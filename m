Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FF0926D4E5;
	Mon,  2 Feb 2026 18:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770058342; cv=none; b=MNzuhak+E7Vkr4ZyDV26P61+lcHedhClQcm/9bk2WzUJI3efNlj7cCmhLTjdEwWXp8jpc1lGqwDislgu6kPx5RDzIsjkINw8AwZ1/n6z4FqnpcezFCtUxdfla/W7mb8zEtFawNcEIrZlEVuxLRg7OV3QFT06eqO5rI0zoltRXmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770058342; c=relaxed/simple;
	bh=GOleOZSLCybPgY9oOZzzYC/StizP9hr+mQ/CEpKf2Ds=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rfY3708bfPM+vwtZJNhi7iyXFKvSX3bGN0qmMOWAxt1HpcTb1aGYtwfsHtj0zp99Z+DxLul6M9tAGHC4QaIf81Jo2LXxEksGcmqErr3OMQGm5aRHm2cr8qjX3NGtELT3kqlIJUM7XforGKob/pZ4HXCGqYtxvl9hYOzgp41f1GE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ldg7hxrq; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ldg7hxrq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770058340; x=1801594340;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=GOleOZSLCybPgY9oOZzzYC/StizP9hr+mQ/CEpKf2Ds=;
  b=Ldg7hxrq0/9k+0oCOQ+0JWcnOsbfCTaFG5WR6IZiFrQ8mCxnYOPKaVmI
   s51b1Ed5F9Z67ZOjtb5Y3mrPoJ6WDH2Yy8TPRUTUBcOqL1O9HPG13B2py
   LYiLXkVLGaD1D3hh6Oq4ErPvpKz268VmWcLUEEtvykR71t3VhFjxJD5gx
   8Ubk21/qWxHkU+cL6QRTQa7Hb1WSBceaRyUimwIsztG3BitN4KuqJRpM+
   KZ/jqJXJ6OmO8tDJGnUQ8ZRtUwcng7gbgJ9Ue+KKFrFWV6WExHQOxpX7C
   l9nLtoOso8GDR4O+bBchJqa00LgH50+dYVPWim3LHALwx9cF4jD3K6f0s
   w==;
X-CSE-ConnectionGUID: FnkJ6nJnS32Vp18JRsH79w==
X-CSE-MsgGUID: XKfv0ke1QVmDHUUFTa2GgQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11690"; a="71122709"
X-IronPort-AV: E=Sophos;i="6.21,269,1763452800"; 
   d="scan'208";a="71122709"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2026 10:52:19 -0800
X-CSE-ConnectionGUID: HjFsASBvQMqUt8EGl/maaA==
X-CSE-MsgGUID: dF/rH+jIQvO2Oa9y8nWB3Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,269,1763452800"; 
   d="scan'208";a="247200893"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 02 Feb 2026 10:52:15 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vmz1x-00000000frs-2POJ;
	Mon, 02 Feb 2026 18:52:13 +0000
Date: Tue, 3 Feb 2026 02:51:37 +0800
From: kernel test robot <lkp@intel.com>
To: Jiri Olsa <jolsa@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
	Alexei Starovoitov <ast@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Menglong Dong <menglong8.dong@gmail.com>,
	Song Liu <song@kernel.org>
Subject: Re: [PATCH bpf-next] ftrace: Fix direct_functions leak in
 update_ftrace_direct_del
Message-ID: <202602030237.Ze7K6UoS-lkp@intel.com>
References: <20260202075849.1684369-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260202075849.1684369-1-jolsa@kernel.org>

Hi Jiri,

kernel test robot noticed the following build warnings:

[auto build test WARNING on bpf-next/master]

url:    https://github.com/intel-lab-lkp/linux/commits/Jiri-Olsa/ftrace-Fix-direct_functions-leak-in-update_ftrace_direct_del/20260202-160850
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
patch link:    https://lore.kernel.org/r/20260202075849.1684369-1-jolsa%40kernel.org
patch subject: [PATCH bpf-next] ftrace: Fix direct_functions leak in update_ftrace_direct_del
config: i386-randconfig-r123-20260202 (https://download.01.org/0day-ci/archive/20260203/202602030237.Ze7K6UoS-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260203/202602030237.Ze7K6UoS-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202602030237.Ze7K6UoS-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   kernel/trace/ftrace.c:1094:43: sparse:     got struct ftrace_hash *
   kernel/trace/ftrace.c:1326:40: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct ftrace_hash *hash @@     got struct ftrace_hash [noderef] __rcu *filter_hash @@
   kernel/trace/ftrace.c:1326:40: sparse:     expected struct ftrace_hash *hash
   kernel/trace/ftrace.c:1326:40: sparse:     got struct ftrace_hash [noderef] __rcu *filter_hash
   kernel/trace/ftrace.c:1327:40: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct ftrace_hash *hash @@     got struct ftrace_hash [noderef] __rcu *notrace_hash @@
   kernel/trace/ftrace.c:1327:40: sparse:     expected struct ftrace_hash *hash
   kernel/trace/ftrace.c:1327:40: sparse:     got struct ftrace_hash [noderef] __rcu *notrace_hash
   kernel/trace/ftrace.c:1328:37: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct ftrace_hash [noderef] __rcu *filter_hash @@     got struct ftrace_hash * @@
   kernel/trace/ftrace.c:1328:37: sparse:     expected struct ftrace_hash [noderef] __rcu *filter_hash
   kernel/trace/ftrace.c:1328:37: sparse:     got struct ftrace_hash *
   kernel/trace/ftrace.c:1329:38: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct ftrace_hash [noderef] __rcu *notrace_hash @@     got struct ftrace_hash * @@
   kernel/trace/ftrace.c:1329:38: sparse:     expected struct ftrace_hash [noderef] __rcu *notrace_hash
   kernel/trace/ftrace.c:1329:38: sparse:     got struct ftrace_hash *
   kernel/trace/ftrace.c:2141:54: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct ftrace_hash *old_hash @@     got struct ftrace_hash [noderef] __rcu *filter_hash @@
   kernel/trace/ftrace.c:2141:54: sparse:     expected struct ftrace_hash *old_hash
   kernel/trace/ftrace.c:2141:54: sparse:     got struct ftrace_hash [noderef] __rcu *filter_hash
   kernel/trace/ftrace.c:1533:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/trace/ftrace.c:1533:9: sparse:    struct ftrace_hash [noderef] __rcu *
   kernel/trace/ftrace.c:1533:9: sparse:    struct ftrace_hash *
   kernel/trace/ftrace.c:1549:39: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct ftrace_hash *hash @@     got struct ftrace_hash [noderef] __rcu *filter_hash @@
   kernel/trace/ftrace.c:1550:40: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct ftrace_hash *hash @@     got struct ftrace_hash [noderef] __rcu *filter_hash @@
   kernel/trace/ftrace.c:1551:40: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct ftrace_hash *hash @@     got struct ftrace_hash [noderef] __rcu *notrace_hash @@
   kernel/trace/ftrace.c:1552:42: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct ftrace_hash *hash @@     got struct ftrace_hash [noderef] __rcu *notrace_hash @@
   kernel/trace/ftrace.c:1723:18: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct ftrace_ops *ops @@     got struct ftrace_ops [noderef] __rcu *[addressable] [toplevel] ftrace_ops_list @@
   kernel/trace/ftrace.c:1724:43: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct ftrace_ops *ops @@     got struct ftrace_ops [noderef] __rcu *next @@
   kernel/trace/ftrace.c:1785:14: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct ftrace_hash *hash @@     got struct ftrace_hash [noderef] __rcu *filter_hash @@
   kernel/trace/ftrace.c:1786:22: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct ftrace_hash *notrace_hash @@     got struct ftrace_hash [noderef] __rcu *notrace_hash @@
   kernel/trace/ftrace.c:2119:50: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct ftrace_hash *hash @@     got struct ftrace_hash [noderef] __rcu *filter_hash @@
   kernel/trace/ftrace.c:2130:50: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct ftrace_hash *hash @@     got struct ftrace_hash [noderef] __rcu *filter_hash @@
   kernel/trace/ftrace.c:2613:53: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct ftrace_hash [noderef] __rcu *static [toplevel] direct_functions @@     got struct ftrace_hash * @@
   kernel/trace/ftrace.c:2624:36: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct ftrace_hash *hash @@     got struct ftrace_hash [noderef] __rcu *static [toplevel] direct_functions @@
   kernel/trace/ftrace.c:3425:51: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected struct ftrace_hash *B @@     got struct ftrace_hash [noderef] __rcu *filter_hash @@
   kernel/trace/ftrace.c:3426:66: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected struct ftrace_hash **orig_hash @@     got struct ftrace_hash [noderef] __rcu ** @@
   kernel/trace/ftrace.c:3432:52: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected struct ftrace_hash *B @@     got struct ftrace_hash [noderef] __rcu *notrace_hash @@
   kernel/trace/ftrace.c:3433:66: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected struct ftrace_hash **orig_hash @@     got struct ftrace_hash [noderef] __rcu ** @@
   kernel/trace/ftrace.c:3446:41: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct ftrace_hash *hash @@     got struct ftrace_hash [noderef] __rcu *filter_hash @@
   kernel/trace/ftrace.c:3447:51: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct ftrace_hash *src @@     got struct ftrace_hash [noderef] __rcu *filter_hash @@
   kernel/trace/ftrace.c:3450:52: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected struct ftrace_hash *notrace_hash @@     got struct ftrace_hash [noderef] __rcu *notrace_hash @@
   kernel/trace/ftrace.c:3454:52: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct ftrace_hash *src @@     got struct ftrace_hash [noderef] __rcu *notrace_hash @@
   kernel/trace/ftrace.c:3469:39: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct ftrace_hash *hash @@     got struct ftrace_hash [noderef] __rcu *filter_hash @@
   kernel/trace/ftrace.c:3470:42: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct ftrace_hash *hash @@     got struct ftrace_hash [noderef] __rcu *filter_hash @@
   kernel/trace/ftrace.c:3478:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct ftrace_hash *hash @@     got struct ftrace_hash [noderef] __rcu *notrace_hash @@
   kernel/trace/ftrace.c:3484:81: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected struct ftrace_hash *hash @@     got struct ftrace_hash [noderef] __rcu *filter_hash @@
   kernel/trace/ftrace.c:3488:54: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected struct ftrace_hash *notrace_hash @@     got struct ftrace_hash [noderef] __rcu *notrace_hash @@
   kernel/trace/ftrace.c:3490:56: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected struct ftrace_hash *new_hash @@     got struct ftrace_hash [noderef] __rcu *filter_hash @@
   kernel/trace/ftrace.c:3520:60: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected struct ftrace_hash *new_hash1 @@     got struct ftrace_hash [noderef] __rcu *notrace_hash @@
   kernel/trace/ftrace.c:3521:49: sparse: sparse: incorrect type in argument 3 (different address spaces) @@     expected struct ftrace_hash *new_hash2 @@     got struct ftrace_hash [noderef] __rcu *notrace_hash @@
   kernel/trace/ftrace.c:3560:45: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct ftrace_hash [noderef] __rcu *filter_hash @@     got struct ftrace_hash * @@
   kernel/trace/ftrace.c:3562:46: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct ftrace_hash [noderef] __rcu *notrace_hash @@     got struct ftrace_hash * @@
   kernel/trace/ftrace.c:3564:48: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct ftrace_hash [noderef] __rcu *filter_hash @@     got struct ftrace_hash * @@
   kernel/trace/ftrace.c:3566:49: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct ftrace_hash [noderef] __rcu *notrace_hash @@     got struct ftrace_hash * @@
   kernel/trace/ftrace.c:3572:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct ftrace_hash *hash @@     got struct ftrace_hash [noderef] __rcu *filter_hash @@
   kernel/trace/ftrace.c:3573:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct ftrace_hash *hash @@     got struct ftrace_hash [noderef] __rcu *notrace_hash @@
   kernel/trace/ftrace.c:3579:34: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct ftrace_hash *save_filter_hash @@     got struct ftrace_hash [noderef] __rcu *filter_hash @@
   kernel/trace/ftrace.c:3580:35: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct ftrace_hash *save_notrace_hash @@     got struct ftrace_hash [noderef] __rcu *notrace_hash @@
   kernel/trace/ftrace.c:3582:45: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct ftrace_hash [noderef] __rcu *filter_hash @@     got struct ftrace_hash *[addressable] filter_hash @@
   kernel/trace/ftrace.c:3583:46: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct ftrace_hash [noderef] __rcu *notrace_hash @@     got struct ftrace_hash *[addressable] notrace_hash @@
   kernel/trace/ftrace.c:3588:53: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct ftrace_hash [noderef] __rcu *filter_hash @@     got struct ftrace_hash *save_filter_hash @@
   kernel/trace/ftrace.c:3589:54: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct ftrace_hash [noderef] __rcu *notrace_hash @@     got struct ftrace_hash *save_notrace_hash @@
   kernel/trace/ftrace.c:3636:31: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct ftrace_hash [noderef] __rcu *filter_hash @@     got struct ftrace_hash * @@
   kernel/trace/ftrace.c:3637:32: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct ftrace_hash [noderef] __rcu *notrace_hash @@     got struct ftrace_hash * @@
   kernel/trace/ftrace.c:3652:59: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct ftrace_hash *hash @@     got struct ftrace_hash [noderef] __rcu *[addressable] filter_hash @@
   kernel/trace/ftrace.c:3653:59: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct ftrace_hash *hash @@     got struct ftrace_hash [noderef] __rcu *[addressable] notrace_hash @@
   kernel/trace/ftrace.c:3658:43: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct ftrace_hash *hash @@     got struct ftrace_hash [noderef] __rcu *[addressable] filter_hash @@
   kernel/trace/ftrace.c:3659:43: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct ftrace_hash *hash @@     got struct ftrace_hash [noderef] __rcu *[addressable] notrace_hash @@
   kernel/trace/ftrace.c:3661:39: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct ftrace_hash [noderef] __rcu *[addressable] filter_hash @@     got struct ftrace_hash * @@
   kernel/trace/ftrace.c:3662:40: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct ftrace_hash [noderef] __rcu *[addressable] notrace_hash @@     got struct ftrace_hash * @@
   kernel/trace/ftrace.c:3704:48: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct ftrace_hash *hash @@     got struct ftrace_hash [noderef] __rcu *filter_hash @@
   kernel/trace/ftrace.c:3705:48: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct ftrace_hash *hash @@     got struct ftrace_hash [noderef] __rcu *notrace_hash @@
   kernel/trace/ftrace.c:3706:45: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct ftrace_hash [noderef] __rcu *filter_hash @@     got struct ftrace_hash * @@
   kernel/trace/ftrace.c:3707:46: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct ftrace_hash [noderef] __rcu *notrace_hash @@     got struct ftrace_hash * @@
   kernel/trace/ftrace.c:3993:14: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct ftrace_hash *hash @@     got struct ftrace_hash [noderef] __rcu *filter_hash @@
   kernel/trace/ftrace.c:4010:22: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct ftrace_hash *hash @@     got struct ftrace_hash [noderef] __rcu *filter_hash @@
   kernel/trace/ftrace.c:4699:22: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct ftrace_hash *hash @@     got struct ftrace_hash [noderef] __rcu *notrace_hash @@
   kernel/trace/ftrace.c:4702:22: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct ftrace_hash *hash @@     got struct ftrace_hash [noderef] __rcu *filter_hash @@
   kernel/trace/ftrace.c:5113:27: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct ftrace_hash **orig_hash @@     got struct ftrace_hash [noderef] __rcu ** @@
   kernel/trace/ftrace.c:5115:27: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct ftrace_hash **orig_hash @@     got struct ftrace_hash [noderef] __rcu ** @@
   kernel/trace/ftrace.c:5495:19: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct ftrace_hash **orig_hash @@     got struct ftrace_hash [noderef] __rcu ** @@
   kernel/trace/ftrace.c:5639:19: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct ftrace_hash **orig_hash @@     got struct ftrace_hash [noderef] __rcu ** @@
   kernel/trace/ftrace.c:5645:34: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct ftrace_hash [noderef] __rcu *filter_hash @@     got struct ftrace_hash *[assigned] old_hash @@
   kernel/trace/ftrace.c:5910:27: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct ftrace_hash **orig_hash @@     got struct ftrace_hash [noderef] __rcu ** @@
   kernel/trace/ftrace.c:5912:27: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct ftrace_hash **orig_hash @@     got struct ftrace_hash [noderef] __rcu ** @@
   kernel/trace/ftrace.c:5993:50: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct ftrace_hash *hash @@     got struct ftrace_hash [noderef] __rcu *static [toplevel] direct_functions @@
   kernel/trace/ftrace.c:5996:51: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct ftrace_hash *hash @@     got struct ftrace_hash [noderef] __rcu *static [toplevel] direct_functions @@
   kernel/trace/ftrace.c:6012:50: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct ftrace_hash *hash @@     got struct ftrace_hash [noderef] __rcu *filter_hash @@
   kernel/trace/ftrace.c:6056:14: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct ftrace_hash *hash @@     got struct ftrace_hash [noderef] __rcu *filter_hash @@
   kernel/trace/ftrace.c:6106:19: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct ftrace_hash *free_hash @@     got struct ftrace_hash [noderef] __rcu *static [toplevel] direct_functions @@
   kernel/trace/ftrace.c:6171:50: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct ftrace_hash *hash @@     got struct ftrace_hash [noderef] __rcu *filter_hash @@
   kernel/trace/ftrace.c:6209:52: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct ftrace_hash *hash @@     got struct ftrace_hash [noderef] __rcu *static [addressable] [assigned] [toplevel] direct_functions @@
   kernel/trace/ftrace.c:6357:48: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct ftrace_hash *hash @@     got struct ftrace_hash [noderef] __rcu *static [addressable] [assigned] [toplevel] direct_functions @@
   kernel/trace/ftrace.c:6362:25: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct ftrace_hash *old_filter_hash @@     got struct ftrace_hash [noderef] __rcu * @@
   kernel/trace/ftrace.c:6378:41: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct ftrace_hash *a @@     got struct ftrace_hash [noderef] __rcu *static [addressable] [assigned] [toplevel] direct_functions @@
   kernel/trace/ftrace.c:6382:30: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct ftrace_hash *old_direct_functions @@     got struct ftrace_hash [noderef] __rcu *static [addressable] [assigned] [toplevel] direct_functions @@
   kernel/trace/ftrace.c:6389:45: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct ftrace_hash [noderef] __rcu *filter_hash @@     got struct ftrace_hash *[assigned] new_filter_hash @@
   kernel/trace/ftrace.c:6394:53: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct ftrace_hash [noderef] __rcu *filter_hash @@     got struct ftrace_hash *old_filter_hash @@
   kernel/trace/ftrace.c:6489:30: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/trace/ftrace.c:6489:30: sparse:    struct ftrace_hash [noderef] __rcu *
   kernel/trace/ftrace.c:6489:30: sparse:    struct ftrace_hash *
   kernel/trace/ftrace.c:6503:50: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct ftrace_hash *hash @@     got struct ftrace_hash [noderef] __rcu *static [addressable] [assigned] [toplevel] direct_functions @@
   kernel/trace/ftrace.c:6514:41: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct ftrace_hash *a @@     got struct ftrace_hash [noderef] __rcu *static [addressable] [assigned] [toplevel] direct_functions @@
>> kernel/trace/ftrace.c:6540:38: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct ftrace_hash *[assigned] old_direct_functions @@     got struct ftrace_hash [noderef] __rcu *static [addressable] [assigned] [toplevel] direct_functions @@
   kernel/trace/ftrace.c:6589:30: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/trace/ftrace.c:6589:30: sparse:    struct ftrace_hash [noderef] __rcu *
   kernel/trace/ftrace.c:6589:30: sparse:    struct ftrace_hash *
   kernel/trace/ftrace.c:6969:35: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct ftrace_hash **orig_hash @@     got struct ftrace_hash [noderef] __rcu ** @@
   kernel/trace/ftrace.c:6977:35: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct ftrace_hash **orig_hash @@     got struct ftrace_hash [noderef] __rcu ** @@
   kernel/trace/ftrace.c:7762:46: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct ftrace_hash *hash @@     got struct ftrace_hash [noderef] __rcu *filter_hash @@
   kernel/trace/ftrace.c:7763:47: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct ftrace_hash *hash @@     got struct ftrace_hash [noderef] __rcu *filter_hash @@
   kernel/trace/ftrace.c:7767:44: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct ftrace_hash *hash @@     got struct ftrace_hash [noderef] __rcu *notrace_hash @@
   kernel/trace/ftrace.c:7785:18: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct ftrace_ops *ops @@     got struct ftrace_ops [noderef] __rcu *[addressable] [toplevel] ftrace_ops_list @@
   kernel/trace/ftrace.c:7785:66: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct ftrace_ops *ops @@     got struct ftrace_ops [noderef] __rcu *next @@
   kernel/trace/ftrace.c:7837:59: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected struct ftrace_hash *hash @@     got struct ftrace_hash [noderef] __rcu *filter_hash @@
   kernel/trace/ftrace.c:7838:59: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected struct ftrace_hash *hash @@     got struct ftrace_hash [noderef] __rcu *notrace_hash @@
   kernel/trace/ftrace.c:8227:62: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected struct ftrace_hash *hash @@     got struct ftrace_hash [noderef] __rcu *filter_hash @@
   kernel/trace/ftrace.c:8228:62: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected struct ftrace_hash *hash @@     got struct ftrace_hash [noderef] __rcu *notrace_hash @@
   kernel/trace/ftrace.c:8272:36: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/trace/ftrace.c:8272:36: sparse:    struct ftrace_ops [noderef] __rcu *
   kernel/trace/ftrace.c:8272:36: sparse:    struct ftrace_ops *
   kernel/trace/ftrace.c:9048:14: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct ftrace_hash *hash @@     got struct ftrace_hash [noderef] __rcu *filter_hash @@
   kernel/trace/ftrace.c:9048:14: sparse:     expected struct ftrace_hash *hash
   kernel/trace/ftrace.c:9048:14: sparse:     got struct ftrace_hash [noderef] __rcu *filter_hash
   kernel/trace/ftrace.c:9097:14: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct ftrace_hash *hash @@     got struct ftrace_hash [noderef] __rcu *filter_hash @@
   kernel/trace/ftrace.c:9097:14: sparse:     expected struct ftrace_hash *hash
   kernel/trace/ftrace.c:9097:14: sparse:     got struct ftrace_hash [noderef] __rcu *filter_hash
   kernel/trace/ftrace.c:230:20: sparse: sparse: dereference of noderef expression
   kernel/trace/ftrace.c:230:20: sparse: sparse: dereference of noderef expression
   kernel/trace/ftrace.c:230:20: sparse: sparse: dereference of noderef expression
   kernel/trace/ftrace.c:3480:29: sparse: sparse: dereference of noderef expression
   kernel/trace/ftrace.c:3480:29: sparse: sparse: dereference of noderef expression
   kernel/trace/ftrace.c:3480:29: sparse: sparse: dereference of noderef expression
   kernel/trace/ftrace.c:3480:29: sparse: sparse: dereference of noderef expression
   kernel/trace/ftrace.c:3480:29: sparse: sparse: dereference of noderef expression
   kernel/trace/ftrace.c:3480:29: sparse: sparse: dereference of noderef expression
   kernel/trace/ftrace.c:3514:29: sparse: sparse: dereference of noderef expression
   kernel/trace/ftrace.c:3514:29: sparse: sparse: dereference of noderef expression
   kernel/trace/ftrace.c:3514:29: sparse: sparse: dereference of noderef expression
   kernel/trace/ftrace.c:3514:29: sparse: sparse: dereference of noderef expression
   kernel/trace/ftrace.c:3514:29: sparse: sparse: dereference of noderef expression
   kernel/trace/ftrace.c:3514:29: sparse: sparse: dereference of noderef expression
   kernel/trace/ftrace.c:6074:30: sparse: sparse: dereference of noderef expression
   kernel/trace/ftrace.c:6083:21: sparse: sparse: dereference of noderef expression
   kernel/trace/ftrace.c:6085:17: sparse: sparse: dereference of noderef expression
   kernel/trace/ftrace.c:3785:48: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct ftrace_hash *hash @@     got struct ftrace_hash [noderef] __rcu *filter_hash @@
   kernel/trace/ftrace.c:3785:48: sparse:     expected struct ftrace_hash *hash
   kernel/trace/ftrace.c:3785:48: sparse:     got struct ftrace_hash [noderef] __rcu *filter_hash
   kernel/trace/ftrace.c:3786:49: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct ftrace_hash *hash @@     got struct ftrace_hash [noderef] __rcu *notrace_hash @@
   kernel/trace/ftrace.c:3786:49: sparse:     expected struct ftrace_hash *hash
   kernel/trace/ftrace.c:3786:49: sparse:     got struct ftrace_hash [noderef] __rcu *notrace_hash

vim +6540 kernel/trace/ftrace.c

  6457	
  6458	/**
  6459	 * update_ftrace_direct_del - Updates @ops by removing its direct
  6460	 * callers provided in @hash
  6461	 * @ops: The address of the struct ftrace_ops object
  6462	 * @hash: The address of the struct ftrace_hash object
  6463	 *
  6464	 * This is used to delete custom direct callers (ip -> addr) in
  6465	 * @ops specified via @hash. The @ops will be either unregistered
  6466	 * updated.
  6467	 *
  6468	 * Returns: zero on success. Non zero on error, which includes:
  6469	 *  -EINVAL - The @hash is empty
  6470	 *  -EINVAL - The @ops is not registered
  6471	 */
  6472	int update_ftrace_direct_del(struct ftrace_ops *ops, struct ftrace_hash *hash)
  6473	{
  6474		struct ftrace_hash *old_direct_functions = NULL;
  6475		struct ftrace_hash *new_direct_functions;
  6476		struct ftrace_hash *new_filter_hash = NULL;
  6477		struct ftrace_hash *old_filter_hash;
  6478		struct ftrace_func_entry *entry;
  6479		struct ftrace_func_entry *del;
  6480		unsigned long size;
  6481		int err = -EINVAL;
  6482	
  6483		if (!hash_count(hash))
  6484			return -EINVAL;
  6485		if (check_direct_multi(ops))
  6486			return -EINVAL;
  6487		if (!(ops->flags & FTRACE_OPS_FL_ENABLED))
  6488			return -EINVAL;
  6489		if (direct_functions == EMPTY_HASH)
  6490			return -EINVAL;
  6491	
  6492		mutex_lock(&direct_mutex);
  6493	
  6494		old_filter_hash = ops->func_hash ? ops->func_hash->filter_hash : NULL;
  6495	
  6496		if (!hash_count(old_filter_hash))
  6497			goto out_unlock;
  6498	
  6499		/* Make sure requested entries are already registered. */
  6500		size = 1 << hash->size_bits;
  6501		for (int i = 0; i < size; i++) {
  6502			hlist_for_each_entry(entry, &hash->buckets[i], hlist) {
  6503				del = __ftrace_lookup_ip(direct_functions, entry->ip);
  6504				if (!del || del->direct != entry->direct)
  6505					goto out_unlock;
  6506			}
  6507		}
  6508	
  6509		err = -ENOMEM;
  6510		new_filter_hash = hash_sub(old_filter_hash, hash);
  6511		if (!new_filter_hash)
  6512			goto out_unlock;
  6513	
  6514		new_direct_functions = hash_sub(direct_functions, hash);
  6515		if (!new_direct_functions)
  6516			goto out_unlock;
  6517	
  6518		/* If there's nothing left, we need to unregister the ops. */
  6519		if (ftrace_hash_empty(new_filter_hash)) {
  6520			err = unregister_ftrace_function(ops);
  6521			if (!err) {
  6522				/* cleanup for possible another register call */
  6523				ops->func = NULL;
  6524				ops->trampoline = 0;
  6525				ftrace_free_filter(ops);
  6526				ops->func_hash->filter_hash = NULL;
  6527			}
  6528		} else {
  6529			err = ftrace_update_ops(ops, new_filter_hash, EMPTY_HASH);
  6530			/*
  6531			 * new_filter_hash is dup-ed, so we need to release it anyway,
  6532			 * old_filter_hash either stays on error or is already released
  6533			 */
  6534		}
  6535	
  6536		if (err) {
  6537			/* free the new_direct_functions */
  6538			old_direct_functions = new_direct_functions;
  6539		} else {
> 6540			old_direct_functions = direct_functions;
  6541			rcu_assign_pointer(direct_functions, new_direct_functions);
  6542		}
  6543	
  6544	 out_unlock:
  6545		mutex_unlock(&direct_mutex);
  6546	
  6547		if (old_direct_functions && old_direct_functions != EMPTY_HASH)
  6548			call_rcu_tasks(&old_direct_functions->rcu, register_ftrace_direct_cb);
  6549		free_ftrace_hash(new_filter_hash);
  6550	
  6551		return err;
  6552	}
  6553	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
