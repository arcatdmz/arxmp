
; �� �����񑀍샂�W���[��                        (strmod ver.1.00)
; �\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\


; �E���̃��W���[�����g���ƁA������֘A�̑�����s�����߂��g�����
; �@���ɂȂ�܂��B

; �Expimod (arX MusicPlayer�p�v���O�C���쐬���W���[��)�̕⏕�p��
; �@�J������܂����B


; �\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\
; �� strsel target                  �����񑀍얽�߂̑���Ώۂ��w��
;
;	target	: ������^�ϐ�
;
;	strmod �ő��삷��ΏۂɂȂ镶����^�ϐ����w�肵�܂��B
;	�ȍ~�̖��߂ł́A���̕ϐ��̒��g���Q�Ƃ��ꂽ��ҏW����܂��B
;	(strgetprm, strcnvprm ������)

; �\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\
; �� strget data,"key"              ����Ώے��̎w��s�̓��e���擾
;
;	data	: �s�̓��e�擾��ϐ�
;	"key"	: ���̍s�̃^�C�g��
;
;	strsel �Ŏw�肳�ꂽ������^�ϐ��̒�����
;
;		�s�̃^�C�g��=�s�̓��e
;
;	�Ƃ����s��T���A���݂���ꍇ�� data �ɂ��̓��e��Ԃ��܂��B
;	�Ⴆ�΁Astrsel �Ŏw�肳�ꂽ������^�ϐ��̒��g��
;
;		xspfile=�����ݒ�.xsp
;		xspauth=arc@arcis
;		xsptitl=�����ݒ�
;		...
;		lsttype=normal
;		lstwidt=200
;		lstheig=80
;
;	����������
;
;		s="" :strget s,"xsptitl"
;
;	�����s����ƁAs �� "�����ݒ�" �Ƃ��������񂪑������܂��B
;	�܂��Ai �����l�^�ϐ��̎�
;
;		strget i,"lstwidt"
;
;	�����s����� i �� 200 �Ƃ������l���������܂��B

; �\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\
; �� strset data,"key"              ����Ώے��̎w��s�̓��e��ݒ�
;
;	data	: �s�̓��e�����Ă��镶����ϐ�
;	"key"	: ���̍s�̃^�C�g��
;
;	strsel �Ŏw�肳�ꂽ������^�ϐ��̒�����
;
;		�s�̃^�C�g��=�s�̓��e
;
;	�Ƃ����s��T���A���݂���ꍇ�͂��̓��e�� data �Ŏw�肳�ꂽ
;	������ɂ��܂��B���݂��Ȃ��ꍇ�͐V���ɍs��ǉ����܂��B

; �\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\
; �� strdel "key"                         ����Ώے��̎w��s���폜
;
;	"key"	: ���̍s�̃^�C�g��
;
;	strsel �Ŏw�肳�ꂽ������^�ϐ��̒�����
;
;		�s�̃^�C�g��=�s�̓��e
;
;	�Ƃ����s��T���A���݂���ꍇ�͂��̍s���폜���܂��B

; �\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\
; �� strdelex                             ����Ώے��̓���s���폜
;
;	strsel �Ŏw�肳�ꂽ������^�ϐ��̒��� * �܂��� . �Ŏn�܂�
;	�s��S�č폜���܂��B

; �\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\
; �� strgeta data,"key"           ����Ώے��̎w��̈�̓��e���擾
;
;	data	: �̈�̓��e�擾�敶����ϐ�
;	"key"	: ���e���擾�������̈�̃^�C�g��
;
;	strsel �Ŏw�肳�ꂽ������^�ϐ��̒���
;
;		*�̈於
;		�̈�̓��e
;		*end
;
;	�ƂȂ��Ă��镔���� "�̈�" �ƌĂт܂��B
;	���̖��߂́A�̈於���w�肷�邱�Ƃł��̓��e���擾�ł��܂��B
;	���s��Astat �ɂ͎擾���ꂽ�̈�̒������������܂��B

; �\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\
; �� strseta data,"key"           ����Ώے��̎w��̈�̓��e��ݒ�
;
;	data	: �̈�̓��e�����Ă��镶����ϐ�
;	"key"	: ���e��ݒ肵�����̈�̃^�C�g��
;
;	strsel �Ŏw�肳�ꂽ������^�ϐ��̒��� �w�肳�ꂽ�^�C�g����
;	�̈��T���A���݂���ꍇ�͂��̓��e�� data �Ŏw�肳�ꂽ����
;	��ɂ��܂��B���݂��Ȃ��ꍇ�͐V���ɗ̈���쐬���܂��B


; �\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\
; �� strgetprm var,data,num
;                          *�ŋ�؂�ꂽ�p�����[�^��z��ϐ��ɑ��
;
;	var	: �p�����[�^�擾�敶����^�z��ϐ�
;	data	: �p�����[�^�Ƃ��Ď擾����������������Ă���ϐ�
;	num	: �p�����[�^�̐�( 0 �őS�擾)
;
;	data �̒��� * �ŋ�؂�ꂽ��������A�z��ϐ� var �Ɉ��
;	�����Ď擾���܂��B
;	�z��͍Œ� 16 �m�ۂ��Ă����Ȃ���΂Ȃ�܂���B
;	���Ƃ��� data �̒��g��
;
;		abc*def*����������*123*555*�Ȃɂʂ˂�
;
;	�ƂȂ��Ă�������
;
;		sdim param,64,16
;		strgetprm param,data,6
;
;	�����s�����
;
;	(�ϐ�)	|	(���e)
;	param.0	|	abc
;	param.1	|	def
;	param.2	|	����������
;	param.3	|	123
;	param.4	|	555
;	param.5 |	�Ȃɂʂ˂�
;
;	�ƂȂ�܂��B
;	������ param.3/4 �͐��l�ł���������Ƃ��Ĉ����Ă��܂��B
;	����𐔒l�^�ɕϊ����邽�߂Ɏg���̂����̖��߂ł��B

; �\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\
; �� strcnvprm to,from,start,num
;                               �����^�z��ϐ��̈ꕔ�𐔒l�^�ɕϊ�
;
;	to	: �ϊ��搔�l�^�z��ϐ�
;	from	: �ϊ���������^�z��ϐ�
;	start	: �ϊ��J�n�ʒu
;	num	: �ϊ���
;
;	��� strgetprm �̗�ŁA�Ō��
;
;		dim prm,16
;		strcnvprm prm,param,3,2
;
;	�����s����ƁAparam.3/4 �� prm.0/1 �ɑ�������
;
;	(�ϐ�)	|	(���e)
;	prm.0	|	123
;	prm.1	|	555
;
;	�ƂȂ�܂��B


#module

; ���W���[���̏�����
#deffunc strinit
	mref stt,64
	dim sel :dim i :dim ii :dim iii :dim l
	dim prm,16
	sdim s,64
	sel=1 :return

; �����񑀍얽�߂̑���Ώۂ��w��
#deffunc strsel val
	mref Target,24
	sel=0 :return

; ����Ώے��̎w��s�̓��e���擾
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

; ����Ώے��̎w��s�̓��e��ݒ�
#deffunc strset val,str
	if sel :return
	mref p1,24
	mref p2,33
	prm=1 :gosub *strproc
	return

; ����Ώے��̎w��s���폜
#deffunc strdel str
	if sel :return
	p1=""
	mref p2,32
	prm=2 :gosub *strproc
	return

; ����Ώے��̓���s���폜
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
	 ; �s�������擾
	 strmid s,Target,ii,1
	 ; ����s�������폜
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

; ����Ώے��̎w��̈�̓��e���擾
#deffunc strgeta val,str
	if sel :return
	mref p1,24
	mref p2,33
	p1="" :prm=0 :gosub *strproca
	return

;  ����Ώے��̎w��̈�̓��e��ݒ�
#deffunc strseta val,str
	if sel :return
	mref p1,24
	mref p2,33
	prm=1 :gosub *strproca
	return

; *�ŋ�؂�ꂽ�p�����[�^��z��ϐ��ɑ��
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

; �����^�z��ϐ��̈ꕔ�𐔒l�^�ɕϊ�
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

; * ����Ώے��̎w��s�̓��e���擾/�ݒ�
*strproc
	; �s�̌���
	instr i,Target,p2+"=",0
	if i>0 {
	 instr i,Target,"\n"+p2+"=",0
	 if i>=0 :i+=2
	}
	; �s�����݂��Ȃ�
	if i=-1 {
	 ; �ݒ� (�V�K�ɍs���쐬)
	 if prm {
	  strlen i,Target :strmid s,Target,i-2,2
	  if s="\n" :s="" :else :s="\n"
	  Target+=s+p2+"="+p1+"\n"
	 ; �擾/�폜 (���s)
	 } else :if prm=0 :p1=""
	 stt=0
	 return
	}
	; �s�̓��e�ɂ��Ă̏����擾
	strlen l,Target
	strlen ii,p2 :i+=prm!2*(ii+1)
	instr ii,Target,"\n",i
	if ii=-1 :ii=l-i
	; �ݒ� (�����̍s�̓��e��ύX)
	;  or �폜 (�����̈�s���폜)
	if prm {
	 sdim Target_buf,l+1
	 strmid Target_buf,Target,-1,l-i-ii
	 strmid Target,Target,0,i
	 Target+=p1+Target_buf
	 sdim Target_buf,64
	; �擾 (����)
	} else :strmid p1,Target,i,ii
	stt=ii
	return

; * ����Ώے��̎w��̈�̓��e���擾/�ݒ�
*strproca
	; �̈�̌���
	instr i,Target,"*"+p2+"\n",0
	if i>0 {
	 instr i,Target,"\n*"+p2+"\n",0
	 if i>=0 :i+=2
	}
	; �̈悪���݂��Ȃ�
	if i=-1 {
	 ; �ݒ� (�V�K�ɗ̈���쐬)
	 if prm {
	  strlen i,Target :strmid s,Target,i-2,2
	  if s="\n" :s="" :else :s="\n"
	  Target+=s+"*"+p2+"\n"+p1+"\n*end\n"
	 ; �擾 (���s)
	 } else :p1=""
	 stt=0
	 return
	}
	; �̈�̓��e�ɂ��Ă̏����擾
	strlen l,Target
	strlen ii,p2 :i+=ii+3
	instr ii,Target,"*end",i
	if ii=-1 :ii=l-i :else :ii-=2
	; �ݒ� (�����̗̈��ύX)
	if prm {
	 sdim Target_buf,l+1
	 strmid Target_buf,Target,-1,l-i-ii
	 strmid Target,Target,0,i
	 Target+=p1+Target_buf
	 sdim Target_buf,64
	; �擾 (����)
	} else :strmid p1,Target,i,ii
	stt=ii
	return

#global
strinit


; �\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\
;                                                    (c) arc@arcis