Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7887642B339
	for <bpf@vger.kernel.org>; Thu, 16 Jul 2026 14:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784213321; cv=none; b=ZNd3TIYmt0pELbhVVo7Qwfa4GXOwMsR5sZDJk8aOxWKSUbfLVCK15XwHYEqb0pgGM2IsTRhCcJCOlqbSdnBcuGSwEm91PXx75gT0sDn5XARB5v6vy3+/+Vy5kwgNGHgWjwiTEsOqrRqH1m7X6YNLVS0D4h5QboJtvUozeKTvEwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784213321; c=relaxed/simple;
	bh=JILSFi2HVRBAcBiWE5nq1EB2kJSOlUkj5SnLvuyDZTw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=KBT/eH5mzHfNSBp2ZBXdQ+oOr3h/xd0FYfIJHrxR5ibmbnHboxEck1jB7IzK+pMsiQcZzjcLJJUY61v26HfyGvaPBKgSRxQcYPAozJuh/Uqa664qoROvFRWrKoWgIb2g7sPDHHa5As8je8o52PisK25KJoTfP5bJdMEdq2ix1xI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NxEK2LPY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NxEK2LPY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DE1F1F00A3A;
	Thu, 16 Jul 2026 14:48:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784213320;
	bh=lDD5j3vAa0qwlWgT3VgOxgBcLuPwYh0kPt41DiefFQY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NxEK2LPY0Llyhii55po56ANWY4KNUjTn80bgmy2kCHs/Utg0Xd/PzxZ73tpo4xKuy
	 cysc3+NtDs7ncJLBgNdGDXqiEkVI6t59EP08Jq+pfHp22TmAFw4cS5pWsJOkEncV55
	 Qvpi2D7GfVVfm8p27Uo6vuHvsakjfMaBoUbHHHSiGRKTbNNI2w+A3Yu4Zmut5fEUDy
	 sdR8xq3u59xRb9RAmCC3FKm55JUejvxw1XTOWfBpiOyO93+C9nqqNbIykDipHhOVXN
	 F+TJcqtjIdDhhOj2UDnhlvTRdm/g3FdaTOvAZzAdrnM58GU/cCylPw4tMwWOdpnqBF
	 cQXWuCn4JWT9w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 1/3] bpf: Add memory usage for arena
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jiayuan Chen" <jiayuan.chen@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260716142746.8794-1-jiayuan.chen@linux.dev>
References: <20260716142746.8794-1-jiayuan.chen@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 16 Jul 2026 14:48:39 +0000
Message-Id: <20260716144840.3DE1F1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [Medium] The `nr_pages` counter is modified using plain writes while bein=
g read concurrently locklessly, constituting a data race.

Pre-existing issues:
- [High] Functions that can sleep and acquire sleepable locks are called wh=
ile holding a raw spinlock with interrupts disabled.
--

--- Patch [1]: [PATCH bpf-next 1/3] bpf: Add memory usage for arena ---
commit 68cbc4739a7a9be56d49db779d319ec002523097
Author: Jiayuan Chen <jiayuan.chen@linux.dev>
Subject: bpf: Add memory usage for arena

This patch adds memory usage tracking for the arena map type by counting
the pages mapped into the arena. It bumps a counter in apply_range_set_cb()=
=20
when a page is added, drops it in apply_range_clear_cb() when removed, and=
=20
returns the calculated usage in map_mem_usage().

> diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
> index 80b7b8a694464..bc34602116040 100644
> --- a/kernel/bpf/arena.c
> +++ b/kernel/bpf/arena.c

[ ... ]

> @@ -196,6 +198,7 @@ static int apply_range_set_cb(pte_t *pte, unsigned lo=
ng addr, void *data)
>  	set_pte_at(&init_mm, addr, pte, pteval);
>  #endif
>  	d->i++;
> +	d->arena->nr_pages++;
>  	return 0;
>  }

[Severity: Medium]
Is it safe to use a plain increment here since nr_pages is read concurrentl=
y?

In arena_map_mem_usage(), arena->nr_pages is read locklessly via
READ_ONCE(arena->nr_pages). The Linux Kernel Memory Model requires that wri=
tes
pairing with a lockless READ_ONCE must be marked with WRITE_ONCE to prevent
the compiler from splitting the writes or assuming no concurrent access.

Could this lead to incorrect statistics or torn writes?

[ ... ]

> @@ -227,10 +230,11 @@ static int apply_range_clear_cb(pte_t *pte, unsigne=
d long addr, void *data)
>  	 * scratches its PTE. A later bpf_arena_free_pages() over that range wa=
lks
>  	 * here. Without the skip, scratch_page would be freed.
>  	 */
> -	if (page =3D=3D d->scratch_page)
> +	if (page =3D=3D d->arena->scratch_page)
>  		return 0;
> =20
>  	__llist_add(&page->pcp_llist, d->free_pages);
> +	d->arena->nr_pages--;

[Severity: Medium]
Similar to the increment above, does this plain decrement need WRITE_ONCE()=
 to
safely pair with the READ_ONCE() in arena_map_mem_usage()?

[ ... ]

> @@ -506,8 +512,7 @@ static vm_fault_t arena_vm_fault(struct vm_fault *vmf)
>  	if (ret)
>  		goto out_sigsegv_memcg;
> =20
> -	struct apply_range_data data =3D { .pages =3D &page, .i =3D 0,
> -					 .scratch_page =3D arena->scratch_page };
> +	struct apply_range_data data =3D { .arena =3D arena, .pages =3D &page, =
.i =3D 0 };
>  	/* Account into memcg of the process that created bpf_arena */
>  	ret =3D bpf_map_alloc_pages(map, NUMA_NO_NODE, 1, &page);

[Severity: High]
This isn't a bug introduced by this patch, but does this function call
sleepable allocators while holding a raw spinlock?

In arena_vm_fault(), the raw spinlock is acquired before this block:

	if (raw_res_spin_lock_irqsave(&arena->spinlock, flags))

Then bpf_map_alloc_pages() performs sleepable memory allocations (GFP_USER
with __GFP_DIRECT_RECLAIM). Furthermore, apply_to_page_range() is called
shortly after, which may dynamically allocate kernel page tables using
GFP_PGTABLE_KERNEL while taking init_mm.page_table_lock (a sleepable
spinlock on PREEMPT_RT).

Can this cause a kernel panic (BUG: sleeping function called from invalid
context) or potential deadlocks?

[ ... ]

> @@ -696,8 +701,8 @@ static long arena_alloc_pages(struct bpf_arena *arena=
, long uaddr, long page_cnt
>  		bpf_map_memcg_exit(old_memcg, new_memcg);
>  		return 0;
>  	}
> +	data.arena =3D arena;
>  	data.pages =3D pages;
> -	data.scratch_page =3D arena->scratch_page;
> =20
>  	if (raw_res_spin_lock_irqsave(&arena->spinlock, flags))

[Severity: High]
This isn't a bug introduced by this patch, but are sleepable functions also
called inside this atomic section in arena_alloc_pages()?

After the lock is acquired, the code enters a loop that calls
bpf_map_alloc_pages() and apply_to_page_range(), both of which can sleep
or acquire sleepable locks.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260716142746.8794=
-1-jiayuan.chen@linux.dev?part=3D1
