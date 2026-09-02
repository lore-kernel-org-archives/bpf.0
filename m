Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89E01248880
	for <bpf@vger.kernel.org>; Wed,  2 Sep 2026 05:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788328688; cv=pass; b=p9GIQ2mQZCfg8TbpnCwve68stvhkDc2gqK3jonpktq0Ml1kO8eaxoIyfXQW+cFiCH25ugLqVwMH/4tc4C/qhF/HhvvyLJ7b7oajqEArGuSTk+PqivbDhEi1NuTcLVSTEwvjn+sLbNpWwFEy/Uopq/6maTMWPxFHM/ruaab3Qr6o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788328688; c=relaxed/simple;
	bh=5XmfEqSRPTgbbO7h7FFAffQCGzKDNIjR2ydswy+DCHM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c11W7NG3PwGaZj4EC1QGb0JCV5XgskKWQkd2FRYg0qyqK3GOhNvPyL6AEfBn1/u1fnqzSivktjTpDOaGeR/Oqle3eEaPc+lLaB9x3tzeUcgvDIaaqt5KsRADgGGm/TsDBU6GXJ2fACogoTtjsb292qyIu9m9QkaDqT5VKqFCgY0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CMVbcf+I; arc=pass smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CMVbcf+I"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-3969e82ff8fso795024a91.0
        for <bpf@vger.kernel.org>; Tue, 01 Sep 2026 22:58:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788328687; cv=none;
        d=google.com; s=arc-20260327;
        b=iVQfLFm8xz4Yf2UT+uYOMidcXzazP8jJvoBESL3E8zYm+Tx6GguJClUqElr79pVTmA
         xztc8vBniLVXT7TWpDweobFO6XLlGXF2O8wKJkUpV1AO9vvsteBINZueB7vw2HBDrqv9
         ZUS2/+8J8x1/4+OmbB+TJ9m1SGm8aqQgju/uqom+FZsizeWIWx5+0xB/4a2ZzMzzTiMr
         CbNebBzHHCu40sbVuq0+oX9p422Z8PBCMZ//41ktJXgkKAj3f/zEJwk83zhwY3FfLCzL
         wfy6LapYv8Wm0I5EieIhsgS1Tlk9SRyPEoue1zwWAZL4/JL/xOA478xyjtwp0w5xduDh
         dLoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5XmfEqSRPTgbbO7h7FFAffQCGzKDNIjR2ydswy+DCHM=;
        fh=DT5YRB/6nmlBXxKYKeVpI+4rwe4UwVkGPd6IsvtSrzM=;
        b=oCBtxR9UmkoZG9T/8Wj/GktXohZmcRD0QHjdzKnK6rFrUgbh9k81fka69BUp+wYd+U
         VQaUCNRLgnDBIkWm7Qhp8l6unyq9f0Y9yt+nFx004+0z4zac8JThgSsr79KvLqMmTlY8
         MI9W+R1P9tstXDH9GNkuPbO2Vc6Vxy8Ty2iCm+vZo1kH6gzB4JVC2nI2KjFIzSV/HAq/
         j2mp7ZUyIHWoQFcKK5iS/jOKfyAPtFaiM1x2jEMiwBmsu0N3YcnECYDWrhC9ARWJlRN/
         6rMG7FD6wCAJO3krTSiperUm43b4L7zdy7yltmkcHFbnwLDV9EpmfEH4uqPukRc5LpxQ
         rp/g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788328687; x=1788933487; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5XmfEqSRPTgbbO7h7FFAffQCGzKDNIjR2ydswy+DCHM=;
        b=CMVbcf+IuRlQPF+PzV5w2viUI93ORABnNjTPj1kt2jsjR/D6Kmh2+LwkdBw5k6Jwaw
         mRYB/VUeN57eUcsHWzTEvu99U56PWRqmJ1nk9V4NTvR7grQvL88JjHEF9TVYjrTf//n4
         x3d4sBB25Ycy5bj7IZGBtkuQb1NOIwYTNYfUGH3T690fDhsGdJpd6IPGMqSryU0OsIGE
         o7/fi9i+jk/xZx6A937OvDPvLKsvyDlTuo/dKMKUqeOhsnb/17md2OlhmUWu+Oi6dwRV
         DUjo8MFgEN6M48W/29+c2M2Vwck+1sW6TKy8N+mVAfMp6audbRXrQWFGf4wPgQBbq99m
         S9eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788328687; x=1788933487;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5XmfEqSRPTgbbO7h7FFAffQCGzKDNIjR2ydswy+DCHM=;
        b=BZYj0iNHHegEXWKq9jH3fxfVD6S/5DsOPYTVnS6Rux9rUq4zK6i8rdP7bUyF7momR9
         B14zWLuQ3zcw8gJ7HHSiZpN64TNwiHRiQ3gcZ/p7/FV3XG6gb459Jh2eBp2hWwh1gPlZ
         7ZQBU54jytdz69B09PF+3yf5YK4Md0azCVr2A8sRcbxTsbmXdxVNDbOLoWPoMNAOTu6H
         dFiC8KV2SwZCbGQkNPNmeK1qI30xbL2hjnGoPcDFZR2ycjkVa67JMxeMSFgpDAl5Nx92
         L5h9V08JRMBHmPWWVWjGOmqc2aIbfIPnUQzgd+9B0iUXSW5kJPNf2MN0aNLoGfW1Nwpv
         PNGw==
X-Forwarded-Encrypted: i=1; AKwUvBy6TjxoUWK4c4W7KSILMGsfma3fA3BbZY3hITd7AkyY0FMxC2U8o7hafwzzSH+zxxylxnM=@vger.kernel.org
X-Gm-Message-State: AFuF++nxGxO1VuzJ4HriajEy9xLo7cxIHb8Kp86NvrxF20vp49DH2WR7
	v0U9LK19KrFJ8MTnCPc83AKyyf576QzZ5Dd8cs9/vXfIIgjJ3xW61TeZGH13clTp+h7iIbaL6td
	RMbAMy/DlSna4NHOrYYSyRQf/l3bzato=
X-Gm-Gg: AYBFou0rqd4yO/T3LK46sllyISn5x/cLyLOsV7pr+MK95EfC5IxRFGxikYsz66pv55X
	goVCfpvYyW75GU0ik0F4vu0r1kaLDTH6Wt4BVBpP1CRKkNUvKippzrWt7qljGDkojOgJ06YBjJ3
	rAOjZP3C9dvmTGraUYePcRIC3rc7dzJcCr2z5kgTayK46oIYykS2piYncTnD3CbsBzCaRUrFlAR
	xPFZUsZpddcTCUbZ5OwTi8NQD9u4Cpq6Yio53gh6Xiy6OjemwkmiPx+ltavIXesJvPWuRyweQfv
	0XYs9ta7JVn51l/J93ki0JBX153U5YVHR8yEiLSM9P+Mi21cgDi37w5UxFzL7n+B1wF8u5LmMqi
	RKXR23DarFi5jB0uTijz2a7wpeBDqGIOJAWElu4c=
X-Received: by 2002:a17:90b:4c0b:b0:398:9bd5:490e with SMTP id
 98e67ed59e1d1-39aee1427e6mr3457741a91.21.1788328686768; Tue, 01 Sep 2026
 22:58:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260819122252.1782790-1-florent.revest@linux.dev>
 <DL27QZ6SEZKT.1CV2HAX4A3WI4@gmail.com> <CAADnVQLxi-R1KDUXJJjpq69SpV8UcNJVqBi7uicO=V0WhAvyQA@mail.gmail.com>
 <DL2S878KSOI5.1SZMLIAWMCNUJ@gmail.com> <DL3FIBQNP6AU.1HO08FMI292UX@linux.dev>
In-Reply-To: <DL3FIBQNP6AU.1HO08FMI292UX@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 1 Sep 2026 22:57:52 -0700
X-Gm-Features: AcwNN1XUPbWnJt4wDy1lHdklrgi9PCmuthwiRhro39sjZasqw3H5dZWNrM7Ep5Y
Message-ID: <CAADnVQLMm43qJxuiHUuuh51wAL4kH0+fRoaM7YfbZEXT7LHn0A@mail.gmail.com>
Subject: Re: [PATCH bpf] bpf: Keep progs alive until the trampoline image
 calling them is freed
To: Florent Revest <florent.revest@linux.dev>
Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	KP Singh <kpsingh@kernel.org>, Emil Tsalapatis <emil@etsalapatis.com>, 
	John Fastabend <john.fastabend@gmail.com>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Jose Fernandez <jose.fernandez@linux.dev>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 31, 2026 at 1:58=E2=80=AFPM Florent Revest <florent.revest@linu=
x.dev> wrote:
>
> On Mon Aug 31, 2026 at 2:43 AM UTC, Kumar Kartikeya Dwivedi wrote:
> > On Sun Aug 30, 2026 at 3:21 PM CEST, Alexei Starovoitov wrote:
> > > On Sun, Aug 30, 2026 at 3:41=E2=80=AFAM Kumar Kartikeya Dwivedi
> > > <memxor@gmail.com> wrote:
> > >>
> > >> Overall, looks good to me. Thanks for the fix!
> > >>
> > >> Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> > >>
> > >> Note for whoever applies this: please add Reported-by: tag for Secha=
ng as well.
> > >> Optionally, wordsmith the commit log with the suggestion above.
> > >
> > > Hold on. I don't think we can proceed with this fix.
> > > It defeats the point of fexit jmp patching and keeps progs
> > > pinned until a sleepable kernel function that were attached to
> > > will return. Which means that the tracing prog attached to "unlucky" =
kernel
> > > function that sleeps for an hour will stay pinned for an hour.
> > > Let's think of a different way of fixing the race.
> >
> > I don't have background on the original commit being fixed, but is that=
 really
> > realistic? Or worrisome even if it happens in practice, since worst cas=
e the
> > program refcounts remains raised for that duration?
> >
> > We have similar worst case for programs too (e.g. using bpf_copy_from_u=
ser on
> > user controlled buffer in, say, LSM progs). At least here we won't be e=
xtending
> > any RCU flavored GP.
> >
> > That said I will think about alternative fixes in the meantime, if we a=
ccept the
> > premise that we don't want to pin program references in the image and k=
eep their
> > lifetimes decoupled.
>
> How about having old trampolines skip freed programs instead of keeping
> them alive ?

Isn't it doing it now?
That was the whole point of patching nop to jmp in a trampoline.
