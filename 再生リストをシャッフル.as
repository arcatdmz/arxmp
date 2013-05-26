
;title "再生リストをシャッフル"
; ―――――――――――――――――――――――――――――――――――――

/* 制作メモ ――――――――――――――――――――――――――――――――

 ・この as ファイルについて

	再生リストをシャッフルします。

 ―――――――――――――――――――――――――――――――――――― */

	#include "_init_def.as"
	#include "_mod_xpi.as"

	xpi_connect
	if stat=0 :end

	; 一時ファイルの名前を決定
	sdim tmpdir,szdir :sdim tmpfile,512
	xpi_peek tmpdir,ai.pdir+(szdir*4),szdir
	tmpfile=tmpdir+"plugin_tmp.xlt"

	; 再生リストの取得
	#const bufmax		65536	; 扱えるデータの最大長(bytes)

	sdim list,bufmax
	xpi_peek list,ai.plist,bufmax
	if list="" {
		; 一時ファイル作成
		i=0
		repeat 1
		 xpi_func FNC_IDLECHK,2
		 if stat=-1 {
		  dialog "プレイヤーが処理を実行中であるため、リストを取得できません。\nダイアログが開いている場合は一旦キャンセルするなどしてから再度 [OK] を押してください。"
		  i++ :continue 0
		 }
		loop
		xpi_opt tmpfile
		xpi_func FNC_XLT_SAVE|FNC_STR
		; 一時ファイル読み込み
		exist tmpfile
		if strsize!-1 {
			if strsize>0 {
				notesel list :noteload tmpfile :notemax i
			}
		; 使用した一時ファイルを削除
		delete tmpfile
		}
	}

	; シャッフル
	sdim s,512
	notesel list
	notemax max
	if max {
		randomize
		repeat max,1
			noteget s,max-1
			notedel max-1
			rnd i,cnt
			noteadd s,i
			await
		loop
		; 再生リストをいったん消去
		xpi_func FNC_LIST_CLEAR|FNC_AUTO|FNC_ALL
		strlen i,list
		if i>bufmax {
			; 一時ファイル作成
			notesave tmpfile
			; 一時ファイルから読み込み
			xpi_opt tmpfile
			xpi_func FNC_XLT_LOAD|FNC_STR
			; 使用した一時ファイルを削除
			delete tmpfile
		} else {
			xpi_poke list,ai.plist,bufmax
		}
		; 再生リストを更新
		xpi_func FNC_LIST_REFRESH|FNC_ON
	}
	stop


; ―――――――――――――――――――――――――――――――――――――
;                                                              (c) arc@arcis
