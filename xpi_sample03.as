
title "arxmp 用プラグインのサンプル(3)"
; ―――――――――――――――――――――――――――――――――――――

/* 制作メモ ――――――――――――――――――――――――――――――――

 ・この as ファイルについて

	プラグインのサンプルです。

 ―――――――――――――――――――――――――――――――――――― */

	#include "_init_def.as"
	#include "_mod_xpi.as"

	xpi_connect 1,1
	if stat=0 :end

	pos 10,10
	mes "プレイヤーが音楽を再生している状態に変更があると表示します。"
	pos 20,35

	sdim status,9,4
	status="停止","再生終了","再生開始","一時停止"

	gsel 0,1

	repeat
	 gm_getmessage msgval
	 if msgval!0 {
	  if msgval.1=WM_NOTIFYPI {
	   i=msgval.3 :mes status.i
	  }
	 }
	 wait 10
	loop


; ―――――――――――――――――――――――――――――――――――――
;                                                              (c) arc@arcis
