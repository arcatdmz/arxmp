;
#define mytitle "ファリスのジョブチェンジ"
; ―――――――――――――――――――――――――――――――――――――

/* 制作メモ ――――――――――――――――――――――――――――――――

 ・この as ファイルについて

	ファリスのジョブチェンジを行います。

 ―――――――――――――――――――――――――――――――――――― */

	#include "llmod.as"
	#include "_init_def.as"
	#include "_mod_xpi.as"

	xpi_connect
	if stat=0 :end

	#define faris_folder	"ファリス★スキン\\"
	#define faris_skin	"ファリス★スキン.xsp"
	#define faris_setting	"ファリス★スキン.xsv"
	#const CharX		284
	#const CharY		142

	#module
	; システム色を取得
	; p1 : 取得先
	; p2 : 取得情報
	#deffunc excinfo val,int
	mref col,48
	mref prm,1
	dllproc "GetSysColor",prm,1,D_USER
	col.0=dllret@&255
	col.1=dllret@>>8&255
	col.2=dllret@>>16&255
	return
	; ウィンドウの操作
	; active p1,p2
	;  p1 : 操作モード(ウィンドウを強制アクティブ/ウィンドウを操作可能/不可能)
	;  p2 : ウィンドウID
	#deffunc active int,int
	mref i,0
	mref wid,1
	if i=0 :gsel wid,1 :return
	mref bmscr,96+wid
	prm=bmscr.13,(i=1)
	dllproc "EnableWindow",prm,2,D_USER@
	return
	#global

	; バッファ確保
	sdim s	,	512
	sdim ss	,	512
	dim i :dim ii :dim iii
	sdim tmp,	3200
	;  画像ファイルのリスト
	sdim xsslist,	2048
	;  スキンディレクトリ
	sdim skndir,	512
	;  システム色
	dim SysColor,3	:excinfo SysColor,15	;背景色
	dim SysColorS,3	:excinfo SysColorS,16	;線色
	;  現在のジョブ（画像ファイル名）
	sdim now_faris,	256
	;  選択されているジョブ
	dim sel_xsslist :dim sel_xsslist_b
	;  スキンの透過色
	dim TransColor,3

	; 初期化
	font "ＭＳ ゴシック",13 :objmode 2
	width 450,180
	title mytitle

;_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/
; メイン処理

	; スキン情報を取得
	xpi_peek skndir,ai.pdir,szdir
	xpi_peek s,ai.psinfo_,szsinfo_
	if s!faris_skin {
	 exist skndir+faris_skin
	 if strsize=-1 :dialog "このプラグインはファリス★スキンがないと利用できません。\n現在プレイヤーにはファリス★スキンがインストールされていないので、プラグインを終了します。",0,mytitle :end
	 dialog "このプラグインはプレイヤーのスキンが「ファリス★スキン」でないと利用できません。\nプレイヤーのスキンをファリス★スキンに変更しますか？",2,mytitle
	 if stat=7 :end
	 s=faris_skin
	 xpi_opt s
	 xpi_func FNC_XSP_LOAD|FNC_STR
	}

	; 画像リストの取得
	gosub *_refresh_xsslist
	buffer 3 :gsel 0

	; 画面の整備
	font "ＭＳ ゴシック",12 :objmode 2
	redraw 2
	pos 5,5		:objsize winx-40,21 :combox sel_xsslist,120,xsslist
	pos winx-35,5 :objsize 30,20 :button "更新",*refresh_xsslist
	pos 5,30	:objsize 150,winy-35 :button "ジョブチェンジ←",*change_job
	gosub *load_job
	gosub *refresh
	redraw 1

	gsel 0,1

; メインループ
*mainloop
	if sel_xsslist!sel_xsslist_b :sel_xsslist_b=sel_xsslist :redraw 2 :gosub *refresh :redraw 1
	wait 5
	goto *mainloop

; 現在のジョブ設定を読み込む
*load_job
	; スキン設定ファイルを読み込み
	exist skndir+faris_setting
	if strsize=-1 :return
	bload skndir+faris_setting,tmp
	notesel tmp :noteget s,0
	strlen i,s
	ii=0
	; 画像ファイル名を取得
	repeat i
	 instr iii,s,"\\",ii
	 if iii!-1 :ii+=iii+1 :continue
	 strmid s,s,ii,i-ii :break
	loop
	; ジョブのリストと比較
	notesel xsslist :notemax i
	repeat i
	 noteget ss,cnt
	 if ss=s :sel_xsslist=cnt :break
	loop
	return

; ジョブを変更する
*change_job
	; 選択されたジョブが無い？
	if sel_xsslist=-1 :return
	; 画像が存在しないジョブ？
	if strsize=-1 :return
	; ジョブを変更（スキン設定ファイルを読み込み）
	active 2
	title "少しお待ち下さい / "+mytitle
	s=skndir+faris_folder+now_faris+".xss"
	xpi_opt s
	xpi_func FNC_XSS_LOAD|FNC_STR
	title mytitle
	active 1
	goto *mainloop

; 画面を更新する
*refresh
	; 画像読み込み
	if sel_xsslist=-1 :return
	notesel xsslist
	noteget now_faris,sel_xsslist
	s=skndir+faris_folder+now_faris+".bmp"
	exist s
	gsel 3
	color SysColor.0,SysColor.1,SysColor.2		:boxf
	if strsize!-1 {
	 pos 0,0 :picload s,1,0,0
	 pget 0,0 :TransColor.0=rval :TransColor.1=gval :TransColor.2=bval
	}
	; 画面に表示
	gsel 0
	color SysColor.0,SysColor.1,SysColor.2		:boxf
	color TransColor.0,TransColor.1,TransColor.2	:gmode 4,,,256
	pos 160,30 :gcopy 3,0,0,CharX,CharY
	return

; リストの更新
*refresh_xsslist :gosub *_refresh_xsslist :goto *mainloop
*_refresh_xsslist
	; ジョブのリストを取得
	dirlist xsslist,skndir+faris_folder+"*.xss",1
	notesel xsslist
	notemax i
	if i=0 :dialog "ジョブチェンジするために必要なスキン設定ファイル(*.xss)が一つもありません。\nプラグインを終了します。",0,mytitle :end
	; 拡張子の除去(abc.xss → abc)
	repeat i
	 noteget s,cnt
	 strlen i,s
	 strmid s,s,0,i-4
	 noteadd s,cnt,1
	loop
	; コンボボックス内容更新
	objprm 0,xsslist
	return


;_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/
;                                               (C) Arc@ARCIS