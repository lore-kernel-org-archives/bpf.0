Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C496047ECC2
	for <bpf@vger.kernel.org>; Thu,  7 May 2026 19:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778181480; cv=none; b=uwOKgdw8fVX342en8W/xUCUAx10LImRHqxZhqs+qbnQ9Q8ryegd73yNrFnkE8etN+m/3m0HEtGlB2bmpjbyNN8dUGwaEzVlGYr56U4f+ybTiYomwSxSdzvB09zkMs6wJ3KMK/he0gLcEa9COHyYAX3v8/ruSDs9zPE6JHoWUBsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778181480; c=relaxed/simple;
	bh=viQrCw1rzzhdybo8am8tQgrGlbVjHmNfBLEgbQut7Z4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jglsrrqEz8mApO7vi9xykk2z1eCTRcmcL9gLoW+Fc2nrZTb7+7C/8zf/6Sxm+6ks8lBZ3JAcXEhxJxAvFQP5hpTmzhjQSW9uC/zk/4mdzqv9XWWFOV0sltVEhDd1lQPVmMlmp7n52doapaZVzisGvzlel+hGZt02VKlCw4S/ox8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Oq/QFBwu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Oq/QFBwu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82882C2BCB2;
	Thu,  7 May 2026 19:18:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778181480;
	bh=viQrCw1rzzhdybo8am8tQgrGlbVjHmNfBLEgbQut7Z4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=Oq/QFBwugagHIRrAF6uL63bTzeimme4eXdHLdZ7X53XStfeFDT8xpPoWNO0Kb4r6Q
	 2az5f13ybJGQOd9Pg5DR9S603z8FnImgNa1WLH5C5Z9azUYv8UHRO07spTxHhL8ttM
	 pakYXq4BwA3X6FY33ZfO7iFG9tJJ64Fru5J6UG7Hu9ufvpYm0auOhpcnXOeAM0os75
	 fUaD5fdMt1NraK9Gw65107QgUA7iY+4JNUWMCRhzKPr/ebRTvtthJ/4YKxC3RB/O/1
	 UC0rU2qHmuL0ml0+WcnzVNiuhHoq8YHFEzQxMPlwEub7oYlmoaTUtlU+x0hmQWF6kI
	 Ob9PNM/97aJlg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v9 7/7] net: bcmgenet: reject MTU changes
 incompatible with XDP
Reply-To: sashiko@lists.linux.dev
To: "Nicolai Buchwitz" <nb@tipi-net.de>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260506095553.55357-8-nb@tipi-net.de>
References: <20260506095553.55357-8-nb@tipi-net.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 07 May 2026 19:18:00 +0000
Message-Id: <20260507191800.82882C2BCB2@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The introduced `ndo_change_mtu` callback is entirely dead code base=
d on a false premise.
--

commit 4a63ea349d9dde80e552364564a8fc480bce7552
Author: Nicolai Buchwitz <nb@tipi-net.de>

net: bcmgenet: reject MTU changes incompatible with XDP

Add a minimal ndo_change_mtu that rejects MTU values too large for
single-page XDP buffers when an XDP program is attached.

> diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.c b/drivers/net=
/ethernet/broadcom/genet/bcmgenet.c
> --- a/drivers/net/ethernet/broadcom/genet/bcmgenet.c
> +++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
> @@ -4095,6 +4095,20 @@ static int bcmgenet_xdp_xmit(struct net_device *de=
v, int num_frames,
[ ... ]
> +static int bcmgenet_change_mtu(struct net_device *dev, int new_mtu)
> +{
> +	struct bcmgenet_priv *priv =3D netdev_priv(dev);
> +
> +	if (priv->xdp_prog && new_mtu > PAGE_SIZE - GENET_RX_HEADROOM -
> +	    SKB_DATA_ALIGN(sizeof(struct skb_shared_info))) {

Is this check actually reachable?

The networking core (dev_validate_mtu()) strictly enforces that any
requested MTU cannot exceed dev->max_mtu. Because the bcmgenet driver
does not manually override dev->max_mtu, it inherits the default value
of ETH_DATA_LEN (1500 bytes) set by ether_setup().

On a system with the minimum 4KB page size, the right side of this
condition evaluates to approximately 3400 bytes. Since new_mtu is
strictly bounded to 1500, the condition new_mtu > ~3400 seems
mathematically impossible to satisfy, rendering the check dead code.

Additionally, the driver statically configures the hardware MAC to a
maximum frame length of 1522 bytes (ENET_MAX_MTU_SIZE) and the DMA ring
to a maximum receive buffer length of 2048 bytes (RX_BUF_LENGTH). Thus,
a buffer overflow rewriting the skb_shared_info appears structurally
impossible even if the MTU check were somehow bypassed.

> +		netdev_warn(dev, "MTU too large for single-page XDP buffer\n");
> +		return -EINVAL;
> +	}
> +
> +	WRITE_ONCE(dev->mtu, new_mtu);
> +	return 0;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260506095553.5535=
7-1-nb@tipi-net.de?part=3D7
