Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05AF13876CD
	for <bpf@vger.kernel.org>; Sun,  3 May 2026 20:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777838967; cv=none; b=g/1XzXZ6hdCDwsRaafVP9sx7GYf1ijwFRe2y+o+9POQ6H3clITw0jPgM81+33tyNfaSnJ/ciL397AR71u8wx8aypzuliRb1qEQDMY4vsbWKzUntOxirgXOjUgCzBfc9yfD93zwza7gfvxYN0KYcf9vuPEd8GTxTK/TPojH2v7RA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777838967; c=relaxed/simple;
	bh=xySxV++GOM5XIXlCfurX0mk8vfsj9ELxkmA3xnUfNVw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=c18mYhjfGcyANCz/oLZYp5Az0J5eHmV9Uks6lSHu7gZJTScBOGWfRu/r9Jvb83ZnAePE1naZtX6p2Am4rC2U21ZFF2XP3ECuW9l7gArf+smUr1VsXsjFhHaZN5JqrUxJZxMqqUiGbEhfRDWhb+dtpuJKarlShBePQBZiQQlweWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zlyc/reE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zlyc/reE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A500AC2BCB4;
	Sun,  3 May 2026 20:09:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777838966;
	bh=xySxV++GOM5XIXlCfurX0mk8vfsj9ELxkmA3xnUfNVw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=Zlyc/reEgYocqjgihK3Zqts9vXWyVj7+5cCZSp2SkMENgXKCDMtTUOr+rdbeNWQnv
	 x9cC1U1eOk5PajNDtg+dHp82rq0NxnfuzOQIwG+bTpKYLhF0+Lu4ounc5pbb3kPLt3
	 /geyffV12YOYOvHs5f9SeiboFfPfbjoRt3FNOh9r2g32Sf/UOFAbhdxac2i/Plxhgx
	 64ZEWHFAkiZFxtG+vYLVXbUNO6XM7nZLANIS3yl7kp/Yc5fD8QDMyphfcCvH2D7kN9
	 53pzA7kgTtkRAF79YDil1xKusWRARJ8jQOLQfNVBoXoIzFJMu2XNFHb8qlmn8rcGYE
	 E4NgYgNYFQ/OQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v5 5/8] xsk: prevent CQ desync when freeing
 half-built skbs in xsk_build_skb()
Reply-To: sashiko@lists.linux.dev
To: "Jason Xing" <kerneljasonxing@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260502200722.53960-6-kerneljasonxing@gmail.com>
References: <20260502200722.53960-6-kerneljasonxing@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 03 May 2026 20:09:26 +0000
Message-Id: <20260503200926.A500AC2BCB4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] In `xsk_build_skb_zerocopy()`, if `xsk_skb_metadata()` fails, the =
newly allocated `skb` is leaked.
--

commit 88b75ff1d12b482a55e1724cc457909cf3ea19dd
Author: Jason Xing <kerneljasonxing@gmail.com>

xsk: prevent CQ desync when freeing half-built skbs in xsk_build_skb()

Postpone the skb initialization phase in xsk_build_skb() until the first
frag allocation is completed to prevent the skb destructor from running
on error paths. Before the initialization, the skb can be safely freed
by kfree_skb().

Closes: https://lore.kernel.org/all/20260419045822.843BFC2BCAF@smtp.kernel.=
org/

> diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> index 55378c3855d5..af3c5752bb63 100644
> --- a/net/xdp/xsk.c
> +++ b/net/xdp/xsk.c
> @@ -819,8 +819,6 @@ static struct sk_buff *xsk_build_skb_zerocopy(struct =
xdp_sock *xs,
>  			return ERR_PTR(err);
> =20
>  		skb_reserve(skb, hr);
> -
> -		xsk_skb_init_misc(skb, xs, desc->addr);
>  		if (desc->options & XDP_TX_METADATA) {
>  			err =3D xsk_skb_metadata(skb, buffer, desc, pool, hr);
>  			if (unlikely(err))

Could this leak the newly allocated skb if xsk_skb_metadata() fails?

If xsk_skb_metadata() returns an error, xsk_build_skb_zerocopy() will return
ERR_PTR(err) directly without freeing the skb.

The caller receives the error pointer, sets its local skb variable to NULL,
and jumps to the free_err label:

net/xdp/xsk.c:xsk_build_skb() {
    ...
	if (dev->priv_flags & IFF_TX_SKB_NO_LINEAR) {
		skb =3D xsk_build_skb_zerocopy(xs, desc);
		if (IS_ERR(skb)) {
			err =3D PTR_ERR(skb);
			skb =3D NULL;
			goto free_err;
		}
    ...
}

Because the skb is explicitly nullified here, the kfree_skb(skb) call in
the cleanup path is bypassed, leaving the socket buffer and its associated
sk_wmem_alloc charge leaked.

While this pre-existing issue is explicitly fixed later in this patch series
in commit "xsk: avoid skb leak in XDP_TX_METADATA case", should it be
addressed earlier to ensure intermediate states remain safe during a bisect?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260502200722.5396=
0-1-kerneljasonxing@gmail.com?part=3D5
