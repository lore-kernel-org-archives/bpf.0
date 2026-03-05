Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CBA830FC26
	for <bpf@vger.kernel.org>; Thu,  5 Mar 2026 08:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772700947; cv=none; b=oiAB3WSJj/q8p+Dw5Uwd4dObGqX7femvH+N4NkS5nNPBe5O15KJhgruPwxA3eI8mp65jsM2ocqzSOu64A++iJaxHiKAltpD5t8ifAELu3ag4b76fO9Dl+RvEZBFzDDSf8LKAy5mCqwFTrYYJvwc/7Lwy5qcC/EXrN/NPc8Xe2HY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772700947; c=relaxed/simple;
	bh=KvQC244mb8gIOMZVdMYn6Tn//fuIPSbkRxl6PK+JLEE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e1amVeIjWi9wfaHGKzYr5exTWfWaUzMkJUEfC03oDrAKMEeZ1s5N+49iuhNcuZcKurayDimXJEdxm9TBH+RkkdRkbASvATKiO4ATWbuUNkBAMdXg7VeqwDmtOmsaabN6KobuYQs5KrS8wbK2MFYpcvkq1cKT8YWyXTM64n2ZcVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DhdUfREu; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DhdUfREu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772700946; x=1804236946;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=KvQC244mb8gIOMZVdMYn6Tn//fuIPSbkRxl6PK+JLEE=;
  b=DhdUfREu/aO6O28Pa6pncTt6z3FTums6AdoEMk42w/rxQlACohcfL2Sq
   +fUP29WqcvcBdNEtZqH7u8g2/A5N7JLh2CzTpm7tWa0OqPZT6DOCFXSCF
   zKgriYJ1pL2IyyCHDHouPclo9bQJcbufYAwhrOWwTLVpv7Q5ms5fj+fDx
   tN85xhDtyuUZPydDYL8QyfGvmxqxlLNOFfkQhDONZJ1e80wDUhvgrBIEZ
   y9U0FYZ2RBHt3MRfLUh7ywfloEc6eHA5kQPRtM5jB9T1ezOCxQvns+hRz
   Bu64eKOaKj7fZsFQMJCsi0qjhpYwskmybmj4v9OPis3up/FzXNpPSm322
   A==;
X-CSE-ConnectionGUID: nES5l+SpQgKj1vmPzBvSbA==
X-CSE-MsgGUID: rIHLjc4ZTqaDPRIsjfLSwg==
X-IronPort-AV: E=McAfee;i="6800,10657,11719"; a="91352582"
X-IronPort-AV: E=Sophos;i="6.23,325,1770624000"; 
   d="scan'208";a="91352582"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2026 00:55:45 -0800
X-CSE-ConnectionGUID: 1EdtUNBrT4WZ/Fc4ol0MVQ==
X-CSE-MsgGUID: FTFjEgtDRxmV4ldGZ2gw4Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,325,1770624000"; 
   d="scan'208";a="217850906"
Received: from lkp-server01.sh.intel.com (HELO cadc4577a874) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 05 Mar 2026 00:55:42 -0800
Received: from kbuild by cadc4577a874 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vy4Ud-000000000N8-0WGA;
	Thu, 05 Mar 2026 08:55:39 +0000
Date: Thu, 5 Mar 2026 16:55:38 +0800
From: kernel test robot <lkp@intel.com>
To: Puranjay Mohan <puranjay@kernel.org>, bpf@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Puranjay Mohan <puranjay@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, kernel-team@meta.com
Subject: Re: [PATCH bpf 1/3] bpf: fix mm lifecycle in open-coded task_vma
 iterator
Message-ID: <202603051628.H3HNsDUG-lkp@intel.com>
References: <20260304142026.1443666-2-puranjay@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260304142026.1443666-2-puranjay@kernel.org>

Hi Puranjay,

kernel test robot noticed the following build errors:

[auto build test ERROR on 3ebc98c1ae7efda949a015990280a097f4a5453a]

url:    https://github.com/intel-lab-lkp/linux/commits/Puranjay-Mohan/bpf-fix-mm-lifecycle-in-open-coded-task_vma-iterator/20260304-224301
base:   3ebc98c1ae7efda949a015990280a097f4a5453a
patch link:    https://lore.kernel.org/r/20260304142026.1443666-2-puranjay%40kernel.org
patch subject: [PATCH bpf 1/3] bpf: fix mm lifecycle in open-coded task_vma iterator
config: arm-randconfig-003-20260305 (https://download.01.org/0day-ci/archive/20260305/202603051628.H3HNsDUG-lkp@intel.com/config)
compiler: clang version 23.0.0git (https://github.com/llvm/llvm-project 9a109fbb6e184ec9bcce10615949f598f4c974a9)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260305/202603051628.H3HNsDUG-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603051628.H3HNsDUG-lkp@intel.com/

All errors (new ones prefixed by >>):

>> kernel/bpf/task_iter.c:840:3: error: call to undeclared function 'mmput_async'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     840 |                 mmput_async(work->mm);
         |                 ^
   kernel/bpf/task_iter.c:848:3: error: call to undeclared function 'mmput_async'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     848 |                 mmput_async(mm);
         |                 ^
   2 errors generated.


vim +/mmput_async +840 kernel/bpf/task_iter.c

   833	
   834	static void do_bpf_iter_mmput(struct irq_work *entry)
   835	{
   836		struct bpf_iter_mmput_irq_work *work;
   837	
   838		work = container_of(entry, struct bpf_iter_mmput_irq_work, irq_work);
   839		if (work->mm) {
 > 840			mmput_async(work->mm);
   841			work->mm = NULL;
   842		}
   843	}
   844	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
