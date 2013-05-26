
title "設定 / 音楽再生"
; ―――――――――――――――――――――――――――――――――――――

/* 制作メモ ――――――――――――――――――――――――――――――――

 ・この as ファイルについて

	プレイヤーが再生できるファイル種を変更するプラグインです。

 ―――――――――――――――――――――――――――――――――――― */


; ―――――――――――――――――――――――――――――――――――――
; 命令拡張など

	#include "_init_def.as"
	#include "_mod_xpi.as"
	ll_getproc pEnableWindow,"EnableWindow",XD_USER
	#define DisableWindow prm=xpi_hwnd@xpimod,0 :ll_callfunc prm,2,pEnableWindow

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
	; stat		/	プレイヤーのバージョン番号
	;			or 0 (プレイヤーが起動していない)
	if stat=0 {
	 dialog "プレイヤー本体が起動していることを確認できませんでした。\nプラグインを終了します。",0
	 end
	}

	sdim types,sztypes,ntypes
	xpi_peek types,ai.ptypes,sztypes*ntypes


; ―――――――――――――――――――――――――――――――――――――
; 画面の整備

	width 360,270
	redraw 2

	prm=15
	dllproc "GetSysColor",prm,1,XD_USER
	col=dllret&255,dllret>>8&255,dllret>>16&255
	; col		/	(配列変数) システム色

	color col,col.1,col.2
	boxf

	color 0,0,0
	font "MS UI Gothic",16,17
	pos 10,10
	mes "再生できるファイル種の設定"
	line 10,26,winx-10,26

	font "ＭＳ ゴシック",12,16
	objmode 2,1
	objsize winx-110,20
	pos 15,40	:mes "MP3"
	pos 100,36	:input types.TP_MP3
	pos 15,65	:mes "WMA"
	pos 100,61	:input types.TP_WMA
	pos 15,90	:mes "Midi"
	pos 100,86	:input types.TP_MID
	pos 15,115	:mes "Wave"
	pos 100,111	:input types.TP_WAV
	pos 15,140	:mes "OggVorbis"
	pos 100,136	:input types.TP_OGG
	pos 15,165	:mes "CD Audio"
	pos 100,161	:input types.TP_CDA
	pos 15,190	:mes "(MCI)"
	pos 100,186	:input types.TP_MCI
	pos 15,215	:mes "(DirectShow)"
	pos 100,211	:input types.TP_DXS

	font "MS UI Gothic",12,16
	objsize 60,25
	pos winx-66,winy-30 :button "OK",*ok

	redraw 1
	gsel 0,1
	stop


; ―――――――――――――――――――――――――――――――――――――
; 設定の変更

*ok

	repeat sztypes*ntypes
	 peek i,types,cnt
	 if (i>='a')&(i<='z') :i-=32 :poke types,cnt,i
	loop
	xpi_poke types,ai.ptypes,sztypes*ntypes

	end


; ―――――――――――――――――――――――――――――――――――――
;                                                              (c) arc@arcis
