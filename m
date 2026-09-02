Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22BF527473
	for <bpf@vger.kernel.org>; Wed,  2 Sep 2026 02:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788317534; cv=none; b=mf3PlB9DdHxxtoY3kPDTuhsQ2UEbl1XKqgV13pmRhnLp0VZUNUsORYvvQfd+fyXarnhy36SwluwKAOojN8L0LviHkXlkOfMnO32s6485NVGesHGKTYw0sd04nIeXTOMI2k+gUuWCH7V9YFUELL+xJoc1J8bOq51E/RcpsfEPmQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788317534; c=relaxed/simple;
	bh=AQlXUioNWpcIL61bgLPVUILw8x8325m0z3eAVBUWCVQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=HdoZlecJp/DEQedIUeU8FfDoipFtIv0L6mb9v3kX/18eHETav043We3RB7WrA2r6jFFWN6CrNPyHi+lvtxmgonUBKhgGV3Xc3dp+Ep5LlHzz0eqgmnaMGF3UdIXZ9zAnxfW8Eomc6nxny7Q12ZyASuK5Fz1MfzFwlWz2x9EOOo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OjXFfbLd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OjXFfbLd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 779E11F000E9;
	Wed,  2 Sep 2026 02:52:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788317532;
	bh=AtW5Wcu6SqNRfM8lyINcboFvcgW5k4K9xiInpS13lao=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OjXFfbLdScYjg2MKaA/ZQZ2sj2Ouv6VexOhr/LF5aig18vY/faTruv6Astq+iaIl5
	 wZFAhy1B2g08mLUMNL2pt/uYvi+PSR9Qi6jxnrLn5ZkIJLEW+8zbJHeMZE5RDxI+gD
	 NVsk/4/iu8O9Z8XKxfofvHTYnZXQebhutTakV47LUBZq/hNpYX8Gu2v90VHIBBtOEn
	 24cF+gmnkGYttZYRzA/VT6yIo5sOWLT7CKPOvnYECcjTQS25bTGzWIyTtd5B1xYRiM
	 Ki7UNi14PjofNwg/2GZiGbK8YfQe+/2yn3dkujcI8O2RTmMxEHk0nOUIzz9ztZw6rA
	 a/4FtrGEBh4ZQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next, v3] net/mlx5: Use dma_wmb() for completion
 queue doorbell updates
Reply-To: sashiko-reviews@lists.linux.dev
To: lirongqing <lirongqing@baidu.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260902023429.1717-1-lirongqing@baidu.com>
References: <20260902023429.1717-1-lirongqing@baidu.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 02 Sep 2026 02:52:12 +0000
Message-Id: <20260902025212.779E11F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Replacing wmb() with dma_wmb() breaks ordering between DMA doorbel=
l writes and normal memory updates, leading to potential CQ overruns.
--

commit 3bd90cae934d1db51177852241805820453b9c02
Author: Li RongQing <lirongqing@baidu.com>

net/mlx5: Use dma_wmb() for completion queue doorbell updates

This commit replaces wmb() with dma_wmb() in various mlx5 completion queue
polling routines. The goal is to improve performance by using a lighter
barrier where only DMA coherent memory accesses are involved.

>     Since only DMA coherent memory accesses are involved (no MMIO accesses
>     follow), we can safely use dma_wmb() instead of wmb().

Does this accurately describe the code following the barrier?

While there might not be MMIO accesses, there are normal memory accesses
that follow, such as updates to consumer indices like sq->cc or pushing to
a freelist.

> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/ptp.c b/drivers/n=
et/ethernet/mellanox/mlx5/core/en/ptp.c
> index 723f66a6bd634..17084d76209e8 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en/ptp.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en/ptp.c
> @@ -259,7 +259,7 @@ static bool mlx5e_ptp_poll_ts_cq(struct mlx5e_cq *cq,=
 int napi_budget)
>  	mlx5_cqwq_update_db_record(cqwq);
> =20
>  	/* ensure cq space is freed before enabling more cqes */
> -	wmb();
> +	dma_wmb();
> =20
>  	while (metadata_buff_sz > 0)
>  		mlx5e_ptp_metadata_fifo_push(&ptpsq->metadata_freelist,

[Severity: High]
Is the DMA write to the CQ doorbell ordered before pushing to the
metadata_freelist in normal memory?

If dma_wmb() only guarantees ordering between two DMA memory accesses,
can the CPU reorder the normal memory write to execute before the wq->db
write?

> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c b/drivers/n=
et/ethernet/mellanox/mlx5/core/en/xdp.c
> index 77ea51bfbaae5..ee0986bd5c18d 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c
> @@ -817,7 +817,7 @@ bool mlx5e_poll_xdpsq_cq(struct mlx5e_cq *cq)
>  	mlx5_cqwq_update_db_record(&cq->wq);
> =20
>  	/* ensure cq space is freed before enabling more cqes */
> -	wmb();
> +	dma_wmb();
> =20
>  	sq->cc =3D sqcc;

[Severity: High]
Does dma_wmb() guarantee that the DMA write to the CQ doorbell is ordered
before the normal memory write to sq->cc?

If it does not, this could lead to a CQ overrun where the transmitting CPU
observes the updated sq->cc, posts new WQEs, and rings the SQ doorbell
before the device observes the CQ space update. This could cause the device
to think the CQ is full, leading to dropped completions, leaked SKBs, or TX
timeouts.

[ ... ]

> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_tx.c b/drivers/ne=
t/ethernet/mellanox/mlx5/core/en_tx.c
> index 0b5e600e4a6a9..14479da98f427 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en_tx.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_tx.c
> @@ -849,7 +849,7 @@ bool mlx5e_poll_tx_cq(struct mlx5e_cq *cq, int napi_b=
udget)
>  	mlx5_cqwq_update_db_record(&cq->wq);
> =20
>  	/* ensure cq space is freed before enabling more cqes */
> -	wmb();
> +	dma_wmb();
> =20
>  	sq->dma_fifo_cc =3D dma_fifo_cc;
>  	sq->cc =3D sqcc;

[Severity: High]
Will the normal memory write to sq->cc be properly ordered after the DMA
write to the CQ doorbell with only dma_wmb()?

[ ... ]

> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/aso.c b/drivers/=
net/ethernet/mellanox/mlx5/core/lib/aso.c
> index 614cd57a40d74..8f7a89ae4ad8c 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/lib/aso.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/aso.c
> @@ -421,7 +421,7 @@ int mlx5_aso_poll_cq(struct mlx5_aso *aso, bool with_=
data)
>  	mlx5_cqwq_update_db_record(&cq->wq);
> =20
>  	/* ensure cq space is freed before enabling more cqes */
> -	wmb();
> +	dma_wmb();
> =20
>  	if (with_data)
>  		aso->cc +=3D MLX5_ASO_WQEBBS_DATA;

[Severity: High]
Could the normal memory write to aso->cc execute before the DMA write to
the CQ doorbell due to the relaxed guarantees of dma_wmb()?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260902023429.1717=
-1-lirongqing@baidu.com?part=3D1
