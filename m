Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82A1434EEF2
	for <bpf@vger.kernel.org>; Fri, 27 Mar 2026 12:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774613921; cv=none; b=nDf93YdwF7eP29EvvFMN6DF15zvyhYZlCNLtTqMJjC3cy/Y1A+PtlG65S9STITPh/8JvVC734bqHBYU7hmIWkBtcSJaPqEAu4FIC+AdLnFUkS8QDcf1uro77hi+D50p4SIwi3d9zdBlc8w9Nfe3psmvAYaEYksxU7wdjMDRzD1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774613921; c=relaxed/simple;
	bh=EaKJ+rRyUyacbPbzLG2wbYQ1RHT0poSn3EKIFeh9jMI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Miq8f8ZOhx7Yki4w5Xx8FWdmHmWyUigPrZao0ZnExIwChZ9LZkdnuhjKAk3To8ENks3uDK69U+LHsKqdl7FXFzIC1Je6wOoijHmtW/gfwt4TcaZnvt+tS0DIfw7LbjQ67UEvqDo+Bsere97YB69rz6v/YS0F7IVRhhy60RGTbrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jj7sJUVX; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jj7sJUVX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774613920; x=1806149920;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=EaKJ+rRyUyacbPbzLG2wbYQ1RHT0poSn3EKIFeh9jMI=;
  b=jj7sJUVXKgaxcH2jolayhKOoNvefKkGqe+/JPO90Ac1A0WJlXRzfzcbR
   X6F6k4DpZ53iNs0NhZ1b7bKdwTSthgRSb1HXpE0T0DwS8NbXeL+sQ6rS3
   0XuHdMZQdEMKojHj/rPmAMN9npfEKi9XZgwT95aLrPzMI42R2+JkVju8/
   Il2R3msgre+5xrXV8HyI8+ZpBZjEVJeuL8XufFIBlXn84QkC4otPPbLev
   jEVV/JaN781gM6BFXQRm9G4+RHeHTgm9l8K65LtI5HzF2kdnYuwagK6TG
   uhiM5bqkdmPU3zUu1Taz5Vpv4V7LpNSmuN/EX5HKib2Jt3rvUCIgyWzST
   w==;
X-CSE-ConnectionGUID: l6O34Zy4Q+2XL+UIBCfWeg==
X-CSE-MsgGUID: XuEih5M9QsiG5K2cdrnGPw==
X-IronPort-AV: E=McAfee;i="6800,10657,11741"; a="75566668"
X-IronPort-AV: E=Sophos;i="6.23,144,1770624000"; 
   d="scan'208";a="75566668"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2026 05:18:39 -0700
X-CSE-ConnectionGUID: aTeumil1RsSUl8a3gw9waQ==
X-CSE-MsgGUID: mutqkBPvStiqF9kzYi0oqg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,144,1770624000"; 
   d="scan'208";a="225551369"
Received: from lkp-server01.sh.intel.com (HELO 3905d212be1b) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 27 Mar 2026 05:18:35 -0700
Received: from kbuild by 3905d212be1b with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1w6692-00000000AFp-0gdP;
	Fri, 27 Mar 2026 12:18:32 +0000
Date: Fri, 27 Mar 2026 20:18:02 +0800
From: kernel test robot <lkp@intel.com>
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, bpf@vger.kernel.org,
	ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
	kafai@meta.com, kernel-team@meta.com, eddyz87@gmail.com,
	memxor@gmail.com
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Mykyta Yatsenko <yatsenko@meta.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH bpf-next v6 3/6] bpf: Add sleepable support for classic
 tracepoint programs
Message-ID: <202603272034.xdMLP5lS-lkp@intel.com>
References: <20260325-sleepable_tracepoints-v6-3-2b182dacea13@meta.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260325-sleepable_tracepoints-v6-3-2b182dacea13@meta.com>

Hi Mykyta,

kernel test robot noticed the following build errors:

[auto build test ERROR on 6c8e1a9eee0fec802b542dadf768c30c2a183b3c]

url:    https://github.com/intel-lab-lkp/linux/commits/Mykyta-Yatsenko/bpf-Add-sleepable-support-for-raw-tracepoint-programs/20260327-132324
base:   6c8e1a9eee0fec802b542dadf768c30c2a183b3c
patch link:    https://lore.kernel.org/r/20260325-sleepable_tracepoints-v6-3-2b182dacea13%40meta.com
patch subject: [PATCH bpf-next v6 3/6] bpf: Add sleepable support for classic tracepoint programs
config: sparc64-defconfig (https://download.01.org/0day-ci/archive/20260327/202603272034.xdMLP5lS-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260327/202603272034.xdMLP5lS-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603272034.xdMLP5lS-lkp@intel.com/

All errors (new ones prefixed by >>):

>> ld.lld: error: duplicate symbol: bpf_prog_inc_misses_counter
   >>> defined at mdio_bus.c
   >>>            drivers/net/phy/mdio_bus.o:(bpf_prog_inc_misses_counter)
   >>> defined at mdio_device.c
   >>>            drivers/net/phy/mdio_device.o:(.text+0x0)
--
>> ld.lld: error: duplicate symbol: bpf_prog_inc_misses_counter
   >>> defined at phy.c
   >>>            drivers/net/phy/phy.o:(bpf_prog_inc_misses_counter)
   >>> defined at phy-c45.c
   >>>            drivers/net/phy/phy-c45.o:(.text+0x0)
--
>> ld.lld: error: duplicate symbol: bpf_prog_inc_misses_counter
   >>> defined at phy.c
   >>>            drivers/net/phy/phy.o:(bpf_prog_inc_misses_counter)
   >>> defined at phy-core.c
   >>>            drivers/net/phy/phy-core.o:(.text+0x0)
--
>> ld.lld: error: duplicate symbol: bpf_prog_inc_misses_counter
   >>> defined at phy.c
   >>>            drivers/net/phy/phy.o:(bpf_prog_inc_misses_counter)
   >>> defined at linkmode.c
   >>>            drivers/net/phy/linkmode.o:(.text+0x0)
--
>> ld.lld: error: duplicate symbol: bpf_prog_inc_misses_counter
   >>> defined at phy.c
   >>>            drivers/net/phy/phy.o:(bpf_prog_inc_misses_counter)
   >>> defined at phy_device.c
   >>>            drivers/net/phy/phy_device.o:(.text+0x0)
--
>> ld.lld: error: duplicate symbol: bpf_prog_inc_misses_counter
   >>> defined at phy.c
   >>>            drivers/net/phy/phy.o:(bpf_prog_inc_misses_counter)
   >>> defined at phy_link_topology.c
   >>>            drivers/net/phy/phy_link_topology.o:(.text+0x0)
--
>> ld.lld: error: duplicate symbol: bpf_prog_inc_misses_counter
   >>> defined at phy.c
   >>>            drivers/net/phy/phy.o:(bpf_prog_inc_misses_counter)
   >>> defined at phy_caps.c
   >>>            drivers/net/phy/phy_caps.o:(.text+0x0)
--
>> ld.lld: error: duplicate symbol: bpf_prog_inc_misses_counter
   >>> defined at phy.c
   >>>            drivers/net/phy/phy.o:(bpf_prog_inc_misses_counter)
   >>> defined at phy_port.c
   >>>            drivers/net/phy/phy_port.o:(.text+0x0)
--
>> ld.lld: error: duplicate symbol: bpf_prog_inc_misses_counter
   >>> defined at phy.c
   >>>            drivers/net/phy/phy.o:(bpf_prog_inc_misses_counter)
   >>> defined at mdio_bus_provider.c
   >>>            drivers/net/phy/mdio_bus_provider.o:(.text+0x0)
--
>> ld.lld: error: duplicate symbol: bpf_prog_inc_misses_counter
   >>> defined at phy.c
   >>>            drivers/net/phy/phy.o:(bpf_prog_inc_misses_counter)
   >>> defined at swphy.c
   >>>            drivers/net/phy/swphy.o:(.text+0x0)
--
>> ld.lld: error: duplicate symbol: bpf_prog_inc_misses_counter
   >>> defined at vlan.c
   >>>            net/8021q/vlan.o:(bpf_prog_inc_misses_counter)
   >>> defined at vlan_netlink.c
   >>>            net/8021q/vlan_netlink.o:(.text+0x0)
..

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
