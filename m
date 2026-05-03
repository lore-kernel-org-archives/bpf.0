Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89F46386C1C
	for <bpf@vger.kernel.org>; Sun,  3 May 2026 20:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777838965; cv=none; b=behIJGk2o59XCMtIIlSP/mVZCavRceitcDfUBFZgBNhhpHVz10OdrYp7eHKQ8WVyTf2g0HMniYIReRbCq0Hv/RDtg153evzQueP+oJ2yFzPYY2PqN/DSP1igHpBsTiHpm3INEkz29TNALNq51RrJ+ram3ZdEEV0g9i8WBticiic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777838965; c=relaxed/simple;
	bh=CRmEMPEfdjQduZRWrWqe3W4J9umvjMlGT1XmIQ9bI/0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=TQSxd9oW6XaqE0cBYox1hABhBkdCkSXTfWe560rsPtvIqUIRxMbIW0yUnEF4dm9HTzxlTA0C9MMHIwnFL/FPEkjUsMS+m4y4OFmxf7+YhA8UuIoZ72xModdsBs5/O42GYADqRIml53KEDnjz6BnhukpdR0ujDcXeQ5jvC6Hh920=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EsBySaGI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EsBySaGI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AD38C2BCB4;
	Sun,  3 May 2026 20:09:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777838965;
	bh=CRmEMPEfdjQduZRWrWqe3W4J9umvjMlGT1XmIQ9bI/0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=EsBySaGI6ePyhBwLHtXK8GKctgJQ0hQzrvNCQ/hjG/C2sbLzodTJA0VuNTQI2Z0jl
	 OSGUdoTxrEXFVS8+IRoDql2qK+KgtZzFh2eaYD8D7SbfiTx+0H8qV+bf6560U6yHG6
	 IkAtsjIlEQgMVgaYwvVf7tsbzuWj81TihIVY8uSIIS+Y/4hBF1G1dzKC5fujsqSx/q
	 XH7+qxeqrsg5+k3yvYFlgD6N6DdWn7oQohIGZtNJx0fyCedICS/OWNFV1Mk2EpvLQz
	 OvTb5OYNt70kA7nmfl9708YQAjVnEs2AaBCStc1A9tOBXbawxZsjl06qpS7o2wSRW5
	 Azj0/pllm3TJQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v5 3/8] xsk: handle NULL dereference of the skb
 without frags issue
Reply-To: sashiko@lists.linux.dev
To: "Jason Xing" <kerneljasonxing@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260502200722.53960-4-kerneljasonxing@gmail.com>
References: <20260502200722.53960-4-kerneljasonxing@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 03 May 2026 20:09:24 +0000
Message-Id: <20260503200925.1AD38C2BCB4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Completion Queue (CQ) state corruption when handling -EOVERFLOW fo=
r the first descriptor.
--

commit 819a57cd3753db9f503ac093f83dccc180da574d
Author: Jason Xing <kerneljasonxing@gmail.com>

xsk: handle NULL dereference of the skb without frags issue

This commit fixes a NULL pointer dereference when a first descriptor
triggers -EOVERFLOW in xsk_build_skb_zerocopy() by adding a check for
xs->skb. It handles the first-descriptor case by manually canceling the CQ
slot and incrementing invalid_descs.

> diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> --- a/net/xdp/xsk.c
> +++ b/net/xdp/xsk.c
> @@ -976,9 +976,14 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock=
 *xs,
>  		kfree_skb(skb);
> =20
>  	if (err =3D=3D -EOVERFLOW) {
> -		/* Drop the packet */
> -		xsk_inc_num_desc(xs->skb);
> -		xsk_drop_skb(xs->skb);
> +		if (xs->skb) {
> +			/* Drop the packet */
> +			xsk_inc_num_desc(xs->skb);
> +			xsk_drop_skb(xs->skb);
> +		} else {
> +			xsk_cq_cancel_locked(xs->pool, 1);

Does this cause a Completion Queue (CQ) state corruption?

When a first descriptor triggers -EOVERFLOW in xsk_build_skb_zerocopy(), the
free_err path first calls kfree_skb(skb) just above this code. Because
xsk_skb_init_misc() was called earlier, the SKB's destructor is set to
xsk_destruct_skb(). The kfree_skb() call invokes this destructor, which
submits a completion and increments the ring's producer index.

If we then call xsk_cq_cancel_locked() here, it decrements the reservation
index while the producer index was already incremented, breaking the core
invariant cached_prod >=3D ring->producer.=20

This causes space calculations to underflow and can overwrite unconsumed
entries in the CQ.

I see this was addressed later in the series by commit 88b75ff1d12b ("xsk:
prevent CQ desync when freeing half-built skbs in xsk_build_skb()").

> +			xs->tx->invalid_descs++;
> +		}
>  		xskq_cons_release(xs->tx);
>  	} else {
>  		/* Let application retry */

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260502200722.5396=
0-1-kerneljasonxing@gmail.com?part=3D3
