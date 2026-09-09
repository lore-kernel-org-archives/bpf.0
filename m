Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E70D399360
	for <bpf@vger.kernel.org>; Wed,  9 Sep 2026 18:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788978202; cv=pass; b=bsapTv0fjH04rCmgc1lWwY+oJuuMGst7/7jk1eENoeJCry8AZN3/HtYe48FoBvgvv1pU1qMyMoYTMe6974CLj5dAowHKLo/3fFINrcFxNbs7JiqGxvwTAvrulrbS2rKX6bY7A5C3Xf69LFD+kV/KvnQdNVRRfbFQREIUPgPNt+I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788978202; c=relaxed/simple;
	bh=zdEvRafZ1wxYj8Zf+FkqNdINv1M+wLRPyAa2OT9MwWE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YBRy6YnhvP80OjKfcWZMqi+5RzhScr2iLI/L4e76/E40++uujVoYfBA35Sq0IbkbD+C/KyvI5POeQ11gFcoDh6to+CY2Y9SUp7FZY7Zd/U3lwo0BvNTaFnEPzXSazPC2zSJIfWzkmb14+Q+4UN/2dPC/nbwqsGT9xeBe4i69IWU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zs7loEBf; arc=pass smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zs7loEBf"
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-4b21f09ec76so4172332b6e.0
        for <bpf@vger.kernel.org>; Wed, 09 Sep 2026 11:23:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788978199; cv=none;
        d=google.com; s=arc-20260327;
        b=XFy0GFBzLf/FN7VR42MsInSiH1e/lgCfebc/Mil+i1GN5oTIyMHUaHqDXSLKbga3QC
         SLQIOVeCqcqPzUce+3uhWPCgPbBR4cSrAX3c3Ca04gczGlBgXtt0zLUgjR5Iq7RdEDcn
         t4DvM27Z9eKcUe0JWHoHcEtqIHkyQH01D0Udc1lVAvLplR3yKWtuSyNUfaW+F3EwEB5G
         CKFJMcTZKYNXtVRv5KgBWNuHCc74qiG5SnmPxQCxPr3PZvS+mmQTpLCrdjogfUyG+t4z
         /993rtwmSfQDLCQfNrboi/w2F/stS6qneIkWyB+yU0D3/By6YN+cYjqBefQ1q9iP1xUk
         qmBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2b6BoinuLG0QGvpAKCoLAUI6NX7c731Lp8Y6NL5Q0og=;
        fh=+iofH7kLhUIpDUAo/a2rUbKulXCH8Go9n65YHAt0kP0=;
        b=CxPOIWryk1ApB5SDJKEOUdYli0xMio7cmvLRnhqB64V+On6Dbqo02jSRbvBS1kyJjF
         +g36bZI7H8YtBondhxjBX0E+YIMk32oKciLPpsehl8ZfrAU6GXtqQYztGDP9R/ta0D4A
         1chiE7gClOrViAbcfxCpGhyv4MJzUHdG0gIN9OSzUWYlS8EZy7QIZWzKIzaHdiUUtR/2
         NwUItyEAS4rhdE8gnomuEzvqUvTkTJAN4st+otMXaLm0ffkpL4p19maQk132yF2yPDqS
         xWTsZGy3K6AtV0by44jTGxVAQCkGb5LwCr+C43YZakpGoZ76gN67qLCYXy8YexPxlm18
         COLA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788978199; x=1789582999; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2b6BoinuLG0QGvpAKCoLAUI6NX7c731Lp8Y6NL5Q0og=;
        b=Zs7loEBf/O6PPDNU5rGQGiB5VkoK8MFFPrZFslE1Yoo6yG+Z8wju7XI6zBbz2W57aD
         0abglvU+JQlNncedn2oQx1nSQAPCkm7O94uRtCRvdq7VmJl5tcDfJSv1XDLu4QueH1uT
         OUkNqxKwLCGdrFSiO6a+7CwxGovn/RMzxmS2YQ5sitQMyGmdPhsGJVZCCNS/42DN88Py
         F8tl4VuVpxTdnulkqw5aSDbkzf3Tnq4qmVVNQtQkob2FiNEAuhTkCSZWuwPNwG9CElu5
         dan5UjDKvwjdYGRvjtVpNyP6tnNIifAEKQjKAH+Dp4cC4ZT+OossRWsx34PGCrIYr82c
         YJew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788978199; x=1789582999;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2b6BoinuLG0QGvpAKCoLAUI6NX7c731Lp8Y6NL5Q0og=;
        b=NGF8Lx+yMUCL5qE0Ywc40QpVRdcidZ4BFxk7LbN0MSBmwE0etzEI8229A/SpTeqKrL
         wTR0Iv0Pd4EjVFxjAGfsc4C+ZVc35CWNGRy/hdfH6SHf//5xI4xEWFVvyZjGS3DucyRv
         PPt2VhnJROU6oCJNJvoRxdP9Reer5oJGYKsXT3DzN0ugTayO0rIWg3iKHwwgS0djxzyc
         60+FimmQafdHRp2eumDWg57MK7EhJQYY0h43idtSBmW1BqDvU4Bd+m082G8ydU3bF1MU
         5z157S9AXApSNTCwkoZQZq4z9f4lNAgy5jdQc5NbSpbnGigJExG2yvmMjyE3gZxI78mo
         mM8w==
X-Gm-Message-State: AFuF++my2vdPBBirM/edVAyRjMLn64Xo1Y2OnZu0PjJcz8z9/zxV2wAI
	VUeZWlcM0OyiMZDMRqNS6qD+Hos5VC0YjdXYUeHQQiVgdFKNzNNppEbVgJJDzjUOAghSu0+Q8NP
	rKy3E1oF8Vk200T0TT3ZgMnkOSA/QFas=
X-Gm-Gg: AYBFou2okcRIFNklxpiAQjekLqWTIj9bBKtrZiDdHDZe+tZB7acROSm22+8ZO89cvXF
	edmG8mUXdpTXT3jxgTic0Bg5LDIeAaALe59UzeVxvhSW0P4yHLi1c2oFzIxRwKivy0Z9v1v4mD7
	vUIJMeAqyDC3AzplTKpNFpD0J07jvNbfiY7g6ZmJh89cPqgpbEVIekgg+pe2td4fzCsMgDmMGIZ
	DxKyhoqur4F8p1LUBrI/IUExmEZMYZT2ikl5g4wxb3JG+AiBHMmieFn/iI+blHePHZccsxlkwRy
	JbgRRVGm7xwMEsl1WcT3ok41/aIJYfqFWPM8oRKKF0+ko1KSASjaW0aNADYyNbzwqrLgMA==
X-Received: by 2002:a05:6820:2017:b0:6b7:83d6:2929 with SMTP id
 006d021491bc7-6b783d62f60mr19271513eaf.44.1788978198808; Wed, 09 Sep 2026
 11:23:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260905220117.922028-8-ameryhung@gmail.com> <40ffa664fac297b60b3387d9e763a2adc31e5ef0692791b718054cd5b5772133@mail.kernel.org>
In-Reply-To: <40ffa664fac297b60b3387d9e763a2adc31e5ef0692791b718054cd5b5772133@mail.kernel.org>
From: Amery Hung <ameryhung@gmail.com>
Date: Wed, 9 Sep 2026 11:23:07 -0700
X-Gm-Features: AcwNN1Xjj9FL7Hx5TJqC96ql5tRj1qnsrZRgGQhM24UpP03utY65pUrrIwedyWo
Message-ID: <CAMB2axOeRX-GcUnL1Am1CKs4-_80Q3JZZy=K+3RRbPLgYOrU2w@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 07/22] bpf: Align helper and kfunc
 ARG_PTR_TO_PROG_AUX handling
To: bot+bpf-ci@kernel.org
Cc: bpf@vger.kernel.org, alexei.starovoitov@gmail.com, andrii@kernel.org, 
	daniel@iogearbox.net, eddyz87@gmail.com, memxor@gmail.com, 
	kernel-team@meta.com, ast@kernel.org, martin.lau@kernel.org, 
	yonghong.song@linux.dev, mason@kernel.org, ihor.solodrai@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 5, 2026 at 4:08=E2=80=AFPM <bot+bpf-ci@kernel.org> wrote:
>
> > diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> > index f620920ea575..547703f54a89 100644
> > --- a/include/linux/bpf.h
> > +++ b/include/linux/bpf.h
> > @@ -922,6 +922,7 @@ enum bpf_arg_type {
> >       ARG_PTR_TO_TASK_WORK,   /* pointer to bpf_task_work */
> >       ARG_PTR_TO_IRQ_FLAG,    /* pointer to saved IRQ flags on the stac=
k */
> >       ARG_PTR_TO_RES_SPIN_LOCK,       /* pointer to bpf_res_spin_lock *=
/
> > +     ARG_PTR_TO_PROG_AUX,    /* pointer to the caller's bpf_prog_aux *=
/
> >       __BPF_ARG_TYPE_MAX,
> >
> >       /* Extended arg_types. */
>
> [ ... ]
>
> > diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> > index 72bfd8f93ae4..1b731aad54da 100644
> > --- a/kernel/bpf/helpers.c
> > +++ b/kernel/bpf/helpers.c
> > @@ -1510,6 +1510,7 @@ static const struct bpf_func_proto bpf_timer_set_=
callback_proto =3D {
> >       .ret_type       =3D RET_INTEGER,
> >       .arg1_type      =3D ARG_PTR_TO_TIMER,
> >       .arg2_type      =3D ARG_PTR_TO_FUNC,
> > +     .arg3_type      =3D ARG_PTR_TO_PROG_AUX,
> >  };
>
> [ ... ]
>
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index a0a74a5e23be..22f5aff76b40 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
>
> [ ... ]
>
> > @@ -9400,9 +9406,42 @@ static bool check_proto_release_reg(const struct=
 bpf_func_proto *fn, struct bpf_
> >       return true;
> >  }
> >
> > -static int check_func_proto(const struct bpf_func_proto *fn, struct bp=
f_call_arg_meta *meta)
> > +static bool check_arg_prog_aux(struct bpf_verifier_env *env,
> > +                            const struct bpf_func_proto *proto)
> >  {
> > -     return check_raw_mode_ok(fn, meta) &&
> > +     bool seen =3D false;
> > +     argno_t argno;
> > +     u32 i;
> > +
> > +     for (i =3D 0; i < ARRAY_SIZE(proto->arg_type); i++) {
> > +             if (proto->arg_type[i] =3D=3D ARG_UNUSED)
> > +                     break;
>
> Does this early break work correctly for kfunc protos?
>
> gen_kfunc_arg_proto() in verifier.c skips __ign and implicit arguments
> without assigning a type, leaving ARG_UNUSED holes in the middle of
> proto->arg_type. For example:
>
>   bpf_arena_alloc_pages(void *p__map, void *addr__ign, u32 page_cnt,
>                         int node_id, u64 flags)
>
> leaves arg_type[1] =3D=3D ARG_UNUSED while arg_type[2], [3], [4] have rea=
l
> types. Similarly:
>
>   bpf_list_push_front_impl(head, node, meta__ign, off)
>
> leaves arg_type[2] =3D=3D ARG_UNUSED while arg_type[3] is a real type.
>
> The loop above terminates at the first hole and never inspects remaining
> arguments. If a kfunc has a prog_aux argument after a hole, or has >5
> arguments with a prog_aux argument in position 6+, these checks are
> unreachable.
>
> The consequence is a net loss of validation. check_kfunc_args()
> previously performed both checks unconditionally, per argument, from
> BTF. Both were deleted from that function (which now does an unguarded
> cur_aux(env)->arg_prog =3D regno) and moved here, where the early break
> makes them unreachable for affected signatures.
>
> The stack-argument check is the more critical one. argno_from_arg(i + 1)
> / reg_from_argno() return -1 for arguments 6 and above, and
> check_kfunc_args() now assigns that value into the 4-bit arg_prog
> bitfield (include/linux/bpf_verifier.h), yielding arg_prog =3D=3D 0xf.
> bpf_fixup_kfunc_call() would then emit BPF_LD_IMM64(15, (long)prog->aux),
> storing to a non-existent register number.
>
> No in-tree kfunc currently combines >5 arguments, a non-implicit
> bpf_prog_aux argument and a preceding hole, so the escalation is latent;
> the validation loss itself is not.
>
> > +             if (proto->arg_type[i] !=3D ARG_PTR_TO_PROG_AUX)
> > +                     continue;
> > +
> > +             if (seen) {
> > +                     verifier_bug(env, "Only 1 prog->aux argument supp=
orted");
> > +                     return false;
> > +             }
> > +
> > +             argno =3D argno_from_arg(i + 1);
> > +             if (reg_from_argno(argno) < 0) {
> > +                     verbose(env, "%s prog->aux cannot be a stack argu=
ment\n",
> > +                             reg_arg_name(env, argno));
> > +                     return false;
> > +             }
> > +
> > +             seen =3D true;
> > +     }
> > +
> > +     return true;
> > +}
> > +
> > +static int check_func_proto(struct bpf_verifier_env *env, const struct=
 bpf_func_proto *fn,
> > +                         struct bpf_call_arg_meta *meta)
> > +{
> > +     return check_arg_prog_aux(env, fn) &&
> > +            check_raw_mode_ok(fn, meta) &&
> >              check_arg_pair_ok(fn) &&
> >              check_mem_arg_rw_flag_ok(fn) &&
> >              check_proto_release_reg(fn, meta) &&
>
> [ ... ]
>
> > @@ -12044,6 +12083,9 @@ get_kfunc_arg_type(struct bpf_verifier_env *env=
, struct bpf_call_arg_meta *meta,
> >       const char *ref_tname =3D NULL;
> >       int arg_type;
> >
> > +     if (is_kfunc_arg_prog_aux(meta->btf, &args[arg]))
> > +             return ARG_PTR_TO_PROG_AUX;
> > +
> >       t =3D btf_type_skip_modifiers(meta->btf, args[arg].type, NULL);
> >
> >       /* Scalar arguments are classified from their BTF suffix/name alo=
ne. */
> > @@ -12192,9 +12234,7 @@ static int gen_kfunc_arg_proto(struct bpf_verif=
ier_env *env, struct bpf_call_arg
> >       }
> >
> >       for (i =3D 0; i < nargs; i++) {
> > -             if (is_kfunc_arg_prog_aux(btf, &args[i]) ||
> > -                 is_kfunc_arg_ignore(btf, &args[i]) ||
> > -                 is_kfunc_arg_implicit(meta, i))
> > +             if (is_kfunc_arg_ignore(btf, &args[i]) || is_kfunc_arg_im=
plicit(meta, i))
> >                       continue;
>
> Does ARG_PTR_TO_PROG_AUX get recorded for KF_IMPLICIT_ARGS kfuncs with
> a bpf_prog_aux argument?
>
> The loop above skips implicit arguments before calling
> get_kfunc_arg_type(), so those arguments never get a type and
> proto->arg_type[i] stays ARG_UNUSED.
>
> resolve_btfids' is_kf_implicit_arg() restricts implicit arguments to
> exactly two types: bpf_prog_aux and btf_struct_meta.
> process_kfunc_with_implicit_args() rewrites the BTF at build time: the
> visible kfunc FUNC gets a truncated func_proto without the implicit
> args, while a <name>_impl FUNC keeps the full one. fetch_kfunc_meta()
> sets meta->func_proto to the _impl proto, so is_kfunc_arg_implicit()
> returns true for the trailing bpf_prog_aux argument in KF_IMPLICIT_ARGS
> kfuncs.
>
> Concrete trace for bpf_wq_set_callback (kernel/bpf/helpers.c, registered
> KF_IMPLICIT_ARGS):
>
>   1. nargs =3D 4 from the _impl proto (wq, callback_fn, flags, aux); the
>      visible proto has vlen 3.
>
>   2. i =3D=3D 3: is_kfunc_arg_implicit(meta, 3) is true -> continue,
>      get_kfunc_arg_type() never runs, proto->arg_type[3] =3D=3D ARG_UNUSE=
D.
>
>   3. check_kfunc_args() i =3D=3D 3: arg_type =3D=3D ARG_UNUSED, so the
>      ARG_PTR_TO_PROG_AUX branch is skipped and the next line
>      (is_kfunc_arg_implicit) continues. cur_aux(env)->arg_prog is never
>      set.
>
>   4. bpf_fixup_kfunc_call() tests env->insn_aux_data[insn_idx].arg_prog,
>      which is 0, so no BPF_LD_IMM64(R4, prog->aux) is emitted.
>
>   5. At run time bpf_wq_set_callback() is entered with whatever the
>      program left in R4 and immediately dereferences it:
>
>        return __bpf_async_set_callback(async, callback_fn, aux->prog);
>
> This affects every KF_IMPLICIT_ARGS kfunc with a bpf_prog_aux argument:
> bpf_wq_set_callback (helpers.c, aux->prog), bpf_task_work_schedule_signal
> (helpers.c), bpf_task_work_schedule_resume (helpers.c), bpf_stream_vprint=
k
> (stream.c, bpf_stream_get(stream_id, aux)), bpf_stream_print_stack (strea=
m.c),
> scx_bpf_cid_override (kernel/sched/ext/cid.c), plus the testmod kfuncs
> bpf_kfunc_implicit_arg and bpf_kfunc_multi_st_ops_test_1_assoc. The
> register is program-controlled, so this is an arbitrary kernel pointer
> dereference reachable from a loadable BPF program.
>
> The immediately following commit in the series, ef7ad41fb8d0, repairs
> exactly this by adding ARG_IGNORE, moving the ignore/implicit test after
> is_kfunc_arg_prog_aux() inside get_kfunc_arg_type(), and deleting the
> pre-classification skip from gen_kfunc_arg_proto(). The ordering fix
> from ef7ad41fb8d0 belongs in this commit to avoid a bisect hole.
>
> >
> >               arg_type =3D get_kfunc_arg_type(env, meta, args, i, nargs=
);
> > @@ -12204,7 +12244,7 @@ static int gen_kfunc_arg_proto(struct bpf_verif=
ier_env *env, struct bpf_call_arg
> >               proto->arg_type[i] =3D arg_type;
> >       }
> >
> > -     return 0;
> > +     return check_arg_prog_aux(env, proto) ? 0 : -EINVAL;
> >  }
>
> [ ... ]
>
> > @@ -12799,18 +12839,7 @@ static int check_kfunc_args(struct bpf_verifie=
r_env *env, struct bpf_call_arg_me
> >               int regno =3D reg_from_argno(argno);
> >               u32 ref_id =3D args[i].type, type_size;
> >
> > -             if (is_kfunc_arg_prog_aux(btf, &args[i])) {
> > -                     /* Reject repeated use bpf_prog_aux */
> > -                     if (meta->arg_prog) {
> > -                             verifier_bug(env, "Only 1 prog->aux argum=
ent supported per-kfunc");
> > -                             return -EFAULT;
> > -                     }
> > -                     if (regno < 0) {
> > -                             verbose(env, "%s prog->aux cannot be a st=
ack argument\n",
> > -                                     reg_arg_name(env, argno));
> > -                             return -EINVAL;
> > -                     }
> > -                     meta->arg_prog =3D true;
> > +             if (arg_type =3D=3D ARG_PTR_TO_PROG_AUX) {
> >                       cur_aux(env)->arg_prog =3D regno;
> >                       continue;
> >               }
>

Neither issue affects the final series state because the next patch
introduces ARG_IGNORE and classifies ignored and implicit arguments.
However, the intermediate state is not bisect-safe. I will switch the
order of the two patches.

>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a =
bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/READM=
E.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/339954=
42755
