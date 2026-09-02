Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AD9E381AE5
	for <bpf@vger.kernel.org>; Wed,  2 Sep 2026 19:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788377519; cv=pass; b=fPL8DTd0ZhapUqMWoD3RqLrMo568PoBza1FecwEJNFf6RHrkItynJxbG4r2yThfuAItflJZQzUxPc2Dair1HM8/rVruaQ3CX2Vg3Ze/Vwvvv89Oo1zqYMuADxJ2PZgnwLkDnOezpGajj/j+kJSPX7CjhnUMoQgYW4SGpeNP7xLY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788377519; c=relaxed/simple;
	bh=zzjKGij2xv9IwtzyPmqyOdFHZLosR5uzYe7NgB5WR5w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tlQsFCiSWGoa4sT9dOAPJB9LlpMw5nCUPZh8U5rFCVmlS7kfmZTY0d1nzuUN9CuoNHlotVe7pQr/4XSJ0KSNX6O1l4tSrZILI5qFkU4DZ61lZ2NdQzu0z1E89UPH90mKYBhf4NNpQwqIOs0cHR0CDMjxvbah5mgbGrIdAvqWa6E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DcO2qkaa; arc=pass smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DcO2qkaa"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-86b03b75fecso25092887b3.0
        for <bpf@vger.kernel.org>; Wed, 02 Sep 2026 12:31:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788377509; cv=none;
        d=google.com; s=arc-20260327;
        b=dLeqqmnqXsxpmKYjUPuSA0wAtiqqIQUNda6+h8jpeBwUUxl6dBGpmoEhYEbGfEOdE7
         Q1us8qhYiItShy/Uk3P9Ql5U8BKQ+DBnNNSuV7S+oal/vnq1N4u8w+gpyGc5/8tKYAQy
         CmQYo93DsZ+Cswxp4+KnfyM/zcrIz3Jk8W0koKAQcFQ3yzNfT4dvykRgjcW2RGbYeL04
         BUcv5LAQgukS3kjBMEUPTuPwql/vPciT5T/AVcSn9fePgcpy6Ou+U9gfgErLoynugqnL
         NqXmLlRjMqr2sm6IkKCVltzRv7K08LH+IlvdmZDWALHepMZqpqENT/kh0Vmv0Nvgb2h/
         7rrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4xB9mu0NfOZSjIYdWgzuHULYbUQ75NlZHyzkoQqQjp0=;
        fh=wv2/tgzKEVv2sc8w5Jp3c8RFafoKg/MqFWTy1K+jmn4=;
        b=dnS5t+P0jS9GedYOSIJlRLWO6NSXGZojXL/BZ7EV5cfRFp0H5M2T5YAvBfMC35BCFE
         6gc0p5qPchQ2Sb+suNIs+1a//wQ5CBR3HRyzmBa6dnb5rzk4ZfY0t/xtY/Y+1eglh0xw
         NrV5KuflRXZHqhr+MXP2awgUETW4k0X/GIzXxevxN1MAtBbceZr3/0Czs7XzF4uBFH+d
         nJwYMTRAwPs9VpCFbGmXVWW+ERFGRdktgtAmuI54acHJzRgrSw00RocrhunkNcXoem6S
         h50WbCXLvFzV7Q1Tp/VN0EGANceAtl2k49PHVtJVQZBrKwferCuRTXKvKmwCT2YNfwKM
         WJlg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788377509; x=1788982309; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=4xB9mu0NfOZSjIYdWgzuHULYbUQ75NlZHyzkoQqQjp0=;
        b=DcO2qkaaBXedEGfgIDl640T7TUGQpfBI0bwk3Wm3h1pK95XzF8ohcf5fi8xyh8vU51
         R/pNmsRDVBG1rN/OjgqkN9qQgzUFV+QU+Qa/t0++RD/wEHji62+/3GoAfWXzw0gV6WuM
         Xpvn2U8BVF/xK/94xntkvljMd6fpWBCcxeG1xnkmq6Q7ElqHfgq46f5czvPzFSwKheit
         VXYCneDkWeZORbud5Wjr9p1r0dqh7nIFO809NCVxh+SOHMKZlE77dVd/4HbMO0ue1FBe
         0sGFD5v6qvpxde73ixUPI9R1lPUy/myC13Moruz5OHXUcHxOg2fRZjWsD1/BLkKqa4rj
         9keg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788377509; x=1788982309;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4xB9mu0NfOZSjIYdWgzuHULYbUQ75NlZHyzkoQqQjp0=;
        b=JffMbY3raKwNLI55/01l1C32rNMBaH3CGGTNzW60/mL+Asy89wQP6bCottt2P7ILke
         iKrdHWSXl2C61ouA3e6KxvCTVfPri8keQCEoMzHUmoe0h1VNgL7K0Dm0ml2wcoHBfqrO
         7wd8YBEVpBYczEqilBNSX84lHGNYCfV3cWbWAlMhYa1dJRZwq4uTwoJnBDZBud3zVGqP
         zJ+6ZL71Fz17zRv2wdSPzF481Zgudf1PuIpX+MPzm+r4wY3QiWe5zlO6ooRod4unxRms
         hBrrFpi5WNLBkOicnj5DoZqK9P1MyWcM0j/nSqFvO5imp3fX54XbQ3dYzXidWZ2RzCk0
         iGfg==
X-Gm-Message-State: AFuF++ldX59cMObrOgoOb/9XGwya813SsmoIJWFO7ru8S8AEX8Dvd6rf
	CEdJsQ+D0cUK80mkxLD918ZrJvu1KbQs16jW5w6qo/W2du0zOTajPWaN5E+S8q/hZ1GDgPdyvIp
	U9CQmE3XBtxpLhiMZxpUPITK/kPvmsdo=
X-Gm-Gg: AYBFou2tNIZjqLXBd0oS8hwTbdMhSWcz6uneyTzdyMMnYhENtJX5jQeXPLCssThPrs9
	KRv3y9zb1t/WXnbHOnOvx679yDD2Vuiy4h4SSV7o1dmGAW/HyLYFXkM+IohJn4pAxmsokJqD1LE
	XeWLI3/GejFtOUyHAGzp7XXkalJN7uHLQ93MXSbeD5+5pAcvmheXB8DVGbpa/D3miCGQduBp4fd
	h1iBYADZtyaGkWhv0Tfx2N8R8tUsoGlfDuVshXBxMjHn3Kwky7xcaRG1ajMUhnTgZwZYGMeHntR
	4cKd1qCLjS9PwUYp75Pa0WqgO1Q11eICbNR5/wxsjDObptFxnt8o0uAqOS1JSphC4YjaqjPF9w=
	=
X-Received: by 2002:a05:690c:c512:b0:864:6fab:adff with SMTP id
 00721157ae682-86c509d9cd2mr39132517b3.14.1788377508601; Wed, 02 Sep 2026
 12:31:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260831110934.241898-1-a.s.protopopov@gmail.com> <DL514LM5TA6V.IOW7P2WM70BE@gmail.com>
In-Reply-To: <DL514LM5TA6V.IOW7P2WM70BE@gmail.com>
From: Anton Protopopov <a.s.protopopov@gmail.com>
Date: Wed, 2 Sep 2026 21:31:36 +0200
X-Gm-Features: AcwNN1V2Rt775pi-2pC2GM4FeyRGEHYTzRhtRvIQQntbTC-IwI8Yk3niV4K0Pwc
Message-ID: <CAGn_itxwZcMLtass5fZQ5XqgUtwTaJHfUGxg_SK7h_vqEgpmeA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 0/7] Add new way to add BPF LSM hooks
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, lsm <linux-security-module@vger.kernel.org>, 
	netdev <netdev@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Matt Bobrowski <matt@bobrowski.net>, John Fastabend <john.fastabend@gmail.com>, 
	Christian Brauner <brauner@kernel.org>, Paul Moore <paul@paul-moore.com>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 2, 2026 at 8:07=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
> On Mon Aug 31, 2026 at 4:09 AM PDT, Anton Protopopov wrote:
> > The BPF LSM programs are allowed to attach to LSM hooks. This enables
> > operators to mitigate known bugs without a need to reboot or livepatch
> > machines.  BPF has shown very useful to create such runtime policies.
> > However, many APIs and parts of kernel aren't covered by existing LSM
> > hooks and this would be beneficial to extend the coverage.
> >
> > To simplify the process of adding new hooks this patch series enables
> > BPF to attach policy programs to hooks defined outside of the
> > official LSM list.
> >
> > One of the reasons to add a new mechanism is that in order to add a
> > new LSM hook an implementation, at least one in-kernel LSM must be
> > added, such as SELinux or AppArmor, and BPF is specifically not
> > considered as a reference implementation [1].  This is, however, not
> > feasible for the use cases and capabilities covered by BPF LSMs,
> > which are not directly comparable to those of traditional LSMs.
>
> This is no go.
> bpf-lsm can attach to lsm hooks, but the machinery has nothing to
> do with LSM. bpf-lsm is exactly the same as bpf-mod-ret.
> So calling everything LSM is actively misleading and wrong.
> Patch 1 starts this misleading naming convention
> and then later patches add fake LSM hooks. Sorry, but no.

Got it, thank you.

>
> pw-bot: cr
