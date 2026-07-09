Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE714212D86
	for <bpf@vger.kernel.org>; Thu,  9 Jul 2026 12:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783601271; cv=pass; b=ks+KMTvNm3BIC3L3c4ZDy3sshJPf7Z9/NNLM/PbNCuoenbQ4HdT3zS78Qqaf1oiNmKqiPOndEF6+ThACpwydvUYorCqDXNf8yDN2bydfRggFrVoDG1SNxRWD7qCitPu7FVJqHLbPf3gzZBYglaa2qpPWyT4pkDxA2LsnxB5WIMU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783601271; c=relaxed/simple;
	bh=ZqAVtC0zui/GEoBvIAUtspL9FoCa5rolrJYDNg/cF4E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Kc8il3iJvyrQY6X4+8yoymIVqTX+Zx0/5c9B/8riVRKykjVl/A8WTb96vubid1PU0W7Nj30bU8wLoP5VlQLL4XG3PjmU/tHeBrHNoMWpHBD3b0/PrkHBeMiayAbwZAoN/lSe0gD9aTBZJQTZxszIIph5GA756vbXjExwMiW9hDQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CNjnwfdS; arc=pass smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CNjnwfdS"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-80bd5b5b3afso18724067b3.3
        for <bpf@vger.kernel.org>; Thu, 09 Jul 2026 05:47:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783601269; cv=none;
        d=google.com; s=arc-20260327;
        b=SPEwD98hGzSyE0gsnGkMedr4GGYfzxw/SA7IXwxqvJI0gvnjNLvVTmq1QqpsowTaFf
         Rt5GfuFagUyIeeLntauH33Gd+eNsBR/mdJhk3MRpy9w6zC0YjxBNRg7IkcmFGvd1X852
         yA4NdGPrXiBykvKQjtZk74VXb6WWLXKwIfc4oGw7xYuFVnqgYMt8A/44T4P5NgnmqJTP
         /laZtsQBiSmmiaSb6UgN+5F2qOY0jtkAR1deK+KA223/s3EksJZgjBJgLORhvOUWF6e/
         shtRP0uR4SQrqKz8k5DbLfQK9B5H/c1M7MZDrDC93ZeuN5F13B6hoPUdCNpVh1CZ3uJE
         73gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=KbtfCdAsNe15E0EjVxF9jMshY329gv5ThshJ+2KYxgY=;
        fh=Gb2jYWfnRE9tiVrycsLqut9UaWgVu/muX8TeT6TC36A=;
        b=OQQ8/bUYVsuRJ6m20er3WhzWliFGBzV5mxd3zxCFjJ/F1hvwWrjD46Eqg2FY8FFsfi
         gxg21ywN3XLztftcybvxY+J9utU3q0kHcxHSrfxK0xhWT1yZQ4Xhv6O18YwkmFGCuEGg
         t9GC/TCWp+3XdcKxOSK2QMgZFJ+oGe+tlci5ymYfdBgDh2fuWxBaj2PUJ/QC+DoLvFJA
         +kNoMxrXMWyuQUy7mYNAvuNY+9fOq5dlPnxIHYg0OhQOjx83uvMmJI3yGBgXdT0FxiCj
         LRCSpmr/BpTwLvIWvr5sdAqeKy5PmdCaKctnMoiKCV37RcpEnHHCkkl5Ad9offmgtH0/
         8k1g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783601269; x=1784206069; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=KbtfCdAsNe15E0EjVxF9jMshY329gv5ThshJ+2KYxgY=;
        b=CNjnwfdSJBbBiraOmNerll9XX8TFKK9MhjYiRBt7VMKWTLbW81P6CPTitYAGlv3nXZ
         7EX6nWvMj0v+6PlVLWDNKo+UqOhB5JfQEgE2IDc8oa6o4juj92rSUN1r2qhQtaV6agEJ
         0hXNtQ7qG0eoM0lsa1cpBB3l6+I8lK+s4znDxDrbiC5CEzPUA9KgAe1xRoRhoesrLrL+
         TrFihOMafu002P/5lu8Q8/9nUlALHTEPq1v4iRJRrLVrU0upL1yWTEXX84W086GksKFU
         gW7Sf8QxdNpQr8hxE6VCgkqIMmbx6flYzA77Z09aSzE53ivGkCeWbNGBzqucweS9JqeG
         fXGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783601269; x=1784206069;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KbtfCdAsNe15E0EjVxF9jMshY329gv5ThshJ+2KYxgY=;
        b=nFuaqdcYaxvn1rZRn/wjhqiPhXU3fydVtHgeIKW2YIs1sWvu7pagqYPbmLmF8X6++7
         BNV/AHeXLMOiwKaL4GajYNTz0/aS+bZ6ssML2q/FShIyg3e0UZXIENBJ37Tc3EuneThP
         XAI9NIvlX0aV4tGT4+Y+8qO46RcKx/Wduw0Ph9WkZZ6fyJdl/41W2Z9gTd50Jc4WYJ/F
         h06abmLzZP7SgNx4nsvvafMeJ1Bt25CiaHMdG7PqLQvJex7oy028FK0VQPEhjkI6wFNq
         AdcUgo57OAZ2leM/46PLJHMUkF+z8z5cPMZk9fIKeJff6CVZ2wkES/FUasTfc+VnOLsT
         FczA==
X-Gm-Message-State: AOJu0YywohfMeNJVLcO5R+do2nHVCY02jR0pEO4MDDUwQgYlvVotHSJz
	Xev362PELfydaQUp0tP/ZIoi+uJbSxOOY2nTb1mAfnKqacu8PQKPdm/UHiFZS62m/yVzlri9OJd
	y2iTDFvuAGsJ6aJ7aNEFaometav7gKPs=
X-Gm-Gg: AfdE7clBLO989bNEDH9rEYvebJzLCprEDdvjCIkTmujW0XCa6B3yvAW7X/w5r7n2tAy
	BeAZjFwjcddkNHD2+5btd6tdbvZkSCo75ChpaqD+unPUngE3v2IU9xJi9SeWX3uD6rRbuSGQEbz
	nErSFqhQGs+p0HokmwEuTSNKy3W3LsdDkRE5GTgNCLr22HQ1qz1u1KkOJKwROxkgHLjE8H8fQOF
	j/gI1UCx2cQmVU/8ZljkkF3ZmT9DNK9bTfHMWCpVI8jmpOOxy3xWRAvz+ENfuTg/6K1Dx+5jz9w
	JlVR8E9d04q1wD220wVfS5t8+MRzMIx0wFDydudk
X-Received: by 2002:a05:690c:e20c:20b0:81e:685a:2f78 with SMTP id
 00721157ae682-81e685a5adcmr26626937b3.43.1783601268652; Thu, 09 Jul 2026
 05:47:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260708090151.151729-1-sun.jian.kdev@gmail.com>
 <20260708090151.151729-2-sun.jian.kdev@gmail.com> <ak5HLLrYK3R_g2y_@u94a>
 <CABFUUZHpPwuTk69hb54WugJwssFuvoqFFPv34dZRbKLLc1PwwQ@mail.gmail.com> <ak8XSRiLKx5WcIQw@u94a>
In-Reply-To: <ak8XSRiLKx5WcIQw@u94a>
From: sun jian <sun.jian.kdev@gmail.com>
Date: Thu, 9 Jul 2026 20:47:37 +0800
X-Gm-Features: AVVi8CeXZdNci7kpIcIeMEoZGh__nXpYan_lq-qhUswwNCZeuYTPyhviupka2-8
Message-ID: <CABFUUZHTCLh1nHa3VGjvgvS=iPk_rOrFyBEMs0fiPZNGz3nMxw@mail.gmail.com>
Subject: Re: [PATCH bpf v4 1/2] bpf: Reject negative const offsets for buffer pointers
To: Shung-Hsi Yu <shung-hsi.yu@suse.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	john.fastabend@gmail.com, andrii@kernel.org, eddyz87@gmail.com, 
	memxor@gmail.com, martin.lau@linux.dev, song@kernel.org, 
	yonghong.song@linux.dev, jolsa@kernel.org, emil@etsalapatis.com, 
	shuah@kernel.org, mmullins@fb.com, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 9, 2026 at 2:47=E2=80=AFPM Shung-Hsi Yu <shung-hsi.yu@suse.com>=
 wrote:
>
> On Wed, Jul 08, 2026 at 10:11:01PM +0800, sun jian wrote:
> [...]
> > > > @@ -5326,14 +5326,18 @@ static int check_max_stack_depth(struct bpf=
_verifier_env *env)
> > > >  static int __check_buffer_access(struct bpf_verifier_env *env,
> > > >                                const char *buf_info,
> > > >                                const struct bpf_reg_state *reg,
> > > > -                              argno_t argno, int off, int size)
> > > > +                              argno_t argno, int off, int size,
> > > > +                              u32 *access_end)
> > > >  {
> > > > +     s64 start, var_off;
> > > > +
> > > >       if (off < 0) {
> > > >               verbose(env,
> > > >                       "%s invalid %s buffer access: off=3D%d, size=
=3D%d\n",
> > > >                       reg_arg_name(env, argno), buf_info, off, size=
);
> > > >               return -EACCES;
> > > >       }
> > > > +
> > > >       if (!tnum_is_const(reg->var_off)) {
> > > >               char tn_buf[48];
> > > >
> > > > @@ -5344,6 +5348,29 @@ static int __check_buffer_access(struct bpf_=
verifier_env *env,
> > > >               return -EACCES;
> > > >       }
> > > >
> > > > +     var_off =3D (s64)reg->var_off.value;
> > > > +     if (var_off >=3D BPF_MAX_VAR_OFF || var_off <=3D -BPF_MAX_VAR=
_OFF) {
> > > > +             verbose(env, "%s %s buffer offset %lld is not allowed=
\n",
> > > > +                     reg_arg_name(env, argno), buf_info, var_off);
> > > > +             return -EACCES;
> > > > +     }
> > > > +
> > > > +     start =3D var_off + off;
> > > > +     if (start < 0) {
> > > > +             verbose(env,
> > > > +                     "%s invalid negative %s buffer offset: off=3D=
%d, var_off=3D%lld\n",
> > > > +                     reg_arg_name(env, argno), buf_info, off, var_=
off);
> > > > +             return -EACCES;
> > > > +     }
> > >
> > > I was thinking of suggest to just do a single unsigned check
> > >
> > >   var_off =3D reg->var_off.value;
> > >   if (var_off >=3D BPF_MAX_VAR_OFF) {
> > >     ...
> > >
> > > But looking at the code before 022ac0750883, what you have is closer
> > > aligned to the previous behavior, let's stick to this.
>
> Actually looking again at 022ac0750883, moving the `off < 0` after
> tnum_is_const() and bringing back the `off +=3D reg->off` removed from
> check_mem_access() is perhaps the more faithful restoration of the
> original behavior.
>
> Though reg->off no longer exists, we have to use reg->var_off.value
> instead. IIUC any register of pointer type should already have its
> var_off bounded to +-BPF_MAX_VAR_OFF by adjust_ptr_min_max_vals() in
> theory, and thus shouldn't overflow `int off`.
>
Thanks for the additional analysis.

I checked the related verifier code paths and the following provenance item=
s:

1. The source and initial state of PTR_TO_TP_BUFFER on the raw_tp writable
path.
2. The shared PTR_TO_TP_BUFFER/PTR_TO_BUF buffer access checker path.
3. The pointer arithmetic path through adjust_ptr_min_max_vals() and the
BPF_MAX_VAR_OFF bounds.
4. The source and range guarantees of the access size.
5. The source and range of the instruction offset passed to buffer access
checks.
6.The accounting path from effective offset calculation to access_end and
max_tp_access/max_access.

Based on these checks, folding the constant var_off back into the access
offset is consistent with the current pointer offset tracking model and is
also closer to the pre-022ac0750883 behavior.

> See the diff below.
>
> [...]
>
> > I agree that the size check is redundant given the current call path. I=
=E2=80=99ll leave
> > v4 as-is for now to avoid another respin unless maintainers prefer drop=
ping it
> > or adding a short comment around the access_end calculation.
>
> Agree and make sense. Let's see what @Eduard thinks.
>
> ---
>
One remaining question is the intended semantics after restoring the
offset-folding behavior.

For example:

    r6 +=3D 16;
    r0 =3D *(u64 *)(r6 - 8);

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index d46f7db20d8f..e116b33ad83e 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -5359,12 +5359,6 @@ static int __check_buffer_access(struct bpf_verifi=
er_env *env,
>                                  const struct bpf_reg_state *reg,
>                                  argno_t argno, int off, int size)
>  {
> -       if (off < 0) {
> -               verbose(env,
> -                       "%s invalid %s buffer access: off=3D%d, size=3D%d=
\n",
> -                       reg_arg_name(env, argno), buf_info, off, size);
> -               return -EACCES;
> -       }

The current v4 approach rejects this because the instruction offset is nega=
tive.

>         if (!tnum_is_const(reg->var_off)) {
>                 char tn_buf[48];
>
> @@ -5375,6 +5369,14 @@ static int __check_buffer_access(struct bpf_verifi=
er_env *env,
>                 return -EACCES;
>         }
>
> +       off +=3D reg->var_off.value;
> +       if (off < 0) {
> +               verbose(env,
> +                       "%s invalid %s buffer access: off=3D%d, size=3D%d=
\n",
> +                       reg_arg_name(env, argno), buf_info, off, size);
> +               return -EACCES;
> +       }
> +
>         return 0;
>  }
>
The folded-offset approach would accept it because the final effective
offset is non-negative.

So this would change the accepted program set if we choose to restore the
previous offset-folding behavior. It would be good to clarify whether the
effective-offset behavior or the current instruction-offset restriction is
the desired convention.

I'll wait for the maintainers' preference.

Thanks,
Sun Jian
