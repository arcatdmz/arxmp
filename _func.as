
; ■ arX MusicPlayer の機能
; ―――――――――――――――――――――――――――――――――――――

/* 制作メモ ――――――――――――――――――――――――――――――――

 ・既知の問題

	リストウィンドウのメニューバーからメニュー項目をクリックすると
	*btn_ListWnd に飛んだり、 HSP Error が出た後強制終了する

		-> メニューバーの項目に指定するメニューIDが $4000 を超えると
		　 HSP がメニュー項目のクリックを ウィンドウ内のボタンクリッ
		　 クと勘違いすることがあるため。
		　 メニューIDを 小さな値にして解決。

 ・この as ファイルについて

	ラベル一覧
	*btn_*		ウィンドウ内ボタンが押された際の処理
	*exec_func	プレイヤーの機能を実行する処理

 ―――――――――――――――――――――――――――――――――――― */


; ―――――――――――――――――――――――――――――――――――――
; ボタン機能の実行
;	使用値	stat		ボタンのオブジェクトID
; ―――――――――――――――――――――――――――――――――――――

; ―――――――――――――――――――――――――――――――――――――
; メイン画面のボタン
*btn
	func=obj.stat
	#ifdef DEBUG
	addlog "BTN main (id="+stat+")"
	#endif
	gosub *exec_func :goto *main


; ―――――――――――――――――――――――――――――――――――――
; リスト画面のボタン
*btn_ListWnd
	repeat
	 ; [↑] [↓]
	 if stat=0 :func=FNC_LIST_UP|FNC_AUTO+IDX_SEL :break
	 if stat=1 :func=FNC_LIST_DOWN|FNC_AUTO+IDX_SEL :break
	 ; [D] [R] [C]
	 if stat=2 :func=FNC_LIST_DELETE|FNC_AUTO+IDX_SEL :break
	 if stat=3 :func=FNC_LIST_RENAME|FNC_AUTO+IDX_SEL :break
	 if stat=4 :func=FNC_LIST_CLEAR|FNC_ALL :break
	 ; [選択中の項目を消去]
	 if stat=6 :func=FNC_LIST_CLEAR|FNC_AUTO+IDX_SEL :break
	 ; [リストを保存] [〃読込]
	 if stat=7 :func=FNC_XLT_SAVE :break
	 if stat=8 :func=FNC_XLT_LOAD :break
	 ; [閉じる]
	 if stat=9 :func=FNC_OPEN_WND|FNC_OFF+widList :break
	 func=0 :break
	loop
	#ifdef DEBUG
	addlog "BTN list (id="+stat+")"
	#endif
	gosub *exec_func :goto *main

; ―――――――――――――――――――――――――――――――――――――
; 情報画面のボタン
*btn_InfoWnd
	if dispInfoWnd&IDX_WND_INPUT {
	 ; [参照]
	 if stat=15 {
	  dialog "bmp;*.jpg",16,"画像ファイル"
	  if stat=0 :stop
	  funcopts=refstr
	  gsel widInfo
	  objprm 13,funcopts
	  gsel sWid
	  stop
	 }
	 ; [キャンセル]
	 if stat=17 {
	  funcopts=""
	 ; [O K]
	 } else {
	  if dispInfoWnd&IDX_WND_SKV {
	   ; リストから内容を選ぶ型のスキン変数
	   i=sEditingIdx
	   if sVar_type.i=SV_LIST {
	    if funcopt=-1 :funcopt=0
	    notesel sVar_list.i
	    noteget funcopts,funcopt
	   }
	   if funcopts="" :funcopts="(null)"
	  }
	 }
	 #ifdef DEBUG
	 funclv--
	 #endif
	 func=FNC_OPEN_WND|FNC_OFF+widInfo :goto *exec_func
	}
	repeat
	 ; [プロパティを表示]
	 if stat=10 :func=FNC_OPEN_PROPERTY|FNC_AUTO+IDX_CUR :break
	 ; [情報を更新]
	 if stat=11 :func=FNC_OPEN_WND|FNC_ON|FNC_REFRESH+widInfo+IDX_WND_MINFO :break
	 ; [閉じる] [キャンセル]
	 if stat=12 :func=FNC_OPEN_WND|FNC_OFF+widInfo :break
	 func=0 :break
	loop
	#ifdef DEBUG
	addlog "BTN info (id="+stat+")"
	#endif
	gosub *exec_func :goto *main


; ―――――――――――――――――――――――――――――――――――――
; 機能の実行
;	使用値	func		機能番号
;		funcopts	文字列オプション
;	返り値	funcret		結果
; ―――――――――――――――――――――――――――――――――――――

*exec_func

	repeat 2
	 funcid    = func&$FF000000
	 funcopt   = func&$0000FFFF
	 ; 例外的な値を機能番号に変換
	 if funcid=0 {
	  ; (1) メニューバーのメニュー項目ID
	  if func>=FNCM {
	   #ifdef DEBUG
	   addlog "CNV (menuid="+func+")"
	   #endif
	   repeat
	    if func<FNCM_SET_SEARCH {
	     func=FNC_SET|FNC_AUTO+(func-FNCM_SET)
	     break
	    }
	    if func<FNCM_SET_SEARCHEX {
	     func=FNC_SET_SEARCH|FNC_AUTO+TPEXfromTP(func-FNCM_SET_SEARCH)
	     break
	    }
	    if func<FNCM_XPI_LOAD {
	     func=FNC_SET_SEARCH|FNC_AUTO|FNC_ALL
	     break
	    }
	    if func<FNCM_LOADLIB {
	     func=FNC_XPI_LOAD|FNC_AUTO+(func-FNCM_XPI_LOAD)
	     break
	    }
	    if func<FNCM_XLT_LOAD {
	     func=FNC_LOADLIB|FNC_AUTO+(func-FNCM_LOADLIB)
	     break
	    }
	    if func<FNCM_XLT_LOADEX {
	     func=FNC_XLT_LOAD|FNC_AUTO+(func-FNCM_XLT_LOAD)
	     break
	    }
	    if func<FNCM_XLT_SAVE {
	     func=FNC_XLT_LOAD|FNC_AUTO|FNC_REFRESH
	     break
	    }
	    if func<FNCM_XLT_SAVEEX {
	     func=FNC_XLT_SAVE|FNC_AUTO+(func-FNCM_XLT_SAVE)
	     break
	    }
	    func=FNC_XLT_SAVE|FNC_AUTO|FNC_ON
	    break
	   loop
	  ; (2) 旧版の機能番号
	  } else {
	   #ifdef DEBUG
	   addlog "CNV (funcid="+func+")"
	   #endif
	   i=func&$FFF-FNC_OBJ402
	   if i>=0&(i<objs) :func=obj_func.i
	  }
	 } else :break
	loop

	#ifdef DEBUG
	func_.funclv=func :funclv++
	#define	return_(%1=funcret) funcret=%1 :funclv-- :gosub *addlogfnc :return
	#else
	#define return_(%1=funcret) funcret=%1 :return
	#endif

; ―――――――――――――――――――――――――――――――――――――
; ウィンドウを開く/隠す
;	注意	tmp の内容を破壊しない(FNC_XSP_LOAD 用の配慮)

	if funcid=FNC_OPEN_WND {
	 ; (1) メイン画面(→プレイヤー終了)
	 if funcopt=widMain|(funcopt=widRegion) :goto *exit
	 ; (2) リスト画面
	 if funcopt=widList {
	  ; 初めてリスト画面を表示する場合
	  if wi.widList=0 {
	   ; ウィンドウの初期化
	   bgscr widList,dispx,dispy,2,ListWndX,ListWndY
	   title "リストウィンドウ"+sep+prgtitles
	   mref bmscrl,67
	   hwListWnd=bmscrl.13
	   prm=hwListWnd,-16,$CC0000 :dllprocp FNC_SetWindowLongA,prm,3
	   ; メニューの設定
	   dllproc "CreateMenu",prm,0,D_USER
	   hmBar=dllret
	   prm=hwListWnd,hmBar
	   dllproc "SetMenu",prm,2,D_USER
	   imenu "再生リスト(&L)",0,hmList,hmBar
	   imenu "設定(&C)",0,hmSet,hmBar
	   dllproc "DrawMenuBar",hwListWnd,1,D_USER
	   ; ウィンドウの大きさを調整
	   prm=15 :dllprocp FNC_GetSystemMetrics,prm,1 :ListWndHeight+=dllret
	   prm=4  :dllprocp FNC_GetSystemMetrics,prm,1 :ListWndHeight+=dllret
	   prm=32 :dllprocp FNC_GetSystemMetrics,prm,1 :ListWndWidth +=dllret*2
	   prm=33 :dllprocp FNC_GetSystemMetrics,prm,1 :ListWndHeight+=dllret*2
	   width ListWndWidth,ListWndHeight
	   ListWndWidth=winx
	   ListWndHeight=winy
	   ; オブジェクトの整備
	   font "ＭＳ ゴシック",12
	   objmode 2,1
	   boxf_ 0,0,dispx,dispy,hSysBrush
	   objsize 18,32
	   pos 0,0
	   button "↑",*btn_ListWnd
	   button "↓",*btn_ListWnd
	   button "D",*btn_ListWnd
	   button "R",*btn_ListWnd
	   button "C",*btn_ListWnd
	   pos 20,0
	   objsize winx-20,winy-25
	   i=lSelectedIdx
	   listbox lSelectedIdx,0,""
	   lSelectedIdx=i
	   objsize 140,21
	   pos 5,winy-23
	   button "選択中の項目を消去",*btn_ListWnd
	   objsize 100,21
	   pos 150,winy-23
	   button "リストを保存",*btn_ListWnd
	   pos 250,winy-23
	   button "リストを読込",*btn_ListWnd
	   objsize 60,21
	   pos winx-65,winy-23
	   button "閉じる",*btn_ListWnd
	   ; ウィンドウメッセージ取得設定
	   gm_setwndproc hwListWnd
	   gm_setmessage hwListWnd,WM_COMMAND		; WM_COMMAND(メニュー項目のクリック)の取得
	   hwListSub=bmscrl.46
	   gm_setwndproc hwListSub
	   gm_setmessage hwListSub,WM_LBUTTONDBLCLK	; ダブルクリックの取得
	   gm_setmessage hwListSub,WM_KEYUP		; [Delete] キー押下の取得
	   gm_setmessage hwListSub,WM_DROPFILES		; ドラッグ＆ドロップの取得
	   prm=hwListSub,1				; ドラッグ＆ドロップの許可
	   dllprocp FNC_DragAcceptFiles,prm,2
	   ; チップヘルプの更新
	   gsel sWid
	   wi.widList=1
	   gosub refresh_tiphelp
	  }
	  if func&FNC_CHANGE {
	   i=func&FNC_AUTO!0&(dispListWnd)|(func&FNC_OFF)
	   ; i		/ 画面を閉じる(1)か開く(0)か
	   ; メイン画面のリスト編集系ボタンを有効/無効に
	   repeat objmax
	    ii=obj.cnt&$FF000000
	    iii=0
	    repeat
	     if ii=FNC_OPEN_LISTAREA	:iii=1 :break
	     if ii=FNC_PLAYLIST		:iii=1 :break
	     if ii=FNC_PLAYLISTC	:iii=1 :break
	     break
	    loop
	    if iii :btnable cnt,i=0
	   loop
	   ; 画面表示に反映
	   dispListWnd=i=0
	   func=FNC_LIST_REFRESH :gosub *exec_func
	   gsel widList,dispListWnd*2-1
	   gsel sWid
	   func=FNC_OPEN_LISTAREA|FNC_OX(dispListWnd=0) :gosub *exec_func
	  }
	  return_ dispListWnd
	 }
	 ; (3) 情報ウィンドウ
	 if funcopt&$FF=widInfo {
	  ; 初めて情報画面を表示する場合
	  if wi.widInfo=0 {
	   ; ウィンドウの初期化
	   screen widInfo,360,185,6,dispx-360/2,dispy-185/2
	   title ""
	   mref bmscri,67
	   hwInfoWnd=bmscri.13
	   ; オブジェクトの整備
	   font "ＭＳ ゴシック",12
	   objmode 2,1
	   ;  曲情報表示欄
	   s=""
	   objsize 85 ,25:pos 2 ,3  :combox mScrollType  ,,type_minfo
	   objsize 265,24:pos 90,1  :mesbox s,,,0
	   objsize 85 ,25:pos 2 ,28 :combox mScrollType.1,,type_minfo
	   objsize 265,24:pos 90,26 :mesbox s,,,0
	   objsize 85 ,25:pos 2 ,53 :combox mScrollType.2,,type_minfo
	   objsize 265,24:pos 90,51 :mesbox s,,,0
	   objsize 85 ,25:pos 2 ,78 :combox mScrollType.3,,type_minfo
	   objsize 265,24:pos 90,76 :mesbox s,,,0
	   objsize 85 ,25:pos 2 ,103:combox mScrollType.4,,type_minfo
	   objsize 265,24:pos 90,101:mesbox s,,,0
	   objsize 150,21
	   pos 205,129	:button "プロパティを表示",*btn_InfoWnd
	   objsize 100,21
	   pos 150,160	:button "情報を更新",*btn_InfoWnd
	   pos 255,160	:button "閉じる",*btn_InfoWnd
	   ;  入力ボックス
	   objsize 340,21
	   pos 10,40	:input funcopts
	   ;  選択ボックス
	   objsize 340,70
	   i=funcopt
	   funcopt=0	:s=""
	   pos 10,30	:listbox funcopt,50,s
	   funcopt=i
	   ;  [参照]
	   objsize 40,21
	   font "MS UI Gothic",10
	   pos 310,40	:button "参照...",*btn_InfoWnd
	   font "ＭＳ ゴシック",12
	   ;  [O K] [キャンセル]
	   objsize 100,21
	   pos 150,160 :button "O K",*btn_InfoWnd
	   pos 255,160 :button "キャンセル",*btn_InfoWnd
	   wi.widInfo=1
	  } else :gsel widInfo
	  if func&FNC_CHANGE {
	   ; 画面を閉じる
	   if func&FNC_AUTO!0&(dispInfoWnd&1)|(func&FNC_OFF) {
	    gsel widInfo,-1
	    gsel sWid
	    if dispInfoWnd&IDX_WND_INPUT!0 {
	     if dispInfoWnd&IDX_WND_SKV {
	      ; [参照] ボタン表示用に縮めた入力ボックスを元に戻す
	      i=sEditingIdx
	      if sVar_type.i=SV_IMAGE :objresize 340,21,13
	     }
	     gosub enable_allWnd
	    }
	    dispInfoWnd=0
	   ; 画面を開く
	   } else {
	    dispInfoWnd=funcopt&IDX_WND_INPUT+1
	    redraw 2
	    boxf_ 0,0,winx,winy,hSysBrush
	    boxf_ 4,winy-31,winx-5,winy-30,hSysBrush2
	    ; 曲情報(IDX_WND_MINFO)
	    if dispInfoWnd&IDX_WND_INPUT=0 {
	     repeat 13  :btnable cnt,3 :loop
	     repeat 5,13:btnable cnt,2 :loop
	     if func&FNC_REFRESH {
	      func=FNC_GETTAGINFO|FNC_AUTO+IDX_CUR :gosub *exec_func
	     } else :gosub get_mscroll
	    ; その他
	    } else {
 	     gosub disable_allWnd
	     repeat 16  :btnable cnt,2 :loop
	     repeat 2,16:btnable cnt,3 :loop
	     palcolor 0
	     pos 10,10
	     repeat
	      ; スキン変数内容の編集画面(IDX_WND_SKV)
	      if dispInfoWnd&IDX_WND_SKV {
	       i=sEditingIdx :ii=sVar_type.i=SV_LIST+13
	       ; i	/	スキン変数ID
	       ; ii	/	リストボックスを使用可能にする(14)か、
	       ;		入力ボックスを使用可能にする(13)か
	       btnable ii,3
	       if sVar_type.i=SV_IMAGE {
	        objresize 300,21,13
	        btnable 15,3
	       }
	       objprm ii,funcopts
	       mes sVar_dsc.i :break
	      }
	      ; 音楽ファイル名の変更画面(IDX_WND_RENAME)
	      btnable 13,3
	      objprm 13,funcopts
	      if dispInfoWnd&IDX_WND_RENAME :mes langs.lgDlg_Rename :break
	      ; お気に入り登録名入力画面(IDX_WND_FAVORITE)
	      if dispInfoWnd&IDX_WND_FAVORITE :mes langs.lgDlg_Favorite :break
	      break
	     loop
	     redraw 1
	     gsel widInfo,1
	     gsel sWid
	     ; この後
	     ; [O K] [キャンセル] ボタンがクリックされると *btn_InfoWnd へ
	     ; [Alt]+[F4] キーが押されると *exit へ
	     stop
	    }
	    redraw 1
	    gsel widInfo,1
	    gsel sWid
	   }
	  }
	  return_ dispInfoWnd
	 }
	 ; (4) 再生に使用している仕組みの説明画面
	 funcopt-=widExt
	 if mStatus=ST_CLOSED|(funcopt>=npfprop) :return_ FR_ERR
	 ; ファイル種の確認
	 i=TPfromTPEX(mFileType)
	 ; 各仕組みの説明を表示
	 repeat
	  ; Windows MCI を利用
	  if type.i=PF_MCI {
	   dialog "Multimedia Control Interface\n\n　マルチメディアを再生するために使用される仕組みです。\n　音楽ファイルにとどまらず、映像や静止画、CDの再生などができます。",,"MCI"
	   break
	  }
	  ; DirectX DirectShow を利用
	  if type.i=PF_DXS {
	   gosub enum_filters
	   break
	  }
	  ; 外部DLLを利用
	  if type.i=PF_DLL {
	   ; DDE
	   /*
	   if mFileType&TPEX_MID {
	    if dde_name="TMIDI" {
	     dialog "TMIDI Player / (c) ふみぃ\n\n　Midiの高品位な再生と歌詞表示に特化したソフトウェアです。\n\n※現在の版の arXmp は TMIDI Player のメイン画面を表示しない仕様となっており、\n　歌詞表示機能を利用することはできません。",,dde_name+".exe"
	     break
	    }
	    if dde_name="WFP" {
	     dialog "WFP / (c) A.I (Tonouesan)\n\n　Midiの高品位な再生と歌詞表示に特化したソフトウェアです。",,dde_name+".exe"
	     break
	    }
	    break
	   }
	   */
	   ; Vox.dll
	   if mFileType&TPEX_OGG {
	    dialog "Vox - Vorbis Expander / (c) 野村XX\n\n　Vox.dll は OggVorbis 形式の音楽ファイルを再生する機能を持ちます。",,"Vox.dll"
	    break
	   }
	   ; vbmp3.dll
	   if mFileType&TPEX_MP3 {
	    dialog "vbmp3 / original ver. (c) ミケ\n\n　vbmp3.dll は MPEG Audio 形式の音楽ファイルを再生する機能を持ちます。",,"vbmp3.dll"
	    break
	   }
	   break
	  }
	  break
	 loop
	 return_ FR_DONE
	}

; ―――――――――――――――――――――――――――――――――――――
; リスト領域を表示/隠す

	if funcid=FNC_OPEN_LISTAREA {
	 if func&FNC_CHANGE {
	  ; 隠す
	  if func&FNC_AUTO!0&(dispListArea)|(func&FNC_OFF) {
	   scrLine+=scrAreaHide_ListAreaLine
	   script=scrAreaHide_ListArea+script
	   prm=MainWndWidth+ListAreaWidth,MainWndHeight+ListAreaHeight,MainWndWidth,MainWndHeight
	   dispListArea=0
	  ; 表示
	  } else {
	   scrLine+=scrAreaDisp_ListAreaLine
	   script=scrAreaDisp_ListArea+script
	   prm=MainWndWidth,MainWndHeight,MainWndWidth+ListAreaWidth,MainWndHeight+ListAreaHeight
	   dispListArea=1
	  }
	  ; メイン画面の大きさ変更
	  if sListArea!2 {
	   if sListArea=1 {
	    repeat 10,1
	     width prm+(prm.2-prm/10*cnt),prm.1+(prm.3-prm.1/10*cnt)
	     await
	    loop
	   }
	   width prm.2,prm.3
	  }
	 }
	 return_ dispListArea
	}

; ―――――――――――――――――――――――――――――――――――――
; 音楽ファイルのプロパティを表示

	if funcid=FNC_OPEN_PROPERTY {
	 if func&FNC_STR=0 {
	  gosub get_mpath
	  if funcopt=-1 :return_ FR_ERR
	 }
	 ; mp3infp.dll 使用時はタグのプロパティページを優先して表示
	 if D_MP3INFP!0 {
	  s=funcopts
	  prm=0,ps,0
	  dllprocp FNC_mp3infp_ViewProp,prm,3
	 ; 非使用時は普通にプロパティを表示
	 } else {
	  skiperr 1
	  exec funcopts,,"properties"
	  dllret=err=0
	  skiperr 0
	 }
	 return_ dllret=0*FR_ERR
	}

; ―――――――――――――――――――――――――――――――――――――
; 音楽ファイルの親フォルダを表示

	if funcid=FNC_OPEN_PARENTDIR {
	 if func&FNC_STR=0 {
	  gosub get_mpath
	  if funcopt=-1 :return_ FR_ERR
	 }
	 ; 親フォルダの取得
	 getfname funcopts
	 strmid funcopts,funcopts,0,stat
	 ; 存在確認と表示
	 exist_ funcopts
	 if stat=-1 :exec funcopts,16 :return_ FR_DONE
	 return_ FR_ERR
	}

; ―――――――――――――――――――――――――――――――――――――
; メイン画面を最小化/元に戻す

	if funcid=FNC_MINIMIZE {
	 if func&FNC_CHANGE {
	  ; 最小化
	  if func&FNC_AUTO!0&(dispMainWnd&2=0)|(func&FNC_ON) {
	   ginfo 2 :MainWndX=prmx :MainWndY=prmy
	   dllprocp FNC_CloseWindow,hwMainWnd,1
	  ; 元に戻す
	  } else {
	   prm=hwProcess,WM_TASKTRAY,0,WM_LBUTTONUP
	   dllprocp FNC_SendMessageA,prm,4
	  }
	 }
	 return_ dispMainWnd&2!0
	}

; ―――――――――――――――――――――――――――――――――――――
; メニューを表示する

	if funcid=FNC_POPUP {
	 if funcopt<0|(funcopt>=nhmenu) :return_ FR_ERR
	 ginfo
	 i=funcopt
	 pmenu hmenu.i,prmx,prmy,bmscr.13
	 ; 選択された機能の実行
	 if dllret {
	  func=dllret :gosub *exec_func
	  return_
	 }
	 return_ FR_ERR
	}

; ―――――――――――――――――――――――――――――――――――――
; 音楽の再生
; (全長やファイル種別タグの取得処理を含む)

	if funcid=FNC_PLAY {
	 if func&FNC_STR=0 {
	  gosub get_mpath
	  if funcopt=-1 :return_ FR_ERR
	  mFileIdx=funcopt
	 } else :mFileIdx=-1
	 ; これまで再生していた音楽の停止
	 if mStatus!ST_CLOSED :func=FNC_STOP :gosub *exec_func
	 ; 音楽の情報 [1]
	 mFilePath=funcopts	:gettype mFilePath :s=refstr
	 mFileType=stat		:getfname mFilePath
	 mFileName=refstr	:i=mFileIdx+1
	 mFileSize=0 :mQuality=0
	 mAuthor="" :mName="" :mComment="" :mAlbumName="" :mRelDate="" :mFormat=""
	 ; タスクトレイ表示用文字列の生成
	 mTasktray=""+i+". "+mFileName
	 strlen i,mTasktray
	 if 64-lprgnames<i {
	  strmid_ mTasktray,mTasktray,0,61-lprgnames
	  mTasktray+="..."
	 }
	 mTasktray+=sep+prgnames
	 ; ファイル種の確認
	 i=TPfromTPEX(mFileType)
	 if i=TP_OTH :return_ FR_ERR
	 ; ファイルの存在確認
	 if i!TP_CDA {
	  exist_ mFilePath
	  if stat!1 {
	   convert sss,langs.lgDlg_ErrorNotFound,"音楽ファイル","%format%"
	   convert ss,sss,mFilePath,"%file%"
	   gosub disable_allWnd
	   if mFileIdx=-1 {
	    convert s,ss,"","%confirm%"
	    dialog s,0,prgtitles
	   } else {
	    convert s,ss,langs.lgDlg_ConfirmClearFile,"%confirm%"
	    dialog s,2,prgtitles
	   }
	   if stat=6 :func=FNC_LIST_CLEAR+mFileIdx :gosub *exec_func
	   gosub enable_allWnd
	   return_ FR_ERR
	  }
	  exist mFilePath
	  if strsize=-1 :mFileSize=0 :else :mFileSize=strsize
	 }
	 ; 読み込みと再生開始
	 title_ "音楽を読み込んでいます"+sep+prgtitles
	 gosub disable_allWnd
	 npfprop=0
	 repeat
	  ; Windows MCI を利用
	  ;	s	/ 拡張子(大文字)
	  if type.i=PF_MCI {
	   ; CD のみ特殊
	   if mFileType&TPEX_CDA {
	    ; ドライブ名を取得
	    s=mFilePath
	    strmid ss,s,0,3
	    ; トラック名を取得
	    strlen i,s
	    repeat i
	     peek ii,s,cnt
	     if (ii>='a')&(ii<='z') :ii-=32
	     poke s,cnt,ii
	    loop
	    instr prm,s,"TRACK",0
	    instr prm.1,s,".CDA",0
	    prm+=5
	    strmid s,s,prm,prm.1-prm
	    int_ s
	    ;	im	/ 再生するトラック番号
	    ; 開く
	    mci "open "+ss+" alias "+mci_alias+" wait type cdaudio"
	    if stat!1 :dllret=1 :break
	    ; 再生に使用している仕組みメニュー構築
	    npfprop=1
	    imenu "MCI: CD-Audio",FNC_OPEN_WND|FNC_ON+widExt,0,hmMinfoSubPf
	    ; 再生開始
	    mci "set "+mci_alias+" time format tmsf"
	    mci "status "+mci_alias+" number of tracks"
	    i=im+1
	    if i<=stat :s=" to "+i :else :s=""
	    mci "play "+mci_alias+" from "+im+s
	    ; ※ time format milliseconds にして
	    ;		i=mci_cdatrackstart+mDuration
	    ;		mci "play "+mci_alias+" from "+mci_cdatrackstart+" to "+i
	    ;		if stat=-1 :dllret=1 :break
	    ; 　 を実行すると１トラックで再生が止まってくれない？
	    ; 時間単位の設定と全長、トラックの開始位置の取得
	    mci "set "+mci_alias+" time format milliseconds"
	    mci "status "+mci_alias+" length track "+im
	    mDuration=stat
	    mci "status "+mci_alias+" position track "+im
	    mci_cdatrackstart=stat
	    dllret=0 :break
	   }
	   ; デバイス名の指定を確認
	   mci_device=""
	   instr i,types.TP_MCI,s+"("
	   if i!-1 {
	    strlen ii,s :i+=ii+1
	    instr ii,types.TP_MCI,")",i
	    if ii!-1&(ii<256) {
	     strmid mci_device,types.TP_MCI,i,ii
	     mci_device=" type "+mci_device
	    }
	   }
	   ; 音楽ファイルを開く
	   ss=mFilePath
	   s =""
	   prm=pss,ps,512
	   dllprocp FNC_GetShortPathNameA,prm,3
	   mci "open \""+s+"\" alias "+mci_alias+" wait"+mci_device
	   if stat=-1 :dllret=1 :break
	   ; 曲情報の取得
	   mci "info "+mci_alias+" name"	:mName=refstr
	   mci "info "+mci_alias+" copyright"	:mAuthor=refstr
	   mci "capability "+mci_alias+" device type" :mFormat=refstr
	   ; 再生に使用している仕組みメニュー構築
	   npfprop=1
	   imenu "MCI: "+mFormat,FNC_OPEN_WND|FNC_ON+widExt,0,hmMinfoSubPf
	   ; 時間単位の設定と全長の取得
	   mci "set "+mci_alias+" time format milliseconds"
	   mci "status "+mci_alias+" length"
	   mDuration=stat
	   ; 再生開始
	   mci "play "+mci_alias+" from 0"
	   dllret=0 :break
	  }
	  ; DirectX DirectShow を利用
	  if type.i=PF_DXS {
	   if pCallMethod=0 :func=FNC_LOADLIB+IDX_LOAD_COM :gosub *exec_func
	   if dxs_clsid_FilterGraph=0 :func=FNC_LOADLIB+IDX_LOAD_DXS :gosub *exec_func
	   ; 音楽ファイルの受け皿作成
	   memcpy i ,dxs_clsid_FilterGraph,16
	   memcpy ii,dxs_iid_IGraphBuilder,16
	   prm=pi,0,1,pii
	   getptr prm.4,dxs_gb
	   dllprocp FNC_CoCreateInstance,prm,5
	   ; 音楽ファイルを流し込む(IGraphBuilder->RenderFile)
	   s=mFilePath
	   uni s
	   prmex=ps,0
	   prm=pprmex,2,13,dxs_gb
	   ll_callfunc prm,4,pCallMethod
	   if dllret!0 :break
	   ; 利用されるフィルタの一覧を取得(〃->EnumFilters)
	   gosub enum_filters
	   ; 再生に使用している仕組みメニュー構築
	   notesel tmp2
	   notemax npfprop
	   npfprop--		; ファイルフィルタは除外
	   repeat npfprop
	    noteget s,cnt
	    imenu s,FNC_OPEN_WND|FNC_ON+widExt+cnt,0,hmMinfoSubPf
	   loop
	   ; 使用するインターフェースの準備(IGraphBuilder->QueryInterface)
	   qi dxs_gb,dxs_mc,dxs_iid_IMediaControl
	   qi dxs_gb,dxs_ms,dxs_iid_IMediaSeeking
	   qi dxs_gb,dxs_ba,dxs_iid_IBasicAudio
	   ; 時間単位の設定(IMediaSeeking->SetTimeFormat)
	   ; prmex=pi
	   ; prm=pprmex,1,9,dxs_ms
	   ; ll_callfunc prm,4,pCallMethod
	   ; 全長の取得(IMediaSeeking->)
	   prmex=pi
	   prm=pprmex,1,10,dxs_ms
	   ll_callfunc prm,4,pCallMethod
	   llconv mDuration,i
	   ; 再生開始(IMediaControl->Run)
	   prm=0,0,7,dxs_mc
	   ll_callfunc prm,4,pCallMethod
	   dllret=0 :break
	  }
	  ; 外部DLLを利用
	  if type.i=PF_DLL {
	   ; DDE
	   /*
	   if mFileType&TPEX_MID {
	    title_ "DDE: initializing"+sep+prgtitles
	    ; (1) DDE通信の相手を確認
	    s =defdde_dir
	    ss=defdde_name
	    instr i,types.TP_MID,"("
	    if i!-1 {
	     i++
	     instr ii,types.TP_MID,")",i
	     if ii!-1&(ii<512) {
	      strmid s,types.TP_MID,i,ii
	      getfname s
	      ss=refstr
	      strmid s,s,0,stat
	     }
	     peek i,s,1
	     if i!':' :s=extdir+s
	    }
	    ; (2) DDEの初期化
	    i=0
	    if s !dde_dir  :i=1
	    if ss!dde_name :i=1
	    if i&(dde_inst!0) :gosub uninit_dde
	    dde_dir=s
	    dde_name=ss
	    if dde_inst=0 {
	     func=FNC_LOADLIB|FNC_ON+IDX_LOAD_DDE :gosub *exec_func
	     if funcret=0 :dllret=1 :break
	    }
	    ; (3) DDE通信の開始
	    title_ "DDE("+dde_name+"): connecting"+sep+prgtitles
	    repeat
	     if dde_name="TMIDI" :funcopts="OWL_Window" :break
	     if dde_name="WFP" :funcopts="WFP Main Window Class" :break
	     break
	    loop
	    s=dde_name :ss=dde_name
	    ; s		/ サービス名
	    ; ss	/ トピック名
	    ; funcopts	/ サービスを提供するプログラムのウィンドウクラス
	    dde_hwnd=0
	    repeat 2
	     ; メイン画面探索
	     prm=pfuncopts,0
	     repeat cnt*9+1
	      if cnt!0 :wait 50
	      dllprocp FNC_FindWindowA,prm,2
	      if dllret :dde_hwnd=dllret :break
	     loop
	     ;  TMIDI の場合
	     if dde_name="TMIDI" {
	      ; (一般的なクラス名のウィンドウなので精査を要する)
	      if dde_hwnd {
	       repeat cnt*9+1
	        if cnt!0 :wait 50
	        prm=dde_hwnd,ptmp,1024
	        dllprocp FNC_GetWindowTextA,prm,3
	        if dllret {
	         instr i,tmp,"TMIDI Player"
	         ; TMIDI Player ウィンドウを発見
	         if i!-1 {
	          ; 隠す
	          if cnt=1 {
	           prm.1=0
	           dllprocp FNC_CloseWindow,prm,1
	           dllprocp FNC_ShowWindow,prm,2
	           break
	          }
	         } else :dde_hwnd=0
	        }
	       loop
	      }
	     }
	     ; 通信を試みる
	     dde_c s,ss
	     if dde_hconv :break
	     ; 一度通信に失敗したらプログラムの起動から試みる
	     title_ "DDE("+dde_name+"): executing a DDE server"+sep+prgtitles
	     tmp=dde_dir+dde_name+".exe"
	     exist_ tmp
	     if stat!1 :break
	     sss="open"
	     prm=bmscr.13,psss,ptmp,0,0,1
	     ;  WFP の場合
	     if dde_name="WFP" {
	      ; 全画面非表示での起動
	      string@arxmp_mod="/DM /DW /DS /DP /DQ"
	      prm.3=pstring@arxmp_mod
	     }
	     dllprocp FNC_ShellExecuteA,prm,6
	     dllprocp FNC_SetForegroundWindow,hwMainWnd,1
	    loop
	    if dde_hconv=0 :dllret=1 :break
	    ; Midiファイルを開く
	    title_ "DDE("+dde_name+"): opening a file"+sep+prgtitles
	    ss=mFilePath
	    s =""
	    prm=pss,ps,512
	    dllprocp FNC_GetShortPathNameA,prm,3
	    repeat
	     ; TMIDI Player の場合
	     if dde_name="TMIDI" {
	      ; 再生の開始
	      dde_exec "lock"
	      dde_exec "playfile "+s
	      ; 曲情報の取得
	      ss=s
	      dde_req "getplayfile" :int_ s :dde_idx=im
	      dde_req "gettitle "+dde_idx
	      if s!ss :mName=s
	      ; 全長の取得
	      dde_req "getlength "+dde_idx :int_ s
	      mDuration=im
	      if mDuration=0 {
	       dde_exec "unlock"
	       dde_dc
	       dllret=1 :break
	      }
	      dllret=0 :break
	     }
	     if dde_name="WFP" {
	      ; 再生の開始
	      dde_exec s+" /PLAY"
	      ; 曲情報の取得
	      ; (無理)
	      ; 全長の取得
	      ; (無理)
	      dllret=0 :break
	     }
	     dllret=1 :break
	    loop
	    if dllret :break
	    ; 再生に使用している仕組みメニュー構築
	    npfprop=1
	    imenu "DDE: "+dde_name,FNC_OPEN_WND|FNC_ON+widExt,0,hmMinfoSubPf
	    dllret=0 :break
	   }
	   */
	   ; Vox.dll
	   if mFileType&TPEX_OGG {
	    ; OggVorbisファイルを開く
	    if D_VOX=0 {
	     func=FNC_LOADLIB|FNC_ON+IDX_LOAD_VOX :gosub *exec_func
	     if funcret=0 :dllret=1 :break
	    }
	    s=mFilePath
	    dllprocp FNC_vox_Load,ps,1
	    if dllret=-1 :break
	    vox_id=dllret
	    ; 再生に使用している仕組みメニュー構築
	    npfprop=1
	    imenu "Vox.dll",FNC_OPEN_WND|FNC_ON+widExt,0,hmMinfoSubPf
	    ; 曲情報の取得
	    prm=vox_id,pss,0
	    prscom mAuthor,"ARTIST"
	    prscom mName,"TITLE"
	    prscom mComment,"COMMENT"
	    prscom mComment,"DESCRIPTION"
	    prscom mRelDate,"DATE"
	    ; 全長の取得
	    prm=vox_id,0
	    dllprocp FNC_vox_GetTotalTime,prm,1
	    mDuration=dllret
	    ; 再生開始
	    dllprocp FNC_vox_SetLoop	,prm,2
	    dllprocp FNC_vox_Play	,prm,1
	    dllret=0 :break
	   }
	   ; vbmp3.dll
	   if mFileType&TPEX_MP3 {
	    ; MP3ファイルを開く
	    if D_VBMP3=0 {
	     func=FNC_LOADLIB|FNC_ON+IDX_LOAD_VBMP3 :gosub *exec_func
	     if funcret=0 :dllret=1 :break
	    }
	    s=mFilePath
	    prm=ps,pss
	    dllprocp FNC_vbmp3_open,prm,2
	    if dllret=0 :dllret=1 :break
	    ; 再生に使用している仕組みメニュー構築
	    npfprop=1
	    imenu "vbmp3.dll",FNC_OPEN_WND|FNC_ON+widExt,0,hmMinfoSubPf
	    ; 曲情報の取得
	    ll_peek s,pss	:mName=s
	    ll_peek s,pss+128	:mAuthor=s
	    ; 全長の取得
	    ll_peek4 i,pss+268
	    mDuration=i*1000
	    ; 再生開始
	    dllprocp FNC_vbmp3_play	,prm,0
	    dllret=0 :break
	   }
	   dllret=1 :break
	  }
	  break
	 loop
	 if dllret!0 {
	  convert sss,langs.lgDlg_ErrorFormat,"音楽","%format%"
	  convert ss,sss,mFilePath,"%file%"
	   if mFileIdx=-1 {
	    convert s,ss,"","%confirm%"
	    dialog s,0,prgtitles
	   } else {
	    convert s,ss,langs.lgDlg_ConfirmClearFile,"%confirm%"
	    dialog s,2,prgtitles
	   }
	  if stat=6 :func=FNC_LIST_CLEAR+mFileIdx :gosub *exec_func
	  gosub enable_allWnd
	  return_ FR_ERR
	 }
	 ; 起動時の再生箇所再現
	 if dispMainWnd&initializing {
	  mPosition=xstheader.14 :gosub apply_mPosition
	 }
	 title_ "音楽の再生を開始しています"+sep+prgtitles
	 ; 音楽の情報 [2]
	 func=FNC_GETTAGINFO|FNC_AUTO+IDX_CUR :gosub *exec_func
	 ; タスクトレイに反映
	 if dispMainWnd&2!0|dispTrayicon :ttray mTasktray
	 ; タイトルに反映
	 dispTitle=1
	 ; スクリプトの実行を準備
	 scrLine+=scrAreaShow_FileInfoLine
	 script=scrAreaShow_FileInfo+script
	 ; 再生開始待ち
	 mStatus=ST_PAUSED
	 gosub wait_mStatus
	 gosub enable_allWnd_
	 return_ FR_DONE
	}

; ―――――――――――――――――――――――――――――――――――――
; 音楽の一時停止/再開

	if funcid=FNC_PAUSE {
	 if mStatus=ST_CLOSED :return_ FR_ERR
	 ; ファイル種の確認
	 i=TPfromTPEX(mFileType)
	 ; 再生の一時停止/再開
	 repeat
	  ; Windows MCI を利用
	  if type.i=PF_MCI {
	   if mStatus=ST_PLAYING {
	    if mFileType&TPEX_CDA {
	     mci "stop "+mci_alias
	     mci_cdapaused=1
	     break
	    }
	    mci "pause "+mci_alias :break
	   }
	   if mFileType&TPEX_CDA :mci_cdapaused=0
	   mci "play "+mci_alias
	   break
	  }
	  ; DirectX DirectShow を利用
	  if type.i=PF_DXS {
	   ; 再生一時停止(IMediaControl->Pause)
	   ;   または再開(〃 　　　　　->Run  )
	   prm=0,0,0,dxs_mc
	   prm.2=(mStatus=ST_PLAYING)+7
	   ll_callfunc prm,4,pCallMethod
	   break
	  }
	  ; 外部DLLを利用
	  if type.i=PF_DLL {
	   ; DDE
	   /*
	   if mFileType&TPEX_MID {
	    if mStatus=ST_PLAYING {
	     if dde_name="TMIDI" :dde_exec "pause" :break
	     if dde_name="WFP" :dde_exec "/PAUSE" :break
	     break
	    }
	    if dde_name="TMIDI" :dde_exec "resume" :break
	    if dde_name="WFP" :dde_exec "/RESUME" :break
	    break
	   }
	   */
	   ; Vox.dll
	   if mFileType&TPEX_OGG {
	    if mStatus=ST_PLAYING {
	     dllprocp FNC_vox_Pause,vox_id,1
	     mStatus=ST_PAUSED
	     break
	    }
	    dllprocp FNC_vox_Play,vox_id,1
	    mStatus=ST_PLAYING
	    break
	   }
	   ; vbmp3.dll
	   if mFileType&TPEX_MP3 {
	    if mStatus=ST_PLAYING {
	     dllprocp FNC_vbmp3_pause,prm,0
	     mStatus=ST_PAUSED :break
	    }
	    dllprocp FNC_vbmp3_restart,prm,0
	    mStatus=ST_PLAYING :break
	   }
	   break
	  }
	  break
	 loop
	 return_ mStatus=ST_PAUSED
	}

; ―――――――――――――――――――――――――――――――――――――
; 音楽の停止
;	注意	funcopts, mFileIdx の内容を破壊しない (FNC_PLAY 用の配慮)
;		im の内容を破壊しない (FNC_SET_PLAYFUNC 用の配慮)

	if funcid=FNC_STOP {
	 if mStatus=ST_CLOSED :return_ FR_DONE
	 ; ファイル種の確認
	 i=TPfromTPEX(mFileType)
	 ; 再生停止
	 repeat
	  ; Windows MCI を利用
	  if type.i=PF_MCI {
	   if mFileType&TPEX_CDA :mci_cdapaused=0
	   ; 再生停止
	   mci "stop "+mci_alias
	   ; 使用したデバイスの解放
	   mci "close "+mci_alias
	   break
	  }
	  ; DirectX DirectShow を利用
	  if type.i=PF_DXS {
	   ; 再生停止(IMediaControl->Stop)
	   prm=0,0,9,dxs_mc
	   ll_callfunc prm,4,pCallMethod
	   ; 使用したインターフェースの解放
	   ri dxs_gb
	   ri dxs_mc
	   ri dxs_ms
	   ri dxs_ba
	   break
	  }
	  ; 外部DLLを利用
	  if type.i=PF_DLL {
	   ; DDE
	   /*
	   if mFileType&TPEX_MID {
	    repeat
	     if dde_name="TMIDI" {
	      dde_exec "stop"
	      dde_exec "unlock"
	      ; if dde_hwnd {
	      ;  prm=dde_hwnd,1
	      ;  dllprocp FNC_ShowWindow,prm,2
	      ; }
	      break
	     }
	     if dde_name="WFP" :dde_exec "/STOP" :break
	     break
	    loop
	    if dispMainWnd&closing {
	     gosub uninit_dde
	    } else :dde_dc
	    break
	   }
	   */
	   ; Vox.dll
	   if mFileType&TPEX_OGG {
	    dllprocp FNC_vox_Release	,vox_id,1
	    dllprocp FNC_vox_Delete	,vox_id,1
	    break
	   }
	   ; vbmp3.dll
	   if mFileType&TPEX_MP3 {
	    dllprocp FNC_vbmp3_stop	,prm,0
	    dllprocp FNC_vbmp3_close	,prm,0
	    break
	   }
	   break
	  }
	  break
	 loop
	 ; 変数などの初期化
	 mFileType=0
	 mPosition=0
	 mStatus=ST_CLOSED
	 repeat npfprop :dmenu hmMinfoSubPf,FNC_OPEN_WND|FNC_ON+widExt+cnt :loop
	 ; プラグインなどに通知
	 gosub notify_mStatus
	 ; タイトルに反映
	 dispTitle=TI_TITLE
	 return_ FR_DONE
	}

; ―――――――――――――――――――――――――――――――――――――
; 再生モードを変更

	if funcid=FNC_MODE {
	 ; (1) 再生リストの繰返し再生
	 if funcopt=PM_REPLIST {
	  if func&FNC_CHANGE {
	   if func&FNC_AUTO :lMode=lMode^PM_REPLIST :else {
	    lMode=lMode&$F+(func&FNC_ON!0*PM_REPLIST)
	   }
	   ; スクリプトの実行を準備
	   scrLine+=scrAreaShow_ModeExLine
	   script=scrAreaShow_ModeEx+script
	  }
	  ; チェックを更新
	  ;  メニュー
	  i=lMode&PM_REPLIST!0
	  if func&FNC_CHANGE|(dispMainWnd&initializing) {
	   mii.1=1 :mii.3=8*i :setmii hmSetPlay,FNC_OBJ402+objList_ChangeListLoop
	  }
	  ;  チェックボックス
	  if func&(FNC_CHANGE|FNC_REFRESH) {
	   repeat snChk
	    ii=chkid.cnt
	    if obj.ii^func&$FF00FFFF=0 :objprm ii,i
	    chk_.cnt=chk.cnt
	   loop
	  }
	  return_ lMode&PM_REPLIST!0
	 }
	 ; (2) 再生モード
	 if func&FNC_CHANGE|(dispMainWnd&initializing) {
	  ; メニューから既存のチェックを外す
	  mii.1=1 :mii.3=0 :setmii hmMode,FNC_MODE|FNC_ON+(lMode&$F)
	  if func&FNC_CHANGE {
	   ; 再生モード値を変更
	   if func&FNC_AUTO {
	    lMode=lMode&$F0+(lMode&$F+1\6)
	   } else {
	    lMode=lMode&$F0+(funcopt\6)
	   }
	   ; タイトルに反映する
	   i=lMode&$F+lgPMTI
	   title_ ""+langs.i+sep+prgtitles
	   ; スクリプトの実行を準備
	   scrLine+=scrAreaShow_ModeLine
	   script=scrAreaShow_Mode+script
	  }
	  ; メニューにチェックを付す
	  mii.1=1 :mii.3=8 :setmii hmMode,FNC_MODE|FNC_ON+(lMode&$F)
	 }
	 return_ lMode&$F
	}

; ―――――――――――――――――――――――――――――――――――――
; 音量を変更
/*
	if funcid=FNC_VOLUME {
	 ; 未実装
	}
*/

; ―――――――――――――――――――――――――――――――――――――
; 再生位置を変更
;	注意	秒単位の指定しかできない。

	if funcid=FNC_SEEK {
	 if mStatus=ST_CLOSED :return_ FR_ERR
	 ; 再生位置の設定
	 mPosition=funcopt*1000
	 gosub apply_mPosition
	 gosub wait_mStatus
	 return_ FR_DONE
	}

; ―――――――――――――――――――――――――――――――――――――
; 音楽ファイルのタグ情報を取得
;	内部処理用

	if funcid=FNC_GETTAGINFO {
	 ; mp3infp.dll を利用して音楽情報を取得
	 if D_MP3INFP {
	  if mFileType&(TPEX_MID|TPEX_CDA)=0 {
	   s=mFilePath
	   prm=0,ps :dllprocp FNC_mp3infp_Load,prm,2
	   if mFileType&TPEX_MP3 {
	    dllprocp FNC_mp3infp_mp3_GetTagType,prm,0
	    repeat
	     if dllret&4 :s="_rmp" :break
	     if dllret&2 :s="_v2" :break
	     if dllret&1 :s="_v1" :break
	     break
	    loop
	   } else :s=""
	   prm=pss,pi
	   getval mAuthor,"IART"+s
	   getval mName,"INAM"+s
	   getval mAlbumName,"IPRD"+s
	   getval mRelDate,"ICRD"+s
	   getval mComment,"ICMT"+s
	   getval mFormat,"AFMT"
	   repeat
	    if s="_v1" :break
	    getval tmp,"ICOP"+s
	    if tmp!"" :mAuthor+=" / "+tmp
	    break
	   loop
	  }
	 } else {
	  ; 自力でMP3情報を解析
	  if mFileType&TPEX_MP3 {
	   bload mFilePath,tmp,128,mFileSize-128
	   strmid s,tmp,0,3
	   if s="TAG" {
	    strmid mAuthor,tmp,33,30	; minfo_.1
	    strmid mName,tmp,3,30	;        2
	    strmid mComment,tmp,97,30	;        3
	    strmid mAlbumName,tmp,63,30	;        5
	    strmid mRelDate,tmp,93,4	;        6
	    prm=1,30
	    repeat 6
	     repeat prm.1,1
	      peek i,minfo_.prm,prm.1-cnt
	      if i=' ' {
	       poke minfo_.prm,prm.1-cnt,0
	      } else :break
	     loop
	     prm++
	     if prm=4 :prm++
	     if prm=6 :prm.1=4
	    loop
	   }
	  }
	 }
	 ; 自力でMidi情報を解析
	 if mFileType&TPEX_MID {
	  ; 曲情報の取得
	  bload mFilePath,prm,16
	  ;  (1) ヘッダを表す4バイト(文字列に直すと MThd )の確認
	  if prm=$6468544D {
	   ; (2) その他ヘッダ情報の取得
	   ; prm.1	/ その他ヘッダ情報のサイズ
	   ; prm.2	/ 前2バイト フォーマット
	   ;		/ 後2バイト トラック数
	   ; ※ 例えば 00 01 は $ 01 00 のように、1byteごとに逆順で
	   ; 　 変数に入っているため word, dword マクロで変換している
	   i =word(prm.2) :prm.2=prm.2>>16
	   ii=word(prm.2)
	   mFormat="MIDI(format-"+i+") "+ii+"トラック"
	   ; (3) トラックデータの取得
	   i=dword(prm.1)+8
	   ; i		/ トラックデータ開始位置
	   bload mFilePath,prm,16,i
	   if prm=$6B72544D {
	    i+=8
	    ii=dword(prm.1)
	    ; i		/ トラックデータの中身開始位置
	    ; ii	/ トラックデータの中身サイズ
	    bload mFilePath,tmp,ii,i
	    prm=0,0
	    ; prm	/ 解析中の位置
	    ; prm.1	/ 最後に解析したイベントのサイズ
	    repeat
	     ; デルタタイム
	     repeat 4
	      peek i,tmp,prm :prm++
	      if i&$80=0 :break
	     loop
	     ; イベント
	     peek i,tmp,prm :prm++
	     ;  可変長データ
	     if i&$F0=$F0 {
	      ;  メタイベント
	      if i=$FF {
	       peek i,tmp,prm :prm++
	       gosub get_delta
	       ; i	/ メタイベントの種類
	       ;	$02	/ 著作権表示
	       if i=2 :strmid mAuthor,tmp,prm,prm.1
	       ;	$03	/ 曲タイトル
	       if i=3 :strmid mName,tmp,prm,prm.1
	       ;	$01	/ 任意のテキスト
	       if i=1 :strmid mComment,tmp,prm,prm.1
	       ;	$2F	/ トラックの終端
	       if i=$2F :break
	      ;  SysExイベント
	      } else :gosub get_delta
	     ;  それ以外のデータ(MIDIイベントなど)
	     } else {
	      ; ランニングステータス未適用
	      if i&$80 {
	       prm.1=1
	       i=i>>8
	       if i!$C&(i!$D) :prm.1++
	      ; ランニングステータス適用
	      ; (イベントのサイズが一つ前と同じ)
	      } else :prm--
	     }
	     prm+=prm.1
	     if prm>=ii :break
	    loop
	   }
	  }
	 }
	 ; スクロール内容とメニュー項目を更新
	 gosub get_mscroll
	 tmenu "著作者: "+mAuthor,FNC_CLIP+IDX_CLIP_MINFO+1,hmMinfo
	 tmenu "タイトル: "+mName,FNC_CLIP+IDX_CLIP_MINFO+2,hmMinfo
	 tmenu "ファイル名: "+mFileName,FNC_CLIP+IDX_CLIP_MINFO+0,hmMinfo
	 return_ FR_DONE
	}

; ―――――――――――――――――――――――――――――――――――――
; 音楽の再生状態(と再生位置)を取得

	if funcid=FNC_GETSTATE {
	 if mStatus=ST_CLOSED :return_ ST_CLOSED
	 im=mStatus
	 mStatus=ST_CLOSED
	 ; ファイル種の確認
	 i=TPfromTPEX(mFileType)
	 ; 再生状態と再生中位置の取得
	 repeat
	  ; Windows MCI を利用
	  if type.i=PF_MCI {
	   ; 再生位置の取得
	   mci "status "+mci_alias+" position"
	   if mFileType&TPEX_CDA {
	    mPosition=stat-mci_cdatrackstart
	   } else :mPosition=stat
	   ; 再生状態の取得
	   if mDuration=0 :mStatus=ST_PLAYING :break
	   if mPosition>=mDuration :mStatus=ST_STOPPED :break
	   mci "status "+mci_alias+" mode"
	   if refstr="playing" :mStatus=ST_PLAYING :break
	   if refstr="stopped" {
	    if mci_cdapaused=0 :mStatus=ST_STOPPED :break
	   }
	   mStatus=ST_PAUSED :break
	  }
	  ; DirectX DirectShow を利用
	  if type.i=PF_DXS {
	   ; 再生位置の取得(MediaSeeking->GetCurrentPosition)
	   if mDuration=0 :mStatus=ST_PLAYING :break
	   i=0,0,0,0
	   prmex=pi
	   prm=pprmex,1,12,dxs_ms
	   ll_callfunc prm,4,pCallMethod
	   llconv mPosition,i
	   ; 再生状態の取得(IMediaControl->GetState)
	   prmex=500,pi
	   prm=pprmex,2,10,dxs_mc
	   ll_callfunc prm,4,pCallMethod
	   if i=1 :mStatus=ST_PAUSED	:break
	   ; 音楽の終わりは再生位置で判断する
	   if i=2 {
	    if mPosition>=mDuration :mStatus=ST_STOPPED :break
	    mStatus=ST_PLAYING	:break
	   }
	   break
	  }
	  ; 外部DLLを利用
	  if type.i=PF_DLL {
	   ; DDE
	   /*
	   if mFileType&TPEX_MID {
	    if dde_name="TMIDI" {
	     ; 曲情報の確認(書庫ファイル再生時対策)
	     dde_req "getplayfile" :int_ s
	     if im!dde_idx {
	      dde_idx=im
	      dde_req "gettitle "+im :mName=s
	      dde_req "getlength "+im :int_ s :mDuration=im
	      func=FNC_GETTAGINFO|FNC_AUTO+IDX_CUR :gosub *exec_func
	      scrLine+=scrAreaShow_FileInfoLine
	      script=scrAreaShow_FileInfo+script
	     }
	     ; 再生位置と状態の取得
	     dde_req "gettime" :int_ s :mPosition=im
	     dde_req "getstatus"
	     if s="play" :mStatus=ST_PLAYING :break
	     if s="pause":mStatus=ST_PAUSED :break
	     mStatus=ST_STOPPED :break
	    }
	    if dde_name="WFP" {
	     ; 再生状態の取得
	     dde_req "PlayStatus"
	     if s="Play" :mStatus=ST_PLAYING :break
	     if s="Pause":mStatus=ST_PAUSED :break
	     mStatus=ST_STOPPED :break
	    }
	    break
	   }
	   */
	   ; Vox.dll
	   if mFileType&TPEX_OGG {
	    dllprocp FNC_vox_GetCurrentTime,vox_id,1
	    mPosition=dllret
	    dllprocp FNC_vox_GetStatus,vox_id,1
	    if dllret=1 :mStatus=ST_PLAYING :break
	    if dllret=0&(mStatus!ST_PAUSED) :mStatus=ST_STOPPED :break
	    break
	   }
	   ; vbmp3.dll
	   if mFileType&TPEX_MP3 {
	    dllprocp FNC_vbmp3_getState,pi,1
	    mPosition=i*1000
	    mStatus=dllret+1
	    break
	   }
	   break
	  }
	  break
	 loop
	 ; プラグインなどに通知
	 if im!mStatus :gosub notify_mStatus
	 return_ mStatus
	}

; ―――――――――――――――――――――――――――――――――――――
; 再生リストの表示を更新

	if funcid=FNC_LIST_REFRESH {
	 funcret=FR_DONE
	 title "再生リストの表示を更新しています"+sep+prgtitles
	 gosub disable_allWnd
	 ; リストボックスの表示内容を再作成
	 if lReqRefresh|(func&FNC_ON) {
	  lReqRefresh=0
	  notesel list
	  notemax lNum
	  lLength=0
	  list_=""
	  ; 表示内容を取得
	  repeat lNum
	   await
	   noteget s,cnt
	   ; ※ 再生中の音楽のインデックスを追尾
	   if s=mFilePath :mFileIdx=cnt
	   getfname s
	   lLength+=im-stat+2
	   ; リストに表示できる文字長の限界に注意
	   if lLength>bufmax {
	    lLength-=im-stat+2
	    dialog langs.lgDlg_ErrorTooManyFiles,0,prgtitles
	    ; 以降の行を削除
	    repeat lNum-cnt,cnt
	     notedel lNum-cnt
	    loop
	    funcret=FR_ERR
	    break
	   }
	   list_+=refstr+"\n"
	  loop
	 }
	 ; 画面に反映する
	 gosub get_listobjid
	 if i!-1 {
	  gsel lWid
	  lsi_backup
	  objprm i,list_
	  lsi_restore i
	  gsel sWid
	 }
	 ; タイトルに反映する
	 title_ ""+lNum+" ファイル"+sep+prgtitles
	 gosub enable_allWnd
	 return_
	}

; ―――――――――――――――――――――――――――――――――――――
; 再生リストに(notedata(func&FNC_AUTO=0 なら funcopts))を追加
;	内部処理用
;	注意	画面を使用不可にする上、そのまま放置する
;		後に FNC_REFRESH でリストの表示を更新する必要がある

	if funcid=FNC_LIST_ADD {
	 gosub disable_allWnd
	 lReqRefresh=1
	 notesel list
	 ; ※ 選択中の音楽のインデックスを追尾
	 if lSelectedIdx!-1 {
	  noteget s,lSelectedIdx
	  instr funcopt,list,s+"\n",0
	 } else :funcopt=-1
	 tmp=""
	 if func&FNC_AUTO=0 {
	  strlen i,funcopts :sdim notedata,i+1
	  notedata=funcopts :funcopts=""
	 } else {
	  if func&FNC_STR=0 :funcopts=""
	 }
	 ; funcopt	/ 選択中の音楽の位置
	 ; notedata	/ 追加するファイル一覧
	 ; tmp		/ 追加するフォルダとリストファイル一覧
	 ; funcopts	/ (notedata)内ファイルの親フォルダ
	 repeat :await
	  if cnt {
	   ; 検索するフォルダの取得(ss)
	   notecut_ ss,tmp
	   if stat=0 :break
	   title ""+cnt+". "+ss
	   ; リストファイルとフォルダの判別
	   gettype ss
	   if stat=TPEX_XLT {
	    notesel notedata
	    noteload ss :funcopts=""
	    ; 簡易EXCELテンプレートファイル用フィルタ
	    wpeek i,notedata
	    if i=$CFD0 :continue
	    ; (↑ヘッダが$CFD0)
	    notesel list
	   } else {
	    ; ごみ箱の中身用フィルタ
	    strlen i,ss
	    strmid s,ss,3,8
	    if s="RECYCLER" :continue
	    ; (↑フォルダ名でチェック)
	    funcopts=ss+"\\"
	    dirlist notedata,funcopts+"*.*"
	   }
	  }
	  ; ファイルとフォルダの判別
	  repeat
	   notecut_ s,notedata
	   if stat=0 :break
	   s=funcopts+s
	   exist_ s
	   if stat=-1 {
	    if lSearchType&TPEX_DIR|(func&FNC_ON=0) :tmp+=s+"\n"
	    continue
	   } else {
	    ; ファイル種の確認
	    if func&FNC_ON {
	     gettype s
	     if stat=0 :continue	; 非対応
	     if stat&$FFFFF000!0 {	; 音楽ファイルでない
	      if stat=TPEX_XLT {	; リストファイル
	       if lSearchType&TPEX_XLT|(func&FNC_ON=0) :tmp+=s+"\n"
	      }
	      continue
	     } else {			; 音楽ファイル
	      if lSearchType&stat=0&(func&FNC_ON!0) :continue
	     }
	    }
	    ; ファイルの重複確認
	    instr i,list,s+"\n"
	    ; (1) 重複無し
	    if i=-1 {
	     noteadd s,lNum
	     lNum++
	    ; (2) 重複
	    } else {
	     ; 重複ファイルを最下行に移動するオプションの確認
	     if lDownDblItem=0 :continue
	     ; 重複ファイルを最下行に移動
	     s+="\n"
	     strlen ii,s
	     strlen iii,list
	     memcpy list,list,iii-i-ii,i,i+ii
	     poke list,iii-ii,s
	     poke list,iii,0
	     if funcopt>=0 {
	      if funcopt=i :funcopt=iii-ii-2 :lSelectedIdx=lNum-1 :else {
	       if funcopt>i :funcopt-=ii :lSelectedIdx--
	      }
	     }
	    }
	   }
	   await
	  loop
	 loop
	 sdim notedata,bufnd
	 return_ lNum
	}

; ―――――――――――――――――――――――――――――――――――――
; 再生リストにファイルを追加

	if funcid=FNC_LIST_ADD_FILE {
	 gosub disable_allWnd
	 ; ファイルが指定されていなければダイアログを表示
	 if func&FNC_STR=0 {
	  ; ファイル拡張子フィルタ生成
	  s="読み込める全ての音楽ファイル|"
	  sss=""
	  i=lgTP
	  repeat TP_PLAYABLE
	   if types.cnt!"" {
	    convert ss,types.cnt,";*."," "
	    ; カッコ ( ) を無視
	    strlen ii,ss :prm=0
	    repeat
	     instr iii,ss,"(",prm
	     if iii=-1 {
	      break
	     } else {
	      prm+=iii
	      instr iii,ss,")",prm
	      iii++
	      ii-=iii
	      strmid tmp,ss,prm+iii,ii-prm
	      strmid ss,ss,0,prm
	      ss+=tmp
	     }
	    loop
	    ; フィルタに追加
	    sss+=langs.i+"|*."+ss+"|"
	    s+="*."+ss+";"
	   }
	   i++
	  loop
	  s+="|"+sss
	  ; フィルタの | を全て (null) に変換
	  strlen i,s
	  repeat i
	   peek ii,s,cnt
	   if ii='|' :poke s,cnt,0
	  loop
	  ; GetOpenFileNameA
	  tmp=""
	  tmp2=""
	  ss=lCurDir
	  sss="音楽ファイルを開く"
	  prm=76,bmscr.13,bmscr.14,ps,0,0,1,ptmp2,bufmax-1,ptmp,bufmax-1,pss,psss,$81204,0,0,0,0,0
	  dllprocp FNC_GetOpenFileNameA,pprm,1
	  if dllret {
	   i=(prm.14>>16)&$FFFF
	   ; 一つのファイルのみ選択された
	   if i {
	    ; tmp2	/ 選択されたファイルのフルパス(と拡張子)
	    ; tmp	/ 選択されたファイルの名前
	    strlen i,tmp2
	    strlen ii,tmp
	    strmid lCurdir,tmp2,0,i-ii
	    funcopts=tmp2
	   ; 複数のファイルが選択された
	   } else {
	    ; tmp2	/ 選択されたファイルが入っていたフォルダのフルパス
	    peek lCurdir,tmp2
	    strlen ii,lCurdir
	    lCurdir+="\\"
	    ;		/ と、選択されたファイルの名前(複数)
	    sdim notedata,bufmax
	    i=0 :ii++
	    repeat ,ii
	     ; i	/ notedata(コピー先)の文字長
	     ; ii	/ tmp2(コピー元)のファイル名開始オフセット
	     peek iii,tmp2,cnt
	     if iii=0 {
	      prm=cnt-ii; ファイル名一つ分の文字長
	      memcpy notedata,tmp2,prm,i,ii	; ファイル名コピー
	      wpoke notedata,i+prm,2573		; '\n' 書き込み
	      peek iii,tmp2,cnt+1
	      if iii=0 :wpoke notedata,i+prm+2,0 :break
	      i+=prm+2
	      ii=cnt+1
	     }
	    loop
	    ; notedata	/ 選択されたファイルの名前(複数)
	    funcopts=lCurdir
	    func=FNC_LIST_ADD|FNC_AUTO|FNC_STR	:gosub *exec_func
	    func=FNC_LIST_REFRESH		:gosub *exec_func
	    return_
	   }
	  } else :gosub enable_allWnd :return_ FR_ERR
	 }
	 ; funcopts	/ リストに追加するファイルのフルパス
	 funcret=FR_DONE
	 notesel list
	 getfname funcopts
	 ; ファイルの重複確認
	 instr i,list,funcopts+"\n"
	 ; (1) 重複無し
	 if i=-1 {
	  ; リストに表示できる文字長の限界に注意
	  lLength+=im-stat+2
	  if lLength>bufmax {
	   lLength-=im-stat+2
	   dialog langs.lgDlg_ErrorTooManyFiles,0,prgtitles
	   funcret=FR_ERR
	  } else {
	   ; フルパス情報とファイル名情報
	   list+=funcopts+"\n"
	   list_+=refstr+"\n"
 	   ; 画面に反映する
	   gosub get_listobjid
	   if i!-1 {
	    gsel lWid
	    lsi_backup
	    s=refstr :objsend i,lisLB*LB_ADDSTRING+(lisCB*CB_ADDSTRING),0,s,0
	    lsi_restore i
	    gsel sWid
	   }
	   lNum++
	  }
	 ; (2) 重複
	 } else {
	  ; 重複ファイルを最下行に移動するオプションの確認
	  if lDownDblItem {
	   ; 重複ファイルが存在する行数を取得
	   if i=0 :prm=0 :else {
	    ii=0 :prm=-1
	    repeat i,1
	     instr iii,list,"\n",ii
	     if iii=-1 :break
	     ii+=iii+2
	     if ii>=i :prm=cnt :break
	    loop
	   }
	   ; 重複ファイルを最下行に移動
	   ; ※ 再生中の音楽のインデックスを追尾
	   if prm<mFileIdx :mFileIdx-- :else {
	    if prm=mFileIdx :mFileIdx=lNum-1
	   }
	   ; ※ 選択中の音楽のインデックスを追尾
	   if prm<lSelectedIdx :lSelectedIdx-- :else {
	    if prm=lSelectedIdx :lSelectedIdx=lNum-1
	   }
	   ; フルパス情報
	   notedel prm
	   noteadd funcopts,lNum-1
	   ; ファイル名情報
	   notesel list_
	   notedel prm
	   noteadd refstr,lNum-1
 	   ; 画面に反映する
	   gosub get_listobjid
	   if i!-1 {
	    gsel lWid
	    lsi_backup
	    ; リストボックスの表示
	    ii=0 :objsend i,lisLB*LB_DELETESTRING+(lisCB*CB_DELETESTRING),prm,ii,0
	    s=refstr :objsend i,lisLB*LB_ADDSTRING+(lisCB*CB_ADDSTRING),0,s,0
	    lsi_restore i
	    gsel sWid
	   }
	  }
	 }
	 ; タイトルに反映する
	 title_ ""+lNum+" ファイル"+sep+prgtitles
	 gosub enable_allWnd
	 return_
	}

; ―――――――――――――――――――――――――――――――――――――
; 再生リストにフォルダ内ファイルを追加

	if funcid=FNC_LIST_ADD_FOLDER {
	 ; フォルダが指定されていなければダイアログを表示
	 if func&FNC_STR=0 {
	  gosub disable_allWnd
	  ; 初期フォルダを指定するためのコールバック関数を準備
	  if pCallbackFunc=0 {
	   func=FNC_LOADLIB|IDX_LOAD_COM :gosub *exec_func
	  }
	  ; ダイアログの表示
	  s=""
	  ss=langs.lgDlg_Folder
	  tmp=lCurdir
	  prmex=ptmp,pfunc.FNC_SendMessageA
	  prm=bmscr.13,0,ps,pss,3,pCallbackFunc,pprmex,0
	  dllprocp FNC_SHBrowseForFolderA,pprm,1
	  if dllret=0 :gosub enable_allWnd :return_ FR_ERR
	  ; PIDL からパスを取得
	  prm=dllret,ps
	  dllprocp FNC_SHGetPathFromIDListA,prm,2
	  funcopts=s
	  ; PIDL に使用されたメモリ領域の解放
	  prmex=prm
	  ;  IMalloc インターフェースの取得
	  dllprocp FNC_SHGetMalloc,pi,1
	  ;  IMalloc->Free メソッドによりメモリ領域を解放
	  prm=pprmex,1,5,i
	  ll_callfunc prm,4,pCallMethod
	  ;  IMalloc インターフェースを解放
	  ri i
	 }
	 ; リストにフォルダ内ファイルを追加
	 strmid s,funcopts,-1,1
	 if s!"\\" :funcopts+="\\"
	 dirlist notedata,funcopts+"*.*"
	 lCurdir=funcopts
	 func=FNC_LIST_ADD|FNC_AUTO|FNC_STR|FNC_ON :gosub *exec_func
	 func=FNC_LIST_REFRESH :gosub *exec_func
	 return_
	}

; ―――――――――――――――――――――――――――――――――――――
; 再生リストの並び替え

	if funcid=FNC_LIST_SORT {
	 gosub disable_allWnd
	 ; ※ 選択中の音楽のインデックスを追尾 (1)
	 if lSelectedIdx!-1 {
	  notesel list
	  noteget s,lSelectedIdx
	 }
	 strsort list
	 ; ※ 選択中の音楽のインデックスを追尾 (2)
	 if lSelectedIdx!-1 {
	  notenum_ s,list :lSelectedIdx=stat
	 }
	 lReqRefresh=1
	 func=FNC_LIST_REFRESH :gosub *exec_func
	 title_ "リスト項目を名前順に並び替えました"+sep+prgtitles
	 return_ FR_DONE
	}

; ―――――――――――――――――――――――――――――――――――――
; 再生リスト中のファイルの存在確認

	if funcid=FNC_LIST_CHECK {
	 gosub disable_allWnd
	 notesel list
	 prm=0,0
	 ii=lNum
	 repeat lNum,1
	  i=cnt*100/ii :if i!prm :prm=i :title ""+prm+"%"
	  i=ii-cnt
	  noteget s,i
	  gettype s
	  if stat&TPEX_CDA :continue
	  exist_ s
	  if stat!1 {
	   prm.1++
	   notedel i
	   ; ※ 選択中の音楽のインデックスを追尾
	   if i<=lSelectedIdx :lSelectedIdx--
	   lNum--
	   continue
	  }
	 loop
	 if prm.1 {
	  lReqRefresh=1
	  func=FNC_LIST_REFRESH :gosub *exec_func
	 } else :gosub enable_allWnd
	 title_ "存在しない音楽ファイルを再生リストから除きました"+sep+prgtitles
	 return_ FR_DONE
	}

; ―――――――――――――――――――――――――――――――――――――
; リスト中の項目を削除

	if funcid=FNC_LIST_CLEAR {
	 ; 全項目を削除
	 if func&FNC_ALL {
	  gosub disable_allWnd
	  if func&FNC_AUTO=0 {
	   dialog langs.lgDlg_ConfirmClearAll,2,prgtitles
	   if stat=7 :gosub enable_allWnd :return_ FR_ERR
	  }
	  list=""
	  lReqRefresh=1
	  func=FNC_LIST_REFRESH :gosub *exec_func
	  return_ FR_DONE
	 }
	 ; 一項目を削除
	 ;  削除対象を取得
	 gosub get_mpath
	 if funcopt=-1 :return_ FR_ERR
	 ;  削除
	 ;   フルパス情報
	 notesel list
	 notedel funcopt
	 ;   ファイル名情報
	 notesel list_
	 notedel funcopt
	 ; ※ 再生中の音楽のインデックスを追尾
	 if funcopt<=mFileIdx :mFileIdx--
	 ; ※ 選択中の音楽のインデックスを追尾
	 if funcopt<lSelectedIdx|(funcopt+1=lNum) :lSelectedIdx--
	 lNum--
	 getfname funcopts
	 lLength-=im-stat+2
	 ;  画面に反映する
	 gosub get_listobjid
	 if i!-1 {
	  gsel lWid
	  lsi_backup
	  prm=0 :objsend i,lisLB*LB_DELETESTRING+(lisCB*CB_DELETESTRING),funcopt,prm,0
	  lsi_restore i
	  gsel sWid
	 }
	 ;  タイトルに反映する
	 title_ ""+lNum+" ファイル"+sep+prgtitles
	 return FR_DONE
	}

; ―――――――――――――――――――――――――――――――――――――
; 再生リスト中の音楽ファイルをごみ箱に廃棄

	if funcid=FNC_LIST_DELETE {
	 ; 削除対象を取得
	 gosub get_mpath
	 if funcopt=-1 :return_ FR_ERR
	 ; ファイル種の確認
	 gettype funcopts
	 if stat&TPEX_CDA :return_ FR_ERR
	 ; 削除
	 gosub disable_allWnd
	 exist_ funcopts
	 if stat>0 {
	  convert s,langs.lgDlg_ConfirmDelete,funcopts,"%file%"
	  dialog s,2,prgtitles
	  if stat=6 {
	   ; s の内容を一度空にしておかないと誤動作を起こす
	   memset s,0,szs
	   i=0 :getptr pi,i
	   s=funcopts
	   prm=hwProcess,3,ps,0,$50,pi,0,0
	   dllprocp FNC_SHFileOperationA,pprm,1
	  } else :dllret=1
	 } else :dllret=0
	 ; 成功
	 if dllret=0 {
	  func=FNC_LIST_CLEAR+funcopt :gosub *exec_func
	  funcret=FR_DONE
	 } else :funcret=FR_ERR
	 gosub enable_allWnd
	 return_
	}

; ―――――――――――――――――――――――――――――――――――――
; 再生リスト中の音楽ファイルの名前を変更

	if funcid=FNC_LIST_RENAME {
	 ; 変名対象を取得
	 gosub get_mpath
	 if funcopt=-1 :return_ FR_ERR
	 ; ファイル種の確認
	 gettype funcopts
	 if stat&TPEX_CDA :return_ FR_ERR
	 ; 変名対象の情報を保存
	 getfname funcopts
	 lEditingFrom=refstr
	 lEditingIdx=funcopt
	 strmid lEditingDir,funcopts,0,stat
	 ; 変名画面表示
	 funcopts=lEditingFrom
	 func=FNC_OPEN_WND|FNC_ON+widInfo+IDX_WND_RENAME :gosub *exec_func
	 ; ファイル名の変更
	 if funcopts!"" {
	  gosub disable_allWnd
	  ; s, ss の内容を一度空にしておかないと誤動作を起こす
	  memset s,0,szs
	  memset ss,0,szss
	  s=lEditingDir+lEditingFrom
	  ss=lEditingDir+funcopts
	  prm=hwProcess,4,ps,pss,$50,pi,0,0
	  dllprocp FNC_SHFileOperationA,pprm,1
	  ; 成功
	  if dllret=0 {
	   ; フルパス情報
	   notesel list
	   notedel lEditingIdx
	   noteadd ss,lEditingIdx
	   ; ファイル名情報
	   notesel list_
	   notedel lEditingIdx
	   noteadd funcopts,lEditingIdx
	   ; 画面に反映する
	   gosub get_listobjid
	   if i!-1 {
	    gsel lWid
	    lsi_backup
	    prm=0 :objsend i,lisLB*LB_DELETESTRING+(lisCB*CB_DELETESTRING),lEditingIdx,prm,0
	    objsend i,lisLB*LB_INSERTSTRING+(lisCB*CB_INSERTSTRING),lEditingIdx,funcopts,0
	    lsi_restore i
	    gsel sWid
	   }
	  }
	  gosub enable_allWnd
	 }
	 return_ FR_DONE
	}

; ―――――――――――――――――――――――――――――――――――――
; 再生リスト中の項目を一つ上に移動

	if funcid=FNC_LIST_UP {
	 ; 移動対象を取得
	 gosub get_mpath
	 if funcopt=-1 :return_ FR_ERR
	 ; 移動
	 ;  フルパス情報
	 notesel list
	 notedel funcopt
	 ; ※ 再生中の音楽のインデックスを追尾
	 if funcopt=mFileIdx {
	  if funcopt=0 :mFileIdx=lNum-1 :else {
	   mFileIdx--
	  }
	 } else {
	  if funcopt-1=mFileIdx :mFileIdx++
	 }
	 ; ※ 選択中の音楽のインデックスを追尾
	 if funcopt=lSelectedIdx {
	  if funcopt=0 :lSelectedIdx=lNum-1 :else {
	   lSelectedIdx--
	  }
	 } else {
	  if funcopt-1=lSelectedIdx :lSelectedIdx++
	 }
	 noteadd funcopts,funcopt-1
	 getfname funcopts
	 ;  ファイル名情報
	 notesel list_
	 notedel funcopt
	 noteadd refstr,funcopt-1
	 ; 画面に反映する
	 gosub get_listobjid
	 if i!-1 {
	  gsel lWid
	  lsi_backup
	  prm=0 :objsend i,lisLB*LB_DELETESTRING+(lisCB*CB_DELETESTRING),funcopt,prm,0
	  s=refstr :objsend i,lisLB*LB_INSERTSTRING+(lisCB*CB_INSERTSTRING),funcopt-1,s,0
	  lsi_restore i
	  gsel sWid
	 }
	 return_ FR_DONE
	}

; ―――――――――――――――――――――――――――――――――――――
; 再生リスト中の項目を一つ下に移動

	if funcid=FNC_LIST_DOWN {
	 ; 移動対象を取得
	 gosub get_mpath
	 if funcopt=-1 :return_ FR_ERR
	 ; 最下行の項目を一番上に移動
	 if funcopt+1=lNum {
	  ; 移動
	  ;  フルパス情報
	  notesel list
	  notedel funcopt
	  ; ※ 再生中の音楽のインデックスを追尾
	  if funcopt=mFileIdx :mFileIdx=0 :else :mFileIdx++
	  ; ※ 選択中の音楽のインデックスを追尾
	  if funcopt=lSelectedIdx :lSelectedIdx=0 :else :lSelectedIdx++
	  noteadd funcopts,0
	  getfname funcopts
	  ;  ファイル名情報
	  notesel list_
	  notedel funcopt
	  noteadd refstr,0
	  ; 画面に反映する
	  gosub get_listobjid
	  if i!-1 {
	   gsel lWid
	   lsi_backup
	   prm=0 :objsend i,lisLB*LB_DELETESTRING+(lisCB*CB_DELETESTRING),funcopt,prm,0
	   s=refstr :objsend i,lisLB*LB_INSERTSTRING+(lisCB*CB_INSERTSTRING),0,s,0
	   lsi_restore i
	   gsel sWid
	  }
	 ; 上記以外は「指定された項目の一つ下を上に移動する」と考える
	 } else {
	  func=FNC_LIST_UP+funcopt+1 :gosub *exec_func
	 }
	 return_ FR_DONE
	}

; ―――――――――――――――――――――――――――――――――――――
; リストファイルを読み込む

	if funcid=FNC_XLT_LOAD {
	 if func&FNC_STR=0 {
	  ; (1) お気に入りリスト
	  if func&FNC_AUTO {
	   ; お気に入りの一覧を更新する
	   if func&FNC_REFRESH {
	    funcret=FR_DONE
	    ; 既存の一覧を削除
	    notemax_ fXLT
	    repeat stat
	     dmenu hmFavSaveSub,FNCM_XLT_SAVE+cnt
	     dmenu hmFav,FNCM_XLT_LOAD+cnt
	    loop
	    ; 新しい一覧を作成
	    dirlist fXLT,datdir+"*.xlt",1
	    notesel fXLT :notemax i
	    if i=0 :return_
	    repeat i
	     noteget s,cnt
	     strlen ii,s :strmid ss,s,0,ii-4
	     imenu ss,FNCM_XLT_SAVE+cnt,0,hmFavSaveSub,cnt+1
	     imenu ss,FNCM_XLT_LOAD+cnt,0,hmFav,cnt+3
	    loop
	    return_
	   }
	   notesel fXLT
	   noteget funcopts,funcopt
	   funcopts=datdir+funcopts
	  ; (2) 一般のリストファイル
	  } else {
	   gosub disable_allWnd
	   dialog "xlt",16,"リストファイル"
	   if stat=0 :gosub enable_allWnd :return_ FR_ERR
	   gosub enable_allWnd
	   funcopts=refstr
	  }
	 }
	 ;	funcopts	/ 読み込むリストファイル
	 exist_ funcopts
	 if stat>0 {
	  if lClearOnLoad :list="" :lNum=0
	  sdim notedata,bufnd
	  notesel notedata
	  noteload funcopts
	  func=FNC_LIST_ADD|FNC_AUTO|FNC_ON :gosub *exec_func
	  func=FNC_LIST_REFRESH :gosub *exec_func
	 } else :funcret=FR_ERR
	 return_
	}

; ―――――――――――――――――――――――――――――――――――――
; 再生リストをリストファイルとして保存

	if funcid=FNC_XLT_SAVE {
	 if func&FNC_STR=0 {
	  ; (1) お気に入りリスト
	  if func&FNC_AUTO {
	   ; お気に入りへの新規登録
	   if func&FNC_ON {
	    funcopts=defxlt
	    func=FNC_OPEN_WND|FNC_ON+widInfo+IDX_WND_FAVORITE :gosub *exec_func
	    if funcopts="" :return_ FR_ERR
	    func=FNC_AUTO
	   ; お気に入りの上書き保存
	   } else {
	    notesel fXLT
	    noteget funcopts,funcopt
	   }
	   funcopts=datdir+funcopts
	  ; (2) 一般のリストファイル
	  } else {
	   gosub disable_allWnd
	   dialog "xlt",17,"リストファイル"
	   if stat=0 :gosub enable_allWnd :return_ FR_ERR
	   gosub enable_allWnd
	   funcopts=refstr
	  }
	 }
	 gettype funcopts
	 if stat&TPEX_XLT=0 :funcopts+=".xlt"
	 exist_ funcopts
	 if stat=1 {
	  convert s,langs.lgDlg_ConfirmOverwrite,funcopts,"%file%"
	  gosub disable_allWnd
	  dialog s,2,prgtitles
	  if stat=7 :gosub enable_allWnd :return_ FR_ERR
	  gosub enable_allWnd
	 }
	 notesel list
	 skiperr 1
	 notesave funcopts :i=err
	 skiperr 0
	 if i {
	  convert s,langs.lgDlg_ErrorOnSave,funcopts,"%file%"
	  gosub disable_allWnd
	  dialog s,1,prgtitles
	  gosub enable_allWnd
	  return_ FR_ERR
	 }
	 ; お気に入りメニューの更新
	 if func&FNC_AUTO :func=FNC_XLT_LOAD|FNC_AUTO|FNC_REFRESH :gosub *exec_func
	 return_ FR_DONE
	}

; ―――――――――――――――――――――――――――――――――――――
; スキン変数の値を編集

	if funcid=FNC_XSP_MODIFY {
	 ; 全ての変数値を初期化
	 if func&FNC_OFF {
	  strlen i,sFileName
	  strmid s,sFileName,0,i-4
	  s=skndir+s+".xsv"
	  exist_ s
	  if stat!1 :return_ FR_ERR
	  delete s
	  func=FNC_XSP_LOAD|FNC_AUTO :gosub *exec_func
	  return_ FR_DONE	  
	 }
	 ; 変数値を文字列で指定
	 if func&FNC_STR {
	  if funcopt>=snVar :return_ FR_ERR
	  i=funcopt
	  sVar.i=funcopts
	 ; ダイアログを表示して変数値をユーザーに尋ねる
	 } else {
	  if func&FNC_AUTO=0 {
	   i=funcopt
	   sEditingIdx=i
	   if sVar_type.i=SV_COLOR {
	    gosub disable_allWnd
	    dialog "",33
	    if stat!1 :gosub enable_allWnd :return_ FR_ERR
	    sVar.i=""+rval+"*"+gval+"*"+bval
	    gosub enable_allWnd
	   } else {
	    if sVar_type.i=SV_FONT {
	     gosub disable_allWnd
	     prm=bmscr.38,60,pprmex
	     dllprocp FNC_GetObjectA,prm,3
	     prm=60,bmscr.13,0,pprmex,0,$41,bmscr.40,0,0,0,0,0,$2000
	     dllprocp FNC_ChooseFontA,pprm,1
	     if dllret=0 :gosub enable_allWnd :return_ FR_ERR
	     memcpy s,prmex,32,,28
	     prm=prm.4/10
	     if prmex.4>400 :ii=1 :else :ii=0
	     if (prmex.5&$FF)!0 :ii+=2
	     sVar.i=s+"*"+prm+"*"+ii
	     gosub enable_allWnd
	    } else {
	     ; スキン変数入力画面表示
	     if sVar_type.i=SV_LIST :funcopts=sVar_listdsc.i :else :funcopts=sVar.i
	     func=FNC_OPEN_WND|FNC_ON+widInfo+IDX_WND_SKV :gosub *exec_func
	     if funcopts="" :return_ FR_ERR
	     if funcopts="(null)" :funcopts=""
	     ; スキン変数の値を変更
	     i=sEditingIdx
	     sVar.i=funcopts
	    }
	   }
	  }
	 }
	 ; スキン変数の値を保存
	 strlen i,sFileName
	 strmid s,sFileName,0,i-4
	 s=skndir+s+".xsv"
	 tmp=""
	 repeat snVar
	  tmp+=sVar.cnt+"\n"
	 loop
	 strlen i,tmp
	 bsave s,tmp,i
	 ; スキンの再読み込み
	 func=FNC_XSP_LOAD|FNC_AUTO :gosub *exec_func
	 return_ FR_DONE
	}

; ―――――――――――――――――――――――――――――――――――――
; スキンを読み込む

	if funcid=FNC_XSP_LOAD {
	 ; スキンの一覧を更新する
	 if func&FNC_REFRESH {
	  funcret=FR_DONE
	  ; 既存の一覧を削除
	  notemax_ fXSP
	  repeat stat :dmenu hmSkin,FNC_XSP_LOAD+cnt :loop
	  ; 新しい一覧を作成
	  dirlist fXSP,skndir+"*.xsp",1
	  notesel fXSP :notemax i
	  if i=0 :return_
	  repeat i
	   noteget s,cnt
	   strlen ii,s :strmid ss,s,0,ii-4
	   imenu ss,FNC_XSP_LOAD+cnt,0,hmSkin,cnt+1
	   if s=sFileName {
	    mii.1=1 :mii.3=8
	    setmii hmSkin,FNC_XSP_LOAD+cnt
	   }
	  loop
	  return_
	 }
	 ; 読み込むスキンを取得する
	 notesel fXSP :notemax i
	 if func&FNC_AUTO :funcopts=sFileName :else {
	  if func&FNC_STR=0 :noteget funcopts,funcopt
	 }
	 ; メニューのチェックを更新
	 mii.1=1
	 repeat i
	  noteget s,cnt
	  if s=sFileName :mii.3=0 :setmii hmSkin,FNC_XSP_LOAD+cnt
	  if s=funcopts :mii.3=8 :setmii hmSkin,FNC_XSP_LOAD+cnt
	 loop
	 ; 読み込む
	 repeat 2
	  s=skndir+funcopts
	  exist_ s
	  if stat!1 {
	   if cnt=0 :funcopts=defxsp :continue
	   gosub enable_allWnd
	   dialog "初期設定スキンが見つからないためプレイヤーを終了します。\nプレイヤー本体を公式サイトからダウンロードしてインストールし直して下さい。",1,prgtitles
	   goto *exit
	  }
	 loop
	 bload s,tmp
	 poke tmp,strsize,0	; 文字列の終わりを示すコードを付加
	 strsel tmp
	 ; スクリプトのバージョン確認
	 strget i,".SkinScript.ver"
	 if i>vscript|(i=0) {
	  convert sss,langs.lgDlg_ErrorFormat,"スキン","%format%"
	  convert ss,sss,s,"%file%"
	  convert s,ss,"","%confirm%"
	  gosub disable_allWnd
	  dialog s,0,prgtitles
	  gosub enable_allWnd
	  return_ FR_ERR
	 }
	 sFileName=funcopts
	 ; スクリプトの内容を分割
	 ;  (1) 一般的なイベント
	 strgeta_xsp scrAreaInit		,"Initialize"
	 strgeta_xsp scrAreaMain		,"MainLoop"
	 strgeta_xsp scrAreaShow_Mode		,"ChangeMode"
	 strgeta_xsp scrAreaShow_ModeEx		,"ChangeRepMode"
	 strgeta_xsp scrAreaShow_FileInfo	,"ChangeFile"
	 strgeta_xsp scrAreaShow_Tiphelp	,"ShowTiphelp"
	 strgeta_xsp scrAreaDisp_ListArea	,"ShowList"
	 strgeta_xsp scrAreaHide_ListArea	,"HideList"
	 ;  (2) ユーザー定義イベント
	 i=0 :snAreaUser=0	; 数と長さを調査
	 repeat ,1
	  strgeta funcopts,"UserDef"+cnt
	  if stat=0 :snAreaUser=cnt :break
	  if i<stat :i=stat
	 loop
	 if snAreaUser {
	  sdim scrAreaUser,i+3,snAreaUser
	  dim scrAreaUserLine,snAreaUser
	  i=0
	  repeat snAreaUser	; 実際に取得
	   i++
	   strgeta scrAreaUser.cnt,"UserDef"+i
	   notemax_ scrAreaUser.cnt
	   scrAreaUserLine.cnt=stat
	  loop
	 }
	 ; 画面情報を初期化
	 repeat snObj			; オブジェクト情報(cf. _init_var.as)
	  obj.cnt=-1
	  obj.cnt.2=-1
	  if obj.i.1 {
	   dllprocp FNC_DeleteObject,obj.i.1,1
	   obj.cnt.1=0
	  }
	 loop
	 repeat snChk			; チェックボックス情報
	  chkid.cnt=-1
	 loop
	 if wi.widMain|wi.widRegion {
	  snObj=0			; 設置オブジェクト数
	  snChk=0			;
	  if dispMainWnd&2=0 {		; 現在の画面位置を保存
	   ginfo 2
	   MainWndX=prmx :MainWndY=prmy
	  } else :gosub open_sWid
	  gsel sWid,-1
	  if sWid=widRegion {		; 不定形ウィンドウを四角形に戻す
	   palcolor 255
	   boxf
	   color 0,0,0
	   regmake
	  }
	  cls				; オブジェクト消去
	  hwMainWnd=0			; メイン画面ハンドル
	  hwList=0			; メイン画面リストハンドル
	  dispListArea=0		; リスト領域は最初隠してある	  
	 }
	 if hwListSub {			; リスト画面を隠す
	  func=FNC_OPEN_WND|FNC_OFF+widList :gosub *exec_func
	 }
	 if wi.widBuffer :gsel widBuffer :boxf
	 ; スキン変数関連のメニュー項目を消去
	 repeat snVar :dmenu hmSkinSubModify,FNC_XSP_MODIFY+cnt :loop
	 ; スキン情報を取得
	 strget sAuthor,".SkinScript.auth"	; 著作者
	 strget sName,".SkinScript.titl"	; タイトル
	 strget sComment,".SkinScript.comm"	; コメント
	 strget sScrollStep,".Scroll.widt"	; スクロール文字列を一度に動かす幅
	 strget sScrollWidth,".ScrollArea.widt"	; スクロール領域(幅)
	 strget sDragX,".Window.drag.x"		; ドラッグ領域	(開始Ｘ座標)
	 strget sDragY,".Window.drag.y"		; 〃		(開始Ｙ座標)
	 strget sDragWidth,".Window.drag.widt"	; 〃		(幅)
	 strget sDragHeight,".Window.drag.heig"	; 〃		(高さ)
	 strget sSeekX,".Window.seek.x"		; シークバー領域(開始Ｘ座標)
	 strget sSeekY,".Window.seek.y"		; 〃		(開始Ｙ座標)
	 strget sSeekWidth,".Window.seek.widt"	; 〃		(幅)
	 strget sSeekHeight,".Window.seek.heig"	; 〃		(高さ)
	 strget sSeekDirection,".Window.seek.direct"; 〃	(向き)
	 strget MainWndWidth,".Window.widt"	; メイン画面	(幅)
	 strget MainWndHeight,".Window.heig"	; 〃		(高さ)
	 strget ListAreaWidth,".List.widt"	; リスト領域	(幅)
	 strget ListAreaHeight,".List.heig"	; 〃		(高さ)
	 strget s,".Window.type"		; メイン画面の種類
	 ; メイン画面の作成
	 ;  (1) 不定形ウィンドウ
	 if s="region" {
	  if wi.widRegion=0 {
	   bgscr widRegion,640,480,2,dispx,dispy
	   title prgtitles
	  }
	  gsel widRegion
	  strget s,".Window.img" :s=skndir+s
	  existex s
	  if stat>0 {
	   gosub gsel_widBuffer
	   picload s,1
	   bload s,ss,64	; 画像の大きさを調べる
	   wpeek prm,ss,0
	   if prm=19778 {	; (BMPヘッダ "BM" の確認)
	    wpeek prm.3,ss,$12	; 幅
	    wpeek prm.4,ss,$16	; 高さ
	   } else :prm.3=640,480
	   pget 0,0		; 画像左上の色を調べる
	   prm=rval,gval,bval	; R,G,B
	   gsel widRegion
	   redraw 2
	   gcopy widBuffer,0,0,prm.3,prm.4
	   strget i,".Window.trans.r" :if stat :prm  =i
	   strget i,".Window.trans.g" :if stat :prm.1=i
	   strget i,".Window.trans.b" :if stat :prm.2=i
	   color prm,prm.1,prm.2
	   regmake
	   color 0,0,0
	   redraw 1
	  }
	  sWid=widRegion
	 ;  (2) 枠付きウィンドウ
	 } else {
	  gsel widMain
	  if wi.widMain=0 :title prgtitles
	  sWid=widMain
	 }
	 ; 画面情報の更新
	 width MainWndWidth,MainWndHeight,MainWndX,MainWndY
	 mref bmscr,67
	 hwMainWnd=bmscr.13
	 objmode 2,1
	 ;  (*) 初めて使用するウィンドウ
	 i=sWid
	 if wi.i=0 {
	  wi.i=1
	  ; メッセージ取得設定
	  if i=widRegion :gm_setwndproc hwMainWnd
	  gm_setmessage hwMainWnd,WM_LBUTTONDOWN; 左クリックの取得
	  gm_setmessage hwMainWnd,WM_DROPFILES	; ドラッグ＆ドロップの取得
	  prm=hwMainWnd,1			; ドラッグ＆ドロップの許可
	  dllprocp FNC_DragAcceptFiles,prm,2
	  ; ウィンドウスタイルの設定
	  ; (システムメニューを表示)
	  if i=widRegion {
	   prm.1=-16
	   dllprocp FNC_GetWindowLongA,prm,2
	   prm.2=dllret|$80000
	   dllprocp FNC_SetWindowLongA,prm,3
	  }
	 }
	 strget s,".List.type"			; リストの種類
	 repeat
	  if s="normal" :sListArea=0 :break
	  if s="scroll" :sListArea=1 :break
	  sListArea=2 :break
	 loop
	 strget snVar,".Var.num"		; スキン変数の数
	 if snVar>0 {
	  ; スキン変数ファイルを読み込む
	  strlen i,sFileName
	  strmid s,sFileName,0,i-4
	  s=skndir+s+".xsv"
	  exist_ s
	  if stat=1 {
	   notesel funcopts
	   noteload s
	   i=1
	  } else :i=0
	  ; スキン変数の初期値代入と編集用メニュー生成
	  repeat snVar
	   strget sVar_type.cnt,".Var."+cnt+".type"	; 種別
	   strget s,".Var."+cnt+".list"			; 内容選択肢一覧
	   strget ss,".Var."+cnt+".list+"		; 内容選択肢説明一覧
	   convert sVar_list.cnt,s,"\n","<BR>"
	   if ss="" {
	    sVar_listdsc.cnt=sVar_list.cnt
	   } else {
	    convert sVar_listdsc.cnt,ss,"\n","<BR>"
	   }
	   strget sVar_dsc.cnt,".Var."+cnt+".comm"	; 内容説明
	   if i :noteget sVar.cnt,cnt :else {
	    strget sVar.cnt,".Var."+cnt+".default"	; 標準値
	   }
	   if sVar_dsc.cnt!"" {
	    imenu sVar_dsc.cnt,FNC_XSP_MODIFY+cnt,0,hmSkinSubModify,cnt+1
	   }
	  loop
	  mii.3=0
	 } else :mii.3=3
	 mii.1=1
	 notemax_ fXSP
	 setmii hmSkin,stat+4,1
	 ; 言語ファイルを読み込む
	 strget funcopts,".XmsFile"
	 if funcopts="" :funcopts=defxms
	 if funcopts!sLanguage :func=FNC_XMS_LOAD|FNC_STR :gosub *exec_func
	 ; メニューの更新
	 tmenu "著作者: "+sAuthor,FNC_CLIP+IDX_CLIP_SINFO+1,hmSkinSub
	 tmenu "タイトル: "+sName,FNC_CLIP+IDX_CLIP_SINFO+2,hmSkinSub
	 tmenu "コメント: "+sComment,FNC_CLIP+IDX_CLIP_SINFO+3,hmSkinSub
	 ; スクリプトの実行を準備
	 scrLine+=scrAreaInitLine+1
	 script=scrAreaInit+"!!!init=xsp\n"+script
	 return_ FR_DONE
	}

; ―――――――――――――――――――――――――――――――――――――
; スキン設定ファイルを読み込む

	if funcid=FNC_XSS_LOAD {
	 if snVar=0 :return_ FR_ERR
	 if func&FNC_STR=0 {
	  gosub disable_allWnd
	  dialog "xss",16,"スキン設定ファイル"
	  if stat=0 :gosub enable_allWnd :return_ FR_ERR
	  funcopts=refstr
	  gosub enable_allWnd
	 }
	 exist_ funcopts
	 if stat!1 :return_ FR_ERR
	 notesel notedata
	 noteload funcopts
	 noteget s,0
	 if "for:"+sFileName!s :return_ FR_ERR
	 repeat snVar
	  noteget sVar.cnt,cnt+1
	 loop
	 sdim notedata,bufnd
	 func=FNC_XSP_MODIFY|FNC_AUTO :gosub *exec_func
	 return_ FR_DONE
	}

; ―――――――――――――――――――――――――――――――――――――
; スキン設定ファイルに保存

	if funcid=FNC_XSS_SAVE {
	 if snVar=0 :return_ FR_ERR
	 if func&FNC_STR=0 {
	  gosub disable_allWnd
	  dialog "xss",17,"スキン設定ファイル"
	  if stat=0 :gosub enable_allWnd :return_ FR_ERR
	  funcopts=refstr
	  gosub enable_allWnd
	 }
	 tmp="for:"+sFileName+"\n"
	 repeat snVar
	  tmp+=sVar.cnt+"\n"
	 loop
	 strlen i,tmp
	 bsave funcopts,tmp,i
	 return_ FR_DONE
	}

; ―――――――――――――――――――――――――――――――――――――
; 言語ファイルを読み込む

	if funcid=FNC_XMS_LOAD {
	 ; 言語ファイルの一覧を更新する
	 if func&FNC_REFRESH {
	  funcret=FR_DONE
	  ; 既存の一覧を削除
	  notemax_ fXMS
	  repeat stat :dmenu hmLanguage,FNC_XMS_LOAD|FNC_ON+cnt :loop
	  ; 新しい一覧を作成
	  dirlist fXMS,skndir+"*.xms",1
	  notesel fXMS :notemax i
	  if i=0 :return_
	  repeat i
	   noteget s,cnt
	   strlen ii,s :strmid ss,s,0,ii-4
	   imenu ss,FNC_XMS_LOAD|FNC_ON+cnt,0,hmLanguage,cnt+1
	   if s=sLanguage {
	    mii.1=1 :mii.3=8
	    setmii hmLanguage,FNC_XMS_LOAD|FNC_ON+cnt
	   }
	  loop
	  return_
	 }
	 ; 読み込むファイルを取得
	 notesel fXMS :notemax i
	 if func&FNC_AUTO :funcopts=sLanguage :else {
	  if func&FNC_STR=0 :noteget funcopts,funcopt
	 }
	 ; メニューのチェックを更新
	 mii.1=1
	 repeat i
	  noteget s,cnt
	  if s=sLanguage :mii.3=0 :setmii hmLanguage,FNC_XMS_LOAD|FNC_ON+cnt
	  if s=funcopts :mii.3=8 :setmii hmLanguage,FNC_XMS_LOAD|FNC_ON+cnt
	 loop
	 ; 読み込む
	 repeat 2
	  s=skndir+funcopts
	  exist_ s
	  if stat=1 {
	   bload s,tmp
	  } else {
	   if cnt=0 :funcopts=defxms :continue
	   tmp=""
	  }
	 loop
	 strsel tmp
	 ; 言語ファイルのバージョン確認
	 strget i,".LanguageFile.ver"
	 if i>vlanguage|(i=0) {
	  strget i,".MessageFile.ver"
	  if i>vlanguage|(i=0) {
	   convert sss,langs.lgDlg_ErrorFormat,"言語ファイル","%format%"
	   convert ss,sss,s,"%file%"
	   convert s,ss,"","%confirm%"
	   gosub enable_allWnd
	   dialog s,0,prgtitles
	   gosub disable_allWnd
	   return_ FR_ERR
	  }
	 }
	 sLanguage=funcopts
	 ;  (1) 初期設定値代入
	 langs.lgPM  ="NOR(ﾉｰﾏﾙ )","REV(ﾘﾊﾞｰｽ)","RND(ﾗﾝﾀﾞﾑ)","REP(ﾘﾋﾟｰﾄ)","STP(ｽﾄｯﾌﾟ)","MDR(ﾚｺｰﾄﾞ)"
	 i=lgPMTI :repeat 6,lgPM :langs.i=langs.cnt :i++ :loop
	 langs.lgPMEX="しない","する"
	 langs.lgST="停止","再生終了","再生中","一時停止中",
	 langs.lgTP="MP3","WMA","MIDI","WAVE","OggVorbis","CD-Audio","(MCI で再生可能なファイル)","(DirectShow で再生可能なファイル)"
	 langs.lgDlg_ErrorFormat="指定された%format%は壊れているか、\nまたは未対応の形式であるため読み込むことが出来ませんでした。\n%confirm%\n(%file%)"
	 langs.lgDlg_ErrorNotFound="指定された%format%が見つからず、読み込むことが出来ませんでした。\n%confirm%\n(%file%)"
	 langs.lgDlg_ErrorOnSave="ファイルの保存に失敗しました。\n\nファイル名に使えない文字を指定していないか、\n読み取り専用のディスクに保存しようとしていないかなどを確認してください。\n\n(%file%)"
	 langs.lgDlg_ConfirmClearFile="再生リストから削除しますか？\n"
	 ;  (2) 言語ファイルの内容を取得
	 ;	ダイアログ用口調
	 ;	 旧版サポート
	 if i<403 {
	  strget_lg lgDlg_ErrorTooManyFiles,	".List.adderror"
	  strget_lg lgDlg_Folder,	".List.addfolder"
	  strget_lg lgDlg_Rename,	".List.renamefile"
	  strget_lg lgDlg_Favorite,	".List.favorite"
	  strget_lg lgDlg_ConfirmDelete,".List.deletefile"
	  langs.lgDlg_ConfirmDelete+="%file%"
	  strget_lg lgDlg_ConfirmClearAll,".List.clearlist"
	  strget_lg lgDlg_ConfirmOverwrite,".List.overwrite"
	  langs.lgDlg_ConfirmOverwrite+="%file%"
	 }
	 ;	 ver.403.00α1～
	 repeat lgs
	  strget_lg cnt,"."+lg_key.cnt
	 loop
	 ;	オブジェクトのチップヘルプ文字列
	 i=lgObj
	 repeat objs
	  strget s,".Obj."+obj_key.cnt
	  convert langs.i,s,"\n","<BR>"
	  i++
	 loop
	 ; (コンボボックスはリストボックスと同じチップヘルプ)
	 i=lgObj+objMainlistc
	 ii=lgObj+objMainlist
	 if langs.i="" :langs.i=langs.ii
	 ; 表示の更新
	 if func&FNC_ON :gosub refresh_tiphelp
	 return_ FR_DONE
	}

; ―――――――――――――――――――――――――――――――――――――
; プラグインなどの外部ファイルを起動

	if funcid=FNC_XPI_LOAD {
	 ; プラグインの一覧を更新する
	 if func&FNC_REFRESH {
	  funcret=FR_DONE
	  ; 既存の一覧を削除
	  notemax_ fXPI
	  repeat stat :dmenu hmPlugin,FNC_XPI_LOAD+cnt :loop
	  ; 新しい一覧を作成
	  dirlist fXPI,extdir+"*.xpi",1
	  dirlist notedata,extdir+"*.exe",1 :if stat :fXPI+=notedata
	  dirlist notedata,extdir+"*.lnk",1 :if stat :fXPI+=notedata
	  sdim notedata,bufnd
	  notesel fXPI :notemax i
	  if i=0 :return_
	  repeat i
	   noteget s,cnt
	   strlen ii,s :strmid ss,s,0,ii-4
	   imenu ss,FNC_XPI_LOAD+cnt,0,hmPlugin,cnt+1
	  loop
	  return_
	 }
	 if func&FNC_AUTO {
	  if funcopt=IDX_XPI_HELP {
	   s=helpfile
	   exist_ s
	   if stat=1 :exec s,16 :return_ FR_DONE
	   return_ FR_ERR
	  }
	  if funcopt=IDX_XPI_VOLUME {
	   s="\\sndvol32.exe" :ss=windir+s
	   repeat 2
	    exist_ ss
	    if stat!1 {
	     funcret=FR_ERR
	     ss=sysdir+s
	     continue
	    } else :exec ss+" /t" :funcret=FR_DONE
	   loop
	   return_
	  }
	  repeat
	   if funcopt=IDX_XPI_SETPLAYFUNC :funcopts=datdir+setplayfunc :break
	   if funcopt=IDX_XPI_SETPLAYTYPE :funcopts=datdir+setplaytype :break
	   if funcopt=IDX_XPI_CFGFAVORITE :funcopts=datdir+cfgfavorite :break
	   break
	  loop
	 } else {
	  notesel fXPI
	  noteget funcopts,funcopt
	 }
	 gettype funcopts
	 if stat&TPEX_EXE {
	  skiperr 1
	  exec extdir+funcopts,16 :i=err
	  skiperr 0
	  if i :return_ FR_ERR
	 } else {
	  strlen i,funcopts
	  bsave tmpdir+"run.xmp",funcopts,i
	  exec myself
	 }
	 return_ FR_DONE
	}

; ―――――――――――――――――――――――――――――――――――――
; スクリプトを読み込んで実行

	if funcid=FNC_XS_LOAD {
	 ; スクリプトの一覧を更新する
	 if func&FNC_REFRESH {
	  funcret=FR_DONE
	  ; 既存の一覧を削除
	  notemax_ fXS
	  repeat stat :dmenu hmScript,FNC_XS_LOAD|FNC_AUTO+cnt :loop
	  ; 新しい一覧を作成
	  dirlist fXS,extdir+"*.xs",1
	  notesel fXS :notemax i
	  if i=0 :return_
	  repeat i
	   noteget s,cnt
	   strlen ii,s :strmid ss,s,0,ii-3
	   imenu ss,FNC_XS_LOAD|FNC_AUTO+cnt,0,hmScript,cnt+1
	  loop
	  return_
	 }
	 ; 読み込むファイルを取得
	 if func&FNC_STR=0 {
	  if func&FNC_AUTO {
	   notesel fXS
	   noteget funcopts,funcopt
	   funcopts=extdir+funcopts
	  } else {
	   gosub disable_allWnd
	   dialog "xs",16,"スクリプト"
	   if stat=0 :gosub enable_allWnd :return_ FR_ERR
	   funcopts=refstr
	   gosub enable_allWnd
	  }
	 }
	 ; 読み込む
	 exist_ funcopts
	 if stat!1 :return_ FR_ERR
	 bload funcopts,tmp
	 poke script,strsize,0	; 文字列の終わりを示すコードを付加
	 notemax_ tmp
	 script+=tmp
	 scrLine+=stat
	 return_ FR_DONE
	}

; ―――――――――――――――――――――――――――――――――――――
; クリップボードに情報をコピー

	if funcid=FNC_CLIP {
	 i=funcopt
	 ; 音楽情報
	 if i<IDX_CLIP_SINFO {
	  if i<nminfo_ :s=minfo_.i :funcret=FR_DONE :else :s="" :funcret=FR_ERR
	 ; スキン情報
	 } else {
	  i-=IDX_CLIP_SINFO
	  if i<nsinfo_ :s=sinfo_.i :funcret=FR_DONE :else :s="" :funcret=FR_ERR
	 }
	 ; クリップボードを開く
	 prm=0
	 dllprocp FNC_OpenClipboard,prm,1
	 dllprocp FNC_EmptyClipboard,prm,0
	 ; クリップボードにデータを書き込み
	 if s!"" {
	  ; グローバルメモリオブジェクトを作成＆ロック
	  prm=$42 :strlen prm.1,s :prm.1++
	  dllprocp FNC_GlobalAlloc,prm,2 :i=dllret
	  i=dllret
	  dllprocp FNC_GlobalLock,i,1
	  ;	i	/ メモリオブジェクトハンドル
	  ;	dllret	/ メモリブロックの先頭のポインタ
	  ; 文字列をグローバルメモリへコピー＆ロック解除
	  prm=dllret,ps
	  dllprocp FNC_lstrcpy,prm,2
	  dllprocp FNC_GlobalUnlock,i,1
	  prm=1,i
	  dllprocp FNC_SetClipboardData,prm,2
	 }
	 ; クリップボードを閉じる
	 dllprocp FNC_CloseClipboard,prm,0
	 return_
	}

; ―――――――――――――――――――――――――――――――――――――
; 設定の変更

; SET系覚書	(1) dispMainWnd|initializing != 0
;			起動時のみの処理
;		(2) func|FNC_REFRESH != 0
;			起動時またはスキン読み込み後の処理
;		(3) func|FNC_CHANGE != 0
;			設定変更時の処理
;
;		メニューのチェックを更新する必要があるのは	(1),(3)
;		チェックボックスの更新をする	〃		(2),(3)
;		スクリプトを実行する　　　　	〃		(3)

	if funcid=FNC_SET {
	 ; 設定値の変更
	 if func&FNC_CHANGE {
	  if func&FNC_AUTO {
	   repeat
	    if funcopt=IDX_SET_LIST_CLEARONLOAD	:lClearOnLoad=lClearOnLoad^1 :break
	    if funcopt=IDX_SET_LIST_DOWNDBLITEM	:lDownDblItem=lDownDblItem^1 :break
	    if funcopt=IDX_SET_DISP_ONTOP	:dispMainWnd =dispMainWnd ^1 :break
	    if funcopt=IDX_SET_DISP_TIPHELP	:dispTiphelp =dispTiphelp ^1 :break
	    if funcopt=IDX_SET_DISP_TRAYICON	:dispTrayicon=dispTrayicon^1 :break
	    if funcopt=IDX_SET_DISP_TASKBAR	:dispTaskbar =dispTaskbar ^1 :break
	    if funcopt=IDX_SET_PLAY_REPLAY	:lReplay     =lReplay     ^1 :break
	    break
	   loop
	  } else {
	   repeat
	    i=func&FNC_ON!0
	    if funcopt=IDX_SET_LIST_CLEARONLOAD	:lClearOnLoad=i :break
	    if funcopt=IDX_SET_LIST_DOWNDBLITEM	:lDownDblItem=i :break
	    if funcopt=IDX_SET_DISP_ONTOP	:dispMainWnd =dispMainWnd&2+i :break
	    if funcopt=IDX_SET_DISP_TIPHELP	:dispTiphelp =i :break
	    if funcopt=IDX_SET_DISP_TRAYICON	:dispTrayicon=i :break
	    if funcopt=IDX_SET_DISP_TASKBAR	:dispTaskbar =i :break
	    if funcopt=IDX_SET_PLAY_REPLAY	:lReplay     =i :break
	    break
	   loop
	  }
	 }
	 ; 設定値の取得と設定変更の適用
	 repeat
	  prm=hmSetList
	  if funcopt=IDX_SET_LIST_CLEARONLOAD	:prm.1=lClearOnLoad :break
	  if funcopt=IDX_SET_LIST_DOWNDBLITEM	:prm.1=lDownDblItem :break
	  prm=hmSetDisp
	  if funcopt=IDX_SET_DISP_ONTOP		{
	   if func&(FNC_CHANGE|FNC_REFRESH) :gsel sWid,dispMainWnd&1+1
	   prm.1=dispMainWnd&1 :break
	  }
	  if funcopt=IDX_SET_DISP_TIPHELP	{
	   if func&(FNC_CHANGE|FNC_REFRESH) :gosub refresh_tiphelp
	   prm.1=dispTiphelp :break
	  }
	  if funcopt=IDX_SET_DISP_TRAYICON	{
	   if func&FNC_CHANGE|(dispMainWnd&initializing) {
	    if dispTrayicon {
	     ntray hIcon
	     ttray mTasktray,hIcon
	    } else :ctray
	   }
	   prm.1=dispTrayicon :break
	  }
	  if funcopt=IDX_SET_DISP_TASKBAR	{
	   if func&(FNC_CHANGE|FNC_REFRESH) {
	    ;  拡張スタイルに/から WS_EX_TOOLWINDOW を加える/外す
	    ;  ※ ツールウィンドウは、通常のタイトルバーより小さいタイトルバーを持ち...
	    ;  　 ↑タイトルバーが元々無いウィンドウでこのスタイルを指定した場合には "小さいタイトルバーe.t.c." は関係無いらしい
	    if sWid=widRegion {
	     if dispMainWnd&2=0 :gsel sWid,-1
	     prmex=hwMainWnd,-20
	     dllprocp FNC_GetWindowLongA,prmex,2
	     if dispTaskbar :prmex.2=dllret&($FFFFFF7F) :else :prmex.2=dllret|$80
	     dllprocp FNC_SetWindowLongA,prmex,3
	     if dispMainWnd&2=0 :gsel sWid,dispMainWnd&1+1
	    }
	   }
	   prm.1=dispTaskbar :break
	  }
	  prm=hmSetPlay
	  if funcopt=IDX_SET_PLAY_REPLAY	:prm.1=lReplay :break
	  break
	 loop
	 ; チェックを更新
	 ;  メニュー
	 if func&FNC_CHANGE|(dispMainWnd&initializing) {
	  mii.1=1 :mii.3=prm.1*8 :setmii prm,FNCM_SET+funcopt
	 }
	 ;  オブジェクト
	 if func&(FNC_CHANGE|FNC_REFRESH) {
	  repeat snChk
	   i=chkid.cnt
	   if obj.i^func&$FF00FFFF=0 :objprm i,prm.1
	   chk_.cnt=chk.cnt
	  loop
	 }
	 return_ prm.1
	} 

; ―――――――――――――――――――――――――――――――――――――
; 設定の変更>再生リスト編集での検索対象

	if funcid=FNC_SET_SEARCH {
	 repeat
	  if func&FNC_AUTO {
	   if func&FNC_ALL :lSearchType=lSearchType=0*TPEX_ALL
	   lSearchType=lSearchType^funcopt :break
	  }
	  if func&FNC_OFF :lSearchType=lSearchType&($FFFFFF^funcopt) :break
	  if func&FNC_ON :lSearchType=lSearchType|funcopt :break
	  break
	 loop
	 ; チェックを更新
	 ; ($1-$2000 まで)
	 i=1 :ii=0 :mii.1=1
	 repeat 11
	  prm=lSearchType&i!0
	  ; メニュー
	  if func&FNC_CHANGE|(dispMainWnd&initializing) {
	   mii.3=prm*8
	   setmii hmSetListSub,FNCM_SET_SEARCH+ii
	  }
	  ; オブジェクト
	  if func&(FNC_REFRESH|FNC_CHANGE) {
	   repeat snChk
	    iii=chkid.cnt
	    if obj.iii^(FNC_SET_SEARCH|FNC_AUTO+i)&$FF00FFFF=0 :objprm iii,prm
	    chk_.cnt=chk.cnt
	   loop
	  }
	  if cnt=8 :i=$1000 :ii=12 :else :i=i<<1 :ii++
	 loop
	 return_ lSearchType
	}

; ―――――――――――――――――――――――――――――――――――――
; 設定の変更>再生手法

	if funcid=FNC_SET_PLAYFUNC {
	 ; 呼び出し先で値が変更されることの無い im.5,6 に設定内容を退避
	 im.5=funcopt&$FFF :i=im.5
	 im.6=funcopt-i
	 if i<TP_PLAYABLE {
	  if mStatus!ST_CLOSED&(i=(TPfromTPEX(mFileType)))&(type.i!im.6) {
	   dispMainWnd=dispMainWnd|closing
	   func=FNC_STOP :gosub *exec_func
	   dispMainWnd=dispMainWnd^closing
	   i=im.5
	   type.i=im.6
	   func=FNC_PLAY+mFileIdx :gosub *exec_func
	   i=im.5
	  } else :type.i=im.6
	 } else :return_ FR_ERR
	 return_ type.i
	}

; ―――――――――――――――――――――――――――――――――――――
; DLLなどの使用準備
;	注意	prmex などの内容を破壊しない
;		(FNC_LIST_ADD_FOLDER ダイアログなどのための配慮)

	if funcid=FNC_LOADLIB {
	 ; COM の使用準備
	 if funcopt=IDX_LOAD_COM {
	  prm=0 :dllproc "CoInitialize",prm,1,D_OLE
	  ; インターフェースのメソッド呼び出し用マシン語の指定
	  ; (lollipop モジュールより一部抜粋）
	  ; CallMethod	... インターフェースのメソッド呼び出し関数
	  ;	prm=引数,引数の数,メソッドのインデックス,インターフェースポインタ
	  ;	※ メソッドのインデックス
	  ;		0	(Interface)	-> QueryInterface
	  ;		1	(Interface)	-> AddRef
	  ;		2	(Interface)	-> Release
	  dim CallMethod,11	; 関数データ長 (11*4>)$2A(>(10*4))
	  getptr pCallMethod,CallMethod
	  prm=pCallMethod,44,$40,pi :dllprocp FNC_VirtualProtect,prm,4
	  CallMethod = $8bec8b55, $d2851455, $458b1974, $0c4d8b08, $34ff03eb, $fa7d4988, $8b028b52, $14ff104d, $b805eb88, $80004003, $0000c3c9
	  ; SHBrowseForFolder 用のコールバック関数を準備
	  ; (ちょくとさんのホームページより抜粋)
	  dim CallbackFunc,8
	  getptr pCallbackFunc,CallbackFunc
	  prm=pCallbackFunc,32,$40,pi :dllprocp FNC_VirtualProtect,prm,4
	  CallbackFunc = $08247c83, $8b147501, $ff102444, $68016a30, $00000466, $102474ff, $330450ff, $0010c2c0
	  return_ FR_DONE
	 }
	 ; DirectShow の使用準備
	 if funcopt=IDX_LOAD_DXS {
	  ; 関連 CLSID の取得
	  getclsid "{e436ebb3-524f-11ce-9f53-0020af0ba770}",dxs_clsid_FilterGraph
	  ; 関連 IID の取得
	  getiid "{00000000-0000-0000-c000-000000000046}",dxs_iid_IUnknown
	  getiid "{56a868a9-0ad4-11ce-b03a-0020af0ba770}",dxs_iid_IGraphBuilder
	  getiid "{56a868b1-0ad4-11ce-b03a-0020af0ba770}",dxs_iid_IMediaControl
	  getiid "{36b73880-c2c8-11cf-8b46-00805f6cef60}",dxs_iid_IMediaSeeking
	  getiid "{56a868b3-0ad4-11ce-b03a-0020af0ba770}",dxs_iid_IBasicAudio
	  getiid "{b196b28b-bab4-101a-b69c-00aa00341d07}",dxs_iid_ISpecifyPropertyPages
	  ; DLL の読み込み
	  ll_libload D_OLEPRO,"olepro32.dll"
	  ll_getproc pfunc.FNC_OleCreatePropertyFrame	,"OleCreatePropertyFrame"	,D_OLEPRO
	  ll_getproc pfunc.FNC_CoTaskMemFree		,"CoTaskMemFree"		,D_OLE
	  return_ FR_DONE
	 }
	 ; Vox.dll の使用準備と解放
	 if funcopt=IDX_LOAD_VOX {
	  if func&FNC_CHANGE {
	   if D_VOX=0 {
	    if func&FNC_AUTO=0&(func&FNC_ON=0) :return_ 0
	    ll_libload D_VOX,"vox.dll"
	    if D_VOX=0 :gosub disable_allWnd :dialog "\"vox.dll\" was not found.",1,prgtitles :gosub enable_allWnd :return_ FR_ERR
	    ll_getproc pfunc.FNC_vox_Load	,"VoxLoad"		,D_VOX
	    ll_getproc pfunc.FNC_vox_SetLoop	,"VoxSetLoop"		,D_VOX
	    ll_getproc pfunc.FNC_vox_Play	,"VoxPlay"		,D_VOX
	    ll_getproc pfunc.FNC_vox_GetComment	,"VoxGetComment"	,D_VOX
	    ll_getproc pfunc.FNC_vox_ParseComment,"VoxParseComment"	,D_VOX
	    ll_getproc pfunc.FNC_vox_GetTotalTime,"VoxGetTotalTime"	,D_VOX
	    ll_getproc pfunc.FNC_vox_GetCurrentTime,"VoxGetCurrentTime"	,D_VOX
	    ll_getproc pfunc.FNC_vox_GetStatus	,"VoxGetStatus"		,D_VOX
	    ll_getproc pfunc.FNC_vox_Seek	,"VoxSeek"		,D_VOX
	    ll_getproc pfunc.FNC_vox_Pause	,"VoxPause"		,D_VOX
	    ll_getproc pfunc.FNC_vox_Release	,"VoxRelease"		,D_VOX
	    ll_getproc pfunc.FNC_vox_Delete	,"VoxDelete"		,D_VOX
	   } else {
	    if func&FNC_AUTO=0&(func&FNC_ON!0) :return_ 1
	    ll_libfree D_VOX
	    D_VOX=0
	   }
	  }
	  return_ D_VOX!0
	 }
	 ; vbmp3.dll の使用準備と解放
	 if funcopt=IDX_LOAD_VBMP3 {
	  if func&FNC_CHANGE {
	   if D_VBMP3=0 {
	    if func&FNC_AUTO=0&(func&FNC_ON=0) :return_ 0
	    ll_libload D_VBMP3,"vbmp3.dll"
	    if D_VBMP3=0 :gosub disable_allWnd :dialog "\"vbmp3.dll\" was not found.",1,prgtitles :gosub enable_allWnd :return_ FR_ERR
	    dllproc "vbmp3_init",prm,0,D_VBMP3
	    ll_getproc pfunc.FNC_vbmp3_open	,"vbmp3_open"	,D_VBMP3
	    ll_getproc pfunc.FNC_vbmp3_play	,"vbmp3_play"	,D_VBMP3
	    ll_getproc pfunc.FNC_vbmp3_getMpegInfo,"vbmp3_getMpegInfo",D_VBMP3
	    ll_getproc pfunc.FNC_vbmp3_getState,"vbmp3_getState",D_VBMP3
	    ll_getproc pfunc.FNC_vbmp3_seek	,"vbmp3_seek"	,D_VBMP3
	    ll_getproc pfunc.FNC_vbmp3_pause	,"vbmp3_pause"	,D_VBMP3
	    ll_getproc pfunc.FNC_vbmp3_restart	,"vbmp3_restart",D_VBMP3
	    ll_getproc pfunc.FNC_vbmp3_stop	,"vbmp3_stop"	,D_VBMP3
	    ll_getproc pfunc.FNC_vbmp3_close	,"vbmp3_close"	,D_VBMP3
	    ll_getproc pfunc.FNC_vbmp3_free	,"vbmp3_free"	,D_VBMP3
	   } else {
	    if func&FNC_AUTO=0&(func&FNC_ON!0) :return_ 1
	    dllprocp FNC_vbmp3_free,prm,0
	    ll_libfree D_VBMP3
	    D_VBMP3=0
	   }
	  }
	  return_ D_VBMP3!0
	 }
	 if funcopt=IDX_LOAD_MP3INFP {
	  if func&FNC_CHANGE {
	   gosub disable_allWnd
	   if D_MP3INFP=0 {
	    if func&FNC_AUTO=0&(func&FNC_ON=0) :gosub enable_allWnd :return_ 0
	    ll_libload D_MP3INFP,"mp3infp.dll"
	    if D_MP3INFP=0 {
	     dialog "\"mp3infp.dll\" was not found.",1,prgtitles
	    } else {
	     dllproc "mp3infp_GetVer",prm,0,D_MP3INFP
	     if dllret<$226 {
	      ll_libfree D_MP3INFP :D_MP3INFP=0
	      dialog "The version of mp3infp.dll is too old.\nplease download and install the newest version, then try again.",1,prgtitles
	     } else {
	      ll_getproc pfunc.FNC_mp3infp_ViewProp,	"mp3infp_ViewProp"	,D_MP3INFP
	      ll_getproc pfunc.FNC_mp3infp_Load,	"mp3infp_Load"		,D_MP3INFP
	      ll_getproc pfunc.FNC_mp3infp_mp3_GetTagType,"mp3infp_mp3_GetTagType",D_MP3INFP
	      ll_getproc pfunc.FNC_mp3infp_GetValue,	"mp3infp_GetValue"	,D_MP3INFP
	     }
	    }
	   } else {
	    if func&FNC_AUTO=0&(func&FNC_ON!0) :gosub enable_allWnd :return_ 1
	    ll_libfree D_MP3INFP
	    D_MP3INFP=0
	   }
	   ; チェックを更新
	   ;  メニュー
	   mii.1=1 :mii.3=D_MP3INFP!0*8
	   setmii hmSetPlay,FNCM_LOADLIB+IDX_LOAD_MP3INFP
	   gosub enable_allWnd
	  }
	  ;  オブジェクト
	  if func&(FNC_CHANGE|FNC_REFRESH) {
	   repeat snChk
	    ii=chkid.cnt
	    if obj.ii^func&$FF00FFFF=0 :objprm ii,D_MP3INFP!0
	    chk_.cnt=chk.cnt
	   loop
	  }
	  return_ D_MP3INFP!0
	 }
	 ; DDEの初期化と解放
	 /*
	 if funcopt=IDX_LOAD_DDE {
	  if func&FNC_CHANGE {
	   if dde_inst=0 {
	    if func&FNC_AUTO=0&(func&FNC_ON=0) :return_ 0
	    ; APPCMD_CLIENTONLY | CBF_FAIL_ALLSVRXACTIONS
	    ; | CBF_SKIP_ALLNOTIFICATIONS
	    i=0 :prm=pi,0,$3FF010,0
	    dllprocp FNC_DdeInitializeA,prm,4
	    dde_inst=i
	    ; EnumWindows で使用するコールバック関数
	    / *
	    dim CallbackFunc2,12
	    getptr pCallbackFunc2,CallbackFunc2
	    prm=pCallbackFunc2,48,$40,pi :dllprocp FNC_VirtualProtect,prm,4
	    CallbackFunc2   = $0824448b, $8b08488b, $ca3b0450, $c033057c, $8b0008c2, $748b5610
	    CallbackFunc2.6 = $34890824, $08488b8a, $48895e41, $0001b808, $08c20000, $00000000
	    * /
	   } else {
	    if func&FNC_AUTO=0&(func&FNC_ON!0) :return_ 1
	    dllprocp FNC_DdeInitializeA,dde_inst,1
	    dde_inst=0
	   }
	  }
	  return_ dde_inst!0
	 }
	 */
	 return_ FR_ERR
	}

; ―――――――――――――――――――――――――――――――――――――
; スクリプトを実行

	if funcid=FNC_SCRIPT {
	 if func&FNC_STR=0 {
	  if funcopt<IDX_SCRIPT_USER {
	   repeat
	    if funcopt=0 :scrplus scrAreaMain :break
	    if funcopt=1 :scrplus scrAreaShow_Mode :break
	    if funcopt=2 :scrplus scrAreaShow_ModeEx :break
	    if funcopt=3 :scrplus scrAreaShow_FileInfo :break
	    if funcopt=4 :scrplus scrAreaShow_Tiphelp :break
	    if funcopt=5 :scrplus scrAreaDisp_ListArea :break
	    if funcopt=6 :scrplus scrAreaHide_ListArea :break
	    break
	   loop
	  } else {
	   i=funcopt-IDX_SCRIPT_USER
	   if i<0|(i>=snAreaUser) :return_ FR_ERR
	   script+=scrAreaUser.i
	   scrLine+=scrAreaUserLine.i
	  }
	 } else {
	  notemax_ funcopts
	  script+=funcopts
	  scrLine+=stat
	 }
	 return_ FR_DONE
	}

	return_ FR_IDLE


; ―――――――――――――――――――――――――――――――――――――
; (デバッグ画面用サブルーチン)
; ―――――――――――――――――――――――――――――――――――――

	#ifdef DEBUG
	*addlogfnc
	funcid=func_.funclv&$FF000000
	repeat
	 if funcid=$01000000 :s="OPEN_WND" :break
	 if funcid=$02000000 :s="OPEN_LISTAREA" :break
	 if funcid=$03000000 :s="OPEN_PROPERTY" :break
	 if funcid=$04000000 :s="OPEN_PARENTDIR" :break
	 if funcid=$05000000 :s="MINIMIZE" :break
	 if funcid=$06000000 :s="POPUP" :break
	 ;  音楽再生
	 if funcid=$07000000 :s="PLAY" :break
	 if funcid=$08000000 :s="PAUSE" :break
	 if funcid=$09000000 :s="STOP" :break
	 if funcid=$0A000000 :s="MODE" :break
	 if funcid=$0B000000 :s="VOLUME" :break
	 if funcid=$0C000000 :s="SEEK" :break
	 if funcid=$0D000000 :s="GETTAGINFO" :break
	 ;if funcid=$0E000000 :s="GETSTATE" :break
	 ;  リスト編集
	 if funcid=$0F000000 :s="LIST_REFRESH" :break
	 if funcid=$10000000 :s="LIST_ADD" :break
	 if funcid=$11000000 :s="LIST_ADD_FILE" :break
	 if funcid=$12000000 :s="LIST_ADD_FOLDER" :break
	 if funcid=$13000000 :s="LIST_SORT" :break
	 if funcid=$14000000 :s="LIST_CHECK" :break
	 if funcid=$15000000 :s="LIST_CLEAR" :break
	 if funcid=$16000000 :s="LIST_DELETE" :break
	 if funcid=$17000000 :s="LIST_RENAME" :break
	 if funcid=$18000000 :s="LIST_UP" :break
	 if funcid=$19000000 :s="LIST_DOWN" :break
	 if funcid=$1A000000 :s="XLT_LOAD" :break
	 if funcid=$1B000000 :s="XLT_SAVE" :break
	 ;  スキン
	 if funcid=$1C000000 :s="XSP_MODIFY" :break
	 if funcid=$1D000000 :s="XSP_LOAD" :break
	 if funcid=$1E000000 :s="XSS_LOAD" :break
	 if funcid=$1F000000 :s="XSS_SAVE" :break
	 if funcid=$20000000 :s="XMS_LOAD" :break
	 ;  プラグイン
	 if funcid=$21000000 :s="XPI_LOAD" :break
	 if funcid=$22000000 :s="XS_LOAD" :break
	 ;  その他
	 if funcid=$23000000 :s="CLIP" :break
	 if funcid=$24000000 :s="SET" :break
	 if funcid=$25000000 :s="SET_SEARCH" :break
	 if funcid=$26000000 :s="SET_PLAYFUNC" :break
	 if funcid=$27000000 :s="LOADLIB" :break
	 if funcid=$30000000 :s="SCRIPT" :break
	 s="(?)"
	 break
	loop
	if funcid!$0E000000 {
	 i=func_.funclv
	 str i,24
	 ss=""
	 repeat funclv :ss+=" " :loop
	 addlog "FNC "+ss+"$"+i+"("+s+") -> "+funcret
	 int i
	}
	return
	#endif


; ―――――――――――――――――――――――――――――――――――――
;                                                              (c) arc@arcis
