Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B8C7279DCC
	for <bpf@vger.kernel.org>; Sat,  6 Jun 2026 15:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780760735; cv=none; b=YzuEbBq3v2w8B396nh7UoGTfhXnxC/UCoobiCMZwHNuORzKIJFuv6qNkhpiPo5j3is5yahV7tHjnxujzKIIZTLiKK46Wp0ZXF4emMcw1MDA1cjdmQDQCkFbpPjgUsn6102AvSslp/3exQAE9ZPgcZlzVzUxfpUITftJvxFGAR0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780760735; c=relaxed/simple;
	bh=B1m7vSBhs7ZQt4pIuro/i2PzVniJB3iFg2HDy1j6B88=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=WIBYkaJiRny/8qgnqurhfzREMllUCjpnHLVaEbDKBJh8EZdWsVtFGK0PKg4xQMWazTEHFOQbz1ZDS77DXm7lDwPa6l5oqYv7JQ0wp170+YVV4FkT/C6huyf/kHognmTNHyrlgjwppyor76fxkNt2wnjmGoVfuuG9u0oTneH86xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GAv8Go/6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GAv8Go/6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8BD81F00893;
	Sat,  6 Jun 2026 15:45:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780760734;
	bh=0K0hJOr1+kq6ZjJo0ctACYySApSsSapeznrhkfnQuFk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GAv8Go/6s6aZ48gK65NdJC9qGZ/jFxdjSfYZ1giyeWkIfmP8vYVNB8PXOGFSB+wje
	 wSsnLkOtWsuqcs57Z5TDXO2JCi+7fQMD6rXLWT0LYdlT/Bc7XeokrN/HJ5NsLlA4hj
	 qKJEWJpeu9M5hLy4/xaDrifx/xgW1VAkIOC9Yq2FYWVfyXLUny/LitFuSCoZ7pd6Ye
	 vjqsJUCkR1HpOkjgDsfrwjdXh7m60bQTieb46cvY/p2qz9nKqHZsYjuhvTBYNbDc3N
	 YhxchfdbkpHpvqITHJ8dCfyi2fDrl55CokorhTOk+qOzBNsHERJKTpSjBY0lgcq5ei
	 YNbrWfzaRhdLQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v4 2/4] net: mvpp2: limit XDP frame size to the RX
 buffer
Reply-To: sashiko-reviews@lists.linux.dev
To: "Til Kaiser" <mail@tk154.de>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260605154457.163304-3-mail@tk154.de>
References: <20260605154457.163304-3-mail@tk154.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 06 Jun 2026 15:45:33 +0000
Message-Id: <20260606154533.B8BD81F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] MTU change while XDP is loaded disables percpu_pools globally, cau=
sing NULL pointer dereference in XDP datapath.
--

commit 17d23d36e2ff657dddc4655e8e281c3847e806d4
Author: Til Kaiser <mail@tk154.de>

net: mvpp2: limit XDP frame size to the RX buffer

mvpp2 has short and long BM pools, and short pool buffers can be smaller
than PAGE_SIZE. The XDP path nevertheless initializes every xdp_buff with
PAGE_SIZE as frame size. This patch initializes the XDP buffer with
bm_pool->frag_size so XDP tailroom matches the actual buffer backing the
packet.

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

[Severity: High]
This is a pre-existing issue, but while looking at XDP buffer initializatio=
n,
is there a NULL pointer dereference in the XDP datapath if the MTU is chang=
ed?

If an MTU change occurs and the new MTU is larger than MVPP2_BM_LONG_PKT_SI=
ZE,
the driver disables percpu_pools globally:

drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c:mvpp2_change_mtu() {
	...
	if (MVPP2_RX_PKT_SIZE(mtu) > MVPP2_BM_LONG_PKT_SIZE) {
		if (priv->percpu_pools) {
			netdev_warn(dev, "mtu %d too high, switching to shared buffers", mtu);
			mvpp2_bm_switch_buffers(priv, false);
		}
	}
	...
}

Because priv->percpu_pools is global across the mvpp2 controller, this affe=
cts
all ports. However, mvpp2_bm_switch_buffers() does not detach the existing =
XDP
programs.

When a packet is subsequently received on a port with XDP attached, mvpp2_r=
x()
leaves the page pool pointer pp as NULL because port->priv->percpu_pools is
now false:

drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c:mvpp2_rx() {
	...
	if (port->priv->percpu_pools) {
		pp =3D port->priv->page_pool[pool];
		...
	} else {
		dma_dir =3D DMA_FROM_DEVICE;
		/* pp remains NULL */
	}
	...
	if (xdp_prog) {
		...
		ret =3D mvpp2_run_xdp(port, xdp_prog, &xdp, pp, &ps);
	...
}

If the XDP program drops the packet (XDP_DROP) or fails a redirect/tx actio=
n,
mvpp2_run_xdp() unconditionally dereferences the NULL pp pointer:

drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c:mvpp2_run_xdp() {
	...
	case XDP_DROP:
		page =3D virt_to_head_page(xdp->data);
		page_pool_put_page(pp, page, sync, true);
		ret =3D MVPP2_XDP_DROPPED;
		...
}

Can this lead to a kernel crash when page_pool_put_page() accesses the NULL
page pool pointer?

>  			xdp_prepare_buff(&xdp, data,
>  					 MVPP2_MH_SIZE + MVPP2_SKB_HEADROOM,
>  					 rx_bytes, true);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260605154457.1633=
04-1-mail@tk154.de?part=3D2
