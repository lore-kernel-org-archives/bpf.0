Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60B6E4BC007;
	Fri, 25 Sep 2026 20:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790369545; cv=none; b=XA0kYp9dUL3PKVEA/o+V/bZ/T6zXGIJ5u50+xdrhGUSyvhusOis8vy1SK8B8z1aN3c0x/e2Kv3agv+Pj9Fes0qPswV0hOKv5KX6Z6LyMWN8xwYd4taE+vlC+y+ILN/KaEAIQDHxcQSpqRyTXfhDDWwcL9VSaj4FYtUAkRGB7+RY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790369545; c=relaxed/simple;
	bh=3FjbcHS+/O49bK5Nk66ggY6QtqyfflAxfsYuyB/GsSs=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZV/qHEBap+6gp8kD0iABvwb8id2b2vLwGDTPdyRUPSzbl1/MA337CEu5r6P4uKMELQJ10IDv5KEFw8eh8mMuqouo+aAxSwOmaFrvmtEcHpqtH8gkG+3p6bUwimVkOQIaZ2gLrfBT/lgOnZNESyBDuM7BrItq7HNRM+fIGjqyw3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YUeuS2OI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YUeuS2OI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E6CA1F000FF;
	Fri, 25 Sep 2026 20:52:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790369544;
	bh=rfx4GRgvaRSdSRGh67ySOhLQR6YOyXcLJQEKF3xm+uQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=YUeuS2OIUvqqJgk4p/wOad84NalwtD7NDOQZ2xu/uyG5DW+pSalc/JeC/WvK7lSU7
	 Z3i+So38NNBb3x+J9J9g8upxv0sucDiNKCc287SKspU7pfLhxgd+2pFfd2fs4vLMLH
	 bAarbx+fQjnpmRV9v4SxLd55X1BZggBArsSCxxAdBqJzUGsREmFEKWIcoFy4M0w2yl
	 SFjzBn2l530wUQXbpso5Hm5Ztf0LrKFYHb3kvBSPsStRBfi6U/K7N3V2yv8okzDMbe
	 SQzzd0i5d4K7SbwxKEZJwChbwYivR0I838hONEQSnqe3R5hJMod85hnHk5EtMG6Q4G
	 +3XDB7voHoerg==
Subject:
 Re: [PATCH net-next v8 03/15] net: microchip: fdma: add PCIe ATU support
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
Date: Fri, 25 Sep 2026 20:52:22 +0000
Message-ID: <179036954263.2160803.8852252834530526539@kernel.org>
In-Reply-To: <20260924-lan966x-pci-fdma-v8-3-201c7b707d8b@microchip.com>
References: <20260924-lan966x-pci-fdma-v8-3-201c7b707d8b@microchip.com>
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

- [Low] fdma_pci_atu_region_map()
  (drivers/net/ethernet/microchip/fdma/fdma_pci.c) is exported.
- [Low] The ATU region claimed in fdma_alloc_coherent_and_map() is
  released only by fdma_free_coherent_and_unmap().
- [Low] If fdma_pci_atu_region_map() fails, fdma_alloc_coherent_and_map()
  calls fdma_free_coherent() (fdma_api.c:154) but leaves fdma->dcbs and…
- [Low] fdma_pci_atu_region_map() sets the iATU enable bit (CTRL2, offset
  0x4) with a bare writel() and never reads it back.
- [Low] fdma_pci_atu_configure_translation() and fdma_pci_atu_init()
  never write iATU REGION_CTRL1 (offset 0x0: TLP type, function number,…

--

net: microchip: fdma: add PCIe ATU support

This patch adds PCIe ATU support to the shared Microchip FDMA library. It
lets lan966x (and later lan969x) DMA to host memory when running as a PCIe
endpoint. The outbound address space is split into six regions. New
helpers combine coherent DMA allocation with claiming and programming an
ATU region, and the mapped allocation is padded to the 64KB ATU
granularity.

> diff --git a/drivers/net/ethernet/microchip/fdma/fdma_api.c b/drivers/net/ethernet/microchip/fdma/fdma_api.c
> index e78c3590da9e6..a3c9e3097c5c2 100644
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

[ ... ]

> +	err = fdma_alloc_coherent(dev, fdma);
> +	if (err)
> +		return err;
> +
> +	region = fdma_pci_atu_region_map(atu, fdma->dma, fdma->size);
> +	if (IS_ERR(region)) {
> +		fdma_free_coherent(dev, fdma);
> +		return PTR_ERR(region);
> +	}

[Severity: Low]
If fdma_pci_atu_region_map() fails here, the buffer is freed, but
fdma->dcbs and fdma->dma still point at it. A later
fdma_free_coherent_and_unmap() or fdma_free_coherent() on the same struct
fdma would then call dma_free_coherent() on this buffer a second time.
Could that happen?

No caller later in the series seems to do this:
lan966x_fdma_pci_rx_alloc()/tx_alloc() just return the error.
lan966x_fdma_pci_init() frees only the rx struct when the tx allocation
fails. lan966x_fdma_pci_reload() puts the old structs back with memcpy()
on failure.

Would clearing fdma->dcbs and fdma->dma after the rollback free still be
worth doing?

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

[Severity: Low]
This is the only path that releases the region claimed in
fdma_alloc_coherent_and_map(). The plain fdma_free_coherent() is still
exported and does not touch fdma->atu_region.

What happens if a by-value copy of struct fdma is freed with
fdma_free_coherent(), as the platform lan966x_fdma_reload() does? The
region would stay in_use, with an enabled outbound window pointing at
freed memory. The next map could also hit WARN_ON(fdma->atu_region).

Later in the series the PCIe path looks correct. lan966x_fdma_pci_reload()
sets rx.fdma.atu_region and tx.fdma.atu_region to NULL before
reallocating, then frees the old copies with
fdma_free_coherent_and_unmap(). The platform lan966x_fdma_reload() only
runs through lan966x_fdma_ops, which never maps ATU regions.

Would it help to document that fdma_free_coherent() must not be used on
a mapped struct fdma?

[ ... ]

> diff --git a/drivers/net/ethernet/microchip/fdma/fdma_pci.c b/drivers/net/ethernet/microchip/fdma/fdma_pci.c
> new file mode 100644
> index 0000000000000..dd1dc46cbc9dc
> --- /dev/null
> +++ b/drivers/net/ethernet/microchip/fdma/fdma_pci.c
> @@ -0,0 +1,208 @@

[ ... ]

> +/* Configure the address translation in the ATU. */
> +static void
> +fdma_pci_atu_configure_translation(struct fdma_pci_atu_region *region)
> +{

[ ... ]

> +	/* The OB address space lies entirely below 4GB, so the limit always
> +	 * fits the lower limit register and the upper one is left alone.
> +	 */
> +	writel(region->limit_addr,
> +	       fdma_pci_atu_addr_get(atu->addr, FDMA_PCI_ATU_LIMIT_ADDR, idx));

[Severity: Low]
This writes base, limit and target, but it never writes REGION_CTRL1
(offset 0x0: TLP type, function number, INCREASE_REGION_SIZE) or
UPPER_LIMIT (offset 0x20). fdma_pci_atu_init() doesn't write them either;
it only clears the enable bit.

Does this code depend on those registers still holding their reset values
(memory request type, function 0, no increased region size)? For
comparison, dw_pcie_prog_outbound_atu() always writes CTRL1 explicitly.

No other agent that programs these registers has been identified, and
this driver never writes them. Would setting CTRL1 and UPPER_LIMIT to 0
during setup be reasonable hardening?

[ ... ]

> +/* Map a host DMA address into a free outbound region. */
> +struct fdma_pci_atu_region *
> +fdma_pci_atu_region_map(struct fdma_pci_atu *atu, u64 target_addr, int size)
> +{

[ ... ]

> +	if (!IS_ALIGNED(target_addr, FDMA_PCI_ATU_REGION_ALIGN))
> +		return ERR_PTR(-EINVAL);

[ ... ]

> +	region->target_addr = target_addr;
> +	region->limit_addr = region->base_addr + size - 1;

[Severity: Low]
target_addr is checked for FDMA_PCI_ATU_REGION_ALIGN alignment, but size
is not, and size goes straight into limit_addr here.

The commit message says the hardware widens a limit that is not 64KB
aligned. fdma_pci_atu_region_map() is exported. If a caller passed a size
such as 0x1234, would the outbound window then extend to
target_addr + 0xffff, past the end of the caller's buffer?

This isn't reachable today. The fdma_pci.h comment says "target_addr and
size must be FDMA_PCI_ATU_REGION_ALIGN aligned". The only in-tree caller,
fdma_alloc_coherent_and_map(), pads fdma->size with ALIGN() first.

Could an IS_ALIGNED(size, FDMA_PCI_ATU_REGION_ALIGN) check that returns
-EINVAL go next to the target_addr check, so the documented precondition
is enforced?

> +	region->in_use = true;
> +
> +	fdma_pci_atu_configure_translation(region);
> +	fdma_pci_atu_region_enable(region);

[Severity: Low]
fdma_pci_atu_region_enable() sets the enable bit in CTRL2 (offset 0x4)
with a bare writel(), and success is returned without reading the bit
back. On the other side, fdma_pci_atu_region_unmap() clears the bit with
a posted write, and fdma_free_coherent_and_unmap() frees the buffer right
after.

dw_pcie_prog_outbound_atu() polls CTRL2 after enabling a region, with the
comment "Make sure ATU enable takes effect before any subsequent config
and I/O accesses". Does the lan966x iATU need a similar read-back?

In the series as posted, lan966x_fdma_rx_start() reads registers on the
same endpoint before it activates a channel, and those reads would flush
the enable write. Every unmap caller also first waits for the channels to
go idle via lan966x_fdma_rx_disable()/tx_disable(). So this only matters
if the hardware needs settle time beyond that flush.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260924-lan966x-pci-fdma-v8-0-201c7b707d8b%40microchip.com
