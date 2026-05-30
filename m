Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1AAC29D26E
	for <bpf@vger.kernel.org>; Sat, 30 May 2026 00:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780101879; cv=none; b=QYqMLzSZ8kisZnqjWzX+bvpZ0i1pvduxIRA4SfpCw/d/inLCVs4We5Ci5WyBizMgkue/NnnPHJDxCfQPW/1n773rU8Gbw4AqvfhK0Irclup4RbQF1gtYtkTgsrueXjl1ToWIC8j1WcuV8JvNUZ02+4/19RYzDyFjlCTI13d0jLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780101879; c=relaxed/simple;
	bh=i/Fv2I2tZNGOCxl//uf1Gj+N3tSYFwBYEKyapDjC494=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=kDMo7xdoDC1diJhcTqc4io8+/AP7agzEXfHrAfV7YUsEXpKMvW+Ii9kjd7kseARP1YDk4Srj9l07N9YiBgwUY7bv+R0/mekt0/mvVUcQf5qok3HKd/gAuOOLjxABrKv5CPjjeb7Q6NGge+izuRM2x9NnIqbYDLugMxHJyDTB9bE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FhTgFbeN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FhTgFbeN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCB671F00898;
	Sat, 30 May 2026 00:44:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780101878;
	bh=sCBoCjGDm0sgvuyr/6UZS6rCKRXNiaGcQS3bmnjq718=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FhTgFbeNMtcxXVtNJIo3CB/vpELIIz9dDsenaZ6R/5pQjZQ6rCzYNJjYMOGbOsUCE
	 TUMEsYUui73R4pSDLlJ6Rc93nvPKwdSmMFRBxeB3yBTdiQO4bFWBPY2M+BA7Yh5Oo3
	 Zu6+Q5c6klCvGYESNKZcwg83n/T2uukMFUXX+N06l1MayXtBYXk4zUH8h2yJq4oGRZ
	 OlaKfAMArp2Q39bt9dy0Ek80aEyUOU//xZ38VOVQOTUiNGGzbHjuilflJmtwvxiZ7W
	 N9+GnGStSnuOCIydPfGFc2pqeL95KYWATYrFM+m4TEVRTlzrFRRCf7gsevDy3Io6tb
	 K+VurnggOzRPQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v5 08/13] net: lan966x: add shutdown callback
 to stop FDMA on reboot
Reply-To: sashiko-reviews@lists.linux.dev
To: "Daniel Machon" <daniel.machon@microchip.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260520-lan966x-pci-fdma-v5-8-ca56197ae05b@microchip.com>
References: <20260520-lan966x-pci-fdma-v5-8-ca56197ae05b@microchip.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 30 May 2026 00:44:37 +0000
Message-Id: <20260530004437.CCB671F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

New issues:
- [High] Calling napi_disable() unconditionally during shutdown causes a NU=
LL pointer dereference if the device tree contains no valid ports.
- [High] The lan966x_shutdown() callback disables hardware channels before =
stopping the network stack and NAPI, allowing concurrent traffic to re-acti=
vate the DMA channels.

Pre-existing issues:
- [Critical] The driver's `remove` method tears down the FDMA structures be=
fore unregistering the network devices, leading to a Use-After-Free upon co=
ncurrent transmission.
- [High] NAPI is deleted without being disabled in the probe error path if =
fdma_init fails.
--

commit 4567cfb4a8261113fe86f623b6d21c6d3a34dd6b
Author: Daniel Machon <daniel.machon@microchip.com>

net: lan966x: add shutdown callback to stop FDMA on reboot

This commit adds a shutdown callback to stop the FDMA engine when the host
reboots. It masks FDMA interrupts and disables the RX and TX channels.
This prevents the shared PCIe INTx from asserting before the driver
re-probes on the card.

> diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_main.c b/driv=
ers/net/ethernet/microchip/lan966x/lan966x_main.c
> --- a/drivers/net/ethernet/microchip/lan966x/lan966x_main.c
> +++ b/drivers/net/ethernet/microchip/lan966x/lan966x_main.c

[ ... ]

> static void lan966x_remove(struct platform_device *pdev)
> {
> 	struct lan966x *lan966x =3D platform_get_drvdata(pdev);
>=20
> 	lan966x_taprio_deinit(lan966x);
> 	lan966x_vcap_deinit(lan966x);
> 	lan966x->ops->fdma_deinit(lan966x);
> 	lan966x_cleanup_ports(lan966x);

[Severity: Critical]
This is a pre-existing issue, but does the remove method tear down FDMA
structures before unregistering the network devices?

Because lan966x_cleanup_ports() has not yet unregistered the netdevs, they
remain active. Could a concurrent frame transmission call lan966x_fdma_xmit=
(),
access the freed DMA coherent memory, and result in a use-after-free?

>=20
> 	cancel_delayed_work_sync(&lan966x->stats_work);
> 	destroy_workqueue(lan966x->stats_queue);

[ ... ]

> @@ -1313,9 +1313,27 @@ static void lan966x_remove(struct platform_device =
*pdev)
>  	debugfs_remove_recursive(lan966x->debugfs_root);
>  }
> =20
> +static void lan966x_shutdown(struct platform_device *pdev)
> +{
> +	struct lan966x *lan966x =3D platform_get_drvdata(pdev);
> +
> +	if (!lan966x->fdma)
> +		return;
> +
> +	lan966x_fdma_rx_disable(&lan966x->rx);
> +	lan966x_fdma_tx_disable(&lan966x->tx);

[Severity: High]
Should the network stack and NAPI be disabled before turning off the
hardware channels?

If the networking stack invokes ndo_start_xmit concurrently, could the driv=
er
observe the channel is deactivated and write to FDMA_CH_ACTIVATE to turn the
DMA engine back on? This might defeat the purpose of the shutdown callback
and risk DMA memory corruption.

> +
> +	napi_synchronize(&lan966x->napi);
> +	napi_disable(&lan966x->napi);

[Severity: High]
What happens here if the device tree contains no valid ports?

If the ports list is empty, lan966x_fdma_netdev_init() is never called, lea=
ving
lan966x->napi zero-initialized (meaning napi->dev is NULL). Does calling
napi_disable() here unconditionally attempt to acquire netdev_lock(n->dev) =
and
cause a NULL pointer dereference?

> +
> +	lan_wr(0, lan966x, FDMA_INTR_ENA);
> +	lan_wr(0, lan966x, FDMA_INTR_DB_ENA);
> +}

[Severity: High]
This is a pre-existing issue, but I noticed a potential problem in
lan966x_probe() during error handling.

If lan966x->ops->fdma_init() fails after the global NAPI instance is
initialized and enabled by lan966x_port_init(), the error path jumps to
cleanup_ptp and bypasses cleanup_fdma.

This leads to lan966x_cleanup_ports() removing the NAPI instance via
netif_napi_del() without first calling napi_disable(). Does deleting an
enabled NAPI instance trigger a WARN_ON and potentially lead to a
use-after-free if a poll happens concurrently?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260520-lan966x-pc=
i-fdma-v5-0-ca56197ae05b@microchip.com?part=3D8
