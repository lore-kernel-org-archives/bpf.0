Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB9813EDE63
	for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 10:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790244012; cv=none; b=DCgjNXbGPwb+Vdn7TbFQTk/eBjLS0ILE0GBxgXXp5SMIc45C7PmBe7RNIpTjspb64SNFk29wJ5uRtjlRLcNP3F2KWN1n+RC7eMx6fxM+mIBgl/6ILXDaY5C9YI9Vn6y9q/SKUCPfMLaGbh9OFYGjArxqtjnR4Mnf0ZoqvYyQEsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790244012; c=relaxed/simple;
	bh=bNKcdMnGeGMzp5obwp/ejl4SCDxf2U9LwHX8Z6chyYQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=AQxIv9u+zK0W2DW+NsJEnBS5NwA6J+kYeMxcEbbOpzHwdjJd3NjvkTIjEIG6cib6fzK8qLC+/Laz5XhdFtp0QLyzaicZp5i7HAPJ3jcN7a0YkVY/pf8K0vSbI+atJPoWi34DIEfstGMshtv+vi0+l9FHcQ9/E/DwynCuDnkhi90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IgwLGxst; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IgwLGxst"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F06341F000FF;
	Thu, 24 Sep 2026 10:00:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790244006;
	bh=z8pZ2s9UwAknyqzvw0IX645AF8djaud5dTgOcliQaio=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IgwLGxst3/TWeFaz+IpXxlSLFjwBqe2E73Lg5K9YlNva3KVZhgRv29Pn7l4F/tALf
	 2JJ821PxJVy06vKSftONSgTYoKHMpH48DZ4Wq8M9k1+5HgnRJxplFSP0NPHOX5nweF
	 jfAMOGrvL/kYlUFEAC9R5giKDwdD2/mqpUckUBiIEn32ZRHtDXY7y9pbdiuwuCD2hQ
	 geRoFZhsMshnKf5kiRz/KwdHZCDYX9lxngqqzh286xDfMVt6LOEVlsvE/h9dAj4ZCu
	 kxUR6n8MjRF+KxgyMiwsnphuwLeHa092ZBSTeQLwIhl1+cXVaQqlqwXxIDxSwVMCRz
	 H6RwpEJ+u9D5g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next] net: stmmac: add XDP multi-buff support for TX
 side
Reply-To: sashiko-reviews@lists.linux.dev
To: "Lorenzo Bianconi" <lorenzo.bianconi@oss.qualcomm.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260923-b4-stmmac-xmit-mb-v1-1-a71a1c522142@oss.qualcomm.com>
References: <20260923-b4-stmmac-xmit-mb-v1-1-a71a1c522142@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 24 Sep 2026 10:00:04 +0000
Message-Id: <20260924100004.F06341F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] stmmac: exact-match coalescing logic skips TX completion interrupts
- [High] stmmac: missing memory barrier before setting TX OWN bit
- [Medium] stmmac: XDP frame check removes SKB TX threshold reservation
--

commit 4955fe9fec58eed4009939eaf9ed4fcf2a742ee7
Author: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>

net: stmmac: add XDP multi-buff support for TX side

This patch extends stmmac_xdp_xmit_xdpf to transmit XDP frames with fragmen=
ts
by mapping and programming each buffer into a dedicated TX descriptor.

> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/=
net/ethernet/stmicro/stmmac/stmmac_main.c
> index bf9e7e4cb1c31..41ccde6371ecd 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -5239,77 +5239,114 @@ static unsigned int stmmac_rx_buf2_len(struct st=
mmac_priv *priv,
[ ... ]
> -	if (stmmac_tx_avail(priv, queue) < STMMAC_TX_THRESH(priv))
> +	if (stmmac_tx_avail(priv, queue) < num_frames)

[Severity: Medium]
Could this change lead to TX ring starvation for standard SKB traffic?

The STMMAC_TX_THRESH check was designed to reserve a portion of the shared =
TX
ring for standard SKB traffic. By replacing the threshold with a check agai=
nst
just num_frames, heavy XDP loads could exhaust all available TX descriptors,
potentially leaving 0 descriptors for SKBs and monopolizing the TX ring.

>  		return STMMAC_XDP_CONSUMED;
[ ... ]
> +	tx_q->tx_count_frames +=3D num_frames;
> =20
> -	if (tx_q->tx_count_frames % priv->tx_coal_frames[queue] =3D=3D 0)
> -		set_ic =3D true;
> -	else
> -		set_ic =3D false;
> -
> -	if (set_ic) {
> +	if (!(tx_q->tx_count_frames % priv->tx_coal_frames[queue])) {

[Severity: High]
Will this exact-match coalescing logic reliably trigger TX completion
interrupts?

When transmitting XDP multi-buffer frames, tx_count_frames increases by
num_frames, which can be greater than 1. The modulo condition relies on an
exact match to 0 to trigger the Interrupt on Completion (IC) bit.

If num_frames causes the counter to overshoot a multiple of tx_coal_frames
(for example, jumping from 24 to 26 when the threshold is 25), the IC bit
will not be set. This could indefinitely delay TX completion handling and
exhaust the TX ring.

> +		struct stmmac_txq_stats *txq_stats;
> =20
> +		desc =3D stmmac_get_tx_desc(priv, tx_q, entry);
> +		stmmac_set_tx_ic(priv, desc);
>  		tx_q->tx_count_frames =3D 0;
> -		stmmac_set_tx_ic(priv, tx_desc);
> +
> +		txq_stats =3D &priv->xstats.txq_stats[queue];
>  		u64_stats_update_begin(&txq_stats->q_syncp);
>  		u64_stats_inc(&txq_stats->q.tx_set_ic_bit);
>  		u64_stats_update_end(&txq_stats->q_syncp);
>  	}
> =20
> +	/* Set the OWN bit on the first descriptor now that all descriptors
> +	 * for this skb are populated.
> +	 */
> +	desc =3D stmmac_get_tx_desc(priv, tx_q, first_entry);
> +	stmmac_set_tx_owner(priv, desc);

[Severity: High]
Is a dma_wmb() needed here before setting the TX OWN bit on the first
descriptor?

The new logic loops over fragments, calling stmmac_prepare_tx_desc() with
tx_own=3D0 for the first descriptor. This effectively bypasses the internal
dma_wmb() inside stmmac_prepare_tx_desc(), which typically requires both
is_fs and tx_own to be true.

Without a preceding dma_wmb() before manually setting the OWN bit here,
the CPU might reorder the write to the first descriptor's OWN bit before
the writes that populated the fragment descriptors. The DMA engine could
then process stale or uninitialized memory.

> +	tx_q->cur_tx =3D STMMAC_NEXT_ENTRY(entry, priv->dma_conf.dma_tx_size);
>  	stmmac_enable_dma_transmission(priv, priv->ioaddr, queue);
> =20
> -	entry =3D STMMAC_NEXT_ENTRY(entry, priv->dma_conf.dma_tx_size);
> -	tx_q->cur_tx =3D entry;
> -
>  	return STMMAC_XDP_TX;
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260923-b4-stmmac-=
xmit-mb-v1-1-a71a1c522142@oss.qualcomm.com?part=3D1
