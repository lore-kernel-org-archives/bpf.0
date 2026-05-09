Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1432384231
	for <bpf@vger.kernel.org>; Sat,  9 May 2026 08:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778315238; cv=none; b=jw179ieE+iUwtALcEhOWbsKu03b6XLoyEaEP0o26z9LW0xthPlbC/31UrDZAxaPV5hEv8wR7OCNUjRG+ki4SszVwMLh8EFduCs8dcTms+YPR+343DI5iFGevyBet+SEPjRIARzH+I+wg3w8VsaIvcFJZKFEA7DjC0I3DLeLNtCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778315238; c=relaxed/simple;
	bh=Hy9d+Vc0PLyya/fVUh9x8+I2w+ZiZJC/7x38q3PL3io=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=mTgDZwPK7eAZGzLRjfFUFWdpQaXZ8TLnmCDBWBO6prGccwzm05ak47D1OsistxgYaTtC3s0LpKyLb81hVI14Ac70vHwV7NuRy77w3Fd92eOyv5Qj9krsTHN/akhDd9v5Lo2XvT4FcdGhjsx5hQr1G7QFil6Q+8RspM3oT9/0AoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BuVl6fuj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BuVl6fuj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33278C2BCB2;
	Sat,  9 May 2026 08:27:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778315238;
	bh=Hy9d+Vc0PLyya/fVUh9x8+I2w+ZiZJC/7x38q3PL3io=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=BuVl6fujA+d4rk5/OCf/EzYA45kRtaOApB97fRTcqcOPfYWWVqTKjzz5vt/xo5fIo
	 4Udty+7VlAxA6LSqzg25JjH15o75Ux0H1SV1+lFwSsS86CQRevEL4VhfLTdXXc55JF
	 h7fOe5zr5A+JImmONUhSLEBMw2Kl7cZys7JD8MivGHAzdbWOjK4o6VCL2B91bTWb5u
	 SuMbmbcIA3ISsWy2Kid/hmItoC7ymHHfDpePMtEPihGAWtE8dTfsgbw2Avm0UNOXHX
	 eJXazDtkraUdGRfzYjHEDJ8Ber/VY1Iet3yBXWk3gYCAC5OpfsuJ/gW79luZC8+hOu
	 /1fKn57nr0rvg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v4 03/13] net: microchip: fdma: add PCIe ATU
 support
Reply-To: sashiko@lists.linux.dev
To: "Daniel Machon" <daniel.machon@microchip.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260508-lan966x-pci-fdma-v4-3-14e0c89d8d63@microchip.com>
References: <20260508-lan966x-pci-fdma-v4-3-14e0c89d8d63@microchip.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 09 May 2026 08:27:17 +0000
Message-Id: <20260509082718.33278C2BCB2@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] Race condition and unsafe unmap ordering in the shared ATU region =
pool.
- [High] Missing ATU hardware initialization and REGION_CTRL1 configuration.
- [Medium] ATU translation window is hardcoded to the maximum region size, =
bypassing DMA isolation.
- [Medium] Dangling pointers left after DMA teardown risk double-free memor=
y corruption.
--

commit 22984db44c5308e0df119c7e94e5241b187dad51
Author: Daniel Machon <daniel.machon@microchip.com>

net: microchip: fdma: add PCIe ATU support

When operating as a PCIe endpoint, the lan966x/lan969x FDMA engine needs to
map outbound DMA addresses through a PCIe Address Translation Unit (ATU).
This patch adds functions to allocate FDMA memory and map it into one of
six equally-sized ATU outbound regions.

> diff --git a/drivers/net/ethernet/microchip/fdma/fdma_api.c b/drivers/net=
/ethernet/microchip/fdma/fdma_api.c
> index e78c3590da9e6..e0c2b137afef7 100644
> --- a/drivers/net/ethernet/microchip/fdma/fdma_api.c
> +++ b/drivers/net/ethernet/microchip/fdma/fdma_api.c

[ ... ]

> +#if IS_ENABLED(CONFIG_MCHP_LAN966X_PCI)
> +/* Allocate coherent DMA memory and map it in the ATU. */
> +int fdma_alloc_coherent_and_map(struct device *dev, struct fdma *fdma,
> +				struct fdma_pci_atu *atu)
> +{
> +	struct fdma_pci_atu_region *region;
> +	int err;
> +
> +	err =3D fdma_alloc_coherent(dev, fdma);
> +	if (err)
> +		return err;
> +
> +	region =3D fdma_pci_atu_region_map(atu, fdma->dma, fdma->size);
> +	if (IS_ERR(region)) {
> +		fdma_free_coherent(dev, fdma);

Could leaving fdma->dcbs populated after calling fdma_free_coherent() cause
a double-free if the caller has a teardown routine that checks for non-NULL
pointers?

> +		return PTR_ERR(region);
> +	}
> +
> +	fdma->atu_region =3D region;
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(fdma_alloc_coherent_and_map);
> +
> +/* Free coherent DMA memory and unmap the memory in the ATU. */
> +void fdma_free_coherent_and_unmap(struct device *dev, struct fdma *fdma)
> +{
> +	fdma_pci_atu_region_unmap(fdma->atu_region);
> +	fdma_free_coherent(dev, fdma);

Similarly, should fdma->atu_region and fdma->dcbs be cleared after being
freed to prevent dangling pointers?

> +}
> +EXPORT_SYMBOL_GPL(fdma_free_coherent_and_unmap);
> +#endif

[ ... ]

> diff --git a/drivers/net/ethernet/microchip/fdma/fdma_pci.c b/drivers/net=
/ethernet/microchip/fdma/fdma_pci.c
> new file mode 100644
> index 0000000000000..1bd41eaa58a4b
> --- /dev/null
> +++ b/drivers/net/ethernet/microchip/fdma/fdma_pci.c

[ ... ]

> +/* Configure the address translation in the ATU. */
> +static void
> +fdma_pci_atu_configure_translation(struct fdma_pci_atu_region *region)
> +{
> +	struct fdma_pci_atu *atu =3D region->atu;
> +	int idx =3D region->idx;

Does the ATU require REGION_CTRL1 (TLP Type at offset 0x0) to be configured
here?

If a bootloader previously configured an ATU region for Configuration or I/O
accesses, could the register retain that type and cause memory accesses to
be translated into invalid TLP types?

> +
> +	writel(lower_32_bits(region->base_addr),
> +	       fdma_pci_atu_addr_get(atu->addr,
> +				     FDMA_PCI_ATU_LWR_BASE_ADDR, idx));
> +
> +	writel(upper_32_bits(region->base_addr),
> +	       fdma_pci_atu_addr_get(atu->addr,
> +				     FDMA_PCI_ATU_UPP_BASE_ADDR, idx));
> +
> +	/* Upper limit register only needed with REGION_SIZE > 4GB. */
> +	writel(region->limit_addr,
> +	       fdma_pci_atu_addr_get(atu->addr, FDMA_PCI_ATU_LIMIT_ADDR, idx));

Since the LIMIT_ADDR register is always programmed to the maximum static
region size, does this allow the FDMA engine to read or write beyond its
intended buffer into adjacent host memory?

Should the limit register be dynamically programmed using the requested size
passed to fdma_pci_atu_region_map() instead?

> +
> +	writel(lower_32_bits(region->target_addr),
> +	       fdma_pci_atu_addr_get(atu->addr,
> +				     FDMA_PCI_ATU_LWR_TARGET_ADDR, idx));
> +
> +	writel(upper_32_bits(region->target_addr),
> +	       fdma_pci_atu_addr_get(atu->addr,
> +				     FDMA_PCI_ATU_UPP_TARGET_ADDR, idx));
> +}
> +
> +/* Find an unused ATU region. */
> +static struct fdma_pci_atu_region *
> +fdma_pci_atu_region_get_free(struct fdma_pci_atu *atu)
> +{
> +	struct fdma_pci_atu_region *regions =3D atu->regions;
> +
> +	for (int i =3D 0; i < FDMA_PCI_ATU_REGION_MAX; i++) {
> +		if (regions[i].in_use)
> +			continue;

Is there a race condition when accessing the shared atu->regions array?

Since there appears to be no locking, could concurrent allocations claim the
same region and overwrite each other's hardware registers?

> +
> +		return &regions[i];
> +	}
> +
> +	return ERR_PTR(-ENOSPC);
> +}
> +
> +/* Unmap an ATU region, clearing its translation and disabling it. */
> +void fdma_pci_atu_region_unmap(struct fdma_pci_atu_region *region)
> +{
> +	if (IS_ERR_OR_NULL(region))
> +		return;
> +
> +	region->target_addr =3D 0;
> +	region->in_use =3D false;
> +
> +	fdma_pci_atu_region_disable(region);

By setting region->in_use =3D false before disabling the region in hardware,
could a concurrent thread allocate and enable this region, only for this
unmap thread to proceed and clear the hardware translations, leaving the
new allocation disabled?

> +	fdma_pci_atu_configure_translation(region);
> +}
> +EXPORT_SYMBOL_GPL(fdma_pci_atu_region_unmap);

[ ... ]

> +/* Initialize ATU, dividing the OB space into equally sized regions. */
> +void fdma_pci_atu_init(struct fdma_pci_atu *atu, void __iomem *addr)
> +{
> +	struct fdma_pci_atu_region *regions =3D atu->regions;
> +	u32 region_size =3D fdma_pci_atu_region_size();
> +
> +	atu->addr =3D addr;
> +
> +	for (int i =3D 0; i < FDMA_PCI_ATU_REGION_MAX; i++) {
> +		regions[i].base_addr =3D
> +			FDMA_PCI_ATU_OB_START + (i * region_size);
> +		regions[i].limit_addr =3D
> +			regions[i].base_addr + region_size - 1;
> +		regions[i].idx =3D i;
> +		regions[i].atu =3D atu;
> +	}

Should the hardware regions be explicitly disabled during initialization?

If the bootloader left any regions enabled that overlap with the Outbound
space, could they silently intercept DMA traffic before the driver maps
them?

> +}
> +EXPORT_SYMBOL_GPL(fdma_pci_atu_init);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260508-lan966x-pc=
i-fdma-v4-0-14e0c89d8d63@microchip.com?part=3D3
