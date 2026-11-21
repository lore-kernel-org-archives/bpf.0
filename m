Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.19
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795285110;
	b=qOnSWNPlVGLMHYwA9xX+WjVX52I+3A/aeTM1cMWYZf0xDqQjnXolkiPFP5UlkdyLZLRG
	 S4Rw3ZMnpyb6vvN3spavnrpLB0FjaxwLpUl5LCMLikevht5di0OFiobPliP+OEixNvrtt
	 uFLFSFjFiASEWZDZ27sqIryjaZRD7ul1VB49E8mgYNMBS61El3PkNpC6jstIDPbXe+RoC
	 JGZifLP1zVhsS9nF3ru6fB9Q9H+hUvKIXSBl5my3B2OLtwlKdO8CGfiKxCErsTW9BELuF
	 YI1I+gLin19JHTV3rDhYdInJL9tdev+QSIOBkJCEkgurB+WoMO9DznYyEKJqF4aAwjw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795285110;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=/akYk8/GMFheY0T1GirI7r3aE6F8rx4GegrnPEa9u3c=;
	b=3J7lI9G+0+oQdUNECnpLa/GuGiba+rAxQTOwLI7vwPvFvN6HRM3GVcEoY3htmNV9CPs7
	 FO4CtNKzGDSbHuQkRRP1oLHckadrU/Cx7jRdBUuR0inL6uAFFIwon5hxML5SLKdkJeEkM
	 DR5BLmDYtjhsWYdxROc/FksK20GHRJrXMk/ftJViyOE0LjPru/Z77298l3t3jGdQ++/Vi
	 iyCAuZJg2+mIi5lqYuAlE4NDpqZ+pUGggt28wYlNgV4MEkJudRuFW0a5RKqZE96LRqOfN
	 E0qECvMjh7Vpwv5tjFJ9SJw2hhNwpnwStPv85zXaY/0A7b6yKaFiCbGsv0EwU2yuy/w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=YXKMJeDW;
	arc=none smtp.remote-ip=192.198.163.19
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4AFC606A339
	for <bpf@vger.kernel.org>; Sat, 21 Nov 2026 18:18:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D4AFC606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=YXKMJeDW
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795285110; x=1826821110;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=FS52rYp5xVLN4N6fXCWfgMpxvn0Xs8nTcWcTNdNZJrs=;
  b=YXKMJeDW/xmupzXqeAVFIrXyS/09VoR7CZ1mwP4CSn+I7At+Ll+Iupz8
   x0pLNHoYZnPWq3Fobp6v5PEyJV/NUJ4eMVmD20DqhIawe55861uSw71Iy
   Pm+vMRXAV4fzEhHodi4/Vtxi9nZjLLqFBqlBof5RWz3Az8MW/sJLkhLCm
   opc7Mnza2k9kw0fcoLOnGqCFNNo7NJAmjVauIRnAeajVJmL8okuKnNqbF
   NZ8bpoVh1uOQZAGiQ8E5j6bNXZ+rPaYuUAVgbupqVwWKPl7YOme3ILs+J
   KoNJ/ItRTNvzxCieb2sHf96jvBu1jm2qiYypEyjSmdlDrvq/RoKkWrlaf
   w==;
X-CSE-ConnectionGUID: PB2WluQiQp2TDISa9VsNfg==
X-CSE-MsgGUID: ThSQ9OpuQ0u7u30p43VEhw==
X-IronPort-AV: E=McAfee;i="6800,10657,11973"; a="4241704"
X-IronPort-AV: E=Sophos;i="6.27,225,1787036400"; 
   d="scan'208";a="4241704"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2026 10:18:30 -0800
X-CSE-ConnectionGUID: 7ROqlSiZSTuexAyJ7/Mz8A==
X-CSE-MsgGUID: clpb1/YmQeGIfpaBAIipdg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,225,1787036400"; 
   d="scan'208";a="10844817"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 21 Nov 2026 10:18:27 -0800
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xUpfN-00000001KQI-05Ml;
	Sat, 21 Nov 2026 18:18:25 +0000
Date: Sun, 22 Nov 2026 02:17:27 +0800
From: kernel test robot <lkp@intel.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, daniel@iogearbox.net, andrii@kernel.org,
	eddyz87@gmail.com, memxor@gmail.com
Subject: Re: [PATCH bpf-next v2 37/49] bpf: Verify in passes
Message-ID: <202611220224.dm18oPJv-lkp@intel.com>
References: <20261120204959.614908-38-alexei.starovoitov@gmail.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261120204959.614908-38-alexei.starovoitov@gmail.com>

Hi Alexei,

kernel test robot noticed the following build errors:

[auto build test ERROR on 82cc2b4383e3edfa1026c8612fb4e90a9329ba11]

url:    https://github.com/intel-lab-lkp/linux/commits/Alexei-Starovoitov/bpf-Look-for-bpf_clone_redirect-once-in-check_recursion/20261120-204909
base:   82cc2b4383e3edfa1026c8612fb4e90a9329ba11
patch link:    https://lore.kernel.org/r/20261120204959.614908-38-alexei.starovoitov%40gmail.com
patch subject: [PATCH bpf-next v2 37/49] bpf: Verify in passes
config: csky-randconfig-1000-20261121 (https://download.01.org/0day-ci/archive/20261122/202611220224.dm18oPJv-lkp@intel.com/config)
compiler: csky-linux-gcc (GCC) 11.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261122/202611220224.dm18oPJv-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202611220224.dm18oPJv-lkp@intel.com/

All errors (new ones prefixed by >>):

   csky-linux-ld: kernel/bpf/verifier.o: in function `do_check_block':
>> kernel/bpf/verifier.c:21686:(.text+0x27540): undefined reference to `bpf_prog_offload_verify_insn'
>> csky-linux-ld: kernel/bpf/verifier.c:21816:(.text+0x27640): undefined reference to `bpf_prog_offload_verify_insn'


vim +21686 kernel/bpf/verifier.c

faed5c27d37622 Alexei Starovoitov      2026-11-20  21602  
5395aa9bbeb569 Alexei Starovoitov      2026-11-07  21603  /* Process the current state until it gets to the start of a basic block. */
5395aa9bbeb569 Alexei Starovoitov      2026-11-07  21604  static int do_check_block(struct bpf_verifier_env *env, int prev_insn_idx)
8b7df50fd40d7a Luis Gerhorst           2025-06-03  21605  {
8b7df50fd40d7a Luis Gerhorst           2025-06-03  21606  	struct bpf_verifier_state *state = env->cur_state;
ce70cdf9582e07 Alexei Starovoitov      2026-11-20  21607  	struct bpf_verifier_stack_elem *elem;
8b7df50fd40d7a Luis Gerhorst           2025-06-03  21608  	struct bpf_insn *insns = env->prog->insnsi;
8b7df50fd40d7a Luis Gerhorst           2025-06-03  21609  	int insn_cnt = env->prog->len;
dab17a2b0bfd16 Alexei Starovoitov      2026-11-20  21610  	bool do_print_state = true, from_unproven;
532cf1318e675e Alexei Starovoitov      2026-11-20  21611  	struct prog_requirements prog_requirements, new_requirements;
ce70cdf9582e07 Alexei Starovoitov      2026-11-20  21612  	bool again = prev_insn_idx == env->insn_idx;
532cf1318e675e Alexei Starovoitov      2026-11-20  21613  	unsigned long ranges;
532cf1318e675e Alexei Starovoitov      2026-11-20  21614  	bool stack_args;
aba707a5c97228 Alexei Starovoitov      2026-11-20  21615  	u32 held;
8b7df50fd40d7a Luis Gerhorst           2025-06-03  21616  
ce70cdf9582e07 Alexei Starovoitov      2026-11-20  21617  	mark_verifier_state_scratched(env);
8b7df50fd40d7a Luis Gerhorst           2025-06-03  21618  	for (;;) {
8b7df50fd40d7a Luis Gerhorst           2025-06-03  21619  		struct bpf_insn *insn;
dadb59104c6441 Luis Gerhorst           2025-07-05  21620  		struct bpf_insn_aux_data *insn_aux;
0810f59cd31bd0 Alexei Starovoitov      2026-11-20  21621  		struct bpf_insn_fixups fixups;
6762e3a0bce5fc Eduard Zingerman        2026-04-10  21622  		int err;
8b7df50fd40d7a Luis Gerhorst           2025-06-03  21623  
faed5c27d37622 Alexei Starovoitov      2026-11-20  21624  		err = bpf_check_limits(env);
faed5c27d37622 Alexei Starovoitov      2026-11-20  21625  		if (err)
faed5c27d37622 Alexei Starovoitov      2026-11-20  21626  			return err;
8fd58560b71e97 Alexei Starovoitov      2026-11-07  21627  
8b7df50fd40d7a Luis Gerhorst           2025-06-03  21628  		env->prev_insn_idx = prev_insn_idx;
8b7df50fd40d7a Luis Gerhorst           2025-06-03  21629  		if (env->insn_idx >= insn_cnt) {
8b7df50fd40d7a Luis Gerhorst           2025-06-03  21630  			verbose(env, "invalid insn idx %d insn_cnt %d\n",
8b7df50fd40d7a Luis Gerhorst           2025-06-03  21631  				env->insn_idx, insn_cnt);
8b7df50fd40d7a Luis Gerhorst           2025-06-03  21632  			return -EFAULT;
8b7df50fd40d7a Luis Gerhorst           2025-06-03  21633  		}
8b7df50fd40d7a Luis Gerhorst           2025-06-03  21634  
8b7df50fd40d7a Luis Gerhorst           2025-06-03  21635  		insn = &insns[env->insn_idx];
dadb59104c6441 Luis Gerhorst           2025-07-05  21636  		insn_aux = &env->insn_aux_data[env->insn_idx];
8b7df50fd40d7a Luis Gerhorst           2025-06-03  21637  
14c950ac2be8ca Kumar Kartikeya Dwivedi 2026-08-13  21638  		account_processed_insn(env);
14c950ac2be8ca Kumar Kartikeya Dwivedi 2026-08-13  21639  
8b7df50fd40d7a Luis Gerhorst           2025-06-03  21640  		state->last_insn_idx = env->prev_insn_idx;
13f843c0177eeb Eduard Zingerman        2025-06-11  21641  		state->insn_idx = env->insn_idx;
daf8248701b621 Kumar Kartikeya Dwivedi 2026-08-15  21642  		/*
5395aa9bbeb569 Alexei Starovoitov      2026-11-07  21643  		 * Record the incoming edge. A zero-offset conditional has identical
daf8248701b621 Kumar Kartikeya Dwivedi 2026-08-15  21644  		 * successors, so its outcome cannot be reconstructed from the edge.
daf8248701b621 Kumar Kartikeya Dwivedi 2026-08-15  21645  		 */
daf8248701b621 Kumar Kartikeya Dwivedi 2026-08-15  21646  		if (!state->speculative && prev_insn_idx >= 0 && prev_insn_idx < insn_cnt) {
daf8248701b621 Kumar Kartikeya Dwivedi 2026-08-15  21647  			struct bpf_insn *prev_insn = &insns[prev_insn_idx];
daf8248701b621 Kumar Kartikeya Dwivedi 2026-08-15  21648  			int fallthrough_idx = prev_insn_idx + 1;
daf8248701b621 Kumar Kartikeya Dwivedi 2026-08-15  21649  			int branch_idx = prev_insn_idx + bpf_jmp_offset(prev_insn) + 1;
daf8248701b621 Kumar Kartikeya Dwivedi 2026-08-15  21650  			u8 class = BPF_CLASS(prev_insn->code);
daf8248701b621 Kumar Kartikeya Dwivedi 2026-08-15  21651  			u8 opcode = BPF_OP(prev_insn->code);
daf8248701b621 Kumar Kartikeya Dwivedi 2026-08-15  21652  
daf8248701b621 Kumar Kartikeya Dwivedi 2026-08-15  21653  			if ((class == BPF_JMP || class == BPF_JMP32) &&
daf8248701b621 Kumar Kartikeya Dwivedi 2026-08-15  21654  			    opcode != BPF_JA && opcode != BPF_CALL && opcode != BPF_EXIT &&
daf8248701b621 Kumar Kartikeya Dwivedi 2026-08-15  21655  			    opcode <= BPF_JCOND && branch_idx != fallthrough_idx) {
daf8248701b621 Kumar Kartikeya Dwivedi 2026-08-15  21656  				if (env->insn_idx == branch_idx)
daf8248701b621 Kumar Kartikeya Dwivedi 2026-08-15  21657  					bpf_diag_record_branch(env, prev_insn_idx, true);
daf8248701b621 Kumar Kartikeya Dwivedi 2026-08-15  21658  				else if (env->insn_idx == fallthrough_idx)
daf8248701b621 Kumar Kartikeya Dwivedi 2026-08-15  21659  					bpf_diag_record_branch(env, prev_insn_idx, false);
daf8248701b621 Kumar Kartikeya Dwivedi 2026-08-15  21660  			}
daf8248701b621 Kumar Kartikeya Dwivedi 2026-08-15  21661  		}
8b7df50fd40d7a Luis Gerhorst           2025-06-03  21662  
8b7df50fd40d7a Luis Gerhorst           2025-06-03  21663  		if (env->log.level & BPF_LOG_LEVEL2 && do_print_state) {
8b7df50fd40d7a Luis Gerhorst           2025-06-03  21664  			verbose(env, "\nfrom %d to %d%s:",
8b7df50fd40d7a Luis Gerhorst           2025-06-03  21665  				env->prev_insn_idx, env->insn_idx,
8b7df50fd40d7a Luis Gerhorst           2025-06-03  21666  				env->cur_state->speculative ?
8b7df50fd40d7a Luis Gerhorst           2025-06-03  21667  				" (speculative execution)" : "");
8b7df50fd40d7a Luis Gerhorst           2025-06-03  21668  			print_verifier_state(env, state, state->curframe, true);
8b7df50fd40d7a Luis Gerhorst           2025-06-03  21669  			do_print_state = false;
8b7df50fd40d7a Luis Gerhorst           2025-06-03  21670  		}
8b7df50fd40d7a Luis Gerhorst           2025-06-03  21671  
8b7df50fd40d7a Luis Gerhorst           2025-06-03  21672  		if (env->log.level & BPF_LOG_LEVEL) {
8b7df50fd40d7a Luis Gerhorst           2025-06-03  21673  			if (verifier_state_scratched(env))
8b7df50fd40d7a Luis Gerhorst           2025-06-03  21674  				print_insn_state(env, state, state->curframe);
8b7df50fd40d7a Luis Gerhorst           2025-06-03  21675  
8b7df50fd40d7a Luis Gerhorst           2025-06-03  21676  			verbose_linfo(env, env->insn_idx, "; ");
8b7df50fd40d7a Luis Gerhorst           2025-06-03  21677  			env->prev_log_pos = env->log.end_pos;
8b7df50fd40d7a Luis Gerhorst           2025-06-03  21678  			verbose(env, "%d: ", env->insn_idx);
19dbb134748110 Alexei Starovoitov      2026-04-02  21679  			bpf_verbose_insn(env, insn);
483a1bb0b6cf81 Eduard Zingerman        2026-08-07  21680  			verbose(env, "\n");
8b7df50fd40d7a Luis Gerhorst           2025-06-03  21681  			env->prev_insn_print_pos = env->log.end_pos - env->prev_log_pos;
8b7df50fd40d7a Luis Gerhorst           2025-06-03  21682  			env->prev_log_pos = env->log.end_pos;
8b7df50fd40d7a Luis Gerhorst           2025-06-03  21683  		}
8b7df50fd40d7a Luis Gerhorst           2025-06-03  21684  
532cf1318e675e Alexei Starovoitov      2026-11-20  21685  		if (env->replay) {
8b7df50fd40d7a Luis Gerhorst           2025-06-03 @21686  			err = bpf_prog_offload_verify_insn(env, env->insn_idx,
8b7df50fd40d7a Luis Gerhorst           2025-06-03  21687  							   env->prev_insn_idx);
8b7df50fd40d7a Luis Gerhorst           2025-06-03  21688  			if (err)
8b7df50fd40d7a Luis Gerhorst           2025-06-03  21689  				return err;
532cf1318e675e Alexei Starovoitov      2026-11-20  21690  		} else if (bpf_prog_is_offloaded(env->prog->aux)) {
532cf1318e675e Alexei Starovoitov      2026-11-20  21691  			/* the driver cannot forget what an imprecise state shows */
532cf1318e675e Alexei Starovoitov      2026-11-20  21692  			note_pessimized_insn(env, env->insn_idx);
8b7df50fd40d7a Luis Gerhorst           2025-06-03  21693  		}
8b7df50fd40d7a Luis Gerhorst           2025-06-03  21694  
8b7df50fd40d7a Luis Gerhorst           2025-06-03  21695  		sanitize_mark_insn_seen(env);
dab17a2b0bfd16 Alexei Starovoitov      2026-11-20  21696  		insn_aux->suspect_loops |= state->suspect_loops;
8b7df50fd40d7a Luis Gerhorst           2025-06-03  21697  		prev_insn_idx = env->insn_idx;
8b7df50fd40d7a Luis Gerhorst           2025-06-03  21698  
f1606dd0ac4923 Alexei Starovoitov      2026-04-02  21699  		/* Sanity check: precomputed constants must match verifier state */
dab17a2b0bfd16 Alexei Starovoitov      2026-11-20  21700  		if (!state->speculative && !env->err && !env->extra_values &&
dab17a2b0bfd16 Alexei Starovoitov      2026-11-20  21701  		    insn_aux->const_reg_mask) {
f1606dd0ac4923 Alexei Starovoitov      2026-04-02  21702  			struct bpf_reg_state *regs = cur_regs(env);
f1606dd0ac4923 Alexei Starovoitov      2026-04-02  21703  			u16 mask = insn_aux->const_reg_mask;
f1606dd0ac4923 Alexei Starovoitov      2026-04-02  21704  
f1606dd0ac4923 Alexei Starovoitov      2026-04-02  21705  			for (int r = 0; r < ARRAY_SIZE(insn_aux->const_reg_vals); r++) {
f1606dd0ac4923 Alexei Starovoitov      2026-04-02  21706  				u32 cval = insn_aux->const_reg_vals[r];
f1606dd0ac4923 Alexei Starovoitov      2026-04-02  21707  
f1606dd0ac4923 Alexei Starovoitov      2026-04-02  21708  				if (!(mask & BIT(r)))
f1606dd0ac4923 Alexei Starovoitov      2026-04-02  21709  					continue;
f1606dd0ac4923 Alexei Starovoitov      2026-04-02  21710  				if (regs[r].type != SCALAR_VALUE)
f1606dd0ac4923 Alexei Starovoitov      2026-04-02  21711  					continue;
f1606dd0ac4923 Alexei Starovoitov      2026-04-02  21712  				if (!tnum_is_const(regs[r].var_off))
f1606dd0ac4923 Alexei Starovoitov      2026-04-02  21713  					continue;
f1606dd0ac4923 Alexei Starovoitov      2026-04-02  21714  				if (verifier_bug_if((u32)regs[r].var_off.value != cval,
f1606dd0ac4923 Alexei Starovoitov      2026-04-02  21715  						    env, "const R%d: %u != %llu",
f1606dd0ac4923 Alexei Starovoitov      2026-04-02  21716  						    r, cval, regs[r].var_off.value))
f1606dd0ac4923 Alexei Starovoitov      2026-04-02  21717  					return -EFAULT;
f1606dd0ac4923 Alexei Starovoitov      2026-04-02  21718  			}
f1606dd0ac4923 Alexei Starovoitov      2026-04-02  21719  		}
f1606dd0ac4923 Alexei Starovoitov      2026-04-02  21720  
d6f1c85f22534d Luis Gerhorst           2025-06-03  21721  		/* Reduce verification complexity by stopping speculative path
d6f1c85f22534d Luis Gerhorst           2025-06-03  21722  		 * verification when a nospec is encountered.
d6f1c85f22534d Luis Gerhorst           2025-06-03  21723  		 */
dab17a2b0bfd16 Alexei Starovoitov      2026-11-20  21724  		if (state->speculative && insn_aux->non_speculative_first)
dab17a2b0bfd16 Alexei Starovoitov      2026-11-20  21725  			need_nospec(env, env->insn_idx);
dadb59104c6441 Luis Gerhorst           2025-07-05  21726  		if (state->speculative && insn_aux->nospec)
d6f1c85f22534d Luis Gerhorst           2025-06-03  21727  			goto process_bpf_exit;
dab17a2b0bfd16 Alexei Starovoitov      2026-11-20  21728  		insn_aux->speculative_first |= !insn_aux->seen;
d6f1c85f22534d Luis Gerhorst           2025-06-03  21729  
532cf1318e675e Alexei Starovoitov      2026-11-20  21730  		ranges = operands_with_range(env, insn);
532cf1318e675e Alexei Starovoitov      2026-11-20  21731  		stack_args = cur_func(env)->out_stack_arg_cnt;
532cf1318e675e Alexei Starovoitov      2026-11-20  21732  
0810f59cd31bd0 Alexei Starovoitov      2026-11-20  21733  		err = check_loop_guard(env) ?: check_recursion_guard(env);
eaea7390705214 Alexei Starovoitov      2026-11-07  21734  		if (err)
eaea7390705214 Alexei Starovoitov      2026-11-07  21735  			return err;
eaea7390705214 Alexei Starovoitov      2026-11-07  21736  
46bc0f24720aa7 Alexei Starovoitov      2026-11-20  21737  		bpf_equations_before_insn(env);
aba707a5c97228 Alexei Starovoitov      2026-11-20  21738  		held = held_cnt(state);
dab17a2b0bfd16 Alexei Starovoitov      2026-11-20  21739  		from_unproven = reads_from_unproven(env);
0810f59cd31bd0 Alexei Starovoitov      2026-11-20  21740  		fixups = insn_aux->fixups;
532cf1318e675e Alexei Starovoitov      2026-11-20  21741  		prog_requirements = get_prog_requirements(env);
28d9a7acba4a20 Alexei Starovoitov      2026-11-20  21742  		env->no_report = state->speculative;
46bc0f24720aa7 Alexei Starovoitov      2026-11-20  21743  		err = do_check_insn(env, &do_print_state) ?: bpf_equations_after_insn(env);
28d9a7acba4a20 Alexei Starovoitov      2026-11-20  21744  		env->no_report = false;
532cf1318e675e Alexei Starovoitov      2026-11-20  21745  		new_requirements = get_prog_requirements(env);
532cf1318e675e Alexei Starovoitov      2026-11-20  21746  		/* a join adds values only to a range */
532cf1318e675e Alexei Starovoitov      2026-11-20  21747  		if ((ranges || stack_args || again) &&
532cf1318e675e Alexei Starovoitov      2026-11-20  21748  		    memcmp(&prog_requirements, &new_requirements, sizeof(new_requirements)))
532cf1318e675e Alexei Starovoitov      2026-11-20  21749  			note_pessimized_insn(env, prev_insn_idx);
5614fba52b4c0b Alexei Starovoitov      2026-11-20  21750  		/* a call or an exit gave the state to the flow, the error is from there */
5614fba52b4c0b Alexei Starovoitov      2026-11-20  21751  		if (err < 0 && !state->frame[0])
5614fba52b4c0b Alexei Starovoitov      2026-11-20  21752  			return err;
aba707a5c97228 Alexei Starovoitov      2026-11-20  21753  		insn_aux->releases |= held_cnt(state) < held && err != PROCESS_BPF_EXIT;
aba707a5c97228 Alexei Starovoitov      2026-11-20  21754  		insn_aux->acquires |= held_cnt(state) > held;
0810f59cd31bd0 Alexei Starovoitov      2026-11-20  21755  		if (nospec_ends_path(env, state, err)) {
d6f1c85f22534d Luis Gerhorst           2025-06-03  21756  			/* Prevent this speculative path from ever reaching the
d6f1c85f22534d Luis Gerhorst           2025-06-03  21757  			 * insn that would have been unsafe to execute.
0810f59cd31bd0 Alexei Starovoitov      2026-11-20  21758  			 * What it noted does not apply to the other paths.
0810f59cd31bd0 Alexei Starovoitov      2026-11-20  21759  			 * check_fastcall_stack_contract() clears the pattern only once.
d6f1c85f22534d Luis Gerhorst           2025-06-03  21760  			 */
0810f59cd31bd0 Alexei Starovoitov      2026-11-20  21761  			fixups.fastcall_spills_num = insn_aux->fastcall_spills_num;
0810f59cd31bd0 Alexei Starovoitov      2026-11-20  21762  			insn_aux->fixups = fixups;
0810f59cd31bd0 Alexei Starovoitov      2026-11-20  21763  			need_nospec(env, prev_insn_idx);
0810f59cd31bd0 Alexei Starovoitov      2026-11-20  21764  			free_pushed_states(env);
d6f1c85f22534d Luis Gerhorst           2025-06-03  21765  			goto process_bpf_exit;
dab17a2b0bfd16 Alexei Starovoitov      2026-11-20  21766  		} else if (error_is_recoverable(err) && !env->path_sensitive) {
dab17a2b0bfd16 Alexei Starovoitov      2026-11-20  21767  			env->insn_idx = prev_insn_idx;
dab17a2b0bfd16 Alexei Starovoitov      2026-11-20  21768  			if (bpf_same_insns_unproven(env))
dab17a2b0bfd16 Alexei Starovoitov      2026-11-20  21769  				return err;
dab17a2b0bfd16 Alexei Starovoitov      2026-11-20  21770  			if (from_unproven)
dab17a2b0bfd16 Alexei Starovoitov      2026-11-20  21771  				bpf_note_reads_from_unproven(env, prev_insn_idx);
dab17a2b0bfd16 Alexei Starovoitov      2026-11-20  21772  			else
dab17a2b0bfd16 Alexei Starovoitov      2026-11-20  21773  				note_error(env, err);
dab17a2b0bfd16 Alexei Starovoitov      2026-11-20  21774  			err = skip_unproven_insn(env, insn);
dab17a2b0bfd16 Alexei Starovoitov      2026-11-20  21775  			if (err < 0)
dab17a2b0bfd16 Alexei Starovoitov      2026-11-20  21776  				return err;
dab17a2b0bfd16 Alexei Starovoitov      2026-11-20  21777  			if (err)
dab17a2b0bfd16 Alexei Starovoitov      2026-11-20  21778  				goto process_bpf_exit;
dab17a2b0bfd16 Alexei Starovoitov      2026-11-20  21779  			mark_from_unproven(env, prev_insn_idx, true);
dab17a2b0bfd16 Alexei Starovoitov      2026-11-20  21780  			env->insn_idx++;
d6f1c85f22534d Luis Gerhorst           2025-06-03  21781  		} else if (err < 0) {
8b7df50fd40d7a Luis Gerhorst           2025-06-03  21782  			return err;
8b7df50fd40d7a Luis Gerhorst           2025-06-03  21783  		} else if (err == PROCESS_BPF_EXIT) {
d6f1c85f22534d Luis Gerhorst           2025-06-03  21784  			goto process_bpf_exit;
2ec74a053611ed Alexei Starovoitov      2026-04-11  21785  		} else if (err == INSN_IDX_UPDATED) {
2ec74a053611ed Alexei Starovoitov      2026-04-11  21786  		} else if (err == 0) {
dab17a2b0bfd16 Alexei Starovoitov      2026-11-20  21787  			if (!bpf_pseudo_call(insn) && !bpf_is_callx(insn))
dab17a2b0bfd16 Alexei Starovoitov      2026-11-20  21788  				mark_from_unproven(env, prev_insn_idx, from_unproven);
2ec74a053611ed Alexei Starovoitov      2026-04-11  21789  			env->insn_idx++;
d6f1c85f22534d Luis Gerhorst           2025-06-03  21790  		}
d6f1c85f22534d Luis Gerhorst           2025-06-03  21791  
0810f59cd31bd0 Alexei Starovoitov      2026-11-20  21792  		/* only a store that stays gets it, see bpf_convert_ctx_accesses() */
0810f59cd31bd0 Alexei Starovoitov      2026-11-20  21793  		if (state->speculative && insn_aux->nospec_result && !insn_aux->fastcall_pattern &&
0810f59cd31bd0 Alexei Starovoitov      2026-11-20  21794  		    bpf_is_mem_insn(insn) && BPF_MODE(insn->code) == BPF_MEM) {
8b7df50fd40d7a Luis Gerhorst           2025-06-03  21795  process_bpf_exit:
14c950ac2be8ca Kumar Kartikeya Dwivedi 2026-08-13  21796  			account_current_path(env);
faed5c27d37622 Alexei Starovoitov      2026-11-20  21797  			bpf_free_verifier_state(env, state, false);
5395aa9bbeb569 Alexei Starovoitov      2026-11-07  21798  			memset(state, 0, sizeof(*state));
5395aa9bbeb569 Alexei Starovoitov      2026-11-07  21799  			return flow_drain(env);
5395aa9bbeb569 Alexei Starovoitov      2026-11-07  21800  		}
5395aa9bbeb569 Alexei Starovoitov      2026-11-07  21801  
ce70cdf9582e07 Alexei Starovoitov      2026-11-20  21802  		/* if the insn pushed a part, the current state is a part too */
ce70cdf9582e07 Alexei Starovoitov      2026-11-20  21803  		for (elem = env->head; elem; elem = elem->next)
ce70cdf9582e07 Alexei Starovoitov      2026-11-20  21804  			again |= elem->again;
5395aa9bbeb569 Alexei Starovoitov      2026-11-07  21805  		err = flow_drain(env);
c9e31900b54cad Eduard Zingerman        2025-06-11  21806  		if (err)
c9e31900b54cad Eduard Zingerman        2025-06-11  21807  			return err;
5395aa9bbeb569 Alexei Starovoitov      2026-11-07  21808  
ce70cdf9582e07 Alexei Starovoitov      2026-11-20  21809  		/* the parts of a state meet at the next insn */
ce70cdf9582e07 Alexei Starovoitov      2026-11-20  21810  		if (env->insn_idx < insn_cnt &&
ce70cdf9582e07 Alexei Starovoitov      2026-11-20  21811  		    (again || bpf_flow_is_bb_start(env, env->insn_idx))) {
5395aa9bbeb569 Alexei Starovoitov      2026-11-07  21812  			account_current_path(env);
ce70cdf9582e07 Alexei Starovoitov      2026-11-20  21813  			return bpf_flow_deliver(env, state, env->insn_idx, prev_insn_idx, false);
8b7df50fd40d7a Luis Gerhorst           2025-06-03  21814  		}
8b7df50fd40d7a Luis Gerhorst           2025-06-03  21815  	}
17a5267067f3c3 Alexei Starovoitov      2014-09-26 @21816  }
17a5267067f3c3 Alexei Starovoitov      2014-09-26  21817  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
