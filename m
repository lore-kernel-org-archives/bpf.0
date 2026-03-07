Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 601A033556E;
	Sat,  7 Mar 2026 17:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772904239; cv=none; b=JqK7oIi36ZdF2U5xtWM7UVgilBc4Z0juO8VFrjtfCweJR4VQ19WnUhx2xr+7G7c4i0lwCqxU62Q9tkbAikSPW+SWQOr7dkrqj2bWh1SPtmcPffa1CT2esMQCm4OXACLrthuvxjXQfZsXsKsWndEx57HHtSZluP1CQ0Wgz4M5zrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772904239; c=relaxed/simple;
	bh=1mNp8Car79u1dPnTpl5JYKumOp3Byg/lTv+u5frcbbY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c7U/pim3VsC9k7ovUsvsmUWYwK1NMf3X6h5qX5OspvsUsLlwRCwLq65CdZSaxCCJYLuLwd5XoSXbe5+XSpg390rhAs35gZwtBp2auraV7ZTIGA1VhzxuHy21MmVhm/6Qab78/wgSFp60eFyE1qxyeaw9fRYTHoXUa7fqIHsCU0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mmdE6qHz; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mmdE6qHz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772904237; x=1804440237;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1mNp8Car79u1dPnTpl5JYKumOp3Byg/lTv+u5frcbbY=;
  b=mmdE6qHzHmUvwFWUcgnbNj3LR/hj5g2IKeShb1Wf8TbHkgUC+QJVK5Uw
   niBh3Swz2T8RPbG+5Lz+KwJeijk+js3nfwZKjnnSCDzZSJ0AmWkRvkvjx
   E1LFYZTl8Hr1Byb/efFCw7e1VBrQQOZhpb90DNOudT6dzdBnCXMMsdl7Z
   i3ldB0b+tPadqy40bSOKv5aHPpAo1liyNDploLjhAWJeGD6xoCOkL4Ryg
   v2ycVwt3Xmig+eNYsTy04ZXtN9FMOc6U6Av7xc+ZKM85beKG0QDYmKM1O
   w5W07tvlnnhZeyyPfiShqS9RX8pM+032YT23kaDhXWxGS9hM395FyMSJ0
   g==;
X-CSE-ConnectionGUID: /sRdY2+6QSix/LVLMZoMcA==
X-CSE-MsgGUID: rlSuUb4eQj2MKNQiEIPaIQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11722"; a="73890278"
X-IronPort-AV: E=Sophos;i="6.23,107,1770624000"; 
   d="scan'208";a="73890278"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2026 09:23:56 -0800
X-CSE-ConnectionGUID: eRuBoaDXQkGBhP43tBdBuA==
X-CSE-MsgGUID: YKXOwP8STeeImnVsW+QVOA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,107,1770624000"; 
   d="scan'208";a="257234263"
Received: from lkp-server01.sh.intel.com (HELO 058beb05654c) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 07 Mar 2026 09:23:48 -0800
Received: from kbuild by 058beb05654c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vyvNP-000000002Nj-3cnD;
	Sat, 07 Mar 2026 17:23:43 +0000
Date: Sun, 8 Mar 2026 01:23:16 +0800
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
Message-ID: <202603080126.Lh5uvLLo-lkp@intel.com>
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
config: riscv-randconfig-002-20260307 (https://download.01.org/0day-ci/archive/20260308/202603080126.Lh5uvLLo-lkp@intel.com/config)
compiler: clang version 23.0.0git (https://github.com/llvm/llvm-project c32caeec8158d634bb71ab8911a6031248b9fc47)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260308/202603080126.Lh5uvLLo-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603080126.Lh5uvLLo-lkp@intel.com/

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
