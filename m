Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793607270;
	b=peXb7ky64sYsV54kXHRh2WWyHZt5vx+h45Q4KwesbtrIV5qdMw5EocCaBbo8/sjz4QmY
	 Y+c6hw5ZJhsYqZ3fYHH8OLBBvMJPYz6qytlPpaj7AE596NRBEIisVNC9nzNBI5JSR1LVg
	 fuDcZJQa4yyxVkFOUVpLcpdhPnSQdyu9769KTDfNqjNDiuKq2uQoBxhBASso7OUDf7mTP
	 ilITs9/D8ZAbWe24iJb/cWWWqvL3E/lR915ZviLxYayM3AbKdsyzFKKd3j95HQ6aMI7w7
	 D0aVoU5/RtxJsWnh1TtwRBelv86SImT16TAdcf8ATpYPzIPNmItPYnwhhypdSPH41/A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793607270;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=7PkmO9E34XxgGmqqHlDqmaQi7tYcgKQvhGHds/lDuHw=;
	b=jIu2DCU9alqRxRU9TApHbROXKggDpGsviMgkPYLf7G0SsBV7H3fO2kfZxeBVJqeqelQc
	 I5MIERjucGm3yuE+W6VkTwCI1VLGrdhcTQrjEjU1NKRHLa9V2S19Ytgvw9GfnnuTiNAmp
	 8rQU3rVfaWjCnElOWNC8vOEtou4ljf4mXiT/WiJ6pYu6G/roIRS+Kgi1EDc0WWOEdRBAd
	 AcUtwF5qilpKw8yDitpL1e2chxspADla4CrUdkTWaSExwcrR5Z0ptmbAY742rLd7hSUII
	 lfRzg6jdA6ZYkacPzRWiUm5qHr+qvK+FeO4BS1ic+xEKs3iwNOX21XdWLuDPOZJxj8g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Kyv+Kegm;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8B24606A324;
	Mon,  2 Nov 2026 08:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Kyv+Kegm
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5CC51F000C1;
	Mon,  2 Nov 2026 08:14:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793607269;
	bh=7PkmO9E34XxgGmqqHlDqmaQi7tYcgKQvhGHds/lDuHw=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=Kyv+KegmEwkrYjNsBtVg/aMcQLzrp+vI3wBreAHBi+WCwd5alF2epD+StN7Wx8T4P
	 uKmmC7RvjI76aGmGqeWf463Sc3DxcXcoZ+2a3oesuYnlx1Z9A3HSRaJTNqwqnZyQlB
	 huxK7pMjONlpm+mgvGNBNQ5Y3TsRoVVD7I6mqKl+8Q8tJkMrRNlfV1zKKnbjn7YqiU
	 gCda/R+G6vObDr+wGt3g2x6hMSMHDI0dlbfXhnuGLNwN9cmmrhDbPWG2XBgUd1dO7J
	 i/XBmBu2ZGA4oYREMfmmpZFn5vMGbGrl32ZzSVJ8QRcSOA5txIt77zx3OC8sjhCAsX
	 gvhU/5vRPVkfw==
Content-Type: multipart/mixed; boundary="===============7351402555586448473=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <2bc16926af0fdbbc1063e023a8f2b750a6f415d40578dbd79717372b99324c53@mail.kernel.org>
In-Reply-To: <20261102073714.1103088-1-yangfeng59949@163.com>
References: <20261102073714.1103088-1-yangfeng59949@163.com>
Subject: Re: [PATCH v2 bpf-next] bpf: Fix suspicious RCU usage for sleepable bpf_get_stack()
From: bot+bpf-ci@kernel.org
To: yangfeng59949@163.com,song@kernel.org,jolsa@kernel.org,ihor.solodrai@linux.dev,kpsingh@kernel.org,matt@bobrowski.net,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,martin.lau@linux.dev,yonghong.song@linux.dev,emil@etsalapatis.com,rostedt@goodmis.org,mhiramat@kernel.org,mathieu.desnoyers@efficios.com
Cc: bpf@vger.kernel.org,linux-trace-kernel@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Mon,  2 Nov 2026 08:14:28 +0000 (UTC)

--===============7351402555586448473==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Fix suspicious RCU usage for sleepable bpf_get_stack()

TL;DR: Commit message only: it understates scope. Sleepable LSM and SYSCALL
programs also get the might_sleep bpf_get_stack(), so calls in
preempt/IRQ-disabled or lock regions are rejected too. Code matches existing
policy.

> bpf: Fix suspicious RCU usage for sleepable bpf_get_stack()
>
> Sleepable BPF programs run under rcu_read_lock_trace(), not classic RCU.
> bpf_get_stack() relies on the caller holding a classic RCU read lock:
> get_perf_callchain() -> get_callchain_entry() dereferences
> callchain_cpus_entries, and the returned entry is read until
> callchain_store().  __bpf_get_stack() takes that lock only for the
> sleepable variant, i.e. when may_fault is true.
>
> The sleepable variant was added by commit d4dd9775ec24 ("bpf: wire up
> sleepable bpf_get_stack() and bpf_get_task_stack() helpers") but only
> wired up for kprobe/uprobe.  All other program types that can be
> sleepable still get the non-sleepable variant:
>
>  - tracing_prog_func_proto() serves BPF_TRACE_ITER, fentry/fexit/fmod_ret
>    and BPF_TRACE_RAW_TP programs, and falls back to
>    raw_tp_prog_func_proto() for BPF_FUNC_get_stack, which always returns
>    bpf_get_stack_proto_raw_tp.  Sleepable iterators have been allowed
>    since commit cf83b2d2e2b6 ("bpf: Permit cond_resched for some
>    iterators"), e.g. for the task_file target.
>
>  - tp_prog_func_proto() serves BPF_PROG_TYPE_TRACEPOINT programs and
>    always returns bpf_get_stack_proto_tp.  Sleepable programs of that
>    type are allowed on syscall tracepoints since commit 8cfb77d30920
>    ("bpf: Verifier support for sleepable tracepoint programs"); they run
>    through trace_call_bpf_faultable() and bpf_prog_run_array_sleepable(),
>    which hold rcu_tasks_trace but no classic RCU read lock.
>
> So a sleepable program calling bpf_get_stack() triggers:
>
>   WARNING: suspicious RCU usage
>   suspicious rcu_dereference_check() usage!
>
> Route these paths to bpf_get_stack_sleepable() and mark the new protos
> might_sleep, since build_id_parse() may fault in file data for
> BPF_F_USER_STACK | BPF_F_USER_BUILD_ID.  Sleepable programs that call
> bpf_get_stack() from inside a bpf_rcu_read_lock() region are now rejected
> by the verifier, which is the correct behavior for a helper that can
> sleep.
>
> Reported-by: Kaiyan Mei <M202472210@hust.edu.cn>
> Reported-by: Yinhao Hu <dddddd@hust.edu.cn>
> Closes: https://lore.kernel.org/all/41ce77bf.17656.1a17b3fcb04.Coremail.kaiyanm@hust.edu.cn/
> Signed-off-by: Feng Yang <yangfeng@kylinos.cn>

The commit message lists tracing_prog_func_proto() (iterators,
fentry/fexit/fmod_ret, BPF_TRACE_RAW_TP) and BPF_PROG_TYPE_TRACEPOINT as the
affected paths, and says only that calls from inside a bpf_rcu_read_lock()
region are now rejected.  Is that the full scope of the behaviour change?

The raw_tp_prog_func_proto() change reaches more program types than that:

  - BPF_PROG_TYPE_RAW_TRACEPOINT uses it directly, via
    raw_tracepoint_verifier_ops.get_func_proto.

  - BPF_PROG_TYPE_LSM reaches it through the default case of
    bpf_lsm_func_proto() -> tracing_prog_func_proto().

  - BPF_PROG_TYPE_SYSCALL, which is always sleepable, reaches it through the
    default case of syscall_prog_func_proto() -> tracing_prog_func_proto().

For each of these, a sleepable program's BPF_FUNC_get_stack now resolves to
bpf_get_stack_proto_raw_tp_sleepable, which has .might_sleep = true.
check_helper_call() will then reject the call wherever in_sleepable_context()
is false:

  sleepable helper bpf_get_stack#67 in rcu_read_lock region

or the equivalent non-preemptible, IRQ-disabled or lock region variants.
Before the patch these programs loaded and ran, since the old helper never
slept.

The code change itself matches the policy already applied to uprobe programs
and bpf_get_task_stack() by commit 9d02927fdf4e ("bpf: Mark faultable stack
helpers as sleepable"), so only the description of the user-visible scope
looks incomplete.

Could the commit message mention that sleepable LSM and BPF_PROG_TYPE_SYSCALL
programs are affected as well, and that calls from preempt-disabled,
IRQ-disabled and lock-held regions are rejected too, not only calls inside a
bpf_rcu_read_lock() region?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/41409077371
--===============7351402555586448473==--
