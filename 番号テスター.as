
title "�@�\�ԍ��e�X�^�["
; �\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\

/* ���상�� �\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\

 �E���� as �t�@�C���ɂ���

	�@�\�ԍ��̎��s���e�X�g���܂��B

 �\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\ */

	#include "_init_def.as"
	#include "_mod_xpi.as"

	ll_getproc pEnableWindow,"EnableWindow",XD_USER
	#define ableobj(%1,%2)	prm=%1+41 :prm=bmscr@xpimod.prm,%2 :ll_callfunc prm,2,pEnableWindow
	#define disableobj(%1)	ableobj %1,0
	#define enableobj(%1)	ableobj %1,1

	xpi_connect ,1
	if stat=0 :end

	; Prepare for main processing.
	font "MS UI Gothic",14
	font "Tahoma",14
	objmode 2,1
	dim func
	func="$00000000"
	sdim funcopts,65535
	funcopts="(�@�\�ԍ��� STR=$00040000 ���܂܂�Ă���Ƃ��̂݁A���̗��ɓ��͂��ꂽ�����񂪋@�\�̃I�v�V�����Ƃ��Ďg�p����܂��B)"
	sdim s,64

	; Initialize the main window.
	pos 10,7
	mes "�@�\�ԍ�:"
	pos 10,33
	mes "�I�v�V����:"
	objsize winx-90,21
	pos 85,5
	input func
	objsize winx-90,409
	pos 85,31
	mesbox funcopts,,,1
	objsize 135,30
	pos 395,445
	button "�@�\�ԍ��ɂ���",*explanation
	objsize 100,30
	pos 535,445
	button "�@�\�̎��s",*execute

	; Show the main window. (Stand by.)
	gsel 0,1
	stop

	; Show the web page explaining "�@�\�ԍ�".
	*explanation
	exec "http://dmz.catfood.jp/1/arxmp/res/arxmp_functype.html",16
	stop

	; Execute specified "�@�\�ԍ�",
	;  and inform result by showing dialog.
	*execute
	int func
	if func&$040000	:xpi_opt funcopts
	repeat 4 :disableobj cnt :loop
	xpi_func func
	repeat
	 s=stat
	 if s=$0F000001	:s="FR_IDLE(�v���C���[�͑ҋ@��Ԃł�)" :break
	 if s=$0F000000	:s="FR_ERR(�@�\���s���ɃG���[���������܂���)" :break
	 if s=$00000000	:s="FR_DONE(�@�\�͖��Ȃ����s����܂���)" :break
	 str s
	 break
	loop
	repeat 4 :enableobj cnt :loop
	str func,24
	func="$"+func
	dialog "���s���ꂽ�@�\: "+func+"\n�Ԃ�l: "+s
	objprm 0,func
	stop


; �\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\
;                                                              (c) arc@arcis
