
.:: �ݒ�̕ύX - FNC_SET

.::		ON�ɂ��邩�� FNC_ON $00200000 �𑫂�
.::		(OFF�ɂ���Ȃ� FNC_OFF $00400000 �𑫂��Ηǂ�)

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

.:: �Đ����X�g�̓o�^�ΏەύX - FNC_SEARCH

exefunc=%f.$252031FF%

.::		���ʎl���͈ȉ��̒l��K�X�g�ݍ��킹��;
.::			TPEX_MP3	$00000001
.::			TPEX_WMA	$00000002
.::			TPEX_MID	$00000004
.::			TPEX_WAV	$00000008
.::			TPEX_OGG	$00000010
.::			TPEX_CDA	$00000020
.::			(TPEX_DEF	$0000003F - �����܂ł̍��v)
.::			TPEX_MCI	$00000040
.::			TPEX_DXS	$00000080
.::			TPEX_DIR	$00001000 - �f�B���N�g��
.::			TPEX_XLT	$00002000 - ���X�g�t�@�C��
.::			(TPEX_ALL	$000031FF - �����܂ł̍��v)

.:: DLL�̓ǂݍ��� - FNC_LOADLIB

.::		mp3infp.dll
exefunc=%f.$27200004%

.:: �Đ����[�h�̕ύX - FNC_MODE

exefunc=%f.$0A200010%
