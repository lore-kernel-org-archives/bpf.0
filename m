Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7A3A2C15AB
	for <bpf@vger.kernel.org>; Sat, 30 May 2026 00:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780101881; cv=none; b=pkRAnqp9Jnxg68y3DX6oH+yWNMX3QHO2Oi7L2tB8EgOw0eug4XDMn2M6XrOqeevsMSNCSwN6HnZTaejmFnpsseS+BmI8jGQVrsQFykemKRyGhkSv8nEUVikLU2jhJVr0i2/5dmIf3ovh2XulQbSeO68Q+78Rog+gMBZCd/MZjPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780101881; c=relaxed/simple;
	bh=TWlHIcxkpR75nvTeuwIEt2YjWaXd5XMmIfcsKE24Rv4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=M03Wud8hnAvhgCFXqbymOLEU/oVbATMeTmrkXtdtUiSNgvwSuPcSgKLe1QycJuFo3aRzMdWx03V7LUxvNtXzH2FpTfHMedY9AHNFYXNgWnThEBp5Jmix30tvbcsylx858Z1KiaHiGLaAHvBKU21czpuvw6SjrCvHeyxv70ciUs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nRDGq/IT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nRDGq/IT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57B1A1F00899;
	Sat, 30 May 2026 00:44:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780101879;
	bh=ZLGoGvl7P1h1YM5ERfO0iS8/jkHI9cAG7UwHFw2zJ0s=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nRDGq/ITc2bMfLQEAZZ6Xscscqi/dgv4LU428nqaMxyW8HjeuZJAw/tpj9ev9a8Xj
	 W9bQxnNuz68NQV9jcb6/G+X/bxMp7iAimv4oWS8LjJhD9PWsmNuPcnI8ZgFBWgZTdd
	 ByIZIKDENQBpO4weXIEAoWl5CFrA5x1Rg4JA+k7bJot2xedWmrs+W/ubZj5EwAdVbG
	 FVNVIEFFy7BO9YeCoIKY1JMg1olOeqOCv6HvehEw0oWsoCRR39oqS2wrDpsbVAin8W
	 gpzti32txY+pLT3xfT466JZhYVxmkIQfLOdMXqR9GqmTh4nfxwdD+/LyphIEc9o0Mu
	 oKTPuMF5qTOFw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v5 10/13] net: lan966x: add PCIe FDMA MTU
 change support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Daniel Machon" <daniel.machon@microchip.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260520-lan966x-pci-fdma-v5-10-ca56197ae05b@microchip.com>
References: <20260520-lan966x-pci-fdma-v5-10-ca56197ae05b@microchip.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 30 May 2026 00:44:39 +0000
Message-Id: <20260530004439.57B1A1F00899@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [High] Enabling NAPI after starting FDMA RX and waking TX queues introduc=
es a race condition that can result in permanently masked hardware interrup=
ts.
- [Low] Calling napi_synchronize() immediately before napi_disable() is an =
anti-pattern and inherently racy.

Pre-existing issues:
- [High] Missing tx_lock in lan966x_fdma_pci_xmit causes TX ring corruption=
 when multiple ports transmit concurrently.
--

commit 57dba359ada8c7a7372a6ba3549f892f7d7fd051
Author: Daniel Machon <daniel.machon@microchip.com>

net: lan966x: add PCIe FDMA MTU change support

This commit adds MTU change support for the PCIe FDMA path. It reallocates
the RX and TX buffers with the new size when the MTU changes, and caps the
PCIe DCB ring at 256 to prevent the contiguous allocation from overflowing
MAX_PAGE_ORDER at jumbo MTUs.

> diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_fdma_pci.c b/=
drivers/net/ethernet/microchip/lan966x/lan966x_fdma_pci.c
> index c27d9e76e7358..3ea6d22ee573b 100644
> --- a/drivers/net/ethernet/microchip/lan966x/lan966x_fdma_pci.c
> +++ b/drivers/net/ethernet/microchip/lan966x/lan966x_fdma_pci.c
[ ... ]
> @@ -342,7 +347,7 @@ static int lan966x_fdma_pci_init(struct lan966x *lan9=
66x)
> =20
>  	lan966x->tx.lan966x =3D lan966x;
>  	tx_fdma->channel_id =3D FDMA_INJ_CHANNEL;
> -	tx_fdma->n_dcbs =3D FDMA_DCB_MAX;
> +	tx_fdma->n_dcbs =3D FDMA_PCI_DCB_MAX;
>  	tx_fdma->n_dbs =3D FDMA_TX_DCB_MAX_DBS;
>  	tx_fdma->priv =3D lan966x;
>  	tx_fdma->db_size =3D FDMA_PCI_DB_SIZE(lan966x->rx.max_mtu);

[Severity: High]
This is a pre-existing issue, but does the shared FDMA TX ring require
synchronization in the transmission path?

The driver shares a single FDMA TX ring (lan966x->tx.fdma) across multiple
physical switch ports, each represented by a separate net_device.

Since the network stack synchronizes ndo_start_xmit on a per-queue
(per net_device) basis, multiple ports can execute lan966x_fdma_pci_xmit()
concurrently on different CPUs. Because lan966x_fdma_pci_xmit() accesses
and modifies the shared tx->fdma state without holding the
spin_lock(&lan966x->tx_lock) (unlike the non-PCI lan966x_fdma_xmit() path),
could concurrent transmissions lead to unsynchronized TX ring accesses and
ring corruption?

[ ... ]
> @@ -365,9 +370,155 @@ static int lan966x_fdma_pci_init(struct lan966x *la=
n966x)
>  	return 0;
>  }
> =20
[ ... ]
> +static int lan966x_fdma_pci_reload(struct lan966x *lan966x, int new_mtu)
> +{
> +	struct fdma tx_fdma_old =3D lan966x->tx.fdma;
> +	struct fdma rx_fdma_old =3D lan966x->rx.fdma;
> +	u32 old_mtu =3D lan966x->rx.max_mtu;
> +	int err;
> +
> +	napi_synchronize(&lan966x->napi);
> +	napi_disable(&lan966x->napi);

[Severity: Low]
Is this call to napi_synchronize() necessary before napi_disable()?

Since napi_disable() safely sets NAPI_STATE_DISABLE and internally blocks
until the NAPI_STATE_SCHED flag clears, adding a manual napi_synchronize()
right before it seems redundant. Does this leave a tiny race window where N=
API
could be rescheduled before napi_disable() takes effect?

> +	lan966x_fdma_pci_stop_netdev(lan966x);
> +	lan966x_fdma_rx_disable(&lan966x->rx);
> +	lan966x_fdma_tx_disable(&lan966x->tx);
[ ... ]
> +	/* Free and unmap old memory. */
> +	fdma_free_coherent_and_unmap(lan966x->dev, &rx_fdma_old);
> +	fdma_free_coherent_and_unmap(lan966x->dev, &tx_fdma_old);
> +
> +	/* Keep this order: rx_start, wakeup_netdev, napi_enable. */
> +	lan966x_fdma_rx_start(&lan966x->rx);
> +	lan966x_fdma_pci_wakeup_netdev(lan966x);
> +	napi_enable(&lan966x->napi);

[Severity: High]
Does this order introduce a race condition that can result in permanently
masked hardware interrupts?

If a packet is received right after lan966x_fdma_rx_start() enables hardware
interrupts, the device raises an interrupt triggering the handler. The ISR
would then mask the hardware interrupt and call napi_schedule().

Because napi_enable() has not yet been called, NAPI_STATE_SCHED is still set
from the earlier napi_disable(), which causes napi_schedule() to fail to
queue the NAPI poll. Subsequently, napi_enable() clears the state flags but
does not schedule a poll.

Should napi_enable() be called before lan966x_fdma_rx_start() to prevent
hardware interrupts from remaining permanently masked?

> +
> +	return err;
> +restore:
> +
> +	/* No new buffers are allocated at this point. Use the old buffers,
> +	 * but reset them before starting the FDMA again.
> +	 */
> +
> +	memcpy(&lan966x->tx.fdma, &tx_fdma_old, sizeof(struct fdma));
> +	memcpy(&lan966x->rx.fdma, &rx_fdma_old, sizeof(struct fdma));
> +
> +	lan966x->rx.max_mtu =3D old_mtu;
> +
> +	lan966x_fdma_pci_reset_mem(lan966x);
> +
> +	/* Keep this order: rx_start, wakeup_netdev, napi_enable. */
> +	lan966x_fdma_rx_start(&lan966x->rx);
> +	lan966x_fdma_pci_wakeup_netdev(lan966x);
> +	napi_enable(&lan966x->napi);

[Severity: High]
Does this restore path have the same race condition with hardware interrupts
as mentioned above?

> +
> +	return err;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260520-lan966x-pc=
i-fdma-v5-0-ca56197ae05b@microchip.com?part=3D10
