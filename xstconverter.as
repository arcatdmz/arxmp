
; 設定ファイルコンバータ
; ―――――――――――――――――――――――――――――――――――――

; 命令拡張と定義

	#include "strmod.as"

	#const xstgenuine	$74737821
	#const nxstheader	48
	#const szlinfo_		512
	#const szsinfo_		512
	#const sztypes		256
	#const ntypes		8;TP_PLAYABLE

	#const TP_CHECK		6
	#const TP_PLAYABLE	8
	#const TP_MP3		0	; MP3
	#const TP_WMA		1	; WMA
	#const TP_MID		2	; MIDI
	#const TP_WAV		3	; WAVE
	#const TP_OGG		4	; OggVorbis
	#const TP_CDA		5	; CD-Audio
	#const TP_MCI		6	; MCI で再生できる音楽ファイル
	#const TP_DXS		7	; DirectShow で再生できる音楽ファイル

	#const global TPEX_MP3	$00000001
	#const global TPEX_WMA	$00000002
	#const global TPEX_MID	$00000004
	#const global TPEX_WAV	$00000008
	#const global TPEX_OGG	$00000010
	#const global TPEX_CDA	$00000020
	#const global TPEX_DEF	$0000003F; 以上の合計
	#const global TPEX_MCI	$00000040
	#const global TPEX_DXS	$00000080
	#const global TPEX_DIR	$00001000; ディレクトリ
	#const global TPEX_XLT	$00002000; リストファイル

; 変換対象の取得とバッファの初期化

	chdir exedir+"\\d"

	sdim list,1024
	dirlist list,"*.xst",1

	notesel list
	notemax i

	dim xstheader,nxstheader

	sdim data,1024
	sdim s,512
	sdim ss,512
	sdim prms,sztypes,16;ntypes
	sdim tmp,4096

; 変換

	repeat i

	noteget s,cnt
	bload s,xstheader,nxstheader*4,0

; (1) ver.402.xx → ver.403.00β1

	if xstheader!xstgenuine {
	 notesel data
	 noteload s
	 strsel data
	 ; ヘッダ領域
	 xstheader=xstgenuine,40215
	 strget ss,".WindowPosition"	:strgetprm prms,ss :strcnvprm prm,prms,0,2 :xstheader.2=prm,prm.1
	 strget ss,".listWindowPosition":strgetprm prms,ss :strcnvprm prm,prms,0,2 :xstheader.4=prm,prm.1
	 strget ss,".listWindowSize"	:strgetprm prms,ss :strcnvprm prm,prms,0,2 :xstheader.6=prm,prm.1
	 strget i,".ActiveIndex"	:xstheader.8=i!0
	 strget i,".SearchSubdir"	:xstheader.9 =i*TPEX_DIR
	 strget i,".ListExpand"		:xstheader.9+=i*TPEX_XLT
	 strget ss,".SearchType" :strgetprm prms,ss,0
	 repeat TP_CHECK
	  i=prms.cnt :int i :xstheader.9+=1<<cnt*i
	 loop
	 xstheader.9+=TPEX_CDA+TPEX_MCI+TPEX_DXS
	 strget i,".AddMode"		:xstheader.10=i!0
	 strget i,".ListAddMode"	:xstheader.11=i!0
	 strget i,".PlayMode"		:xstheader.12 =i!0
	 strget i,".ListLoop"		:xstheader.12+=i*16
	 xstheader.13=xstheader.8
	 xstheader.14=0
	 strget i,".WindowTopLock"	:xstheader.16=i!0
	 strget i,".TipHelp"		:xstheader.17=i!0
	 strget i,".TrayIcon"		:xstheader.18=i!0
	 xstheader.19=1,0,0
	 strget i,".useInfp"		:xstheader.22=i!0
	 strget i,".useVbMP3"		:xstheader.24=i*$2000+$1000
	 xstheader.25=$2000,$2000,$1000
	 strget i,".useVox"		:xstheader.28=i*$1000+$2000
	 xstheader.29=$1000,$1000,$2000
	 strget ss,".InfoType" :strgetprm prms,ss,0 :strcnvprm prm,prms,0,5
	 i=36 :repeat 5 :xstheader.i=prm.cnt :i++ :loop
	 memcpy tmp,xstheader,nxstheader*4
	 ; 文字列データ領域
	 strget ss,".SkinFile"	:memcpy tmp,ss,szsinfo_,nxstheader*4
	 strget ss,".Current"	:memcpy tmp,ss,szlinfo_,nxstheader*4+szsinfo_
	 prms="MP3 MP2 MP1 RMP","WMA","MID MIDI RMI","WAV WAVE","OGG","CDA","",""
	 strget prms.TP_MCI,".Playable"
	 memcpy tmp,prms,sztypes*TP_PLAYABLE,nxstheader*4+szsinfo_+szlinfo_
	 ; 上書き保存
	 bsave s,tmp,nxstheader*4+szsinfo_+szlinfo_+(sztypes*ntypes)
	 strlen i,s
	 strmid s,s,0,i-4
	 strdelex :notesave s+".xpt"
	 notesel list

; (2) ver.403.00α1 → ver.403.00β1

	} else {
	 if xstheader.1<40218 {
	  ; ヘッダ領域
	  xstheader.20=0,0
	  repeat TP_PLAYABLE,24
	   xstheader.cnt=(xstheader.cnt+1)*$1000
	  loop
	  ; 上書き保存
	  bsave s,xstheader,nxstheader*4,0
	 }
	}

	loop

; 終了処理

	delete exedir+"\\e\\xstconverter.xpi"
	exec exedir+"\\arxmp.exe"
	end


; ―――――――――――――――――――――――――――――――――――――
;                                                              (c) arc@arcis
