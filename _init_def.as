
; �� arX MusicPlayer �Ɋւ����`				_init_def.as
; �\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\

/* ���상�� �\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\

 �E���� as �t�@�C���ɂ���

	�v���O�C���Ƌ��ʂ̒�`��� 05/03/15��

 �\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\ */

	#const X_DEF		1

; �\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\
; 1. �@�\�ԍ�
; �\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\

	; �@�\�ԍ�
	;  ��ʊ֘A
	#const FNC_OPEN_WND		$01000000
	#const FNC_OPEN_LISTAREA	$02000000
	#const FNC_OPEN_PROPERTY	$03000000
	#const FNC_OPEN_PARENTDIR	$04000000
	#const FNC_MINIMIZE		$05000000
	#const FNC_POPUP		$06000000
	;  ���y�Đ�
	#const FNC_PLAY			$07000000
	#const FNC_PAUSE		$08000000
	#const FNC_STOP			$09000000
	#const FNC_MODE			$0A000000
	#const FNC_VOLUME		$0B000000
	#const FNC_SEEK			$0C000000
	#const FNC_GETTAGINFO		$0D000000
	#const FNC_GETSTATE		$0E000000
	;  ���X�g�ҏW
	#const FNC_LIST_REFRESH		$0F000000
	#const FNC_LIST_ADD		$10000000
	#const FNC_LIST_ADD_FILE	$11000000
	#const FNC_LIST_ADD_FOLDER	$12000000
	#const FNC_LIST_SORT		$13000000
	#const FNC_LIST_CHECK		$14000000
	#const FNC_LIST_CLEAR		$15000000
	#const FNC_LIST_DELETE		$16000000
	#const FNC_LIST_RENAME		$17000000
	#const FNC_LIST_UP		$18000000
	#const FNC_LIST_DOWN		$19000000
	#const FNC_XLT_LOAD		$1A000000
	#const FNC_XLT_SAVE		$1B000000
	;  �X�L��
	#const FNC_XSP_MODIFY		$1C000000
	#const FNC_XSP_LOAD		$1D000000
	#const FNC_XSS_LOAD		$1E000000
	#const FNC_XSS_SAVE		$1F000000
	#const FNC_XMS_LOAD		$20000000
	;  �v���O�C��
	#const FNC_XPI_LOAD		$21000000
	#const FNC_XS_LOAD		$22000000
	;  ���̑�
	#const FNC_CLIP			$23000000
	#const FNC_SET			$24000000
	#const FNC_SET_SEARCH		$25000000
	#const FNC_SET_PLAYFUNC		$26000000
	#const FNC_LOADLIB		$27000000
	#const FNC_SCRIPT		$30000000

	;  �{�^���ȊO�̃I�u�W�F�N�g
	#const FNC_PLAYLIST		$E0000000
	#const FNC_PLAYLISTC		$E1000000


; �\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\
; 2. �@�\�I�v�V����
; �\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\

	#const OBJ_CHKBOX	$00020000	; �I�u�W�F�N�g�Ƃ��Đݒu����鎞�`�F�b�N�{�b�N�X�ɂ���
	#const FNC_STR		$00040000	; ������I�v�V�������܂�
	#const FNC_ALL		$00100000	; �S�Ă̍���
	#const FNC_AUTO		$00080000	; �@�\��������
	#const FNC_ON		$00200000	; ON
	#const FNC_OFF		$00400000	; OFF
	#const FNC_CHANGE	$00680000	; FNC_ON, FNC_OFF, FNC_AUTO �̘a
						; (�ݒ�ύX�̗L�����ʗp)
	#const FNC_REFRESH	$00800000	; �ꗗ�X�V
	#const IDX_SEL		0	; |FNC_AUTO+..	�� �I������Ă��鍀�ڂ�..
	#const IDX_CUR		1	; |   �V   +..	�� �Đ�����Ă��鍀�ځV
	#const IDX_CUR_NEXT	2	; |   �V   +..	�� �Đ�����Ă��鍀�ڂ̎��V
	#const IDX_CUR_PREV	3	; |   �V   +..	�� �Đ�����Ă��鍀�ڂ̑O�V
	#const IDX_CLIP_MINFO	0	; +FNC_CLIP	�� ���y�����N���b�v�{�[�h�ɃR�s�[
	#const IDX_CLIP_SINFO	16	; +     �V	�� ���y�����N���b�v�{�[�h�ɃR�s�[
	#const IDX_XPI_HELP	1	; +FNC_XPI_LOAD	�� �w���v�\��
	#const IDX_XPI_VOLUME	2	; +     �V	�� Windows�̉��ʒ���
	#const IDX_XPI_SETPLAYFUNC 3	; +     �V	�� �f�R�[�_�I��
	#const IDX_XPI_SETPLAYTYPE 4	; +     �V	�� �Đ��\��I��
	#const IDX_XPI_CFGFAVORITE 5	; +     �V	�� ���C�ɓ���ҏW
	#const IDX_LOAD_COM	0	; +FNC_LOADLIB	�� COM �̏�����
	#const IDX_LOAD_DXS	1	; +     �V	�� DirectShow �̏�����
	#const IDX_LOAD_VOX	2	; +     �V	�� vox.dll ���g�p
	#const IDX_LOAD_VBMP3	3	; +     �V	�� vbmp3.dll ���g�p
	#const IDX_LOAD_MP3INFP	4	; +     �V	�� mp3infp.dll ���g�p
	;#const IDX_LOAD_DDE	5	; +     �V	�� DDE �̏�����
	#const IDX_SCRIPT_USER	16	; +FNC_SCRIPT	�� ���[�U�[��`�G���A�̃X�N���v�g�����s
	#const IDX_WND_MINFO	$0000	; +FNC_OPEN_WND �� �ȏ��
	#const IDX_WND_RENAME	$0100	; +     �V      �� �t�@�C�����ύX
	#const IDX_WND_FAVORITE	$0200	; +     �V      �� ���C�ɓ��薼����
	#const IDX_WND_SKV	$0400	; +   �V + SV_* �� �X�L���ϐ��ҏW���
	#const IDX_WND_INPUT	$0700	; RENAME, FAVORITE, SKV�̘a
					; (����ʕ\�����e���ʗp)
	#const IDX_SET_LIST_CLEARONLOAD	16; +FNC_SET	�� �ݒ�l�ύX
	#const IDX_SET_LIST_DOWNDBLITEM	17; +  �V
	#const IDX_SET_DISP_ONTOP	32; +  �V
	#const IDX_SET_DISP_TIPHELP	33; +  �V
	#const IDX_SET_DISP_TRAYICON	34; +  �V
	#const IDX_SET_DISP_TASKBAR	35; +  �V
	#const IDX_SET_PLAY_REPLAY	48; +  �V


; �\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\
; 3. ���̑��̐ݒ�l
; �\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\

	; �v���C���[�̃E�B���h�EID
	#const widMain		0	; ���C�����
	#const widRegion	3	; ���C�����(�g����/�s��`)
	#const widBuffer	4	; �X�L���p�o�b�t�@
	#const widInfo		5	; ���ړI���
	#const widList		6	; ���X�g���
	#const widExt		16	; �Đ��Ɏg�p����d�g�ݕ\�����

	; �Đ����[�h�l
	#const PM_NOR		0	; �ʏ�Đ�
	#const PM_REV		1	; �t���Đ�
	#const PM_RND		2	; �����_���Đ�
	#const PM_REP		3	; ���s�[�g�Đ�
	#const PM_STP		4	; ��ȂŒ�~
	#const PM_MDR		5	; �Ȋԋ󔒍Đ�
	#const PM_REPLIST	16	; �Đ����X�g���J��Ԃ��Đ�

	; �Đ���Ԓl
	#const ST_CLOSED	0	; ��~
	#const ST_STOPPED	1	; �Đ��I��
	#const ST_PLAYING	2	; �Đ���
	#const ST_PAUSED	3	; �ꎞ��~��

	; ���y�̎�ޒl�Ȃ�
	#const global TP_PLAYABLE 8	; ������Ԃł̍Đ��\�퐔
	#const global TP_MP3	0	; MP3
	#const global TP_WMA	1	; WMA
	#const global TP_MID	2	; MIDI
	#const global TP_WAV	3	; WAVE
	#const global TP_OGG	4	; OggVorbis
	#const global TP_CDA	5	; CD-Audio
	#const global TP_MCI	6	; MCI �ōĐ��ł��鉹�y�t�@�C��
	#const global TP_DXS	7	; DirectShow �ōĐ��ł��鉹�y�t�@�C��
	#const global TP_DIR	12	; �f�B���N�g��
	#const global TP_XLT	13	; ���X�g�t�@�C��
	#const global TP_OTH	-1	; ��
	#const global TPEX_MP3	$000001
	#const global TPEX_WMA	$000002
	#const global TPEX_MID	$000004
	#const global TPEX_WAV	$000008
	#const global TPEX_OGG	$000010
	#const global TPEX_CDA	$000020
	#const global TPEX_DEF	$00003F	; �ȏ�̍��v
	#const global TPEX_MCI	$000040
	#const global TPEX_DXS	$000080
	#const global TPEX_DIR	$001000	; �f�B���N�g��
	#const global TPEX_XLT	$002000	; ���X�g�t�@�C��
	#const global TPEX_ALL	$0030FF	; �ȏ�̍��v
	#const global TPEX_XSP	$010000	; �X�L��
	#const global TPEX_XPI	$020000	; �v���O�C��
	#const global TPEX_XMS	$040000	; ����t�@�C��
	#const global TPEX_XSS	$080000	; �X�L���ݒ�t�@�C��
	#const global TPEX_XS	$100000	; �X�N���v�g�t�@�C��
	#const global TPEX_ARC	$200000	; ���Ƀt�@�C��
	#const global TPEX_IMG	$400000	; �摜�t�@�C��
	#const global TPEX_EXE	$800000	; ���s�t�@�C��

	; �Đ���@�l
	#const PF_MCI		$1000	; MCI �ōĐ�
	#const PF_DXS		$2000	; DirectShow �ōĐ�
	#const PF_DLL		$3000	; ���̑��̓���� DLL ��p���čĐ�


; �\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\
;                                                              (c) arc@arcis
