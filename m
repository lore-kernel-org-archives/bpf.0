Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F9253C1D56
	for <bpf@vger.kernel.org>; Sun, 27 Sep 2026 20:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790541783; cv=none; b=TvFhYS3W0WNlEXS+hx1eGtcigkhkT9aOhDd9c8srI6Ycv4gep3gZNoFIZKvMkbwM0mbraxiz5oZCMrNbkeFDG4pgMr4UsFFcN/Xy3b2RGEm82KhFiX4q6wloBmEgUGUnana8OpsDhP86/uQPhVYoXhSBdHTg1FR2JxEJ94l+dKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790541783; c=relaxed/simple;
	bh=zQc2Jkegn0E2cK6Pzm5Gg55Dtj9iwSPbqqrYtslDApM=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=AI6xYiPmDvpQtt/GYM4JsY6BtN67ZqW2RT8gc7V0ex3fCPsy88uF8itARu+ySHu7qCIeVX4iD81wog88jf9owQ0+qOnJlRF1qnSC4GFQkgLZhAIGZiAJFYni13pZhTL+Lz0YT6WOU2UZMpJ4CxBAfmUYiN3As/84dpO+JL3aXn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q+tt2vur; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q+tt2vur"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 299DD1F000FF;
	Sun, 27 Sep 2026 20:43:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790541781;
	bh=HYzVx+sWLHAKL8OtKjnt8kpFA5FT85FDMfB3ZYksnrY=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=Q+tt2vur9QpgNJvPRKv4L/wHXIl6mkLe50eSAXp0nfLJopHvdO+YD7/QBTdP+bVo+
	 wvSqIV3zIMck7hVxuz4CUJdOljbHIoDNK67QcvXyKzOLXDk+Cwuzo3H2oQDjwTSgUE
	 k9bGbGHE1jvnanaOLW8YpHJ73WWjqVw10MJ4mtr7Akl2PJni1Tky6kqRXazr42nDGo
	 j1LVXiJ6f10uL9jkwaxZ4FZzydFS6k/pF3MpF4EG0+5oNyQsF8MLhWe+kBbXVpwBUP
	 KE5DWw+BsjzctNZvH87FD0B1fag+dafKNjrBuGLDhcuZcbTLnCbo3mmc9+HN6YebPp
	 w+f/zJJAIthYw==
Content-Type: multipart/mixed; boundary="===============8291596240482757525=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <c36950d9dfb439185a3aa399116879c5a07f9c092ee4ef3134398bb9921a503f@mail.kernel.org>
In-Reply-To: <20260926-scev-minimal-rebase-v1-24-c8e5ab5ba79f@gmail.com>
References: <20260926-scev-minimal-rebase-v1-24-c8e5ab5ba79f@gmail.com>
Subject: Re: [PATCH bpf-next 24/36] bpf: compute scalar evolution expressions for loops
From: bot+bpf-ci@kernel.org
To: eddyz87@gmail.com,bpf@vger.kernel.org,ast@kernel.org,andrii@kernel.org
Cc: daniel@iogearbox.net,martin.lau@linux.dev,kernel-team@fb.com,yonghong.song@linux.dev,eddyz87@gmail.com,memxor@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Sun, 27 Sep 2026 20:43:01 +0000 (UTC)

--===============8291596240482757525==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/scev.c b/kernel/bpf/scev.c
> new file mode 100644
> index 000000000000..396b0c776dfa
> --- /dev/null
> +++ b/kernel/bpf/scev.c

[ ... ]

> +static int add_expr(struct scev *scev, struct expr e)
> +{
> +	struct expr_bucket *bucket;
> +	u32 i, id, hash, new_cap;
> +	void *tmp;
> +
> +	hash = expr_hash(&e) % NUM_BUCKETS;
> +	bucket = scev->exprs_ht[hash];
> +
> +	if (bucket) {
> +		for (i = 0; i < bucket->cnt; i++) {
> +			id = bucket->ids[i];
> +			if (expr_eq(&e, &scev->exprs[id]))
> +				return id;
> +		}
> +	}
> +
> +	if (!bucket || bucket->cap == bucket->cnt) {
> +		new_cap = bucket ? bucket->cap * 2 : 32;
> +		bucket = kvrealloc(bucket, sizeof(*bucket) + sizeof(u32) * new_cap, GFP_KERNEL_ACCOUNT | __GFP_ZERO);
> +		if (!bucket)
> +			return -ENOMEM;
> +		scev->exprs_ht[hash] = bucket;
> +		bucket->cap = new_cap;
> +	}
> +
> +	if (scev->exprs_cnt == scev->exprs_cap) {
> +		new_cap = scev->exprs_cap + 256;
> +		tmp = kvrealloc(scev->exprs, sizeof(struct expr) * new_cap, GFP_KERNEL_ACCOUNT);
> +		if (!tmp)
> +			return -ENOMEM;
> +		scev->exprs = tmp;
> +		scev->exprs_cap = new_cap;
> +	}
> +
> +	id = scev->exprs_cnt++;
> +	scev->exprs[id] = e;
> +	bucket->ids[bucket->cnt++] = id;
> +	return id;
> +}

Could this cause excessive CPU time during verification for programs with
many loops?

The hash table has a fixed NUM_BUCKETS (256) and never resizes. The linear
search through each bucket grows quadratically with the number of distinct
expressions, which accumulates across all loops in a program. A program
near BPF_COMPLEXITY_LIMIT_INSNS (1M instructions) laid out as bounded
loops of ALU operations could generate around 3M expressions, leading to
roughly 1.7e10 bucket comparisons.

The exprs array also grows by a fixed 256 entries per realloc. Once past
the kmalloc range, kvrealloc falls back to vmalloc, and vrealloc copies
the entire array on every page-boundary growth.

There are no cond_resched or signal_pending checks in the SCEV computation
path, which runs from bpf_check before do_check_main. Could this cause an
uninterruptible CPU stall with soft-lockup warnings on systems without
CONFIG_PREEMPT?

[ ... ]

> +static void setup_initial_loop_env(struct bpf_verifier_env *env, struct env *e, int insn_idx)
> +{
> +	struct scev *scev = env->scev;
> +	int i;
> +
> +	for (i = 0; i < REGS_NUM; i++)
> +		e->reg2expr[i] = expr1(scev, REG, i);
> +}

Does this handle expr1 allocation failures?

expr1 calls add_expr, which returns a negative errno when kvrealloc fails,
for example under a memcg limit or fault injection. The loop fills REGS_NUM
(267) entries, so the exprs array is likely to grow during the loop. If
that fails, reg2expr[i] ends up as 0xFFFFFFF4 (-ENOMEM cast to u32) for
one or more high stack-slot registers.

The bogus id is then used as an index into scev->exprs:

kernel/bpf/scev.c:transform_expr_once() does expr = scev->exprs[root],
with root being u32 0xFFFFFFF4, when reached from compute_header_scevs.

kernel/bpf/scev.c:forget_non_invariants() does header_expr =
&scev->exprs[header_env->reg2expr[i]] when the loop is nested in an outer
one.

That is an out-of-bounds read tens of GiB past the array. Should
setup_initial_loop_env return int and fail on id < 0, with
compute_scev_for_loop propagating that error?

[ ... ]

> +static int mk_fill(struct scev *scev, int id, u8 code)
> +{
> +	bool sx = BPF_MODE(code) == BPF_MEMSX;
> +
> +	switch (BPF_SIZE(code)) {
> +	case BPF_B:  return expr1(scev, sx ? SEXT8  : ZEXT8,  id);
> +	case BPF_H:  return expr1(scev, sx ? SEXT16 : ZEXT16, id);
> +	case BPF_W:  return expr1(scev, sx ? SEXT32 : ZEXT32, id);
> +	case BPF_DW: return sx ? UNKNOWN_EXPR_ID : id; /* DW sign-extended load is invalid */
> +	}
> +	return UNKNOWN_EXPR_ID;
> +}

[ ... ]

> +static int maybe_load_fp(struct scev *scev, struct env *e, struct bpf_insn *insn)
> +{
> +	int id;
> +
> +	if (insn->src_reg == BPF_REG_FP && is_spill_off(insn->off))
> +		id = mk_fill(scev, e->reg2expr[off_to_reg(insn)], insn->code);
> +	else
> +		id = OPAQUE_EXPR_ID;
> +	return replace_reg(scev, e, insn->dst_reg, id);
> +}

Does mk_fill account for endianness?

maybe_load_fp calls mk_fill for any 8-byte-aligned fp offset, and mk_fill
models a narrow fill as the low-order bits of the spilled 64-bit value
(ZEXTn or SEXTn of the slot expression). That only holds on little-endian.

On a big-endian host such as s390, a B/H/W load at the start of an 8-byte
slot (fp-8, fp-16, etc.) reads the high-order bytes of a DW spill, not the
low-order ones. For BPF_W, simplify then folds ZEXT32(IMM c) into
IMM((u32)c), producing an immediate that does not match the runtime value.

The later commit 1987b0e52b34 in this series uses these expressions in
bpf_clamp_scev_regs for backedge clamping and in bpf_widen_scev_regs for
widening. Wrong immediates there can lead to incorrect register ranges.

Should mk_fill special-case big-endian layout or return OPAQUE or UNKNOWN
for narrow fills when little_endian is false?

[ ... ]

> +static void forget_non_invariants(struct scev *scev, struct env *acc, struct env *header_env)
> +{
> +	struct expr *header_expr;
> +	int i;
> +
> +	if (acc->empty)
> +		acc->empty = false;
> +
> +	for (i = 0; i < REGS_NUM; i++) {
> +		header_expr = &scev->exprs[header_env->reg2expr[i]];
> +		if (is_expr1(header_expr, REG, i))
> +			continue;
> +		acc->reg2expr[i] = UNKNOWN_EXPR_ID;
> +	}
> +}

[ ... ]

> +static int compute_scev_for_loop(struct bpf_verifier_env *env, int cur_header)
> +{
> +	struct bpf_min_heap *worklist = &env->scev->worklist;
> +	struct bpf_insn_aux_data *aux = env->insn_aux_data;
> +	struct bpf_loop *cur_loop = aux[cur_header].loop;
> +	struct env *header_env, *nested_header_env;
> +	struct scev *scev = env->scev;
> +	struct bpf_loop *nested_loop;
> +	struct env *cur_env = NULL;
> +	struct env *old_env = NULL;
> +	struct bpf_iarray *succ;
> +	bool log_level2 = env->log.level & BPF_LOG_LEVEL2;
> +	int s, i, err, idx, succ_idx;

[ ... ]

> +		memcpy(cur_env, find_loop_env(scev, cur_header, idx), sizeof(*cur_env));
> +		if (nested_loop) {
> +			/*
> +			 * Process nested loop as a single instruction by
> +			 * forgetting anything non-invariant in the nested loop
> +			 */
> +			if (log_level2)
> +				memcpy(old_env, cur_env, sizeof(*old_env));
> +			nested_header_env = find_header_env(scev, idx);
> +			forget_non_invariants(scev, cur_env, nested_header_env);
> +			if (log_level2)
> +				log_env_changes(env, LOG_AT_TRANSFER, old_env, cur_env, idx);
> +			/*
> +			 * Treat nested loop exits as successors,
> +			 * join cur_env into successor's envs.
> +			 */
> +			for (i = 0; i < nested_loop->exits_cnt; i++) {
> +				s = nested_loop->exits[i].to;
> +				err = join_successor(env, cur_header, s, old_env, cur_env);
> +				if (err)
> +					goto out;
> +			}

Does forget_non_invariants correctly identify invariants across nested
loops?

The code decides that register i is invariant across a nested loop only by
checking that the nested loop's header env maps i to (reg i). The header
env is the join of the backedge contributions only. But a register can hold
a different value on an exit edge and still be restored before the latch,
either by an exact register copy (MOV copies the expression id) or by a
spill and fill.

For example, using 64-bit arithmetic with r7 as a map value pointer and r6
starting at 0:

    2: r9 = 0                 // outer header
    3: r8 = r6                // inner header
    4: r6 = -1000
    5: r9 += 1
    6: if r9 > 5 goto 9       // inner exit, r6 == -1000 here
    7: r6 = r8                // restores r6: expr is (reg r6) again
    8: goto 3                 // inner backedge
    9: r6 += 1
   10: if r6 s< 3 goto 2      // outer latch

The inner header env has r6 = (reg r6), so forget_non_invariants keeps r6
and edge 6->9 receives r6 = (reg r6) instead of UNKNOWN. The outer header
SCEV becomes r6 = (linear r6 1), and the latch at 10 is matched as a linear
latch. At runtime, though, r6 is -999 when the backedge is first taken.

The later commit 1987b0e52b34 in this series consumes these SCEVs.
bpf_compute_loop_iters computes max_header_count = 3 for the loop above,
and bpf_widen_scev_regs widens r6 at the header to [0..2]. On the
backedge, bpf_clamp_scev_regs intersects the verifier's actual r6 range
with linear_bounds(entry r6 = 0) = [0..2]. With r6 = -999 the intersection
is empty, which hits verifier_bug and fails with -EFAULT. If the modified
value is a range that overlaps [0..2], the clamp silently narrows r6 to
[0..2], the widened header checkpoint then prunes the next iteration, and a
later r6-indexed map value access is accepted even though r6 can be
negative at runtime.

Should forget_non_invariants check that a register is unchanged along every
path from the nested header to each exit, not only along the paths to the
latch?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/36346543957
--===============8291596240482757525==--
