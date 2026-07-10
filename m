Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C1B4413D6F
	for <bpf@vger.kernel.org>; Fri, 10 Jul 2026 12:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783685696; cv=none; b=NEiQPxBU0JQeT6SSa6WWpuJDh8ns7DFKLawpvQsTBvfId9bw/60IVXuAgZQBy1m3RplavlTI2tp8syb9qUCZSx10oy4VuGdytsC7x89KMaBgZi5WuLVMTViGfq3QlBDMtaRN+NN8ji/g9xyXaVrI4kEv577tQ+smlBlnSzwxQEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783685696; c=relaxed/simple;
	bh=geJXDNX8twDQiZng3bk/RrWeGZLkzPaDNl+6xbCuzl8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=bU8AqbVqWLlgOd8YWEn9hrh6/5r8p/aPW/KjDgcAx3uxCZS3/GdcRACKlzf4hvNbpkjuZAYoG3+G/r1oqYQ78IPwrrnJFxmD2+WpSg7E1+7nh3gQc3Ik91G6tHhuHxnx8IOD6Uaa/EiieFbK8ADz25atgzbb8m0pi6BVhYesQwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YjKlxZQF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YjKlxZQF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE3C11F000E9;
	Fri, 10 Jul 2026 12:14:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783685695;
	bh=LESwJp72H57QQuCbTlaELyGeExQ7fDOYoqbAkTT5OjQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YjKlxZQF6Q9Wj8ggcJNZ138LwtOFGPfTIljS7uXxjAm9ti0o/piEHQU9b0fhn3WkP
	 17vwP3i2ie0f256S/s/5+00XAbePfnEhzcPoC6O2ccSaYkdD9hqTAVWFaJnpOmevpV
	 QdDfIcyAl1NcZQ4qm2/3IauNCDw95OcjVrgq47sszY/gmJgqmCAheiM9bQm0K+C5kb
	 lytspWJCcMBCp0vij0Uz1Z50kHKVZYBZ0G4OCG8aPdFprfw5O/RxuT16G21zN1ymBk
	 hSdKHsG2b3wxAVwzpiR6/CShL5mDfok1Dc5aCHIR78nZMPcqyhX2UifBhniiv8jdz9
	 giaCQk5BxR0MQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] x86/mm/pat: acquire mmap lock on page table free to
 avoid ptdump UAF
Reply-To: sashiko-reviews@lists.linux.dev
To: "Lorenzo Stoakes" <ljs@kernel.org>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260710-fix-cpa-ptdump-race-v1-1-d898699a7417@kernel.org>
References: <20260710-fix-cpa-ptdump-race-v1-1-d898699a7417@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 10 Jul 2026 12:14:54 +0000
Message-Id: <20260710121454.BE3C11F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The patch fails to protect ptdump invocations on mm_structs other =
than init_mm (such as current->mm or efi_mm), leaving them vulnerable to Us=
e-After-Free.
- [High] The patch fails to protect lockless kernel page table walkers from=
 a Use-After-Free race when freeing collapsed page tables.
--

--- Patch [1]: [PATCH] x86/mm/pat: acquire mmap lock on page table free to =
avoid ptdump UAF ---
commit 34992f845258302500edbd0c5e7fac8afe267207
Author: Lorenzo Stoakes <ljs@kernel.org>

x86/mm/pat: acquire mmap lock on page table free to avoid ptdump UAF

This commit attempts to fix a use-after-free issue when ptdump walks kernel
page tables concurrently with them being collapsed and freed by CPA. It adds
an mmap_read_lock on init_mm during the free operation.

> diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
> index d023a40a1e034..4c4b8244502fc 100644
> --- a/arch/x86/mm/pat/set_memory.c
> +++ b/arch/x86/mm/pat/set_memory.c

[ ... ]

> @@ -436,9 +437,16 @@ static void cpa_collapse_large_pages(struct cpa_data=
 *cpa)
> =20
>  	flush_tlb_all();
> =20
> -	list_for_each_entry_safe(ptdesc, tmp, &pgtables, pt_list) {
> -		list_del(&ptdesc->pt_list);
> -		pagetable_free(ptdesc);
> +	/*
> +	 * ptdump might read these page tables, so avoid a use-after-free by
> +	 * acquiring the mmap read lock on init_mm (ptdump acquires the mmap
> +	 * write lock).
> +	 */
> +	scoped_guard(mmap_read_lock, &init_mm) {

[Severity: High]
This isn't a bug introduced by this patch, but does locking init_mm protect
ptdump invocations that use a different mm_struct?

For example, when reading /sys/kernel/debug/page_tables/current_kernel,
the kernel calls ptdump_curknl_show() which invokes ptdump on current->mm:

arch/x86/mm/debug_pagetables.c:ptdump_curknl_show() {
    ...
    ptdump_walk_pgd_level_debugfs(m, current->mm, false);
    ...
}

The ptdump walker will acquire the mmap_write_lock for current->mm, entirely
bypassing the init_mm lock added here. Can this still lead to a
use-after-free if set_memory_rox() concurrently frees a PTE page while
ptdump_curknl_show() is reading it?

> +		list_for_each_entry_safe(ptdesc, tmp, &pgtables, pt_list) {
> +			list_del(&ptdesc->pt_list);
> +			pagetable_free(ptdesc);

[Severity: High]
This is a pre-existing issue, but does mmap_read_lock protect against
lockless kernel page table walkers?

Functions like vmalloc_to_page() traverse kernel page tables locklessly:

mm/vmalloc.c:vmalloc_to_page() {
    ...
    ptep =3D pte_offset_kernel(pmd, addr);
    pte =3D ptep_get(ptep);
    ...
}

If a lockless walker reads a PMD and gets preempted, and concurrently
cpa_collapse_large_pages() collapses the PMD and synchronously frees the
page table to the buddy allocator via pagetable_free(), will the walker
dereference freed memory when it resumes?

Since mmap_read_lock does not block lockless walkers, would fixing this
properly require RCU-delayed freeing for kernel page tables instead of
synchronous freeing?

> +		}
> +	}
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260710-fix-cpa-pt=
dump-race-v1-1-d898699a7417@kernel.org?part=3D1
