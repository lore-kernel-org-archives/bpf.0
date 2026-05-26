Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28CDF3D1CB2
	for <bpf@vger.kernel.org>; Tue, 26 May 2026 10:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779789944; cv=none; b=GmMLM8gkf+QuQZqWEdF0Wy+btS642/+XmHCbveBPt2HhQHwDb51lFfMcLyQiATfl9Oj8axG4y6qFk+9mzb1DyQ6QSc4W+HpsfQTZhTTiC0ji6O/RsLtN3qhkLHXkiid1+4EE5gJSRDdStsCS4NOWL3UGId1UuF4oHTPLEmQvK0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779789944; c=relaxed/simple;
	bh=IlL1lkhJwaZYJdKvf+EgfoBinPka2LtJjJXFXuy/V4Q=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=iXY5Smx6dElPfyZjFUNkwOrW7cGcgrS9TVOzN1TbmDg42BG+T71txosCEa5P2OgHqdpaUqkvVulVffxpgo7gldNcudM/UiG4tSYCgfxD3ZR1EgAwVUoGRUyBf26fXCGO84ZsXlw+zCnqkWSxbefNSAxaOBgBxfBop9CYuHMFP0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PB5Zo9wF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PB5Zo9wF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DAFE1F000E9;
	Tue, 26 May 2026 10:05:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779789942;
	bh=FDstuirwSNX0OPm4vZXyRKveHGFvFonA/3rLBlSWYpA=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=PB5Zo9wF1D7xxpWD5UppdEZe5bi2GgCC/T9tuCLa04ag7sPRXmsPr9H/ymjfB0Oeo
	 mYegQcSM4mTMGv3LRAnApsqIVA472JcUVWqGReX7D3MQxPsGr7yuW8UjsNZnJNSIGu
	 l8kFr6X2I6BAU1AZPjQYftCpYn1+LDXoHXAAsL1EHFEXgTo1XLo62ck1DzDqfWXWai
	 wE0o2YCOXwBd8pw5U6fcQyy2MhIcdeONkkbIDXjFWtIqPOBnRtNsfd2zf2gIOC+6GN
	 ucthVcQ7wO1e2cFGR26q50polo+wLdt18on73+6E/RJ0hKh5D8JevHFbvJOvlzD2lm
	 9paX/dsHkvVPw==
Content-Type: multipart/mixed; boundary="===============8123383875555294971=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <e98190c9cf56e356e517d69e5409b8fa34ee99342287c612418fbfe57319e1c4@mail.kernel.org>
In-Reply-To: <20260526-better-1m-reporting-v1-5-51e4f2c59780@gmail.com>
References: <20260526-better-1m-reporting-v1-5-51e4f2c59780@gmail.com>
Subject: Re: [PATCH RFC bpf-next 5/6] bpf: report register diff summary for hot callchains
From: bot+bpf-ci@kernel.org
To: eddyz87@gmail.com,bpf@vger.kernel.org,ast@kernel.org
Cc: andrii@kernel.org,daniel@iogearbox.net,martin.lau@linux.dev,kernel-team@fb.com,yonghong.song@linux.dev,eddyz87@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Tue, 26 May 2026 10:05:42 +0000 (UTC)

--===============8123383875555294971==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/states.c b/kernel/bpf/states.c
> index 877338136009..17b48d9f0c10 100644
> --- a/kernel/bpf/states.c
> +++ b/kernel/bpf/states.c

[ ... ]

> @@ -1588,3 +1627,94 @@ int bpf_is_state_visited(struct bpf_verifier_env *env, int insn_idx)
>  	list_add(&new_sl->node, head);
>  	return 0;
>  }
> +
> +static bool callchain_matches_state(struct bpf_callchain *cc,
> +				    struct bpf_verifier_state *st)
> +{
> +	int i;
> +
> +	if (st->curframe != cc->curframe)
> +		return false;
> +	for (i = 0; i < (int)cc->curframe; i++)
> +		if (st->frame[i + 1]->callsite != cc->insn_idx[i])
> +			return false;
> +	return true;
> +}
> +
> +struct state_diff_cnt {
> +	struct bpf_state_diff diff;
> +	u32 cnt;
> +};
> +
> +static int state_diff_cmp(const void *a, const void *b)
> +{
> +	return ((struct state_diff_cnt *)b)->cnt - ((struct state_diff_cnt *)a)->cnt;
> +}
> +
> +static bool state_diff_eq(struct bpf_state_diff *a, struct bpf_state_diff *b)
> +{
> +	return a->frame == b->frame && a->slot == b->slot && a->kind == b->kind;
> +}
> +
> +int bpf_sample_state_diffs(struct bpf_verifier_env *env,
> +			   struct bpf_callchain *cc,
> +			   struct bpf_state_diff *top_diffs,
> +			   int *nr_diffs)
> +{
> +	struct bpf_verifier_state_list *sl_i, *sl_j;
> +	struct state_diff_cnt *diff_cnts = NULL;
> +	struct list_head *pos_i, *pos_j, *head;
> +	u32 leaf_insn, callsite, hash_idx;
> +	int i, cap = 0, nr_locs = 0;
> +
> +	leaf_insn = cc->insn_idx[cc->curframe];
> +	callsite = cc->curframe > 0 ? cc->insn_idx[cc->curframe - 1] : BPF_MAIN_FUNC;
> +	hash_idx = (leaf_insn ^ callsite) % env->prog->len;
> +	head = &env->explored_states[hash_idx];
> +
> +	list_for_each(pos_i, head) {
> +		sl_i = container_of(pos_i, struct bpf_verifier_state_list, node);
> +		if (!callchain_matches_state(cc, &sl_i->state))
> +			continue;
> +		list_for_each(pos_j, pos_i) {
                                       ^^^^^^
> +			struct bpf_state_diff diff = {};
> +
> +			sl_j = container_of(pos_j, struct bpf_verifier_state_list, node);

Can this dereference corrupt memory?

The inner list_for_each(pos_j, pos_i) walks the list starting from
pos_i (an element in the list, not the list head). The
env->explored_states array contains standalone list_head anchors (not
embedded in bpf_verifier_state_list structures), so when the iteration
crosses the anchor, pos_j points to the bare list_head at
env->explored_states[hash_idx].

At that point, the container_of() produces an invalid pointer, and the
subsequent dereference via &sl_j->state accesses arbitrary memory adjacent
to the explored_states array (potentially other hash buckets). This can
cause spurious matches or crashes when callchain_matches_state() tries to
read sl_j->state.curframe from unrelated memory.

The outer list_for_each(pos_i, head) correctly uses the real anchor as
terminator. For the inner loop to iterate "all elements after pos_i to the
end of the list," it should terminate at head:

    for (pos_j = pos_i->next; pos_j != head; pos_j = pos_j->next)

or use a helper macro that accepts head as the terminator.

> +			if (!callchain_matches_state(cc, &sl_j->state))
> +				continue;
> +			if (states_equal(env, &sl_i->state, &sl_j->state, NOT_EXACT, &diff))
> +				continue;
> +			for (i = 0; i < nr_locs; i++) {
> +				if (state_diff_eq(&diff_cnts[i].diff, &diff)) {
> +					diff_cnts[i].cnt++;
> +					goto next;
> +				}
> +			}
> +			if (nr_locs == cap) {
> +				int new_cap = cap ? cap * 2 : 16;
> +				struct state_diff_cnt *new;
> +
> +				new = kvrealloc(diff_cnts, new_cap * sizeof(*new),
> +						GFP_KERNEL_ACCOUNT);
> +				if (!new) {
> +					kvfree(diff_cnts);
> +					return -ENOMEM;
> +				}
> +				memset(new + cap, 0, (new_cap - cap) * sizeof(*new));
> +				diff_cnts = new;
> +				cap = new_cap;
> +			}
> +			diff_cnts[nr_locs].diff = diff;
> +			diff_cnts[nr_locs].cnt = 1;
> +			nr_locs++;
> +next:;
> +		}
> +	}
> +
> +	sort(diff_cnts, nr_locs, sizeof(*diff_cnts), state_diff_cmp, NULL);
> +	*nr_diffs = min(nr_locs, *nr_diffs);
> +	for (i = 0; i < *nr_diffs; i++)
> +		top_diffs[i] = diff_cnts[i].diff;
> +	kvfree(diff_cnts);
> +	return 0;
> +}
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 8eb8f1ce17c7..7a84eeae395f 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[ ... ]

> @@ -17292,13 +17292,13 @@ static void free_callchain_profile(struct bpf_verifier_env *env)
>  	}
>  }
>
> -static void print_callchain_entry(struct bpf_verifier_env *env,
> -				  struct bpf_callchain_entry *entry, int idx)
> +static int print_callchain_entry(struct bpf_verifier_env *env,
> +				 struct bpf_callchain_entry *entry, int idx)
>  {
>  	struct bpf_callchain *cc = &entry->cc;
>  	const struct bpf_line_info *linfo;
>  	struct bpf_subprog_info *sub;
> -	int i, insn_idx;
> +	int i, err, insn_idx;
>
>  	verbose(env, "#%d most visited simulated stacktrace (visited %llu times):\n",
>  		idx, entry->count);
> @@ -17316,6 +17316,35 @@ static void print_callchain_entry(struct bpf_verifier_env *env,
>  				BPF_LINE_INFO_LINE_NUM(linfo->line_col));
>  		verbose(env, "\n");
>  	}
> +
> +	insn_idx = cc->insn_idx[cc->curframe];
> +	if (bpf_is_force_checkpoint(env, insn_idx)) {
> +		struct bpf_state_diff top_diffs[3];
> +		int nr_diffs = ARRAY_SIZE(top_diffs);
> +
> +		err = bpf_sample_state_diffs(env, cc, top_diffs, &nr_diffs);
> +		if (err)
> +			return err;
> +		for (i = 0; i < nr_diffs; i++) {
> +			struct bpf_state_diff *d = &top_diffs[i];
> +
> +			switch (d->kind) {
> +			case DIFF_REG:
> +				verbose(env, "    Most varying: R%d (frame %d)\n",
> +					d->slot, d->frame);
> +				break;
> +			case DIFF_STACK:
> +				verbose(env, "    Most varying: fp-%d (frame %d)\n",
> +					(d->slot + 1) * BPF_REG_SIZE, d->frame);
> +				break;
> +			case DIFF_ARG:
> +				verbose(env, "    Most varying: arg#%d (frame %d)\n",
> +					d->slot, d->frame);
> +				break;
> +			}
> +		}
> +	}
> +	return 0;
>  }
>
>  static void disasm_subprog(struct bpf_verifier_env *env, struct bpf_subprog_info *sub)

[ ... ]

> @@ -17340,16 +17369,16 @@ static void disasm_subprog(struct bpf_verifier_env *env, struct bpf_subprog_info
>   * Print several most visited simulated stack traces,
>   * and a disasembly of related subprograms.
>   */
> -static void print_hotspots(struct bpf_verifier_env *env)
> +static int print_hotspots(struct bpf_verifier_env *env)
>  {
>  	DECLARE_BITMAP(printed_subs, BPF_MAX_SUBPROGS) = {};
>  	struct bpf_callchain_entry *top[3] = {};
>  	struct bpf_callchain_entry *entry;
>  	struct bpf_subprog_info *sub;
> -	int i, j, bkt, nr_top = 0;
> +	int i, j, err, bkt, nr_top = 0;
>
>  	if (!(env->log.level & BPF_LOG_LEVEL))
> -		return;
> +		return 0;
>
>  	/* Collect the hottest callchains */
>  	hash_for_each(env->callchain_htab, bkt, entry, node) {

[ ... ]

> @@ -17388,9 +17417,14 @@ static void print_hotspots(struct bpf_verifier_env *env)
>
>  	/* Print the hot callchains */
>  	for (i = 0; i < nr_top; i++) {
> -		print_callchain_entry(env, top[i], i + 1);
> +		err = print_callchain_entry(env, top[i], i + 1);
> +		if (err)
> +			return err;
> +
>  		verbose(env, "\n");
>  	}
> +
> +	return 0;
>  }
>
>  static int do_check_insn(struct bpf_verifier_env *env, bool *do_print_state)
> @@ -17527,7 +17561,9 @@ static int do_check(struct bpf_verifier_env *env)
>  		insn_aux = &env->insn_aux_data[env->insn_idx];
>
>  		if (++env->insn_processed > BPF_COMPLEXITY_LIMIT_INSNS) {
> -			print_hotspots(env);
> +			err = print_hotspots(env);
> +			if (err)
> +				return err;
>  			verbose(env,
>  				"BPF program is too large. Processed %d insn\n",
>  				env->insn_processed);

Should diagnostic allocation failures mask the complexity limit verdict?

When the verifier hits BPF_COMPLEXITY_LIMIT_INSNS, do_check() now calls
print_hotspots() and returns its error before emitting the standard
"BPF program is too large" message.

If bpf_sample_state_diffs() returns -ENOMEM from kvrealloc() during
diagnostic printing, do_check() propagates that error to userspace instead
of the expected -E2BIG. The program is correctly rejected, but the
user-visible error shifts from "program too large" to "out of memory"
purely because diagnostic output failed to allocate.

Would it be better to ignore or log-and-discard errors from
print_hotspots() so that -E2BIG and the "too large" message are always
produced when the complexity limit is reached?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/26444655429
--===============8123383875555294971==--
