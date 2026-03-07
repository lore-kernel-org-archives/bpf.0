Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7737C330659;
	Sat,  7 Mar 2026 17:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772904238; cv=none; b=q0ByU6YAejMsCeFns5pRJlzxnnI+JGaajttzohFbVFgR+4e0BHkJ/yLuNECbhA3Ad9Oki1Bght2qMteRsZOVx9dEkRKxQ8W9J/XiqYiqqbpYtmh/5jmx4gTuCGTie2apsk3YIidBvbdwD50TrD2ATye2ta3tU5EhU73F3Sk2Bvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772904238; c=relaxed/simple;
	bh=old0xdZwgrJsWukz3od9fCjMaLFlhCHt0yZChfgcuCA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gjHxNFk5zgvYT4s370UATQ2Z7kkQWAWUtdLTYKs2laPJ2Hr2zLr14xYsKo9cuP74zhkj06ja5JFwXYoSwc/ERF/la3eL6/9HpEbg9r+J8eDZijNYT3RX7lHYXE08IETY6KmEGhQjwXOMVT4nGOraZyHXaIXmnH+St9TR/ggFq8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gAKoZza+; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gAKoZza+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772904234; x=1804440234;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=old0xdZwgrJsWukz3od9fCjMaLFlhCHt0yZChfgcuCA=;
  b=gAKoZza+zBg8QfyqLBiZGwfLxF+b6V6NMWMKLVqTwM0v4HLUhobKcXyl
   LLMb/nteujf2U4c3+wp7tu3b3DZw6AKOz09p0CWQMehV2iH4m8PyeFxIa
   iV85sBLof6TJJ69GdiMol8AeeoiVAxDPMyxaMWWpkPtU4Gzon3bvCfBO2
   Zf84u5S9duuwCDICR6N+XjK02DMLbbIOhRAHuBb0k3sZaSDRbc0q94/vG
   gyFrVENYfwXzweBzf1SCT7mLXyuIwu0+ZvFemyb36PH5KgXh2JQ6fdwJn
   gYiX1x0y1log7K8TNVKYynIeFPXWHJXn97mzPi/gdVVTTdX7pNB4RWllK
   g==;
X-CSE-ConnectionGUID: 8oIcN3/5Sl2owFLWsx4r3A==
X-CSE-MsgGUID: za7Led9zSMmISikTUuDyWg==
X-IronPort-AV: E=McAfee;i="6800,10657,11722"; a="73183961"
X-IronPort-AV: E=Sophos;i="6.23,107,1770624000"; 
   d="scan'208";a="73183961"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2026 09:23:53 -0800
X-CSE-ConnectionGUID: /k0cv0owQL6cuijTy6RHUQ==
X-CSE-MsgGUID: s1luV+E7QoeRiJ16/xAD0g==
X-ExtLoop1: 1
Received: from lkp-server01.sh.intel.com (HELO 058beb05654c) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 07 Mar 2026 09:23:47 -0800
Received: from kbuild by 058beb05654c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vyvNP-000000002Nh-3Gha;
	Sat, 07 Mar 2026 17:23:43 +0000
Date: Sun, 8 Mar 2026 01:23:15 +0800
From: kernel test robot <lkp@intel.com>
To: Xu Kuohai <xukuohai@huaweicloud.com>, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: oe-kbuild-all@lists.linux.dev, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	Puranjay Mohan <puranjay@kernel.org>,
	Anton Protopopov <a.s.protopopov@gmail.com>,
	Shahab Vahedi <list+bpf@vahedi.org>,
	Russell King <linux@armlinux.org.uk>,
	Tiezhu Yang <yangtiezhu@loongson.cn>,
	Hengqi Chen <hengqi.chen@gmail.com>,
	Johan Almbladh <johan.almbladh@anyfinetworks.com>,
	Paul Burton <paulburton@kernel.org>,
	Hari Bathini <hbathini@linux.ibm.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Naveen N Rao <naveen@kernel.org>,
	Luke Nelson <luke.r.nels@gmail.com>, Xi Wang <xi.wang@gmail.com>,
	=?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>,
	Pu Lehui <pulehui@huawei.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	"David S . Miller" <davem@davemloft.net>,
	Wang YanQing <udknight@gmail.com>
Subject: Re: [bpf-next v7 1/5] bpf: Move constants blinding from JIT to
 verifier
Message-ID: <202603080148.tjqluX6P-lkp@intel.com>
References: <20260307103949.2340104-2-xukuohai@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260307103949.2340104-2-xukuohai@huaweicloud.com>

Hi Xu,

kernel test robot noticed the following build errors:

[auto build test ERROR on bpf-next/master]

url:    https://github.com/intel-lab-lkp/linux/commits/Xu-Kuohai/bpf-Move-constants-blinding-from-JIT-to-verifier/20260307-181538
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
patch link:    https://lore.kernel.org/r/20260307103949.2340104-2-xukuohai%40huaweicloud.com
patch subject: [bpf-next v7 1/5] bpf: Move constants blinding from JIT to verifier
config: m68k-defconfig (https://download.01.org/0day-ci/archive/20260308/202603080148.tjqluX6P-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 15.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260308/202603080148.tjqluX6P-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603080148.tjqluX6P-lkp@intel.com/

All errors (new ones prefixed by >>):

   kernel/bpf/verifier.c: In function 'fixup_call_args':
>> kernel/bpf/verifier.c:23100:23: error: implicit declaration of function 'bpf_jit_blind_constants' [-Wimplicit-function-declaration]
   23100 |                 err = bpf_jit_blind_constants(env);
         |                       ^~~~~~~~~~~~~~~~~~~~~~~


vim +/bpf_jit_blind_constants +23100 kernel/bpf/verifier.c

 23087	
 23088	static int fixup_call_args(struct bpf_verifier_env *env)
 23089	{
 23090	#ifndef CONFIG_BPF_JIT_ALWAYS_ON
 23091		struct bpf_prog *prog = env->prog;
 23092		struct bpf_insn *insn = prog->insnsi;
 23093		bool has_kfunc_call = bpf_prog_has_kfunc_call(prog);
 23094		int i, depth;
 23095	#endif
 23096		int err = 0;
 23097	
 23098		if (env->prog->jit_requested &&
 23099		    !bpf_prog_is_offloaded(env->prog->aux)) {
 23100			err = bpf_jit_blind_constants(env);
 23101			if (err)
 23102				return err;
 23103			err = jit_subprogs(env);
 23104			if (err == 0)
 23105				return 0;
 23106			if (err == -EFAULT)
 23107				return err;
 23108		}
 23109	#ifndef CONFIG_BPF_JIT_ALWAYS_ON
 23110		if (has_kfunc_call) {
 23111			verbose(env, "calling kernel functions are not allowed in non-JITed programs\n");
 23112			return -EINVAL;
 23113		}
 23114		if (env->subprog_cnt > 1 && env->prog->aux->tail_call_reachable) {
 23115			/* When JIT fails the progs with bpf2bpf calls and tail_calls
 23116			 * have to be rejected, since interpreter doesn't support them yet.
 23117			 */
 23118			verbose(env, "tail_calls are not allowed in non-JITed programs with bpf-to-bpf calls\n");
 23119			return -EINVAL;
 23120		}
 23121		for (i = 0; i < prog->len; i++, insn++) {
 23122			if (bpf_pseudo_func(insn)) {
 23123				/* When JIT fails the progs with callback calls
 23124				 * have to be rejected, since interpreter doesn't support them yet.
 23125				 */
 23126				verbose(env, "callbacks are not allowed in non-JITed programs\n");
 23127				return -EINVAL;
 23128			}
 23129	
 23130			if (!bpf_pseudo_call(insn))
 23131				continue;
 23132			depth = get_callee_stack_depth(env, insn, i);
 23133			if (depth < 0)
 23134				return depth;
 23135			bpf_patch_call_args(insn, depth);
 23136		}
 23137		err = 0;
 23138	#endif
 23139		return err;
 23140	}
 23141	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
