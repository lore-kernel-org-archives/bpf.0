Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BFBC33438F;
	Sat,  7 Mar 2026 17:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772903359; cv=none; b=rupIinPxBWdt78dUamitWKm8bWvRtz2IvqrnoX+9+92ysr64/LmJzTsjS6oGPCrTOgznj8XD2iPYDc1dx/cTpLSeVVtLyHv+vqZuWBNrHeWX3sUyyHPqVbIxm+DFeIPebtyq9pZJNuWqCDFEMolRLDwvDST6Efo6XbTEyqlyUrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772903359; c=relaxed/simple;
	bh=KHFeNtfK3xhUslDy7/86IoviHngY4/bdrX3PnhqPzK4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nRnxAswgeBU5i1HP7X69aQy2A/09NWspKLPBFXdT58mD+pWhqVxIE1yo3DRiRyMsk4xyLTS/dM+pOeo1COvyOXLO4bFwqAYQaPf6JNWwqp643R1+vdY4VekIUn5rewyJY+buAWcxTr/0BCGPGdUtevJa0TE1If5WdZ+FjmOStDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HeLwiEco; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HeLwiEco"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772903358; x=1804439358;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=KHFeNtfK3xhUslDy7/86IoviHngY4/bdrX3PnhqPzK4=;
  b=HeLwiEcog0Cvpg1w2J5IIH5lEstfJ+5Wm3mhUF6ISakxx3vhTiCXRZH2
   09ngW/zvdYEvg9ehHD6ZFOmW96af4mZ/zF0bmgbGdy7biB1TELNM0Ghgd
   9H2qjMHrIn/rGh6gmQYkGh/f/7WvCJ2574JJu/MikQc3ca8uDRx3RDw/O
   SRGVoYT904STPmbYiccKpXI4ySVBRAgBhvC7eHZN1EcWLtAKbJIH6z9Mg
   4hr6QYNPONfZPLeTRphmkGSxcwmY1ZqcYe7Uie4HLPhp+kvP2N2wc0wHV
   aRTIqSt2ErE+CooqBlP1Lcidc5cMwo1V7Phk5H2KK8FRbYRPbosc3ybD3
   Q==;
X-CSE-ConnectionGUID: pmJDpWF/Qj+crLQxov2QNQ==
X-CSE-MsgGUID: BkTub3/iTaCxPxb6EPXvWw==
X-IronPort-AV: E=McAfee;i="6800,10657,11722"; a="85461423"
X-IronPort-AV: E=Sophos;i="6.23,107,1770624000"; 
   d="scan'208";a="85461423"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2026 09:09:17 -0800
X-CSE-ConnectionGUID: LcqLTwAYSC63ZKLMJFHkaA==
X-CSE-MsgGUID: hZFPj6DbQtOdHbBDtB5gYQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,107,1770624000"; 
   d="scan'208";a="222070247"
Received: from igk-lkp-server01.igk.intel.com (HELO 9958d990ccf2) ([10.211.93.152])
  by fmviesa004.fm.intel.com with ESMTP; 07 Mar 2026 09:09:11 -0800
Received: from kbuild by 9958d990ccf2 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vyv9J-000000002Wf-1GSP;
	Sat, 07 Mar 2026 17:09:09 +0000
Date: Sat, 7 Mar 2026 18:08:13 +0100
From: kernel test robot <lkp@intel.com>
To: Xu Kuohai <xukuohai@huaweicloud.com>, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Alexei Starovoitov <ast@kernel.org>,
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
Message-ID: <202603071836.igZbCyrE-lkp@intel.com>
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
config: x86_64-kexec (https://download.01.org/0day-ci/archive/20260307/202603071836.igZbCyrE-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260307/202603071836.igZbCyrE-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603071836.igZbCyrE-lkp@intel.com/

All errors (new ones prefixed by >>):

>> kernel/bpf/verifier.c:23100:9: error: call to undeclared function 'bpf_jit_blind_constants'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
    23100 |                 err = bpf_jit_blind_constants(env);
          |                       ^
   1 error generated.


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
