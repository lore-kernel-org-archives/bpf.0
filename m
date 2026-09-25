Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEA094FDE5D;
	Fri, 25 Sep 2026 20:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790369559; cv=none; b=ULhVqrICIY+jFGPk6DJ4vd086nnKkLf0VlYW/cJCQ6PYqbRJOnbv1WMfXHPMXVWB2X4/xiDqQdc9M/7ZqZr/Ivcnx+N9WlI6H3Ssbkdzz/LSsY3xQqhvYU9J/hD41QM2kwP+i5EMGPXtRLsg3/B6vJFxk0DEvrV7cxBBKnSWwCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790369559; c=relaxed/simple;
	bh=j9wjPD8Fq1UhZZv+dhgmh58GftvH/zwSHzBOT3SInRI=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NQp1PM893l/EQV+051jzKZaktIR7U+N4r1hcZrRIjMnmp++nFXfsavnOZg9/8c4CEjUuRupw6MFYPYzCCedWBTyLKWM53xO3pCgbJpIulvvuB0MoZ0Go9Q4kIUmTHQzIhupm0dUTqj8Qqew2qn5En5QrCZ/+ojGH8KMtNeHAlRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QxMl7/8m; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QxMl7/8m"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F96B1F00898;
	Fri, 25 Sep 2026 20:52:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790369557;
	bh=RIN8FgoQb6EH0fSmeV1d3nr9tPsnceX1bvV0MMDXHlc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=QxMl7/8mx6Js4HDmlzrjb7J7Gbtm0F8ipK3QJgc6TSiezhmbB1l877jOH6wfgiIaS
	 nvioCnjBPR4uAjkocfDCx1A7kOJrrcsvaMyLf3BnvXJEN4Fw3oPY9Q2Q9thA+gjbkX
	 IGThDJKS7TnqUyejZYop2rpiqqpoeumCiOMkN9fTDPKuDkDo4EeHpRLz77zqXrXBSQ
	 1Pc3jiV8MJUIIl4otZOjoZzMlKUxmboIkywpZ+X8/VMesBO7lAOKsSI62Au56/OzkI
	 JA6vOmLp8mK6QYHLUw9ZY9nFeKcDaoP5KSpFoq89ViK/QRPyzjj+i5ytziBhB8zTLL
	 It4gxXe1wr3+Q==
Subject: Re: [PATCH net-next v8 15/15] misc: lan966x-pci: dts: add fdma
 interrupt to overlay
From: netdev-bot+sashiko@kernel.org
To: daniel.machon@microchip.com
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horatiu.vultur@microchip.com,
 steen.hegelund@microchip.com, UNGLinuxDriver@microchip.com, ast@kernel.org,
 daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
 sdf@fomichev.me, herve.codina@bootlin.com, arnd@arndb.de,
 gregkh@linuxfoundation.org, mohsin.bashr@gmail.com, horms@kernel.org,
 richardcochran@gmail.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Date: Fri, 25 Sep 2026 20:52:36 +0000
Message-ID: <179036955606.2160803.3935915196015080196@kernel.org>
In-Reply-To: <20260924-lan966x-pci-fdma-v8-15-201c7b707d8b@microchip.com>
References: <20260924-lan966x-pci-fdma-v8-15-201c7b707d8b@microchip.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 2 · Medium: 0 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] PCIe FDMA init races with a concurrent MTU change on netdevices
  that are already registered.
- [High] Removing a PCIe lan966x can deadlock against a concurrent MTU
  change.

--

misc: lan966x-pci: dts: add fdma interrupt to overlay

This patch adds the fdma interrupt (OIC interrupt 14) to the lan966x PCI
device tree overlay. With the "fdma" named interrupt present,
platform_get_irq_byname() succeeds and lan966x->fdma becomes true for the
PCIe card, which turns on the new PCIe FDMA init, resize and deinit paths.

> diff --git a/drivers/misc/lan966x_pci.dtso b/drivers/misc/lan966x_pci.dtso
> index 7bb726550cafd..5bb12dbc08431 100644
> --- a/drivers/misc/lan966x_pci.dtso
> +++ b/drivers/misc/lan966x_pci.dtso
> @@ -141,8 +141,9 @@ switch: switch@e0000000 {
>  
>  					interrupt-parent = <&oic>;
>  					interrupts = <12 IRQ_TYPE_LEVEL_HIGH>,
> +						     <14 IRQ_TYPE_LEVEL_HIGH>,
>  						     <9 IRQ_TYPE_LEVEL_HIGH>;
> -					interrupt-names = "xtr", "ana";
> +					interrupt-names = "xtr", "fdma", "ana";

[Severity: High]
This overlay change makes the PCIe FDMA path reachable. Can
lan966x_fdma_pci_init() race with an MTU change on a port that is already
registered?

In lan966x_probe(), the port netdevs are registered and NAPI is enabled
from inside the port loop:

lan966x_probe()
  lan966x_probe_port()
    register_netdev(dev)
  lan966x_port_init()
    lan966x_fdma_netdev_init()

Only after that loop does probe call lan966x->ops->fdma_init(), and it
does so without RTNL.

The only thing guarding the resize path is a plain pointer check in
lan966x_fdma_pci_resize():

	if (!lan966x->rx.lan966x)
		return 0;

However, lan966x_fdma_pci_init() sets that pointer first, before
rx.max_mtu, before tx.lan966x and before the rings are allocated:

	lan966x->rx.lan966x = lan966x;
	lan966x->rx.max_mtu = lan966x_fdma_get_max_frame(lan966x);
	...
	lan966x->tx.lan966x = lan966x;
	...
	err = lan966x_fdma_pci_rx_alloc(&lan966x->rx);
	...
	err = lan966x_fdma_pci_tx_alloc(&lan966x->tx);

If an RTM_SETLINK MTU change lands in that window (for example a network
manager configuring the new netdev), it would take this path:

lan966x_port_change_mtu()
  lan966x_fdma_pci_resize()
    __lan966x_fdma_pci_reload()
      lan966x_fdma_pci_reload()

lan966x_fdma_pci_reload() snapshots the half-built rings into
rx_fdma_old/tx_fdma_old. It then disables NAPI and the channels, and
allocates and frees rings in the same lan966x->rx.fdma/tx.fdma fields that
probe is still filling in.

If probe has not yet set tx.lan966x, lan966x_fdma_tx_disable() would pass
a NULL lan966x to lan_rmw(). If probe is past that point, both threads
would allocate, overwrite and free the same ring and ATU region fields at
the same time. Could that leak the rings and ATU windows, or free memory
that probe or the FDMA engine is still using?

The commit that adds PCIe FDMA MTU change support says the resize is
skipped "until lan966x_fdma_pci_init() has built the rings". The flag,
though, is set at the start of init rather than after the rings exist.
Would it be better to set it last, or to serialize init against
ndo_change_mtu, for example by holding RTNL?

[Severity: High]
Also enabled by this change: can lan966x_remove() deadlock against a
concurrent MTU change?

lan966x_remove() tears down the FDMA before the netdevs are unregistered.
It does not take RTNL and does not call netif_device_detach():

	lan966x->ops->fdma_deinit(lan966x);
	lan966x_cleanup_ports(lan966x);

lan966x_fdma_pci_deinit() disables NAPI and frees the rings. It leaves
rx.lan966x set:

	if (lan966x->fdma_ndev)
		napi_disable(&lan966x->napi);
	...
	fdma_free_coherent_and_unmap(lan966x->dma_dev, &lan966x->rx.fdma);
	fdma_free_coherent_and_unmap(lan966x->dma_dev, &lan966x->tx.fdma);

The ports stay registered and present until each unregister_netdev() in
lan966x_cleanup_ports() finishes. During that time, an MTU change that
alters the max frame size would still pass the check in
lan966x_fdma_pci_resize() and reach lan966x_fdma_pci_reload(), which
calls napi_disable() a second time with RTNL held:

	napi_disable(&lan966x->napi);

The first disable leaves NAPIF_STATE_SCHED set. napi_disable_locked()
therefore waits forever:

	while (val & (NAPIF_STATE_SCHED | NAPIF_STATE_NPSVC)) {
		usleep_range(20, 200);
		val = READ_ONCE(n->state);
	}

In that case the remove task would then block in unregister_netdev() on
rtnl_lock(), and so would every other RTNL user. If the second
napi_disable() did return, the reload would go on to free
rx_fdma_old/tx_fdma_old, which deinit has already freed.

lan966x_shutdown() in this series already guards against this. It takes
rtnl_lock() and calls netif_device_detach() on each port. The shutdown
commit says this is done "so ndo_open/ndo_change_mtu cannot re-enter the
FDMA against a disabled NAPI".

Does lan966x_remove() need the same protection before calling
fdma_deinit(), or should deinit clear rx.lan966x so that later resizes
are skipped?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260924-lan966x-pci-fdma-v8-0-201c7b707d8b%40microchip.com
