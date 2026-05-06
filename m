Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DD7330E0D5
	for <bpf@vger.kernel.org>; Wed,  6 May 2026 18:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778093441; cv=none; b=Beei7nQ2fpAbpcZtyKUDW2kiIwNi+Pis/Xh2GtakfVqeRJ0ewbX2SAZ5rYoXtbvpUMFjmBcdui7oIhMJLi5IRNbq+tH+Xvz2gAr8JHi0ilWEAfjcfA2olikbqFIr7TnnG3w1y4Ffi1nxRbdbzny2Dxo9L/trGxluXYclMQE9HyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778093441; c=relaxed/simple;
	bh=7Lju96bFqUm5R3L1CmwnzDMlukkEI3ssxu7dXLCVz44=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=fJgCn8VpsEA7011pbIHyNYZAddtl+uy9LLeMbMZCnLUF7nyrpll9E97CwwXQkrpOKLutmtYENVazsFzEhv9Vjb1KuPbY6eWNHKgy/9S3qicnYXG8n6l9b2pxnevgJAFBPHvq9lEf1ufyrx3RMRYi2otheSTKdk4OBkRMCJ4IdTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QVF0wMlu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QVF0wMlu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53895C2BCB0;
	Wed,  6 May 2026 18:50:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778093440;
	bh=7Lju96bFqUm5R3L1CmwnzDMlukkEI3ssxu7dXLCVz44=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=QVF0wMluGgCFly0vhp5hECUHn20aT7i4X5+rHlS++ByRIGXsqBZVgr4XhDVXl2rP6
	 LhNTQKcOo82KDUSPp8b9A5y+dfuCc9vnhCeb5zbjxaC9wqwfnD1wjvGJEJa8XPl90a
	 I7nPjCznMvmfGumqAONi+bpS67K2LVpjPzF8ey0PJyJoa1HFJoxzUHREJLJNEMyuU1
	 ylG0kOp+pAFjYs2NZOvsK4LCOuXPaLOM8b+MCZ7kkySnS0fXO93g/RHg9r/cgAe01a
	 0Mv7U6x9fcE9uzT1+s19y56bU3JZoyBMZe09lSR82wFPmmIWYG6eV3Q229ZNRKtaGE
	 7C6JhBetOhE6g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v5 3/5] veth: implement Byte Queue Limits (BQL)
 for latency reduction
Reply-To: sashiko@lists.linux.dev
To: hawk@kernel.org
Cc: bpf@vger.kernel.org
In-Reply-To: <20260505132159.241305-4-hawk@kernel.org>
References: <20260505132159.241305-4-hawk@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 06 May 2026 18:50:39 +0000
Message-Id: <20260506185040.53895C2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] Resetting the peer's TX queue during NAPI deletion fails to explic=
itly schedule the qdisc if it was stopped solely by BQL, potentially strand=
ing buffered packets indefinitely.
- [High] veth_napi_del_range() conditionally skips waking the peer's stoppe=
d TX queue when the local device is going down, permanently leaking the DRV=
_XOFF stop state on the peer.
- [Medium] DRV_XOFF queue wakeups are bypassed for deactivated TX queues, l=
eading to permanently stuck queues if reactivated.
--

commit 1b05a5559481675536cd1059fcf1bd7e7b6e721c
Author: Jesper Dangaard Brouer <hawk@kernel.org>
Subject: veth: implement Byte Queue Limits (BQL) for latency reduction

This commit adds Byte Queue Limits (BQL) support to veth to give qdiscs=20
visibility into the ptr_ring queue depth, reducing base latency. It charges=
=20
a fixed unit per packet under the producer lock and resets BQL state on=20
NAPI deletion.

> diff --git a/drivers/net/veth.c b/drivers/net/veth.c
> index 0cfb19b760dd5..86b78900c48e3 100644
> --- a/drivers/net/veth.c
> +++ b/drivers/net/veth.c

[ ... ]

> @@ -1074,6 +1118,7 @@ static int __veth_napi_enable(struct net_device *de=
v)
>  static void veth_napi_del_range(struct net_device *dev, int start, int e=
nd)
>  {
>  	struct veth_priv *priv =3D netdev_priv(dev);
> +	struct net_device *peer;
>  	int i;
> =20
>  	for (i =3D start; i < end; i++) {
> @@ -1092,6 +1137,24 @@ static void veth_napi_del_range(struct net_device =
*dev, int start, int end)
>  		ptr_ring_cleanup(&rq->xdp_ring, veth_ptr_free);
>  	}
> =20
> +	/* Reset BQL and wake stopped peer txqs.  A concurrent veth_xmit()
> +	 * may have set DRV_XOFF between rcu_assign_pointer(napi, NULL) and
> +	 * synchronize_net(), and NAPI can no longer clear it.
> +	 * Only wake when the device is still up.
> +	 */
> +	peer =3D rtnl_dereference(priv->peer);
> +	if (peer) {
> +		int peer_end =3D min_t(int, end, peer->real_num_tx_queues);
> +
> +		for (i =3D start; i < peer_end; i++) {
> +			struct netdev_queue *txq =3D netdev_get_tx_queue(peer, i);
> +
> +			netdev_tx_reset_queue(txq);
> +			if (netif_running(dev))
> +				netif_tx_wake_queue(txq);

Does netdev_tx_reset_queue() clear STACK_XOFF without scheduling the qdisc?

If netif_tx_wake_queue() only schedules the qdisc when DRV_XOFF was set,
wouldn't a queue stopped solely by BQL (STACK_XOFF set, DRV_XOFF clear) be
stalled indefinitely here?

By checking netif_running(dev), the wakeup is skipped when the local device
is brought down. Does this permanently leak the DRV_XOFF state on the peer?
If the local device is brought back up later, it appears the peer's TX queue
would remain wedged.

Additionally, if a user reduces the peer's active TX queues (e.g., via
ethtool), the loop bound peer->real_num_tx_queues will skip deactivated
queues.

If those inactive queues had DRV_XOFF set, do they retain that state
permanently when reactivated later, since BQL resets on real_num changes
but DRV_XOFF does not?

> +		}
> +	}
> +
>  	for (i =3D start; i < end; i++) {
>  		page_pool_destroy(priv->rq[i].page_pool);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260505132159.2413=
05-1-hawk@kernel.org?part=3D3
