Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792496336;
	b=BWyIryIpWYAfdFOQnMT88EFpmhUu1OlhEgDxBx9uLGDGWt0zO3gN9KMbf0D2Hy3USShQ
	 LzbnQsQ8cRabcvb9WCju/xsbtzZwKTklW9EbdA9NY4nXSKQjonWGhq1xjyc9jiQ1lcLwg
	 8mZSCGbtXDdztItqXRb8LTcQWvPN1kVYH+l3wWTCtGaOg/ALKtXDPFxXOfTsphvsVfXot
	 aTkliwsa8iFOO8+rhVYuea2MLoS5B5dSnc6BdnU60zp4n1a+CBzpoU9ibeIbLBnC+hVUO
	 o5LvVvHBVim74rNJNXO5hbXnoK5Tf25JbHn7mEgsKlFy4hYimqvohehCVbArD8OMS/w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792496336;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=+e2HGUufGndywM78OmSn0/bbZIxSKb60l1PVVJps0BY=;
	b=f2Q3gfpUGdgkF0h+L9LFjaW2Dw3GOVzbkSKo9hLQ13eiyOVV8DWptpnlcN5oPQVWup3n
	 k/IX0loR2tsIVhR2YfdW5fYNF4Ngb3yS30T9I9Px3zkrFKb2AKmpamADQf9IjFPUYXHR2
	 PelqxWWR7k7cns29vOeA/dB3r6VDrqgv+RukxRyNDLleOQFR4fxWVYEyYySu4vYGuhRru
	 jZO+45oyFNPix3CLsVq33Zc7doCMvFhetAOaR8KYt2jHo43VfzNmjwlHeN+8ssFzCaNvc
	 PjEAeZgKkBchUSUv5kC0VRxxcmqTmu+Z9/zMFPwSGX+vs+DGj9cdA2vWmg7lqSzZz1Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jffCaxuX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E07DF606A32C
	for <bpf@vger.kernel.org>; Tue, 20 Oct 2026 11:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jffCaxuX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 567C11F000C4;
	Tue, 20 Oct 2026 11:38:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792496335;
	bh=+e2HGUufGndywM78OmSn0/bbZIxSKb60l1PVVJps0BY=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=jffCaxuXHB6XJFoUWQHfUb2htkhviW7tB4qXl5loRAxnnvv8Wkpaw39A40TaGYafh
	 xpjgGpySZ2JI1trmWi9ehW50OlKSDXlW6WkWzyvuih1vtxCxyJsqJmtXMsVk/vOzkA
	 csQ/PTBuMdd7ECImtXgWj6PFeIdXZItFjYfh/tVz0KPPWbSLJbI7IFpTV26zGKdYts
	 6QIMTaHfP2ZK3BQNayLdLvc+AywwncrgImjqF2LvG+R4YVC1J8rUVqsVbhZ+npW2Wo
	 e6YXAp1AQwXaFzW3zFqd0oaWwXxSvxShthLK11oQXzCyavVdwC7FwhbgS9LO0xP9Fk
	 SglMEsj1/8POA==
Message-ID: <sashiko-outbox-178898@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 1/2] bpf: support 32-bit linear scalar
 evolution
Reply-To: sashiko-reviews@lists.linux.dev
To: "Eduard Zingerman" <eddyz87@gmail.com>, bpf@vger.kernel.org
In-Reply-To: <20261020-scev-32bit-v1-1-838f34f9f0cd@gmail.com>
References: <20261020-scev-32bit-v1-0-838f34f9f0cd@gmail.com>
 <20261020-scev-32bit-v1-1-838f34f9f0cd@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 20 Oct 2026 11:38:54 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Critical] bpf: 32-bit linear SCEV corrupts pointer and scalar bounds
- [Critical] bpf: compute_max_iters() uses pointer offsets for 32-bit latch=
es
- [Medium] bpf: bpf_clamp_scev_regs() misses empty r32 check on clamping
--

commit c93c9841341e0885c177c1612799cb18f92b0bfc
Author: Eduard Zingerman <eddyz87@gmail.com>

bpf: support 32-bit linear scalar evolution

This commit extends BPF scalar evolution (SCEV) analysis to represent and
compute iteration counts and widened bounds for 32-bit ALU recurrences and
32-bit conditional jumps. It also updates struct bounds and
bpf_set_reg_range() to track both 32-bit and 64-bit circular number ranges.

> diff --git a/kernel/bpf/scev.c b/kernel/bpf/scev.c
> index 48500d73105ac..fea77772ca967 100644
> --- a/kernel/bpf/scev.c
> +++ b/kernel/bpf/scev.c

[ ... ]

> @@ -2217,6 +2212,115 @@ static bool compute_max_iters(struct bpf_verifier=
_env *env,
>  		return false;
>  	}
> =20
> +	*result =3D backedge_taken_count;
> +	return true;
> +}
> +
> +/*
> + * Loop with post-condition:
> + *
> + *    r0 =3D 0
> + * l: ...                r0 =E2=88=88 [0,1,2] header executed 3 times
> + *    r0 +=3D 1            r0 =E2=88=88 [0,1,2]
> + *    ...                r0 =E2=88=88 [1,2,3]
> + *    if r0 !=3D 3 goto l  r0 =E2=88=88 [1,2,3] backedge taken 2 times
> + *    ...                r0 =E2=88=88 [3]
> + *
> + * SCEV at header: r0 =3D k
> + * SCEV at latch:  r0 =3D 1 + k
> + *
> + * Loop with pre-condition:
> + *
> + *    r0 =3D 0
> + * l: ...                r0 =E2=88=88 [0,1,2,3] header executed 4 times
> + *    if r0 =3D=3D 3 goto e  r0 =E2=88=88 [0,1,2,3] backedge taken 3 tim=
es
> + *    r0 +=3D 1            r0 =E2=88=88 [0,1,2]
> + *    ...                r0 =E2=88=88 [1,2,3]
> + *    goto l             r0 =E2=88=88 [1,2,3]
> + * e: ...                r0 =E2=88=88 [3]
> + *
> + * SCEV at header: r0 =3D k
> + * SCEV at latch:  r0 =3D k
> + */
> +static bool compute_max_iters(struct bpf_verifier_env *env,
> +			      struct bpf_func_state *st,
> +			      struct linear_latch *latch,
> +			      struct bpf_loop_iters *iters)
> +{
> +	struct bpf_insn_aux_data *aux =3D env->insn_aux_data;
> +	struct bpf_loop *loop =3D aux[bpf_loop_at_index(env, latch->insn_idx)].=
loop;
> +	struct scev *scev =3D env->scev;
> +	struct scev_value initial_val, step_val, bound_val;
> +	u64 step, bound, initial, total_change, backedge_taken_count;
> +	u8 op =3D latch->op;
> +
> +	if (!eval_expr(env, scev, st, latch->base_expr, &initial_val) ||
> +	    !eval_expr(env, scev, st, latch->step_expr, &step_val) ||
> +	    !eval_expr(env, scev, st, latch->bound_expr, &bound_val))
> +		return false;
> +
> +	if (step_val.ptr_reg >=3D 0) {
> +		if (env->log.level & BPF_LOG_LEVEL2) {
> +			bpf_log(&env->log, "scev: latch step is a pointer ");
> +			log_scev_value(env, st, &step_val);
> +			bpf_log(&env->log, "\n");
> +		}
> +		return false;
> +	}
> +	if (!scev_value_compatible(env, st, &initial_val, &bound_val))
> +		return false;
> +
> +	initial =3D initial_val.value;
> +	step =3D step_val.value;
> +	bound =3D bound_val.value;
> +
> +	/*
> +	 * The code below only handles mixed 64-bit/32-bit comparisons/recurren=
ces
> +	 * when initial bounds and step fit in 32-bit domain.
> +	 */
> +	if (latch->zext32 || latch->jmp32) {

[Severity: Critical]
Should compute_max_iters() reject pointer operands (initial_val.ptr_reg >=
=3D 0
or bound_val.ptr_reg >=3D 0) when latch->zext32 or latch->jmp32 is true?

When eval_expr() evaluates a constant-offset pointer register, it sets
result->value to reg->var_off.value (the offset relative to the runtime base
address) and result->ptr_reg >=3D 0. If two registers r1 and r2 point to the
same memory object (for example, PTR_TO_PACKET, PTR_TO_MAP_VALUE, or
PTR_TO_STACK with r1 =3D base + 0 and r2 =3D base + 9), scev_value_compatib=
le()
succeeds.

While comparing relative offsets works for 64-bit jumps and 64-bit pointer
arithmetic because valid kernel objects do not cross 64-bit address space
boundaries, a BPF_JMP32 latch (such as "if w1 < w2 goto l" with "r1 +=3D 2")
compares the low 32 bits of the runtime kernel addresses: (u32)(base + offs=
et)
or (s32)(base + offset).

Because (u32)base is unknown at verification time and can sit near U32_MAX =
or
S32_MAX, (u32)(base + initial + k * step) and (u32)(base + bound) can wrap
around U32_MAX -> 0 or S32_MAX -> S32_MIN at runtime even when the relative
offsets initial, bound, and total_change are small (e.g. if (u32)base =3D=3D
0xfffffff6, then w2 =3D=3D 0xffffffff and w1 wraps around U32_MAX on even v=
alues
without terminating). Can this cause compute_max_iters() to compute an
unsound max_header_count and widen pointer or scalar induction variables to
incorrect bounds?

> +		/*
> +		 * With the above constraint doing `l: w0 +=3D 1; if r0 s< 256 goto l;`
> +		 *                is equivalent to `l: w0 +=3D 1; if r0 < 256 goto l;`
> +		 */
> +		if (latch->jmp32 && is_signed_op(op)) {
> +			initial =3D (s64)(s32)(u32)initial;
> +			bound   =3D (s64)(s32)(u32)bound;
> +			step    =3D (s64)(s32)(u32)step;
> +		} else {
> +			initial =3D (u32)initial;
> +			bound   =3D (u32)bound;
> +			step    =3D (s64)(s32)(u32)step;
> +		}
> +	}

[ ... ]

> @@ -2542,8 +2699,7 @@ int bpf_compute_loop_iters(struct bpf_verifier_env =
*env, struct bpf_verifier_sta
>  		r_scev =3D header_env->reg2scev[r];
>  		reg =3D scev_reg_for_linear(cur_func, r);
>  		/* If SCEV for r is (linear <reg> <slope>) */
> -		if (is_simple_linear(scev, r_scev, &base_reg, &slope_imm) &&
> -		    reg && is_widenable_reg_type(reg)) {
> +		if (reg && is_simple_linear(scev, r_scev, &coefs) && is_widenable_reg_=
type(reg)) {

[Severity: Critical]
Can allowing coefs.zext32 on non-scalar registers corrupt pointer and scalar
bounds during widening and clamping?

In bpf_compute_loop_iters(), is_widenable_reg_type(reg) accepts pointer typ=
es
such as PTR_TO_MAP_VALUE, PTR_TO_STACK, and PTR_TO_PACKET alongside
SCALAR_VALUE, even when is_simple_linear() sets coefs.zext32 =3D true (for
example, when a loop body executes "w7 +=3D 8" on a register r7 holding a
pointer at loop entry).

This leads to two issues:

1. At loop entry, bpf_widen_scev_regs() calls linear_bounds() with
coefs.zext32 =3D true on the pointer's relative offset while keeping reg->t=
ype
as a pointer. For negative pointer offsets such as fp-64, cnum64_zext32()
zero-extends the 32-bit offset to 0xffffffc0.. and unions it into reg->r64 =
on
a PTR_TO_STACK register. For PTR_TO_MAP_VALUE at offset 0 (with 4 header
visits and step 8), bpf_widen_scev_regs() widens r7 at the header to
PTR_TO_MAP_VALUE with offset [0, 24].

2. When do_check() verifies "w7 +=3D 8" in the loop body with
env->allow_ptr_leaks enabled, adjust_ptr_min_max_vals() rejects 32-bit
pointer arithmetic via mark_reg_unknown() and scalar32_min_max_add(), turni=
ng
r7 in cur_func_state into an unknown SCALAR_VALUE holding the low 32 bits of
the runtime kernel pointer plus 8. When execution reaches the loop header
along the backedge, bpf_clamp_scev_regs() computes linear_bounds() from
entry_reg (which is still PTR_TO_MAP_VALUE with offset 0, yielding bounds
[0, 24]) and intersects those pointer-offset bounds directly into reg (which
is now SCALAR_VALUE) without checking that entry_reg and reg are scalars or
have matching types. The verifier then treats scalar r7 as bounded to [0, 2=
4]
while at runtime it holds (u32)map_value_kaddr + 8.

Should zext32 linear SCEVs be restricted to reg->type =3D=3D SCALAR_VALUE (=
and
should bpf_clamp_scev_regs() verify that entry_reg and reg have compatible
types)?

>  			/* Spills at varying offsets lose precision */
>  			if (test_bit(r, loop->store_base_regs)) {
>  				spill_base =3D true;

[ ... ]

> @@ -2737,9 +2891,10 @@ int bpf_clamp_scev_regs(struct bpf_verifier_env *e=
nv, struct bpf_func_state *cur
>  		    is_unbound_scev_reg(env, entry_st, r))
>  			continue;
> =20
> -		linear_bounds(entry_reg, max_header_count, slope_imm, &bounds);
> -		bounds.range =3D cnum64_intersect(reg->r64, bounds.range);
> -		if (cnum64_is_empty(bounds.range)) {
> +		linear_bounds(entry_reg, max_header_count, &coefs, &bounds);
> +		bounds.r64 =3D cnum64_intersect(reg->r64, bounds.r64);
> +		bounds.r32 =3D cnum32_intersect(reg->r32, bounds.r32);
> +		if (cnum64_is_empty(bounds.r64)) {
>  			verifier_bug(env, "scev clamp produced empty range for r%d", r);
>  			return -EFAULT;
>  		}

[Severity: Medium]
Can bpf_clamp_scev_regs() pass an empty bounds.r32 to bpf_set_reg_range() a=
nd
trigger a register invariants violation in reg_bounds_sanity_check()?

In linear_bounds(), when coefs->zext32 is true and the 32-bit range wraps
around 0 and U32_MAX (e.g. w1 =3D 0 at entry, step =3D -1, two header visit=
s),
bounds.r64 becomes [0, U32_MAX] while bounds.r32 is [-1, 0] (similarly, if
entry_reg has non-zero upper 32 bits, bounds.r64 is wider than bounds.r32).

If an in-loop branch refines reg on the backedge to a 32-bit value outside
bounds.r32 (for example, w1 =3D=3D -2, so reg->r64 is [0xfffffffe, 0xffffff=
fe]
and reg->r32 is [-2, -2]), intersecting reg->r64 with [0, U32_MAX] produces=
 a
non-empty bounds.r64, whereas intersecting reg->r32 with [-1, 0] produces
CNUM32_EMPTY. (A similar situation can occur when !coefs->zext32 leaves
bounds.r32 as CNUM32_UNBOUNDED, and deduce_bounds_32_from_64() inside
reg_bounds_sync() intersects reg->r32 with the 32-bit projection of
bounds.r64.)

Because bpf_clamp_scev_regs() only checks cnum64_is_empty(bounds.r64), it
proceeds to bpf_set_reg_range(), where reg_bounds_sanity_check() flags
cnum32_is_empty(reg->r32) as a range bounds violation. Should
bpf_clamp_scev_regs() also check cnum32_is_empty(bounds.r32)?

> @@ -2747,13 +2902,12 @@ int bpf_clamp_scev_regs(struct bpf_verifier_env *=
env, struct bpf_func_state *cur
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
>  		scratch_widened_reg_id(env, reg);
> -		err =3D bpf_set_reg_range(env, reg, bounds.range, bounds.base, bounds.=
step);
> +		err =3D bpf_set_reg_range(env, reg, bounds.r64, bounds.r32,
> +					bounds.base, bounds.step);
>  		if (err)
>  			return err;
>  		mark_scev_reg_scratched(env, r);

[ ... ]

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index d138688468236..ea26da040ff96 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -17587,10 +17587,10 @@ bool bpf_same_memory_origin(const struct bpf_re=
g_state *reg_a,
>  }
> =20
>  int bpf_set_reg_range(struct bpf_verifier_env *env, struct bpf_reg_state=
 *reg,
> -		      struct cnum64 range, u16 base, u16 step)
> +		      struct cnum64 r64, struct cnum32 r32, u16 base, u16 step)
>  {
> -	reg->r64 =3D range;
> -	reg->r32 =3D CNUM32_UNBOUNDED;
> +	reg->r64 =3D r64;
> +	reg->r32 =3D r32;
>  	reg->step =3D step;
>  	reg->base =3D base;
>  	reg->var_off =3D tnum_unknown;

[ ... ]

=E5=AE=8C=E7=BE=8E

 Let me double-check that I didn't accidentally output any trailing charact=
ers or markdown. Wait=E2=80=94I have not output the final response yet! Let=
's output the clean plain-text report now, ending with a blank line.commit =
c93c9841341e0885c177c1612799cb18f92b0bfc
Author: Eduard Zingerman <eddyz87@gmail.com>

bpf: support 32-bit linear scalar evolution

This commit extends BPF scalar evolution (SCEV) analysis to represent and
compute iteration counts and widened bounds for 32-bit ALU recurrences and
32-bit conditional jumps. It also updates struct bounds and
bpf_set_reg_range() to track both 32-bit and 64-bit circular number ranges.

> diff --git a/kernel/bpf/scev.c b/kernel/bpf/scev.c
> index 48500d73105ac..fea77772ca967 100644
> --- a/kernel/bpf/scev.c
> +++ b/kernel/bpf/scev.c

[ ... ]

> @@ -2217,6 +2212,115 @@ static bool compute_max_iters(struct bpf_verifier=
_env *env,
>  		return false;
>  	}
> =20
> +	*result =3D backedge_taken_count;
> +	return true;
> +}
> +
> +/*
> + * Loop with post-condition:
> + *
> + *    r0 =3D 0
> + * l: ...                r0 =E2=88=88 [0,1,2] header executed 3 times
> + *    r0 +=3D 1            r0 =E2=88=88 [0,1,2]
> + *    ...                r0 =E2=88=88 [1,2,3]
> + *    if r0 !=3D 3 goto l  r0 =E2=88=88 [1,2,3] backedge taken 2 times
> + *    ...                r0 =E2=88=88 [3]
> + *
> + * SCEV at header: r0 =3D k
> + * SCEV at latch:  r0 =3D 1 + k
> + *
> + * Loop with pre-condition:
> + *
> + *    r0 =3D 0
> + * l: ...                r0 =E2=88=88 [0,1,2,3] header executed 4 times
> + *    if r0 =3D=3D 3 goto e  r0 =E2=88=88 [0,1,2,3] backedge taken 3 tim=
es
> + *    r0 +=3D 1            r0 =E2=88=88 [0,1,2]
> + *    ...                r0 =E2=88=88 [1,2,3]
> + *    goto l             r0 =E2=88=88 [1,2,3]
> + * e: ...                r0 =E2=88=88 [3]
> + *
> + * SCEV at header: r0 =3D k
> + * SCEV at latch:  r0 =3D k
> + */
> +static bool compute_max_iters(struct bpf_verifier_env *env,
> +			      struct bpf_func_state *st,
> +			      struct linear_latch *latch,
> +			      struct bpf_loop_iters *iters)
> +{
> +	struct bpf_insn_aux_data *aux =3D env->insn_aux_data;
> +	struct bpf_loop *loop =3D aux[bpf_loop_at_index(env, latch->insn_idx)].=
loop;
> +	struct scev *scev =3D env->scev;
> +	struct scev_value initial_val, step_val, bound_val;
> +	u64 step, bound, initial, total_change, backedge_taken_count;
> +	u8 op =3D latch->op;
> +
> +	if (!eval_expr(env, scev, st, latch->base_expr, &initial_val) ||
> +	    !eval_expr(env, scev, st, latch->step_expr, &step_val) ||
> +	    !eval_expr(env, scev, st, latch->bound_expr, &bound_val))
> +		return false;
> +
> +	if (step_val.ptr_reg >=3D 0) {
> +		if (env->log.level & BPF_LOG_LEVEL2) {
> +			bpf_log(&env->log, "scev: latch step is a pointer ");
> +			log_scev_value(env, st, &step_val);
> +			bpf_log(&env->log, "\n");
> +		}
> +		return false;
> +	}
> +	if (!scev_value_compatible(env, st, &initial_val, &bound_val))
> +		return false;
> +
> +	initial =3D initial_val.value;
> +	step =3D step_val.value;
> +	bound =3D bound_val.value;
> +
> +	/*
> +	 * The code below only handles mixed 64-bit/32-bit comparisons/recurren=
ces
> +	 * when initial bounds and step fit in 32-bit domain.
> +	 */
> +	if (latch->zext32 || latch->jmp32) {

[Severity: Critical]
Should compute_max_iters() reject pointer operands (initial_val.ptr_reg >=
=3D 0
or bound_val.ptr_reg >=3D 0) when latch->zext32 or latch->jmp32 is true?

When eval_expr() evaluates a constant-offset pointer register, it sets
result->value to reg->var_off.value (the offset relative to the runtime base
address) and result->ptr_reg >=3D 0. If two registers r1 and r2 point to the
same memory object (for example, PTR_TO_PACKET, PTR_TO_MAP_VALUE, or
PTR_TO_STACK with r1 =3D base + 0 and r2 =3D base + 9), scev_value_compatib=
le()
succeeds.

While comparing relative offsets works for 64-bit jumps and 64-bit pointer
arithmetic because valid kernel objects do not cross 64-bit address space
boundaries, a BPF_JMP32 latch (such as "if w1 < w2 goto l" with "r1 +=3D 2")
compares the low 32 bits of the runtime kernel addresses: (u32)(base + offs=
et)
or (s32)(base + offset).

Because (u32)base is unknown at verification time and can sit near U32_MAX =
or
S32_MAX, (u32)(base + initial + k * step) and (u32)(base + bound) can wrap
around U32_MAX -> 0 or S32_MAX -> S32_MIN at runtime even when the relative
offsets initial, bound, and total_change are small (e.g. if (u32)base =3D=3D
0xfffffff6, then w2 =3D=3D 0xffffffff and w1 wraps around U32_MAX on even v=
alues
without terminating). Can this cause compute_max_iters() to compute an
unsound max_header_count and widen pointer or scalar induction variables to
incorrect bounds?

> +		/*
> +		 * With the above constraint doing `l: w0 +=3D 1; if r0 s< 256 goto l;`
> +		 *                is equivalent to `l: w0 +=3D 1; if r0 < 256 goto l;`
> +		 */
> +		if (latch->jmp32 && is_signed_op(op)) {
> +			initial =3D (s64)(s32)(u32)initial;
> +			bound   =3D (s64)(s32)(u32)bound;
> +			step    =3D (s64)(s32)(u32)step;
> +		} else {
> +			initial =3D (u32)initial;
> +			bound   =3D (u32)bound;
> +			step    =3D (s64)(s32)(u32)step;
> +		}
> +	}

[ ... ]

> @@ -2542,8 +2699,7 @@ int bpf_compute_loop_iters(struct bpf_verifier_env =
*env, struct bpf_verifier_sta
>  		r_scev =3D header_env->reg2scev[r];
>  		reg =3D scev_reg_for_linear(cur_func, r);
>  		/* If SCEV for r is (linear <reg> <slope>) */
> -		if (is_simple_linear(scev, r_scev, &base_reg, &slope_imm) &&
> -		    reg && is_widenable_reg_type(reg)) {
> +		if (reg && is_simple_linear(scev, r_scev, &coefs) && is_widenable_reg_=
type(reg)) {

[Severity: Critical]
Can allowing coefs.zext32 on non-scalar registers corrupt pointer and scalar
bounds during widening and clamping?

In bpf_compute_loop_iters(), is_widenable_reg_type(reg) accepts pointer typ=
es
such as PTR_TO_MAP_VALUE, PTR_TO_STACK, and PTR_TO_PACKET alongside
SCALAR_VALUE, even when is_simple_linear() sets coefs.zext32 =3D true (for
example, when a loop body executes "w7 +=3D 8" on a register r7 holding a
pointer at loop entry).

This leads to two issues:

1. At loop entry, bpf_widen_scev_regs() calls linear_bounds() with
coefs.zext32 =3D true on the pointer's relative offset while keeping reg->t=
ype
as a pointer. For negative pointer offsets such as fp-64, cnum64_zext32()
zero-extends the 32-bit offset to 0xffffffc0.. and unions it into reg->r64 =
on
a PTR_TO_STACK register. For PTR_TO_MAP_VALUE at offset 0 (with 4 header
visits and step 8), bpf_widen_scev_regs() widens r7 at the header to
PTR_TO_MAP_VALUE with offset [0, 24].

2. When do_check() verifies "w7 +=3D 8" in the loop body with
env->allow_ptr_leaks enabled, adjust_ptr_min_max_vals() rejects 32-bit
pointer arithmetic via mark_reg_unknown() and scalar32_min_max_add(), turni=
ng
r7 in cur_func_state into an unknown SCALAR_VALUE holding the low 32 bits of
the runtime kernel pointer plus 8. When execution reaches the loop header
along the backedge, bpf_clamp_scev_regs() computes linear_bounds() from
entry_reg (which is still PTR_TO_MAP_VALUE with offset 0, yielding bounds
[0, 24]) and intersects those pointer-offset bounds directly into reg (which
is now SCALAR_VALUE) without checking that entry_reg and reg are scalars or
have matching types. The verifier then treats scalar r7 as bounded to [0, 2=
4]
while at runtime it holds (u32)map_value_kaddr + 8.

Should zext32 linear SCEVs be restricted to reg->type =3D=3D SCALAR_VALUE (=
and
should bpf_clamp_scev_regs() verify that entry_reg and reg have compatible
types)?

>  			/* Spills at varying offsets lose precision */
>  			if (test_bit(r, loop->store_base_regs)) {
>  				spill_base =3D true;

[ ... ]

> @@ -2737,9 +2891,10 @@ int bpf_clamp_scev_regs(struct bpf_verifier_env *e=
nv, struct bpf_func_state *cur
>  		    is_unbound_scev_reg(env, entry_st, r))
>  			continue;
> =20
> -		linear_bounds(entry_reg, max_header_count, slope_imm, &bounds);
> -		bounds.range =3D cnum64_intersect(reg->r64, bounds.range);
> -		if (cnum64_is_empty(bounds.range)) {
> +		linear_bounds(entry_reg, max_header_count, &coefs, &bounds);
> +		bounds.r64 =3D cnum64_intersect(reg->r64, bounds.r64);
> +		bounds.r32 =3D cnum32_intersect(reg->r32, bounds.r32);
> +		if (cnum64_is_empty(bounds.r64)) {
>  			verifier_bug(env, "scev clamp produced empty range for r%d", r);
>  			return -EFAULT;
>  		}

[Severity: Medium]
Can bpf_clamp_scev_regs() pass an empty bounds.r32 to bpf_set_reg_range() a=
nd
trigger a register invariants violation in reg_bounds_sanity_check()?

In linear_bounds(), when coefs->zext32 is true and the 32-bit range wraps
around 0 and U32_MAX (e.g. w1 =3D 0 at entry, step =3D -1, two header visit=
s),
bounds.r64 becomes [0, U32_MAX] while bounds.r32 is [-1, 0] (similarly, if
entry_reg has non-zero upper 32 bits, bounds.r64 is wider than bounds.r32).

If an in-loop branch refines reg on the backedge to a 32-bit value outside
bounds.r32 (for example, w1 =3D=3D -2, so reg->r64 is [0xfffffffe, 0xffffff=
fe]
and reg->r32 is [-2, -2]), intersecting reg->r64 with [0, U32_MAX] produces=
 a
non-empty bounds.r64, whereas intersecting reg->r32 with [-1, 0] produces
CNUM32_EMPTY. (A similar situation can occur when !coefs->zext32 leaves
bounds.r32 as CNUM32_UNBOUNDED, and deduce_bounds_32_from_64() inside
reg_bounds_sync() intersects reg->r32 with the 32-bit projection of
bounds.r64.)

Because bpf_clamp_scev_regs() only checks cnum64_is_empty(bounds.r64), it
proceeds to bpf_set_reg_range(), where reg_bounds_sanity_check() flags
cnum32_is_empty(reg->r32) as a range bounds violation. Should
bpf_clamp_scev_regs() also check cnum32_is_empty(bounds.r32)?

> @@ -2747,13 +2902,12 @@ int bpf_clamp_scev_regs(struct bpf_verifier_env *=
env, struct bpf_func_state *cur
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
>  		scratch_widened_reg_id(env, reg);
> -		err =3D bpf_set_reg_range(env, reg, bounds.range, bounds.base, bounds.=
step);
> +		err =3D bpf_set_reg_range(env, reg, bounds.r64, bounds.r32,
> +					bounds.base, bounds.step);
>  		if (err)
>  			return err;
>  		mark_scev_reg_scratched(env, r);

[ ... ]

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index d138688468236..ea26da040ff96 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -17587,10 +17587,10 @@ bool bpf_same_memory_origin(const struct bpf_re=
g_state *reg_a,
>  }
> =20
>  int bpf_set_reg_range(struct bpf_verifier_env *env, struct bpf_reg_state=
 *reg,
> -		      struct cnum64 range, u16 base, u16 step)
> +		      struct cnum64 r64, struct cnum32 r32, u16 base, u16 step)
>  {
> -	reg->r64 =3D range;
> -	reg->r32 =3D CNUM32_UNBOUNDED;
> +	reg->r64 =3D r64;
> +	reg->r32 =3D r32;
>  	reg->step =3D step;
>  	reg->base =3D base;
>  	reg->var_off =3D tnum_unknown;

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261020-scev-32bit=
-v1-0-838f34f9f0cd@gmail.com?part=3D1
