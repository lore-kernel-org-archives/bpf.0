Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6229A4F798B;
	Fri, 25 Sep 2026 20:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790369554; cv=none; b=QCttnpvpnl5+cQLSzuQnuMWeMvQ3iP9tKlUyX78Mj/7D6OMt0plRroXkXySODqFlaQerA0d8AyPNj0z1NN6S9BafgGBSYKPHNWi/qEG0dpnkdy0OGPz/FI9m/lIDrWVQfDpApanokzNggVpcEfgQqRHI2Y0P5IgBMFnUXxYrsMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790369554; c=relaxed/simple;
	bh=gAg1llPGBopDeQQs/ZjJ0/jdCMMcu7ZfCmwJyzJgOcA=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=N1cew4Y8WrsbdMsSFY6m3GHc7/XYHnMyTzsRFWOmHWmp0fLDdnW26m9KzcJTaEaz2PpHhV2sva0QD76Q/2PP/aCosOtE/iBLa3qtyNxvgZ+24LCzISqEPHHUUeYYgdFuDKUCh6Do9+af/0j8xJLnW8r6FkeGXyHwubhqNNJedhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EJJFLzyo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EJJFLzyo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9C811F00898;
	Fri, 25 Sep 2026 20:52:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790369552;
	bh=YSgAxlXgEc2s9LS1CtbV0rseO6xAilthM544NHvznvs=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=EJJFLzyoxSuVP7w7t85qn/vxadgtDJ/1XcJ6Zg4vsobe4tKr//MavrE9FrOVIk0d7
	 0W5YDOfoEJkO9BEL6R0T8nii3o9WmZKPPk9369VX+cB3/J0KIoQnLab+bjL3l8LCTm
	 mpDhivrdnbtjkX/vaCHp8/Bk7FfZe6ESy7W4POSsmk64XdTnqPSbAGj3F3jMS7Pepc
	 P/urGlQmDB+9L/dOobnlT/SIz2kJuB+2g/rH+J/A+ptdBiQaCa/LvQz0jvFL6dW2wg
	 c27StwZl9equGGspME2W1ujdAzBf9z8X+V6e5pTzQnXqaZY9meK6Ra2Tild5WvJ83r
	 1cGRY1mlqB3jQ==
Subject:
 Re: [PATCH net-next v8 12/15] net: lan966x: add PCIe FDMA MTU change support
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
Date: Fri, 25 Sep 2026 20:52:30 +0000
Message-ID: <179036955031.2160803.2502756827414954464@kernel.org>
In-Reply-To: <20260924-lan966x-pci-fdma-v8-12-201c7b707d8b@microchip.com>
References: <20260924-lan966x-pci-fdma-v8-12-201c7b707d8b@microchip.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider.

Critical: 0 · High: 2 (1) · Medium: 0 · Low: 1 (1)

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] lan966x_fdma_pci_resize() skips the resize only while
  `lan966x->rx.lan966x` is NULL.
- [High] lan966x_fdma_pci_resize() reads the plain field
  `lan966x->rx.lan966x` without any synchronization with…
- [Low] The comment says FDMA_PCI_DB_SIZE_MAX (lan966x_main.h:106) is the
  'Largest db_size keeping the ATU-padded ring inside one MAX_PAGE_ORDER…

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but the patch
  works around it only on the PCIe path.
- [Low] lan966x_fdma_pci_reload() frees the old RX/TX coherent rings and
  unmaps their ATU regions (lines 465-466) after calling…

--

net: lan966x: add PCIe FDMA MTU change support

This commit adds MTU change support to the lan966x PCIe FDMA path. On an
MTU change it reallocates the contiguous ATU-mapped RX and TX rings at the
new size, and falls back to the old rings if that fails. It also caps the
PCIe DCB ring at 256 entries, advertises FDMA_PCI_MAX_MTU in dev->max_mtu
when the FDMA is in use, and skips the resize until
lan966x_fdma_pci_init() has run.

> diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c b/drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c
> index 2e8f786d6feec..a7940eca5df31 100644
> --- a/drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c
> +++ b/drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c
> @@ -890,11 +890,7 @@ static int lan966x_fdma_reload(struct lan966x *lan966x, int new_mtu)
>  
>  int lan966x_fdma_get_max_frame(struct lan966x *lan966x)
>  {
> -	return lan966x_fdma_get_max_mtu(lan966x) +
> -	       IFH_LEN_BYTES +
> -	       SKB_DATA_ALIGN(sizeof(struct skb_shared_info)) +
> -	       VLAN_HLEN * 2 +
> -	       XDP_PACKET_HEADROOM;
> +	return lan966x_fdma_get_max_mtu(lan966x) + FDMA_OVERHEAD;
>  }

[Severity: High]
This isn't a bug introduced by this patch, but the commit message notes
that the FDMA init "runs after the netdevs register". The platform FDMA
has the same ordering. Does the platform path need the same guard?

lan966x_probe_port() calls register_netdev(). lan966x_fdma_init() runs
only later, from lan966x_probe() via lan966x->ops->fdma_init(). The
platform resize callback has no check for that window:

lan966x_fdma_change_mtu() {
	max_mtu = lan966x_fdma_get_max_frame(lan966x);
	if (max_mtu == lan966x->rx.max_mtu)
		return 0;

	return __lan966x_fdma_reload(lan966x, max_mtu);
}

Before init, rx.max_mtu is still 0, so an MTU change in that window goes
through:

__lan966x_fdma_reload()->lan966x_fdma_reload()->lan966x_fdma_rx_disable()

lan966x_fdma_rx_disable() uses rx->lan966x, which is still NULL at that
point. If NAPI has not been added yet, napi_disable() on the
uninitialized napi_struct could crash first.

A udev .link MTUBytes= setting or NetworkManager can apply an MTU at
netdev registration, which can land in this window.

> diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_fdma_pci.c b/drivers/net/ethernet/microchip/lan966x/lan966x_fdma_pci.c
> index bccd1b8590d74..7185e65dda435 100644
> --- a/drivers/net/ethernet/microchip/lan966x/lan966x_fdma_pci.c
> +++ b/drivers/net/ethernet/microchip/lan966x/lan966x_fdma_pci.c

[ ... ]

> @@ -391,9 +391,156 @@ static int lan966x_fdma_pci_init(struct lan966x *lan966x)

[ ... ]

> +static int lan966x_fdma_pci_reload(struct lan966x *lan966x, int new_mtu)
> +{
> +	struct fdma tx_fdma_old = lan966x->tx.fdma;
> +	struct fdma rx_fdma_old = lan966x->rx.fdma;
> +	u32 old_mtu = lan966x->rx.max_mtu;
> +	int err;
> +
> +	napi_disable(&lan966x->napi);
> +	lan966x_fdma_tx_disable_netdev(lan966x);
> +	lan966x_fdma_rx_disable(&lan966x->rx);
> +	lan966x_fdma_tx_disable(&lan966x->tx);

[ ... ]

> +	err = lan966x_fdma_pci_tx_alloc(&lan966x->tx);
> +	if (err) {
> +		fdma_free_coherent_and_unmap(lan966x->dma_dev,
> +					     &lan966x->rx.fdma);
> +		goto restore;
> +	}
> +
> +	/* Free and unmap old memory. */
> +	fdma_free_coherent_and_unmap(lan966x->dma_dev, &rx_fdma_old);
> +	fdma_free_coherent_and_unmap(lan966x->dma_dev, &tx_fdma_old);

[Severity: Low]
This is a pre-existing issue, but lan966x_fdma_rx_disable() and
lan966x_fdma_tx_disable() both ignore the return value of their poll on
FDMA_CH_ACTIVE:

	readx_poll_timeout_atomic(lan966x_fdma_channel_active, lan966x,
				  val, !(val & BIT(fdma->channel_id)),
				  READL_SLEEP_US, READL_TIMEOUT_US);

If a channel never goes idle, the old rings are freed here and their ATU
regions unmapped while the FDMA could still be using them. Should the
timeout be propagated, and the free skipped when it fires?

The timeout is READL_TIMEOUT_US (100 seconds), so this only matters for a
wedged engine. The platform lan966x_fdma_reload() and both deinit paths
already free rings after the same unchecked poll, so this patch just adds
another caller.

[ ... ]

>  static int lan966x_fdma_pci_resize(struct lan966x *lan966x)
>  {
> -	return -EOPNOTSUPP;
> +	int max_mtu;
> +
> +	/* Nothing to resize until fdma_pci_init() has built the rings; it
> +	 * sizes them from DEV_MAC_MAXLEN_CFG, which the caller already set.
> +	 */
> +	if (!lan966x->rx.lan966x)
> +		return 0;

[Severity: High]
Does a non-NULL rx.lan966x really mean the rings have been built?
lan966x_fdma_pci_init() sets it before either ring is allocated, and it
is not cleared when init fails:

lan966x_fdma_pci_init() {
	...
	lan966x->rx.lan966x = lan966x;
	...
	err = lan966x_fdma_pci_rx_alloc(&lan966x->rx);
	if (err)
		return err;

	err = lan966x_fdma_pci_tx_alloc(&lan966x->tx);
	if (err) {
		fdma_free_coherent_and_unmap(lan966x->dma_dev, rx_fdma);
		return err;
	}
	...
}

lan966x_fdma_pci_deinit() disables NAPI and frees both rings, but it
does not clear rx.lan966x or rx.max_mtu either.

The netdevs are still registered in both cases. lan966x_remove() calls
fdma_deinit before lan966x_cleanup_ports(), and it does so without RTNL.
When fdma_init fails, lan966x_probe() jumps to cleanup_ptp and reaches
lan966x_cleanup_ports() only later.

An MTU change in either window passes this check. Because rx.max_mtu is
stale, it then goes into lan966x_fdma_pci_reload().

After deinit, can the unconditional napi_disable() in
lan966x_fdma_pci_reload() spin forever in napi_disable_locked() while
holding RTNL? The first disable left SCHED|NPSVC set. lan966x_remove()
would then block in unregister_netdev() waiting for RTNL. If deinit and
the reload run at the same time, both would disable NAPI and free the
same coherent buffers and ATU regions.

After a tx_alloc failure in init, rx.fdma.dcbs still points at the
freed buffer. The reload copies it into rx_fdma_old and, if the new
allocation succeeds, frees it a second time with
fdma_free_coherent_and_unmap(&rx_fdma_old). The new rings are then left
running with nothing to free them, because the probe error path never
calls fdma_deinit.

If the reload's own allocation fails instead,
lan966x_fdma_pci_reset_mem() memsets the freed buffer and dereferences
the NULL atu_region.

Before this patch the PCIe resize returned -EOPNOTSUPP, so these paths
could not be reached. The later XDP patch in the series does not change
this check, init or deinit either.

Would this need a real ring-state flag, with teardown serialized against
MTU changes?

[Severity: High]
Can this check also race with lan966x_fdma_pci_init() itself?

lan966x_probe() calls fdma_init after register_netdev(), and without
RTNL. lan966x_fdma_pci_init() sets rx.lan966x first and tx.lan966x
later. It then allocates both rings with calls that can sleep
(dma_alloc_coherent(), the ATU mutex).

An ndo_change_mtu under RTNL can pass this check as soon as rx.lan966x
is set:

CPU1 (probe)                        CPU2 (RTNL)
lan966x_fdma_pci_init()
  lan966x->rx.lan966x = lan966x;
                                    lan966x_port_change_mtu()
                                      lan966x_fdma_pci_resize()
                                        __lan966x_fdma_pci_reload()
  lan966x_fdma_pci_rx_alloc()             lan966x_fdma_pci_reload()
                                            copies half-built rx/tx fdma
                                            allocates new rings
                                            frees "old" dcbs/ATU region

Both contexts then write the same rx/tx struct fdma. Init can overwrite
atu_region and dcbs. It can also hit WARN_ON(fdma->atu_region) in
fdma_alloc_coherent_and_map() and free rx_fdma, which by then may be the
buffer the reload just started the FDMA on.

Could this end in DMA into freed coherent memory, double frees, or
leaked ATU regions?

If the probe thread is preempted after setting rx.lan966x but before
setting tx.lan966x, would lan966x_fdma_tx_disable() and
lan966x_fdma_pci_tx_alloc() in the reload dereference a NULL
tx->lan966x?

> +
> +	max_mtu = lan966x_fdma_get_max_frame(lan966x);
> +	if (max_mtu == lan966x->rx.max_mtu)
> +		return 0;
> +
> +	return __lan966x_fdma_pci_reload(lan966x, max_mtu);
>  }

[ ... ]

> diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_main.h b/drivers/net/ethernet/microchip/lan966x/lan966x_main.h
> index 16bc28c8f11f8..1877f1916d716 100644
> --- a/drivers/net/ethernet/microchip/lan966x/lan966x_main.h
> +++ b/drivers/net/ethernet/microchip/lan966x/lan966x_main.h

[ ... ]

> @@ -87,6 +88,33 @@

[ ... ]

> +/* Largest db_size keeping the ATU-padded ring inside one MAX_PAGE_ORDER
> + * block and within the 16-bit DCB DATAL field. Inverts ALIGN(x, R) <= L
> + * into x <= ALIGN_DOWN(L, R) to bound x directly.
> + */
> +#define FDMA_PCI_DB_SIZE_MAX						\
> +	MIN_T(u32,							\
> +	      (ALIGN_DOWN(PAGE_SIZE << MAX_PAGE_ORDER,			\
> +			  FDMA_PCI_ATU_REGION_ALIGN) -			\
> +	       FDMA_PCI_DCB_MAX * sizeof(struct fdma_dcb)) /		\
> +	      (FDMA_PCI_DCB_MAX * FDMA_RX_DCB_MAX_DBS),			\
> +	      ALIGN_DOWN(GENMASK(15, 0), FDMA_PCI_DB_ALIGN))
> +
> +#define FDMA_PCI_MAX_MTU						\
> +	(FDMA_PCI_DB_SIZE_MAX - FDMA_OVERHEAD -				\
> +	 (ETH_HLEN + ETH_FCS_LEN))

[Severity: Low]
Can this arithmetic wrap on builds with a small MAX_PAGE_ORDER?

sizeof(struct fdma_dcb) is 256, so the subtracted term is 65536. If
PAGE_SIZE << MAX_PAGE_ORDER is below 64K, the unsigned subtraction
wraps. MIN_T(u32) truncates the result to 0xFFFFFF00, so the 16-bit
bound (65408) is picked, even though the ring would then be far larger
than one MAX_PAGE_ORDER block.

At 64K or 128K, FDMA_PCI_DB_SIZE_MAX is 0 or 256. That is below
FDMA_OVERHEAD, so FDMA_PCI_MAX_MTU wraps to roughly 4G, and
lan966x_probe_port() writes that value into dev->max_mtu. For blocks
smaller than about 1MB, the result is below the default MTU of 1500.

The value is correct for the tested configuration (4K pages,
MAX_PAGE_ORDER=10). arm32 ARCH_FORCE_MAX_ORDER has no range limit,
though, so the smaller configurations can be built.

Would a BUILD_BUG_ON() on this formula be worth adding?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260924-lan966x-pci-fdma-v8-0-201c7b707d8b%40microchip.com
