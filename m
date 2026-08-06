Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07FB21D63F3
	for <bpf@vger.kernel.org>; Thu,  6 Aug 2026 03:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785986371; cv=none; b=BQPY5mP5pr/TK54tnOEF2hSgZSVyu6GarxutZ4EJ1H6Y0CPPpddh3kV7Y9mqiRYmrCbE7zLZRSeo1BGX5cnXZRGeSU3DnmO6xMabokDgkv1HcYnMCOL5tpTCaB5CrCxdnGhqkmx/5z+Gcu0fWonh8tA5qZortrundofXXft+HZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785986371; c=relaxed/simple;
	bh=rLbI7aQwbg52CainhrPhzRCE4lkh0/bFO5vST/9SPCc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ROgJU5ABCtm8YUOfiSXvYctexsJtTipcT9ETtvKOWANDTSGEI6CMsbY4DUzcRgntvBDXVpbW6gxOCpuPLzwjpdIBM08blrOCUiSjLgG0HgTHAO+V4nCtP1G2XIOIngqyTvOk8dYxs0k7QvGdBy1tPevbgdi/2g/ibsmIRVEOR2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Typavha8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Typavha8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61C701F00A3A;
	Thu,  6 Aug 2026 03:19:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785986369;
	bh=eC9+bNXkrJ08g77uocUcJjkXO54GpboY5OMzlz6+a30=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Typavha8muXkqMX7R2bVKF1Jbk95eVdYhW5pB4QC5g3uNeFWZoSHtwFL7DTQKUvzw
	 xRzyii7ysgNbBmSz+nubSRWRoobki1Ui6jRj6Njb+Ysi7xM/3t4vYxYk8lB/wdQXjP
	 5DhGhAQriqiidXLx+BeFrHC2qROKrA5X1JDYlbKSPNmTB9pxxS6Cv91L/w78efys79
	 JvGNoJNM2esdCqviTMp/dRfHC/xDupz/tEgyDFnfWGo0fhb86rYmH00EXGGEeMWQgC
	 YEsbDNJ0dL3eh9C/ctrhZHJc+IHGN/QWYm0OnmCQDGqRc01OkV0VMJLysX5s21QUOB
	 R1cl1WIZphlow==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v1 3/3] bpf, arena: check range_tree_set return
 in arena_free_pages and arena_free_worker
Reply-To: sashiko-reviews@lists.linux.dev
To: chenyuan_fl@163.com
Cc: bpf@vger.kernel.org
In-Reply-To: <20260806030359.299480-4-chenyuan_fl@163.com>
References: <20260806030359.299480-1-chenyuan_fl@163.com>
 <20260806030359.299480-4-chenyuan_fl@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 06 Aug 2026 03:19:28 +0000
Message-Id: <20260806031929.61C701F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [Low] The newly introduced multi-line comment in `arena_free_worker` does=
 not follow the required BPF subsystem comment style (the opening `/*` is n=
ot on its own line).

Pre-existing issues:
- [High] TLB flush race in BPF arena free path allows BPF data corruption a=
nd leaking data to the page allocator.
--

--- Patch [3]: [PATCH bpf-next v1 3/3] bpf, arena: check range_tree_set ret=
urn in arena_free_pages and arena_free_worker ---
commit e8687a8aed3ed0a8e5127b69fdd0e533b6129491
Author: Yuan Chen <chenyuan@kylinos.cn>

bpf, arena: check range_tree_set return in arena_free_pages and arena_free_=
worker

This commit updates arena_free_pages() and arena_free_worker() to handle
range_tree_set() errors. In arena_free_pages(), it aborts the free on
error, and in arena_free_worker(), it moves range_tree_set() before PTE
clearing.

> diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
> index 555ee2531ef98..30745da9277b0 100644
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
This is a pre-existing issue, but does updating the free range tree under
arena->spinlock and then dropping the lock before flushing the TLB create a
race condition?

In both arena_free_pages() and arena_free_worker(), the spinlock is dropped
before flush_tlb_kernel_range() is called.=20

If another thread concurrently allocates this same virtual address, maps new
physical pages into the PTE, and returns to the BPF program, could the new
program write to the old physical page due to stale TLB entries on that CPU?

When the first thread resumes, it would execute the TLB flush and free the
old physical page to the buddy allocator, which might cause data corruption
or leak data to the page allocator.

>  	init_llist_head(&free_pages);
>  	cdata.arena =3D arena;

[ ... ]

> @@ -1004,11 +1009,17 @@ static void arena_free_worker(struct work_struct =
*work)
>  		kaddr =3D arena_vm_start + s->uaddr;
>  		pgoff =3D compute_pgoff(arena, s->uaddr);
> =20
> +		/* Mark the range as free before clearing PTEs so that
> +		 * if the range tree update fails we leave the PTEs
> +		 * intact, avoiding an unrecoverable state where pages
> +		 * are freed but the arena free tree does not track them.
> +		 */

[Severity: Low]
Does this multi-line comment follow the BPF subsystem style?=20

The BPF subsystem guidelines require the opening /* to be on its own line:

/*
 * Mark the range as free before clearing PTEs so that
 ...

> +		if (range_tree_set(&arena->rt, pgoff, page_cnt))
> +			continue;
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260806030359.2994=
80-1-chenyuan_fl@163.com?part=3D3
