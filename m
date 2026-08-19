Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 699143CF054;
	Wed, 19 Aug 2026 18:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787165959; cv=none; b=E8cKOBDhvycPfAgzvdUseZ73s4yYicNK/jq3H0psYM50U0PSa7eqvojl0e5PlkYPIZ/hu/qfq0SBOST6ieE30pNZWEtNB7TRAT8MDtrYsZI2H+QMGN2qoZRUrm29uPsygoZDRtdcuvSlVu2Moq0dC8tgU1jpj6VkSryg+Y2qHWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787165959; c=relaxed/simple;
	bh=sbKurF3MB5hsXtMP7HmwxrWZbHbt4HuspurYj7GgXtY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lKDH9QO5LqbLkFHUF+qruDjQpkG8+0GrNxB/kAk9MzMJCjGJjATWhGdCIbunKGOiUPYWfqn2Xo2dZMgI4IVeiizsExZyl+XFAwwnf7opbDfQRGwsHr+XMPkt+NeBGX9cWZ+EMMaq4G7zB2LS7oy+KiBmJ8gFNH+1Xky8P5DEvac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=M6dQoAOT; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="M6dQoAOT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787165958; x=1818701958;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=sbKurF3MB5hsXtMP7HmwxrWZbHbt4HuspurYj7GgXtY=;
  b=M6dQoAOTSGP1Sm6u+xqBNTzcekaYfnb+v1gUDD5TcBxvikr+xnsDSbHj
   dvuYbMSqYahLAVDM2KbjPMw1Y5/TShxXKPKmAvvmjvMaUKixe6AJG4Xu8
   V/CZAFNVjzvhX6jSeU7hZMZNz9vRFlvnuJxn0/s5t/KjEMYKi1hkSMlNI
   882+QfnnPtHJyxRTKhKkJVWiEXUFL8k2qAyH8Jlsnu9VROiQFFnTHnB01
   PUg6S0Lg8ve1gk0B7WXRrfWFYVDMGXp+7X8l+zfqj+IkgXbW6LEZ0oVX7
   apvWSHofaAffySjOrbgmOqUD1LcoJyfPeFuhnidBKpI6tMXeUw3hMXFwq
   A==;
X-CSE-ConnectionGUID: hVtQPxJgRRuFnEtLvvpV/A==
X-CSE-MsgGUID: jtoQPxQoRcyx/AkR0SQ5ZQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11880"; a="98362593"
X-IronPort-AV: E=Sophos;i="6.25,231,1779174000"; 
   d="scan'208";a="98362593"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2026 11:59:16 -0700
X-CSE-ConnectionGUID: qgGqj6cESFugWTCUOU3eZQ==
X-CSE-MsgGUID: cJ1hEMnBT3K0FmhDyWde6A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,231,1779174000"; 
   d="scan'208";a="263868455"
Received: from guptapa-desk.jf.intel.com (HELO desk) ([10.165.239.46])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2026 11:59:16 -0700
Date: Wed, 19 Aug 2026 11:59:09 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: Dave Hansen <dave.hansen@intel.com>
Cc: kernel test robot <yi1.lai@intel.com>, oe-lkp@lists.linux.dev, 
	lkp@intel.com, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	x86@kernel.org, Daniel Borkmann <daniel@iogearbox.net>, 
	Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [linus:master] [x86/bugs] a3af84b0fa:
 stress-ng.seccomp.ops_per_sec 95.7% regression
Message-ID: <4h7zrdfpu3ailx5ajkyqohmcfuxgrk3tn7i7n3dkp3ksy5xehk@xqg5j6pqzocv>
References: <202608191340.98574fe2-lkp@intel.com>
 <b771b524-ceca-4766-9eaa-07bee153802a@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b771b524-ceca-4766-9eaa-07bee153802a@intel.com>

On Wed, Aug 19, 2026 at 08:26:53AM -0700, Dave Hansen wrote:
> On 8/18/26 23:20, kernel test robot wrote:
> > kernel test robot noticed a 95.7% regression of stress-ng.seccomp.ops_per_sec on:
> 
> One one level this is a "vulnerability mitigations cause performance
> loss, news at 11" kind of thing. Like, Duh!
> 
> The microbenchmark here does seem to be a pretty worse-case scenario
> where it sits in a loop loading and running a seccomp filter program. In
> other words, it's just about as pathological of a test as you can have.
> 
> I think Pawan had some more ideas about ways to optimize this. Is there
> any appetite for that? Or is the test just too synthetic to worry about?

One of the optimization is to do fine-grained tracking, i.e. track reuse
per-chunk instead of per-pack. This requires an additional bitmap per-pack.

Another option is to track the CPUs where the cBPF program ran, and only
send IPIs to those CPUs. This mainly reduces the overhead on workloads on
other CPUs, not necessarily the workload allocating programs. Seems more
relevant on servers with many CPUs.

Not sure if these are worth the effort yet, given that I am not aware of a
real-world workload with a significant impact.
