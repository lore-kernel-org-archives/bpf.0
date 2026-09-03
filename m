Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 886D122A4EE
	for <bpf@vger.kernel.org>; Thu,  3 Sep 2026 00:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788394952; cv=pass; b=WNbg7lhsKjOQ+nrZfpeWW5AE6rColbnQSCldwoDNVjIUf0c6QiDJul3Uno90zY7xUiXqj1Tn22eQwr4ex1/wuqnYPrF0EhdeoBtYi6kkncJ+e744CMxAGeSF5xsQfXoAe3KRpzwEv9MZxgdzUkaDowKWASWB7TTGTyAdj1Q5DEs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788394952; c=relaxed/simple;
	bh=HpXZGHKjm19GrKGeBKOpw8KiMZWEY3w+BaVtBt5+knU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eaOzDGPWwin+4hRRt8Ng330BtzzgIivhGhyl63dWn49SdT16cAZaD+YzdpdKw2vn6G5puzgzqLAqEO2cWKtWQMXGQnlEDY00rxqCWfjslFKY8917KOKElBuGkQodBZT3jeH34hFp+i+tYbIHL6WE5e7jSWxxxIATaUfyWL/yUhk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UgqT9Ja4; arc=pass smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UgqT9Ja4"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-8568e3ed034so1499433b3a.0
        for <bpf@vger.kernel.org>; Wed, 02 Sep 2026 17:22:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788394949; cv=none;
        d=google.com; s=arc-20260327;
        b=DZR234U+8kFROS6PvPF7xBMWi0GBnqVfVgKSE3V5xgtO7o4ATIasmkU+3PNljFpgVd
         mXoVoyT5N3a10FYel9td9p5dWCwh5J5y3MgpslnwjkSrw7u3K5bncYhxdYSgogqR5AYl
         ronBFlta1kA9rHAtey2ivZSmKOenJOcb+BPAqLkrOnxrD8LE1YuauuLrDTccOK0VU+Ke
         KNm/UIgEc7m+S+bIlN7RdmfEvKi0Y9M4VLigodds8ukEpTovZ8aNyzVgsVxwKhgH7VLQ
         jx0sp6brn+lNlVqV23XhJQuezrYHrSXeJCUvQ98wZiukg8jjn0rwmKBTZrh4tOPAfNNI
         d6XA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=KWsvOdETbY/9pvWuO7n+ydArZGGk0CzvZ5+doKudMVs=;
        fh=XU5sS8e7Lpgs14+QTk++21dPha5X/ou03qclF1wWUeA=;
        b=B5VWNfwXyBlzRYka//yUic0nFRXJe7/gixNZrBEth7d2VtoloeS87ofUngb8YAQYgu
         AAvjYA7EX4jVAMmtZBMtZxCcBUvfimo1gcf1v8IjoVeCDXdsTSeihbvHX6Nx78py1PVh
         PB3tVMNoFBW/P6aJpi52qg9oV/ix1UgMaQl6Y1IJYwmL9H1lAdLHIeZs24s2l3a0tA84
         2rLQ1DFHWnhKRhiQpKaXVbCL6m0wO3Pftbpe9Kyf3u5HAAnxRsFDxg521GrblUADHnEE
         JxzjppmFVJvzaqFUnK0jT76hKk2XzABz+ISRpT0ufUEBUBsx4+KYMiyA3w9/T7NBecls
         orWQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788394949; x=1788999749; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=KWsvOdETbY/9pvWuO7n+ydArZGGk0CzvZ5+doKudMVs=;
        b=UgqT9Ja4QslI+H0nJlHEo3L3FrVIzKP97lfiwc5Vg0pwxI9O4TCkmABM1cxsyUTh/o
         bsHQmDLCVZdQ8hb+ZhE2Fixtnl5+IrZoq/014hSzMWuCmOQeOBYZkXJbILvq0ubclxhG
         tcNG0uCx2u6KAkzPpHt4VoQfwrrovB2wzCzfCb/23UMdHd5oA5FuDI5YSxSGtnuuJIOL
         VdfGmmuEzsDpz3KpcsR8HHBl7X4iy5EzSsCt01zBzxbCB4Jn8weZ2LFDF8jwbqIunFJb
         ueN6xmAtGh/OG0PxUj93Fx72/f/fvMSzmcL3AwC+bmeKoFDdzy6og0hwfcLL1vaOYit8
         lBKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788394949; x=1788999749;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KWsvOdETbY/9pvWuO7n+ydArZGGk0CzvZ5+doKudMVs=;
        b=MklsUiVnK/EZv/DxX5ojR3Hn+hAfj1pVViTm73ZNpH1nB8lEl01leUW0Nvbn3bJk0L
         StJcd78bCIrgd1DTc3xJU4euJpHCqjDIftCKT4HWXtwPB0vxR8tA7eIbBWjczbybF1o9
         KmTPbWEsyqLzmf2A4Wr6LH0ILXtX1znvHESQ7opVd8bU81R/ACcE8L6M05mBfKcuekF0
         KnvSiTxqHFWz5eYOyeS1inSKDvazWSokZ7niCPsqUHUISqtB4tkt04ovEAz8HwQSN7M8
         j3Cdcd1EHP3xMIno6M9t0vmMTLJ/rkZvE0cDhpJ8yJhJEe4pnvvju61sJF4d32CE/Sqs
         C+6g==
X-Forwarded-Encrypted: i=1; AKwUvBzCmFQRp0w9a0plJ26hYywfsA4t2gdSjEPwq//tR7pJcpydC3z9BYkAFmaH5QwwTXNc4Ew=@vger.kernel.org
X-Gm-Message-State: AFuF++mFWKGr5iBW2pHe2aerX5Xg50D9UgemJeHP6G1hXWu/D3a2DOuD
	48jTP4lCbH+dBahcy5JcSKNcNqrQrFw24UUXQ5VHSz4X0tBjm0sFE61/6XwfO7glM3GISdaGDrU
	f5PqhyjWJalq0ZVT5LXLEwzAMc90XBVc=
X-Gm-Gg: AYBFou2VxNw9rVWDb5T9xTZbYvNzsQFRyrfWjGO7MK5iPwjBPSfuQg+k7g/Gl+e8kWR
	MVDu9USdv4A5jQWIUqD+d2LK2Z7s3cLeSZTJpUc5dpC51KxkHqsstgQbNxzIJO5PIB9A/cBcztH
	08hWIwSYwP0gKmwd+xYAagkbWhwP//AY+eu3/FBYXsyPChLjtaeYSi3VQQ13SUvT3y7dMqiC3b7
	HO7PBhWYpna+qNquWsBwNO5OnGzlcyKolMevJns2Zq+p8JPAtO1BA71rBEY2CNijzoIIsnVR3U+
	2yPX5Knymm6u7Lm6zL5//RHT6VbCFM5/B4fzYVkcUyGp9TlhzuSxUjKVdSqdw7cSR67w6d3+d4w
	EunGR3+xKFO3BF/3qq/3ogqi4NwjChNDW3aWz
X-Received: by 2002:a05:6a00:997:b0:84e:f90e:492f with SMTP id
 d2e1a72fcca58-85ed25e06efmr11217290b3a.7.1788394948796; Wed, 02 Sep 2026
 17:22:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260901-libbpf-frags-flags-v3-3-4eb6f14968b0@redhat.com> <140ef9fa6dc454d62eaf49b168850890f1617fba462dcc37288747f6fbc7dae8@mail.kernel.org>
In-Reply-To: <140ef9fa6dc454d62eaf49b168850890f1617fba462dcc37288747f6fbc7dae8@mail.kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 2 Sep 2026 17:22:15 -0700
X-Gm-Features: AcwNN1VQ1YMtD0MgL0myLt2ygnmk6dG-xiKZpsmTHuTFu9Rx8blS2RsSJlnGUVk
Message-ID: <CAEf4Bzbvy=igxp9ihNrc9WHs8gXeY4nvfxc+Dt=0Oijmy+gyXA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 3/4] libbpf: Move section-defined program
 flags to prog_flags
To: bot+bpf-ci@kernel.org, Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: toke@redhat.com, qmo@kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com, martin.lau@linux.dev, 
	song@kernel.org, yonghong.song@linux.dev, jolsa@kernel.org, 
	emil@etsalapatis.com, ihor.solodrai@linux.dev, larysa.zaremba@intel.com, 
	davem@davemloft.net, kuba@kernel.org, hawk@kernel.org, 
	john.fastabend@gmail.com, sdf@fomichev.me, lorenzo@kernel.org, 
	bpf@vger.kernel.org, netdev@vger.kernel.org, martin.lau@kernel.org, 
	mason@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 1, 2026 at 2:54=E2=80=AFAM <bot+bpf-ci@kernel.org> wrote:
>
> > diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> > index f09cbfd8e729d..c036e8a91ed88 100644
> > --- a/tools/lib/bpf/libbpf.c
> > +++ b/tools/lib/bpf/libbpf.c
> > @@ -7879,6 +7879,19 @@ static int tracing_multi_mod_fd(struct bpf_progr=
am *prog, int *btf_obj_fd)
> >       return 0;
> >  }
> >
> > +static int libbpf_setup_prog_flags(struct bpf_program *prog, long cook=
ie)
> > +{
> > +     enum sec_def_flags def =3D cookie;
> > +
> > +     if (def & SEC_SLEEPABLE)
> > +             prog->prog_flags |=3D BPF_F_SLEEPABLE;
> > +
> > +     if (def & SEC_XDP_FRAGS)
> > +             prog->prog_flags |=3D BPF_F_XDP_HAS_FRAGS;
> > +
> > +     return 0;
> > +}
> > +
> >  /* this is called as prog->sec_def->prog_prepare_load_fn for libbpf-su=
pported sec_defs */
> >  static int libbpf_prepare_prog_load(struct bpf_program *prog,
> >                                   struct bpf_prog_load_opts *opts, long=
 cookie)
> > @@ -7889,12 +7902,6 @@ static int libbpf_prepare_prog_load(struct bpf_p=
rogram *prog,
> >       if ((def & SEC_EXP_ATTACH_OPT) && !kernel_supports(prog->obj, FEA=
T_EXP_ATTACH_TYPE))
> >               opts->expected_attach_type =3D 0;
> >
> > -     if (def & SEC_SLEEPABLE)
> > -             opts->prog_flags |=3D BPF_F_SLEEPABLE;
> > -
> > -     if (prog->type =3D=3D BPF_PROG_TYPE_XDP && (def & SEC_XDP_FRAGS))
> > -             opts->prog_flags |=3D BPF_F_XDP_HAS_FRAGS;
> > -
>
> Does this change break bpf_program__clone() when the caller passes
> non-zero opts.prog_flags?
>
> Before this patch, libbpf_prepare_prog_load() OR'd in the section flags
> after the caller's override:
>
>     /* in bpf_program__clone() */
>     attr.prog_flags =3D OPTS_GET(opts, prog_flags, 0) ?: prog->prog_flags=
;
>     ...
>     prog->sec_def->prog_prepare_load_fn(prog, &attr, ...);
>
>     /* in libbpf_prepare_prog_load() */
>     if (def & SEC_SLEEPABLE)
>         opts->prog_flags |=3D BPF_F_SLEEPABLE;
>
> So a caller doing:
>
>     LIBBPF_OPTS(bpf_prog_load_opts, opts, .prog_flags =3D BPF_F_TEST_STAT=
E_FREQ);
>     fd =3D bpf_program__clone(prog, &opts);
>
> would get TEST_STATE_FREQ | SLEEPABLE for a program in SEC("fentry.s/..."=
).
>
> After this patch, the flags live only in prog->prog_flags, and the `?:`
> in bpf_program__clone() discards prog->prog_flags entirely when the
> caller passes non-zero opts.prog_flags:
>
>     attr.prog_flags =3D OPTS_GET(opts, prog_flags, 0) ?: prog->prog_flags=
;
>                       ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>                       returns TEST_STATE_FREQ, prog->prog_flags is ignore=
d
>
> So the same caller now gets only TEST_STATE_FREQ without SLEEPABLE. For
> sleepable-only helpers like bpf_copy_from_user, this produces a verifier
> rejection. For BPF_PROG_TYPE_SYSCALL, which requires prog->sleepable,
> it fails at load. For xdp.frags programs, BPF_F_XDP_HAS_FRAGS is lost.
>
> Looking at the pattern immediately below in the same function:
>
>     if (attr.token_fd)
>         attr.prog_flags |=3D BPF_F_TOKEN_FD;
>
> should the section flags be OR'd in unconditionally, or should the

no, I don't think so. In the given example, I think BPF_F_SLEEPABLE
flag should be provided by the caller explicitly.

Mykyta, can you please check if veristat would need some adjustments
due to these changes? Thanks!

> caller-override `?:` be removed for prog_flags? The commit message
> mentions bpf_program__set_flags() and bpf_program__set_type() as
> affected APIs but doesn't mention bpf_program__clone().
>
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a =
bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/READM=
E.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/334899=
85893
