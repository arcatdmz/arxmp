
; �� �X�N���v�g
; �\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\

/* ���상�� �\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\

 �E���� as �t�@�C���ɂ���

	�X�N���v�g(arXmp�p�Ǝ�����)�̎��s�������s��

 �\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\ */


; �\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\
; �X�N���v�g�̎��s
;	�g�p�l	script		�X�N���v�g
;		scrLine		�X�N���v�g�̍s��
; �\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\

	*exec_script
	redraw 2
	repeat
	 await
	 notecut_ s,script
	 ; ���s�R�[�h��������Ȃ�
	 ; (�s���ȃX�N���v�g�H)
	 if stat=0 {
	  scrLine=1
	  if im>1024 {		; �T�C�Y���ُ큨�s���\�ƒf��
	   scrLine=0 :break
	  }
	  s=script :script=""	; �ꉞ���߂Ƃ��Ď��s���Ă݂�
	 }
	 ; ���߂���s�Ԃ���s
	 gosub *exec_scriptline
	 scrLine--
	 if scrLine<=0 :break
	loop
	redraw 1
	return


; �\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\
; ���߂̎��s
;	�g�p�l	s		����
;	�Ԃ�l	scrRet		����
; �\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\

	*exec_scriptline
	; ����L�[���[�h�̒u��
	i=0
	strlen prm.36,s			; prm.36 ���ߑS�̂̒���
	repeat
	 ; �L�[���[�h�J�n�̂��邵
	 instr ii,s,"%",i
	 if ii=-1 :break
	 ; �L�[���[�h�I���̂��邵
	 i+=ii+1			; i   �L�[���[�h�J�n�ʒu
	 instr ii,s,"%",i		; ii  �L�[���[�h��
	 if ii=0 :sss="" :else {
	  strmid sss,s,i,ii
	  peek prm,sss,0		; (prm �L�[���[�h�̎��)
	  strmid ss,sss,-1,ii-2		; (ss  �L�[���[�h�̏ڍ�)
	  repeat
	   if prm='p' :gosub get_minfo :break
	   if prm='o' {
	    prm.2=i,ii			; i,ii	�ޔ�
	    gosub get_objid
	    sss=""+i
	    i=prm.2 :ii=prm.3		; i,ii	�߂�
	    break
	   }
	   if prm='f' {
	    ; �ȉ� v.403.00�`
	    prm.2=ii			; ii	�ޔ�
	    gosub get_objfunc
	    sss=""+ii
	    ii=prm.2			; ii	�߂�
	    break
	   }
	   if prm='s' {
	    if ss="user" :sss=user :break
	    if ss="dir" :sss=exedir :break
	    if ss="titl" :sss=prgtitles :break
	    if ss="col" :sss=""+SysColor+"*"+SysColor.1+"*"+SysColor.2 :break
	    if ss="cols" :sss=""+SysColor2+"*"+SysColor2.1+"*"+SysColor2.2 :break
	    if ss="repmode" :get_langPMEX sss,lMode :break
	    ; �ȉ� v.403.00�`
	    strmid tmp,ss,0,4
	    strmid ss,ss,5,ii-5
	    if tmp="scrl" {
	     gosub get_scrlpos
	     if ss="x" :sss=""+prm :break
	     if ss="y" :sss=""+prm.1 :break
	     if ss="pos" :sss=""+prm+"*"+prm.1 :break
	     break
	    }
	    if tmp="seek" {
	     if ss="x" :sss=""+sSeekX :break
	     if ss="y" :sss=""+sSeekY :break
	     if ss="pos" :sss=""+sSeekX+"*"+sSeekY :break
	     gosub get_seekrect
	     if ss="ex" :sss=""+prm.2 :break
	     if ss="ey" :sss=""+prm.3 :break
	     if ss="epos" :sss=""+prm.2+"*"+prm.3 :break
	     if ss="rect" :sss=""+prm+"*"+prm.1+"*"+prm.2+"*"+prm.3 :break
	     if ss="width" :im=prm.2-prm :sss=""+im :break
	     if ss="height" :im=prm.3-prm.1 :sss=""+im :break
	     if ss="size" :im=prm.2-prm,prm.3-prm.1 :sss=""+im+"*"+im.1 :break
	     break
	    }
	    break
	   }
	   if prm='v' {
	    int_ ss
	    if im>=0&(im<snVar) :sss=sVar.im
	    break
	   }
	   if prm='d' {
	    int_ ss
	    if im>=0&(im<nlangs) :sss=langs.im
	    break
	   }
	   break
	  loop
	 }
	 strlen iii,sss			; iii �u��������
	 ; �u��
	 strmid ss,s,0,i-1		; ss �L�[���[�h�O
	 strmid s,s,-1,prm.36-i-ii-1	; s  �L�[���[�h��
	 s=ss+sss+s
	 ; ���̍X�V
	 prm.36+=iii-ii-2
	 i--
	loop
	; ���ߓ��e�̐؂蕪��
	strmid scrfunc,s,0,3
	if scrfunc=".::" :return
	if scrfunc=":::" :return
	strlen i,s
	instr ii,s,"=",0
	if i=7|(ii=7) :strmid scrfunc.1,s,3,4 :else :scrfunc.1=""
	if ii!-1 {
	 strmid s,s,-1,i-ii-1
	 strgetprm scrprms,s
	} else {
	 s=""
	 scrprms="","","","","","","","","","","","","","","",""
	}

; �\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\
; ���ꖽ��

	if scrfunc="!!!" {
	 if scrfunc.1="init" {
	  if scrprms="xsp" {
	   ; �Đ����X�g�̕\�����X�V
	   func=FNC_LIST_REFRESH :gosub *exec_func
	   ; �`�F�b�N�{�b�N�X�⃁�j���[�̃`�F�b�N���X�V
	   func=FNC_SET_SEARCH|FNC_REFRESH			:gosub *exec_func
	   func=FNC_MODE|FNC_REFRESH				:gosub *exec_func
	   func=FNC_MODE|FNC_REFRESH+PM_REPLIST			:gosub *exec_func
	   func=FNC_SET|FNC_REFRESH+IDX_SET_LIST_CLEARONLOAD	:gosub *exec_func
	   func=FNC_SET|FNC_REFRESH+IDX_SET_LIST_DOWNDBLITEM	:gosub *exec_func
	   func=FNC_SET|FNC_REFRESH+IDX_SET_PLAY_REPLAY		:gosub *exec_func
	   func=FNC_SET|FNC_REFRESH+IDX_SET_DISP_TRAYICON	:gosub *exec_func
	   func=FNC_SET|FNC_REFRESH+IDX_SET_DISP_TIPHELP	:gosub *exec_func
	   func=FNC_SET|FNC_REFRESH+IDX_SET_DISP_TASKBAR	:gosub *exec_func
	   func=FNC_SET|FNC_REFRESH+IDX_SET_DISP_ONTOP		:gosub *exec_func
	   func=FNC_LOADLIB|FNC_REFRESH+IDX_LOAD_MP3INFP	:gosub *exec_func
	   ; �v���C���[�N���㏉�߂ăX�L���̓ǂݍ��݂����������Ƃ��̏���
	   if dispMainWnd&initializing {
	    title langs.lgWelcome+sep+prgtitles :dispTitle=0
	    dispMainWnd=dispMainWnd^initializing
	   }
	   if mStatus!ST_CLOSED {
	    scrLine+=scrAreaShow_FileInfoLine
	    script=scrAreaShow_FileInfo+script
	   }
	   repeat snChk
	    chk_.cnt=chk.cnt
	   loop
	   return
	  }
	 }
	}

; �\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\
; �X�L���p����

	; �F�̐ݒ�
	if scrfunc="col" {
	 strcnvprm prm,scrprms,0,3
	 color prm,prm.1,prm.2
	 return
	}

	; �ʒu�̐ݒ�
	if scrfunc="pos" {
	 strcnvprm prm,scrprms,0,2
	 pos prm,prm.1
	 return
	}

	; �摜����
	if scrfunc="img" {
	 ; �ǂݍ���
	 if scrfunc.1="load" {
	  existex scrprms
	  if stat {
	   gosub gsel_widBuffer
	   strcnvprm prm,scrprms,1,2
	   picload scrprms,1,prm,prm.1
	   gsel sWid
	  }
	  return
	 }
	 strcnvprm prm,scrprms,0,6
	 ; �`�惂�[�h�ύX
	 if scrfunc.1="mode" :gmode prm,,,prm.1 :return
	 ; �`��(�o�b�t�@�����C�����)
	 if scrfunc.1="draw" {
	  if wi.widBuffer {
	   gcopy widBuffer,prm,prm.1,prm.2,prm.3
	  }
	  return
	 }
	 ; �`��(���C����ʁ��o�b�t�@)
	 ; �����Ȏd�l���J�� ver.403.00�`
	 if scrfunc.1="xdrw" {
	  gosub gsel_widBuffer
	  pos prm.4,prm.5
	  gcopy sWid,prm,prm.1,prm.2,prm.3
	  gsel sWid
	  return
	 }
	 return
	}

	; ������\��
	if scrfunc="mes" {
	 ; �\���t�H���g�̕ύX
	 if scrfunc.1="font" {
	  strcnvprm prm,scrprms,1,2
	  font scrprms,prm,prm.1
	  return
	 }
	 ; �\��
	 ;  (1) �\��������擾
	 ;		sss	�\��������
	 ;		ss	�񂹃I�v�V����
	 if scrfunc.1="" {
	  sss=scrprms
	  ss=scrprms.1
	 } else {
	  if scrfunc.1="scrl" {
	   gosub get_scrlpos
	   pos prm,prm.1
	   sss=mScroll
	  } else :ss=scrfunc.1 :gosub get_minfo
	  ss=scrprms
	 }
	 ;  (2) ���ۂɕ\��
	 ;	�ʏ�\��(����)
	 if ss="" :mes sss :else {
	  ;	�������s
	  if ss="box" {
	   strcnvprm prm,scrprms,2,2
	   prm.4=prm,prm.1
	   s=""
	   i=0 :ii=0
	   prm=bmscr.4,pss,0,pprmex
	   strlen prm.6,sss
	   repeat prm.6
	    ; �����擾
	    peek iii,sss,i
	    dllprocp FNC_IsDBCSLeadByte,iii,1
	    dllret++
	    strmid ss,sss,i,dllret
	    i+=dllret
	    ; ���������擾
	    prm.2=dllret
	    dllprocp FNC_GetTextExtentPoint32A,prm,4
	    ii+=prmex
	    ; ��������
	    if ii>prm.4 {
	     mes s :s=""
	     ii=prmex
	     pos csrx,csry+prm.5
	    }
	    s+=ss
	    ; ����������
	    if i>=prm.6 :break
	   loop
	   mes s
	   return
	  ;	�񂹃I�v�V�����t���\��
	  } else {
	   prm=bmscr.4,psss,0,pprmex
	   strlen prm.2,sss
	   dllprocp FNC_GetTextExtentPoint32A,prm,4
	   prm=csrx,csry+prmex.1
	   ;	(�E��)
	   if ss="right" :pos csrx-prmex,csry :else {
	    ;	(������)
	    if ss="center" :pos csrx-(prmex/2),csry
	   }
	   mes sss
	   pos prm,prm.1
	  }
	 }
	 return
	}

	; �}�`
	if scrfunc="drw" {
	 if scrfunc.1="line" :strcnvprm prm,scrprms,0,4 :line prm.0,prm.1,prm.2,prm.3 :else {
	  prm=-1,-1,-1,-1
	  if scrfunc.1="boxs" {
	   gosub get_seekrect
	  } else :if scrfunc.1="boxf" :strcnvprm prm,scrprms,0,4
	  boxf prm.0,prm.1,prm.2,prm.3
	 }
	 return
	}

	; �E�B���h�E
	if scrfunc="win" {
	 if scrfunc.1="regi" :regmake :return
	 strcnvprm prm,scrprms,0,2
	 if scrfunc.1="size" :width prm,prm.1 :return
	 if scrfunc.1="widt" :width prm, :return
	 if scrfunc.1="heig" :width ,prm :return
	 if scrfunc.1="posi" :width ,,prm,prm.1 :return
	 return
	}

	; �I�u�W�F�N�g
	if scrfunc="obj" {
	 ; �T�C�Y�̎w��
	 if scrfunc.1="size" :strcnvprm prm,scrprms,0,2 :objsize prm,prm.1 :return
	 ; �ݒu
	 if scrfunc.1="xset" {
	  if snObj>=objmax :return	; �ݒu���̌��E���m�F
	  ss=scrprms
	  gosub get_objfunc
	  if ii=0 :return
	  i=snObj
	  obj.i=ii
	  ; (1) �`�F�b�N�{�b�N�X
	  if obj.i&OBJ_CHKBOX {
	   if snChk>=chkmax :return	; �ݒu���̌��E���m�F
	   ii=snChk
	   chkid.ii=i
	   chkbox scrprms.1,chk.ii
	   snChk++
	   i+=41
	  } else {
	   ; (2) �Đ����X�g
	   if obj.i>>28&$F>=$E {
	    repeat 1
	     if hwList :i=0 :break
	     prm=lSelectedIdx
	     if obj.i=FNC_PLAYLIST :listbox lSelectedIdx,0,"" :sList=0 :else {
	      if obj.i=FNC_PLAYLISTC :combox lSelectedIdx,120,"" :sList=1 :else :i=0 :break
	     }
	     lSelectedIdx=prm
	     i+=41 :hwList=bmscr.i
	     ; ���b�Z�[�W�擾�ݒ�
	     gm_setwndproc hwList
	     gm_setmessage hwList,WM_LBUTTONDBLCLK	; �_�u���N���b�N�̎擾
	     gm_setmessage hwList,WM_KEYUP		; [Delete] �L�[�����̎擾
	    loop
	   ; (3) �{�^��
	   } else :button scrprms.1,*btn :i+=41
	  }
	  ; i	/ �I�u�W�F�N�gID+41
	  ;	  (�ݒu�Ɏ��s������ 0 )
	  if i {
	   ; ���[�U�[��`�C�x���g�Ƃ̊֘A�t��
	   if scrprms.2!"" {
	    ; ���b�Z�[�W�擾�ݒ�
	    int_ scrprms.2
	    i-=41 :obj.i.2=im :i+=41
	    i=bmscr.i
	    gm_setwndproc i
	    gm_setmessage i,WM_MOUSEMOVE	; �}�E�X���{�^���ɏ����
	    gm_setmessage i,WM_MOUSELEAVE	; �@�@�@�V�@�@�@���痣�ꂽ
	   }
	   snObj++
	  }
	  return
	 }
	 strmid s,scrprms,0,4
	 if s="Obj." {
	  strlen i,scrprms
	  strmid ss,scrprms,4,i-4
	  gosub get_objid
	 } else :int_ scrprms :i=im
	 ; �`�b�v�w���v�̐ݒ�
	 if scrfunc.1="help" :tiphelp scrprms.1,i :return
	 strcnvprm prm,scrprms,1,4
	 ; �傫���ƈʒu�̕ύX
	 if scrfunc.1="resz" :objresize prm,prm.1,i :return
	 if scrfunc.1="reps" :objrepos prm,prm.1,i :return
	 ; �摜��\��t��
	 if scrfunc.1="pimg" {
	  ;	i	/ �I�u�W�F�N�gID
	  ;	prm	/ �]�����w���W,�x���W,��,����
	  ; �\��t���̏���
	  ;  (1) �r�b�g�}�b�v�I�u�W�F�N�g���쐬
	  ;		(�ȑO�쐬����������������܂��폜)
	  if obj.i.1 :dllprocp FNC_DeleteObject,obj.i.1,1
	  prmex=bmscr.4,prm.2,prm.3
	  dllprocp FNC_CreateCompatibleBitmap,prmex,3
	  obj.i.1=dllret
	  ;  (2) ���𑀍삷�邽�߂̃f�o�C�X�R���e�L�X�g���쐬
	  dllprocp FNC_CreateCompatibleDC,bmscr.4,1
	  iii=dllret
	  ;  (3) �]��������摜���R�s�[
	  prmex=iii,obj.i.1
	  dllprocp FNC_SelectObject,prmex,2
	  prmex.1=0,0,prm.2,prm.3,bmscr.4,prm,prm.1,$CC0020
	  dllprocp FNC_BitBlt,prmex,9
	  ; �\��t��
	  ;  (1) �\��t����{�^���̃X�^�C����ύX
	  ii=i+41
	  prmex=bmscr.ii,-16,$50000080
	  dllprocp FNC_SetWindowLongA,prmex,3
	  ;  (2)
	  prmex=bmscr.ii,$F7,0,obj.i.1
	  dllprocp FNC_SendMessageA,prmex,4
	  ; ��n��
	  dllprocp FNC_DeleteDC,iii,1
	  return
	 }
	 ; �X�^�C���̐ݒ�
	 if scrfunc.1="styl" :btnable i,prm :return
	 return
	}

; �\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\
; �v���O�C���p����

	if scrfunc="exe" {
	 if scrfunc.1="func" {
	  int_ scrprms
	  func=im
	  funcopts=scrprms.1
	  if funcopts!"" :func=func|FNC_STR
	  gosub *exec_func
	  return
	 }
	}

	return


; �\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\
;                                                              (c) arc@arcis
