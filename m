Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B487747887F;
	Mon, 14 Sep 2026 14:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789394990; cv=none; b=gYkwJmxpE21oXJMXUachFRRhj8hoWSZEKUryoG0Mr78Wjv2t+OJvty3xijGAJsS6WUi8o8V+Cd/Vem39OhJlpq4I/XIx3ZKShwesK3C+fX6pn/dzOeX7AwKmgRh5W7beghZYGUDQB8vC/xTmvP+8t4WeFcTbFaJozegb0AGuLkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789394990; c=relaxed/simple;
	bh=kXyZcf9mVRUP9nMLt2/MVgHhc0OPsuWGYpRhhFqEPKc=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WKjubpvKEufWgv2hmuQI2sUc2vjVOzoS/eO4gkUTentCdXrGpAdfDW/uX4BU3dYwoRajDsY8tSUShISGDhUfJTCg9qmY1yMjjOPzFxEcpPoBqXKTMsb/Ul7yIllyaT5IN7o7u60t3W2j3TLRyfpKEIRUnFQq2UnPO9MYWivC9B4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=yLA8gBwI; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="yLA8gBwI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1789394988; x=1820930988;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=kXyZcf9mVRUP9nMLt2/MVgHhc0OPsuWGYpRhhFqEPKc=;
  b=yLA8gBwI7TujHyIAtGwTFaXHDmuJO5ynF0hbGw/uThoi13bENbP4t+XC
   BrCzyAEbC8zDPEJgsuxCvMojqxH3wNYWwHzvISl6wyFQNBr9TeYf2cXvF
   8QrLQimP4JDATU0JWlfXj0k1XfQ2lGfInD88/gBF/E+TKoCdNNJJHrO4G
   xFVTcvnR1qapO69WX/FK6bpLgbz7UbnBB37ipupwnT9SqtDNAn/y7zDuF
   +wfOJ16+JGgt7kuh7lsKQNpLxGtCKcQLOWaU24EYhZduJyLTuQ0y900w6
   dcIFfmkn330wEQjocqbFeCqGMeYt1s+WzRsacg1W0XHM5gCSWw3JSXfka
   Q==;
X-CSE-ConnectionGUID: rVLQJSZ6ShGlku+t+zZqfg==
X-CSE-MsgGUID: +9pA80GKSjCe+q/7ZmKqbQ==
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="62642258"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Sep 2026 07:09:41 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Mon, 14 Sep 2026 07:09:40 -0700
Received: from DEN-DL-M70577 (10.10.85.11) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Mon, 14 Sep 2026 07:09:36 -0700
Date: Mon, 14 Sep 2026 16:09:36 +0200
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
Subject: Re: [PATCH net-next v6 08/14] net: lan966x: clear FDMA interrupt
 stickies after switch reset
Message-ID: <20260914140936.kqsqxbovxvsihv42@DEN-DL-M70577>
References: <20260909-lan966x-pci-fdma-v6-8-6f48dab9d671@microchip.com>
 <178904554399.219967.11177166628090236711@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <178904554399.219967.11177166628090236711@kernel.org>

> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider:
> 
> Critical: 0 · High: 0 · Medium: 0 · Low: 1
> 
> - [Low] Commit-message/comment vs. reachability at this revision: the
>   added FDMA sticky clear in lan966x_reset_switch()…
> 
> --
> 
> net: lan966x: clear FDMA interrupt stickies after switch reset
> 
> The patch acks FDMA_ERRORS, FDMA_INTR_ERR and FDMA_INTR_DB right after
> reset_control_reset() in lan966x_reset_switch(), so that spurious sticky
> bits latched by the GCB soft reset in PCI mode do not make the FDMA IRQ
> handler fire as soon as the IRQ is requested. The clear is unconditional and
> is described as a no-op on the platform path.
> 
> > diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_main.c b/drivers/net/ethernet/microchip/lan966x/lan966x_main.c
> > index 6e6c08bb8eea..11094a381ec2 100644
> > --- a/drivers/net/ethernet/microchip/lan966x/lan966x_main.c
> > +++ b/drivers/net/ethernet/microchip/lan966x/lan966x_main.c
> > @@ -1067,6 +1067,15 @@ static int lan966x_reset_switch(struct lan966x *lan966x)
> >
> >       reset_control_reset(switch_reset);
> >
> > +     /* When in PCI mode, the GCB soft reset issued by the reset
> > +      * controller can latch spurious bits in the FDMA error stickies.
> > +      * Clear them before request_irq hooks up the FDMA IRQ line,
> > +      * otherwise the handler fires immediately on probe.
> > +      */
> > +     lan_wr(lan_rd(lan966x, FDMA_ERRORS), lan966x, FDMA_ERRORS);
> > +     lan_wr(lan_rd(lan966x, FDMA_INTR_ERR), lan966x, FDMA_INTR_ERR);
> > +     lan_wr(lan_rd(lan966x, FDMA_INTR_DB), lan966x, FDMA_INTR_DB);
> 
> [Severity: Low]
> This isn't a bug in the register writes themselves, but is the failure
> described in the changelog reachable at this point in the series?

No, but this is a preparation patch that makes sure that once the FDMA support
lands, in a later patch, the failure is not introduced.

> 
> The commit message says the latched bits "sit in FDMA_INTR_ERR until the FDMA
> IRQ is requested later in probe, at which point the handler fires immediately
> and WARNs". In lan966x_probe() the FDMA handler is only installed when a named
> "fdma" interrupt exists:
> 
>         lan966x->fdma_irq = platform_get_irq_byname(pdev, "fdma");
>         if (lan966x->fdma_irq > 0) {
>                 err = devm_request_irq(&pdev->dev, lan966x->fdma_irq,
>                                        lan966x_fdma_irq_handler, 0,
>                                        "fdma irq", lan966x);
>                 ...
>                 lan966x->fdma = true;
>         }
> 
> At this commit the PCI overlay in drivers/misc/lan966x_pci.dtso does not
> describe that interrupt:
> 
>         interrupts = <12 IRQ_TYPE_LEVEL_HIGH>,
>                      <9 IRQ_TYPE_LEVEL_HIGH>;
>         interrupt-names = "xtr", "ana";
> 
> so platform_get_irq_byname(pdev, "fdma") fails and lan966x_fdma_irq_handler()
> is never requested on the PCI path.
> 
> The overlay also disagrees with the positional list in
> Documentation/devicetree/bindings/net/microchip,lan966x-switch.yaml, where the
> second entry is reserved for "fdma":
> 
>         interrupt-names:
>           minItems: 1
>           items:
>             - const: xtr
>             - const: fdma
>             - const: ana
> 
> Both points are resolved later in the same series by "misc: lan966x-pci: dts:
> add fdma interrupt to overlay", which switches the overlay to
> interrupts <12>,<14>,<9> and interrupt-names = "xtr", "fdma", "ana", so this is
> only an observation about the ordering of the changelog against the code state
> here rather than an actionable defect.
> 
> Would it help to mention in the commit message that the WARN only becomes
> reachable once the overlay gains the "fdma" interrupt?

The changelog already scopes itself with "When in PCI mode".

> 
> >       /* Don't reinitialize the switch core, if it is already initialized. In
> >        * case it is initialized twice, some pointers inside the queue system
> >        * in HW will get corrupted and then after a while the queue system gets
> 
> --
> Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260909-lan966x-pci-fdma-v6-0-6f48dab9d671%40microchip.com
