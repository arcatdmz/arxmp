
; �� arX MusicPlayer �̋@�\
; �\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\

/* ���상�� �\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\

 �E���m�̖��

	���X�g�E�B���h�E�̃��j���[�o�[���烁�j���[���ڂ��N���b�N�����
	*btn_ListWnd �ɔ�񂾂�A HSP Error ���o���㋭���I������

		-> ���j���[�o�[�̍��ڂɎw�肷�郁�j���[ID�� $4000 �𒴂����
		�@ HSP �����j���[���ڂ̃N���b�N�� �E�B���h�E���̃{�^���N���b
		�@ �N�Ɗ��Ⴂ���邱�Ƃ����邽�߁B
		�@ ���j���[ID�� �����Ȓl�ɂ��ĉ����B

 �E���� as �t�@�C���ɂ���

	���x���ꗗ
	*btn_*		�E�B���h�E���{�^���������ꂽ�ۂ̏���
	*exec_func	�v���C���[�̋@�\�����s���鏈��

 �\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\ */


; �\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\
; �{�^���@�\�̎��s
;	�g�p�l	stat		�{�^���̃I�u�W�F�N�gID
; �\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\

; �\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\
; ���C����ʂ̃{�^��
*btn
	func=obj.stat
	#ifdef DEBUG
	addlog "BTN main (id="+stat+")"
	#endif
	gosub *exec_func :goto *main


; �\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\
; ���X�g��ʂ̃{�^��
*btn_ListWnd
	repeat
	 ; [��] [��]
	 if stat=0 :func=FNC_LIST_UP|FNC_AUTO+IDX_SEL :break
	 if stat=1 :func=FNC_LIST_DOWN|FNC_AUTO+IDX_SEL :break
	 ; [D] [R] [C]
	 if stat=2 :func=FNC_LIST_DELETE|FNC_AUTO+IDX_SEL :break
	 if stat=3 :func=FNC_LIST_RENAME|FNC_AUTO+IDX_SEL :break
	 if stat=4 :func=FNC_LIST_CLEAR|FNC_ALL :break
	 ; [�I�𒆂̍��ڂ�����]
	 if stat=6 :func=FNC_LIST_CLEAR|FNC_AUTO+IDX_SEL :break
	 ; [���X�g��ۑ�] [�V�Ǎ�]
	 if stat=7 :func=FNC_XLT_SAVE :break
	 if stat=8 :func=FNC_XLT_LOAD :break
	 ; [����]
	 if stat=9 :func=FNC_OPEN_WND|FNC_OFF+widList :break
	 func=0 :break
	loop
	#ifdef DEBUG
	addlog "BTN list (id="+stat+")"
	#endif
	gosub *exec_func :goto *main

; �\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\
; ����ʂ̃{�^��
*btn_InfoWnd
	if dispInfoWnd&IDX_WND_INPUT {
	 ; [�Q��]
	 if stat=15 {
	  dialog "bmp;*.jpg",16,"�摜�t�@�C��"
	  if stat=0 :stop
	  funcopts=refstr
	  gsel widInfo
	  objprm 13,funcopts
	  gsel sWid
	  stop
	 }
	 ; [�L�����Z��]
	 if stat=17 {
	  funcopts=""
	 ; [O K]
	 } else {
	  if dispInfoWnd&IDX_WND_SKV {
	   ; ���X�g������e��I�Ԍ^�̃X�L���ϐ�
	   i=sEditingIdx
	   if sVar_type.i=SV_LIST {
	    if funcopt=-1 :funcopt=0
	    notesel sVar_list.i
	    noteget funcopts,funcopt
	   }
	   if funcopts="" :funcopts="(null)"
	  }
	 }
	 #ifdef DEBUG
	 funclv--
	 #endif
	 func=FNC_OPEN_WND|FNC_OFF+widInfo :goto *exec_func
	}
	repeat
	 ; [�v���p�e�B��\��]
	 if stat=10 :func=FNC_OPEN_PROPERTY|FNC_AUTO+IDX_CUR :break
	 ; [�����X�V]
	 if stat=11 :func=FNC_OPEN_WND|FNC_ON|FNC_REFRESH+widInfo+IDX_WND_MINFO :break
	 ; [����] [�L�����Z��]
	 if stat=12 :func=FNC_OPEN_WND|FNC_OFF+widInfo :break
	 func=0 :break
	loop
	#ifdef DEBUG
	addlog "BTN info (id="+stat+")"
	#endif
	gosub *exec_func :goto *main


; �\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\
; �@�\�̎��s
;	�g�p�l	func		�@�\�ԍ�
;		funcopts	������I�v�V����
;	�Ԃ�l	funcret		����
; �\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\

*exec_func

	repeat 2
	 funcid    = func&$FF000000
	 funcopt   = func&$0000FFFF
	 ; ��O�I�Ȓl���@�\�ԍ��ɕϊ�
	 if funcid=0 {
	  ; (1) ���j���[�o�[�̃��j���[����ID
	  if func>=FNCM {
	   #ifdef DEBUG
	   addlog "CNV (menuid="+func+")"
	   #endif
	   repeat
	    if func<FNCM_SET_SEARCH {
	     func=FNC_SET|FNC_AUTO+(func-FNCM_SET)
	     break
	    }
	    if func<FNCM_SET_SEARCHEX {
	     func=FNC_SET_SEARCH|FNC_AUTO+TPEXfromTP(func-FNCM_SET_SEARCH)
	     break
	    }
	    if func<FNCM_XPI_LOAD {
	     func=FNC_SET_SEARCH|FNC_AUTO|FNC_ALL
	     break
	    }
	    if func<FNCM_LOADLIB {
	     func=FNC_XPI_LOAD|FNC_AUTO+(func-FNCM_XPI_LOAD)
	     break
	    }
	    if func<FNCM_XLT_LOAD {
	     func=FNC_LOADLIB|FNC_AUTO+(func-FNCM_LOADLIB)
	     break
	    }
	    if func<FNCM_XLT_LOADEX {
	     func=FNC_XLT_LOAD|FNC_AUTO+(func-FNCM_XLT_LOAD)
	     break
	    }
	    if func<FNCM_XLT_SAVE {
	     func=FNC_XLT_LOAD|FNC_AUTO|FNC_REFRESH
	     break
	    }
	    if func<FNCM_XLT_SAVEEX {
	     func=FNC_XLT_SAVE|FNC_AUTO+(func-FNCM_XLT_SAVE)
	     break
	    }
	    func=FNC_XLT_SAVE|FNC_AUTO|FNC_ON
	    break
	   loop
	  ; (2) ���ł̋@�\�ԍ�
	  } else {
	   #ifdef DEBUG
	   addlog "CNV (funcid="+func+")"
	   #endif
	   i=func&$FFF-FNC_OBJ402
	   if i>=0&(i<objs) :func=obj_func.i
	  }
	 } else :break
	loop

	#ifdef DEBUG
	func_.funclv=func :funclv++
	#define	return_(%1=funcret) funcret=%1 :funclv-- :gosub *addlogfnc :return
	#else
	#define return_(%1=funcret) funcret=%1 :return
	#endif

; �\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\
; �E�B���h�E���J��/�B��
;	����	tmp �̓��e��j�󂵂Ȃ�(FNC_XSP_LOAD �p�̔z��)

	if funcid=FNC_OPEN_WND {
	 ; (1) ���C�����(���v���C���[�I��)
	 if funcopt=widMain|(funcopt=widRegion) :goto *exit
	 ; (2) ���X�g���
	 if funcopt=widList {
	  ; ���߂ă��X�g��ʂ�\������ꍇ
	  if wi.widList=0 {
	   ; �E�B���h�E�̏�����
	   bgscr widList,dispx,dispy,2,ListWndX,ListWndY
	   title "���X�g�E�B���h�E"+sep+prgtitles
	   mref bmscrl,67
	   hwListWnd=bmscrl.13
	   prm=hwListWnd,-16,$CC0000 :dllprocp FNC_SetWindowLongA,prm,3
	   ; ���j���[�̐ݒ�
	   dllproc "CreateMenu",prm,0,D_USER
	   hmBar=dllret
	   prm=hwListWnd,hmBar
	   dllproc "SetMenu",prm,2,D_USER
	   imenu "�Đ����X�g(&L)",0,hmList,hmBar
	   imenu "�ݒ�(&C)",0,hmSet,hmBar
	   dllproc "DrawMenuBar",hwListWnd,1,D_USER
	   ; �E�B���h�E�̑傫���𒲐�
	   prm=15 :dllprocp FNC_GetSystemMetrics,prm,1 :ListWndHeight+=dllret
	   prm=4  :dllprocp FNC_GetSystemMetrics,prm,1 :ListWndHeight+=dllret
	   prm=32 :dllprocp FNC_GetSystemMetrics,prm,1 :ListWndWidth +=dllret*2
	   prm=33 :dllprocp FNC_GetSystemMetrics,prm,1 :ListWndHeight+=dllret*2
	   width ListWndWidth,ListWndHeight
	   ListWndWidth=winx
	   ListWndHeight=winy
	   ; �I�u�W�F�N�g�̐���
	   font "�l�r �S�V�b�N",12
	   objmode 2,1
	   boxf_ 0,0,dispx,dispy,hSysBrush
	   objsize 18,32
	   pos 0,0
	   button "��",*btn_ListWnd
	   button "��",*btn_ListWnd
	   button "D",*btn_ListWnd
	   button "R",*btn_ListWnd
	   button "C",*btn_ListWnd
	   pos 20,0
	   objsize winx-20,winy-25
	   i=lSelectedIdx
	   listbox lSelectedIdx,0,""
	   lSelectedIdx=i
	   objsize 140,21
	   pos 5,winy-23
	   button "�I�𒆂̍��ڂ�����",*btn_ListWnd
	   objsize 100,21
	   pos 150,winy-23
	   button "���X�g��ۑ�",*btn_ListWnd
	   pos 250,winy-23
	   button "���X�g��Ǎ�",*btn_ListWnd
	   objsize 60,21
	   pos winx-65,winy-23
	   button "����",*btn_ListWnd
	   ; �E�B���h�E���b�Z�[�W�擾�ݒ�
	   gm_setwndproc hwListWnd
	   gm_setmessage hwListWnd,WM_COMMAND		; WM_COMMAND(���j���[���ڂ̃N���b�N)�̎擾
	   hwListSub=bmscrl.46
	   gm_setwndproc hwListSub
	   gm_setmessage hwListSub,WM_LBUTTONDBLCLK	; �_�u���N���b�N�̎擾
	   gm_setmessage hwListSub,WM_KEYUP		; [Delete] �L�[�����̎擾
	   gm_setmessage hwListSub,WM_DROPFILES		; �h���b�O���h���b�v�̎擾
	   prm=hwListSub,1				; �h���b�O���h���b�v�̋���
	   dllprocp FNC_DragAcceptFiles,prm,2
	   ; �`�b�v�w���v�̍X�V
	   gsel sWid
	   wi.widList=1
	   gosub refresh_tiphelp
	  }
	  if func&FNC_CHANGE {
	   i=func&FNC_AUTO!0&(dispListWnd)|(func&FNC_OFF)
	   ; i		/ ��ʂ����(1)���J��(0)��
	   ; ���C����ʂ̃��X�g�ҏW�n�{�^����L��/������
	   repeat objmax
	    ii=obj.cnt&$FF000000
	    iii=0
	    repeat
	     if ii=FNC_OPEN_LISTAREA	:iii=1 :break
	     if ii=FNC_PLAYLIST		:iii=1 :break
	     if ii=FNC_PLAYLISTC	:iii=1 :break
	     break
	    loop
	    if iii :btnable cnt,i=0
	   loop
	   ; ��ʕ\���ɔ��f
	   dispListWnd=i=0
	   func=FNC_LIST_REFRESH :gosub *exec_func
	   gsel widList,dispListWnd*2-1
	   gsel sWid
	   func=FNC_OPEN_LISTAREA|FNC_OX(dispListWnd=0) :gosub *exec_func
	  }
	  return_ dispListWnd
	 }
	 ; (3) ���E�B���h�E
	 if funcopt&$FF=widInfo {
	  ; ���߂ď���ʂ�\������ꍇ
	  if wi.widInfo=0 {
	   ; �E�B���h�E�̏�����
	   screen widInfo,360,185,6,dispx-360/2,dispy-185/2
	   title ""
	   mref bmscri,67
	   hwInfoWnd=bmscri.13
	   ; �I�u�W�F�N�g�̐���
	   font "�l�r �S�V�b�N",12
	   objmode 2,1
	   ;  �ȏ��\����
	   s=""
	   objsize 85 ,25:pos 2 ,3  :combox mScrollType  ,,type_minfo
	   objsize 265,24:pos 90,1  :mesbox s,,,0
	   objsize 85 ,25:pos 2 ,28 :combox mScrollType.1,,type_minfo
	   objsize 265,24:pos 90,26 :mesbox s,,,0
	   objsize 85 ,25:pos 2 ,53 :combox mScrollType.2,,type_minfo
	   objsize 265,24:pos 90,51 :mesbox s,,,0
	   objsize 85 ,25:pos 2 ,78 :combox mScrollType.3,,type_minfo
	   objsize 265,24:pos 90,76 :mesbox s,,,0
	   objsize 85 ,25:pos 2 ,103:combox mScrollType.4,,type_minfo
	   objsize 265,24:pos 90,101:mesbox s,,,0
	   objsize 150,21
	   pos 205,129	:button "�v���p�e�B��\��",*btn_InfoWnd
	   objsize 100,21
	   pos 150,160	:button "�����X�V",*btn_InfoWnd
	   pos 255,160	:button "����",*btn_InfoWnd
	   ;  ���̓{�b�N�X
	   objsize 340,21
	   pos 10,40	:input funcopts
	   ;  �I���{�b�N�X
	   objsize 340,70
	   i=funcopt
	   funcopt=0	:s=""
	   pos 10,30	:listbox funcopt,50,s
	   funcopt=i
	   ;  [�Q��]
	   objsize 40,21
	   font "MS UI Gothic",10
	   pos 310,40	:button "�Q��...",*btn_InfoWnd
	   font "�l�r �S�V�b�N",12
	   ;  [O K] [�L�����Z��]
	   objsize 100,21
	   pos 150,160 :button "O K",*btn_InfoWnd
	   pos 255,160 :button "�L�����Z��",*btn_InfoWnd
	   wi.widInfo=1
	  } else :gsel widInfo
	  if func&FNC_CHANGE {
	   ; ��ʂ����
	   if func&FNC_AUTO!0&(dispInfoWnd&1)|(func&FNC_OFF) {
	    gsel widInfo,-1
	    gsel sWid
	    if dispInfoWnd&IDX_WND_INPUT!0 {
	     if dispInfoWnd&IDX_WND_SKV {
	      ; [�Q��] �{�^���\���p�ɏk�߂����̓{�b�N�X�����ɖ߂�
	      i=sEditingIdx
	      if sVar_type.i=SV_IMAGE :objresize 340,21,13
	     }
	     gosub enable_allWnd
	    }
	    dispInfoWnd=0
	   ; ��ʂ��J��
	   } else {
	    dispInfoWnd=funcopt&IDX_WND_INPUT+1
	    redraw 2
	    boxf_ 0,0,winx,winy,hSysBrush
	    boxf_ 4,winy-31,winx-5,winy-30,hSysBrush2
	    ; �ȏ��(IDX_WND_MINFO)
	    if dispInfoWnd&IDX_WND_INPUT=0 {
	     repeat 13  :btnable cnt,3 :loop
	     repeat 5,13:btnable cnt,2 :loop
	     if func&FNC_REFRESH {
	      func=FNC_GETTAGINFO|FNC_AUTO+IDX_CUR :gosub *exec_func
	     } else :gosub get_mscroll
	    ; ���̑�
	    } else {
 	     gosub disable_allWnd
	     repeat 16  :btnable cnt,2 :loop
	     repeat 2,16:btnable cnt,3 :loop
	     palcolor 0
	     pos 10,10
	     repeat
	      ; �X�L���ϐ����e�̕ҏW���(IDX_WND_SKV)
	      if dispInfoWnd&IDX_WND_SKV {
	       i=sEditingIdx :ii=sVar_type.i=SV_LIST+13
	       ; i	/	�X�L���ϐ�ID
	       ; ii	/	���X�g�{�b�N�X���g�p�\�ɂ���(14)���A
	       ;		���̓{�b�N�X���g�p�\�ɂ���(13)��
	       btnable ii,3
	       if sVar_type.i=SV_IMAGE {
	        objresize 300,21,13
	        btnable 15,3
	       }
	       objprm ii,funcopts
	       mes sVar_dsc.i :break
	      }
	      ; ���y�t�@�C�����̕ύX���(IDX_WND_RENAME)
	      btnable 13,3
	      objprm 13,funcopts
	      if dispInfoWnd&IDX_WND_RENAME :mes langs.lgDlg_Rename :break
	      ; ���C�ɓ���o�^�����͉��(IDX_WND_FAVORITE)
	      if dispInfoWnd&IDX_WND_FAVORITE :mes langs.lgDlg_Favorite :break
	      break
	     loop
	     redraw 1
	     gsel widInfo,1
	     gsel sWid
	     ; ���̌�
	     ; [O K] [�L�����Z��] �{�^�����N���b�N������ *btn_InfoWnd ��
	     ; [Alt]+[F4] �L�[���������� *exit ��
	     stop
	    }
	    redraw 1
	    gsel widInfo,1
	    gsel sWid
	   }
	  }
	  return_ dispInfoWnd
	 }
	 ; (4) �Đ��Ɏg�p���Ă���d�g�݂̐������
	 funcopt-=widExt
	 if mStatus=ST_CLOSED|(funcopt>=npfprop) :return_ FR_ERR
	 ; �t�@�C����̊m�F
	 i=TPfromTPEX(mFileType)
	 ; �e�d�g�݂̐�����\��
	 repeat
	  ; Windows MCI �𗘗p
	  if type.i=PF_MCI {
	   dialog "Multimedia Control Interface\n\n�@�}���`���f�B�A���Đ����邽�߂Ɏg�p�����d�g�݂ł��B\n�@���y�t�@�C���ɂƂǂ܂炸�A�f����Î~��ACD�̍Đ��Ȃǂ��ł��܂��B",,"MCI"
	   break
	  }
	  ; DirectX DirectShow �𗘗p
	  if type.i=PF_DXS {
	   gosub enum_filters
	   break
	  }
	  ; �O��DLL�𗘗p
	  if type.i=PF_DLL {
	   ; DDE
	   /*
	   if mFileType&TPEX_MID {
	    if dde_name="TMIDI" {
	     dialog "TMIDI Player / (c) �ӂ݂�\n\n�@Midi�̍��i�ʂȍĐ��Ɖ̎��\���ɓ��������\�t�g�E�F�A�ł��B\n\n�����݂̔ł� arXmp �� TMIDI Player �̃��C����ʂ�\�����Ȃ��d�l�ƂȂ��Ă���A\n�@�̎��\���@�\�𗘗p���邱�Ƃ͂ł��܂���B",,dde_name+".exe"
	     break
	    }
	    if dde_name="WFP" {
	     dialog "WFP / (c) A.I (Tonouesan)\n\n�@Midi�̍��i�ʂȍĐ��Ɖ̎��\���ɓ��������\�t�g�E�F�A�ł��B",,dde_name+".exe"
	     break
	    }
	    break
	   }
	   */
	   ; Vox.dll
	   if mFileType&TPEX_OGG {
	    dialog "Vox - Vorbis Expander / (c) �쑺XX\n\n�@Vox.dll �� OggVorbis �`���̉��y�t�@�C�����Đ�����@�\�������܂��B",,"Vox.dll"
	    break
	   }
	   ; vbmp3.dll
	   if mFileType&TPEX_MP3 {
	    dialog "vbmp3 / original ver. (c) �~�P\n\n�@vbmp3.dll �� MPEG Audio �`���̉��y�t�@�C�����Đ�����@�\�������܂��B",,"vbmp3.dll"
	    break
	   }
	   break
	  }
	  break
	 loop
	 return_ FR_DONE
	}

; �\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\
; ���X�g�̈��\��/�B��

	if funcid=FNC_OPEN_LISTAREA {
	 if func&FNC_CHANGE {
	  ; �B��
	  if func&FNC_AUTO!0&(dispListArea)|(func&FNC_OFF) {
	   scrLine+=scrAreaHide_ListAreaLine
	   script=scrAreaHide_ListArea+script
	   prm=MainWndWidth+ListAreaWidth,MainWndHeight+ListAreaHeight,MainWndWidth,MainWndHeight
	   dispListArea=0
	  ; �\��
	  } else {
	   scrLine+=scrAreaDisp_ListAreaLine
	   script=scrAreaDisp_ListArea+script
	   prm=MainWndWidth,MainWndHeight,MainWndWidth+ListAreaWidth,MainWndHeight+ListAreaHeight
	   dispListArea=1
	  }
	  ; ���C����ʂ̑傫���ύX
	  if sListArea!2 {
	   if sListArea=1 {
	    repeat 10,1
	     width prm+(prm.2-prm/10*cnt),prm.1+(prm.3-prm.1/10*cnt)
	     await
	    loop
	   }
	   width prm.2,prm.3
	  }
	 }
	 return_ dispListArea
	}

; �\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\
; ���y�t�@�C���̃v���p�e�B��\��

	if funcid=FNC_OPEN_PROPERTY {
	 if func&FNC_STR=0 {
	  gosub get_mpath
	  if funcopt=-1 :return_ FR_ERR
	 }
	 ; mp3infp.dll �g�p���̓^�O�̃v���p�e�B�y�[�W��D�悵�ĕ\��
	 if D_MP3INFP!0 {
	  s=funcopts
	  prm=0,ps,0
	  dllprocp FNC_mp3infp_ViewProp,prm,3
	 ; ��g�p���͕��ʂɃv���p�e�B��\��
	 } else {
	  skiperr 1
	  exec funcopts,,"properties"
	  dllret=err=0
	  skiperr 0
	 }
	 return_ dllret=0*FR_ERR
	}

; �\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\
; ���y�t�@�C���̐e�t�H���_��\��

	if funcid=FNC_OPEN_PARENTDIR {
	 if func&FNC_STR=0 {
	  gosub get_mpath
	  if funcopt=-1 :return_ FR_ERR
	 }
	 ; �e�t�H���_�̎擾
	 getfname funcopts
	 strmid funcopts,funcopts,0,stat
	 ; ���݊m�F�ƕ\��
	 exist_ funcopts
	 if stat=-1 :exec funcopts,16 :return_ FR_DONE
	 return_ FR_ERR
	}

; �\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\
; ���C����ʂ��ŏ���/���ɖ߂�

	if funcid=FNC_MINIMIZE {
	 if func&FNC_CHANGE {
	  ; �ŏ���
	  if func&FNC_AUTO!0&(dispMainWnd&2=0)|(func&FNC_ON) {
	   ginfo 2 :MainWndX=prmx :MainWndY=prmy
	   dllprocp FNC_CloseWindow,hwMainWnd,1
	  ; ���ɖ߂�
	  } else {
	   prm=hwProcess,WM_TASKTRAY,0,WM_LBUTTONUP
	   dllprocp FNC_SendMessageA,prm,4
	  }
	 }
	 return_ dispMainWnd&2!0
	}

; �\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\
; ���j���[��\������

	if funcid=FNC_POPUP {
	 if funcopt<0|(funcopt>=nhmenu) :return_ FR_ERR
	 ginfo
	 i=funcopt
	 pmenu hmenu.i,prmx,prmy,bmscr.13
	 ; �I�����ꂽ�@�\�̎��s
	 if dllret {
	  func=dllret :gosub *exec_func
	  return_
	 }
	 return_ FR_ERR
	}

; �\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\
; ���y�̍Đ�
; (�S����t�@�C����ʃ^�O�̎擾�������܂�)

	if funcid=FNC_PLAY {
	 if func&FNC_STR=0 {
	  gosub get_mpath
	  if funcopt=-1 :return_ FR_ERR
	  mFileIdx=funcopt
	 } else :mFileIdx=-1
	 ; ����܂ōĐ����Ă������y�̒�~
	 if mStatus!ST_CLOSED :func=FNC_STOP :gosub *exec_func
	 ; ���y�̏�� [1]
	 mFilePath=funcopts	:gettype mFilePath :s=refstr
	 mFileType=stat		:getfname mFilePath
	 mFileName=refstr	:i=mFileIdx+1
	 mFileSize=0 :mQuality=0
	 mAuthor="" :mName="" :mComment="" :mAlbumName="" :mRelDate="" :mFormat=""
	 ; �^�X�N�g���C�\���p������̐���
	 mTasktray=""+i+". "+mFileName
	 strlen i,mTasktray
	 if 64-lprgnames<i {
	  strmid_ mTasktray,mTasktray,0,61-lprgnames
	  mTasktray+="..."
	 }
	 mTasktray+=sep+prgnames
	 ; �t�@�C����̊m�F
	 i=TPfromTPEX(mFileType)
	 if i=TP_OTH :return_ FR_ERR
	 ; �t�@�C���̑��݊m�F
	 if i!TP_CDA {
	  exist_ mFilePath
	  if stat!1 {
	   convert sss,langs.lgDlg_ErrorNotFound,"���y�t�@�C��","%format%"
	   convert ss,sss,mFilePath,"%file%"
	   gosub disable_allWnd
	   if mFileIdx=-1 {
	    convert s,ss,"","%confirm%"
	    dialog s,0,prgtitles
	   } else {
	    convert s,ss,langs.lgDlg_ConfirmClearFile,"%confirm%"
	    dialog s,2,prgtitles
	   }
	   if stat=6 :func=FNC_LIST_CLEAR+mFileIdx :gosub *exec_func
	   gosub enable_allWnd
	   return_ FR_ERR
	  }
	  exist mFilePath
	  if strsize=-1 :mFileSize=0 :else :mFileSize=strsize
	 }
	 ; �ǂݍ��݂ƍĐ��J�n
	 title_ "���y��ǂݍ���ł��܂�"+sep+prgtitles
	 gosub disable_allWnd
	 npfprop=0
	 repeat
	  ; Windows MCI �𗘗p
	  ;	s	/ �g���q(�啶��)
	  if type.i=PF_MCI {
	   ; CD �̂ݓ���
	   if mFileType&TPEX_CDA {
	    ; �h���C�u�����擾
	    s=mFilePath
	    strmid ss,s,0,3
	    ; �g���b�N�����擾
	    strlen i,s
	    repeat i
	     peek ii,s,cnt
	     if (ii>='a')&(ii<='z') :ii-=32
	     poke s,cnt,ii
	    loop
	    instr prm,s,"TRACK",0
	    instr prm.1,s,".CDA",0
	    prm+=5
	    strmid s,s,prm,prm.1-prm
	    int_ s
	    ;	im	/ �Đ�����g���b�N�ԍ�
	    ; �J��
	    mci "open "+ss+" alias "+mci_alias+" wait type cdaudio"
	    if stat!1 :dllret=1 :break
	    ; �Đ��Ɏg�p���Ă���d�g�݃��j���[�\�z
	    npfprop=1
	    imenu "MCI: CD-Audio",FNC_OPEN_WND|FNC_ON+widExt,0,hmMinfoSubPf
	    ; �Đ��J�n
	    mci "set "+mci_alias+" time format tmsf"
	    mci "status "+mci_alias+" number of tracks"
	    i=im+1
	    if i<=stat :s=" to "+i :else :s=""
	    mci "play "+mci_alias+" from "+im+s
	    ; �� time format milliseconds �ɂ���
	    ;		i=mci_cdatrackstart+mDuration
	    ;		mci "play "+mci_alias+" from "+mci_cdatrackstart+" to "+i
	    ;		if stat=-1 :dllret=1 :break
	    ; �@ �����s����ƂP�g���b�N�ōĐ����~�܂��Ă���Ȃ��H
	    ; ���ԒP�ʂ̐ݒ�ƑS���A�g���b�N�̊J�n�ʒu�̎擾
	    mci "set "+mci_alias+" time format milliseconds"
	    mci "status "+mci_alias+" length track "+im
	    mDuration=stat
	    mci "status "+mci_alias+" position track "+im
	    mci_cdatrackstart=stat
	    dllret=0 :break
	   }
	   ; �f�o�C�X���̎w����m�F
	   mci_device=""
	   instr i,types.TP_MCI,s+"("
	   if i!-1 {
	    strlen ii,s :i+=ii+1
	    instr ii,types.TP_MCI,")",i
	    if ii!-1&(ii<256) {
	     strmid mci_device,types.TP_MCI,i,ii
	     mci_device=" type "+mci_device
	    }
	   }
	   ; ���y�t�@�C�����J��
	   ss=mFilePath
	   s =""
	   prm=pss,ps,512
	   dllprocp FNC_GetShortPathNameA,prm,3
	   mci "open \""+s+"\" alias "+mci_alias+" wait"+mci_device
	   if stat=-1 :dllret=1 :break
	   ; �ȏ��̎擾
	   mci "info "+mci_alias+" name"	:mName=refstr
	   mci "info "+mci_alias+" copyright"	:mAuthor=refstr
	   mci "capability "+mci_alias+" device type" :mFormat=refstr
	   ; �Đ��Ɏg�p���Ă���d�g�݃��j���[�\�z
	   npfprop=1
	   imenu "MCI: "+mFormat,FNC_OPEN_WND|FNC_ON+widExt,0,hmMinfoSubPf
	   ; ���ԒP�ʂ̐ݒ�ƑS���̎擾
	   mci "set "+mci_alias+" time format milliseconds"
	   mci "status "+mci_alias+" length"
	   mDuration=stat
	   ; �Đ��J�n
	   mci "play "+mci_alias+" from 0"
	   dllret=0 :break
	  }
	  ; DirectX DirectShow �𗘗p
	  if type.i=PF_DXS {
	   if pCallMethod=0 :func=FNC_LOADLIB+IDX_LOAD_COM :gosub *exec_func
	   if dxs_clsid_FilterGraph=0 :func=FNC_LOADLIB+IDX_LOAD_DXS :gosub *exec_func
	   ; ���y�t�@�C���̎󂯎M�쐬
	   memcpy i ,dxs_clsid_FilterGraph,16
	   memcpy ii,dxs_iid_IGraphBuilder,16
	   prm=pi,0,1,pii
	   getptr prm.4,dxs_gb
	   dllprocp FNC_CoCreateInstance,prm,5
	   ; ���y�t�@�C���𗬂�����(IGraphBuilder->RenderFile)
	   s=mFilePath
	   uni s
	   prmex=ps,0
	   prm=pprmex,2,13,dxs_gb
	   ll_callfunc prm,4,pCallMethod
	   if dllret!0 :break
	   ; ���p�����t�B���^�̈ꗗ���擾(�V->EnumFilters)
	   gosub enum_filters
	   ; �Đ��Ɏg�p���Ă���d�g�݃��j���[�\�z
	   notesel tmp2
	   notemax npfprop
	   npfprop--		; �t�@�C���t�B���^�͏��O
	   repeat npfprop
	    noteget s,cnt
	    imenu s,FNC_OPEN_WND|FNC_ON+widExt+cnt,0,hmMinfoSubPf
	   loop
	   ; �g�p����C���^�[�t�F�[�X�̏���(IGraphBuilder->QueryInterface)
	   qi dxs_gb,dxs_mc,dxs_iid_IMediaControl
	   qi dxs_gb,dxs_ms,dxs_iid_IMediaSeeking
	   qi dxs_gb,dxs_ba,dxs_iid_IBasicAudio
	   ; ���ԒP�ʂ̐ݒ�(IMediaSeeking->SetTimeFormat)
	   ; prmex=pi
	   ; prm=pprmex,1,9,dxs_ms
	   ; ll_callfunc prm,4,pCallMethod
	   ; �S���̎擾(IMediaSeeking->)
	   prmex=pi
	   prm=pprmex,1,10,dxs_ms
	   ll_callfunc prm,4,pCallMethod
	   llconv mDuration,i
	   ; �Đ��J�n(IMediaControl->Run)
	   prm=0,0,7,dxs_mc
	   ll_callfunc prm,4,pCallMethod
	   dllret=0 :break
	  }
	  ; �O��DLL�𗘗p
	  if type.i=PF_DLL {
	   ; DDE
	   /*
	   if mFileType&TPEX_MID {
	    title_ "DDE: initializing"+sep+prgtitles
	    ; (1) DDE�ʐM�̑�����m�F
	    s =defdde_dir
	    ss=defdde_name
	    instr i,types.TP_MID,"("
	    if i!-1 {
	     i++
	     instr ii,types.TP_MID,")",i
	     if ii!-1&(ii<512) {
	      strmid s,types.TP_MID,i,ii
	      getfname s
	      ss=refstr
	      strmid s,s,0,stat
	     }
	     peek i,s,1
	     if i!':' :s=extdir+s
	    }
	    ; (2) DDE�̏�����
	    i=0
	    if s !dde_dir  :i=1
	    if ss!dde_name :i=1
	    if i&(dde_inst!0) :gosub uninit_dde
	    dde_dir=s
	    dde_name=ss
	    if dde_inst=0 {
	     func=FNC_LOADLIB|FNC_ON+IDX_LOAD_DDE :gosub *exec_func
	     if funcret=0 :dllret=1 :break
	    }
	    ; (3) DDE�ʐM�̊J�n
	    title_ "DDE("+dde_name+"): connecting"+sep+prgtitles
	    repeat
	     if dde_name="TMIDI" :funcopts="OWL_Window" :break
	     if dde_name="WFP" :funcopts="WFP Main Window Class" :break
	     break
	    loop
	    s=dde_name :ss=dde_name
	    ; s		/ �T�[�r�X��
	    ; ss	/ �g�s�b�N��
	    ; funcopts	/ �T�[�r�X��񋟂���v���O�����̃E�B���h�E�N���X
	    dde_hwnd=0
	    repeat 2
	     ; ���C����ʒT��
	     prm=pfuncopts,0
	     repeat cnt*9+1
	      if cnt!0 :wait 50
	      dllprocp FNC_FindWindowA,prm,2
	      if dllret :dde_hwnd=dllret :break
	     loop
	     ;  TMIDI �̏ꍇ
	     if dde_name="TMIDI" {
	      ; (��ʓI�ȃN���X���̃E�B���h�E�Ȃ̂Ő�����v����)
	      if dde_hwnd {
	       repeat cnt*9+1
	        if cnt!0 :wait 50
	        prm=dde_hwnd,ptmp,1024
	        dllprocp FNC_GetWindowTextA,prm,3
	        if dllret {
	         instr i,tmp,"TMIDI Player"
	         ; TMIDI Player �E�B���h�E�𔭌�
	         if i!-1 {
	          ; �B��
	          if cnt=1 {
	           prm.1=0
	           dllprocp FNC_CloseWindow,prm,1
	           dllprocp FNC_ShowWindow,prm,2
	           break
	          }
	         } else :dde_hwnd=0
	        }
	       loop
	      }
	     }
	     ; �ʐM�����݂�
	     dde_c s,ss
	     if dde_hconv :break
	     ; ��x�ʐM�Ɏ��s������v���O�����̋N�����玎�݂�
	     title_ "DDE("+dde_name+"): executing a DDE server"+sep+prgtitles
	     tmp=dde_dir+dde_name+".exe"
	     exist_ tmp
	     if stat!1 :break
	     sss="open"
	     prm=bmscr.13,psss,ptmp,0,0,1
	     ;  WFP �̏ꍇ
	     if dde_name="WFP" {
	      ; �S��ʔ�\���ł̋N��
	      string@arxmp_mod="/DM /DW /DS /DP /DQ"
	      prm.3=pstring@arxmp_mod
	     }
	     dllprocp FNC_ShellExecuteA,prm,6
	     dllprocp FNC_SetForegroundWindow,hwMainWnd,1
	    loop
	    if dde_hconv=0 :dllret=1 :break
	    ; Midi�t�@�C�����J��
	    title_ "DDE("+dde_name+"): opening a file"+sep+prgtitles
	    ss=mFilePath
	    s =""
	    prm=pss,ps,512
	    dllprocp FNC_GetShortPathNameA,prm,3
	    repeat
	     ; TMIDI Player �̏ꍇ
	     if dde_name="TMIDI" {
	      ; �Đ��̊J�n
	      dde_exec "lock"
	      dde_exec "playfile "+s
	      ; �ȏ��̎擾
	      ss=s
	      dde_req "getplayfile" :int_ s :dde_idx=im
	      dde_req "gettitle "+dde_idx
	      if s!ss :mName=s
	      ; �S���̎擾
	      dde_req "getlength "+dde_idx :int_ s
	      mDuration=im
	      if mDuration=0 {
	       dde_exec "unlock"
	       dde_dc
	       dllret=1 :break
	      }
	      dllret=0 :break
	     }
	     if dde_name="WFP" {
	      ; �Đ��̊J�n
	      dde_exec s+" /PLAY"
	      ; �ȏ��̎擾
	      ; (����)
	      ; �S���̎擾
	      ; (����)
	      dllret=0 :break
	     }
	     dllret=1 :break
	    loop
	    if dllret :break
	    ; �Đ��Ɏg�p���Ă���d�g�݃��j���[�\�z
	    npfprop=1
	    imenu "DDE: "+dde_name,FNC_OPEN_WND|FNC_ON+widExt,0,hmMinfoSubPf
	    dllret=0 :break
	   }
	   */
	   ; Vox.dll
	   if mFileType&TPEX_OGG {
	    ; OggVorbis�t�@�C�����J��
	    if D_VOX=0 {
	     func=FNC_LOADLIB|FNC_ON+IDX_LOAD_VOX :gosub *exec_func
	     if funcret=0 :dllret=1 :break
	    }
	    s=mFilePath
	    dllprocp FNC_vox_Load,ps,1
	    if dllret=-1 :break
	    vox_id=dllret
	    ; �Đ��Ɏg�p���Ă���d�g�݃��j���[�\�z
	    npfprop=1
	    imenu "Vox.dll",FNC_OPEN_WND|FNC_ON+widExt,0,hmMinfoSubPf
	    ; �ȏ��̎擾
	    prm=vox_id,pss,0
	    prscom mAuthor,"ARTIST"
	    prscom mName,"TITLE"
	    prscom mComment,"COMMENT"
	    prscom mComment,"DESCRIPTION"
	    prscom mRelDate,"DATE"
	    ; �S���̎擾
	    prm=vox_id,0
	    dllprocp FNC_vox_GetTotalTime,prm,1
	    mDuration=dllret
	    ; �Đ��J�n
	    dllprocp FNC_vox_SetLoop	,prm,2
	    dllprocp FNC_vox_Play	,prm,1
	    dllret=0 :break
	   }
	   ; vbmp3.dll
	   if mFileType&TPEX_MP3 {
	    ; MP3�t�@�C�����J��
	    if D_VBMP3=0 {
	     func=FNC_LOADLIB|FNC_ON+IDX_LOAD_VBMP3 :gosub *exec_func
	     if funcret=0 :dllret=1 :break
	    }
	    s=mFilePath
	    prm=ps,pss
	    dllprocp FNC_vbmp3_open,prm,2
	    if dllret=0 :dllret=1 :break
	    ; �Đ��Ɏg�p���Ă���d�g�݃��j���[�\�z
	    npfprop=1
	    imenu "vbmp3.dll",FNC_OPEN_WND|FNC_ON+widExt,0,hmMinfoSubPf
	    ; �ȏ��̎擾
	    ll_peek s,pss	:mName=s
	    ll_peek s,pss+128	:mAuthor=s
	    ; �S���̎擾
	    ll_peek4 i,pss+268
	    mDuration=i*1000
	    ; �Đ��J�n
	    dllprocp FNC_vbmp3_play	,prm,0
	    dllret=0 :break
	   }
	   dllret=1 :break
	  }
	  break
	 loop
	 if dllret!0 {
	  convert sss,langs.lgDlg_ErrorFormat,"���y","%format%"
	  convert ss,sss,mFilePath,"%file%"
	   if mFileIdx=-1 {
	    convert s,ss,"","%confirm%"
	    dialog s,0,prgtitles
	   } else {
	    convert s,ss,langs.lgDlg_ConfirmClearFile,"%confirm%"
	    dialog s,2,prgtitles
	   }
	  if stat=6 :func=FNC_LIST_CLEAR+mFileIdx :gosub *exec_func
	  gosub enable_allWnd
	  return_ FR_ERR
	 }
	 ; �N�����̍Đ��ӏ��Č�
	 if dispMainWnd&initializing {
	  mPosition=xstheader.14 :gosub apply_mPosition
	 }
	 title_ "���y�̍Đ����J�n���Ă��܂�"+sep+prgtitles
	 ; ���y�̏�� [2]
	 func=FNC_GETTAGINFO|FNC_AUTO+IDX_CUR :gosub *exec_func
	 ; �^�X�N�g���C�ɔ��f
	 if dispMainWnd&2!0|dispTrayicon :ttray mTasktray
	 ; �^�C�g���ɔ��f
	 dispTitle=1
	 ; �X�N���v�g�̎��s������
	 scrLine+=scrAreaShow_FileInfoLine
	 script=scrAreaShow_FileInfo+script
	 ; �Đ��J�n�҂�
	 mStatus=ST_PAUSED
	 gosub wait_mStatus
	 gosub enable_allWnd_
	 return_ FR_DONE
	}

; �\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\
; ���y�̈ꎞ��~/�ĊJ

	if funcid=FNC_PAUSE {
	 if mStatus=ST_CLOSED :return_ FR_ERR
	 ; �t�@�C����̊m�F
	 i=TPfromTPEX(mFileType)
	 ; �Đ��̈ꎞ��~/�ĊJ
	 repeat
	  ; Windows MCI �𗘗p
	  if type.i=PF_MCI {
	   if mStatus=ST_PLAYING {
	    if mFileType&TPEX_CDA {
	     mci "stop "+mci_alias
	     mci_cdapaused=1
	     break
	    }
	    mci "pause "+mci_alias :break
	   }
	   if mFileType&TPEX_CDA :mci_cdapaused=0
	   mci "play "+mci_alias
	   break
	  }
	  ; DirectX DirectShow �𗘗p
	  if type.i=PF_DXS {
	   ; �Đ��ꎞ��~(IMediaControl->Pause)
	   ;   �܂��͍ĊJ(�V �@�@�@�@�@->Run  )
	   prm=0,0,0,dxs_mc
	   prm.2=(mStatus=ST_PLAYING)+7
	   ll_callfunc prm,4,pCallMethod
	   break
	  }
	  ; �O��DLL�𗘗p
	  if type.i=PF_DLL {
	   ; DDE
	   /*
	   if mFileType&TPEX_MID {
	    if mStatus=ST_PLAYING {
	     if dde_name="TMIDI" :dde_exec "pause" :break
	     if dde_name="WFP" :dde_exec "/PAUSE" :break
	     break
	    }
	    if dde_name="TMIDI" :dde_exec "resume" :break
	    if dde_name="WFP" :dde_exec "/RESUME" :break
	    break
	   }
	   */
	   ; Vox.dll
	   if mFileType&TPEX_OGG {
	    if mStatus=ST_PLAYING {
	     dllprocp FNC_vox_Pause,vox_id,1
	     mStatus=ST_PAUSED
	     break
	    }
	    dllprocp FNC_vox_Play,vox_id,1
	    mStatus=ST_PLAYING
	    break
	   }
	   ; vbmp3.dll
	   if mFileType&TPEX_MP3 {
	    if mStatus=ST_PLAYING {
	     dllprocp FNC_vbmp3_pause,prm,0
	     mStatus=ST_PAUSED :break
	    }
	    dllprocp FNC_vbmp3_restart,prm,0
	    mStatus=ST_PLAYING :break
	   }
	   break
	  }
	  break
	 loop
	 return_ mStatus=ST_PAUSED
	}

; �\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\
; ���y�̒�~
;	����	funcopts, mFileIdx �̓��e��j�󂵂Ȃ� (FNC_PLAY �p�̔z��)
;		im �̓��e��j�󂵂Ȃ� (FNC_SET_PLAYFUNC �p�̔z��)

	if funcid=FNC_STOP {
	 if mStatus=ST_CLOSED :return_ FR_DONE
	 ; �t�@�C����̊m�F
	 i=TPfromTPEX(mFileType)
	 ; �Đ���~
	 repeat
	  ; Windows MCI �𗘗p
	  if type.i=PF_MCI {
	   if mFileType&TPEX_CDA :mci_cdapaused=0
	   ; �Đ���~
	   mci "stop "+mci_alias
	   ; �g�p�����f�o�C�X�̉��
	   mci "close "+mci_alias
	   break
	  }
	  ; DirectX DirectShow �𗘗p
	  if type.i=PF_DXS {
	   ; �Đ���~(IMediaControl->Stop)
	   prm=0,0,9,dxs_mc
	   ll_callfunc prm,4,pCallMethod
	   ; �g�p�����C���^�[�t�F�[�X�̉��
	   ri dxs_gb
	   ri dxs_mc
	   ri dxs_ms
	   ri dxs_ba
	   break
	  }
	  ; �O��DLL�𗘗p
	  if type.i=PF_DLL {
	   ; DDE
	   /*
	   if mFileType&TPEX_MID {
	    repeat
	     if dde_name="TMIDI" {
	      dde_exec "stop"
	      dde_exec "unlock"
	      ; if dde_hwnd {
	      ;  prm=dde_hwnd,1
	      ;  dllprocp FNC_ShowWindow,prm,2
	      ; }
	      break
	     }
	     if dde_name="WFP" :dde_exec "/STOP" :break
	     break
	    loop
	    if dispMainWnd&closing {
	     gosub uninit_dde
	    } else :dde_dc
	    break
	   }
	   */
	   ; Vox.dll
	   if mFileType&TPEX_OGG {
	    dllprocp FNC_vox_Release	,vox_id,1
	    dllprocp FNC_vox_Delete	,vox_id,1
	    break
	   }
	   ; vbmp3.dll
	   if mFileType&TPEX_MP3 {
	    dllprocp FNC_vbmp3_stop	,prm,0
	    dllprocp FNC_vbmp3_close	,prm,0
	    break
	   }
	   break
	  }
	  break
	 loop
	 ; �ϐ��Ȃǂ̏�����
	 mFileType=0
	 mPosition=0
	 mStatus=ST_CLOSED
	 repeat npfprop :dmenu hmMinfoSubPf,FNC_OPEN_WND|FNC_ON+widExt+cnt :loop
	 ; �v���O�C���Ȃǂɒʒm
	 gosub notify_mStatus
	 ; �^�C�g���ɔ��f
	 dispTitle=TI_TITLE
	 return_ FR_DONE
	}

; �\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\
; �Đ����[�h��ύX

	if funcid=FNC_MODE {
	 ; (1) �Đ����X�g�̌J�Ԃ��Đ�
	 if funcopt=PM_REPLIST {
	  if func&FNC_CHANGE {
	   if func&FNC_AUTO :lMode=lMode^PM_REPLIST :else {
	    lMode=lMode&$F+(func&FNC_ON!0*PM_REPLIST)
	   }
	   ; �X�N���v�g�̎��s������
	   scrLine+=scrAreaShow_ModeExLine
	   script=scrAreaShow_ModeEx+script
	  }
	  ; �`�F�b�N���X�V
	  ;  ���j���[
	  i=lMode&PM_REPLIST!0
	  if func&FNC_CHANGE|(dispMainWnd&initializing) {
	   mii.1=1 :mii.3=8*i :setmii hmSetPlay,FNC_OBJ402+objList_ChangeListLoop
	  }
	  ;  �`�F�b�N�{�b�N�X
	  if func&(FNC_CHANGE|FNC_REFRESH) {
	   repeat snChk
	    ii=chkid.cnt
	    if obj.ii^func&$FF00FFFF=0 :objprm ii,i
	    chk_.cnt=chk.cnt
	   loop
	  }
	  return_ lMode&PM_REPLIST!0
	 }
	 ; (2) �Đ����[�h
	 if func&FNC_CHANGE|(dispMainWnd&initializing) {
	  ; ���j���[��������̃`�F�b�N���O��
	  mii.1=1 :mii.3=0 :setmii hmMode,FNC_MODE|FNC_ON+(lMode&$F)
	  if func&FNC_CHANGE {
	   ; �Đ����[�h�l��ύX
	   if func&FNC_AUTO {
	    lMode=lMode&$F0+(lMode&$F+1\6)
	   } else {
	    lMode=lMode&$F0+(funcopt\6)
	   }
	   ; �^�C�g���ɔ��f����
	   i=lMode&$F+lgPMTI
	   title_ ""+langs.i+sep+prgtitles
	   ; �X�N���v�g�̎��s������
	   scrLine+=scrAreaShow_ModeLine
	   script=scrAreaShow_Mode+script
	  }
	  ; ���j���[�Ƀ`�F�b�N��t��
	  mii.1=1 :mii.3=8 :setmii hmMode,FNC_MODE|FNC_ON+(lMode&$F)
	 }
	 return_ lMode&$F
	}

; �\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\
; ���ʂ�ύX
/*
	if funcid=FNC_VOLUME {
	 ; ������
	}
*/

; �\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\
; �Đ��ʒu��ύX
;	����	�b�P�ʂ̎w�肵���ł��Ȃ��B

	if funcid=FNC_SEEK {
	 if mStatus=ST_CLOSED :return_ FR_ERR
	 ; �Đ��ʒu�̐ݒ�
	 mPosition=funcopt*1000
	 gosub apply_mPosition
	 gosub wait_mStatus
	 return_ FR_DONE
	}

; �\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\
; ���y�t�@�C���̃^�O�����擾
;	���������p

	if funcid=FNC_GETTAGINFO {
	 ; mp3infp.dll �𗘗p���ĉ��y�����擾
	 if D_MP3INFP {
	  if mFileType&(TPEX_MID|TPEX_CDA)=0 {
	   s=mFilePath
	   prm=0,ps :dllprocp FNC_mp3infp_Load,prm,2
	   if mFileType&TPEX_MP3 {
	    dllprocp FNC_mp3infp_mp3_GetTagType,prm,0
	    repeat
	     if dllret&4 :s="_rmp" :break
	     if dllret&2 :s="_v2" :break
	     if dllret&1 :s="_v1" :break
	     break
	    loop
	   } else :s=""
	   prm=pss,pi
	   getval mAuthor,"IART"+s
	   getval mName,"INAM"+s
	   getval mAlbumName,"IPRD"+s
	   getval mRelDate,"ICRD"+s
	   getval mComment,"ICMT"+s
	   getval mFormat,"AFMT"
	   repeat
	    if s="_v1" :break
	    getval tmp,"ICOP"+s
	    if tmp!"" :mAuthor+=" / "+tmp
	    break
	   loop
	  }
	 } else {
	  ; ���͂�MP3�������
	  if mFileType&TPEX_MP3 {
	   bload mFilePath,tmp,128,mFileSize-128
	   strmid s,tmp,0,3
	   if s="TAG" {
	    strmid mAuthor,tmp,33,30	; minfo_.1
	    strmid mName,tmp,3,30	;        2
	    strmid mComment,tmp,97,30	;        3
	    strmid mAlbumName,tmp,63,30	;        5
	    strmid mRelDate,tmp,93,4	;        6
	    prm=1,30
	    repeat 6
	     repeat prm.1,1
	      peek i,minfo_.prm,prm.1-cnt
	      if i=' ' {
	       poke minfo_.prm,prm.1-cnt,0
	      } else :break
	     loop
	     prm++
	     if prm=4 :prm++
	     if prm=6 :prm.1=4
	    loop
	   }
	  }
	 }
	 ; ���͂�Midi�������
	 if mFileType&TPEX_MID {
	  ; �ȏ��̎擾
	  bload mFilePath,prm,16
	  ;  (1) �w�b�_��\��4�o�C�g(������ɒ����� MThd )�̊m�F
	  if prm=$6468544D {
	   ; (2) ���̑��w�b�_���̎擾
	   ; prm.1	/ ���̑��w�b�_���̃T�C�Y
	   ; prm.2	/ �O2�o�C�g �t�H�[�}�b�g
	   ;		/ ��2�o�C�g �g���b�N��
	   ; �� �Ⴆ�� 00 01 �� $ 01 00 �̂悤�ɁA1byte���Ƃɋt����
	   ; �@ �ϐ��ɓ����Ă��邽�� word, dword �}�N���ŕϊ����Ă���
	   i =word(prm.2) :prm.2=prm.2>>16
	   ii=word(prm.2)
	   mFormat="MIDI(format-"+i+") "+ii+"�g���b�N"
	   ; (3) �g���b�N�f�[�^�̎擾
	   i=dword(prm.1)+8
	   ; i		/ �g���b�N�f�[�^�J�n�ʒu
	   bload mFilePath,prm,16,i
	   if prm=$6B72544D {
	    i+=8
	    ii=dword(prm.1)
	    ; i		/ �g���b�N�f�[�^�̒��g�J�n�ʒu
	    ; ii	/ �g���b�N�f�[�^�̒��g�T�C�Y
	    bload mFilePath,tmp,ii,i
	    prm=0,0
	    ; prm	/ ��͒��̈ʒu
	    ; prm.1	/ �Ō�ɉ�͂����C�x���g�̃T�C�Y
	    repeat
	     ; �f���^�^�C��
	     repeat 4
	      peek i,tmp,prm :prm++
	      if i&$80=0 :break
	     loop
	     ; �C�x���g
	     peek i,tmp,prm :prm++
	     ;  �ϒ��f�[�^
	     if i&$F0=$F0 {
	      ;  ���^�C�x���g
	      if i=$FF {
	       peek i,tmp,prm :prm++
	       gosub get_delta
	       ; i	/ ���^�C�x���g�̎��
	       ;	$02	/ ���쌠�\��
	       if i=2 :strmid mAuthor,tmp,prm,prm.1
	       ;	$03	/ �ȃ^�C�g��
	       if i=3 :strmid mName,tmp,prm,prm.1
	       ;	$01	/ �C�ӂ̃e�L�X�g
	       if i=1 :strmid mComment,tmp,prm,prm.1
	       ;	$2F	/ �g���b�N�̏I�[
	       if i=$2F :break
	      ;  SysEx�C�x���g
	      } else :gosub get_delta
	     ;  ����ȊO�̃f�[�^(MIDI�C�x���g�Ȃ�)
	     } else {
	      ; �����j���O�X�e�[�^�X���K�p
	      if i&$80 {
	       prm.1=1
	       i=i>>8
	       if i!$C&(i!$D) :prm.1++
	      ; �����j���O�X�e�[�^�X�K�p
	      ; (�C�x���g�̃T�C�Y����O�Ɠ���)
	      } else :prm--
	     }
	     prm+=prm.1
	     if prm>=ii :break
	    loop
	   }
	  }
	 }
	 ; �X�N���[�����e�ƃ��j���[���ڂ��X�V
	 gosub get_mscroll
	 tmenu "�����: "+mAuthor,FNC_CLIP+IDX_CLIP_MINFO+1,hmMinfo
	 tmenu "�^�C�g��: "+mName,FNC_CLIP+IDX_CLIP_MINFO+2,hmMinfo
	 tmenu "�t�@�C����: "+mFileName,FNC_CLIP+IDX_CLIP_MINFO+0,hmMinfo
	 return_ FR_DONE
	}

; �\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\
; ���y�̍Đ����(�ƍĐ��ʒu)���擾

	if funcid=FNC_GETSTATE {
	 if mStatus=ST_CLOSED :return_ ST_CLOSED
	 im=mStatus
	 mStatus=ST_CLOSED
	 ; �t�@�C����̊m�F
	 i=TPfromTPEX(mFileType)
	 ; �Đ���ԂƍĐ����ʒu�̎擾
	 repeat
	  ; Windows MCI �𗘗p
	  if type.i=PF_MCI {
	   ; �Đ��ʒu�̎擾
	   mci "status "+mci_alias+" position"
	   if mFileType&TPEX_CDA {
	    mPosition=stat-mci_cdatrackstart
	   } else :mPosition=stat
	   ; �Đ���Ԃ̎擾
	   if mDuration=0 :mStatus=ST_PLAYING :break
	   if mPosition>=mDuration :mStatus=ST_STOPPED :break
	   mci "status "+mci_alias+" mode"
	   if refstr="playing" :mStatus=ST_PLAYING :break
	   if refstr="stopped" {
	    if mci_cdapaused=0 :mStatus=ST_STOPPED :break
	   }
	   mStatus=ST_PAUSED :break
	  }
	  ; DirectX DirectShow �𗘗p
	  if type.i=PF_DXS {
	   ; �Đ��ʒu�̎擾(MediaSeeking->GetCurrentPosition)
	   if mDuration=0 :mStatus=ST_PLAYING :break
	   i=0,0,0,0
	   prmex=pi
	   prm=pprmex,1,12,dxs_ms
	   ll_callfunc prm,4,pCallMethod
	   llconv mPosition,i
	   ; �Đ���Ԃ̎擾(IMediaControl->GetState)
	   prmex=500,pi
	   prm=pprmex,2,10,dxs_mc
	   ll_callfunc prm,4,pCallMethod
	   if i=1 :mStatus=ST_PAUSED	:break
	   ; ���y�̏I���͍Đ��ʒu�Ŕ��f����
	   if i=2 {
	    if mPosition>=mDuration :mStatus=ST_STOPPED :break
	    mStatus=ST_PLAYING	:break
	   }
	   break
	  }
	  ; �O��DLL�𗘗p
	  if type.i=PF_DLL {
	   ; DDE
	   /*
	   if mFileType&TPEX_MID {
	    if dde_name="TMIDI" {
	     ; �ȏ��̊m�F(���Ƀt�@�C���Đ����΍�)
	     dde_req "getplayfile" :int_ s
	     if im!dde_idx {
	      dde_idx=im
	      dde_req "gettitle "+im :mName=s
	      dde_req "getlength "+im :int_ s :mDuration=im
	      func=FNC_GETTAGINFO|FNC_AUTO+IDX_CUR :gosub *exec_func
	      scrLine+=scrAreaShow_FileInfoLine
	      script=scrAreaShow_FileInfo+script
	     }
	     ; �Đ��ʒu�Ə�Ԃ̎擾
	     dde_req "gettime" :int_ s :mPosition=im
	     dde_req "getstatus"
	     if s="play" :mStatus=ST_PLAYING :break
	     if s="pause":mStatus=ST_PAUSED :break
	     mStatus=ST_STOPPED :break
	    }
	    if dde_name="WFP" {
	     ; �Đ���Ԃ̎擾
	     dde_req "PlayStatus"
	     if s="Play" :mStatus=ST_PLAYING :break
	     if s="Pause":mStatus=ST_PAUSED :break
	     mStatus=ST_STOPPED :break
	    }
	    break
	   }
	   */
	   ; Vox.dll
	   if mFileType&TPEX_OGG {
	    dllprocp FNC_vox_GetCurrentTime,vox_id,1
	    mPosition=dllret
	    dllprocp FNC_vox_GetStatus,vox_id,1
	    if dllret=1 :mStatus=ST_PLAYING :break
	    if dllret=0&(mStatus!ST_PAUSED) :mStatus=ST_STOPPED :break
	    break
	   }
	   ; vbmp3.dll
	   if mFileType&TPEX_MP3 {
	    dllprocp FNC_vbmp3_getState,pi,1
	    mPosition=i*1000
	    mStatus=dllret+1
	    break
	   }
	   break
	  }
	  break
	 loop
	 ; �v���O�C���Ȃǂɒʒm
	 if im!mStatus :gosub notify_mStatus
	 return_ mStatus
	}

; �\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\
; �Đ����X�g�̕\�����X�V

	if funcid=FNC_LIST_REFRESH {
	 funcret=FR_DONE
	 title "�Đ����X�g�̕\�����X�V���Ă��܂�"+sep+prgtitles
	 gosub disable_allWnd
	 ; ���X�g�{�b�N�X�̕\�����e���č쐬
	 if lReqRefresh|(func&FNC_ON) {
	  lReqRefresh=0
	  notesel list
	  notemax lNum
	  lLength=0
	  list_=""
	  ; �\�����e���擾
	  repeat lNum
	   await
	   noteget s,cnt
	   ; �� �Đ����̉��y�̃C���f�b�N�X��ǔ�
	   if s=mFilePath :mFileIdx=cnt
	   getfname s
	   lLength+=im-stat+2
	   ; ���X�g�ɕ\���ł��镶�����̌��E�ɒ���
	   if lLength>bufmax {
	    lLength-=im-stat+2
	    dialog langs.lgDlg_ErrorTooManyFiles,0,prgtitles
	    ; �ȍ~�̍s���폜
	    repeat lNum-cnt,cnt
	     notedel lNum-cnt
	    loop
	    funcret=FR_ERR
	    break
	   }
	   list_+=refstr+"\n"
	  loop
	 }
	 ; ��ʂɔ��f����
	 gosub get_listobjid
	 if i!-1 {
	  gsel lWid
	  lsi_backup
	  objprm i,list_
	  lsi_restore i
	  gsel sWid
	 }
	 ; �^�C�g���ɔ��f����
	 title_ ""+lNum+" �t�@�C��"+sep+prgtitles
	 gosub enable_allWnd
	 return_
	}

; �\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\
; �Đ����X�g��(notedata(func&FNC_AUTO=0 �Ȃ� funcopts))��ǉ�
;	���������p
;	����	��ʂ��g�p�s�ɂ����A���̂܂ܕ��u����
;		��� FNC_REFRESH �Ń��X�g�̕\�����X�V����K�v������

	if funcid=FNC_LIST_ADD {
	 gosub disable_allWnd
	 lReqRefresh=1
	 notesel list
	 ; �� �I�𒆂̉��y�̃C���f�b�N�X��ǔ�
	 if lSelectedIdx!-1 {
	  noteget s,lSelectedIdx
	  instr funcopt,list,s+"\n",0
	 } else :funcopt=-1
	 tmp=""
	 if func&FNC_AUTO=0 {
	  strlen i,funcopts :sdim notedata,i+1
	  notedata=funcopts :funcopts=""
	 } else {
	  if func&FNC_STR=0 :funcopts=""
	 }
	 ; funcopt	/ �I�𒆂̉��y�̈ʒu
	 ; notedata	/ �ǉ�����t�@�C���ꗗ
	 ; tmp		/ �ǉ�����t�H���_�ƃ��X�g�t�@�C���ꗗ
	 ; funcopts	/ (notedata)���t�@�C���̐e�t�H���_
	 repeat :await
	  if cnt {
	   ; ��������t�H���_�̎擾(ss)
	   notecut_ ss,tmp
	   if stat=0 :break
	   title ""+cnt+". "+ss
	   ; ���X�g�t�@�C���ƃt�H���_�̔���
	   gettype ss
	   if stat=TPEX_XLT {
	    notesel notedata
	    noteload ss :funcopts=""
	    ; �Ȉ�EXCEL�e���v���[�g�t�@�C���p�t�B���^
	    wpeek i,notedata
	    if i=$CFD0 :continue
	    ; (���w�b�_��$CFD0)
	    notesel list
	   } else {
	    ; ���ݔ��̒��g�p�t�B���^
	    strlen i,ss
	    strmid s,ss,3,8
	    if s="RECYCLER" :continue
	    ; (���t�H���_���Ń`�F�b�N)
	    funcopts=ss+"\\"
	    dirlist notedata,funcopts+"*.*"
	   }
	  }
	  ; �t�@�C���ƃt�H���_�̔���
	  repeat
	   notecut_ s,notedata
	   if stat=0 :break
	   s=funcopts+s
	   exist_ s
	   if stat=-1 {
	    if lSearchType&TPEX_DIR|(func&FNC_ON=0) :tmp+=s+"\n"
	    continue
	   } else {
	    ; �t�@�C����̊m�F
	    if func&FNC_ON {
	     gettype s
	     if stat=0 :continue	; ��Ή�
	     if stat&$FFFFF000!0 {	; ���y�t�@�C���łȂ�
	      if stat=TPEX_XLT {	; ���X�g�t�@�C��
	       if lSearchType&TPEX_XLT|(func&FNC_ON=0) :tmp+=s+"\n"
	      }
	      continue
	     } else {			; ���y�t�@�C��
	      if lSearchType&stat=0&(func&FNC_ON!0) :continue
	     }
	    }
	    ; �t�@�C���̏d���m�F
	    instr i,list,s+"\n"
	    ; (1) �d������
	    if i=-1 {
	     noteadd s,lNum
	     lNum++
	    ; (2) �d��
	    } else {
	     ; �d���t�@�C�����ŉ��s�Ɉړ�����I�v�V�����̊m�F
	     if lDownDblItem=0 :continue
	     ; �d���t�@�C�����ŉ��s�Ɉړ�
	     s+="\n"
	     strlen ii,s
	     strlen iii,list
	     memcpy list,list,iii-i-ii,i,i+ii
	     poke list,iii-ii,s
	     poke list,iii,0
	     if funcopt>=0 {
	      if funcopt=i :funcopt=iii-ii-2 :lSelectedIdx=lNum-1 :else {
	       if funcopt>i :funcopt-=ii :lSelectedIdx--
	      }
	     }
	    }
	   }
	   await
	  loop
	 loop
	 sdim notedata,bufnd
	 return_ lNum
	}

; �\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\
; �Đ����X�g�Ƀt�@�C����ǉ�

	if funcid=FNC_LIST_ADD_FILE {
	 gosub disable_allWnd
	 ; �t�@�C�����w�肳��Ă��Ȃ���΃_�C�A���O��\��
	 if func&FNC_STR=0 {
	  ; �t�@�C���g���q�t�B���^����
	  s="�ǂݍ��߂�S�Ẳ��y�t�@�C��|"
	  sss=""
	  i=lgTP
	  repeat TP_PLAYABLE
	   if types.cnt!"" {
	    convert ss,types.cnt,";*."," "
	    ; �J�b�R ( ) �𖳎�
	    strlen ii,ss :prm=0
	    repeat
	     instr iii,ss,"(",prm
	     if iii=-1 {
	      break
	     } else {
	      prm+=iii
	      instr iii,ss,")",prm
	      iii++
	      ii-=iii
	      strmid tmp,ss,prm+iii,ii-prm
	      strmid ss,ss,0,prm
	      ss+=tmp
	     }
	    loop
	    ; �t�B���^�ɒǉ�
	    sss+=langs.i+"|*."+ss+"|"
	    s+="*."+ss+";"
	   }
	   i++
	  loop
	  s+="|"+sss
	  ; �t�B���^�� | ��S�� (null) �ɕϊ�
	  strlen i,s
	  repeat i
	   peek ii,s,cnt
	   if ii='|' :poke s,cnt,0
	  loop
	  ; GetOpenFileNameA
	  tmp=""
	  tmp2=""
	  ss=lCurDir
	  sss="���y�t�@�C�����J��"
	  prm=76,bmscr.13,bmscr.14,ps,0,0,1,ptmp2,bufmax-1,ptmp,bufmax-1,pss,psss,$81204,0,0,0,0,0
	  dllprocp FNC_GetOpenFileNameA,pprm,1
	  if dllret {
	   i=(prm.14>>16)&$FFFF
	   ; ��̃t�@�C���̂ݑI�����ꂽ
	   if i {
	    ; tmp2	/ �I�����ꂽ�t�@�C���̃t���p�X(�Ɗg���q)
	    ; tmp	/ �I�����ꂽ�t�@�C���̖��O
	    strlen i,tmp2
	    strlen ii,tmp
	    strmid lCurdir,tmp2,0,i-ii
	    funcopts=tmp2
	   ; �����̃t�@�C�����I�����ꂽ
	   } else {
	    ; tmp2	/ �I�����ꂽ�t�@�C���������Ă����t�H���_�̃t���p�X
	    peek lCurdir,tmp2
	    strlen ii,lCurdir
	    lCurdir+="\\"
	    ;		/ �ƁA�I�����ꂽ�t�@�C���̖��O(����)
	    sdim notedata,bufmax
	    i=0 :ii++
	    repeat ,ii
	     ; i	/ notedata(�R�s�[��)�̕�����
	     ; ii	/ tmp2(�R�s�[��)�̃t�@�C�����J�n�I�t�Z�b�g
	     peek iii,tmp2,cnt
	     if iii=0 {
	      prm=cnt-ii; �t�@�C��������̕�����
	      memcpy notedata,tmp2,prm,i,ii	; �t�@�C�����R�s�[
	      wpoke notedata,i+prm,2573		; '\n' ��������
	      peek iii,tmp2,cnt+1
	      if iii=0 :wpoke notedata,i+prm+2,0 :break
	      i+=prm+2
	      ii=cnt+1
	     }
	    loop
	    ; notedata	/ �I�����ꂽ�t�@�C���̖��O(����)
	    funcopts=lCurdir
	    func=FNC_LIST_ADD|FNC_AUTO|FNC_STR	:gosub *exec_func
	    func=FNC_LIST_REFRESH		:gosub *exec_func
	    return_
	   }
	  } else :gosub enable_allWnd :return_ FR_ERR
	 }
	 ; funcopts	/ ���X�g�ɒǉ�����t�@�C���̃t���p�X
	 funcret=FR_DONE
	 notesel list
	 getfname funcopts
	 ; �t�@�C���̏d���m�F
	 instr i,list,funcopts+"\n"
	 ; (1) �d������
	 if i=-1 {
	  ; ���X�g�ɕ\���ł��镶�����̌��E�ɒ���
	  lLength+=im-stat+2
	  if lLength>bufmax {
	   lLength-=im-stat+2
	   dialog langs.lgDlg_ErrorTooManyFiles,0,prgtitles
	   funcret=FR_ERR
	  } else {
	   ; �t���p�X���ƃt�@�C�������
	   list+=funcopts+"\n"
	   list_+=refstr+"\n"
 	   ; ��ʂɔ��f����
	   gosub get_listobjid
	   if i!-1 {
	    gsel lWid
	    lsi_backup
	    s=refstr :objsend i,lisLB*LB_ADDSTRING+(lisCB*CB_ADDSTRING),0,s,0
	    lsi_restore i
	    gsel sWid
	   }
	   lNum++
	  }
	 ; (2) �d��
	 } else {
	  ; �d���t�@�C�����ŉ��s�Ɉړ�����I�v�V�����̊m�F
	  if lDownDblItem {
	   ; �d���t�@�C�������݂���s�����擾
	   if i=0 :prm=0 :else {
	    ii=0 :prm=-1
	    repeat i,1
	     instr iii,list,"\n",ii
	     if iii=-1 :break
	     ii+=iii+2
	     if ii>=i :prm=cnt :break
	    loop
	   }
	   ; �d���t�@�C�����ŉ��s�Ɉړ�
	   ; �� �Đ����̉��y�̃C���f�b�N�X��ǔ�
	   if prm<mFileIdx :mFileIdx-- :else {
	    if prm=mFileIdx :mFileIdx=lNum-1
	   }
	   ; �� �I�𒆂̉��y�̃C���f�b�N�X��ǔ�
	   if prm<lSelectedIdx :lSelectedIdx-- :else {
	    if prm=lSelectedIdx :lSelectedIdx=lNum-1
	   }
	   ; �t���p�X���
	   notedel prm
	   noteadd funcopts,lNum-1
	   ; �t�@�C�������
	   notesel list_
	   notedel prm
	   noteadd refstr,lNum-1
 	   ; ��ʂɔ��f����
	   gosub get_listobjid
	   if i!-1 {
	    gsel lWid
	    lsi_backup
	    ; ���X�g�{�b�N�X�̕\��
	    ii=0 :objsend i,lisLB*LB_DELETESTRING+(lisCB*CB_DELETESTRING),prm,ii,0
	    s=refstr :objsend i,lisLB*LB_ADDSTRING+(lisCB*CB_ADDSTRING),0,s,0
	    lsi_restore i
	    gsel sWid
	   }
	  }
	 }
	 ; �^�C�g���ɔ��f����
	 title_ ""+lNum+" �t�@�C��"+sep+prgtitles
	 gosub enable_allWnd
	 return_
	}

; �\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\
; �Đ����X�g�Ƀt�H���_���t�@�C����ǉ�

	if funcid=FNC_LIST_ADD_FOLDER {
	 ; �t�H���_���w�肳��Ă��Ȃ���΃_�C�A���O��\��
	 if func&FNC_STR=0 {
	  gosub disable_allWnd
	  ; �����t�H���_���w�肷�邽�߂̃R�[���o�b�N�֐�������
	  if pCallbackFunc=0 {
	   func=FNC_LOADLIB|IDX_LOAD_COM :gosub *exec_func
	  }
	  ; �_�C�A���O�̕\��
	  s=""
	  ss=langs.lgDlg_Folder
	  tmp=lCurdir
	  prmex=ptmp,pfunc.FNC_SendMessageA
	  prm=bmscr.13,0,ps,pss,3,pCallbackFunc,pprmex,0
	  dllprocp FNC_SHBrowseForFolderA,pprm,1
	  if dllret=0 :gosub enable_allWnd :return_ FR_ERR
	  ; PIDL ����p�X���擾
	  prm=dllret,ps
	  dllprocp FNC_SHGetPathFromIDListA,prm,2
	  funcopts=s
	  ; PIDL �Ɏg�p���ꂽ�������̈�̉��
	  prmex=prm
	  ;  IMalloc �C���^�[�t�F�[�X�̎擾
	  dllprocp FNC_SHGetMalloc,pi,1
	  ;  IMalloc->Free ���\�b�h�ɂ�胁�����̈�����
	  prm=pprmex,1,5,i
	  ll_callfunc prm,4,pCallMethod
	  ;  IMalloc �C���^�[�t�F�[�X�����
	  ri i
	 }
	 ; ���X�g�Ƀt�H���_���t�@�C����ǉ�
	 strmid s,funcopts,-1,1
	 if s!"\\" :funcopts+="\\"
	 dirlist notedata,funcopts+"*.*"
	 lCurdir=funcopts
	 func=FNC_LIST_ADD|FNC_AUTO|FNC_STR|FNC_ON :gosub *exec_func
	 func=FNC_LIST_REFRESH :gosub *exec_func
	 return_
	}

; �\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\
; �Đ����X�g�̕��ёւ�

	if funcid=FNC_LIST_SORT {
	 gosub disable_allWnd
	 ; �� �I�𒆂̉��y�̃C���f�b�N�X��ǔ� (1)
	 if lSelectedIdx!-1 {
	  notesel list
	  noteget s,lSelectedIdx
	 }
	 strsort list
	 ; �� �I�𒆂̉��y�̃C���f�b�N�X��ǔ� (2)
	 if lSelectedIdx!-1 {
	  notenum_ s,list :lSelectedIdx=stat
	 }
	 lReqRefresh=1
	 func=FNC_LIST_REFRESH :gosub *exec_func
	 title_ "���X�g���ڂ𖼑O���ɕ��ёւ��܂���"+sep+prgtitles
	 return_ FR_DONE
	}

; �\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\
; �Đ����X�g���̃t�@�C���̑��݊m�F

	if funcid=FNC_LIST_CHECK {
	 gosub disable_allWnd
	 notesel list
	 prm=0,0
	 ii=lNum
	 repeat lNum,1
	  i=cnt*100/ii :if i!prm :prm=i :title ""+prm+"%"
	  i=ii-cnt
	  noteget s,i
	  gettype s
	  if stat&TPEX_CDA :continue
	  exist_ s
	  if stat!1 {
	   prm.1++
	   notedel i
	   ; �� �I�𒆂̉��y�̃C���f�b�N�X��ǔ�
	   if i<=lSelectedIdx :lSelectedIdx--
	   lNum--
	   continue
	  }
	 loop
	 if prm.1 {
	  lReqRefresh=1
	  func=FNC_LIST_REFRESH :gosub *exec_func
	 } else :gosub enable_allWnd
	 title_ "���݂��Ȃ����y�t�@�C�����Đ����X�g���珜���܂���"+sep+prgtitles
	 return_ FR_DONE
	}

; �\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\
; ���X�g���̍��ڂ��폜

	if funcid=FNC_LIST_CLEAR {
	 ; �S���ڂ��폜
	 if func&FNC_ALL {
	  gosub disable_allWnd
	  if func&FNC_AUTO=0 {
	   dialog langs.lgDlg_ConfirmClearAll,2,prgtitles
	   if stat=7 :gosub enable_allWnd :return_ FR_ERR
	  }
	  list=""
	  lReqRefresh=1
	  func=FNC_LIST_REFRESH :gosub *exec_func
	  return_ FR_DONE
	 }
	 ; �ꍀ�ڂ��폜
	 ;  �폜�Ώۂ��擾
	 gosub get_mpath
	 if funcopt=-1 :return_ FR_ERR
	 ;  �폜
	 ;   �t���p�X���
	 notesel list
	 notedel funcopt
	 ;   �t�@�C�������
	 notesel list_
	 notedel funcopt
	 ; �� �Đ����̉��y�̃C���f�b�N�X��ǔ�
	 if funcopt<=mFileIdx :mFileIdx--
	 ; �� �I�𒆂̉��y�̃C���f�b�N�X��ǔ�
	 if funcopt<lSelectedIdx|(funcopt+1=lNum) :lSelectedIdx--
	 lNum--
	 getfname funcopts
	 lLength-=im-stat+2
	 ;  ��ʂɔ��f����
	 gosub get_listobjid
	 if i!-1 {
	  gsel lWid
	  lsi_backup
	  prm=0 :objsend i,lisLB*LB_DELETESTRING+(lisCB*CB_DELETESTRING),funcopt,prm,0
	  lsi_restore i
	  gsel sWid
	 }
	 ;  �^�C�g���ɔ��f����
	 title_ ""+lNum+" �t�@�C��"+sep+prgtitles
	 return FR_DONE
	}

; �\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\
; �Đ����X�g���̉��y�t�@�C�������ݔ��ɔp��

	if funcid=FNC_LIST_DELETE {
	 ; �폜�Ώۂ��擾
	 gosub get_mpath
	 if funcopt=-1 :return_ FR_ERR
	 ; �t�@�C����̊m�F
	 gettype funcopts
	 if stat&TPEX_CDA :return_ FR_ERR
	 ; �폜
	 gosub disable_allWnd
	 exist_ funcopts
	 if stat>0 {
	  convert s,langs.lgDlg_ConfirmDelete,funcopts,"%file%"
	  dialog s,2,prgtitles
	  if stat=6 {
	   ; s �̓��e����x��ɂ��Ă����Ȃ��ƌ듮����N����
	   memset s,0,szs
	   i=0 :getptr pi,i
	   s=funcopts
	   prm=hwProcess,3,ps,0,$50,pi,0,0
	   dllprocp FNC_SHFileOperationA,pprm,1
	  } else :dllret=1
	 } else :dllret=0
	 ; ����
	 if dllret=0 {
	  func=FNC_LIST_CLEAR+funcopt :gosub *exec_func
	  funcret=FR_DONE
	 } else :funcret=FR_ERR
	 gosub enable_allWnd
	 return_
	}

; �\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\
; �Đ����X�g���̉��y�t�@�C���̖��O��ύX

	if funcid=FNC_LIST_RENAME {
	 ; �ϖ��Ώۂ��擾
	 gosub get_mpath
	 if funcopt=-1 :return_ FR_ERR
	 ; �t�@�C����̊m�F
	 gettype funcopts
	 if stat&TPEX_CDA :return_ FR_ERR
	 ; �ϖ��Ώۂ̏���ۑ�
	 getfname funcopts
	 lEditingFrom=refstr
	 lEditingIdx=funcopt
	 strmid lEditingDir,funcopts,0,stat
	 ; �ϖ���ʕ\��
	 funcopts=lEditingFrom
	 func=FNC_OPEN_WND|FNC_ON+widInfo+IDX_WND_RENAME :gosub *exec_func
	 ; �t�@�C�����̕ύX
	 if funcopts!"" {
	  gosub disable_allWnd
	  ; s, ss �̓��e����x��ɂ��Ă����Ȃ��ƌ듮����N����
	  memset s,0,szs
	  memset ss,0,szss
	  s=lEditingDir+lEditingFrom
	  ss=lEditingDir+funcopts
	  prm=hwProcess,4,ps,pss,$50,pi,0,0
	  dllprocp FNC_SHFileOperationA,pprm,1
	  ; ����
	  if dllret=0 {
	   ; �t���p�X���
	   notesel list
	   notedel lEditingIdx
	   noteadd ss,lEditingIdx
	   ; �t�@�C�������
	   notesel list_
	   notedel lEditingIdx
	   noteadd funcopts,lEditingIdx
	   ; ��ʂɔ��f����
	   gosub get_listobjid
	   if i!-1 {
	    gsel lWid
	    lsi_backup
	    prm=0 :objsend i,lisLB*LB_DELETESTRING+(lisCB*CB_DELETESTRING),lEditingIdx,prm,0
	    objsend i,lisLB*LB_INSERTSTRING+(lisCB*CB_INSERTSTRING),lEditingIdx,funcopts,0
	    lsi_restore i
	    gsel sWid
	   }
	  }
	  gosub enable_allWnd
	 }
	 return_ FR_DONE
	}

; �\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\
; �Đ����X�g���̍��ڂ����Ɉړ�

	if funcid=FNC_LIST_UP {
	 ; �ړ��Ώۂ��擾
	 gosub get_mpath
	 if funcopt=-1 :return_ FR_ERR
	 ; �ړ�
	 ;  �t���p�X���
	 notesel list
	 notedel funcopt
	 ; �� �Đ����̉��y�̃C���f�b�N�X��ǔ�
	 if funcopt=mFileIdx {
	  if funcopt=0 :mFileIdx=lNum-1 :else {
	   mFileIdx--
	  }
	 } else {
	  if funcopt-1=mFileIdx :mFileIdx++
	 }
	 ; �� �I�𒆂̉��y�̃C���f�b�N�X��ǔ�
	 if funcopt=lSelectedIdx {
	  if funcopt=0 :lSelectedIdx=lNum-1 :else {
	   lSelectedIdx--
	  }
	 } else {
	  if funcopt-1=lSelectedIdx :lSelectedIdx++
	 }
	 noteadd funcopts,funcopt-1
	 getfname funcopts
	 ;  �t�@�C�������
	 notesel list_
	 notedel funcopt
	 noteadd refstr,funcopt-1
	 ; ��ʂɔ��f����
	 gosub get_listobjid
	 if i!-1 {
	  gsel lWid
	  lsi_backup
	  prm=0 :objsend i,lisLB*LB_DELETESTRING+(lisCB*CB_DELETESTRING),funcopt,prm,0
	  s=refstr :objsend i,lisLB*LB_INSERTSTRING+(lisCB*CB_INSERTSTRING),funcopt-1,s,0
	  lsi_restore i
	  gsel sWid
	 }
	 return_ FR_DONE
	}

; �\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\
; �Đ����X�g���̍��ڂ�����Ɉړ�

	if funcid=FNC_LIST_DOWN {
	 ; �ړ��Ώۂ��擾
	 gosub get_mpath
	 if funcopt=-1 :return_ FR_ERR
	 ; �ŉ��s�̍��ڂ���ԏ�Ɉړ�
	 if funcopt+1=lNum {
	  ; �ړ�
	  ;  �t���p�X���
	  notesel list
	  notedel funcopt
	  ; �� �Đ����̉��y�̃C���f�b�N�X��ǔ�
	  if funcopt=mFileIdx :mFileIdx=0 :else :mFileIdx++
	  ; �� �I�𒆂̉��y�̃C���f�b�N�X��ǔ�
	  if funcopt=lSelectedIdx :lSelectedIdx=0 :else :lSelectedIdx++
	  noteadd funcopts,0
	  getfname funcopts
	  ;  �t�@�C�������
	  notesel list_
	  notedel funcopt
	  noteadd refstr,0
	  ; ��ʂɔ��f����
	  gosub get_listobjid
	  if i!-1 {
	   gsel lWid
	   lsi_backup
	   prm=0 :objsend i,lisLB*LB_DELETESTRING+(lisCB*CB_DELETESTRING),funcopt,prm,0
	   s=refstr :objsend i,lisLB*LB_INSERTSTRING+(lisCB*CB_INSERTSTRING),0,s,0
	   lsi_restore i
	   gsel sWid
	  }
	 ; ��L�ȊO�́u�w�肳�ꂽ���ڂ̈������Ɉړ�����v�ƍl����
	 } else {
	  func=FNC_LIST_UP+funcopt+1 :gosub *exec_func
	 }
	 return_ FR_DONE
	}

; �\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\
; ���X�g�t�@�C����ǂݍ���

	if funcid=FNC_XLT_LOAD {
	 if func&FNC_STR=0 {
	  ; (1) ���C�ɓ��胊�X�g
	  if func&FNC_AUTO {
	   ; ���C�ɓ���̈ꗗ���X�V����
	   if func&FNC_REFRESH {
	    funcret=FR_DONE
	    ; �����̈ꗗ���폜
	    notemax_ fXLT
	    repeat stat
	     dmenu hmFavSaveSub,FNCM_XLT_SAVE+cnt
	     dmenu hmFav,FNCM_XLT_LOAD+cnt
	    loop
	    ; �V�����ꗗ���쐬
	    dirlist fXLT,datdir+"*.xlt",1
	    notesel fXLT :notemax i
	    if i=0 :return_
	    repeat i
	     noteget s,cnt
	     strlen ii,s :strmid ss,s,0,ii-4
	     imenu ss,FNCM_XLT_SAVE+cnt,0,hmFavSaveSub,cnt+1
	     imenu ss,FNCM_XLT_LOAD+cnt,0,hmFav,cnt+3
	    loop
	    return_
	   }
	   notesel fXLT
	   noteget funcopts,funcopt
	   funcopts=datdir+funcopts
	  ; (2) ��ʂ̃��X�g�t�@�C��
	  } else {
	   gosub disable_allWnd
	   dialog "xlt",16,"���X�g�t�@�C��"
	   if stat=0 :gosub enable_allWnd :return_ FR_ERR
	   gosub enable_allWnd
	   funcopts=refstr
	  }
	 }
	 ;	funcopts	/ �ǂݍ��ރ��X�g�t�@�C��
	 exist_ funcopts
	 if stat>0 {
	  if lClearOnLoad :list="" :lNum=0
	  sdim notedata,bufnd
	  notesel notedata
	  noteload funcopts
	  func=FNC_LIST_ADD|FNC_AUTO|FNC_ON :gosub *exec_func
	  func=FNC_LIST_REFRESH :gosub *exec_func
	 } else :funcret=FR_ERR
	 return_
	}

; �\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\
; �Đ����X�g�����X�g�t�@�C���Ƃ��ĕۑ�

	if funcid=FNC_XLT_SAVE {
	 if func&FNC_STR=0 {
	  ; (1) ���C�ɓ��胊�X�g
	  if func&FNC_AUTO {
	   ; ���C�ɓ���ւ̐V�K�o�^
	   if func&FNC_ON {
	    funcopts=defxlt
	    func=FNC_OPEN_WND|FNC_ON+widInfo+IDX_WND_FAVORITE :gosub *exec_func
	    if funcopts="" :return_ FR_ERR
	    func=FNC_AUTO
	   ; ���C�ɓ���̏㏑���ۑ�
	   } else {
	    notesel fXLT
	    noteget funcopts,funcopt
	   }
	   funcopts=datdir+funcopts
	  ; (2) ��ʂ̃��X�g�t�@�C��
	  } else {
	   gosub disable_allWnd
	   dialog "xlt",17,"���X�g�t�@�C��"
	   if stat=0 :gosub enable_allWnd :return_ FR_ERR
	   gosub enable_allWnd
	   funcopts=refstr
	  }
	 }
	 gettype funcopts
	 if stat&TPEX_XLT=0 :funcopts+=".xlt"
	 exist_ funcopts
	 if stat=1 {
	  convert s,langs.lgDlg_ConfirmOverwrite,funcopts,"%file%"
	  gosub disable_allWnd
	  dialog s,2,prgtitles
	  if stat=7 :gosub enable_allWnd :return_ FR_ERR
	  gosub enable_allWnd
	 }
	 notesel list
	 skiperr 1
	 notesave funcopts :i=err
	 skiperr 0
	 if i {
	  convert s,langs.lgDlg_ErrorOnSave,funcopts,"%file%"
	  gosub disable_allWnd
	  dialog s,1,prgtitles
	  gosub enable_allWnd
	  return_ FR_ERR
	 }
	 ; ���C�ɓ��胁�j���[�̍X�V
	 if func&FNC_AUTO :func=FNC_XLT_LOAD|FNC_AUTO|FNC_REFRESH :gosub *exec_func
	 return_ FR_DONE
	}

; �\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\
; �X�L���ϐ��̒l��ҏW

	if funcid=FNC_XSP_MODIFY {
	 ; �S�Ă̕ϐ��l��������
	 if func&FNC_OFF {
	  strlen i,sFileName
	  strmid s,sFileName,0,i-4
	  s=skndir+s+".xsv"
	  exist_ s
	  if stat!1 :return_ FR_ERR
	  delete s
	  func=FNC_XSP_LOAD|FNC_AUTO :gosub *exec_func
	  return_ FR_DONE	  
	 }
	 ; �ϐ��l�𕶎���Ŏw��
	 if func&FNC_STR {
	  if funcopt>=snVar :return_ FR_ERR
	  i=funcopt
	  sVar.i=funcopts
	 ; �_�C�A���O��\�����ĕϐ��l�����[�U�[�ɐq�˂�
	 } else {
	  if func&FNC_AUTO=0 {
	   i=funcopt
	   sEditingIdx=i
	   if sVar_type.i=SV_COLOR {
	    gosub disable_allWnd
	    dialog "",33
	    if stat!1 :gosub enable_allWnd :return_ FR_ERR
	    sVar.i=""+rval+"*"+gval+"*"+bval
	    gosub enable_allWnd
	   } else {
	    if sVar_type.i=SV_FONT {
	     gosub disable_allWnd
	     prm=bmscr.38,60,pprmex
	     dllprocp FNC_GetObjectA,prm,3
	     prm=60,bmscr.13,0,pprmex,0,$41,bmscr.40,0,0,0,0,0,$2000
	     dllprocp FNC_ChooseFontA,pprm,1
	     if dllret=0 :gosub enable_allWnd :return_ FR_ERR
	     memcpy s,prmex,32,,28
	     prm=prm.4/10
	     if prmex.4>400 :ii=1 :else :ii=0
	     if (prmex.5&$FF)!0 :ii+=2
	     sVar.i=s+"*"+prm+"*"+ii
	     gosub enable_allWnd
	    } else {
	     ; �X�L���ϐ����͉�ʕ\��
	     if sVar_type.i=SV_LIST :funcopts=sVar_listdsc.i :else :funcopts=sVar.i
	     func=FNC_OPEN_WND|FNC_ON+widInfo+IDX_WND_SKV :gosub *exec_func
	     if funcopts="" :return_ FR_ERR
	     if funcopts="(null)" :funcopts=""
	     ; �X�L���ϐ��̒l��ύX
	     i=sEditingIdx
	     sVar.i=funcopts
	    }
	   }
	  }
	 }
	 ; �X�L���ϐ��̒l��ۑ�
	 strlen i,sFileName
	 strmid s,sFileName,0,i-4
	 s=skndir+s+".xsv"
	 tmp=""
	 repeat snVar
	  tmp+=sVar.cnt+"\n"
	 loop
	 strlen i,tmp
	 bsave s,tmp,i
	 ; �X�L���̍ēǂݍ���
	 func=FNC_XSP_LOAD|FNC_AUTO :gosub *exec_func
	 return_ FR_DONE
	}

; �\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\
; �X�L����ǂݍ���

	if funcid=FNC_XSP_LOAD {
	 ; �X�L���̈ꗗ���X�V����
	 if func&FNC_REFRESH {
	  funcret=FR_DONE
	  ; �����̈ꗗ���폜
	  notemax_ fXSP
	  repeat stat :dmenu hmSkin,FNC_XSP_LOAD+cnt :loop
	  ; �V�����ꗗ���쐬
	  dirlist fXSP,skndir+"*.xsp",1
	  notesel fXSP :notemax i
	  if i=0 :return_
	  repeat i
	   noteget s,cnt
	   strlen ii,s :strmid ss,s,0,ii-4
	   imenu ss,FNC_XSP_LOAD+cnt,0,hmSkin,cnt+1
	   if s=sFileName {
	    mii.1=1 :mii.3=8
	    setmii hmSkin,FNC_XSP_LOAD+cnt
	   }
	  loop
	  return_
	 }
	 ; �ǂݍ��ރX�L�����擾����
	 notesel fXSP :notemax i
	 if func&FNC_AUTO :funcopts=sFileName :else {
	  if func&FNC_STR=0 :noteget funcopts,funcopt
	 }
	 ; ���j���[�̃`�F�b�N���X�V
	 mii.1=1
	 repeat i
	  noteget s,cnt
	  if s=sFileName :mii.3=0 :setmii hmSkin,FNC_XSP_LOAD+cnt
	  if s=funcopts :mii.3=8 :setmii hmSkin,FNC_XSP_LOAD+cnt
	 loop
	 ; �ǂݍ���
	 repeat 2
	  s=skndir+funcopts
	  exist_ s
	  if stat!1 {
	   if cnt=0 :funcopts=defxsp :continue
	   gosub enable_allWnd
	   dialog "�����ݒ�X�L����������Ȃ����߃v���C���[���I�����܂��B\n�v���C���[�{�̂������T�C�g����_�E�����[�h���ăC���X�g�[���������ĉ������B",1,prgtitles
	   goto *exit
	  }
	 loop
	 bload s,tmp
	 poke tmp,strsize,0	; ������̏I���������R�[�h��t��
	 strsel tmp
	 ; �X�N���v�g�̃o�[�W�����m�F
	 strget i,".SkinScript.ver"
	 if i>vscript|(i=0) {
	  convert sss,langs.lgDlg_ErrorFormat,"�X�L��","%format%"
	  convert ss,sss,s,"%file%"
	  convert s,ss,"","%confirm%"
	  gosub disable_allWnd
	  dialog s,0,prgtitles
	  gosub enable_allWnd
	  return_ FR_ERR
	 }
	 sFileName=funcopts
	 ; �X�N���v�g�̓��e�𕪊�
	 ;  (1) ��ʓI�ȃC�x���g
	 strgeta_xsp scrAreaInit		,"Initialize"
	 strgeta_xsp scrAreaMain		,"MainLoop"
	 strgeta_xsp scrAreaShow_Mode		,"ChangeMode"
	 strgeta_xsp scrAreaShow_ModeEx		,"ChangeRepMode"
	 strgeta_xsp scrAreaShow_FileInfo	,"ChangeFile"
	 strgeta_xsp scrAreaShow_Tiphelp	,"ShowTiphelp"
	 strgeta_xsp scrAreaDisp_ListArea	,"ShowList"
	 strgeta_xsp scrAreaHide_ListArea	,"HideList"
	 ;  (2) ���[�U�[��`�C�x���g
	 i=0 :snAreaUser=0	; ���ƒ����𒲍�
	 repeat ,1
	  strgeta funcopts,"UserDef"+cnt
	  if stat=0 :snAreaUser=cnt :break
	  if i<stat :i=stat
	 loop
	 if snAreaUser {
	  sdim scrAreaUser,i+3,snAreaUser
	  dim scrAreaUserLine,snAreaUser
	  i=0
	  repeat snAreaUser	; ���ۂɎ擾
	   i++
	   strgeta scrAreaUser.cnt,"UserDef"+i
	   notemax_ scrAreaUser.cnt
	   scrAreaUserLine.cnt=stat
	  loop
	 }
	 ; ��ʏ���������
	 repeat snObj			; �I�u�W�F�N�g���(cf. _init_var.as)
	  obj.cnt=-1
	  obj.cnt.2=-1
	  if obj.i.1 {
	   dllprocp FNC_DeleteObject,obj.i.1,1
	   obj.cnt.1=0
	  }
	 loop
	 repeat snChk			; �`�F�b�N�{�b�N�X���
	  chkid.cnt=-1
	 loop
	 if wi.widMain|wi.widRegion {
	  snObj=0			; �ݒu�I�u�W�F�N�g��
	  snChk=0			;
	  if dispMainWnd&2=0 {		; ���݂̉�ʈʒu��ۑ�
	   ginfo 2
	   MainWndX=prmx :MainWndY=prmy
	  } else :gosub open_sWid
	  gsel sWid,-1
	  if sWid=widRegion {		; �s��`�E�B���h�E���l�p�`�ɖ߂�
	   palcolor 255
	   boxf
	   color 0,0,0
	   regmake
	  }
	  cls				; �I�u�W�F�N�g����
	  hwMainWnd=0			; ���C����ʃn���h��
	  hwList=0			; ���C����ʃ��X�g�n���h��
	  dispListArea=0		; ���X�g�̈�͍ŏ��B���Ă���	  
	 }
	 if hwListSub {			; ���X�g��ʂ��B��
	  func=FNC_OPEN_WND|FNC_OFF+widList :gosub *exec_func
	 }
	 if wi.widBuffer :gsel widBuffer :boxf
	 ; �X�L���ϐ��֘A�̃��j���[���ڂ�����
	 repeat snVar :dmenu hmSkinSubModify,FNC_XSP_MODIFY+cnt :loop
	 ; �X�L�������擾
	 strget sAuthor,".SkinScript.auth"	; �����
	 strget sName,".SkinScript.titl"	; �^�C�g��
	 strget sComment,".SkinScript.comm"	; �R�����g
	 strget sScrollStep,".Scroll.widt"	; �X�N���[�����������x�ɓ�������
	 strget sScrollWidth,".ScrollArea.widt"	; �X�N���[���̈�(��)
	 strget sDragX,".Window.drag.x"		; �h���b�O�̈�	(�J�n�w���W)
	 strget sDragY,".Window.drag.y"		; �V		(�J�n�x���W)
	 strget sDragWidth,".Window.drag.widt"	; �V		(��)
	 strget sDragHeight,".Window.drag.heig"	; �V		(����)
	 strget sSeekX,".Window.seek.x"		; �V�[�N�o�[�̈�(�J�n�w���W)
	 strget sSeekY,".Window.seek.y"		; �V		(�J�n�x���W)
	 strget sSeekWidth,".Window.seek.widt"	; �V		(��)
	 strget sSeekHeight,".Window.seek.heig"	; �V		(����)
	 strget sSeekDirection,".Window.seek.direct"; �V	(����)
	 strget MainWndWidth,".Window.widt"	; ���C�����	(��)
	 strget MainWndHeight,".Window.heig"	; �V		(����)
	 strget ListAreaWidth,".List.widt"	; ���X�g�̈�	(��)
	 strget ListAreaHeight,".List.heig"	; �V		(����)
	 strget s,".Window.type"		; ���C����ʂ̎��
	 ; ���C����ʂ̍쐬
	 ;  (1) �s��`�E�B���h�E
	 if s="region" {
	  if wi.widRegion=0 {
	   bgscr widRegion,640,480,2,dispx,dispy
	   title prgtitles
	  }
	  gsel widRegion
	  strget s,".Window.img" :s=skndir+s
	  existex s
	  if stat>0 {
	   gosub gsel_widBuffer
	   picload s,1
	   bload s,ss,64	; �摜�̑傫���𒲂ׂ�
	   wpeek prm,ss,0
	   if prm=19778 {	; (BMP�w�b�_ "BM" �̊m�F)
	    wpeek prm.3,ss,$12	; ��
	    wpeek prm.4,ss,$16	; ����
	   } else :prm.3=640,480
	   pget 0,0		; �摜����̐F�𒲂ׂ�
	   prm=rval,gval,bval	; R,G,B
	   gsel widRegion
	   redraw 2
	   gcopy widBuffer,0,0,prm.3,prm.4
	   strget i,".Window.trans.r" :if stat :prm  =i
	   strget i,".Window.trans.g" :if stat :prm.1=i
	   strget i,".Window.trans.b" :if stat :prm.2=i
	   color prm,prm.1,prm.2
	   regmake
	   color 0,0,0
	   redraw 1
	  }
	  sWid=widRegion
	 ;  (2) �g�t���E�B���h�E
	 } else {
	  gsel widMain
	  if wi.widMain=0 :title prgtitles
	  sWid=widMain
	 }
	 ; ��ʏ��̍X�V
	 width MainWndWidth,MainWndHeight,MainWndX,MainWndY
	 mref bmscr,67
	 hwMainWnd=bmscr.13
	 objmode 2,1
	 ;  (*) ���߂Ďg�p����E�B���h�E
	 i=sWid
	 if wi.i=0 {
	  wi.i=1
	  ; ���b�Z�[�W�擾�ݒ�
	  if i=widRegion :gm_setwndproc hwMainWnd
	  gm_setmessage hwMainWnd,WM_LBUTTONDOWN; ���N���b�N�̎擾
	  gm_setmessage hwMainWnd,WM_DROPFILES	; �h���b�O���h���b�v�̎擾
	  prm=hwMainWnd,1			; �h���b�O���h���b�v�̋���
	  dllprocp FNC_DragAcceptFiles,prm,2
	  ; �E�B���h�E�X�^�C���̐ݒ�
	  ; (�V�X�e�����j���[��\��)
	  if i=widRegion {
	   prm.1=-16
	   dllprocp FNC_GetWindowLongA,prm,2
	   prm.2=dllret|$80000
	   dllprocp FNC_SetWindowLongA,prm,3
	  }
	 }
	 strget s,".List.type"			; ���X�g�̎��
	 repeat
	  if s="normal" :sListArea=0 :break
	  if s="scroll" :sListArea=1 :break
	  sListArea=2 :break
	 loop
	 strget snVar,".Var.num"		; �X�L���ϐ��̐�
	 if snVar>0 {
	  ; �X�L���ϐ��t�@�C����ǂݍ���
	  strlen i,sFileName
	  strmid s,sFileName,0,i-4
	  s=skndir+s+".xsv"
	  exist_ s
	  if stat=1 {
	   notesel funcopts
	   noteload s
	   i=1
	  } else :i=0
	  ; �X�L���ϐ��̏����l����ƕҏW�p���j���[����
	  repeat snVar
	   strget sVar_type.cnt,".Var."+cnt+".type"	; ���
	   strget s,".Var."+cnt+".list"			; ���e�I�����ꗗ
	   strget ss,".Var."+cnt+".list+"		; ���e�I���������ꗗ
	   convert sVar_list.cnt,s,"\n","<BR>"
	   if ss="" {
	    sVar_listdsc.cnt=sVar_list.cnt
	   } else {
	    convert sVar_listdsc.cnt,ss,"\n","<BR>"
	   }
	   strget sVar_dsc.cnt,".Var."+cnt+".comm"	; ���e����
	   if i :noteget sVar.cnt,cnt :else {
	    strget sVar.cnt,".Var."+cnt+".default"	; �W���l
	   }
	   if sVar_dsc.cnt!"" {
	    imenu sVar_dsc.cnt,FNC_XSP_MODIFY+cnt,0,hmSkinSubModify,cnt+1
	   }
	  loop
	  mii.3=0
	 } else :mii.3=3
	 mii.1=1
	 notemax_ fXSP
	 setmii hmSkin,stat+4,1
	 ; ����t�@�C����ǂݍ���
	 strget funcopts,".XmsFile"
	 if funcopts="" :funcopts=defxms
	 if funcopts!sLanguage :func=FNC_XMS_LOAD|FNC_STR :gosub *exec_func
	 ; ���j���[�̍X�V
	 tmenu "�����: "+sAuthor,FNC_CLIP+IDX_CLIP_SINFO+1,hmSkinSub
	 tmenu "�^�C�g��: "+sName,FNC_CLIP+IDX_CLIP_SINFO+2,hmSkinSub
	 tmenu "�R�����g: "+sComment,FNC_CLIP+IDX_CLIP_SINFO+3,hmSkinSub
	 ; �X�N���v�g�̎��s������
	 scrLine+=scrAreaInitLine+1
	 script=scrAreaInit+"!!!init=xsp\n"+script
	 return_ FR_DONE
	}

; �\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\
; �X�L���ݒ�t�@�C����ǂݍ���

	if funcid=FNC_XSS_LOAD {
	 if snVar=0 :return_ FR_ERR
	 if func&FNC_STR=0 {
	  gosub disable_allWnd
	  dialog "xss",16,"�X�L���ݒ�t�@�C��"
	  if stat=0 :gosub enable_allWnd :return_ FR_ERR
	  funcopts=refstr
	  gosub enable_allWnd
	 }
	 exist_ funcopts
	 if stat!1 :return_ FR_ERR
	 notesel notedata
	 noteload funcopts
	 noteget s,0
	 if "for:"+sFileName!s :return_ FR_ERR
	 repeat snVar
	  noteget sVar.cnt,cnt+1
	 loop
	 sdim notedata,bufnd
	 func=FNC_XSP_MODIFY|FNC_AUTO :gosub *exec_func
	 return_ FR_DONE
	}

; �\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\
; �X�L���ݒ�t�@�C���ɕۑ�

	if funcid=FNC_XSS_SAVE {
	 if snVar=0 :return_ FR_ERR
	 if func&FNC_STR=0 {
	  gosub disable_allWnd
	  dialog "xss",17,"�X�L���ݒ�t�@�C��"
	  if stat=0 :gosub enable_allWnd :return_ FR_ERR
	  funcopts=refstr
	  gosub enable_allWnd
	 }
	 tmp="for:"+sFileName+"\n"
	 repeat snVar
	  tmp+=sVar.cnt+"\n"
	 loop
	 strlen i,tmp
	 bsave funcopts,tmp,i
	 return_ FR_DONE
	}

; �\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\
; ����t�@�C����ǂݍ���

	if funcid=FNC_XMS_LOAD {
	 ; ����t�@�C���̈ꗗ���X�V����
	 if func&FNC_REFRESH {
	  funcret=FR_DONE
	  ; �����̈ꗗ���폜
	  notemax_ fXMS
	  repeat stat :dmenu hmLanguage,FNC_XMS_LOAD|FNC_ON+cnt :loop
	  ; �V�����ꗗ���쐬
	  dirlist fXMS,skndir+"*.xms",1
	  notesel fXMS :notemax i
	  if i=0 :return_
	  repeat i
	   noteget s,cnt
	   strlen ii,s :strmid ss,s,0,ii-4
	   imenu ss,FNC_XMS_LOAD|FNC_ON+cnt,0,hmLanguage,cnt+1
	   if s=sLanguage {
	    mii.1=1 :mii.3=8
	    setmii hmLanguage,FNC_XMS_LOAD|FNC_ON+cnt
	   }
	  loop
	  return_
	 }
	 ; �ǂݍ��ރt�@�C�����擾
	 notesel fXMS :notemax i
	 if func&FNC_AUTO :funcopts=sLanguage :else {
	  if func&FNC_STR=0 :noteget funcopts,funcopt
	 }
	 ; ���j���[�̃`�F�b�N���X�V
	 mii.1=1
	 repeat i
	  noteget s,cnt
	  if s=sLanguage :mii.3=0 :setmii hmLanguage,FNC_XMS_LOAD|FNC_ON+cnt
	  if s=funcopts :mii.3=8 :setmii hmLanguage,FNC_XMS_LOAD|FNC_ON+cnt
	 loop
	 ; �ǂݍ���
	 repeat 2
	  s=skndir+funcopts
	  exist_ s
	  if stat=1 {
	   bload s,tmp
	  } else {
	   if cnt=0 :funcopts=defxms :continue
	   tmp=""
	  }
	 loop
	 strsel tmp
	 ; ����t�@�C���̃o�[�W�����m�F
	 strget i,".LanguageFile.ver"
	 if i>vlanguage|(i=0) {
	  strget i,".MessageFile.ver"
	  if i>vlanguage|(i=0) {
	   convert sss,langs.lgDlg_ErrorFormat,"����t�@�C��","%format%"
	   convert ss,sss,s,"%file%"
	   convert s,ss,"","%confirm%"
	   gosub enable_allWnd
	   dialog s,0,prgtitles
	   gosub disable_allWnd
	   return_ FR_ERR
	  }
	 }
	 sLanguage=funcopts
	 ;  (1) �����ݒ�l���
	 langs.lgPM  ="NOR(ɰ�� )","REV(��ް�)","RND(�����)","REP(��߰�)","STP(�į��)","MDR(ں���)"
	 i=lgPMTI :repeat 6,lgPM :langs.i=langs.cnt :i++ :loop
	 langs.lgPMEX="���Ȃ�","����"
	 langs.lgST="��~","�Đ��I��","�Đ���","�ꎞ��~��",
	 langs.lgTP="MP3","WMA","MIDI","WAVE","OggVorbis","CD-Audio","(MCI �ōĐ��\�ȃt�@�C��)","(DirectShow �ōĐ��\�ȃt�@�C��)"
	 langs.lgDlg_ErrorFormat="�w�肳�ꂽ%format%�͉��Ă��邩�A\n�܂��͖��Ή��̌`���ł��邽�ߓǂݍ��ނ��Ƃ��o���܂���ł����B\n%confirm%\n(%file%)"
	 langs.lgDlg_ErrorNotFound="�w�肳�ꂽ%format%�������炸�A�ǂݍ��ނ��Ƃ��o���܂���ł����B\n%confirm%\n(%file%)"
	 langs.lgDlg_ErrorOnSave="�t�@�C���̕ۑ��Ɏ��s���܂����B\n\n�t�@�C�����Ɏg���Ȃ��������w�肵�Ă��Ȃ����A\n�ǂݎ���p�̃f�B�X�N�ɕۑ����悤�Ƃ��Ă��Ȃ����Ȃǂ��m�F���Ă��������B\n\n(%file%)"
	 langs.lgDlg_ConfirmClearFile="�Đ����X�g����폜���܂����H\n"
	 ;  (2) ����t�@�C���̓��e���擾
	 ;	�_�C�A���O�p����
	 ;	 ���ŃT�|�[�g
	 if i<403 {
	  strget_lg lgDlg_ErrorTooManyFiles,	".List.adderror"
	  strget_lg lgDlg_Folder,	".List.addfolder"
	  strget_lg lgDlg_Rename,	".List.renamefile"
	  strget_lg lgDlg_Favorite,	".List.favorite"
	  strget_lg lgDlg_ConfirmDelete,".List.deletefile"
	  langs.lgDlg_ConfirmDelete+="%file%"
	  strget_lg lgDlg_ConfirmClearAll,".List.clearlist"
	  strget_lg lgDlg_ConfirmOverwrite,".List.overwrite"
	  langs.lgDlg_ConfirmOverwrite+="%file%"
	 }
	 ;	 ver.403.00��1�`
	 repeat lgs
	  strget_lg cnt,"."+lg_key.cnt
	 loop
	 ;	�I�u�W�F�N�g�̃`�b�v�w���v������
	 i=lgObj
	 repeat objs
	  strget s,".Obj."+obj_key.cnt
	  convert langs.i,s,"\n","<BR>"
	  i++
	 loop
	 ; (�R���{�{�b�N�X�̓��X�g�{�b�N�X�Ɠ����`�b�v�w���v)
	 i=lgObj+objMainlistc
	 ii=lgObj+objMainlist
	 if langs.i="" :langs.i=langs.ii
	 ; �\���̍X�V
	 if func&FNC_ON :gosub refresh_tiphelp
	 return_ FR_DONE
	}

; �\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\
; �v���O�C���Ȃǂ̊O���t�@�C�����N��

	if funcid=FNC_XPI_LOAD {
	 ; �v���O�C���̈ꗗ���X�V����
	 if func&FNC_REFRESH {
	  funcret=FR_DONE
	  ; �����̈ꗗ���폜
	  notemax_ fXPI
	  repeat stat :dmenu hmPlugin,FNC_XPI_LOAD+cnt :loop
	  ; �V�����ꗗ���쐬
	  dirlist fXPI,extdir+"*.xpi",1
	  dirlist notedata,extdir+"*.exe",1 :if stat :fXPI+=notedata
	  dirlist notedata,extdir+"*.lnk",1 :if stat :fXPI+=notedata
	  sdim notedata,bufnd
	  notesel fXPI :notemax i
	  if i=0 :return_
	  repeat i
	   noteget s,cnt
	   strlen ii,s :strmid ss,s,0,ii-4
	   imenu ss,FNC_XPI_LOAD+cnt,0,hmPlugin,cnt+1
	  loop
	  return_
	 }
	 if func&FNC_AUTO {
	  if funcopt=IDX_XPI_HELP {
	   s=helpfile
	   exist_ s
	   if stat=1 :exec s,16 :return_ FR_DONE
	   return_ FR_ERR
	  }
	  if funcopt=IDX_XPI_VOLUME {
	   s="\\sndvol32.exe" :ss=windir+s
	   repeat 2
	    exist_ ss
	    if stat!1 {
	     funcret=FR_ERR
	     ss=sysdir+s
	     continue
	    } else :exec ss+" /t" :funcret=FR_DONE
	   loop
	   return_
	  }
	  repeat
	   if funcopt=IDX_XPI_SETPLAYFUNC :funcopts=datdir+setplayfunc :break
	   if funcopt=IDX_XPI_SETPLAYTYPE :funcopts=datdir+setplaytype :break
	   if funcopt=IDX_XPI_CFGFAVORITE :funcopts=datdir+cfgfavorite :break
	   break
	  loop
	 } else {
	  notesel fXPI
	  noteget funcopts,funcopt
	 }
	 gettype funcopts
	 if stat&TPEX_EXE {
	  skiperr 1
	  exec extdir+funcopts,16 :i=err
	  skiperr 0
	  if i :return_ FR_ERR
	 } else {
	  strlen i,funcopts
	  bsave tmpdir+"run.xmp",funcopts,i
	  exec myself
	 }
	 return_ FR_DONE
	}

; �\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\
; �X�N���v�g��ǂݍ���Ŏ��s

	if funcid=FNC_XS_LOAD {
	 ; �X�N���v�g�̈ꗗ���X�V����
	 if func&FNC_REFRESH {
	  funcret=FR_DONE
	  ; �����̈ꗗ���폜
	  notemax_ fXS
	  repeat stat :dmenu hmScript,FNC_XS_LOAD|FNC_AUTO+cnt :loop
	  ; �V�����ꗗ���쐬
	  dirlist fXS,extdir+"*.xs",1
	  notesel fXS :notemax i
	  if i=0 :return_
	  repeat i
	   noteget s,cnt
	   strlen ii,s :strmid ss,s,0,ii-3
	   imenu ss,FNC_XS_LOAD|FNC_AUTO+cnt,0,hmScript,cnt+1
	  loop
	  return_
	 }
	 ; �ǂݍ��ރt�@�C�����擾
	 if func&FNC_STR=0 {
	  if func&FNC_AUTO {
	   notesel fXS
	   noteget funcopts,funcopt
	   funcopts=extdir+funcopts
	  } else {
	   gosub disable_allWnd
	   dialog "xs",16,"�X�N���v�g"
	   if stat=0 :gosub enable_allWnd :return_ FR_ERR
	   funcopts=refstr
	   gosub enable_allWnd
	  }
	 }
	 ; �ǂݍ���
	 exist_ funcopts
	 if stat!1 :return_ FR_ERR
	 bload funcopts,tmp
	 poke script,strsize,0	; ������̏I���������R�[�h��t��
	 notemax_ tmp
	 script+=tmp
	 scrLine+=stat
	 return_ FR_DONE
	}

; �\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\
; �N���b�v�{�[�h�ɏ����R�s�[

	if funcid=FNC_CLIP {
	 i=funcopt
	 ; ���y���
	 if i<IDX_CLIP_SINFO {
	  if i<nminfo_ :s=minfo_.i :funcret=FR_DONE :else :s="" :funcret=FR_ERR
	 ; �X�L�����
	 } else {
	  i-=IDX_CLIP_SINFO
	  if i<nsinfo_ :s=sinfo_.i :funcret=FR_DONE :else :s="" :funcret=FR_ERR
	 }
	 ; �N���b�v�{�[�h���J��
	 prm=0
	 dllprocp FNC_OpenClipboard,prm,1
	 dllprocp FNC_EmptyClipboard,prm,0
	 ; �N���b�v�{�[�h�Ƀf�[�^����������
	 if s!"" {
	  ; �O���[�o���������I�u�W�F�N�g���쐬�����b�N
	  prm=$42 :strlen prm.1,s :prm.1++
	  dllprocp FNC_GlobalAlloc,prm,2 :i=dllret
	  i=dllret
	  dllprocp FNC_GlobalLock,i,1
	  ;	i	/ �������I�u�W�F�N�g�n���h��
	  ;	dllret	/ �������u���b�N�̐擪�̃|�C���^
	  ; ��������O���[�o���������փR�s�[�����b�N����
	  prm=dllret,ps
	  dllprocp FNC_lstrcpy,prm,2
	  dllprocp FNC_GlobalUnlock,i,1
	  prm=1,i
	  dllprocp FNC_SetClipboardData,prm,2
	 }
	 ; �N���b�v�{�[�h�����
	 dllprocp FNC_CloseClipboard,prm,0
	 return_
	}

; �\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\
; �ݒ�̕ύX

; SET�n�o��	(1) dispMainWnd|initializing != 0
;			�N�����݂̂̏���
;		(2) func|FNC_REFRESH != 0
;			�N�����܂��̓X�L���ǂݍ��݌�̏���
;		(3) func|FNC_CHANGE != 0
;			�ݒ�ύX���̏���
;
;		���j���[�̃`�F�b�N���X�V����K�v������̂�	(1),(3)
;		�`�F�b�N�{�b�N�X�̍X�V������	�V		(2),(3)
;		�X�N���v�g�����s����@�@�@�@	�V		(3)

	if funcid=FNC_SET {
	 ; �ݒ�l�̕ύX
	 if func&FNC_CHANGE {
	  if func&FNC_AUTO {
	   repeat
	    if funcopt=IDX_SET_LIST_CLEARONLOAD	:lClearOnLoad=lClearOnLoad^1 :break
	    if funcopt=IDX_SET_LIST_DOWNDBLITEM	:lDownDblItem=lDownDblItem^1 :break
	    if funcopt=IDX_SET_DISP_ONTOP	:dispMainWnd =dispMainWnd ^1 :break
	    if funcopt=IDX_SET_DISP_TIPHELP	:dispTiphelp =dispTiphelp ^1 :break
	    if funcopt=IDX_SET_DISP_TRAYICON	:dispTrayicon=dispTrayicon^1 :break
	    if funcopt=IDX_SET_DISP_TASKBAR	:dispTaskbar =dispTaskbar ^1 :break
	    if funcopt=IDX_SET_PLAY_REPLAY	:lReplay     =lReplay     ^1 :break
	    break
	   loop
	  } else {
	   repeat
	    i=func&FNC_ON!0
	    if funcopt=IDX_SET_LIST_CLEARONLOAD	:lClearOnLoad=i :break
	    if funcopt=IDX_SET_LIST_DOWNDBLITEM	:lDownDblItem=i :break
	    if funcopt=IDX_SET_DISP_ONTOP	:dispMainWnd =dispMainWnd&2+i :break
	    if funcopt=IDX_SET_DISP_TIPHELP	:dispTiphelp =i :break
	    if funcopt=IDX_SET_DISP_TRAYICON	:dispTrayicon=i :break
	    if funcopt=IDX_SET_DISP_TASKBAR	:dispTaskbar =i :break
	    if funcopt=IDX_SET_PLAY_REPLAY	:lReplay     =i :break
	    break
	   loop
	  }
	 }
	 ; �ݒ�l�̎擾�Ɛݒ�ύX�̓K�p
	 repeat
	  prm=hmSetList
	  if funcopt=IDX_SET_LIST_CLEARONLOAD	:prm.1=lClearOnLoad :break
	  if funcopt=IDX_SET_LIST_DOWNDBLITEM	:prm.1=lDownDblItem :break
	  prm=hmSetDisp
	  if funcopt=IDX_SET_DISP_ONTOP		{
	   if func&(FNC_CHANGE|FNC_REFRESH) :gsel sWid,dispMainWnd&1+1
	   prm.1=dispMainWnd&1 :break
	  }
	  if funcopt=IDX_SET_DISP_TIPHELP	{
	   if func&(FNC_CHANGE|FNC_REFRESH) :gosub refresh_tiphelp
	   prm.1=dispTiphelp :break
	  }
	  if funcopt=IDX_SET_DISP_TRAYICON	{
	   if func&FNC_CHANGE|(dispMainWnd&initializing) {
	    if dispTrayicon {
	     ntray hIcon
	     ttray mTasktray,hIcon
	    } else :ctray
	   }
	   prm.1=dispTrayicon :break
	  }
	  if funcopt=IDX_SET_DISP_TASKBAR	{
	   if func&(FNC_CHANGE|FNC_REFRESH) {
	    ;  �g���X�^�C����/���� WS_EX_TOOLWINDOW ��������/�O��
	    ;  �� �c�[���E�B���h�E�́A�ʏ�̃^�C�g���o�[��菬�����^�C�g���o�[������...
	    ;  �@ ���^�C�g���o�[�����X�����E�B���h�E�ł��̃X�^�C�����w�肵���ꍇ�ɂ� "�������^�C�g���o�[e.t.c." �͊֌W�����炵��
	    if sWid=widRegion {
	     if dispMainWnd&2=0 :gsel sWid,-1
	     prmex=hwMainWnd,-20
	     dllprocp FNC_GetWindowLongA,prmex,2
	     if dispTaskbar :prmex.2=dllret&($FFFFFF7F) :else :prmex.2=dllret|$80
	     dllprocp FNC_SetWindowLongA,prmex,3
	     if dispMainWnd&2=0 :gsel sWid,dispMainWnd&1+1
	    }
	   }
	   prm.1=dispTaskbar :break
	  }
	  prm=hmSetPlay
	  if funcopt=IDX_SET_PLAY_REPLAY	:prm.1=lReplay :break
	  break
	 loop
	 ; �`�F�b�N���X�V
	 ;  ���j���[
	 if func&FNC_CHANGE|(dispMainWnd&initializing) {
	  mii.1=1 :mii.3=prm.1*8 :setmii prm,FNCM_SET+funcopt
	 }
	 ;  �I�u�W�F�N�g
	 if func&(FNC_CHANGE|FNC_REFRESH) {
	  repeat snChk
	   i=chkid.cnt
	   if obj.i^func&$FF00FFFF=0 :objprm i,prm.1
	   chk_.cnt=chk.cnt
	  loop
	 }
	 return_ prm.1
	} 

; �\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\
; �ݒ�̕ύX>�Đ����X�g�ҏW�ł̌����Ώ�

	if funcid=FNC_SET_SEARCH {
	 repeat
	  if func&FNC_AUTO {
	   if func&FNC_ALL :lSearchType=lSearchType=0*TPEX_ALL
	   lSearchType=lSearchType^funcopt :break
	  }
	  if func&FNC_OFF :lSearchType=lSearchType&($FFFFFF^funcopt) :break
	  if func&FNC_ON :lSearchType=lSearchType|funcopt :break
	  break
	 loop
	 ; �`�F�b�N���X�V
	 ; ($1-$2000 �܂�)
	 i=1 :ii=0 :mii.1=1
	 repeat 11
	  prm=lSearchType&i!0
	  ; ���j���[
	  if func&FNC_CHANGE|(dispMainWnd&initializing) {
	   mii.3=prm*8
	   setmii hmSetListSub,FNCM_SET_SEARCH+ii
	  }
	  ; �I�u�W�F�N�g
	  if func&(FNC_REFRESH|FNC_CHANGE) {
	   repeat snChk
	    iii=chkid.cnt
	    if obj.iii^(FNC_SET_SEARCH|FNC_AUTO+i)&$FF00FFFF=0 :objprm iii,prm
	    chk_.cnt=chk.cnt
	   loop
	  }
	  if cnt=8 :i=$1000 :ii=12 :else :i=i<<1 :ii++
	 loop
	 return_ lSearchType
	}

; �\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\
; �ݒ�̕ύX>�Đ���@

	if funcid=FNC_SET_PLAYFUNC {
	 ; �Ăяo����Œl���ύX����邱�Ƃ̖��� im.5,6 �ɐݒ���e��ޔ�
	 im.5=funcopt&$FFF :i=im.5
	 im.6=funcopt-i
	 if i<TP_PLAYABLE {
	  if mStatus!ST_CLOSED&(i=(TPfromTPEX(mFileType)))&(type.i!im.6) {
	   dispMainWnd=dispMainWnd|closing
	   func=FNC_STOP :gosub *exec_func
	   dispMainWnd=dispMainWnd^closing
	   i=im.5
	   type.i=im.6
	   func=FNC_PLAY+mFileIdx :gosub *exec_func
	   i=im.5
	  } else :type.i=im.6
	 } else :return_ FR_ERR
	 return_ type.i
	}

; �\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\
; DLL�Ȃǂ̎g�p����
;	����	prmex �Ȃǂ̓��e��j�󂵂Ȃ�
;		(FNC_LIST_ADD_FOLDER �_�C�A���O�Ȃǂ̂��߂̔z��)

	if funcid=FNC_LOADLIB {
	 ; COM �̎g�p����
	 if funcopt=IDX_LOAD_COM {
	  prm=0 :dllproc "CoInitialize",prm,1,D_OLE
	  ; �C���^�[�t�F�[�X�̃��\�b�h�Ăяo���p�}�V����̎w��
	  ; (lollipop ���W���[�����ꕔ�����j
	  ; CallMethod	... �C���^�[�t�F�[�X�̃��\�b�h�Ăяo���֐�
	  ;	prm=����,�����̐�,���\�b�h�̃C���f�b�N�X,�C���^�[�t�F�[�X�|�C���^
	  ;	�� ���\�b�h�̃C���f�b�N�X
	  ;		0	(Interface)	-> QueryInterface
	  ;		1	(Interface)	-> AddRef
	  ;		2	(Interface)	-> Release
	  dim CallMethod,11	; �֐��f�[�^�� (11*4>)$2A(>(10*4))
	  getptr pCallMethod,CallMethod
	  prm=pCallMethod,44,$40,pi :dllprocp FNC_VirtualProtect,prm,4
	  CallMethod = $8bec8b55, $d2851455, $458b1974, $0c4d8b08, $34ff03eb, $fa7d4988, $8b028b52, $14ff104d, $b805eb88, $80004003, $0000c3c9
	  ; SHBrowseForFolder �p�̃R�[���o�b�N�֐�������
	  ; (���傭�Ƃ���̃z�[���y�[�W��蔲��)
	  dim CallbackFunc,8
	  getptr pCallbackFunc,CallbackFunc
	  prm=pCallbackFunc,32,$40,pi :dllprocp FNC_VirtualProtect,prm,4
	  CallbackFunc = $08247c83, $8b147501, $ff102444, $68016a30, $00000466, $102474ff, $330450ff, $0010c2c0
	  return_ FR_DONE
	 }
	 ; DirectShow �̎g�p����
	 if funcopt=IDX_LOAD_DXS {
	  ; �֘A CLSID �̎擾
	  getclsid "{e436ebb3-524f-11ce-9f53-0020af0ba770}",dxs_clsid_FilterGraph
	  ; �֘A IID �̎擾
	  getiid "{00000000-0000-0000-c000-000000000046}",dxs_iid_IUnknown
	  getiid "{56a868a9-0ad4-11ce-b03a-0020af0ba770}",dxs_iid_IGraphBuilder
	  getiid "{56a868b1-0ad4-11ce-b03a-0020af0ba770}",dxs_iid_IMediaControl
	  getiid "{36b73880-c2c8-11cf-8b46-00805f6cef60}",dxs_iid_IMediaSeeking
	  getiid "{56a868b3-0ad4-11ce-b03a-0020af0ba770}",dxs_iid_IBasicAudio
	  getiid "{b196b28b-bab4-101a-b69c-00aa00341d07}",dxs_iid_ISpecifyPropertyPages
	  ; DLL �̓ǂݍ���
	  ll_libload D_OLEPRO,"olepro32.dll"
	  ll_getproc pfunc.FNC_OleCreatePropertyFrame	,"OleCreatePropertyFrame"	,D_OLEPRO
	  ll_getproc pfunc.FNC_CoTaskMemFree		,"CoTaskMemFree"		,D_OLE
	  return_ FR_DONE
	 }
	 ; Vox.dll �̎g�p�����Ɖ��
	 if funcopt=IDX_LOAD_VOX {
	  if func&FNC_CHANGE {
	   if D_VOX=0 {
	    if func&FNC_AUTO=0&(func&FNC_ON=0) :return_ 0
	    ll_libload D_VOX,"vox.dll"
	    if D_VOX=0 :gosub disable_allWnd :dialog "\"vox.dll\" was not found.",1,prgtitles :gosub enable_allWnd :return_ FR_ERR
	    ll_getproc pfunc.FNC_vox_Load	,"VoxLoad"		,D_VOX
	    ll_getproc pfunc.FNC_vox_SetLoop	,"VoxSetLoop"		,D_VOX
	    ll_getproc pfunc.FNC_vox_Play	,"VoxPlay"		,D_VOX
	    ll_getproc pfunc.FNC_vox_GetComment	,"VoxGetComment"	,D_VOX
	    ll_getproc pfunc.FNC_vox_ParseComment,"VoxParseComment"	,D_VOX
	    ll_getproc pfunc.FNC_vox_GetTotalTime,"VoxGetTotalTime"	,D_VOX
	    ll_getproc pfunc.FNC_vox_GetCurrentTime,"VoxGetCurrentTime"	,D_VOX
	    ll_getproc pfunc.FNC_vox_GetStatus	,"VoxGetStatus"		,D_VOX
	    ll_getproc pfunc.FNC_vox_Seek	,"VoxSeek"		,D_VOX
	    ll_getproc pfunc.FNC_vox_Pause	,"VoxPause"		,D_VOX
	    ll_getproc pfunc.FNC_vox_Release	,"VoxRelease"		,D_VOX
	    ll_getproc pfunc.FNC_vox_Delete	,"VoxDelete"		,D_VOX
	   } else {
	    if func&FNC_AUTO=0&(func&FNC_ON!0) :return_ 1
	    ll_libfree D_VOX
	    D_VOX=0
	   }
	  }
	  return_ D_VOX!0
	 }
	 ; vbmp3.dll �̎g�p�����Ɖ��
	 if funcopt=IDX_LOAD_VBMP3 {
	  if func&FNC_CHANGE {
	   if D_VBMP3=0 {
	    if func&FNC_AUTO=0&(func&FNC_ON=0) :return_ 0
	    ll_libload D_VBMP3,"vbmp3.dll"
	    if D_VBMP3=0 :gosub disable_allWnd :dialog "\"vbmp3.dll\" was not found.",1,prgtitles :gosub enable_allWnd :return_ FR_ERR
	    dllproc "vbmp3_init",prm,0,D_VBMP3
	    ll_getproc pfunc.FNC_vbmp3_open	,"vbmp3_open"	,D_VBMP3
	    ll_getproc pfunc.FNC_vbmp3_play	,"vbmp3_play"	,D_VBMP3
	    ll_getproc pfunc.FNC_vbmp3_getMpegInfo,"vbmp3_getMpegInfo",D_VBMP3
	    ll_getproc pfunc.FNC_vbmp3_getState,"vbmp3_getState",D_VBMP3
	    ll_getproc pfunc.FNC_vbmp3_seek	,"vbmp3_seek"	,D_VBMP3
	    ll_getproc pfunc.FNC_vbmp3_pause	,"vbmp3_pause"	,D_VBMP3
	    ll_getproc pfunc.FNC_vbmp3_restart	,"vbmp3_restart",D_VBMP3
	    ll_getproc pfunc.FNC_vbmp3_stop	,"vbmp3_stop"	,D_VBMP3
	    ll_getproc pfunc.FNC_vbmp3_close	,"vbmp3_close"	,D_VBMP3
	    ll_getproc pfunc.FNC_vbmp3_free	,"vbmp3_free"	,D_VBMP3
	   } else {
	    if func&FNC_AUTO=0&(func&FNC_ON!0) :return_ 1
	    dllprocp FNC_vbmp3_free,prm,0
	    ll_libfree D_VBMP3
	    D_VBMP3=0
	   }
	  }
	  return_ D_VBMP3!0
	 }
	 if funcopt=IDX_LOAD_MP3INFP {
	  if func&FNC_CHANGE {
	   gosub disable_allWnd
	   if D_MP3INFP=0 {
	    if func&FNC_AUTO=0&(func&FNC_ON=0) :gosub enable_allWnd :return_ 0
	    ll_libload D_MP3INFP,"mp3infp.dll"
	    if D_MP3INFP=0 {
	     dialog "\"mp3infp.dll\" was not found.",1,prgtitles
	    } else {
	     dllproc "mp3infp_GetVer",prm,0,D_MP3INFP
	     if dllret<$226 {
	      ll_libfree D_MP3INFP :D_MP3INFP=0
	      dialog "The version of mp3infp.dll is too old.\nplease download and install the newest version, then try again.",1,prgtitles
	     } else {
	      ll_getproc pfunc.FNC_mp3infp_ViewProp,	"mp3infp_ViewProp"	,D_MP3INFP
	      ll_getproc pfunc.FNC_mp3infp_Load,	"mp3infp_Load"		,D_MP3INFP
	      ll_getproc pfunc.FNC_mp3infp_mp3_GetTagType,"mp3infp_mp3_GetTagType",D_MP3INFP
	      ll_getproc pfunc.FNC_mp3infp_GetValue,	"mp3infp_GetValue"	,D_MP3INFP
	     }
	    }
	   } else {
	    if func&FNC_AUTO=0&(func&FNC_ON!0) :gosub enable_allWnd :return_ 1
	    ll_libfree D_MP3INFP
	    D_MP3INFP=0
	   }
	   ; �`�F�b�N���X�V
	   ;  ���j���[
	   mii.1=1 :mii.3=D_MP3INFP!0*8
	   setmii hmSetPlay,FNCM_LOADLIB+IDX_LOAD_MP3INFP
	   gosub enable_allWnd
	  }
	  ;  �I�u�W�F�N�g
	  if func&(FNC_CHANGE|FNC_REFRESH) {
	   repeat snChk
	    ii=chkid.cnt
	    if obj.ii^func&$FF00FFFF=0 :objprm ii,D_MP3INFP!0
	    chk_.cnt=chk.cnt
	   loop
	  }
	  return_ D_MP3INFP!0
	 }
	 ; DDE�̏������Ɖ��
	 /*
	 if funcopt=IDX_LOAD_DDE {
	  if func&FNC_CHANGE {
	   if dde_inst=0 {
	    if func&FNC_AUTO=0&(func&FNC_ON=0) :return_ 0
	    ; APPCMD_CLIENTONLY | CBF_FAIL_ALLSVRXACTIONS
	    ; | CBF_SKIP_ALLNOTIFICATIONS
	    i=0 :prm=pi,0,$3FF010,0
	    dllprocp FNC_DdeInitializeA,prm,4
	    dde_inst=i
	    ; EnumWindows �Ŏg�p����R�[���o�b�N�֐�
	    / *
	    dim CallbackFunc2,12
	    getptr pCallbackFunc2,CallbackFunc2
	    prm=pCallbackFunc2,48,$40,pi :dllprocp FNC_VirtualProtect,prm,4
	    CallbackFunc2   = $0824448b, $8b08488b, $ca3b0450, $c033057c, $8b0008c2, $748b5610
	    CallbackFunc2.6 = $34890824, $08488b8a, $48895e41, $0001b808, $08c20000, $00000000
	    * /
	   } else {
	    if func&FNC_AUTO=0&(func&FNC_ON!0) :return_ 1
	    dllprocp FNC_DdeInitializeA,dde_inst,1
	    dde_inst=0
	   }
	  }
	  return_ dde_inst!0
	 }
	 */
	 return_ FR_ERR
	}

; �\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\
; �X�N���v�g�����s

	if funcid=FNC_SCRIPT {
	 if func&FNC_STR=0 {
	  if funcopt<IDX_SCRIPT_USER {
	   repeat
	    if funcopt=0 :scrplus scrAreaMain :break
	    if funcopt=1 :scrplus scrAreaShow_Mode :break
	    if funcopt=2 :scrplus scrAreaShow_ModeEx :break
	    if funcopt=3 :scrplus scrAreaShow_FileInfo :break
	    if funcopt=4 :scrplus scrAreaShow_Tiphelp :break
	    if funcopt=5 :scrplus scrAreaDisp_ListArea :break
	    if funcopt=6 :scrplus scrAreaHide_ListArea :break
	    break
	   loop
	  } else {
	   i=funcopt-IDX_SCRIPT_USER
	   if i<0|(i>=snAreaUser) :return_ FR_ERR
	   script+=scrAreaUser.i
	   scrLine+=scrAreaUserLine.i
	  }
	 } else {
	  notemax_ funcopts
	  script+=funcopts
	  scrLine+=stat
	 }
	 return_ FR_DONE
	}

	return_ FR_IDLE


; �\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\
; (�f�o�b�O��ʗp�T�u���[�`��)
; �\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\

	#ifdef DEBUG
	*addlogfnc
	funcid=func_.funclv&$FF000000
	repeat
	 if funcid=$01000000 :s="OPEN_WND" :break
	 if funcid=$02000000 :s="OPEN_LISTAREA" :break
	 if funcid=$03000000 :s="OPEN_PROPERTY" :break
	 if funcid=$04000000 :s="OPEN_PARENTDIR" :break
	 if funcid=$05000000 :s="MINIMIZE" :break
	 if funcid=$06000000 :s="POPUP" :break
	 ;  ���y�Đ�
	 if funcid=$07000000 :s="PLAY" :break
	 if funcid=$08000000 :s="PAUSE" :break
	 if funcid=$09000000 :s="STOP" :break
	 if funcid=$0A000000 :s="MODE" :break
	 if funcid=$0B000000 :s="VOLUME" :break
	 if funcid=$0C000000 :s="SEEK" :break
	 if funcid=$0D000000 :s="GETTAGINFO" :break
	 ;if funcid=$0E000000 :s="GETSTATE" :break
	 ;  ���X�g�ҏW
	 if funcid=$0F000000 :s="LIST_REFRESH" :break
	 if funcid=$10000000 :s="LIST_ADD" :break
	 if funcid=$11000000 :s="LIST_ADD_FILE" :break
	 if funcid=$12000000 :s="LIST_ADD_FOLDER" :break
	 if funcid=$13000000 :s="LIST_SORT" :break
	 if funcid=$14000000 :s="LIST_CHECK" :break
	 if funcid=$15000000 :s="LIST_CLEAR" :break
	 if funcid=$16000000 :s="LIST_DELETE" :break
	 if funcid=$17000000 :s="LIST_RENAME" :break
	 if funcid=$18000000 :s="LIST_UP" :break
	 if funcid=$19000000 :s="LIST_DOWN" :break
	 if funcid=$1A000000 :s="XLT_LOAD" :break
	 if funcid=$1B000000 :s="XLT_SAVE" :break
	 ;  �X�L��
	 if funcid=$1C000000 :s="XSP_MODIFY" :break
	 if funcid=$1D000000 :s="XSP_LOAD" :break
	 if funcid=$1E000000 :s="XSS_LOAD" :break
	 if funcid=$1F000000 :s="XSS_SAVE" :break
	 if funcid=$20000000 :s="XMS_LOAD" :break
	 ;  �v���O�C��
	 if funcid=$21000000 :s="XPI_LOAD" :break
	 if funcid=$22000000 :s="XS_LOAD" :break
	 ;  ���̑�
	 if funcid=$23000000 :s="CLIP" :break
	 if funcid=$24000000 :s="SET" :break
	 if funcid=$25000000 :s="SET_SEARCH" :break
	 if funcid=$26000000 :s="SET_PLAYFUNC" :break
	 if funcid=$27000000 :s="LOADLIB" :break
	 if funcid=$30000000 :s="SCRIPT" :break
	 s="(?)"
	 break
	loop
	if funcid!$0E000000 {
	 i=func_.funclv
	 str i,24
	 ss=""
	 repeat funclv :ss+=" " :loop
	 addlog "FNC "+ss+"$"+i+"("+s+") -> "+funcret
	 int i
	}
	return
	#endif


; �\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\
;                                                              (c) arc@arcis
