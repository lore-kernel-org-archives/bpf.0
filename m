Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7457548A8D7
	for <bpf@vger.kernel.org>; Thu, 23 Jul 2026 18:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784832871; cv=pass; b=F7sx2vo6jFbMolEaNNipARSNTbAg/ocmEhmzTI2eImmqQ+As6u7GxdNXkrFtBW7UzIrsje3fo1frr32Z4SlFot/T3Wgfl82+Mix1m687kF97RDjn7aDG80iZ6YhOwdd1cOU+NM6yXpra1w7Bl1Q79fs3bLMTbySGXMjbW5GoVSU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784832871; c=relaxed/simple;
	bh=A+DwNBWdhdV6Z+SG7OPJ2fvJ4kaoRit2HmpO7nwr+Jk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HTJ0OtQqO6q6h0eVnX0BkOQvE/hBrLtDMT8r/eUKljQybMrK4z32DXYWRyOSqofBivA10MAiz9EWIDnni1/mDg2nRA9IQ+sWoJQtnmDYBo493CzIuaokUoKMyRApj3eLWFeQVpMXtovS6Qzw/sg6PbM85gAMQqTVRa88BvOs490=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ywd9P9AA; arc=pass smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ywd9P9AA"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-80cebd41372so9290457b3.3
        for <bpf@vger.kernel.org>; Thu, 23 Jul 2026 11:54:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784832859; cv=none;
        d=google.com; s=arc-20260327;
        b=TmMrhgkTdTMW6MTKDz5ndd9Y3e62lbAs2hPmDXtRXd/wVO9QIpxo2/maR7ANihucZS
         FSMDexV7tcqttn82qvU+6HTEMy7f2A/mJcqDHUt/ZjNINyJ17OciKaD2vCKpinUlJbd/
         CHyLCZvT/VjtA3EBqTStPl5WCqtCbaihVmqRDkslq1AdL93eomAw7YskLC64AEUPe9oM
         bWHQx9a1YYN3Lng1xsbWB0oSJvebc5g9J1mvwdseQHbkIn79J0/3zMUbvaY8TMyQB+fF
         K47bOIba9xexj8qTseYp0B5ZefcFoQpqIpLsXYftYaxIl+cCVmngHrqSIpHaez7HElkN
         RSZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Qa9bU5WWlnrT9J3GllGph8U3lPugnECSdzFcC2slgYw=;
        fh=uA360uvxR9S0K/Y4Lovo7aIaGlBwzVBnnb2BKWupr/4=;
        b=asWqEIZpailWG0GV/E3uWT88LpzkaxakbBq7pRh3fx/Qf1PuG1RokFCcrlgswiOdpu
         VcYeP6rQADlAsbo46It36+mYH/LithYlCLOcIS7hsr1MhxH9YquRFH3EQuxCHoVbBWQz
         zVZnYlHQhyUdER9FOLRHwIba/8unSAolkqeFBBj7Ssfbl1GVo2Y/FlRhYGZjELDnzvAz
         6KqNwdnZmxuGV2b/s9TxNiMbdlHhGmMmh3Oo6PVfRvsz8qXlX+uoVMIIE9fdJm/ernFj
         W3uZ8jJkMBTCvZcYWz10hWuW+miPBgiqw2vfzA4M0HdCGERhF+gLIAgHk8mJ2YEofzqh
         Y3DA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784832859; x=1785437659; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Qa9bU5WWlnrT9J3GllGph8U3lPugnECSdzFcC2slgYw=;
        b=Ywd9P9AAoqQgVt8DWnnBnRi3gzKlfWsMzmXzYTq132mbXStZRfkDa69ayIIEXWudRF
         y86SemdCqi37fKSS6bYBOKhadhnWHN/IdbcekokXKmMJ43ga/jpwWJ35nqfw/iVKRDZa
         0tZcVSgOvseFuGwx59Je5HNQe05RIYChqc9MKUQNAjOxIxi+HezYpPzr56Fqcie0NaGQ
         5RSErGSd7jQEit1Odo8mGW2ZyCuqRWVMnhej7XilRv7NkghSgk8yGOnEZOnqFXuvsAjA
         6+7sGWwB983HvPbDvW/MGRddJWE2e7keOFbRU5es6hgCWujZlD97eVFrTKU+cZmHq0Fi
         MAyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784832859; x=1785437659;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Qa9bU5WWlnrT9J3GllGph8U3lPugnECSdzFcC2slgYw=;
        b=O6rzTEmmNJp+z646UovzLCNgZXFKWBiWjlEtgJh2gZ0A+xqXbcTmBIJrN8nOVhEKll
         8QaarROdoQAbrrbexjx5WvxW1bhGwUIYgAL8/NcWDqgARPKWG/w9AT2CK7FZQxVS/Esi
         Dx4i1tuvLj/vsKzg14J5xCG3nNRP0WPBx6GRE7PQCZu1DL4TsarXlc2n2XaNLg2N5YcT
         MeEgh+HZ8vEYilCDTo/DCEugsxDyxG6QGrIV+zH9hGJQeK4gvJM3keNjjbCwCjEqgeVb
         Y+Bd436/ImNT+R1N8V8RLapAfEiPNUC9zs392/5k1JbxIOFbNd+UcVHX2LBpYXsVfl9C
         n0vQ==
X-Gm-Message-State: AOJu0YzxxLipL7vrBokXz7Q+MWLxxY5eFV0aYN/h1pFrDHL1+3c4fBG+
	mwIb7EiPUUqHOY2gkQ0QSL9576sVj9y6ztw5CWvUmbuFsQkU8E+f8VMwy+0XdM4KBESjuWTRtpk
	wGqPDzEyEphFxPuzJsQNxL/FkhBPnTx3RXg==
X-Gm-Gg: AR+sD11zdp48JXyFiSuPxvq9nfrzqWj7PfmWJF7Wc4Lx4+cP8mnRchLeNHYZtYYYpCK
	bBvWn3E9XYMyviOHaVSpyGdz0hzsLQRiPiWylWhEQSxucRmsAPv1FVZxnUXLJJPlNDXrojTACex
	dKCQ0+/WfAz7mBrGsEKiMqzk2MSsl4JCumkk5sLvBGj5jSWjMkB7FlRB6bISy17R43i9Pvubv/p
	sznssAxz0izlOb6xhs9otKsmf/DFlpcz/037Vt+A28Fjo4AiMtLFEwDiH4ajA==
X-Received: by 2002:a05:690c:660c:b0:80e:38c5:bc17 with SMTP id
 00721157ae682-81f4c1a0b48mr12335177b3.7.1784832859259; Thu, 23 Jul 2026
 11:54:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260723050806.1158442-1-ameryhung@gmail.com> <20260723050806.1158442-8-ameryhung@gmail.com>
 <20260723055758.5F7201F000E9@smtp.kernel.org>
In-Reply-To: <20260723055758.5F7201F000E9@smtp.kernel.org>
From: Amery Hung <ameryhung@gmail.com>
Date: Thu, 23 Jul 2026 11:54:08 -0700
X-Gm-Features: AUfX_mzZddXGt83Bzab0nPn6L98g__jZNuWaDyAcT6CG2sg_7U-eO5op9mM6aKQ
Message-ID: <CAMB2axMGGHrAojKtdXAoPi6soYyBVf+LVqWFcpDSLQt2mo-gyA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 07/18] bpf: Check fixed-size mem args of
 helpers and kfuncs the same way
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 22, 2026 at 10:57=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
>
> Pre-existing issues:
> - [High] Global subprograms incorrectly accept NULL pointers for non-null=
able ARG_PTR_TO_MEM arguments, leading to kernel NULL pointer dereference.
> --
>
> --- Patch [7]: [PATCH bpf-next v1 07/18] bpf: Check fixed-size mem args o=
f helpers and kfuncs the same way ---
> commit 878ed5f4f87b10a9bf04aa450c46f6f99550d430
> Author: Amery Hung <ameryhung@gmail.com>
>
> bpf: Check fixed-size mem args of helpers and kfuncs the same way
>
> This commit consolidates the fixed-size memory argument checking for help=
ers,
> kfuncs, and global subprograms by routing the helper MEM_FIXED_SIZE case
> through check_mem_reg. It also resolves a bug where passing a NULL to an
> argument marked PTR_MAYBE_NULL | ARG_PTR_TO_FIXED_SIZE_MEM would falsely
> reject the program.
>
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index 6520742d51b58..be5d93c0da813 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -6941,11 +6941,14 @@ static int check_mem_size_reg(struct bpf_verifi=
er_env *env,
> >  }
> >
> >  static int check_mem_reg(struct bpf_verifier_env *env, struct bpf_reg_=
state *reg,
> > -                      argno_t argno, u32 mem_size, struct bpf_call_arg=
_meta *meta)
> > +                      argno_t argno, u32 mem_size, enum bpf_access_typ=
e access_type,
> > +                      struct bpf_call_arg_meta *meta)
> >  {
> > +     /* meta->btf is set only for kfuncs; a NULL meta means a global s=
ubprog. */
> > +     bool helper =3D meta && !meta->btf;
> >       bool may_be_null =3D type_may_be_null(reg->type);
> >       struct bpf_reg_state saved_reg;
> > -     int err;
> > +     int size, err =3D 0;
> >
> >       if (bpf_register_is_null(reg))
> >               return 0;
>
> [Severity: High]
> This isn't a bug introduced by this patch, but does this early return all=
ow a
> NULL pointer to bypass memory access bounds checks and type validations w=
hen
> the register is a constant 0?
>
> [ ... ]
>
> > @@ -9257,7 +9261,7 @@ static int btf_check_func_arg_match(struct bpf_ve=
rifier_env *env, int subprog,
> >                       ret =3D check_func_arg_reg_off(env, reg, argno, A=
RG_DONTCARE);
> >                       if (ret < 0)
> >                               return ret;
> > -                     if (check_mem_reg(env, reg, argno, arg->mem_size,=
 NULL))
> > +                     if (check_mem_reg(env, reg, argno, arg->mem_size,=
 BPF_READ | BPF_WRITE, NULL))
> >                               return -EINVAL;
> >                       if (!(arg->arg_type & PTR_MAYBE_NULL) && (reg->ty=
pe & PTR_MAYBE_NULL)) {
> >                               bpf_log(log, "%s is expected to be non-NU=
LL\n",
>
> [Severity: High]
> This is a pre-existing issue, but if a caller passes a hardcoded NULL
> (SCALAR_VALUE of 0) to a global subprogram expecting a non-nullable
> ARG_PTR_TO_MEM, check_mem_reg returns 0 immediately.
>
> Because the SCALAR_VALUE type does not have the PTR_MAYBE_NULL flag set,
> this subsequent bitwise check in btf_check_func_arg_match:
>
> !(arg->arg_type & PTR_MAYBE_NULL) && (reg->type & PTR_MAYBE_NULL)
>
> will fail to catch the NULL. Could this allow a global subprogram to
> incorrectly accept and dereference a NULL pointer at runtime, resulting
> in a kernel panic?
>

Confirmed that this is a preexisting issue. I will send the fix as a
separate patch. This is yet another example of why we need to
consolidate call verification.

> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260723050806.11=
58442-1-ameryhung@gmail.com?part=3D7
