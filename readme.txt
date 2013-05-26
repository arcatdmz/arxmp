
 ◇ arX MusicPlayer
 ―――――――――――――――――――――――――――――――――――――
 ver.403.00β5(仮) - 2006/10/18版


 □ はじめに

　この版のプレイヤーは ver.403.00 正式公開前の準備段階としてユーザーの方に
　人柱になって開発に協力して頂く意味もあって(^^;公開しているものであり、完
　成しているように見える機能にバグが残っていて正しく動作しないことがありま
　すので、特に初めて arX MusicPlayer をお使いになる方などは、 動作の安定性
　がある程度保証されている ver.402.15 をご利用ください。
　なお、どの版をお使い頂く場合でも、使用した結果起きるあらゆる事態に対して
　著作者である arc@dmz が一切の責任を負わないことを了承してください。

 □ ver.403.00 正式公開前の更新履歴

　06/10/18 β4.1→β5(仮)

	※密かに公開しているため、バージョン番号に仮を付しています。

	　初めから添付されているスキンには arc@dmz が作成していないものも
	　含まれており、それらの使用条件は 各スキン作者の定めるところによ
	　ることとします。
	　詳しくは各スキンに付属の readme ファイルをお読みください。

	・Midiファイル情報(SMFメタイベント)の取得処理を追加
	・MP3ファイル情報(ID3v1)の取得処理を追加
	・OggVorbis タグ情報の文字化け修正
	・名前順並び替えの高速化
	・リスト保存時のエラー回避処理追加
	・上記エラー回避処理追加に伴い言語ファイル更新
	・プラグインフォルダ内の実行ファイルとショートカットをプラグインリストに追加するようにした
	・不定形ウィンドウでもタスクバーのタイトル右クリック時にシステムメニューを表示するようにした
	・その他、バグ修正と微調整

　05/01/31 β4→β4.1

	・「再生に使用する仕組みの変更」(setplayfunc.ax)新版を添付
	　β4には誤って使えない古い版を添付していました(^^;

　05/01/31 β3→β4

	・スクリプト(スキンの表示などに使う機能)のバグを修正
	・「Windows UI」(スキン)を標準添付
	・その他微調整

　05/01/23 β2→β3

	・プラグインとして提供されていたお気に入り編集機能をプレイヤー本体に内蔵
	・単独で選択したファイルが再生リストに追加されないバグを修正
	・再生に使用する仕組みについての情報表示画面を追加
	・その他微調整

　05/01/01 β1→β2

	・終了時の再生箇所再現機能付加
	・EXEアイコンへのドラッグ＆ドロップ処理のバグを修正
	・プレイヤーが起動しているとWindowsの終了処理が阻害されるバグを修正

　04/12/27 α1→β1

	・Vox.dll, vbmp3.dll に対応(設定画面の整備)
	・Vox.dll ver.0.60 → ver.0.61 に差し替え
	　(ファイルサイズが二倍近くに膨れ上がってる...(T-T)
	・EXEアイコンへのファイルのドラッグ＆ドロップに対応
	・一部の機能実行後にプレイヤー画面が操作不能になるバグを修正

 □ 前版(ver.402.15)との比較

　操作方法や機能は、右クリックメニュー以外はほぼ全て ver.402.15 を踏襲して
　います。それらについては前版のヘルプファイルを参照下さい。

　変更点、改善点は主に以下のとおりです。

	・再生リスト登録可能ファイル数激増
	・再生リストの表示処理が一部高速化
	・Windows XP SP2のメモリ保護機能(DEP)に対応
	・起動時に、前回終了時の再生箇所を再現する機能を付加(β2～) 
	・選択中、再生中のリスト項目情報を比較的シツコク保持
	　　→	スキンを変えたりリストを編集した際に、
		選択中の項目が変わってしまうことが少なくなりました。
	・DirectX 8.0以降の DirectShow を利用した音楽再生に対応
	　　→　MCI, DirectShow(CD Audio以外), 外部DLL(MP3,OggVorbisのみ)
		の中から再生手段を選べるようになりました。
	・右クリックメニュー再構成
	・色々見直したので全体的に動作が軽くなった…かも？

　β版ゆえの制限事項は以下のとおりです。

	・ちゃんとしたヘルプファイルが無い

　右クリックメニューについては以下に一覧を示しておきます。
　項目名の後ろに書いてある FNC… は、気にしないで下さい(^^;;

	(右クリックメニュー)
	 ├ 音楽の情報	(&I)
	 │　├ 著作者 - mAuthor		FNC_CLIP+IDX_CLIP_MINFO+1
	 │　├ タイトル - mName		FNC_CLIP+IDX_CLIP_MINFO+2
	 │　├ ファイル名 - mFileName		FNC_CLIP+IDX_CLIP_MINFO+0
	 │　├ その他の情報をコピー	
	 │　│　├ フルパス			FNC_CLIP+IDX_CLIP_MINFO+4
	 │　│　├ アルバムのタイトル		FNC_CLIP+IDX_CLIP_MINFO+5
	 │　│　├ 発売日			FNC_CLIP+IDX_CLIP_MINFO+6
	 │　│　├ コメント			FNC_CLIP+IDX_CLIP_MINFO+3
	 │　│　└ 音楽ファイルの種類		FNC_CLIP+IDX_CLIP_MINFO+7
	 │　├ ────────
	 │　├ プロパティを表示		FNC_OPEN_PROPERTY|FNC_AUTO+IDX_CUR
	 │　├ 親フォルダを開く		FNC_OPEN_PARENTDIR|FNC_AUTO+IDX_CUR
[*]	 │　├ 情報画面を開く			FNC_OPEN_WND+widInfo
└┬再生している音楽のタイトルなどを確認できます。
　└また、メイン画面で右から左に流れる音楽情報の種類を変更できます。(対応スキンのみ)
[*]	 │　└ 再生に使用している仕組み
│	 │　　　└ [仕組み一覧,idx]		FNC_OPEN_WND+widExt+idx
└┬再生に使用している仕組みが表示されます。
　└DirectShowを使用しているときはフィルタ一覧が表示されます。
	 ├ 音楽の再生	(&P)
	 │　├ 次のファイル			FNC_PLAY|FNC_AUTO+IDX_CUR_NEXT
	 │　├ 前のファイル			FNC_PLAY|FNC_AUTO+IDX_CUR_PREV
	 │　├ ────────
	 │　├ 一時停止/再開			FNC_PAUSE
	 │　├ 再生停止			FNC_STOP
	 │　└ 選択中のファイルを再生		FNC_PLAY|FNC_AUTO+IDX_SEL
	 ├ 再生モード	(&M)
	 │　├ NOR(ノーマル)			FNC_MODE|FNC_ON+PM_NOR
	 │　├ REV(リバース)			FNC_MODE|FNC_ON+PM_REV
	 │　├ RND(ランダム)			FNC_MODE|FNC_ON+PM_RND
	 │　├ REP(リピート)			FNC_MODE|FNC_ON+PM_REP
	 │　├ STP(ストップ)			FNC_MODE|FNC_ON+PM_STP
	 │　└ MDR(レコード)			FNC_MODE|FNC_ON+PM_MDR
	 ├ 再生リスト	(&L)
	 │　├ お気に入り
	 │　│　├ 現在の再生リストを...
	 │　│　│　├ 新規登録		FNCM_XLT_SAVEEX
	 │　│　│　├ ────────
	 │　│　│　└ 上書き保存
	 │　│　│　　　└ [お気に入りリスト,idx] FNCM_XLT_SAVE+idx
	 │　│　├ ────────
	 │　│　├ [お気に入りリスト,idx]	FNCM_XLT_LOAD+idx
	 │　│　├ ────────
	 │　│　└ 一覧更新			FNCM_XLT_LOADEX
	 │　├ ファイルを追加			FNC_OBJ402+objList_AddFile
	 │　├ フォルダを追加			FNC_OBJ402+objList_AddFolder
	 │　├ 名前順並び替え			FNC_OBJ402+objList_Sort
	 │　├ 全ファイル存在確認		FNC_OBJ402+objList_CheckAll
	 │　├ ────────
[*]	 │　└ リスト画面を開く/閉じる		FNC_OBJ402+objWindow_OpenList
└─リスト画面が開いたり閉じたりします。大きな画面で快適に再生リストを編集できます。
	 ├ ────────
	 ├ スキン	(&S)
	 │　├ [変更先,idx]			FNC_XSP_LOAD+idx
	 │　├ ────────
	 │　├ 一覧更新			FNC_XSP_LOAD|FNC_REFRESH
	 │　├ 現在のスキンの情報
	 │　│　├ 著作者 - sAuthor		FNC_CLIP+IDX_CLIP_SINFO+1
	 │　│　├ タイトル - sName		FNC_CLIP+IDX_CLIP_SINFO+2
	 │　│　├ コメント - sComment		FNC_CLIP+IDX_CLIP_SINFO+3
[*]	 │　│　└ 言語ファイル - sLanguage
│	 │　│　　　├	[言語ファイル一覧,idx]	FNC_XMS_LOAD+idx
│	 │　│　　　├ ────────
│	 │　│　　　└ 一覧更新		FNC_XMS_LOAD|FNC_REFRESH
└┬言語ファイルが、厳密にスキンごとに決定されるようになりました。
　└選択した言語ファイルの情報はスキンを変えるまでの間だけ保持されます。
	 │　├ ────────
	 │　└ 現在のスキンを編集
	 │　　　├ [編集項目,idx]		FNC_XSP_MODIFY+idx
	 │　　　├ ────────
	 │　　　├ ファイルから設定を読み込む	FNC_XSS_LOAD
	 │　　　├ 現在の設定をファイルに保存する FNC_XSS_SAVE
	 │　　　└ 初めの設定に戻す		FNC_XSP_MODIFY|FNC_OFF
	 ├ プラグイン	(&P)
	 │　├ [プラグイン一覧,idx]		FNC_XPI_LOAD+idx
	 │　├ ────────
	 │　└ 一覧更新			FNC_XPI_LOAD|FNC_REFRESH
	 ├ スクリプト	(&X)
	 │　├ [スクリプト一覧,idx]		FNC_XS_LOAD|FNC_AUTO+idx
	 │　├ ────────
	 │　├ 一覧更新			FNC_XS_LOAD|FNC_REFRESH
	 │　└ 一覧以外のスクリプトを実行	FNC_XS_LOAD
	 ├ 設定	(&C)
	 │　├ 再生リスト登録対象
	 │　│　├ MPEG Audio			FNCM_SET_SEARCH+TP_MP3
	 │　│　├ WindowsMediaAudio		FNCM_SET_SEARCH+TP_WMA
	 │　│　├ Midi			FNCM_SET_SEARCH+TP_MID
	 │　│　├ Wave			FNCM_SET_SEARCH+TP_WAV
	 │　│　├ OggVorbis			FNCM_SET_SEARCH+TP_OGG
	 │　│　├ CD Audio			FNCM_SET_SEARCH+TP_CDA
	 │　│　├ (上記以外の)MCIで再生できるファイル FNCM_SET_SEARCH+TP_MCI
	 │　│　├ (〃)DirectShowで再生できるファイル FNCM_SET_SEARCH+TP_DXS
	 │　│　├ ────────
[*]	 │　│　├ サブフォルダの中身		FNCM_SET_SEARCH+TP_DIR
└┬前版では [リスト編集] > [サブフォルダまで検索] という項目で表示されていました。
　└初期設定スキンでは、メイン画面のリスト領域にあるチェックボックスと連動します。
	 │　│　├ リストファイルの中身	FNCM_SET_SEARCH+TP_XLT
	 │　│　├ ────────
	 │　│　└ 全てにチェックを付ける/外す FNCM_SET_SEARCHEX
	 │　├ リスト編集
	 │　│　├ 重複ファイルは最下行に移動	FNCM_SET+IDX_SET_LIST_DOWNDBLITEM
	 │　│　└ リストファイルは新しい再生リストに読込 FNCM_SET+IDX_SET_LIST_CLEARONLOAD
	 │　├ 画面設定
	 │　│　├ ボタンなどにチップヘルプを表示	FNCM_SET+IDX_SET_DISP_TIPHELP
	 │　│　├ メイン画面を常に最前面に表示	FNCM_SET+IDX_SET_DISP_ONTOP
	 │　│　├ タスクトレイに常にアイコンを表示	FNCM_SET+IDX_SET_DISP_TRAYICON
[*]	 │　│　└ (メイン画面不定形時)タスクバーにタイトルを表示 FNCM_SET+IDX_SET_DISP_ONTOP
└─スカイブルー、ユフィ◆スキンなどで有効な設定です。
	 │　└ 音楽再生
	 │　　　├ 音楽情報の取得に mp3infp.dll を使用	FNCM_LOADLIB+IDX_LOAD_MP3INFP
	 │　　　├ 再生リストを繰り返し再生		FNC_OBJ402+objList_ChangeListLoop
[*]	 │　　　├ 起動時に前回終了時の再生箇所を再現	FNCM_SET+IDX_SET_PLAY_REPLAY
└―設定を一時的にオフにしたいときは、[Shift] キーを押しっぱなしにしてプレイヤーを起動してください。
	 │　　　├ ────────
[*]	 │　　　├ 再生に使用する仕組みの変更		FNCM_XPI_LOAD+IDX_XPI_SETPLAYFUNC
[*]	 │　　　└ 再生できるファイル種の変更		FNCM_XPI_LOAD+IDX_XPI_SETPLAYTYPE
└―設定画面が開きます。
	 ├ ────────
	 ├ 最小化	(&Z)			FNC_MINIMIZE|FNC_AUTO
	 ├ 音量の調整	(&V)			FNC_XPI_LOAD|FNC_AUTO+IDX_XPI_VOLUME
	 ├ ヘルプの表示(&H)			FNC_XPI_LOAD|FNC_AUTO+IDX_XPI_HELP
	 └ プレイヤーの終了(&E)		FNC_OPEN_WND+widMain

	(右クリックメニュー - 再生リスト上)
	 ├ 選択項目
	 │　├ 一つ上へ移動			FNC_LIST_UP|FNC_AUTO+IDX_SEL
	 │　├ 一つ下へ移動			FNC_LIST_DOWN|FNC_AUTO+IDX_SEL
	 │　├ 項目の削除			FNC_LIST_CLEAR|FNC_AUTO+IDX_SEL
	 │　├ ごみ箱に捨てる			FNC_LIST_DELETE|FNC_AUTO+IDX_SEL
	 │　├ 名前を変更			FNC_LIST_RENAME|FNC_AUTO+IDX_SEL
	 │　├ ────────
	 │　├ 再生				FNC_PLAY|FNC_AUTO+IDX_SEL
	 │　├ プロパティを表示		FNC_OPEN_PROPERTY|FNC_AUTO+IDX_SEL
	 │　└ 親フォルダを開く		FNC_OPEN_PARENTDIR|FNC_AUTO+IDX_SEL
	 ├ お気に入り
	 │　├ 現在の再生リストを...
	 │　│　├ 新規登録			FNC_XLT_SAVE|FNC_AUTO|FNC_ON
	 │　│　├ ────────
	 │　│　└ 上書き保存
	 │　│　　　└ [お気に入りリスト,idx]	FNC_XLT_SAVE|FNC_AUTO+idx
	 │　├ ────────
	 │　├ [お気に入りリスト,idx]		FNC_XLT_LOAD|FNC_AUTO+idx
	 │　├ ────────
	 │　└ 一覧更新			FNC_XLT_LOAD|FNC_AUTO|FNC_REFRESH
	 ├ ファイルを追加			FNC_LIST_ADD_FILE
	 ├ フォルダを追加			FNC_LIST_ADD_FOLDER
	 ├ 名前順並び替え			FNC_LIST_SORT|FNC_ALL
	 ├ 全ファイル存在確認			FNC_LIST_CHECK|FNC_ALL
	 ├ 設定 - リスト編集			(右クリックメニュー) 同名項目参照
	 └ 設定 - 再生リストの登録対象		(右クリックメニュー) 同名項目参照

　[*] … 前版からの大きな変更点


 □ プラグインについて(プラグイン製作者の方へ)

　プレイヤーの版が新しくなるにつれ激しく仕様変更を繰り返してきたプラグインですが、
　ver.403.00 も以前とは内部処理が全く異なるものとなりました。
　と言っても arc@dmz 以外の誰かがプラグインを開発しているという話を
　未だ聞いたことが無いので影響は薄いかもしれませんが…。
　(スキンは結構多くの方が作成して下さっているようで、嬉しい限りです(^-^)

　仕様書などはまだ作成できていません。公開までしばらくお待ちください。


 □ スクリプトについて(スキン製作者の方へ)

　ver.403.00α1以降のスクリプトは、以前と大枠では互換性を保ちながら
　いくつかの新機能をサポートしています。
　ただし、使用できなくなった古い命令もあります。

　詳細は、公式サイト内開発者用ページの仕様書をご覧ください。


 ―――――――――――――――――――――――――――――――――――――
 (c) arc@dmz
 arX MusicPlayer 公式サイト - http://digitalmuseum.jp/arxmp/
