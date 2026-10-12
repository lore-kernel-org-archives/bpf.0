Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F30A3B388A;
	Mon, 12 Oct 2026 18:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791831329; cv=none; b=ZjWhYBUArdddVr7QoWwCYuJsrC8XNojSW0eEwWwXNJHUIFGlh1r0YHbsqregfKpYq/w80zo5WYQcJlZgE2pZEiFFyCSIj/fWTp2mJfK1WR84pD0rxO6cjv8max9gLnRAr6jGLYJklrbIrbdXZT5yZD1YOshPw+QVUu7KY8Ds1VY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791831329; c=relaxed/simple;
	bh=58Zn7fC3ITmipyGcHmVZLv6Ol3+1lWU9hDhyVMQHoLo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=uxjy75Yvsra2X3kGtXeGyqWXpQQwJIVfz9thEQbSOcYQkXcg+cQlSIEL9W+7acTbGxEQ1jSM/UMIfdKooabuFFBxP9GsDCVPT7OL6HPyMIogNTOtAwG+jYnSn0fHWmxskUDpr1k+yh1YIojOkpFNzFadY7Mwlw+y4VSIAmSz+Ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nHXadWCH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nHXadWCH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FE3C1F008A1;
	Mon, 12 Oct 2026 18:55:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791831327;
	bh=AcZU6JSMMdr6MoCnHdN+htZaIqxEg0BmRp+fOIwoPx8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=nHXadWCHlt74yxn3YXSencjVvH/ok4F2jsA3V/0IfNsvqBJqttigEOaFWV+a3U/fs
	 T1FvHv1+bGVbbegpsdCEM1u91XWPLq0j1mFFfNfO+SEIVBtekwfr0pGZRw/3sHboKL
	 tEk7GKDuLJpJsLPC5Zc8er+2UMTId/Nq+fNC+v8R6Q+NyaeCHKEO+bcGaU1ELCFs4z
	 JM5fYRU0/18WxeTC2Qdy1Vr2jaQkC1x1+9ko9+omsdV77tQGcdLQtwHeSJrEnZNgJu
	 qWMLoPxJL+Y77it963Xk/yNdxR5fy5rawcDWhNQCysWCD3/ZLJuH/M03QGlrP+24iH
	 U5D0veb2Gb1JA==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
Subject: Re: [RFC net-next 11/15] xdp: Copy provider buffers on pass and
 redirect
In-Reply-To: <20261003190239.B15771F0089C@smtp.kernel.org>
References: <20261002190018.696925-1-bjorn@kernel.org>
 <20261002190018.696925-12-bjorn@kernel.org>
 <20261003190239.B15771F0089C@smtp.kernel.org>
Date: Mon, 12 Oct 2026 20:55:24 +0200
Message-ID: <87zewiagv7.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

sashiko-bot@kernel.org writes:

> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [High] net: xdp: payload truncation in xdp_build_skb_from_zc() when met=
adata unsupported
> --
>
> commit a36f92358b032a7e20669d832f27102e55f9f4eb
> Author: Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org>
>
> xdp: Copy provider buffers on pass and redirect
>
> This commit introduces logic to copy provider buffers into kernel pages
> on pass and redirects, handling fragments appropriately. It splits the
> copy from the release for redirects, maintaining the classic zero-copy
> path while resolving frag addresses through xdp_frag_address().
>
>> diff --git a/net/core/xdp.c b/net/core/xdp.c
>> index 386240bd24c98..b7f16f44dac22 100644
>> --- a/net/core/xdp.c
>> +++ b/net/core/xdp.c
> [ ... ]
>> @@ -638,6 +718,9 @@ struct sk_buff *xdp_build_skb_from_buff(const struct=
 xdp_buff *xdp)
>>  	u32 nr_frags =3D 0;
>>  	int metalen;
>>=20=20
>> +	if (xdp_buff_has_netmem(xdp))
>> +		return xdp_build_skb_from_zc(xdp);
>> +
>>  	if (unlikely(xdp_buff_has_frags(xdp))) {
>
> [Severity: High]
> Does generalizing xdp_build_skb_from_zc() to handle all netmem buffers ca=
use
> a payload truncation when metadata is unsupported?
>
> Previously, xdp_build_skb_from_zc() only handled pure XSK buffers, where
> data_meta =3D=3D data is guaranteed. Now, it can receive generic provider=
-backed
> netmem buffers.
>
> If a netmem provider driver does not support metadata and initializes the
> buffer via xdp_prepare_buff() with false, xdp->data_meta is set to
> xdp->data + 1.
>
> Looking at the length calculation and copy in xdp_build_skb_from_zc():
>
> struct sk_buff *xdp_build_skb_from_zc(struct xdp_buff *xdp)
> {
>         u32 headroom =3D xdp->data_meta - xdp->data_hard_start;
>         ...
>         u32 len =3D xdp->data_end - xdp->data_meta;
>         ...
>         memcpy(__skb_put(skb, len), xdp->data_meta, len);
> }
>
> Without checking xdp_data_meta_unsupported(xdp), it blindly uses
> xdp->data_meta to determine the length and as the source for memcpy().
>
> Could this cause the first byte of every packet to be truncated and the
> payload to be shifted by one byte, leading to silent data corruption on
> XDP_PASS?
>
> Should xdp_build_skb_from_zc() check xdp_data_meta_unsupported(xdp) simil=
ar
> to how xdp_copy_zc_to_xdp_frame() handles it?

Yep. Unsupported metadata should copy from data, with the matching
length. I'll fix that and add coverage.
