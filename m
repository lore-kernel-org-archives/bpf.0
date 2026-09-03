Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 464E913E02A
	for <bpf@vger.kernel.org>; Thu,  3 Sep 2026 22:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788476177; cv=none; b=EbroQz9j1B6htAvaXAWwHeYTtvmj2o6Mjxrfp+nX041FfWiBJRAaHrnkLLXf1W+V0Xb33DPW426+FsDduzc3GKbp25VdVZ60LBR6lItycewBSSVfzqbhBBdQMtKIr47qyxUKOLUxRQt3Xj3B6FifKLipeYcbhP7GGxpW94h123c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788476177; c=relaxed/simple;
	bh=F2rfcmo9Q3EBFlU2r5UAEVozq4Qzm+MsPaFQDHj2bQ4=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=O2W4EXFn9dWLZVvDn88C2pxv+P3BqQQ8xnrGatEj2/3jh9S0w27B3qecfqUAO/2LDLL8EghtfaXpkKABq3n8JI8JbTCetgxbtCxgGoEC9hhY3GIjaue+EYmf/z0+ykxw6SQcRqC4QyKWQwEezTm/8SNuGgGH0OsxuQmgi/l+wfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f1IdtVRw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f1IdtVRw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE2DA1F000E9;
	Thu,  3 Sep 2026 22:56:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788476175;
	bh=h8JcrmHdJMMosXZ9+yrioHZjLQnaYvTSwmhsYffAEz8=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=f1IdtVRwXcsL/zdeIuV5++KOE3ZtA+fdAVEs/BjWCkf6hfKKTOZrL8GvwPhfbyTHa
	 LQSvUncMLO6DNsR2KMIyZDwuS1TfesputBCPx4mfkDm2DYWWI783yIoeRrdehRxWHy
	 pJrovQ6g4IoclU1w5JtLG8FiApF31cSqhU/nk6FL2eq7ArDaD95hmzuBYFHmWbL+CE
	 hqVXdcEseZUQtDLF3RtCvxZCH7SRsI50Fiv/Cu7NZRkh5mokPvQazpS6J2MW8AdE0u
	 v75fzOAabzfzA0yu5gMv09/DxnPk/0XSILxxvdGVWr9iIhYP9VceXHFsXB6LpIczA1
	 Hl7rY1To4+zTg==
Content-Type: multipart/mixed; boundary="===============5587475080051462124=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <6d52649fa67e5fe668d18486a26d876020a5db065ac25f20a1033a0f1ae6d9de@mail.kernel.org>
In-Reply-To: <20260903214758.2727663-6-memxor@gmail.com>
References: <20260903214758.2727663-6-memxor@gmail.com>
Subject: Re: [PATCH bpf v1 5/8] bpf: Mark faultable stack helpers as sleepable
From: bot+bpf-ci@kernel.org
To: memxor@gmail.com,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,emil@etsalapatis.com,npc@anthropic.com,kkd@meta.com,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Thu,  3 Sep 2026 22:56:14 +0000 (UTC)

--===============5587475080051462124==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
> index a839041e0d008..d09d4c3fe547c 100644
> --- a/kernel/bpf/stackmap.c
> +++ b/kernel/bpf/stackmap.c
> @@ -875,6 +875,7 @@ BPF_CALL_4(bpf_get_stack_sleepable, struct pt_regs *, regs, void *, buf, u32, si
>  const struct bpf_func_proto bpf_get_stack_sleepable_proto = {
>  	.func		= bpf_get_stack_sleepable,
>  	.gpl_only	= true,
> +	.might_sleep	= true,
>  	.ret_type	= RET_INTEGER,
>  	.arg1_type	= ARG_PTR_TO_CTX,
>  	.arg2_type	= ARG_PTR_TO_UNINIT_MEM,

Does the unconditional .might_sleep marking reject too much? The faultable
path only sleeps when BPF_F_USER_BUILD_ID is requested. Looking at
__bpf_get_stack() in kernel/bpf/stackmap.c, the may_fault=true argument
flows to callchain_finalize():

    if (user_build_id)
            stack_map_get_build_id_offset(buf, trace_nr, user, may_fault);

and stack_map_get_build_id_offset() only takes the blocking path when
may_fault && has_user_ctx. With flags that do not contain BPF_F_USER_BUILD_ID,
user_build_id is false and no sleeping callee (build_id_parse_file()) is
reached; everything else already runs under preempt_disable().

Because prototype selection is per-program (kprobe_prog_func_proto() in
kernel/trace/bpf_trace.c and bpf_base_func_proto() in kernel/bpf/helpers.c,
both keyed only on prog->sleepable), the new flag rejects every call from
a non-sleepable region of a sleepable program, including calls that provably
cannot sleep.

This previously-accepted program is now rejected:

    SEC("uprobe.s/...")
    int prog(struct pt_regs *ctx) {
            bpf_rcu_read_lock();
            ...
            bpf_get_stack(ctx, buf, sizeof(buf), BPF_F_USER_STACK);
            bpf_rcu_read_unlock();
    }

The verifier sets state->in_sleepable = prog->sleepable, bpf_rcu_read_lock()
raises active_rcu_locks, so in_sleepable_context() (kernel/bpf/verifier.c)
returns false and the load fails with "sleepable helper bpf_get_stack#... in
rcu_read_lock region".

The follow-up selftest commit f73872d1b9dba confirms these programs loaded
before the change ("Both programs load when the prototypes lack might_sleep").

The diagnostic advice emitted ("Move the helper call outside the critical
section, or use a non-sleepable helper") is also not actionable for the
second half: once prog->sleepable is set there is no way for a program to
reach bpf_get_stack_proto / bpf_get_task_stack_proto, so "use a
non-sleepable helper" has no corresponding UAPI.

The tightening itself is correct and intended, and workarounds exist (hoist
the call, or bpf_task_acquire() the task before leaving the RCU section),
so this is a scope observation rather than a memory-safety defect.

Note that the tree already has a narrower mechanism for exactly this
situation: insn_aux_data[insn_idx].non_sleepable (set for helpers in
kernel/bpf/verifier.c) is used to swap bpf_dynptr_from_file /
bpf_arena_alloc_pages / bpf_arena_free_pages for non-sleepable
implementations at the offending call site instead of rejecting the program.
That consumer only exists for kfuncs today; if the intent is that helper
call sites cannot be downgraded the same way, the changelog would be a good
place to say so, and to state explicitly that calls without
BPF_F_USER_BUILD_ID are rejected too.

> @@ -928,6 +929,7 @@ BPF_CALL_4(bpf_get_task_stack_sleepable, struct task_struct *, task, void *, buf
>  const struct bpf_func_proto bpf_get_task_stack_sleepable_proto = {
>  	.func		= bpf_get_task_stack_sleepable,
>  	.gpl_only	= false,
> +	.might_sleep	= true,
>  	.ret_type	= RET_INTEGER,
>  	.arg1_type	= ARG_PTR_TO_BTF_ID,
>  	.arg1_btf_id	= &btf_tracing_ids[BTF_TRACING_TYPE_TASK],

The same concern applies here: bpf_get_task_stack() in a sleepable program's
RCU section or timer callback now rejects unconditionally, even when the
call cannot reach build_id_parse_file().


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/33811770362
--===============5587475080051462124==--
