Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7D6C353A64;
	Mon,  6 Jul 2026 22:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783377115; cv=none; b=Ta/B4/3W13xUuqlTy1gmz/t3dJbq82Bh9Wmr3yQWIMuYQ6usPsJsHt8NoY4FghB8IvtLzI6i6rQ2dqbJNR5JiqKvQtpzWuyOOMVtFwwK5eyh3k5qvat+jcy09+45R3aSVIuf1HRHdlSPrH+UZtXxCj+RqW9bVFGLOpy/zsI9ILQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783377115; c=relaxed/simple;
	bh=Yn9SIWWX0+e1gsk743vCcUe1e49KQC+4Tqk+wLDv3As=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UEQ1rzt0rQ0Oy8ziJ95dTsnVi9nq3zOXL4EbIUTB8v+kRcMyW0jw6aq7gjoweDcJwcvY3w47dnz7lOskMnht1arwr2+Kse3Ngjwv9do5TQ6uDPX+I0Gc+hgt7BmzfDdA5zu0PbFg6kpDYij2h2zc22aYUFCsVoRpXxYGu7eeu9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mKMHFtES; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mKMHFtES"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783377114; x=1814913114;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Yn9SIWWX0+e1gsk743vCcUe1e49KQC+4Tqk+wLDv3As=;
  b=mKMHFtESeFHgzkgJ0rnLKqTrz6pt9pp8QA7FvKeJMwzNN25hOUbZ/L7s
   oP6qvx21mxzrrGZdpkIkckAFuG6AG7jbBvoWmutKwg9VFSN/808jgeVpo
   nOg6RIOiQ2lVvkuRzAVP8I60xQ2KI9Ifm1f05FsnYQs6o/TOUL5fo1xRU
   TVEcyMZFfpXBtxwCXl2X+MwbqKL/qO1ckcpId3PnSn2WRv9xQnXc4+IHG
   3txh9I+q9FYLH+LEKmBKpp+sjN/x6rYdsAGMwVVUHmTOoGM9J04Uj4EwO
   fuZCpiZhYUWepd29/lPurYhZRd1JYwhMyq03q1ZQSLiYOPse/EyGr+DL8
   Q==;
X-CSE-ConnectionGUID: WTS/3HKhQqi7UCPfpqAXpw==
X-CSE-MsgGUID: t7XlSi/SSS2KJuc5jW8bcw==
X-IronPort-AV: E=McAfee;i="6800,10657,11839"; a="83882461"
X-IronPort-AV: E=Sophos;i="6.25,151,1779174000"; 
   d="scan'208";a="83882461"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2026 15:31:53 -0700
X-CSE-ConnectionGUID: pCP/NMBWTJ+F6UT6gP1fUw==
X-CSE-MsgGUID: wOzDKSZpRta5ww1abeffyA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,151,1779174000"; 
   d="scan'208";a="277040733"
Received: from guptapa-desk.jf.intel.com (HELO desk) ([10.165.239.46])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2026 15:31:53 -0700
Date: Mon, 6 Jul 2026 15:31:45 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH v12 05/12] x86/vmscape: Move mitigation selection to a
 switch()
Message-ID: <qhjhd7k6p7x5ti2bi3wu7kyzphxqtnz3njy5g6tnq6gpcq6nsf@qrp2qfbh4je7>
References: <20260622-vmscape-bhb-v12-0-76cbda0ae3e5@linux.intel.com>
 <20260622-vmscape-bhb-v12-5-76cbda0ae3e5@linux.intel.com>
 <20260623174336.CF3DD1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260623174336.CF3DD1F000E9@smtp.kernel.org>

On Tue, Jun 23, 2026 at 05:43:36PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] The use of a `default:` label in the `switch` statement defeats the compiler's ability to ensure all mitigation modes are explicitly handled.
> --
> 
> commit 5e3a6ba10ff7b033ea17daee7432bcf9168f3b13
> Author: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
> 
> x86/vmscape: Move mitigation selection to a switch()
> 
> This commit refactors the vmscape mitigation selection logic to use a switch
> statement. The stated goal is to explicitly handle all mitigation modes and
> group the logic for each mode together in preparation for future additions.
> 
> > diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
> > --- a/arch/x86/kernel/cpu/bugs.c
> > +++ b/arch/x86/kernel/cpu/bugs.c
> [ ... ]
> > @@ -3088,17 +3088,33 @@ early_param("vmscape", vmscape_parse_cmdline);
> >  
> >  static void __init vmscape_select_mitigation(void)
> >  {
> [ ... ]
> > +	switch (vmscape_mitigation) {
> > +	case VMSCAPE_MITIGATION_NONE:
> > +		break;
> > +
> > +	case VMSCAPE_MITIGATION_IBPB_EXIT_TO_USER:
> > +		if (!boot_cpu_has(X86_FEATURE_IBPB))
> > +			vmscape_mitigation = VMSCAPE_MITIGATION_NONE;
> > +		break;
> > +
> > +	case VMSCAPE_MITIGATION_AUTO:
> > +		if (boot_cpu_has(X86_FEATURE_IBPB))
> > +			vmscape_mitigation = VMSCAPE_MITIGATION_IBPB_EXIT_TO_USER;
> > +		else
> > +			vmscape_mitigation = VMSCAPE_MITIGATION_NONE;
> > +		break;
> > +
> > +	default:
> > +		break;
> 
> [Severity: Medium]
> Does including a default case here defeat the stated goal of the patch?

Yes, it does. "default:" was added because of a preference to not add
currently unreachable code:

  https://lore.kernel.org/all/7d136f5b-437d-48ce-852d-cc793df4de15@suse.com/

> The commit message notes this refactor "ensures that all mitigation modes are
> explicitly handled". However, including a default block suppresses compiler
> warnings about unhandled enum values.

Updating the the commit message to reflect the intent of the patch:

  x86/vmscape: Move mitigation selection to a switch()

  Convert the mitigation selection to a switch() to keep the handling for
  each mitigation mode together and make it easier to follow. This also
  prepares for adding the BHB-clearing mitigation mode for VMSCAPE.
