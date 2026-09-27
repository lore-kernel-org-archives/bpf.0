Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 823D6283FCE;
	Sun, 27 Sep 2026 15:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790524206; cv=none; b=sBNXG6L46MF/8Zvx6Dx+JVL5tiBiU4PcRA4VLPQT0BV1C7R/pyzMXLUo30U1daKCDlsZHak/koM1FlhYbliw/Ut4JWKVV35uFD1pCfhhlWd5tD7rf38syjbIMbRbRPvxR/2EMSI6x7RtJ/kF7jVm7+7KQxGzFwReXVGsyioaycs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790524206; c=relaxed/simple;
	bh=YFxNBK5aeDrvVDt9YPAj/1V/e0fYWSOgWbQN2AvUs3M=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=tgV6o4sQpYbvJDbl78EYF7+nZd7Aks85mp2wQie4Lyoncx6IntLlUnW77fMrfxNpkQm+RyalguHiPTHtwr6OL7hrfhkXGQmPdFemhbMmIfoAkV7jRknLsqNepxoM7mASKDYouiqyvysdLfi4QEucUMbONNjISDU6HUy2dpo19k8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bkF0I38M; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bkF0I38M"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE0A61F000FF;
	Sun, 27 Sep 2026 15:50:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790524205;
	bh=nlKTAoU1f99lRWqUhNL53qJBX5TgunD9FpTHd+gs2WU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bkF0I38Myr+pR3E2epcWjZwW5+7cx/draESF0G6tC1eFTzTK45moBIryM2s2YxdOH
	 Mf+7bUFriFnTGWc5ER627uZZOxhtFFK6xAlKtjF82iX6z4D3GO/Z9SVHKUxM/Y4MGk
	 NbS+UCysYGcXn0EqRKZq6gynRjUwsI5R0SbYUns1hYViQ7A/Pu+usVzU9rbAgKtdVr
	 DZp6lRJCWM7FDUrQ6aVlfId3W4Kx0t8q8xA6nV9HAvdD7gZ/YjGWCsOXMaHSwWhkvj
	 ZEsrkmtl2LiEPtmF7flYhv4s5VhDbQqnejjmcxJDqekoCcBCryZzfdH34a0zCVAEEA
	 1dkD6VGvbXhvg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v4 09/15] net: stmmac: track datapath and power
 ownership across failed reopening
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Hilliard" <james.hilliard1@gmail.com>
Cc: linux-sunxi@lists.linux.dev, bpf@vger.kernel.org
In-Reply-To: <20260926-submit-stmmac-reset-fixes-v1-v4-9-ec1c0250b3c9@gmail.com>
References: <20260926-submit-stmmac-reset-fixes-v1-v4-0-ec1c0250b3c9@gmail.com>
 <20260926-submit-stmmac-reset-fixes-v1-v4-9-ec1c0250b3c9@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 27 Sep 2026 15:50:04 +0000
Message-Id: <20260927155004.DE0A61F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] net: stmmac: IRQ storm and permanent disablement due to IRQ_NONE r=
eturn on wakeup
--

commit d1c65d817aaf24471fe20e2504c91eda25ba350f
Author: James Hilliard <james.hilliard1@gmail.com>

net: stmmac: track datapath and power ownership across failed reopening

This patch tracks datapath and power ownership for stmmac interfaces across
failed reopening attempts. It separates core sleep cleanup from platform
and clock restoration, adding guards to skip accessing unpowered MMIO
registers via a hw_unavailable flag.

> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/=
net/ethernet/stmicro/stmmac/stmmac_main.c
> index c4ba97d57b47e..22a65c1c16810 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
[ ... ]
> @@ -6377,6 +6571,12 @@ static irqreturn_t stmmac_interrupt(int irq, void =
*dev_id)
>  	struct net_device *dev =3D (struct net_device *)dev_id;
>  	struct stmmac_priv *priv =3D netdev_priv(dev);
> =20
> +	if (READ_ONCE(priv->hw_unavailable)) {
> +		if (priv->irq_wake)
> +			pm_wakeup_event(priv->device, 0);
> +		return IRQ_NONE;
> +	}
> +
>  	/* Check if adapter is up */
>  	if (test_bit(STMMAC_DOWN, &priv->state))
>  		return IRQ_HANDLED;

[Severity: High]
When the device is suspended with Wake-on-LAN enabled, will returning
IRQ_NONE here cause an interrupt storm?

If a magic packet wakes the system, it asserts the MAC's level-triggered
interrupt line. During the resume_noirq phase, the generic IRQ subsystem
unmasks the interrupt line and this handler is called.

Because hw_unavailable is still true until the later system resume callback
phase, this code returns IRQ_NONE without acknowledging the interrupt at the
MAC hardware or masking the IRQ line. For a level-triggered shared interrup=
t,
this causes the interrupt controller to immediately re-trigger, creating
an infinite IRQ storm that permanently disables the IRQ line.

[ ... ]
> @@ -6399,6 +6599,12 @@ static irqreturn_t stmmac_mac_interrupt(int irq, v=
oid *dev_id)
>  	struct net_device *dev =3D (struct net_device *)dev_id;
>  	struct stmmac_priv *priv =3D netdev_priv(dev);
> =20
> +	if (READ_ONCE(priv->hw_unavailable)) {
> +		if (priv->irq_wake)
> +			pm_wakeup_event(priv->device, 0);
> +		return IRQ_NONE;
> +	}
> +
>  	/* Check if adapter is up */
>  	if (test_bit(STMMAC_DOWN, &priv->state))
>  		return IRQ_HANDLED;

[Severity: High]
Does this dedicated MAC interrupt handler suffer from the same IRQ storm
issue as stmmac_interrupt above when returning IRQ_NONE during a wakeup
event?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260926-submit-stm=
mac-reset-fixes-v1-v4-0-ec1c0250b3c9@gmail.com?part=3D9
