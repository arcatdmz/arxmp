
; �� �T�u���[�`��
; �\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\

/* ���상�� �\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\

 �E���� as �t�@�C���ɂ���

	�򖖂ȃT�u���[�`�����܂Ƃ߂Ă���

 �\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\ */


; �\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\
; ���y�t�@�C�����̎擾
;	�g�p�l	func,funcopt
;	�Ԃ�l	funcopts	���y�t�@�C����
;		funcopt		���̃��X�g���ł̈ʒu

*get_mpath
	if func&FNC_AUTO {
	 i=-1
	 repeat
	  if lNum=0 :break
	  if funcopt=IDX_SEL :i=lSelectedIdx :break
	  i=mFileIdx
	  if funcopt=IDX_CUR :break
	  if lMode&$F=PM_RND {
	   if lNum<2 :i=0 :else {
	    repeat
	     rnd i,lNum
	     if i!mFileIdx :break
	    loop
	   }
	   break
	  }
	  if funcopt=IDX_CUR_PREV {
	   i--
	   if i=-1 :i=lNum-1
	   break
	  }
	  if funcopt=IDX_CUR_NEXT {
	   i++
	   if i=lNum :i=0
	   break
	  }
	  break
	 loop
	 funcopt=i
	}
	if funcopt=-1 :funcopts="" :return
	notesel list
	noteget funcopts,funcopt
	return

; �\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\
; ���y���̎擾
;	�g�p�l	ss	���y��񎯕ʎq
;	�Ԃ�l	sss	���y���

*get_minfo
	if ss="indx" :im=mFileIdx+1 :sss=""+im :return
	if ss="posi" :timeconv sss,mPosition :return
	if ss="posh" :im=mPosition/1000/3600 :sss=""+im :return
	if ss="posm" :im=mPosition/1000/60 :sss=""+im :return
	if ss="poss" :im=mPosition/1000\60 :sss=""+im :return
	if ss="lgth" :timeconv sss,mDuration :return
	if ss="lgtH" :im=mDuration/1000/3600 :sss=""+im :return
	if ss="lgtm" :im=mDuration/1000/60 :sss=""+im :return
	if ss="lgts" :im=mDuration/1000\60 :sss=""+im :return
	if ss="fpth" :sss=mFilePath :return
	if ss="file" :sss=mFileName :return
	if ss="auth" :sss=mAuthor :return
	if ss="titl" :sss=mName :return
	if ss="atit" :sss=mAlbumName :return
	if ss="rele" :sss=mRelDate :return
	if ss="comm" :sss=mComment :return
	if ss="form" :sss=mFormat :return
	if ss="scrl" :sss=mScroll :return
	if ss="type" :get_langTP sss,mFileType :return
	if ss="stat" :get_langST sss,mStatus :return
	if ss="mode" :get_langPM sss,lMode :return
	return

; �\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\
; �I�u�W�F�N�gID�̎擾

;	�g�p�l	ss	�I�u�W�F�N�g���ʎq
;	�Ԃ�l	i	�I�u�W�F�N�gID

*get_objid
	; �I�u�W�F�N�g���ʎq �� �I�u�W�F�N�g�@�\
	gosub get_objfunc
	; �I�u�W�F�N�g�@�\   �� �I�u�W�F�N�gID
	gosub get_objid_from_func
	return

;	�g�p�l	ii	�I�u�W�F�N�g�@�\
;	�Ԃ�l	i	�I�u�W�F�N�gID
;	�O��	prm �̓��e��j�󂵂Ȃ�
;		(*exec_script �� FNC_LIST_CLEAR �p�̔z��)

*get_objid_from_func
	i=-1
	repeat objmax
	 if obj.cnt=ii :i=cnt :break
	loop
	return

*get_listobjid
	if dispListWnd {
	 i=5
	} else {
	 if sList :ii=FNC_PLAYLISTC :else :ii=FNC_PLAYLIST
	 gosub get_objid_from_func
	}
	return

; �\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\
; �I�u�W�F�N�g�@�\�̎擾
;	�g�p�l	ss	�I�u�W�F�N�g���ʎq
;	�Ԃ�l	ii	�I�u�W�F�N�g�@�\

*get_objfunc
	peek ii,ss,0
	if ii='$' :ii=ss :int ii : else {
	 ii=0
	 ; �I�u�W�F�N�g���ʎq �� �I�u�W�F�N�g�@�\
	 repeat objs
	  if obj_key.cnt=ss :ii=obj_func.cnt :break
	 loop
	}
	return

; �\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\
; �I�u�W�F�N�g���No.�̎擾
;	�g�p�l	ii	�I�u�W�F�N�g�@�\
;	�Ԃ�l	i	�I�u�W�F�N�g���No.

*get_objtype
	i=-1
	; �I�u�W�F�N�g�@�\ �� �I�u�W�F�N�g���ʎq
	repeat objs
	 if obj_func.cnt=ii :i=cnt :break
	loop
	return

; �\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\
; ���y���̕\�����X�V
;	�g�p�l	mScrollType	����

*get_mscroll
	if dispInfoWnd=1 :gsel widInfo
	mScroll=""
	repeat 5
	 i=mScrollType.cnt
	 s=""
	 repeat
	  if i=0 :s=mFilePath	:break
	  if i=1 :s=mFileName	:break
	  if i=2 :s=mAuthor	:break
	  if i=3 :s=mName	:break
	  if i=4 :s=mAlbumName	:break
	  if i=5 :s=mRelDate	:break
	  if i=6 :s=mComment	:break
	  if i=7 :s=mFormat	:break
	  if i=8 :sizeconv s,mFileSize :break
	  if i=9 :timeconv s,mDuration :break
	  if i=10:s=""		:break
	  if i=11:i=mFileIdx+1	:s=""+i+"." :break
	  break
	 loop
	 if s!"" {
	  if cnt!0 :mScroll+=" "
	  mScroll+=s
	 }
	 if dispInfoWnd=1 :objprm cnt*2+1,s
	loop
	s=mScroll :strlen i,s
	prm=bmscr.4,ps,i,pi
	dllprocp FNC_GetTextExtentPoint32A,prm,4
	mScrollWidth=i
	gsel sWid
	return

; �\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\
; �V�[�N�o�[�̈�̎l�����W���擾

*get_seekrect
	if (mDuration!0)&(mPosition!0) {
	if sSeekDirection=0 :prm=sSeekX,sSeekY,sSeekX+(mPosition*sSeekWidth/mDuration),sSeekY+sSeekHeight :else {
	  prm=sSeekX,sSeekY+sSeekHeight-(mPosition*sSeekHeight/mDuration)-1,sSeekX+sSeekWidth,sSeekY+sSeekHeight-1
	 }
	} else :prm=0,0,0,0
	return

; �\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\
; �X�N���[���̈�̍�����W���擾

*get_scrlpos
	prm=csrx,csry
	if mScrollWidth!0&(sScrollStep!0) {
	 prm+=sScrollWidth-(mainloop/TI_SCROLL\(mScrollWidth+sScrollWidth/sScrollStep)*sScrollStep)
	}
	return

; �\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\
; �o�b�t�@��ʂ𑀍���(��;����������)

*gsel_widBuffer
	if wi.widBuffer=0 {
	 #ifdef DEBUG
	 screen widBuffer,640,480,14 :boxf
	 title "debug window (2)"+sep+prgtitles
	 #else
	 buffer widBuffer,,,0 :boxf
	 #endif
	 wi.widBuffer=1
	} else :gsel widBuffer
	return

; �\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\
; �ŏ�������̕��A

*open_sWid
	if dispMainWnd&2 {
	 mii.1=1 :mii.3=0 :setmii hmOnMain,FNC_MINIMIZE|FNC_AUTO
	 dispMainWnd=dispMainWnd^2
	 gsel sWid,dispMainWnd&1+1
	 dllprocp FNC_OpenIcon,hwMainWnd,1
	 if dispTrayicon=0 :ctray
	}
	return

; �\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\
; ��ʂ��g�p�s�ɂ���

*disable_allWnd
	repeat 3
	 if dinfo.cnt!0 {
	  ; ����ʂ͓��͎��g�p�s�ɂ��Ȃ�
	  if cnt=2&(dispInfoWnd&IDX_WND_INPUT!0) :continue
	  prm=dinfo.cnt,0
	  dllprocp FNC_EnableWindow,prm,2
	 }
	loop
	return

; �\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\
; ��ʂ��g�p�ɂ���

*enable_allWnd
	gosub enable_allWnd_
	if dispListWnd {
	 prm=hwListWnd
	} else :prm=hwMainWnd
	dllprocp FNC_SetForegroundWindow,prm,1
	return

*enable_allWnd_
	repeat 3
	 if dinfo.cnt!0 {
	  if cnt=2&(dispInfoWnd&IDX_WND_INPUT!0) :continue
	  prm=dinfo.cnt,1
	  dllprocp FNC_EnableWindow,prm,2
	 }
	loop
	return

; �\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\
; �`�b�v�w���v�̍X�V

*refresh_tiphelp
	if dispTiphelp=0 :s="" :else {
	 scrLine+=scrAreaShow_TiphelpLine
	 script=scrAreaShow_Tiphelp+script
	}
	repeat snObj
	 ii=obj.cnt
	 gosub get_objtype
	 if i>=0 {
	  if dispTiphelp :i+=lgObj :s=langs.i
	  tiphelp s,cnt
	 }
	loop
	if wi.widList {
	 gsel widList
	 if dispTiphelp {
	  ; lgObj=31
	  tiphelp langs.56,0	; lgObj+objList_MoveUpFile
	  tiphelp langs.57,1	; �V	objList_MoveDownFile
	  tiphelp langs.52,2	; �V	objList_DelFile
	  tiphelp langs.53,3	; �V	objList_RenameFile
	  tiphelp langs.51,4	; �V	objList_ClrAll
	  tiphelp langs.44,5	; �V	objMainlist
	  tiphelp langs.50,6	; �V	objList_ClrFile
	  tiphelp langs.58,7	; �V	objList_Load
	  tiphelp langs.59,8	; �V	objList_Save
	  tiphelp langs.32,9	; �V	objWindow_CloseList
	 } else {
	  repeat 10
	   tiphelp "",cnt
	  loop
	 }
	 gsel sWid
	}
	return

; �\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\
; ���y�̍Đ��J�n�҂�

*wait_mStatus
	repeat 20
	 wait 10
	 func=FNC_GETSTATE :gosub *exec_func
	 if mStatus=ST_PLAYING :break
	loop
	return

; �\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\
; �v���O�C���ɉ��y�̍Đ���Ԃ�ʒm

*notify_mStatus
	prm.1=WM_NOTIFYPI,NP_ST,mStatus
	repeat szfmo_send/4,fi_send_mStatus/4
	 ll_peek4 prm,cnt*4+pfmo_info
	 if prm :dllprocp FNC_SendMessageA,prm,4
	loop
	return

; �\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\
; ���y�̍Đ��ʒu�ݒ�

*apply_mPosition
	i=TPfromTPEX(mFileType)
	if i=TP_OTH :return
	repeat
	 ; Windows MCI �𗘗p
	 if type.i=PF_MCI {
	  ; �ʒu�ړ�
	  if mFileType&TPEX_CDA {
	   i=mci_cdatrackstart+mPosition
	  } else :i=mPosition
	  mci "seek "+mci_alias+" to "+i+" wait"
	  mci "play "+mci_alias
	  break
	 }
	 ; DirectX DirectShow �𗘗p
	 if type.i=PF_DXS {
	  ; �ʒu�ړ�(MediaSeeking->SetPositions)
	  ; mPosition 1000 = 1[sec]
	  ; �� i 10000000 = 1[sec]
	  llreconv i,mPosition
	  prmex=pi,1,0,0
	  prm=pprmex,4,14,dxs_ms
	  ll_callfunc prm,4,pCallMethod
	  break
	 }
	 ; �O��DLL�𗘗p
	 if type.i=PF_DLL {
	  ; Vox.dll
	  if mFileType&TPEX_OGG {
	   prm=vox_id,mPosition
	   dllprocp FNC_vox_Seek,prm,2
	   break
	  }
	  ; vbmp3.dll
	  if mFileType&TPEX_MP3 {
	   prm=mPosition/1000
	   dllprocp FNC_vbmp3_seek,prm,1
	   break
	  }
	  break
	 }
	 break
	loop
	return

; �\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\
; �t�B���^�̃v���p�e�B(�܂��͐���)��\��
;	�g�p�l	funcid=FNC_OPEN_WND
; �t�B���^�̈ꗗ���擾
;	�g�p�l	funcid=FNC_OPEN_WND�ȊO(FNC_PLAY����̌Ăяo����z��)

*enum_filters
	; ���p�����t�B���^�̈ꗗ���擾(IGraphBuilder->EnumFilters)
	prmex=pi
	prm=pprmex,2,5,dxs_gb
	ll_callfunc prm,4,pCallMethod
	im=i
	;	im	/	IEnumFilters �|�C���^
	tmp2=""
	repeat
	 ; �e�t�B���^�� IBaseFilter �|�C���^���擾(IEnumFilters->Next)
	 prmex=1,pii,piii
	 prm=pprmex,3,3,im
	 ll_callfunc prm,4,pCallMethod
	 if dllret :break
	 ;	ii	/	IBaseFilter �|�C���^
		if funcopt=cnt|(funcid!FNC_OPEN_WND) {
		 ; �t�B���^�̏����擾(IBaseFilter->QueryFilterInfo)
		 prmex=ptmp
		 prm=pprmex,1,12,ii
		 ll_callfunc prm,4,pCallMethod
		 if funcid!FNC_OPEN_WND {
		  gosub *@f
		  s="DirectShow �t�B���^: "+s
		 }
		 ; tmp �擪 256bytes ���� 4bytes
		 ;	/	IFilterGraph �|�C���^
			; �t�B���^���v���p�e�B�y�[�W���������ׂ�
			qi ii,iii,dxs_iid_ISpecifyPropertyPages
			;  �����Ă��Ȃ�
			if iii=0 {
			 if funcid=FNC_OPEN_WND {
			  gosub *@f
			  ; s	/	�t�B���^��
			  i=npfprop-cnt
			  dialog "DirectX DirectShow\n\n�@DirectX�Ƃ�������ȃv���O�����̍\�����i�ł���DirectShow�́A���y��f���A�摜���Đ�����@�\�������܂��B\n\n�@DirectShow �t�B���^�́A�f�[�^�Ƃ��Ẵt�@�C��������f���Ƃ��ĕ\�������܂łɌo��ߒ����T�O�I�ɕ\���Ă��܂��B\n�@�t�@�C���� arXmp �̃��j���[�ɕ\������Ă���t�B���^�������珇�ɒʂ�A�Ō�Ɏ��ɕ������鉹�ƂȂ�܂��B\n�@�I�����ꂽ�u"+s+"�v�̓f�[�^��"+i+"�Ԗڂɒʂ�t�B���^�ł��B\n\n�����j���[�ɂ����� (*) ��̕t�����t�B���^�́A�N���b�N���ꂽ�Ƃ��ɓƎ��̃v���p�e�B�y�[�W��\�����܂��B",,"DirectShow"
			 }
			;  �����Ă���
			} else {
			 ; iii	/ ISpecifyPropertyPages �|�C���^
			 if funcid=FNC_OPEN_WND {
			  ; �y�[�W���̎擾(ISpecifyPropertyPages->GetPages)
			  prmex=ptmp2
			  prm=pprmex,1,3,iii
			  ll_callfunc prm,4,pCallMethod
			  ; ISpecifyPropertyPages �|�C���^�̔j��
			  ri iii
			  ; �t�B���^�� IUnknown �|�C���^���擾
			  qi ii,iii,dxs_iid_IUnknown
			  ; iii	/ IUnknown �|�C���^
			  ; �v���p�e�B�y�[�W��\��
			  prm=hwMainWnd,0,0,ptmp,1,piii,0,0,0,0,0
			  memcpy prm,tmp2,8,24,0
			  dllprocp FNC_OleCreatePropertyFrame,prm,11
			  ; IUnknown �|�C���^�̔j��
			  ri iii
			  ; �y�[�W���p�������̈�̉��
			  dllprocp FNC_CoTaskMemFree,prm.7,1
			 } else {
			  s+="(*)"
			  ri iii
			 }
			}
		 if funcid!FNC_OPEN_WND :tmp2+=s+"\n"
		 ; IFilterGraph �|�C���^�̔j��
		 memcpy iii,tmp,4,0,256 :ri iii
		}
	 ; IBaseFilter �|�C���^�̔j��
	 ri ii
	 if funcopt=cnt&(funcid=FNC_OPEN_WND) :break
	loop
	ri im
	return

	*@
	repeat 128
	 wpeek prm,tmp,cnt*2
	 if prm=0 {
	  prm.1=0,ptmp,cnt+1,ps,(cnt+1)*2,0,0
	  dllprocp FNC_WideCharToMultiByte,prm,8
	  break
	 }
	loop
	return

; �\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\
; �ϒ��`���ŕ\���ꂽ�������擾����
;	�g�p�l	tmp	�f�[�^
;		prm	�ϒ��`���̊J�n�ʒu
;	�Ԃ�l	prm.1	����

*get_delta
	prm.1=0
	repeat 4
	 peek iii,tmp,prm
	 prm.1=prm.1<<7+(iii&$7F)
	 prm++
	 if iii&$80=0 :break
	loop
	return

; �\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\
; DDE������I���

/*
*uninit_dde
	repeat
	 if dde_name="TMIDI" {
	  dde_dc
	  if dde_hwnd {
	   prm=dde_hwnd,WM_CLOSE,0,0
	   dllprocp FNC_SendMessageA,prm,4
	  }
	  break
	 }
	 if dde_name="WFP" {
	  dde_exec "/QUIT"
	  dde_dc
	  break
	 }
	 break
	loop
	return
*/

; �\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\
; �{�^���ɑ΂���}�E�X�̓�����ǐ�
;	�g�p�l	i	�I�u�W�F�N�gID+41

*track_mouseleave
	prm=16,2,bmscr.i,0
	dllprocp FNC_TrackMouseEvent,pprm,1
	return


; �\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\
;                                                              (c) arc@arcis
