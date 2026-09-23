Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38EF444C4FD
	for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 19:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790192758; cv=none; b=P06DZqksHgcBnsZwxUSKL8Bk8H+7UopmBFK48JImoPxEVVByToUOdkE85nkBVVXRPgt2snO18SaYJJrjm4P1EzJAzDWsInkJfa9k5jjUol9RY1QdLIUuX3HmZkJjmuK7jPBgkoDx6u8RvmJeQci5BWVTWHkSoRJoGF6aGQ8T/NM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790192758; c=relaxed/simple;
	bh=o3WTXNSpt1RtWSDZflrH3eztvxeuVKIejyc6QlAYUzo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=V/j4bprbqLvKxgwFCZxIezFVdLDcEeLFQ9f37rSw6bH8fnIyjjU9jzCyA2XqG4mI3t0oipuR2L3enk0DmraLlzz/ciws04dxd+K7TsGZTj+5DREDSNbGzW2WuX/2iVIq6qymSXzpM7nHggj5meQIrNgBXH13IVyDZtIhBGdcKjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L5g6ay34; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L5g6ay34"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC81F1F00893;
	Wed, 23 Sep 2026 19:45:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790192757;
	bh=mWYsOjT/honulXiNL+Fa3CiVt0RkAq6nSe+ou5gCcac=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=L5g6ay34p4BfHadTZAfJvfDGcaYQ6c9Ief1jgcFlzt+NiMqk2tcRIdg2iLCy/sYeG
	 vxFyphOBW2v+qWM6ho0DuOPByrkJORc/+GOcuboNNHh73oFCVChd9oScsKai2CPrBM
	 fm+VZS92cDG5Pp2QdENrPhxuaoVyVSewpaUzpCc1h/QDK9m6qmtwiJaeUCOIYRUFWL
	 ryrkm61eKFwEUYMl7kJK8v9fGnuSDfzvdJw7WBDJmXcrSVr4wXFAGqFCvlhFcjMcoX
	 /QbzXxy/rJ4LJkHQp/93hbU/X0jJXPgaPuA7ZkWzLsZPR8fP1jN52nYv2Ab4d59Ip3
	 kduXZZdbKMAPg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v2 8/9] gve: ensure XDP mem model is registered when
 disabling XSK pools
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joshua Washington" <joshwash@google.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260922194533.631387-9-joshwash@google.com>
References: <20260922194533.631387-1-joshwash@google.com>
 <20260922194533.631387-9-joshwash@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Sep 2026 19:45:56 +0000
Message-Id: <20260923194556.CC81F1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Critical] net/gve: GQI RDA missing ring state reset causes host-device d=
esync
- [Critical] net/gve: Use-After-Free of XSK pool in RDA mode upon disable
- [High] net/gve: QPL TX stall due to missing allocation counters reset
--

commit 94bf684b19419e50950102b96994b969bc7787bd
Author: Joshua Washington <joshwash@google.com>
Subject: gve: ensure XDP mem model is registered when disabling XSK pools

This patch modifies how the GVE driver disables XSK pools to ensure the
memory model is registered correctly. In QPL mode, it registers the memory
model live. In RDA mode, it fully restarts the rings to handle potential
memory allocation failures safely.

> diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/eth=
ernet/google/gve/gve_main.c
> --- a/drivers/net/ethernet/google/gve/gve_main.c
> +++ b/drivers/net/ethernet/google/gve/gve_main.c

[ ... ]

> @@ -1735,31 +1776,11 @@ static int gve_xsk_pool_disable(struct net_device=
 *dev,
>  	if (!netif_running(dev) || !priv->tx_cfg.num_xdp_queues)
>  		goto unmap_and_return;
> =20
> -	/* Stop and start RDA queues to repost buffers. */
> -	if (!gve_is_qpl(priv) && priv->xdp_prog) {
> -		err =3D gve_configure_rings_xdp(priv, priv->rx_cfg.num_queues);
> -		if (err)
> -			return err;
> -	}
> -
> -	napi_rx =3D &priv->ntfy_blocks[priv->rx[qid].ntfy_id].napi;
> -	napi_disable_locked(napi_rx); /* make sure current rx poll is done */
> -
> -	tx_qid =3D gve_xdp_tx_queue_id(priv, qid);
> -	napi_tx =3D &priv->ntfy_blocks[priv->tx[tx_qid].ntfy_id].napi;
> -	napi_disable_locked(napi_tx); /* make sure current tx poll is done */
> -
> -	gve_unreg_xsk_pool(priv, qid);
> -	smp_mb(); /* Make sure it is visible to the workers on datapath */
> -
> -	napi_enable_locked(napi_rx);
> -	napi_enable_locked(napi_tx);

[ ... ]

> +	if (gve_is_qpl(priv)) {
> +		err =3D gve_unreg_xsk_pool_live(priv, dev, qid);
> +	} else {
> +		/* Stop and start RDA queues to repost buffers. */
> +		err =3D gve_restart_rings(priv);
> +	}

[Severity: Critical]
In the branch for RDA mode, gve_restart_rings() is called, but it appears
to omit unregistering the XSK pool, which was previously handled by
gve_unreg_xsk_pool().

Since gve_restart_rings() stops and starts the hardware queues reusing
the existing memory arrays, the tx->xsk_pool and rx->xsk_pool pointers
are never cleared to NULL. The pool memory is unmapped and subsequently
freed by the XDP framework.

When NAPI polling resumes on the restarted rings, could fast-path
functions like gve_clean_tx_done_dqo() check and dereference the stale
tx->xsk_pool pointer, leading to a use-after-free?

[Severity: Critical]
Also regarding this RDA mode restart path: when the rings are restarted,
the start path re-registers queues with the hardware, which resets the
device's expected descriptor pointers to 0.

However, looking at gve_tx_stop_ring_gqi(), it does not seem to reset
the software ring pointers (tx->req and tx->done) unlike the DQO path.

When transmission resumes, could the host use its stale absolute pointers
and ring the doorbell with a large offset, causing the device to
interpret this as a massive burst of packets and read uninitialized memory?

> diff --git a/drivers/net/ethernet/google/gve/gve_tx_dqo.c b/drivers/net/e=
thernet/google/gve/gve_tx_dqo.c
> --- a/drivers/net/ethernet/google/gve/gve_tx_dqo.c
> +++ b/drivers/net/ethernet/google/gve/gve_tx_dqo.c

[ ... ]

> +static void gve_tx_reset_ring_dqo(struct gve_tx_ring *tx)
> +{
> +	size_t size;
> +
> +	/* Reset dqo_tx fields. */
> +	tx->dqo_tx.head =3D 0;
> +	tx->dqo_tx.tail =3D 0;
> +	tx->dqo_tx.last_re_idx =3D 0;
> +	tx->dqo_tx.posted_packet_desc_cnt =3D 0;
> +	tx->dqo_tx.completed_packet_desc_cnt =3D 0;
> +	tx->dqo_tx.free_pending_packets =3D 0;

[Severity: High]
This function resets the standard TX fields, but it seems to miss
resetting the QPL allocation counters (tx->dqo_tx.alloc_tx_qpl_buf_cnt
and tx->dqo_tx.free_tx_qpl_buf_cnt).

Since gve_tx_init_ring_state_dqo() later sets
tx->dqo_compl.free_tx_qpl_buf_cnt to 0, will the available buffer
calculation upon restart use a stale, large alloc count against a zeroed
free count? This might make the queue incorrectly think no QPL buffers
are available, resulting in a TX stall.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260922194533.6313=
87-1-joshwash@google.com?part=3D8
