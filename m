Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F61032E151;
	Fri, 20 Feb 2026 12:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771588820; cv=none; b=EjwDT+hpxIWmeVbHi3zdcKGbq19AIdpZGSkd1Roxz7Aa5sju9IdOjmWLDJnehci4+3Uu72krnUTzqud5J6ielMuCTS5L0OK+fbD2PcOJizLanZ7BYOMBfZyWZxLpTZrgwPf4Z+fWyA8ydBcaweT6wMsItvxkG5TKECTarEUQHiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771588820; c=relaxed/simple;
	bh=BJwn3q+eqyH6klWhmr3v9YPJaWcEJddp5EliWQLosW4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iQsVYLTF1mKxHXOin1JBWCmtwqsNVEcfH+Uu4Vy9LMSNtArmUTkXP+08FYO8mBuFmA6CuDt7R6a+8sfJeqXjkPxxZ8IxrauaLeTU31rUyM1uHjAUauviIWfoskNxd/33C180apqLQOLaPNZujEqrR24U+hW11L0EIxYr7nZa3Go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dhK7RrRa; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dhK7RrRa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771588818; x=1803124818;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=BJwn3q+eqyH6klWhmr3v9YPJaWcEJddp5EliWQLosW4=;
  b=dhK7RrRaoKni7o9QEwNQj4RZ4Vu+iDJlasl9bMItWTLu6lwmAVCw8YOr
   uKNUguRZ3z9I1Fv3/aAFI64NEBb/DuLPCfYbbTb3YbGKEoHqfBDL4AsJp
   xk96+UvmIEs8x16YqalSRLavNvJDgbOapz7ceicyoYMLtQctCYlLgudBJ
   tEzXmFZrhgTA3IBGuXBW7nsE5EYexphbPFkvDVA5E1SB4jcV8RIyjQ1if
   2cU5r79BOX2crj++vMOmS6EllnHzcRNqbKkHbtxpo82h6gQwatFbQ6TcW
   J95866OXzJ6UQ7TZbQXyLeYI97uWG+OPKR+MnMIpZLFcMIsfGZhJKyZ/C
   g==;
X-CSE-ConnectionGUID: GjJWUeXTT7COONg3mn9/AQ==
X-CSE-MsgGUID: aW7RY/KaTJ2eRsSJJCXMYA==
X-IronPort-AV: E=McAfee;i="6800,10657,11706"; a="72579546"
X-IronPort-AV: E=Sophos;i="6.21,301,1763452800"; 
   d="scan'208";a="72579546"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2026 04:00:18 -0800
X-CSE-ConnectionGUID: fxCgkGONQi+IaN4+f3YPjQ==
X-CSE-MsgGUID: JjXTyrWBSxStWLPFlyzSCg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,301,1763452800"; 
   d="scan'208";a="213402075"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 20 Feb 2026 04:00:11 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vtPB3-0000000144S-0Nu8;
	Fri, 20 Feb 2026 12:00:09 +0000
Date: Fri, 20 Feb 2026 19:59:16 +0800
From: kernel test robot <lkp@intel.com>
To: Leon Hwang <leon.hwang@linux.dev>, bpf@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Puranjay Mohan <puranjay@kernel.org>,
	Xu Kuohai <xukuohai@huaweicloud.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H . Peter Anvin" <hpa@zytor.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Leon Hwang <leon.hwang@linux.dev>, Peilin Ye <yepeilin@google.com>,
	Luis Gerhorst <luis.gerhorst@fau.de>,
	Viktor Malik <vmalik@redhat.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next v2 2/6] bpf, x86: Add 64-bit bitops kfuncs
 support for x86_64
Message-ID: <202602201931.LBZGbpvs-lkp@intel.com>
References: <20260219142933.13904-3-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260219142933.13904-3-leon.hwang@linux.dev>

Hi Leon,

kernel test robot noticed the following build errors:

[auto build test ERROR on bpf-next/master]

url:    https://github.com/intel-lab-lkp/linux/commits/Leon-Hwang/bpf-Introduce-64-bit-bitops-kfuncs/20260219-223550
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
patch link:    https://lore.kernel.org/r/20260219142933.13904-3-leon.hwang%40linux.dev
patch subject: [PATCH bpf-next v2 2/6] bpf, x86: Add 64-bit bitops kfuncs support for x86_64
config: x86_64-randconfig-012-20260220 (https://download.01.org/0day-ci/archive/20260220/202602201931.LBZGbpvs-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
rustc: rustc 1.88.0 (6b00bc388 2025-06-23)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260220/202602201931.LBZGbpvs-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202602201931.LBZGbpvs-lkp@intel.com/

All errors (new ones prefixed by >>):

>> ld.lld: error: undefined symbol: bpf_clz64
   >>> referenced by bpf_jit_comp.c:1621 (arch/x86/net/bpf_jit_comp.c:1621)
   >>>               arch/x86/net/bpf_jit_comp.o:(do_jit) in archive vmlinux.a
   >>> referenced by bpf_jit_comp.c:4250 (arch/x86/net/bpf_jit_comp.c:4250)
   >>>               arch/x86/net/bpf_jit_comp.o:(bpf_jit_inlines_kfunc_call) in archive vmlinux.a
--
>> ld.lld: error: undefined symbol: bpf_ctz64
   >>> referenced by bpf_jit_comp.c:1647 (arch/x86/net/bpf_jit_comp.c:1647)
   >>>               arch/x86/net/bpf_jit_comp.o:(do_jit) in archive vmlinux.a
   >>> referenced by bpf_jit_comp.c:4247 (arch/x86/net/bpf_jit_comp.c:4247)
   >>>               arch/x86/net/bpf_jit_comp.o:(bpf_jit_inlines_kfunc_call) in archive vmlinux.a
--
>> ld.lld: error: undefined symbol: bpf_ffs64
   >>> referenced by bpf_jit_comp.c:1673 (arch/x86/net/bpf_jit_comp.c:1673)
   >>>               arch/x86/net/bpf_jit_comp.o:(do_jit) in archive vmlinux.a
   >>> referenced by bpf_jit_comp.c:4247 (arch/x86/net/bpf_jit_comp.c:4247)
   >>>               arch/x86/net/bpf_jit_comp.o:(bpf_jit_inlines_kfunc_call) in archive vmlinux.a
--
>> ld.lld: error: undefined symbol: bpf_fls64
   >>> referenced by bpf_jit_comp.c:1677 (arch/x86/net/bpf_jit_comp.c:1677)
   >>>               arch/x86/net/bpf_jit_comp.o:(do_jit) in archive vmlinux.a
   >>> referenced by bpf_jit_comp.c:4250 (arch/x86/net/bpf_jit_comp.c:4250)
   >>>               arch/x86/net/bpf_jit_comp.o:(bpf_jit_inlines_kfunc_call) in archive vmlinux.a
--
>> ld.lld: error: undefined symbol: bpf_popcnt64
   >>> referenced by bpf_jit_comp.c:1683 (arch/x86/net/bpf_jit_comp.c:1683)
   >>>               arch/x86/net/bpf_jit_comp.o:(do_jit) in archive vmlinux.a
   >>> referenced by bpf_jit_comp.c:4253 (arch/x86/net/bpf_jit_comp.c:4253)
   >>>               arch/x86/net/bpf_jit_comp.o:(bpf_jit_inlines_kfunc_call) in archive vmlinux.a
--
>> ld.lld: error: undefined symbol: bpf_rol64
   >>> referenced by bpf_jit_comp.c:1707 (arch/x86/net/bpf_jit_comp.c:1707)
   >>>               arch/x86/net/bpf_jit_comp.o:(do_jit) in archive vmlinux.a
   >>> referenced by bpf_jit_comp.c:4256 (arch/x86/net/bpf_jit_comp.c:4256)
   >>>               arch/x86/net/bpf_jit_comp.o:(bpf_jit_inlines_kfunc_call) in archive vmlinux.a
--
>> ld.lld: error: undefined symbol: bpf_ror64
   >>> referenced by bpf_jit_comp.c:1714 (arch/x86/net/bpf_jit_comp.c:1714)
   >>>               arch/x86/net/bpf_jit_comp.o:(do_jit) in archive vmlinux.a
   >>> referenced by bpf_jit_comp.c:4256 (arch/x86/net/bpf_jit_comp.c:4256)
   >>>               arch/x86/net/bpf_jit_comp.o:(bpf_jit_inlines_kfunc_call) in archive vmlinux.a

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
