Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1D82202F71;
	Thu, 19 Mar 2026 16:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773938337; cv=none; b=toLkHXHZCYMh9RVtwmZZAgAhX3j6JjyyJx88/T4zU4qucuA3CDb82DBhnxqubd08wvNTdjJ7kGl0LrF76tcqO6g0Jcl+mt7XA4yR7QIaw606KkHI1k8SSj3nkFKKNKEo955+MDEs47aaAsBNc9sz94oJWZHOTPHsN1vCn/kp0lQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773938337; c=relaxed/simple;
	bh=6N9VI8OlJe86dOZ53wIy6bu/hPqupS0IXeW6m1qQ6KA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p3j/X1MG98cWtZY9AL1zIW7taYu5LLc/zIVwsBRKHIYWMTyKLGLD/d15W4Q/ARCpyzDvuThKoa7LwTMgGHHvtlt1Yg/0YiQSHwxM6HVBvOGkiBCHTREmDPto76yWPwViw6fgwh3ocbpq97iV3Nly1EhwHOmQO8D2CsccVlFSF8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Voxj7htg; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Voxj7htg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773938329; x=1805474329;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6N9VI8OlJe86dOZ53wIy6bu/hPqupS0IXeW6m1qQ6KA=;
  b=Voxj7htg0FmQ/D0cViZ1Ri+jalSa5dAYTTE9u8SzwtHovolmblODQfpp
   bIniAI53rc37OI9aohuVCEUZpHfv/xdC6mB0e+IySZtNbmVbNW/55Y7c9
   pRvsOEqFeEANFvE5d1y++CKwEVFGsLtcRu0TuqTyR2RlKztT4AvPOMiPd
   i+g3QRC+VBwYjgTKcmR78BBmQXupJInQmWkP2kGmYpjo7Dq/SCNPK68wN
   vRXPZ0ZG7RXqnnsIpDaUHmYSAMBIUlyEt/reQ+mQp7zCULdHag4EGXnSg
   znI6sw88+nrpQPQgWEXO6ofJePtmEac5EaQpCvsdAemELdn40kt0uWu6i
   Q==;
X-CSE-ConnectionGUID: UvypNZbDRf6QDwKSAzZ8ag==
X-CSE-MsgGUID: m75C3b33SVS7uohGG8LaWg==
X-IronPort-AV: E=McAfee;i="6800,10657,11734"; a="75135220"
X-IronPort-AV: E=Sophos;i="6.23,129,1770624000"; 
   d="scan'208";a="75135220"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2026 09:38:48 -0700
X-CSE-ConnectionGUID: 2SHgaA5/TMinMFLmiGwUXg==
X-CSE-MsgGUID: C/BN4k2GQte/l8zVGwipfg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,129,1770624000"; 
   d="scan'208";a="223040640"
Received: from lkp-server02.sh.intel.com (HELO a51c2a36b9df) ([10.239.97.151])
  by orviesa008.jf.intel.com with ESMTP; 19 Mar 2026 09:38:44 -0700
Received: from kbuild by a51c2a36b9df with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1w3GOP-000000001Kb-16OB;
	Thu, 19 Mar 2026 16:38:41 +0000
Date: Fri, 20 Mar 2026 00:31:02 +0800
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
Subject: Re: [PATCHv3 bpf-next 06/24] bpf: Add multi tracing attach types
Message-ID: <202603200034.0g8Ml43R-lkp@intel.com>
References: <20260316075138.465430-7-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260316075138.465430-7-jolsa@kernel.org>

Hi Jiri,

kernel test robot noticed the following build errors:

[auto build test ERROR on bpf-next/master]

url:    https://github.com/intel-lab-lkp/linux/commits/Jiri-Olsa/ftrace-Add-ftrace_hash_count-function/20260316-160117
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
patch link:    https://lore.kernel.org/r/20260316075138.465430-7-jolsa%40kernel.org
patch subject: [PATCHv3 bpf-next 06/24] bpf: Add multi tracing attach types
config: sh-allmodconfig (https://download.01.org/0day-ci/archive/20260320/202603200034.0g8Ml43R-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 15.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260320/202603200034.0g8Ml43R-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603200034.0g8Ml43R-lkp@intel.com/

All errors (new ones prefixed by >>):

   kernel/bpf/syscall.c: In function 'bpf_prog_load':
>> kernel/bpf/syscall.c:2967:22: error: implicit declaration of function 'is_tracing_multi' [-Wimplicit-function-declaration]
    2967 |         multi_func = is_tracing_multi(attr->expected_attach_type);
         |                      ^~~~~~~~~~~~~~~~
--
   kernel/bpf/verifier.c: In function 'is_tracing_multi_id':
>> kernel/bpf/verifier.c:25059:16: error: implicit declaration of function 'is_tracing_multi'; did you mean 'is_tracing_multi_id'? [-Wimplicit-function-declaration]
   25059 |         return is_tracing_multi(prog->expected_attach_type) && bpf_multi_func_btf_id[0] == btf_id;
         |                ^~~~~~~~~~~~~~~~
         |                is_tracing_multi_id


vim +/is_tracing_multi +2967 kernel/bpf/syscall.c

  2890	
  2891	static int bpf_prog_load(union bpf_attr *attr, bpfptr_t uattr, u32 uattr_size)
  2892	{
  2893		enum bpf_prog_type type = attr->prog_type;
  2894		struct bpf_prog *prog, *dst_prog = NULL;
  2895		struct btf *attach_btf = NULL;
  2896		struct bpf_token *token = NULL;
  2897		bool bpf_cap;
  2898		int err;
  2899		char license[128];
  2900		bool multi_func;
  2901	
  2902		if (CHECK_ATTR(BPF_PROG_LOAD))
  2903			return -EINVAL;
  2904	
  2905		if (attr->prog_flags & ~(BPF_F_STRICT_ALIGNMENT |
  2906					 BPF_F_ANY_ALIGNMENT |
  2907					 BPF_F_TEST_STATE_FREQ |
  2908					 BPF_F_SLEEPABLE |
  2909					 BPF_F_TEST_RND_HI32 |
  2910					 BPF_F_XDP_HAS_FRAGS |
  2911					 BPF_F_XDP_DEV_BOUND_ONLY |
  2912					 BPF_F_TEST_REG_INVARIANTS |
  2913					 BPF_F_TOKEN_FD))
  2914			return -EINVAL;
  2915	
  2916		bpf_prog_load_fixup_attach_type(attr);
  2917	
  2918		if (attr->prog_flags & BPF_F_TOKEN_FD) {
  2919			token = bpf_token_get_from_fd(attr->prog_token_fd);
  2920			if (IS_ERR(token))
  2921				return PTR_ERR(token);
  2922			/* if current token doesn't grant prog loading permissions,
  2923			 * then we can't use this token, so ignore it and rely on
  2924			 * system-wide capabilities checks
  2925			 */
  2926			if (!bpf_token_allow_cmd(token, BPF_PROG_LOAD) ||
  2927			    !bpf_token_allow_prog_type(token, attr->prog_type,
  2928						       attr->expected_attach_type)) {
  2929				bpf_token_put(token);
  2930				token = NULL;
  2931			}
  2932		}
  2933	
  2934		bpf_cap = bpf_token_capable(token, CAP_BPF);
  2935		err = -EPERM;
  2936	
  2937		if (!IS_ENABLED(CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS) &&
  2938		    (attr->prog_flags & BPF_F_ANY_ALIGNMENT) &&
  2939		    !bpf_cap)
  2940			goto put_token;
  2941	
  2942		/* Intent here is for unprivileged_bpf_disabled to block BPF program
  2943		 * creation for unprivileged users; other actions depend
  2944		 * on fd availability and access to bpffs, so are dependent on
  2945		 * object creation success. Even with unprivileged BPF disabled,
  2946		 * capability checks are still carried out for these
  2947		 * and other operations.
  2948		 */
  2949		if (sysctl_unprivileged_bpf_disabled && !bpf_cap)
  2950			goto put_token;
  2951	
  2952		if (attr->insn_cnt == 0 ||
  2953		    attr->insn_cnt > (bpf_cap ? BPF_COMPLEXITY_LIMIT_INSNS : BPF_MAXINSNS)) {
  2954			err = -E2BIG;
  2955			goto put_token;
  2956		}
  2957		if (type != BPF_PROG_TYPE_SOCKET_FILTER &&
  2958		    type != BPF_PROG_TYPE_CGROUP_SKB &&
  2959		    !bpf_cap)
  2960			goto put_token;
  2961	
  2962		if (is_net_admin_prog_type(type) && !bpf_token_capable(token, CAP_NET_ADMIN))
  2963			goto put_token;
  2964		if (is_perfmon_prog_type(type) && !bpf_token_capable(token, CAP_PERFMON))
  2965			goto put_token;
  2966	
> 2967		multi_func = is_tracing_multi(attr->expected_attach_type);
  2968	
  2969		/* attach_prog_fd/attach_btf_obj_fd can specify fd of either bpf_prog
  2970		 * or btf, we need to check which one it is
  2971		 */
  2972		if (attr->attach_prog_fd) {
  2973			dst_prog = bpf_prog_get(attr->attach_prog_fd);
  2974			if (IS_ERR(dst_prog)) {
  2975				dst_prog = NULL;
  2976				attach_btf = btf_get_by_fd(attr->attach_btf_obj_fd);
  2977				if (IS_ERR(attach_btf)) {
  2978					err = -EINVAL;
  2979					goto put_token;
  2980				}
  2981				if (!btf_is_kernel(attach_btf)) {
  2982					/* attaching through specifying bpf_prog's BTF
  2983					 * objects directly might be supported eventually
  2984					 */
  2985					btf_put(attach_btf);
  2986					err = -ENOTSUPP;
  2987					goto put_token;
  2988				}
  2989			}
  2990		} else if (attr->attach_btf_id || multi_func) {
  2991			/* fall back to vmlinux BTF, if BTF type ID is specified */
  2992			attach_btf = bpf_get_btf_vmlinux();
  2993			if (IS_ERR(attach_btf)) {
  2994				err = PTR_ERR(attach_btf);
  2995				goto put_token;
  2996			}
  2997			if (!attach_btf) {
  2998				err = -EINVAL;
  2999				goto put_token;
  3000			}
  3001			btf_get(attach_btf);
  3002		}
  3003	
  3004		if (bpf_prog_load_check_attach(type, attr->expected_attach_type,
  3005					       attach_btf, attr->attach_btf_id,
  3006					       dst_prog, multi_func)) {
  3007			if (dst_prog)
  3008				bpf_prog_put(dst_prog);
  3009			if (attach_btf)
  3010				btf_put(attach_btf);
  3011			err = -EINVAL;
  3012			goto put_token;
  3013		}
  3014	
  3015		/* plain bpf_prog allocation */
  3016		prog = bpf_prog_alloc(bpf_prog_size(attr->insn_cnt), GFP_USER);
  3017		if (!prog) {
  3018			if (dst_prog)
  3019				bpf_prog_put(dst_prog);
  3020			if (attach_btf)
  3021				btf_put(attach_btf);
  3022			err = -EINVAL;
  3023			goto put_token;
  3024		}
  3025	
  3026		prog->expected_attach_type = attr->expected_attach_type;
  3027		prog->sleepable = !!(attr->prog_flags & BPF_F_SLEEPABLE);
  3028		prog->aux->attach_btf = attach_btf;
  3029		prog->aux->attach_btf_id = multi_func ? bpf_multi_func_btf_id[0] : attr->attach_btf_id;
  3030		prog->aux->dst_prog = dst_prog;
  3031		prog->aux->dev_bound = !!attr->prog_ifindex;
  3032		prog->aux->xdp_has_frags = attr->prog_flags & BPF_F_XDP_HAS_FRAGS;
  3033	
  3034		/* move token into prog->aux, reuse taken refcnt */
  3035		prog->aux->token = token;
  3036		token = NULL;
  3037	
  3038		prog->aux->user = get_current_user();
  3039		prog->len = attr->insn_cnt;
  3040	
  3041		err = -EFAULT;
  3042		if (copy_from_bpfptr(prog->insns,
  3043				     make_bpfptr(attr->insns, uattr.is_kernel),
  3044				     bpf_prog_insn_size(prog)) != 0)
  3045			goto free_prog;
  3046		/* copy eBPF program license from user space */
  3047		if (strncpy_from_bpfptr(license,
  3048					make_bpfptr(attr->license, uattr.is_kernel),
  3049					sizeof(license) - 1) < 0)
  3050			goto free_prog;
  3051		license[sizeof(license) - 1] = 0;
  3052	
  3053		/* eBPF programs must be GPL compatible to use GPL-ed functions */
  3054		prog->gpl_compatible = license_is_gpl_compatible(license) ? 1 : 0;
  3055	
  3056		if (attr->signature) {
  3057			err = bpf_prog_verify_signature(prog, attr, uattr.is_kernel);
  3058			if (err)
  3059				goto free_prog;
  3060		}
  3061	
  3062		prog->orig_prog = NULL;
  3063		prog->jited = 0;
  3064	
  3065		atomic64_set(&prog->aux->refcnt, 1);
  3066	
  3067		if (bpf_prog_is_dev_bound(prog->aux)) {
  3068			err = bpf_prog_dev_bound_init(prog, attr);
  3069			if (err)
  3070				goto free_prog;
  3071		}
  3072	
  3073		if (type == BPF_PROG_TYPE_EXT && dst_prog &&
  3074		    bpf_prog_is_dev_bound(dst_prog->aux)) {
  3075			err = bpf_prog_dev_bound_inherit(prog, dst_prog);
  3076			if (err)
  3077				goto free_prog;
  3078		}
  3079	
  3080		/*
  3081		 * Bookkeeping for managing the program attachment chain.
  3082		 *
  3083		 * It might be tempting to set attach_tracing_prog flag at the attachment
  3084		 * time, but this will not prevent from loading bunch of tracing prog
  3085		 * first, then attach them one to another.
  3086		 *
  3087		 * The flag attach_tracing_prog is set for the whole program lifecycle, and
  3088		 * doesn't have to be cleared in bpf_tracing_link_release, since tracing
  3089		 * programs cannot change attachment target.
  3090		 */
  3091		if (type == BPF_PROG_TYPE_TRACING && dst_prog &&
  3092		    dst_prog->type == BPF_PROG_TYPE_TRACING) {
  3093			prog->aux->attach_tracing_prog = true;
  3094		}
  3095	
  3096		/* find program type: socket_filter vs tracing_filter */
  3097		err = find_prog_type(type, prog);
  3098		if (err < 0)
  3099			goto free_prog;
  3100	
  3101		prog->aux->load_time = ktime_get_boottime_ns();
  3102		err = bpf_obj_name_cpy(prog->aux->name, attr->prog_name,
  3103				       sizeof(attr->prog_name));
  3104		if (err < 0)
  3105			goto free_prog;
  3106	
  3107		err = security_bpf_prog_load(prog, attr, token, uattr.is_kernel);
  3108		if (err)
  3109			goto free_prog_sec;
  3110	
  3111		/* run eBPF verifier */
  3112		err = bpf_check(&prog, attr, uattr, uattr_size);
  3113		if (err < 0)
  3114			goto free_used_maps;
  3115	
  3116		prog = bpf_prog_select_runtime(prog, &err);
  3117		if (err < 0)
  3118			goto free_used_maps;
  3119	
  3120		err = bpf_prog_mark_insn_arrays_ready(prog);
  3121		if (err < 0)
  3122			goto free_used_maps;
  3123	
  3124		err = bpf_prog_alloc_id(prog);
  3125		if (err)
  3126			goto free_used_maps;
  3127	
  3128		/* Upon success of bpf_prog_alloc_id(), the BPF prog is
  3129		 * effectively publicly exposed. However, retrieving via
  3130		 * bpf_prog_get_fd_by_id() will take another reference,
  3131		 * therefore it cannot be gone underneath us.
  3132		 *
  3133		 * Only for the time /after/ successful bpf_prog_new_fd()
  3134		 * and before returning to userspace, we might just hold
  3135		 * one reference and any parallel close on that fd could
  3136		 * rip everything out. Hence, below notifications must
  3137		 * happen before bpf_prog_new_fd().
  3138		 *
  3139		 * Also, any failure handling from this point onwards must
  3140		 * be using bpf_prog_put() given the program is exposed.
  3141		 */
  3142		bpf_prog_kallsyms_add(prog);
  3143		perf_event_bpf_event(prog, PERF_BPF_EVENT_PROG_LOAD, 0);
  3144		bpf_audit_prog(prog, BPF_AUDIT_LOAD);
  3145	
  3146		err = bpf_prog_new_fd(prog);
  3147		if (err < 0)
  3148			bpf_prog_put(prog);
  3149		return err;
  3150	
  3151	free_used_maps:
  3152		/* In case we have subprogs, we need to wait for a grace
  3153		 * period before we can tear down JIT memory since symbols
  3154		 * are already exposed under kallsyms.
  3155		 */
  3156		__bpf_prog_put_noref(prog, prog->aux->real_func_cnt);
  3157		return err;
  3158	
  3159	free_prog_sec:
  3160		security_bpf_prog_free(prog);
  3161	free_prog:
  3162		free_uid(prog->aux->user);
  3163		if (prog->aux->attach_btf)
  3164			btf_put(prog->aux->attach_btf);
  3165		bpf_prog_free(prog);
  3166	put_token:
  3167		bpf_token_put(token);
  3168		return err;
  3169	}
  3170	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
