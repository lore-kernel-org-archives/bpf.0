Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49FCC31328E
	for <bpf@vger.kernel.org>; Fri, 13 Feb 2026 07:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770968848; cv=none; b=hg7ZVikQMupVsjlwHY6kcmRcLCi5yNtUCqZG4qekZi8BafrUyycF34bESjUV3n5DdBRDuE7fbXnDFojUwKp7VCSzrrdyriu0D4brRQEyBPpFX0Zz1kHhGEYlOInA/7vNm8D/tgyFYrUyCa1krJtiPaxs7H0uQ9uG5ifvJqO/ggY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770968848; c=relaxed/simple;
	bh=Q9FayCI6DPsELjSrd6Qc++AQKJJ5wuxs8Gft0Bu2xXY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dFcqYVRHQxL5PywgJBbVzMsZbNTgB8uBB4LUI+CPiy68iVgKv89ZPlcrwlWOp/A33X6r1jz2YNGU2deyvr4/lnz7QkZ4pUqH2LwHi99d0huu/046MhtT8SEGQ+eVEIO4oVwrIjPSap5fJicuBgggZCQ2+qFfY4EML6WsWkivbsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dRq8GJjw; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dRq8GJjw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770968847; x=1802504847;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Q9FayCI6DPsELjSrd6Qc++AQKJJ5wuxs8Gft0Bu2xXY=;
  b=dRq8GJjwdY5Baa1ydMksNsoX/cC4c2wlhOMmEZL8F3lvSZKyoRFolAQS
   kXZKSEZIb//JCC8x/Ughn1uX4wCagGRWZ24FI8FTqc8aUzxDv71tEM/Fg
   PrY2bjyzIJOexnje01bBtLUyRnpfvRIxouwrwyIy93Qcf/gfcj0tRBowI
   54ImjtnExvzRPFo1r+otVpG/yuJ4evye4DWbZPLtjNtS/BzayJA4sTMiC
   4tdeVEMntKtcwDQpKNOQSDRwnskpSPF7lUjQCv9cPO7HF06Deeyp9BZpF
   dQMX3OsAnSQITryVTUHfZLVRGP/48muGHdSxDFaJ+4CgXUZ0IVdS4BeAG
   Q==;
X-CSE-ConnectionGUID: 3cFVJDV7Rb67OvdjzWJbbw==
X-CSE-MsgGUID: RQk1WAFpTVu4H91SK0jLmA==
X-IronPort-AV: E=McAfee;i="6800,10657,11699"; a="72057590"
X-IronPort-AV: E=Sophos;i="6.21,288,1763452800"; 
   d="scan'208";a="72057590"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2026 23:47:27 -0800
X-CSE-ConnectionGUID: re8DZ9oYRO+mIy2aezGoog==
X-CSE-MsgGUID: NwdJi+8HSBuEcghE5Qi/1w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,288,1763452800"; 
   d="scan'208";a="211765829"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 12 Feb 2026 23:47:20 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vqntW-00000000vCS-0E69;
	Fri, 13 Feb 2026 07:47:18 +0000
Date: Fri, 13 Feb 2026 15:46:26 +0800
From: kernel test robot <lkp@intel.com>
To: Larysa Zaremba <larysa.zaremba@intel.com>, bpf@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev,
	Larysa Zaremba <larysa.zaremba@intel.com>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Wei Fang <wei.fang@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>, Simon Horman <horms@kernel.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	"Bastien Curutchet (eBPF Foundation)" <bastien.curutchet@bootlin.com>
Subject: Re: [Intel-wired-lan] [PATCH bpf v2 4/9] ice: change XDP RxQ
 frag_size from DMA write length to xdp.frame_sz
Message-ID: <202602131552.b0xrTOY6-lkp@intel.com>
References: <20260212183328.1883148-6-larysa.zaremba@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260212183328.1883148-6-larysa.zaremba@intel.com>

Hi Larysa,

kernel test robot noticed the following build warnings:

[auto build test WARNING on bpf/master]

url:    https://github.com/intel-lab-lkp/linux/commits/Larysa-Zaremba/xdp-use-modulo-operation-to-calculate-XDP-frag-tailroom/20260213-030652
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git master
patch link:    https://lore.kernel.org/r/20260212183328.1883148-6-larysa.zaremba%40intel.com
patch subject: [Intel-wired-lan] [PATCH bpf v2 4/9] ice: change XDP RxQ frag_size from DMA write length to xdp.frame_sz
config: parisc-allyesconfig (https://download.01.org/0day-ci/archive/20260213/202602131552.b0xrTOY6-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 15.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260213/202602131552.b0xrTOY6-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202602131552.b0xrTOY6-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/net/ethernet/intel/ice/ice_base.c: In function 'ice_vsi_cfg_rxq':
>> drivers/net/ethernet/intel/ice/ice_base.c:662:13: warning: variable 'rx_buf_len' set but not used [-Wunused-but-set-variable]
     662 |         u32 rx_buf_len;
         |             ^~~~~~~~~~


vim +/rx_buf_len +662 drivers/net/ethernet/intel/ice/ice_base.c

8adfcfd6a2eedb Alexander Lobakin      2025-10-06  651  
43c7f9198deb85 Krzysztof Kazimierczak 2020-11-20  652  /**
43c7f9198deb85 Krzysztof Kazimierczak 2020-11-20  653   * ice_vsi_cfg_rxq - Configure an Rx queue
43c7f9198deb85 Krzysztof Kazimierczak 2020-11-20  654   * @ring: the ring being configured
43c7f9198deb85 Krzysztof Kazimierczak 2020-11-20  655   *
43c7f9198deb85 Krzysztof Kazimierczak 2020-11-20  656   * Return 0 on success and a negative value on error.
43c7f9198deb85 Krzysztof Kazimierczak 2020-11-20  657   */
3e5fb691faee1d Maciej Fijalkowski     2024-01-23  658  static int ice_vsi_cfg_rxq(struct ice_rx_ring *ring)
43c7f9198deb85 Krzysztof Kazimierczak 2020-11-20  659  {
43c7f9198deb85 Krzysztof Kazimierczak 2020-11-20  660  	struct device *dev = ice_pf_to_dev(ring->vsi->back);
93f53db9f9dc4a Michal Kubiak          2025-09-25  661  	u32 num_bufs = ICE_DESC_UNUSED(ring);
3a4f419f750946 Michal Kubiak          2025-09-25 @662  	u32 rx_buf_len;
43c7f9198deb85 Krzysztof Kazimierczak 2020-11-20  663  	int err;
43c7f9198deb85 Krzysztof Kazimierczak 2020-11-20  664  
597b8af58bb2df Piotr Raczynski        2024-08-20  665  	if (ring->vsi->type == ICE_VSI_PF || ring->vsi->type == ICE_VSI_SF) {
ebc33a3f8d0aed Maciej Fijalkowski     2024-07-26  666  		ice_rx_xsk_pool(ring);
93f53db9f9dc4a Michal Kubiak          2025-09-25  667  		err = ice_realloc_rx_xdp_bufs(ring, ring->xsk_pool);
93f53db9f9dc4a Michal Kubiak          2025-09-25  668  		if (err)
93f53db9f9dc4a Michal Kubiak          2025-09-25  669  			return err;
93f53db9f9dc4a Michal Kubiak          2025-09-25  670  
43c7f9198deb85 Krzysztof Kazimierczak 2020-11-20  671  		if (ring->xsk_pool) {
6084262621449f Larysa Zaremba         2026-02-12  672  			u32 frag_size =
6084262621449f Larysa Zaremba         2026-02-12  673  				xsk_pool_get_rx_frag_step(ring->xsk_pool);
3a4f419f750946 Michal Kubiak          2025-09-25  674  			rx_buf_len =
43c7f9198deb85 Krzysztof Kazimierczak 2020-11-20  675  				xsk_pool_get_rx_frame_size(ring->xsk_pool);
3de38c87174225 Maciej Fijalkowski     2024-01-24  676  			err = __xdp_rxq_info_reg(&ring->xdp_rxq, ring->netdev,
3de38c87174225 Maciej Fijalkowski     2024-01-24  677  						 ring->q_index,
3de38c87174225 Maciej Fijalkowski     2024-01-24  678  						 ring->q_vector->napi.napi_id,
6084262621449f Larysa Zaremba         2026-02-12  679  						 frag_size);
3de38c87174225 Maciej Fijalkowski     2024-01-24  680  			if (err)
3de38c87174225 Maciej Fijalkowski     2024-01-24  681  				return err;
43c7f9198deb85 Krzysztof Kazimierczak 2020-11-20  682  			err = xdp_rxq_info_reg_mem_model(&ring->xdp_rxq,
43c7f9198deb85 Krzysztof Kazimierczak 2020-11-20  683  							 MEM_TYPE_XSK_BUFF_POOL,
43c7f9198deb85 Krzysztof Kazimierczak 2020-11-20  684  							 NULL);
43c7f9198deb85 Krzysztof Kazimierczak 2020-11-20  685  			if (err)
43c7f9198deb85 Krzysztof Kazimierczak 2020-11-20  686  				return err;
43c7f9198deb85 Krzysztof Kazimierczak 2020-11-20  687  			xsk_pool_set_rxq_info(ring->xsk_pool, &ring->xdp_rxq);
43c7f9198deb85 Krzysztof Kazimierczak 2020-11-20  688  
43c7f9198deb85 Krzysztof Kazimierczak 2020-11-20  689  			dev_info(dev, "Registered XDP mem model MEM_TYPE_XSK_BUFF_POOL on Rx ring %d\n",
43c7f9198deb85 Krzysztof Kazimierczak 2020-11-20  690  				 ring->q_index);
43c7f9198deb85 Krzysztof Kazimierczak 2020-11-20  691  		} else {
8adfcfd6a2eedb Alexander Lobakin      2025-10-06  692  			err = ice_rxq_pp_create(ring);
93f53db9f9dc4a Michal Kubiak          2025-09-25  693  			if (err)
93f53db9f9dc4a Michal Kubiak          2025-09-25  694  				return err;
93f53db9f9dc4a Michal Kubiak          2025-09-25  695  
3de38c87174225 Maciej Fijalkowski     2024-01-24  696  			err = __xdp_rxq_info_reg(&ring->xdp_rxq, ring->netdev,
2fba7dc5157b6f Maciej Fijalkowski     2023-01-31  697  						 ring->q_index,
2fba7dc5157b6f Maciej Fijalkowski     2023-01-31  698  						 ring->q_vector->napi.napi_id,
6084262621449f Larysa Zaremba         2026-02-12  699  						 ring->truesize);
3de38c87174225 Maciej Fijalkowski     2024-01-24  700  			if (err)
93f53db9f9dc4a Michal Kubiak          2025-09-25  701  				goto err_destroy_fq;
973c22488e49c4 Larysa Zaremba         2026-02-12  702  
93f53db9f9dc4a Michal Kubiak          2025-09-25  703  			xdp_rxq_info_attach_page_pool(&ring->xdp_rxq,
93f53db9f9dc4a Michal Kubiak          2025-09-25  704  						      ring->pp);
43c7f9198deb85 Krzysztof Kazimierczak 2020-11-20  705  		}
43c7f9198deb85 Krzysztof Kazimierczak 2020-11-20  706  	}
43c7f9198deb85 Krzysztof Kazimierczak 2020-11-20  707  
2fba7dc5157b6f Maciej Fijalkowski     2023-01-31  708  	ring->xdp.data = NULL;
43c7f9198deb85 Krzysztof Kazimierczak 2020-11-20  709  	err = ice_setup_rx_ctx(ring);
43c7f9198deb85 Krzysztof Kazimierczak 2020-11-20  710  	if (err) {
43c7f9198deb85 Krzysztof Kazimierczak 2020-11-20  711  		dev_err(dev, "ice_setup_rx_ctx failed for RxQ %d, err %d\n",
43c7f9198deb85 Krzysztof Kazimierczak 2020-11-20  712  			ring->q_index, err);
93f53db9f9dc4a Michal Kubiak          2025-09-25  713  		goto err_destroy_fq;
43c7f9198deb85 Krzysztof Kazimierczak 2020-11-20  714  	}
43c7f9198deb85 Krzysztof Kazimierczak 2020-11-20  715  
1742b3d528690a Magnus Karlsson        2020-08-28  716  	if (ring->xsk_pool) {
ed0907e3bdcfc7 Magnus Karlsson        2021-02-05  717  		bool ok;
ed0907e3bdcfc7 Magnus Karlsson        2021-02-05  718  
c4655761d3cf62 Magnus Karlsson        2020-08-28  719  		if (!xsk_buff_can_alloc(ring->xsk_pool, num_bufs)) {
1742b3d528690a Magnus Karlsson        2020-08-28  720  			dev_warn(dev, "XSK buffer pool does not provide enough addresses to fill %d buffers on Rx ring %d\n",
3f0d97cdfe6e90 Krzysztof Kazimierczak 2020-05-15  721  				 num_bufs, ring->q_index);
3f0d97cdfe6e90 Krzysztof Kazimierczak 2020-05-15  722  			dev_warn(dev, "Change Rx ring/fill queue size to avoid performance issues\n");
3f0d97cdfe6e90 Krzysztof Kazimierczak 2020-05-15  723  
3f0d97cdfe6e90 Krzysztof Kazimierczak 2020-05-15  724  			return 0;
3f0d97cdfe6e90 Krzysztof Kazimierczak 2020-05-15  725  		}
3f0d97cdfe6e90 Krzysztof Kazimierczak 2020-05-15  726  
ebc33a3f8d0aed Maciej Fijalkowski     2024-07-26  727  		ok = ice_alloc_rx_bufs_zc(ring, ring->xsk_pool, num_bufs);
43c7f9198deb85 Krzysztof Kazimierczak 2020-11-20  728  		if (!ok) {
43c7f9198deb85 Krzysztof Kazimierczak 2020-11-20  729  			u16 pf_q = ring->vsi->rxq_map[ring->q_index];
43c7f9198deb85 Krzysztof Kazimierczak 2020-11-20  730  
1742b3d528690a Magnus Karlsson        2020-08-28  731  			dev_info(dev, "Failed to allocate some buffers on XSK buffer pool enabled Rx ring %d (pf_q %d)\n",
2d4238f5569722 Krzysztof Kazimierczak 2019-11-04  732  				 ring->q_index, pf_q);
43c7f9198deb85 Krzysztof Kazimierczak 2020-11-20  733  		}
43c7f9198deb85 Krzysztof Kazimierczak 2020-11-20  734  
3f0d97cdfe6e90 Krzysztof Kazimierczak 2020-05-15  735  		return 0;
3f0d97cdfe6e90 Krzysztof Kazimierczak 2020-05-15  736  	}
3f0d97cdfe6e90 Krzysztof Kazimierczak 2020-05-15  737  
dc5e7a3513efcb Michal Kubiak          2025-05-14  738  	if (ring->vsi->type == ICE_VSI_CTRL)
dc5e7a3513efcb Michal Kubiak          2025-05-14  739  		ice_init_ctrl_rx_descs(ring, num_bufs);
dc5e7a3513efcb Michal Kubiak          2025-05-14  740  	else
93f53db9f9dc4a Michal Kubiak          2025-09-25  741  		err = ice_alloc_rx_bufs(ring, num_bufs);
93f53db9f9dc4a Michal Kubiak          2025-09-25  742  
93f53db9f9dc4a Michal Kubiak          2025-09-25  743  	if (err)
93f53db9f9dc4a Michal Kubiak          2025-09-25  744  		goto err_destroy_fq;
eff380aaffedb2 Anirudh Venkataramanan 2019-10-24  745  
eff380aaffedb2 Anirudh Venkataramanan 2019-10-24  746  	return 0;
93f53db9f9dc4a Michal Kubiak          2025-09-25  747  
93f53db9f9dc4a Michal Kubiak          2025-09-25  748  err_destroy_fq:
8adfcfd6a2eedb Alexander Lobakin      2025-10-06  749  	ice_rxq_pp_destroy(ring);
93f53db9f9dc4a Michal Kubiak          2025-09-25  750  
93f53db9f9dc4a Michal Kubiak          2025-09-25  751  	return err;
eff380aaffedb2 Anirudh Venkataramanan 2019-10-24  752  }
eff380aaffedb2 Anirudh Venkataramanan 2019-10-24  753  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
