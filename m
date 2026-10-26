Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.7
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793019081;
	b=VLq3pWmV9MQ0/eRpmKbogxWTWoyot0l2W0xKqCqD4Z19YTJN+8/oZMUaF4xoGssYFt2r
	 CZanOSDOCLjeDDJWRLG7EUQLteBPlGfY2sbyZ2+5VfgCmhcArksDA9+7hGuG9h+DZQqj7
	 FjI4no1Jkm08zymq6Kl7COWM7EgjtkYJ9XMSxLDmppEY0n1MTJmYRTTztZcPpMeJNinuy
	 5vU/fjcFybcAkk2hxjRwpt2ttyjV6emHI0NOtSOSAWYEyM8dJ/qcXqaMv22XaHd+v01SN
	 BAdAvZHoHEv+9g/No8+rIkDvVl+RmSUAmjwlEJGOTKihSSXRzMbeEvYXA0/6erm1iOA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793019081;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=lMwn+4oIVnsstSCbfq8MK68QF37dEg/bjP544vEx8bw=;
	b=TQjIx6NEYtOeEpCfjR2hIIxihSeilaPzLuVu2vi8td7fn3RSrAOe21n2p8+8m1GMZf7e
	 S3mua8Y0h8vb/9z7/PNK/Kpm+h1osAXuXqcNF+K+U97m2XTONRq4xqrtLNE+iygT1vPYk
	 HvpKEHej+n1OSiJ44fwY/Wj5KU4iMtmTPh+sWpiSrj7H1iwMKgUhTAEieP0GgHyXh3ZIc
	 A5SBo5sahHmYI2ti3kSN3n4gtELq8mnBE6e+KCExRDDPLqamDliw+Ymndq31myr8IHtP2
	 +4+QUTiCRlRx3NCuO7qfHhAUlSI0waVeMR9YOI4y1tkiikS8N97rPFxmBibUWmT/j3g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=jJxU+993;
	arc=none smtp.remote-ip=192.198.163.7
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0081606A328
	for <bpf@vger.kernel.org>; Mon, 26 Oct 2026 12:51:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B0081606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=jJxU+993
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793019080; x=1824555080;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ov/Z1+WmlvQ5EUqwjTPj/XboqzU4ywFSwt7x4HPKUXs=;
  b=jJxU+993J4dT/C7naZNFFQwNnRFpMCLnW7PrglLjI2PPQ6zyr9MCqM1/
   jH8LOarWag2DdyvpYC08ydNDmKLLRFx7dGSr6TbdjRvsjqshMHcj1WFWK
   QZcaqo13pvT/uDakdNsWB9zD4BSnvAOY4q31F5WHFODzClrF/MXXqKVqt
   jPqHATzGN0gYdYs+8rPZILToL/+2ygzj8wZMMxu4WKJRIvi4JmdhdWie8
   FdiWGmgg/tiG1EbK+FM3RHK+/hCWYfXr9C7SjcESupreqkMmKUcQUe0ff
   Y+WbuOtQlSIqfpS+4unXmT/jhHzfU1IiRS86TWc1PR9e/765XnOxRaXUA
   A==;
X-CSE-ConnectionGUID: 34VPqZVcS+mOl7+zCazvOw==
X-CSE-MsgGUID: ij6guFTYRnWS6kjTg/RikQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11946"; a="1580211"
X-IronPort-AV: E=Sophos;i="6.27,179,1787036400"; 
   d="scan'208";a="1580211"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2026 05:51:18 -0700
X-CSE-ConnectionGUID: otJytBP+RsS61yzVfDMkjQ==
X-CSE-MsgGUID: DhD2CGvfRxGXL9bEq03kAA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,179,1787036400"; 
   d="scan'208";a="6083943"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
  by fmviesa013.fm.intel.com with ESMTP; 26 Oct 2026 05:51:17 -0700
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xLKAT-00000000Vvu-3EaZ;
	Mon, 26 Oct 2026 12:51:13 +0000
Date: Mon, 26 Oct 2026 20:51:11 +0800
From: kernel test robot <lkp@intel.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, daniel@iogearbox.net, andrii@kernel.org,
	eddyz87@gmail.com, memxor@gmail.com
Subject: Re: [PATCH bpf 51/81] bpf: Check stack and count calls of recursive
 subprogs at run time
Message-ID: <202610262057.WlLdhg8d-lkp@intel.com>
References: <20261026025943.404450-52-alexei.starovoitov@gmail.com>
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
In-Reply-To: <20261026025943.404450-52-alexei.starovoitov@gmail.com>

Hi Alexei,

kernel test robot noticed the following build errors:

[auto build test ERROR on bpf/master]

url:    https://github.com/intel-lab-lkp/linux/commits/Alexei-Starovoitov/selftests-bpf-Remove-tests-for-global-data-in-arena/20261026-025822
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git master
patch link:    https://lore.kernel.org/r/20261026025943.404450-52-alexei.starovoitov%40gmail.com
patch subject: [PATCH bpf 51/81] bpf: Check stack and count calls of recursive subprogs at run time
config: powerpc-randconfig-1000-20261026 (https://download.01.org/0day-ci/archive/20261026/202610262057.WlLdhg8d-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 8.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261026/202610262057.WlLdhg8d-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202610262057.WlLdhg8d-lkp@intel.com/

All errors (new ones prefixed by >>):

   kernel/bpf/fixups.c: In function 'bpf_insert_recursion_checks':
>> kernel/bpf/fixups.c:792:28: error: macro "__fortify_memcpy_chk" passed 9 arguments, but takes just 8
             2 * sizeof(buf[0]));
                               ^
   In file included from include/linux/string.h:396,
                    from include/crypto/sha2.h:10,
                    from include/linux/bpf.h:11,
                    from kernel/bpf/fixups.c:3:
>> include/linux/fortify-string.h:638:26: error: '__fortify_memcpy_chk' undeclared (first use in this function); did you mean 'fortify_memcpy_chk'?
    #define memcpy(p, q, s)  __fortify_memcpy_chk(p, q, s,   \
                             ^~~~~~~~~~~~~~~~~~~~
   kernel/bpf/fixups.c:791:3: note: in expansion of macro 'memcpy'
      memcpy(buf + n, (struct bpf_insn[]){ BPF_LD_IMM64(BPF_REG_0, (long)depth) },
      ^~~~~~
   include/linux/fortify-string.h:638:26: note: each undeclared identifier is reported only once for each function it appears in
    #define memcpy(p, q, s)  __fortify_memcpy_chk(p, q, s,   \
                             ^~~~~~~~~~~~~~~~~~~~
   kernel/bpf/fixups.c:791:3: note: in expansion of macro 'memcpy'
      memcpy(buf + n, (struct bpf_insn[]){ BPF_LD_IMM64(BPF_REG_0, (long)depth) },
      ^~~~~~
   kernel/bpf/fixups.c:834:27: error: macro "__fortify_memcpy_chk" passed 9 arguments, but takes just 8
            2 * sizeof(buf[0]));
                              ^
   kernel/bpf/fixups.c:865:28: error: macro "__fortify_memcpy_chk" passed 9 arguments, but takes just 8
             2 * sizeof(buf[0]));
                               ^


vim +/__fortify_memcpy_chk +792 kernel/bpf/fixups.c

   696	
   697	/*
   698	 * How deep a recursion goes is not known, so it is counted at run time. In the same
   699	 * spirit as may_goto: the program goes on for as long as there is budget and
   700	 * takes a way out that was verified when there is none.
   701	 *
   702	 * Every subprog on a cycle of the call graph adds its weight to a per-cpu
   703	 * counter of the program when it is entered and takes it back at every exit.
   704	 * The weight is the part of the budget that its frame takes: of the stack
   705	 * room, or of the room in the stack in arena, whichever is larger. So these
   706	 * frames take no more than BPF_RECURSION_STACK, on top of the chain of calls
   707	 * without recursion that check_max_stack_depth() looked at.
   708	 *
   709	 * A subprog that calls itself twice doesn't have to go deep to go on forever. So
   710	 * the calls are counted too: BPF_MAX_LOOPS of them in a run of the prog, like the
   711	 * callbacks of bpf_loop(). Once they are used up every call returns at once, and
   712	 * the frames that are there come to an end.
   713	 *
   714	 * Another run of the program on the same cpu, in interrupt or after
   715	 * preemption, counts in the same counter. Then there is less for both.
   716	 */
   717	int bpf_insert_recursion_checks(struct bpf_verifier_env *env)
   718	{
   719		struct bpf_subprog_info *si = env->subprog_info;
   720		u32 frame, min_frame = U32_MAX, arena_frame = 0, arena_room = 0, weight;
   721		u32 limit = BPF_RECURSION_STACK;
   722		struct bpf_insn buf[24], first;
   723		struct bpf_prog *new_prog;
   724		struct bpf_recursion_budget __percpu *depth;
   725		/* Only this cpu touches the counters */
   726		int fetch_add = BPF_ADD | BPF_FETCH |
   727				(bpf_jit_supports_local_atomics() ? BPF_ATOMIC_LOCAL : 0);
   728		int i, s, n, bail, bail_len, err;
   729	
   730		for (s = 0; s < env->subprog_cnt; s++) {
   731			if (!si[s].recursive)
   732				continue;
   733			frame = recursive_frame_size(env, s);
   734			si[s].recursion_weight = DIV_ROUND_UP(frame * BPF_RECURSION_UNITS, limit);
   735			min_frame = min(min_frame, frame);
   736			arena_frame = max(arena_frame, si[s].arena_stack_depth);
   737		}
   738		if (min_frame == U32_MAX)
   739			return 0;
   740		if (arena_frame) {
   741			/*
   742			 * One more frame is for the subprog that finds that there is no
   743			 * budget: it has its frame by then.
   744			 */
   745			u32 room = BPF_ARENA_STACK_MAX - env->max_arena_stack_depth;
   746	
   747			if (room < 2 * arena_frame) {
   748				verbose(env, "no room in the stack in arena for recursion\n");
   749				return -EACCES;
   750			}
   751			/* no more than the frames that fit in the stack can take */
   752			arena_room = min(room - arena_frame, limit / min_frame * arena_frame);
   753			env->max_arena_stack_depth += arena_room + arena_frame;
   754		}
   755		for (s = 0; s < env->subprog_cnt; s++) {
   756			if (!si[s].recursive)
   757				continue;
   758			if (si[s].arena_stack_depth)
   759				si[s].recursion_weight = max(si[s].recursion_weight,
   760							     DIV_ROUND_UP(si[s].arena_stack_depth *
   761									  BPF_RECURSION_UNITS, arena_room));
   762			if (si[s].recursion_weight > BPF_RECURSION_UNITS) {
   763				verbose(env, "the frame of recursive %s() is too large\n",
   764					bpf_subprog_name(env, s));
   765				return -EACCES;
   766			}
   767		}
   768	
   769		depth = alloc_percpu_gfp(struct bpf_recursion_budget, GFP_KERNEL_ACCOUNT);
   770		if (!depth)
   771			return -ENOMEM;
   772		env->prog->aux->call_depth = depth;
   773		env->prog->jit_required = 1;
   774	
   775		/* From the last one, so that nothing moves in those that are yet to be done. */
   776		for (s = env->subprog_cnt - 1; s > 0; s--) {
   777			if (!si[s].recursive)
   778				continue;
   779			/*
   780			 * R0 has nothing at the entry. The address is not for AX:
   781			 * blinding of constants takes ld_imm64 apart with the help of
   782			 * AX. It leaves alone the insns that have AX in them.
   783			 */
   784			n = 0;
   785			first = env->prog->insnsi[si[s].start];
   786			/* The exit drops the frame in the stack in arena. Take it before the check. */
   787			if (is_arena_sp_adj(&first)) {
   788				buf[n++] = first;
   789				first = BPF_JMP_A(0);
   790			}
   791			memcpy(buf + n, (struct bpf_insn[]){ BPF_LD_IMM64(BPF_REG_0, (long)depth) },
 > 792			       2 * sizeof(buf[0]));
   793			n += 2;
   794			buf[n++] = BPF_MOV64_PERCPU_REG(BPF_REG_0, BPF_REG_0);
   795			weight = si[s].recursion_weight;
   796			bail_len = bpf_ret_reg_pair(env, s) ? 3 : 2;
   797			buf[n++] = BPF_MOV64_IMM(BPF_REG_AX, weight);
   798			buf[n++] = BPF_ATOMIC_OP(BPF_W, fetch_add, BPF_REG_0, BPF_REG_AX,
   799						 offsetof(struct bpf_recursion_budget, depth));
   800			buf[n++] = BPF_JMP_IMM(BPF_JGT, BPF_REG_AX, BPF_RECURSION_UNITS - weight, 3);
   801			buf[n++] = BPF_MOV64_IMM(BPF_REG_AX, 1);
   802			buf[n++] = BPF_ATOMIC_OP(BPF_W, fetch_add, BPF_REG_0, BPF_REG_AX,
   803						 offsetof(struct bpf_recursion_budget, calls));
   804			buf[n++] = BPF_JMP_IMM(BPF_JLT, BPF_REG_AX, BPF_MAX_LOOPS, bail_len);
   805			bail = n;
   806			buf[n++] = BPF_MOV64_IMM(BPF_REG_0, 0);
   807			if (bpf_ret_reg_pair(env, s))
   808				buf[n++] = BPF_MOV64_IMM(BPF_REG_2, 0);
   809			buf[n++] = budget_exit_insn(env, &si[s]);
   810			buf[n] = first;
   811			err = bpf_adj_moved_insn(&buf[n], n);
   812			if (err) {
   813				verbose(env, "insn %d cannot be patched due to 16-bit range\n",
   814					env->insn_aux_data[si[s].start].orig_idx);
   815				return err;
   816			}
   817			n++;
   818			new_prog = __bpf_patch_insn_data(env, si[s].start, buf, n, BPF_PATCH_MOVE_TARGET);
   819			if (!new_prog)
   820				return -ENOMEM;
   821			env->prog = new_prog;
   822			env->insn_aux_data[si[s].start + bail].recursion_bail = true;
   823			/* calls get to the check, jumps to the first insn do not */
   824			err = adjust_jmp_off(env->prog, si[s].start, n - 1);
   825			if (err)
   826				return err;
   827		}
   828	
   829		/*
   830		 * The calls are counted anew when a run begins. For async callbacks see
   831		 * bpf_prog_begin_run(). R0 has nothing at the entry.
   832		 */
   833		memcpy(buf, (struct bpf_insn[]){ BPF_LD_IMM64(BPF_REG_0, (long)depth) },
   834		       2 * sizeof(buf[0]));
   835		buf[2] = BPF_MOV64_PERCPU_REG(BPF_REG_0, BPF_REG_0);
   836		/* calls and reported */
   837		buf[3] = BPF_ST_MEM(BPF_DW, BPF_REG_0, 0, 0);
   838		buf[4] = env->prog->insnsi[0];
   839		err = bpf_adj_moved_insn(&buf[4], 4);
   840		if (err) {
   841			verbose(env, "insn %d cannot be patched due to 16-bit range\n",
   842				env->insn_aux_data[0].orig_idx);
   843			return err;
   844		}
   845		new_prog = __bpf_patch_insn_data(env, 0, buf, 5, BPF_PATCH_MOVE_TARGET);
   846		if (!new_prog)
   847			return -ENOMEM;
   848		env->prog = new_prog;
   849		/* a jump to the first insn doesn't begin a run */
   850		err = adjust_jmp_off(env->prog, 0, 4);
   851		if (err)
   852			return err;
   853	
   854		/* R1 is nothing to the caller. Jumps to exit get to what is added. */
   855		for (i = 0; i < env->prog->len; i++) {
   856			if (bpf_is_ldimm64(&env->prog->insnsi[i])) {
   857				i++;
   858				continue;
   859			}
   860			if (env->prog->insnsi[i].code != (BPF_JMP | BPF_EXIT) ||
   861			    !bpf_find_containing_subprog(env, i)->recursive)
   862				continue;
   863			n = 0;
   864			memcpy(buf, (struct bpf_insn[]){ BPF_LD_IMM64(BPF_REG_1, (long)depth) },
   865			       2 * sizeof(buf[0]));
   866			n += 2;
   867			buf[n++] = BPF_MOV64_PERCPU_REG(BPF_REG_1, BPF_REG_1);
   868			weight = bpf_find_containing_subprog(env, i)->recursion_weight;
   869			buf[n++] = BPF_MOV64_IMM(BPF_REG_AX, -(int)weight);
   870			buf[n++] = BPF_ATOMIC_OP(BPF_W, fetch_add, BPF_REG_1, BPF_REG_AX,
   871						 offsetof(struct bpf_recursion_budget, depth));
   872			buf[n++] = env->prog->insnsi[i];
   873			new_prog = bpf_patch_insn_data(env, i, buf, n);
   874			if (!new_prog)
   875				return -ENOMEM;
   876			env->prog = new_prog;
   877			i += n - 1;
   878		}
   879		return 0;
   880	}
   881	

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
