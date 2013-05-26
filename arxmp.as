
; ■ arX MusicPlayer					      音楽プレイヤー
; ―――――――――――――――――――――――――――――――――――――

	; 通常版として配布時はコメントアウト
	;#const DEBUG	1

/* 制作メモ ――――――――――――――――――――――――――――――――

 ・プログラムの仕様

	0. ソースコード
	─=─=─=─=─=─=─=─=─=─=─=─=─=─=─=─=─=─=─=─=─=─=─

	◇ as ファイル	　　◇ ax ファイル	◇機能
	-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
	arxmp_start.as	　　start.ax		ax, xpi ファイルの起動
	arxmp.as	　　arxmp.ax		メインの処理
	strmod.as	　　-			(命令拡張, 文字列操作関係)
	_mod.as		　　-			(命令拡張)
	_init_def.as	　　-			(定義, プラグインと共有)
	_init_defex.as	　　-			(定義)
	_init_xpi.as	　　-			(プラグイン対応の準備)
	_init_var.as	　　-			(変数領域の確保)
	_func.as	　　-			(機能, 機能番号の処理)
	_script.as	　　-			(機能, スクリプトの処理)
	_sub.as		　　-			(機能, サブルーチン)
	cfgfavorite.as	　　cfgfavorite.ax	お気に入りの編集
	setplayfunc.as	　　setplayfunc.ax	再生機能の設定
	setplaytype.as	　　setplaytype.ax	再生可能種の設定
	_mod_xpi.as	　　-			(命令拡張, プラグイン用)

	1. 正式対応メディア
	─=─=─=─=─=─=─=─=─=─=─=─=─=─=─=─=─=─=─=─=─=─=─

	◇種類			◇再生手法		◇取得可能なタグ種
	-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
	MPEG Audio		MCI, DirectShow, vbmp3	MPEGヘッダ, ID3v1
	Windows MediaAudio	MCI, DirectShow		不可
	Midi			MCI, DirectShow, DDE	SMFメタイベント
	Wave			MCI, DirectShow		不可
	OggVorbis		MCI, DirectShow, vox	(vox 経由で)推奨タグ
	CD Audio		MCI, (DirectShow)	不可

	※ タグ情報は mp3infp を利用することで追加取得可
	※ 再生手法 MCI, DirectShow が対応するメディアなら上記以外でも再生可

	2. 再生リスト
	─=─=─=─=─=─=─=─=─=─=─=─=─=─=─=─=─=─=─=─=─=─=─

	格納可能な項目数は無制限ですが、リストボックスやコンボボックスに64KB
	超の内容を表示できないWin9Xに配慮して ファイル名リストの全長がそれま
	でに制限されています。リスト編集中に制限を越えた場合は、警告表示後64
	KB以降の項目が自動的に削られます。

	(cf. _func.as 「FNC_LIST_～」 )

	3. 機能番号
	─=─=─=─=─=─=─=─=─=─=─=─=─=─=─=─=─=─=─=─=─=─=─

	プレイヤーの機能のほとんどには16進数で8桁の番号が付けられています。

	上二桁で大まかな種類を指定し、次のニ桁で大まかな動作オプションを、残
	り二桁で詳細なオプションを指定するようになっています。

	(cf. _func.as )
	(cf. http://hp.vector.co.jp/authors/VA022483/xmp/res/func.html )

	4. スクリプト
	─=─=─=─=─=─=─=─=─=─=─=─=─=─=─=─=─=─=─=─=─=─=─

	スキンなどで使われる独自のインタプリタ言語を「スクリプト」と呼んでい
	ます。hsp2.exe が ax ファイルをリアルタイムに処理して 様々なプログラ
	ムとしての機能を果たすように、arxmp.exe はスクリプトをリアルタイムに
	処理することで外観を変えたり、自動処理を実行することができます。
	arxmp が HSP で開発されたこともあり、文法が少し HSP に似ています。

	(cf. _script.as )
	(cf. _func.as 「FNC_XSP_LOAD」e.t.c. )
	(cf. http://hp.vector.co.jp/authors/VA022483/xmp/res/skin.html )
	(cf. http://hp.vector.co.jp/authors/VA022483/xmp/res/script.html )

	5. プラグイン
	─=─=─=─=─=─=─=─=─=─=─=─=─=─=─=─=─=─=─=─=─=─=─

	プラグインと言っても要は拡張子を xpi に変えた ax ファイルを 本体と別
	に起動しているだけです。 hsgetmsg(ちょくとさん製作) を利用して本体と
	プラグインでウィンドウメッセージのやり取りをすることで、プラグインか
	ら本体の機能を実行したり結果を取得したりできるようになっています。
	また、本体側で起動時に FileMappingObject を作成して 変数のポインタ情
	報を保存、プラグインからそれを読み込んで本体の変数内容を操作できるよ
	うにしてあります。 プラグインが FMO の指定領域に自分のウィンドウハン
	ドル情報を登録しておくと、イベント発生時に本体からウィンドウメッセー
	ジの通知を受けられる仕組みもあります。

	(cf. _init_xpi.as )
	(cf. _func.as 「FNC_XPI_LOAD」 )
	(cf. http://hp.vector.co.jp/authors/VA022483/xmp/res/plugin.html )
	(cf. http://hp.vector.co.jp/authors/VA022483/text.html「mbmod.as」)

	6. デバッグウィンドウ
	─=─=─=─=─=─=─=─=─=─=─=─=─=─=─=─=─=─=─=─=─=─=─

	#const DEBUG 1 をコメントアウトせずに arxmp.as をコンパイルすると、
	デバッグウィンドウ付きの arxmp.ax が作成されます。

	◇表示内容
		◇説明
	-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
	BTN [window name] (id=[objid])
		[window name]上のボタン(オブジェクトID[objid])の機能を実行
	MSG [message code]->[hwnd],[lprm],[wprm]
		[hwnd]に送られたウィンドウメッセージ(WM_*)[message code]を処理
	FNC [func]
		[func] で表される機能を実行(_func.as 参照)
	CNV (menuid=[menuid])
		[menuid] を機能番号に変換して実行(_func.as 参照)

 ・課題

	MPEG Audio (VBR) で再生中位置表示がおかしい(DirectShow Filterのバグ)
	CD再生中の終了で稀にメモリアクセスエラーが起きる

 ・更新履歴

   ver.400(00)	2002/11/01	β2として公開
          (01)	2002/11/04	口調ファイルの仕様変更
          (02)	2002/11/06	拡張スクリプトの仕様変更
          (03)	2002/11/07	拡張スクリプトの仕様修正、カレントディレクトリ問題修正、スキンプログラム書式修正、口調ファイルが読み込まれないバグを修正。
          (04)	2002/11/09	スキンプログラムのバグ修正、フォルダとファイルの追加ダイアログを変更、ファイルの追加モード選択機能追加、ドラッグ＆ドロップができないバグを修正。
          (05)	2002/11/10	多分最後の書式変更。フォルダを正しく追加できないバグを修正、拡張プログラムのバグを修正。
          (06)	2002/11/11	拡張プログラムの書式を調整。チップヘルプとフォルダ検索オプションが保存されないバグを修正。ドラッグ＆ドロップに対応しきれていなかったバグを修正。
          (07)	2002/11/18	スキンスクリプト実行中に落ちるバグを修正
          (08)	2002/11/25	お気に入りを読み込めないバグを修正
          (09)	2002/12/01	口調ファイルが読み込めないバグを修正。拡張スクリプトの命令を拡張。
          (10)	2002/12/14	スキン変数の全機能を実装
          (11)	2002/12/14	リージョンウィンドウ作成の激速化
          (12)	2002/12/18	VBMP3.dllを使用可能に
          (13)	2002/12/23	スキンの仕様を拡張、スクリプトを少し整理
          (14)	2002/12/24	微妙なバグを修正
          (15)	2002/12/25	ほんの少し修正
          (16)	2003/01/11	仕様拡張、MCIで再生するファイル種を設定できるように、スキンのバグ修正
          (17)	2003/04/14	仕様拡張、再生リスト繰り返しオプション追加、再生位置表示バー追加。hsplmenu.dll/Srexhsp.dll 不使用、CD対応
        (17.0)	2003/04/15	リスト中のファイル数が常に3個と表示されるバグ修正/CDを再生できないバグ修正
        (17.1)	2003/04/19	リストファイル読み込みバグ修正/ウィンドウサイズ通知バグ修正
	(17.2)	2003/04/26	キーボード操作のサポート/初期設定スキン差し替え/音量調整/スキン仕様拡張
   ver.401(00)	2003/05/02	プラグイン仕様決定/フォルダ追加高速化/プラグイン動作高速化/タイトルが変わらないバグ修正
        (00.0)	2003/05/18	ファイル追加機能の統合
        (00.1)	2003/05/21	追加するファイル種の管理方法を変更(内部処理)
        (00.2)	2003/06/12	ドラッグ＆ドロップされたファイルの処理方法変更(内部処理)
	(00.3)	2003/07/03	CD再生時のバグを修正
          (01)	2003/07/16	バグ修正、メモリ共有モジュール自作、SendMessage対応、プラグインEXE/LNK対応、ファイルリスト自動並び替え、スクリプト書式拡張
   ver.402(00)	2003/09/16	バグ修正、OggVorbis 正式対応、ウィンドウ最前面表示機能追加
          (01)	2003/10/12	ダイアログが隠れるバグ、縦シークバーが正しく表示されないバグ、ドラッグ＆ドロップとシークの優先順位変更
          (01)	2003/10/29	mp3infpに対応、ファイルのプロパティ表示機能追加、フォルダ選択ダイアログ表示時のバグ修正(?)
          (02)	2003/11/21	右クリックメニューが意図しない場面で出てしまうバグ、フォルダ内ファイル検索中に落ちるバグ、不定形ウィンドウへのファイルのドラッグ＆ドロップが出来ないバグを修正。開発環境をHSP2.55→2.6へ移行、JPEG読み込みを可能に。
          (02)	2003/12/01	WMAファイル情報読み込み時にエラーが起きるバグを修正
          (03)	2003/12/19	再生終了時にリスト登録ファイルが無いと読み込みを試み続けるバグ、メイン画面にリストが無いスキンの時リスト画面のリストで[Delete]キーを押すとリストが全消去されるバグを修正。mp3infp使用時に読み込むMP3のタグの優先順位を変更。スクリプト仕様修正＆拡張。
          (04)	2003/12/24	スキン変更時にチップヘルプが表示されなくなる事があるバグを修正、存在しないスキン設定ファイルとスクリプトを読み込もうとした時にプログラムがエラーで終了するバグを修正。エラーが起きても設定を保存してから終了するように改良。
          (05)	2004/01/02	スクリプトからボタンとメニューの機能を呼び出せないバグを修正。
	  (06)	2004/02/07	リスト中のファイル削除を高速化、再生中の音楽ファイルインデックスがリスト編集時にずれるバグを修正、タスクトレイに常にアイコンを表示させられる機能を追加。
	  (07)	2004/02/09	再生リスト上での右クリック時に編集メニューを表示する機能を追加、リスト中のファイル移動を高速化。
	  (08)	2004/02/11	コンボボックス上での右クリックメニューからの選択中ファイル上下移動がうまく出来ないバグを修正。
	  (09)	2004/02/20	リストファイル読み込み前に一旦再生リストを消去する設定を追加、設定項目増加に伴い項目をグループ分け。
	  (10)	2004/03/18	音楽CDを再生出来ないことがあるバグ、情報画面等を開いた後閉じるとメイン画面が更新されなくなるバグ、MCIで再生可能と定義したファイル種以外が読み込まれてしまうバグを修正。全員が読み込むスクリプト(everyone.xs)を定義。
	  (11)	2004/04/26	OggVorbis ファイルを二回連続で再生してしまうバグを修正、ファイルの存在確認ができていなかったバグを修正
	  (12)	2004/05/04	ファイルの存在確認ができていなかったバグを修正
	  (13)	2004/06/18	WindowsXPで初回起動時にエラーが発生するバグを修正
	  (14)	2004/06/24	ファイルの関連付けが上手くいかないバグ、少し長いパスのフォルダを選択時にエラーで落ちるバグを修正。再生中ファイルの入っているフォルダを開く機能を追加
	  (15)	2004/08/06	MCIで開けるファイルの設定が上手く適用されないバグを修正。
          (16)	2004/10/～	再制作開始
   ver.403(α1)	2004/12/19	・モジュールの整理やマクロ化。機能の種類分けなどを見直した。
				・自前デバッグウィンドウの表示。(正式配布時は除去)
				・再生リスト登録可能ファイル数激増。
				・選択中のリスト項目追尾。
	(↓)	設定ファイルフォーマット変更/コンバータ用意
			xstheader.20,21 -> (不使用)
			PF_MCI,DXS,DLL $0,1,2 -> $1000,$2000,$3000
		機能番号変更
			FNC_LOADLIB	 $26000000 -> $27000000
			FNC_SET_PLAYFUNC $26000000 (新番号)
			FNC_USERDEF	 FNC_SCRIPT (新名称)
          (β1)	2004/12/27	・Vox.dll, vbmp3.dll 対応
				・EXEアイコンへのドラッグ＆ドロップに対応
				・プラグイン仕様仮決定
				・一部の機能実行後にプレイヤー画面が操作不能になるバグを修正
          (β2)	2005/01/01	・終了時の再生箇所再現機能付加
				・EXEアイコンへのドラッグ＆ドロップ処理のバグを修正
				・プレイヤーが起動しているとWindowsの終了処理が阻害されるバグを修正
	  (β3)	2005/01/21	・お気に入り編集機能を見かけ上システムに内蔵(プラグインのaxファイル化)
				・単独で選択したファイルがリストに追加されないバグを修正
				・再生に使用する仕組みの情報表示画面追加
				・プラグイン仕様調整
				・その他微調整
	  (β4)	2005/01/31	・スクリプトのバグを修正
					チェックボックス挙動不審
					オブジェクト識別子 popup
				・_func.as を少し整理
				・その他微調整
	  (β5)	2005/09/09	・Midiファイル情報(SMFメタイベント)の取得処理を追加
				・MP3ファイル情報(ID3v1)の取得処理を追加
				・OggVorbis タグ情報の文字化け修正
				・名前順並び替えの高速化
				・スクリプトのバグを修正
					チェックボックス挙動不審
					特殊キー(%～%)があるとき、たまにプログラムが落ちた
					%p.lgtm% %p.lgts% が %p.pos*% と同じ意味になっていた
				・スクリプト仕様書に imgmode 追記
				・スクリプトの仕様を拡張、ボタンにマウスが乗ったり離れたときの処理を追加できるようにした
				・リスト保存時のエラー回避処理追加
				・上記エラー回避処理追加に伴い言語ファイル更新
				・スキン設定ファイルが読み込めないバグを修正
				・デバッグウィンドウで、内部処理から呼び出された機能番号が正しく表示されなかったバグを修正
				・プラグインフォルダ内の実行ファイルとショートカットをプラグインリストに追加するようにした
				・不定形ウィンドウでもタスクバーのタイトル右クリック時にシステムメニューを表示するようにした
				・フォルダ単体でドラッグ＆ドロップされたときリストに追加されないバグを修正
				・その他微調整
				(・DDEによるTMIDI Playerなどの制御に対応 / 取りやめ)

 ・この as ファイルについて

	ラベル一覧
	*main		プレイヤーの待機時の処理
	*exit		プレイヤーの終了ボタンが押された際の処理
	*error		エラーが発生し、終了を余儀なくされた際の処理

 ―――――――――――――――――――――――――――――――――――― */


; ―――――――――――――――――――――――――――――――――――――
; 定義
; ―――――――――――――――――――――――――――――――――――――

	#define	prgname		"arX MusicPlayer"
	#define prgnames	"arXmp"
	#define prgver		"403.00β5(仮)"
	#define prgtitle	prgname+" ver."+prgver+prguser
	#define prgtitles	prgnames+" v."+prgver
	#define helpfile	exedir+"\\readme.txt"
	#define setplayfunc	"setplayfunc.ax"
	#define setplaytype	"setplaytype.ax"
	#define cfgfavorite	"cfgfavorite.ax"
	#const	lprgnames	8	; 3(sep=" - ")+5(prgnames="arXmp")
	#const	vmain		40222	; 403.00β5
	#const	vscript		40219	; 403.00β5
	; β1 40218	チェックボックス、オブジェクト識別子(popup)のバグ修正
	; β5 40219	チェックボックスのバグ修正、imgmode命令追加、イベント処理追加
	#const	vlanguage	40301	; 403.01
	; β5 40301	.Err.onsave 追加
	#include "_init_def.as"
	#include "_init_defex.as"


; ―――――――――――――――――――――――――――――――――――――
; 命令拡張
; ―――――――――――――――――――――――――――――――――――――

	; hsgetmsg
	#uselib "hsgetmsg.dll"
	#func gm_setwndproc	gm_setwndproc	$202
	#func gm_setmessage	gm_setmessage	$202
	#func gm_getmessage	gm_getmessage	$202
	mref bmscr,67
	hwProcess=bmscr.13
	gm_setwndproc hwProcess
	; loadlib
	ll_libload D_GDI,"gdi32"
	ll_libload D_USER,"user32"
	ll_libload D_SHELL,"shell32"
	ll_libload D_KERNEL,"kernel32"
	ll_libload D_COMDLG,"comdlg32"
	ll_libload D_OLE,"ole32"
	ll_retset dllret
	; その他モジュール
	#include "strmod.as"
	#include "_mod.as"


; ―――――――――――――――――――――――――――――――――――――
; (デバッグ用)
; ―――――――――――――――――――――――――――――――――――――

	#ifdef DEBUG
	gsel 0,-1
	; 動作ログ用の準備
	#define addlog(%1) str logline,3 :log=logline+"| "+%1+"\n"+log :gsel widDebug :objprm 0,log :gsel sWid :int logline :logline++ :im=logline\1000=0 :log=log.im
	sdim log,65535,2
	log="\n"
	log+="◇-arX MusicPlayer ver."+prgver+" について\n"
	log+="この版のプレイヤーは完成しているように見える機能にバグが残っていて正しく動作しないことがあります。プレイヤーのバージョンアップを速やかに行うために、バグを発見された方は作者へご報告願います。\n\n"
	log+="　公式サイト:\n　　http://hp.vector.co.jp/authors/VA022483/xmp/\n"
	log+="　メール:\n　　arc@mocha.freemail.ne.jp\n"
	log.1 ="\n"
	log.1+="◇-デバッグウィンドウ(debug window)について\nプレイヤーの動作を確認するためのものです。バグ報告の際は、不具合発生時に最上行付近に表示されていた内容をお知らせ頂けると助かります。内容が1000行に到達する度にクリアされます。\n\n"
	log.1+="　※表示内容凡例\n"
	log.1+="　FNC $[機能番号]([機能名]) -> 返り値\n"
	log.1+="　BTN [ウィンドウ名] (id=[オブジェクトID])\n"
	log.1+="　CNV [変換されたメニューID]\n"
	log.1+="　MSG $[WM_?] -> hwnd,lprm,wprm"
	log+=log.1
	logline=0
	funclv=0
 	dim func_,16
	; ログ表示画面の初期化
	#const widDebug	10
	screen widDebug,320,280,14,dispx-331,5
	mref bmscrd,67
	prm=bmscrd.13,-20
	dllprocp FNC_GetWindowLongA,prm,2
	prmex.2=dllret|$80
	dllprocp FNC_SetWindowLongA,prmex,3
	title "debug window"+sep+prgtitles
	font "ＭＳ ゴシック",12
	objmode 2,1
	mesbox log,winx,winy,0
	gsel widDebug,2
	gsel 0
	#else
	onerror *error
	#endif


; ―――――――――――――――――――――――――――――――――――――
; 変数などの初期化
; ―――――――――――――――――――――――――――――――――――――

	; 汎用変数の初期化
	#const szs	1024
	#const szss	512
	dim prm,37	:getptr pprm,prm
	dim prmex,22	:getptr pprmex,prmex
	dim i :dim ii :dim iii :dim im
	getptr pi,i :getptr pii,ii :getptr piii,iii
	sdim s,szs	:getptr ps,s
	sdim ss,szss	:getptr pss,ss
	sdim sss,1024	:getptr psss,sss
	sdim tmp,bufmax	:getptr ptmp,tmp
	sdim tmp2,bufmax:getptr ptmp2,tmp2
	sdim notedata,bufnd
	; 機能情報用変数の初期化
	dim func,nfunc
	sdim funcopts,bufmax
	getptr pfuncopts,funcopts
	; コマンドラインの変換とプラグイン関連の初期化
	#include "_init_xpi.as"
	; その他の変数の初期化など、色々
	#include "_init_var.as"


; ―――――――――――――――――――――――――――――――――――――
; 設定の読み込み
; ―――――――――――――――――――――――――――――――――――――

	; tmp2	/	コマンドラインから変換された音楽ファイルのリスト

	; 設定ファイルの読み込み
	; (はじめは先頭192バイトのヘッダ情報のみ)
	s=datdir+user+".xst"
	exist_ s
	if stat>0 {
	 bload s,xstheader	,192,0
	 if xstheader!xstgenuine {
	  dialog "設定ファイルが壊れていたため、設定が全て初期化されました。\n\n("+s+")",1,prgtitles
	 } else {
	  ; ヘッダ情報以降を読み込む
	  bload s,tmp,,192
	  memcpy sFileName,tmp	,szsinfo_	:prm=szsinfo_
	  memcpy lCurdir,tmp	,szlinfo_,,prm	:prm+=szlinfo_
	  memcpy types,tmp	,sztypes*TP_PLAYABLE,,prm
	  ; リストと再生情報
	  lSelectedIdx=xstheader.8
	  lSearchType=xstheader.9
	  lDownDblItem=xstheader.10!0
	  lClearOnLoad=xstheader.11!0
	  lMode=xstheader.12
	  mFileIdx=xstheader.13
	  lReplay=xstheader.15!0
	  ; 画面情報と拡張機能
	  dispMainWnd=xstheader.16!0
	  dispTiphelp=xstheader.17!0
	  dispTrayicon=xstheader.18!0
	  dispTaskbar=xstheader.19!0
	  ; その他
	  if xstheader.22 :func=FNC_LOADLIB|FNC_ON+IDX_LOAD_MP3INFP :gosub *exec_func
	  i=24 :repeat TP_PLAYABLE
	   type.cnt=xstheader.i :i++ :loop
	  i=36 :repeat 5
	   mScrollType.cnt=xstheader.i :i++ :loop
	  if setVmain<vmain {
	   dialog "プレイヤーがバージョンアップされました。\n継続的なご利用ありがとうございます。",0,prgtitles
	   setVmain=vmain
	  }
	 }
	}

	; ユーザー用再生リストの読み込み
	s=datdir+user+".xpt"
	exist_ s
	if stat>0 {
	 notesel list
	 noteload s
	 notemax lNum
	}

	; 設定ファイル内容と連動した変数に標準設定値を代入
	; (設定ファイル破損/初回起動時)
	if xstheader!xstgenuine {
	 xstheader=xstgenuine
	 setVmain=vmain
	 MainWndX=dispx-320/2
	 MainWndY=dispy-170/2
	 ListWndX=dispx-640/2
	 ListWndY=dispy-480/2
	 ListWndWidth =640
	 ListWndHeight=480
	}

	; プレイヤー初期化処理フラグ
	; (_script.as 内 "!!!init=xsp" の処理で解除)
	dispMainWnd=dispMainWnd|initializing

	; メニューのファイル一覧更新
	func=FNC_XS_LOAD|FNC_REFRESH	:gosub *exec_func
	func=FNC_XSP_LOAD|FNC_REFRESH	:gosub *exec_func
	func=FNC_XMS_LOAD|FNC_REFRESH	:gosub *exec_func
	func=FNC_XPI_LOAD|FNC_REFRESH	:gosub *exec_func
	func=FNC_XLT_LOAD|FNC_AUTO|FNC_REFRESH	:gosub *exec_func

	; スキン読み込み
	func=FNC_XSP_LOAD|FNC_AUTO :gosub *exec_func

	; ドラッグ&ドロップされたファイルを処理
	strlen i,tmp2
	if i {
	 im=lDownDblItem
	 lDownDblItem=1
	 funcopts=tmp2
	 func=FNC_LIST_ADD|FNC_ON :gosub *exec_func
	 lDownDblItem=im
	 xstheader.14=0
	 func=FNC_PLAY+lNum-1 :gosub *exec_func
	} else {
	 ; 前回終了時の再生箇所を再現
	 if lReplay&(xstheader.14!-1) {
	  ; [Shift] キーでキャンセル
	  getkey i,16
	  if i=0 :func=FNC_PLAY|FNC_AUTO+IDX_CUR :gosub *exec_func
	 }
	}


; ―――――――――――――――――――――――――――――――――――――
; メイン処理
; ―――――――――――――――――――――――――――――――――――――

	onexit *exit
	randomize

*main
	wait 5

; ―――――――――――――――――――――――――――――――――――――
; 0.050*TI_REFRESH秒ごとに画面表示を更新

	if mainloop\TI_REFRESH=0 {
	 ; メイン画面の最小化状態
	 dllproc "IsIconic",hwMainWnd,1,D_USER
	 if dispMainWnd&2!0!dllret {
	  if dllret {
	   mii.1=1 :mii.3=8 :setmii hmOnMain,FNC_MINIMIZE|FNC_AUTO
	   dispMainWnd=dispMainWnd^2
	   gsel sWid,-1
	   if dispTrayicon=0 {
	    ntray hIcon
	    ttray mTasktray,hIcon
	   }
	  }
	 }
	 ; メイン画面の表示
	 if mStatus!ST_CLOSED&(dispMainWnd&2=0)&(scrLine=0) {
	  scrLine+=scrAreaMainLine
	  script=scrAreaMain+script
	 }
	 ; メイン画面タイトルの表示
	 if dispTitle {
	  dispTitle--
	  if dispTitle=0 {
	   if mStatus!ST_CLOSED {
	    title mFileName+sep+prgtitles
	   } else :title prgtitles
	  }
	 }
	 ; リスト画面の大きさ
	 if dispListWnd {
	  gsel widList
	  if ListWndWidth!winx|(ListWndHeight!winy) {
	   ListWndWidth=winx
	   ListWndHeight=winy
	   objresize winx-20,winy-25,5
	   objrepos 5,winy-23,6
	   objrepos 150,winy-23,7
	   objrepos 250,winy-23,8
	   objrepos winx-65,winy-23,9
	  }
	  gsel sWid
	 }
	}

; ―――――――――――――――――――――――――――――――――――――
; 0.050秒ごとに音楽の再生状態変化及びユーザー操作へ反応

	; スクリプト検知→実行
	if scrLine :gosub *exec_script

	func=FNC_GETSTATE :gosub *exec_func
	; 音楽の再生終了
	if mStatus=ST_STOPPED {
	 i=lMode&$F
	 if i=PM_MDR :wait 300
	 repeat
	  if i=PM_NOR|(i=PM_MDR)|(i=PM_RND) {
	   if mFileIdx+1=lNum&(lMode&$F0=0)&(i!PM_RND) {
	    func=FNC_STOP :break
	   }
	   func=FNC_PLAY|FNC_AUTO+IDX_CUR_NEXT :break
	  }
	  if i=PM_STP :func=FNC_STOP :break
	  if i=PM_REP {
	   if mFileType&TPEX_MID!0&(type.TP_MID=PF_DLL) {
	    func=FNC_PLAY|FNC_AUTO+IDX_CUR :break
	   }
	   func=FNC_SEEK :break
	  }
	  if i=PM_REV :func=FNC_PLAY|FNC_AUTO+IDX_CUR_PREV :break
	 loop
	 gosub *exec_func
	 if funcret=FR_ERR :func=FNC_STOP :gosub *exec_func
	}

	*main_
	gm_getmessage msgval		; ウィンドウメッセージ
	#ifdef DEBUG
	if msgval!0&(msgval.1!WM_TASKTRAY)&(msgval.1!WM_LBUTTONDOWN)&(msgval.1=WM_COMMAND&(msgval.3!0)=0) {
	 i=msgval.1 :str i,20
	 addlog "MSG $"+i+" -> "+msgval+","+msgval.2+","+msgval.3
	 int i
	}
	#endif
	getkey i,VK_APPS		; 右クリック機能キー
	stick ii,0,1 :ii=(ii&512!0)	; 右クリック

	; マウスがボタンの上に乗ったか離れた
	if msgval!0&(msgval.1=WM_MOUSEMOVE|(msgval.1=WM_MOUSELEAVE)) {
	 i=41
	 repeat snObj
	  if msgval=bmscr.i {
	   ; cnt	/ オブジェクトID
	   ; i		/ オブジェクトID+41
	   func=$FF
	   if msgval.1=WM_MOUSEMOVE&(obj.cnt.2&hovering=0) :obj.cnt.2+=hovering :gosub track_mouseleave :func=obj.cnt.2&$FF
	   if msgval.1=WM_MOUSELEAVE :obj.cnt.2-=(obj.cnt.2&hovering!0)*hovering :func=obj.cnt.2>>8&$FF
	   if (snAreaUser+IDX_SCRIPT_USER)>func {
	    prm=16,3,bmscr.i,0
	    func+=FNC_SCRIPT
	   } else :func=0
	   break
	  }
	  i++
	 loop
	 if func :gosub *exec_func
	 ; 何個もメッセージが連続で飛んでくることが多いので、リアルタイムに処理する
	 ; (そうしないとひとつのメッセージ処理につき0.050秒かかり動作がもたつく)
	 goto *main_
	}

	if msgval=hwProcess {
	 ; 機能の実行要求
	 if msgval.1=WM_EXECFUNC {
	  func=msgval.2
	  gosub *exec_func
	  if msgval.3 {
	   prm=msgval.3,WM_NOTIFYPI,NP_FUNCRET,funcret
	   dllprocp FNC_SendMessageA,prm,4
	  }
	  i=0 :ii=0
	 }
	 ; タスクトレイへの操作
	 if msgval.1=WM_TASKTRAY {
	  if msgval.3=WM_LBUTTONUP :gosub open_sWid
	  if msgval.3=WM_RBUTTONUP :ii=1 :else :ii=0
	  dllprocp FNC_SetForegroundWindow,hwMainWnd,1
	 }
	}

	; 右クリック
	if i|ii {
	 ginfo 1
	 if (prmx=sWid)|(prmx=widList) {
	  ginfo 2*i	; 画面左上(機能キー) or マウスカーソル(右クリック)
	  prm=prmx,prmy	; 座標を取得
	  dllprocp FNC_WindowFromPoint,prm,2
	  ; (1) リスト上での右クリック時、特殊メニュー表示
	  if dllret=hwList|(dllret=hwListSub)&ii {
	   ; リストボックスではまず擬似クリック
	   ; (マウスカーソル下の項目を選択)
	   if sList=0 {
	    prm=dllret,pprmex
	    dllprocp FNC_GetWindowRect,prm,2
	    prm.1=WM_LBUTTONDOWN,1,prmy-prmex.1<<16+prmx-prmex
	    dllprocp FNC_SendMessageA,prm,4
	    prm.2=WM_LBUTTONUP
	    dllprocp FNC_SendMessageA,prm,4
	   }
	   i=hmOnList
	  ; (2) その他では通常メニュー表示
	  } else :i=hmOnMain
	  pmenu i,prmx,prmy
	  if dllret :func=dllret :gosub *exec_func
	 }
	}

	; 左クリック
	if msgval=hwMainWnd&(msgval.1=WM_LBUTTONDOWN) {
	 ginfo 1
	 if prmx=sWid {
	  ; 再生位置を変更
	  ; if (mStatus=ST_PLAYING)&(sSeekX<=mousex)&(sSeekY<=mousey)&(sSeekWidth>=(mousex-sSeekX))&(sSeekHeight>=(mousey-sSeekY)) {
	  if (mStatus!=ST_STOPPED)&(sSeekX<=mousex)&(sSeekY<=mousey)&(sSeekWidth>=(mousex-sSeekX))&(sSeekHeight>=(mousey-sSeekY)) {
	   if sSeekDirection=0 {
	    mPosition=mDuration*(mousex-sSeekX)/sSeekWidth
	   } else {
	    mPosition=mDuration*(sSeekHeight-(mousey-sSeekY))/sSeekHeight
	   }
	   gosub apply_mPosition
	   gosub wait_mStatus
	  ; 画面位置を移動
	  } else {
	   if (sDragX<=mousex)&(sDragY<=mousey)&(sDragWidth>=(mousex-sDragX))&(sDragHeight>=(mousey-sDragY)) {
	    repeat 1
	     stick i,256
	     i=0 :objsend -28,$A1,2,i,0
	     if i&256 :continue
	     wait 20
	    loop
	   }
	  }
	 }
	}

	; リストへの操作
	if dispListWnd&(msgval=hwListSub)|(msgval=hwList) {
	 ; ダブルクリックまたはEnterキーが押されたら選択されているファイルを再生
	 if (msgval.1=WM_LBUTTONDBLCLK)|((msgval.1=WM_KEYUP)&(msgval.2=VK_RETURN)) {
	  func=FNC_PLAY|FNC_AUTO+IDX_SEL
	  gosub *exec_func
	  ; func=FNC_PAUSE
	  ; gosub *exec_func
	 }
	 ; Deleteキーが押されたら選択されているファイルを削除
	 if (msgval.1=WM_KEYUP)&(msgval.2=VK_DELETE) {
	  func=FNC_LIST_CLEAR|FNC_AUTO+IDX_SEL
	  gosub *exec_func
	 }
	 ; ※その他ショートカットキー登録が可能

	 ; (ここにキー別処理を追加)

	}

	; ドラッグ＆ドロップ
	if msgval!0&(msgval.1=WM_DROPFILES) {
	 ; ファイル数を取得
	 prm=msgval.2,-1,0,0
	 dllprocp FNC_DragQueryFileA,prm,4
	 i=dllret
	 ; ファイル名を取得
	 funcopts=""
	 prm.2=ps,512
	 repeat i
	  if cnt :funcopts+="\n"
	  prm.1=cnt
	  dllprocp FNC_DragQueryFileA,prm,4
	  funcopts+=s
	 loop
	 dllprocp FNC_DragFinish,prm,1
	 repeat
	  if i=1 {
	   gettype funcopts
	   if stat&TPEX_XLT {
	    func=FNC_XLT_LOAD|FNC_STR :gosub *exec_func
	    break
	   }
	   if stat&TPEX_XSS {
	    func=FNC_XSS_LOAD|FNC_STR :gosub *exec_func
	    break
	   }
	   if stat&TPEX_ALL=0 {
	    if stat&TPEX_IMG {
	     repeat snVar
	      if sVar_type.cnt=SV_IMAGE {
	       func=FNC_XSP_MODIFY|FNC_STR+cnt :gosub *exec_func
	       break
	      }
	     loop
	     break
	    }
	    break
	   }
	  }
	  funcopts+="\n"
	  func=FNC_LIST_ADD|FNC_ON :gosub *exec_func
	  func=FNC_LIST_REFRESH :gosub *exec_func
	  break
	 loop
	}

	; チェック内容の変更検知→変更適用
	repeat snChk
	 if chk.cnt!chk_.cnt {
	  i=chkid.cnt :func=obj.i :gosub *exec_func
	  chk_.cnt=chk.cnt
	 }
	loop

	; メニューのクリック→機能実行
	if msgval!0&(msgval.1=WM_COMMAND)&(msgval.3=0) {
	 func=msgval.2 :gosub *exec_func
	}

	mainloop=mainloop+1\$FFFFFFF
	msgval=0,0,0,0
	goto *main


; ―――――――――――――――――――――――――――――――――――――
; 終了処理
; ―――――――――――――――――――――――――――――――――――――

*exit
	; ユーザーが×ボタンを押した or [Alt]+[F4]
	if iparam=0 {
	 ginfo 1
	 #ifdef DEBUG
	 i=prmx!widDebug&(prmx!32)&(prmx!sWid)
	 #endif
	 #ifndef DEBUG
	 i=prmx!sWid
	 #endif
	 ; メイン画面以外が閉じられた
	 if i {
	  if prmx=widInfo&(dispInfoWnd&IDX_WND_INPUT!0) {
	   funcopts=""
	   #ifdef DEBUG
	   funclv--
	   #endif
	   func=FNC_OPEN_WND|FNC_OFF+widInfo :goto *exec_func
	  }
	  func=FNC_OPEN_WND|FNC_OFF+prmx
	  gosub *exec_func
	  goto *main
	 }
	}
	; 情報の保存
	;  (1) 再生リスト
	notesel list
	notesave datdir+user+".xpt"
	;  (2) その他情報
	;	情報を整理
	if dispMainWnd&2=0 {
	 ginfo 2
	 MainWndX=prmx :MainWndY=prmy
	}
	xstheader.8 =lSelectedIdx,lSearchType,lDownDblItem,lClearOnLoad,lMode,mFileIdx,mPosition,lReplay
	if mStatus=ST_CLOSED :xstheader.14=-1
	xstheader.16=dispMainWnd,dispTiphelp,dispTrayicon,dispTaskbar,0,0,D_MP3INFP!0
	i=24
	repeat TP_PLAYABLE :xstheader.i=type.cnt :i++ :loop
	i=36
	repeat 5 :xstheader.i=mScrollType.cnt :i++ :loop
	;	情報を一つの変数にまとめる
	prm=nxstheader*4
	memcpy tmp,xstheader	,prm
	memcpy tmp,sFileName	,szsinfo_,prm	:prm+=szsinfo_
	memcpy tmp,lCurdir	,szlinfo_,prm	:prm+=szlinfo_
	memcpy tmp,types	,sztypes*TP_PLAYABLE,prm :prm+=sztypes*TP_PLAYABLE
	;	最後にファイルに保存する
	s=datdir+user+".xst"
	exist_ s
	if stat=1 :delete s
	bsave s,tmp,prm
	dispMainWnd=dispMainWnd|closing
	; 再生中の音楽を停止
	if mStatus!ST_CLOSED :func=FNC_STOP :gosub *exec_func
	; タスクトレイアイコンの消去
	if dispMainWnd&2|dispTrayicon :ctray
	; 登録されたプラグインに終了メッセージ送信
	prm.1=WM_CLOSE,0,0
	repeat szfmo_send/4,fi_send_onexit/4
	 ll_peek4 prm,cnt*4+pfmo_info
	 if prm :dllprocp FNC_SendMessageA,prm,4
	loop
	; プラグイン向け公開情報の更新
	ll_poke4 0,pfmo_info
	prm=hfmo_info,2,0,0,0
	dllprocp FNC_UnmapViewOfFile,prm,5
	; COM 他、各種 DLL ハンドルの解放
	if dde_inst :func=FNC_LOADLIB|FNC_OFF+IDX_LOAD_DDE :gosub *exec_func
	if pCallMethod :dllproc "CoUninitialize",prm,0,D_OLE
	if D_VBMP3 :dllprocp FNC_vbmp3_free,prm,0
	repeat nD
	 if D.cnt!0 :ll_libfree D.cnt
	loop
	; メニューハンドルの解放
	repeat nhmenu
	 if hmenu.cnt :dllprocp FNC_DestroyMenu,hmenu.cnt,1
	loop
	; その他ハンドルの解放
	if hIcon!0 :dllproc "DestroyIcon",hIcon,1,D_USER
	dllprocp FNC_CloseHandle,hfmo_info,1
	end

*error
	dialog "エラーが発生したためプレイヤーが強制終了されます。\n\n　エラー番号= "+wparam+"\n　エラー発生位置= "+lparam,1,prgtitles
	end


; ―――――――――――――――――――――――――――――――――――――
; 他のスクリプトと結合
; ―――――――――――――――――――――――――――――――――――――

	#include "_func.as"
	#include "_script.as"
	#include "_sub.as"


; ―――――――――――――――――――――――――――――――――――――
;                                                              (c) arc@arcis
