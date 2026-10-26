Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792986825;
	b=eB1owlsJz6VY2mCOJS4jsNmVkTtRZqrb3jz7PkGAi0CFWZkSXlXIjGjQi56M40WotOY2
	 243gL1C7JoCyiDo9fZrBXYrq4zNg9fodDiPMAV5LJW8gsPfdCqm3b7IzIPqfaXoRidQhJ
	 SN5Z4TFYbGvpj86Vn9BO49U+bkCkCt4pRJ+nJVjk+Q2Qw8i8WnelC0XemLgQL928Bz00L
	 yPidkyk6eYQIa+H7O7D3/hLh9+11haj2nw50+tfOgr/Ua3OI3t6xv9l3kkKhhzKGpxlqN
	 nN7KbuPqbXlqoMcHm1JIfHG+i321t2msTVBC4ZIDmZ7rI+NfYne1Kz0dkGpj409rFsA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792986825;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=iPYHmhpQSlBqIucIpWbnCrZERmr96M+bAvmbUVpt+3w=;
	b=KX5roZ1AP52ksIg66MwsqetdXzWl308/5Gmj2Hgxok/DVndUShVGVnATMAMnCTDueP35
	 XzBpURevogpjdU1fsWYwQFOyjGlJYLXk1YECeAogCmOZMG5d0TP+xKSrjVip/cn+dky1m
	 uwqMzrgQ8g4P0Rw3JtNfJ/l4WFtq877QvZn7b8Y7dEVyena6FAO5QPekuylVRIHoXAPQI
	 W1rhqEAzfRsgJJNhCm6ILsM8/SmDtSRlF1pZb4i6SK1n0hDxDb1PE4Xty7CSx47jPAf2w
	 vPdWBRODvT21rPoXcHjT9v4zCHSdvtcuvTDf1Q5HukJdI35vjutZ4wRWtRMQPC+ZNPg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KKnFyvAY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEE9E606A31D
	for <bpf@vger.kernel.org>; Mon, 26 Oct 2026 03:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KKnFyvAY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63D011F01825;
	Mon, 26 Oct 2026 03:53:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792986824;
	bh=iPYHmhpQSlBqIucIpWbnCrZERmr96M+bAvmbUVpt+3w=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=KKnFyvAYUka+Ndg9IpL6+R/DntuDIQjpeJTNZNeiZ20FYYkuhPBYgo/xAMTVzoDJd
	 4+WNPm25kpDDLIzXBPOqyBB5HZicY+D9Gwk4LNcMMsGpSdtC3bfEVPNWRs4WnSCw1N
	 5OmGndQBcrGmuT62iCBk7nM0LrQ52EpqwQqczfPA0GcIjqVrB9aNvI/CFhjiYfn8sY
	 uJ2riWB7qHkVorCz4UsG/+zdRNXJODv//zUqcysrKDkZmTaTVhf3uXk1mv+oG3LRZA
	 8yQAw72PNEBd8Yi5fFf3aM94p/nxEyhzcURyZBGsU27jANFDnk6rgGhEnqrihja/5U
	 Y2r/Jdsv+Z3lQ==
Content-Type: multipart/mixed; boundary="===============4534030329879841392=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <4597bc817393b620e801dcb1bdae2158c273582d2f44b7050dfebd3a23eb3358@mail.kernel.org>
In-Reply-To: <20261026025943.404450-49-alexei.starovoitov@gmail.com>
References: <20261026025943.404450-49-alexei.starovoitov@gmail.com>
Subject: Re: [PATCH bpf 48/81] bpf: Describe loops that scalar evolution cannot count exactly
From: bot+bpf-ci@kernel.org
To: alexei.starovoitov@gmail.com,bpf@vger.kernel.org
Cc: daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Mon, 26 Oct 2026 03:53:44 +0000 (UTC)

--===============4534030329879841392==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Describe loops that scalar evolution cannot count exactly

TL;DR:
- Pointer compares in scev may undercount iterations, so the verifier could
  accept an out-of-bounds map access
- Forgetting "fresh" registers may reject previously loading programs or leave
  uninitialized/pointer values at the loop head
- Stray leftover comment (nit)

> diff --git a/kernel/bpf/scev.c b/kernel/bpf/scev.c
> index 46ccce4ab130..853aac03d519 100644
> --- a/kernel/bpf/scev.c
> +++ b/kernel/bpf/scev.c

[ ... ]

> @@ -2244,6 +2309,234 @@ static bool compute_backedge_taken_count(u8 op, u64 initial, u64 step, u64 bound

[ ... ]

> +	bias = sign ? 1ULL << 63 : 0;
> +	d->bmin = (sign ? (u64)bound->smin : bound->umin) ^ bias;
> +	d->bmax = (sign ? (u64)bound->smax : bound->umax) ^ bias;
> +	if (latch->zext32) {
> +		/* zero extended, so it is not negative */
> +		d->imin = initial->u32_min ^ bias;
> +		d->imax = initial->u32_max ^ bias;
> +		d->lo = bias;
> +		d->hi = bias + U32_MAX;
> +		return;
> +	}
> +	d->imin = (sign ? (u64)initial->smin : initial->umin) ^ bias;
> +	d->imax = (sign ? (u64)initial->smax : initial->umax) ^ bias;
> +	d->lo = 0;
> +	d->hi = U64_MAX;
> +}

Can this undercount the iterations when the latch compares two pointers of
the same origin with an unsigned op?

For a pointer, eval_expr() fills scev_value from reg_umin()/reg_umax() of
r64, which holds the offset of the pointer.  With sign == false,
latch_domain() orders the first value and the bound by those u64 offsets.
At run time the jump compares addresses, and for two pointers into the same
object address order is the signed order of the offsets.  The two orders
differ whenever a range holds both a negative and a non-negative offset.
cnum64_umin()/cnum64_umax() then return [0, U64_MAX], so d->imin = 0 or
d->bmax = U64_MAX is taken as the furthest value, when in address order the
real extreme is the negative offset or offset 0.

The old code could not get here.  eval_expr() required tnum_is_const(), and
with constants a disagreement in order either fails 'initial >= bound' or
gives a count of about 2^64, which the U32_MAX check rejects.  The new range
path is the first place where a straddling range reaches the count.

Example (privileged, so env->allow_uninit_stack is set):

  r6 &= 63            // r6 in [0, 63]
  r7 = r10
  r7 -= r6            // PTR_TO_STACK, off in [-63, 0]
  r9 = 0
loop:
  ... body uses r9 as an index ...
  r7 += 1
  r9 += 1
  if r7 <= r10 goto loop   // BPF_JLE, BPF_X, both PTR_TO_STACK

base_expr is (+ r7 1).  Its offsets [-62, 1] straddle 0, so
scev_value_add() gives umin = 0, umax = U64_MAX.  The bound r10 has offset
0, and scev_value_compatible() accepts it (same frameno).  konst is false,
so compute_backedge_taken_max() runs.  In the BPF_JLE case d.imin = 0 <=
d.bmax = 0, so cnt = div64_u64(0 - 0, 1) + 1 = 1, and the wrap check passes.
compute_max_iters() then sets max_header_count = 2.

At run time, with r6 = 63 so that r7 starts at fp-63, the latch lets
fp-62 .. fp+0 through: 63 backedges and 64 trips through the header.
bpf_widen_scev_regs() gives r9 the range [0, 1] (linear_bounds() with
max_header_count 2).  When the body comes back to the head with r9 in
[1, 2], bpf_clamp_scev_regs() narrows it to [1, 1], and the state is pruned
against the head.  The body is only verified for r9 <= 1, while r9 really
reaches 63.  An access like *(u8 *)(map_value + r9) on a 2-byte value passes
the verifier and writes out of bounds at run time.

The same thing happens with a straddling bound and BPF_JLT, step 1 (bmax =
U64_MAX stands for offset -1, while offset 0 is the real largest bound), and
with a straddling first value in the BPF_JGT/BPF_JGE down case.  BPF_JNE is
not affected: its unsigned attempt either fails or yields a count of about
2^64, which is rejected, and its signed retry orders pointers correctly.

The only pointer check in compute_backedge_taken_max() is:

	/* halves of pointers are not compared */
	if (initial->ptr_reg >= 0 && (latch->jmp32 || latch->zext32))
		return false;

For full-width unsigned compares the pointer case falls through to the u64
domain.  Should pointer operands use the signed view of the offsets whatever
the op, or be rejected when umin/umax and smin/smax disagree?

Nothing in af2fd429b9f6..51224d16c11b changes compute_backedge_taken_max()
or latch_domain().  At the end of the series bpf_flow_loop_enter() still
widens and clamps from this count, and in the 'counted' walk it also drops
trips beyond max_header_count ('there is no such iteration at run time').

[ ... ]

> @@ -2595,6 +2923,71 @@ static int mark_expr_precise(struct bpf_verifier_env *env, struct bpf_func_state
> +/*
> + * Nothing that @id is computed from is what a register had at the head of the loop, and
> + * some of it is not known: it's made anew in every iteration.
> + */
> +static bool expr_is_fresh(struct bpf_verifier_env *env, u32 id)
> +{
> +	struct scev *scev = env->scev;
> +	bool opaque = false;
> +	u32 order, regno;
> +
> +	scev->stack_sz = 0;
> +	expr_stack_push(scev, id);
> +	while (expr_next(scev, &id, &order)) {
> +		if (order & DEPTH_LIMIT)
> +			return false;
> +		if (!(order & PRE))
> +			continue;
> +		if (is_reg(scev, id, &regno) || is_op(scev, id, UNKNOWN))
> +			return false;
> +		if (is_opaque(scev, id))
> +			opaque = true;
> +	}
> +	return opaque;
> +}

Is it right to treat any expression built only from opaque leaves as fresh
here?  The comment in bpf_compute_loop_iters() justifies it with:

  What is loaded from memory or returned by a call in every iteration is
  as little known when iterations are looked at one by one.

The code does not seem to support that.  OPAQUE_EXPR_ID is produced by
maybe_load_fp() for every load whose base is not r10, whatever its size
('else id = OPAQUE_EXPR_ID;').  It is also produced for BPF_LD_IMM64 of a
map, map value, BTF id or function, and for atomic fetch results.  The
verifier knows more about many of these values:

  - check_mem_access() runs coerce_reg_to_size() on a u8/u16/u32 load,
    which gives [0,255], [0,65535] or [0,U32_MAX]
  - a ctx load can give a pointer type
  - a load through a non-r10 pointer to the stack gives the exact spilled
    value

Before this patch such a register reached 'cant_widen: ... return 0', and
the loop was unrolled with the exact value in each iteration.  Now
expr_is_fresh() returns true, bpf_compute_loop_iters() returns 1, and
bpf_widen_scev_regs() replaces the register with a fully unknown 64-bit
scalar.

For example:

  r7 = <non-NULL map value, value_size 256>
  r6 = 0
  r8 = 0
l0:
  r1 = r7
  r1 += r6
  r0 = *(u8 *)(r1 + 0)
  r6 = *(u8 *)(r7 + 0)
  r8 += 1
  if r8 < 10 goto l0

At the head, r6 has scev (any r6 OPAQUE).  That is not widenable, and
expr_loses_bits_only() is false, so r6 goes to forget_regs.
expr_is_fresh() returns true for the opaque leaf, so the function returns 1
and r6 becomes an unknown scalar.  The map access with r6 as an unbounded
offset is then rejected, although the same program loaded before this patch
(r6 is in [0,255] in every iteration).

The comment is also wrong about calls: forget_call_regs() sets r0-r5 to
UNKNOWN_EXPR_ID, and expr_is_fresh() returns false for UNKNOWN, so a value
returned by a helper makes the loop walk instead of being forgotten.

The same logic is still in place at the end of the series (51224d16c11b):
bpf_flow_loop_enter() in 0535bc235aed still widens directly on err == 1, and
expr_is_fresh()/maybe_load_fp() are unchanged.

Could the opaque leaves carry their load width (for example zext8/16/32 of
an opaque leaf), or could a register be treated as fresh only when what the
verifier knows at the entry is no better than an unknown scalar of the same
width?

[ ... ]

> @@ -2759,7 +3182,17 @@ int bpf_compute_loop_iters(struct bpf_verifier_env *env, struct bpf_verifier_sta
>  				bpf_log(log, ", requires exact stack-offset tracking");
>  			bpf_log(log, "\n");
>  		}
> -		return 0;
> +		/* the count stands, it is this one that is not known in the loop */
> +		if (spill_base)
> +			iters->spill_base = true;
> +		else
> +			__set_bit(r, iters->forget_regs);
> +		/*
> +		 * What is loaded from memory or returned by a call in every iteration is
> +		 * as little known when iterations are looked at one by one.
> +		 */
> +		if (spill_base || !expr_is_fresh(env, header_env->reg2expr[r]))
> +			walk = true;
>  	}

Can this make programs that loaded before this patch fail to load?  A live
register that is reloaded on every iteration now ends up less precise at the
head than it was in any iteration, while the loop is still counted and
widened.

Before the patch, a live register with no summary went to cant_widen and the
function returned 0, so the verifier walked the loop.  Now, when
header_env->reg2expr[r] is fresh, walk stays false.  The function returns 1,
and bpf_widen_scev_regs() calls scev_forget_reg() on the register:

    if (r < MAX_BPF_REG) {
        if (func->regs[r].type == SCALAR_VALUE) {
            bpf_mark_reg_unknown_imprecise(&func->regs[r]);
            ...
        } else if (func->regs[r].type == PTR_TO_ARENA) {
            ...
        }
        return;
    }

An expression is fresh when it contains an opaque leaf and no register, and
maybe_load_fp() gives OPAQUE_EXPR_ID to every load that is not a spill fill,
whatever its size.  That causes two problems.

1) The entry value is uninitialized or a pointer.  scev_forget_reg() leaves
it as it is, so the widened head still holds the entry value, while the
counted IV is already a range that includes the exit value.  A hand-written
example:

    r9 = <non-NULL map value>
    r7 = 0
 1: if r7 >= 10 goto 2f
    r6 = *(u8 *)(r9 + 0)
    r7 += 1
    goto 1b
 2: r0 = r6
    exit

r6 is live at the head because of the exit path, and its expression is
opaque.  The loop is counted (header_count 11), and r7 is widened to [0, 10]
while r6 stays uninitialized.  From the head state the branch r7 >= 10 is
now taken, and 'r0 = r6' fails with R6 !read_ok.  Before the patch the loop
was walked: the exit is reached only with r7 == 10, where r6 is set, and the
program loaded.

A pointer entry value has the same problem.  For example, an entry pointer
that the loop replaces with a scalar is still a pointer on the exit path.

2) The entry value is a scalar.  It becomes a fully unknown 64-bit scalar,
but a narrow load gives a bounded value: coerce_reg_to_size() bounds BPF_B,
BPF_H and BPF_W loads to [0, 255], [0, 65535] and [0, U32_MAX].  Take:

    prev = 0;
    for (i = 0; i < 16; i++) {
        tbl[prev] = 1;
        prev = in[i];
    }

with u8 'in' and a 256-byte map value as 'tbl'.  Walking the loop proved the
access safe.  Now prev is unknown at the head, and 'tbl + prev' fails as an
unbounded memory access.

The new comment claims that a value loaded again in each iteration is 'as
little known when iterations are looked at one by one'.  That is not true
for sized loads, or for an uninitialized or pointer entry value.

The comment also mentions values 'returned by a call', but
forget_call_regs() sets r0-r5 to UNKNOWN_EXPR_ID, and expr_is_fresh()
returns false for UNKNOWN, so a call result always walks the loop and is
never forgotten.

The commit message says such a register becomes an 'unknown scalar' at the
head, which does not match the uninitialized and pointer entry cases either.

In 51224d16c11b, at the end of the series, handle_loop_entry() still calls
bpf_widen_scev_regs() for a return value of 1 with the same forget logic, so
no later commit in the series fixes this.

Could a fresh register be forgotten only when the result covers all
iterations, and the loop be walked otherwise (walk = true)?  Here that would
mean forgetting only when the entry value is a SCALAR_VALUE and the unknown
result does not lose a range that the loads give.

[ ... ]

> @@ -2951,3 +3456,255 @@ int bpf_clamp_scev_regs(struct bpf_verifier_env *env, struct bpf_func_state *cur

[ ... ]

> +/*
> + * The number of iterations of the loop that @st enters is not known. Make @st
> + * stand for all of them as far as there is a summary of what the loop does:
> + * - a variable that a constant is added to can be anything, anything that
> + *   fits in 32 bits if it is computed in 32 bits,
> + * - a variable that is set to one of several values is one of them.
> + * The rest is left as it is: the state that comes back to the loop head tells.
> + * Guessing here would make up values that the program never has.
> + */
> +
> +/*
> + *	do { arr[i] = i; i--; } while (i < 1000);
> + * What register @r may be at the head of the loop: what it is at the entry, or what the
> + * jump that closes the loop lets through. It's a guess. The state that comes back to
> + * the head is compared with it like with any other state.
> + */

Is the first comment block above, the one before latch_range(), meant to
stay?  It is not attached to any function, and it describes
bpf_scev_forget_regs(), which has its own comment further down.

The two comments disagree about counters.  The detached block says:

  a variable that a constant is added to can be anything, anything that
  fits in 32 bits if it is computed in 32 bits

The code does something else for a counter that the closing jump tests:

    if (latch_range(env, loop, st->insn_idx, r, reg, &range)) {
        ...
        err = bpf_set_reg_range(env, reg, range, CNUM32_UNBOUNDED, 0, 1);

That range is the union of the entry range and what the back edge lets
through.  It is not unknown and not [0, U32_MAX].  Only counters that
latch_range() rejects get scev_forget_reg() or [0, U32_MAX].

The comment on bpf_scev_forget_regs() says this correctly ("is what the jump
that closes the loop lets through, see latch_range()"), so the detached
block looks like a leftover of an earlier version.  It is still present at
the end of the series (51224d16c11b).


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/40263142572
--===============4534030329879841392==--
