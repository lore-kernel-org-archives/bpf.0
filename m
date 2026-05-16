Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77E71405C31
	for <bpf@vger.kernel.org>; Sat, 16 May 2026 09:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778925332; cv=none; b=iVDfsitt5zFgrIgy4xW9ubQ07dY6xjgRiQ/zoQXvMuFNPfim0JyGwGYDvSlZKymSC4QuWXLAPzGRlFjOMZ9gurnqEHjpxGOzztVE5k+QJwSVREYVVs1hqs7n8X7vAlrEJoT9T4BVyzxoWOJizmcbhIWQLdQYKldha7UMnBGSkEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778925332; c=relaxed/simple;
	bh=m6wEiREUyUE10X93cxJMGF8m43jMJSQQdgOV37LTUig=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=urEGr7mGZWkmvsmuJGoFAG16+B5RwzFmSamYOZLr4AbvnhOL+QPRW5wCuuQU6MyyXTw7+0NXs21qILJLVPJ7pvz/w+bLkxgnb4Aq08gZGbNwhYq7NLdc993Uwo3Ln9h0NW6Jt+4kerlvaIrwDerYJ4gNPmQevC+hdfnNGBB0foE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bxWKspBh; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bxWKspBh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778925331; x=1810461331;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=m6wEiREUyUE10X93cxJMGF8m43jMJSQQdgOV37LTUig=;
  b=bxWKspBht+XahpynsWH1k83RJxExBEyLY8HEPNln3aJqtYVraRcjpsB7
   wp3p13S48TxzD3VXNLnQu6l5GMqhlcWMyvyxSGhCEavPH0nNUQcG9ClOI
   iZ3RZGVtdf/Yu3uW7vbyo4twbIYZYGuDDtJsxDS9OduOb5pi5+eHxEory
   8vDDKv4QEQhgM252dsxxxaCbvrGXhfzm0qckdDSLCgc2TRNmmHV0pU2ne
   neCQNNkoDjAUMFgC//CTOsUtGTTH+A1Io/UkaXSoBh/JvHYP+rG7UZCNk
   h5khTR3iFzPvG/cXl1hI3ouf8itIB9U+7m5TwUatBK6QuVKAoOWV1eUfi
   A==;
X-CSE-ConnectionGUID: gdm0xsrqSoi3cNz6Ho+cnA==
X-CSE-MsgGUID: J5XoDwepR4WWVldYX+XFng==
X-IronPort-AV: E=McAfee;i="6800,10657,11787"; a="90174060"
X-IronPort-AV: E=Sophos;i="6.23,238,1770624000"; 
   d="scan'208";a="90174060"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2026 02:55:30 -0700
X-CSE-ConnectionGUID: kttadIOuSIa31bXM8+hW8A==
X-CSE-MsgGUID: foAg92+QTZiArTK278xUgw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,238,1770624000"; 
   d="scan'208";a="235901402"
Received: from igk-lkp-server01.igk.intel.com (HELO bdf09bfdbd5f) ([10.211.93.152])
  by fmviesa007.fm.intel.com with ESMTP; 16 May 2026 02:55:28 -0700
Received: from kbuild by bdf09bfdbd5f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wOBjx-000000009Iz-18Iv;
	Sat, 16 May 2026 09:55:25 +0000
Date: Sat, 16 May 2026 11:54:50 +0200
From: kernel test robot <lkp@intel.com>
To: Mahe Tardy <mahe.tardy@gmail.com>, bpf@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	martin.lau@linux.dev, daniel@iogearbox.net,
	john.fastabend@gmail.com, ast@kernel.org, andrii@kernel.org,
	yonghong.song@linux.dev, jordan@jrife.io,
	Mahe Tardy <mahe.tardy@gmail.com>
Subject: Re: [PATCH bpf-next v5 4/4] selftests/bpf: add bpf_icmp_send
 recursion test
Message-ID: <202605161150.IlT3RNUq-lkp@intel.com>
References: <20260515194746.50920-5-mahe.tardy@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260515194746.50920-5-mahe.tardy@gmail.com>

Hi Mahe,

kernel test robot noticed the following build warnings:

[auto build test WARNING on bpf-next/master]
[also build test WARNING on bpf-next/net bpf/master linus/master v7.1-rc3 next-20260508]
[cannot apply to linux-review/Mahe-Tardy/net-move-netfilter-nf_reject_fill_skb_dst-to-core-ipv4/20260422-023045]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Mahe-Tardy/bpf-add-bpf_icmp_send-kfunc/20260516-035616
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
patch link:    https://lore.kernel.org/r/20260515194746.50920-5-mahe.tardy%40gmail.com
patch subject: [PATCH bpf-next v5 4/4] selftests/bpf: add bpf_icmp_send recursion test
config: x86_64-kexec (https://download.01.org/0day-ci/archive/20260516/202605161150.IlT3RNUq-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260516/202605161150.IlT3RNUq-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202605161150.IlT3RNUq-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> Warning: net/core/filter.c:12496 function parameter '__skb' not described in 'bpf_icmp_send'
>> Warning: net/core/filter.c:12496 function parameter '__skb' not described in 'bpf_icmp_send'

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
