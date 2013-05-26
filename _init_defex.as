
; ■ arX MusicPlayer に関する定義(2)			      _init_defex.as
; ―――――――――――――――――――――――――――――――――――――

/* 制作メモ ――――――――――――――――――――――――――――――――

 ・この as ファイルについて

	プレイヤー起動中に変更されない様々な情報をここで定義しておく

 ―――――――――――――――――――――――――――――――――――― */

	#const X_DEFEX		1

; ―――――――――――――――――――――――――――――――――――――
; 1. 色々。
; ―――――――――――――――――――――――――――――――――――――

	; ウィンドウメッセージID
	#const WM_EXECFUNC	$550
	#const WM_TASKTRAY	$552
	#const WM_NOTIFYPI	$550
	#const WM_CLOSE		$010
	#const WM_KEYUP		$101
	#const WM_COMMAND	$111
	#const WM_LBUTTONDOWN	$201
	#const WM_LBUTTONUP	$202
	#const WM_LBUTTONDBLCLK	$203
	#const WM_RBUTTONUP	$205
	#const WM_DROPFILES	$233
	#const WM_MOUSEMOVE	$200
	#const WM_MOUSELEAVE	$2A3
	; その他 Windows の指定する定数
	#const LB_ADDSTRING	$180
	#const LB_INSERTSTRING	$181
	#const LB_DELETESTRING	$182
	#const LB_SETCURSEL	$186
	#const CB_ADDSTRING	$143
	#const CB_DELETESTRING	$144
	#const CB_INSERTSTRING	$14A
	#const CB_SETCURSEL	$14E
	#const VK_RETURN	$0D
	#const VK_DELETE	$2E
	#const VK_APPS		$5D

	; プレイヤーの制約値
	#const bufmax		65536	; 扱えるデータの最大長(bytes)
	#const objmax		64	; 設置できるオブジェクトの最大数
	#const chkmax		64	; 〃　　　　チェックボックス　〃
	#const svmax		16	; スキン変数の最大数

	; 時間の設定
	#const TI_REFRESH	4	; ループ2回ごとに画面を更新
	#const TI_SCROLL	10	; ループ10回ごとにスクロール文字列を進める
	#const TI_TITLE		20	; ループ20回の間、変更したタイトルを保持

	; スキン変数の種類値
	#const SV_COLOR		0	; 色
	#const SV_STR		1	; 文字列
	#const SV_IMAGE		2	; 画像
	#const SV_INT		3	; 数値
	#const SV_FONT		4	; フォント
	#const SV_LIST		5	; 一覧から選択

	; プラグイン関連値
	;  (cf.) arxmp.as & _func.as
	#const NP_FUNCRET	0	; プラグインへの機能実行結果通知
	#const NP_ST		1	; プラグインへの再生状態変更通知
	;  (cf.) _init_var.as
	#define global fmo_info	"arxmp_info"	; FileMappingObjectの名前
	#const global szfmo_info	160	; 全情報サイズ
	#const global fi_p		32	; ポインタ情報(1)オフセット
	#const global fi_p_		64	; 　　〃　　　(2)　〃
	#const global szfmo_send	32	; 各ハンドル情報領域のサイズ
	#const global fi_send_mStatus	96	; 再生状況を通知するウィンドウのハンドル情報オフセット
	#const global fi_send_onexit	128	; 終了時に連動させる　〃

	; その他の値
	#define type_minfo	"フルパス\nﾌｧｲﾙ名\n製作者\nタイトル\nアルバム\n発売日\nコメント\nﾌｫｰﾏｯﾄ\nﾌｧｲﾙｻｲｽﾞ\n長さ\n音質\n通し番号\n無し"
	#define mci_alias	"arxmp"		; MCIのエイリアス名
	#define sep		" - "	; タイトルをつなぐ記号
	#define defxsp		"初期設定.xsp"	;
	#define defxms		"初期設定.xms"	;
	#define defxlt		"お気に入り"	;
	;#define defdde_dir extdir+"TMIDI Player\\"
	;#define defdde_name "TMIDI"		;
	#const xstgenuine	$74737821	; 設定ファイルのヘッダ値
	#const initializing	$0F000000	; 初期化中であることを示す値
	#const closing		$0E000000	; 終了中であることを示す値
	#const hovering		$0F000000	; マウスがボタン上にあることを示す値


; ―――――――――――――――――――――――――――――――――――――
; 2. 変数名に関する定義
; ―――――――――――――――――――――――――――――――――――――

	; notesel, dirlist 用変数の初期サイズ
	#const bufnd			64

	; DLLのハンドル
	#const nD			10
	dim D,nD
		#define D_GDI		D
		#define D_USER		D.1
		#define D_SHELL		D.2
		#define D_KERNEL	D.3
		#define D_COMDLG	D.4
		#define D_OLE		D.5
		#define D_VOX		D.6
		#define D_VBMP3		D.7
		#define D_MP3INFP	D.8
		#define D_OLEPRO	D.9

	; 設定ファイル内容
	#const nxstheader		48
		#define setVmain	xstheader.1	; 前回起動時のプレイヤーのバージョン
		#define MainWndX	xstheader.2	; メイン画面位置(Ｘ座標)
		#define MainWndY	xstheader.3	; 〃		(Ｙ座標)
		#define ListWndX	xstheader.4	; リスト画面位置(Ｘ座標)
		#define ListWndY	xstheader.5	; 〃		(Ｙ座標)
		#define ListWndWidth	xstheader.6	; 〃　　　　幅
		#define ListWndHeight	xstheader.7	; 〃　　　　高さ

	; 再生リスト関連の情報と設定内容
	#const nlinfo			10
		#define lNum		linfo		; 再生リストに登録されている項目数
		#define lLength		linfo.1		; 再生リストに登録されている項目名全長
		#define lReqRefresh	linfo.2		; list_ の内容を更新する必要がある(1)か否(0)か
		#define lSelectedIdx	linfo.3		; 再生リストで選択されている項目の位置
		#define lEditingIdx	linfo.4		; 現在編集対象となっている項目の位置
		#define lSearchType	linfo.5		; 再生リストに登録する対象とする項目の種類
		#define lDownDblItem	linfo.6		; 重複項目を最下行に移動する(1)か否(0)か
		#define lClearOnLoad	linfo.7		; リストファイル読み込み時に再生リストを一旦消去する(1)か否(0)か
		#define lMode		linfo.8		; 再生モード
		#define lReplay		linfo.9		; 起動時の再生箇所再現
	#const nlinfo_			3
	#const szlinfo_			512
		#define lEditingFrom	linfo_		; 編集対象となっているファイルの元の名前
		#define lEditingDir	linfo_.1	; 編集対象となっているファイルの親フォルダのパス
		#define lCurDir		linfo_.2	; 検索対象のフォルダのパス

	; 再生中の音楽についての情報
	#const nminfo			13
		#define mFileIdx	minfo		; 再生中の音楽のリスト中での位置
		#define mFileType	minfo.1		; 〃　　　　　　種類(TPEX_*)
		#define mFileSize	minfo.2		; 〃　　　　　　ファイルサイズ[bytes]
		#define mStatus		minfo.3		; 〃　　　　　　状態(ST_*)
		#define mPosition	minfo.4		; 〃　　　　　　再生位置[ms]
		#define mDuration	minfo.5		; 〃　　　　　　全長[ms]
		#define mQuality	minfo.6		; 〃　　　　　　音質[kbps]
		#define mScrollWidth	minfo.7		; 〃　　　　　　情報を表す文字列の横幅[px]
		;dup mScrollType	minfo.8		; 〃		　　　　　　　　　種類(minfo.8-12)
	#const nminfo_			9
	#const szminfo_			512
		#define mFileName	minfo_		; 〃　　　　　　ファイル名
		#define mAuthor		minfo_.1	; 〃　　　　　　著作者
		#define mName		minfo_.2	; 〃　　　　　　タイトル
		#define mComment	minfo_.3	; 〃　　　　　　コメント
		#define mFilePath	minfo_.4	; 〃　　　　　　フルパス
		#define mAlbumName	minfo_.5	; 〃　　　　　　アルバムのタイトル
		#define mRelDate	minfo_.6	; 〃　　　　　　発売日
		#define mFormat		minfo_.7	; 〃　　　　　　その他の情報
		#define mTasktray	minfo_.8	; タスクトレイに表示する情報
		;#define mScroll	minfo_.9	; 〃　　　　　　情報を表す文字列(スクロール用)

	; ウィンドウ関連の情報と設定内容
	#const ndinfo			16
		#define hwMainWnd	dinfo		; メイン画面のハンドル
		#define hwListWnd	dinfo.1		; リスト画面のハンドル
		#define hwInfoWnd	dinfo.2		; 情報画面のハンドル
		#define hwList		dinfo.3		; メイン画面にあるリストのハンドル
		#define hwListSub	dinfo.4		; リスト画面にあるリストのハンドル
		#define hIcon		dinfo.5		; アイコンのハンドル
		#define hSysBrush	dinfo.6		; システム色ブラシのハンドル
		#define hSysBrush2	dinfo.7		; 〃　　　　　　　　　　　　(影色)
		#define dispMainWnd	dinfo.8		; メイン画面を最前面表示する(+1)か否(+0)か、最小化されている(+2)か否(+0)か
		#define dispListWnd	dinfo.9		; リスト画面を表示している(1)か否(0)か
		#define dispInfoWnd	dinfo.10	; 情報ウィンドウを表示している(1 + (0,$100,$200,$*400))か否(0)か
		#define dispListArea	dinfo.11	; リスト領域を表示している(1)か否(0)か
		#define dispTiphelp	dinfo.12	; チップヘルプを表示している(1)か否(0)か
		#define dispTrayicon	dinfo.13	; トレイアイコンを常時表示する(1)か否(0)か
		#define dispTaskbar	dinfo.14	; タスクバーにタイトルを表示する(1)か否(0)か
		#define dispTitle	dinfo.15	; メイン画面タイトルの変更要求(1-)

	; ファイル一覧情報
	#const nfinfo_			5
	#const szfinfo_			16384
		#define fXSP		finfo_		; スキン一覧
		#define fXMS		finfo_.1	; 言語ファイル一覧
		#define fXLT		finfo_.2	; リストファイル一覧
		#define fXS		finfo_.3	; スクリプトファイル一覧
		#define fXPI		finfo_.4	; プラグイン一覧

	; スキン/外観情報
	#const nsinfo			23
		#define snAreaUser	sinfo		; ユーザー定義エリア数
		#define snObj		sinfo.1		; 設置オブジェクト数
		#define snChk		sinfo.2		; 設置チェックボックス数
		#define snVar		sinfo.3		; スキン変数の数
		#define sWid		sinfo.4		; メイン画面ID
		#define sList		sinfo.5		; リスト種別 (0 リストボックス,1 コンボボックス)
		#define sListArea	sinfo.6		; リスト領域種別 (0 通常,1 スクロール,2 別画面リスト)
		#define sScrollStep	sinfo.7		;
		#define sScrollWidth	sinfo.8		;
		#define sDragX		sinfo.9
		#define sDragY		sinfo.10
		#define sDragWidth	sinfo.11
		#define sDragHeight	sinfo.12
		#define sSeekX		sinfo.13
		#define sSeekY		sinfo.14
		#define sSeekWidth	sinfo.15
		#define sSeekHeight	sinfo.16
		#define sSeekDirection	sinfo.17
		#define sEditingIdx	sinfo.18	; 編集中のスキン変数ID
		#define MainWndWidth	sinfo.19
		#define MainWndHeight	sinfo.20
		#define ListAreaWidth	sinfo.21
		#define ListAreaHeight	sinfo.22
	#const nsinfo_			5
	#const szsinfo_			512
		#define sFileName	sinfo_		; 現在のスキンのファイル名
		#define sAuthor		sinfo_.1	; 〃　　　　　　著作者
		#define sName		sinfo_.2	; 〃　　　　　　タイトル
		#define sComment	sinfo_.3	; 〃　　　　　　コメント
		#define sLanguage	sinfo_.4	; 〃　　　　　に関連付けられた言語ファイル

	; 口調情報
	; 11 + (PM_*)14 + (ST_*)4 + (TP_*)6+2 + (obj)41
	#const nlangs			79
	#const szlangs			256
	#const lgObj			32
	#const lgPMTI			73

	; スクリプト情報
	#const nscr			4
		#define scrVersion	scr
		#define scrType		scr.1
		#define scrTypeEx	scr.2
		#define scrLine		scr.3

	; メニュー情報
	#const nhmenu			24
		#define hmBar		hmenu
		#define hmOnMain	hmenu.1
		#define hmOnList	hmenu.2
		#define hmMinfo		hmenu.3
		#define hmMinfoSub	hmenu.4
		#define hmMinfoSubPf	hmenu.5
		#define hmPlay		hmenu.6
		#define hmMode		hmenu.7
		#define hmList		hmenu.8
		#define hmFav		hmenu.9
		#define hmFavSave	hmenu.10
		#define hmFavSaveSub	hmenu.11
		#define hmSkin		hmenu.12
		#define hmSkinSub	hmenu.13
		#define hmSkinSubModify	hmenu.14
		#define hmLanguage	hmenu.15
		#define hmPlugin	hmenu.16
		#define hmScript	hmenu.17
		#define hmSet		hmenu.18
		#define hmSetList	hmenu.19
		#define hmSetListSub	hmenu.20
		#define hmSetDisp	hmenu.21
		#define hmSetPlay	hmenu.22
		#define hmListSel	hmenu.23

	; 再生機構の情報
	#const npf			40
		; プロパティ数
		#define npfprop			pf.35	;
		; DirectX DirectShow
		#define dxs_clsid_FilterGraph	pf	; CLSID	┐
		#define dxs_iid_IUnknown	pf.4	; IID	┴ 取得にそれぞれ 16byte 必要
		#define dxs_iid_IGraphBuilder	pf.8	;	    (LONGLONG型, 配列 4 個分)
		#define dxs_iid_IMediaControl	pf.12	;
		#define dxs_iid_IMediaSeeking	pf.16	;
		#define dxs_iid_IBasicAudio	pf.20	;
		#define dxs_iid_ISpecifyPropertyPages pf.24;
		#define dxs_gb			pf.28	; 上記IDを元に取得したインターフェース
		#define dxs_mc			pf.29	;                   へのポインタ格納用
		#define dxs_ms			pf.30	;
		#define dxs_ba			pf.31	;
		; MCI
		#define mci_cdatrackstart	pf.32	; トラックの開始位置
		#define mci_cdapaused		pf.33	; 一時停止している(1)か否(0)か
		; Vox
		#define vox_id			pf.34	; Vox.dll 音楽ID
		; DDE
		/*
		#define global dde_inst		pf@.36	; DDEのインスタンスID
		#define global dde_hconv	pf@.37	; DDEの通信ハンドル
		#define dde_hwnd		pf.38	; DDE通信の相手のウィンドウハンドル
		#define dde_idx			pf.39	; DDE通信の相手が保持する再生リスト中での再生ファイル位置
		*/
	#const npf_			4
	#const szpf_			512
		; MCI
		#define mci_device		pf_	; デバイス名
		; DirectShow
		#define dxs_filter		pf_.1	; フィルタ一覧
		; DDE
		#define dde_dir			pf_.2	; DDEサーバーがあるフォルダ
		#define dde_name		pf_.3	; DDEサーバーのファイル名

	; 機能情報
	#const nfunc			4
		#define funcid		func.1		; func&$FFFF0000
		#define funcopt		func.2		; func&$0000FFFF
		#define funcret		func.3		; 返り値

	; ウィンドウ情報
	#const nwi			7

	; ファイル種情報
	; #const ntypes			TP_PLAYABLE
	; #const ntype			TP_PLAYABLE
	#const sztypes			256

	; その他の情報
	#const nstt			3
		#define mainloop	stt
		#define hfmo_info	stt.1
		#define pfmo_info	stt.2

	; フォルダ情報
	#const ndir			5
	#const szdir			512
		#define skndir		dir
		#define datdir		dir.1
		#define extdir		dir.2
		#define sysdir		dir.3
		#define tmpdir		dir.4


; ―――――――――――――――――――――――――――――――――――――
; 3. 機能に関する定義
; ―――――――――――――――――――――――――――――――――――――

	; 機能番号
	#const FNC_OBJ402		700

	; 機能オプション
	;#const OBJ_BUTTON	$00000000	;

	; 機能の返り値
	#const FR_IDLE		$0F000001 ; 特に意味の無い値
	#const FR_ERR		$0F000000 ; 失敗
	#const FR_DONE		$00000000 ; 成功


; ―――――――――――――――――――――――――――――――――――――
; 4. メニューバーの項目IDに関する定義
; ―――――――――――――――――――――――――――――――――――――

	; 設定
	#const FNCM		$300
	#const FNCM_SET		$300
	#const FNCM_SET_SEARCH	$400
	#const FNCM_SET_SEARCHEX $500
	#const FNCM_XPI_LOAD	$600
	#const FNCM_LOADLIB	$700
	#const FNCM_XLT_LOAD	$800
	#const FNCM_XLT_LOADEX	$A00
	#const FNCM_XLT_SAVE	$B00
	#const FNCM_XLT_SAVEEX	$D00


; ―――――――――――――――――――――――――――――――――――――
; 5. オブジェクト識別子と旧機能番号に関する定義
; ―――――――――――――――――――――――――――――――――――――

	#const objs		41

	sdim obj_key,24,objs
	dim obj_func,objs

	; ウィンドウ
	#const objWindow_OpenList	0
	#const objWindow_CloseList	1
	#const objWindow_OpenListArea	2
	#const objWindow_OpenInfo	3
	#const objWindow_MinimizeMain	5
	#const objWindow_ShowProperty	31
	#const objWindow_ShowFolder	4
	#const objMusic_CfgVolume	6
	#const objExit			30
	obj_key.objWindow_OpenList	="listwindow"
	obj_key.objWindow_CloseList	="closelistwindow"
	obj_key.objWindow_OpenListArea	="listarea"
	obj_key.objWindow_OpenInfo	="infowindow"
	obj_key.objWindow_MinimizeMain	="minimize"
	obj_key.objWindow_ShowProperty	="showproperty"
	obj_key.objWindow_ShowFolder	="showfolder"
	obj_key.objMusic_CfgVolume	="cfgvolume"
	obj_key.objExit			="exit"
	obj_func.objWindow_OpenList	=FNC_OPEN_WND|FNC_AUTO+widList
	obj_func.objWindow_CloseList	=FNC_OPEN_WND|FNC_OFF+widList
	obj_func.objWindow_OpenListArea	=FNC_OPEN_LISTAREA|FNC_AUTO
	obj_func.objWindow_OpenInfo	=FNC_OPEN_WND|FNC_AUTO+widInfo+IDX_WND_MINFO
	obj_func.objWindow_MinimizeMain	=FNC_MINIMIZE|FNC_AUTO
	obj_func.objWindow_ShowProperty	=FNC_OPEN_PROPERTY|FNC_AUTO+IDX_CUR
	obj_func.objWindow_ShowFolder	=FNC_OPEN_PARENTDIR|FNC_AUTO+IDX_CUR
	obj_func.objMusic_CfgVolume	=FNC_XPI_LOAD|FNC_AUTO+IDX_XPI_VOLUME
	obj_func.objExit		=FNC_OPEN_WND+widMain

	; メニュー
	#const objMenu_PopupFavorite	7
	#const objFile_SaveFavorite	29
	#const objMenu_Popup		32
	obj_key.objMenu_PopupFavorite	="favorite"
	obj_key.objFile_SaveFavorite	="savefavr"
	obj_key.objMenu_Popup		="popup"
	obj_func.objMenu_PopupFavorite	=FNC_POPUP+9
	obj_func.objFile_SaveFavorite	=FNC_POPUP+10
	obj_func.objMenu_Popup		=FNC_POPUP+1

	; 音楽再生
	#const objMusic_Play		8
	#const objMusic_PlayPrev	9
	#const objMusic_PlayNext	10
	#const objMusic_Pause		11
	#const objMusic_Stop		12
	obj_key.objMusic_Play		="play"
	obj_key.objMusic_PlayPrev	="prev"
	obj_key.objMusic_PlayNext	="next"
	obj_key.objMusic_Pause		="pause"
	obj_key.objMusic_Stop		="stop"
	obj_func.objMusic_Play		=FNC_PLAY|FNC_AUTO+IDX_SEL
	obj_func.objMusic_PlayPrev	=FNC_PLAY|FNC_AUTO+IDX_CUR_PREV
	obj_func.objMusic_PlayNext	=FNC_PLAY|FNC_AUTO+IDX_CUR_NEXT
	obj_func.objMusic_Pause		=FNC_PAUSE
	obj_func.objMusic_Stop		=FNC_STOP

	; リスト編集
	#const objMainlist		13	; リストボックス
	#const objMainlistc		14	; コンボボックス
	#const objList_AddFolderchk	15
	#const objList_ChangeMode	16
	#const objList_ChangeListLoop	38
	#const objList_AddFile		17
	#const objList_AddFolder	18
	#const objList_ClrFile		19
	#const objList_ClrAll		20
	#const objList_DelFile		21
	#const objList_RenameFile	22
	#const objList_CheckAll		23
	#const objList_Sort		24
	#const objList_MoveUpFile	25
	#const objList_MoveDownFile	26
	#const objList_Save		27
	#const objList_Load		28
	#const objList_ShowProperty	40
	#const objList_ShowFolder	39
	obj_key.objMainlist		="mainlist"
	obj_key.objMainlistc		="maincomlist"
	obj_key.objList_AddFolderchk	="addfolderchk"
	obj_key.objList_ChangeMode	="mode"
	obj_key.objList_ChangeListLoop	="repmode"
	obj_key.objList_AddFile		="addfile"
	obj_key.objList_AddFolder	="addfolder"
	obj_key.objList_ClrFile		="clearfile"
	obj_key.objList_ClrAll		="clearlist"
	obj_key.objList_DelFile		="delete"
	obj_key.objList_RenameFile	="rename"
	obj_key.objList_CheckAll	="checklist"
	obj_key.objList_Sort		="sortlist"
	obj_key.objList_MoveUpFile	="moveup"
	obj_key.objList_MoveDownFile	="movedown"
	obj_key.objList_Save		="savelist"
	obj_key.objList_Load		="loadlist"
	obj_key.objList_ShowProperty	="showproperty_s"
	obj_key.objList_ShowFolder	="showfolder_s"
	obj_func.objMainlist		=FNC_PLAYLIST
	obj_func.objMainlistc		=FNC_PLAYLISTC
	obj_func.objList_AddFolderchk	=FNC_SET_SEARCH|FNC_AUTO|OBJ_CHKBOX+TPEX_DIR
	obj_func.objList_ChangeMode	=FNC_MODE|FNC_AUTO
	obj_func.objList_ChangeListLoop	=FNC_MODE|FNC_AUTO+PM_REPLIST
	obj_func.objList_AddFile	=FNC_LIST_ADD_FILE
	obj_func.objList_AddFolder	=FNC_LIST_ADD_FOLDER
	obj_func.objList_ClrFile	=FNC_LIST_CLEAR|FNC_AUTO+IDX_SEL
	obj_func.objList_ClrAll		=FNC_LIST_CLEAR|FNC_ALL
	obj_func.objList_DelFile	=FNC_LIST_DELETE|FNC_AUTO+IDX_SEL
	obj_func.objList_RenameFile	=FNC_LIST_RENAME|FNC_AUTO+IDX_SEL
	obj_func.objList_CheckAll	=FNC_LIST_CHECK|FNC_ALL
	obj_func.objList_Sort		=FNC_LIST_SORT|FNC_ALL
	obj_func.objList_MoveUpFile	=FNC_LIST_UP|FNC_AUTO+IDX_SEL
	obj_func.objList_MoveDownFile	=FNC_LIST_DOWN|FNC_AUTO+IDX_SEL
	obj_func.objList_Save		=FNC_XLT_SAVE
	obj_func.objList_Load		=FNC_XLT_LOAD
	obj_func.objList_ShowProperty	=FNC_OPEN_PROPERTY|FNC_AUTO+IDX_SEL
	obj_func.objList_ShowFolder	=FNC_OPEN_PARENTDIR|FNC_AUTO+IDX_SEL

	; ユーザー定義
	#const objUserDef1		33
	#const objUserDef2		34
	#const objUserDef3		35
	#const objUserDef4		36
	#const objUserDef5		37
	obj_key.objUserDef1		="userdef1"
	obj_key.objUserDef2		="userdef2"
	obj_key.objUserDef3		="userdef3"
	obj_key.objUserDef4		="userdef4"
	obj_key.objUserDef5		="userdef5"
	obj_func.objUserDef1		=FNC_SCRIPT+IDX_SCRIPT_USER
	obj_func.objUserDef2		=FNC_SCRIPT+IDX_SCRIPT_USER+1
	obj_func.objUserDef3		=FNC_SCRIPT+IDX_SCRIPT_USER+2
	obj_func.objUserDef4		=FNC_SCRIPT+IDX_SCRIPT_USER+3
	obj_func.objUserDef5		=FNC_SCRIPT+IDX_SCRIPT_USER+4


; ―――――――――――――――――――――――――――――――――――――
; 6. 言語(口調)に関する定義
; ―――――――――――――――――――――――――――――――――――――

	#const lgs				12+20

	sdim lg_key,24,lgs

	#const lgWelcome		0	; ご利用ありがとうございます。
	#const lgDlg_ErrorFormat	1	; 指定された%format%は壊れているか、\nまたは未対応の形式であるため読み込むことが出来ませんでした。\n%confirm%\n(%file%)
	#const lgDlg_ErrorNotFound	2	; 指定された%format%が見つからず、読み込むことが出来ませんでした。\n%confirm%\n(%file%)
	#const lgDlg_ErrorTooManyFiles	3	; 多すぎです。
	#const lgDlg_ErrorOnSave	4	; ファイル名の保存に失敗しました。
	#const lgDlg_ConfirmClearFile	5	; 再生リストから削除しますか？\n
	#const lgDlg_Folder		6	; ファイルを検索するフォルダを選んでください。
	#const lgDlg_Rename		7	; 変更後の名前を入力してください。
	#const lgDlg_Favorite		8	; お気に入りの登録名を〃。
	#const lgDlg_ConfirmDelete	9	; 指定された音楽ファイルをごみ箱に捨てて宜しいですか？
	#const lgDlg_ConfirmClearAll	10	; 再生リストを空にして宜しいですか？
	#const lgDlg_ConfirmOverwrite	11	; 指定されたリストファイルは既に存在します。上書きして宜しいですか？
	lg_key.lgWelcome		="Welcome"
	lg_key.lgDlg_ErrorFormat	="Err.format"
	lg_key.lgDlg_ErrorNotFound	="Err.notfound"
	lg_key.lgDlg_ErrorTooManyFiles	="Err.toomany"
	lg_key.lgDlg_ErrorOnSave	="Err.onsave"
	lg_key.lgDlg_ConfirmClearFile	="Sub.cfm"
	lg_key.lgDlg_Folder		="Dlg.folder"
	lg_key.lgDlg_Rename		="Dlg.rename"
	lg_key.lgDlg_Favorite		="Dlg.favorite"
	lg_key.lgDlg_ConfirmDelete	="Cfm.del"
	lg_key.lgDlg_ConfirmClearAll	="Cfm.clrall"
	lg_key.lgDlg_ConfirmOverwrite	="Cfm.overwrite"
	#const lgPM			12
	#const lgPMEX			18
	#const lgST			20
	#const lgTP			24
	lg_key.lgPM="Mode.nor","Mode.rev","Mode.rnd","Mode.rep","Mode.stp","Mode.mdr"
	lg_key.lgPMEX="RepMode.no","RepMode.yes"	
	lg_key.lgST="Status.stopped","Status.closed","Status.playing","Status.paused"
	lg_key.lgTP="Type.mp3","Type.wma","Type.mid","Type.wav","Type.ogg","Type.cda","Type.mci","Type.dxs"


; ―――――――――――――――――――――――――――――――――――――
;                                                              (c) arc@arcis
