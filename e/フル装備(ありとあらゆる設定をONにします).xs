
.:: 設定の変更 - FNC_SET

.::		ONにするから FNC_ON $00200000 を足す
.::		(OFFにするなら FNC_OFF $00400000 を足せば良い)

.::		IDX_SET_LIST_CLEARONLOAD
exefunc=%f.$24200010%
.::		IDX_SET_LIST_DOWNDBLITEM
exefunc=%f.$24200011%
.::		IDX_SET_DISP_ONTOP
exefunc=%f.$24200020%
.::		IDX_SET_DISP_TIPHELP
exefunc=%f.$24200021%
.::		IDX_SET_DISP_TRAYICON
exefunc=%f.$24200022%
.::		IDX_SET_DISP_TASKBAR
exefunc=%f.$24200023%

.:: 再生リストの登録対象変更 - FNC_SEARCH

exefunc=%f.$252031FF%

.::		下位四桁は以下の値を適宜組み合わせる;
.::			TPEX_MP3	$00000001
.::			TPEX_WMA	$00000002
.::			TPEX_MID	$00000004
.::			TPEX_WAV	$00000008
.::			TPEX_OGG	$00000010
.::			TPEX_CDA	$00000020
.::			(TPEX_DEF	$0000003F - ここまでの合計)
.::			TPEX_MCI	$00000040
.::			TPEX_DXS	$00000080
.::			TPEX_DIR	$00001000 - ディレクトリ
.::			TPEX_XLT	$00002000 - リストファイル
.::			(TPEX_ALL	$000031FF - ここまでの合計)

.:: DLLの読み込み - FNC_LOADLIB

.::		mp3infp.dll
exefunc=%f.$27200004%

.:: 再生モードの変更 - FNC_MODE

exefunc=%f.$0A200010%
