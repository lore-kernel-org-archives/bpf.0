Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB0C635836E;
	Fri, 16 Oct 2026 14:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792162711; cv=none; b=aiWXDJgJnswaGHjG5E/tmb7U7v8Z7+ipcHix+AaV8CgL6ixMnGll2OeE/Ropc+xyePdlKESl75PE5dbVV2j2Q27ZxZAZ/Qy3OWNtlIEOlseXFKHrjQXz8sF6bW2LSAu6sTHX9j3hLt8GI6s6BkTcMtEkMBYB80wCTFbImN4bjIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792162711; c=relaxed/simple;
	bh=G+SPmLkBW1fXUjGyTjP32KXJfHC9PjVmZm3aijMhdBU=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=MksEEudDVO+4RaEMlkBNQRgbjkY4ImbOrwjZEYXDl/LyOickhVFqxAFKlXtyBnISiXIoVZwcuJ9wBV0wziVCgwSVy5eblotemq0e+YVKazQrMIVqQtQ/DAkZ1nOnECxLnkv0EBYZK2I/1KR/bLnvnJbW3NdO+sqOt9WF6o4q+S0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WVCcudLy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WVCcudLy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D8E71F000C5;
	Fri, 16 Oct 2026 14:58:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792162709;
	bh=WJb5qae4lmzBx/9CbIcNr6fNsbl7w9tJ+X/B74jHhtI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WVCcudLyAo9to0gzS0jX6T3rO1Gh2NfJ8lLL2VMvOQ1VAhYewylVTj0Q3NnIcU/wx
	 6s+okYtWe/Xb54JcrXDJR5Q+VDS5dM3cYse3H+7lyAIiyOq2fYt0vnLuFRv9FymV5s
	 tittv+gAjiUG26aMaAChI6W0OeEYP0eBOwU/ttPwCiwEH/SpeenmYzMMlvkQ/RPILk
	 aKz9tytxvpwEAZJ6dfs2ywcNjyK50Xfhvu6n6RaT5wet8V0oaRB5/d/z2fpAzmY9Vg
	 Aybmz/+CG2h+qe4bAuzmMBWn1DnQptop2KQt+vh8ud22JM1ORdOpK9ZfyAWlmTDRe+
	 FUwy0Vy+DCQaQ==
Message-ID: <sashiko-outbox-174509@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v3 2/2] net: stmmac: Avoid freeing and
 re-requesting IRQ during XDP set prog
Reply-To: sashiko-reviews@lists.linux.dev
To: "Daniel Thompson" <daniel@riscstar.com>
Cc: bpf@vger.kernel.org, linux-sunxi@lists.linux.dev
In-Reply-To: <20261015-tc956x-stmmac-no_irq_teardown-v3-2-8189870be545@riscstar.com>
References: <20261015-tc956x-stmmac-no_irq_teardown-v3-0-8189870be545@riscstar.com>
 <20261015-tc956x-stmmac-no_irq_teardown-v3-2-8189870be545@riscstar.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 16 Oct 2026 14:58:29 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] net: stmmac: Use-After-Free in stmmac_tx_err() due to active ISR a=
fter DMA descriptors freed
--

commit 4c2320440039ed3235615c60f92cbcfdc0584d5a
Author: Daniel Thompson <daniel@riscstar.com>

net: stmmac: Avoid freeing and re-requesting IRQ during XDP set prog

This commit changes the XDP setup process to avoid completely freeing and
re-requesting IRQs, which disrupts TSN thread tuning. Instead of calling
stmmac_free_irq(), it masks the DMA interrupts and synchronizes them during
XDP release.

> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/=
net/ethernet/stmicro/stmmac/stmmac_main.c
> index 7b80fe66cf199..f1359637007e2 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
[ ... ]
> @@ -7141,8 +7186,9 @@ void stmmac_xdp_release(struct net_device *dev)
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

[Severity: High]
Could this change introduce a use-after-free when setting up an XDP program?

Since the ISR stmmac_interrupt() remains registered after replacing
stmmac_free_irq(), the interrupt handler can still run if a shared IRQ or
unmasked MAC interrupt fires.

When stmmac_stop_all_dma() stops the TX DMA, it sets the TPS (Tx Process
Stopped) bit in the hardware DMA status register.

Immediately after this in stmmac_xdp_release(), free_dma_desc_resources()
is called, which frees the descriptor memory without assigning NULL.

If an interrupt fires at this point, stmmac_interrupt() reads the raw DMA
status and evaluates TPS regardless of whether DMA interrupts are masked:

drivers/net/ethernet/stmicro/stmmac/dwmac4_lib.c:dwmac4_dma_interrupt() {
    ...
    if (unlikely(intr_status & DMA_CHAN_STATUS_TPS)) {
        x->tx_process_stopped_irq++;
        ret =3D tx_hard_error;
    }
    ...
}

This unconditionally returns tx_hard_error, which then triggers
stmmac_tx_err() to execute.

drivers/net/ethernet/stmicro/stmmac/stmmac_main.c:stmmac_tx_err() {
    ...
    dma_free_tx_skbufs(priv, &priv->dma_conf, chan);
    stmmac_clear_tx_descriptors(priv, &priv->dma_conf, chan);
    ...
}

Will stmmac_tx_err() then try to clear and re-free the already freed
descriptors, resulting in a use-after-free?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261015-tc956x-stm=
mac-no_irq_teardown-v3-0-8189870be545@riscstar.com?part=3D2
