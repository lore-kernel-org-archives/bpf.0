Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A54848F84F
	for <bpf@vger.kernel.org>; Sat, 10 Oct 2026 11:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791632136; cv=none; b=BbIKsBsUVVM7bq9qQXGMApqw2GqQdlFoxi6JuPAenpLJJ4Brkq3XCEVR0jHW5FMiZUJxgAJz/Gld3DEclA4ZlvunkOq/ZrFd5ds03zGSnHB4TtUvKcYOJpVp9+i0ma8dkpRAdUa4vgRkohnf5eMWJUtIOTNX0C1ModkCSzItgNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791632136; c=relaxed/simple;
	bh=zpop4oigONxEbMsSKCGLNwSZSwMzxUg7O06JACxhw2Q=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=qg8ppk9cP4D4uCRe4YvFhSRyBzMUQRX2KjKjBLIiZ8cXcAqLfFfXYWze8taoyuDNAeqO17jocj1Piox859mtx08cz5qFg8nGCeZIb+h54LEwXa/RpuCsjhmh9L2707gQtdM1/3OamixghV2hZW2nqkTO5NUpD7bBXXG5tB1fyZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L4n4v/nd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L4n4v/nd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D416C1F000FF;
	Sat, 10 Oct 2026 11:35:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791632135;
	bh=Bu5XjpqHvx2AfYLpWOr5DyYsI01BFUGb+nR6vccYaZQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=L4n4v/ndEjvpja20wn4WKd+O0oaoEoIL5Zs7cJgks6uQ2CkCCl0DxMWsTPipemZaL
	 mFm0kTHzMjCm5nfy68f6wDcCegtlAWHD3rqn2VRBtynE1M8OJlB7B5RPP/XW1RhLk4
	 puLksLJ9CoxUQHUd70X1u+Y23O7TVRFzWm/a8Jbf353SS1n3FZn7Isz/8baJfb5iEy
	 iFqJXQPquMSj+ZSsR67dA9LMbHNGSgvQ1fg4ZrIMxcMb+EeCTQpMF7r0sB79Obx16b
	 1AwkIS9Zxr8L8sbo9raAI19+4M9vbZk24tnPQDJ652JyGc+udXAPBB8F7ZlfcKmTeh
	 NNKsTqq4RCXzg==
Message-ID: <sashiko-outbox-166469@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next 2/4] eth: mpnic: report per-queue stats
Reply-To: sashiko-reviews@lists.linux.dev
To: "Daniel Zahka" <daniel.zahka@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20261009-mpnic-counters3-v1-2-7dc7644cc500@gmail.com>
References: <20261009-mpnic-counters3-v1-0-7dc7644cc500@gmail.com>
 <20261009-mpnic-counters3-v1-2-7dc7644cc500@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 10 Oct 2026 11:35:34 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] eth: mpnic: missing drops and errors in queue stats reporting
--

commit cda12cc259f9eb77d108f5cb4427efce257c6e0b
Author: Daniel Zahka <daniel.zahka@gmail.com>

eth: mpnic: report per-queue stats

This commit exposes the per-ring packet and byte counters through the
queue stats API. It also reports counters for deactivated rings through
the base stats callback.

> diff --git a/drivers/net/ethernet/meta/mpnic/mpnic_netdev.c b/drivers/net=
/ethernet/meta/mpnic/mpnic_netdev.c
> index 5164475a0f943..c2f4a326a8f0f 100644
> --- a/drivers/net/ethernet/meta/mpnic/mpnic_netdev.c
> +++ b/drivers/net/ethernet/meta/mpnic/mpnic_netdev.c
[ ... ]
> +static void mpnic_get_queue_stats_rx(struct net_device *dev, int idx,
> +				     struct netdev_queue_stats_rx *rx)
> +{
> +	struct mpnic_net *mpn =3D netdev_priv(dev);
> +	struct mpnic_ring *rxr =3D mpn->rx[idx];
> +	struct mpnic_queue_stats *stats;
> +	unsigned int start;
> +	u64 bytes, packets;
> +
> +	if (!rxr)
> +		return;
> +
> +	stats =3D &rxr->stats;
> +	do {
> +		start =3D u64_stats_fetch_begin(&stats->syncp);
> +		bytes =3D u64_stats_read(&stats->rcq.bytes);
> +		packets =3D u64_stats_read(&stats->rcq.packets);
> +	} while (u64_stats_fetch_retry(&stats->syncp, start));
> +
> +	rx->bytes =3D bytes;
> +	rx->packets =3D packets;

[Severity: Medium]
Should this also read stats->rcq.dropped and stats->rcq.errors from the
queue stats and assign them to rx->hw_drops or similar fields? The
driver collects these internal stats, but they appear to be missing from
the queue stats API reporting here.

> +}
> +
> +static void mpnic_get_queue_stats_tx(struct net_device *dev, int idx,
> +				     struct netdev_queue_stats_tx *tx)
> +{
> +	struct mpnic_net *mpn =3D netdev_priv(dev);
> +	struct mpnic_ring *txr =3D mpn->tx[idx];
> +	struct mpnic_queue_stats *stats;
> +	struct mpnic_q_triad *qt;
> +	unsigned int start;
> +	u64 bytes, packets;
> +
> +	if (!txr)
> +		return;
> +
> +	qt =3D container_of(txr, struct mpnic_q_triad, sub0);
> +
> +	stats =3D &qt->cmpl.stats;
> +	do {
> +		start =3D u64_stats_fetch_begin(&stats->syncp);
> +		bytes =3D u64_stats_read(&stats->tcq.bytes);
> +		packets =3D u64_stats_read(&stats->tcq.packets);
> +	} while (u64_stats_fetch_retry(&stats->syncp, start));
> +
> +	tx->bytes =3D bytes;
> +	tx->packets =3D packets;

[Severity: Medium]
Does this miss assigning stats->twq.dropped from the transmission queue
stats to tx->hw_drops or tx->hw_drop_errors?

> +}
> +
> +static void mpnic_get_base_stats(struct net_device *dev,
> +				 struct netdev_queue_stats_rx *rx,
> +				 struct netdev_queue_stats_tx *tx)
> +{
> +	struct mpnic_net *mpn =3D netdev_priv(dev);
> +	struct mpnic_base_stats *base;
> +
> +	base =3D netdev_lock_dereference(mpn->stats.base, dev);
> +
> +	tx->bytes =3D base->tx.bytes;
> +	tx->packets =3D base->tx.packets;
> +
> +	rx->bytes =3D base->rx.bytes;
> +	rx->packets =3D base->rx.packets;

[Severity: Medium]
Since the deactivated rings collect drop and error counts internally,
should this also map base->tx.dropped, base->rx.dropped, and
base->rx.errors to the corresponding rx and tx struct fields?

> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261009-mpnic-coun=
ters3-v1-0-7dc7644cc500@gmail.com?part=3D2
