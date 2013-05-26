
; ■ arX MusicPlayer の多重起動チェック				_init_xpi.as
; ―――――――――――――――――――――――――――――――――――――

/* 制作メモ ――――――――――――――――――――――――――――――――

 ・この as ファイルについて

	コマンドラインの変換後に多重起動のチェックを行い、
	多重起動していた場合はプラグインとして動作後、終了。

 ―――――――――――――――――――――――――――――――――――― */


; ―――――――――――――――――――――――――――――――――――――
; コマンドラインの変換
; ―――――――――――――――――――――――――――――――――――――

	repeat
	 tmp=cmdline
	 strlen i,tmp
	 if i=0 :break
	 tmp2=""
	 instr i,tmp,"\""
	 if i=-1 {
	  exist_ tmp
	  if stat=1 :tmp2=tmp :break
	 }
	 prm=ps,512,pss,pi
	 strlen prmex,tmp
	 ii=0
	 repeat
	  if ii>=prmex :break
	  strmid s,tmp,ii,1
	  ; (半角スペース) が出たらスキップ
	  if s=" " :ii++ :else {
	   ; " が出たら次の " まで検索
	   if s="\"" {
	    ii++ :instr i,tmp,"\"",ii
	    ; もし次の " が無かったらコマンドラインの終わりまでがパスと判断
	    if i=-1 :i=prmex-ii-1
	    ;  ファイルパスを一つ抜き出す
	    strmid s,tmp,ii,i :tmp2+=s+"\n"
	    ; ファイルパスの長さと「"」の長さを検索開始インデックスに足す
	    ii+=i+2
	   ; それ以外なら次の (半角スペース) まで検索
	   } else {
	    instr i,tmp," ",ii
	    ; もし次の (半角スペース) が無かったらコマンドラインの終わりまでがパスと判断
	    if i=-1 :i=prmex-ii
	    strmid s,tmp,ii,i
	    ; ファイルパスの長さを検索開始インデックスに足す
	    ii+=i
	    ; DOSのファイル名だった場合を考慮してロングパスに変換
	    dllprocp FNC_GetFullPathNameA,prm,4
	    tmp2+=ss+"\n"
	   }
	  }
	 loop
	 break
	loop


; ―――――――――――――――――――――――――――――――――――――
; 多重起動の判断
; ―――――――――――――――――――――――――――――――――――――

	s=fmo_info
	prm=-1,0,4,0,szfmo_info,ps
	dllprocp FNC_CreateFileMappingA,prm,6	:hfmo_info=dllret
	dllprocp FNC_GetLastError,prm,0		:i=dllret
	prm=hfmo_info,2,0,0,0
	dllprocp FNC_MapViewOfFile,prm,5	:pfmo_info=dllret


; ―――――――――――――――――――――――――――――――――――――
; 多重起動時の処理
; ―――――――――――――――――――――――――――――――――――――

	if i=183 {
	 ll_peek4 i,pfmo_info
	 if i!0 {
	  if tmp2="" :end
	  ; ウィンドウメッセージ送信先を取得
	  ll_peek4 prmex,pfmo_info+12
	  ; プレイヤーへのＤ＆Ｄファイル登録
	  ;  (1) 既に起動しているプレイヤー[既]の
	  ;                  プロセスハンドルを取得
	  prm=prmex,pi
	  dllprocp FNC_GetWindowThreadProcessId,prm,2
	  prm=$28,0,i
	  dllprocp FNC_OpenProcess,prm,3
	  prmex.1=dllret
	  ;  (2) ファイルリストを、[既] の funcopts に代入
	  prm=prmex.1,0,ptmp2,bufmax,0
	  ll_peek4 prm.1,pfmo_info+16
	  dllprocp FNC_WriteProcessMemory,prm,5
	  ;  (3) [既] にウィンドウメッセージを送信し、
	  ;                           機能の実行を要請
	  gm_setmessage hwProcess,WM_NOTIFYPI
	  prm=prmex,WM_EXECFUNC,FNC_LIST_ADD|FNC_ON,hwProcess
	  dllprocp FNC_SendMessageA,prm,4
	  i=-1
	  ; (1分でタイムアウト)
	  repeat 600
	   wait 10
	   gm_getmessage msgval
	   if msgval=hwProcess&(msgval.1=WM_NOTIFYPI) {
	    i=msgval.3 :break
	   }
	  loop
	  prm.3=0
	  prm.2=FNC_LIST_REFRESH :dllprocp FNC_SendMessageA,prm,4
	  if i!-1 {
	   i-- :prm.2=FNC_PLAY+i
	   dllprocp FNC_SendMessageA,prm,4	  }
	  ; 終了処理
	  dllprocp FNC_CloseHandle,prmex.1,1
	  prm=hfmo_info,2,0,0,0
	  dllprocp FNC_UnmapViewOfFile,prm,5
	  dllprocp FNC_CloseHandle,prm,1
	  end
	 }
	}


; ―――――――――――――――――――――――――――――――――――――
; 通常時の処理
; ―――――――――――――――――――――――――――――――――――――

	; 機能(FNC_*)のオプション指定に使用する変数の
	;                                  アクセス権を設定
	prm=ptmp,bufmax,$40,pi :dllprocp FNC_VirtualProtect,prm,4
	prm=pfuncopts,bufmax,$40,pi :dllprocp FNC_VirtualProtect,prm,4

	; 基本的なプラグイン向け公開情報を共有メモリに書き込み
	; (その他の情報は _init_var.as で書き込み)
	ll_poke4 vmain,pfmo_info
	ll_poke4 vscript,pfmo_info+4
	ll_poke4 vlanguage,pfmo_info+8
	ll_poke4 hwProcess,pfmo_info+12
	ll_poke4 pfuncopts,pfmo_info+16

	; ウィンドウメッセージ取得の準備
	gm_setmessage hwProcess,WM_EXECFUNC
	gm_setmessage hwProcess,WM_TASKTRAY


; ―――――――――――――――――――――――――――――――――――――
;                                                              (c) arc@arcis
