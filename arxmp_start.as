
; �� arX MusicPlayer starter
; �\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\

	; �ϐ�
	sdim s,512
	sdim ss,512
	dim i

	; �e���|�����f�B���N�g���̎擾
	sdim tmpdir,512
	ll_libload D_KERNEL,"kernel32"
	ll_retset dllret
	ll_getptr tmpdir
	prm=512,dllret
	ll_getproc i,"GetTempPathA",D_KERNEL
	ll_callfunc prm,2,i

	; run ���ׂ��t�@�C���̊m�F
	repeat
	 ss=tmpdir+"run.xmp"
	 exist ss
	 if strsize=-1 {
	  ss=exedir+"\\d\\run.xmp"
	  exist ss
	  if strsize=-1 :s=exedir+"\\d\\arxmp.ax" :break
	 }
	 bload ss,s
	 delete ss
	 chdir exedir+"\\e\\"
	 break
	loop

	; run
	exist s
	if strsize=-1 :dialog "�v���C���[�܂��̓v���O�C�����N���ł��܂���ł����B\n�ȉ��̃t�@�C�������݂��Ȃ����Ƃ������ł��B\n\n("+s+")",1,"arXmp starter" :end
	run s,cmdline :end


; �\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\
;                                                    (c) arc@arcis
