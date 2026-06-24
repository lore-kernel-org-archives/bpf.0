Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A400230B525
	for <bpf@vger.kernel.org>; Wed, 24 Jun 2026 08:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782291214; cv=none; b=g+qugEtvySkJ9tssXTkxqchtfEjZ1lqkS/ESWw0H2IHF1aCKS2ZAkqDOWIa6myf59bZSDHOwGw4TZxR4wTTZloAaEk8RzG30bS0gMkpsqwp3H2psp3ooYPPwvKCbr885HEbVODHFUEkLoAZvSgsHD7+bJAiSxJPaZivFeCFICu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782291214; c=relaxed/simple;
	bh=SDzKE+BzWvKCG/y7mDCWLkl8Vt+H9YSOa7s84s2z0iE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=DL7qrhmrI/irIczDqpsQeIcED6R1KpAOjRo+YpO+a7WA4YIBDE0Y5t2l0xF6+otBrZMqBXbt67N+oEWJXCI90iCJGp/1Nn6lsEIf+a18SpRSqnv4ZNNgOFnFzVBPhq0EFgz+4Q8UbSuySdQImIhDKymXQ30e9WW2yKH/f3Brg7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jf1mK1HO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jf1mK1HO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2380B1F000E9;
	Wed, 24 Jun 2026 08:53:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782291213;
	bh=K3AMMan4XeGDCQSQm1iwlbusohxgfo2ss3OGCL7PnA0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Jf1mK1HOOGHXa2g5svu0wR9Pvg4uWyQgLnUE84vIb9v2bfrZ9rO+MlexC7PPHVECM
	 GDdi5XKhXxDRhCWmhEd6IivPFXxu4gWq8nSZkvdTZ2oTllRJ6ijo0rI99XEXbpjMYO
	 ra21gknOL9o3ZuNTmhpmAao54jmiSISijISWR708t+SIw5Ob78f8mHHU4jX4ySXTxI
	 ey0jNS8G6D/bB/kp2EjQIG+gsAWAnRKWyL5T+QMZo03scfVEkdOX5hIFU489kEyfLR
	 AI1/eQJuhdLOlgclkzeYPctYqwJzuY1PoU9MdpTlr+MWEwgcGGj1S6NkNfCZOlhD+S
	 G57y9t7lrFhDQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] xsk: fix memory corruptions in net/core/xdp.c
Reply-To: sashiko-reviews@lists.linux.dev
To: "Clement Lecigne" <clecigne@google.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260624084130.2382335-1-clecigne@google.com>
References: <20260624084130.2382335-1-clecigne@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 24 Jun 2026 08:53:32 +0000
Message-Id: <20260624085333.2380B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Critical] The new dynamic `truesize` calculation tightly bounds the skb =
linear buffer size but fails to account for the `LARGEST_ALIGN(len)` paddin=
g used in the subsequent `memcpy()`. This leads to an out-of-bounds write t=
hat corrupts the `skb_shared_info` structure.
--

commit f8cfaa75cd9fcfb65c25981d740b6eedecb19f7b
Author: Cl=C3=A9ment Lecigne <clecigne@google.com>

xsk: fix memory corruptions in net/core/xdp.c

This commit attempts to fix a memory corruption in AF_XDP zero-copy handling
by dynamically calculating the truesize for skb allocation. It also fixes a
mismatch in xdp_copy_frags_from_zc() between allocation and copy sizes.

> diff --git a/net/core/xdp.c b/net/core/xdp.c
> index 9890a30584ba7..f36d1fb875ab8 100644
> --- a/net/core/xdp.c
> +++ b/net/core/xdp.c
[ ... ]
> @@ -740,7 +740,9 @@ struct sk_buff *xdp_build_skb_from_zc(struct xdp_buff=
 *xdp)
>  {
>  	const struct xdp_rxq_info *rxq =3D xdp->rxq;
>  	u32 len =3D xdp->data_end - xdp->data_meta;
> -	u32 truesize =3D xdp->frame_sz;
> +	u32 headroom =3D xdp->data_meta - xdp->data_hard_start;
> +	u32 truesize =3D SKB_DATA_ALIGN(headroom + len) +
> +		       SKB_DATA_ALIGN(sizeof(struct skb_shared_info));

[Severity: Critical]
Does this tight allocation size account for the LARGEST_ALIGN(len) padding
used during the memcpy() below?

If an XDP program modifies the packet data making headroom unaligned, and=20
headroom + len is close to a multiple of SMP_CACHE_BYTES, napi_build_skb()
will place the skb_shared_info structure exactly at=20
SKB_DATA_ALIGN(headroom + len).

Could the LARGEST_ALIGN(len) size in the memcpy() below write past this
linear data area and corrupt the adjacent skb_shared_info structure?

>  	struct sk_buff *skb =3D NULL;
>  	struct page_pool *pp;
>  	int metalen;
[ ... ]
> @@ -762,7 +764,7 @@ struct sk_buff *xdp_build_skb_from_zc(struct xdp_buff=
 *xdp)
>  	}
> =20
>  	skb_mark_for_recycle(skb);
> -	skb_reserve(skb, xdp->data_meta - xdp->data_hard_start);
> +	skb_reserve(skb, headroom);
> =20
>  	memcpy(__skb_put(skb, len), xdp->data_meta, LARGEST_ALIGN(len));

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260624084130.2382=
335-1-clecigne@google.com?part=3D1
