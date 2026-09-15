Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3047D3F5BE6;
	Tue, 15 Sep 2026 10:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789469549; cv=none; b=qTZuL4lYmZ7WNVUg5e+OgStOuyJlq9syUGCPoVEmCpDPuCYmVHA4nbuDBw+ojXb3Fm0+kPdP4KwCG//Kxj+f1vDdwhEunjzp3x9WdP2+wVUfjPRddUmVfeh4Cml1uM2acYEYT+MrXOce6wF8yi0vaqMYnssFY0P53za8AbWjn0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789469549; c=relaxed/simple;
	bh=HtFG603PXEqzpj0QOJ8wws45R27BlfrhSLuLOWM0nJI=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kOrDCZWjuQuu4iUpmGFZZwQSzzDC/1f9ohcXiGis1CWRmsiKYbUG7NoH8zk8ZYwv24319dmLfLg1gp8SQH7zQDRvOk47JUNwk4NEGxozuXfLR5nEuvxoDTlOL+/zQAYws9XD4CrtBTfKkF4WL3Y0l6HYYeBWGtsa3j+bUpZA06k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=gwuYddms; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="gwuYddms"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1789469548; x=1821005548;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=HtFG603PXEqzpj0QOJ8wws45R27BlfrhSLuLOWM0nJI=;
  b=gwuYddms/CinuLSHvTQU3X2dLud2UDIHGwT6IhXWIe4UOxB7U0/N8RzS
   8lgthqFRcIiJcBunEWNQNdY0kqbXJhR5WeTEIVQOMt85WCpseifr1KfIp
   eK0G0ifaVt/T2cSz9cWx4ceGkVKcIAR31p28nccNxQ4fWzbObeG9qBiUx
   1n10v/zwDSPuZQ+BLLBBH/yVJUr1/ObuDqvjjC06BLNPm5mAgi6N1J19/
   fxrQbi14D1n/yZXb4qG5avG1n9Na+NePI458Md3iFWpcOFOXUHFeOItli
   ysksuJG0IlMG3WZibDchmoyRQMYRLY7BBj7lrx0wg5wHwlxjfhEdOSPOQ
   g==;
X-CSE-ConnectionGUID: txDYYXqPRfKs/UNfmy8rBw==
X-CSE-MsgGUID: 0HDZTiWpRQ+4dp5SFWUfYQ==
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="73639701"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2026 03:52:26 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.87.152) by
 chn-vm-ex1.mchp-main.com (10.10.87.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.45; Tue, 15 Sep 2026 03:52:26 -0700
Received: from DEN-DL-M70577.microsemi.net (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Tue, 15 Sep 2026 03:52:22 -0700
Date: Tue, 15 Sep 2026 12:52:21 +0200
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
Subject: Re: [PATCH net-next v6 14/14] misc: lan966x-pci: dts: add fdma
 interrupt to overlay
Message-ID: <20260915105221.dn7xpsizv4o7xhg4@DEN-DL-M70577.microsemi.net>
References: <20260909-lan966x-pci-fdma-v6-14-6f48dab9d671@microchip.com>
 <178904555475.219967.711870735307370384@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <178904555475.219967.711870735307370384@kernel.org>

> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider:
> 
> Critical: 0 � High: 0 � Medium: 1 � Low: 0
> 
> - [Medium] The FDMA interrupt is hooked up (and thereby unmasked in the
>   OIC) long before any FDMA state exists.
> 
> --
> 
> misc: lan966x-pci: dts: add fdma interrupt to overlay
> 
> This adds OIC interrupt 14 as the "fdma" named interrupt to the lan966x
> PCI device tree overlay, so FDMA-based injection/extraction can be used
> when the switch is reached over PCIe.
> 
> > diff --git a/drivers/misc/lan966x_pci.dtso b/drivers/misc/lan966x_pci.dtso
> > index 7bb726550caf..5bb12dbc0843 100644
> > --- a/drivers/misc/lan966x_pci.dtso
> > +++ b/drivers/misc/lan966x_pci.dtso
> > @@ -141,8 +141,9 @@ switch: switch@e0000000 {
> >
> >                                       interrupt-parent = <&oic>;
> >                                       interrupts = <12 IRQ_TYPE_LEVEL_HIGH>,
> > +                                                  <14 IRQ_TYPE_LEVEL_HIGH>,
> >                                                    <9 IRQ_TYPE_LEVEL_HIGH>;
> > -                                     interrupt-names = "xtr", "ana";
> > +                                     interrupt-names = "xtr", "fdma", "ana";
> 
> [Severity: Medium]
> With source 14 now named "fdma", platform_get_irq_byname(pdev, "fdma")
> starts succeeding on the PCIe path, and lan966x_probe() requests the
> handler right there:
> 
> drivers/net/ethernet/microchip/lan966x/lan966x_main.c:lan966x_probe() {
>         lan966x->fdma_irq = platform_get_irq_byname(pdev, "fdma");
>         if (lan966x->fdma_irq > 0) {
>                 err = devm_request_irq(&pdev->dev, lan966x->fdma_irq,
>                                        lan966x_fdma_irq_handler, 0,
>                                        "fdma irq", lan966x);
>                 ...
>                 lan966x->fdma = true;
>         }
> }
> 
> Is this ordering safe?  The OIC maps and unmasks source 14 at
> devm_request_irq() time, but at that point no FDMA state exists yet:
> 
> - netif_napi_add()/napi_enable() only run later, from
>   lan966x_port_init() -> lan966x_fdma_netdev_init() in the per-port
>   probe loop, so lan966x->napi is still the zeroed devm_kzalloc()
>   memory and napi.poll is NULL.
> 
> - the DCB rings, the LLP/ATU windows and the FDMA_CTRL NRESET pulse are
>   all done even later, from lan966x->ops->fdma_init() ->
>   lan966x_fdma_pci_init().
> 
> If the OIC delivers an FDMA interrupt in that window, the handler
> schedules NAPI unconditionally:
> 
> drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c:lan966x_fdma_irq_handler() {
>         db = lan_rd(lan966x, FDMA_INTR_DB);
>         err = lan_rd(lan966x, FDMA_INTR_ERR);
> 
>         if (db) {
>                 lan_wr(0, lan966x, FDMA_INTR_DB_ENA);
>                 lan_wr(db, lan966x, FDMA_INTR_DB);
> 
>                 napi_schedule(&lan966x->napi);
>         }
> }
> 
> Can this then oops in __napi_poll(), either calling n->poll() while it
> is still NULL, or running lan966x_fdma_pci_napi_poll() against
> rx->fdma.dcbs == NULL and n_dcbs == 0, where fdma_has_frames() ->
> fdma_db_get() dereferences the dcbs array?
> 
> How reachable is that window in practice?  The series itself describes
> the card arriving with FDMA state from a previous boot.  The commit
> "net: lan966x: clear FDMA interrupt stickies after switch reset" says
> the stickies "sit in FDMA_INTR_ERR until the FDMA IRQ is requested later
> in probe, at which point the handler fires immediately and WARNs", and
> "net: lan966x: add shutdown callback to stop FDMA on reboot" says that
> on the endpoint "channels stay active and interrupt sources stay armed
> across the reset" and that "FDMA_INTR_ENA persists on the card across a
> warm reboot".
> 
> The sticky clear in lan966x_reset_switch() clears the latched bits at
> one instant, but does not mask FDMA_INTR_ENA/FDMA_INTR_DB_ENA and does
> not stop the channels.  After a reboot that skips device_shutdown()
> (panic reboot, kexec/kdump, watchdog warm reset with the card still
> powered), could a still-active channel latch FDMA_INTR_DB again after
> the clear and have it delivered as soon as source 14 is unmasked?
> 
> Would it be more robust to reset and mask the FDMA block (the
> FDMA_CTRL NRESET pulse that already exists in lan966x_fdma_pci_init(),
> plus clearing FDMA_INTR_ENA/FDMA_INTR_DB_ENA) before
> devm_request_irq(), or to request the FDMA IRQ only after fdma_init()
> has built the rings and added the NAPI instance?
> 

I think this is pre-existing. It can oops, both variants, and yes - a channel the
previous kernel left active can re-latch FDMA_INTR_DB before devm_request_irq()
unmasks the source. Your second suggestion is the right fix; the reset half of the
first is what fdma_init()'s NRESET pulse already does.

None of this originates here: the request has sat before netif_napi_add() and
ops->fdma_init() since c8349639324a ("net: lan966x: Add FDMA functionality"), and
the SoC device tree has named "fdma" since 2952d32c0611 ("ARM: dts: lan966x: add
switch node") - this patch adds one entry to an interrupt-names list. Nothing to
change in this patch; it goes to net with the same reorder as the MTU-change problem
earlier in the series.

> --
> Sashiko AI review � https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260909-lan966x-pci-fdma-v6-0-6f48dab9d671%40microchip.com
