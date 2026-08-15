Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54B4A3254A0
	for <bpf@vger.kernel.org>; Sat, 15 Aug 2026 07:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786780150; cv=none; b=XsEzwzTeiUTy0HlF4w3CPGnv2P/8+ndS2MztZ6EXlmoi1LR1VpzF/OpGO4YOlnfaPtwuEIrC3yHYgzS/e03jSrRVRS6yPJXZ20TKWYayg5chRBIT6Zov/i2A+XHOGiGgSIzKpSxKZcHZ1kDtyu7Kp7zf4pMV/T4DOTtWiN7aPHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786780150; c=relaxed/simple;
	bh=5q9RZHECsOEuYQ2q7oUhhEoIUsQdXKvr/q7z7hN41W8=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=bluob9NNDYy7pLXSmCKhtDGlVrkf5LeC1EYBtfEj4lqRvjMdc83ZT1VePOgeT3f6AnXvpfp0RWIzBvwcXEoBytzSZ63dRQez4yugWqnfw17yyeOqFKXEemGXf7tS+Hzmu0sDE4EQS6TexBl8lp5dbE9Cyyr5Gmytn/WqqtH58vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GHxF7z+d; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GHxF7z+d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A7FA1F000E9;
	Sat, 15 Aug 2026 07:49:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786780148;
	bh=Mw7vIEbofCaN4IsklwXZZI/tQGhkOBXinM/bSAsdSaA=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=GHxF7z+ded+RiTNiFrkPSVCqBLG5mOa/FTg8CvzpZ6opaR0gcxs33xX1htJa5s6aW
	 hNF71klNvnXLwQKQSn9HgprbgfO0ZNSNafjZzLkXQmonjsrqOuZdl11uqEpWC/t1P3
	 JERnspb36hjpG3SRVGH7QJO6eNrOp3x8UyImE2Cp1wJ9OkKQiMPbxkYRRzq7z0veCm
	 w7ZVUG6xVwZaUA8IHf/yiN70VJUVtMeR0UkMki1y2KKjyiWJqMerDCdMSuKx+8AuGj
	 7mbxJUft/iQ4Ef16+q7Sgti+/PE+ExboZHaVoQK7rLI644HWgo+OgIMVtrEq9j2XFa
	 gG0Q8zWP1+Riw==
Content-Type: multipart/mixed; boundary="===============6400495832891283493=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <3eda33675965763aa9b2e6a5784f32b34a6a83988a55fbea98b0dbd0cf3b088d@mail.kernel.org>
In-Reply-To: <20260815064612.378577-12-memxor@gmail.com>
References: <20260815064612.378577-12-memxor@gmail.com>
Subject: Re: [PATCH bpf-next v5 11/14] bpf: Report Call Type Safety argument errors
From: bot+bpf-ci@kernel.org
To: memxor@gmail.com,bpf@vger.kernel.org
Cc: eddyz87@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,emil@etsalapatis.com,kkd@meta.com,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Sat, 15 Aug 2026 07:49:08 +0000 (UTC)

--===============6400495832891283493==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/diagnostics.c b/kernel/bpf/diagnostics.c
> index 5d20ea9e470e..99784d465881 100644
> --- a/kernel/bpf/diagnostics.c
> +++ b/kernel/bpf/diagnostics.c

[ ... ]

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index f5bf8cf644b8..2c067be53106 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[ ... ]

> @@ -12417,29 +12552,43 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_call_arg_me
>
>  	t = btf_type_skip_modifiers(btf, args[i].type, NULL);
>
> -	if (btf_type_is_ptr(t) && (bpf_register_is_null(reg) || type_may_be_null(reg->type)) &&
> +	if (btf_type_is_ptr(t)) {
> +		ref_t = btf_type_skip_modifiers(btf, t->type, &ref_id);
> +		ref_tname = btf_name_by_offset(btf, ref_t->name_off);
> +	}
> +
> +	if (btf_type_is_ptr(t) &&
> +	    (bpf_register_is_null(reg) || type_may_be_null(reg->type)) &&
>  	    !type_may_be_null(kf_arg_type)) {
> +		const char *expected_type;
> +
> +		expected_type = bpf_diag_fmt_btf_type(env, btf, ref_id);
>  		verbose(env, "Possibly NULL pointer passed to trusted %s\n",
>  			reg_arg_name(env, argno));
> +		bpf_diag_call_arg_fmt(env, insn_idx, argno, func_name,
> +				      "Add a NULL check and call the kfunc only on the non-NULL path.",
> +				      "the pointer may be NULL, but this kfunc requires a non-NULL pointer to %s",
> +				      expected_type);
>  		return -EACCES;
>  	}
>
>  	if (regno == meta->release_regno && !is_kfunc_arg_dynptr(meta->btf, &args[i]) &&
>  	    !reg_is_referenced(env, reg) && !bpf_register_is_null(reg)) {
> +		const char *expected_type;
> +
> +		expected_type = bpf_diag_fmt_btf_type(env, btf, ref_id);
>  		verbose(env, "release kfunc %s expects referenced PTR_TO_BTF_ID passed to %s\n",
>  			func_name, reg_arg_name(env, argno));
> +		bpf_diag_call_arg_fmt(env, insn_idx, argno, func_name,
> +				      "Pass the resource-owning pointer returned by the matching acquire kfunc, and avoid calling the release kfunc after ownership has already been transferred or released.",
> +				      "release kfuncs require a resource-owning value of type %s returned by a matching acquire kfunc",
> +				      expected_type);
>  		return -EINVAL;
>  	}

When the kfunc parameter is a plain void*, will bpf_diag_fmt_btf_type()
format it correctly? For a void* parameter, ref_id becomes 0 after
btf_type_skip_modifiers() and bpf_diag_fmt_btf_type() produces the
literal string "()" for type ID 0.

This affects in-tree kfuncs like bpf_copy_from_user_str() (void *dst,
u64 dst__sz, ...) where the first argument takes a non-nullable void*.
A program passing an unchecked bpf_map_lookup_elem() result would see:

  "The first argument (R1) to bpf_copy_from_user_str does not satisfy
  the verifier contract: the pointer may be NULL, but this kfunc
  requires a non-NULL pointer to ()."

The pointee type name is already available in scope as ref_tname, which
the adjacent terse verbose() messages use.

> @@ -12499,35 +12648,67 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_call_arg_me
>  	case KF_ARG_CONST:
>  		if (reg->type != SCALAR_VALUE) {
>  			verbose(env, "%s is not a scalar\n", reg_arg_name(env, argno));
> +			bpf_diag_call_arg_fmt(env, insn_idx, argno, func_name,
> +					      "Pass an integer scalar value for this argument, not a pointer or resource object.",
> +					      "the kfunc expects an integer scalar, but %s is %s",
> +					      reg_arg_name(env, argno),
> +					      bpf_diag_reg_type_plain(env, reg->type));
>  			return -EINVAL;
>  		}
>
>  		ret = process_const_arg(env, reg, argno, meta);
> -		if (ret < 0)
> +		if (ret < 0) {
> +			if (ret == -EINVAL)
> +				bpf_diag_call_arg_fmt(env, insn_idx, argno, func_name,
> +						      "Pass a compile-time constant or a value the verifier can prove is constant at this call.",
> +						      "the kfunc requires this scalar argument to be a verifier-known constant, but %s is variable on this path",
> +						      reg_arg_name(env, argno));
>  			return ret;
> +		}
>  		break;

[ ... ]

> @@ -12776,9 +13012,15 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_call_arg_me
>  		struct bpf_reg_state *buff_reg = get_func_arg_reg(caller, regs, i - 1);
>  		struct bpf_reg_state *size_reg = reg;
>  		argno_t buff_argno = argno_from_arg(i);
> +		enum bpf_mem_size_failure failure;
>
>  		if (reg->type != SCALAR_VALUE) {
>  			verbose(env, "%s is not a scalar\n", reg_arg_name(env, argno));
> +			bpf_diag_call_arg_fmt(env, insn_idx, argno, func_name,
> +					      "Pass an integer scalar length for this memory argument.",
> +					      "the kfunc expects a scalar memory size, but %s is %s",
> +					      reg_arg_name(env, argno),
> +					      bpf_diag_reg_type_plain(env, reg->type));
>  			return -EINVAL;
>  		}
>
> @@ -12786,11 +13028,34 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_call_arg_me
>  			break;
>
>  		ret = check_mem_size_reg(env, buff_reg, size_reg, buff_argno, argno,
> -					 BPF_READ | BPF_WRITE, true, meta);
> +					 BPF_READ | BPF_WRITE, true, meta, &failure);

Does the identical process_const_arg() failure in the KF_ARG_CONST case
above also need the Call Type Safety report? The KF_ARG_CONST_MEM_SIZE
case adds the report to its process_const_arg() -EINVAL path:

kernel/bpf/verifier.c:check_kfunc_args() {
    case KF_ARG_CONST:
        ...
        ret = process_const_arg(env, reg, argno, meta);
        if (ret < 0) {
            if (ret == -EINVAL)
                bpf_diag_call_arg_fmt(...);
            return ret;
        }
    ...
    case KF_ARG_CONST_MEM_SIZE:
        ret = process_const_arg(env, reg, argno, meta);
        if (ret < 0)
            return ret;       // no report here
        fallthrough;
    case KF_ARG_MEM_SIZE:
        ...
}

A program that passes a non-constant buffer__szk argument to
bpf_dynptr_slice() (which uses the '__szk' constant-size suffix) fails
with only the terse 'R4 must be a known constant' message, while the
immediately following KF_ARG_MEM_SIZE checks do emit structured reports.

> @@ -12804,8 +13069,15 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_call_arg_me
>  		break;
>  	case KF_ARG_PTR_TO_REFCOUNTED_KPTR:
>  		if (!type_is_ptr_alloc_obj(reg->type)) {
> +			const char *expected_type;
> +
> +			expected_type = bpf_diag_fmt_btf_type(env, btf, ref_id);
>  			verbose(env, "%s is neither owning or non-owning ref\n",
>  				reg_arg_name(env, argno));
> +			bpf_diag_call_arg_fmt(env, insn_idx, argno, func_name,
> +					      "Pass a pointer returned by the matching BPF object allocation or lookup operation for this kfunc.",
> +					      "the kfunc expects a pointer to BPF-managed refcounted object type %s, but this argument is not such an object pointer",
> +					      expected_type);
>  			return -EINVAL;
>  		}

Does this message render correctly for the actual refcounted_kptr
parameter? The KF_ARG_PTR_TO_REFCOUNTED_KPTR class is selected by the
parameter-name suffix '__refcounted_kptr', and the only in-tree kfunc
with such a parameter is:

kernel/bpf/helpers.c {
    void *bpf_refcount_acquire_impl(void *p__refcounted_kptr,
                                    void *meta__ign)
}

For this void* parameter, ref_id becomes 0 and bpf_diag_fmt_btf_type()
produces "()", so the message reads:

  "the kfunc expects a pointer to BPF-managed refcounted object type (),
  but this argument is not such an object pointer"

For a generic refcounted-kptr argument the expected type is a property
of the register (reg->btf/reg->btf_id), not of the kfunc prototype, so
ref_id cannot describe it.

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/31870608176
--===============6400495832891283493==--
