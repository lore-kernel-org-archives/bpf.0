Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29AED2472AE;
	Tue, 29 Sep 2026 17:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790703334; cv=none; b=D6edZMSBHdB1Dk2/5DqwOmkYmLdI7nhQJEnl9BpGfNWv+UAnfYEoijMaH8yPElZXszIM08zsxC7hqe6C7PobBPFp862zKIY4UaA9USV0PVgq4dzCfcxSocP6SxIrsc6On7j7rwqY7TXu1KHTuH0tbDerv8R3HUgE19adbSZ7aM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790703334; c=relaxed/simple;
	bh=LCCm9TdD7IBpMpqOchJaXCd9YzFtxv7n5q7b3Wdv45I=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=JAjL4KLuBaBp+4aDcN7RmsTuLb2OLi7KxcHfHwPrTvsavuN4mmO+2xEm6oCa6gwN/WYcfhihYWcE2LHIO4bwHzxgcgWtr3e/hyXzFnljx8l1/+vKS64I/CYLfvKu27GwDrPu70TkZSyCKoDS+bWpa+px9zc/jyuG5U17WCOz5ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=igg0NQDl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="igg0NQDl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C88191F000FF;
	Tue, 29 Sep 2026 17:35:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790703333;
	bh=8ox1yIKsjgmd67Nn+OV3krulVc0mUnkNPEk6FpSCLz0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=igg0NQDl78pWIdxhYnxRMV7yeLp3/ykbhXkTJ5x17Bop5KRppAChpQW6wRO2vrRD7
	 SzvWxKO8SZ7RxlUinYScpY6jtbFHnZY4LLLakRNR2wwLulceH588QRo3QFaHb30hrN
	 Nr0MwtQ1AaTuPLCJvoG/xHHuJHDzyuu/Vu1t2zRFsRK4kcUQLhHm1fofgHKK4yVGac
	 WTuJGfPiY0JMpXH76MN9+PvCem4BhLtm1SsyXKrYjF9Rb0jiWFw4ovh6iQusvO4sOF
	 jADJ6y6BV0lKQF2ICundI7aDndU31zvSJMQW8tjP7tAvsLrSRK0vZfOM711BibM8I0
	 KzhnkjCdI5y5A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 03/14] rcu-tasks: Add a Tasks RCU implementation for
 reader-marked trampolines
Reply-To: sashiko-reviews@lists.linux.dev
To: "Josef Bacik" <josef@toxicpanda.com>
Cc: bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org
In-Reply-To: <20260929-b4-rcu-tasks-preempt-qs-v6-3-c111ee02caca@toxicpanda.com>
References: <20260929-b4-rcu-tasks-preempt-qs-v6-0-c111ee02caca@toxicpanda.com>
 <20260929-b4-rcu-tasks-preempt-qs-v6-3-c111ee02caca@toxicpanda.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 29 Sep 2026 17:35:32 +0000
Message-Id: <20260929173532.C88191F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] rcu-tasks: Use-After-Free if task oopses inside irq-exit preempt=
ion
--

commit 6894dfa1f4c077dbeacd53dcfc82e1697f747465
Author: Josef Bacik <josef@toxicpanda.com>

rcu-tasks: Add a Tasks RCU implementation for reader-marked trampolines

This commit introduces a new Tasks RCU implementation for architectures
where trampolines are marked as Tasks Trace RCU readers. It tracks context
switches and preemptions during irq exits to wait for tasks that might
be lingering in unmarked trampoline text.

> diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
> index 627295396cd91..e7498601c28c3 100644
> --- a/kernel/rcu/tasks.h
> +++ b/kernel/rcu/tasks.h
[ ... ]
> +static void rcu_tasks_tramp_hold(struct task_struct *t)
> +{
> +	unsigned long flags;
> +
> +	if (t->rcu_tasks_holdout)
> +		return;
> +	raw_spin_lock_irqsave(&rcu_tasks_tramp_lock, flags);
> +	list_add_tail(&t->rcu_tasks_holdout_list, &rcu_tasks_tramp_holdouts);
> +	WRITE_ONCE(t->rcu_tasks_holdout, true);
> +	raw_spin_unlock_irqrestore(&rcu_tasks_tramp_lock, flags);
> +}

[Severity: Medium]
Does this code risk a use-after-free of the task struct?

It appears that the task is added to the holdout list without incrementing =
its
reference count (e.g., unlike the classic flavor which deliberately calls
get_task_struct()).

If a task is preempted inside unmarked trampoline text,
rcu_tasks_irq_resched_enter() adds it to rcu_tasks_tramp_holdouts. If the t=
ask
subsequently suffers a hardware exception or kernel oops while executing
preempt_schedule_irq(), it will be killed via make_task_dead() and do_exit(=
).
Because rcu_tasks_irq_resched_exit() would never be reached to clear
t->rcu_tasks_irq_ip, rcu_tasks_note_qs() skips removing it from the holdout
list, leaving a dangling pointer when the task is later freed.

[ ... ]
> +static void rcu_tasks_tramp_wait_holdouts(struct rcu_tasks *rtp, unsigne=
d long *lastreport)
> +{
> +	struct task_struct *t;
> +	unsigned long flags;
> +	int cpu;
> +
> +	raw_spin_lock_irqsave(&rcu_tasks_tramp_lock, flags);
> +	list_splice_tail_init(&rcu_tasks_tramp_holdouts, &rcu_tasks_gp_holdouts=
);
> +	raw_spin_unlock_irqrestore(&rcu_tasks_tramp_lock, flags);
> +
> +	for (;;) {
> +		struct cpumask *kick =3D &rcu_tasks_pending_cpus;
> +		struct task_struct *show[8];
> +		int nshow =3D 0, i;
> +		bool empty, report;
> +
> +		report =3D rcu_tasks_tramp_stall(rtp, lastreport,
> +					       "tasks preempted in trampoline text");
> +		cpumask_clear(kick);
> +		raw_spin_lock_irqsave(&rcu_tasks_tramp_lock, flags);
> +		empty =3D list_empty(&rcu_tasks_gp_holdouts);
> +		list_for_each_entry(t, &rcu_tasks_gp_holdouts, rcu_tasks_holdout_list)=
 {
> +			if (task_curr(t))
> +				__cpumask_set_cpu(task_cpu(t), kick);

[Severity: Medium]
If the scenario described above occurs and the task struct has been freed,
could we hit a use-after-free here when iterating over the holdout list and
accessing t?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260929-b4-rcu-tas=
ks-preempt-qs-v6-0-c111ee02caca@toxicpanda.com?part=3D3
