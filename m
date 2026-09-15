Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D0D03B42F6;
	Tue, 15 Sep 2026 13:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789478961; cv=none; b=Uqb5iW5/hbApoTXjILjdOkcV3VY3O5UCIwPDtmiNC7r5W0bATKX1o+VTZazMG4qyoLPcovFoaQZB8Ag0ezz6vQasi3xopChlpcZWI9KqOlH2zV+cz9rye3H15VlH1jDD494JhMEgnfa6jTX8YMm55EebpDwqbXMgmnUzc8t8RWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789478961; c=relaxed/simple;
	bh=icB4PsDqXVr0bQ0YzhQY7U+ADYrkGT67ZLU7vn+DbVY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=cxDDvohW3q93ON+XZt41FkQc0+snD5X0nQ7e04BVdwa1BNvcBewybHZm8neaZz8d5AG5NTy2TdBvWqDeRXc2aZmWEHET7Nh4IPyBkmXIOvlZfIUx1eS8BXvdRK9j/hHRhZC66V/X+4ehrfU/d4Y5WFXFQYLeBw04XGccxsFdFFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lnoFFEpb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lnoFFEpb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E868D1F000FF;
	Tue, 15 Sep 2026 13:29:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789478960;
	bh=NVEVSJtUz3xVFwa8+s4VpdC5eHoOE0R2vmOYq10iegc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lnoFFEpb2qrZtRBFWcJpu0Ewaic3x9AUtPvoJvMLhMb7BaPLJOVUMSTKEOzj3xI9S
	 hC5I2o+1Ku8a6HRosxmrpN9Betz78Xk1/xD4IXU66z18Xa91No8TzO/rlnvw1pH9NI
	 xkl9lwzHHbaQnQOUvScqNiH3eNtGOt5hA3j/Ey+qlbUYYQDEA6Zh6dJBulza3pNzge
	 vUp32TN6eGa4gJNay4EzmoUUhLaSfP8vTv/YftOj/hB5tH0m5u5S4RousHrnUTOJtu
	 APkju2RTRIFqPAncJWglMzyI69OXDgcLEUHJEPvk2M5uo60Os8WeQJeu9Uqn8B6jFo
	 56LPGbKQDn+Dw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v3 03/13] rcu-tasks: Add a Tasks RCU implementation
 for reader-marked trampolines
Reply-To: sashiko-reviews@lists.linux.dev
To: "Josef Bacik" <josef@toxicpanda.com>
Cc: bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org
In-Reply-To: <20260915-b4-rcu-tasks-preempt-qs-v3-3-0ad30c4c5ee7@toxicpanda.com>
References: <20260915-b4-rcu-tasks-preempt-qs-v3-0-0ad30c4c5ee7@toxicpanda.com>
 <20260915-b4-rcu-tasks-preempt-qs-v3-3-0ad30c4c5ee7@toxicpanda.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 13:29:19 +0000
Message-Id: <20260915132919.E868D1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] rcu-tasks: Use-after-free in trampolines executed by the idle task
--

commit 4dc15eb660eecbf1c68e4f2d97dcdde7b8456c35
Author: Josef Bacik <josef@toxicpanda.com>

    rcu-tasks: Add a Tasks RCU implementation for reader-marked trampolines

    Tasks RCU waits for every task to pass through a voluntary context swit=
ch,
    usermode or idle, because a preempted task might be sitting in a trampo=
line
    that is about to be freed and nothing marks it as such. This adds a new
    Tasks RCU implementation for architectures that make their trampolines =
Tasks
    Trace RCU readers.

> diff --git a/kernel/entry/common.c b/kernel/entry/common.c
> index e4acd50bd81a1..94318519998c8 100644
> --- a/kernel/entry/common.c
> +++ b/kernel/entry/common.c
> @@ -141,8 +142,13 @@ void raw_irqentry_exit_cond_resched(struct pt_regs *=
regs)
>  		rcu_irq_exit_check_preempt();
>  		if (IS_ENABLED(CONFIG_DEBUG_ENTRY))
>  			WARN_ON_ONCE(!on_thread_stack());
> -		if (need_resched() && arch_irqentry_exit_need_resched())
> +		if (need_resched() && arch_irqentry_exit_need_resched()) {
> +			if (IS_ENABLED(CONFIG_TASKS_RCU_TRAMPOLINE_READERS))
> +				rcu_tasks_irq_resched_enter(instruction_pointer(regs));

[Severity: High]
Does this logic leave the idle task off the holdout list if it is
interrupted while executing trampoline text?

If an IRQ interrupts the idle task (for example, while executing a traced
function before entering an RCU extended quiescent state) and enters the
trampoline's unmarked preamble, but does not wake any new tasks,
need_resched() will be false.

Because need_resched() is false, raw_irqentry_exit_cond_resched() will not
call rcu_tasks_irq_resched_enter(), meaning the idle task is never added to
the holdout list.

>  			preempt_schedule_irq();
> +			if (IS_ENABLED(CONFIG_TASKS_RCU_TRAMPOLINE_READERS))
> +				rcu_tasks_irq_resched_exit();
> +		}
>  	}
>  }

[ ... ]

> diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
> index 627295396cd91..3a7c092361a66 100644
> --- a/kernel/rcu/tasks.h
> +++ b/kernel/rcu/tasks.h

[ ... ]

> +/* Has @cpu passed a quiescent event since the snapshot, or need it not?=
 */
> +static bool rcu_tasks_cpu_quiescent(int cpu)
> +{
> +	if (!cpu_online(cpu))
> +		return true;
> +	/* Pairs with the release in rcu_tasks_qs_event(). */
> +	if (smp_load_acquire(per_cpu_ptr(&rcu_tasks_qs_seq, cpu)) !=3D
> +	    per_cpu(rcu_tasks_qs_snap, cpu))
> +		return true;
> +	/*
> +	 * Idle or nohz_full userspace (an RCU extended quiescent state): no
> +	 * task-level kernel frames there, and whatever ran before has switched
> +	 * out.  As with the classic flavor, the idle task itself is not waited
> +	 * for.
> +	 */
> +	if (!(ct_rcu_watching_cpu(cpu) & CT_RCU_WATCHING))
> +		return true;
> +	return idle_cpu(cpu);
> +}

[Severity: High]
Could the unconditional return of idle_cpu() lead to a use-after-free crash
if the idle task was interrupted in trampoline code?

Since the idle task wasn't added to the holdout list during IRQ exit
(because need_resched() was false in raw_irqentry_exit_cond_resched()), the
grace period thread relies entirely on rcu_tasks_cpu_quiescent().

Because idle_cpu(cpu) returns true, the QS sequence check for the idle task
is bypassed. The GP thread will assume the CPU has passed a quiescent state,
complete the grace period, and free the trampoline memory.

When the IRQ returns, the idle task will resume execution in the now-freed
trampoline memory, which can lead to a kernel panic.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260915-b4-rcu-tas=
ks-preempt-qs-v3-0-0ad30c4c5ee7@toxicpanda.com?part=3D3
