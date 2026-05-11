Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14DBF406269
	for <bpf@vger.kernel.org>; Mon, 11 May 2026 16:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778518754; cv=pass; b=KJxPhSAgG7HmglHZ8LfI33lkXJPzZ8m09SpGLJYdR9VhHLIMMyh0HmRA2DcsrZL0XMWPwC4f3MtYLYolnC6uT+iBrVBePqdobdCxRmmJPbCBLYfJncKcOnqA2BOrmL9i1mgJLsHmqslNmJjQ2xjmFHeaH9i1IRMZQ+n5sHvk5VE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778518754; c=relaxed/simple;
	bh=Ha0rRvKWgkAo6Nig7EHFpVxlc12HQ2cMdD7ndqS7YVs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZQLWqawpkz4ytjz5d824kw/IDUCa3cxU2r6eA0kg+mdc87OSPdgescavuNJ5q2EHOsHq2Cclc8zVjsxb+0+7cfjoYzu3DwYP90hXY+6SLewpGaLTgV6EPN3ujALH2rCtme01GdFJUSTIAc23yLSLhhK1oU91LOrzPn4i/FcisAk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kIu+WjnK; arc=pass smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kIu+WjnK"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2ba928852a5so30133115ad.1
        for <bpf@vger.kernel.org>; Mon, 11 May 2026 09:59:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778518752; cv=none;
        d=google.com; s=arc-20240605;
        b=BJrmJKhGzG/+tuVr3Bo4PdO6MYcIPWpBOBLwfd6Z/v2DXnkHgA2J4E+ftIC/mlqam9
         DUdnVbxZ4O2m4eW5JA20VHLW0EZBZLUigv35D1cgWsNsgJbU/4Zlb905oNoEcUfxTBVi
         eHyYF0CDTR94bdM9bzNPmEiOytW4AFbycQvYiis8HGJrxUzkn8lEPvgvo65or/k9LJmb
         le1csPPGAq9tU11VhAbfUONm4QBbxDr6Yh4zgeaYAFIz5t/CJ20wc87IKdgKWjxUMRz+
         itmb7qlyHGyNhi7COtiOFNLqBHqNyk9RUY1VgTdvSrnq+7mamzCrM2t66A8hfgGLEVmz
         2ONQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0r6Qq+ozy7faGnRk36eo9W/uT7KOLT+2idzut1OQJ0g=;
        fh=UMGzUfRmy2FF2GsgNUMHPK/geZJL1r/fbnJT8uOw+3g=;
        b=WDMC0X/6Y4y5vOZo7IfbuRIdXOhOOVChSTAU+WlGwAfAZ4BQzPalElVeH8DLAzFTlf
         bmvI0yinY7by3k2MD7DFzdsYIhtA7m9uyRJZDJebS8bGHQ2SFoSBoOpo9jmwoeSRt2PD
         kBC1Mzf1QEF69lrjtp/B7XOy/GqNQjkduWYNJXtp/EeEnopu4wfQVgvKRssLDy/4JD9I
         3tVfHTvM8F6iMRtta57gzLiS8ZmWM44Kr00cyaPUv0I+2kgfZmyUiOmwmsRPotLP5nNq
         kfiok6PcTqHHKcl7FA1TVQa5GaqHUiCtds/XM2gxsaZyT7Xk8Npvacuf9W0JLI7Yo04W
         mbEg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778518752; x=1779123552; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0r6Qq+ozy7faGnRk36eo9W/uT7KOLT+2idzut1OQJ0g=;
        b=kIu+WjnKbHQ6pFMcxnwdScXVeXzx9fXM0Xrn2iRf+xQA39goizF+s7qCA0KjCWrcx5
         ROjg9tiyFa6svfLypzX3sPRvB84zuOznHIPgHXFb42Sa3U3d7XbyaRAuTLilHeiqwJv7
         9mTdZjdfxQpiTkzOkQLUAvj629Z2EaqK9d8q8hGf+Iy38E5jW85rguDdinM3Y/gqvfuc
         to67jw84xKNPfcz70piTx8KXi5eon4pDURwRNUbjhXen/YAv2yyNhUfmeYktstsWEfAL
         KmFif0drB65G3i4B8zh+sDRBahj1YJgFrKV9cUGSTvJ6p6sEk3WPuHjy0ynNLUv6BBaE
         Ohgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778518752; x=1779123552;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0r6Qq+ozy7faGnRk36eo9W/uT7KOLT+2idzut1OQJ0g=;
        b=a5oQS5MdufxDdohdWLnRYbXQYtH51RXDnIHNPOZOjAAi3A7+ewlCPMjYiVGycL2vaF
         8Zo+7Gu8DABweG8E1p4kcrrxe9h2ONi1s44cB2GgVwPvwfeKic4SbQowXkyeXzLUtaLe
         42AoZMykwAqXbKUKJN1OA1QTCIQQm7pl3ibfzKtpKXFQz2MOpP+ndboJHDmpX0rYm5Ms
         ugeDXY0YctNtsoN6yLoVLD/gnAqkgw1tkm0pCIy3AMKgNqXshjBRUkvjzFwzc+fUm2yU
         +k4hda9VfljG9AUOoWsBeZA1Mq4WtU/RtvqrjCFAr69kMXKMx2MKDjDMDw+GrjvaVoij
         5tGA==
X-Forwarded-Encrypted: i=1; AFNElJ/LO6ODuOFbKoK7wldlUFh3/UJisqHJxQ1DPVFpg/hqgHzDYIEdjURTmZEEhKlmnlOWcgM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYPVC47bt+s+I7TfLE50JlUFx7OOYcdSXnQnyWRRIcvI118nA4
	8azF5bq2Larfsc9i1euHoju5iqfN5b1Ew5bh2GVtLyHjAmiVyYbS42Y4NWhEEbBPW4FFndxSfz2
	xGEIdYXYLV8YB23f5gn2Fn0K0HGwYJ1M=
X-Gm-Gg: Acq92OE304d5W1FDZX00yIceYOZuZ6o6Ceo9u6XqSTd2yXxXw9RnzTuEf9h1q2jnB7l
	acZ2CotBzLGKKnoMrpJpYtOga0c894e/Jn5ySyDsL4W0yP/cheVZXq7cHZoZ7bByhCc7xuPNjxz
	I8mrXQ/8REyEnZlPkxAeyki+MDIPt9FluVCvHNeMj93laUa9qmip3Vf1HQGKX36/cuZ2+Ifu5za
	mtj0gEFoFMniCm9dnD7bsQ5ENk//Lssbgio7MnaagG93Evwvhj20oiPLrzHm1+JFqRkfA14rkpV
	W3C3A2nV64DMGVsdfnPUvrMCPT43L+FidahsFsYlwkRO
X-Received: by 2002:a17:902:d60d:b0:2b0:bed1:46f7 with SMTP id
 d9443c01a7336-2bc7ac7e1f1mr110862585ad.37.1778518752260; Mon, 11 May 2026
 09:59:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260509003146.976844-2-andrii@kernel.org> <20260509021238.AE98FC2BCB0@smtp.kernel.org>
In-Reply-To: <20260509021238.AE98FC2BCB0@smtp.kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 11 May 2026 18:58:59 +0200
X-Gm-Features: AVHnY4LI-Ux-85n2hwrEp9RoQJwdvgmdyEYc_4E1KQulnnf0EoIFed0iqKrIYe0
Message-ID: <CAEf4BzZ-nASpoF+-vLYZ1D8eWRVd5JWAuhrwx8XZNrX7ZPY5_Q@mail.gmail.com>
Subject: Re: [PATCH bpf 2/2] selftests/bpf: Add tests for uprobe nop5 red zone clobbering
To: sashiko@lists.linux.dev
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 8, 2026 at 7:12=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [Medium] The `optimized_red_zone` USDT subtest is brittle and may produ=
ce false positive passes because it relies on the compiler arbitrarily plac=
ing operands in the stack's red zone.
> --
>
> commit 1fbbd69b145cd2d80be83d6482e65179431782ac
> Author: Andrii Nakryiko <andrii@kernel.org>
>
> selftests/bpf: Add tests for uprobe nop5 red zone clobbering
>
> This commit adds tests to verify that the uprobe nop5 CALL optimization d=
oes
> not clobber the x86-64 stack red zone. It introduces an assembly-level te=
st
> and a USDT subtest which intends to trigger a probe in a function where t=
he
> compiler places operands in the red zone.
>
> > diff --git a/tools/testing/selftests/bpf/usdt_2.c b/tools/testing/selft=
ests/bpf/usdt_2.c
> > index 789883aaca4c3..fc7e6d220a38b 100644
> > --- a/tools/testing/selftests/bpf/usdt_2.c
> > +++ b/tools/testing/selftests/bpf/usdt_2.c
>
> [ ... ]
>
> > @@ -13,4 +13,17 @@ void usdt_2(void)
> >       USDT(optimized_attach, usdt_2);
> >  }
> >
> > +static volatile unsigned long usdt_red_zone_arg1 =3D 0xDEADBEEF;
> > +static volatile unsigned long usdt_red_zone_arg2 =3D 0xCAFEBABE;
> > +static volatile unsigned long usdt_red_zone_arg3 =3D 0xFEEDFACE;
> > +
> > +void __attribute__((noinline)) usdt_red_zone_trigger(void)
> > +{
> > +     unsigned long a1 =3D usdt_red_zone_arg1;
> > +     unsigned long a2 =3D usdt_red_zone_arg2;
> > +     unsigned long a3 =3D usdt_red_zone_arg3;
> > +
> > +     USDT(optimized_attach, usdt_red_zone, a1, a2, a3);
>
> Is this test reliable across different compiler versions and optimization=
s?
>

No it's not, which is why I added an assembly-based test as well. It
doesn't hurt to have a C-level example which does trigger a red zone
issue in practice to show the issue is not hypothetical. But I can
also drop it, if people think it's unnecessary.

> The x86-64 USDT macro uses the "nor" inline assembly constraint, which al=
lows
> the compiler to allocate these operands to CPU registers. Because there i=
s no
> register pressure in usdt_red_zone_trigger(), modern compilers might allo=
cate
> the local variables a1, a2, and a3 directly to registers rather than the
> stack's red zone.

we compile selftests in -O0 mode, so unlikely, but in release mode it
will definitely be optimized like that

>
> If the operands are placed in registers, the uprobe CALL optimization
> clobbering [rsp-8] will not corrupt them. This could cause the test to pa=
ss
> even on buggy kernels, creating a false positive.
>
> Would it be safer to explicitly force these operands into the red zone
> using inline assembly constraints, rather than depending on the compiler'=
s
> register allocator?
>
> > +}
> > +
> >  #endif
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260509003146.97=
6844-1-andrii@kernel.org?part=3D2
