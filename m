Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DD8E486E67;
	Thu, 10 Sep 2026 13:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789045551; cv=none; b=HpokaodSW7E/Yxeq+tr++IJ8rPx6NihQ4SDh5itqx2fEKW/CuKNOhJjuV/9jGx+AdIXFV+hE669b1XLaqdCmhJQSr67qMBXIbQWeSp0s7OP+Q0bxbUHbFqKlbYahMx/kXCr5g/C2OhD3LIuCecs7Q53s7ZXvSAsBFMOxzS5/qrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789045551; c=relaxed/simple;
	bh=AIcPlROLZYJRT3LF6fszMq09HDa7DPGeq8eIhufMjrY=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=g31oiixnSGesrx2zG7XLaB/SrwThd4cHDNSY1Cv4lbN8szqXwc7lV3XbCYUUoSEZpvgWlfiWuV2aLc6AEst7un4ZwMzj61isg5WqMlwPMQqdr56OKlM6hyd1ZiQ+MDEGZ8GGWXjpSfZ99CWF0dlNOT3JKXvwZGeth/sKx4KahNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EvJpCLHX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EvJpCLHX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB6371F0089A;
	Thu, 10 Sep 2026 13:05:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789045549;
	bh=soVxyxS8LHzU6+KouZ11cXays4Dkr+9r+gqYpoz1J6g=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=EvJpCLHXxHMUajmuZKlp2lsHJX4zPVyAKKijkY4Ud3tslXtlKqWXaaXm9OcM/jxdG
	 spA3AqHElhScXhCb+81VulTtk6Ewe7cq1TJxWm5u2vESE/z3FFpfp7B6tMp2ris84r
	 NX475eu1CMpBHuVcsvL8bSZOAjbj0MxLT8ieicj1IinAuiy+8Q30AROwESaojhOE5V
	 Tvwn1KhCNw/ysHH9LGL+kJG5BStA9PZJdg+VpDn/K27MbjYclHiVEzzxpG8u4I7UAY
	 kQXxdbwUJvicgEGFvNWrdv7L593/Px+TVDgPVLCnKduHwh3lRA4w5yhrHX12XIYT17
	 Ve+eUC2IQ6hLw==
Subject: Re: [PATCH net-next v6 10/14] net: lan966x: add PCIe FDMA support
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
Date: Thu, 10 Sep 2026 13:05:47 +0000
Message-ID: <178904554750.219967.2010862453597890441@kernel.org>
In-Reply-To: <20260909-lan966x-pci-fdma-v6-10-6f48dab9d671@microchip.com>
References: <20260909-lan966x-pci-fdma-v6-10-6f48dab9d671@microchip.com>
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
issue(s) to consider:

Critical: 0 · High: 0 (1) · Medium: 1 (1) · Low: 3

- [Medium] DISCARDED — fixed later in the series.
- [Low] DISCARDED — fixed later in the series.
- [Low] DISCARDED — fixed later in the series.
- [Low] DISCARDED — fixed later in the series.

Pre-existing issues:
- [High] Use-after-free in the new PCIe receive path:
  `lan966x_fdma_pci_rx_get_frame()`…
- [Medium] DISCARDED — pre-existing shared-library ordering weakness.

--

net: lan966x: add PCIe FDMA support

Adds a second FDMA backend for lan966x used when the switch is reached over
PCIe, using contiguous ATU-mapped DMA buffers and memcpy-based frame
transfer instead of per-page mappings. XDP and PTP are not advertised or
allowed on this path.

> diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_fdma_pci.c b/drivers/net/ethernet/microchip/lan966x/lan966x_fdma_pci.c
> new file mode 100644
> index 000000000000..f1f3c789d3a6
> --- /dev/null
> +++ b/drivers/net/ethernet/microchip/lan966x/lan966x_fdma_pci.c
> @@ -0,0 +1,404 @@

[ ... ]

> +/* Return true if blockl is a valid RX frame size. */
> +static bool lan966x_fdma_pci_rx_size_fits(struct fdma *fdma, u32 blockl)
> +{
> +	return blockl >= IFH_LEN_BYTES + ETH_HLEN + ETH_FCS_LEN &&
> +	       blockl <= fdma->db_size - XDP_PACKET_HEADROOM;
> +}

[ ... ]

> +	skb->protocol = eth_type_trans(skb, skb->dev);
> +
> +	if (lan966x->bridge_mask & BIT(src_port)) {
> +		skb->offload_fwd_mark = 1;
> +
> +		skb_reset_network_header(skb);
> +		if (!lan966x_hw_offload(lan966x, src_port, skb))
> +			skb->offload_fwd_mark = 0;
> +	}
> +
> +	skb->dev->stats.rx_bytes += skb->len;
> +	skb->dev->stats.rx_packets++;
> +
> +	return skb;
> +}

[Severity: High]
This isn't a bug introduced by this patch - lan966x_fdma_rx_get_frame() in
lan966x_fdma.c has the same caller pattern - but can lan966x_fdma_pci_rx_get_frame()
touch skb after lan966x_hw_offload() has already freed it?

lan966x_hw_offload() replaces the buffer and reports only a boolean:

drivers/net/ethernet/microchip/lan966x/lan966x_main.c:lan966x_hw_offload() {
	...
	if (eth_type_vlan(skb->protocol)) {
		skb = skb_vlan_untag(skb);
		if (unlikely(!skb))
			return false;
	}
	...
}

and skb_vlan_untag() frees the caller's skb on failure:

net/core/skbuff.c:skb_vlan_untag() {
	...
	if (unlikely(!pskb_may_pull(skb, VLAN_HLEN + sizeof(unsigned short))))
		goto err_free;
	...
err_free:
	kfree_skb(skb);
	return NULL;
}

So on the false return the caller's pointer is dangling, and
lan966x_fdma_pci_rx_get_frame() then does:

	skb->offload_fwd_mark = 0;
	skb->dev->stats.rx_bytes += skb->len;
	skb->dev->stats.rx_packets++;
	return skb;

with the returned skb going to napi_gro_receive() in
lan966x_fdma_pci_napi_poll().

Is the new lower bound in lan966x_fdma_pci_rx_size_fits() wide enough to let
this happen? IFH_LEN_BYTES + ETH_HLEN + ETH_FCS_LEN is 46, so a BLOCKL of
46..51 is accepted, and after skb_pull(IFH_LEN_BYTES),
skb_trim(skb->len - ETH_FCS_LEN) and eth_type_trans() there are only 0..5
bytes left. For a frame with h_proto 0x8100 on a bridged port that has IGMP
or MLD redirection enabled, the pskb_may_pull(VLAN_HLEN + 2) inside
skb_vlan_untag() then fails and the buffer is freed.

Would it make sense to have lan966x_hw_offload() take a struct sk_buff **,
or to have the caller stop using skb once it returns false?

>  static int lan966x_fdma_pci_xmit(struct sk_buff *skb, __be32 *ifh,

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260909-lan966x-pci-fdma-v6-0-6f48dab9d671%40microchip.com
