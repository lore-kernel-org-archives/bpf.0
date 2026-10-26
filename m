Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793025891;
	b=fvJ1dqRyDkLmaxcmiHO41FAQ4+L/6UsAr1Z8lLDlSBAzUtgvZsxdXqj6CBkMZX3H9APZ
	 IpZfHoMMG7bi8KqfjNUO0fYYe9Gz9QiUzFn6RqnJIkBMPOGIATqdata6nNB2PwozAidte
	 pktJmcojVfexNkvUCSDp4zN8PB43y2oXpfb8ERbg9tSVIQpNsQ9fDwyYIXOXpEqtVX+sK
	 sI7PNfsvZpPNY0U1APSSBzR9IBH8uqnlJL6KXiaY7+b+idg1KpPG3YJ/iGEkIHS+U2zWV
	 BN3jkoW+0T7rltp7KZxytg3XA1u5XSjsF3so+t/GDdJsL8sY3KI6TfKTY/JlVrEMh0Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793025891;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=OdAPy/CoPz/vfWZ7wRu1j+eYID0az22RSj0i/Go1qnw=;
	b=4gwPUu919Vz877hlugWEqiu5kZxTIyyDEEmIxrdzNjgee6vPmEtoA/Qzq+VQV2G3HOiY
	 skhzZdNiu7lP5l8kQEtMLKcuK05un67oAoUgDnGuKa5raeOUXN5t4zJmNlA6oYriIF/QL
	 mgcM85jsRUIdr6rGL6HadEGNLfuHtTd/tiFLGuVqeFabTyl2/es4u9gHM2K2B+b9c6oiR
	 WvgDa7SpMHTRrCza/CSTK1toiyltcuwc+osG+uM2i6u2eTmIndcU4rgQCJr9V9/waqu6m
	 0wIwI2q5GOXkJjSkGW7C/M1Cytf6SfKpoL7toVbGWuItRkvmRfDai8s1rrlvjXdUDnw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=kyNjs3ta;
	arc=none smtp.remote-ip=198.175.65.14
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FFF6606A32E
	for <bpf@vger.kernel.org>; Mon, 26 Oct 2026 14:44:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4FFF6606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=kyNjs3ta
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793025890; x=1824561890;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8TsUWj36XD1mav8rJ6nSKUgTGR7eWwxtagWA+FEHNFI=;
  b=kyNjs3tapG5sFl+/9wDiX3FNCxkr2MS+Hjp3EMceczU5njjVNwS6fdOi
   zviwvUKryJR3rbIBtf6kD8lOSTkixgFyjQ2PNoOr8FS9lNdFzUEGtS48o
   LqNfsHcJQyRFVfqxPILzevP+/yI6iHv3rs01NiKxnDnMT4a1wWwGyCXpH
   u8QYu4zmUMPG3xR/jqqIHhSQbRcQzcD0CfjimwD+L7Bwp+FE7R+uMYOj1
   U2YK+4xOVv1kbhaqlLgmLQouq4O7il5nGyA4p/MPsqHaaUc4ebWgqh3C9
   cXZpNr+FfI1/ZNVWxWe3Him80UvRwmj2IL1KobPut3FStrUFhktDDHrfj
   g==;
X-CSE-ConnectionGUID: aFmX7o3QTSS83J8BlrVL2g==
X-CSE-MsgGUID: P1KGbtn8RAeDqVQ4ut/Vww==
X-IronPort-AV: E=McAfee;i="6800,10657,11947"; a="1571155"
X-IronPort-AV: E=Sophos;i="6.27,179,1787036400"; 
   d="scan'208";a="1571155"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2026 07:44:50 -0700
X-CSE-ConnectionGUID: +0iof/m5TlKvDtfl6P1bWQ==
X-CSE-MsgGUID: wiHeEfSzRta+QfuDd07drw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,179,1787036400"; 
   d="scan'208";a="4431735"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 26 Oct 2026 07:44:48 -0700
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xLLwK-00000000W4Q-3vjC;
	Mon, 26 Oct 2026 14:44:44 +0000
Date: Mon, 26 Oct 2026 22:43:55 +0800
From: kernel test robot <lkp@intel.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com,
	memxor@gmail.com
Subject: Re: [PATCH bpf 07/81] bpf: One time slice of may_goto for a run of a
 prog
Message-ID: <202610262241.4DF09B1A-lkp@intel.com>
References: <20261026025943.404450-8-alexei.starovoitov@gmail.com>
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
In-Reply-To: <20261026025943.404450-8-alexei.starovoitov@gmail.com>

Hi Alexei,

kernel test robot noticed the following build warnings:

[auto build test WARNING on bpf/master]

url:    https://github.com/intel-lab-lkp/linux/commits/Alexei-Starovoitov/selftests-bpf-Remove-tests-for-global-data-in-arena/20261026-025822
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git master
patch link:    https://lore.kernel.org/r/20261026025943.404450-8-alexei.starovoitov%40gmail.com
patch subject: [PATCH bpf 07/81] bpf: One time slice of may_goto for a run of a prog
config: um-defconfig (https://download.01.org/0day-ci/archive/20261026/202610262241.4DF09B1A-lkp@intel.com/config)
compiler: clang version 24.0.0git (https://github.com/llvm/llvm-project 186e70f4e6a1521991d2340d3d49b23b1beff11f)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261026/202610262241.4DF09B1A-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202610262241.4DF09B1A-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> kernel/bpf/core.c:3633:6: warning: no previous prototype for function 'bpf_prog_begin_run' [-Wmissing-prototypes]
    3633 | void bpf_prog_begin_run(const struct bpf_prog *prog)
         |      ^
   kernel/bpf/core.c:3633:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
    3633 | void bpf_prog_begin_run(const struct bpf_prog *prog)
         | ^
         | static 
   1 warning generated.


vim +/bpf_prog_begin_run +3633 kernel/bpf/core.c

  3628	
  3629	/*
  3630	 * The kernel is about to call an async callback of @prog on this cpu: a run begins.
  3631	 * The main prog does the same in its first insns.
  3632	 */
> 3633	void bpf_prog_begin_run(const struct bpf_prog *prog)
  3634	{
  3635		struct bpf_prog_aux *aux;
  3636	
  3637		if (!prog)
  3638			return;
  3639		aux = prog->aux->main_prog_aux;
  3640		if (aux->may_goto_budget) {
  3641			this_cpu_write(aux->may_goto_budget->start, 0);
  3642			this_cpu_write(aux->may_goto_budget->count, BPF_MAX_TIMED_LOOPS);
  3643		}
  3644	}
  3645	

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
