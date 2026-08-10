Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA6953D954E;
	Mon, 10 Aug 2026 12:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786365833; cv=none; b=UrvKSEq1KQPC3Wx8Vi7d8qnSxImf2/61VgJLAflyfvQK3AU7QcBq/YdPz2JfRVLI9fMr3SJjczWlnMl3M1ua4kTPO0CvZN4uq9r+lfVQkE4TzjJxjorDF4gAqDYOvujMGdb4CnynTN/3Ttbm7WRp8eQlUyWOdxmLkaw1otV0TQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786365833; c=relaxed/simple;
	bh=24gvAXp17teeDJQB4dktddtoNbx6jYAm0555LRY/pYk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=NoCa8LLHCnpNWJzhDaRpkDjskvDe01jc09aXBDvn60lxp8FJSt7DcjS7jRPooWAr05kpvcN8j0r7tAbYUOgODN/WWLEVWfYdX3HK9VoZrqtdOSmB9j7r6KMKMJgME+jUsFuV53axuiCv0PSGVrtHCZNmSjf9XCvy6B5q6zR95qQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QN5+f1fB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QN5+f1fB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 390741F000E9;
	Mon, 10 Aug 2026 12:43:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786365831;
	bh=FN/yf9C675WsQ25omG0Zbe5cc9UT5PhSQDard6cXxGY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QN5+f1fB4qU7VcjXAcqOfPlGZryG2lGjMtCpdVSiqgmEadJzrElrC61HFZNr5x7s+
	 CH+nSqTpZ5Gg+TwcWQHCs+D3p6FxqD5Mfw4JUSYEeLF2Ahy1KlSRfYRcSob0j3yIk5
	 J5R3GlrXDrVcgTnRxNdcmuu3Y48RlgdUlB30rXACIh6fX0MixkQtWtF6WQ3MkJvN7x
	 KVaWPgXzBIrp/48fvVpYqNQFBorxKvbSyT6WRpO8vbnBC4F+Vdb4zkBWuFrCa5B2qe
	 dTlwYNtcZh8NU21kESVbGcmv2E8V7ZOQD6wN/DTagkpP5o8rMC/8KmTFwMTheJwOXW
	 lABNUXo+c2IIw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 1/6] rcu: Make call_rcu() safe to call from any
 context
Reply-To: sashiko-reviews@lists.linux.dev
To: "Puranjay Mohan" <puranjay@kernel.org>
Cc: bpf@vger.kernel.org, linux-rt-devel@lists.linux.dev, linux-kernel@vger.kernel.org
In-Reply-To: <20260810122758.183765-2-puranjay@kernel.org>
References: <20260810122758.183765-1-puranjay@kernel.org>
 <20260810122758.183765-2-puranjay@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 10 Aug 2026 12:43:50 +0000
Message-Id: <20260810124351.390741F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Deferred callbacks bypass `debug_rcu_head_queue()` check, causing =
immediate list corruption on double `call_rcu()` and defeating `CONFIG_DEBU=
G_OBJECTS_RCU_HEAD`.
--

--- Patch [1]: [PATCH v4 1/6] rcu: Make call_rcu() safe to call from any co=
ntext ---
commit 5205f0afe602a3f93ee865a26d94981f93553b7d
Author: Puranjay Mohan <puranjay@kernel.org>

rcu: Make call_rcu() safe to call from any context

This patch defers call_rcu() via a per-CPU llist and irq_work when called
with interrupts disabled. This avoids deadlocks or list corruption if
call_rcu() is invoked from NMI or instrumentation.

> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 96848fc1f02b8..ff9a2395c9e8e 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c

[ ... ]

> -static void
> -__call_rcu_common(struct rcu_head *head, rcu_callback_t func, bool lazy_=
in)
> +/*
> + * Also called by __rcu_defer_drain() to re-issue a deferred callback, s=
o it
> + * must not re-check the deferral condition.  Either caller may have int=
errupts
> + * already disabled, and a drain of a remote CPU re-issues onto the drai=
ning
> + * CPU.
> + */
> +static void rcu_do_enqueue(struct rcu_head *head, rcu_callback_t func, b=
ool lazy_in)
>  {
>  	static atomic_t doublefrees;
>  	unsigned long flags;
>  	bool lazy;
>  	struct rcu_data *rdp;
> =20
> -	/* Misaligned rcu_head! */
> -	WARN_ON_ONCE((unsigned long)head & (sizeof(void *) - 1));
> -
> -	/* Avoid NULL dereference if callback is NULL. */
> -	if (WARN_ON_ONCE(!func))
> -		return;
> -
>  	if (debug_rcu_head_queue(head)) {

[ ... ]

> +static void call_rcu_defer(struct rcu_head *head, rcu_callback_t func)
> +{
> +	struct rcu_data *rdp =3D this_cpu_ptr(&rcu_data);
> +
> +	/*
> +	 * Instrumentation on the enqueue path can re-enter here from inside the
> +	 * drain.  Re-queuing would livelock it, so drop the callback; an NMI
> +	 * cannot loop, so let it through.
> +	 */
> +	if (READ_ONCE(rdp->defer_draining) && !in_nmi()) {
> +		WARN_ONCE(IS_ENABLED(CONFIG_PROVE_RCU),
> +			  "call_rcu() re-entered during callback drain; leaking callback\n");
> +		return;
> +	}
> +	head->func =3D func;
> +	if (llist_add((struct llist_node *)head, &rdp->defer_head))
> +		irq_work_queue(&rdp->defer_work);
> +}

[ ... ]

> +static void
> +__call_rcu_common(struct rcu_head *head, rcu_callback_t func, bool lazy_=
in)
> +{
> +	/* Misaligned rcu_head! */
> +	WARN_ON_ONCE((unsigned long)head & (sizeof(void *) - 1));
> +
> +	/* Avoid NULL dereference if callback is NULL. */
> +	if (WARN_ON_ONCE(!func))
> +		return;
> +
> +	/* Record the caller: the irq_work's stack says nothing about it. */
> +	kasan_record_aux_stack(head);
> +
> +	if (should_rcu_defer()) {
> +		call_rcu_defer(head, func);

[Severity: High]
Does this bypass the debug check for double call_rcu(), potentially corrupt=
ing
the callback list?

By moving debug_rcu_head_queue() from __call_rcu_common() into rcu_do_enque=
ue(),
deferred callbacks are added to the defer_head list before being validated.

If a double call_rcu() occurs, llist_add() in call_rcu_defer() will overwri=
te
head->next. If the callback was already in a normal cblist, its next pointe=
r is
overwritten with defer_head->first, immediately splitting the cblist and
splicing it into the deferred list.

Could we check debug_rcu_head_queue() here before deferring, so that
CONFIG_DEBUG_OBJECTS_RCU_HEAD can safely catch the bug without list corrupt=
ion?

> +		return;
> +	}
> +
> +	/*
> +	 * Only reachable from an NMI when deferral is off: before the scheduler
> +	 * is up, or with CONFIG_RCU_DEFER=3Dn.  The enqueue can then race.
> +	 */
> +	WARN_ON_ONCE(IS_ENABLED(CONFIG_PROVE_RCU) && in_nmi());
> +
> +	rcu_do_enqueue(head, func, lazy_in);
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260810122758.1837=
65-1-puranjay@kernel.org?part=3D1
