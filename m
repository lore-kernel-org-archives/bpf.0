Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1CFF30216D;
	Thu, 15 Oct 2026 08:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792052179; cv=none; b=aZafg+j8dPvIkngwuMYPrHoyXr1O5gPBOK1KzRohR7h61gGSJLKQcHcNfx5X0AcDre2TlpOwHH3FSi2+QXdh5rKL6+l/+rwtw1yfillLDhJ5yCiLwmc9Iar7Xu48sKBh1uRNP7PemY6HCmYKQRWfna6NZzHi0h90UYP/Hakdmko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792052179; c=relaxed/simple;
	bh=WQrY/10Sx5ZLKNs4wzxH4x0sne26aGBqwpymsNVEZNo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J3dDNRYWxwQXYejfCejmsJNelMAj2sboDYU+J39tpy5WN+zTtcUCt1ummMPfRftpHTbShR8x4g51yRs34cmqtOEzHO1Jn3edP0dSjdu23R+BalIMLf4Ehg0aFmk2fVzA2BRtZnxQChJhm5PKuIS11aHGcV/uP8oBQfhUJlikX9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D+2ATOFo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D+2ATOFo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D37BB1F000C4;
	Thu, 15 Oct 2026 08:16:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792052178;
	bh=5o7xsZFTTFM2WuI57OlieYgdarxkwcy1AXb2N5U0PlI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=D+2ATOFoltP2nF981paY8m+3M3kd+Tjj49sknPJQJTqIexCCDVBowBAaT4iXrPvkQ
	 FWqyVyOm+GtBh+CyAbIWI4Vmz7NZHkeBIA+V58wTv/YUKIbdNmh0CRUOSsDKMkGZlp
	 2Pvze3OMXHOreuqUXKrhGYXUqBQ7PtMqWnrgPqJNrdjehCZJWUGpJq5bEi2xCJYdcf
	 kT3/GHacDQ4CrZrxoFB6qKOPwGvAEqgT4DT5MqKLoqFAMxMEJNf1QG5H/Aq+Guw0bg
	 4Gv3++dwqzxwhVP4ErsCfK+W6NL8G/MuKPWW3LcOd2pu91diTykdvJZAvyCyTSF3VU
	 RLbvsO4Ql8T7g==
Date: Thu, 15 Oct 2026 11:16:11 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Karl Mehltretter <kmehltretter@gmail.com>
Cc: Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Luis Chamberlain <mcgrof@kernel.org>,
	=?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>,
	linux-riscv@lists.infradead.org, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] riscv: mm: Pre-allocate module page tables for execmem
Message-ID: <atCLy-3RZbf3fGRp@kernel.org>
References: <20261015033643.84972-1-kmehltretter@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261015033643.84972-1-kmehltretter@gmail.com>

On Thu, Oct 15, 2026 at 05:36:43AM +0200, Karl Mehltretter wrote:
> RV64 pre-allocates page-table levels for late kernel mappings. The module
> range is guarded by CONFIG_MODULES, although execmem can use it without
> modules.
> 
> With CONFIG_BPF_JIT=y and CONFIG_MODULES=n, execmem adds a mapping to
> init_mm while the current process retains an empty PGD entry. Initializing
> a BPF program pack then faults:
> 
>   Unable to handle kernel paging request ...
>   [ffffffff78000000] pgd=0000000000000000
>   ...
>   bpf_jit_fill_hole_with_zero
>   bpf_prog_pack_alloc
> 
> Use CONFIG_EXECMEM for the module-range pre-allocation, as powerpc does
> for its execmem page-table setup. Both CONFIG_MODULES and CONFIG_BPF_JIT
> select it.

I think the commit message should mention that BPF_JIT_REGION is inside
MODULES region.
 
> Fixes: 2c9e5d4a0082 ("bpf: remove CONFIG_BPF_JIT dependency on CONFIG_MODULES of")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>

Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

> ---
> 
> Notes:
>     Tested on a BeagleV Ahead with matched LLVM 18.1.3 builds based on
>     v7.3-rc7:
>     
>     - unpatched: a native XDP attach triggered the Oops above
>     - patched: native XDP attach and detach completed without an Oops
>
>  arch/riscv/mm/init.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> index fb37b0b67efe..d92342c162e2 100644
> --- a/arch/riscv/mm/init.c
> +++ b/arch/riscv/mm/init.c
> @@ -1437,7 +1437,7 @@ static void __init preallocate_pgd_pages_range(unsigned long start, unsigned lon
>  void __init pgtable_cache_init(void)
>  {
>  	preallocate_pgd_pages_range(VMALLOC_START, VMALLOC_END, "vmalloc");
> -	if (IS_ENABLED(CONFIG_MODULES))
> +	if (IS_ENABLED(CONFIG_EXECMEM))
>  		preallocate_pgd_pages_range(MODULES_VADDR, MODULES_END, "bpf/modules");
>  	if (IS_ENABLED(CONFIG_MEMORY_HOTPLUG)) {
>  		preallocate_pgd_pages_range(VMEMMAP_START, VMEMMAP_END, "vmemmap");
> -- 
> 2.43.0
> 

-- 
Sincerely yours,
Mike.
