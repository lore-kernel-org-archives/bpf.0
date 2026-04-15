Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAAC12AD16
	for <bpf@vger.kernel.org>; Wed, 15 Apr 2026 08:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776243124; cv=none; b=vDYO0/57+kCrgDtbcdIlX7icK/p2POS3GK99eJD6sBgOo7LjtXZFo55EHyeyS62Xmsi1tf208khisVph+Ik25aRufZdMrglR84eL8vPokuJT9cGdkP7Rmllod4OVgvPLBoG6po9SPl2OJ947vJmqPAUBHY73OeQxlhJ80ShuLtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776243124; c=relaxed/simple;
	bh=oNQBtYND4HO0dF2gdWhtKPJ7vH8dxiyjOIDQvXoorEk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=NY62AOlI0XgOu7NfKkHOdzNmwt/+wDr7P5QUCcH/2yix6bVJTbGpYkxjCBSe+lfp/PCWb+TMnjGYeBy6rVv90vFmVLI5H0T1CznSlQXpHEuj9TtvWtZ24VTtNbOcO14+KwQpVhauTjlRwzFKtPe162OHtyjGiiJzf7zoLj5lq5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xwod31+P; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xwod31+P"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F87AC19424;
	Wed, 15 Apr 2026 08:52:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776243124;
	bh=oNQBtYND4HO0dF2gdWhtKPJ7vH8dxiyjOIDQvXoorEk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=Xwod31+PRFmz5Ihp+nBy4pMtEE0S6F7hWBE7vf48wCRVtbERDQsoDcZwRaqlTkdxO
	 TuUwAnT68hwi4CnZgF2snRp3vwIOOK8Pnz325snz9F+P2NmQ1bu3MvBseY2ynItwYI
	 uHzYdMhuR/PTVIa3SWCauFIOkmeqbLq0Ms7H0NNuKdoVfbJhp9XAj83ESx8P+ew31B
	 M7+zlLuQrN1Wjno49YvBXDGRpa1Zj83P4yrBtRaV+i2Bg/DOc5Wk1tYVeCiq3GStcR
	 jTXLHj2ncytG/oeOEUpCvYhfY+7BbkkwDLrtN8bIer+LMqlv+q1agkxDLOK1p9KsGB
	 +jDuBRz4PpXUA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC net-next v4 02/14] xsk: extend xsk_build_skb() to
 support passing an already allocated skb
Reply-To: sashiko@lists.linux.dev
To: "Jason Xing" <kerneljasonxing@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260415082654.21026-3-kerneljasonxing@gmail.com>
References: <20260415082654.21026-3-kerneljasonxing@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 15 Apr 2026 08:52:03 +0000
Message-Id: <20260415085204.3F87AC19424@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Sashiko AI review found 1 potential issue(s):
- [High] Inconsistent ownership semantics of `allocated_skb` on error paths=
 lead to a memory leak in the zero-copy path.
--

commit a6016c1c59927d7e151f38b7f237ad699db86b1e
Author: Jason Xing <kernelxing@tencent.com>

xsk: extend xsk_build_skb() to support passing an already allocated skb

This patch extends xsk_build_skb() to accept an allocated_skb parameter,
allowing the batch feature to reuse an already allocated skb instead of
allocating a new one.

> diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> index 1194268ae8676..becc8ebfd82f8 100644
> --- a/net/xdp/xsk.c
> +++ b/net/xdp/xsk.c

[ ... ]

> @@ -793,15 +797,16 @@ static struct sk_buff *xsk_build_skb_zerocopy(struc=
t xdp_sock *xs,
>  	return skb;
>  }
> =20
> -static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
> -				     struct xdp_desc *desc)
> +struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
> +			      struct sk_buff *allocated_skb,
> +			      struct xdp_desc *desc)
>  {
>  	struct net_device *dev =3D xs->dev;
>  	struct sk_buff *skb =3D xs->skb;
>  	int err;
> =20
>  	if (dev->priv_flags & IFF_TX_SKB_NO_LINEAR) {
> -		skb =3D xsk_build_skb_zerocopy(xs, desc);
> +		skb =3D xsk_build_skb_zerocopy(xs, allocated_skb, desc);
>  		if (IS_ERR(skb)) {
>  			err =3D PTR_ERR(skb);
>  			skb =3D NULL;
>  			goto free_err;

Does this leak allocated_skb on the zero-copy error path?

If xsk_build_skb_zerocopy() fails on the first descriptor (e.g., if
xsk_skb_metadata() returns an error due to invalid metadata), it returns an
ERR_PTR without freeing the SKB.

Because skb is then explicitly set to NULL before jumping to free_err,
kfree_skb() is skipped.

While the original code also had a leak here for internally allocated SKBs,
this patch extends the issue to caller-provided SKBs. In copy mode,
xsk_build_skb() correctly frees allocated_skb on error, but the zero-copy
path does not.

Could this lead to memory exhaustion if a caller assumes xsk_build_skb()
always consumes or frees the provided SKB on error?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260415082654.2102=
6-1-kerneljasonxing@gmail.com?part=3D2
