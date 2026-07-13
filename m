Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC5B443C054
	for <bpf@vger.kernel.org>; Mon, 13 Jul 2026 16:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783961077; cv=none; b=FMK9a0nhpRExoNme8Lx5cx0hNAuJzNOiT3knGtJ7s/joSfDiZ23BOJgQydtr00GuVcL5jQIgbbCEJGKu6cDUN96rMnf9iCNDGgZjnrmEkD17wR0IebZHMCzc3PvmB88RLrPujAnEMYD5/+DQ14D1i/fgL/WxbGomWbicElFPQXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783961077; c=relaxed/simple;
	bh=Z1GCW3Xf0/y6dRLP+GYaLG5CI3IXoNkK+xlEHO3c1sk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R0CTKWAqAQ/Nh7L7T1cED9R7diS0pUP6dg9Ka4S05HQWSmJU+vDwGYIke6ZXtGb0afYY0YFp4RavbFvZ/7jBkvj56eg0pvGtxtQz/ptR52qzQhy7NNKnEv9wha1TL1nsig4vWh8Irhc3xFD3gO5iz9rXO7f6yD8mkMyMKITTD8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jIUwwh2C; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jIUwwh2C"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783961076; x=1815497076;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Z1GCW3Xf0/y6dRLP+GYaLG5CI3IXoNkK+xlEHO3c1sk=;
  b=jIUwwh2CQUyhgJeWhJudLORZNPmqL6XRhEP36XrQxT6v6OPWMEPkyBdv
   z6nf2ZvfHrIsus4l+v2i/E3rAlOvKxuFIwm4XdBYWtNJTxy/5HMpw5dbz
   2V6rfeTgI1LIO0XjConcVofFmc93RPqE1O01QPovsoshNF3ytQ4RGJh8y
   zRDu36J9QxS4gP0NVXK/1bLcW8gzdCa04NDazEliQd+EaW+whbf15Il2L
   yk8v1L+oaFfVDSrlO2rmuhw2kSkVPCpb9hBWuYOqPA5Jrvy2OS+czRthh
   hLVm7ooH6g4NNXGrqk3HhKhreu/wHoAciZsFpoW8J+geyzwYj7+05AJQZ
   g==;
X-CSE-ConnectionGUID: kh29ZtpIQK2UrB2/rxJdrQ==
X-CSE-MsgGUID: XaFljCeqThWXJX6k58D8pA==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="84768682"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="84768682"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2026 09:44:35 -0700
X-CSE-ConnectionGUID: wnoPbsbDQIu8PM/fO7RA3A==
X-CSE-MsgGUID: Skz/iq9aSRu+UfdoxzzBkg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="249247193"
Received: from guptapa-desk.jf.intel.com (HELO desk) ([10.165.239.46])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2026 09:44:35 -0700
Date: Mon, 13 Jul 2026 09:44:28 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
Subject: Re: [PATCH 7.1.y 1/6] bpf: Support for hardening against JIT spraying
Message-ID: <jwpskujnm5upszc6v2aicpifckl7smjwi7myzfcdksksoho4wf@kx4cl6j66rsa>
References: <20260709-cbpf-jit-spray-hardening-7-1-y-v1-0-5ac5a2d6797f@linux.intel.com>
 <20260709-cbpf-jit-spray-hardening-7-1-y-v1-1-5ac5a2d6797f@linux.intel.com>
 <20260709223717.3C6291F00A3F@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260709223717.3C6291F00A3F@smtp.kernel.org>

On Thu, Jul 09, 2026 at 10:37:15PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] Security Mitigation Bypass: Indirect branch predictor flush is skipped for large BPF allocations and when packs are freed to the system pool.
> --
> 
> --- Patch [1]: [PATCH 7.1.y 1/6] bpf: Support for hardening against JIT spraying ---
> commit 3f99052f0f28956849dd13889694d621bc46be60
> Author: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
> 
> bpf: Support for hardening against JIT spraying
> 
> This patch introduces the bpf_arch_pred_flush mechanism to flush indirect
> branch predictors before reusing JIT memory. This aims to protect new BPF
> programs from using branch predictions left behind by previous programs that
> occupied the same space. However, it intentionally skips flushing for large
> allocations and when returning packs to the system pool.
> 
> > diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> > index 6aa2a8b240306..f49b9b23f95e6 100644
> > --- a/kernel/bpf/core.c
> > +++ b/kernel/bpf/core.c
> [ ... ]
> > @@ -941,6 +951,14 @@ void *bpf_prog_pack_alloc(u32 size, bpf_jit_fill_hole_t bpf_fill_ill_insns)
> >  
> >  	mutex_lock(&pack_mutex);
> >  	if (size > BPF_PROG_PACK_SIZE) {
> > +		/*
> > +		 * Allocations larger than a pack get their own pages, and
> > +		 * predictors are not flushed for such allocation. This is only
> > +		 * safe because cBPF programs (the unprivileged attack surface)
> > +		 * are bounded well below a pack size.
> > +		 */
> > +		if (static_branch_unlikely(&bpf_pred_flush_enabled))
> > +			pr_warn_once("BPF: Predictors not flushed for allocations greater than BPF_PROG_PACK_SIZE\n");
> >  		size = round_up(size, PAGE_SIZE);
> >  		ptr = bpf_jit_alloc_exec(size);
> 
> [Severity: High]
> Does skipping the flush for allocations larger than BPF_PROG_PACK_SIZE leave
> large BPF programs and Kernel Modules vulnerable to poisoned predictions?
> 
> If an unprivileged attacker loads cBPF programs to fill a BPF pack and trains
> the indirect branch predictor, they leave poisoned predictions for that memory.
> 
> When the attacker unloads the cBPF programs, the BPF pack is freed. If a
> privileged user subsequently allocates a large BPF program, this new
> allocation might reuse the freed memory.
> 
> Since bpf_prog_pack_alloc() explicitly skips bpf_arch_pred_flush() for these
> allocations, wouldn't the privileged victim program inherit the attacker's
> poisoned predictions?
> 
> Additionally, does freeing an empty pack back to the system pool bypass the
> mitigation completely?
> 
> When a pack is fully emptied in bpf_prog_pack_free(), it is returned to the
> system pool without a predictor flush:
> 
> kernel/bpf/core.c:bpf_prog_pack_free() {
> 	...
> 	if (bitmap_find_next_zero_area(pack->bitmap, BPF_PROG_CHUNK_COUNT, 0,
> 				       BPF_PROG_CHUNK_COUNT, 0) == 0) {
> 		list_del(&pack->list);
> 		bpf_jit_free_exec(pack->ptr);
> 		kfree(pack);
> 	}
> 	...
> }
> 
> Could Kernel Modules or large BPF programs that subsequently allocate this
> memory via execmem inherit these poisoned predictions?

No to all of the above. Misprediction into a privileged program is less of
a concern because the code is not controlled by the attacker. Hence,
crafting a gadget into the privileged code is extremely difficult.
