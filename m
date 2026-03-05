Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B13539C657
	for <bpf@vger.kernel.org>; Thu,  5 Mar 2026 11:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772711936; cv=none; b=ucLZJgIMKG3FBS1xL1U8USGE0fR63Pfaqk9qCm1YUOK3kd/yAvPIHm8Vo7Ov1uWMvR59koADDpmZC0eUxOb9LX9dTwlxGEr1WoKxBHq7BjhBV5RY/Y81TuBoo6vTkW/uhERMAKLO1jyhLOd2TW26lXCvplwq6fq1NrIn4iNSGQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772711936; c=relaxed/simple;
	bh=WWRGI+KbGpsRJSAmm6vXGaQ/nIg6dH18FaRze5eZ3EM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zv4ewtOxo8A6y9sHqPfd5mpU2ss5qha+62RzBgtVqUNiPW8Pnek8eXC1o7bsB9yZglbvJv3XxijNO9EoNDhI2RZmv1Lg0LTyRlphSRtirLgg1jWpyRXU1Com3cdWbftXlWuFHzYW4smx9Et2k4TW5zvBsxQpVbTmmH/zyvtpwpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FhYT4ger; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FhYT4ger"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772711935; x=1804247935;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=WWRGI+KbGpsRJSAmm6vXGaQ/nIg6dH18FaRze5eZ3EM=;
  b=FhYT4gerROB5RuxYX/Fw2hdZVaJ5zggldI4Fp8nDfEwPEd9calliDL3X
   O9R4CoepgY1wVDGdMXxmzA4/HSqdVNGEngmcM3zqVw2JwwBpbJvj/t9Zn
   OBKHiwY+A9lLOzLGJHZO8bA+TsNUMAwJMC2b2u7g1Iv3+eo2aSa0YxjNj
   n4SjRSeVMQo7LYoEwtb6NZNqMYK/pSgEBM3c6RffanosciAUCQl0zH/eX
   0PMaenCvVrH+CNirhNcJvAN2fjfC8J4WbuFBy9MrmDmXMP74B9fZEZhCt
   cYhTMVDT6vnBfnJ66f0guwUvoeD2DuQv7xYjBaPCZcMW+EMDgYDfcx/Hn
   g==;
X-CSE-ConnectionGUID: 04NILDjfR7eSZjV1mZOEWg==
X-CSE-MsgGUID: xcx9fdJgREOdcQfrM0O38g==
X-IronPort-AV: E=McAfee;i="6800,10657,11719"; a="84429984"
X-IronPort-AV: E=Sophos;i="6.23,102,1770624000"; 
   d="scan'208";a="84429984"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2026 03:58:54 -0800
X-CSE-ConnectionGUID: V48aCbpvTxW94fjtuqflcg==
X-CSE-MsgGUID: ou9Oq/kHRZqVlZmilx+4IQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,102,1770624000"; 
   d="scan'208";a="215475899"
Received: from lkp-server01.sh.intel.com (HELO cadc4577a874) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 05 Mar 2026 03:58:52 -0800
Received: from kbuild by cadc4577a874 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vy7Lt-000000000Ys-34tS;
	Thu, 05 Mar 2026 11:58:49 +0000
Date: Thu, 5 Mar 2026 19:58:18 +0800
From: kernel test robot <lkp@intel.com>
To: Puranjay Mohan <puranjay@kernel.org>, bpf@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Puranjay Mohan <puranjay@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, kernel-team@meta.com
Subject: Re: [PATCH bpf 1/3] bpf: fix mm lifecycle in open-coded task_vma
 iterator
Message-ID: <202603051901.tplxkNgS-lkp@intel.com>
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
config: sh-allmodconfig (https://download.01.org/0day-ci/archive/20260305/202603051901.tplxkNgS-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 15.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260305/202603051901.tplxkNgS-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603051901.tplxkNgS-lkp@intel.com/

All errors (new ones prefixed by >>):

   kernel/bpf/task_iter.c: In function 'do_bpf_iter_mmput':
>> kernel/bpf/task_iter.c:840:17: error: implicit declaration of function 'mmput_async' [-Wimplicit-function-declaration]
     840 |                 mmput_async(work->mm);
         |                 ^~~~~~~~~~~


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
