
; ■ 文字列操作モジュール                        (strmod ver.1.00)
; ――――――――――――――――――――――――――――――――


; ・このモジュールを使うと、文字列関連の操作を行う命令を使えるよ
; 　うになります。

; ・xpimod (arX MusicPlayer用プラグイン作成モジュール)の補助用に
; 　開発されました。


; ――――――――――――――――――――――――――――――――
; □ strsel target                  文字列操作命令の操作対象を指定
;
;	target	: 文字列型変数
;
;	strmod で操作する対象になる文字列型変数を指定します。
;	以降の命令では、この変数の中身が参照されたり編集されます。
;	(strgetprm, strcnvprm を除く)

; ――――――――――――――――――――――――――――――――
; □ strget data,"key"              操作対象中の指定行の内容を取得
;
;	data	: 行の内容取得先変数
;	"key"	: その行のタイトル
;
;	strsel で指定された文字列型変数の中から
;
;		行のタイトル=行の内容
;
;	という行を探し、存在する場合は data にその内容を返します。
;	例えば、strsel で指定された文字列型変数の中身が
;
;		xspfile=初期設定.xsp
;		xspauth=arc@arcis
;		xsptitl=初期設定
;		...
;		lsttype=normal
;		lstwidt=200
;		lstheig=80
;
;	だった時に
;
;		s="" :strget s,"xsptitl"
;
;	を実行すると、s に "初期設定" という文字列が代入されます。
;	また、i が数値型変数の時
;
;		strget i,"lstwidt"
;
;	を実行すると i に 200 という数値が代入されます。

; ――――――――――――――――――――――――――――――――
; □ strset data,"key"              操作対象中の指定行の内容を設定
;
;	data	: 行の内容を入れてある文字列変数
;	"key"	: その行のタイトル
;
;	strsel で指定された文字列型変数の中から
;
;		行のタイトル=行の内容
;
;	という行を探し、存在する場合はその内容を data で指定された
;	文字列にします。存在しない場合は新たに行を追加します。

; ――――――――――――――――――――――――――――――――
; □ strdel "key"                         操作対象中の指定行を削除
;
;	"key"	: その行のタイトル
;
;	strsel で指定された文字列型変数の中から
;
;		行のタイトル=行の内容
;
;	という行を探し、存在する場合はその行を削除します。

; ――――――――――――――――――――――――――――――――
; □ strdelex                             操作対象中の特殊行を削除
;
;	strsel で指定された文字列型変数の中で * または . で始まる
;	行を全て削除します。

; ――――――――――――――――――――――――――――――――
; □ strgeta data,"key"           操作対象中の指定領域の内容を取得
;
;	data	: 領域の内容取得先文字列変数
;	"key"	: 内容を取得したい領域のタイトル
;
;	strsel で指定された文字列型変数の中で
;
;		*領域名
;		領域の内容
;		*end
;
;	となっている部分を "領域" と呼びます。
;	この命令は、領域名を指定することでその内容を取得できます。
;	実行後、stat には取得された領域の長さが代入されます。

; ――――――――――――――――――――――――――――――――
; □ strseta data,"key"           操作対象中の指定領域の内容を設定
;
;	data	: 領域の内容を入れてある文字列変数
;	"key"	: 内容を設定したい領域のタイトル
;
;	strsel で指定された文字列型変数の中で 指定されたタイトルの
;	領域を探し、存在する場合はその内容を data で指定された文字
;	列にします。存在しない場合は新たに領域を作成します。


; ――――――――――――――――――――――――――――――――
; □ strgetprm var,data,num
;                          *で区切られたパラメータを配列変数に代入
;
;	var	: パラメータ取得先文字列型配列変数
;	data	: パラメータとして取得したい文字列を入れてある変数
;	num	: パラメータの数( 0 で全取得)
;
;	data の中で * で区切られた文字列を、配列変数 var に一つず
;	つ分けて取得します。
;	配列は最低 16 個確保しておかなければなりません。
;	たとえば data の中身が
;
;		abc*def*あいうえお*123*555*なにぬねの
;
;	となっていた時に
;
;		sdim param,64,16
;		strgetprm param,data,6
;
;	を実行すると
;
;	(変数)	|	(内容)
;	param.0	|	abc
;	param.1	|	def
;	param.2	|	あいうえお
;	param.3	|	123
;	param.4	|	555
;	param.5 |	なにぬねの
;
;	となります。
;	ここで param.3/4 は数値ですが文字列として扱われています。
;	それを数値型に変換するために使うのが次の命令です。

; ――――――――――――――――――――――――――――――――
; □ strcnvprm to,from,start,num
;                               文字型配列変数の一部を数値型に変換
;
;	to	: 変換先数値型配列変数
;	from	: 変換元文字列型配列変数
;	start	: 変換開始位置
;	num	: 変換数
;
;	上の strgetprm の例で、最後に
;
;		dim prm,16
;		strcnvprm prm,param,3,2
;
;	を実行すると、param.3/4 が prm.0/1 に代入されて
;
;	(変数)	|	(内容)
;	prm.0	|	123
;	prm.1	|	555
;
;	となります。


#module

; モジュールの初期化
#deffunc strinit
	mref stt,64
	dim sel :dim i :dim ii :dim iii :dim l
	dim prm,16
	sdim s,64
	sel=1 :return

; 文字列操作命令の操作対象を指定
#deffunc strsel val
	mref Target,24
	sel=0 :return

; 操作対象中の指定行の内容を取得
#deffunc strget val,str
	if sel :return
	mref pval_var,1024
	mref p2,33
	sdim p1,512
	p1="" :prm=0 :gosub *strproc
	if (pval_var&$ffff=2) {
	 mref var,24
	} else :mref var,16 :int p1
	var=p1
	sdim p1,64
	return

; 操作対象中の指定行の内容を設定
#deffunc strset val,str
	if sel :return
	mref p1,24
	mref p2,33
	prm=1 :gosub *strproc
	return

; 操作対象中の指定行を削除
#deffunc strdel str
	if sel :return
	p1=""
	mref p2,32
	prm=2 :gosub *strproc
	return

; 操作対象中の特殊行を削除
#deffunc strdelex
	if sel :return
	strlen l,Target
	sdim Target_buf,l+1 :ii=0
	repeat l
	 if ii=0 :i=-2 :else {
	  instr i,Target,"\n",ii
	  if i=-1 :break
	 }
	 ii+=i+2
	 ; 行頭文字取得
	 strmid s,Target,ii,1
	 ; 特殊行発見→削除
	 repeat
	  i=0
	  if s="." :i=1 :break
	  if s="*" :i=1 :break
	  break
	 loop
	 if i {
	  instr i,Target,"\n",ii
	  strmid Target_buf,Target,-1,l-i-ii-2
	  strmid Target,Target,0,ii
	  Target+=Target_buf
	  l-=i+2
	 }
	loop
	return

; 操作対象中の指定領域の内容を取得
#deffunc strgeta val,str
	if sel :return
	mref p1,24
	mref p2,33
	p1="" :prm=0 :gosub *strproca
	return

;  操作対象中の指定領域の内容を設定
#deffunc strseta val,str
	if sel :return
	mref p1,24
	mref p2,33
	prm=1 :gosub *strproca
	return

; *で区切られたパラメータを配列変数に代入
#deffunc strgetprm val,val,int
	mref p1,56
	mref p2,25
	mref num,2
	repeat 16 :p1.cnt="" :loop
	if p2="" :return
	strlen l,p2 :ii=0
	if num=0 :num=l
	repeat num
	 prm=cnt
	 instr i,p2,"*",ii
	 if (i=-1)|(ii>=l) {
	  if l-ii=0 {
	   p1.prm=""
	  } else {
	   strmid p1.prm,p2,ii,l-ii
	  }
	  break
	 }
	 strmid p1.cnt,p2,ii,i
	 ii+=i+1
	loop
	return

; 文字型配列変数の一部を数値型に変換
#deffunc strcnvprm val,val,int,int
	mref p1,48
	mref p2,57
	mref start,2
	mref num,3
	ii=start
	repeat num
	 strlen prm,p2.ii
	 if prm>63 :continue
	 i=p2.ii :int i
	 p1.cnt=i
	 ii++
	loop
	return

; * 操作対象中の指定行の内容を取得/設定
*strproc
	; 行の検索
	instr i,Target,p2+"=",0
	if i>0 {
	 instr i,Target,"\n"+p2+"=",0
	 if i>=0 :i+=2
	}
	; 行が存在しない
	if i=-1 {
	 ; 設定 (新規に行を作成)
	 if prm {
	  strlen i,Target :strmid s,Target,i-2,2
	  if s="\n" :s="" :else :s="\n"
	  Target+=s+p2+"="+p1+"\n"
	 ; 取得/削除 (失敗)
	 } else :if prm=0 :p1=""
	 stt=0
	 return
	}
	; 行の内容についての情報を取得
	strlen l,Target
	strlen ii,p2 :i+=prm!2*(ii+1)
	instr ii,Target,"\n",i
	if ii=-1 :ii=l-i
	; 設定 (既存の行の内容を変更)
	;  or 削除 (既存の一行を削除)
	if prm {
	 sdim Target_buf,l+1
	 strmid Target_buf,Target,-1,l-i-ii
	 strmid Target,Target,0,i
	 Target+=p1+Target_buf
	 sdim Target_buf,64
	; 取得 (成功)
	} else :strmid p1,Target,i,ii
	stt=ii
	return

; * 操作対象中の指定領域の内容を取得/設定
*strproca
	; 領域の検索
	instr i,Target,"*"+p2+"\n",0
	if i>0 {
	 instr i,Target,"\n*"+p2+"\n",0
	 if i>=0 :i+=2
	}
	; 領域が存在しない
	if i=-1 {
	 ; 設定 (新規に領域を作成)
	 if prm {
	  strlen i,Target :strmid s,Target,i-2,2
	  if s="\n" :s="" :else :s="\n"
	  Target+=s+"*"+p2+"\n"+p1+"\n*end\n"
	 ; 取得 (失敗)
	 } else :p1=""
	 stt=0
	 return
	}
	; 領域の内容についての情報を取得
	strlen l,Target
	strlen ii,p2 :i+=ii+3
	instr ii,Target,"*end",i
	if ii=-1 :ii=l-i :else :ii-=2
	; 設定 (既存の領域を変更)
	if prm {
	 sdim Target_buf,l+1
	 strmid Target_buf,Target,-1,l-i-ii
	 strmid Target,Target,0,i
	 Target+=p1+Target_buf
	 sdim Target_buf,64
	; 取得 (成功)
	} else :strmid p1,Target,i,ii
	stt=ii
	return

#global
strinit


; ――――――――――――――――――――――――――――――――
;                                                    (c) arc@arcis