Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD3A7345CCA
	for <bpf@vger.kernel.org>; Tue, 21 Apr 2026 09:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776764425; cv=none; b=Kz6oynwfQoVC4VyC5FeykbsIhk/s1A6t1aFtfdOsLpsQyAG/iuQohd44zFUoXGW9nWqFBCpNTR6Ta4y8Hi6rbh9Yf/93Ml/fdXEOPyazsUk/gKJHQ3Qc+p6ZaEv/dtiaGBJxDG1eRPXu9c8/s8+kHtmvkvdGoJ+7V3d6UsgZQu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776764425; c=relaxed/simple;
	bh=Fo6/M1gJ1APu+irFynuHUcygAYdMMaUZhfA0vyF8pAs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=opxfUsyov1Vw8e8NsXHp3y7Rk3YMUr4mlunJIB0cJkK7lZFmepXYWmIsaqONWwm299H5K9IFxRtte9/B6+R3H8646t/lP2JCaAKB8Xuf4Zr9bxEhTbdBwk02x+t9TB1bhgmxHtgl0gDqHiR+dVTPoTnTtpAReQ+TTzEjOVS18oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VWQkq2Gv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VWQkq2Gv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 684A0C2BCB0;
	Tue, 21 Apr 2026 09:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776764425;
	bh=Fo6/M1gJ1APu+irFynuHUcygAYdMMaUZhfA0vyF8pAs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=VWQkq2Gv7zLrOlSEX+bfYITn7/pvsWyAsMrpl5mT8WnLJ2Of7M795lmIfbKpqfsRx
	 hiwUHuY+NZKZ1N7zWXMeAwi+7Tbv+bUWKdsrXQgHh9fa/Vj3gL8SzALy53TVQvhi8g
	 U45yp69Bkbb0dI6r44xa+qGC7ltAlTF09P8dA/YsHd4CsBsOu32irQvHaoHchYcwKn
	 tLYoRySVQVMBOVBNhBpBMXB83j2NlIh0pdKjKlqQCvGIENsJ1Ae7TWgPhptaw2uPif
	 02SuGOYydCi4yJb+4aktiXUyX6CyX9yVkVB8QOvQC19dbhTZiSSVd95EvE5KnEoLLz
	 5Uj/ZSreadI5g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v2 5/8] xsk: avoid skb leak in XDP_TX_METADATA case
Reply-To: sashiko@lists.linux.dev
To: "Jason Xing" <kerneljasonxing@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260420082805.14844-6-kerneljasonxing@gmail.com>
References: <20260420082805.14844-6-kerneljasonxing@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 21 Apr 2026 09:40:24 +0000
Message-Id: <20260421094025.684A0C2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Sashiko AI review found 2 potential issue(s):
- [Critical] Time-of-Check to Time-of-Use (TOCTOU) vulnerability in `xsk_sk=
b_metadata` allows unprivileged users to bypass bounds checks and cause out=
-of-bounds memory accesses.
- [High] Software checksumming calculation fails completely because `skb_ch=
ecksum_help()` is invoked on an incomplete and non-linear SKB.
--

commit aef1b3344bd952f39b1181e046ab7d9ce77fbc8a
Author: Jason Xing <kerneljasonxing@gmail.com>

xsk: avoid skb leak in XDP_TX_METADATA case

This commit explicitly adds a call to kfree_skb() (via
xsk_drop_untrans_skb) when xsk_skb_metadata() returns an error, preventing
an skb leak if metadata processing fails.

Link: https://lore.kernel.org/all/20260415085204.3F87AC19424@smtp.kernel.or=
g/

> diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> index 55b448abb8178..fd5432fb807e1 100644
> --- a/net/xdp/xsk.c
> +++ b/net/xdp/xsk.c
> @@ -829,8 +829,10 @@ static struct sk_buff *xsk_build_skb_zerocopy(struct=
 xdp_sock *xs,
>  		xsk_skb_init_misc(skb, xs, desc->addr);
>  		if (desc->options & XDP_TX_METADATA) {
>  			err =3D xsk_skb_metadata(skb, buffer, desc, pool, hr);

While looking at this metadata handling, I noticed a couple of pre-existing
regressions.

Will skb_checksum_help() always fail when called here?

xsk_skb_metadata() is called right after allocating the SKB but before any
payload fragments are appended via skb_fill_page_desc() further down in
xsk_build_skb_zerocopy(). This means skb->len and skb_headlen(skb) are 0.

If software checksumming is enabled, xsk_skb_metadata() calls
skb_checksum_help(skb). Since skb_headlen(skb) is 0, won't the check
offset >=3D skb_headlen(skb) in skb_checksum_help() always evaluate to true,
triggering a warning and causing the packet to be dropped?

Also, can a user-space program modify the checksum metadata concurrently?

In xsk_skb_metadata(), the metadata is read directly from the UMEM buffer,
which is shared memory mapped into user-space:

net/xdp/xsk.c:xsk_skb_metadata() {
    ...
	if (meta->flags & XDP_TXMD_FLAGS_CHECKSUM) {
		if (unlikely(meta->request.csum_start +
			     meta->request.csum_offset +
			     sizeof(__sum16) > desc->len))
			return -EINVAL;

		skb->csum_start =3D hr + meta->request.csum_start;
		skb->csum_offset =3D meta->request.csum_offset;
    ...
}

The bounds check does not use READ_ONCE(). Could a user-space application
modify meta->request.csum_start and meta->request.csum_offset between the
check and the assignment? If so, it might bypass the bounds check and speci=
fy
arbitrarily large offsets, causing out-of-bounds writes when the hardware
inserts the checksum.

> -			if (unlikely(err))
> +			if (unlikely(err)) {
> +				xsk_drop_untrans_skb(skb);
>  				return ERR_PTR(err);
> +			}
>  		}
>  	} else {
>  		struct xsk_addrs *xsk_addr;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260420082805.1484=
4-1-kerneljasonxing@gmail.com?part=3D5
