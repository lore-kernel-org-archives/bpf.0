Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794286252;
	b=5ZGS/gWRWDiYRVPiZtxCLhAliVXP2jNW4aRH3Xa04XESfExnZJfa6CH8YTFhT3SQv4/j
	 kMwNtM8RK1cwisibFY3LGVkYP5RfDqMdpqJRzg0yvLtHYP27dBpktWY/HldfNYBTmPeWx
	 dCC1Qtn01M+uAW24ff04+v0BJ35tVzLWJfDroInizDn0CcnFdAwgh2vXNQcVZ2pxf7vPl
	 iZoZYZWh6nD1qV5p8A8gyGz4a9Nbzd7lNioOU/SaQtz5YFouA0nyf/6C6EDDR73CrIW1n
	 t5WoAzgIF277u4E2Ys5sxPNtvfQJMGiMhVk774I1pUBivNuKFW9tlaSuYHIHNnRxmlw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794286252;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=B85EC0L+pBFB579Ujhp3KXXlR2dbTL0zQHUKTiqNw98=;
	b=eJIdUfiqLxHwJwuocn0SX0vfAW/9juj5akdK2L4w1qput3aePGvhiwOVO4xZgmILBpMs
	 0p6OEjqBwUW0yMtBaw/zN2lRiJxZJF034fvidtHQL9Awwxs71x0FqyVoqDLOqeKcWp42h
	 lUCs+nl+afIcFzvh5xx4WDOHpQBupje95lvMEYpfFccJvyPYeXe+Ci9bAKIzw0lfJlwKS
	 /5xQSwSmSkNGODMilshgT0NVCkICYZPQHJ2hUq8Eq8EWm29vIRK+ULpcyHY14dvl/5n2X
	 sRbaDIi3tPy0Fr2K2Yy99jKDgExLVQPmS9/NDJ7wCQ5MC9Dto/a3Sy2ahxLhKSGbkBw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Azis7Wug;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D23F1606A31C
	for <bpf@vger.kernel.org>; Tue, 10 Nov 2026 04:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Azis7Wug
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5ABDE1F0089F;
	Tue, 10 Nov 2026 04:50:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794286251;
	bh=B85EC0L+pBFB579Ujhp3KXXlR2dbTL0zQHUKTiqNw98=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=Azis7WugshSOcDquU1+yxVm8nv2Kh+NE814fcYNKO7lRqz7KY1fK17skwaNkNy5GK
	 WKfzK0n8Y7OTtJuKy1qbTMEI0JkX4VSAy30o+/B0xGt2uUU0mih0AESFQI0vT5pUKX
	 x/zgp4E1PZ2lZsDSJBXzBctrCi9Zad90mrC2Nv21OqkwsmMlo/ELVGEKqooJdP31M/
	 JkqSloYOWOE+iIJTAjmOGBa95QBl2BQ/dzX4Mrbr45i+v2TE7sWbS6cSP/eeCtAWI9
	 xCYIwJigiBH02HVLcrbRXp1fiigyYofQ8vxgVKYrv9MnzZmQFkx0r91bZD0RBRjoMN
	 5wELjsK5YK+rw==
Content-Type: multipart/mixed; boundary="===============4998320395606795897=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <43c55f9f83154718dbe6bf05384c2da79c48f98ffa5bc405151013bd0d82d591@mail.kernel.org>
In-Reply-To: <32ccc244a112dffbd5ad415cc1b2a652eb344c24.1794269506.git.memxor@gmail.com>
References: <32ccc244a112dffbd5ad415cc1b2a652eb344c24.1794269506.git.memxor@gmail.com>
Subject: Re: [PATCH bpf-next v1 08/20] bpf: Register bpf_task_park() for syscall programs
From: bot+bpf-ci@kernel.org
To: memxor@gmail.com,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,emil@etsalapatis.com,ihor.solodrai@linux.dev,tj@kernel.org,shakeel.butt@linux.dev,kkd@meta.com,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Tue, 10 Nov 2026 04:50:51 +0000 (UTC)

--===============4998320395606795897==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Register bpf_task_park() for syscall programs

TL;DR:
- Verifier may accept bpf_task_park() while a syscall program holds the wakeup
  SRCU read lock, possibly blocking device removal indefinitely
- Comment and commit message on per-CPU state look inaccurate: run-time stats
  may be wrong after migration

> diff --git a/include/linux/filter.h b/include/linux/filter.h
> --- a/include/linux/filter.h
> +++ b/include/linux/filter.h

[ ... ]

> @@ -883,6 +883,12 @@ static __always_inline u32 bpf_prog_run(const struct bpf_prog *prog, const void
>   * This uses migrate_disable/enable() explicitly to document that the
>   * invocation of a BPF program does not require reentrancy protection
>   * against a BPF program which is invoked from a preempting task.
> + *
> + * A syscall program may call bpf_task_park(), which lifts the pin for the
> + * duration of its sleep and restores it before returning to the program,
> + * so such a program may resume on another CPU. Nothing on this path keeps
> + * per-CPU state across the program: __bpf_prog_run() samples its stats
> + * only after the program returns.
>   */

Is this description of __bpf_prog_run() accurate?  The same sentence appears
in the commit message.  __bpf_prog_run() reads the start time on the CPU the
program starts on, before the program runs:

    u64 duration, start = sched_clock();

    ret = dfunc(ctx, prog->insnsi, prog->bpf_func);

    duration = sched_clock() - start;

Only the this_cpu_ptr(prog->stats) lookup happens after the return.

If the program parks and resumes on another CPU, duration is the difference
between sched_clock() readings taken on two CPUs.  include/linux/sched/clock.h
says sched_clock() has no promise of monotonicity or bounded drift between
CPUs.

With CONFIG_HAVE_UNSTABLE_SCHED_CLOCK and an unstable clock, run_time_ns can
then include the offset between the two CPU clocks.  If the second CPU's
clock is behind, the u64 duration wraps before u64_stats_add() adds it to
that CPU's nsecs, and bpf_prog_get_stats() sums those values.

The effect is limited to bpf_stats_enabled accounting, but could the comment
and commit message be corrected, or the start time be handled when the
program migrates?

> diff --git a/kernel/bpf/task_park.c b/kernel/bpf/task_park.c
> --- a/kernel/bpf/task_park.c
> +++ b/kernel/bpf/task_park.c

[ ... ]

> @@ -276,3 +276,18 @@ __bpf_kfunc int bpf_task_wake(struct task_struct *task, u64 flags)
>  }
>  
>  __bpf_kfunc_end_defs();
> +
> +BTF_KFUNCS_START(bpf_task_park_kfunc_ids)
> +BTF_ID_FLAGS(func, bpf_task_park, KF_SLEEPABLE)
> +BTF_KFUNCS_END(bpf_task_park_kfunc_ids)
> +
> +static const struct btf_kfunc_id_set bpf_task_park_kfunc_set = {
> +	.owner = THIS_MODULE,
> +	.set = &bpf_task_park_kfunc_ids,
> +};
> +
> +static int __init bpf_task_park_kfunc_init(void)
> +{
> +	return register_btf_kfunc_id_set(BPF_PROG_TYPE_SYSCALL, &bpf_task_park_kfunc_set);
> +}
> +late_initcall(bpf_task_park_kfunc_init);

Can a syscall program hold an SRCU read section across bpf_task_park() by
way of a KF_ACQUIRE reference?  Registering for the same hook as the wakeup
source kfuncs in drivers/base/power/wakeup.c puts them side by side, and
bpf_wakeup_sources_read_lock() hands the SRCU read lock to the program as a
reference:

    __bpf_kfunc struct bpf_ws_lock *bpf_wakeup_sources_read_lock(void)
    {
        return (struct bpf_ws_lock *)(long)(wakeup_sources_read_lock() + 1);
    }

wakeup_sources_read_lock() is srcu_read_lock(&wakeup_srcu).  The verifier
does not treat this as a region.  in_rcu_cs() checks only active_rcu_locks,
active_preempt_locks, active_locks, active_irq_id and in_sleepable(), so
KF_SLEEPABLE passes.  check_park_stack_objects() checks only dynptrs and
iterators, and invalidate_regs_across_park() keeps the register on purpose
because it is backed by a verifier-tracked reference.

So it looks like the verifier accepts this syscall program:

    lock = bpf_wakeup_sources_read_lock();
    bpf_task_park(U64_MAX, 0);
    bpf_wakeup_sources_read_unlock(lock);

That sleeps in schedule_hrtimeout(NULL, ...) inside a wakeup_srcu read
section with no time limit.  At this commit no program can call
bpf_task_wake(), so only a signal ends the sleep.

Meanwhile, removal of a wakeup-capable device blocks in an uninterruptible
wait:

device_del()
  device_pm_remove()
    device_wakeup_disable()
      wakeup_source_unregister()
        wakeup_source_remove()
          synchronize_srcu(&wakeup_srcu)

The comment in this file says a read section may not be held across a sleep
of unbounded length, and that the verifier keeps the call out of a lock, a
saved IRQ state or an RCU read section.  An SRCU read section held as a
KF_ACQUIRE reference seems to get around both.

Nothing later in the series (08c90fceb77d, ba78244d0ebf) appears to refuse
the park while such a reference is held.  Should the verifier reject
bpf_task_park() while an acquired reference of this kind is live?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/42755601621
--===============4998320395606795897==--
