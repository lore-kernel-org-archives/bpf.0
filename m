Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ACA93546EB
	for <bpf@vger.kernel.org>; Sat,  5 Sep 2026 23:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788649710; cv=none; b=p2SsTVDItyVdtpUdHDZ4XkZUpTl16G1TFCqKDDuS60jlbhc6R07u1WY7GBVuVXhi61R7cc8XMw/csSLIpQIG7LTDYp+mJe5ulU5SpVIohk4RI7hgEjCMg5QJbCOYYMER8uoGG//Cm/hCvMX0np8F49BYHDhUIARKLNjyaL5BHeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788649710; c=relaxed/simple;
	bh=s39MNgajLIDr/x9opwokpUWmmTzdvZLt6SQEtby92E4=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=WmSbaOIibg+nvjV5T/2hoQrQW2rvJfVVRQRGAzdRftZNtgPHYJnmZE/IgSeFidhC+mc5b+PYz+T6u+kHoMZInxP6YSHDDR+zdYPILl/8EcoLh+tsm2iyCVosPtMuBh/gFltbY04nXrQ6HfbBkbMGlIbJkPOWEH2Hasaeocn4xxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P8do2bBg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P8do2bBg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D7761F00A3D;
	Sat,  5 Sep 2026 23:08:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788649708;
	bh=e+t1liCxPkWd7/26M6hrnXkX8bw/Lf3GuXCkkSUI6nI=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=P8do2bBgCaGoIe234MNgKP92Yddz9tDJ5hc1N7JggnA0aNwR1gtwUJOBYHWJFJzWs
	 rZap4qiUwJU5/cSNTJvCE8hbpnS0Uu4LbwoQTaQOmBXAg0QnSTwTfs8XMojkCccTF1
	 fCyjFLPups/kUdmJhdfEnGHfZ2X3lKtomp+67JwBWklyQrdIXZnLFdquonycDO4fyv
	 pqVd5z61nrC7A3y7tZ+/i5A7MpCkJCi14pY0jvytg7FEiKN18hSZmtnQAe+D2qVcJi
	 RR6JcA2CN7gy/G7Ca8p5ZbpZlha3ldrZiw6/vGO+Xra92/X54nyScUVUv/xSQ4cI1T
	 rEMf+0cWS3hmA==
Content-Type: multipart/mixed; boundary="===============5853405701909201058=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <5189666ade3136d3ff5f5d8cc75a7ef57dbe2e4cc6c0cb9fec73024dfabc655a@mail.kernel.org>
In-Reply-To: <20260905220117.922028-7-ameryhung@gmail.com>
References: <20260905220117.922028-7-ameryhung@gmail.com>
Subject: Re: [PATCH bpf-next v1 06/22] bpf: Unify kfunc argument kinds with enum bpf_arg_type
From: bot+bpf-ci@kernel.org
To: ameryhung@gmail.com,bpf@vger.kernel.org
Cc: alexei.starovoitov@gmail.com,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,memxor@gmail.com,ameryhung@gmail.com,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Sat,  5 Sep 2026 23:08:28 +0000 (UTC)

--===============5853405701909201058==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 1574fe2d8cc0..f620920ea575 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -908,6 +908,20 @@ enum bpf_arg_type {
>  	ARG_PTR_TO_TIMER,	/* pointer to bpf_timer */
>  	ARG_KPTR_XCHG_DEST,	/* pointer to destination that kptrs are bpf_kptr_xchg'd into */
>  	ARG_PTR_TO_DYNPTR,      /* pointer to bpf_dynptr. See bpf_type_flag for dynptr type */
> +
> +	ARG_CONST_SCALAR,	/* scalar known at verification time */
> +	ARG_CONST_MEM_SIZE,	/* ARG_MEM_SIZE that must be constant */
> +	ARG_PTR_TO_ALLOC_BTF_ID,	/* pointer to an allocated object */
> +	ARG_PTR_TO_REFCOUNTED_KPTR,	/* pointer to a refcounted local kptr */
> +	ARG_PTR_TO_ITER,	/* pointer to an iterator */
> +	ARG_PTR_TO_LIST_HEAD,	/* pointer to bpf_list_head */
> +	ARG_PTR_TO_LIST_NODE,	/* pointer to bpf_list_node */
> +	ARG_PTR_TO_RB_ROOT,	/* pointer to bpf_rb_root */
> +	ARG_PTR_TO_RB_NODE,	/* pointer to bpf_rb_node */
> +	ARG_PTR_TO_WORKQUEUE,	/* pointer to bpf_wq */
> +	ARG_PTR_TO_TASK_WORK,	/* pointer to bpf_task_work */
> +	ARG_PTR_TO_IRQ_FLAG,	/* pointer to saved IRQ flags on the stack */
> +	ARG_PTR_TO_RES_SPIN_LOCK,	/* pointer to bpf_res_spin_lock */
>  	__BPF_ARG_TYPE_MAX,
>
>  	/* Extended arg_types. */

[ ... ]

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index d444e72fdd97..a0a74a5e23be 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -8533,10 +8533,9 @@ reg_find_field_offset(const struct bpf_reg_state *reg, s32 off, u32 fields)
>  	return field;
>  }
>
> -static int __check_func_arg_reg_off(struct bpf_verifier_env *env,
> -				    const struct bpf_reg_state *reg, argno_t argno,
> -				    enum bpf_arg_type arg_type,
> -				    bool btf_id_fixed_off_ok)
> +static int check_func_arg_reg_off(struct bpf_verifier_env *env,
> +				  const struct bpf_reg_state *reg, argno_t argno,
> +				  enum bpf_arg_type arg_type)
>  {
>  	u32 type = reg->type;
>
> @@ -8592,12 +8591,15 @@ static int __check_func_arg_reg_off(struct bpf_verifier_env *env,
>  	case PTR_TO_BTF_ID | MEM_ALLOC | NON_OWN_REF:
>  	case PTR_TO_BTF_ID | MEM_ALLOC | NON_OWN_REF | MEM_RCU:
>  		/* When referenced PTR_TO_BTF_ID is passed to release function,
> -		 * its fixed offset must be 0. In the other cases, fixed offset
> -		 * can be non-zero unless the caller requires otherwise.
> -		 * var_off always must be 0 for PTR_TO_BTF_ID, hence we still
> -		 * need to do checks instead of returning.
> +		 * its fixed offset must be 0. bpf_refcount_acquire() returns the
> +		 * pointer it was given while incrementing the refcount at the
> +		 * refcount field offset, so it needs a zero offset too. In the
> +		 * other cases, fixed offset can be non-zero. var_off always must
> +		 * be 0 for PTR_TO_BTF_ID, hence we still need to do checks
> +		 * instead of returning.
>  		 */
> -		return __check_ptr_off_reg(env, reg, argno, btf_id_fixed_off_ok);
> +		return __check_ptr_off_reg(env, reg, argno,
> +					   base_type(arg_type) != ARG_PTR_TO_REFCOUNTED_KPTR);
>  	case PTR_TO_CTX:
>  		/*
>  		 * Allow fixed and variable offsets for syscall context, but
> @@ -8613,13 +8615,6 @@ static int __check_func_arg_reg_off(struct bpf_verifier_env *env,
>  	}
>  }
>
> -static int check_func_arg_reg_off(struct bpf_verifier_env *env,
> -				  const struct bpf_reg_state *reg, argno_t argno,
> -				  enum bpf_arg_type arg_type)
> -{
> -	return __check_func_arg_reg_off(env, reg, argno, arg_type, true);
> -}
> -

[ ... ]

> @@ -11793,34 +11788,6 @@ static void btf_member_path_str(const struct btf *btf, const struct btf_member_p
>  	}
>  }
>
> -enum kfunc_ptr_arg_type {
> -	KF_ARG_CONST_MEM_SIZE,
> -	KF_ARG_MEM_SIZE,
> -	KF_ARG_CONST,
> -	KF_ARG_CONST_ALLOC_SIZE_OR_ZERO,
> -	KF_ARG_ANYTHING,
> -	KF_ARG_PTR_TO_CTX,
> -	KF_ARG_PTR_TO_ALLOC_BTF_ID,    /* Allocated object */
> -	KF_ARG_PTR_TO_REFCOUNTED_KPTR, /* Refcounted local kptr */
> -	KF_ARG_PTR_TO_DYNPTR,
> -	KF_ARG_PTR_TO_ITER,
> -	KF_ARG_PTR_TO_LIST_HEAD,
> -	KF_ARG_PTR_TO_LIST_NODE,
> -	KF_ARG_PTR_TO_BTF_ID,	       /* Also covers reg2btf_ids conversions */
> -	KF_ARG_PTR_TO_MEM,
> -	KF_ARG_PTR_TO_CALLBACK,
> -	KF_ARG_PTR_TO_RB_ROOT,
> -	KF_ARG_PTR_TO_RB_NODE,
> -	KF_ARG_PTR_TO_CONST_STR,
> -	KF_ARG_CONST_MAP_PTR,
> -	KF_ARG_PTR_TO_TIMER,
> -	KF_ARG_PTR_TO_WORKQUEUE,
> -	KF_ARG_PTR_TO_IRQ_FLAG,
> -	KF_ARG_PTR_TO_RES_SPIN_LOCK,
> -	KF_ARG_PTR_TO_TASK_WORK,
> -	KF_ARG_PTR_TO_ARENA,
> -};
> -

This deletion removes KF_ARG_PTR_TO_REFCOUNTED_KPTR from the tree. Does
the kerneldoc comment in include/linux/bpf_verifier.h for struct
bpf_call_arg_meta need updating? It still refers to the deleted name:

    /* arg_{btf,btf_id,owning_ref} are used by kfunc-specific handling,
     * ...
     *   bpf_refcount_acquire (via KF_ARG_PTR_TO_REFCOUNTED_KPTR arg type)
     */

The replacement is ARG_PTR_TO_REFCOUNTED_KPTR.

[ ... ]

> @@ -12826,13 +12793,11 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_call_arg_me
>  	 */
>  	for (i = 0; i < nargs; i++) {
>  		struct bpf_reg_state *reg = get_func_arg_reg(caller, regs, i);
> +		enum bpf_arg_type arg_type = meta->fn->arg_type[i];
>  		const struct btf_type *t, *ref_t, *resolve_ret;
> -		enum bpf_arg_type arg_type = ARG_UNUSED;
>  		argno_t argno = argno_from_arg(i + 1);
>  		int regno = reg_from_argno(argno);
> -		bool btf_id_fixed_off_ok = true;
>  		u32 ref_id = args[i].type, type_size;
> -		int kf_arg_type = meta->fn->arg_type[i];

[ ... ]

> @@ -12901,54 +12866,14 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_call_arg_me
>  			ref_tname = btf_name_by_offset(btf, ref_t->name_off);
>  		}
>
> -		switch (base_type(kf_arg_type)) {
> -		case KF_ARG_CONST:
> -		case KF_ARG_CONST_MEM_SIZE:
> -		case KF_ARG_MEM_SIZE:
> -		case KF_ARG_ANYTHING:
> -		case KF_ARG_CONST_ALLOC_SIZE_OR_ZERO:
> -		case KF_ARG_PTR_TO_ALLOC_BTF_ID:
> -		case KF_ARG_PTR_TO_BTF_ID:
> -		case KF_ARG_CONST_MAP_PTR:
> -		case KF_ARG_PTR_TO_ITER:
> -		case KF_ARG_PTR_TO_LIST_HEAD:
> -		case KF_ARG_PTR_TO_LIST_NODE:
> -		case KF_ARG_PTR_TO_RB_ROOT:
> -		case KF_ARG_PTR_TO_RB_NODE:
> -		case KF_ARG_PTR_TO_MEM:
> -		case KF_ARG_PTR_TO_CALLBACK:
> -		case KF_ARG_PTR_TO_CONST_STR:
> -		case KF_ARG_PTR_TO_WORKQUEUE:
> -		case KF_ARG_PTR_TO_TIMER:
> -		case KF_ARG_PTR_TO_TASK_WORK:
> -		case KF_ARG_PTR_TO_IRQ_FLAG:
> -		case KF_ARG_PTR_TO_RES_SPIN_LOCK:
> -		case KF_ARG_PTR_TO_ARENA:
> -			break;
> -		case KF_ARG_PTR_TO_DYNPTR:
> -			arg_type = ARG_PTR_TO_DYNPTR;
> -			break;
> -		case KF_ARG_PTR_TO_CTX:
> -			arg_type = ARG_PTR_TO_CTX;
> -			break;
> -		case KF_ARG_PTR_TO_REFCOUNTED_KPTR:
> -			arg_type = ARG_PTR_TO_BTF_ID;
> -			btf_id_fixed_off_ok = false;
> -			break;
> -		default:
> -			verifier_bug(env, "unknown kfunc arg type %d", kf_arg_type);
> -			return -EFAULT;
> -		}
> -
>  		if (regno == meta->release_regno)
>  			arg_type |= OBJ_RELEASE;
> -		ret = __check_func_arg_reg_off(env, reg, argno, arg_type,
> -					       btf_id_fixed_off_ok);
> +		ret = check_func_arg_reg_off(env, reg, argno, arg_type);
>  		if (ret < 0)
>  			return ret;

Dropping the translation switch means check_func_arg_reg_off() now
receives the flag-carrying arg_type from get_kfunc_arg_type() instead of
a bare base type. Does this affect the PTR_TO_CTX case in that function?

Looking at check_func_arg_reg_off():

    case PTR_TO_CTX:
            if (arg_type != ARG_PTR_TO_CTX && is_var_ctx_off_allowed(env->prog))
                    return 0;

The test compares the full value rather than base_type(arg_type).
Before this commit, the translation switch assigned 'arg_type =
ARG_PTR_TO_CTX;' with no flags. After it, get_kfunc_arg_type() can
return ARG_PTR_TO_CTX | PTR_MAYBE_NULL for a context-typed kfunc
parameter carrying a '__nullable' suffix. In BPF_PROG_TYPE_SYSCALL
programs (the only program type where is_var_ctx_off_allowed() is true),
would a nullable ctx arg skip the __check_ptr_off_reg() call, taking the
'return 0' path instead of rejecting modified ctx pointers?

While this appears unreachable today (no in-tree kfunc has both a
context-typed parameter and a __nullable suffix), is the "No functional
change" claim literally exact, or would converting the test to
'base_type(arg_type) != ARG_PTR_TO_CTX' make the unification flag-safe?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/33995442755
--===============5853405701909201058==--
