Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B2081D5151;
	Sat, 11 Apr 2026 10:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775904386; cv=none; b=bHI8X+OGOjUY4tgzj28zg/1IYcn6xNZR9jxkHRk4h5+SihdUMV8p3JybJ9EGSdLZGOX3Po2BG9DaGQhVZYc/oR0DF+KI6rjm2i1JwR/1Lef7oXb/YsNlYcsYHqWjPUt0sMtpcbE1lX5Mn8wTVayhTyzI5jWtG2Ln82xHsK2Tdow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775904386; c=relaxed/simple;
	bh=yfup+R+Hy7kL/EVQORGNoDyl5Kw0LcEhlJSNpUE5f5M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ozdjAdFb583GcnY0FqrNdUIPBqf/XtBaJAJNzqwZuWoGwuGxdwhWvxQPzv5Z2e5ox9M2ZTs7r5CbgvB8z+skNe7BWUhVpHMsiJ/KffHv491hxiiVRFyD48TaZ6tG02tw76U4glE3gJPETZsb2sw55gpcj/yQZ4cC/eXqdwb92HQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WR/5Rn4v; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WR/5Rn4v"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775904385; x=1807440385;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=yfup+R+Hy7kL/EVQORGNoDyl5Kw0LcEhlJSNpUE5f5M=;
  b=WR/5Rn4vNkRd5Vk8IGXkJ5Kg1I2ZQWFByKX4BX2NlmUQgQ6MkV1bX6x8
   7gTjXXUVLKWqLrez1csoToJ2J9Ksm6GblipAIVk7vQJHPywFf6JCntgPv
   S56sSqs3nJ9WDpkoVnZDruwBfmUSQ3D3AnJW9jIFORdiuWcdAvCtE+Eml
   WseXFFRvvIS7fx17Rcxd7XYlA0/PltEuTKetgUWEVvaDmWJ2bfyd9sRNb
   Jev3wu2j7t8Xgh4xS0hlfe2+T6L62MHgcJGXPggSoiz52msNgEP1rHvrF
   r4jnLaOs3GBYyN/TbxnutinGcq8WMrGrmGz+up6dKlRIv/whfx3VD2HlV
   Q==;
X-CSE-ConnectionGUID: Q9L5+wyoRGukWcWT0Caf4A==
X-CSE-MsgGUID: XSL1lhGSTF+LeZ4/u3EPJQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11755"; a="88297090"
X-IronPort-AV: E=Sophos;i="6.23,173,1770624000"; 
   d="scan'208";a="88297090"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2026 03:46:24 -0700
X-CSE-ConnectionGUID: cSlGkiyNTvmFeLPPAlNDLg==
X-CSE-MsgGUID: MRnAW5IERXaHc+Puwf/vIw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,173,1770624000"; 
   d="scan'208";a="226163658"
Received: from lkp-server01.sh.intel.com (HELO 3eaaf1a74b89) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 11 Apr 2026 03:46:21 -0700
Received: from kbuild by 3eaaf1a74b89 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wBVr0-0000000015B-3f1P;
	Sat, 11 Apr 2026 10:46:18 +0000
Date: Sat, 11 Apr 2026 18:45:39 +0800
From: kernel test robot <lkp@intel.com>
To: Ihor Solodrai <ihor.solodrai@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>, Song Liu <song@kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Puranjay Mohan <puranjay@kernel.org>,
	Shakeel Butt <shakeel.butt@linux.dev>, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH bpf v1] bpf: Avoid faultable build ID reads under mm locks
Message-ID: <202604111812.ms5JQMgD-lkp@intel.com>
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
config: i386-buildonly-randconfig-002-20260411 (https://download.01.org/0day-ci/archive/20260411/202604111812.ms5JQMgD-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260411/202604111812.ms5JQMgD-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202604111812.ms5JQMgD-lkp@intel.com/

All errors (new ones prefixed by >>):

>> kernel/bpf/stackmap.c:172:35: error: call to undeclared function 'vma_start_read_locked'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     172 |         if (range_in_vma(vma, ip, ip) && vma_start_read_locked(vma))
         |                                          ^
   kernel/bpf/stackmap.c:172:35: note: did you mean 'vma_assert_write_locked'?
   include/linux/mmap_lock.h:507:20: note: 'vma_assert_write_locked' declared here
     507 | static inline void vma_assert_write_locked(struct vm_area_struct *vma)
         |                    ^
   1 error generated.


vim +/vma_start_read_locked +172 kernel/bpf/stackmap.c

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
