Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794249752;
	b=TInvI1TXTI26kHn8Y1bbYGHCGjDOW0pzVpRmRefc/kvtAouVOtExa0O54F8S+XIsSKjN
	 23T+V/B7EeDInfk52mKe1Oz0iocqXi3PWsYfLNp+H5c6iZGgj7lfivZmhkvIaJ4E/q0V4
	 993uN/hwBmlw0w0A14bfJ1xQFn45CypZkWmeoMv8ra6vs3EyfBxXnWkRuiDTjJobucQQU
	 pxBgublJdiQ18SZPQhSWaGkg5Ig/f8xwfYcp8O8HdTO6KUKGA7L9p7At07WfXw2aZQHkI
	 KWvjmPtnJIORxvW7DJjQnp08nKfUOgEy5Gq2mZuuFWGtOmSR/JkxrC8pqBv/97N+BhQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794249752;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=0Dg/cAQPuYtcmxQb14Z2pEjRiO0lslVnPskLtv97mXY=;
	b=nrJ5iQwxOr1423H8KOsPFMZkCluUL8Ps2pw2AJ3mUCEk67NJsLHZGjd0J7AdfGbL11ry
	 4KiAtnzDQtz/WWd4RJOWuG+aV74lwD9V+5SbQ395vyyJ4PyDn8TQno3uLsCR38nhLo4gm
	 FUVTH0/De7X1RlVnuaMjVS7HTT/3saxuVsrFRzlmC5SVEmLoqDU+dg/WcYe5Sm8nYOHpJ
	 Bu+vIS1JigF29UGRTVNvRxK6H/J/hSGONeR2p2Sb9TCmOb2vXCV5AavK4dNEjQr4fCBiM
	 1YsW1Os60U3JqyxGPkidxeIf3UaKYhHZ9hL1hHene64iFk0avDmy/XOr3ck0CPv/Itg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UJ+XoitN;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32D7E606A321
	for <bpf@vger.kernel.org>; Mon,  9 Nov 2026 18:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UJ+XoitN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EE531F0089F;
	Mon,  9 Nov 2026 18:42:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794249751;
	bh=0Dg/cAQPuYtcmxQb14Z2pEjRiO0lslVnPskLtv97mXY=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=UJ+XoitN89DAhJF9ISOVeznqTYvbNyo8++OhqxsGSWOwIIMXlEFlOQma1w5CalkMr
	 Q7cHmmQuIYRGuAHneiFO2Z9H/It7YKkWNf6Yq7WKuq7uFsLdZWt0RBx0p4E1WNruDQ
	 dAxSERrfftXgYRVHS8feRBnn9ipl5AmBoWz2UBM9jQSeBQiG5EJx16Tva6i4VvPUnR
	 h5sE6Jhi55REXu+0lpVskLhRMWIuBIgvE+PGB1hteNb8RH8cHqhwCeyRq/NFDWzz9n
	 z26TkxI9kzDLopx7L+cfJLXPRpjkV8hzp2uRP1hZU/lzJh5hDNnI58fYmKUKHTaqXK
	 efetARkH7Hgkw==
Message-ID: <sashiko-outbox-205433@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v4 6/9] selftests/bpf: libarena: Handle NMI
 reentrancy
Reply-To: sashiko-reviews@lists.linux.dev
To: "Emil Tsalapatis" <emil@etsalapatis.com>, bpf@vger.kernel.org
In-Reply-To: <20261109182055.7581-7-emil@etsalapatis.com>
References: <20261109182055.7581-1-emil@etsalapatis.com>
 <20261109182055.7581-7-emil@etsalapatis.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Nov 2026 18:42:31 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 3 potential
issues to consider:
- [Medium] selftests/bpf: buddy_alloc_memory() grows allocator in NMI
  context
- [Medium] selftests/bpf: unvalidated write and error propagation in
  deferred free
- [Low] selftests/bpf: deferred frees stay unpoisoned in
  buddy_deferred_free_start()
--

commit 88f6bdc1e521e6f215ca4ea48a935038a6d8cf00
Author: Emil Tsalapatis <emil@etsalapatis.com>

selftests/bpf: libarena: Handle NMI reentrancy

This commit switches the libarena buddy allocator to use trylock in NMI
context and defers frees to an intrusive list when the buddy lock cannot be
acquired.

> diff --git a/tools/testing/selftests/bpf/libarena/src/buddy.bpf.c b/tools=
/testing/selftests/bpf/libarena/src/buddy.bpf.c
> index 13c55cf53e524..4d4d21356935d 100644
> --- a/tools/testing/selftests/bpf/libarena/src/buddy.bpf.c
> +++ b/tools/testing/selftests/bpf/libarena/src/buddy.bpf.c
[ ... ]
> @@ -46,10 +47,14 @@ static int idx_is_allocated(struct buddy_chunk __aren=
a *chunk, u64 idx, bool *al
>  static u64 arena_next_pow2(__u64 n);
>  static u64 size_to_order(size_t size);
>  static void __arena *buddy_alloc_memory(struct buddy __arena *buddy, siz=
e_t size,
> -					int order, size_t norder);
> +					int order, size_t norder, bool grow);
>  static int buddy_free_unlocked(struct buddy __arena *buddy, u64 addr);
> +static bool buddy_deferred_free_pending(struct buddy __arena *buddy);
> +static int buddy_deferred_free_complete(struct buddy __arena *buddy);
> =20
> -#define buddy_lock(buddy, flags) (arena_spin_lock_irqsave(&(buddy)->lock=
, (flags)))
> +#define buddy_lock(buddy, flags)						\
> +	(bpf_in_nmi() ? arena_spin_trylock_irqsave(&(buddy)->lock, (flags)) :	\
> +			arena_spin_lock_irqsave(&(buddy)->lock, (flags)))
>  #define buddy_unlock(buddy, flags) (arena_spin_unlock_irqrestore(&(buddy=
)->lock, (flags)))

[Severity: Medium]
Can buddy_alloc_memory() still call buddy_chunk_get() to grow the allocator
when bpf_in_nmi() is true?

When an allocation in NMI context misses the per-cpu cache and existing
chunks, buddy_alloc_memory() calls buddy_chunk_get():

tools/testing/selftests/bpf/libarena/src/buddy.bpf.c:buddy_chunk_get() {
    ...
	ret =3D buddy_alloc_arena_vaddr(buddy, &vaddr);
	if (ret)
		return NULL;
    ...
	/* Unreserve the address space. */
	bpf_arena_free_pages(&arena, (void __arena *)vaddr,
			     BUDDY_CHUNK_PAGES);

	chunk =3D bpf_arena_alloc_pages(&arena, (void __arena *)vaddr,
				      BUDDY_CHUNK_PAGES, NUMA_NO_NODE, 0);
    ...
}

Because NMI programs are non-sleepable, bpf_arena_free_pages() defers
unreservation to a workqueue via irq_work instead of updating the arena
range tree synchronously.  The immediately following bpf_arena_alloc_pages()
at vaddr then always fails because the range is still marked reserved,
logging an allocation failure and leaking 1 MiB of buddy->vaddr address
space per attempt.  Should buddy_alloc_memory() avoid calling
buddy_chunk_get() when bpf_in_nmi() is true?

[ ... ]

> @@ -970,6 +977,13 @@ static void __arena *buddy_alloc_memory(struct buddy=
 __arena *buddy, size_t size
>  	if (buddy_lock(buddy, flags))
>  		return NULL;
> =20
> +	if (unlikely(buddy_deferred_free_pending(buddy))) {
> +		if (buddy_deferred_free_complete(buddy)) {
> +			buddy_unlock(buddy, flags);
> +			return NULL;
> +		}
> +	}
> +
>  	address =3D (u8 __arena *)buddy_alloc_from_existing_chunks(buddy, order=
, norder);
>  	buddy_unlock(buddy, flags);
>  	if (address)
> @@ -1176,10 +1190,90 @@ static __always_inline int buddy_free_unlocked(st=
ruct buddy __arena *buddy, u64
>  	return 0;
>  }
> =20
> +static bool buddy_deferred_free_pending(struct buddy __arena *buddy)
> +{
> +	return buddy->deferred_free !=3D NULL;
> +}
> +
> +static __always_inline void buddy_deferred_free_push(struct buddy __aren=
a *buddy,
> +						   void __arena *first, void __arena *last)
> +{
> +	void __arena *head;
> +
> +	do {
> +		head =3D READ_ONCE(buddy->deferred_free);
> +		*(void __arena * __arena *)last =3D head;
> +	} while (cmpxchg((void __arena * __arena *)&buddy->deferred_free,
> +			 head, first) !=3D head && can_loop);
> +}
> +
> +static void buddy_deferred_free_start(struct buddy __arena *buddy, void =
__arena *addr)
> +{
> +	/*
> +	 * Make a linked list by chaining the allocations into a linked list.
> +	 * Possible because allocations are 16 bytes minimum and so fit a point=
er.
> +	 */
> +	asan_unpoison(addr, sizeof(void *));
> +	buddy_deferred_free_push(buddy, addr, addr);
> +}
> +
> +static void buddy_deferred_free_start_bulk(struct buddy __arena *buddy,
> +		 void __arena * __arena *addrs, size_t naddrs)
> +{
> +	void __arena *first, *last, *addr;
> +	unsigned int i;
> +
> +	/*
> +	 * Chain the allocations into a local linked list. Possible because
> +	 * allocations are 16 bytes minimum and so fit a pointer.
> +	 */
> +	first =3D NULL;
> +	last =3D NULL;
> +	for (i =3D zero; i < naddrs && can_loop; i++) {
> +		addr =3D addrs[i];
> +		if (!addr)
> +			continue;
> +
> +		asan_unpoison(addr, sizeof(void *));
> +
> +		if (!first)
> +			first =3D addr;
> +		else
> +			*(void __arena * __arena *)last =3D addr;
> +
> +		last =3D addr;
> +	}
> +
> +	if (!first)
> +		return;
> +
> +	/* Splice the local list onto the deferred-free list. */
> +	buddy_deferred_free_push(buddy, first, last);
> +}

[Severity: Low]
Does buddy_deferred_free_start() leave deferred objects unpoisoned in the
asan shadow map until buddy_deferred_free_complete() runs?

Both buddy_deferred_free_start() and buddy_deferred_free_start_bulk() call
asan_unpoison(addr, sizeof(void *)) and leave the freed object (including
any padding bytes in the first 8 bytes when the allocation size was under 8
bytes) unpoisoned while it sits on buddy->deferred_free.  Use-after-free
accesses during that window will not be caught by asan, and writes to the
first 8 bytes can corrupt the intrusive list pointer without triggering an
asan violation.

> +
> +static int buddy_deferred_free_complete(struct buddy __arena *buddy)
> +{
> +	void __arena *head, *old;
> +	int ret =3D 0, err;
> +
> +	head =3D __sync_lock_test_and_set((void __arena * __arena *)&buddy->def=
erred_free,
> +					NULL);
> +
> +	while (head && can_loop) {
> +		old =3D head;
> +		head =3D *(void __arena * __arena *)head;
> +
> +		err =3D buddy_free_unlocked(buddy, (u64)old);
> +		ret =3D ret ?: err;
> +	}
> +
> +	return ret;
> +}
> +
>  __weak int buddy_free(struct buddy __arena *buddy, void __arena *addr)
>  {
>  	unsigned long flags;
> -	int ret;
> +	int ret, err;
> =20
>  	if (!buddy)
>  		return -EINVAL;
> @@ -1193,20 +1287,28 @@ __weak int buddy_free(struct buddy __arena *buddy=
, void __arena *addr)
>  		return 0;
> =20
>  	ret =3D buddy_lock(buddy, flags);
> -	if (ret)
> -		return ret;
> +	if (ret) {
> +		buddy_deferred_free_start(buddy, addr);
> +		return 0;
> +	}
> =20
>  	ret =3D buddy_free_unlocked(buddy, (u64)addr);
> =20
> +	/* Drain any frees stranded during NMI/lock failure. */
> +	if (unlikely(buddy_deferred_free_pending(buddy))) {
> +		err =3D buddy_deferred_free_complete(buddy);
> +		ret =3D ret ?: err;
> +	}
> +
>  	buddy_unlock(buddy, flags);
> =20
>  	return ret;
>  }

[Severity: Medium]
Can buddy_deferred_free_start() and buddy_deferred_free_start_bulk()
overwrite memory before validating that the address is an allocated block?

Unlike buddy_cache_free(), which checks alignment and allocation state via
buddy_cache_get_order() before touching the block, the deferred-free paths
unpoison and write the next pointer directly into *(void __arena * __arena =
*)addr
when buddy_lock() fails.  Passing an unaligned, interior,already-freed, or
duplicate address while the lock is contended corrupts 8 bytes at addr or
creates a cycle in buddy->deferred_free.

In addition, when buddy_deferred_free_complete() later drains an invalid
entry, propagating its error causes buddy_alloc_memory() to abort and return
NULL for an unrelated allocation, and causes buddy_free() to return an error
even when the current caller's addr was freed without issue.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261109182055.7581=
-1-emil@etsalapatis.com?part=3D6
