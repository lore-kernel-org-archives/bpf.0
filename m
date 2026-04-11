Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF0D5334C05;
	Sat, 11 Apr 2026 10:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775903666; cv=none; b=i2g0YeWeEc2C0TL/JXfyBm+hE8fp43skvgVjBhxZsA88VB90mZWXrg33nYzSHJllqn+yayIhfY+mDkjWtZYdDQ8DrIidEtiuRp4wijEIsMI6QeUZ2R+3hx+wAbWPWeVEpLfUmFLMGcj++mDQYbvg04mba25BBVKc32B/1Ml6t5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775903666; c=relaxed/simple;
	bh=6gRFbouoYWoY5APyzgMyhgHofBb853d6SD+Ng9j3I5I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=urfY4Q4wtjbxGA740Lc9FxD8W05ymZbLMpeXwesrvXfObH+FnUzHdhb8dmA6zxOjFyIylQxNqAhTnC0Ybwf01H/l5QhqQg2Q6BMx/1RBtvgGgE6j4keogcGCuK4/LJJ4RDqWrErgHm8qG9UPyvp8mkqUVqYLQcgWuTWLgtWE7z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TJd9W8R5; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TJd9W8R5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775903664; x=1807439664;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6gRFbouoYWoY5APyzgMyhgHofBb853d6SD+Ng9j3I5I=;
  b=TJd9W8R5b2uQd7oSRi6EMNFIC7Z0+5suDdQt2H/GVldp3YroaTY4Gza4
   L5JssQ3K+kOIjE97lRtuIY6ATrcSszk68LQBNtryDBVTO1CE8UwMiiiyC
   wdrHv7KfO/m7Q/l22XD7wf8mBSPJOYDo8PrtD2tRuJFfEmbm71sXkkYSH
   dfefvZ1jXpOghGtkCLhb671pJtVzDXXZLonkqt0gZFe9RSB62mvEoikFR
   o94qs6rNmUGmLzhnzEPolY7+8FK19valFLHVfUoiD4pkJHJV45VcY8Bjk
   OPuLR7xe2Tmv1jO3tn96L85uOKhSNWt9EfenEVgApG+YCY/5RgvSu5kdJ
   w==;
X-CSE-ConnectionGUID: NtZu9fS+TH+pZgjB9tQZMQ==
X-CSE-MsgGUID: Xq/eUcEOQw2+Kccc5e0P6A==
X-IronPort-AV: E=McAfee;i="6800,10657,11755"; a="76869293"
X-IronPort-AV: E=Sophos;i="6.23,173,1770624000"; 
   d="scan'208";a="76869293"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2026 03:34:23 -0700
X-CSE-ConnectionGUID: eTS0ezy1Tu20BIZ68pMAGg==
X-CSE-MsgGUID: PZaI9jPURFuYsHr8TQK88Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,173,1770624000"; 
   d="scan'208";a="229589669"
Received: from lkp-server01.sh.intel.com (HELO 3eaaf1a74b89) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 11 Apr 2026 03:34:20 -0700
Received: from kbuild by 3eaaf1a74b89 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wBVfO-0000000014d-1Q7K;
	Sat, 11 Apr 2026 10:34:18 +0000
Date: Sat, 11 Apr 2026 18:34:04 +0800
From: kernel test robot <lkp@intel.com>
To: Ihor Solodrai <ihor.solodrai@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>, Song Liu <song@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, Puranjay Mohan <puranjay@kernel.org>,
	Shakeel Butt <shakeel.butt@linux.dev>, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH bpf v1] bpf: Avoid faultable build ID reads under mm locks
Message-ID: <202604111854.PygL2SVE-lkp@intel.com>
References: <20260407223003.720428-1-ihor.solodrai@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260407223003.720428-1-ihor.solodrai@linux.dev>

Hi Ihor,

kernel test robot noticed the following build errors:

[auto build test ERROR on bpf/master]

url:    https://github.com/intel-lab-lkp/linux/commits/Ihor-Solodrai/bpf-Avoid-faultable-build-ID-reads-under-mm-locks/20260411-130435
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git master
patch link:    https://lore.kernel.org/r/20260407223003.720428-1-ihor.solodrai%40linux.dev
patch subject: [PATCH bpf v1] bpf: Avoid faultable build ID reads under mm locks
config: x86_64-buildonly-randconfig-003-20260411 (https://download.01.org/0day-ci/archive/20260411/202604111854.PygL2SVE-lkp@intel.com/config)
compiler: gcc-13 (Debian 13.3.0-16) 13.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260411/202604111854.PygL2SVE-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202604111854.PygL2SVE-lkp@intel.com/

All errors (new ones prefixed by >>):

   kernel/bpf/stackmap.c: In function 'stack_map_lock_vma':
>> kernel/bpf/stackmap.c:172:42: error: implicit declaration of function 'vma_start_read_locked'; did you mean 'vma_assert_write_locked'? [-Werror=implicit-function-declaration]
     172 |         if (range_in_vma(vma, ip, ip) && vma_start_read_locked(vma))
         |                                          ^~~~~~~~~~~~~~~~~~~~~
         |                                          vma_assert_write_locked
   cc1: some warnings being treated as errors


vim +172 kernel/bpf/stackmap.c

   161	
   162	static struct vm_area_struct *stack_map_lock_vma(struct mm_struct *mm, unsigned long ip)
   163	{
   164		struct vm_area_struct *vma;
   165	
   166		vma = lock_vma_under_rcu(mm, ip);
   167		if (vma)
   168			return vma;
   169	
   170		mmap_read_lock(mm);
   171		vma = find_vma(mm, ip);
 > 172		if (range_in_vma(vma, ip, ip) && vma_start_read_locked(vma))
   173			goto out;
   174	
   175		vma = NULL;
   176	out:
   177		mmap_read_unlock(mm);
   178	
   179		return vma;
   180	}
   181	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
