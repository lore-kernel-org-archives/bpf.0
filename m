Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793940647;
	b=Zj5DFDYgUwmwPrF4AXwUBtEn36/NT5+BeWKUlnuKN9H4nw3xkvIpeC39MlqAwbyp76Kl
	 zwvTB1sSPva+X7QLUl+RXY1pvlj+pqZokDaF0HiA8b02W8eG3PM5xJYKRtxuc/RlrgkGM
	 blRLDXAF4ZYfdM7/fD/9Yv9eeKsMBybhg780ZlLljz9qldzMAuILmSS3vBVBnM3pMn8dT
	 HHxvjZrUCrrBtmJI14qAT/wZOmGqNO3pLZ3czbnERjK9ljzUXNvGe1n1IjexB4l5nirLI
	 CBXymjzrUQMIRuwcVbkB/DLeNyhYemYJ7H6YOz1+rp4v4uXvgsJWnzlV4g6qmwidxjw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793940647;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=4QDav9lZCLldotw5mg80BbKfn3HzISbic/APrnckdrs=;
	b=GA08TxfioY/iFIWHGNNrP4HqKAw/BG9V49OnZLxGDQ8X6JPK8mIgtTuGlCGmiIPwCOxg
	 6PynmFw6flXau1wwwG61LHAVJjm+Fx6EXikaIOavxmbC6py5E2bCL6Bw7mAk8NFeRU0Y9
	 VfhBtqytdvRTLaSAENFWdHGesN3knfR1D7h20/qAj6HiHHTgeZYQVOqLkJeIft9R/54oy
	 fDQS+jx//7oMsYLA9OyAdzLA7ZWr8/ANmRle844KfCEgawbk/N35fOmi2LcOiRckq8uir
	 PFcUEGOyAxBBmMRAfupUn0lZNlcvkHH8vQhbLNVRBqK1ybsUTZG32T7hNvgc4j9UuIQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iZtKgXVb;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CB3D606A31B
	for <bpf@vger.kernel.org>; Fri,  6 Nov 2026 04:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iZtKgXVb
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06A151F0089F;
	Fri,  6 Nov 2026 04:50:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793940647;
	bh=4QDav9lZCLldotw5mg80BbKfn3HzISbic/APrnckdrs=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=iZtKgXVbS8CzxNLWxdj68vs0IYDc30F2Q5Dn+ei+UO1xG+NTvRFQmtzyX/Ns0hjZM
	 Y3AsXkZsfPMWzvaTWEPar5MJqPbP6//vOQOkUknB9wJn5JYFMcAxz3ftB9J43pFb2j
	 47qt5ij0VSv5pZYOivVXaZ9cZJMYa6oRP3F7zkwnltzd5UqJtNuK5eCy6QLTc3tVDO
	 3injncqb+kzOvRlPRgq2T0VpZnjIkxfYZ5MnDu9UOu7gDjDfUCLT4U9DLuHULpynJ+
	 wxnMZUzFing48jvYR7+UcekFQqsiDACKg+kSlKQDrfXYPj1fgBt8P3bi2QNcBKD0+9
	 ajCieDLgJK7iQ==
Content-Type: multipart/mixed; boundary="===============0520255565338144482=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <32ad255716e5f6b6f55e2a0defcbb30cd191d107aeaf60fcc4f6ec765a8354ed@mail.kernel.org>
In-Reply-To: <20261106035111.3315285-22-alexei.starovoitov@gmail.com>
References: <20261106035111.3315285-22-alexei.starovoitov@gmail.com>
Subject: Re: [PATCH bpf-next v3 21/45] bpf: Verify static subprogs on their own
From: bot+bpf-ci@kernel.org
To: alexei.starovoitov@gmail.com,bpf@vger.kernel.org
Cc: daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Fri,  6 Nov 2026 04:50:47 +0000 (UTC)

--===============0520255565338144482==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Verify static subprogs on their own

TL;DR: Verifying static subprogs on their own may reject previously loading
programs (struct_ops ref context, subprog loading data_end); later series
patches fix both. PTR_TO_STACK type-flag compare looks latent.

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[ ... ]

> +/* What func_is_on_its_own() asks of an argument, be it in a register or on the stack */
> +static bool arg_needs_caller(const struct bpf_verifier_state *state,
> +			     const struct bpf_subprog_info *sub, const struct bpf_reg_state *reg)
> +{
> +	/* only the ids of what is held have names */
> +	if (reg->type != SCALAR_VALUE &&
> +	    ((reg->id && !inherited_id(state, reg->id)) ||
> +	     (reg->parent_id && !inherited_id(state, reg->parent_id)) ||
> +	     (reg->map_uid && !inherited_id(state, reg->map_uid))))
> +		return true;

Can this reject a struct_ops program that holds a reference it got at entry
through a __ref context argument?

The context register is PTR_TO_CTX with id 0, so arg_needs_caller() returns
false and func_is_on_its_own() lets the callee be verified on its own.
call_func_on_its_own() then renames every held reference:

    entry.refs[i].id = inherited_id(state, entry.refs[i].id);

When the callee loads the referenced pointer from the context,
__check_ctx_access() looks up the original id kept in ctx_arg_info[]:

    if (info->ref_id &&
        !find_reference_state(env->cur_state, info->ref_id)) {
            verbose(env, "invalid bpf_context access off=%d. Reference may already be released\n", off);
            return -EACCES;

The entry state only has the BPF_INHERITED_ID + i names, so the lookup
fails.  For example, the skb of Qdisc_ops.enqueue, or the task in the
selftest 'struct_ops/test_refcounted', passed on to:

    static __noinline int pid_of(unsigned long long *ctx)
    { struct task_struct *task = (void *)ctx[1]; return task->pid; }

would now be rejected, while it loaded before this patch.  The commit
message lists the cases that keep the frames of the caller, and a context
whose ids live outside the register state is not among them.

A later commit in the series, d67af9e9ebf4 ("bpf: Keep the frames of the
caller for ctx of struct_ops with a reference"), adds the missing case to
arg_needs_caller().

> +	/*
> +	 * Pointers to the packet that share an id have ranges of the same size, see
> +	 * find_good_pkt_pointers(). What comes out of the function has the range of all calls.
> +	 */
> +	if (reg_is_pkt_pointer(reg) && reg->id)
> +		return true;
> +	/* it checks how much of the packet is there, for the caller */
> +	if (reg->type == PTR_TO_PACKET_END && !sub->recursive)
> +		return true;

Can a static subprog that checks a packet pointer for its caller now be
rejected when it loads data_end from the context itself, instead of taking
it as an argument?

    static __noinline bool has(struct xdp_md *ctx, void *p, u32 n)
    { return p + n <= (void *)(long)ctx->data_end; }
    ...
    if (!has(ctx, p, 14)) return XDP_DROP;
    return *(char *)(p + 13) ? XDP_PASS : XDP_DROP;

    invalid access to packet, off=13 size=1, R6(id=0,off=13,r=0)

The arguments are PTR_TO_CTX, PTR_TO_PACKET with id 0, and a scalar, so
arg_needs_caller() returns false for each of them.  In the callee,
find_good_pkt_pointers() walks bpf_for_each_reg_in_vstate() over the
callee's own one-frame state only, and the caller's r6 keeps r=0.  With the
frames of the caller, the same walk updated r6 in the caller's frame.

The commit message names "the subprog does a check for the caller" as a
reason to keep the frames, but only covers a PTR_TO_PACKET_END argument.

A later commit in the series, 8686ffec6023 ("bpf: Keep the frames of the
caller for a subprog that loads data_end"), adds
bpf_subprog_info.loads_pkt_end and keeps the frames for a PTR_TO_PACKET
argument of such a subprog.

[ ... ]

> +	for (i = BPF_REG_1; i <= BPF_REG_5; i++) {
> +		if (!(live & BIT(i)))
> +			continue;
> +		if (caller->regs[i].type == PTR_TO_STACK ||
> +		    base_type(caller->regs[i].type) == CONST_PTR_TO_DYNPTR)
> +			return false;

A subsystem pattern flags this as potentially concerning: the exact compare
of caller->regs[i].type against PTR_TO_STACK imposes a restriction on a
match, and a register with any type flag set would skip it, while the
CONST_PTR_TO_DYNPTR test on the same line uses base_type().

Should this be base_type(caller->regs[i].type) == PTR_TO_STACK?  The same
applies to the stack_arg_regs loop below, and to the
reg->type == PTR_TO_PACKET_END test in arg_needs_caller().

If a pointer to the caller's stack ever carried a type flag, the callee
would be verified with no caller frame, and the pointer's frameno would
refer to a frame of the callee's own state.

In this tree I did not find a path that puts a flagged PTR_TO_STACK into a
register.  The only flagged values are the spilled_ptr of STACK_ITER slots,
which are never filled into a register, and callback setup copies
PTR_TO_STACK unchanged.  So this looks latent rather than reachable today.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/42160076968
--===============0520255565338144482==--
