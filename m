Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8C2746EC6E;
	Tue, 15 Sep 2026 10:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789467815; cv=none; b=OG0aJyS/20UvCJL8djucJaHM6XTzXTWSTUZ/UH6b0TnkusLCEEtjMwZIrVx6sVrdEm6oxvv8Oqvp3PnbPp7j80qcax2zzdFKx5lUgAQ1AiZGH7dCzqIQpNYyv0CTyWLvp6uTytxOUXyWLGEZ32PSfeJjSKhpEIIB4L+DEyqLai8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789467815; c=relaxed/simple;
	bh=JfImeWlYPb6UguGyY5w2XgH2wKkAkpEILz0Teog64b0=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OovFQiFDAZdU+Xfzbmfv1LIN4VlFYSYuQ4V50WiwZsEYGgOoGkXYrBMxmALyIjK9Q7Nib82bRm3caNQXLJ9vTuJdxkC35gw2r2tGUPVpmgoCwdjd5mP3omlnFTr6mtZpj42CXmAfyOyieGd/dUEXUd1ST/ksT6cp1wnxO9vg7RM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=GDoqJUOU; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="GDoqJUOU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1789467813; x=1821003813;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=JfImeWlYPb6UguGyY5w2XgH2wKkAkpEILz0Teog64b0=;
  b=GDoqJUOUHmtC4eNwwvNrDhOwScE5zUFpRkH6mfREmwR+D1mxJjpSE9Xk
   WsxkwL0WM5L0r/WfYE0GSRm4vSxLZd2FuQiS/1Mejqhv83141aq93zEyG
   XFTjglCgvO73oo2/gj9xFykSL0ufNOzJwfOHV+6R3rAltlcHSRFbuh4bH
   aD0GH51zE+Gmb/YFNLL84iNlJF2lonJCvkkw3kqnyBtYyh21dk9X7jfh/
   95lrOat2wJ+mwzF0zvEoH2CQZClsC5qi4fn6ef/HWiff6qNMzLMaz3xO7
   10NCq/e+q7X056TkOZwrvZ5XyRhana0Fv3JvPw3x7U5cSKJk1c+iOKE04
   g==;
X-CSE-ConnectionGUID: 9WTmWqleSx6F5QXJDCSgfg==
X-CSE-MsgGUID: gwhz8rzfTASyaXT8+QuNoQ==
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="62696225"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 Sep 2026 03:23:32 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Tue, 15 Sep 2026 03:23:31 -0700
Received: from DEN-DL-M70577.microsemi.net (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Tue, 15 Sep 2026 03:23:28 -0700
Date: Tue, 15 Sep 2026 12:23:27 +0200
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
Subject: Re: [PATCH net-next v6 11/14] net: lan966x: add PCIe FDMA MTU change
 support
Message-ID: <20260915102327.y2yxkhmspt6ofiwb@DEN-DL-M70577.microsemi.net>
References: <20260909-lan966x-pci-fdma-v6-11-6f48dab9d671@microchip.com>
 <178904554934.219967.15514762105046273538@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <178904554934.219967.15514762105046273538@kernel.org>

> Thank you for your contribution! Sashiko AI review found 4 potential
> issue(s) to consider:
> 
> Critical: 0 · High: 2 · Medium: 1 · Low: 1
> 
> - [High] NULL pointer dereference in the new lan966x_fdma_pci_reset_mem()
>   restore path.
> - [High] Unbalanced/unguarded napi_disable()/napi_enable() in the new MTU
>   reload path.
> - [Medium] Netdev MTU contract mismatch on the PCIe FDMA path.
> - [Low] Inverted restart ordering in lan966x_fdma_pci_reload(): both the
>   success path (lines 458-460) and the restore path (lines 476-478) call…
> 
> --
> 
> net: lan966x: add PCIe FDMA MTU change support
> 
> This adds MTU change support to the PCIe FDMA path by reallocating the
> contiguous ATU-mapped RX and TX buffers, falling back to resetting and
> reusing the existing buffers if the reallocation fails. It also caps the
> PCIe DCB ring at 256 entries so the contiguous allocation stays below
> MAX_PAGE_ORDER at jumbo MTU.
> 
> A few questions about the new reload and resize paths below.
> 
> > diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_fdma_pci.c b/drivers/net/ethernet/microchip/lan966x/lan966x_fdma_pci.c
> > index f1f3c789d3a6..6cabbb8b47f2 100644
> > --- a/drivers/net/ethernet/microchip/lan966x/lan966x_fdma_pci.c
> > +++ b/drivers/net/ethernet/microchip/lan966x/lan966x_fdma_pci.c
> > @@ -1,8 +1,15 @@
> >  // SPDX-License-Identifier: GPL-2.0+
> >
> > +#include <linux/mmzone.h>
> > +
> >  #include "fdma_api.h"
> >  #include "lan966x_main.h"
> >
> > +/* Ring must fit in one MAX_PAGE_ORDER DMA block; 512 DCBs overflows
> > + * at jumbo MTU.
> > + */
> > +#define FDMA_PCI_DCB_MAX     256
> > +
> 
> [ ... ]
> 
> > @@ -374,9 +381,164 @@ static int lan966x_fdma_pci_init(struct lan966x *lan966x)
> >       return 0;
> >  }
> >
> > +/* Reset existing rx and tx buffers. */
> > +static void lan966x_fdma_pci_reset_mem(struct lan966x *lan966x)
> > +{
> > +     struct lan966x_rx *rx = &lan966x->rx;
> > +     struct lan966x_tx *tx = &lan966x->tx;
> > +
> > +     memset(rx->fdma.dcbs, 0, rx->fdma.size);
> > +     memset(tx->fdma.dcbs, 0, tx->fdma.size);
> > +
> > +     fdma_dcbs_init(&rx->fdma,
> > +                    FDMA_DCB_INFO_DATAL(rx->fdma.db_size - XDP_PACKET_HEADROOM),
> > +                    FDMA_DCB_STATUS_INTR);
> > +
> > +     fdma_dcbs_init(&tx->fdma,
> > +                    FDMA_DCB_INFO_DATAL(tx->fdma.db_size),
> > +                    FDMA_DCB_STATUS_DONE);
> > +
> > +     lan966x_fdma_llp_configure(lan966x,
> > +                                tx->fdma.atu_region->base_addr,
> > +                                tx->fdma.channel_id);
> 
> [Severity: High]
> Can tx->fdma.atu_region be NULL here?
> 
> lan966x_fdma_pci_reset_mem() is only reached from the restore label of
> lan966x_fdma_pci_reload(), and that label is taken when the ring
> allocation failed.  Probe registers the netdevs from
> lan966x_probe_port() -> register_netdev() inside the ports loop, while
> lan966x->fdma is already true, and ops->fdma_init() (which sets
> n_dcbs/db_size/size and maps the ATU regions) only runs after that loop.
> 
> An MTU change in that window passes the !lan966x->fdma guard in
> lan966x_port_change_mtu() and reaches lan966x_fdma_pci_resize() with a
> zeroed fdma:
> 
>   rx.max_mtu == 0, so the "max_mtu == lan966x->rx.max_mtu" early return
>   does not fire
> 
>   n_dcbs == 0, so fdma_get_size_contiguous() returns ALIGN(0, PAGE_SIZE)
>   == 0 and both -ERANGE guards pass
> 
> lan966x_fdma_pci_reload() then recomputes size, which stays 0, and:
> 
>   lan966x_fdma_pci_rx_alloc()
>     fdma_alloc_coherent_and_map()
>       fdma_pci_atu_region_map()
>         if (size <= 0)
>                 return ERR_PTR(-EINVAL);
> 
> so control reaches restore, memcpy's the still-zeroed fdma structs back
> (atu_region == NULL, dcbs == NULL, size == 0), and calls reset_mem().
> memset(NULL, 0, 0) and fdma_dcbs_init() with n_dcbs == 0 are both
> no-ops, so nothing stops execution before tx->fdma.atu_region->base_addr
> is evaluated.  Would a NULL check on atu_region (or an early bail in
> resize() when the FDMA is not initialized yet) be appropriate here?

Real and the proper fix is to reorder initialization like we did on sparx5 in
b8909aad5b8d ("net: sparx5: move netdev and notifier block registration to
probe"), where the FDMA irq is requested and the FDMA initialized in
sparx5_frame_io_init() and netdev registration happens last.

For now, I can add a small check that makes sure that MTU change bails out in
case FDMA is not initialized yet.

> 
> > +     lan966x_fdma_llp_configure(lan966x,
> > +                                rx->fdma.atu_region->base_addr,
> > +                                rx->fdma.channel_id);
> > +}
> > +
> > +/* Wake all TX queues on every port (undoes lan966x_fdma_tx_disable_netdev). */
> > +static void lan966x_fdma_pci_wakeup_netdev(struct lan966x *lan966x)
> > +{
> > +     for (int i = 0; i < lan966x->num_phys_ports; ++i) {
> > +             struct lan966x_port *port = lan966x->ports[i];
> > +
> > +             if (port)
> > +                     netif_tx_wake_all_queues(port->dev);
> > +     }
> > +}
> > +
> > +static int lan966x_fdma_pci_reload(struct lan966x *lan966x, int new_mtu)
> > +{
> > +     struct fdma tx_fdma_old = lan966x->tx.fdma;
> > +     struct fdma rx_fdma_old = lan966x->rx.fdma;
> > +     u32 old_mtu = lan966x->rx.max_mtu;
> > +     int err;
> > +
> > +     napi_disable(&lan966x->napi);
> 
> [Severity: High]
> Should this napi_disable() be guarded the way the other users of
> lan966x->napi in this driver are?
> 
> lan966x_fdma_pci_deinit() does:
> 
>         if (lan966x->fdma_ndev)
>                 napi_disable(&lan966x->napi);
> 
> and lan966x_shutdown() has the same guard, with a comment noting that the
> reload paths disable this NAPI under rtnl.  Two states look problematic
> for the unguarded call:
> 
> The NAPI may not have been added yet.  netif_napi_add() only runs from
> lan966x_fdma_netdev_init(), called by lan966x_port_init(), which happens
> after lan966x_probe_port() already did register_netdev().  An MTU change
> in that window reaches napi_disable() with n->dev == NULL (lan966x is
> devm_kzalloc'ed), and napi_disable() does netdev_lock(n->dev).
> 

I believe the fix mentioned above also covers this.

> The NAPI may already be disabled.  lan966x_remove() calls
> ops->fdma_deinit() (which disables the NAPI and frees/unmaps both rings)
> before lan966x_cleanup_ports() unregisters the netdevs, and
> lan966x_shutdown() disables the NAPI without clearing fdma_ndev.  A
> concurrent MTU change then calls napi_disable() a second time and
> napi_disable_locked() spins:
> 
> net/core/dev.c:napi_disable_locked() {
>         ...
>         while (val & (NAPIF_STATE_SCHED | NAPIF_STATE_NPSVC)) {
>                 usleep_range(20, 200);
>                 val = READ_ONCE(n->state);
>         }
>         ...
> }
> 
> There is no timeout and no other wake condition, and ndo_change_mtu
> holds rtnl throughout, which also blocks the unregister_netdev() that
> would end the window.  The matching napi_enable() calls on both exit
> paths below have the same issue.
>

I'd say pre-existing. In order to fix this race, we need a proper net fix to
reorder the probe init/deinit paths.

> > +     lan966x_fdma_tx_disable_netdev(lan966x);
> > +     lan966x_fdma_rx_disable(&lan966x->rx);
> > +     lan966x_fdma_tx_disable(&lan966x->tx);
> > +
> > +     lan966x->rx.max_mtu = new_mtu;
> > +
> > +     /* Must be NULL'ed in order to realloc them. */
> > +     lan966x->rx.fdma.atu_region = NULL;
> > +     lan966x->tx.fdma.atu_region = NULL;
> > +
> > +     lan966x->tx.fdma.db_size = FDMA_PCI_DB_SIZE(lan966x->rx.max_mtu);
> > +     lan966x->tx.fdma.size = fdma_get_size_contiguous(&lan966x->tx.fdma);
> > +     lan966x->rx.fdma.db_size = FDMA_PCI_DB_SIZE(lan966x->rx.max_mtu);
> > +     lan966x->rx.fdma.size = fdma_get_size_contiguous(&lan966x->rx.fdma);
> > +
> > +     err = lan966x_fdma_pci_rx_alloc(&lan966x->rx);
> > +     if (err)
> > +             goto restore;
> > +
> > +     err = lan966x_fdma_pci_tx_alloc(&lan966x->tx);
> > +     if (err) {
> > +             fdma_free_coherent_and_unmap(lan966x->dma_dev,
> > +                                          &lan966x->rx.fdma);
> > +             goto restore;
> > +     }
> > +
> > +     /* Free and unmap old memory. */
> > +     fdma_free_coherent_and_unmap(lan966x->dma_dev, &rx_fdma_old);
> > +     fdma_free_coherent_and_unmap(lan966x->dma_dev, &tx_fdma_old);
> > +
> > +     napi_enable(&lan966x->napi);
> > +     lan966x_fdma_rx_start(&lan966x->rx);
> > +     lan966x_fdma_pci_wakeup_netdev(lan966x);
> 
> [Severity: Low]
> This isn't a bug as such, but the restart order here is the reverse of
> the pre-existing non-PCI path.  lan966x_fdma_reload() does:
> 
>         lan966x_fdma_rx_start(&lan966x->rx);
>         ...
>         lan966x_fdma_wakeup_netdev(lan966x);
>         napi_enable(&lan966x->napi);
> 
> Once napi_enable() clears NAPI_STATE_DISABLE, a pending FDMA DB
> interrupt reaching napi_schedule() from lan966x_fdma_irq_handler() can
> run lan966x_fdma_pci_napi_poll() on another CPU concurrently with
> lan966x_fdma_rx_start().  Both then do unsynchronized read-modify-write
> on FDMA_INTR_DB_ENA:
> 
> lan966x_fdma_pci_napi_poll():
>         if (counter < weight && napi_complete_done(napi, counter))
>                 lan_wr(0xff, lan966x, FDMA_INTR_DB_ENA);
> 
> lan966x_fdma_rx_start() instead does lan_rd() followed by lan_rmw() on
> the same register, and the poll can also issue FDMA_CH_RELOAD for a
> channel rx_start() has not activated yet.  Would matching the ordering
> used by lan966x_fdma_reload() be preferable?
>

The order is deliberate - it was swapped in v6 after an earlier round of this
review flagged the platform order as the live bug: waking the queues before NAPI
is live lets a TX clobber the extraction bit, with no poll scheduled to restore
it. v7 will carry a comment saying so.

> > +
> > +     return err;
> > +restore:
> > +
> > +     /* No new buffers are allocated at this point. Use the old buffers,
> > +      * but reset them before starting the FDMA again.
> > +      */
> > +
> > +     memcpy(&lan966x->tx.fdma, &tx_fdma_old, sizeof(struct fdma));
> > +     memcpy(&lan966x->rx.fdma, &rx_fdma_old, sizeof(struct fdma));
> > +
> > +     lan966x->rx.max_mtu = old_mtu;
> > +
> > +     lan966x_fdma_pci_reset_mem(lan966x);
> > +
> > +     napi_enable(&lan966x->napi);
> > +     lan966x_fdma_rx_start(&lan966x->rx);
> > +     lan966x_fdma_pci_wakeup_netdev(lan966x);
> > +
> > +     return err;
> > +}
> > +
> 
> [ ... ]
> 
> >  static int lan966x_fdma_pci_resize(struct lan966x *lan966x)
> >  {
> > -     return -EOPNOTSUPP;
> > +     struct fdma rx_fdma;
> > +     int max_mtu;
> > +
> > +     max_mtu = lan966x_fdma_get_max_frame(lan966x);
> > +     if (max_mtu == lan966x->rx.max_mtu)
> > +             return 0;
> > +
> > +     /* rx and tx have n_dbs == 1, so both rings need the same contiguous
> > +      * dma_alloc_coherent() block, which can't exceed MAX_PAGE_ORDER. The
> > +      * allocation is padded to the ATU region granularity, so test the
> > +      * padded size.
> > +      */
> > +     rx_fdma = lan966x->rx.fdma;
> > +     rx_fdma.db_size = FDMA_PCI_DB_SIZE(max_mtu);
> > +     if (ALIGN(fdma_get_size_contiguous(&rx_fdma),
> > +               FDMA_PCI_ATU_REGION_ALIGN) > (PAGE_SIZE << MAX_PAGE_ORDER))
> > +             return -ERANGE;
> 
> [Severity: Medium]
> Does the MTU range the netdev advertises still match what this path can
> actually do?
> 
> lan966x_probe_port() sets dev->max_mtu = ETH_MAX_MTU for the PCIe
> instantiation too, but with n_dcbs == FDMA_PCI_DCB_MAX (256),
> n_dbs == FDMA_RX_DCB_MAX_DBS (1) and db_size == ALIGN(max_frame, 128),
> the padded contiguous allocation crosses PAGE_SIZE << MAX_PAGE_ORDER at
> roughly 15.7 KiB of MTU on a 4 KiB-page build, so larger requests get a
> bare -ERANGE that lan966x_port_change_mtu() passes straight to
> userspace, and the cut-off moves with PAGE_SIZE and MAX_PAGE_ORDER.

The dev->max_mtu = ETH_MAX_MTU is intentional. Max MTU is rejected at runtime
and scales with PAGE_SIZE and MAX_PAGE_ORDER, depending on kernel configuration.

> 
> There is a second effect for MTUs in [65518, 65535], which the
> advertised max_mtu still permits.  lan966x_port_change_mtu() programs
> the register before calling the resize callback:
> 
>         lan_wr(DEV_MAC_MAXLEN_CFG_MAX_LEN_SET(LAN966X_HW_MTU(new_mtu)),
>                lan966x, DEV_MAC_MAXLEN_CFG(port->chip_port));
> 
> DEV_MAC_MAXLEN_CFG_MAX_LEN is GENMASK(15, 0) and LAN966X_HW_MTU(mtu) is
> mtu + 18, so FIELD_PREP() masks the runtime value, e.g. mtu 65535
> programs MAX_LEN = 65553 & 0xffff = 17.  lan966x_fdma_pci_resize() then
> derives max_mtu from that already-truncated register via
> lan966x_fdma_get_max_frame() -> lan966x_fdma_get_max_mtu() ->
> lan_rd(DEV_MAC_MAXLEN_CFG), so it either returns 0 (multi-port case,
> where the max over ports is unchanged) or reloads with a tiny db_size,
> and the MTU change is reported as successful while the MAC is configured
> for a 17-byte frame.

True and pre-existing in the platform path. If I decide to cap at dev->max_mtu,
which requires a PCI special case (lan966x_is_pci()), I might as well fix this
one by ETH_MAX_MTU - (ETH_HLEN + ETH_FCS_LEN).

> 
> Before this patch the PCIe callback returned -EOPNOTSUPP for every
> resize, so lan966x_port_change_mtu() always rolled the register back;
> this patch is what makes the path reachable.  Would capping dev->max_mtu
> for the PCIe path (to both the ring limit and the 16-bit MAC field) be
> the better fix, so the resize-time rejection becomes unreachable?
> 



> > +
> > +     /* db_size is also handed to the FDMA in the 16-bit DCB DATAL field,
> > +      * where a larger value would be silently truncated.
> > +      */
> > +     if (rx_fdma.db_size > GENMASK(15, 0))
> > +             return -ERANGE;
> > +
> > +     return __lan966x_fdma_pci_reload(lan966x, max_mtu);
> >  }
> 
> [ ... ]
> 
> --
> Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260909-lan966x-pci-fdma-v6-0-6f48dab9d671%40microchip.com
