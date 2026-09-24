Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1430D40B6E9
	for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 06:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790231382; cv=none; b=hkgD8G50tq+ZmLnOetTwMq2rzIvVwVvJ0rBTSxTKJ92Lc5rzpN8bbUD/X3RhulCB2o6yIaaoRD0w6Elrz16lSo9UgKBY4qHnoMff4xRDt98d5kzbHO78fFf681NprJuyb1SgoAZPvWxBB4sk4fCMYAoM3BZ65UzQjNiCrNqXLbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790231382; c=relaxed/simple;
	bh=BuIXD8S5l5q/0slqUTWFMSUmWWK4KXiXvi0pgDAzVQ4=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=l7Vbdkqp0/DkwQLup2DM++JjFhjeMfkVmTirNMLy7w4Mxm+hEjzCQCW6GE1H+CVs60vrx6tMNa3eH3niJqKDdEKfAhX1I9zd22ATLmmruPwivNzAosEql5b1BuulbdDRpVsdWr1DKty9hOzXHqBB1kJVYyFNn9c7fmLruApiJPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e8B6swKZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e8B6swKZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 953091F00893;
	Thu, 24 Sep 2026 06:29:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790231376;
	bh=/8eP/br0Gftf8ak3Kn1eNXXk6acXtNOZxbzEzlvwgqc=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=e8B6swKZ3iKSEM5d/CJvBrDHwxZek/AJvDE3WhDHFhI9SzNAdYFuLBrcs8+reOKqk
	 K8tIICpd5dL1dHuC4jN3/YeCS2L6CpujfqgTX8sjwouqqi7Q1Q3CAgQuirzEovzbqC
	 J7FfRVADxWdelHx3ZH5qzjUgj7gW4qEaqMRpDA8BHk5TlSIZSlgnx6BwzESo+y4lbv
	 SsdHJIvh1nDZJsXZfYxBMsZVDCJHjFqtu+oBfh1zrLIVMr+9TR14sLZoc0/qGolof/
	 7JbIz5aqYDfWbvj8O/ZGgfSlxiYvSbvHGyBi6/+KuaTqx1gthUFtzmkpHdNp8uatAK
	 iDjE+OSPGACUg==
Content-Type: multipart/mixed; boundary="===============5761656831470524727=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <8012e6b9f32534518dd069e927814eceb41c0f3bd7474c64349143d4283aa4be@mail.kernel.org>
In-Reply-To: <20260924053621.7076-2-emil@etsalapatis.com>
References: <20260924053621.7076-2-emil@etsalapatis.com>
Subject: Re: [PATCH bpf v2 1/2] bpf: Add sleepable arena page allocation path
From: bot+bpf-ci@kernel.org
To: emil@etsalapatis.com,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,daniel@iogearbox.net,emil@etsalapatis.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Thu, 24 Sep 2026 06:29:34 +0000 (UTC)

--===============5761656831470524727==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 1d2676782d70..71688190a7f0 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h

[ ... ]

> diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
> index 7b6847200b43..013faacc4551 100644
> --- a/kernel/bpf/arena.c
> +++ b/kernel/bpf/arena.c

[ ... ]

> @@ -698,31 +721,38 @@ static long arena_alloc_pages(struct bpf_arena *arena, long uaddr, long page_cnt
>  	}
>
>  	bpf_map_memcg_enter(&arena->map, &old_memcg, &new_memcg);
> -	/* Cap allocation size to KMALLOC_MAX_CACHE_SIZE so kmalloc_nolock() can succeed. */
> -	alloc_pages = min(page_cnt, KMALLOC_MAX_CACHE_SIZE / sizeof(struct page *));
> -	pages = kmalloc_nolock(alloc_pages * sizeof(struct page *), __GFP_ACCOUNT, NUMA_NO_NODE);
> -	if (!pages) {
> -		bpf_map_memcg_exit(old_memcg, new_memcg);
> -		return 0;
> +
> +	can_sleep = sleepable && !is_bpf_alloc_nonsleepable();
> +	if (can_sleep) {
> +		alloc_pages = page_cnt;
> +		pages = kvcalloc(page_cnt, sizeof(struct page *), GFP_KERNEL_ACCOUNT);
> +		if (!pages)
> +			goto out_memcg;
> +
> +		ret = bpf_map_alloc_pages(&arena->map, node_id, page_cnt, pages);
> +		if (ret)
> +			goto out_free_array;
> +		data.i = 0;
> +	} else {
> +		/* Cap allocation size so kmalloc_nolock() can succeed. */
> +		alloc_pages = min(page_cnt, KMALLOC_MAX_CACHE_SIZE / sizeof(struct page *));
> +		pages = kmalloc_nolock(alloc_pages * sizeof(struct page *), __GFP_ACCOUNT,
> +				       NUMA_NO_NODE);
> +		if (!pages)
> +			goto out_memcg;
>  	}
> +
>  	data.arena = arena;
>  	data.pages = pages;
>
>  	if (raw_res_spin_lock_irqsave(&arena->spinlock, flags))
>  		goto out_free_pages;
>
> -	if (uaddr) {
> -		ret = is_range_tree_set(&arena->rt, pgoff, page_cnt);
> -		if (ret)
> -			goto out_unlock_free_pages;
> -		ret = range_tree_clear(&arena->rt, pgoff, page_cnt);
> -	} else {
> -		ret = pgoff = range_tree_find(&arena->rt, page_cnt);
> -		if (pgoff >= 0)
> -			ret = range_tree_clear(&arena->rt, pgoff, page_cnt);
> +	ret = arena_adjust_tree(arena, uaddr, page_cnt, &pgoff);
> +	if (ret) {
> +		raw_res_spin_unlock_irqrestore(&arena->spinlock, flags);
> +		goto out_free_pages;
>  	}
> -	if (ret)
> -		goto out_unlock_free_pages;

In the sleepable path, the code now preallocates the entire pointer
array via kvcalloc(page_cnt, ..., GFP_KERNEL_ACCOUNT) and all page_cnt
pages via bpf_map_alloc_pages() before checking whether the requested
arena range is actually available.

The range check happens later in arena_adjust_tree() under the spinlock.
That check rejects requests where a uaddr hint overlaps already
allocated pages (is_range_tree_set() returns -ESRCH) or where no
contiguous free range exists (range_tree_find() returns -ENOENT).

The old code ran these checks under the lock before allocating anything,
so rejected requests returned NULL at minimal cost. With the new
sleepable path, each rejected request allocates and zeroes all the pages
first via GFP_KERNEL allocations, potentially pushing the system into
direct reclaim or OOM, then frees them all through the out_free_pages
loop.

Can a sleepable program that retries a fixed-address allocation or
probes an almost-full arena repeatedly cause large reclaim and OOM
pressure for requests that were never going to succeed?

One approach would be to reserve the range under the lock first via
arena_adjust_tree() and allocate afterwards, restoring the range with
range_tree_set() if allocation fails. Another option would be an
unlocked or locked precheck against the range tree before
preallocating.

[ ... ]

> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index 244a939b9d2d..9eeb65f2d929 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/35961888778
--===============5761656831470524727==--
