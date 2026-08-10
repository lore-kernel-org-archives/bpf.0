Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 189D63B71DF
	for <bpf@vger.kernel.org>; Mon, 10 Aug 2026 10:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786356049; cv=none; b=tgszF6lMyJNCmZZNCFy9I7QGgQdjj1mlBdfVzDVoXLNTx63NezCUTIw2/FpOileJET8HnBsa6FQka2L6B30Os/+JHG1Vt40qGkIfA77Dr+mOblCDyjLMqRCDYSvVpM9wJJbsgUYhB805b0Eh1bdPkWaXawITt56vggVla3b//ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786356049; c=relaxed/simple;
	bh=NB4KpmkwxFUffZzqOI6B0QBcmc7U6Grn/l1L8e8d/BU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ignwQwT3awEuCjAgKC7a3mUhvpE+jwRC6TRwZLx554vfqGYWU9tvc9X4ZVZ9NH6ZCwkxhFHOh2Ovp0z2yX0lr1bREM/ZXYjjXfpwIkMOsVcFwL96eXq80M/JGm2hAFGHqP32+l1rxYUoG0/cg3NdK63+nox2bZi5xdewQv6ePQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G7mzsGje; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G7mzsGje"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 946191F00A3A;
	Mon, 10 Aug 2026 10:00:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786356047;
	bh=DGmzD1waLCSQPkGz4f9bTt373/x9knyplBpEnkpapNM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=G7mzsGjebVYgajgwD9ZGm6OenyzzNU/S5JE5Lkh/pwU9QfKJZCj2uQ3yNi5Oq7sOf
	 bMWst3WR2VU4s7VF/fi/CFDYwLbIlh7ONPPq+QLm8WVivfvjWbAuXl7z/3lTQ1Fye5
	 0CAxj4GvGzPMa9Nt2LubEnKG+bLAJ0iz4sulFrlVPkKunNtaX+HkZFdjFEtbtbp09s
	 UwxNrQMN7yKu5u9eCBi3EVBx+z1sE+3Jo4PflXjaW6JuzBul/+XvnSsP6eT1wTzf2z
	 6BmXnVTWAr4YIOykHFGudrc24vXN269dl3s3aXjd/1U/WDKoFHgsr2/AeCt8nONFHP
	 rMNC4emSUGe4Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v2 3/3] bpf, arena: check range_tree_set return
 in arena_free_pages and arena_free_worker
Reply-To: sashiko-reviews@lists.linux.dev
To: chenyuan_fl@163.com
Cc: bpf@vger.kernel.org
In-Reply-To: <20260810094634.2723213-4-chenyuan_fl@163.com>
References: <20260810094634.2723213-1-chenyuan_fl@163.com>
 <20260810094634.2723213-4-chenyuan_fl@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 10 Aug 2026 10:00:47 +0000
Message-Id: <20260810100047.946191F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] A race condition between dropping the arena spinlock and flushing =
the TLB allows concurrent reallocation and stale TLB access, leading to an =
information leak.
--

--- Patch [3]: [PATCH bpf-next v2 3/3] bpf, arena: check range_tree_set ret=
urn in arena_free_pages and arena_free_worker ---
commit d52cc998404e8cd2b8a37ee307bab5c587ce8336
Author: Yuan Chen <chenyuan@kylinos.cn>

bpf, arena: check range_tree_set return in arena_free_pages and arena_free_=
worker

arena_free_pages() and arena_free_worker() now handle range_tree_set()
errors. arena_free_pages() aborts the free on error, and
arena_free_worker() moves range_tree_set() before PTE clearing so that a
failed tree update leaves the PTEs intact instead of freeing pages that
the arena free tree does not track.

> diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
> index 7b6847200b431..4597d9becb97a 100644
> --- a/kernel/bpf/arena.c
> +++ b/kernel/bpf/arena.c
> @@ -881,7 +881,12 @@ static void arena_free_pages(struct bpf_arena *arena=
, long uaddr, long page_cnt,
>  	if (ret)
>  		goto defer;
> =20
> -	range_tree_set(&arena->rt, pgoff, page_cnt);
> +	ret =3D range_tree_set(&arena->rt, pgoff, page_cnt);
> +	if (ret) {
> +		raw_res_spin_unlock_irqrestore(&arena->spinlock, flags);
> +		bpf_map_memcg_exit(old_memcg, new_memcg);
> +		return;
> +	}

[Severity: High]
This is a pre-existing issue, but does marking the range as free here,
before dropping the spinlock and flushing the TLB, create a race condition?

If CPU 1 calls arena_free_pages(), marks the pages as free via
range_tree_set(), clears the PTEs, and drops the spinlock:

        ret =3D range_tree_set(&arena->rt, pgoff, page_cnt);
        ...
        raw_res_spin_unlock_irqrestore(&arena->spinlock, flags);

Before CPU 1 executes flush_tlb_kernel_range(), could CPU 2 allocate the
same virtual address via bpf_arena_alloc_pages() and populate new PTEs?=20

If CPU 2 (or another CPU) previously accessed this virtual address, its
TLB might still point to the old physical page. Writes to this address
would then incorrectly modify the old physical page.

CPU 1 would then flush the TLB and free the old physical page to the buddy
allocator, potentially leaking sensitive data to other processes.

[ ... ]

> @@ -1004,11 +1009,18 @@ static void arena_free_worker(struct work_struct =
*work)
>  		kaddr =3D arena_vm_start + s->uaddr;
>  		pgoff =3D compute_pgoff(arena, s->uaddr);
> =20
> +		/*
> +		 * Mark the range as free before clearing PTEs so that
> +		 * if the range tree update fails we leave the PTEs
> +		 * intact, avoiding an unrecoverable state where pages
> +		 * are freed but the arena free tree does not track them.
> +		 */
> +		if (range_tree_set(&arena->rt, pgoff, page_cnt))
> +			continue;

[Severity: High]
This isn't a bug introduced by this patch, but does the same race
condition exist here in the asynchronous worker?

The worker marks the range as free via range_tree_set() and drops the
spinlock:

        if (range_tree_set(&arena->rt, pgoff, page_cnt))
                continue;
        ...
        raw_res_spin_unlock_irqrestore(&arena->spinlock, flags);

Before iterating the list again to call flush_tlb_kernel_range(), this
seems to expose the old physical pages to the same concurrent reallocation
race window as arena_free_pages().

> +
>  		/* clear ptes and collect pages in free_pages llist */
>  		apply_to_existing_page_range(&init_mm, kaddr, page_cnt << PAGE_SHIFT,
>  					     apply_range_clear_cb, &cdata);
> -
> -		range_tree_set(&arena->rt, pgoff, page_cnt);
>  	}
>  	raw_res_spin_unlock_irqrestore(&arena->spinlock, flags);
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260810094634.2723=
213-1-chenyuan_fl@163.com?part=3D3
