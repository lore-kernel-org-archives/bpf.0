Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD636345CCA
	for <bpf@vger.kernel.org>; Tue, 21 Apr 2026 09:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776764423; cv=none; b=hC00c7YiDUtAcIjb74CLLQ3EQDbFQrYdjSU1+W6l2/Q22w63Zdygwor0Y5ismiHWgxV+o6fwVF/Aa07Bmw6hjKHnh5jqorDs6ZXYGv9tZwtNjX1PoicwttyVH6g/jLcWfK3ehiRDx/0dPzzsOvfJu41l9aJO1l2iYNJXktQUhEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776764423; c=relaxed/simple;
	bh=KbC90zFK4Nzcfx2aHmPMMdCW1ksXpA8+SmuCkoOka80=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=hsYAheSyrcamQnyJlCANdI4tqoqu9jajW/FGCOvv3mg5JdzoRkn3+P6Jli4RF3yeM2rXt85/KFzC1DdLXdS3ijvcCXE88hhpUw3ioS7GP/e8Naj3hOE75XjQw7tbae6DOgKrrb7FQHEgX5YqSGbn/QQZBgVKKMryG3hS9RXRE4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SVbawOVy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SVbawOVy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69C89C2BCB0;
	Tue, 21 Apr 2026 09:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776764423;
	bh=KbC90zFK4Nzcfx2aHmPMMdCW1ksXpA8+SmuCkoOka80=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=SVbawOVyU64GPeKATgL96nG2laNi7w2l3kS/HnNDMOA9ejayyfnQRff40N5QYVxlY
	 Rxtg8UYGP9DlT+B4tWhV79CDWBDjfAV2RLps9qSmumMak12oQHLt53Vazop7Cju/kw
	 CRxgok4/WffoCkRonivZmpGpcc0SqvT9yaZ0r0SEHj8WrOav85Kdl+IB74X4vZeu7h
	 OWjII3An0mAIAb61zU37B3agHhD8a+RsmIy7r7wivFQLj9yrqMq4ODidKzaKAbzXN4
	 uk0avyXxt8oxdtN3uIWfd2WBtwfBAeR55tb5U/CsMxf0zdziGkU+R3sdMpJhDHAnZ9
	 Ve2jJVUyokkmQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v2 2/8] xsk: handle NULL dereference of the skb
 without frags issue
Reply-To: sashiko@lists.linux.dev
To: "Jason Xing" <kerneljasonxing@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260420082805.14844-3-kerneljasonxing@gmail.com>
References: <20260420082805.14844-3-kerneljasonxing@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 21 Apr 2026 09:40:22 +0000
Message-Id: <20260421094023.69C89C2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Sashiko AI review found 1 potential issue(s):
- [High] Memory leak of newly allocated skb in `xsk_build_skb_zerocopy()` o=
n error paths for the first descriptor.
--

commit c0083470d60454acdbd801635be8f00a9b79a9eb
Author: Jason Xing <kerneljasonxing@gmail.com>

xsk: handle NULL dereference of the skb without frags issue

This commit addresses a NULL pointer dereference in the error handling
path of xsk_build_skb by explicitly checking if xs->skb is NULL. For the
first-descriptor case, it cancels the CQ slot and tracks the invalid
descriptor instead of dropping the skb.

> In this series, the skb is already freed by kfree_skb() inside
> xsk_build_skb_zerocopy for the first-descriptor case, so we only need
> to do the bookkeeping: cancel the one reserved CQ slot and account for
> the single invalid descriptor.

Is this description accurate regarding the skb being freed?

Looking at xsk_build_skb(), if xsk_build_skb_zerocopy() encounters an
error and returns an error pointer, the local skb variable is set to
NULL before jumping to the free_err label:

    skb =3D xsk_build_skb_zerocopy(xs, desc);
    if (IS_ERR(skb)) {
        err =3D PTR_ERR(skb);
        skb =3D NULL;
        goto free_err;
    }

Since skb is NULL, the cleanup code at free_err is bypassed:

free_err:
    if (skb && !skb_shinfo(skb)->nr_frags)
        kfree_skb(skb);

Does this code leak the newly allocated skb and its sk_wmem_alloc charge
when xsk_build_skb_zerocopy() fails on the first descriptor?

I see this is addressed later in the series by commit aef1b3344bd95
("xsk: avoid skb leak in XDP_TX_METADATA case") and commit 93315725e1616
("xsk: free the skb when hitting the upper bound MAX_SKB_FRAGS"), but
the commit message here appears to incorrectly assume the free is already
happening.

> diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> index 887abed254668..54d4895fc11eb 100644
> --- a/net/xdp/xsk.c
> +++ b/net/xdp/xsk.c

[ ... ]

> @@ -973,9 +973,14 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock=
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
> +			xs->tx->invalid_descs++;
> +		}

Because the skb wasn't freed as the commit message assumed, can a
malicious application exploit this missing kfree_skb by repeatedly
supplying abnormally large descriptors to exhaust socket buffer memory?

>  		xskq_cons_release(xs->tx);
>  	} else {
>  		/* Let application retry */

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260420082805.1484=
4-1-kerneljasonxing@gmail.com?part=3D2
