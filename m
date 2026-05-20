Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E41503D171C
	for <bpf@vger.kernel.org>; Wed, 20 May 2026 14:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779286957; cv=none; b=HHd9uMdqFzwU+6b8u46u/WWgLw5SmNOS+BSAOrkTg/onqfrF3lrZZ4KSfw08C2FEcADelJvIBIsHOPW5RILFNX0Z2cm7mfG77C3KRJtUkkn3n2WNJfVC17yj1XdUDz6+lFGKE+bLYX1tWNN5ELz9mhQINgDfoYEUyK3+tgSmO1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779286957; c=relaxed/simple;
	bh=sGlwd6u82z+6w2sCIVZ2iDxtNvSuIiWzCUEzS7fBp7w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cg4n0/rPoXD5qIaOOuELsaOUeKbFmwlGa5iRZgHfQPlWbi5zOWjedgzu3ksjJP1OnmCq+Wts3PE0nemcCV3iAfW8MhyO7CuTaOFATpBwj1yN81y3LtuKQGjow35cs27q7bVVxKvQboMkMnZJOS3opYtBr1912QA3RgC2TNbpBMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-56f6afbd205so2991519e0c.0
        for <bpf@vger.kernel.org>; Wed, 20 May 2026 07:22:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779286955; x=1779891755;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aZoThamAoFC+57ME4syXtEn5B5U6ktH01XuUBn+rEH8=;
        b=QIM6CUfGZg141RQBP3//MnzQ35l95nl1Z8jfz2gLJk/8eEuF5BaB1IBxZc374yTdvA
         EXteAkSM9zqNYbjqqsvoDE8pOUQD9DJXGIj6wOuMMRi984RgLJExgpfwn6pdoKvTWeds
         EKULK/EsaSXZWJMKBtnVa/qK8T8mqSmMUdbuhkkTTeSBzEp/vCEFuZhNddnFkMx6vpo+
         XHEIYk63ZiAW+Z4NJSrCbsgll/+jjyh53Du7IyoAj/A6Y2x303NO8GD+LnFaOQBn41pp
         lwZ8uGzboYBLYR3luBYg36DTPaXYy/0hZceh6TzDw+TPZPxiPK2NRFkKZ3I0hDHCUaLi
         cz2Q==
X-Forwarded-Encrypted: i=1; AFNElJ+yY2cQ9zjWy2qwVFW/aM3uPzJIElGbAMMOnOvkotfHQmkQ/mPObpADA68PC1PChy3048A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFbXCabUIKTbvyvNnaAm+l/riFaTM6YAY/8pufa5d95k60/KzF
	uu81TIUMZTccH40Oq11FqCYiFRdzffwyZBYLaQHlBJMjOmROQmikioYU4UYVevKmAPg=
X-Gm-Gg: Acq92OGZOFwobNF3Whj29wqiAH2g0cITpQ6zkN6vKTCII1Z+/zD0XewKIPekiutn9sq
	0APWKjbdDpeo/0LyitMIHUPOGXNToLJY0tKwXTXc/G5XXTFmSVS7cEAdtZHA1YaBvujkzZUzdkp
	ID/2NFu8lsWwb4Gpk4uHdGkhq0ttw6G7mUdxZAgSthZwjeJ+/Qeu1Eh6/QpVFrRwXUEssBf6V2e
	ogOpHORuRbqgqYy5qT8fWDcfvt3RdHVTRWNAY2vptbSrF/Yn3GuuDN682hvmDhUNANMaLlsLCX4
	FUrIWTLTiBazwNPajnX7XA1qJcbFOsozSVOdgQZB+CweupmGUHr+KEhzEBC+iiyP6KTyiYP0cpg
	70H34tVI3KEWqRA1l0sD9d6J2MBuKoxYsoXzn8aOZ4Rk9XwBHi0OGsKmxS+JmOFdyIPB8VAQvw/
	QhM+01yk6J+8TVZWqUiGlYy+KgZxqKzeiweJWA/GwfwdRxA6aIO8mpl0gv2h6daCrT34/Dm8+ee
	vwZeTvRLbSFuA==
X-Received: by 2002:a05:6122:220e:b0:575:fa0b:bc23 with SMTP id 71dfb90a1353d-5760b7104ecmr4569427e0c.2.1779286954522;
        Wed, 20 May 2026 07:22:34 -0700 (PDT)
Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com. [209.85.221.179])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5760fae4264sm11748613e0c.17.2026.05.20.07.22.29
        for <bpf@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 May 2026 07:22:29 -0700 (PDT)
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-56f6afbd205so2991420e0c.0
        for <bpf@vger.kernel.org>; Wed, 20 May 2026 07:22:29 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+oW+neKNEJQhz9e7vP8lc6TLDD97+1VWQgPOoCn03exFUJanWTEXhLxmV2eck6Jy+84ow=@vger.kernel.org
X-Received: by 2002:a05:6122:6b8a:10b0:56e:e652:2c10 with SMTP id
 71dfb90a1353d-575f574b7e6mr7767762e0c.4.1779286949282; Wed, 20 May 2026
 07:22:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260519203858.1342507-1-arnd@kernel.org> <9eecfab7-afac-4144-b544-ac715b07980e@linux.dev>
 <8e9cdb17-83c6-4287-91eb-dd6d3a457f28@app.fastmail.com> <CAADnVQKnc6JTObEPUqh-EBY7+_GJ3TPfetxiWYE86UAiiMn-AA@mail.gmail.com>
In-Reply-To: <CAADnVQKnc6JTObEPUqh-EBY7+_GJ3TPfetxiWYE86UAiiMn-AA@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 20 May 2026 16:22:18 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWb2hA+z+=ewu_=E2E40AtE-dYjzECKOaja+E414zbixA@mail.gmail.com>
X-Gm-Features: AVHnY4IUmr7th7FfH5RLAy9yHVc1Z15QwLSdp67zRIpVjevSQzaeDtGElwSzkk8
Message-ID: <CAMuHMdWb2hA+z+=ewu_=E2E40AtE-dYjzECKOaja+E414zbixA@mail.gmail.com>
Subject: Re: [PATCH] bpf: avoid padding in struct bpf_common_attr
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Yonghong Song <yonghong.song@linux.dev>, 
	Arnd Bergmann <arnd@kernel.org>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Leon Hwang <leon.hwang@linux.dev>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	KP Singh <kpsingh@kernel.org>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Alexei,

On Wed, 20 May 2026 at 16:03, Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
> On Wed, May 20, 2026 at 8:39=E2=80=AFAM Arnd Bergmann <arnd@arndb.de> wro=
te:
> > On Wed, May 20, 2026, at 00:17, Yonghong Song wrote:
> > > On 5/19/26 1:38 PM, Arnd Bergmann wrote:
> > >> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> > >> index cc4c0b62cdfa..0f0ec00cae4a 100644
> > >> --- a/include/uapi/linux/bpf.h
> > >> +++ b/include/uapi/linux/bpf.h
> > >> @@ -1507,6 +1507,7 @@ struct bpf_common_attr {
> > >>      __u32 log_size;
> > >>      __u32 log_level;
> > >>      __u32 log_true_size;
> > >> +    __u32 __pad;
> > >
> > > Let us make it as
> > >       __u32 :32;
> > > ?
> > > This can avoid people to use the '__pad' name.
> >
> > Sure. Do you want me to resend, are are you going to change
> > it yourself?
>
> No need to add a pad.
> The issue was fixed in commit f05ddc6771c4 ("bpf: Check tail zero of
> bpf_common_attr using offsetofend")

I am afraid that commit does not fix any  -Wpadded warnings?

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds
