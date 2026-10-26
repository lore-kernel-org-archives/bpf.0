Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792986792;
	b=5ljw4b+a7EKsg3vhoxUOTiRYcpUBMhgiOc5/NfWlOIiMK9QaXwSunzk7EsH/vGA8Tv4E
	 xZ2+OjURDXUrMNddw8AaW6MsZPgxMy9B+/YEj/feBsE9xcTaRFF9zXupzHl05z91QTl64
	 0Lxn7cO0H6lDTATpKlpH2ai9VOmnboqk4erYwwdGxuzkQCCqg3yqnXaTsm24l/SNjTPHK
	 EHoelFfCFIv0ATK4KgJcoX53EttMgPNGIsvxJtuKGY4kzmFGtlXGBeoJjP7x8qnKMaDrq
	 kOtn6sOcgtjjtWiYvp2srEmqfc9zkHDCKICGVMKYFgEDiqZkjLIBNvcuHjKq2r8weRA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792986792;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=QB/6KXpAbkCrIcCYKDZhg9aj3IS5q1tLfvdDj+Zcapo=;
	b=qPkq+8I5gT+YeY8Hewwq0fXYpFIT8DTAVDxqqmNlzwqpXmaNCJW/iM/CDdyHPVdgyCol
	 ZW2FJXvPwaAx3Xp/xP0wzA6ifOCl/P9A72FTdErL/0XhJWvNGIGxWfx6FZePCtZ196Nrc
	 zbO1Rob0g6ago+3rqzLOHmS4Y+P3Btk7v2MZP/6OZTdmTHxC53G1innzmI9BwDpK02Gkq
	 x+J3H2BLXr6jWdY6+f1rocIwFyrtEcmXFl+wTvior9Kf5IemHdZObwIwVs7Av/b/oFVI3
	 uzj3NXkglfrYukFFfMteQOEgvp8lc7Y82umE4cCB6JwD/Djcd7exgpuKvaw6++uzxxw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OayqxTgu;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57946606A31E
	for <bpf@vger.kernel.org>; Mon, 26 Oct 2026 03:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OayqxTgu
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04B4E1F01825;
	Mon, 26 Oct 2026 03:53:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792986792;
	bh=QB/6KXpAbkCrIcCYKDZhg9aj3IS5q1tLfvdDj+Zcapo=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=OayqxTguS0fQdvljVTFYN/UKDNGMUjmzn2nzdEYRQ2LhFO5l9XCm/AxG2R2qKcG63
	 IeByf2H2xUxAJ0TomTd23opc1+qLTv3+CnonyxehvDcJjnoc7PpheWKp3FolhMXIbz
	 p3oetajnVc10D4fu7ylmszIg2khFw8IFOKqFjMywOfWhqRnL+VaLibJFk4hIpH++/J
	 PM1O8Ay/1WxB9bTgpzDqv5tPVcZnziljdxJcnl/EJXcVqIejJ2nZLdJvB+obMXhNYs
	 Wr4NXZ2YoUUyHRtb6AWdvpwhLNY0CiXYTHO3uaL6EG4QR1Cl9pKOSrrqV9VF/E/jo4
	 Rv4Ttsg3mTmFQ==
Content-Type: multipart/mixed; boundary="===============0482243271192692125=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <d5d1b10bfa34fbfc8dc74bc2e58577768743f81230e3d78d32aed95d0700607d@mail.kernel.org>
In-Reply-To: <20261026025943.404450-62-alexei.starovoitov@gmail.com>
References: <20261026025943.404450-62-alexei.starovoitov@gmail.com>
Subject: Re: [PATCH bpf 61/81] bpf: Remove precision tracking
From: bot+bpf-ci@kernel.org
To: alexei.starovoitov@gmail.com,bpf@vger.kernel.org
Cc: daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Mon, 26 Oct 2026 03:53:12 +0000 (UTC)

--===============0482243271192692125==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Remove precision tracking

TL;DR:
- Possible valid programs rejected: need_const seeding may not cover __szk,
  rdonly/rdwr_buf_size, stack-passed or map-key args, so joined states may
  fail "must be a known constant"
- Nit: dead 'best'/'latch' stores in bpf_compute_loop_iters()

> diff --git a/kernel/bpf/scev.c b/kernel/bpf/scev.c
> index 853aac03d519..4da7ad48f99e 100644
> --- a/kernel/bpf/scev.c
> +++ b/kernel/bpf/scev.c

[ ... ]

> @@ -3195,17 +3171,6 @@ int bpf_compute_loop_iters(struct bpf_verifier_env *env, struct bpf_verifier_sta
>  			walk = true;
>  	}
>  
> -	bitmap_zero(iters->precise_regs, REGS_NUM);
> -	err = mark_expr_precise(env, cur_func, latch.base_expr, iters->precise_regs);
> -	if (err)
> -		return err;
> -	err = mark_expr_precise(env, cur_func, latch.step_expr, iters->precise_regs);
> -	if (err)
> -		return err;
> -	err = mark_expr_precise(env, cur_func, latch.bound_expr, iters->precise_regs);
> -	if (err)
> -		return err;
> -
>  	/* 2: the count is known, what some of the live registers are is not */
>  	return walk ? 2 : 1;
>  }

this isn't a bug, but is the local 'best' in bpf_compute_loop_iters() still
needed now that these calls are gone?

The only readers of 'latch' after the selection loop were the three
mark_expr_precise() calls removed above:

    err = mark_expr_precise(env, cur_func, latch.base_expr, iters->precise_regs);
    err = mark_expr_precise(env, cur_func, latch.step_expr, iters->precise_regs);
    err = mark_expr_precise(env, cur_func, latch.bound_expr, iters->precise_regs);

That leaves 'struct linear_latch latch, best;', 'best = latch;' in the
selection loop and 'latch = best;' after it as dead stores.  What the rest
of the function needs from the chosen latch is already copied into
iters->max_header_count, iv_reg and iv_range inside the loop.

The leftover is still present at the end of the series, after 91e7ff3a122f
("bpf: Remove leftovers of precision tracking and read marks").  Could
'best' and the two assignments be dropped?

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 2c385a7d459c..245147ff3b1e 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[ ... ]

> @@ -8287,9 +8056,6 @@ static int process_const_alloc_mem_size(struct bpf_verifier_env *env, struct bpf
>  static int process_const_arg(struct bpf_verifier_env *env, struct bpf_reg_state *reg,
>  			     argno_t argno, struct bpf_call_arg_meta *meta)
>  {
> -	int regno = reg_from_argno(argno);
> -	int err;
> -
>  	if (meta->arg_constant.found) {
>  		verifier_bug(env, "only one constant argument permitted");
>  		return -EFAULT;
> @@ -8300,13 +8066,6 @@ static int process_const_arg(struct bpf_verifier_env *env, struct bpf_reg_state
>  		return -EINVAL;
>  	}
>  
> -	if (regno >= 0)
> -		err = mark_chain_precision(env, regno);
> -	else
> -		err = mark_stack_arg_precision(env, arg_idx_from_argno(argno));
> -	if (err < 0)
> -		return err;
> -
>  	meta->arg_constant.found = true;
>  	meta->arg_constant.value = reg->var_off.value;
>  

The commit message says the precision marks are not needed because
flow_compute_need_const() "finds the registers and stack slots that go into
such arguments" and the verifier does not join states that differ in them.

Is that true for every call site that loses its mark_chain_precision() call
in this commit?  flow_compute_need_const() with FLOW_NEED_ARG is seeded
only from these two places:

bpf_kfunc_const_arg_regs():
	for (i = 0, slot = 0; i < nargs && slot < MAX_BPF_FUNC_REG_ARGS; i++) {
		if (is_kfunc_arg_constant(meta.btf, &args[i]))   /* suffix "__k" only */
			mask |= BIT(BPF_REG_1 + slot);

bpf_helper_const_arg_regs():
		if (fn->arg_type[i] == ARG_CONST_ALLOC_SIZE_OR_ZERO)

Several arguments that process_const_arg() or process_const_alloc_mem_size()
still require to be known constants do not appear to be covered:

1. kfunc args with the __szk suffix.  gen_kfunc_arg_proto() maps them to
ARG_CONST_MEM_SIZE and check_func_arg() sends them to process_const_arg().
btf_param_match_suffix("buffer__szk", "__k") is false, so they are not
seeded.  bpf_dynptr_slice() and bpf_dynptr_slice_rdwr() take such an
argument.

2. kfunc args named rdonly_buf_size or rdwr_buf_size.  They map to
ARG_CONST_ALLOC_SIZE_OR_ZERO and reach process_const_alloc_mem_size(), but
bpf_kfunc_const_arg_regs() only tests for "__k".  An in-tree user is
hid_bpf_get_data(ctx, offset, rdwr_buf_size).

3. __k kfunc args passed on the stack (argument 6 and later).  The loop
above stops at MAX_BPF_FUNC_REG_ARGS, and struct flow_need has no
stack-arg slots.  The removed mark_stack_arg_precision() calls used to cover
these.

4. The map key slot that get_constant_map_key() reads to drop
PTR_MAYBE_NULL from an array map lookup.  need_const only adds a slot for
an LDX into a needed register, and the helper reads the key through R2.

As the comment above flow_compute_need_const() describes for
bpf_rdonly_cast(), LLVM can sink two calls into one:

	r4 = 20; if r6 == 0 goto L; r4 = 40;
L:	call bpf_dynptr_slice      /* r4 is buffer__szk */

The two states meet at L with R4=20 and R4=40.  In flow_merge(),
flow_needed_consts_differ() finds no need bit for R4.  flow_null_differs(),
flow_join_makes_up() (R4 is not tested by a jump) and
flow_callback_depth_differs() do not apply either.

bpf_states_join() -> join_reg() then joins the scalars to [20,40], and
process_const_arg() fails with "R4 must be a known constant".

Before the series, process_const_arg() marked R4 precise, the two states
were not pruned, and the program loaded.

The same happens with an array map lookup whose key is 0 on one path and 1
on the other: R0 stays map_value_or_null, and an access without a NULL
check that was accepted before is now rejected.

No verifier decision changes at this commit itself, since
bpf_mark_chain_precision() was already stubbed to return 0 by 0535bc235aed
("bpf: Verify programs as a fixpoint over the control flow graph").  But
this commit removes the remaining precision handling at these sites and
names flow_compute_need_const() as the replacement.

A search of the commits after this one in the series found none that
extends bpf_kfunc_const_arg_regs(), bpf_helper_const_arg_regs() or
flow_compute_need_const() to cover the cases above.

Should the need_const seeding cover ARG_CONST_MEM_SIZE, the
rdonly_buf_size/rdwr_buf_size args, stack-passed constant args and the
constant map key?  Otherwise, should the commit message avoid claiming that
flow_compute_need_const() covers them?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/40263142572
--===============0482243271192692125==--
