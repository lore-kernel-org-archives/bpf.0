Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5F784A340F
	for <bpf@vger.kernel.org>; Tue,  5 May 2026 18:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778005380; cv=none; b=QKDfYKx6lEVxyWidKoU0RDFUWS8Ly2DaUQ29o3s19rfuUkDSdlrvRs69+LhWA7NUXZX662D0U+0HVmKmKfvpubPF07K2x7cVTdeyGHnAxDcLJkHgXh3ZwtF3Zc77l0eF5LM3VwOuQiJYsDjvQRUKMTaiXCSLR9X4lfVdwQpQvik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778005380; c=relaxed/simple;
	bh=RvOp31bN8+LFvBEHdN+i0tR018r1dlq43ximR6EKVBY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=DD2ha5U7DfE3emxTqphu6xKtR9YbXKUbuGIykGyA3BnEchbpFRZ9UDtR628Pc2KouCT3vIybWKifc22RpAYzoxDczGEEnXZw+2BU+RB0rdRnkACv5KIdi6+rCPtCK2aTQbgAJkuJfRxNi3+6zuyIp76/w69keQK4oUnhlUaWjEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nRAsSOtA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nRAsSOtA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89186C2BCB4;
	Tue,  5 May 2026 18:22:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778005379;
	bh=RvOp31bN8+LFvBEHdN+i0tR018r1dlq43ximR6EKVBY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=nRAsSOtAOp/+WsJ0cT4rtnJ80xrN4ChfATeB8EHrNcCMajsdHos0MeFQax5mvpOJk
	 IspDgg+tBEYY2UxaNnEjvoanww7wXFmsQjELvpGZMhyQqOb4yuAeGgMRdaoiZtcAh2
	 Pz9aSg1Qb1r2cy0KMgUSaQpAOoLxx/Re2Hh6ZCYjJw4gNESjChwvBRn283fawG+Zw0
	 SuU1iGNAjk5Lkk8E8My45WuW9aEOU8uOXD2EhHOww67DE30wFKYE7mNnzkkTQUJY52
	 cag9hMCxsE8JZd0pfgdNjV2kTNMbgxVS4WiQApEWtu7TK8cOh9y1m1iU7tQgvk3dB7
	 Yubg1gxCF8iww==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v3 10/13] net: lan966x: add PCIe FDMA MTU
 change support
Reply-To: sashiko@lists.linux.dev
To: "Daniel Machon" <daniel.machon@microchip.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260504-lan966x-pci-fdma-v3-10-a56f5740d870@microchip.com>
References: <20260504-lan966x-pci-fdma-v3-10-a56f5740d870@microchip.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 05 May 2026 18:22:59 +0000
Message-Id: <20260505182259.89186C2BCB4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] NAPI enablement race condition in reload paths can permanently sta=
ll the device.
--

commit 20d04dd9ba5afad59c5a90474d47aff04eccef0c
Author: Daniel Machon <daniel.machon@microchip.com>

net: lan966x: add PCIe FDMA MTU change support

This commit adds MTU change support for the PCIe FDMA path. It allows
continuous ATU-mapped RX and TX buffers to be reallocated with a new size
upon MTU changes, falling back to reusing existing buffers upon allocation
failure.

> diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_fdma_pci.c b/=
drivers/net/ethernet/microchip/lan966x/lan966x_fdma_pci.c
> index 2c54880460772..491ddc337760f 100644
> --- a/drivers/net/ethernet/microchip/lan966x/lan966x_fdma_pci.c
> +++ b/drivers/net/ethernet/microchip/lan966x/lan966x_fdma_pci.c
[ ... ]
> @@ -354,9 +359,155 @@ static int lan966x_fdma_pci_init(struct lan966x *la=
n966x)
[ ... ]
> +static int lan966x_fdma_pci_reload(struct lan966x *lan966x, int new_mtu)
> +{
[ ... ]
> +	/* Keep this order: rx_start, wakeup_netdev, napi_enable. */
> +	lan966x_fdma_rx_start(&lan966x->rx);
> +	lan966x_fdma_pci_wakeup_netdev(lan966x);
> +	napi_enable(&lan966x->napi);

Is this ordering vulnerable to a race condition that can permanently stall
the device?

If an interrupt fires immediately after lan966x_fdma_rx_start() but before
napi_enable(), could the following sequence occur:

lan966x_fdma_rx_start()
  -> enables hardware interrupts via FDMA_INTR_DB_ENA

Hardware Interrupt
lan966x_fdma_irq_handler()
  -> masks interrupt via FDMA_INTR_DB_ENA
  -> napi_schedule()
     -> drops the event because napi_enable() hasn't run yet

napi_enable()
  -> clears NAPI state but schedules no poll

Since the hardware interrupt remains masked by the ISR and NAPI will never =
run
to unmask it, does this leave the NAPI polling permanently stalled?

Should napi_enable() be called before lan966x_fdma_rx_start() unmasks the
hardware interrupts?

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

Does this restore path have the same race condition between unmasking
hardware interrupts and enabling NAPI?

> +
> +	return err;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260504-lan966x-pc=
i-fdma-v3-0-a56f5740d870@microchip.com?part=3D10
