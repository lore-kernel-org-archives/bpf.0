Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E07F038B125
	for <bpf@vger.kernel.org>; Sat,  9 May 2026 08:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778315240; cv=none; b=uVfz5LNPUCBk1VSMuMiR4I7PT0J/9S5ct67J6vhjEH7dUr3iMGWAwMmw8vHc2WsCWoORclZWAIWjEUmC/AKw76CDe2ejlllxfXa4aQpgAKu6/B3ipip9fu2vNPgGi+QexO74SxQ/x8eOSwJIbz5BNN64eruU5izAtOYuZ1cg+JM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778315240; c=relaxed/simple;
	bh=AWXWnl76hONf0fjez7cZEhCcxoPRyx65/lkyHKrkPUw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=g+YNrn/W8BqMktUGUr9f9GehbZpWO2bPKc9CJy2TOwwKQhJn2RJc7vmPv4PySJWNPe2ahD/HYwyi8AAATl/BzI03EAC0ljk3Sw8xchaLMHRzIx5G34ZGdmH0nMfV4k96n7JfA1C9VlZIiGEOI+nD/yL9r8KFUgi6sx5xSmezvM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fgVUMX2q; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fgVUMX2q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94D72C2BCB4;
	Sat,  9 May 2026 08:27:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778315239;
	bh=AWXWnl76hONf0fjez7cZEhCcxoPRyx65/lkyHKrkPUw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=fgVUMX2qfROGmZdFvaJAsz+JOh4gbDiYX39Vvklfb9QDkMctpOwhPr+WptecC/TDE
	 IFvSoxN/lfbKtlMhie/azJKN/SeU54BO0LlEZLIR5d7ky4Q25a0sP78XsNZ1zowUnV
	 lCYKJuy7v+KsgmfX040P5Nqvvv5ylDzz8Sro8d5Q6mBVUGWPUfIe2aR1PQfceESEjO
	 3NB0kgxwS0NHdDaTUpyFcv0X1ImErmJo69PHjawUOCLSAWzJO6VeUDHrB7CCh8ebhZ
	 2T8UsTSX+sfMs8GibUUBjG9/WY4psnW0R6yS4ALrYwWwTKzyzHt07YFctUIdZuTKES
	 r5V7K7uN+79Cg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v4 08/13] net: lan966x: add shutdown callback
 to stop FDMA on reboot
Reply-To: sashiko@lists.linux.dev
To: "Daniel Machon" <daniel.machon@microchip.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260508-lan966x-pci-fdma-v4-8-14e0c89d8d63@microchip.com>
References: <20260508-lan966x-pci-fdma-v4-8-14e0c89d8d63@microchip.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 09 May 2026 08:27:19 +0000
Message-Id: <20260509082719.94D72C2BCB4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] NULL Pointer Dereference in `lan966x_shutdown` due to uninitialize=
d NAPI structure.
- [High] Unsafe Teardown: Network Queues Reactivate DMA Engine across host =
reboot.
--

commit 416539af976fe45bd91d93198a7588ced579e467
Author: Daniel Machon <daniel.machon@microchip.com>

net: lan966x: add shutdown callback to stop FDMA on reboot

When lan966x is used as a PCIe endpoint, the FDMA engine runs on the
card and survives a host reboot. Without a shutdown callback, channels
stay active and interrupt sources stay armed across the reset.

[ ... ]

> diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_main.c b/driv=
ers/net/ethernet/microchip/lan966x/lan966x_main.c
> index b3701953b0905..271c023900dbe 100644
> --- a/drivers/net/ethernet/microchip/lan966x/lan966x_main.c
> +++ b/drivers/net/ethernet/microchip/lan966x/lan966x_main.c
> @@ -1311,9 +1311,27 @@ static void lan966x_remove(struct platform_device =
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

Could this race with a concurrent transmission and re-activate the DMA
engine across reboot?

Because the network device queues aren't stopped before disabling the TX pa=
th
(e.g., via netif_device_detach() or netif_tx_disable()), the networking sta=
ck
remains active during shutdown.

If a packet is transmitted concurrently or after the callback runs,
ndo_start_xmit() (lan966x_fdma_xmit()) will execute, acquire tx_lock, and c=
all
lan966x_fdma_tx_start(). Seeing that tx->activated is false, it will
unconditionally set it to true and call lan966x_fdma_tx_activate(tx).

This re-initializes and restarts the hardware DMA channel and explicitly
unmasks the FDMA_INTR_DB_ENA interrupts, which seems to defeat the purpose =
of
the shutdown callback.

> +
> +	napi_synchronize(&lan966x->napi);
> +	napi_disable(&lan966x->napi);

Does this napi_disable() call risk a NULL pointer dereference during shutdo=
wn?

If the device tree contains no active child nodes under the ethernet-ports
node, or if port initialization fails, lan966x_probe() still returns succes=
s.

In this configuration, lan966x->fdma is set to true (since the IRQ was
acquired), but lan966x_fdma_netdev_init() is never invoked. This leaves the
lan966x->napi structure zero-initialized, with napi.dev remaining NULL.

When napi_disable() executes, it locks the associated netdev via
netdev_lock(n->dev), which will crash when n->dev is NULL.

> +
> +	lan_wr(0, lan966x, FDMA_INTR_ENA);
> +	lan_wr(0, lan966x, FDMA_INTR_DB_ENA);
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260508-lan966x-pc=
i-fdma-v4-0-14e0c89d8d63@microchip.com?part=3D8
