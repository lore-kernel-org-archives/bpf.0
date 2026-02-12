Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A38DB72623
	for <bpf@vger.kernel.org>; Thu, 12 Feb 2026 08:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770884177; cv=none; b=tCi3+zq8fGeoiv0y+Ktk+X3JQwdtO+efEnTa1YHveXfQGIOdI/zHO5nGdlLWu7CerP7bqFeGcwuTeICqDQOjag6DdWIOBvk0WBHuxL0yNyE2rgOqQLnyMybyyCs6SXVap+/aV8xjqsZw/bKn1Z7PwxdP4jhteruUW8hHq563haw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770884177; c=relaxed/simple;
	bh=5aoTKAZC9pIwJvooINmvnmCBgU/3N7O7OtGGRHKtH5I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qW+Qmb6e2fKN86qhFHJWSEdDD5qEUInS4mertA0Vhq1bVg+H5vuRkzGmDCNs/MszPQkJijY5NsCE0rPC1F21ZlTHjfnPby7gqz1ymZXjgkeRSLsyk0C4kz+xFot/UhIWEbMOc2Iuhn9X9bsIz4zjLFuSowqYY9rB/RRfT/j+wtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XWw4wli1; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XWw4wli1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770884176; x=1802420176;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5aoTKAZC9pIwJvooINmvnmCBgU/3N7O7OtGGRHKtH5I=;
  b=XWw4wli1KcTTGameKaoEfHStG0q19CktI7AaX8GWMxRs17TB20SNmZOd
   BlGbYCvCk4N3gAXHUrM2IKC2daicc8ioKyL0FGKtHskwF4GL+EUuzGW+0
   PdGGnUW2uz+5Vw+7MYRKy0KXdJ0pBJzvuCHT3qzcJMT8iniqtLIiTnIKu
   1q+AR3rkNBLM5IHiLV0Nrb5NuGDoFGw1rq2A51nin4wNNWYfRmZ4Md1Xl
   z+uE79cwFWUHwdz3qGC17UURe3gCwyLYnsldB1ciaiPjWkXFHbnadiLu3
   5ZbBg11Vvsm4rFal4lgLgeDTFn0pwrVKGrUdDldpGyn5Fj91AWRrDQomT
   w==;
X-CSE-ConnectionGUID: rKVO+42JT96b9qcxl+G1dQ==
X-CSE-MsgGUID: 1pRu2g76SzWPh6rSIIQfTg==
X-IronPort-AV: E=McAfee;i="6800,10657,11698"; a="82688620"
X-IronPort-AV: E=Sophos;i="6.21,286,1763452800"; 
   d="scan'208";a="82688620"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2026 00:16:15 -0800
X-CSE-ConnectionGUID: QJojZEZqR22zXchZiWs/8g==
X-CSE-MsgGUID: IN2EF4zZTMiDSwtXTlX7dQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,286,1763452800"; 
   d="scan'208";a="242151100"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 12 Feb 2026 00:16:12 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vqRru-00000000qpC-1UkC;
	Thu, 12 Feb 2026 08:16:10 +0000
Date: Thu, 12 Feb 2026 16:15:19 +0800
From: kernel test robot <lkp@intel.com>
To: Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org,
	ast@kernel.org, andrii@kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com,
	yonghong.song@linux.dev, eddyz87@gmail.com
Subject: Re: [PATCH bpf-next 3/3] bpf: rename bpf_reg_state->off to
 bpf_reg_state->delta
Message-ID: <202602121620.Ygb7WrDQ-lkp@intel.com>
References: <20260211-ptrs-off-migration-v1-3-996c2a37b063@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260211-ptrs-off-migration-v1-3-996c2a37b063@gmail.com>

Hi Eduard,

kernel test robot noticed the following build errors:

[auto build test ERROR on 4475cdac12c46fc26ee815de1b43cfe9f8375140]

url:    https://github.com/intel-lab-lkp/linux/commits/Eduard-Zingerman/bpf-split-check_reg_sane_offset-in-two-parts/20260212-063425
base:   4475cdac12c46fc26ee815de1b43cfe9f8375140
patch link:    https://lore.kernel.org/r/20260211-ptrs-off-migration-v1-3-996c2a37b063%40gmail.com
patch subject: [PATCH bpf-next 3/3] bpf: rename bpf_reg_state->off to bpf_reg_state->delta
config: x86_64-rhel-9.4-rust (https://download.01.org/0day-ci/archive/20260212/202602121620.Ygb7WrDQ-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
rustc: rustc 1.88.0 (6b00bc388 2025-06-23)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260212/202602121620.Ygb7WrDQ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202602121620.Ygb7WrDQ-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/net/ethernet/netronome/nfp/bpf/verifier.c:101:14: error: no member named 'off' in 'struct bpf_reg_state'
     101 |         off = reg3->off + reg3->var_off.value;
         |               ~~~~  ^
   drivers/net/ethernet/netronome/nfp/bpf/verifier.c:140:34: error: no member named 'off' in 'struct bpf_reg_state'
     140 |         off = reg->var_off.value + reg->off;
         |                                    ~~~  ^
   drivers/net/ethernet/netronome/nfp/bpf/verifier.c:150:54: error: no member named 'off' in 'struct bpf_reg_state'
     150 |         old_off = old_arg->reg.var_off.value + old_arg->reg.off;
         |                                                ~~~~~~~~~~~~ ^
   drivers/net/ethernet/netronome/nfp/bpf/verifier.c:361:22: error: no member named 'off' in 'struct bpf_reg_state'
     361 |         old_off = meta->ptr.off + meta->ptr.var_off.value;
         |                   ~~~~~~~~~ ^
   drivers/net/ethernet/netronome/nfp/bpf/verifier.c:362:17: error: no member named 'off' in 'struct bpf_reg_state'
     362 |         new_off = reg->off + reg->var_off.value;
         |                   ~~~  ^
   drivers/net/ethernet/netronome/nfp/bpf/verifier.c:431:51: error: no member named 'off' in 'struct bpf_reg_state'
     431 |         off = reg->var_off.value + meta->insn.off + reg->off;
         |                                                     ~~~  ^
   6 errors generated.
--
>> drivers/net/ethernet/netronome/nfp/bpf/jit.c:1734:58: error: no member named 'off' in 'struct bpf_reg_state'
    1734 |         lm_off += meta->arg2.reg.var_off.value + meta->arg2.reg.off;
         |                                                  ~~~~~~~~~~~~~~ ^
   drivers/net/ethernet/netronome/nfp/bpf/jit.c:2878:20: error: no member named 'off' in 'struct bpf_reg_state'
    2878 |                                      meta->ptr.off + meta->ptr.var_off.value);
         |                                      ~~~~~~~~~ ^
   drivers/net/ethernet/netronome/nfp/bpf/jit.c:2989:20: error: no member named 'off' in 'struct bpf_reg_state'
    2989 |                                      meta->ptr.off + meta->ptr.var_off.value);
         |                                      ~~~~~~~~~ ^
   drivers/net/ethernet/netronome/nfp/bpf/jit.c:4156:59: error: no member named 'off' in 'struct bpf_reg_state'
    4156 |         head_ld_off = head_ld_meta->insn.off + head_ld_meta->ptr.off;
         |                                                ~~~~~~~~~~~~~~~~~ ^
   drivers/net/ethernet/netronome/nfp/bpf/jit.c:4157:59: error: no member named 'off' in 'struct bpf_reg_state'
    4157 |         head_st_off = head_st_meta->insn.off + head_st_meta->ptr.off;
         |                                                ~~~~~~~~~~~~~~~~~ ^
   drivers/net/ethernet/netronome/nfp/bpf/jit.c:4158:39: error: no member named 'off' in 'struct bpf_reg_state'
    4158 |         ld_off = ld->off + head_ld_meta->ptr.off;
         |                            ~~~~~~~~~~~~~~~~~ ^
   drivers/net/ethernet/netronome/nfp/bpf/jit.c:4329:17: error: no member named 'off' in 'struct bpf_reg_state'
    4329 |                     meta->ptr.off == range_ptr_off) {
         |                     ~~~~~~~~~ ^
   drivers/net/ethernet/netronome/nfp/bpf/jit.c:4364:35: error: no member named 'off' in 'struct bpf_reg_state'
    4364 |                 range_ptr_off = range_node->ptr.off;
         |                                 ~~~~~~~~~~~~~~~ ^
   8 errors generated.


vim +101 drivers/net/ethernet/netronome/nfp/bpf/verifier.c

8231f8444110c3 Jakub Kicinski 2017-12-14   82  
527db74b71ee5a Jakub Kicinski 2018-10-16   83  static bool nfp_bpf_map_update_value_ok(struct bpf_verifier_env *env)
527db74b71ee5a Jakub Kicinski 2018-10-16   84  {
527db74b71ee5a Jakub Kicinski 2018-10-16   85  	const struct bpf_reg_state *reg1 = cur_regs(env) + BPF_REG_1;
527db74b71ee5a Jakub Kicinski 2018-10-16   86  	const struct bpf_reg_state *reg3 = cur_regs(env) + BPF_REG_3;
527db74b71ee5a Jakub Kicinski 2018-10-16   87  	struct bpf_offloaded_map *offmap;
527db74b71ee5a Jakub Kicinski 2018-10-16   88  	struct bpf_func_state *state;
527db74b71ee5a Jakub Kicinski 2018-10-16   89  	struct nfp_bpf_map *nfp_map;
527db74b71ee5a Jakub Kicinski 2018-10-16   90  	int off, i;
527db74b71ee5a Jakub Kicinski 2018-10-16   91  
527db74b71ee5a Jakub Kicinski 2018-10-16   92  	state = env->cur_state->frame[reg3->frameno];
527db74b71ee5a Jakub Kicinski 2018-10-16   93  
527db74b71ee5a Jakub Kicinski 2018-10-16   94  	/* We need to record each time update happens with non-zero words,
527db74b71ee5a Jakub Kicinski 2018-10-16   95  	 * in case such word is used in atomic operations.
527db74b71ee5a Jakub Kicinski 2018-10-16   96  	 * Implicitly depend on nfp_bpf_stack_arg_ok(reg3) being run before.
527db74b71ee5a Jakub Kicinski 2018-10-16   97  	 */
527db74b71ee5a Jakub Kicinski 2018-10-16   98  
527db74b71ee5a Jakub Kicinski 2018-10-16   99  	offmap = map_to_offmap(reg1->map_ptr);
527db74b71ee5a Jakub Kicinski 2018-10-16  100  	nfp_map = offmap->dev_priv;
527db74b71ee5a Jakub Kicinski 2018-10-16 @101  	off = reg3->off + reg3->var_off.value;
527db74b71ee5a Jakub Kicinski 2018-10-16  102  
527db74b71ee5a Jakub Kicinski 2018-10-16  103  	for (i = 0; i < offmap->map.value_size; i++) {
527db74b71ee5a Jakub Kicinski 2018-10-16  104  		struct bpf_stack_state *stack_entry;
527db74b71ee5a Jakub Kicinski 2018-10-16  105  		unsigned int soff;
527db74b71ee5a Jakub Kicinski 2018-10-16  106  
527db74b71ee5a Jakub Kicinski 2018-10-16  107  		soff = -(off + i) - 1;
527db74b71ee5a Jakub Kicinski 2018-10-16  108  		stack_entry = &state->stack[soff / BPF_REG_SIZE];
527db74b71ee5a Jakub Kicinski 2018-10-16  109  		if (stack_entry->slot_type[soff % BPF_REG_SIZE] == STACK_ZERO)
527db74b71ee5a Jakub Kicinski 2018-10-16  110  			continue;
527db74b71ee5a Jakub Kicinski 2018-10-16  111  
527db74b71ee5a Jakub Kicinski 2018-10-16  112  		if (nfp_map->use_map[i / 4].type == NFP_MAP_USE_ATOMIC_CNT) {
527db74b71ee5a Jakub Kicinski 2018-10-16  113  			pr_vlog(env, "value at offset %d/%d may be non-zero, bpf_map_update_elem() is required to initialize atomic counters to zero to avoid offload endian issues\n",
527db74b71ee5a Jakub Kicinski 2018-10-16  114  				i, soff);
527db74b71ee5a Jakub Kicinski 2018-10-16  115  			return false;
527db74b71ee5a Jakub Kicinski 2018-10-16  116  		}
527db74b71ee5a Jakub Kicinski 2018-10-16  117  		nfp_map->use_map[i / 4].non_zero_update = 1;
527db74b71ee5a Jakub Kicinski 2018-10-16  118  	}
527db74b71ee5a Jakub Kicinski 2018-10-16  119  
527db74b71ee5a Jakub Kicinski 2018-10-16  120  	return true;
527db74b71ee5a Jakub Kicinski 2018-10-16  121  }
527db74b71ee5a Jakub Kicinski 2018-10-16  122  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
