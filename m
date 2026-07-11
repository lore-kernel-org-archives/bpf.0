Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EE192367B8;
	Sat, 11 Jul 2026 15:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783783650; cv=none; b=KE4XbQoAgvsc2xmSrE8b7DxFdI6eV/Od/a58DGw+GPCsv6JPVO0q682ROnwPTK2Jy8YcO/cH20qYzwb870PXwZGE28TwGZRByu+kGDWB3y+yFYP/HTmRXbkMBPpa+GzseoV+3st/j3D1ko8fhflG9s7tDxOYQC6qRD6szdEXlpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783783650; c=relaxed/simple;
	bh=4FhbT1roqH5pubu5uI5tCeFPNFFKV24ExU6tscwO9zM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rDwPANsRJdZxFM4hD6M4cqhAlOSsXJoh4CqWerNjWvLOVf8fm0z2RH9mtxP/6rrj2abfMUWomqauVY5C5Z8kFvoq5PhtibIFZaQuwhjONNJ5dT/RQ85qMnpIWoHhTxKzT1E6MXd9iD3bjXn9VkRi3m1Mi35hpwp7qa8IORW41Wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hg7gGNgA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hg7gGNgA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F264C1F000E9;
	Sat, 11 Jul 2026 15:27:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783783649;
	bh=0O9D9pDNfZYmsRf/d2dCrEHeCBY53yw+re1nqSW9KrI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=hg7gGNgAGxQo6yBWzhjzEmGjTBqWM0jykjjLXmtDENT6JrCAiDHsQGIIE63aKbkFl
	 pTDvjkv9OQJNOHeXufnpA7MbPE+oJTElVxhGL7CnOmfhsxKRVZXV60f4d3IM1553pb
	 hnlIaGZhyYgZCeVTbZ0pK03NsJjrwjTPNyP4LUTOpAViHWaUzoSJ0S8u5eH3E/+uqA
	 jqz3oIsA6n/nK3Xgj6oKmcerocZBMw0ti36476hzT7G0E/2USRWU2zjCEIshcyUQWE
	 rBlbF4ezCNFGpgDZ6QlQu7QZXvO55YQdt6G6gntnrem1IeQ5XHMNqSjmCFbi9ufBxF
	 LK5GkUN5Nj9ug==
Date: Sat, 11 Jul 2026 18:27:24 +0300
From: Mike Rapoport <rppt@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next v2 3/5] bpf: alloc_prog_pack(): skip ROX
 management for already ROX memory
Message-ID: <alJg3N5uANoLzIna@kernel.org>
References: <20260711-execmem-x86-rox-bpf-v0-v2-0-bfd956d35119@kernel.org>
 <20260711-execmem-x86-rox-bpf-v0-v2-3-bfd956d35119@kernel.org>
 <20260711100032.58B1C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260711100032.58B1C1F000E9@smtp.kernel.org>

On Sat, Jul 11, 2026 at 10:00:31AM +0000, sashiko-bot@kernel.org wrote:
>
> bpf: alloc_prog_pack(): skip ROX management for already ROX memory
> 
> > @@ -965,7 +972,7 @@ void *bpf_prog_pack_alloc(u32 size, bpf_jit_fill_hole_t bpf_fill_ill_insns, bool
> >  			pr_warn_once("BPF: Predictors not flushed for allocations greater than BPF_PROG_PACK_SIZE\n");
> >  		size = round_up(size, PAGE_SIZE);
> >  		ptr = bpf_jit_alloc_exec(size);
> > -		if (ptr) {
> > +		if (ptr && !bpf_jit_mem_is_rox()) {
> >  			int err;
> >  
> >  			bpf_fill_ill_insns(ptr, size);
> 
> [Severity: Medium]
> Since this patch protects bpf_prog_pack_alloc() and alloc_new_pack() from
> writing to memory that might already be ROX, does it also need to protect
> other callers of bpf_jit_alloc_exec() that write directly to the allocated
> memory?
> 
> For example, bpf_jit_binary_alloc() allocates memory and directly writes
> illegal instructions:
> 
> kernel/bpf/core.c:bpf_jit_binary_alloc() {
>     ...
>     hdr = bpf_jit_alloc_exec(size);
>     if (!hdr) {
>         bpf_jit_uncharge_modmem(size);
>         return NULL;
>     }
> 
>     /* Fill space with illegal/arch-dep instructions. */
>     bpf_fill_ill_insns(hdr, size);
>     ...
> }

ROX caches are only supported on x86-64, and this is never called there.
 
> Similarly, on x86, arch_bpf_trampoline_size() allocates memory and passes
> it as a read-write buffer:
> 
> arch/x86/net/bpf_jit_comp.c:arch_bpf_trampoline_size() {
>     ...
>     image = bpf_jit_alloc_exec(PAGE_SIZE);
>     if (!image)
>         return -ENOMEM;
> 
>     ret = __arch_prepare_bpf_trampoline(&im, image, image + PAGE_SIZE, image,
>                                         m, flags, tnodes, func_addr);
>     ...
> }
> 
> Could these paths cause a page fault when EXECMEM_ROX_CACHE is enabled,
> since they attempt to write directly to the read-only memory?

This is handled by the next patch.

-- 
Sincerely yours,
Mike.
