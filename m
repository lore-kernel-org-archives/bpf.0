Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 684C9423A72;
	Mon, 20 Jul 2026 13:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784552845; cv=none; b=be6VWlyINzzVeNMrD3Q6ibTkbwauUVCt7QG2dHiCW0toc7M2iYKmOugpvXqWkqbp8kXBzeIisUGNjv33jhLkKot68bAAiZX75fh/qftKEpTh14zpSB+X0+SCDoxhGEJMXAXE9stgp+/gvf/ya2QAbIkMhVqs2QEgSQTpMdqMKuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784552845; c=relaxed/simple;
	bh=94jLs4pN65bI9GjrCpe4Yvvfqu5YHmUVOi6rtgwMxh0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=UCuFWiHBz/qYUpn0kXgreN4t3tFUB1PufxPaxth3k9z2aLMWxw4rurYuN1xno1yGRhAD+9V7n1dFAtkpnZr8YhhnJvervyKPyjIBbjPlaHxifT2fHEvBjx3e3IljZfkDG8j3A4Dik8YGgE65ALUTl8UeWc2UzmerbpPQ4+oEOZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T6ApG76b; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T6ApG76b"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 333EB1F00A3A;
	Mon, 20 Jul 2026 13:07:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784552839;
	bh=a2Jbx+MGZnPUeIlSJxhYdZO1D/nzfxLEcF7IxuL1wRw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=T6ApG76bt4DcZ9c7AsIpQC3j4M4EGRaUmFrZHe2uCrXA2tB76XehHv7ZOcE3BBmMN
	 7MEuZuQ4QWKpKDMmKAbUACDSYIki9v0DRZUooSyH7M8c9Yt0cWZFOkBk27Q9jknZDo
	 bzEpyxQvF5w79XpywBl9wIAi/JyEsnkaVdZ3K65/AJszGv+qf1jgjIVyYdr3R/slT6
	 AkhWqtelZv2wozANFni7727wpRyH2iIaHbL0UMeg7Bd4ikA4WvQazsaRmHrYrsN6GQ
	 R+40GyDSfIDhvfZ6qWfpvyvMU6VUzw7VzTw601bh4RBW2JBp31V9KC/ikJFLVltOQl
	 aOJDEAN09Oe6w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH slab/for-next v4 7/8] mm/slab: introduce
 kfree_rcu_nolock()
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?SGFycnkgWW9vIChPcmFjbGUp?= <harry@kernel.org>
Cc: linux-kernel@vger.kernel.org, bpf@vger.kernel.org, linux-rt-devel@lists.linux.dev
In-Reply-To: <20260720-kfree_rcu_nolock-v4-7-964e03c41a4e@kernel.org>
References: <20260720-kfree_rcu_nolock-v4-0-964e03c41a4e@kernel.org>
 <20260720-kfree_rcu_nolock-v4-7-964e03c41a4e@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 20 Jul 2026 13:07:18 +0000
Message-Id: <20260720130719.333EB1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] kfree_call_rcu_nolock() crashes with a NULL pointer dereference wh=
en given a ZERO_SIZE_PTR or an unsupported vmalloc/large kmalloc pointer.
- [High] Memory leak and cache destruction panic because deferred_work_barr=
ier() is called after flush_rcu_sheaves_on_cache().
- [High] Calling kfree_rcu_nolock() on PREEMPT_RT triggers an 'Invalid wait=
 context' lockdep warning from local_trylock().
--

--- Patch [7]: [PATCH slab/for-next v4 7/8] mm/slab: introduce kfree_rcu_no=
lock() ---
commit 278abd26e1c5865b59d3e42ddc961dd9dca8dc17
Author: Harry Yoo (Oracle) <harry@kernel.org>

mm/slab: introduce kfree_rcu_nolock()

This patch introduces the kfree_rcu_nolock() variant to handle
k[v]free_rcu() calls in unknown context. It uses kfree_rcu_sheaf() when
possible and falls back to kvfree_rcu() batching. It also adjusts barrier
placement in kvfree_rcu_barrier_on_cache().

> diff --git a/mm/slab_common.c b/mm/slab_common.c
> index c1c32909fa528..09c457645e039 100644
> --- a/mm/slab_common.c
> +++ b/mm/slab_common.c
[ ... ]
> @@ -1263,6 +1263,29 @@ EXPORT_TRACEPOINT_SYMBOL(kmem_cache_alloc);
>  EXPORT_TRACEPOINT_SYMBOL(kfree);
>  EXPORT_TRACEPOINT_SYMBOL(kmem_cache_free);
> =20
> +void kfree_call_rcu_nolock(struct kvfree_rcu_head *head, void *ptr)
> +{
> +	struct slab *slab;
> +	struct kmem_cache *s;
> +
> +	VM_WARN_ON_ONCE(is_vmalloc_addr(ptr) || !virt_to_slab(ptr));
> +
> +	slab =3D virt_to_slab(ptr);
> +	s =3D slab->slab_cache;

[Severity: High]
Does this code properly handle unsupported pointers? For example, if a call=
er
passes a 0-byte allocation (ZERO_SIZE_PTR) or a large kmalloc object,
virt_to_slab() returns NULL.=20

Since the kfree_rcu_nolock() macro only checks if the pointer evaluates to
true (and ZERO_SIZE_PTR is truthy), this would lead to a NULL pointer
dereference when accessing slab->slab_cache. Should this return early if
virt_to_slab() returns NULL instead of just warning?

> +
> +	if (unlikely(IS_ENABLED(CONFIG_NUMA) && slab_nid(slab) !=3D numa_mem_id=
()))
> +		goto fallback;
> +
> +	if (unlikely(!__kfree_rcu_sheaf(s, ptr, SLAB_FREE_NOLOCK)))

[Severity: High]
Could this trigger an 'Invalid wait context' lockdep warning on PREEMPT_RT?

The kfree_rcu_nolock() variant is intended to be safe for any context,
including under raw spinlocks or in hardirq context. However,
__kfree_rcu_sheaf() acquires s->cpu_sheaves->lock via local_trylock():

mm/slub.c:__kfree_rcu_sheaf() {
    ...
    if (!local_trylock(&s->cpu_sheaves->lock))
        goto fail;
    ...
}

On PREEMPT_RT, local_trylock() maps to a sleepable spin_trylock(). Taking
this lock from a raw spinlock or hardirq context would violate wait-type
nesting rules.

> +		goto fallback;
> +
> +	return;
> +
> +fallback:
> +	defer_kfree_rcu(head);
> +}
> +EXPORT_SYMBOL_GPL(kfree_call_rcu_nolock);
> +
[ ... ]
> @@ -2120,10 +2143,11 @@ void kvfree_rcu_barrier_on_cache(struct kmem_cach=
e *s)
>  		cpus_read_lock();
>  		flush_rcu_sheaves_on_cache(s);
>  		cpus_read_unlock();
> -		deferred_work_barrier();
> -		rcu_barrier();
>  	}
> =20
> +	/* kfree_rcu_nolock() might have deferred frees even without sheaves */
> +	deferred_work_barrier();
> +	rcu_barrier();

[Severity: High]
Can this sequence strand objects in the sheaves and cause a cache
destruction panic?

Since deferred_work_barrier() is now called after
flush_rcu_sheaves_on_cache() completes, the deferred work for objects in
objs_by_rcu will call kvfree_call_rcu().=20

If the cache has sheaves, kvfree_call_rcu() will succeed at placing those
objects back into the newly emptied sheaves:

mm/slub.c:deferred_percpu_work_fn() {
    ...
    llnode =3D llist_del_all(objs_by_rcu);
    llist_for_each_safe(pos, t, llnode) {
        ...
        kvfree_call_rcu(head, objp);
    }
    ...
}

Since there is no further sheaf flush after this repopulation, could these
objects remain stranded and cause kmem_cache_destroy() to fail with a
'Slab cache still has objects' panic?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260720-kfree_rcu_=
nolock-v4-0-964e03c41a4e@kernel.org?part=3D7
