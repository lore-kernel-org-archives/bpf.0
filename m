Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DACC82F0C7E;
	Fri,  6 Feb 2026 21:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770414505; cv=none; b=PtN28ZcmDYy7RLe5brNgsBr5ncUm+bphLfhshpHRgSETY1+Du65S+qZmA+tMQCsUttiwEWIoN/0gBQxzTwCHHxqsS39jKLBdC56rsEXmZJQTp9L5l5AG7RSVmx2eYfffZMRf0elKEGjfgo2HuPC0KW/AgvPCqcbSkxQIwvnISmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770414505; c=relaxed/simple;
	bh=OTAKu6rfMqIETd68jbhyz7+ArkBvpBLfD4eMEZbcVgw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qm5vcfbuJWltZlNwkxYrzyoG18KOxQDF4g3UY/wuGoOpPsctNrdY/a2L/DjdLDY20sYsruvJg60LghWMc3pI9bwXr8R7C7Yv8F4+1xzV5jpgrZBj9SQWFcbsCwG3kmSm3cV8dGo1fewW1ukmP+phz10cjss4M6WmJwrNZqnd0Wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UKhaDmWL; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UKhaDmWL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770414505; x=1801950505;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=OTAKu6rfMqIETd68jbhyz7+ArkBvpBLfD4eMEZbcVgw=;
  b=UKhaDmWL88qPRXttKXQOVpcO9k9WR6VtqnLA4shIcsq8aZ51qZuFh4sA
   72/pY29WnRbJTxTHuKGNnNfnWiLZs+2rK6qwqEXYKWWBt0D41SXeH1XJG
   YDGgZlLfeG3SO4d84ptWExxyVjY7yn8BQXDzNe5O0zKW5Z4TxXxm74QLL
   X7p7D6MX/97X9IJXbh1VAqSHKesXVW6/PihK+EzRCOf/PXmhCK9pWpkoa
   1hpOdqPfBEUFF1e9ymXAtmFL5bg8hBEOxbR5zfXkljyI4tAyOzMV8x1Lq
   AMXb3uPkcCENCw+8Ko1575Whs9BM6r4CMSCkTubVXpFPm7oaM5Lboe3hu
   A==;
X-CSE-ConnectionGUID: OdV/DtjsRF+BahqeqD8KoQ==
X-CSE-MsgGUID: 46xVaP6aR5KmiCTg5AtioQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11693"; a="71664994"
X-IronPort-AV: E=Sophos;i="6.21,277,1763452800"; 
   d="scan'208";a="71664994"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2026 13:48:24 -0800
X-CSE-ConnectionGUID: eBoQ4nf7Q+2o9LQPoINnPg==
X-CSE-MsgGUID: w0vkzmSrSQ66tmNFWLgnGA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,277,1763452800"; 
   d="scan'208";a="210078155"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 06 Feb 2026 13:48:19 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1voTgW-00000000lBo-2tlh;
	Fri, 06 Feb 2026 21:48:16 +0000
Date: Sat, 7 Feb 2026 05:47:52 +0800
From: kernel test robot <lkp@intel.com>
To: Menglong Dong <menglong8.dong@gmail.com>, ast@kernel.org,
	bjorn@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, daniel@iogearbox.net, andrii@kernel.org,
	martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
	yonghong.song@linux.dev, john.fastabend@gmail.com,
	kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com,
	jolsa@kernel.org, pulehui@huawei.com, puranjay@kernel.org,
	pjw@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu,
	alex@ghiti.fr, bpf@vger.kernel.org, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org, jiang.biao@linux.dev
Subject: Re: [PATCH bpf-next v3 2/3] bpf, riscv: add fsession support for
 trampolines
Message-ID: <202602070533.NAsdK5m6-lkp@intel.com>
References: <20260206122002.1494125-3-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260206122002.1494125-3-dongml2@chinatelecom.cn>

Hi Menglong,

kernel test robot noticed the following build errors:

[auto build test ERROR on bpf-next/master]

url:    https://github.com/intel-lab-lkp/linux/commits/Menglong-Dong/bpf-riscv-introduce-emit_store_stack_imm64-for-trampoline/20260206-202356
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
patch link:    https://lore.kernel.org/r/20260206122002.1494125-3-dongml2%40chinatelecom.cn
patch subject: [PATCH bpf-next v3 2/3] bpf, riscv: add fsession support for trampolines
config: riscv-allyesconfig (https://download.01.org/0day-ci/archive/20260207/202602070533.NAsdK5m6-lkp@intel.com/config)
compiler: clang version 16.0.6 (https://github.com/llvm/llvm-project 7cbf1a2591520c2491aa35339f227775f4d3adf6)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260207/202602070533.NAsdK5m6-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202602070533.NAsdK5m6-lkp@intel.com/

All errors (new ones prefixed by >>):

>> arch/riscv/net/bpf_jit_comp64.c:1008:37: error: incompatible pointer types passing 'struct bpf_tramp_link **' to parameter of type 'struct bpf_tramp_link *'; remove & [-Werror,-Wincompatible-pointer-types]
                   if (bpf_prog_calls_session_cookie(&tl->links[i])) {
                                                     ^~~~~~~~~~~~~
   include/linux/bpf.h:2199:73: note: passing argument to parameter 'link' here
   static inline bool bpf_prog_calls_session_cookie(struct bpf_tramp_link *link)
                                                                           ^
   1 error generated.


vim +1008 arch/riscv/net/bpf_jit_comp64.c

   998	
   999	static int invoke_bpf(struct bpf_tramp_links *tl, int args_off, int retval_off,
  1000			      int run_ctx_off, int func_meta_off, bool save_ret, u64 func_meta,
  1001			      int cookie_off, struct rv_jit_context *ctx)
  1002	{
  1003		int i, cur_cookie = (cookie_off - args_off) / 8;
  1004	
  1005		for (i = 0; i < tl->nr_links; i++) {
  1006			int err;
  1007	
> 1008			if (bpf_prog_calls_session_cookie(&tl->links[i])) {
  1009				u64 meta = func_meta | ((u64)cur_cookie << BPF_TRAMP_COOKIE_INDEX_SHIFT);
  1010	
  1011				emit_store_stack_imm64(RV_REG_T1, -func_meta_off, meta, ctx);
  1012				cur_cookie--;
  1013			}
  1014			err = invoke_bpf_prog(tl->links[i], args_off, retval_off, run_ctx_off,
  1015					      save_ret, ctx);
  1016			if (err)
  1017				return err;
  1018		}
  1019		return 0;
  1020	}
  1021	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
