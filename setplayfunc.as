
title "設定 / 音楽再生"
; ―――――――――――――――――――――――――――――――――――――

/* 制作メモ ――――――――――――――――――――――――――――――――

 ・この as ファイルについて

	再生に使用する仕組みを変更するプラグインです。

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

	;#const PF_MCI		$1000	; MCI で再生
	;#const PF_DXS		$2000	; DirectShow で再生
	;#const PF_DLL		$3000	; その他の特殊な DLL を用いて再生
	xpi_peek pf_mp3,ai.ptype   ,4 :pf_mp3=pf_mp3/$1000-1
	xpi_peek pf_wma,ai.ptype+4 ,4 :pf_wma=pf_wma/$1000-1
	xpi_peek pf_mid,ai.ptype+8 ,4 :pf_mid=pf_mid/$1000-1
	xpi_peek pf_wav,ai.ptype+12,4 :pf_wav=pf_wav/$1000-1
	xpi_peek pf_ogg,ai.ptype+16,4 :pf_ogg=pf_ogg/$1000-1


; ―――――――――――――――――――――――――――――――――――――
; 画面の整備

	width 320,215
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
	mes "再生に使用する仕組みの変更"
	line 10,26,winx-10,26

	font "ＭＳ ゴシック",12,16
	objmode 2,1
	objsize winx-90,21
	pos 15,40	:mes "MP3"
	pos 80,36	:combox pf_mp3,100,"MCI(標準設定)\nDirectShow\nVBMP3.dll"
	pos 15,65	:mes "WMA"
	pos 80,61	:combox pf_wma,100,"MCI\nDirectShow(標準設定)"
	pos 15,90	:mes "Midi"
	pos 80,86	:combox pf_mid,100,"MCI\nDirectShow(標準設定)\nDDE(TMIDI Playerなど)"
	pos 15,115	:mes "Wave"
	pos 80,111	:combox pf_wav,100,"MCI(標準設定)\nDirectShow"
	pos 15,140	:mes "OggVorbis"
	pos 80,136	:combox pf_ogg,100,"MCI\nDirectShow\nVox.dll(標準設定)"
	pos 15,165	:mes "CD Audio"
	pos 84,165	:mes "MCI(固定)"

	font "MS UI Gothic",12,16
	objsize 60,25
	pos winx-66,winy-30 :button "OK",*ok

	redraw 1
	gsel 0,1
	stop


; ―――――――――――――――――――――――――――――――――――――
; 設定の変更

*ok

	; プレイヤーが待機状態になるまで待つ
	DisableWindow
	i=0
	repeat 1
	 xpi_func FNC_IDLECHK,2
	 if stat=-1 {
	  dialog "プレイヤーが処理を実行中であるため、設定を変更できません。\nダイアログが開いている場合は一旦キャンセルするなどしてから再度 [OK] を押してください。"
	  i++ :continue 0
	 }
	loop

	; 設定の変更
	s=""
	xpi_func FNC_SET_PLAYFUNC+TP_MP3+((pf_mp3+1)*$1000)
	if stat=FR_ERR :s+="vbmp3.dll "
	xpi_func FNC_SET_PLAYFUNC+TP_WMA+((pf_wma+1)*$1000)
	xpi_func FNC_SET_PLAYFUNC+TP_MID+((pf_mid+1)*$1000)
	xpi_func FNC_SET_PLAYFUNC+TP_WAV+((pf_wav+1)*$1000)
	xpi_func FNC_SET_PLAYFUNC+TP_OGG+((pf_ogg+1)*$1000)
	if stat=FR_ERR :s+="vox.dll "
	if s!"" {
	 dialog s+"が見つからなかったため設定を正しく変更できませんでした。\nDLLをダウンロードして arxmp.exe のあるフォルダ内に移動後、再度設定し直してください。"
	}

	end


; ―――――――――――――――――――――――――――――――――――――
;                                                              (c) arc@arcis
