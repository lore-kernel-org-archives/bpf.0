Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B78D23C50A
	for <bpf@vger.kernel.org>; Sat, 30 May 2026 00:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780101858; cv=none; b=NduaiBSorMtqWz0u2abMqU/eQL3AYsWAPJQSygqoC2L7Ab+ZvdPJhXCz50HD7DMZr4wNNnbIh1u8UvpECaQgcLrq7vX9iFC/+yB7zN9YT1M4vrqhmctWVkkgXs0SE4pO5x0Hgk/NcDU/KxLZld6H8p8r73P81EToeZWA0G0lWx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780101858; c=relaxed/simple;
	bh=FjcpK6tmezoOt6b7LyiOrXeT3Hxfj/tlqctt4oWlc20=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=XAjztTG1z3AhGIcL8nBen+gf+IEgtaSRTvNiRlFpf5fvoPv60TQsU/3Z6BZorNXHyeqOYU/tUgA65dGjAXhG35igej6YedyMkl3IJvVGKyFIiQ4wugyrTefhAdYf7Qyc60uyxku0zEwW2RQQHtr7J3gpvocW4IwQDywnj4y9MXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=atqptJyO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="atqptJyO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFDC11F00898;
	Sat, 30 May 2026 00:44:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780101857;
	bh=cK62szyRydz+xagPUjmMWlQD0rninCF8/FCuy03dHJU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=atqptJyOoZXaY3I44/Ihf1Lp4K6JNagFMYNYJLD0uWXURhijI3vqrlxBPjzJXekjf
	 h+pliyr26rmraXhCVAfXMowBN+bK6CrttsplajLFN17zO7Liwv/+xkEEihQy7aEno+
	 SVnsTlouaVrXzxqGxZZtqLkYKpse+TPdyRSD109TaB9fYuquaTUYOH2h2ejvxd+Sez
	 Y0dNlFwAo39snD2NWl16Rpf2Bb4RCjCKKknLRlK4yXnaHceWGF1EkPU5zGf4yQ5zFe
	 tQzt9XhJTuLoW0cdGzLjt0cc/tVqe6XsIkXbIthTFlFG1nGDJrI412LPRc4BN1VvqY
	 89p9BHUZ+ytYw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v4 3/5] xsk: drain continuation descs after overflow
 in xsk_build_skb()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jason Xing" <kerneljasonxing@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260520004244.55663-4-kerneljasonxing@gmail.com>
References: <20260520004244.55663-4-kerneljasonxing@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 30 May 2026 00:44:16 +0000
Message-Id: <20260530004416.EFDC11F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Invalid TX descriptors cause `drain_cont` state desynchronization,=
 leading to dropped or corrupted packets.
--

commit 964153358c7221b02aafc63e0caa53629df56557
Author: Jason Xing <kerneljasonxing@gmail.com>

xsk: drain continuation descs after overflow in xsk_build_skb()

This commit fixes a bug where leftover continuation descriptors remain
in the TX ring after an -EOVERFLOW drop in xsk_build_skb(). It introduces
a drain_cont flag to process and drop the remaining fragments of an
oversized multi-buffer packet, preventing corruption of the packet stream.

Closes: https://lore.kernel.org/all/20260425041726.85FB3C2BCB2@smtp.kernel.=
org/
Fixes: cf24f5a5feea ("xsk: add support for AF_XDP multi-buffer on Tx path")

[ ... ]

> diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> index 0a6203c425766..f4add7be8c935 100644
> --- a/net/xdp/xsk.c
> +++ b/net/xdp/xsk.c
> @@ -1062,11 +1062,30 @@ static int __xsk_generic_xmit(struct sock *sk)
>  			goto out;
>  		}
> =20
> +		if (unlikely(xs->drain_cont)) {
> +			unsigned long flags;
> +			u32 idx;
> +
> +			spin_lock_irqsave(&xs->pool->cq_prod_lock, flags);
> +			idx =3D xskq_get_prod(xs->pool->cq);
> +			xskq_prod_write_addr(xs->pool->cq, idx, desc.addr);
> +			xskq_prod_submit_n(xs->pool->cq, 1);
> +			spin_unlock_irqrestore(&xs->pool->cq_prod_lock, flags);
> +
> +			xs->tx->invalid_descs++;
> +			xskq_cons_release(xs->tx);
> +			if (!xp_mb_desc(&desc))
> +				xs->drain_cont =3D false;
> +			continue;
> +		}
> +
>  		skb =3D xsk_build_skb(xs, &desc);
>  		if (IS_ERR(skb)) {
>  			err =3D PTR_ERR(skb);
>  			if (err !=3D -EOVERFLOW)
>  				goto out;
> +			if (xp_mb_desc(&desc))
> +				xs->drain_cont =3D true;
>  			err =3D 0;
>  			continue;
>  		}

[Severity: High]
Could this leave xs->drain_cont set to true if an invalid descriptor is
encountered?

When xskq_cons_peek_desc() encounters an invalid TX descriptor (like an
out-of-bounds address), it returns false and terminates the while loop
early.

The invalid descriptor is then consumed by xskq_cons_release() outside the
loop:

net/xdp/xsk.c:__xsk_generic_xmit() {
    ...
    while (xskq_cons_peek_desc(xs->tx, &desc, xs->pool)) {
        ...
    }

    if (xskq_has_descs(xs->tx)) {
        if (xs->skb)
            xsk_drop_skb(xs->skb);
        xskq_cons_release(xs->tx);
    }
    ...
}

If xs->drain_cont was true, and this invalid descriptor happens to be the
last fragment of the overflowed packet, the loop exits before evaluating
the XDP_PKT_CONTD flag or clearing xs->drain_cont.

Will this cause a regression where the next valid packet transmitted by the
application is erroneously treated as a drained fragment and dropped because
xs->drain_cont remained true?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260520004244.5566=
3-1-kerneljasonxing@gmail.com?part=3D3
