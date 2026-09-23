Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A468421242;
	Wed, 23 Sep 2026 20:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790194051; cv=none; b=Njv0xwqZuLv7Ca4P3MCLdPizcmSy9shIE+JYGTM/NpOvL/In5eNB6/EbtbwFG7OcYya3RwxdzWSs52cgKTZgOQlTNd2a/MzP/L1w4ARnU7L0tteKleMBemd25ITu+BTS1M7w5LYtI6C+cZcaqNcXBaQNGPpeLvPgzdPxMELjkqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790194051; c=relaxed/simple;
	bh=b+ZUpGa6QtP4h3zRO5IzpXHWnWQVoqpgBJly0o9sNe0=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LEOoTnsPK8aeA1kn5D6cLclzxHg17vWpS1p17FKoqAewJPPo3HW4L1JmDff7eD7kmJRkOOLGHCDGX35MlBriihipGCh3Pjjn0UzaVwXS99tIWL8YRcHpb8+KnbSH1uapVujrgxib2zdRjhg1xQD2Fhpa4dWy3NQTrKhOCNG629o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=rKuXitPo; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="rKuXitPo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1790194044; x=1821730044;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=b+ZUpGa6QtP4h3zRO5IzpXHWnWQVoqpgBJly0o9sNe0=;
  b=rKuXitPo+RBZQv7IItkuOogQNYrZd/5vobouxKYK/TerKjhexoSQCWDy
   N0gGf78/lN96BKLvvkeBsL75T9Z4p6RSWkyCq/upiyOo0esSbUfsdqdK9
   BXzk9no+qPE3bQp5NkC0oKv94M6mOpjEdHBq8ikftUxJ+UUilKPEzQ4Cu
   F0ip2CWfRXQjtpn+9j1IECnISUsDJUiq9MWNeNqOmATp8wW/V8GY5ANUM
   K9YS5WbZhChbaNq5jPfsr8RvrOPE0dTs+9xTB0HG+XI1UzOpWX5GqKm7T
   TPg8/a2B/evX5fEEQJay3u+l9Sum0M6CDMxP8DpNxpxNh5m9vQf0J4VOV
   g==;
X-CSE-ConnectionGUID: 01StXGozS7CH3JLmiR1lmA==
X-CSE-MsgGUID: RWHogFk+QJSGEEvDe4k/Pw==
X-IronPort-AV: E=Sophos;i="6.27,119,1787036400"; 
   d="scan'208";a="74201924"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 Sep 2026 13:07:17 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Wed, 23 Sep 2026 13:07:16 -0700
Received: from DEN-DL-M70577.microsemi.net (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Wed, 23 Sep 2026 13:07:12 -0700
Date: Wed, 23 Sep 2026 22:07:12 +0200
From: Daniel Machon <daniel.machon@microchip.com>
To: Simon Horman <horms@kernel.org>
CC: <netdev-bot+sashiko@kernel.org>, <andrew+netdev@lunn.ch>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <horatiu.vultur@microchip.com>,
	<steen.hegelund@microchip.com>, <UNGLinuxDriver@microchip.com>,
	<ast@kernel.org>, <daniel@iogearbox.net>, <hawk@kernel.org>,
	<john.fastabend@gmail.com>, <sdf@fomichev.me>, <herve.codina@bootlin.com>,
	<arnd@arndb.de>, <gregkh@linuxfoundation.org>, <mohsin.bashr@gmail.com>,
	<richardcochran@gmail.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH net-next v7 11/14] net: lan966x: add PCIe FDMA MTU change
 support
Message-ID: <20260923200712.jirfdepdpv5vm45m@DEN-DL-M70577.microsemi.net>
References: <20260918-lan966x-pci-fdma-v7-11-0ecc179c8a2c@microchip.com>
 <179008205354.2160803.17637640817184992984@kernel.org>
 <20260923094622.gmxyw46ligz4rsyd@DEN-DL-M70577.microsemi.net>
 <20260923193929.GW13925@horms.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260923193929.GW13925@horms.kernel.org>

> On Wed, Sep 23, 2026 at 11:46:22AM +0200, Daniel Machon wrote:
> > > Thank you for your contribution! Sashiko AI review found 4 potential
> > > issue(s) to consider.
> > >
> > > Critical: 0 · High: 2 (2) · Medium: 1 (1) · Low: 1
> > >
> > > If you believe none of the issues are legitimate, please reply to each
> > > issue of Medium severity or higher and explain why the AI is wrong.
> > > If any of them are legitimate and you plan to respin, please let patchwork
> > > know by including "pw-bot: cr" as a separate line at the end of your reply
> > > (one such reply per series is enough).
> > >
> > > - [High] MTU change during or after PCIe FDMA teardown runs the full
> > >   reload on freed/quiesced state: unbounded napi_disable() while holding…
> > > - [High] The new resize readiness check publishes lan966x->rx.lan966x
> > >   before the PCI FDMA rings exist, so an MTU change can race with ring…
> > > - [Medium] The new PCIe resize path retires DMA rings and tears down
> > >   their ATU outbound window without ever confirming the hardware is…
> > > - [Low] FDMA_PCI_DB_SIZE_MAX / FDMA_PCI_MAX_MTU perform unsigned
> > >   arithmetic with no underflow guard and no BUILD_BUG_ON, even though…
> > >
> > > Pre-existing issues:
> > > - [High] The hazard the new PCIe reload path documents and avoids is
> > >   still live in the sibling platform reload path, which this series…
> > > - [High] The two implementers of lan966x_fdma_ops::fdma_resize now
> > >   disagree about the 'rings not built yet' precondition, and the…
> > > - [Medium] Window in which DEV_MAC_MAXLEN_CFG exceeds the DCB buffer
> > >   size, combined with a missing SOF/EOF check in…
> > >
> > > --
> > >
> > > net: lan966x: add PCIe FDMA MTU change support
> > >
> > > This adds MTU change support to the PCIe FDMA path by reallocating the
> > > contiguous ATU-mapped RX and TX rings at the new size and falling back to
> > > the old buffers on failure.  It also caps the PCIe DCB ring at 256 entries
> > > and advertises a derived dev->max_mtu (FDMA_PCI_MAX_MTU) when the FDMA is
> > > in use.
> > >
> > > A few questions below about the new reload path and the new size macros.
> > >
> > > > diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_fdma_pci.c b/drivers/net/ethernet/microchip/lan966x/lan966x_fdma_pci.c
> > > > index 5d6902459f20..940425beec2f 100644
> > > > --- a/drivers/net/ethernet/microchip/lan966x/lan966x_fdma_pci.c
> > > > +++ b/drivers/net/ethernet/microchip/lan966x/lan966x_fdma_pci.c
> > > > @@ -358,7 +358,7 @@ static int lan966x_fdma_pci_init(struct lan966x *lan966x)
> > > >       lan966x->rx.lan966x = lan966x;
> > > >       lan966x->rx.max_mtu = lan966x_fdma_get_max_frame(lan966x);
> > > >       rx_fdma->channel_id = FDMA_XTR_CHANNEL;
> > > > -     rx_fdma->n_dcbs = FDMA_DCB_MAX;
> > > > +     rx_fdma->n_dcbs = FDMA_PCI_DCB_MAX;
> > > >       rx_fdma->n_dbs = FDMA_RX_DCB_MAX_DBS;
> > > >       rx_fdma->priv = lan966x;
> > > >       rx_fdma->db_size = FDMA_PCI_DB_SIZE(lan966x->rx.max_mtu);
> > >
> > > [Severity: High]
> > > Can an MTU change race with ring construction here?  lan966x_fdma_pci_init()
> > > sets rx.lan966x before it fills in channel_id/n_dcbs/n_dbs/db_size/size and
> > > before the two sleeping allocations in lan966x_fdma_pci_rx_alloc() and
> > > lan966x_fdma_pci_tx_alloc().
> > >
> > > The netdevs are already live at that point: lan966x_probe() runs the whole
> > > port loop, including lan966x_probe_port()->register_netdev() and
> > > lan966x_port_init()->lan966x_fdma_netdev_init()->netif_napi_add()+
> > > napi_enable(), and only calls ops->fdma_init() afterwards, without holding
> > > RTNL.
> > >
> > > So an rtnl-held ndo_change_mtu in that window sees rx.lan966x != NULL, passes
> > > the new guard in lan966x_fdma_pci_resize(), finds a max_mtu that differs from
> > > the partially initialised rx.max_mtu, and enters __lan966x_fdma_pci_reload().
> > > Both contexts then write the same lan966x->rx.fdma / lan966x->tx.fdma:
> > >
> > >   lan966x_fdma_pci_reload()
> > >       lan966x_fdma_rx_disable(&lan966x->rx)   /* channel_id still 0 */
> > >       lan966x->rx.fdma.atu_region = NULL;     /* under probe's feet */
> > >       lan966x_fdma_pci_rx_alloc(&lan966x->rx) /* second ring */
> > >
> > > Does this leak probe's ring plus its ATU region (only
> > > FDMA_PCI_ATU_REGION_MAX == 6 exist), or trip WARN_ON(fdma->atu_region) /
> > > -ENOSPC in fdma_pci_atu_region_map()?  And on the failure branch,
> > > lan966x_fdma_pci_reset_mem() dereferences tx->fdma.atu_region->base_addr,
> > > which is NULL in a snapshot taken before probe allocated it.
> >
> > Yes, same issue as adressed in #4. Theres a race because netdevs are registered
> > before initialization (in this case FDMA) has happened. The proper fix is a
> > reordering of the probe initialization.
> 
> Hi Daniel,
> 
> I'm wondering if you could expand on this a little. I'm unsure what #4
> refers to. And I'm unclear if you are planing the reordering as part
> of this patchset.

Hi Simon,

Yes, sorry for being vague here.

#4 refers to patch 4, where I explained that the issue reported there was really
due to the existing probe initialization order and netdev registration order.
Sashiko seems to report multiple race issues that can happen since the netdevs
are registered before the HW is fully initialized. This is real, and something
that needs to be fixed, just not in this series, IMHO.

For Sparx5 and lan969x, I fixed this not long ago, and made sure that netdevs
were registered last in probe, as they should be. Now, lan966x should get the
same treatment, as a separate fix series for net. :-)

Thanks for the review!

> 
> >
> > >
> > > [ ... ]
> > >
> > > > @@ -391,9 +391,156 @@ static int lan966x_fdma_pci_init(struct lan966x *lan966x)
> > > >       return 0;
> > > >  }
> > > >
> > > > +/* Reset existing rx and tx buffers. */
> > > > +static void lan966x_fdma_pci_reset_mem(struct lan966x *lan966x)
> > > > +{
> > > > +     struct lan966x_rx *rx = &lan966x->rx;
> > > > +     struct lan966x_tx *tx = &lan966x->tx;
> > > > +
> > > > +     memset(rx->fdma.dcbs, 0, rx->fdma.size);
> > > > +     memset(tx->fdma.dcbs, 0, tx->fdma.size);
> > > > +
> > > > +     fdma_dcbs_init(&rx->fdma,
> > > > +                    FDMA_DCB_INFO_DATAL(rx->fdma.db_size - XDP_PACKET_HEADROOM),
> > > > +                    FDMA_DCB_STATUS_INTR);
> > > > +
> > > > +     fdma_dcbs_init(&tx->fdma,
> > > > +                    FDMA_DCB_INFO_DATAL(tx->fdma.db_size),
> > > > +                    FDMA_DCB_STATUS_DONE);
> > > > +
> > > > +     lan966x_fdma_llp_configure(lan966x,
> > > > +                                tx->fdma.atu_region->base_addr,
> > > > +                                tx->fdma.channel_id);
> > > > +     lan966x_fdma_llp_configure(lan966x,
> > > > +                                rx->fdma.atu_region->base_addr,
> > > > +                                rx->fdma.channel_id);
> > > > +}
> > > > +
> > >
> > > [ ... ]
> > >
> > > > +static int lan966x_fdma_pci_reload(struct lan966x *lan966x, int new_mtu)
> > > > +{
> > > > +     struct fdma tx_fdma_old = lan966x->tx.fdma;
> > > > +     struct fdma rx_fdma_old = lan966x->rx.fdma;
> > > > +     u32 old_mtu = lan966x->rx.max_mtu;
> > > > +     int err;
> > > > +
> > > > +     napi_disable(&lan966x->napi);
> > > > +     lan966x_fdma_tx_disable_netdev(lan966x);
> > > > +     lan966x_fdma_rx_disable(&lan966x->rx);
> > > > +     lan966x_fdma_tx_disable(&lan966x->tx);
> > >
> > > [Severity: High]
> > > What happens if an MTU change lands after the PCIe FDMA has already been torn
> > > down?  lan966x_fdma_pci_deinit() disables NAPI and frees both coherent rings,
> > > but it leaves lan966x->rx.lan966x set, lan966x->fdma true and fdma->dcbs
> > > dangling.  It also runs before the netdevs are unregistered and without RTNL:
> > >
> > >   lan966x_remove()
> > >       lan966x->ops->fdma_deinit(lan966x);
> > >       lan966x_cleanup_ports(lan966x);   /* unregister_netdev() here */
> > >
> > > The new guard in lan966x_fdma_pci_resize() only rejects "rings not built
> > > yet", so an ndo_change_mtu in that window passes it and reaches this
> > > function.  Three things then follow in order:
> > >
> > > napi_disable(&lan966x->napi) on an already-disabled NAPI.  Does
> > > napi_disable_locked() spin forever in
> > >
> > >         while (val & (NAPIF_STATE_SCHED | NAPIF_STATE_NPSVC))
> > >                 usleep_range(20, 200);
> > >
> > > since nothing clears those bits until napi_enable()?  That task holds RTNL,
> > > so unregister_netdev() in lan966x_remove() can never complete.
> > >
> > > If that is somehow passed, the success path below calls
> > > fdma_free_coherent_and_unmap() on the stale rx_fdma_old/tx_fdma_old
> > > snapshots, so dma_free_coherent(dev, fdma->size, fdma->dcbs, fdma->dma) runs
> > > a second time on the multi-MB blocks deinit already released.
> > >
> > > And the restore: path calls lan966x_fdma_pci_reset_mem(), which memsets up to
> > > rx->fdma.size bytes into freed DMA memory and then dereferences
> > > tx->fdma.atu_region->base_addr, which fdma_free_coherent_and_unmap() already
> > > set to NULL.
> > >
> > > Would a "rings are live" state check (or clearing rx.lan966x and dcbs in
> > > deinit, or unregistering the netdevs before fdma_deinit) close this?
> >
> > lan966x_remove() is not touched by this series (apart from calling
> > ops->fdma_deinit), so I'd say pre-existing. But I believe this issue will also
> > disappear, when we refactor probe init as described above.
> 
> ...
