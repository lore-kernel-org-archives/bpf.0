Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6BBB34D38B;
	Thu, 13 Aug 2026 16:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786640351; cv=none; b=UdiDT4AD6o9XAwu4tLTNASwyuVzMYhIK/HeXIKMR0OaRQyqhm1HrzpdZ3vXcnBk/GRu0Naaugq6Fsj7PwfPKWKpnx7CLongho2NZRz+BfGPA3bFI3dTE2cz+zI/MDfWrSojujuOMmORBMxdLCNCdm4J1DtjSBSn3NZMo5SVYGxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786640351; c=relaxed/simple;
	bh=GoPukQW4A/wZ7dMKq+X+GW7rm/rCYafEuDVC+FmxvBo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ay6RzBWt58UH0RIg7HrVIwi0jtGCxxnqWlIPEHjHZvjYh1DuII6NwfSD0taI1eq1ZJIC8+8cqpXdZWfY2O6ISgVKIPjUX8xjP6G3mMdKjqjftgHg+NxA/wLA4RgA4HSnzPYcEjur4sGmlTpHjco9qNaQkT7XMVAERpsAHj9a/gE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nHaLTJsQ; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nHaLTJsQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786640349; x=1818176349;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=GoPukQW4A/wZ7dMKq+X+GW7rm/rCYafEuDVC+FmxvBo=;
  b=nHaLTJsQcfnEiwRYff1BRH1GKsHEAXv+2UNSjmccuR/0eMmcvAzSjWk3
   83C6JuMhBR/aArclkWHanL2gmCBHdwVNMyfSU7RlVRC+FfMSz1PrOtRIX
   7MB1XxQVKEqPE+OkZcgNs/d2IFhkzQZIApG3yR9U+qqVCvh+z/Jlv5gtT
   hd8J1pLJrfLuLH6IK+EGLYunulPvso+ubImhx0igGtnTJZw9kzlk+fCR5
   KXsS/+7vU7axxlILWjF+IGQBw17CmyZKpQ8RpvFViIUA+phGJEaXtmhqR
   tpUTyehnaVlOFywkhASqhKR9pLbkiTRro9vklHOkG41rotFiOgm4AxjCZ
   Q==;
X-CSE-ConnectionGUID: lfnpxgd6T2yzB8awJr5oTQ==
X-CSE-MsgGUID: +A6I1bAmQ6ClWmojv9/IRQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11874"; a="87104054"
X-IronPort-AV: E=Sophos;i="6.25,221,1779174000"; 
   d="scan'208";a="87104054"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2026 09:59:08 -0700
X-CSE-ConnectionGUID: Z4N5aDB+T2iBuHAPO/7iGA==
X-CSE-MsgGUID: 0tyDqDAUS2qK9iyIQfr1Ug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,221,1779174000"; 
   d="scan'208";a="268265215"
Received: from lkp-server01.sh.intel.com (HELO 6eda058d650d) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 13 Aug 2026 09:59:05 -0700
Received: from kbuild by 6eda058d650d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wuYlh-00000000Vug-228x;
	Thu, 13 Aug 2026 16:59:01 +0000
Date: Fri, 14 Aug 2026 00:58:19 +0800
From: kernel test robot <lkp@intel.com>
To: Sanghyun Park <sanghyun.park.cnu@gmail.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev,
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
Message-ID: <202608140002.MOWNZYuj-lkp@intel.com>
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
config: powerpc-allmodconfig (https://download.01.org/0day-ci/archive/20260814/202608140002.MOWNZYuj-lkp@intel.com/config)
compiler: powerpc64-linux-gcc (GCC) 16.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260814/202608140002.MOWNZYuj-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202608140002.MOWNZYuj-lkp@intel.com/

All errors (new ones prefixed by >>):

   kernel/bpf/task_iter.c: In function 'bpf_iter_task_vma_destroy':
>> kernel/bpf/task_iter.c:1017:17: error: implicit declaration of function 'bpf_iter_mmput_async' [-Wimplicit-function-declaration]
    1017 |                 bpf_iter_mmput_async(kit->data->mm);
         |                 ^~~~~~~~~~~~~~~~~~~~


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
