Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 487303AA4E4
	for <bpf@vger.kernel.org>; Fri, 26 Jun 2026 09:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782464940; cv=none; b=R8K8TY9n1ob1YTLTs75gQhvd8sITIUXyVDVe6NlE8K81jybVRyxZsReDISAncg9rfFoEXfCB4SkTwK85piWBP+xcLf8foza01n+dO6KNZFk3iDr/LbOukFOKR+Hmnh6UYCYoWB7xsVTeGrTuXV8pWXkxWm0AGYfmM8+/B8Rc/M0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782464940; c=relaxed/simple;
	bh=ISjDigds5McU5v7l3HrH4zvRsBc2//A/3e1t2Z/3OXQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=JB/me9uYM9c/DHEHUSqkewWAn1GyJvEDfDPBaNVAw4wGx+FNojRrerxUw1ZO3yBYgmHhN1Faf5E0mIwro4MEIRgyIpmYPLpmUMZ+ODLB4gESms7QtlJckoYH7aqzfX2K4gcfvq351F3AJhOq+h/bwJokqxdwX99pMpkeI2tW9NU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TVjkf8zL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TVjkf8zL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BED261F000E9;
	Fri, 26 Jun 2026 09:08:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782464938;
	bh=q6F8XAJ21jw25GCHvweLyg6Kzn4aIk3kxdqtYt/q4cA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TVjkf8zLJE8+X0xdGbt6OcOQ9WK0JQ+aIedKtWBzpyvllNYNHYH8iyhHdjJvUUdtT
	 M6KR/DhZXxAqrgd7Mk4BbJtSuLxDIM4HN8GyrETml3p9lurO3T6xikyOd9dzQOE+oI
	 M2vI5cxvLgT8pkbolTI0R/2OWkc9gw+3KZVDh9I1trAjj9ZLmWPgJD13R+LAGhuWZN
	 xfGiRQ14kdPIC/WzcApVIjgsMMze2u9clruoGCvhBj7e8AHbqxCuKljJ6w3WFfvPZQ
	 SBbRruQUY4xl7kJXiR71+n/RMIrqXIM4KH3Jpr0Ai76YvlV8rVVa1wpxluKFVimrgp
	 MbZIoqrYRSkqQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] xsk: fix memory corruptions in net/core/xdp.c
Reply-To: sashiko-reviews@lists.linux.dev
To: "Clement Lecigne" <clecigne@google.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260626085226.1765180-1-clecigne@google.com>
References: <0922ce5d-48d8-44e7-983c-e547f3126ef4@intel.com>
 <20260626085226.1765180-1-clecigne@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 26 Jun 2026 09:08:58 +0000
Message-Id: <20260626090858.BED261F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Critical] The exact dynamic allocation sizing in xdp_build_skb_from_zc()=
 combined with a rounded-up memcpy() introduces a reliable out-of-bounds wr=
ite into skb_shared_info.
--

commit 332575c8834e99019b6ead4fd6570c4662e36762
Author: Cl=C3=A9ment Lecigne <clecigne@google.com>

xsk: fix memory corruptions in net/core/xdp.c

This commit attempts to fix out of bounds writes during AF_XDP zero-copy
frame conversions. It introduces dynamic truesize calculations using
SKB_HEAD_ALIGN for the skb allocation and LARGEST_ALIGN for fragment
allocations to properly account for required headroom and packet length.

> diff --git a/net/core/xdp.c b/net/core/xdp.c
> index 9890a30584ba7..52546746378a0 100644
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
>  	u32 len =3D xdp->data_end - xdp->data_meta;
> -	u32 truesize =3D xdp->frame_sz;
> +	u32 truesize =3D SKB_HEAD_ALIGN(headroom + len);

[Severity: Critical]
Does this regression allocate enough linear space to handle a rounded-up
memcpy when the headroom is unaligned?

If an XDP program adjusts data_meta such that headroom is not a multiple of
64 (for example, 252 bytes), and a packet of 68 bytes is received, the
allocated linear size from SKB_HEAD_ALIGN(320) would be 320.

However, the later memcpy uses LARGEST_ALIGN(len) for the 68 bytes, which
could round up to 96 bytes.  This means 252 + 96 =3D 348 bytes could be
written into a 320 byte space.

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

[Severity: Critical]
Can this regression corrupt skb_shared_info?

Since the linear space allocation might only be 320 bytes as shown above,
but this memcpy could write up to 348 bytes, it appears this might write
past the end of the linear data region.

Could this lead to overwriting destructor_arg and cause issues upon SKB
free?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260626085226.1765=
180-1-clecigne@google.com?part=3D1
