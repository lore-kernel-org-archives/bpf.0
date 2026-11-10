Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794273378;
	b=O+5ulOhDGRm4/zDOjXkeFrpWg8lu49+XIQkoYVkOuZ9Ll7UiSuseBCJjdFdRBOU/SFlf
	 e6Tj6PzHpI9FZMWbIwIehiOxzLsU/R5lnKbd5E09mTKsLMWghCdrrsmXFvWmYmZtQbEBQ
	 7xviYQ+nplekerYF7TYFac4gBUwPlMUa4DbwrljV60g6mZ5U/WeZw9CvoNIqJc54HNBhP
	 N2meJt9GstEh0njcbvy+y/t1+u8M9FJ8LrhhZd3EKBUeKL7KCL4tdpFcScvfFJybYPxJg
	 L9NOnwCnH6NSCqq4VJPnD35rKgQawchoQIXRr5qsxEFCQoKlKSy27rPCY5CuVnJwQ1w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794273378;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=nk2H0sTeVCeJn88xbMQe5jlnEfnpG6MpNTMY1HNwOJg=;
	b=npWnU4ipF7aKYz9g1F4G0GnSrxbLDFSNJrbLA9oAwnMfCHPm9JwhmqNqaF9/OQr7CyZE
	 XoeLiV3yrm4EbfzFgzNWfZmpHsy/cZipYdXZv2sgUvaMIcRh/ePQCq96DHVUOmAFHTm8k
	 wrzDebgk8gewFGEf0VivSfESSRbOLH0UaIzMA89IZnRN7n4iXih14IqC4l5tOYJHAw7q7
	 1Ejp6GfpoAaNPR+nazLi5X0cXfzNfY9a7jZmYiE3lHwKCmBOGQmZH21eYoB/KrQWFaMZ2
	 3WLk8+RMR+N27+bgZa4o92NZCG3VNcWMC39l0A2IacEyaPJT+j5KMp5gWAxs42oz/6Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="DvcMx7T/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00803606A33D
	for <bpf@vger.kernel.org>; Tue, 10 Nov 2026 01:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DvcMx7T/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B37761F008A1;
	Tue, 10 Nov 2026 01:16:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794273377;
	bh=nk2H0sTeVCeJn88xbMQe5jlnEfnpG6MpNTMY1HNwOJg=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=DvcMx7T/jpFXOTw2qYNniPimyqEFIzW6jvaDBaienTEu46JRaUUG83cif0wMus23k
	 FPoWzA+vEAos3Bu0g5XIFhp9H8E6occFexsSaIRA/eI0kNYw976x6hQxkvim66YMEJ
	 8/Yt5gASEo4lVaVXgBNQv95S6Mymu+9E/1Tq+xnp/IZI+jFT21cEcXEM2TF4IpFsvl
	 RKyPiZ3wXPA4cmsKQd6VlRpkdt+ZyeQ/h5n/JWWh1IzKO/kWCVdbd54hW0bj1avD9g
	 v8cgEtBjGC012xBdZoGkTWOv9VpuBvGNkxb0nmFlP91GFX99EgsxnPq8dCjQs3/92C
	 tBof0fYTqWopA==
Message-ID: <sashiko-outbox-205948@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v1 06/20] bpf: Defer bpf_task_wake() to
 irq_work when IRQs are disabled
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>, bpf@vger.kernel.org
In-Reply-To: <e405280f8db39c5e378b6c42077c8b8f1f2c6d0d.1794269506.git.memxor@gmail.com>
References: <cover.1794269506.git.memxor@gmail.com>
 <e405280f8db39c5e378b6c42077c8b8f1f2c6d0d.1794269506.git.memxor@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 01:16:14 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [High] bpf: use-after-free in bpf_task_wake_defer() pinning
  task->usage
- [Medium] bpf: undrained per-CPU wake queue in bpf_task_wake_defer() on
  dying CPU
--

commit 35b974753f83ac79811d129b40ee5a3e768f027c
Author: Kumar Kartikeya Dwivedi <memxor@gmail.com>

bpf: Defer bpf_task_wake() to irq_work when IRQs are disabled

This commit defers bpf_task_wake() calls made with IRQs disabled to a
per-CPU hard irq_work queue using a per-task bpf_wake_node list node.

> diff --git a/kernel/bpf/task_park.c b/kernel/bpf/task_park.c
> index 39c9f085f7a97..5a9b3124312ee 100644
> --- a/kernel/bpf/task_park.c
> +++ b/kernel/bpf/task_park.c
[ ... ]
> +static DEFINE_PER_CPU(struct wake_q_node *, bpf_task_wake_queue);
> +
> +static void bpf_task_wake_deferred(struct irq_work *work)
> +{
> +	struct wake_q_node *node =3D xchg(this_cpu_ptr(&bpf_task_wake_queue), N=
ULL);
> +
> +	while (node) {
> +		struct task_struct *task =3D container_of(node, struct task_struct, bp=
f_wake_node);
> +
> +		node =3D node->next =3D=3D WAKE_Q_TAIL ? NULL : node->next;
> +		/* The task may be queued again from here on. */
> +		WRITE_ONCE(task->bpf_wake_node.next, NULL);
> +		wake_up_state(task, TASK_INTERRUPTIBLE);
> +		put_task_struct(task);
> +	}
> +}
> +
> +static DEFINE_PER_CPU(struct irq_work, bpf_task_wake_work) =3D
> +	IRQ_WORK_INIT_HARD(bpf_task_wake_deferred);
> +
> +static void bpf_task_wake_defer(struct task_struct *task)
> +{
> +	struct wake_q_node *node =3D &task->bpf_wake_node, *head;
> +
> +	/*
> +	 * The claim, as in __wake_q_add(): NULL is free, anything else is
> +	 * queued. The xchg() that stored the pending word is a full barrier
> +	 * between that store and the claim, so a claim lost to another holder
> +	 * is still covered: the holder's wake follows its own reset of the
> +	 * node, which this claim did not observe, so the task it wakes
> +	 * observes the word.
> +	 */
> +	if (cmpxchg_relaxed(&node->next, NULL, WAKE_Q_TAIL))
> +		return;
> +	get_task_struct(task);

[Severity: High]
Can pinning task via get_task_struct() here cause a refcount addition on
zero and a use-after-free in bpf_task_wake_deferred()?

bpf_task_wake() is registered with KF_RCU, so a tracing or LSM program can
pass a task_struct whose usage count has already reached zero in
__put_task_struct():

__put_task_struct(tsk)
  security_task_free(tsk)
    <BPF program with IRQs disabled>
      bpf_task_wake(tsk, 0)
        bpf_task_wake_defer(tsk)
          get_task_struct(tsk)  <-- refcount_inc on 0
          irq_work_queue(...)
  free_task(tsk)
<irq_work>
  bpf_task_wake_deferred()
    WRITE_ONCE(tsk->bpf_wake_node.next, NULL)  <-- use-after-free
    wake_up_state(tsk, TASK_INTERRUPTIBLE)

A nascent task in copy_process() before rcu_users is initialized is also
freed by delayed_free_task() on fork failure without consulting
tsk->usage.  Pinning task with refcount_inc_not_zero(&task->rcu_users)
before claiming node->next (or releasing node->next on failure) and
dropping it with put_task_struct_rcu_user() in bpf_task_wake_deferred()
would avoid queuing tasks in either state.

> +	head =3D this_cpu_read(bpf_task_wake_queue);
> +	do {
> +		WRITE_ONCE(node->next, head ?: WAKE_Q_TAIL);
> +	} while (!try_cmpxchg(this_cpu_ptr(&bpf_task_wake_queue), &head, node));
> +	irq_work_queue(this_cpu_ptr(&bpf_task_wake_work));
> +}

[Severity: Medium]
Can a wakeup queued on an outgoing CPU after CPUHP_AP_SMPCFD_DYING stay
undrained while the CPU is offline?

During CPU hotplug teardown, __cpu_disable() disables local IPI delivery
and smpcfd_dying_cpu() runs irq_work_run() at CPUHP_AP_SMPCFD_DYING.
After that callback finishes, the migration stopper thread still parks on
the outgoing CPU and fires trace_sched_waking and trace_sched_switch with
IRQs disabled.  If a BPF program attached there calls bpf_task_wake(),
bpf_task_wake_defer() queues task onto the outgoing CPU's
bpf_task_wake_queue and raised_list, which smpcfd_dead_cpu() ->
irq_work_run_cpu() does not drain because it only flushes lazy_list.

The wakeup is lost and task->bpf_wake_node.next remains non-NULL while the
CPU stays offline, causing subsequent deferred bpf_task_wake() calls for
that task on online CPUs to fail the cmpxchg_relaxed() claim as well.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1794269506.gi=
t.memxor@gmail.com?part=3D6
