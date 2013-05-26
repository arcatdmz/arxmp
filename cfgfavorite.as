
title "お気に入り / 編集"
; ―――――――――――――――――――――――――――――――――――――

/* 制作メモ ――――――――――――――――――――――――――――――――

 ・この as ファイルについて

	お気に入りを編集します。

 ―――――――――――――――――――――――――――――――――――― */


; ―――――――――――――――――――――――――――――――――――――
; 命令拡張など

	#include "_init_def.as"
	#include "_mod_xpi.as"
	ll_libload D_SHELL,"shell32"
	ll_getproc pEnableWindow,"EnableWindow",XD_USER
	ll_getproc pSHFileOperationA,"SHFileOperationA",D_SHELL
	#define EnableWindow prm=bmscr.13,1 :ll_callfunc prm,2,pEnableWindow
	#define DisableWindow prm=bmscr.13,0 :ll_callfunc prm,2,pEnableWindow

	; ミニ llmod
	#module
		#deffunc dllproc str,val,int,int
		mref funcname,32 :mref prms,17 :mref prm_n,2 :mref dll_no,3
		ll_getproc func,funcname,dll_no
		ll_callfunc prms,prm_n,func :return
	#global


; ―――――――――――――――――――――――――――――――――――――
; プラグインとしての準備

	xpi_connect ,1
	if stat=0 :end

	sdim datdir,szdir
	xpi_peek datdir,ai.pdir+szdir,szdir

	; お気に入りリスト
	sdim list,4096
	notesel list
	dirlist list,datdir+"*.xlt",1
	; (本体と同期)
	xpi_func FNC_XLT_LOAD|FNC_AUTO|FNC_REFRESH

	; SHFileOperationA
	#const sz	512
	getptr pprm,prm
	getptr pi,i
	sdim s,sz
	sdim from,sz	:getptr pfrom,from
	sdim to,sz	:getptr pto,to


; ―――――――――――――――――――――――――――――――――――――
; 画面の整備

	prm=15
	dllproc "GetSysColor",prm,1,XD_USER
	col=dllret&255,dllret>>8&255,dllret>>16&255
	; col		/	(配列変数) システム色

	screen 3,240,80,6
	title "名前の変更"
	font "MS UI Gothic",13
	objmode 2,1
	color col,col.1,col.2
	boxf
	color 0,0,0
	pos 5,5
	mes "変更後の名前を入力してください。"
	objsize winx-10,20
	pos 5,25
	input to
	objsize 50,25
	pos 102,50
	button "OK",*rnm_ok
	objsize 80,25
	pos 155,50
	button "キャンセル",*rnm_cancel

	gsel 0
	width 360,225
	mref bmscr,67

	color col,col.1,col.2
	boxf

	font "MS UI Gothic",13
	objmode 2,1
	objsize winx-10,200
	pos 5,5		:listbox sel,0,list
	objsize 90,25
	pos 195,190	:button "名前の変更",*rnm
	objsize 60,25
	pos 290,190	:button "削除",*dlt

	gsel 0,1
	stop

*rnm
	if sel=-1 :stop
	DisableWindow
	noteget from,sel
	gsel 3
	strlen i,from
	strmid to,from,0,i-4
	objprm 0,to
	gsel 3,1
	gsel 0
	stop

*rnm_cancel
	EnableWindow
	gsel 3,-1
	gsel 0
	stop

*rnm_ok
	s=to+".xlt"
	from=datdir+from
	to=datdir+s
	strlen i,from	:memset from,0,sz-i,i
	strlen i,to	:memset to,0,sz-i,i
	prm=bmscr.13,4,pfrom,pto,$40,pi,0,0
	ll_callfunc pprm,1,pSHFileOperationA
	if dllret=0 {
	 notedel sel
	 noteadd s,sel
	 objprm 0,list
	 xpi_func FNC_XLT_LOAD|FNC_AUTO|FNC_REFRESH
	}
	goto *rnm_cancel

*dlt
	if sel=-1 :stop
	noteget from,sel
	dialog "選択されたお気に入りリストをごみ箱に捨ててもよろしいですか？\n\n("+from+")",2
	if stat=7 :stop
	from=datdir+from
	strlen i,from	:memset from,0,sz-i,i
	prm=bmscr.13,3,pfrom,0,$50,pi,0,0
	ll_callfunc pprm,1,pSHFileOperationA
	if dllret=0 {
	 notedel sel
	 objprm 0,list
	 xpi_func FNC_XLT_LOAD|FNC_AUTO|FNC_REFRESH
	}
	stop


; ―――――――――――――――――――――――――――――――――――――
;                                                              (c) arc@arcis
