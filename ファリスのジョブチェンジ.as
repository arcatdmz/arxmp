;
#define mytitle "�t�@���X�̃W���u�`�F���W"
; �\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\

/* ���상�� �\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\

 �E���� as �t�@�C���ɂ���

	�t�@���X�̃W���u�`�F���W���s���܂��B

 �\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\ */

	#include "llmod.as"
	#include "_init_def.as"
	#include "_mod_xpi.as"

	xpi_connect
	if stat=0 :end

	#define faris_folder	"�t�@���X���X�L��\\"
	#define faris_skin	"�t�@���X���X�L��.xsp"
	#define faris_setting	"�t�@���X���X�L��.xsv"
	#const CharX		284
	#const CharY		142

	#module
	; �V�X�e���F���擾
	; p1 : �擾��
	; p2 : �擾���
	#deffunc excinfo val,int
	mref col,48
	mref prm,1
	dllproc "GetSysColor",prm,1,D_USER
	col.0=dllret@&255
	col.1=dllret@>>8&255
	col.2=dllret@>>16&255
	return
	; �E�B���h�E�̑���
	; active p1,p2
	;  p1 : ���샂�[�h(�E�B���h�E�������A�N�e�B�u/�E�B���h�E�𑀍�\/�s�\)
	;  p2 : �E�B���h�EID
	#deffunc active int,int
	mref i,0
	mref wid,1
	if i=0 :gsel wid,1 :return
	mref bmscr,96+wid
	prm=bmscr.13,(i=1)
	dllproc "EnableWindow",prm,2,D_USER@
	return
	#global

	; �o�b�t�@�m��
	sdim s	,	512
	sdim ss	,	512
	dim i :dim ii :dim iii
	sdim tmp,	3200
	;  �摜�t�@�C���̃��X�g
	sdim xsslist,	2048
	;  �X�L���f�B���N�g��
	sdim skndir,	512
	;  �V�X�e���F
	dim SysColor,3	:excinfo SysColor,15	;�w�i�F
	dim SysColorS,3	:excinfo SysColorS,16	;���F
	;  ���݂̃W���u�i�摜�t�@�C�����j
	sdim now_faris,	256
	;  �I������Ă���W���u
	dim sel_xsslist :dim sel_xsslist_b
	;  �X�L���̓��ߐF
	dim TransColor,3

	; ������
	font "�l�r �S�V�b�N",13 :objmode 2
	width 450,180
	title mytitle

;_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/
; ���C������

	; �X�L�������擾
	xpi_peek skndir,ai.pdir,szdir
	xpi_peek s,ai.psinfo_,szsinfo_
	if s!faris_skin {
	 exist skndir+faris_skin
	 if strsize=-1 :dialog "���̃v���O�C���̓t�@���X���X�L�����Ȃ��Ɨ��p�ł��܂���B\n���݃v���C���[�ɂ̓t�@���X���X�L�����C���X�g�[������Ă��Ȃ��̂ŁA�v���O�C�����I�����܂��B",0,mytitle :end
	 dialog "���̃v���O�C���̓v���C���[�̃X�L�����u�t�@���X���X�L���v�łȂ��Ɨ��p�ł��܂���B\n�v���C���[�̃X�L�����t�@���X���X�L���ɕύX���܂����H",2,mytitle
	 if stat=7 :end
	 s=faris_skin
	 xpi_opt s
	 xpi_func FNC_XSP_LOAD|FNC_STR
	}

	; �摜���X�g�̎擾
	gosub *_refresh_xsslist
	buffer 3 :gsel 0

	; ��ʂ̐���
	font "�l�r �S�V�b�N",12 :objmode 2
	redraw 2
	pos 5,5		:objsize winx-40,21 :combox sel_xsslist,120,xsslist
	pos winx-35,5 :objsize 30,20 :button "�X�V",*refresh_xsslist
	pos 5,30	:objsize 150,winy-35 :button "�W���u�`�F���W��",*change_job
	gosub *load_job
	gosub *refresh
	redraw 1

	gsel 0,1

; ���C�����[�v
*mainloop
	if sel_xsslist!sel_xsslist_b :sel_xsslist_b=sel_xsslist :redraw 2 :gosub *refresh :redraw 1
	wait 5
	goto *mainloop

; ���݂̃W���u�ݒ��ǂݍ���
*load_job
	; �X�L���ݒ�t�@�C����ǂݍ���
	exist skndir+faris_setting
	if strsize=-1 :return
	bload skndir+faris_setting,tmp
	notesel tmp :noteget s,0
	strlen i,s
	ii=0
	; �摜�t�@�C�������擾
	repeat i
	 instr iii,s,"\\",ii
	 if iii!-1 :ii+=iii+1 :continue
	 strmid s,s,ii,i-ii :break
	loop
	; �W���u�̃��X�g�Ɣ�r
	notesel xsslist :notemax i
	repeat i
	 noteget ss,cnt
	 if ss=s :sel_xsslist=cnt :break
	loop
	return

; �W���u��ύX����
*change_job
	; �I�����ꂽ�W���u�������H
	if sel_xsslist=-1 :return
	; �摜�����݂��Ȃ��W���u�H
	if strsize=-1 :return
	; �W���u��ύX�i�X�L���ݒ�t�@�C����ǂݍ��݁j
	active 2
	title "�������҂������� / "+mytitle
	s=skndir+faris_folder+now_faris+".xss"
	xpi_opt s
	xpi_func FNC_XSS_LOAD|FNC_STR
	title mytitle
	active 1
	goto *mainloop

; ��ʂ��X�V����
*refresh
	; �摜�ǂݍ���
	if sel_xsslist=-1 :return
	notesel xsslist
	noteget now_faris,sel_xsslist
	s=skndir+faris_folder+now_faris+".bmp"
	exist s
	gsel 3
	color SysColor.0,SysColor.1,SysColor.2		:boxf
	if strsize!-1 {
	 pos 0,0 :picload s,1,0,0
	 pget 0,0 :TransColor.0=rval :TransColor.1=gval :TransColor.2=bval
	}
	; ��ʂɕ\��
	gsel 0
	color SysColor.0,SysColor.1,SysColor.2		:boxf
	color TransColor.0,TransColor.1,TransColor.2	:gmode 4,,,256
	pos 160,30 :gcopy 3,0,0,CharX,CharY
	return

; ���X�g�̍X�V
*refresh_xsslist :gosub *_refresh_xsslist :goto *mainloop
*_refresh_xsslist
	; �W���u�̃��X�g���擾
	dirlist xsslist,skndir+faris_folder+"*.xss",1
	notesel xsslist
	notemax i
	if i=0 :dialog "�W���u�`�F���W���邽�߂ɕK�v�ȃX�L���ݒ�t�@�C��(*.xss)���������܂���B\n�v���O�C�����I�����܂��B",0,mytitle :end
	; �g���q�̏���(abc.xss �� abc)
	repeat i
	 noteget s,cnt
	 strlen i,s
	 strmid s,s,0,i-4
	 noteadd s,cnt,1
	loop
	; �R���{�{�b�N�X���e�X�V
	objprm 0,xsslist
	return


;_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/
;                                               (C) Arc@ARCIS