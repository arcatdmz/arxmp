
title "arxmp 用プラグインのサンプル(5)"
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
	mes "再生リストの内容を表示します。"

	pos 20,csry+10
	font "ＭＳ ゴシック",12

	sdim list,65535
	xpi_peek list,ai.plist,65535

	gsel 0,1

	; ――――――――――――――――――――――――――――――――
	; プレイヤーの再生リストはメモリノートパッド命令で管理されており、
	; 自動的にメモリの確保容量を増加させる機能が使用されるとリストのデ
	; ータへのポインタが変更されます。

	if list="" {

	; その際は上記の命令で再生リストを取得することができなくなるので、
	; 一旦 xpi_func FNC_XLT_SAVE などで 再生リストを一時ファイルとして
	; 保存(#1)後、プラグイン側でメモリノートパッド命令 noteload からデ
	; ータを読み込む(#2)しかありません。

	; #準備
	dialog "再生リストの取得に失敗しました。\n再生リスト登録ファイル数が多すぎるのかもしれません。\n\n一時ファイルを介して再度取得に試みますか？",2
	if stat=7 :end
	i=0
	repeat 1
	 xpi_func FNC_IDLECHK,2
	 if stat=-1 {
	  dialog "プレイヤーが処理を実行中であるため、リストを取得できません。\nダイアログが開いている場合は一旦キャンセルするなどしてから再度 [OK] を押してください。"
	  i++ :continue 0
	 }
	loop

	; #1
	; 一時ファイルの作成
	file="C:\\plugin_tmp.xlt"
	xpi_opt file
	xpi_func FNC_XLT_SAVE|FNC_STR

	; #2
	; 一時ファイルの読み込み
	exist file
	if strsize!-1 {
	 if strsize>0 {
	  ; tmp に読み込み
	  tmp="" :notesel tmp :noteload file :notemax i
	  ; 表示可能量を list にコピー
	  memcpy list,tmp,65535
	 }
	 ; 使用した一時ファイルを削除
	 delete file
	}

	}

	; ――――――――――――――――――――――――――――――――

	strlen i,list
	if i=0 :list="(再生リストは空でした)"

	mes list

	stop


; ―――――――――――――――――――――――――――――――――――――
;                                                              (c) arc@arcis
