Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90D403F4DC5
	for <bpf@vger.kernel.org>; Sat, 10 Oct 2026 10:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791628038; cv=none; b=tEiR6NUUwJ7aa/EpOfLVr2YfRp+dxuTRpGDUyxYJ6y4FuYPmdVjeXINmsibOovCtqRvWn2Ku8S2X5g9VDXHZ7UBVcHHd6TOY00hQYsN2RLz6RBUMg6XPGtJ5N2qbvdWJr4eQMWyvoUV7qOK8FHtR7HTjD9I76tmxRuatmQBU1vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791628038; c=relaxed/simple;
	bh=pWP5PBYkwcVWOutJF9cySpUTaQdp4vuvQRLqEuxhY/8=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=R3ONg/0ej5sfjJCr4YVNJBISGE5HQZQtoGwWAOWnOsPJ5J91LY1YOoZs4u0epDp88U5RaQWz3ulaHK8/FeiBF649gxG9QTjr6Whs/u0u1TAfxTXt1VGw/6VqeuRI/K2OsNWrSE1HYRX/O0+/cM4TWDkNAqzTo6pYheM8tJrgWW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J+t83vsP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J+t83vsP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1ADC51F000FF;
	Sat, 10 Oct 2026 10:27:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791628037;
	bh=UAnv1DXK9olVbRaeCcy6p72v1eBX1TGvw2HuH3WKd7Y=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=J+t83vsPYhLIYQBYtcb8GeUWT5+zFLVzaxM5roFCNSmiEfUWGjGjoAXXx0950uWHP
	 AvOcnRH7RLV1OBDUwaiSdCgrrCD7DgzPp3eh55h+fRSGcdnZ1dE74xpXbatuyySQ7p
	 XDrUkbyyjaMso8KNfWDkPDcDmG9VEmbc9KBt1eVNmJK3SG2W7OClb6jkSNrW2YvCbs
	 eJ2WyHESmVxFMqJro7GFxGx7eKOBFwRnMduDqf0jmLX8SrlsFvqt9YUIWdFx0vEDV/
	 EUgRp7qPmBkMP2atvxzhyXkSmHmiJ4zMw8us6t4zO/qR62cEbA68CPBc64faWuWP+/
	 3VvhTk+ilRN5g==
Message-ID: <sashiko-outbox-166433@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v5 3/3] net: stmmac: allow non-linear xdp_buff
 in XDP mode
Reply-To: sashiko-reviews@lists.linux.dev
To: "Lorenzo Bianconi" <lorenzo.bianconi@oss.qualcomm.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20261009-stmmac-rx-mb-v5-3-c38fa4eaa138@oss.qualcomm.com>
References: <20261009-stmmac-rx-mb-v5-0-c38fa4eaa138@oss.qualcomm.com>
 <20261009-stmmac-rx-mb-v5-3-c38fa4eaa138@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 10 Oct 2026 10:27:16 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Critical] net: stmmac: AF_XDP Zero-Copy RX path data corruption with jum=
bo frames
- [High] net: stmmac: truncated jumbo frames passed to XDP ZC
- [Medium] net/stmmac: silent drop of jumbo frames with non-SG XDP
--

commit ea7721d2338075cf38b4bf936b99f96440c2eceb
Author: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>

net: stmmac: allow non-linear xdp_buff in XDP mode

This commit drops the checks that rejected attaching an XDP program when
the MTU is larger than ETH_DATA_LEN, and that refused to increase the MTU
while XDP is enabled. This allows XDP to operate on frames bigger than
ETH_DATA_LEN since the RX path now builds multi-buffer xdp_buffs.

> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/=
net/ethernet/stmicro/stmmac/stmmac_main.c
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -6351,12 +6351,6 @@ static int stmmac_change_mtu(struct net_device *de=
v, int new_mtu)
>  		txfifosz =3D priv->dma_cap.tx_fifo_size;
> =20
>  	txfifosz /=3D priv->plat->tx_queues_to_use;
> -
> -	if (stmmac_xdp_is_enabled(priv) && new_mtu > ETH_DATA_LEN) {
> -		netdev_dbg(priv->dev, "Jumbo frames not supported for XDP\n");
> -		return -EINVAL;
> -	}
> -
>  	new_mtu =3D STMMAC_ALIGN(new_mtu);

[Severity: Critical]
Does removing this MTU restriction expose the AF_XDP Zero-Copy RX path to
jumbo frames without multi-buffer support?

In stmmac_rx_zc(), when a jumbo frame arrives and spans multiple RX
descriptors, intermediate segments (where rx_not_ls is set) are dropped:

drivers/net/ethernet/stmicro/stmmac/stmmac_main.c:stmmac_rx_zc() {
    ...
    /* XSK pool expects RX frame 1:1 mapped to XSK buffer */
    if (likely(status & rx_not_ls)) {
        xsk_buff_free(buf->xdp);
        buf->xdp =3D NULL;
        dirty++;
        count++;
        goto read_again;
    }
    ...
}

However, the error flag is never set when dropping these intermediate
segments. When the final segment arrives (rx_not_ls is 0), it is processed
as a brand-new, valid packet because error is 0.=20

Since len was never accumulated, the segment length is calculated based on
the descriptor's total packet length. This artificially expands the XDP
buffer's data_end to encompass the full frame size, even though the hardware
only wrote the tail of the jumbo frame into this buffer.

Could this pass the tail of the jumbo frame, followed by uninitialized
user-space memory from the XSK pool, to the XDP program and network stack,
resulting in data corruption or an information leak?

> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_xdp.c b/drivers/n=
et/ethernet/stmicro/stmmac/stmmac_xdp.c
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_xdp.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_xdp.c
> @@ -109,14 +109,6 @@ int stmmac_xdp_set_prog(struct stmmac_priv *priv, st=
ruct bpf_prog *prog,
> =20
>  	if_running =3D netif_running(dev);
> =20
> -	if (prog && dev->mtu > ETH_DATA_LEN) {
> -		/* For now, the driver doesn't support XDP functionality with
> -		 * jumbo frames so we return error.
> -		 */
> -		NL_SET_ERR_MSG_MOD(extack, "Jumbo frames not supported");
> -		return -EOPNOTSUPP;
> -	}
> -
>  	if (!prog)
>  		xdp_features_clear_redirect_target(dev);

[Severity: Medium]
Should this check have been replaced with a validation against
prog->aux->xdp_has_frags rather than being removed entirely?

Removing this unconditionally allows a user to configure an MTU > 1500 while
a single-buffer XDP program is already loaded.

If a non-SG XDP program is attached and a jumbo frame arrives,
stmmac_xdp_run_prog() bypasses __stmmac_xdp_run_prog() for multi-buffer
packets:

drivers/net/ethernet/stmicro/stmmac/stmmac_main.c:stmmac_xdp_run_prog() {
    int res =3D STMMAC_XDP_CONSUMED;
    ...
    if (likely(!xdp_buff_has_frags(xdp) || prog->aux->xdp_has_frags))
        res =3D __stmmac_xdp_run_prog(priv, prog, xdp);
out:
    return ERR_PTR(-res);
}

Will this result in all jumbo traffic being silently dropped without warning
when a non-SG XDP program is attached?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261009-stmmac-rx-=
mb-v5-0-c38fa4eaa138@oss.qualcomm.com?part=3D3
