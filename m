Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CA7B443E56
	for <bpf@vger.kernel.org>; Fri, 25 Sep 2026 12:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790339708; cv=none; b=jRxHe0kQZdnclxnRgBKBPbnCPS22WK4KI26M46Tv7uCAaY0RFyWSirg8OxglNTLsd/sUo+3QKjIjisJzcyrsTN6wyi0uc4Qtgxm/w6zY4D10OWd1lnqyXsvgdtSePrN66K6Q11XxMVnQf7ODPliRFFA5G2l4hlwxeoxRv0FzMps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790339708; c=relaxed/simple;
	bh=MGVZqOZ+hIjky8YT4mhQJyVbwzeNrYMG9GCXfp3l2dU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=FzdQhPKgvA/KbJxokKfHcXfNZ4l5MaSIJHG6791zg3Z825+Xh86ChLPcuLaXRyujohds30izu8QfyJx8X9nZIh8+6exDYxGSPXY/JCkg1Io7fe7UNudzupU+kXRgxetl8kHfdkWtanu2HmxZHlzdya6iYWlkmgvL/7B+QJNXsLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ggk3sEnK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ggk3sEnK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 846CC1F000FF;
	Fri, 25 Sep 2026 12:35:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790339706;
	bh=eZ2u7vFbjhNw0yQSpl8AJGq8HKBk3iGAdb+AmV+1XGE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Ggk3sEnKYdEEup+qHesUBXd4LDTDFXcSONRViHZkju4SYx5pK3Qjyimpo/J/p6Lfi
	 L3GvEYEhWyHVHx3PHkJHSCQT3x4t5i3A63IyqwDQhH1H5XpyJEVVTNE4yk47fAsnla
	 YcvzPlRGG8QZeZGddX1j3ck6r3wgK6X6u24ppeX8LS7Rdn15fWg6fgZMiso5SVf5LZ
	 m6280PH4aLIjEnZhd5qhnchQcm3//8L9hX86mYlPpjPXVIYhh7keq+2xUHOEvHKL+8
	 YsHz7rsol28EXzn6hG3lbhM7Z7P68qUvrk3yqNKYqJExBPNCR29b9bHUI95lBZF6R1
	 mqsDs/nSW/zPg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v2] net: stmmac: add XDP multi-buff support for
 TX side
Reply-To: sashiko-reviews@lists.linux.dev
To: "Lorenzo Bianconi" <lorenzo.bianconi@oss.qualcomm.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260924-b4-stmmac-xmit-mb-v2-1-003347b7bc25@oss.qualcomm.com>
References: <20260924-b4-stmmac-xmit-mb-v2-1-003347b7bc25@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 25 Sep 2026 12:35:06 +0000
Message-Id: <20260925123506.846CC1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] net: stmmac: missing dma_wmb() before setting OWN bit in XDP TX
--

commit cb286a806a3e690802c6042eb9f26c31d2e6ccda
Author: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Subject: net: stmmac: add XDP multi-buff support for TX side

This commit extends stmmac_xdp_xmit_xdpf() to transmit XDP frames with
fragments (multi-buff). Each buffer, including the frame head and every fra=
g,
is mapped and programmed into a dedicated TX descriptor.

> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/=
net/ethernet/stmicro/stmmac/stmmac_main.c
> index bf9e7e4cb1c31..089281ef9e612 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
[ ... ]
> @@ -5239,77 +5239,117 @@ static int stmmac_xdp_xmit_xdpf(struct stmmac_pr=
iv *priv, int queue,
[ ... ]
> +	while (true) {
> +		skb_frag_t *frag =3D i ? &sinfo->frags[i - 1] : NULL;
> +		int len =3D frag ? skb_frag_size(frag) : xdpf->len;
> +		bool last_frame =3D i =3D=3D num_frames - 1;
[ ... ]
> +		stmmac_prepare_tx_desc(priv, desc, !i, len, csum,
> +				       priv->descriptor_mode, !!i, last_frame,
> +				       xdp_get_frame_len(xdpf));
[ ... ]
> +	/* Set the OWN bit on the first descriptor now that all descriptors
> +	 * for this skb are populated.
> +	 */
> +	desc =3D stmmac_get_tx_desc(priv, tx_q, first_entry);
> +	stmmac_set_tx_owner(priv, desc);

[Severity: High]
Does this code need a memory barrier before setting the OWN bit?

When preparing the first descriptor, stmmac_prepare_tx_desc() is called with
tx_own set to false (!!i evaluates to 0 for the first entry). This skips the
internal dma_wmb() that would normally serialize writing the descriptor
payload before setting the OWN bit.

Since stmmac_set_tx_owner() lacks a memory barrier, weakly-ordered CPUs can
reorder the writes. If the DMA engine is actively polling the TX ring, it
might observe the OWN bit being set before the descriptor's payload is fully
written. Could this cause the DMA engine to fetch incorrect memory regions,
leading to data corruption on the wire or hardware IOMMU faults?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260924-b4-stmmac-=
xmit-mb-v2-1-003347b7bc25@oss.qualcomm.com?part=3D1
