Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC13D472782
	for <bpf@vger.kernel.org>; Fri,  5 Jun 2026 07:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780644186; cv=none; b=jZWPmggfzeAh/XI9CLsEjVAWX7zLU57YxJkuSZMtwSFGkU0vY7325ibGJf4SyMUidLbQqgzQcwa9iTgyWOG8AMpE/IvNVs7XybnK427PoZnPudLOMXDS/G/g21WfnWe3AA/VA66jjFbNYqbEtMAxoe6T6WdY8fsv9bSRWgKKvZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780644186; c=relaxed/simple;
	bh=M7JZtJz43HVdcP9Se9l+lYMdEFeye4R8jhM74WtkC+g=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=bZYPLLibBxADQ87LEOd3TE3166h87RYwe/85PafyD+Zzc6QTv2kEe69mF2sFtayTALAlESXOY+mglhWYUcYCMVat3FYV1ovi+XaftdzFLGhWA85TbjwGpWBLOdOkiYJuTxYOO0Y+wn8AmEGOjl/IIU2sCPy3BdC3VgsPnQy2C0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C3rRCe2f; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C3rRCe2f"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4865C1F00898;
	Fri,  5 Jun 2026 07:23:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780644185;
	bh=qP0LTxQK7Cz3SRBnJDcdWoldeufqYnRPG1Pczp0VC+0=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=C3rRCe2f0V6Oy80zLsKo89J4UWYlbVS24Ql8xeYJ0D26Ew9HhAMg1ii6GOpqwXca/
	 ghcZ20EpvSBSlu5KzxyDQ9dyyzoExhP9/kry3DqhkQOtojYbS20O+b/iZKvLGx9ax2
	 5fepauvxcUG9ol1U2kLjfo+ziYd8n6h457JPz+w4jBjHDZhPOqftGhmBrduMBEX3NJ
	 oVRw/i/laA0m3nASABB4X7nA0PIWdJciSu6g4H+p7v3Burs0N3NN0CU8+RsYWta2yl
	 r9sp+9OZM7GVQydNcbElQBfbMgdor994ORZMZm3HHnA41tfGmc8NAtwpvuMqnoeXz/
	 VbxTYVoEv+25w==
Content-Type: multipart/mixed; boundary="===============2845680261476517435=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <39011cf3f56398b67c3b787d866a7d9a60e8a30fccdc82fdf14b37e0e8c1d1b7@mail.kernel.org>
In-Reply-To: <20260605063412.974640-12-memxor@gmail.com>
References: <20260605063412.974640-12-memxor@gmail.com>
Subject: Re: [PATCH bpf-next v1 11/17] bpf: Report Call Type Safety argument errors
From: bot+bpf-ci@kernel.org
To: memxor@gmail.com,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,emil@etsalapatis.com,kkd@meta.com,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Fri,  5 Jun 2026 07:23:05 +0000 (UTC)

--===============2845680261476517435==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/diagnostics.c b/kernel/bpf/diagnostics.c
> index 369b7813b5dc..169c1a2425c8 100644
> --- a/kernel/bpf/diagnostics.c
> +++ b/kernel/bpf/diagnostics.c
> @@ -714,6 +714,43 @@ static const char *bpf_diag_arg_ordinal(int argno)
>  	}
>  }
>
> +void bpf_diag_report_call_type(struct bpf_verifier_env *env, u32 insn_idx,
> +			       int regno, const char *call_name,
> +			       const char *arg_name, const char *reason,
> +			       const char *suggestion)
> +{
> +	struct bpf_diag_history_opts opts = {
> +		.scope = BPF_DIAG_HISTORY_SCOPE_REG,
> +		.frameno = bpf_diag_current_frameno(env),
> +		.regno = regno,
> +	};
> +	const char *ordinal = bpf_diag_arg_ordinal(regno);
> +	char arg_desc[48];

For arguments > 5, reg_from_argno() returns -1, which is passed here as
regno. Calling bpf_diag_arg_ordinal(-1) returns NULL, even though it
appears designed to handle up to 12 arguments.

This drops the ordinal string for stack arguments. Looking at the code:

	if (ordinal && arg_name)
		scnprintf(arg_desc, sizeof(arg_desc), "%s argument (%s)",
			  ordinal, arg_name);
	else if (arg_name)
		scnprintf(arg_desc, sizeof(arg_desc), "argument %s", arg_name);

When ordinal is NULL, the message falls through to "argument %s", losing
the position information.

Additionally, this breaks causal history tracking for stack arguments
since history is skipped when the regno >= 0 check fails:

	if (regno >= 0)
		bpf_diag_print_history(env, &opts);

Should this function receive argno instead of regno, or at least pass
argno directly to bpf_diag_arg_ordinal()?

Reference:
https://lore.kernel.org/bpf/20260605064700.A77A41F00893@smtp.kernel.org/

[ ... ]

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 1c26614bec2b..d2a776d2059c 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -8039,6 +8039,39 @@ static const struct bpf_reg_types *compatible_reg_types[__BPF_ARG_TYPE_MAX] = {
>  	[ARG_PTR_TO_DYNPTR]		= &dynptr_types,
>  };
>
> +static const char *bpf_diag_reg_type_plain(struct bpf_verifier_env *env,
> +					   enum bpf_reg_type type)
> +{
> +	switch (base_type(type)) {
> +	case NOT_INIT:
> +		return "an uninitialized value";
> +	case SCALAR_VALUE:
> +		return "an integer scalar";
> +	case PTR_TO_CTX:
> +		return "a context pointer";
> +	case PTR_TO_STACK:
> +		return "a stack pointer";
> +	case PTR_TO_MAP_VALUE:
> +		if (type_may_be_null(type))
> +			return "a nullable map value pointer";
> +		return "a map value pointer";
> +	case PTR_TO_MEM:
> +		if (type_may_be_null(type))
> +			return "a nullable memory pointer";
> +		return "a memory pointer";
> +	case PTR_TO_BTF_ID:
> +		if (type_is_non_owning_ref(type))
> +			return "a borrowed allocated object pointer";
> +		if (type_is_ptr_alloc_obj(type))
> +			return "an owned allocated object pointer";
> +		if (type_flag(type) & PTR_UNTRUSTED)
> +			return "an untrusted kernel object pointer";
> +		return "a kernel object pointer";

PTR_TO_MAP_VALUE and PTR_TO_MEM correctly identify nullable pointers
above, but PTR_TO_BTF_ID omits the check.

When a nullable PTR_TO_BTF_ID is passed to a helper expecting a
non-nullable pointer, it fails the type check in check_reg_type(), but
the error message will drop the 'nullable' qualifier.

This causes the verifier to report 'it has type a kernel object pointer,
but this helper argument accepts...', making the actual cause of the
rejection (nullability) very confusing for users.

Should this include:

	case PTR_TO_BTF_ID:
		if (type_may_be_null(type))
			return "a nullable kernel object pointer";
		if (type_is_non_owning_ref(type))
			return "a borrowed allocated object pointer";
		...

Reference:
https://lore.kernel.org/bpf/20260605064700.A77A41F00893@smtp.kernel.org/


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/27000182395
--===============2845680261476517435==--
