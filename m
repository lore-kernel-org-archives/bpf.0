Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0C593E49F4
	for <bpf@vger.kernel.org>; Sat, 15 Aug 2026 07:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786779284; cv=none; b=c8h5UiGg7QdDVuvZMQCJ2V6FZVOXRPszMmorBviJLckPXete53dfrUoFUQqA208rlvPVDYK3jS7LE3BMwZ7DgloTcm6242fYo3/GAXH4oMl195Yp+FQ7+OlJcTpYpa5eXwayEZA5vT0/u6Eo+bc4yBcw7jKDRjjMxcgcjrFRvQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786779284; c=relaxed/simple;
	bh=jQvwd6dM0cTY8nRtiuyxKuJs3Ya884itpG1o55Gy30c=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=N0hr8TwfxH3SFoEPcoGKoNXm5ssDFWqaA7Tlmbvnw1Ru4+BK/ho0PEGNBOhhxeFyaxzq2Z+dD/1mKVf2EqXdVz7zwXaEiMXSRIXakIsQf+DgbmG4zrEiVgCMy92P9tGeHUAww/F3ehB6E85L0f9yZncmWPImYfZ1y+6v91Fw1k4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JRxBn0WI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JRxBn0WI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6A8B1F000E9;
	Sat, 15 Aug 2026 07:34:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786779283;
	bh=DLg2QKPMa0NivfeDh0n8p7XvO5xCIJN/Jqjhs7g7fSY=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=JRxBn0WI3L/9xb5r1sAfOT8mrMMkyt05a9Yo0y/lsxqjQ6fYUIsxmz8haYjVrb+e9
	 vB67JzFWv5oN5myoiym9Fj5NElnxUnZCg+6ojz8R/L5CWauEkDjGKagQvCyP8Tqm9S
	 LWiVRBDVA3MlaCtfPATs24CjMTPIUEBqG/cfAdMVQwFp5g9VAJsszjfr7Alz4eftip
	 S9M9SgTzwSxy5J/tsn5yHsrNXnqBAuVKQdjl5ttL+ZQQVZcl5tUNHqrjg/LVP4AWWp
	 fHBsBM5sIbs3LRImTd13ilvpKnXv2cwOAKBiHK3h183Z70TntkZ9TyFoZXWdP6JTXT
	 iGvrmrmXNxGTQ==
Content-Type: multipart/mixed; boundary="===============4328045260132972321=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <85d734cb98ae3cf513fc1c123fb1666d6fe576f0afbe734b5058c37a850f53a6@mail.kernel.org>
In-Reply-To: <20260815064612.378577-9-memxor@gmail.com>
References: <20260815064612.378577-9-memxor@gmail.com>
Subject: Re: [PATCH bpf-next v5 08/14] bpf: Report Register Type Safety errors
From: bot+bpf-ci@kernel.org
To: memxor@gmail.com,bpf@vger.kernel.org
Cc: eddyz87@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,emil@etsalapatis.com,kkd@meta.com,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Sat, 15 Aug 2026 07:34:42 +0000 (UTC)

--===============4328045260132972321==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/diagnostics.c b/kernel/bpf/diagnostics.c

[ ... ]

> +static int diag_stack_argno(u8 slot)
> +{
> +	return MAX_BPF_FUNC_REG_ARGS + slot + 1;
> +}
> +
> +static void diag_format_stack_arg(char *buf, size_t size, u8 slot, const char *arg_name)
> +{
> +	int argno = diag_stack_argno(slot);
> +	const char *ordinal = diag_arg_ordinal(argno);
> +
> +	if (ordinal && arg_name)
> +		scnprintf(buf, size, "outgoing stack argument %u (%s argument, %s)", slot + 1,
> +			  ordinal, arg_name);

[ ... ]

> +static const char *diag_mod_target_desc(struct bpf_verifier_env *env,
> +					const struct bpf_diag_mod_target *target)
> +{
> +	switch (target->kind) {
> +	case BPF_DIAG_MOD_TARGET_REG:
> +		return bpf_diag_fmt(env, "R%u", target->regno);
> +	case BPF_DIAG_MOD_TARGET_STACK_ARG:
> +		return bpf_diag_fmt(env, "stack arg%d", diag_stack_argno(target->stack_arg));
                                                      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Does this numbering match the rest of the diagnostic output?

diag_stack_argno() returns MAX_BPF_FUNC_REG_ARGS + slot + 1, which for
slot 0 gives 6 (the absolute argument ordinal). But diag_format_stack_arg()
uses slot + 1 to label the same slot, and the pre-existing verbose() message
in check_outgoing_stack_args() also uses spi + 1.

For a 6-argument bpf2bpf call where the first stack argument (slot 0) was
invalidated by an intervening call, the verifier log shows three different
numbers for the same slot:

  callee expects 6 args, stack arg1 is not initialized
    (from verbose(), using slot + 1)

  outgoing stack argument 1 (sixth argument, x) is not initialized
    (from diag_format_stack_arg(), using slot + 1)

  stack arg6: call invalidated this outgoing stack argument
    (from diag_mod_target_desc() via diag_print_history(), using slot + 6)

The string "stack arg%d" appears in both the pre-existing verbose() output
and this new Causal path section. In one place it means slot number within
the stack-arg area, in the other it means absolute argument position.

Should diag_mod_target_desc() use target->stack_arg + 1 to match the
slot-numbering convention used by verbose() and diag_format_stack_arg(), or
use different wording to clarify the number is an absolute argument ordinal
rather than a stack slot number?

> +	case BPF_DIAG_MOD_TARGET_STACK_SLOT:
> +		return bpf_diag_fmt(env, "stack slot fp%d", -(target->spi + 1) * BPF_REG_SIZE);
> +	default:
> +		return "value";
> +	}
> +}

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/31870608176
--===============4328045260132972321==--
