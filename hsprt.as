#include "hrccmp.as"

	sdim out,32000
	sdim msg,32000
	sdim hrcname,260

	hrcname="arxmp.hrc"

	mes "HRC�t�@�C��"

	objsize 640,25
	input hrcname
	objsize 100,25
	button "HRC�I��",*openfile
	button "HRC�ҏW",*editfile

	mes "\n���s����"
	mesbox msg,640,300,1
	button "�R���p�C��",*compile

	stop

*openfile
	dialog "hrc;ini;txt",16,"HRC�t�@�C��"

	if stat:objprm 0,refstr

	stop

*editfile
	prm="notepad \"" + hrcname + "\""
	exec prm

	stop

*compile
	hrc_ini hrcname
	hrc_comp
	hrc_getmes out

	objprm 3,out

	stop
