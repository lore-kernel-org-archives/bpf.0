Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1460C175A70;
	Sun, 15 Mar 2026 06:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773554740; cv=none; b=OFSOnfxHfrTVhIN+65UyjttmXNpIp4NVkzFIs4FQlEX/Rm2K4uC6qdWJxxr1uObb3gVSUL9NGyY5+JtDj+iv0/OIg6xcXH7e/P/H7ikL8MJ9GJm2rWsdYffnrS7B7x3rO7zoR4hBxJKTmZ3dBleV/rPV2yugsAyTjbffrVEABQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773554740; c=relaxed/simple;
	bh=wyI2M0AKUwykqSAQb/jTITWlNbRZYw5mTJD4YdCFD+8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nvxUDDGFjQRKoxuvs8h8JUBiVM/PJ2HVG5eo8zu+r/Rp9R+JHk96z6n7I9eqkhtbwsamIyMg3ijYVAjRqPD6IfYOL9WP082+SJ/osO9t3DNoJDWCUNGBqiL0LEDJPlyYyOzSVNUEhoN9bO4KCXiYstgpyL2rmhW9BjFFqwi+g8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GvraZl6r; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GvraZl6r"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773554739; x=1805090739;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=wyI2M0AKUwykqSAQb/jTITWlNbRZYw5mTJD4YdCFD+8=;
  b=GvraZl6rCv3Z/X8e7TGEFL7KV1+R6IhaWJyNv8I9+e9TpC1bs/QeYBBI
   CXWi1osRR5ElkBTyt+MIIol4QecgXQyHTt6BabFYeRYTKTOcvDbkZXybX
   BAMqs/mNJMFYoW1z1dqIFdmddzby7al4ux+feYxi5fURbH/iPYRiqbOTz
   /HMgPNQ2Uzpg3me9tfFMOK58FJB5UBAVnWuBUK3pYqXHTlil3eu6mdok1
   OEXo3HVvnbLhMpa+RByy+oGmVIC3uV31QFlJIQM5T5Dv0JjQ/STSnIgUe
   FvFfes0jE051UzAg5/R8KkBA1cEFLqPcHjCVpg4V8HToIximy5hqkdOYw
   g==;
X-CSE-ConnectionGUID: UewVkNbmTiCcpVxYA6K93w==
X-CSE-MsgGUID: zgR9XVx7TwCV2lTVw2/38g==
X-IronPort-AV: E=McAfee;i="6800,10657,11729"; a="85691101"
X-IronPort-AV: E=Sophos;i="6.23,119,1770624000"; 
   d="scan'208";a="85691101"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2026 23:05:38 -0700
X-CSE-ConnectionGUID: kn1yRXrdRKatPlt/1fV69A==
X-CSE-MsgGUID: C2VuPskURL6GpEUglA143g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,119,1770624000"; 
   d="scan'208";a="246590957"
Received: from igk-lkp-server01.igk.intel.com (HELO 9958d990ccf2) ([10.211.93.152])
  by fmviesa001.fm.intel.com with ESMTP; 14 Mar 2026 23:05:31 -0700
Received: from kbuild by 9958d990ccf2 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1w1ebQ-000000003yr-3J69;
	Sun, 15 Mar 2026 06:05:28 +0000
Date: Sun, 15 Mar 2026 07:05:04 +0100
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
	Alexis =?iso-8859-1?Q?Lothor=E9?= <alexis.lothore@bootlin.com>,
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
Subject: Re: [PATCH bpf-next v9 1/5] bpf: Move constants blinding out of
 arch-specific JITs
Message-ID: <202603150744.o3j4EtgB-lkp@intel.com>
References: <20260312170255.3427799-2-xukuohai@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260312170255.3427799-2-xukuohai@huaweicloud.com>

Hi Xu,

kernel test robot noticed the following build errors:

[auto build test ERROR on bpf-next/net]
[also build test ERROR on bpf-next/master bpf/master powerpc/next powerpc/fixes next-20260313]
[cannot apply to linus/master v6.16-rc1]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Xu-Kuohai/bpf-Move-constants-blinding-out-of-arch-specific-JITs/20260315-041957
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git net
patch link:    https://lore.kernel.org/r/20260312170255.3427799-2-xukuohai%40huaweicloud.com
patch subject: [PATCH bpf-next v9 1/5] bpf: Move constants blinding out of arch-specific JITs
config: x86_64-kexec (https://download.01.org/0day-ci/archive/20260315/202603150744.o3j4EtgB-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260315/202603150744.o3j4EtgB-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603150744.o3j4EtgB-lkp@intel.com/

All errors (new ones prefixed by >>):

>> kernel/bpf/verifier.c:22809:5: error: call to undeclared function 'bpf_jit_prog_release_other'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
    22809 |                                 bpf_jit_prog_release_other(orig_prog, prog);
          |                                 ^
   kernel/bpf/verifier.c:23035:3: error: call to undeclared function 'bpf_jit_prog_release_other'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
    23035 |                 bpf_jit_prog_release_other(prog, orig_prog);
          |                 ^
   2 errors generated.


vim +/bpf_jit_prog_release_other +22809 kernel/bpf/verifier.c

 22777	
 22778	static int jit_subprogs(struct bpf_verifier_env *env)
 22779	{
 22780		struct bpf_prog *orig_prog = env->prog, *prog, **func, *tmp;
 22781		int i, j, subprog_start, subprog_end = 0, len, subprog;
 22782		struct bpf_map *map_ptr;
 22783		struct bpf_insn *insn;
 22784		void *old_bpf_func;
 22785		int err, num_exentries;
 22786		bool blinded = false;
 22787	
 22788		if (env->subprog_cnt <= 1)
 22789			return 0;
 22790	
 22791		prog = bpf_jit_blind_constants(env, NULL);
 22792		if (IS_ERR(prog))
 22793			return -ENOMEM;
 22794		if (prog != orig_prog)
 22795			blinded = true;
 22796	
 22797		for (i = 0, insn = prog->insnsi; i < prog->len; i++, insn++) {
 22798			if (!bpf_pseudo_func(insn) && !bpf_pseudo_call(insn))
 22799				continue;
 22800	
 22801			/* Upon error here we cannot fall back to interpreter but
 22802			 * need a hard reject of the program. Thus -EFAULT is
 22803			 * propagated in any case.
 22804			 */
 22805			subprog = find_subprog(env, i + insn->imm + 1);
 22806			if (verifier_bug_if(subprog < 0, env, "No program to jit at insn %d",
 22807					    i + insn->imm + 1)) {
 22808				if (blinded) {
 22809					bpf_jit_prog_release_other(orig_prog, prog);
 22810					env->prog = orig_prog;
 22811				}
 22812				return -EFAULT;
 22813			}
 22814			/* temporarily remember subprog id inside insn instead of
 22815			 * aux_data, since next loop will split up all insns into funcs
 22816			 */
 22817			insn->off = subprog;
 22818			/* remember original imm in case JIT fails and fallback
 22819			 * to interpreter will be needed
 22820			 */
 22821			env->insn_aux_data[i].call_imm = insn->imm;
 22822			/* point imm to __bpf_call_base+1 from JITs point of view */
 22823			insn->imm = 1;
 22824			if (bpf_pseudo_func(insn)) {
 22825	#if defined(MODULES_VADDR)
 22826				u64 addr = MODULES_VADDR;
 22827	#else
 22828				u64 addr = VMALLOC_START;
 22829	#endif
 22830				/* jit (e.g. x86_64) may emit fewer instructions
 22831				 * if it learns a u32 imm is the same as a u64 imm.
 22832				 * Set close enough to possible prog address.
 22833				 */
 22834				insn[0].imm = (u32)addr;
 22835				insn[1].imm = addr >> 32;
 22836			}
 22837		}
 22838	
 22839		err = bpf_prog_alloc_jited_linfo(prog);
 22840		if (err)
 22841			goto out_undo_insn;
 22842	
 22843		err = -ENOMEM;
 22844		func = kzalloc_objs(prog, env->subprog_cnt);
 22845		if (!func)
 22846			goto out_undo_insn;
 22847	
 22848		for (i = 0; i < env->subprog_cnt; i++) {
 22849			subprog_start = subprog_end;
 22850			subprog_end = env->subprog_info[i + 1].start;
 22851	
 22852			len = subprog_end - subprog_start;
 22853			/* bpf_prog_run() doesn't call subprogs directly,
 22854			 * hence main prog stats include the runtime of subprogs.
 22855			 * subprogs don't have IDs and not reachable via prog_get_next_id
 22856			 * func[i]->stats will never be accessed and stays NULL
 22857			 */
 22858			func[i] = bpf_prog_alloc_no_stats(bpf_prog_size(len), GFP_USER);
 22859			if (!func[i])
 22860				goto out_free;
 22861			memcpy(func[i]->insnsi, &prog->insnsi[subprog_start],
 22862			       len * sizeof(struct bpf_insn));
 22863			func[i]->type = prog->type;
 22864			func[i]->len = len;
 22865			if (bpf_prog_calc_tag(func[i]))
 22866				goto out_free;
 22867			func[i]->is_func = 1;
 22868			func[i]->sleepable = prog->sleepable;
 22869			func[i]->blinded = prog->blinded;
 22870			func[i]->aux->func_idx = i;
 22871			/* Below members will be freed only at prog->aux */
 22872			func[i]->aux->btf = prog->aux->btf;
 22873			func[i]->aux->subprog_start = subprog_start;
 22874			func[i]->aux->func_info = prog->aux->func_info;
 22875			func[i]->aux->func_info_cnt = prog->aux->func_info_cnt;
 22876			func[i]->aux->poke_tab = prog->aux->poke_tab;
 22877			func[i]->aux->size_poke_tab = prog->aux->size_poke_tab;
 22878			func[i]->aux->main_prog_aux = prog->aux;
 22879	
 22880			for (j = 0; j < prog->aux->size_poke_tab; j++) {
 22881				struct bpf_jit_poke_descriptor *poke;
 22882	
 22883				poke = &prog->aux->poke_tab[j];
 22884				if (poke->insn_idx < subprog_end &&
 22885				    poke->insn_idx >= subprog_start)
 22886					poke->aux = func[i]->aux;
 22887			}
 22888	
 22889			func[i]->aux->name[0] = 'F';
 22890			func[i]->aux->stack_depth = env->subprog_info[i].stack_depth;
 22891			if (env->subprog_info[i].priv_stack_mode == PRIV_STACK_ADAPTIVE)
 22892				func[i]->aux->jits_use_priv_stack = true;
 22893	
 22894			func[i]->jit_requested = 1;
 22895			func[i]->blinding_requested = prog->blinding_requested;
 22896			func[i]->aux->kfunc_tab = prog->aux->kfunc_tab;
 22897			func[i]->aux->kfunc_btf_tab = prog->aux->kfunc_btf_tab;
 22898			func[i]->aux->linfo = prog->aux->linfo;
 22899			func[i]->aux->nr_linfo = prog->aux->nr_linfo;
 22900			func[i]->aux->jited_linfo = prog->aux->jited_linfo;
 22901			func[i]->aux->linfo_idx = env->subprog_info[i].linfo_idx;
 22902			func[i]->aux->arena = prog->aux->arena;
 22903			func[i]->aux->used_maps = env->used_maps;
 22904			func[i]->aux->used_map_cnt = env->used_map_cnt;
 22905			num_exentries = 0;
 22906			insn = func[i]->insnsi;
 22907			for (j = 0; j < func[i]->len; j++, insn++) {
 22908				if (BPF_CLASS(insn->code) == BPF_LDX &&
 22909				    (BPF_MODE(insn->code) == BPF_PROBE_MEM ||
 22910				     BPF_MODE(insn->code) == BPF_PROBE_MEM32 ||
 22911				     BPF_MODE(insn->code) == BPF_PROBE_MEM32SX ||
 22912				     BPF_MODE(insn->code) == BPF_PROBE_MEMSX))
 22913					num_exentries++;
 22914				if ((BPF_CLASS(insn->code) == BPF_STX ||
 22915				     BPF_CLASS(insn->code) == BPF_ST) &&
 22916				     BPF_MODE(insn->code) == BPF_PROBE_MEM32)
 22917					num_exentries++;
 22918				if (BPF_CLASS(insn->code) == BPF_STX &&
 22919				     BPF_MODE(insn->code) == BPF_PROBE_ATOMIC)
 22920					num_exentries++;
 22921			}
 22922			func[i]->aux->num_exentries = num_exentries;
 22923			func[i]->aux->tail_call_reachable = env->subprog_info[i].tail_call_reachable;
 22924			func[i]->aux->exception_cb = env->subprog_info[i].is_exception_cb;
 22925			func[i]->aux->changes_pkt_data = env->subprog_info[i].changes_pkt_data;
 22926			func[i]->aux->might_sleep = env->subprog_info[i].might_sleep;
 22927			if (!i)
 22928				func[i]->aux->exception_boundary = env->seen_exception;
 22929			func[i] = bpf_int_jit_compile(func[i]);
 22930			if (!func[i]->jited) {
 22931				err = -ENOTSUPP;
 22932				goto out_free;
 22933			}
 22934			cond_resched();
 22935		}
 22936	
 22937		/* at this point all bpf functions were successfully JITed
 22938		 * now populate all bpf_calls with correct addresses and
 22939		 * run last pass of JIT
 22940		 */
 22941		for (i = 0; i < env->subprog_cnt; i++) {
 22942			insn = func[i]->insnsi;
 22943			for (j = 0; j < func[i]->len; j++, insn++) {
 22944				if (bpf_pseudo_func(insn)) {
 22945					subprog = insn->off;
 22946					insn[0].imm = (u32)(long)func[subprog]->bpf_func;
 22947					insn[1].imm = ((u64)(long)func[subprog]->bpf_func) >> 32;
 22948					continue;
 22949				}
 22950				if (!bpf_pseudo_call(insn))
 22951					continue;
 22952				subprog = insn->off;
 22953				insn->imm = BPF_CALL_IMM(func[subprog]->bpf_func);
 22954			}
 22955	
 22956			/* we use the aux data to keep a list of the start addresses
 22957			 * of the JITed images for each function in the program
 22958			 *
 22959			 * for some architectures, such as powerpc64, the imm field
 22960			 * might not be large enough to hold the offset of the start
 22961			 * address of the callee's JITed image from __bpf_call_base
 22962			 *
 22963			 * in such cases, we can lookup the start address of a callee
 22964			 * by using its subprog id, available from the off field of
 22965			 * the call instruction, as an index for this list
 22966			 */
 22967			func[i]->aux->func = func;
 22968			func[i]->aux->func_cnt = env->subprog_cnt - env->hidden_subprog_cnt;
 22969			func[i]->aux->real_func_cnt = env->subprog_cnt;
 22970		}
 22971		for (i = 0; i < env->subprog_cnt; i++) {
 22972			old_bpf_func = func[i]->bpf_func;
 22973			tmp = bpf_int_jit_compile(func[i]);
 22974			if (tmp != func[i] || func[i]->bpf_func != old_bpf_func) {
 22975				verbose(env, "JIT doesn't support bpf-to-bpf calls\n");
 22976				err = -ENOTSUPP;
 22977				goto out_free;
 22978			}
 22979			cond_resched();
 22980		}
 22981	
 22982		/*
 22983		 * Cleanup func[i]->aux fields which aren't required
 22984		 * or can become invalid in future
 22985		 */
 22986		for (i = 0; i < env->subprog_cnt; i++) {
 22987			func[i]->aux->used_maps = NULL;
 22988			func[i]->aux->used_map_cnt = 0;
 22989		}
 22990	
 22991		/* finally lock prog and jit images for all functions and
 22992		 * populate kallsysm. Begin at the first subprogram, since
 22993		 * bpf_prog_load will add the kallsyms for the main program.
 22994		 */
 22995		for (i = 1; i < env->subprog_cnt; i++) {
 22996			err = bpf_prog_lock_ro(func[i]);
 22997			if (err)
 22998				goto out_free;
 22999		}
 23000	
 23001		for (i = 1; i < env->subprog_cnt; i++)
 23002			bpf_prog_kallsyms_add(func[i]);
 23003	
 23004		/* Last step: make now unused interpreter insns from main
 23005		 * prog consistent for later dump requests, so they can
 23006		 * later look the same as if they were interpreted only.
 23007		 */
 23008		for (i = 0, insn = prog->insnsi; i < prog->len; i++, insn++) {
 23009			if (bpf_pseudo_func(insn)) {
 23010				insn[0].imm = env->insn_aux_data[i].call_imm;
 23011				insn[1].imm = insn->off;
 23012				insn->off = 0;
 23013				continue;
 23014			}
 23015			if (!bpf_pseudo_call(insn))
 23016				continue;
 23017			insn->off = env->insn_aux_data[i].call_imm;
 23018			subprog = find_subprog(env, i + insn->off + 1);
 23019			insn->imm = subprog;
 23020		}
 23021	
 23022		prog->jited = 1;
 23023		prog->bpf_func = func[0]->bpf_func;
 23024		prog->jited_len = func[0]->jited_len;
 23025		prog->aux->extable = func[0]->aux->extable;
 23026		prog->aux->num_exentries = func[0]->aux->num_exentries;
 23027		prog->aux->func = func;
 23028		prog->aux->func_cnt = env->subprog_cnt - env->hidden_subprog_cnt;
 23029		prog->aux->real_func_cnt = env->subprog_cnt;
 23030		prog->aux->bpf_exception_cb = (void *)func[env->exception_callback_subprog]->bpf_func;
 23031		prog->aux->exception_boundary = func[0]->aux->exception_boundary;
 23032		bpf_prog_jit_attempt_done(prog);
 23033	
 23034		if (blinded)
 23035			bpf_jit_prog_release_other(prog, orig_prog);
 23036	
 23037		return 0;
 23038	out_free:
 23039		/* We failed JIT'ing, so at this point we need to unregister poke
 23040		 * descriptors from subprogs, so that kernel is not attempting to
 23041		 * patch it anymore as we're freeing the subprog JIT memory.
 23042		 */
 23043		for (i = 0; i < prog->aux->size_poke_tab; i++) {
 23044			map_ptr = prog->aux->poke_tab[i].tail_call.map;
 23045			map_ptr->ops->map_poke_untrack(map_ptr, prog->aux);
 23046		}
 23047		/* At this point we're guaranteed that poke descriptors are not
 23048		 * live anymore. We can just unlink its descriptor table as it's
 23049		 * released with the main prog.
 23050		 */
 23051		for (i = 0; i < env->subprog_cnt; i++) {
 23052			if (!func[i])
 23053				continue;
 23054			func[i]->aux->poke_tab = NULL;
 23055			bpf_jit_free(func[i]);
 23056		}
 23057		kfree(func);
 23058	out_undo_insn:
 23059		if (blinded) {
 23060			bpf_jit_prog_release_other(orig_prog, prog);
 23061			env->prog = prog = orig_prog;
 23062		}
 23063		/* cleanup main prog to be interpreted */
 23064		prog->jit_requested = 0;
 23065		prog->blinding_requested = 0;
 23066		for (i = 0, insn = prog->insnsi; i < prog->len; i++, insn++) {
 23067			if (!bpf_pseudo_call(insn))
 23068				continue;
 23069			insn->off = 0;
 23070			insn->imm = env->insn_aux_data[i].call_imm;
 23071		}
 23072		bpf_prog_jit_attempt_done(prog);
 23073		return err;
 23074	}
 23075	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
