Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4470472782
	for <bpf@vger.kernel.org>; Fri,  5 Jun 2026 07:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780644185; cv=none; b=tFMh4hHXkmRNJGunGYjSGi9FEfWQzuElW5fcNJOE5bKUC6JrVfQZLUgswAE9duayaCZBXcPtDaKNGkYIumV7jqOlfMi2o3UopPIwwe3+3AnxUH3yKq/4V8qlEo8pLUjzQVSE02tvJ/cEvCvfk6+ZfEmtzpDPTVTHnoTThV2z1PU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780644185; c=relaxed/simple;
	bh=i1TF+n83m8fADeTFLTwvqM4OJHRC6Gn/x9vVoqIemqo=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=d1yuB/FmlzHUsWlN5U4MQr/kBi+SBnpVgMblBrWhimvXhI96MM86lxNFsiqrx0rTp5/q69jzrG7XxZFn4I1LWuWWjgz0rmmYvThehkAoCXZRVjIevdU919rr++Nil8K8NCdfdHBnkYaurgOpoGIvLdWqRUC+ltmVPXPJ7Rnz7R0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WYrbIVtU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WYrbIVtU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FA1E1F00893;
	Fri,  5 Jun 2026 07:23:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780644183;
	bh=eivdkebv8qiBYuFhgjA7nuOBxAAnOehWtlNfHUAAwWY=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=WYrbIVtUlv00UTSQfvb50+Yg7CeSQ8VB947TTIWTq2Nlq2qb7C9ToBkkn09A1+lLT
	 EybQOdn+e4ewRgNz91WsPgKeEOvlf5Hm1+4HBRaSDjKvYdia/Ub/GStE+1h/TTb9yn
	 bSSoo14UrLbDdSj07L7zTb9mIiH0jtvPDBJe3U6jnIfgOOCn7696Mn+gZgb8ewiFM4
	 Jq5fmFJQkjw4IGnpuwiKQAwX7QIefZJtWctD74TvacNmP1+YNQHAR88jyEyCxZQoHO
	 x7oRNcWbG/zEs18QtfZsKsZ9P7TxgjkLaBGHkAPKTnN645Tx/CVBJ3muOtgXOss59K
	 5mCbH0Buk4TuA==
Content-Type: multipart/mixed; boundary="===============5846836419116224857=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <7e5e90c1f3653f41b3d1774c476aaffdf2dd32d3d9f6ef9246208dcff8579656@mail.kernel.org>
In-Reply-To: <20260605063412.974640-9-memxor@gmail.com>
References: <20260605063412.974640-9-memxor@gmail.com>
Subject: Re: [PATCH bpf-next v1 08/17] bpf: Report Register Type Safety errors
From: bot+bpf-ci@kernel.org
To: memxor@gmail.com,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,emil@etsalapatis.com,kkd@meta.com,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Fri,  5 Jun 2026 07:23:03 +0000 (UTC)

--===============5846836419116224857==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/diagnostics.c b/kernel/bpf/diagnostics.c
> index 7a122c5025c2..920ac17758c2 100644
> --- a/kernel/bpf/diagnostics.c
> +++ b/kernel/bpf/diagnostics.c

[ ... ]

> +void bpf_diag_report_invalid_deref(struct bpf_verifier_env *env, u32 insn_idx,
> +				   int regno, const char *reg_name,
> +				   const char *type_name,
> +				   enum bpf_diag_invalid_deref_kind kind,
> +				   s64 offset)
> +{
> +	struct bpf_diag_history_opts opts = {
> +		.scope = BPF_DIAG_HISTORY_SCOPE_REG,
> +		.frameno = bpf_diag_current_frameno(env),
> +		.regno = regno,
> +	};

[ ... ]

> +	bpf_diag_print_history(env, &opts);

This call to bpf_diag_print_history() in bpf_diag_report_invalid_deref()
is unconditional, but bpf_diag_report_register_type() guards the same call
with "if (regno >= 0)".

The callers in verifier.c pass reg_from_argno(argno) as regno:

	bpf_diag_report_invalid_deref(env, env->insn_idx, reg_from_argno(argno),
				      ...);

reg_from_argno() can return -1 for stack arguments. When regno is -1,
bpf_diag_history_start_idx() finds no match (dst_reg is a u8) and returns
index 0, and since bpf_diag_history_event_visible() returns true for all
branch events, would this dump the entire branch history of the program
into the verifier log?

Should this guard the history print with regno >= 0, the same way
bpf_diag_report_register_type() does?

> +void bpf_diag_report_unreadable_reg(struct bpf_verifier_env *env,
> +				    u32 insn_idx, int regno)
> +{
> +	struct bpf_diag_history_opts opts = {
> +		.scope = BPF_DIAG_HISTORY_SCOPE_REG,
> +		.frameno = bpf_diag_current_frameno(env),
> +		.regno = regno,
> +	};

[ ... ]

> +	bpf_diag_print_history(env, &opts);

The same unconditional history print appears here in
bpf_diag_report_unreadable_reg(). Does this have the same concern when
regno is -1?

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 7bb2a81ee353..adf660ab9e7d 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[ ... ]

> @@ -13684,6 +13712,7 @@ static int adjust_ptr_min_max_vals(struct bpf_verifier_env *env,
>  	struct bpf_sanitize_info info = {};
>  	u8 opcode = BPF_OP(insn->code);
>  	u32 dst = insn->dst_reg;
> +	char reason[256];
>  	int ret, bounds_ret;
>
>  	dst_reg = &regs[dst];
> @@ -13707,12 +13736,28 @@ static int adjust_ptr_min_max_vals(struct bpf_verifier_env *env,
>  		verbose(env,
>  			"R%d 32-bit pointer arithmetic prohibited\n",
>  			dst);
> +		scnprintf(reason, sizeof(reason),
> +			  "R%d holds %s. 32-bit ALU operations on pointers discard pointer provenance, so the verifier cannot keep the result as a safe "
> +			  "pointer.",
> +			  dst, bpf_diag_reg_type_plain(env, ptr_reg->type));
                              ^^^^^^^^^^^^^^^^^^^^^^^

Where is bpf_diag_reg_type_plain() defined?

This patch adds seven calls to bpf_diag_reg_type_plain(env, ptr_reg->type)
inside adjust_ptr_min_max_vals(), but the function does not appear to be
defined or declared anywhere in the tree at this commit.

A grep for the symbol returns only these seven call sites in verifier.c,
with no declaration in kernel/bpf/diagnostics.h, kernel/bpf/diagnostics.c,
any header under include/, and no matching #define. The other helper added
in the same patch, bpf_diag_report_register_type(), is defined in
diagnostics.c, so the omission looks specific to bpf_diag_reg_type_plain()
(perhaps a renamed or forgotten helper relative to reg_type_str()).

Since a translation unit referencing an undeclared function fails to build
under -Werror=implicit-function-declaration, does kernel/bpf/verifier.c
still compile at this commit?

> +		bpf_diag_report_register_type(env, env->insn_idx, dst,
> +					      "32-bit pointer arithmetic",
> +					      reason,
> +					      "Use 64-bit pointer arithmetic with an allowed, bounded scalar offset, or convert the value to a scalar only after pointer use "
> +					      "is complete.");

The dst argument passed here is insn->dst_reg.

For commutative pointer arithmetic such as scalar += pointer, dst_reg held
the scalar value before the instruction. Passing dst in that case would
make bpf_diag_report_register_type() claim the scalar register held a
pointer, and trace the scalar register's history rather than the pointer's
provenance.

The same dst is used for all of the bpf_diag_report_register_type() and
off_reg/ptr_reg based reports in this function. Should these reports
reference the register that actually held the pointer instead?

>  		return -EACCES;
>  	}
>
>  	if (ptr_reg->type & PTR_MAYBE_NULL) {
>  		verbose(env, "R%d pointer arithmetic on %s prohibited, null-check it first\n",
>  			dst, reg_type_str(env, ptr_reg->type));
> +		scnprintf(reason, sizeof(reason),
> +			  "R%d may be NULL (%s). Pointer arithmetic is allowed only after the program proves the pointer is non-NULL on this path.",
> +			  dst, reg_type_str(env, ptr_reg->type));
> +		bpf_diag_report_register_type(env, env->insn_idx, dst,
> +					      "pointer arithmetic before NULL check",
> +					      reason,
> +					      "Add a NULL check first, and do the pointer arithmetic only on the non-NULL branch.");
>  		return -EACCES;
>  	}

[ ... ]

There is one more observation that is not in this patch but is related to
the register-scoped history this patch relies on.

In clear_all_pkt_pointers() and release_reference(), invalidation history
is only recorded when bpf_diag_func_regno() or bpf_diag_stack_arg_slot()
returns >= 0:

kernel/bpf/verifier.c:clear_all_pkt_pointers() {
	...
		int regno = bpf_diag_func_regno(state, reg);
		int slot = bpf_diag_stack_arg_slot(state, reg);

		mark_reg_invalid(env, reg);
		if (regno >= 0)
			bpf_diag_record_reg_invalidate(...);
		if (slot >= 0)
			bpf_diag_record_stack_arg(...);
	...
}

Both helpers return -1 for ordinary stack spills, which live in
STACK_SPILL slots and are in neither state->regs nor
state->stack_arg_regs.

So would a pointer spilled to the stack and later invalidated here record
no history event? If the program restores and dereferences that pointer,
would the new diagnostic trace stop at the stack fill instruction and never
show when the pointer was invalidated?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/27000182395
--===============5846836419116224857==--
