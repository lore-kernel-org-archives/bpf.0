Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D824B43F8C8;
	Fri,  2 Oct 2026 07:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790926421; cv=none; b=iHSfb3a9fXzKTBW8LD89f33gIQWXHRPZ8eQXR76a9Mh4jxE2havKS9yrf+tSaJXp/3wO4Hq+PEP5mz6VwPGyaLbdiXK+yXb9uFzSlPsKwPFXT0IfJu4WOiaPPtpIUOaS3rxwF2DvzsbNKTvhKAInOWwLCdI4rMTZ7MyLvKgVX3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790926421; c=relaxed/simple;
	bh=Q9P9XUaOkiudvSmfCOXXnrdvZkVH7/T1KpEhSbhorXw=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QDq5idnV5g+lszQ/tonvp6vb2wDs+Htn4skBNFedgqCdvtViNnDu37/TSSJ6hSHrZ07eYurlR/DDmFYEgWOPv0lFYBCBviuCx5fs4COTq8QgcQWMVdHx2XqtJrd0M/SrMzdRZTOvQ+rhAhApWkgP7ZfgV/ttQsw2qj/SV+JzitM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NBAUQQAq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NBAUQQAq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AF3E1F000FF;
	Fri,  2 Oct 2026 07:33:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790926419;
	bh=De8mm47Dqq8xwOUDEsY2KEZPW93OpNe5BducNLl/enI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=NBAUQQAqxEfj76uKA8n4n36LD8PrTtK7/Nki4ooyuGK/nyzUcIIkBCa18eubzLHqf
	 xGy5JlN2LienKbbsR2lCC0Yxf+T2gdmO0P8FfZW/T8EfyG5ElXsccohumNDEcazB3o
	 Xut67KW+P64LOq8RTsezYNRfhFUpsibEZ75STSqRRIEJnpdh5yV711JkoD4dEtMsqj
	 B8zXpufpsnw5wqjeO35Bs2y0ZhjtO7OaGKA060c6jdGQmRdQK5bVaaiW3qjnMqBimz
	 jOPSWNB5LT8nq/oDDtVL5v5jNpkSsKpxutEN/dKRV9vYPiRQxS4PTdPsKO1fhEANGz
	 ZYW/ZIn0bnIUw==
Subject: Re: [PATCH net-next v9 11/15] net: lan966x: add PCIe FDMA support
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
Date: Fri, 02 Oct 2026 07:33:37 +0000
Message-ID: <179092641772.434549.10428923177677726938@kernel.org>
In-Reply-To: <20260928-lan966x-pci-fdma-v9-11-a17caf60f89a@microchip.com>
References: <20260928-lan966x-pci-fdma-v9-11-a17caf60f89a@microchip.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 8 potential
issue(s) to consider.

Critical: 0 · High: 0 (1) · Medium: 3 (1) · Low: 5 (1)

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] Double fetch of the RX BLOCKL.
- [Medium] lan966x_fdma_pci_napi_poll() limits RX consumption only by
  `counter < weight` and tracks refill progress only through the wrapped…
- [Medium] When lan966x_fdma_pci_get_next_dcb() finds no free TX DCB,
  lan966x_fdma_pci_xmit() calls netif_stop_queue(dev) and returns…
- [Low] At this commit the in-tree PCIe overlay
  (drivers/misc/lan966x_pci.dtso) has no "fdma" interrupt.
- [Low] The iomap entry { TARGET_PCIE_DBI, 0x400000, 0 } derives
  regs[TARGET_PCIE_DBI] 4 MB into IO range 0.
- [Low] lan966x_fdma_pci_resize() always returns -EOPNOTSUPP, so once
  PCIe FDMA is active every ndo_change_mtu call is rolled back.
- [Low] In lan966x_fdma_pci_napi_poll(), the FDMA_ERROR branch says "No
  rx_dropped increment here because src_port is invalid".
- [Low] With lan966x->ptp left at 0 on PCIe, lan966x_ptp_init() never
  initialises port->tx_skbs or the PTP locks, while the "ptp" IRQ…

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but the new PCIe
  backend inherits it.
- [Medium] __fdma_dcb_add() writes fdma->last_dcb->nextptr (publishing
  the new DCB) before it writes the new DCB's own nextptr =…
- [Low] lan966x_fdma_pci_hw_offload() reads ip_hdr(skb)->protocol and
  ipv6_hdr(skb)->daddr without checking that skb->len covers an IP…

--

net: lan966x: add PCIe FDMA support

This commit adds a PCIe FDMA backend for lan966x. It uses contiguous
coherent DMA buffers mapped through the endpoint's ATU and copies frames
with memcpy. The new ops are selected when lan966x_is_pci() is true, and
XDP and PTP are disabled on the PCIe path.

> diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_fdma_pci.c b/drivers/net/ethernet/microchip/lan966x/lan966x_fdma_pci.c
> new file mode 100644
> index 000000000000..f511e7061314
> --- /dev/null
> +++ b/drivers/net/ethernet/microchip/lan966x/lan966x_fdma_pci.c

[ ... ]

> +static bool lan966x_fdma_pci_hw_offload(struct lan966x *lan966x, u32 port,
> +					struct sk_buff **pskb)
> +{

[ ... ]

> +	if (skb->protocol == htons(ETH_P_IP) &&
> +	    ip_hdr(skb)->protocol == IPPROTO_IGMP)
> +		return false;
> +
> +	if (IS_ENABLED(CONFIG_IPV6) &&
> +	    skb->protocol == htons(ETH_P_IPV6) &&
> +	    ipv6_addr_is_multicast(&ipv6_hdr(skb)->daddr) &&
> +	    !ipv6_mc_check_mld(skb))
> +		return false;

[Severity: Low]
This isn't a bug introduced by this patch, because the same code already
exists in lan966x_hw_offload() in lan966x_main.c. Still,
ip_hdr(skb)->protocol and ipv6_hdr(skb)->daddr are read here without
checking that skb->len covers an IP header.

On a runt frame, or on a frame shrunk by an XDP program once XDP support
lands later in the series, could this read uninitialized skb tailroom?

The reads stay inside the skb head allocation, and any minimum-size
Ethernet frame covers both fields. So only the offload_fwd_mark decision
for an already malformed packet is affected.

> +static struct sk_buff *lan966x_fdma_pci_rx_get_frame(struct lan966x_rx *rx,
> +						     u64 src_port)
> +{

[ ... ]

> +	/* Get the received frame and create an SKB for it. */
> +	db = fdma_db_next_get(fdma);
> +	data_len = fdma_db_len_get(db);
> +
> +	skb = napi_alloc_skb(&lan966x->napi, data_len);
> +	if (unlikely(!skb))
> +		return NULL;
> +
> +	memcpy(skb->data,
> +	       fdma_dataptr_virt_addr_contiguous(fdma,
> +						 fdma->dcb_index,
> +						 fdma->db_index),
> +						 data_len);

[Severity: Medium]
BLOCKL is validated in lan966x_fdma_pci_rx_check_frame() through
lan966x_fdma_pci_rx_size_fits(). Here it is read again from the DCB
status in coherent DMA memory.

Can the value passed to napi_alloc_skb() and memcpy() differ from the
value that was checked?

It looks like "net: lan966x: add PCIe FDMA XDP support" later in the
series fixes this. That patch reads blockl once in rx_check_frame() and
passes data and data_len to rx_get_frame(). Would it make sense to fold
that change into this patch?

At this commit the path isn't enabled in-tree yet, because the overlay
has no "fdma" interrupt.

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
netif_stop_queue() only stops TX queue 0. Each port netdev is created in
lan966x_probe_port() with 8 TX queues:

	dev = devm_alloc_etherdev_mqs(lan966x->dev,
				      sizeof(struct lan966x_port),
				      NUM_PRIO_QUEUES, 1);

There is no ndo_select_queue, so skbs are spread over all 8 queues.
lan966x_fdma_wakeup_netdev(), called from the PCIe NAPI poll, also only
checks and wakes queue 0.

When the shared TX ring is full and an skb arrives on one of queues 1 to
7, does that queue ever get stopped?

It looks like sch_direct_xmit() would requeue the skb and reschedule the
qdisc. net_tx_action would then keep retrying, taking tx_lock and
scanning the whole DCB ring each time, until the hardware completes a
DCB.

Would netif_tx_stop_all_queues() and netif_tx_wake_all_queues() be a
better fit here? The platform lan966x_fdma_xmit() has the same pattern,
and lan966x_fdma_pci_xmit_xdpf() from "net: lan966x: add PCIe FDMA XDP
support" repeats it.

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

[Severity: Medium]
This is a pre-existing issue in the shared fdma_api.c helper and was not
introduced by this patch, but the new backend depends on it.
__fdma_dcb_add() links the new DCB into the chain before terminating it,
and there is no DMA write barrier between the two steps:

drivers/net/ethernet/microchip/fdma/fdma_api.c:__fdma_dcb_add() {
    ...
	fdma->last_dcb->nextptr = cpu_to_le64(nextptr);

	fdma->last_dcb = dcb;

	dcb->nextptr = cpu_to_le64(FDMA_DCB_INVALID_DATA);
	dcb->info = cpu_to_le64(info);
    ...
}

If the FDMA channel is still walking the chain, could it follow the new
link and read a stale nextptr or info from the new DCB?

The window is short, and whether the hardware acts on it depends on its
prefetch behavior. When the channel is stopped, the writel() doorbell in
lan966x_fdma_tx_start() or lan966x_fdma_rx_reload() orders the earlier
stores.

[ ... ]

> +static int lan966x_fdma_pci_napi_poll(struct napi_struct *napi, int weight)
> +{

[ ... ]

> +	dcb_reload = fdma->dcb_index;
> +
> +	/* Get all received skbs. */
> +	while (counter < weight) {
> +		if (!fdma_has_frames(fdma))
> +			break;
> +		/* Order DONE read before DCB/frame reads below. */
> +		dma_rmb();
> +		counter++;
> +		switch (lan966x_fdma_pci_rx_check_frame(rx, &src_port)) {
> +		case FDMA_PASS:
> +			break;
> +		case FDMA_ERROR:
> +			/* No rx_dropped increment here because src_port is
> +			 * invalid.
> +			 */

[Severity: Low]
Is this comment accurate for every FDMA_ERROR return?
lan966x_fdma_pci_rx_check_frame() also returns FDMA_ERROR after src_port
and ports[src_port] have already been validated:

	blockl = fdma_db_len_get(db);
	if (!lan966x_fdma_pci_rx_size_fits(fdma, blockl))
		return FDMA_ERROR;

In that case a frame with a bad BLOCKL on a valid port is dropped without
being counted in rx_dropped or rx_length_errors. This code is unchanged
at the end of the series.

> +			fdma_dcb_advance(fdma);
> +			continue;
> +		}

[ ... ]

> +	while (dcb_reload != fdma->dcb_index) {
> +		old_dcb = dcb_reload;
> +		dcb_reload++;
> +		dcb_reload &= fdma->n_dcbs - 1;

[Severity: Medium]
The RX loop is bounded only by counter < weight. Refill progress is
tracked only through the wrapped dcb_reload and dcb_index values.

What happens if weight >= n_dcbs and every DCB is DONE? n_dcbs is
FDMA_DCB_MAX, which is 512 here and 256 after "net: lan966x: add PCIe
FDMA MTU change support".

fdma_dcb_advance() would wrap dcb_index back to dcb_reload. DONE bits are
only cleared by this refill loop, so the RX loop would then reprocess
stale DONE descriptors and pass the same frames to napi_gro_receive()
again.

When weight is a multiple of n_dcbs, dcb_reload equals fdma->dcb_index at
this point. The refill loop then doesn't run at all, and the ring is left
un-armed.

The normal NAPI weight of 64 can't reach this, but busy polling can.
__napi_busy_loop() passes the socket's budget straight to napi->poll, and
SO_BUSY_POLL_BUDGET accepts values up to U16_MAX with CAP_NET_ADMIN.

The native lan966x_fdma_napi_poll() has the same structure. This is
still present at the end of the series.

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
At this commit the in-tree PCIe overlay (drivers/misc/lan966x_pci.dtso)
only declares:

	interrupt-names = "xtr", "ana";

As a result lan966x->fdma stays false on the PCIe instance, and this
function returns right away. Is it intended that the new backend is
dormant at this commit?

The "fdma" interrupt is added later in the series by "misc: lan966x-pci:
dts: add fdma interrupt to overlay". Until then the driver keeps using
register-based I/O.

[ ... ]

> +	lan966x->tx.lan966x = lan966x;
> +	tx_fdma->channel_id = FDMA_INJ_CHANNEL;
> +	tx_fdma->n_dcbs = FDMA_DCB_MAX;

[Severity: High]
This isn't a bug introduced by this patch, because the platform
lan966x_fdma_init() uses the same ordering, but the new PCIe backend
inherits it.

lan966x_probe() sets lan966x->fdma = true, registers every port netdev,
and enables NAPI (lan966x_port_init() -> lan966x_fdma_netdev_init()), all
before it calls lan966x->ops->fdma_init().

Here tx_fdma->n_dcbs is set without holding tx_lock. tx_fdma->dcbs is
only allocated later, in lan966x_fdma_pci_tx_alloc(). That happens after
the GFP_KERNEL coherent allocation in lan966x_fdma_pci_rx_alloc(), which
can sleep.

If a port is opened and transmits during that window, can the following
happen?

lan966x_port_xmit()
    spin_lock(&lan966x->tx_lock);
    if (port->lan966x->fdma)
        lan966x->ops->fdma_xmit()
            lan966x_fdma_pci_xmit()
                lan966x_fdma_pci_get_next_dcb()
                    fdma_db_get(fdma, i, 0)   <- fdma->dcbs is NULL

Later in the same window, xmit could also pick DCBs that
fdma_dcbs_init() has already marked DONE while last_dcb is still being
set up. It could also start the injection channel before
lan966x_fdma_llp_configure() has programmed the TX LLP.

Would either of these close the window?

- Calling fdma_init before the ports are registered.
- Publishing n_dcbs under tx_lock, only after the rings are allocated.

[ ... ]

> +static int lan966x_fdma_pci_resize(struct lan966x *lan966x)
> +{
> +	return -EOPNOTSUPP;
> +}

[Severity: Low]
lan966x_port_change_mtu() rolls back the MTU whenever
lan966x->ops->fdma_resize() fails. With this stub, won't every
ndo_change_mtu call fail once PCIe FDMA is active?

The next patch, "net: lan966x: add PCIe FDMA MTU change support",
replaces the stub with a real implementation. At this commit the path is
dormant, because the overlay has no "fdma" interrupt.

[ ... ]

> diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_main.c b/drivers/net/ethernet/microchip/lan966x/lan966x_main.c
> index 024ce9f9916c..de2202786826 100644
> --- a/drivers/net/ethernet/microchip/lan966x/lan966x_main.c
> +++ b/drivers/net/ethernet/microchip/lan966x/lan966x_main.c
> @@ -50,6 +50,7 @@ struct lan966x_main_io_resource {
>  static const struct lan966x_main_io_resource lan966x_main_iomap[] =  {
>  	{ TARGET_CPU,                   0xc0000, 0 }, /* 0xe00c0000 */
>  	{ TARGET_FDMA,                  0xc0400, 0 }, /* 0xe00c0400 */
> +	{ TARGET_PCIE_DBI,             0x400000, 0 }, /* 0xe0400000 */

[Severity: Low]
This entry places regs[TARGET_PCIE_DBI] 4 MB into IO range 0. At this
commit the overlay's "cpu" reg is only 1 MB:

	reg = <0xe0000000 0x0100000>,

Wouldn't the iATU accesses from fdma_pci_atu_init(), and the region map
and unmap, fall outside the ioremap window?

This can't be reached at this commit, because lan966x_fdma_pci_init()
returns early without an "fdma" interrupt. Later in the series, "misc:
lan966x-pci: dts: extend cpu reg to cover PCIE DBI space" enlarges the
reg to 0x0800000, and it comes before the "fdma" interrupt is added. On
the SoC instance the pointer is computed but never used.

[ ... ]

> @@ -1187,7 +1190,9 @@ static int lan966x_probe(struct platform_device *pdev)
>  		if (err)
>  			return dev_err_probe(&pdev->dev, err, "Unable to use ptp irq");
> 
> -		lan966x->ptp = 1;
> +		/* PTP is not supported on the PCIe path yet. */
> +		if (!lan966x_is_pci(lan966x))
> +			lan966x->ptp = 1;
>  	}

[Severity: Low]
With lan966x->ptp left at 0 on PCIe, lan966x_ptp_init() never
initializes port->tx_skbs or the PTP locks. If a "ptp" interrupt exists,
lan966x_ptp_irq_handler has already been registered just above. Could
that handler then touch uninitialized PTP state?

This can't happen in-tree, because drivers/misc/lan966x_pci.dtso doesn't
declare a "ptp" interrupt. Would it be more robust to also skip the ptp
IRQ request on PCIe?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260928-lan966x-pci-fdma-v9-0-a17caf60f89a%40microchip.com
