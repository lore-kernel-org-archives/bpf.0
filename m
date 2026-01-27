Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 441E01C5D7D
	for <bpf@vger.kernel.org>; Tue, 27 Jan 2026 01:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769479045; cv=none; b=oekwz1oobRiurBkFo5Hegx2CyG6m9BOY5O6J1u/qmyN95yP/uoJeqSUzBHq11iHxnVHuhKHjszEz5c6GU77YeJDpoIyX9gM3h9LA26sk0/CA3g5YvITUXkp0/frn7PToQa1I+ne2oQ2b9Mxytz/Yb/dFMjdZ7o7kAWe+mIqCUTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769479045; c=relaxed/simple;
	bh=ZzM8uB1l0zJ46D6h/XoMohgRYAGwDL4rrhiYM5uJ+24=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KuG7rLsoYgkc78/FwlOu+f+LII0AssZ8tTSuK80vs1ZMofGugk+xju5zO7ijoOAtTSv2E08cAciVMBA3a719+QGcSNOq1KUEKbQF21AofIAMmo8cSS06VYysrzPNTG8yAAoevvsLisUhI9VefMsMC2ogOUWFqJJ8uL3O16FqHcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aQ+64hOD; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aQ+64hOD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769479043; x=1801015043;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ZzM8uB1l0zJ46D6h/XoMohgRYAGwDL4rrhiYM5uJ+24=;
  b=aQ+64hODa6tP7Ok66prfchsqfvcjXjseckHoajmrs26Hjh9ffdtZpYs2
   EON2nbqy2qH4Dw7IRVLqlW8ZBeAhryEFiQCiCYUTE74uXX0HoliTpGwI6
   fg7kA4oxViI1b3JEIe5DLMx2d57aTf3z0ezNP/wvpJnnEo/gzktqjEN7g
   YuBxEUwPp1mqcc0NOfMgwZqbKBSgZUCYnrnOWQBQk77q4SPWHKwEPitHG
   4y14hStBC0tewNL9QY+3zQplekVQBeHcW7FJackOUSzn9syFxMQvOmNWy
   d1V8KBNs20Rn2giNxPmQv6XL90qzBj4RWmXk5x2xygjy9hleX/bpee3eR
   A==;
X-CSE-ConnectionGUID: NjmwOkoLQu6XQYO40i1nSw==
X-CSE-MsgGUID: iM1/9uFAT0uvY11MFIxX7A==
X-IronPort-AV: E=McAfee;i="6800,10657,11683"; a="88241923"
X-IronPort-AV: E=Sophos;i="6.21,256,1763452800"; 
   d="scan'208";a="88241923"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2026 17:57:23 -0800
X-CSE-ConnectionGUID: 7Xxf7rlxQUmuafsS97qZog==
X-CSE-MsgGUID: jofJrfDxRuewqjZnFsMtzQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,256,1763452800"; 
   d="scan'208";a="206958434"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 26 Jan 2026 17:57:20 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vkYKU-00000000Xs2-0906;
	Tue, 27 Jan 2026 01:57:18 +0000
Date: Tue, 27 Jan 2026 09:56:21 +0800
From: kernel test robot <lkp@intel.com>
To: Guillaume GONNET <ggonnet.linux@gmail.com>, daniel@iogearbox.net
Cc: oe-kbuild-all@lists.linux.dev, ast@kernel.org, bpf@vger.kernel.org,
	ggonnet.linux@gmail.com, john.fastabend@gmail.com,
	martin.lau@linux.dev
Subject: Re: [PATCH] bpf: fix TCX/netkit detach permissions when prog FD
 isn't given
Message-ID: <202601270903.NBB1BD47-lkp@intel.com>
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
config: sh-defconfig (https://download.01.org/0day-ci/archive/20260127/202601270903.NBB1BD47-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 15.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260127/202601270903.NBB1BD47-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202601270903.NBB1BD47-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from include/net/tcx.h:7,
                    from net/core/dev.c:114:
   include/linux/bpf_mprog.h: In function 'bpf_mprog_detach_empty':
>> include/linux/bpf_mprog.h:348:24: error: implicit declaration of function 'bpf_net_capable'; did you mean 'sk_net_capable'? [-Wimplicit-function-declaration]
     348 |                 return bpf_net_capable();
         |                        ^~~~~~~~~~~~~~~
         |                        sk_net_capable


vim +348 include/linux/bpf_mprog.h

   343	
   344	static inline bool bpf_mprog_detach_empty(enum bpf_prog_type type)
   345	{
   346		switch (type) {
   347		case BPF_PROG_TYPE_SCHED_CLS:
 > 348			return bpf_net_capable();

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
