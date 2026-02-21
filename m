Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E91E1758B;
	Sat, 21 Feb 2026 03:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771642858; cv=none; b=e8cWRks+QLBqyC/2RVG8CIvJdsyW1sJz0w2d8ntklY/WHdvks/ayibuddWitc92NKyXZq6JNzAy/ZRPRZdCLGUPEs8bT/S1TMB5jiKHhuznlc4VOgA4k7fElgqSQqC2Nc60wtOrcRsMU3RD8hjJWgghKegmJc5XIKZYRV0pUOsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771642858; c=relaxed/simple;
	bh=2zzOYjNR8Hoe95QVPVqwpg+tXry5jT/aSn2GG5S9euw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s6l8F/AwP9iZk//w+LiewBvz80WXwTuUKblJfH56kNuR0OaTtKx7ZXX2xF4tFqXLbkat3rOI8uwMKNbxh9zdQWDrIaT3jSPYV+0a4L8dlYAt9z56gWcYQEGGj32yakB+fGaPi9jR7YzfpuM+oX0OOEcriYC8L9WryLMdPXvjwLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZfjjkBLg; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZfjjkBLg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771642856; x=1803178856;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=2zzOYjNR8Hoe95QVPVqwpg+tXry5jT/aSn2GG5S9euw=;
  b=ZfjjkBLgfwaSRAsdwr7MY34fxxfUnQ5CLBW8E0Rj3SHSPkHhVpHNNyNA
   20wHE7oClfb849RRK6SeYcRYcaLebbbjM164HTNZ9siLe7nHiJ60vJPuc
   kIT6q1FQgQ7D5tP7MAx167BBh9s3IOmj3qkyjTOVn/30i3+lCc/c/9XT2
   jxEsSK24axhB7WKXGytBH9G30Y/7PtuLWGUzw6pn+ySeg1/0QpS1/m2Uv
   CLkLDQm26YjiCv+TTYF/NyHzkvoqd8ndDOtyydIsCBwZThieHVxvp60vd
   MmcC5p1ySVAaSTFrMdGtwHtQVtTPP/4dpIbNb2AbZrgWm5OFdgQv1k/4Y
   g==;
X-CSE-ConnectionGUID: Qk5UJ/foQ/iOIj7Af0+cHQ==
X-CSE-MsgGUID: ldPfE4ntR8e5YU1PbaxNDQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11707"; a="72641703"
X-IronPort-AV: E=Sophos;i="6.21,302,1763452800"; 
   d="scan'208";a="72641703"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2026 19:00:55 -0800
X-CSE-ConnectionGUID: C4ZVHOI6RJe+U03qi+SU5Q==
X-CSE-MsgGUID: LcfUmNlITnmVYQWJLTagYA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,302,1763452800"; 
   d="scan'208";a="213530153"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 20 Feb 2026 19:00:51 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vtdEf-000000014fA-0vdq;
	Sat, 21 Feb 2026 03:00:49 +0000
Date: Sat, 21 Feb 2026 11:00:05 +0800
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
Message-ID: <202602211023.EiuS4wkF-lkp@intel.com>
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
config: riscv-randconfig-001-20260221 (https://download.01.org/0day-ci/archive/20260221/202602211023.EiuS4wkF-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 8.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260221/202602211023.EiuS4wkF-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202602211023.EiuS4wkF-lkp@intel.com/

All errors (new ones prefixed by >>):

   arch/riscv/net/bpf_jit_comp64.c: In function 'invoke_bpf_prog':
>> arch/riscv/net/bpf_jit_comp64.c:944:7: error: 'struct bpf_tramp_link' has no member named 'cookie'
     if (l->cookie)
          ^~
   arch/riscv/net/bpf_jit_comp64.c:945:65: error: 'struct bpf_tramp_link' has no member named 'cookie'
      emit_store_stack_imm64(RV_REG_T1, -run_ctx_off + cookie_off, l->cookie, ctx);
                                                                    ^~
   arch/riscv/net/bpf_jit_comp64.c: At top level:
   arch/riscv/net/bpf_jit_comp64.c:999:30: warning: 'struct bpf_tramp_links' declared inside parameter list will not be visible outside of this definition or declaration
    static int invoke_bpf(struct bpf_tramp_links *tl, int args_off, int retval_off,
                                 ^~~~~~~~~~~~~~~
   arch/riscv/net/bpf_jit_comp64.c: In function 'invoke_bpf':
>> arch/riscv/net/bpf_jit_comp64.c:1005:20: error: dereferencing pointer to incomplete type 'struct bpf_tramp_links'
     for (i = 0; i < tl->nr_links; i++) {
                       ^~
   arch/riscv/net/bpf_jit_comp64.c: At top level:
   arch/riscv/net/bpf_jit_comp64.c:1024:14: warning: 'struct bpf_tramp_links' declared inside parameter list will not be visible outside of this definition or declaration
          struct bpf_tramp_links *tlinks,
                 ^~~~~~~~~~~~~~~
   arch/riscv/net/bpf_jit_comp64.c: In function '__arch_prepare_bpf_trampoline':
>> arch/riscv/net/bpf_jit_comp64.c:1033:42: error: invalid use of undefined type 'struct bpf_tramp_links'
     struct bpf_tramp_links *fentry = &tlinks[BPF_TRAMP_FENTRY];
                                             ^
   arch/riscv/net/bpf_jit_comp64.c:1033:42: error: dereferencing pointer to incomplete type 'struct bpf_tramp_links'
   arch/riscv/net/bpf_jit_comp64.c:1034:41: error: invalid use of undefined type 'struct bpf_tramp_links'
     struct bpf_tramp_links *fexit = &tlinks[BPF_TRAMP_FEXIT];
                                            ^
   arch/riscv/net/bpf_jit_comp64.c:1035:44: error: invalid use of undefined type 'struct bpf_tramp_links'
     struct bpf_tramp_links *fmod_ret = &tlinks[BPF_TRAMP_MODIFY_RETURN];
                                               ^
   arch/riscv/net/bpf_jit_comp64.c:1118:39: error: passing argument 1 of 'bpf_fsession_cookie_cnt' from incompatible pointer type [-Werror=incompatible-pointer-types]
     cookie_cnt = bpf_fsession_cookie_cnt(tlinks);
                                          ^~~~~~
   In file included from arch/riscv/net/bpf_jit_comp64.c:9:
   include/linux/bpf.h:2207:67: note: expected 'struct bpf_tramp_nodes *' but argument is of type 'struct bpf_tramp_links *'
    static inline int bpf_fsession_cookie_cnt(struct bpf_tramp_nodes *nodes)
                                              ~~~~~~~~~~~~~~~~~~~~~~~~^~~~~
   arch/riscv/net/bpf_jit_comp64.c:1175:23: error: passing argument 1 of 'bpf_fsession_cnt' from incompatible pointer type [-Werror=incompatible-pointer-types]
     if (bpf_fsession_cnt(tlinks)) {
                          ^~~~~~
   In file included from arch/riscv/net/bpf_jit_comp64.c:9:
   include/linux/bpf.h:2189:60: note: expected 'struct bpf_tramp_nodes *' but argument is of type 'struct bpf_tramp_links *'
    static inline int bpf_fsession_cnt(struct bpf_tramp_nodes *nodes)
                                       ~~~~~~~~~~~~~~~~~~~~~~~~^~~~~
   arch/riscv/net/bpf_jit_comp64.c:1191:20: error: passing argument 1 of 'invoke_bpf' from incompatible pointer type [-Werror=incompatible-pointer-types]
      ret = invoke_bpf(fentry, args_off, retval_off, run_ctx_off, func_meta_off,
                       ^~~~~~
   arch/riscv/net/bpf_jit_comp64.c:999:47: note: expected 'struct bpf_tramp_links *' but argument is of type 'struct bpf_tramp_links *'
    static int invoke_bpf(struct bpf_tramp_links *tl, int args_off, int retval_off,
                          ~~~~~~~~~~~~~~~~~~~~~~~~^~
   arch/riscv/net/bpf_jit_comp64.c:1198:16: warning: assignment to 'int *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
      branches_off = kcalloc(fmod_ret->nr_links, sizeof(int), GFP_KERNEL);
                   ^
   arch/riscv/net/bpf_jit_comp64.c:1241:23: error: passing argument 1 of 'bpf_fsession_cnt' from incompatible pointer type [-Werror=incompatible-pointer-types]
     if (bpf_fsession_cnt(tlinks))
                          ^~~~~~
   In file included from arch/riscv/net/bpf_jit_comp64.c:9:
   include/linux/bpf.h:2189:60: note: expected 'struct bpf_tramp_nodes *' but argument is of type 'struct bpf_tramp_links *'
    static inline int bpf_fsession_cnt(struct bpf_tramp_nodes *nodes)
                                       ~~~~~~~~~~~~~~~~~~~~~~~~^~~~~
   arch/riscv/net/bpf_jit_comp64.c:1245:20: error: passing argument 1 of 'invoke_bpf' from incompatible pointer type [-Werror=incompatible-pointer-types]
      ret = invoke_bpf(fexit, args_off, retval_off, run_ctx_off, func_meta_off,
                       ^~~~~
   arch/riscv/net/bpf_jit_comp64.c:999:47: note: expected 'struct bpf_tramp_links *' but argument is of type 'struct bpf_tramp_links *'
    static int invoke_bpf(struct bpf_tramp_links *tl, int args_off, int retval_off,
                          ~~~~~~~~~~~~~~~~~~~~~~~~^~
   arch/riscv/net/bpf_jit_comp64.c: At top level:
   arch/riscv/net/bpf_jit_comp64.c:1308:16: warning: 'struct bpf_tramp_links' declared inside parameter list will not be visible outside of this definition or declaration
            struct bpf_tramp_links *tlinks, void *func_addr)
                   ^~~~~~~~~~~~~~~
   arch/riscv/net/bpf_jit_comp64.c:1307:5: error: conflicting types for 'arch_bpf_trampoline_size'
    int arch_bpf_trampoline_size(const struct btf_func_model *m, u32 flags,
        ^~~~~~~~~~~~~~~~~~~~~~~~
   In file included from arch/riscv/net/bpf_jit_comp64.c:9:
   include/linux/bpf.h:1271:5: note: previous declaration of 'arch_bpf_trampoline_size' was here
    int arch_bpf_trampoline_size(const struct btf_func_model *m, u32 flags,
        ^~~~~~~~~~~~~~~~~~~~~~~~
   arch/riscv/net/bpf_jit_comp64.c: In function 'arch_bpf_trampoline_size':
   arch/riscv/net/bpf_jit_comp64.c:1317:46: error: passing argument 3 of '__arch_prepare_bpf_trampoline' from incompatible pointer type [-Werror=incompatible-pointer-types]
     ret = __arch_prepare_bpf_trampoline(&im, m, tlinks, func_addr, flags, &ctx);
                                                 ^~~~~~
   arch/riscv/net/bpf_jit_comp64.c:1024:31: note: expected 'struct bpf_tramp_links *' but argument is of type 'struct bpf_tramp_links *'
          struct bpf_tramp_links *tlinks,
          ~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~
   arch/riscv/net/bpf_jit_comp64.c: At top level:
   arch/riscv/net/bpf_jit_comp64.c:1334:23: warning: 'struct bpf_tramp_links' declared inside parameter list will not be visible outside of this definition or declaration
        u32 flags, struct bpf_tramp_links *tlinks,
                          ^~~~~~~~~~~~~~~
   arch/riscv/net/bpf_jit_comp64.c:1332:5: error: conflicting types for 'arch_prepare_bpf_trampoline'
    int arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *ro_image,
        ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   In file included from arch/riscv/net/bpf_jit_comp64.c:9:
   include/linux/bpf.h:1264:5: note: previous declaration of 'arch_prepare_bpf_trampoline' was here
    int arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *image, void *image_end,
        ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/riscv/net/bpf_jit_comp64.c: In function 'arch_prepare_bpf_trampoline':
   arch/riscv/net/bpf_jit_comp64.c:1349:45: error: passing argument 3 of '__arch_prepare_bpf_trampoline' from incompatible pointer type [-Werror=incompatible-pointer-types]
     ret = __arch_prepare_bpf_trampoline(im, m, tlinks, func_addr, flags, &ctx);
                                                ^~~~~~
   arch/riscv/net/bpf_jit_comp64.c:1024:31: note: expected 'struct bpf_tramp_links *' but argument is of type 'struct bpf_tramp_links *'
          struct bpf_tramp_links *tlinks,
          ~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~
   cc1: some warnings being treated as errors


vim +944 arch/riscv/net/bpf_jit_comp64.c

93fd420d71beed5 Menglong Dong  2026-02-08   936  
49b5e77ae3e214a Pu Lehui       2023-02-15   937  static int invoke_bpf_prog(struct bpf_tramp_link *l, int args_off, int retval_off,
49b5e77ae3e214a Pu Lehui       2023-02-15   938  			   int run_ctx_off, bool save_ret, struct rv_jit_context *ctx)
49b5e77ae3e214a Pu Lehui       2023-02-15   939  {
49b5e77ae3e214a Pu Lehui       2023-02-15   940  	int ret, branch_off;
49b5e77ae3e214a Pu Lehui       2023-02-15   941  	struct bpf_prog *p = l->link.prog;
49b5e77ae3e214a Pu Lehui       2023-02-15   942  	int cookie_off = offsetof(struct bpf_tramp_run_ctx, bpf_cookie);
49b5e77ae3e214a Pu Lehui       2023-02-15   943  
93fd420d71beed5 Menglong Dong  2026-02-08  @944  	if (l->cookie)
93fd420d71beed5 Menglong Dong  2026-02-08   945  		emit_store_stack_imm64(RV_REG_T1, -run_ctx_off + cookie_off, l->cookie, ctx);
93fd420d71beed5 Menglong Dong  2026-02-08   946  	else
49b5e77ae3e214a Pu Lehui       2023-02-15   947  		emit_sd(RV_REG_FP, -run_ctx_off + cookie_off, RV_REG_ZERO, ctx);
49b5e77ae3e214a Pu Lehui       2023-02-15   948  
49b5e77ae3e214a Pu Lehui       2023-02-15   949  	/* arg1: prog */
49b5e77ae3e214a Pu Lehui       2023-02-15   950  	emit_imm(RV_REG_A0, (const s64)p, ctx);
49b5e77ae3e214a Pu Lehui       2023-02-15   951  	/* arg2: &run_ctx */
49b5e77ae3e214a Pu Lehui       2023-02-15   952  	emit_addi(RV_REG_A1, RV_REG_FP, -run_ctx_off, ctx);
49b5e77ae3e214a Pu Lehui       2023-02-15   953  	ret = emit_call((const u64)bpf_trampoline_enter(p), true, ctx);
49b5e77ae3e214a Pu Lehui       2023-02-15   954  	if (ret)
49b5e77ae3e214a Pu Lehui       2023-02-15   955  		return ret;
49b5e77ae3e214a Pu Lehui       2023-02-15   956  
10541b374aa05c8 Xu Kuohai      2024-04-16   957  	/* store prog start time */
10541b374aa05c8 Xu Kuohai      2024-04-16   958  	emit_mv(RV_REG_S1, RV_REG_A0, ctx);
10541b374aa05c8 Xu Kuohai      2024-04-16   959  
49b5e77ae3e214a Pu Lehui       2023-02-15   960  	/* if (__bpf_prog_enter(prog) == 0)
49b5e77ae3e214a Pu Lehui       2023-02-15   961  	 *	goto skip_exec_of_prog;
49b5e77ae3e214a Pu Lehui       2023-02-15   962  	 */
49b5e77ae3e214a Pu Lehui       2023-02-15   963  	branch_off = ctx->ninsns;
49b5e77ae3e214a Pu Lehui       2023-02-15   964  	/* nop reserved for conditional jump */
49b5e77ae3e214a Pu Lehui       2023-02-15   965  	emit(rv_nop(), ctx);
49b5e77ae3e214a Pu Lehui       2023-02-15   966  
49b5e77ae3e214a Pu Lehui       2023-02-15   967  	/* arg1: &args_off */
49b5e77ae3e214a Pu Lehui       2023-02-15   968  	emit_addi(RV_REG_A0, RV_REG_FP, -args_off, ctx);
49b5e77ae3e214a Pu Lehui       2023-02-15   969  	if (!p->jited)
49b5e77ae3e214a Pu Lehui       2023-02-15   970  		/* arg2: progs[i]->insnsi for interpreter */
49b5e77ae3e214a Pu Lehui       2023-02-15   971  		emit_imm(RV_REG_A1, (const s64)p->insnsi, ctx);
49b5e77ae3e214a Pu Lehui       2023-02-15   972  	ret = emit_call((const u64)p->bpf_func, true, ctx);
49b5e77ae3e214a Pu Lehui       2023-02-15   973  	if (ret)
49b5e77ae3e214a Pu Lehui       2023-02-15   974  		return ret;
49b5e77ae3e214a Pu Lehui       2023-02-15   975  
7112cd26e606c7b Björn Töpel    2023-10-04   976  	if (save_ret) {
7112cd26e606c7b Björn Töpel    2023-10-04   977  		emit_sd(RV_REG_FP, -retval_off, RV_REG_A0, ctx);
7112cd26e606c7b Björn Töpel    2023-10-04   978  		emit_sd(RV_REG_FP, -(retval_off - 8), regmap[BPF_REG_0], ctx);
7112cd26e606c7b Björn Töpel    2023-10-04   979  	}
49b5e77ae3e214a Pu Lehui       2023-02-15   980  
49b5e77ae3e214a Pu Lehui       2023-02-15   981  	/* update branch with beqz */
49b5e77ae3e214a Pu Lehui       2023-02-15   982  	if (ctx->insns) {
49b5e77ae3e214a Pu Lehui       2023-02-15   983  		int offset = ninsns_rvoff(ctx->ninsns - branch_off);
49b5e77ae3e214a Pu Lehui       2023-02-15   984  		u32 insn = rv_beq(RV_REG_A0, RV_REG_ZERO, offset >> 1);
49b5e77ae3e214a Pu Lehui       2023-02-15   985  		*(u32 *)(ctx->insns + branch_off) = insn;
49b5e77ae3e214a Pu Lehui       2023-02-15   986  	}
49b5e77ae3e214a Pu Lehui       2023-02-15   987  
49b5e77ae3e214a Pu Lehui       2023-02-15   988  	/* arg1: prog */
49b5e77ae3e214a Pu Lehui       2023-02-15   989  	emit_imm(RV_REG_A0, (const s64)p, ctx);
49b5e77ae3e214a Pu Lehui       2023-02-15   990  	/* arg2: prog start time */
49b5e77ae3e214a Pu Lehui       2023-02-15   991  	emit_mv(RV_REG_A1, RV_REG_S1, ctx);
49b5e77ae3e214a Pu Lehui       2023-02-15   992  	/* arg3: &run_ctx */
49b5e77ae3e214a Pu Lehui       2023-02-15   993  	emit_addi(RV_REG_A2, RV_REG_FP, -run_ctx_off, ctx);
49b5e77ae3e214a Pu Lehui       2023-02-15   994  	ret = emit_call((const u64)bpf_trampoline_exit(p), true, ctx);
49b5e77ae3e214a Pu Lehui       2023-02-15   995  
49b5e77ae3e214a Pu Lehui       2023-02-15   996  	return ret;
49b5e77ae3e214a Pu Lehui       2023-02-15   997  }
49b5e77ae3e214a Pu Lehui       2023-02-15   998  
35b3515be0ecb9d Menglong Dong  2026-02-08   999  static int invoke_bpf(struct bpf_tramp_links *tl, int args_off, int retval_off,
35b3515be0ecb9d Menglong Dong  2026-02-08  1000  		      int run_ctx_off, int func_meta_off, bool save_ret, u64 func_meta,
35b3515be0ecb9d Menglong Dong  2026-02-08  1001  		      int cookie_off, struct rv_jit_context *ctx)
35b3515be0ecb9d Menglong Dong  2026-02-08  1002  {
35b3515be0ecb9d Menglong Dong  2026-02-08  1003  	int i, cur_cookie = (cookie_off - args_off) / 8;
35b3515be0ecb9d Menglong Dong  2026-02-08  1004  
35b3515be0ecb9d Menglong Dong  2026-02-08 @1005  	for (i = 0; i < tl->nr_links; i++) {
35b3515be0ecb9d Menglong Dong  2026-02-08  1006  		int err;
35b3515be0ecb9d Menglong Dong  2026-02-08  1007  
35b3515be0ecb9d Menglong Dong  2026-02-08  1008  		if (bpf_prog_calls_session_cookie(tl->links[i])) {
35b3515be0ecb9d Menglong Dong  2026-02-08  1009  			u64 meta = func_meta | ((u64)cur_cookie << BPF_TRAMP_COOKIE_INDEX_SHIFT);
35b3515be0ecb9d Menglong Dong  2026-02-08  1010  
35b3515be0ecb9d Menglong Dong  2026-02-08  1011  			emit_store_stack_imm64(RV_REG_T1, -func_meta_off, meta, ctx);
35b3515be0ecb9d Menglong Dong  2026-02-08  1012  			cur_cookie--;
35b3515be0ecb9d Menglong Dong  2026-02-08  1013  		}
35b3515be0ecb9d Menglong Dong  2026-02-08  1014  		err = invoke_bpf_prog(tl->links[i], args_off, retval_off, run_ctx_off,
35b3515be0ecb9d Menglong Dong  2026-02-08  1015  				      save_ret, ctx);
35b3515be0ecb9d Menglong Dong  2026-02-08  1016  		if (err)
35b3515be0ecb9d Menglong Dong  2026-02-08  1017  			return err;
35b3515be0ecb9d Menglong Dong  2026-02-08  1018  	}
35b3515be0ecb9d Menglong Dong  2026-02-08  1019  	return 0;
35b3515be0ecb9d Menglong Dong  2026-02-08  1020  }
35b3515be0ecb9d Menglong Dong  2026-02-08  1021  
49b5e77ae3e214a Pu Lehui       2023-02-15  1022  static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im,
49b5e77ae3e214a Pu Lehui       2023-02-15  1023  					 const struct btf_func_model *m,
49b5e77ae3e214a Pu Lehui       2023-02-15  1024  					 struct bpf_tramp_links *tlinks,
49b5e77ae3e214a Pu Lehui       2023-02-15  1025  					 void *func_addr, u32 flags,
49b5e77ae3e214a Pu Lehui       2023-02-15  1026  					 struct rv_jit_context *ctx)
49b5e77ae3e214a Pu Lehui       2023-02-15  1027  {
49b5e77ae3e214a Pu Lehui       2023-02-15  1028  	int i, ret, offset;
49b5e77ae3e214a Pu Lehui       2023-02-15  1029  	int *branches_off = NULL;
6801b0aef79db47 Pu Lehui       2024-07-02  1030  	int stack_size = 0, nr_arg_slots = 0;
35b3515be0ecb9d Menglong Dong  2026-02-08  1031  	int retval_off, args_off, func_meta_off, ip_off, run_ctx_off, sreg_off, stk_arg_off;
35b3515be0ecb9d Menglong Dong  2026-02-08  1032  	int cookie_off, cookie_cnt;
49b5e77ae3e214a Pu Lehui       2023-02-15 @1033  	struct bpf_tramp_links *fentry = &tlinks[BPF_TRAMP_FENTRY];
49b5e77ae3e214a Pu Lehui       2023-02-15  1034  	struct bpf_tramp_links *fexit = &tlinks[BPF_TRAMP_FEXIT];
49b5e77ae3e214a Pu Lehui       2023-02-15  1035  	struct bpf_tramp_links *fmod_ret = &tlinks[BPF_TRAMP_MODIFY_RETURN];
1732ebc4a26181c Pu Lehui       2024-01-23  1036  	bool is_struct_ops = flags & BPF_TRAMP_F_INDIRECT;
49b5e77ae3e214a Pu Lehui       2023-02-15  1037  	void *orig_call = func_addr;
49b5e77ae3e214a Pu Lehui       2023-02-15  1038  	bool save_ret;
35b3515be0ecb9d Menglong Dong  2026-02-08  1039  	u64 func_meta;
49b5e77ae3e214a Pu Lehui       2023-02-15  1040  	u32 insn;
49b5e77ae3e214a Pu Lehui       2023-02-15  1041  
25ad10658dc1068 Pu Lehui       2023-07-21  1042  	/* Two types of generated trampoline stack layout:
25ad10658dc1068 Pu Lehui       2023-07-21  1043  	 *
25ad10658dc1068 Pu Lehui       2023-07-21  1044  	 * 1. trampoline called from function entry
25ad10658dc1068 Pu Lehui       2023-07-21  1045  	 * --------------------------------------
25ad10658dc1068 Pu Lehui       2023-07-21  1046  	 * FP + 8	    [ RA to parent func	] return address to parent
25ad10658dc1068 Pu Lehui       2023-07-21  1047  	 *					  function
25ad10658dc1068 Pu Lehui       2023-07-21  1048  	 * FP + 0	    [ FP of parent func ] frame pointer of parent
25ad10658dc1068 Pu Lehui       2023-07-21  1049  	 *					  function
25ad10658dc1068 Pu Lehui       2023-07-21  1050  	 * FP - 8           [ T0 to traced func ] return address of traced
25ad10658dc1068 Pu Lehui       2023-07-21  1051  	 *					  function
25ad10658dc1068 Pu Lehui       2023-07-21  1052  	 * FP - 16	    [ FP of traced func ] frame pointer of traced
25ad10658dc1068 Pu Lehui       2023-07-21  1053  	 *					  function
25ad10658dc1068 Pu Lehui       2023-07-21  1054  	 * --------------------------------------
49b5e77ae3e214a Pu Lehui       2023-02-15  1055  	 *
25ad10658dc1068 Pu Lehui       2023-07-21  1056  	 * 2. trampoline called directly
25ad10658dc1068 Pu Lehui       2023-07-21  1057  	 * --------------------------------------
25ad10658dc1068 Pu Lehui       2023-07-21  1058  	 * FP - 8	    [ RA to caller func ] return address to caller
49b5e77ae3e214a Pu Lehui       2023-02-15  1059  	 *					  function
25ad10658dc1068 Pu Lehui       2023-07-21  1060  	 * FP - 16	    [ FP of caller func	] frame pointer of caller
49b5e77ae3e214a Pu Lehui       2023-02-15  1061  	 *					  function
25ad10658dc1068 Pu Lehui       2023-07-21  1062  	 * --------------------------------------
49b5e77ae3e214a Pu Lehui       2023-02-15  1063  	 *
49b5e77ae3e214a Pu Lehui       2023-02-15  1064  	 * FP - retval_off  [ return value      ] BPF_TRAMP_F_CALL_ORIG or
49b5e77ae3e214a Pu Lehui       2023-02-15  1065  	 *					  BPF_TRAMP_F_RET_FENTRY_RET
49b5e77ae3e214a Pu Lehui       2023-02-15  1066  	 *                  [ argN              ]
49b5e77ae3e214a Pu Lehui       2023-02-15  1067  	 *                  [ ...               ]
49b5e77ae3e214a Pu Lehui       2023-02-15  1068  	 * FP - args_off    [ arg1              ]
49b5e77ae3e214a Pu Lehui       2023-02-15  1069  	 *
35b3515be0ecb9d Menglong Dong  2026-02-08  1070  	 * FP - func_meta_off [ regs count, etc ]
49b5e77ae3e214a Pu Lehui       2023-02-15  1071  	 *
49b5e77ae3e214a Pu Lehui       2023-02-15  1072  	 * FP - ip_off      [ traced func	] BPF_TRAMP_F_IP_ARG
49b5e77ae3e214a Pu Lehui       2023-02-15  1073  	 *
35b3515be0ecb9d Menglong Dong  2026-02-08  1074  	 *                  [ stack cookie N    ]
35b3515be0ecb9d Menglong Dong  2026-02-08  1075  	 *                  [ ...               ]
35b3515be0ecb9d Menglong Dong  2026-02-08  1076  	 * FP - cookie_off  [ stack cookie 1    ]
35b3515be0ecb9d Menglong Dong  2026-02-08  1077  	 *
49b5e77ae3e214a Pu Lehui       2023-02-15  1078  	 * FP - run_ctx_off [ bpf_tramp_run_ctx ]
49b5e77ae3e214a Pu Lehui       2023-02-15  1079  	 *
49b5e77ae3e214a Pu Lehui       2023-02-15  1080  	 * FP - sreg_off    [ callee saved reg	]
49b5e77ae3e214a Pu Lehui       2023-02-15  1081  	 *
49b5e77ae3e214a Pu Lehui       2023-02-15  1082  	 *		    [ pads              ] pads for 16 bytes alignment
6801b0aef79db47 Pu Lehui       2024-07-02  1083  	 *
6801b0aef79db47 Pu Lehui       2024-07-02  1084  	 *		    [ stack_argN        ]
6801b0aef79db47 Pu Lehui       2024-07-02  1085  	 *		    [ ...               ]
6801b0aef79db47 Pu Lehui       2024-07-02  1086  	 * FP - stk_arg_off [ stack_arg1        ] BPF_TRAMP_F_CALL_ORIG
49b5e77ae3e214a Pu Lehui       2023-02-15  1087  	 */
49b5e77ae3e214a Pu Lehui       2023-02-15  1088  
49b5e77ae3e214a Pu Lehui       2023-02-15  1089  	if (flags & (BPF_TRAMP_F_ORIG_STACK | BPF_TRAMP_F_SHARE_IPMODIFY))
49b5e77ae3e214a Pu Lehui       2023-02-15  1090  		return -ENOTSUPP;
49b5e77ae3e214a Pu Lehui       2023-02-15  1091  
6801b0aef79db47 Pu Lehui       2024-07-02  1092  	if (m->nr_args > MAX_BPF_FUNC_ARGS)
49b5e77ae3e214a Pu Lehui       2023-02-15  1093  		return -ENOTSUPP;
49b5e77ae3e214a Pu Lehui       2023-02-15  1094  
6801b0aef79db47 Pu Lehui       2024-07-02  1095  	for (i = 0; i < m->nr_args; i++)
6801b0aef79db47 Pu Lehui       2024-07-02  1096  		nr_arg_slots += round_up(m->arg_size[i], 8) / 8;
6801b0aef79db47 Pu Lehui       2024-07-02  1097  
25ad10658dc1068 Pu Lehui       2023-07-21  1098  	/* room of trampoline frame to store return address and frame pointer */
25ad10658dc1068 Pu Lehui       2023-07-21  1099  	stack_size += 16;
49b5e77ae3e214a Pu Lehui       2023-02-15  1100  
49b5e77ae3e214a Pu Lehui       2023-02-15  1101  	save_ret = flags & (BPF_TRAMP_F_CALL_ORIG | BPF_TRAMP_F_RET_FENTRY_RET);
d0bf7cd5df18466 Chenghao Duan  2025-09-22  1102  	if (save_ret)
7112cd26e606c7b Björn Töpel    2023-10-04  1103  		stack_size += 16; /* Save both A5 (BPF R0) and A0 */
49b5e77ae3e214a Pu Lehui       2023-02-15  1104  	retval_off = stack_size;
49b5e77ae3e214a Pu Lehui       2023-02-15  1105  
6801b0aef79db47 Pu Lehui       2024-07-02  1106  	stack_size += nr_arg_slots * 8;
49b5e77ae3e214a Pu Lehui       2023-02-15  1107  	args_off = stack_size;
49b5e77ae3e214a Pu Lehui       2023-02-15  1108  
35b3515be0ecb9d Menglong Dong  2026-02-08  1109  	/* function metadata, such as regs count */
49b5e77ae3e214a Pu Lehui       2023-02-15  1110  	stack_size += 8;
35b3515be0ecb9d Menglong Dong  2026-02-08  1111  	func_meta_off = stack_size;
49b5e77ae3e214a Pu Lehui       2023-02-15  1112  
49b5e77ae3e214a Pu Lehui       2023-02-15  1113  	if (flags & BPF_TRAMP_F_IP_ARG) {
49b5e77ae3e214a Pu Lehui       2023-02-15  1114  		stack_size += 8;
49b5e77ae3e214a Pu Lehui       2023-02-15  1115  		ip_off = stack_size;
49b5e77ae3e214a Pu Lehui       2023-02-15  1116  	}
49b5e77ae3e214a Pu Lehui       2023-02-15  1117  
35b3515be0ecb9d Menglong Dong  2026-02-08  1118  	cookie_cnt = bpf_fsession_cookie_cnt(tlinks);
35b3515be0ecb9d Menglong Dong  2026-02-08  1119  	/* room for session cookies */
35b3515be0ecb9d Menglong Dong  2026-02-08  1120  	stack_size += cookie_cnt * 8;
35b3515be0ecb9d Menglong Dong  2026-02-08  1121  	cookie_off = stack_size;
35b3515be0ecb9d Menglong Dong  2026-02-08  1122  
49b5e77ae3e214a Pu Lehui       2023-02-15  1123  	stack_size += round_up(sizeof(struct bpf_tramp_run_ctx), 8);
49b5e77ae3e214a Pu Lehui       2023-02-15  1124  	run_ctx_off = stack_size;
49b5e77ae3e214a Pu Lehui       2023-02-15  1125  
49b5e77ae3e214a Pu Lehui       2023-02-15  1126  	stack_size += 8;
49b5e77ae3e214a Pu Lehui       2023-02-15  1127  	sreg_off = stack_size;
49b5e77ae3e214a Pu Lehui       2023-02-15  1128  
a5912c37faf723c Puranjay Mohan 2024-07-08  1129  	if ((flags & BPF_TRAMP_F_CALL_ORIG) && (nr_arg_slots - RV_MAX_REG_ARGS > 0))
6801b0aef79db47 Pu Lehui       2024-07-02  1130  		stack_size += (nr_arg_slots - RV_MAX_REG_ARGS) * 8;
6801b0aef79db47 Pu Lehui       2024-07-02  1131  
e944fc8152744a4 Xiao Wang      2024-05-23  1132  	stack_size = round_up(stack_size, STACK_ALIGN);
49b5e77ae3e214a Pu Lehui       2023-02-15  1133  
6801b0aef79db47 Pu Lehui       2024-07-02  1134  	/* room for args on stack must be at the top of stack */
6801b0aef79db47 Pu Lehui       2024-07-02  1135  	stk_arg_off = stack_size;
6801b0aef79db47 Pu Lehui       2024-07-02  1136  
1732ebc4a26181c Pu Lehui       2024-01-23  1137  	if (!is_struct_ops) {
25ad10658dc1068 Pu Lehui       2023-07-21  1138  		/* For the trampoline called from function entry,
25ad10658dc1068 Pu Lehui       2023-07-21  1139  		 * the frame of traced function and the frame of
25ad10658dc1068 Pu Lehui       2023-07-21  1140  		 * trampoline need to be considered.
25ad10658dc1068 Pu Lehui       2023-07-21  1141  		 */
25ad10658dc1068 Pu Lehui       2023-07-21  1142  		emit_addi(RV_REG_SP, RV_REG_SP, -16, ctx);
25ad10658dc1068 Pu Lehui       2023-07-21  1143  		emit_sd(RV_REG_SP, 8, RV_REG_RA, ctx);
25ad10658dc1068 Pu Lehui       2023-07-21  1144  		emit_sd(RV_REG_SP, 0, RV_REG_FP, ctx);
25ad10658dc1068 Pu Lehui       2023-07-21  1145  		emit_addi(RV_REG_FP, RV_REG_SP, 16, ctx);
49b5e77ae3e214a Pu Lehui       2023-02-15  1146  
25ad10658dc1068 Pu Lehui       2023-07-21  1147  		emit_addi(RV_REG_SP, RV_REG_SP, -stack_size, ctx);
25ad10658dc1068 Pu Lehui       2023-07-21  1148  		emit_sd(RV_REG_SP, stack_size - 8, RV_REG_T0, ctx);
25ad10658dc1068 Pu Lehui       2023-07-21  1149  		emit_sd(RV_REG_SP, stack_size - 16, RV_REG_FP, ctx);
25ad10658dc1068 Pu Lehui       2023-07-21  1150  		emit_addi(RV_REG_FP, RV_REG_SP, stack_size, ctx);
25ad10658dc1068 Pu Lehui       2023-07-21  1151  	} else {
e63985ecd22681c Puranjay Mohan 2024-03-03  1152  		/* emit kcfi hash */
e63985ecd22681c Puranjay Mohan 2024-03-03  1153  		emit_kcfi(cfi_get_func_hash(func_addr), ctx);
25ad10658dc1068 Pu Lehui       2023-07-21  1154  		/* For the trampoline called directly, just handle
25ad10658dc1068 Pu Lehui       2023-07-21  1155  		 * the frame of trampoline.
25ad10658dc1068 Pu Lehui       2023-07-21  1156  		 */
25ad10658dc1068 Pu Lehui       2023-07-21  1157  		emit_addi(RV_REG_SP, RV_REG_SP, -stack_size, ctx);
25ad10658dc1068 Pu Lehui       2023-07-21  1158  		emit_sd(RV_REG_SP, stack_size - 8, RV_REG_RA, ctx);
25ad10658dc1068 Pu Lehui       2023-07-21  1159  		emit_sd(RV_REG_SP, stack_size - 16, RV_REG_FP, ctx);
49b5e77ae3e214a Pu Lehui       2023-02-15  1160  		emit_addi(RV_REG_FP, RV_REG_SP, stack_size, ctx);
25ad10658dc1068 Pu Lehui       2023-07-21  1161  	}
49b5e77ae3e214a Pu Lehui       2023-02-15  1162  
49b5e77ae3e214a Pu Lehui       2023-02-15  1163  	/* callee saved register S1 to pass start time */
49b5e77ae3e214a Pu Lehui       2023-02-15  1164  	emit_sd(RV_REG_FP, -sreg_off, RV_REG_S1, ctx);
49b5e77ae3e214a Pu Lehui       2023-02-15  1165  
49b5e77ae3e214a Pu Lehui       2023-02-15  1166  	/* store ip address of the traced function */
93fd420d71beed5 Menglong Dong  2026-02-08  1167  	if (flags & BPF_TRAMP_F_IP_ARG)
93fd420d71beed5 Menglong Dong  2026-02-08  1168  		emit_store_stack_imm64(RV_REG_T1, -ip_off, (u64)func_addr, ctx);
49b5e77ae3e214a Pu Lehui       2023-02-15  1169  
35b3515be0ecb9d Menglong Dong  2026-02-08  1170  	func_meta = nr_arg_slots;
35b3515be0ecb9d Menglong Dong  2026-02-08  1171  	emit_store_stack_imm64(RV_REG_T1, -func_meta_off, func_meta, ctx);
49b5e77ae3e214a Pu Lehui       2023-02-15  1172  
6801b0aef79db47 Pu Lehui       2024-07-02  1173  	store_args(nr_arg_slots, args_off, ctx);
49b5e77ae3e214a Pu Lehui       2023-02-15  1174  
35b3515be0ecb9d Menglong Dong  2026-02-08  1175  	if (bpf_fsession_cnt(tlinks)) {
35b3515be0ecb9d Menglong Dong  2026-02-08  1176  		/* clear all session cookies' value */
35b3515be0ecb9d Menglong Dong  2026-02-08  1177  		for (i = 0; i < cookie_cnt; i++)
35b3515be0ecb9d Menglong Dong  2026-02-08  1178  			emit_sd(RV_REG_FP, -cookie_off + 8 * i, RV_REG_ZERO, ctx);
35b3515be0ecb9d Menglong Dong  2026-02-08  1179  		/* clear return value to make sure fentry always get 0 */
35b3515be0ecb9d Menglong Dong  2026-02-08  1180  		emit_sd(RV_REG_FP, -retval_off, RV_REG_ZERO, ctx);
35b3515be0ecb9d Menglong Dong  2026-02-08  1181  	}
35b3515be0ecb9d Menglong Dong  2026-02-08  1182  
49b5e77ae3e214a Pu Lehui       2023-02-15  1183  	if (flags & BPF_TRAMP_F_CALL_ORIG) {
9f1e16fb1fc9826 Pu Lehui       2024-06-22  1184  		emit_imm(RV_REG_A0, ctx->insns ? (const s64)im : RV_MAX_COUNT_IMM, ctx);
49b5e77ae3e214a Pu Lehui       2023-02-15  1185  		ret = emit_call((const u64)__bpf_tramp_enter, true, ctx);
49b5e77ae3e214a Pu Lehui       2023-02-15  1186  		if (ret)
49b5e77ae3e214a Pu Lehui       2023-02-15  1187  			return ret;
49b5e77ae3e214a Pu Lehui       2023-02-15  1188  	}
49b5e77ae3e214a Pu Lehui       2023-02-15  1189  
35b3515be0ecb9d Menglong Dong  2026-02-08  1190  	if (fentry->nr_links) {
35b3515be0ecb9d Menglong Dong  2026-02-08  1191  		ret = invoke_bpf(fentry, args_off, retval_off, run_ctx_off, func_meta_off,
35b3515be0ecb9d Menglong Dong  2026-02-08  1192  				 flags & BPF_TRAMP_F_RET_FENTRY_RET, func_meta, cookie_off, ctx);
49b5e77ae3e214a Pu Lehui       2023-02-15  1193  		if (ret)
49b5e77ae3e214a Pu Lehui       2023-02-15  1194  			return ret;
49b5e77ae3e214a Pu Lehui       2023-02-15  1195  	}
49b5e77ae3e214a Pu Lehui       2023-02-15  1196  
49b5e77ae3e214a Pu Lehui       2023-02-15  1197  	if (fmod_ret->nr_links) {
49b5e77ae3e214a Pu Lehui       2023-02-15  1198  		branches_off = kcalloc(fmod_ret->nr_links, sizeof(int), GFP_KERNEL);
49b5e77ae3e214a Pu Lehui       2023-02-15  1199  		if (!branches_off)
49b5e77ae3e214a Pu Lehui       2023-02-15  1200  			return -ENOMEM;
49b5e77ae3e214a Pu Lehui       2023-02-15  1201  
49b5e77ae3e214a Pu Lehui       2023-02-15  1202  		/* cleanup to avoid garbage return value confusion */
49b5e77ae3e214a Pu Lehui       2023-02-15  1203  		emit_sd(RV_REG_FP, -retval_off, RV_REG_ZERO, ctx);
49b5e77ae3e214a Pu Lehui       2023-02-15  1204  		for (i = 0; i < fmod_ret->nr_links; i++) {
49b5e77ae3e214a Pu Lehui       2023-02-15  1205  			ret = invoke_bpf_prog(fmod_ret->links[i], args_off, retval_off,
49b5e77ae3e214a Pu Lehui       2023-02-15  1206  					      run_ctx_off, true, ctx);
49b5e77ae3e214a Pu Lehui       2023-02-15  1207  			if (ret)
49b5e77ae3e214a Pu Lehui       2023-02-15  1208  				goto out;
49b5e77ae3e214a Pu Lehui       2023-02-15  1209  			emit_ld(RV_REG_T1, -retval_off, RV_REG_FP, ctx);
49b5e77ae3e214a Pu Lehui       2023-02-15  1210  			branches_off[i] = ctx->ninsns;
49b5e77ae3e214a Pu Lehui       2023-02-15  1211  			/* nop reserved for conditional jump */
49b5e77ae3e214a Pu Lehui       2023-02-15  1212  			emit(rv_nop(), ctx);
49b5e77ae3e214a Pu Lehui       2023-02-15  1213  		}
49b5e77ae3e214a Pu Lehui       2023-02-15  1214  	}
49b5e77ae3e214a Pu Lehui       2023-02-15  1215  
49b5e77ae3e214a Pu Lehui       2023-02-15  1216  	if (flags & BPF_TRAMP_F_CALL_ORIG) {
8f3e00af8e52c0d Menglong Dong  2025-12-19  1217  		/* skip to actual body of traced function */
8f3e00af8e52c0d Menglong Dong  2025-12-19  1218  		orig_call += RV_FENTRY_NINSNS * 4;
6801b0aef79db47 Pu Lehui       2024-07-02  1219  		restore_args(min_t(int, nr_arg_slots, RV_MAX_REG_ARGS), args_off, ctx);
6801b0aef79db47 Pu Lehui       2024-07-02  1220  		restore_stack_args(nr_arg_slots - RV_MAX_REG_ARGS, args_off, stk_arg_off, ctx);
49b5e77ae3e214a Pu Lehui       2023-02-15  1221  		ret = emit_call((const u64)orig_call, true, ctx);
49b5e77ae3e214a Pu Lehui       2023-02-15  1222  		if (ret)
49b5e77ae3e214a Pu Lehui       2023-02-15  1223  			goto out;
49b5e77ae3e214a Pu Lehui       2023-02-15  1224  		emit_sd(RV_REG_FP, -retval_off, RV_REG_A0, ctx);
7112cd26e606c7b Björn Töpel    2023-10-04  1225  		emit_sd(RV_REG_FP, -(retval_off - 8), regmap[BPF_REG_0], ctx);
2382a405c581ae8 Pu Lehui       2024-06-22  1226  		im->ip_after_call = ctx->ro_insns + ctx->ninsns;
49b5e77ae3e214a Pu Lehui       2023-02-15  1227  		/* 2 nops reserved for auipc+jalr pair */
49b5e77ae3e214a Pu Lehui       2023-02-15  1228  		emit(rv_nop(), ctx);
49b5e77ae3e214a Pu Lehui       2023-02-15  1229  		emit(rv_nop(), ctx);
49b5e77ae3e214a Pu Lehui       2023-02-15  1230  	}
49b5e77ae3e214a Pu Lehui       2023-02-15  1231  
49b5e77ae3e214a Pu Lehui       2023-02-15  1232  	/* update branches saved in invoke_bpf_mod_ret with bnez */
49b5e77ae3e214a Pu Lehui       2023-02-15  1233  	for (i = 0; ctx->insns && i < fmod_ret->nr_links; i++) {
49b5e77ae3e214a Pu Lehui       2023-02-15  1234  		offset = ninsns_rvoff(ctx->ninsns - branches_off[i]);
49b5e77ae3e214a Pu Lehui       2023-02-15  1235  		insn = rv_bne(RV_REG_T1, RV_REG_ZERO, offset >> 1);
49b5e77ae3e214a Pu Lehui       2023-02-15  1236  		*(u32 *)(ctx->insns + branches_off[i]) = insn;
49b5e77ae3e214a Pu Lehui       2023-02-15  1237  	}
49b5e77ae3e214a Pu Lehui       2023-02-15  1238  
35b3515be0ecb9d Menglong Dong  2026-02-08  1239  	/* set "is_return" flag for fsession */
35b3515be0ecb9d Menglong Dong  2026-02-08  1240  	func_meta |= (1ULL << BPF_TRAMP_IS_RETURN_SHIFT);
35b3515be0ecb9d Menglong Dong  2026-02-08  1241  	if (bpf_fsession_cnt(tlinks))
35b3515be0ecb9d Menglong Dong  2026-02-08  1242  		emit_store_stack_imm64(RV_REG_T1, -func_meta_off, func_meta, ctx);
35b3515be0ecb9d Menglong Dong  2026-02-08  1243  
35b3515be0ecb9d Menglong Dong  2026-02-08  1244  	if (fexit->nr_links) {
35b3515be0ecb9d Menglong Dong  2026-02-08  1245  		ret = invoke_bpf(fexit, args_off, retval_off, run_ctx_off, func_meta_off,
35b3515be0ecb9d Menglong Dong  2026-02-08  1246  				 false, func_meta, cookie_off, ctx);
49b5e77ae3e214a Pu Lehui       2023-02-15  1247  		if (ret)
49b5e77ae3e214a Pu Lehui       2023-02-15  1248  			goto out;
49b5e77ae3e214a Pu Lehui       2023-02-15  1249  	}
49b5e77ae3e214a Pu Lehui       2023-02-15  1250  
49b5e77ae3e214a Pu Lehui       2023-02-15  1251  	if (flags & BPF_TRAMP_F_CALL_ORIG) {
2382a405c581ae8 Pu Lehui       2024-06-22  1252  		im->ip_epilogue = ctx->ro_insns + ctx->ninsns;
9f1e16fb1fc9826 Pu Lehui       2024-06-22  1253  		emit_imm(RV_REG_A0, ctx->insns ? (const s64)im : RV_MAX_COUNT_IMM, ctx);
49b5e77ae3e214a Pu Lehui       2023-02-15  1254  		ret = emit_call((const u64)__bpf_tramp_exit, true, ctx);
49b5e77ae3e214a Pu Lehui       2023-02-15  1255  		if (ret)
49b5e77ae3e214a Pu Lehui       2023-02-15  1256  			goto out;
49b5e77ae3e214a Pu Lehui       2023-02-15  1257  	}
49b5e77ae3e214a Pu Lehui       2023-02-15  1258  
49b5e77ae3e214a Pu Lehui       2023-02-15  1259  	if (flags & BPF_TRAMP_F_RESTORE_REGS)
6801b0aef79db47 Pu Lehui       2024-07-02  1260  		restore_args(min_t(int, nr_arg_slots, RV_MAX_REG_ARGS), args_off, ctx);
49b5e77ae3e214a Pu Lehui       2023-02-15  1261  
7112cd26e606c7b Björn Töpel    2023-10-04  1262  	if (save_ret) {
7112cd26e606c7b Björn Töpel    2023-10-04  1263  		emit_ld(regmap[BPF_REG_0], -(retval_off - 8), RV_REG_FP, ctx);
fd2e08128944a76 Hengqi Chen    2025-09-08  1264  		if (is_struct_ops) {
fd2e08128944a76 Hengqi Chen    2025-09-08  1265  			ret = sign_extend(RV_REG_A0, regmap[BPF_REG_0], m->ret_size,
fd2e08128944a76 Hengqi Chen    2025-09-08  1266  					  m->ret_flags & BTF_FMODEL_SIGNED_ARG, ctx);
fd2e08128944a76 Hengqi Chen    2025-09-08  1267  			if (ret)
fd2e08128944a76 Hengqi Chen    2025-09-08  1268  				goto out;
fd2e08128944a76 Hengqi Chen    2025-09-08  1269  		} else {
fd2e08128944a76 Hengqi Chen    2025-09-08  1270  			emit_ld(RV_REG_A0, -retval_off, RV_REG_FP, ctx);
fd2e08128944a76 Hengqi Chen    2025-09-08  1271  		}
7112cd26e606c7b Björn Töpel    2023-10-04  1272  	}
49b5e77ae3e214a Pu Lehui       2023-02-15  1273  
49b5e77ae3e214a Pu Lehui       2023-02-15  1274  	emit_ld(RV_REG_S1, -sreg_off, RV_REG_FP, ctx);
49b5e77ae3e214a Pu Lehui       2023-02-15  1275  
1732ebc4a26181c Pu Lehui       2024-01-23  1276  	if (!is_struct_ops) {
25ad10658dc1068 Pu Lehui       2023-07-21  1277  		/* trampoline called from function entry */
25ad10658dc1068 Pu Lehui       2023-07-21  1278  		emit_ld(RV_REG_T0, stack_size - 8, RV_REG_SP, ctx);
25ad10658dc1068 Pu Lehui       2023-07-21  1279  		emit_ld(RV_REG_FP, stack_size - 16, RV_REG_SP, ctx);
25ad10658dc1068 Pu Lehui       2023-07-21  1280  		emit_addi(RV_REG_SP, RV_REG_SP, stack_size, ctx);
25ad10658dc1068 Pu Lehui       2023-07-21  1281  
25ad10658dc1068 Pu Lehui       2023-07-21  1282  		emit_ld(RV_REG_RA, 8, RV_REG_SP, ctx);
25ad10658dc1068 Pu Lehui       2023-07-21  1283  		emit_ld(RV_REG_FP, 0, RV_REG_SP, ctx);
25ad10658dc1068 Pu Lehui       2023-07-21  1284  		emit_addi(RV_REG_SP, RV_REG_SP, 16, ctx);
25ad10658dc1068 Pu Lehui       2023-07-21  1285  
49b5e77ae3e214a Pu Lehui       2023-02-15  1286  		if (flags & BPF_TRAMP_F_SKIP_FRAME)
25ad10658dc1068 Pu Lehui       2023-07-21  1287  			/* return to parent function */
25ad10658dc1068 Pu Lehui       2023-07-21  1288  			emit_jalr(RV_REG_ZERO, RV_REG_RA, 0, ctx);
49b5e77ae3e214a Pu Lehui       2023-02-15  1289  		else
25ad10658dc1068 Pu Lehui       2023-07-21  1290  			/* return to traced function */
25ad10658dc1068 Pu Lehui       2023-07-21  1291  			emit_jalr(RV_REG_ZERO, RV_REG_T0, 0, ctx);
25ad10658dc1068 Pu Lehui       2023-07-21  1292  	} else {
25ad10658dc1068 Pu Lehui       2023-07-21  1293  		/* trampoline called directly */
25ad10658dc1068 Pu Lehui       2023-07-21  1294  		emit_ld(RV_REG_RA, stack_size - 8, RV_REG_SP, ctx);
25ad10658dc1068 Pu Lehui       2023-07-21  1295  		emit_ld(RV_REG_FP, stack_size - 16, RV_REG_SP, ctx);
49b5e77ae3e214a Pu Lehui       2023-02-15  1296  		emit_addi(RV_REG_SP, RV_REG_SP, stack_size, ctx);
49b5e77ae3e214a Pu Lehui       2023-02-15  1297  
49b5e77ae3e214a Pu Lehui       2023-02-15  1298  		emit_jalr(RV_REG_ZERO, RV_REG_RA, 0, ctx);
25ad10658dc1068 Pu Lehui       2023-07-21  1299  	}
49b5e77ae3e214a Pu Lehui       2023-02-15  1300  
49b5e77ae3e214a Pu Lehui       2023-02-15  1301  	ret = ctx->ninsns;
49b5e77ae3e214a Pu Lehui       2023-02-15  1302  out:
49b5e77ae3e214a Pu Lehui       2023-02-15  1303  	kfree(branches_off);
49b5e77ae3e214a Pu Lehui       2023-02-15  1304  	return ret;
49b5e77ae3e214a Pu Lehui       2023-02-15  1305  }
49b5e77ae3e214a Pu Lehui       2023-02-15  1306  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
