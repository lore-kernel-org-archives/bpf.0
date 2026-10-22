Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792673605;
	b=DKboWCKHOYVBkv4UHR8NyP44osk7MJ1zFdZ7PHHkBnsP1MSCoyHX22u23XUPLsikoYA+
	 VTijFbmnDVmmRe6GMchvPKB3KjjHVzTc+FmrSkwXFCXyrh8Xj+RI4GAi4Df29nJCTqQ/f
	 r2dwhO/sEcDfVgGwXvbAaFoDZ1vJ/z09SBW2CKeLCCPNBwweTdTZrWE3pN+jrKK91+6cu
	 bei4ELVxkwqw8DGqvPh2fPWrh6oqtQRD7KqYVPp2LK65TLHyhgjZm8wlcHbIucUCDS8Yz
	 LQKfyY5Va8kYU8GMb8XAfPUeYWc9BoBH3yr7EbgiUlASOLc4ZNZi2oDhOD0v/vEQxZQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792673605;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=DuOyL5Yv5ZPnjDFPTwunN1/2GA2AHOIbh6wGmtTtRLU=;
	b=EBKppDWogecrlIzhrbh9aEGHLBK7t4jKxJ5vUsFzeOA+e8il0m01hxXH9LzP2+p6PGhq
	 IzTNYQXiJnbjPVHhZYLLJ5M/IXzLpBsUs4SQj1Ladx0JO0DbtMxbnhOnoLwbkwqAP2QnK
	 F6cXm1EnOj6PrHzVVS6xHevyaogrgjFx7VJkKQFJda9VmSTNgIMmipKJkKfd/eUPPTc0h
	 cpXcBAO5yj6ZfbetnAPrq4sf+bQY52SphkhavRP8K/hE65FBLOfT2XkiHFM+3sx7GwO3H
	 r5FdPt18C9Oq7/amN87KzrO84vzz1z0O1ybmw98oQUtYqcaOs46p2B6ryfWCRP7kFbw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="L83gpN/H";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BC47606A31B
	for <bpf@vger.kernel.org>; Thu, 22 Oct 2026 12:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=L83gpN/H
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A13311F000C1;
	Thu, 22 Oct 2026 12:53:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792673605;
	bh=DuOyL5Yv5ZPnjDFPTwunN1/2GA2AHOIbh6wGmtTtRLU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=L83gpN/HtkfRSQxvSM7mHZuVv2VWxFm/ADw7N0d8uEsRXPeSNRhHgI3J2RuCvzggN
	 4DXhOz7uRWJJqEWAxOVOqz+3jxWR4RSWfZo3ZylLzEj73kIppzxGFW9yYw4Lcfj6rg
	 pH4Fg+R1+c12FEXLbX29ENaGuDxtkSFlfckO73yXT63vB5+Sqas7WJBAGJ0CObaJfP
	 ZWGSYe5wGPdgSPbLzdkq/XG4Z2DJAgfIPb00V3dpzupxEawuD119+s33T0L2CtfkTJ
	 qXe8MjIwALFONpgqh3yQvru2n2KSVKx8WwM8ExOdDPDVi7KzvzoTSDg4mwaiAgOJ1z
	 lkqKoh+oz3NSw==
Date: Thu, 22 Oct 2026 13:53:23 +0100
From: Harry Yoo <harry@kernel.org>
To: Emil Tsalapatis <emil@etsalapatis.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	eddyz87@gmail.com, memxor@gmail.com, daniel@iogearbox.net
Subject: Re: [PATCH bpf-next v2 3/7] selftests/bpf: libarena: Add buddy
 per-CPU caches
Message-ID: <atoAxMKmTpuUiqMf@thinkstation>
References: <20261021232641.10063-1-emil@etsalapatis.com>
 <20261021232641.10063-4-emil@etsalapatis.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261021232641.10063-4-emil@etsalapatis.com>

On Wed, Oct 21, 2026 at 11:26:37PM +0000, Emil Tsalapatis wrote:
> Every small allocation currently reaches the central buddy allocator and
> takes its lock. This serializes otherwise independent callers and touches
> the buddy metadata on every allocation and free.
> 
> Add a fixed-size LIFO array for each cached order and CPU. Keep the
> per-CPU cache pointers in struct buddy and allocate each CPU's packed
> cache from the buddy during initialization. Cache the eight smallest
> allocation orders, up to 2 KiB. Each array holds 16 objects, bounding each
> CPU's cache to about 1.5 KiB.

TIL the min alloc size is not PAGE_SIZE in BPF buddy allocator :)

> Allocations pop from the local array and frees push onto it without taking
> the buddy lock. Empty and full arrays fall through to the central buddy
> allocator. Packed arrays keep the fast path to a bounds check and a single
> slot access.
> 
> BPF programs only disable migration, so another task can preempt a cache
> operation and run on the same CPU, and an IRQ or NMI program can interrupt
> one. Claim the CPU with a cmpxchg on a per-CPU flag before touching its
> arrays, following the model used by the main BPF memory allocator. An
> operation that finds the CPU already claimed falls through to the central
> buddy allocator.
> 
> Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
> ---
>  .../bpf/libarena/include/libarena/buddy.h     |  34 +++
>  .../bpf/libarena/include/libarena/common.h    |   4 +
>  .../bpf/libarena/selftests/test_buddy.bpf.c   |   9 +
>  .../selftests/bpf/libarena/src/buddy.bpf.c    | 215 +++++++++++++++++-
>  4 files changed, 257 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/libarena/include/libarena/buddy.h b/tools/testing/selftests/bpf/libarena/include/libarena/buddy.h
> index f150e1c37e3d..66349915745b 100644
> --- a/tools/testing/selftests/bpf/libarena/include/libarena/buddy.h
> +++ b/tools/testing/selftests/bpf/libarena/include/libarena/buddy.h
> @@ -65,10 +65,44 @@ struct buddy_chunk {
>  	struct buddy_chunk __arena	*next;
>  };
>  
> +/* Constants related to the buddy allocator's object caches. */
> +enum buddy_cache_consts {
> +	/*
> +	 * Do not cache larger allocations to avoid excessive
> +	 * memory consumption from the per-cpu lists.
> +	 */
> +	BUDDY_CACHE_NUM_ORDERS = 1 << 3,
> +
> +	/*
> +	 * Just like arena spinlocks, hardcode percpu state to a maximum number of CPUs.
> +	 * Since arena spinlocks are a hard dependency, use the exact same limit.
> +	 */
> +	BUDDY_CACHE_MAX_CPUS = 1024,

Is there no way to get nr_cpu_ids from the kernel in BPF?
NR_CPUS is upper bound supported by the kernel but during the boot
process, the kernel updates nr_cpu_ids based on the processor of the
system.

Kernels built with CONFIG_MAXSMP won't be able to use this because
it uses very high NR_CPUS? (8192 on x86)

> +	/*
> +	 * Objects retained locally for each allocation order.
> +	 */
> +	BUDDY_CACHE_CAPACITY = 16,
> +};
> +
> diff --git a/tools/testing/selftests/bpf/libarena/src/buddy.bpf.c b/tools/testing/selftests/bpf/libarena/src/buddy.bpf.c
> index 6dfaa23089a9..c41e163b014f 100644
> --- a/tools/testing/selftests/bpf/libarena/src/buddy.bpf.c
> +++ b/tools/testing/selftests/bpf/libarena/src/buddy.bpf.c
> @@ -7,6 +7,9 @@
>  /*
>   * Buddy allocator arena-based implementation.
>   *
> +static __always_inline struct buddy_cache __arena *
> +buddy_cache_enter(struct buddy __arena *buddy)
> +{
> +	struct buddy_cache __arena *cache;
> +
> +	/* The caches only exist between buddy_init() and buddy_destroy(). */
> +	cache = buddy->percpu[bpf_get_smp_processor_id()];
> +	if (unlikely(!cache))
> +		return NULL;
> +
> +	/*
> +	 * No support for cache operations from contexts that interrupted or
> +	 * preempted an in-flight operation on the same CPU, just like the
> +	 * kernel's BPF memory allocator.
> +	 */
> +	if (cmpxchg(&cache->active, 0, 1))
> +		return NULL;

Maybe use cmpxchg_local() instead of cmpxchg() because this is percpu?
Not sure if there's cmpxchg_local() equivalent in BPF...

On x86, cmpxchg instruction should be cheaper without LOCK prefix.

> +
> +	return cache;
> +}
> +
> +static __always_inline void buddy_cache_exit(struct buddy_cache __arena *cache)
> +{
> +	smp_store_release(&cache->active, 0);
> +}

We don't need this barrier because this is percpu?

-- 
Cheers,
Harry / Hyeonggon
