Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793647928;
	b=uQBEVpH1LjZLl+A6hUvRQ3aI3oSCa8aTPHywnf6HYH/F5qMvtwaY/BydLCYZgntshM2I
	 TK9d/DcZ9Nu981egbbvdXZV1URUTNlfo9E/vxZ6rbaGf7epypPuhEyCgukY5F5DKhVmBL
	 M2NlEvhvkuHrygpsbImvTcZ3XLR2Ste7lmc3TO42wjTs1EtVITkEMsAgAYzyLcpl/MFGP
	 80k4ss34a8hN4ULk93VFHbGpDYuA5EWfuIz2MynanRM/fc//k81Sjgn3K2mJ4lV6pvj/z
	 eF9oKkFkdO8Qkd+Dzu+oXoQrdsvCicLLB13O9zRzJyJKMCdExGImm772ZFx56IXj55Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793647928;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=HmS255ceBEF6kch7cTBpJwV56V5cGRor24skezv76QY=;
	b=hdkpKlPjF158R24sFVyzrsQwUNGdw3Vd9gHht5tDKwZv1N5ULOx2qW3Gr+OjNu7TF0XH
	 T3TdT+KvcuiZP0HfjLy19Hob2YAzVj2tOB4D7wpBNE82SjWqovczajFwc8mJDcWUqqIgY
	 K0YyBoMMns9wkCkknVhKjrQ8NogcHEqfpZKgiyET6T6N+Y8o07LwHZqGCcALGY+gF2ipB
	 bxW8fMDoZ8t7IYHDp9SifK61migd4CgWr5XJMV3JvSqtx+oLM6/Nv9OvE6PBJDnjheDfZ
	 cI28yK+mR6/Exj56ZI8tozAFU7ygrUDvCvy9+REgZ+edgUYKKAIvEWDie25+Nw8U8YA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=F9RjzoYK;
	arc=none smtp.remote-ip=192.198.163.14
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EE0B606A330;
	Mon,  2 Nov 2026 19:32:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2EE0B606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=F9RjzoYK
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793647927; x=1825183927;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=sY9pnK0BK2rUKtlv8LzoQMe8VTz4cJFaZ6oRCiRB2Dw=;
  b=F9RjzoYK2tUZ2YF7aSbLm5cRQpueJ/NlS/ewtLdgULpkHZ7pVhf2HGt8
   5anUHLtLC8WvCIvpz/iyOddPXswH4YO3SBNFDnUaQqPd5wVYoMOOhbvl2
   l2YCS/PkQ5xUWerFMAOUIVPzgIeE3TLgIZ17gqxWSUZTI6nD1Dr/0ixsM
   9Arm/fmHjyBskMolOVeQg4/0HI+5cDbDE20bTxd4lDteFb7coO9ua3G5m
   GQF2ZjjQFNaPvkyi1F7HBPPL/SkQOOuHc/zITyYxlccxfc6I2Lj+iM1qU
   0/94oxMauEGwrzn68hvATJocnxAbwFBjYQgd7P3WbEa6hBL3l0anp6XLL
   g==;
X-CSE-ConnectionGUID: t7+iGARGQg6EKzjZO6L/IQ==
X-CSE-MsgGUID: +9Tr9NjrRxK0xhbCM4W76w==
X-IronPort-AV: E=McAfee;i="6800,10657,11954"; a="2385755"
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="2385755"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2026 11:32:06 -0800
X-CSE-ConnectionGUID: LKdoUus/QXSziw5XSMY/gA==
X-CSE-MsgGUID: wD1IGcNCS5mSmu4XFLR2xA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="7983893"
Received: from guptapa-desk.jf.intel.com (HELO desk) ([10.165.239.46])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2026 11:32:07 -0800
Date: Mon, 2 Nov 2026 11:31:55 -0800
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: Chengfeng Lin <lin2530632123@gmail.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>, 
	Daniel Borkmann <daniel@iogearbox.net>, x86@kernel.org, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [linus:master] [x86/bugs] a3af84b0fa:
 stress-ng.seccomp.ops_per_sec 95.7% regression
Message-ID: <yilzadgbu3w66oydn6gugvxcaxyncxq74evyfnknbpcka5vhns@crxojxq7dm76>
References: <202608191340.98574fe2-lkp@intel.com>
 <4h7zrdfpu3ailx5ajkyqohmcfuxgrk3tn7i7n3dkp3ksy5xehk@xqg5j6pqzocv>
 <179361623876.3.16264907931792312619.redis-ibpb-report@gmail.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <179361623876.3.16264907931792312619.redis-ibpb-report@gmail.com>

On Mon, Nov 02, 2026 at 06:43:58PM +0800, Chengfeng Lin wrote:
> Hi Pawan, Dave and Daniel,
> 
> I found another workload affected by a3af84b0fa00 while running MMTests:
> Redis ZPOPMIN throughput on v7.3 is about 13% lower than on v7.1.3.
> Unlike the repeated filter loading discussed here, the slowdown remains
> after the tasks that triggered the predictor flush (IBPB) have exited.
> Can this cost be reduced while preserving the security protection?
> 
> The machine is an i7-12700KF with 32 GiB RAM. All runs used CPU microcode
> 0x3e, and I did not disable any security mitigations. The test uses
> unmodified Redis 6.2.6 and MMTests' redis-benchmark-small recipe:
> 
>   redis-benchmark --csv -c 1 -r 50000 -n 100000 -P 256
> 
> There is one client, no CPU pinning, and all 20 logical CPUs are available.
> After each boot, I ran the full MMTests recipe nine times. Each run kept
> all 20 commands, including ZADD before ZPOPMIN, and the recipe's five
> internal repetitions:
> 
>                            v7.1.3 first       v7.3      v7.1.3 return
>   ZPOPMIN (requests/s)        999,366         871,397      1,000,947
>   GET (requests/s)          3,548,521       3,551,132      3,547,933
>   Complete test time (s)       61.396          61.704         61.301
> 
> ZPOPMIN is down 12.87% relative to the mean of the two v7.1.3 baselines.
> Within each boot, its coefficient of variation is below 0.75%; the two
> baselines differ by 0.16%.
> GET is essentially unchanged (+0.08%). The complete test, including
> startup and cleanup, takes 0.58% longer. The ZPOPMIN sequence drains the
> set without refilling it, so its request rate includes empty results,
> not just successful member removals.
> 
> Bisection identified a3af84b0fa00. To test the effect of a flush without
> changing kernel code, I used its parent, 96cce16e26dd, where Redis was
> still fast. On each CPU in turn, a short-lived helper enabled
> indirect-branch protection for itself using:
> 
>   prctl(PR_SET_SPECULATION_CTRL, PR_SPEC_INDIRECT_BRANCH,
>         PR_SPEC_FORCE_DISABLE, 0L, 0L)
> 
> After all helpers exited, I started Redis from a controller whose
> protection setting was unchanged. Redis did not inherit the helpers'
> setting.
> 
> ZPOPMIN throughput fell by 11.06% and 11.69% on two separate boots.
> After another reboot, I ran the same helpers without changing their
> protection settings. Throughput returned to baseline (a 1.33% difference).

So am I understanding it correctly that with the same kernel(without BPF
JIT mitigation) and same workload configuration produced different
performance results accross boots?

Is it possible for you to repeat the test with a different microcode? If
the microcode is late-loaded in your setup you can use dis_ucode_ldr kernel
parameter to skip loading the microcode.
