Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CB1426059D
	for <bpf@vger.kernel.org>; Sat, 30 May 2026 00:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780101877; cv=none; b=kezQ3qhTJj3FQ2SvbkKPfcPEv/gYjzP5Ia9BXAmjXNkX8vIpGZhvsMZvVvFKpQB1ekoUJB1BOSPC7p0Md1m29znJkxI5TvMLYHuJDYYLFaq5vdbMtF2fHiPUsocnju8vG8hBvowu4S0pK4SReQzZJydV4X1/jLFNBl10cjx7mSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780101877; c=relaxed/simple;
	bh=DmiAZh3HQ8ZDe85lQd2lK+zTp34z6VSmu7U0WYZqgTU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=i03yvC/eh50oLs/IwY8veZ0YMpFuoM8xstNeCHFJUfZxG+IksshR7DrqEDVj2rqi+ykKPLsXYBi+1vrYIFcWvM2eai3Xov4KbXHU2ZY678JBGX/C9W+r+ByDtqOYq2q00pRQfH/aEXZn/8Vl3ozdzqkLXAulZFUQtTmzniIAxTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kRUztA9W; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kRUztA9W"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FB791F00898;
	Sat, 30 May 2026 00:44:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780101876;
	bh=iR3SxJgTv5WHMV1lADX6CKuGTyBAIqQSYIi/dg8hEPc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kRUztA9WRtXPh40svtP9vI1BwVGyM3AG14MIGPdVeAwx0nl4mevgcdGtlfwuyRwjk
	 yG3maUBPomfFLTOoW2RdsmJ9Fu7SPARc6Pe3K99Cr6+MpJUQme42ejZ0L3wcj9nQS5
	 Hv6gIDYdPYtQcBwo4X6gAS6Tr/hUGRMi0lv/y+sf5evvQinzKrA+uCVLB2pS4/Kn+E
	 dKPJDFc8D+R+SQqd+sA9V6DE2Kw2V6iX92Lr2hyVSqy2E7/saOknyxwpqGFvPpno7T
	 YRJjRJP5yhliSWhy0jJKYXJKyax+I6rvG1RFPZWdqzrPSE1pUcurjJSR8GAoJ739eJ
	 /QMf9oAgSzKjg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v5 03/13] net: microchip: fdma: add PCIe ATU
 support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Daniel Machon" <daniel.machon@microchip.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260520-lan966x-pci-fdma-v5-3-ca56197ae05b@microchip.com>
References: <20260520-lan966x-pci-fdma-v5-3-ca56197ae05b@microchip.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 30 May 2026 00:44:36 +0000
Message-Id: <20260530004436.4FB791F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Medium] The ATU outbound window limit is statically configured to its ma=
ximum size instead of being tightly constrained to the allocated DMA buffer=
 size.
- [Medium] Hardware ATU regions are not explicitly disabled during initiali=
zation, risking stray DMAs from stale configuration.
- [Low] The block comment detailing the ATU regions contains a mathematical=
 error, contradicting the actual hardware configuration.
--

commit 474737a9138a576d895670ba7334d761b2fb9464
Author: Daniel Machon <daniel.machon@microchip.com>
net: microchip: fdma: add PCIe ATU support

When lan966x or lan969x operates as a PCIe endpoint, the internal FDMA
engine cannot directly access host memory. Instead, DMA addresses must
be translated through the PCIe Address Translation Unit (ATU), which
provides outbound windows mapping internal addresses to PCIe bus addresses.

> diff --git a/drivers/net/ethernet/microchip/fdma/fdma_pci.c b/drivers/net=
/ethernet/microchip/fdma/fdma_pci.c
> new file mode 100644
> index 0000000000000..1bd41eaa58a4b
> --- /dev/null
> +++ b/drivers/net/ethernet/microchip/fdma/fdma_pci.c
> @@ -0,0 +1,182 @@
[ ... ]
> + * +-------------+------------+------------+-----+------------+
> + * | Index       | Region 0   | Region 1   | ... | Region 5   |
> + * +-------------+------------+------------+-----+------------+
> + * | Base addr   | 0x10000000 | 0x12aa0000 | ... | 0x1d500000 |

[Severity: Low]
This isn't a bug, but there appears to be a mathematical error in the
comment. The computed region size is round_down((0x1fffffff - 0x10000000) /
6, BIT(16)) which equals 0x2aa0000. Using this size, Region 5's base address
would be 0x10000000 + (5 * 0x2aa0000) =3D 0x1d520000, not 0x1d500000.

> + * | Limit addr  | 0x12a9ffff | 0x1553ffff | ... | 0x1ff9ffff |
> + * | Target addr | host dma   | host dma   | ... | host dma   |
> + * +-------------+------------+------------+-----+------------+

[ ... ]

> +struct fdma_pci_atu_region *
> +fdma_pci_atu_region_map(struct fdma_pci_atu *atu, u64 target_addr, int s=
ize)
> +{
> +	struct fdma_pci_atu_region *region;
> +
> +	if (!atu)
> +		return ERR_PTR(-EINVAL);
> +
> +	if (size <=3D 0)
> +		return ERR_PTR(-EINVAL);
> +
> +	if (size > fdma_pci_atu_region_size())
> +		return ERR_PTR(-E2BIG);
> +
> +	region =3D fdma_pci_atu_region_get_free(atu);
> +	if (IS_ERR(region))
> +		return region;
> +
> +	region->target_addr =3D target_addr;
> +	region->in_use =3D true;
> +
> +	/* Enable first, according to datasheet section 3.24.7.4.1 */
> +	fdma_pci_atu_region_enable(region);
> +	fdma_pci_atu_configure_translation(region);
> +
> +	return region;
> +}

[Severity: Medium]
Could this dynamically program the limit_addr to base_addr + size - 1
to enforce strict DMA bounds, rather than using the statically
configured ~42MB limit?

Since the actual DMA buffer allocations are typically much smaller, the
current approach massively over-provisions the DMA window. Could a
hardware bug or malicious endpoint firmware exploit this to perform
out-of-bounds DMAs and silently corrupt adjacent host physical memory?

[ ... ]

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

[Severity: Medium]
Should the initialization explicitly disable all hardware ATU regions by
clearing their enable bits?

Because the PCIe endpoint controller cannot be hard-reset by the driver
without dropping the PCIe link to the host, the ATU registers might
retain state from the bootloader or a previous kernel crash. Could
stray DMAs to host memory occur before the kernel explicitly reclaims
and reconfigures these regions if they are left enabled?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260520-lan966x-pc=
i-fdma-v5-0-ca56197ae05b@microchip.com?part=3D3
