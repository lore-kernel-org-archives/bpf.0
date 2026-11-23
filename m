Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.21
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795394597;
	b=dIqmkEmP0jC/51WqvB5v0C2FxveqFlAfkENtGb571NAzrdVMiJVZcEByOYNac+8obxwM
	 bCrgl/O9SRwHSlIRNbsB/TEF/EwEwBxbf/ssbAa+xuFNjnT8GB9+THABqPIRvgQMMFR6U
	 R2z34/8dbJ9Yt0kPm9S8AR7hPj38nheKBw3YVjahLVPK+Oyq4n+2+PlIxBZ1tM9+daUAT
	 He9zn8zom+q+BAFuC9r4lQjfwI4nCwwF8MpXOl1ZM9rk4bAsLMRxJqCgwFWhcSeTS0VUs
	 eBPqPol4agpY7KJPCmG4TamO2hUXbpFe/vq1aJVLibLqKIqkKd/4+xorIgHsgRlaGqg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795394597;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding;
	bh=TLXj3Fi8Kl5VNZ08p1Bk9+717X3RrFhG/5sffc1EOzM=;
	b=Kts1F8uAftwV8Z5qviE03kvROAHT/DJ17gvUkJZWdarqsBG0VycisWfSHL0dm2mdDrBb
	 HHuL5WV6v0VeTNZHiq1uJt5r6QqdONMHT5lm7qSrKi4keIahpejxq+2x4A5BpEWWP1OkU
	 UqO/0u1ZtZTXVWEStfGXVtsnuwHQ7x6APbKdKy4lJ9I9T/VkIhrktSgvvdrZ2B3DxAUlf
	 cYGWdTqC84qZmy/EOEPdVUaAQbrO9bQAhRXt+3OGh3AZcnhuqNDQi3xwjGPC/WMKSbaTu
	 KUCg1rv4DLWddLnCGOCbK14Vw6bEFJqFoyXofA4CffdHJjn76zSoF9TJY6aHzwZlttQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Op86zi+m;
	arc=none smtp.remote-ip=198.175.65.21
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B472606A33C;
	Mon, 23 Nov 2026 00:43:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6B472606A33C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Op86zi+m
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795394595; x=1826930595;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=iJ4+vs+nmNJDXv13dvpUiuHGj5q0As+YtfUP5iiyV5A=;
  b=Op86zi+mR5dhHG+z/KwsvjqMy+VXBm8tV//ZWRvUVIrOhCSlyn6EKNCf
   QzIZgbZ1OLTaAQDQ9EtlgfpGMNlICcBgLUIMQq+BXFGB7jfGIkV7/Fl0s
   5jt0j6baO4ivtoF6uoY6zbN5zO+14rjDIp+9vXdj4X5oqtKCFD4jX89kE
   ZfodtWhIX89CbiOl7qVM3RJ2EZpWfHJDr3vLuJz7gbc1fJrk86SBDLaFM
   P4/tqx8lYC5aMSt8KuJZEb7/0bC6kfahZpKGYq6GRXZYkDud/VPbMSAo4
   cQi3v4sNDKdaIHnPPYYU1RXJI1RNH2oCCw5h8Lr7scgm1AMiysiQYVokY
   g==;
X-CSE-ConnectionGUID: YWAvt++IRyy32qublHLk7Q==
X-CSE-MsgGUID: Jdkl/GJ4TSCp7yrhWIQDKg==
X-IronPort-AV: E=McAfee;i="6800,10657,11974"; a="4279016"
X-IronPort-AV: E=Sophos;i="6.27,227,1787036400"; 
   d="scan'208";a="4279016"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2026 16:43:14 -0800
X-CSE-ConnectionGUID: ZkRECSoFTU6hGqtygMhgig==
X-CSE-MsgGUID: 1bGPQQSXR5GrRHxZBsawWQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,227,1787036400"; 
   d="scan'208";a="11073546"
Received: from ly-workstation.sh.intel.com (HELO ly-workstation) ([10.239.182.64])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2026 16:43:12 -0800
Date: Mon, 23 Nov 2026 08:43:08 +0800
From: kernel test robot <yi1.lai@intel.com>
To: Emil Tsalapatis <emil@etsalapatis.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, linux-kernel@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	yi1.lai@intel.com
Subject: [linus:master] [bpf]  bd59a58663:  stress-ng.seccomp.ops_per_sec
 59.6% regression
Message-ID: <202611230821.f5107bac-lkp@intel.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit


Hello,

kernel test robot noticed a 59.6% regression of stress-ng.seccomp.ops_per_sec on:

commit: bd59a58663895778da607fd02a8f17a93db97d16 ("bpf: Use dedicated workqueue for freeing BPF programs") https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

testcase: stress-ng
config: x86_64-rhel-9.4
compiler: gcc-14
test machine: 224 threads 2 sockets Intel(R) Xeon(R) Platinum 8480CTDX (Sapphire Rapids) with 256G memory
parameters:

	nr_threads: 100%
	testtime: 60s
	test: seccomp
	cpufreq_governor: performance


If you fix the issue in a separate patch/commit (i.e. not just a new version of the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <yi1.lai@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202611230821.f5107bac-lkp@intel.com


Details are as below:
-------------------------------------------------------------------------------------------------->


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20261123/202611230821.f5107bac-lkp@intel.com

=========================================================================================
compiler/cpufreq_governor/kconfig/nr_threads/rootfs/tbox_group/test/testcase/testtime:
  gcc-14/performance/x86_64-rhel-9.4/100%/debian-13-x86_64-20250902.cgz/lkp-spr-r02/seccomp/stress-ng/60s

commit: 
  ef2cb4d4c5 ("Merge branch 'reject-writable-map-iterators-on-read-only-maps'")
  bd59a58663 ("bpf: Use dedicated workqueue for freeing BPF programs")

ef2cb4d4c59132b8 bd59a58663895778da607fd02a8
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
    613342           -59.6%     247980 ±  2%  stress-ng.seccomp.ops
     10230           -59.6%       4134 ±  2%  stress-ng.seccomp.ops_per_sec
    691777           -84.6%     106534        stress-ng.time.involuntary_context_switches
  60318172           -59.8%   24270033 ±  2%  stress-ng.time.minor_page_faults
      5077           +48.9%       7560        stress-ng.time.percent_of_cpu_this_job_got
      3007           +50.6%       4527        stress-ng.time.system_time
     44.78           -55.9%      19.74 ±  2%  stress-ng.time.user_time
   1475619 ±  2%     -71.9%     415109 ±  2%  stress-ng.time.voluntary_context_switches


Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


