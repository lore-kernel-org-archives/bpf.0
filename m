Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 405EA38B7A6
	for <bpf@vger.kernel.org>; Sat,  9 May 2026 08:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778315241; cv=none; b=IVmcDDaUxzg1tQup3ANUd8rUnon+y8gXzw4XM74uqMHfy4+Ay59Ay67lcalbYdBOb1JgdaTDDtQcTSzS/z4KIcP14opRZlpk3YnR02SZyobM/+xy7ed+dATz9F2dcl0DcHyjB12O9sKvIHIPyF4U1POrw6fUQwOyj33F62czyck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778315241; c=relaxed/simple;
	bh=qfGeQ9wm1J4d5yl4dARom1nR93b9MKK92gmX+THtdhU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=YMj70jOr6c1YR19a86ldYEQj0x6e7zuKUMP/ZvS3ZXtDRuqcu5FK+6Q4h+A5VagX7nRi5f7wxJNCpdooBkZlaqTSkkaBMm/x6GOGnfs+iavt1/HR4QB/4Tj2J2EVCLB4YqQEpaaqS5UmmcREN1Za08NXagd7TiXm3k3vTXx0BBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lEyLiFa9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lEyLiFa9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA2FAC2BCC9;
	Sat,  9 May 2026 08:27:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778315241;
	bh=qfGeQ9wm1J4d5yl4dARom1nR93b9MKK92gmX+THtdhU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=lEyLiFa92agQ7Nz9mpCPkVeUf3aurJZQmL8mkpIOdI/zZYPm78vV/lV7xSBHqAvb4
	 DWNRKchoLqBGrGkSzfnXjwWcapUAs2mG6mhfYvzI/gPVAA36e1PT1bgMpSPAxfID5i
	 FZCny53vaiVdFnfknuaCa6+JfjKaE4Qx9hHHSyzvFGWDOc5vyzrToMroXRTLGtJISj
	 TDGLrWiK7UHQf8Lx/AhAx+CtycPQGeGDOGfPzxN54iCgySTRQqJ0Y7KX2kNn7nshAS
	 xY3LrPUujZu4cEgPSN2GMLQM78HvMH4OxLng8+BvC98Db8VBx6EnK41QoGZ48HHL61
	 oiXnbXvZAu5vA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v4 10/13] net: lan966x: add PCIe FDMA MTU
 change support
Reply-To: sashiko@lists.linux.dev
To: "Daniel Machon" <daniel.machon@microchip.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260508-lan966x-pci-fdma-v4-10-14e0c89d8d63@microchip.com>
References: <20260508-lan966x-pci-fdma-v4-10-14e0c89d8d63@microchip.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 09 May 2026 08:27:20 +0000
Message-Id: <20260509082720.EA2FAC2BCC9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] Race condition in NAPI enable ordering causes permanent RX/TX stal=
l.
- [High] Calling `napi_synchronize()` before `napi_disable()` can cause an =
infinite loop and soft lockup.
- [Medium] Unconditional queue wakeup in `lan966x_fdma_pci_wakeup_netdev` v=
iolates link state semantics.
--

commit 803b55efb87afad3a441075a2a92444e18f35bb2
Author: Daniel Machon <daniel.machon@microchip.com>

net: lan966x: add PCIe FDMA MTU change support

This commit adds MTU change support for the PCIe FDMA path. It reallocates
the contiguous ATU-mapped RX and TX buffers with the new size when the MTU
changes, falling back to reusing the reset buffers on allocation failure.

> diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_fdma_pci.c b/=
drivers/net/ethernet/microchip/lan966x/lan966x_fdma_pci.c
> index 2e88d211073d6..0568251a95d92 100644
> --- a/drivers/net/ethernet/microchip/lan966x/lan966x_fdma_pci.c
> +++ b/drivers/net/ethernet/microchip/lan966x/lan966x_fdma_pci.c

[ ... ]

> @@ -361,9 +366,155 @@ static int lan966x_fdma_pci_init(struct lan966x *la=
n966x)
>  	return 0;
>  }

[ ... ]

> +/* Wake all TX queues on every port (undoes lan966x_fdma_pci_stop_netdev=
). */
> +static void lan966x_fdma_pci_wakeup_netdev(struct lan966x *lan966x)
> +{
> +	for (int i =3D 0; i < lan966x->num_phys_ports; ++i) {
> +		struct lan966x_port *port =3D lan966x->ports[i];
> +
> +		if (port)
> +			netif_tx_wake_all_queues(port->dev);
> +	}
> +}

Should this verify the link state before unconditionally waking the queues?

If a port is administratively down or has lost carrier, its queues should
likely remain stopped. Unconditionally waking them here might force the
network stack to queue packets to a disabled interface.

> +static int lan966x_fdma_pci_reload(struct lan966x *lan966x, int new_mtu)
> +{
> +	struct fdma tx_fdma_old =3D lan966x->tx.fdma;
> +	struct fdma rx_fdma_old =3D lan966x->rx.fdma;
> +	u32 old_mtu =3D lan966x->rx.max_mtu;
> +	int err;
> +
> +	napi_synchronize(&lan966x->napi);
> +	napi_disable(&lan966x->napi);

Does calling napi_synchronize() before napi_disable() risk an infinite loop
here?

Since the hardware RX and TX channels are still active at this point,
network traffic could continue generating interrupts that repeatedly
re-schedule the NAPI. This would continuously assert the NAPI_STATE_SCHED
bit.

Because napi_synchronize() spins as long as NAPI_STATE_SCHED is set, could
this hang indefinitely and cause a soft lockup? It looks like relying solely
on napi_disable() here would be safer.

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

Can this specific ordering cause a permanent stall?

napi_disable() leaves the NAPI_STATE_SCHED bit set until napi_enable() clea=
rs
it. If a hardware interrupt fires right after lan966x_fdma_rx_start() but
before napi_enable(), napi_schedule() will return false and fail to queue t=
he
NAPI.

The interrupt handler would then mask the device interrupt. When
napi_enable() subsequently runs, it clears NAPI_STATE_SCHED, but the NAPI
remains unqueued and the hardware interrupt remains permanently masked.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260508-lan966x-pc=
i-fdma-v4-0-14e0c89d8d63@microchip.com?part=3D10
