Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A472E4519A3;
	Wed,  5 Aug 2026 12:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785933413; cv=none; b=dAmy55MaXHVShgRNXea89G4TKNkxMCjar2nLZf7od4egMPhmPc1yZ5zwQGxHK9gv2RLF0T6n6JtAkfSlMdEOlJoKAiaR15pVU38pIpVsTwE5ZO3L/wCtciXyr6k/X80XRck6gBKe/IWxMOdhTfCyZ45mb31vfNg4NWsqmYUh1/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785933413; c=relaxed/simple;
	bh=u/QSMQYvK3iV/UzNy9hvY2R60BnUEZffif2r23mh6e4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=rqyY0PJjqbjDdW9BNGRbBGi9PuNkWZtFNOmZeOMMIX2qqKKRJ8H2na7GHzndnqJPwCTxowI2UZE0PDxcIoCWqsXvOWfqoAjh/XxYZF1HemU+9+XwEXRxN2ZJIFvEQE0YBeGdA742qqhDUM8wIExMIT8mEFVeadC4NtfqiGmb0Pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PYL+97++; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PYL+97++"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E48571F000E9;
	Wed,  5 Aug 2026 12:36:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785933411;
	bh=WpYGhy71GQYMEhx6/E9ep6qlSdxmN2HrvHU4YQK/7EE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PYL+97++58QkILjCKbG3ivZFRqxdlHKWu9h6ifgzaXgT8Kut61fVB3BXng2dG71nm
	 SsDD2ZZ3nz98hZu+pyNKnAwguzMLJtTJTWtHsYdUu/+0njSsQKVUlqbs7ge86BPD4v
	 lSI8JQjk3S8IzhEoH4RdRvu3PPiXmr1QIjyB1zmnCvXs09BrLlBNDSzon0mGHeh/sd
	 4hpKX8DOlkOl72oAmQ7LOa8PyjeqR1135liWBfvWA4/ZS1mBZlHZzw/cMDMVVpCM4j
	 QfGVtLFS+mCq6SshI03eZLVAkMDrQZ6xi46gy745Nce15WZSkjnz/mhsNKPcF3TRD0
	 JoSzU4Uev1Dww==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/6] rcu: Make call_rcu() safe to call from any
 context
Reply-To: sashiko-reviews@lists.linux.dev
To: "Puranjay Mohan" <puranjay@kernel.org>
Cc: linux-rt-devel@lists.linux.dev, bpf@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260805122346.269445-2-puranjay@kernel.org>
References: <20260805122346.269445-1-puranjay@kernel.org>
 <20260805122346.269445-2-puranjay@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 05 Aug 2026 12:36:49 +0000
Message-Id: <20260805123650.E48571F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Critical] A lockless check in rcu_defer_flush() causes rcu_barrier() to =
miss in-flight deferred callbacks, violating the core rcu_barrier() guarant=
ee.
- [High] __rcu_defer_drain() creates an unbounded non-interruptible critica=
l section, breaking PREEMPT_RT constraints and risking hard lockups.
- [Medium] KASAN stack trace recording for deferred callbacks records the a=
synchronous irq_work context instead of the actual call_rcu() caller.
--

--- Patch [1]: [PATCH v3 1/6] rcu: Make call_rcu() safe to call from any co=
ntext ---
commit 2b52f34260090add38843ff0920806c5e56bf18c
Author: Puranjay Mohan <puranjay@kernel.org>
Subject: rcu: Make call_rcu() safe to call from any context

This commit makes call_rcu() safe to call from any context by deferring
callbacks to a per-CPU llist when interrupts are disabled. An irq_work
then re-issues these callbacks once interrupts are re-enabled, preventing
deadlocks or list corruption.

> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 96848fc1f02b8..6fd7331aebc58 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
[ ... ]
> @@ -3206,6 +3211,104 @@ __call_rcu_common(struct rcu_head *head, rcu_call=
back_t func, bool lazy_in)
>  	local_irq_restore(flags);
>  }
> =20
> +/*
> + * Re-issue deferred callbacks straight to the enqueue so they cannot de=
fer
> + * again.  ->defer_lock serializes the drainers: this CPU's irq_work,
> + * rcu_defer_flush() and rcutree_migrate_callbacks().
> + */
> +static void __rcu_defer_drain(struct rcu_data *rdp, bool guard)
> +{
> +	struct llist_node *node, *next;
> +	unsigned long flags;
> +
> +	if (!IS_ENABLED(CONFIG_RCU_DEFER))
> +		return;
> +
> +	raw_spin_lock_irqsave(&rdp->defer_lock, flags);
> +	if (guard)
> +		WRITE_ONCE(rdp->defer_draining, true);
> +	llist_for_each_safe(node, next, llist_del_all(&rdp->defer_head)) {
> +		struct rcu_head *head =3D (struct rcu_head *)node;
> +
> +		head->next =3D NULL;
> +		rcu_do_enqueue(head, head->func, false);
> +	}

[Severity: High]
Could holding this raw spinlock across an unbounded number of enqueues cause
latency spikes or hard lockups, especially on PREEMPT_RT?

If a bulk teardown path calls call_rcu() in a loop with interrupts disabled,
thousands of callbacks could be staged. When __rcu_defer_drain() runs, it
loops over all of them in a single uninterrupted pass. If another CPU
executes rcu_barrier() and calls __rcu_defer_drain(), it would also spin on
this raw lock with interrupts disabled for the entire duration of the drain.

> +	if (guard)
> +		WRITE_ONCE(rdp->defer_draining, false);
> +	raw_spin_unlock_irqrestore(&rdp->defer_lock, flags);
> +}
[ ... ]
> +/* Stage @head for this CPU's irq_work when call_rcu() cannot enqueue no=
w. */
> +static void call_rcu_defer(struct rcu_head *head, rcu_callback_t func)
> +{
> +	struct rcu_data *rdp =3D this_cpu_ptr(&rcu_data);
[ ... ]
> +	head->func =3D func;
> +	if (llist_add((struct llist_node *)head, &rdp->defer_head))
> +		irq_work_queue(&rdp->defer_work);
> +}

[Severity: Medium]
Will this delay KASAN stack trace recording to the irq_work context?

Because call_rcu_defer() stages the callback without recording the stack tr=
ace,
the trace gets recorded later by kasan_record_aux_stack(head) inside
rcu_do_enqueue(). This means any use-after-free reports might point to
the irq_work instead of the original call_rcu() caller, making debugging
more difficult.

> +/*
> + * Register pending deferred callbacks into the callback lists so a foll=
owing
> + * rcu_barrier() waits for them.  This runs before rcu_barrier() scans t=
he
> + * lists.
> + */
> +static void rcu_defer_flush(void)
> +{
> +	int cpu;
> +
> +	if (!IS_ENABLED(CONFIG_RCU_DEFER))
> +		return;
> +
> +	for_each_possible_cpu(cpu) {
> +		struct rcu_data *rdp =3D per_cpu_ptr(&rcu_data, cpu);
> +
> +		if (!llist_empty(&rdp->defer_head))
> +			__rcu_defer_drain(rdp, false);
> +	}
> +}

[Severity: Critical]
Can this lockless check cause rcu_barrier() to miss in-flight callbacks?

If CPU A's irq_work detaches the list via llist_del_all() in
__rcu_defer_drain(), defer_head becomes empty immediately. If CPU B
executes rcu_defer_flush() concurrently, the lockless llist_empty()
check will return true and bypass acquiring defer_lock.

Since CPU A has detached the callbacks but hasn't yet enqueued them
into cblist, CPU B might skip __rcu_defer_drain(), check a cblist that
does not yet contain the detached callbacks, and allow rcu_barrier()
to return prematurely while objects are still in use.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260805122346.2694=
45-1-puranjay@kernel.org?part=3D1
