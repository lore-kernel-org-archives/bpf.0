Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 715A743B3E5;
	Thu, 27 Aug 2026 09:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787824753; cv=none; b=saCdKYkjDCodmg6OWZkniJj/sG7YBcHLig8nwJCfjOHZbr++muehI4TfFVPyFnq3eXyEyeykIgjEDrTgc0Y576IaE66wGIXa/R7DOfSQm0I7fk6aLOYk8zKJ/Ro4F9Uw8Hq7bD9oUmdBmlsTj1zBCHKjEWgheof/uZxV1iTjzsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787824753; c=relaxed/simple;
	bh=9zWHX1koS7Y08c8z6OqdIcI8jre+mu/ZH79BynCwR7I=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NLZIeLbXxukBb+fAoSjHin54Pg2huw7PtsJU9ySpieLi98MZE5nxX4VhKnD/lblCx3cVUw1vCqFUiKNoi5lty8Bnk1/81Z4wfIzBcCKa8Sn7y9RZY/vL/Mf43PThhea+WO/a0YXz48K/XP4PpENZH8XH4NUH8U2638nFRgoHWks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=rJVdl54x; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="rJVdl54x"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1787824749; x=1819360749;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=9zWHX1koS7Y08c8z6OqdIcI8jre+mu/ZH79BynCwR7I=;
  b=rJVdl54xWdwPmieXltYO74HZpuuMhkTad9vsCKiZ17eJgpe/hkTO12PZ
   iSl3DxQJ8skr15WeMwWfvKjDGMPPxX4olxvJ5ve9bSxAITfwnJNXnQp9p
   niB7e/njPB8NaOuSspZrEkqHFbU5cnGR79tu6T8f1ZCCXBvc1ftb2nDmn
   LxZQ6U5JyRC7o2CcxxvySCCapgRQa+jw23ppGZl1VLd5Dfv0YAeoV7a+W
   W72AeWh/XanVhzpjbqg4IpMqyy6cOLQbIxT81tTjGL1d0i9j7a8vkrSAe
   T3P/JDL88VJukgmMYlcIdEM8nZYWTsQj2uG93TDa+AwarUSsqiQLz+4x6
   g==;
X-CSE-ConnectionGUID: TKd9ukl7SMmUnG5Q+MYsKQ==
X-CSE-MsgGUID: Wh+SSoq1RgyeT1qOVKnEPA==
X-IronPort-AV: E=Sophos;i="6.25,246,1779174000"; 
   d="scan'208";a="294132463"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 Aug 2026 02:59:02 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Thu, 27 Aug 2026 02:59:01 -0700
Received: from DEN-DL-M70577.microsemi.net (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Thu, 27 Aug 2026 02:58:57 -0700
Date: Thu, 27 Aug 2026 11:58:57 +0200
From: Daniel Machon <daniel.machon@microchip.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
	<pabeni@redhat.com>, Horatiu Vultur <horatiu.vultur@microchip.com>, "Steen
 Hegelund" <steen.hegelund@microchip.com>, <UNGLinuxDriver@microchip.com>,
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend
	<john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, "Herve
 Codina" <herve.codina@bootlin.com>, Arnd Bergmann <arnd@arndb.de>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>, Mohsin Bashir
	<mohsin.bashr@gmail.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH net-next v5 09/13] net: lan966x: add PCIe FDMA support
Message-ID: <20260827095857.nt2zngzhoq777qou@DEN-DL-M70577.microsemi.net>
References: <20260520-lan966x-pci-fdma-v5-0-ca56197ae05b@microchip.com>
 <20260520-lan966x-pci-fdma-v5-9-ca56197ae05b@microchip.com>
 <20260522185637.1fe72213@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260522185637.1fe72213@kernel.org>

> On Wed, 20 May 2026 10:12:21 +0200 Daniel Machon wrote:
> > Add PCIe FDMA support for lan966x. The PCIe FDMA path uses contiguous
> > DMA buffers mapped through the endpoint's ATU, with memcpy-based frame
> > transfer instead of per-page DMA mappings.
> >
> > With PCIe FDMA, throughput increases from ~33 Mbps (register-based I/O)
> > to ~620 Mbps on an Intel x86 host with a lan966x PCIe card.
> 
> > diff --git a/drivers/net/ethernet/microchip/lan966x/Makefile b/drivers/net/ethernet/microchip/lan966x/Makefile
> > index 4cdbe263502c..ac0beceb2a0d 100644
> > --- a/drivers/net/ethernet/microchip/lan966x/Makefile
> > +++ b/drivers/net/ethernet/microchip/lan966x/Makefile
> > @@ -18,6 +18,10 @@ lan966x-switch-objs  := lan966x_main.o lan966x_phylink.o lan966x_port.o \
> >  lan966x-switch-$(CONFIG_LAN966X_DCB) += lan966x_dcb.o
> >  lan966x-switch-$(CONFIG_DEBUG_FS) += lan966x_vcap_debugfs.o
> >
> > +ifdef CONFIG_MCHP_LAN966X_PCI
> 
> ifeq ()
> 
> would be more common in a Makefile?

Switching to ifneq ($(CONFIG_MCHP_LAN966X_PCI),) in v6.

> 
> > +lan966x-switch-y += lan966x_fdma_pci.o
> > +endif
> > +
> 
> > diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_main.c b/drivers/net/ethernet/microchip/lan966x/lan966x_main.c
> > index cc3c7b6c65ae..7036b1d937d5 100644
> > --- a/drivers/net/ethernet/microchip/lan966x/lan966x_main.c
> > +++ b/drivers/net/ethernet/microchip/lan966x/lan966x_main.c
> > @@ -7,6 +7,7 @@
> >  #include <linux/ip.h>
> >  #include <linux/of.h>
> >  #include <linux/of_net.h>
> > +#include <linux/pci.h>
> >  #include <linux/phy/phy.h>
> >  #include <linux/platform_device.h>
> >  #include <linux/reset.h>
> > @@ -49,6 +50,9 @@ struct lan966x_main_io_resource {
> >  static const struct lan966x_main_io_resource lan966x_main_iomap[] =  {
> >       { TARGET_CPU,                   0xc0000, 0 }, /* 0xe00c0000 */
> >       { TARGET_FDMA,                  0xc0400, 0 }, /* 0xe00c0400 */
> > +#if IS_ENABLED(CONFIG_MCHP_LAN966X_PCI)
> 
> why config option being enabled changes the targets?
> Can someone with a non-PCI device enable that option too
> (sure it would be useless but given that/if they can guarding
> with an #if seems like a waste of LoC)
> 

Rationale was to only map in the PCIE_DBI target if actually needed. Sure, can
drop the conditional in v6.

> > +     { TARGET_PCIE_DBI,             0x400000, 0 }, /* 0xe0400000 */
> > +#endif
> >       { TARGET_ORG,                         0, 1 }, /* 0xe2000000 */
> >       { TARGET_GCB,                    0x4000, 1 }, /* 0xe2004000 */
> >       { TARGET_QS,                     0x8000, 1 }, /* 0xe2008000 */
> > @@ -1100,6 +1104,13 @@ static int lan966x_reset_switch(struct lan966x *lan966x)
> >
> >  static const struct lan966x_fdma_ops *lan966x_get_fdma_ops(struct device *dev)
> >  {
> > +#if IS_ENABLED(CONFIG_MCHP_LAN966X_PCI)
> > +     for (struct device *p = dev->parent; p; p = p->parent) {
> > +             if (dev_is_pci(p))
> 
> If the PCIe devices also use an intermediate platform device for
> probing, can't they explicitly have some flag / state to indicate
> they are PCIe? The device walk in such a constrained env seems
> like an overkill
> 

I think it could be possible to pass some state between lan966x_pci and the
switch driver, however that seems like a much more complex solution than this.
The parent bus node already implies the same — the switch device only ever sits
under a PCI-created bus in the PCIe case, so an explicit flag/state would just
restate what the topology already tells us. The walk itself is deliberate, v1
checked dev->parent->parent directly, and I opened it up to a walk so PCIe
detection keeps working if the overlay's DT topology gains or loses an
intermediate bus node. I'd like to keep as it.

> > +                     return &lan966x_fdma_pci_ops;
> > +     }
> > +#endif
> > +
> >       return &lan966x_fdma_ops;
> >  }
> >
> > diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_main.h b/drivers/net/ethernet/microchip/lan966x/lan966x_main.h
> > index 5f4dbeda17cd..e7fdd4447fb6 100644
> > --- a/drivers/net/ethernet/microchip/lan966x/lan966x_main.h
> > +++ b/drivers/net/ethernet/microchip/lan966x/lan966x_main.h
> > @@ -17,6 +17,9 @@
> >  #include <net/xdp.h>
> >
> >  #include <fdma_api.h>
> > +#if IS_ENABLED(CONFIG_MCHP_LAN966X_PCI)
> > +#include <fdma_pci.h>
> > +#endif
> 
> Conditional #includes make build testing harder, better to avoid them
> 

Ack.

> >  #include <vcap_api.h>
> >  #include <vcap_api_client.h>
> >
> > @@ -288,6 +291,10 @@ struct lan966x {
> >
> >       void __iomem *regs[NUM_TARGETS];
> >
> > +#if IS_ENABLED(CONFIG_MCHP_LAN966X_PCI)
> > +     struct fdma_pci_atu atu;
> > +#endif
> > +
> >       int shared_queue_sz;
> >
> >       u8 base_mac[ETH_ALEN];
> > @@ -586,6 +593,10 @@ void lan966x_fdma_wakeup_netdev(struct lan966x *lan966x);
> >  int lan966x_fdma_get_max_frame(struct lan966x *lan966x);
> >  int lan966x_qsys_sw_status(struct lan966x *lan966x);
> >
> > +#if IS_ENABLED(CONFIG_MCHP_LAN966X_PCI)
> > +extern const struct lan966x_fdma_ops lan966x_fdma_pci_ops;
> > +#endif
> 
> There should be no need to wrap extern in an #if

Ack.


/Daniel
