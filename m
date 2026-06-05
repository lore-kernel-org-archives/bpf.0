Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 189DE403E93
	for <bpf@vger.kernel.org>; Fri,  5 Jun 2026 06:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780642022; cv=none; b=HLW2Uj33/RXEZQ+yyOfoP3skNupLmE9Z/SlrganuGBg2tSmYyVB1LZ0aAODqz6yKUqQt8D2RT8qd8IIStkrLaDUdJTbOGxrtWqx0zYEis19O/wkO2zPtqK8E+nBfRfVrjri+nLPY2gXK7ngFyh1D9LfvNz1oFh7yJoDDXGjRo6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780642022; c=relaxed/simple;
	bh=SXaDOpgREBiGpVpn5F7/Tq+Z+ANrKReplJZXuD5ya7M=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=STu/7PZr4S/U2MfJFv26IPTfOtnL2VNHrdGAMfHR+WpKHBAOdvbOdzUkVxCc3IMCvHEi6P+FFgFL+VxzP5fqrocILR4BEk3wqwSOtpPJSGE5i80OCWIBZFj24bqxCB05ueW2FVdflb8eBLSWmINflKZaHX6gXoasxdIQonxvFus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N2dHapFJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N2dHapFJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A77A41F00893;
	Fri,  5 Jun 2026 06:47:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780642020;
	bh=KdW8UexgC/rJhOJWSfwj0qEEtXMKf2SwdvNHYQcFBg8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=N2dHapFJfCuzA4BwicoXUNbERAMClw01MOAprPlIwMsW05F2HWWOYtrv+eActWwi7
	 D23CEbVLYnLKi9gvX3GwylkxVTmtfq5t/ryDOlspjsFDmy8O9Rf+lymYLTBc9Rp7bl
	 8Zv2qx9uGG+W4Uyh+QSy65QdfQxb1dE9SarQz1GJiSm3gwe2LzQ6dFDJ6pkp/5Wh+J
	 YR0LH6NjXhOmW49KL9XHeqkVSPV2G5+bhKA8SpmctUCOyL2JdCTbwlv7XgYHU1F245
	 vzp8Y3aXRR0nuhovENsrL8rxS0c+gbDtqSEgpUJz+vjmoN4sm5b2blK8YwYJZ9xFS0
	 zDMSXPwjdGp1Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v1 11/17] bpf: Report Call Type Safety argument
 errors
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260605063412.974640-12-memxor@gmail.com>
References: <20260605063412.974640-12-memxor@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 05 Jun 2026 06:47:00 +0000
Message-Id: <20260605064700.A77A41F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] bpf_diag_report_call_type incorrectly uses a register number (re=
gno) instead of an argument ordinal, breaking diagnostic ordinals and dropp=
ing causal history tracking for stack arguments.
- [Medium] bpf_diag_reg_type_plain completely omits the 'nullable' qualifie=
r for PTR_TO_BTF_ID types, leading to highly confusing type-mismatch errors.
--

commit d36f4b9fea5180f51f3ba1c10068790e858fb646
Author: Kumar Kartikeya Dwivedi <memxor@gmail.com>

bpf: Report Call Type Safety argument errors

This commit augments selected helper and kfunc argument-contract failures
with Call Type Safety reports. It adds reason, source context, causal regis=
ter
history, and targeted suggestions to the verifier messages. The changes cov=
er
helper register-type mismatch, nullability requirements, release kfunc
requirements, and memory arguments.

> diff --git a/kernel/bpf/diagnostics.c b/kernel/bpf/diagnostics.c
> index 369b7813b5dcf..169c1a2425c8c 100644
> --- a/kernel/bpf/diagnostics.c
> +++ b/kernel/bpf/diagnostics.c
[ ... ]
> @@ -714,6 +714,43 @@ static const char *bpf_diag_arg_ordinal(int argno)
>  	}
>  }
> =20
> +void bpf_diag_report_call_type(struct bpf_verifier_env *env, u32 insn_id=
x,
> +			       int regno, const char *call_name,
> +			       const char *arg_name, const char *reason,
> +			       const char *suggestion)
> +{
> +	struct bpf_diag_history_opts opts =3D {
> +		.scope =3D BPF_DIAG_HISTORY_SCOPE_REG,
> +		.frameno =3D bpf_diag_current_frameno(env),
> +		.regno =3D regno,
> +	};
> +	const char *ordinal =3D bpf_diag_arg_ordinal(regno);

[Severity: Medium]
Will this return NULL and drop the ordinal string for stack arguments?

For arguments > 5, reg_from_argno() returns -1, which is passed here as
regno. Calling bpf_diag_arg_ordinal(-1) returns NULL, even though it appears
designed to handle up to 12 arguments.

Should we be passing argno instead of regno to bpf_diag_report_call_type(),
or at least passing argno directly to bpf_diag_arg_ordinal()?

> +	char arg_desc[48];
> +
> +	if (ordinal && arg_name)
> +		scnprintf(arg_desc, sizeof(arg_desc), "%s argument (%s)",
> +			  ordinal, arg_name);
> +	else if (arg_name)
> +		scnprintf(arg_desc, sizeof(arg_desc), "argument %s", arg_name);
> +	else
> +		scnprintf(arg_desc, sizeof(arg_desc), "argument");
> +
> +	bpf_diag_report_header(env, BPF_DIAG_CATEGORY_CALL_TYPE_SAFETY,
> +			       "invalid call argument");
> +	bpf_diag_report_reason(env,
> +			       "The %s to %s does not satisfy the verifier contract: %s.",
> +			       arg_desc, call_name, reason);
> +
> +	bpf_diag_report_section(env, "At");
> +	bpf_diag_report_source(env, insn_idx, '!',
> +			       "invalid %s for %s", arg_desc, call_name);
> +
> +	if (regno >=3D 0)
> +		bpf_diag_print_history(env, &opts);

[Severity: Medium]
Does this silently bypass causal history tracking for stack arguments?

Because regno evaluates to -1 for arguments > 5, this check skips printing
the history. Is it intentional to drop history tracking for stack arguments,
or can we add support to track their history?

> +
> +	bpf_diag_report_suggestion(env, "%s", suggestion);
> +}
> +
>  void bpf_diag_report_invalid_deref(struct bpf_verifier_env *env, u32 ins=
n_idx,
>  				   int regno, const char *reg_name,
>  				   const char *type_name,
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 1c26614bec2b7..d2a776d2059cc 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
[ ... ]
> @@ -8039,6 +8039,39 @@ static const struct bpf_reg_types *compatible_reg_=
types[__BPF_ARG_TYPE_MAX] =3D {
>  	[ARG_PTR_TO_DYNPTR]		=3D &dynptr_types,
>  };
> =20
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

[Severity: Medium]
Should we be checking type_may_be_null(type) for PTR_TO_BTF_ID types here?

PTR_TO_MAP_VALUE and PTR_TO_MEM correctly identify nullable pointers above,
but PTR_TO_BTF_ID omits the check.

When a nullable PTR_TO_BTF_ID is passed to a helper expecting a non-nullable
pointer, it fails the type check in check_reg_type(), but the error message
will drop the "nullable" qualifier. This causes the verifier to report "it
has type a kernel object pointer, but this helper argument accepts...", mak=
ing
the actual cause of the rejection (nullability) very confusing for users.

> +		if (type_is_ptr_alloc_obj(type))
> +			return "an owned allocated object pointer";
> +		if (type_flag(type) & PTR_UNTRUSTED)
> +			return "an untrusted kernel object pointer";
> +		return "a kernel object pointer";
> +	default:
> +		return reg_type_str(env, type);
> +	}
> +}
> +

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260605063412.9746=
40-1-memxor@gmail.com?part=3D11
