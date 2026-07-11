Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E3F529BD9A;
	Sat, 11 Jul 2026 15:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783784196; cv=none; b=t4XAD2vFjLX65JV8pdiQmdg3wUDvbZBZNDkd/Wt/5vqVlNb5gJOVpDYEm/vJj9o0iwGS0pUfZ4qkypKUyvywid9aeMrhY/V7SwVPevHWUd1JcC4pXn4Wcc3mUCImoZRVy+ycM1YtsFoRFLeXxN1ASrnP4ntJFycV2nSptFMPlYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783784196; c=relaxed/simple;
	bh=bqqLc70tV4VoPXTl/mIWe+tLn6W5AiWgeqZujrBRBno=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=boxLK9oYPjGmf+hYN7J2ddTpVhrMg4wfoG4KdhBymldYoDDDADQNgdSokcltC4vJ+5CZjnwPDwVShFGqFQ+jwKrrCs/QzdRIH7x3dxBqle9K6BvrDglASlbywAoNXPq25nbUG8/btA4Me9ogDL5hjyr3CeNZf9QuWRQagJ5D++s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GQhOJusu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GQhOJusu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB1EB1F000E9;
	Sat, 11 Jul 2026 15:36:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783784190;
	bh=ElPHFUw4BORNodBTDK/eDIXnDqLH0jyos22YI/OxWQI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=GQhOJusuAhE+F4pY84V0XjUvcpk7dnx4F1bhw22NjVrXXnjyLcW5rqG5dbJ/VIzoX
	 Jw6yMApQz0Be0aM9Hg3EYwXjAGSLAlN/K32n7ik2Ri0JipgNlmgONNzNY8psSBmYYw
	 XJ3EkBf401JBNS7IvYpNmIkFEAmtdxUgpVaYmQzMCF8nKbpT5/Dqg4GNbKIsJLL1W4
	 DxfN+KmvHUsrLQauF4rJ3sO+1DkM0LqOvxb6m+QnRzzA1cjAxsr/JfQnQPdL5ThEJi
	 ffyGre01rPmKuWOKHtmcW1XxnCsqQZxuVDE/Bvlk8+YWH79OhJysXXYx1L/YYEm9hY
	 8wXPNWHUh5aSQ==
Date: Sat, 11 Jul 2026 18:36:25 +0300
From: Mike Rapoport <rppt@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next v2 4/5] bpf, x86: make sure allocation in
 arch_bpf_trampoline_size() is writable
Message-ID: <alJi-ftl5zRS2foS@kernel.org>
References: <20260711-execmem-x86-rox-bpf-v0-v2-0-bfd956d35119@kernel.org>
 <20260711-execmem-x86-rox-bpf-v0-v2-4-bfd956d35119@kernel.org>
 <20260711100246.331B21F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260711100246.331B21F000E9@smtp.kernel.org>

On Sat, Jul 11, 2026 at 10:02:45AM +0000, sashiko-bot@kernel.org wrote:
>
> bpf, x86: make sure allocation in arch_bpf_trampoline_size() is writable
>     
> arch_bpf_trampoline_size() allocates a buffer to get actual size required
> for a trampoline.
>     
> This buffer must be in the module address space because
> __arch_prepare_bpf_trampoline() calculates rel32 offsets relatively to
> that buffer.
> 
> > diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> > index de7515ea1beae..b2feec81e2312 100644
> > --- a/arch/x86/net/bpf_jit_comp.c
> > +++ b/arch/x86/net/bpf_jit_comp.c
> > @@ -3703,13 +3703,12 @@ int arch_bpf_trampoline_size(const struct btf_func_model *m, u32 flags,
> >  	int ret;
> >  
> >  	/* Allocate a temporary buffer for __arch_prepare_bpf_trampoline().
> > -	 * This will NOT cause fragmentation in direct map, as we do not
> > -	 * call set_memory_*() on this buffer.
> >  	 *
> >  	 * We cannot use kvmalloc here, because we need image to be in
> >  	 * module memory range.
> > +	 * Since it must be writable use bpf_jit_alloc_exec_rw().
> >  	 */
> > -	image = bpf_jit_alloc_exec(PAGE_SIZE);
> > +	image = bpf_jit_alloc_exec_rw(PAGE_SIZE);
> 
> [Severity: Medium]
> Does this allocation cause unnecessary page table modifications and hugepage 
> shattering?

No.
 
> Allocating via bpf_jit_alloc_exec_rw() forces page table permission changes
> (set_memory_nx and set_memory_rw), which triggers cross-CPU TLB flushes
> and permanently splits 2MB hugepages in the ROX cache's direct map. When
> the buffer is immediately freed, these operations are repeated.

2M page is split temporarily. When the buffer is freed and ROX is restored,
2M page is collapsed.
 
> [Severity: High]
> This is a pre-existing issue, but there appears to be a flaw when freeing
> memory to the ROX cache in __execmem_cache_free():
> 
> mm/execmem.c:__execmem_cache_free() {
> ...
> 	execmem_fill_trapping_insns(ptr, size);
> 	execmem_restore_rox(ptr, size);
> 
> 	err = execmem_cache_add_locked(ptr, size, gfp_mask);
> ...
> }
> 
> Does this ignore the return value of execmem_restore_rox()?

Answered this one already:
https://lore.kernel.org/bpf/ak-ZubgH13_MrXy4@kernel.org/

-- 
Sincerely yours,
Mike.
