Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 406FE432BC2;
	Fri,  2 Oct 2026 07:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790926418; cv=none; b=BDHifaRvCQAffUusU7DLim4sr1xeIdqgh8gg6YuYJSYKne9UdyPksFiFurwQix7i7DZNgVWYcDZDPY5RTKqqZnhza9FAfYcFVhGXQwSL2CfCP2z43Z5RPhF98eoa8JdJcjEEQSpWLm5tEC2tf32wg5+CvBYG6sE3JutOQ8uuw58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790926418; c=relaxed/simple;
	bh=ZvtpHeS/9vNUEOab1wIeNoTdJq+X/A2MZ377rK+g7Pg=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uMKp1xBxze85xGar/BzSOadi/qTjUSjRwxBCmZpLvpN2qpuv9Js2CQybknLQ2P+Lr5meTbdHObqUkYvY56euOO2Nj3Q9FmGhhgsLL4STckbm2gX4yPh+P2lXS7OD3h+nWk7kt8sv13sPuVhKmXu2qyYP55uHS+W0LPq4UenBykA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HkDRbHYw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HkDRbHYw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 544F01F000FF;
	Fri,  2 Oct 2026 07:33:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790926415;
	bh=cCVA2bphe9rgIaAkbT8Wl6DzYThQJL8+2Cs7Ytb8KGI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=HkDRbHYwFcy0jd7FZj8ra4WYZUhLGRjebT/KamkCt1t2y85ksNQuN8yMK3JFvGo1d
	 Js2UfJbNq185oy2eZ+WLw9igoTtC6Qs3UXA7C31Udy000Rt8zXDVOi9j8J+AZ9wsWp
	 pIOJMy5mCXF0OffFLvCWIV4y4vWNtzL9Ilj8X38vF4cTcAK0aIYOv4vJTHg3+uiXLa
	 M1fna2or2zC+qIxEw9Mslvvoz0Mn/nNQPJRTeyfYoa/j23JI1P8CpP6lPRuG/wLt1v
	 S1ILz9zX4N2+VUfnWSwiSV2aG5Htr/x0AirEOjGftXkK8BOU4EKcHtG+83yJxEw/uY
	 lGbO+faFz4f/w==
Subject:
 Re: [PATCH net-next v9 03/15] net: microchip: fdma: add PCIe ATU support
From: netdev-bot+sashiko@kernel.org
To: daniel.machon@microchip.com
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horatiu.vultur@microchip.com,
 steen.hegelund@microchip.com, UNGLinuxDriver@microchip.com, ast@kernel.org,
 daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
 sdf@fomichev.me, herve.codina@bootlin.com, arnd@arndb.de,
 gregkh@linuxfoundation.org, mohsin.bashr@gmail.com, horms@kernel.org,
 richardcochran@gmail.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Date: Fri, 02 Oct 2026 07:33:33 +0000
Message-ID: <179092641379.434549.2030178310971788784@kernel.org>
In-Reply-To: <20260928-lan966x-pci-fdma-v9-3-a17caf60f89a@microchip.com>
References: <20260928-lan966x-pci-fdma-v9-3-a17caf60f89a@microchip.com>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] fdma_pci_atu_region_map() in
  drivers/net/ethernet/microchip/fdma/fdma_pci.c is exported.
- [Low] The alignment comment in fdma_pci_atu_region_map()
  (drivers/net/ethernet/microchip/fdma/fdma_pci.c, lines 151-155) says…
- [Low] fdma_pci_atu_region_enable() writes REGION_CTRL2 = BIT(31) with a
  single posted writel().
- [Low] fdma_pci_atu_configure_translation() programs LOWER/UPPER_BASE,
  LIMIT and LOWER/UPPER_TARGET, and fdma_pci_atu_init() only clears…

--

net: microchip: fdma: add PCIe ATU support

This commit adds PCIe ATU outbound window support to the Microchip FDMA
library. When the switch runs as a PCIe endpoint, the lan966x (and later
lan969x) FDMA engine can then reach host memory. The outbound space is
split into six regions, and new helpers combine a coherent DMA allocation
with claiming and programming a region, padding the allocation to the
64KB ATU granularity.

> diff --git a/drivers/net/ethernet/microchip/fdma/fdma_pci.c b/drivers/net/ethernet/microchip/fdma/fdma_pci.c
> new file mode 100644
> index 000000000000..dd1dc46cbc9d
> --- /dev/null
> +++ b/drivers/net/ethernet/microchip/fdma/fdma_pci.c

[ ... ]

> +/* Configure the address translation in the ATU. */
> +static void
> +fdma_pci_atu_configure_translation(struct fdma_pci_atu_region *region)
> +{
> +	struct fdma_pci_atu *atu = region->atu;
> +	int idx = region->idx;
> +
> +	writel(lower_32_bits(region->base_addr),
> +	       fdma_pci_atu_addr_get(atu->addr,
> +				     FDMA_PCI_ATU_LWR_BASE_ADDR, idx));
> +
> +	writel(upper_32_bits(region->base_addr),
> +	       fdma_pci_atu_addr_get(atu->addr,
> +				     FDMA_PCI_ATU_UPP_BASE_ADDR, idx));
> +
> +	/* The OB address space lies entirely below 4GB, so the limit always
> +	 * fits the lower limit register and the upper one is left alone.
> +	 */
> +	writel(region->limit_addr,
> +	       fdma_pci_atu_addr_get(atu->addr, FDMA_PCI_ATU_LIMIT_ADDR, idx));

[Severity: Low]
Should REGION_CTRL1 (offset 0x0) and the upper limit register (offset
0x20) be written explicitly, either here or in fdma_pci_atu_init()?

Neither fdma_pci_atu_configure_translation() nor fdma_pci_atu_init()
writes them. fdma_pci_atu_init() only clears the enable bit through
fdma_pci_atu_region_disable(). As a result, the TLP type, function
number, INCREASE_REGION_SIZE and the upper limit all depend on reset
values.

For comparison, dw_pcie_prog_outbound_atu() in
drivers/pci/controller/dwc/pcie-designware.c always writes CTRL1. On
4.60a and later it also writes the upper limit:

	if (dw_pcie_ver_is_ge(pci, 460A))
		dw_pcie_writel_atu_ob(pci, atu->index, PCIE_ATU_UPPER_LIMIT,
				      upper_32_bits(limit_addr));
	...
	dw_pcie_writel_atu_ob(pci, atu->index, PCIE_ATU_REGION_CTRL1, val);

This driver never changes those registers, so reloading it can't leave
them stale. It would only matter if something else, such as endpoint-side
firmware, had programmed the ATU before the host driver bound. No in-tree
path doing that was found.

Would writing CTRL1 = 0 at init be reasonable hardening?

[ ... ]

> +/* Map a host DMA address into a free outbound region. */
> +struct fdma_pci_atu_region *
> +fdma_pci_atu_region_map(struct fdma_pci_atu *atu, u64 target_addr, int size)
> +{

[ ... ]

> +	/* The ATU region base is only ever aligned to FDMA_PCI_ATU_REGION_ALIGN;
> +	 * require the same alignment of the host target address, since the ATU
> +	 * translates addr - target_addr + base_addr and any misalignment here
> +	 * would shift every translated address by the same amount.
> +	 */

[Severity: Low]
Is the translation direction in this comment reversed?

In struct fdma_pci_atu_region, base_addr is the OB window address and
target_addr is the host DMA address. The file header says the ATU turns
FDMA OB addresses into host DMA addresses, so the hardware computes
target_addr + (addr - base_addr).

The formula in the comment is the host to OB direction. That is what the
software helper fdma_pci_atu_translate_addr() computes:

	return region->base_addr + (addr - region->target_addr);

This does not affect the code's behaviour. Could the comment instead
describe the OB to host translation that the ATU performs?

> +	if (!IS_ALIGNED(target_addr, FDMA_PCI_ATU_REGION_ALIGN))
> +		return ERR_PTR(-EINVAL);

[Severity: Low]
Should size also be checked for FDMA_PCI_ATU_REGION_ALIGN alignment here?

The prototype comment in fdma_pci.h says:

  /* Map a host DMA address into a free ATU region. target_addr and size must be
   * FDMA_PCI_ATU_REGION_ALIGN aligned; a misaligned target_addr returns -EINVAL.
   */

However, fdma_pci_atu_region_map() only rejects a misaligned target_addr.
Any size in the range 0 < size <= fdma_pci_atu_region_size() is accepted
and programmed directly:

	region->limit_addr = region->base_addr + size - 1;

The commit message says the hardware widens the limit to the 64KB
boundary. The padding that keeps the widened window inside owned memory
is applied only in fdma_alloc_coherent_and_map():

	fdma->size = ALIGN(fdma->size, FDMA_PCI_ATU_REGION_ALIGN);

That wrapper is the only caller in the series, so no current path passes
an unaligned size. A future direct caller of the exported
fdma_pci_atu_region_map() could, though, and that would open a window
past the end of its buffer.

Would an IS_ALIGNED(size, FDMA_PCI_ATU_REGION_ALIGN) check next to the
target_addr check make the function match its documented contract?

> +
> +	mutex_lock(&atu->lock);

[ ... ]

> +	region->target_addr = target_addr;
> +	region->limit_addr = region->base_addr + size - 1;
> +	region->in_use = true;
> +
> +	fdma_pci_atu_configure_translation(region);
> +	fdma_pci_atu_region_enable(region);

[Severity: Low]
Should the enable bit be read back before fdma_pci_atu_region_map()
returns success?

fdma_pci_atu_region_enable() is a single posted writel() of BIT(31) to
REGION_CTRL2, and nothing checks whether it took effect.
dw_pcie_prog_outbound_atu() programs the same register layout. It polls
for PCIE_ATU_ENABLE and returns -ETIMEDOUT if the bit never appears:

	/*
	 * Make sure ATU enable takes effect before any subsequent config
	 * and I/O accesses.
	 */

Unmap is similar. fdma_pci_atu_region_unmap() posts the disable with no
flushing read, and fdma_free_coherent_and_unmap() then frees the buffer
right away through fdma_free_coherent().

In the lan966x user, fdma_pci_atu_region_map() is followed by
non-posted reads through the same BAR before FDMA_CH_ACTIVATE, and the
channels are polled until inactive before every unmap. That probably
hides this in practice.

Would a readback after the enable and the disable writes make the
ordering explicit?

> +
> +	mutex_unlock(&atu->lock);
> +
> +	return region;
> +}

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260928-lan966x-pci-fdma-v9-0-a17caf60f89a%40microchip.com
