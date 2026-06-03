Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84F9F3E1704
	for <bpf@vger.kernel.org>; Wed,  3 Jun 2026 16:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780505720; cv=none; b=XB0QzvELFK1cq51a0fon1gGrQ1vux7SnFp8X7jqVr+LHq7fmIOGTKt2tiwixTQtcYzpMkXJ8MIzxWoWIbnBa9Kx5udyn16Swp6Q0KnunsEdZUiLSj3Izrd3ek97vhAoYelDAjjSu9GgV6CmRP3rZx5B+1Q1oBvShpMZT4nRuD0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780505720; c=relaxed/simple;
	bh=l1hVFtzxzn832BrLRgtxn5RnmLwtFnCwi9gnQEzUtk4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=MZzfmhimqHQ6i4WTBxCS2SCgUSwUkwxbx7fr4EOnLpNlwXCZA8KWneZ24XvhYSs4SOQA/5T0ngSf2ZpAfuyI4qWwLEVGh3i1lrIfI5JwTMhX3P+0TBZ4ZE7sAfFNC1Hy69yibe3Lbjr4eQ6PVjgSVTc/FqTV8by9SJ5wlZwhinQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=huU6llon; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="huU6llon"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BAEB1F00898;
	Wed,  3 Jun 2026 16:55:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780505719;
	bh=qELfPd8GDpFAw/Qp1+UYEMVU5VGxGaZDQwLe9p7qbdM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=huU6llonDrUbAgDLz2+OWNufDa/FEaPoGzCOOXCjsJzbkGlbYMKTOGj3wa5jlUaaz
	 YEXjtP35nMvdQRJKe2tvivgHcJ0gGtm3WS9HDXaalAm18os+Ua9DsmiH/3o8Bwz18n
	 5c10r7F5BE/3/G2fRgaJO+aKDh2wMBKHr3sqcaCudClyGla9JDEujCYYM41LRJqW9j
	 1weCIgvJ9r+onfhDglSm0461twPAMQXfKfoU8Xos6ktDvE7UP6pHNDFauxJEAH6OFc
	 RAGuz7YC15nuhCp9IV4n5J4/r4VAF0E9mCDww/L0kQR+ofwoZeVSM4F2iEJDGtYRjW
	 b67OFomIbdIOQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v2 2/4] net: mvpp2: limit XDP frame size to the RX
 buffer
Reply-To: sashiko-reviews@lists.linux.dev
To: "Til Kaiser" <mail@tk154.de>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260602164635.62517-3-mail@tk154.de>
References: <20260602164635.62517-3-mail@tk154.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 03 Jun 2026 16:55:18 +0000
Message-Id: <20260603165519.3BAEB1F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Changing MTU to jumbo frames switches to shared buffers without de=
taching XDP, leading to NULL pointer dereference.
--

commit 6697a25a0b55fb9d610bfbe672d3935e951e1d53
Author: Til Kaiser <mail@tk154.de>

net: mvpp2: limit XDP frame size to the RX buffer

mvpp2 has short and long BM pools, and short pool buffers can be smaller
than PAGE_SIZE. The XDP path nevertheless initializes every xdp_buff with
PAGE_SIZE as frame size. This initializes the XDP buffer with
bm_pool->frag_size so XDP tailroom matches the actual buffer backing the
packet.

> diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c b/drivers/ne=
t/ethernet/marvell/mvpp2/mvpp2_main.c
> index 92a701f4fe3f5..3372ed27cc8d6 100644
> --- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
> +++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
[ ... ]
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
This is a pre-existing issue, but is there a problem with XDP and jumbo
frames here?

If mvpp2_change_mtu() is called with an MTU that requires jumbo frames but =
is
smaller than MVPP2_MAX_RX_BUF_SIZE, it allows the MTU change and switches to
shared pools by calling mvpp2_bm_switch_buffers().

This destroys the page_pool structures and sets priv->percpu_pools to false,
but the XDP program remains attached.

Later, when packets arrive in mvpp2_rx():

	if (port->priv->percpu_pools) {
		pp =3D port->priv->page_pool[pool];
		dma_dir =3D page_pool_get_dma_dir(pp);
	} else {
		dma_dir =3D DMA_FROM_DEVICE;
	}

Because priv->percpu_pools is now false, pp remains NULL.

When mvpp2_run_xdp() is called with this NULL pp, and the XDP program retur=
ns
XDP_DROP, it unconditionally calls page_pool_put_page() with the NULL pp and
a non-page-pool page:

	case XDP_DROP:
		page =3D virt_to_head_page(xdp->data);
		page_pool_put_page(pp, page, sync, true);

Could this cause a kernel panic when XDP drops or redirects a packet after
an MTU change?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260602164635.6251=
7-1-mail@tk154.de?part=3D2
