Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C412813A258;
	Fri, 18 Sep 2026 15:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789744233; cv=none; b=YyWh0v0e/HDvAqjH+GLke5KK1BVb9wZMk32yWr+v/vnbt3/KPFoq5zxTBc7bCHA8yf6cHlHkPWsaUiJC2ZSWaESyHh7FralqUyLJCVajWch+xM0k4MQq5aED9FAeLeOAww38oYfqXwSvLJjCHPkEqGXe/ZV4n4yJ2ZAr4hwRMao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789744233; c=relaxed/simple;
	bh=x9nI8krNjaf1CacRJy8wh0+FceJVMFXjZNMyCjkWp0M=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=cEYqGH+PWiPKTLWdSCUvoTym4gqQY4eOL/4X6LhkF227POY/SuNlRD9PPSbp5nMtLhbaGRdFaSIA+RDL3u88wVw37NVUMRsS8MZLMuqlZH2WJyo7/7kW56u0te1cgp/tR6tOSqCdqrXppE2YjWISrBFBZ1ANB6CVap0db5QPz0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bVE3NKJ3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bVE3NKJ3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E0941F000FF;
	Fri, 18 Sep 2026 15:10:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789744231;
	bh=85SXaRwWcLRL0l9RndOEuK+a4aiLbRSz4zPmmbl/uU8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bVE3NKJ3+tZPF2drH5S0lC/1xDa3kXSu4SK5G3B+/5rOI0oDtnxfCab7o+wdBhK6l
	 VSQZ6+C/o4c7O3vn7ty+CgvFhnISZvB1Y2TFSepHwxiih2jj9g7DqUEIFSp0IPz/HV
	 0ckfw1XVUoV9kN4Zmzw1vYbUlmd4ZtK9kTwIIqRYu4Xn0BgYBkW1yvPLcptaIVPIKR
	 HGIN0ZqDAgu74TO+ltPIUKR+3jf1lSqVpqo5/CuP9PY5KAmT9wFHFzqDYFPPn5iMbk
	 GjhM/I2UF+AcA0PO2/prS3Rc2gDkhwGODVUk1VZMNBnZTTB0St6qVGkuNqTGKWgCIL
	 Udy1Ku0pvhUzg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v4 02/13] rcu-tasks: Add a Tasks RCU implementation
 for reader-marked trampolines
Reply-To: sashiko-reviews@lists.linux.dev
To: "Josef Bacik" <josef@toxicpanda.com>
Cc: bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org
In-Reply-To: <20260918-b4-rcu-tasks-preempt-qs-v4-2-63f0e9d69661@toxicpanda.com>
References: <20260918-b4-rcu-tasks-preempt-qs-v4-0-63f0e9d69661@toxicpanda.com>
 <20260918-b4-rcu-tasks-preempt-qs-v4-2-63f0e9d69661@toxicpanda.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 15:10:30 +0000
Message-Id: <20260918151031.2E0941F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Critical] rcu-tasks: NULL pointer dereference in rcu_tasks_irq_resched_e=
nter() during early boot
--

commit ea4914f1671c6b6ff32f3cbc1cd74fa6dd51744d
Author: Josef Bacik <josef@toxicpanda.com>

rcu-tasks: Add a Tasks RCU implementation for reader-marked trampolines

This commit introduces a Tasks RCU implementation for architectures that
make their trampolines Tasks Trace RCU readers. It hooks into the generic
irq entry code to track preemptions. The tracking utilizes a per-CPU list
for tasks preempted during irq exit.

> diff --git a/kernel/entry/common.c b/kernel/entry/common.c
> index e4acd50bd81a1..94318519998c8 100644
> --- a/kernel/entry/common.c
> +++ b/kernel/entry/common.c

[ ... ]

> @@ -141,8 +142,13 @@ void raw_irqentry_exit_cond_resched(struct pt_regs *=
regs)
>  		rcu_irq_exit_check_preempt();
>  		if (IS_ENABLED(CONFIG_DEBUG_ENTRY))
>  			WARN_ON_ONCE(!on_thread_stack());
> -		if (need_resched() && arch_irqentry_exit_need_resched())
> +		if (need_resched() && arch_irqentry_exit_need_resched()) {
> +			if (IS_ENABLED(CONFIG_TASKS_RCU_TRAMPOLINE_READERS))
> +				rcu_tasks_irq_resched_enter(instruction_pointer(regs));
>  			preempt_schedule_irq();
> +			if (IS_ENABLED(CONFIG_TASKS_RCU_TRAMPOLINE_READERS))
> +				rcu_tasks_irq_resched_exit();
> +		}
>  	}
>  }

> diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
> index 627295396cd91..f03be742be48c 100644
> --- a/kernel/rcu/tasks.h
> +++ b/kernel/rcu/tasks.h

[ ... ]

> +void rcu_tasks_irq_resched_enter(unsigned long ip)
> +{
> +	struct task_struct *t =3D current;
> +	struct rcu_tasks_percpu *rtpcp =3D this_cpu_ptr(rcu_tasks.rtpcpu);
> +
> +	lockdep_assert_irqs_disabled();
> +	WRITE_ONCE(t->rcu_tasks_irq_ip, ip);
> +	t->rcu_tasks_exit_cpu =3D smp_processor_id();
> +	raw_spin_lock_rcu_node(rtpcp);
> +	list_add(&t->rcu_tasks_exit_list, &rtpcp->rtp_exit_list);

[Severity: Critical]
Could this cause a null pointer dereference regression during early boot?

When the trampoline reader feature is selected,
raw_irqentry_exit_cond_resched() hooks into the generic irq exit path to
call rcu_tasks_irq_resched_enter(). During early boot, interrupts are
enabled via local_irq_enable() in start_kernel(), meaning preemptions can
begin occurring.

However, the per-cpu rtp_exit_list list head cannot be statically
initialized and is dynamically initialized via cblist_init_generic() from
a core_initcall. Since core_initcalls are executed much later by the
kernel_init thread, any preemption before that phase will attempt to
list_add() to a zero-initialized (null) rtp_exit_list.

Would this lead to a kernel panic when the list macros dereference the
uninitialized head pointer?

> +	raw_spin_unlock_rcu_node(rtpcp);
> +
> +	if (unlikely(rcu_tasks_trampoline_text(ip)))
> +		rcu_tasks_tramp_hold(t);
> +	else
> +		rcu_tasks_tramp_release(t);
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918-b4-rcu-tas=
ks-preempt-qs-v4-0-63f0e9d69661@toxicpanda.com?part=3D2
