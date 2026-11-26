Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.19
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795730981;
	b=15hBeIzxe+LO2/Zmw3H2tuThPb+e+pcXuFHbIzWKD82SM9Jx9Id7gwmAZDfu3UQ510Dh
	 W/fUCOjgqoL7LcVfYRqLPx1qDvkdzUCph5jsGejv5sbYRniE6zjxLm9kLSUZGDtLPe5/A
	 cFNqWr5UAU4GfaErHw2Qjrkvgt7B+XxhRGAcSl5xvEWkNHhN6df/xgvFrs4gwrVMvLnQQ
	 bou3nsgwrE1cPFJYIv+iDDrOHBkyOlQb8milL056yIG3GQf+W6J2AHk8W32iT973rw8Im
	 HtSzBCMISw1Vay7g/IdbUBKexxhulei+SdfiKRPKmUmAhuFZadp2dJx1cdygTOw3llg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795730981;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=HZhnmqSAPt49qmlu2oisQZMoTBfupFfujLhSckYglEQ=;
	b=KJ8xzV/G4yP8ItTuEe3ZFnVIGviY9IJihmf8jDsiVpZWYdHoa67YsG2J2Ar49jIEKLwl
	 LrQRQBNME38hUSmQXiPVx7xFvK6RG/AS1yz/zDTFD5320EwFo5xkQVm97lh8LSgAUv83d
	 ctkTZVPb4gLpURu9fInesQdnp1CVfdv97hx26qzFz9i7AtNyEnOfbZ+DIrrMj7Di8c+PX
	 az6UAStgeQjV3Ifb0ihjbqDNdJDpguowe4vUNP5sFne7u+R0gvYzrFTHEDJp7RnddxTx2
	 K6vBN5kvl7r7gdrKt2iguzd6VNpEoMsyudaC1FaGYVQ4KU2+PX8zUflNQPAfwHNrxvQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=eS1nb26A;
	arc=none smtp.remote-ip=192.198.163.19
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0BC7606A327;
	Thu, 26 Nov 2026 22:09:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C0BC7606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=eS1nb26A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795730981; x=1827266981;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Y1FrIwMJzQnQKtTx2fAkalLSx4xeVaURU10IeoBIfU0=;
  b=eS1nb26AkKUsrHyrxBzIuH6EpfMiqO7yWTyuQXU5A7hpejm+vLMWWHCg
   alrIip+WD21cxn6mk4BGSBqVF3QZ10HPqdS+rmwi0Yv+2NE9VqVo2QY3E
   TOCKuOwPdg18siuHUkCdfBc/fXNKtkQ4GJdYZMoaTuo7i6Aw83doTn0g5
   p3dyZzqwirFI61pt3Pf6eAGjxk4XSZzD/TxOQfnZGnI+iYtIBg/w/2t/N
   xY7zWxPU61s0nwNeg0XEqPUpGY1ElPC4wNE1qbmNIr3DlesyMfYjDvMD+
   2pjqAbVtJJ8PULhE8QdoAlkmsjO5y+ZuSh1kuHFVNoT8L1ahAj7HrQ1jt
   A==;
X-CSE-ConnectionGUID: lmp6ElVHQcOaZ0W06sbReA==
X-CSE-MsgGUID: 0h+iw7npT3qytiwZySgXHw==
X-IronPort-AV: E=McAfee;i="6800,10657,11978"; a="4661061"
X-IronPort-AV: E=Sophos;i="6.27,235,1787036400"; 
   d="scan'208";a="4661061"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2026 14:09:41 -0800
X-CSE-ConnectionGUID: gW5GhYWJTL+N3VD2IVZIJw==
X-CSE-MsgGUID: fOrOBiwPS7aTmzLnX7dzRg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,235,1787036400"; 
   d="scan'208";a="12592652"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 26 Nov 2026 14:09:37 -0800
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xWheo-00000001Uxc-15rV;
	Thu, 26 Nov 2026 22:09:34 +0000
Date: Fri, 27 Nov 2026 06:09:16 +0800
From: kernel test robot <lkp@intel.com>
To: Gabriele Monaco <gmonaco@redhat.com>, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Nam Cao <namcao@linutronix.de>, Wen Yang <wen.yang@linux.dev>,
	Tobias Schaffner <tobias.schaffner@siemens.com>,
	Viktor Malik <vmalik@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	John Ogness <john.ogness@linutronix.de>
Subject: Re: [PATCH v3 05/18] rv: Add generic monitor event tracepoints and
 BPF kfuncs
Message-ID: <20261127053433.PIs3CD9x-lkp@intel.com>
References: <20261126130004.127155-6-gmonaco@redhat.com>
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
In-Reply-To: <20261126130004.127155-6-gmonaco@redhat.com>

Hi Gabriele,

kernel test robot noticed the following build warnings:

[auto build test WARNING on b6a9fa34ce4187cb69d3c588a4bbffc31ce5db8f]

url:    https://github.com/intel-lab-lkp/linux/commits/Gabriele-Monaco/sched-Add-task-enqueue-dequeue-trace-points/20261126-135947
base:   b6a9fa34ce4187cb69d3c588a4bbffc31ce5db8f
patch link:    https://lore.kernel.org/r/20261126130004.127155-6-gmonaco%40redhat.com
patch subject: [PATCH v3 05/18] rv: Add generic monitor event tracepoints and BPF kfuncs
config: loongarch-randconfig-1000-20261127 (https://download.01.org/0day-ci/archive/20261127/20261127053433.PIs3CD9x-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 16.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261127/20261127053433.PIs3CD9x-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/20261127053433.PIs3CD9x-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> Warning: kernel/trace/rv/rv_bpf.c:28 function parameter 'id__nullable' not described in 'bpf_rv_event_monitor'
>> Warning: kernel/trace/rv/rv_bpf.c:51 function parameter 'id__nullable' not described in 'bpf_rv_error_monitor'
>> Warning: kernel/trace/rv/rv_bpf.c:28 function parameter 'id__nullable' not described in 'bpf_rv_event_monitor'
>> Warning: kernel/trace/rv/rv_bpf.c:51 function parameter 'id__nullable' not described in 'bpf_rv_error_monitor'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
