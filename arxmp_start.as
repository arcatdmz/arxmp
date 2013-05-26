
; ■ arX MusicPlayer starter
; ―――――――――――――――――――――――――――――――――――――

	; 変数
	sdim s,512
	sdim ss,512
	dim i

	; テンポラリディレクトリの取得
	sdim tmpdir,512
	ll_libload D_KERNEL,"kernel32"
	ll_retset dllret
	ll_getptr tmpdir
	prm=512,dllret
	ll_getproc i,"GetTempPathA",D_KERNEL
	ll_callfunc prm,2,i

	; run すべきファイルの確認
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
	if strsize=-1 :dialog "プレイヤーまたはプラグインを起動できませんでした。\n以下のファイルが存在しないことが原因です。\n\n("+s+")",1,"arXmp starter" :end
	run s,cmdline :end


; ――――――――――――――――――――――――――――――――
;                                                    (c) arc@arcis
