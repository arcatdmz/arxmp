
; ■ サブルーチン
; ―――――――――――――――――――――――――――――――――――――

/* 制作メモ ――――――――――――――――――――――――――――――――

 ・この as ファイルについて

	瑣末なサブルーチンをまとめてある

 ―――――――――――――――――――――――――――――――――――― */


; ―――――――――――――――――――――――――――――――――――――
; 音楽ファイル名の取得
;	使用値	func,funcopt
;	返り値	funcopts	音楽ファイル名
;		funcopt		そのリスト中での位置

*get_mpath
	if func&FNC_AUTO {
	 i=-1
	 repeat
	  if lNum=0 :break
	  if funcopt=IDX_SEL :i=lSelectedIdx :break
	  i=mFileIdx
	  if funcopt=IDX_CUR :break
	  if lMode&$F=PM_RND {
	   if lNum<2 :i=0 :else {
	    repeat
	     rnd i,lNum
	     if i!mFileIdx :break
	    loop
	   }
	   break
	  }
	  if funcopt=IDX_CUR_PREV {
	   i--
	   if i=-1 :i=lNum-1
	   break
	  }
	  if funcopt=IDX_CUR_NEXT {
	   i++
	   if i=lNum :i=0
	   break
	  }
	  break
	 loop
	 funcopt=i
	}
	if funcopt=-1 :funcopts="" :return
	notesel list
	noteget funcopts,funcopt
	return

; ―――――――――――――――――――――――――――――――――――――
; 音楽情報の取得
;	使用値	ss	音楽情報識別子
;	返り値	sss	音楽情報

*get_minfo
	if ss="indx" :im=mFileIdx+1 :sss=""+im :return
	if ss="posi" :timeconv sss,mPosition :return
	if ss="posh" :im=mPosition/1000/3600 :sss=""+im :return
	if ss="posm" :im=mPosition/1000/60 :sss=""+im :return
	if ss="poss" :im=mPosition/1000\60 :sss=""+im :return
	if ss="lgth" :timeconv sss,mDuration :return
	if ss="lgtH" :im=mDuration/1000/3600 :sss=""+im :return
	if ss="lgtm" :im=mDuration/1000/60 :sss=""+im :return
	if ss="lgts" :im=mDuration/1000\60 :sss=""+im :return
	if ss="fpth" :sss=mFilePath :return
	if ss="file" :sss=mFileName :return
	if ss="auth" :sss=mAuthor :return
	if ss="titl" :sss=mName :return
	if ss="atit" :sss=mAlbumName :return
	if ss="rele" :sss=mRelDate :return
	if ss="comm" :sss=mComment :return
	if ss="form" :sss=mFormat :return
	if ss="scrl" :sss=mScroll :return
	if ss="type" :get_langTP sss,mFileType :return
	if ss="stat" :get_langST sss,mStatus :return
	if ss="mode" :get_langPM sss,lMode :return
	return

; ―――――――――――――――――――――――――――――――――――――
; オブジェクトIDの取得

;	使用値	ss	オブジェクト識別子
;	返り値	i	オブジェクトID

*get_objid
	; オブジェクト識別子 → オブジェクト機能
	gosub get_objfunc
	; オブジェクト機能   → オブジェクトID
	gosub get_objid_from_func
	return

;	使用値	ii	オブジェクト機能
;	返り値	i	オブジェクトID
;	前提	prm の内容を破壊しない
;		(*exec_script と FNC_LIST_CLEAR 用の配慮)

*get_objid_from_func
	i=-1
	repeat objmax
	 if obj.cnt=ii :i=cnt :break
	loop
	return

*get_listobjid
	if dispListWnd {
	 i=5
	} else {
	 if sList :ii=FNC_PLAYLISTC :else :ii=FNC_PLAYLIST
	 gosub get_objid_from_func
	}
	return

; ―――――――――――――――――――――――――――――――――――――
; オブジェクト機能の取得
;	使用値	ss	オブジェクト識別子
;	返り値	ii	オブジェクト機能

*get_objfunc
	peek ii,ss,0
	if ii='$' :ii=ss :int ii : else {
	 ii=0
	 ; オブジェクト識別子 → オブジェクト機能
	 repeat objs
	  if obj_key.cnt=ss :ii=obj_func.cnt :break
	 loop
	}
	return

; ―――――――――――――――――――――――――――――――――――――
; オブジェクト種類No.の取得
;	使用値	ii	オブジェクト機能
;	返り値	i	オブジェクト種類No.

*get_objtype
	i=-1
	; オブジェクト機能 → オブジェクト識別子
	repeat objs
	 if obj_func.cnt=ii :i=cnt :break
	loop
	return

; ―――――――――――――――――――――――――――――――――――――
; 音楽情報の表示を更新
;	使用値	mScrollType	情報種

*get_mscroll
	if dispInfoWnd=1 :gsel widInfo
	mScroll=""
	repeat 5
	 i=mScrollType.cnt
	 s=""
	 repeat
	  if i=0 :s=mFilePath	:break
	  if i=1 :s=mFileName	:break
	  if i=2 :s=mAuthor	:break
	  if i=3 :s=mName	:break
	  if i=4 :s=mAlbumName	:break
	  if i=5 :s=mRelDate	:break
	  if i=6 :s=mComment	:break
	  if i=7 :s=mFormat	:break
	  if i=8 :sizeconv s,mFileSize :break
	  if i=9 :timeconv s,mDuration :break
	  if i=10:s=""		:break
	  if i=11:i=mFileIdx+1	:s=""+i+"." :break
	  break
	 loop
	 if s!"" {
	  if cnt!0 :mScroll+=" "
	  mScroll+=s
	 }
	 if dispInfoWnd=1 :objprm cnt*2+1,s
	loop
	s=mScroll :strlen i,s
	prm=bmscr.4,ps,i,pi
	dllprocp FNC_GetTextExtentPoint32A,prm,4
	mScrollWidth=i
	gsel sWid
	return

; ―――――――――――――――――――――――――――――――――――――
; シークバー領域の四隅座標を取得

*get_seekrect
	if (mDuration!0)&(mPosition!0) {
	if sSeekDirection=0 :prm=sSeekX,sSeekY,sSeekX+(mPosition*sSeekWidth/mDuration),sSeekY+sSeekHeight :else {
	  prm=sSeekX,sSeekY+sSeekHeight-(mPosition*sSeekHeight/mDuration)-1,sSeekX+sSeekWidth,sSeekY+sSeekHeight-1
	 }
	} else :prm=0,0,0,0
	return

; ―――――――――――――――――――――――――――――――――――――
; スクロール領域の左上座標を取得

*get_scrlpos
	prm=csrx,csry
	if mScrollWidth!0&(sScrollStep!0) {
	 prm+=sScrollWidth-(mainloop/TI_SCROLL\(mScrollWidth+sScrollWidth/sScrollStep)*sScrollStep)
	}
	return

; ―――――――――――――――――――――――――――――――――――――
; バッファ画面を操作先に(含;初期化処理)

*gsel_widBuffer
	if wi.widBuffer=0 {
	 #ifdef DEBUG
	 screen widBuffer,640,480,14 :boxf
	 title "debug window (2)"+sep+prgtitles
	 #else
	 buffer widBuffer,,,0 :boxf
	 #endif
	 wi.widBuffer=1
	} else :gsel widBuffer
	return

; ―――――――――――――――――――――――――――――――――――――
; 最小化からの復帰

*open_sWid
	if dispMainWnd&2 {
	 mii.1=1 :mii.3=0 :setmii hmOnMain,FNC_MINIMIZE|FNC_AUTO
	 dispMainWnd=dispMainWnd^2
	 gsel sWid,dispMainWnd&1+1
	 dllprocp FNC_OpenIcon,hwMainWnd,1
	 if dispTrayicon=0 :ctray
	}
	return

; ―――――――――――――――――――――――――――――――――――――
; 画面を使用不可にする

*disable_allWnd
	repeat 3
	 if dinfo.cnt!0 {
	  ; 情報画面は入力時使用不可にしない
	  if cnt=2&(dispInfoWnd&IDX_WND_INPUT!0) :continue
	  prm=dinfo.cnt,0
	  dllprocp FNC_EnableWindow,prm,2
	 }
	loop
	return

; ―――――――――――――――――――――――――――――――――――――
; 画面を使用可にする

*enable_allWnd
	gosub enable_allWnd_
	if dispListWnd {
	 prm=hwListWnd
	} else :prm=hwMainWnd
	dllprocp FNC_SetForegroundWindow,prm,1
	return

*enable_allWnd_
	repeat 3
	 if dinfo.cnt!0 {
	  if cnt=2&(dispInfoWnd&IDX_WND_INPUT!0) :continue
	  prm=dinfo.cnt,1
	  dllprocp FNC_EnableWindow,prm,2
	 }
	loop
	return

; ―――――――――――――――――――――――――――――――――――――
; チップヘルプの更新

*refresh_tiphelp
	if dispTiphelp=0 :s="" :else {
	 scrLine+=scrAreaShow_TiphelpLine
	 script=scrAreaShow_Tiphelp+script
	}
	repeat snObj
	 ii=obj.cnt
	 gosub get_objtype
	 if i>=0 {
	  if dispTiphelp :i+=lgObj :s=langs.i
	  tiphelp s,cnt
	 }
	loop
	if wi.widList {
	 gsel widList
	 if dispTiphelp {
	  ; lgObj=31
	  tiphelp langs.56,0	; lgObj+objList_MoveUpFile
	  tiphelp langs.57,1	; 〃	objList_MoveDownFile
	  tiphelp langs.52,2	; 〃	objList_DelFile
	  tiphelp langs.53,3	; 〃	objList_RenameFile
	  tiphelp langs.51,4	; 〃	objList_ClrAll
	  tiphelp langs.44,5	; 〃	objMainlist
	  tiphelp langs.50,6	; 〃	objList_ClrFile
	  tiphelp langs.58,7	; 〃	objList_Load
	  tiphelp langs.59,8	; 〃	objList_Save
	  tiphelp langs.32,9	; 〃	objWindow_CloseList
	 } else {
	  repeat 10
	   tiphelp "",cnt
	  loop
	 }
	 gsel sWid
	}
	return

; ―――――――――――――――――――――――――――――――――――――
; 音楽の再生開始待ち

*wait_mStatus
	repeat 20
	 wait 10
	 func=FNC_GETSTATE :gosub *exec_func
	 if mStatus=ST_PLAYING :break
	loop
	return

; ―――――――――――――――――――――――――――――――――――――
; プラグインに音楽の再生状態を通知

*notify_mStatus
	prm.1=WM_NOTIFYPI,NP_ST,mStatus
	repeat szfmo_send/4,fi_send_mStatus/4
	 ll_peek4 prm,cnt*4+pfmo_info
	 if prm :dllprocp FNC_SendMessageA,prm,4
	loop
	return

; ―――――――――――――――――――――――――――――――――――――
; 音楽の再生位置設定

*apply_mPosition
	i=TPfromTPEX(mFileType)
	if i=TP_OTH :return
	repeat
	 ; Windows MCI を利用
	 if type.i=PF_MCI {
	  ; 位置移動
	  if mFileType&TPEX_CDA {
	   i=mci_cdatrackstart+mPosition
	  } else :i=mPosition
	  mci "seek "+mci_alias+" to "+i+" wait"
	  mci "play "+mci_alias
	  break
	 }
	 ; DirectX DirectShow を利用
	 if type.i=PF_DXS {
	  ; 位置移動(MediaSeeking->SetPositions)
	  ; mPosition 1000 = 1[sec]
	  ; → i 10000000 = 1[sec]
	  llreconv i,mPosition
	  prmex=pi,1,0,0
	  prm=pprmex,4,14,dxs_ms
	  ll_callfunc prm,4,pCallMethod
	  break
	 }
	 ; 外部DLLを利用
	 if type.i=PF_DLL {
	  ; Vox.dll
	  if mFileType&TPEX_OGG {
	   prm=vox_id,mPosition
	   dllprocp FNC_vox_Seek,prm,2
	   break
	  }
	  ; vbmp3.dll
	  if mFileType&TPEX_MP3 {
	   prm=mPosition/1000
	   dllprocp FNC_vbmp3_seek,prm,1
	   break
	  }
	  break
	 }
	 break
	loop
	return

; ―――――――――――――――――――――――――――――――――――――
; フィルタのプロパティ(または説明)を表示
;	使用値	funcid=FNC_OPEN_WND
; フィルタの一覧を取得
;	使用値	funcid=FNC_OPEN_WND以外(FNC_PLAYからの呼び出しを想定)

*enum_filters
	; 利用されるフィルタの一覧を取得(IGraphBuilder->EnumFilters)
	prmex=pi
	prm=pprmex,2,5,dxs_gb
	ll_callfunc prm,4,pCallMethod
	im=i
	;	im	/	IEnumFilters ポインタ
	tmp2=""
	repeat
	 ; 各フィルタの IBaseFilter ポインタを取得(IEnumFilters->Next)
	 prmex=1,pii,piii
	 prm=pprmex,3,3,im
	 ll_callfunc prm,4,pCallMethod
	 if dllret :break
	 ;	ii	/	IBaseFilter ポインタ
		if funcopt=cnt|(funcid!FNC_OPEN_WND) {
		 ; フィルタの情報を取得(IBaseFilter->QueryFilterInfo)
		 prmex=ptmp
		 prm=pprmex,1,12,ii
		 ll_callfunc prm,4,pCallMethod
		 if funcid!FNC_OPEN_WND {
		  gosub *@f
		  s="DirectShow フィルタ: "+s
		 }
		 ; tmp 先頭 256bytes から 4bytes
		 ;	/	IFilterGraph ポインタ
			; フィルタがプロパティページを持つか調べる
			qi ii,iii,dxs_iid_ISpecifyPropertyPages
			;  持っていない
			if iii=0 {
			 if funcid=FNC_OPEN_WND {
			  gosub *@f
			  ; s	/	フィルタ名
			  i=npfprop-cnt
			  dialog "DirectX DirectShow\n\n　DirectXという巨大なプログラムの構成部品であるDirectShowは、音楽や映像、画像を再生する機能を持ちます。\n\n　DirectShow フィルタは、データとしてのファイルが音や映像として表現されるまでに経る過程を概念的に表しています。\n　ファイルは arXmp のメニューに表示されているフィルタを下から順に通り、最後に耳に聞こえる音となります。\n　選択された「"+s+"」はデータが"+i+"番目に通るフィルタです。\n\n※メニューにおいて (*) 印の付いたフィルタは、クリックされたときに独自のプロパティページを表示します。",,"DirectShow"
			 }
			;  持っている
			} else {
			 ; iii	/ ISpecifyPropertyPages ポインタ
			 if funcid=FNC_OPEN_WND {
			  ; ページ情報の取得(ISpecifyPropertyPages->GetPages)
			  prmex=ptmp2
			  prm=pprmex,1,3,iii
			  ll_callfunc prm,4,pCallMethod
			  ; ISpecifyPropertyPages ポインタの破棄
			  ri iii
			  ; フィルタの IUnknown ポインタを取得
			  qi ii,iii,dxs_iid_IUnknown
			  ; iii	/ IUnknown ポインタ
			  ; プロパティページを表示
			  prm=hwMainWnd,0,0,ptmp,1,piii,0,0,0,0,0
			  memcpy prm,tmp2,8,24,0
			  dllprocp FNC_OleCreatePropertyFrame,prm,11
			  ; IUnknown ポインタの破棄
			  ri iii
			  ; ページ情報用メモリ領域の解放
			  dllprocp FNC_CoTaskMemFree,prm.7,1
			 } else {
			  s+="(*)"
			  ri iii
			 }
			}
		 if funcid!FNC_OPEN_WND :tmp2+=s+"\n"
		 ; IFilterGraph ポインタの破棄
		 memcpy iii,tmp,4,0,256 :ri iii
		}
	 ; IBaseFilter ポインタの破棄
	 ri ii
	 if funcopt=cnt&(funcid=FNC_OPEN_WND) :break
	loop
	ri im
	return

	*@
	repeat 128
	 wpeek prm,tmp,cnt*2
	 if prm=0 {
	  prm.1=0,ptmp,cnt+1,ps,(cnt+1)*2,0,0
	  dllprocp FNC_WideCharToMultiByte,prm,8
	  break
	 }
	loop
	return

; ―――――――――――――――――――――――――――――――――――――
; 可変長形式で表された長さを取得する
;	使用値	tmp	データ
;		prm	可変長形式の開始位置
;	返り値	prm.1	長さ

*get_delta
	prm.1=0
	repeat 4
	 peek iii,tmp,prm
	 prm.1=prm.1<<7+(iii&$7F)
	 prm++
	 if iii&$80=0 :break
	loop
	return

; ―――――――――――――――――――――――――――――――――――――
; DDE制御を終わる

/*
*uninit_dde
	repeat
	 if dde_name="TMIDI" {
	  dde_dc
	  if dde_hwnd {
	   prm=dde_hwnd,WM_CLOSE,0,0
	   dllprocp FNC_SendMessageA,prm,4
	  }
	  break
	 }
	 if dde_name="WFP" {
	  dde_exec "/QUIT"
	  dde_dc
	  break
	 }
	 break
	loop
	return
*/

; ―――――――――――――――――――――――――――――――――――――
; ボタンに対するマウスの動きを追跡
;	使用値	i	オブジェクトID+41

*track_mouseleave
	prm=16,2,bmscr.i,0
	dllprocp FNC_TrackMouseEvent,pprm,1
	return


; ―――――――――――――――――――――――――――――――――――――
;                                                              (c) arc@arcis
