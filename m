Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BD102E8DE3;
	Sun, 18 Oct 2026 12:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792325278; cv=none; b=iNpLm7UA30ibyR3xLOCsGJV8DboOr6UvFQAZcsDDNyl93vrWQR20LI2JTXeXDzqQlpK8RrKQnxQeGOnBiLVhzO0g6xNRDW04XkgotZJcWArmhfKTM7iESM1DudtoWoVV2PxbujjgOO6jg1UzHla0z9pNtF6AC2CVou/Y4PBRAS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792325278; c=relaxed/simple;
	bh=Nbo19b7G3oNxBbB32F5vfOWulsJT5KJmK1ShCi/27xg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VeVPFo96FaeNdYAwl/F8HqTT5CRgqceDy8YIQlgoVlrE6J0Zy1oRcsyZvCA6O/y5EYVgr6ADC/eVDfkFIqh6nQyOwu9RPbfbJUln8J812GEEwu1KiwGwrkzlKGSNPwiRp/bLdbqlI6zndZuClzscR/6gi0nKVRoU1FDURYjp2ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lvKPRaAE; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lvKPRaAE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792325277; x=1823861277;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Nbo19b7G3oNxBbB32F5vfOWulsJT5KJmK1ShCi/27xg=;
  b=lvKPRaAEV+f9bsTj4E9gFuWtTNFtTakIJ8Be/0w9CuYhQ0ZTQMSUx/Vx
   u9JxCEZzO4vGrOCMhXdnpVasa4OxhH0Uf//jnjcA4s13acVH9eRtpXC0y
   XVlay36KriyXD3Hc37Nwx9qV+XNPrWhYIpK+rga3x58713TudtKk0EPuo
   HL29egrMHR9AML3d4hGwP+JTyQW9zIuJG3HNQPVokFpxHdruzwaiuus7H
   d8qfEV/XDHZ6K4DCMe41896JdtmxJaWsqnkD+M/RcXEnIQI31Imnvosmf
   H19vtCAcmV+wDudBOcx9BcHBLaXhbVLeD3E8CxE8MRpSxp+dEX2lUhIMA
   Q==;
X-CSE-ConnectionGUID: 58n/fiX/Rty/vlWlaK79xw==
X-CSE-MsgGUID: 0s0SiAEPRjKSQoPjmTqu+w==
X-IronPort-AV: E=McAfee;i="6800,10657,11938"; a="931700"
X-IronPort-AV: E=Sophos;i="6.27,165,1787036400"; 
   d="scan'208";a="931700"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2026 05:07:57 -0700
X-CSE-ConnectionGUID: C2O++14kShWBevqM8q8YNw==
X-CSE-MsgGUID: LWkPYdNFRryIksqKkb0Lsg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,165,1787036400"; 
   d="scan'208";a="2611520"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 18 Oct 2026 05:07:53 -0700
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xIPg6-00000000KOO-3Pyn;
	Sun, 18 Oct 2026 12:07:50 +0000
Date: Sun, 18 Oct 2026 20:06:58 +0800
From: kernel test robot <lkp@intel.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, daniel@iogearbox.net, andrii@kernel.org,
	eddyz87@gmail.com, memxor@gmail.com, netdev@vger.kernel.org,
	josef@toxicpanda.com, mason@kernel.org
Subject: Re: [PATCH bpf-next v2 04/43] bpf: don't hand out a linked element
 as extra element
Message-ID: <202610182013.abPmS8oP-lkp@intel.com>
References: <20261017163745.3341787-5-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261017163745.3341787-5-alexei.starovoitov@gmail.com>

Hi Alexei,

kernel test robot noticed the following build errors:

[auto build test ERROR on 458575e1f2ddea944d679fe778c92e370a9b61a4]

url:    https://github.com/intel-lab-lkp/linux/commits/Alexei-Starovoitov/bpf-use-the-frame-mem-type-in-devmap-egress-XDP/20261017-163703
base:   458575e1f2ddea944d679fe778c92e370a9b61a4
patch link:    https://lore.kernel.org/r/20261017163745.3341787-5-alexei.starovoitov%40gmail.com
patch subject: [PATCH bpf-next v2 04/43] bpf: don't hand out a linked element as extra element
config: arc-randconfig-1000-20261018 (https://download.01.org/0day-ci/archive/20261018/202610182013.abPmS8oP-lkp@intel.com/config)
compiler: arc-linux-gcc (GCC) 11.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261018/202610182013.abPmS8oP-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202610182013.abPmS8oP-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from include/linux/atomic.h:80,
                    from include/asm-generic/bitops/lock.h:5,
                    from arch/arc/include/asm/bitops.h:190,
                    from include/linux/bitops.h:67,
                    from include/linux/log2.h:12,
                    from include/asm-generic/div64.h:55,
                    from ./arch/arc/include/generated/asm/div64.h:1,
                    from include/linux/math.h:6,
                    from include/linux/math64.h:6,
                    from include/linux/time64.h:5,
                    from include/linux/restart_block.h:9,
                    from include/linux/thread_info.h:14,
                    from include/asm-generic/preempt.h:5,
                    from ./arch/arc/include/generated/asm/preempt.h:1,
                    from include/linux/preempt.h:107,
                    from include/linux/alloc_tag.h:11,
                    from include/linux/workqueue.h:9,
                    from include/linux/bpf.h:12,
                    from kernel/bpf/hashtab.c:5:
   kernel/bpf/hashtab.c: In function 'alloc_htab_elem':
>> include/linux/atomic/atomic-arch-fallback.h:384:27: error: implicit declaration of function 'arch_cmpxchg_local'; did you mean 'raw_cmpxchg_local'? [-Werror=implicit-function-declaration]
     384 | #define raw_cmpxchg_local arch_cmpxchg_local
         |                           ^~~~~~~~~~~~~~~~~~
   include/linux/atomic/atomic-arch-fallback.h:392:16: note: in expansion of macro 'raw_cmpxchg_local'
     392 |         ___r = raw_cmpxchg_local((_ptr), ___o, (_new)); \
         |                ^~~~~~~~~~~~~~~~~
   include/linux/atomic/atomic-instrumented.h:5022:9: note: in expansion of macro 'raw_try_cmpxchg_local'
    5022 |         raw_try_cmpxchg_local(__ai_ptr, __ai_oldp, __VA_ARGS__); \
         |         ^~~~~~~~~~~~~~~~~~~~~
   kernel/bpf/hashtab.c:1292:35: note: in expansion of macro 'try_cmpxchg_local'
    1292 |                         } while (!try_cmpxchg_local(pl_new, &l_new, NULL));
         |                                   ^~~~~~~~~~~~~~~~~
   include/linux/atomic/atomic-arch-fallback.h:392:14: warning: assignment to 'struct htab_elem *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
     392 |         ___r = raw_cmpxchg_local((_ptr), ___o, (_new)); \
         |              ^
   include/linux/atomic/atomic-instrumented.h:5022:9: note: in expansion of macro 'raw_try_cmpxchg_local'
    5022 |         raw_try_cmpxchg_local(__ai_ptr, __ai_oldp, __VA_ARGS__); \
         |         ^~~~~~~~~~~~~~~~~~~~~
   kernel/bpf/hashtab.c:1292:35: note: in expansion of macro 'try_cmpxchg_local'
    1292 |                         } while (!try_cmpxchg_local(pl_new, &l_new, NULL));
         |                                   ^~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +384 include/linux/atomic/atomic-arch-fallback.h

8c8b096a23d12f Peter Zijlstra 2023-05-31  383  
9257959a6e5b4f Mark Rutland   2023-06-05 @384  #define raw_cmpxchg_local arch_cmpxchg_local
8c8b096a23d12f Peter Zijlstra 2023-05-31  385  

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
