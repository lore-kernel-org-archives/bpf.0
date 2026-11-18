Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795017143;
	b=t/DAHeuPeeJiv8YgKRy4/W1jf+tows+0JTJlqa/BXqbwF0MwgfBQJpcl88tKgimLkGzb
	 5asfB+F70dpLzzMqcaHctXvaKs5USQkw8VjbDgEY9Izntjy5X7+avDEmPWrfjie9Egu7z
	 6WOq71aXzJCn/fV6EueCUMh7dGs+p4lwWHQDhPDpORL7afBPRVL965ANEm/cxvwJKHaBI
	 9Aksenjeck/rUEH+BRUzPqxtHHxoqGCC5CWB3iyprraBZfew2W0QV/DmbZaOCbtjwt9QA
	 CQRyFGOICrF4m65FPc3cCSY0nzOVasr6RfRyFT3Cm4Zu4gesI2LGZysDCLjzUuhel0Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795017143;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=RPckgaKl6DdNmGkCsATLYf2QdOonPmpdoOfSlrReJ98=;
	b=Ly2zhNEb1NHseFoZcqIUJQTbhKZGZzudDFfsrRyTZV6YnrnRX9j7tPJ5kipelcaHs0Xh
	 kJDCs6B6cEo8azJbzyqX5LghUaXMROM0KMd5v51CYrgiCdF+S2oOViQill3dFHBVCPtfu
	 d+3AFSV1kVMhXz7JTl+kC7MWYAhuJ+ilDQ5N71uQTpIkuYKm43QjXirDhk8koY0jJimIX
	 u4GF7FbG3DZUiNnbMo/eW7kvrtEUF+hadivdgF5xj54phVpJvsesU7BDybil6nBbyAj+/
	 35Exo5WefHwrKKYbAM0bNBnjNvK4N1mVN/571O9eWS7p6hsCaDDB61/FU1SDaZh+DBw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ka8WmrpJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16801606A333
	for <bpf@vger.kernel.org>; Wed, 18 Nov 2026 15:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ka8WmrpJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C94B61F000C7;
	Wed, 18 Nov 2026 15:52:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795017142;
	bh=RPckgaKl6DdNmGkCsATLYf2QdOonPmpdoOfSlrReJ98=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ka8WmrpJ7vBCO+u3qqCBpzGeZjJ1IkMaPVP8E0Ebz/iaJdd1/1oIjWVeqM/2b/bGc
	 UDdLFPTjtglFsckNg7b2MuvKJadv2UL/cuxBacWZo20yQsHQzwea/RHtVET1DUZEuP
	 CHBSQnagDBuJ1e4W3CEfIrGcwlO0WY/iJGK/9eEcS5stj0x9qeg8qmnTcB9lPIdkRG
	 G+RdHyl3FGO/4jKasXLc3zDGanQJXkJYB8LdfXFBnsEuDaUM8QRzA7rKjDmcVt5J3k
	 FTYDnbqQwwBcQH+CxSxLIZj59G32I6YDXF5qxkx3dKsOc7SeHLEd1iJGhRFe8nj2gf
	 m06VDlwg6Yvlw==
Message-ID: <sashiko-outbox-221383@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net] net: stmmac: fix num tx queues in
 stmmac_xdp_get_tx_queue()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Lorenzo Bianconi" <lorenzo.bianconi@oss.qualcomm.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20261117-stmmac-fix-xdp_get_tx_queue-v1-1-4cd74ee7a76c@oss.qualcomm.com>
References: <20261117-stmmac-fix-xdp_get_tx_queue-v1-1-4cd74ee7a76c@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 15:52:21 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] net: stmmac: race on num_tx_queues in
  stmmac_xdp_get_tx_queue() skips txtimer
It also noticed 1 related pre-existing issue this patch does not
introduce:
- [High] net: stmmac: unchecked return value of
  netif_set_real_num_tx_queues() [1]
--

commit f55af370614a4d0bb79d7ac40f036cd36c0c9e78
Author: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>

net: stmmac: fix num tx queues in stmmac_xdp_get_tx_queue()

This commit bounds the CPU-based TX queue selection in
stmmac_xdp_get_tx_queue() by priv->xmit_qdisc.num_tx_queues instead of
priv->plat->tx_queues_to_use to stay within dev->real_num_tx_queues when
tc-mqprio offload is active.

> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/=
net/ethernet/stmicro/stmmac/stmmac_main.c
> index 25894771e9e9f..cf87afd273439 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -5408,13 +5408,14 @@ static int stmmac_xdp_xmit_xdpf(struct stmmac_pri=
v *priv, int queue,
>  static int stmmac_xdp_get_tx_queue(struct stmmac_priv *priv,
>  				   int cpu)
>  {
> +	unsigned int num_tx_queues =3D priv->xmit_qdisc.num_tx_queues;
>  	int index =3D cpu;
> =20
>  	if (unlikely(index < 0))
>  		index =3D 0;
> =20
> -	while (index >=3D priv->plat->tx_queues_to_use)
> -		index -=3D priv->plat->tx_queues_to_use;
> +	while (index >=3D num_tx_queues)
> +		index -=3D num_tx_queues;
> =20
>  	return index;
>  }

[Severity: Medium]
Can stmmac_finalize_xdp_rx() arm txtimer on the wrong TX queue if
priv->xmit_qdisc.num_tx_queues changes during an RX NAPI poll?

Unlike priv->plat->tx_queues_to_use, priv->xmit_qdisc.num_tx_queues is
updated on a running interface by tc_setup_dwmac510_mqprio() and
stmmac_reset_tc_mqprio() without stopping RX NAPI:

CPU0                              CPU1 (<softirq>)
                                  stmmac_rx()
                                    stmmac_xdp_xmit_back()
                                      q =3D stmmac_xdp_get_tx_queue()
                                      stmmac_xdp_xmit_xdpf(..., q, ...)
tc_setup_dwmac510_mqprio()
  priv->xmit_qdisc.num_tx_queues =3D n
                                    stmmac_finalize_xdp_rx()
                                      q' =3D stmmac_xdp_get_tx_queue()
                                      stmmac_tx_timer_arm(..., q')
                                      <-- q' !=3D q; q's txtimer not armed

Because stmmac_xdp_xmit_xdpf() only sets interrupt-on-completion every
priv->tx_coal_frames[queue] frames, uncoalesced XDP_TX descriptors queued
on the old queue can be left without a completion interrupt or timer
cleanup.

[Severity: High]
This problem wasn't introduced by this patch, but stmmac_hw_setup()
ignores the return value of netif_set_real_num_tx_queues() [1]:

drivers/net/ethernet/stmicro/stmmac/stmmac_main.c:stmmac_hw_setup() {
	...
	/* Configure real RX and TX queues */
	netif_set_real_num_rx_queues(dev, priv->plat->rx_queues_to_use);
	netif_set_real_num_tx_queues(dev, priv->xmit_qdisc.num_tx_queues);

	/* Start the ball rolling... */
	stmmac_start_all_dma(priv);
	...
}

Can netif_set_real_num_tx_queues() fail with -ENOMEM during stmmac_open()
or stmmac_resume(), leaving dev->real_num_tx_queues out of sync with
priv->xmit_qdisc.num_tx_queues while DMA is started anyway?

[1] https://sashiko.dev/#/bug/linux-1bc77f7b-c8d8-4341-a8a0-49092e607be6

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117-stmmac-fix=
-xdp_get_tx_queue-v1-1-4cd74ee7a76c@oss.qualcomm.com?part=3D1
