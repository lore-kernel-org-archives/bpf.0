Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com [209.85.221.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 339EA184540
	for <bpf@vger.kernel.org>; Wed, 18 Mar 2026 22:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773871237; cv=pass; b=NlNc+uXH2UXoduC3Rf+Ouoyh15k/RaNPB8PHJbHr06gtchlvordsx5w9g6V6wtYDPUAGN6CSviYRdE4hdraVnLtIpNXHz+2OU5DaheLHED4CJUeLU6yoOxzqdItlMVws57+b5cAyjBUKwf6sZuHCoI/TliVYwAXHIGUqsipIYxA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773871237; c=relaxed/simple;
	bh=+U0MgxCoWBFHjRIt8SGgowH5PVM84Wt/X15Y77kbdT8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gfFFEdLiJb2FgyMpiHiiPYbqghUiDOIWKzii52dt7kXU69ADAbDhsDf4ZUWAmbC5HR4FiRrn4dMWkXmKZp0seu14kF4P5H+WFk9LH1IHDYSa+MKNLUyTh1Z7dVbc4KIN933E7QN/Sdvpswko1IhhlbpvlGPnScRMQHCTN7c475o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E21ezNSe; arc=pass smtp.client-ip=209.85.221.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E21ezNSe"
Received: by mail-wr1-f68.google.com with SMTP id ffacd0b85a97d-439b9cf8cb5so345098f8f.0
        for <bpf@vger.kernel.org>; Wed, 18 Mar 2026 15:00:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773871234; cv=none;
        d=google.com; s=arc-20240605;
        b=NW6VpYWFvITfwhuXUYpTm6YZggmGbsil8zZYvFZoY+M2ffMZOULD+VqAQJ9VCS7amE
         sSnk0goMGZo4t9BsHIRv/QzcAKV6/rh08QjuDQTSQVM1iTIAdOOfMHgrSoPUDnKW7KwU
         Pqi90GmzytiMFqeAaBJwXJ5vdPooYiqFa4WWtgNT1fDODHOIPOIamJ45YIBXlvYXWznw
         Z1eePclDE0fhwR0ndig2rc67CukoK4QT/MNlRIRCDm2oJ3MiylbvUTBVFpkQbq/LQLun
         LExP2UVjzzY7TcJBc2cqqK9EplyYZ31cJtVIbRTCN9MmKLBDs7vj4kwKX55EhYrww6KV
         ZZwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=ns5yKy1QHuN0mYG2c/++gdCis3Cz1Jdi5cCnoMbwlkk=;
        fh=SrtBCg5MYo70qFxdH+TuvYZE7Ydb4sLjlb4LcxAYr50=;
        b=cwBJXtEvKMl/OYpRLLQ8dzIQuinXH7OTKKh1XrKNvYUZgFG1nQ+U8u0dcQOgHnTNiP
         XsjXitWKQsD4UZYGYY3zd1GwHuNx+PPnXx4tSwgRLEK5Zreq5Ob3+ssC1qwUD4CPFToN
         QsR4m4miCh+71bhw3h9hEGwRhaQhAAFkp2vN9YoZiRyfUXDQr08ChVWbd82QqPcz1spR
         03ChVOjgWCy6Iulol0rdGiLI9dQYbPpo0u/ZcKEW7VZ8F3Qx5zO2FONy9+CoNS/wl64B
         bWgr6O0LAzp6gkcSL3kG9TUZSe5ksCfR546sPMCcfSMXwveFI+bZfB/sa1vmKld0axXw
         FNMw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773871234; x=1774476034; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ns5yKy1QHuN0mYG2c/++gdCis3Cz1Jdi5cCnoMbwlkk=;
        b=E21ezNSeqR510r0yUfT6KRVEKdSwgull/jR8VzUrHaskqRcYIC8R4WLFVRhY5kQaQJ
         x4sbsLSjUsxrPqchH0wpRp6GIkaWbTND2uX8ldSBzsKGWHPAZxdcij3YUnR0r8aGUunx
         nKy17/7hJKfyCou4RoEV1Kc3dA5lHIAMbCMNutRWUkDXuYfz/52bvlVCOs3kwrGcRu/Z
         NHodnuYgjuGOilRHP8JoNd8tWOt5EfloX2z1pynDSbRC6MqTeZW0hTMQknLXeU8C5nZA
         rU7csiRnrRcL9DaPPUMpARhEgQFPmEsYQQJ4e5vGDEhbawIHbUSnZ290b2F4D7gm4PW2
         30ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773871234; x=1774476034;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ns5yKy1QHuN0mYG2c/++gdCis3Cz1Jdi5cCnoMbwlkk=;
        b=mKFExHs0hDoRVx6hvEe9QdXaXYHFDFpFySoDPFYm4fxVlTCDDaeTwt2FbUIbc/1/Hp
         dAbAYA/o/Tja7g8fTYZSTzwOyqLYOYL8ktJjTW+8oHT+XY4bJs9SyDZ0gdUo8HtSPk4p
         iEec8QeHMgoz2q0M40zVP5cg0t9JJ9Fzcece7AcuoxITCdr4awDtklxmkcPzZESXWZpQ
         CsnCBNYeWO1OjASkva2xWiW2b97eGL6+9RhfeZPVEiK2xUKoDkWNBAOUcNKoQ5RxFvbF
         D79iwiH6qxhny++Of5GVirTM+nw70VmpTwfY9is/Aew2H6BkxPsnGqvKVtpVxz5XnJCr
         JZiw==
X-Gm-Message-State: AOJu0YwD6fNIsjpBZABd4cfGe/orFg8POVPPNllon15bPl+qPHqKFE0D
	QvMik6o+QaNOuBBOLjEkfRmAWEmlWyILU8ATcvzMYz7+0OrA2y3Q6YpbCUkCl47PHsuydYRylBx
	WDsDjXkEcDFZ36qhFmDkLcJmlOebj+XM=
X-Gm-Gg: ATEYQzxXDkmcyW5pC8G9ptiS5xad+y1UwhKU2LmONT7p9YSOhsEdsWKrTJ6Rq/SxGMz
	gaNXCpiCcWb/J5+nYLPkNzNOSTyi/UHx8dodzp8RIrKXJRVTOVeXPtvnfpgdTEsZKO6WMFuQ481
	i0Cznih2sJM10ejtsVmxZ1H2NpUQkjGfLuPwszgokYQo5QuTSxHkwIrK648qyculuYgnF9qs9MA
	UaT5M9/ApDflLZZlEhcIhX8eNmYf1MqoQWe3LTSzZpLnrt0xN9I5wnZc0bjYAzB6R1HMoj3fb5L
	mECX7l07k9cKWdUJFDjaBzut5JqE4ZqH/li+rps7Nx5SU0uO+zYQnB2fBT0=
X-Received: by 2002:a05:6000:1847:b0:439:bd70:610f with SMTP id
 ffacd0b85a97d-43b527c86cdmr8990955f8f.44.1773871234320; Wed, 18 Mar 2026
 15:00:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260318103526.2590079-1-memxor@gmail.com> <20260318103526.2590079-2-memxor@gmail.com>
 <87cy11kzam.fsf@gmail.com>
In-Reply-To: <87cy11kzam.fsf@gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Wed, 18 Mar 2026 22:59:58 +0100
X-Gm-Features: AaiRm52FQB7PI215lp4okXIFeTmIy4CbfbehyXesgukJlr7gQ7qBDdxKRW5r_W0
Message-ID: <CAP01T76NYrHKBeJk1h9J++whDEg4-z-WyR1jSd-Yv=k1BuRugQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 1/3] bpf: Support variable offsets for syscall PTR_TO_CTX
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org, Tejun Heo <tj@kernel.org>, 
	Dan Schatzberg <dschatzberg@meta.com>, Emil Tsalapatis <emil@etsalapatis.com>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, kkd@meta.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 18 Mar 2026 at 15:06, Mykyta Yatsenko
<mykyta.yatsenko5@gmail.com> wrote:
>
> Kumar Kartikeya Dwivedi <memxor@gmail.com> writes:
>
> > Allow accessing PTR_TO_CTX with variable offsets in syscall programs.
> > Fixed offsets are already enabled for all program types that do not
> > convert their ctx accesses, since the changes we made in the commit
> > de6c7d99f898 ("bpf: Relax fixed offset check for PTR_TO_CTX"). Note
> > that we also lift the restriction on passing syscall context into
> > helpers, which was not permitted before, and passing modified syscall
> > context into kfuncs.
> >
> > The structure of check_mem_access can be mostly shared and preserved,
> > but we must use check_mem_region_access to correctly verify access with
> > variable offsets.
> >
> > The check made in check_helper_mem_access is hardened to only allow
> > PTR_TO_CTX for syscall programs to be passed in as helper memory. This
> > was the original intention of the existing code anyway, and it makes
> > little sense for other program types' context to be utilized as a memory
> > buffer. In case a convincing example presents itself in the future, this
> > check can be relaxed further.
> >
> > We also no longer use the last-byte access to simulate helper memory
> > access, but instead go through check_mem_region_access. Since this no
> > longer updates our max_ctx_offset, we must do so manually, to keep track
> > of the maximum offset at which the program ctx may be accessed.
> >
> > Take care to ensure that when arg_type is ARG_PTR_TO_CTX, we do not
> > relax any fixed or variable offset constraints around PTR_TO_CTX even in
> > syscall programs, and require them to be passed unmodified. There are
> > several reasons why this is necessary. First, if we pass a modified ctx,
> > then the global subprog's accesses will not update the max_ctx_offset to
> > its true maximum offset, and can lead to out of bounds accesses. Second,
> > tail called program (or extension program replacing global subprog) where
> > their max_ctx_offset exceeds the program they are being called from can
> > also cause issues. For the latter, unmodified PTR_TO_CTX is the first
> > requirement for the fix, the second is ensuring max_ctx_offset >= the
> > program they are being called from, which has to be a separate change
> > not made in this commit.
> >
> > All in all, we can hint using arg_type when we expect ARG_PTR_TO_CTX and
> > make our relaxation around offsets conditional on it.
> >
> > Cc: Tejun Heo <tj@kernel.org>
> > Cc: Dan Schatzberg <dschatzberg@meta.com>
> > Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
> > Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> > ---
> >  kernel/bpf/verifier.c                         | 67 ++++++++++++-------
> >  .../bpf/progs/verifier_global_subprogs.c      |  1 -
> >  2 files changed, 43 insertions(+), 25 deletions(-)
> >
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index 01c18f4268de..14bf64e0c600 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -7843,6 +7843,7 @@ static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, u32 regn
> >                * Program types that don't rewrite ctx accesses can safely
> >                * dereference ctx pointers with fixed offsets.
> >                */
> > +             bool var_off_ok = resolve_prog_type(env->prog) == BPF_PROG_TYPE_SYSCALL;
> >               bool fixed_off_ok = !env->ops->convert_ctx_access;
> >               struct bpf_retval_range range;
> >               struct bpf_insn_access_aux info = {
> > @@ -7857,16 +7858,26 @@ static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, u32 regn
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
> > -             if (fixed_off_ok)
> > -                     off += reg->var_off.value;
> > +             if (var_off_ok) {
> > +                     err = check_mem_region_access(env, regno, off, size, U16_MAX, false);
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
> nit: this code looks a bit complex, I wonder if it makes sense to encode
> the context offset mode into an enum:
> enum bpf_ctx_allowed_off {
>      CTX_OFF_VAR,
>      CTX_OFF_FIXED,
>      CTX_OFF_NONE
> };
>
> we can factor out a helper that returns allowed offset mode:
> ```
> enum bpf_ctx_allowed_off get_context_allowed_offset(env)
> {
>         if (resolve_prog_type(env->prog) == BPF_PROG_TYPE_SYSCALL)
>                 return CTX_OFF_VAR;
>         else if (!env->ops->convert_ctx_access)
>                 return CTX_OFF_FIXED;
>         else
>                 return CTX_OFF_NONE;
> }
> ```
>
> The enum makes the three-way exclusive modes explicit, eliminates the
> implicit priority and more self-documenting.
>
> The enum can also be used below.

Take a look at Eduard's suggestion, and let me know your thoughts.

>
> > +
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
> Why did you remove this block here, it should correspond to fixed
> offset, and is not processed in the resolve_prog_type(env->prog) ==
> BPF_PROG_TYPE_SYSCALL) branch.

Because I don't know if it makes any sense to support passing ctx for
other program types except syscall into helpers.
I noted this in the commit message. I would be ok to change it back,
but I think passing ctx into helpers as memory is questionable for
anything except syscall progs.

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
> If we introduce bpf_ctx_allowed_off enum, this check could be modified
> to if (get_context_allowed_offset() == CTX_OFF_VAR) here and also in
> other place as well, does it capture the logic better?
> I'm not 100% sure if these use cases are worth adding a separate enum,
> though, let me know what you think.
> > +                     int err = check_mem_region_access(env, regno, 0, access_size, U16_MAX,
> > +                                                       zero_size_allowed);
> > +                     if (err)
> > +                             return err;
> > +                     if (env->prog->aux->max_ctx_offset < reg->umax_value + access_size)
> > +                             env->prog->aux->max_ctx_offset = reg->umax_value + access_size;
> > +                     return 0;
> >               }
> > -
> >               fallthrough;
> >       default: /* scalar_value or invalid ptr */
> >               /* Allow zero-byte read from NULL, regardless of pointer type */
> > @@ -9401,6 +9406,7 @@ static const struct bpf_reg_types mem_types = {
> >               PTR_TO_MEM | MEM_RINGBUF,
> >               PTR_TO_BUF,
> >               PTR_TO_BTF_ID | PTR_TRUSTED,
> > +             PTR_TO_CTX,
> >       },
> >  };
> >
> > @@ -9710,6 +9716,17 @@ static int check_func_arg_reg_off(struct bpf_verifier_env *env,
> >                * still need to do checks instead of returning.
> >                */
> >               return __check_ptr_off_reg(env, reg, regno, true);
> > +     case PTR_TO_CTX:
> > +             /*
> > +              * Allow fixed and variable offsets for syscall context, but
> > +              * only when the argument is passed as memory, not ctx,
> > +              * otherwise we may get modified ctx in tail called programs and
> > +              * global subprogs (that may act as extension prog hooks).
> > +              */
> > +             if (arg_type != ARG_PTR_TO_CTX &&
> > +                 resolve_prog_type(env->prog) == BPF_PROG_TYPE_SYSCALL)
> This looks like another instance where we check for prog_type==syscall,
> but actually mean: is variable offset into ctx is allowed.
> > +                     return 0;
> > +             fallthrough;
> >       default:
> >               return __check_ptr_off_reg(env, reg, regno, false);
> >       }
> > @@ -10757,7 +10774,7 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env, int subprog,
> >                        * invalid memory access.
> >                        */
> >               } else if (arg->arg_type == ARG_PTR_TO_CTX) {
> > -                     ret = check_func_arg_reg_off(env, reg, regno, ARG_DONTCARE);
> > +                     ret = check_func_arg_reg_off(env, reg, regno, ARG_PTR_TO_CTX);
> >                       if (ret < 0)
> >                               return ret;
> >                       /* If function expects ctx type in BTF check that caller
> > @@ -13565,7 +13582,6 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
> >                               }
> >                       }
> >                       fallthrough;
> > -             case KF_ARG_PTR_TO_CTX:
> >               case KF_ARG_PTR_TO_DYNPTR:
> >               case KF_ARG_PTR_TO_ITER:
> >               case KF_ARG_PTR_TO_LIST_HEAD:
> > @@ -13583,6 +13599,9 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
> >               case KF_ARG_PTR_TO_IRQ_FLAG:
> >               case KF_ARG_PTR_TO_RES_SPIN_LOCK:
> >                       break;
> > +             case KF_ARG_PTR_TO_CTX:
> > +                     arg_type = ARG_PTR_TO_CTX;
> > +                     break;
> >               default:
> >                       verifier_bug(env, "unknown kfunc arg type %d", kf_arg_type);
> >                       return -EFAULT;
> > diff --git a/tools/testing/selftests/bpf/progs/verifier_global_subprogs.c b/tools/testing/selftests/bpf/progs/verifier_global_subprogs.c
> > index f02012a2fbaa..2250fc31574d 100644
> > --- a/tools/testing/selftests/bpf/progs/verifier_global_subprogs.c
> > +++ b/tools/testing/selftests/bpf/progs/verifier_global_subprogs.c
> > @@ -134,7 +134,6 @@ __noinline __weak int subprog_user_anon_mem(user_struct_t *t)
> >
> >  SEC("?tracepoint")
> >  __failure __log_level(2)
> > -__msg("invalid bpf_context access")
> >  __msg("Caller passes invalid args into func#1 ('subprog_user_anon_mem')")
> >  int anon_user_mem_invalid(void *ctx)
> >  {
> > --
> > 2.52.0
