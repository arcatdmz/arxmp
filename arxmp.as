
; �� arX MusicPlayer					      ���y�v���C���[
; �\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\

	; �ʏ�łƂ��Ĕz�z���̓R�����g�A�E�g
	;#const DEBUG	1

/* ���상�� �\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\

 �E�v���O�����̎d�l

	0. �\�[�X�R�[�h
	��=��=��=��=��=��=��=��=��=��=��=��=��=��=��=��=��=��=��=��=��=��=��

	�� as �t�@�C��	�@�@�� ax �t�@�C��	���@�\
	-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
	arxmp_start.as	�@�@start.ax		ax, xpi �t�@�C���̋N��
	arxmp.as	�@�@arxmp.ax		���C���̏���
	strmod.as	�@�@-			(���ߊg��, �����񑀍�֌W)
	_mod.as		�@�@-			(���ߊg��)
	_init_def.as	�@�@-			(��`, �v���O�C���Ƌ��L)
	_init_defex.as	�@�@-			(��`)
	_init_xpi.as	�@�@-			(�v���O�C���Ή��̏���)
	_init_var.as	�@�@-			(�ϐ��̈�̊m��)
	_func.as	�@�@-			(�@�\, �@�\�ԍ��̏���)
	_script.as	�@�@-			(�@�\, �X�N���v�g�̏���)
	_sub.as		�@�@-			(�@�\, �T�u���[�`��)
	cfgfavorite.as	�@�@cfgfavorite.ax	���C�ɓ���̕ҏW
	setplayfunc.as	�@�@setplayfunc.ax	�Đ��@�\�̐ݒ�
	setplaytype.as	�@�@setplaytype.ax	�Đ��\��̐ݒ�
	_mod_xpi.as	�@�@-			(���ߊg��, �v���O�C���p)

	1. �����Ή����f�B�A
	��=��=��=��=��=��=��=��=��=��=��=��=��=��=��=��=��=��=��=��=��=��=��

	�����			���Đ���@		���擾�\�ȃ^�O��
	-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
	MPEG Audio		MCI, DirectShow, vbmp3	MPEG�w�b�_, ID3v1
	Windows MediaAudio	MCI, DirectShow		�s��
	Midi			MCI, DirectShow, DDE	SMF���^�C�x���g
	Wave			MCI, DirectShow		�s��
	OggVorbis		MCI, DirectShow, vox	(vox �o�R��)�����^�O
	CD Audio		MCI, (DirectShow)	�s��

	�� �^�O���� mp3infp �𗘗p���邱�ƂŒǉ��擾��
	�� �Đ���@ MCI, DirectShow ���Ή����郁�f�B�A�Ȃ��L�ȊO�ł��Đ���

	2. �Đ����X�g
	��=��=��=��=��=��=��=��=��=��=��=��=��=��=��=��=��=��=��=��=��=��=��

	�i�[�\�ȍ��ڐ��͖������ł����A���X�g�{�b�N�X��R���{�{�b�N�X��64KB
	���̓��e��\���ł��Ȃ�Win9X�ɔz������ �t�@�C�������X�g�̑S���������
	�łɐ�������Ă��܂��B���X�g�ҏW���ɐ������z�����ꍇ�́A�x���\����64
	KB�ȍ~�̍��ڂ������I�ɍ���܂��B

	(cf. _func.as �uFNC_LIST_�`�v )

	3. �@�\�ԍ�
	��=��=��=��=��=��=��=��=��=��=��=��=��=��=��=��=��=��=��=��=��=��=��

	�v���C���[�̋@�\�̂قƂ�ǂɂ�16�i����8���̔ԍ����t�����Ă��܂��B

	��񌅂ő�܂��Ȏ�ނ��w�肵�A���̃j���ő�܂��ȓ���I�v�V�������A�c
	��񌅂ŏڍׂȃI�v�V�������w�肷��悤�ɂȂ��Ă��܂��B

	(cf. _func.as )
	(cf. http://hp.vector.co.jp/authors/VA022483/xmp/res/func.html )

	4. �X�N���v�g
	��=��=��=��=��=��=��=��=��=��=��=��=��=��=��=��=��=��=��=��=��=��=��

	�X�L���ȂǂŎg����Ǝ��̃C���^�v���^������u�X�N���v�g�v�ƌĂ�ł�
	�܂��Bhsp2.exe �� ax �t�@�C�������A���^�C���ɏ������� �l�X�ȃv���O��
	���Ƃ��Ă̋@�\���ʂ����悤�ɁAarxmp.exe �̓X�N���v�g�����A���^�C����
	�������邱�ƂŊO�ς�ς�����A�������������s���邱�Ƃ��ł��܂��B
	arxmp �� HSP �ŊJ�����ꂽ���Ƃ�����A���@������ HSP �Ɏ��Ă��܂��B

	(cf. _script.as )
	(cf. _func.as �uFNC_XSP_LOAD�ve.t.c. )
	(cf. http://hp.vector.co.jp/authors/VA022483/xmp/res/skin.html )
	(cf. http://hp.vector.co.jp/authors/VA022483/xmp/res/script.html )

	5. �v���O�C��
	��=��=��=��=��=��=��=��=��=��=��=��=��=��=��=��=��=��=��=��=��=��=��

	�v���O�C���ƌ����Ă��v�͊g���q�� xpi �ɕς��� ax �t�@�C���� �{�̂ƕ�
	�ɋN�����Ă��邾���ł��B hsgetmsg(���傭�Ƃ��񐻍�) �𗘗p���Ė{�̂�
	�v���O�C���ŃE�B���h�E���b�Z�[�W�̂��������邱�ƂŁA�v���O�C����
	��{�̂̋@�\�����s�����茋�ʂ��擾������ł���悤�ɂȂ��Ă��܂��B
	�܂��A�{�̑��ŋN������ FileMappingObject ���쐬���� �ϐ��̃|�C���^��
	���ۑ��A�v���O�C�����炻���ǂݍ���Ŗ{�̂̕ϐ����e�𑀍�ł����
	���ɂ��Ă���܂��B �v���O�C���� FMO �̎w��̈�Ɏ����̃E�B���h�E�n��
	�h������o�^���Ă����ƁA�C�x���g�������ɖ{�̂���E�B���h�E���b�Z�[
	�W�̒ʒm���󂯂���d�g�݂�����܂��B

	(cf. _init_xpi.as )
	(cf. _func.as �uFNC_XPI_LOAD�v )
	(cf. http://hp.vector.co.jp/authors/VA022483/xmp/res/plugin.html )
	(cf. http://hp.vector.co.jp/authors/VA022483/text.html�umbmod.as�v)

	6. �f�o�b�O�E�B���h�E
	��=��=��=��=��=��=��=��=��=��=��=��=��=��=��=��=��=��=��=��=��=��=��

	#const DEBUG 1 ���R�����g�A�E�g������ arxmp.as ���R���p�C������ƁA
	�f�o�b�O�E�B���h�E�t���� arxmp.ax ���쐬����܂��B

	���\�����e
		������
	-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
	BTN [window name] (id=[objid])
		[window name]��̃{�^��(�I�u�W�F�N�gID[objid])�̋@�\�����s
	MSG [message code]->[hwnd],[lprm],[wprm]
		[hwnd]�ɑ���ꂽ�E�B���h�E���b�Z�[�W(WM_*)[message code]������
	FNC [func]
		[func] �ŕ\�����@�\�����s(_func.as �Q��)
	CNV (menuid=[menuid])
		[menuid] ���@�\�ԍ��ɕϊ����Ď��s(_func.as �Q��)

 �E�ۑ�

	MPEG Audio (VBR) �ōĐ����ʒu�\������������(DirectShow Filter�̃o�O)
	CD�Đ����̏I���ŋH�Ƀ������A�N�Z�X�G���[���N����

 �E�X�V����

   ver.400(00)	2002/11/01	��2�Ƃ��Č��J
          (01)	2002/11/04	�����t�@�C���̎d�l�ύX
          (02)	2002/11/06	�g���X�N���v�g�̎d�l�ύX
          (03)	2002/11/07	�g���X�N���v�g�̎d�l�C���A�J�����g�f�B���N�g�����C���A�X�L���v���O���������C���A�����t�@�C�����ǂݍ��܂�Ȃ��o�O���C���B
          (04)	2002/11/09	�X�L���v���O�����̃o�O�C���A�t�H���_�ƃt�@�C���̒ǉ��_�C�A���O��ύX�A�t�@�C���̒ǉ����[�h�I���@�\�ǉ��A�h���b�O���h���b�v���ł��Ȃ��o�O���C���B
          (05)	2002/11/10	�����Ō�̏����ύX�B�t�H���_�𐳂����ǉ��ł��Ȃ��o�O���C���A�g���v���O�����̃o�O���C���B
          (06)	2002/11/11	�g���v���O�����̏����𒲐��B�`�b�v�w���v�ƃt�H���_�����I�v�V�������ۑ�����Ȃ��o�O���C���B�h���b�O���h���b�v�ɑΉ�������Ă��Ȃ������o�O���C���B
          (07)	2002/11/18	�X�L���X�N���v�g���s���ɗ�����o�O���C��
          (08)	2002/11/25	���C�ɓ����ǂݍ��߂Ȃ��o�O���C��
          (09)	2002/12/01	�����t�@�C�����ǂݍ��߂Ȃ��o�O���C���B�g���X�N���v�g�̖��߂��g���B
          (10)	2002/12/14	�X�L���ϐ��̑S�@�\������
          (11)	2002/12/14	���[�W�����E�B���h�E�쐬�̌�����
          (12)	2002/12/18	VBMP3.dll���g�p�\��
          (13)	2002/12/23	�X�L���̎d�l���g���A�X�N���v�g����������
          (14)	2002/12/24	�����ȃo�O���C��
          (15)	2002/12/25	�ق�̏����C��
          (16)	2003/01/11	�d�l�g���AMCI�ōĐ�����t�@�C�����ݒ�ł���悤�ɁA�X�L���̃o�O�C��
          (17)	2003/04/14	�d�l�g���A�Đ����X�g�J��Ԃ��I�v�V�����ǉ��A�Đ��ʒu�\���o�[�ǉ��Bhsplmenu.dll/Srexhsp.dll �s�g�p�ACD�Ή�
        (17.0)	2003/04/15	���X�g���̃t�@�C���������3�ƕ\�������o�O�C��/CD���Đ��ł��Ȃ��o�O�C��
        (17.1)	2003/04/19	���X�g�t�@�C���ǂݍ��݃o�O�C��/�E�B���h�E�T�C�Y�ʒm�o�O�C��
	(17.2)	2003/04/26	�L�[�{�[�h����̃T�|�[�g/�����ݒ�X�L�������ւ�/���ʒ���/�X�L���d�l�g��
   ver.401(00)	2003/05/02	�v���O�C���d�l����/�t�H���_�ǉ�������/�v���O�C�����썂����/�^�C�g�����ς��Ȃ��o�O�C��
        (00.0)	2003/05/18	�t�@�C���ǉ��@�\�̓���
        (00.1)	2003/05/21	�ǉ�����t�@�C����̊Ǘ����@��ύX(��������)
        (00.2)	2003/06/12	�h���b�O���h���b�v���ꂽ�t�@�C���̏������@�ύX(��������)
	(00.3)	2003/07/03	CD�Đ����̃o�O���C��
          (01)	2003/07/16	�o�O�C���A���������L���W���[������ASendMessage�Ή��A�v���O�C��EXE/LNK�Ή��A�t�@�C�����X�g�������ёւ��A�X�N���v�g�����g��
   ver.402(00)	2003/09/16	�o�O�C���AOggVorbis �����Ή��A�E�B���h�E�őO�ʕ\���@�\�ǉ�
          (01)	2003/10/12	�_�C�A���O���B���o�O�A�c�V�[�N�o�[���������\������Ȃ��o�O�A�h���b�O���h���b�v�ƃV�[�N�̗D�揇�ʕύX
          (01)	2003/10/29	mp3infp�ɑΉ��A�t�@�C���̃v���p�e�B�\���@�\�ǉ��A�t�H���_�I���_�C�A���O�\�����̃o�O�C��(?)
          (02)	2003/11/21	�E�N���b�N���j���[���Ӑ}���Ȃ���ʂŏo�Ă��܂��o�O�A�t�H���_���t�@�C���������ɗ�����o�O�A�s��`�E�B���h�E�ւ̃t�@�C���̃h���b�O���h���b�v���o���Ȃ��o�O���C���B�J������HSP2.55��2.6�ֈڍs�AJPEG�ǂݍ��݂��\�ɁB
          (02)	2003/12/01	WMA�t�@�C�����ǂݍ��ݎ��ɃG���[���N����o�O���C��
          (03)	2003/12/19	�Đ��I�����Ƀ��X�g�o�^�t�@�C���������Ɠǂݍ��݂����ݑ�����o�O�A���C����ʂɃ��X�g�������X�L���̎����X�g��ʂ̃��X�g��[Delete]�L�[�������ƃ��X�g���S���������o�O���C���Bmp3infp�g�p���ɓǂݍ���MP3�̃^�O�̗D�揇�ʂ�ύX�B�X�N���v�g�d�l�C�����g���B
          (04)	2003/12/24	�X�L���ύX���Ƀ`�b�v�w���v���\������Ȃ��Ȃ鎖������o�O���C���A���݂��Ȃ��X�L���ݒ�t�@�C���ƃX�N���v�g��ǂݍ������Ƃ������Ƀv���O�������G���[�ŏI������o�O���C���B�G���[���N���Ă��ݒ��ۑ����Ă���I������悤�ɉ��ǁB
          (05)	2004/01/02	�X�N���v�g����{�^���ƃ��j���[�̋@�\���Ăяo���Ȃ��o�O���C���B
	  (06)	2004/02/07	���X�g���̃t�@�C���폜���������A�Đ����̉��y�t�@�C���C���f�b�N�X�����X�g�ҏW���ɂ����o�O���C���A�^�X�N�g���C�ɏ�ɃA�C�R����\����������@�\��ǉ��B
	  (07)	2004/02/09	�Đ����X�g��ł̉E�N���b�N���ɕҏW���j���[��\������@�\��ǉ��A���X�g���̃t�@�C���ړ����������B
	  (08)	2004/02/11	�R���{�{�b�N�X��ł̉E�N���b�N���j���[����̑I�𒆃t�@�C���㉺�ړ������܂��o���Ȃ��o�O���C���B
	  (09)	2004/02/20	���X�g�t�@�C���ǂݍ��ݑO�Ɉ�U�Đ����X�g����������ݒ��ǉ��A�ݒ荀�ڑ����ɔ������ڂ��O���[�v�����B
	  (10)	2004/03/18	���yCD���Đ��o���Ȃ����Ƃ�����o�O�A����ʓ����J���������ƃ��C����ʂ��X�V����Ȃ��Ȃ�o�O�AMCI�ōĐ��\�ƒ�`�����t�@�C����ȊO���ǂݍ��܂�Ă��܂��o�O���C���B�S�����ǂݍ��ރX�N���v�g(everyone.xs)���`�B
	  (11)	2004/04/26	OggVorbis �t�@�C������A���ōĐ����Ă��܂��o�O���C���A�t�@�C���̑��݊m�F���ł��Ă��Ȃ������o�O���C��
	  (12)	2004/05/04	�t�@�C���̑��݊m�F���ł��Ă��Ȃ������o�O���C��
	  (13)	2004/06/18	WindowsXP�ŏ���N�����ɃG���[����������o�O���C��
	  (14)	2004/06/24	�t�@�C���̊֘A�t������肭�����Ȃ��o�O�A���������p�X�̃t�H���_��I�����ɃG���[�ŗ�����o�O���C���B�Đ����t�@�C���̓����Ă���t�H���_���J���@�\��ǉ�
	  (15)	2004/08/06	MCI�ŊJ����t�@�C���̐ݒ肪��肭�K�p����Ȃ��o�O���C���B
          (16)	2004/10/�`	�Đ���J�n
   ver.403(��1)	2004/12/19	�E���W���[���̐�����}�N�����B�@�\�̎�ޕ����Ȃǂ����������B
				�E���O�f�o�b�O�E�B���h�E�̕\���B(�����z�z���͏���)
				�E�Đ����X�g�o�^�\�t�@�C���������B
				�E�I�𒆂̃��X�g���ڒǔ��B
	(��)	�ݒ�t�@�C���t�H�[�}�b�g�ύX/�R���o�[�^�p��
			xstheader.20,21 -> (�s�g�p)
			PF_MCI,DXS,DLL $0,1,2 -> $1000,$2000,$3000
		�@�\�ԍ��ύX
			FNC_LOADLIB	 $26000000 -> $27000000
			FNC_SET_PLAYFUNC $26000000 (�V�ԍ�)
			FNC_USERDEF	 FNC_SCRIPT (�V����)
          (��1)	2004/12/27	�EVox.dll, vbmp3.dll �Ή�
				�EEXE�A�C�R���ւ̃h���b�O���h���b�v�ɑΉ�
				�E�v���O�C���d�l������
				�E�ꕔ�̋@�\���s��Ƀv���C���[��ʂ�����s�\�ɂȂ�o�O���C��
          (��2)	2005/01/01	�E�I�����̍Đ��ӏ��Č��@�\�t��
				�EEXE�A�C�R���ւ̃h���b�O���h���b�v�����̃o�O���C��
				�E�v���C���[���N�����Ă����Windows�̏I���������j�Q�����o�O���C��
	  (��3)	2005/01/21	�E���C�ɓ���ҏW�@�\����������V�X�e���ɓ���(�v���O�C����ax�t�@�C����)
				�E�P�ƂőI�������t�@�C�������X�g�ɒǉ�����Ȃ��o�O���C��
				�E�Đ��Ɏg�p����d�g�݂̏��\����ʒǉ�
				�E�v���O�C���d�l����
				�E���̑�������
	  (��4)	2005/01/31	�E�X�N���v�g�̃o�O���C��
					�`�F�b�N�{�b�N�X�����s�R
					�I�u�W�F�N�g���ʎq popup
				�E_func.as ����������
				�E���̑�������
	  (��5)	2005/09/09	�EMidi�t�@�C�����(SMF���^�C�x���g)�̎擾������ǉ�
				�EMP3�t�@�C�����(ID3v1)�̎擾������ǉ�
				�EOggVorbis �^�O���̕��������C��
				�E���O�����ёւ��̍�����
				�E�X�N���v�g�̃o�O���C��
					�`�F�b�N�{�b�N�X�����s�R
					����L�[(%�`%)������Ƃ��A���܂Ƀv���O������������
					%p.lgtm% %p.lgts% �� %p.pos*% �Ɠ����Ӗ��ɂȂ��Ă���
				�E�X�N���v�g�d�l���� imgmode �ǋL
				�E�X�N���v�g�̎d�l���g���A�{�^���Ƀ}�E�X��������藣�ꂽ�Ƃ��̏�����ǉ��ł���悤�ɂ���
				�E���X�g�ۑ����̃G���[��������ǉ�
				�E��L�G���[��������ǉ��ɔ�������t�@�C���X�V
				�E�X�L���ݒ�t�@�C�����ǂݍ��߂Ȃ��o�O���C��
				�E�f�o�b�O�E�B���h�E�ŁA������������Ăяo���ꂽ�@�\�ԍ����������\������Ȃ������o�O���C��
				�E�v���O�C���t�H���_���̎��s�t�@�C���ƃV���[�g�J�b�g���v���O�C�����X�g�ɒǉ�����悤�ɂ���
				�E�s��`�E�B���h�E�ł��^�X�N�o�[�̃^�C�g���E�N���b�N���ɃV�X�e�����j���[��\������悤�ɂ���
				�E�t�H���_�P�̂Ńh���b�O���h���b�v���ꂽ�Ƃ����X�g�ɒǉ�����Ȃ��o�O���C��
				�E���̑�������
				(�EDDE�ɂ��TMIDI Player�Ȃǂ̐���ɑΉ� / �����)

 �E���� as �t�@�C���ɂ���

	���x���ꗗ
	*main		�v���C���[�̑ҋ@���̏���
	*exit		�v���C���[�̏I���{�^���������ꂽ�ۂ̏���
	*error		�G���[���������A�I����]�V�Ȃ����ꂽ�ۂ̏���

 �\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\ */


; �\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\
; ��`
; �\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\

	#define	prgname		"arX MusicPlayer"
	#define prgnames	"arXmp"
	#define prgver		"403.00��5(��)"
	#define prgtitle	prgname+" ver."+prgver+prguser
	#define prgtitles	prgnames+" v."+prgver
	#define helpfile	exedir+"\\readme.txt"
	#define setplayfunc	"setplayfunc.ax"
	#define setplaytype	"setplaytype.ax"
	#define cfgfavorite	"cfgfavorite.ax"
	#const	lprgnames	8	; 3(sep=" - ")+5(prgnames="arXmp")
	#const	vmain		40222	; 403.00��5
	#const	vscript		40219	; 403.00��5
	; ��1 40218	�`�F�b�N�{�b�N�X�A�I�u�W�F�N�g���ʎq(popup)�̃o�O�C��
	; ��5 40219	�`�F�b�N�{�b�N�X�̃o�O�C���Aimgmode���ߒǉ��A�C�x���g�����ǉ�
	#const	vlanguage	40301	; 403.01
	; ��5 40301	.Err.onsave �ǉ�
	#include "_init_def.as"
	#include "_init_defex.as"


; �\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\
; ���ߊg��
; �\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\

	; hsgetmsg
	#uselib "hsgetmsg.dll"
	#func gm_setwndproc	gm_setwndproc	$202
	#func gm_setmessage	gm_setmessage	$202
	#func gm_getmessage	gm_getmessage	$202
	mref bmscr,67
	hwProcess=bmscr.13
	gm_setwndproc hwProcess
	; loadlib
	ll_libload D_GDI,"gdi32"
	ll_libload D_USER,"user32"
	ll_libload D_SHELL,"shell32"
	ll_libload D_KERNEL,"kernel32"
	ll_libload D_COMDLG,"comdlg32"
	ll_libload D_OLE,"ole32"
	ll_retset dllret
	; ���̑����W���[��
	#include "strmod.as"
	#include "_mod.as"


; �\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\
; (�f�o�b�O�p)
; �\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\

	#ifdef DEBUG
	gsel 0,-1
	; ���샍�O�p�̏���
	#define addlog(%1) str logline,3 :log=logline+"| "+%1+"\n"+log :gsel widDebug :objprm 0,log :gsel sWid :int logline :logline++ :im=logline\1000=0 :log=log.im
	sdim log,65535,2
	log="\n"
	log+="��-arX MusicPlayer ver."+prgver+" �ɂ���\n"
	log+="���̔ł̃v���C���[�͊������Ă���悤�Ɍ�����@�\�Ƀo�O���c���Ă��Đ��������삵�Ȃ����Ƃ�����܂��B�v���C���[�̃o�[�W�����A�b�v�𑬂₩�ɍs�����߂ɁA�o�O�𔭌����ꂽ���͍�҂ւ��񍐊肢�܂��B\n\n"
	log+="�@�����T�C�g:\n�@�@http://hp.vector.co.jp/authors/VA022483/xmp/\n"
	log+="�@���[��:\n�@�@arc@mocha.freemail.ne.jp\n"
	log.1 ="\n"
	log.1+="��-�f�o�b�O�E�B���h�E(debug window)�ɂ���\n�v���C���[�̓�����m�F���邽�߂̂��̂ł��B�o�O�񍐂̍ۂ́A�s��������ɍŏ�s�t�߂ɕ\������Ă������e�����m�点������Ə�����܂��B���e��1000�s�ɓ��B����x�ɃN���A����܂��B\n\n"
	log.1+="�@���\�����e�}��\n"
	log.1+="�@FNC $[�@�\�ԍ�]([�@�\��]) -> �Ԃ�l\n"
	log.1+="�@BTN [�E�B���h�E��] (id=[�I�u�W�F�N�gID])\n"
	log.1+="�@CNV [�ϊ����ꂽ���j���[ID]\n"
	log.1+="�@MSG $[WM_?] -> hwnd,lprm,wprm"
	log+=log.1
	logline=0
	funclv=0
 	dim func_,16
	; ���O�\����ʂ̏�����
	#const widDebug	10
	screen widDebug,320,280,14,dispx-331,5
	mref bmscrd,67
	prm=bmscrd.13,-20
	dllprocp FNC_GetWindowLongA,prm,2
	prmex.2=dllret|$80
	dllprocp FNC_SetWindowLongA,prmex,3
	title "debug window"+sep+prgtitles
	font "�l�r �S�V�b�N",12
	objmode 2,1
	mesbox log,winx,winy,0
	gsel widDebug,2
	gsel 0
	#else
	onerror *error
	#endif


; �\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\
; �ϐ��Ȃǂ̏�����
; �\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\

	; �ėp�ϐ��̏�����
	#const szs	1024
	#const szss	512
	dim prm,37	:getptr pprm,prm
	dim prmex,22	:getptr pprmex,prmex
	dim i :dim ii :dim iii :dim im
	getptr pi,i :getptr pii,ii :getptr piii,iii
	sdim s,szs	:getptr ps,s
	sdim ss,szss	:getptr pss,ss
	sdim sss,1024	:getptr psss,sss
	sdim tmp,bufmax	:getptr ptmp,tmp
	sdim tmp2,bufmax:getptr ptmp2,tmp2
	sdim notedata,bufnd
	; �@�\���p�ϐ��̏�����
	dim func,nfunc
	sdim funcopts,bufmax
	getptr pfuncopts,funcopts
	; �R�}���h���C���̕ϊ��ƃv���O�C���֘A�̏�����
	#include "_init_xpi.as"
	; ���̑��̕ϐ��̏������ȂǁA�F�X
	#include "_init_var.as"


; �\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\
; �ݒ�̓ǂݍ���
; �\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\

	; tmp2	/	�R�}���h���C������ϊ����ꂽ���y�t�@�C���̃��X�g

	; �ݒ�t�@�C���̓ǂݍ���
	; (�͂��߂͐擪192�o�C�g�̃w�b�_���̂�)
	s=datdir+user+".xst"
	exist_ s
	if stat>0 {
	 bload s,xstheader	,192,0
	 if xstheader!xstgenuine {
	  dialog "�ݒ�t�@�C�������Ă������߁A�ݒ肪�S�ď���������܂����B\n\n("+s+")",1,prgtitles
	 } else {
	  ; �w�b�_���ȍ~��ǂݍ���
	  bload s,tmp,,192
	  memcpy sFileName,tmp	,szsinfo_	:prm=szsinfo_
	  memcpy lCurdir,tmp	,szlinfo_,,prm	:prm+=szlinfo_
	  memcpy types,tmp	,sztypes*TP_PLAYABLE,,prm
	  ; ���X�g�ƍĐ����
	  lSelectedIdx=xstheader.8
	  lSearchType=xstheader.9
	  lDownDblItem=xstheader.10!0
	  lClearOnLoad=xstheader.11!0
	  lMode=xstheader.12
	  mFileIdx=xstheader.13
	  lReplay=xstheader.15!0
	  ; ��ʏ��Ɗg���@�\
	  dispMainWnd=xstheader.16!0
	  dispTiphelp=xstheader.17!0
	  dispTrayicon=xstheader.18!0
	  dispTaskbar=xstheader.19!0
	  ; ���̑�
	  if xstheader.22 :func=FNC_LOADLIB|FNC_ON+IDX_LOAD_MP3INFP :gosub *exec_func
	  i=24 :repeat TP_PLAYABLE
	   type.cnt=xstheader.i :i++ :loop
	  i=36 :repeat 5
	   mScrollType.cnt=xstheader.i :i++ :loop
	  if setVmain<vmain {
	   dialog "�v���C���[���o�[�W�����A�b�v����܂����B\n�p���I�Ȃ����p���肪�Ƃ��������܂��B",0,prgtitles
	   setVmain=vmain
	  }
	 }
	}

	; ���[�U�[�p�Đ����X�g�̓ǂݍ���
	s=datdir+user+".xpt"
	exist_ s
	if stat>0 {
	 notesel list
	 noteload s
	 notemax lNum
	}

	; �ݒ�t�@�C�����e�ƘA�������ϐ��ɕW���ݒ�l����
	; (�ݒ�t�@�C���j��/����N����)
	if xstheader!xstgenuine {
	 xstheader=xstgenuine
	 setVmain=vmain
	 MainWndX=dispx-320/2
	 MainWndY=dispy-170/2
	 ListWndX=dispx-640/2
	 ListWndY=dispy-480/2
	 ListWndWidth =640
	 ListWndHeight=480
	}

	; �v���C���[�����������t���O
	; (_script.as �� "!!!init=xsp" �̏����ŉ���)
	dispMainWnd=dispMainWnd|initializing

	; ���j���[�̃t�@�C���ꗗ�X�V
	func=FNC_XS_LOAD|FNC_REFRESH	:gosub *exec_func
	func=FNC_XSP_LOAD|FNC_REFRESH	:gosub *exec_func
	func=FNC_XMS_LOAD|FNC_REFRESH	:gosub *exec_func
	func=FNC_XPI_LOAD|FNC_REFRESH	:gosub *exec_func
	func=FNC_XLT_LOAD|FNC_AUTO|FNC_REFRESH	:gosub *exec_func

	; �X�L���ǂݍ���
	func=FNC_XSP_LOAD|FNC_AUTO :gosub *exec_func

	; �h���b�O&�h���b�v���ꂽ�t�@�C��������
	strlen i,tmp2
	if i {
	 im=lDownDblItem
	 lDownDblItem=1
	 funcopts=tmp2
	 func=FNC_LIST_ADD|FNC_ON :gosub *exec_func
	 lDownDblItem=im
	 xstheader.14=0
	 func=FNC_PLAY+lNum-1 :gosub *exec_func
	} else {
	 ; �O��I�����̍Đ��ӏ����Č�
	 if lReplay&(xstheader.14!-1) {
	  ; [Shift] �L�[�ŃL�����Z��
	  getkey i,16
	  if i=0 :func=FNC_PLAY|FNC_AUTO+IDX_CUR :gosub *exec_func
	 }
	}


; �\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\
; ���C������
; �\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\

	onexit *exit
	randomize

*main
	wait 5

; �\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\
; 0.050*TI_REFRESH�b���Ƃɉ�ʕ\�����X�V

	if mainloop\TI_REFRESH=0 {
	 ; ���C����ʂ̍ŏ������
	 dllproc "IsIconic",hwMainWnd,1,D_USER
	 if dispMainWnd&2!0!dllret {
	  if dllret {
	   mii.1=1 :mii.3=8 :setmii hmOnMain,FNC_MINIMIZE|FNC_AUTO
	   dispMainWnd=dispMainWnd^2
	   gsel sWid,-1
	   if dispTrayicon=0 {
	    ntray hIcon
	    ttray mTasktray,hIcon
	   }
	  }
	 }
	 ; ���C����ʂ̕\��
	 if mStatus!ST_CLOSED&(dispMainWnd&2=0)&(scrLine=0) {
	  scrLine+=scrAreaMainLine
	  script=scrAreaMain+script
	 }
	 ; ���C����ʃ^�C�g���̕\��
	 if dispTitle {
	  dispTitle--
	  if dispTitle=0 {
	   if mStatus!ST_CLOSED {
	    title mFileName+sep+prgtitles
	   } else :title prgtitles
	  }
	 }
	 ; ���X�g��ʂ̑傫��
	 if dispListWnd {
	  gsel widList
	  if ListWndWidth!winx|(ListWndHeight!winy) {
	   ListWndWidth=winx
	   ListWndHeight=winy
	   objresize winx-20,winy-25,5
	   objrepos 5,winy-23,6
	   objrepos 150,winy-23,7
	   objrepos 250,winy-23,8
	   objrepos winx-65,winy-23,9
	  }
	  gsel sWid
	 }
	}

; �\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\
; 0.050�b���Ƃɉ��y�̍Đ���ԕω��y�у��[�U�[����֔���

	; �X�N���v�g���m�����s
	if scrLine :gosub *exec_script

	func=FNC_GETSTATE :gosub *exec_func
	; ���y�̍Đ��I��
	if mStatus=ST_STOPPED {
	 i=lMode&$F
	 if i=PM_MDR :wait 300
	 repeat
	  if i=PM_NOR|(i=PM_MDR)|(i=PM_RND) {
	   if mFileIdx+1=lNum&(lMode&$F0=0)&(i!PM_RND) {
	    func=FNC_STOP :break
	   }
	   func=FNC_PLAY|FNC_AUTO+IDX_CUR_NEXT :break
	  }
	  if i=PM_STP :func=FNC_STOP :break
	  if i=PM_REP {
	   if mFileType&TPEX_MID!0&(type.TP_MID=PF_DLL) {
	    func=FNC_PLAY|FNC_AUTO+IDX_CUR :break
	   }
	   func=FNC_SEEK :break
	  }
	  if i=PM_REV :func=FNC_PLAY|FNC_AUTO+IDX_CUR_PREV :break
	 loop
	 gosub *exec_func
	 if funcret=FR_ERR :func=FNC_STOP :gosub *exec_func
	}

	*main_
	gm_getmessage msgval		; �E�B���h�E���b�Z�[�W
	#ifdef DEBUG
	if msgval!0&(msgval.1!WM_TASKTRAY)&(msgval.1!WM_LBUTTONDOWN)&(msgval.1=WM_COMMAND&(msgval.3!0)=0) {
	 i=msgval.1 :str i,20
	 addlog "MSG $"+i+" -> "+msgval+","+msgval.2+","+msgval.3
	 int i
	}
	#endif
	getkey i,VK_APPS		; �E�N���b�N�@�\�L�[
	stick ii,0,1 :ii=(ii&512!0)	; �E�N���b�N

	; �}�E�X���{�^���̏�ɏ���������ꂽ
	if msgval!0&(msgval.1=WM_MOUSEMOVE|(msgval.1=WM_MOUSELEAVE)) {
	 i=41
	 repeat snObj
	  if msgval=bmscr.i {
	   ; cnt	/ �I�u�W�F�N�gID
	   ; i		/ �I�u�W�F�N�gID+41
	   func=$FF
	   if msgval.1=WM_MOUSEMOVE&(obj.cnt.2&hovering=0) :obj.cnt.2+=hovering :gosub track_mouseleave :func=obj.cnt.2&$FF
	   if msgval.1=WM_MOUSELEAVE :obj.cnt.2-=(obj.cnt.2&hovering!0)*hovering :func=obj.cnt.2>>8&$FF
	   if (snAreaUser+IDX_SCRIPT_USER)>func {
	    prm=16,3,bmscr.i,0
	    func+=FNC_SCRIPT
	   } else :func=0
	   break
	  }
	  i++
	 loop
	 if func :gosub *exec_func
	 ; �������b�Z�[�W���A���Ŕ��ł��邱�Ƃ������̂ŁA���A���^�C���ɏ�������
	 ; (�������Ȃ��ƂЂƂ̃��b�Z�[�W�����ɂ�0.050�b�����蓮�삪������)
	 goto *main_
	}

	if msgval=hwProcess {
	 ; �@�\�̎��s�v��
	 if msgval.1=WM_EXECFUNC {
	  func=msgval.2
	  gosub *exec_func
	  if msgval.3 {
	   prm=msgval.3,WM_NOTIFYPI,NP_FUNCRET,funcret
	   dllprocp FNC_SendMessageA,prm,4
	  }
	  i=0 :ii=0
	 }
	 ; �^�X�N�g���C�ւ̑���
	 if msgval.1=WM_TASKTRAY {
	  if msgval.3=WM_LBUTTONUP :gosub open_sWid
	  if msgval.3=WM_RBUTTONUP :ii=1 :else :ii=0
	  dllprocp FNC_SetForegroundWindow,hwMainWnd,1
	 }
	}

	; �E�N���b�N
	if i|ii {
	 ginfo 1
	 if (prmx=sWid)|(prmx=widList) {
	  ginfo 2*i	; ��ʍ���(�@�\�L�[) or �}�E�X�J�[�\��(�E�N���b�N)
	  prm=prmx,prmy	; ���W���擾
	  dllprocp FNC_WindowFromPoint,prm,2
	  ; (1) ���X�g��ł̉E�N���b�N���A���ꃁ�j���[�\��
	  if dllret=hwList|(dllret=hwListSub)&ii {
	   ; ���X�g�{�b�N�X�ł͂܂��[���N���b�N
	   ; (�}�E�X�J�[�\�����̍��ڂ�I��)
	   if sList=0 {
	    prm=dllret,pprmex
	    dllprocp FNC_GetWindowRect,prm,2
	    prm.1=WM_LBUTTONDOWN,1,prmy-prmex.1<<16+prmx-prmex
	    dllprocp FNC_SendMessageA,prm,4
	    prm.2=WM_LBUTTONUP
	    dllprocp FNC_SendMessageA,prm,4
	   }
	   i=hmOnList
	  ; (2) ���̑��ł͒ʏ탁�j���[�\��
	  } else :i=hmOnMain
	  pmenu i,prmx,prmy
	  if dllret :func=dllret :gosub *exec_func
	 }
	}

	; ���N���b�N
	if msgval=hwMainWnd&(msgval.1=WM_LBUTTONDOWN) {
	 ginfo 1
	 if prmx=sWid {
	  ; �Đ��ʒu��ύX
	  ; if (mStatus=ST_PLAYING)&(sSeekX<=mousex)&(sSeekY<=mousey)&(sSeekWidth>=(mousex-sSeekX))&(sSeekHeight>=(mousey-sSeekY)) {
	  if (mStatus!=ST_STOPPED)&(sSeekX<=mousex)&(sSeekY<=mousey)&(sSeekWidth>=(mousex-sSeekX))&(sSeekHeight>=(mousey-sSeekY)) {
	   if sSeekDirection=0 {
	    mPosition=mDuration*(mousex-sSeekX)/sSeekWidth
	   } else {
	    mPosition=mDuration*(sSeekHeight-(mousey-sSeekY))/sSeekHeight
	   }
	   gosub apply_mPosition
	   gosub wait_mStatus
	  ; ��ʈʒu���ړ�
	  } else {
	   if (sDragX<=mousex)&(sDragY<=mousey)&(sDragWidth>=(mousex-sDragX))&(sDragHeight>=(mousey-sDragY)) {
	    repeat 1
	     stick i,256
	     i=0 :objsend -28,$A1,2,i,0
	     if i&256 :continue
	     wait 20
	    loop
	   }
	  }
	 }
	}

	; ���X�g�ւ̑���
	if dispListWnd&(msgval=hwListSub)|(msgval=hwList) {
	 ; �_�u���N���b�N�܂���Enter�L�[�������ꂽ��I������Ă���t�@�C�����Đ�
	 if (msgval.1=WM_LBUTTONDBLCLK)|((msgval.1=WM_KEYUP)&(msgval.2=VK_RETURN)) {
	  func=FNC_PLAY|FNC_AUTO+IDX_SEL
	  gosub *exec_func
	  ; func=FNC_PAUSE
	  ; gosub *exec_func
	 }
	 ; Delete�L�[�������ꂽ��I������Ă���t�@�C�����폜
	 if (msgval.1=WM_KEYUP)&(msgval.2=VK_DELETE) {
	  func=FNC_LIST_CLEAR|FNC_AUTO+IDX_SEL
	  gosub *exec_func
	 }
	 ; �����̑��V���[�g�J�b�g�L�[�o�^���\

	 ; (�����ɃL�[�ʏ�����ǉ�)

	}

	; �h���b�O���h���b�v
	if msgval!0&(msgval.1=WM_DROPFILES) {
	 ; �t�@�C�������擾
	 prm=msgval.2,-1,0,0
	 dllprocp FNC_DragQueryFileA,prm,4
	 i=dllret
	 ; �t�@�C�������擾
	 funcopts=""
	 prm.2=ps,512
	 repeat i
	  if cnt :funcopts+="\n"
	  prm.1=cnt
	  dllprocp FNC_DragQueryFileA,prm,4
	  funcopts+=s
	 loop
	 dllprocp FNC_DragFinish,prm,1
	 repeat
	  if i=1 {
	   gettype funcopts
	   if stat&TPEX_XLT {
	    func=FNC_XLT_LOAD|FNC_STR :gosub *exec_func
	    break
	   }
	   if stat&TPEX_XSS {
	    func=FNC_XSS_LOAD|FNC_STR :gosub *exec_func
	    break
	   }
	   if stat&TPEX_ALL=0 {
	    if stat&TPEX_IMG {
	     repeat snVar
	      if sVar_type.cnt=SV_IMAGE {
	       func=FNC_XSP_MODIFY|FNC_STR+cnt :gosub *exec_func
	       break
	      }
	     loop
	     break
	    }
	    break
	   }
	  }
	  funcopts+="\n"
	  func=FNC_LIST_ADD|FNC_ON :gosub *exec_func
	  func=FNC_LIST_REFRESH :gosub *exec_func
	  break
	 loop
	}

	; �`�F�b�N���e�̕ύX���m���ύX�K�p
	repeat snChk
	 if chk.cnt!chk_.cnt {
	  i=chkid.cnt :func=obj.i :gosub *exec_func
	  chk_.cnt=chk.cnt
	 }
	loop

	; ���j���[�̃N���b�N���@�\���s
	if msgval!0&(msgval.1=WM_COMMAND)&(msgval.3=0) {
	 func=msgval.2 :gosub *exec_func
	}

	mainloop=mainloop+1\$FFFFFFF
	msgval=0,0,0,0
	goto *main


; �\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\
; �I������
; �\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\

*exit
	; ���[�U�[���~�{�^���������� or [Alt]+[F4]
	if iparam=0 {
	 ginfo 1
	 #ifdef DEBUG
	 i=prmx!widDebug&(prmx!32)&(prmx!sWid)
	 #endif
	 #ifndef DEBUG
	 i=prmx!sWid
	 #endif
	 ; ���C����ʈȊO������ꂽ
	 if i {
	  if prmx=widInfo&(dispInfoWnd&IDX_WND_INPUT!0) {
	   funcopts=""
	   #ifdef DEBUG
	   funclv--
	   #endif
	   func=FNC_OPEN_WND|FNC_OFF+widInfo :goto *exec_func
	  }
	  func=FNC_OPEN_WND|FNC_OFF+prmx
	  gosub *exec_func
	  goto *main
	 }
	}
	; ���̕ۑ�
	;  (1) �Đ����X�g
	notesel list
	notesave datdir+user+".xpt"
	;  (2) ���̑����
	;	���𐮗�
	if dispMainWnd&2=0 {
	 ginfo 2
	 MainWndX=prmx :MainWndY=prmy
	}
	xstheader.8 =lSelectedIdx,lSearchType,lDownDblItem,lClearOnLoad,lMode,mFileIdx,mPosition,lReplay
	if mStatus=ST_CLOSED :xstheader.14=-1
	xstheader.16=dispMainWnd,dispTiphelp,dispTrayicon,dispTaskbar,0,0,D_MP3INFP!0
	i=24
	repeat TP_PLAYABLE :xstheader.i=type.cnt :i++ :loop
	i=36
	repeat 5 :xstheader.i=mScrollType.cnt :i++ :loop
	;	������̕ϐ��ɂ܂Ƃ߂�
	prm=nxstheader*4
	memcpy tmp,xstheader	,prm
	memcpy tmp,sFileName	,szsinfo_,prm	:prm+=szsinfo_
	memcpy tmp,lCurdir	,szlinfo_,prm	:prm+=szlinfo_
	memcpy tmp,types	,sztypes*TP_PLAYABLE,prm :prm+=sztypes*TP_PLAYABLE
	;	�Ō�Ƀt�@�C���ɕۑ�����
	s=datdir+user+".xst"
	exist_ s
	if stat=1 :delete s
	bsave s,tmp,prm
	dispMainWnd=dispMainWnd|closing
	; �Đ����̉��y���~
	if mStatus!ST_CLOSED :func=FNC_STOP :gosub *exec_func
	; �^�X�N�g���C�A�C�R���̏���
	if dispMainWnd&2|dispTrayicon :ctray
	; �o�^���ꂽ�v���O�C���ɏI�����b�Z�[�W���M
	prm.1=WM_CLOSE,0,0
	repeat szfmo_send/4,fi_send_onexit/4
	 ll_peek4 prm,cnt*4+pfmo_info
	 if prm :dllprocp FNC_SendMessageA,prm,4
	loop
	; �v���O�C���������J���̍X�V
	ll_poke4 0,pfmo_info
	prm=hfmo_info,2,0,0,0
	dllprocp FNC_UnmapViewOfFile,prm,5
	; COM ���A�e�� DLL �n���h���̉��
	if dde_inst :func=FNC_LOADLIB|FNC_OFF+IDX_LOAD_DDE :gosub *exec_func
	if pCallMethod :dllproc "CoUninitialize",prm,0,D_OLE
	if D_VBMP3 :dllprocp FNC_vbmp3_free,prm,0
	repeat nD
	 if D.cnt!0 :ll_libfree D.cnt
	loop
	; ���j���[�n���h���̉��
	repeat nhmenu
	 if hmenu.cnt :dllprocp FNC_DestroyMenu,hmenu.cnt,1
	loop
	; ���̑��n���h���̉��
	if hIcon!0 :dllproc "DestroyIcon",hIcon,1,D_USER
	dllprocp FNC_CloseHandle,hfmo_info,1
	end

*error
	dialog "�G���[�������������߃v���C���[�������I������܂��B\n\n�@�G���[�ԍ�= "+wparam+"\n�@�G���[�����ʒu= "+lparam,1,prgtitles
	end


; �\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\
; ���̃X�N���v�g�ƌ���
; �\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\

	#include "_func.as"
	#include "_script.as"
	#include "_sub.as"


; �\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\
;                                                              (c) arc@arcis
