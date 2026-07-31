Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04CE8438472
	for <bpf@vger.kernel.org>; Fri, 31 Jul 2026 15:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785510585; cv=none; b=k37Umy8SllavgVAytt0Q6Vj25kqUsYfAQleC/3dGzzxCRxr0n1+CWvBEd1nlSbdOGcoHh4tR49qQC2gkNMCQoRxa7wVjhHHIFCVIpbL+v3vlU6GIxFN8Km0bLXj/K7aMkZCgeQh1Z7iiP+USh2pp2+D1IYeVTFDqPmE58eAajTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785510585; c=relaxed/simple;
	bh=eZiApgxFk1DZXECZkRxqwx+YawPlxkFo1dBkd9X9dQg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=A69Ke0Vv+dMafFFUzFx/IawCM6hhtFH1TgFRtlnjCPEs+YWr11xeFEgDOvWTT/9akxxWLwdArwciADYQ3C4w3OjYyLLClcT6ubA7Kam8zaf/aTBICELsXWGLUtQYfnAaDcsRiYVNqMMcfObbhAP1LNXNXMQ9484tTVX/s9Fwuiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nQRkrZoP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nQRkrZoP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0A0E1F000E9;
	Fri, 31 Jul 2026 15:09:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785510580;
	bh=r6TRhTXKeUG6+nbuiS322O6M2UQ0KZqfHuV8bmh1f1o=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nQRkrZoPzVCBrtRN0V6gESPJlEvrtIkbk3U07f7W+YB2spQrPwnkjsQnsJXcUh/RY
	 fEDc14iXMgnc7f+nm01oWZ0cGuOaREbM+Vr/cG4ca6wOHm6dSqgVc8w9MO5zcXTR72
	 R1cvzApK4OGwKmbIGF6bdiF8o5CaQV5x4ZAvxJMolfdNNU2ALLyhEr4e29ZKIBnlUC
	 5reSHFpKL1Lkxuud1BOYugaBSzJA7NBQR2dlPmhptQiKwIIo5IEXRH94TWwNTBmqfp
	 4/jdkkvkYiYj1TbjxCMmcZAumKI2CVw5Ra55debjO49kSPOSPay7JYN3ayBmfdml20
	 ZhTyplaQvTFmA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v2] net: stmmac: Avoid freeing and
 re-requesting IRQ during XDP set prog
Reply-To: sashiko-reviews@lists.linux.dev
To: "Daniel Thompson" <daniel@riscstar.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260730-tc956x-stmmac-no_irq_teardown-v2-1-a6c31932ba84@riscstar.com>
References: <20260730-tc956x-stmmac-no_irq_teardown-v2-1-a6c31932ba84@riscstar.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 31 Jul 2026 15:09:39 +0000
Message-Id: <20260731150939.C0A0E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Critical] Removing `stmmac_free_irq()` leaves interrupt handlers active =
during XDP reconfiguration. Stopping the DMA engine triggers an unmasked ab=
normal interrupt that races with descriptor teardown, causing the error han=
dler `stmmac_tx_err()` to access freed DMA memory.
--

--- Patch [1]: [PATCH net-next v2] net: stmmac: Avoid freeing and re-reques=
ting IRQ during XDP set prog ---
commit 5d6c0328f64a95acf920d677c1576229f816f722
Author: Daniel Thompson <daniel@riscstar.com>

net: stmmac: Avoid freeing and re-requesting IRQ during XDP set prog

This patch modifies the XDP setup path in the stmmac driver to avoid freeing
and re-requesting IRQs. Instead of fully tearing down the interrupts, it
silences the DMA interrupts and synchronizes them before stopping the DMA
channels.

> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/=
net/ethernet/stmicro/stmmac/stmmac_main.c
> index 2a0d7eff88d3f..3cf436014686a 100644
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
Could this lead to a race condition and use-after-free in the interrupt
handler?

By replacing stmmac_free_irq() with stmmac_disable_all_dma_irq(), the OS-le=
vel
interrupt handlers remain active. Since stmmac_disable_all_dma_irq() only
disables normal RX/TX interrupts, abnormal interrupts remain unmasked.

When stmmac_stop_all_dma() is called immediately after, it halts the DMA en=
gine.
This sets the Transmit Process Stopped (TPS) status flag, which triggers an
unmasked abnormal hardware interrupt.

Because the handler is still registered, the interrupt fires and calls
stmmac_tx_err(), which accesses the DMA queues. Concurrently, the thread
executing stmmac_xdp_release() proceeds to call free_dma_desc_resources():

Thread 1 (stmmac_xdp_release):
    stmmac_stop_all_dma(priv);
    // TPS interrupt raised here
    free_dma_desc_resources(priv, ...);
    // Frees TX resources and socket buffers

Thread 2 (stmmac_interrupt):
    // Interrupt fires due to TPS error
    stmmac_tx_err(priv, chan);
    // Accesses and attempts to clean up the same freed DMA resources

Is there a way to safely mask abnormal interrupts as well before stopping t=
he
DMA channels to avoid this race?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260730-tc956x-stm=
mac-no_irq_teardown-v2-1-a6c31932ba84@riscstar.com?part=3D1
