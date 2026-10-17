Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 049583939A4;
	Sat, 17 Oct 2026 17:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792257439; cv=none; b=RBH0E+yFdksTs4fikom2CtRH/J9sGcStvxEnhgilGhuMD9gkIxZ2rT8kbJ/XFInr8JrtRXrMl218X2IhBxMCzkvvoYm1KjqE0IOMSFNl3YRN7d2j3oeLdscKRtFUik1fYCA9Gt5jsXImXtUZc4ylmWJtTIDxPaHCSkqW6scR+Tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792257439; c=relaxed/simple;
	bh=fDwfYTdff5syWVefNisnVN/E/0oSEprZLDnd3J1Y8o8=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=cBbpwy0qkUdjdJLASVOUhP8SDdhhRN+cf3hjb1cS9Y9e1Apctcwg6JL7p0JWqYpFxH+fB9enfmCNMrB6dfJ2DDCNzrStwyYfE9StnT3F9V4m2+Byv+sMtS8sMnIqmxm6vVpriuLzx+fZn9Ay2lRdPpcr0JfvcFxFjw5F8+cTEDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MPOFLojG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MPOFLojG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AEA41F000C4;
	Sat, 17 Oct 2026 17:17:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792257437;
	bh=3+2eKBEa3pvaVsKTiJ6bETRA9I5BKp+BTqn8EgT8sN4=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=MPOFLojGbL3tdAgGB8/Bry/fqmE69fm0o4zT0LZ3CliT05jz3slu+860/ehTjxVaK
	 YbcQuuqOXKNo4fhIgWNMPt1fpjK9OGF5bm79y1OPbokyWONkZaV+40ZNkp4CrE4tgn
	 laV/y2ZOSCF6P58qCHTDZ90Dl9unhkc63F2sqRreiMZTjar2NJPhecjJGZHBWkxzOi
	 w6O7agMzqffpJT/V50LGQVDrgfnte1YS1D9PmO6EShO1mrk0UnyH6DHeNmSD5j8ZYz
	 ok2GZh5uAMDm/3oooe2z2S+Wis2Xn3KCU4ZgJiOoEyPYZJiS+hvh4JATEYDz8GRAEg
	 Hds9iWWeZ8now==
Content-Type: multipart/mixed; boundary="===============0096483132692541398=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <4656e25df00e93dfb992cd78b48c76aa1af8ddd22cd500c070aa7cb4c549d80c@mail.kernel.org>
In-Reply-To: <20261017163745.3341787-36-alexei.starovoitov@gmail.com>
References: <20261017163745.3341787-36-alexei.starovoitov@gmail.com>
Subject: Re: [PATCH bpf-next v2 35/43] bpf, cpumap: Hold the device of frames in the queue
From: bot+bpf-ci@kernel.org
To: alexei.starovoitov@gmail.com,bpf@vger.kernel.org
Cc: daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,netdev@vger.kernel.org,josef@toxicpanda.com,mason@kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Sat, 17 Oct 2026 17:17:16 +0000 (UTC)

--===============0096483132692541398==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf, cpumap: Hold the device of frames in the queue

TL;DR:
- The 2048-pointer held[] array in struct bpf_cpu_map_entry makes each entry a
  ~32 KiB order-3 allocation, which may fail under fragmentation
- Stale comments and parameter name in the GRO flush code (nit)

> diff --git a/kernel/bpf/cpumap.c b/kernel/bpf/cpumap.c
> --- a/kernel/bpf/cpumap.c
> +++ b/kernel/bpf/cpumap.c

[ ... ]

> @@ -45,6 +45,7 @@
>   */
>
>  #define CPU_MAP_BULK_SIZE 8  /* 8 == one cacheline on 64-bit archs */
> +#define CPU_MAP_HELD_DEVS 2048
>  struct bpf_cpu_map_entry;
>  struct bpf_cpu_map;
>

[ ... ]

> @@ -74,6 +75,13 @@ struct bpf_cpu_map_entry {
>
>  	struct completion kthread_running;
>  	struct rcu_work free_work;
> +
> +	/*
> +	 * Every frame and skb in the queue holds a reference to its device.
> +	 * The kthread keeps it until nothing is left in GRO.
> +	 */
> +	struct net_device *held[CPU_MAP_HELD_DEVS];
> +	u32 nr_held;
>  };

Does embedding held[CPU_MAP_HELD_DEVS] in struct bpf_cpu_map_entry make the
entry too large for a slab object?

That is 2048 pointers, 16384 bytes on 64-bit, so the entry grows from about
360 bytes to about 16.7 KiB.  __cpu_map_entry_alloc() allocates it with:

    rcpu = bpf_map_kmalloc_node(map, sizeof(*rcpu), gfp | __GFP_ZERO, numa);

At that size the request is above KMALLOC_MAX_CACHE_SIZE (2 * PAGE_SIZE with
4K pages), so __do_kmalloc_node() sends it to __kmalloc_large_node_noprof().
That is an order-3 (32 KiB) physically contiguous page allocation, and about
half of it is never used.

Every cpumap entry, including each BPF_MAP_UPDATE_ELEM that changes qsize
(which reallocates the entry), now costs 32 KiB of order-3 memory charged to
the map's memcg, where it used to be a small kmalloc object.  A cpumap that
covers all CPUs on a large machine would add megabytes.

Under fragmentation the GFP_KERNEL | __GFP_NOWARN order-3 request has to go
through compaction or reclaim, or it fails with -ENOMEM where the old
allocation would have succeeded.  The commit message does not mention this
cost.

The array only bounds how many references the kthread keeps between full GRO
flushes.  Would a smaller CPU_MAP_HELD_DEVS, or allocating held[] separately
(for example with kvmalloc), avoid the large contiguous allocation?

[ ... ]

> @@ -398,10 +410,13 @@ static int cpu_map_kthread_run(void *data)
>  		/* Flush either every 64 packets or in case of empty ring */
>  		packets += n;
>  		empty = __ptr_ring_empty(rcpu->queue);
> -		if (packets >= NAPI_POLL_WEIGHT || empty) {
> -			cpu_map_gro_flush(rcpu, empty);
> +		full = empty || rcpu->nr_held > CPU_MAP_HELD_DEVS - CPUMAP_BATCH;
> +		if (packets >= NAPI_POLL_WEIGHT || full) {
> +			cpu_map_gro_flush(rcpu, full);
>  			packets = 0;
>  		}
> +		while (full && rcpu->nr_held)
> +			dev_put(rcpu->held[--rcpu->nr_held]);
>
>  		local_bh_enable(); /* resched point, may call do_softirq() */
>  	}

This isn't a bug, but are the comments describing this flush still accurate?

The full flush is now also forced when nr_held exceeds CPU_MAP_HELD_DEVS -
CPUMAP_BATCH (2040), even while the ring is non-empty, yet the comment above
still says:

    /* Flush either every 64 packets or in case of empty ring */

Also, cpu_map_gro_flush() still names its parameter 'empty' and still says:

    /*
     * If the ring is not empty, there'll be a new iteration soon, and we
     * only need to do a full flush if a tick is long (> 1 ms).
     * If the ring is empty, to not hold GRO packets in the stack for too
     * long, do a full flush.
     * ...
     */

It is now called with 'full', which can be true for a non-empty ring, so
both comments describe the old behaviour.  The reason for the extra full
flush (bounding how long the device references are held) is not visible
where the flush decision is made.

Would renaming the parameter (for example 'flush_all') and updating both
comments keep them in line with the code?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/39051545464
--===============0096483132692541398==--
