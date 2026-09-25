Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 865C04F30C9;
	Fri, 25 Sep 2026 20:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790369553; cv=none; b=FRmmeHecgA+4tCgVuImanSY8gQRydYBPvEpCrmw9URt7mIjep/5ak+GlkBem1t1bUOUB9sdKlZhb1C215Pn+dTXPcff/5AjS2IZgi3ds2WTf2wn0bFfDeUCcTRhbVSdpR9PX+xNLl1TN6/XDuZb81/1V00O81Cz+ghIj7xShjZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790369553; c=relaxed/simple;
	bh=EyUClTCfMWodpc9p35CvyDLpfye+ESA3Yakdbe4gzJk=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Cl1mgq190naOtxAsFqzXrriJ9jnzUqiJNlF/tCHo1YnIoxn5P4vi5Lzsfa/0cVEAXh+743oXySAHehyGG/QC+e5war7D0Q3qYNwCSVsciVK9LsGC9Ytoe0QV/Cu9y/Xrf8D/8S0XiXYjAy/+lXUqZ1GSUXsAJhy4r8sCWxY7RkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K9y1ICp1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K9y1ICp1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B46B81F00893;
	Fri, 25 Sep 2026 20:52:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790369550;
	bh=HJBDZZ+S0CHTq5BbIZKIHfblsDf8J6KmFhWf/nYvPDg=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=K9y1ICp1Wx60avDD3+tQQexfkUYZlo1dNY7s94IrCYJ854aicgYaW2FVXlp/eYrFY
	 KmP1jqvwpN3rEMLUed9ff1qbBL1KdFufbvd3bra1Ltp4uUmGlfCLKf5yvaoJMrNb5p
	 D7fBQmi6GX9IRBA2+94zcSmOwCsEDLDiXp+Ykrl/Vk6nNNTz8/tYWZAk4VF/3SShkm
	 kiLK09Bn6SD5ixmMI2kpal2UhaWuB4Sskqe2/w0ZV9WcAGmoj12sujiHK7nu+aQSS1
	 ZyiRxfyeiAAXSwkapsWFs0WfifCXDSg8Vbsldt7JsxBEB0+zdDF3JSLcdD0sXqJ0pq
	 ePAoTLlcyxe5g==
Subject: Re: [PATCH net-next v8 11/15] net: lan966x: add PCIe FDMA support
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
Date: Fri, 25 Sep 2026 20:52:28 +0000
Message-ID: <179036954826.2160803.4060688622764457742@kernel.org>
In-Reply-To: <20260924-lan966x-pci-fdma-v8-11-201c7b707d8b@microchip.com>
References: <20260924-lan966x-pci-fdma-v8-11-201c7b707d8b@microchip.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 11 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 6 (1) · Low: 5

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] lan966x_fdma_pci_napi_poll() limits RX processing only by the
  caller's budget and decides which descriptors to re-arm with `while…
- [Medium] Port netdevs are allocated with NUM_PRIO_QUEUES TX queues
  (devm_alloc_etherdev_mqs(..., NUM_PRIO_QUEUES, 1)).
- [Medium] lan966x_fdma_pci_init() sets tx_fdma->n_dcbs = FDMA_DCB_MAX
  (FDMA_PCI_DCB_MAX at the series end) before allocating the ring.
- [Medium] lan966x->fdma is set to true, and the port netdevs are
  registered, before lan966x->ops->fdma_init() runs.
- [Medium] At this commit, lan966x_fdma_pci_rx_check_frame() reads and
  validates BLOCKL, but lan966x_fdma_pci_rx_get_frame() re-reads it from…
- [Medium] lan966x_fdma_pci_get_next_dcb() treats a TX DCB as free when
  DB0 has DONE set and the DCB is not fdma->last_dcb, and it always…
- [Low] At this commit the in-tree PCIe overlay
  (drivers/misc/lan966x_pci.dtso) declares only the "xtr" and "ana"…
- [Low] The patch adds TARGET_PCIE_DBI at offset 0x400000 in IO range 0
  ("cpu").
- [Low] At this commit lan966x_fdma_pci_resize() always returns
  -EOPNOTSUPP, so lan966x_port_change_mtu() rolls back every MTU change…
- [Low] In lan966x_fdma_pci_napi_poll(), the FDMA_ERROR case says "No
  rx_dropped increment here because src_port is invalid".
- [Low] lan966x_main.h documents FDMA_ERROR as "something went wrong,
  stop getting more frames", and the platform lan966x_fdma_napi_poll()…

Pre-existing issues:
- [Medium] __fdma_dcb_add() writes the DB status and dataptr, links the
  DCB into the live chain (fdma->last_dcb->nextptr = new), and only then…

--

net: lan966x: add PCIe FDMA support

This adds a PCIe FDMA backend for lan966x. The backend uses contiguous
coherent DMA buffers mapped through the endpoint ATU and copies frames with
memcpy. The patch also maps the PCIe DBI register target, disables PTP on
the PCIe path and rejects XDP on PCIe instances.

> diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_fdma_pci.c b/drivers/net/ethernet/microchip/lan966x/lan966x_fdma_pci.c
> new file mode 100644
> index 0000000000000..bccd1b8590d74
> --- /dev/null
> +++ b/drivers/net/ethernet/microchip/lan966x/lan966x_fdma_pci.c
> @@ -0,0 +1,421 @@

[ ... ]

> +static int lan966x_fdma_pci_get_next_dcb(struct fdma *fdma)
> +{
> +	struct fdma_db *db;
> +
> +	for (int i = 0; i < fdma->n_dcbs; i++) {
> +		db = fdma_db_get(fdma, i, 0);
> +
> +		if (!fdma_db_is_done(db))
> +			continue;
> +		if (fdma_is_last(fdma, &fdma->dcbs[i]))
> +			continue;
> +
> +		return i;
> +	}
> +
> +	return -ENOSPC;
> +}

[Severity: Medium]
Can this hand out the DCB that the TX engine is still parked on?

A DCB counts as free here once DB0 has DONE set and it is not
fdma->last_dcb. The scan always starts at index 0.

Suppose the engine is parked on a completed DCB0 whose NEXTPTR is INVALID:

xmit B
  lan966x_fdma_pci_get_next_dcb() returns 1
  __fdma_dcb_add(1): DCB0->nextptr = DCB1, last_dcb = DCB1
  lan966x_fdma_tx_start() writes CH_RELOAD

xmit C (right after, serialized only by tx_lock)
  lan966x_fdma_pci_get_next_dcb() returns 0 (DONE, not last)
  __fdma_dcb_add(0): clears DCB0 DONE, DCB1->nextptr = DCB0,
                     DCB0->nextptr = INVALID

What if the engine re-reads DCB0.NEXTPTR after the posted RELOAD write
and after C's stores? Would it then see INVALID and stay parked?

In that case frames B and C would never be sent, and DCB0 and DCB1 would
never see DONE again. The next xmit would link DCB0 to DCB2 and strand
them. If this repeats, the ring could drain until xmit returns
NETDEV_TX_BUSY for good.

This depends on the FDMA RELOAD semantics, which I could not confirm. The
platform path uses a used flag for similar selection. The same logic
appears in lan966x_fdma_pci_xmit_xdpf() later in the series.

[ ... ]

> +static int lan966x_fdma_pci_rx_check_frame(struct lan966x_rx *rx, u64 *src_port)
> +{

[ ... ]

> +	blockl = fdma_db_len_get(db);
> +	if (!lan966x_fdma_pci_rx_size_fits(fdma, blockl))
> +		return FDMA_ERROR;
> +
> +	return FDMA_PASS;
> +}
> +
> +static struct sk_buff *lan966x_fdma_pci_rx_get_frame(struct lan966x_rx *rx,
> +						     u64 src_port)
> +{

[ ... ]

> +	/* Get the received frame and create an SKB for it. */
> +	db = fdma_db_next_get(fdma);
> +	data_len = fdma_db_len_get(db);
> +
> +	skb = napi_alloc_skb(&lan966x->napi, data_len);

[Severity: Medium]
Is it safe to read BLOCKL a second time here?

lan966x_fdma_pci_rx_check_frame() validates BLOCKL but then drops the
value. This function reads it again from coherent memory that the device
can write. The second, unchecked value then drives napi_alloc_skb(),
memcpy(), skb_put(), skb_pull() and skb_trim().

If the endpoint rewrites BLOCKL between the two loads, could this read
past the buffer or underflow skb->len?

The later patch "net: lan966x: add PCIe FDMA XDP support" appears to fix
this. It computes data_len once in rx_check_frame() and passes it into
rx_get_frame(). The path is also not reachable at this commit, because the
overlay has no "fdma" irq.

[ ... ]

> +static int lan966x_fdma_pci_xmit(struct sk_buff *skb, __be32 *ifh,
> +				 struct net_device *dev)
> +{

[ ... ]

> +	next_to_use = lan966x_fdma_pci_get_next_dcb(fdma);
> +
> +	if (next_to_use < 0) {
> +		netif_stop_queue(dev);
> +		return NETDEV_TX_BUSY;
> +	}

[Severity: Medium]
Does netif_stop_queue() stop the queue this skb came from?

lan966x_probe_port() creates port netdevs with NUM_PRIO_QUEUES TX queues:

    dev = devm_alloc_etherdev_mqs(lan966x->dev,
                                  sizeof(struct lan966x_port),
                                  NUM_PRIO_QUEUES, 1);

There is no ndo_select_queue, so traffic is hashed over all 8 queues.
netif_stop_queue(dev) stops only txq 0. lan966x_fdma_wakeup_netdev(),
called from the new poll, also checks and wakes only txq 0.

For an skb on txq 1-7, the qdisc requeues it, calls __netif_schedule() and
retries at once, because that queue was never stopped. Could
net_tx_action then spin in softirq, contending on tx_lock, until a DCB
frees up?

The same pattern shows up in lan966x_fdma_pci_xmit_xdpf() later in the
series.

[ ... ]

> +	/* Order frame write before DCB status write below. */
> +	dma_wmb();
> +
> +	fdma_dcb_add(fdma,
> +		     next_to_use,
> +		     0,
> +		     FDMA_DCB_STATUS_INTR |
> +		     FDMA_DCB_STATUS_SOF |
> +		     FDMA_DCB_STATUS_EOF |
> +		     FDMA_DCB_STATUS_BLOCKO(0) |
> +		     FDMA_DCB_STATUS_BLOCKL(IFH_LEN_BYTES + skb->len + ETH_FCS_LEN));
> +
> +	/* Start the transmission. */
> +	lan966x_fdma_tx_start(tx);

[Severity: Medium]
This is a pre-existing issue in __fdma_dcb_add() and was not introduced
by this patch, but the new PCIe TX and RX re-arm paths depend on it.

__fdma_dcb_add() links the new DCB into the live chain before it has
finished initializing it, with no barrier in between:

drivers/net/ethernet/microchip/fdma/fdma_api.c:__fdma_dcb_add() {
    ...
	fdma->last_dcb->nextptr = cpu_to_le64(nextptr);
	fdma->last_dcb = dcb;
	dcb->nextptr = cpu_to_le64(FDMA_DCB_INVALID_DATA);
	dcb->info = cpu_to_le64(info);
    ...
}

The dma_wmb() here orders only the frame data against the descriptor
stores. Both callers then issue a CH_RELOAD writel(), which orders the
earlier stores. That leaves a problem only if the engine follows a
freshly written nextptr without a RELOAD.

Can this FDMA do that? If it can, could the device fetch a DCB whose
nextptr or info is still stale?

[ ... ]

> +static int lan966x_fdma_pci_napi_poll(struct napi_struct *napi, int weight)
> +{

[ ... ]

> +		switch (lan966x_fdma_pci_rx_check_frame(rx, &src_port)) {
> +		case FDMA_PASS:
> +			break;
> +		case FDMA_ERROR:
> +			/* No rx_dropped increment here because src_port is
> +			 * invalid.
> +			 */
> +			fdma_dcb_advance(fdma);
> +			continue;
> +		}

[Severity: Low]
Is this comment accurate? lan966x_fdma_pci_rx_check_frame() also returns
FDMA_ERROR when BLOCKL fails lan966x_fdma_pci_rx_size_fits(). By that
point it has already confirmed that src_port is in range and
ports[src_port] is non-NULL:

	blockl = fdma_db_len_get(db);
	if (!lan966x_fdma_pci_rx_size_fits(fdma, blockl))
		return FDMA_ERROR;

So a frame dropped for its length on a valid port is counted in neither
rx_dropped nor rx_length_errors. This is still the case at the end of the
series.

[Severity: Low]
Should FDMA_ERROR stop the loop here? lan966x_main.h documents it as:

 * FDMA_ERROR, something went wrong, stop getting more frames

and lan966x_fdma_napi_poll() on the platform path follows that:

	case FDMA_ERROR:
		lan966x_fdma_rx_free_page(rx);
		fdma_dcb_advance(fdma);
		goto allocate_new;

The PCIe poll instead advances and keeps pulling frames up to the budget.
The two backends therefore handle the same action code differently. The
code is unchanged at the end of the series.

> +		skb = lan966x_fdma_pci_rx_get_frame(rx, src_port);
> +		fdma_dcb_advance(fdma);
> +		if (!skb) {
> +			lan966x->ports[src_port]->dev->stats.rx_dropped++;
> +			continue;
> +		}
> +
> +		napi_gro_receive(&lan966x->napi, skb);
> +	}
> +	while (dcb_reload != fdma->dcb_index) {
> +		old_dcb = dcb_reload;
> +		dcb_reload++;
> +		dcb_reload &= fdma->n_dcbs - 1;

[Severity: Medium]
What happens here when the budget is at least n_dcbs?

The RX loop above is bounded only by weight, not by the ring size. If
every descriptor is DONE and weight >= n_dcbs, fdma_dcb_advance() wraps
dcb_index back to where it started. This loop then runs zero times, no DCB
goes back to the hardware and the DONE bits stay set.

Won't the next poll then deliver the same stale frames again?

With budgets above n_dcbs, descriptors are also revisited within a single
call, and only the modulo remainder is re-armed.

__napi_busy_loop() passes the busy-poll budget straight to napi->poll().
SO_BUSY_POLL_BUDGET accepts up to U16_MAX with CAP_NET_ADMIN. n_dcbs is
512 here and 256 (FDMA_PCI_DCB_MAX) at the end of the series. The platform
poll has the same pattern.

[ ... ]

> +static int lan966x_fdma_pci_init(struct lan966x *lan966x)
> +{
> +	struct fdma *rx_fdma = &lan966x->rx.fdma;
> +	struct fdma *tx_fdma = &lan966x->tx.fdma;
> +	int err;
> +
> +	if (!lan966x->fdma)
> +		return 0;

[Severity: Low]
Can any of the new PCIe FDMA code run at this commit?

lan966x_probe() sets lan966x->fdma only when an "fdma" irq exists. The
in-tree overlay drivers/misc/lan966x_pci.dtso declares only:

	interrupt-names = "xtr", "ana";

so on PCIe this function returns immediately. The "~620 Mbps" figure in
the commit message can't be reproduced from this commit alone.

The later patch "misc: lan966x-pci: dts: add fdma interrupt to overlay"
adds the interrupt, so this is resolved once the series is applied.

[ ... ]

> +	lan966x->tx.lan966x = lan966x;
> +	tx_fdma->channel_id = FDMA_INJ_CHANNEL;
> +	tx_fdma->n_dcbs = FDMA_DCB_MAX;

[Severity: Medium]
Can a transmit race with this initialization?

When lan966x_probe() calls lan966x->ops->fdma_init(), lan966x->fdma is
already true and the port netdevs are already registered.

This function publishes tx_fdma->n_dcbs, db_size and the ops callbacks
without holding lan966x->tx_lock. It then sleeps in dma_alloc_coherent(),
via fdma_alloc_coherent_and_map(). Only after that does it set
tx.fdma.dcbs and atu_region.

A transmit on a port that is up with carrier during that window would
take this path:

lan966x_port_xmit()
  spin_lock(&lan966x->tx_lock)
  lan966x->ops->fdma_xmit()
    lan966x_fdma_pci_xmit()
      lan966x_fdma_pci_get_next_dcb()
        fdma_db_get(fdma, i, 0)   <- dcbs is still NULL

It could also pick a DCB whose DONE bit fdma_dcbs_init() has just set.
fdma_dcb_add() would then run with a NULL atu_region in
lan966x_fdma_pci_dataptr_cb().

Before this point n_dcbs is 0 from kzalloc, so the window opens exactly at
this assignment. The platform backend has the same probe ordering.

[ ... ]

> +	err = lan966x_fdma_pci_rx_alloc(&lan966x->rx);
> +	if (err)
> +		return err;
> +
> +	err = lan966x_fdma_pci_tx_alloc(&lan966x->tx);
> +	if (err) {
> +		fdma_free_coherent_and_unmap(lan966x->dma_dev, rx_fdma);
> +		return err;
> +	}

[Severity: Medium]
Does this error path leave tx.fdma and rx.fdma in a state that xmit can
still use?

tx_fdma->n_dcbs stays set. tx.fdma.dcbs is then either NULL, if
dma_alloc_coherent() failed, or points at freed coherent memory, because
fdma_alloc_coherent_and_map() frees the buffer without clearing the
pointer:

	region = fdma_pci_atu_region_map(atu, fdma->dma, fdma->size);
	if (IS_ERR(region)) {
		fdma_free_coherent(dev, fdma);
		return PTR_ERR(region);
	}

In the same way, rx.fdma.dcbs is left dangling after
fdma_free_coherent_and_unmap(rx_fdma).

Probe then unwinds through cleanup_ptp, cleanup_fdb and cleanup_ports.
lan966x->fdma stays true until lan966x_cleanup_ports() unregisters the
netdevs. Could a transmit on an up port in that window reach
lan966x_fdma_pci_get_next_dcb() and dereference NULL or read freed memory?

If a stale DONE bit is seen, the memcpy() in lan966x_fdma_pci_xmit() would
write into the freed buffer. fdma_dcb_add() would then use the NULL
atu_region.

[ ... ]

> +static int lan966x_fdma_pci_resize(struct lan966x *lan966x)
> +{
> +	return -EOPNOTSUPP;
> +}

[Severity: Low]
With this stub, won't lan966x_port_change_mtu() roll back every MTU
change on a PCIe FDMA instance?

	err = lan966x->ops->fdma_resize(lan966x);
	if (err) {
		...
		dev->mtu = old_mtu;
	}

The later patch "net: lan966x: add PCIe FDMA MTU change support" replaces
this stub with a real resize. The PCIe FDMA path also can't be reached at
this commit, because the overlay has no "fdma" irq.

[ ... ]

> diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_main.c b/drivers/net/ethernet/microchip/lan966x/lan966x_main.c
> index 024ce9f9916c7..de22027868261 100644
> --- a/drivers/net/ethernet/microchip/lan966x/lan966x_main.c
> +++ b/drivers/net/ethernet/microchip/lan966x/lan966x_main.c
> @@ -50,6 +50,7 @@ struct lan966x_main_io_resource {
>  static const struct lan966x_main_io_resource lan966x_main_iomap[] =  {
>  	{ TARGET_CPU,                   0xc0000, 0 }, /* 0xe00c0000 */
>  	{ TARGET_FDMA,                  0xc0400, 0 }, /* 0xe00c0400 */
> +	{ TARGET_PCIE_DBI,             0x400000, 0 }, /* 0xe0400000 */

[Severity: Low]
Is range 0 large enough for this offset at this commit?

The in-tree overlay sizes the "cpu" resource at 1 MB:

	reg = <0xe0000000 0x0100000>, ...

lan966x_create_targets() ioremaps only resource_size() and does not check
the offsets against it. lan966x_fdma_pci_init() passes
regs[TARGET_PCIE_DBI] to fdma_pci_atu_init(), which writes at
+0x300000 + 0x200 * idx, so those writes would fall outside the mapping.

This code runs only when lan966x->fdma is true. The later patch
"misc: lan966x-pci: dts: extend cpu reg to cover PCIE DBI space" grows
the reg to 0x800000 before the "fdma" irq is added, so the out-of-range
write can't happen at any point in the series.

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260924-lan966x-pci-fdma-v8-0-201c7b707d8b%40microchip.com
