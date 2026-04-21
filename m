Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FC8A3451C1
	for <bpf@vger.kernel.org>; Tue, 21 Apr 2026 21:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776807741; cv=none; b=XfpZ+r2CSLY9kdvTdud5xduTjUeLbDTqO/K2j6avIFBY+WeGGKSTytm0XOUWKLvkedVe0zRBqxZV1nKEWNW2ELHvEsFrBjOu1R9159KUPWmdSW7Wcu3GKZ0LxL8BRWx0q5GEqezVXKK5hLLp/dVmMqQxRlT6SVT9NNEdcAB0Zsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776807741; c=relaxed/simple;
	bh=oDOBb6XQ/P4sNZY9E6xLurNNETArW19osslFY9Y80zE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=s3UbrGuoFeAgG3/ByUhtJphbC4/bSnRvbfq7AHluf1HRe+/u7Pt80bcNocPLDhrZof3CtNgR9p0Lym524bnxfhsDlXImTcZ8kjIVo14P1ywKS8U96BMFRWTSCxc7D035EeYxsTerGngcLz8jW68D2i9dHOvmdFpPyb6zFVwhWlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nulh1OAa; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nulh1OAa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFA5CC2BCB0;
	Tue, 21 Apr 2026 21:42:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776807741;
	bh=oDOBb6XQ/P4sNZY9E6xLurNNETArW19osslFY9Y80zE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=nulh1OAaHniMGUtflT7hOqP/HnCQtyAn+KkpiMmG49tLRtrlfAXyMaHpXsKeG/S9g
	 R5BOzlpw/r5jS58yZ12LgWVngZlOPA/H75TqdqAq3BouWTy7dfob0TzlNyqm5h4y9b
	 81uAplSFfWaSHh3AorRCXTvfawnGeGcItdJznA3PDbLuLM+GOs4h1GCA4qETUHHDyE
	 9f9MHOft9vSuNoMJ+7oU7VrEy1ExACnPH+vqSIDOSgsVVUZI5U4ush5toCYnXniemB
	 ycabPSAog6nymLE+Nkzd97B6+B4R/lMyB/jZ++onYxOdggNnNr6eJdJJye4uwii8bL
	 YqGJhkC8mp/Og==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v8 6/8] selftests/bpf: Add buddy allocator for
 libarena
Reply-To: sashiko@lists.linux.dev
To: "Emil Tsalapatis" <emil@etsalapatis.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260421165037.4736-7-emil@etsalapatis.com>
References: <20260421165037.4736-7-emil@etsalapatis.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 21 Apr 2026 21:42:20 +0000
Message-Id: <20260421214220.DFA5CC2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Sashiko AI review found 5 potential issue(s):
- [High] Permanent physical memory leak in buddy_alloc_from_new_chunk() whe=
n allocator lock fails.
- [Medium] Missing NULL pointer checks after idx_to_header() can cause BPF =
program faults.
- [Medium] buddy_chunk_get() holds the global spinlock across expensive thr=
ead-local initialization, disabling preemption unnecessarily.
- [Medium] buddy_free_unlocked() lacks bounds checking, allowing arbitrary =
metadata corruption if given a bad pointer.
- [Medium] buddy_init() permanently leaks 1GiB of arena virtual address spa=
ce on failure.
--

commit b2490ddf9769a03f5339f5d758f0fb5765e551bc
Author: Emil Tsalapatis <emil@etsalapatis.com>

selftests/bpf: Add buddy allocator for libarena

Add a byte-oriented buddy allocator for libarena. The buddy
allocator provides an alloc/free interface for small arena allocations
ranging from 16 bytes to 512 KiB. Lower allocations values are rounded
up to 16 bytes. The buddy allocator does not handle larger allocations
that can instead use the existing bpf_arena_{alloc, free}_pages() kfunc.

> diff --git a/tools/testing/selftests/bpf/libarena/src/buddy.bpf.c b/tools=
/testing/selftests/bpf/libarena/src/buddy.bpf.c
> index 0000000000000..489b7383a53a5
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/libarena/src/buddy.bpf.c
[ ... ]
> +static buddy_chunk_t *buddy_chunk_get(buddy_t *buddy)
> +{
[ ... ]
> +	chunk =3D bpf_arena_alloc_pages(&arena, (void __arena *)vaddr,
> +				      BUDDY_CHUNK_PAGES, NUMA_NO_NODE, 0);
> +	if (!chunk) {
> +		arena_stderr("[ALLOC FAILED]");
> +		return NULL;
> +	}
> +
> +	if (buddy_lock(buddy)) {
> +		/*
> +		 * We cannot reclaim the vaddr space, but that is ok - this
> +		 * operation should always succeed. The error path is to catch
> +		 * accidental deadlocks that will cause -ENOMEMs to the program as
> +		 * the allocator fails to refill itself, in which case vaddr usage
> +		 * is the least of our worries.
> +		 */
> +		bpf_arena_free_pages(&arena, (void __arena *)vaddr, BUDDY_CHUNK_PAGES);
> +		return NULL;
> +	}
> +
> +	asan_poison(chunk, BUDDY_POISONED, BUDDY_CHUNK_PAGES * __PAGE_SIZE);
> +
> +	/* Unpoison the chunk itself. */
> +	asan_unpoison(chunk, sizeof(*chunk));
> +
> +	/* Mark all freelists as empty. */
> +	for (ord =3D zero; ord < BUDDY_CHUNK_NUM_ORDERS && can_loop; ord++)
> +		chunk->freelists[ord] =3D BUDDY_CHUNK_ITEMS;

Is it necessary to hold the global spinlock across this chunk initializatio=
n?

At this stage, the newly allocated physical chunk has not yet been linked i=
nto
the globally visible buddy->first_chunk list, making it strictly thread-loc=
al.

Holding the lock here appears to unnecessarily disable preemption across th=
ese
computationally expensive operations like the 1MiB memory poisoning and the
unbounded while loop, while also serializing unrelated memory allocations on
other CPUs.

[ ... ]
> +__weak int buddy_init(buddy_t __arg_arena *buddy)
> +{
> +	buddy_chunk_t *chunk;
> +	int ret;
> +
> +	if (!asan_ready())
> +		return -EINVAL;
> +
> +	/* Reserve enough address space to ensure allocations are aligned. */
> +	ret =3D buddy_reserve_arena_vaddr(buddy);
> +	if (ret)
> +		return ret;
> +
> +	_Static_assert(BUDDY_CHUNK_PAGES > 0,
> +		       "chunk must use one or more pages");
> +
> +	chunk =3D buddy_chunk_get(buddy);
> +
> +	if (buddy_lock(buddy)) {
> +		bpf_arena_free_pages(&arena, chunk, BUDDY_CHUNK_PAGES);
> +		return -EINVAL;
> +	}

Does this leak the 1GiB of arena virtual address space if the initial chunk
allocation fails or if the lock cannot be acquired?

If buddy_chunk_get() returns NULL due to memory pressure, or if buddy_lock()
fails, the function returns an error without calling
buddy_unreserve_arena_vaddr().

If the calling program handles the error and retries initialization, this
could leak an additional 1GiB per attempt, rapidly exhausting the BPF
arena's maximum 4GiB virtual address space.

[ ... ]
> +__weak u64 buddy_chunk_alloc(buddy_chunk_t __arg_arena *chunk, int order=
_req)
> +{
[ ... ]
> +	retidx =3D chunk->freelists[order];
> +	header =3D idx_to_header(chunk, retidx);
> +	if (unlikely(!header))
> +		return (u64) NULL;
> +
> +	chunk->freelists[order] =3D header->next_index;
> +
> +	if (header->next_index !=3D BUDDY_CHUNK_ITEMS) {
> +		next_header =3D idx_to_header(chunk, header->next_index);
> +		next_header->prev_index =3D BUDDY_CHUNK_ITEMS;
> +	}

Could next_header be NULL here?

The idx_to_header() function is designed to return NULL if an index is
invalid or the block is improperly marked as allocated.

If the allocator state becomes corrupted and next_header is NULL, the
subsequent dereference would cause a NULL pointer dereference within the
arena, leading the BPF exception handler to terminate the program instead
of returning an error gracefully.

[ ... ]
> +static u64 buddy_alloc_from_new_chunk(buddy_t *buddy, buddy_chunk_t *chu=
nk, int order)
> +{
> +	u64 address;
> +
> +	if (buddy_lock(buddy))
> +		return (u64)NULL;

Does this leak the newly allocated physical chunk if the lock fails?

The chunk passed to this function was newly allocated via buddy_chunk_get().
If the spinlock fails, the function returns NULL and the chunk pointer is
dropped without being linked into buddy->first_chunk or freed via
bpf_arena_free_pages().

This results in a permanent 1MiB physical memory leak per lock
acquisition failure.

[ ... ]
> +static __always_inline int buddy_free_unlocked(buddy_t *buddy, u64 addr)
> +{
> +	buddy_header_t *header, *buddy_header;
> +	u64 idx, buddy_idx, tmp_idx;
> +	buddy_chunk_t *chunk;
> +	bool allocated;
> +	u8 order;
> +	int ret;
> +
> +	if (!buddy)
> +		return -EINVAL;
> +
> +	if (addr & (BUDDY_MIN_ALLOC_BYTES - 1)) {
> +		arena_stderr("Freeing unaligned address %llx\n", addr);
> +		return -EINVAL;
> +	}
> +
> +	/* Get (chunk, idx) out of the address. */
> +	chunk =3D (void __arena *)(addr & ~BUDDY_CHUNK_OFFSET_MASK);
> +	idx =3D (addr & BUDDY_CHUNK_OFFSET_MASK) / BUDDY_MIN_ALLOC_BYTES;
> +
> +	/* Mark the block as unallocated so we can access the header. */
> +	ret =3D idx_set_allocated(chunk, idx, false);

Are we missing bounds checking on the block index here?

The first sizeof(buddy_chunk_t) bytes of each 1MiB chunk are reserved for
internal metadata and permanently marked as allocated.

If a BPF program accidentally frees a pointer pointing into the metadata,
it appears the allocator will successfully free its own internal tracking
structures since it blindly marks the block as free with
idx_set_allocated() without verifying that the index falls outside the
reserved metadata area.

This would allow unintentional total corruption of the allocator's
internal state, coalescing metadata blocks and handing them out to
future malloc() callers.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260421165037.4736=
-1-emil@etsalapatis.com?part=3D6
