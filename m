Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 843C328C869
	for <bpf@vger.kernel.org>; Sat, 30 May 2026 19:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780168878; cv=pass; b=gjsGxaqgH6F0fxieIdPo4aY+EjRNBBI78e0Y45ZU4dXh66TgtE5QRsRGOgw65ABaxSvuEp+ZcYCqKLhmi14kRUTJZTltIerikrbwCM3pHUY3mOnSWYDcKroyK0cDF7YEWtl5sDJ2V6nUBsovLUVP2KGxlyKLwMd60bPUtbOlV7g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780168878; c=relaxed/simple;
	bh=JBbY23VLzr7UTA/IuwMS3GsOoIkG4M0mGFC5/+VyNkY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rtw0BPuL74xnMLn2iB3Jpzgdgd3fiyM8fRmo+Qcga8e8QOYTrpfQ+VxWy33/A7jQIgp2ea7psgEe4yJhaol/fAlQyvHN28oK0/qcU2dYBwfugKVYVCTyIfuJbRcPLxW/4yklo0gfLJMx5VUmr3m5ikCo4KGnpg0hx3iWvDEAKsE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cak1ofO2; arc=pass smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cak1ofO2"
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-7e690c213e3so1555009a34.3
        for <bpf@vger.kernel.org>; Sat, 30 May 2026 12:21:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780168875; cv=none;
        d=google.com; s=arc-20240605;
        b=l1OfrhP7m9qVvLKldKAgwlWHJ+yYmG/a0+SlYR1u2Vw6phTV8wtjczur5a1LIbs5ON
         2bmwz29ehqXzBU85P/CIdrL2rhfIaVyf4AnwodiVG/WphAvWtS6tZkb4ppxInjKnU6ON
         ULZkRIzYUM9m5i2AB+gEBi7GCUhakN7IuXTugtb9Yij7nWZX6U9M8fSqz1GbQkG56cOu
         rntqHKsrNAk5zkenBdJzwWWHl383ZRKAir1uA7sN8chnQ8MvoRAV2iVOQ/ae/NvmSokE
         Uy3P1/cYvcWyyB2piaARbfC54L6eIxzqCc3Qy+enoMIhgLp/QtuphUnLhsbeskD3pibj
         y1lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=OV2fwopur6+ZLoKlvbHioBItO6Jx7w6IvPcKRJq8eAA=;
        fh=RgjKBwmDsALzMUC59VM6pFGtYfN7Jzsr5HjkbK9XzRs=;
        b=C4GW+zcQ+EbgEEaoR8IUxs/jTagy2L/tlaoW43MZ9rRnLvlnsAIJG6JTyFEIvcp9BD
         X1ehA9EjA5Xf85GviboU6c271yeVC4jH9c6Ns9D2jLcUy2SxpUMwIeTa3XZuA8t4FNhw
         oZ4WDgQfiDvIKZHkXQjkIzQUznDdOLyCWWlnV8Youp4Gf9nd6A2w2xmZe0maLOOoB1ew
         ttGV5kJrZUBtoCBjrZhCRfxckcQS6gIaxCow0lPvMIE/P/GDgF+NM546AD9OuLycTU1Y
         xuribr1BZXEhYTmGVhUAjbNSi67LaP21TxIBzXh1HhcvMOsox3uQvABUvRQNrffDdB49
         KC+w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780168875; x=1780773675; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=OV2fwopur6+ZLoKlvbHioBItO6Jx7w6IvPcKRJq8eAA=;
        b=cak1ofO2RfAwkYotkZFdjCgYHfaFxHIJhyN/ipD6+Npw9l0Zsal7lECWl9F4onPUeT
         HtHnIpzyWEbcl8Sjze5INikV0yl9FZZXLPcDsi1qi8o2xgrlM3sIjoSjA24wVqSSzjo5
         mIrr1y0iOrxICp5BksHKW7R707/m4Vyo55Js1C2MZ/DOxaKVEMI76HRNzgnh4ic0flOD
         z58SWRCLbbG3NNGUKrRwgSeQn0vyofb4inI+kmzHqRkZpI67v1d48pk9UgZNZ/Up+C5K
         1Jelck+mrdFCXB8yL49wlHHUYMmNX74SKn5bzqrNXOYAYJ3p8jE18IFfi5N1MWIlQwcY
         GvTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780168875; x=1780773675;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OV2fwopur6+ZLoKlvbHioBItO6Jx7w6IvPcKRJq8eAA=;
        b=EYWxOEcEHesCIuMbhrjyW7eGu+LgR14N2I5Uu/LP1GB3VPOs038ARB/tZkgNnd3mpk
         VzF+IsqLaP+aQVlYHewLsno79sOSh7XxWF+yz2ub81B9igPfgxaEok36xpk1X5Ru6AfJ
         8sBC7TPKWA6dta8zly2M8mGre0IYuGi2jDqwGdVFn1Z20cWxFVz25fbiyEbI5dLBa3z1
         1oDcVvbJll8X8mqjcxMuy4SB4ft59X67x3pxkGTWOSCVuC37aOXrF2VWYaFejZD3JqaQ
         H3KSTryB5HuwSaaj+ZFkb5tNmk9Ie1yFxBeTTT1A6eyFL9d+/aVFN9tekfKlHDS1dh2o
         3a0w==
X-Forwarded-Encrypted: i=1; AFNElJ+4TmyupKp8JrCK9SxAyAQoiYZWQstq13Bj2H4DQkWOPWnMfCBZU7Q9KSEkejW+VIixytA=@vger.kernel.org
X-Gm-Message-State: AOJu0YycvyFZqxCP0pePflgxmfjs0ll3l1AnBGrObOquxGWOwif5IBwO
	IzEfJIxQy7zhUBuuX5MDm1oGcdTDCf2LVOlTqVm4anixiokEkKRixVES4RlSkTNOEbpRxmzK+K2
	iMqYkpVFnVnXzBO9jmBTICIt+LtDth9hdv63v
X-Gm-Gg: Acq92OHwNNQxlY6Zwr4aoYBFKemvbPZpsS3AgmrkY8JnmMGQwEGULeHSWmTDFmRSwgY
	TjqD+Zsm/YptyLdbVIr8t/rIVViJjWXMMUK2Pfz90wdEboP1Agri3Qrqwgh6dX71eG2Oby1aCuY
	/nR7+EH8b2Or2gW9eYmVevKjmI7+pxkuqjbMHF/nMBVjPtchp4v5Hqf665/RgpaGF65+l/Y0Wk5
	JqaZixhdFrFW4fz7JjTO/WVWf8OVrg7zsNWv2YtWGhoyVMM8LWaGDCiR72CjjXsWivhJfK5Uck7
	F/AxUJzceN2bWYOcgNAB
X-Received: by 2002:a05:6830:6681:b0:7de:477c:9799 with SMTP id
 46e09a7af769-7e6a1dc4ad5mr3162146a34.15.1780168875317; Sat, 30 May 2026
 12:21:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260507184238.65280-2-suchitkarunakaran@gmail.com>
 <20260507234959.EEC5BC2BCB8@smtp.kernel.org> <agAqESWvLdIJBErN@google.com>
 <agZgPBrlKZ655KdO@x1> <agq3PCt_FhxIYgQ8@google.com> <ahoqS-hZDkAluO5a@x1>
In-Reply-To: <ahoqS-hZDkAluO5a@x1>
From: Suchit Karunakaran <suchitkarunakaran@gmail.com>
Date: Sun, 31 May 2026 00:51:03 +0530
X-Gm-Features: AVHnY4JLijZIElElgE9i3KRQV2LweikX4CquHZOzoihGyT7FEgWhWkVlbLJrM0k
Message-ID: <CAO9wTFiNVphYwr2sBHXh4-pPLG4jkqUyCRsk6UqrQJG55Fc1qA@mail.gmail.com>
Subject: Re: [PATCH 2/2] perf build: compile BPF skeletons with -mcpu=v3
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>, linux-perf-users@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sat, 30 May 2026 at 05:37, Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
>
> On Sun, May 17, 2026 at 11:52:44PM -0700, Namhyung Kim wrote:
> > On Thu, May 14, 2026 at 08:52:28PM -0300, Arnaldo Carvalho de Melo wrote:
> > > On Sat, May 09, 2026 at 11:47:45PM -0700, Namhyung Kim wrote:
> > > > Hi Arnaldo,
> > > >
> > > > On Thu, May 07, 2026 at 11:49:59PM +0000, sashiko-bot@kernel.org wrote:
> > > > > Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> > > > > - [High] Adding `-mcpu=v3` to `CLANG_OPTIONS` forces all BPF skeletons to use the BPF v3 ISA, breaking backward compatibility for perf tools designed to run on older kernels.
> > > > > --
> > > > >
> > > > > commit 2e8791aeccf694e1ae9ed9fda46e3a6f73332838
> > > > > Author: Suchit Karunakaran <suchitkarunakaran@gmail.com>
> > > > >
> > > > > perf build: compile BPF skeletons with -mcpu=v3
> > > > >
> > > > > This commit adds -mcpu=v3 to CLANG_OPTIONS to support the atomic
> > > > > cmpxchg instruction required by the lock_contention BPF program.
> > > > > This forces Clang to emit BPF ISA v3 instructions during skeleton
> > > > > compilation.
> > > > >
> > > > > > diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
> > > > > > index cee19c923c060..a9a8c84b6b006 100644
> > > > > > --- a/tools/perf/Makefile.perf
> > > > > > +++ b/tools/perf/Makefile.perf
> > > > >
> > > > > [ ... ]
> > > > >
> > > > > > @@ -1195,7 +1195,7 @@ ifneq ($(CROSS_COMPILE),)
> > > > > >  CLANG_TARGET_ARCH = --target=$(notdir $(CROSS_COMPILE:%-=%))
> > > > > >  endif
> > > > > >
> > > > > > -CLANG_OPTIONS = -Wall
> > > > > > +CLANG_OPTIONS = -Wall -mcpu=v3
> > > > >
> > > > > Does this change break backward compatibility for other perf tools running
> > > > > on older kernels?
> > > > >
> > > > > Since CLANG_OPTIONS is used in the pattern rule for compiling all BPF
> > > > > skeletons, this forces every BPF program in perf (such as
> > > > > augmented_raw_syscalls.bpf.c and off_cpu.bpf.c) to target the BPF ISA v3.
> > > > >
> > > > > Kernels older than 5.1 do not support v3 instructions and will reject
> > > > > these programs during the verifier load phase.
> > > >
> > > > I think it's old enough and we can move on to ensure v3 instructions.
> > >
> > > Can I take this as an Reviewed-by or Acked-by?
> >
> > Yep,
> >
> > Reviewed-by: Namhyung Kim <namhyung@kernel.org>
>
> So this got refactored, Suchit, can you take a look at perf-tools-next
> to see what is needed to have this in place after Ian's changes?
>
> Thanks in advance,
>
> - Arnaldo

Hi Arnaldo. Sure, I'll take a look at perf-tools-next and send a
revised version.
