Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75D8533CEBB
	for <bpf@vger.kernel.org>; Mon, 29 Jun 2026 07:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782718416; cv=none; b=QycrTEsif0Gsy+GSLKnrCfHeGks//QyP+TqeAlHw7U9d+v0PZ9Z3Z9G4XwxE9AiT9UP92VILbDeXkV9HYdwVlgj+WsyMPrwwwEHcxU/rGOPNLZnRKXV5AwoAJLo3CO8P0SFxt3KfgWlGxbjMwf6DO1A7WCFHWHbmLTDMvRpiqA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782718416; c=relaxed/simple;
	bh=wZOZKDoWljGUlkL8ex4s+ssqSNZ3LpZ3oxuaFqAxkK4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=nvvHDW/fQcZ+K83xPu52qfZSdvqZJNkQAQX/wowGKgF14u3n6UI8hBtQrUwyocG7wiIXleDqe+auaAp32klD+TTPmjRSTl6QR5yhQxhMTTt0YJKCDjUeMl10lWac8Yq3e7r3ly6p8hyXflV9nvp0l74cSsbD9syHzz8giM+lbUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lAB4T5ft; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lAB4T5ft"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 852031F000E9;
	Mon, 29 Jun 2026 07:33:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782718411;
	bh=hRYbDqwtb+f2D8x5guszg7rv9vG47h6HOtUNyvgworY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lAB4T5ftAojgaJjLmQgtGUbmDnPHWIOPxvuTd4ffl5M7xXp2WfFHbhQspiXqxDF6K
	 KQ5XVXdKTXfqy0SNenY2zWyXZglEVaXaUtq+MZC+nX7kQu7kavFd3oqGGwyVfe7BKi
	 yy9x6XRwij5wBvUnfWyAn4RXaTmGWdGQYK61vda4Wt0OFRCtdKvC1wE0pehgzGXT2i
	 QreBRpvOxTlNFCLsCBmK6KTleJn0LTDPO2T+HXSnGrgz2FlTxgLOgAkAE4i7ItW+Gj
	 2WN3vngue8lwvfEyelwxFrWK44b4a7kmHfioFuCbyJ/uqLOrYoFfsfUc8jm02Kj4Y7
	 j4gnq3b12VkZQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] xsk: fix memory corruptions in net/core/xdp.c
Reply-To: sashiko-reviews@lists.linux.dev
To: "Clement Lecigne" <clecigne@google.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260629072300.1664622-1-clecigne@google.com>
References: <20260629072300.1664622-1-clecigne@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 29 Jun 2026 07:33:31 +0000
Message-Id: <20260629073331.852031F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] The patch incorrectly rounds up the SKB logical length (`len`), ap=
pending uninitialized garbage bytes to the packet and corrupting its size.
--

commit 2b99f24545da4e2ce6d6317b4cc495604fb468a5
Author: Cl=C3=A9ment Lecigne <clecigne@google.com>

xsk: fix memory corruptions in net/core/xdp.c

This commit fixes a buffer overflow in xdp_build_skb_from_zc() when using
2KB UMEM chunks by accurately calculating the required truesize, including
SKB headroom and skb_shared_info overhead. It also fixes an out-of-bounds
write in xdp_copy_frags_from_zc() by aligning the allocation request size
with the memcpy operation.

> diff --git a/net/core/xdp.c b/net/core/xdp.c
> index 9890a30584ba7..7e39f17ad407d 100644
> --- a/net/core/xdp.c
> +++ b/net/core/xdp.c
[ ... ]
> @@ -738,9 +738,10 @@ static noinline bool xdp_copy_frags_from_zc(struct s=
k_buff *skb,
>   */
>  struct sk_buff *xdp_build_skb_from_zc(struct xdp_buff *xdp)
>  {
> +	u32 headroom =3D xdp->data_meta - xdp->data_hard_start;
>  	const struct xdp_rxq_info *rxq =3D xdp->rxq;
> -	u32 len =3D xdp->data_end - xdp->data_meta;
> -	u32 truesize =3D xdp->frame_sz;
> +	u32 len =3D LARGEST_ALIGN(xdp->data_end - xdp->data_meta);

[Severity: High]
Does redefining len with LARGEST_ALIGN() discard the exact packet payload
length needed for correct SKB construction?

> +	u32 truesize =3D SKB_HEAD_ALIGN(headroom + len);
>  	struct sk_buff *skb =3D NULL;
>  	struct page_pool *pp;
>  	int metalen;
[ ... ]
> @@ -762,7 +763,7 @@ struct sk_buff *xdp_build_skb_from_zc(struct xdp_buff=
 *xdp)
>  	}
> =20
>  	skb_mark_for_recycle(skb);
> -	skb_reserve(skb, xdp->data_meta - xdp->data_hard_start);
> +	skb_reserve(skb, headroom);
> =20
>  	memcpy(__skb_put(skb, len), xdp->data_meta, LARGEST_ALIGN(len));

[Severity: High]
Will passing the improperly aligned len to __skb_put() incorrectly inflate
the logical length of the constructed SKB?=20

If len is rounded up to the nearest LARGEST_ALIGN boundary, __skb_put()
will increase skb->len and skb->tail beyond the actual valid payload length.

Could this cause the trailing bytes to contain uninitialized data from UMEM,
leading to a potential info leak or data corruption when the SKB is
forwarded?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260629072300.1664=
622-1-clecigne@google.com?part=3D1
