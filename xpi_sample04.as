
title "arxmp 用プラグインのサンプル(4)"
; ―――――――――――――――――――――――――――――――――――――

/* 制作メモ ――――――――――――――――――――――――――――――――

 ・この as ファイルについて

	プラグインのサンプルです。

 ―――――――――――――――――――――――――――――――――――― */

	#include "_init_def.as"
	#include "_mod_xpi.as"

	xpi_connect ,1
	if stat=0 :end

	font "ＭＳ ゴシック",16
	pos 10,10
	mes "プラグインが起動した時点で再生されている音楽の情報を表示します。"

	pos 20,csry+10
	mes "文字列型情報"
	font "ＭＳ ゴシック",12
	pos 30,csry+5

	sdim a,szminfo_
	repeat nminfo_
	 xpi_peek a,ai.pminfo_+(szminfo_*cnt),szminfo_
	 mes ""+cnt+": "+a
	loop

	font "ＭＳ ゴシック",16
	pos 20,csry+10
	mes "数値型情報"
	font "ＭＳ ゴシック",12
	pos 30,csry+5

	dim i
	repeat nminfo
	 xpi_peek i,ai.pminfo+(4*cnt),4
	 mes ""+cnt+": "+i
	loop

	gsel 0,1
	stop


; ―――――――――――――――――――――――――――――――――――――
;                                                              (c) arc@arcis
