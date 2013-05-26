
; ■ arX MusicPlayer に関する定義				_init_def.as
; ―――――――――――――――――――――――――――――――――――――

/* 制作メモ ――――――――――――――――――――――――――――――――

 ・この as ファイルについて

	プラグインと共通の定義情報 05/03/15版

 ―――――――――――――――――――――――――――――――――――― */

	#const X_DEF		1

; ―――――――――――――――――――――――――――――――――――――
; 1. 機能番号
; ―――――――――――――――――――――――――――――――――――――

	; 機能番号
	;  画面関連
	#const FNC_OPEN_WND		$01000000
	#const FNC_OPEN_LISTAREA	$02000000
	#const FNC_OPEN_PROPERTY	$03000000
	#const FNC_OPEN_PARENTDIR	$04000000
	#const FNC_MINIMIZE		$05000000
	#const FNC_POPUP		$06000000
	;  音楽再生
	#const FNC_PLAY			$07000000
	#const FNC_PAUSE		$08000000
	#const FNC_STOP			$09000000
	#const FNC_MODE			$0A000000
	#const FNC_VOLUME		$0B000000
	#const FNC_SEEK			$0C000000
	#const FNC_GETTAGINFO		$0D000000
	#const FNC_GETSTATE		$0E000000
	;  リスト編集
	#const FNC_LIST_REFRESH		$0F000000
	#const FNC_LIST_ADD		$10000000
	#const FNC_LIST_ADD_FILE	$11000000
	#const FNC_LIST_ADD_FOLDER	$12000000
	#const FNC_LIST_SORT		$13000000
	#const FNC_LIST_CHECK		$14000000
	#const FNC_LIST_CLEAR		$15000000
	#const FNC_LIST_DELETE		$16000000
	#const FNC_LIST_RENAME		$17000000
	#const FNC_LIST_UP		$18000000
	#const FNC_LIST_DOWN		$19000000
	#const FNC_XLT_LOAD		$1A000000
	#const FNC_XLT_SAVE		$1B000000
	;  スキン
	#const FNC_XSP_MODIFY		$1C000000
	#const FNC_XSP_LOAD		$1D000000
	#const FNC_XSS_LOAD		$1E000000
	#const FNC_XSS_SAVE		$1F000000
	#const FNC_XMS_LOAD		$20000000
	;  プラグイン
	#const FNC_XPI_LOAD		$21000000
	#const FNC_XS_LOAD		$22000000
	;  その他
	#const FNC_CLIP			$23000000
	#const FNC_SET			$24000000
	#const FNC_SET_SEARCH		$25000000
	#const FNC_SET_PLAYFUNC		$26000000
	#const FNC_LOADLIB		$27000000
	#const FNC_SCRIPT		$30000000

	;  ボタン以外のオブジェクト
	#const FNC_PLAYLIST		$E0000000
	#const FNC_PLAYLISTC		$E1000000


; ―――――――――――――――――――――――――――――――――――――
; 2. 機能オプション
; ―――――――――――――――――――――――――――――――――――――

	#const OBJ_CHKBOX	$00020000	; オブジェクトとして設置される時チェックボックスにする
	#const FNC_STR		$00040000	; 文字列オプションを含む
	#const FNC_ALL		$00100000	; 全ての項目
	#const FNC_AUTO		$00080000	; 機能自動判別
	#const FNC_ON		$00200000	; ON
	#const FNC_OFF		$00400000	; OFF
	#const FNC_CHANGE	$00680000	; FNC_ON, FNC_OFF, FNC_AUTO の和
						; (設定変更の有無判別用)
	#const FNC_REFRESH	$00800000	; 一覧更新
	#const IDX_SEL		0	; |FNC_AUTO+..	→ 選択されている項目を..
	#const IDX_CUR		1	; |   〃   +..	→ 再生されている項目〃
	#const IDX_CUR_NEXT	2	; |   〃   +..	→ 再生されている項目の次〃
	#const IDX_CUR_PREV	3	; |   〃   +..	→ 再生されている項目の前〃
	#const IDX_CLIP_MINFO	0	; +FNC_CLIP	→ 音楽情報をクリップボードにコピー
	#const IDX_CLIP_SINFO	16	; +     〃	→ 音楽情報をクリップボードにコピー
	#const IDX_XPI_HELP	1	; +FNC_XPI_LOAD	→ ヘルプ表示
	#const IDX_XPI_VOLUME	2	; +     〃	→ Windowsの音量調整
	#const IDX_XPI_SETPLAYFUNC 3	; +     〃	→ デコーダ選択
	#const IDX_XPI_SETPLAYTYPE 4	; +     〃	→ 再生可能種選択
	#const IDX_XPI_CFGFAVORITE 5	; +     〃	→ お気に入り編集
	#const IDX_LOAD_COM	0	; +FNC_LOADLIB	→ COM の初期化
	#const IDX_LOAD_DXS	1	; +     〃	→ DirectShow の初期化
	#const IDX_LOAD_VOX	2	; +     〃	→ vox.dll を使用
	#const IDX_LOAD_VBMP3	3	; +     〃	→ vbmp3.dll を使用
	#const IDX_LOAD_MP3INFP	4	; +     〃	→ mp3infp.dll を使用
	;#const IDX_LOAD_DDE	5	; +     〃	→ DDE の初期化
	#const IDX_SCRIPT_USER	16	; +FNC_SCRIPT	→ ユーザー定義エリアのスクリプトを実行
	#const IDX_WND_MINFO	$0000	; +FNC_OPEN_WND → 曲情報
	#const IDX_WND_RENAME	$0100	; +     〃      → ファイル名変更
	#const IDX_WND_FAVORITE	$0200	; +     〃      → お気に入り名入力
	#const IDX_WND_SKV	$0400	; +   〃 + SV_* → スキン変数編集画面
	#const IDX_WND_INPUT	$0700	; RENAME, FAVORITE, SKVの和
					; (情報画面表示内容判別用)
	#const IDX_SET_LIST_CLEARONLOAD	16; +FNC_SET	→ 設定値変更
	#const IDX_SET_LIST_DOWNDBLITEM	17; +  〃
	#const IDX_SET_DISP_ONTOP	32; +  〃
	#const IDX_SET_DISP_TIPHELP	33; +  〃
	#const IDX_SET_DISP_TRAYICON	34; +  〃
	#const IDX_SET_DISP_TASKBAR	35; +  〃
	#const IDX_SET_PLAY_REPLAY	48; +  〃


; ―――――――――――――――――――――――――――――――――――――
; 3. その他の設定値
; ―――――――――――――――――――――――――――――――――――――

	; プレイヤーのウィンドウID
	#const widMain		0	; メイン画面
	#const widRegion	3	; メイン画面(枠無し/不定形)
	#const widBuffer	4	; スキン用バッファ
	#const widInfo		5	; 多目的画面
	#const widList		6	; リスト画面
	#const widExt		16	; 再生に使用する仕組み表示画面

	; 再生モード値
	#const PM_NOR		0	; 通常再生
	#const PM_REV		1	; 逆順再生
	#const PM_RND		2	; ランダム再生
	#const PM_REP		3	; リピート再生
	#const PM_STP		4	; 一曲で停止
	#const PM_MDR		5	; 曲間空白再生
	#const PM_REPLIST	16	; 再生リストを繰り返し再生

	; 再生状態値
	#const ST_CLOSED	0	; 停止
	#const ST_STOPPED	1	; 再生終了
	#const ST_PLAYING	2	; 再生中
	#const ST_PAUSED	3	; 一時停止中

	; 音楽の種類値など
	#const global TP_PLAYABLE 8	; 初期状態での再生可能種数
	#const global TP_MP3	0	; MP3
	#const global TP_WMA	1	; WMA
	#const global TP_MID	2	; MIDI
	#const global TP_WAV	3	; WAVE
	#const global TP_OGG	4	; OggVorbis
	#const global TP_CDA	5	; CD-Audio
	#const global TP_MCI	6	; MCI で再生できる音楽ファイル
	#const global TP_DXS	7	; DirectShow で再生できる音楽ファイル
	#const global TP_DIR	12	; ディレクトリ
	#const global TP_XLT	13	; リストファイル
	#const global TP_OTH	-1	; 他
	#const global TPEX_MP3	$000001
	#const global TPEX_WMA	$000002
	#const global TPEX_MID	$000004
	#const global TPEX_WAV	$000008
	#const global TPEX_OGG	$000010
	#const global TPEX_CDA	$000020
	#const global TPEX_DEF	$00003F	; 以上の合計
	#const global TPEX_MCI	$000040
	#const global TPEX_DXS	$000080
	#const global TPEX_DIR	$001000	; ディレクトリ
	#const global TPEX_XLT	$002000	; リストファイル
	#const global TPEX_ALL	$0030FF	; 以上の合計
	#const global TPEX_XSP	$010000	; スキン
	#const global TPEX_XPI	$020000	; プラグイン
	#const global TPEX_XMS	$040000	; 言語ファイル
	#const global TPEX_XSS	$080000	; スキン設定ファイル
	#const global TPEX_XS	$100000	; スクリプトファイル
	#const global TPEX_ARC	$200000	; 書庫ファイル
	#const global TPEX_IMG	$400000	; 画像ファイル
	#const global TPEX_EXE	$800000	; 実行ファイル

	; 再生手法値
	#const PF_MCI		$1000	; MCI で再生
	#const PF_DXS		$2000	; DirectShow で再生
	#const PF_DLL		$3000	; その他の特殊な DLL を用いて再生


; ―――――――――――――――――――――――――――――――――――――
;                                                              (c) arc@arcis
