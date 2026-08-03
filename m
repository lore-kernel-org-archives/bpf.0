Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 588B630D3F8;
	Mon,  3 Aug 2026 14:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785767707; cv=none; b=f8C7NyeWtHajd1BMmNOzidaPpCH2I9N8SYD1Wek3GNnChVb4YWoenbsDMKWFHDN/QAFKzLcIvOuoULFRCoApTNoMrw3rebT4wh5bnKypOY/vXUYnTOuZq7pYRMTRmMspxStENG9rDp7w7hGTXU+i6fojR4kGlYnx3NErJ0m/x48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785767707; c=relaxed/simple;
	bh=842jnfvWgr5zCg1CKzFfwwUHVd9RW6entE2A78VWwj0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=JMuykHSzvq2sVzIfdWQb0DJSP/sjbKOBdEb27I86rCBCFpwvdR+6QxoLJ7mRRpwYs/E7CkNSjx9HBqoYpvRQ1hmtEecVOlNGu2yWkyZBdnoJUyKMfB9K5mJ66bv5q13me1x+xv86wwBaeI0uAnQJmk60cSi8kFv48bFQfcHG8Gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JMn6gzHe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JMn6gzHe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E3D21F00A3A;
	Mon,  3 Aug 2026 14:35:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785767706;
	bh=RA9U7DsHdtyDOfDw1dyoBJ0z5ovMpQoUFnN4IOk0NG4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JMn6gzHevzWdZOQq0jSjb68/e7DgItm1blbNKqIlzne8tp3m/vjxWl5O/2wQllbGZ
	 HLK+V3FAvXmbFzVCoP9AIwjiPGP5yne5yiZ0VX82tsPtSay44IdOlogCjcP3KbIXjA
	 cN5jfgzODuLBlPKNPZEv9taLoVxpMgmLpY1np8lulZ1i2QhO8ThvviYhyl2teRRqH1
	 drdjpgGtf4+2QckBcfDVhZGNWUtxVZAsLegxc0/fZPBck7lrbd+JvUL8sEnOOkgPWd
	 IF36z3nNzI0wzRmGULOsbmRfVAVJ7bWpL5IWPnKGrhox4VJXo3rrMYu+2dLIcrSPk6
	 vjXrmHGXHwoew==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/6] rcu: Make Tiny call_rcu() safe to call from any
 context
Reply-To: sashiko-reviews@lists.linux.dev
To: "Puranjay Mohan" <puranjay@kernel.org>
Cc: bpf@vger.kernel.org, linux-rt-devel@lists.linux.dev, linux-kernel@vger.kernel.org
In-Reply-To: <20260803135329.2327280-2-puranjay@kernel.org>
References: <20260803134839.2103051-1-puranjay@kernel.org>
 <20260803135329.2327280-2-puranjay@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 03 Aug 2026 14:35:03 +0000
Message-Id: <20260803143505.2E3D21F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Relocating `debug_rcu_head_queue()` into `rcu_do_enqueue()` bypass=
es double-free detection for deferred callbacks, silently corrupting the lo=
ckless list and inducing a permanent hard livelock during `rcu_defer_drain(=
)`.
- [Medium] Invalid `WARN_ON_ONCE` in `call_rcu()` falsely flags safe NMI ex=
ecutions due to a flawed concurrency assumption.
--

--- Patch [2]: [PATCH v2 2/6] rcu: Make Tiny call_rcu() safe to call from a=
ny context ---
commit 866e1596ae5a7314657b9b0164dfabf922016c70
Author: Puranjay Mohan <puranjay@kernel.org>

rcu: Make Tiny call_rcu() safe to call from any context

Give Tiny call_rcu() the same treatment as Tree RCU.  When interrupts are
disabled and the scheduler is up, stage the callback on a lockless list
that an irq_work re-issues later.  One global list and irq_work suffice
since Tiny RCU is uniprocessor, and there is no CPU-offline drain.

> diff --git a/kernel/rcu/tiny.c b/kernel/rcu/tiny.c
> index dccccd6be9411..5736b964d8ee1 100644
> --- a/kernel/rcu/tiny.c
> +++ b/kernel/rcu/tiny.c

[ ... ]

> @@ -42,8 +44,86 @@ static struct rcu_ctrlblk rcu_ctrlblk =3D {

[ ... ]

> +static void call_rcu_defer(struct rcu_head *head, rcu_callback_t func)
> +{
> +	/* A re-entrant call_rcu() during the drain would livelock it; drop it.=
 */
> +	if (rcu_defer_draining && !in_nmi()) {
> +		WARN_ONCE(1, "call_rcu() re-entered during callback drain; leaking cal=
lback\n");
> +		return;
> +	}
> +	head->func =3D func;
> +	if (llist_add((struct llist_node *)head, &rcu_defer_list))

[Severity: High]
Does moving the debug_rcu_head_queue() check into rcu_do_enqueue() bypass
double-free detection for deferred callbacks?

If a double-free occurs, llist_add() will be called twice on the same node =
here,
corrupting the lockless list by creating a circular link (head->next =3D he=
ad).

When the irq_work executes rcu_defer_drain(), won't the llist_for_each_safe=
()
iteration infinitely hang on the circular list before the delayed debug che=
ck
can prevent the livelock?

> +		irq_work_queue(&rcu_defer_iw);
> +}

[ ... ]

> @@ -157,29 +237,15 @@ EXPORT_SYMBOL_GPL(synchronize_rcu);
>   */
>  void call_rcu(struct rcu_head *head, rcu_callback_t func)
>  {
> -	static atomic_t doublefrees;
> -	unsigned long flags;

[ ... ]

> +	if (should_rcu_defer()) {
> +		call_rcu_defer(head, func);
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

[Severity: Medium]
Is this concurrency assumption backwards?=20

If an NMI interrupted a context where IRQs were enabled, that interrupted
context could not have been in the middle of rcu_do_enqueue() because
rcu_do_enqueue() disables IRQs via local_irq_save().

Since it's impossible for the NMI to race with rcu_do_enqueue() in this
scenario, will this falsely trigger kernel warnings during safe NMI
executions?

> -	if (unlikely(is_idle_task(current))) {
> -		/* force scheduling for rcu_qs() */
> -		resched_cpu(0);
> -	}
> +	rcu_do_enqueue(head, func);
>  }
>  EXPORT_SYMBOL_GPL(call_rcu);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260803134839.2103=
051-1-puranjay@kernel.org?part=3D2
