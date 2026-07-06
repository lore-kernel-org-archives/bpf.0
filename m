Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A57A7433BA5
	for <bpf@vger.kernel.org>; Mon,  6 Jul 2026 16:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783355878; cv=none; b=CeFKNuyB5IxQ47MEcs3xd1SbY/TaLoGe4lY6eCYxrkGoAm0YGisKL3hn0S1FJENU0z1ZmiwJenHPnbxz7oejIhIIRFb2oUEsjEr3ORhy1NyAjpbLsIWXTemZXxDh3hi+LH/ydIKbpBzTNO86dKmf+q3+4A+CJZP/rr9xey9nHLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783355878; c=relaxed/simple;
	bh=Ycwm9aKV7o6TSHrHztWDYMq8TnrbkiBQ2SEpKlh51KQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=IbGyoHw3bThOsG2wYK8xHB075lvWCzBQl4xEl/XojVcEv7eGQFT3LBlFO88gGIA4h/kM4uh/G65Ca3/8eilYkDepLKNg7zRMV5BD09oPzw/gKGNc8Qzk3ZPYoLHG30OEvIOxD1tFfELxnnk+sGey+k4Dd7ECCWnUopC/bA/WgUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bB9OVlLc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bB9OVlLc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B9F31F000E9;
	Mon,  6 Jul 2026 16:37:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783355876;
	bh=qHHv0HbXP8pawR6tEF1libX0AV5XiOFvo2xHFm90CJ4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bB9OVlLcIUKCDm4VqLss4pXABsBQGP6lGAnqHPrO3lLggIQSJFzG3U4hcsJNCyXQz
	 H7/JvNFU7xJ5MWYWRwnkeynlC5FiGW4uL8IroZ1k6ZcnkjFlnYQhPJQ2glF0UWoTXt
	 bc27owD0ggBVo6eZyJ1vDl0J+P2eFmd3zBk86qPJQJmzVmkMZh0o7emo+xTyV9UPAd
	 xkcHPA21ebBPYPXY4RvJQQSZcJY0Y9ukRlY3EBzr7ZbSHIxXkQb/d5Y18dtacUzU9f
	 eTAkUArGH/UO35GgdSwUJvzZHov1WUDIzA1iEp9hEEDMdEwCBI0f2zFtXPDze/8eOx
	 Q76+QFZX0NqcQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] net: stmmac: Avoid freeing and re-requesting IRQ during
 XDP set prog
Reply-To: sashiko-reviews@lists.linux.dev
To: "Daniel Thompson" <daniel@riscstar.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260706-tc956x-stmmac-no_irq_teardown-v1-1-df009d0272bf@riscstar.com>
References: <20260706-tc956x-stmmac-no_irq_teardown-v1-1-df009d0272bf@riscstar.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 06 Jul 2026 16:37:55 +0000
Message-Id: <20260706163756.6B9F31F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [High] Removing `stmmac_disable_dma_irq()` during XDP open leaves DMA int=
errupts unmasked before NAPI is enabled, leading to lost wakeups and potent=
ial interrupt storms.

Pre-existing issues:
- [Critical] Concurrent `ndo_xdp_xmit` access during XDP reconfiguration ca=
uses UAF of DMA descriptors.
- [High] The return value of `stmmac_xdp_open()` is ignored in `stmmac_xdp_=
setup_prog()`, leading to a silent network outage if reopening the device f=
ails.
--

commit 28a5a0b2fab7c42eb59936b760afc9e0ec09c6ef
Author: Daniel Thompson <daniel@riscstar.com>

net: stmmac: Avoid freeing and re-requesting IRQ during XDP set prog

This commit removes the implicit IRQ synchronization by omitting calls to
stmmac_free_irq() and stmmac_request_irq() during XDP program setup. It
instead explicitly disables DMA interrupts and synchronizes the IRQ handler
to prevent tearing down and restarting IRQ threads, which disrupts TSN
system tuning.

> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/=
net/ethernet/stmicro/stmmac/stmmac_main.c
> index 2a0d7eff88d3f..acd145f1f3069 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c

[ ... ]

> @@ -7108,8 +7152,9 @@ void stmmac_xdp_release(struct net_device *dev)
>  	for (chan =3D 0; chan < priv->plat->tx_queues_to_use; chan++)
>  		hrtimer_cancel(&priv->dma_conf.tx_queue[chan].txtimer);
> =20
> -	/* Free the IRQ lines */
> -	stmmac_free_irq(dev, REQ_IRQ_ERR_ALL, 0);
> +	/* Silence DMA interrupts */
> +	stmmac_disable_all_dma_irq(priv);
> +	stmmac_synchronize_irq(dev);
> =20
>  	/* Stop TX/RX DMA channels */
>  	stmmac_stop_all_dma(priv);

[Severity: Critical]
This is a pre-existing issue, but does freeing the DMA descriptor rings
shortly after this point (via free_dma_desc_resources) cause a
use-after-free if ndo_xdp_xmit runs concurrently?

While stmmac_xdp_release() calls netif_tx_disable(), this does not stop
stmmac_xdp_xmit() from executing. If an XDP redirect occurs exactly while
the program is being detached, could stmmac_xdp_xmit() proceed and access
the freed tx_q->dma_tx array? It appears stmmac_xdp_xmit() only checks
STMMAC_DOWN, which is not set during XDP reconfiguration.

[ ... ]

> @@ -7156,10 +7201,8 @@ int stmmac_xdp_open(struct net_device *dev)
>  	stmmac_reset_queues_param(priv);
> =20
>  	/* DMA CSR Channel configuration */
> -	for (chan =3D 0; chan < dma_csr_ch; chan++) {
> +	for (chan =3D 0; chan < dma_csr_ch; chan++)
>  		stmmac_init_chan(priv, priv->ioaddr, priv->plat->dma_cfg, chan);
> -		stmmac_disable_dma_irq(priv, priv->ioaddr, chan, 1, 1);
> -	}
> =20
>  	/* Adjust Split header */
>  	sph_en =3D (priv->hw->rx_csum > 0) && priv->sph_active;

[Severity: High]
When stmmac_disable_dma_irq() is removed here, stmmac_init_chan() still
unmasks interrupts at the hardware level. Does this leave the DMA interrupts
unmasked before NAPI is enabled?

Since the OS IRQ is now permanently active (not freed during release), could
a packet arriving right after stmmac_start_all_dma() fire an interrupt
before stmmac_enable_all_queues() has run? It looks like this might cause
the interrupt service routine's call to napi_schedule_prep() to fail,
leading to a lost wakeup or an interrupt storm.

[ ... ]

[Severity: High]
This is a pre-existing issue, but I noticed that in stmmac_xdp_setup_prog()
in drivers/net/ethernet/stmicro/stmmac/stmmac_xdp.c, the return value of
stmmac_xdp_open() is ignored:

drivers/net/ethernet/stmicro/stmmac/stmmac_xdp.c:stmmac_xdp_setup_prog() {
    ...
    if (if_running && need_update)
        stmmac_xdp_open(dev);

    if (prog)
        xdp_features_set_redirect_target(dev, false);

    return 0;
}

If stmmac_xdp_open() fails (for example, due to a memory allocation failure
for DMA rings), it returns a negative error code. Does ignoring this error
mask the initialization failure and leave the interface functionally down,
potentially leading to a silent network outage?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706-tc956x-stm=
mac-no_irq_teardown-v1-1-df009d0272bf@riscstar.com?part=3D1
