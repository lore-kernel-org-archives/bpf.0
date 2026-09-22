Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40047442FAA;
	Tue, 22 Sep 2026 13:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790082047; cv=none; b=bmxXs4j/sZ6kHrkachE0fYl1dHJZbF78IuQS6haX7cn2ze6NuoLgiUtb9WEzzns4msjMNbnhqoyN4syH0mooQgoTJ2r1HALbIBUNNHAZBG6my/i0YR+6BOkVYQR0Ow9M3c+mc7+gZZyEsuLEhFHW7PKfCztX9oLhnv7ngc9qSZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790082047; c=relaxed/simple;
	bh=NABM3e2WhM5YCtERsiysLz8SOWCNnO9w43TP+pT850Y=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IVpwTzYoW++7sWZG/XCQq+KbBOS6Cj9oDslHkTwUirCZ9CiAlAEpMLaLrUV+WQ24OVJ/3DGRj19rg/PWc/onumbOhrSk0OBPqNuSpQebidslSfp+ybSbQddDQwoxP/kV35eauV2SdY3LX8zYYmoYw9iDd1+MZJ3jPA7+BFpxA3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gvo2zOzv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gvo2zOzv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA9A61F000FF;
	Tue, 22 Sep 2026 13:00:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790082045;
	bh=LEEG9mS5wOzPf9gOdNrWMyZGlMvYoecIavgIHmxVD9g=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Gvo2zOzvTdJikdVr/ZehIEdoP+JvxSzy0KLkTibzz85mVe4C5vIvNTF2qdWAoZDg4
	 hdFFT0Vkr8PEmoYQCuBmtp2j0ZULDYGp4aPyGTU7GFc5hd1AhjuP+DlaNjA/hsTeKK
	 qCW3pBBAV7n9IydAWBOSjNHj3aUSba3GefwYzbrL4d36OcX0jr5RWDpQzy808S5Y+F
	 YUZHqjR5XppDJs/P+kNjyWMbgNpfonMbnH48DpSZAKvHSkADjoYJp86W6EuPZhyU/p
	 j82Oj2ksqL8q1leeJUMJZtRC8LwHSfLSbVAAkt5/S60sPYzosWTIHMMvaPZu9PPDN+
	 6OnUHlWV63FNw==
Subject:
 Re: [PATCH net-next v7 03/14] net: microchip: fdma: add PCIe ATU support
From: netdev-bot+sashiko@kernel.org
To: daniel.machon@microchip.com
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horatiu.vultur@microchip.com,
 steen.hegelund@microchip.com, UNGLinuxDriver@microchip.com, ast@kernel.org,
 daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
 sdf@fomichev.me, herve.codina@bootlin.com, arnd@arndb.de,
 gregkh@linuxfoundation.org, mohsin.bashr@gmail.com, richardcochran@gmail.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Date: Tue, 22 Sep 2026 13:00:44 +0000
Message-ID: <179008204420.2160803.14375469578712775106@kernel.org>
In-Reply-To: <20260918-lan966x-pci-fdma-v7-3-0ecc179c8a2c@microchip.com>
References: <20260918-lan966x-pci-fdma-v7-3-0ecc179c8a2c@microchip.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 4 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 3

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] fdma_pci_atu_region_map() programs base/limit/target and then
  issues the region-enable write (CTRL2 bit31) and returns immediately;…
- [Low] fdma_pci_atu_region_map()
  (drivers/net/ethernet/microchip/fdma/fdma_pci.c:138) validates that…
- [Low] fdma_pci_atu_configure_translation() programs lower/upper base
  (+0x8/+0xc), limit (+0x10) and lower/upper target (+0x14/+0x18), and…
- [Low] fdma_pci_atu_translate_addr() (fdma_pci.c:181) computes
  region->base_addr + (addr - region->target_addr) with no check that…

--

net: microchip: fdma: add PCIe ATU support

Adds a PCIe ATU layer for the Microchip FDMA engine so that a lan966x or
lan969x acting as a PCIe endpoint can reach host memory. The outbound
address space 0x10000000-0x1fffffff is split into six regions that are
claimed and programmed when FDMA buffers are allocated.

A few questions on the new ATU code below.

> diff --git a/drivers/net/ethernet/microchip/fdma/fdma_api.c b/drivers/net/ethernet/microchip/fdma/fdma_api.c
> index e78c3590da9e..a3c9e3097c5c 100644
> --- a/drivers/net/ethernet/microchip/fdma/fdma_api.c
> +++ b/drivers/net/ethernet/microchip/fdma/fdma_api.c
> @@ -127,6 +127,50 @@ void fdma_free_phys(struct fdma *fdma)
>  }
>  EXPORT_SYMBOL_GPL(fdma_free_phys);
>  
> +#if IS_ENABLED(CONFIG_MCHP_LAN966X_PCI)
> +/* Allocate coherent DMA memory and map it in the ATU. */
> +int fdma_alloc_coherent_and_map(struct device *dev, struct fdma *fdma,
> +				struct fdma_pci_atu *atu)
> +{
> +	struct fdma_pci_atu_region *region;
> +	int err;
> +
> +	if (WARN_ON(fdma->atu_region))
> +		return -EBUSY;
> +
> +	/* The ATU cannot express a limit finer than the region granularity, so
> +	 * the hardware widens the programmed limit to that boundary. Pad the
> +	 * allocation to match, or the outbound window would extend past the
> +	 * memory we own.
> +	 */
> +	fdma->size = ALIGN(fdma->size, FDMA_PCI_ATU_REGION_ALIGN);
> +
> +	err = fdma_alloc_coherent(dev, fdma);
> +	if (err)
> +		return err;
> +
> +	region = fdma_pci_atu_region_map(atu, fdma->dma, fdma->size);
> +	if (IS_ERR(region)) {
> +		fdma_free_coherent(dev, fdma);
> +		return PTR_ERR(region);
> +	}
> +
> +	fdma->atu_region = region;
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(fdma_alloc_coherent_and_map);
> +
> +/* Free coherent DMA memory and unmap the memory in the ATU. */
> +void fdma_free_coherent_and_unmap(struct device *dev, struct fdma *fdma)
> +{
> +	fdma_pci_atu_region_unmap(fdma->atu_region);
> +	fdma->atu_region = NULL;
> +	fdma_free_coherent(dev, fdma);
> +}
> +EXPORT_SYMBOL_GPL(fdma_free_coherent_and_unmap);
> +#endif

[ ... ]

> diff --git a/drivers/net/ethernet/microchip/fdma/fdma_pci.c b/drivers/net/ethernet/microchip/fdma/fdma_pci.c
> new file mode 100644
> index 000000000000..dd1dc46cbc9d
> --- /dev/null
> +++ b/drivers/net/ethernet/microchip/fdma/fdma_pci.c
> @@ -0,0 +1,208 @@

[ ... ]

> +#define FDMA_PCI_ATU_ADDR            0x300000
> +#define FDMA_PCI_ATU_IDX_SIZE        0x200
> +#define FDMA_PCI_ATU_ENA_REG         0x4
> +#define FDMA_PCI_ATU_ENA_BIT         BIT(31)
> +#define FDMA_PCI_ATU_LWR_BASE_ADDR   0x8
> +#define FDMA_PCI_ATU_UPP_BASE_ADDR   0xc
> +#define FDMA_PCI_ATU_LIMIT_ADDR      0x10
> +#define FDMA_PCI_ATU_LWR_TARGET_ADDR 0x14
> +#define FDMA_PCI_ATU_UPP_TARGET_ADDR 0x18

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
> +
> +	writel(lower_32_bits(region->target_addr),
> +	       fdma_pci_atu_addr_get(atu->addr,
> +				     FDMA_PCI_ATU_LWR_TARGET_ADDR, idx));
> +
> +	writel(upper_32_bits(region->target_addr),
> +	       fdma_pci_atu_addr_get(atu->addr,
> +				     FDMA_PCI_ATU_UPP_TARGET_ADDR, idx));
> +}

[Severity: Low]
The offsets used here match the DesignWare unrolled iATU layout: block at
DBI + 0x300000, 0x200 stride per region, Control 2 at +0x4 with enable in
bit 31, base at +0x8/+0xc, limit at +0x10, target at +0x14/+0x18.

That layout also has a Control 1 register at +0x0 selecting the outbound
TLP type, the function number and the ECRC/TD bits, and it is never
written here. fdma_pci_atu_init() claims all six outbound regions and
only clears Control 2, so each region keeps whatever Control 1 value it
already held.

The generic driver for the same block always programs it explicitly
before enabling:

drivers/pci/controller/dwc/pcie-designware.c:dw_pcie_prog_outbound_atu() {
	...
	val = atu->type | atu->routing | PCIE_ATU_FUNC_NUM(atu->func_no);
	...
	dw_pcie_writel_atu_ob(pci, atu->index, PCIE_ATU_REGION_CTRL1, val);
	...
}

Is it safe to inherit Control 1 from whatever configured the outbound
windows before the driver probes, or should it be programmed for the
memory TLP type explicitly?

> +/* Map a host DMA address into a free outbound region. */
> +struct fdma_pci_atu_region *
> +fdma_pci_atu_region_map(struct fdma_pci_atu *atu, u64 target_addr, int size)
> +{
> +	struct fdma_pci_atu_region *region;
> +
> +	if (!atu)
> +		return ERR_PTR(-EINVAL);
> +
> +	if (size <= 0)
> +		return ERR_PTR(-EINVAL);
> +
> +	if (size > fdma_pci_atu_region_size())
> +		return ERR_PTR(-ERANGE);
> +
> +	/* The ATU region base is only ever aligned to FDMA_PCI_ATU_REGION_ALIGN;
> +	 * require the same alignment of the host target address, since the ATU
> +	 * translates addr - target_addr + base_addr and any misalignment here
> +	 * would shift every translated address by the same amount.
> +	 */
> +	if (!IS_ALIGNED(target_addr, FDMA_PCI_ATU_REGION_ALIGN))
> +		return ERR_PTR(-EINVAL);

[Severity: Low]
Should size also be checked against FDMA_PCI_ATU_REGION_ALIGN here?

fdma_pci.h documents the requirement for both arguments:

/* Outbound regions are 64KB granular (datasheet section 3.24.7.4.1), so both
 * the region base and the mapped size must be aligned to this.
 */

/* Map a host DMA address into a free ATU region. target_addr and size must be
 * FDMA_PCI_ATU_REGION_ALIGN aligned; a misaligned target_addr returns -EINVAL.
 */

but only target_addr is verified, and the unaligned value then goes
straight into the hardware limit:

	region->limit_addr = region->base_addr + size - 1;

Per the commit message the hardware widens that limit to the 64KB
boundary, so an unaligned size would leave the outbound window covering
up to 64KB - 1 beyond the buffer.

The single in-tree caller, fdma_alloc_coherent_and_map(), pads with
fdma->size = ALIGN(fdma->size, FDMA_PCI_ATU_REGION_ALIGN) before
allocating, so nothing can hit this today, but the invariant lives in the
caller while fdma_pci_atu_region_map() is exported. Would it make sense
to enforce it in the primitive too?

> +	mutex_lock(&atu->lock);
> +
> +	region = fdma_pci_atu_region_get_free(atu);
> +	if (IS_ERR(region)) {
> +		mutex_unlock(&atu->lock);
> +		return region;
> +	}
> +
> +	region->target_addr = target_addr;
> +	region->limit_addr = region->base_addr + size - 1;
> +	region->in_use = true;
> +
> +	fdma_pci_atu_configure_translation(region);
> +	fdma_pci_atu_region_enable(region);
> +
> +	mutex_unlock(&atu->lock);
> +
> +	return region;
> +}
> +EXPORT_SYMBOL_GPL(fdma_pci_atu_region_map);

[Severity: Medium]
Does the enable write need to be read back before the region is treated
as mapped?

fdma_pci_atu_region_enable() issues a posted write of bit 31 to Control 2
and fdma_pci_atu_region_map() returns immediately, so the caller can arm
the FDMA channel (later in the series
lan966x_fdma_pci_rx_alloc() programs the LLP with region->base_addr and
lan966x_fdma_rx_start() starts the channel) before the outbound window is
known to be live. There is also no way for the API to report a window
that never enables.

The generic driver for this register layout polls instead:

drivers/pci/controller/dwc/pcie-designware.c:dw_pcie_prog_outbound_atu() {
	...
	/*
	 * Make sure ATU enable takes effect before any subsequent config
	 * and I/O accesses.
	 */
	for (retries = 0; retries < LINK_WAIT_MAX_IATU_RETRIES; retries++) {
		val = dw_pcie_readl_atu_ob(pci, atu->index, PCIE_ATU_REGION_CTRL2);
		if (val & PCIE_ATU_ENABLE)
			return 0;

		mdelay(LINK_WAIT_IATU);
	}
	...
	return -ETIMEDOUT;
}

The same applies in reverse on teardown: fdma_pci_atu_region_unmap()
issues the disable write and fdma_free_coherent_and_unmap() calls
fdma_free_coherent() right after, without confirming the window is down
before those pages go back to the allocator.

> +/* Translate a host DMA address to the corresponding OB address. */
> +u64 fdma_pci_atu_translate_addr(struct fdma_pci_atu_region *region, u64 addr)
> +{
> +	return region->base_addr + (addr - region->target_addr);
> +}
> +EXPORT_SYMBOL_GPL(fdma_pci_atu_translate_addr);

[Severity: Low]
Can this return an address belonging to a different region?

All six regions are contiguous slices of the same outbound space
(base_addr = 0x10000000 + i * region_size), and nothing here checks that
addr falls inside [target_addr, target_addr + mapped size) or that
region->in_use is still set. An address outside the mapping silently
lands in a neighbouring window and the FDMA would then read or write
another buffer's host target rather than failing.

fdma_pci_atu_region_unmap() also resets target_addr to 0 while leaving
base_addr alone:

	region->target_addr = 0;
	region->in_use = false;

so a translation on a released region returns base_addr + addr.

The in-tree users, lan966x_fdma_pci_dataptr_cb() and
lan966x_fdma_pci_nextptr_cb(), only pass offsets inside the mapped
buffer, and fdma_free_coherent_and_unmap() clears fdma->atu_region, so no
current path feeds a bad address. Since the region already stores
limit_addr, would a bounds and in_use assertion be worth adding?

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260918-lan966x-pci-fdma-v7-0-0ecc179c8a2c%40microchip.com
