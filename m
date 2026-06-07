Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA62F32ABC0
	for <bpf@vger.kernel.org>; Sun,  7 Jun 2026 15:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780845181; cv=none; b=avA+Q2TZHoJsahrcju/es2489yecDHVkjt1k4wFwp0Wa6BWOdaOqyjCD0D3U0kwM19AxHjj5s1KeLV7nAXrd+wLnt311ZO9EtY0h4WWvoMVrkNX8/1STEF4H4BbOmdJRXdoVlcb3C4O8e2gwr1NuyyRCXfcB+zTb6pt/n0f+bD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780845181; c=relaxed/simple;
	bh=N+gI735G6uWSV3X6+Hq/Gg7PI7f1+u9vNAo4FbZFKQ4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Ew25IEBQMlAjfUxWca+298nxmq1dQ8G3mgUAqeFxlON5uUkhwO9aXiekSt+azB/Qu8yzglAwDVv5aZSIxZppB518pKP3wYpIQG5qXQ5C3zNz4vwfYBlvdyA3hUhb0nTyo78br2vYFZ06+ZtzqqabjA4XrPcki2TP11wA71Ymydc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KEIGPvg+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KEIGPvg+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 736A71F00893;
	Sun,  7 Jun 2026 15:12:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780845179;
	bh=ebNYxYcRc+8pezudCJsL4OZzkrVFSi1oTn2NodCT/hk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KEIGPvg+tV5nApXSj8raBnQeVn/+IMr2of0lmfw1AYe6VSLYYiovLSbbIuftoJl3V
	 0z4gOhUobXACFpR0+pbtxF+Q5jIie3WGQp0/KgQKsnkGIVxW3qVb/z81WJWgY0RUIR
	 iXw1U+FaghBgXzCKmxs3Nt5EspiOVWC5cX/VsbGq6Wnmyo+UaKETvx6rT39IF4smJ2
	 6w30ZhMujPkj6U+OCf7IP/ct9ciLrvZF6TIABHQ9e0PMsk2djUcvUbP3hL1z8be/dl
	 Bb9IrRKhG1HS2NSEYB9NNstbNwHcLBjBoG1+YnrpEYgJ1KR4bOa/dB/hawdcVjP8Mz
	 B/d+8BlhT8G1w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] net: lan966x: restore RX state on reload failure
Reply-To: sashiko-reviews@lists.linux.dev
To: "Guangshuo Li" <lgs201920130244@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260607145747.1494514-1-lgs201920130244@gmail.com>
References: <20260607145747.1494514-1-lgs201920130244@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 07 Jun 2026 15:12:59 +0000
Message-Id: <20260607151259.736A71F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

New issues:
- [High] The return value of xdp_rxq_info_reg_mem_model() is ignored, leavi=
ng XDP queues without a valid memory model if registration fails.

Pre-existing issues:
- [High] lan966x_fdma_rx_alloc() ignores the return value of fdma_dcbs_init=
(), leading to hardware DMA into uninitialized memory if allocation fails.
- [High] lan966x_fdma_reload() fails to update rx->fdma.db_size during MTU =
changes, causing frames to be truncated.
- [High] Snapshotting the RX ring state before disabling NAPI creates a rac=
e condition leading to Use-After-Free and memory leaks.
--

commit 8b6a1ed08092bd9d26dff38bd133b141c326226a
Author: Guangshuo Li <lgs201920130244@gmail.com>

net: lan966x: restore RX state on reload failure

This commit saves and restores rx->page_order, rx->max_mtu, and per-port
XDP RXQ mem model registrations during a failed RX MTU reload. It attempts
to keep the restored RX state consistent when lan966x_fdma_rx_alloc() fails.

> diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c b/driv=
ers/net/ethernet/microchip/lan966x/lan966x_fdma.c
> index f8ce735a7fc09..8272ad0851508 100644
> --- a/drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c
> +++ b/drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c
> @@ -815,6 +815,7 @@ static int lan966x_fdma_reload(struct lan966x *lan966=
x, int new_mtu)
>  	struct page *(*old_pages)[FDMA_RX_DCB_MAX_DBS];
>  	struct page_pool *page_pool;
>  	struct fdma fdma_rx_old;
> +	int page_order, max_mtu;
>  	int err, i, j;
> =20
>  	old_pages =3D kmemdup(lan966x->rx.page, sizeof(lan966x->rx.page),
> @@ -825,6 +826,8 @@ static int lan966x_fdma_reload(struct lan966x *lan966=
x, int new_mtu)
>  	/* Store these for later to free them */
>  	memcpy(&fdma_rx_old, &lan966x->rx.fdma, sizeof(struct fdma));
>  	page_pool =3D lan966x->rx.page_pool;
> +	page_order =3D lan966x->rx.page_order;
> +	max_mtu =3D lan966x->rx.max_mtu;
> =20
>  	napi_synchronize(&lan966x->napi);
>  	napi_disable(&lan966x->napi);

[Severity: High]
This is a pre-existing issue, but does snapshotting the RX ring state before
disabling NAPI create a race condition?

If the NAPI poll loop runs concurrently on another CPU during this window, =
it
can process packets, pass some of the old pages to the network stack, and
allocate new pages into rx->page.

Later, the driver iterates over the stale old_pages snapshot and frees them
to the page pool. This could double-free the pages that were consumed by the
network stack. Additionally, any new pages allocated by NAPI after the
snapshot might be completely absent from old_pages and thus leaked.

[ ... ]

> @@ -854,7 +857,24 @@ static int lan966x_fdma_reload(struct lan966x *lan96=
6x, int new_mtu)
>  	return 0;
>  restore:
>  	lan966x->rx.page_pool =3D page_pool;
> +	lan966x->rx.page_order =3D page_order;
> +	lan966x->rx.max_mtu =3D max_mtu;

[Severity: High]
This isn't a bug introduced by this patch, but does lan966x_fdma_reload() f=
ail
to update rx->fdma.db_size during MTU changes?

When changing the MTU, the driver updates rx->page_order and rx->max_mtu, b=
ut
fails to update rx->fdma.db_size (which was initially calculated in
lan966x_fdma_init() as PAGE_SIZE << rx->page_order).

Consequently, the subsequent call to fdma_dcbs_init() configures the hardwa=
re
descriptors with the old db_size. If the user increases the MTU, the hardwa=
re
will still restrict DMA to the old buffer size, which could silently trunca=
te
larger frames.

[Severity: High]
This is also a pre-existing issue, but does lan966x_fdma_rx_alloc() ignore =
the
return value of fdma_dcbs_init()?

drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c:lan966x_fdma_rx_alloc=
() {
    ...
	fdma_dcbs_init(fdma, FDMA_DCB_INFO_DATAL(fdma->db_size),
		       FDMA_DCB_STATUS_INTR);

	return 0;
}

If page allocation fails within fdma_dcbs_init(), it aborts and returns
-ENOMEM. However, lan966x_fdma_rx_alloc() ignores this return value and
returns 0. The hardware RX ring is then started with uninitialized DMA
descriptors (containing physical address 0), which could cause silent memory
corruption when the hardware DMAs packets into address 0.

>  	memcpy(&lan966x->rx.fdma, &fdma_rx_old, sizeof(struct fdma));
> +	/*
> +	 * lan966x_fdma_rx_alloc_page_pool() registered the new pool with
> +	 * each port's XDP RXQ before the allocation failed. The new pool is
> +	 * destroyed by lan966x_fdma_rx_alloc(), so restore the old pool's
> +	 * registration before restarting RX.
> +	 */
> +	for (i =3D 0; i < lan966x->num_phys_ports; i++) {
> +		if (!lan966x->ports[i])
> +			continue;
> +
> +		xdp_rxq_info_unreg_mem_model(&lan966x->ports[i]->xdp_rxq);
> +		xdp_rxq_info_reg_mem_model(&lan966x->ports[i]->xdp_rxq,
> +					   MEM_TYPE_PAGE_POOL, page_pool);

[Severity: High]
Is it safe to ignore the return value of xdp_rxq_info_reg_mem_model() here?

If xdp_rxq_info_reg_mem_model() fails (e.g., due to -ENOMEM from kzalloc), =
the
XDP RX queue is left unregistered. When subsequent packets are processed, X=
DP
might treat the page_pool buffers as standard shared pages and call put_pag=
e()
instead of page_pool_put_page(), which could corrupt the page pool allocato=
r.

This same issue also appears to be present in the forward path within
lan966x_fdma_rx_alloc_page_pool():

drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c:lan966x_fdma_rx_alloc=
_page_pool() {
    ...
		xdp_rxq_info_unreg_mem_model(&port->xdp_rxq);
		xdp_rxq_info_reg_mem_model(&port->xdp_rxq, MEM_TYPE_PAGE_POOL,
					   rx->page_pool);
    ...
}

> +	}
> +
>  	lan966x_fdma_rx_start(&lan966x->rx);
> =20
>  	lan966x_fdma_wakeup_netdev(lan966x);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260607145747.1494=
514-1-lgs201920130244@gmail.com?part=3D1
