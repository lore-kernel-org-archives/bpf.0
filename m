Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB61F3BBFA7
	for <bpf@vger.kernel.org>; Mon, 10 Aug 2026 14:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786370931; cv=none; b=Cia2t+6qAJI+XZWu/qHWgCNB8RTi2jLIAL17QopSIxmJKygFvxlLdvqzEzlfcfSlsU/BCVAZTo/SX5VulIhVIJuQshtpUa2X8Fks7+t5NRZatdtDpybWeswec7JrY3+ekzpVIR3EFv74N1Ajgt7iB17fq0dUWP0yQiqJmm+A7uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786370931; c=relaxed/simple;
	bh=6GptQo2ii5+RWP64uQyOLJRp5bAZXbKAyNuYen7+xVE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=j/H/gnLqKRmarnPQEOF2k9xB8qcYGD+du7xCchdLgA1QeU8gv4QZ4mPt33PmtChKEw3gTya2iok1pDtSUe4TIwY+oNV+bEukElh7nBsdN77p0SUTalQlhqsMWkv58cAT2pbVEybWMhKQQoiyz0sy5/PJur0G6nRK5x50pjeIUN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OifWlxvY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OifWlxvY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4214E1F000E9;
	Mon, 10 Aug 2026 14:08:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786370930;
	bh=h60EKpK2YnLh4jVR+AqPc49VtjDm0vMVbgkVDYRz1e0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OifWlxvYa0I1CzndqM66cOR7n7SkIkdkYb3gETWwH//r4G5khRRoOwBvUpU6q8hrh
	 kyF8sUhEf3KegTSLqrq+hbOnDF7CztILY4+f1SgKM5QGV+nOCivPaZ+LfeXawvYMpE
	 xFwMqySv9jb8/b1ijg7UiR/Oq+2UEmxeIgH8Bx4eQZ/ERlAicdwE08PShP7Vy3QRB0
	 djXLU/Mk8WpFscWY7uggGR8Sqb9E6Lm6fHpmOZTvIv6UwbZVNXTenusjrfodsqMv4E
	 9UEoFkAhDEUnokKNkDAo5316r4/8sMjS39VhjrrMWmKGtZajEuU8MKpsdFFu60DrtT
	 BpaJYS2410Cmg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v3 3/3] bpf, arena: check range_tree_set return
 in arena_free_pages and arena_free_worker
Reply-To: sashiko-reviews@lists.linux.dev
To: chenyuan_fl@163.com
Cc: bpf@vger.kernel.org
In-Reply-To: <20260810134800.2875487-4-chenyuan_fl@163.com>
References: <20260810134800.2875487-1-chenyuan_fl@163.com>
 <20260810134800.2875487-4-chenyuan_fl@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 10 Aug 2026 14:08:49 +0000
Message-Id: <20260810140850.4214E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Physical memory leak in the BPF arena allocation rollback and defe=
rred free paths when `range_tree_set()` fails.
--

--- Patch [3]: [PATCH bpf-next v3 3/3] bpf, arena: check range_tree_set ret=
urn in arena_free_pages and arena_free_worker ---
commit 2ed41c8c8f7aaa211a3d44f83cea88768b2f5819
Author: Yuan Chen <chenyuan@kylinos.cn>

bpf, arena: check range_tree_set return in arena_free_pages and arena_free_=
worker

This commit adds error checking for range_tree_set() in the BPF arena
allocation rollback and free paths. If the tree update fails, it aborts
the page free operation or skips clearing PTEs to prevent untracked pages.

> diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
> index 7b6847200b431..1e519c3c229ca 100644
> --- a/kernel/bpf/arena.c
> +++ b/kernel/bpf/arena.c

[ ... ]

> @@ -881,7 +883,12 @@ static void arena_free_pages(struct bpf_arena *arena=
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
Does this early return cause a physical memory leak bounded by the lifetime
of the BPF map?

If arena_alloc_pages() fails midway due to memory limits, it attempts to
roll back the partially allocated physical pages by calling
arena_free_pages(). Under memory pressure, the range_tree_set() call is
highly likely to fail due to its internal kmalloc_nolock() allocation.

Aborting here leaves the physical pages mapped in the kernel VMA and
completely orphaned. Exchanging a virtual address space leak for a physical
memory leak on an error path under OOM conditions worsens memory pressure.

The pre-patch behavior of freeing pages and clearing PTEs appeared safe,
since bpf_arena_fault_handler() handles unmapped PTEs by mapping the
scratch_page.

>  	init_llist_head(&free_pages);
>  	cdata.arena =3D arena;

[ ... ]

> @@ -1004,11 +1011,18 @@ static void arena_free_worker(struct work_struct =
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
> +

[Severity: High]
Can this continue statement permanently leak the physical pages from the
free system?

When this skips PTE clearing and page collection, the subsequent loop in
arena_free_worker():

arena_free_worker() {
    ...
    llist_for_each_safe(pos, t, list) {
        s =3D llist_entry(pos, struct arena_free_span, node);
        ...
        kfree_nolock(s);
    }
    ...
}

unconditionally destroys the tracking span 's'. This abandons the pages,
leaving them orphaned rather than avoiding an unrecoverable state.

>  		/* clear ptes and collect pages in free_pages llist */
>  		apply_to_existing_page_range(&init_mm, kaddr, page_cnt << PAGE_SHIFT,
>  					     apply_range_clear_cb, &cdata);
> -
> -		range_tree_set(&arena->rt, pgoff, page_cnt);
>  	}
>  	raw_res_spin_unlock_irqrestore(&arena->spinlock, flags);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260810134800.2875=
487-1-chenyuan_fl@163.com?part=3D3
