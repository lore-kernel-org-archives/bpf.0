Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14717342524
	for <bpf@vger.kernel.org>; Tue, 14 Jul 2026 03:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784000209; cv=none; b=tLA5yVsVGNAU8yTrHgq6uZtaDp0IvKLvEHKEBpD1WhS4yF5Z84HHOncomCwiPtoLN7sPJc3TtlnwSINpBbo5/dx5bkRGqpOOoGOsZfciKkgu2aMwTPPskbCJqoLr5RvIogOY1U/dt8bhR2vMa007qtdRhaWuKZc0gFR2Cc+Uu90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784000209; c=relaxed/simple;
	bh=5eCcIL4oxMV+SkkS0K44HVewVkr6API4IPwHUXYMYU0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uOgbkZOvE9tizr/eK0g4PYUezvuQe345FUsAfGPwJ+RmeEBZuz+mA+Zy+9FSGFuQ2Uw/grVG94jjRnzlfMT6TbDZAs/SPG91YEVXgU73AHH2M+xpd0VSEs8d3V03afeZ/T9DLbZMT4u362ln5F5bquy1W9Zoto2k25TrQAnXniM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=W0E+4kzm; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W0E+4kzm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784000208; x=1815536208;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5eCcIL4oxMV+SkkS0K44HVewVkr6API4IPwHUXYMYU0=;
  b=W0E+4kzm3Jxrbyyy0aIsQuEoNWYJf17D8cCXa8QTKyk4todDPJHOjafD
   /C9kOSTjP4A1jG16Eq3YGtF186dOnCFRl3NzeNX74JhEL43hrdqUnykwM
   PHHLTt4GYl6nPtTUbDirAJOiT0sDcfzH/owSeELtioJM8QbIMNaeSBebX
   +E4sslrbmDgxNX3wGRs0kT/M82TGns+BCu6Oh4stcPMJSe7ZEyZGsNPw+
   ar+6CWGqxvJDJTn/uw/Vzyvl3dElTgdVBnZUiG8m+nu60nADdsTcYZVND
   D95JC24/EhLV7scHdGM1YxHwhPtRpON8bOHwZa6TYivKZ5WJqGMtu1wXE
   Q==;
X-CSE-ConnectionGUID: +wCdhShPR/2WD6hfO5AdyA==
X-CSE-MsgGUID: JeRXhIAoTKGsRiCRPsfACg==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="110162102"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="110162102"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2026 20:36:47 -0700
X-CSE-ConnectionGUID: VzoiWrt2TreOTxJFUMVWJA==
X-CSE-MsgGUID: xq3MnKdWQwO5PsCiajxmbQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="259308756"
Received: from igk-lkp-server01.igk.intel.com (HELO e5a8ed462067) ([10.211.93.152])
  by orviesa003.jf.intel.com with ESMTP; 13 Jul 2026 20:36:45 -0700
Received: from kbuild by e5a8ed462067 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wjTwo-000000003rt-2uLo;
	Tue, 14 Jul 2026 03:36:42 +0000
Date: Tue, 14 Jul 2026 05:36:18 +0200
From: kernel test robot <lkp@intel.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>, kkd@meta.com,
	kernel-team@meta.com
Subject: Re: [PATCH bpf-next v3 17/17] bpf: Gate verifier diagnostics on log
 level
Message-ID: <202607140517.PEmgml8m-lkp@intel.com>
References: <20260713153910.2556007-18-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260713153910.2556007-18-memxor@gmail.com>

Hi Kumar,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 9a3a07d06e7d74f4aecc51396c771149336ac55d]

url:    https://github.com/intel-lab-lkp/linux/commits/Kumar-Kartikeya-Dwivedi/bpf-Add-verifier-diagnostics-report-helpers/20260713-235352
base:   9a3a07d06e7d74f4aecc51396c771149336ac55d
patch link:    https://lore.kernel.org/r/20260713153910.2556007-18-memxor%40gmail.com
patch subject: [PATCH bpf-next v3 17/17] bpf: Gate verifier diagnostics on log level
config: x86_64-kexec (https://download.01.org/0day-ci/archive/20260714/202607140517.PEmgml8m-lkp@intel.com/config)
compiler: clang version 22.1.8 (https://github.com/llvm/llvm-project ca7933e47d3a3451d81e72ac174dcb5aa28b59d1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260714/202607140517.PEmgml8m-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202607140517.PEmgml8m-lkp@intel.com/

All warnings (new ones prefixed by >>):

   kernel/bpf/diagnostics.c:38:40: warning: diagnostic behavior may be improved by adding the 'format(printf, 2, 3)' attribute to the declaration of 'diag_log' [-Wmissing-format-attribute]
      30 | static void diag_log(struct bpf_verifier_env *env, const char *fmt, ...)
         | __attribute__((format(printf, 2, 3))) 
      31 | {
      32 |         va_list args;
      33 | 
      34 |         if (!bpf_diag_enabled(env))
      35 |                 return;
      36 | 
      37 |         va_start(args, fmt);
      38 |         bpf_verifier_vlog(&env->log, fmt, args);
         |                                               ^
   kernel/bpf/diagnostics.c:30:13: note: 'diag_log' declared here
      30 | static void diag_log(struct bpf_verifier_env *env, const char *fmt, ...)
         |             ^
>> kernel/bpf/diagnostics.c:89:48: warning: diagnostic behavior may be improved by adding the 'format(printf, 2, 0)' attribute to the declaration of 'diag_vprint_indented' [-Wmissing-format-attribute]
      82 | static void diag_vprint_indented(struct bpf_verifier_env *env, const char *fmt, va_list args)
         | __attribute__((format(printf, 2, 0))) 
      83 | {
      84 |         char *buf;
      85 | 
      86 |         if (!bpf_diag_enabled(env))
      87 |                 return;
      88 | 
      89 |         buf = kvasprintf(GFP_KERNEL_ACCOUNT, fmt, args);
         |                                                       ^
   kernel/bpf/diagnostics.c:82:13: note: 'diag_vprint_indented' declared here
      82 | static void diag_vprint_indented(struct bpf_verifier_env *env, const char *fmt, va_list args)
         |             ^
   kernel/bpf/diagnostics.c:130:13: warning: unused function 'diag_report_reason' [-Wunused-function]
     130 | static void diag_report_reason(struct bpf_verifier_env *env, const char *fmt, ...)
         |             ^~~~~~~~~~~~~~~~~~
   kernel/bpf/diagnostics.c:144:13: warning: unused function 'diag_report_suggestion' [-Wunused-function]
     144 | static void diag_report_suggestion(struct bpf_verifier_env *env, const char *fmt, ...)
         |             ^~~~~~~~~~~~~~~~~~~~~~
   4 warnings generated.


vim +89 kernel/bpf/diagnostics.c

    81	
    82	static void diag_vprint_indented(struct bpf_verifier_env *env, const char *fmt, va_list args)
    83	{
    84		char *buf;
    85	
    86		if (!bpf_diag_enabled(env))
    87			return;
    88	
  > 89		buf = kvasprintf(GFP_KERNEL_ACCOUNT, fmt, args);
    90		if (!buf) {
    91			diag_log(env, "%s<failed to allocate diagnostic text>\n", BPF_DIAG_TEXT_INDENT);
    92			return;
    93		}
    94	
    95		diag_print_wrapped_text(env, buf);
    96		kfree(buf);
    97	}
    98	

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
