Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38B8F34165B;
	Fri, 13 Mar 2026 20:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773432686; cv=none; b=LTGDRhnbc43vhcY0AGPDhBVYm8oMVw1KVWhxpvtZrudzpnwGRCHJNvCnnRPxMTHLIooh//gjPuxHghY3FmoK1/BZBR4nqsYaDYr1rKPIY2ux4sgqufpA8igtuXgiN+QIO9ulLHoGb+r86GTX3mlfSlGLRTiWyxAL/FGfg5oquT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773432686; c=relaxed/simple;
	bh=SMPmzclyOIKQEi+ShtklVqvxCpyJHokDbfVTltDu+3M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kRlToBvQ0BCe/FMuF7qd2IdGJKRvezvhHVWcQ2aXCz87xiOfNwU1gN3wzLOTqW23DciW4mNHlNfrVRyTzhsxPNh9YPaCGjESxgnfDccUh+ObaVL8H/UssL1Ol5q1uNPhap4qbHAsFJekW8m5lEvHWEL6BkZgKs1bnljeW9ZeE/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bT4aDX6C; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bT4aDX6C"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773432686; x=1804968686;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=SMPmzclyOIKQEi+ShtklVqvxCpyJHokDbfVTltDu+3M=;
  b=bT4aDX6CQcrOwxC21NijNFDx3OjWFPVlxOU3Fq5rOsiGlItu6GVicdM2
   gBGXKpCQM+pKw0olRAXGm3eLWbINue2SsBh3o6BnUxdQP5Yaw+UXj6mky
   +1H6iUs7A7bEqQMcATCSbbKLv25RZh9zH5qcQ15MD/qoUoDABRqR7TUpW
   zrIieomoXV2kVULArviW3s8ooXfyCMLomLA6gT1baS3fS6BvCMmwWDJpx
   3aiv0cQm2drgK9x466RftKxnIp/5DRdhCQJ/6tCbxYf5kI7ZElb82siWq
   uV7bqP3FwBI2iPir203kOZsVobGn4oxvRHNx74jJEpHHBsd691hCunnEE
   Q==;
X-CSE-ConnectionGUID: a1Z5r507SLG30j1Uwh9gqA==
X-CSE-MsgGUID: Sbj+0bzFSHCJVLLsp+9w7A==
X-IronPort-AV: E=McAfee;i="6800,10657,11728"; a="74517787"
X-IronPort-AV: E=Sophos;i="6.23,118,1770624000"; 
   d="scan'208";a="74517787"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2026 13:11:22 -0700
X-CSE-ConnectionGUID: 2kUbeFEFSaKhLs70W7WvSQ==
X-CSE-MsgGUID: ev3j7rCVSJW5exQ6b/MdoA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,118,1770624000"; 
   d="scan'208";a="246403671"
Received: from igk-lkp-server01.igk.intel.com (HELO 9958d990ccf2) ([10.211.93.152])
  by fmviesa001.fm.intel.com with ESMTP; 13 Mar 2026 13:11:16 -0700
Received: from kbuild by 9958d990ccf2 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1w18qn-000000003hZ-0QxX;
	Fri, 13 Mar 2026 20:11:13 +0000
Date: Fri, 13 Mar 2026 21:10:41 +0100
From: kernel test robot <lkp@intel.com>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Andrew Lunn <andrew@lunn.ch>
Cc: oe-kbuild-all@lists.linux.dev,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Alexei Starovoitov <ast@kernel.org>, bpf@vger.kernel.org,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Stanislav Fomichev <sdf@fomichev.me>
Subject: Re: [PATCH net-next v2 13/15] net: stmmac: add helper to set
 transmit tail pointer
Message-ID: <202603132104.OVIsnpBk-lkp@intel.com>
References: <E1w0czK-0000000CzH7-19Fb@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1w0czK-0000000CzH7-19Fb@rmk-PC.armlinux.org.uk>

Hi Russell,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Russell-King-Oracle/net-stmmac-rearrange-stmmac_tx_info-members-to-pack-better/20260313-225823
base:   net-next/main
patch link:    https://lore.kernel.org/r/E1w0czK-0000000CzH7-19Fb%40rmk-PC.armlinux.org.uk
patch subject: [PATCH net-next v2 13/15] net: stmmac: add helper to set transmit tail pointer
config: x86_64-rhel-9.4 (https://download.01.org/0day-ci/archive/20260313/202603132104.OVIsnpBk-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260313/202603132104.OVIsnpBk-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603132104.OVIsnpBk-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/net/ethernet/stmicro/stmmac/dwmac4_descs.c: In function 'dwmac4_display_ring':
>> drivers/net/ethernet/stmicro/stmmac/dwmac4_descs.c:430:40: error: implicit declaration of function 'dma_desc_to_edesc' [-Wimplicit-function-declaration]
     430 |                 struct dma_edesc *ep = dma_desc_to_edesc(head);
         |                                        ^~~~~~~~~~~~~~~~~
>> drivers/net/ethernet/stmicro/stmmac/dwmac4_descs.c:430:40: error: initialization of 'struct dma_edesc *' from 'int' makes pointer from integer without a cast [-Wint-conversion]


vim +/dma_desc_to_edesc +430 drivers/net/ethernet/stmicro/stmmac/dwmac4_descs.c

   396	
   397	static void dwmac4_display_ring(void *head, unsigned int size, bool rx,
   398					dma_addr_t dma_rx_phy, unsigned int desc_size)
   399	{
   400		dma_addr_t dma_addr;
   401		int i;
   402	
   403		pr_info("%s descriptor ring:\n", rx ? "RX" : "TX");
   404	
   405		if (desc_size == sizeof(struct dma_desc)) {
   406			struct dma_desc *p = (struct dma_desc *)head;
   407	
   408			for (i = 0; i < size; i++) {
   409				dma_addr = dma_rx_phy + i * sizeof(*p);
   410				pr_info("%03d [%pad]: 0x%x 0x%x 0x%x 0x%x\n",
   411					i, &dma_addr,
   412					le32_to_cpu(p->des0), le32_to_cpu(p->des1),
   413					le32_to_cpu(p->des2), le32_to_cpu(p->des3));
   414				p++;
   415			}
   416		} else if (desc_size == sizeof(struct dma_extended_desc)) {
   417			struct dma_extended_desc *extp = (struct dma_extended_desc *)head;
   418	
   419			for (i = 0; i < size; i++) {
   420				dma_addr = dma_rx_phy + i * sizeof(*extp);
   421				pr_info("%03d [%pad]: 0x%x 0x%x 0x%x 0x%x 0x%x 0x%x 0x%x 0x%x\n",
   422					i, &dma_addr,
   423					le32_to_cpu(extp->basic.des0), le32_to_cpu(extp->basic.des1),
   424					le32_to_cpu(extp->basic.des2), le32_to_cpu(extp->basic.des3),
   425					le32_to_cpu(extp->des4), le32_to_cpu(extp->des5),
   426					le32_to_cpu(extp->des6), le32_to_cpu(extp->des7));
   427				extp++;
   428			}
   429		} else if (desc_size == sizeof(struct dma_edesc)) {
 > 430			struct dma_edesc *ep = dma_desc_to_edesc(head);
   431	
   432			for (i = 0; i < size; i++) {
   433				dma_addr = dma_rx_phy + i * sizeof(*ep);
   434				pr_info("%03d [%pad]: 0x%x 0x%x 0x%x 0x%x 0x%x 0x%x 0x%x 0x%x\n",
   435					i, &dma_addr,
   436					le32_to_cpu(ep->des4), le32_to_cpu(ep->des5),
   437					le32_to_cpu(ep->des6), le32_to_cpu(ep->des7),
   438					le32_to_cpu(ep->basic.des0), le32_to_cpu(ep->basic.des1),
   439					le32_to_cpu(ep->basic.des2), le32_to_cpu(ep->basic.des3));
   440				ep++;
   441			}
   442		} else {
   443			pr_err("unsupported descriptor!");
   444		}
   445	}
   446	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
