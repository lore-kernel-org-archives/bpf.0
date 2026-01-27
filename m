Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2E172F5492
	for <bpf@vger.kernel.org>; Tue, 27 Jan 2026 03:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769483551; cv=none; b=HqCliXnHHuelE/MoiTfHYG2iiHG84+G3ZByOzZvMC6OLG2Tv91Qhmiu4dPZ0JGWmGFA0k9QodgOI9liL9uLzNwpaYoNQQG7F+HfDyMyoQjoK4avRTcFgzQ+02RMx5AOIhSwPkwcj/nOJlu7H0fVbT6rq3RJTHKFxqreMgvw3lYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769483551; c=relaxed/simple;
	bh=F0xwNB4dWriN1a5K1PHUdXnOCCnIalH6lNe30Gb5pO0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uslISeUKX93Ij2VrBIEsJSRQW+aNSfuX/fYIKoUiRZEIRYT5X4b2Es87Jy9AHVxsfDjjKy7tYTowGcWO60tWGBf+OLjoDg6r/lU25y8EV1NOFJxzto7P82Aba1PE9Bgd/KYZDacPnbjA8dkEYMQ6A7vjdCo9OyDMs9ClboEOX2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e32pc3oN; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e32pc3oN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769483550; x=1801019550;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=F0xwNB4dWriN1a5K1PHUdXnOCCnIalH6lNe30Gb5pO0=;
  b=e32pc3oNe18I01Kcvs7X7IvsJJPn5ovHGk+P5gYi0gZ1IAHAYosXVF25
   hAPEPSXw9pzCBtV4WCSmI1p2VHwa8+KnNf+s67nXlCXctAJ43ak7tqcNC
   kiRVv9lsIDUz2oXEbQYK65Cd1fPr/b6a8vxZT+xMfE8sNKiv9iFBheyMV
   LW8Rj5TeflyX5oBo7Wuwi3z+ZMj08a4InXoeB5RRcuhO3lQcvS+eBNJOn
   8uLERF7dU7lAheafgy3Cilz9R96+Wh06CsnuL8V9d/LbXeOFC0llc+v9A
   lKuEpxuFwOuABa28qMJoleAsJnAQ84V/2AcMMWJp9mGVRD9Jrd7dyJZBq
   w==;
X-CSE-ConnectionGUID: zTnFu+apSomntwXUXa0dkw==
X-CSE-MsgGUID: FCDwsFqWRpu8Coq3PHAD6g==
X-IronPort-AV: E=McAfee;i="6800,10657,11683"; a="81388199"
X-IronPort-AV: E=Sophos;i="6.21,256,1763452800"; 
   d="scan'208";a="81388199"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2026 19:12:30 -0800
X-CSE-ConnectionGUID: bnCpPfnHQe+RN4RApbYWBA==
X-CSE-MsgGUID: 0uhEqLevR4q49t/ynCSgNQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,256,1763452800"; 
   d="scan'208";a="207910339"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 26 Jan 2026 19:12:27 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vkZVA-00000000XwE-3Y2d;
	Tue, 27 Jan 2026 03:12:24 +0000
Date: Tue, 27 Jan 2026 11:12:05 +0800
From: kernel test robot <lkp@intel.com>
To: Guillaume GONNET <ggonnet.linux@gmail.com>, daniel@iogearbox.net
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, ast@kernel.org,
	bpf@vger.kernel.org, ggonnet.linux@gmail.com,
	john.fastabend@gmail.com, martin.lau@linux.dev
Subject: Re: [PATCH] bpf: fix TCX/netkit detach permissions when prog FD
 isn't given
Message-ID: <202601271136.K6L9UhO2-lkp@intel.com>
References: <20260126173431.19825-1-ggonnet.linux@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260126173431.19825-1-ggonnet.linux@gmail.com>

Hi Guillaume,

kernel test robot noticed the following build errors:

[auto build test ERROR on bpf-next/net]
[also build test ERROR on bpf/master linus/master v6.19-rc7 next-20260126]
[cannot apply to bpf-next/master]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Guillaume-GONNET/bpf-fix-TCX-netkit-detach-permissions-when-prog-FD-isn-t-given/20260127-013722
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git net
patch link:    https://lore.kernel.org/r/20260126173431.19825-1-ggonnet.linux%40gmail.com
patch subject: [PATCH] bpf: fix TCX/netkit detach permissions when prog FD isn't given
config: powerpc-pcm030_defconfig (https://download.01.org/0day-ci/archive/20260127/202601271136.K6L9UhO2-lkp@intel.com/config)
compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project 9b8addffa70cee5b2acc5454712d9cf78ce45710)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260127/202601271136.K6L9UhO2-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202601271136.K6L9UhO2-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from net/core/dev.c:114:
   In file included from include/net/tcx.h:7:
>> include/linux/bpf_mprog.h:348:10: error: call to undeclared function 'bpf_net_capable'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     348 |                 return bpf_net_capable();
         |                        ^
   include/linux/bpf_mprog.h:348:10: note: did you mean 'sk_net_capable'?
   include/net/sock.h:3024:6: note: 'sk_net_capable' declared here
    3024 | bool sk_net_capable(const struct sock *sk, int cap);
         |      ^
   1 error generated.


vim +/bpf_net_capable +348 include/linux/bpf_mprog.h

   343	
   344	static inline bool bpf_mprog_detach_empty(enum bpf_prog_type type)
   345	{
   346		switch (type) {
   347		case BPF_PROG_TYPE_SCHED_CLS:
 > 348			return bpf_net_capable();

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
