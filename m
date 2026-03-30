Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 975C93D6CCB;
	Mon, 30 Mar 2026 17:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774893275; cv=none; b=biFN3tiyeF1mbSuLRKA68cA5pKcpBTVyszrBP2/zXEBTDwqi5pEpVC/5wkqM2+h7q30U8RcNwIMYBXizS3ZwjLUatwT9c77/E5WOCFOrXb2RnC96SXG8TThjgJ25xLj2lq38T4CmolmKTRwYXEob5qYxIKPS6DiOcOiR2rqPZ4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774893275; c=relaxed/simple;
	bh=eLUUs/uINZRp0swu0VT+wM5lj3OYCTGL+1axZehhiZI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=arKbT+7OioyqPseI0Cw+uU+/wk8Q6U2QEdPi8MiooqUL/dLSq5T21AzdvgNXKfrq8Pis8VoxbKlbpOnMdYYeVLtslHD/+q0Hinh5nu+9dzVYKeP6oMypQym0cTfV/H4nAaSAuILDUTQVzVaUhx2nQapTlt8uKJySP0sCiP0a9rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GwQLl2ES; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GwQLl2ES"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774893273; x=1806429273;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=eLUUs/uINZRp0swu0VT+wM5lj3OYCTGL+1axZehhiZI=;
  b=GwQLl2ESkB6znV55Subdf7UQ579gLjIQ5yyQKYsF88NnipOqsWythUY7
   wYIz6HNFd8dY3WmWS8SuRGGowPijhy0l/x7xbSR0KyGtGNPfzYpCseV+q
   4W0ThgDJcQUrEed1xxI5ClurTMKQe7i6wkuF4irPKP+nIdEcMEfIa3jTr
   4Bd5i5LvLyz/TebKPuyp/GTjrw4+bkZn6K3Yd5CsvMsvTzdomIfMO4IIu
   v1zoxR+cCxD5ZbN+5Uhz3MOxwZ7dGUDtonM98tc3B673ezd/XGjsVJHjX
   +A1YROF4fREjELF4qp6aHyNA4wcgbXr+sS8u1kdCEXdM372lxLruBRu3z
   A==;
X-CSE-ConnectionGUID: zux+ZnFHTI2pwvVNJFIkJA==
X-CSE-MsgGUID: olVUb06SQ6earDi0FhukfA==
X-IronPort-AV: E=McAfee;i="6800,10657,11743"; a="101351693"
X-IronPort-AV: E=Sophos;i="6.23,150,1770624000"; 
   d="scan'208";a="101351693"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2026 10:54:33 -0700
X-CSE-ConnectionGUID: 4oKm/7PgQl2Vh3qJ7qdA4w==
X-CSE-MsgGUID: ZlvjjazRS5emlFqeRpMgkg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,150,1770624000"; 
   d="scan'208";a="249175053"
Received: from lkp-server01.sh.intel.com (HELO 283bf2e1b94a) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 30 Mar 2026 10:54:30 -0700
Received: from kbuild by 283bf2e1b94a with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1w7Gom-000000001Rx-0Ds9;
	Mon, 30 Mar 2026 17:54:28 +0000
Date: Tue, 31 Mar 2026 01:53:33 +0800
From: kernel test robot <lkp@intel.com>
To: Helen Koike <koike@igalia.com>, andrii@kernel.org, eddyz87@gmail.com,
	shung-hsi.yu@suse.com, yonghong.song@linux.dev, ast@kernel.org,
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-dev@igalia.com
Cc: oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH] bpf: fix umin/umax when lower bits fall outside u32 range
Message-ID: <202603310103.qoJg885q-lkp@intel.com>
References: <20260327194849.855397-1-koike@igalia.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260327194849.855397-1-koike@igalia.com>

Hi Helen,

kernel test robot noticed the following build warnings:

[auto build test WARNING on bpf-next/net]
[also build test WARNING on bpf-next/master bpf/master linus/master v7.0-rc6 next-20260327]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Helen-Koike/bpf-fix-umin-umax-when-lower-bits-fall-outside-u32-range/20260330-171706
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git net
patch link:    https://lore.kernel.org/r/20260327194849.855397-1-koike%40igalia.com
patch subject: [PATCH] bpf: fix umin/umax when lower bits fall outside u32 range
config: i386-randconfig-013-20260330 (https://download.01.org/0day-ci/archive/20260331/202603310103.qoJg885q-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260331/202603310103.qoJg885q-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603310103.qoJg885q-lkp@intel.com/

All warnings (new ones prefixed by >>):

   kernel/bpf/verifier.c: In function '__reg_deduce_mixed_bounds':
>> kernel/bpf/verifier.c:2699:63: warning: suggest parentheses around arithmetic in operand of '|' [-Wparentheses]
    2699 |                 new_umin = (reg->umin_value & ~0xffffffffULL) + (1ULL << 32) |
         |                            ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~
   kernel/bpf/verifier.c:2710:63: warning: suggest parentheses around arithmetic in operand of '|' [-Wparentheses]
    2710 |                 new_umax = (reg->umax_value & ~0xffffffffULL) - (1ULL << 32) |
         |                            ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~


vim +2699 kernel/bpf/verifier.c

  2675	
  2676	static void __reg_deduce_mixed_bounds(struct bpf_reg_state *reg)
  2677	{
  2678		/* Try to tighten 64-bit bounds from 32-bit knowledge, using 32-bit
  2679		 * values on both sides of 64-bit range in hope to have tighter range.
  2680		 * E.g., if r1 is [0x1'00000000, 0x3'80000000], and we learn from
  2681		 * 32-bit signed > 0 operation that s32 bounds are now [1; 0x7fffffff].
  2682		 * With this, we can substitute 1 as low 32-bits of _low_ 64-bit bound
  2683		 * (0x100000000 -> 0x100000001) and 0x7fffffff as low 32-bits of
  2684		 * _high_ 64-bit bound (0x380000000 -> 0x37fffffff) and arrive at a
  2685		 * better overall bounds for r1 as [0x1'000000001; 0x3'7fffffff].
  2686		 * We just need to make sure that derived bounds we are intersecting
  2687		 * with are well-formed ranges in respective s64 or u64 domain, just
  2688		 * like we do with similar kinds of 32-to-64 or 64-to-32 adjustments.
  2689		 */
  2690		__u64 new_umin, new_umax;
  2691		__s64 new_smin, new_smax;
  2692	
  2693		/*
  2694		 * If (u32)umin > u32_max, no value in the current upper-32-bit block
  2695		 * satisfies [u32_min, u32_max] while being >= umin; advance umin to
  2696		 * the next block. Otherwise apply standard u32->u64 tightening.
  2697		 */
  2698		if ((u32)reg->umin_value > reg->u32_max_value)
> 2699			new_umin = (reg->umin_value & ~0xffffffffULL) + (1ULL << 32) |
  2700				   reg->u32_min_value;
  2701		else
  2702			new_umin = (reg->umin_value & ~0xffffffffULL) |
  2703				   reg->u32_min_value;
  2704	
  2705		/*
  2706		 * Symmetrically, if (u32)umax < u32_min, retreat umax to the
  2707		 * previous block. Otherwise apply standard u32->u64 tightening.
  2708		 */
  2709		if ((u32)reg->umax_value < reg->u32_min_value)
  2710			new_umax = (reg->umax_value & ~0xffffffffULL) - (1ULL << 32) |
  2711				   reg->u32_max_value;
  2712		else
  2713			new_umax = (reg->umax_value & ~0xffffffffULL) |
  2714				   reg->u32_max_value;
  2715	
  2716		reg->umin_value = max_t(u64, reg->umin_value, new_umin);
  2717		reg->umax_value = min_t(u64, reg->umax_value, new_umax);
  2718		/* u32 -> s64 tightening, u32 range embedded into s64 preserves range validity */
  2719		new_smin = (reg->smin_value & ~0xffffffffULL) | reg->u32_min_value;
  2720		new_smax = (reg->smax_value & ~0xffffffffULL) | reg->u32_max_value;
  2721		reg->smin_value = max_t(s64, reg->smin_value, new_smin);
  2722		reg->smax_value = min_t(s64, reg->smax_value, new_smax);
  2723	
  2724		/* Here we would like to handle a special case after sign extending load,
  2725		 * when upper bits for a 64-bit range are all 1s or all 0s.
  2726		 *
  2727		 * Upper bits are all 1s when register is in a range:
  2728		 *   [0xffff_ffff_0000_0000, 0xffff_ffff_ffff_ffff]
  2729		 * Upper bits are all 0s when register is in a range:
  2730		 *   [0x0000_0000_0000_0000, 0x0000_0000_ffff_ffff]
  2731		 * Together this forms are continuous range:
  2732		 *   [0xffff_ffff_0000_0000, 0x0000_0000_ffff_ffff]
  2733		 *
  2734		 * Now, suppose that register range is in fact tighter:
  2735		 *   [0xffff_ffff_8000_0000, 0x0000_0000_ffff_ffff] (R)
  2736		 * Also suppose that it's 32-bit range is positive,
  2737		 * meaning that lower 32-bits of the full 64-bit register
  2738		 * are in the range:
  2739		 *   [0x0000_0000, 0x7fff_ffff] (W)
  2740		 *
  2741		 * If this happens, then any value in a range:
  2742		 *   [0xffff_ffff_0000_0000, 0xffff_ffff_7fff_ffff]
  2743		 * is smaller than a lowest bound of the range (R):
  2744		 *   0xffff_ffff_8000_0000
  2745		 * which means that upper bits of the full 64-bit register
  2746		 * can't be all 1s, when lower bits are in range (W).
  2747		 *
  2748		 * Note that:
  2749		 *  - 0xffff_ffff_8000_0000 == (s64)S32_MIN
  2750		 *  - 0x0000_0000_7fff_ffff == (s64)S32_MAX
  2751		 * These relations are used in the conditions below.
  2752		 */
  2753		if (reg->s32_min_value >= 0 && reg->smin_value >= S32_MIN && reg->smax_value <= S32_MAX) {
  2754			reg->smin_value = reg->s32_min_value;
  2755			reg->smax_value = reg->s32_max_value;
  2756			reg->umin_value = reg->s32_min_value;
  2757			reg->umax_value = reg->s32_max_value;
  2758			reg->var_off = tnum_intersect(reg->var_off,
  2759						      tnum_range(reg->smin_value, reg->smax_value));
  2760		}
  2761	}
  2762	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
