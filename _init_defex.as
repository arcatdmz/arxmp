
; �� arX MusicPlayer �Ɋւ����`(2)			      _init_defex.as
; �\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\

/* ���상�� �\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\

 �E���� as �t�@�C���ɂ���

	�v���C���[�N�����ɕύX����Ȃ��l�X�ȏ��������Œ�`���Ă���

 �\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\ */

	#const X_DEFEX		1

; �\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\
; 1. �F�X�B
; �\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\

	; �E�B���h�E���b�Z�[�WID
	#const WM_EXECFUNC	$550
	#const WM_TASKTRAY	$552
	#const WM_NOTIFYPI	$550
	#const WM_CLOSE		$010
	#const WM_KEYUP		$101
	#const WM_COMMAND	$111
	#const WM_LBUTTONDOWN	$201
	#const WM_LBUTTONUP	$202
	#const WM_LBUTTONDBLCLK	$203
	#const WM_RBUTTONUP	$205
	#const WM_DROPFILES	$233
	#const WM_MOUSEMOVE	$200
	#const WM_MOUSELEAVE	$2A3
	; ���̑� Windows �̎w�肷��萔
	#const LB_ADDSTRING	$180
	#const LB_INSERTSTRING	$181
	#const LB_DELETESTRING	$182
	#const LB_SETCURSEL	$186
	#const CB_ADDSTRING	$143
	#const CB_DELETESTRING	$144
	#const CB_INSERTSTRING	$14A
	#const CB_SETCURSEL	$14E
	#const VK_RETURN	$0D
	#const VK_DELETE	$2E
	#const VK_APPS		$5D

	; �v���C���[�̐���l
	#const bufmax		65536	; ������f�[�^�̍ő咷(bytes)
	#const objmax		64	; �ݒu�ł���I�u�W�F�N�g�̍ő吔
	#const chkmax		64	; �V�@�@�@�@�`�F�b�N�{�b�N�X�@�V
	#const svmax		16	; �X�L���ϐ��̍ő吔

	; ���Ԃ̐ݒ�
	#const TI_REFRESH	4	; ���[�v2�񂲂Ƃɉ�ʂ��X�V
	#const TI_SCROLL	10	; ���[�v10�񂲂ƂɃX�N���[���������i�߂�
	#const TI_TITLE		20	; ���[�v20��̊ԁA�ύX�����^�C�g����ێ�

	; �X�L���ϐ��̎�ޒl
	#const SV_COLOR		0	; �F
	#const SV_STR		1	; ������
	#const SV_IMAGE		2	; �摜
	#const SV_INT		3	; ���l
	#const SV_FONT		4	; �t�H���g
	#const SV_LIST		5	; �ꗗ����I��

	; �v���O�C���֘A�l
	;  (cf.) arxmp.as & _func.as
	#const NP_FUNCRET	0	; �v���O�C���ւ̋@�\���s���ʒʒm
	#const NP_ST		1	; �v���O�C���ւ̍Đ���ԕύX�ʒm
	;  (cf.) _init_var.as
	#define global fmo_info	"arxmp_info"	; FileMappingObject�̖��O
	#const global szfmo_info	160	; �S���T�C�Y
	#const global fi_p		32	; �|�C���^���(1)�I�t�Z�b�g
	#const global fi_p_		64	; �@�@�V�@�@�@(2)�@�V
	#const global szfmo_send	32	; �e�n���h�����̈�̃T�C�Y
	#const global fi_send_mStatus	96	; �Đ��󋵂�ʒm����E�B���h�E�̃n���h�����I�t�Z�b�g
	#const global fi_send_onexit	128	; �I�����ɘA��������@�V

	; ���̑��̒l
	#define type_minfo	"�t���p�X\ņ�ٖ�\n�����\n�^�C�g��\n�A���o��\n������\n�R�����g\n̫�ϯ�\ņ�ٻ���\n����\n����\n�ʂ��ԍ�\n����"
	#define mci_alias	"arxmp"		; MCI�̃G�C���A�X��
	#define sep		" - "	; �^�C�g�����Ȃ��L��
	#define defxsp		"�����ݒ�.xsp"	;
	#define defxms		"�����ݒ�.xms"	;
	#define defxlt		"���C�ɓ���"	;
	;#define defdde_dir extdir+"TMIDI Player\\"
	;#define defdde_name "TMIDI"		;
	#const xstgenuine	$74737821	; �ݒ�t�@�C���̃w�b�_�l
	#const initializing	$0F000000	; ���������ł��邱�Ƃ������l
	#const closing		$0E000000	; �I�����ł��邱�Ƃ������l
	#const hovering		$0F000000	; �}�E�X���{�^����ɂ��邱�Ƃ������l


; �\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\
; 2. �ϐ����Ɋւ����`
; �\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\

	; notesel, dirlist �p�ϐ��̏����T�C�Y
	#const bufnd			64

	; DLL�̃n���h��
	#const nD			10
	dim D,nD
		#define D_GDI		D
		#define D_USER		D.1
		#define D_SHELL		D.2
		#define D_KERNEL	D.3
		#define D_COMDLG	D.4
		#define D_OLE		D.5
		#define D_VOX		D.6
		#define D_VBMP3		D.7
		#define D_MP3INFP	D.8
		#define D_OLEPRO	D.9

	; �ݒ�t�@�C�����e
	#const nxstheader		48
		#define setVmain	xstheader.1	; �O��N�����̃v���C���[�̃o�[�W����
		#define MainWndX	xstheader.2	; ���C����ʈʒu(�w���W)
		#define MainWndY	xstheader.3	; �V		(�x���W)
		#define ListWndX	xstheader.4	; ���X�g��ʈʒu(�w���W)
		#define ListWndY	xstheader.5	; �V		(�x���W)
		#define ListWndWidth	xstheader.6	; �V�@�@�@�@��
		#define ListWndHeight	xstheader.7	; �V�@�@�@�@����

	; �Đ����X�g�֘A�̏��Ɛݒ���e
	#const nlinfo			10
		#define lNum		linfo		; �Đ����X�g�ɓo�^����Ă��鍀�ڐ�
		#define lLength		linfo.1		; �Đ����X�g�ɓo�^����Ă��鍀�ږ��S��
		#define lReqRefresh	linfo.2		; list_ �̓��e���X�V����K�v������(1)����(0)��
		#define lSelectedIdx	linfo.3		; �Đ����X�g�őI������Ă��鍀�ڂ̈ʒu
		#define lEditingIdx	linfo.4		; ���ݕҏW�ΏۂƂȂ��Ă��鍀�ڂ̈ʒu
		#define lSearchType	linfo.5		; �Đ����X�g�ɓo�^����ΏۂƂ��鍀�ڂ̎��
		#define lDownDblItem	linfo.6		; �d�����ڂ��ŉ��s�Ɉړ�����(1)����(0)��
		#define lClearOnLoad	linfo.7		; ���X�g�t�@�C���ǂݍ��ݎ��ɍĐ����X�g����U��������(1)����(0)��
		#define lMode		linfo.8		; �Đ����[�h
		#define lReplay		linfo.9		; �N�����̍Đ��ӏ��Č�
	#const nlinfo_			3
	#const szlinfo_			512
		#define lEditingFrom	linfo_		; �ҏW�ΏۂƂȂ��Ă���t�@�C���̌��̖��O
		#define lEditingDir	linfo_.1	; �ҏW�ΏۂƂȂ��Ă���t�@�C���̐e�t�H���_�̃p�X
		#define lCurDir		linfo_.2	; �����Ώۂ̃t�H���_�̃p�X

	; �Đ����̉��y�ɂ��Ă̏��
	#const nminfo			13
		#define mFileIdx	minfo		; �Đ����̉��y�̃��X�g���ł̈ʒu
		#define mFileType	minfo.1		; �V�@�@�@�@�@�@���(TPEX_*)
		#define mFileSize	minfo.2		; �V�@�@�@�@�@�@�t�@�C���T�C�Y[bytes]
		#define mStatus		minfo.3		; �V�@�@�@�@�@�@���(ST_*)
		#define mPosition	minfo.4		; �V�@�@�@�@�@�@�Đ��ʒu[ms]
		#define mDuration	minfo.5		; �V�@�@�@�@�@�@�S��[ms]
		#define mQuality	minfo.6		; �V�@�@�@�@�@�@����[kbps]
		#define mScrollWidth	minfo.7		; �V�@�@�@�@�@�@����\��������̉���[px]
		;dup mScrollType	minfo.8		; �V		�@�@�@�@�@�@�@�@�@���(minfo.8-12)
	#const nminfo_			9
	#const szminfo_			512
		#define mFileName	minfo_		; �V�@�@�@�@�@�@�t�@�C����
		#define mAuthor		minfo_.1	; �V�@�@�@�@�@�@�����
		#define mName		minfo_.2	; �V�@�@�@�@�@�@�^�C�g��
		#define mComment	minfo_.3	; �V�@�@�@�@�@�@�R�����g
		#define mFilePath	minfo_.4	; �V�@�@�@�@�@�@�t���p�X
		#define mAlbumName	minfo_.5	; �V�@�@�@�@�@�@�A���o���̃^�C�g��
		#define mRelDate	minfo_.6	; �V�@�@�@�@�@�@������
		#define mFormat		minfo_.7	; �V�@�@�@�@�@�@���̑��̏��
		#define mTasktray	minfo_.8	; �^�X�N�g���C�ɕ\��������
		;#define mScroll	minfo_.9	; �V�@�@�@�@�@�@����\��������(�X�N���[���p)

	; �E�B���h�E�֘A�̏��Ɛݒ���e
	#const ndinfo			16
		#define hwMainWnd	dinfo		; ���C����ʂ̃n���h��
		#define hwListWnd	dinfo.1		; ���X�g��ʂ̃n���h��
		#define hwInfoWnd	dinfo.2		; ����ʂ̃n���h��
		#define hwList		dinfo.3		; ���C����ʂɂ��郊�X�g�̃n���h��
		#define hwListSub	dinfo.4		; ���X�g��ʂɂ��郊�X�g�̃n���h��
		#define hIcon		dinfo.5		; �A�C�R���̃n���h��
		#define hSysBrush	dinfo.6		; �V�X�e���F�u���V�̃n���h��
		#define hSysBrush2	dinfo.7		; �V�@�@�@�@�@�@�@�@�@�@�@�@(�e�F)
		#define dispMainWnd	dinfo.8		; ���C����ʂ��őO�ʕ\������(+1)����(+0)���A�ŏ�������Ă���(+2)����(+0)��
		#define dispListWnd	dinfo.9		; ���X�g��ʂ�\�����Ă���(1)����(0)��
		#define dispInfoWnd	dinfo.10	; ���E�B���h�E��\�����Ă���(1 + (0,$100,$200,$*400))����(0)��
		#define dispListArea	dinfo.11	; ���X�g�̈��\�����Ă���(1)����(0)��
		#define dispTiphelp	dinfo.12	; �`�b�v�w���v��\�����Ă���(1)����(0)��
		#define dispTrayicon	dinfo.13	; �g���C�A�C�R�����펞�\������(1)����(0)��
		#define dispTaskbar	dinfo.14	; �^�X�N�o�[�Ƀ^�C�g����\������(1)����(0)��
		#define dispTitle	dinfo.15	; ���C����ʃ^�C�g���̕ύX�v��(1-)

	; �t�@�C���ꗗ���
	#const nfinfo_			5
	#const szfinfo_			16384
		#define fXSP		finfo_		; �X�L���ꗗ
		#define fXMS		finfo_.1	; ����t�@�C���ꗗ
		#define fXLT		finfo_.2	; ���X�g�t�@�C���ꗗ
		#define fXS		finfo_.3	; �X�N���v�g�t�@�C���ꗗ
		#define fXPI		finfo_.4	; �v���O�C���ꗗ

	; �X�L��/�O�Ϗ��
	#const nsinfo			23
		#define snAreaUser	sinfo		; ���[�U�[��`�G���A��
		#define snObj		sinfo.1		; �ݒu�I�u�W�F�N�g��
		#define snChk		sinfo.2		; �ݒu�`�F�b�N�{�b�N�X��
		#define snVar		sinfo.3		; �X�L���ϐ��̐�
		#define sWid		sinfo.4		; ���C�����ID
		#define sList		sinfo.5		; ���X�g��� (0 ���X�g�{�b�N�X,1 �R���{�{�b�N�X)
		#define sListArea	sinfo.6		; ���X�g�̈��� (0 �ʏ�,1 �X�N���[��,2 �ʉ�ʃ��X�g)
		#define sScrollStep	sinfo.7		;
		#define sScrollWidth	sinfo.8		;
		#define sDragX		sinfo.9
		#define sDragY		sinfo.10
		#define sDragWidth	sinfo.11
		#define sDragHeight	sinfo.12
		#define sSeekX		sinfo.13
		#define sSeekY		sinfo.14
		#define sSeekWidth	sinfo.15
		#define sSeekHeight	sinfo.16
		#define sSeekDirection	sinfo.17
		#define sEditingIdx	sinfo.18	; �ҏW���̃X�L���ϐ�ID
		#define MainWndWidth	sinfo.19
		#define MainWndHeight	sinfo.20
		#define ListAreaWidth	sinfo.21
		#define ListAreaHeight	sinfo.22
	#const nsinfo_			5
	#const szsinfo_			512
		#define sFileName	sinfo_		; ���݂̃X�L���̃t�@�C����
		#define sAuthor		sinfo_.1	; �V�@�@�@�@�@�@�����
		#define sName		sinfo_.2	; �V�@�@�@�@�@�@�^�C�g��
		#define sComment	sinfo_.3	; �V�@�@�@�@�@�@�R�����g
		#define sLanguage	sinfo_.4	; �V�@�@�@�@�@�Ɋ֘A�t����ꂽ����t�@�C��

	; �������
	; 11 + (PM_*)14 + (ST_*)4 + (TP_*)6+2 + (obj)41
	#const nlangs			79
	#const szlangs			256
	#const lgObj			32
	#const lgPMTI			73

	; �X�N���v�g���
	#const nscr			4
		#define scrVersion	scr
		#define scrType		scr.1
		#define scrTypeEx	scr.2
		#define scrLine		scr.3

	; ���j���[���
	#const nhmenu			24
		#define hmBar		hmenu
		#define hmOnMain	hmenu.1
		#define hmOnList	hmenu.2
		#define hmMinfo		hmenu.3
		#define hmMinfoSub	hmenu.4
		#define hmMinfoSubPf	hmenu.5
		#define hmPlay		hmenu.6
		#define hmMode		hmenu.7
		#define hmList		hmenu.8
		#define hmFav		hmenu.9
		#define hmFavSave	hmenu.10
		#define hmFavSaveSub	hmenu.11
		#define hmSkin		hmenu.12
		#define hmSkinSub	hmenu.13
		#define hmSkinSubModify	hmenu.14
		#define hmLanguage	hmenu.15
		#define hmPlugin	hmenu.16
		#define hmScript	hmenu.17
		#define hmSet		hmenu.18
		#define hmSetList	hmenu.19
		#define hmSetListSub	hmenu.20
		#define hmSetDisp	hmenu.21
		#define hmSetPlay	hmenu.22
		#define hmListSel	hmenu.23

	; �Đ��@�\�̏��
	#const npf			40
		; �v���p�e�B��
		#define npfprop			pf.35	;
		; DirectX DirectShow
		#define dxs_clsid_FilterGraph	pf	; CLSID	��
		#define dxs_iid_IUnknown	pf.4	; IID	�� �擾�ɂ��ꂼ�� 16byte �K�v
		#define dxs_iid_IGraphBuilder	pf.8	;	    (LONGLONG�^, �z�� 4 ��)
		#define dxs_iid_IMediaControl	pf.12	;
		#define dxs_iid_IMediaSeeking	pf.16	;
		#define dxs_iid_IBasicAudio	pf.20	;
		#define dxs_iid_ISpecifyPropertyPages pf.24;
		#define dxs_gb			pf.28	; ��LID�����Ɏ擾�����C���^�[�t�F�[�X
		#define dxs_mc			pf.29	;                   �ւ̃|�C���^�i�[�p
		#define dxs_ms			pf.30	;
		#define dxs_ba			pf.31	;
		; MCI
		#define mci_cdatrackstart	pf.32	; �g���b�N�̊J�n�ʒu
		#define mci_cdapaused		pf.33	; �ꎞ��~���Ă���(1)����(0)��
		; Vox
		#define vox_id			pf.34	; Vox.dll ���yID
		; DDE
		/*
		#define global dde_inst		pf@.36	; DDE�̃C���X�^���XID
		#define global dde_hconv	pf@.37	; DDE�̒ʐM�n���h��
		#define dde_hwnd		pf.38	; DDE�ʐM�̑���̃E�B���h�E�n���h��
		#define dde_idx			pf.39	; DDE�ʐM�̑��肪�ێ�����Đ����X�g���ł̍Đ��t�@�C���ʒu
		*/
	#const npf_			4
	#const szpf_			512
		; MCI
		#define mci_device		pf_	; �f�o�C�X��
		; DirectShow
		#define dxs_filter		pf_.1	; �t�B���^�ꗗ
		; DDE
		#define dde_dir			pf_.2	; DDE�T�[�o�[������t�H���_
		#define dde_name		pf_.3	; DDE�T�[�o�[�̃t�@�C����

	; �@�\���
	#const nfunc			4
		#define funcid		func.1		; func&$FFFF0000
		#define funcopt		func.2		; func&$0000FFFF
		#define funcret		func.3		; �Ԃ�l

	; �E�B���h�E���
	#const nwi			7

	; �t�@�C������
	; #const ntypes			TP_PLAYABLE
	; #const ntype			TP_PLAYABLE
	#const sztypes			256

	; ���̑��̏��
	#const nstt			3
		#define mainloop	stt
		#define hfmo_info	stt.1
		#define pfmo_info	stt.2

	; �t�H���_���
	#const ndir			5
	#const szdir			512
		#define skndir		dir
		#define datdir		dir.1
		#define extdir		dir.2
		#define sysdir		dir.3
		#define tmpdir		dir.4


; �\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\
; 3. �@�\�Ɋւ����`
; �\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\

	; �@�\�ԍ�
	#const FNC_OBJ402		700

	; �@�\�I�v�V����
	;#const OBJ_BUTTON	$00000000	;

	; �@�\�̕Ԃ�l
	#const FR_IDLE		$0F000001 ; ���ɈӖ��̖����l
	#const FR_ERR		$0F000000 ; ���s
	#const FR_DONE		$00000000 ; ����


; �\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\
; 4. ���j���[�o�[�̍���ID�Ɋւ����`
; �\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\

	; �ݒ�
	#const FNCM		$300
	#const FNCM_SET		$300
	#const FNCM_SET_SEARCH	$400
	#const FNCM_SET_SEARCHEX $500
	#const FNCM_XPI_LOAD	$600
	#const FNCM_LOADLIB	$700
	#const FNCM_XLT_LOAD	$800
	#const FNCM_XLT_LOADEX	$A00
	#const FNCM_XLT_SAVE	$B00
	#const FNCM_XLT_SAVEEX	$D00


; �\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\
; 5. �I�u�W�F�N�g���ʎq�Ƌ��@�\�ԍ��Ɋւ����`
; �\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\

	#const objs		41

	sdim obj_key,24,objs
	dim obj_func,objs

	; �E�B���h�E
	#const objWindow_OpenList	0
	#const objWindow_CloseList	1
	#const objWindow_OpenListArea	2
	#const objWindow_OpenInfo	3
	#const objWindow_MinimizeMain	5
	#const objWindow_ShowProperty	31
	#const objWindow_ShowFolder	4
	#const objMusic_CfgVolume	6
	#const objExit			30
	obj_key.objWindow_OpenList	="listwindow"
	obj_key.objWindow_CloseList	="closelistwindow"
	obj_key.objWindow_OpenListArea	="listarea"
	obj_key.objWindow_OpenInfo	="infowindow"
	obj_key.objWindow_MinimizeMain	="minimize"
	obj_key.objWindow_ShowProperty	="showproperty"
	obj_key.objWindow_ShowFolder	="showfolder"
	obj_key.objMusic_CfgVolume	="cfgvolume"
	obj_key.objExit			="exit"
	obj_func.objWindow_OpenList	=FNC_OPEN_WND|FNC_AUTO+widList
	obj_func.objWindow_CloseList	=FNC_OPEN_WND|FNC_OFF+widList
	obj_func.objWindow_OpenListArea	=FNC_OPEN_LISTAREA|FNC_AUTO
	obj_func.objWindow_OpenInfo	=FNC_OPEN_WND|FNC_AUTO+widInfo+IDX_WND_MINFO
	obj_func.objWindow_MinimizeMain	=FNC_MINIMIZE|FNC_AUTO
	obj_func.objWindow_ShowProperty	=FNC_OPEN_PROPERTY|FNC_AUTO+IDX_CUR
	obj_func.objWindow_ShowFolder	=FNC_OPEN_PARENTDIR|FNC_AUTO+IDX_CUR
	obj_func.objMusic_CfgVolume	=FNC_XPI_LOAD|FNC_AUTO+IDX_XPI_VOLUME
	obj_func.objExit		=FNC_OPEN_WND+widMain

	; ���j���[
	#const objMenu_PopupFavorite	7
	#const objFile_SaveFavorite	29
	#const objMenu_Popup		32
	obj_key.objMenu_PopupFavorite	="favorite"
	obj_key.objFile_SaveFavorite	="savefavr"
	obj_key.objMenu_Popup		="popup"
	obj_func.objMenu_PopupFavorite	=FNC_POPUP+9
	obj_func.objFile_SaveFavorite	=FNC_POPUP+10
	obj_func.objMenu_Popup		=FNC_POPUP+1

	; ���y�Đ�
	#const objMusic_Play		8
	#const objMusic_PlayPrev	9
	#const objMusic_PlayNext	10
	#const objMusic_Pause		11
	#const objMusic_Stop		12
	obj_key.objMusic_Play		="play"
	obj_key.objMusic_PlayPrev	="prev"
	obj_key.objMusic_PlayNext	="next"
	obj_key.objMusic_Pause		="pause"
	obj_key.objMusic_Stop		="stop"
	obj_func.objMusic_Play		=FNC_PLAY|FNC_AUTO+IDX_SEL
	obj_func.objMusic_PlayPrev	=FNC_PLAY|FNC_AUTO+IDX_CUR_PREV
	obj_func.objMusic_PlayNext	=FNC_PLAY|FNC_AUTO+IDX_CUR_NEXT
	obj_func.objMusic_Pause		=FNC_PAUSE
	obj_func.objMusic_Stop		=FNC_STOP

	; ���X�g�ҏW
	#const objMainlist		13	; ���X�g�{�b�N�X
	#const objMainlistc		14	; �R���{�{�b�N�X
	#const objList_AddFolderchk	15
	#const objList_ChangeMode	16
	#const objList_ChangeListLoop	38
	#const objList_AddFile		17
	#const objList_AddFolder	18
	#const objList_ClrFile		19
	#const objList_ClrAll		20
	#const objList_DelFile		21
	#const objList_RenameFile	22
	#const objList_CheckAll		23
	#const objList_Sort		24
	#const objList_MoveUpFile	25
	#const objList_MoveDownFile	26
	#const objList_Save		27
	#const objList_Load		28
	#const objList_ShowProperty	40
	#const objList_ShowFolder	39
	obj_key.objMainlist		="mainlist"
	obj_key.objMainlistc		="maincomlist"
	obj_key.objList_AddFolderchk	="addfolderchk"
	obj_key.objList_ChangeMode	="mode"
	obj_key.objList_ChangeListLoop	="repmode"
	obj_key.objList_AddFile		="addfile"
	obj_key.objList_AddFolder	="addfolder"
	obj_key.objList_ClrFile		="clearfile"
	obj_key.objList_ClrAll		="clearlist"
	obj_key.objList_DelFile		="delete"
	obj_key.objList_RenameFile	="rename"
	obj_key.objList_CheckAll	="checklist"
	obj_key.objList_Sort		="sortlist"
	obj_key.objList_MoveUpFile	="moveup"
	obj_key.objList_MoveDownFile	="movedown"
	obj_key.objList_Save		="savelist"
	obj_key.objList_Load		="loadlist"
	obj_key.objList_ShowProperty	="showproperty_s"
	obj_key.objList_ShowFolder	="showfolder_s"
	obj_func.objMainlist		=FNC_PLAYLIST
	obj_func.objMainlistc		=FNC_PLAYLISTC
	obj_func.objList_AddFolderchk	=FNC_SET_SEARCH|FNC_AUTO|OBJ_CHKBOX+TPEX_DIR
	obj_func.objList_ChangeMode	=FNC_MODE|FNC_AUTO
	obj_func.objList_ChangeListLoop	=FNC_MODE|FNC_AUTO+PM_REPLIST
	obj_func.objList_AddFile	=FNC_LIST_ADD_FILE
	obj_func.objList_AddFolder	=FNC_LIST_ADD_FOLDER
	obj_func.objList_ClrFile	=FNC_LIST_CLEAR|FNC_AUTO+IDX_SEL
	obj_func.objList_ClrAll		=FNC_LIST_CLEAR|FNC_ALL
	obj_func.objList_DelFile	=FNC_LIST_DELETE|FNC_AUTO+IDX_SEL
	obj_func.objList_RenameFile	=FNC_LIST_RENAME|FNC_AUTO+IDX_SEL
	obj_func.objList_CheckAll	=FNC_LIST_CHECK|FNC_ALL
	obj_func.objList_Sort		=FNC_LIST_SORT|FNC_ALL
	obj_func.objList_MoveUpFile	=FNC_LIST_UP|FNC_AUTO+IDX_SEL
	obj_func.objList_MoveDownFile	=FNC_LIST_DOWN|FNC_AUTO+IDX_SEL
	obj_func.objList_Save		=FNC_XLT_SAVE
	obj_func.objList_Load		=FNC_XLT_LOAD
	obj_func.objList_ShowProperty	=FNC_OPEN_PROPERTY|FNC_AUTO+IDX_SEL
	obj_func.objList_ShowFolder	=FNC_OPEN_PARENTDIR|FNC_AUTO+IDX_SEL

	; ���[�U�[��`
	#const objUserDef1		33
	#const objUserDef2		34
	#const objUserDef3		35
	#const objUserDef4		36
	#const objUserDef5		37
	obj_key.objUserDef1		="userdef1"
	obj_key.objUserDef2		="userdef2"
	obj_key.objUserDef3		="userdef3"
	obj_key.objUserDef4		="userdef4"
	obj_key.objUserDef5		="userdef5"
	obj_func.objUserDef1		=FNC_SCRIPT+IDX_SCRIPT_USER
	obj_func.objUserDef2		=FNC_SCRIPT+IDX_SCRIPT_USER+1
	obj_func.objUserDef3		=FNC_SCRIPT+IDX_SCRIPT_USER+2
	obj_func.objUserDef4		=FNC_SCRIPT+IDX_SCRIPT_USER+3
	obj_func.objUserDef5		=FNC_SCRIPT+IDX_SCRIPT_USER+4


; �\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\
; 6. ����(����)�Ɋւ����`
; �\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\

	#const lgs				12+20

	sdim lg_key,24,lgs

	#const lgWelcome		0	; �����p���肪�Ƃ��������܂��B
	#const lgDlg_ErrorFormat	1	; �w�肳�ꂽ%format%�͉��Ă��邩�A\n�܂��͖��Ή��̌`���ł��邽�ߓǂݍ��ނ��Ƃ��o���܂���ł����B\n%confirm%\n(%file%)
	#const lgDlg_ErrorNotFound	2	; �w�肳�ꂽ%format%�������炸�A�ǂݍ��ނ��Ƃ��o���܂���ł����B\n%confirm%\n(%file%)
	#const lgDlg_ErrorTooManyFiles	3	; �������ł��B
	#const lgDlg_ErrorOnSave	4	; �t�@�C�����̕ۑ��Ɏ��s���܂����B
	#const lgDlg_ConfirmClearFile	5	; �Đ����X�g����폜���܂����H\n
	#const lgDlg_Folder		6	; �t�@�C������������t�H���_��I��ł��������B
	#const lgDlg_Rename		7	; �ύX��̖��O����͂��Ă��������B
	#const lgDlg_Favorite		8	; ���C�ɓ���̓o�^�����V�B
	#const lgDlg_ConfirmDelete	9	; �w�肳�ꂽ���y�t�@�C�������ݔ��Ɏ̂ĂċX�����ł����H
	#const lgDlg_ConfirmClearAll	10	; �Đ����X�g����ɂ��ċX�����ł����H
	#const lgDlg_ConfirmOverwrite	11	; �w�肳�ꂽ���X�g�t�@�C���͊��ɑ��݂��܂��B�㏑�����ċX�����ł����H
	lg_key.lgWelcome		="Welcome"
	lg_key.lgDlg_ErrorFormat	="Err.format"
	lg_key.lgDlg_ErrorNotFound	="Err.notfound"
	lg_key.lgDlg_ErrorTooManyFiles	="Err.toomany"
	lg_key.lgDlg_ErrorOnSave	="Err.onsave"
	lg_key.lgDlg_ConfirmClearFile	="Sub.cfm"
	lg_key.lgDlg_Folder		="Dlg.folder"
	lg_key.lgDlg_Rename		="Dlg.rename"
	lg_key.lgDlg_Favorite		="Dlg.favorite"
	lg_key.lgDlg_ConfirmDelete	="Cfm.del"
	lg_key.lgDlg_ConfirmClearAll	="Cfm.clrall"
	lg_key.lgDlg_ConfirmOverwrite	="Cfm.overwrite"
	#const lgPM			12
	#const lgPMEX			18
	#const lgST			20
	#const lgTP			24
	lg_key.lgPM="Mode.nor","Mode.rev","Mode.rnd","Mode.rep","Mode.stp","Mode.mdr"
	lg_key.lgPMEX="RepMode.no","RepMode.yes"	
	lg_key.lgST="Status.stopped","Status.closed","Status.playing","Status.paused"
	lg_key.lgTP="Type.mp3","Type.wma","Type.mid","Type.wav","Type.ogg","Type.cda","Type.mci","Type.dxs"


; �\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\
;                                                              (c) arc@arcis
