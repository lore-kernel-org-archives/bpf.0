Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C34873876BE
	for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 23:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790205815; cv=none; b=rHPirP1SHb9Uy5FGI2lt8pGDR+Sm9MjXloDkJhqQDPR+Hz8BQe4dZTnrKwWedVYrNPbA3w21ImePPDnDCrrDZUbiN3rwHvvBdrWvYu8kzkPV5CclCRRb+F3+S8lTkaynncSNPFVDPHLvyvPXZiSirM6wU41NYc0MkIsMOoIcNnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790205815; c=relaxed/simple;
	bh=qZQIJh7uM1cQNHGGc4JfEPtKXQx3RpHLPlu6pT00Utk=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=Q2m8vcQENGWIFIqGzMcbDv5hv4n6QElHQoxkNaE41ou2ZoD9xE1FJNm1VlH+LbwLF2Ry1Xkl8omqRs9X8pFVrFPgAbLyBr54qN4NUU06DjFHxr8TPF3zUgHhRsAk2HkCqJlPNFRIPsMMrAc8rc7pSxxUQMytYHUqICBSH/xKncg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MqFtCYA9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MqFtCYA9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2596A1F000FF;
	Wed, 23 Sep 2026 23:23:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790205813;
	bh=RDd3KwMOWyaBiOF+I/xKJ3IuPwAvcxr3OMvEPS5Oh6w=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=MqFtCYA92CQBo3k/o3ffd1i1fNd5m0zagh9suv0zny/tkkb6hx7aoMM6VhHF10Zg9
	 YiUYioz3yBAhC9jhoWSg5m5eEor1KTQPXZ2gT84qil4fVV4CF76d58phnY7HJbte50
	 qJvWezQhAdc4UQSxgOOrWWfVgu3RgZKZcOVZCucV5XtO0N3/89GrzJNL8B+NF/YREG
	 nIPK27+K4tlLs3Twn7b/YqKTxc7jsZc0qvIIEG6u9UpKovDDwB55nVvyTeZf379o57
	 GOjLV50ThC33Z/O5l8+YuvQAPiEO51nX2oOS8I8mesiPkNuv6bcXSWpUIXZUc16NoQ
	 eQ/SQtMMKxTKw==
Content-Type: multipart/mixed; boundary="===============7335568898387699739=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <0d70bf9223370e198d837f262ed9c826df920a5966ba089a268d1d234d6c632d@mail.kernel.org>
In-Reply-To: <20260923223554.562379-7-alexei.starovoitov@gmail.com>
References: <20260923223554.562379-7-alexei.starovoitov@gmail.com>
Subject: Re: [PATCH bpf-next 6/8] bpf: Walk loops with widened states first
From: bot+bpf-ci@kernel.org
To: alexei.starovoitov@gmail.com,bpf@vger.kernel.org
Cc: daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Wed, 23 Sep 2026 23:23:32 +0000 (UTC)

--===============7335568898387699739==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> index fb35f8a7aedd2..e02ee286067d2 100644
> --- a/include/linux/bpf_verifier.h
> +++ b/include/linux/bpf_verifier.h
> @@ -1068,6 +1068,8 @@ struct bpf_verifier_env {
>  	bool widen_loops;
>  	/* the walk did or tried that, so a failure can be due to the lost precision */
>  	bool widen_used;
> +	/* insns processed by a walk that was given up */
> +	u32 insn_wasted;
>  	struct bpf_iarray *succ;
>  	struct bpf_iarray *gotox_tmp_buf;
>  };
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 2fb5a66bd7d49..871aa45031d61 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[ ... ]

> +/* What a walk changes outside of verifier states and per insn data. */
> +struct walk_snapshot {
> +	struct bpf_insn_aux_data *insn_aux;
> +	struct bpf_func_info_aux *func_aux;
> +	struct bpf_subprog_info *subprogs;
> +	struct bpf_prog *prog;
> +	u64 log_pos, diag_pos;
> +	u32 insn_processed, prev_insn_processed;
> +	u32 jmps_processed, prev_jmps_processed;
> +	u32 total_states, peak_states, max_states_per_insn, longest_mark_read_walk;
> +	u32 explored_states_size, free_list_size, num_backedges;
> +	u32 id_gen, pass_cnt, max_stack_depth;
> +	u32 max_ctx_offset, max_pkt_offset, max_tp_access, max_rdonly_access, max_rdwr_access;
> +	bool seen_direct_write, seen_exception, explore_alu_limits, tail_call_reachable;
> +	void *arena;
> +};

[ ... ]

> +static void walk_snapshot_restore(struct bpf_verifier_env *env, struct walk_snapshot *s)
> +{
> +	struct bpf_prog_aux *aux = env->prog->aux;
> +
> +	memcpy(env->insn_aux_data, s->insn_aux,
> +	       array_size(env->prog->len, sizeof(*env->insn_aux_data)));
> +	memcpy(env->subprog_info, s->subprogs, sizeof(env->subprog_info));
> +	memcpy(env->prog, s->prog, offsetof(struct bpf_prog, insnsi));
                    ^^^^

Does this memcpy leak a callchain buffer reference?

The bpf_prog header (everything before insnsi) contains the bitfield
has_callchain_buf (include/linux/bpf.h:1926). This is not just a flag -
it records that a reference was taken on the global perf callchain buffers.

check_helper_call() takes the reference when it encounters
bpf_get_stack() or bpf_get_task_stack():

kernel/bpf/verifier.c:check_helper_call() {
    if ((func_id == BPF_FUNC_get_stack ||
         func_id == BPF_FUNC_get_task_stack) &&
        !env->prog->has_callchain_buf) {
        ...
        err = get_callchain_buffers(sysctl_perf_event_max_stack);
        ...
        env->prog->has_callchain_buf = true;
    }
}

The matching put is only in bpf_prog_free_deferred():

kernel/bpf/core.c:bpf_prog_free_deferred() {
    if (aux->prog->has_callchain_buf)
        put_callchain_buffers();
}

Consider this sequence when the widened walk fails and is redone:

1. walk_snapshot_save() snapshots the header with has_callchain_buf == 0

2. The widened walk reaches bpf_get_stack() or bpf_get_task_stack() for
   the first time. get_callchain_buffers() increments nr_callchain_events
   and sets has_callchain_buf = 1

3. The walk fails with widen_used set (e.g. -EINVAL, -EACCES, or -E2BIG
   from bpf_commit_loop_guards()). walk_snapshot_restore() copies the
   saved header back with has_callchain_buf == 0, but the reference is
   still held

4. The second walk reaches the helper again. Since has_callchain_buf is
   0, get_callchain_buffers() is called again, incrementing
   nr_callchain_events a second time and setting the bit

5. When the program is freed, bpf_prog_free_deferred() calls
   put_callchain_buffers() once, so one reference leaks

Each such load leaks one count on nr_callchain_events. The count never
returns to zero, so release_callchain_buffers() never runs and the per-CPU
callchain buffers stay allocated forever.

Also, perf_event_max_stack_handler() in kernel/events/callchain.c returns
-EBUSY while nr_callchain_events != 0, so writes to the
kernel.perf_event_max_stack and kernel.perf_event_max_contexts_per_stack
sysctls fail permanently once this happens.

Trigger requirements (all reachable today):
- The program is loaded with bpf_capable
- It has a loop (scc_cnt > 1) and is not offloaded
- It calls bpf_get_stack() or bpf_get_task_stack()
- The widened walk fails with widen_used set

The commit message says 126 selftests programs are walked twice, so the
redo path is hit often. Any repeated load of such a program leaks more
references.

The commit message says the restore covers the "flags of the prog", but
has_callchain_buf is a flag that owns a resource. Should the restore
either preserve has_callchain_buf across the memcpy (save and OR it back
in afterwards) or call put_callchain_buffers() when the live header has
the bit set and the snapshot does not?

> +	if (s->func_aux)
> +		memcpy(aux->func_info_aux, s->func_aux, func_aux_size(env));

[ ... ]

> +	if (!(env->log.level & BPF_LOG_LEVEL2))
> +		bpf_vlog_reset(&env->log, s->log_pos);
> +	bpf_diag_event_log_restore(env, s->diag_pos);
> +}

[ ... ]

> +static int do_check_prog(struct bpf_verifier_env *env)
> +{
> +	struct walk_snapshot snap;
> +	int ret;
> +
> +	/* no loops without bpf_capable, the driver of an offloaded prog sees every insn visit */
> +	if (!env->bpf_capable || env->scc_cnt <= 1 || bpf_prog_is_offloaded(env->prog->aux)) {
> +		ret = do_check_main(env);
> +		return ret ?: do_check_subprogs(env);
> +	}
> +
> +	env->scc_converged = kvzalloc_objs(*env->scc_converged, BITS_TO_LONGS(env->scc_cnt),
> +					   GFP_KERNEL_ACCOUNT);
> +	if (!env->scc_converged)
> +		return -ENOMEM;
> +	ret = walk_snapshot_save(env, &snap);
> +	if (ret)
> +		return ret;
> +
> +	env->widen_loops = true;
> +	env->widen_used = false;
> +	ret = do_check_main(env);
> +	ret = ret ?: do_check_subprogs(env);
> +	if (!ret && env->widen_used)
> +		ret = bpf_commit_loop_guards(env);
> +	env->widen_loops = false;
> +	if (ret && ret != -ENOMEM && ret != -EAGAIN && ret != -EFAULT && env->widen_used) {
> +		walk_snapshot_restore(env, &snap);
> +		if (env->log.level & BPF_LOG_LEVEL)
> +			verbose(env, "walk with widened loops failed, walking every iteration\n");
> +		ret = do_check_main(env);
> +		ret = ret ?: do_check_subprogs(env);
> +	}
> +	walk_snapshot_free(&snap);
> +	return ret;
> +}

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/35929952632
--===============7335568898387699739==--
