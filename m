Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17A1E3CF660
	for <bpf@vger.kernel.org>; Sat, 10 Oct 2026 10:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791628037; cv=none; b=gc2UQ/PAhCSDm40kH9ow5jX52ukoomoYIMFjyZtzOMN8scRSdWaEcvGPbrQW3IHpQKNFk9mtr3UFRpIVmyDBFXowWKBbn4xTQ0tcNUcZb7YPhaFQ87Ng77KNsQZ+9G92yOCSDIu5IUv3lrY5wxCa7yJzOmldA2M4xKcedqmaO30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791628037; c=relaxed/simple;
	bh=OQ0KHjCf5qu1wLqxeCJWcS733zQUdUeVl/oa9aoBZEI=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=SmmXv09yISajBw+Wir3e1fut9ZDRi2+/safDwJvrNkAnuxK1O2FgDLOQpm4pDe39zHNx8NCod0OFVZifE/SjWX7IXhEPAS9mBKJNcwAewKes40rgs9RWxAL6C55eVXx2BEhkzSuvAVSPtQV7KBXOplCQn7TzqocEeJ5Sybq0xxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QuFNQFW5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QuFNQFW5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7854E1F00893;
	Sat, 10 Oct 2026 10:27:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791628035;
	bh=Ov+jl9kmvoT6Oc68j7mvZWIJvXOkudw/PX2eTwFwZDM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QuFNQFW5fpvr8Lngk1KVo2Jdi8E6YWH2dFBKKLQeByKG7nhVihXp9xLk+KOiAIS8a
	 rR7qBfAsjTnVDNrjs3REW8bWEVVr0wBXTO0omvgNE2DIW9X9qEal1X9dWb4pJAqgHI
	 7ZW3OrprjOQxq70nGU2a3I/oQIJM/1s1vI3v4matCBU8uP+GrQdXOIZxOj6eUnS2IZ
	 /IC8nq5MhKiGVoChgQ924MDv8iPxSx0HTtDVJZU8bNLPtKfErvhqJ9Zq92Rzo2bXD8
	 i1jnQuKmlvqZTSqaDEP4SP/VCJkxqZz54KQ1HbB/oxtql+gocyb7T4PZ+QKfuNpc7m
	 +CgBRE7d4Is5Q==
Message-ID: <sashiko-outbox-166431@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v5 2/3] net: stmmac: rework stmmac_rx to
 support XDP rx multi-buff
Reply-To: sashiko-reviews@lists.linux.dev
To: "Lorenzo Bianconi" <lorenzo.bianconi@oss.qualcomm.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20261009-stmmac-rx-mb-v5-2-c38fa4eaa138@oss.qualcomm.com>
References: <20261009-stmmac-rx-mb-v5-0-c38fa4eaa138@oss.qualcomm.com>
 <20261009-stmmac-rx-mb-v5-2-c38fa4eaa138@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 10 Oct 2026 10:27:14 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] net: stmmac: OOB read in stmmac_rx_zc() for multi-buffer frames
--

commit b6459feb6b07a40586d4710878eea688f9a8b50c
Author: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>

net: stmmac: rework stmmac_rx to support XDP rx multi-buff

This commit reworks stmmac_rx to build the xdp_buff by accumulating all
descriptors that make up a frame. This allows the XDP program to run on
the full, possibly fragmented packet instead of just the first buffer. It
lays the groundwork for extending XDP to jumbo frames and SPH.

> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/=
net/ethernet/stmicro/stmmac/stmmac_main.c
> index 6128e6d9504c8..be2cba8fcbc6d 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
[ ... ]
> @@ -5798,6 +5804,118 @@ static int stmmac_rx_zc(struct stmmac_priv *priv,=
 int limit, u32 queue)
>  	return failure ? limit : (int)count;
>  }

[Severity: High]
Since this patch series removes the MTU check and enables jumbo frame
support, does it expose an out-of-bounds read in stmmac_rx_zc for
multi-buffer frames?

Looking at stmmac_rx_zc, when AF_XDP Zero-Copy is active and intermediate
fragments are dropped, the len accumulator is not updated:

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

	ctx =3D xsk_buff_to_stmmac_ctx(buf->xdp);
	...
	buf1_len =3D stmmac_rx_buf1_len(priv, p, status, len);
	len +=3D buf1_len;
	...
	buf->xdp->data_end =3D buf->xdp->data + buf1_len;
}

When the final descriptor arrives (status without rx_not_ls), len is
still 0. The stmmac_rx_buf1_len function then calculates
buf1_len =3D min(dma_buf_sz, plen - 0).

If plen is greater than dma_buf_sz, buf1_len is set to dma_buf_sz, but the
final descriptor only contains the tail bytes of the frame. This gives the
XDP program a buffer length that exceeds the actual data written by DMA,
potentially exposing up to dma_buf_sz of uninitialized XSK UMEM memory.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261009-stmmac-rx-=
mb-v5-0-c38fa4eaa138@oss.qualcomm.com?part=3D2
