Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com [209.85.221.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF95615FA81
	for <bpf@vger.kernel.org>; Wed, 18 Mar 2026 21:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773871082; cv=pass; b=JuRe87oBKzmAIEHYp62g7a3WGVNd+630z6zlNZpBcdJnZFZIgkE39HiUChMZKPKdL/I+HokOb6usjg44spMesgV2xIhwhVmqhC+49W84NgcoR1I5Jv4P8klOgs1651LYmV2/TetwDG0hRBExwVPRA31py1OfTlh8FTP8Ydx3eIM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773871082; c=relaxed/simple;
	bh=nwipwckUYuPqmtIsYimY4tuX2idT1gp1l4Kl2jRTIDc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JeaX5XnC+618XIZ1+MlwQLfiD29XPrLZSOOc3zOgXuHj5ZXkdKZO0spmyhUbgUjLHMiZpTp9hdlNxa6cm4X2RsnebIoFuZgUPjWBLkIBxorfsSKSAbg/pFgXzIxcal4sKApQlurBcCU/AuV69uookEINk97oH4+8w27zSTFQ7Tk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Erciq4cC; arc=pass smtp.client-ip=209.85.221.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Erciq4cC"
Received: by mail-wr1-f65.google.com with SMTP id ffacd0b85a97d-43b3f91a7abso153106f8f.1
        for <bpf@vger.kernel.org>; Wed, 18 Mar 2026 14:58:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773871079; cv=none;
        d=google.com; s=arc-20240605;
        b=FkF/obDTpz8aPGLDpTOYOJOOKGq/WFdhsfPo7d8MxETA1KcdkiW/SMiHzZ/s6pml13
         zh53YJtCL/KVYMW+qTAacUlu4ywY6qCs6a/uIXfx9mUVKNf0vdTQJFtPRi1WfTqFFZZM
         ySPR2f6IkHedT5lWmJXwmRoM0eZNB2asR4A5QIgYvDp9TGkve/DcNj0B2zsXVgtirPDd
         MAY6B66wmcN+S5WGuToWfOk5vw0iMVbJ/kBY6UxMfkLs9PfjknZp4cSiGwZksyxTsT8w
         3bnseZKj9c3hT46uvOAfKm4DveuCF+BWyKtLqHl3aWzjCtBikjjSujl5H9J5D/smypoJ
         aHRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=JyZImjByqPdNUV4KHe2JbBfjhlm/QQ/qbyjpN3/fC8g=;
        fh=jR1Kjz2ljfdIALWUCPBon5tMpz4rOpUIQbLfM+lGbgo=;
        b=dOye7f7TPQMLnho28M+JonCcAL2nklusmjLTsTC4APATpS8GThqXqUa3T2KbbegqYD
         u9ex0vmvW2Vl3CO8ZAd5tykLFzkoI45IpAleH/eT+LRia9IfRP/mKA7KciNau6Ve5+N/
         MC9x8m1hKJkbZlRDzunXxc1JU7mKApgvMZloLcP6FEE4S6Bm/pntVz6nD3rd9Eo+10LG
         8JuBGatnSy01dr6bizC/hLIzl/pf2vZQi+bmD08i1WEc17up4uAPgqcWdI4mRyEXZ03K
         QP+L7xADgNqK2W79XULu4aA6bbuuN5NfaCLO9aQwOAcUTGJQfm/hYEgI5jsabkoF2MQd
         wmuA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773871079; x=1774475879; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JyZImjByqPdNUV4KHe2JbBfjhlm/QQ/qbyjpN3/fC8g=;
        b=Erciq4cCD2QvC9oeIZRfFwOcGIziJAAXEHUppBWO1MaeBaw0R2I6UuIQ29khGFqZki
         8j4bjtK8PlvQPiFKvx7199RX8jAALvy1t61sI3q5cfawKkf47IO0G6xIQIB7GEkXM7lJ
         tF6XaCd9qNeddRaBgy+zPIaOyG+MyQ3bR6b90YkSVvf4hLjBCbzKckmnJqNDsthDh1q6
         IGEGbnua7oZy8RC9UO5+LhTTktI+0Oh9Xdy3Vs6k2KUeT3u1xBf+f8Ed1cXohzA04g2R
         I+1YSFKWbYuGw3w+vzVTSBu0SLTkpF+5oM+upovJha5tNb413GHN73AIdcgbBhannVhj
         9VDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773871079; x=1774475879;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JyZImjByqPdNUV4KHe2JbBfjhlm/QQ/qbyjpN3/fC8g=;
        b=Sq9PBvqiUi/MEQNSLQXLkMFQz7FmDbEqLi8K5U2POtOYNF9VAIwa9+bASeOWim0c7K
         +5AEyVP63WhtIYc3KcJ9/eJCVj7kc3xjBwSuGP/Rcrz31YKL+xni1UZvdMCbOjCkriuS
         JWgSM+owHHGH9X01VxzvqPQEmMT3WOddZAL79Pz3W9KBwPok1PryFxoQ1vVkoYpxQZRW
         jVY/d8vxBrtCCKuXAsVQasb6NN2SSxk+LCdi6MSKeXcdLBYHGCxfCnGiIqMJVd+W7jbK
         sPGaubEV1GKJjSlzzEWM6V9/aAc+/RXJIknTbBW03vvjeb6KwFP4KImmSQepgF/UXeJz
         udow==
X-Gm-Message-State: AOJu0YyQK4kGO6iWUQQlW64sEsfaQT2IVctUe030MGrzVYjq13PtOBt/
	8c9tXoHW6kuL28px6q4oT3itSmwwXOxYOuwJnjD5PphQLDeCBbonb9B+qhmZn3Ft9kDzlmmw1ym
	Oh8To92NalXGYSujba4aAMpkY1/WSVaE=
X-Gm-Gg: ATEYQzxTESTZ0uHUHpb7QyZz5dOLdl3yRQC685GooWT1QfdzMQlf4SXS+6sYk8F3BdT
	Hq7sn9Omr3WgCZCpQGdVcqmaBJzz/W1TPZy8YbCyMQ6YAt/dxNHnI0umMajRMOEB7SqOJTShPoh
	aQfwz5kJhhfnRO+IoGHWJR6dwP7z1Bj6wwDUsEZSbgKrh7dgVyGm2kA8o+rSMbYe9c+wl30J8xq
	k98af212/S7UYyYT4r3Gm6EfEnWAs15Xp67b1SMfa5QHV+LyG8WIF07qJ69sJhwAI2Ra4vzCdbB
	+NgsV5jyI/Mx96yQPCkzedgBE3erVBRJ9kCCDQEA2xAgPUPuRAp8/4J3Ci2UuKM2aO8XEQ==
X-Received: by 2002:a05:6000:4284:b0:43b:4101:6d09 with SMTP id
 ffacd0b85a97d-43b527a3effmr7514958f8f.11.1773871078850; Wed, 18 Mar 2026
 14:57:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260318103526.2590079-1-memxor@gmail.com> <20260318103526.2590079-2-memxor@gmail.com>
 <e05e441f4b071a33c71f28d6668f2e580952c7da.camel@gmail.com>
In-Reply-To: <e05e441f4b071a33c71f28d6668f2e580952c7da.camel@gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Wed, 18 Mar 2026 22:57:22 +0100
X-Gm-Features: AaiRm52RMA6sd58p_AO3B01Io4K3wMs-gwokbuXk80UScbSoiGaKOxzC3c0MeEQ
Message-ID: <CAP01T74km+A-CU9J4n2S+ZkhD+XmgpekU=2_7jF=TTU-T30+Fw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 1/3] bpf: Support variable offsets for syscall PTR_TO_CTX
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, Tejun Heo <tj@kernel.org>, 
	Dan Schatzberg <dschatzberg@meta.com>, Emil Tsalapatis <emil@etsalapatis.com>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@kernel.org>, kkd@meta.com, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 18 Mar 2026 at 22:13, Eduard Zingerman <eddyz87@gmail.com> wrote:
>
> On Wed, 2026-03-18 at 03:35 -0700, Kumar Kartikeya Dwivedi wrote:
>
> [...]
>
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index 01c18f4268de..14bf64e0c600 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -7843,6 +7843,7 @@ static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, u32
> > regn
> >                * Program types that don't rewrite ctx accesses can safely
> >                * dereference ctx pointers with fixed offsets.
> >                */
> > +             bool var_off_ok = resolve_prog_type(env->prog) == BPF_PROG_TYPE_SYSCALL;
> >               bool fixed_off_ok = !env->ops->convert_ctx_access;
> >               struct bpf_retval_range range;
> >               struct bpf_insn_access_aux info = {
> > @@ -7857,16 +7858,26 @@ static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, u32
> > regn
> >                       return -EACCES;
> >               }
> >
> > -             err = __check_ptr_off_reg(env, reg, regno, fixed_off_ok);
> > -             if (err < 0)
> > -                     return err;
> > -
> >               /*
> >                * Fold the register's constant offset into the insn offset so
> > -              * that is_valid_access() sees the true effective offset.
> > +              * that is_valid_access() sees the true effective offset. If the
> > +              * register's offset is allowed to be variable, then the maximum
> > +              * possible offset is simulated (which is equal to var_off.value
> > +              * when var_off is constant).
> >                */
>
> Nit: I'm not sure this comment adds much value, I'd drop it altogether.
>

Ok.

> > -             if (fixed_off_ok)
> > -                     off += reg->var_off.value;
> > +             if (var_off_ok) {
> > +                     err = check_mem_region_access(env, regno, off, size, U16_MAX, false);
>                                                                              ^^^^^^^^
>                  Nit: Maybe leave a comment here saying that the following check_ctx_access()
>                       ensures proper maximal bound?
>                  Nit: check_mem_region_access() which calls __check_mem_access(), maybe add
>                      `case PTR_TO_CTX` there for error reporting?

Ack.

>
> > +                     if (err)
> > +                             return err;
> > +                     off += reg->umax_value;
> > +             } else {
> > +                     err = __check_ptr_off_reg(env, reg, regno, fixed_off_ok);
> > +                     if (err < 0)
> > +                             return err;
> > +                     if (fixed_off_ok)
> > +                             off += reg->var_off.value;
> > +             }
>
> Let's simplify this as:
>
>                 if (var_off_ok)
>                         err = check_mem_region_access(env, regno, off, size, U16_MAX, false);
>                 else
>                         err = __check_ptr_off_reg(env, reg, regno, fixed_off_ok);
>                 if (err < 0)
>                         return err;
>                 off += reg->umax_value;

Ack.

>
> Tbh, the above looks a bit ad-hoc, one might argue that a better way in
> terms of abstraction would be to adjust bpf_verifier_ops->is_valid_access()
> to accept or reject varying offset access.

I think for all current cases, the callback is supplied to make sure
the fixed offset is well formed.
There isn't really "valid or invalid" access otherwise, esp. for
syscall programs.
We can probably also drop this from syscall_prog_is_valid_access.
> if (off % size != 0)
Unaligned accesses should be fine.

If we moved it inside we'd have to repeat this ptr offset thing for
most of them except syscall.
Second, it does not have access to either env or reg to do the
check_mem_region_access.

>
> >               err = check_ctx_access(env, insn_idx, off, size, t, &info);
> >               if (err)
> >                       verbose_linfo(env, insn_idx, "; ");
> > @@ -8442,22 +8453,16 @@ static int check_helper_mem_access(struct bpf_verifier_env *env, int regno,
> >               return check_ptr_to_btf_access(env, regs, regno, 0,
> >                                              access_size, BPF_READ, -1);
> >       case PTR_TO_CTX:
> > -             /* in case the function doesn't know how to access the context,
> > -              * (because we are in a program of type SYSCALL for example), we
> > -              * can not statically check its size.
> > -              * Dynamically check it now.
> > -              */
> > -             if (!env->ops->convert_ctx_access) {
> > -                     int offset = access_size - 1;
> > -
> > -                     /* Allow zero-byte read from PTR_TO_CTX */
> > -                     if (access_size == 0)
> > -                             return zero_size_allowed ? 0 : -EACCES;
> > -
> > -                     return check_mem_access(env, env->insn_idx, regno, offset, BPF_B,
> > -                                             access_type, -1, false, false);
> > +             /* Only permit reading or writing syscall context using helper calls. */
> > +             if (resolve_prog_type(env->prog) == BPF_PROG_TYPE_SYSCALL) {
>
> Nit: this is a second place where this check is hard-coded.

Any better ideas? This program type is sort of special wrt semantics of ctx.
Unlike all others, ctx here is user supplied, and rw, and carries no
kernel data.

>
> > +                     int err = check_mem_region_access(env, regno, 0, access_size, U16_MAX,
> > +                                                       zero_size_allowed);
> > +                     if (err)
> > +                             return err;
> > +                     if (env->prog->aux->max_ctx_offset < reg->umax_value + access_size)
> > +                             env->prog->aux->max_ctx_offset = reg->umax_value + access_size;
> > +                     return 0;
>
> Why is this change necessary at all? Wouldn't old code handle all
> relevant cases, now that check_mem_access() is updated?

I think we cannot pass the access_size through, check_mem_access is
meant to simulate an instruction access.
Earlier it was doing access on the final byte since pointer
modification was not permitted, so real register offset was always
zero.
All we needed to check was whether access_size - 1 fell within bounds,
more importantly just record the max_ctx_offset since there's no
bounds except U16_MAX.
Now, the register is modified, and we can access lengths wider than
those we get from bpf_size_to_bytes.

>
> >               }
> > -
> >               fallthrough;
> >       default: /* scalar_value or invalid ptr */
> >               /* Allow zero-byte read from NULL, regardless of pointer type */
>
> [...]
>
> > diff --git a/tools/testing/selftests/bpf/progs/verifier_global_subprogs.c
> > b/tools/testing/selftests/bpf/progs/verifier_global_subprogs.c
> > index f02012a2fbaa..2250fc31574d 100644
> > --- a/tools/testing/selftests/bpf/progs/verifier_global_subprogs.c
> > +++ b/tools/testing/selftests/bpf/progs/verifier_global_subprogs.c
> > @@ -134,7 +134,6 @@ __noinline __weak int subprog_user_anon_mem(user_struct_t *t)
> >
> >  SEC("?tracepoint")
> >  __failure __log_level(2)
> > -__msg("invalid bpf_context access")
>
> Nit: should this test case be forked as tracepoint and non-tracepoint versions?

In terms of coverage? I have those in the next patch already.

>
> >  __msg("Caller passes invalid args into func#1 ('subprog_user_anon_mem')")
> >  int anon_user_mem_invalid(void *ctx)
> >  {
