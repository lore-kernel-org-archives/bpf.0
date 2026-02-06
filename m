Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FAD43EBF19;
	Fri,  6 Feb 2026 20:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770409402; cv=none; b=gwnz9yFPk4nXe9Di2cHabnThfFDmojp6xaYAs+4Dc1EEqcTDYxSpdwumRMnbUZJg1+HNAeQJtJ6JPXADSqqzu2Ose8ULvM90U+sBX49/3PpNZbTPvWtgqgKE4EaQAwodK6PTlbEY4tg69biBsK51XkDoSV7u6oDoXGVWoCyUFHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770409402; c=relaxed/simple;
	bh=ZWMzhVSsuFWA8/ih7p2SAqQIt6FnkD+vZqt/ciGixAc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MStWQg/XKMo1MPlqb3PmGTJ+zUXB+74SR/bCtp6cC6nucPI/JN9yA+s6qiJywCceTa7vLc0ZeylXlMgJFGxWzVlg8aJPYI5CmEN1XzE+DiXSX90VAJlXjOoEYfxUlvPtoNMdaTlbvp0uorHvhHjdvXjccICnpq+3hggEwSpw6dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nZFlEr49; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nZFlEr49"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770409401; x=1801945401;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ZWMzhVSsuFWA8/ih7p2SAqQIt6FnkD+vZqt/ciGixAc=;
  b=nZFlEr49+EV4IL3X7A7ZBtlxdlf/WzKH9YArjAZf3o5K6j0uN+xMOjHB
   4crPC8BfUQzNfFNwvrsXn9nAn3zXWCCNQBmP6fIFbElt7PImT2QiP2OpD
   opFUj3l+9S8v600FElwAv6MkVU7/kk4mafHQvSsTWCdJr+UAoaYUlUOjs
   vMKraqq97WMx5oJYBxuv9RZ5gId/m3SYBS7knwpQniqPGhXXXw+OD15ro
   415orpUOyrxkkeHoRhq3LsOv3BeqECz5hAwFZEnJd+A+/Lw8tSJe+ucOl
   70xFfBEwJp/BMX8E8MyKtgM1XRa8yANlcfGrsATdmMFq+Y8qW8mgIXFoT
   g==;
X-CSE-ConnectionGUID: qYwLr5NNT+eSBJt/hseY8Q==
X-CSE-MsgGUID: Vhx29QsGRvyiRm5uFApTvQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11693"; a="83062520"
X-IronPort-AV: E=Sophos;i="6.21,277,1763452800"; 
   d="scan'208";a="83062520"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2026 12:23:20 -0800
X-CSE-ConnectionGUID: 6yKFI4BGS2KXCCJIJN6sBQ==
X-CSE-MsgGUID: h7YTw79iTb+WMmdilYntNQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,277,1763452800"; 
   d="scan'208";a="210253095"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 06 Feb 2026 12:23:15 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1voSMC-00000000l6i-4C6F;
	Fri, 06 Feb 2026 20:23:13 +0000
Date: Sat, 7 Feb 2026 04:22:42 +0800
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
Message-ID: <202602070435.BuX0TvvF-lkp@intel.com>
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
config: riscv-randconfig-r112-20260206 (https://download.01.org/0day-ci/archive/20260207/202602070435.BuX0TvvF-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 10.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260207/202602070435.BuX0TvvF-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202602070435.BuX0TvvF-lkp@intel.com/

All errors (new ones prefixed by >>):

   arch/riscv/net/bpf_jit_comp64.c: In function 'invoke_bpf':
>> arch/riscv/net/bpf_jit_comp64.c:1008:37: error: passing argument 1 of 'bpf_prog_calls_session_cookie' from incompatible pointer type [-Werror=incompatible-pointer-types]
    1008 |   if (bpf_prog_calls_session_cookie(&tl->links[i])) {
         |                                     ^~~~~~~~~~~~~
         |                                     |
         |                                     struct bpf_tramp_link **
   In file included from arch/riscv/net/bpf_jit_comp64.c:9:
   include/linux/bpf.h:2199:73: note: expected 'struct bpf_tramp_link *' but argument is of type 'struct bpf_tramp_link **'
    2199 | static inline bool bpf_prog_calls_session_cookie(struct bpf_tramp_link *link)
         |                                                  ~~~~~~~~~~~~~~~~~~~~~~~^~~~
   cc1: some warnings being treated as errors


vim +/bpf_prog_calls_session_cookie +1008 arch/riscv/net/bpf_jit_comp64.c

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
