
;title "�Đ����X�g���V���b�t��"
; �\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\

/* ���상�� �\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\

 �E���� as �t�@�C���ɂ���

	�Đ����X�g���V���b�t�����܂��B

 �\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\ */

	#include "_init_def.as"
	#include "_mod_xpi.as"

	xpi_connect
	if stat=0 :end

	; �ꎞ�t�@�C���̖��O������
	sdim tmpdir,szdir :sdim tmpfile,512
	xpi_peek tmpdir,ai.pdir+(szdir*4),szdir
	tmpfile=tmpdir+"plugin_tmp.xlt"

	; �Đ����X�g�̎擾
	#const bufmax		65536	; ������f�[�^�̍ő咷(bytes)

	sdim list,bufmax
	xpi_peek list,ai.plist,bufmax
	if list="" {
		; �ꎞ�t�@�C���쐬
		i=0
		repeat 1
		 xpi_func FNC_IDLECHK,2
		 if stat=-1 {
		  dialog "�v���C���[�����������s���ł��邽�߁A���X�g���擾�ł��܂���B\n�_�C�A���O���J���Ă���ꍇ�͈�U�L�����Z������Ȃǂ��Ă���ēx [OK] �������Ă��������B"
		  i++ :continue 0
		 }
		loop
		xpi_opt tmpfile
		xpi_func FNC_XLT_SAVE|FNC_STR
		; �ꎞ�t�@�C���ǂݍ���
		exist tmpfile
		if strsize!-1 {
			if strsize>0 {
				notesel list :noteload tmpfile :notemax i
			}
		; �g�p�����ꎞ�t�@�C�����폜
		delete tmpfile
		}
	}

	; �V���b�t��
	sdim s,512
	notesel list
	notemax max
	if max {
		randomize
		repeat max,1
			noteget s,max-1
			notedel max-1
			rnd i,cnt
			noteadd s,i
			await
		loop
		; �Đ����X�g�������������
		xpi_func FNC_LIST_CLEAR|FNC_AUTO|FNC_ALL
		strlen i,list
		if i>bufmax {
			; �ꎞ�t�@�C���쐬
			notesave tmpfile
			; �ꎞ�t�@�C������ǂݍ���
			xpi_opt tmpfile
			xpi_func FNC_XLT_LOAD|FNC_STR
			; �g�p�����ꎞ�t�@�C�����폜
			delete tmpfile
		} else {
			xpi_poke list,ai.plist,bufmax
		}
		; �Đ����X�g���X�V
		xpi_func FNC_LIST_REFRESH|FNC_ON
	}
	stop


; �\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\
;                                                              (c) arc@arcis
