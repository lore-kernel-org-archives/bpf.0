Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00A111FF7C7
	for <bpf@vger.kernel.org>; Tue, 17 Feb 2026 01:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771293008; cv=none; b=BS/Fegli74gjYWSkwLL7+uFTTTz2jKI5vZLPqPvvnVrwUgDU8/LhWLkUbwuNqU51pZ7E/8AEgD1e8NWqxsKV+kUQWsobKwrdSauZR3qjsxvLQ2dvtNYnmEiaQWkcWmNabcsR1FP5Oa8WrfL95pAt/mbj106FmDg7KIUX63ZoJR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771293008; c=relaxed/simple;
	bh=tB2iANIoliVRoxJY0Yh1Zbwf52Y1p61Ktt0sl8ORDoc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KwbmnES0S0/nFCi376fwwRYU8/vpLDkp6QeFKRBO+2jDzItU27bMhzz8oMQx16VPUo8sJAH+e66SvYG4WwBglEk0CVZqGRnE/owtACK0sf9AezoCoWDaJ1fwuNIWqg9tIledLgmso7WQtMiSUVa0xsKIXxp8dU2HeSsOii4f+bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ltpxQ97O; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ltpxQ97O"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771293007; x=1802829007;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=tB2iANIoliVRoxJY0Yh1Zbwf52Y1p61Ktt0sl8ORDoc=;
  b=ltpxQ97OKJQ88vKS6TY621pg0Hp7s1gAo7n2LtHa3IwNXAwDG5tmPD/A
   DK+nt8x8T8fVpiX7QiwMOB+0FmqdZKTZgg+JOUMiPOSswCYqXqYYATgVG
   2Eemzz5zHzBvY8OeMS0xSpbVHnKHEVypkmfBgRR4aThffsNuINYE2XWRG
   QFtPnIvLMlJEPssmfQRXwdUljGC3gCYwxOsr+uc+6KHfsSrmirVi2HdS7
   eafgotzqHpAj3anNQpn1nGmzDyocSEf0nKF4mgWIukrfr30q/VLkJgey9
   9pfckvMGUl4I9TPmzFhniwtqB23Iabr40PyTJnvYX1UZ84ZaEzuZ/19gE
   g==;
X-CSE-ConnectionGUID: u2d265TJQCqvYlTxQdjs+A==
X-CSE-MsgGUID: UACeErf8Q8GNGUfKQFNcwg==
X-IronPort-AV: E=McAfee;i="6800,10657,11703"; a="82996453"
X-IronPort-AV: E=Sophos;i="6.21,295,1763452800"; 
   d="scan'208";a="82996453"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2026 17:50:06 -0800
X-CSE-ConnectionGUID: 2I/HuGqsSpOki0MF7JxgGQ==
X-CSE-MsgGUID: f9SWCtP8QayNuqmJGWLWnQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,295,1763452800"; 
   d="scan'208";a="217714744"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 16 Feb 2026 17:50:03 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vsADw-000000010Ts-2bJt;
	Tue, 17 Feb 2026 01:50:00 +0000
Date: Tue, 17 Feb 2026 09:49:09 +0800
From: kernel test robot <lkp@intel.com>
To: adubey@linux.ibm.com, bpf@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, hbathini@linux.ibm.com,
	linuxppc-dev@lists.ozlabs.org, ast@kernel.org, daniel@iogearbox.net,
	andrii@kernel.org, martin.lau@kernel.org, eddyz87@gmail.com,
	yonghong.song@linux.dev, clm@meta.com, ihor.solodrai@linux.dev,
	chleroy@kernel.org, Abhishek Dubey <adubey@linux.ibm.com>
Subject: Re: [PATCH 1/2] powerpc64/bpf: Implement JIT support for private
 stack
Message-ID: <202602170941.f1KIvBuf-lkp@intel.com>
References: <20260216152234.36632-1-adubey@linux.ibm.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260216152234.36632-1-adubey@linux.ibm.com>

Hi,

kernel test robot noticed the following build warnings:

[auto build test WARNING on bpf-next/master]
[also build test WARNING on bpf/master powerpc/next linus/master next-20260216]
[cannot apply to bpf-next/net powerpc/fixes v6.19]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/adubey-linux-ibm-com/selftests-bpf-Enable-private-stack-tests-for-powerpc64/20260216-182353
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
patch link:    https://lore.kernel.org/r/20260216152234.36632-1-adubey%40linux.ibm.com
patch subject: [PATCH 1/2] powerpc64/bpf: Implement JIT support for private stack
config: powerpc64-randconfig-r133-20260217 (https://download.01.org/0day-ci/archive/20260217/202602170941.f1KIvBuf-lkp@intel.com/config)
compiler: powerpc64-linux-gcc (GCC) 8.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260217/202602170941.f1KIvBuf-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202602170941.f1KIvBuf-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> arch/powerpc/net/bpf_jit_comp.c:266:43: sparse: sparse: cast removes address space '__percpu' of expression
--
>> arch/powerpc/net/bpf_jit_comp64.c:186:9: sparse: sparse: cast removes address space '__percpu' of expression
>> arch/powerpc/net/bpf_jit_comp64.c:186:9: sparse: sparse: cast removes address space '__percpu' of expression
>> arch/powerpc/net/bpf_jit_comp64.c:186:9: sparse: sparse: cast removes address space '__percpu' of expression
>> arch/powerpc/net/bpf_jit_comp64.c:186:9: sparse: sparse: cast removes address space '__percpu' of expression
>> arch/powerpc/net/bpf_jit_comp64.c:186:9: sparse: sparse: cast removes address space '__percpu' of expression
>> arch/powerpc/net/bpf_jit_comp64.c:186:9: sparse: sparse: cast removes address space '__percpu' of expression
>> arch/powerpc/net/bpf_jit_comp64.c:186:9: sparse: sparse: cast removes address space '__percpu' of expression
>> arch/powerpc/net/bpf_jit_comp64.c:186:9: sparse: sparse: cast removes address space '__percpu' of expression
>> arch/powerpc/net/bpf_jit_comp64.c:186:9: sparse: sparse: cast removes address space '__percpu' of expression
>> arch/powerpc/net/bpf_jit_comp64.c:186:9: sparse: sparse: cast removes address space '__percpu' of expression
>> arch/powerpc/net/bpf_jit_comp64.c:186:9: sparse: sparse: cast removes address space '__percpu' of expression
>> arch/powerpc/net/bpf_jit_comp64.c:186:9: sparse: sparse: cast removes address space '__percpu' of expression
>> arch/powerpc/net/bpf_jit_comp64.c:186:9: sparse: sparse: cast removes address space '__percpu' of expression
>> arch/powerpc/net/bpf_jit_comp64.c:186:9: sparse: sparse: cast removes address space '__percpu' of expression
>> arch/powerpc/net/bpf_jit_comp64.c:186:9: sparse: sparse: cast removes address space '__percpu' of expression
>> arch/powerpc/net/bpf_jit_comp64.c:186:9: sparse: sparse: cast removes address space '__percpu' of expression
>> arch/powerpc/net/bpf_jit_comp64.c:186:9: sparse: sparse: cast removes address space '__percpu' of expression
>> arch/powerpc/net/bpf_jit_comp64.c:212:32: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __percpu *priv_frame_ptr @@     got void * @@
   arch/powerpc/net/bpf_jit_comp64.c:212:32: sparse:     expected void [noderef] __percpu *priv_frame_ptr
   arch/powerpc/net/bpf_jit_comp64.c:212:32: sparse:     got void *
   arch/powerpc/net/bpf_jit_comp64.c:1476:41: sparse: sparse: cast truncates bits from constant value (8000000000000000 becomes 0)
   arch/powerpc/net/bpf_jit_comp64.c:1476:41: sparse: sparse: cast truncates bits from constant value (8000000000000000 becomes 0)
   arch/powerpc/net/bpf_jit_comp64.c:1478:41: sparse: sparse: cast truncates bits from constant value (c000000000000000 becomes 0)
   arch/powerpc/net/bpf_jit_comp64.c:1478:41: sparse: sparse: cast truncates bits from constant value (c000000000000000 becomes 0)

vim +/__percpu +266 arch/powerpc/net/bpf_jit_comp.c

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
   203			jit_data = kzalloc(sizeof(*jit_data), GFP_KERNEL);
   204			if (!jit_data) {
   205				fp = org_fp;
   206				goto out;
   207			}
   208			fp->aux->jit_data = jit_data;
   209		}
   210	
   211		if (!priv_stack_ptr && fp->aux->jits_use_priv_stack) {
   212			/*
   213			 * Allocate private stack of size equivalent to
   214			 * verifier-calculated stack size plus two memory
   215			 * guard regions to detect private stack overflow
   216			 * and underflow.
   217			 */
   218			priv_stack_alloc_size = round_up(fp->aux->stack_depth, 16) +
   219								2 * PRIV_STACK_GUARD_SZ;
   220			priv_stack_ptr = __alloc_percpu_gfp(priv_stack_alloc_size, 16, GFP_KERNEL);
   221			if (!priv_stack_ptr) {
   222				fp = org_fp;
   223				goto out_priv_stack;
   224			}
   225	
   226			priv_stack_init_guard(priv_stack_ptr, priv_stack_alloc_size);
   227			fp->aux->priv_stack_ptr = priv_stack_ptr;
   228		}
   229	
   230		flen = fp->len;
   231		addrs = jit_data->addrs;
   232		if (addrs) {
   233			cgctx = jit_data->ctx;
   234			/*
   235			 * JIT compiled to a writable location (image/code_base) first.
   236			 * It is then moved to the readonly final location (fimage/fcode_base)
   237			 * using instruction patching.
   238			 */
   239			fimage = jit_data->fimage;
   240			fhdr = jit_data->fhdr;
   241			proglen = jit_data->proglen;
   242			hdr = jit_data->hdr;
   243			image = (void *)hdr + ((void *)fimage - (void *)fhdr);
   244			extra_pass = true;
   245			/* During extra pass, ensure index is reset before repopulating extable entries */
   246			cgctx.exentry_idx = 0;
   247			goto skip_init_ctx;
   248		}
   249	
   250		addrs = kcalloc(flen + 1, sizeof(*addrs), GFP_KERNEL);
   251		if (addrs == NULL) {
   252			fp = org_fp;
   253			goto out_addrs;
   254		}
   255	
   256		memset(&cgctx, 0, sizeof(struct codegen_context));
   257		bpf_jit_init_reg_mapping(&cgctx);
   258	
   259		/* Make sure that the stack is quadword aligned. */
   260		cgctx.stack_size = round_up(fp->aux->stack_depth, 16);
   261		cgctx.arena_vm_start = bpf_arena_get_kern_vm_start(fp->aux->arena);
   262		cgctx.user_vm_start = bpf_arena_get_user_vm_start(fp->aux->arena);
   263		cgctx.is_subprog = bpf_is_subprog(fp);
   264		cgctx.exception_boundary = fp->aux->exception_boundary;
   265		cgctx.exception_cb = fp->aux->exception_cb;
 > 266		cgctx.priv_sp = priv_stack_ptr ? (u64)priv_stack_ptr : 0;
   267	
   268		/* Scouting faux-generate pass 0 */
   269		if (bpf_jit_build_body(fp, NULL, NULL, &cgctx, addrs, 0, false)) {
   270			/* We hit something illegal or unsupported. */
   271			fp = org_fp;
   272			goto out_addrs;
   273		}
   274	
   275		/*
   276		 * If we have seen a tail call, we need a second pass.
   277		 * This is because bpf_jit_emit_common_epilogue() is called
   278		 * from bpf_jit_emit_tail_call() with a not yet stable ctx->seen.
   279		 * We also need a second pass if we ended up with too large
   280		 * a program so as to ensure BPF_EXIT branches are in range.
   281		 */
   282		if (cgctx.seen & SEEN_TAILCALL || !is_offset_in_branch_range((long)cgctx.idx * 4)) {
   283			cgctx.idx = 0;
   284			if (bpf_jit_build_body(fp, NULL, NULL, &cgctx, addrs, 0, false)) {
   285				fp = org_fp;
   286				goto out_addrs;
   287			}
   288		}
   289	
   290		bpf_jit_realloc_regs(&cgctx);
   291		/*
   292		 * Pretend to build prologue, given the features we've seen.  This will
   293		 * update ctgtx.idx as it pretends to output instructions, then we can
   294		 * calculate total size from idx.
   295		 */
   296		bpf_jit_build_prologue(NULL, &cgctx);
   297		addrs[fp->len] = cgctx.idx * 4;
   298		bpf_jit_build_epilogue(NULL, &cgctx);
   299	
   300		fixup_len = fp->aux->num_exentries * BPF_FIXUP_LEN * 4;
   301		extable_len = fp->aux->num_exentries * sizeof(struct exception_table_entry);
   302	
   303		proglen = cgctx.idx * 4;
   304		alloclen = proglen + FUNCTION_DESCR_SIZE + fixup_len + extable_len;
   305	
   306		fhdr = bpf_jit_binary_pack_alloc(alloclen, &fimage, 4, &hdr, &image,
   307						      bpf_jit_fill_ill_insns);
   308		if (!fhdr) {
   309			fp = org_fp;
   310			goto out_addrs;
   311		}
   312	
   313		if (extable_len)
   314			fp->aux->extable = (void *)fimage + FUNCTION_DESCR_SIZE + proglen + fixup_len;
   315	
   316	skip_init_ctx:
   317		code_base = (u32 *)(image + FUNCTION_DESCR_SIZE);
   318		fcode_base = (u32 *)(fimage + FUNCTION_DESCR_SIZE);
   319	
   320		/* Code generation passes 1-2 */
   321		for (pass = 1; pass < 3; pass++) {
   322			/* Now build the prologue, body code & epilogue for real. */
   323			cgctx.idx = 0;
   324			cgctx.alt_exit_addr = 0;
   325			bpf_jit_build_prologue(code_base, &cgctx);
   326			if (bpf_jit_build_body(fp, code_base, fcode_base, &cgctx, addrs, pass,
   327					       extra_pass)) {
   328				bpf_arch_text_copy(&fhdr->size, &hdr->size, sizeof(hdr->size));
   329				bpf_jit_binary_pack_free(fhdr, hdr);
   330				fp = org_fp;
   331				goto out_addrs;
   332			}
   333			bpf_jit_build_epilogue(code_base, &cgctx);
   334	
   335			if (bpf_jit_enable > 1)
   336				pr_info("Pass %d: shrink = %d, seen = 0x%x\n", pass,
   337					proglen - (cgctx.idx * 4), cgctx.seen);
   338		}
   339	
   340		if (bpf_jit_enable > 1)
   341			/*
   342			 * Note that we output the base address of the code_base
   343			 * rather than image, since opcodes are in code_base.
   344			 */
   345			bpf_jit_dump(flen, proglen, pass, code_base);
   346	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
