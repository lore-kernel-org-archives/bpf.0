Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 416C43CF95E;
	Wed, 19 Aug 2026 06:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787120459; cv=none; b=NA4TdrOOPrZSdJDAyVZ0qWMDSTR7Rr47j/4Fxg+bgWTYSOayMzs3IzwWqUPDAwqUe2qpZUKQL0zLeHx4m9N0NAFYn1bSGM8QChj0qoZQ1ZY4mT+TtXDwcfw6HoA/LqlovVT/08AdW0Z5ihOF5nfQr9o0i46IZsmH1Q2JDVcCUwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787120459; c=relaxed/simple;
	bh=Ng2o8K+43txLKGvsL/EPU7ZsEutTWUGantArXxecLZM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=cBLDdK/pYITT/ee1ZoWwYgbXpUNwep1kUyoueMXMyox9HS0h+/8ZCm9YrppxhhltBh/AqcObMyxj8mYidnvFdNy8yWDfFsJFi3CeNP2D1lV5gRggkqWcdaXJ9F/+rT2IN0e8zoettIxuhogWNgVeHECr2/bQVesKIvaMXyYz2yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AsKbi2Rc; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AsKbi2Rc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787120458; x=1818656458;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=Ng2o8K+43txLKGvsL/EPU7ZsEutTWUGantArXxecLZM=;
  b=AsKbi2RcVuh02zAioCv4C0Kp1GmC4OY+7JiS1dsuBjQXPraKaJzMuOEc
   xNm4l5yCOLM/wQ3b/ZBiH+ok3LtwlpoWGxalNDScahk+i4N4jK9Fl4EL4
   6X5W2QswTOWO8zwOBKkxdOfCvkfZCgGr1K6et+bboLZ6FFwgju/tewojj
   sZ9Q7w6XXjEHV1ydL4OA4V3kYUXstBAeGCIbHsJp24rObjr27eimpTPsw
   oUhqL5Oc2okDpUrqBdCBCYU2LGMi3RkHXm4qOzOMLw/ChrpmMFQQyt8nB
   D+nlEPiQNgwLqOC86CD8oymjEuXOeJilR4OHjoQ/ccnw+8qD0Hp+JtzmT
   w==;
X-CSE-ConnectionGUID: s6Jr9Wj2QemnoBSSVK8K4A==
X-CSE-MsgGUID: iMzIeT4PR5CPYnd9BTFQUg==
X-IronPort-AV: E=McAfee;i="6800,10657,11879"; a="87539724"
X-IronPort-AV: E=Sophos;i="6.25,231,1779174000"; 
   d="scan'208";a="87539724"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2026 23:20:57 -0700
X-CSE-ConnectionGUID: F2T2AxHsRMmCBLkddOCruA==
X-CSE-MsgGUID: r/p917lLRc6Y9enCF2zR/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,231,1779174000"; 
   d="scan'208";a="269722936"
Received: from ly-workstation.sh.intel.com (HELO ly-workstation) ([10.239.182.64])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2026 23:20:55 -0700
Date: Wed, 19 Aug 2026 14:20:52 +0800
From: kernel test robot <yi1.lai@intel.com>
To: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org, x86@kernel.org,
	Daniel Borkmann <daniel@iogearbox.net>,
	Dave Hansen <dave.hansen@linux.intel.com>, yi1.lai@intel.com
Subject: [linus:master] [x86/bugs]  a3af84b0fa: stress-ng.seccomp.ops_per_sec
 95.7% regression
Message-ID: <202608191340.98574fe2-lkp@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit


Hello,

kernel test robot noticed a 95.7% regression of stress-ng.seccomp.ops_per_sec on:

commit: a3af84b0fa00ead01fcd0e28b5d773ff25990a0d ("x86/bugs: Enable IBPB flush on BPF JIT allocation")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

testcase: stress-ng
config: x86_64-rhel-9.4
compiler: gcc-14
test machine: 256 threads 2 sockets Intel(R) Xeon(R) 6768P  CPU @ 2.4GHz (Granite Rapids) with 64G memory
parameters:

	nr_threads: 100%
	testtime: 60s
	test: seccomp
	cpufreq_governor: performance

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <yi1.lai@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202608191340.98574fe2-lkp@intel.com


Details are as below:
-------------------------------------------------------------------------------------------------->


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20260819/202608191340.98574fe2-lkp@intel.com

=========================================================================================
compiler/cpufreq_governor/kconfig/nr_threads/rootfs/tbox_group/test/testcase/testtime:
  gcc-14/performance/x86_64-rhel-9.4/100%/debian-13-x86_64-20250902.cgz/lkp-gnr-2sp4/seccomp/stress-ng/60s

commit: 
  96cce16e26 ("bpf: Support for hardening against JIT spraying")
  a3af84b0fa ("x86/bugs: Enable IBPB flush on BPF JIT allocation")
  b72e29e0f7 (bpf: Prefer dirty packs for eBPF allocations)

96cce16e26dd02a8 a3af84b0fa00ead01fcd0e28b5d b72e29e0f7ee329d89f86db8700
---------------- --------------------------- ---------------------------
         %stddev     %change         %stddev     %change         %stddev
             \          |                \          |                \
    351130           -95.7%      15233           -92.8%      25169        stress-ng.seccomp.ops
      5866           -95.7%     252.80           -92.9%     418.07        stress-ng.seccomp.ops_per_sec
    403577           -92.1%      31710           -88.5%      46510        stress-ng.time.involuntary_context_switches
  34288719 ±  2%     -95.4%    1594121           -92.5%    2566499        stress-ng.time.minor_page_faults
      4244           -67.9%       1363 ±  2%     -71.9%       1193        stress-ng.time.percent_of_cpu_this_job_got
      2515           -67.1%     826.95 ±  2%     -71.3%     721.20        stress-ng.time.system_time
     41.17 ±  2%     -94.9%       2.10 ±  3%     -91.7%       3.40 ±  2%  stress-ng.time.user_time
   1119583 ±  2%     -96.3%      40891           -94.5%      61287        stress-ng.time.voluntary_context_switches

Commit b72e29e0f7 slightly recovers performance but remains far below baseline.

Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


