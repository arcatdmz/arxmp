
; ■ arX MusicPlayer 用の命令拡張
; ―――――――――――――――――――――――――――――――――――――

/* 制作メモ ――――――――――――――――――――――――――――――――

 ・この as ファイルについて

	Windows の関数(API)と、拡張命令、マクロの定義を行う

	※ グローバル変数とローカル変数が混在していて、
	　 一般用途に転用できない命令がほとんど

 ―――――――――――――――――――――――――――――――――――― */


; ―――――――――――――――――――――――――――――――――――――
; WIN32API
; ―――――――――――――――――――――――――――――――――――――

	#const funcs					114
	; user32.dll
	#const FNC_TrackMouseEvent			113
	#const FNC_ShowWindow				47
	#const FNC_EnableWindow				48
	#const FNC_MoveWindow				66
	#const FNC_FindWindowA				109
	#const FNC_GetWindowTextA			110
	#const FNC_SetForegroundWindow			6
	#const FNC_SetWindowLongA			31
	#const FNC_GetWindowLongA			49
	#const FNC_CreateWindowExA			29
	#const FNC_CreatePopupMenu			7
	#const FNC_TrackPopupMenu			8
	#const FNC_InsertMenuItemA			9
	#const FNC_GetMenuItemInfoA			10
	#const FNC_SetMenuItemInfoA			11
	#const FNC_DeleteMenu				54
	#const FNC_DestroyMenu				12
	#const FNC_FillRect				13
	#const FNC_GetSysColor				32
	#const FNC_GetSysColorBrush			0
	#const FNC_GetSystemMetrics			72
	#const FNC_SendMessageA				30
	#const FNC_CloseWindow				34
	#const FNC_OpenIcon				35
	#const FNC_SetRect				37
	#const FNC_GetWindowRect			51
	#const FNC_SetWindowRgn				38
	#const FNC_WindowFromPoint			50
	#const FNC_OpenClipboard			62
	#const FNC_EmptyClipboard			63
	#const FNC_SetClipboardData			64
	#const FNC_CloseClipboard			65
	#const FNC_ScreenToClient			68
	#const FNC_GetWindowThreadProcessId		97
	#const FNC_DdeInitializeA			67
	#const FNC_DdeCreateStringHandleA		102
	#const FNC_DdeFreeStringHandle			103
	#const FNC_DdeConnect				104
	#const FNC_DdeDisconnect			105
	#const FNC_DdeClientTransaction			106
	#const FNC_DdeGetData				107
	#const FNC_DdeFreeDataHandle			108
	; gdi32.dll
	#const FNC_ExtCreateRegion			39
	#const FNC_GetTextExtentPoint32A		45
	#const FNC_CreateCompatibleDC			69
	#const FNC_CreateCompatibleBitmap		1
	#const FNC_SelectObject				2
	#const FNC_BitBlt				3
	#const FNC_DeleteObject				4
	#const FNC_DeleteDC				5
	#const FNC_GetObjectA				70
	; shell32.dll
	#const FNC_SHFileOperationA			16
	#const FNC_SHGetPathFromIDListA			33
	#const FNC_SHGetMalloc				53
	#const FNC_SHBrowseForFolderA			52
	#const FNC_Shell_NotifyIconA			17
	#const FNC_ShellExecuteA			18
	#const FNC_DragAcceptFiles			19
	#const FNC_DragQueryFileA			20
	#const FNC_DragFinish				21
	; kernel32.dll
	#const FNC_IsDBCSLeadByte			46
	#const FNC_MultiByteToWideChar			24
	#const FNC_WideCharToMultiByte			99
	#const FNC_GetFileAttributesA			25
	#const FNC_GetShortPathNameA			26
	#const FNC_VirtualProtect			36
	#const FNC_GlobalAlloc				40
	#const FNC_GlobalReAlloc			41
	#const FNC_GlobalLock				42
	#const FNC_GlobalUnlock				43
	#const FNC_GlobalFree				44
	#const FNC_lstrcpy				61
	#const FNC_MapViewOfFile			14
	#const FNC_UnmapViewOfFile			15
	#const FNC_CreateFileMappingA			22
	#const FNC_CloseHandle				23
	#const FNC_GetLastError				94
	#const FNC_OpenProcess				95
	#const FNC_WriteProcessMemory			96
	#const FNC_GetFullPathNameA			98
	#const FNC_CompareStringA			111

	; comdlg32.dll
	#const FNC_GetOpenFileNameA			55
	#const FNC_ChooseFontA				71
	; ole32.dll
	#const FNC_CLSIDFromString			27
	#const FNC_IIDFromString			28
	#const FNC_CoCreateInstance			56
	#const FNC_CoTaskMemFree			101
	; ole32pro.dll
	#const FNC_OleCreatePropertyFrame		100
	; mp3infp.dll
	#const FNC_mp3infp_ViewProp			57
	#const FNC_mp3infp_Load				58
	#const FNC_mp3infp_mp3_GetTagType		59
	#const FNC_mp3infp_GetValue			60
	; vox.dll
	#const FNC_vox_Load				73
	#const FNC_vox_SetLoop				74
	#const FNC_vox_Play				75
	#const FNC_vox_GetComment			76
	#const FNC_vox_ParseComment			112
	#const FNC_vox_GetTotalTime			77
	#const FNC_vox_GetCurrentTime			78
	#const FNC_vox_GetStatus			79
	#const FNC_vox_Seek				80
	#const FNC_vox_Pause				81
	#const FNC_vox_Release				82
	#const FNC_vox_Delete				83
	; vbmp3.dll
	#const FNC_vbmp3_open				84
	#const FNC_vbmp3_play				85
	#const FNC_vbmp3_getMpegInfo			86
	#const FNC_vbmp3_getState			87
	#const FNC_vbmp3_seek				88
	#const FNC_vbmp3_pause				89
	#const FNC_vbmp3_restart			90
	#const FNC_vbmp3_stop				91
	#const FNC_vbmp3_close				92
	#const FNC_vbmp3_free				93

	dim pfunc,funcs
	;   user32.dll
	ll_getproc pfunc.FNC_TrackMouseEvent		,"TrackMouseEvent"		,D_USER
	ll_getproc pfunc.FNC_ShowWindow			,"ShowWindow"			,D_USER
	ll_getproc pfunc.FNC_EnableWindow		,"EnableWindow"			,D_USER
	ll_getproc pfunc.FNC_MoveWindow			,"MoveWindow"			,D_USER
	ll_getproc pfunc.FNC_FindWindowA		,"FindWindowA"			,D_USER
	ll_getproc pfunc.FNC_GetWindowTextA		,"GetWindowTextA"		,D_USER
	ll_getproc pfunc.FNC_GetSysColor		,"GetSysColor"			,D_USER
	ll_getproc pfunc.FNC_GetSysColorBrush		,"GetSysColorBrush"		,D_USER
	ll_getproc pfunc.FNC_GetSystemMetrics		,"GetSystemMetrics"		,D_USER
	ll_getproc pfunc.FNC_SetForegroundWindow	,"SetForegroundWindow"		,D_USER
	ll_getproc pfunc.FNC_SetWindowLongA		,"SetWindowLongA"		,D_USER
	ll_getproc pfunc.FNC_GetWindowLongA		,"GetWindowLongA"		,D_USER
	ll_getproc pfunc.FNC_CreateWindowExA		,"CreateWindowExA"		,D_USER
	ll_getproc pfunc.FNC_CreatePopupMenu		,"CreatePopupMenu"		,D_USER
	ll_getproc pfunc.FNC_TrackPopupMenu		,"TrackPopupMenu"		,D_USER
	ll_getproc pfunc.FNC_InsertMenuItemA		,"InsertMenuItemA"		,D_USER
	ll_getproc pfunc.FNC_GetMenuItemInfoA		,"GetMenuItemInfoA"		,D_USER
	ll_getproc pfunc.FNC_SetMenuItemInfoA		,"SetMenuItemInfoA"		,D_USER
	ll_getproc pfunc.FNC_DeleteMenu			,"DeleteMenu"			,D_USER
	ll_getproc pfunc.FNC_DestroyMenu		,"DestroyMenu"			,D_USER
	ll_getproc pfunc.FNC_FillRect			,"FillRect"			,D_USER
	ll_getproc pfunc.FNC_SendMessageA		,"SendMessageA"			,D_USER
	ll_getproc pfunc.FNC_CloseWindow		,"CloseWindow"			,D_USER
	ll_getproc pfunc.FNC_OpenIcon			,"OpenIcon"			,D_USER
	ll_getproc pfunc.FNC_SetRect			,"SetRect"			,D_USER
	ll_getproc pfunc.FNC_GetWindowRect		,"GetWindowRect"		,D_USER
	ll_getproc pfunc.FNC_SetWindowRgn		,"SetWindowRgn"			,D_USER
	ll_getproc pfunc.FNC_WindowFromPoint		,"WindowFromPoint"		,D_USER
	ll_getproc pfunc.FNC_OpenClipboard		,"OpenClipboard"		,D_USER
	ll_getproc pfunc.FNC_EmptyClipboard		,"EmptyClipboard"		,D_USER
	ll_getproc pfunc.FNC_SetClipboardData		,"SetClipboardData"		,D_USER
	ll_getproc pfunc.FNC_CloseClipboard		,"CloseClipboard"		,D_USER
	ll_getproc pfunc.FNC_ScreenToClient		,"ScreenToClient"		,D_USER
	ll_getproc pfunc.FNC_GetWindowThreadProcessId	,"GetWindowThreadProcessId"	,D_USER
	ll_getproc pfunc.FNC_DdeInitializeA		,"DdeInitializeA"		,D_USER
	ll_getproc pfunc.FNC_DdeCreateStringHandleA	,"DdeCreateStringHandleA"	,D_USER
	ll_getproc pfunc.FNC_DdeFreeStringHandle	,"DdeFreeStringHandle"		,D_USER
	ll_getproc pfunc.FNC_DdeConnect			,"DdeConnect"			,D_USER
	ll_getproc pfunc.FNC_DdeDisconnect		,"DdeDisconnect"		,D_USER
	ll_getproc pfunc.FNC_DdeClientTransaction	,"DdeClientTransaction"		,D_USER
	ll_getproc pfunc.FNC_DdeGetData			,"DdeGetData"			,D_USER
	ll_getproc pfunc.FNC_DdeFreeDataHandle		,"DdeFreeDataHandle"		,D_USER
	;   gdi32.dll
	ll_getproc pfunc.FNC_ExtCreateRegion		,"ExtCreateRegion"		,D_GDI
	ll_getproc pfunc.FNC_GetTextExtentPoint32A	,"GetTextExtentPoint32A"	,D_GDI
	ll_getproc pfunc.FNC_CreateCompatibleDC		,"CreateCompatibleDC"		,D_GDI
	ll_getproc pfunc.FNC_CreateCompatibleBitmap	,"CreateCompatibleBitmap"	,D_GDI
	ll_getproc pfunc.FNC_SelectObject		,"SelectObject"			,D_GDI
	ll_getproc pfunc.FNC_BitBlt			,"BitBlt"			,D_GDI
	ll_getproc pfunc.FNC_DeleteObject		,"DeleteObject"			,D_GDI
	ll_getproc pfunc.FNC_DeleteDC			,"DeleteDC"			,D_GDI
	ll_getproc pfunc.FNC_GetObjectA			,"GetObjectA"			,D_GDI
	;   shell32.dll
	ll_getproc pfunc.FNC_SHFileOperationA		,"SHFileOperationA"		,D_SHELL
	ll_getproc pfunc.FNC_SHGetPathFromIDListA	,"SHGetPathFromIDListA"		,D_SHELL
	ll_getproc pfunc.FNC_SHGetMalloc		,"SHGetMalloc"			,D_SHELL
	ll_getproc pfunc.FNC_SHBrowseForFolderA		,"SHBrowseForFolderA"		,D_SHELL
	ll_getproc pfunc.FNC_Shell_NotifyIconA		,"Shell_NotifyIconA"		,D_SHELL
	ll_getproc pfunc.FNC_ShellExecuteA		,"ShellExecuteA"		,D_SHELL
	ll_getproc pfunc.FNC_DragAcceptFiles		,"DragAcceptFiles"		,D_SHELL
	ll_getproc pfunc.FNC_DragQueryFileA		,"DragQueryFileA"		,D_SHELL
	ll_getproc pfunc.FNC_DragFinish			,"DragFinish"			,D_SHELL
	;   kernel32.dll
	ll_getproc pfunc.FNC_IsDBCSLeadByte		,"IsDBCSLeadByte"		,D_KERNEL
	ll_getproc pfunc.FNC_MultiByteToWideChar	,"MultiByteToWideChar"		,D_KERNEL
	ll_getproc pfunc.FNC_WideCharToMultiByte	,"WideCharToMultiByte"		,D_KERNEL
	ll_getproc pfunc.FNC_GetFileAttributesA		,"GetFileAttributesA"		,D_KERNEL
	ll_getproc pfunc.FNC_GetShortPathNameA		,"GetShortPathNameA"		,D_KERNEL
	ll_getproc pfunc.FNC_VirtualProtect		,"VirtualProtect"		,D_KERNEL
	ll_getproc pfunc.FNC_GlobalAlloc		,"GlobalAlloc"			,D_KERNEL
	ll_getproc pfunc.FNC_GlobalReAlloc		,"GlobalReAlloc"		,D_KERNEL
	ll_getproc pfunc.FNC_GlobalLock			,"GlobalLock"			,D_KERNEL
	ll_getproc pfunc.FNC_GlobalUnlock		,"GlobalUnlock"			,D_KERNEL
	ll_getproc pfunc.FNC_GlobalFree			,"GlobalFree"			,D_KERNEL
	ll_getproc pfunc.FNC_lstrcpy			,"lstrcpy"			,D_KERNEL
	ll_getproc pfunc.FNC_MapViewOfFile		,"MapViewOfFile"		,D_KERNEL
	ll_getproc pfunc.FNC_UnmapViewOfFile		,"UnmapViewOfFile"		,D_KERNEL
	ll_getproc pfunc.FNC_CreateFileMappingA		,"CreateFileMappingA"		,D_KERNEL
	ll_getproc pfunc.FNC_CloseHandle		,"CloseHandle"			,D_KERNEL
	ll_getproc pfunc.FNC_GetLastError		,"GetLastError"			,D_KERNEL
	ll_getproc pfunc.FNC_OpenProcess		,"OpenProcess"			,D_KERNEL
	ll_getproc pfunc.FNC_WriteProcessMemory		,"WriteProcessMemory"		,D_KERNEL
	ll_getproc pfunc.FNC_GetFullPathNameA		,"GetFullPathNameA"		,D_KERNEL
	ll_getproc pfunc.FNC_CompareStringA		,"CompareStringA"		,D_KERNEL
	; comdlg32.dll
	ll_getproc pfunc.FNC_GetOpenFileNameA		,"GetOpenFileNameA"		,D_COMDLG
	ll_getproc pfunc.FNC_ChooseFontA		,"ChooseFontA"			,D_COMDLG
	;   ole32.dll
	ll_getproc pfunc.FNC_CLSIDFromString		,"CLSIDFromString"		,D_OLE
	ll_getproc pfunc.FNC_IIDFromString		,"IIDFromString"		,D_OLE
	ll_getproc pfunc.FNC_CoCreateInstance		,"CoCreateInstance"		,D_OLE


; ―――――――――――――――――――――――――――――――――――――
; マクロとモジュール
; ―――――――――――――――――――――――――――――――――――――

	; 汎用マクロ
	;  %1 が 1 なら FNC_ON, 0 なら FNC_OFF
	#define ctype FNC_OX(%1) (%1!0*FNC_ON+(%1=0*FNC_OFF))
	;  %1 を数値と見なし、変数 im に代入
	#define int_(%1) im=%1 :int im
	;  タイトルを一定時間 %1 に変える
	#define title_(%1) title %1 :dispTitle=TI_TITLE
	;  %2 をミリ秒単位時間と見なし、文字列に変換して %1 に代入
	#define timeconv(%1,%2) im.4=%2/1000 :im=im.4/3600,im.4\3600/60,im.4\60 :%1="" :repeat im!0 :%1+=""+im+"時" :loop :%1+=""+im.1+"分"+im.2+"秒"
	;  %1 をLONGLONG型変数と見なし、内容をミリ秒単位に変換
	#define llconv(%1,%2) %1=%2/10000+(%2<0*429496)+(%2.1*429497)
	;  逆変換
	#define llreconv(%1,%2) %1.1=%2/429497 :%1=(%2\429497-(%2\429497>214748*429496))*10000

	; リスト用マクロ
	;  現在の更新対象リストオブジェクトがリストボックスか(1)否(0)か
	#define lisLB	(sList=0|dispListWnd)
	;  〃　　　　　　　　　　　　　　　　コンボボックスか(1)否(0)か
	#define lisCB	(dispListWnd=0&sList)
	;  更新対象リストオブジェクトが載っている画面ID
	#define lWid	(dispListWnd*widList+(dispListWnd=0*sWid))
	;  選択項目のバックアップとリストア
	#define lsi_backup im=lSelectedIdx
	#define lsi_restore(%1) prm=1 :objsend %1,lisLB*LB_SETCURSEL+(lisCB*CB_SETCURSEL),im,prm

	; 言語取得用マクロ
	;	get_langPM	s,lMode
	;	get_langPMEX	s,lMode
	;	get_langST	s,mStatus
	;	get_langTP	s,mFileType
	#define get_langPM(%1,%2)	im=%2&$F+lgPM	:%1=langs.im
	#define get_langPMEX(%1,%2)	im=%2>>4&$F+lgPMEX	:%1=langs.im
	#define get_langST(%1,%2)	im=%2+lgST		:%1=langs.im
	#define get_langTP(%1,%2)	im=TPfromTPEX(%2)+lgTP:%1=langs.im
	#define strget_lg(%1,%2) strget s,%2 :if s!"" :convert langs.%1,s,"\n","<BR>"

	; スクリプト関連マクロ
	#define scrplus(%1) script+=%1 :scrLine+=%1Line
	#define strgeta_xsp(%1,%2) strgeta funcopts,%2 :sdim %1,stat+3 :%1=funcopts :notemax_ %1 :%1Line=stat

	; COM用マクロ
	#define getclsid(%1,%2) s=%1 :uni s :prm=ps,pi :dllprocp FNC_CLSIDFromString,prm,2 :memcpy %2,i,16
	#define getiid(%1,%2) s=%1 :uni s :prm=ps,pi :dllprocp FNC_IIDFromString,prm,2 :memcpy %2,i,16
	;  QueryInterface
	#define qi(%1,%2,%3) memcpy i,%3,16 :prmex=pi :getptr prmex.1,%2 :prm=pprmex,2,0,%1 :ll_callfunc prm,4,pCallMethod
	;  Release
	#define ri(%1) prm=0,0,2,%1 :ll_callfunc prm,4,pCallMethod

	; TP_?⇔TPEX_? 変換マクロ
	; ※ TPEX_DIR, TPEX_XLT は TP_DIR, TP_XLT でなく TP_OTH となる
	#define ctype TPfromTPEX(%1) %1&TPEX_MP3!0*TP_MP3+(%1&TPEX_WMA!0*TP_WMA)+(%1&TPEX_MID!0*TP_MID)+(%1&TPEX_WAV!0*TP_WAV)+(%1&TPEX_OGG!0*TP_OGG)+(%1&TPEX_CDA!0*TP_CDA)+(%1&TPEX_DEF=0*(%1&TPEX_MCI!0*TP_MCI+(%1&TPEX_DXS!0*TP_DXS)+(%1&$FFF=0*TP_OTH)))
	#define ctype TPEXfromTP(%1) (1<<(%1))

	; 音楽情報取得用マクロ
	#define ctype word(%1) (%1&$FF<<8+(%1>>8&$FF))
	#define ctype dword(%1) (%1&$FF<<24+(%1&$FF00<<8)+(%1>>8&$FF00)+(%1>>24&$FF))
	#define getval(%1,%2) ss=%2 :dllprocp FNC_mp3infp_GetValue,prm,2 :if dllret :ll_peek %1,i :else :%1=""
	#define prscom(%1,%2) ss=%2 :dllprocp FNC_vox_ParseComment,prm,3 :if dllret :ll_peek %1,dllret

	#module "arxmp_mod"

	; ―――――――――――――――――――――――――――――――――
	; 汎用命令

		; エセ dllproc (本家 dllproc と微妙に互換)
		; ※ stat に結果が返らない、エラーダイアログが表示されない差異有り
		#deffunc dllproc str,val,int,int
		mref funcname,32 :mref prms,17 :mref prm_n,2 :mref dll_no,3
		ll_getproc func,funcname,dll_no
		ll_callfunc prms,prm_n,func :return

		; ポインタの分かっている関数を実行
		; ※ ll_getproc を先にメインで実行しておいてあるだけで、他は dllproc と同じ
		#define global dllprocp(%1,%2,%3=0) ll_callfunc %2,%3,pfunc@.%1

		; 本家 getptr 互換
		#deffunc getptr val,val
		mref vptr,16 :mref pval_var,1025
		if (pval_var&$ffff=2) :mref var,25 :else :mref var,17
		ll_getptr var :vptr=dllret@
		return

	; ―――――――――――――――――――――――――――――――――
	; メニュー関連命令

		; ポップアップメニューの作成
		#deffunc nmenu val
		mref hmenu,16
		dllprocp FNC_CreatePopupMenu@,prm
		hmenu=dllret@
		return

 		; メニュー項目の追加
		;	使用値	"p1"	/ 項目表示文字列
		;		p2	/ メニュー項目ID
		;		p3	/ 項目下のサブメニューのハンドル
		;		p4	/ 項目追加先のメニューのハンドル
		;		p5	/ 項目位置(0; 最下行, n; n番目)
		#deffunc imenu str,int,int,int,int
		mref s,32 :mref id,1 :mref hsubmenu,2 :mref hmenu,3 :mref p5,4
		p5--
		string=s
		;  MENUITEMINFO構造体を作成
		mii@=oschk@>0*4+44,(hmenu!0*$4)+(oschk@>0*$30)+$12,0,0,id,hsubmenu,0,0,0,0,0,0
		if string="" :mii@.2=$800 :else {
		 if string="|" :mii@.2=$10 :else {
		  mii@.2=0 :mii@.9=pstring :strlen mii@.10,string
		 }
		}
		;  メニュー追加
		prm=hmenu,p5,1,pmii@
		dllprocp FNC_InsertMenuItemA@,prm,4
		return

 		; メニュー項目の削除
		;	使用値	p1	/ 項目削除元のメニューのハンドル
		;		p2	/ メニュー項目ID
		#deffunc dmenu int,int
		mref hmenu :mref id,1
		prm=hmenu,id,0
		dllprocp FNC_DeleteMenu@,prm,3
		return

		; GetMenuItemInfoA
		;	使用値	p1	/ 調査する項目のあるメニューのハンドル
		;		p2	/ 調査する項目のID
		#deffunc getmii int,int
		mref hmenu :mref id,1
		prm=hmenu,id,0,pmii@ :dllprocp FNC_GetMenuItemInfoA@,prm,4
		return

		; SetMenuItemInfoA
		;	使用値	p1	/ 設定する項目のあるメニューのハンドル
		;		p2	/ 設定する項目のIDか位置
		;		p3	/ p2 がID(0)か位置(1)か
		#deffunc setmii int,int,int
		mref hmenu :mref id,1 :mref i,2
		prm=hmenu,id,i,pmii@ :dllprocp FNC_SetMenuItemInfoA@,prm,4
		return

		; メニュー項目の表示文字列変更
		;	使用値	"p1"	/ 表示文字列
		;		p2	/ 変更する項目のID
		;		p3	/ 変更する項目のあるメニューのハンドル
		#deffunc tmenu str,int,int
		mref s,32 :mref id,1 :mref hmenu,2
		string=s
		; 下調べ
		mii@.1=oschk@>0*$30+$10	; dwTypeData の取得
		mii@.9=pstring2
		getmii hmenu,id
		; 文字列変更
		mii@.9=pstring :strlen mii@.10,string
		setmii hmenu,id
		return

		; メニューのポップアップ
		;	使用値	p1	/ ポップアップするメニューのハンドル
		;		p2,p3	/ ポップアップする位置
		;		p4	/ アクティブにするウィンドウのハンドル
		#deffunc pmenu int,int,int,int
		mref hmenu
		mref x,1
		mref y,2
		mref hwnd,3
		if hwnd {
		 dllprocp FNC_SetForegroundWindow@,hwnd,1 
		} else {
		 mref bmscr,67 :hwnd=bmscr.13
		}
		prm=hmenu,$182,x,y,0,hwnd,0
		dllprocp FNC_TrackPopupMenu@,prm,7
		return

	; ―――――――――――――――――――――――――――――――――
	; トレイアイコン関連命令

		; トレイアイコンの初期化
		#deffunc ntray int
		mref hicon
		prm=0 :prmex@=88,hwProcess@,0,3,WM_TASKTRAY@,hicon
		gosub *@f
		return

		; トレイアイコン表示文字列の設定
		;	使用値	"p1"	/ 表示文字列
		#deffunc ttray str,int
		mref hicon,1
		prm=1 :prmex@=88,hwProcess@,0,4,WM_TASKTRAY@,hicon
		mref s,32
		memcpy prmex@,s,64,24
		gosub *@f
		return

		; トレイアイコンの消去
		#deffunc ctray
		prm=2 :prmex@=88,hwProcess@,0,4,0,0
		gosub *@f
		return

		*@
		prm.1=pprmex@
		dllprocp FNC_Shell_NotifyIconA@,prm,2
		return

	; ―――――――――――――――――――――――――――――――――
	; GUI関連命令

		; ブラシによる boxf
		;	使用値	p1-p4	/ 矩形領域
		;		p5	/ ブラシのハンドル
		#deffunc boxf_ int,int,int,int,int
		mref left :mref top,1 :mref right,2 :mref bottom,3
		mref hbrush,4
		mref bmscr,67
		prmex@=left,top,right,bottom
		prm=bmscr.4,pprmex@,hbrush
		dllprocp FNC_FillRect@,prm,3
		return

		; ボタンオブジェクトの各種制御
		;	使用値	p1	/ オブジェクトID
		;		p2	/ 機能番号
		;	機能番号 (0から順に)
		;		 0 有効/無効/不可視/可視/-/
		;		 5 透明化ボタン/枠強調/
		;		 7 テキスト表示位置左/右/中央/上/下/マルチライン/
		;		13 フラット/フラット,枠強調/フラット,トグル動作
		#deffunc btnable int,int
		mref id
		mref opt,1
		mref bmscr,67
		if id<0|(id>objmax@) :return
		id+=41 :hobj=bmscr.id
		if opt<2 {		; 有効/無効
		 prm=hobj,1-opt
		 dllprocp FNC_EnableWindow@,prm,2
		 return
		}
		if opt<4 {		; 不可視/可視
		 prm=hobj,opt-2
		 dllprocp FNC_ShowWindow@,prm,2
		 return
		}
		if opt=5 {		; 透明化
		 prm=hobj,-20,$20	:dllprocp FNC_SetWindowLongA@,prm,3
		 prm=hobj,-16,$5400000B	:dllprocp FNC_SetWindowLongA@,prm,3
		 return
		}
		; その他
		i=0
		opt-=6
		repeat
		 if opt=0	:i=$001 :break;	BS_DEFPUSHBUTTON
		 if opt=1	:i=$100 :break;	BS_LEFT
		 if opt=2	:i=$200 :break;	BS_RIGHT
		 if opt=3	:i=$300 :break;	BS_CENTER
		 if opt=4	:i=$400 :break;	BS_TOP
		 if opt=5	:i=$800 :break;	BS_BOTTOM
		 if opt=6	:i=$2000:break;	BS_MULTILINE
		 if opt=7	:i=$8000:break;	BS_FLAT
		 if opt=8	:i=$8001:break;	BS_FLAT+BS_DEFPUSHBUTTON
		 if opt=9	:i=$9003:break;	BS_FLAT+BS_PUSHLIKE+BS_AUTOCHECKBOX
		 if opt=10	:i=$1003:break;	BS_PUSHLIKE+BS_AUTOCHECKBOX
		 if opt=11	:i=$1006:break;	BS_PUSHLIKE+BS_AUTO3STATE
		 if opt=12	:i=$1009:break;	BS_PUSHLIKE+BS_AUTORADIOBUTTON
		 ; 以下はチェックボックスにのみ利用可
		 if opt=13	:i=$220 :break;	BS_LEFTTEXT+BS_RIGHT
		 if opt=14	:i=$620 :break;	BS_LEFTTEXT+BS_RIGHT+BS_TOP
		 if opt=15	:i=$A20 :break;	BS_LEFTTEXT+BS_RIGHT+BS_BOTTOM
		 break
		loop
		if i!0 {
		 prm=hobj,-16		:dllprocp FNC_GetWindowLongA@,prm,2
		 prm.2=(dllret@|i)	:dllprocp FNC_SetWindowLongA@,prm,3
		}
		return

		; オブジェクトの大きさを変更
		#deffunc objrect int,int,int,int
		mref x :mref y,1 :mref id,2 :mref resz,3
		mref bmscr,67
		if id<0|(id>objmax@) :return
		id+=41 :hobj=bmscr.id
		prm.3=x,y,1
		; 元々の位置と大きさを取得
		prm=hobj,pprmex@
		dllprocp FNC_GetWindowRect@,prm,2
		; 変更
		if resz {
		 prm=bmscr.13,pprmex@
		 dllprocp FNC_ScreenToClient@,prm,2
		 prm=hobj,prmex@,prmex@.1
		} else {
		 prm=hobj,prm.3,prm.4,prmex@.2-prmex@,prmex@.3-prmex@.1
		}
		dllprocp FNC_MoveWindow@,prm,6
		return
		; マクロ定義
		#define global objresize(%1,%2,%3) objrect %1,%2,%3,1
		#define global objrepos(%1,%2,%3) objrect %1,%2,%3,0

		; 超高速で不定形ウィンドウを作成
		#deffunc regmake
		if code=0 {
		 dim code,153	; マシン語コード格納用
		 getptr pRegmake,code
		 prm=pRegmake,612,$40,pi@ :dllprocp FNC_VirtualProtect@,prm,4
		 code.0  =$83EC8B55,$5653B8C4,$C458B57 ,$508B188B,$E0558904,$8908488B,$508BDC4D,$D855890C
		 code.8  =$8910488B,$508BD44D,$D0558914,$8918488B,$408BCC4D,$C845891C,$8B08458B,$55891450
		 code.16 =$84D8BC4 ,$890C418B,$558BC045,$44A8B08 ,$8BBC4D89,$508B0845,$B8558908,$8B084D8B
		 code.24 =$A081    ,$FC458900,$C07D83  ,$45C70974,$01EC    ,$C707EB00,$3EC45   ,$558B0000
		 code.32 =$55AF0FBC,$E85589EC,$81E84D8B,$03E1    ,$49057980,$41FCC983,$04B8    ,$25C12B00
		 code.40 =$80000003,$83480579,$8940FCC8,$45C7E845,$64F8    ,$F8558B00,$8304E2C1,$6A5220C2
		 code.48 =$89D3FF02,$4D8BE445,$55FF51E4,$33F88BDC,$2007C7C0,$8D000000,$47C71057,$0104
		 code.56 =$C478900 ,$6A084789,$6A006A00,$52006A00,$33D055FF,$F44D89C9,$3BF4458B,$8D0FB845
		 code.64 =$0131    ,$48B8458B,$8BF4452B,$AF0FE855,$FD88BD0 ,$FBC5DAF ,$3EC5DAF ,$DA03C45D
		 code.72 =$753BF633,$FB8D0FBC,$83000000,$7400C07D,$8AC03306,$3318EB03,$8AD233C0,$38A0153
		 code.80 =$3308E2C1,$10E0C1C9,$B024B8A ,$3BC10BC2,$840FFC45,$00C1    ,$46F07589,$7DBC753B
		 code.88 =$EC5D0332,$C07D83  ,$C0330674,$18EB038A,$D233C033,$8A01538A,$8E2C103 ,$E0C1C933
		 code.96 =$24B8A10 ,$C10BC20B,$74FC453B,$753B4606,$8BCE7CBC,$453B0847,$8B2A72F8,$FF52E455
		 code.104=$4583D855,$26A64F8 ,$C1F84D8B,$C18304E1,$458B5120,$55FF50E4,$E44589E0,$52E4558B
		 code.112=$8BDC55FF,$20478DF8,$42F4558B,$4D8B5652,$558B51F4,$4F8B52F0,$4E1C108 ,$FF50C103
		 code.120=$478BD055,$F0453B10,$458B067E,$104789F0,$3B14578B,$67EF455 ,$89F44D8B,$773B144F
		 code.128=$89037E18,$458B1877,$473B40F4,$8B077E1C,$8942F455,$47FF1C57,$EC5D0308,$BC753B46
		 code.136=$FF058C0F,$45FFFFFF,$F44D8BF4,$FB84D3B ,$FFFECF8C,$458B57FF,$4E0C1F8 ,$5020C083
		 code.144=$55FF006A,$6AD88BCC,$458B5301,$34508B08,$C855FF52,$51E44D8B,$8BD455FF,$5B5E5FC3
		 code.152=$C25DE58B,0
		 ; 呼び出す関数のアドレスを格納
		 rgfunc  =pfunc@.FNC_GlobalAlloc@,pfunc@.FNC_GlobalReAlloc@,pfunc@.FNC_GlobalLock@,pfunc@.FNC_GlobalUnlock@
		 rgfunc.4=pfunc@.FNC_GlobalFree@,pfunc@.FNC_SetRect@,pfunc@.FNC_ExtCreateRegion@,pfunc@.FNC_SetWindowRgn@
		}
		mref bmscr,67 :getptr prm,bmscr		; BMSCR構造体へのポインタ
		getptr prm.1,rgfunc			; 呼び出す関数のアドレスが入った構造体へのポインタ
		ll_callfunc prm,2,pRegmake		; 者どもかかれーい！
		return

		; チップヘルプの設定
		;	使用値	p1	/ 表示文字列
		;		p2	/ オブジェクトID
		#deffunc tiphelp str,int
		mref s,32 :mref objid,1
		mref bmscr,67
		if objid<0|(objid>objmax@) :return
		objid+=41
		string2=s
		; チップヘルプ用子ウィンドウの作成
		; (各親ウィンドウにつき一回のみ)
		wid=bmscr.18
		if hwnd_tip.wid=0 {
		 ; ※ COMCTL 初期化は不要らしい
		 ;	; Windows 98以降では InitCommonControlsEx を利用
		 ;	if oschk>0 {
		 ;	 prmex=8,
		 ;	 dllproc "InitCommonControlsEx",pprmex,1,D_COMCTL
		 ;	} else {
		 ;	 dllproc "InitCommonControls",prm,0,D_COMCTL
		 ;	}
		 prm=0,pstring,0,$40|1,$8000000,$8000000,$8000000,$8000000,bmscr.13,0,bmscr.14,0
		 string="tooltips_class32" :dllprocp FNC_CreateWindowExA@,prm,12
		 hwnd_tip.wid=dllret@
		}
		; ToolInfo 構造体の作成
		;	cbSize	,uFlags	,hwnd(parent)	,uId/hwnd	,Rect		,hInst		,lpszText
		prmex@=	40	,(1|16)	,bmscr.13	,bmscr.objid	,0,0,0,0	,bmscr.14	,pstring2
		; 前回作成したチップヘルプの削除 (WM_USER+5)
		; prm=hwnd_tip.wid,1029,0,pprmex@ :dllprocp FNC_SendMessageA@,prm,4
		; チップヘルプの登録 (WM_USER+4)
		prm=hwnd_tip.wid,1028,0,pprmex@ :dllprocp FNC_SendMessageA@,prm,4
		; 幅の制限 (WM_USER+24)
		prm=hwnd_tip.wid,1048,0,200 :dllprocp FNC_SendMessageA@,prm,4
		return

	; ―――――――――――――――――――――――――――――――――
	; その他の命令

		; ファイル名取得
		;	使用値	p1	/ ファイルのフルパス
		;	返り値	refstr	/ ファイル名
		;		im	/ フルパス長
		;		stat	/ フォルダパス長
		#deffunc getfname str
		mref s,32
		stt=0
		repeat
		 instr i,s,"\\",stt
		 if i=-1 :break
		 stt+=i+1
		loop
	  	strlen im@,s
		strmid ref,s,-1,im@-stt
		return

		; ファイル種別判定
		;	使用値	p1	/ ファイル名
		;	返り値	stat	/ ファイル種(TPEX_*)
		#deffunc gettype str
		mref s,32
		stt=0
		; 拡張子を取得
		i=0
		repeat
		 instr ii,s,".",i
		 if ii=-1 :break
		 i+=ii+1
		loop
		strlen ii,s
		strmid string,s,-1,ii-i
		strlen i,string
		; 全て大文字に変換
		if i {
		 repeat i,0
		  peek ii,string,cnt
		  if (ii>='a')&(ii<='z') :ii-=32
		  poke string,cnt,ii
		 loop
		} else :stt=0 :return
		; ファイル種の取得
		stt=0
		ref=string
		repeat 1
		 ; if ref="" :stt=TPEX_DIR :break
		 if ref="XLT" :stt=TPEX_XLT :break
		 if ref="XSP" :stt=TPEX_XSP :break
		 if ref="XPI" :stt=TPEX_XPI :break
		 if ref="XMS" :stt=TPEX_XMS :break
		 if ref="XSS" :stt=TPEX_XSS :break
		 if ref="XS"  :stt=TPEX_XS  :break
		 if ref="EXE" :stt=TPEX_EXE :break
		 if ref="LNK" :stt=TPEX_EXE :break
		 ; if ref="LZH" :stt=TPEX_ARC :break
		 if ref="BMP" :stt=TPEX_IMG :break
		 if ref="JPG" :stt=TPEX_IMG :break
		 if ref="JPEG":stt=TPEX_IMG :break
		 break
		loop
		repeat TP_PLAYABLE
		 if types@.cnt!"" {
		  string2=" "+types@.cnt+" "
		  string=" "+ref+" " :instr i,string2,string
		  if i=-1 :string=" "+ref+"(" :instr i,string2,string
		  if i!-1 :stt+=(1<<cnt)
		 }
		loop
		i=stt :string=s :gosub *@f
		stt=(stt=-1)*TPEX_DIR+i
		return

		; 高速 exist
		;	使用値	p1	/ 存在を確認するファイルまたはフォルダ名
		;	戻り値	stat	/ 存在しない(0),ファイル(1),フォルダ(-1)
		#deffunc exist_ str
		mref s,32 :string=s
		gosub *@f
		return

		; 拡張 exist
		;	使用値	p1	/ パスを確認するファイルまたはフォルダ名
		;	戻り値	p1	/ 補正されたパス
		;		stat	/ 存在しない(0),ファイル(1)
		#deffunc existex val
		mref s,24
		repeat 6
		 if cnt=0 :string=s :else {
		  i=cnt-1 :string=dir@.i+s
		 }
		 gosub *@f
		 if stt=1 :break
		loop
		if stt=1 :s=string :else :stt=0
		return

		*@
		dllprocp FNC_GetFileAttributesA@,pstring,1
		if dllret@=-1 :stt=0	:return	; 存在しない
		if dllret@&$10:stt=-1	:return	; フォルダ
		stt=1
		return

		; サイズ自動調査 bsave
		;	使用値	p1	/ 保存名
		;		p2	/ 内容文字列
		#deffunc bsave_ str,val
		mref s,32 :mref data,25
		strlen i,data
		bsave s,data,i
		return

		; notesel してない変数の notemax
		;	使用値	p1	/ 行数を数える文字列型変数
		;	返り値	stat	/ 行数
		#deffunc notemax_ val
		mref notedata,24
		strlen i,notedata
		if i=0 :stt=0 :return
		; 文字列の最後が \n でなかったら付加
		strmid string,notedata,-1,2
		if string!"\n" :notedata+="\n"
		; 改行コード数を取得
		i=0
		repeat
		 instr ii,notedata,"\n",i
		 if ii=
		 if ii=-1 :stt=cnt :break
		 i+=ii+2
		loop
		return

		; notesel してない変数の一行目 切り取り	(notecut_)
		; 〃			　　　 取得	(noteget_)
		;	使用値	p1	/ 取得先
		;		p2	/ 取得元
		;	返り値	stat	/ 0(失敗) 1(成功)
		;		im	/ 取得元の長さ
		#deffunc note_ val,val,int
		mref s,24
		mref notedata,25
		mref cut,2 :cflg=cut
		strlen im@,notedata
		if im@=0 :s="" :stt=0 :return
		instr i,notedata,"\n",0
		if i=-1 {
		 strmid s,notedata,0,im@
		 if cflg :notedata=""
		} else {
		 strmid s,notedata,0,i
		 if cflg :strmid notedata,notedata,i+2,im@-i-2
		}
		stt=1
		return
		; マクロ定義
		#define global notecut_(%1,%2) note_ %1,%2,1
		#define global noteget_(%1,%2) note_ %1,%2,0

		; notesel していない変数中の該当データの行数取得
		;	使用値	p1	/ 行数を数える文字列
		;		p2	/ 取得元
		;	返り値	stat	/ 行数
		#deffunc notenum_ val,val
		mref s,24
		mref notedata,25
		instr till,notedata,s
		if till=-1 :stt=-1 :return
		; そこまでの改行コード数を取得
		i=0
		repeat
		 if i>=till :stt=cnt :break
		 instr ii,notedata,"\n",i
		 if ii=-1 :stt=cnt :break
		 i+=ii+2
		loop
		return

		; 文字の化けない strmid
		#deffunc strmid_ val,val,int,int
		mref to,24
		mref from,25
		mref start,2
		mref length,3
		strlen i,from :if i=0 :return
		string=from
		to=""
		i=0 :ii=start
		repeat length
		 peek i,string,ii
		 dllprocp FNC_IsDBCSLeadByte@,i,1
		 dllret@++
		 if ii+dllret@>length :break
		 strmid string2,string,ii,dllret@
		 to+=string2 :ii+=dllret@
		loop
		return

		; バイト単位のファイルサイズを文字列に変換
		;	使用値	p1	/ 変換先文字列変数
		;		p2	/ 変換前の数値
		#deffunc sizeconv val,int
		mref sizes,24
		mref size,1
		if size>1024 {
		 i=size/1024
		 sizes=""
		 if i>1024 {
		  size=i/1024
		  i=i\1024*1000/1024
		  str i,3
		  sizes=""+size+"."+i+"MB"
		  int i
		 } else {
		  size=size\1024*1000/1024
		  str size,3
		  sizes=""+i+"."+size+"KB"
		  int size
		 }
		} else {
		 sizes=""+size+"byte"
		 if size>1 :size+="s"
		}
		return

		; 文字列の置換
		; (1) 前準備
		;	使用値	p1	/ 置換後キーワード
		;		p2	/ 置換前キーワード
		#deffunc convkey str,str
		mref after_,32	:mref before_,33
		after=after_	:before=before_
		strlen la,after	:strlen lb,before
		return
		; (2) 置換
		;	使用値	p1	/ 置換後文字列代入先
		;		p2	/ 置換前文字列
		#deffunc conv val,val
		mref to,24 :mref from,25
		i=0 :to=""
		strlen l,from
		repeat
		 instr ii,from,before,i
		 if ii=-1 {
		  strmid string,from,i,l-i
		  to+=string :break
		 }
		 strmid string,from,i,ii
		 to+=string+after
		 i+=ii+lb
		loop
		return
		; (*) マクロ定義
		; convert 後,前,キー後,キー前
		#define global convert(%1,%2,%3,%4) convkey %3,%4 :conv %1,%2

		; 文字列の並び替え
		;	使用値	p1	/ 並び替える文字列
		#deffunc strsort val
		mref i :pvar=i
		if sortfunc1=0 {
		 ; マシン語コード格納
		 prm.2=$40,pi@
		 dim sortfunc1,10 :getptr psf1,sortfunc1
		 prm=psf1,40	:dllprocp FNC_VirtualProtect@,prm,4
		 dim sortfunc2,22 :getptr psf2,sortfunc2
		 prm=psf2,88	:dllprocp FNC_VirtualProtect@,prm,4
		 dim sortfunc3,50 :getptr psf3,sortfunc3
		 prm=psf3,200	:dllprocp FNC_VirtualProtect@,prm,4
		 dim sortfunc4,20 :getptr psf4,sortfunc4
		 prm=psf4,80	:dllprocp FNC_VirtualProtect@,prm,4
		 sortfunc1   =$8bc03353,$330c244c,$ebd98bd2,$0dea8009,$8301fa80,$118a00d0,$75d20a41,$8bcb2bf0
		 sortfunc1.8 =$4008245c,$c35b0b89
		 sortfunc2   =$24448b53,$245c8b08,$244c8b10,$ebd23314,$90909016,$fa809090,$8a11750d,$0afa8011
		 sortfunc2.8 =$c6410175,$8900ff43,$04c08318,$8841118a,$d20a4313,$d38be075,$0c244c8b,$1024542b
		 sortfunc2.16=$8b4b1189,$d33bfc50,$e8830375,$24442b04,$02e8c108,$0000c35b
		 sortfunc3   =$0424448b,$08244c8b,$1974c90b,$57565355,$7c8df08b,$6c8dfc88,$c033fc24,$000072e8
		 sortfunc3.8 =$5b5e5f00,$ff8bc35d,$df8b5756,$dbd1de03,$83fce383,$c78304ee,$eb1b8b04,$8b0e8b08
		 sortfunc3.16=$890f8917,$044e8b16,$8b04c683,$ff6a2055,$51ff6a53,$08006852,$69e80000,$83000000
		 sortfunc3.24=$e17202f8,$83fc4f8b,$558b04ef,$53ff6a20,$5251ff6a,$00080068,$004ae800,$f8830000
		 sortfunc3.32=$3be17702,$83b672f7,$c78304ee,$8b565b04,$8dfb8bf7,$fb3b045e,$23758e77,$8b204d8b
		 sortfunc3.40=$6a1f8b16,$ff6a53ff,$00685152,$e8000008,$00000014,$7602f883,$89068b06,$5f07891e
		 sortfunc3.48=$76e53b5e,$e7ff56ce
		 sortfunc4   =$448b5356,$5c8b0c24,$4c8b1024,$d2331424,$2474c90b,$0302e1c1,$6608ebcb,$0a0d00c7
		 sortfunc4.8 =$8b02c083,$04c38333,$108803eb,$46168a40,$f675d20a,$e372d93b,$18247c83,$66087400
		 sortfunc4.16=$0a0d00c7,$c602c083,$5e5b0000,$000000c3
		 ll_poke4 pfunc@.FNC_CompareStringA@-$5f-psf3,psf3+$5b
		 ll_poke4 pfunc@.FNC_CompareStringA@-$7e-psf3,psf3+$7a
		 ll_poke4 pfunc@.FNC_CompareStringA@-$b4-psf3,psf3+$b0
		 /*
		 ; (降順)
		 ; sortfunc3.24=$e17702f8,$83fc4f8b,$558b04ef,$53ff6a20,$5251ff6a,$00080068,$004ae800,$f8830000
		 ; sortfunc3.32=$3be17202,$83b672f7,$c78304ee,$8b565b04,$8dfb8bf7,$fb3b045e,$23758e77,$8b204d8b
		 ; sortfunc3.40=$6a1f8b16,$ff6a53ff,$00685152,$e8000008,$00000014,$7302f883,$89068b06,$5f07891e
		 */
		}
		; (1) sortfunc1
		prm=pi@,pvar
		ll_callfunc prm,2,psf1
		linenum=dllret@
		; (2) sortfunc2
		sdim notedata@,i@
		ll_getptr notedata@ :pnotedata=dllret@
		dim point,linenum :ll_getptr point :ppoint=dllret@
		prm=ppoint,pi@,pnotedata,pvar
		ll_callfunc prm,4,psf2
		pointnum=dllret@
		/*
		(バッファサイズ)<(必要サイズ) → エラー
		; if pval.2*4<(i+linenum-1) {
		;  sdim notedata@,bufnd@ :dim point,1 :stt=-1 :return
		; }
		*/
		; (3) sortfunc3
		prm=ppoint,pointnum,0
		/* prm.2
		1	大小文字を区別しない
		2	場所を取らない文字(濁音など)を区別しない
		4	記号を無視する
		$1000	句読点を記号として扱う
		$10000	ひらがなとカタカナを区別しない
		$20000	1 バイト文字と、それと同じ 2 バイト文字を区別しない
		*/
		ll_callfunc prm,3,psf3
		; (4) sortfunc4
		prm=pvar,ppoint,pointnum,linenum-pointnum
		ll_callfunc prm,4,psf4
		sdim notedata@,bufnd@
		dim point,1
		return

	; ―――――――――――――――――――――――――――――――――
	; COM 用命令

		; ANSI→UNICODE変換 (COM用)
		;	使用値	p1	/ 変換する文字列
		#deffunc uni val
		mref wc,24
		strlen prm.5,wc :prm.5++ :sdim mb,prm.5+1 :mb=wc
		prm=0,0,0,-1
		getptr prm.2,mb
		getptr prm.4,wc
		prm.5=prm.5*2
		dllprocp FNC_MultiByteToWideChar@,prm,6
		return

	; ―――――――――――――――――――――――――――――――――
	; DDE 用命令

		; 接続
		;	使用値	p1	/ サービス名
		;		p2	/ トピック名
		#deffunc dde_c str,str
		mref s,32  :string=s
		mref ss,33 :string2=ss
		prm=dde_inst,pstring,1004
		dllprocp FNC_DdeCreateStringHandleA@,prm,3 :i=dllret@
		prm.1=pstring2
		dllprocp FNC_DdeCreateStringHandleA@,prm,3 :ii=dllret@
		; i		/ サービス名のハンドル
		; ii		/ トピック名のハンドル
		prm.1=i,ii,0
		dllprocp FNC_DdeConnect@,prm,4
		dde_hconv=dllret@
	        ; dde_hconv	/ 通信ハンドル
	        prm.1=i  :dllprocp FNC_DdeFreeStringHandle,prm,2
	        prm.1=ii :dllprocp FNC_DdeFreeStringHandle,prm,2
		return

		; 切断
		#deffunc dde_dc
		dllprocp FNC_DdeDisconnect@,dde_hconv,1
		dde_hconv=0
		return

		; 情報の取得
		;	使用値	p1	/ アイテム名
		#deffunc dde_req str
		mref s,32 :string=s
		prm=dde_inst,pstring,1004
		dllprocp FNC_DdeCreateStringHandleA@,prm,3 :i=dllret@
		; i		/ データアイテム名のハンドル
		prm=0,0,dde_hconv,i,1,$20B0,5000,0
		dllprocp FNC_DdeClientTransaction@,prm,8
		prm=dde_inst,i
		i=dllret@
		; i		/ 返り値ハンドル
		dllprocp FNC_DdeFreeStringHandle@,prm,2
		s@=""
		if i {
		 prm=i,ps@,szs@-1,0
		 dllprocp FNC_DdeGetData@,prm,4
		 dllprocp FNC_DdeFreeDataHandle@,prm,1
		 stt=0
		} else {
		 stt=1
		}
		return

		; 機能の実行
		;	使用値	p1	/ コマンド
		#deffunc dde_exec str
		mref s,32 :string=s
		strlen i,string :i++
		prm=pstring,ii,dde_hconv,0,0,$4050,5000,0
		dllprocp FNC_DdeClientTransaction@,prm,8
		if dllret@ {
		 dllprocp FNC_DdeFreeDataHandle@,dllret@,1
		 stt=0
		} else :stt = 1
		return

	#global
	mref stt@arxmp_mod,64
	mref ref@arxmp_mod,65
	sdim before@arxmp_mod,512
	sdim after@arxmp_mod,512
	sdim string@arxmp_mod,512
	sdim string2@arxmp_mod,1024
	; dim pstring@arxmp_mod
	; dim pstring2@arxmp_mod
	getptr pstring@arxmp_mod,string@arxmp_mod
	getptr pstring2@arxmp_mod,string2@arxmp_mod	
	; dim mii
	getptr pmii,mii


; ―――――――――――――――――――――――――――――――――――――
;                                                              (c) arc@arcis
