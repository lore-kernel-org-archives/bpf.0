Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E927A2135AD
	for <bpf@vger.kernel.org>; Mon,  8 Jun 2026 13:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780926674; cv=none; b=RNkdFP8VvwintAMOOVdMgXBoDXPSZ4rfGBD3OJgHb5hqBtwugDDqF18mkOlhRNPlicV+nlOHJBXju7c9o5dz0bnEdAHFut9WTgT9yiXckj6uLSJeDNCork/xuC405BxcjUI81dfVDLWUAPk/i8pmaHonVszttJFQUQEDKAcv204=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780926674; c=relaxed/simple;
	bh=zqPEguX31sWWl9I0stIwjoyf4bllP9HfI7b6Fsx0iAA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Sq4H/rIyPlynhqkLE+4Ux2TRfEP0L5AWyQFxpfVaZgIrzduAOO2nahFRjsDOFJkPu3yyr3scAMppCV903vBBRbOQ023LMSjVd2DfVS6y0aQahcpNq66fef7/cQuWKgx7ii7emBlV8rN2HFmMYbrhEzYtFATyxxP4+eFFTmTwPgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eOQBxcx6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eOQBxcx6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AF451F00893;
	Mon,  8 Jun 2026 13:51:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780926672;
	bh=qn9yTRQpRdUs2Tx4+VglCH/bIvnDikNZMZh/aLDU7k0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eOQBxcx6PK+mH556c1XsqfmIk0p77lN20CKvswiLxkZn+vLdaLyayAKdRGM8EHUe1
	 TFYm9UEyai69YO1QjAQj0RURhA10u+z3ZWvDEF1yj6BHmYpVTb01A7V/a7UNLZtkbX
	 GB4WffX88CfZvaWBBoBXsOCRzpZKFSDsbgzMm9aCRNxxp1IILd8FYD53TtUqpyhrS+
	 k1SSlIDb3GPcn6MwhjPnNm/ZUJ4meuZvBx8oKwa0uNxqyxhtcuGMqNMAESB5vLbQuD
	 sFQXdZFfQ9QVCxQZjOXV6oyBD6x/Y5Wzs9EdlC4PFsWhNx2MXz4gVOsm3zLmJ7JvlX
	 iNYb0RQb3GPiA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v5 2/4] net: mvpp2: limit XDP frame size to the RX
 buffer
Reply-To: sashiko-reviews@lists.linux.dev
To: "Til Kaiser" <mail@tk154.de>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260607134943.21996-3-mail@tk154.de>
References: <20260607134943.21996-3-mail@tk154.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 08 Jun 2026 13:51:11 +0000
Message-Id: <20260608135112.1AF451F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Changing MTU to a value > 1664 silently disables per-CPU pools whi=
le leaving XDP programs attached, leading to a NULL pointer dereference whe=
n XDP drops or redirects packets.
--

commit de2e76bdbee6c2ad0c3dc5a24f4854767f944f85
Author: Til Kaiser <mail@tk154.de>

net: mvpp2: limit XDP frame size to the RX buffer

mvpp2 has short and long BM pools, and short pool buffers can be smaller
than PAGE_SIZE. The XDP path nevertheless initializes every xdp_buff with
PAGE_SIZE as frame size.

> diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c b/drivers/ne=
t/ethernet/marvell/mvpp2/mvpp2_main.c
> index 92a701f4fe3f5..3372ed27cc8d6 100644
> --- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
> +++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
> @@ -3979,7 +3979,7 @@ static int mvpp2_rx(struct mvpp2_port *port, struct=
 napi_struct *napi,
>  			else
>  				xdp_rxq =3D &rxq->xdp_rxq_long;
> =20
> -			xdp_init_buff(&xdp, PAGE_SIZE, xdp_rxq);
> +			xdp_init_buff(&xdp, bm_pool->frag_size, xdp_rxq);
>  			xdp_prepare_buff(&xdp, data,
>  					 MVPP2_MH_SIZE + MVPP2_SKB_HEADROOM,
>  					 rx_bytes, true);

[Severity: High]
This isn't a bug introduced by this patch, but could this lead to a NULL
pointer dereference in the XDP path?

If the MTU is changed to a value > 1664 on another port, mvpp2_change_mtu()
globally disables per-CPU pools:

drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c:mvpp2_change_mtu() {
    ...
	if (priv->percpu_pools) {
		netdev_warn(dev, "mtu %d too high, switching to shared buffers", mtu);
		mvpp2_bm_switch_buffers(priv, false);
	}
    ...
}

This leaves other ports with their XDP programs still attached but without
per-CPU pools. When a packet arrives, mvpp2_rx() leaves pp as NULL:

drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c:mvpp2_rx() {
    ...
		if (port->priv->percpu_pools) {
			pp =3D port->priv->page_pool[pool];
			dma_dir =3D page_pool_get_dma_dir(pp);
		} else {
			dma_dir =3D DMA_FROM_DEVICE;
		}
    ...
}

Shortly after xdp_prepare_buff() in mvpp2_rx(), mvpp2_run_xdp() is called
with the NULL pp. If the XDP program drops or redirects the packet, does
mvpp2_run_xdp() pass the NULL pp to page_pool_put_page(), causing a panic?

drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c:mvpp2_run_xdp() {
    ...
	case XDP_DROP:
		ret =3D MVPP2_XDP_DROPPED;
		page =3D virt_to_head_page(xdp->data);
		page_pool_put_page(pp, page, sync, true);
    ...
}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260607134943.2199=
6-1-mail@tk154.de?part=3D2
