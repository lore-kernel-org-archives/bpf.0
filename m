Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85406101C2
	for <bpf@vger.kernel.org>; Sat, 30 Mar 2024 09:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711791513; cv=none; b=qEzeSDCMwSoz64A1CdzTCQy05j4+mBjBxvo8DA+XAnZkTfnbiNvvCi2LdfFrZVApwR19sF2TCg4y2HUsE4XE+HWWZFclFKuMtLBAQ5yeFTlv51uOgPrmuFfwe59ja6i1PXzPo6ub+IT7mHL+UV4/Hp20h3B8kuNZtr4Y+YMh1sQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711791513; c=relaxed/simple;
	bh=+UDvDzkEealmmiWn3qyXkFv8xSxGpYh+eHNDrKmB8c4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yqv/0npzuIrz7D0mrvCZiqB8/Wrcge2Eo9+TjcY8YdqVxIWYk0hwEtpzbZ1M0XZcO1D2/qNPDVGf4jvUZ5VzwrUjT+gi8jiyyGT1C4mHE+/fu4HMoyjQCfb8PQOl/kwdti5nZ8BYmBMuQzulCXZeeiM0JozmGY9TOL8WDMaqO40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AiTuGhxx; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AiTuGhxx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711791510; x=1743327510;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+UDvDzkEealmmiWn3qyXkFv8xSxGpYh+eHNDrKmB8c4=;
  b=AiTuGhxxmHsHsmmuU/jtitOYsGku13eaR8ljHBx2u/QmNv+Xn+EiOTYB
   tAxhNQF9fIeDfJJ8NjSHMzSAbZf8YkWtAKsvhkidTKRU8gmv8GuUVc3nZ
   lxOscbXChQZ0vqxUwlRJdXa7N7eLVf6ZPk6rCTkrf1mw/6PqN/sSpaFH5
   Z7wZZJgpaJBbQdaN0904fWcwNjJiy1dRO/k5p3Wnpgono3QE3y0YVU9ip
   UpO34Xib3Rh+dq5pww2DVwCm47YqNuSjapEWlwQioBpLEUAMReh2kBjXG
   Vf1RKr3qf7bomHT/BkiQU5ZgDGLsYNL1/a2HCkpZ42U4zaD3MVeDS7XUv
   g==;
X-CSE-ConnectionGUID: VhpukrYwQv+FW19UFm3dVg==
X-CSE-MsgGUID: YGOMJf4IQC2sifE9vQQzng==
X-IronPort-AV: E=McAfee;i="6600,9927,11028"; a="9922947"
X-IronPort-AV: E=Sophos;i="6.07,166,1708416000"; 
   d="scan'208";a="9922947"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2024 02:38:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,166,1708416000"; 
   d="scan'208";a="17239943"
Received: from lkp-server01.sh.intel.com (HELO be39aa325d23) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 30 Mar 2024 02:38:26 -0700
Received: from kbuild by be39aa325d23 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rqVAO-00047m-07;
	Sat, 30 Mar 2024 09:38:24 +0000
Date: Sat, 30 Mar 2024 17:37:48 +0800
From: kernel test robot <lkp@intel.com>
To: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	ast@kernel.org, daniel@iogearbox.net, martin.lau@kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, andrii@kernel.org,
	kernel-team@meta.com
Subject: Re: [PATCH bpf-next 2/4] bpf: inline bpf_get_smp_processor_id()
 helper
Message-ID: <202403301711.Z4Wp1R02-lkp@intel.com>
References: <20240329184740.4084786-3-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240329184740.4084786-3-andrii@kernel.org>

Hi Andrii,

kernel test robot noticed the following build errors:

[auto build test ERROR on bpf-next/master]

url:    https://github.com/intel-lab-lkp/linux/commits/Andrii-Nakryiko/bpf-add-internal-only-per-CPU-LDX-instructions/20240330-025035
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
patch link:    https://lore.kernel.org/r/20240329184740.4084786-3-andrii%40kernel.org
patch subject: [PATCH bpf-next 2/4] bpf: inline bpf_get_smp_processor_id() helper
config: arm-randconfig-001-20240330 (https://download.01.org/0day-ci/archive/20240330/202403301711.Z4Wp1R02-lkp@intel.com/config)
compiler: clang version 19.0.0git (https://github.com/llvm/llvm-project 79ba323bdd0843275019e16b6e9b35133677c514)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240330/202403301711.Z4Wp1R02-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202403301711.Z4Wp1R02-lkp@intel.com/

All errors (new ones prefixed by >>):

          |                                        ~~~~~~~~~~~~~~~~~~ ^ ~~~~~~~~
   kernel/bpf/verifier.c:10532:42: warning: bitwise operation between different enumeration types ('enum bpf_reg_type' and 'enum bpf_type_flag') [-Wenum-enum-conversion]
    10532 |                 regs[BPF_REG_0].type = PTR_TO_TCP_SOCK | ret_flag;
          |                                        ~~~~~~~~~~~~~~~ ^ ~~~~~~~~
   kernel/bpf/verifier.c:10536:37: warning: bitwise operation between different enumeration types ('enum bpf_reg_type' and 'enum bpf_type_flag') [-Wenum-enum-conversion]
    10536 |                 regs[BPF_REG_0].type = PTR_TO_MEM | ret_flag;
          |                                        ~~~~~~~~~~ ^ ~~~~~~~~
   kernel/bpf/verifier.c:10558:38: warning: bitwise operation between different enumeration types ('enum bpf_reg_type' and 'enum bpf_type_flag') [-Wenum-enum-conversion]
    10558 |                         regs[BPF_REG_0].type = PTR_TO_MEM | ret_flag;
          |                                                ~~~~~~~~~~ ^ ~~~~~~~~
   kernel/bpf/verifier.c:10562:42: warning: bitwise operation between different enumeration types ('enum bpf_reg_type' and 'enum bpf_type_flag') [-Wenum-enum-conversion]
    10562 |                                 regs[BPF_REG_0].type = PTR_TO_BTF_ID | MEM_ALLOC | MEM_RCU;
          |                                                        ~~~~~~~~~~~~~ ^ ~~~~~~~~~
   kernel/bpf/verifier.c:10570:42: warning: bitwise operation between different enumeration types ('enum bpf_reg_type' and 'enum bpf_type_flag') [-Wenum-enum-conversion]
    10570 |                                 regs[BPF_REG_0].type = PTR_TO_BTF_ID | ret_flag;
          |                                                        ~~~~~~~~~~~~~ ^ ~~~~~~~~
   kernel/bpf/verifier.c:10584:40: warning: bitwise operation between different enumeration types ('enum bpf_reg_type' and 'enum bpf_type_flag') [-Wenum-enum-conversion]
    10584 |                 regs[BPF_REG_0].type = PTR_TO_BTF_ID | ret_flag;
          |                                        ~~~~~~~~~~~~~ ^ ~~~~~~~~
   kernel/bpf/verifier.c:11324:21: warning: bitwise operation between different enumeration types ('enum bpf_reg_type' and 'enum bpf_type_flag') [-Wenum-enum-conversion]
    11324 |         case PTR_TO_BTF_ID | MEM_ALLOC:
          |              ~~~~~~~~~~~~~ ^ ~~~~~~~~~
   kernel/bpf/verifier.c:11779:36: warning: bitwise operation between different enumeration types ('enum bpf_reg_type' and 'enum bpf_type_flag') [-Wenum-enum-conversion]
    11779 |                         if (reg->type == (PTR_TO_BTF_ID | MEM_ALLOC)) {
          |                                           ~~~~~~~~~~~~~ ^ ~~~~~~~~~
   kernel/bpf/verifier.c:11784:43: warning: bitwise operation between different enumeration types ('enum bpf_reg_type' and 'enum bpf_type_flag') [-Wenum-enum-conversion]
    11784 |                         } else if (reg->type == (PTR_TO_BTF_ID | MEM_ALLOC | MEM_PERCPU)) {
          |                                                  ~~~~~~~~~~~~~ ^ ~~~~~~~~~
   kernel/bpf/verifier.c:11824:25: warning: bitwise operation between different enumeration types ('enum bpf_arg_type' and 'enum bpf_type_flag') [-Wenum-enum-conversion]
    11824 |                                    (dynptr_arg_type & MEM_UNINIT)) {
          |                                     ~~~~~~~~~~~~~~~ ^ ~~~~~~~~~~
   kernel/bpf/verifier.c:11844:26: warning: bitwise operation between different enumeration types ('enum bpf_arg_type' and 'enum bpf_type_flag') [-Wenum-enum-conversion]
    11844 |                         if (!(dynptr_arg_type & MEM_UNINIT)) {
          |                               ~~~~~~~~~~~~~~~ ^ ~~~~~~~~~~
   kernel/bpf/verifier.c:11871:36: warning: bitwise operation between different enumeration types ('enum bpf_reg_type' and 'enum bpf_type_flag') [-Wenum-enum-conversion]
    11871 |                             reg->type != (PTR_TO_BTF_ID | MEM_ALLOC)) {
          |                                           ~~~~~~~~~~~~~ ^ ~~~~~~~~~
   kernel/bpf/verifier.c:11875:36: warning: bitwise operation between different enumeration types ('enum bpf_reg_type' and 'enum bpf_type_flag') [-Wenum-enum-conversion]
    11875 |                         if (reg->type == (PTR_TO_BTF_ID | MEM_ALLOC) && !reg->ref_obj_id) {
          |                                           ~~~~~~~~~~~~~ ^ ~~~~~~~~~
   kernel/bpf/verifier.c:11885:36: warning: bitwise operation between different enumeration types ('enum bpf_reg_type' and 'enum bpf_type_flag') [-Wenum-enum-conversion]
    11885 |                             reg->type != (PTR_TO_BTF_ID | MEM_ALLOC)) {
          |                                           ~~~~~~~~~~~~~ ^ ~~~~~~~~~
   kernel/bpf/verifier.c:11889:36: warning: bitwise operation between different enumeration types ('enum bpf_reg_type' and 'enum bpf_type_flag') [-Wenum-enum-conversion]
    11889 |                         if (reg->type == (PTR_TO_BTF_ID | MEM_ALLOC) && !reg->ref_obj_id) {
          |                                           ~~~~~~~~~~~~~ ^ ~~~~~~~~~
   kernel/bpf/verifier.c:11898:36: warning: bitwise operation between different enumeration types ('enum bpf_reg_type' and 'enum bpf_type_flag') [-Wenum-enum-conversion]
    11898 |                         if (reg->type != (PTR_TO_BTF_ID | MEM_ALLOC)) {
          |                                           ~~~~~~~~~~~~~ ^ ~~~~~~~~~
   kernel/bpf/verifier.c:11921:37: warning: bitwise operation between different enumeration types ('enum bpf_reg_type' and 'enum bpf_type_flag') [-Wenum-enum-conversion]
    11921 |                                 if (reg->type != (PTR_TO_BTF_ID | MEM_ALLOC)) {
          |                                                   ~~~~~~~~~~~~~ ^ ~~~~~~~~~
   kernel/bpf/verifier.c:12166:19: warning: bitwise operation between different enumeration types ('enum bpf_reg_type' and 'enum bpf_type_flag') [-Wenum-enum-conversion]
    12166 |                                 if (reg->type & MEM_RCU) {
          |                                     ~~~~~~~~~ ^ ~~~~~~~
   include/linux/bpf_verifier.h:476:12: note: expanded from macro 'bpf_for_each_reg_in_vstate_mask'
     476 |                                 (void)(__expr);                          \
         |                                        ^~~~~~
   kernel/bpf/verifier.c:12166:19: warning: bitwise operation between different enumeration types ('enum bpf_reg_type' and 'enum bpf_type_flag') [-Wenum-enum-conversion]
    12166 |                                 if (reg->type & MEM_RCU) {
          |                                     ~~~~~~~~~ ^ ~~~~~~~
   include/linux/bpf_verifier.h:481:12: note: expanded from macro 'bpf_for_each_reg_in_vstate_mask'
     481 |                                 (void)(__expr);                          \
         |                                        ^~~~~~
   kernel/bpf/verifier.c:12330:42: warning: bitwise operation between different enumeration types ('enum bpf_reg_type' and 'enum bpf_type_flag') [-Wenum-enum-conversion]
    12330 |                                 regs[BPF_REG_0].type = PTR_TO_BTF_ID | MEM_ALLOC;
          |                                                        ~~~~~~~~~~~~~ ^ ~~~~~~~~~
   kernel/bpf/verifier.c:12340:42: warning: bitwise operation between different enumeration types ('enum bpf_reg_type' and 'enum bpf_type_flag') [-Wenum-enum-conversion]
    12340 |                                 regs[BPF_REG_0].type = PTR_TO_BTF_ID | MEM_ALLOC;
          |                                                        ~~~~~~~~~~~~~ ^ ~~~~~~~~~
   kernel/bpf/verifier.c:12359:42: warning: bitwise operation between different enumeration types ('enum bpf_reg_type' and 'enum bpf_type_flag') [-Wenum-enum-conversion]
    12359 |                                 regs[BPF_REG_0].type = PTR_TO_BTF_ID | PTR_TRUSTED;
          |                                                        ~~~~~~~~~~~~~ ^ ~~~~~~~~~~~
   kernel/bpf/verifier.c:12371:42: warning: bitwise operation between different enumeration types ('enum bpf_reg_type' and 'enum bpf_type_flag') [-Wenum-enum-conversion]
    12371 |                                 regs[BPF_REG_0].type = PTR_TO_BTF_ID | PTR_UNTRUSTED;
          |                                                        ~~~~~~~~~~~~~ ^ ~~~~~~~~~~~~~
   kernel/bpf/verifier.c:12388:39: warning: bitwise operation between different enumeration types ('enum bpf_reg_type' and 'enum bpf_type_flag') [-Wenum-enum-conversion]
    12388 |                                 regs[BPF_REG_0].type = PTR_TO_MEM | type_flag;
          |                                                        ~~~~~~~~~~ ^ ~~~~~~~~~
   kernel/bpf/verifier.c:12948:20: warning: bitwise operation between different enumeration types ('const enum bpf_reg_type' and 'enum bpf_type_flag') [-Wenum-enum-conversion]
    12948 |         if (ptr_reg->type & PTR_MAYBE_NULL) {
          |             ~~~~~~~~~~~~~ ^ ~~~~~~~~~~~~~~
   kernel/bpf/verifier.c:17572:31: warning: bitwise operation between different enumeration types ('enum bpf_reg_type' and 'enum bpf_type_flag') [-Wenum-enum-conversion]
    17572 |                         *prev_type = PTR_TO_BTF_ID | PTR_UNTRUSTED;
          |                                      ~~~~~~~~~~~~~ ^ ~~~~~~~~~~~~~
   kernel/bpf/verifier.c:18030:38: warning: bitwise operation between different enumeration types ('enum bpf_reg_type' and 'enum bpf_type_flag') [-Wenum-enum-conversion]
    18030 |                 aux->btf_var.reg_type = PTR_TO_MEM | MEM_RDONLY;
          |                                         ~~~~~~~~~~ ^ ~~~~~~~~~~
   kernel/bpf/verifier.c:18049:41: warning: bitwise operation between different enumeration types ('enum bpf_reg_type' and 'enum bpf_type_flag') [-Wenum-enum-conversion]
    18049 |                 aux->btf_var.reg_type = PTR_TO_BTF_ID | MEM_PERCPU;
          |                                         ~~~~~~~~~~~~~ ^ ~~~~~~~~~~
   kernel/bpf/verifier.c:18066:38: warning: bitwise operation between different enumeration types ('enum bpf_reg_type' and 'enum bpf_type_flag') [-Wenum-enum-conversion]
    18066 |                 aux->btf_var.reg_type = PTR_TO_MEM | MEM_RDONLY;
          |                                         ~~~~~~~~~~ ^ ~~~~~~~~~~
   kernel/bpf/verifier.c:19001:22: warning: bitwise operation between different enumeration types ('enum bpf_reg_type' and 'enum bpf_type_flag') [-Wenum-enum-conversion]
    19001 |                 case PTR_TO_BTF_ID | PTR_UNTRUSTED:
          |                      ~~~~~~~~~~~~~ ^ ~~~~~~~~~~~~~
   kernel/bpf/verifier.c:19008:22: warning: bitwise operation between different enumeration types ('enum bpf_reg_type' and 'enum bpf_type_flag') [-Wenum-enum-conversion]
    19008 |                 case PTR_TO_BTF_ID | MEM_ALLOC | PTR_UNTRUSTED:
          |                      ~~~~~~~~~~~~~ ^ ~~~~~~~~~
>> kernel/bpf/verifier.c:20078:55: error: use of undeclared identifier 'pcpu_hot'
    20078 |                         insn_buf[0] = BPF_MOV32_IMM(BPF_REG_0, (u32)(long)&pcpu_hot.cpu_number);
          |                                                                            ^
   kernel/bpf/verifier.c:20491:51: warning: bitwise operation between different enumeration types ('enum bpf_arg_type' and 'enum bpf_type_flag') [-Wenum-enum-conversion]
    20491 |                         } else if (arg->arg_type == (ARG_PTR_TO_DYNPTR | MEM_RDONLY)) {
          |                                                      ~~~~~~~~~~~~~~~~~ ^ ~~~~~~~~~~
   kernel/bpf/verifier.c:20496:23: warning: bitwise operation between different enumeration types ('enum bpf_arg_type' and 'enum bpf_type_flag') [-Wenum-enum-conversion]
    20496 |                                 if (arg->arg_type & PTR_MAYBE_NULL)
          |                                     ~~~~~~~~~~~~~ ^ ~~~~~~~~~~~~~~
   kernel/bpf/verifier.c:20503:23: warning: bitwise operation between different enumeration types ('enum bpf_arg_type' and 'enum bpf_type_flag') [-Wenum-enum-conversion]
    20503 |                                 if (arg->arg_type & PTR_MAYBE_NULL)
          |                                     ~~~~~~~~~~~~~ ^ ~~~~~~~~~~~~~~
   kernel/bpf/verifier.c:20505:23: warning: bitwise operation between different enumeration types ('enum bpf_arg_type' and 'enum bpf_type_flag') [-Wenum-enum-conversion]
    20505 |                                 if (arg->arg_type & PTR_UNTRUSTED)
          |                                     ~~~~~~~~~~~~~ ^ ~~~~~~~~~~~~~
   kernel/bpf/verifier.c:20507:23: warning: bitwise operation between different enumeration types ('enum bpf_arg_type' and 'enum bpf_type_flag') [-Wenum-enum-conversion]
    20507 |                                 if (arg->arg_type & PTR_TRUSTED)
          |                                     ~~~~~~~~~~~~~ ^ ~~~~~~~~~~~
   99 warnings and 1 error generated.


vim +/pcpu_hot +20078 kernel/bpf/verifier.c

 19587	
 19588	/* Do various post-verification rewrites in a single program pass.
 19589	 * These rewrites simplify JIT and interpreter implementations.
 19590	 */
 19591	static int do_misc_fixups(struct bpf_verifier_env *env)
 19592	{
 19593		struct bpf_prog *prog = env->prog;
 19594		enum bpf_attach_type eatype = prog->expected_attach_type;
 19595		enum bpf_prog_type prog_type = resolve_prog_type(prog);
 19596		struct bpf_insn *insn = prog->insnsi;
 19597		const struct bpf_func_proto *fn;
 19598		const int insn_cnt = prog->len;
 19599		const struct bpf_map_ops *ops;
 19600		struct bpf_insn_aux_data *aux;
 19601		struct bpf_insn insn_buf[16];
 19602		struct bpf_prog *new_prog;
 19603		struct bpf_map *map_ptr;
 19604		int i, ret, cnt, delta = 0, cur_subprog = 0;
 19605		struct bpf_subprog_info *subprogs = env->subprog_info;
 19606		u16 stack_depth = subprogs[cur_subprog].stack_depth;
 19607		u16 stack_depth_extra = 0;
 19608	
 19609		if (env->seen_exception && !env->exception_callback_subprog) {
 19610			struct bpf_insn patch[] = {
 19611				env->prog->insnsi[insn_cnt - 1],
 19612				BPF_MOV64_REG(BPF_REG_0, BPF_REG_1),
 19613				BPF_EXIT_INSN(),
 19614			};
 19615	
 19616			ret = add_hidden_subprog(env, patch, ARRAY_SIZE(patch));
 19617			if (ret < 0)
 19618				return ret;
 19619			prog = env->prog;
 19620			insn = prog->insnsi;
 19621	
 19622			env->exception_callback_subprog = env->subprog_cnt - 1;
 19623			/* Don't update insn_cnt, as add_hidden_subprog always appends insns */
 19624			mark_subprog_exc_cb(env, env->exception_callback_subprog);
 19625		}
 19626	
 19627		for (i = 0; i < insn_cnt;) {
 19628			if (insn->code == (BPF_ALU64 | BPF_MOV | BPF_X) && insn->imm) {
 19629				if ((insn->off == BPF_ADDR_SPACE_CAST && insn->imm == 1) ||
 19630				    (((struct bpf_map *)env->prog->aux->arena)->map_flags & BPF_F_NO_USER_CONV)) {
 19631					/* convert to 32-bit mov that clears upper 32-bit */
 19632					insn->code = BPF_ALU | BPF_MOV | BPF_X;
 19633					/* clear off and imm, so it's a normal 'wX = wY' from JIT pov */
 19634					insn->off = 0;
 19635					insn->imm = 0;
 19636				} /* cast from as(0) to as(1) should be handled by JIT */
 19637				goto next_insn;
 19638			}
 19639	
 19640			if (env->insn_aux_data[i + delta].needs_zext)
 19641				/* Convert BPF_CLASS(insn->code) == BPF_ALU64 to 32-bit ALU */
 19642				insn->code = BPF_ALU | BPF_OP(insn->code) | BPF_SRC(insn->code);
 19643	
 19644			/* Make divide-by-zero exceptions impossible. */
 19645			if (insn->code == (BPF_ALU64 | BPF_MOD | BPF_X) ||
 19646			    insn->code == (BPF_ALU64 | BPF_DIV | BPF_X) ||
 19647			    insn->code == (BPF_ALU | BPF_MOD | BPF_X) ||
 19648			    insn->code == (BPF_ALU | BPF_DIV | BPF_X)) {
 19649				bool is64 = BPF_CLASS(insn->code) == BPF_ALU64;
 19650				bool isdiv = BPF_OP(insn->code) == BPF_DIV;
 19651				struct bpf_insn *patchlet;
 19652				struct bpf_insn chk_and_div[] = {
 19653					/* [R,W]x div 0 -> 0 */
 19654					BPF_RAW_INSN((is64 ? BPF_JMP : BPF_JMP32) |
 19655						     BPF_JNE | BPF_K, insn->src_reg,
 19656						     0, 2, 0),
 19657					BPF_ALU32_REG(BPF_XOR, insn->dst_reg, insn->dst_reg),
 19658					BPF_JMP_IMM(BPF_JA, 0, 0, 1),
 19659					*insn,
 19660				};
 19661				struct bpf_insn chk_and_mod[] = {
 19662					/* [R,W]x mod 0 -> [R,W]x */
 19663					BPF_RAW_INSN((is64 ? BPF_JMP : BPF_JMP32) |
 19664						     BPF_JEQ | BPF_K, insn->src_reg,
 19665						     0, 1 + (is64 ? 0 : 1), 0),
 19666					*insn,
 19667					BPF_JMP_IMM(BPF_JA, 0, 0, 1),
 19668					BPF_MOV32_REG(insn->dst_reg, insn->dst_reg),
 19669				};
 19670	
 19671				patchlet = isdiv ? chk_and_div : chk_and_mod;
 19672				cnt = isdiv ? ARRAY_SIZE(chk_and_div) :
 19673					      ARRAY_SIZE(chk_and_mod) - (is64 ? 2 : 0);
 19674	
 19675				new_prog = bpf_patch_insn_data(env, i + delta, patchlet, cnt);
 19676				if (!new_prog)
 19677					return -ENOMEM;
 19678	
 19679				delta    += cnt - 1;
 19680				env->prog = prog = new_prog;
 19681				insn      = new_prog->insnsi + i + delta;
 19682				goto next_insn;
 19683			}
 19684	
 19685			/* Implement LD_ABS and LD_IND with a rewrite, if supported by the program type. */
 19686			if (BPF_CLASS(insn->code) == BPF_LD &&
 19687			    (BPF_MODE(insn->code) == BPF_ABS ||
 19688			     BPF_MODE(insn->code) == BPF_IND)) {
 19689				cnt = env->ops->gen_ld_abs(insn, insn_buf);
 19690				if (cnt == 0 || cnt >= ARRAY_SIZE(insn_buf)) {
 19691					verbose(env, "bpf verifier is misconfigured\n");
 19692					return -EINVAL;
 19693				}
 19694	
 19695				new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, cnt);
 19696				if (!new_prog)
 19697					return -ENOMEM;
 19698	
 19699				delta    += cnt - 1;
 19700				env->prog = prog = new_prog;
 19701				insn      = new_prog->insnsi + i + delta;
 19702				goto next_insn;
 19703			}
 19704	
 19705			/* Rewrite pointer arithmetic to mitigate speculation attacks. */
 19706			if (insn->code == (BPF_ALU64 | BPF_ADD | BPF_X) ||
 19707			    insn->code == (BPF_ALU64 | BPF_SUB | BPF_X)) {
 19708				const u8 code_add = BPF_ALU64 | BPF_ADD | BPF_X;
 19709				const u8 code_sub = BPF_ALU64 | BPF_SUB | BPF_X;
 19710				struct bpf_insn *patch = &insn_buf[0];
 19711				bool issrc, isneg, isimm;
 19712				u32 off_reg;
 19713	
 19714				aux = &env->insn_aux_data[i + delta];
 19715				if (!aux->alu_state ||
 19716				    aux->alu_state == BPF_ALU_NON_POINTER)
 19717					goto next_insn;
 19718	
 19719				isneg = aux->alu_state & BPF_ALU_NEG_VALUE;
 19720				issrc = (aux->alu_state & BPF_ALU_SANITIZE) ==
 19721					BPF_ALU_SANITIZE_SRC;
 19722				isimm = aux->alu_state & BPF_ALU_IMMEDIATE;
 19723	
 19724				off_reg = issrc ? insn->src_reg : insn->dst_reg;
 19725				if (isimm) {
 19726					*patch++ = BPF_MOV32_IMM(BPF_REG_AX, aux->alu_limit);
 19727				} else {
 19728					if (isneg)
 19729						*patch++ = BPF_ALU64_IMM(BPF_MUL, off_reg, -1);
 19730					*patch++ = BPF_MOV32_IMM(BPF_REG_AX, aux->alu_limit);
 19731					*patch++ = BPF_ALU64_REG(BPF_SUB, BPF_REG_AX, off_reg);
 19732					*patch++ = BPF_ALU64_REG(BPF_OR, BPF_REG_AX, off_reg);
 19733					*patch++ = BPF_ALU64_IMM(BPF_NEG, BPF_REG_AX, 0);
 19734					*patch++ = BPF_ALU64_IMM(BPF_ARSH, BPF_REG_AX, 63);
 19735					*patch++ = BPF_ALU64_REG(BPF_AND, BPF_REG_AX, off_reg);
 19736				}
 19737				if (!issrc)
 19738					*patch++ = BPF_MOV64_REG(insn->dst_reg, insn->src_reg);
 19739				insn->src_reg = BPF_REG_AX;
 19740				if (isneg)
 19741					insn->code = insn->code == code_add ?
 19742						     code_sub : code_add;
 19743				*patch++ = *insn;
 19744				if (issrc && isneg && !isimm)
 19745					*patch++ = BPF_ALU64_IMM(BPF_MUL, off_reg, -1);
 19746				cnt = patch - insn_buf;
 19747	
 19748				new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, cnt);
 19749				if (!new_prog)
 19750					return -ENOMEM;
 19751	
 19752				delta    += cnt - 1;
 19753				env->prog = prog = new_prog;
 19754				insn      = new_prog->insnsi + i + delta;
 19755				goto next_insn;
 19756			}
 19757	
 19758			if (is_may_goto_insn(insn)) {
 19759				int stack_off = -stack_depth - 8;
 19760	
 19761				stack_depth_extra = 8;
 19762				insn_buf[0] = BPF_LDX_MEM(BPF_DW, BPF_REG_AX, BPF_REG_10, stack_off);
 19763				insn_buf[1] = BPF_JMP_IMM(BPF_JEQ, BPF_REG_AX, 0, insn->off + 2);
 19764				insn_buf[2] = BPF_ALU64_IMM(BPF_SUB, BPF_REG_AX, 1);
 19765				insn_buf[3] = BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_AX, stack_off);
 19766				cnt = 4;
 19767	
 19768				new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, cnt);
 19769				if (!new_prog)
 19770					return -ENOMEM;
 19771	
 19772				delta += cnt - 1;
 19773				env->prog = prog = new_prog;
 19774				insn = new_prog->insnsi + i + delta;
 19775				goto next_insn;
 19776			}
 19777	
 19778			if (insn->code != (BPF_JMP | BPF_CALL))
 19779				goto next_insn;
 19780			if (insn->src_reg == BPF_PSEUDO_CALL)
 19781				goto next_insn;
 19782			if (insn->src_reg == BPF_PSEUDO_KFUNC_CALL) {
 19783				ret = fixup_kfunc_call(env, insn, insn_buf, i + delta, &cnt);
 19784				if (ret)
 19785					return ret;
 19786				if (cnt == 0)
 19787					goto next_insn;
 19788	
 19789				new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, cnt);
 19790				if (!new_prog)
 19791					return -ENOMEM;
 19792	
 19793				delta	 += cnt - 1;
 19794				env->prog = prog = new_prog;
 19795				insn	  = new_prog->insnsi + i + delta;
 19796				goto next_insn;
 19797			}
 19798	
 19799			if (insn->imm == BPF_FUNC_get_route_realm)
 19800				prog->dst_needed = 1;
 19801			if (insn->imm == BPF_FUNC_get_prandom_u32)
 19802				bpf_user_rnd_init_once();
 19803			if (insn->imm == BPF_FUNC_override_return)
 19804				prog->kprobe_override = 1;
 19805			if (insn->imm == BPF_FUNC_tail_call) {
 19806				/* If we tail call into other programs, we
 19807				 * cannot make any assumptions since they can
 19808				 * be replaced dynamically during runtime in
 19809				 * the program array.
 19810				 */
 19811				prog->cb_access = 1;
 19812				if (!allow_tail_call_in_subprogs(env))
 19813					prog->aux->stack_depth = MAX_BPF_STACK;
 19814				prog->aux->max_pkt_offset = MAX_PACKET_OFF;
 19815	
 19816				/* mark bpf_tail_call as different opcode to avoid
 19817				 * conditional branch in the interpreter for every normal
 19818				 * call and to prevent accidental JITing by JIT compiler
 19819				 * that doesn't support bpf_tail_call yet
 19820				 */
 19821				insn->imm = 0;
 19822				insn->code = BPF_JMP | BPF_TAIL_CALL;
 19823	
 19824				aux = &env->insn_aux_data[i + delta];
 19825				if (env->bpf_capable && !prog->blinding_requested &&
 19826				    prog->jit_requested &&
 19827				    !bpf_map_key_poisoned(aux) &&
 19828				    !bpf_map_ptr_poisoned(aux) &&
 19829				    !bpf_map_ptr_unpriv(aux)) {
 19830					struct bpf_jit_poke_descriptor desc = {
 19831						.reason = BPF_POKE_REASON_TAIL_CALL,
 19832						.tail_call.map = BPF_MAP_PTR(aux->map_ptr_state),
 19833						.tail_call.key = bpf_map_key_immediate(aux),
 19834						.insn_idx = i + delta,
 19835					};
 19836	
 19837					ret = bpf_jit_add_poke_descriptor(prog, &desc);
 19838					if (ret < 0) {
 19839						verbose(env, "adding tail call poke descriptor failed\n");
 19840						return ret;
 19841					}
 19842	
 19843					insn->imm = ret + 1;
 19844					goto next_insn;
 19845				}
 19846	
 19847				if (!bpf_map_ptr_unpriv(aux))
 19848					goto next_insn;
 19849	
 19850				/* instead of changing every JIT dealing with tail_call
 19851				 * emit two extra insns:
 19852				 * if (index >= max_entries) goto out;
 19853				 * index &= array->index_mask;
 19854				 * to avoid out-of-bounds cpu speculation
 19855				 */
 19856				if (bpf_map_ptr_poisoned(aux)) {
 19857					verbose(env, "tail_call abusing map_ptr\n");
 19858					return -EINVAL;
 19859				}
 19860	
 19861				map_ptr = BPF_MAP_PTR(aux->map_ptr_state);
 19862				insn_buf[0] = BPF_JMP_IMM(BPF_JGE, BPF_REG_3,
 19863							  map_ptr->max_entries, 2);
 19864				insn_buf[1] = BPF_ALU32_IMM(BPF_AND, BPF_REG_3,
 19865							    container_of(map_ptr,
 19866									 struct bpf_array,
 19867									 map)->index_mask);
 19868				insn_buf[2] = *insn;
 19869				cnt = 3;
 19870				new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, cnt);
 19871				if (!new_prog)
 19872					return -ENOMEM;
 19873	
 19874				delta    += cnt - 1;
 19875				env->prog = prog = new_prog;
 19876				insn      = new_prog->insnsi + i + delta;
 19877				goto next_insn;
 19878			}
 19879	
 19880			if (insn->imm == BPF_FUNC_timer_set_callback) {
 19881				/* The verifier will process callback_fn as many times as necessary
 19882				 * with different maps and the register states prepared by
 19883				 * set_timer_callback_state will be accurate.
 19884				 *
 19885				 * The following use case is valid:
 19886				 *   map1 is shared by prog1, prog2, prog3.
 19887				 *   prog1 calls bpf_timer_init for some map1 elements
 19888				 *   prog2 calls bpf_timer_set_callback for some map1 elements.
 19889				 *     Those that were not bpf_timer_init-ed will return -EINVAL.
 19890				 *   prog3 calls bpf_timer_start for some map1 elements.
 19891				 *     Those that were not both bpf_timer_init-ed and
 19892				 *     bpf_timer_set_callback-ed will return -EINVAL.
 19893				 */
 19894				struct bpf_insn ld_addrs[2] = {
 19895					BPF_LD_IMM64(BPF_REG_3, (long)prog->aux),
 19896				};
 19897	
 19898				insn_buf[0] = ld_addrs[0];
 19899				insn_buf[1] = ld_addrs[1];
 19900				insn_buf[2] = *insn;
 19901				cnt = 3;
 19902	
 19903				new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, cnt);
 19904				if (!new_prog)
 19905					return -ENOMEM;
 19906	
 19907				delta    += cnt - 1;
 19908				env->prog = prog = new_prog;
 19909				insn      = new_prog->insnsi + i + delta;
 19910				goto patch_call_imm;
 19911			}
 19912	
 19913			if (is_storage_get_function(insn->imm)) {
 19914				if (!in_sleepable(env) ||
 19915				    env->insn_aux_data[i + delta].storage_get_func_atomic)
 19916					insn_buf[0] = BPF_MOV64_IMM(BPF_REG_5, (__force __s32)GFP_ATOMIC);
 19917				else
 19918					insn_buf[0] = BPF_MOV64_IMM(BPF_REG_5, (__force __s32)GFP_KERNEL);
 19919				insn_buf[1] = *insn;
 19920				cnt = 2;
 19921	
 19922				new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, cnt);
 19923				if (!new_prog)
 19924					return -ENOMEM;
 19925	
 19926				delta += cnt - 1;
 19927				env->prog = prog = new_prog;
 19928				insn = new_prog->insnsi + i + delta;
 19929				goto patch_call_imm;
 19930			}
 19931	
 19932			/* bpf_per_cpu_ptr() and bpf_this_cpu_ptr() */
 19933			if (env->insn_aux_data[i + delta].call_with_percpu_alloc_ptr) {
 19934				/* patch with 'r1 = *(u64 *)(r1 + 0)' since for percpu data,
 19935				 * bpf_mem_alloc() returns a ptr to the percpu data ptr.
 19936				 */
 19937				insn_buf[0] = BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_1, 0);
 19938				insn_buf[1] = *insn;
 19939				cnt = 2;
 19940	
 19941				new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, cnt);
 19942				if (!new_prog)
 19943					return -ENOMEM;
 19944	
 19945				delta += cnt - 1;
 19946				env->prog = prog = new_prog;
 19947				insn = new_prog->insnsi + i + delta;
 19948				goto patch_call_imm;
 19949			}
 19950	
 19951			/* BPF_EMIT_CALL() assumptions in some of the map_gen_lookup
 19952			 * and other inlining handlers are currently limited to 64 bit
 19953			 * only.
 19954			 */
 19955			if (prog->jit_requested && BITS_PER_LONG == 64 &&
 19956			    (insn->imm == BPF_FUNC_map_lookup_elem ||
 19957			     insn->imm == BPF_FUNC_map_update_elem ||
 19958			     insn->imm == BPF_FUNC_map_delete_elem ||
 19959			     insn->imm == BPF_FUNC_map_push_elem   ||
 19960			     insn->imm == BPF_FUNC_map_pop_elem    ||
 19961			     insn->imm == BPF_FUNC_map_peek_elem   ||
 19962			     insn->imm == BPF_FUNC_redirect_map    ||
 19963			     insn->imm == BPF_FUNC_for_each_map_elem ||
 19964			     insn->imm == BPF_FUNC_map_lookup_percpu_elem)) {
 19965				aux = &env->insn_aux_data[i + delta];
 19966				if (bpf_map_ptr_poisoned(aux))
 19967					goto patch_call_imm;
 19968	
 19969				map_ptr = BPF_MAP_PTR(aux->map_ptr_state);
 19970				ops = map_ptr->ops;
 19971				if (insn->imm == BPF_FUNC_map_lookup_elem &&
 19972				    ops->map_gen_lookup) {
 19973					cnt = ops->map_gen_lookup(map_ptr, insn_buf);
 19974					if (cnt == -EOPNOTSUPP)
 19975						goto patch_map_ops_generic;
 19976					if (cnt <= 0 || cnt >= ARRAY_SIZE(insn_buf)) {
 19977						verbose(env, "bpf verifier is misconfigured\n");
 19978						return -EINVAL;
 19979					}
 19980	
 19981					new_prog = bpf_patch_insn_data(env, i + delta,
 19982								       insn_buf, cnt);
 19983					if (!new_prog)
 19984						return -ENOMEM;
 19985	
 19986					delta    += cnt - 1;
 19987					env->prog = prog = new_prog;
 19988					insn      = new_prog->insnsi + i + delta;
 19989					goto next_insn;
 19990				}
 19991	
 19992				BUILD_BUG_ON(!__same_type(ops->map_lookup_elem,
 19993					     (void *(*)(struct bpf_map *map, void *key))NULL));
 19994				BUILD_BUG_ON(!__same_type(ops->map_delete_elem,
 19995					     (long (*)(struct bpf_map *map, void *key))NULL));
 19996				BUILD_BUG_ON(!__same_type(ops->map_update_elem,
 19997					     (long (*)(struct bpf_map *map, void *key, void *value,
 19998						      u64 flags))NULL));
 19999				BUILD_BUG_ON(!__same_type(ops->map_push_elem,
 20000					     (long (*)(struct bpf_map *map, void *value,
 20001						      u64 flags))NULL));
 20002				BUILD_BUG_ON(!__same_type(ops->map_pop_elem,
 20003					     (long (*)(struct bpf_map *map, void *value))NULL));
 20004				BUILD_BUG_ON(!__same_type(ops->map_peek_elem,
 20005					     (long (*)(struct bpf_map *map, void *value))NULL));
 20006				BUILD_BUG_ON(!__same_type(ops->map_redirect,
 20007					     (long (*)(struct bpf_map *map, u64 index, u64 flags))NULL));
 20008				BUILD_BUG_ON(!__same_type(ops->map_for_each_callback,
 20009					     (long (*)(struct bpf_map *map,
 20010						      bpf_callback_t callback_fn,
 20011						      void *callback_ctx,
 20012						      u64 flags))NULL));
 20013				BUILD_BUG_ON(!__same_type(ops->map_lookup_percpu_elem,
 20014					     (void *(*)(struct bpf_map *map, void *key, u32 cpu))NULL));
 20015	
 20016	patch_map_ops_generic:
 20017				switch (insn->imm) {
 20018				case BPF_FUNC_map_lookup_elem:
 20019					insn->imm = BPF_CALL_IMM(ops->map_lookup_elem);
 20020					goto next_insn;
 20021				case BPF_FUNC_map_update_elem:
 20022					insn->imm = BPF_CALL_IMM(ops->map_update_elem);
 20023					goto next_insn;
 20024				case BPF_FUNC_map_delete_elem:
 20025					insn->imm = BPF_CALL_IMM(ops->map_delete_elem);
 20026					goto next_insn;
 20027				case BPF_FUNC_map_push_elem:
 20028					insn->imm = BPF_CALL_IMM(ops->map_push_elem);
 20029					goto next_insn;
 20030				case BPF_FUNC_map_pop_elem:
 20031					insn->imm = BPF_CALL_IMM(ops->map_pop_elem);
 20032					goto next_insn;
 20033				case BPF_FUNC_map_peek_elem:
 20034					insn->imm = BPF_CALL_IMM(ops->map_peek_elem);
 20035					goto next_insn;
 20036				case BPF_FUNC_redirect_map:
 20037					insn->imm = BPF_CALL_IMM(ops->map_redirect);
 20038					goto next_insn;
 20039				case BPF_FUNC_for_each_map_elem:
 20040					insn->imm = BPF_CALL_IMM(ops->map_for_each_callback);
 20041					goto next_insn;
 20042				case BPF_FUNC_map_lookup_percpu_elem:
 20043					insn->imm = BPF_CALL_IMM(ops->map_lookup_percpu_elem);
 20044					goto next_insn;
 20045				}
 20046	
 20047				goto patch_call_imm;
 20048			}
 20049	
 20050			/* Implement bpf_jiffies64 inline. */
 20051			if (prog->jit_requested && BITS_PER_LONG == 64 &&
 20052			    insn->imm == BPF_FUNC_jiffies64) {
 20053				struct bpf_insn ld_jiffies_addr[2] = {
 20054					BPF_LD_IMM64(BPF_REG_0,
 20055						     (unsigned long)&jiffies),
 20056				};
 20057	
 20058				insn_buf[0] = ld_jiffies_addr[0];
 20059				insn_buf[1] = ld_jiffies_addr[1];
 20060				insn_buf[2] = BPF_LDX_MEM(BPF_DW, BPF_REG_0,
 20061							  BPF_REG_0, 0);
 20062				cnt = 3;
 20063	
 20064				new_prog = bpf_patch_insn_data(env, i + delta, insn_buf,
 20065							       cnt);
 20066				if (!new_prog)
 20067					return -ENOMEM;
 20068	
 20069				delta    += cnt - 1;
 20070				env->prog = prog = new_prog;
 20071				insn      = new_prog->insnsi + i + delta;
 20072				goto next_insn;
 20073			}
 20074	
 20075			/* Implement bpf_get_smp_processor_id() inline. */
 20076			if (insn->imm == BPF_FUNC_get_smp_processor_id &&
 20077			    prog->jit_requested && bpf_jit_supports_percpu_insns()) {
 20078				insn_buf[0] = BPF_MOV32_IMM(BPF_REG_0, (u32)(long)&pcpu_hot.cpu_number);
 20079				insn_buf[1] = BPF_LDX_MEM_PERCPU(BPF_W, BPF_REG_0, BPF_REG_0, 0);
 20080				cnt = 2;
 20081	
 20082				new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, cnt);
 20083				if (!new_prog)
 20084					return -ENOMEM;
 20085	
 20086				delta    += cnt - 1;
 20087				env->prog = prog = new_prog;
 20088				insn      = new_prog->insnsi + i + delta;
 20089				goto next_insn;
 20090			}
 20091	
 20092			/* Implement bpf_get_func_arg inline. */
 20093			if (prog_type == BPF_PROG_TYPE_TRACING &&
 20094			    insn->imm == BPF_FUNC_get_func_arg) {
 20095				/* Load nr_args from ctx - 8 */
 20096				insn_buf[0] = BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_1, -8);
 20097				insn_buf[1] = BPF_JMP32_REG(BPF_JGE, BPF_REG_2, BPF_REG_0, 6);
 20098				insn_buf[2] = BPF_ALU64_IMM(BPF_LSH, BPF_REG_2, 3);
 20099				insn_buf[3] = BPF_ALU64_REG(BPF_ADD, BPF_REG_2, BPF_REG_1);
 20100				insn_buf[4] = BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_2, 0);
 20101				insn_buf[5] = BPF_STX_MEM(BPF_DW, BPF_REG_3, BPF_REG_0, 0);
 20102				insn_buf[6] = BPF_MOV64_IMM(BPF_REG_0, 0);
 20103				insn_buf[7] = BPF_JMP_A(1);
 20104				insn_buf[8] = BPF_MOV64_IMM(BPF_REG_0, -EINVAL);
 20105				cnt = 9;
 20106	
 20107				new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, cnt);
 20108				if (!new_prog)
 20109					return -ENOMEM;
 20110	
 20111				delta    += cnt - 1;
 20112				env->prog = prog = new_prog;
 20113				insn      = new_prog->insnsi + i + delta;
 20114				goto next_insn;
 20115			}
 20116	
 20117			/* Implement bpf_get_func_ret inline. */
 20118			if (prog_type == BPF_PROG_TYPE_TRACING &&
 20119			    insn->imm == BPF_FUNC_get_func_ret) {
 20120				if (eatype == BPF_TRACE_FEXIT ||
 20121				    eatype == BPF_MODIFY_RETURN) {
 20122					/* Load nr_args from ctx - 8 */
 20123					insn_buf[0] = BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_1, -8);
 20124					insn_buf[1] = BPF_ALU64_IMM(BPF_LSH, BPF_REG_0, 3);
 20125					insn_buf[2] = BPF_ALU64_REG(BPF_ADD, BPF_REG_0, BPF_REG_1);
 20126					insn_buf[3] = BPF_LDX_MEM(BPF_DW, BPF_REG_3, BPF_REG_0, 0);
 20127					insn_buf[4] = BPF_STX_MEM(BPF_DW, BPF_REG_2, BPF_REG_3, 0);
 20128					insn_buf[5] = BPF_MOV64_IMM(BPF_REG_0, 0);
 20129					cnt = 6;
 20130				} else {
 20131					insn_buf[0] = BPF_MOV64_IMM(BPF_REG_0, -EOPNOTSUPP);
 20132					cnt = 1;
 20133				}
 20134	
 20135				new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, cnt);
 20136				if (!new_prog)
 20137					return -ENOMEM;
 20138	
 20139				delta    += cnt - 1;
 20140				env->prog = prog = new_prog;
 20141				insn      = new_prog->insnsi + i + delta;
 20142				goto next_insn;
 20143			}
 20144	
 20145			/* Implement get_func_arg_cnt inline. */
 20146			if (prog_type == BPF_PROG_TYPE_TRACING &&
 20147			    insn->imm == BPF_FUNC_get_func_arg_cnt) {
 20148				/* Load nr_args from ctx - 8 */
 20149				insn_buf[0] = BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_1, -8);
 20150	
 20151				new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, 1);
 20152				if (!new_prog)
 20153					return -ENOMEM;
 20154	
 20155				env->prog = prog = new_prog;
 20156				insn      = new_prog->insnsi + i + delta;
 20157				goto next_insn;
 20158			}
 20159	
 20160			/* Implement bpf_get_func_ip inline. */
 20161			if (prog_type == BPF_PROG_TYPE_TRACING &&
 20162			    insn->imm == BPF_FUNC_get_func_ip) {
 20163				/* Load IP address from ctx - 16 */
 20164				insn_buf[0] = BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_1, -16);
 20165	
 20166				new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, 1);
 20167				if (!new_prog)
 20168					return -ENOMEM;
 20169	
 20170				env->prog = prog = new_prog;
 20171				insn      = new_prog->insnsi + i + delta;
 20172				goto next_insn;
 20173			}
 20174	
 20175			/* Implement bpf_kptr_xchg inline */
 20176			if (prog->jit_requested && BITS_PER_LONG == 64 &&
 20177			    insn->imm == BPF_FUNC_kptr_xchg &&
 20178			    bpf_jit_supports_ptr_xchg()) {
 20179				insn_buf[0] = BPF_MOV64_REG(BPF_REG_0, BPF_REG_2);
 20180				insn_buf[1] = BPF_ATOMIC_OP(BPF_DW, BPF_XCHG, BPF_REG_1, BPF_REG_0, 0);
 20181				cnt = 2;
 20182	
 20183				new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, cnt);
 20184				if (!new_prog)
 20185					return -ENOMEM;
 20186	
 20187				delta    += cnt - 1;
 20188				env->prog = prog = new_prog;
 20189				insn      = new_prog->insnsi + i + delta;
 20190				goto next_insn;
 20191			}
 20192	patch_call_imm:
 20193			fn = env->ops->get_func_proto(insn->imm, env->prog);
 20194			/* all functions that have prototype and verifier allowed
 20195			 * programs to call them, must be real in-kernel functions
 20196			 */
 20197			if (!fn->func) {
 20198				verbose(env,
 20199					"kernel subsystem misconfigured func %s#%d\n",
 20200					func_id_name(insn->imm), insn->imm);
 20201				return -EFAULT;
 20202			}
 20203			insn->imm = fn->func - __bpf_call_base;
 20204	next_insn:
 20205			if (subprogs[cur_subprog + 1].start == i + delta + 1) {
 20206				subprogs[cur_subprog].stack_depth += stack_depth_extra;
 20207				subprogs[cur_subprog].stack_extra = stack_depth_extra;
 20208				cur_subprog++;
 20209				stack_depth = subprogs[cur_subprog].stack_depth;
 20210				stack_depth_extra = 0;
 20211			}
 20212			i++;
 20213			insn++;
 20214		}
 20215	
 20216		env->prog->aux->stack_depth = subprogs[0].stack_depth;
 20217		for (i = 0; i < env->subprog_cnt; i++) {
 20218			int subprog_start = subprogs[i].start;
 20219			int stack_slots = subprogs[i].stack_extra / 8;
 20220	
 20221			if (!stack_slots)
 20222				continue;
 20223			if (stack_slots > 1) {
 20224				verbose(env, "verifier bug: stack_slots supports may_goto only\n");
 20225				return -EFAULT;
 20226			}
 20227	
 20228			/* Add ST insn to subprog prologue to init extra stack */
 20229			insn_buf[0] = BPF_ST_MEM(BPF_DW, BPF_REG_FP,
 20230						 -subprogs[i].stack_depth, BPF_MAX_LOOPS);
 20231			/* Copy first actual insn to preserve it */
 20232			insn_buf[1] = env->prog->insnsi[subprog_start];
 20233	
 20234			new_prog = bpf_patch_insn_data(env, subprog_start, insn_buf, 2);
 20235			if (!new_prog)
 20236				return -ENOMEM;
 20237			env->prog = prog = new_prog;
 20238		}
 20239	
 20240		/* Since poke tab is now finalized, publish aux to tracker. */
 20241		for (i = 0; i < prog->aux->size_poke_tab; i++) {
 20242			map_ptr = prog->aux->poke_tab[i].tail_call.map;
 20243			if (!map_ptr->ops->map_poke_track ||
 20244			    !map_ptr->ops->map_poke_untrack ||
 20245			    !map_ptr->ops->map_poke_run) {
 20246				verbose(env, "bpf verifier is misconfigured\n");
 20247				return -EINVAL;
 20248			}
 20249	
 20250			ret = map_ptr->ops->map_poke_track(map_ptr, prog->aux);
 20251			if (ret < 0) {
 20252				verbose(env, "tracking tail call prog failed\n");
 20253				return ret;
 20254			}
 20255		}
 20256	
 20257		sort_kfunc_descs_by_imm_off(env->prog);
 20258	
 20259		return 0;
 20260	}
 20261	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
