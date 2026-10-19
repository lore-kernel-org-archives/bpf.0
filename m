Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.21
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792443503;
	b=BmR4A+kxhmJhcR4X2JNYaDXltE/GyA+SLQuiqT2UcQArVbh+f4Am1xr07wsiYbEJ2/BS
	 8bg6eDv5IrNqJSeYIqzaCWzpJxZmxEwt8dNzBao8TAcQfX2tpE9k3unq9WzmcPOYN82Bz
	 +b/kdQ+acw8g6TMTq6msDUThxVHV42VPgbW5FXP1CV/hK57bTOLrzjlhtExoLrAMgZPta
	 qFx1qsrziXoLFe92eJFfnrU3ssCs/D99K/fnOzZViLx1wjfI7kS5OFc98TP47cYImaM47
	 q2gPkkqDsX+JFVgQ6RimBZb8wKugt4s6TDoVG2/boYEcs0e1Rnfi+k8iUcAggLpQlOg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792443503;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=etQvNscIjqvkrWpefPH+Ohc94n3wsi43ZWyZPkQfApQ=;
	b=EFf6OBBHKSlnsXU1eXnLPB0f0+UREOKH5grNMT48r8DvbvsmtKuONmwhW+sa372sInuv
	 wPmH509OizHJ8o/SK1PA3B0W9qo45znZvCA/K8TTIDGMx6tUD1D3hHO3wXXbs3XZStQBf
	 VA/wH54SzCxURqzBMMV3qukr0NfYBf90KrVIf7dhqUSFvhwyESN5JQchYP4o49vnYkiSh
	 JLQSh/7fBjCRGj4r8suyEwqbF8sk4Q2BdeIgXPNm8zpUVf/CzTJ4w8yTA0QAy440GJyKU
	 VG7yuqGfs+GaNnZfhzDSumBQfWSso+XpffPebcRdfsLe7dvI4G6jJEOgjwmZD3SuNPQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="MQJP/Zeq";
	arc=none smtp.remote-ip=198.175.65.21
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD2D6606A31C;
	Mon, 19 Oct 2026 20:58:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AD2D6606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=MQJP/Zeq
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792443503; x=1823979503;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=LjZKwGBbVcACOcsPvYU618VBeMr1LoG3ldjZ3OGSp3Q=;
  b=MQJP/ZeqaCS9Hl76Rfka6j/Fyty9PVAXaYJuFhaL+ujI1YEvAoTgtqbi
   xYeK4Qe+kVYy8C9eAIBUuld7ggPEqP4uQeYCSt9CAogVx6ZT8vPGwylx0
   ZXYdXSaHaO1zoxSw6me+mPJOEexthNvdGh95al4OM8hxedUa9CZ9W/rvK
   9a0cdgx+58RLW9rxlHlUhSF6VHq6uUCWS/dYOMWsXwx9ZpOKOVHbT1Pn1
   ZpfSg/AGa5vpwSy2ZRKBKWyrnyvYRIF4vQuR2QIbSDDuFz3KGD1Eg6wlO
   OxiqNQlaNICcZL4BMYycn6v16HTfEXYmbqSkyAL/Aoz7AL0BUON9jCFwR
   Q==;
X-CSE-ConnectionGUID: fB5ojh34QqOsDsNQj9VOTg==
X-CSE-MsgGUID: 1vi/ZCdZQUK/7AR80u5JQw==
X-IronPort-AV: E=McAfee;i="6800,10657,11940"; a="1240717"
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="1240717"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2026 13:58:22 -0700
X-CSE-ConnectionGUID: l4uSqfeCQheS9pa1UzaC7Q==
X-CSE-MsgGUID: pxRj+kMZRlaHxvrp1glKuQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="2943062"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 19 Oct 2026 13:58:18 -0700
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xIuQx-00000000MO2-3Cks;
	Mon, 19 Oct 2026 20:58:15 +0000
Date: Tue, 20 Oct 2026 04:57:54 +0800
From: kernel test robot <lkp@intel.com>
To: David Laight <david.laight.linux@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Petr Mladek <pmladek@suse.com>, Kees Cook <kees@kernel.org>,
	linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
	bpf@vger.kernel.org, Jim Cromie <jim.cromie@gmail.com>,
	Lorenzo Stoakes <ljs@kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Linux Memory Management List <linux-mm@kvack.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>,
	Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v2 next 03/15] kallsyms: Improve selftest
 test_perf_kallsyms_lookup_name() output
Message-ID: <202610200434.qSHPOyDo-lkp@intel.com>
References: <20261018155206.132411-4-david.laight.linux@gmail.com>
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
In-Reply-To: <20261018155206.132411-4-david.laight.linux@gmail.com>

Hi David,

kernel test robot noticed the following build warnings:

[auto build test WARNING on akpm-mm/mm-everything]
[also build test WARNING on linus/master v7.3]
[cannot apply to next-20261016 next-20261016]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/David-Laight/kallsyms-scripts-kallsyms-c-Avoid-overrunning-on-stack-buffer/20261018-165152
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/20261018155206.132411-4-david.laight.linux%40gmail.com
patch subject: [PATCH v2 next 03/15] kallsyms: Improve selftest test_perf_kallsyms_lookup_name() output
config: arm64-randconfig-1000-20261019 (https://download.01.org/0day-ci/archive/20261020/202610200434.qSHPOyDo-lkp@intel.com/config)
compiler: clang version 21.1.8 (https://github.com/llvm/llvm-project 2078da43e25a4623cab2d0d60decddf709aaea28)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261020/202610200434.qSHPOyDo-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202610200434.qSHPOyDo-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> kernel/kallsyms_selftest.c:82:12: warning: unused variable 'The_time_has_come_the_Walrus_said_To_talk_of_many_things_Of_shoes_and_ships_and_sealing_wax_Of_cabbages_and_kings_And_why_the_sea_is_boiling_hot_And_whether_pigs_have_wings_O_Oysters_said_the_Carpenter_Youve_had_a_pleasant_run_Shall_we_be_trotting_home_again_But_answer_came_there_none_And_this_was_scarcely_odd_because_Theyd_eaten_every_one_The_moon_was_shining_sulkily_Because_she_thought_the_sun_Had_got_no_business_to_be_there_After_the_day_was_done_Its_very_rude_of_him_she_said_To_come_and_spoil_the_fun' [-Wunused-variable]
      82 | static int kallsyms_very_long_name = 1;
         |            ^~~~~~~~~~~~~~~~~~~~~~~
   kernel/kallsyms_selftest.c:69:33: note: expanded from macro 'kallsyms_very_long_name'
      69 | #define kallsyms_very_long_name \
         |                                 ^
   1 warning generated.


vim +/The_time_has_come_the_Walrus_said_To_talk_of_many_things_Of_shoes_and_ships_and_sealing_wax_Of_cabbages_and_kings_And_why_the_sea_is_boiling_hot_And_whether_pigs_have_wings_O_Oysters_said_the_Carpenter_Youve_had_a_pleasant_run_Shall_we_be_trotting_home_again_But_answer_came_there_none_And_this_was_scarcely_odd_because_Theyd_eaten_every_one_The_moon_was_shining_sulkily_Because_she_thought_the_sun_Had_got_no_business_to_be_there_After_the_day_was_done_Its_very_rude_of_him_she_said_To_come_and_spoil_the_fun +82 kernel/kallsyms_selftest.c

    81	
  > 82	static int kallsyms_very_long_name = 1;
    83	

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
