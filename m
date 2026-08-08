Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E07D23803C7;
	Sat,  8 Aug 2026 03:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786158009; cv=none; b=MISy8MKz/nUVoPb5XE+A2eFV426qk5P+TvePBoGHNhDvjiAHhj/+v53IvetzI52bqr/oSmLnd9rD4KFiS0+MY6POrqQtPIHJusM3gDZzxs4YrHc4+3QuytTTLJ84m6U1WWTw10XYYRIRuEAGi2R38qXy2Xx4gn+r43Oi0POjz0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786158009; c=relaxed/simple;
	bh=HRDBBFzvW2Ykk/EqBGsgeNi+7wPARF7Oe3MAvEkowq4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IFiXO4+sHwZxSC3/prJCZ9/RQbgSxOjbRmmkRuVtGbAHd+25CeDNaURpmrviK/b6GEvXDjOtwGdCeiw9jiGf/MBe6EZ2g68bWQWSmLX9D/nwOlhNdAnYqbLcW0GtOMQbLs+eWOZFK6J92bQKDQonF5E3Wo8LiIcnMNvaIR9mivQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WdYYFu4p; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WdYYFu4p"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786158007; x=1817694007;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=HRDBBFzvW2Ykk/EqBGsgeNi+7wPARF7Oe3MAvEkowq4=;
  b=WdYYFu4pJQ5jGhTUYmOZsB3fkbQEsFqIcvJy1nTBUFZxNZg0AvWW3ObA
   NH5pIjaEBH3HJUleNJ090ieXS34rkDw5bg5Ug0wVzgkMyeoPIdVcu51k0
   vNCnNvzFsXyZSFdqPUIeHMp+7ECrcN59BN40poSTF4dHgTuk1MCeeq72h
   cblyfocUA8VwPG+xwuufet1uoHR7w8V9hC5KGRZoBp9/KDE4EKOILVp/K
   uLOj5dkivOs/FmOgYXlliD8MV5TgQnJ7ufHuUum9mnhOzRVtNlVQgBclu
   HjluVO3Ejc+UEh9Boq46OeSBSGvz4KwJH96zF0+Qyzs3AsjWa4vuulv55
   g==;
X-CSE-ConnectionGUID: 69+bRniwT3yNJpLkeESnZg==
X-CSE-MsgGUID: KPmT2ps8QsyQ9X0U5Q3+ug==
X-IronPort-AV: E=McAfee;i="6800,10657,11868"; a="86979901"
X-IronPort-AV: E=Sophos;i="6.25,211,1779174000"; 
   d="scan'208";a="86979901"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2026 20:00:06 -0700
X-CSE-ConnectionGUID: Jkvpkn1BRuyLzTO8h1QmCw==
X-CSE-MsgGUID: N5vga5gDS3S6mfPlHlnuOw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,211,1779174000"; 
   d="scan'208";a="261263923"
Received: from lkp-server01.sh.intel.com (HELO 6eda058d650d) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 07 Aug 2026 19:59:58 -0700
Received: from kbuild by 6eda058d650d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wsXHu-00000000Jfx-2fuP;
	Sat, 08 Aug 2026 02:59:54 +0000
Date: Sat, 8 Aug 2026 10:59:20 +0800
From: kernel test robot <lkp@intel.com>
To: Rong Tao <rtoax@foxmail.com>, andrii@kernel.org, vmalik@redhat.com,
	ast@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, rtoax@foxmail.com,
	Rong Tao <rongtao@cestc.cn>, Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Yuzuki Ishiyama <ishiyama@hpc.is.uec.ac.jp>,
	"(open list:BPF \\(Safe Dynamic Programs and Tools\\))" <bpf@vger.kernel.org>,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next v2 2/2] selftests/bpf: Test
 bpf_strcat,bpf_strncat kfuncs
Message-ID: <202608081054.Y56a5ufe-lkp@intel.com>
References: <tencent_DB0510330C3A8574B3C62E6154165FCB4709@qq.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_DB0510330C3A8574B3C62E6154165FCB4709@qq.com>

Hi Rong,

kernel test robot noticed the following build errors:

[auto build test ERROR on bpf-next/master]

url:    https://github.com/intel-lab-lkp/linux/commits/Rong-Tao/selftests-bpf-Test-bpf_strcat-bpf_strncat-kfuncs/20260807-065842
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
patch link:    https://lore.kernel.org/r/tencent_DB0510330C3A8574B3C62E6154165FCB4709%40qq.com
patch subject: [PATCH bpf-next v2 2/2] selftests/bpf: Test bpf_strcat,bpf_strncat kfuncs
config: riscv-randconfig-r131-20260807 (https://download.01.org/0day-ci/archive/20260808/202608081054.Y56a5ufe-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 8.5.0
sparse: v0.6.5-rc1
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260808/202608081054.Y56a5ufe-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202608081054.Y56a5ufe-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from include/uapi/linux/filter.h:9,
                    from include/linux/bpf.h:8,
                    from kernel/bpf/helpers.c:4:
   kernel/bpf/helpers.c: In function '__bpf_strncat':
>> include/linux/compiler_types.h:702:38: error: call to '__compiletime_assert_851' declared with attribute error: min(slen, sz) signedness error
     _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
                                         ^
   include/linux/compiler.h:68:3: note: in definition of macro '__trace_if_value'
     (cond) ?     \
      ^~~~
   include/linux/compiler.h:55:28: note: in expansion of macro '__trace_if_var'
    #define if(cond, ...) if ( __trace_if_var( !!(cond , ## __VA_ARGS__) ) )
                               ^~~~~~~~~~~~~~
   kernel/bpf/helpers.c:4219:2: note: in expansion of macro 'if'
     if (space <= 1 || space < min(slen, sz) + 1)
     ^~
   include/linux/compiler_types.h:690:2: note: in expansion of macro '__compiletime_assert'
     __compiletime_assert(condition, msg, prefix, suffix)
     ^~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:702:2: note: in expansion of macro '_compiletime_assert'
     _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
     ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:40:37: note: in expansion of macro 'compiletime_assert'
    #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
                                        ^~~~~~~~~~~~~~~~~~
   include/linux/minmax.h:93:2: note: in expansion of macro 'BUILD_BUG_ON_MSG'
     BUILD_BUG_ON_MSG(!__types_ok(ux, uy),  \
     ^~~~~~~~~~~~~~~~
   include/linux/minmax.h:98:2: note: in expansion of macro '__careful_cmp_once'
     __careful_cmp_once(op, x, y, __UNIQUE_ID(x_), __UNIQUE_ID(y_))
     ^~~~~~~~~~~~~~~~~~
   include/linux/minmax.h:105:19: note: in expansion of macro '__careful_cmp'
    #define min(x, y) __careful_cmp(min, x, y)
                      ^~~~~~~~~~~~~
   kernel/bpf/helpers.c:4219:28: note: in expansion of macro 'min'
     if (space <= 1 || space < min(slen, sz) + 1)
                               ^~~


vim +/__compiletime_assert_851 +702 include/linux/compiler_types.h

eb5c2d4b45e3d2 Will Deacon 2020-07-21  688  
eb5c2d4b45e3d2 Will Deacon 2020-07-21  689  #define _compiletime_assert(condition, msg, prefix, suffix) \
eb5c2d4b45e3d2 Will Deacon 2020-07-21  690  	__compiletime_assert(condition, msg, prefix, suffix)
eb5c2d4b45e3d2 Will Deacon 2020-07-21  691  
eb5c2d4b45e3d2 Will Deacon 2020-07-21  692  /**
eb5c2d4b45e3d2 Will Deacon 2020-07-21  693   * compiletime_assert - break build and emit msg if condition is false
eb5c2d4b45e3d2 Will Deacon 2020-07-21  694   * @condition: a compile-time constant condition to check
eb5c2d4b45e3d2 Will Deacon 2020-07-21  695   * @msg:       a message to emit if condition is false
eb5c2d4b45e3d2 Will Deacon 2020-07-21  696   *
eb5c2d4b45e3d2 Will Deacon 2020-07-21  697   * In tradition of POSIX assert, this macro will break the build if the
eb5c2d4b45e3d2 Will Deacon 2020-07-21  698   * supplied condition is *false*, emitting the supplied error message if the
eb5c2d4b45e3d2 Will Deacon 2020-07-21  699   * compiler has support to do so.
eb5c2d4b45e3d2 Will Deacon 2020-07-21  700   */
eb5c2d4b45e3d2 Will Deacon 2020-07-21  701  #define compiletime_assert(condition, msg) \
eb5c2d4b45e3d2 Will Deacon 2020-07-21 @702  	_compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
eb5c2d4b45e3d2 Will Deacon 2020-07-21  703  

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
