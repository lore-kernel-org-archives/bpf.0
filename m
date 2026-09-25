Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9C5D4D0A1F
	for <bpf@vger.kernel.org>; Fri, 25 Sep 2026 18:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790359872; cv=none; b=L4zoROcCkA5dmPLLKlZi3kocUzmSEzuDDv7+aPt5IONBW27jRw4GAPDtuY6ol9L0+58bJTTdeKOq6yQDfA5rxyz4cQKG12gHNn6rBL4wd7uJ0VuEXZHU7ZlWj5ZV6N+KapFHEVevoZnLTUesEfhaRx2C4c5Yw8d+Z5VMbimrrO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790359872; c=relaxed/simple;
	bh=KcD7iV4pneWDQ+xgNiGHiLCV3JCuyg3um0UR0GQVqFA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=fgdu3Tr6/0FZj0lBHKw0LtKLhBWpsnjjxM5FyRw1uenDWjYOrQ/nwjx2vmn8ahYGfyRpJUJ8IRBA+UREpEOIebe/8j1SRdq4h3a0lSoMyApEMYPy2WLH1+HMV+8MQNvJ2XNe0oqAYRDpdXATjEEaf/J02h1NEfTtW+y4Xhqzg4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=neN/5pK0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="neN/5pK0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 249841F000FF;
	Fri, 25 Sep 2026 18:11:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790359870;
	bh=2uP7EHEE5N1dFydFBjZvCsqXKF5QSyFwU7x1Ew8pguI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=neN/5pK0bsCDk6Jqv+oyoS0B7pnyujZtU72lqa3w6wS4PeNs/l5ResRjuIz02wyrh
	 i9D8R0ZZzqaRfxpe13fHwNf3c+/BORXAN3u+S67GNxovY4m7pMYqBnsq3fFT3wYwdY
	 4MztmtUZA9MrMDNFktxyL9dtsbmZjsi1G7P6tIjYD3vi0wz6161vn+KhM9+OODMpeb
	 bPSPQWoI1u0gSDmPEmGR2Ap9rOxMXERjQNy/vswmuGDHIy63Vskg6Pz5V0vK0k5gBw
	 GuzbgNYuIW6vqELPT5t/x0llwhpayLMYQFxU70MStwQL91p/BE3gz93cygt9PYCNoa
	 uibi16DXt+eyQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v3 10/10] net: stmmac: retain DMA resources across
 MTU changes
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Hilliard" <james.hilliard1@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260924-submit-stmmac-reset-fixes-v1-v3-10-c031e3f3a282@gmail.com>
References: <20260924-submit-stmmac-reset-fixes-v1-v3-0-c031e3f3a282@gmail.com>
 <20260924-submit-stmmac-reset-fixes-v1-v3-10-c031e3f3a282@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 25 Sep 2026 18:11:09 +0000
Message-Id: <20260925181110.249841F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] net: stmmac: Use-After-Free of TX hrtimers during MTU reconfigurat=
ion
- [High] net: stmmac: Shared interrupt line disruption via disable_irq()
--

commit 3f4df67ed0eaa758c59a612b2b520f3af55b5627
Author: James Hilliard <james.hilliard1@gmail.com>

net: stmmac: retain DMA resources across MTU changes

Releasing the current datapath before reopening with a new MTU loses the
working configuration when hardware setup fails. Keep the old rings and
IRQ registrations until replacement hardware setup succeeds, so an
ordinary setup error can restore the old MTU without allocating new rings
or requesting interrupts again.

> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/=
net/ethernet/stmicro/stmmac/stmmac_main.c
> index d17c68f55caf6..1a552455a633d 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c

[ ... ]

> @@ -4080,14 +4156,40 @@ static int stmmac_request_irq(struct net_device *=
dev)
>  	return ret;
>  }
> =20
> +/* Balance disable_irq()/enable_irq() for every registered IRQ, including
> + * shared lines. Unlike freeing and requesting IRQs, this cannot fail.
> + */
> +static void stmmac_set_irq_state(struct stmmac_priv *priv, bool enable)
> +{
> +	void (*set_state)(unsigned int) =3D enable ? enable_irq : disable_irq;
> +	struct stmmac_msi *msi =3D priv->msi;
> +	int irq =3D priv->dev->irq;
> +	u32 i;
> +
> +	set_state(irq);

[Severity: High]
Since dev->irq, priv->wol_irq, and priv->sfty_irq can be registered as
shared interrupt lines (IRQF_SHARED) in single IRQ mode, does using
disable_irq() here risk completely disrupting other unrelated devices
sharing the same interrupt line?

Could this suppress the interrupt at the controller level and lead to
system-wide instability or timeouts for those other devices?

[ ... ]

> @@ -6234,6 +6338,113 @@ static void stmmac_set_rx_mode(struct net_device =
*dev)
>  	stmmac_set_filter(priv, priv->hw, dev);
>  }
> =20
> +static int stmmac_reconfigure_mtu(struct net_device *dev, int mtu)
> +{

[ ... ]

> +	/* An IRQ can recover a TX error and restart a queue. Drain handlers
> +	 * before the final TX stop, and keep the registrations for rollback.
> +	 */
> +	stmmac_set_irq_state(priv, false);
> +	netif_tx_disable(dev);
> +	synchronize_net();
> +
> +	ret =3D stmmac_prepare_rx_buffers(priv);

[Severity: High]
If a TX error IRQ fires between the initial stmmac_quiesce() and the
stmmac_set_irq_state(priv, false) call here in stmmac_reconfigure_mtu(),
the queue can be restarted and stmmac_tx_timer_arm() will re-arm the TX
hrtimer.

However, this block appears to omit a final stmmac_stop_tx_queues(priv)
or hrtimer_cancel() call to disarm the TX hrtimers before freeing the
old configuration.

Does this mean the timer could remain queued when old_conf is freed,
potentially causing a use-after-free and a kernel panic?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260924-submit-stm=
mac-reset-fixes-v1-v3-0-c031e3f3a282@gmail.com?part=3D10
