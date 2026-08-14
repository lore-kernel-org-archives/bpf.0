Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAAD4299922;
	Fri, 14 Aug 2026 06:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786687548; cv=none; b=q/Cs3Yp0QmoDAmQEKLVY1Jymfi8kr9mCf15E0GEC30DHEpaCuKCgk3F4gpmNRFe3zEEsXXi3eFJS9E3+HSpNmGXo38aLcZ3LklH4hUmxVs61QyWuIFluFgZArhrmQUE6OrmqhrMC4m2TNEepnrGlHTtlHZ2ILFDgvs0Nq4CwhIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786687548; c=relaxed/simple;
	bh=bweWAuLimVobUQxKsEkztmQk/LOdMDq6E/NcelP8x+Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qFLm+E/0s8DVZ96XPkRrB4ouQFOJxM+0ZcncmsYXnELlW3Prl/nKQRq5Iy2pLWvaff10kPetrlrKwnf3ykceq0fxoEEueM7lCeID2UZ8mfQ099XZPcJrzciPfw4Ja76eH011KSTkbbQ910MK+8rsCMjVR7DAuHe+/THBOJjREFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EPblmWHd; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EPblmWHd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786687547; x=1818223547;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=bweWAuLimVobUQxKsEkztmQk/LOdMDq6E/NcelP8x+Y=;
  b=EPblmWHdU8rBZeMykyAwRVvrBN0ijIV20ezZk7tAyRf35eRiLiWZZBQg
   gdETFHnKNqDkb/fgUjFPi2Um5PbFv0tbpv+wZCfDHa5kfVjTnLqrsWAwi
   D+o+Y/xlOcWQr6AHnkyI8KIZI4Hacuxrn74e3vM0dV4Kk8g6eFjtLqDMc
   5ECNqDFKrVK/fUM7dMpUSFbuSnlBRgWWeaiFk3PqzbfH/rF6nyjy+nFQb
   Jipi+Tl+3NnEMKwZOlc8PUIMFsRTbJjxK+uzkHrqKQAQHVcxnf5VCMRGB
   v1hDeodLPlkBV9AjctMpSlgT+wL6ddeqAzAHqOctkRd4BTE0pfew13DsG
   w==;
X-CSE-ConnectionGUID: EP7oEPX7ShWSwxQeiydBVA==
X-CSE-MsgGUID: ToWjkbDIReqE9fHj96B5OA==
X-IronPort-AV: E=McAfee;i="6800,10657,11874"; a="87339967"
X-IronPort-AV: E=Sophos;i="6.25,222,1779174000"; 
   d="scan'208";a="87339967"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2026 23:05:47 -0700
X-CSE-ConnectionGUID: qQ/hPPo8S92uG4fZyRvFCA==
X-CSE-MsgGUID: CIq1YTc4RSaqH84efCjMnw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,222,1779174000"; 
   d="scan'208";a="267998779"
Received: from lkp-server01.sh.intel.com (HELO 6eda058d650d) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 13 Aug 2026 23:05:42 -0700
Received: from kbuild by 6eda058d650d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wul2x-00000000XzS-2dGK;
	Fri, 14 Aug 2026 06:05:39 +0000
Date: Fri, 14 Aug 2026 14:05:12 +0800
From: kernel test robot <lkp@intel.com>
To: Sanghyun Park <sanghyun.park.cnu@gmail.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Sanghyun Park <sanghyun.park.cnu@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Puranjay Mohan <puranjay@kernel.org>, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next v5] bpf: Fix use-after-free on mm_struct in
 bpf_find_vma()
Message-ID: <202608141429.e94YU9PI-lkp@intel.com>
References: <20260630023443.3026627-2-sanghyun.park.cnu@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260630023443.3026627-2-sanghyun.park.cnu@gmail.com>

Hi Sanghyun,

kernel test robot noticed the following build errors:

[auto build test ERROR on bpf-next/net]
[also build test ERROR on bpf/master linus/master v7.2-rc7]
[cannot apply to bpf-next/master next-20260812]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Sanghyun-Park/bpf-Fix-use-after-free-on-mm_struct-in-bpf_find_vma/20260813-193715
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git net
patch link:    https://lore.kernel.org/r/20260630023443.3026627-2-sanghyun.park.cnu%40gmail.com
patch subject: [PATCH bpf-next v5] bpf: Fix use-after-free on mm_struct in bpf_find_vma()
config: riscv-randconfig-002-20260814 (https://download.01.org/0day-ci/archive/20260814/202608141429.e94YU9PI-lkp@intel.com/config)
compiler: clang version 24.0.0git (https://github.com/llvm/llvm-project 844a18e753e822736c9805ab779144b647a2c186)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260814/202608141429.e94YU9PI-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202608141429.e94YU9PI-lkp@intel.com/

All errors (new ones prefixed by >>):

>> kernel/bpf/task_iter.c:1017:3: error: call to undeclared function 'bpf_iter_mmput_async'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
    1017 |                 bpf_iter_mmput_async(kit->data->mm);
         |                 ^
   1 error generated.


vim +/bpf_iter_mmput_async +1017 kernel/bpf/task_iter.c

4ac454682158473 Dave Marchevsky 2023-10-13  1009  
4ac454682158473 Dave Marchevsky 2023-10-13  1010  __bpf_kfunc void bpf_iter_task_vma_destroy(struct bpf_iter_task_vma *it)
4ac454682158473 Dave Marchevsky 2023-10-13  1011  {
4ac454682158473 Dave Marchevsky 2023-10-13  1012  	struct bpf_iter_task_vma_kern *kit = (void *)it;
4ac454682158473 Dave Marchevsky 2023-10-13  1013  
4ac454682158473 Dave Marchevsky 2023-10-13  1014  	if (kit->data) {
4cbee026db54cad Puranjay Mohan  2026-04-08  1015  		bpf_iter_task_vma_snapshot_reset(&kit->data->snapshot);
4ac454682158473 Dave Marchevsky 2023-10-13  1016  		put_task_struct(kit->data->task);
d8e27d2d22b6e2d Puranjay Mohan  2026-04-08 @1017  		bpf_iter_mmput_async(kit->data->mm);
4ac454682158473 Dave Marchevsky 2023-10-13  1018  		bpf_mem_free(&bpf_global_ma, kit->data);
4ac454682158473 Dave Marchevsky 2023-10-13  1019  	}
4ac454682158473 Dave Marchevsky 2023-10-13  1020  }
4ac454682158473 Dave Marchevsky 2023-10-13  1021  

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
