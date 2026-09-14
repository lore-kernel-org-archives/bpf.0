Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2026B4749CB;
	Mon, 14 Sep 2026 13:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789394238; cv=none; b=I+aVlC6N4NVJbtlWbAoaExzIv1CTymL8NTpGn1ztpicYm9OJMg0ftOv8jevB2NuNZgweq+fKaMhCHPKh7IUerQFILd7tMBajSeDDebKWH9Y8rOqZK4ZkJzEsPU7I20cWj+Vb7hj2vszDDP9tjwRHrcpBAzrCXIVF4F7fj0gl09E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789394238; c=relaxed/simple;
	bh=PSFZPbHmEp1JTVcXB+enU0TPAw31ETrksc4lM4YVn70=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H4OSpNz8vB3u+c2YVL8FPJ7R0uaYzSnqy0QBqHAwaFKY+c/9qrg29qHX3v9QThuMjHIUZCY3N4X2O29ex4q0oafQoF6HJxlI1p++ON420y5ER2HUJjixPtoIw89DfQN701EfkrHvx6WxX5bUaQ6edH2rL+R7piTPQAs1lz/dcVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=RUFFm6TO; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="RUFFm6TO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1789394236; x=1820930236;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=PSFZPbHmEp1JTVcXB+enU0TPAw31ETrksc4lM4YVn70=;
  b=RUFFm6TOn1j5KMxg94qtbFffEsnIP3qnIiaaqSYp0xMggb65kMG3Z+cy
   NSz89yhEIsLCsOvUUxY1HdwuXvBJS5hQE6SewOvXBxNBhyQnn/HfjMgnu
   6OoyWpj4iEoHlL3EeLPaZ53kuGdcb6A0j6U3aXhULt9S/WgjEvyY3HmqY
   HxmQIzOIGNV+FM8mFYlQLgW/KeSPKDTpZ/fBAEXd9CCuI7d7mo8zH+Izi
   9ov90enS/OM09uoXF0yrim5expBmUUcP6o72Z+NKcva/91MDkhoec4mlQ
   BM0aWEVHX/eG/ADWMlTf9iBfP/cOz7hhukAJFHRy56pQF6pEFAc6yxHje
   g==;
X-CSE-ConnectionGUID: F4jQQy5jT+KnjqObTby7AQ==
X-CSE-MsgGUID: Q+CcJsvATBOz3WLg2gOmCg==
X-IronPort-AV: E=Sophos;i="6.27,102,1787036400"; 
   d="scan'208";a="63567291"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Sep 2026 06:57:14 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Mon, 14 Sep 2026 06:57:14 -0700
Received: from DEN-DL-M70577 (10.10.85.11) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Mon, 14 Sep 2026 06:57:10 -0700
Date: Mon, 14 Sep 2026 15:57:09 +0200
From: Daniel Machon <daniel.machon@microchip.com>
To: <netdev-bot+sashiko@kernel.org>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <horatiu.vultur@microchip.com>,
	<steen.hegelund@microchip.com>, <UNGLinuxDriver@microchip.com>,
	<ast@kernel.org>, <daniel@iogearbox.net>, <hawk@kernel.org>,
	<john.fastabend@gmail.com>, <sdf@fomichev.me>, <herve.codina@bootlin.com>,
	<arnd@arndb.de>, <gregkh@linuxfoundation.org>, <mohsin.bashr@gmail.com>,
	<richardcochran@gmail.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH net-next v6 03/14] net: microchip: fdma: add PCIe ATU
 support
Message-ID: <20260914135709.tgwmxocq2a6masm3@DEN-DL-M70577>
References: <20260909-lan966x-pci-fdma-v6-3-6f48dab9d671@microchip.com>
 <178904554204.219967.17805291259175904857@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <178904554204.219967.17805291259175904857@kernel.org>

> Thank you for your contribution! Sashiko AI review found 6 potential
> issue(s) to consider:
> 
> Critical: 0 · High: 0 · Medium: 3 · Low: 3
> 
> - [Medium] fdma_pci_atu_region_map() (EXPORT_SYMBOL_GPL) is the primitive
>   that programs the ATU limit register (region->limit_addr =…
> - [Medium] fdma_pci_atu_region_enable() writes the region enable bit
>   (BIT(31) at offset 0x4) and returns immediately, and…
> - [Medium] fdma_pci_atu_configure_translation() programs lower/upper base
>   (0x8/0xc), limit (0x10), lower/upper target (0x14/0x18) and the enable…
> - [Low] The commit message says the patch "effectively add[s] support for
>   PCIe FDMA", but at this commit nothing in the tree calls…
> - [Low] fdma_pci_atu_init() is the designated initializer of struct
>   fdma_pci_atu (it even programs hardware, disabling all six outbound…
> - [Low] fdma_pci_atu_translate_addr() reads region->base_addr and
>   region->target_addr with no lock, no READ_ONCE() and no in_use…
> 
> --
> 
> net: microchip: fdma: add PCIe ATU support
> 
> This adds a new fdma_pci.c/fdma_pci.h library that carves the PCIe endpoint
> outbound address space (0x10000000-0x1fffffff) into six equally sized ATU
> regions, and adds fdma_alloc_coherent_and_map()/fdma_free_coherent_and_unmap()
> helpers that pair a coherent DMA allocation with an ATU region mapping.
> 
> A few questions below.
> 
> >     Add the required functions and helpers that combine the DMA allocation
> >     with the ATU region mapping, effectively adding support for PCIe FDMA.
> 
> [Severity: Low]
> Is "effectively adding support for PCIe FDMA" the right wording for this
> patch on its own?
> 
> At this commit nothing in the tree calls fdma_pci_atu_init(),
> fdma_pci_atu_region_map(), fdma_pci_atu_translate_addr(),
> fdma_alloc_coherent_and_map() or fdma_free_coherent_and_unmap(), and
> FDMA_PCI_DB_ALIGN/FDMA_PCI_DB_SIZE() have no user either.
> 
> The wiring appears later in the series, in "net: lan966x: add PCIe FDMA
> support" and its follow-ups (lan966x_fdma_pci.c calls fdma_pci_atu_init(),
> fdma_alloc_coherent_and_map(), fdma_free_coherent_and_unmap(),
> fdma_pci_atu_translate_addr() and FDMA_PCI_DB_SIZE()).
> 
> Would "add the infrastructure for PCIe FDMA" describe this patch more
> accurately?

Wording. The subject is "add PCIe ATU support" and patch 10/14 is "net: lan966x:
add PCIe FDMA support"; side by side, I think its clear. Can reword if a respin
is required.

> 
> > diff --git a/drivers/net/ethernet/microchip/fdma/fdma_api.c b/drivers/net/ethernet/microchip/fdma/fdma_api.c
> > index e78c3590da9e..a3c9e3097c5c 100644
> > --- a/drivers/net/ethernet/microchip/fdma/fdma_api.c
> > +++ b/drivers/net/ethernet/microchip/fdma/fdma_api.c
> > @@ -127,6 +127,50 @@ void fdma_free_phys(struct fdma *fdma)
> >  }
> >  EXPORT_SYMBOL_GPL(fdma_free_phys);
> >
> > +#if IS_ENABLED(CONFIG_MCHP_LAN966X_PCI)
> > +/* Allocate coherent DMA memory and map it in the ATU. */
> > +int fdma_alloc_coherent_and_map(struct device *dev, struct fdma *fdma,
> > +                             struct fdma_pci_atu *atu)
> > +{
> > +     struct fdma_pci_atu_region *region;
> > +     int err;
> > +
> > +     if (WARN_ON(fdma->atu_region))
> > +             return -EBUSY;
> > +
> > +     /* The ATU cannot express a limit finer than the region granularity, so
> > +      * the hardware widens the programmed limit to that boundary. Pad the
> > +      * allocation to match, or the outbound window would extend past the
> > +      * memory we own.
> > +      */
> > +     fdma->size = ALIGN(fdma->size, FDMA_PCI_ATU_REGION_ALIGN);
> > +
> > +     err = fdma_alloc_coherent(dev, fdma);
> > +     if (err)
> > +             return err;
> > +
> > +     region = fdma_pci_atu_region_map(atu, fdma->dma, fdma->size);
> > +     if (IS_ERR(region)) {
> > +             fdma_free_coherent(dev, fdma);
> > +             return PTR_ERR(region);
> > +     }
> 
> [ ... ]
> 
> > diff --git a/drivers/net/ethernet/microchip/fdma/fdma_pci.c b/drivers/net/ethernet/microchip/fdma/fdma_pci.c
> > new file mode 100644
> > index 000000000000..bbfd3c67e03b
> > --- /dev/null
> > +++ b/drivers/net/ethernet/microchip/fdma/fdma_pci.c
> > @@ -0,0 +1,203 @@
> 
> [ ... ]
> 
> > +#define FDMA_PCI_ATU_ADDR            0x300000
> > +#define FDMA_PCI_ATU_IDX_SIZE        0x200
> > +#define FDMA_PCI_ATU_ENA_REG         0x4
> > +#define FDMA_PCI_ATU_ENA_BIT         BIT(31)
> > +#define FDMA_PCI_ATU_LWR_BASE_ADDR   0x8
> > +#define FDMA_PCI_ATU_UPP_BASE_ADDR   0xc
> > +#define FDMA_PCI_ATU_LIMIT_ADDR      0x10
> > +#define FDMA_PCI_ATU_LWR_TARGET_ADDR 0x14
> > +#define FDMA_PCI_ATU_UPP_TARGET_ADDR 0x18
> 
> [ ... ]
> 
> > +static void fdma_pci_atu_region_enable(struct fdma_pci_atu_region *region)
> > +{
> > +     writel(FDMA_PCI_ATU_ENA_BIT,
> > +            fdma_pci_atu_addr_get(region->atu->addr, FDMA_PCI_ATU_ENA_REG,
> > +                                  region->idx));
> > +}
> 
> [Severity: Medium]
> Does the enable bit take effect by the time this writel() retires?
> 
> The register block looks like the DesignWare unrolled iATU: the 0x300000
> base matches DEFAULT_DBI_ATU_OFFSET, the 0x200 stride matches
> PCIE_ATU_UNROLL_BASE(dir, index) = index << 9, and 0x0/0x4/0x8/0xc/0x10/
> 0x14/0x18 match PCIE_ATU_UNR_REGION_CTRL1/CTRL2/LOWER_BASE/UPPER_BASE/
> LOWER_LIMIT/LOWER_TARGET/UPPER_TARGET with PCIE_ATU_ENABLE = BIT(31) in
> CTRL2.
> 
> For that IP, dw_pcie_prog_outbound_atu() in
> drivers/pci/controller/dwc/pcie-designware.c polls until the enable bit
> reads back:
> 
>         for (retries = 0; retries < LINK_WAIT_MAX_IATU_RETRIES; retries++) {
>                 val = dw_pcie_readl_atu(pci, dir, index, PCIE_ATU_REGION_CTRL2);
>                 if (val & PCIE_ATU_ENABLE)
>                         return 0;
> 
>                 mdelay(LINK_WAIT_IATU);
>         }
> 
>         dev_err(pci->dev, "Outbound iATU is not being enabled\n");
> 
>         return -ETIMEDOUT;
> 
> with the comment "Make sure ATU enable takes effect before any subsequent
> config and I/O accesses".
> 
> Here fdma_pci_atu_region_map() returns the region as usable right after
> this write, and the caller programs FDMA descriptors with
> region->base_addr. Should the enable be read back (and a failure to arm
> reported to the caller) instead of being fire-and-forget?
> 

dw_pcie_prog_outbound_atu() polls because it programs the *local* iATU and then
immediately transacts through the window it armed. We program the *endpoint's*
iATU and never transact through it: the only consumer is the FDMA engine, which
cannot start before FDMA_CH_ACTIVATE, with four readl()s of the same BAR in
between.

> > +/* Configure the address translation in the ATU. */
> > +static void
> > +fdma_pci_atu_configure_translation(struct fdma_pci_atu_region *region)
> > +{
> > +     struct fdma_pci_atu *atu = region->atu;
> > +     int idx = region->idx;
> > +
> > +     writel(lower_32_bits(region->base_addr),
> > +            fdma_pci_atu_addr_get(atu->addr,
> > +                                  FDMA_PCI_ATU_LWR_BASE_ADDR, idx));
> > +
> > +     writel(upper_32_bits(region->base_addr),
> > +            fdma_pci_atu_addr_get(atu->addr,
> > +                                  FDMA_PCI_ATU_UPP_BASE_ADDR, idx));
> > +
> > +     /* Upper limit register only needed with REGION_SIZE > 4GB. */
> > +     writel(region->limit_addr,
> > +            fdma_pci_atu_addr_get(atu->addr, FDMA_PCI_ATU_LIMIT_ADDR, idx));
> 
> [Severity: Medium]
> Should region control 1 (offset 0x0) be programmed here too?
> 
> Everything except CTRL1 is written: base, limit, target and the enable bit
> in CTRL2. On the DWC unrolled iATU, CTRL1 holds the outbound TLP TYPE (MEM
> = 0), TD, PCIE_ATU_FUNC_NUM(pf) and PCIE_ATU_INCREASE_REGION_SIZE
> (BIT(13)). dw_pcie_prog_outbound_atu() always writes CTRL1 before enabling
> CTRL2:
> 
>         val = type | PCIE_ATU_FUNC_NUM(func_no);
>         ...
>         dw_pcie_writel_atu(pci, dir, index, PCIE_ATU_REGION_CTRL1, val);
>         dw_pcie_writel_atu(pci, dir, index, PCIE_ATU_REGION_CTRL2,
>                            PCIE_ATU_ENABLE);
> 
> There is no define for offset 0x0 in this file, and fdma_pci_atu_init()
> only clears the enable bit, so each window is armed with whatever CTRL1
> value reset, the endpoint bootloader, or a previous OS instance left in
> place. With a residual TYPE the FDMA writes go out as the wrong TLP type,
> with a stale FUNC_NUM they carry the wrong requester, and with a stale
> INCREASE_REGION_SIZE the window end is taken from a register this code
> never writes.

The datasheet does not describe programming region CTRL1 as part of setting up an
outbound window, and no side effect from leaving it alone has ever been
observed.

> 
> Related, is the comment "Upper limit register only needed with REGION_SIZE
> > 4GB" accurate here? That mode is selected by CTRL1 BIT(13), which is
> neither set nor cleared, and the upper limit register is never written.

The comment (tries) to clarify why the upper half is not written, which is when
the region size is > 4GB. I'd say its fine. And yes, in the case of >4GB,
BIT(13) needs to be set.

> 
> [ ... ]
> 
> > +/* Find an unused ATU region. */
> > +static struct fdma_pci_atu_region *
> > +fdma_pci_atu_region_get_free(struct fdma_pci_atu *atu)
> > +{
> > +     struct fdma_pci_atu_region *regions = atu->regions;
> > +
> > +     for (int i = 0; i < FDMA_PCI_ATU_REGION_MAX; i++) {
> > +             if (regions[i].in_use)
> > +                     continue;
> > +
> > +             return &regions[i];
> > +     }
> > +
> > +     return ERR_PTR(-ENOSPC);
> > +}
> 
> [ ... ]
> 
> > +/* Map a host DMA address into a free outbound region. */
> > +struct fdma_pci_atu_region *
> > +fdma_pci_atu_region_map(struct fdma_pci_atu *atu, u64 target_addr, int size)
> > +{
> > +     struct fdma_pci_atu_region *region;
> > +
> > +     if (!atu)
> > +             return ERR_PTR(-EINVAL);
> > +
> > +     if (size <= 0)
> > +             return ERR_PTR(-EINVAL);
> > +
> > +     if (size > fdma_pci_atu_region_size())
> > +             return ERR_PTR(-ERANGE);
> > +
> > +     /* The ATU region base is only ever aligned to FDMA_PCI_ATU_REGION_ALIGN;
> > +      * require the same alignment of the host target address, since the ATU
> > +      * translates addr - target_addr + base_addr and any misalignment here
> > +      * would shift every translated address by the same amount.
> > +      */
> > +     if (!IS_ALIGNED(target_addr, FDMA_PCI_ATU_REGION_ALIGN))
> > +             return ERR_PTR(-EINVAL);
> 
> [Severity: Medium]
> Should this validation block also reject a size that is not a multiple of
> FDMA_PCI_ATU_REGION_ALIGN?

Hardening: it cannot be reached: the only in-tree caller is
fdma_alloc_coherent_and_map(), which does fdma->size = ALIGN(fdma->size,
FDMA_PCI_ATU_REGION_ALIGN.

> 
> fdma_pci.h states the rule for both halves:
> 
>         /* Outbound regions are 64KB granular (datasheet section 3.24.7.4.1), so both
>          * the region base and the mapped size must be aligned to this.
>          */
>         #define FDMA_PCI_ATU_REGION_ALIGN BIT(16)
> 
> and the commit message names the consequence of not honouring it: "the
> outbound window would extend past the memory the host allocated for DMA".
> 
> The size given here becomes the programmed limit:
> 
>         region->limit_addr = region->base_addr + size - 1;
> 
> so with, say, a PAGE_SIZE-aligned 0x21000 from fdma_get_size() the hardware
> widens the limit to the next 64KB boundary and the enabled outbound window
> covers up to 64KB-1 of host memory beyond the buffer, which the FDMA engine
> can then write into.
> 
> The 64KB padding is only done in the convenience wrapper
> fdma_alloc_coherent_and_map(), not in this exported primitive that
> programs the register, and the commit message advertises the primitive for
> reuse by lan969x. Would an IS_ALIGNED(size, FDMA_PCI_ATU_REGION_ALIGN)
> check (or rounding here) be better placed alongside the target_addr check?
> 
> Also, the header comment for fdma_pci_atu_region_map() is just "Map a host
> DMA address into a free ATU region", with no mention that a target_addr
> that is not 64KB aligned is rejected with -EINVAL. Could that requirement
> be documented at the prototype?

Yes, I will document that if a respin is required.

> 
> > +
> > +     mutex_lock(&atu->lock);
> > +
> > +     region = fdma_pci_atu_region_get_free(atu);
> > +     if (IS_ERR(region)) {
> > +             mutex_unlock(&atu->lock);
> > +             return region;
> > +     }
> > +
> > +     region->target_addr = target_addr;
> > +     region->limit_addr = region->base_addr + size - 1;
> > +     region->in_use = true;
> > +
> > +     fdma_pci_atu_configure_translation(region);
> > +     fdma_pci_atu_region_enable(region);
> > +
> > +     mutex_unlock(&atu->lock);
> > +
> > +     return region;
> > +}
> > +EXPORT_SYMBOL_GPL(fdma_pci_atu_region_map);
> > +
> > +/* Translate a host DMA address to the corresponding OB address. */
> > +u64 fdma_pci_atu_translate_addr(struct fdma_pci_atu_region *region, u64 addr)
> > +{
> > +     return region->base_addr + (addr - region->target_addr);
> > +}
> > +EXPORT_SYMBOL_GPL(fdma_pci_atu_translate_addr);
> 
> [Severity: Low]
> What serializes these reads against the writers?
> 
> fdma_pci_atu_region_map() and fdma_pci_atu_region_unmap() mutate
> target_addr/in_use and the hardware window under the sleeping atu->lock,
> while this helper reads base_addr/target_addr with no lock, no READ_ONCE()
> and no in_use check. Its intended callers are descriptor callbacks
> (lan966x_fdma_pci_dataptr_cb()/nextptr_cb(), reached from NAPI poll and
> from lan966x_fdma_pci_xmit()), which cannot take a mutex.
> 
> Looking at the end of the series, the writers are
> lan966x_fdma_pci_reload() and lan966x_fdma_pci_deinit(), both of which
> first do napi_disable() and lan966x_fdma_tx_disable_netdev() (netif_tx_disable()
> drains in-flight ndo_start_xmit callers), and both are under rtnl, so there
> does not seem to be a reachable race today.
> 
> Given that, would it help to document at the prototype that the caller must
> quiesce DMA and the descriptor paths before unmapping a region, since this
> is an exported helper?
> 

Yes, I will document that if a respin is required.

> > +
> > +/* Initialize ATU, dividing the OB space into equally sized regions. */
> > +void fdma_pci_atu_init(struct fdma_pci_atu *atu, void __iomem *addr)
> > +{
> > +     struct fdma_pci_atu_region *regions = atu->regions;
> > +     u32 region_size = fdma_pci_atu_region_size();
> > +
> > +     atu->addr = addr;
> > +     mutex_init(&atu->lock);
> > +
> > +     for (int i = 0; i < FDMA_PCI_ATU_REGION_MAX; i++) {
> > +             regions[i].base_addr =
> > +                     FDMA_PCI_ATU_OB_START + (i * region_size);
> > +             regions[i].idx = i;
> > +             regions[i].atu = atu;
> > +
> > +             fdma_pci_atu_region_disable(&regions[i]);
> > +     }
> > +}
> > +EXPORT_SYMBOL_GPL(fdma_pci_atu_init);
> 
> [Severity: Low]
> Should this also initialize in_use, target_addr and limit_addr?
> 
> This is the designated initializer for struct fdma_pci_atu and it even
> touches hardware (disabling all six windows), but it only sets base_addr,
> idx and atu. The allocation state that fdma_pci_atu_region_get_free()
> consumes is in_use, which is never assigned here, so the helper silently
> depends on the embedding structure having been zeroed. If in_use held
> garbage, every region would look busy and mapping would fail with -ENOSPC.
> 
> The only in-tree caller later in the series passes &lan966x->atu, and
> lan966x comes from devm_kzalloc() in lan966x_probe(), so it works today.
> Would it be worth clearing the per-region software state here (or noting
> the "caller must zero the struct" precondition at the prototype)?

I think this is a false positive: The struct is zeroed by design rather
than by luck: struct fdma_pci_atu is embedded in struct lan966x, which is
devm_kzalloc()'d, so in_use is already false when fdma_pci_atu_init() runs. It
is also the only one of the three that is read before it is written - it has a
single reader, fdma_pci_atu_region_get_free().  target_addr and limit_addr are
assigned by fdma_pci_atu_region_map() under the lock, and a region pointer only
ever reaches a caller as that function's return value, so neither can be read
first.

> 
> There is also no counterpart to this function: nothing resets the software
> state, unmaps still-mapped regions, or calls mutex_destroy(). Is a
> fdma_pci_atu_deinit() wanted for symmetry?
> 

Maybe. This version deliberately leaves the ATU reigions alone, and rely on the
fdma_pci_atu_init, to reinitialize the regions on probe. No issues have been
observed so far.

> > diff --git a/drivers/net/ethernet/microchip/fdma/fdma_pci.h b/drivers/net/ethernet/microchip/fdma/fdma_pci.h
> > new file mode 100644
> > index 000000000000..60aa2d2a9af3
> > --- /dev/null
> > +++ b/drivers/net/ethernet/microchip/fdma/fdma_pci.h
> > @@ -0,0 +1,52 @@
> 
> [ ... ]
> 
> > +/* Outbound regions are 64KB granular (datasheet section 3.24.7.4.1), so both
> > + * the region base and the mapped size must be aligned to this.
> > + */
> > +#define FDMA_PCI_ATU_REGION_ALIGN BIT(16)
> 
> [ ... ]
> 
> > +/* Initialize ATU, dividing OB space into regions. */
> > +void fdma_pci_atu_init(struct fdma_pci_atu *atu, void __iomem *addr);
> > +
> > +/* Unmap an ATU region, clearing its translation and disabling it. */
> > +void fdma_pci_atu_region_unmap(struct fdma_pci_atu_region *region);
> > +
> > +/* Map a host DMA address into a free ATU region. */
> > +struct fdma_pci_atu_region *fdma_pci_atu_region_map(struct fdma_pci_atu *atu,
> > +                                                 u64 target_addr,
> > +                                                 int size);
> 
> [ ... ]
> 
> --
> Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260909-lan966x-pci-fdma-v6-0-6f48dab9d671%40microchip.com
