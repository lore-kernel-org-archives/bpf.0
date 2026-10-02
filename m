Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF6BB470E8C;
	Fri,  2 Oct 2026 09:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790932286; cv=none; b=tTDYUx4PPB3A8CH7DCKeTU9qY4CNmL+imjStVWHDToJrJnglV5t7BcwmYX9ufAl2CXVCCnI2YeOOPqA94DBEE9jkqARcXJos0NdWxMmYtDpJGgOGDrZqpSCQ/FARvGHkUqosrKucwrAvnLMOM6XKAonuptfavLas4n7/RG0U7ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790932286; c=relaxed/simple;
	bh=QyiqJbVNVVWpOjOeWDvCPx4TpBrd1c2J6poMC4kMREk=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o4j4OVdyN4lXnGni9Pc8vQYBsSFfMDAJBo8HjXXUxBwHS3Z5VhrXDqqLObZLzZuuAFHm5b31qm65ACOeky4cbHkuKljqamoM1c9jzUB95GeYp3FZ0ErgmuCczOHQgMFpS862CR/1zq7qAb92+14suLRvL7IDw3IBlt39pFJOrH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=wM3uMVOw; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="wM3uMVOw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1790932284; x=1822468284;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=QyiqJbVNVVWpOjOeWDvCPx4TpBrd1c2J6poMC4kMREk=;
  b=wM3uMVOwtjXsxw3/gr8jcpB1KsSx3heks6O3PpJmnybtD9Cg4IchOVcu
   4T20z7+tH24+8Nuh47qvttaSzhrwjg4d7k91f6AM32CV77ifzrD3dbLTE
   6PIhZ50a4Fgu8I6oXhsB7pRwB3X8jWoD+wyNM8dyTIacVy+p3NbF3QQ3N
   a49WkMKABoGwykRhIniPmOf8tMky8MQrsFfGcUf9kAgvEXD8hhqKm2saf
   ndQ+hHdkNJzF8NLA1WiYLU7HAnWIMx6r07VKJV8sUQ1GvB1VmTERNdgf4
   0xtD+yoACF6CLpykkY4f+3NVzPrpmgo3W86ivwYuwpy+K2M/Gtq2W3aRP
   g==;
X-CSE-ConnectionGUID: K6kcmqTgQBOroRaveL+Z0A==
X-CSE-MsgGUID: DyHNEIi1RiWBs0+eM9r5zA==
X-IronPort-AV: E=Sophos;i="6.27,136,1787036400"; 
   d="scan'208";a="63547435"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 02 Oct 2026 02:11:23 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Fri, 2 Oct 2026 02:11:23 -0700
Received: from DEN-DL-M70577 (10.10.85.11) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Fri, 2 Oct 2026 02:11:19 -0700
Date: Fri, 2 Oct 2026 11:11:18 +0200
From: Daniel Machon <daniel.machon@microchip.com>
To: <netdev-bot+sashiko@kernel.org>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <horatiu.vultur@microchip.com>,
	<steen.hegelund@microchip.com>, <UNGLinuxDriver@microchip.com>,
	<ast@kernel.org>, <daniel@iogearbox.net>, <hawk@kernel.org>,
	<john.fastabend@gmail.com>, <sdf@fomichev.me>, <herve.codina@bootlin.com>,
	<arnd@arndb.de>, <gregkh@linuxfoundation.org>, <mohsin.bashr@gmail.com>,
	<horms@kernel.org>, <richardcochran@gmail.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH net-next v9 13/15] net: lan966x: add PCIe FDMA XDP support
Message-ID: <20261002091118.dnavfb3whz5enjcd@DEN-DL-M70577>
References: <20260928-lan966x-pci-fdma-v9-13-a17caf60f89a@microchip.com>
 <179092642155.434549.4173203120024624969@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <179092642155.434549.4173203120024624969@kernel.org>

> Thank you for your contribution! Sashiko AI review found 2 potential
> issue(s) to consider.
> 
> Critical: 0 · High: 0 · Medium: 1 · Low: 1
> 
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
> 
> - [Medium] This patch removes the PCIe rejection from lan966x_xdp_setup()
>   (drivers/net/ethernet/microchip/lan966x/lan966x_xdp.c), so a bond can…
> - [Low] In lan966x_xdp_pci_run(), xdp_init_buff() is called with frame_sz
>   = fdma->db_size, and hard_start is the slot start (virt_addr -…
> 
> --
> 
> net: lan966x: add PCIe FDMA XDP support
> 
> This commit adds XDP support to the lan966x PCIe FDMA path. The IFH and
> FCS are stripped before the program runs, and XDP_TX is done by copying
> the frame into a TX slot behind a newly built IFH. lan966x_xdp_setup()
> no longer rejects PCIe and skips the page_pool reload on that path.
> 
> > diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_fdma_pci.c b/drivers/net/ethernet/microchip/lan966x/lan966x_fdma_pci.c
> > index 758554c951c52..949994874ed96 100644
> > --- a/drivers/net/ethernet/microchip/lan966x/lan966x_fdma_pci.c
> > +++ b/drivers/net/ethernet/microchip/lan966x/lan966x_fdma_pci.c
> 
> [ ... ]
> 
> > @@ -139,7 +140,123 @@ static bool lan966x_fdma_pci_rx_size_fits(struct fdma *fdma, u32 blockl)
> >  	       blockl <= fdma->db_size - XDP_PACKET_HEADROOM;
> >  }
> >  
> 
> [ ... ]
> 
> > +static int lan966x_xdp_pci_run(struct lan966x_port *port, void *data,
> > +			       u32 data_len, void **xdp_data, u32 *xdp_len)
> > +{
> 
> [ ... ]
> 
> > +	xdp_init_buff(&xdp, fdma->db_size, &port->xdp_rxq);
> > +
> > +	/* hard_start is set to slot start (virt_addr is XDP_PACKET_HEADROOM
> > +	 * into the slot). Headroom includes the IFH; BPF may grow into it
> > +	 * via adjust_head. IFH is rebuilt on XDP_TX and unread on XDP_PASS.
> > +	 */
> > +	xdp_prepare_buff(&xdp,
> > +			 data - XDP_PACKET_HEADROOM,
> > +			 XDP_PACKET_HEADROOM + IFH_LEN_BYTES,
> > +			 data_len,
> > +			 false);
> 
> [Severity: Low]
> Can data_end end up past xdp_data_hard_end() here?
> 
> frame_sz is the full db_size and hard_start is the start of the slot, so
> the XDP core computes the data limit as:
> 
> include/net/xdp.h:xdp_data_hard_end()
>     ((xdp)->data_hard_start + (xdp)->frame_sz -
>      SKB_DATA_ALIGN(sizeof(struct skb_shared_info)))
> 
> The upper bound in lan966x_fdma_pci_rx_size_fits(), shown in the context
> above, only reserves the headroom:
> 
>     blockl <= fdma->db_size - XDP_PACKET_HEADROOM;
> 
> lan966x_fdma_pci_rx_check_frame() sets data to slot + XDP_PACKET_HEADROOM
> + IFH_LEN_BYTES and data_len to blockl - IFH_LEN_BYTES - ETH_FCS_LEN. At
> the largest accepted blockl, data_end is then slot + db_size -
> ETH_FCS_LEN, roughly 316 bytes past xdp_data_hard_end().
> 
> For such a buffer, bpf_xdp_adjust_tail() returns -EINVAL for any offset,
> shrinks included, because it checks this first:
> 
>     if (unlikely(data_end > data_hard_end))
>         return -EINVAL;
> 
> Reaching this needs a blockl that eats into the shinfo reserve, for
> example a malformed BLOCKL. It could also be an oversized frame truncated
> to DATAL while lan966x_port_change_mtu() has raised MAXLEN but
> fdma_resize() has not yet reallocated the rings.
> 
> Memory safety is not affected, since data_end stays inside the slot the
> driver owns.
> 
> Should lan966x_fdma_pci_rx_size_fits() also reserve
> SKB_DATA_ALIGN(sizeof(struct skb_shared_info)) so it matches the frame_sz
> given to xdp_init_buff()?
> 
> > +
> > +	act = bpf_prog_run_xdp(xdp_prog, &xdp);
> > +
> > +	*xdp_data = xdp.data;
> > +	*xdp_len = xdp.data_end - xdp.data;
> > +
> > +	switch (act) {
> > +	case XDP_PASS:
> > +		return FDMA_PASS;
> > +	case XDP_TX:
> > +		return lan966x_fdma_pci_xmit_xdpf(port, *xdp_data, *xdp_len) ?
> > +		       FDMA_DROP : FDMA_TX;
> > +	default:
> > +		bpf_warn_invalid_xdp_action(port->dev, xdp_prog, act);
> > +		fallthrough;
> > +	case XDP_ABORTED:
> > +		trace_xdp_exception(port->dev, xdp_prog, act);
> > +		fallthrough;
> > +	case XDP_DROP:
> > +		return FDMA_DROP;
> > +	}
> > +}
> 
> [Severity: Medium]
> Now that lan966x_xdp_setup() no longer rejects PCIe, can a bond attach a
> program to lan966x PCIe ports and then have its XDP_TX frames silently
> dropped here?
> 
> The ports share lan966x_port_netdev_ops, which provides both .ndo_bpf and
> .ndo_xdp_xmit. That is all bond_xdp_set() checks, so it accepts these
> ports. It then pushes the program down:
> 
> bond_xdp_set()
>     dev_xdp_propagate()
>         lan966x_xdp_setup()    <- now succeeds on PCIe
> 
> bond_xdp_set() also calls
> static_branch_inc(&bpf_master_redirect_enabled_key). After that,
> bpf_prog_run_xdp() rewrites XDP_TX on a bond slave:
> 
>     if (act == XDP_TX && netif_is_bond_slave(xdp->rxq->dev))
>         act = xdp_master_redirect(xdp);
> 
> In round-robin, XOR and 802.3ad modes, xdp_master_redirect() returns
> XDP_REDIRECT whenever the bond picks a transmit slave other than the
> receiving port. That action falls into the default case above:
> 
> bpf_warn_invalid_xdp_action() -> trace_xdp_exception() -> FDMA_DROP
> 
> A bond program that only returns XDP_TX attaches without error, but a
> hash- or round-robin-dependent share of its packets is dropped. With two
> slaves in round-robin, that is about half. Before this patch the attach
> failed with -EOPNOTSUPP.
> 
> Should the PCIe path handle XDP_REDIRECT, or keep refusing the attach
> when the port is a bond slave?

Re-raise of issue dismissed in v7. xdp_features doesn't advertise REDIRECT on
PCIe, and the warning path is the intended fallback

> 
> [ ... ]
> 
> -- 
> Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260928-lan966x-pci-fdma-v9-0-a17caf60f89a%40microchip.com
