Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E16F9372EE2
	for <bpf@vger.kernel.org>; Tue, 28 Jul 2026 16:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785255646; cv=none; b=luLq7GB6qAoaneYJ/x4xU+gsyF0aoG8bXc9A3TBHVHKuKFmMnf4i2iy2F67Aob2GboR5KS77ZLbuRNCUdWuI2ZqEmUVMQyPclQI2kFzVEnFO56PN5Z+6a3GyCrm20Yto8JjuhWA6V4M9f7jwPNZlYEItGk30IpokgEHwG/UkRaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785255646; c=relaxed/simple;
	bh=yC5nW3Ar1Pj4ps6d794XR+B+Pdb0omVPjfCMc7/ew2o=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=EyBLV7h3j1Zp50pczhPQ3x9/h1Q3tzn0iCM11Yue82OYtsAe+zfNNYBxBr4AOhVdWT1OFSLyf1qFqDm7+0hDtqr0DDo/TiKnIytfts7wZ86ImRpAR9afyzrnzbSHI8gO6BO9GCRjvAendlu4lM9KTyUGGSgzW7g5MuFTXs+EYqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EzSX81sg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EzSX81sg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2D9F1F00A3A;
	Tue, 28 Jul 2026 16:20:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785255644;
	bh=C3DTuOvAX4gx3iRdHC6G1PKa98gJgCCut+NNnbKo0VY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EzSX81sgY1fGU8R53I8IzpCa2KKIObgZRCqKLNQKejPL6h1Oaq3lItjVKe50zoCvM
	 rHaTaQLttoeexR/fHfD8wKpU0nVN50ZMrPz+N0wtfYjAMo66LKa6rji2vuRaqmsGCX
	 U/sc82mQTaKmm9Rev9P9o0v1Y53GEvkyzSxLefpmkz/2YRi/3qlYjp/wLkokjlhQAr
	 BDtI4swEe/HT4J47YcJXj1zoCVKeaPIvI6aZgG4CazhZZw3fpTHBg1w56GrzMywMvA
	 g0OyGk36+vnc3PlZXATd0YCpWOv32N4jRxP227CKFdVDwQaXtZ12y3hYY46go8Bi+q
	 YBEInOLhXHayw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net 6/6] xsk: validate metadata when processing requests
Reply-To: sashiko-reviews@lists.linux.dev
To: "Stanislav Fomichev" <sdf.kernel@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260727161959.885642-7-sdf@fomichev.me>
References: <20260727161959.885642-1-sdf@fomichev.me>
 <20260727161959.885642-7-sdf@fomichev.me>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 28 Jul 2026 16:20:44 +0000
Message-Id: <20260728162044.B2D9F1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Zero-copy drivers unconditionally parse XDP TX metadata ignoring t=
he XDP_TX_METADATA option flag.
- [High] The stmmac driver drops AF_XDP TX frames without generating comple=
tions when the frame length exceeds max_sdu, causing the AF_XDP completion =
queue (CQ) to permanently desynchronize.
--

--- Patch [6]: [PATCH net 6/6] xsk: validate metadata when processing reque=
sts ---
commit 8967b4032038ba439c0a13ce2dc4cab303b87c2e
Author: Stanislav Fomichev <sdf.kernel@gmail.com>

xsk: validate metadata when processing requests
   =20
The zero-copy path validates TX metadata while obtaining the descriptor
context, then reads it again later when preparing the hardware request.
Validate the metadata in xsk_tx_metadata_request() and use the resulting
flags snapshot for every feature check.

> diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethe=
rnet/intel/igc/igc_main.c
> index 5a18d00deb4f4..7b6cdc037c00f 100644
> --- a/drivers/net/ethernet/intel/igc/igc_main.c
> +++ b/drivers/net/ethernet/intel/igc/igc_main.c
> @@ -3082,7 +3082,7 @@ static void igc_xdp_xmit_zc(struct igc_ring *ring)
>  		meta_req.tx_buffer =3D bi;
>  		meta_req.meta =3D meta;
>  		meta_req.used_desc =3D 0;
> -		xsk_tx_metadata_request(&meta, &igc_xsk_tx_metadata_ops,
> +		xsk_tx_metadata_request(pool, &meta, &igc_xsk_tx_metadata_ops,
>  					&meta_req);

[Severity: High]
This is a pre-existing issue, but do the zero-copy drivers unconditionally
parse XDP TX metadata while ignoring the XDP_TX_METADATA option flag?

Looking at igc_xdp_xmit_zc() (and similarly in mlx5e_xsk_tx() and
stmmac_xdp_xmit_zc()), the zero-copy path reads metadata directly without
checking xdp_desc.options:

    meta =3D xsk_buff_get_metadata(pool, xdp_desc.addr);

If an application sends a standard AF_XDP packet without requesting metadata
(by clearing the XDP_TX_METADATA flag), the driver ignores desc->options and
unconditionally reads the metadata memory. Since the memory might contain
stale data, meta->flags could contain valid but bogus bits.

Could this trigger unintended hardware offloads, causing data corruption
(bogus checksum offsets) or TX queue stalls (bogus launch times)?

[ ... ]

> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/=
net/ethernet/stmicro/stmmac/stmmac_main.c
> index 3f5111969c414..eb666b0bcdd22 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -2747,8 +2747,8 @@ static bool stmmac_xdp_xmit_zc(struct stmmac_priv *=
priv, u32 queue, u32 budget)
>  		meta_req.set_ic =3D &set_ic;
>  		meta_req.tbs =3D tx_q->tbs;
>  		meta_req.edesc =3D &tx_q->dma_entx[entry];
> -		xsk_tx_metadata_request(&meta, &stmmac_xsk_tx_metadata_ops,
> -					&meta_req);
> +		xsk_tx_metadata_request(pool, &meta,
> +					&stmmac_xsk_tx_metadata_ops, &meta_req);

[Severity: High]
This isn't a bug introduced by this patch, but does stmmac_xdp_xmit_zc()
permanently desynchronize the AF_XDP completion queue when dropping oversiz=
ed
frames?

Earlier in stmmac_xdp_xmit_zc(), if the frame length exceeds max_sdu, the
descriptor is dropped via continue without issuing an XSK completion or
posting a dummy hardware descriptor:

    if (priv->est && priv->est->enable &&
        priv->est->max_sdu[queue] &&
        xdp_desc.len > priv->est->max_sdu[queue]) {
        priv->xstats.max_sdu_txq_drop[queue]++;
        continue;
    }

Since xsk_tx_peek_desc() reserves a slot in the AF_XDP completion queue (CQ=
),
dropping the frame skips the hardware descriptor setup, and no completion
interrupt is generated for this packet.

When a subsequent packet completes, xsk_tx_completed() will advance the CQ
producer. Because CQ entries are positional, would user space receive the
address of the dropped packet as a completion instead of the actually
completed packet, permanently leaking descriptors?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260727161959.8856=
42-1-sdf@fomichev.me?part=3D6
