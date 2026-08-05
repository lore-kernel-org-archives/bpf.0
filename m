Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7B964766BD;
	Wed,  5 Aug 2026 12:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785933345; cv=none; b=Mn/8rVFCWZRfES9+YEgLuDBUM4jtaul80MQI1Y8hZpxepa3z2+6j5YAz02wGjP8CR0MeYHUbPL2+dL84S9ZLhmw8IiwbYKh3g6431G00TFNRHI4c9zHQC8mHWE1HqZKGLmkcxhdaTTjqqvmJLkNjbFPwGF4AEKj8VcAmq0yDq9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785933345; c=relaxed/simple;
	bh=e1gegNThzMuh+33P96hFm4RkJpbJa7EkhPIID3hb6Sw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=cuYbrFlcV9sY+XHflzEv8c97Jja7oZdgYumgQIUBWFhyuwV94BqrkL58i4dmiCmnkuNiYoKYIwQIyBN344OTyGo+0jR0jXR8bQSzUYVD0UjMkK+O86Cqk5IgQSSbswQMp5DF/9fPAorDWswNCC6kGZ6Qs6ArCnX5J6uPi0N9Hoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OY6iI1+f; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OY6iI1+f"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 166401F000E9;
	Wed,  5 Aug 2026 12:35:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785933343;
	bh=KDAAxE67AkA4VWS6hTKD9Qmq2J0HyWRc7mVnAlucdnQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OY6iI1+fQdGt7rd4Why2AO6cLyzK7FNgP9mQVYvB5bGxifr/4Vk9RNlaXJYEA4qsy
	 zPIUt45kTbDRkhOyu82qs1GXqNiSymPEWQgmle8+/vQJ8oD8ZpWtVOWKsQQCqk+rIc
	 7rICIgnsQnU/sGRKYcLLg3/xvu8NAddnZuJ4BnC+Q4k1+jVpjlSOzhgOD5AESSc/Sj
	 AJRyEoSsB5rSYcPkHrESGEPAh/AwklV1yWX7qUAvlc8bWGPWopHxN+voO3FcpxWMSs
	 l0j1T5DMi8Xv0XnsxOKMDbduTpS8OJhb665MGzN4tV34yskxjrEo/iwOjbEKn4Hkyo
	 43EBp6YUyAYYA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 3/6] srcu: Make call_srcu() safe to call from any
 context
Reply-To: sashiko-reviews@lists.linux.dev
To: "Puranjay Mohan" <puranjay@kernel.org>
Cc: linux-rt-devel@lists.linux.dev, bpf@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260805122346.269445-4-puranjay@kernel.org>
References: <20260805122346.269445-1-puranjay@kernel.org>
 <20260805122346.269445-4-puranjay@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 05 Aug 2026 12:35:42 +0000
Message-Id: <20260805123543.166401F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Critical] A TOCTOU race in `srcu_defer_flush()` locklessly checking `lli=
st_empty()` can cause `srcu_barrier()` to return prematurely, leading to a =
Use-After-Free.
- [Medium] Expedited SRCU callbacks can be silently downgraded to normal ca=
llbacks due to a non-atomic update race on `sdp->defer_exp` between `__call=
_srcu()` and `__srcu_defer_drain()`.
--

--- Patch [3]: [PATCH v3 3/6] srcu: Make call_srcu() safe to call from any =
context ---
commit 137e7f3c08249a4bd260b0c0d6f275423685df28
Author: Puranjay Mohan <puranjay@kernel.org>

srcu: Make call_srcu() safe to call from any context

call_srcu() has the same constraint as call_rcu(): its callback list and
locks are only touched with interrupts disabled. Defer as call_rcu()
does: stage the callback on the srcu_data's ->defer_cbs, chain that
srcu_data onto a per-CPU list, and raise a per-CPU irq_work that
re-issues it straight to the enqueue helper, never back through
__call_srcu().

> diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> index 304112674e8a2..35fface51d50b 100644
> --- a/kernel/rcu/srcutree.c
> +++ b/kernel/rcu/srcutree.c
[ ... ]
> @@ -79,6 +80,45 @@ static void process_srcu(struct work_struct *work);
>  static void srcu_irq_work(struct irq_work *work);
>  static void srcu_delay_timer(struct timer_list *t);
> =20
> +struct srcu_defer;
> +static void srcu_defer_drain(struct irq_work *iw);
> +static void __srcu_defer_drain(struct srcu_defer *sndp, bool guard);
> +
[ ... ]
> +/*
> + * Flush pending deferred callbacks so a following srcu_barrier() waits =
for them.
> + */
> +static void srcu_defer_flush(void)
> +{
> +	int cpu;
> +
> +	if (!IS_ENABLED(CONFIG_RCU_DEFER))
> +		return;
> +
> +	for_each_possible_cpu(cpu) {
> +		struct srcu_defer *sndp =3D &per_cpu(srcu_defer, cpu);
> +
> +		if (!llist_empty(&sndp->list))
> +			__srcu_defer_drain(sndp, false);

[Severity: Critical]
Can this lockless list check lead to a use-after-free during cleanup?

If an asynchronous irq_work is concurrently executing
__srcu_defer_drain() and has already detached the list:

CPU1 (irq_work)
__srcu_defer_drain()
    raw_spin_lock_irqsave(&sndp->lock, flags);
    llist_del_all(&sndp->list);  // list is now empty

CPU2 (cleanup_srcu_struct or srcu_barrier)
srcu_defer_flush()
    llist_empty(&sndp->list) // returns true, returns immediately

Then CPU2 could return prematurely from srcu_defer_flush(), and
cleanup_srcu_struct() might free the srcu_struct while CPU1 is still
iterating through the detached callbacks and accessing sdp->ssp.

> +	}
> +}
[ ... ]
> @@ -1423,6 +1473,111 @@ static void __call_srcu(struct srcu_struct *ssp, =
struct rcu_head *rhp,
[ ... ]
> +static void __call_srcu(struct srcu_struct *ssp, struct rcu_head *rhp,
> +			rcu_callback_t func, bool do_norm)
> +{
> +	if (should_rcu_defer()) {
> +		struct srcu_defer *sndp =3D this_cpu_ptr(&srcu_defer);
> +		struct srcu_data *sdp;
[ ... ]
> +		sdp =3D this_cpu_ptr(ssp->sda);
> +		rhp->func =3D func;
> +		if (!do_norm)
> +			WRITE_ONCE(sdp->defer_exp, true);
> +		if (llist_add((struct llist_node *)rhp, &sdp->defer_cbs)) {

[Severity: Medium]
Could this flag be overwritten by a concurrent __srcu_defer_drain()?

If __call_srcu() sets sdp->defer_exp to true just as another CPU is
draining the list (e.g., from srcu_defer_flush()), can the drainer's
delayed write to sdp->defer_exp clear the flag we just set here?

CPU1
__srcu_defer_drain()
    cnode =3D llist_del_all(&sdp->defer_cbs);

CPU2
__call_srcu()
    if (!do_norm)
        WRITE_ONCE(sdp->defer_exp, true);
    llist_add(rhp, &sdp->defer_cbs);

CPU1
__srcu_defer_drain()
    do_norm =3D !READ_ONCE(sdp->defer_exp);
    if (!do_norm)
        WRITE_ONCE(sdp->defer_exp, false); // Overwrites CPU2's write

This would cause CPU2's newly enqueued expedited callback to lose its
expedited status.

> +			/*
> +			 * Chain this srcu_data for the drain.  ->ssp must be
> +			 * published here: deferral skips check_init_srcu_struct(),
> +			 * so on a never-initialized static srcu_struct the
> +			 * statically zeroed ->sda still has a NULL ->ssp.
> +			 */
> +			sdp->ssp =3D ssp;
> +			if (llist_add(&sdp->defer_link, &sndp->list))
> +				irq_work_queue(&sndp->iw);
> +		}
> +		return;
> +	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260805122346.2694=
45-1-puranjay@kernel.org?part=3D3
