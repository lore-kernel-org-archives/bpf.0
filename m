Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792521412;
	b=pbjYepPzEgxMpCq5qsxBTkZI6t8KfSIpYyFtx4/clbZkonXY6eKZ9I+5bA0H1o94qTj9
	 qhKnGmuIwfRGP2/inGMiH5R/WLPt4sIfwd05rPxpKn6VhQLvAyWOUPipYWLSPM7BvdL3d
	 Mw69t0o8bkTAwI03PP69dtO7hl6+NW8CFghNm3MHPUnfkRhwL/056mX1/kFThh1ERWOjw
	 yercuzVK9rT2dWpNEbpLmNXTVw4fBiwpFBWO3xkTJ/IS3nSdT7IAEBDq6DAecNr9y6ZLO
	 F8bO5pid6htLBkHROgjp1wePFVsw1zC0vup6I0S4dhjyT2obH4Kwv+qkcdB40HyQtNQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792521412;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=6XFglQIwIcQq47ucEF+Jep4VYqyQbu2yIdNWVzBU9wU=;
	b=oBJTo6IRXXYNGqVZfK+hWGGBMZGXol+4gouXAAzbd41f4IJz/mypRhmt3KD1QVhac1fY
	 cgAkZWQvsm2fyVGUsmsZ3UMi6FQ3zYFHlhe4Gxis0/uTBmP7cXLDArkHAAqgNaoFH0gLE
	 bni0AeOmaXjmmD1549hDdbszV4J8YbRuDmAR+2dDRDaW3FSq3UOTfzQRY2gKsbc4cOLQF
	 S0hcG2sa8wkYrCii4JZp1EPQh0366bhZSoyaRwbY3zxSvcsRe2k/nNYr6KIj3ZUqWp3hT
	 1S9kBFsF4jiILiZeKlgY+WuiHt9knbQ6cevP1c4uhRRylX1qug368MupJTm7gCfsLVg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dpSknhjr;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9465C606A31C
	for <bpf@vger.kernel.org>; Tue, 20 Oct 2026 18:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dpSknhjr
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 169641F000C9;
	Tue, 20 Oct 2026 18:36:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792521412;
	bh=6XFglQIwIcQq47ucEF+Jep4VYqyQbu2yIdNWVzBU9wU=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=dpSknhjr6YcL4SW4DkhiUNyvjDsqykRpK/xKU53aa09CuJ+QM7uYlQGzdhtDwIFR+
	 jjmGG6qq71Kayvx89tZYIuSYRhxI6bYj3mJkmctjQojqIreRYZ2bh6E+Gt4DyyQa3P
	 96J6901bVyxUxoG7pmi4TDKATdIUCIdKieJyWe3/p8FUmZ+81a2cZhAfuqXaCzsr/T
	 p4xbb1ht2bRX4w/NrGAf/jAWNSkMIoHCLk+povnJ5yXlLgeZK4fsyQROd2Ah3xa8jR
	 qs9RObTWKv/bTm5ldMr9KyWqP6MXSQ93Qs2QZv+m9deqx/PgtZ7JxmbPxvYAzPZkdP
	 PfOhT3M2A7cWw==
Message-ID: <sashiko-outbox-179489@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v1 3/7] selftests/bpf: libarena: Add buddy
 per-CPU caches
Reply-To: sashiko-reviews@lists.linux.dev
To: "Emil Tsalapatis" <emil@etsalapatis.com>, bpf@vger.kernel.org
In-Reply-To: <20261020181900.6755-4-emil@etsalapatis.com>
References: <20261020181900.6755-1-emil@etsalapatis.com>
 <20261020181900.6755-4-emil@etsalapatis.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 20 Oct 2026 18:36:51 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Medium] selftests/bpf: missing cache validity and NULL checks in buddy.b=
pf.c
- [Medium] selftests/bpf: missing pointer validation in buddy_cache_free()
- [Medium] selftests/bpf: out-of-bounds write in buddy_cache_state_destroy()
--

commit 8dee6e0e331ae6f1872b723dff5e251350292c90
Author: Emil Tsalapatis <emil@etsalapatis.com>

selftests/bpf: libarena: Add buddy per-CPU caches

This commit introduces per-CPU LIFO array caches in struct buddy for the
eight smallest allocation orders so small allocations and frees can bypass
the central buddy allocator lock on the fast path.

> diff --git a/tools/testing/selftests/bpf/libarena/src/buddy.bpf.c b/tools=
/testing/selftests/bpf/libarena/src/buddy.bpf.c
> index 72b9ea3ac7d53..ce05e3e58ebae 100644
> --- a/tools/testing/selftests/bpf/libarena/src/buddy.bpf.c
> +++ b/tools/testing/selftests/bpf/libarena/src/buddy.bpf.c

[ ... ]

> @@ -38,18 +42,116 @@
>   * and their allocation state. It also includes the freelist
>   * heads for the allocation itself.
>   */

[ ... ]

> +static __always_inline void __arena *
> +buddy_cache_pop(struct buddy_cache __arena *cache, int order)
> +{
> +	struct buddy_cache_order __arena *slots;
> +	void __arena *addr;
> +	u32 elems;
> +
> +	slots =3D &cache->orders[order];
> +	elems =3D READ_ONCE(slots->elems);
> +	if (!elems)
> +		return NULL;
> +
> +	addr =3D READ_ONCE(slots->objects[elems - 1]);
> +	WRITE_ONCE(slots->elems, elems - 1);
> +
> +	return addr;
> +}
> +
> +static __always_inline int buddy_cache_push(struct buddy_cache __arena *=
cache,
> +					    int order, void __arena *obj)
> +{
> +	struct buddy_cache_order __arena *slots;
> +	u32 elems;
> +
> +	slots =3D &cache->orders[order];
> +	elems =3D READ_ONCE(slots->elems);
> +	if (elems >=3D BUDDY_CACHE_CAPACITY)
> +		return -ENOMEM;
> +
> +	WRITE_ONCE(slots->objects[elems], obj);
> +	WRITE_ONCE(slots->elems, elems + 1);
> +
> +	return 0;
> +}
> +
> +void __arena *buddy_cache_alloc(struct buddy __arena *buddy, size_t orde=
r)
> +{
> +	struct buddy_cache_state __arena *state =3D &buddy->cache_state;
> +	struct buddy_cache __arena *cache;
> +	unsigned int cpu;
> +
> +	DISABLE_CACHE_IF_ASAN(NULL);
> +
> +	if (order >=3D BUDDY_CACHE_NUM_ORDERS)
> +		return NULL;
> +
> +	cpu =3D bpf_get_smp_processor_id();
> +	cache =3D state->percpu[cpu];
> +
> +	return buddy_cache_pop(cache, order);
> +}

[Severity: Medium]
Should buddy_cache_alloc() and buddy_cache_free() check that buddy is
non-NULL, that READ_ONCE(state->valid) is true, and that cache is non-NULL
before calling buddy_cache_pop() or buddy_cache_push()?

In buddy_alloc(), buddy_cache_alloc(buddy, order) is now called before
buddy_alloc_memory() checks if (!buddy):

buddy_alloc()
    order =3D size_to_order(size);
    address =3D buddy_cache_alloc(buddy, order);
    if (address)
        return address;
    return buddy_alloc_memory(buddy, size, order, 0);

Calling buddy_alloc(NULL, size) for a cached order (order <
BUDDY_CACHE_NUM_ORDERS) will therefore dereference &buddy->cache_state in
buddy_cache_alloc().

In addition, buddy_cache_state_init() and buddy_cache_state_destroy()
maintain state->valid with WRITE_ONCE(), but neither this commit nor the
follow-up commits in the series check state->valid or cache !=3D NULL in
buddy.bpf.c. If buddy_alloc() or buddy_free() is called while cache_state is
uninitialized or destroyed (where state->valid is false and
state->percpu[cpu] is NULL), buddy_cache_pop() and buddy_cache_push() will
dereference NULL at arena address 0. Because BPF exception handling on
reserved page 0 zeroes loads and ignores stores, buddy_cache_push() will
read elems as 0, ignore the stores, and return 0, causing buddy_free() to
silently drop the freed block instead of returning it to the central buddy
allocator.

> +
> +/* Retrieve the order of an allocation from the address. */
> +static int buddy_cache_get_order(void __arena *addr)
> +{
> +	struct buddy_chunk __arena *chunk;
> +	u64 idx;
> +
> +	chunk =3D (void __arena *)((u64)addr & ~BUDDY_CHUNK_OFFSET_MASK);
> +	idx =3D ((u64)addr & BUDDY_CHUNK_OFFSET_MASK) / BUDDY_MIN_ALLOC_BYTES;
> +
> +	return idx_get_order(chunk, idx);
> +}
> +
> +int buddy_cache_free(struct buddy __arena *buddy, void __arena *addr)
> +{
> +	struct buddy_cache_state __arena *state =3D &buddy->cache_state;
> +	struct buddy_cache __arena *cache;
> +	unsigned int cpu;
> +	int order;
> +
> +	DISABLE_CACHE_IF_ASAN(-EINVAL);
> +
> +	order =3D buddy_cache_get_order(addr);
> +	if (order >=3D BUDDY_CACHE_NUM_ORDERS)
> +		return -EINVAL;
> +
> +	cpu =3D bpf_get_smp_processor_id();
> +	cache =3D state->percpu[cpu];
> =20
> +	return buddy_cache_push(cache, order, addr);
> +}

[Severity: Medium]
What prevents buddy_cache_free() from accepting unaligned, interior, or
unallocated pointers before buddy_free_unlocked() can validate them?

In buddy_free(), buddy_cache_free() is invoked prior to
buddy_free_unlocked():

buddy_free()
    ret =3D buddy_cache_free(buddy, addr);
    if (!ret)
        return 0;
    ...
    ret =3D buddy_free_unlocked(buddy, (u64)addr);

While buddy_free_unlocked() checks that addr is aligned to
BUDDY_MIN_ALLOC_BYTES and verifies that idx is marked allocated via
idx_set_allocated(chunk, idx, false), buddy_cache_get_order() divides by
BUDDY_MIN_ALLOC_BYTES and reads idx_get_order(chunk, idx) without checking
either alignment or chunk->allocated.

When a chunk is initialized in buddy_chunk_get(), chunk->orders is
zero-initialized, and buddy_chunk_alloc() only sets the order and allocated
bit at the head index idx of each allocated block (advancing by idx +=3D 1U=
 <<
order_req), leaving interior sub-block indices with allocated =3D=3D 0 and
order =3D=3D 0.

If a caller passes an interior pointer such as
(u8 __arena *)alloc_path_test.bulk[i] + BUDDY_MIN_ALLOC_BYTES (as tested by
test_buddy_cache_paths() in the follow-up commit "selftests/bpf: libarena:
Cover buddy cache fast paths"), buddy_cache_get_order() reads order 0 at
idx + 1, and buddy_cache_free() pushes the interior pointer into the order-0
per-CPU cache and returns 0 instead of failing with -EINVAL. Likewise, an
unaligned pointer inside an allocated cached-order block has its low bits
truncated by the division in buddy_cache_get_order() and is pushed unaligned
into the per-CPU cache, corrupting subsequent buddy_alloc() returns.

[ ... ]

> @@ -557,6 +659,46 @@ static struct buddy_chunk __arena *buddy_chunk_get(s=
truct buddy __arena *buddy)
>  	return chunk;
>  }
> =20
> +static int buddy_cache_state_init(struct buddy __arena *buddy)
> +{
> +	struct buddy_cache_state __arena *state =3D &buddy->cache_state;
> +	struct buddy_cache __arena *cache;
> +	unsigned int cpu, order;
> +	int ret;
> +
> +	DISABLE_CACHE_IF_ASAN(0);
> +
> +	if (CONFIG_NR_CPUS > BUDDY_CACHE_MAX_CPUS)
> +		return -E2BIG;
> +
> +	WRITE_ONCE(state->valid, false);
> +
> +	for (cpu =3D zero; cpu < CONFIG_NR_CPUS && can_loop; cpu++) {
> +		ret =3D buddy_alloc_bulk(buddy, sizeof(*cache), 0,
> +				       (void __arena * __arena *)&state->percpu[cpu]);
> +		if (ret)
> +			return ret;
> +
> +		cache =3D state->percpu[cpu];
> +		for (order =3D zero; order < BUDDY_CACHE_NUM_ORDERS && can_loop; order=
++)
> +			WRITE_ONCE(cache->orders[order].elems, 0);
> +	}
> +
> +	WRITE_ONCE(state->valid, true);
> +
> +	return 0;
> +}
> +
> +static void buddy_cache_state_destroy(struct buddy __arena *buddy)
> +{
> +	struct buddy_cache_state __arena *state =3D &buddy->cache_state;
> +	unsigned int cpu;
> +
> +	WRITE_ONCE(state->valid, false);
> +	for (cpu =3D zero; cpu < CONFIG_NR_CPUS && can_loop; cpu++)
> +		WRITE_ONCE(state->percpu[cpu], NULL);
> +}

[Severity: Medium]
Can buddy_cache_state_destroy() overflow state->percpu[] when CONFIG_NR_CPUS
is greater than BUDDY_CACHE_MAX_CPUS (1024)?

While buddy_cache_state_init() checks if (CONFIG_NR_CPUS >
BUDDY_CACHE_MAX_CPUS) and returns -E2BIG, buddy_init() handles that failure
by calling buddy_destroy() -> buddy_cache_state_destroy():

buddy_init()
    ret =3D buddy_cache_state_init(buddy);
    if (ret) {
        buddy_destroy(buddy);
        return ret;
    }

In addition, arena_buddy_destroy() and arena_buddy_reset() in common.bpf.c
call buddy_destroy() directly before buddy_init(). Since
buddy_cache_state_destroy() loops up to CONFIG_NR_CPUS without bounding
against BUDDY_CACHE_MAX_CPUS, won't it write past the end of
state->percpu[BUDDY_CACHE_MAX_CPUS] and clobber adjacent arena memory on
kernels built with CONFIG_NR_CPUS > 1024?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261020181900.6755=
-1-emil@etsalapatis.com?part=3D3
