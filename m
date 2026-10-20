Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792496144;
	b=hrpouubN24dtEFbrO9gH/0JFxZEwJj5rXh7yDNHlteA5niGLjtgBEDCo+0Fmt4aWrspy
	 7wbuFFFyMbazrM3xFiPwqaKBLioiuC92vdb0aq49cMCu3VX7wAoO6i0ruLI8uzU6TFYUQ
	 +uESz7nIFze/7aI9OeHatO/dwxWEjJyetNAMwbM7jdFlMMfNJ+Ah2Ilgmu7b/Pw6OwDe+
	 qlP4i3NTagBovUqVg86sF00yn9ko8BSDZBbz2T2XYLqQvC3bVxBRCmE85iPZM2Op6bK5x
	 lNbJMGb3qUclbzkgoN0w8cdcnLXPf0br+8gRohECGUI6DJWkRIrZsvpDde76bpcF0cg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792496144;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=R9B8eYpJda7kuAvwpFEWDf5XPGZ2X5HhGOLodbuiADU=;
	b=KAolLxjLHPahauCabSL5JOzGUAZ5nvXeA4iSAxVzuBZdvudHyXKQaJpQ8djNAnBNSHlH
	 tIfvscT9pJ2JDuui8NNZ0m04KTdUAlpdKaF8VIRM7mlQMNpigwCL2Vgqj8x6FI2vXHl/f
	 Iz3BNWOTLlpHGBbVUtLAfYcKkLXGwzzYq3OI/650/g29GiNCXe2lEyXd83sUPmFDRfTA5
	 9z7hm8lwqBatT4byEXFj4wqJ+pmoFDUbVe1iqvT5kGsW/hnKOofku4OjEROpuy4gb5q1r
	 qz+Qi3eEQOOkdb6Gtl1lIAiYvMSvx5ugylNdu1nALpvwTi0RjasqBkS4j+PGdE4Sk8g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DGn7LzVk;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BD16606A31B
	for <bpf@vger.kernel.org>; Tue, 20 Oct 2026 11:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DGn7LzVk
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E13011F000C4;
	Tue, 20 Oct 2026 11:35:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792496144;
	bh=R9B8eYpJda7kuAvwpFEWDf5XPGZ2X5HhGOLodbuiADU=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=DGn7LzVkUQVPytZ90rFpP8F81hFZxWevtFmctQyIMafnZ+wAygsgOEerxrHbxqfxy
	 l6cONVh4Zr2a80cxeND9/U+yY54hXm23Da5J7V7YItPEOlu3oYJ7c1IkqOXOEdg4PR
	 /tBPB9DyBXt6E2+HP1zBtBokli5Yptc4uGsJpmIE58FeZ86oZx3i5lQhHku+tul9rx
	 jA8xEZX70wd2zEtJ7+mibO7ZCFo4E2juUK2VHDChCg6KK6kKtK5zMQhgiOWiKqNACv
	 rLmFe94xwef2/RlQvpwC5IJ/z4GVWlJd5ESRDGJnK+1DVfZINBA0+JI+DYH9PfOzKE
	 METJSrpA8KygQ==
Content-Type: multipart/mixed; boundary="===============3278452598389739939=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <77720df26bea4edfd16a92d307115ad152f9ab558df8848fd8e0d7cb31e9f5eb@mail.kernel.org>
In-Reply-To: <20261020-scev-32bit-v1-1-838f34f9f0cd@gmail.com>
References: <20261020-scev-32bit-v1-1-838f34f9f0cd@gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: support 32-bit linear scalar evolution
From: bot+bpf-ci@kernel.org
To: eddyz87@gmail.com,bpf@vger.kernel.org,ast@kernel.org
Cc: andrii@kernel.org,daniel@iogearbox.net,kernel-team@fb.com,yonghong.song@linux.dev,eddyz87@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Tue, 20 Oct 2026 11:35:43 +0000 (UTC)

--===============3278452598389739939==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: support 32-bit linear scalar evolution

TL;DR:
- JMP32 pointer latches may give too-small iteration bounds, risking unsafe
  memory access
- zext32 clamping may hit verifier_bug on an empty 32-bit range, or clamp
  pointers wrongly
- verifier_scev selftest log breaks until a later patch

> diff --git a/kernel/bpf/scev.c b/kernel/bpf/scev.c
> index 48500d73105a..fea77772ca96 100644
> --- a/kernel/bpf/scev.c
> +++ b/kernel/bpf/scev.c

[ ... ]

> @@ -2217,6 +2212,115 @@ static bool compute_max_iters(struct bpf_verifier_env *env,

[ ... ]

> +static bool compute_max_iters(struct bpf_verifier_env *env,
> +			      struct bpf_func_state *st,
> +			      struct linear_latch *latch,
> +			      struct bpf_loop_iters *iters)

[ ... ]

> +	if (!scev_value_compatible(env, st, &initial_val, &bound_val))
> +		return false;
> +
> +	initial = initial_val.value;
> +	step = step_val.value;
> +	bound = bound_val.value;
> +
> +	/*
> +	 * The code below only handles mixed 64-bit/32-bit comparisons/recurrences
> +	 * when initial bounds and step fit in 32-bit domain.
> +	 */
> +	if (latch->zext32 || latch->jmp32) {
> +		/*
> +		 * With the above constraint doing `l: w0 += 1; if r0 s< 256 goto l;`
> +		 *                is equivalent to `l: w0 += 1; if r0 < 256 goto l;`
> +		 */
> +		if (latch->jmp32 && is_signed_op(op)) {
> +			initial = (s64)(s32)(u32)initial;
> +			bound   = (s64)(s32)(u32)bound;
> +			step    = (s64)(s32)(u32)step;
> +		} else {
> +			initial = (u32)initial;
> +			bound   = (u32)bound;
> +			step    = (s64)(s32)(u32)step;
> +		}
> +	}

Can a JMP32 latch whose operands are pointers get through this code?

Before this patch match_linear_latch() rejected every latch that was not
BPF_JMP, but it now accepts BPF_JMP32, and compute_max_iters() never checks
whether the latch operands are pointers.  scev_value_compatible() still
accepts two pointers with the same memory origin (PTR_TO_STACK in the same
frame, PTR_TO_MAP_VALUE with the same id, PTR_TO_MEM/PTR_TO_BUF with the same
id), and for those eval_expr() returns reg->var_off.value, which is the
offset from the object and not the address.

For 64-bit comparisons, comparing offsets is equivalent to comparing
addresses because kernel addresses do not wrap.  A JMP32 comparison is
different, since at runtime it compares the low 32 bits of the absolute
addresses, and those bits can wrap (unsigned) or cross the sign boundary
(signed) anywhere inside an object.  is_branch_taken() already says so for
this exact case:

    /*
     * The low 32 bits of a valid pointer may well be zero, hence
     * nothing below applies to a 32-bit comparison.
     */
    if (is_jmp32)
        return -1;

The 32-bit handling here (truncate or sign-extend the operands, then
range-check total_change) only reasons about the offset values.  It cannot
tell whether the low 32 bits of base+offset stay on one side of the wrap or
sign boundary.

For a pointer-vs-pointer JMP32 latch (allowed for privileged programs, since
check_cond_jmp_op() only rejects pointer comparisons when !allow_ptr_leaks),
can the computed max_header_count end up smaller than the real number of
iterations?  bpf_widen_scev_regs() and bpf_clamp_scev_regs() then bound the
induction pointer's range with that count, and the memory access checks
inside the loop depend on it being a true upper bound.

Would it make sense to return false here when latch->jmp32 is set and either
initial_val.ptr_reg or bound_val.ptr_reg is >= 0?  zext32 latches cannot
involve pointers, because ALU32 on pointers is rejected.

[ ... ]

> @@ -2542,8 +2699,7 @@ int bpf_compute_loop_iters(struct bpf_verifier_env *env, struct bpf_verifier_sta
>  		r_scev = header_env->reg2scev[r];
>  		reg = scev_reg_for_linear(cur_func, r);
>  		/* If SCEV for r is (linear <reg> <slope>) */
> -		if (is_simple_linear(scev, r_scev, &base_reg, &slope_imm) &&
> -		    reg && is_widenable_reg_type(reg)) {
> +		if (reg && is_simple_linear(scev, r_scev, &coefs) && is_widenable_reg_type(reg)) {

Can this classify a register that holds a pointer at loop entry as a
widenable linear induction variable?

is_simple_linear() now also accepts (zext32 (linear rA imm)).  The header
SCEV for such a register comes from reg2expr == (zext32 (+ rA imm)), and the
new simplify() rule also produces that form from 'wA = wA; wA += imm'.

When allow_ptr_leaks is set, check_alu_op() handles a 32-bit MOV from a
pointer by calling mark_reg_unknown().  The register is then SCALAR_VALUE at
the backedge while it is still a pointer type at loop entry.

is_widenable_reg_type() is only checked here, against the header-state
register.  bpf_clamp_scev_regs() skips only NOT_INIT entry registers and
never checks that entry_reg->type matches reg->type, so linear_bounds()
builds bounds from the entry pointer's offset range (reg->r64/var_off
describe the offset for pointers, not the value):

    linear_bounds(entry_reg, max_header_count, &coefs, &bounds);
    bounds.r64 = cnum64_intersect(reg->r64, bounds.r64);

Those bounds are intersected into the scalar register on every backedge, so
the scalar is tracked with bounds that don't describe its runtime value.  If
the intersection is empty, the verifier_bug("scev clamp produced empty
range") path fires instead.

Before this patch a zext32 SCEV was never linear, so this register hit
'can't widen' and no clamping happened.  This was traced from the code only,
not from running a reproducer.

Should the zext32 case require reg->type == SCALAR_VALUE in
bpf_compute_loop_iters()/bpf_widen_scev_regs(), and should
bpf_clamp_scev_regs() skip registers whose current type differs from
entry_reg->type?

[ ... ]

> @@ -2737,9 +2891,10 @@ int bpf_clamp_scev_regs(struct bpf_verifier_env *env, struct bpf_func_state *cur
>  		    is_unbound_scev_reg(env, entry_st, r))
>  			continue;
>  
> -		linear_bounds(entry_reg, max_header_count, slope_imm, &bounds);
> -		bounds.range = cnum64_intersect(reg->r64, bounds.range);
> -		if (cnum64_is_empty(bounds.range)) {
> +		linear_bounds(entry_reg, max_header_count, &coefs, &bounds);
> +		bounds.r64 = cnum64_intersect(reg->r64, bounds.r64);
> +		bounds.r32 = cnum32_intersect(reg->r32, bounds.r32);
> +		if (cnum64_is_empty(bounds.r64)) {
>  			verifier_bug(env, "scev clamp produced empty range for r%d", r);
>  			return -EFAULT;
>  		}

Can bounds.r32 be empty here while bounds.r64 is not?  Only the 64-bit
intersection is checked for emptiness before both ranges are passed to
bpf_set_reg_range().

For zext32 induction variables linear_bounds() sets bounds.r64 to
cnum64_zext32(r32).  When the 32-bit arc wraps through 0 that is the full
[0, U32_MAX], so the 64-bit intersection with any zero-extended value is
non-empty while the 32-bit intersection can still be empty.

In that case bpf_set_reg_range() stores CNUM32_EMPTY in reg->r32 and
reg_bounds_sync() returns early because range_bounds_violation() is true.
reg_bounds_sanity_check() then fires:

    verifier_bug("REG INVARIANTS VIOLATION (bpf_set_reg_range): range bounds violation")

verifier_bug() is a WARN_ONCE on CONFIG_DEBUG_KERNEL kernels.  With
BPF_F_TEST_REG_INVARIANTS the load fails with -EFAULT, and without it the
register is reset to unbounded.

This can be reached without a verifier bug.  The verifier does not track the
link between the latch IV and other IVs, so a branch in the loop body can
narrow a non-latch IV to its exit value, and that state still reaches the
backedge.  Example (needs allow_uninit_stack, i.e. a privileged loader):

  0: r1 = 0
  1: w3 = -4             ; r3 = 0xfffffffc
  2: w3 += 2             ; loop header
  3: if w3 != 6 goto +1
  4: r2 = 0
  5: r1 += 1
  6: if r1 != 5 goto -5  ; latch, max_header_count = 5
  7: r0 = 0
  8: exit

Header values of w3 are 0xfffffffc, 0xfffffffe, 0, 2, 4.  linear_bounds()
gives r32 = {0xfffffffc, 8} and r64 = [0, U32_MAX].

On the first widened pass the body sees w3 in {0xfffffffe..6}.  The
fall-through of 'if w3 != 6' refines w3 to 6, so r64 = {6}.  The widened
r1 = [0,4] becomes [1,4] after the latch refinement, so the backedge is
taken.  At the header bpf_clamp_scev_regs() computes:

  cnum64_intersect({6}, [0, U32_MAX]) = {6}   (passes the r64 check)
  cnum32_intersect({6}, {0xfffffffc..4}) = CNUM32_EMPTY

and passes the empty r32 to bpf_set_reg_range().

Before this patch zext32 IVs were never widened or clamped (is_simple_linear()
did not match zext32), and the clamp always passed CNUM32_UNBOUNDED for r32,
so this program verified without any warning.

Should cnum32_is_empty(bounds.r32) be checked alongside r64 here?  The same
infeasible-backedge pattern with a 64-bit IV (r3 += 2; if r3 != 10 goto +1)
appears to reach the existing r64 check and fail with -EFAULT, so would
treating an empty clamp intersection as an unreachable path, instead of
calling verifier_bug(), be the better fix for both?

> @@ -2747,13 +2902,12 @@ int bpf_clamp_scev_regs(struct bpf_verifier_env *env, struct bpf_func_state *cur
>  			bpf_log(log, "loop header at %d, clamping ", insn_idx);
>  			log_reg(env, r);
>  			bpf_log(log, " to ");
> -			bpf_verbose_snum(env, cnum64_smin(bounds.range));
> -			bpf_log(log, "..");
> -			bpf_verbose_snum(env, cnum64_smax(bounds.range));
> -			bpf_log(log, " step %u\n", bounds.step);
> +			log_bounds(env, &bounds);
> +			bpf_log(log, "\n");
>  		}

Does this change the clamp log line for 64-bit IVs as well?  For a non-zext
IV, bounds.r32 starts as CNUM32_UNBOUNDED, so
cnum32_intersect(reg->r32, bounds.r32) just returns the current reg->r32.
When that range is bounded, log_bounds() now prints an extra " (s32 ..)"
part.

verifier_scev.c post_cond_jne_neg_step (r0 = 3; r0 += -1; if r0 != 0 goto)
still expects:

    __msg("loop header at 1, clamping r0 to 1..2 step 1")

The kernel now prints "loop header at 1, clamping r0 to 1..2 (s32 1..2) step
1", so that test fails at this commit.  This patch updates
verifier_stack_ptr.c for the new format but not verifier_scev.c.

The expectation is changed later in the series, by commit a8fb69f8ae2e
("selftests/bpf: tests for 32-bit scalar evolution bounds computation"), to
"clamping r0 to 1..2 (s32 1..2) step 1".  Until then the series is not
bisectable for test_progs -t verifier_scev.  Could the verifier_scev.c
update be folded into this patch?

Related: for non-zext IVs the printed "(s32 ..)" range is the unclamped
current r32, so it can be wider than the clamped 64-bit range, for example
"clamping r7 to -64..-16 (s32 -64..-8)".  Could that be misleading in the
log?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/39413885357
--===============3278452598389739939==--
