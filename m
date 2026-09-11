Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C84C3515C5;
	Fri, 11 Sep 2026 14:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789136788; cv=none; b=f3NrCI8kB38V3I/wqfRhrL691H+m5Nj3Dh3twx0NYatAXpBulvxyfpx5++HfURJIbKAqLg1Cu0mvNZVGgoT3npAzddSYohPUUhXfAJWSUbpMYViDkGlTWwWvSclgoEDzK5kPjm4Q4TRMKwrsH5z3apvzX0EphC12PNg0aOUQ4XE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789136788; c=relaxed/simple;
	bh=yfEXWM6VUef8CWR3t58XluuZtqzgvp0he5DPtZ292lw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=G3BxsdChVNTrX7vxpH4ex5EOLW1znM8RLvl1SUqx7s/+5ovH6tueX0mMN3N2T8XKOZq+ObKI5ofJPACV65SU23iubZSw/A5nitLg0M5WWq5O0MDQWypIgAb9wxQEfYNCTA5XFY3NJLenMzjEgpIHDyyucS6PSMpncnKZ2cZaCJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OpM7eGja; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OpM7eGja"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACAED1F000FF;
	Fri, 11 Sep 2026 14:26:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789136786;
	bh=5i+QR7TdRrGj/hsXJyP1g6TWyFnrwBaJG+rXd+CDvg4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OpM7eGjaV0VoRBV2/qTALAuJqOZfDhqWtMZp+aQ9fsbuDC3lUt+FD4MYyzgEXNAuy
	 ZDkd4yIBe8CQtlDKzyY3xDhKLG9RqLs/xU9NquOj11AH5FDaFZBVpCmOCP9KT719Bn
	 YP5+NT61Bgx/IBqSnQa+z5OGFBNGoiusQFmI78Luke+Wnwbk6lyCNyrJtV8hqKlmhc
	 YYdQj17lpuiI+6HbbcAWCkqnzjCZczNxDeiwVfVR9+/0x+80McKKDSI9bGF/zbL28o
	 daCNrlVKemxRevZVWtosVOBkqBwPiR3Od255hol9Rb0rpYBmL08wlfViQVyVfFzwAS
	 WKWrWTK7SYr8g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v2 04/15] kprobes: Let Tasks RCU recognise tasks
 preempted in an optprobe jump window
Reply-To: sashiko-reviews@lists.linux.dev
To: "Josef Bacik" <josef@toxicpanda.com>
Cc: bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org
In-Reply-To: <20260911-b4-rcu-tasks-preempt-qs-v2-4-eaaa61ed2da4@toxicpanda.com>
References: <20260911-b4-rcu-tasks-preempt-qs-v2-0-eaaa61ed2da4@toxicpanda.com>
 <20260911-b4-rcu-tasks-preempt-qs-v2-4-eaaa61ed2da4@toxicpanda.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 11 Sep 2026 14:26:26 +0000
Message-Id: <20260911142626.ACAED1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Lockless traversal of the RCU-protected `kprobe_table` in `kprob=
e_in_optimized_region()` lacks `rcu_read_lock()`, leading to lockdep splats=
 on PREEMPT_RCU kernels.
--

commit dc16333e12fedda231a4417b135bef649425955b
Author: Josef Bacik <josef@toxicpanda.com>

kprobes: Let Tasks RCU recognise tasks preempted in an optprobe jump window

This commit adds a lockless check kprobe_in_optimized_region() to allow Tas=
ks
RCU to recognize tasks preempted within an instruction boundary about to be
overwritten by an optimized jump kprobe. It evaluates registered kprobes=20
inside the optimizer's Tasks RCU grace period.

> diff --git a/kernel/kprobes.c b/kernel/kprobes.c
> index 6337da5cab9e7..cf2ea278fdf5b 100644
> --- a/kernel/kprobes.c
> +++ b/kernel/kprobes.c

[ ... ]

> @@ -511,6 +511,48 @@ static struct kprobe *get_optimized_kprobe(kprobe_op=
code_t *addr)
>  	return NULL;
>  }
> =20
> +/*
> + * True while kprobe_optimizer() is waiting for its Tasks RCU grace peri=
od.
> + * Only in that window can a preemption inside an optprobe's jump region
> + * matter to it, so kprobe_in_optimized_region() does no work otherwise.
> + */
> +static bool kprobe_optimizer_waiting;
> +
> +/**
> + * kprobe_in_optimized_region - Could @addr be inside bytes a jump-optim=
ized
> + *	kprobe replaces?
> + * @addr: kernel text address, typically an interrupted instruction poin=
ter
> + *
> + * kprobe_optimizer() relies on synchronize_rcu_tasks() to wait for task=
s that
> + * were preempted on an instruction boundary inside the region about to =
be
> + * overwritten by the optimized jump; such a task must not report a Task=
s RCU
> + * quiescent state when it is preempted (see rcu_tasks_ip_in_trampoline(=
)).
> + * This is the lockless, conservative form of get_optimized_kprobe(): it=
 does
> + * not care whether the kprobe found is, or ever will be, optimized.  Ma=
y be
> + * called from any context with preemption disabled; the kprobe hash is
> + * RCU-protected and every free path waits for a grace period after unha=
shing.
> + *
> + * The hash walk only runs while the optimizer is actually waiting.  A
> + * preemption that does not observe kprobe_optimizer_waiting predates the
> + * grace period (its leading synchronize_rcu() publishes the store to ev=
ery
> + * interrupts-disabled reader before any task is sampled as a holdout); =
such a
> + * task is then an ordinary preempted holdout, and the jump is not writt=
en
> + * until it has run again and left the region.
> + */
> +bool kprobe_in_optimized_region(unsigned long addr)
> +{
> +	int i;
> +
> +	if (!READ_ONCE(kprobe_optimizer_waiting))
> +		return false;
> +
> +	for (i =3D 1; i < MAX_OPTIMIZED_LENGTH / sizeof(kprobe_opcode_t); i++)
> +		if (get_kprobe((kprobe_opcode_t *)addr - i))

[Severity: Medium]
When kprobe_in_optimized_region() calls get_kprobe(), neither rcu_read_lock=
()
nor kprobe_mutex is held (for example, when called from the Tasks RCU GP
kthread).

get_kprobe() iterates the hash list using:

    hlist_for_each_entry_rcu(p, head, hlist,
                             lockdep_is_held(&kprobe_mutex)) {

Without explicitly acquiring rcu_read_lock() around get_kprobe(), lockdep
will complain about suspicious RCU usage, because preempt_disable() (or
running from a kthread) does not satisfy rcu_read_lock_held() on
CONFIG_PREEMPT_RCU.

Could this lockless traversal of kprobe_table trigger a lockdep warning on
PREEMPT_RCU kernels?

> +			return true;
> +	return false;
> +}
> +NOKPROBE_SYMBOL(kprobe_in_optimized_region);
> +

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260911-b4-rcu-tas=
ks-preempt-qs-v2-0-eaaa61ed2da4@toxicpanda.com?part=3D4
