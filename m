Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F158F374A1F
	for <bpf@vger.kernel.org>; Wed,  2 Sep 2026 07:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788333553; cv=none; b=L2qbmP4ToErHnnx0dSOP7/HChQx55w/Qnxk10rQtWUU1C23OeXx/TUJu4m3RlJoZYsCf9+ar93r7CENlGacegr7OiF03ymrIEvJJLBKiCLuo8LtryiXlBIQfGJh6+wvECrpqrZc9+rNXHXYM2ctij4Qas7Tvap2sicCRXhQKtas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788333553; c=relaxed/simple;
	bh=/exuGaS4krxKz2hioM/uE45KtKrJfasEOojR67LBjY8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=OFR39bq5QUF3zzQGDU/wzCSusJul5g4Y1MY4eUN1AGKX5pFX9lDxPJxlqRf5eYjewcfhRYpsWdGxzQZdIVwHLmFnh9X9d6lKVb3Rcdr0AGuqCGyjr7aZc7r3xmH4m2FyCo1NMnmMy9KJCt0BHNUZlG1D/AjSp8/wDbsCmenk9IY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bdFG8jwP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bdFG8jwP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B63B1F000E9;
	Wed,  2 Sep 2026 07:19:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788333547;
	bh=RTU8epFu8TDOv1aEblgSB8cxxFaVpahC3jou+3V0XfA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bdFG8jwPGmhy6cVykruphDEL10Hx2ZyY3wrOAdY3jAm2QH6Qaaw7xxbG6Wwhc6O6Z
	 Se1LMIzDDPtLtus/AFn4mHSmZZ2TpXAbcIhv+F/vIF+3nvQ2PVqZqEwJedun6ItT63
	 ikuT1Lva/dZyNcwGpBHYYOyKM0CAKShBj0vIcS4/jtKLEpGNRxuFharUyMt9i3IbQ5
	 AL3V7yB+fRX9Kmo58VnZoqxOxySoJSv8/qUgaEwylFV2rBoMZ25l7IoV7Ff5arBgy0
	 NrIqACZUfB7W4JRwxMRXnZwcD5YjYs8aapVVHzhaV58lSUQaRpd0x1RhmdgOYaJPuK
	 lZx5wbZ+bFQNg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 4/5] bpf: Atomically update PTE and range tree
 in arena VM fault handler
Reply-To: sashiko-reviews@lists.linux.dev
To: "Emil Tsalapatis" <emil@etsalapatis.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260902070239.16968-5-emil@etsalapatis.com>
References: <20260902070239.16968-1-emil@etsalapatis.com>
 <20260902070239.16968-5-emil@etsalapatis.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 02 Sep 2026 07:19:07 +0000
Message-Id: <20260902071907.8B63B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

New issues:
- [High] Concurrent free operations are silently dropped if they race with =
page faults, causing unrecoverable memory leaks.
- [High] Spurious SIGBUS on transient page contention for concurrent page f=
aults.
- [High] Lock imbalance (underflow) on retry when called under the per-VMA =
lock.

Pre-existing issues:
- [High] Sleeping in atomic context during page table allocation/mapping.
--

commit 9df1d7e4529a5986fc13837866875a32b59d72bd
Author: Emil Tsalapatis <emil@etsalapatis.com>

bpf: Atomically update PTE and range tree in arena VM fault handler

This patch addresses a race condition in the arena VM fault handler by
temporarily marking the page range as unavailable while dropping the
range tree spinlock to insert the PTE. It also adds logic to return
VM_FAULT_RETRY for transient allocation failures.

> diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
> index d22b71a791db3..d7006cdb98990 100644
> --- a/kernel/bpf/arena.c
> +++ b/kernel/bpf/arena.c
> @@ -514,6 +510,14 @@ static vm_fault_t arena_vm_fault(struct vm_fault *vm=
f)
>  		goto out_sigsegv_memcg;
> =20
>  	ret =3D range_tree_clear(&arena->rt, vmf->pgoff, 1);
> +	/* If a range is unavailable, try again. */
> +	if (ret =3D=3D -EAGAIN) {
> +		raw_res_spin_unlock_irqrestore(&arena->spinlock, flags);
> +		bpf_map_memcg_exit(old_memcg, new_memcg);
> +
> +		goto retry;
> +	}
> +
>  	if (ret)
>  		goto out_sigsegv_memcg;

[Severity: High]
This isn't a bug introduced by this patch, but is it safe to call
bpf_map_alloc_pages() and apply_to_page_range() directly after this block?

The spinlock is acquired via raw_res_spin_lock_irqsave() at the start of
arena_vm_fault(), which disables hardware interrupts. Just below this diff,
we have:

    ret =3D bpf_map_alloc_pages(map, NUMA_NO_NODE, 1, &page);
    if (ret) {
        ...
    }
    ret =3D apply_to_page_range(&init_mm, kaddr, PAGE_SIZE, ...);

Since both of these functions can allocate memory and take sleepable locks
(especially under PREEMPT_RT), could this cause a sleeping-in-atomic-context
violation?

[ ... ]

> @@ -534,15 +538,41 @@ static vm_fault_t arena_vm_fault(struct vm_fault *v=
mf)
> +retry:
> +
> +	/* Only for special cases (GUP/device drivers). */
> +	if (!(vmf->flags & FAULT_FLAG_ALLOW_RETRY))
> +		return VM_FAULT_SIGBUS;

[Severity: High]
Could this lead to spurious SIGBUS crashes for userspace applications?

When two threads fault on the same arena page concurrently, the first
thread sets the page to unavailable. The second thread receives -EAGAIN
and jumps to the retry label.

However, if this is the second attempt (where FAULT_FLAG_ALLOW_RETRY has
been cleared, e.g., in do_user_addr_fault), it seems this will escalate
the transient contention into a fatal VM_FAULT_SIGBUS instead of waiting
for the first thread to finish.

> +
> +	if (!(vmf->flags & FAULT_FLAG_RETRY_NOWAIT))
> +		release_fault_lock(vmf);

[Severity: High]
Does this properly handle faults entered under the per-VMA lock?

The release_fault_lock() helper unconditionally calls mmap_read_unlock().
If the fault was entered under the RCU-based per-VMA lock (indicated by
FAULT_FLAG_VMA_LOCK), it appears this would mistakenly unlock the unheld
mmap_lock and leak the VMA lock, potentially causing an imbalance.=20

Should this check for FAULT_FLAG_VMA_LOCK and call vma_end_read() when
appropriate?

> +
> +	return VM_FAULT_RETRY;
>  }

[ ... ]

> @@ -888,7 +918,9 @@ static void arena_free_pages(struct bpf_arena *arena,=
 long uaddr, long page_cnt,
>  		raw_res_spin_unlock_irqrestore(&arena->spinlock, flags);
>  		if (ret =3D=3D -ENOMEM)
>  			goto defer;
> -		WARN_ON_ONCE(ret);
> +		/* An overlapping fault reserves the range before installing its PTE. =
*/
> +		if (ret !=3D -EAGAIN)
> +			WARN_ON_ONCE(ret);
>  		bpf_map_memcg_exit(old_memcg, new_memcg);
>  		return;
>  	}

[Severity: High]
Will this silently drop concurrent free operations?

If range_tree_set_unavail() returns -EAGAIN because an overlapping fault
has temporarily reserved the range, the function returns immediately without
freeing the page or deferring the work.

Since the fault handler does not free the memory either, it looks like the
page might permanently leak. Should the -EAGAIN case be retried or deferred
similar to the -ENOMEM case?

[ ... ]

> @@ -1043,7 +1075,7 @@ static void arena_free_worker(struct work_struct *w=
ork)
>  			 * the defer: path of arena_free_pages(). Do not treat
>  			 * the leak as a bug.
>  			 */
> -			if (ret !=3D -ENOMEM)
> +			if (ret !=3D -ENOMEM && ret !=3D -EAGAIN)
>  				WARN_ON_ONCE(ret);
> =20
>  			kfree_nolock(s);
>  			continue;

[Severity: High]
Similar to the previous concern, does this permanently leak deferred free
operations that encounter an unavailable range?

If the deferred worker gets -EAGAIN, it frees the tracking span and
continues, effectively discarding the free request.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260902070239.1696=
8-1-emil@etsalapatis.com?part=3D4
