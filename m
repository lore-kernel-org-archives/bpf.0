Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C59F32E68D;
	Sat, 14 Mar 2026 17:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773507992; cv=none; b=RuQYrM5fGybCkTxUEg00ZsYgSjON7+PAKwKoNQOoA5TNZBuee9YeylXq9t1YXzShhR/7ffj4Qnbf291h/Rz6x4oNpVS78vdAvKgT7WT+ywpD+AtqhqiUkTrvSYuRe5itYc+3Wg8ra+eG728AunwkAVCQbameSIj5EbenNwIF5NM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773507992; c=relaxed/simple;
	bh=BP6PDAwL7ZQIFhbNuWPztuxpeFKM2OWgbd3nAKkdShI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XX+x6pgS8VQYXoaN04lXOYyVX9t11jXLdtonSiAUfD3z4W3SxIjTvlFKRLIn9ONWmya5a07LCq74D8TVgrya6WBFPy0xp0+gS0BVtolkRRqmkkD4zBIMVVao0cYaNeUtx93Tmrl+B7EJr9Bb2FMXCiyaFieOVrJVfl/bGvDtnQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Uwt4ZS7G; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Uwt4ZS7G"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773507990; x=1805043990;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=BP6PDAwL7ZQIFhbNuWPztuxpeFKM2OWgbd3nAKkdShI=;
  b=Uwt4ZS7GhduaC5gYc1F+SynASRWlHe7ZPq1GEdSkbjtNMpTd5Y4k5PTO
   TlYT2+gZLTrCa2QqAbGPUwoEBCd62kX3y1+ynnihsBwvPtE4wOHlqwk1c
   ObD6D4Bqxp/V9p5bRRaLM/40eTJWBrvz56qMbLPEjzSVM+Nmq2Nj9hka9
   aHsf+fUHbhcmO1rtIOWzguHmiiLBd8sXM3E+bWiEvLUTod06tPseXSSWs
   buZs16cMufUjRejOzkOf9MrU/wW5pki0BkDTwI2NFplyJaN4S/bgimIR1
   fePhJAXG34M2bIBp7wQAAErelOgGjlmVOaMMD482Laa/J+ygvLjnVQdKz
   Q==;
X-CSE-ConnectionGUID: Mb8+q8B9TRqg1JH3RhtXCA==
X-CSE-MsgGUID: AHUvEtNuRRWFKFIinb99XQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11729"; a="74291606"
X-IronPort-AV: E=Sophos;i="6.23,119,1770624000"; 
   d="scan'208";a="74291606"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2026 10:06:29 -0700
X-CSE-ConnectionGUID: S7Qzg7o5QjeaYBCY2orMyA==
X-CSE-MsgGUID: 1B0hQ5hhSyOavx3FZxVKcw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,119,1770624000"; 
   d="scan'208";a="221543533"
Received: from igk-lkp-server01.igk.intel.com (HELO 9958d990ccf2) ([10.211.93.152])
  by orviesa008.jf.intel.com with ESMTP; 14 Mar 2026 10:06:23 -0700
Received: from kbuild by 9958d990ccf2 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1w1SRQ-000000003pJ-4Brw;
	Sat, 14 Mar 2026 17:06:21 +0000
Date: Sat, 14 Mar 2026 18:05:40 +0100
From: kernel test robot <lkp@intel.com>
To: Levi Zim via B4 Relay <devnull+rsworktech.outlook.com@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>
Cc: oe-kbuild-all@lists.linux.dev, Amery Hung <ameryhung@gmail.com>,
	linux-riscv@lists.infradead.org, stable@vger.kernel.org,
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev, Levi Zim <rsworktech@outlook.com>
Subject: Re: [PATCH bpf] bpf: do not use kmalloc_nolock when
 !HAVE_CMPXCHG_DOUBLE
Message-ID: <202603141857.sLJ0vJoa-lkp@intel.com>
References: <20260314-bpf-kmalloc-nolock-v1-1-24abf3f75a9f@outlook.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260314-bpf-kmalloc-nolock-v1-1-24abf3f75a9f@outlook.com>

Hi Levi,

kernel test robot noticed the following build warnings:

[auto build test WARNING on e06e6b8001233241eb5b2e2791162f0585f50f4b]

url:    https://github.com/intel-lab-lkp/linux/commits/Levi-Zim-via-B4-Relay/bpf-do-not-use-kmalloc_nolock-when-HAVE_CMPXCHG_DOUBLE/20260314-195705
base:   e06e6b8001233241eb5b2e2791162f0585f50f4b
patch link:    https://lore.kernel.org/r/20260314-bpf-kmalloc-nolock-v1-1-24abf3f75a9f%40outlook.com
patch subject: [PATCH bpf] bpf: do not use kmalloc_nolock when !HAVE_CMPXCHG_DOUBLE
config: x86_64-rhel-9.4 (https://download.01.org/0day-ci/archive/20260314/202603141857.sLJ0vJoa-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260314/202603141857.sLJ0vJoa-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603141857.sLJ0vJoa-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from include/net/bpf_sk_storage.h:15,
                    from net/core/sock.c:141:
>> include/linux/bpf_local_storage.h:22:19: warning: 'KMALLOC_NOLOCK_SUPPORTED' defined but not used [-Wunused-const-variable=]
      22 | static const bool KMALLOC_NOLOCK_SUPPORTED = IS_ENABLED(CONFIG_HAVE_CMPXCHG_DOUBLE);
         |                   ^~~~~~~~~~~~~~~~~~~~~~~~


vim +/KMALLOC_NOLOCK_SUPPORTED +22 include/linux/bpf_local_storage.h

    21	
  > 22	static const bool KMALLOC_NOLOCK_SUPPORTED = IS_ENABLED(CONFIG_HAVE_CMPXCHG_DOUBLE);
    23	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
