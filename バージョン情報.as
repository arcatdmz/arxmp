
screen 3,320,240,6
title "バージョン情報"
; ―――――――――――――――――――――――――――――――――――――

/* 制作メモ ――――――――――――――――――――――――――――――――

 ・この as ファイルについて

	バージョン情報を表示します。

 ―――――――――――――――――――――――――――――――――――― */

	#include "_init_def.as"
	#include "_mod_xpi.as"

	xpi_connect ,1
	if stat=0 :end

	redraw 2

	font "Arial Black",300,17
	color 230,240,255
	pos 170,-90	:mes "5"
	color 240,240,240
	pos -15,-80	:mes "b"
	font "Arial Black",144,17
	pos 120,-20	:mes "e"
	font "Arial Black",96,17
	pos 190,80	:mes "t"
	font "Arial Black",144,17
	pos 220,20	:mes "a"

	font "Verdana",24,16
	color 0,0,0		:line 15,37,winx-15,37
	color 240,240,240	:line 15,41,winx-15,41
	color 0,0,0
	pos 15,8 :mes "arX MusicPlayer"

	font "Verdana",16,16
	pos 30,55 :mes "ver:"		:pos 150,55 :mes ai
	pos 30,75 :mes "script ver:"	:pos 150,75 :mes ai.1
	pos 30,95 :mes "lang. ver:"	:pos 150,95 :mes ai.2

	font "MS UI Gothic",13
	objmode 2,1
	objsize 120,30	:pos 125,200	:button "公式サイトへ",*open_web
	objsize 60,30	:pos 250,200	:button "閉じる",*close

	redraw 1

	gsel 3,1
	stop

	*open_web
	exec "http://digitalmuseum.jp/arxmp/",16
	stop

	*close
	end


; ―――――――――――――――――――――――――――――――――――――
;                                                              (c) arc@arcis
