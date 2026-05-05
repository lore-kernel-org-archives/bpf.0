Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64F1747DD67
	for <bpf@vger.kernel.org>; Tue,  5 May 2026 18:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778005375; cv=none; b=Wz8l0rn+ktoZGpP9oqrsCNM7wtDiVALAfBFeKwgat3M1GM+Cj6si5ftRZbtATLFS7MxpE50YsjZF9zjaTadVZIeSmCOC0V89N0cdYRRD5J5l6YCCxSechRbBxe0xxMwZOb89k9A7RlJbjIPUI8YYfm53m3xZFg0v+I6UaWJ6ngg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778005375; c=relaxed/simple;
	bh=ljqh9ILO8C1TxfFWlFOzr3OhrZCnXLkx4psYS4kQLWI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Dg4g+JY/ybZ0YEZmQeHQvGtuhvJPym5jEalHWJJ8lKKYCrC0XRWhVFtEV1VYQE+ju2VC0W8y76yoQx3r+v/XbDXjsf+z2Pt7I2du0uz42YZYeX2AynajOSJTmoxp/OkpP27PsMMl4p3SXTS8UKk7+EUk7VpTkEQGQvR7KpvdVXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nKeim18P; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nKeim18P"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB605C2BCB4;
	Tue,  5 May 2026 18:22:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778005375;
	bh=ljqh9ILO8C1TxfFWlFOzr3OhrZCnXLkx4psYS4kQLWI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=nKeim18P0TjXSQPq34/6fPCcqn2/X89COoEIPIA5EsdF51NeQ2hT6Bf1zf98tXo2R
	 ZEBzRG0MW2YhOjSR0eP6sALZPXFGDXGEm+W72yG/B0r0Fmp60qHFB/+9MIVanjDWDJ
	 4gBBHofzG2ezXA4doNhL/2bRF8c5UibhEhmCdnQk5Y0IgiG5X7Q8wabzAbNL3skGpI
	 uR2+9V8OLzFMmSCtpx/aMhzjDgrzhn1P8iqQLxAj/y/fAPhQC5fCRGFpxD5ZNnYlVe
	 m/CaiZEBmWHVQexJChrXt+A0aQBzm/FxS/xl3GBxZYhVkYoSBUivZUIMrLh++igm2C
	 WgvbJIjKduzWg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v3 03/13] net: microchip: fdma: add PCIe ATU
 support
Reply-To: sashiko@lists.linux.dev
To: "Daniel Machon" <daniel.machon@microchip.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260504-lan966x-pci-fdma-v3-3-a56f5740d870@microchip.com>
References: <20260504-lan966x-pci-fdma-v3-3-a56f5740d870@microchip.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 05 May 2026 18:22:54 +0000
Message-Id: <20260505182254.DB605C2BCB4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Critical] Writing a potentially unaligned host DMA address to the ATU ta=
rget register causes hardware truncation, leading to corrupted DMA memory a=
ccesses.
- [High] ATU hardware state is not cleared during initialization, which can=
 lead to wild DMAs from stale window configurations.
--

commit e1449c4cacf5f519b9e9335c915ef4cb12b7ad20
Author: Daniel Machon <daniel.machon@microchip.com>

net: microchip: fdma: add PCIe ATU support

This commit adds PCIe Address Translation Unit (ATU) support for the
microchip fdma driver. It divides the outbound address space into six
regions and maps coherent DMA memory allocations to these regions for PCIe
endpoint operation.

> diff --git a/drivers/net/ethernet/microchip/fdma/fdma_pci.c b/drivers/net=
/ethernet/microchip/fdma/fdma_pci.c
> new file mode 100644
> index 0000000000000..1bd41eaa58a4b
> --- /dev/null
> +++ b/drivers/net/ethernet/microchip/fdma/fdma_pci.c

[ ... ]

> +/* Map a host DMA address into a free outbound region. */
> +struct fdma_pci_atu_region *
> +fdma_pci_atu_region_map(struct fdma_pci_atu *atu, u64 target_addr, int s=
ize)
> +{
> +	struct fdma_pci_atu_region *region;

[ ... ]

> +	region->target_addr =3D target_addr;
> +	region->in_use =3D true;
> +
> +	/* Enable first, according to datasheet section 3.24.7.4.1 */
> +	fdma_pci_atu_region_enable(region);
> +	fdma_pci_atu_configure_translation(region);
> +
> +	return region;
> +}

Could this lead to corrupted DMA memory accesses due to hardware truncation?

The target_addr passed here comes from fdma_alloc_coherent() which uses
dma_alloc_coherent() and only guarantees PAGE_SIZE alignment (e.g., 4KB).

However, the ATU region size is explicitly aligned to 64KB
(FDMA_PCI_ATU_REGION_ALIGN). PCIe ATUs typically use bitwise substitution
for the address offset and ignore or truncate the lower bits of the target
address register.

If the allocated DMA address is 4KB-aligned but not 64KB-aligned, and the
ATU hardware truncates the lower bits, will this cause a mismatch since
fdma_pci_atu_translate_addr() computes the descriptor address assuming
the exact, untruncated target_addr was used?

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
> +}

Could this leave the hardware in an inconsistent state and lead to wild DMAs
from stale window configurations?

This initializes the software tracking array, but does not appear to issue
any writes to the hardware to clear or disable the ATU windows.

In scenarios like driver unbind/bind or kexec, the ATU hardware might
retain its previously configured target addresses and enable bits. Should
all ATU regions be explicitly disabled during initialization to prevent
residual traffic from using stale host physical addresses?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260504-lan966x-pc=
i-fdma-v3-0-a56f5740d870@microchip.com?part=3D3
