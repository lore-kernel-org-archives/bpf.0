Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF74E381EB7
	for <bpf@vger.kernel.org>; Fri,  7 Aug 2026 22:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786141820; cv=pass; b=kqjv0fpoZaQVgFZb6E1FS3d8lRiEaGgyP9D0ug2Cmxijhk17JbYadQ1vdhvw2bAdRiJkfxiogk/hysXfgNkcEXC0HdEokD8tp1AaR0mp2EkinHR/o6UCpqxPS7IagqUDPKLCgnbi5s707rtXqRvH3RaDfWIU9bwmaLOIGAGrjf4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786141820; c=relaxed/simple;
	bh=M+zrpUV0VaFtoZj+OU64r6AtSK4v33i3ABYR8V+3Uzw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LqZK78MhDNhi5PCTjKaoHkKY+IL4ePbWp6HcZONBdVvFKTxiUQ09lzIuJ2AcLSUOFEFcmPf2YMnoT6tM8sTloePCbvdKh6nzZsjfqZOEfij+wUiMxQei9r0SA+sFNRso0sRKVNH/CYsLx4aBIr5LpRB1eqSCOtS4IGMBxL7Q/c0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fgXSh7UC; arc=pass smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fgXSh7UC"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-848761b5897so16636b3a.3
        for <bpf@vger.kernel.org>; Fri, 07 Aug 2026 15:30:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786141818; cv=none;
        d=google.com; s=arc-20260327;
        b=qi05xoBJh4MIqw/t8re5vt62YvZiJvIOjeEUizr3qg3Zr3T6iK1qUViFCfsiS5sD6c
         AAkseZXPFhoYg1SWFu7xPVQvPaPSfWGqjBcvwALl/ALGr7jqS0gbL7Fb6EgMh9GiKtXy
         h0kDfbLC0joFfgCHPEG8uQjdGzWuDXRyScJscSb/EYb3Ii3f+x5XbfPICfuD14eCer6E
         hO8r/iolCLaNkCpxHjzaAjZtRlL49fiIMYrvyYbWfEHPNRktdMsjUQ5CQ5TOCLEO6iJj
         akSLt/zIDH5HFPic1yxozeLRmDLLjUvzBl5CxuMnt6iSxkGmPZgjSKlnbGwyahsz1VOP
         xQnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=M+zrpUV0VaFtoZj+OU64r6AtSK4v33i3ABYR8V+3Uzw=;
        fh=9cKgm0AuBDFqeSwfuMM12VB83nsYTgcxkg8Hkn332Qk=;
        b=ILi+lyuHHGSNVSplK3pO6DFoRjm2weKjXfDvbNl99YKvUg5861hcBJOIQNjtAYdHwO
         wbbNHokHtcslhr/JFI8LIgl2k1krQqzM3pM6GIfQtk4VnzjVYFABKS7v+NLMlD4ltS0F
         dJ1QpsXMjMg6kVw20cavaCTr5jk51hwh7Cgc9gXBR0y5NG0WER8v9wVocKHz3yin38dl
         B5/aU8rN3HR0rj2ruQZlu/O07Ts1UTzA6uPsCREuAi+XqaC+jz9OssN62Ezlra+lduUh
         jIX2Yt4OD7aiHx2hLrTl0y2hlUgm1MDX3tiYGrsnuohwuTJW/EBPGIdVceAGx2NRluyI
         jpRA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786141818; x=1786746618; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=M+zrpUV0VaFtoZj+OU64r6AtSK4v33i3ABYR8V+3Uzw=;
        b=fgXSh7UCXD3PPOIv3iggmckx8Byk1heFyXO4pQTwRzT16RJQmv7I8yIFhIXM0FCglr
         nlUdV7eD9nZn2Cf55c+wscIqDiNncXGckNUtOpGdcBZrXd8ZeNfHbPSR85wPQXlPGkGK
         2XZjWgvmgCzP9ry+WdT7nakbcomoLGTwHI5fNOwGT7zGXVSGKENn8crPjXmdf57ON/hG
         WrXqF5JUcUcaBOwl1Au9vLrL+9wCphJI9pkSJFjrWHDUznZEn6vOCPb0jyH6i+9vmq2f
         o6qJlQeLEL/fkFbSJt3fk8o+f0/5GIimt76PcUcasbFLtOhVMjyUxrpJwNDN4SJEWvop
         KCCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786141818; x=1786746618;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=M+zrpUV0VaFtoZj+OU64r6AtSK4v33i3ABYR8V+3Uzw=;
        b=rFZQjY1rlF4kZDp8eyebUE4QMMRC3PiGAQykh+IlKywMWOvh2hwOdm3lj5WduHokjv
         ec7MUyW/Z2sk7qlRn7sw14vYCZeIOtTpIYS2SI5OiHSU26ILFA5zEZc8Sd8wPlUazELp
         5/ws6nmg8FGqjmztIdrqAw5hGrOb51/WY2zIqB+n4BGHmRQDnOCaOeY7Q087bopqZfsY
         VM0qaEZW+RioAlbvc6ZGWuzeNBV64MgCpDMBQD723/ZbKKbIju2p1QtStg2j9dxTWr7m
         rWx4W+U9KgtGWNTinvDuOnOIfyf409bwHvcJxZaygxC0tzaRzEYKcCMPSfa99q4s64+Q
         2jKA==
X-Forwarded-Encrypted: i=1; AHgh+RqRfmDurk1zB1PI1BA/YvZ1BPmR3VPvAjLJrJC+oN2uxxJuisoO11Ebtwnu3Cjt5SHwkm0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGCuQGt2ydyas+17dPkqJe8o+HgadTjfl+0a5ZN5h3O7CJ5DTw
	pvBUe1oH1zTL5YSesoV4qUERn30JIp+L4qG7dIOfqUQ+uC1Ywj4vT/RBYAmnqQGGnzeG8HxYdWx
	wY5+Fbzt4xckVRC0up53J6neYPWKvXTc=
X-Gm-Gg: AR+sD13s5KeweyCYYVwLNq/57iD+eg4f5+ZIHxNrYhtk6Un4ONJ0V7jnCjtjq9Eey4N
	FEwIBEC9ALk7i0tmgJFE+USCOhAa/4PbHrelbxIfLuiK5c4su5G5e5fSFl0eUzsdB6HD3sxAh16
	VW82UHMomNjOQDoUkhfhaZAH4GO0w+H1+eVOZwkl3ZoUn5/pbAY0Qt0QR65+LTAgLIZhXCRyCIx
	LunTcVdooQmEquFGf/Ez6cgAEwYzS9NkBHR8N3Csdknqg1wo96o0NENyG7tw9Pdln4dxOKDkxcE
	sZWBdgjnopRFMjVSCYbrWCgaP/Mc2Mue20xy8OHXJm0omA0rsC7HGp+ChCejuEKTq39L5SesMou
	Lx638SL75YcutwEMlecBOaptmXh6USlnnmBW4TwWwig==
X-Received: by 2002:a05:6a00:a0d:b0:84e:1a34:2470 with SMTP id
 d2e1a72fcca58-84f2e01f32emr23437500b3a.30.1786141818074; Fri, 07 Aug 2026
 15:30:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260803021643.2189641-1-dwindsor@gmail.com> <a68933c3-39d6-414e-b869-bb3fd1a6b4ba@linux.dev>
 <CAEXv5_iKZnDvitaURzcAJDdHHB6H-YwP5MApMeCR64KqXQVRSQ@mail.gmail.com>
In-Reply-To: <CAEXv5_iKZnDvitaURzcAJDdHHB6H-YwP5MApMeCR64KqXQVRSQ@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 7 Aug 2026 15:30:02 -0700
X-Gm-Features: AUfX_mwTs1S4Da7NtyyNQX7khDCecbTNZNFw_lktzzmqViefwoUE5YGm4eQjG2E
Message-ID: <CAEf4BzbyevsZYb_xH_yRmKGv=MDdEmobc-vWwW2KwPjU2Qp-Xw@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: add BPF_F_SEALED flag to seal BPF links at creation
To: David Windsor <dwindsor@gmail.com>
Cc: Leon Hwang <leon.hwang@linux.dev>, bpf@vger.kernel.org, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Emil Tsalapatis <emil@etsalapatis.com>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>, Liam Wisehart <liamwisehart@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 2, 2026 at 8:26=E2=80=AFPM David Windsor <dwindsor@gmail.com> w=
rote:
>
> On Sun, Aug 2, 2026 at 10:44=E2=80=AFPM Leon Hwang <leon.hwang@linux.dev>=
 wrote:
> >
> > On 3/8/26 10:16, David Windsor wrote:
> > > Introduce a new BPF_F_SEALED flag for BPF_LINK_CREATE that creates th=
e
> > > link permanently sealed. A sealed link can never have its program
> > > replaced via BPF_LINK_UPDATE, can never be detached via BPF_LINK_DETA=
CH,
> > > and holds an extra self-reference that is never released, so the link=
 and
> > > its program attachment persist until the machine reboots, even after =
user
> > > space closes every fd referring to it. There is no way to unseal a li=
nk.
> > >
> > > The sealed state is tracked by a new bool field on struct bpf_link.
> >
> >
> > Why do you want BPF_F_SEALED? What's your case for it?
> >
>
> For the BPF LSM use case, mainly. There is some language in the
> commitmsg about programs not being able to be unloaded until reboot,
> but I will be more explicit in v2.
>
> There was a presentation ("Securing BPF LSMs against tampering") [1]
> at LSFMM+BPF about it.
>
> [1]: https://lwn.net/Articles/1082111/

I had to skim the articles to recall that it was me proposing
something like this :)

Anyways, as Kumar mentioned, a) link has to be crated as sealed before
FD is exposed, it's straightforward, and b) I do think that it would
be too easy to have syzbots of the world to accidentally or not create
tons of sealed links, so I'd require CAP_SYS_ADMIN for this, which I
assume won't be a problem for intended use cases?

But also, yeah, I wonder what Christian and other BPF LSM users think
about this.

pw-bot: cr


>
> > I think 'sealed' should be set before allocating the FD to avoid the
> > race issues reported by Sashiko.
> >
>
> Will do this in v2.
>
> > Thanks,
> > Leon
> >
> > > [...]
