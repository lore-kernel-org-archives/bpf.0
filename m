Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 216FF3793A8
	for <bpf@vger.kernel.org>; Fri, 17 Jul 2026 17:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784310617; cv=none; b=giJaSwjJutqtm98JIZwmyRjnytOQiDFfiTSmbCHeBh3KHhsUzk31xIfCxhSg5xP6gVb6+8xLcJHnEQsWdfCx46ML9rzKi5G1uL3txSdO3fYpcAdF0K3i/fyJ0S1qfOle75UmqSsmv623C7P8MdyyCR7NGXZRL3XeEzY9uNNKgfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784310617; c=relaxed/simple;
	bh=O7snS6rlyYpPoI5WsiR3y7EUeHUL2zTOCy3fSm3H+dg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=QZGqe/zZgCZLpjW7eXO+DV9Kcgv+Ij3DEUmM+0TrmCK11uRAihk6vaphyXg3RpEA3N4WetQ5D12/i6qzKOmKbM/z+MPrWn1eed6m5KkuBAMuMh5A76d098pTXVmrR43HPPcTHyfZ53TuTQYm/olqZ9y2nS6GkR95zOuxREdPIcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W0XoeFEl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W0XoeFEl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 543751F000E9;
	Fri, 17 Jul 2026 17:50:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784310615;
	bh=S1h0qT4UYN47zRNMBFLFTk1vt40B9iwZunXTZkIt7jE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=W0XoeFElCtEuO+cajXMuXYF2lHDgAZ0ZyL9k/m+iK1oqt8kywFcBe18+R66CcJddl
	 jq39wyEp8hONY54APAPWTLc/mHoeaDkpUjwsVQC+XV7eRlmpar0mOGYwbGsJV/I6zU
	 5kQBWczNLYGM0RYzDt0SyYctZ1Q2p/SQepHDxHocUAAJouNBfkEM1PXBIMGENwL8u2
	 kqp9yaNqgC2bKxNlk1fKQXpkfyCKRLRFyscRoosU8lQqVqXKzfrzIt+2/YIQjvuOYF
	 PcE2Usr6l0mwMtfB82tSJjjHpWQN77rNzXj1btdD1Sg5ysfMOn+8p6nccp+TgI87r+
	 MyVHSME/NKrVg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH mm-hotfixes v5 2/5] x86/mm/pat: acquire init_mm write
 lock on collapse to avoid UAF
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TG9yZW56byBTdG9ha2VzIChBUk0p?= <ljs@kernel.org>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260717-series-vmap-race-fix-v5-2-606a0ac6d3e5@kernel.org>
References: <20260717-series-vmap-race-fix-v5-0-606a0ac6d3e5@kernel.org>
 <20260717-series-vmap-race-fix-v5-2-606a0ac6d3e5@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 17 Jul 2026 17:50:14 +0000
Message-Id: <20260717175015.543751F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] TOCTOU race in `_lookup_address_cpa` leading to kernel memory =
corruption.
- [High] Incomplete Use-After-Free fix against ptdump due to mmap_lock mism=
atch.
- [High] Use-after-free in `populate_pgd` rollback path due to premature pa=
ge freeing.
--

--- Patch [2]: [PATCH mm-hotfixes v5 2/5] x86/mm/pat: acquire init_mm write=
 lock on collapse to avoid UAF ---
commit b25bc68391fb2bdee5625f9af3d5344a0d10d51f
Author: Lorenzo Stoakes (ARM) <ljs@kernel.org>

x86/mm/pat: acquire init_mm write lock on collapse to avoid UAF
   =20
This commit adds scoped_guard(mmap_write_lock, &init_mm) to
cpa_collapse_large_pages() to avoid use-after-free issues with ptdump
and to serialize concurrent CPA walkers.

> diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
> index d023a40a1e034..d1e63f7d267ff 100644
> --- a/arch/x86/mm/pat/set_memory.c
> +++ b/arch/x86/mm/pat/set_memory.c
[ ... ]
> @@ -442,6 +443,18 @@ static void cpa_collapse_large_pages(struct cpa_data=
 *cpa)
>  	}
>  }
> =20
> +static void cpa_collapse_large_pages(struct cpa_data *cpa)
> +{
> +	/*
> +	 * Take the mmap write lock on init_mm to:
> +	 * - Avoid a use-after-free if raced by ptdump (which takes its own
> +	 *   write lock on init_mm).
> +	 * - Serialise concurrent CPA walkers.
> +	 */
> +	scoped_guard(mmap_write_lock, &init_mm)
> +		__cpa_collapse_large_pages(cpa);

[Severity: Critical]
This is a pre-existing issue, but does this lock actually serialize
concurrent CPA walkers like set_memory_rw() that might evaluate pmd_leaf()?

Other CPA walkers rely on cpa_lock and do not take init_mm's mmap lock.
If CPU1 executes __change_page_attr() via set_memory_rw(), it takes
cpa_lock, calls _lookup_address_cpa() -> lookup_address_in_pgd_attr(),
and evaluates pmd_leaf(*pmd) as false.

If CPU2 concurrently executes cpa_collapse_large_pages(), taking
mmap_write_lock(&init_mm) and pgd_lock, it collapses the PMD into a large
page (leaf).

CPU1 then continues and calls pte_offset_kernel(pmd), which reads the new
leaf PMD and incorrectly returns a pointer to the 2M data page itself.
Then set_pte_atomic() writes to this data page, corrupting physical memory.

Are concurrent standard CPA walkers able to race with this collapse since
they do not share the same lock?


[Severity: High]
This is a pre-existing issue, but does taking the mmap lock on init_mm
fully prevent races with ptdump?

When ptdump is triggered via debugfs, it calls
ptdump_walk_pgd_level_debugfs() on current->mm:

    ptdump_walk_pgd_level_debugfs(m, current->mm, false);

This takes mmap_write_lock(current->mm) in ptdump_walk_pgd(), which provides
no mutual exclusion against mmap_write_lock(&init_mm) taken here.

Since current->mm can be different from init_mm, won't ptdump concurrently
walk the shared kernel page tables while this function frees the PTE pages,
resulting in the same use-after-free this patch attempts to fix?

> +}
> +
>  static void cpa_flush(struct cpa_data *cpa, int cache)
>  {

[ ... ]

As a related note on pre-existing issues in this file:

[Severity: High]
This is a pre-existing issue, but is there a use-after-free in the
populate_pgd() rollback path due to premature page freeing?

In unmap_pte_range() during rollback (e.g., if populate_pgd() fails due to
OOM during dynamic encryption attribute changes via set_memory_encrypted()):

	if (try_to_free_pte_page((pte_t *)pmd_page_vaddr(*pmd))) {
		pmd_clear(pmd);

The PTE page is returned to the allocator by try_to_free_pte_page() before
pmd_clear() clears the PMD entry.

Could a concurrent ptdump or lockless walker read the PMD and access the
freed memory during this window?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260717-series-vma=
p-race-fix-v5-0-606a0ac6d3e5@kernel.org?part=3D2
