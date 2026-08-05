Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C908746D55D;
	Wed,  5 Aug 2026 12:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785933435; cv=none; b=G7hynDO9kTpNJblMwKR0Ohu7hTrtnQbhXi7NCE/IouaMF95GvGJVm0HzRWGh5ubbZ3LH5JTORSfu/1wFEYeIw+ptXg4XcdL/hNNnibRaHuFLPfyj+vVzR5PPrZhe7pulqYVQybFjv0CX/tZqz55xyzUwMbge7u6YX8lKKtjk7+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785933435; c=relaxed/simple;
	bh=O9yx0Bnp3LbluUspTX00zDpBiSzT8VdZ+tvXCzBn6jA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=LjKjjptAKGDjYDrceguMVuWLZybWtCAGfIH2369a4dDeIe0CAsfia5JQlqsfXoIryiPvYMWyW2PeBzyFFdKMnP3zAbVMFu6PH31/ee8O9W0LdfUHoBpkJTcjd4iscSsP8CJrv1vD/xSVWnzlUB5KEARdXNtjtUPD49VmJvxJmCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oZ0UbvDa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oZ0UbvDa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DF251F000E9;
	Wed,  5 Aug 2026 12:37:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785933433;
	bh=pVN4bX2dJAKinPvQn5oF6FVBy1lT0j89ERsoQqWyNWU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oZ0UbvDayHHc4fVfCc2Rua/JyOE8k5Xwpku0R/xOUVAle7E6fGiRdWgCPxx8r8nym
	 KZmqGbaKzy+ELr8vGK9U5Zwh4BBFqCxYXYvt94XSdF/MZb1WWp/cAVjatcWsgETFZz
	 zQ20xcLJbGoQ/6FFGhAcg4lMLr6luCKqo8Y/aSZ/VVQ/fiIzMdYs80UWKofH1XqPtE
	 r1G/lagP3QhyaWoBZL/KE+gb8WnxBtD3iMX+KFW9L5Ma59ChBx11gku0o/E7ELiskn
	 c8sFYJ/W8Vcq+Br68Xl7F7AWPYtfeU41gdz8irMJUk8Cu7P5pynG6H/yjQAsv+496/
	 cHYxBW+1b3nCA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/6] rcu: Make Tiny call_rcu() safe to call from any
 context
Reply-To: sashiko-reviews@lists.linux.dev
To: "Puranjay Mohan" <puranjay@kernel.org>
Cc: linux-rt-devel@lists.linux.dev, bpf@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260805122346.269445-3-puranjay@kernel.org>
References: <20260805122346.269445-1-puranjay@kernel.org>
 <20260805122346.269445-3-puranjay@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 05 Aug 2026 12:37:12 +0000
Message-Id: <20260805123713.3DF251F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Bypass of debug validation causes fatal RCU list corruption on dou=
ble-free.
- [High] O(N) runqueue spinlock acquisitions cause severe interrupt latency=
 during callback drain.
--

--- Patch [2]: [PATCH v3 2/6] rcu: Make Tiny call_rcu() safe to call from a=
ny context ---
commit 695767be85ec82f2457b846af53d8afe8fb742d1
Author: Puranjay Mohan <puranjay@kernel.org>

rcu: Make Tiny call_rcu() safe to call from any context

This commit updates Tiny RCU's call_rcu() to defer callbacks when called
with interrupts disabled. It uses a lockless list and an irq_work to
re-issue them later, similar to Tree RCU.

> diff --git a/kernel/rcu/tiny.c b/kernel/rcu/tiny.c
> index dccccd6be9411..baffe660043f5 100644
> --- a/kernel/rcu/tiny.c
> +++ b/kernel/rcu/tiny.c

[ ... ]

> +static void rcu_do_enqueue(struct rcu_head *head, rcu_callback_t func)
> +{
> +	static atomic_t doublefrees;
> +	unsigned long flags;
> +
> +	if (debug_rcu_head_queue(head)) {
> +		if (atomic_inc_return(&doublefrees) < 4) {
> +			pr_err("%s(): Double-freed CB %p->%pS()!!!  ", __func__, head, head->=
func);
> +			mem_dump_obj(head);
> +		}
> +		return;
> +	}
> +
> +	head->func =3D func;
> +	head->next =3D NULL;
> +
> +	local_irq_save(flags);
> +	*rcu_ctrlblk.curtail =3D head;
> +	rcu_ctrlblk.curtail =3D &head->next;
> +	local_irq_restore(flags);
> +
> +	if (unlikely(is_idle_task(current))) {
> +		/* force scheduling for rcu_qs() */
> +		resched_cpu(0);
> +	}
> +}
> +
> +static void __rcu_defer_drain(bool guard)
> +{
> +	struct llist_node *node, *next;
> +	unsigned long flags;
> +
> +	/* Callbacks are unordered, so drain in llist order without reversing. =
*/
> +	local_irq_save(flags);
> +	if (guard)
> +		WRITE_ONCE(rcu_defer_draining, true);
> +	llist_for_each_safe(node, next, llist_del_all(&rcu_defer_list)) {
> +		struct rcu_head *head =3D (struct rcu_head *)node;
> +
> +		head->next =3D NULL;
> +		rcu_do_enqueue(head, head->func);

[Severity: High]
Does this code cause severe interrupt latency during callback drain?

If a batch of RCU callbacks is deferred and the CPU subsequently goes idle,
__rcu_defer_drain() loops over the entire batch in hardirq context.

For each callback, rcu_do_enqueue() will call resched_cpu(0) because
current is the idle task.  Since resched_cpu() unconditionally takes the
runqueue spinlock, this results in an O(N) locking sequence in hardirq
context, which could lead to watchdog soft lockups.

> +	}
> +	if (guard)
> +		WRITE_ONCE(rcu_defer_draining, false);
> +	local_irq_restore(flags);
> +}

[ ... ]

> @@ -157,29 +250,15 @@ EXPORT_SYMBOL_GPL(synchronize_rcu);
>   */
>  void call_rcu(struct rcu_head *head, rcu_callback_t func)
>  {
> -	static atomic_t doublefrees;
> -	unsigned long flags;
> -
> -	if (debug_rcu_head_queue(head)) {
> -		if (atomic_inc_return(&doublefrees) < 4) {
> -			pr_err("%s(): Double-freed CB %p->%pS()!!!  ", __func__, head, head->=
func);
> -			mem_dump_obj(head);
> -		}
> +	if (should_rcu_defer()) {
> +		call_rcu_defer(head, func);

[Severity: High]
Does moving the debug validation after the deferral bypass it during a
double-free?

If a subsystem double-frees an RCU callback while interrupts are disabled,
it will take this deferral path instead of checking debug_rcu_head_queue().

In call_rcu_defer():

	if (llist_add((struct llist_node *)head, &rcu_defer_list))

If the callback is already in the list, llist_add() modifies its next
pointer, creating a cycle in the lockless list.  Later, when the
irq_work drains the list, llist_for_each_safe() in __rcu_defer_drain()
will loop infinitely, causing a system hard lockup in hardirq context.

>  		return;
>  	}
> =20
> -	head->func =3D func;
> -	head->next =3D NULL;
> -
> -	local_irq_save(flags);
> -	*rcu_ctrlblk.curtail =3D head;
> -	rcu_ctrlblk.curtail =3D &head->next;
> -	local_irq_restore(flags);
> +	/* An NMI reaching here entered with irqs enabled, so the enqueue can r=
ace. */
> +	WARN_ON_ONCE(IS_ENABLED(CONFIG_PROVE_RCU) && in_nmi());
> =20
> -	if (unlikely(is_idle_task(current))) {
> -		/* force scheduling for rcu_qs() */
> -		resched_cpu(0);
> -	}
> +	rcu_do_enqueue(head, func);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260805122346.2694=
45-1-puranjay@kernel.org?part=3D2
