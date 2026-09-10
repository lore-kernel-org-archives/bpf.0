Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28ECB3905E7
	for <bpf@vger.kernel.org>; Thu, 10 Sep 2026 16:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789057113; cv=pass; b=UISeOV+dUkWnsagEjuRK+zOjhv5iaV9fHn//5fzT+wX4dmxm1yZklz0ZsLLlwnpAup6ljWd26mVlE21Pa0Bg9HP3eZwpEuaC/3oH7to7nU4PPMePFB4O6dEzy3Un0vHUUTUU878KXl4QfJYLwCdeLf1VQD+inkeZIinzv3P70Hk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789057113; c=relaxed/simple;
	bh=xPTXmq3IFCSKJnG+AUqMmIcVMPJiq4BgjXiNsbgbQsA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=avTxSAiJEuBBTZg1GPHOjJQwxoQzAkup71n97qeI4vWOxew6lu7pd3wj55wzwkH7tVr8JzCbKPVkkYTsXtnjIxvR/wHLbQI7cagTstVOpv+4hDtWbNxix1nS+nw8TGWjpgvdPDfmg4sBt87SUgFSM7DA/ZGQhQA35YGfvMyVdvY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gbGlYcjH; arc=pass smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gbGlYcjH"
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-6bd209cf210so1729651eaf.3
        for <bpf@vger.kernel.org>; Thu, 10 Sep 2026 09:18:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789057110; cv=none;
        d=google.com; s=arc-20260327;
        b=rg3DjlrLEx+AA9prI0vhwZbjSuADZ6mdiQ06H4d/TQsNHSjIDWEX08fjbqJX2im742
         UxCNQSN/UrtbXmrHMAToFucYSU8ezR8Lhf8//HPkEbkqlajvp4OOC19bZTjfOyqCT3L6
         PxI16fIPbvo93gP9l79aWUAzl0tr0T15mV9ObEYPvIYI2bkwv/T0IDAnjJzypGoOF8CF
         ctaK9yVg7l0XR3wZ2tXx7HAMt4kK5nvPjC43FfbrIQ594NByTPmQUIVpOyE05hwv2LOU
         XTHgO34kVkEX4HEEC4CdfZf/Vhy8rUAMKtka+71PUry1om9I3PGlundpLTNBZTyC8tqR
         6kag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=V2OpOIdzqTNwrLTqFon9KD9npArEV/8lWwM0QVbx9Ts=;
        fh=+iofH7kLhUIpDUAo/a2rUbKulXCH8Go9n65YHAt0kP0=;
        b=g8/10rEuBr5nJmgVKQsa7INZ2dUS1F99HeTVYEgFsy5QLVa4cr7NQIp+CLxF8UKU0x
         DvHLtcZIc3U/z3Qd227DxSpAYUm5i65kjbKWZLolTx7Sb9vfZsy2hWv+MkcpUzIWW8O6
         wssumu+CLY9pi6YtM3l+Zoq95iUpwJyNXE84f71c+7BKWmubBtTufaLHvUCRsfE/NYN2
         /2TgSD2BkaTP+w9/gV6PBnNagddagiv9Fm+yVSsjkLAkHBmqkQdol63jFFyVyXMZl8ML
         QrEqmwZCpZC4bs5CqTCgBh/Iq3Fek1SC21XVvqQBGBSkQF7kivs0e+zEtZrzfANGrMdS
         Rtsg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789057110; x=1789661910; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=V2OpOIdzqTNwrLTqFon9KD9npArEV/8lWwM0QVbx9Ts=;
        b=gbGlYcjH3xEhkO637S9AeBA3cvuGUfCsy12Uut/aq5ChRqw4bUXNAbTiX9P5WLgy5S
         /gUkYln6IzzHYeGEDRwy4be6lUS2Xc0wTxojI6O9VWBk8LKHX16WWdjll9OcpToTUHQI
         c+E365Uh4i+RMW3PjhpawENG69RMjhkO1XkySGv8q6Y3PLH6olMPhc5gK5LKraPRoQXd
         P2QBwZ1TWkfE840EiP6ax/cYF37dSwHuvgMgYiK9pRhVusC/x02VLdlw9XMv+4J1OomQ
         QsyOqakFuRVfIKV4aj6tHSVskZdHpVcP9VE1US0dmLmcpe0tAI3rAVjgp6Wd0TWAEA3o
         0yxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789057110; x=1789661910;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=V2OpOIdzqTNwrLTqFon9KD9npArEV/8lWwM0QVbx9Ts=;
        b=WFkhT66AD6XDQobtx5yHF0FZZ+CFJzmR6rsFfYRoMYQYum9pBw1CEl9IjG6bxF/5Kg
         wH71g7pP2w4dFnbzTkYEQzZ08EmGqQaPRCXKIxHvfg2lNiRYxCot4p2RngTItONxBbFS
         nK00NfA+UToeDR/XKedHeO1c9K3sDAPoA4YE6Kd9CpxUxzNHkX64+UUmLO/YugraruPO
         MjmVi615GyXzDD3f7C7uNLnq1Rttd/T8WE4ni9fuVUmwFl8TZDoxOLqXEY59w6+e8KzP
         47FKus6OLIib6P3HqFKA48d3LSgWNKKPpeyiqizy1PDH0V2snvVN7hDGrCTnchTCebeo
         BJ5g==
X-Gm-Message-State: AFuF++kEPHq9lGG87kfaziRdnphJlbqm1qo85nvxUjqXwd/9BOap9JsF
	QDBzkUPp0vVdPQy092pHBdqFJyKF2p1Tkhv1R8ThwxeshIqaB2ynCa+o7C//HKHfh0OA5/OpuCS
	p1hxrIvu1sSKZVCLp7ATPRYIP59b3yEA=
X-Gm-Gg: AYBFou2AHSXxUuNoqX5jgGcPiilkX/bBr0eXBSNbO01TvhDTFOOhnFWjX7J5MbHmWxc
	M8KwcOQt5LFzJefu6EBvWHWK8YFXLMdLADS1LwJUE+djg275IW4JnIN1l3leSOa8zGAsr/VdLdo
	KCYfFCJuG9jcZDSIhleCVq9KeIJv8WeiEFwvCd13D0kmXuCn1NAk8gvtaoA8ysGBbU2EiuOgWt7
	Mt96Y1yyDTb01TVlZyIN/hGMd84D/s2ZKMimCj6qkR7p/qBApbgG2FbFlWDHz0oNtwZKSbicswi
	trTqa6DjvkUuVa/25ER/noU4lCgy7YR1iFWy/WC892mfQDn7aE+ZfeI=
X-Received: by 2002:a05:6820:80c7:b0:6be:139:c032 with SMTP id
 006d021491bc7-6be0139d6b2mr6200556eaf.18.1789057109581; Thu, 10 Sep 2026
 09:18:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260905220117.922028-19-ameryhung@gmail.com> <58079fda8b9a98ec66a54e8c1cb80e4eaedf82cc5fda7f8cebef10fb1b4e266d@mail.kernel.org>
In-Reply-To: <58079fda8b9a98ec66a54e8c1cb80e4eaedf82cc5fda7f8cebef10fb1b4e266d@mail.kernel.org>
From: Amery Hung <ameryhung@gmail.com>
Date: Thu, 10 Sep 2026 09:18:16 -0700
X-Gm-Features: AcwNN1WK3TI4nm1oL-zZHhB7pahAGQQBYFeBvP1WQOiLVYbQG2tqKxYyMPdoEAo
Message-ID: <CAMB2axMiEOPq4x2pe+T-nVPDiPgOsRtTuyZjF3Z2f13vF0TxzA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 18/22] bpf: Admit kfunc argument registers
 through check_reg_type()
To: bot+bpf-ci@kernel.org
Cc: bpf@vger.kernel.org, alexei.starovoitov@gmail.com, andrii@kernel.org, 
	daniel@iogearbox.net, eddyz87@gmail.com, memxor@gmail.com, 
	kernel-team@meta.com, ast@kernel.org, martin.lau@kernel.org, 
	yonghong.song@linux.dev, mason@kernel.org, ihor.solodrai@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 5, 2026 at 4:23=E2=80=AFPM <bot+bpf-ci@kernel.org> wrote:
>
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index bd3fea62aa02..cad49ea5fdfa 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
>
> [ ... ]
>
> > @@ -8251,7 +8239,7 @@ static const struct bpf_reg_types mem_types =3D {
> >       },
> >  };
> >
> > -static const struct bpf_reg_types spin_lock_types =3D {
> > +static const struct bpf_reg_types map_value_or_alloc_obj_types =3D {
> >       .types =3D {
> >               PTR_TO_MAP_VALUE,
> >               PTR_TO_BTF_ID | MEM_ALLOC,
>
> [ ... ]
>
> > @@ -8280,7 +8268,29 @@ static const struct bpf_reg_types percpu_btf_ptr=
_types =3D {
> >  static const struct bpf_reg_types func_ptr_types =3D { .types =3D { PT=
R_TO_FUNC } };
> >  static const struct bpf_reg_types stack_ptr_types =3D { .types =3D { P=
TR_TO_STACK } };
> >  static const struct bpf_reg_types const_str_ptr_types =3D { .types =3D=
 { PTR_TO_MAP_VALUE } };
> > -static const struct bpf_reg_types timer_types =3D { .types =3D { PTR_T=
O_MAP_VALUE } };
> > +static const struct bpf_reg_types map_value_types =3D { .types =3D { P=
TR_TO_MAP_VALUE } };
> > +static const struct bpf_reg_types arena_types =3D {
> > +     .types =3D {
> > +             PTR_TO_ARENA,
> > +             SCALAR_VALUE,
> > +     }
> > +};
> > +
> > +static const struct bpf_reg_types alloc_obj_types =3D {
> > +     .types =3D {
> > +             PTR_TO_BTF_ID | MEM_ALLOC,
> > +             PTR_TO_BTF_ID | MEM_ALLOC | MEM_PERCPU,
> > +     }
> > +};
> > +
> > +static const struct bpf_reg_types alloc_obj_or_non_own_ref_types =3D {
> > +     .types =3D {
> > +             PTR_TO_BTF_ID | MEM_ALLOC,
> > +             PTR_TO_BTF_ID | MEM_ALLOC | NON_OWN_REF,
> > +             PTR_TO_BTF_ID | MEM_ALLOC | NON_OWN_REF | MEM_RCU,
> > +     }
> > +};
>
> Does alloc_obj_or_non_own_ref_types need a diagnostic improvement?
> reg_type_str() has no textual prefix for MEM_ALLOC or NON_OWN_REF and
> renders PTR_TO_BTF_ID as the bare stem "ptr_". The first two entries both
> render as "ptr_" and the third as "rcu_ptr_", giving users the
> non-actionable list "ptr_, ptr_, rcu_ptr_". The selftest updates confirm
> this is what users see:
>
>   rbtree_fail.c: __msg("R2 type=3Dscalar expected=3Dptr_, ptr_, rcu_ptr_"=
)
>   refcounted_kptr_fail.c: __msg("R1 type=3Dctx expected=3Dptr_, ptr_, rcu=
_ptr_")
>
> These replace specific messages like "R1 is neither owning or non-owning
> ref". The changelog claims "The reason continues to report the actual
> register type and all accepted register types", which is literally true b=
ut
> not useful here: three distinct ownership states collapse to two
> indistinguishable strings, and "ptr_" is a dangling stem. Either
> reg_type_str() needs prefixes for MEM_ALLOC/NON_OWN_REF, or
> ARG_PTR_TO_REFCOUNTED_KPTR / ARG_PTR_TO_LIST_NODE / ARG_PTR_TO_RB_NODE
> should keep an ownership-specific message.
>
> > @@ -8310,16 +8320,32 @@ static const struct bpf_reg_types *compatible_r=
eg_types[__BPF_ARG_TYPE_MAX] =3D {
> >  #endif
> >       [ARG_PTR_TO_SOCKET]             =3D &fullsock_types,
> >       [ARG_PTR_TO_BTF_ID]             =3D &btf_ptr_types,
> > -     [ARG_PTR_TO_SPIN_LOCK]          =3D &spin_lock_types,
> > +     [ARG_PTR_TO_SPIN_LOCK]          =3D &map_value_or_alloc_obj_types=
,
> >       [ARG_PTR_TO_MEM]                =3D &mem_types,
> >       [ARG_PTR_TO_RINGBUF_MEM]        =3D &ringbuf_mem_types,
> >       [ARG_PTR_TO_PERCPU_BTF_ID]      =3D &percpu_btf_ptr_types,
> >       [ARG_PTR_TO_FUNC]               =3D &func_ptr_types,
> >       [ARG_PTR_TO_STACK]              =3D &stack_ptr_types,
> >       [ARG_PTR_TO_CONST_STR]          =3D &const_str_ptr_types,
> > -     [ARG_PTR_TO_TIMER]              =3D &timer_types,
> > +     [ARG_PTR_TO_TIMER]              =3D &map_value_types,
> >       [ARG_KPTR_XCHG_DEST]            =3D &kptr_xchg_dest_types,
> >       [ARG_PTR_TO_DYNPTR]             =3D &dynptr_types,
> > +     /* Argument kinds only a kfunc can have. */
> > +     [ARG_SCALAR]                    =3D &scalar_types,
> > +     [ARG_CONST_SCALAR]              =3D &scalar_types,
> > +     [ARG_CONST_MEM_SIZE]            =3D &scalar_types,
> > +     [ARG_PTR_TO_ALLOC_BTF_ID]       =3D &alloc_obj_types,
> > +     [ARG_PTR_TO_REFCOUNTED_KPTR]    =3D &alloc_obj_or_non_own_ref_typ=
es,
> > +     [ARG_PTR_TO_ITER]               =3D &stack_ptr_types,
> > +     [ARG_PTR_TO_LIST_HEAD]          =3D &map_value_or_alloc_obj_types=
,
> > +     [ARG_PTR_TO_LIST_NODE]          =3D &alloc_obj_or_non_own_ref_typ=
es,
> > +     [ARG_PTR_TO_RB_ROOT]            =3D &map_value_or_alloc_obj_types=
,
> > +     [ARG_PTR_TO_RB_NODE]            =3D &alloc_obj_or_non_own_ref_typ=
es,
> > +     [ARG_PTR_TO_RES_SPIN_LOCK]      =3D &map_value_or_alloc_obj_types=
,
> > +     [ARG_PTR_TO_WORKQUEUE]          =3D &map_value_types,
> > +     [ARG_PTR_TO_TASK_WORK]          =3D &map_value_types,
> > +     [ARG_PTR_TO_IRQ_FLAG]           =3D &stack_ptr_types,
> > +     [ARG_PTR_TO_ARENA]              =3D &arena_types,
> >  };
>
> Does ARG_PTR_TO_MEM need to admit allocated objects for kfuncs? Running

This seems to be a real regression. Since helper currently does not
allow it (wether relaxing it or not can be defer), I will add a
shortcut in check_reg_type to allow this instead of adding
PTR_TO_BTF_ID | MEM_ALLOC to mem_types.

> check_reg_type() on kfunc arguments makes mem_types the admission gate fo=
r
> ARG_PTR_TO_MEM, but mem_types lists only PTR_TO_BTF_ID | PTR_TRUSTED amon=
g
> the BTF-backed register types. Before this commit check_kfunc_args() had =
no
> reg-type test in its ARG_PTR_TO_MEM / ARG_MEM_SIZE cases (the commit
> removes tests from ten other cases but adds none here), so a kfunc memory
> argument was validated only by check_mem_reg()/check_mem_size_reg() ->
> check_helper_mem_access(), which accepts any BTF-ID register:
>
>   case PTR_TO_BTF_ID:
>     return check_ptr_to_btf_access(env, regs, reg, argno, 0,
>                                    access_size, access_type, -1);
>     /* kernel/bpf/verifier.c:7097-7099, switch is on base_type(reg->type)=
 */
>
> Kfunc memory arguments are checked with BPF_READ | BPF_WRITE
> (verifier.c:13243 and 13289), and check_ptr_to_btf_access() has an explic=
it
> carve-out that permits exactly those writes for BPF-allocated objects:
>
>   /* Writes are permitted with default btf_struct_access for
>    * program allocated objects (which always have id > 0).
>    */
>   if (atype !=3D BPF_READ && !type_is_ptr_alloc_obj(reg->type)) {
>     verbose(env, "only read is supported\n");
>     return -EACCES;
>   }
>   /* kernel/bpf/verifier.c:6093-6099 */
>
> check_func_arg_reg_off() likewise enumerates PTR_TO_BTF_ID | MEM_ALLOC an=
d
> PTR_TO_BTF_ID | MEM_ALLOC | NON_OWN_REF as register types that legitimate=
ly
> reach argument checking with a fixed offset (verifier.c:8567-8578). So a
> program that does
>
>   struct foo *f =3D bpf_obj_new(typeof(*f));
>   ...
>   some_kfunc(&f->buf, sizeof(f->buf));  /* void *p, u32 p__sz */
>
> or passes such a pointer to a fixed-size scalar-pointer kfunc argument
> (get_kfunc_arg_type() verifier.c:12321, ARG_PTR_TO_MEM | MEM_FIXED_SIZE)
> loaded before this commit and is now rejected at check_reg_type() with
> -EACCES: "R1 type=3Dptr_ expected=3Dfp, pkt, pkt_meta, map_key, map_value=
, mem,
> ringbuf_mem, buf, trusted_ptr_, ctx".
>
> Since mem_types already excluded PTR_TO_BTF_ID | MEM_ALLOC for helpers, t=
he
> write-to-allocated-object carve-out in check_ptr_to_btf_access() was
> reachable from the argument path only through kfuncs; after this commit i=
t
> is unreachable from any argument path.
>
> This is a third, undocumented behaviour change. The changelog states "Two
> behavior changes fall out of running admission first" and lists only the
> ARG_CONST_MEM_SIZE precision fix and the ARG_CONST_MAP_PTR
> type_may_be_null() removal. No selftest covers passing an allocated objec=
t
> as a kfunc memory argument, so the capability is removed silently. Forwar=
d
> search over the supplied range 8f65640265e8..a490f49b0c4e shows no change
> to mem_types. If the narrowing is intended it should be stated in the
> changelog (and the now-dead carve-out comment in check_ptr_to_btf_access(=
)
> updated); otherwise mem_types needs PTR_TO_BTF_ID | MEM_ALLOC (and the
> NON_OWN_REF form).
>
> [ ... ]
>
> > @@ -13002,25 +13015,20 @@ static int check_kfunc_args(struct bpf_verifi=
er_env *env, struct bpf_call_arg_me
> >               if (base_type(arg_type) =3D=3D ARG_PTR_TO_BTF_ID)
> >                       ref_id =3D *meta->fn->arg_btf_id[i];
> >
> > -             ret =3D resolve_func_arg_type(env, reg, i, meta, insn_idx=
, &arg_type, &arg_size);
> > +             ret =3D resolve_func_arg_type(env, reg, i, meta, &arg_typ=
e, &arg_size);
> >               if (ret < 0)
> >                       return ret;
> > +
> > +             ret =3D check_reg_type(env, reg, argno, arg_type, meta);
> > +             if (ret < 0)
> > +                     return ret;
> > +
> >               ret =3D check_func_arg_reg_off(env, reg, argno, arg_type)=
;
> >               if (ret < 0)
> >                       return ret;
> >
> >               switch (base_type(arg_type)) {
> >               case ARG_CONST_SCALAR:
> > -                     if (reg->type !=3D SCALAR_VALUE) {
> > -                             verbose(env, "%s is not a scalar\n", reg_=
arg_name(env, argno));
> > -                             bpf_diag_call_arg_fmt(env, insn_idx, argn=
o, func_name,
> > -                                                   "Pass an integer sc=
alar value for this argument, not a pointer or resource object.",
> > -                                                   "the kfunc expects =
an integer scalar, but %s is %s",
> > -                                                   reg_arg_name(env, a=
rgno),
> > -                                                   bpf_diag_reg_type_p=
lain(env, reg->type));
> > -                             return -EINVAL;
> > -                     }
> > -
> >                       ret =3D process_const_arg(env, reg, argno, meta);
> >                       if (ret < 0) {
> >                               if (ret =3D=3D -EINVAL)
>
> [ ... ]
>
> > @@ -11845,24 +11874,8 @@ static int resolve_func_arg_type(struct bpf_ve=
rifier_env *env,
> >               ref_t =3D btf_type_skip_modifiers(btf, ref_id, &ref_id);
> >               ref_tname =3D btf_name_by_offset(btf, ref_t->name_off);
> >
> > -             if (!btf_type_is_scalar_struct(env, btf, ref_t)) {
> > -                     enum bpf_reg_type reg2btf_type =3D lookup_reg2btf=
_ids(ref_id);
> > -                     const char *expected_type;
> > -
> > -                     verbose(env, "%s is %s expected %s %s",
> > -                             reg_arg_name(env, argno), reg_type_str(en=
v, reg->type),
> > -                             btf_type_str(ref_t), ref_tname);
> > -                     if (reg2btf_type !=3D NOT_INIT)
> > -                             verbose(env, " or %s", reg_type_str(env, =
reg2btf_type));
> > -                     verbose(env, "\n");
> > -                     expected_type =3D bpf_diag_fmt_btf_type(env, btf,=
 ref_id);
> > -                     bpf_diag_call_arg_fmt(env, insn_idx, argno, meta-=
>func_name,
> > -                                           "Pass a verifier-tracked po=
inter to the expected kernel object type, not a pointer to stack storage or=
 another memory buffer.",
> > -                                           "the function expects a poi=
nter to %s, but this argument is %s and cannot be used as that kernel objec=
t pointer",
> > -                                           expected_type,
> > -                                           bpf_diag_reg_type_plain(env=
, reg->type));
> > -                     return -EINVAL;
> > -             }
> > +             if (!btf_type_is_scalar_struct(env, btf, ref_t))
> > +                     return 0;
>
> Does this break existing selftests? The patch deletes the only producer o=
f
> the "R1 is fp expected STRUCT prog_test_fail1" diagnostic from
> resolve_func_arg_type(), replacing it with a bare `return 0;`. It updates
> verifier/calls.c line 79 but leaves three other cases in the same file
> still asserting the removed message:
>
>   calls.c:34  .errstr =3D "R1 is fp expected STRUCT prog_test_fail1"
>   calls.c:49  .errstr =3D "max struct nesting depth exceeded\nR1 is fp
>                expected STRUCT prog_test_fail2"
>   calls.c:64  .errstr =3D "R1 is fp expected STRUCT prog_test_fail3"
>
> All three are reached: bpf_kfunc_call_test_fail1/2/3 take pointers to
> struct prog_test_fail1 (has pointer member), prog_test_fail2 (nesting dep=
th
> > 4) and prog_test_fail3 (flexible array), so btf_type_is_scalar_struct()
> returns false for each and the removed verbose() used to fire. After the
> patch, resolve_func_arg_type() returns 0 with arg_type still
> ARG_PTR_TO_BTF_ID; check_reg_type() then rejects R1 (PTR_TO_STACK) agains=
t
> btf_ptr_types and prints "R1 type=3Dfp expected=3Dptr_, trusted_ptr_, rcu=
_ptr_"
> instead. The asserted substrings never appear, so these three test_verifi=
er
> cases fail.
>
> These three sites are not fixed anywhere later in the series either: `git
> show a490f49b0c4e:tools/testing/selftests/bpf/verifier/calls.c` still
> contains all three stale strings, and no commit in 8f65640265e8..a490f49b=
0c4e
> touches verifier/calls.c.
>
> Do the test expectations in other files also need updating? Three more BP=
F
> selftests assert the "is fp expected STRUCT ..." message that this commit
> removes from resolve_func_arg_type():
>
>   tools/testing/selftests/bpf/progs/cgrp_kfunc_failure.c:67
>     __msg("R1 is fp expected STRUCT cgroup")
>   tools/testing/selftests/bpf/progs/task_kfunc_failure.c:53
>     __msg("R1 is fp expected STRUCT task_struct")
>   tools/testing/selftests/bpf/progs/verifier_vfs_reject.c:31
>     __msg("R1 is fp expected STRUCT task_struct")
>
> struct cgroup and struct task_struct are not scalar structs, so each of
> these used to hit the deleted verbose(); after the patch check_reg_type()
> emits "R1 type=3Dfp expected=3Dptr_, trusted_ptr_, rcu_ptr_" and the asse=
rtions
> fail.
>
> This is confirmed by the series itself: commit a490f49b0c4e ("bpf: Check
> helper and kfunc arguments in one path"), four commits later, updates
> exactly these three lines to __msg("R1 type=3Dfp expected=3Dptr_, trusted=
_ptr_,
> rcu_ptr_"). Those test-expectation updates belong in this commit, which i=
s
> the one that changes the message; as it stands the tree is bisect-broken
> for 4 commits (test_progs cgrp_kfunc/task_kfunc/verifier_vfs_reject).

Will fix the test error message expectations.

>
> Does this lose test coverage for the ownership check?
> rbtree_fail.c:182 and rbtree_fail.c:206 were the only two selftests
> asserting the verifier check at kernel/bpf/verifier.c:13183:
>
>   verbose(env, "%s can only take non-owning or refcounted bpf_rb_node
>   pointer\n", func_name);
>
> Both tests invalidate a non-owning ref across bpf_spin_unlock() (the
> register becomes SCALAR_VALUE) and then call bpf_rbtree_remove(). With
> check_reg_type() now running before the switch, SCALAR_VALUE is rejected =
by
> ARG_PTR_TO_RB_NODE's alloc_obj_or_non_own_ref_types table first, so the
> ownership check is no longer reached and the new expectations only assert
> the generic register-class error. `grep -r "can only take non-owning or
> refcounted" tools/testing/selftests/bpf/` now returns nothing: the check
> has zero test coverage after this patch.
>
> Worth double-checking whether that check is still reachable at all. The
> only register types that can now reach it are PTR_TO_BTF_ID|MEM_ALLOC,
> |NON_OWN_REF and |NON_OWN_REF|MEM_RCU; the NON_OWN_REF forms satisfy
> type_is_non_owning_ref(), and a plain owning MEM_ALLOC register whose
> reference has been released is invalidated by
> release_reference()/mark_reg_invalid(). If no reachable register type
> remains, the check is dead and should be dropped rather than left
> uncovered; if it is reachable, the two repurposed tests should be kept (o=
r
> a replacement added) so the ownership rule stays guarded.

The check is indeed unreachable.

I prefer keep it to be safe. The listed compatible types happen to
match what !type_is_non_owning_ref() && reg_is_referenced() gates. It
requires that a plain MEM_ALLOC pointer must carry a live reference.

>
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a =
bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/READM=
E.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/339954=
42755
