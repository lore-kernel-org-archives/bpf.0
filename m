Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6064326FD93
	for <bpf@vger.kernel.org>; Fri, 13 Feb 2026 06:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770963214; cv=none; b=gNV/lUgo7qGjphfjJj+BM4eeKeHLzQzp/XpKMouJGBqUwU/6UkL2kcgTRNHYVuHtG8vv98KVvNuErxuaXEOQxw5+eUMfp6gFtf+j7CAZbjdBi1Vjr97lkaxo+owkKVH6asbKePDD1JSmQhJj4M1OQZZhwLvHWCJ0Ay+y1jxBNrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770963214; c=relaxed/simple;
	bh=FxYaHbZOahP5KM8dCLOZuLbyNPRUlc/HoBMEp6Wlc4A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a/+scOnZ5DI9io5mdEDYGHHwJJFijoXJOK/fZ+VHHa7kAby7kBIcCXTmIizieLxj/KC2zrauBJKLiAyUDKnehAAsof1pybwVkESD2/tgYiPTUSc6oEEDQReobo/5lZn/L9969y4uU4t7P6d4s55AlTm1fE5RnB7EAiEDZ/M35+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bdh8eb7K; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bdh8eb7K"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770963210; x=1802499210;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=FxYaHbZOahP5KM8dCLOZuLbyNPRUlc/HoBMEp6Wlc4A=;
  b=bdh8eb7KzMvlQHLU6U+0Y/iU39IkAFdpUxK4G1yyQC3FS/LAJWvrICL0
   HzA7teCN8KgWnV7aiohD0tysFqFBvakOdn9AelM8bayJnbDSuhXQp0WHv
   EF0xZ2NXE4E5q3wxz+FDAV4owjW+2gZk0a6xq6G9eohqTssB+3Jg8uMwx
   b2cApRX5sj4p1fpxi6vrhEosXSTlA9yd7uH05OAsfgsmL3Uwx9tCHGSnN
   MWN3kAJu18Z7JuSNr3i8MGohOm4Sh4+lmu71jlBSgSuyqHc53L72cmqZe
   ee/vIHmLWm4q479UTScr2tOeG8qlBmKzdJHaK0fXEu9wrhzHpVkdwGI//
   Q==;
X-CSE-ConnectionGUID: 00CyV9yeQYGcC2ryzMHBDw==
X-CSE-MsgGUID: whbkBd7TQvKAdHuW83QIuQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11699"; a="75988947"
X-IronPort-AV: E=Sophos;i="6.21,288,1763452800"; 
   d="scan'208";a="75988947"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2026 22:13:29 -0800
X-CSE-ConnectionGUID: 2p5EqpDhTE6x8A9jgYuEhg==
X-CSE-MsgGUID: YGybm8eWSk2nBmsYvfQZow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,288,1763452800"; 
   d="scan'208";a="212012838"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 12 Feb 2026 22:13:17 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vqmQU-00000000v9U-2Nn8;
	Fri, 13 Feb 2026 06:13:14 +0000
Date: Fri, 13 Feb 2026 14:12:21 +0800
From: kernel test robot <lkp@intel.com>
To: Larysa Zaremba <larysa.zaremba@intel.com>, bpf@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
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
Subject: Re: [Intel-wired-lan] [PATCH bpf v2 6/9] i40e: use xdp.frame_sz as
 XDP RxQ info frag_size
Message-ID: <202602131407.iwRQooFn-lkp@intel.com>
References: <20260212183328.1883148-8-larysa.zaremba@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260212183328.1883148-8-larysa.zaremba@intel.com>

Hi Larysa,

kernel test robot noticed the following build errors:

[auto build test ERROR on bpf/master]

url:    https://github.com/intel-lab-lkp/linux/commits/Larysa-Zaremba/xdp-use-modulo-operation-to-calculate-XDP-frag-tailroom/20260213-030652
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git master
patch link:    https://lore.kernel.org/r/20260212183328.1883148-8-larysa.zaremba%40intel.com
patch subject: [Intel-wired-lan] [PATCH bpf v2 6/9] i40e: use xdp.frame_sz as XDP RxQ info frag_size
config: i386-buildonly-randconfig-001-20260213 (https://download.01.org/0day-ci/archive/20260213/202602131407.iwRQooFn-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260213/202602131407.iwRQooFn-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202602131407.iwRQooFn-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/net/ethernet/intel/i40e/i40e_main.c:3583:18: error: call to undeclared function 'xsk_pool_get_rx_frag_step'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
    3583 |                 xdp_frame_sz = xsk_pool_get_rx_frag_step(ring->xsk_pool);
         |                                ^
   drivers/net/ethernet/intel/i40e/i40e_main.c:3583:18: note: did you mean 'xsk_pool_get_rx_frame_size'?
   include/net/xdp_sock_drv.h:340:19: note: 'xsk_pool_get_rx_frame_size' declared here
     340 | static inline u32 xsk_pool_get_rx_frame_size(struct xsk_buff_pool *pool)
         |                   ^
   1 error generated.


vim +/xsk_pool_get_rx_frag_step +3583 drivers/net/ethernet/intel/i40e/i40e_main.c

  3552	
  3553	/**
  3554	 * i40e_configure_rx_ring - Configure a receive ring context
  3555	 * @ring: The Rx ring to configure
  3556	 *
  3557	 * Configure the Rx descriptor ring in the HMC context.
  3558	 **/
  3559	static int i40e_configure_rx_ring(struct i40e_ring *ring)
  3560	{
  3561		struct i40e_vsi *vsi = ring->vsi;
  3562		u32 chain_len = vsi->back->hw.func_caps.rx_buf_chain_len;
  3563		u16 pf_q = vsi->base_queue + ring->queue_index;
  3564		struct i40e_hw *hw = &vsi->back->hw;
  3565		struct i40e_hmc_obj_rxq rx_ctx;
  3566		u32 xdp_frame_sz = 0;
  3567		int err = 0;
  3568		bool ok;
  3569	
  3570		bitmap_zero(ring->state, __I40E_RING_STATE_NBITS);
  3571	
  3572		/* clear the context structure first */
  3573		memset(&rx_ctx, 0, sizeof(rx_ctx));
  3574	
  3575		ring->rx_buf_len = vsi->rx_buf_len;
  3576	
  3577		/* XDP RX-queue info only needed for RX rings exposed to XDP */
  3578		if (ring->vsi->type != I40E_VSI_MAIN)
  3579			goto skip;
  3580	
  3581		ring->xsk_pool = i40e_xsk_pool(ring);
  3582		if (ring->xsk_pool) {
> 3583			xdp_frame_sz = xsk_pool_get_rx_frag_step(ring->xsk_pool);
  3584			ring->rx_buf_len = xsk_pool_get_rx_frame_size(ring->xsk_pool);
  3585			err = __xdp_rxq_info_reg(&ring->xdp_rxq, ring->netdev,
  3586						 ring->queue_index,
  3587						 ring->q_vector->napi.napi_id,
  3588						 xdp_frame_sz);
  3589			if (err)
  3590				return err;
  3591			err = xdp_rxq_info_reg_mem_model(&ring->xdp_rxq,
  3592							 MEM_TYPE_XSK_BUFF_POOL,
  3593							 NULL);
  3594			if (err)
  3595				goto unreg_xdp;
  3596			dev_info(&vsi->back->pdev->dev,
  3597				 "Registered XDP mem model MEM_TYPE_XSK_BUFF_POOL on Rx ring %d\n",
  3598				 ring->queue_index);
  3599	
  3600		} else {
  3601			xdp_frame_sz = i40e_rx_pg_size(ring) / 2;
  3602			err = __xdp_rxq_info_reg(&ring->xdp_rxq, ring->netdev,
  3603						 ring->queue_index,
  3604						 ring->q_vector->napi.napi_id,
  3605						 xdp_frame_sz);
  3606			if (err)
  3607				return err;
  3608			err = xdp_rxq_info_reg_mem_model(&ring->xdp_rxq,
  3609							 MEM_TYPE_PAGE_SHARED,
  3610							 NULL);
  3611			if (err)
  3612				goto unreg_xdp;
  3613		}
  3614	
  3615	skip:
  3616		xdp_init_buff(&ring->xdp, xdp_frame_sz, &ring->xdp_rxq);
  3617	
  3618		rx_ctx.dbuff = DIV_ROUND_UP(ring->rx_buf_len,
  3619					    BIT_ULL(I40E_RXQ_CTX_DBUFF_SHIFT));
  3620	
  3621		rx_ctx.base = (ring->dma / 128);
  3622		rx_ctx.qlen = ring->count;
  3623	
  3624		/* use 16 byte descriptors */
  3625		rx_ctx.dsize = 0;
  3626	
  3627		/* descriptor type is always zero
  3628		 * rx_ctx.dtype = 0;
  3629		 */
  3630		rx_ctx.hsplit_0 = 0;
  3631	
  3632		rx_ctx.rxmax = min_t(u16, vsi->max_frame, chain_len * ring->rx_buf_len);
  3633		if (hw->revision_id == 0)
  3634			rx_ctx.lrxqthresh = 0;
  3635		else
  3636			rx_ctx.lrxqthresh = 1;
  3637		rx_ctx.crcstrip = 1;
  3638		rx_ctx.l2tsel = 1;
  3639		/* this controls whether VLAN is stripped from inner headers */
  3640		rx_ctx.showiv = 0;
  3641		/* set the prefena field to 1 because the manual says to */
  3642		rx_ctx.prefena = 1;
  3643	
  3644		/* clear the context in the HMC */
  3645		err = i40e_clear_lan_rx_queue_context(hw, pf_q);
  3646		if (err) {
  3647			dev_info(&vsi->back->pdev->dev,
  3648				 "Failed to clear LAN Rx queue context on Rx ring %d (pf_q %d), error: %d\n",
  3649				 ring->queue_index, pf_q, err);
  3650			err = -ENOMEM;
  3651			goto unreg_xdp;
  3652		}
  3653	
  3654		/* set the context in the HMC */
  3655		err = i40e_set_lan_rx_queue_context(hw, pf_q, &rx_ctx);
  3656		if (err) {
  3657			dev_info(&vsi->back->pdev->dev,
  3658				 "Failed to set LAN Rx queue context on Rx ring %d (pf_q %d), error: %d\n",
  3659				 ring->queue_index, pf_q, err);
  3660			err = -ENOMEM;
  3661			goto unreg_xdp;
  3662		}
  3663	
  3664		/* configure Rx buffer alignment */
  3665		if (!vsi->netdev || test_bit(I40E_FLAG_LEGACY_RX_ENA, vsi->back->flags)) {
  3666			if (I40E_2K_TOO_SMALL_WITH_PADDING) {
  3667				dev_info(&vsi->back->pdev->dev,
  3668					 "2k Rx buffer is too small to fit standard MTU and skb_shared_info\n");
  3669				err = -EOPNOTSUPP;
  3670				goto unreg_xdp;
  3671			}
  3672			clear_ring_build_skb_enabled(ring);
  3673		} else {
  3674			set_ring_build_skb_enabled(ring);
  3675		}
  3676	
  3677		ring->rx_offset = i40e_rx_offset(ring);
  3678	
  3679		/* cache tail for quicker writes, and clear the reg before use */
  3680		ring->tail = hw->hw_addr + I40E_QRX_TAIL(pf_q);
  3681		writel(0, ring->tail);
  3682	
  3683		if (ring->xsk_pool) {
  3684			xsk_pool_set_rxq_info(ring->xsk_pool, &ring->xdp_rxq);
  3685			ok = i40e_alloc_rx_buffers_zc(ring, I40E_DESC_UNUSED(ring));
  3686		} else {
  3687			ok = !i40e_alloc_rx_buffers(ring, I40E_DESC_UNUSED(ring));
  3688		}
  3689		if (!ok) {
  3690			/* Log this in case the user has forgotten to give the kernel
  3691			 * any buffers, even later in the application.
  3692			 */
  3693			dev_info(&vsi->back->pdev->dev,
  3694				 "Failed to allocate some buffers on %sRx ring %d (pf_q %d)\n",
  3695				 ring->xsk_pool ? "AF_XDP ZC enabled " : "",
  3696				 ring->queue_index, pf_q);
  3697		}
  3698	
  3699		return 0;
  3700	unreg_xdp:
  3701		if (ring->vsi->type == I40E_VSI_MAIN)
  3702			xdp_rxq_info_unreg(&ring->xdp_rxq);
  3703	
  3704		return err;
  3705	}
  3706	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
