Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F7503FBEB8
	for <bpf@vger.kernel.org>; Mon, 27 Jul 2026 23:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785196612; cv=pass; b=rcRA6DO/IgxEVAVlRO9qvT0BddItzc2vcKeBrTP722wrNF91/Naa4OMIhZzRMA21e7+HzNQCX+Lh6eo/PGQyNS1aoDBCCRmfEl2Yqinh4K/N5MnfiwS7uXfXV9zZ1MzHVqHaQUW8vvZ88gozgphMkT5PjiQnKQRflxYOdMwk7vw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785196612; c=relaxed/simple;
	bh=YX70+j90p+Q6UdAC/gQObPtCVCCLKJl8HEQaUf+4qPQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qcJgDHpZQx00allXswVtlCoRE5wsQ08iXpaZAz8vL1FBGr0YalgWM7JJwgk4+eqFjXIjWm9IXA0a/gJEPZHk8E1RRdtPbWGfvuShF954QQu360VdYXcVEeUx0By8rGv8VOP3REHZSQIjFTgt2n+3USk5fhzwnVOugeW2BEWMq/0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e8HnAh97; arc=pass smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e8HnAh97"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-84864086bfeso3156827b3a.1
        for <bpf@vger.kernel.org>; Mon, 27 Jul 2026 16:56:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785196611; cv=none;
        d=google.com; s=arc-20260327;
        b=dEcPXG2EpCqdZh9QVX6oCwoWzBrpF856oqUlIirOueDVlagrrjdrXOL9B+jLDJ+BLj
         q6nm2aNomRR6TlkSFVmoBqjEVj5Njr+gmkKDOZQPrMe/2n/iiDafatIgXO2MxWKdQLxs
         lXKyXTgnyya8ZWrULZcqeEess/HXUMVmSS6zORjJ5aiXRS1OWIsmlXm8+znBAoeAQq2y
         zBG37Dmp+j/Xw4XN2Emwji0vPKxwysrfc2jeUhODE22nuVbPg2mRUwkaY6CwFrfgCEyb
         2BWh/Ny3tzVtMj2Bfdb9dJDlL28j561VKYJk3yK0Algl4jZVjJwZa3AXjGE2WvFvlNme
         OnWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9XM/XHX/LkcJNT++tvJJaFRPZGqMOlXBtBfQscR6nn8=;
        fh=7eoyOfXUpehVHh0e6FcQCsD9SMN+Vtenv0RH2SBGXXs=;
        b=VMJhO8FJjrQzwcErwxJRpWsoWYjJMs9A/LoprdEDzOOMfWmNyeM98UUh23wmvlomNU
         MD7dA5bGEZbNaLqCrdX2RtPYn9NhWPqWtCGMZW1tle22qHHywCYDg1OHpxrxhI0WQCGz
         6qHaJVbti2RncAeWPzM2108r9uwt/ZJxUCYsiJYa5TzoD58Aykl8kghOaimjVOH48PhS
         Fg5kX+4+pWWwyAJRZhJeJtOZ/WZ9z0W2yuuxwDZbC7BB1BL/x4581bNVKsWzV1doU0r6
         oUkWdgFPihQis8SsMrD8i8FzG2vmrzrMBCa8rNW6Eo1lHUWxQwGgBYf5EsF+kxICRphf
         hvsQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785196611; x=1785801411; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=9XM/XHX/LkcJNT++tvJJaFRPZGqMOlXBtBfQscR6nn8=;
        b=e8HnAh97bEeTi1wsAfZvWyymhcqVe3OTAA2n3qXtfIqUO8njspgZ3mxuplixG5Y5xP
         D/X8FfI6EOx2/agYNgyICHO9J7p81Tsy/O0poVNCX1kDqkjcQLRTsTzNV6Z+ubUxm+Ru
         +kdw7j+uL9AJepKSgFaSWDnLUFkz0hktn9JYK0cQtlO6np12LZ63rOJ5VBG7xAobOZ4z
         papJXq8rkBNclmng4fvszJRjoYUZF7hfApNuixs4jcFSKTWZ5YBwen/HEzorfq+Cl3f/
         t/izvEjzhI7wK9uDCG6I4R3Q9nDnqlJs9B6XyK584zwacO/N9V54NZfjc/WDFRSp3h75
         UnSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785196611; x=1785801411;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9XM/XHX/LkcJNT++tvJJaFRPZGqMOlXBtBfQscR6nn8=;
        b=lJEDuLJRZ1dAKE2v8TreWHwNqT++t/fQmqODvbnmy/nfOFa0uwVpccSnac9LtG5adT
         VR5oyO5aUssXyXmgoEKGI16+NKBUTH9PV/jZ5gNZpPelUqmCMQmAA8XxdUQILLyHGSPC
         zCf8JucARiOJRsKgFuq2O6etTtZbP4IPAQi0Ov6+6KxiPAlHgUiYxRE8gcyrpdr5qKFn
         T5s4gLr+eTGTVp+CIegcxDEFlFbbLqRabsUV+mD3EEP1T0TXMhhm1GD/+ay4uo7KGves
         acay2DWxr98Xt4urNofd0yKz9j9TgADXgav724ZL8f1JuNWKfz/TzfSOznKtYaYTe8mZ
         tfRg==
X-Gm-Message-State: AOJu0YyVSsVbyR099bJ3MMTpE9Quh6rwdZxWaH/A2Um7ttkm5ylC6gTx
	q/IuuJb1eVbhGKLGOysN4KvLLHAhODpU5suQqplaIP/Vz576cbm1Cdb/qP+Q+5aR0DvVu0zaJLG
	dmni/+PytL0hjCb5c7+VV2kI2MjT5CgcHDXz6
X-Gm-Gg: AR+sD13FPed9hxwQHIW2YpH4CWliSH4G/CDY70Ev5Dtf+j/03tORr3YIy8++hISDMaI
	ijLHgt1wrLbtlkej/Paqp+ZB0J7ohALnipw5Ce6PiNktvpHfGVMltsXXYsAm1CGs9lppgXW0tDO
	SEYKdQyOh7LX71p8FPRkopSrZjLlxBUeGTPstNLC73NFy49zH+QbBCSRynaZH7hRIdJajhB0IS4
	UWWT1kNgWl68zNkkcWO/6ZOr9TpidVq4fANi/yB5I3KH8ErlH5/VHlPXjM768N93g1qU0/PufeX
	K1HKgxS8GFTbLeS1Xnxx/qyFnG+hhD+koZzLJoWEVSl1OAcBDOSyIcNL3Q==
X-Received: by 2002:a05:6a00:9090:b0:848:6e2d:2709 with SMTP id
 d2e1a72fcca58-84e932bbabdmr36270b3a.56.1785196610621; Mon, 27 Jul 2026
 16:56:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260722132424.450230-1-puranjay@kernel.org> <20260722132424.450230-5-puranjay@kernel.org>
In-Reply-To: <20260722132424.450230-5-puranjay@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 27 Jul 2026 16:56:25 -0700
X-Gm-Features: AUfX_mzw1RvQqP9NGFJ4XgNz6t-tKfOzSovShq-MPeqnZ_WkSZD2IamJqxpHRHQ
Message-ID: <CAEf4BzZAE9PWy4Y8VDLix=0uKoxGbK23Ln5rmDELBDDk1AFZLw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 4/6] bpf: Elide range checks when inlining
 bpf_iter_num_new() for constant bounds
To: Puranjay Mohan <puranjay@kernel.org>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 22, 2026 at 6:24=E2=80=AFAM Puranjay Mohan <puranjay@kernel.org=
> wrote:
>
> bpf_for() is frequently used with constant bounds, e.g. bpf_for(i, 0, N)
> with a literal N. In that case bpf_iter_num_new()'s start > end and
> range > BPF_MAX_LOOPS checks, and their error paths, are decidable at
> verification time and need not be emitted at all.
>
> Record, per call site, whether both the start and end arguments are
> constant with the same value on every visit, mirroring the state tracking
> bpf_loop() inlining already does. check_kfunc_call() stores this in
> bpf_insn_aux_data; the multi-visit merge matters because the same call
> site can be reached with different constants on different paths, in which
> case it falls back to the general sequence.
>
> The fold relies on the exact constant values, so the start and end
> registers are marked precise. Without that the verifier could prune a
> path reaching the call with different constants before the merge above
> sees it, and the folded code would run with a stale value.
>
> When the bounds are known, inline_bpf_iter_num_new() folds the checks and
> emits only the reachable tail: the iterator init for a valid range, or th=
e
> zeroing store plus the -EINVAL / -E2BIG result otherwise. The runtime
> behaviour is identical to the general sequence and to the kfunc.
>
> Suggested-by: Eduard Zingerman <eddyz87@gmail.com>
> Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
> ---
>  include/linux/bpf_verifier.h | 13 ++++++
>  kernel/bpf/verifier.c        | 76 +++++++++++++++++++++++++++++++++++-
>  2 files changed, 87 insertions(+), 2 deletions(-)
>

oh my goodness, please no. you are micro-optimizing
bpf_iter_num_new(), which is called just *ONCE* and adds all this
complexity. It's not worth it, at all. please drop.

the only comparison worth eliminating would be the one done in
bpf_iter_num_next, but you can't :)


> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> index 682c2cd3b8443..8c04e2fd80170 100644
> --- a/include/linux/bpf_verifier.h
> +++ b/include/linux/bpf_verifier.h
> @@ -612,6 +612,15 @@ struct bpf_loop_inline_state {
>         u32 callback_subprogno; /* valid when fit_for_inline is true */
>  };
>
> +struct bpf_iter_num_new_state {
> +       unsigned int initialized:1; /* set to true upon first entry */
> +       unsigned int fit_for_inline:1; /* true if start and end are const=
ant
> +                                       * with the same value at each cal=
l
> +                                       */
> +       s32 start; /* valid when fit_for_inline is true */
> +       s32 end;   /* valid when fit_for_inline is true */
> +};
> +
>  /* pointer and state for maps */
>  struct bpf_map_ptr_state {
>         struct bpf_map *map_ptr;
> @@ -661,6 +670,10 @@ struct bpf_insn_aux_data {
>                  * the state of the relevant registers to make decision a=
bout inlining
>                  */
>                 struct bpf_loop_inline_state loop_inline_state;
> +               /* if instruction is a call to bpf_iter_num_new this fiel=
d tracks its start/end
> +                * arguments to make a decision about eliding the range c=
hecks when inlining
> +                */
> +               struct bpf_iter_num_new_state iter_num_new_state;
>         };
>         union {
>                 /* remember the size of type passed to bpf_obj_new to rew=
rite R1 */
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index dec6bcba53a22..d5b73ae801944 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -12962,6 +12962,47 @@ static int check_special_kfunc(struct bpf_verifi=
er_env *env, struct bpf_call_arg
>
>  static int check_return_code(struct bpf_verifier_env *env, int regno, co=
nst char *reg_name);
>
> +/*
> + * bpf_iter_num_new() can be inlined more tightly when its start and end=
 arguments are constant,
> + * as the range checks and their error paths can then be resolved at rew=
rite time. Record, per
> + * call site, whether both arguments are constant with the same value on=
 every visit.
> + */
> +static int update_iter_num_new_state(struct bpf_verifier_env *env)
> +{
> +       struct bpf_iter_num_new_state *state =3D &cur_aux(env)->iter_num_=
new_state;
> +       struct bpf_reg_state *start_reg =3D &cur_regs(env)[BPF_REG_2];
> +       struct bpf_reg_state *end_reg =3D &cur_regs(env)[BPF_REG_3];
> +       bool known =3D tnum_is_const(start_reg->var_off) && tnum_is_const=
(end_reg->var_off);
> +       s32 start =3D start_reg->var_off.value;
> +       s32 end =3D end_reg->var_off.value;
> +       int err;
> +
> +       if (!state->initialized) {
> +               state->initialized =3D 1;
> +               state->fit_for_inline =3D known;
> +               state->start =3D start;
> +               state->end =3D end;
> +       } else if (state->fit_for_inline) {
> +               state->fit_for_inline =3D known && state->start =3D=3D st=
art && state->end =3D=3D end;
> +       }
> +
> +       /*
> +        * While folding is still viable the decision relies on the exact=
 constant values, so mark
> +        * the registers precise; otherwise the verifier could prune a pa=
th that reaches this call
> +        * with different constants and the folded code would run with a =
stale value.
> +        */
> +       if (state->fit_for_inline) {
> +               err =3D mark_chain_precision(env, BPF_REG_2);
> +               if (err)
> +                       return err;
> +               err =3D mark_chain_precision(env, BPF_REG_3);
> +               if (err)
> +                       return err;
> +       }
> +
> +       return 0;
> +}
> +
>  static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_ins=
n *insn,
>                             int *insn_idx_p)
>  {
> @@ -13163,6 +13204,12 @@ static int check_kfunc_call(struct bpf_verifier_=
env *env, struct bpf_insn *insn,
>                 }
>         }
>
> +       if (meta.func_id =3D=3D special_kfunc_list[KF_bpf_iter_num_new]) =
{
> +               err =3D update_iter_num_new_state(env);
> +               if (err)
> +                       return err;
> +       }
> +
>         for (i =3D 0; i < CALLER_SAVED_REGS; i++) {
>                 u32 regno =3D caller_saved[i];
>
> @@ -19774,10 +19821,34 @@ static void __fixup_collection_insert_kfunc(str=
uct bpf_insn_aux_data *insn_aux,
>   * Inline bpf_iter_num_new(). R1 holds the pointer to the iterator, R2 a=
nd R3 hold the (int)
>   * start and end arguments. Keep in sync with the kfunc in kernel/bpf/bp=
f_iter.c.
>   */
> -static int inline_bpf_iter_num_new(struct bpf_insn *insn_buf)
> +static int inline_bpf_iter_num_new(struct bpf_insn *insn_buf, struct bpf=
_iter_num_new_state *state)
>  {
>         int i =3D 0;
>
> +       /*
> +        * When start and end are constant the range checks and their err=
or paths fold away,
> +        * leaving just the state init or the error result.
> +        */
> +       if (state->fit_for_inline) {
> +               s32 start =3D state->start, end =3D state->end;
> +
> +               if (start > end) {
> +                       /* s->cur =3D s->end =3D 0; return -EINVAL; */
> +                       insn_buf[i++] =3D BPF_ST_MEM(BPF_DW, BPF_REG_1, 0=
, 0);
> +                       insn_buf[i++] =3D BPF_MOV64_IMM(BPF_REG_0, -EINVA=
L);
> +               } else if ((s64)end - (s64)start > BPF_MAX_LOOPS) {
> +                       /* s->cur =3D s->end =3D 0; return -E2BIG; */
> +                       insn_buf[i++] =3D BPF_ST_MEM(BPF_DW, BPF_REG_1, 0=
, 0);
> +                       insn_buf[i++] =3D BPF_MOV64_IMM(BPF_REG_0, -E2BIG=
);
> +               } else {
> +                       /* s->cur =3D start - 1; s->end =3D end; return 0=
; */
> +                       insn_buf[i++] =3D BPF_ST_MEM(BPF_W, BPF_REG_1, 0,=
 start - 1);
> +                       insn_buf[i++] =3D BPF_ST_MEM(BPF_W, BPF_REG_1, 4,=
 end);
> +                       insn_buf[i++] =3D BPF_MOV64_IMM(BPF_REG_0, 0);
> +               }
> +               return i;
> +       }
> +
>         /* if (start > end) goto einval; */
>         insn_buf[i++] =3D BPF_JMP32_REG(BPF_JSGT, BPF_REG_2, BPF_REG_3, 8=
);
>         /*
> @@ -19979,7 +20050,8 @@ int bpf_fixup_kfunc_call(struct bpf_verifier_env =
*env, struct bpf_insn *insn,
>                 insn_buf[5] =3D BPF_ALU64_IMM(BPF_NEG, BPF_REG_0, 0);
>                 *cnt =3D 6;
>         } else if (desc->func_id =3D=3D special_kfunc_list[KF_bpf_iter_nu=
m_new]) {
> -               *cnt =3D inline_bpf_iter_num_new(insn_buf);
> +               *cnt =3D inline_bpf_iter_num_new(insn_buf,
> +                                              &env->insn_aux_data[insn_i=
dx].iter_num_new_state);
>         } else if (desc->func_id =3D=3D special_kfunc_list[KF_bpf_iter_nu=
m_next]) {
>                 *cnt =3D inline_bpf_iter_num_next(insn_buf);
>         } else if (desc->func_id =3D=3D special_kfunc_list[KF_bpf_iter_nu=
m_destroy]) {
> --
> 2.53.0-Meta
>
