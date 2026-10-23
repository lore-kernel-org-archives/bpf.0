Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792738962;
	b=333MXu8wSNcj8xs3K1+0EwU66jUYQsCEVsiU6IBpaEsfqdVEKVta5aW4z1Rfv+bA0e2y
	 +lRhRVweqFfjXGM1W8GFZiK+Fx+6yr6LnHNuKOAjmd1YNy2fsQnX1OEIuqc+KtjYQ/aSB
	 E5X3U4Y5R/XKG3wM1LvMwoSjoG9LaoSpw9U4VX5JSVlwXgf8JjKMrHAvPdaLu/bxvj+E+
	 rhUV2OEAJ+fOKRNp+/RLEHPlyyG68d2lYcH70CerxnVGQ+sEbXy12NE9qCzNOcPYMZBLJ
	 SYiIsQI8nHN071vjXWiaVZNac7EdkHmlCYesvptOJwL1+6f2KMDpzErZ5Cs8qf33zBA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792738962;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=SxH/ebTcWg5HUSaM82Z0/U2PzsQ+jG1838i8v13X41s=;
	b=eWrzCI0aMGeJco+p3A0LO17pH+0XVQ9A/m6jVdRGb0oYWPiEOK9oqHQdLdp1eycVJPMI
	 LHNmo0nPpILqZ4Qee658afsmKNE7j4QIcrPTu4Is38K2bYMiq4NXtJTWQxa1G3mTccee6
	 MGLiUH2+p5GeFP/MdoTYetUUINxtHqwDVWBuXIIvMa+aq+8U/3n88FlwBv0Ein+VDH/yY
	 c9QeKKWVU8yFxy2BDVSt4P9EHhMQEPAiwkJwLYVuiHckfNifw15XD7sej/Esi6MNibSkA
	 LIJOztxsVrjiayCExbIcRBH1pc40DzwC/I1wwyaKXefZhVUwdo1iv5hxoAM05nYDDBw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=A94HX6Ia;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32486606A32C
	for <bpf@vger.kernel.org>; Fri, 23 Oct 2026 07:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=A94HX6Ia
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC7A41F01825;
	Fri, 23 Oct 2026 07:02:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792738961;
	bh=SxH/ebTcWg5HUSaM82Z0/U2PzsQ+jG1838i8v13X41s=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=A94HX6IawBMP+VzqYSRjIS+oc9+EsHsh3KPTaH709HhRjPTM+5RlIFeN/6M7gWKeJ
	 VujPtyBkWNSiPL+2IwcmW30jaNXKMgxJz76m8iysmy8K623sY0kCNns7wb3hAr9oqk
	 NUNsDdLrmFa8k5364yn/pc01pCi9GBaDuy1UwEGnRcl/34g76KL8iLeA+TVVAjWiY4
	 8bMfL4Qr/WUOMTFZ8fin1FJ3Wb95VU+7XoGdWMg1YDu6tsajMNvLn1Hn8bqvzJV/1P
	 j/CN2D0o2IWIV+TWU6N2y5ojVEihyvbkHOoBG8PWoKhvH3TlNfpsitn8YmkWWEeymV
	 Q2tI7FryI5Ufg==
Message-ID: <sashiko-outbox-182377@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v4 2/2] net: stmmac: Stop Tx queue when
 (en|dis)abling XSK pools
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kurt Kanzenbach" <kurt@linutronix.de>
Cc: bpf@vger.kernel.org
In-Reply-To: <20261022-stmmac_xsk_crashes-v4-2-15c0c750bb96@linutronix.de>
References: <20261022-stmmac_xsk_crashes-v4-0-15c0c750bb96@linutronix.de>
 <20261022-stmmac_xsk_crashes-v4-2-15c0c750bb96@linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 23 Oct 2026 07:02:41 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] net: stmmac: stmmac_xdp_xmit() flushes TX descriptors when queue i=
s stopped
--

commit c900d4172ba56a5bcf30305f3561e2f9948f9892
Author: Kurt Kanzenbach <kurt@linutronix.de>

net: stmmac: Stop Tx queue when (en|dis)abling XSK pools

This commit stops the network device Tx queue while enabling or disabling
XSK pools so that concurrent transmissions do not access Tx DMA descriptors
while the Tx ring is being freed and reallocated. It also adds a check in
stmmac_xdp_xmit_xdpf() to bail out when the Tx queue is stopped.

> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/=
net/ethernet/stmicro/stmmac/stmmac_main.c
> index 27c4a249e560f..2083520179a69 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -5270,6 +5270,10 @@ static int stmmac_xdp_xmit_xdpf(struct stmmac_priv=
 *priv, int queue,
>  	if (unlikely(xdp_frame_has_frags(xdpf)))
>  		num_frames +=3D sinfo->nr_frags;
> =20
> +	/* Ring may be torn down for an XSK pool switch */
> +	if (netif_tx_queue_stopped(netdev_get_tx_queue(priv->dev, queue)))
> +		return STMMAC_XDP_CONSUMED;
> +
>  	if (stmmac_tx_avail(priv, queue) < max(num_frames, txq_thr))
>  		return STMMAC_XDP_CONSUMED;
> =20

[Severity: High]
In drivers/net/ethernet/stmicro/stmmac/stmmac_xdp.c,
stmmac_xdp_stop_tx_queue() releases nq->_xmit_lock immediately after setting
__QUEUE_STATE_DRV_XOFF, so stmmac_disable_tx_queue() and
stmmac_enable_tx_queue() run without holding nq->_xmit_lock.

If stmmac_xdp_xmit() in drivers/net/ethernet/stmicro/stmmac/stmmac_main.c is
invoked concurrently with XDP_XMIT_FLUSH while the queue is stopped for an
XSK pool switch, stmmac_xdp_xmit_xdpf() returns STMMAC_XDP_CONSUMED and bre=
aks
out of the frame loop, but stmmac_xdp_xmit() still executes the flush block:

	for (i =3D 0; i < num_frames; i++) {
		int res;

		res =3D stmmac_xdp_xmit_xdpf(priv, queue, frames[i], true);
		if (res =3D=3D STMMAC_XDP_CONSUMED)
			break;

		nxmit++;
	}

	if (flags & XDP_XMIT_FLUSH) {
		stmmac_flush_tx_descriptors(priv, queue);
		stmmac_tx_timer_arm(priv, queue);
	}

stmmac_flush_tx_descriptors() reads tx_q->dma_tx_phy and tx_q->cur_tx and
writes to the hardware Tx tail pointer register via
stmmac_set_queue_tx_tail_ptr():

static void stmmac_flush_tx_descriptors(struct stmmac_priv *priv, int queue)
{
	struct stmmac_tx_queue *tx_q =3D &priv->dma_conf.tx_queue[queue];
	...
	wmb();

	stmmac_set_queue_tx_tail_ptr(priv, tx_q, queue, tx_q->cur_tx);
}

Meanwhile, stmmac_disable_tx_queue() frees the old ring without resetting
tx_q->cur_tx, and stmmac_enable_tx_queue() updates tx_q->dma_tx_phy, resets
tx_q->cur_tx to 0, programs the tail pointer to 0, and starts Tx DMA before
netif_tx_wake_queue() is called.

Can a concurrent stmmac_xdp_xmit() call corrupt the hardware Tx tail pointer
register with a stale tx_q->cur_tx or arm tx_q->txtimer while the Tx queue =
is
being reconfigured, and should thestopped-queue check be performed in
stmmac_xdp_xmit() (or skip flushing when no frames were transmitted)?

>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261022-stmmac_xsk=
_crashes-v4-0-15c0c750bb96@linutronix.de?part=3D2
