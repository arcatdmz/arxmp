
title "�ݒ� / ���y�Đ�"
; �\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\

/* ���상�� �\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\

 �E���� as �t�@�C���ɂ���

	�v���C���[���Đ��ł���t�@�C�����ύX����v���O�C���ł��B

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

	sdim types,sztypes,ntypes
	xpi_peek types,ai.ptypes,sztypes*ntypes


; �\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\
; ��ʂ̐���

	width 360,270
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
	mes "�Đ��ł���t�@�C����̐ݒ�"
	line 10,26,winx-10,26

	font "�l�r �S�V�b�N",12,16
	objmode 2,1
	objsize winx-110,20
	pos 15,40	:mes "MP3"
	pos 100,36	:input types.TP_MP3
	pos 15,65	:mes "WMA"
	pos 100,61	:input types.TP_WMA
	pos 15,90	:mes "Midi"
	pos 100,86	:input types.TP_MID
	pos 15,115	:mes "Wave"
	pos 100,111	:input types.TP_WAV
	pos 15,140	:mes "OggVorbis"
	pos 100,136	:input types.TP_OGG
	pos 15,165	:mes "CD Audio"
	pos 100,161	:input types.TP_CDA
	pos 15,190	:mes "(MCI)"
	pos 100,186	:input types.TP_MCI
	pos 15,215	:mes "(DirectShow)"
	pos 100,211	:input types.TP_DXS

	font "MS UI Gothic",12,16
	objsize 60,25
	pos winx-66,winy-30 :button "OK",*ok

	redraw 1
	gsel 0,1
	stop


; �\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\
; �ݒ�̕ύX

*ok

	repeat sztypes*ntypes
	 peek i,types,cnt
	 if (i>='a')&(i<='z') :i-=32 :poke types,cnt,i
	loop
	xpi_poke types,ai.ptypes,sztypes*ntypes

	end


; �\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\
;                                                              (c) arc@arcis
