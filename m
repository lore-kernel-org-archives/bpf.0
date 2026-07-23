Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C86F472F74
	for <bpf@vger.kernel.org>; Thu, 23 Jul 2026 15:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784820847; cv=none; b=N2zmGNoD9Kn3tWE3KiMGe3+rOThXyCj3SAd7xCL84AsTeEa5vabsmoilo0poMRh4IU+FhTz5nEN1+UEuQcD/8Aeuj0HTR6rapXikpCQDwarOQEtkjvYKYMtMcsxxu5DY4uprTLfNvtbGszbLN8NBfuMnmGNu4pE/MFt3LOfIKZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784820847; c=relaxed/simple;
	bh=IS6ogMKG9NL29Dq1ZCzVERKxTMcD2W/V/2ixS/JL7AA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=f0kmL1eOMtLu28zVZ37HxgsxxdOQK8tXSJUSEzfNFMJQyJoZZMPn1FDrkUOvNw5gXTDEbL22YypmqJuezSHwTTc0H0rbdVGuNAF2X8zLBz2DkRbqB1xwgakk+GgaUWImVVeAYCMwXQ5is4uR0vhtwJ2cuZ1099IIUMx42uzP7VQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B303A1F000E9;
	Thu, 23 Jul 2026 15:34:03 +0000 (UTC)
From: sashiko-bot@kernel.org
Subject: Re: [PATCH mm-hotfixes v6 2/5] x86/mm/pat: acquire init_mm write
 lock on collapse to avoid UAF
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TG9yZW56byBTdG9ha2VzIChBUk0p?= <ljs@kernel.org>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260723-series-vmap-race-fix-v6-2-8cc77dcc0018@kernel.org>
References: <20260723-series-vmap-race-fix-v6-0-8cc77dcc0018@kernel.org>
 <20260723-series-vmap-race-fix-v6-2-8cc77dcc0018@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 23 Jul 2026 15:33:58 +0000
Message-Id: <20260723153403.B303A1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Incomplete Fix / Use-After-Free: Lockless kernel page table walker=
s (like `vmalloc_to_page()`) are still vulnerable to UAF when kernel page t=
ables are freed.
--

--- Patch [2]: [PATCH mm-hotfixes v6 2/5] x86/mm/pat: acquire init_mm write=
 lock on collapse to avoid UAF ---
commit 5ded4e5b38c3bfea3e52e559a3009697ac580593
Author: Lorenzo Stoakes (ARM) <ljs@kernel.org>

x86/mm/pat: acquire init_mm write lock on collapse to avoid UAF
   =20
This commit attempts to fix a use-after-free issue when collapsing
page tables by taking the mmap write lock on init_mm during the
CPA collapse operation. It aims to serialize against ptdump and
other concurrent CPA walkers.

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
> +}

[Severity: High]
This is a pre-existing issue, but does this fix leave lockless kernel page
table walkers unprotected?

While taking the init_mm mmap write lock serializes against ptdump,
functions like vmalloc_to_page() in mm/vmalloc.c perform lockless walks
over the kernel page tables without acquiring the init_mm mmap read lock:

mm/vmalloc.c:vmalloc_to_page() {
    ...
    pmd =3D pmd_offset(pud, addr);
    if (pmd_none(*pmd))
        return NULL;
    if (pmd_leaf(*pmd))
        return pmd_page(*pmd) + ((addr & ~PMD_MASK) >> PAGE_SHIFT);
    if (WARN_ON_ONCE(pmd_bad(*pmd)))
        return NULL;

    ptep =3D pte_offset_kernel(pmd, addr);
    ...
}

If a thread executing vmalloc_to_page() checks pmd_leaf() and is preempted,
and concurrently set_memory_rox() calls cpa_collapse_large_pages(), the
PMD could be collapsed and the old PTE page freed.=20

When the first thread resumes, could it dereference the freed PTE page=20
causing a use-after-free, or read the new leaf PMD and incorrectly treat=20
it as a PTE page?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260723-series-vma=
p-race-fix-v6-0-8cc77dcc0018@kernel.org?part=3D2
