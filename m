Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05F7D4A3415
	for <bpf@vger.kernel.org>; Tue,  5 May 2026 18:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778005377; cv=none; b=dibOSMuJp8PC/XJ8KN1VNe9Lw3bv4qcdubRLJBir2S30KdF1yBjGZOcWlOk/kFHpvlsRVc75ZQg6+FfGQ5HsByT1cpzcfV75ezFgBuGUVQT/z2xn+xBNbJEP9XS/8jExvq0X6+pTQ9lhMeW3OHzv1pATzwsGPuWoEUyikmuldNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778005377; c=relaxed/simple;
	bh=fpStNQfSPwP0jLhlomZz2huYkcvpiec7S3ugAJxK4Ig=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ijVJjdJxn4kWmHDp93ucI9amoaWmCD/AFtQGPv/YHjVL/zPGHRzX218aA0L2ybtg5ooSBJqjNKsJhnwpajZQXT2Q8L5q+Ne1hIbLfRivOZfZujewN2QvN/9uoSFJ9ZNjkAXddw+W44aCSgS2fQ+7KQXdqwZMkhX0wEminodTQEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oB7wZcRF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oB7wZcRF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A54BCC2BCB4;
	Tue,  5 May 2026 18:22:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778005376;
	bh=fpStNQfSPwP0jLhlomZz2huYkcvpiec7S3ugAJxK4Ig=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=oB7wZcRF+mv+b0YDPdTPWNpgXHmDXbL6rVemjAcdreuC3X25Mvu1pw1LbTK6FrFv3
	 tSAgiCO+MRnhFHhjIIiXfJjzMnFTBNtdE6MAzilYIUIYIgn+UEMFZYaZe8bBx0vWaY
	 Ocs2EvgJ31cYYZjrtXtUr40RZMsyuEZjsCoen3MgOEdrNtlFVjz/351DAFbI6SYJFc
	 6bzVUAT9mxGO2ZXNmR0vZqXR5qQDjITmg4uprX5FpHLseMtBirolKiawldbHfjrBxe
	 rotZAZVLW0x8p+oiQgQJQGe2f7Metb+rlcia1FYdVny8HEvNmQFSUt8oS9sMdFu+eb
	 YrPqzP4dPWzTA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v3 05/13] net: lan966x: export FDMA helpers for
 reuse
Reply-To: sashiko@lists.linux.dev
To: "Daniel Machon" <daniel.machon@microchip.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260504-lan966x-pci-fdma-v3-5-a56f5740d870@microchip.com>
References: <20260504-lan966x-pci-fdma-v3-5-a56f5740d870@microchip.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 05 May 2026 18:22:56 +0000
Message-Id: <20260505182256.A54BCC2BCB4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Critical] Data race and Use-After-Free during driver teardown due to loc=
kless state modification and incorrect ordering
- [High] Unsafe DMA teardown due to ignored timeout in lan966x_fdma_tx_disa=
ble() and lan966x_fdma_rx_disable()
--

commit d9b72843e1c15f3261008784be970a31341a866d
Author: Daniel Machon <daniel.machon@microchip.com>

net: lan966x: export FDMA helpers for reuse

Make shared FDMA helpers non-static, so they can be reused by the PCIe
FDMA implementation.

> diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c b/driv=
ers/net/ethernet/microchip/lan966x/lan966x_fdma.c
> index 6c5761e886d47..25e673bdf0841 100644
> --- a/drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c
> +++ b/drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c
[ ... ]
> @@ -171,7 +171,7 @@ static void lan966x_fdma_rx_start(struct lan966x_rx *=
rx)
>  		lan966x, FDMA_CH_ACTIVATE);
>  }
> =20
> -static void lan966x_fdma_rx_disable(struct lan966x_rx *rx)
> +void lan966x_fdma_rx_disable(struct lan966x_rx *rx)
>  {
>  	struct lan966x *lan966x =3D rx->lan966x;
>  	struct fdma *fdma =3D &rx->fdma;

This isn't a bug introduced in this patch, but exporting this function
exposes an existing issue.

Does this code handle hardware timeouts safely? Looking at the implementati=
on
of lan966x_fdma_rx_disable(), the return value of readx_poll_timeout_atomic=
()
is ignored:

    readx_poll_timeout_atomic(lan966x_fdma_channel_active, lan966x,
                              val, !(val & BIT(fdma->channel_id)),
                              READL_SLEEP_US, READL_TIMEOUT_US);

If the hardware is unresponsive and the poll times out, the driver might
falsely assume the channel is halted and proceed to alter hardware state.

If the caller later frees the coherent DMA rings while the DMA engine is
still active, could this lead to memory corruption or IOMMU faults?

[ ... ]
> @@ -265,7 +265,7 @@ static void lan966x_fdma_tx_activate(struct lan966x_t=
x *tx)
>  		lan966x, FDMA_CH_ACTIVATE);
>  }
> =20
> -static void lan966x_fdma_tx_disable(struct lan966x_tx *tx)
> +void lan966x_fdma_tx_disable(struct lan966x_tx *tx)
>  {
>  	struct lan966x *lan966x =3D tx->lan966x;
>  	struct fdma *fdma =3D &tx->fdma;

This is another pre-existing issue exposed by exporting these helpers.

The same ignored timeout issue from readx_poll_timeout_atomic() exists
here in lan966x_fdma_tx_disable().

Additionally, is it safe to modify tx->activated without holding the
lan966x->tx_lock?

Looking at the driver teardown path, lan966x_remove() appears to call
lan966x->ops->fdma_deinit() (which calls lan966x_fdma_tx_disable() and frees
the DMA rings) before lan966x_cleanup_ports() unregisters the netdev.

If the network interface is up and actively transmitting during module
removal, could the networking stack concurrently call lan966x_port_xmit(),
acquire tx_lock, and write to tx->fdma.dcbs while it is being freed,
resulting in a use-after-free?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260504-lan966x-pc=
i-fdma-v3-0-a56f5740d870@microchip.com?part=3D5
