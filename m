Received: from mail-oi2-f12.google.com (mail-oi2-f12.google.com [74.125.231.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAD0136F8EA
	for <bpf@vger.kernel.org>; Wed,  9 Sep 2026 18:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.231.204
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788977075; cv=pass; b=tFZJrdFIdOSS1Ntp4SVAXvor+Lc0b/Yhd87l4oMzcDUGuJNxNOsfTXTxzYU4456cYM1sxe5Ycm+NAqNW0sx7e2CoJYy4nz9GeDnVJMpCeQ21EL+1/Ms9VVe+FSPYREST6xXvjHW5ZA2ZNRYitLoIK/1JISS2Q3pTmPfvyAGvcTQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788977075; c=relaxed/simple;
	bh=zPhv7kecLiGqMjX9jGWlfWCD1/aej3oRziEnpw5vrZ0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hPn6LIBVjD/LITUPWBorBD1IdUm6sQaKpVhijuKgdBeJqCxDFVIVzKEWmwkvyW8RCGmob6n27DKewG3P3nU68TAShLet9r4V6YPcz4gRbiNWzlHCbt5+gM18CyXLvTpqqiDOCTlqi5UNqKVnadZOOfKYiooc+eioaChZOUTcpmU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FsT3eehf; arc=pass smtp.client-ip=74.125.231.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FsT3eehf"
Received: by mail-oi2-f12.google.com with SMTP id 5614622812f47-4b37a368895so364686b6e.3
        for <bpf@vger.kernel.org>; Wed, 09 Sep 2026 11:04:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788977073; cv=none;
        d=google.com; s=arc-20260327;
        b=QHglcYS7u6fsGsoTs45DyW2oefZ/s1J1WYQWPnICezV+x7Ne/pxLE3e4OJXVLMFfJR
         OY4xEDC/ybCar+XVvXMLVfhDn7RG2aJiGW+z/ZdR5BrwFaNXz25TT1P0P5v+bk2oonIQ
         PXjZKC+UndP5GOvIfEdvdac71nO39+8jL/H6HVOlRXRtphLDVaJq7bsERvjyOhfJGOyV
         7xvf+wGyE/xuT7fw/qclWyZomXJJzaQEKtj+yi9BCNHFy2IqgYGIpwLaHKmzgQ3JIFHf
         yYofii2+qB+aybnkvnZFwBporsPH+58hQsLC64fqLtyaXCGxWBI6TjQK4trjy+o4/H7F
         cedA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xt9wnQmVp9c36M7PI95VSyzTQimGQjCz6RZ4dTxoEjk=;
        fh=+iofH7kLhUIpDUAo/a2rUbKulXCH8Go9n65YHAt0kP0=;
        b=qPRIcGEjsVO40o+gQiEtjRJeH+8NP9/sX0AekWb0O3MCUmUeOTwKbVpRtT4hP2r6b4
         mfIL18eVvhLx3UQESepSG2VvLjJo4DwAkbTIr0wvX+Rd8TeJk7sgI/j4mkZIp6W4sNnS
         DzAfhJ8QNB3tNq9Qeq/Lro0DFiD+0bmDhQVcrdeJAVWFzlisSMsIhhZl36ylKXjXnZ+g
         ExRqxG1ga8KYQbwCWkcI4Yn6opi3u6IhluALCq6/fuJv1+/8VtfDpKH6oXEIDVT53lj3
         OW8aoo8fksZWB8O/izV+LvBiGmFJOySMKJazHvDFGsCQ7Oohus296VGCUrLmdfsXuzJk
         pFug==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788977073; x=1789581873; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xt9wnQmVp9c36M7PI95VSyzTQimGQjCz6RZ4dTxoEjk=;
        b=FsT3eehfID1l6V8F1L+DDRgTSLL+Ude/58EVdBsHqdHnzwMA5jJQlz5YE0OXhRTywp
         xLClgabBE7gju7GLjqc7rmatpdnhxu65iDZ325XLvYtGTm2j3Qfn+AWekYiE4Ik0AFjL
         Mo5kn1+T+q31Vy/nKwLqgJlc1B2gHw5fmZAaRnr+8UzSAh4xiFGang8mxepS4lbqBQ5f
         ZFCtGaTBCv5UFtRZiiaDNCTx70LZ+aQNkgciI4juF+FTQ5I/+9RESsHhJEg7+3Jk5H2D
         b0pC+srvuJjdwyXNgi0PR0XQ1F6pN1jopviqoJgAIS4PMzp2Cl/8Jo7DyLDnaXSQKD/v
         cP8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788977073; x=1789581873;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xt9wnQmVp9c36M7PI95VSyzTQimGQjCz6RZ4dTxoEjk=;
        b=eMATwam/j1TfijNUFblw3H8306Ow+4vxk4vs0rtsdC/2E1hqqZOVhUPQ4Z6sCj0W1i
         BniSlze+gINtlhrhbByn68FAeVC3JO9mhcJ941H5wFVB8BZ778Mw3MlSj4p34gnP1VA6
         vM7Iw5/YCn6IJPrjTokKGX3C7MSfeG/sLqOshlyxdPt+m9g//tkcJJEeXQ5v++ZaetuF
         BX7J9ge05FNLIgphgVOFJdNXdd+AZFU3Py1by8bnO+nQKhhqE7j+YIJxVCNZogvWBOno
         jO3WS/752qp+bKjspRCE8KD9+l8xzbXsKQSh6I+mD1B1exB27nzoYSLoUD3l4T1BLywm
         Ulcg==
X-Gm-Message-State: AFuF++lOMIvSLuemNlwCItxpjmBa8CKLnK+Sxcwiq1+zw5QRGpCLXTlC
	amqIbtURt0YFJbhYSen0xjuODF8Zsc3aBs58VNYgFSHtULF6MxrDi9gmnTOkk6vRYe0d2M2OmF3
	iVX2IeHkVuC33jEOw3tY6QW55wGmYH5c=
X-Gm-Gg: AYBFou3tRbrne9HsTThav9OfYMaOy5NNCMLfWh1kAZGpx0fZlqiqEOw9/kfCrZ0VN4v
	rFcvHLzC3zvTo1cKPtlDwhXZYS/dhkPOpGflNXlrR8PV8j8a/DDIeGLIOWxEnvgqVtQFHqdc3ig
	lfv5iuWolxp1bOeBEvF7TNYCuU/WdhJF3LwvH3W40Kbq19B30KA2s+GaYIVgv7pd3H0gGdxbTFa
	DAoYhWyK0hljKo/jocjhJIZJ8z+WJ9Sg3xpKiQjIU1h4e+pvwB0qJ5kJgYaXOQFE7zpQ/vFS9lD
	aze+Jp/Q2UlPeMxD23Vb7piFk3AHZJGVq1Ery9HSVLQs0K5qxCzMBvM/sUeEnPXZezfCAA==
X-Received: by 2002:a05:6820:615:b0:6b1:89ff:8a1a with SMTP id
 006d021491bc7-6bee4da4619mr1591694eaf.3.1788977072365; Wed, 09 Sep 2026
 11:04:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260905220117.922028-7-ameryhung@gmail.com> <5189666ade3136d3ff5f5d8cc75a7ef57dbe2e4cc6c0cb9fec73024dfabc655a@mail.kernel.org>
In-Reply-To: <5189666ade3136d3ff5f5d8cc75a7ef57dbe2e4cc6c0cb9fec73024dfabc655a@mail.kernel.org>
From: Amery Hung <ameryhung@gmail.com>
Date: Wed, 9 Sep 2026 11:04:20 -0700
X-Gm-Features: AcwNN1Ux2v74si3H-LgFGvIVJX2UKfcvukp2eO-SeAgrF-gq1sgVtnhjzDM6CP4
Message-ID: <CAMB2axOHTkSz=AOqCSwc6m2nnBDKiGCu5au9kJAGKBGeDHd_yg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 06/22] bpf: Unify kfunc argument kinds with
 enum bpf_arg_type
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
> > index 1574fe2d8cc0..f620920ea575 100644
> > --- a/include/linux/bpf.h
> > +++ b/include/linux/bpf.h
> > @@ -908,6 +908,20 @@ enum bpf_arg_type {
> >       ARG_PTR_TO_TIMER,       /* pointer to bpf_timer */
> >       ARG_KPTR_XCHG_DEST,     /* pointer to destination that kptrs are =
bpf_kptr_xchg'd into */
> >       ARG_PTR_TO_DYNPTR,      /* pointer to bpf_dynptr. See bpf_type_fl=
ag for dynptr type */
> > +
> > +     ARG_CONST_SCALAR,       /* scalar known at verification time */
> > +     ARG_CONST_MEM_SIZE,     /* ARG_MEM_SIZE that must be constant */
> > +     ARG_PTR_TO_ALLOC_BTF_ID,        /* pointer to an allocated object=
 */
> > +     ARG_PTR_TO_REFCOUNTED_KPTR,     /* pointer to a refcounted local =
kptr */
> > +     ARG_PTR_TO_ITER,        /* pointer to an iterator */
> > +     ARG_PTR_TO_LIST_HEAD,   /* pointer to bpf_list_head */
> > +     ARG_PTR_TO_LIST_NODE,   /* pointer to bpf_list_node */
> > +     ARG_PTR_TO_RB_ROOT,     /* pointer to bpf_rb_root */
> > +     ARG_PTR_TO_RB_NODE,     /* pointer to bpf_rb_node */
> > +     ARG_PTR_TO_WORKQUEUE,   /* pointer to bpf_wq */
> > +     ARG_PTR_TO_TASK_WORK,   /* pointer to bpf_task_work */
> > +     ARG_PTR_TO_IRQ_FLAG,    /* pointer to saved IRQ flags on the stac=
k */
> > +     ARG_PTR_TO_RES_SPIN_LOCK,       /* pointer to bpf_res_spin_lock *=
/
> >       __BPF_ARG_TYPE_MAX,
> >
> >       /* Extended arg_types. */
>
> [ ... ]
>
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index d444e72fdd97..a0a74a5e23be 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -8533,10 +8533,9 @@ reg_find_field_offset(const struct bpf_reg_state=
 *reg, s32 off, u32 fields)
> >       return field;
> >  }
> >
> > -static int __check_func_arg_reg_off(struct bpf_verifier_env *env,
> > -                                 const struct bpf_reg_state *reg, argn=
o_t argno,
> > -                                 enum bpf_arg_type arg_type,
> > -                                 bool btf_id_fixed_off_ok)
> > +static int check_func_arg_reg_off(struct bpf_verifier_env *env,
> > +                               const struct bpf_reg_state *reg, argno_=
t argno,
> > +                               enum bpf_arg_type arg_type)
> >  {
> >       u32 type =3D reg->type;
> >
> > @@ -8592,12 +8591,15 @@ static int __check_func_arg_reg_off(struct bpf_=
verifier_env *env,
> >       case PTR_TO_BTF_ID | MEM_ALLOC | NON_OWN_REF:
> >       case PTR_TO_BTF_ID | MEM_ALLOC | NON_OWN_REF | MEM_RCU:
> >               /* When referenced PTR_TO_BTF_ID is passed to release fun=
ction,
> > -              * its fixed offset must be 0. In the other cases, fixed =
offset
> > -              * can be non-zero unless the caller requires otherwise.
> > -              * var_off always must be 0 for PTR_TO_BTF_ID, hence we s=
till
> > -              * need to do checks instead of returning.
> > +              * its fixed offset must be 0. bpf_refcount_acquire() ret=
urns the
> > +              * pointer it was given while incrementing the refcount a=
t the
> > +              * refcount field offset, so it needs a zero offset too. =
In the
> > +              * other cases, fixed offset can be non-zero. var_off alw=
ays must
> > +              * be 0 for PTR_TO_BTF_ID, hence we still need to do chec=
ks
> > +              * instead of returning.
> >                */
> > -             return __check_ptr_off_reg(env, reg, argno, btf_id_fixed_=
off_ok);
> > +             return __check_ptr_off_reg(env, reg, argno,
> > +                                        base_type(arg_type) !=3D ARG_P=
TR_TO_REFCOUNTED_KPTR);
> >       case PTR_TO_CTX:
> >               /*
> >                * Allow fixed and variable offsets for syscall context, =
but
> > @@ -8613,13 +8615,6 @@ static int __check_func_arg_reg_off(struct bpf_v=
erifier_env *env,
> >       }
> >  }
> >
> > -static int check_func_arg_reg_off(struct bpf_verifier_env *env,
> > -                               const struct bpf_reg_state *reg, argno_=
t argno,
> > -                               enum bpf_arg_type arg_type)
> > -{
> > -     return __check_func_arg_reg_off(env, reg, argno, arg_type, true);
> > -}
> > -
>
> [ ... ]
>
> > @@ -11793,34 +11788,6 @@ static void btf_member_path_str(const struct b=
tf *btf, const struct btf_member_p
> >       }
> >  }
> >
> > -enum kfunc_ptr_arg_type {
> > -     KF_ARG_CONST_MEM_SIZE,
> > -     KF_ARG_MEM_SIZE,
> > -     KF_ARG_CONST,
> > -     KF_ARG_CONST_ALLOC_SIZE_OR_ZERO,
> > -     KF_ARG_ANYTHING,
> > -     KF_ARG_PTR_TO_CTX,
> > -     KF_ARG_PTR_TO_ALLOC_BTF_ID,    /* Allocated object */
> > -     KF_ARG_PTR_TO_REFCOUNTED_KPTR, /* Refcounted local kptr */
> > -     KF_ARG_PTR_TO_DYNPTR,
> > -     KF_ARG_PTR_TO_ITER,
> > -     KF_ARG_PTR_TO_LIST_HEAD,
> > -     KF_ARG_PTR_TO_LIST_NODE,
> > -     KF_ARG_PTR_TO_BTF_ID,          /* Also covers reg2btf_ids convers=
ions */
> > -     KF_ARG_PTR_TO_MEM,
> > -     KF_ARG_PTR_TO_CALLBACK,
> > -     KF_ARG_PTR_TO_RB_ROOT,
> > -     KF_ARG_PTR_TO_RB_NODE,
> > -     KF_ARG_PTR_TO_CONST_STR,
> > -     KF_ARG_CONST_MAP_PTR,
> > -     KF_ARG_PTR_TO_TIMER,
> > -     KF_ARG_PTR_TO_WORKQUEUE,
> > -     KF_ARG_PTR_TO_IRQ_FLAG,
> > -     KF_ARG_PTR_TO_RES_SPIN_LOCK,
> > -     KF_ARG_PTR_TO_TASK_WORK,
> > -     KF_ARG_PTR_TO_ARENA,
> > -};
> > -
>
> This deletion removes KF_ARG_PTR_TO_REFCOUNTED_KPTR from the tree. Does
> the kerneldoc comment in include/linux/bpf_verifier.h for struct
> bpf_call_arg_meta need updating? It still refers to the deleted name:
>
>     /* arg_{btf,btf_id,owning_ref} are used by kfunc-specific handling,
>      * ...
>      *   bpf_refcount_acquire (via KF_ARG_PTR_TO_REFCOUNTED_KPTR arg type=
)
>      */
>
> The replacement is ARG_PTR_TO_REFCOUNTED_KPTR.
>
> [ ... ]
>
> > @@ -12826,13 +12793,11 @@ static int check_kfunc_args(struct bpf_verifi=
er_env *env, struct bpf_call_arg_me
> >        */
> >       for (i =3D 0; i < nargs; i++) {
> >               struct bpf_reg_state *reg =3D get_func_arg_reg(caller, re=
gs, i);
> > +             enum bpf_arg_type arg_type =3D meta->fn->arg_type[i];
> >               const struct btf_type *t, *ref_t, *resolve_ret;
> > -             enum bpf_arg_type arg_type =3D ARG_UNUSED;
> >               argno_t argno =3D argno_from_arg(i + 1);
> >               int regno =3D reg_from_argno(argno);
> > -             bool btf_id_fixed_off_ok =3D true;
> >               u32 ref_id =3D args[i].type, type_size;
> > -             int kf_arg_type =3D meta->fn->arg_type[i];
>
> [ ... ]
>
> > @@ -12901,54 +12866,14 @@ static int check_kfunc_args(struct bpf_verifi=
er_env *env, struct bpf_call_arg_me
> >                       ref_tname =3D btf_name_by_offset(btf, ref_t->name=
_off);
> >               }
> >
> > -             switch (base_type(kf_arg_type)) {
> > -             case KF_ARG_CONST:
> > -             case KF_ARG_CONST_MEM_SIZE:
> > -             case KF_ARG_MEM_SIZE:
> > -             case KF_ARG_ANYTHING:
> > -             case KF_ARG_CONST_ALLOC_SIZE_OR_ZERO:
> > -             case KF_ARG_PTR_TO_ALLOC_BTF_ID:
> > -             case KF_ARG_PTR_TO_BTF_ID:
> > -             case KF_ARG_CONST_MAP_PTR:
> > -             case KF_ARG_PTR_TO_ITER:
> > -             case KF_ARG_PTR_TO_LIST_HEAD:
> > -             case KF_ARG_PTR_TO_LIST_NODE:
> > -             case KF_ARG_PTR_TO_RB_ROOT:
> > -             case KF_ARG_PTR_TO_RB_NODE:
> > -             case KF_ARG_PTR_TO_MEM:
> > -             case KF_ARG_PTR_TO_CALLBACK:
> > -             case KF_ARG_PTR_TO_CONST_STR:
> > -             case KF_ARG_PTR_TO_WORKQUEUE:
> > -             case KF_ARG_PTR_TO_TIMER:
> > -             case KF_ARG_PTR_TO_TASK_WORK:
> > -             case KF_ARG_PTR_TO_IRQ_FLAG:
> > -             case KF_ARG_PTR_TO_RES_SPIN_LOCK:
> > -             case KF_ARG_PTR_TO_ARENA:
> > -                     break;
> > -             case KF_ARG_PTR_TO_DYNPTR:
> > -                     arg_type =3D ARG_PTR_TO_DYNPTR;
> > -                     break;
> > -             case KF_ARG_PTR_TO_CTX:
> > -                     arg_type =3D ARG_PTR_TO_CTX;
> > -                     break;
> > -             case KF_ARG_PTR_TO_REFCOUNTED_KPTR:
> > -                     arg_type =3D ARG_PTR_TO_BTF_ID;
> > -                     btf_id_fixed_off_ok =3D false;
> > -                     break;
> > -             default:
> > -                     verifier_bug(env, "unknown kfunc arg type %d", kf=
_arg_type);
> > -                     return -EFAULT;
> > -             }
> > -
> >               if (regno =3D=3D meta->release_regno)
> >                       arg_type |=3D OBJ_RELEASE;
> > -             ret =3D __check_func_arg_reg_off(env, reg, argno, arg_typ=
e,
> > -                                            btf_id_fixed_off_ok);
> > +             ret =3D check_func_arg_reg_off(env, reg, argno, arg_type)=
;
> >               if (ret < 0)
> >                       return ret;
>
> Dropping the translation switch means check_func_arg_reg_off() now
> receives the flag-carrying arg_type from get_kfunc_arg_type() instead of
> a bare base type. Does this affect the PTR_TO_CTX case in that function?
>
> Looking at check_func_arg_reg_off():
>
>     case PTR_TO_CTX:
>             if (arg_type !=3D ARG_PTR_TO_CTX && is_var_ctx_off_allowed(en=
v->prog))
>                     return 0;
>
> The test compares the full value rather than base_type(arg_type).
> Before this commit, the translation switch assigned 'arg_type =3D
> ARG_PTR_TO_CTX;' with no flags. After it, get_kfunc_arg_type() can
> return ARG_PTR_TO_CTX | PTR_MAYBE_NULL for a context-typed kfunc
> parameter carrying a '__nullable' suffix. In BPF_PROG_TYPE_SYSCALL
> programs (the only program type where is_var_ctx_off_allowed() is true),
> would a nullable ctx arg skip the __check_ptr_off_reg() call, taking the
> 'return 0' path instead of rejecting modified ctx pointers?
>
> While this appears unreachable today (no in-tree kfunc has both a
> context-typed parameter and a __nullable suffix), is the "No functional
> change" claim literally exact, or would converting the test to
> 'base_type(arg_type) !=3D ARG_PTR_TO_CTX' make the unification flag-safe?

Make sense to compare against base type. Will change.

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
