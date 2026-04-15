Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 984F530EF6C
	for <bpf@vger.kernel.org>; Wed, 15 Apr 2026 09:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776244319; cv=none; b=q5UzTaM+uDZrlxSDkvYrW6dhobh9x873NtDEbTFYjaUWS7FPtiwL9c19lTCv0ospv0atBa1Q77toRalwFk4LI3s64EHbqKs+ouFXUZRE2HssAC/5hgAyIxgwhymZlQfYxKQN/QsdP0csRhrVvjtKX2eZXZ19b7pYl+zdmJDM29E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776244319; c=relaxed/simple;
	bh=XcscAeLQzAA/GZuFLpc03JsdUyYC7A49yR4IfKPiRHE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=PUHuklybz1dMdeLz+SXbNP5+W13x+jaYax/pMHNL2wR0Mb11guHfd0O8MnMRVkjOpCyKkMWQTvuxYLGFVISg4TDIRCmSzFAoUNt8dbOadzqPoM2RZT6JZezwT8RzQBHwLKR6cMmcxK0pYotZW/hjX7NNyEOG6zME0XtohS6grb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=US/IpZ/V; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="US/IpZ/V"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BC4FC19424;
	Wed, 15 Apr 2026 09:11:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776244319;
	bh=XcscAeLQzAA/GZuFLpc03JsdUyYC7A49yR4IfKPiRHE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=US/IpZ/VsA0GQijQUm0n34+Vv5v5Tk+INPSDturI1xvtGdF4If5G/OSkurTL4l1JW
	 nB69l2n6zEQxMsbrRvRSIG9RE4yzee+WP/M9k8cu0tyndWhiipQG8KjO+v8LJzKBMx
	 mASsm47GiBT55bK3gU6vkUgeQwy/prrVZ8yPUpnq6mp6Y78X9pkOf8pUeqfNiM5T4o
	 L7XJqftTt2ZFgg5m8rFkkzKVTRdmk5k3H1x106i+m++8BQ6UgRksR2zHuL2KsJw+QB
	 Qj/3cPCwgIaJrEOZ1blmuI/RJiimYUHHD7UGI6+m3gmmL1sC+umlYDXRpO4G/B/B5c
	 lw2ihSLaH34hw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC net-next v4 05/14] xsk: add direct xmit in batch
 function
Reply-To: sashiko@lists.linux.dev
To: "Jason Xing" <kerneljasonxing@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260415082654.21026-6-kerneljasonxing@gmail.com>
References: <20260415082654.21026-6-kerneljasonxing@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 15 Apr 2026 09:11:58 +0000
Message-Id: <20260415091159.2BC4FC19424@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Sashiko AI review found 4 potential issue(s):
- [High] Packet validation executed inside hardware transmit lock, causing =
severe lock contention
- [High] Missing transmit recursion protection introduces deadlock vectors
- [High] Missing device state validation allows transmission to stopped or =
suspended devices
- [Medium] Hardware doorbell batching is defeated by hardcoded 'more' param=
eter
--

commit b98984346f64d24e3ecd521b219464ccbe9fba91
Author: Jason Xing <kernelxing@tencent.com>

xsk: add direct xmit in batch function

This commit adds a batch transmission logic for AF_XDP. It introduces a
new direct transmit function that disables bottom halves, grabs the lock
once, and sends all aggregated packets in a loop.

> diff --git a/net/core/dev.c b/net/core/dev.c
> --- a/net/core/dev.c
> +++ b/net/core/dev.c

[ ... ]

> +int xsk_direct_xmit_batch(struct xdp_sock *xs, struct net_device *dev)
> +{
> +	u16 queue_id =3D xs->queue_id;
> +	struct netdev_queue *txq =3D netdev_get_tx_queue(dev, queue_id);
> +	struct sk_buff_head *send_queue =3D &xs->batch.send_queue;
> +	int ret =3D NETDEV_TX_BUSY;
> +	struct sk_buff *skb;
> +

Should there be a check for the device state before attempting to transmit?
Direct transmit paths that bypass the Qdisc layer, like __dev_direct_xmit(),
typically verify that the device is running and the carrier is up:

	if (unlikely(!netif_running(dev) ||
		     !netif_carrier_ok(dev)))
		goto drop;

Could invoking transmission on a stopped or suspended device cause issues?

> +	local_bh_disable();

Are we missing transmit recursion protection here? Standard paths wrap the
hardware transmit lock with recursion tracking to protect against stack
overflows and deadlocks when routing through virtual devices:

	dev_xmit_recursion_inc();
	HARD_TX_LOCK(dev, txq, smp_processor_id());

> +	HARD_TX_LOCK(dev, txq, smp_processor_id());
> +	while ((skb =3D __skb_dequeue(send_queue)) !=3D NULL) {
> +		struct sk_buff *orig_skb =3D skb;
> +		bool again =3D false;
> +
> +		skb =3D validate_xmit_skb_list(skb, dev, &again);

Will executing validate_xmit_skb_list() inside the hardware transmit lock
cause lock contention? This function can perform computationally expensive
operations such as GSO segmentation, software checksum fallbacks, and
subsystem hooks. Other transmit paths execute this validation strictly
before acquiring the hardware lock.

> +		if (skb !=3D orig_skb) {
> +			dev_core_stats_tx_dropped_inc(dev);
> +			kfree_skb_list(skb);
> +			ret =3D NET_XMIT_DROP;
> +			break;
> +		}
> +
> +		if (netif_xmit_frozen_or_drv_stopped(txq)) {
> +			__skb_queue_head(send_queue, skb);
> +			break;
> +		}
> +		skb_set_queue_mapping(skb, queue_id);
> +		ret =3D netdev_start_xmit(skb, dev, txq, false);

Does passing false for the more parameter defeat the purpose of hardware
doorbell batching? It instructs the driver to ring the hardware doorbell for
every single packet instead of delaying it until the end of the batch.

It looks like this might be fixed later in the patch series by commit
6d7c8f2ad056e ("xsk: support dynamic xmit.more control for batch xmit").

> +		if (ret !=3D NETDEV_TX_OK) {
> +			if (ret =3D=3D NETDEV_TX_BUSY)
> +				__skb_queue_head(send_queue, skb);
> +			break;
> +		}
> +	}
> +	HARD_TX_UNLOCK(dev, txq);

Also, we would need to pair any added recursion increment with a decrement
here:

	dev_xmit_recursion_dec();

> +	local_bh_enable();
> +
> +	return ret;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260415082654.2102=
6-1-kerneljasonxing@gmail.com?part=3D5
