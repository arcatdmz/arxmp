
; ■ arX MusicPlayer で利用する変数などの初期化			_init_var.as
; ―――――――――――――――――――――――――――――――――――――

/* 制作メモ ――――――――――――――――――――――――――――――――

 ・この as ファイルについて

	変数の宣言と初期設定値の代入、ポップアップメニューの構築を行う

 ―――――――――――――――――――――――――――――――――――― */


; ―――――――――――――――――――――――――――――――――――――
; 変数の宣言
; ―――――――――――――――――――――――――――――――――――――

	prm=fi_p_,fi_p
	#define dim_(%1,%2)	dim %1,%2	:getptr i,%1 :ll_poke4 i,pfmo_info+prm.1 :prm.1+=4 :prmex=i,%2*4,$40,pi :dllprocp FNC_VirtualProtect,prmex,4
	#define sdim_(%1,%2)	sdim %1,%2	:getptr i,%1 :ll_poke4 i,pfmo_info+prm :prm+=4 :prmex=i,%2,$40,pi :dllprocp FNC_VirtualProtect,prmex,4
	#define sdima_(%1,%2,%3) sdim %1,%2,%3	:getptr i,%1 :ll_poke4 i,pfmo_info+prm :prm+=4 :prmex=i,%2*%3,$40,pi :dllprocp FNC_VirtualProtect,prmex,4

	; 設定ファイル内容
	dim xstheader			,nxstheader	

	; 再生リスト関連の情報と設定内容
	sdim_ list			,bufmax
	sdim list_			,bufmax
	dim linfo			,nlinfo
	sdim linfo_			,szlinfo_,nlinfo_

	; 再生中の音楽についての情報
	dim_ minfo			,nminfo
		dup mScrollType		minfo.8
	sdima_ minfo_			,szminfo_,nminfo_
		sdim mScroll		,2560

	; ウィンドウ関連の情報と設定内容
	dim dinfo			,ndinfo

	; ファイル一覧情報
	sdim finfo_			,szfinfo_,nfinfo_

	; スキン/外観情報
	dim_ sinfo			,nsinfo
	sdima_ sinfo_			,szsinfo_,nsinfo_
	dim sVar_type,svmax		; スキン変数種別
	sdim sVar_dsc,64,svmax		; 〃        内容説明
	sdim sVar_list,512,svmax	; 〃        内容選択肢一覧(\n区切り)
	sdim sVar_listdsc,512,svmax	; 〃        選択肢一覧項目の説明(\n区切り)
	sdim sVar,512,svmax		; 〃        内容

	; 口調情報
	sdima_ langs,szlangs,nlangs

	; スクリプト情報
	sdim script			,bufmax
	sdim scrfunc			,5,2
	sdim scrprms			,512,16
	dim scr				,nscr

	; メニュー情報
	dim_ hmenu			,nhmenu

	; 再生機構の情報
	dim pf				,npf
	sdim pf_			,szpf_,npf_

	; ウィンドウ情報
	dim obj				,objmax,3
	;	obj.objid	/ オブジェクトの持つ機能番号
	;	obj.objid.1	/ オブジェクトに貼り付けられたビットマップオブジェクトのハンドル
	;	obj.objid.2	/ オブジェクトに発生したイベントを処理するユーザー定義エリアの番号
	dim chk				,chkmax
	dim chk_			,chkmax
	;	chk.cid		/ チェックボックスの状態
	;	chk_.cid	/ 〃(状態変化検出用)
	dim chkid			,chkmax
	;	chkid.cid	/ IDが cid のチェックボックスの、オブジェクトID
	repeat objmax :obj.cnt=-1 :loop
	dim wi				,nwi		; 画面初期化情報

	; ファイル種情報
	sdima_ types			,sztypes,TP_PLAYABLE
	dim_ type			,TP_PLAYABLE

	; フォルダ情報
	sdima_ dir			,szdir,ndir


; ―――――――――――――――――――――――――――――――――――――
; 情報取得と初期設定値代入
; ―――――――――――――――――――――――――――――――――――――

	; OS 種別の取得
	prm=148 :dllproc "GetVersionExA",pprm,1,D_KERNEL
	if prm.4=1&(prm.1>=10)|(prm.4=2&(prm.1>=5)) :oschk=1

	; ユーザー名の取得
	ll_libload i,"advapi32"
	sdim prguser,64 :sdim user,64
	getptr prm,user :ii=64 :prm.1=pii
	dllproc "GetUserNameA",prm,2,i
	ll_libfree i
	repeat 1
	 if user=""		:break
	 if user="Guest"	:break
	 if user="guest"	:break
	 if user="既定"		:break
	 if user="Administrator":break
	 prguser=" for "+user	:break
	loop

	; フォルダパスの取得
	prm=512,ps :dllproc "GetTempPathA",prm,2,D_KERNEL :tmpdir=s
	prm=ps,512 :dllproc "GetSystemDirectoryA",prm,2,D_KERNEL :sysdir=s
	datdir=exedir+"\\d\\"
	skndir=exedir+"\\s\\"
	extdir=exedir+"\\e\\"

	; 自分のファイル名を取得
	sdim myself,512
	prm=0,0,512
	getptr prm.1,myself
	dllproc "GetModuleFileNameA",prm,3,D_KERNEL
	; そのアイコンのハンドルを取得
	prm=prm.1,0,0,0,1
	getptr prm.2,hIcon
	dllproc "ExtractIconExA",prm,5,D_SHELL

	; システム色ブラシのハンドル取得
	prm=15 :dllprocp FNC_GetSysColorBrush,prm,1 :hSysBrush =dllret
	prm=16 :dllprocp FNC_GetSysColorBrush,prm,1 :hSysBrush2=dllret
	; システム色の取得
	prm=15 :dllprocp FNC_GetSysColor,prm,1 :SysColor =dllret&$FF,dllret>>8&$FF,dllret>>16&$FF
	prm=16 :dllprocp FNC_GetSysColor,prm,1 :SysColor2=dllret&$FF,dllret>>8&$FF,dllret>>16&$FF

	; 初期設定値代入
	sFileName=defxsp
	lReqRefresh=1
	lSearchType=$000010FF
	lDownDblItem=1
	dispTiphelp=1
	dispTaskbar=1
	mTasktray=prgtitles
	mScrollType=11,1,7,6,8
	types.TP_MP3="MP3 MP2 MP1 RMP"	:type.TP_MP3=PF_MCI
	types.TP_WMA="WMA"		:type.TP_WMA=PF_DXS
	types.TP_MID="MID MIDI RMI"	:type.TP_MID=PF_DXS
	types.TP_WAV="WAV WAVE"		:type.TP_WAV=PF_MCI
	types.TP_OGG="OGG"		:type.TP_OGG=PF_DLL
	types.TP_CDA="CDA"		:type.TP_CDA=PF_MCI
					 type.TP_MCI=PF_MCI
					 type.TP_DXS=PF_DXS


; ―――――――――――――――――――――――――――――――――――――
; ポップアップメニューの構築
; ―――――――――――――――――――――――――――――――――――――

		nmenu hmMinfoSub
		imenu "フルパス"	,FNC_CLIP+IDX_CLIP_MINFO+4,0,hmMinfoSub
		imenu "アルバムのタイトル",FNC_CLIP+IDX_CLIP_MINFO+5,0,hmMinfoSub
		imenu "発売日"		,FNC_CLIP+IDX_CLIP_MINFO+6,0,hmMinfoSub
		imenu "コメント"	,FNC_CLIP+IDX_CLIP_MINFO+3,0,hmMinfoSub
		imenu "音楽ファイルの種類",FNC_CLIP+IDX_CLIP_MINFO+7,0,hmMinfoSub
		nmenu hmMinfoSubPf
		;imenu "MCI",FNC_CLIP+IDX_CLIP_MINFO+7,0,hmMinfoSub
	nmenu hmMinfo
	imenu "著作者: "	,FNC_CLIP+IDX_CLIP_MINFO+1,0,hmMinfo
	imenu "タイトル: "	,FNC_CLIP+IDX_CLIP_MINFO+2,0,hmMinfo
	imenu "ファイル名: "	,FNC_CLIP+IDX_CLIP_MINFO+0,0,hmMinfo
	imenu "その他の情報をコピー",0,hmMinfoSub,hmMinfo
	imenu ""		,0,0,hmMinfo
	imenu "プロパティを表示",FNC_OPEN_PROPERTY|FNC_AUTO+IDX_CUR,0,hmMinfo
	imenu "親フォルダを開く",FNC_OPEN_PARENTDIR|FNC_AUTO+IDX_CUR,0,hmMinfo
	imenu "情報画面を開く"	,FNC_OPEN_WND|FNC_ON+widInfo,0,hmMinfo
	imenu "再生に使用している仕組み",0,hmMinfoSubPf,hmMinfo
	nmenu hmPlay
	imenu "次のファイル"	,FNC_PLAY|FNC_AUTO+IDX_CUR_NEXT,0,hmPlay
	imenu "前のファイル"	,FNC_PLAY|FNC_AUTO+IDX_CUR_PREV,0,hmPlay
	imenu ""		,0,0,hmPlay
	imenu "一時停止/再生再開",FNC_PAUSE,0,hmPlay
	imenu "再生停止"	,FNC_STOP,0,hmPlay
	imenu "選択中のファイルを再生",FNC_PLAY|FNC_AUTO+IDX_SEL,0,hmPlay
	nmenu hmMode
	imenu "&NOR\t(ノーマル)",FNC_MODE|FNC_ON+PM_NOR,0,hmMode; 通常再生
	imenu "RE&V\t(リバース)",FNC_MODE|FNC_ON+PM_REV,0,hmMode; 逆順再生
	imenu "RN&D\t(ランダム)",FNC_MODE|FNC_ON+PM_RND,0,hmMode; 無作為順
	imenu "RE&P\t(リピート)",FNC_MODE|FNC_ON+PM_REP,0,hmMode; 一曲繰返
	imenu "&STP\t(ストップ)",FNC_MODE|FNC_ON+PM_STP,0,hmMode; 一曲停止
	imenu "&MDR\t(レコード)",FNC_MODE|FNC_ON+PM_MDR,0,hmMode; 曲間空白
				nmenu hmFavSaveSub
				; (お気に入り一覧)
				; imenu "",FNCM_XLT_SAVE+fileidx
			nmenu hmFavSave
			imenu "新規登録",FNCM_XLT_SAVEEX,0,hmFavSave
			imenu "上書き保存",0,hmFavSaveSub,hmFavSave
		nmenu hmFav
		imenu "現在の再生リストを...",0,hmFavSave,hmFav
		imenu ""	,0,0,hmFav
		; (お気に入り一覧)
		; imenu "",FNCM_XLT_LOAD+fileidx
		imenu ""	,0,0,hmFav
		imenu "一覧更新",FNCM_XLT_LOADEX,0,hmFav
		imenu "編集",FNCM_XPI_LOAD+IDX_XPI_CFGFAVORITE,0,hmFav
	nmenu hmList
	imenu "お気に入り"	,0,hmFav,hmList
	imenu "ファイルを追加"	,FNC_OBJ402+objList_AddFile,0,hmList
	imenu "フォルダを追加"	,FNC_OBJ402+objList_AddFolder,0,hmList
	imenu "名前順並び替え"	,FNC_OBJ402+objList_Sort,0,hmList
	imenu "全ファイル存在確認",FNC_OBJ402+objList_CheckAll,0,hmList
	imenu ""		,0,0,hmList
	imenu "リスト画面を開く/閉じる",FNC_OBJ402+objWindow_OpenList,0,hmList
			nmenu hmLanguage
			; (言語ファイル一覧)
			; imenu "",FNC_XMS_LOAD+fileidx
			imenu ""	,0,0,hmLanguage
			imenu "一覧更新",FNC_XMS_LOAD|FNC_REFRESH,0,hmLanguage
		nmenu hmSkinSub
		imenu "著作者: "  ,FNC_CLIP+IDX_CLIP_SINFO+1,0,hmSkinSub
		imenu "タイトル: ",FNC_CLIP+IDX_CLIP_SINFO+2,0,hmSkinSub
		imenu "コメント: ",FNC_CLIP+IDX_CLIP_SINFO+3,0,hmSkinSub
		imenu "言語ファイル",0,hmLanguage,hmSkinSub
		nmenu hmSkinSubModify
		; (編集項目一覧)
		; imenu "",FNC_XSP_MODIFY+idx,0,hmSkinSubModify
		imenu "",0,0,hmSkinSubModify
		imenu "ファイルから設定を読み込む",FNC_XSS_LOAD,0,hmSkinSubModify
		imenu "現在の設定をファイルに保存する",FNC_XSS_SAVE,0,hmSkinSubModify
		imenu "初めの設定に戻す",FNC_XSP_MODIFY|FNC_OFF,0,hmSkinSubModify
	nmenu hmSkin
	; (スキン一覧)
	; imenu "",FNC_XSP_LOAD+fileidx,0,hmSkin
	imenu ""	,0,0,hmSkin
	imenu "一覧更新",FNC_XSP_LOAD|FNC_REFRESH,0,hmSkin
	imenu ""	,0,0,hmSkin
	imenu "現在のスキンの情報",0,hmSkinSub,hmSkin
	imenu "現在のスキンを編集",0,hmSkinSubModify,hmSkin
	nmenu hmPlugin
	; (プラグイン一覧)
	; imenu "",FNC_XPI_LOAD+fileidx,0,hmPlugin
	imenu ""	,0,0,hmPlugin
	imenu "一覧更新",FNC_XPI_LOAD|FNC_REFRESH,0,hmPlugin
	nmenu hmScript
	; (スクリプト一覧)
	; imenu "",FNC_XS_LOAD|FNC_AUTO+fileidx,0,hmScript
	imenu ""	,0,0,hmScript
	imenu "一覧更新",FNC_XS_LOAD|FNC_REFRESH,0,hmScript
	imenu "一覧以外のスクリプトを実行",FNC_XS_LOAD,0,hmScript
		nmenu hmSetListSub
		imenu "M&PEG Audio",FNCM_SET_SEARCH+TP_MP3,0,hmSetListSub
		imenu "WindowsMedia&Audio",FNCM_SET_SEARCH+TP_WMA,0,hmSetListSub
		imenu "Mi&di",FNCM_SET_SEARCH+TP_MID,0,hmSetListSub
		imenu "&Wave",FNCM_SET_SEARCH+TP_WAV,0,hmSetListSub
		imenu "&OggVorbis",FNCM_SET_SEARCH+TP_OGG,0,hmSetListSub
		imenu "&CD Audio",FNCM_SET_SEARCH+TP_CDA,0,hmSetListSub
		imenu "(上記以外の)&MCIで再生できるファイル",FNCM_SET_SEARCH+TP_MCI,0,hmSetListSub
		imenu "(〃)&DirectShowで再生できるファイル",FNCM_SET_SEARCH+TP_DXS,0,hmSetListSub
		imenu "",0,0,hmSetListSub
		imenu "サブフォルダの中身(&S)",FNCM_SET_SEARCH+TP_DIR,0,hmSetListSub
		imenu "リストファイルの中身(&L)",FNCM_SET_SEARCH+TP_XLT,0,hmSetListSub
		imenu "",0,0,hmSetListSub
		imenu "全てにチェックを付す/外す(&A)",FNCM_SET_SEARCHEX,0,hmSetListSub
		nmenu hmSetList
		imenu "重複ファイルは最下行に移動",FNCM_SET+IDX_SET_LIST_DOWNDBLITEM,0,hmSetList
		imenu "リストファイルは新規再生リストに読込",FNCM_SET+IDX_SET_LIST_CLEARONLOAD,0,hmSetList
		nmenu hmSetDisp
		imenu "ボタンなどにチップヘルプを表示",FNCM_SET+IDX_SET_DISP_TIPHELP,0,hmSetDisp
		imenu "メイン画面を常に最前面表示",FNCM_SET+IDX_SET_DISP_ONTOP,0,hmSetDisp
		imenu "タスクトレイに常にアイコンを表示",FNCM_SET+IDX_SET_DISP_TRAYICON,0,hmSetDisp
		imenu "(メイン画面不定形時)タスクバーにタイトル表示",FNCM_SET+IDX_SET_DISP_TASKBAR,0,hmSetDisp
		nmenu hmSetPlay
		imenu "音楽情報の取得に mp3infp を使用",FNCM_LOADLIB+IDX_LOAD_MP3INFP,0,hmSetPlay
		imenu "再生リストを繰返し再生",FNC_OBJ402+objList_ChangeListLoop,0,hmSetPlay
		imenu "起動時に前回終了時の再生箇所を再現",FNCM_SET+IDX_SET_PLAY_REPLAY,0,hmSetPlay
		imenu "",0,0,hmSetPlay
		imenu "再生に使用する仕組みの変更",FNCM_XPI_LOAD+IDX_XPI_SETPLAYFUNC,0,hmSetPlay
		imenu "再生できるファイル種の設定",FNCM_XPI_LOAD+IDX_XPI_SETPLAYTYPE,0,hmSetPlay
	nmenu hmSet
	imenu "再生リストの登録対象",0,hmSetListSub,hmSet
	imenu "リスト編集",0,hmSetList,hmSet
	imenu "画面表示",0,hmSetDisp,hmSet
	imenu "音楽再生",0,hmSetPlay,hmSet
	nmenu hmOnMain
	imenu "音楽の情報\t(&I)",0,hmMinfo,hmOnMain
	imenu "音楽の再生\t(&P)",0,hmPlay,hmOnMain
	imenu "再生モード\t(&M)",0,hmMode,hmOnMain
	imenu "再生リスト\t(&L)",0,hmList,hmOnMain
	imenu ""		,0,0,hmOnMain
	imenu "スキン\t(&S)"	,0,hmSkin,hmOnMain
	imenu "プラグイン\t(&P)",0,hmPlugin,hmOnMain
	imenu "スクリプト\t(&X)",0,hmScript,hmOnMain
	imenu "設定　　　\t(&C)",0,hmSet,hmOnMain
	imenu ""		,0,0,hmOnMain
	imenu "最小化　\t(&Z)"	,FNC_MINIMIZE|FNC_AUTO,0,hmOnMain
	imenu "音量の調整\t(&V)",FNC_XPI_LOAD|FNC_AUTO+IDX_XPI_VOLUME,0,hmOnMain
	imenu "ヘルプの表示\t(&H)",FNC_XPI_LOAD|FNC_AUTO+IDX_XPI_HELP,0,hmOnMain
	imenu "プレイヤーの終了\t(&Q)",FNC_OPEN_WND+widMain,0,hmOnMain

	nmenu hmListSel
	imenu "一つ上へ移動"	,FNC_LIST_UP|FNC_AUTO+IDX_SEL,0,hmListSel
	imenu "一つ下へ移動"	,FNC_LIST_DOWN|FNC_AUTO+IDX_SEL,0,hmListSel
	imenu "項目の削除"	,FNC_LIST_CLEAR|FNC_AUTO+IDX_SEL,0,hmListSel
	imenu "ごみ箱に捨てる"	,FNC_LIST_DELETE|FNC_AUTO+IDX_SEL,0,hmListSel
	imenu "名前を変更"	,FNC_LIST_RENAME|FNC_AUTO+IDX_SEL,0,hmListSel
	imenu ""		,0,0,hmListSel
	imenu "再生"		,FNC_PLAY|FNC_AUTO+IDX_SEL,0,hmListSel
	imenu "プロパティを表示",FNC_OPEN_PROPERTY|FNC_AUTO+IDX_SEL,0,hmListSel
	imenu "親フォルダを開く",FNC_OPEN_PARENTDIR|FNC_AUTO+IDX_SEL,0,hmListSel
	nmenu hmOnList
	imenu "選択項目",0,hmListSel,hmOnList
	imenu ""		,0,0,hmOnList
	imenu "お気に入り"	,0,hmFav,hmOnList
	imenu "ファイルを追加"	,FNC_LIST_ADD_FILE,0,hmOnList
	imenu "フォルダを追加"	,FNC_LIST_ADD_FOLDER,0,hmOnList
	imenu "名前順並び替え"	,FNC_LIST_SORT|FNC_ALL,0,hmOnList
	imenu "全ファイル存在確認",FNC_LIST_CHECK|FNC_ALL,0,hmOnList
	imenu "設定 - リスト編集",0,hmSetList,hmOnList
	imenu "設定 - 再生リストの登録対象",0,hmSetListSub,hmOnList


; ―――――――――――――――――――――――――――――――――――――
;                                                              (c) arc@arcis
