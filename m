Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.17
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794363682;
	b=Bx895vBOb9m1pFgfUYcuVcwdhLu1Sv80M0tEbWncj9VVD0xooSle3XnqoT9zq4QrfSqY
	 1H20cjjpnBogctm03Of+gwhjeANWqv7xRpEYGWeBgOfVzM9iS6U+j1LjX0Hvo86TscBcf
	 MK/DrdkhcZaqUH+gq73nnC5S/Bx5K9+DoBcxI9vOvr1+m8XB9K8WjO9LPEa+s8LtXHm9s
	 gU2/eDCfcozUAYl9F1qlB22vsch5wmo8yUiceMTSmktvHvilbHm+1AUaiF+oaBLB9AYif
	 abLKNlSXhVp76UeZAt4VjJIJvbJXW+fTHn1s8PpYRNZsm/MevDPpUnKWZ4ug86dS4hA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794363682;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=WJbesFIYlpH1gBWGhFnOLKrK8EWw7z9yvLVG93BvJhk=;
	b=Nb0n1lfJhZVhwfDY+cxH3LJobUHFfJEm1sIDThr8rPlc+xiT+41l47CvLGOKoU3LPmdd
	 NFvV+Y+GDPnHZ/EYSitZ/ICWDtKCGflqetCxuEUeUIn9hZaRpqueY11mdWteqaM1vz/pR
	 esK7Z7gHTroxsn8d2i6wBqzZnOuEe9771SpH1fh+8wOqilxQSVTidwz1J6UyGfhbCsSPr
	 7aT0GgfcTGUVt6cjcyD1c/86CRs2+M2PZYN4UmWrwTIlRQbCC0CIuzw7IAJUNbp3/AnXK
	 4MySP2djriFAUGZGuKgrhBYT9VPYO7leagncadnRWskYXY4y1sp7hVJGsZbZAq8Uo6Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=H1BAPK3e;
	arc=none smtp.remote-ip=198.175.65.17
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72137606A335;
	Wed, 11 Nov 2026 02:21:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 72137606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=H1BAPK3e
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794363682; x=1825899682;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=w+Xr+QzMFDzwse/PNcCw0jqlWFmK5mh/TodzvCIlmX4=;
  b=H1BAPK3ezf6vDifk0ZEN4Nv8DsUPZbBi4Hjs4SjKd6sI2Viaw4NKpFHy
   4lquMYBTFn+GwCUHVoTz/5P61s2mISQxn3Aed0myBYkv304taYIoYNaFZ
   hJDHJZMVXF20nxuq9VsPtND7E2TSCJ1hCFmGQRhs1NWgv7NOujQjr6lre
   dGoE3vFN2Ar1VUe3k8Yh3vjPldxEaH3Z2xieXaB9EG0zFahndHG2z7DKs
   7qBQvGo7USaPyMeSM3y9rBaUB7y0Mraw/mOX+efylOU5WpNcH3lpFTebp
   zg2CljP0DbI6qKgokrazDEQ4Ng/Mlo3I6osLG/Dwd6MWyznvsowL3jZpA
   A==;
X-CSE-ConnectionGUID: BH/mHbQyQlmqkf/7OWh6uw==
X-CSE-MsgGUID: eYgbRsIBRD2htPutqLnAwQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11962"; a="3153920"
X-IronPort-AV: E=Sophos;i="6.27,207,1787036400"; 
   d="scan'208";a="3153920"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2026 18:21:22 -0800
X-CSE-ConnectionGUID: /Psi1CagQMSAizsJ6rTKlA==
X-CSE-MsgGUID: jhs4LrhCQpuiSFsIXmJsnw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,207,1787036400"; 
   d="scan'208";a="8643043"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 10 Nov 2026 18:21:18 -0800
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xQxxa-00000000xtr-2qFM;
	Wed, 11 Nov 2026 02:21:14 +0000
Date: Wed, 11 Nov 2026 10:20:16 +0800
From: kernel test robot <lkp@intel.com>
To: Jiri Olsa <jolsa@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>,
	Naveen N Rao <naveen@kernel.org>,
	"David S. Miller" <davem@davemloft.net>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	netdev@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Jason Baron <jbaron@akamai.com>, Alice Ryhl <aliceryhl@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ard Biesheuvel <ardb@kernel.org>, Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>, Alan Maguire <almagui@kernel.org>,
	x86@kernel.org, linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH 13/13] samples/kprobes: Add batch probe example
Message-ID: <202611110929.bmBlvfbY-lkp@intel.com>
References: <20261109195827.1091410-1-jolsa@kernel.org>
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
In-Reply-To: <20261109195827.1091410-1-jolsa@kernel.org>

Hi Jiri,

kernel test robot noticed the following build warnings:

[auto build test WARNING on trace/for-next]
[also build test WARNING on linus/master v7.4-rc2 next-20261109]
[cannot apply to tip/x86/core]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Jiri-Olsa/static_call-Index-code-text-reservation-lookups/20261109-204904
base:   https://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace for-next
patch link:    https://lore.kernel.org/r/20261109195827.1091410-1-jolsa%40kernel.org
patch subject: [PATCH 13/13] samples/kprobes: Add batch probe example
config: x86_64-allmodconfig (https://download.01.org/0day-ci/archive/20261111/202611110929.bmBlvfbY-lkp@intel.com/config)
compiler: clang version 22.1.8 (https://github.com/llvm/llvm-project ca7933e47d3a3451d81e72ac174dcb5aa28b59d1)
rustc: rustc 1.96.0 (ac68faa20 2026-05-25)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261111/202611110929.bmBlvfbY-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202611110929.bmBlvfbY-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> samples/kprobes/kprobe_many_example.o: warning: objtool: kprobe_many_call_function+0x1f: no-cfi indirect call!

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
