Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B668729E10C
	for <bpf@vger.kernel.org>; Mon, 16 Feb 2026 22:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771282603; cv=none; b=LNU46eN7L3Ed5EqZBI2VqAYnVd+YR6srnqqbFVv1lYHS5Tky4mJFSJ7nyB11LpO/WzgzCBlD6azajXUfBJkAznVzeYmeE7rwSETEy2n9XKz9Sjg6oAzaW2l2f3XeqvGV56X4o2Hheg1zqPdL/rS7An67OKecNxZR+IIG5DfdGUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771282603; c=relaxed/simple;
	bh=5+qSj58YUGwEKtn88r89DeFNdf0ZmunrvT5PzJ8DcZY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E2s23VYKzG7FCLDZGil5cwqfVVQTJ56Un4orI+Bs8Oz0vYBZTwi4J1O5EkhOboUhGYpfuX5RKBoyxAc3wM1qEPwFaANKMtpA6AW/Fp3zUdfcNCWB4qQuIN7b5XWYJ3cSmLjS16pPXABUsQKVlmNmNf5IFN/g8PdKVhzxW3piiIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bz4FbvvS; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bz4FbvvS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771282601; x=1802818601;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5+qSj58YUGwEKtn88r89DeFNdf0ZmunrvT5PzJ8DcZY=;
  b=bz4FbvvSObBvK17TEnIkG3QPDSpgO+lJQkWzLfeAtUiy2UNLg8gtezjG
   KRCbm2xuM0Njs1+lciQ4kbniumBtsOOy2a+plfQl705vOTpG6gaOA4TCz
   pG7QDttS0qhw8rABPBI08TuvV53HBbnao703P9WsAHmp8vBgW2UO1iuzl
   oVBOQj0acz7xbHWYLbMmp0xF9VtohTLpyabyZnlMLV2psvAA5qA6wQgZ7
   /Pp+7KnCe6+qnYdL/gQr/Y7teoKcAIHvAVPbbd8w+unLBV+g6wUd78Kik
   Cf+wwOk8V7+Xt40pHaXrKqs8KzyqY1DCIWQRzP2Ut/4TV+N7bJ9nXarmv
   Q==;
X-CSE-ConnectionGUID: uieyp7IUSP+A+4nqwEViZQ==
X-CSE-MsgGUID: 7Eo/i+mgQAa0/4/PpB7YsA==
X-IronPort-AV: E=McAfee;i="6800,10657,11703"; a="72351870"
X-IronPort-AV: E=Sophos;i="6.21,295,1763452800"; 
   d="scan'208";a="72351870"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2026 14:56:41 -0800
X-CSE-ConnectionGUID: xg9nOKBhSu+d0Q0Mmgaiiw==
X-CSE-MsgGUID: MgljM/ILRQGGWU+iC+eVdQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,295,1763452800"; 
   d="scan'208";a="242785416"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 16 Feb 2026 14:56:38 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vs7W8-000000010Lg-33tt;
	Mon, 16 Feb 2026 22:56:36 +0000
Date: Tue, 17 Feb 2026 06:55:57 +0800
From: kernel test robot <lkp@intel.com>
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, bpf@vger.kernel.org,
	ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
	kafai@meta.com, kernel-team@meta.com, eddyz87@gmail.com,
	memxor@gmail.com
Cc: oe-kbuild-all@lists.linux.dev, Mykyta Yatsenko <yatsenko@meta.com>
Subject: Re: [PATCH bpf-next v2] bpf: Fix special fields mem leak for
 non-prealloc maps
Message-ID: <202602170623.VkzXTazv-lkp@intel.com>
References: <20260216131341.1285427-1-mykyta.yatsenko5@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260216131341.1285427-1-mykyta.yatsenko5@gmail.com>

Hi Mykyta,

kernel test robot noticed the following build warnings:

[auto build test WARNING on bpf-next/master]

url:    https://github.com/intel-lab-lkp/linux/commits/Mykyta-Yatsenko/bpf-Fix-special-fields-mem-leak-for-non-prealloc-maps/20260216-211513
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
patch link:    https://lore.kernel.org/r/20260216131341.1285427-1-mykyta.yatsenko5%40gmail.com
patch subject: [PATCH bpf-next v2] bpf: Fix special fields mem leak for non-prealloc maps
config: parisc-randconfig-r112-20260217 (https://download.01.org/0day-ci/archive/20260217/202602170623.VkzXTazv-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 9.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260217/202602170623.VkzXTazv-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202602170623.VkzXTazv-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   kernel/bpf/helpers.c:1212:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned long long ( *[usertype] callback_fn )( ... ) @@     got void [noderef] __rcu * @@
   kernel/bpf/helpers.c:1212:21: sparse:     expected unsigned long long ( *[usertype] callback_fn )( ... )
   kernel/bpf/helpers.c:1212:21: sparse:     got void [noderef] __rcu *
   kernel/bpf/helpers.c:2601:18: sparse: sparse: symbol 'bpf_task_release_dtor' was not declared. Should it be static?
   kernel/bpf/helpers.c:2631:18: sparse: sparse: symbol 'bpf_cgroup_release_dtor' was not declared. Should it be static?
   kernel/bpf/helpers.c: note: in included file (through arch/parisc/include/asm/atomic.h, include/linux/atomic.h, arch/parisc/include/asm/bitops.h, ...):
>> arch/parisc/include/asm/cmpxchg.h:32:39: sparse: sparse: cast truncates bits from constant value (eb9f becomes 9f)
>> arch/parisc/include/asm/cmpxchg.h:32:39: sparse: sparse: cast truncates bits from constant value (eb9f becomes 9f)

vim +32 arch/parisc/include/asm/cmpxchg.h

9e5228ce0b9619 Paul Gortmaker    2012-04-01  22  
9e5228ce0b9619 Paul Gortmaker    2012-04-01  23  /* optimizer better get rid of switch since size is a constant */
9e5228ce0b9619 Paul Gortmaker    2012-04-01  24  static inline unsigned long
068550631fbe0b Andrzej Hajda     2023-01-18  25  __arch_xchg(unsigned long x, volatile void *ptr, int size)
9e5228ce0b9619 Paul Gortmaker    2012-04-01  26  {
9e5228ce0b9619 Paul Gortmaker    2012-04-01  27  	switch (size) {
9e5228ce0b9619 Paul Gortmaker    2012-04-01  28  #ifdef CONFIG_64BIT
2a7d4eed5720d1 John David Anglin 2020-10-02  29  	case 8: return __xchg64(x, (volatile unsigned long *) ptr);
9e5228ce0b9619 Paul Gortmaker    2012-04-01  30  #endif
2a7d4eed5720d1 John David Anglin 2020-10-02  31  	case 4: return __xchg32((int) x, (volatile int *) ptr);
2a7d4eed5720d1 John David Anglin 2020-10-02 @32  	case 1: return __xchg8((char) x, (volatile char *) ptr);
9e5228ce0b9619 Paul Gortmaker    2012-04-01  33  	}
9e5228ce0b9619 Paul Gortmaker    2012-04-01  34  	__xchg_called_with_bad_pointer();
9e5228ce0b9619 Paul Gortmaker    2012-04-01  35  	return x;
9e5228ce0b9619 Paul Gortmaker    2012-04-01  36  }
9e5228ce0b9619 Paul Gortmaker    2012-04-01  37  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
