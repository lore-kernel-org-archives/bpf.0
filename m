Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A0741B7910;
	Tue,  7 Apr 2026 02:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775527798; cv=none; b=us36GnsHK9Q7sAaLJrTB3U4DIUa2xGru7fAG6LJO6GMy1Igj+emAjzdySAHb0ZPeWW3ihy0qL7MzDX1VoN+qt74xbXvsA2cRXPQN3yh2HwbPn0IQOEvVP2RM6twdmvs/+Bakg3/BJZ1rgYXoEW96PH3DM5ky5/ng+dQkia0Wwhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775527798; c=relaxed/simple;
	bh=8zm7b1Dp5ZpiFTf/LgmJSJNCehJUDDM+96sCJdAfMgk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BAcLrcQsSSfmLTKC66oFasLjORTF6nzSaeqq4k3qgDus/SpraXVn00gh+FWiW5t973DctiBFO5e/EPPNzbgD0vcVmlm7tUxI/rPIP2TRuOf7bYHCZxNIEvD82frVdrr/GZhC7zDRiQ8xocN5o1EuCGB6zFAg/4yr4exyId9J/cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CqEIbu1/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CqEIbu1/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FFE6C4CEF7;
	Tue,  7 Apr 2026 02:09:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775527798;
	bh=8zm7b1Dp5ZpiFTf/LgmJSJNCehJUDDM+96sCJdAfMgk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CqEIbu1/BUSfAdrjcjmNOZAJzrixByXza3QuIRv7Ki8WNp20xG6Y5WIYpg3/iC1ho
	 n6oOPnLOdUQGb0gTsdxxDVKiCFGWXmuKf2djzu+uNDe6lxLStdCdcQz2hhIX8B2m5C
	 gvBM6uPvyqvl+UGZg1ZYLRSFKCPjBjjCYhBWVtyxbMj/MFIjOcE4WVYGepsnqgWKU1
	 /JPYIoNWWQLmLbjcIqDBUq59YxwXDWBqXbUGRZ7jrPC9msOBw6R4SRWaDRoC4GdN0T
	 MI7GF+IHUhOTM2noxKAU7HNEVgaRMR0OxgpQM5W6spcoVhPof03yDWIQypOlDfWxmI
	 uQqVRr9fy+tyg==
From: Jakub Kicinski <kuba@kernel.org>
To: jitendra.vegiraju@broadcom.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	alexandre.torgue@foss.st.com,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	mcoquelin.stm32@gmail.com,
	bcm-kernel-feedback-list@broadcom.com,
	richardcochran@gmail.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	rmk+kernel@armlinux.org.uk,
	rohan.g.thomas@altera.com,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	bpf@vger.kernel.org,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	sdf@fomichev.me,
	me@ziyao.cc,
	siyanteng@cqsoftware.com.cn,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	weishangjuan@eswincomputing.com,
	wens@kernel.org,
	vladimir.oltean@nxp.com,
	lizhi2@eswincomputing.com,
	boon.khai.ng@altera.com,
	maxime.chevallier@bootlin.com,
	chenchuangyu@xiaomi.com,
	yangtiezhu@loongson.cn,
	ovidiu.panait.rb@renesas.com,
	chenhuacai@kernel.org,
	florian.fainelli@broadcom.com,
	quic_abchauha@quicinc.com
Subject: Re: [PATCH net-next v9 1/4] net: stmmac: Add DW25GMAC support in stmmac core driver
Date: Mon,  6 Apr 2026 19:09:54 -0700
Message-ID: <20260407020954.3674529-1-kuba@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260402213629.1996133-2-jitendra.vegiraju@broadcom.com>
References: <20260402213629.1996133-2-jitendra.vegiraju@broadcom.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
Subject: net: stmmac: Add DW25GMAC support in stmmac core driver

This commit introduces support for the DW25GMAC hardware in the stmmac
core driver, which uses a new Hyper-DMA (HDMA) architecture. It adds a
new DMA ops instance mapping virtual DMA channels to physical DMA
channels and sets up the basic device configurations.

> diff --git a/drivers/net/ethernet/stmicro/stmmac/dw25gmac.c b/drivers/net/ethernet/stmicro/stmmac/dw25gmac.c
> new file mode 100644
> index 0000000000000..82eb22bff73e0
> --- /dev/null
> +++ b/drivers/net/ethernet/stmicro/stmmac/dw25gmac.c

[ ... ]

> +static int rd_dma_ch_ind(void __iomem *ioaddr, u8 mode, u32 channel)
> +{
> +	u32 reg_val = 0;
> +
> +	reg_val |= FIELD_PREP(XXVGMAC_MODE_SELECT, mode);
> +	reg_val |= FIELD_PREP(XXVGMAC_ADDR_OFFSET, channel);
> +	reg_val |= XXVGMAC_CMD_TYPE | XXVGMAC_OB;
> +	writel(reg_val, ioaddr + XXVGMAC_DMA_CH_IND_CONTROL);
> +	return readl(ioaddr + XXVGMAC_DMA_CH_IND_DATA);
> +}

Does this readl() need to wait for the hardware to clear the XXVGMAC_OB
(Operation Busy) bit? Returning immediately might read uninitialized or
stale data if the hardware hasn't finished the fetch.

> +
> +static void wr_dma_ch_ind(void __iomem *ioaddr, u8 mode, u32 channel, u32 val)
> +{
> +	u32 reg_val = 0;
> +
> +	writel(val, ioaddr + XXVGMAC_DMA_CH_IND_DATA);
> +	reg_val |= FIELD_PREP(XXVGMAC_MODE_SELECT, mode);
> +	reg_val |= FIELD_PREP(XXVGMAC_ADDR_OFFSET, channel);
> +	reg_val |= XGMAC_OB;

This isn't a bug, but should this use the XXVGMAC_OB macro instead of
XGMAC_OB here for consistency?

> +	writel(reg_val, ioaddr + XXVGMAC_DMA_CH_IND_CONTROL);
> +}

Similarly, does this function need to poll for the busy bit to clear after
the writel()? If back-to-back operations occur, the next indirect write
might overwrite the control and data registers while the hardware is still
processing this request.

[ ... ]

> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
> index f02b434bbd505..64c38de294da2 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c

[ ... ]

> -int dwxgmac2_setup(struct stmmac_priv *priv)
> +static void dwxgmac2_common_setup(struct stmmac_priv *priv, char *mac_name)
>  {

This isn't a bug, but should mac_name be declared as const char * since it
is passed string literals like "XGMAC2" and "DW25GMAC"? This avoids
discarded-qualifiers compiler warnings.

>  	struct mac_device_info *mac = priv->hw;
>  
> -	dev_info(priv->device, "\tXGMAC2\n");
> +	dev_info(priv->device, "\t%s\n", mac_name);

[ ... ]
-- 
pw-bot: cr
