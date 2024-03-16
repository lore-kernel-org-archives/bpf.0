Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92D77CA6B
	for <bpf@vger.kernel.org>; Sat, 16 Mar 2024 07:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710573404; cv=none; b=V2iJNrSbVYpPXkrxI/zZ5swdRB23xKiGCYmQCBk4DESIMODZeQ8iXXXZ6KLdebQvlmTeDKThdwQcQo2ePEGVddeIX0OIheLBs1zH1z3eGKx+becr6smtHW8RUMk3hTp8EFSEdCTe7qehZ876KodJVe9Tfa/lCiS4W9Pn/K3j5jM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710573404; c=relaxed/simple;
	bh=pb30vU5hSB2U0Cdxy74wJKqr4POzniEQmDmRkVhngYE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LPQsXsxVGuLIRFDRJPTpWJLp5FtETTq9+7m42iqdYsWHRQkGgHaEsb3EhHt5H0wDBPv684zgTr7jzXs97K3cco9KFlRXzwS/Z3723p2Eu/PpwNZNVOEaFz2mGJe4mAUw1xxqoVF3/pBxlu2RPWAlW8vo3A+5YA6ADZ5nQ99Qyks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aexK2kgb; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aexK2kgb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710573403; x=1742109403;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=pb30vU5hSB2U0Cdxy74wJKqr4POzniEQmDmRkVhngYE=;
  b=aexK2kgbqEnjy9IUhYMlpINmhX6mNqRLLXeDGlfT3GZuCB4WekezIe0i
   hfzEH9aOcmGclwTjporKD60smfFsaJXrSKmFF/628NwuLBtS+MTuCWC8G
   PlPsJTk9G0MFQ+wqQ77JYTq4nu6y4tsFl0ncZT5PteYzxFVhKWvIUF/bR
   0s7bXYtr939kbREMlqzOLoEAdINykaO309mfm/b9PIBar07+0Yj4qq4CQ
   jffOmT8mx2Gf0/QcwZS1KeEZiNcw7xDZbh+6ISW32qayRWNTQM6OEQGeM
   SdKwRv52uxYKq2qLaQypJW0QtHl35DGcZFeYBmeQssw5DiUhOA3E59LHN
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11014"; a="5582475"
X-IronPort-AV: E=Sophos;i="6.07,129,1708416000"; 
   d="scan'208";a="5582475"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2024 00:16:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,129,1708416000"; 
   d="scan'208";a="43961214"
Received: from lkp-server01.sh.intel.com (HELO b21307750695) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 16 Mar 2024 00:16:38 -0700
Received: from kbuild by b21307750695 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rlOHT-000FA3-2k;
	Sat, 16 Mar 2024 07:16:35 +0000
Date: Sat, 16 Mar 2024 15:16:02 +0800
From: kernel test robot <lkp@intel.com>
To: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	ast@kernel.org, daniel@iogearbox.net, martin.lau@kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, andrii@kernel.org,
	kernel-team@meta.com
Subject: Re: [PATCH bpf-next 2/5] bpf: pass whole link instead of prog when
 triggering raw tracepoint
Message-ID: <202403161557.04JKlQo6-lkp@intel.com>
References: <20240315204524.967664-3-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240315204524.967664-3-andrii@kernel.org>

Hi Andrii,

kernel test robot noticed the following build errors:

[auto build test ERROR on bpf-next/master]

url:    https://github.com/intel-lab-lkp/linux/commits/Andrii-Nakryiko/bpf-flatten-bpf_probe_register-call-chain/20240316-044808
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
patch link:    https://lore.kernel.org/r/20240315204524.967664-3-andrii%40kernel.org
patch subject: [PATCH bpf-next 2/5] bpf: pass whole link instead of prog when triggering raw tracepoint
config: riscv-defconfig (https://download.01.org/0day-ci/archive/20240316/202403161557.04JKlQo6-lkp@intel.com/config)
compiler: clang version 19.0.0git (https://github.com/llvm/llvm-project 8f68022f8e6e54d1aeae4ed301f5a015963089b7)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240316/202403161557.04JKlQo6-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202403161557.04JKlQo6-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from kernel/bpf/syscall.c:4:
   In file included from include/linux/bpf.h:21:
   In file included from include/linux/kallsyms.h:13:
   In file included from include/linux/mm.h:2188:
   include/linux/vmstat.h:522:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     522 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
>> kernel/bpf/syscall.c:3477:36: error: incompatible pointer types passing 'struct bpf_raw_tp_link *' to parameter of type 'struct bpf_prog *' [-Werror,-Wincompatible-pointer-types]
    3477 |         bpf_probe_unregister(raw_tp->btp, raw_tp);
         |                                           ^~~~~~
   include/linux/trace_events.h:798:88: note: passing argument to parameter 'p' here
     798 | static inline int bpf_probe_unregister(struct bpf_raw_event_map *btp, struct bpf_prog *p)
         |                                                                                        ^
   kernel/bpf/syscall.c:3831:38: error: incompatible pointer types passing 'struct bpf_raw_tp_link *' to parameter of type 'struct bpf_prog *' [-Werror,-Wincompatible-pointer-types]
    3831 |         err = bpf_probe_register(link->btp, link);
         |                                             ^~~~
   include/linux/trace_events.h:794:86: note: passing argument to parameter 'p' here
     794 | static inline int bpf_probe_register(struct bpf_raw_event_map *btp, struct bpf_prog *p)
         |                                                                                      ^
   kernel/bpf/syscall.c:5822:30: warning: bitwise operation between different enumeration types ('enum bpf_arg_type' and 'enum bpf_type_flag') [-Wenum-enum-conversion]
    5822 |         .arg2_type      = ARG_PTR_TO_MEM | MEM_RDONLY,
         |                           ~~~~~~~~~~~~~~ ^ ~~~~~~~~~~
   2 warnings and 2 errors generated.


vim +3477 kernel/bpf/syscall.c

  3471	
  3472	static void bpf_raw_tp_link_release(struct bpf_link *link)
  3473	{
  3474		struct bpf_raw_tp_link *raw_tp =
  3475			container_of(link, struct bpf_raw_tp_link, link);
  3476	
> 3477		bpf_probe_unregister(raw_tp->btp, raw_tp);
  3478		bpf_put_raw_tracepoint(raw_tp->btp);
  3479	}
  3480	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
