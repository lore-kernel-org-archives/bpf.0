Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 652D625393E;
	Fri, 16 Oct 2026 14:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792162710; cv=none; b=a4j8EPqD53DMp4zwTIVEaLkneDKLvi36uQCJgc7mrdCafQajjJNXX3cHv6XmQlONOeAGXfCJnV/0o30h9qXpZpUGQ4vZ7W8C4jxLMNs0CKlAMo6vP+zloM8e7OWq3rQifqLFzcijmx9tJp8zdjtwVN68OJxuhUvHOFuYxIIiggU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792162710; c=relaxed/simple;
	bh=P+i/1P6kAVyRCsimt7I10I57QvG7dcXXak0hAzw9nPE=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=luGD8Xcj5bq4rVYXFQK9GlEBxJLhNSp0KHIE6HJmkB2Kb//ou6S4V/pAYpUIdOXjEDP55y9tZtCFRu+imzNh/LuURN7dLiETGoxcCHZERlHoVfoZvwGif7OmVGdg0FGBwH8zW5mgw7cpdmX9z2EqofLvGW+L9qfhqmd/XuKZohI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BofuF3E0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BofuF3E0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C56C51F000C4;
	Fri, 16 Oct 2026 14:58:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792162709;
	bh=NloS2JQ8zk67r6FG92N8ouwpSmvC4h1LM3iGLYFZXbE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BofuF3E0SnbBZba+pwhXjPk7yrZ6vFxvkZ03LaQczA3hqzlKAxeE+UUqVYg6yvIU6
	 ksPW6Q8Dfp6tDYzqYWE8uF2tGIU9QGKA6OLT6mXraF4n1e2ralk4yDH/8lgaRuLBFU
	 xj9Hvpoq2q2xRcZNzBZL31x7DnGCIywuiqPkOKh9nhSzr/k7npzpDWo62QB4QZUpau
	 F2gmqx7VU7UToeaygWpidh5IQc66mxn5JviO+ghTX4QpyzFn1JwjKAiB4MYf3jISNh
	 IT1sOkcnrTHFL0ZV8/LPYnaBDaLC0YjPHQAAFy5KZG+E6UeNvFokQh454VgKxR+rww
	 FiAQ89Q0bkLEQ==
Message-ID: <sashiko-outbox-174508@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v3 1/2] net: stmmac: Introduce group arguments
 for enable/disable_dma_irq
Reply-To: sashiko-reviews@lists.linux.dev
To: "Daniel Thompson" <daniel@riscstar.com>
Cc: bpf@vger.kernel.org, linux-sunxi@lists.linux.dev
In-Reply-To: <20261015-tc956x-stmmac-no_irq_teardown-v3-1-8189870be545@riscstar.com>
References: <20261015-tc956x-stmmac-no_irq_teardown-v3-0-8189870be545@riscstar.com>
 <20261015-tc956x-stmmac-no_irq_teardown-v3-1-8189870be545@riscstar.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 16 Oct 2026 14:58:28 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] net: stmmac: hardcoded generic OTHER masks break variant-specific =
IRQs
--

commit 6b53d33b472c115af2d55abc75c5663ee8048b05
Author: Daniel Thompson <daniel@riscstar.com>

net: stmmac: Introduce group arguments for enable/disable_dma_irq

The enable_dma_irq/disable_dma_irq functions take two booleans, rx and tx,
that identify which interrupts should be disabled. Replace these with a sin=
gle
bitflag argument, group. This allows a third group to be added which is use=
d to
enable/disable other sources of DMA interrupt.

> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac4_lib.c b/drivers/n=
et/ethernet/stmicro/stmmac/dwmac4_lib.c
> index a0249715fafaf..7c5881ca61e8b 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac4_lib.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac4_lib.c
[ ... ]
> @@ -109,30 +109,39 @@ void dwmac4_set_rx_ring_len(struct stmmac_priv *pri=
v, void __iomem *ioaddr,
>  	writel(len, ioaddr + DMA_CHAN_RX_RING_LEN(dwmac4_addrs, chan));
>  }
> =20
> +static u32 dwmac4_enable_dma_mask(u32 group)
> +{
> +	u32 mask =3D 0;
> +
> +	if (group & STMMAC_DMA_IRQ_RX)
> +		mask |=3D DMA_CHAN_INTR_ENA_RIE;
> +	if (group & STMMAC_DMA_IRQ_TX)
> +		mask |=3D DMA_CHAN_INTR_ENA_TIE;
> +	if (group & STMMAC_DMA_IRQ_OTHER)
> +		mask |=3D DMA_CHAN_INTR_DEFAULT_MASK &
> +			~(DMA_CHAN_INTR_ENA_RIE | DMA_CHAN_INTR_ENA_TIE);
> +
> +	return mask;
> +}

[Severity: High]
Does hardcoding DMA_CHAN_INTR_DEFAULT_MASK here cause a regression for
hardware variants that require different bit layouts for summary and abnorm=
al
interrupts?

For example, 4.10a uses a different mask DMA_CHAN_INTR_DEFAULT_MASK_4_10
during channel initialization, where AIE is BIT 14 rather than BIT 15. Since
the generic mask is used here, an attempt to disable STMMAC_DMA_IRQ_OTHER
interrupts could fail to clear the AIE bit on 4.10a hardware, potentially
causing an interrupt storm or use-after-free if unmasked interrupts fire
during XDP ring reconfiguration.

[ ... ]
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac_lib.c b/drivers/ne=
t/ethernet/stmicro/stmmac/dwmac_lib.c
> index a0383f9486c2d..d746527198546 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac_lib.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac_lib.c
[ ... ]
> +static u32 dwmac_enable_dma_mask(u32 group)
> +{
> +	u32 mask =3D 0;
> +
> +	if (group & STMMAC_DMA_IRQ_RX)
> +		mask |=3D DMA_INTR_DEFAULT_RX;
> +	if (group & STMMAC_DMA_IRQ_TX)
> +		mask |=3D DMA_INTR_DEFAULT_TX;
> +	if (group & STMMAC_DMA_IRQ_OTHER)
> +		mask |=3D DMA_INTR_DEFAULT_MASK &
> +			~(DMA_INTR_DEFAULT_RX | DMA_INTR_DEFAULT_TX);

[Severity: High]
Could this hardcoded mask also cause a regression for Loongson MACs?

Loongson hardware uses a custom mask layout DMA_INTR_DEFAULT_MASK_LOONGSON
because it has specific bits like NIS_TX (BIT 18) and NIS_RX (BIT 17). This
generic mask does not cover those bits, meaning they might remain enabled
when attempting to mask STMMAC_DMA_IRQ_OTHER interrupts.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261015-tc956x-stm=
mac-no_irq_teardown-v3-0-8189870be545@riscstar.com?part=3D1
