Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2935F48F823;
	Thu, 10 Sep 2026 13:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789045554; cv=none; b=s8Y138CqNRpdKfy8U/j8WOLLuCZ6Q5EfVnzQ0ISstKYmPJZz77DreTl9FGkEgYDPXeUJ4m2FEZIPFYsRk+uMffa3jwc9q5WPPJVR9oy/QjUm2t/BjPCCoAz77XWfs9uTfYhRGa6ZIIMdyV/Hmfr8rfkpc7nLTPz9NQbGftc4qvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789045554; c=relaxed/simple;
	bh=2BM3Kgrx6IKnaPuau/ag3+DHrIZNrb6PzEIcFyv/gBM=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FC+ECRRcL+qqqFIj55xSNhLzFx7uBp5e7U6P90Q4cT8ik0QNrzg/DUvOZsrSqwO7MPm4UAdT8asGWihLLF8KJSQZN3XzrCVBtpWNXQi3+BmYDLCERmov3evZTgEqsmbsowydjWh9RjrmwARCj7ZSGtF5IAldJIWPCotCLDBWB3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oMswmUb6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oMswmUb6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E4C11F00893;
	Thu, 10 Sep 2026 13:05:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789045552;
	bh=05JqaFBeFEoQ2fVd/vXC0wIOHHckjhCp9F0L301SgEs=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=oMswmUb6eg3Tll5EF2xsdbpXrhXxaQMiQvHzCNWSK+3kpuVxphOLK9YWNqTZElwsD
	 DM2oxIvfkfivDx8wV2DSRahqTgvZdRAiBeWRz9Da+58K+nnc8vA2FR1356iSNxTvZw
	 clX4CazWt7cxNDaSwsXRCrW+d4oEOFxGIPvRUkhszAYVSOL4i3qO/Gqh07H4KpkVSh
	 UJ8hGbYWIoc0ihmBOVkFU/W4LvPP2Lm1B8fJMolq/GMmM/WSweTrkEPvzGXWrsMgND
	 f7qL0PNKnwbP2lS5XmE5AQzc0fq0Ujp7k+/HKU+xpPSLJDjUvgRk46WAW9hGbR1rfP
	 k6jT5K9Quj3qw==
Subject: Re: [PATCH net-next v6 12/14] net: lan966x: add PCIe FDMA XDP support
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
Date: Thu, 10 Sep 2026 13:05:51 +0000
Message-ID: <178904555117.219967.2055099842496630976@kernel.org>
In-Reply-To: <20260909-lan966x-pci-fdma-v6-12-6f48dab9d671@microchip.com>
References: <20260909-lan966x-pci-fdma-v6-12-6f48dab9d671@microchip.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider:

Critical: 0 · High: 0 · Medium: 1 · Low: 0

- [Medium] Inconsistent XDP frame presentation between the two RX hooks
  of the same driver: after this patch lan966x has two in-tree XDP RX…

--

net: lan966x: add PCIe FDMA XDP support

This adds XDP support to the lan966x PCIe FDMA path, using contiguous
ATU-mapped buffers and a memcpy-based XDP_TX instead of the page_pool
scheme used by the platform path. The IFH and FCS are stripped before
the BPF program runs, and lan966x_xdp_setup() now skips the page_pool
reload for the PCIe case. Only XDP_ACT_BASIC is advertised for PCIe.

> diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_fdma_pci.c b/drivers/net/ethernet/microchip/lan966x/lan966x_fdma_pci.c
> index 6cabbb8b47f2..02c021617a3e 100644
> --- a/drivers/net/ethernet/microchip/lan966x/lan966x_fdma_pci.c
> +++ b/drivers/net/ethernet/microchip/lan966x/lan966x_fdma_pci.c

[ ... ]

> @@ -126,7 +127,123 @@ static bool lan966x_fdma_pci_rx_size_fits(struct fdma *fdma, u32 blockl)

[ ... ]

> +static int lan966x_xdp_pci_run(struct lan966x_port *port, void *data,
> +			       u32 data_len, void **xdp_data, u32 *xdp_len)
> +{

[ ... ]

> +	xdp_prepare_buff(&xdp,
> +			 data - XDP_PACKET_HEADROOM,
> +			 XDP_PACKET_HEADROOM + IFH_LEN_BYTES,
> +			 data_len,
> +			 false);
> +
> +	act = bpf_prog_run_xdp(xdp_prog, &xdp);

[ ... ]

> @@ -158,38 +275,33 @@ static int lan966x_fdma_pci_rx_check_frame(struct lan966x_rx *rx, u64 *src_port)
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
Should the two lan966x XDP receive hooks agree on whether the FCS is part
of the window handed to the BPF program?

On the PCIe path, lan966x_fdma_pci_rx_check_frame() subtracts the FCS
before calling into the program:

	*data_len = blockl - IFH_LEN_BYTES - ETH_FCS_LEN;

	return lan966x_xdp_pci_run(port, virt_addr, *data_len, data, data_len);

On the platform path, lan966x_fdma_rx_check_frame() passes the raw BLOCKL
value and lan966x_xdp_run() only removes the IFH:

drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c:lan966x_fdma_rx_check_frame() {
	...
	return lan966x_xdp_run(port, page, FDMA_DCB_STATUS_BLOCKL(db->status));
}

drivers/net/ethernet/microchip/lan966x/lan966x_xdp.c:lan966x_xdp_run() {
	...
	xdp_prepare_buff(&xdp, page_address(page),
			 IFH_LEN_BYTES + XDP_PACKET_HEADROOM,
			 data_len - IFH_LEN_BYTES, false);
}

That BLOCKL value still contains the FCS, as shown by the trim done later
on the same path:

drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c:lan966x_fdma_rx_get_frame() {
	...
	skb_put(skb, FDMA_DCB_STATUS_BLOCKL(db->status));
	...
	skb_pull(skb, IFH_LEN_BYTES);

	if (likely(!(skb->dev->features & NETIF_F_RXFCS)))
		skb_trim(skb, skb->len - ETH_FCS_LEN);
}

So xdp.data_end points four bytes past the end of the Ethernet payload on
the platform path, and exactly at the end of the payload on the new PCIe
path. Both windows stay inside the DMA buffer, so this looks like a
behavioural difference rather than an out-of-bounds access.

A program that parses backwards from data_end, compares data_end - data
against an L3 length field, or trims via bpf_xdp_adjust_tail() would get
different results depending on whether the switch is platform- or
PCIe-attached. The PCIe framing matches the usual XDP convention of no
FCS, which would make the platform hook the one that differs from
convention.

> diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_main.c b/drivers/net/ethernet/microchip/lan966x/lan966x_main.c
> index e089c08b9c37..9ada497767c6 100644
> --- a/drivers/net/ethernet/microchip/lan966x/lan966x_main.c
> +++ b/drivers/net/ethernet/microchip/lan966x/lan966x_main.c
> @@ -874,11 +874,13 @@ static int lan966x_probe_port(struct lan966x *lan966x, u32 p,
>  
>  	port->phylink = phylink;
>  
> -	/* XDP is not supported on the PCIe FDMA path. */
> -	if (lan966x->fdma && !lan966x_is_pci(lan966x))
> -		dev->xdp_features = NETDEV_XDP_ACT_BASIC |
> -				    NETDEV_XDP_ACT_REDIRECT |
> -				    NETDEV_XDP_ACT_NDO_XMIT;
> +	if (lan966x->fdma) {
> +		dev->xdp_features = NETDEV_XDP_ACT_BASIC;
> +
> +		if (!lan966x_is_pci(lan966x))
> +			dev->xdp_features |= NETDEV_XDP_ACT_REDIRECT |
> +					     NETDEV_XDP_ACT_NDO_XMIT;
> +	}

[Severity: Medium]
Both paths now report the same NETDEV_XDP_ACT_BASIC bit from
lan966x_probe_port(), so is there anything in the uAPI that lets a
program distinguish the FCS-included window of lan966x_xdp_run() from
the FCS-stripped window of lan966x_xdp_pci_run()?

Would it make sense to make one of the two hooks match the other so that
the frame presentation is the same for identically-advertised netdevs?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260909-lan966x-pci-fdma-v6-0-6f48dab9d671%40microchip.com
