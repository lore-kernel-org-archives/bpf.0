Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE4173939C9;
	Tue,  2 Jun 2026 18:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780425456; cv=none; b=OYlow3eUkpxmZenKAMUz1w2PH3vUs56FAE67vqvHK9ImrSUxIDwDZxjZFuKGQPRUp4zxXWZoCq2iD335y2NbJyYqtt6F3mUHOUGsr5b/hGGcKGB9KxB4A63tiG4tF265RR5ZspBpiYoyEHtSs+P3aooGnaTpw1GwBpKWotuBW60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780425456; c=relaxed/simple;
	bh=oAq8qM3HQwLOUf0dLtNi91RP45H4gyTYwZIldBfNhv8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hfqi/hLWgxPinj83hPOPj7fQJnw7wnH78qkJh0QKlAIaYYtXGPWfjqQdTjI/BGruCslAipG2o5Jgg50pqqp4yu1pWouq5Xj05YSBfFhM4DqH3NbHRTdLcaz2HjRQ1fzJH1n0M2tpw7j2P7SrFeaGwnITraq5OL4FRwrEGcWJIGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OrfaBZ9b; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OrfaBZ9b"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780425455; x=1811961455;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=oAq8qM3HQwLOUf0dLtNi91RP45H4gyTYwZIldBfNhv8=;
  b=OrfaBZ9bxkytBwiXjeXIQPA8rdcPXff1yR69+7Xyi7mEH+HPxXyM8+Qv
   CIIVIzbwRB1FlFC/64DYShGrSyo7zB8twITeu2O4nr/v49BsrzTojzPsT
   dxoU8kf9sIN7togKmQQ8SLMVux20bqlJIbQLt+Hvnd80v/VHPNrEywNy/
   lwjDRPynoq8qxCLgu1sAt38TwMLQTqGj9AZvWsghsaKDzEAUVFrH0Q1WE
   ZPRAkaUVxo4t0J/E7txmvU41WLsPmT3SczBX/pUJD+hC2uE1EEhUskWqh
   muaY1qb8Jq4/Jnengt8ANE6OUjuHnOafe4WteuUvfmqoXvn+jldzboBCu
   w==;
X-CSE-ConnectionGUID: QT5nMkVXSJ+D6EEOHwajKw==
X-CSE-MsgGUID: l0AwHYkwS/KG1MqlD/IQiQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11805"; a="81403930"
X-IronPort-AV: E=Sophos;i="6.24,183,1774335600"; 
   d="scan'208";a="81403930"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2026 11:37:34 -0700
X-CSE-ConnectionGUID: IJYNmEQWRrGsUIgGlt/QTA==
X-CSE-MsgGUID: 12HATrhzQ2mZSd4uFpyV9w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,183,1774335600"; 
   d="scan'208";a="239540565"
Received: from igk-lkp-server01.igk.intel.com (HELO 892db79562d4) ([10.211.93.152])
  by fmviesa006.fm.intel.com with ESMTP; 02 Jun 2026 11:37:30 -0700
Received: from kbuild by 892db79562d4 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wUTzT-000000001qD-2vNy;
	Tue, 02 Jun 2026 18:37:27 +0000
Date: Tue, 2 Jun 2026 20:37:21 +0200
From: kernel test robot <lkp@intel.com>
To: chenyuan_fl@163.com, eddyz87@gmail.com, yonghong.song@linux.dev
Cc: oe-kbuild-all@lists.linux.dev, andrii@kernel.org, ast@kernel.org,
	bot+bpf-ci@kernel.org, bpf@vger.kernel.org, chenyuan@kylinos.cn,
	chenyuan_fl@163.com, clm@meta.com, daniel@iogearbox.net,
	ihor.solodrai@linux.dev, jolsa@kernel.org,
	linux-kernel@vger.kernel.org, martin.lau@kernel.org,
	martin.lau@linux.dev, memxor@gmail.com, song@kernel.org
Subject: Re: [PATCH bpf v4 2/2] selftests/bpf: Add regression test for kfunc
 implicit arg injection
Message-ID: <202606022025.lDSZsxCa-lkp@intel.com>
References: <20260602093836.2632714-3-chenyuan_fl@163.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260602093836.2632714-3-chenyuan_fl@163.com>

Hi Yuan,

kernel test robot noticed the following build errors:

[auto build test ERROR on bpf/master]

url:    https://github.com/intel-lab-lkp/linux/commits/chenyuan_fl-163-com/bpf-Fix-kfunc-implicit-arg-inject-type-detection-to-prevent-invalid-pointer-deref/20260602-175420
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git master
patch link:    https://lore.kernel.org/r/20260602093836.2632714-3-chenyuan_fl%40163.com
patch subject: [PATCH bpf v4 2/2] selftests/bpf: Add regression test for kfunc implicit arg injection
config: x86_64-rhel-9.4 (https://download.01.org/0day-ci/archive/20260602/202606022025.lDSZsxCa-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260602/202606022025.lDSZsxCa-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202606022025.lDSZsxCa-lkp@intel.com/

All errors (new ones prefixed by >>):

   kernel/bpf/verifier.c: In function 'check_kfunc_args':
>> kernel/bpf/verifier.c:12097:33: error: implicit declaration of function 'reg_arg_name' [-Wimplicit-function-declaration]
   12097 |                                 reg_arg_name(env, argno));
         |                                 ^~~~~~~~~~~~
>> kernel/bpf/verifier.c:12097:51: error: 'argno' undeclared (first use in this function)
   12097 |                                 reg_arg_name(env, argno));
         |                                                   ^~~~~
   kernel/bpf/verifier.c:12097:51: note: each undeclared identifier is reported only once for each function it appears in


vim +/reg_arg_name +12097 kernel/bpf/verifier.c

 12044	
 12045	static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_arg_meta *meta,
 12046				    int insn_idx)
 12047	{
 12048		const char *func_name = meta->func_name, *ref_tname;
 12049		const struct btf *btf = meta->btf;
 12050		const struct btf_param *args;
 12051		struct btf_record *rec;
 12052		u32 i, nargs;
 12053		int ret;
 12054	
 12055		args = (const struct btf_param *)(meta->func_proto + 1);
 12056		nargs = btf_type_vlen(meta->func_proto);
 12057		if (nargs > MAX_BPF_FUNC_REG_ARGS) {
 12058			verbose(env, "Function %s has %d > %d args\n", func_name, nargs,
 12059				MAX_BPF_FUNC_REG_ARGS);
 12060			return -EINVAL;
 12061		}
 12062	
 12063		/* Check that BTF function arguments match actual types that the
 12064		 * verifier sees.
 12065		 */
 12066		for (i = 0; i < nargs; i++) {
 12067			struct bpf_reg_state *regs = cur_regs(env), *reg = &regs[i + 1];
 12068			const struct btf_type *t, *ref_t, *resolve_ret;
 12069			enum bpf_arg_type arg_type = ARG_DONTCARE;
 12070			u32 regno = i + 1, ref_id, type_size;
 12071			bool is_ret_buf_sz = false;
 12072			int kf_arg_type;
 12073	
 12074			if (is_kfunc_arg_prog_aux(btf, &args[i])) {
 12075				/* Reject repeated use bpf_prog_aux */
 12076				if (meta->arg_prog) {
 12077					verifier_bug(env, "Only 1 prog->aux argument supported per-kfunc");
 12078					return -EFAULT;
 12079				}
 12080				meta->arg_prog = true;
 12081				cur_aux(env)->arg_prog = regno;
 12082				continue;
 12083			}
 12084	
 12085			if (is_kfunc_arg_ignore(btf, &args[i]))
 12086				continue;
 12087	
 12088			if (is_kfunc_arg_implicit(meta, i)) {
 12089				/* list_push / rbtree_add kfuncs have implicit args
 12090				 * (e.g. 'off' parameter) handled during verification
 12091				 * in bpf_fixup_kfunc_call().  Don't flag them.
 12092				 */
 12093				if (is_bpf_list_push_kfunc(meta->func_id) ||
 12094				    is_bpf_rbtree_add_kfunc(meta->func_id))
 12095					continue;
 12096				verbose(env, "%s unrecognized implicit argument, possible BTF mismatch\n",
 12097					reg_arg_name(env, argno));
 12098				return -EFAULT;
 12099			}
 12100	
 12101			t = btf_type_skip_modifiers(btf, args[i].type, NULL);
 12102	
 12103			if (btf_type_is_scalar(t)) {
 12104				if (reg->type != SCALAR_VALUE) {
 12105					verbose(env, "R%d is not a scalar\n", regno);
 12106					return -EINVAL;
 12107				}
 12108	
 12109				if (is_kfunc_arg_constant(meta->btf, &args[i])) {
 12110					if (meta->arg_constant.found) {
 12111						verifier_bug(env, "only one constant argument permitted");
 12112						return -EFAULT;
 12113					}
 12114					if (!tnum_is_const(reg->var_off)) {
 12115						verbose(env, "R%d must be a known constant\n", regno);
 12116						return -EINVAL;
 12117					}
 12118					ret = mark_chain_precision(env, regno);
 12119					if (ret < 0)
 12120						return ret;
 12121					meta->arg_constant.found = true;
 12122					meta->arg_constant.value = reg->var_off.value;
 12123				} else if (is_kfunc_arg_scalar_with_name(btf, &args[i], "rdonly_buf_size")) {
 12124					meta->r0_rdonly = true;
 12125					is_ret_buf_sz = true;
 12126				} else if (is_kfunc_arg_scalar_with_name(btf, &args[i], "rdwr_buf_size")) {
 12127					is_ret_buf_sz = true;
 12128				}
 12129	
 12130				if (is_ret_buf_sz) {
 12131					if (meta->r0_size) {
 12132						verbose(env, "2 or more rdonly/rdwr_buf_size parameters for kfunc");
 12133						return -EINVAL;
 12134					}
 12135	
 12136					if (!tnum_is_const(reg->var_off)) {
 12137						verbose(env, "R%d is not a const\n", regno);
 12138						return -EINVAL;
 12139					}
 12140	
 12141					meta->r0_size = reg->var_off.value;
 12142					ret = mark_chain_precision(env, regno);
 12143					if (ret)
 12144						return ret;
 12145				}
 12146				continue;
 12147			}
 12148	
 12149			if (!btf_type_is_ptr(t)) {
 12150				verbose(env, "Unrecognized arg#%d type %s\n", i, btf_type_str(t));
 12151				return -EINVAL;
 12152			}
 12153	
 12154			if ((bpf_register_is_null(reg) || type_may_be_null(reg->type)) &&
 12155			    !is_kfunc_arg_nullable(meta->btf, &args[i])) {
 12156				verbose(env, "Possibly NULL pointer passed to trusted arg%d\n", i);
 12157				return -EACCES;
 12158			}
 12159	
 12160			if (reg->ref_obj_id) {
 12161				if (is_kfunc_release(meta) && meta->ref_obj_id) {
 12162					verifier_bug(env, "more than one arg with ref_obj_id R%d %u %u",
 12163						     regno, reg->ref_obj_id,
 12164						     meta->ref_obj_id);
 12165					return -EFAULT;
 12166				}
 12167				meta->ref_obj_id = reg->ref_obj_id;
 12168				if (is_kfunc_release(meta))
 12169					meta->release_regno = regno;
 12170			}
 12171	
 12172			ref_t = btf_type_skip_modifiers(btf, t->type, &ref_id);
 12173			ref_tname = btf_name_by_offset(btf, ref_t->name_off);
 12174	
 12175			kf_arg_type = get_kfunc_ptr_arg_type(env, meta, t, ref_t, ref_tname, args, i, nargs);
 12176			if (kf_arg_type < 0)
 12177				return kf_arg_type;
 12178	
 12179			switch (kf_arg_type) {
 12180			case KF_ARG_PTR_TO_NULL:
 12181				continue;
 12182			case KF_ARG_PTR_TO_MAP:
 12183				if (!reg->map_ptr) {
 12184					verbose(env, "pointer in R%d isn't map pointer\n", regno);
 12185					return -EINVAL;
 12186				}
 12187				if (meta->map.ptr && (reg->map_ptr->record->wq_off >= 0 ||
 12188						      reg->map_ptr->record->task_work_off >= 0)) {
 12189					/* Use map_uid (which is unique id of inner map) to reject:
 12190					 * inner_map1 = bpf_map_lookup_elem(outer_map, key1)
 12191					 * inner_map2 = bpf_map_lookup_elem(outer_map, key2)
 12192					 * if (inner_map1 && inner_map2) {
 12193					 *     wq = bpf_map_lookup_elem(inner_map1);
 12194					 *     if (wq)
 12195					 *         // mismatch would have been allowed
 12196					 *         bpf_wq_init(wq, inner_map2);
 12197					 * }
 12198					 *
 12199					 * Comparing map_ptr is enough to distinguish normal and outer maps.
 12200					 */
 12201					if (meta->map.ptr != reg->map_ptr ||
 12202					    meta->map.uid != reg->map_uid) {
 12203						if (reg->map_ptr->record->task_work_off >= 0) {
 12204							verbose(env,
 12205								"bpf_task_work pointer in R2 map_uid=%d doesn't match map pointer in R3 map_uid=%d\n",
 12206								meta->map.uid, reg->map_uid);
 12207							return -EINVAL;
 12208						}
 12209						verbose(env,
 12210							"workqueue pointer in R1 map_uid=%d doesn't match map pointer in R2 map_uid=%d\n",
 12211							meta->map.uid, reg->map_uid);
 12212						return -EINVAL;
 12213					}
 12214				}
 12215				meta->map.ptr = reg->map_ptr;
 12216				meta->map.uid = reg->map_uid;
 12217				fallthrough;
 12218			case KF_ARG_PTR_TO_ALLOC_BTF_ID:
 12219			case KF_ARG_PTR_TO_BTF_ID:
 12220				if (!is_trusted_reg(reg)) {
 12221					if (!is_kfunc_rcu(meta)) {
 12222						verbose(env, "R%d must be referenced or trusted\n", regno);
 12223						return -EINVAL;
 12224					}
 12225					if (!is_rcu_reg(reg)) {
 12226						verbose(env, "R%d must be a rcu pointer\n", regno);
 12227						return -EINVAL;
 12228					}
 12229				}
 12230				fallthrough;
 12231			case KF_ARG_PTR_TO_DYNPTR:
 12232			case KF_ARG_PTR_TO_ITER:
 12233			case KF_ARG_PTR_TO_LIST_HEAD:
 12234			case KF_ARG_PTR_TO_LIST_NODE:
 12235			case KF_ARG_PTR_TO_RB_ROOT:
 12236			case KF_ARG_PTR_TO_RB_NODE:
 12237			case KF_ARG_PTR_TO_MEM:
 12238			case KF_ARG_PTR_TO_MEM_SIZE:
 12239			case KF_ARG_PTR_TO_CALLBACK:
 12240			case KF_ARG_PTR_TO_REFCOUNTED_KPTR:
 12241			case KF_ARG_PTR_TO_CONST_STR:
 12242			case KF_ARG_PTR_TO_WORKQUEUE:
 12243			case KF_ARG_PTR_TO_TIMER:
 12244			case KF_ARG_PTR_TO_TASK_WORK:
 12245			case KF_ARG_PTR_TO_IRQ_FLAG:
 12246			case KF_ARG_PTR_TO_RES_SPIN_LOCK:
 12247				break;
 12248			case KF_ARG_PTR_TO_CTX:
 12249				arg_type = ARG_PTR_TO_CTX;
 12250				break;
 12251			default:
 12252				verifier_bug(env, "unknown kfunc arg type %d", kf_arg_type);
 12253				return -EFAULT;
 12254			}
 12255	
 12256			if (is_kfunc_release(meta) && reg->ref_obj_id)
 12257				arg_type |= OBJ_RELEASE;
 12258			ret = check_func_arg_reg_off(env, reg, regno, arg_type);
 12259			if (ret < 0)
 12260				return ret;
 12261	
 12262			switch (kf_arg_type) {
 12263			case KF_ARG_PTR_TO_CTX:
 12264				if (reg->type != PTR_TO_CTX) {
 12265					verbose(env, "arg#%d expected pointer to ctx, but got %s\n",
 12266						i, reg_type_str(env, reg->type));
 12267					return -EINVAL;
 12268				}
 12269	
 12270				if (meta->func_id == special_kfunc_list[KF_bpf_cast_to_kern_ctx]) {
 12271					ret = get_kern_ctx_btf_id(&env->log, resolve_prog_type(env->prog));
 12272					if (ret < 0)
 12273						return -EINVAL;
 12274					meta->ret_btf_id  = ret;
 12275				}
 12276				break;
 12277			case KF_ARG_PTR_TO_ALLOC_BTF_ID:
 12278				if (reg->type == (PTR_TO_BTF_ID | MEM_ALLOC)) {
 12279					if (!is_bpf_obj_drop_kfunc(meta->func_id)) {
 12280						verbose(env, "arg#%d expected for bpf_obj_drop()\n", i);
 12281						return -EINVAL;
 12282					}
 12283				} else if (reg->type == (PTR_TO_BTF_ID | MEM_ALLOC | MEM_PERCPU)) {
 12284					if (!is_bpf_percpu_obj_drop_kfunc(meta->func_id)) {
 12285						verbose(env, "arg#%d expected for bpf_percpu_obj_drop()\n", i);
 12286						return -EINVAL;
 12287					}
 12288				} else {
 12289					verbose(env, "arg#%d expected pointer to allocated object\n", i);
 12290					return -EINVAL;
 12291				}
 12292				if (!reg->ref_obj_id) {
 12293					verbose(env, "allocated object must be referenced\n");
 12294					return -EINVAL;
 12295				}
 12296				if (meta->btf == btf_vmlinux) {
 12297					meta->arg_btf = reg->btf;
 12298					meta->arg_btf_id = reg->btf_id;
 12299				}
 12300				break;
 12301			case KF_ARG_PTR_TO_DYNPTR:
 12302			{
 12303				enum bpf_arg_type dynptr_arg_type = ARG_PTR_TO_DYNPTR;
 12304				int clone_ref_obj_id = 0;
 12305	
 12306				if (reg->type == CONST_PTR_TO_DYNPTR)
 12307					dynptr_arg_type |= MEM_RDONLY;
 12308	
 12309				if (is_kfunc_arg_uninit(btf, &args[i]))
 12310					dynptr_arg_type |= MEM_UNINIT;
 12311	
 12312				if (meta->func_id == special_kfunc_list[KF_bpf_dynptr_from_skb]) {
 12313					dynptr_arg_type |= DYNPTR_TYPE_SKB;
 12314				} else if (meta->func_id == special_kfunc_list[KF_bpf_dynptr_from_xdp]) {
 12315					dynptr_arg_type |= DYNPTR_TYPE_XDP;
 12316				} else if (meta->func_id == special_kfunc_list[KF_bpf_dynptr_from_skb_meta]) {
 12317					dynptr_arg_type |= DYNPTR_TYPE_SKB_META;
 12318				} else if (meta->func_id == special_kfunc_list[KF_bpf_dynptr_from_file]) {
 12319					dynptr_arg_type |= DYNPTR_TYPE_FILE;
 12320				} else if (meta->func_id == special_kfunc_list[KF_bpf_dynptr_file_discard]) {
 12321					dynptr_arg_type |= DYNPTR_TYPE_FILE;
 12322					meta->release_regno = regno;
 12323				} else if (meta->func_id == special_kfunc_list[KF_bpf_dynptr_clone] &&
 12324					   (dynptr_arg_type & MEM_UNINIT)) {
 12325					enum bpf_dynptr_type parent_type = meta->initialized_dynptr.type;
 12326	
 12327					if (parent_type == BPF_DYNPTR_TYPE_INVALID) {
 12328						verifier_bug(env, "no dynptr type for parent of clone");
 12329						return -EFAULT;
 12330					}
 12331	
 12332					dynptr_arg_type |= (unsigned int)get_dynptr_type_flag(parent_type);
 12333					clone_ref_obj_id = meta->initialized_dynptr.ref_obj_id;
 12334					if (dynptr_type_refcounted(parent_type) && !clone_ref_obj_id) {
 12335						verifier_bug(env, "missing ref obj id for parent of clone");
 12336						return -EFAULT;
 12337					}
 12338				}
 12339	
 12340				ret = process_dynptr_func(env, regno, insn_idx, dynptr_arg_type, clone_ref_obj_id);
 12341				if (ret < 0)
 12342					return ret;
 12343	
 12344				if (!(dynptr_arg_type & MEM_UNINIT)) {
 12345					int id = dynptr_id(env, reg);
 12346	
 12347					if (id < 0) {
 12348						verifier_bug(env, "failed to obtain dynptr id");
 12349						return id;
 12350					}
 12351					meta->initialized_dynptr.id = id;
 12352					meta->initialized_dynptr.type = dynptr_get_type(env, reg);
 12353					meta->initialized_dynptr.ref_obj_id = dynptr_ref_obj_id(env, reg);
 12354				}
 12355	
 12356				break;
 12357			}
 12358			case KF_ARG_PTR_TO_ITER:
 12359				if (meta->func_id == special_kfunc_list[KF_bpf_iter_css_task_new]) {
 12360					if (!check_css_task_iter_allowlist(env)) {
 12361						verbose(env, "css_task_iter is only allowed in bpf_lsm, bpf_iter and sleepable progs\n");
 12362						return -EINVAL;
 12363					}
 12364				}
 12365				ret = process_iter_arg(env, regno, insn_idx, meta);
 12366				if (ret < 0)
 12367					return ret;
 12368				break;
 12369			case KF_ARG_PTR_TO_LIST_HEAD:
 12370				if (reg->type != PTR_TO_MAP_VALUE &&
 12371				    reg->type != (PTR_TO_BTF_ID | MEM_ALLOC)) {
 12372					verbose(env, "arg#%d expected pointer to map value or allocated object\n", i);
 12373					return -EINVAL;
 12374				}
 12375				if (reg->type == (PTR_TO_BTF_ID | MEM_ALLOC) && !reg->ref_obj_id) {
 12376					verbose(env, "allocated object must be referenced\n");
 12377					return -EINVAL;
 12378				}
 12379				ret = process_kf_arg_ptr_to_list_head(env, reg, regno, meta);
 12380				if (ret < 0)
 12381					return ret;
 12382				break;
 12383			case KF_ARG_PTR_TO_RB_ROOT:
 12384				if (reg->type != PTR_TO_MAP_VALUE &&
 12385				    reg->type != (PTR_TO_BTF_ID | MEM_ALLOC)) {
 12386					verbose(env, "arg#%d expected pointer to map value or allocated object\n", i);
 12387					return -EINVAL;
 12388				}
 12389				if (reg->type == (PTR_TO_BTF_ID | MEM_ALLOC) && !reg->ref_obj_id) {
 12390					verbose(env, "allocated object must be referenced\n");
 12391					return -EINVAL;
 12392				}
 12393				ret = process_kf_arg_ptr_to_rbtree_root(env, reg, regno, meta);
 12394				if (ret < 0)
 12395					return ret;
 12396				break;
 12397			case KF_ARG_PTR_TO_LIST_NODE:
 12398				if (reg->type != (PTR_TO_BTF_ID | MEM_ALLOC)) {
 12399					verbose(env, "arg#%d expected pointer to allocated object\n", i);
 12400					return -EINVAL;
 12401				}
 12402				if (!reg->ref_obj_id) {
 12403					verbose(env, "allocated object must be referenced\n");
 12404					return -EINVAL;
 12405				}
 12406				ret = process_kf_arg_ptr_to_list_node(env, reg, regno, meta);
 12407				if (ret < 0)
 12408					return ret;
 12409				break;
 12410			case KF_ARG_PTR_TO_RB_NODE:
 12411				if (is_bpf_rbtree_add_kfunc(meta->func_id)) {
 12412					if (reg->type != (PTR_TO_BTF_ID | MEM_ALLOC)) {
 12413						verbose(env, "arg#%d expected pointer to allocated object\n", i);
 12414						return -EINVAL;
 12415					}
 12416					if (!reg->ref_obj_id) {
 12417						verbose(env, "allocated object must be referenced\n");
 12418						return -EINVAL;
 12419					}
 12420				} else {
 12421					if (!type_is_non_owning_ref(reg->type) && !reg->ref_obj_id) {
 12422						verbose(env, "%s can only take non-owning or refcounted bpf_rb_node pointer\n", func_name);
 12423						return -EINVAL;
 12424					}
 12425					if (in_rbtree_lock_required_cb(env)) {
 12426						verbose(env, "%s not allowed in rbtree cb\n", func_name);
 12427						return -EINVAL;
 12428					}
 12429				}
 12430	
 12431				ret = process_kf_arg_ptr_to_rbtree_node(env, reg, regno, meta);
 12432				if (ret < 0)
 12433					return ret;
 12434				break;
 12435			case KF_ARG_PTR_TO_MAP:
 12436				/* If argument has '__map' suffix expect 'struct bpf_map *' */
 12437				ref_id = *reg2btf_ids[CONST_PTR_TO_MAP];
 12438				ref_t = btf_type_by_id(btf_vmlinux, ref_id);
 12439				ref_tname = btf_name_by_offset(btf, ref_t->name_off);
 12440				fallthrough;
 12441			case KF_ARG_PTR_TO_BTF_ID:
 12442				/* Only base_type is checked, further checks are done here */
 12443				if ((base_type(reg->type) != PTR_TO_BTF_ID ||
 12444				     (bpf_type_has_unsafe_modifiers(reg->type) && !is_rcu_reg(reg))) &&
 12445				    !reg2btf_ids[base_type(reg->type)]) {
 12446					verbose(env, "arg#%d is %s ", i, reg_type_str(env, reg->type));
 12447					verbose(env, "expected %s or socket\n",
 12448						reg_type_str(env, base_type(reg->type) |
 12449								  (type_flag(reg->type) & BPF_REG_TRUSTED_MODIFIERS)));
 12450					return -EINVAL;
 12451				}
 12452				ret = process_kf_arg_ptr_to_btf_id(env, reg, ref_t, ref_tname, ref_id, meta, i);
 12453				if (ret < 0)
 12454					return ret;
 12455				break;
 12456			case KF_ARG_PTR_TO_MEM:
 12457				resolve_ret = btf_resolve_size(btf, ref_t, &type_size);
 12458				if (IS_ERR(resolve_ret)) {
 12459					verbose(env, "arg#%d reference type('%s %s') size cannot be determined: %ld\n",
 12460						i, btf_type_str(ref_t), ref_tname, PTR_ERR(resolve_ret));
 12461					return -EINVAL;
 12462				}
 12463				ret = check_mem_reg(env, reg, regno, type_size);
 12464				if (ret < 0)
 12465					return ret;
 12466				break;
 12467			case KF_ARG_PTR_TO_MEM_SIZE:
 12468			{
 12469				struct bpf_reg_state *buff_reg = &regs[regno];
 12470				const struct btf_param *buff_arg = &args[i];
 12471				struct bpf_reg_state *size_reg = &regs[regno + 1];
 12472				const struct btf_param *size_arg = &args[i + 1];
 12473	
 12474				if (!bpf_register_is_null(buff_reg) || !is_kfunc_arg_nullable(meta->btf, buff_arg)) {
 12475					ret = check_kfunc_mem_size_reg(env, size_reg, regno + 1);
 12476					if (ret < 0) {
 12477						verbose(env, "arg#%d arg#%d memory, len pair leads to invalid memory access\n", i, i + 1);
 12478						return ret;
 12479					}
 12480				}
 12481	
 12482				if (is_kfunc_arg_const_mem_size(meta->btf, size_arg, size_reg)) {
 12483					if (meta->arg_constant.found) {
 12484						verifier_bug(env, "only one constant argument permitted");
 12485						return -EFAULT;
 12486					}
 12487					if (!tnum_is_const(size_reg->var_off)) {
 12488						verbose(env, "R%d must be a known constant\n", regno + 1);
 12489						return -EINVAL;
 12490					}
 12491					meta->arg_constant.found = true;
 12492					meta->arg_constant.value = size_reg->var_off.value;
 12493				}
 12494	
 12495				/* Skip next '__sz' or '__szk' argument */
 12496				i++;
 12497				break;
 12498			}
 12499			case KF_ARG_PTR_TO_CALLBACK:
 12500				if (reg->type != PTR_TO_FUNC) {
 12501					verbose(env, "arg%d expected pointer to func\n", i);
 12502					return -EINVAL;
 12503				}
 12504				meta->subprogno = reg->subprogno;
 12505				break;
 12506			case KF_ARG_PTR_TO_REFCOUNTED_KPTR:
 12507				if (!type_is_ptr_alloc_obj(reg->type)) {
 12508					verbose(env, "arg#%d is neither owning or non-owning ref\n", i);
 12509					return -EINVAL;
 12510				}
 12511				if (!type_is_non_owning_ref(reg->type))
 12512					meta->arg_owning_ref = true;
 12513	
 12514				rec = reg_btf_record(reg);
 12515				if (!rec) {
 12516					verifier_bug(env, "Couldn't find btf_record");
 12517					return -EFAULT;
 12518				}
 12519	
 12520				if (rec->refcount_off < 0) {
 12521					verbose(env, "arg#%d doesn't point to a type with bpf_refcount field\n", i);
 12522					return -EINVAL;
 12523				}
 12524	
 12525				meta->arg_btf = reg->btf;
 12526				meta->arg_btf_id = reg->btf_id;
 12527				break;
 12528			case KF_ARG_PTR_TO_CONST_STR:
 12529				if (reg->type != PTR_TO_MAP_VALUE) {
 12530					verbose(env, "arg#%d doesn't point to a const string\n", i);
 12531					return -EINVAL;
 12532				}
 12533				ret = check_reg_const_str(env, reg, regno);
 12534				if (ret)
 12535					return ret;
 12536				break;
 12537			case KF_ARG_PTR_TO_WORKQUEUE:
 12538				if (reg->type != PTR_TO_MAP_VALUE) {
 12539					verbose(env, "arg#%d doesn't point to a map value\n", i);
 12540					return -EINVAL;
 12541				}
 12542				ret = check_map_field_pointer(env, regno, BPF_WORKQUEUE, &meta->map);
 12543				if (ret < 0)
 12544					return ret;
 12545				break;
 12546			case KF_ARG_PTR_TO_TIMER:
 12547				if (reg->type != PTR_TO_MAP_VALUE) {
 12548					verbose(env, "arg#%d doesn't point to a map value\n", i);
 12549					return -EINVAL;
 12550				}
 12551				ret = process_timer_kfunc(env, regno, meta);
 12552				if (ret < 0)
 12553					return ret;
 12554				break;
 12555			case KF_ARG_PTR_TO_TASK_WORK:
 12556				if (reg->type != PTR_TO_MAP_VALUE) {
 12557					verbose(env, "arg#%d doesn't point to a map value\n", i);
 12558					return -EINVAL;
 12559				}
 12560				ret = check_map_field_pointer(env, regno, BPF_TASK_WORK, &meta->map);
 12561				if (ret < 0)
 12562					return ret;
 12563				break;
 12564			case KF_ARG_PTR_TO_IRQ_FLAG:
 12565				if (reg->type != PTR_TO_STACK) {
 12566					verbose(env, "arg#%d doesn't point to an irq flag on stack\n", i);
 12567					return -EINVAL;
 12568				}
 12569				ret = process_irq_flag(env, regno, meta);
 12570				if (ret < 0)
 12571					return ret;
 12572				break;
 12573			case KF_ARG_PTR_TO_RES_SPIN_LOCK:
 12574			{
 12575				int flags = PROCESS_RES_LOCK;
 12576	
 12577				if (reg->type != PTR_TO_MAP_VALUE && reg->type != (PTR_TO_BTF_ID | MEM_ALLOC)) {
 12578					verbose(env, "arg#%d doesn't point to map value or allocated object\n", i);
 12579					return -EINVAL;
 12580				}
 12581	
 12582				if (!is_bpf_res_spin_lock_kfunc(meta->func_id))
 12583					return -EFAULT;
 12584				if (meta->func_id == special_kfunc_list[KF_bpf_res_spin_lock] ||
 12585				    meta->func_id == special_kfunc_list[KF_bpf_res_spin_lock_irqsave])
 12586					flags |= PROCESS_SPIN_LOCK;
 12587				if (meta->func_id == special_kfunc_list[KF_bpf_res_spin_lock_irqsave] ||
 12588				    meta->func_id == special_kfunc_list[KF_bpf_res_spin_unlock_irqrestore])
 12589					flags |= PROCESS_LOCK_IRQ;
 12590				ret = process_spin_lock(env, regno, flags);
 12591				if (ret < 0)
 12592					return ret;
 12593				break;
 12594			}
 12595			}
 12596		}
 12597	
 12598		if (is_kfunc_release(meta) && !meta->release_regno) {
 12599			verbose(env, "release kernel function %s expects refcounted PTR_TO_BTF_ID\n",
 12600				func_name);
 12601			return -EINVAL;
 12602		}
 12603	
 12604		return 0;
 12605	}
 12606	

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
