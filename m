Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8183F4CEE4B
	for <bpf@vger.kernel.org>; Wed, 14 Oct 2026 08:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791968269; cv=none; b=dzuRJaPV5L2VpnoOaLz2PgPd+heIut6tn4ssQetw7eD6jERBFwReGGPn1QnsCK3rTwVK5d1+BhzayWfdHqMHvM/P9rikiTO+inh8MmFx2DKJrR/6+caNuIC12z9rvY72YsvAN4AWYWDA/zvUPe06eiR52g/rNJluXySwSgMEE/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791968269; c=relaxed/simple;
	bh=0ZXEJaYbkUwQutY4qt4EydbiFZqJCeyaoNd2NGNwwgA=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=DoFZy/Y0wi0d6yjGgc1Bli0F9cDefA5/2oXInxhEJWeczvAbwfxkFCybraFI4chRUJ0d0mGirOQBzMKqn3Hkhgdnvbv8SqwD7EDNycr4lEVKPbfz72kLRxKjNaCv1lOKWqflnxYiWyjdaxgYr5XMxWPox+Vbf5Pj4UNKVHoudFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lXm/6V67; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lXm/6V67"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE7191F000FF;
	Wed, 14 Oct 2026 08:57:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791968266;
	bh=5kaMqEsXC2ndeaD4OSY+E11/RcBCY7fzLa20XI0kwC8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lXm/6V67SWj04g5s+PTjukb1mmwzE4+6/tEbbcb8wDYlKu0Ut1OEs9y+G6EJkt2U2
	 pVAYgzjw8D5xUdqLVHZCmwUVUGA0L+lrifrfdMRuySTicmqduMTrixiMw/SECipFt3
	 RzDb0dAgoyrT+NKabaqxpYtxzjfAzOKQTMGK5btAgmg0sNY9YpoeZOm4YK3F01iISw
	 bZ8zEY+M4pe53dcaR3e3GCkx1abOiOV5YhUTZ28ma+UT39yW+pVz9Agkt9kDOGl0YZ
	 4P9VrNTn52EqwJq/PPtm5kS/r1qSuLH6/2iJS5y6M1cYcOOAeXawU2D3npsDmNstr3
	 OEgc3zxu88jRg==
Message-ID: <sashiko-outbox-171051@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v3 2/2] net: stmmac: Stop Tx queue when
 (en|dis)abling XSK pools
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kurt Kanzenbach" <kurt@linutronix.de>
Cc: bpf@vger.kernel.org
In-Reply-To: <20261013-stmmac_xsk_crashes-v3-2-50fca7790af2@linutronix.de>
References: <20261013-stmmac_xsk_crashes-v3-0-50fca7790af2@linutronix.de>
 <20261013-stmmac_xsk_crashes-v3-2-50fca7790af2@linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 14 Oct 2026 08:57:46 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] net: stmmac: hardware UAF due to unconditional flush on stopped qu=
eue
--

commit ef870c171b8f7f53a01cef2bdd086a9bc0f02d35
Author: Kurt Kanzenbach <kurt@linutronix.de>

net: stmmac: Stop Tx queue when (en|dis)abling XSK pools

When enabling or disabling XSK pools in parallel to Tx traffic, kernel
crashes occur. This patch adds stopping of the Tx queue during the enabling
and disabling of XSK pools to prevent accessing freed Tx DMA descriptors.

> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/=
net/ethernet/stmicro/stmmac/stmmac_main.c
> index 2aa5a26954731..0e8ab2bd8f3e8 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -5216,6 +5216,10 @@ static int stmmac_xdp_xmit_xdpf(struct stmmac_priv=
 *priv, int queue,
>  	dma_addr_t dma_addr;
>  	bool set_ic;
> =20
> +	/* Ring may be torn down for an XSK pool switch */
> +	if (netif_tx_queue_stopped(netdev_get_tx_queue(priv->dev, queue)))
> +		return STMMAC_XDP_CONSUMED;
> +

[Severity: High]
Could this unconditional flush cause a hardware use-after-free regression?

While this protects stmmac_xdp_xmit_xdpf() from accessing descriptors when =
the
queue is stopped, stmmac_xdp_xmit() calls it in a loop and then uncondition=
ally
flushes if XDP_XMIT_FLUSH is set:

drivers/net/ethernet/stmicro/stmmac/stmmac_main.c:stmmac_xdp_xmit() {
    ...
	for (i =3D 0; i < num_frames; i++) {
		...
		res =3D stmmac_xdp_xmit_xdpf(priv, queue, frames[i], true);
		if (res =3D=3D STMMAC_XDP_CONSUMED)
			break;
		nxmit++;
	}

	if (flags & XDP_XMIT_FLUSH) {
		stmmac_flush_tx_descriptors(priv, queue);
		stmmac_tx_timer_arm(priv, queue);
	}
    ...
}

If stmmac_xdp_xmit() is called with XDP_XMIT_FLUSH during an AF_XDP pool sw=
itch,
it will break out of the loop but still call stmmac_flush_tx_descriptors().

Since stmmac_flush_tx_descriptors() calls stmmac_set_queue_tx_tail_ptr(), c=
ould
this write a stale physical address to the hardware DMA tail pointer while
stmmac_enable_tx_queue() is allocating new descriptors, causing the DMA eng=
ine
to fetch from freed memory?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261013-stmmac_xsk=
_crashes-v3-0-50fca7790af2@linutronix.de?part=3D2
