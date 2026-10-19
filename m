Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.17
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792426132;
	b=HAgCE+8yBnRtmUxgHamHW+uaaEdPTHqLBp+JeiD9mBdtaRoB7d5FwVsyv7p95dsPwGIY
	 WIuGkdbMB2UvTIL6NhumDz5U5NALXxEq0cXV0kotoIyhIdVP8Oii8QFIk8YKyokT93z/L
	 dxxb1ztZR1YUDWD5m59e6BopC5K0tzR9Sk94aPY7gMGZPClF5A9X/ZNUWojzsBPPNImP4
	 KwP/KmsLBTw3jT7Cc5NL8uZ+zq+BSrYQJRE4XbygPc0GlBjSF1KhesIGc950hNxGHtqME
	 k5QoN1g6wVRpzjsvNpSFXPoSMTBHjEx6uGiguBNN/r7M4QsLgzyexRBgv9JA7njc51g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792426132;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=poUPYDGsy3A3qaMJ9gfhwR/7k9/rzOgPJFd+QviZSu4=;
	b=dCBuWDXFD4WxyT7J1U7lfYOdzQnosFhEhkKG5oxaJUwpgKhCmtsoeXfpAh6/QPWfTL0l
	 mM3bHRChR0APpXVcUM+H9LqTP0AWgoTCEl3QE56yut7FUQVi5elPe5z9ZMEGy3o0yTKgg
	 JzBuRU+1qsvxnbCC1Xi4V1c0XhTnlAHMlLMtR+QqPyLooDzx7TuuNtxMOFIhZH/WbA9b8
	 v9MokzjqttUlXaSM8Y9p8MUgbxchvNCOzLqxbZmAlpeDeeQS6ztuJqsi2Akfivg/bljGY
	 ibY0FqlHoZZ3DQlyzIlPtR8j+X9lDj3BpA01O2Md3w5oZsYsXqgKfJl4/cBeDGgI1WA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=KugTD+Zt;
	arc=none smtp.remote-ip=192.198.163.17
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92394606A319;
	Mon, 19 Oct 2026 16:08:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 92394606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=KugTD+Zt
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792426131; x=1823962131;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=tYhhhR8eq9pKvNN5fuGWDReozGHrqdOYBbHVTcKvxBc=;
  b=KugTD+Zt7PqoHvngfvaYdD3o+2ULemqzgkL7KUWAJiYyv+rG3iea1Dta
   5JAe+fUthnIHrlygmvqESBNL8qHE9cUvnlcuHHpLVQbO2RRh3iTyeiGFC
   27PMgarxWwKbK5m5pM0in6yvsBE0tU4fQKekEIxA8g2ADARmcUen09M6j
   nkBQbuumik+j3+ixvSu+6Tn2TVqDLzCymQzJnxB6KcW3YvfIPfeFBNolR
   Rs5ZOF+B6za9Cog7oFDx90n0wXCJ10+2aVsnZQESK0UrhxEn4Fv3KZu2v
   n2W3h2P8q1SS+HCXvm7D95l1Z5eJD31XONn1v4RM3/zKSrpkXHQPfS770
   A==;
X-CSE-ConnectionGUID: 5m5KIbayQASJcPXGdismwA==
X-CSE-MsgGUID: zECmI0blRMKATO8hOjuUhQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11940"; a="1115517"
X-IronPort-AV: E=Sophos;i="6.27,167,1787036400"; 
   d="scan'208";a="1115517"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2026 09:08:50 -0700
X-CSE-ConnectionGUID: jYCtRLUTTomG131lll5p9A==
X-CSE-MsgGUID: JXzuwFcEQkOgnWp/q2l9oQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,167,1787036400"; 
   d="scan'208";a="2452806"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 19 Oct 2026 09:08:47 -0700
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xIpum-00000000Lv4-1g5f;
	Mon, 19 Oct 2026 16:08:44 +0000
Date: Tue, 20 Oct 2026 00:07:48 +0800
From: kernel test robot <lkp@intel.com>
To: David Laight <david.laight.linux@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Petr Mladek <pmladek@suse.com>, Kees Cook <kees@kernel.org>,
	linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
	bpf@vger.kernel.org, Jim Cromie <jim.cromie@gmail.com>,
	Lorenzo Stoakes <ljs@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev,
	Linux Memory Management List <linux-mm@kvack.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>,
	Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v2 next 03/15] kallsyms: Improve selftest
 test_perf_kallsyms_lookup_name() output
Message-ID: <202610192356.CItNLOke-lkp@intel.com>
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
config: nios2-randconfig-1000-20261019 (https://download.01.org/0day-ci/archive/20261019/202610192356.CItNLOke-lkp@intel.com/config)
compiler: nios2-linux-gcc (GCC) 10.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261019/202610192356.CItNLOke-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202610192356.CItNLOke-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> kernel/kallsyms_selftest.c:70:1: warning: 'The_time_has_come_the_Walrus_said_To_talk_of_many_things_Of_shoes_and_ships_and_sealing_wax_Of_cabbages_and_kings_And_why_the_sea_is_boiling_hot_And_whether_pigs_have_wings_O_Oysters_said_the_Carpenter_Youve_had_a_pleasant_run_Shall_we_be_trotting_home_again_But_answer_came_there_none_And_this_was_scarcely_odd_because_Theyd_eaten_every_one_The_moon_was_shining_sulkily_Because_she_thought_the_sun_Had_got_no_business_to_be_there_After_the_day_was_done_Its_very_rude_of_him_she_said_To_come_and_spoil_the_fun' defined but not used [-Wunused-variable]
      70 | The_time_has_come_the_Walrus_said_To_talk_of_many_things\
         | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      71 | _Of_shoes_and_ships_and_sealing_wax_Of_cabbages_and_kings\
         | ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      72 | _And_why_the_sea_is_boiling_hot_And_whether_pigs_have_wings\
         | ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      73 | \
         | ~
      74 | _O_Oysters_said_the_Carpenter_Youve_had_a_pleasant_run\
         | ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      75 | _Shall_we_be_trotting_home_again_But_answer_came_there_none\
         | ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      76 | _And_this_was_scarcely_odd_because_Theyd_eaten_every_one\
         | ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      77 | \
         | ~
      78 | _The_moon_was_shining_sulkily_Because_she_thought_the_sun\
         | ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      79 | _Had_got_no_business_to_be_there_After_the_day_was_done\
         | ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      80 | _Its_very_rude_of_him_she_said_To_come_and_spoil_the_fun
         | ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   kernel/kallsyms_selftest.c:70:1: note: in definition of macro 'kallsyms_very_long_name'
      70 | The_time_has_come_the_Walrus_said_To_talk_of_many_things\
         | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      71 | _Of_shoes_and_ships_and_sealing_wax_Of_cabbages_and_kings\
         | ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      72 | _And_why_the_sea_is_boiling_hot_And_whether_pigs_have_wings\
         | ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      73 | \
         | ~
      74 | _O_Oysters_said_the_Carpenter_Youve_had_a_pleasant_run\
         | ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      75 | _Shall_we_be_trotting_home_again_But_answer_came_there_none\
         | ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      76 | _And_this_was_scarcely_odd_because_Theyd_eaten_every_one\
         | ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      77 | \
         | ~
      78 | _The_moon_was_shining_sulkily_Because_she_thought_the_sun\
         | ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      79 | _Had_got_no_business_to_be_there_After_the_day_was_done\
         | ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      80 | _Its_very_rude_of_him_she_said_To_come_and_spoil_the_fun
         | ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +/The_time_has_come_the_Walrus_said_To_talk_of_many_things_Of_shoes_and_ships_and_sealing_wax_Of_cabbages_and_kings_And_why_the_sea_is_boiling_hot_And_whether_pigs_have_wings_O_Oysters_said_the_Carpenter_Youve_had_a_pleasant_run_Shall_we_be_trotting_home_again_But_answer_came_there_none_And_this_was_scarcely_odd_because_Theyd_eaten_every_one_The_moon_was_shining_sulkily_Because_she_thought_the_sun_Had_got_no_business_to_be_there_After_the_day_was_done_Its_very_rude_of_him_she_said_To_come_and_spoil_the_fun +70 kernel/kallsyms_selftest.c

    67	
    68	/* This is 509 characters, compresses to about 330 */
    69	#define kallsyms_very_long_name \
  > 70	The_time_has_come_the_Walrus_said_To_talk_of_many_things\
    71	_Of_shoes_and_ships_and_sealing_wax_Of_cabbages_and_kings\
    72	_And_why_the_sea_is_boiling_hot_And_whether_pigs_have_wings\
    73	\
    74	_O_Oysters_said_the_Carpenter_Youve_had_a_pleasant_run\
    75	_Shall_we_be_trotting_home_again_But_answer_came_there_none\
    76	_And_this_was_scarcely_odd_because_Theyd_eaten_every_one\
    77	\
    78	_The_moon_was_shining_sulkily_Because_she_thought_the_sun\
    79	_Had_got_no_business_to_be_there_After_the_day_was_done\
    80	_Its_very_rude_of_him_she_said_To_come_and_spoil_the_fun
    81	

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
