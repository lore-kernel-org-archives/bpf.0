Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3BAA443AB0;
	Fri,  2 Oct 2026 07:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790926425; cv=none; b=odAE1HbRwTna3EvFEUF/0VH74T6QVnE0xeuHbD3Mbi4o4wB436OMELut5d83+4SQFaOvaTkIoxShBWgH88vteUAb6eYF001pbFsb/zo/KJgrC8DuzoneiS5X0FNRUdjNcy2alw81hQA0BJ4fLQ92mymFJTDGW+ltvo5ntV8uTHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790926425; c=relaxed/simple;
	bh=nyvWjHcv/AS4QiA+RXhq4KUw6mL8FYVCaMKLaZ1cnzk=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dr9RJ0yZvh/a5RlirbdBAxmo+Qyck5p8tGn22yWKUEBXS+sKihoCtnuUzKG/EpCVpgIhBbHTR9BrFrc9zbo+WPKMCngIMCnixiCiYsjBqDeW/V2nO+eluD2j4FfjsVYCWbb1AGxgDNi/+DWaSBVBNW6Ha22PXxsKB/8KfB2hqxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nT4s4qzA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nT4s4qzA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 039041F0089A;
	Fri,  2 Oct 2026 07:33:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790926423;
	bh=/bjJuVdlO1Nwdwt/JwclPfDOlhy65SBr4h+jou97nng=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=nT4s4qzApJjjSLt/9PsPLpcfKxXgFYVH4IVUvcJt7tk62cpB+5EPA/y5trsGCWnc5
	 9hrFJfXKmxDqA9j6ygpJhoQ5IyNX5xo5hH6u0CmkvXR4C6m4k9s9LIhHPUKDksiEU+
	 rJY3q0mDNlqLmgwagbO1gNu/V2o40bAzmdQRZ0rbmxKGlEURvTj2BDEs1RlNdvUHqt
	 Mk4yTWnhVBEEtUE9tMqM/wgjiF+NDq68kS0pmD42VnqIcjKBzQEtTVyGFBwaAYBoOC
	 YhzGBIHNECseY+El0qu9rqLvJwBadaVhNenELWZ7B6oE5r5WBPbNxeTTgAyWw2zl6g
	 j2jrGnzZ3Ej4w==
Subject: Re: [PATCH net-next v9 13/15] net: lan966x: add PCIe FDMA XDP support
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
Date: Fri, 02 Oct 2026 07:33:41 +0000
Message-ID: <179092642155.434549.4173203120024624969@kernel.org>
In-Reply-To: <20260928-lan966x-pci-fdma-v9-13-a17caf60f89a@microchip.com>
References: <20260928-lan966x-pci-fdma-v9-13-a17caf60f89a@microchip.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] This patch removes the PCIe rejection from lan966x_xdp_setup()
  (drivers/net/ethernet/microchip/lan966x/lan966x_xdp.c), so a bond can…
- [Low] In lan966x_xdp_pci_run(), xdp_init_buff() is called with frame_sz
  = fdma->db_size, and hard_start is the slot start (virt_addr -…

--

net: lan966x: add PCIe FDMA XDP support

This commit adds XDP support to the lan966x PCIe FDMA path. The IFH and
FCS are stripped before the program runs, and XDP_TX is done by copying
the frame into a TX slot behind a newly built IFH. lan966x_xdp_setup()
no longer rejects PCIe and skips the page_pool reload on that path.

> diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_fdma_pci.c b/drivers/net/ethernet/microchip/lan966x/lan966x_fdma_pci.c
> index 758554c951c52..949994874ed96 100644
> --- a/drivers/net/ethernet/microchip/lan966x/lan966x_fdma_pci.c
> +++ b/drivers/net/ethernet/microchip/lan966x/lan966x_fdma_pci.c

[ ... ]

> @@ -139,7 +140,123 @@ static bool lan966x_fdma_pci_rx_size_fits(struct fdma *fdma, u32 blockl)
>  	       blockl <= fdma->db_size - XDP_PACKET_HEADROOM;
>  }
>  

[ ... ]

> +static int lan966x_xdp_pci_run(struct lan966x_port *port, void *data,
> +			       u32 data_len, void **xdp_data, u32 *xdp_len)
> +{

[ ... ]

> +	xdp_init_buff(&xdp, fdma->db_size, &port->xdp_rxq);
> +
> +	/* hard_start is set to slot start (virt_addr is XDP_PACKET_HEADROOM
> +	 * into the slot). Headroom includes the IFH; BPF may grow into it
> +	 * via adjust_head. IFH is rebuilt on XDP_TX and unread on XDP_PASS.
> +	 */
> +	xdp_prepare_buff(&xdp,
> +			 data - XDP_PACKET_HEADROOM,
> +			 XDP_PACKET_HEADROOM + IFH_LEN_BYTES,
> +			 data_len,
> +			 false);

[Severity: Low]
Can data_end end up past xdp_data_hard_end() here?

frame_sz is the full db_size and hard_start is the start of the slot, so
the XDP core computes the data limit as:

include/net/xdp.h:xdp_data_hard_end()
    ((xdp)->data_hard_start + (xdp)->frame_sz -
     SKB_DATA_ALIGN(sizeof(struct skb_shared_info)))

The upper bound in lan966x_fdma_pci_rx_size_fits(), shown in the context
above, only reserves the headroom:

    blockl <= fdma->db_size - XDP_PACKET_HEADROOM;

lan966x_fdma_pci_rx_check_frame() sets data to slot + XDP_PACKET_HEADROOM
+ IFH_LEN_BYTES and data_len to blockl - IFH_LEN_BYTES - ETH_FCS_LEN. At
the largest accepted blockl, data_end is then slot + db_size -
ETH_FCS_LEN, roughly 316 bytes past xdp_data_hard_end().

For such a buffer, bpf_xdp_adjust_tail() returns -EINVAL for any offset,
shrinks included, because it checks this first:

    if (unlikely(data_end > data_hard_end))
        return -EINVAL;

Reaching this needs a blockl that eats into the shinfo reserve, for
example a malformed BLOCKL. It could also be an oversized frame truncated
to DATAL while lan966x_port_change_mtu() has raised MAXLEN but
fdma_resize() has not yet reallocated the rings.

Memory safety is not affected, since data_end stays inside the slot the
driver owns.

Should lan966x_fdma_pci_rx_size_fits() also reserve
SKB_DATA_ALIGN(sizeof(struct skb_shared_info)) so it matches the frame_sz
given to xdp_init_buff()?

> +
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
> +		fallthrough;
> +	case XDP_ABORTED:
> +		trace_xdp_exception(port->dev, xdp_prog, act);
> +		fallthrough;
> +	case XDP_DROP:
> +		return FDMA_DROP;
> +	}
> +}

[Severity: Medium]
Now that lan966x_xdp_setup() no longer rejects PCIe, can a bond attach a
program to lan966x PCIe ports and then have its XDP_TX frames silently
dropped here?

The ports share lan966x_port_netdev_ops, which provides both .ndo_bpf and
.ndo_xdp_xmit. That is all bond_xdp_set() checks, so it accepts these
ports. It then pushes the program down:

bond_xdp_set()
    dev_xdp_propagate()
        lan966x_xdp_setup()    <- now succeeds on PCIe

bond_xdp_set() also calls
static_branch_inc(&bpf_master_redirect_enabled_key). After that,
bpf_prog_run_xdp() rewrites XDP_TX on a bond slave:

    if (act == XDP_TX && netif_is_bond_slave(xdp->rxq->dev))
        act = xdp_master_redirect(xdp);

In round-robin, XOR and 802.3ad modes, xdp_master_redirect() returns
XDP_REDIRECT whenever the bond picks a transmit slave other than the
receiving port. That action falls into the default case above:

bpf_warn_invalid_xdp_action() -> trace_xdp_exception() -> FDMA_DROP

A bond program that only returns XDP_TX attaches without error, but a
hash- or round-robin-dependent share of its packets is dropped. With two
slaves in round-robin, that is about half. Before this patch the attach
failed with -EOPNOTSUPP.

Should the PCIe path handle XDP_REDIRECT, or keep refusing the attach
when the port is a bond slave?

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260928-lan966x-pci-fdma-v9-0-a17caf60f89a%40microchip.com
