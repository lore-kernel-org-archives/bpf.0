Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793939093;
	b=Ix3GBYb7ZCYqmrzmxQW8FA1nMPtVoh+5QQKFx/dmaQC97gOfN46fH0Qdy/pM3dz/FlBA
	 lx3eZLcaaj6VqRMgLdj2ANM0263kLfR9a7xHXoV3Ou2EUh0QnlAGhoa1luFUJGCWcjfRU
	 Oia9U4KHUOGQ53a64T/b4NZbFoEBYkCJpJxZFQ9WeATHQ7Wfzee6qD3sbydiCnAOdlDfu
	 7Ey8NBPRjBQip9SCKdO3SbBcSJz2Nc2OzR3ZyNcSdDdCc8jrHau6nFnFEVmSlWdGLqDqw
	 iGwvUJ4hgdxox3CSJ3VxTc5JNn+QUBj0365TtRVCZn9c9pwbtc/OCMZtW47laTKIOfQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793939093;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=4ss322bpLq7NrDxU6M4ocdh8aO0fXOygWog6mbB2APo=;
	b=iLT2PVBAqIIDBaqmIV/pOtPjnxbcJBbhxhxdzAQR3w0vM4Fam1Zj1ylmbkIDnD4JhQmU
	 Xqpt7a5XFGLlEd0A6xKwUFrXChZdmlOwfA7IdfROr5uo+85pH1Tuk4353w6vhja7O4t3S
	 J7sHicIuRMSvfORgCIbW2p0IntHffgzO/pFhhSSu1LRJ/VMKDIUPikNfy52/eSEObJsy6
	 CkPWjd9LX4/+dZLWEw/+aRLJdphm32HA5Ff7EzHfZ+Q/HrM/NYLlx90uNw+eu8MkpUFbV
	 AViTuQ0AcysZn60xyAp4krjc6ISzP/kIR1lTaMn8upamkZV3XiTcAwCM1aU6pMVvPiw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gji+z5zF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90946606A31B
	for <bpf@vger.kernel.org>; Fri,  6 Nov 2026 04:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gji+z5zF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E06801F0089F;
	Fri,  6 Nov 2026 04:24:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793939093;
	bh=4ss322bpLq7NrDxU6M4ocdh8aO0fXOygWog6mbB2APo=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=gji+z5zF5XTibgMa/18U2d2mb/u6xfDdnqt/cf230xe34vG+sL2J/zpXnJOpO8U8b
	 esEeaynBmPnnPul9/yxb/fDQmX98n5w1Y4IyEi2OLKm0ZnY70uoDe+rwDaFOfuJa8i
	 ICRDwQ8/e29VcIghDbDimJ8S6RrMPyQ6nVzH4EOzrlyYJgkMuTJTr+e2VyWMlmT6uY
	 F5LBssuSKPS3oBr81h35h+dfu3yXChFeypf7aOkspL6VRP5+3zIvDXuWzm5ecS1v3F
	 VjB+vSC41154BH7coVHvuGHvkiMPR8+Bf/Ajgl2j/dJsgHkYhI6StL/XTXPGpveQoi
	 EPXO7t8tgbUtA==
Content-Type: multipart/mixed; boundary="===============5226351768685160338=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <60b55c76f3bea539ab7abb49ee63fa81ae7355d3e20662bc57d86cff380cb9de@mail.kernel.org>
In-Reply-To: <20261106035111.3315285-34-alexei.starovoitov@gmail.com>
References: <20261106035111.3315285-34-alexei.starovoitov@gmail.com>
Subject: Re: [PATCH bpf-next v3 33/45] bpf: Keep the frames of the caller for ctx of struct_ops with a reference
From: bot+bpf-ci@kernel.org
To: alexei.starovoitov@gmail.com,bpf@vger.kernel.org
Cc: daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Fri,  6 Nov 2026 04:24:52 +0000 (UTC)

--===============5226351768685160338==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Keep the frames of the caller for ctx of struct_ops with a reference

TL;DR:
- Missing !sub->recursive check may make the verifier reject a recursive
  subprog taking struct_ops ctx while a ref is held (frame-depth E2BIG)
- Condition is broader than the __ref case: it fires for any held ref,
  including sched_ext

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[ ... ]

> @@ -11586,9 +11586,13 @@ static u32 inherited_id(const struct bpf_verifier_state *state, u32 id)
>  /* What func_is_on_its_own() asks of an argument, be it in a register or on the stack */
> -static bool arg_needs_caller(const struct bpf_verifier_state *state,
> +static bool arg_needs_caller(struct bpf_verifier_env *env, const struct bpf_verifier_state *state,
>  			     const struct bpf_subprog_info *sub, const struct bpf_reg_state *reg)
>  {
> +	/* the id of a __ref argument is kept in ctx_arg_info[], see __check_ctx_access() */
> +	if (reg->type == PTR_TO_CTX && state->acquired_refs &&
> +	    env->prog->type == BPF_PROG_TYPE_STRUCT_OPS)
> +		return true;

Should this case also be limited by !sub->recursive, like the neighbouring
cases that keep the caller?

	if ((reg->type == PTR_TO_PACKET_END ||
	     (reg->type == PTR_TO_PACKET && sub->loads_pkt_end)) && !sub->recursive)
		return true;
	/* or whether there is something to point to */
	return type_may_be_null(reg->type) && !sub->recursive;

When func_is_on_its_own() returns false, check_static_func_call() calls
setup_func_entry(), which pushes a new frame.  A recursive subprog that
gets ctx and calls itself with ctx again still sees state->acquired_refs
as non-zero, so every level of the recursion keeps the frames again, and
states with a different curframe are never compared or joined.

If the depth is not bounded by a constant, the descent only stops at the
check in setup_func_entry():

	if (state->curframe + 1 >= MAX_CALL_FRAMES) {
		verbose(env, "the call stack of %d frames is too deep\n", ...);
		return -E2BIG;

For example, a test_refcounted struct_ops prog holds task__ref from the
start, and calls:

	static __noinline int depth(unsigned long long *ctx, int n)
	{
		return n > 0 ? depth(ctx, n - 1) : ctx[0] & 1;
	}

with an unknown n.  depth() only reads the plain int at ctx[0].  Before
this patch it was verified once on its own and the prog loaded.  Can this
now be rejected?

The condition is also wider than the __ref case the commit message
describes.  It fires for any BPF_PROG_TYPE_STRUCT_OPS prog that holds any
entry in refs[], including bpf_spin_lock and IRQ-flag entries, since
acquired_refs counts all REF_TYPE_* kinds.  That includes sched_ext
programs, which have no __ref arguments, so ctx_arg_info[] never holds a
ref_id there.

Would it be better to add && !sub->recursive, and to check whether a
ctx_arg_info[i].ref_id is still among state->refs rather than testing
acquired_refs?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/42160076968
--===============5226351768685160338==--
