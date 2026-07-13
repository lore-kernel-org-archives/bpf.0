Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96EB4346E40
	for <bpf@vger.kernel.org>; Mon, 13 Jul 2026 17:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783963489; cv=none; b=G/io5NaYips9n1A6XkzL4w1vQ58JbfbtZMMIq+HTzsJWojTilz90L/kptH8Xjhu+xpGMABZhx+0ErlIWOJ5AygtvJu4fIIxG2JKL5Jm1i+eWWKb2LQis4brTrfXrhn58cl2nw/sSdpe1vHq4h/RW2mNNuvfIWZj4uh5sCISsaUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783963489; c=relaxed/simple;
	bh=LhoU1IW1NUPYKzwG3u2YcU0ZdQy23+0F391w4hKM3io=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OFJeZiUDFhi6Jhh7n0KCmrda8rZzWOnHQ9v3xFBH0hywAz4l9fW3dpBolrSpLmeCrdRUiy0RDJ3n2tkfJ9azCfR1tsS35e8dCifBVxc/U2zwVBdhdBts8rry3N7AVLFHlV7X9teuUaYT9F2Ne9361cNyOkXYFo6saM/Hdkj8Mp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mKSwFiQ2; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mKSwFiQ2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783963487; x=1815499487;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=LhoU1IW1NUPYKzwG3u2YcU0ZdQy23+0F391w4hKM3io=;
  b=mKSwFiQ2JATCIAjjUqIByJ7Er4hguX/i7QgdE0t5JAJxMmH8wuP7Wjlj
   Gmq3KMsNBnE4t8WBqSQ/00mnh/URlFwyoDoXs7/27YnPpyoG4idPux0cy
   rGk3LwCAGKGX8/rWQMn+pYgHQykSQvAvEP3FowvuMcQoKRr876HKblirh
   PiWJyX7rnGnmfdDRyloOWD7Idgm5vkCVtP0hvCGyhDPREqYEQJrqcdjeZ
   MavEGF7Dk2c1OGnu/1Gy0EH+vtYpupHXOpwqHIRLoa6CYUid2z75RGMjw
   ipk7C9BO2394/NDFXrEzceTPm6OnnnRxCVxNBGt0lkVF4UzKj3jCIuvQ7
   A==;
X-CSE-ConnectionGUID: tW5zM5seSDyT9BqF78YxPg==
X-CSE-MsgGUID: ce1tg9AgRpqO8n+syuetdA==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="88402386"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="88402386"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2026 10:24:47 -0700
X-CSE-ConnectionGUID: iHszYsmwQpmrNPrtx3NmVA==
X-CSE-MsgGUID: ijzKJy/wQt6MQdhBw70jHA==
X-ExtLoop1: 1
Received: from guptapa-desk.jf.intel.com (HELO desk) ([10.165.239.46])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2026 10:24:47 -0700
Date: Mon, 13 Jul 2026 10:24:38 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
Subject: Re: [PATCH 7.1.y 3/6] bpf: Restrict JIT predictor flush to cBPF
Message-ID: <7ggk6loahtxyw2mhjxu4tup6korbtrairwoi3rffxrwezedxkf@mww5mtcedfyp>
References: <20260709-cbpf-jit-spray-hardening-7-1-y-v1-0-5ac5a2d6797f@linux.intel.com>
 <20260709-cbpf-jit-spray-hardening-7-1-y-v1-3-5ac5a2d6797f@linux.intel.com>
 <20260709223537.D189A1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260709223537.D189A1F000E9@smtp.kernel.org>

On Thu, Jul 09, 2026 at 10:35:37PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] Restricting JIT predictor flush to cBPF bypasses Spectre v2 mitigations for unprivileged native eBPF programs.
> --
> 
> --- Patch [3]: [PATCH 7.1.y 3/6] bpf: Restrict JIT predictor flush to cBPF ---
> commit 96d12fd545f6cf1b750e18b7bd03c2fd3abf27be
> Author: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
> 
> bpf: Restrict JIT predictor flush to cBPF
> 
> This commit restricts the branch predictor flush on BPF JIT memory reuse to
> only execute for cBPF programs. The rationale provided is that only cBPF
> programs can be loaded by an unprivileged user, whereas eBPF is privileged
> by default.
>
> > diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> > index f49b9b23f95e6..1b7e74e63bd4b 100644
> > --- a/kernel/bpf/core.c
> > +++ b/kernel/bpf/core.c
> [ ... ]
> > @@ -957,7 +957,7 @@ void *bpf_prog_pack_alloc(u32 size, bpf_jit_fill_hole_t bpf_fill_ill_insns)
> >  		 * safe because cBPF programs (the unprivileged attack surface)
> >  		 * are bounded well below a pack size.
> >  		 */
> > -		if (static_branch_unlikely(&bpf_pred_flush_enabled))
> > +		if (was_classic && static_branch_unlikely(&bpf_pred_flush_enabled))
> >  			pr_warn_once("BPF: Predictors not flushed for allocations greater than BPF_PROG_PACK_SIZE\n");
> >  		size = round_up(size, PAGE_SIZE);
> >  		ptr = bpf_jit_alloc_exec(size);
> 
> [Severity: High]
> Does this bypass the Spectre v2 mitigations for unprivileged native eBPF
> programs?
> 
> If kernel.unprivileged_bpf_disabled=0 (which is the default when
> CONFIG_BPF_UNPRIV_DEFAULT_OFF is not set), unprivileged users can load native
> eBPF programs such as BPF_PROG_TYPE_SOCKET_FILTER. Since these are not cBPF,
> was_classic is false, and the warning logic for large allocations explicitly
> bypasses the check in bpf_prog_pack_alloc().

With unprivileged eBPF enabled there is a bigger problem to deal with. In
such a case system already reports vulnerable to spectre-v2:

  spectre_v2_show_state()
  {
          if (spectre_v2_enabled == SPECTRE_V2_EIBRS && unprivileged_ebpf_enabled())
                  return sysfs_emit(buf, "Vulnerable: eIBRS with unprivileged eBPF\n");

> [ ... ]
> > @@ -989,7 +989,9 @@ void *bpf_prog_pack_alloc(u32 size, bpf_jit_fill_hole_t bpf_fill_ill_insns)
> >  	pos = 0;
> >  
> >  found_free_area:
> > -	static_call_cond(bpf_arch_pred_flush)();
> > +	/* Flush only for cBPF as it may contain a crafted gadget */
> > +	if (static_branch_unlikely(&bpf_pred_flush_enabled) && was_classic)
> > +		static_call_cond(bpf_arch_pred_flush)();
> >  	bitmap_set(pack->bitmap, pos, nbits);
> >  	ptr = (void *)(pack->ptr) + (pos << BPF_PROG_CHUNK_SHIFT);
> 
> [Severity: High]
> For unprivileged native eBPF programs, the predictor flush during memory pack
> reuse is also skipped here. Could this allow an unprivileged attacker to load
> a crafted JIT gadget into a reused memory chunk and exploit leftover branch
> predictor state from previously executed privileged BPF programs?

Same as above.
