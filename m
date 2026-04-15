Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7786432A3C8
	for <bpf@vger.kernel.org>; Wed, 15 Apr 2026 09:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776245881; cv=none; b=bUrBbLFf8WPVMOB+JzvFgfMOc1XZN/lzk5M0nR/bsuqXlBNPs9J4dcY4WrjULPFJdcG1ps0dPqs/JXhV/Y/0Nm3RkSQmbkl/oIby3zD5L6UX5UTZcFHihMMqDiiFzoEyczpFE7Dr0UsI8nYsiRP9hJmKj9brMVWgo0rR+H6B5eM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776245881; c=relaxed/simple;
	bh=mcYi8VmykU5CBwf3ecUrQNP7fc0qFK+CcKZj81u7QF0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=AIpAuDklmhZ+7ZLIk8wjma5jQPb9rsqfCz0nldPPZOz5L2SqDuIX4oO7Cb0/eE6GLaV4rv+rlANZTTN7cZd2vCj47zKr2xw92Bd7k741tr7PEVmGUwxpcSB2bKzAQ8VcfymwdJxeaMrUqZu5IDT3kzOrTFeVcpUPyq0FP6/36hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r+tSCxq1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r+tSCxq1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CECEC19424;
	Wed, 15 Apr 2026 09:38:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776245881;
	bh=mcYi8VmykU5CBwf3ecUrQNP7fc0qFK+CcKZj81u7QF0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=r+tSCxq1I9Nz6Cb+SYh/66Q9D4okh7rR/VUUzIMKajua8C9xazXmbPJEtaCwaBTRQ
	 sWkyAeKMpJUeqyDvRG792iUPWrnKWrpCN1e/YFm7U8096nZ6gm2viPpnX92XiVLc7J
	 zuURQY/C+vIzUkNXjdNIkJU/enXUp+40k6RhOI2D/uJCXM2Xs7L5XKuVzTkMINOUgW
	 +oSyAMTEk7O5mJa7t3D7MA2Ao7OteyAxKNqAeFgBikvoQh0DwUSYD4WF/XbNFnv4Pf
	 8gtxZpXj3nI/GTCJgAdshLuyLBXj/zSPXojriBRyDXKMmd5o6gWUAfUmhCTCUfBJ3V
	 LZiHr9Lc+9SyQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC net-next v4 11/14] xsk: support batch xmit main
 logic
Reply-To: sashiko@lists.linux.dev
To: "Jason Xing" <kerneljasonxing@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260415082654.21026-12-kerneljasonxing@gmail.com>
References: <20260415082654.21026-12-kerneljasonxing@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 15 Apr 2026 09:38:00 +0000
Message-Id: <20260415093801.0CECEC19424@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Sashiko AI review found 5 potential issue(s):
- [Critical] TOCTOU race on socket state pointers leading to NULL pointer d=
ereference and Use-After-Free.
- [Critical] Integer underflow in `xsk_alloc_batch_skb()` leading to massiv=
e OOB memory allocation and kernel crash.
- [Critical] Unconditional dropping of partially built packets (`xs->skb`) =
causes buffer leaks and packet stream corruption.
- [High] Double cancellation of CQ slots and incorrect TX pointer manipulat=
ion on SKB build failure.
- [High] Infinite `-EAGAIN` livelock and stat inflation when packets span b=
atch boundaries.
--

commit 4041fe3cb310f6f01b04ae2ff1fbd04cf0aa2713
Author: Jason Xing <kernelxing@tencent.com>
xsk: support batch xmit main logic

This commit implements the core logic for batched transmission in AF_XDP
sockets via __xsk_generic_xmit_batch(). It introduces a loop to read
descriptors, reserve completion queue slots, allocate SKBs, and transmit
packets in batches.

> diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> index b4f3cc7125804..16e47f6fc30ec 100644
> --- a/net/xdp/xsk.c
> +++ b/net/xdp/xsk.c
[ ... ]
> @@ -914,6 +914,122 @@ struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
>  	return ERR_PTR(err);
>  }
> =20
> +static int __xsk_generic_xmit_batch(struct xdp_sock *xs)
> +{
> +	struct xsk_buff_pool *pool =3D xs->pool;
> +	struct xsk_batch *batch =3D &xs->batch;
> +	struct xdp_desc *descs =3D batch->desc_cache;
> +	struct net_device *dev =3D xs->dev;
> +	u32 max_batch, max_budget;
> +	bool sent_frame =3D false;
> +	struct sk_buff *skb;
> +	u32 cons_descs;
> +	int err =3D 0;
> +	u32 i =3D 0;
> +
> +	mutex_lock(&xs->mutex);

Can a TOCTOU race occur here with a concurrent socket bind() or setsockopt(=
)?

The pointers for pool, dev, and batch->desc_cache are read before the mutex
is acquired. If another thread modifies the socket state, could these
pointers be NULL or freed by the time xsk_is_bound() is checked, leading to
a use-after-free or NULL pointer dereference when accessing dev or descs?

> +
> +	/* Since we dropped the RCU read lock, the socket state might have chan=
ged. */
> +	if (unlikely(!xsk_is_bound(xs))) {
[ ... ]
> +	for (i =3D 0; i < max_budget; i +=3D cons_descs) {
> +		u32 nb_pkts =3D 0;
> +		u32 nb_descs;
[ ... ]
> +		cons_descs =3D xskq_cons_read_desc_batch_copy(xs->tx, pool, descs,
> +							    nb_descs, &nb_pkts);
> +		if (cons_descs < nb_descs) {
> +			u32 delta =3D nb_descs - cons_descs;
> +
> +			xsk_cq_cancel_locked(pool, delta);
> +			xs->tx->queue_empty_descs +=3D delta;
> +			if (!cons_descs) {
> +				err =3D -EAGAIN;
> +				goto out;
> +			}

Could this lead to an infinite -EAGAIN livelock and inflated statistics?

If a multi-fragment packet spans beyond the nb_descs batch limit without an
end-of-packet descriptor, xskq_cons_read_desc_batch_copy() might safely
rewind the fragments and return 0. The code then treats these valid
descriptors as empty, adds to queue_empty_descs, and returns -EAGAIN,
causing the application to loop infinitely hitting the same boundary.

> +			nb_descs =3D cons_descs;
> +		}
> +
> +		cons_descs =3D xsk_alloc_batch_skb(xs, nb_pkts, nb_descs, &err);

Does this calculation of nb_pkts trigger an integer underflow?

If a batch contains only fragments without an end-of-packet flag, nb_pkts
will be 0. Inside xsk_alloc_batch_skb(), if there is an existing partially
built skb (xs->skb !=3D NULL), the code may decrement nb_pkts. Since nb_pkts
is unsigned, nb_pkts-- would underflow to 0xFFFFFFFF, resulting in a
massive out-of-bounds memory allocation.

> +		/* Return 'nb_descs - cons_descs' number of descs to the
> +		 * pool if the batch allocation partially fails
> +		 */
> +		if (cons_descs < nb_descs) {
> +			xskq_cons_cancel_n(xs->tx, nb_descs - cons_descs);
> +			xsk_cq_cancel_locked(pool, nb_descs - cons_descs);
> +		}

Can this cause a double cancellation of completion queue slots?

If xsk_build_skb() fails inside xsk_alloc_batch_skb() due to memory limits,
it already calls xsk_cq_cancel_locked() internally:

net/xdp/xsk.c:xsk_build_skb() {
	...
	if (err =3D=3D -EOVERFLOW) {
		...
	} else {
		xsk_cq_cancel_locked(xs->pool, 1);
	}
}

Calling xsk_cq_cancel_locked() again here for the failed descriptors would
underflow the completion queue pointers, potentially corrupting the user
space ring buffer.=20

Also, does xsk_build_skb() advancing the TX consumer pointer on -EOVERFLOW
conflict with the rewind happening here?

[ ... ]
> +		if (err)
> +			goto out;
> +	}
> +
> +	/* Maximum budget of descriptors have been consumed */
> +	if (xskq_has_descs(xs->tx))
> +		err =3D -EAGAIN;
> +
> +out:
> +	if (xs->skb)
> +		xsk_drop_skb(xs->skb);

Does unconditionally dropping the partially built xs->skb corrupt the packet
stream?=20

If transmission hits a NETDEV_TX_BUSY (-EAGAIN) or a valid multi-fragment
packet spans a batch boundary, the code drops the fragments processed so fa=
r.=20
Because the completion queue slots and TX pointers for these early fragments
might not be properly rewound or notified, does this permanently leak buffe=
rs
and merge unrelated fragments into corrupted packets on the next sendmsg()
retry?

> +
> +	/* If send_queue has more pending skbs, we must to clear
> +	 * the rest of them.
> +	 */
> +	while ((skb =3D __skb_dequeue(&batch->send_queue)) !=3D NULL) {

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260415082654.2102=
6-1-kerneljasonxing@gmail.com?part=3D11
