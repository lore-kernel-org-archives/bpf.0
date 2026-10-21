Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792614542;
	b=lX5l/w8X3Kx4n2ZaNUkz4Mo4jeJ6hUvxCssqTM0cGMx24zLPCUTxL0WUmdAguXY95Av6
	 8Q7S5is36jvdDX15bjmmcH7Mp+4EJFA5aHRWWo1RVYwit256LksYi7s9fHnYUWK1yaBv6
	 3KoGnfO6x1+zR3tJed88Tli67WKERe62sdaWO+6n8rsvcIsn78vnQBNitxYnpOOsXyFWO
	 SZ7E1Y3Zj5M8O5H0DQn+E99RMX6uMrv5kDM95qUJ12Q/S6Gq+Mf6gIHYnsgacljxob1VT
	 buchfdinrPF/7yhk+rYpiSOsJFXKcJotGlB0o0JgjXLW/qwZid8sSiCiOYrst2+10cw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792614542;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Mime-Version:Content-Transfer-Encoding:Content-Type:Date:Message-Id:
	 From:To:Cc:Subject:X-Mailer:References:In-Reply-To;
	bh=ZkUDEi1ZKF4zPDuTjyVvmeEc3FKgBGSoU/KmGuq+tU0=;
	b=rTmnNHyjh0Fe7/35LFIg7k5FRcnXtSebSo/j/E3mK3QUHabckNnEcd5ZuwQKqU8K1f52
	 4tBp/ileeBfIgqfarMmxxPtmtTN5emN1QDD2/KT+NBtoxahIq2l1rx5GlhEMZqWZSMjR1
	 93gqk06zYPoEcEUMgd6kQW6Vm2jRDSwKeucBwYhFCPXQ7IxXVuLTyTzVKSNfhlEnousLi
	 ip9azN3ABZrrewboK1U6/VK8jRQV+6//uOuD7+bIWFoiG9p7+VFQGU1ZbzPuN34mlJCbh
	 DNt7QXz4837yBUTQoCJKRkeWTfYBq+jbVWuNpcUac9cOhAtNLhEAooACLj2xjRu6X4A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=etsalapatis.com;
	spf=pass smtp.mailfrom=etsalapatis.com;
	dkim=pass header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=tKgLtB3B;
	arc=none smtp.remote-ip=209.85.215.177
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34D38606A319
	for <bpf@vger.kernel.org>; Wed, 21 Oct 2026 20:29:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 34D38606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=tKgLtB3B
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-cc4dbcf2b85so462140a12.3
        for <bpf@vger.kernel.org>; Wed, 21 Oct 2026 13:29:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1792614540; x=1793219340; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ZkUDEi1ZKF4zPDuTjyVvmeEc3FKgBGSoU/KmGuq+tU0=;
        b=tKgLtB3BvO/nbX6wMp5qi4bkMQwGaUPqSOHROAjI9v1c5mZRZvzuyAYqV1B4c3JrQv
         gOqDE4NktNmT1VA7t9b3l4xuw1aWuLTXNQYmghX7Q3GlGTayBAoo6lknE49F6inYUGH2
         w4ZVBHXAw6mq1pZCC11/ULJ8sJ8byKmK6EypDqKppqc/PVDjWJUpP+NzJBKi/gGpbA9o
         izXDR1lCYhZvQgnTSxpt9aoGahh2tEJcW7n7RJTk4VXfg3cP762GgsKqH9F4AudLPYhc
         9metQ/O6huH6Q/LOyR+qG7/INJcGbbnhShYJb8UaWSMDh0s9LxMsGzwNOSotAbcOVbjf
         fcQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792614540; x=1793219340;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZkUDEi1ZKF4zPDuTjyVvmeEc3FKgBGSoU/KmGuq+tU0=;
        b=lRptu/UfFPQIlfJBcPq0LGOkaqHfBaAUtYUNFsmQ7udwV5qnfkURZ1XchDRq29iyaT
         1Z7S4sAFRm4G3HDXtGtnTrmfTgc7OP8hcgsWIVME3g+O/NB4eDtbBZZ2kWvuP4Rr4p+w
         VhdqJRSbEXipeFUk9YbZH1LkPkWJl5cTvGDNEED1mk8Cbldhe5wVrmzTQ8opHys3ufab
         sainT2nydzpGbqHBockF/kIpCPWoazeV0uAXHVr7syLfe0imwq94v72xoRoXtONOVbUz
         Odb4frYTmTkYrmRt258f892FCOxRVJ9Yd71anTc3RnWpzPDx3zWxZWnATPvRwcaTd30O
         S4kA==
X-Forwarded-Encrypted: i=1; AKwUvBwUrcq2QWAQwGtOoO6gfQpxjWiP+B/8Fdj+8N+AG0DUTeDsA4Qg2HncVt8Xv/o1wTP1QQQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYKkSf/K2P3dipaaMpD2rlcyvnTfIGH5n/1rjeoE/zLrfqD6p/Nd
	PPNwq7czNpanmNeiLjzBZWQ6TDQhL7xPpWCUsaHWXPhgWQltkd906giEAsdD/rwMuTQ=
X-Gm-Gg: AYBFou0axwI/iNnmOvBLZI9xJNd6oMm09JYB02hiWRpSOk6XCdYpJJJ9PHuvic2Vffk
	vDaZkfbFzDncOVSL1jp85vzEB3pW2nJaJsr8JRpniDdgj3DcWpufcOvPhm0NYNF9csKG8hrC55J
	WuKB8/X4t/vXnJSuxdAwNbDsTtkSSgCdQhxbZwQheLyfzzfcbwuDPPQI8bQxGaa36OeGhIeIfBz
	4R5fULG/AvoUMXzWpd8h2CGnEe+vrbKAPJMz2Hru0ehKBSFYnWqyRQmcsLZDyuPpWYo2zc05c4w
	mRszwRJsrlpWXjgUlOcaUBS8pBmIz0Xer/ZYEgTRnM/Hp0wNlpioZzdGR/UbQaVhSB6HygBvJqo
	n+IrzW1hfAi2xAwL/99fYveQ/Zu6rCxlyC0I9rjx1YBwkFbiK8BCLpGq5jf0OFGKjzKTGP7PwmS
	LTGHJUikx8q94vNXwfQXr7KgvyE6MAjipt5mwqfKrNuMn6BeHMG58emB4IyD0y+0lFcAxkroHMU
	/o3Ve2TAKnxNnV/R5EEOUlkO1Ro0QOIEIlx/gyf
X-Received: by 2002:a05:6a20:7fa1:b0:3de:1b92:a4dd with SMTP id adf61e73a8af0-3e287df842fmr2478195637.18.1792614540119;
        Wed, 21 Oct 2026 13:29:00 -0700 (PDT)
Received: from localhost ([2620:10d:c090:600::1:66d6])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8a0895c08c8sm1295568b3a.25.2026.10.21.13.28.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Oct 2026 13:28:59 -0700 (PDT)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 21 Oct 2026 20:28:53 +0000
Message-Id: <DMASTFVS9NFD.1W46I66DW4NHU@etsalapatis.com>
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>, "Emil Tsalapatis"
 <emil@etsalapatis.com>, <bpf@vger.kernel.org>
Cc: <andrii@kernel.org>, <eddyz87@gmail.com>, <memxor@gmail.com>,
 <daniel@iogearbox.net>, "Harry Yoo" <harry@kernel.org>
Subject: Re: [PATCH bpf-next v1 0/7] bpf libarena allocator improvements
X-Mailer: aerc 0.21.0
References: <20261020181900.6755-1-emil@etsalapatis.com>
 <DM9ZQ59RPJ8P.2S767179JJRCC@gmail.com>
In-Reply-To: <DM9ZQ59RPJ8P.2S767179JJRCC@gmail.com>

On Tue Oct 20, 2026 at 9:41 PM UTC, Alexei Starovoitov wrote:
> On Tue, Oct 20, 2026 at 11:18 AM Emil Tsalapatis <emil@etsalapatis.com> w=
rote:
>> object LIFOs, one for each allocator order. This speeds up allocation
>> and freeing for BPF programs that have some degree of locality. The
>> CPU caches are lockless. The caches are replenished from and spilled
>> into "transfer caches", per-order caches shared between the CPUs that
>> amortize the cost of spilling/refilling. Data from the transfer caches
>> is in turn moved from and to the allocator.
>
> can we drop the transfer caches and spill with buddy_free_bulk() ?
> Refill already goes through buddy_alloc_bulk() and buddy_free_bulk()
> has no user other than the selftest. That's one buddy lock per 8
> objects in both directions.
>

(Anything not mentioned is an implicit ack).

I changed bench_malloc_free() to time frees as well and added a cross-CPU
variant. I will add the benchmark numbers in the next cover letter,
TL;DR is 2-4x lower alloc/free latency for single threaded, 10x-100x
lower for 8 producers (benefit is larger for allocation/free cycles
as we don't spill into the contended caches/buddy alloc).

I think we should keep the transfer cache, because with some finagling
(e.g., checking the transfer array without its lock and dumping a whole
batch when it's fiull the second lock during frees) it helps for heavily lo=
aded
producer/allocation configurations. This is both on allocs and frees. There=
's
no config where dropping the transfer cache provides a meaningful
speedup.

Setup: Two versions of the code, one out of your prototype one out of the
transfer cache version. Run in a 16-vCPU VM mean latency in ns over three
runs. allocs/cycle is the number of consecutive allocations, and then frees=
,
in each iteration. With 1-16 allocs/cycle everything stays in the 16-slot
local cache, so the interesting rows are the ones that overflow.

libarena-malloc-free, allocation latency (ns, lower is better):

                  transfer cache             spill
  allocs/cycle    1p   2p   4p   8p     1p   2p   4p   8p
            64    75  142  191  380     102  210  444  952
           256   104  149  240  446     112  230  517 1110

libarena-malloc-free, free latency (ns, lower is better):

                  transfer cache             spill
  allocs/cycle    1p   2p   4p   8p     1p   2p   4p   8p
            64    75   97  140  331     137  252  508 1014
           256   137  107  179  404     156  267  668 1244

libarena-malloc-xfree, where each worker publishes its list in a shared
slot and frees the list left there by the previous invocation, so with
more than one pinned worker most frees happen on a different CPU from
the allocation:

libarena-malloc-xfree, allocation latency (ns, lower is better):

                  transfer cache             spill
  allocs/cycle    1p   2p   4p   8p     1p   2p   4p   8p
            64    76  164  206  399     103  231  450  966
           256   101  210  264  482     110  252  592 1188

libarena-malloc-xfree, free latency (ns, lower is better):

                  transfer cache             spill
  allocs/cycle    1p   2p   4p   8p     1p   2p   4p   8p
            64    74   99  128  311     137  246  492 1002
           256   132  119  164  408     154  306  614 1218

With 2-8 producers, the transfer cache saves:

- 33-60% of the allocation time and 60-73% of the free time with
  same-CPU frees.
- 17-59% of the allocation time and 60-74% of the free time with
  cross-CPU frees.

With 1-16 allocs/cycle the cache-hit paths of the two versions are
identical, so the remaining differences there most likely come from
code and data layout or noise, not from the transfer cache. They go
both ways:

- The transfer version is 3-9 ns faster at 1 alloc/cycle, on
  allocations in both benchmarks and on same-CPU frees, and up to 4 ns
  faster on cross-CPU allocations at 4 allocs/cycle.
- The spill version is ~2 ns (3.5%) faster on cross-CPU frees at
  1 alloc/cycle with 4 and 8 producers.

The 2-producer rows of the same-CPU benchmark are noisier than the rest
(up to ~68% between runs), but the 4- and 8-producer differences are
well beyond that.

The transfer cache helps even in libarena-malloc-free, where each worker
frees its own objects and nothing moves between CPUs, because the shared
per-order array acts as extra capacity: overflowing batches are parked
there and come back on the next miss under a per-order lock, so batches
most likely rarely go back to the buddy alloc. Without it, every batch goes
through the global buddy lock and is split and coalesced again, and that
contention grows with the number of producers.

Freeing on a different CPU doesn't change the perf gaps, because
contention on the buddy lock dominates.

The two-locks-per-free case is fixed in the transfer version by adding
a lockless peek at the transfer array's count + bulk frees. A full array
then costs one buddy lock per batch, the same as spilling. The refill
side gets the same check. On 256 allocs/cycle 1-producer the transfer
cache version now beats the non-transfer cache (137 ns vs 156 ns,
132 vs 154 ns cross-CPU).

Code complexity-wise, the transfer version is only 75 LOC larger, and
provides a real benefit.

I can send a v2 with the transfer cache still in the patch just so we
can mark the rest of the feedback as addressed and to make the updated
design more concrete, and keep discussing there.

> Spilling is where the series doesn't amortize today. With the transfer
> array full a free on a full local cache takes the transfer lock, gets
> -ENOMEM, then takes the buddy lock for that one object. The local cache
> stays full, so the next free does the same: two locks per free. With
> --nallocs 1000 from run_bench_libarena.sh that's about 900 of the 1000
> frees of each worker.
>
> There are no numbers in the cover or in the logs, and the benchmark
> can't show the case patch 6 is for: bench_malloc_free() times only
> arena_malloc() and each worker frees its own objects.
>
> Then no need for struct buddy_transfer_order, the per-order locks,
> buddy_transfer_take_batch/put_batch and the second enter on a miss or a
> full cache. With the guard in struct buddy_cache active[] and struct
> buddy_cache_ctx go away too.
>
> Below leaves out NMI handling, selftests and the pointer validation
> that sashiko asked for.
>
> Something like this (not even compile tested):
>
> diff --git a/tools/testing/selftests/bpf/libarena/include/libarena/buddy.=
h b/tools/testing/selftests/bpf/libarena/include/libarena/buddy.h
> index 528c69a..ff22795 100644
> --- a/tools/testing/selftests/bpf/libarena/include/libarena/buddy.h
> +++ b/tools/testing/selftests/bpf/libarena/include/libarena/buddy.h
> @@ -65,10 +65,35 @@ struct buddy_chunk {
>  	struct buddy_chunk __arena	*next;
>  };
>
> +enum buddy_cache_consts {
> +	/* Larger allocations are not cached. */
> +	BUDDY_CACHE_NUM_ORDERS	=3D 1 << 3,
> +
> +	/* Same limit as arena spinlocks, buddy_init() fails beyond it anyway. =
*/
> +	BUDDY_CACHE_MAX_CPUS	=3D 1024,
> +
> +	/* Objects moved to and from the buddy at once, as an order. */
> +	BUDDY_CACHE_BATCH_ORDER	=3D 3,
> +	BUDDY_CACHE_BATCH_SIZE	=3D 1 << BUDDY_CACHE_BATCH_ORDER,
> +
> +	BUDDY_CACHE_CAPACITY	=3D BUDDY_CACHE_BATCH_SIZE * 2,
> +};
> +
> +struct buddy_cache_order {
> +	u32 elems;
> +	void __arena *objects[BUDDY_CACHE_CAPACITY];
> +} __attribute__((aligned(64)));
> +
> +struct buddy_cache {
> +	unsigned int active;	/* An operation is in flight on this CPU */
> +	struct buddy_cache_order orders[BUDDY_CACHE_NUM_ORDERS];
> +};
> +
>  struct buddy {
>  	struct buddy_chunk __arena *first_chunk;		/* Pointer to the chunk linke=
d list. */
>  	arena_spinlock_t lock;			/* Allocator lock */
>  	u64 vaddr;				/* Allocation into reserved vaddr */
> +	struct buddy_cache __arena *percpu[BUDDY_CACHE_MAX_CPUS];
>  };
>
>  #ifdef __BPF__
> @@ -76,6 +101,10 @@ struct buddy {
>  int buddy_init(struct buddy __arena *buddy);
>  int buddy_destroy(struct buddy __arena *buddy);
>  int buddy_free(struct buddy __arena *buddy, void __arena *free);
> +int buddy_free_bulk(struct buddy __arena *buddy, void __arena * __arena =
*addrs,
> +	size_t naddrs);
>  void __arena *buddy_alloc(struct buddy __arena *buddy, size_t size);
> +int buddy_alloc_bulk(struct buddy __arena *buddy, size_t size, size_t no=
rder,
> +	void __arena * __arena * out);
>
>  #endif /* __BPF__  */
> diff --git a/tools/testing/selftests/bpf/libarena/src/buddy.bpf.c b/tools=
/testing/selftests/bpf/libarena/src/buddy.bpf.c
> index 2490ab1..490133a 100644
> --- a/tools/testing/selftests/bpf/libarena/src/buddy.bpf.c
> +++ b/tools/testing/selftests/bpf/libarena/src/buddy.bpf.c
> @@ -557,6 +557,139 @@ static struct buddy_chunk __arena *buddy_chunk_get(=
struct buddy __arena *buddy)
>  	return chunk;
>  }
>
> +/*
> + * Per-CPU caching is disabled in ASAN builds. Cached objects stay unpoi=
soned
> + * and the additional call chain doesn't fit the stack limit.
> + */
> +#ifdef BPF_ARENA_ASAN
> +#define buddy_order_cached(order) false
> +#else
> +#define buddy_order_cached(order) ((order) < BUDDY_CACHE_NUM_ORDERS)
> +#endif
> +
> +static __always_inline struct buddy_cache __arena *
> +buddy_cache_enter(struct buddy __arena *buddy)
> +{
> +	struct buddy_cache __arena *cache;
> +
> +	/* A nested or preempting operation on this CPU goes to the buddy. */
> +	cache =3D buddy->percpu[bpf_get_smp_processor_id()];
> +	if (cmpxchg(&cache->active, 0, 1))
> +		return NULL;
> +
> +	return cache;
> +}
> +
> +static __always_inline void buddy_cache_exit(struct buddy_cache __arena =
*cache)
> +{
> +	smp_store_release(&cache->active, 0);
> +}
> +
> +static __always_inline void __arena *
> +buddy_cache_pop(struct buddy_cache_order __arena *slots)
> +{
> +	u32 elems =3D READ_ONCE(slots->elems);
> +
> +	if (!elems)
> +		return NULL;
> +
> +	WRITE_ONCE(slots->elems, elems - 1);
> +
> +	return READ_ONCE(slots->objects[elems - 1]);
> +}
> +
> +static void __arena *buddy_cache_alloc(struct buddy __arena *buddy, size=
_t size,
> +				       int order)
> +{
> +	struct buddy_cache_order __arena *slots;
> +	struct buddy_cache __arena *cache;
> +	void __arena *address;
> +
> +	if (!buddy_order_cached(order))
> +		return NULL;
> +
> +	cache =3D buddy_cache_enter(buddy);
> +	if (!cache)
> +		return NULL;
> +
> +	slots =3D &cache->orders[order];
> +	address =3D buddy_cache_pop(slots);
> +	if (!address && !buddy_alloc_bulk(buddy, size, BUDDY_CACHE_BATCH_ORDER,
> +					  (void __arena * __arena *)slots->objects)) {
> +		WRITE_ONCE(slots->elems, BUDDY_CACHE_BATCH_SIZE);
> +		address =3D buddy_cache_pop(slots);
> +	}
> +
> +	buddy_cache_exit(cache);
> +
> +	return address;
> +}
> +
> +static int buddy_cache_free(struct buddy __arena *buddy, void __arena *a=
ddr)
> +{
> +	struct buddy_cache_order __arena *slots;
> +	struct buddy_cache __arena *cache;
> +	struct buddy_chunk __arena *chunk;
> +	u32 elems;
> +	u64 idx;
> +	int order;
> +	int ret =3D 0;
> +
> +	chunk =3D (void __arena *)((u64)addr & ~BUDDY_CHUNK_OFFSET_MASK);
> +	idx =3D ((u64)addr & BUDDY_CHUNK_OFFSET_MASK) / BUDDY_MIN_ALLOC_BYTES;
> +	order =3D idx_get_order(chunk, idx);
> +	if (!buddy_order_cached(order))
> +		return -EINVAL;
> +
> +	cache =3D buddy_cache_enter(buddy);
> +	if (!cache)
> +		return -EAGAIN;
> +
> +	slots =3D &cache->orders[order];
> +	elems =3D READ_ONCE(slots->elems);
> +	if (elems >=3D BUDDY_CACHE_CAPACITY) {
> +		/* Full. Give a batch back with one trip to the buddy. */
> +		elems -=3D BUDDY_CACHE_BATCH_SIZE;
> +		ret =3D buddy_free_bulk(buddy,
> +				      (void __arena * __arena *)&slots->objects[elems],
> +				      BUDDY_CACHE_BATCH_SIZE);
> +		if (ret)
> +			goto out;
> +	}
> +
> +	WRITE_ONCE(slots->objects[elems], addr);
> +	WRITE_ONCE(slots->elems, elems + 1);
> +
> +out:
> +	buddy_cache_exit(cache);
> +
> +	return ret;
> +}
> +
> +static int buddy_cache_init(struct buddy __arena *buddy)
> +{
> +	struct buddy_cache __arena *cache;
> +	unsigned int cpu, order;
> +	int ret;
> +
> +	if (!buddy_order_cached(0))
> +		return 0;
> +
> +	for (cpu =3D zero; cpu < CONFIG_NR_CPUS && can_loop; cpu++) {
> +		ret =3D buddy_alloc_bulk(buddy, sizeof(*cache), 0,
> +				       (void __arena * __arena *)&buddy->percpu[cpu]);
> +		if (ret)
> +			return ret;
> +
> +		cache =3D buddy->percpu[cpu];
> +		cache->active =3D 0;
> +		for (order =3D zero; order < BUDDY_CACHE_NUM_ORDERS && can_loop; order=
++)
> +			cache->orders[order].elems =3D 0;
> +	}
> +
> +	return 0;
> +}
> +
>  __weak int buddy_init(struct buddy __arena *buddy)
>  {
>  	struct buddy_chunk __arena *chunk;
> @@ -590,7 +723,14 @@ __weak int buddy_init(struct buddy __arena *buddy)
>
>  	buddy_unlock(buddy, flags);
>
> -	return chunk ? 0 : -ENOMEM;
> +	if (!chunk)
> +		return -ENOMEM;
> +
> +	ret =3D buddy_cache_init(buddy);
> +	if (ret)
> +		buddy_destroy(buddy);
> +
> +	return ret;
>  }
>
>  /*
> @@ -628,7 +768,7 @@ __weak int buddy_destroy(struct buddy __arena *buddy)
>  	return 0;
>  }
>
> -__weak u64 buddy_chunk_alloc(struct buddy_chunk __arena *chunk, int orde=
r_req)
> +__weak u64 buddy_chunk_alloc(struct buddy_chunk __arena *chunk, int orde=
r_req, int order_allocs)
>  {
>  	struct buddy_header __arena *header, *tmp_header, *next_header;
>  	u32 idx, tmpidx, retidx;
> @@ -636,7 +776,7 @@ __weak u64 buddy_chunk_alloc(struct buddy_chunk __are=
na *chunk, int order_req)
>  	u64 order =3D 0;
>  	u64 i;
>
> -	for (order =3D order_req; order < BUDDY_CHUNK_NUM_ORDERS && can_loop; o=
rder++) {
> +	for (order =3D order_req + order_allocs; order < BUDDY_CHUNK_NUM_ORDERS=
 && can_loop; order++) {
>  		if (chunk->freelists[order] !=3D BUDDY_CHUNK_ITEMS)
>  			break;
>  	}
> @@ -658,11 +798,19 @@ __weak u64 buddy_chunk_alloc(struct buddy_chunk __a=
rena *chunk, int order_req)
>
>  	header->prev_index =3D BUDDY_CHUNK_ITEMS;
>  	header->next_index =3D BUDDY_CHUNK_ITEMS;
> -	if (idx_set_order(chunk, retidx, order_req))
> -		return (u64)NULL;
> +	/*
> +	 * For a bulk allocation, record the allocation state and size
> +	 * of each item separately so each can be freed independently.
> +	 */
> +	for (i =3D zero, idx =3D retidx; i < (1U << order_allocs) && can_loop; =
i++) {
> +		if (idx_set_order(chunk, idx, order_req))
> +			return (u64)NULL;
>
> -	if (idx_set_allocated(chunk, retidx, true))
> -		return (u64)NULL;
> +		if (idx_set_allocated(chunk, idx, true))
> +			return (u64)NULL;
> +
> +		idx +=3D 1U << order_req;
> +	}
>
>  	/*
>  	 * Do not unpoison the address yet, will be done by the caller
> @@ -673,7 +821,7 @@ __weak u64 buddy_chunk_alloc(struct buddy_chunk __are=
na *chunk, int order_req)
>  		return (u64)NULL;
>
>  	/* If we allocated from a larger-order chunk, split the buddies. */
> -	for (i =3D order_req; i < order && can_loop; i++) {
> +	for (i =3D order_req + order_allocs; i < order && can_loop; i++) {
>  		/*
>  		 * Flip the bit for the current order (the bit is guaranteed
>  		 * to be 0, so just add 1 << i).
> @@ -706,14 +854,14 @@ __weak u64 buddy_chunk_alloc(struct buddy_chunk __a=
rena *chunk, int order_req)
>  }
>
>  /* Scan the existing chunks for available memory. */
> -static u64 buddy_alloc_from_existing_chunks(struct buddy __arena *buddy,=
 int order)
> +static u64 buddy_alloc_from_existing_chunks(struct buddy __arena *buddy,=
 int order, int norder)
>  {
>  	struct buddy_chunk __arena *chunk;
>  	u64 address;
>
>  	for (chunk =3D buddy->first_chunk; chunk !=3D NULL && can_loop;
>  	     chunk =3D chunk->next) {
> -		address =3D buddy_chunk_alloc(chunk, order);
> +		address =3D buddy_chunk_alloc(chunk, order, norder);
>  		if (address)
>  			return address;
>  	}
> @@ -725,7 +873,8 @@ static u64 buddy_alloc_from_existing_chunks(struct bu=
ddy __arena *buddy, int ord
>   * Try an allocation from a newly allocated chunk. Also
>   * incorporate the chunk into the linked list.
>   */
> -static u64 buddy_alloc_from_new_chunk(struct buddy __arena *buddy, struc=
t buddy_chunk __arena *chunk, int order)
> +static u64 buddy_alloc_from_new_chunk(struct buddy __arena *buddy, struc=
t buddy_chunk __arena *chunk,
> +		int order, int norder)
>  {
>  	unsigned long flags;
>  	u64 address;
> @@ -741,33 +890,31 @@ static u64 buddy_alloc_from_new_chunk(struct buddy =
__arena *buddy, struct buddy_
>  	chunk->next =3D buddy->first_chunk;
>  	buddy->first_chunk =3D chunk;
>
> -	address =3D buddy_chunk_alloc(buddy->first_chunk, order);
> +	address =3D buddy_chunk_alloc(buddy->first_chunk, order, norder);
>
>  	buddy_unlock(buddy, flags);
>
>  	return (u64)address;
>  }
> -__weak
> -void __arena *buddy_alloc(struct buddy __arena *buddy, size_t size)
> +static void __arena *buddy_alloc_memory(struct buddy __arena *buddy, siz=
e_t size,
> +		int order, size_t norder)
>  {
>  	void __arena *address =3D NULL;
> +	u8 __arena *object;
>  	struct buddy_chunk __arena *chunk;
> +	unsigned int alloc_size;
> +	unsigned int i, offset;
>  	unsigned long flags;
> -	int order;
> -
> -	if (!buddy)
> -		return NULL;
>
> -	order =3D size_to_order(size);
> -	if (order >=3D BUDDY_CHUNK_NUM_ORDERS || order < 0) {
> -		arena_stderr("invalid order %d (sz %lu)\n", order, size);
> +	if (order < 0 || order >=3D BUDDY_CHUNK_NUM_ORDERS || norder >=3D BUDDY=
_CHUNK_NUM_ORDERS - order) {
> +		arena_stderr("invalid order %d (norder %lu) (sz %lu)\n", order, norder=
, size);
>  		return NULL;
>  	}
>
>  	if (buddy_lock(buddy, flags))
>  		return NULL;
>
> -	address =3D (u8 __arena *)buddy_alloc_from_existing_chunks(buddy, order=
);
> +	address =3D (u8 __arena *)buddy_alloc_from_existing_chunks(buddy, order=
, norder);
>  	buddy_unlock(buddy, flags);
>  	if (address)
>  		goto done;
> @@ -775,28 +922,76 @@ void __arena *buddy_alloc(struct buddy __arena *bud=
dy, size_t size)
>  	/* Get a new chunk. */
>  	chunk =3D buddy_chunk_get(buddy);
>  	if (chunk)
> -		address =3D (u8 __arena *)buddy_alloc_from_new_chunk(buddy, chunk, ord=
er);
> +		address =3D (u8 __arena *)buddy_alloc_from_new_chunk(buddy, chunk, ord=
er, norder);
>
>  done:
>  	/* If we failed to allocate memory, return NULL. */
>  	if (!address)
>  		return NULL;
>
> +	alloc_size =3D BUDDY_MIN_ALLOC_BYTES << order;
> +
>  	/*
> -	 * Unpoison exactly the amount of bytes requested. If the
> -	 * data is smaller than the header, we must poison any
> -	 * unused bytes that were part of the header.
> +	 * Unpoison exactly the requested bytes in each allocation. Keep
> +	 * the padding between the requested size and the rounded buddy
> +	 * allocation poisoned.
>  	 */
> -	if (size < BUDDY_HEADER_OFF + sizeof(struct buddy_header __arena))
> -		asan_poison(address + BUDDY_HEADER_OFF, BUDDY_POISONED,
> -			    sizeof(struct buddy_header __arena));
> +	for (i =3D zero, offset =3D zero; i < (1U << norder) && can_loop; i++, =
offset +=3D alloc_size) {
> +		object =3D (u8 __arena *)address + offset;
>
> -	asan_unpoison(address, size);
> +		if (size < BUDDY_HEADER_OFF + sizeof(struct buddy_header __arena))
> +			asan_poison(object + BUDDY_HEADER_OFF,
> +				    BUDDY_POISONED,
> +				    sizeof(struct buddy_header __arena));
> +
> +		asan_unpoison(object, size);
> +	}
>
>  	return address;
>  }
>
> -static __always_inline int buddy_free_unlocked(struct buddy __arena *bud=
dy, u64 addr)
> +__weak
> +int buddy_alloc_bulk(struct buddy __arena *buddy, size_t size, size_t no=
rder,
> +		void __arena * __arena * out)
> +{
> +	void __arena *address;
> +	unsigned int i, off;
> +	unsigned int step;
> +	int order;
> +
> +	if (!buddy || !out || norder >=3D BUDDY_CHUNK_NUM_ORDERS)
> +		return -EINVAL;
> +
> +	order =3D size_to_order(size);
> +	address =3D buddy_alloc_memory(buddy, size, order, norder);
> +	if (!address)
> +		return -ENOMEM;
> +
> +	step =3D BUDDY_MIN_ALLOC_BYTES << order;
> +	for (i =3D zero, off =3D zero; i < (1U << norder) && can_loop; i++, off=
 +=3D step)
> +		out[i] =3D &address[off];
> +
> +	return 0;
> +}
> +
> +__weak
> +void __arena *buddy_alloc(struct buddy __arena *buddy, size_t size)
> +{
> +	void __arena *address;
> +	int order;
> +
> +	if (!buddy)
> +		return NULL;
> +
> +	order =3D size_to_order(size);
> +	address =3D buddy_cache_alloc(buddy, size, order);
> +	if (address)
> +		return address;
> +
> +	return buddy_alloc_memory(buddy, size, order, 0);
> +}
> +
> +static int buddy_free_unlocked(struct buddy __arena *buddy, u64 addr)
>  {
>  	struct buddy_header __arena *header, *buddy_header;
>  	u64 idx, buddy_idx, tmp_idx;
> @@ -889,6 +1084,9 @@ __weak int buddy_free(struct buddy __arena *buddy, v=
oid __arena *addr)
>  	if (!addr)
>  		return 0;
>
> +	if (!buddy_cache_free(buddy, addr))
> +		return 0;
> +
>  	ret =3D buddy_lock(buddy, flags);
>  	if (ret)
>  		return ret;
> @@ -900,4 +1098,32 @@ __weak int buddy_free(struct buddy __arena *buddy, =
void __arena *addr)
>  	return ret;
>  }
>
> +/*
> + * Fails only when it can't take the lock, then nothing was freed. Objec=
ts that
> + * buddy_free_unlocked() rejects are reported there, like in buddy_free(=
).
> + */
> +__weak int buddy_free_bulk(struct buddy __arena *buddy, void __arena * _=
_arena *addrs, size_t naddrs)
> +{
> +	unsigned long flags;
> +	unsigned int i;
> +	int ret;
> +
> +	if (!buddy || !addrs)
> +		return -EINVAL;
> +
> +	ret =3D buddy_lock(buddy, flags);
> +	if (ret)
> +		return ret;
> +
> +	for (i =3D zero; i < naddrs && can_loop; i++) {
> +		/* NULL pointers are ignored. */
> +		if (addrs[i])
> +			buddy_free_unlocked(buddy, (u64)addrs[i]);
> +	}
> +
> +	buddy_unlock(buddy, flags);
> +
> +	return 0;
> +}
> +
>  __weak char _license[] SEC("license") =3D "GPL";
>
> pw-bot: cr

