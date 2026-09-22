Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F1A654CF78;
	Tue, 22 Sep 2026 13:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790082059; cv=none; b=b9V2r8V8yyLQn5wOiTrSyeTYKU5sHB1SQaxosIHTMZnKcuCufwOoMbm5xYoQ+v6BVZnOkRYZc8o6zeft+yigfbpD7ZYWXPmd6/6V7qgC3wHF1wiWnr/rjiQiKFjvj2t9mlm1pmmWULYlJZDPv2du9zMGy/0B4FiKYBNZYPIYomE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790082059; c=relaxed/simple;
	bh=tdsYPqtgECvZ/pdNvrB2XafY5ujqEOjISpPvmoN0trs=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZXs6x1j+tnIhCxtQbDm8iTvg0yKkreyRolsvpDxuOGES58J5O3Ec3lGRKcCjBrDVISvz4u+pNV2hKyUtCi9CQNl7OSqd5PGTOY16WmBtjMo+fbyVyaZda36IKf5YrqLn5OxON5jchzylULGtOwWkrxK3CvrLMSY3OoU+VpgA+5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C6V60+pr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C6V60+pr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E06931F00898;
	Tue, 22 Sep 2026 13:00:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790082057;
	bh=Wj/7Xdnsm4ibHLoVgGnKY5bMcyQ8f/lFGwZELRbl09Y=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=C6V60+prcOEmg4/b8yrcPe/xz5QLoAwupA/83BXJGog/ley4gJyECquhrZDTcFkl5
	 g+2DwGqtsyGsjSJSrhxw7ci/+Szw8f3ea2N4AGJH8o8q50knib1TuJm8FzzWYXL2U1
	 qcRr02a3t+zXzzo9HxalhGpY5wCLtwtwncl7JfeBjg2Ok1bb35giDJpQMU8r02q8h2
	 lN5xAFRpRVkCpBeeHEJ23wiQNN2AKx7FZ5sHHmMzsMGWuT1RpQzFZJALhRqGjG3VEm
	 K/bhV1/F1bG3+9UbzDF2tNxF0r6kYsiP0r/9FQBuYdYNtLPsMzmJFEeyTi6G05DEWo
	 lrwxVvC1CxUMw==
Subject: Re: [PATCH net-next v7 12/14] net: lan966x: add PCIe FDMA XDP support
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
Date: Tue, 22 Sep 2026 13:00:55 +0000
Message-ID: <179008205544.2160803.323034395102452966@kernel.org>
In-Reply-To: <20260918-lan966x-pci-fdma-v7-12-0ecc179c8a2c@microchip.com>
References: <20260918-lan966x-pci-fdma-v7-12-0ecc179c8a2c@microchip.com>
X-sashiko-severity: Medium
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

Critical: 0 · High: 0 · Medium: 3 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The same lan966x driver now presents two different XDP frame
  views depending on the FDMA back-end.
- [Medium] lan966x_xdp_pci_run()
  (drivers/net/ethernet/microchip/lan966x/lan966x_fdma_pci.c) has no…
- [Medium] lan966x_fdma_pci_napi_poll() bounds its RX loop only by the
  caller-supplied weight, and clears the DONE bits solely in the…

--

net: lan966x: add PCIe FDMA XDP support

This adds XDP support to the lan966x PCIe FDMA path, running the BPF
program on the contiguous ATU-mapped RX buffer and implementing XDP_TX by
rebuilding the IFH and memcpy'ing the post-XDP frame into a TX slot. The
IFH and FCS are now stripped in lan966x_fdma_pci_rx_check_frame() before
the program runs, and lan966x_xdp_setup() no longer rejects programs on
the PCIe path.

A few questions below.

> diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_fdma_pci.c b/drivers/net/ethernet/microchip/lan966x/lan966x_fdma_pci.c
> index 940425beec2f..e833dbb4fcf0 100644
> --- a/drivers/net/ethernet/microchip/lan966x/lan966x_fdma_pci.c
> +++ b/drivers/net/ethernet/microchip/lan966x/lan966x_fdma_pci.c

[ ... ]

> +static int lan966x_xdp_pci_run(struct lan966x_port *port, void *data,
> +			       u32 data_len, void **xdp_data, u32 *xdp_len)
> +{

[ ... ]

> +	act = bpf_prog_run_xdp(xdp_prog, &xdp);
> +
> +	*xdp_data = xdp.data;
> +	*xdp_len = xdp.data_end - xdp.data;
> +
> +	switch (act) {
> +	case XDP_PASS:
> +		return FDMA_PASS;
> +	case XDP_TX:
> +		return lan966x_fdma_pci_xmit_xdpf(port, *xdp_data, *xdp_len) ?
> +		       FDMA_DROP : FDMA_TX;
> +	default:
> +		bpf_warn_invalid_xdp_action(port->dev, xdp_prog, act);

[Severity: Medium]
Should this switch have an XDP_REDIRECT arm, at least for the bonding
case?  XDP_TX can be rewritten into XDP_REDIRECT inside
bpf_prog_run_xdp() before the driver sees the action:

include/net/xdp.h:bpf_prog_run_xdp() {
	u32 act = __bpf_prog_run(prog, xdp, BPF_DISPATCHER_FUNC(xdp));

	if (static_branch_unlikely(&bpf_master_redirect_enabled_key)) {
		if (act == XDP_TX && netif_is_bond_slave(xdp->rxq->dev))
			act = xdp_master_redirect(xdp);
	}
	...
}

bond_xdp_set() increments bpf_master_redirect_enabled_key and only
requires the slave to provide ndo_bpf and ndo_xdp_xmit, both of which
lan966x_port_netdev_ops provides on the PCIe path as well.  Before this
patch lan966x_xdp_setup() rejected any program on the PCIe path, so this
combination was not reachable; now it is.

With no XDP_REDIRECT case, a program returning XDP_TX on a bonded PCIe
port lands in the default arm, so the frame is dropped,
bpf_warn_invalid_xdp_action() prints "Driver unsupported XDP return value
4", trace_xdp_exception() fires, and the per-CPU redirect info stashed by
xdp_master_redirect() is never consumed - while lan966x_probe_port() now
advertises NETDEV_XDP_ACT_BASIC (XDP_TX) for exactly this path.

The other implementer of the same lan966x_fdma_action values,
lan966x_xdp_run() in lan966x_xdp.c, does handle XDP_REDIRECT, so the two
sides of the shared enum disagree.

> +		fallthrough;
> +	case XDP_ABORTED:
> +		trace_xdp_exception(port->dev, xdp_prog, act);
> +		fallthrough;
> +	case XDP_DROP:
> +		return FDMA_DROP;
> +	}
> +}
> +
> +static int lan966x_fdma_pci_rx_check_frame(struct lan966x_rx *rx, u64 *src_port,
> +					   void **data, u32 *data_len)
>  {
>  	struct lan966x *lan966x = rx->lan966x;
>  	struct fdma *fdma = &rx->fdma;
> @@ -168,38 +286,33 @@ static int lan966x_fdma_pci_rx_check_frame(struct lan966x_rx *rx, u64 *src_port)
>  	if (!lan966x_fdma_pci_rx_size_fits(fdma, blockl))
>  		return FDMA_ERROR;
>  
> -	return FDMA_PASS;
> +	/* Present the Ethernet frame (no IFH, no FCS). HW re-inserts the
> +	 * FCS on TX; see lan966x_fdma_pci_xmit_xdpf(). May be overridden
> +	 * by XDP. The FCS strip is unconditional because NETIF_F_RXFCS
> +	 * is not advertised in hw_features.
> +	 */
> +	*data = virt_addr + IFH_LEN_BYTES;
> +	*data_len = blockl - IFH_LEN_BYTES - ETH_FCS_LEN;
> +
> +	return lan966x_xdp_pci_run(port, virt_addr, *data_len, data, data_len);
>  }

[Severity: Medium]
The commit message states:

    XDP sees the frame with IFH and FCS stripped.

Is that only true for the PCIe back-end?  The platform back-end of the
same driver hands the FCS to the program:

drivers/net/ethernet/microchip/lan966x/lan966x_xdp.c:lan966x_xdp_run() {
	...
	xdp_prepare_buff(&xdp, page_address(page),
			 IFH_LEN_BYTES + XDP_PACKET_HEADROOM,
			 data_len - IFH_LEN_BYTES, false);
	...
}

and the trailing 4 bytes are only removed afterwards, once the program has
already run:

drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c:lan966x_fdma_rx_get_frame() {
	...
	if (likely(!(skb->dev->features & NETIF_F_RXFCS)))
		skb_trim(skb, skb->len - ETH_FCS_LEN);
	...
}

So one XDP program keyed on xdp->data_end - xdp->data, or doing an IP
total-length cross-check or tail parsing, sees 4 extra bytes on a platform
lan966x and not on a PCIe lan966x, and for XDP_TX the platform path
re-sends the stale FCS as payload while the PCIe path strips it and lets
HW insert a fresh one.

Could either the platform path be harmonized in this series, or the commit
message say that the divergence is known and intentional?

[ ... ]

> @@ -287,6 +400,8 @@ static int lan966x_fdma_pci_napi_poll(struct napi_struct *napi, int weight)
>  	struct sk_buff *skb;
>  	int counter = 0;
>  	u64 src_port;
> +	u32 data_len;
> +	void *data;
>  
>  	/* Wake any stopped TX queues if a TX DCB is available. */
>  	spin_lock(&lan966x->tx_lock);
> @@ -303,7 +418,10 @@ static int lan966x_fdma_pci_napi_poll(struct napi_struct *napi, int weight)
>  		/* Order DONE read before DCB/frame reads below. */
>  		dma_rmb();
>  		counter++;
> -		switch (lan966x_fdma_pci_rx_check_frame(rx, &src_port)) {
> +		switch (lan966x_fdma_pci_rx_check_frame(rx,
> +							&src_port,
> +							&data,
> +							&data_len)) {
>  		case FDMA_PASS:
>  			break;
>  		case FDMA_ERROR:
> @@ -312,8 +430,17 @@ static int lan966x_fdma_pci_napi_poll(struct napi_struct *napi, int weight)
>  			 */
>  			fdma_dcb_advance(fdma);
>  			continue;
> +		case FDMA_TX:
> +			fdma_dcb_advance(fdma);
> +			continue;
> +		case FDMA_DROP:
> +			fdma_dcb_advance(fdma);
> +			continue;
>  		}

[Severity: Medium]
Can the same descriptors be processed twice when the RX loop consumes the
whole ring in one poll?

The RX loop is bounded only by the caller-supplied weight, and the DONE
bits are cleared solely by the fdma_dcb_add() in the replenish loop, whose
trip count comes from a wrapped index comparison:

lan966x_fdma_pci_napi_poll() {
	dcb_reload = fdma->dcb_index;

	while (counter < weight) {
		if (!fdma_has_frames(fdma))
			break;
		...
	}
	while (dcb_reload != fdma->dcb_index) {
		old_dcb = dcb_reload;
		dcb_reload++;
		dcb_reload &= fdma->n_dcbs - 1;

		fdma_dcb_add(fdma, old_dcb, ...);
		lan966x_fdma_rx_reload(rx);
	}
	...
}

The PCIe ring has FDMA_PCI_DCB_MAX = 256 descriptors.  With all 256 DONE
and weight >= 256, fdma_dcb_advance() wraps fdma->dcb_index back to
dcb_reload, so the replenish loop runs zero iterations: nothing is
re-armed and no DONE bit is cleared.  counter == weight also suppresses
napi_complete_done(), so the next poll re-processes the same 256
descriptors - duplicate skbs via napi_gro_receive(), and with this patch
the same frames are re-run through the BPF program and re-transmitted by
lan966x_fdma_pci_xmit_xdpf() on XDP_TX.

A weight >= 256 is reachable through busy polling: SO_BUSY_POLL_BUDGET
accepts up to U16_MAX (CAP_NET_ADMIN needed to raise it) and
__napi_busy_loop() passes that budget straight into napi->poll():

net/core/dev.c:__napi_busy_loop() {
	...
	work = napi_poll(napi, budget);
	...
}

The loop shape itself came in with "net: lan966x: add PCIe FDMA support"
earlier in this series, and the platform twin lan966x_fdma_napi_poll() has
the same shape with 512 DCBs; this patch extends the switch with
FDMA_TX/FDMA_DROP, which adds the repeated XDP execution and repeated
transmit to the effects.  Would counting consumed descriptors and capping
the loop at fdma->n_dcbs address this?

> -		skb = lan966x_fdma_pci_rx_get_frame(rx, src_port);
> +		skb = lan966x_fdma_pci_rx_get_frame(rx,
> +						    src_port,
> +						    data,
> +						    data_len);
>  		fdma_dcb_advance(fdma);
>  		if (!skb) {
>  			lan966x->ports[src_port]->dev->stats.rx_dropped++;

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260918-lan966x-pci-fdma-v7-0-0ecc179c8a2c%40microchip.com
