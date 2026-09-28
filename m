Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43D4F3115BC;
	Mon, 28 Sep 2026 11:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790593347; cv=none; b=MmOc4zYKMm0DRXF9W5W5f5o2x2srkV1qW4BXzz1RrIKAijvCAXDTh35U56GJsXmVV4SkhcAdiBSGj9C3mQCgkUNEkOMm6B/5v7+nDZaZZW5JJy9af4AxgFzaYDAsQo/DP4eEU3XJKcBLTD6+dmA08VZE2gX1XarcGoTFRA7nEt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790593347; c=relaxed/simple;
	bh=vDM3Jsc4s2Pcenh8iO1OuupcO/tSGDTEI7SgHoe5a50=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=byLpeRrB+goYvi9UEfZAwRd9kGxJ7365B+ZnskgtUqSiRnasBcxR9w5JWCQmxM6jPYDS7x0Fj1ViLai3Q6StfuaMkJHgMGKeXlAMsjTa280RWJGyCMayz/IqX7nsCgalnYKBMmiRKS1pO+ymgnzIKzc/fqkPIkCns48ZNJjbX8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=RO5T5IGF; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="RO5T5IGF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1790593350; x=1822129350;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=vDM3Jsc4s2Pcenh8iO1OuupcO/tSGDTEI7SgHoe5a50=;
  b=RO5T5IGFE4/2AJCdyHAmU/qqBxvHRx3EAmAnHcUXw/qSSz00ogPOPZad
   dNniuk3ZBZYy4OC8Nx6vGQURsT9AhbXNWfTHwYHLGS7BpdJEtq2a+en4R
   rsPk0nWrOpnoqeEABv56r/I5kE3kF81d6e7Pc0uofVqkzrv8ClBtU4bRf
   dZqoXUa0zejejJQ3PlgjnufJ9kfvvKeI0Q3EWkilIxV4pCz5mfOZuwle4
   NhL8Kk1TMlWYlpBuXqtMD4Dy7vPYI9pSb/I1LqkqUTBhISNaFh2qHVs4u
   L+t7sUn7PR/bHmSZP+4BzM4lk70mO+HGV11L5ozh36BrZ7IGI1Dn0Xo0J
   g==;
X-CSE-ConnectionGUID: bFAJbgXdQXa3H8oQWgtrFg==
X-CSE-MsgGUID: 7FAlnek9R5ygFrSu1nO9/w==
X-IronPort-AV: E=Sophos;i="6.27,128,1787036400"; 
   d="scan'208";a="231363130"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2026 04:02:29 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.87.152) by
 chn-vm-ex3.mchp-main.com (10.10.87.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.49; Mon, 28 Sep 2026 04:02:23 -0700
Received: from DEN-DL-M70577 (10.10.85.11) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Mon, 28 Sep 2026 04:02:18 -0700
Date: Mon, 28 Sep 2026 13:02:18 +0200
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
Subject: Re: [PATCH net-next v8 13/15] net: lan966x: add PCIe FDMA XDP support
Message-ID: <20260928110218.ktlj26jtyakuywio@DEN-DL-M70577>
References: <20260924-lan966x-pci-fdma-v8-13-201c7b707d8b@microchip.com>
 <179036955220.2160803.7046320782670912992@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <179036955220.2160803.7046320782670912992@kernel.org>

> Thank you for your contribution! Sashiko AI review found 3 potential
> issue(s) to consider.
> 
> Critical: 1 � High: 0 � Medium: 2 � Low: 0
> 
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
> 
> - [Critical] Use-after-free and double free on the PCIe RX path when an
>   XDP program shrinks a frame.
> - [Medium] On the PCIe path the driver accepts XDP but cannot handle
>   XDP_REDIRECT, and the bond driver cannot tell.
> - [Medium] In lan966x_fdma_pci_napi_poll(), a poll that consumes all
>   FDMA_PCI_DCB_MAX (256) RX descriptors never re-arms any of them.
> 
> --
> 
> net: lan966x: add PCIe FDMA XDP support
> 
> This commit adds basic XDP support (XDP_PASS, XDP_DROP, XDP_TX) to the
> lan966x PCIe FDMA path. The IFH and FCS are stripped before the program
> runs, and the pointer and length from after XDP are passed on to skb
> construction or to a new memcpy-based XDP_TX routine.
> lan966x_xdp_setup() now accepts programs on PCIe and skips the page_pool
> reload there.
> 
> > diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_fdma_pci.c b/drivers/net/ethernet/microchip/lan966x/lan966x_fdma_pci.c
> > index 7185e65dda435..216e9cbcd1580 100644
> > --- a/drivers/net/ethernet/microchip/lan966x/lan966x_fdma_pci.c
> > +++ b/drivers/net/ethernet/microchip/lan966x/lan966x_fdma_pci.c
> 
> [ ... ]
> 
> > +static int lan966x_xdp_pci_run(struct lan966x_port *port, void *data,
> > +                            u32 data_len, void **xdp_data, u32 *xdp_len)
> > +{
> 
> [ ... ]
> 
> > +     act = bpf_prog_run_xdp(xdp_prog, &xdp);
> > +
> > +     *xdp_data = xdp.data;
> > +     *xdp_len = xdp.data_end - xdp.data;
> > +
> > +     switch (act) {
> > +     case XDP_PASS:
> > +             return FDMA_PASS;
> > +     case XDP_TX:
> > +             return lan966x_fdma_pci_xmit_xdpf(port, *xdp_data, *xdp_len) ?
> > +                    FDMA_DROP : FDMA_TX;
> > +     default:
> > +             bpf_warn_invalid_xdp_action(port->dev, xdp_prog, act);
> > +             fallthrough;
> 
> [Severity: Medium]
> What happens here when the PCIe port is a bond slave?
> 
> The PCIe ports use the same lan966x_port_netdev_ops as the platform
> ports, so both .ndo_bpf and .ndo_xdp_xmit are set. bond_xdp_set() looks
> only at those pointers and never reads xdp_features:
> 
> drivers/net/bonding/bond_main.c:bond_xdp_set() {
>     ...
>                 if (!slave_dev->netdev_ops->ndo_bpf ||
>                     !slave_dev->netdev_ops->ndo_xdp_xmit) {
>     ...
> }
> 
> This patch removes the -EOPNOTSUPP return for PCIe in
> lan966x_xdp_setup(), so a bond with a lan966x PCIe slave can now install
> its program on that slave. For bond slaves, bpf_prog_run_xdp() can then
> turn XDP_TX into XDP_REDIRECT:
> 
> net/core/filter.c:xdp_master_redirect() {
>     ...
>         if (slave && slave != xdp->rxq->dev) {
>                 ri->tgt_index = slave->ifindex;
>                 ri->map_id = INT_MAX;
>                 ri->map_type = BPF_MAP_TYPE_UNSPEC;
>                 return XDP_REDIRECT;
>     ...
> }
> 
> It can also return XDP_ABORTED when the master is down.
> 
> This switch has no XDP_REDIRECT case. Would those frames go to the
> default branch, log a "Driver unsupported" warning and be dropped?
> Nothing calls xdp_do_redirect(), so the redirect info set by
> xdp_master_redirect() would never be used.

Re-raise of dismissed issue in v7.

> 
> [ ... ]
> 
> >  static struct sk_buff *lan966x_fdma_pci_rx_get_frame(struct lan966x_rx *rx,
> > -                                                  u64 src_port)
> > +                                                  u64 src_port, void *data,
> > +                                                  u32 data_len)
> >  {
> 
> [ ... ]
> 
> > -     memcpy(skb->data,
> > -            fdma_dataptr_virt_addr_contiguous(fdma,
> > -                                              fdma->dcb_index,
> > -                                              fdma->db_index),
> > -                                              data_len);
> > +     memcpy(skb->data, data, data_len);
> >
> >       skb_put(skb, data_len);
> >
> >       skb->dev = lan966x->ports[src_port]->dev;
> > -     skb_pull(skb, IFH_LEN_BYTES);
> > -
> > -     skb_trim(skb, skb->len - ETH_FCS_LEN);
> >
> >       skb->protocol = eth_type_trans(skb, skb->dev);
> 
> [Severity: Critical]
> Can this lead to a use-after-free when an XDP program shrinks the frame?
> 
> data_len is now the length from after XDP, returned by
> lan966x_xdp_pci_run(). bpf_xdp_adjust_tail() and bpf_xdp_adjust_head()
> let it shrink to ETH_HLEN. Take a 14-byte frame with h_proto 0x8100
> that returns XDP_PASS. eth_type_trans() then leaves skb->len == 0 and
> skb->protocol == ETH_P_8021Q.
> 
> Now suppose src_port is in bridge_mask and IGMP/MLD redirect is enabled
> in ANA_CPU_FWD_CFG. lan966x_port_mc_set() enables it when multicast
> snooping is on, and snooping is on by default. In that case the code
> after this point reaches:
> 
> drivers/net/ethernet/microchip/lan966x/lan966x_main.c:lan966x_hw_offload() {
>     ...
>         if (eth_type_vlan(skb->protocol)) {
>                 skb = skb_vlan_untag(skb);
>                 if (unlikely(!skb))
>                         return false;
>         }
>     ...
> }
> 
> pskb_may_pull(skb, VLAN_HLEN + 2) fails in skb_vlan_untag(), so it
> frees the skb with kfree_skb() and returns NULL. lan966x_hw_offload()
> only returns a bool, so the caller still holds the freed pointer:
> 
>                 if (!lan966x_hw_offload(lan966x, src_port, skb))
>                         skb->offload_fwd_mark = 0;
>         }
> 
>         skb->dev->stats.rx_bytes += skb->len;
> 
> The freed skb is then returned to lan966x_fdma_pci_napi_poll(), which
> passes it to napi_gro_receive(). Would that be a use-after-free followed
> by a double free?
> 
> The problem in lan966x_hw_offload() is older. Before this patch it could
> not be reached, because skbs were built from the hardware length and the
> MAC drops runts. The frame contents can also come from the network, for
> example when a decap program uses adjust_head on a minimum-size outer
> frame.

A VLAN-tag frame arrives on a bridged port, with IGMP/MLD snooping enabled. That
same port has an XDP program that shrinks the frame to ETH_HLEN and returns
XDP_PASS. AFAICT, yes, that will result in UAF.

Agree that the problem is lan966x_hw_offload, which can potentially free the
skb, without letting the caller know. This function is pre-existing and used in
the platform path, but the UAF can never happen there, because the frame length
is guarded, and the post-program length is not used at all.

Since there is no live bug in the platform path today, this should, IMO, be a
preparatory commit in this series, that refactors the lan966x_hw_offload()
function to let the caller know the skb was freed.

> 
> [ ... ]
> 
> > @@ -312,8 +430,17 @@ static int lan966x_fdma_pci_napi_poll(struct napi_struct *napi, int weight)
> >                        */
> >                       fdma_dcb_advance(fdma);
> >                       continue;
> > +             case FDMA_TX:
> > +                     fdma_dcb_advance(fdma);
> > +                     continue;
> > +             case FDMA_DROP:
> > +                     fdma_dcb_advance(fdma);
> > +                     continue;
> >               }
> 
> [Severity: Medium]
> What happens if one poll consumes all 256 (FDMA_PCI_DCB_MAX) RX
> descriptors?
> 
> Every result path calls fdma_dcb_advance(), which wraps at n_dcbs. After
> 256 frames, dcb_index is back at the value saved in dcb_reload. The
> re-arm loop at the end of lan966x_fdma_pci_napi_poll() then runs zero
> times:
> 
>         while (dcb_reload != fdma->dcb_index) {
>                 old_dcb = dcb_reload;
>                 dcb_reload++;
>                 dcb_reload &= fdma->n_dcbs - 1;
> 
> So none of the consumed DCBs are re-armed, and they all keep
> FDMA_DCB_STATUS_DONE. With a budget above 256, fdma_has_frames() stays
> true and the same frames are processed again in the same call. With a
> budget of exactly 256, the next poll processes them again.
> 
> Would this deliver stale frames twice, run XDP on them again, and resend
> the XDP_TX frames?
> 
> Only the budget bounds the loop. __napi_busy_loop() passes the socket's
> SO_BUSY_POLL_BUDGET straight to napi_poll(), and that value can be up to
> U16_MAX with CAP_NET_ADMIN. The ring can fill completely, because the
> hardware fills the last DCB before it stops on the invalid nextptr.
> 
> This loop was added by the earlier "net: lan966x: add PCIe FDMA support"
> commit in this series. This patch extends it with the XDP_TX and
> XDP_DROP results, and it does not seem to be fixed later in the series.
> The platform lan966x_fdma_napi_poll() has the same pattern with 512
> DCBs.

Re-raise of dismissed issue in v7.

> 
> --
> Sashiko AI review � https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260924-lan966x-pci-fdma-v8-0-201c7b707d8b%40microchip.com

pw-bot: cr
