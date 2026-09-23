Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 471063D904C;
	Wed, 23 Sep 2026 08:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790153147; cv=none; b=S8iBS9i4wC0awA+lFYiPhM/dAzoiZVl/vy3ck8nnM4tH1ZvxENdOc0GOQMcLNOfVa80HjLkUUVUC7Uhwnv05RG9FVkVd8f2jV6AbtDQwMoO3V9Q1bd3HAK4BJqx7+OTLEGVxUvrRlGcgxleym3ckXfqw7E59igg5mIgzR+SUB0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790153147; c=relaxed/simple;
	bh=gZoJn8dtnYcXAOAiXm8aGKWW7joS9eEI91xrTyLKbVY=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SF8dzy9V2+KaXcNUpH5Z5saDd+0h3NU5GtKhkacgaFpI7wINS9y3SDDPFFiX4EfHOdHh+KUAtgREImcZtT3hxHzMyYuWMg2imoOPKc3l0GAjxVAdErPvmw5HDW34TvClmwWI8W+v3vL1/bkRP71zU72B2sTJH+7FrnbuEgmlHw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=npYumDqT; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="npYumDqT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1790153145; x=1821689145;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=gZoJn8dtnYcXAOAiXm8aGKWW7joS9eEI91xrTyLKbVY=;
  b=npYumDqTXLPOCjs2nkkLluz1h8hGAx8icGwL81axfAaOhHXkcykf5zcN
   2q6FeTtzOYW+GoTut0yQzX3f6SOuUcLG2RugYmol7hkK4c4VYde0eCuGv
   22Yful6SfmsHlGGW41JHpuUbh8eYdnlSSeiGvH8rnJKisUI2CR0V/QNRh
   gELiDDMUgBqdGYYZ8Z0z2inlAZfs7pNfmt2sIokoWDsK3TWypSepxzxJi
   n+Nc3eue/RkGJ09iKTP4qUoIrDZQjvWJyAU9EP6Ax74iKC6UTVG7HlErK
   KqB2S6fo0Lvv+gIosscFIkDCQ7onBWVHzBSWSW07OW4OOfWmwrM2n8dwH
   A==;
X-CSE-ConnectionGUID: iKr+KxGLRXWYaWM+I386fA==
X-CSE-MsgGUID: ciBZ7Q/PQQSoOwQJ46eehA==
X-IronPort-AV: E=Sophos;i="6.27,118,1787036400"; 
   d="scan'208";a="231148803"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 Sep 2026 01:45:43 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Wed, 23 Sep 2026 01:45:43 -0700
Received: from DEN-DL-M70577 (10.10.85.11) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Wed, 23 Sep 2026 01:45:39 -0700
Date: Wed, 23 Sep 2026 10:45:38 +0200
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
Subject: Re: [PATCH net-next v7 10/14] net: lan966x: add PCIe FDMA support
Message-ID: <20260923084538.wgkw2nt5ergoxcot@DEN-DL-M70577>
References: <20260918-lan966x-pci-fdma-v7-10-0ecc179c8a2c@microchip.com>
 <179008205148.2160803.12818321368571406375@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <179008205148.2160803.12818321368571406375@kernel.org>

> Thank you for your contribution! Sashiko AI review found 6 potential
> issue(s) to consider.
> 
> Critical: 0 · High: 0 · Medium: 4 (1) · Low: 2
> 
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
> 
> - [Medium] DISCARDED (resolved later in the series): claim that the new {
>   TARGET_PCIE_DBI, 0x400000, 0 } iomap entry points 3 MiB past the end…
> - [Medium] DISCARDED (resolved later in the series): claim that
>   lan966x_fdma_pci_resize() returning -EOPNOTSUPP unconditionally makes…
> - [Medium] The PCIe FDMA path places hardware descriptors in host memory
>   and lets the LAN966x endpoint fetch them over PCIe, but every…
> - [Medium] net: lan966x: rx_bytes statistic undercounts received frame
>   size
> - [Low] DISCARDED (resolved later in the series): claim that the PCIe
>   FDMA backend is dead code because drivers/misc/lan966x_pci.dtso…
> - [Low] In lan966x_fdma_pci_napi_poll() the FDMA_ERROR arm carries the
>   comment "No rx_dropped increment here because src_port is invalid.",…
> 
> Pre-existing issues:
> - [Medium] DISCARDED: claim that __fdma_dcb_add() links a new DCB into
>   the live hardware chain (writing fdma->last_dcb->nextptr) before…
> 
> --
> 
> net: lan966x: add PCIe FDMA support
> 
> This adds a second FDMA backend for lan966x that is selected when the
> switch is enumerated over PCIe. It uses contiguous coherent DMA buffers
> mapped through the endpoint ATU and memcpy-based frame transfer, and it
> opts out of XDP and PTP on that path.
> 
> A couple of questions about the new path below.
> 
> > diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_fdma_pci.c b/drivers/net/ethernet/microchip/lan966x/lan966x_fdma_pci.c
> > new file mode 100644
> > index 000000000000..5d6902459f20
> > --- /dev/null
> > +++ b/drivers/net/ethernet/microchip/lan966x/lan966x_fdma_pci.c
> > @@ -0,0 +1,421 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> > +
> > +#include "fdma_api.h"
> > +#include "lan966x_main.h"
> > +
> > +static int lan966x_fdma_pci_dataptr_cb(struct fdma *fdma, int dcb, int db,
> > +                                    u64 *dataptr)
> > +{
> > +     u64 addr;
> > +
> > +     addr = fdma_dataptr_dma_addr_contiguous(fdma, dcb, db);
> > +
> > +     *dataptr = fdma_pci_atu_translate_addr(fdma->atu_region, addr);
> > +
> > +     return 0;
> > +}
> > +
> > +static int lan966x_fdma_pci_nextptr_cb(struct fdma *fdma, int dcb, u64 *nextptr)
> > +{
> > +     u64 addr;
> > +
> > +     fdma_nextptr_cb(fdma, dcb, &addr);
> > +
> > +     *nextptr = fdma_pci_atu_translate_addr(fdma->atu_region, addr);
> > +
> > +     return 0;
> > +}
> 
> [Severity: Medium]
> Is this path expected to work on a big-endian host?
> 
> Until now the descriptor producer and the FDMA engine were both on the
> little-endian SoC, so the native-endian descriptor layout in
> drivers/net/ethernet/microchip/fdma/fdma_api.h was fine:
> 
>   struct fdma_db {
>         u64 dataptr;
>         u64 status;
>   };
> 
>   struct fdma_dcb {
>         u64 nextptr;
>         u64 info;
>         struct fdma_db db[FDMA_DB_MAX];
>   };
> 
> With PCIe FDMA the descriptors live in host memory and are fetched by the
> endpoint, so the host and the engine can disagree on byte order. The
> translated addresses written here, and the status/info words written by
> __fdma_db_add()/__fdma_dcb_add(), all go out in host byte order, and the
> HW-written DONE/BLOCKL fields are read back the same way in
> lan966x_fdma_pci_get_next_dcb() and lan966x_fdma_pci_rx_check_frame().
> 
> CONFIG_MCHP_LAN966X_PCI in drivers/misc/Kconfig only has
> 
>   depends on PCI
>   depends on OF_OVERLAY
> 
> so a big-endian host (e.g. powerpc) can select it. On such a host, would
> the engine see byte-swapped nextptr/dataptr and length fields, i.e. would
> RX/TX not work at all? Should the descriptor fields become explicit
> little-endian types with accessors at the hardware boundary, or should the
> Kconfig entry gain a little-endian dependency?

Hmm. Never tested on PowerPC, not this driver nor the DT overlay mechanism it
relies on for PCI deployment, which has only been exercised on ARM and x86 so
far (AFAICT) [1].

[1] https://lore.kernel.org/all/20240430183301.46568e35@bootlin.com/

> 
> [ ... ]
> 
> > +static int lan966x_fdma_pci_rx_check_frame(struct lan966x_rx *rx, u64 *src_port)
> > +{
> [ ... ]
> > +     lan966x_ifh_get_src_port(virt_addr, src_port);
> > +
> > +     if (*src_port >= lan966x->num_phys_ports)
> > +             return FDMA_ERROR;
> > +
> > +     port = lan966x->ports[*src_port];
> > +     if (!port)
> > +             return FDMA_ERROR;
> > +
> > +     db = fdma_db_next_get(fdma);
> > +
> > +     /* BLOCKL is a 16-bit HW-populated field; reject obviously-bad
> > +      * values before they feed memcpy/XDP sizes.
> > +      */
> > +     blockl = FDMA_DCB_STATUS_BLOCKL(db->status);
> > +     if (!lan966x_fdma_pci_rx_size_fits(fdma, blockl))
> > +             return FDMA_ERROR;
> > +
> > +     return FDMA_PASS;
> > +}
> 
> [ ... ]
> 
> > +             switch (lan966x_fdma_pci_rx_check_frame(rx, &src_port)) {
> > +             case FDMA_PASS:
> > +                     break;
> > +             case FDMA_ERROR:
> > +                     /* No rx_dropped increment here because src_port is
> > +                      * invalid.
> > +                      */
> > +                     fdma_dcb_advance(fdma);
> > +                     continue;
> > +             }
> 
> [Severity: Low]
> Is this comment accurate for all FDMA_ERROR cases?
> 
> lan966x_fdma_pci_rx_check_frame() also returns FDMA_ERROR for a BLOCKL
> value rejected by lan966x_fdma_pci_rx_size_fits(), and that check runs
> after *src_port and lan966x->ports[*src_port] have already been validated.
> 
> So for a frame whose BLOCKL is below IFH_LEN_BYTES + ETH_HLEN +
> ETH_FCS_LEN or above db_size - XDP_PACKET_HEADROOM, src_port is known
> good, yet the frame is dropped without incrementing rx_dropped on
> lan966x->ports[src_port]->dev.
> 
> Would it make sense to distinguish the two failures so the size-rejected
> frames get counted, and adjust the comment accordingly?
> 
> [ ... ]
> 
> > @@ -0,0 +1,421 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> > +
> > +#include "fdma_api.h"
> > +#include "lan966x_main.h"
> > +
> > +static int lan966x_fdma_pci_dataptr_cb(struct fdma *fdma, int dcb, int db,
> > +                                    u64 *dataptr)
> > +{
> > +     u64 addr;
> > +
> > +     addr = fdma_dataptr_dma_addr_contiguous(fdma, dcb, db);
> > +
> > +     *dataptr = fdma_pci_atu_translate_addr(fdma->atu_region, addr);
> > +
> > +     return 0;
> > +}
> > +
> > +static int lan966x_fdma_pci_nextptr_cb(struct fdma *fdma, int dcb, u64 *nextptr)
> > +{
> > +     u64 addr;
> > +
> > +     fdma_nextptr_cb(fdma, dcb, &addr);
> > +
> > +     *nextptr = fdma_pci_atu_translate_addr(fdma->atu_region, addr);
> > +
> > +     return 0;
> > +}
> > +
> > +/* Stop the TX queues on every port, so nothing feeds the injection channel
> > + * while it is torn down or resized.
> > + */
> > +static void lan966x_fdma_tx_disable_netdev(struct lan966x *lan966x)
> > +{
> > +     struct lan966x_port *port;
> > +     int i;
> > +
> > +     for (i = 0; i < lan966x->num_phys_ports; ++i) {
> > +             port = lan966x->ports[i];
> > +             if (!port)
> > +                     continue;
> > +
> > +             netif_tx_disable(port->dev);
> > +     }
> > +}
> > +
> > +static int lan966x_fdma_pci_rx_alloc(struct lan966x_rx *rx)
> > +{
> > +     struct lan966x *lan966x = rx->lan966x;
> > +     struct fdma *fdma = &rx->fdma;
> > +     int err;
> > +
> > +     err = fdma_alloc_coherent_and_map(lan966x->dma_dev, fdma,
> > +                                       &lan966x->atu);
> > +     if (err)
> > +             return err;
> > +
> > +     err = fdma_dcbs_init(fdma,
> > +                          FDMA_DCB_INFO_DATAL(fdma->db_size - XDP_PACKET_HEADROOM),
> > +                          FDMA_DCB_STATUS_INTR);
> > +     if (err) {
> > +             fdma_free_coherent_and_unmap(lan966x->dma_dev, fdma);
> > +             return err;
> > +     }
> > +
> > +     lan966x_fdma_llp_configure(lan966x,
> > +                                fdma->atu_region->base_addr,
> > +                                fdma->channel_id);
> > +
> > +     return 0;
> > +}
> > +
> > +static int lan966x_fdma_pci_tx_alloc(struct lan966x_tx *tx)
> > +{
> > +     struct lan966x *lan966x = tx->lan966x;
> > +     struct fdma *fdma = &tx->fdma;
> > +     int err;
> > +
> > +     err = fdma_alloc_coherent_and_map(lan966x->dma_dev, fdma,
> > +                                       &lan966x->atu);
> > +     if (err)
> > +             return err;
> > +
> > +     err = fdma_dcbs_init(fdma,
> > +                          FDMA_DCB_INFO_DATAL(fdma->db_size),
> > +                          FDMA_DCB_STATUS_DONE);
> > +     if (err) {
> > +             fdma_free_coherent_and_unmap(lan966x->dma_dev, fdma);
> > +             return err;
> > +     }
> > +
> > +     lan966x_fdma_llp_configure(lan966x,
> > +                                fdma->atu_region->base_addr,
> > +                                fdma->channel_id);
> > +
> > +     return 0;
> > +}
> > +
> > +static int lan966x_fdma_pci_get_next_dcb(struct fdma *fdma)
> > +{
> > +     struct fdma_db *db;
> > +
> > +     for (int i = 0; i < fdma->n_dcbs; i++) {
> > +             db = fdma_db_get(fdma, i, 0);
> > +
> > +             if (!fdma_db_is_done(db))
> > +                     continue;
> > +             if (fdma_is_last(fdma, &fdma->dcbs[i]))
> > +                     continue;
> > +
> > +             return i;
> > +     }
> > +
> > +     return -ENOSPC;
> > +}
> > +
> > +/* TX slot layout (sizes in bytes):
> > + *
> > + *  +---------------------+-----+---------+-----+
> > + *  | XDP_PACKET_HEADROOM | IFH | payload | FCS |
> > + *  |         256         |  28 |   len   |   4 |
> > + *  +---------------------+-----+---------+-----+
> > + *  |<---------------- db_size ----------------->|
> > + *
> > + * Return true if the frame plus required overhead fits.
> > + */
> > +static bool lan966x_fdma_pci_tx_size_fits(struct fdma *fdma, u32 len)
> > +{
> > +     return XDP_PACKET_HEADROOM + IFH_LEN_BYTES + len + ETH_FCS_LEN <=
> > +            fdma->db_size;
> > +}
> > +
> > +/* Return true if blockl is a valid RX frame size. */
> > +static bool lan966x_fdma_pci_rx_size_fits(struct fdma *fdma, u32 blockl)
> > +{
> > +     return blockl >= IFH_LEN_BYTES + ETH_HLEN + ETH_FCS_LEN &&
> > +            blockl <= fdma->db_size - XDP_PACKET_HEADROOM;
> > +}
> > +
> > +static int lan966x_fdma_pci_rx_check_frame(struct lan966x_rx *rx, u64 *src_port)
> > +{
> > +     struct lan966x *lan966x = rx->lan966x;
> > +     struct fdma *fdma = &rx->fdma;
> > +     struct lan966x_port *port;
> > +     struct fdma_db *db;
> > +     void *virt_addr;
> > +     u32 blockl;
> > +
> > +     /* virt_addr points to the IFH. */
> > +     virt_addr = fdma_dataptr_virt_addr_contiguous(fdma,
> > +                                                   fdma->dcb_index,
> > +                                                   fdma->db_index);
> > +
> > +     lan966x_ifh_get_src_port(virt_addr, src_port);
> > +
> > +     if (*src_port >= lan966x->num_phys_ports)
> > +             return FDMA_ERROR;
> > +
> > +     port = lan966x->ports[*src_port];
> > +     if (!port)
> > +             return FDMA_ERROR;
> > +
> > +     db = fdma_db_next_get(fdma);
> > +
> > +     /* BLOCKL is a 16-bit HW-populated field; reject obviously-bad
> > +      * values before they feed memcpy/XDP sizes.
> > +      */
> > +     blockl = FDMA_DCB_STATUS_BLOCKL(db->status);
> > +     if (!lan966x_fdma_pci_rx_size_fits(fdma, blockl))
> > +             return FDMA_ERROR;
> > +
> > +     return FDMA_PASS;
> > +}
> > +
> > +static struct sk_buff *lan966x_fdma_pci_rx_get_frame(struct lan966x_rx *rx,
> > +                                                  u64 src_port)
> > +{
> > +     struct lan966x *lan966x = rx->lan966x;
> > +     struct fdma *fdma = &rx->fdma;
> > +     struct sk_buff *skb;
> > +     struct fdma_db *db;
> > +     u32 data_len;
> > +
> > +     /* Get the received frame and create an SKB for it. */
> > +     db = fdma_db_next_get(fdma);
> > +     data_len = FDMA_DCB_STATUS_BLOCKL(db->status);
> > +
> > +     skb = napi_alloc_skb(&lan966x->napi, data_len);
> > +     if (unlikely(!skb))
> > +             return NULL;
> > +
> > +     memcpy(skb->data,
> > +            fdma_dataptr_virt_addr_contiguous(fdma,
> > +                                              fdma->dcb_index,
> > +                                              fdma->db_index),
> > +                                              data_len);
> > +
> > +     skb_put(skb, data_len);
> > +
> > +     skb->dev = lan966x->ports[src_port]->dev;
> > +     skb_pull(skb, IFH_LEN_BYTES);
> > +
> > +     skb_trim(skb, skb->len - ETH_FCS_LEN);
> > +
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
> > +
> > +static int lan966x_fdma_pci_xmit(struct sk_buff *skb, __be32 *ifh,
> > +                              struct net_device *dev)
> > +{
> > +     struct lan966x_port *port = netdev_priv(dev);
> > +     struct lan966x *lan966x = port->lan966x;
> > +     struct lan966x_tx *tx = &lan966x->tx;
> > +     struct fdma *fdma = &tx->fdma;
> > +     int next_to_use;
> > +     void *virt_addr;
> > +
> > +     next_to_use = lan966x_fdma_pci_get_next_dcb(fdma);
> > +
> > +     if (next_to_use < 0) {
> > +             netif_stop_queue(dev);
> > +             return NETDEV_TX_BUSY;
> > +     }
> > +
> > +     if (skb_put_padto(skb, ETH_ZLEN)) {
> > +             dev->stats.tx_dropped++;
> > +             return NETDEV_TX_OK;
> > +     }
> > +
> > +     if (!lan966x_fdma_pci_tx_size_fits(fdma, skb->len)) {
> > +             dev_kfree_skb_any(skb);
> > +             dev->stats.tx_dropped++;
> > +             return NETDEV_TX_OK;
> > +     }
> > +
> > +     skb_tx_timestamp(skb);
> > +
> > +     /* virt_addr points to the IFH. */
> > +     virt_addr = fdma_dataptr_virt_addr_contiguous(fdma, next_to_use, 0);
> > +     memcpy(virt_addr, ifh, IFH_LEN_BYTES);
> > +     memcpy(virt_addr + IFH_LEN_BYTES, skb->data, skb->len);
> > +
> > +     /* Order frame write before DCB status write below. */
> > +     dma_wmb();
> > +
> > +     fdma_dcb_add(fdma,
> > +                  next_to_use,
> > +                  0,
> > +                  FDMA_DCB_STATUS_INTR |
> > +                  FDMA_DCB_STATUS_SOF |
> > +                  FDMA_DCB_STATUS_EOF |
> > +                  FDMA_DCB_STATUS_BLOCKO(0) |
> > +                  FDMA_DCB_STATUS_BLOCKL(IFH_LEN_BYTES + skb->len + ETH_FCS_LEN));
> > +
> > +     /* Start the transmission. */
> > +     lan966x_fdma_tx_start(tx);
> > +
> > +     dev->stats.tx_bytes += skb->len;
> > +     dev->stats.tx_packets++;
> > +
> > +     /* Safe to free: PTP is not supported on the PCIe path yet,
> > +      * so lan966x->ptp is always 0 here.
> > +      */
> > +     dev_consume_skb_any(skb);
> > +
> > +     return NETDEV_TX_OK;
> > +}
> > +
> > +static int lan966x_fdma_pci_napi_poll(struct napi_struct *napi, int weight)
> > +{
> > +     struct lan966x *lan966x = container_of(napi, struct lan966x, napi);
> > +     struct lan966x_rx *rx = &lan966x->rx;
> > +     struct fdma *fdma = &rx->fdma;
> > +     int dcb_reload, old_dcb;
> > +     struct sk_buff *skb;
> > +     int counter = 0;
> > +     u64 src_port;
> > +
> > +     /* Wake any stopped TX queues if a TX DCB is available. */
> > +     spin_lock(&lan966x->tx_lock);
> > +     if (lan966x_fdma_pci_get_next_dcb(&lan966x->tx.fdma) >= 0)
> > +             lan966x_fdma_wakeup_netdev(lan966x);
> > +     spin_unlock(&lan966x->tx_lock);
> > +
> > +     dcb_reload = fdma->dcb_index;
> > +
> > +     /* Get all received skbs. */
> > +     while (counter < weight) {
> > +             if (!fdma_has_frames(fdma))
> > +                     break;
> > +             /* Order DONE read before DCB/frame reads below. */
> > +             dma_rmb();
> > +             counter++;
> > +             switch (lan966x_fdma_pci_rx_check_frame(rx, &src_port)) {
> > +             case FDMA_PASS:
> > +                     break;
> > +             case FDMA_ERROR:
> > +                     /* No rx_dropped increment here because src_port is
> > +                      * invalid.
> > +                      */
> > +                     fdma_dcb_advance(fdma);
> > +                     continue;
> > +             }
> > +             skb = lan966x_fdma_pci_rx_get_frame(rx, src_port);
> > +             fdma_dcb_advance(fdma);
> > +             if (!skb) {
> > +                     lan966x->ports[src_port]->dev->stats.rx_dropped++;
> > +                     continue;
> > +             }
> > +
> > +             napi_gro_receive(&lan966x->napi, skb);
> > +     }
> > +     while (dcb_reload != fdma->dcb_index) {
> > +             old_dcb = dcb_reload;
> > +             dcb_reload++;
> > +             dcb_reload &= fdma->n_dcbs - 1;
> > +
> > +             fdma_dcb_add(fdma,
> > +                          old_dcb,
> > +                          FDMA_DCB_INFO_DATAL(fdma->db_size - XDP_PACKET_HEADROOM),
> > +                          FDMA_DCB_STATUS_INTR);
> > +
> > +             lan966x_fdma_rx_reload(rx);
> > +     }
> > +
> > +     if (counter < weight && napi_complete_done(napi, counter))
> > +             lan_wr(0xff, lan966x, FDMA_INTR_DB_ENA);
> > +
> > +     return counter;
> > +}
> > +
> > +static int lan966x_fdma_pci_init(struct lan966x *lan966x)
> > +{
> > +     struct fdma *rx_fdma = &lan966x->rx.fdma;
> > +     struct fdma *tx_fdma = &lan966x->tx.fdma;
> > +     int err;
> > +
> > +     if (!lan966x->fdma)
> > +             return 0;
> > +
> > +     lan_wr(FDMA_CTRL_NRESET_SET(0), lan966x, FDMA_CTRL);
> > +     lan_wr(FDMA_CTRL_NRESET_SET(1), lan966x, FDMA_CTRL);
> > +
> > +     fdma_pci_atu_init(&lan966x->atu, lan966x->regs[TARGET_PCIE_DBI]);
> > +
> > +     lan966x->rx.lan966x = lan966x;
> > +     lan966x->rx.max_mtu = lan966x_fdma_get_max_frame(lan966x);
> > +     rx_fdma->channel_id = FDMA_XTR_CHANNEL;
> > +     rx_fdma->n_dcbs = FDMA_DCB_MAX;
> > +     rx_fdma->n_dbs = FDMA_RX_DCB_MAX_DBS;
> > +     rx_fdma->priv = lan966x;
> > +     rx_fdma->db_size = FDMA_PCI_DB_SIZE(lan966x->rx.max_mtu);
> > +     rx_fdma->size = fdma_get_size_contiguous(rx_fdma);
> > +     rx_fdma->ops.nextptr_cb = &lan966x_fdma_pci_nextptr_cb;
> > +     rx_fdma->ops.dataptr_cb = &lan966x_fdma_pci_dataptr_cb;
> > +
> > +     lan966x->tx.lan966x = lan966x;
> > +     tx_fdma->channel_id = FDMA_INJ_CHANNEL;
> > +     tx_fdma->n_dcbs = FDMA_DCB_MAX;
> > +     tx_fdma->n_dbs = FDMA_TX_DCB_MAX_DBS;
> > +     tx_fdma->priv = lan966x;
> > +     tx_fdma->db_size = FDMA_PCI_DB_SIZE(lan966x->rx.max_mtu);
> > +     tx_fdma->size = fdma_get_size_contiguous(tx_fdma);
> > +     tx_fdma->ops.nextptr_cb = &lan966x_fdma_pci_nextptr_cb;
> > +     tx_fdma->ops.dataptr_cb = &lan966x_fdma_pci_dataptr_cb;
> > +
> > +     err = lan966x_fdma_pci_rx_alloc(&lan966x->rx);
> > +     if (err)
> > +             return err;
> > +
> > +     err = lan966x_fdma_pci_tx_alloc(&lan966x->tx);
> > +     if (err) {
> > +             fdma_free_coherent_and_unmap(lan966x->dma_dev, rx_fdma);
> > +             return err;
> > +     }
> > +
> > +     lan966x_fdma_rx_start(&lan966x->rx);
> > +
> > +     return 0;
> > +}
> > +
> > +static int lan966x_fdma_pci_resize(struct lan966x *lan966x)
> > +{
> > +     return -EOPNOTSUPP;
> > +}
> > +
> > +static void lan966x_fdma_pci_deinit(struct lan966x *lan966x)
> > +{
> > +     if (!lan966x->fdma)
> > +             return;
> > +
> > +     if (lan966x->fdma_ndev)
> > +             napi_disable(&lan966x->napi);
> > +
> > +     lan966x_fdma_tx_disable_netdev(lan966x);
> > +     lan966x_fdma_rx_disable(&lan966x->rx);
> > +     lan966x_fdma_tx_disable(&lan966x->tx);
> > +
> > +     fdma_free_coherent_and_unmap(lan966x->dma_dev, &lan966x->rx.fdma);
> > +     fdma_free_coherent_and_unmap(lan966x->dma_dev, &lan966x->tx.fdma);
> > +}
> > +
> > +const struct lan966x_fdma_ops lan966x_fdma_pci_ops = {
> > +     .fdma_init = &lan966x_fdma_pci_init,
> > +     .fdma_deinit = &lan966x_fdma_pci_deinit,
> > +     .fdma_xmit = &lan966x_fdma_pci_xmit,
> > +     .fdma_poll = &lan966x_fdma_pci_napi_poll,
> > +     .fdma_resize = &lan966x_fdma_pci_resize,
> > +};
> 
> [Severity: Medium]
> Is rx_bytes meant to count the frame as it arrived on the wire?
> 
> By the time this runs, skb->len has already been reduced twice: the
> skb_trim() above drops ETH_FCS_LEN, and eth_type_trans() pulls the
> MAC header out of the linear region, so skb->len is short by at least
> ETH_HLEN. If lan966x_hw_offload() ends up untagging a VLAN header,
> that is another four bytes gone. So every packet delivered through
> lan966x_fdma_pci_rx_get_frame() undercounts rx_bytes by 14 bytes or
> more, which is visible to userspace via ip -s link.
> 
> The frame length is available before any of that surgery happens --
> data_len from FDMA_DCB_STATUS_BLOCKL(db->status), or skb->len right
> after the skb_pull(skb, IFH_LEN_BYTES) -- so accounting could be done
> there instead.
> 
> I realise this mirrors what the existing register/page path in
> lan966x_fdma.c does, so if the intent is to keep the two backends
> byte-for-byte consistent, please say so; otherwise it would be good
> not to copy the miscount into the new file.

Not only lan966x, but sparx5 and lan969x does the exact same thing, increasing
rx_bytes after headers are pulled.  The undercount is real, but not visible to
userspace. Both implementations (platform and PCI) read hardware counters directly

> --
> Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260918-lan966x-pci-fdma-v7-0-0ecc179c8a2c%40microchip.com
