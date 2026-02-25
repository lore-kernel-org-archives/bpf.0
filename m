Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AEB13E958C
	for <bpf@vger.kernel.org>; Wed, 25 Feb 2026 17:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772039644; cv=none; b=ACJkFG9A0LV8oDR8kUrSl6jLy74GhWBsYP9q/dTwRHtbY2EW6zBd0W1XHgkb0B+HA47w+aHT2bayZxImYNIf/htarkp0WfYbsFq2PfsLvWpqYLpPNNfCqt2rw6JyRnzm3CH6wo5kQq6oVp4hWKSxi+LsaIPMZ46Lb/uwi7yU9i0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772039644; c=relaxed/simple;
	bh=nUo04ih3SDy0r3suDHQjkZDw8s/+NqXtWaoVNaiVJzk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oM04TyIJjmQEeJxse429/5MJFLmE1cn/ub7q9aPQFQA6otcbLkA6M1Is6T4pV3Vru55eq64ubrpWjFyfX2wdAhrUfKbDcc+hMJ+JuZ2lV5DZsJHMLW7eelZmkk09PvlL5j70QGYZTgAcei+SPi/YcQF279m3Q0rGD67/Lmvhsl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NNIACqKF; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NNIACqKF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772039641; x=1803575641;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=nUo04ih3SDy0r3suDHQjkZDw8s/+NqXtWaoVNaiVJzk=;
  b=NNIACqKF7wLMNVB1LoLqO8V7CNWicdBriGDWx59umVMovEDyjyovP42/
   aHWVxyO48B9HeWhRIwXT6GqXYNzCTqI2IcyEOWfnAYUBRLNhHSFbqmGGB
   TRwlhIOZnQnSKdnx038dFyYSzb2vWirufHvfst0r+F5WLAlEaZq9EziM1
   jA/fWc0/sWDGCOIQtxxQ3D+y6pGvPP42u3MgG3SfN3ufie7XMB5tJHI65
   K+Jj8Q6e2BqcN1gij5ZwaOAXWVt0fHQl1yVuHZWcADbYmz1zL+xH4Pk6A
   l+Rk7UGdkAO4wwvQPZPCNhTOmT0TnD0HKBv+YoUQlJ2D2JXNF3gcdEI/z
   Q==;
X-CSE-ConnectionGUID: //0SpNYeQXSLjAHUYP1+zA==
X-CSE-MsgGUID: kGcm+HBGTqWObFPMTDyDNg==
X-IronPort-AV: E=McAfee;i="6800,10657,11712"; a="98555861"
X-IronPort-AV: E=Sophos;i="6.21,310,1763452800"; 
   d="scan'208";a="98555861"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2026 09:14:01 -0800
X-CSE-ConnectionGUID: Nr6cnKMKQNmf9WXDGJ6XbA==
X-CSE-MsgGUID: ERRqZfocT9ilA52qPrFI0Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,310,1763452800"; 
   d="scan'208";a="215516689"
Received: from lkp-server02.sh.intel.com (HELO a3936d6a266d) ([10.239.97.151])
  by orviesa010.jf.intel.com with ESMTP; 25 Feb 2026 09:13:58 -0800
Received: from kbuild by a3936d6a266d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vvISR-000000006gP-1Lft;
	Wed, 25 Feb 2026 17:13:55 +0000
Date: Thu, 26 Feb 2026 01:13:18 +0800
From: kernel test robot <lkp@intel.com>
To: adubey@linux.ibm.com, linuxppc-dev@lists.ozlabs.org
Cc: oe-kbuild-all@lists.linux.dev, bpf@vger.kernel.org,
	hbathini@linux.ibm.com, ast@kernel.org, daniel@iogearbox.net,
	andrii@kernel.org, maddy@linux.ibm.com,
	Abhishek Dubey <adubey@linux.ibm.com>
Subject: Re: [PATCH v2 1/2] powerpc64/bpf: Implement JIT support for private
 stack
Message-ID: <202602260116.5ljOxwdH-lkp@intel.com>
References: <20260225153950.15331-1-adubey@linux.ibm.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260225153950.15331-1-adubey@linux.ibm.com>

Hi,

kernel test robot noticed the following build warnings:

[auto build test WARNING on bpf-next/master]
[also build test WARNING on bpf/master powerpc/next linus/master v7.0-rc1 next-20260224]
[cannot apply to bpf-next/net powerpc/fixes]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/adubey-linux-ibm-com/selftests-bpf-Enable-private-stack-tests-for-powerpc64/20260225-184532
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
patch link:    https://lore.kernel.org/r/20260225153950.15331-1-adubey%40linux.ibm.com
patch subject: [PATCH v2 1/2] powerpc64/bpf: Implement JIT support for private stack
config: powerpc-randconfig-r123-20260225 (https://download.01.org/0day-ci/archive/20260226/202602260116.5ljOxwdH-lkp@intel.com/config)
compiler: clang version 23.0.0git (https://github.com/llvm/llvm-project 9a109fbb6e184ec9bcce10615949f598f4c974a9)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260226/202602260116.5ljOxwdH-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202602260116.5ljOxwdH-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> arch/powerpc/net/bpf_jit_comp.c:222:7: warning: variable 'addrs' is used uninitialized whenever 'if' condition is true [-Wsometimes-uninitialized]
     222 |                 if (!priv_stack_ptr) {
         |                     ^~~~~~~~~~~~~~~
   arch/powerpc/net/bpf_jit_comp.c:370:9: note: uninitialized use occurs here
     370 |                 kfree(addrs);
         |                       ^~~~~
   arch/powerpc/net/bpf_jit_comp.c:222:3: note: remove the 'if' if its condition is always false
     222 |                 if (!priv_stack_ptr) {
         |                 ^~~~~~~~~~~~~~~~~~~~~~
     223 |                         fp = org_fp;
         |                         ~~~~~~~~~~~~
     224 |                         goto out_priv_stack;
         |                         ~~~~~~~~~~~~~~~~~~~~
     225 |                 }
         |                 ~
   arch/powerpc/net/bpf_jit_comp.c:171:12: note: initialize the variable 'addrs' to silence this warning
     171 |         u32 *addrs;
         |                   ^
         |                    = NULL
   1 warning generated.


vim +222 arch/powerpc/net/bpf_jit_comp.c

   164	
   165	struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *fp)
   166	{
   167		u32 proglen;
   168		u32 alloclen;
   169		u8 *image = NULL;
   170		u32 *code_base;
   171		u32 *addrs;
   172		struct powerpc_jit_data *jit_data;
   173		struct codegen_context cgctx;
   174		int pass;
   175		int flen;
   176		int priv_stack_alloc_size;
   177		void __percpu *priv_stack_ptr = NULL;
   178		struct bpf_binary_header *fhdr = NULL;
   179		struct bpf_binary_header *hdr = NULL;
   180		struct bpf_prog *org_fp = fp;
   181		struct bpf_prog *tmp_fp;
   182		bool bpf_blinded = false;
   183		bool extra_pass = false;
   184		u8 *fimage = NULL;
   185		u32 *fcode_base;
   186		u32 extable_len;
   187		u32 fixup_len;
   188	
   189		if (!fp->jit_requested)
   190			return org_fp;
   191	
   192		tmp_fp = bpf_jit_blind_constants(org_fp);
   193		if (IS_ERR(tmp_fp))
   194			return org_fp;
   195	
   196		if (tmp_fp != org_fp) {
   197			bpf_blinded = true;
   198			fp = tmp_fp;
   199		}
   200	
   201		jit_data = fp->aux->jit_data;
   202		if (!jit_data) {
   203			jit_data = kzalloc_obj(*jit_data);
   204			if (!jit_data) {
   205				fp = org_fp;
   206				goto out;
   207			}
   208			fp->aux->jit_data = jit_data;
   209		}
   210	
   211		priv_stack_ptr = fp->aux->priv_stack_ptr;
   212		if (!priv_stack_ptr && fp->aux->jits_use_priv_stack) {
   213			/*
   214			 * Allocate private stack of size equivalent to
   215			 * verifier-calculated stack size plus two memory
   216			 * guard regions to detect private stack overflow
   217			 * and underflow.
   218			 */
   219			priv_stack_alloc_size = round_up(fp->aux->stack_depth, 16) +
   220								2 * PRIV_STACK_GUARD_SZ;
   221			priv_stack_ptr = __alloc_percpu_gfp(priv_stack_alloc_size, 16, GFP_KERNEL);
 > 222			if (!priv_stack_ptr) {
   223				fp = org_fp;
   224				goto out_priv_stack;
   225			}
   226	
   227			priv_stack_init_guard(priv_stack_ptr, priv_stack_alloc_size);
   228			fp->aux->priv_stack_ptr = priv_stack_ptr;
   229		}
   230	
   231		flen = fp->len;
   232		addrs = jit_data->addrs;
   233		if (addrs) {
   234			cgctx = jit_data->ctx;
   235			/*
   236			 * JIT compiled to a writable location (image/code_base) first.
   237			 * It is then moved to the readonly final location (fimage/fcode_base)
   238			 * using instruction patching.
   239			 */
   240			fimage = jit_data->fimage;
   241			fhdr = jit_data->fhdr;
   242			proglen = jit_data->proglen;
   243			hdr = jit_data->hdr;
   244			image = (void *)hdr + ((void *)fimage - (void *)fhdr);
   245			extra_pass = true;
   246			/* During extra pass, ensure index is reset before repopulating extable entries */
   247			cgctx.exentry_idx = 0;
   248			goto skip_init_ctx;
   249		}
   250	
   251		addrs = kcalloc(flen + 1, sizeof(*addrs), GFP_KERNEL);
   252		if (addrs == NULL) {
   253			fp = org_fp;
   254			goto out_addrs;
   255		}
   256	
   257		memset(&cgctx, 0, sizeof(struct codegen_context));
   258		bpf_jit_init_reg_mapping(&cgctx);
   259	
   260		/* Make sure that the stack is quadword aligned. */
   261		cgctx.stack_size = round_up(fp->aux->stack_depth, 16);
   262		cgctx.arena_vm_start = bpf_arena_get_kern_vm_start(fp->aux->arena);
   263		cgctx.user_vm_start = bpf_arena_get_user_vm_start(fp->aux->arena);
   264		cgctx.is_subprog = bpf_is_subprog(fp);
   265		cgctx.exception_boundary = fp->aux->exception_boundary;
   266		cgctx.exception_cb = fp->aux->exception_cb;
   267		cgctx.priv_sp = priv_stack_ptr;
   268	
   269		/* Scouting faux-generate pass 0 */
   270		if (bpf_jit_build_body(fp, NULL, NULL, &cgctx, addrs, 0, false)) {
   271			/* We hit something illegal or unsupported. */
   272			fp = org_fp;
   273			goto out_addrs;
   274		}
   275	
   276		/*
   277		 * If we have seen a tail call, we need a second pass.
   278		 * This is because bpf_jit_emit_common_epilogue() is called
   279		 * from bpf_jit_emit_tail_call() with a not yet stable ctx->seen.
   280		 * We also need a second pass if we ended up with too large
   281		 * a program so as to ensure BPF_EXIT branches are in range.
   282		 */
   283		if (cgctx.seen & SEEN_TAILCALL || !is_offset_in_branch_range((long)cgctx.idx * 4)) {
   284			cgctx.idx = 0;
   285			if (bpf_jit_build_body(fp, NULL, NULL, &cgctx, addrs, 0, false)) {
   286				fp = org_fp;
   287				goto out_addrs;
   288			}
   289		}
   290	
   291		bpf_jit_realloc_regs(&cgctx);
   292		/*
   293		 * Pretend to build prologue, given the features we've seen.  This will
   294		 * update ctgtx.idx as it pretends to output instructions, then we can
   295		 * calculate total size from idx.
   296		 */
   297		bpf_jit_build_prologue(NULL, &cgctx);
   298		addrs[fp->len] = cgctx.idx * 4;
   299		bpf_jit_build_epilogue(NULL, &cgctx);
   300	
   301		fixup_len = fp->aux->num_exentries * BPF_FIXUP_LEN * 4;
   302		extable_len = fp->aux->num_exentries * sizeof(struct exception_table_entry);
   303	
   304		proglen = cgctx.idx * 4;
   305		alloclen = proglen + FUNCTION_DESCR_SIZE + fixup_len + extable_len;
   306	
   307		fhdr = bpf_jit_binary_pack_alloc(alloclen, &fimage, 4, &hdr, &image,
   308						      bpf_jit_fill_ill_insns);
   309		if (!fhdr) {
   310			fp = org_fp;
   311			goto out_addrs;
   312		}
   313	
   314		if (extable_len)
   315			fp->aux->extable = (void *)fimage + FUNCTION_DESCR_SIZE + proglen + fixup_len;
   316	
   317	skip_init_ctx:
   318		code_base = (u32 *)(image + FUNCTION_DESCR_SIZE);
   319		fcode_base = (u32 *)(fimage + FUNCTION_DESCR_SIZE);
   320	
   321		/* Code generation passes 1-2 */
   322		for (pass = 1; pass < 3; pass++) {
   323			/* Now build the prologue, body code & epilogue for real. */
   324			cgctx.idx = 0;
   325			cgctx.alt_exit_addr = 0;
   326			bpf_jit_build_prologue(code_base, &cgctx);
   327			if (bpf_jit_build_body(fp, code_base, fcode_base, &cgctx, addrs, pass,
   328					       extra_pass)) {
   329				bpf_arch_text_copy(&fhdr->size, &hdr->size, sizeof(hdr->size));
   330				bpf_jit_binary_pack_free(fhdr, hdr);
   331				fp = org_fp;
   332				goto out_addrs;
   333			}
   334			bpf_jit_build_epilogue(code_base, &cgctx);
   335	
   336			if (bpf_jit_enable > 1)
   337				pr_info("Pass %d: shrink = %d, seen = 0x%x\n", pass,
   338					proglen - (cgctx.idx * 4), cgctx.seen);
   339		}
   340	
   341		if (bpf_jit_enable > 1)
   342			/*
   343			 * Note that we output the base address of the code_base
   344			 * rather than image, since opcodes are in code_base.
   345			 */
   346			bpf_jit_dump(flen, proglen, pass, code_base);
   347	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
