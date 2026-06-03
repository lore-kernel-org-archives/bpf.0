Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F2683E717A
	for <bpf@vger.kernel.org>; Wed,  3 Jun 2026 16:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780505721; cv=none; b=PwWE0/8VsW5Z3SkNQ0NDZs/9dI+WtxSOTPYRww4/Xd9LVyGhx+cu1LgB9f2U5S2adsfM7noT5tSJEsM/YiWXYOB7Jfl4Cb1h7GqBNg1Yd07ukzluiFtIAAifyuAjXKJBurjNZuWlJft7YidAusTnz/MOM44jfIa6ZYDWhtmLYIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780505721; c=relaxed/simple;
	bh=dsPr6O1BI32T65p75nc+rLy+mftSHmTcSxP8VOMbiyg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=oOlt69BB/AVCv2oHKml/LNd4Yz83uvrwBf2+Xo6OFkmouKwMCzRR760XMd1ozkhr+Z0v422M2EXAeIFoXQshJYzv8axE3Fh94bCuwK0nL5F/Nqklr9RP6ElMHtGyR84Hm98sSu+Qm1/HYvS9Rr/7wLnaD4ZcwnV0fcnc4yhCb54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZTr8I4fm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZTr8I4fm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFB561F0089A;
	Wed,  3 Jun 2026 16:55:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780505720;
	bh=bixOAWhQZLP5/BJ2FFmM+bjGigl6muWcKWfIhQYMPK4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZTr8I4fmgbBDUF6H7P2TRNzXOf4VeYBFpK1bQcqFA5SE9GXRuqfuivUQvQk1JUtts
	 FVqUTxREe+lg9LQkEyCyIh3DG2llmKSU7z9Aeqe6Qs57Vc507Vh9s1xCoCiIK/Ahtm
	 M6fEseBlu4tM+u81/zfe0CAMTNOKCz18OhqNuQPqYx3f3PFAL1YYJ+hvDyUl8vrSjP
	 HNn6g/HgTuJpDN1jeQao+fsty4bPQq69L9/Yd6fmJtpq4Gj094hrKPZeDjqMZXD01X
	 qCnh8b/1P4AsFKdF0S+/c+tZnP44lFodxC4dMYB5GjSw9/X4kIaTmlDklRT44kKj1e
	 c8Silj8yiaq8A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v2 3/4] net: mvpp2: do not return retired RX buffers
 to BM
Reply-To: sashiko-reviews@lists.linux.dev
To: "Til Kaiser" <mail@tk154.de>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260602164635.62517-4-mail@tk154.de>
References: <20260602164635.62517-4-mail@tk154.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 03 Jun 2026 16:55:19 +0000
Message-Id: <20260603165519.CFB561F0089A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Fixing the UAF introduces a permanent leak of hardware Buffer Mana=
ger (BM) pool slots on RX refill failure, leading to a permanent RX stall.
--

commit 0804789e54c7ef2fb92f8bc16ab030a2285b6149
Author: Til Kaiser <mail@tk154.de>

net: mvpp2: do not return retired RX buffers to BM

This patch splits the RX error handling path to avoid returning buffers
to the hardware Buffer Manager (BM) pool after they have been passed to
XDP or built into an skb.

> diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c b/drivers/ne=
t/ethernet/marvell/mvpp2/mvpp2_main.c
> index 3372ed27cc8d6..397aa5ca4992c 100644
> --- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
> +++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
> @@ -3991,7 +3991,7 @@ static int mvpp2_rx(struct mvpp2_port *port, struct=
 napi_struct *napi,
>  				err =3D mvpp2_rx_refill(port, bm_pool, pp, pool);
>  				if (err) {
>  					netdev_err(port->dev, "failed to refill BM pools\n");
> -					goto err_drop_frame;
> +					goto err_drop_frame_retired;

[Severity: High]
Does skipping the buffer return here cause a permanent hardware pool leak?

By jumping to err_drop_frame_retired, we no longer put a replacement buffer
into the hardware Buffer Manager (BM) pool. If mvpp2_rx_refill() repeatedly
fails under memory pressure, will this drain the BM pool slots to zero and
permanently stall packet reception?

To avoid returning an already-consumed buffer while keeping the BM pool
full, would it be safer to perform the buffer allocation and refill
before passing the original buffer to XDP?

[ ... ]

> @@ -4023,13 +4025,16 @@ static int mvpp2_rx(struct mvpp2_port *port, stru=
ct napi_struct *napi,
>  		err =3D mvpp2_rx_refill(port, bm_pool, pp, pool);
>  		if (err) {
>  			netdev_err(port->dev, "failed to refill BM pools\n");
> +			if (!pp)
> +				dma_unmap_single_attrs(dev->dev.parent, dma_addr,
> +						       bm_pool->buf_size,
> +						       DMA_FROM_DEVICE,
> +						       DMA_ATTR_SKIP_CPU_SYNC);
>  			dev_kfree_skb_any(skb);
> -			goto err_drop_frame;
> +			goto err_drop_frame_retired;

[Severity: High]
Does this path also permanently lose a hardware buffer slot?

Since the successfully built skb is freed and we jump to
err_drop_frame_retired, the hardware BM pool does not get replenished.

Could the refill be done before calling build_skb() so the original buffer
can be safely returned to the hardware pool if allocation fails?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260602164635.6251=
7-1-mail@tk154.de?part=3D3
