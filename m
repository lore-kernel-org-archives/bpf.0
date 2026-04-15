Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13008313537
	for <bpf@vger.kernel.org>; Wed, 15 Apr 2026 09:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776245582; cv=none; b=ovIbZSDCZmGdUPc2b+bK62BX+aG7keCDo1I2VzeD6TQdFC7x2sUj/uAkQDcBGTQXVGRS1fjm/P28nC9xNvR7V5tUnVCOHomje1dcZo1JEoktFk+ZTV/QknHwFMaZbwHoKOINDvr+8ctAAtH6raKYl3rJ2/2loiqMs18r3oGxX8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776245582; c=relaxed/simple;
	bh=HsFKdPS75pn/QKx0B7LXRXR0MzhR9LPCp7qj4tOemSM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=OqtNgpGx/UpLhc8g75gfYIermBilANTXe/NxinHxbMeXZiYmaHk8pbQi7PnBTOAwAK5FMK3kBsRgACx0Yr6Loly8C4h27Saaq7f0ocfr/sIbNqomhxdBvE0wpuQEJp6Jm9a+mGpIJucj7oRfAqQkMuA6xNKtfbq4gchHrnd6HSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mOAs44JO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mOAs44JO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 799F2C19424;
	Wed, 15 Apr 2026 09:33:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776245581;
	bh=HsFKdPS75pn/QKx0B7LXRXR0MzhR9LPCp7qj4tOemSM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=mOAs44JOpY6vg32ScdJkkoEWW/XJ0w0MAVDQ934efo8m1+kVkdJHz2xfwhul5afeY
	 MjYZUx6+3GTQaHovnSxU6LDUQoFQZ+5Vy/Aa3mByWrLjTNFRhCtLG0PAAlLJ5zzCEh
	 xmM3LkAl8PTeL/iuUdbN84WLnxUj+JdjBw9yENtcLT3iWOWLyx14fMXr1Ox8VsgqvP
	 AeFLLEMBWZ3meoUbJpdD1/E4y74T3wW9JXW/wIYS5xuWBnCxY3D0Ma6X+cuuQyXRKu
	 IvHMopnHdwViLou0xtJ1Z9nNz++dwTCNv3wxasvO0vgkagW3owB8q08cEf4U6n+gAV
	 j6HXE1PdlzRdw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC net-next v4 07/14] xsk: try to skip validating skb
 list in xmit path
Reply-To: sashiko@lists.linux.dev
To: "Jason Xing" <kerneljasonxing@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260415082654.21026-8-kerneljasonxing@gmail.com>
References: <20260415082654.21026-8-kerneljasonxing@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 15 Apr 2026 09:33:00 +0000
Message-Id: <20260415093301.799F2C19424@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Sashiko AI review found 2 potential issue(s):
- [Critical] Bypassing `validate_xmit_skb_list()` based on `NETIF_F_SG` ski=
ps critical hardware capability checks, software fallbacks, and SKB initial=
ization, leading to kernel panics and corrupted packets.
- [High] Breaking out of the transmit loop early leaves packets stuck in th=
e TX ring indefinitely because the hardware doorbell is never flushed.
--

commit 7603ac608a36b8d39e026a60b567ea2b106617f0
Author: Jason Xing <kernelxing@tencent.com>

xsk: try to skip validating skb list in xmit path

This patch attempts to optimize the XSK transmit path by skipping
validate_xmit_skb_list() if the device supports Scatter-Gather,
aiming to improve performance for drivers like ixgbe.

> diff --git a/net/core/dev.c b/net/core/dev.c
> index 99188353abec6..12643cbab6530 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
[ ... ]
> @@ -4878,15 +4879,17 @@ int xsk_direct_xmit_batch(struct xdp_sock *xs, st=
ruct net_device *dev)
>  	local_bh_disable();
>  	HARD_TX_LOCK(dev, txq, smp_processor_id());
>  	while ((skb =3D __skb_dequeue(send_queue)) !=3D NULL) {
> -		struct sk_buff *orig_skb =3D skb;
> -		bool again =3D false;
> -
> -		skb =3D validate_xmit_skb_list(skb, dev, &again);
> -		if (skb !=3D orig_skb) {
> -			dev_core_stats_tx_dropped_inc(dev);
> -			kfree_skb_list(skb);
> -			ret =3D NET_XMIT_DROP;
> -			break;
> +		if (unlikely(need_validate)) {
> +			struct sk_buff *orig_skb =3D skb;
> +			bool again =3D false;
> +
> +			skb =3D validate_xmit_skb_list(skb, dev, &again);

Does skipping validate_xmit_skb_list() based on NETIF_F_SG bypass necessary
hardware capability checks and software fallbacks?

validate_xmit_skb() performs dynamic feature verification via
ndo_features_check(), transport header initialization via
skb_set_transport_header(), and software checksum fallbacks via
skb_csum_hwoffload_help().

AF_XDP users can request TX checksum offload, setting skb->ip_summed to
CHECKSUM_PARTIAL. By skipping validation solely because the device supports
Scatter-Gather, packets bypass skb_set_transport_header(), leaving
skb->transport_header uninitialized.

Could this cause drivers that use skb_transport_offset() to compute massive
sizes, corrupting TX descriptors and potentially hanging the NIC?

Additionally, if the device lacks NETIF_F_HW_CSUM, skipping
skb_csum_hwoffload_help() sends CHECKSUM_PARTIAL to drivers unable to handle
it. Might this result in silent data corruption on the wire or driver crash=
es?

> +			if (skb !=3D orig_skb) {
> +				dev_core_stats_tx_dropped_inc(dev);
> +				kfree_skb_list(skb);
> +				ret =3D NET_XMIT_DROP;
> +				break;

If this loop breaks early, does it leave packets stuck in the TX ring?

While this behavior was introduced earlier in the series and not by this
specific patch, the issue is present in this modified block.

The batching logic calls netdev_start_xmit() with more =3D true for all pac=
kets
except the last one in the queue.

If the loop breaks early here due to a validate_xmit_skb_list() failure,
the function returns without ever calling netdev_start_xmit() with
more =3D false.

Will this cause the driver to defer ringing the hardware TX doorbell,
leaving previously submitted packets stranded in the TX ring and causing
latency spikes or TX watchdog timeouts?

> +			}
>  		}
> =20
>  		if (netif_xmit_frozen_or_drv_stopped(txq)) {

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260415082654.2102=
6-1-kerneljasonxing@gmail.com?part=3D7
