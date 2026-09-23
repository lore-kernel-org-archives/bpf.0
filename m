Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C0B13905F4
	for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 23:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790206636; cv=none; b=FqWTTHFlEYzXr4cbrINVPXJvM5oE9IMCVAfTVQ8arcfp2gqbo3NYBIxf8vUM7u7OXWUyWS7LiEK7ugBI6qHpfoxjapIu/qCT6wY662TWIbBkZJe4RSZeh8QapRHrdD+oe+QuNfd4wQ572dLXybDacGzInw+lYi47gsVXBz8AFHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790206636; c=relaxed/simple;
	bh=bud0i9ScVhUyQl5NjeIlK48m+LtgyOXSwh98vBqQaFs=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=fW2JUnNtt2hquMDq4HwHoNSWcHKJ1alf/Bxg81zQxzb+5obxo/dStp0n44ZrOXmxzVw34hBA5atCI3QNS80DjXbavKlZtdIoDGsXWNBbX38/A71a2kvw/R1Y6mWvYk9vxQOqNMHygS2xpTi+m3p0ZjzdhMQZfkMreghnwa585Zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VEi6eUeF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VEi6eUeF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54E7F1F000FF;
	Wed, 23 Sep 2026 23:37:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790206634;
	bh=zTSceNqgNteixi0yW4H6sRXDXd5N/W8vMPJ4Tizxg4s=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=VEi6eUeFE6HasHh9gyMs/JWBhwiB9grp36YOJ+5aLqA4SNP6IvmNnlWTbszIe6h9g
	 aKuEDqKcJFScKCdA8bC1oj4uuAqzbQGUfPbSLvY5aCwhkIjg9htZu9r5t8gwYYaSok
	 xd58otZ2G5QbOG5zkMiy3DM+Gdvfm34sjK7OJ6OCvdwLmGbNIjpHvCV/WBmyAfFLLQ
	 aEg2Y0TPQKeyKMo8/xQNHsUA9+cb8b7rJxc7lKryVYnutafima1dvO9yw/aYjDapxA
	 hI7G2TSiGQJ23hhqBoqVfCV7l/cNxDexUEoC5yn89aTXqth5zRkSczbE2ynBs0Rpuj
	 xZCIxve8fMuQA==
Content-Type: multipart/mixed; boundary="===============7747721747467046637=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <d3cbffce24d4e675faa467abc23089698a0e824b647d378a3dc41ababa46c5c7@mail.kernel.org>
In-Reply-To: <20260923223554.562379-4-alexei.starovoitov@gmail.com>
References: <20260923223554.562379-4-alexei.starovoitov@gmail.com>
Subject: Re: [PATCH bpf-next 3/8] bpf: Widen scalars at loop heads
From: bot+bpf-ci@kernel.org
To: alexei.starovoitov@gmail.com,bpf@vger.kernel.org
Cc: daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Wed, 23 Sep 2026 23:37:13 +0000 (UTC)

--===============7747721747467046637==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> index 5a08f079a4896..981902cd5b71a 100644
> --- a/include/linux/bpf_verifier.h
> +++ b/include/linux/bpf_verifier.h

[ ... ]

> diff --git a/kernel/bpf/states.c b/kernel/bpf/states.c
> index 66fb11b6c6a76..22987ce070e74 100644
> --- a/kernel/bpf/states.c
> +++ b/kernel/bpf/states.c
> @@ -1108,6 +1108,41 @@ static int propagate_backedges(struct bpf_verifier_env *env, struct bpf_scc_visi
>  	return 0;
>  }
>
> +/* Did the walk get to @insn_idx over a back-edge? */
> +static bool is_backedge(struct bpf_verifier_env *env, int insn_idx)
> +{
> +	int prev = env->prev_insn_idx;
> +	struct bpf_insn_aux_data *aux;
> +	struct bpf_insn *insn;
> +
> +	if (prev < 0 || prev >= env->prog->len)
> +		return false;
> +	aux = &env->insn_aux_data[prev];
> +	insn = &env->prog->insnsi[prev];
> +	/* check_cfg() does not record the edge of an unconditional jump as a jump */
> +	if ((BPF_CLASS(insn->code) == BPF_JMP || BPF_CLASS(insn->code) == BPF_JMP32) &&
> +	    BPF_OP(insn->code) == BPF_JA)
> +		return aux->backedge_ft || aux->backedge_br;
> +	return insn_idx == prev + 1 ? aux->backedge_ft : aux->backedge_br;
                                      ^^^^

Does this correctly handle LD_IMM64 fall-through and static subprog call
fall-through back-edges?

For LD_IMM64, check_cfg() pushes t + 2 as FALLTHROUGH and marks
backedge_ft on the LD_IMM64 insn. After do_check_insn() adds 1 and
do_check() adds another, is_backedge() is called with insn_idx == prev +
2, not prev + 1. This causes the function to return aux->backedge_br,
which is false:

  0: goto +2
  1: r1 = 0 ll            <- back-edge 1 -> 3 is LD_IMM64 fall-through
  3: r0 = *(u32 *)(r7 +0)
  4: if r0 != 0 goto -4
  5: exit

For a static subprog call, visit_func_call_insn() pushes t + 1 as
FALLTHROUGH, which marks backedge_ft on the call insn. After the callee
returns, prepare_func_exit() sets insn_idx = callsite + 1, while
prev_insn_idx is still the callee's BPF_EXIT. is_backedge() reads the
EXIT insn's aux, which has no backedge flags, and returns false:

  0: goto +1
  1: call subprog         <- back-edge 1 -> 2 is the call fall-through
  2: r0 = *(u32 *)(r7 +0)
  3: if r0 != 0 goto -3
  4: exit

In this commit the result goes to bpf_widen_loop_head():

kernel/bpf/verifier.c:bpf_widen_loop_head() {
  u32 passes = backedge ? old->loop_passes + 1 : 1;
  ...
}

so passes stays at 1 on every trip. The pass schedule (WIDEN_THR_PASSES
/ WIDEN_GEN_PASSES) never moves forward, and the 'states at loop head
%d don't converge' check (passes > WIDEN_MAX_PASSES) never fires. A loop
whose states never converge is walked until the 1M-insn limit, not given
up after 10 trips as the commit message says.

Nothing sets env->widen_loops yet in this commit, so this path only runs
once c7896d6154118 is applied. The larger impact comes with 3a779857709c5
("bpf: Add may_goto to loops that are not walked to the end"), where the
same helper decides whether a run-time bound is needed:

kernel/bpf/verifier.c:loop_head_guard() {
  if (!is_backedge(env, insn_idx))
    return true;
  ...
  return bpf_mark_loop_guard(env, cur);
}

For both edges above this returns true early. Neither guard_pending nor
guard_impossible is set, but the loop-head RANGE_WITHIN hit still calls
add_scc_backedge(), which sets scc_converged for the SCC.
bpf_commit_loop_guards() only looks at insns that have guard_pending or
guard_impossible, so it finds nothing and returns 0. The loop is accepted
even though it was not walked to the end, and no may_goto is added. In
both examples the loop condition depends on memory at r7. A program where
that value stays non-zero never terminates, which can cause soft lockups
or RCU stalls. This needs bpf_capable, since loop heads are only marked
for capable users.

Note that bpf_mark_loop_guard() explicitly handles 'not a jump' (class !=
JMP, op == CALL/EXIT), but these two edges never reach it.

is_backedge() is unchanged at 7d6b7dd8cb91b, the end of the series. A
possible fix: treat the LD_IMM64 fall-through (insn_idx == prev + 2) as
backedge_ft. For a subprog return, look up the call insn (callsite =
insn_idx - 1) instead of the EXIT insn. The guard for that case also has
to be marked, or made impossible, on the call insn so that
bpf_commit_loop_guards() sees it.

> +}
> +
> +/* The state of this walk that was the last to get to loop head @insn_idx. */
> +static struct bpf_verifier_state *loop_head_state(struct bpf_verifier_env *env, int insn_idx)
> +{

[ ... ]

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index cb5d498ada698..85b2691f81b12 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[ ... ]

> @@ -8040,6 +8041,287 @@ static struct bpf_verifier_state *find_prev_entry(struct bpf_verifier_env *env,
>  	return NULL;
>  }
>
> +/* A constant that register @regno is compared with, -1 if any register. */
> +struct widen_thr {
> +	s64 val;
> +	int regno;
> +};
> +
> +struct bpf_widen_thrs {
> +	u32 cnt;
> +	struct widen_thr thr[];
> +};
> +
> +/* passes around a loop that widen to constants the loop compares with */
> +#define WIDEN_THR_PASSES	4
> +/* passes that widen to S32_MAX and the like, later ones drop the bound */
> +#define WIDEN_GEN_PASSES	6
> +/* states at the loop head differ in something that can't be widened */
> +#define WIDEN_MAX_PASSES	10
> +
> +static const struct widen_thr widen_generic[] = {
> +	{ S32_MIN, -1 }, { 0, -1 }, { S32_MAX, -1 }, { U32_MAX, -1 },
> +};
> +
> +static int cmp_widen_thr(const void *a, const void *b)
> +{
> +	s64 x = ((const struct widen_thr *)a)->val;
> +	s64 y = ((const struct widen_thr *)b)->val;
> +
> +	return x < y ? -1 : x > y;
> +}
> +
> +static bool is_cmp_imm(const struct bpf_insn *insn)
> +{
> +	u8 class = BPF_CLASS(insn->code);
> +	u8 op = BPF_OP(insn->code);
> +
> +	if (class != BPF_JMP && class != BPF_JMP32)
> +		return false;
> +	if (BPF_SRC(insn->code) != BPF_K)
> +		return false;
> +	return op != BPF_JA && op != BPF_CALL && op != BPF_EXIT && op != BPF_JCOND;
> +}
> +
> +/*
> + * Sorted constants that registers are compared with in the SCC of @insn_idx.
> + * A range that ends at one of them can be cut back by the exit test of
> + * the loop, so that the state at the loop head stops growing.
> + */
> +static const struct bpf_widen_thrs *scc_thresholds(struct bpf_verifier_env *env, int insn_idx)
> +{
> +	struct bpf_insn_aux_data *aux = env->insn_aux_data;
> +	struct bpf_insn *insns = env->prog->insnsi;
> +	u32 scc = aux[insn_idx].scc;
> +	struct bpf_widen_thrs *thrs;
> +	int i, d, n = 0;
> +
> +	if (!scc)
> +		return NULL;
> +	if (!env->scc_thrs) {
> +		env->scc_thrs = kvzalloc_objs(*env->scc_thrs, env->scc_cnt, GFP_KERNEL_ACCOUNT);
> +		if (!env->scc_thrs)
> +			return NULL;
> +	}
> +	if (env->scc_thrs[scc])
> +		return env->scc_thrs[scc];
> +
> +	for (i = 0; i < env->prog->len; i++)
> +		if (aux[i].scc == scc && is_cmp_imm(&insns[i]))
> +			n++;
> +	thrs = kvzalloc(struct_size(thrs, thr, 3 * n), GFP_KERNEL_ACCOUNT);
> +	if (!thrs)
> +		return NULL;
> +	for (i = 0; i < env->prog->len; i++) {
> +		if (aux[i].scc != scc || !is_cmp_imm(&insns[i]))
> +			continue;
             ^^^^

Can this avoid the quadratic cost when a program has many loops? The
function walks the whole program twice the first time each SCC is widened:

kernel/bpf/verifier.c:scc_thresholds() {
  for (i = 0; i < env->prog->len; i++)
    if (aux[i].scc == scc && is_cmp_imm(&insns[i]))
      n++;
  ...
  for (i = 0; i < env->prog->len; i++) {
    if (aux[i].scc != scc || !is_cmp_imm(&insns[i]))
      continue;
  ...
}

The cache in env->scc_thrs only saves repeat lookups for the same SCC, so
the total cost is O(number of widened loops * prog->len).
bpf_compute_scc() gives every loop its own SCC id. The call chain is
do_check() -> bpf_is_state_visited() -> bpf_widen_loop_head() ->
scc_thresholds(), and it runs the second time any loop head is reached.

With CAP_BPF a program can be up to BPF_COMPLEXITY_LIMIT_INSNS (1M)
instructions long (bpf_prog_load()). Consider a program made of many
copies of a tiny loop such as:

  r1 = 0
L:
  r1 += 1
  if r1 >= 100 goto out
  goto L

Each copy costs only about 10 processed instructions to widen and
converge, so the 1M processed-insn budget allows on the order of 100k
loops in a program several hundred thousand instructions long. That adds
up to about 1e10-1e11 scans of insn_aux_data entries, on the order of
minutes of verifier CPU time. Walking the same program without widening
needs about 1M processed instructions.

The scan cannot cause a soft lockup, because do_check() calls
cond_resched() and checks signal_pending(). It is still an avoidable
quadratic cost that also slows down ordinary large programs with many
loops.

No other per-state path in the verifier scans the whole program: the only
other full passes in verifier.c are check_subprogs() and
sanitize_dead_code().

This commit does not set env->widen_loops yet. The code becomes active in
c7896d6154118 ("bpf: Walk loops with widened states first") for
bpf_capable programs with scc_cnt > 1. scc_thresholds() is unchanged at
the end of the series (7d6b7dd8cb91b), so no later fix was found.

A single O(prog->len) pass would avoid this: count and fill the constants
for all SCCs at once, bucketed by aux[i].scc, on the first call or after
bpf_compute_scc().

> +		for (d = -1; d <= 1; d++) {
> +			thrs->thr[thrs->cnt].val = (s64)insns[i].imm + d;
> +			thrs->thr[thrs->cnt++].regno = insns[i].dst_reg;
> +		}
> +	}
> +	sort(thrs->thr, thrs->cnt, sizeof(thrs->thr[0]), cmp_widen_thr, NULL);
> +	env->scc_thrs[scc] = thrs;
> +	return thrs;
> +}
> +
> +/*
> + * Nearest constant in sorted @thr that is >= @x if @up, <= @x otherwise.
> + * Constants that another register is compared with are skipped.
> + */
> +static bool thr_nearest(const struct widen_thr *thr, u32 cnt, int regno, s64 x, bool up,
> +			s64 *res)
> +{
> +	bool found = false;
> +	u32 i;
> +
> +	for (i = 0; i < cnt; i++) {
> +		if (regno >= 0 && thr[i].regno >= 0 && thr[i].regno != regno)
> +			continue;
> +		if (up && thr[i].val >= x) {
> +			*res = thr[i].val;
> +			return true;
> +		}
> +		if (!up && thr[i].val <= x) {
> +			*res = thr[i].val;
> +			found = true;
> +		}
> +	}
> +	return found;
> +}
> +
> +struct widen_ctx {
> +	const struct bpf_widen_thrs *thrs;
> +	u32 passes;
> +	int regno;
> +};
> +
> +/* Where to move the end @x of a range that keeps moving up or down. */
> +static bool widen_pick(const struct widen_ctx *w, s64 x, bool up, s64 *res)
> +{
> +	bool found = false;
> +	s64 t;
> +
> +	if (w->passes <= WIDEN_THR_PASSES && w->thrs &&
> +	    thr_nearest(w->thrs->thr, w->thrs->cnt, w->regno, x, up, &t)) {
> +		*res = t;
> +		found = true;
> +	}
> +	if (w->passes <= WIDEN_GEN_PASSES &&
> +	    thr_nearest(widen_generic, ARRAY_SIZE(widen_generic), -1, x, up, &t)) {
> +		*res = !found ? t : up ? min(*res, t) : max(*res, t);
> +		found = true;
> +	}
> +	return found;
> +}

The commit message says:

> The first 4 trips use constants of the loop, the next 2 use S32_MIN, 0,
> S32_MAX, U32_MAX, then the bound is dropped.

But widen_pick() checks generic constants on every pass <= WIDEN_GEN_PASSES,
including passes 1-4, and the nearer of the loop constant and the generic
constant wins:

kernel/bpf/verifier.c:widen_pick() {
  if (w->passes <= WIDEN_GEN_PASSES &&
      thr_nearest(widen_generic, ARRAY_SIZE(widen_generic), -1, x, up, &t)) {
    *res = !found ? t : up ? min(*res, t) : max(*res, t);
}

So in passes 1-4 a range end can stop at 0, S32_MIN, S32_MAX or U32_MAX
before it reaches the loop constant.

Example: `for (i = -100; i < 100; i++)`. On pass 1, smax moves from -100
to -99. The loop constants offer 99 and the generic list offers 0, so
smax is widened to 0 rather than 99, and one extra trip is needed before
the state converges. Such stops use up the WIDEN_THR_PASSES budget. After
pass 4 the loop constants are no longer used, so a loop that needs close
to 4 loop-constant steps can end up with a wider bound than the commit
message describes.

This is not unsound, since every choice still widens outward. But either
the commit message should describe the combined behaviour, or the generic
constants should only be used when passes > WIDEN_THR_PASSES, as the
message says.

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/35929952632
--===============7747721747467046637==--
