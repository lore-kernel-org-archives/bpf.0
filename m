Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CF6B3FA5FC
	for <bpf@vger.kernel.org>; Thu, 23 Jul 2026 15:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784820873; cv=none; b=ncGQYALaCWNoFQ+gYrZdStMcbkTalF74CJ2qLtYU0CtsE7FXTvGsG71BWQAHDgk2sD0tMB40R0MG+w9YpDxzsbTP0kVg7xJTO6BGI2RAcLJCuLsU68pCHHZ7VmkzYCN+3XVH5OL/FyMT/KYlV2pISZNZM/0sNkiECBxSCvoOmCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784820873; c=relaxed/simple;
	bh=5+Oidvt6Y6nd/IYEEQav0OWntlRQWlpvILC++f8ZjL4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ETj1PFtmbGJyzH7AmSPzqLt9Uc1KM4p1FKh0mbP6hiA1u9mVhr2Ap0lCfCU6+wumWrsTNHwgvCJUH58CbnlAluLnzCCpcPUNbHWHToc0UcYr7LuV3Q+fifaa3cVoq3yR6a9RFb94GGERZNTQTwsUplDtW5m8phAhSCeaQUvWe0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EFE51F00A3A;
	Thu, 23 Jul 2026 15:34:25 +0000 (UTC)
From: sashiko-bot@kernel.org
Subject: Re: [PATCH mm-hotfixes v6 3/5] x86/mm/pat: acquire init_mm read
 lock on attribute change to avoid UAF
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TG9yZW56byBTdG9ha2VzIChBUk0p?= <ljs@kernel.org>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260723-series-vmap-race-fix-v6-3-8cc77dcc0018@kernel.org>
References: <20260723-series-vmap-race-fix-v6-0-8cc77dcc0018@kernel.org>
 <20260723-series-vmap-race-fix-v6-3-8cc77dcc0018@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 23 Jul 2026 15:34:23 +0000
Message-Id: <20260723153426.0EFE51F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Lockless callers of __change_page_attr_set_clr() remain vulnerable=
 to Use-After-Free because set_memory_rox() and CPA_COLLAPSE operate on the=
 direct map.
--

--- Patch [3]: [PATCH mm-hotfixes v6 3/5] x86/mm/pat: acquire init_mm read =
lock on attribute change to avoid UAF ---
commit 99a1d277a38cbe15d561ae13b70590f794c51988
Author: Lorenzo Stoakes (ARM) <ljs@kernel.org>
x86/mm/pat: acquire init_mm read lock on attribute change to avoid UAF

This commit resolves a use-after-free race between a lockless page table
walker and concurrent CPA collapse by acquiring the init_mm mmap read lock.
It also temporarily drops the lock during page table allocations to avoid
deadlocks with memory reclaim.

Link: https://lore.kernel.org/all/20260626163213.2284080-1-den@openvz.org/

> The CPA_COLLAPSE flag is only set by set_memory_rox(), which exclusively
> operates upon vmalloc ranges, and on x86 only within the module mapping
> space.
>=20
> This is important, because some callers directly invoke
> __change_page_attr_set_clr(), bypassing this lock. However, none of these
> operate within the module mapping space.
>=20
> * cpa_process_alias() - a recursive helper called by
>   __change_page_attr_set_clr().
> * __set_memory_enc_pgtable() - operates on the direct mapping and (via
>   __vmbus_establish_gpadl()) the vmalloc mapping space.
> * __set_pages_[n]p() - called by set_direct_map_[invalid, default,
>   valid]_noflush(), __kernel_map_pages() - operates on the direct map.

[Severity: High]
This is a pre-existing issue, but is the assumption that set_memory_rox()
exclusively operates upon vmalloc ranges accurate?

Looking at machine_kexec_prepare(), it appears to call set_memory_rox() on
control_page, which is a direct map address. If set_memory_rox() operates
on the direct map, could a concurrent vfree() trigger a use-after-free?

For example, if CPU 1 is doing kexec:

machine_kexec_prepare()
  set_memory_rox() -> sets CPA_COLLAPSE
    cpa_collapse_large_pages() -> replaces a page table with a huge page
                                  and frees the PTE page table via
                                  pagetable_free()

And CPU 2 is concurrently doing vfree():

vfree()
  vm_reset_perms()
    set_area_direct_map()
      set_direct_map_invalid_noflush()
        __set_pages_np() -> calls __change_page_attr_set_clr() locklessly

If CPU 2 performs a lockless walk on direct map pages that share the same
2MB region being collapsed by CPU 1, could it access the freed PTE page?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260723-series-vma=
p-race-fix-v6-0-8cc77dcc0018@kernel.org?part=3D3
