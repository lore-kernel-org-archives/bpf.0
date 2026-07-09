Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8145175A73;
	Thu,  9 Jul 2026 12:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783601600; cv=none; b=EdJ7zjXnjq8+Wu4CgYMg3EzK5SlmygpdiZyE9ZsFBEAQP2HpmIhNeeC4pE651jJ8qRH9twnDbPrHWuuAFV8x1ufuZE74gTRGqfcMLk4JAstrnc/fwQ7GdeYYvaRlyCgVf0jzTiGQPewzRnsIx9JjNCYnAHrHr8f9YSwn1PY70OU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783601600; c=relaxed/simple;
	bh=16l+S21xlwHjjfhKPVhx//0cZVIl97DUqS1U17HjA3g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZF9gIEmfsF6bnq587GeQFbejXFihZFTkkueNwwcp6SBNdJzhSzg3RUT/82awOBuaj+0dxF319Wg3ynM3nZDn8upay9YgG+/5FsvO3L2KjGpLuLd0AkLXozrH1XNfiAeIcc6ivjgaxEBltpgHpGqvjbf49+AoSDuqNudFTfTjkRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hLAlzOrV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hLAlzOrV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F00D1F000E9;
	Thu,  9 Jul 2026 12:53:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783601599;
	bh=FGvbiY5ReKD/NdiWcpdO94gKwLOERm4LJb10mvKgmQ0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=hLAlzOrVbmTy4EdOAKSVFasoKIQd78WI0jpV8XLateDBppEAo9chiueLkTzRvyvlh
	 3cstZqQNx0/Z2wAqniJJ27nfXKAIYZVN/mj3SHeFIwCMbI0zjT0jBJhhEnvb99HJi4
	 WSsXpExWyveOdPpsA9S1CDpv6826fFUmqwdi+/oLx+Evn7cz+R8v4xWtOaIi0xi3Xs
	 xNYl1+mxxUKYPvrVrhIAyZTeT8SlnL3Lis8XyjuQurV1tTc806s7fDoGOp9ptvU5dA
	 juzA+FQWyEuuSayaiwJ00JYb68qh7qIqHMEnW0wVNGW7nS0rKcQ3xjmxMnPE94O5xf
	 KdKYAkHz8jc/w==
Date: Thu, 9 Jul 2026 15:53:13 +0300
From: Mike Rapoport <rppt@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>
Subject: Re: [PATCH bpf-next 5/5] x86/bpf: enable EXECMEM_ROX_CACHE for BPF
 allocations
Message-ID: <ak-ZubgH13_MrXy4@kernel.org>
References: <20260626-execmem-x86-rox-bpf-v0-v1-0-45a0b0ed4fe9@kernel.org>
 <20260626-execmem-x86-rox-bpf-v0-v1-5-45a0b0ed4fe9@kernel.org>
 <20260626185945.2F7BB1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260626185945.2F7BB1F000E9@smtp.kernel.org>

On Fri, Jun 26, 2026 at 06:59:44PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [Critical] Pages freed from the ROX cache via vfree() are returned to the page allocator with Read-Only permissions, causing kernel panics on subsequent allocations.
> - [High] The return value of execmem_restore_rox() is ignored in __execmem_cache_free(), potentially leaving cached memory as Non-Executable (NX) and crashing the kernel when BPF programs are executed.
> --
> 
> commit d59aa3f12b249d60a053835fa723486bb4d4f203
> Author: Mike Rapoport (Microsoft) <rppt@kernel.org>
> 
> x86/bpf: enable EXECMEM_ROX_CACHE for BPF allocations
>     
> BPF core and x86 JIT use text poking and temporary writable buffers and
> thus can handle ROX memory. Enable ROX cache for EXECMEM_BPF when
> configuration and CPU features allow that.
> 
> > diff --git a/arch/x86/mm/init.c b/arch/x86/mm/init.c
> > index fb67217fddcd3..079f8c7e9e3cd 100644
> > --- a/arch/x86/mm/init.c
> > +++ b/arch/x86/mm/init.c
> > @@ -1107,10 +1107,10 @@ struct execmem_info __init *execmem_arch_setup(void)
> >  				.alignment = MODULE_ALIGN,
> >  			},
> >  			[EXECMEM_BPF] = {
> > -				.flags	= EXECMEM_KASAN_SHADOW,
> > +				.flags	= flags,
> >  				.start	= start,
> >  				.end	= MODULES_END,
> > -				.pgprot	= PAGE_KERNEL,
> > +				.pgprot	= pgprot,
> 
> [Severity: Critical]
> This is a pre-existing issue, but enabling the ROX cache for BPF
> significantly increases the likelihood of triggering it. When memory is freed
> back to the page allocator via vfree() from the ROX cache, it appears to
> retain Read-Only permissions.
> 
> In mm/execmem.c:execmem_cache_populate_alloc(), memory is allocated without
> the VM_FLUSH_RESET_PERMS flag:
> 
>     unsigned long vm_flags = VM_ALLOW_HUGE_VMAP;
>     ...
>     p = execmem_vmalloc(range, alloc_size, PAGE_KERNEL, vm_flags);
> 
> When the block is later cleaned up in mm/execmem.c:execmem_cache_clean(), it
> is freed using vfree():
> 
>     execmem_set_direct_map_valid(vm, true);
>     mas_store_gfp(&mas, NULL, GFP_KERNEL);
>     vfree(area);
> 
> Since VM_FLUSH_RESET_PERMS was omitted, vfree() skips resetting the direct map
> permissions. If a subsequent kernel subsystem allocates these same pages from
> the buddy allocator and attempts to write to them, will this result in a Write
> Protection fault and kernel panic?

The call to execmem_set_direct_map_valid() resets the direct map
permissions so there's no need to reset them in vfree().

> [Severity: High]
> This is also a pre-existing issue exposed by enabling the ROX cache. In the
> error handling path, the return value of execmem_restore_rox() is ignored.
> 
> Looking at mm/execmem.c:__execmem_cache_free():
> 
>     execmem_fill_trapping_insns(ptr, size);
>     execmem_restore_rox(ptr, size);
>     err = execmem_cache_add_locked(ptr, size, gfp_mask);
> 
> If execmem_restore_rox() fails (for example, if set_memory_rox() returns
> ENOMEM when allocating page tables for direct map splitting), the memory is
> left as Non-Executable (NX).

set_memory_rox() cannot fail here.

The only failure path in set_memory is an allocation failure when there is
a splitting of large pages. At this point a 2M page would be already split
by execmem_alloc_rw() so execmem_restore_rox() updates permissions on 4k
pages and collapses them into 2M page once the entire 2M page is ROX.
     
> Since this error is ignored and the memory is still added to the free list,
> could BPF subsequently allocate this NX memory from the cache, assuming it is
> executable, and crash the system when attempting to execute JIT code?
> 
> >  				.alignment = MODULE_ALIGN,
> >  			},
> >  			[EXECMEM_MODULE_DATA] = {
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260626-execmem-x86-rox-bpf-v0-v1-0-45a0b0ed4fe9@kernel.org?part=5

-- 
Sincerely yours,
Mike.
