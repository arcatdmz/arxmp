
title "機能番号テスター"
; ―――――――――――――――――――――――――――――――――――――

/* 制作メモ ――――――――――――――――――――――――――――――――

 ・この as ファイルについて

	機能番号の実行をテストします。

 ―――――――――――――――――――――――――――――――――――― */

	#include "_init_def.as"
	#include "_mod_xpi.as"

	ll_getproc pEnableWindow,"EnableWindow",XD_USER
	#define ableobj(%1,%2)	prm=%1+41 :prm=bmscr@xpimod.prm,%2 :ll_callfunc prm,2,pEnableWindow
	#define disableobj(%1)	ableobj %1,0
	#define enableobj(%1)	ableobj %1,1

	xpi_connect ,1
	if stat=0 :end

	; Prepare for main processing.
	font "MS UI Gothic",14
	font "Tahoma",14
	objmode 2,1
	dim func
	func="$00000000"
	sdim funcopts,65535
	funcopts="(機能番号に STR=$00040000 が含まれているときのみ、この欄に入力された文字列が機能のオプションとして使用されます。)"
	sdim s,64

	; Initialize the main window.
	pos 10,7
	mes "機能番号:"
	pos 10,33
	mes "オプション:"
	objsize winx-90,21
	pos 85,5
	input func
	objsize winx-90,409
	pos 85,31
	mesbox funcopts,,,1
	objsize 135,30
	pos 395,445
	button "機能番号について",*explanation
	objsize 100,30
	pos 535,445
	button "機能の実行",*execute

	; Show the main window. (Stand by.)
	gsel 0,1
	stop

	; Show the web page explaining "機能番号".
	*explanation
	exec "http://dmz.catfood.jp/1/arxmp/res/arxmp_functype.html",16
	stop

	; Execute specified "機能番号",
	;  and inform result by showing dialog.
	*execute
	int func
	if func&$040000	:xpi_opt funcopts
	repeat 4 :disableobj cnt :loop
	xpi_func func
	repeat
	 s=stat
	 if s=$0F000001	:s="FR_IDLE(プレイヤーは待機状態です)" :break
	 if s=$0F000000	:s="FR_ERR(機能実行中にエラーが発生しました)" :break
	 if s=$00000000	:s="FR_DONE(機能は問題なく実行されました)" :break
	 str s
	 break
	loop
	repeat 4 :enableobj cnt :loop
	str func,24
	func="$"+func
	dialog "実行された機能: "+func+"\n返り値: "+s
	objprm 0,func
	stop


; ―――――――――――――――――――――――――――――――――――――
;                                                              (c) arc@arcis
