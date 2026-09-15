Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A170732B137;
	Tue, 15 Sep 2026 08:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789462493; cv=none; b=CahxOF2gOtCdWcdORpkLRHgL1EddQ+liohPl0hk91oT0SkxuY+iHB1N8t3f5IZKS5guSWg1Zy9K5OCRnvyiGEwRo+TVWOZKK74+DgvN9405imZ77M+duZE7ZF6P8Ys1Uyt7FUErsfl3lLmXFRDNc9PW55PxfasJ7fUlrE0Jx8Hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789462493; c=relaxed/simple;
	bh=g/XQZFRhvArqwyhYQQsYV1oxzReIaJfAkZh939ydge0=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sEsKnPdyPGAYTNshOkUkTDU4PipudXr+9hBMQ6ZOmKTVnRP2PoiTiRVOM8J0e2eS56p8r2+rKlEAHjAU0xjqhpWKsGv6vpOcJ/emJdt2eSmaKE3rcuR2mn2cD5fRNgDk8JKHJGTux8zK4YmhhkF2nM1WNOkkhz9wPhM+4h9ux4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=ozfiu/qA; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="ozfiu/qA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1789462492; x=1820998492;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=g/XQZFRhvArqwyhYQQsYV1oxzReIaJfAkZh939ydge0=;
  b=ozfiu/qA9i+bUT2LT1IbFprxUsdEcL/AKUXj3vv/DJ5y5lQAQ+ZNLiUB
   VzLk4nh3V/fbLJ/5VPN+zH7e+vGIdj4VAOd4zQVCwIwj76MVbuZFPKMB0
   4VLWiGUu7ddQW4uNRSXU5UGMWc4DOvXQ7YqLBJfZdC1z0Qt6MmwkllRvJ
   /+qwU8V/ChNNuPvfn1S1zAdoCN/8Yg33tYBOBSWe5lwCcn2ED78JiDzJn
   oU/IZF8sU1erwt3Xk/YGaHZmqpLOT3kEtaGaZKlwKef+JNve/00JUPX/7
   ych/VfXWc5kVtgQGDJnD9G1SoKyUkUM1Sj0JF6wc8mbadJzzDdLtRROqq
   g==;
X-CSE-ConnectionGUID: BntAm97SSBGPRL8iNTiP5w==
X-CSE-MsgGUID: 3Byspm3MRBS9EZyigKLLFA==
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="63612037"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2026 01:54:51 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.87.71) by
 chn-vm-ex2.mchp-main.com (10.10.87.31) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.45; Tue, 15 Sep 2026 01:54:49 -0700
Received: from DEN-DL-M70577.microsemi.net (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Tue, 15 Sep 2026 01:54:46 -0700
Date: Tue, 15 Sep 2026 10:54:45 +0200
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
Subject: Re: [PATCH net-next v6 10/14] net: lan966x: add PCIe FDMA support
Message-ID: <20260915085445.sajcj75jexgkkrvj@DEN-DL-M70577.microsemi.net>
References: <20260909-lan966x-pci-fdma-v6-10-6f48dab9d671@microchip.com>
 <178904554750.219967.2010862453597890441@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <178904554750.219967.2010862453597890441@kernel.org>

> Thank you for your contribution! Sashiko AI review found 4 potential
> issue(s) to consider:
> 
> Critical: 0 · High: 0 (1) · Medium: 1 (1) · Low: 3
> 
> - [Medium] DISCARDED — fixed later in the series.
> - [Low] DISCARDED — fixed later in the series.
> - [Low] DISCARDED — fixed later in the series.
> - [Low] DISCARDED — fixed later in the series.
> 
> Pre-existing issues:
> - [High] Use-after-free in the new PCIe receive path:
>   `lan966x_fdma_pci_rx_get_frame()`…
> - [Medium] DISCARDED — pre-existing shared-library ordering weakness.
> 
> --
> 
> net: lan966x: add PCIe FDMA support
> 
> Adds a second FDMA backend for lan966x used when the switch is reached over
> PCIe, using contiguous ATU-mapped DMA buffers and memcpy-based frame
> transfer instead of per-page mappings. XDP and PTP are not advertised or
> allowed on this path.
> 
> > diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_fdma_pci.c b/drivers/net/ethernet/microchip/lan966x/lan966x_fdma_pci.c
> > new file mode 100644
> > index 000000000000..f1f3c789d3a6
> > --- /dev/null
> > +++ b/drivers/net/ethernet/microchip/lan966x/lan966x_fdma_pci.c
> > @@ -0,0 +1,404 @@
> 
> [ ... ]
> 
> > +/* Return true if blockl is a valid RX frame size. */
> > +static bool lan966x_fdma_pci_rx_size_fits(struct fdma *fdma, u32 blockl)
> > +{
> > +     return blockl >= IFH_LEN_BYTES + ETH_HLEN + ETH_FCS_LEN &&
> > +            blockl <= fdma->db_size - XDP_PACKET_HEADROOM;
> > +}
> 
> [ ... ]
> 
> > +     skb->protocol = eth_type_trans(skb, skb->dev);
> > +
> > +     if (lan966x->bridge_mask & BIT(src_port)) {
> > +             skb->offload_fwd_mark = 1;
> > +
> > +             skb_reset_network_header(skb);
> > +             if (!lan966x_hw_offload(lan966x, src_port, skb))
> > +                     skb->offload_fwd_mark = 0;
> > +     }
> > +
> > +     skb->dev->stats.rx_bytes += skb->len;
> > +     skb->dev->stats.rx_packets++;
> > +
> > +     return skb;
> > +}
> 
> [Severity: High]
> This isn't a bug introduced by this patch - lan966x_fdma_rx_get_frame() in
> lan966x_fdma.c has the same caller pattern - but can lan966x_fdma_pci_rx_get_frame()
> touch skb after lan966x_hw_offload() has already freed it?

Yes, but pre-existing. I think this deserves a proper fix through net and
updates for all callers.

> 
> lan966x_hw_offload() replaces the buffer and reports only a boolean:
> 
> drivers/net/ethernet/microchip/lan966x/lan966x_main.c:lan966x_hw_offload() {
>         ...
>         if (eth_type_vlan(skb->protocol)) {
>                 skb = skb_vlan_untag(skb);
>                 if (unlikely(!skb))
>                         return false;
>         }
>         ...
> }
> 
> and skb_vlan_untag() frees the caller's skb on failure:
> 
> net/core/skbuff.c:skb_vlan_untag() {
>         ...
>         if (unlikely(!pskb_may_pull(skb, VLAN_HLEN + sizeof(unsigned short))))
>                 goto err_free;
>         ...
> err_free:
>         kfree_skb(skb);
>         return NULL;
> }
> 
> So on the false return the caller's pointer is dangling, and
> lan966x_fdma_pci_rx_get_frame() then does:
> 
>         skb->offload_fwd_mark = 0;
>         skb->dev->stats.rx_bytes += skb->len;
>         skb->dev->stats.rx_packets++;
>         return skb;
> 
> with the returned skb going to napi_gro_receive() in
> lan966x_fdma_pci_napi_poll().
> 
> Is the new lower bound in lan966x_fdma_pci_rx_size_fits() wide enough to let
> this happen? IFH_LEN_BYTES + ETH_HLEN + ETH_FCS_LEN is 46, so a BLOCKL of
> 46..51 is accepted, and after skb_pull(IFH_LEN_BYTES),
> skb_trim(skb->len - ETH_FCS_LEN) and eth_type_trans() there are only 0..5
> bytes left. For a frame with h_proto 0x8100 on a bridged port that has IGMP
> or MLD redirection enabled, the pskb_may_pull(VLAN_HLEN + 2) inside
> skb_vlan_untag() then fails and the buffer is freed.
> 
> Would it make sense to have lan966x_hw_offload() take a struct sk_buff **,
> or to have the caller stop using skb once it returns false?
> 
> >  static int lan966x_fdma_pci_xmit(struct sk_buff *skb, __be32 *ifh,
> 
> [ ... ]
> 
> --
> Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260909-lan966x-pci-fdma-v6-0-6f48dab9d671%40microchip.com
