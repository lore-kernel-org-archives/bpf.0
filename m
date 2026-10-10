Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7FEE33A9D6
	for <bpf@vger.kernel.org>; Sat, 10 Oct 2026 01:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791595579; cv=none; b=jm7r0esDOTpgoOIcZTGf9dXTU/X/ySWQ7Q4c7/IqpWuNwme2cGoj8HLfCQXNJVL0fSot/BuEcRtXfwyL+H55dJoEMy4q8GRg+WeQ+rcv021vmGPHd0CTVmfPutIAMdAsI6JMv+1Kt697SBmZ5L4LHx2tShr2ny+qFxDRwylMd+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791595579; c=relaxed/simple;
	bh=/V5wlvPKWQKAkVjopIho6YkU9YilScMH8CxZAO2lAJ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f7e2CUql/lGRvFpKGDA0lGlkHykbFF2vNdxlvrKLyh77VaRyIWn2na+cs1TRDe7fu1D/CrPwMyoEHxyoK5qKXmbGFz8eedcHoHAMBWB68mrVguAYFLOqZg/pMvlCWVfAACD088uyjFNGZ216azCdzu+bCTO99zve4GO6sSBbJFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BFFtk0pI; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BFFtk0pI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791595575; x=1823131575;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=/V5wlvPKWQKAkVjopIho6YkU9YilScMH8CxZAO2lAJ8=;
  b=BFFtk0pIoFbkvMCRDsp+xO8f8oLtwjCL69WmodhsiR88pERueNagXeer
   ivyRnoLyBJahMF0f4rs+3iPnoiWdFDCZd6g6Pjr7cigxKWgWLfadnCCZu
   hSFAzZWfSvu1srJQ7ilSAMThU5hH3xENhRN5XPgDqRO0tpO60MlOQ22Tm
   VwYrCjgyiPPvuoxpLXmd5Flx+983SyPUm/P8C26sVutVjmgP+k3giuEft
   Zj419y4BI4zEpglYT/f6BBup8SO08TgPF0LP+aS0X7531IHeB8XxHwf4s
   Xxggi5AdUZZD0ZY2UmVUX8su2U58N12k9Imoo9tkFU7Pzp75gz/lEgzLd
   w==;
X-CSE-ConnectionGUID: 8Qd927x8S8eb38RO/C+eag==
X-CSE-MsgGUID: hmJZ+tBJQFKQI6vbr/7qzg==
X-IronPort-AV: E=McAfee;i="6800,10657,11930"; a="494683"
X-IronPort-AV: E=Sophos;i="6.27,149,1787036400"; 
   d="scan'208";a="494683"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2026 18:26:15 -0700
X-CSE-ConnectionGUID: +IGKHK0FRq+QDhYz4IF47A==
X-CSE-MsgGUID: 4y38ppWpTQOUfw0Wh1FU6A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,149,1787036400"; 
   d="scan'208";a="568324"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 09 Oct 2026 18:26:12 -0700
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xFLqj-000000006NA-1RGO;
	Sat, 10 Oct 2026 01:26:09 +0000
Date: Sat, 10 Oct 2026 09:25:58 +0800
From: kernel test robot <lkp@intel.com>
To: Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org,
	ast@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, andrii@kernel.org, daniel@iogearbox.net,
	kernel-team@fb.com, yonghong.song@linux.dev,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: Re: [PATCH bpf-next v3 34/51] bpf: use SCEV to widen bounded loops
Message-ID: <202610100928.qjEH6jQv-lkp@intel.com>
References: <20261009-scev-minimal-rebase-v3-34-bcba9bc53ac9@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261009-scev-minimal-rebase-v3-34-bcba9bc53ac9@gmail.com>

Hi Eduard,

kernel test robot noticed the following build errors:

[auto build test ERROR on e1d84a37cba984388988d2f1ddc84561413f0db2]

url:    https://github.com/intel-lab-lkp/linux/commits/Eduard-Zingerman/bpf-represent-stack-access-effects-with-arg_access_info/20261009-034719
base:   e1d84a37cba984388988d2f1ddc84561413f0db2
patch link:    https://lore.kernel.org/r/20261009-scev-minimal-rebase-v3-34-bcba9bc53ac9%40gmail.com
patch subject: [PATCH bpf-next v3 34/51] bpf: use SCEV to widen bounded loops
config: i386-buildonly-randconfig-1002-20261010 (https://download.01.org/0day-ci/archive/20261010/202610100928.qjEH6jQv-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261010/202610100928.qjEH6jQv-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202610100928.qjEH6jQv-lkp@intel.com/

All errors (new ones prefixed by >>):

   ld: kernel/bpf/scev.o: in function `compute_max_iters':
>> kernel/bpf/scev.c:2062:(.text+0x1193): undefined reference to `__udivdi3'
>> ld: kernel/bpf/scev.c:2067:(.text+0x11b7): undefined reference to `__udivdi3'
   ld: kernel/bpf/scev.c:2074:(.text+0x11e3): undefined reference to `__udivdi3'
   ld: kernel/bpf/scev.c:2075:(.text+0x1207): undefined reference to `__udivdi3'
   ld: kernel/bpf/scev.c:2081:(.text+0x123e): undefined reference to `__udivdi3'
   ld: kernel/bpf/scev.o:kernel/bpf/scev.c:2089: more undefined references to `__udivdi3' follow
   ld: kernel/bpf/scev.o: in function `compute_max_iters':
   kernel/bpf/scev.c:2141:(.text+0x1464): undefined reference to `__udivmoddi4'


vim +2062 kernel/bpf/scev.c

  1980	
  1981	/*
  1982	 * Loop with post-condition:
  1983	 *
  1984	 *    r0 = 0
  1985	 * l: ...                r0 ∈ [0,1,2] header executed 3 times
  1986	 *    r0 += 1            r0 ∈ [0,1,2]
  1987	 *    ...                r0 ∈ [1,2,3]
  1988	 *    if r0 != 3 goto l  r0 ∈ [1,2,3] backedge taken 2 times
  1989	 *    ...                r0 ∈ [3]
  1990	 *
  1991	 * SCEV at header: r0 = k
  1992	 * SCEV at latch:  r0 = 1 + k
  1993	 *
  1994	 * Loop with pre-condition:
  1995	 *
  1996	 *    r0 = 0
  1997	 * l: ...                r0 ∈ [0,1,2,3] header executed 4 times
  1998	 *    if r0 == 3 goto e  r0 ∈ [0,1,2,3] backedge taken 3 times
  1999	 *    r0 += 1            r0 ∈ [0,1,2]
  2000	 *    ...                r0 ∈ [1,2,3]
  2001	 *    goto l             r0 ∈ [1,2,3]
  2002	 * e: ...                r0 ∈ [3]
  2003	 *
  2004	 * SCEV at header: r0 = k
  2005	 * SCEV at latch:  r0 = k
  2006	 */
  2007	static bool compute_max_iters(struct bpf_verifier_env *env,
  2008				      struct bpf_func_state *st,
  2009				      struct linear_latch *latch,
  2010				      struct bpf_loop_iters *iters)
  2011	{
  2012		struct bpf_insn_aux_data *aux = env->insn_aux_data;
  2013		struct bpf_loop *loop = aux[bpf_loop_at_index(env, latch->insn_idx)].loop;
  2014		struct scev *scev = env->scev;
  2015		struct scev_value initial_val, step_val, bound_val;
  2016		u64 step, diff, bound, initial, backedge_taken_count;
  2017		u8 op = latch->op;
  2018		bool up, down;
  2019	
  2020		if (!eval_expr(env, scev, st, latch->base_expr, &initial_val) ||
  2021		    !eval_expr(env, scev, st, latch->step_expr, &step_val) ||
  2022		    !eval_expr(env, scev, st, latch->bound_expr, &bound_val))
  2023			return false;
  2024	
  2025		if (step_val.ptr_reg >= 0) {
  2026			if (env->log.level & BPF_LOG_LEVEL2) {
  2027				bpf_log(&env->log, "scev: latch step is a pointer ");
  2028				log_scev_value(env, st, &step_val);
  2029				bpf_log(&env->log, "\n");
  2030			}
  2031			return false;
  2032		}
  2033		if (!scev_value_compatible(env, st, &initial_val, &bound_val))
  2034			return false;
  2035	
  2036		initial = initial_val.value;
  2037		step = step_val.value;
  2038		bound = bound_val.value;
  2039	
  2040		if (step == 0)
  2041			return false;
  2042		down = (s64)step < 0;
  2043		up = (s64)step > 0;
  2044		diff = bound - initial;
  2045		switch (op) {
  2046		case BPF_JLT:
  2047			/*
  2048			 * E.g.: 3 + 2*i < 7 ⇔ 2*i < 4 ⇔ i ∈ [0,1].
  2049			 * Here the inequality describes a set of values `i` might take
  2050			 * while the latch condition remains true (the backedge is taken).
  2051			 * The backedge_taken_count is the size of this set.
  2052			 */
  2053			if (/*
  2054			     * If the condition is initially true, decreasing values won't
  2055			     * change that without underflow. If the condition is initially false,
  2056			     * the main pass would do a single iteration anyway.
  2057			     */
  2058			    down ||
  2059			    /* Is the latch condition false on the first iteration? */
  2060			    initial >= bound ||
  2061			    /* Count iterations satisfying the strict inequality, including i=0. */
> 2062			    check_add_overflow((diff - 1) / step, 1, &backedge_taken_count) ||
  2063			    /*
  2064			     * Check if the last iteration overflows the counter:
  2065			     *   initial + backedge_taken_count * step > U64_MAX
  2066			     */
> 2067			    backedge_taken_count > (U64_MAX - initial) / step)
  2068				return false;
  2069			break;
  2070		case BPF_JLE:
  2071			/* E.g.: 3 + 2*i ≤ 7 ⇔ 2*i ≤ 4 ⇔ i ∈ [0,1,2]. */
  2072			if (down || initial > bound ||
  2073			    /* Count iterations satisfying the non-strict inequality. */
  2074			    check_add_overflow(diff / step, 1, &backedge_taken_count) ||
  2075			    backedge_taken_count > (U64_MAX - initial) / step)
  2076				return false;
  2077			break;
  2078		case BPF_JGT:
  2079			/* E.g.: 7 - 2*i > 3 ⇔ 2*i < 4 ⇔ i ∈ [0,1]. */
  2080			if (up || initial <= bound ||
  2081			    check_add_overflow((-diff - 1) / -step, 1, &backedge_taken_count) ||
  2082			    /*
  2083			     * The last iteration underflows the counter if:
  2084			     *   initial + backedge_taken_count * step < 0 ⇔
  2085			     *             backedge_taken_count * step < -initial ⇔
  2086			     *                    backedge_taken_count > initial / -step
  2087			     * (direction flips because step < 0)
  2088			     */
  2089			    backedge_taken_count > initial / -step)
  2090				return false;
  2091			break;
  2092		case BPF_JGE:
  2093			/* E.g.: 7 - 2*i ≥ 3 ⇔ 2*i ≤ 4 ⇔ i ∈ [0,1,2]. */
  2094			if (up || initial < bound ||
  2095			    check_add_overflow(-diff / -step, 1, &backedge_taken_count) ||
  2096			    backedge_taken_count > initial / -step)
  2097				return false;
  2098			break;
  2099		case BPF_JSLT:
  2100			if (down || (s64)initial >= (s64)bound ||
  2101			    check_add_overflow((diff - 1) / step, 1, &backedge_taken_count) ||
  2102			    /*
  2103			     * Check if the last iteration overflows the signed counter:
  2104			     *   (s64)initial + backedge_taken_count * step > S64_MAX
  2105			     */
  2106			    backedge_taken_count > ((u64)S64_MAX - initial) / step)
  2107				return false;
  2108			break;
  2109		case BPF_JSLE:
  2110			if (down || (s64)initial > (s64)bound ||
  2111			    check_add_overflow(diff / step, 1, &backedge_taken_count) ||
  2112			    backedge_taken_count > ((u64)S64_MAX - initial) / step)
  2113				return false;
  2114			break;
  2115		case BPF_JSGT:
  2116			if (up || (s64)initial <= (s64)bound ||
  2117			    check_add_overflow((-diff - 1) / -step, 1, &backedge_taken_count) ||
  2118			    /*
  2119			     * The last iteration underflows the signed counter if:
  2120			     *   (s64)initial + backedge_taken_count * step < S64_MIN ⇔
  2121			     *                  backedge_taken_count * step < S64_MIN - (s64)initial ⇔
  2122			     *                         backedge_taken_count > initial - (u64)S64_MIN / -step
  2123			     *	 (direction flips because step < 0)
  2124			     */
  2125			    backedge_taken_count > (initial - (u64)S64_MIN) / -step)
  2126				return false;
  2127			break;
  2128		case BPF_JSGE:
  2129			if (up || (s64)initial < (s64)bound ||
  2130			    check_add_overflow(-diff / -step, 1, &backedge_taken_count) ||
  2131			    backedge_taken_count > (initial - (u64)S64_MIN) / -step)
  2132				return false;
  2133			break;
  2134		case BPF_JNE:
  2135			/*
  2136			 * For a decreasing counter flip the diff and step:
  2137			 *   7 - 2*i ≠ 3 ⇔ 2*i ≠ 7 - 3.
  2138			 */
  2139			diff = down ? -diff : diff;
  2140			step = down ? -step : step;
  2141			if (diff == 0 || diff % step)
  2142				return false;
  2143			backedge_taken_count = diff / step;
  2144			break;
  2145		default:
  2146			return false;
  2147		}
  2148	
  2149		/*
  2150		 * max_header_count is u32 and U32_MAX means "infinite",
  2151		 * check to avoid overflow below.
  2152		 */
  2153		if (backedge_taken_count >= U32_MAX - 1)
  2154			return false;
  2155	
  2156		/* The header executes once on entry and once for each taken backedge, hence +1. */
  2157		iters->max_header_count = backedge_taken_count + 1;
  2158		/*
  2159		 * The latch is a conditional jump with one jump target exiting the loop.
  2160		 * Linear latch is matched only if the loop has a single backedge.
  2161		 * The loop still, however can have multiple exits.
  2162		 * In such case, conservatively assume that non-latch exit can happen
  2163		 * at any iteration, thus setting minimal number of iterations as 0.
  2164		 */
  2165		iters->min_header_count = loop->exits_cnt == 1 ? iters->max_header_count : 0;
  2166		return true;
  2167	}
  2168	

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
