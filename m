Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D1223B2FCA;
	Sun, 27 Sep 2026 15:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790524208; cv=none; b=bdhSae3VDkRz9ux4xxqtKxRdl1CZQUqaV74nFiIzbhUPPQrFwiXd/sULSz4S5qW3ZBuTIdYWs4NxLko92pWnqESpGm9ZtjH/iq0gTikLIyosi2Fy35dvjZLvqx4iqjiMG8CqC5rBbnyPFAK0TR526Z+irky3TD508S0G9S8GAqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790524208; c=relaxed/simple;
	bh=CEs8jJTg1IbI6xr9K1eZ9cZINfJQPvy3J0K9LwvAig4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=W2tY1Eo3saYVm9rUolEbPI5RDq/Uy+BzvLxzBDGZzMy4KKqISs5UrJ9k6vJSe4Pl4DdAFsL+lBIH5haEznahDPsesV3ohWzll+G5nPpW7wIwdPjU9UBMpDywEQ4yVVkH1khwcJYChxEUVRfFfoiwblxeHs3ZbQZNlsnfeKsG+SY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZljS/43Z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZljS/43Z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06FB61F000FF;
	Sun, 27 Sep 2026 15:50:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790524207;
	bh=0nMk8Z2X3+PO6Urp05IHH+Xi1G1Roa6nXTtbB9DZAb4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZljS/43Z7/ZJFJirfAWTc0xcCp40A/P5eyPXSiMtyLKxwrJxZ4fofJ6m3aQuXTczL
	 laKWzzcAf3cpMOMeTsLPVLFmWEwT0okWyxzH/6eI53AKqDNn5OAJYG4WTBQCP/gMw4
	 k5LICRVluMTt2X8jzUiuj9A7qePBo/7w+NmAnvL7BDtN2xhnXau+i154JVuewB7pcC
	 3QAaLizxRivAKMG/5nrXYlPKA9di8LuCpEkxR49fcBiOpoQGC8AGiNUTgWxJjplpwV
	 JhYnSoqcxVxAscV0uBxGEEoa1JARGBYUuVSD7Q33Nr2gqfi6S4AHdF3SeZ58SyKB4B
	 yQGBIuYvG4drQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v4 15/15] net: stmmac: retain DMA resources across
 MTU changes
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Hilliard" <james.hilliard1@gmail.com>
Cc: linux-sunxi@lists.linux.dev, bpf@vger.kernel.org
In-Reply-To: <20260926-submit-stmmac-reset-fixes-v1-v4-15-ec1c0250b3c9@gmail.com>
References: <20260926-submit-stmmac-reset-fixes-v1-v4-0-ec1c0250b3c9@gmail.com>
 <20260926-submit-stmmac-reset-fixes-v1-v4-15-ec1c0250b3c9@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 27 Sep 2026 15:50:06 +0000
Message-Id: <20260927155007.06FB61F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] net: stmmac: double disable of NAPI causing deadlock in stmmac_rec=
onfigure_mtu()
--

commit ed7896fe947ec45eb3dddd37b9ca9ed5f20ea4e9
Author: James Hilliard <james.hilliard1@gmail.com>

net: stmmac: retain DMA resources across MTU changes

This commit modifies the MTU change procedure to prepare the replacement
configuration before quiescing the old datapath. It retains the rings and I=
RQ
registrations until setup succeeds so rollback needs no new allocations, and
leaves the interface detached in a distinct HALTED state if rollback fails.

> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/=
net/ethernet/stmicro/stmmac/stmmac_main.c
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c

[ ... ]

> @@ -6601,6 +6651,109 @@ static void stmmac_set_rx_mode(struct net_device =
*dev)
>  	stmmac_set_filter(priv, priv->hw, dev);
>  }
> =20
> +static int stmmac_reconfigure_mtu(struct net_device *dev, int mtu)
> +{
> +	struct stmmac_priv *priv =3D netdev_priv(dev);
> +	struct stmmac_dma_conf *old_conf =3D priv->dma_conf;
> +	struct stmmac_dma_conf *new_conf;
> +	int old_mtu =3D dev->mtu;
> +	int ret, restore_ret;
> +	u32 irq_mask[STMMAC_CH_MAX];
> +	u32 chan;
> +
> +	new_conf =3D stmmac_setup_dma_desc(priv, mtu);
> +	if (IS_ERR(new_conf))
> +		return PTR_ERR(new_conf);
> +
> +	mutex_lock(&priv->ptp_mutex);
> +	stmmac_block_ptp(priv, true);
> +	netif_device_detach(dev);
> +	phylink_stop(priv->phylink);
> +	stmmac_quiesce(priv);

[Severity: High]
Does this unconditional call to stmmac_quiesce() lead to a double-disable of
NAPI if the interface is already in the HALTED state?

If stmmac_reconfigure_mtu() fails to rollback after a hardware setup error,
the interface state is set to STMMAC_DATAPATH_HALTED with NAPI left disable=
d,
but the device remains administratively up (netif_running(dev) remains true=
).

If an MTU change is attempted again, stmmac_change_mtu() will call
stmmac_reconfigure_mtu() a second time. This unconditional stmmac_quiesce()
call will invoke stmmac_disable_all_queues(), resulting in a second
napi_disable() on the already disabled NAPI instances. This can cause the
kernel to deadlock in napi_disable_locked() while waiting for
NAPIF_STATE_SCHED to clear.

> +	if (stmmac_fpe_supported(priv))
> +		ethtool_mmsv_stop(&priv->fpe_cfg.mmsv);

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260926-submit-stm=
mac-reset-fixes-v1-v4-0-ec1c0250b3c9@gmail.com?part=3D15
