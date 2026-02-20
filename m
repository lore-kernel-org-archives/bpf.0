Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EB362D1911;
	Fri, 20 Feb 2026 21:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771621559; cv=none; b=KutcbZWSIXevwutxSFPiJd9XDUa9/QVtDQA+gwUnDN3E6Cws0DFtdHBm9ph7sAR0S5odpJsak+x98cnzLisSdQ4KgS9D2XHDuwVgzhvljh2hMRE01e9TwLWghMpy0BSYsFaHmhnVlBAgt8PWoZkUYhi/83msdmpr4F6EK+2ahi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771621559; c=relaxed/simple;
	bh=mFptfznoJXpcR+E0Htj4dfRl3M076Dua632A3J4rRLo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BR57mdnqAMUHApPJNSMR2jsUOEYUbfyZNZOGf925F0WNQF2oQbXrRUs6auP00P7zH5MpRCEiyYDsBz1dv0wPBha1S3M0tBw8UuhhwA6UZwzoGQTaNmNaLFDc087KOuFAVYs+CRFILbkPwgMeZuaEWP6WnE1wriednzpsOK76Wo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PpA0g1er; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PpA0g1er"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771621558; x=1803157558;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=mFptfznoJXpcR+E0Htj4dfRl3M076Dua632A3J4rRLo=;
  b=PpA0g1eryY46G+QGE1Nb6AQqb57cYLadKs4I9oChRfLyOKT50dNQi+ob
   MqqnPMGfdhPq46gl8/wRGFTUFum7ndlHOxn4SGtDuL0TYC0OKUWqCKAab
   e0d50ushme9tl0UiCAhNeVgGh5nd6mLwyovEZevNMlCSlEIsfholj1ert
   L2vqlB6G9x6vKLCYlI253Y8nN1n6frJuxQpWfVnZktbIWkNZm6mUrvmXO
   pS3DRY4y1WIWpch1kySljQpU2m5vh7g6SqMsn45xwohEKT4aFQ7pBTk2Q
   BWyMAIz1v1kz4oKSq6L6ZtuVuJZUiUf3Yj6UoDxORMcd/+/k4+zDHf+cy
   A==;
X-CSE-ConnectionGUID: PN+V1QxfQpq+BQ6wqOArGg==
X-CSE-MsgGUID: pOwxZhNOSLKzSMA5KdCC7g==
X-IronPort-AV: E=McAfee;i="6800,10657,11707"; a="90126666"
X-IronPort-AV: E=Sophos;i="6.21,302,1763452800"; 
   d="scan'208";a="90126666"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2026 13:05:57 -0800
X-CSE-ConnectionGUID: 9qyvXURCRT6+xJzCVaBkrQ==
X-CSE-MsgGUID: sh2fQiEwRdaYHZkL9Wzpwg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,302,1763452800"; 
   d="scan'208";a="213470627"
Received: from igk-lkp-server01.igk.intel.com (HELO e5404a91d123) ([10.211.93.152])
  by fmviesa010.fm.intel.com with ESMTP; 20 Feb 2026 13:05:54 -0800
Received: from kbuild by e5404a91d123 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vtXh9-000000004H3-32SI;
	Fri, 20 Feb 2026 21:05:51 +0000
Date: Fri, 20 Feb 2026 22:05:48 +0100
From: kernel test robot <lkp@intel.com>
To: Jiri Olsa <jolsa@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
	Menglong Dong <menglong8.dong@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH bpf-next 04/17] bpf: Add struct bpf_tramp_node object
Message-ID: <202602202212.yC5wLunx-lkp@intel.com>
References: <20260220100649.628307-5-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260220100649.628307-5-jolsa@kernel.org>

Hi Jiri,

kernel test robot noticed the following build errors:

[auto build test ERROR on bpf-next/master]

url:    https://github.com/intel-lab-lkp/linux/commits/Jiri-Olsa/ftrace-Add-ftrace_hash_count-function/20260220-181324
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
patch link:    https://lore.kernel.org/r/20260220100649.628307-5-jolsa%40kernel.org
patch subject: [PATCH bpf-next 04/17] bpf: Add struct bpf_tramp_node object
config: riscv-allnoconfig-bpf (https://download.01.org/0day-ci/archive/20260220/202602202212.yC5wLunx-lkp@intel.com/config)
compiler: riscv64-linux-gnu-gcc (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260220/202602202212.yC5wLunx-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202602202212.yC5wLunx-lkp@intel.com/

All errors (new ones prefixed by >>):

   arch/riscv/net/bpf_jit_comp64.c: In function 'invoke_bpf_prog':
>> arch/riscv/net/bpf_jit_comp64.c:944:14: error: 'struct bpf_tramp_link' has no member named 'cookie'
     944 |         if (l->cookie)
         |              ^~
   arch/riscv/net/bpf_jit_comp64.c:945:79: error: 'struct bpf_tramp_link' has no member named 'cookie'
     945 |                 emit_store_stack_imm64(RV_REG_T1, -run_ctx_off + cookie_off, l->cookie, ctx);
         |                                                                               ^~
   arch/riscv/net/bpf_jit_comp64.c: At top level:
   arch/riscv/net/bpf_jit_comp64.c:999:30: warning: 'struct bpf_tramp_links' declared inside parameter list will not be visible outside of this definition or declaration
     999 | static int invoke_bpf(struct bpf_tramp_links *tl, int args_off, int retval_off,
         |                              ^~~~~~~~~~~~~~~
   arch/riscv/net/bpf_jit_comp64.c: In function 'invoke_bpf':
>> arch/riscv/net/bpf_jit_comp64.c:1005:27: error: invalid use of undefined type 'struct bpf_tramp_links'
    1005 |         for (i = 0; i < tl->nr_links; i++) {
         |                           ^~
   arch/riscv/net/bpf_jit_comp64.c:1008:53: error: invalid use of undefined type 'struct bpf_tramp_links'
    1008 |                 if (bpf_prog_calls_session_cookie(tl->links[i])) {
         |                                                     ^~
   arch/riscv/net/bpf_jit_comp64.c:1014:41: error: invalid use of undefined type 'struct bpf_tramp_links'
    1014 |                 err = invoke_bpf_prog(tl->links[i], args_off, retval_off, run_ctx_off,
         |                                         ^~
   arch/riscv/net/bpf_jit_comp64.c: At top level:
   arch/riscv/net/bpf_jit_comp64.c:1024:49: warning: 'struct bpf_tramp_links' declared inside parameter list will not be visible outside of this definition or declaration
    1024 |                                          struct bpf_tramp_links *tlinks,
         |                                                 ^~~~~~~~~~~~~~~
   arch/riscv/net/bpf_jit_comp64.c: In function '__arch_prepare_bpf_trampoline':
   arch/riscv/net/bpf_jit_comp64.c:1033:49: error: invalid use of undefined type 'struct bpf_tramp_links'
    1033 |         struct bpf_tramp_links *fentry = &tlinks[BPF_TRAMP_FENTRY];
         |                                                 ^
   arch/riscv/net/bpf_jit_comp64.c:1034:48: error: invalid use of undefined type 'struct bpf_tramp_links'
    1034 |         struct bpf_tramp_links *fexit = &tlinks[BPF_TRAMP_FEXIT];
         |                                                ^
   arch/riscv/net/bpf_jit_comp64.c:1035:51: error: invalid use of undefined type 'struct bpf_tramp_links'
    1035 |         struct bpf_tramp_links *fmod_ret = &tlinks[BPF_TRAMP_MODIFY_RETURN];
         |                                                   ^
   arch/riscv/net/bpf_jit_comp64.c:1118:46: error: passing argument 1 of 'bpf_fsession_cookie_cnt' from incompatible pointer type [-Wincompatible-pointer-types]
    1118 |         cookie_cnt = bpf_fsession_cookie_cnt(tlinks);
         |                                              ^~~~~~
         |                                              |
         |                                              struct bpf_tramp_links *
   In file included from arch/riscv/net/bpf_jit_comp64.c:9:
   ./include/linux/bpf.h:2207:67: note: expected 'struct bpf_tramp_nodes *' but argument is of type 'struct bpf_tramp_links *'
    2207 | static inline int bpf_fsession_cookie_cnt(struct bpf_tramp_nodes *nodes)
         |                                           ~~~~~~~~~~~~~~~~~~~~~~~~^~~~~
   arch/riscv/net/bpf_jit_comp64.c:1175:30: error: passing argument 1 of 'bpf_fsession_cnt' from incompatible pointer type [-Wincompatible-pointer-types]
    1175 |         if (bpf_fsession_cnt(tlinks)) {
         |                              ^~~~~~
         |                              |
         |                              struct bpf_tramp_links *
   ./include/linux/bpf.h:2189:60: note: expected 'struct bpf_tramp_nodes *' but argument is of type 'struct bpf_tramp_links *'
    2189 | static inline int bpf_fsession_cnt(struct bpf_tramp_nodes *nodes)
         |                                    ~~~~~~~~~~~~~~~~~~~~~~~~^~~~~
   arch/riscv/net/bpf_jit_comp64.c:1190:19: error: invalid use of undefined type 'struct bpf_tramp_links'
    1190 |         if (fentry->nr_links) {
         |                   ^~
   arch/riscv/net/bpf_jit_comp64.c:1191:34: error: passing argument 1 of 'invoke_bpf' from incompatible pointer type [-Wincompatible-pointer-types]
    1191 |                 ret = invoke_bpf(fentry, args_off, retval_off, run_ctx_off, func_meta_off,
         |                                  ^~~~~~
         |                                  |
         |                                  struct bpf_tramp_links *
   arch/riscv/net/bpf_jit_comp64.c:999:47: note: expected 'struct bpf_tramp_links *' but argument is of type 'struct bpf_tramp_links *'
     999 | static int invoke_bpf(struct bpf_tramp_links *tl, int args_off, int retval_off,
         |                       ~~~~~~~~~~~~~~~~~~~~~~~~^~
   arch/riscv/net/bpf_jit_comp64.c:1197:21: error: invalid use of undefined type 'struct bpf_tramp_links'
    1197 |         if (fmod_ret->nr_links) {
         |                     ^~
   In file included from ./include/linux/workqueue.h:9,
                    from ./include/linux/bpf.h:11:
   arch/riscv/net/bpf_jit_comp64.c:1198:48: error: invalid use of undefined type 'struct bpf_tramp_links'
    1198 |                 branches_off = kcalloc(fmod_ret->nr_links, sizeof(int), GFP_KERNEL);
         |                                                ^~
   ./include/linux/alloc_tag.h:251:16: note: in definition of macro 'alloc_hooks_tag'
     251 |         typeof(_do_alloc) _res;                                         \
         |                ^~~~~~~~~
   ./include/linux/slab.h:1115:49: note: in expansion of macro 'alloc_hooks'
    1115 | #define kmalloc_array(...)                      alloc_hooks(kmalloc_array_noprof(__VA_ARGS__))
         |                                                 ^~~~~~~~~~~
   ./include/linux/slab.h:1154:41: note: in expansion of macro 'kmalloc_array'
    1154 | #define kcalloc(n, size, flags)         kmalloc_array(n, size, (flags) | __GFP_ZERO)
         |                                         ^~~~~~~~~~~~~
   arch/riscv/net/bpf_jit_comp64.c:1198:32: note: in expansion of macro 'kcalloc'
    1198 |                 branches_off = kcalloc(fmod_ret->nr_links, sizeof(int), GFP_KERNEL);
         |                                ^~~~~~~
   arch/riscv/net/bpf_jit_comp64.c:1198:48: error: invalid use of undefined type 'struct bpf_tramp_links'
    1198 |                 branches_off = kcalloc(fmod_ret->nr_links, sizeof(int), GFP_KERNEL);
         |                                                ^~
   ./include/linux/alloc_tag.h:255:24: note: in definition of macro 'alloc_hooks_tag'
     255 |                 _res = _do_alloc;                                       \
         |                        ^~~~~~~~~
   ./include/linux/slab.h:1115:49: note: in expansion of macro 'alloc_hooks'
    1115 | #define kmalloc_array(...)                      alloc_hooks(kmalloc_array_noprof(__VA_ARGS__))
         |                                                 ^~~~~~~~~~~
   ./include/linux/slab.h:1154:41: note: in expansion of macro 'kmalloc_array'
    1154 | #define kcalloc(n, size, flags)         kmalloc_array(n, size, (flags) | __GFP_ZERO)
         |                                         ^~~~~~~~~~~~~
   arch/riscv/net/bpf_jit_comp64.c:1198:32: note: in expansion of macro 'kcalloc'
    1198 |                 branches_off = kcalloc(fmod_ret->nr_links, sizeof(int), GFP_KERNEL);
         |                                ^~~~~~~
   arch/riscv/net/bpf_jit_comp64.c:1198:48: error: invalid use of undefined type 'struct bpf_tramp_links'
    1198 |                 branches_off = kcalloc(fmod_ret->nr_links, sizeof(int), GFP_KERNEL);
         |                                                ^~
   ./include/linux/alloc_tag.h:258:24: note: in definition of macro 'alloc_hooks_tag'
     258 |                 _res = _do_alloc;                                       \
         |                        ^~~~~~~~~
   ./include/linux/slab.h:1115:49: note: in expansion of macro 'alloc_hooks'
    1115 | #define kmalloc_array(...)                      alloc_hooks(kmalloc_array_noprof(__VA_ARGS__))
         |                                                 ^~~~~~~~~~~
   ./include/linux/slab.h:1154:41: note: in expansion of macro 'kmalloc_array'
    1154 | #define kcalloc(n, size, flags)         kmalloc_array(n, size, (flags) | __GFP_ZERO)
         |                                         ^~~~~~~~~~~~~
   arch/riscv/net/bpf_jit_comp64.c:1198:32: note: in expansion of macro 'kcalloc'
    1198 |                 branches_off = kcalloc(fmod_ret->nr_links, sizeof(int), GFP_KERNEL);
         |                                ^~~~~~~


vim +944 arch/riscv/net/bpf_jit_comp64.c

93fd420d71beed Menglong Dong 2026-02-08   936  
49b5e77ae3e214 Pu Lehui      2023-02-15   937  static int invoke_bpf_prog(struct bpf_tramp_link *l, int args_off, int retval_off,
49b5e77ae3e214 Pu Lehui      2023-02-15   938  			   int run_ctx_off, bool save_ret, struct rv_jit_context *ctx)
49b5e77ae3e214 Pu Lehui      2023-02-15   939  {
49b5e77ae3e214 Pu Lehui      2023-02-15   940  	int ret, branch_off;
49b5e77ae3e214 Pu Lehui      2023-02-15   941  	struct bpf_prog *p = l->link.prog;
49b5e77ae3e214 Pu Lehui      2023-02-15   942  	int cookie_off = offsetof(struct bpf_tramp_run_ctx, bpf_cookie);
49b5e77ae3e214 Pu Lehui      2023-02-15   943  
93fd420d71beed Menglong Dong 2026-02-08  @944  	if (l->cookie)
93fd420d71beed Menglong Dong 2026-02-08   945  		emit_store_stack_imm64(RV_REG_T1, -run_ctx_off + cookie_off, l->cookie, ctx);
93fd420d71beed Menglong Dong 2026-02-08   946  	else
49b5e77ae3e214 Pu Lehui      2023-02-15   947  		emit_sd(RV_REG_FP, -run_ctx_off + cookie_off, RV_REG_ZERO, ctx);
49b5e77ae3e214 Pu Lehui      2023-02-15   948  
49b5e77ae3e214 Pu Lehui      2023-02-15   949  	/* arg1: prog */
49b5e77ae3e214 Pu Lehui      2023-02-15   950  	emit_imm(RV_REG_A0, (const s64)p, ctx);
49b5e77ae3e214 Pu Lehui      2023-02-15   951  	/* arg2: &run_ctx */
49b5e77ae3e214 Pu Lehui      2023-02-15   952  	emit_addi(RV_REG_A1, RV_REG_FP, -run_ctx_off, ctx);
49b5e77ae3e214 Pu Lehui      2023-02-15   953  	ret = emit_call((const u64)bpf_trampoline_enter(p), true, ctx);
49b5e77ae3e214 Pu Lehui      2023-02-15   954  	if (ret)
49b5e77ae3e214 Pu Lehui      2023-02-15   955  		return ret;
49b5e77ae3e214 Pu Lehui      2023-02-15   956  
10541b374aa05c Xu Kuohai     2024-04-16   957  	/* store prog start time */
10541b374aa05c Xu Kuohai     2024-04-16   958  	emit_mv(RV_REG_S1, RV_REG_A0, ctx);
10541b374aa05c Xu Kuohai     2024-04-16   959  
49b5e77ae3e214 Pu Lehui      2023-02-15   960  	/* if (__bpf_prog_enter(prog) == 0)
49b5e77ae3e214 Pu Lehui      2023-02-15   961  	 *	goto skip_exec_of_prog;
49b5e77ae3e214 Pu Lehui      2023-02-15   962  	 */
49b5e77ae3e214 Pu Lehui      2023-02-15   963  	branch_off = ctx->ninsns;
49b5e77ae3e214 Pu Lehui      2023-02-15   964  	/* nop reserved for conditional jump */
49b5e77ae3e214 Pu Lehui      2023-02-15   965  	emit(rv_nop(), ctx);
49b5e77ae3e214 Pu Lehui      2023-02-15   966  
49b5e77ae3e214 Pu Lehui      2023-02-15   967  	/* arg1: &args_off */
49b5e77ae3e214 Pu Lehui      2023-02-15   968  	emit_addi(RV_REG_A0, RV_REG_FP, -args_off, ctx);
49b5e77ae3e214 Pu Lehui      2023-02-15   969  	if (!p->jited)
49b5e77ae3e214 Pu Lehui      2023-02-15   970  		/* arg2: progs[i]->insnsi for interpreter */
49b5e77ae3e214 Pu Lehui      2023-02-15   971  		emit_imm(RV_REG_A1, (const s64)p->insnsi, ctx);
49b5e77ae3e214 Pu Lehui      2023-02-15   972  	ret = emit_call((const u64)p->bpf_func, true, ctx);
49b5e77ae3e214 Pu Lehui      2023-02-15   973  	if (ret)
49b5e77ae3e214 Pu Lehui      2023-02-15   974  		return ret;
49b5e77ae3e214 Pu Lehui      2023-02-15   975  
7112cd26e606c7 Björn Töpel   2023-10-04   976  	if (save_ret) {
7112cd26e606c7 Björn Töpel   2023-10-04   977  		emit_sd(RV_REG_FP, -retval_off, RV_REG_A0, ctx);
7112cd26e606c7 Björn Töpel   2023-10-04   978  		emit_sd(RV_REG_FP, -(retval_off - 8), regmap[BPF_REG_0], ctx);
7112cd26e606c7 Björn Töpel   2023-10-04   979  	}
49b5e77ae3e214 Pu Lehui      2023-02-15   980  
49b5e77ae3e214 Pu Lehui      2023-02-15   981  	/* update branch with beqz */
49b5e77ae3e214 Pu Lehui      2023-02-15   982  	if (ctx->insns) {
49b5e77ae3e214 Pu Lehui      2023-02-15   983  		int offset = ninsns_rvoff(ctx->ninsns - branch_off);
49b5e77ae3e214 Pu Lehui      2023-02-15   984  		u32 insn = rv_beq(RV_REG_A0, RV_REG_ZERO, offset >> 1);
49b5e77ae3e214 Pu Lehui      2023-02-15   985  		*(u32 *)(ctx->insns + branch_off) = insn;
49b5e77ae3e214 Pu Lehui      2023-02-15   986  	}
49b5e77ae3e214 Pu Lehui      2023-02-15   987  
49b5e77ae3e214 Pu Lehui      2023-02-15   988  	/* arg1: prog */
49b5e77ae3e214 Pu Lehui      2023-02-15   989  	emit_imm(RV_REG_A0, (const s64)p, ctx);
49b5e77ae3e214 Pu Lehui      2023-02-15   990  	/* arg2: prog start time */
49b5e77ae3e214 Pu Lehui      2023-02-15   991  	emit_mv(RV_REG_A1, RV_REG_S1, ctx);
49b5e77ae3e214 Pu Lehui      2023-02-15   992  	/* arg3: &run_ctx */
49b5e77ae3e214 Pu Lehui      2023-02-15   993  	emit_addi(RV_REG_A2, RV_REG_FP, -run_ctx_off, ctx);
49b5e77ae3e214 Pu Lehui      2023-02-15   994  	ret = emit_call((const u64)bpf_trampoline_exit(p), true, ctx);
49b5e77ae3e214 Pu Lehui      2023-02-15   995  
49b5e77ae3e214 Pu Lehui      2023-02-15   996  	return ret;
49b5e77ae3e214 Pu Lehui      2023-02-15   997  }
49b5e77ae3e214 Pu Lehui      2023-02-15   998  
35b3515be0ecb9 Menglong Dong 2026-02-08   999  static int invoke_bpf(struct bpf_tramp_links *tl, int args_off, int retval_off,
35b3515be0ecb9 Menglong Dong 2026-02-08  1000  		      int run_ctx_off, int func_meta_off, bool save_ret, u64 func_meta,
35b3515be0ecb9 Menglong Dong 2026-02-08  1001  		      int cookie_off, struct rv_jit_context *ctx)
35b3515be0ecb9 Menglong Dong 2026-02-08  1002  {
35b3515be0ecb9 Menglong Dong 2026-02-08  1003  	int i, cur_cookie = (cookie_off - args_off) / 8;
35b3515be0ecb9 Menglong Dong 2026-02-08  1004  
35b3515be0ecb9 Menglong Dong 2026-02-08 @1005  	for (i = 0; i < tl->nr_links; i++) {
35b3515be0ecb9 Menglong Dong 2026-02-08  1006  		int err;
35b3515be0ecb9 Menglong Dong 2026-02-08  1007  
35b3515be0ecb9 Menglong Dong 2026-02-08  1008  		if (bpf_prog_calls_session_cookie(tl->links[i])) {
35b3515be0ecb9 Menglong Dong 2026-02-08  1009  			u64 meta = func_meta | ((u64)cur_cookie << BPF_TRAMP_COOKIE_INDEX_SHIFT);
35b3515be0ecb9 Menglong Dong 2026-02-08  1010  
35b3515be0ecb9 Menglong Dong 2026-02-08  1011  			emit_store_stack_imm64(RV_REG_T1, -func_meta_off, meta, ctx);
35b3515be0ecb9 Menglong Dong 2026-02-08  1012  			cur_cookie--;
35b3515be0ecb9 Menglong Dong 2026-02-08  1013  		}
35b3515be0ecb9 Menglong Dong 2026-02-08  1014  		err = invoke_bpf_prog(tl->links[i], args_off, retval_off, run_ctx_off,
35b3515be0ecb9 Menglong Dong 2026-02-08  1015  				      save_ret, ctx);
35b3515be0ecb9 Menglong Dong 2026-02-08  1016  		if (err)
35b3515be0ecb9 Menglong Dong 2026-02-08  1017  			return err;
35b3515be0ecb9 Menglong Dong 2026-02-08  1018  	}
35b3515be0ecb9 Menglong Dong 2026-02-08  1019  	return 0;
35b3515be0ecb9 Menglong Dong 2026-02-08  1020  }
35b3515be0ecb9 Menglong Dong 2026-02-08  1021  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
