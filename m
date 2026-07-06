Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 647763DD870;
	Mon,  6 Jul 2026 22:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783378420; cv=none; b=IZyYUYWrifrfxe+76WUfPCtel8sITBzuU/zppJBrNDXf35u2z7P+7K+3SoPgdL72h5I1TXThhUEdL5PnSqXaSw3O5CPZA8cn8/bk1Rl3OCL/o7+4IQJNolccUVfCFSj8ioMb0//DfvfOm5MR9RrkxytI+esK/3aEgr4K2aQG6wA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783378420; c=relaxed/simple;
	bh=4f/25KfSGRQ8HsTNAZsrQsams+PsiwKOPzS4L2Z1IQA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k2gWLbPIW/WNc5EON6FRCJxo3JieADeOdgJAPAQiGgx4wjvaytdnv3DR7LHObOVXWQgpFZdOuSgWqZFC4GCpyYa75k7cwSOuQdKUI2R2OikZXfVgnqD2ci+7DOTh4jWfphPBARujhScDzv1ORfCyc2MYmdOGTPkiNpIbV7PEqLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LfUwgmxj; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LfUwgmxj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783378419; x=1814914419;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4f/25KfSGRQ8HsTNAZsrQsams+PsiwKOPzS4L2Z1IQA=;
  b=LfUwgmxjpOTDXokS0hrwflU2/X0iJ5owV4i2Hp1Q8DlVuZ9sbkJCxuqi
   0A/2Ykz5rRhmzqoN63UTbeOaIVFRQHk+LChCLHcm4wy2ARMqj+BSEWzP0
   kMAeCTaPSlW0bQ7TleVi0YmcjHNXjcPfKMKyCKS5A3Ivgkfrmk2KlY+R/
   aBu2aVX+5HlgYdVuytJFpC2m+S55aF0nL48lpNDzUxSDx4dtkdEW5M5eP
   opxnk7KnD8fWqavA8W4++Z33uX+NLFu5bNwZJOSmpQFi+pFVwEpd087H/
   oYFvfx6O0b1SD/aG8s7cgpYvlPGo7aGUGOdmTBsYuxj2Mc/t4i5m06Nij
   Q==;
X-CSE-ConnectionGUID: ZXLA3NsxTNuigYUx1upDLg==
X-CSE-MsgGUID: WtE+rzfQS0iffJFU74c9EA==
X-IronPort-AV: E=McAfee;i="6800,10657,11839"; a="94666077"
X-IronPort-AV: E=Sophos;i="6.25,151,1779174000"; 
   d="scan'208";a="94666077"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2026 15:53:38 -0700
X-CSE-ConnectionGUID: 9s1x32AxRZegBhi1OBHjAw==
X-CSE-MsgGUID: YZFCUa9/QKyXjjFvpZrO5g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,151,1779174000"; 
   d="scan'208";a="253926033"
Received: from guptapa-desk.jf.intel.com (HELO desk) ([10.165.239.46])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2026 15:53:39 -0700
Date: Mon, 6 Jul 2026 15:53:32 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: sashiko-reviews@lists.linux.dev, namhyung@kernel.org
Cc: kvm@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH v12 09/12] x86/vmscape: Use static_call() for predictor
 flush
Message-ID: <txanowcrp74ihpevuxwmzt3ivydu3yalvq7cv6vrwofvkhp7cg@4kuyjvo5b4ow>
References: <20260622-vmscape-bhb-v12-0-76cbda0ae3e5@linux.intel.com>
 <20260622-vmscape-bhb-v12-9-76cbda0ae3e5@linux.intel.com>
 <20260623174715.48B501F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260623174715.48B501F000E9@smtp.kernel.org>

On Tue, Jun 23, 2026 at 05:47:14PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 3 potential issue(s) to consider:
> - [Medium] The patch introduces unconditional memory reads on the highly sensitive kernel-to-user exit and KVM VM-enter fast paths, penalizing all systems where the VMSCAPE mitigation is disabled.
> - [Low] The removal of `X86_FEATURE_IBPB_EXIT_TO_USER` from the kernel CPU features header was not mirrored to the corresponding tools header, causing code drift.
> - [Low] Usage of `static_call_cond()` without including `<linux/static_call.h>` makes the header non-self-contained.
> --
> 
> commit 6813e9ba3f5da52dd0859a742860cd03837d50a7
> Author: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
> 
> x86/vmscape: Use static_call() for predictor flush
> 
> This patch replaces the flag-based mitigation selector for VMSCAPE with a
> static_call() to the mitigating function. This avoids adding more feature
> flags and multiple checks, freeing the X86_FEATURE_IBPB_EXIT_TO_USER flag.
> 
> > diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
> > index 1d506e5d6f46a..09f956b72637c 100644
> > --- a/arch/x86/include/asm/cpufeatures.h
> > +++ b/arch/x86/include/asm/cpufeatures.h
> > @@ -504,7 +504,7 @@
> >  #define X86_FEATURE_TSA_SQ_NO		(21*32+11) /* AMD CPU not vulnerable to TSA-SQ */
> >  #define X86_FEATURE_TSA_L1_NO		(21*32+12) /* AMD CPU not vulnerable to TSA-L1 */
> >  #define X86_FEATURE_CLEAR_CPU_BUF_VM	(21*32+13) /* Clear CPU buffers using VERW before VMRUN */
> > -#define X86_FEATURE_IBPB_EXIT_TO_USER	(21*32+14) /* Use IBPB on exit-to-userspace, see VMSCAPE bug */
> > +/* Free */
> 
> [Severity: Low]
> Does this removal also need to be synced to the tools copy in
> tools/arch/x86/include/asm/cpufeatures.h? Leaving them out of sync typically
> triggers a 'Kernel ABI header differs' build warning when compiling tools
> like perf.

This was explained previously here:

https://lore.kernel.org/all/20260324195144.c6gaxewnyojsev2q@desk/

Namhyung, I hope this is still relevant:

  So its important not to touch the copies in tools/ when doing changes in
  the original kernel headers, that will be done later, when
  check-headers.sh inform about the change to the perf tools hackers.

  https://github.com/torvalds/linux/blob/master/tools/include/uapi/README#L39
