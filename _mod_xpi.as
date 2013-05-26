
; ■ arX MusicPlayer プラグイン作成用モジュール			   xpimod.as
; ―――――――――――――――――――――――――――――――――――――

/* 制作メモ ――――――――――――――――――――――――――――――――

 ・この as ファイルについて

	HSP ver.2.61 で利用できます。
	hsgetmsg.dll が別途必要となります。

	llmod.as を併用する場合は、

		#include "llmod.as"
		#include "_mod_xpi.as"

	のような順にしてください。

 ―――――――――――――――――――――――――――――――――――― */


; ―――――――――――――――――――――――――――――――――――――
; 使用する Win32API の準備
; ―――――――――――――――――――――――――――――――――――――

	ll_libload XD_USER,"user32"
	ll_libload XD_KERNEL,"kernel32"
	ll_retset dllret
	#const funcs					10
	; user32.dll
	#const global FNC_SendMessageA			0
	#const global FNC_GetWindowThreadProcessId	1
	; kernel32.dll
	#const global FNC_MapViewOfFile			2
	#const global FNC_UnmapViewOfFile		3
	#const global FNC_CreateFileMappingA		4
	#const global FNC_CloseHandle			5
	#const global FNC_GetLastError			6
	#const global FNC_OpenProcess			7
	#const global FNC_ReadProcessMemory		8
	#const global FNC_WriteProcessMemory		9
	dim pfunc,funcs
	;   user32.dll
	ll_getproc pfunc.FNC_SendMessageA		,"SendMessageA"			,XD_USER
	ll_getproc pfunc.FNC_GetWindowThreadProcessId	,"GetWindowThreadProcessId"	,XD_USER
	;   kernel32.dll
	ll_getproc pfunc.FNC_MapViewOfFile		,"MapViewOfFile"		,XD_KERNEL
	ll_getproc pfunc.FNC_UnmapViewOfFile		,"UnmapViewOfFile"		,XD_KERNEL
	ll_getproc pfunc.FNC_CreateFileMappingA		,"CreateFileMappingA"		,XD_KERNEL
	ll_getproc pfunc.FNC_CloseHandle		,"CloseHandle"			,XD_KERNEL
	ll_getproc pfunc.FNC_GetLastError		,"GetLastError"			,XD_KERNEL
	ll_getproc pfunc.FNC_OpenProcess		,"OpenProcess"			,XD_KERNEL
	ll_getproc pfunc.FNC_ReadProcessMemory		,"ReadProcessMemory"		,XD_KERNEL
	ll_getproc pfunc.FNC_WriteProcessMemory		,"WriteProcessMemory"		,XD_KERNEL


; ―――――――――――――――――――――――――――――――――――――
; 定義
; ―――――――――――――――――――――――――――――――――――――

	; ウィンドウメッセージ
	#const global WM_NOTIFYPI	$550
	#const global WM_EXECFUNC	$550
	#const global NP_FR		0	; プラグインへの結果通知
	#const global NP_ST		1	; プラグインへの再生状態変更通知

	; 機能番号関連
	#const global FNC_IDLECHK	$00000000
	#const global FR_DONE		$00000000
	#const global FR_ERR		$0F000000
	#const global FR_IDLE		$0F000001

	; 共有メモリ領域関連
	#define global fmo_info	"arxmp_info"
	#const global szfmo_info	160	; 全情報サイズ
	#const global szfmo_send	32	; ハンドル情報のサイズ
	#const global nfmo_send		2	; 　　〃　　　　種類数
	#const global fi_p		32	; ポインタ情報(1)
	#const global fi_p_		64	; 　　〃　　　(2)
	#const global fi_send		96	; ハンドル情報
	#const global fi_send_mStatus	96	;  再生状況を通知するウィンドウ
	#const global fi_send_onexit	128	;  終了時に連動させるウィンドウ

	; プレイヤー情報読み込み用
	;  数値型
	#const afi_p		fi_p/4
	#ifndef X_DEFEX
	#const nminfo		13
	#const nsinfo		23
	#const nhmenu		23
	#const ntype		TP_PLAYABLE
	#endif
	#const pminfo		afi_p
	#const psinfo		afi_p+1
	#const phmenu		afi_p+2
	#const ptype		afi_p+3
	;  文字列型
	#const afi_p_		fi_p_/4
	#ifndef X_DEFEX
	#const nminfo_		9
	#const nsinfo_		5
	#const nlangs		72
	#const ntypes		TP_PLAYABLE
	#const ndir		5
	#const szminfo_		512
	#const szsinfo_		512
	#const szlangs		256
	#const sztypes		256
	#const szdir		512
	#endif
	#const plist		afi_p_
	#const pminfo_		afi_p_+1
	#const psinfo_		afi_p_+2
	#const plangs		afi_p_+3
	#const ptypes		afi_p_+4
	#const pdir		afi_p_+5


; ―――――――――――――――――――――――――――――――――――――
; 命令の拡張
; ―――――――――――――――――――――――――――――――――――――

	#ifndef gm_setwndproc
		#uselib "hsgetmsg.dll"
		#func gm_setwndproc	gm_setwndproc	$202
		#func gm_setmessage	gm_setmessage	$202
		#func gm_getmessage	gm_getmessage	$202
		;dim msgval,16
	#endif

	#module "xpimod"
	; ―――――――――――――――――――――――――――――――――
	; 汎用

	; dllproc モドキ
	#define global dllprocp(%1,%2,%3=0) ll_callfunc %2,%3,pfunc@.%1

	; 本家 getptr 互換
	#ifndef getptr
	#deffunc getptr val,val
	mref vptr,16 :mref pval,1025
	if pval&$FFFF=2 :mref var,25 :else :mref var,17
	ll_getptr var :vptr=dllret@
	return
	#endif

	; ―――――――――――――――――――――――――――――――――
	; プラグイン関連

	; プレイヤーの起動確認
	;	xpi_connect p1,p2
	;		p1	/	プレイヤーの再生状況が変わったとき
	;				　通知を受け取る(1)か否(0 or 略)か
	;		p2	/	プレイヤーの終了時、連動して終了さ
	;				　　　　　　れる(0 or 略)か否(1)か
	;	返り値	stat	/	0	プレイヤーが起動していない
	;				(他)	プレイヤーが起動している
	;				 └プレイヤーのバージョン番号
	#deffunc xpi_connect int,int
	if hfmo_info=0 {
	 string=fmo_info
	 prm=-1,0,4,0,szfmo_info,pstring
	 dllprocp FNC_CreateFileMappingA,prm,6	:hfmo_info=dllret@
	 dllprocp FNC_GetLastError,prm,0
	 ; 起動していない
	 if dllret@!183 {
	  dllprocp FNC_CloseHandle,hfmo_info,1
	  hfmo_info=0 :stt=0 :return
	 }
	 ; 起動している
	 prm=hfmo_info,2,0,0,0
	 dllprocp FNC_MapViewOfFile,prm,5
	 pfmo_info=dllret@
	}
	;	プレイヤー情報の取得
	repeat szfmo_info/4
	 ll_peek4 ai@.cnt,cnt*4+pfmo_info
	loop
	if ai@=0 :stt=ai@ :return
	;	プレイヤーのウィンドウハンドルを取得
	arxmp_hwnd=ai@.3
	;	プレイヤーのプロセスIDを取得
	if ai@!0&(arxmp_pid=0) {
	 prm=ai@.3,pi
	 dllprocp FNC_GetWindowThreadProcessId,prm,2
	 arxmp_pid=i
	}
	;	プラグインとしての動作オプションを設定
	;	(音楽の再生状況が変わったときに通知を受ける？)
	mref _fi_send_mStatus
	i=0
	repeat szfmo_send/4,fi_send_mStatus/4
	 if ai@.cnt=xpi_hwnd {
	  if _fi_send_mStatus :i=0 :break
	  ll_poke4 0,cnt*4+pfmo_info
	 }
	 if ai@.cnt=0&_fi_send_mStatus :i=cnt :break
	loop
	if i {
	 ai@.i=xpi_hwnd
	 ll_poke4 xpi_hwnd,i*4+pfmo_info
	}
	;	(プレイヤーの終了時に連動して終了処理に移る？)
	mref _fi_send_onexit,1
	i=0
	repeat szfmo_send/4,fi_send_onexit/4
	 if ai@.cnt=xpi_hwnd {
	  if _fi_send_onexit :i=0 :break
	  ll_poke4 0,cnt*4+pfmo_info
	 }
	 if ai@.cnt=0&_fi_send_onexit :i=cnt :break
	loop
	if i {
	 ai@.i=xpi_hwnd
	 ll_poke4 xpi_hwnd,i*4+pfmo_info
	}
	;	バージョン番号を返す
	stt=ai@ :return
	return

	; プレイヤーの機能を実行する
	;	xpi_func p1
	;		p1	/	機能番号
	;		p2	/	タイムアウト(秒単位, 0 だと永久に待つ)
	;	返り値	stat	/	-1	タイムアウト
	;				FR_ERR	機能実行中にエラー
	;				FR_OK	機能実行が正常に完了
	;				(他)	機能一覧の解説を参照
	#deffunc xpi_func int,int
	mref f :mref i,1
	prm=arxmp_hwnd,WM_EXECFUNC,f,xpi_hwnd
	dllprocp FNC_SendMessageA,prm,4
	i=i*10+(i=0*1)
	repeat i
	 gm_getmessage@ prm
	 if prm=xpi_hwnd&(prm.1=WM_NOTIFYPI)&(prm.2=NP_FR) {
	  if prm.3!FR_IDLE|(f=FNC_IDLECHK) :stt=prm.3 :break
	 }
	 wait 10
	 if i=1 :continue 0
	loop
	if prm!xpi_hwnd|(prm.1!WM_NOTIFYPI) :stt=-1
	return

	; プレイヤーのデータを取得
	;	xpi_peek p1,p2,p3
	;		p1	/	読み出し先変数
	;		p2	/	読み出し元ポインタ
	;		p3	/	読み出すサイズ
	#deffunc xpi_peek val,int,int
	if arxmp_pid=0 :return
	mref p,1
	mref sz,2
	mref pval,1024
	if pval&$FFFF=2 {
	 mref data,24
	} else {
	 mref data,16
	}
	prm=$10,0,arxmp_pid
	dllprocp FNC_OpenProcess,prm,3
	prm=dllret@,p,0,sz,0
	getptr prm.2,data
	dllprocp FNC_ReadProcessMemory,prm,5
	dllprocp FNC_CloseHandle,prm,1
	return

	; プレイヤーのデータを変更
	;	xpi_poke p1,p2,p3
	;		p1	/	書き込む内容の入った変数
	;		p2	/	書き込み先ポインタ
	;		p3	/	書き込むサイズ
	#deffunc xpi_poke val,int,int
	if arxmp_pid=0 :return
	mref p,1
	mref sz,2
	mref pval,1024
	if pval&$FFFF=2 {
	 mref data,24
	 if sz=0 :strlen sz,data :sz++
	} else {
	 mref data,16
	 if sz=0 :sz=4
	}
	prm=$28,0,arxmp_pid
	dllprocp FNC_OpenProcess,prm,3
	prm=dllret@,p,0,sz,0
	getptr prm.2,data
	dllprocp FNC_WriteProcessMemory,prm,5
	dllprocp FNC_CloseHandle,prm,1
	return

	; プレイヤーとのメモリ共有を解除
	;	xpi_disconnect
	#deffunc xpi_disconnect onexit
	if hfmo_info {
	 repeat szfmo_send/4*nfmo_send,fi_send/4
	  prm=cnt*4+pfmo_info
	  ll_peek4 i,prm
	  if i=xpi_hwnd :ll_poke4 0,prm
	 loop
	 prm=hfmo_info,2,0,0,0
	 dllprocp FNC_UnmapViewOfFile,prm,5
	 dllprocp FNC_CloseHandle,hfmo_info,1
	 hfmo_info=0
	}
	return

	#global

	; プレイヤーの機能の文字列オプションを設定
	;	xpi_opt p1
	;		p1	/	機能の文字列オプション
	#define xpi_opt(%1) xpi_poke %1,ai.4

	; プレイヤーの再生リストにファイルなどを追加
	;	xpi_list_add p1,p2
	;		p1	/	ファイルリスト
	;		p2	/	ファイル種フィルタON(1),OFF(0)
	#define xpi_list_add(%1,%2=1) xpi_poke %1,ai.5 :xpi_func FNC_LIST_ADD+(FNC_ON*%2) :xpi_func FNC_LIST_REFRESH


; ―――――――――――――――――――――――――――――――――――――
; その他の準備
; ―――――――――――――――――――――――――――――――――――――

	mref ref@xpimod,65
	mref stt@xpimod,64
	mref bmscr@xpimod,67

	; dim hfmo_info@xpimod
	; dim pfmo_info@xpimod
	; dim _fi_send_mStatus@xpimod
	dim ai,szfmo_info/4

	sdim string@xpimod,512
	sdim string2@xpimod,1024
	; dim pstring@xpimod
	; dim pstring2@xpimod
	getptr pstring@xpimod,string@xpimod
	getptr pstring2@xpimod,string2@xpimod	
	; dim i@xpimod
	getptr pi@xpimod,i@xpimod

	xpi_hwnd@xpimod=bmscr@xpimod.13
	gm_setwndproc xpi_hwnd@xpimod
	gm_setmessage xpi_hwnd@xpimod,WM_NOTIFYPI


; ―――――――――――――――――――――――――――――――――――――
;                                                              (c) arc@arcis
