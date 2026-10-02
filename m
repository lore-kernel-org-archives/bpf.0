Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36AC9474262;
	Fri,  2 Oct 2026 09:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790932614; cv=none; b=BSSh1DIpKJrkYCr4Ya/GNps9P2U3SH8WV5b/5kM1AVyJrX3Z+qeAjaxuz3wuQ2d4MQwF7WrTf0R5miqQOEr904qBWe17sqDVxN6L7WcjaHZub9odZmY5v3/AyWlpZBD4QK+ISUGkPFOoprSek1IIriRPa3dBNi7F0hIr2QbyBf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790932614; c=relaxed/simple;
	bh=GfB4AangzbGer9ZinOHaC9/Iw6vF2BIgUKhcXiugwjs=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qdw1pqRSHK8sA5sPP+ZaHVgHL4HBu3DjZgIB/jZ2iHWX++L7IwqqnJ7GRC8ejzU8Hv4cRDLJzCE9sD8ErtQ9vp9dYtUYjURFIP/gcKmZ69Nl/hCD5W9xqjyLyBesMBPYH8V3u1kSCOubCfwPOGuw5/dJYF1okmjxS7v8/FDOUXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=gLkgmP8q; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="gLkgmP8q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1790932612; x=1822468612;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=GfB4AangzbGer9ZinOHaC9/Iw6vF2BIgUKhcXiugwjs=;
  b=gLkgmP8qYKsFBrB8tz1TcFbpWIVoPt6zUKqM37SYlZ4x2OtNVptdcQ+F
   MkxkotswdlBDkH08VwGO115nN5FjEKHja9Msw+1TsPzXqhD53VRtwBGDg
   Y/YOg/QKA0VJaUGF+3u9cRIPR14CrKzYftCLNlIlBQ1oxMvW/+ew8EzB4
   +R/7b3Nvu2zTNWig7UwBOCc489HE9RbF6cAQiEHbHzIjAfqQpnRcIDyY9
   HcDj4lczp2u81/dvFSmY1duTwVfaQItD2Y9oUkyXZufcaLezn6owk4VrS
   rlc1dVY6yGl5LdA8MLRVtoMcILbaJ5QS2QApooi+56It5VQrE5cRxt+1F
   A==;
X-CSE-ConnectionGUID: 1B6BoPspRIaa6wrCNHZR3Q==
X-CSE-MsgGUID: ZvhM4zZUR1OcZNmWWtJ1aA==
X-IronPort-AV: E=Sophos;i="6.27,136,1787036400"; 
   d="scan'208";a="63547603"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2026 02:16:50 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.87.152) by
 chn-vm-ex4.mchp-main.com (10.10.87.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.49; Fri, 2 Oct 2026 02:16:50 -0700
Received: from DEN-DL-M70577 (10.10.85.11) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Fri, 2 Oct 2026 02:16:46 -0700
Date: Fri, 2 Oct 2026 11:16:45 +0200
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
Subject: Re: [PATCH net-next v9 15/15] misc: lan966x-pci: dts: add fdma
 interrupt to overlay
Message-ID: <20261002091645.tbhmk64qsf5wllni@DEN-DL-M70577>
References: <20260928-lan966x-pci-fdma-v9-15-a17caf60f89a@microchip.com>
 <179092642540.434549.1993526526960644611@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <179092642540.434549.1993526526960644611@kernel.org>

> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider.
> 
> Critical: 0 · High: 0 · Medium: 1 · Low: 0
> 
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
> 
> - [Medium] Once this overlay adds the "fdma" interrupt, PCIe instances
>   use lan966x_fdma_pci_ops, and a teardown ordering bug in that backend…
> 
> --
> 
> misc: lan966x-pci: dts: add fdma interrupt to overlay
> 
> This commit adds the fdma interrupt (OIC interrupt 14) to the lan966x PCI
> device tree overlay. This turns on FDMA-based frame injection and extraction
> when the switch is connected over PCIe.
> 
> > diff --git a/drivers/misc/lan966x_pci.dtso b/drivers/misc/lan966x_pci.dtso
> > index 7bb726550cafd..5bb12dbc08431 100644
> > --- a/drivers/misc/lan966x_pci.dtso
> > +++ b/drivers/misc/lan966x_pci.dtso
> > @@ -141,8 +141,9 @@ switch: switch@e0000000 {
> >  
> >  					interrupt-parent = <&oic>;
> >  					interrupts = <12 IRQ_TYPE_LEVEL_HIGH>,
> > +						     <14 IRQ_TYPE_LEVEL_HIGH>,
> >  						     <9 IRQ_TYPE_LEVEL_HIGH>;
> > -					interrupt-names = "xtr", "fdma", "ana";
> > +					interrupt-names = "xtr", "fdma", "ana";
> 
> [Severity: Medium]
> Once the "fdma" interrupt is present, PCIe instances use
> lan966x_fdma_pci_ops. Does that make a teardown ordering problem in the PCIe
> FDMA backend reachable?
> 
> lan966x_remove() tears down the FDMA before it unregisters the netdevs:
> 
> lan966x_main.c:lan966x_remove() {
>     ...
> 	lan966x->ops->fdma_deinit(lan966x);
> 	lan966x_cleanup_ports(lan966x);
>     ...
> }
> 
> lan966x_fdma_pci_deinit() disables NAPI and frees both rings. It does not
> clear lan966x->rx.lan966x, it does not detach the netdevs, and rtnl is not
> held at this point:
> 
> lan966x_fdma_pci.c:lan966x_fdma_pci_deinit() {
> 	if (lan966x->fdma_ndev)
> 		napi_disable(&lan966x->napi);
>     ...
> 	fdma_free_coherent_and_unmap(lan966x->dma_dev, &lan966x->rx.fdma);
> 	fdma_free_coherent_and_unmap(lan966x->dma_dev, &lan966x->tx.fdma);
> }
> 
> fdma_free_coherent_and_unmap() only clears atu_region, so dcbs and dma
> still hold their old values.
> 
> netif_set_mtu_ext() only checks netif_device_present(). That means an MTU
> change that alters the max frame size can still run during this window:
> 
> lan966x_port_change_mtu()
>   lan966x_fdma_pci_resize()
>     __lan966x_fdma_pci_reload()
>       lan966x_fdma_pci_reload()
>         napi_disable(&lan966x->napi)
> 
> The resize guard is only this check:
> 
> 	if (!lan966x->rx.lan966x)
> 		return 0;
> 
> rx.lan966x is still non-NULL after deinit. Would the second napi_disable()
> on an already disabled NAPI spin forever while holding rtnl? That would also
> block the unregister_netdev() that lan966x_remove() calls next.
> 
> The probe error path in lan966x_fdma_pci_init() looks like it has a similar
> gap:
> 
> 	err = lan966x_fdma_pci_tx_alloc(&lan966x->tx);
> 	if (err) {
> 		fdma_free_coherent_and_unmap(lan966x->dma_dev, rx_fdma);
> 		return err;
> 	}
> 
> rx.lan966x has already been set earlier in lan966x_fdma_pci_init(). The
> netdevs registered by lan966x_probe_port() stay live until the cleanup_ports
> label.
> 
> If an MTU change arrives in that window, NAPI is still enabled from
> lan966x_port_init(). lan966x_fdma_pci_reload() then allocates new rings and
> does:
> 
> 	fdma_free_coherent_and_unmap(lan966x->dma_dev, &rx_fdma_old);
> 
> Is this a second dma_free_coherent() of the RX ring that the error path
> already freed?
> 
> After that, reload re-arms the FDMA on the new rings. The probe error path
> never calls fdma_deinit for them. Would the coherent memory for the new rings
> leak, with the outbound ATU windows still mapped and DMA active after probe
> fails?
> 
> The resize guard added in "net: lan966x: add PCIe FDMA MTU change support"
> is meant to skip the resize until lan966x_fdma_pci_init() has built the
> rings. It doesn't seem to cover rings that were torn down or only partly
> built.
> 
> The shutdown callback from "net: lan966x: add shutdown callback to stop the
> FDMA on reboot" avoids this by taking rtnl and calling netif_device_detach()
> so that ndo_open and ndo_change_mtu can't re-enter the FDMA. Should the
> remove and probe error paths get the same protection?
> 
> The platform backend already has the same remove ordering. The PCIe deinit,
> resize and reload code is new in this series, though, and this overlay change
> is what first makes it reachable.
> 
> -- 
> Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260928-lan966x-pci-fdma-v9-0-a17caf60f89a%40microchip.com

Pre-existing. Lan966x_remove() is a platform function. It's a re-raise of v7
11/14 / v8 15/15, the probe/remove ordering. The issue is real, but out-of-scope
for this series.

