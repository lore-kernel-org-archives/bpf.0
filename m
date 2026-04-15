Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3C823254AE
	for <bpf@vger.kernel.org>; Wed, 15 Apr 2026 09:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776245739; cv=none; b=nrUsx+TiAGmHeGJYYAGCM8o5PCxOitfwnvIa/4fCqk2egajzcDW8V2Ma6tkXj0narK+LI9GUXs52niRZppT4Xuyh9wMixTzLsEsyqK6lhhz3ZhA+PzXjsfsop+5QU6ut6/v7+dOVzMQabNM+Na0NDpiVv/25GFIaKXffLY2XevI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776245739; c=relaxed/simple;
	bh=k7AlI8mUl0XizO+Uds2aYZ4w7uUQqGjZyEswaepdT6c=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=a+KcLQVEgD+67Dcak3DWldxdVh+s4ovZTWHZMGQ73BefnDFEAmFwyw1WijMiqwCClomf8wZr6NlYWPLoJCtIxZzrONUufbFjT/TXhFgW5y/bt6mnt/0Nc/uwEXuN2vfFylgr/sG7FVGGzlR4Rsth/zmjw5AxyfYbXnMaBMUTKb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Coc22Yx2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Coc22Yx2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A4BFC19424;
	Wed, 15 Apr 2026 09:35:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776245739;
	bh=k7AlI8mUl0XizO+Uds2aYZ4w7uUQqGjZyEswaepdT6c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=Coc22Yx2d0LaImt//9fYSYQ1C7DGLP+rNG9fP0aGHsYKEjJyr3TWPYMMHciFSpK9J
	 Fe5PExCsFd6Iw0jJh5dIfA8NKNPmg1AW6VSiTlgCRQ4sGynL6LpHZ4ZJlcugKSUGzD
	 kgYLeM69ESCr9hEc3DWaboZxwM0hDd/Mqv2g+d8k1lHyuzN01p0u1zCKvZsYzrmf39
	 qTjg7a7JY9ajeFe8yd18Vm8y7LrXO3C6ExZkQ3w/PaVsHsHMHbaMw5/4o5XsX9GPVX
	 3GyDSYkA1XyJI6gm3xlWjo6ZaoWpwNO8rqs1evR6kRi3GKE6iNwc9CRap/6LiC4ohR
	 /uOwDxMX6gbcQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC net-next v4 06/14] xsk: support dynamic xmit.more
 control for batch xmit
Reply-To: sashiko@lists.linux.dev
To: "Jason Xing" <kerneljasonxing@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260415082654.21026-7-kerneljasonxing@gmail.com>
References: <20260415082654.21026-7-kerneljasonxing@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 15 Apr 2026 09:35:38 +0000
Message-Id: <20260415093539.4A4BFC19424@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Sashiko AI review found 1 potential issue(s):
- [High] Stalled TX queue due to missing hardware doorbell ring on early lo=
op exit
--

commit 6d7c8f2ad056eb4cb2eec8d360e632f9ef9044f5
Author: Jason Xing <kernelxing@tencent.com>

xsk: support dynamic xmit.more control for batch xmit

This commit updates xsk batch transmission to only set xmit.more to false f=
or
the last skb in the send queue, aiming to reduce unnecessary IRQs and impro=
ve
batching performance.

> diff --git a/net/core/dev.c b/net/core/dev.c
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -4873,6 +4873,7 @@ int xsk_direct_xmit_batch(struct xdp_sock *xs, stru=
ct net_device *dev)
>  	struct sk_buff_head *send_queue =3D &xs->batch.send_queue;
>  	int ret =3D NETDEV_TX_BUSY;
>  	struct sk_buff *skb;
> +	bool more =3D true;
> =20
>  	local_bh_disable();
>  	HARD_TX_LOCK(dev, txq, smp_processor_id());

[ ... ]

> @@ -4892,8 +4893,12 @@ int xsk_direct_xmit_batch(struct xdp_sock *xs, str=
uct net_device *dev)
>  			__skb_queue_head(send_queue, skb);
>  			break;
>  		}
> +
> +		if (!skb_peek(send_queue))
> +			more =3D false;
> +
>  		skb_set_queue_mapping(skb, queue_id);
> -		ret =3D netdev_start_xmit(skb, dev, txq, false);
> +		ret =3D netdev_start_xmit(skb, dev, txq, more);
>  		if (ret !=3D NETDEV_TX_OK) {
>  			if (ret =3D=3D NETDEV_TX_BUSY)
>  				__skb_queue_head(send_queue, skb);
>  			break;
>  		}
>  	}

If an error occurs and the loop breaks early, does this leave previously
transmitted packets stalled in the driver's TX ring?

Since more is passed as true for all packets prior to the failure, the
network driver defers ringing the hardware TX doorbell.

If the code breaks out of the loop due to validate_xmit_skb_list() failing,
netif_xmit_frozen_or_drv_stopped(), or netdev_start_xmit() returning
NETDEV_TX_BUSY, the loop terminates without ever passing more =3D false to =
the
driver.

Could this omission prevent the hardware from being notified to transmit
the successfully processed packets that preceded the error?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260415082654.2102=
6-1-kerneljasonxing@gmail.com?part=3D6
