Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C80A2409289
	for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 23:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790206100; cv=none; b=SgTIHMrvpxgjjw5DtQfdfO5ZCjbOjn8vbVkdmaBUFOOsohaKh7Tq8vtraWoifNj0ge8zAuc7iwtEsaFAZtPfiANCVwKAbBTChksnR6gJbGeH7yAd+eEu+/cOU3gO3TL3BuVcmO8vbwx9WXbnMymcVIHun8nZjL2zT/9+M+Gsfu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790206100; c=relaxed/simple;
	bh=9ZGgdwQk6qx9cSuKLajqKnYGTnnEpABbSIcruzsTVQc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=LURxMImZ8hM6xN3guBk508EPJIVHG1OYkXGaxS2VPzH3Kr0R73x0fJgrl2soduiEX9LiL09Refn+msdYwF7KeMd221bNgYb3qZZXvak2jxmeOPB7PxwYLoeC/y4QzxjwtmFViHI5c04GdCyvJC8icDwVppGAyEQso/+FtfOpDR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mn9HLSWk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mn9HLSWk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 301301F000FF;
	Wed, 23 Sep 2026 23:28:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790206099;
	bh=RlBxlVIg4GrAezssJ1fK264Rq7TCIcdyKOmCM+/Oue4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Mn9HLSWkkwSoR+qVO9WqpvMys5FxnGBfbLG7htBlBCSPQZLYRH+uKYgquLxXwZJQy
	 Dc+AR9NPhPQi2sLmAIaOCvUO5sNR0Hc5umMlTK9IGOrm/XSmsyvPkh9Hgkzeu5WMj3
	 wQkLLbyG3jPov7oHZ1AKq5TFfY5hjNuBW5OCbVnALA3/S9RZq3qrI5sCmOC76LevzK
	 UaxxxrGX97k5XzGTWX+vqU4k34UgDngBRy4++rT8fDFMBAHgu5dY4bOQx7Qnx6DEry
	 aB68mZnX/XG6oSHwabZhDwgtlBcu6hKSPMIhAKCXYzYyE0/wonaizlRDg4GpNooTaJ
	 sq0D7QfPCMadQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v2 2/2] net: stmmac: keep datapath state coherent
 after reinitialization failure
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Hilliard" <james.hilliard1@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260922-submit-stmmac-reset-fixes-v1-v2-2-d92e609be996@gmail.com>
References: <20260922-submit-stmmac-reset-fixes-v1-v2-0-d92e609be996@gmail.com>
 <20260922-submit-stmmac-reset-fixes-v1-v2-2-d92e609be996@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Sep 2026 23:28:18 +0000
Message-Id: <20260923232819.301301F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] net: missing netif_device_attach() on successful MTU retry leaves =
interface detached
- [Medium] pm: missing hardware suspend on system sleep after failed MTU ch=
ange
--

commit aa909a318d1e4379c0a0ad905cb393e855cd5906
Author: James Hilliard <james.hilliard1@gmail.com>
Date:   Tue Sep 22 23:27:41 2026 +0000

    net: stmmac: keep datapath state coherent after reinitialization failure
   =20
    An MTU change releases the running datapath before reopening it. If the
    reopen fails, its replacement DMA resources are freed, but the netdev is
    still administratively up. A later close repeats NAPI shutdown, IRQ
    release and DMA cleanup. Hardware resume failure has a different partial
    state: suspend disabled NAPI but retained the IRQs and DMA resources, so
    ordinary close can hang in a second napi_disable().

> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/=
net/ethernet/stmicro/stmmac/stmmac_main.c
> index 1fb5f804ea234..7b423c87314ca 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
[ ... ]
> @@ -6174,6 +6192,11 @@ static int stmmac_change_mtu(struct net_device *de=
v, int new_mtu)
>  		if (ret) {
>  			free_dma_desc_resources(priv, dma_conf);
>  			kfree(dma_conf);
> +			/*
> +			 * Keep the administrative state and PHY/PM ownership until
> +			 * ndo_stop(), but prevent use of the released data path.
> +			 */
> +			netif_device_detach(dev);
>  			netdev_err(priv->dev, "failed reopening the interface after MTU chang=
e\n");
>  			return ret;
>  		}

[Severity: High]
Does stmmac_change_mtu() need to call netif_device_attach(dev) on the
success path?

If an MTU change fails, netif_device_detach(dev) administratively disables
the datapath while keeping netif_running() true. If the user then retries
changing the MTU and it succeeds, __stmmac_open() restores the datapath,
but netif_device_attach(dev) is never called.

Because the interface remains permanently detached (__LINK_STATE_PRESENT is
false), the networking core and XDP routines will refuse to queue or
transmit packets. The interface will silently drop traffic despite a
successful MTU configuration, requiring a manual down/up cycle to recover.

[ ... ]
> @@ -8198,26 +8246,24 @@ int stmmac_suspend(struct device *dev)
>  {
>  	struct net_device *ndev =3D dev_get_drvdata(dev);
>  	struct stmmac_priv *priv =3D netdev_priv(ndev);
> -	u8 chan;
> =20
> -	if (!ndev || !netif_running(ndev))
> +	rtnl_lock();
> +	if (priv->datapath !=3D STMMAC_DATAPATH_RUNNING) {
> +		rtnl_unlock();
>  		goto suspend_bsp;
> +	}

[Severity: Medium]
Will this bypass the hardware suspend sequence during system sleep if the
datapath is STMMAC_DATAPATH_DOWN following a failed MTU change?

If stmmac_change_mtu() fails, the datapath state becomes
STMMAC_DATAPATH_DOWN, but the interface remains administratively UP. The
error path of __stmmac_open() does not power down the SerDes, and
stmmac_change_mtu() intentionally retains PHY/PM ownership to allow a
retry.

When the system subsequently suspends, stmmac_suspend() skips the hardware
suspend sequence entirely because priv->datapath !=3D STMMAC_DATAPATH_RUNNI=
NG.

Consequently, the device skips stmmac_legacy_serdes_power_down(),
pinctrl_pm_select_sleep_state(), and Wake-on-LAN configuration
(stmmac_pmt()). This leaves hardware actively powered during system sleep,
which could block deep sleep states and break Wake-on-LAN.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260922-submit-stm=
mac-reset-fixes-v1-v2-0-d92e609be996@gmail.com?part=3D2
