Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99B8F2C0285
	for <bpf@vger.kernel.org>; Sun, 14 Jun 2026 07:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781422548; cv=pass; b=NCI2h4mXqRUH3DOh0pd0ZrKFBl2agwOyGbPIuWzEQ2Mer/shxbMuJ6+s8FbWRl4hy58O8124vADXHbpe+ZxaRsaAmJiyHUUkxHNxxFoXRloE/V0BuHj+gLx60G2rRP/PAXA8GFoMClUAPBH1I2EyPZtuF/V21BHTfL4U66vs1aI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781422548; c=relaxed/simple;
	bh=jt9vfiaXpX9Ce0DF2iU5CYaSj0yXd2dYdT7MYev5Vs4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lmHogpi+ZBbXi3dzoGVXy1rRp76Y6pQ1YYRCaxBNx/5+ZNIMgcy/WPjGCw+yTje0AXSL4rC3/lk6oi8JHaiOppUWu8stVmEdUVxzve3WPmksZWq40Z4VBkejWK9O9ZOg7rKQ0BM2knjSOKem9PIWAQWdlycPXo7M+Kz0LkVbseE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CZNTexmB; arc=pass smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CZNTexmB"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-490cf3000f0so23402525e9.1
        for <bpf@vger.kernel.org>; Sun, 14 Jun 2026 00:35:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781422546; cv=none;
        d=google.com; s=arc-20240605;
        b=VKv5mRhpJypLgzztZm2FD3Tz8EoqOXKLHgAnAXtj58qVGBuV/LbbwTZ81Yh8hYjRhB
         FqZJR4I3hPt6XC1uN/4Pvxe4e52AFkBw/ufRshCYIaOBW1vQOq530LKriV2XtnRjizi3
         FTQpF2eb93vd90Qa5vdsgnArweS9xA5J8JxffrZeYWPrGrU1QsP9p5vhrv3WODyyu+xg
         SB0XKOHaU0stnroAyMxkcgIPlK9a9h5C61fSY3vGCyOTjFYhNebxdcD3rM9LQtTM77i1
         aMMg7zIug82YzQ58B6iDe/0p3L0mmmaPhHwNBRcbXZ/wH7i2pCP36yBd2JqLUF1MmBor
         Og6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=G+kn/95nppQ4V0BrtS5dxP/rcmqLU2CIc2jCMr5ukIo=;
        fh=/SbLzIrPPZEG4NPkdOUZiNQAo0ubqZYniHq3JiZAgg8=;
        b=AWzEnglKCdYIrhjRLvXHrr94Hakd8S63dSGhDQT6PKvZxv/a0uL4up9kyh4Xs86zWy
         0caiR64q7rVlWgTikeoNG/R0SjZspXNmHJrlCGh0bPyKtL6uCQnzikxHiLz83lgGjYDl
         vkYtu3kuFd5l7i6fYhmq3j7F4E5E+2NrbCV2Qo2jTKcJUzMmvjAmnjSMbbffCkpG8GAm
         XdoeSQI4Zul9XX0uM3A+HNxTFpw4JersU9XNpjUJs7SuhB6Tw7W1eFE+cwDxTyi7aXMU
         6Eu6trYtRBBoYDgL853vzCXQFprHUGRYV7FX4uDzUzUw1VAh0ael2Hb1bYnAX7+w8FYW
         ke9w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781422546; x=1782027346; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G+kn/95nppQ4V0BrtS5dxP/rcmqLU2CIc2jCMr5ukIo=;
        b=CZNTexmB+rYB6icWofn1xIyuUHlKAaWKCnsviw/rZ7rZUDBUxySstVxuwPx4TObStd
         U5iXyRBrfZRDQS9DXZfwiWVhxq5+oj++T2ECvMS15sbl3O6UXWC25bmyk76bEU5/kvT+
         DhEdbR2jQG+0rnSGluM5Mjg4qujgNlw35OdIgQsn+5FOhIgEQkrtbZSLPW1cO6fay6By
         rkvQjqOgANLzOGmxSvr10VZZlMxbkoSw4hTdas7B900WhfIAmMKpfBCztEr4XsAkopAA
         aJAoxtFP/kJPUcPdqjMaQJAjMUWDN1+g2SqR68PMwqTNrqcemRDA8Twc0dRgAVchcpTW
         5mGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781422546; x=1782027346;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=G+kn/95nppQ4V0BrtS5dxP/rcmqLU2CIc2jCMr5ukIo=;
        b=dCEFBsgW99kuVyctHawtmWJrzTHVFOVVC+IYoRMny232TjeV7KrjqbyBT54bupDje0
         ECLNbWexVlqyDy1FVg8Z+72HQRtiTKL5QUWhaSdaUfWRYLx70jW/roiOmT8tFSnAE/p6
         n8UeNRvLXT7BoIA/xpqYEyz+8Pd6rJksKKT9syZDiKJw6kaZ8KEaDN1vP1FEFl2vrTgG
         z/6n9tiuPm1jTarTaIZonyvhVbUnlj08P51l+Rk4JDmH+79ckSgl58t47MDLQWnIqxEh
         qb/bDOG/k7FFiMAQ+9sDc9Kw4fyWSeqFkQEUVSaE56JMj9BEPEdtMzEGWcAH8a75LHq9
         L4dQ==
X-Forwarded-Encrypted: i=1; AFNElJ+rC9e62rKfCk61fQMLXEEg0DXyAbDFNGZtRVmPKMOesJoSeeuSbDsJcCw0+w1wYTadv2M=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywxt595f53Tzhd8MZrMgFRfy3M6e4IY5hxvYKWj5r9GxVmomXpA
	iRhUopXqWupZoZoCImJroFpg2vEZt9u+F85sE9Gj+4eTynJdqTpTiemrYxIBkiexvOhRlbTESEu
	C3W9AOPJjrpUPCvXyTh9IQ9Afs26tvmE=
X-Gm-Gg: Acq92OHGlf/r91a+3cJnqDjXi5ra0v4RLKSJPhokAZqBnsbtbZU+SJtPV30HVmVUFzm
	gVOdyDKoFhlKRfoDjoRVkXyBJS9zqoGobtPmynRGuWmwIzuruLOw++fkgkbFwDeXxrGbxlXGQ+n
	6ao92dBT5+ElwbfWYwDMMV0Dg8KpJlJ+eslS13Y34WlkjfUINiTdeezTZIxWgSQdVp4qYQ8Tw2i
	t+hFwBDZprj3uObqjUqJWBP8KpFohj8wNGLmwMmt744I/Cu19kH9n69/M9PEcHi5GzwXixtNVK0
	/lfK5Dwd
X-Received: by 2002:a05:600c:820c:b0:489:5022:39a4 with SMTP id
 5b1f17b1804b1-490ec4d652amr112488235e9.9.1781422545558; Sun, 14 Jun 2026
 00:35:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260611160749.391279-1-jt26wzz@gmail.com> <DJ6DMGTPWXJN.1YKSBHULQ1PB9@gmail.com>
 <aivZ9jYGw6QRxLQQ@u94a> <DJ78FEGKX5S8.1H2M4C8415L98@gmail.com>
In-Reply-To: <DJ78FEGKX5S8.1H2M4C8415L98@gmail.com>
From: Zhenzhong Wu <jt26wzz@gmail.com>
Date: Sun, 14 Jun 2026 15:35:33 +0800
X-Gm-Features: AVVi8CeMd-vQB5-GRBpTKGXkjEefh5p3w8xHUU3WFVRuMmsTgKn_YIcq_b-BA8s
Message-ID: <CALgi0XmXX_hBkxZRv8TgxJuoH8QHSBMyM4D3Z90FZGHzs0-s7g@mail.gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: add helper retval linked scalar
 pruning selftest
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Shung-Hsi Yu <shung-hsi.yu@suse.com>, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	john.fastabend@gmail.com, andrii@kernel.org, martin.lau@linux.dev, 
	song@kernel.org, yonghong.song@linux.dev, kpsingh@kernel.org, 
	haoluo@google.com, jolsa@kernel.org, menglong8.dong@gmail.com, 
	eddyz87@gmail.com, stable@vger.kernel.org, mykolal@fb.com, tamird@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Let me add one more data point beyond Shung-Hsi's explanation.

I first tried running the current bpf-next verifier_scalar_ids tests on
a 6.6.y kernel as a rough filter. I then realized that the result was
not a clean comparison, because many of those tests validate verifier
log strings through __msg(), and verifier logs are not stable across
kernel versions. So I did not use the pass/fail result as evidence; I
only used it to pick the closest existing tests for source-level review.

The closest candidates I looked at were:

  precision_two_ids
  linked_regs_broken_link_2
  linked_regs_too_many_regs
  two_nil_old_ids_one_cur_id
  linked_regs_and_subreg_def

Some of them are pruning-related and some cover linked-register
precision, but I still do not see one that covers the same
helper-status/r7 conditional-link pruning scenario as this selftest.

So my current understanding is that the selftest adds distinct coverage.
If this still does not address the concern, I am fine with dropping this
selftest patch.

On Sat, Jun 13, 2026 at 1:04=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Fri Jun 12, 2026 at 3:18 AM PDT, Shung-Hsi Yu wrote:
> > On Thu, Jun 11, 2026 at 09:55:55AM -0700, Alexei Starovoitov wrote:
> >> On Thu Jun 11, 2026 at 9:07 AM PDT, Zhenzhong Wu wrote:
> >> > Add a verifier runtime test for a branch pattern where a helper retu=
rn
> >> > value and a related scalar stay live across the same control-flow
> >> > sequence. Rust/Aya-generated eBPF can naturally produce this shape w=
hen
> >> > a match on a helper status keeps data derived before the helper call
> >> > live across the same branches. Such code commonly uses the helper re=
turn
> >> > value in r0, where 0 means success, producing an r0 =3D=3D 0 / r0 !=
=3D 0
> >> > branch shape.
> > [...]
> >> > +SEC("tc")
> >> > +__description("helper retval linked scalar pruning")
> >> > +__success __retval(0)
> >> > +__naked void helper_retval_linked_scalar_pruning(void)
> >> > +{
> >> > +  asm volatile (
> >> > +  "r7 =3D *(u32 *)(r1 + %[__sk_buff_data_end]);"
> >> > +  "r5 =3D *(u32 *)(r1 + %[__sk_buff_data]);"
> >> > +  "r7 -=3D r5;"
> >> > +  "r2 =3D 0;"
> >> > +  "r3 =3D r10;"
> >> > +  "r3 +=3D -8;"
> >> > +  "r4 =3D 1;"
> >> > +  "call %[bpf_skb_load_bytes];"
> >> > +  "r0 +=3D 1;"
> >> > +  "r6 =3D 1;"
> >> > +  /* success path keeps r7 independent; failure path links r7 to r0=
. */
> >> > +  "if r0 =3D=3D 1 goto l0_%=3D;"
> >>
> >> this exercises linked registers with BPF_ADD_CONST logic.
> >> We already have such tests. Why do we need this one?
> >> How is it different?
> >
> > BPF_ADD_CONST wasn't what was meant to be tested.
> >
> > The main logic is r7.id =3D=3D r0.id only happens on "if r0 =3D=3D 1 go=
to l0_%=3D"
> > fall through, and does not have such link otherwise. I only check tests
> > added in commit c0087d59e504 ("selftests/bpf: tests for per-insn
> > sync_linked_regs() precision tracking"), but it doesn't seem like such
> > conditional linking was tested.
> >
> > The other rational is that this seem like a common pattern that is
> > genereated from Rust-based BPF program.
> >
> >> > +  /* success path keeps r7 independent; failure path links r7 to r0=
. */
> >> > +  "if r0 =3D=3D 1 goto l0_%=3D;"
> >> > +  "r7 =3D r0;"
> >          ^^^^^^^ conditional scalar linking
>
> Fine, it's a regular register linking without BPF_ADD_CONST.
> Still the question remains. I believe:
> "We already have such tests. Why do we need this one? How is it different=
?"
>
