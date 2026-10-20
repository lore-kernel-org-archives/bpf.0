Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792521346;
	b=j9GoZ0CXXPIKAe6ywloF+jwQVWFOJ3GCc5Ecm7Wz2/3vEPoys5OtbJ5EKIbJO7yloT1Z
	 vSe8j3hCdRat8BV8WpiC9yIVJHpxfd2WigdP33GfGHKdfqAo4jtQAdb7WsiebOCgHkmmu
	 OR5PO4nIf+2oRYOU7WQBxX2A5lhnXlR//lry5xXPIuLVFDBYpwWWeAvSAuEVdMHV2MxVI
	 9PUQmYkIcXpSmoZJIhMUnfIFeKV+a61MMsjeFTqCubOzISwE5qfWaPL1M+6BytcPN+0T5
	 b7ZAd4Ml80tzCzIMAeyjdfdbYuFs+lrZKpcw1uosxrpCrasPgkQRCmRyjp/ZYfUHIZA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792521346;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=SPkJeF9RtTy9wB3sPO422VPUe4VfMZVv+6S5vhenFQk=;
	b=MtHO+UG2YDA3fED3BoUsL6cwKnrT46KC+BcBam/FJzw5xhxTvt/ALAc3B7TIokE+zwr3
	 Vgq4Ab0LZ9ZENvwPPJuZWIW0haq+zb3JiwG3Ga7R2DAJs604DMpb40R9jVFCMe+nFp4N7
	 hYkwoj2NXHCaNuJGibY6grGfIvYqQLFbMQQeDKVYgUgRpOqo4HnJrTL4o3NbUy2E3kEwh
	 ldcSdsWdXer5QjtSi6yzI+P4vVMGrhEaisfKIadjKNZ99YPoNjacqxsEhQcxfyYi1qput
	 mmc4jMSkuEH8Lg7b4NpPVF3ygAfmNDPDzfKu2eW+xTsJs20aDxnfjdssPUKrmUbF0iw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mcB87y+X;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5E13606A31B
	for <bpf@vger.kernel.org>; Tue, 20 Oct 2026 18:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mcB87y+X
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9517F1F000C9;
	Tue, 20 Oct 2026 18:35:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792521345;
	bh=SPkJeF9RtTy9wB3sPO422VPUe4VfMZVv+6S5vhenFQk=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=mcB87y+XthN5p8HN+3wx5VZgUiSzauBPmNKyWjEdiNlMvB+HwSEcGQjBT42V5O2m1
	 Q1RsoPKbFVNgzZr7mF+TvSocGDuzyztvAb/y9Yqt76/vODLe7eJnUKE30NdHVyvtIQ
	 sy0cOIpFP2rNQyl3SVYbsq1PqjZ2Uh+wcNMhDJwHo0iL87ac06dCEeDRvRB5c5dF6x
	 pZeqtK3KA74V50l2W4GaVzV/GebJ++1Y4eXiE0UV37sLCfNR/77/mrxNR3osj+tdPL
	 E4hx+v/HwNc7SNy4yd4W7cbPZcl9FzC5ibtNyYw6W/fouoOh48buTsnQ4Rc+Ryj+7u
	 oO0xS4EISMRYA==
Message-ID: <sashiko-outbox-179486@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v1 7/7] selftests/bpf: libarena: Cover buddy
 cache fast paths
Reply-To: sashiko-reviews@lists.linux.dev
To: "Emil Tsalapatis" <emil@etsalapatis.com>, bpf@vger.kernel.org
In-Reply-To: <20261020181900.6755-8-emil@etsalapatis.com>
References: <20261020181900.6755-1-emil@etsalapatis.com>
 <20261020181900.6755-8-emil@etsalapatis.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 20 Oct 2026 18:35:45 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] selftests/bpf: buddy_cache_get_order() accepts interior pointers=
 on free
- [Low] selftests/bpf: error return clobbered in buddy_free() during NMI dr=
ain
--

commit 05ed9b95b2e617e5142c6f1c186bbaa3122d07f7
Author: Emil Tsalapatis <emil@etsalapatis.com>

selftests/bpf: libarena: Cover buddy cache fast paths

This commit adds BPF selftests covering bulk allocations and per-CPU and
transfer cache fast paths in libarena's buddy allocator, and documents that
buddy_alloc_bulk() bypasses the per-CPU caches.

> diff --git a/tools/testing/selftests/bpf/libarena/selftests/test_buddy.bp=
f.c b/tools/testing/selftests/bpf/libarena/selftests/test_buddy.bpf.c
> index 6d123ec052b0f..f14c2945d1e11 100644
> --- a/tools/testing/selftests/bpf/libarena/selftests/test_buddy.bpf.c
> +++ b/tools/testing/selftests/bpf/libarena/selftests/test_buddy.bpf.c

[ ... ]

> @@ -221,4 +240,251 @@ __weak int test_buddy_alignment(void)

[ ... ]

> +SEC("syscall")
> +__weak int test_buddy_cache_paths(void)
> +{

[ ... ]

> +	/* Bulk allocation bypasses the cache. Fill the remaining local slots. =
*/
> +	ret =3D buddy_alloc_bulk(&buddy, TEST_CACHE_SIZE,
> +			       arena_fls(BUDDY_CACHE_CAPACITY) - 1,
> +			       alloc_path_test.bulk);
> +	if (ret)
> +		goto out;

[ ... ]

> +	/* Interior pointers are rejected without consuming the allocation. */
> +	i =3D BUDDY_CACHE_CAPACITY - BUDDY_CACHE_BATCH_SIZE + 2;
> +	if (!buddy_free(&buddy, (u8 __arena *)alloc_path_test.bulk[i] +
> +				 BUDDY_MIN_ALLOC_BYTES)) {
> +		ret =3D -EINVAL;
> +		goto out;
> +	}

[Severity: Medium]
Will this interior pointer check in test_buddy_cache_paths() fail when
BPF_ARENA_ASAN is disabled because buddy_cache_free() accepts the interior
pointer as an order-0 object?

When buddy_alloc_bulk() allocates the TEST_CACHE_SIZE (order 2) objects via
buddy_chunk_alloc() in tools/testing/selftests/bpf/libarena/src/buddy.bpf.c,
only the head granule of each object has its order and allocated bit record=
ed:

	for (i =3D zero, idx =3D retidx; i < (1U << order_allocs) && can_loop; i++=
) {
		if (idx_set_order(chunk, idx, order_req))
			return (u64)NULL;

		if (idx_set_allocated(chunk, idx, true))
			return (u64)NULL;

		idx +=3D 1U << order_req;
	}

The interior granule at alloc_path_test.bulk[i] + BUDDY_MIN_ALLOC_BYTES
(idx + 1) retains its zero-initialized order nibble (0) and allocated bit (=
0).

When test_buddy_cache_paths() passes that interior pointer to buddy_free(),
the call chain:

  buddy_free()
    -> buddy_cache_free()
      -> buddy_cache_get_order()

reads the order directly without checking alignment or whether idx is marked
allocated in chunk->allocated:

static int buddy_cache_get_order(void __arena *addr)
{
	struct buddy_chunk __arena *chunk;
	u64 idx;

	chunk =3D (void __arena *)((u64)addr & ~BUDDY_CHUNK_OFFSET_MASK);
	idx =3D ((u64)addr & BUDDY_CHUNK_OFFSET_MASK) / BUDDY_MIN_ALLOC_BYTES;

	return idx_get_order(chunk, idx);
}

Because idx_get_order() returns 0 for the unallocated interior granule and
the order-0 per-CPU cache has room, buddy_cache_push() pushes the interior
pointer into ctx.cache->orders[0] and buddy_free() returns 0, causing
test_buddy_cache_paths() to return -EINVAL.

Should buddy_cache_get_order() (or buddy_cache_free() and
buddy_cache_transfer_free()) verify that addr is aligned to
BUDDY_MIN_ALLOC_BYTES and that idx is marked allocated via idx_is_allocated=
()
before accepting the pointer into the cache?

> +	ret =3D buddy_free(&buddy, alloc_path_test.bulk[i]);

[Severity: Low]
In tools/testing/selftests/bpf/libarena/src/buddy.bpf.c, can buddy_free()
lose the error returned by buddy_free_unlocked() when a deferred NMI free is
pending?

Looking at buddy_free():

	ret =3D buddy_free_unlocked(buddy, (u64)addr);

	/* Drain any frees stranded during an NMI. */
	if (unlikely(buddy_deferred_free_pending(buddy))) {
		ret =3D buddy_deferred_free_complete(buddy);
		if (ret)
			goto out_unlock;
	}

If buddy_free_unlocked() returns an error (such as -EINVAL for an invalid or
interior pointer that bypassed the cache) while buddy_deferred_free_pending=
()
is true, buddy_deferred_free_complete() overwrites ret with 0 on success.

By contrast, buddy_free_bulk() in the same file preserves any earlier error:

	/* Drain any frees stranded during an NMI. */
	if (unlikely(buddy_deferred_free_pending(buddy))) {
		err =3D buddy_deferred_free_complete(buddy);
		ret =3D ret ?: err;
	}

Should buddy_free() preserve ret in the same way when draining deferred fre=
es?

> +
> +out:
> +	destroy_ret =3D buddy_destroy(&buddy);
> +	return ret ?: destroy_ret;
> +#endif
> +}

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261020181900.6755=
-1-emil@etsalapatis.com?part=3D7
