Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EECFC3542F4;
	Fri, 27 Mar 2026 04:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774585132; cv=none; b=fwM7q58j59ChGl69POulcdJhB0nZ03NlPOCQlWrrvkjp8GzgSktXPlju2giwpXAOt2N/JQlvvkE40P5P5a4nYEWaVryvZS2KC5N/jIsJGqoDI6QWQzzPo6MJBKGH8sGMJbukEiy/PoGlg5MHlPhgi7K7GW0G0mvCnxnUA0/GmT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774585132; c=relaxed/simple;
	bh=2ERgDbodP9pcw0lcX9lf9Npl/24/+cJ1rqbdLBC4gxg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D3kqHeFrE8k4fbkzsg4x5U9vYKRmpTaLSEvt8YOJGrCxNhLU6peZa9uXuDbcti6Cvk2hy59jPwaf7SGQ0XXRWRsyH2d40up3WslnLwx/WE/B01U68ocvVBkRk8s8572toXGAts5HpDl0OfuB+U2zELFjMLrvQAqfgyoSezm1wlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Xv0ZlFdw; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Xv0ZlFdw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774585130; x=1806121130;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2ERgDbodP9pcw0lcX9lf9Npl/24/+cJ1rqbdLBC4gxg=;
  b=Xv0ZlFdw49fX78/XlkXWJODh01N6jvE8iOi+Do8kobEKQnS+GyBzEg9A
   jcOGl/bXtEYzu/xpuXkKpnCzDKu4LsVl4D78CYtpQ1CfvVWuSgOC8JRol
   Pxq5zzE0hHcqEduYSY1yzWr7dP7uJIncqSu+hqfULP1hvzK2hmXfI02+H
   Mg2vQXRC56hSQpeHGBFJFDGcED9YFzsiULs2RyhiWcPo/fdoBMup6BK00
   +3HDq/FfBRQX9p9hwVGQd6cwh/CPG0Y4EjTtPlOl7azlohWJ4CMvoLcrK
   eUd6w2xPvqE2TzgZjpWyuGSR3/gl1jvgcZNjFzN7xVIrzSuFpDYXUHh/5
   A==;
X-CSE-ConnectionGUID: edEnyeE4QsaAm1p/XR47ng==
X-CSE-MsgGUID: dX9Z9CiHQ7+5uri7X1SFlg==
X-IronPort-AV: E=McAfee;i="6800,10657,11741"; a="75559742"
X-IronPort-AV: E=Sophos;i="6.23,143,1770624000"; 
   d="scan'208";a="75559742"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2026 21:18:50 -0700
X-CSE-ConnectionGUID: RZ3TBEvzTzGiLzTYPNdT1g==
X-CSE-MsgGUID: aJpZXE+aQO+v9m8N7vmwVQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,143,1770624000"; 
   d="scan'208";a="220349608"
Received: from lkp-server01.sh.intel.com (HELO 3905d212be1b) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 26 Mar 2026 21:18:46 -0700
Received: from kbuild by 3905d212be1b with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1w5yeh-000000009lV-2v2R;
	Fri, 27 Mar 2026 04:18:43 +0000
Date: Fri, 27 Mar 2026 12:18:41 +0800
From: kernel test robot <lkp@intel.com>
To: Jiri Olsa <jolsa@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
	Menglong Dong <menglong8.dong@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCHv4 bpf-next 09/25] bpf: Add
 bpf_trampoline_multi_attach/detach functions
Message-ID: <202603271242.rKGaiSYu-lkp@intel.com>
References: <20260324081846.2334094-10-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260324081846.2334094-10-jolsa@kernel.org>

Hi Jiri,

kernel test robot noticed the following build warnings:

[auto build test WARNING on bpf-next/master]

url:    https://github.com/intel-lab-lkp/linux/commits/Jiri-Olsa/ftrace-Add-ftrace_hash_count-function/20260326-101836
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
patch link:    https://lore.kernel.org/r/20260324081846.2334094-10-jolsa%40kernel.org
patch subject: [PATCHv4 bpf-next 09/25] bpf: Add bpf_trampoline_multi_attach/detach functions
config: x86_64-randconfig-015-20260327 (https://download.01.org/0day-ci/archive/20260327/202603271242.rKGaiSYu-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260327/202603271242.rKGaiSYu-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603271242.rKGaiSYu-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> kernel/bpf/trampoline.c:100:13: warning: 'trampoline_unlock_all' defined but not used [-Wunused-function]
     100 | static void trampoline_unlock_all(void)
         |             ^~~~~~~~~~~~~~~~~~~~~
>> kernel/bpf/trampoline.c:92:13: warning: 'trampoline_lock_all' defined but not used [-Wunused-function]
      92 | static void trampoline_lock_all(void)
         |             ^~~~~~~~~~~~~~~~~~~


vim +/trampoline_unlock_all +100 kernel/bpf/trampoline.c

    91	
  > 92	static void trampoline_lock_all(void)
    93	{
    94		int i;
    95	
    96		for (i = 0; i < TRAMPOLINE_LOCKS_TABLE_SIZE; i++)
    97			mutex_lock(&trampoline_locks[i].mutex);
    98	}
    99	
 > 100	static void trampoline_unlock_all(void)
   101	{
   102		int i;
   103	
   104		for (i = 0; i < TRAMPOLINE_LOCKS_TABLE_SIZE; i++)
   105			mutex_unlock(&trampoline_locks[i].mutex);
   106	}
   107	#else
   108	static struct bpf_trampoline *direct_ops_ip_lookup(struct ftrace_ops *ops, unsigned long ip)
   109	{
   110		return ops->private;
   111	}
   112	#endif /* CONFIG_HAVE_SINGLE_FTRACE_DIRECT_OPS */
   113	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
