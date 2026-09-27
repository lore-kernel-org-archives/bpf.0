Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41DEB3C276B
	for <bpf@vger.kernel.org>; Sun, 27 Sep 2026 20:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790541785; cv=none; b=dOzZaa7RPFAQouCYPHcWPUm5u2+AyyO/H7wLTp8RNRW7Tso1z9f949Mg01u+TzjNt9Dxkq+I35r15bNcAC3dX6BGGbfR1eQxnIwPhIDLZYlEBqHjzjP73OZsKPxneHDKTtTc5wscfLxYgKeITnfWGEGYYTjyQlJUVsQBzgLKwwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790541785; c=relaxed/simple;
	bh=QcrMJH6/ZKneoCWcvt+Vs5aOvpBc6e6GIjELz/VECAs=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=KBPzqvXwZuaGqXZJ0eJTJW0j0h1Rr/lvt1TStp0Q4QeyRQrP/+zTIKXBd2y8JZRFLauneg0qFxozxB2kznTtJNUPaFmTH1h+y8nOhCz6es5aeZ5Vs7ElU44z6QqNmHKYE6Oe7Fi1TOYsz3uOVbIMYRp7tuKwsrzvJsF4qgl3fX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l2EUY+Is; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l2EUY+Is"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 326A71F00893;
	Sun, 27 Sep 2026 20:43:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790541783;
	bh=Wi16u40FV3A8i8n7XP81BJrqAtIVJQW5SoFMUpE8N1Y=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=l2EUY+IsyCyVZQzxxBqe2C3QZsEtSjrr/DxKwy0uf8FiTH2hgnElTTV1zQw+wvX+f
	 xhBk9K8u6aamBp/jxBCfJomuoAbnvTTMhIjazy+hxlp2Sc1AS68SY4SAPnlutJUUA0
	 F4g8i/7vmPJROPk6CcvJQBtyUUDqiQa8+zdh+r5CDbJwfHi3GAnTX512+5HTzliM69
	 ysKcnBOR1WVC6nlBpZol5yRL/XSGE7A+cjXX97j8xrH3GcWaJhs2WIbQbHOO8uV8fM
	 0G+ItCjc1SUpfOGyaUd191hE17bNijy9Uexc1IWKX/HnHx1KEiKarlKeTFzaLEUFde
	 0QKf7tTk+88rw==
Content-Type: multipart/mixed; boundary="===============6841024937421000205=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <a730406467ad370067e7ceaa5beff37da1758e9c2cda838f7c2fe1261d60b2cf@mail.kernel.org>
In-Reply-To: <20260926-scev-minimal-rebase-v1-26-c8e5ab5ba79f@gmail.com>
References: <20260926-scev-minimal-rebase-v1-26-c8e5ab5ba79f@gmail.com>
Subject: Re: [PATCH bpf-next 26/36] bpf: avoid widening registers that hinder exact stack-slot tracking
From: bot+bpf-ci@kernel.org
To: eddyz87@gmail.com,bpf@vger.kernel.org,ast@kernel.org,andrii@kernel.org
Cc: daniel@iogearbox.net,martin.lau@linux.dev,kernel-team@fb.com,yonghong.song@linux.dev,eddyz87@gmail.com,memxor@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Sun, 27 Sep 2026 20:43:03 +0000 (UTC)

--===============6841024937421000205==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/scev.c b/kernel/bpf/scev.c
> index 205bf8684c3d..1fa6b25a4f29 100644
> --- a/kernel/bpf/scev.c
> +++ b/kernel/bpf/scev.c

[ ... ]

> @@ -1021,6 +1021,65 @@ static void reset_scevs_at_indirect_writes(struct bpf_verifier_env *env, struct
>  	}
>  }
>
> +/* OR the loop-entry registers referenced by expr 'id' into 'mask'. */
> +static void or_expr_regs(struct bpf_verifier_env *env, u32 id, unsigned long *mask)
> +{
> +	struct scev *scev = env->scev;
> +	u32 order;
> +
> +	scev->stack_sz = 0;
> +	expr_stack_push(scev, id);
> +	while (expr_next(scev, &id, &order)) {
> +		if ((order & PRE) && scev->exprs[id].op == REG)
> +			__set_bit(scev->exprs[id].params[0], mask);
> +	}
> +}

Does or_expr_regs() handle the DEPTH_LIMIT case? expr_next() stops
descending at EXPR_STACK_DEPTH (8) and returns POST | DEPTH_LIMIT without
visiting children. REG leaves below level 8 would be dropped from the mask,
but or_expr_regs() needs to collect every loop-entry register the stack
base expression depends on because the result blocks widening. Deep
expressions are easy to produce since transfer() wraps every ALU32 result
in ZEXT32:

  r6 = 0
  w1 = w6          ; zext(r6)
  w1 += 1          ; zext(add(zext(r6),1))
  w1 &= 1          ; zext(and(...))
  w1 <<= 3         ; zext(lsh(...))
  r3 = r10
  r3 += -16
  r3 += r1         ; REG r6 is at level 9 of r3's expr
  r4 = *(u64 *)(r3 + 0)   ; fill of a spilled ctx pointer
  r0 = *(u32 *)(r4 + 0)
  r6 += 1
  if r6 < 4 goto 1b

In collect_store_base_regs(), r3 would be selected for the LDX since r3
is in stack_ptrs. or_expr_regs() would record r10 but not r6, so r6 gets
widened to [0..3]. The fill then has a variable offset and yields a
SCALAR, rejecting the ctx dereference. The same program verifies when the
loop is enumerated.

Other traversals in this file handle this conservatively:
is_any_imm_reg() and is_any_imm_reg_opaque() return false on DEPTH_LIMIT,
and union_any_reg() treats it as a verifier_bug. Setting all bits
of mask (bitmap_fill) when DEPTH_LIMIT is seen would keep the analysis
conservative.

[ ... ]

> @@ -1975,6 +2040,7 @@ int bpf_compute_loop_iters(struct bpf_verifier_env *env, struct bpf_verifier_sta
>  	for (r = 0; r < REGS_NUM; r++) {
>  		struct bpf_reg_state *reg;
>  		u32 ra, r_scev, r_expr;
> +		bool spill_base = false;
>
>  		if (!scev_reg_alive(env, st, r))
>  			continue;
> @@ -1984,10 +2050,16 @@ int bpf_compute_loop_iters(struct bpf_verifier_env *env, struct bpf_verifier_sta
>  		/* If SCEV for r is (linear <reg> <slope>) */
>  		if (is_simple_linear(scev, r_scev, &base_reg, &slope_imm) &&
>  		    is_widenable_reg_type(reg)) {
> -			/* Can't widen if the iteration range overflows */
> -			if (base_reg == r &&
> -			    !linear_bounds(reg, iters, slope_imm, &bounds))
> -				goto cant_widen;
> +			if (base_reg == r) {
> +				/* Can't widen if the iteration range overflows */
> +				if (!linear_bounds(reg, iters, slope_imm, &bounds))
> +					goto cant_widen;
> +				/* Spills at varying offsets lose precision */
> +				if (test_bit(r, loop->store_base_regs)) {
> +					spill_base = true;
> +					goto cant_widen;
> +				}
> +			}
>  			continue;
>  		}
>
> @@ -2006,6 +2078,8 @@ int bpf_compute_loop_iters(struct bpf_verifier_env *env, struct bpf_verifier_sta

Does the store_base_regs check apply to all register types? The check
only runs for registers whose SCEV is (linear r slope). Registers accepted
by is_any_imm_reg() skip it and are widened via union_any_reg() later in
bpf_widen_scev_regs(), again without consulting store_base_regs.

A register j that is 0 on entry and set to 1 at the end of each iteration
has the header SCEV (any j 1). If the body fills a spilled pointer from
ptrs[j] (LDX with base fp-16 + j*8), or_expr_regs() puts j into
store_base_regs. j is still widened to [0..1], the fill has a variable
offset, and the pointer comes back as a SCALAR. The loop enumerates fine
without widening, so this is the same precision loss the commit is meant
to prevent.

The commit message states: "During the loop-widening stage,
bpf_widen_scev_regs() refuses to widen a loop when some of the registers
the loop changes appear in store_base_regs." The refusal is actually in
bpf_compute_loop_iters(), not bpf_widen_scev_regs(), and it covers only
self-based linear registers, not every register the loop changes. The
message also calls the field bpf_loop->store_base_reg instead of
store_base_regs.

Either apply the test_bit(r, loop->store_base_regs) check before the
is_any_imm_reg() acceptance too, or reword the message to state the
narrower rule.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/36346543957
--===============6841024937421000205==--
