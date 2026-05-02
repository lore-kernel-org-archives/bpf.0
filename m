Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6613E353ED9
	for <bpf@vger.kernel.org>; Sat,  2 May 2026 15:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777737379; cv=none; b=mP/E+7jqN4s2Ogokp2w69uuf97U21SRQdlHHNofsH1HRAmHo5ZhT4HOIgPuL9TIew1GV7aT6o+9Ez/yuNxlnTaYQlZNiDvK3OW5YQ0kSoz+qGNStGt2bsaWvEqLvhAOmUzxl9Q95OMc0Cfmmxmo1xn1yvRyTsrdlgT6Kn7jSxVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777737379; c=relaxed/simple;
	bh=2fvirarBl916LCvUw0OuvqLNKnStFg47YuzKgYYIuAg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=aWwMCmJuvXjFVuFBzdP96NDKHt3m35ff7dzLwvRS2p4FLWoql+1OLaG/dUcbEi+39NliPkJzkJ/OrN2q7IlXNSud+S+j24dorT7eXzoDuz+zJ7z0LsBkgJDn61nNsJNDvk4AQotcncRebm3TqnzoF3UHzKmXwglgx9IM2ppGGN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ugOxBwA3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ugOxBwA3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC605C19425;
	Sat,  2 May 2026 15:56:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777737379;
	bh=2fvirarBl916LCvUw0OuvqLNKnStFg47YuzKgYYIuAg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=ugOxBwA3FL2ysPncyT0dL2kzR5yDd8GwXD//yWkunCpRGs2Quho+XSsQCMjtv0kqW
	 EaMohZ3h3qzELq4jX6owFyMzlzULNLTp1cXSYYfxFrlqHBiXy25j8y/Dp5fIuX29x+
	 R7UeRmPBz5ejJS91LjYUpJ56Vah4GS4eUaCy2nxH05BQO/2/a23HICnUKG5xtoapRD
	 7M6PqUXj5ksfK569MvkP61pEgXuCqUGdqMwaXVQO0qqcCT+w9bDW1CHwoSJxfhdmNl
	 fE9y3ultEzwVb45ezqP4TnCSePpfhvQkmmfP3j+xU/86hAUaPysYWbL89T+9ev/eMp
	 xTyWQ35H/MNwQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next 10/12] net: stmmac: tc956x: add TC956x/QPS615
 support
Reply-To: sashiko@lists.linux.dev
To: "Alex Elder" <elder@riscstar.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260501155421.3329862-11-elder@riscstar.com>
References: <20260501155421.3329862-11-elder@riscstar.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 02 May 2026 15:56:18 +0000
Message-Id: <20260502155618.EC605C19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:
- [High] The RX queue IRQ mapping loop incorrectly checks `res->tx_irq[i]` =
instead of `res->rx_irq[i]` for failures.
- [High] DMA address truncation on 32-bit architectures leads to corrupted =
hardware DMA programming.
- [High] Mapped IRQs are never disposed, leaking descriptors and causing a =
WARN on device removal.
- [Medium] Hardware clocks and resets are leaked on `probe()` and `mac_enab=
le()` error paths.
- [Medium] OF node reference leak for `mdio_node` on probe error paths and =
device removal.
--

commit e138cc3787ee995063c093b9ca94f6ca453bbcda
Author: Daniel Thompson <daniel@riscstar.com>
Subject: net: stmmac: tc956x: add TC956x/QPS615 support

This commit adds support for the Toshiba TC956x eMAC/MSIGEN combination,
implemented as a driver for an auxiliary bus device that bridges TC956x
level interrupts to PCIe MSIs.

> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-tc956x.c b/drivers=
/net/ethernet/stmicro/stmmac/dwmac-tc956x.c
> new file mode 100644
> index 000000000000..27ff83dd3bd9
> --- /dev/null
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-tc956x.c

[ ... ]

> +static int tc956x_mac_enable(struct tc956x_data *td)
> +{
> +	const struct tc956x_chip *chip =3D td->auxbus_data->chip;
> +	struct plat_stmmacenet_data *plat =3D td->plat;
> +	u32 id =3D td->auxbus_data->mac_id;
> +	int ret;
> +
> +	tc956x_clock_enable(chip, id, MAC_CLOCK_TX);
> +	tc956x_clock_enable(chip, id, MAC_CLOCK_RX);
> +	tc956x_clock_enable(chip, id, MAC_CLOCK_ALL);
> +	if (id)
> +		tc956x_clock_enable(chip, id, MAC_CLOCK_RMII);
> +
> +	/* Set the speed related registers */
> +	ret =3D tc956x_mac_configure(td, plat->max_speed);
> +	if (ret)
> +		return ret;

If tc956x_mac_configure() fails, will this leak the clocks that were just
enabled since tc956x_clock_disable() is not called?

[ ... ]

> +static void tc956x_dma_init_rx_chan(struct stmmac_priv *priv,
> +				    void __iomem *ioaddr,
> +				    struct stmmac_dma_cfg *dma_cfg,
> +				    dma_addr_t phy, u32 chan)
> +{
> +	dma_addr_t translated =3D phy + TC956X_SLV00_SRC_ADDR;

If dma_addr_t is 32-bit on the target architecture, will adding
TC956X_SLV00_SRC_ADDR (0x1000000000ULL) to phy truncate the result and cause
the upper 32 bits to be 0?=20

Should translated be explicitly typed as u64? The same pattern appears
in tc956x_dma_init_tx_chan(), tc956x_desc_set_addr(), and
tc956x_desc_set_sec_addr().

[ ... ]

> +static int tc956x_dwmac_parse_dt(struct tc956x_data *td)
> +{
> +	struct device_node *mdio_node;
> +	struct device *dev =3D td->dev;
> +	struct device_node *np;
> +
> +	np =3D dev_of_node(dev);
> +	if (!np)
> +		return dev_err_probe(dev, -EINVAL, "no devicetree node\n");
> +
> +	/* Find the MDIO bus */
> +	for_each_child_of_node(np, mdio_node) {
> +		if (of_device_is_compatible(mdio_node,
> +					    "snps,dwmac-mdio"))
> +			break;
> +	}
> +
> +	/* Pass the MDIO bus (if there is one) to the core driver */
> +	if (mdio_node) {
> +		td->plat->mdio_node =3D mdio_node;
> +		td->plat->mdio_bus_data->needs_reset =3D true;
> +	}
> +
> +	return 0;
> +}

Since the loop breaks early when a compatible node is found, does this leak
the reference to mdio_node?=20

Is a call to of_node_put() needed in tc956x_dwmac_remove() and on probe
error paths?

[ ... ]

> +static int tc956x_stmmac_resources_init(struct tc956x_data *td,
> +					struct stmmac_resources *res)
> +{
> +	struct irq_domain *irq_domain =3D td->irq_domain;
> +	u32 i;
> +
> +	res->irq =3D irq_create_mapping(irq_domain, HWIRQ_EVENT);
> +	if (!res->irq)
> +		return -EINVAL;
> +
> +	for (i =3D 0; i < td->plat->tx_queues_to_use; i++) {
> +		res->tx_irq[i] =3D irq_create_mapping(irq_domain, HWIRQ_TX0 + i);
> +		if (!res->tx_irq[i])
> +			return -EINVAL;
> +	}
> +
> +	for (i =3D 0; i < td->plat->rx_queues_to_use; i++) {
> +		res->rx_irq[i] =3D irq_create_mapping(irq_domain, HWIRQ_RX0 + i);
> +		if (!res->tx_irq[i])
> +			return -EINVAL;
> +	}

Should this be checking res->rx_irq[i] instead of res->tx_irq[i]?=20

If tx_irq[i] was previously set during the TX mapping loop, this check won't
catch RX mapping failures and uninitialized IRQs could be left in the
resource structure.

[ ... ]

> +static int tc956x_dwmac_probe(struct auxiliary_device *adev,
> +			      const struct auxiliary_device_id *id)
> +{

[ ... ]

> +	ret =3D tc956x_mac_enable(td);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "failed to enable MAC\n");
> +
> +	ret =3D stmmac_dvr_probe(dev, td->plat, &res);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "failed stmmac probe\n");
> +
> +	return 0;
> +}

Does this error path need to call tc956x_mac_disable(td) to unwind the
hardware state if stmmac_dvr_probe() fails?

[ ... ]

> +static void tc956x_dwmac_remove(struct auxiliary_device *adev)
> +{
> +	struct device *dev =3D &adev->dev;
> +	struct net_device *ndev =3D dev_get_drvdata(dev);
> +	struct stmmac_priv *priv =3D netdev_priv(ndev);
> +	struct tc956x_data *td =3D priv->plat->bsp_priv;
> +
> +	stmmac_dvr_remove(dev);
> +	tc956x_mac_disable(td);
> +}

Are the IRQs created by irq_create_mapping() leaking here?

There appear to be no calls to irq_dispose_mapping() on device removal or
probe error paths. While IRQ_DOMAIN_FLAG_DESTROY_GC frees the generic
chip data, the descriptors might leak and trigger a warning in
irq_domain_remove().

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260501155421.3329=
862-1-elder@riscstar.com?part=3D10
