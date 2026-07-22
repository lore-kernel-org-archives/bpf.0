Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0623B30C174
	for <bpf@vger.kernel.org>; Wed, 22 Jul 2026 13:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784728565; cv=pass; b=GhUvs20hioleDWemLhVdsRuY5DzfvYuEkJFzy0kPo41AIWsTFfbMb+Gpgm9BFuuvSDhU7BIoegYS5Milof7fJrgEID2s1Iun4+YPaAGnC7fG+mU0jCzd+Atmjc6VOfY4ZMJYsM2dYXGONK19f9os+PwdOdKsYznFtVNIu77ZF6c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784728565; c=relaxed/simple;
	bh=5bLP/3FiPzVGV0nYAR3vnGAkmYXdsivYWmY4Mzx/yOs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o+tcvK+knJPusdbMKhMozdUwnfO5gloLlxHS3MQDU7K07HYiC62c5bFw+d9zaVDiZrHeRkkncFRfvFw5XzK0y+5ToQDlP275NqPPmsP0RC5ZYgVcsmXwVOhubGFbZXFznu/Bi+74C7qsyc1XFv1Hb1l5vbSIk8ZOeBXpw/+azzY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KqqJCy8n; arc=pass smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KqqJCy8n"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-c15e2dab83eso1484626466b.1
        for <bpf@vger.kernel.org>; Wed, 22 Jul 2026 06:56:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784728562; cv=none;
        d=google.com; s=arc-20260327;
        b=j9959sWaZdqNSL1Usl62b4wM5EOpTXlLQzDQup+T1HmAENOJzMknfmpfOOoQXkL+6L
         wlBZPCyQYqSs08f3fort/r3Qu+sq//Lz1ELkJBIi0yKzj9BHl50XAU/3YOksIasp8gdL
         F5YFNhwBzYucASJkHf5xyieE7Z52CWZGvlLlTAW0n7xJe8FHW5HHs4+vAal2EKv9gxsm
         02NYcBgmd61QNfCAH1PEYTtIRHlSXvmEGaaA8txm3iZqqRjy3lIK/0mFK2de2DxMFD72
         oXZ/Mt+S/vJzLgMfm+tWNNMVM/pZD9MylYGXEt4qTraW2rK18L3cJMkRnHn4gU1L/Ihd
         bWOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=JQUP8OtybTsrUhTjEXZGCjkU7QBcdeceEAPT5nuav64=;
        fh=iw7+rQzlbDI58pgaP3Ojwlw8x3F/yp+Z3O6odXgNeYk=;
        b=Ht/PEJPW+KNjAwbABlkvK7mUZGmpBQ8xBpsnYuxGYfm56/bqqBJDZmbFQtrmYDF3P6
         poevxee6xIZJwkoR+CwWai3JbQeVUeZlrK3XX3W4ST9iK6U2JoNXdHbd+gHQwrcbjhlu
         9w9F7K8zd1DQ7cA1Ir3SEld2ofGBCmTEaYC+VSwk1CS7QjVGq2aK/VdVc6+U6HppwdMt
         w+uCmZx1dZEpi9M5j/Vsqwxxvu02lf1Cs7tGflBd7L9jbK0xEvhwRbgE/tv8aB4Etscv
         tQ2+tyCMd2fu9HSL9KoDvvmS20BFtunVJ4edV1t/hFdSqYHTK436ZKEWma/Z9Gn+bO+k
         zROA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784728562; x=1785333362; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=JQUP8OtybTsrUhTjEXZGCjkU7QBcdeceEAPT5nuav64=;
        b=KqqJCy8nehTi+FjF0Vjv9hdb/cxTc16+UuzastDU+WGrHmyZg0R/1Im0Lw9eTfj4Tj
         lL2Iler1dksUlhCZm0oTcN9ufxpRtX18A40Cl/A1e5c89vpO4b8Wv9+n4Cnggk3gKqxL
         PNumqX5JiOE08Z+VlK95zp5c86jPtIXu+z/38eRXMRQpyrQkdqUF9yTB8io3kN9fIgcH
         uFXpdhZYdK1iAcFwutL5OFPpFJbZHWwucktwjfVzTWvoxlhmRX19UYQqRcP/ihL7x9xn
         Q48bbujlqawUwJxGfmUbxkDtsY+FToTrFzPLAHa+H5iJWPChH7c7bDuE4m4224eRm8VX
         WSHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784728562; x=1785333362;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JQUP8OtybTsrUhTjEXZGCjkU7QBcdeceEAPT5nuav64=;
        b=fqlWfyWExgTVCx5qPMDnVgihFk+TCJUljqxgTxMaASXSpYftS3kYrWdnTDZVvBoYRg
         l+IbWK9LbYvcOeo5mGMd75ba+k7/EwJrl/iUBHbmsd3bQnS+JRoTZqMXWkZdLtVRuR9i
         ZDIyqNtzkMriWCJaPbiZxVzaYu+FViZKTkKrsIFY/Vr4BFwwxRhlNf839pC1Q4ZK146P
         eEeVzB5Kc/IkgHD1z89L0jdlGnp0YdBy2LivOUQal1oFpjZPQaHa3rphGr/DzF7DJN4/
         6Tuzw1w+N5GhkM8ris1JZC1bktm7GRalAI7vX4H7Bn/X39ttuNcblu1cZ5F3KFDfVR72
         Wkbg==
X-Gm-Message-State: AOJu0Yxj1BFVpXZmp+csS5xzL3dho5aieH2CsWTFNB7EKmlyVmBUFFhw
	u4OzhzsLEvf3H2Wx0iT+FCf3bllOPUd+JwJLGV3HMFb57jUlAw1MGKKHq+E86UGRdUT/N2rWH/R
	Su7A2U4s9Of4PFXm3PlmsUOvY/6ww5KM=
X-Gm-Gg: AR+sD13DIlreSfxqY64xT6GE74ZAi/0QplnlfslR8tK9C40IgkqLgwO6btZJ+1p6VgW
	8Z8QFoKJcWoAJMYFMilM5UWc1E4gfA4927/8+1deYquJK0pkYWDb/lNEmOgaPMmmJ0tixnTn9Sj
	D+kUntWQ6iji5/t1KA9MXPUmkuxCXIxpy2fIlb7x5hur84jbogxkhXbenhJEkCItz2oxd3YTymK
	gAzEsq8D1W5jH3jj2QB44zhMQxchISulVhFEfelFgVovdoQvDGcHpDDX58RpuItZgyVzXV9obgb
	8w==
X-Received: by 2002:a17:907:72cf:b0:c15:c658:dc0d with SMTP id
 a640c23a62f3a-c16b488706bmr1066845366b.39.1784728561898; Wed, 22 Jul 2026
 06:56:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260722130939.3991397-1-puranjay@kernel.org> <DK558EI3JJPH.27AUFGV91DNKV@gmail.com>
In-Reply-To: <DK558EI3JJPH.27AUFGV91DNKV@gmail.com>
From: Puranjay Mohan <puranjay12@gmail.com>
Date: Wed, 22 Jul 2026 14:55:48 +0100
X-Gm-Features: AUfX_mz0AFgXEq10e9EsoOFyENGb9aJ5jTboXb_DmYYSTfZTkwQ08c_hyaZwGbc
Message-ID: <CANk7y0hET12CA27diBiZifH24Bgu4acH-0NUm1==7mYJ3wgC_w@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2] libarena: Use compiler load-acquire/store-release
 in bpf_atomic.h
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Eduard Zingerman <eddyz87@gmail.com>, Emil Tsalapatis <emil@etsalapatis.com>, kkd@meta.com, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 22, 2026 at 2:44=E2=80=AFPM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
> On Wed Jul 22, 2026 at 3:09 PM CEST, Puranjay Mohan wrote:
> > Teach libarena's BPF atomic primitives to use compiler builtins for
> > load-acquire and store-release when Clang advertises
> > __BPF_FEATURE_LOAD_ACQ_STORE_REL. Older compilers continue to use the
> > existing barrier-based fallback.
> >
> > Notably, as BPF programs begin running on arm64, it is better to use th=
e
> > more appropriate variants since we can no longer rely on x86 TSO orderi=
ng.
> >
> > Commit 880442305a39 ("bpf: Introduce load-acquire and store-release ins=
tructions")
> > introduced support, hence kernels from 6.15 onwards are needed when
> > compiling with compilers supporting these instructions. We have
> > relatively recent kernel version requirements in libarena anyway, and
> > have not cut first release, hence declare such a dependency.
> >
> > Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
> > ---
> >
> > Changelog:
> > v1: https://lore.kernel.org/bpf/20260721185705.1365329-1-memxor@gmail.c=
om/
> > Changes in v2:
> > - Use __BPF_FEATURE_LOAD_ACQ_STORE_REL directly for guard.
> > - Use __unqual_typeof
> >
> > ---
> >  .../bpf/libarena/include/bpf_atomic.h         | 20 +++++++++++++++++++
> >  1 file changed, 20 insertions(+)
> >
> > diff --git a/tools/testing/selftests/bpf/libarena/include/bpf_atomic.h =
b/tools/testing/selftests/bpf/libarena/include/bpf_atomic.h
> > index b7b2304319295..4558fa26911f6 100644
> > --- a/tools/testing/selftests/bpf/libarena/include/bpf_atomic.h
> > +++ b/tools/testing/selftests/bpf/libarena/include/bpf_atomic.h
> > @@ -86,6 +86,25 @@ extern bool CONFIG_X86_64 __kconfig __weak;
> >  /* Control dependency provides LOAD->STORE, provide LOAD->LOAD */
> >  #define smp_acquire__after_ctrl_dep() ({ smp_rmb(); })
> >
> > +#if defined(__BPF_FEATURE_LOAD_ACQ_STORE_REL)
> > +/*
> > + * Clang advertises this feature when it can lower acquire/release ato=
mic
> > + * builtins to BPF_LOAD_ACQ/BPF_STORE_REL. Older compilers keep using =
the
> > + * barrier-based fallback below. The generated instructions require ke=
rnel
> > + * verifier/JIT support added in Linux 6.15; compile for an older BPF =
CPU to
> > + * keep using the fallback when targeting older kernels.
> > + */
> > +#define smp_load_acquire(p)                                           =
               \
> > +     ({                                                               =
               \
> > +             __unqual_typeof(*(p)) ___p1 =3D __atomic_load_n((p), __AT=
OMIC_ACQUIRE);   \
> > +             (typeof(*(p)))___p1;                                     =
               \
> > +     })
> > +
> > +#define smp_store_release(p, val)                                     =
               \
> > +     do {                                                             =
               \
> > +             __atomic_store_n((p), (val), __ATOMIC_RELEASE);          =
               \
> > +     } while (0)
>
> Let's use consistent ({  }) for multi-line macros. Also, per your own sug=
gestion
> (and the bot's), wouldn't you want __unqual_typeof() to stash the value f=
or the
> store case as well?

I will do the ({}) change but I don't think __unqual_typeof() is
needed for store case. The load stashes into a temp because it
produces a return value whose type callers observe. My earlier version
that I sent off list was using __atomic_store() which takes a pointer
to the value but this one doesn't.
