Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795183475;
	b=W1Bp4oj6HzUDnbp7h04oFAMFGnSiaCs0sA4qP/G/4/fv8SjCqDx4TAcvpszLb/jpycG9
	 jJzgOTNubHSYLU7TdU6FNszNUIxGXfNaLAvztnKKw6K3sG2nzXmmMqocbIhxU84eMYTsa
	 D5vaD1WvBU9NKTAs1jFbLoHM4pXKnBNO7DqwdRKvjposqpNzl07egjBPxr0tbKbP8AaCN
	 pxQ0lEIREMX5fBNsWqqaw228t82P5mkKZXjL9r/pgLmzVdc9ywsUC9cHJvLs18AHJ/SCu
	 G7HscFVbFkY4hdyd1TgUy0QGjOzLTFVIQVHzSIhrwdpulMjiNwHYC6vqxKQn7x8ekTA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795183475;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=47t4DHRlBZ3cVN0XZQsL2oUDvACQwxCoNP6eDRcx3w4=;
	b=Ks7iQhx7vvV/QWRy4IlbiNZ7WBOTLCm2FjxPZe14sAv2sulzWFUNAvz6K81neKouNCGe
	 5LVDpmByc+qDk45VN1IikytJ1ZYq5bKyxw00mRyZwUQK++tEVGtnINI25m3n4qFrKTwoy
	 MEdFySkR+LrHJyV3sqh9yYDkzNHexF3SstGR02hbbLCMRAIiX/kZ/kUaqtZ5UTLVcEwzI
	 CcPSfx+3/9cWc9zKyoyfPoXkrbp/vBUW7RXOqWXrSRvY3wDcPqN5qKgR/Ww9y/TXI+2o6
	 1ZRVFVWMXwCwqBcvN+581f96eU5bgnHu36Byh8ALrFU6bfRJfqZfWfXwgoo31uGHLsQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YZP1dDq4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B574C606A32C
	for <bpf@vger.kernel.org>; Fri, 20 Nov 2026 14:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YZP1dDq4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F301D1F000C0;
	Fri, 20 Nov 2026 14:04:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795183475;
	bh=47t4DHRlBZ3cVN0XZQsL2oUDvACQwxCoNP6eDRcx3w4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YZP1dDq4rsui/VP1UAdmYMCSd7LyEEOEGJ9WTYw5tA/tuMuUaE1viFQ4WW12RGIaE
	 VfJzTbblWduLxNwgQQI7CAXVinO/WyZYanOFWiVe0lJ7oeeU7Ft69VwZNzUqXgsVBh
	 Tsmy58hFyx9zu8e67ApU6vAKzIduFd197Y0ChWPJHjyfhjtxdjenhTL6NpTFm9bXUg
	 +U3QkXsK+41kE119vMXYW4tlr6UhqTBbtihr9nPm1VKdDSuP1VcmIil8f2qcsza8ld
	 TQK6rwjJ6WZHkFdf3TGmeJ824Qf3/w/01azBrPft1CfXWezU0+saHVFigwym79l2yU
	 TrbxyanPi8Hjg==
Message-ID: <sashiko-outbox-225316@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v3 1/4] igb: don't disable rings that don't exist
 when disabling an XSK pool
Reply-To: sashiko-reviews@lists.linux.dev
To: "Antonio Quartulli" <antonio@mandelbit.com>, intel-wired-lan@lists.osuosl.org
Cc: bpf@vger.kernel.org
In-Reply-To: <20261119140412.163202-2-antonio@mandelbit.com>
References: <20261119140412.163202-1-antonio@mandelbit.com>
 <20261119140412.163202-2-antonio@mandelbit.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Nov 2026 14:04:34 +0000
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
- [Medium] igb: missing num_tx_queues check in igb_xsk_pool_disable()
  dereferences NULL
--

commit e4f6db572e101ec4f5da6fee01a7451218673315
Author: Antonio Quartulli <antonio@mandelbit.com>

igb: don't disable rings that don't exist when disabling an XSK pool

This commit checks qid against adapter->num_rx_queues in
igb_xsk_pool_disable() so rings that do not exist are not disabled or
re-enabled.

Link: https://lore.kernel.org/netdev/20261116153041.3002666-2-antonio@mande=
lbit.com/

> diff --git a/drivers/net/ethernet/intel/igb/igb_xsk.c b/drivers/net/ether=
net/intel/igb/igb_xsk.c
> index ce4a7b58cad2f..8ed82bb1def9a 100644
> --- a/drivers/net/ethernet/intel/igb/igb_xsk.c
> +++ b/drivers/net/ethernet/intel/igb/igb_xsk.c
> @@ -148,7 +148,12 @@ static int igb_xsk_pool_disable(struct igb_adapter *=
adapter, u16 qid)
>  		return -EINVAL;
> =20
>  	rx_ring =3D adapter->rx_ring[qid];
> -	if_running =3D netif_running(adapter->netdev) && igb_xdp_is_enabled(ada=
pter);
> +	/* The stack can know more queues than the device has, e.g. after a
> +	 * fallback to fewer queues on resume: skip the rings it doesn't have.
> +	 */
> +	if_running =3D netif_running(adapter->netdev) &&
> +		     igb_xdp_is_enabled(adapter) &&
> +		     qid < adapter->num_rx_queues;
>  	if (if_running)
>  		igb_txrx_ring_disable(adapter, qid);

[Severity: Medium]
Can igb_txrx_ring_disable() still dereference a NULL adapter->tx_ring[qid]
when qid >=3D adapter->num_tx_queues?

In igb_set_interrupt_capability(), allocating SR-IOV VFs forces
adapter->num_tx_queues to 1 while leaving adapter->num_rx_queues at
adapter->rss_queues (up to 2 on 82576):

drivers/net/ethernet/intel/igb/igb_main.c:igb_set_interrupt_capability() {
	...
	adapter->num_rx_queues =3D adapter->rss_queues;
	if (adapter->vfs_allocated_count)
		adapter->num_tx_queues =3D 1;
	else
		adapter->num_tx_queues =3D adapter->rss_queues;
	...
}

Because igb_xsk_pool_enable() also only checks qid >=3D adapter->num_rx_que=
ues,
disabling a pool bound to qid 1 when SR-IOV is active passes qid <
adapter->num_rx_queues and reaches igb_txrx_ring_disable(), which
immediately dereferences adapter->tx_ring[1] (NULL).

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261119140412.1632=
02-1-antonio@mandelbit.com?part=3D1
