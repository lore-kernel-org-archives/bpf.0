Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB009D2FE
	for <bpf@vger.kernel.org>; Sat, 16 Mar 2024 07:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710572802; cv=none; b=o+5XHicQZZIo3YMS3ozBClgMJxO+dARlOBEsZ/IVOJxi3EhlfPsozWKxs4w9txgDjGHz+W0x+hhzx0Vgz75EnNkBODvMok7rD1khjemPPwTYTeS/Zg5ssWfn2STLVIKZMGaQpk8LAf5AEdfh05VsMBtEV5f3f60ipOI5KSTPjMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710572802; c=relaxed/simple;
	bh=fmtXuNj0Bj/2ZX5YKZDcefNt6obONJhTtFpE9R9CYgA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dJX2XpQ9HqEvG6MOFPICaCtYArygvexlofeZnSV0Oi7OI4pG91tv8lm289PsQf++dfnxSGCehGH0j+E09YSQ0oF8Xlq4IL8MoPDR/VnH9XG/rEr3ydmGvKvJQoVZiTQaBEAdaVu7GhkU6O3HzwZv7/1nQgNxOs9Ls62A/KvvFK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dUxe5msK; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dUxe5msK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710572801; x=1742108801;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=fmtXuNj0Bj/2ZX5YKZDcefNt6obONJhTtFpE9R9CYgA=;
  b=dUxe5msKDTm/i8Vz56v+TdOsZkba0E22EnIWbR9rfRMYfTzY0FKqiJk4
   9tMI7Q9gXJgRPPFX3WVl5pU4YaTrNZY+0SPgXcBHa/lUcTS2CiD+VBSmi
   xhwOxjB6AMhITJ9NuD5AMxD4ne2rdo+8fFlGqYU6hLIH/hFJXpaw1YXJj
   l58O7Y9aXDHt/izzu6TZ1HXEjBwvxCWKcPs6iwu6nH2Z4s+Emps8JnYpg
   ipondNZ1Ri9ncK720SXJol9m4EoBxrI5RRHeIbZBSxD0t2eJfGP+lV8QR
   Ny+TOhcTgVSAB2ZtsQgm08t2/PRd66mWsn6p/cLDhVehx7qbt+rJiwIiL
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11014"; a="9281711"
X-IronPort-AV: E=Sophos;i="6.07,129,1708416000"; 
   d="scan'208";a="9281711"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2024 00:06:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,129,1708416000"; 
   d="scan'208";a="17507555"
Received: from lkp-server01.sh.intel.com (HELO b21307750695) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 16 Mar 2024 00:06:38 -0700
Received: from kbuild by b21307750695 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rlO7n-000F9l-2H;
	Sat, 16 Mar 2024 07:06:35 +0000
Date: Sat, 16 Mar 2024 15:05:43 +0800
From: kernel test robot <lkp@intel.com>
To: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	ast@kernel.org, daniel@iogearbox.net, martin.lau@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, andrii@kernel.org, kernel-team@meta.com
Subject: Re: [PATCH bpf-next 2/5] bpf: pass whole link instead of prog when
 triggering raw tracepoint
Message-ID: <202403161441.xOAmLvHS-lkp@intel.com>
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
config: arm64-defconfig (https://download.01.org/0day-ci/archive/20240316/202403161441.xOAmLvHS-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240316/202403161441.xOAmLvHS-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202403161441.xOAmLvHS-lkp@intel.com/

All errors (new ones prefixed by >>):

   kernel/bpf/syscall.c: In function 'bpf_raw_tp_link_release':
>> kernel/bpf/syscall.c:3477:43: error: passing argument 2 of 'bpf_probe_unregister' from incompatible pointer type [-Werror=incompatible-pointer-types]
    3477 |         bpf_probe_unregister(raw_tp->btp, raw_tp);
         |                                           ^~~~~~
         |                                           |
         |                                           struct bpf_raw_tp_link *
   In file included from include/trace/syscall.h:7,
                    from include/linux/syscalls.h:93,
                    from kernel/bpf/syscall.c:11:
   include/linux/trace_events.h:798:88: note: expected 'struct bpf_prog *' but argument is of type 'struct bpf_raw_tp_link *'
     798 | static inline int bpf_probe_unregister(struct bpf_raw_event_map *btp, struct bpf_prog *p)
         |                                                                       ~~~~~~~~~~~~~~~~~^
   kernel/bpf/syscall.c: In function 'bpf_raw_tp_link_attach':
>> kernel/bpf/syscall.c:3831:45: error: passing argument 2 of 'bpf_probe_register' from incompatible pointer type [-Werror=incompatible-pointer-types]
    3831 |         err = bpf_probe_register(link->btp, link);
         |                                             ^~~~
         |                                             |
         |                                             struct bpf_raw_tp_link *
   include/linux/trace_events.h:794:86: note: expected 'struct bpf_prog *' but argument is of type 'struct bpf_raw_tp_link *'
     794 | static inline int bpf_probe_register(struct bpf_raw_event_map *btp, struct bpf_prog *p)
         |                                                                     ~~~~~~~~~~~~~~~~~^
   cc1: some warnings being treated as errors


vim +/bpf_probe_unregister +3477 kernel/bpf/syscall.c

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
