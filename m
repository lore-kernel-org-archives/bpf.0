Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD99A12CDBE
	for <bpf@vger.kernel.org>; Tue, 28 Apr 2026 14:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777386607; cv=none; b=TxEk0brhz0KB5EjilC6YXKyLVahug50rHr44wKSs1/IrNEsJJkOZDc7vl7VcP7E66hGCc79jMY/H2gED8uyTAAMpiUqzne6Il1TfeynTbz7Zsrwe8fqaRcrITAd2FrdX5Sn0v5EC3tfB676Ly409H+XPyLvn4llYTDc2HsowDjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777386607; c=relaxed/simple;
	bh=FSGZ1SGxHMibjZFCxz/1q0wrKC71QhSmICK5eSKqKXg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WykGaHTwhQa+e0bgD+EykQTjHIuwP7DBt6tlPMv4hIzCe9Vyw03iQamGuXyc4YB9ZQSmYu4IOcyz2J0Rj03QDtzi+i7uK3lL6B2LCkzVA3f0Zqci4244CatAEtnaAtc5wsq8kBQHh3VK9x9dEGKdOsurvyYtBMKC4HyK7tcaxxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jMpubYbl; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jMpubYbl"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4896c22fcbaso86873915e9.0
        for <bpf@vger.kernel.org>; Tue, 28 Apr 2026 07:30:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777386600; x=1777991400; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0drQ7a8wVlSxUYVVyEbYTTxwkUV4vrkdH5enBmDtqbA=;
        b=jMpubYblzbnqr1DKpJoI2B+xfQtdz+ZXa2Kc3Caq0XVUVmfetZrTgsQUDm40kqp2/r
         TQGG5oiwfLt8O4n76Pq+iSyDUr5tWLwGoAzNk62GHB/8Io0oclWAo39d6v+aV7c/QCvk
         HBJgqLCcDXbhmgWSUOz4wD5fs5+wCGyusai2c/cX4T7paoY2EEq+PfdBKolb1yRrLsub
         qcqyQrBhIUrsPBcyeBdHHwHYrK0lXLbLB1Pmy9J77LGoogj9lRTVRMBgOm++XWo3XLoa
         IKYrHnv1ayuAsnFD8Yw9h+sC57nk8VU5aFLnnGOUVztz8fshq3bZwGzWAAv/KrlSXfpB
         vhYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777386600; x=1777991400;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0drQ7a8wVlSxUYVVyEbYTTxwkUV4vrkdH5enBmDtqbA=;
        b=p8NF72iXLBqmuP136YHtXhUqQuwKaEmM0mj6/B9u3fds5vXqAMY6p/TyDk1tfQzH8J
         Jjw/o8fYmHE4ZpMIQ4/ns3KP2tvwQ/HJdXPTvyiyGOYE2tRt+FGjplYw+WSdk1vGxxRt
         7RnEzpQ7e1LsS0ffSjLZraNA+7SW3q58wlYM1b6WyJOdU2hyXuG5Q6OJ2R5MIllwW0z3
         FboXAcIpY4qY2OiILAFNQk0T5/nTHPP9gkUqHB6Kt1ZOmD4mmN8K+4Prxz7e6+Qt+jdo
         3wfOaiSePqlg8Mi7KGauuA1Vf/9HbH5n84WwKZ+cla/p5/TlbBCqCjbQoMU9Gnym7oWa
         PLDg==
X-Forwarded-Encrypted: i=1; AFNElJ/kRmQvRps2jaMs6GGe364H5vwNtPbEsKj5ZRS+Rywh8adAfMkWz/aRYwjh6m0KHJaBAdc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYKh2Fun90L3B7vI+3+7d0sJ40AIwnR9tStUHWHBi4HSSIYMd1
	EFDZFU7gB6AZ0RI76SjhR9jXhQG6qctp0xtoXq5jkHcpRNbhNIhIgTOM
X-Gm-Gg: AeBDievmtWGh7K/wXkWCSZt4X6729jrb9u+pxoOgrpMPJJA8a//B8hW9zpMKpiY3bOh
	82Q33jESVmotmi8RVKDQLTtCA7MesmSaHU1fghvGhfc56umnZ3lRAfBK8ze+OWkj7mYVHwk6WkS
	rxZsP5BxzMgqMnIgAhsry0zSZvniPMF1Qz4/7jd7o+BrCC46QsP3TOW4lGJ0boB6B532is+RXkG
	H0qLnp7rsT2oh7BvZUDt16989g1rveyS68LZa4RnEVh668XGH8LJjM7sM+svtON7CWgbVziC+46
	9vcbaHbhP4sjpCus4940rvP3L1af2QfkjzvOgwHTLiuiQfZdPhiw8Sl0HbEspECb5NsALCcDMnJ
	1QQtffZz96T1cdcB5+HMtdpszUV1tna90E4OShBvCc17IDMc9+2o6LvwMn5ziD2AwN1P5DGH+tx
	25N13lqWwIAegO3gI8vnR1finf5uJkl0NLAgLZ3taeT+mbimdw3uGtSwD1JsWFDtZnwzyVD/VcE
	F+qEVi3XbLd4Wk7SXA=
X-Received: by 2002:a05:600c:4247:b0:48a:6fd4:d3d3 with SMTP id 5b1f17b1804b1-48a77b1e8a4mr26395695e9.20.1777386599436;
        Tue, 28 Apr 2026 07:29:59 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:1126:4:b8ec:c2c0:6f79:ba82? ([2620:10d:c092:500::5:e14b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a7aded70dsm2734655e9.34.2026.04.28.07.29.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 07:29:58 -0700 (PDT)
Message-ID: <7a031b0dcbf54e34d6a6571256b1bb65b5617bcc.camel@gmail.com>
Subject: Re: [PATCH bpf-next 01/18] bpf: Support stack arguments for bpf
 functions
From: Eduard Zingerman <eddyz87@gmail.com>
To: Yonghong Song <yonghong.song@linux.dev>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>, "Jose E .
 Marchesi" <jose.marchesi@oracle.com>, kernel-team@fb.com,  Martin KaFai Lau
 <martin.lau@kernel.org>
Date: Tue, 28 Apr 2026 07:29:57 -0700
In-Reply-To: <20260424171438.2034741-1-yonghong.song@linux.dev>
References: <20260424171433.2034470-1-yonghong.song@linux.dev>
	 <20260424171438.2034741-1-yonghong.song@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2026-04-24 at 10:14 -0700, Yonghong Song wrote:

[...]

I didn't see this in the patch, hence the question: should or should
not this feature be privileged bpf only?

[...]

> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> index d5b4303315dd..2cc349d7fc17 100644
> --- a/include/linux/bpf_verifier.h
> +++ b/include/linux/bpf_verifier.h

[...]

> @@ -508,6 +512,17 @@ struct bpf_verifier_state {
>  	     iter < frame->allocated_stack / BPF_REG_SIZE;		\
>  	     iter++, reg =3D bpf_get_spilled_reg(iter, frame, mask))
> =20
> +#define bpf_get_spilled_stack_arg(slot, frame, mask)                   \
> +	((((slot) < frame->out_stack_arg_depth / BPF_REG_SIZE) &&           \
> +	  (frame->stack_arg_regs[slot].type !=3D NOT_INIT))               \
> +	 ? &frame->stack_arg_regs[slot] : NULL)

can this be a static inline function?

> +
> +/* Iterate over 'frame', setting 'reg' to either NULL or a spilled stack=
 arg. */
> +#define bpf_for_each_spilled_stack_arg(iter, frame, reg, mask)         \
> +	for (iter =3D 0, reg =3D bpf_get_spilled_stack_arg(iter, frame, mask); =
\
> +	     iter < frame->out_stack_arg_depth / BPF_REG_SIZE;              \
> +	     iter++, reg =3D bpf_get_spilled_stack_arg(iter, frame, mask))
> +
>  #define bpf_for_each_reg_in_vstate_mask(__vst, __state, __reg, __mask, _=
_expr)   \
>  	({                                                               \
>  		struct bpf_verifier_state *___vstate =3D __vst;            \
> @@ -525,6 +540,11 @@ struct bpf_verifier_state {
>  					continue;                        \
>  				(void)(__expr);                          \
>  			}                                                \
> +			bpf_for_each_spilled_stack_arg(___j, __state, __reg, __mask) { \
> +				if (!__reg)                              \
> +					continue;                        \
> +				(void)(__expr);                          \
> +			}						 \
>  		}                                                        \
>  	})

Tangential nit: I think this macro is getting a bit too complicated,
we might want to introduce some proper reg_state iterator at some
point, e.g.:

  struct ret_iter it =3D new_reg_iter(state);
  while ((reg =3D next_reg(&it))) { ... }


> =20
> @@ -739,10 +759,13 @@ struct bpf_subprog_info {
>  	bool keep_fastcall_stack: 1;
>  	bool changes_pkt_data: 1;
>  	bool might_sleep: 1;
> -	u8 arg_cnt:3;
> +	u8 arg_cnt:4;
> =20
>  	enum priv_stack_mode priv_stack_mode;
> -	struct bpf_subprog_arg_info args[MAX_BPF_FUNC_REG_ARGS];
> +	struct bpf_subprog_arg_info args[MAX_BPF_FUNC_ARGS];
> +	u16 incoming_stack_arg_depth;

Can this be inferred from arg_cnt?
Also, the verifier keeps doing '/ BPF_REG_SIZE' on this number,
would it be more convenient to keep it as count?

> +	u16 stack_arg_depth; /* incoming + max outgoing */
> +	u16 max_out_stack_arg_depth;
>  };
> =20
>  struct bpf_verifier_env;
> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index 77af44d8a3ad..cfb35a2decf6 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -7880,13 +7880,19 @@ int btf_prepare_func_args(struct bpf_verifier_env=
 *env, int subprog)
>  	}
>  	args =3D (const struct btf_param *)(t + 1);
>  	nargs =3D btf_type_vlen(t);
> -	if (nargs > MAX_BPF_FUNC_REG_ARGS) {
> -		if (!is_global)
> -			return -EINVAL;
> -		bpf_log(log, "Global function %s() with %d > %d args. Buggy compiler.\=
n",
> +	if (nargs > MAX_BPF_FUNC_ARGS) {
> +		bpf_log(log, "Function %s() with %d > %d args not supported.\n",
> +			tname, nargs, MAX_BPF_FUNC_ARGS);

Nit: I'd report it as "kernel supports at-most %d parameters for regular fu=
nctions, while function %s is declared to accept %d parameters"
     just to make the rules a bit more explicit.

> +		return -EINVAL;
> +	}

[...]

> @@ -1378,9 +1382,21 @@ int bpf_fixup_call_args(struct bpf_verifier_env *e=
nv)
>  	struct bpf_prog *prog =3D env->prog;
>  	struct bpf_insn *insn =3D prog->insnsi;
>  	bool has_kfunc_call =3D bpf_prog_has_kfunc_call(prog);
> -	int i, depth;
> +	int depth;
>  #endif
> -	int err =3D 0;
> +	int i, err =3D 0;
> +
> +	for (i =3D 0; i < env->subprog_cnt; i++) {
> +		struct bpf_subprog_info *subprog =3D &env->subprog_info[i];
> +		u16 outgoing =3D subprog->stack_arg_depth - subprog->incoming_stack_ar=
g_depth;
> +
> +		if (subprog->max_out_stack_arg_depth > outgoing) {
> +			verbose(env,
> +				"func#%d writes stack arg slot at depth %u, but calls only require %=
u bytes\n",
> +				i, subprog->max_out_stack_arg_depth, outgoing);
> +			return -EINVAL;

Is this an internal error condition?
If it is, maybe use verifier_bug()?

> +		}
> +	}
> =20
>  	if (env->prog->jit_requested &&
>  	    !bpf_prog_is_offloaded(env->prog->aux)) {
> diff --git a/kernel/bpf/states.c b/kernel/bpf/states.c
> index 8478d2c6ed5b..3e59d1c3a726 100644
> --- a/kernel/bpf/states.c
> +++ b/kernel/bpf/states.c
> @@ -838,6 +838,34 @@ static bool stacksafe(struct bpf_verifier_env *env, =
struct bpf_func_state *old,
>  	return true;
>  }
> =20
> +/*
> + * Compare stack arg slots between old and current states.
> + * Outgoing stack args are path-local state and must agree for pruning.
> + */
> +static bool stack_arg_safe(struct bpf_verifier_env *env, struct bpf_func=
_state *old,
> +			   struct bpf_func_state *cur, struct bpf_idmap *idmap,
> +			   enum exact_level exact)
> +{
> +	int i, nslots;
> +
> +	nslots =3D min(old->out_stack_arg_depth, cur->out_stack_arg_depth) / BP=
F_REG_SIZE;

this is not safe, e.g. it will accept cur with one argument as
equivalent for old with two arguments.

> +	for (i =3D 0; i < nslots; i++) {
> +		struct bpf_reg_state *old_arg =3D &old->stack_arg_regs[i];
> +		struct bpf_reg_state *cur_arg =3D &cur->stack_arg_regs[i];
> +
> +		if (old_arg->type =3D=3D NOT_INIT && cur_arg->type =3D=3D NOT_INIT)
> +			continue;
> +
> +		if (exact =3D=3D EXACT && old_arg->type !=3D cur_arg->type)
> +			return false;
> +
> +		if (!regsafe(env, old_arg, cur_arg, idmap, exact))
> +			return false;
> +	}

regsafe() seem handles NOT_INIT and EXACT in the same way,
I don't think there is a necessity to do the handling explicitly here.

> +
> +	return true;
> +}
> +

[...]

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index ff6ff1c27517..bcf81692a22b 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -1361,6 +1361,18 @@ static int copy_stack_state(struct bpf_func_state =
*dst, const struct bpf_func_st
>  		return -ENOMEM;
> =20
>  	dst->allocated_stack =3D src->allocated_stack;
> +
> +	/* copy stack args state */
> +	n =3D src->out_stack_arg_depth / BPF_REG_SIZE;
> +	if (n) {
> +		dst->stack_arg_regs =3D copy_array(dst->stack_arg_regs, src->stack_arg=
_regs, n,
> +						 sizeof(struct bpf_reg_state),
> +						 GFP_KERNEL_ACCOUNT);
> +		if (!dst->stack_arg_regs)
> +			return -ENOMEM;
> +	}
> +
> +	dst->out_stack_arg_depth =3D src->out_stack_arg_depth;

Given that this is capped by 12, does it make sense to maintain the counter=
?
It might be simpler to always allocate an array of 12 elements.

>  	return 0;
>  }

[...]

> @@ -4417,6 +4446,109 @@ static int check_stack_write(struct bpf_verifier_=
env *env,
>  	return err;
>  }
> =20
> +/*
> + * Write a value to the outgoing stack arg area.
> + * off is a negative offset from r11 (e.g. -8 for arg6, -16 for arg7).
> + */
> +static int check_stack_arg_write(struct bpf_verifier_env *env, struct bp=
f_func_state *state,
> +				 int off, int value_regno)
> +{

Nit: Maybe replace value_regno with pointer to a register state?
     Just for consistency.

> +	int max_stack_arg_regs =3D MAX_BPF_FUNC_ARGS - MAX_BPF_FUNC_REG_ARGS;
> +	struct bpf_subprog_info *subprog =3D &env->subprog_info[state->subprogn=
o];
> +	int spi =3D -off / BPF_REG_SIZE - 1;
> +	struct bpf_func_state *cur;
> +	struct bpf_reg_state *arg;
> +	int err;
> +
> +	if (spi >=3D max_stack_arg_regs) {
> +		verbose(env, "stack arg write offset %d exceeds max %d stack args\n",
> +			off, max_stack_arg_regs);
> +		return -EINVAL;
> +	}
> +
> +	err =3D grow_stack_arg_slots(env, state, -off);
> +	if (err)
> +		return err;
> +
> +	/* Track the max outgoing stack arg access depth. */
> +	if (-off > subprog->max_out_stack_arg_depth)
> +		subprog->max_out_stack_arg_depth =3D -off;
> +
> +	cur =3D env->cur_state->frame[env->cur_state->curframe];
> +	if (value_regno >=3D 0) {
> +		state->stack_arg_regs[spi] =3D cur->regs[value_regno];

Nit: there is copy_register_state(), we should either use it here or
drop it and replace with direct assignments everywhere.

> +	} else {
> +		/* BPF_ST: store immediate, treat as scalar */
> +		arg =3D &state->stack_arg_regs[spi];
> +		arg->type =3D SCALAR_VALUE;
> +		__mark_reg_known(arg, env->prog->insnsi[env->insn_idx].imm);
> +	}
> +	state->no_stack_arg_load =3D true;
> +	return 0;
> +}
> +
> +/*
> + * Read a value from the incoming stack arg area.
> + * off is a positive offset from r11 (e.g. +8 for arg6, +16 for arg7).
> + */
> +static int check_stack_arg_read(struct bpf_verifier_env *env, struct bpf=
_func_state *state,
> +				int off, int dst_regno)
> +{
> +	struct bpf_subprog_info *subprog =3D &env->subprog_info[state->subprogn=
o];
> +	struct bpf_verifier_state *vstate =3D env->cur_state;
> +	int spi =3D off / BPF_REG_SIZE - 1;
> +	struct bpf_func_state *caller, *cur;
> +	struct bpf_reg_state *arg;
> +
> +	if (state->no_stack_arg_load) {
> +		verbose(env, "r11 load must be before any r11 store or call insn\n");
> +		return -EINVAL;
> +	}

I think the error message should be inverted, store should precede the load=
.
But tbh, I'd drop it altogether, the check right below should be sufficient=
.

> +
> +	if (off > subprog->incoming_stack_arg_depth) {
> +		verbose(env, "invalid read from stack arg off %d depth %d\n",
> +			off, subprog->incoming_stack_arg_depth);
> +		return -EACCES;
> +	}
> +
> +	caller =3D vstate->frame[vstate->curframe - 1];
> +	arg =3D &caller->stack_arg_regs[spi];
> +	cur =3D vstate->frame[vstate->curframe];
> +
> +	if (is_spillable_regtype(arg->type))
> +		copy_register_state(&cur->regs[dst_regno], arg);
> +	else
> +		mark_reg_unknown(env, cur->regs, dst_regno);

For stack writes we report error in such situations,
should the same be done here?

> +	return 0;
> +}
> +
> +static int check_outgoing_stack_args(struct bpf_verifier_env *env, struc=
t bpf_func_state *caller,
> +				     int nargs)
> +{
> +	int i, spi;
> +
> +	for (i =3D MAX_BPF_FUNC_REG_ARGS; i < nargs; i++) {
> +		spi =3D i - MAX_BPF_FUNC_REG_ARGS;
> +		if (spi >=3D (caller->out_stack_arg_depth / BPF_REG_SIZE) ||
> +		    caller->stack_arg_regs[spi].type =3D=3D NOT_INIT) {
> +			verbose(env, "stack %s not properly initialized\n",
> +				reg_arg_name(env, argno_from_arg(i + 1)));

Nit: error message is a bit confusing, I'd change it to better reflect the =
rules, e.g.:
     "function %s expects %d arguments, stack argument %d is not initialize=
d".

> +			return -EFAULT;
> +		}
> +	}
> +
> +	return 0;
> +}

[...]
