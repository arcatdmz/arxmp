
; ■ スクリプト
; ―――――――――――――――――――――――――――――――――――――

/* 制作メモ ――――――――――――――――――――――――――――――――

 ・この as ファイルについて

	スクリプト(arXmp用独自言語)の実行処理を行う

 ―――――――――――――――――――――――――――――――――――― */


; ―――――――――――――――――――――――――――――――――――――
; スクリプトの実行
;	使用値	script		スクリプト
;		scrLine		スクリプトの行数
; ―――――――――――――――――――――――――――――――――――――

	*exec_script
	redraw 2
	repeat
	 await
	 notecut_ s,script
	 ; 改行コードが見つからない
	 ; (不正なスクリプト？)
	 if stat=0 {
	  scrLine=1
	  if im>1024 {		; サイズが異常→不正―と断定
	   scrLine=0 :break
	  }
	  s=script :script=""	; 一応命令として実行してみる
	 }
	 ; 命令を一行ぶん実行
	 gosub *exec_scriptline
	 scrLine--
	 if scrLine<=0 :break
	loop
	redraw 1
	return


; ―――――――――――――――――――――――――――――――――――――
; 命令の実行
;	使用値	s		命令
;	返り値	scrRet		結果
; ―――――――――――――――――――――――――――――――――――――

	*exec_scriptline
	; 特殊キーワードの置換
	i=0
	strlen prm.36,s			; prm.36 命令全体の長さ
	repeat
	 ; キーワード開始のしるし
	 instr ii,s,"%",i
	 if ii=-1 :break
	 ; キーワード終了のしるし
	 i+=ii+1			; i   キーワード開始位置
	 instr ii,s,"%",i		; ii  キーワード長
	 if ii=0 :sss="" :else {
	  strmid sss,s,i,ii
	  peek prm,sss,0		; (prm キーワードの種類)
	  strmid ss,sss,-1,ii-2		; (ss  キーワードの詳細)
	  repeat
	   if prm='p' :gosub get_minfo :break
	   if prm='o' {
	    prm.2=i,ii			; i,ii	退避
	    gosub get_objid
	    sss=""+i
	    i=prm.2 :ii=prm.3		; i,ii	戻す
	    break
	   }
	   if prm='f' {
	    ; 以下 v.403.00～
	    prm.2=ii			; ii	退避
	    gosub get_objfunc
	    sss=""+ii
	    ii=prm.2			; ii	戻す
	    break
	   }
	   if prm='s' {
	    if ss="user" :sss=user :break
	    if ss="dir" :sss=exedir :break
	    if ss="titl" :sss=prgtitles :break
	    if ss="col" :sss=""+SysColor+"*"+SysColor.1+"*"+SysColor.2 :break
	    if ss="cols" :sss=""+SysColor2+"*"+SysColor2.1+"*"+SysColor2.2 :break
	    if ss="repmode" :get_langPMEX sss,lMode :break
	    ; 以下 v.403.00～
	    strmid tmp,ss,0,4
	    strmid ss,ss,5,ii-5
	    if tmp="scrl" {
	     gosub get_scrlpos
	     if ss="x" :sss=""+prm :break
	     if ss="y" :sss=""+prm.1 :break
	     if ss="pos" :sss=""+prm+"*"+prm.1 :break
	     break
	    }
	    if tmp="seek" {
	     if ss="x" :sss=""+sSeekX :break
	     if ss="y" :sss=""+sSeekY :break
	     if ss="pos" :sss=""+sSeekX+"*"+sSeekY :break
	     gosub get_seekrect
	     if ss="ex" :sss=""+prm.2 :break
	     if ss="ey" :sss=""+prm.3 :break
	     if ss="epos" :sss=""+prm.2+"*"+prm.3 :break
	     if ss="rect" :sss=""+prm+"*"+prm.1+"*"+prm.2+"*"+prm.3 :break
	     if ss="width" :im=prm.2-prm :sss=""+im :break
	     if ss="height" :im=prm.3-prm.1 :sss=""+im :break
	     if ss="size" :im=prm.2-prm,prm.3-prm.1 :sss=""+im+"*"+im.1 :break
	     break
	    }
	    break
	   }
	   if prm='v' {
	    int_ ss
	    if im>=0&(im<snVar) :sss=sVar.im
	    break
	   }
	   if prm='d' {
	    int_ ss
	    if im>=0&(im<nlangs) :sss=langs.im
	    break
	   }
	   break
	  loop
	 }
	 strlen iii,sss			; iii 置換文字列長
	 ; 置換
	 strmid ss,s,0,i-1		; ss キーワード前
	 strmid s,s,-1,prm.36-i-ii-1	; s  キーワード後
	 s=ss+sss+s
	 ; 情報の更新
	 prm.36+=iii-ii-2
	 i--
	loop
	; 命令内容の切り分け
	strmid scrfunc,s,0,3
	if scrfunc=".::" :return
	if scrfunc=":::" :return
	strlen i,s
	instr ii,s,"=",0
	if i=7|(ii=7) :strmid scrfunc.1,s,3,4 :else :scrfunc.1=""
	if ii!-1 {
	 strmid s,s,-1,i-ii-1
	 strgetprm scrprms,s
	} else {
	 s=""
	 scrprms="","","","","","","","","","","","","","","",""
	}

; ―――――――――――――――――――――――――――――――――――――
; 特殊命令

	if scrfunc="!!!" {
	 if scrfunc.1="init" {
	  if scrprms="xsp" {
	   ; 再生リストの表示を更新
	   func=FNC_LIST_REFRESH :gosub *exec_func
	   ; チェックボックスやメニューのチェックを更新
	   func=FNC_SET_SEARCH|FNC_REFRESH			:gosub *exec_func
	   func=FNC_MODE|FNC_REFRESH				:gosub *exec_func
	   func=FNC_MODE|FNC_REFRESH+PM_REPLIST			:gosub *exec_func
	   func=FNC_SET|FNC_REFRESH+IDX_SET_LIST_CLEARONLOAD	:gosub *exec_func
	   func=FNC_SET|FNC_REFRESH+IDX_SET_LIST_DOWNDBLITEM	:gosub *exec_func
	   func=FNC_SET|FNC_REFRESH+IDX_SET_PLAY_REPLAY		:gosub *exec_func
	   func=FNC_SET|FNC_REFRESH+IDX_SET_DISP_TRAYICON	:gosub *exec_func
	   func=FNC_SET|FNC_REFRESH+IDX_SET_DISP_TIPHELP	:gosub *exec_func
	   func=FNC_SET|FNC_REFRESH+IDX_SET_DISP_TASKBAR	:gosub *exec_func
	   func=FNC_SET|FNC_REFRESH+IDX_SET_DISP_ONTOP		:gosub *exec_func
	   func=FNC_LOADLIB|FNC_REFRESH+IDX_LOAD_MP3INFP	:gosub *exec_func
	   ; プレイヤー起動後初めてスキンの読み込みが完了したときの処理
	   if dispMainWnd&initializing {
	    title langs.lgWelcome+sep+prgtitles :dispTitle=0
	    dispMainWnd=dispMainWnd^initializing
	   }
	   if mStatus!ST_CLOSED {
	    scrLine+=scrAreaShow_FileInfoLine
	    script=scrAreaShow_FileInfo+script
	   }
	   repeat snChk
	    chk_.cnt=chk.cnt
	   loop
	   return
	  }
	 }
	}

; ―――――――――――――――――――――――――――――――――――――
; スキン用命令

	; 色の設定
	if scrfunc="col" {
	 strcnvprm prm,scrprms,0,3
	 color prm,prm.1,prm.2
	 return
	}

	; 位置の設定
	if scrfunc="pos" {
	 strcnvprm prm,scrprms,0,2
	 pos prm,prm.1
	 return
	}

	; 画像処理
	if scrfunc="img" {
	 ; 読み込み
	 if scrfunc.1="load" {
	  existex scrprms
	  if stat {
	   gosub gsel_widBuffer
	   strcnvprm prm,scrprms,1,2
	   picload scrprms,1,prm,prm.1
	   gsel sWid
	  }
	  return
	 }
	 strcnvprm prm,scrprms,0,6
	 ; 描画モード変更
	 if scrfunc.1="mode" :gmode prm,,,prm.1 :return
	 ; 描画(バッファ→メイン画面)
	 if scrfunc.1="draw" {
	  if wi.widBuffer {
	   gcopy widBuffer,prm,prm.1,prm.2,prm.3
	  }
	  return
	 }
	 ; 描画(メイン画面→バッファ)
	 ; 正式な仕様公開は ver.403.00～
	 if scrfunc.1="xdrw" {
	  gosub gsel_widBuffer
	  pos prm.4,prm.5
	  gcopy sWid,prm,prm.1,prm.2,prm.3
	  gsel sWid
	  return
	 }
	 return
	}

	; 文字列表示
	if scrfunc="mes" {
	 ; 表示フォントの変更
	 if scrfunc.1="font" {
	  strcnvprm prm,scrprms,1,2
	  font scrprms,prm,prm.1
	  return
	 }
	 ; 表示
	 ;  (1) 表示文字列取得
	 ;		sss	表示文字列
	 ;		ss	寄せオプション
	 if scrfunc.1="" {
	  sss=scrprms
	  ss=scrprms.1
	 } else {
	  if scrfunc.1="scrl" {
	   gosub get_scrlpos
	   pos prm,prm.1
	   sss=mScroll
	  } else :ss=scrfunc.1 :gosub get_minfo
	  ss=scrprms
	 }
	 ;  (2) 実際に表示
	 ;	通常表示(左寄せ)
	 if ss="" :mes sss :else {
	  ;	自動改行
	  if ss="box" {
	   strcnvprm prm,scrprms,2,2
	   prm.4=prm,prm.1
	   s=""
	   i=0 :ii=0
	   prm=bmscr.4,pss,0,pprmex
	   strlen prm.6,sss
	   repeat prm.6
	    ; 文字取得
	    peek iii,sss,i
	    dllprocp FNC_IsDBCSLeadByte,iii,1
	    dllret++
	    strmid ss,sss,i,dllret
	    i+=dllret
	    ; 文字横長取得
	    prm.2=dllret
	    dllprocp FNC_GetTextExtentPoint32A,prm,4
	    ii+=prmex
	    ; 横幅判定
	    if ii>prm.4 {
	     mes s :s=""
	     ii=prmex
	     pos csrx,csry+prm.5
	    }
	    s+=ss
	    ; 文字長判定
	    if i>=prm.6 :break
	   loop
	   mes s
	   return
	  ;	寄せオプション付き表示
	  } else {
	   prm=bmscr.4,psss,0,pprmex
	   strlen prm.2,sss
	   dllprocp FNC_GetTextExtentPoint32A,prm,4
	   prm=csrx,csry+prmex.1
	   ;	(右寄せ)
	   if ss="right" :pos csrx-prmex,csry :else {
	    ;	(中央寄せ)
	    if ss="center" :pos csrx-(prmex/2),csry
	   }
	   mes sss
	   pos prm,prm.1
	  }
	 }
	 return
	}

	; 図形
	if scrfunc="drw" {
	 if scrfunc.1="line" :strcnvprm prm,scrprms,0,4 :line prm.0,prm.1,prm.2,prm.3 :else {
	  prm=-1,-1,-1,-1
	  if scrfunc.1="boxs" {
	   gosub get_seekrect
	  } else :if scrfunc.1="boxf" :strcnvprm prm,scrprms,0,4
	  boxf prm.0,prm.1,prm.2,prm.3
	 }
	 return
	}

	; ウィンドウ
	if scrfunc="win" {
	 if scrfunc.1="regi" :regmake :return
	 strcnvprm prm,scrprms,0,2
	 if scrfunc.1="size" :width prm,prm.1 :return
	 if scrfunc.1="widt" :width prm, :return
	 if scrfunc.1="heig" :width ,prm :return
	 if scrfunc.1="posi" :width ,,prm,prm.1 :return
	 return
	}

	; オブジェクト
	if scrfunc="obj" {
	 ; サイズの指定
	 if scrfunc.1="size" :strcnvprm prm,scrprms,0,2 :objsize prm,prm.1 :return
	 ; 設置
	 if scrfunc.1="xset" {
	  if snObj>=objmax :return	; 設置数の限界を確認
	  ss=scrprms
	  gosub get_objfunc
	  if ii=0 :return
	  i=snObj
	  obj.i=ii
	  ; (1) チェックボックス
	  if obj.i&OBJ_CHKBOX {
	   if snChk>=chkmax :return	; 設置数の限界を確認
	   ii=snChk
	   chkid.ii=i
	   chkbox scrprms.1,chk.ii
	   snChk++
	   i+=41
	  } else {
	   ; (2) 再生リスト
	   if obj.i>>28&$F>=$E {
	    repeat 1
	     if hwList :i=0 :break
	     prm=lSelectedIdx
	     if obj.i=FNC_PLAYLIST :listbox lSelectedIdx,0,"" :sList=0 :else {
	      if obj.i=FNC_PLAYLISTC :combox lSelectedIdx,120,"" :sList=1 :else :i=0 :break
	     }
	     lSelectedIdx=prm
	     i+=41 :hwList=bmscr.i
	     ; メッセージ取得設定
	     gm_setwndproc hwList
	     gm_setmessage hwList,WM_LBUTTONDBLCLK	; ダブルクリックの取得
	     gm_setmessage hwList,WM_KEYUP		; [Delete] キー押下の取得
	    loop
	   ; (3) ボタン
	   } else :button scrprms.1,*btn :i+=41
	  }
	  ; i	/ オブジェクトID+41
	  ;	  (設置に失敗したら 0 )
	  if i {
	   ; ユーザー定義イベントとの関連付け
	   if scrprms.2!"" {
	    ; メッセージ取得設定
	    int_ scrprms.2
	    i-=41 :obj.i.2=im :i+=41
	    i=bmscr.i
	    gm_setwndproc i
	    gm_setmessage i,WM_MOUSEMOVE	; マウスがボタンに乗った
	    gm_setmessage i,WM_MOUSELEAVE	; 　　　〃　　　から離れた
	   }
	   snObj++
	  }
	  return
	 }
	 strmid s,scrprms,0,4
	 if s="Obj." {
	  strlen i,scrprms
	  strmid ss,scrprms,4,i-4
	  gosub get_objid
	 } else :int_ scrprms :i=im
	 ; チップヘルプの設定
	 if scrfunc.1="help" :tiphelp scrprms.1,i :return
	 strcnvprm prm,scrprms,1,4
	 ; 大きさと位置の変更
	 if scrfunc.1="resz" :objresize prm,prm.1,i :return
	 if scrfunc.1="reps" :objrepos prm,prm.1,i :return
	 ; 画像を貼り付け
	 if scrfunc.1="pimg" {
	  ;	i	/ オブジェクトID
	  ;	prm	/ 転送元Ｘ座標,Ｙ座標,幅,高さ
	  ; 貼り付けの準備
	  ;  (1) ビットマップオブジェクトを作成
	  ;		(以前作成した分があったらまず削除)
	  if obj.i.1 :dllprocp FNC_DeleteObject,obj.i.1,1
	  prmex=bmscr.4,prm.2,prm.3
	  dllprocp FNC_CreateCompatibleBitmap,prmex,3
	  obj.i.1=dllret
	  ;  (2) ↑を操作するためのデバイスコンテキストを作成
	  dllprocp FNC_CreateCompatibleDC,bmscr.4,1
	  iii=dllret
	  ;  (3) 転送元から画像をコピー
	  prmex=iii,obj.i.1
	  dllprocp FNC_SelectObject,prmex,2
	  prmex.1=0,0,prm.2,prm.3,bmscr.4,prm,prm.1,$CC0020
	  dllprocp FNC_BitBlt,prmex,9
	  ; 貼り付け
	  ;  (1) 貼り付け先ボタンのスタイルを変更
	  ii=i+41
	  prmex=bmscr.ii,-16,$50000080
	  dllprocp FNC_SetWindowLongA,prmex,3
	  ;  (2)
	  prmex=bmscr.ii,$F7,0,obj.i.1
	  dllprocp FNC_SendMessageA,prmex,4
	  ; 後始末
	  dllprocp FNC_DeleteDC,iii,1
	  return
	 }
	 ; スタイルの設定
	 if scrfunc.1="styl" :btnable i,prm :return
	 return
	}

; ―――――――――――――――――――――――――――――――――――――
; プラグイン用命令

	if scrfunc="exe" {
	 if scrfunc.1="func" {
	  int_ scrprms
	  func=im
	  funcopts=scrprms.1
	  if funcopts!"" :func=func|FNC_STR
	  gosub *exec_func
	  return
	 }
	}

	return


; ―――――――――――――――――――――――――――――――――――――
;                                                              (c) arc@arcis
