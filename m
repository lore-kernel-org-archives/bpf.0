Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 835F91EB9E3
	for <bpf@vger.kernel.org>; Sat, 28 Feb 2026 01:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772241769; cv=none; b=dELGTtFxqufJ643ZyQbiF0mCqJVEAy7CUkhVrtC6ZegmI54XuuuO4uqwASxe/+P+xkxl6Qy57GibjdwPMMZXttByxJgkhLYKdY9yvvORmw19hOS9PVulbWyrkIE0TKVIxV2eawMZmTmUYwpQC89ch2AnxS4PaZLLnDZnqZyEzmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772241769; c=relaxed/simple;
	bh=GKTGEJrfx7EBVAgyKuxiijOByb6UX2CLfdacpxzuSxk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PMVUeIwIkbtmgLo2UMo//9QFRnsLvE7N8ZVV0vpfohyb+3OzREfssDPt/pFHc1TWg8QrXZDmzLtg8NF+jRMKeBqjGMVElaHsk2ZrBPUuV8tI+3fJNngV4KahbdlCCot6F0WX2k+13e7PX2IEh0s9eUb1KmUkwfU6vR1EK1V959k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Te1LmCmv; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Te1LmCmv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772241767; x=1803777767;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=GKTGEJrfx7EBVAgyKuxiijOByb6UX2CLfdacpxzuSxk=;
  b=Te1LmCmv0QlgIQyU2MbjRzlJYusWWcsdGs1vaaSaCLiI4tJ9AJjJzwFr
   R/I76JhKUNGvNNpmIEkvGXd86/3PGpsL0od3Rj3Tn08bDcWyk1a8QuHh7
   XEVTQbjNWvv1+WMCIjLsYtikxD5Mughr/iFtTSeLZOZyiANNP7b5DyqvM
   NO4LUSjJ7k2zuGQZX5f6oS8QT6n8WkgdEFr3dRA7Mt9udzioamGmEKj53
   f9tByDg5WegNom4aWVkab0y7R/QHMoDoDKxjfy0xRpQPdbmfrCmdjdVDD
   z4rzri9FkIghkWAmGi1SBNyOkr2nkoByQ16eIeer2zU1jO9yY+cdWT+nv
   g==;
X-CSE-ConnectionGUID: XdSQZAIhRhalASOUu8OrbA==
X-CSE-MsgGUID: 8zcWVaBcT8yJh59lKCLN/w==
X-IronPort-AV: E=McAfee;i="6800,10657,11714"; a="98801955"
X-IronPort-AV: E=Sophos;i="6.21,315,1763452800"; 
   d="scan'208";a="98801955"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2026 17:22:47 -0800
X-CSE-ConnectionGUID: Qxi4aMLCQfqHVYIDFut8Sw==
X-CSE-MsgGUID: r1s0ap9FQg+EpTpRIqcK4Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,315,1763452800"; 
   d="scan'208";a="244351451"
Received: from lkp-server02.sh.intel.com (HELO a3936d6a266d) ([10.239.97.151])
  by fmviesa001.fm.intel.com with ESMTP; 27 Feb 2026 17:22:44 -0800
Received: from kbuild by a3936d6a266d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vw92X-00000000BEF-2GkD;
	Sat, 28 Feb 2026 01:22:41 +0000
Date: Sat, 28 Feb 2026 09:22:05 +0800
From: kernel test robot <lkp@intel.com>
To: Emil Tsalapatis <emil@etsalapatis.com>, bpf@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, andrii@kernel.org,
	ast@kernel.org, daniel@iogearbox.net, eddyz87@gmail.com,
	martin.lau@kernel.org, memxor@gmail.com, song@kernel.org,
	yonghong.song@linux.dev, Emil Tsalapatis <emil@etsalapatis.com>
Subject: Re: [PATCH bpf-next v5 1/5] bpf: Factor out program return value
 calculation
Message-ID: <202602280948.ZMhck27g-lkp@intel.com>
References: <20260227154616.6846-2-emil@etsalapatis.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260227154616.6846-2-emil@etsalapatis.com>

Hi Emil,

kernel test robot noticed the following build warnings:

[auto build test WARNING on bpf-next/master]

url:    https://github.com/intel-lab-lkp/linux/commits/Emil-Tsalapatis/bpf-Factor-out-program-return-value-calculation/20260227-235723
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
patch link:    https://lore.kernel.org/r/20260227154616.6846-2-emil%40etsalapatis.com
patch subject: [PATCH bpf-next v5 1/5] bpf: Factor out program return value calculation
config: arm-randconfig-001-20260228 (https://download.01.org/0day-ci/archive/20260228/202602280948.ZMhck27g-lkp@intel.com/config)
compiler: clang version 16.0.6 (https://github.com/llvm/llvm-project 7cbf1a2591520c2491aa35339f227775f4d3adf6)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260228/202602280948.ZMhck27g-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202602280948.ZMhck27g-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> kernel/bpf/verifier.c:17864:3: warning: label at end of compound statement is a C2x extension [-Wc2x-extensions]
                   }
                   ^
   kernel/bpf/verifier.c:17923:6: warning: unused variable 'ret' [-Wunused-variable]
           int ret, err;
               ^
   kernel/bpf/verifier.c:17926:7: warning: unused variable 'return_32bit' [-Wunused-variable]
           bool return_32bit = false;
                ^
   3 warnings generated.


vim +17864 kernel/bpf/verifier.c

 17805	
 17806	
 17807	static bool return_retval_range(struct bpf_verifier_env *env, struct bpf_retval_range *range)
 17808	{
 17809		enum bpf_prog_type prog_type = resolve_prog_type(env->prog);
 17810	
 17811		/* Default return value range. */
 17812		*range = retval_range(0, 1);
 17813	
 17814		switch (prog_type) {
 17815		case BPF_PROG_TYPE_CGROUP_SOCK_ADDR:
 17816			switch (env->prog->expected_attach_type) {
 17817			case BPF_CGROUP_UDP4_RECVMSG:
 17818			case BPF_CGROUP_UDP6_RECVMSG:
 17819			case BPF_CGROUP_UNIX_RECVMSG:
 17820			case BPF_CGROUP_INET4_GETPEERNAME:
 17821			case BPF_CGROUP_INET6_GETPEERNAME:
 17822			case BPF_CGROUP_UNIX_GETPEERNAME:
 17823			case BPF_CGROUP_INET4_GETSOCKNAME:
 17824			case BPF_CGROUP_INET6_GETSOCKNAME:
 17825			case BPF_CGROUP_UNIX_GETSOCKNAME:
 17826				*range = retval_range(1, 1);
 17827				break;
 17828			case BPF_CGROUP_INET4_BIND:
 17829			case BPF_CGROUP_INET6_BIND:
 17830				*range = retval_range(0, 3);
 17831				break;
 17832			default:
 17833				break;
 17834			}
 17835			break;
 17836		case BPF_PROG_TYPE_CGROUP_SKB:
 17837			if (env->prog->expected_attach_type == BPF_CGROUP_INET_EGRESS)
 17838				*range = retval_range(0, 3);
 17839			break;
 17840		case BPF_PROG_TYPE_CGROUP_SOCK:
 17841		case BPF_PROG_TYPE_SOCK_OPS:
 17842		case BPF_PROG_TYPE_CGROUP_DEVICE:
 17843		case BPF_PROG_TYPE_CGROUP_SYSCTL:
 17844		case BPF_PROG_TYPE_CGROUP_SOCKOPT:
 17845			break;
 17846		case BPF_PROG_TYPE_RAW_TRACEPOINT:
 17847			if (!env->prog->aux->attach_btf_id)
 17848				return false;
 17849			*range = retval_range(0, 0);
 17850			break;
 17851		case BPF_PROG_TYPE_TRACING:
 17852			switch (env->prog->expected_attach_type) {
 17853			case BPF_TRACE_FENTRY:
 17854			case BPF_TRACE_FEXIT:
 17855			case BPF_TRACE_FSESSION:
 17856				*range = retval_range(0, 0);
 17857				break;
 17858			case BPF_TRACE_RAW_TP:
 17859			case BPF_MODIFY_RETURN:
 17860				return false;
 17861			case BPF_TRACE_ITER:
 17862				break;
 17863			default:
 17864			}
 17865			break;
 17866		case BPF_PROG_TYPE_KPROBE:
 17867			switch (env->prog->expected_attach_type) {
 17868			case BPF_TRACE_KPROBE_SESSION:
 17869			case BPF_TRACE_UPROBE_SESSION:
 17870				break;
 17871			default:
 17872				return false;
 17873			}
 17874			break;
 17875		case BPF_PROG_TYPE_SK_LOOKUP:
 17876			*range = retval_range(SK_DROP, SK_PASS);
 17877			break;
 17878	
 17879		case BPF_PROG_TYPE_LSM:
 17880			if (env->prog->expected_attach_type != BPF_LSM_CGROUP) {
 17881				/* no range found, any return value is allowed */
 17882				if (!get_func_retval_range(env->prog, range))
 17883					return false;
 17884				/* no restricted range, any return value is allowed */
 17885				if (range->minval == S32_MIN && range->maxval == S32_MAX)
 17886					return false;
 17887				range->return_32bit = true;
 17888			} else if (!env->prog->aux->attach_func_proto->type) {
 17889				/* Make sure programs that attach to void
 17890				 * hooks don't try to modify return value.
 17891				 */
 17892				*range = retval_range(1, 1);
 17893			}
 17894			break;
 17895	
 17896		case BPF_PROG_TYPE_NETFILTER:
 17897			*range = retval_range(NF_DROP, NF_ACCEPT);
 17898			break;
 17899		case BPF_PROG_TYPE_STRUCT_OPS:
 17900			*range = retval_range(0, 0);
 17901			break;
 17902		case BPF_PROG_TYPE_EXT:
 17903			/* freplace program can return anything as its return value
 17904			 * depends on the to-be-replaced kernel func or bpf program.
 17905			 */
 17906		default:
 17907			return false;
 17908		}
 17909	
 17910		/* Continue calculating. */
 17911	
 17912		return true;
 17913	}
 17914	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
