Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D16B23ACA48;
	Mon, 15 Jun 2026 11:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781522652; cv=none; b=mZ1rnF2oSU2sv8OpKxaFsQoAmEvWhQw7cqIMd5nNiIaiZr27AzRxPACcpIv1uJbxbV4FJ016YzKJfJcisATm1R2xls45sfOBiJza06qxiQGD3XJDTb/hgzMXqvFnMV35cMeGRQs2oUbe0m9VLBoxN9UJBWiAM4PddAzs8+t4W3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781522652; c=relaxed/simple;
	bh=CRCKM8+d+hqXC7oxRsDwn8sSebB1DLsNE8Wje/NI8OA=;
	h=From:Subject:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Q4NIeDA5TRi/vd/k+DYP9C4ei/aRSjFRbGdkOZ4x7sWC5OdW6qkdFckkeurZSgVRA8XVqhdu4UNPjV+PNLGaKbsu1p3/C8uAJ+XW6DMMo2WTCXvjn6A1oLaX1x3Qlk0dYjhJxGjqZ0pgQuVBEzryu7SRJPzcW6Ohl5pOAc1k1zI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dwJ9tFCL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dwJ9tFCL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D84E1F000E9;
	Mon, 15 Jun 2026 11:24:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781522651;
	bh=zzw0wFdT3c5yzOHZ0Q4UY3n1QZNL3BThpmX/Tfc5m6U=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=dwJ9tFCL59E7WaeBb18Dd2HpiN6nUocj3p/bUd1vl+5Y5Ib/U5hnOwm/lPiCHTp5b
	 OuKcFl0zF1QndqorTQGnUoqFLVNsjzMTivw7/wnasj8T+v2Op0dJFtlvDjAW/ZxfnH
	 QEuN49kOdBHsvFWfhV0ad86RZy+Q70P6ynd6Vah+dtDydarHv79fHMKoQ5Yzz32zjs
	 GsKyoSa9DIgi0DIbaM3Ddl8eR1tJrwBw6F63dsUJAUcgfzjcChhj10AMAaCkWDwTZf
	 b4+UGKMlJ+TOV9wfww0ZMJyQIDTgf+0x4z9Ie/hbIp9BzfL/1bYRGWWgb/A6z8oUi2
	 eTgO4POPf+ECQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH for-next v3 5/9] mm/slab: extend deferred free mechanism
 to handle rcu sheaves
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-rt-devel@lists.linux.dev, linux-kernel@vger.kernel.org, bpf@vger.kernel.org
In-Reply-To: <20260615-kfree_rcu_nolock-v3-5-70a54f3775bb@kernel.org>
References: <20260615-kfree_rcu_nolock-v3-5-70a54f3775bb@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 15 Jun 2026 11:24:10 +0000
Message-Id: <20260615112411.2D84E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] Acquiring local_trylock inside __kfree_rcu_sheaf() violates lock n=
esting rules on PREEMPT_RT, triggering a lockdep "Invalid wait context" war=
ning.

Pre-existing issues:
- [High] Concurrent lockless calls to deferred_work_barrier() cause an rcuw=
ait race on PREEMPT_RT, leading to permanent task hangs.
--

commit b0c903d6396ede7c44ac45135ec7adc7d173391f
Author: Harry Yoo (Oracle) <harry@kernel.org>
Subject: mm/slab: extend deferred free mechanism to handle rcu sheaves

This patch extends the deferred free fallback mechanism so that a full RCU
sheaf can be submitted to call_rcu() via the existing IRQ work when spinning
is not allowed and IRQs are disabled. It also renames the defer_free structs
to deferred_percpu_work and adds deferred_work_barrier() calls to keep the
kvfree_rcu barrier's promise.

> diff --git a/mm/slub.c b/mm/slub.c
> index 6a3552b70683d..ba593c1c53d50 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
[ ... ]
> @@ -6158,12 +6175,6 @@ bool __kfree_rcu_sheaf(struct kmem_cache *s, void =
*obj, bool allow_spin)
>  	if (likely(rcu_sheaf->size < s->sheaf_capacity)) {
>  		rcu_sheaf =3D NULL;
>  	} else {

[Severity: High]
Does acquiring local_trylock inside __kfree_rcu_sheaf() violate lock nesting
rules on PREEMPT_RT?

The kvfree_call_rcu() API is frequently invoked from hardirq context or whi=
le
holding a raw_spinlock_t.  This function attempts to acquire a local_tryloc=
k:

    if (!local_trylock(&s->cpu_sheaves->lock))

On PREEMPT_RT kernels, local_trylock_t maps to a sleepable spinlock_t.
Attempting to acquire a sleepable lock (even via a trylock operation) while=
 in
a raw_spinlock or hardirq context violates the lock nesting rules.
CONFIG_PROVE_RAW_LOCK_NESTING will catch this and trigger a lockdep warning
for an invalid wait context.

> -		/* call_rcu() disables IRQs to protect percpu data structures */
> -		if (unlikely(!allow_spin && irqs_disabled())) {
> -			rcu_sheaf->size--;
> -			local_unlock(&s->cpu_sheaves->lock);
> -			goto fail;
> -		}
>  		pcs->rcu_free =3D NULL;
>  		rcu_sheaf->node =3D numa_node_id();
>  	}
[ ... ]
> @@ -6408,27 +6418,34 @@ static void free_deferred_objects(struct irq_work=
 *work)
[ ... ]
>  static void defer_free(struct kmem_cache *s, void *head)
>  {
> -	struct defer_free *df;
> +	struct deferred_percpu_work *dpw;
> =20
>  	guard(preempt)();
> =20
>  	head =3D kasan_reset_tag(head);
> =20
> -	df =3D this_cpu_ptr(&defer_free_objects);
> -	if (llist_add(head + s->offset, &df->objects))
> -		irq_work_queue(&df->work);
> +	dpw =3D this_cpu_ptr(&deferred_percpu_work);
> +	if (llist_add(head + s->offset, &dpw->objects))
> +		irq_work_queue(&dpw->work);
>  }
> =20
> -void defer_free_barrier(void)
> +void deferred_work_barrier(void)
>  {
>  	int cpu;
> =20
>  	for_each_possible_cpu(cpu)
> -		irq_work_sync(&per_cpu_ptr(&defer_free_objects, cpu)->work);

[Severity: High]
This is a pre-existing issue, but can concurrent lockless calls to
deferred_work_barrier() cause an rcuwait race on PREEMPT_RT, leading to
permanent task hangs?

The function iterates over all CPUs, invoking irq_work_sync() on each CPU's
deferred work object. On PREEMPT_RT, irq_work_sync() relies on
rcuwait_wait_event() to block until completion, and the rcuwait
synchronization primitive strictly allows only one waiter at a time.

Because deferred_work_barrier() is called without any global serialization
(for instance, in kmem_cache_destroy() and kvfree_rcu_barrier_on_cache(),
and now in flush_all_rcu_sheaves()), multiple threads can enter
irq_work_sync() for the same work object concurrently.

This overwrites the waiter task pointer, meaning only one task will be woken
up when the work completes, leaving the other tasks hanging permanently in =
an
uninterruptible sleep.

> +		irq_work_sync(&per_cpu_ptr(&deferred_percpu_work, cpu)->work);
>  }
> =20
>  static __fastpath_inline

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260615-kfree_rcu_=
nolock-v3-0-70a54f3775bb@kernel.org?part=3D5
