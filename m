Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795395694;
	b=zLGVL07I3MOh9BjtWEwG4A2a4mQA5t/hWSWBCxjC0n1C8me0hls+Sq2KYvJLqik6PRck
	 9eJRpzvXTECmPbLYzCS+ZQAuXDavOuLJXCsd9UHK6FH1FirRZqbMIRcWDkh6SvDlQ1cWB
	 v+JcQZsGFUDiICexAwFANveC1EerhtZJJOMXcZOHZpXOC0MkEhGEWcv+c4YB5ijsAJrIb
	 s/vw+L216vZ1IOAutixoTPjbe83q+hY/2KEP27xIJ+bea+EbMpCEoyA+BSxdep7Je1/NV
	 QjAihdmVRRufEw/tITKdz6+abqv+SkND/OH6c2uvOan5ZsKxOhSFJQe00CNfCz6U9jA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795395694;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=z13LRoOrdfrNPSoGUFs5/mDl9rb7xiyx2/paKPWqi0c=;
	b=14PuC7AY5++vqo2MXwDDRwzKD8I78qpQmGb2xZy0AAl+8zoJ3tXAnEcpIjmZwHYt43j0
	 IbP6qdCQXBDljKUMIhs6Aj6uNUm9VWgoNTUmAossuvFp3Kw9TBID7CyUa1HclMzE6oUsC
	 h61JhR6t9n+/6A+tfHZxSl+XC1zKHHHMQoRK9hzRT928tFPO0J9irByj8KWQeNG8j6qRL
	 HbyXCSKbadgWEp2gY5ZhXEYnOZQxXAqc8Jg4/uYUTbnIRX4iivyaHfiMGHQoPnmIYB1pv
	 Ai8fw9x56JnkLo2kYl9RlM2WbnoqFmQaCpSaW+yn1dBij/wEP/xI/CqKr2FbIKvQDbg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=e6fzl1rT;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9850606A31E
	for <bpf@vger.kernel.org>; Mon, 23 Nov 2026 01:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=e6fzl1rT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BE491F000CF;
	Mon, 23 Nov 2026 01:01:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795395694;
	bh=z13LRoOrdfrNPSoGUFs5/mDl9rb7xiyx2/paKPWqi0c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=e6fzl1rTktzaNiiyTEGqInUw4bLHB0zVVmLcv/KEyk7THREp8TPt22mRvfefONnR0
	 VnYsLdEKpLF5Jm/vhjr0p8g80JmlUTJgOjeJOzuyp+KAZ4UAsgbftD2xK/4fHPtiIC
	 k6o4+bf9cNnDSZZG8NjT/NDjaEge4hRhOO5UPMkLM7QUFG1ARcVT5G8y/4j9Oh1tqD
	 L2a8b91isNlMQ09dK50CCYjnu9RRL/mGcTlSnDwwVfF4gNEQ/Zjk08m0ujqL4f95XO
	 vGMTSZIxNEQHnvPXCk86az6i7Qv/CJXTmQh1wrVLPlZmK0R4+hNpTxz1paKv7GvRJm
	 79deqQKlyjZ/w==
Message-ID: <sashiko-outbox-228501@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v2 6/9] eth: mlx5e: drop the now-dead HW-GRO
 and LRO vs XDP handling
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jakub Kicinski" <kuba@kernel.org>
Cc: bpf@vger.kernel.org
In-Reply-To: <20261122010112.1471146-7-kuba@kernel.org>
References: <20261122010112.1471146-1-kuba@kernel.org>
 <20261122010112.1471146-7-kuba@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 23 Nov 2026 01:01:34 +0000
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
- [Medium] net/mlx5e: XSK pool setup fails with HW-GRO/LRO in
  mlx5e_set_xdp_feature()
--

commit bbcc3184f046fe17399985b6692abbf4e736da56
Author: Jakub Kicinski <kuba@kernel.org>

eth: mlx5e: drop the now-dead HW-GRO and LRO vs XDP handling

This commit removes the driver-side mutual exclusion checks between XDP and
HW-GRO/LRO, relying on the networking core to clear HW-GRO and LRO before
attaching an XDP program, and keys XDP feature advertising off
tcp-data-split instead of packet merge state.

> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/=
net/ethernet/mellanox/mlx5/core/en_main.c
> index 06a8a4be4be7c..08568137d044d 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
> @@ -4487,12 +4487,14 @@ static int mlx5e_handle_feature(struct net_device=
 *netdev,
> =20
>  void mlx5e_set_xdp_feature(struct mlx5e_priv *priv)
>  {
> +	struct netdev_config *cfg =3D priv->netdev->cfg_pending;
>  	struct mlx5e_params *params =3D &priv->channels.params;
>  	struct net_device *netdev =3D priv->netdev;
>  	xdp_features_t val =3D 0;
> =20
> +	/* XDP can't run with HW-GRO, and tcp-data-split keeps HW-GRO on */
>  	if (netdev->netdev_ops->ndo_bpf &&
> -	    params->packet_merge.type =3D=3D MLX5E_PACKET_MERGE_NONE)
> +	    cfg->hds_config !=3D ETHTOOL_TCP_DATA_SPLIT_ENABLED)
>  		val =3D NETDEV_XDP_ACT_BASIC | NETDEV_XDP_ACT_REDIRECT |
>  		      NETDEV_XDP_ACT_XSK_ZEROCOPY |
>  		      NETDEV_XDP_ACT_RX_SG;

[Severity: Medium]
Does advertising NETDEV_XDP_ACT_XSK_ZEROCOPY while HW-GRO or LRO is active
break AF_XDP pool setup when a socket is bound before an XDP program is
attached?

Unlike XDP_SETUP_PROG, xp_assign_dev() checks NETDEV_XDP_ACT_XSK and calls
ndo_bpf(XDP_SETUP_XSK_POOL) without clearing HW-GRO or LRO in the core.
When no XDP program is attached yet and HW-GRO (with tcp-data-split auto)
or LRO is enabled, mlx5e_xsk_enable_locked() runs with
params->packet_merge.type !=3D MLX5E_PACKET_MERGE_NONE:

drivers/net/ethernet/mellanox/mlx5/core/en/xsk/pool.c:mlx5e_xsk_enable_lock=
ed() {
	...
	mlx5e_build_xsk_param(pool, &xsk);
	mlx5e_build_xsk_channel_param(priv->mdev, params, &xsk, cparam);

	if (!params->xdp_prog) {
		/* XSK objects will be created when an XDP program is set,
		 * and the channels are reopened.
		 */
		goto validate_closed;
	}
	...
validate_closed:
	if (!mlx5e_validate_xsk_param(params, &cparam->rq_opt, priv->mdev)) {
		err =3D -EINVAL;
		goto err_remove_pool;
	}
}

Because mlx5e_rx_is_linear_skb() returns false whenever
params->packet_merge.type !=3D MLX5E_PACKET_MERGE_NONE,
mlx5e_validate_xsk_param() logs "Striding RQ linear mode for XSK can't be
activated with current params" and fails with -EINVAL instead of
xp_assign_dev() rejecting zero-copy cleanly with -EOPNOTSUPP (or disabling
HW-GRO/LRO via netdev_update_features()).

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261122010112.1471=
146-1-kuba@kernel.org?part=3D6
