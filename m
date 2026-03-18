Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AB943AEF46
	for <bpf@vger.kernel.org>; Wed, 18 Mar 2026 14:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773842774; cv=none; b=eZdDtCcj2Kr/H9RgM2kA51NayZjXIhWjeXoCr4lXUBTeTxSiGFWk3i0uMI+pvd3V+C3kge+wPxnJEjLzrOSLyKTsWQJqF9YW7Fude3dIQLijDGS8ydcjMXZiVoeyhOV3vqbV/7CKen5RdtkRyUFYotc3xIKJbM5hXUm9LfCw4FU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773842774; c=relaxed/simple;
	bh=znMxnL330olbe//1OCnLgx8XAajyxmNoc9v76H7h5zY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=iYvGxKfnUses2p1xH9v6CaZjf2AsDaTEhvrRxO5/6yuhUGFocU+M5+255S8/UEeAqwjX2lFAP7pTfWJbTIbccoAvOgyTkmMNNUt6Sa7UjUb20I/lTroM96gnRc7ldrfkNa67y+xDhsmmumU5HGHtHekmbTa5+Qd9Np+8scOaBxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L68hneNy; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L68hneNy"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-439b9b1900bso4673281f8f.1
        for <bpf@vger.kernel.org>; Wed, 18 Mar 2026 07:06:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773842771; x=1774447571; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZGw0gn1umRfFDhf3UE64Wsqt3wk6bZ1F/PLpb8EJkTo=;
        b=L68hneNy3d2PHu4nTqkySzJmSWnBZdZ/2Pfo2tkYAa6eEDaxB5DZVGbq98wmr77kBR
         o2JuCD/dbTVuuuN4ju6R6sZ8J5hy+avNKkiqKYv6x4YeX3i3A9vCtgxu/EvYGcl57cBV
         XtWVrhw5SwZ8xduBaX5HdYU8NSTDI+QkhD2K79jobCZswnWvCJRpFHeTaBmIEy7uTcQp
         qa06gsx6DAyepUb5prwmunFKO4yOC/W6D2PV+aIij74EeFayixjMp1H5VNc1lkkJjXsP
         5MnJ6Kqv2XQJAQMgYoGFMrM5tsd3Iju0WdOSWXvvtBOfnmqV4CdMgn56kjxWvjkXZuCg
         2dfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773842771; x=1774447571;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZGw0gn1umRfFDhf3UE64Wsqt3wk6bZ1F/PLpb8EJkTo=;
        b=lHelxbH3qq3Y0VaV2N80UFa9fQHXUeoFMj46HvT17lvnOtc5/bWOr8sbWBXBqTAZ7K
         6Zbif4qOUdv0tTUkJX8J3SEUDFM7GEV/4Ak7kONL2occHVn11qpeKXxIkJz4DqpK2PHk
         DXAOCvhl8chM/5ZVx5ariQAdgylJJpetEfnrion+g7KX0tjjHjeWwN+1QGJDtSEVlviK
         ZF7Nb6CBpCiDN5lHDLBwQEKNkQjmFodFF+ansP52N66XU+fmCNBsU6DVX3HIzt/JluQn
         9SgEW15DZITf3lXoa8W9HIwpfHOwQ2miNv7Q5d5UUzI/aUCGfQlAPGS2gqLtjWWEc6yo
         1oKg==
X-Forwarded-Encrypted: i=1; AJvYcCVRx+f4qbWeT0SpK/FfKqmXVfzQa+NGANQerxI2DTIhUPX+6Ej5C6cYL8F1F6gxMrg/OgI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyek52gvzogR+hDZ8RL61+WfQ8aQoEahqMfxgbvHxjiAUhGArlX
	og3v5n+RKIjY6/5ZeYBPMhSN+tp6F5sR7zY+t1UXk0ARa4ggxbz8V/of
X-Gm-Gg: ATEYQzwDSr/Oh6XyUcTkA5vHulB0LtqLC2WCybsbO7uXxxEz1gSOF470Z9bzsd7rhSO
	djrJET5PJmqDB+JMGNKOgAjoF7qk44noIiiwO9sjXA+bPBDcGm3enyIrHW9pzw3X7UTDqi64OW6
	Q4jYf494gshugLTApWhmLzFL39sGI6LlHAbicut6fTMoS4v3EjtwILrEqNuVsiG371AUxfAw4hb
	p3uFxjGIwifzVMCFSGkjWQAKv+w8dQ8d2IE94Cm8Lh5JOr6asb4SffIF17z99ANNHbhyRjwPHCv
	l17mIFJ1aBpVMD5XE7pBeOana3eVOA/kJdSX9K/DGgan+OoUZMTu0rKEnOylxzXk2mkTSSr1YNw
	5U39Z7g7DT7HSS4BNnD5VDUY7FoNxSJQIOdsZ6gYIhoNSZyqEuMvFsolJdJ154FSiDIoo4ktApn
	i5AI6ycDUZjrbfL6gqQHGaMIm72vadMw/VuA==
X-Received: by 2002:a05:6000:1002:b0:43b:41df:705e with SMTP id ffacd0b85a97d-43b527d2f35mr4257339f8f.49.1773842770463;
        Wed, 18 Mar 2026 07:06:10 -0700 (PDT)
Received: from localhost ([2a01:4b00:bd1f:f500:f867:fc8a:5174:5755])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b5184962bsm8202705f8f.7.2026.03.18.07.06.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2026 07:06:10 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>, Dan Schatzberg <dschatzberg@meta.com>, Emil
 Tsalapatis <emil@etsalapatis.com>, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@kernel.org>, Eduard
 Zingerman <eddyz87@gmail.com>, kkd@meta.com, kernel-team@meta.com
Subject: Re: [PATCH bpf-next v3 1/3] bpf: Support variable offsets for
 syscall PTR_TO_CTX
In-Reply-To: <20260318103526.2590079-2-memxor@gmail.com>
References: <20260318103526.2590079-1-memxor@gmail.com>
 <20260318103526.2590079-2-memxor@gmail.com>
Date: Wed, 18 Mar 2026 14:06:09 +0000
Message-ID: <87cy11kzam.fsf@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Kumar Kartikeya Dwivedi <memxor@gmail.com> writes:

> Allow accessing PTR_TO_CTX with variable offsets in syscall programs.
> Fixed offsets are already enabled for all program types that do not
> convert their ctx accesses, since the changes we made in the commit
> de6c7d99f898 ("bpf: Relax fixed offset check for PTR_TO_CTX"). Note
> that we also lift the restriction on passing syscall context into
> helpers, which was not permitted before, and passing modified syscall
> context into kfuncs.
>
> The structure of check_mem_access can be mostly shared and preserved,
> but we must use check_mem_region_access to correctly verify access with
> variable offsets.
>
> The check made in check_helper_mem_access is hardened to only allow
> PTR_TO_CTX for syscall programs to be passed in as helper memory. This
> was the original intention of the existing code anyway, and it makes
> little sense for other program types' context to be utilized as a memory
> buffer. In case a convincing example presents itself in the future, this
> check can be relaxed further.
>
> We also no longer use the last-byte access to simulate helper memory
> access, but instead go through check_mem_region_access. Since this no
> longer updates our max_ctx_offset, we must do so manually, to keep track
> of the maximum offset at which the program ctx may be accessed.
>
> Take care to ensure that when arg_type is ARG_PTR_TO_CTX, we do not
> relax any fixed or variable offset constraints around PTR_TO_CTX even in
> syscall programs, and require them to be passed unmodified. There are
> several reasons why this is necessary. First, if we pass a modified ctx,
> then the global subprog's accesses will not update the max_ctx_offset to
> its true maximum offset, and can lead to out of bounds accesses. Second,
> tail called program (or extension program replacing global subprog) where
> their max_ctx_offset exceeds the program they are being called from can
> also cause issues. For the latter, unmodified PTR_TO_CTX is the first
> requirement for the fix, the second is ensuring max_ctx_offset >= the
> program they are being called from, which has to be a separate change
> not made in this commit.
>
> All in all, we can hint using arg_type when we expect ARG_PTR_TO_CTX and
> make our relaxation around offsets conditional on it.
>
> Cc: Tejun Heo <tj@kernel.org>
> Cc: Dan Schatzberg <dschatzberg@meta.com>
> Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---
>  kernel/bpf/verifier.c                         | 67 ++++++++++++-------
>  .../bpf/progs/verifier_global_subprogs.c      |  1 -
>  2 files changed, 43 insertions(+), 25 deletions(-)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 01c18f4268de..14bf64e0c600 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -7843,6 +7843,7 @@ static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, u32 regn
>  		 * Program types that don't rewrite ctx accesses can safely
>  		 * dereference ctx pointers with fixed offsets.
>  		 */
> +		bool var_off_ok = resolve_prog_type(env->prog) == BPF_PROG_TYPE_SYSCALL;
>  		bool fixed_off_ok = !env->ops->convert_ctx_access;
>  		struct bpf_retval_range range;
>  		struct bpf_insn_access_aux info = {
> @@ -7857,16 +7858,26 @@ static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, u32 regn
>  			return -EACCES;
>  		}
>  
> -		err = __check_ptr_off_reg(env, reg, regno, fixed_off_ok);
> -		if (err < 0)
> -			return err;
> -
>  		/*
>  		 * Fold the register's constant offset into the insn offset so
> -		 * that is_valid_access() sees the true effective offset.
> +		 * that is_valid_access() sees the true effective offset. If the
> +		 * register's offset is allowed to be variable, then the maximum
> +		 * possible offset is simulated (which is equal to var_off.value
> +		 * when var_off is constant).
>  		 */
> -		if (fixed_off_ok)
> -			off += reg->var_off.value;
> +		if (var_off_ok) {
> +			err = check_mem_region_access(env, regno, off, size, U16_MAX, false);
> +			if (err)
> +				return err;
> +			off += reg->umax_value;
> +		} else {
> +			err = __check_ptr_off_reg(env, reg, regno, fixed_off_ok);
> +			if (err < 0)
> +				return err;
> +			if (fixed_off_ok)
> +				off += reg->var_off.value;
> +		}
nit: this code looks a bit complex, I wonder if it makes sense to encode
the context offset mode into an enum:
enum bpf_ctx_allowed_off {
     CTX_OFF_VAR,
     CTX_OFF_FIXED,
     CTX_OFF_NONE
};

we can factor out a helper that returns allowed offset mode:
```
enum bpf_ctx_allowed_off get_context_allowed_offset(env)
{
        if (resolve_prog_type(env->prog) == BPF_PROG_TYPE_SYSCALL)
	        return CTX_OFF_VAR;
        else if (!env->ops->convert_ctx_access)
        	return CTX_OFF_FIXED;
        else
                return CTX_OFF_NONE;
}
```

The enum makes the three-way exclusive modes explicit, eliminates the
implicit priority and more self-documenting.

The enum can also be used below.

> +
>  		err = check_ctx_access(env, insn_idx, off, size, t, &info);
>  		if (err)
>  			verbose_linfo(env, insn_idx, "; ");
> @@ -8442,22 +8453,16 @@ static int check_helper_mem_access(struct bpf_verifier_env *env, int regno,
>  		return check_ptr_to_btf_access(env, regs, regno, 0,
>  					       access_size, BPF_READ, -1);
>  	case PTR_TO_CTX:
> -		/* in case the function doesn't know how to access the context,
> -		 * (because we are in a program of type SYSCALL for example), we
> -		 * can not statically check its size.
> -		 * Dynamically check it now.
> -		 */
> -		if (!env->ops->convert_ctx_access) {
Why did you remove this block here, it should correspond to fixed
offset, and is not processed in the resolve_prog_type(env->prog) ==
BPF_PROG_TYPE_SYSCALL) branch.
> -			int offset = access_size - 1;
> -
> -			/* Allow zero-byte read from PTR_TO_CTX */
> -			if (access_size == 0)
> -				return zero_size_allowed ? 0 : -EACCES;
> -
> -			return check_mem_access(env, env->insn_idx, regno, offset, BPF_B,
> -						access_type, -1, false, false);
> +		/* Only permit reading or writing syscall context using helper calls. */
> +		if (resolve_prog_type(env->prog) == BPF_PROG_TYPE_SYSCALL) {
If we introduce bpf_ctx_allowed_off enum, this check could be modified
to if (get_context_allowed_offset() == CTX_OFF_VAR) here and also in
other place as well, does it capture the logic better?
I'm not 100% sure if these use cases are worth adding a separate enum,
though, let me know what you think.
> +			int err = check_mem_region_access(env, regno, 0, access_size, U16_MAX,
> +							  zero_size_allowed);
> +			if (err)
> +				return err;
> +			if (env->prog->aux->max_ctx_offset < reg->umax_value + access_size)
> +				env->prog->aux->max_ctx_offset = reg->umax_value + access_size;
> +			return 0;
>  		}
> -
>  		fallthrough;
>  	default: /* scalar_value or invalid ptr */
>  		/* Allow zero-byte read from NULL, regardless of pointer type */
> @@ -9401,6 +9406,7 @@ static const struct bpf_reg_types mem_types = {
>  		PTR_TO_MEM | MEM_RINGBUF,
>  		PTR_TO_BUF,
>  		PTR_TO_BTF_ID | PTR_TRUSTED,
> +		PTR_TO_CTX,
>  	},
>  };
>  
> @@ -9710,6 +9716,17 @@ static int check_func_arg_reg_off(struct bpf_verifier_env *env,
>  		 * still need to do checks instead of returning.
>  		 */
>  		return __check_ptr_off_reg(env, reg, regno, true);
> +	case PTR_TO_CTX:
> +		/*
> +		 * Allow fixed and variable offsets for syscall context, but
> +		 * only when the argument is passed as memory, not ctx,
> +		 * otherwise we may get modified ctx in tail called programs and
> +		 * global subprogs (that may act as extension prog hooks).
> +		 */
> +		if (arg_type != ARG_PTR_TO_CTX &&
> +		    resolve_prog_type(env->prog) == BPF_PROG_TYPE_SYSCALL)
This looks like another instance where we check for prog_type==syscall,
but actually mean: is variable offset into ctx is allowed.
> +			return 0;
> +		fallthrough;
>  	default:
>  		return __check_ptr_off_reg(env, reg, regno, false);
>  	}
> @@ -10757,7 +10774,7 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env, int subprog,
>  			 * invalid memory access.
>  			 */
>  		} else if (arg->arg_type == ARG_PTR_TO_CTX) {
> -			ret = check_func_arg_reg_off(env, reg, regno, ARG_DONTCARE);
> +			ret = check_func_arg_reg_off(env, reg, regno, ARG_PTR_TO_CTX);
>  			if (ret < 0)
>  				return ret;
>  			/* If function expects ctx type in BTF check that caller
> @@ -13565,7 +13582,6 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
>  				}
>  			}
>  			fallthrough;
> -		case KF_ARG_PTR_TO_CTX:
>  		case KF_ARG_PTR_TO_DYNPTR:
>  		case KF_ARG_PTR_TO_ITER:
>  		case KF_ARG_PTR_TO_LIST_HEAD:
> @@ -13583,6 +13599,9 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
>  		case KF_ARG_PTR_TO_IRQ_FLAG:
>  		case KF_ARG_PTR_TO_RES_SPIN_LOCK:
>  			break;
> +		case KF_ARG_PTR_TO_CTX:
> +			arg_type = ARG_PTR_TO_CTX;
> +			break;
>  		default:
>  			verifier_bug(env, "unknown kfunc arg type %d", kf_arg_type);
>  			return -EFAULT;
> diff --git a/tools/testing/selftests/bpf/progs/verifier_global_subprogs.c b/tools/testing/selftests/bpf/progs/verifier_global_subprogs.c
> index f02012a2fbaa..2250fc31574d 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_global_subprogs.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_global_subprogs.c
> @@ -134,7 +134,6 @@ __noinline __weak int subprog_user_anon_mem(user_struct_t *t)
>  
>  SEC("?tracepoint")
>  __failure __log_level(2)
> -__msg("invalid bpf_context access")
>  __msg("Caller passes invalid args into func#1 ('subprog_user_anon_mem')")
>  int anon_user_mem_invalid(void *ctx)
>  {
> -- 
> 2.52.0
