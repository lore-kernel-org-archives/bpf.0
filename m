Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1792E241695
	for <bpf@vger.kernel.org>; Sat, 18 Apr 2026 01:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776474261; cv=none; b=hAaCXFS6gjauKTt7MsskLHVcSAHc9lEXSb+/NAfWWSxIsFlbRUCEunHCEFy8J+8QslOEO6NXRKeCtxTFt5XMJUCrNgIg+xmJxZbWqxEe8cgUyZplRLSYIxPPjLPdLy9BPZQanNapgBoWHYUc5EmnyWChMs8XiLAnx5/BHcUNuqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776474261; c=relaxed/simple;
	bh=nQlJB9XyioAPS5VWtKslvaXl6yLYwJqyFc+ybrYrXZ4=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=UC7ZdVRez4sFSCq058hAD6tCl7iZ+BB035L70f/LUHa4nlyA4Pvh3xS5wCpD/EFXGDE/fUHAElTOVsray8zkBtSoezBhiIgn/5otNO9q7fLdd6L493XBr6xZpFhW51CTQggiELIwC9tpVlA6WSsv/L7iwsqpeo9I/R9XxW9e61Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gVAOVIHg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gVAOVIHg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FB5DC2BCB3;
	Sat, 18 Apr 2026 01:04:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776474260;
	bh=nQlJB9XyioAPS5VWtKslvaXl6yLYwJqyFc+ybrYrXZ4=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=gVAOVIHggkLDBCyjc3rhI6cpGP6Wk9rgM+71dpZOYXrpYUgSEgZykLGdnJmSLnuxl
	 1COoNo81FlDRS9lo+Vkne2pz3LLrcEMnvYD2e6+AadO357ZYgnAcIndCbYW1INaA7i
	 smXq1K9Y6pKliqiBt+DnJvhUhfdl8EbjfjlWLQedWCljoWXZsfwbog1TqU07hzFdZJ
	 VT57et3bTZ4pcq73c+nGJKIE7cVTPcJHIoj7H5O9XgY0xOP2mrqDo4DMiGmxUSmG2m
	 8uvPVKTJqz+1WJBzQm1dtZpt4n5afpSzpn1FF3tcHnyMFtruTGtVLFGoKvRbBCV/Kj
	 zURZ45BF4ZTfA==
Content-Type: multipart/mixed; boundary="===============4714969025340093477=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <9ed0516c340a9717f644ca8d69a474f94774ddbdf4cb39b0b932029612871d35@mail.kernel.org>
In-Reply-To: <20260417034754.2630932-1-yonghong.song@linux.dev>
References: <20260417034754.2630932-1-yonghong.song@linux.dev>
Subject: Re: [PATCH bpf-next v5 11/16] bpf: Support stack arguments for kfunc calls
From: bot+bpf-ci@kernel.org
To: yonghong.song@linux.dev,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,jose.marchesi@oracle.com,kernel-team@fb.com,martin.lau@kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Sat, 18 Apr 2026 01:04:20 +0000 (UTC)

--===============4714969025340093477==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[ ... ]

> @@ -11653,6 +11659,19 @@ bool bpf_is_kfunc_pkt_changing(struct bpf_kfunc_call_arg_meta *meta)
> +static struct bpf_reg_state *get_kfunc_arg_reg(struct bpf_verifier_env *env, int argno)
> +{
> +	struct bpf_func_state *caller;
> +	int spi;
> +
> +	if (argno < MAX_BPF_FUNC_REG_ARGS)
> +		return &cur_regs(env)[argno + 1];
> +
> +	caller = cur_func(env);
> +	spi = out_arg_spi(caller, argno - MAX_BPF_FUNC_REG_ARGS);
> +	return &caller->stack_arg_regs[spi];
> +}

Can the verifier crash here?  Looking at get_kfunc_arg_reg, when
argno >= MAX_BPF_FUNC_REG_ARGS, the function returns
&caller->stack_arg_regs[spi] without checking whether stack_arg_regs
is NULL.

The stack_arg_regs array is only allocated by grow_stack_arg_slots,
which is called from check_stack_arg_write when the program writes
outgoing stack args via r11.  If a malformed BPF program invokes a
kfunc without emitting any stack stores beforehand, stack_arg_regs
will remain NULL.

Consider get_kfunc_ptr_arg_type calling get_kfunc_arg_reg to peek at
argument i+1 when checking for buffer+__sz pairs:

kernel/bpf/verifier.c:get_kfunc_ptr_arg_type() {
    if (argno + 1 < nargs &&
        (is_kfunc_arg_mem_size(meta->btf, &args[argno + 1],
                                get_kfunc_arg_reg(env, argno + 1)) ||
         ...
}

When argno=4 (pointer in r5) and argno+1=5 (size in first stack slot),
get_kfunc_arg_reg(env, 5) enters the stack-arg branch and dereferences
caller->stack_arg_regs even though it may be NULL.  If the arg type is
a scalar (which __sz/__szk suffixes imply), is_kfunc_arg_mem_size will
try to read reg->type, causing a NULL pointer dereference.

The is_stack_arg_slot_initialized gate you added in check_kfunc_args
only fires when the loop reaches i=5; by then the peek at i=4 has
already dereferenced the NULL pointer.

Should get_kfunc_arg_reg verify that stack_arg_regs is non-NULL and
spi < stack_arg_depth/BPF_REG_SIZE before returning the pointer?
Alternatively, should check_kfunc_call add an out_stack_arg_mask
pre-check mirroring the bpf-to-bpf gate that prevents
check_func_arg_reg_off from reading uninitialized stack slots?

> @@ -11660,8 +11679,6 @@ get_kfunc_ptr_arg_type(struct bpf_verifier_env *env,
>  		       const char *ref_tname, const struct btf_param *args,
>  		       int argno, int nargs, struct bpf_reg_state *reg)
>  {
> -	u32 regno = argno + 1;
> -	struct bpf_reg_state *regs = cur_regs(env);
>  	bool arg_mem_size = false;
>
>  	if (meta->func_id == special_kfunc_list[KF_bpf_cast_to_kern_ctx] ||
> @@ -11670,8 +11687,8 @@ get_kfunc_ptr_arg_type(struct bpf_verifier_env *env,
>  		return KF_ARG_PTR_TO_CTX;
>
>  	if (argno + 1 < nargs &&
> -	    (is_kfunc_arg_mem_size(meta->btf, &args[argno + 1], &regs[regno + 1]) ||
> -	     is_kfunc_arg_const_mem_size(meta->btf, &args[argno + 1], &regs[regno + 1])))
> +	    (is_kfunc_arg_mem_size(meta->btf, &args[argno + 1], get_kfunc_arg_reg(env, argno + 1)) ||
> +	     is_kfunc_arg_const_mem_size(meta->btf, &args[argno + 1], get_kfunc_arg_reg(env, argno + 1))))
>  		arg_mem_size = true;

[ ... ]

> @@ -20145,6 +20209,16 @@ int bpf_fixup_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
>  	if (!bpf_jit_supports_far_kfunc_call())
>  		insn->imm = BPF_CALL_IMM(desc->addr);
>
> +	/*
> +	 * After resolving the kfunc address, insn->off is no longer needed
> +	 * for BTF fd index. Repurpose it to store the number of stack args
> +	 * so the JIT can marshal them.
> +	 */
> +	if (desc->func_model.nr_args > MAX_BPF_FUNC_REG_ARGS)
> +		insn->off = desc->func_model.nr_args - MAX_BPF_FUNC_REG_ARGS;
> +	else
> +		insn->off = 0;
> +

This concern was raised by the bpf-ci bot and sashiko-bot in the v5
review thread but does not appear to have been addressed.

Overwriting insn->off destroys the BTF file descriptor index required
by bpf_jit_find_kfunc_model() for module kfunc lookups.  Looking at
the bsearch in kernel/bpf/fixups.c, it uses (insn->imm, insn->off) as
the key:

kernel/bpf/fixups.c:bpf_jit_find_kfunc_model() {
    key.addr = insn->imm;
    key.offset = insn->off;
    entry = bsearch(&key, tab, tab_count, sizeof(*tab), kfunc_addr_cmp);
}

For module kfuncs, insn->off stores a non-zero btf_fd_idx set during
find_kfunc_desc.  After this patch overwrites it with the stack arg
count (or 0), the bsearch will fail to find descriptors that were
stored with offset=btf_fd_idx.

This breaks module kfunc calls on architectures using JIT far calls
(s390x, loongarch, powerpc) for any module kfunc with 5 or fewer args
(insn->off zeroed) or with more than 5 args (insn->off now contains
the stack arg count instead of btf_fd_idx, still mismatching
desc->offset).  Vmlinux kfuncs with more than 5 args also get a
nonzero insn->off that no longer matches desc->offset=0.

Can the stack arg count be communicated to the JIT without clobbering
the btf_fd_idx that bsearch still keys on?

The original concern was raised here:
https://lore.kernel.org/bpf/e5a6e801c10994cc2e03b0cd57e76152eb234493a6b7395a9859feade4a6575b@mail.kernel.org/


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/24592562564
--===============4714969025340093477==--
