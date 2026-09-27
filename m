Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 286EF3C3428
	for <bpf@vger.kernel.org>; Sun, 27 Sep 2026 20:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790541788; cv=none; b=dAhcFIAxTm/PIHV9aUdw5PV1SmefrslBI3I/vdFwzccjJbF0K4kkllo1LrKkYgzqWWr4ooAfeZVIMt0A2l6gwvyfs309k5bLMVxJMhaBamvpggxttYGp1okPcpxD23w5zTKLWxKilCV5hlj7Xn2pDQcv9AA+iIkU4lRo0lTnpjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790541788; c=relaxed/simple;
	bh=dFJomRcSkTx8JVhvp3VU89QJYv1JQ8FZTihMB20Uxgs=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=mpzQlE32WqVbxP02SQw2QGtHgkHhfeqRHXdjfQbJY26qLF/S8jI3q7j6BkK5kxTmtFiOq+XzB2sJg3UprpTNMvuf9/O+e5t9xlXKqxyAWBDgFxEIf3bcbrNe6gjQLD2jitZK+htLpY8wCYGzWrnvavMMVMgCVO6Ely2MP+tbKgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PurtW/oI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PurtW/oI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E7B71F000FF;
	Sun, 27 Sep 2026 20:43:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790541786;
	bh=q1Jq7r2N+WzlZvhRpGZg1iLErYV6A5w59yT0m5ddh8c=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=PurtW/oItoiLVIW7KmCE/ozvwF0EU7km3U2neQf/litvTV6YSS3GviCC+1v/nWXrN
	 2s/tunXWBg5NWs66GuoMdrnbxYg5sc+8tsBkKNeyz9RRoh2D736ASvXcQZmwO0K5wm
	 oY9lln2/WHsggvoISGkyqlysThzni5kjmPz8zf3kXvJWB9jSrHQojZ+De1eAhasNoH
	 LiAodZR4y7v6aonhAAH+RrqTaeaWSdyULfs2Mxo/tAED8zA8BOxFHVeOXWIAQm4kcO
	 xISzF9zlQLoSfqjo8L9pJ/Q9BxnGfRWiFbYOXGB9I5mww7mZz58Oc/csgzlaVWODVB
	 4mItk1DE7vYsQ==
Content-Type: multipart/mixed; boundary="===============3543033587667165334=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <04f8760d4e4f7598c5b9b0a00e8c26134014f125877239e08a0bf38ab76748a5@mail.kernel.org>
In-Reply-To: <20260926-scev-minimal-rebase-v1-25-c8e5ab5ba79f@gmail.com>
References: <20260926-scev-minimal-rebase-v1-25-c8e5ab5ba79f@gmail.com>
Subject: Re: [PATCH bpf-next 25/36] bpf: use SCEV to widen bounded loops
From: bot+bpf-ci@kernel.org
To: eddyz87@gmail.com,bpf@vger.kernel.org,ast@kernel.org,andrii@kernel.org
Cc: daniel@iogearbox.net,martin.lau@linux.dev,kernel-team@fb.com,yonghong.song@linux.dev,eddyz87@gmail.com,memxor@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Sun, 27 Sep 2026 20:43:05 +0000 (UTC)

--===============3543033587667165334==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> index 54a971800ea3..c0eea472949d 100644
> --- a/include/linux/bpf_verifier.h
> +++ b/include/linux/bpf_verifier.h
> @@ -328,6 +328,21 @@ struct bpf_retval_range {
>  	bool return_32bit;
>  };
>
> +struct bpf_loop_iters {
> +	u32 min_header_count;   /* min number of times header is executed */
> +	u32 max_header_count;   /* max number of times header is executed */
> +	bool pre_cond;
> +};
> +
> +struct loop_stack_entry {
> +	struct bpf_verifier_state *entry_state;
> +	struct bpf_loop_iters iters;
> +	u32 loop_id:31;
> +	u32 terminates:1;
> +};
> +
> +#define LOOP_STACK_SIZE 16
                               ^^

The fixed-size per-frame loop stack makes loop nesting depth a hard
verifier limit, so programs that were accepted before this commit are now
rejected. handle_loop_entry_exit() is called unconditionally from
do_check() and pushes an entry for every loop header on the path from the
current insn to the root of the loop tree, whether or not SCEV can prove
the loop terminates. loop_stack_push() fails verification with -E2BIG when
that depth exceeds 16:

kernel/bpf/verifier.c:loop_stack_push() {
    for (h = bpf_loop_at_index(env, env->insn_idx); h >= 0; h = aux[h].loop_header, num_missing++) {
        if (cnt && loop_stack[cnt - 1].loop_id == h) break;
        if (num_missing == LOOP_STACK_SIZE) goto e2big;
        ...
    }
    for (; num_missing; num_missing--, cnt++) {
        if (cnt == LOOP_STACK_SIZE) goto e2big;
        ...
    e2big:
        verbose(env, "Too many nested loops (%d/%d) at %d\n", cnt, num_missing, env->insn_idx);
        return -E2BIG;
}

The loop hierarchy has no nesting-depth limit of its own, and irreducible
or over-approximated CFGs (eg gotox jump tables where every block may jump
to every later block) produce very deep static nests even when the program
terminates trivially at run time.

This is visible in tools/testing/selftests/bpf/progs/verifier_gotox.c:
gotox_edges_at_limit flips from __success __retval(0) to __failure
__msg("Too many nested loops"), with the comment "the CFG is a nest of
~1000 irreducible loops, deeper than the verifier's loop stack; the
program is rejected." Deeply nested bpf_for()/can_loop loops (more than
16 levels in one subprogram) are rejected the same way.

The commit message ("use SCEV to widen bounded loops") does not mention
that loop nesting deeper than 16 is now a rejection condition, and nothing
later in the series changes this.

Since widening is an optimisation, could the logic stop tracking loops
beyond the limit and treat them as non-widenable (the pre-patch behaviour)
instead of failing the load?

[ ... ]

> diff --git a/kernel/bpf/scev.c b/kernel/bpf/scev.c
> index 396b0c776dfa..205bf8684c3d 100644
> --- a/kernel/bpf/scev.c
> +++ b/kernel/bpf/scev.c

[ ... ]

> +static bool eval_expr(struct bpf_verifier_env *env, struct scev *scev, struct bpf_func_state *st, u32 id, u64 *result)
> +{
> +	struct bpf_reg_state *reg;
> +	u32 regno;
> +	s64 imm;
> +
> +	if (is_reg(scev, id, &regno)) {
> +		reg = scev_regno_to_reg(env, st, regno);
> +		if (reg->type == NOT_INIT)
> +			return false;
> +		if (tnum_is_const(reg->var_off)) {
> +			*result = reg->var_off.value;
                             ^^^^^^^^^^^^^^^^^^^^
> +			return true;
> +		}
> +	} else if (is_imm(scev, id, &imm)) {
> +		*result = imm;
> +		return true;
> +	}
> +	return false;
> +}

eval_expr() returns reg->var_off.value for any initialized register type.
For pointer types (this tree folds the fixed offset into var_off), that is
the offset from the pointed-to object, not the runtime value the latch
compares.

When allow_ptr_leaks permits comparing a pointer against a scalar (or
against a pointer with a different base), the iteration count is computed
from offsets while the runtime comparison uses absolute addresses, so the
result has no relation to the real trip count.

Pointer types such as PTR_TO_STACK and PTR_TO_MAP_VALUE are accepted by
is_widenable_reg_type(), so this count can feed widening and clamping.

Should eval_expr() require SCALAR_VALUE for the latch register, bound and
initial values, or require both sides of the comparison to be the same
pointer base?

[ ... ]

> +static bool compute_max_iters(struct bpf_verifier_env *env,
> +			      struct bpf_func_state *st,
> +			      struct linear_latch *latch,
> +			      struct bpf_loop_iters *iters)
> +{
> +	u64 base, step, diff, bound, initial, max_iters;
> +	struct bpf_insn_aux_data *aux = env->insn_aux_data;
> +	struct bpf_loop *loop = aux[bpf_loop_at_index(env, latch->insn_idx)].loop;
> +	struct scev *scev = env->scev;
> +	u8 op = latch->op;
> +
> +	if (!eval_expr(env, scev, st, latch->base_expr, &base) ||
> +	    !eval_expr(env, scev, st, latch->step_expr, &step) ||
> +	    !eval_expr(env, scev, st, latch->bound_expr, &bound) ||
> +	    !eval_expr(env, scev, st, latch->reg_expr, &initial))
> +		return false;
> +
> +	if (step == 0)
> +		return false;
> +	if ((s64)step == S64_MIN)
> +		return false;
> +	if ((s64)step < 0) {
> +		/* Multiply both sides of the equation by -1, e.g. -2*i > -3 becomes 2*i < 3 */
> +		op = bpf_flip_opcode(op);
> +		step = -step;
> +		swap(bound, initial);
> +	}
> +	diff = bound - initial;
> +	if (diff / step == U64_MAX)
> +		return false;
> +	switch (op) {
> +	case BPF_JLT:
> +		max_iters = (u64)initial >= (u64)bound ? 0 : div_round_up(diff, step);
> +		break;
> +	case BPF_JLE:
> +		max_iters = (u64)initial >  (u64)bound ? 0 : diff / step + 1;
> +		break;
> +	case BPF_JSLT:
> +		max_iters = (s64)initial >= (s64)bound ? 0 : div_round_up(diff, step);
> +		break;
> +	case BPF_JSLE:
> +		max_iters = (s64)initial >  (s64)bound ? 0 : diff / step + 1;
> +		break;
> +	case BPF_JNE:
> +		max_iters = diff % step ? U32_MAX : div_round_up(diff, step);
> +		break;
> +	default:
> +		return false;
> +	}
> +
> +	if (max_iters > U32_MAX)
> +		return false;
> +
> +	/*
> +	 * The latch is a conditional jump with one jump target exiting the loop.
> +	 * Linear latch is matched only if the loop has a single backedge.
> +	 * The loop still, however can have multiple exits.
> +	 * In such case, conservatively assume that non-latch exit can happen
> +	 * at any iteration, thus setting minimal number of iterations as 0.
> +	 */
> +	iters->max_header_count = max_iters + (base == 0 ? 1 : 0);
                                   ^^^^^^^^^   ^^^^^^^^^^^^^^^^^^^^
> +	iters->min_header_count = loop->exits_cnt == 1 ? iters->max_header_count : 0;
> +	iters->pre_cond = base == 0;
                           ^^^^^^^^^^^^
> +	return true;
> +}

compute_max_iters() evaluates latch->base_expr but only uses it in a
"base == 0" test. The latch condition is "initial + base + k*step <op>
bound" (see the struct linear_latch comment), but max_iters is derived
from "bound - initial" alone.

The result is right only when base is 0 (pre-condition) or exactly equal
to step (the usual post-increment). match_linear_latch() also accepts any
"(linear (+ reg imm) step)" latch, eg when the compared register is a copy
of the induction variable plus a constant taken before the increment.

For a positive step, whenever base is below step and non-zero (a negative
constant, or 0 < base < step), the real number of header executions is
1 + ceil((bound - initial - base) / step), which is larger than the value
computed here.

For JNE, a base that is not a multiple of step can mean the equality is
never reached even though diff % step == 0.

Because bpf_widen_scev_regs() and bpf_clamp_scev_regs() treat
max_header_count as an upper bound, under-counting lets clamping throw
away induction-variable values the loop really reaches.

Should the arithmetic use (bound - (initial + base)) and add 1 for the
header entry, or should match_linear_latch() reject latches where base is
not 0 or step?

[ ... ]

> +/*
> + * Compute the range an induction variable in `reg` spans over the loop.
> + * Returns false if the computation overflows s64.
> + */
> +static bool linear_bounds(struct bpf_reg_state *reg, struct bpf_loop_iters *iters, s64 slope,
> +			  struct bounds *out)
> +{
> +	s64 slope_abs = slope < 0 ? -slope : slope;
> +	s64 min_val = reg_smin(reg);
> +	s64 max_val = reg_smax(reg);
> +	s64 total_change;
> +	u16 step;
> +
> +	if (check_mul_overflow(slope, (s64)iters->max_header_count - 1, &total_change))
> +		return false;
> +	if (slope > 0) {
> +		if (check_add_overflow(max_val, total_change, &max_val))
> +			return false;
> +	} else {
> +		if (check_add_overflow(min_val, total_change, &min_val))
> +			return false;
> +	}
> +	/*
> +	 * If the entry value is a single point the value set is 'v + slope * k',
> +	 * so the step is |slope|. Otherwise, only the power-of-two alignment
> +	 * shared by the entry value and the slope.
> +	 */
> +	if (cnum64_is_const(reg->r64))
> +		step = slope_abs;
> +	else
> +		step = 1u << min_t(u32, tnum_alignment(reg->var_off), __ffs(slope_abs));
> +	out->range = cnum64_from_srange(min_val, max_val);
> +	out->step = step;
> +	return true;
> +}

When the entry value is not a constant, linear_bounds() picks
step = 2^min(tnum_alignment(var_off), ctz(slope)). All real values are
then 0 mod step, because every tnum member and the slope are multiples of
2^k. But linear_bounds() returns only a range and a step, not a base.

bpf_widen_scev_regs() and bpf_clamp_scev_regs() pass that range and step
to bpf_set_reg_range(), which does:

    reg->base = imod(cnum64_smin(range), step);
    reg->var_off = tnum_unknown;
    reg_bounds_sync(reg);

The base therefore comes from smin of the range, not from the tnum
lattice. smin is not always a tnum member: __update_reg64_bounds() only
intersects r64 with the tnum's min/max and does not round umin up to the
next member. After a range refinement, smin can be off the lattice,
bpf_set_reg_range() records the wrong congruence class, and
cnum64_intersect_linear() in deduce_bounds_64_from_step() then shrinks the
range to that wrong class.

Example:

    r1 = map_lookup_elem(map with value_size 18); if r1 == 0 goto out
    r7 = *(u64 *)(r1 + 0)
    r7 &= 0xc           // var_off (0; 0xc), step reset to 1, r64 [0,12]
    if r7 < 1 goto out  // r64 [1,12]; real values {4,8,12}
    r6 = 0
  H:
    r2 = r1
    r2 += r7
    r0 = *(u8 *)(r2 + 0)
    r7 += 4
    r6 += 1
    if r6 < 3 goto H

At the header:

- max_header_count is 3.
- linear_bounds() returns range [1, 1 + 4*2] = [1, 20] with step
  1 << min(2, 2) = 4.
- bpf_set_reg_range() sets base = imod(1, 4) = 1. cnum64_intersect_linear()
  then narrows r7 to {1,5,9,13,17}, so umax is 17.

At runtime r7 at H is in {4,...,20}, which is 0 mod 4. That set is
disjoint from the verifier's set, and the real maximum 20 is above the
believed maximum 17.

The body's map access passes check_map_access() because 17 + 1 <= 18, but
at runtime it reads offset 20 of an 18-byte value: an out-of-bounds map
value access.

On the backedge, bpf_clamp_scev_regs() does the same. [5,21] intersected
with [1,20] is [5,20]. With base imod(5,4) = 1 this becomes [5,17], which
is within W, so the state is pruned and the error is never found.

The slope < 0 case has the same problem, since
min_val = reg_smin + slope*(n-1) is used as the base source.

Should the widened register base come from linear_bounds() and be passed
to bpf_set_reg_range()? For example, 0 in the tnum-alignment case, or
smin(entry) mod |slope| in the constant case. Alternatively, round min/max
onto the 0 mod step lattice before building the range. Later commits in
the series do not change this logic.

[ ... ]

> +int bpf_compute_loop_iters(struct bpf_verifier_env *env, struct bpf_verifier_state *st,
> +			   struct bpf_loop_iters *iters)
> +{
> +	struct bpf_func_state *cur_func = st->frame[st->curframe];
> +	struct bpf_insn_aux_data *aux = env->insn_aux_data;
> +	struct bpf_verifier_log *log = &env->log;
> +	struct scev *scev = env->scev;
> +	struct env *header_env;
> +	struct linear_latch latch;
> +	struct bpf_loop *loop;
> +	struct bounds bounds;
> +	int insn_idx = st->insn_idx;
> +	int linear_latch;
> +	u32 r, base_reg;
> +	int latch_idx;
> +	s64 slope_imm;
> +	int err;

[ ... ]

> +	header_env = find_header_env(scev, insn_idx);
> +	for (r = 0; r < REGS_NUM; r++) {
> +		struct bpf_reg_state *reg;
> +		u32 ra, r_scev, r_expr;
> +
> +		if (!scev_reg_alive(env, st, r))
> +			continue;
> +
> +		r_scev = header_env->reg2scev[r];
> +		reg = scev_regno_to_reg(env, cur_func, r);
> +		/* If SCEV for r is (linear <reg> <slope>) */
> +		if (is_simple_linear(scev, r_scev, &base_reg, &slope_imm) &&
> +		    is_widenable_reg_type(reg)) {
                     ^^^^^^^^^^^^^^^^^^^^^
> +			/* Can't widen if the iteration range overflows */
> +			if (base_reg == r &&
> +			    !linear_bounds(reg, iters, slope_imm, &bounds))
> +				goto cant_widen;
> +			continue;
> +		}

is_widenable_reg_type() switches on base_type(reg->type), so
PTR_MAYBE_NULL variants are accepted, for example
PTR_TO_MAP_VALUE | PTR_MAYBE_NULL straight from bpf_map_lookup_elem().

The SCEV expressions are computed from the instructions alone, without
type information. So a maybe-null pointer that is null-checked and then
advanced inside the loop gets a (linear r 8) SCEV:

    r1 = map_lookup_elem(...)   // PTR_TO_MAP_VALUE_OR_NULL, id N
    r6 = 0
  H:
    if r1 == 0 goto out         // extra loop exit
    r1 += 8
    r6 += 1
    if r6 < 3 goto H
  out:
    ...

At the first visit of H, bpf_widen_scev_regs() calls bpf_set_reg_range()
on r1, which is still maybe-null. This gives r1 a variable offset
([0,16], step 8, non-constant var_off) while keeping the PTR_MAYBE_NULL
flag and id N, because scratch_scalar_id() only clears scalar ids.

The verifier normally never allows this state, because
adjust_ptr_min_max_vals() rejects arithmetic on maybe-null pointers.

The widened state then reaches the null check at H. check_cond_jmp_op()
calls mark_ptr_or_null_regs(), and mark_ptr_or_null_reg() fires:

kernel/bpf/verifier.c:mark_ptr_or_null_reg() {
    if (!(type_is_ptr_alloc_obj(reg->type) || type_is_non_owning_ref(reg->type)) &&
        WARN_ON_ONCE(!tnum_equals_const(reg->var_off, 0)))
        return;
}

So a kernel WARN can be triggered by any program load that is allowed to
use bounded loops (with panic_on_warn, the machine panics). The program is
later rejected at r1 += 8, but only after the WARN.

Should is_widenable_reg_type() reject type_may_be_null(reg->type), or at
least on the linear path? Later commits in the series do not change
is_widenable_reg_type().

[ ... ]

> +int bpf_widen_scev_regs(struct bpf_verifier_env *env, struct bpf_verifier_state *st,
> +			struct bpf_verifier_state *loop_entry, struct bpf_loop_iters *iters)
> +{
> +	struct bpf_func_state *cur_func = st->frame[st->curframe];
> +	struct bpf_func_state *entry_func = loop_entry->frame[loop_entry->curframe];
> +	struct bpf_verifier_log *log = &env->log;
> +	struct scev *scev = env->scev;
> +	struct bpf_reg_state *reg;
> +	struct env *header_env;
> +	struct bounds bounds;
> +	u32 r, base_reg, r_expr, a, b;
> +	int insn_idx = st->insn_idx;
> +	s64 slope_imm;
> +	int err;
> +
> +	header_env = find_header_env(scev, insn_idx);
> +	for (r = 0; r < REGS_NUM; r++) {
> +		if (!scev_reg_alive(env, st, r))
> +			continue;
> +
> +		r_expr = header_env->reg2scev[r];
> +		/* If SCEV for r is (linear <reg> <slope>)*/
> +		if (is_simple_linear(scev, r_expr, &base_reg, &slope_imm) &&
> +		    base_reg == r) {
> +			reg = scev_regno_to_reg(env, cur_func, r);
> +			/* Feasibility was checked in the filtering pass above. */
                             ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> +			if (!linear_bounds(reg, iters, slope_imm, &bounds)) {
> +				verifier_bug(env, "scev widen bounds overflow for r%d", r);
> +				return -EFAULT;
> +			}

The comment refers to a "filtering pass above", but bpf_widen_scev_regs()
has no such pass. The overflow/feasibility filtering is done earlier in a
different function, bpf_compute_loop_iters() (the "Can't widen if the
iteration range overflows" check), which handle_loop_entry_exit() calls
before this one.

Could the comment name bpf_compute_loop_iters() so readers know where the
invariant that makes the verifier_bug() unreachable is established?

The comment above union_any_reg() has the same wording ("The filtering
pass has checked ...").

[ ... ]

> diff --git a/kernel/bpf/states.c b/kernel/bpf/states.c
> index 68df27e34b60..c1771a355e4e 100644
> --- a/kernel/bpf/states.c
> +++ b/kernel/bpf/states.c

[ ... ]

> @@ -1359,10 +1400,11 @@ int bpf_is_state_visited(struct bpf_verifier_env *env, int insn_idx)
>  			continue;
>
>  		if (sl->state.branches) {
> -			struct bpf_func_state *frame = sl->state.frame[0];
> +			struct bpf_func_state *old_top_frame = sl->state.frame[0];
> +			struct bpf_func_state *old_cur_frame = sl->state.frame[sl->state.curframe];
>
> -			if (frame->in_async_callback_fn &&
> -			    frame->async_entry_cnt != cur->frame[0]->async_entry_cnt) {
> +			if (old_top_frame->in_async_callback_fn &&
> +			    old_top_frame->async_entry_cnt != cur->frame[0]->async_entry_cnt) {
>  				/* Different async_entry_cnt means that the verifier is
>  				 * processing another entry into async callback.
>  				 * Seeing the same state is not an indication of infinite
> @@ -1461,6 +1503,20 @@ int bpf_is_state_visited(struct bpf_verifier_env *env, int insn_idx)
>  				}
>  				goto skip_inf_loop_check;
>  			}
> +
> +			/*
> +			 * If old state belongs to a control flow loop that we know terminates,
> +			 * it should be safe to prune current state.
> +			 */
> +			if (old_cur_frame->loop_stack_cnt &&
> +			    old_cur_frame->loop_stack[old_cur_frame->loop_stack_cnt - 1].terminates) {
> +				if (states_equal(env, &sl->state, cur, RANGE_WITHIN)) {
> +					loop = true;
> +					goto hit;
> +				}
> +				goto skip_inf_loop_check;
> +			}
> +

Pruning against a checkpoint that is still being explored (sl->state.branches > 0)
is only safe if every cycle leading from that checkpoint back to the
current state is proven to terminate.

The new check looks only at whether the innermost loop on the old state's
loop stack terminates. loop_stack_safe() (called from func_states_equal())
compares loop_id, iters.max_header_count, iters.pre_cond and terminates,
but it does not compare loop_stack_entry.entry_state, which is the thing
that identifies a particular invocation of the loop.

If branches > 0, cur descends from the old checkpoint, so some cycle joins
them. That cycle does not have to be the inner loop's backedge. It can
leave the terminating inner loop through an exit edge (loop_stack_pop()),
go around an enclosing loop that was pushed with terminates == false, and
enter the inner loop again.

The re-entry pushes a new entry with a new entry_state but, when the entry
values are the same, with the same loop_id/max_header_count/pre_cond/
terminates. The widened state W from the earlier invocation is still an
ancestor with branches > 0, so its top-of-stack entry says "terminates".
RANGE_WITHIN then prunes cur against W with loop = true.

Before this change, the same states went to the states_maybe_looping()/
EXACT infinite-loop check or ran into the complexity limit. Now the
non-terminating enclosing loop is accepted as converged, and its
termination is never established.

The iterator path just above has the same problem and handles it with an
identity check: "The loop converged only if it's the same iterator. The
one that was destroyed and created again starts from the beginning."
(iter_state->id == old_iter->id).

The SCEV path has no matching check, such as requiring the same
entry_state for the top entry, or requiring every enclosing entry on the
stack to be terminating. Nothing later in the series changes
kernel/bpf/states.c.

Could this also require the invocation to match, for example compare
entry_state of the top entry, or entry_state for every terminating entry
in loop_stack_safe() when used for in-progress pruning? The goal is that
cycles through an enclosing, unproven loop fall through to the existing
infinite-loop detection.

[ ... ]

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 57085f1bf915..9f56ffe09eba 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[ ... ]

> +static bool has_entered_loop(struct bpf_verifier_env *env)
> +{
> +	struct bpf_insn_aux_data *aux = env->insn_aux_data;
> +	int prev_insn_idx = env->prev_insn_idx;
> +	int insn_idx = env->insn_idx;
> +
> +	return aux[insn_idx].loop_entry &&
> +	       (prev_insn_idx == -1 ||
> +		bpf_loop_at_index(env, prev_insn_idx) != bpf_loop_at_index(env, insn_idx));
> +}
> +
> +static bool is_next_loop_iteration(struct bpf_verifier_env *env)
> +{
> +	struct bpf_insn_aux_data *aux = env->insn_aux_data;
> +	int prev_insn_idx = env->prev_insn_idx;
> +	int insn_idx = env->insn_idx;
> +
> +	return aux[insn_idx].loop_entry &&
> +	       (prev_insn_idx != -1 &&
> +		bpf_loop_at_index(env, prev_insn_idx) == bpf_loop_at_index(env, insn_idx));
> +}

is_next_loop_iteration() and has_entered_loop() classify an edge as a
backedge only by comparing bpf_loop_at_index(prev_insn_idx) with
bpf_loop_at_index(insn_idx). They assume that if prev_insn_idx is in the
same loop, it is also in the same frame.

That does not hold for async callbacks, which may reference themselves
(check_helper_call/push_callback_call: "there is no real recursion here.
timer and workqueue callbacks are async").

The async state comes from push_async_cb(env,
env->subprog_info[subprog].start, insn_idx, ...). So when it is popped,
env->insn_idx is the callback's first instruction, env->prev_insn_idx is
the bpf_timer_set_callback()/bpf_wq_set_callback() call instruction, and
the frame is freshly allocated with loop_stack_cnt == 0.

Trigger: subprog S's first instruction is a loop header H (for example a
may_goto-bounded or otherwise bounded loop starting at S's entry), and S
calls bpf_timer_set_callback(timer, S) from inside loop H.

- aux[H].loop_entry is set, bpf_loop_at_index(call_insn) == H and
  bpf_loop_at_index(H) == H.
- So is_next_loop_iteration() returns true and handle_loop_entry_exit()
  calls maybe_clamp_scev_regs().
- On the empty loop stack of the fresh callback frame, that hits
  verifier_bug() and returns -EFAULT.
- has_entered_loop() returns false for the same edge, so H would never be
  pushed anyway. Without the first check, the new do_check() check "loop
  stack empty at %d, while inside the loop %d" would fire as well.

Before this patch, such a program verified normally. Now it is rejected
with -EFAULT, and a user-supplied program can trigger WARN_ONCE
(BPF_WARN_ONCE under CONFIG_DEBUG_KERNEL), which fuzzers report as a
kernel warning.

Could this treat any prev_insn_idx that belongs to a different frame or
callback entry as a loop entry? For example, check that the current
frame's loop stack contains bpf_loop_at_index(insn_idx), or push async and
callback states with prev_insn_idx = -1.

Alternatively, could has_entered_loop() become true whenever the header is
not on cur_func()->loop_stack?

[ ... ]

> +static bool has_exited_loop(struct bpf_verifier_env *env)
> +{
> +	struct bpf_insn_aux_data *aux = env->insn_aux_data;
> +	int prev_insn_idx = env->prev_insn_idx;
> +	int insn_idx = env->insn_idx;
> +	int prev_loop_idx, h;
> +
> +	if (prev_insn_idx == -1)
> +		return false;
> +
> +	prev_loop_idx = bpf_loop_at_index(env, prev_insn_idx);
> +	if (prev_loop_idx < 0)
> +		return false;
> +
> +	/* Still inside the previous instruction's loop if that loop encloses insn_idx */
> +	for (h = bpf_loop_at_index(env, insn_idx); h >= 0; h = aux[h].loop_header)
> +		if (h == prev_loop_idx)
> +			return false;
> +
> +	return true;
> +}

has_entered_loop() and is_next_loop_iteration() test innermost-loop
equality, bpf_loop_at_index(prev) == bpf_loop_at_index(insn). They do not
test whether the loop at insn_idx encloses prev_insn_idx. has_exited_loop()
does walk the aux[h].loop_header chain, so the three helpers disagree.

Two kinds of real backedges into header H are therefore classified as new
loop entries:

- An edge whose source is inside a nested inner loop. For example, a
  jump-to-condition layout where the inner loop's latch falls through or
  jumps straight to the outer header: bpf_loop_at_index(prev) is the inner
  header, bpf_loop_at_index(insn) is H.
- A return from a bpf-to-bpf call whose call instruction is the loop's
  last body instruction and falls through to H: prev_insn_idx is the
  callee's exit instruction, so bpf_loop_at_index(prev) == -1.

What happens on such an edge in handle_loop_entry_exit():

- is_next_loop_iteration() is false, so bpf_clamp_scev_regs() is never
  applied on that backedge.
- has_entered_loop() is true, so bpf_compute_loop_iters() runs again. If
  it succeeds, the code does another bpf_split_cur_state() and
  bpf_widen_scev_regs() against the mid-loop state.
- loop_stack_push() then pushes nothing, because H is already the top of
  the stack.

Consequence: lockstep induction variables (registers that advance with the
counter but are not bounded by the loop condition) are widened at loop
entry but never clamped back to their SCEV bounds. Their ranges drift
further each iteration, so the state does not become RANGE_WITHIN the
widened checkpoint W.

The loop is then walked again with growing ranges instead of exact
constants. A program whose pre-patch walk used exact per-iteration
constants (for example j used as a bounded map-value or stack offset) can
now be falsely rejected, or can use many more states, plus one extra
checkpoint per misclassified backedge.

This is not a soundness problem: the widened values are supersets.
Suggested fix: classify the edge as a next iteration when
bpf_loop_at_index(insn_idx) is the header and it is on the current frame's
loop stack, or when that header encloses bpf_loop_at_index(prev_insn_idx)
through the aux[].loop_header chain, as has_exited_loop() already does.

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/36346543957
--===============3543033587667165334==--
