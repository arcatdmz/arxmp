
title "arxmp �p�v���O�C���̃T���v��(4)"
; �\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\

/* ���상�� �\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\

 �E���� as �t�@�C���ɂ���

	�v���O�C���̃T���v���ł��B

 �\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\ */

	#include "_init_def.as"
	#include "_mod_xpi.as"

	xpi_connect ,1
	if stat=0 :end

	font "�l�r �S�V�b�N",16
	pos 10,10
	mes "�v���O�C�����N���������_�ōĐ�����Ă��鉹�y�̏���\�����܂��B"

	pos 20,csry+10
	mes "������^���"
	font "�l�r �S�V�b�N",12
	pos 30,csry+5

	sdim a,szminfo_
	repeat nminfo_
	 xpi_peek a,ai.pminfo_+(szminfo_*cnt),szminfo_
	 mes ""+cnt+": "+a
	loop

	font "�l�r �S�V�b�N",16
	pos 20,csry+10
	mes "���l�^���"
	font "�l�r �S�V�b�N",12
	pos 30,csry+5

	dim i
	repeat nminfo
	 xpi_peek i,ai.pminfo+(4*cnt),4
	 mes ""+cnt+": "+i
	loop

	gsel 0,1
	stop


; �\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\
;                                                              (c) arc@arcis
