Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96B8539A05E;
	Tue,  7 Apr 2026 14:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775570998; cv=none; b=hR1lfD/zcPMX5oeFayhU54O56GR3jtK8QD0IdNGuvp+LgFM3L7Zd8IFuURTkHT6IUBVlVCII0uU+olAoN5kpSkaWz0R11HUebcSke308RoD2G4rUinN8yTJIy9Cn3nvQ0nmRIqDFqc1PAlgcoiUO0WChP6K2W/pJ6ZFcsGnVLOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775570998; c=relaxed/simple;
	bh=xMtCdr7WJHpOJDQDwTSSF/AZKyKCLw08CI+TTdGi1r0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FYQYBWfeRWZOT75OHuWxyX4PsT0TBHy9/z28uZBIxCmETU/XVmErKdXuWrMxCP3jhwhc4ZbJDnC+wkl1ERlYfb6tZACzDkhTGNYrmNGH++y6zeKY60cB6OXdNbXCKTI1DPclOKGOmeTN6lGD9hAcDSwAWTF+4f39Pr4X8AjS9M4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=TWW+DFii; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="TWW+DFii"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=MN6qzqxRs/zqrPwuVs2/6X79CviG+I8DWPs5lk/Ay2c=; b=TWW+DFiilpedgYEvtVyq7aTK32
	O3BaEiUrFW1cKLzlvwnM8nb50GigIkogLZuJXkkCF0KkWw6k4YhEkMzSNRfhgRZ8AMZ8Shwam0edR
	pWSEcMgEplZ7851y63OAhIgW3Unkzw0Ou8ZIWTzXZ59MnxmqFXbMt9h+suaD1LRDNLq2/DhwZRRDR
	rWbqm+UTVyVUYtXuyK4cZmHgdSWSXe3Vu3WujAKjftI7mK2VTOHxaYr+Kp75Q9tkNYh1E/mkBi3AD
	Zze+0VwODVD2NvONOkTLv91I3qahyeX7LH9AMPR1vxf5X/ODgy06Xn65DxLY6IqJ89NqCla1w3Hme
	ERjpF/Nw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:50812)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1wA77h-0000000010S-2pf6;
	Tue, 07 Apr 2026 15:09:45 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1wA77U-000000002KF-1WoV;
	Tue, 07 Apr 2026 15:09:32 +0100
Date: Tue, 7 Apr 2026 15:09:32 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Jitendra Vegiraju <jitendra.vegiraju@broadcom.com>
Cc: netdev@vger.kernel.org, alexandre.torgue@foss.st.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, mcoquelin.stm32@gmail.com,
	bcm-kernel-feedback-list@broadcom.com, richardcochran@gmail.com,
	ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
	john.fastabend@gmail.com, rohan.g.thomas@altera.com,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org,
	andrew+netdev@lunn.ch, horms@kernel.org, sdf@fomichev.me,
	me@ziyao.cc, siyanteng@cqsoftware.com.cn,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	weishangjuan@eswincomputing.com, wens@kernel.org,
	vladimir.oltean@nxp.com, lizhi2@eswincomputing.com,
	boon.khai.ng@altera.com, maxime.chevallier@bootlin.com,
	chenchuangyu@xiaomi.com, yangtiezhu@loongson.cn,
	ovidiu.panait.rb@renesas.com, chenhuacai@kernel.org,
	florian.fainelli@broadcom.com, quic_abchauha@quicinc.com
Subject: Re: [PATCH net-next v9 1/4] net: stmmac: Add DW25GMAC support in
 stmmac core driver
Message-ID: <adUQHHBD0d3p1OSI@shell.armlinux.org.uk>
References: <20260402213629.1996133-1-jitendra.vegiraju@broadcom.com>
 <20260402213629.1996133-2-jitendra.vegiraju@broadcom.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260402213629.1996133-2-jitendra.vegiraju@broadcom.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

Not withstanding my comment about the other Synopsys xlgmac driver that
we have in the kernel...

On Thu, Apr 02, 2026 at 02:36:26PM -0700, Jitendra Vegiraju wrote:
> From: Jitendra Vegiraju <jitendra.vegiraju@broadcom.com>
> 
> The DW25GMAC introduced a new DMA architecture called Hyper-DMA (HDMA) for
> virtualization scalability. This is realized by decoupling physical DMA
> channels(PDMA) from potentially large number of virtual DMA channels(VDMA).
> The VDMAs provide software abstraction to driver that map to PDMAs for
> frame transmission and reception.
> Since 25GMAC is a derivative of XGMAC, majority of IP is common to both.
> 
> To add support for the HDMA in 25GMAC, a new instance of dma_ops,
> dw25gmac400_dma_ops is introduced.
> To support the current needs, a simple one-to-one mapping of dw25gmac's
> logical VDMA (channel) to TC to PDMAs is used. Most of the other dma
> operation functions in existing dwxgamc2_dma.c file are reused whereever

Typo: dwxgmac2_dma.c

> applicable.
> Added setup function for DW25GMAC's stmmac_hwif_entry in stmmac core.

In a previous review, I questioned the use of DWMAC_CORE_25GMAC and
asked about its version numberspace. I believe you indicated that the
version numberspace is the same as the existing XGMAC core.

I'm going to question the value of adding DWMAC_CORE_25GMAC.

1. What is the value of splitting DWMAC_CORE_25GMAC from
   DWMAC_CORE_XGMAC given that it's in the same versioning numberspace
   as XGMAC, and most tests (via dwmac_is_xgmac()) test for XGMAC or
   25GMAC?

2. Have you reviewed all the places that explicitly test for
   DWMAC_CORE_XGMAC, looking at their "false" paths (for non-XGMAC
   cores) to determine whether they are suitable? For example:

        if (priv->plat->core_type == DWMAC_CORE_XGMAC)
                ndev->max_mtu = XGMAC_JUMBO_LEN;
        else if (priv->plat->enh_desc || priv->synopsys_id >= DWMAC_CORE_4_00)
                ndev->max_mtu = JUMBO_LEN;
        else
                ndev->max_mtu = SKB_MAX_HEAD(NET_SKB_PAD + NET_IP_ALIGN);

   XGMAC can handle a max MTU of 16368, but with your code using
   DWMAC_CORE_25GMAC, we fall back to the next test, which tests the
   IP version against 0x40, and uses a max MTU of 9000. Given that
   DWMAC_CORE_4_00 is a different "version number space" this seems
   wrong.

3. Looking at the MDIO code, this looks very wrong if you're
   introducing DWMAC_CORE_25GMAC. Have you tested MDIO accesses?

   dwxgmac2_setup() is called for DWMAC_CORE_XGMAC core-type. In
   stmmac_mdio_register(), DWMAC_CORE_XGMAC uses different functions
   for MDIO bus access for C22 and C45 from other cores - it uses the
   stmmac_xgmac2_mdio_* functions.

   These use stmmac_xgmac2_c45_format() and stmmac_xgmac2_c22_format()
   to format the register values which do not depend on mii.*_mask, but
   do use mii.address and mii.data for the register offsets. Thus, is
   there any point to setting mii.addr_mask and mii.reg_mask ?

   For non-DWMAC_CORE_XGMAC cores, we fall back to the stmmac_mdio_*()
   functions, which for non-DWMAC_CORE_GMAC4 will only support Clause
   22 access, not Clause 45 - which would be very strange for a 25G
   core.

4. What about the feature printing in
   stmmac_main.c::stmmac_dma_cap_show() ?

5. What about similar tests in stmmac_est.c and stmmac_ethtool.c ?



-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
