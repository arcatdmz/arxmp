
; �� arX MusicPlayer �̑��d�N���`�F�b�N				_init_xpi.as
; �\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\

/* ���상�� �\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\

 �E���� as �t�@�C���ɂ���

	�R�}���h���C���̕ϊ���ɑ��d�N���̃`�F�b�N���s���A
	���d�N�����Ă����ꍇ�̓v���O�C���Ƃ��ē����A�I���B

 �\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\ */


; �\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\
; �R�}���h���C���̕ϊ�
; �\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\

	repeat
	 tmp=cmdline
	 strlen i,tmp
	 if i=0 :break
	 tmp2=""
	 instr i,tmp,"\""
	 if i=-1 {
	  exist_ tmp
	  if stat=1 :tmp2=tmp :break
	 }
	 prm=ps,512,pss,pi
	 strlen prmex,tmp
	 ii=0
	 repeat
	  if ii>=prmex :break
	  strmid s,tmp,ii,1
	  ; (���p�X�y�[�X) ���o����X�L�b�v
	  if s=" " :ii++ :else {
	   ; " ���o���玟�� " �܂Ō���
	   if s="\"" {
	    ii++ :instr i,tmp,"\"",ii
	    ; �������� " ������������R�}���h���C���̏I���܂ł��p�X�Ɣ��f
	    if i=-1 :i=prmex-ii-1
	    ;  �t�@�C���p�X��������o��
	    strmid s,tmp,ii,i :tmp2+=s+"\n"
	    ; �t�@�C���p�X�̒����Ɓu"�v�̒����������J�n�C���f�b�N�X�ɑ���
	    ii+=i+2
	   ; ����ȊO�Ȃ玟�� (���p�X�y�[�X) �܂Ō���
	   } else {
	    instr i,tmp," ",ii
	    ; �������� (���p�X�y�[�X) ������������R�}���h���C���̏I���܂ł��p�X�Ɣ��f
	    if i=-1 :i=prmex-ii
	    strmid s,tmp,ii,i
	    ; �t�@�C���p�X�̒����������J�n�C���f�b�N�X�ɑ���
	    ii+=i
	    ; DOS�̃t�@�C�����������ꍇ���l�����ă����O�p�X�ɕϊ�
	    dllprocp FNC_GetFullPathNameA,prm,4
	    tmp2+=ss+"\n"
	   }
	  }
	 loop
	 break
	loop


; �\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\
; ���d�N���̔��f
; �\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\

	s=fmo_info
	prm=-1,0,4,0,szfmo_info,ps
	dllprocp FNC_CreateFileMappingA,prm,6	:hfmo_info=dllret
	dllprocp FNC_GetLastError,prm,0		:i=dllret
	prm=hfmo_info,2,0,0,0
	dllprocp FNC_MapViewOfFile,prm,5	:pfmo_info=dllret


; �\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\
; ���d�N�����̏���
; �\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\

	if i=183 {
	 ll_peek4 i,pfmo_info
	 if i!0 {
	  if tmp2="" :end
	  ; �E�B���h�E���b�Z�[�W���M����擾
	  ll_peek4 prmex,pfmo_info+12
	  ; �v���C���[�ւ̂c���c�t�@�C���o�^
	  ;  (1) ���ɋN�����Ă���v���C���[[��]��
	  ;                  �v���Z�X�n���h�����擾
	  prm=prmex,pi
	  dllprocp FNC_GetWindowThreadProcessId,prm,2
	  prm=$28,0,i
	  dllprocp FNC_OpenProcess,prm,3
	  prmex.1=dllret
	  ;  (2) �t�@�C�����X�g���A[��] �� funcopts �ɑ��
	  prm=prmex.1,0,ptmp2,bufmax,0
	  ll_peek4 prm.1,pfmo_info+16
	  dllprocp FNC_WriteProcessMemory,prm,5
	  ;  (3) [��] �ɃE�B���h�E���b�Z�[�W�𑗐M���A
	  ;                           �@�\�̎��s��v��
	  gm_setmessage hwProcess,WM_NOTIFYPI
	  prm=prmex,WM_EXECFUNC,FNC_LIST_ADD|FNC_ON,hwProcess
	  dllprocp FNC_SendMessageA,prm,4
	  i=-1
	  ; (1���Ń^�C���A�E�g)
	  repeat 600
	   wait 10
	   gm_getmessage msgval
	   if msgval=hwProcess&(msgval.1=WM_NOTIFYPI) {
	    i=msgval.3 :break
	   }
	  loop
	  prm.3=0
	  prm.2=FNC_LIST_REFRESH :dllprocp FNC_SendMessageA,prm,4
	  if i!-1 {
	   i-- :prm.2=FNC_PLAY+i
	   dllprocp FNC_SendMessageA,prm,4	  }
	  ; �I������
	  dllprocp FNC_CloseHandle,prmex.1,1
	  prm=hfmo_info,2,0,0,0
	  dllprocp FNC_UnmapViewOfFile,prm,5
	  dllprocp FNC_CloseHandle,prm,1
	  end
	 }
	}


; �\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\
; �ʏ펞�̏���
; �\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\

	; �@�\(FNC_*)�̃I�v�V�����w��Ɏg�p����ϐ���
	;                                  �A�N�Z�X����ݒ�
	prm=ptmp,bufmax,$40,pi :dllprocp FNC_VirtualProtect,prm,4
	prm=pfuncopts,bufmax,$40,pi :dllprocp FNC_VirtualProtect,prm,4

	; ��{�I�ȃv���O�C���������J�������L�������ɏ�������
	; (���̑��̏��� _init_var.as �ŏ�������)
	ll_poke4 vmain,pfmo_info
	ll_poke4 vscript,pfmo_info+4
	ll_poke4 vlanguage,pfmo_info+8
	ll_poke4 hwProcess,pfmo_info+12
	ll_poke4 pfuncopts,pfmo_info+16

	; �E�B���h�E���b�Z�[�W�擾�̏���
	gm_setmessage hwProcess,WM_EXECFUNC
	gm_setmessage hwProcess,WM_TASKTRAY


; �\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\
;                                                              (c) arc@arcis
