
title "�ݒ� / ���y�Đ�"
; �\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\

/* ���상�� �\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\

 �E���� as �t�@�C���ɂ���

	�Đ��Ɏg�p����d�g�݂�ύX����v���O�C���ł��B

 �\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\ */


; �\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\
; ���ߊg���Ȃ�

	#include "_init_def.as"
	#include "_mod_xpi.as"
	ll_getproc pEnableWindow,"EnableWindow",XD_USER
	#define DisableWindow prm=xpi_hwnd@xpimod,0 :ll_callfunc prm,2,pEnableWindow

	; �~�j llmod
	#module
		#deffunc dllproc str,val,int,int
		mref funcname,32 :mref prms,17 :mref prm_n,2 :mref dll_no,3
		ll_getproc func,funcname,dll_no
		ll_callfunc prms,prm_n,func :return
	#global


; �\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\
; �v���O�C���Ƃ��Ă̏���

	xpi_connect ,1
	; stat		/	�v���C���[�̃o�[�W�����ԍ�
	;			or 0 (�v���C���[���N�����Ă��Ȃ�)
	if stat=0 {
	 dialog "�v���C���[�{�̂��N�����Ă��邱�Ƃ��m�F�ł��܂���ł����B\n�v���O�C�����I�����܂��B",0
	 end
	}

	;#const PF_MCI		$1000	; MCI �ōĐ�
	;#const PF_DXS		$2000	; DirectShow �ōĐ�
	;#const PF_DLL		$3000	; ���̑��̓���� DLL ��p���čĐ�
	xpi_peek pf_mp3,ai.ptype   ,4 :pf_mp3=pf_mp3/$1000-1
	xpi_peek pf_wma,ai.ptype+4 ,4 :pf_wma=pf_wma/$1000-1
	xpi_peek pf_mid,ai.ptype+8 ,4 :pf_mid=pf_mid/$1000-1
	xpi_peek pf_wav,ai.ptype+12,4 :pf_wav=pf_wav/$1000-1
	xpi_peek pf_ogg,ai.ptype+16,4 :pf_ogg=pf_ogg/$1000-1


; �\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\
; ��ʂ̐���

	width 320,215
	redraw 2

	prm=15
	dllproc "GetSysColor",prm,1,XD_USER
	col=dllret&255,dllret>>8&255,dllret>>16&255
	; col		/	(�z��ϐ�) �V�X�e���F

	color col,col.1,col.2
	boxf

	color 0,0,0
	font "MS UI Gothic",16,17
	pos 10,10
	mes "�Đ��Ɏg�p����d�g�݂̕ύX"
	line 10,26,winx-10,26

	font "�l�r �S�V�b�N",12,16
	objmode 2,1
	objsize winx-90,21
	pos 15,40	:mes "MP3"
	pos 80,36	:combox pf_mp3,100,"MCI(�W���ݒ�)\nDirectShow\nVBMP3.dll"
	pos 15,65	:mes "WMA"
	pos 80,61	:combox pf_wma,100,"MCI\nDirectShow(�W���ݒ�)"
	pos 15,90	:mes "Midi"
	pos 80,86	:combox pf_mid,100,"MCI\nDirectShow(�W���ݒ�)\nDDE(TMIDI Player�Ȃ�)"
	pos 15,115	:mes "Wave"
	pos 80,111	:combox pf_wav,100,"MCI(�W���ݒ�)\nDirectShow"
	pos 15,140	:mes "OggVorbis"
	pos 80,136	:combox pf_ogg,100,"MCI\nDirectShow\nVox.dll(�W���ݒ�)"
	pos 15,165	:mes "CD Audio"
	pos 84,165	:mes "MCI(�Œ�)"

	font "MS UI Gothic",12,16
	objsize 60,25
	pos winx-66,winy-30 :button "OK",*ok

	redraw 1
	gsel 0,1
	stop


; �\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\
; �ݒ�̕ύX

*ok

	; �v���C���[���ҋ@��ԂɂȂ�܂ő҂�
	DisableWindow
	i=0
	repeat 1
	 xpi_func FNC_IDLECHK,2
	 if stat=-1 {
	  dialog "�v���C���[�����������s���ł��邽�߁A�ݒ��ύX�ł��܂���B\n�_�C�A���O���J���Ă���ꍇ�͈�U�L�����Z������Ȃǂ��Ă���ēx [OK] �������Ă��������B"
	  i++ :continue 0
	 }
	loop

	; �ݒ�̕ύX
	s=""
	xpi_func FNC_SET_PLAYFUNC+TP_MP3+((pf_mp3+1)*$1000)
	if stat=FR_ERR :s+="vbmp3.dll "
	xpi_func FNC_SET_PLAYFUNC+TP_WMA+((pf_wma+1)*$1000)
	xpi_func FNC_SET_PLAYFUNC+TP_MID+((pf_mid+1)*$1000)
	xpi_func FNC_SET_PLAYFUNC+TP_WAV+((pf_wav+1)*$1000)
	xpi_func FNC_SET_PLAYFUNC+TP_OGG+((pf_ogg+1)*$1000)
	if stat=FR_ERR :s+="vox.dll "
	if s!"" {
	 dialog s+"��������Ȃ��������ߐݒ�𐳂����ύX�ł��܂���ł����B\nDLL���_�E�����[�h���� arxmp.exe �̂���t�H���_���Ɉړ���A�ēx�ݒ肵�����Ă��������B"
	}

	end


; �\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\
;                                                              (c) arc@arcis
