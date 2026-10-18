Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A73A3D9667;
	Sun, 18 Oct 2026 09:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792316401; cv=none; b=OhUSJRD7/UTVr7uJvIB/LeY5N0BTRLT8A4uAgn/G9wiDJ6CQ2K+ZfB0jOTVqqHZ2+iT6mXzfAWUhnda6RUmjBmDs1+im9ZW4R4lMQPb47u0xWxpH7QguyPhvdEkiVSd8z8Kgyfo10X0GWA/BzMGyv7FibDFgTE83qFWIZiGdsqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792316401; c=relaxed/simple;
	bh=n1y2NmtzRdB5vhgQbqupXPILwaQdTHoyQOYiRId4FV4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bQhyNdTY3x07w7LdnOthFm9UUFvuAxeTDHf2dTj0uTqVEKj3EdwIaZqf6le7LYrCgvdXwWeErebcqiWRv9rSTbWxdO9fGpcXVX3XqBhTnypB+aIM4848dzwhR2qRDefT32/ENpT1xqEgrSGoJfXk/a0zEdnWqSVFuqM0fpDL0oM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VEifHBGz; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VEifHBGz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792316399; x=1823852399;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=n1y2NmtzRdB5vhgQbqupXPILwaQdTHoyQOYiRId4FV4=;
  b=VEifHBGz87suKtXpOv+9HAai/vaE6cU7bGJCImfUa5w6Phk/iKbys+hO
   qNCIus8fXOHMJjmHs3RYXom/kYQ3ZUaYUPYaWgUmuJpRbScFvo0pemovf
   lZPMjVJzii7S3bgrnIQbIAkEYrUZnE+/dPMro6XO++uhuu8xfXvvZZnBO
   tAaKGXLPe85AJTPMKsFsHVrQQ6a09TiE8MsD2fzjo1PWwRg4TY4FjLlm7
   YGWuKkZTICZlJwX9ZlRRnjL9Ycd12fbyeODpIBKKbYZmIuvJjBWncqYpG
   5KKumxABYev+IHfRTJLXws0RshFC8xQMk0JgWY2a6ZRn/qGUM97e9c9wI
   g==;
X-CSE-ConnectionGUID: jYxDGNblSSK11+8z6KAlmA==
X-CSE-MsgGUID: DhsnSpG5QO6cV58jDDlnbQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11938"; a="932931"
X-IronPort-AV: E=Sophos;i="6.27,165,1787036400"; 
   d="scan'208";a="932931"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2026 02:39:47 -0700
X-CSE-ConnectionGUID: hH07kIS+TyWxNa5KqRRQig==
X-CSE-MsgGUID: 3ALg+iBDRfGuQdoMnWqikA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,165,1787036400"; 
   d="scan'208";a="4048612"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
  by fmviesa012.fm.intel.com with ESMTP; 18 Oct 2026 02:39:45 -0700
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xINMj-00000000KIE-25N2;
	Sun, 18 Oct 2026 09:39:41 +0000
Date: Sun, 18 Oct 2026 17:39:24 +0800
From: kernel test robot <lkp@intel.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, daniel@iogearbox.net, andrii@kernel.org,
	eddyz87@gmail.com, memxor@gmail.com, netdev@vger.kernel.org,
	josef@toxicpanda.com, mason@kernel.org
Subject: Re: [PATCH bpf-next v2 04/43] bpf: don't hand out a linked element
 as extra element
Message-ID: <202610181750.BoqAddaF-lkp@intel.com>
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

kernel test robot noticed the following build warnings:

[auto build test WARNING on 458575e1f2ddea944d679fe778c92e370a9b61a4]

url:    https://github.com/intel-lab-lkp/linux/commits/Alexei-Starovoitov/bpf-use-the-frame-mem-type-in-devmap-egress-XDP/20261017-163703
base:   458575e1f2ddea944d679fe778c92e370a9b61a4
patch link:    https://lore.kernel.org/r/20261017163745.3341787-5-alexei.starovoitov%40gmail.com
patch subject: [PATCH bpf-next v2 04/43] bpf: don't hand out a linked element as extra element
config: arc-randconfig-1000-20261018 (https://download.01.org/0day-ci/archive/20261018/202610181750.BoqAddaF-lkp@intel.com/config)
compiler: arc-linux-gcc (GCC) 11.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261018/202610181750.BoqAddaF-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202610181750.BoqAddaF-lkp@intel.com/

All warnings (new ones prefixed by >>):

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
   include/linux/atomic/atomic-arch-fallback.h:384:27: error: implicit declaration of function 'arch_cmpxchg_local'; did you mean 'raw_cmpxchg_local'? [-Werror=implicit-function-declaration]
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
>> include/linux/atomic/atomic-arch-fallback.h:392:14: warning: assignment to 'struct htab_elem *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
     392 |         ___r = raw_cmpxchg_local((_ptr), ___o, (_new)); \
         |              ^
   include/linux/atomic/atomic-instrumented.h:5022:9: note: in expansion of macro 'raw_try_cmpxchg_local'
    5022 |         raw_try_cmpxchg_local(__ai_ptr, __ai_oldp, __VA_ARGS__); \
         |         ^~~~~~~~~~~~~~~~~~~~~
   kernel/bpf/hashtab.c:1292:35: note: in expansion of macro 'try_cmpxchg_local'
    1292 |                         } while (!try_cmpxchg_local(pl_new, &l_new, NULL));
         |                                   ^~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +392 include/linux/atomic/atomic-arch-fallback.h

8c8b096a23d12f Peter Zijlstra 2023-05-31  385  
9257959a6e5b4f Mark Rutland   2023-06-05  386  #ifdef arch_try_cmpxchg_local
9257959a6e5b4f Mark Rutland   2023-06-05  387  #define raw_try_cmpxchg_local arch_try_cmpxchg_local
9257959a6e5b4f Mark Rutland   2023-06-05  388  #else
9257959a6e5b4f Mark Rutland   2023-06-05  389  #define raw_try_cmpxchg_local(_ptr, _oldp, _new) \
9257959a6e5b4f Mark Rutland   2023-06-05  390  ({ \
9257959a6e5b4f Mark Rutland   2023-06-05  391  	typeof(*(_ptr)) *___op = (_oldp), ___o = *___op, ___r; \
9257959a6e5b4f Mark Rutland   2023-06-05 @392  	___r = raw_cmpxchg_local((_ptr), ___o, (_new)); \
9257959a6e5b4f Mark Rutland   2023-06-05  393  	if (unlikely(___r != ___o)) \
9257959a6e5b4f Mark Rutland   2023-06-05  394  		*___op = ___r; \
9257959a6e5b4f Mark Rutland   2023-06-05  395  	likely(___r == ___o); \
9257959a6e5b4f Mark Rutland   2023-06-05  396  })
8c8b096a23d12f Peter Zijlstra 2023-05-31  397  #endif
8c8b096a23d12f Peter Zijlstra 2023-05-31  398  

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
