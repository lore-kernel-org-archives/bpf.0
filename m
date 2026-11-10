Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794286253;
	b=pSOeuTUpW4t/IRr/1gLghWy33b00jbOWY7yDco+muToxMTodr/SH0kKUuLmqh2/7/nGz
	 gfsHjwBwOufd8d1VsRfKjsMowv6QbK/J+yJKzdij2JW8xhJUTHsHl2Tx3yw6Sr+jX3EqY
	 cJ8eVRKn3xc9wOLgRNZg6O+DBgeZ+OcnQcbqRokM8YwnJUqF/hVA+sg8UO0jNt7OOenae
	 ts2CzVYRHSVRSUcN3VQhoTybALyuU2UobnZWhII6vlV2za63exQ+h2rBA/oWA/ZAaF6A3
	 OG43jObFz+5IAIru8TmfJ4aobm04l8IDqqtF9jCBWw6XzVIFvzDJFT1SvTqWVU76evA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794286253;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=UgNRBrRCQe+VePUdxzgMsf5ecxJa1o/Krddmi+w8YnA=;
	b=TW2E4SPHnuNxkoDQj8fnugTqXZzDMU1ewOqZ3z9rLFmZxd/mb7mR0BuJ6OJ5B3BKnvFg
	 uNMbMkJpVmYQSs1tSvW1UwijrTIYiYuqK9vRkMeTgO1wytWU9gE9ZWbo/M23JYrDkaIVE
	 pqQ+S4vQVOJvkOx6oSLG1sUzpEY9ZP2CVlxppbscPltPBZuno+RPDvZXkrKjEnM0w+Ry5
	 LBy47VptZRBV3lqLDUnM4ZUiMyN4LNI6FsKW5f7z08Ygj5hN2tKiPHZLyDUfklhHwGSfm
	 vGc2BH/tEQ7JkKtXo6Z/nc390se72cE/r7BiclQtb8SdiT5uTzXk0EdcL+07pUKpNtQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OkMAehUk;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F05D606A330
	for <bpf@vger.kernel.org>; Tue, 10 Nov 2026 04:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OkMAehUk
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10CA11F0089F;
	Tue, 10 Nov 2026 04:50:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794286253;
	bh=UgNRBrRCQe+VePUdxzgMsf5ecxJa1o/Krddmi+w8YnA=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=OkMAehUk2EdXi1irgvSTjwn4bMsDHxaLMCASZx5XJ0WgvCUJ5SomLqyT2sJcmmyBX
	 iqqdl+NtjDDcrriNvOjSQVDgHRMkwoHNXCicz+JLpHt4r2TrfvdjhRZnR/ck8xqfD9
	 hc2LFssxv/n6xDhgzNkh2epCot7xnA3Lh9capschIEtmVHcc+OoH0I73+EtZ3awGm9
	 0V2rZCmGPFTkaQ/0muR1LaFTS2gV+p4iMif0uFAj1tdyChK07eWK36OfIHKqDsiuW0
	 VHDaWIiv5yRcol/M5YTsRGfSjD4Gger73j74mxcvlKNc4qNAl0+3J457shi1OTCvJH
	 oC9wCdyhY4hHQ==
Content-Type: multipart/mixed; boundary="===============4085456377274220913=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <2837df19d3c1760b7a3f8c5d1e2c65ecef887ce5cac5644ddd9f771b120c7b49@mail.kernel.org>
In-Reply-To: <d3069dd53406ddc20ca68dc1a1904ee9b73c52b3.1794269506.git.memxor@gmail.com>
References: <d3069dd53406ddc20ca68dc1a1904ee9b73c52b3.1794269506.git.memxor@gmail.com>
Subject: Re: [PATCH bpf-next v1 09/20] bpf: Register bpf_task_wake() for all program types
From: bot+bpf-ci@kernel.org
To: memxor@gmail.com,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,emil@etsalapatis.com,ihor.solodrai@linux.dev,tj@kernel.org,shakeel.butt@linux.dev,kkd@meta.com,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Tue, 10 Nov 2026 04:50:53 +0000 (UTC)

--===============4085456377274220913==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Register bpf_task_wake() for all program types

TL;DR: Registering bpf_task_wake() for all program types may let an
fentry/kprobe program on try_to_wake_up re-raise the deferred irq_work wake
endlessly, possibly starving the CPU and tick.

> diff --git a/kernel/bpf/task_park.c b/kernel/bpf/task_park.c
> --- a/kernel/bpf/task_park.c
> +++ b/kernel/bpf/task_park.c

[ ... ]

> +/*
> + * The park stays with syscall programs, whose runner holds the program across
> + * the sleep. The wake touches only the task and defers itself where it cannot
> + * be issued, so every program type has it, to wake a parked task from the
> + * kernel event that makes it worth waking.
> + */
>  static int __init bpf_task_park_kfunc_init(void)
>  {
> -	return register_btf_kfunc_id_set(BPF_PROG_TYPE_SYSCALL, &bpf_task_park_kfunc_set);
> +	int ret;
> +
> +	ret = register_btf_kfunc_id_set(BPF_PROG_TYPE_SYSCALL, &bpf_task_park_kfunc_set);
> +	return ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_UNSPEC, &bpf_task_wake_kfunc_set);
>  }

Can a tracing program attached to the wake path make the deferred wake
re-raise itself indefinitely?

The irq_work drain releases the task's node before it issues the wake:

    static void bpf_task_wake_deferred(struct irq_work *work)
    {
        ...
            /* The task may be queued again from here on. */
            WRITE_ONCE(task->bpf_wake_node.next, NULL);
            wake_up_state(task, TASK_INTERRUPTIBLE);
            put_task_struct(task);

wake_up_state() calls try_to_wake_up(), and neither is in btf_id_deny, so
an fentry or kprobe program can attach to them.  Such a program runs
again inside the drain.  Its recursion guards (prog->active for fentry and
raw_tp, bpf_prog_active for kprobe) are zero at that point, because the
run that queued the wake returned earlier.

The drain runs in hard irq_work with IRQs disabled, so the program's
bpf_task_wake() takes the deferred path again:

    xchg(&task->bpf_wake_pending, 1);
    if (unlikely(irqs_disabled())) {
        bpf_task_wake_defer(task);

The cmpxchg_relaxed(&node->next, NULL, WAKE_Q_TAIL) claim succeeds because
the drain just reset the node, and irq_work_queue() succeeds because
irq_work_single() cleared IRQ_WORK_PENDING before calling the callback.
llist_add() then returns true and irq_work_raise() sends another self-IPI.
This happens on every run, since wake_up_state() is called even when the
task is already running.

For example, SEC("fentry/try_to_wake_up") calling
bpf_task_wake(bpf_get_current_task_btf(), 0), or a waiter kptr read under
RCU, would behave this way.  Once the first try_to_wake_up() with IRQs
disabled queues the work (hrtimer_wakeup() from hardirq, say), each drain
calls try_to_wake_up(), re-runs the program and re-raises the IPI.  Can
that starve the interrupted context and the tick on the CPU?
tp_btf/irq_work_exit looks like it could drive the same loop.

The other irq_work-deferring helpers appear to bound this.
do_bpf_send_signal() releases work->task only after group_send_sig_info(),
so a re-entered program gets -EBUSY.

The commit message and the new comment say the wake "defers itself where
it cannot be issued, so every program type has it".  Does that account for
the deferred wake re-entering programs attached to the wake path?

No later commit in the series changes the wake or the drain.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/42755601621
--===============4085456377274220913==--
