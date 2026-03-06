Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30585382361
	for <bpf@vger.kernel.org>; Fri,  6 Mar 2026 11:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772798324; cv=none; b=hrwu/8j4LeIkhybeyZr/Vlf7AszORklAB3gB7U03gD5ZnoBHV6a/zf2oLIiM3g9Cad8JlHK5mDgTcepyKE596blkDiDMuOhvKkiWGHoG/di+KIs5S12vD3nRUpGJIWxquKkHmRYVbMUea5/1n/uTa5qKqi3/3bulbRIB/RdMEaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772798324; c=relaxed/simple;
	bh=+IpBwDCkQiYgOY4mGAQapVSzapoGq9dBftoL/SfGPB8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eIARdPMbEKmKvSgB8MMj1t9pZyMAPLITbQFmwNQbq8yzSxwdyoGvgObMd67/9kw0rYULv3DN9pgKoMXYxQNKDzOhGDBSP1kpQGM8hGepLQ5JfXgTl5atWMQfS+svteT52eQLQ5zP4/BY14fNXZ+uEZS66eVPJrx+UOkzd2BKPR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=K70u2WfB; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="K70u2WfB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772798322; x=1804334322;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+IpBwDCkQiYgOY4mGAQapVSzapoGq9dBftoL/SfGPB8=;
  b=K70u2WfBRW+X62J9cF20t6e+ADR4Hc97GaCLduXr00atFawXKRyKQUSR
   hqggjU3ChBQ1a2S0YcdlynEoMHLHd+tjMFQXzW/TTWzgNNCnr19CCUr2Q
   qQ2xJE2Tr9oj9OOBYFZukEWreUbdE+6GbCze2KwTP5eMLI1SEuTtFVhdE
   CTJI6LWBa4w+KrZrgAZag0gBfHEV5x2IAY6z0X/DocJwYY583++XU8U8k
   o2XpvQJKSx2nHX0gnJ1kj7YdvH+2z8YX8fl7SlgcEVICRPXK6yusUnT/T
   PL10AQs2A8ZFUlCO8bt+A0k57JvaMNlWhWjad+r6iXNagFDNOpDcaLMN3
   w==;
X-CSE-ConnectionGUID: 7pBNAkt2ThCgXPIzndwm6A==
X-CSE-MsgGUID: Fmcs/PieSFSQx6Dr9qiJkA==
X-IronPort-AV: E=McAfee;i="6800,10657,11720"; a="73095938"
X-IronPort-AV: E=Sophos;i="6.23,104,1770624000"; 
   d="scan'208";a="73095938"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2026 03:58:36 -0800
X-CSE-ConnectionGUID: 6XSjYh0pQOuFZMImCF6AtQ==
X-CSE-MsgGUID: NQ8TAN//QNCJEZMmnefSNA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,104,1770624000"; 
   d="scan'208";a="218224493"
Received: from lkp-server01.sh.intel.com (HELO 058beb05654c) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 06 Mar 2026 03:58:34 -0800
Received: from kbuild by 058beb05654c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vyTp9-000000000oL-37Wk;
	Fri, 06 Mar 2026 11:58:31 +0000
Date: Fri, 6 Mar 2026 19:57:46 +0800
From: kernel test robot <lkp@intel.com>
To: Jenny Guanni Qu <qguanni@gmail.com>, bpf@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, daniel@iogearbox.net, ast@kernel.org,
	andrii@kernel.org, Jenny Guanni Qu <qguanni@gmail.com>
Subject: Re: [PATCH v1 1/2] bpf: Fix undefined behavior in interpreter
 sdiv/smod for INT_MIN
Message-ID: <202603061940.T1ZYupw1-lkp@intel.com>
References: <20260306025600.870163-2-qguanni@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260306025600.870163-2-qguanni@gmail.com>

Hi Jenny,

kernel test robot noticed the following build warnings:

[auto build test WARNING on bpf-next/net]
[also build test WARNING on bpf-next/master bpf/master linus/master v7.0-rc2 next-20260305]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Jenny-Guanni-Qu/bpf-Fix-undefined-behavior-in-interpreter-sdiv-smod-for-INT_MIN/20260306-110344
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git net
patch link:    https://lore.kernel.org/r/20260306025600.870163-2-qguanni%40gmail.com
patch subject: [PATCH v1 1/2] bpf: Fix undefined behavior in interpreter sdiv/smod for INT_MIN
config: arc-randconfig-r072-20260306 (https://download.01.org/0day-ci/archive/20260306/202603061940.T1ZYupw1-lkp@intel.com/config)
compiler: arc-linux-gcc (GCC) 8.5.0
smatch: v0.5.0-9004-gb810ac53
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260306/202603061940.T1ZYupw1-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603061940.T1ZYupw1-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> Warning: kernel/bpf/core.c:1750 function parameter 'x' not described in '__safe_abs32'
>> Warning: kernel/bpf/core.c:1750 expecting prototype for ___bpf_prog_run(). Prototype was for __safe_abs32() instead

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
