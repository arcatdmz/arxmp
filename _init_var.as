
; �� arX MusicPlayer �ŗ��p����ϐ��Ȃǂ̏�����			_init_var.as
; �\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\

/* ���상�� �\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\

 �E���� as �t�@�C���ɂ���

	�ϐ��̐錾�Ə����ݒ�l�̑���A�|�b�v�A�b�v���j���[�̍\�z���s��

 �\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\ */


; �\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\
; �ϐ��̐錾
; �\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\

	prm=fi_p_,fi_p
	#define dim_(%1,%2)	dim %1,%2	:getptr i,%1 :ll_poke4 i,pfmo_info+prm.1 :prm.1+=4 :prmex=i,%2*4,$40,pi :dllprocp FNC_VirtualProtect,prmex,4
	#define sdim_(%1,%2)	sdim %1,%2	:getptr i,%1 :ll_poke4 i,pfmo_info+prm :prm+=4 :prmex=i,%2,$40,pi :dllprocp FNC_VirtualProtect,prmex,4
	#define sdima_(%1,%2,%3) sdim %1,%2,%3	:getptr i,%1 :ll_poke4 i,pfmo_info+prm :prm+=4 :prmex=i,%2*%3,$40,pi :dllprocp FNC_VirtualProtect,prmex,4

	; �ݒ�t�@�C�����e
	dim xstheader			,nxstheader	

	; �Đ����X�g�֘A�̏��Ɛݒ���e
	sdim_ list			,bufmax
	sdim list_			,bufmax
	dim linfo			,nlinfo
	sdim linfo_			,szlinfo_,nlinfo_

	; �Đ����̉��y�ɂ��Ă̏��
	dim_ minfo			,nminfo
		dup mScrollType		minfo.8
	sdima_ minfo_			,szminfo_,nminfo_
		sdim mScroll		,2560

	; �E�B���h�E�֘A�̏��Ɛݒ���e
	dim dinfo			,ndinfo

	; �t�@�C���ꗗ���
	sdim finfo_			,szfinfo_,nfinfo_

	; �X�L��/�O�Ϗ��
	dim_ sinfo			,nsinfo
	sdima_ sinfo_			,szsinfo_,nsinfo_
	dim sVar_type,svmax		; �X�L���ϐ����
	sdim sVar_dsc,64,svmax		; �V        ���e����
	sdim sVar_list,512,svmax	; �V        ���e�I�����ꗗ(\n��؂�)
	sdim sVar_listdsc,512,svmax	; �V        �I�����ꗗ���ڂ̐���(\n��؂�)
	sdim sVar,512,svmax		; �V        ���e

	; �������
	sdima_ langs,szlangs,nlangs

	; �X�N���v�g���
	sdim script			,bufmax
	sdim scrfunc			,5,2
	sdim scrprms			,512,16
	dim scr				,nscr

	; ���j���[���
	dim_ hmenu			,nhmenu

	; �Đ��@�\�̏��
	dim pf				,npf
	sdim pf_			,szpf_,npf_

	; �E�B���h�E���
	dim obj				,objmax,3
	;	obj.objid	/ �I�u�W�F�N�g�̎��@�\�ԍ�
	;	obj.objid.1	/ �I�u�W�F�N�g�ɓ\��t����ꂽ�r�b�g�}�b�v�I�u�W�F�N�g�̃n���h��
	;	obj.objid.2	/ �I�u�W�F�N�g�ɔ��������C�x���g���������郆�[�U�[��`�G���A�̔ԍ�
	dim chk				,chkmax
	dim chk_			,chkmax
	;	chk.cid		/ �`�F�b�N�{�b�N�X�̏��
	;	chk_.cid	/ �V(��ԕω����o�p)
	dim chkid			,chkmax
	;	chkid.cid	/ ID�� cid �̃`�F�b�N�{�b�N�X�́A�I�u�W�F�N�gID
	repeat objmax :obj.cnt=-1 :loop
	dim wi				,nwi		; ��ʏ��������

	; �t�@�C������
	sdima_ types			,sztypes,TP_PLAYABLE
	dim_ type			,TP_PLAYABLE

	; �t�H���_���
	sdima_ dir			,szdir,ndir


; �\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\
; ���擾�Ə����ݒ�l���
; �\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\

	; OS ��ʂ̎擾
	prm=148 :dllproc "GetVersionExA",pprm,1,D_KERNEL
	if prm.4=1&(prm.1>=10)|(prm.4=2&(prm.1>=5)) :oschk=1

	; ���[�U�[���̎擾
	ll_libload i,"advapi32"
	sdim prguser,64 :sdim user,64
	getptr prm,user :ii=64 :prm.1=pii
	dllproc "GetUserNameA",prm,2,i
	ll_libfree i
	repeat 1
	 if user=""		:break
	 if user="Guest"	:break
	 if user="guest"	:break
	 if user="����"		:break
	 if user="Administrator":break
	 prguser=" for "+user	:break
	loop

	; �t�H���_�p�X�̎擾
	prm=512,ps :dllproc "GetTempPathA",prm,2,D_KERNEL :tmpdir=s
	prm=ps,512 :dllproc "GetSystemDirectoryA",prm,2,D_KERNEL :sysdir=s
	datdir=exedir+"\\d\\"
	skndir=exedir+"\\s\\"
	extdir=exedir+"\\e\\"

	; �����̃t�@�C�������擾
	sdim myself,512
	prm=0,0,512
	getptr prm.1,myself
	dllproc "GetModuleFileNameA",prm,3,D_KERNEL
	; ���̃A�C�R���̃n���h�����擾
	prm=prm.1,0,0,0,1
	getptr prm.2,hIcon
	dllproc "ExtractIconExA",prm,5,D_SHELL

	; �V�X�e���F�u���V�̃n���h���擾
	prm=15 :dllprocp FNC_GetSysColorBrush,prm,1 :hSysBrush =dllret
	prm=16 :dllprocp FNC_GetSysColorBrush,prm,1 :hSysBrush2=dllret
	; �V�X�e���F�̎擾
	prm=15 :dllprocp FNC_GetSysColor,prm,1 :SysColor =dllret&$FF,dllret>>8&$FF,dllret>>16&$FF
	prm=16 :dllprocp FNC_GetSysColor,prm,1 :SysColor2=dllret&$FF,dllret>>8&$FF,dllret>>16&$FF

	; �����ݒ�l���
	sFileName=defxsp
	lReqRefresh=1
	lSearchType=$000010FF
	lDownDblItem=1
	dispTiphelp=1
	dispTaskbar=1
	mTasktray=prgtitles
	mScrollType=11,1,7,6,8
	types.TP_MP3="MP3 MP2 MP1 RMP"	:type.TP_MP3=PF_MCI
	types.TP_WMA="WMA"		:type.TP_WMA=PF_DXS
	types.TP_MID="MID MIDI RMI"	:type.TP_MID=PF_DXS
	types.TP_WAV="WAV WAVE"		:type.TP_WAV=PF_MCI
	types.TP_OGG="OGG"		:type.TP_OGG=PF_DLL
	types.TP_CDA="CDA"		:type.TP_CDA=PF_MCI
					 type.TP_MCI=PF_MCI
					 type.TP_DXS=PF_DXS


; �\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\
; �|�b�v�A�b�v���j���[�̍\�z
; �\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\

		nmenu hmMinfoSub
		imenu "�t���p�X"	,FNC_CLIP+IDX_CLIP_MINFO+4,0,hmMinfoSub
		imenu "�A���o���̃^�C�g��",FNC_CLIP+IDX_CLIP_MINFO+5,0,hmMinfoSub
		imenu "������"		,FNC_CLIP+IDX_CLIP_MINFO+6,0,hmMinfoSub
		imenu "�R�����g"	,FNC_CLIP+IDX_CLIP_MINFO+3,0,hmMinfoSub
		imenu "���y�t�@�C���̎��",FNC_CLIP+IDX_CLIP_MINFO+7,0,hmMinfoSub
		nmenu hmMinfoSubPf
		;imenu "MCI",FNC_CLIP+IDX_CLIP_MINFO+7,0,hmMinfoSub
	nmenu hmMinfo
	imenu "�����: "	,FNC_CLIP+IDX_CLIP_MINFO+1,0,hmMinfo
	imenu "�^�C�g��: "	,FNC_CLIP+IDX_CLIP_MINFO+2,0,hmMinfo
	imenu "�t�@�C����: "	,FNC_CLIP+IDX_CLIP_MINFO+0,0,hmMinfo
	imenu "���̑��̏����R�s�[",0,hmMinfoSub,hmMinfo
	imenu ""		,0,0,hmMinfo
	imenu "�v���p�e�B��\��",FNC_OPEN_PROPERTY|FNC_AUTO+IDX_CUR,0,hmMinfo
	imenu "�e�t�H���_���J��",FNC_OPEN_PARENTDIR|FNC_AUTO+IDX_CUR,0,hmMinfo
	imenu "����ʂ��J��"	,FNC_OPEN_WND|FNC_ON+widInfo,0,hmMinfo
	imenu "�Đ��Ɏg�p���Ă���d�g��",0,hmMinfoSubPf,hmMinfo
	nmenu hmPlay
	imenu "���̃t�@�C��"	,FNC_PLAY|FNC_AUTO+IDX_CUR_NEXT,0,hmPlay
	imenu "�O�̃t�@�C��"	,FNC_PLAY|FNC_AUTO+IDX_CUR_PREV,0,hmPlay
	imenu ""		,0,0,hmPlay
	imenu "�ꎞ��~/�Đ��ĊJ",FNC_PAUSE,0,hmPlay
	imenu "�Đ���~"	,FNC_STOP,0,hmPlay
	imenu "�I�𒆂̃t�@�C�����Đ�",FNC_PLAY|FNC_AUTO+IDX_SEL,0,hmPlay
	nmenu hmMode
	imenu "&NOR\t(�m�[�}��)",FNC_MODE|FNC_ON+PM_NOR,0,hmMode; �ʏ�Đ�
	imenu "RE&V\t(���o�[�X)",FNC_MODE|FNC_ON+PM_REV,0,hmMode; �t���Đ�
	imenu "RN&D\t(�����_��)",FNC_MODE|FNC_ON+PM_RND,0,hmMode; ����׏�
	imenu "RE&P\t(���s�[�g)",FNC_MODE|FNC_ON+PM_REP,0,hmMode; ��ȌJ��
	imenu "&STP\t(�X�g�b�v)",FNC_MODE|FNC_ON+PM_STP,0,hmMode; ��Ȓ�~
	imenu "&MDR\t(���R�[�h)",FNC_MODE|FNC_ON+PM_MDR,0,hmMode; �Ȋԋ�
				nmenu hmFavSaveSub
				; (���C�ɓ���ꗗ)
				; imenu "",FNCM_XLT_SAVE+fileidx
			nmenu hmFavSave
			imenu "�V�K�o�^",FNCM_XLT_SAVEEX,0,hmFavSave
			imenu "�㏑���ۑ�",0,hmFavSaveSub,hmFavSave
		nmenu hmFav
		imenu "���݂̍Đ����X�g��...",0,hmFavSave,hmFav
		imenu ""	,0,0,hmFav
		; (���C�ɓ���ꗗ)
		; imenu "",FNCM_XLT_LOAD+fileidx
		imenu ""	,0,0,hmFav
		imenu "�ꗗ�X�V",FNCM_XLT_LOADEX,0,hmFav
		imenu "�ҏW",FNCM_XPI_LOAD+IDX_XPI_CFGFAVORITE,0,hmFav
	nmenu hmList
	imenu "���C�ɓ���"	,0,hmFav,hmList
	imenu "�t�@�C����ǉ�"	,FNC_OBJ402+objList_AddFile,0,hmList
	imenu "�t�H���_��ǉ�"	,FNC_OBJ402+objList_AddFolder,0,hmList
	imenu "���O�����ёւ�"	,FNC_OBJ402+objList_Sort,0,hmList
	imenu "�S�t�@�C�����݊m�F",FNC_OBJ402+objList_CheckAll,0,hmList
	imenu ""		,0,0,hmList
	imenu "���X�g��ʂ��J��/����",FNC_OBJ402+objWindow_OpenList,0,hmList
			nmenu hmLanguage
			; (����t�@�C���ꗗ)
			; imenu "",FNC_XMS_LOAD+fileidx
			imenu ""	,0,0,hmLanguage
			imenu "�ꗗ�X�V",FNC_XMS_LOAD|FNC_REFRESH,0,hmLanguage
		nmenu hmSkinSub
		imenu "�����: "  ,FNC_CLIP+IDX_CLIP_SINFO+1,0,hmSkinSub
		imenu "�^�C�g��: ",FNC_CLIP+IDX_CLIP_SINFO+2,0,hmSkinSub
		imenu "�R�����g: ",FNC_CLIP+IDX_CLIP_SINFO+3,0,hmSkinSub
		imenu "����t�@�C��",0,hmLanguage,hmSkinSub
		nmenu hmSkinSubModify
		; (�ҏW���ڈꗗ)
		; imenu "",FNC_XSP_MODIFY+idx,0,hmSkinSubModify
		imenu "",0,0,hmSkinSubModify
		imenu "�t�@�C������ݒ��ǂݍ���",FNC_XSS_LOAD,0,hmSkinSubModify
		imenu "���݂̐ݒ���t�@�C���ɕۑ�����",FNC_XSS_SAVE,0,hmSkinSubModify
		imenu "���߂̐ݒ�ɖ߂�",FNC_XSP_MODIFY|FNC_OFF,0,hmSkinSubModify
	nmenu hmSkin
	; (�X�L���ꗗ)
	; imenu "",FNC_XSP_LOAD+fileidx,0,hmSkin
	imenu ""	,0,0,hmSkin
	imenu "�ꗗ�X�V",FNC_XSP_LOAD|FNC_REFRESH,0,hmSkin
	imenu ""	,0,0,hmSkin
	imenu "���݂̃X�L���̏��",0,hmSkinSub,hmSkin
	imenu "���݂̃X�L����ҏW",0,hmSkinSubModify,hmSkin
	nmenu hmPlugin
	; (�v���O�C���ꗗ)
	; imenu "",FNC_XPI_LOAD+fileidx,0,hmPlugin
	imenu ""	,0,0,hmPlugin
	imenu "�ꗗ�X�V",FNC_XPI_LOAD|FNC_REFRESH,0,hmPlugin
	nmenu hmScript
	; (�X�N���v�g�ꗗ)
	; imenu "",FNC_XS_LOAD|FNC_AUTO+fileidx,0,hmScript
	imenu ""	,0,0,hmScript
	imenu "�ꗗ�X�V",FNC_XS_LOAD|FNC_REFRESH,0,hmScript
	imenu "�ꗗ�ȊO�̃X�N���v�g�����s",FNC_XS_LOAD,0,hmScript
		nmenu hmSetListSub
		imenu "M&PEG Audio",FNCM_SET_SEARCH+TP_MP3,0,hmSetListSub
		imenu "WindowsMedia&Audio",FNCM_SET_SEARCH+TP_WMA,0,hmSetListSub
		imenu "Mi&di",FNCM_SET_SEARCH+TP_MID,0,hmSetListSub
		imenu "&Wave",FNCM_SET_SEARCH+TP_WAV,0,hmSetListSub
		imenu "&OggVorbis",FNCM_SET_SEARCH+TP_OGG,0,hmSetListSub
		imenu "&CD Audio",FNCM_SET_SEARCH+TP_CDA,0,hmSetListSub
		imenu "(��L�ȊO��)&MCI�ōĐ��ł���t�@�C��",FNCM_SET_SEARCH+TP_MCI,0,hmSetListSub
		imenu "(�V)&DirectShow�ōĐ��ł���t�@�C��",FNCM_SET_SEARCH+TP_DXS,0,hmSetListSub
		imenu "",0,0,hmSetListSub
		imenu "�T�u�t�H���_�̒��g(&S)",FNCM_SET_SEARCH+TP_DIR,0,hmSetListSub
		imenu "���X�g�t�@�C���̒��g(&L)",FNCM_SET_SEARCH+TP_XLT,0,hmSetListSub
		imenu "",0,0,hmSetListSub
		imenu "�S�ĂɃ`�F�b�N��t��/�O��(&A)",FNCM_SET_SEARCHEX,0,hmSetListSub
		nmenu hmSetList
		imenu "�d���t�@�C���͍ŉ��s�Ɉړ�",FNCM_SET+IDX_SET_LIST_DOWNDBLITEM,0,hmSetList
		imenu "���X�g�t�@�C���͐V�K�Đ����X�g�ɓǍ�",FNCM_SET+IDX_SET_LIST_CLEARONLOAD,0,hmSetList
		nmenu hmSetDisp
		imenu "�{�^���ȂǂɃ`�b�v�w���v��\��",FNCM_SET+IDX_SET_DISP_TIPHELP,0,hmSetDisp
		imenu "���C����ʂ���ɍőO�ʕ\��",FNCM_SET+IDX_SET_DISP_ONTOP,0,hmSetDisp
		imenu "�^�X�N�g���C�ɏ�ɃA�C�R����\��",FNCM_SET+IDX_SET_DISP_TRAYICON,0,hmSetDisp
		imenu "(���C����ʕs��`��)�^�X�N�o�[�Ƀ^�C�g���\��",FNCM_SET+IDX_SET_DISP_TASKBAR,0,hmSetDisp
		nmenu hmSetPlay
		imenu "���y���̎擾�� mp3infp ���g�p",FNCM_LOADLIB+IDX_LOAD_MP3INFP,0,hmSetPlay
		imenu "�Đ����X�g���J�Ԃ��Đ�",FNC_OBJ402+objList_ChangeListLoop,0,hmSetPlay
		imenu "�N�����ɑO��I�����̍Đ��ӏ����Č�",FNCM_SET+IDX_SET_PLAY_REPLAY,0,hmSetPlay
		imenu "",0,0,hmSetPlay
		imenu "�Đ��Ɏg�p����d�g�݂̕ύX",FNCM_XPI_LOAD+IDX_XPI_SETPLAYFUNC,0,hmSetPlay
		imenu "�Đ��ł���t�@�C����̐ݒ�",FNCM_XPI_LOAD+IDX_XPI_SETPLAYTYPE,0,hmSetPlay
	nmenu hmSet
	imenu "�Đ����X�g�̓o�^�Ώ�",0,hmSetListSub,hmSet
	imenu "���X�g�ҏW",0,hmSetList,hmSet
	imenu "��ʕ\��",0,hmSetDisp,hmSet
	imenu "���y�Đ�",0,hmSetPlay,hmSet
	nmenu hmOnMain
	imenu "���y�̏��\t(&I)",0,hmMinfo,hmOnMain
	imenu "���y�̍Đ�\t(&P)",0,hmPlay,hmOnMain
	imenu "�Đ����[�h\t(&M)",0,hmMode,hmOnMain
	imenu "�Đ����X�g\t(&L)",0,hmList,hmOnMain
	imenu ""		,0,0,hmOnMain
	imenu "�X�L��\t(&S)"	,0,hmSkin,hmOnMain
	imenu "�v���O�C��\t(&P)",0,hmPlugin,hmOnMain
	imenu "�X�N���v�g\t(&X)",0,hmScript,hmOnMain
	imenu "�ݒ�@�@�@\t(&C)",0,hmSet,hmOnMain
	imenu ""		,0,0,hmOnMain
	imenu "�ŏ����@\t(&Z)"	,FNC_MINIMIZE|FNC_AUTO,0,hmOnMain
	imenu "���ʂ̒���\t(&V)",FNC_XPI_LOAD|FNC_AUTO+IDX_XPI_VOLUME,0,hmOnMain
	imenu "�w���v�̕\��\t(&H)",FNC_XPI_LOAD|FNC_AUTO+IDX_XPI_HELP,0,hmOnMain
	imenu "�v���C���[�̏I��\t(&Q)",FNC_OPEN_WND+widMain,0,hmOnMain

	nmenu hmListSel
	imenu "���ֈړ�"	,FNC_LIST_UP|FNC_AUTO+IDX_SEL,0,hmListSel
	imenu "����ֈړ�"	,FNC_LIST_DOWN|FNC_AUTO+IDX_SEL,0,hmListSel
	imenu "���ڂ̍폜"	,FNC_LIST_CLEAR|FNC_AUTO+IDX_SEL,0,hmListSel
	imenu "���ݔ��Ɏ̂Ă�"	,FNC_LIST_DELETE|FNC_AUTO+IDX_SEL,0,hmListSel
	imenu "���O��ύX"	,FNC_LIST_RENAME|FNC_AUTO+IDX_SEL,0,hmListSel
	imenu ""		,0,0,hmListSel
	imenu "�Đ�"		,FNC_PLAY|FNC_AUTO+IDX_SEL,0,hmListSel
	imenu "�v���p�e�B��\��",FNC_OPEN_PROPERTY|FNC_AUTO+IDX_SEL,0,hmListSel
	imenu "�e�t�H���_���J��",FNC_OPEN_PARENTDIR|FNC_AUTO+IDX_SEL,0,hmListSel
	nmenu hmOnList
	imenu "�I������",0,hmListSel,hmOnList
	imenu ""		,0,0,hmOnList
	imenu "���C�ɓ���"	,0,hmFav,hmOnList
	imenu "�t�@�C����ǉ�"	,FNC_LIST_ADD_FILE,0,hmOnList
	imenu "�t�H���_��ǉ�"	,FNC_LIST_ADD_FOLDER,0,hmOnList
	imenu "���O�����ёւ�"	,FNC_LIST_SORT|FNC_ALL,0,hmOnList
	imenu "�S�t�@�C�����݊m�F",FNC_LIST_CHECK|FNC_ALL,0,hmOnList
	imenu "�ݒ� - ���X�g�ҏW",0,hmSetList,hmOnList
	imenu "�ݒ� - �Đ����X�g�̓o�^�Ώ�",0,hmSetListSub,hmOnList


; �\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\
;                                                              (c) arc@arcis
