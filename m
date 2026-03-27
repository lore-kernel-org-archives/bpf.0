Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D63F35CB9B
	for <bpf@vger.kernel.org>; Fri, 27 Mar 2026 11:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774611335; cv=none; b=ik6EDFw28Ua9BoX73SLT4cOkEtTVSSD0983ttT72w+MEDPGDZ4z2Nwu2o4iolAe3ffZInajL/bvVPHzmlJ5PD7z/TX0b6N0e2Tk07hZR8G6p3gCq/UnFMheTyumH3SLhAgO6E6TI/Hja1pOqsZ7fh5UmwxQxlCQ/8SsxEDpMYcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774611335; c=relaxed/simple;
	bh=PpRB8vSChJA7l38bu5fh541HmHcq/Grnif2xKGtymuU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NZL4NZ8evzfeiccWZ2JM9QsAVRtdsvRnhcIiM0hOHtozbQL6JDY29OQ7IdSJ0+tiN8dtIAcVP1AmbjAuFRVYCA0kKs/IM3QFl2Hgahqqza8XDrBL/9hw5U7M4IW3vSeouTCOoy2GNAzsAeMJgUlF/ftl5fVkpF9bT8llKDQYThY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Tw00jNHZ; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Tw00jNHZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774611333; x=1806147333;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=PpRB8vSChJA7l38bu5fh541HmHcq/Grnif2xKGtymuU=;
  b=Tw00jNHZRpQITEh2sQvp399vOOW2ffnTSEspOgITdym0WyBUQ+Xuojir
   AFfGl1yJ8Eff3U94xcxiblWRz/EBdTf+cA/5Cpmh5WxSCsBCwEdxcfKvl
   N2n0A6zsVBBJVGFFU66zUEECggT+GTLONrgLk8EhPIcgeMMCr8Oo5brUb
   6Y6HTUYwO+ubvE0oc3urL2IZTIJ0N5Jt+cc2a1e3GQ+VT1UKIazVWaVRg
   d5jpJyhukLr81aIr1p0q7OZWF2qdAVf4h3CNkGBXUyxFc+F/VA3o9dxB3
   P6ySDKnmBKVqVeDqRVCDnIi91Ciyh7pFHDxIm60L7i8dVhQ12jsv0whjF
   Q==;
X-CSE-ConnectionGUID: bUh7bW9aT1KioJi2ppWcHQ==
X-CSE-MsgGUID: l+FjAM18QHmWMUVf9AOyuQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11741"; a="101141913"
X-IronPort-AV: E=Sophos;i="6.23,144,1770624000"; 
   d="scan'208";a="101141913"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2026 04:35:32 -0700
X-CSE-ConnectionGUID: +sKy+qFWT7O9giwWyupOlg==
X-CSE-MsgGUID: JKh+EASoQk+TpmGEknZJFA==
X-ExtLoop1: 1
Received: from lkp-server01.sh.intel.com (HELO 3905d212be1b) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 27 Mar 2026 04:35:29 -0700
Received: from kbuild by 3905d212be1b with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1w65TK-00000000ADt-00jr;
	Fri, 27 Mar 2026 11:35:26 +0000
Date: Fri, 27 Mar 2026 19:35:22 +0800
From: kernel test robot <lkp@intel.com>
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, bpf@vger.kernel.org,
	ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
	kafai@meta.com, kernel-team@meta.com, eddyz87@gmail.com,
	memxor@gmail.com
Cc: oe-kbuild-all@lists.linux.dev, Mykyta Yatsenko <yatsenko@meta.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH bpf-next v6 3/6] bpf: Add sleepable support for classic
 tracepoint programs
Message-ID: <202603271953.AkWFtw6W-lkp@intel.com>
References: <20260325-sleepable_tracepoints-v6-3-2b182dacea13@meta.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260325-sleepable_tracepoints-v6-3-2b182dacea13@meta.com>

Hi Mykyta,

kernel test robot noticed the following build errors:

[auto build test ERROR on 6c8e1a9eee0fec802b542dadf768c30c2a183b3c]

url:    https://github.com/intel-lab-lkp/linux/commits/Mykyta-Yatsenko/bpf-Add-sleepable-support-for-raw-tracepoint-programs/20260327-132324
base:   6c8e1a9eee0fec802b542dadf768c30c2a183b3c
patch link:    https://lore.kernel.org/r/20260325-sleepable_tracepoints-v6-3-2b182dacea13%40meta.com
patch subject: [PATCH bpf-next v6 3/6] bpf: Add sleepable support for classic tracepoint programs
config: x86_64-randconfig-103-20260327 (https://download.01.org/0day-ci/archive/20260327/202603271953.AkWFtw6W-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260327/202603271953.AkWFtw6W-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603271953.AkWFtw6W-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from include/linux/security.h:35,
                    from include/linux/perf_event.h:53,
                    from include/linux/trace_events.h:10,
                    from include/trace/syscall.h:7,
                    from include/linux/syscalls.h:95,
                    from include/linux/syscalls_api.h:1,
                    from kernel/sched/sched.h:64,
                    from kernel/sched/rq-offsets.c:5:
>> include/linux/bpf.h:3363:20: error: static declaration of 'bpf_prog_inc_misses_counter' follows non-static declaration
    3363 | static inline void bpf_prog_inc_misses_counter(struct bpf_prog *prog)
         |                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/bpf.h:2489:14: note: previous declaration of 'bpf_prog_inc_misses_counter' with type 'void(struct bpf_prog *)'
    2489 | void notrace bpf_prog_inc_misses_counter(struct bpf_prog *prog);
         |              ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   make[3]: *** [scripts/Makefile.build:184: kernel/sched/rq-offsets.s] Error 1
   make[3]: Target 'prepare' not remade because of errors.
   make[2]: *** [Makefile:1333: prepare0] Error 2
   make[2]: Target 'prepare' not remade because of errors.
   make[1]: *** [Makefile:248: __sub-make] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:248: __sub-make] Error 2
   make: Target 'prepare' not remade because of errors.


vim +/bpf_prog_inc_misses_counter +3363 include/linux/bpf.h

05b24ff9b2cfab Jiri Olsa     2022-09-16  3362  
05b24ff9b2cfab Jiri Olsa     2022-09-16 @3363  static inline void bpf_prog_inc_misses_counter(struct bpf_prog *prog)
05b24ff9b2cfab Jiri Olsa     2022-09-16  3364  {
05b24ff9b2cfab Jiri Olsa     2022-09-16  3365  }
c4bcfb38a95edb Yonghong Song 2022-10-25  3366  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
