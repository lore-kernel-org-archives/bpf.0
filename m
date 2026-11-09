Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794249530;
	b=Qs9hK4eP8O+goeTqI0jasWK3dasf86rY66vRg5I5VuiYsnw7oYBe5zCOP3ZRgUs/D/+6
	 fussUX++tV2BGvAnqlYqzy8N1u8hreH/OApsC2PMT1cy5bUpyt0PxZS0pMUIhnO/+oNwq
	 E5ABnXvrqoCuQE7Cl4R6j2jzg+LExsiCyDQ7Xi2hAS248TL9rhZ5ZzSAS1om7OdC1k7cd
	 TCpixKQJtE2jzVg2GoR2sWQKqULY4F3KkugB7RYH2ElrN+WTlw6w3E0VTPmfosVokwW4a
	 3USFl3vKbwp+iEVfluuoG08WDfwiBwhIkXFrEVsAiubdP5VUTk2tVEa7G5urZZpVZqw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794249530;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=1zhlkafNEx7/8hMmBDuxwXYXpRV7yfzqoGfHgJCrjVQ=;
	b=x7SeMN3Vo377+Tv+PfR8Ve2cMMkaYMwqjTBN9K1zAPcO3bmzhzcy1Y1lWAeRrUD7K+Y4
	 zosesciJ75ehKSIwAb/uupzs/ykpeGNR8gnlYqiSn1BrF7kV1ftRwHHpkRCpAbvuO+kcG
	 dnqWTo+hrby9ZVnc5GegoKEXT2VVecEr9JGjCAhJWgIsi9oRWRT6F9j/8fKo4c/xDbOsG
	 oYHztoFV1JV6qaTwOZ9uL6XwoD15TNU1OPmU26lBMSJBGbFn/1BWuG3eDB8P5ug5hfnK0
	 Rl8Dkif6gQTgi4ScHjelAfrq8H5avfo4kKfH5kGUBjCeLhC31RRBP6SrJXHjwJDvaVQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="m/orSgzb";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C0DC606A321
	for <bpf@vger.kernel.org>; Mon,  9 Nov 2026 18:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=m/orSgzb
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61A0B1F008A1;
	Mon,  9 Nov 2026 18:38:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794249529;
	bh=1zhlkafNEx7/8hMmBDuxwXYXpRV7yfzqoGfHgJCrjVQ=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=m/orSgzb+tWzyEQfdodBWxwxNteXMmbSQBosJJYaATsravM+A0g8yBwlZPO337Wqy
	 2946oC9gWhvnRWZbG9TXx60HnbuZELCSB9tsZjSmSO2762XAqe/uI7v6FHgsqNC1sF
	 LlbaIEMj1099VslXwHSsa07nIZbPtLlfvKuEXOnxKMxLpYvNMhYpqrif6SwegldnG/
	 w7SP8Jw06Z0IjX3IcSGQCu7HneA+raP4qmZIy8ADFOLRlGcM+iHR2Bp7myTJuUhaCg
	 J0hHrcK1QUTEVALAi0tj7wauvQcnuSJhGAU4AGX/1xP7rjprhYSpm5LKDFlYzOB4g3
	 RJbXRG9W27xgQ==
Message-ID: <sashiko-outbox-205430@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v4 5/9] selftests/bpf: libarena: Add buddy
 per-CPU caches
Reply-To: sashiko-reviews@lists.linux.dev
To: "Emil Tsalapatis" <emil@etsalapatis.com>, bpf@vger.kernel.org
In-Reply-To: <20261109182055.7581-6-emil@etsalapatis.com>
References: <20261109182055.7581-1-emil@etsalapatis.com>
 <20261109182055.7581-6-emil@etsalapatis.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Nov 2026 18:38:48 +0000
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
- [Medium] selftests/bpf: conflicting prototype for buddy_alloc_memory()
- [Low] selftests/bpf: buddy_alloc_nogrow() bypasses buddy_cache_alloc()
- [Low] selftests/bpf: missing static on buddy_cache_alloc() and
  buddy_cache_free()
--

commit 2da1f713f762ba4737b95c532cd5e6f183f3f061
Author: Emil Tsalapatis <emil@etsalapatis.com>

selftests/bpf: libarena: Add buddy per-CPU caches

This commit adds per-CPU LIFO array caches to the libarena buddy allocator
for the eight smallest allocation orders so small allocations and frees can
avoid taking the central buddy lock.

> diff --git a/tools/testing/selftests/bpf/libarena/src/buddy.bpf.c b/tools=
/testing/selftests/bpf/libarena/src/buddy.bpf.c
> index 514d0a59eaff5..13c55cf53e524 100644
> --- a/tools/testing/selftests/bpf/libarena/src/buddy.bpf.c
> +++ b/tools/testing/selftests/bpf/libarena/src/buddy.bpf.c
> @@ -38,18 +41,162 @@
>   * and their allocation state. It also includes the freelist
>   * heads for the allocation itself.
>   */
> +static u8 idx_get_order(struct buddy_chunk __arena *chunk, u64 idx);
> +static int idx_is_allocated(struct buddy_chunk __arena *chunk, u64 idx, =
bool *allocated);
> +static u64 arena_next_pow2(__u64 n);
> +static u64 size_to_order(size_t size);
> +static void __arena *buddy_alloc_memory(struct buddy __arena *buddy, siz=
e_t size,
> +					int order, size_t norder);
> +static int buddy_free_unlocked(struct buddy __arena *buddy, u64 addr);

[Severity: Medium]
Does this forward declaration of buddy_alloc_memory() break the build at
this commit?  It omits the fifth parameter (bool grow) from the definition:

tools/testing/selftests/bpf/libarena/src/buddy.bpf.c:
static void __arena *buddy_alloc_memory(struct buddy __arena *buddy, size_t=
 size,
		int order, size_t norder, bool grow)

Although the later commit "selftests/bpf: libarena: Handle NMI reentrancy"
adds bool grow to the prototype, this commit fails to compile with
conflicting types and breaks bisection.  Note also that buddy_alloc_memory(=
),
arena_next_pow2(), size_to_order() and buddy_free_unlocked() are not called
before their definitions in this patch.

[ ... ]

> +void __arena *buddy_cache_alloc(struct buddy __arena *buddy, size_t orde=
r)
> +{
> +	struct buddy_cache __arena *cache;
> +	void __arena *address =3D NULL;
> +
> +	if (!buddy_order_cached(order))
> +		return NULL;
> +
> +	cache =3D buddy_cache_enter(buddy);
> +	if (!cache)
> +		return NULL;
> +
> +	address =3D buddy_cache_pop(cache, order);
> +	buddy_cache_exit(cache);
> +
> +	return address;
> +}
> +
> +/*
> + * Retrieve the order of an allocation from the address. Reject addresses
> + * that do not start an allocated block so that the locked path can repo=
rt
> + * them, instead of caching memory that overlaps a live allocation. Cach=
ed
> + * objects stay marked as allocated, so freeing an object that is already
> + * cached is not detected.
> + */
> +static int buddy_cache_get_order(void __arena *addr)
> +{
> +	struct buddy_chunk __arena *chunk;
> +	bool allocated;
> +	u64 idx;
> +
> +	if ((u64)addr & (BUDDY_MIN_ALLOC_BYTES - 1))
> +		return BUDDY_CHUNK_NUM_ORDERS;
> =20
> +	chunk =3D (void __arena *)((u64)addr & ~BUDDY_CHUNK_OFFSET_MASK);
> +	idx =3D ((u64)addr & BUDDY_CHUNK_OFFSET_MASK) / BUDDY_MIN_ALLOC_BYTES;
> +
> +	if (idx_is_allocated(chunk, idx, &allocated) || !allocated)
> +		return BUDDY_CHUNK_NUM_ORDERS;
> +
> +	return idx_get_order(chunk, idx);
> +}
> +
> +__always_inline int buddy_cache_free(struct buddy __arena *buddy, void _=
_arena *addr)

[Severity: Low]
Should buddy_cache_alloc() and buddy_cache_free() be marked static like the
other internal cache helpers in buddy.bpf.c?  Neither helper is declared in
buddy.h or referenced outside this file, and omitting static prevents
buddy_cache_alloc() from being inlined as a local helper into buddy_alloc().

[ ... ]

> @@ -819,7 +1012,18 @@ static void __arena *buddy_alloc_memory(struct budd=
y __arena *buddy, size_t size
>  __weak
>  void __arena *buddy_alloc(struct buddy __arena *buddy, size_t size)
>  {
> -	return buddy_alloc_memory(buddy, size, size_to_order(size), 0, true);
> +	void __arena *address;
> +	int order;
> +
> +	if (!buddy)
> +		return NULL;
> +
> +	order =3D size_to_order(size);
> +	address =3D buddy_cache_alloc(buddy, order);
> +	if (address)
> +		return address;
> +
> +	return buddy_alloc_memory(buddy, size, order, 0, true);
>  }
> =20
>  __weak

[Severity: Low]
Should buddy_alloc_nogrow() also check buddy_cache_alloc() before falling
back to buddy_alloc_memory()?

tools/testing/selftests/bpf/libarena/src/buddy.bpf.c:
__weak
void __arena *buddy_alloc_nogrow(struct buddy __arena *buddy, size_t size)
{
	return buddy_alloc_memory(buddy, size, size_to_order(size), 0, false);
}

When buddy_free() caches a small object, the object stays marked allocated
and off the chunk freelists.  Because buddy_alloc_nogrow() calls
buddy_alloc_memory() directly, it always takes the central buddy lock and
can return NULL when the chunk freelists are empty even though free objects
of the requested order are sitting in the local per-CPU cache.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261109182055.7581=
-1-emil@etsalapatis.com?part=3D5
