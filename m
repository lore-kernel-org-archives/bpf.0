Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 419F2149DF1
	for <bpf@vger.kernel.org>; Sun, 12 Jul 2026 11:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783854115; cv=none; b=rUbQ79ChjMigrL5700JcFhhdkDWW3WCrAMo683Z0grk0biFVuqbrBIOIBdcqBEsJ0WuUBajY9NZ/Ln8UqoxWU/bmSg4n/QE3zydQlMzM9xNooFPlCgpMPMrZ20m0aaGCTi7Y56wv9AXGxQdvfALY/Df0TDdKfZXqEVCqrdrRhWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783854115; c=relaxed/simple;
	bh=Z01mgsZZRerRKeVLK+ig/XdyMMTc/F9Bnglfm/buDoc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=TjK5kJwX2IpjJwxEfzHCIHWgD0SJBV4GxfMqDY6TwGkOgiB+qq52TnDBM0h8PmmIfXwoA4Y7AZ72DN/S6s8aZg1G7JjtjzysAuTKNLHIiFR/Ep4GOgCaSkehdeGayFXk0wxi9IRVBUmDrEzXEv0UUa5s8JyJVnC93Ug3caEIsKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vd7pGdds; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vd7pGdds"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3965C1F000E9;
	Sun, 12 Jul 2026 11:01:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783854114;
	bh=TBzh//unrOGGKy2+Gpbr25wOXN7JD8xHybFJA6N4dS4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Vd7pGdds92wjubaEB8byoep2MJmt5FV7ib06/BmhIeThDP5t6267l5SV0rU2maHaR
	 IOXe1XVBY1aeYB7f6I1fQ9J11L27/am2ZwSGd+ZMXx9ODDr9Mmcz8DBAfyJizlO2Xc
	 iagIzbpmlhK6/EYSQl5JnizvoDy8x4916G+lkhm4AXBpuHE8fUK2tt/OYjJhUvkpsV
	 mM5jacqQdIz1fj3EASSEEeoUvARe8niPIpFtBw4U5mftKZvKgK8ZkKDmr4ZFT9ioGY
	 FbES9DeRpbSG77WvmT+da8Gq44kpk761JplcCmN+vmWfktG5v8k8bMYNKx9fkSRyq6
	 LQWQUZna3UH1Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH mm-hotfixes v2 2/4] x86/mm/pat: acquire mmap lock on
 page table free to avoid ptdump UAF
Reply-To: sashiko-reviews@lists.linux.dev
To: "Lorenzo Stoakes" <ljs@kernel.org>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260712-series-vmap-race-fix-v2-2-ad134cc3a12a@kernel.org>
References: <20260712-series-vmap-race-fix-v2-0-ad134cc3a12a@kernel.org>
 <20260712-series-vmap-race-fix-v2-2-ad134cc3a12a@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 12 Jul 2026 11:01:52 +0000
Message-Id: <20260712110153.3965C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Lockless walkers of `init_mm` (such as `lookup_address()` and =
`vmalloc_to_page()`) are entirely unprotected against CPA large page collap=
se, resulting in use-after-free and severe executable memory corruption.
- [Critical] Kernel page tables are freed locklessly and before being unlin=
ked in the error path of `populate_pgd()`, leading to concurrent ptdump Use=
-After-Free and hardware page table walker race conditions.
- [High] Acquiring `mmap_read_lock(&init_mm)` does not fully protect agains=
t `ptdump` use-after-free, as `ptdump` can walk kernel page tables while ho=
lding the `mmap_write_lock` of other `mm_struct`s.
--

--- Patch [2]: [PATCH mm-hotfixes v2 2/4] x86/mm/pat: acquire mmap lock on =
page table free to avoid ptdump UAF ---
commit e694327eb6fa8a3cd99ff84b5655377d8ebf1050
Author: Lorenzo Stoakes <ljs@kernel.org>
x86/mm/pat: acquire mmap lock on page table free to avoid ptdump UAF

This commit attempts to fix a use-after-free regression when ptdump walks
page tables that are concurrently being freed during a large page
collapse. It does so by acquiring the mmap_read_lock on init_mm around
the page table freeing loop in cpa_collapse_large_pages().

> diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
> --- a/arch/x86/mm/pat/set_memory.c
> +++ b/arch/x86/mm/pat/set_memory.c
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
This is a pre-existing issue, but does acquiring the lock on init_mm fully
protect against ptdump?

Looking at arch/x86/mm/debug_pagetables.c:ptdump_curknl_show(), the walk
is initiated using current->mm:

ptdump_walk_pgd_level_debugfs(m, current->mm, false);

Since this causes ptdump to acquire current->mm->mmap_lock instead of
init_mm's lock, could ptdump still walk these kernel page tables
concurrently with the collapse?

[Severity: Critical]
This is a pre-existing issue, but does taking mmap_read_lock protect
against lockless walkers?

Functions like lookup_address_in_pgd_attr() perform a lockless traversal:

if (pmd_leaf(*pmd) || !pmd_present(*pmd))
    return (pte_t *)pmd;
...
return pte_offset_kernel(pmd, address);

If a lockless walker checks pmd_leaf() just before the large page collapse
overwrites the PMD, could it evaluate pte_offset_kernel() on a huge page
payload instead of a page table array?

> +		list_for_each_entry_safe(ptdesc, tmp, &pgtables, pt_list) {
> +			list_del(&ptdesc->pt_list);
> +			pagetable_free(ptdesc);
> +		}
> +	}
>  }

[ ... ]

[Severity: Critical]
This is a pre-existing issue, but does unmap_pte_range() correctly
sequence freeing and unlinking page tables?

In the error rollback path of populate_pgd(), unmap_pte_range() clears
the PTEs and then calls try_to_free_pte_page():

arch/x86/mm/pat/set_memory.c:unmap_pte_range() {
    ...
    if (try_to_free_pte_page((pte_t *)pmd_page_vaddr(*pmd))) {
        pmd_clear(pmd);
        return true;
    }
    ...
}

Since try_to_free_pte_page() invokes pte_free_kernel() locklessly, the
memory is returned to the allocator before pmd_clear() unlinks the PMD.

Could a concurrent software or hardware page table walker traverse the
freed page before the PMD is cleared?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260712-series-vma=
p-race-fix-v2-0-ad134cc3a12a@kernel.org?part=3D2
