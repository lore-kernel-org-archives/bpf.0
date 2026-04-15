Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0113C23372C
	for <bpf@vger.kernel.org>; Wed, 15 Apr 2026 09:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776246442; cv=none; b=NHQk4YLE6SQwlVzqVHLJre1fa+VUBa3/OfxXGxardiK4DwaiBxV/5L0xya8+TwviYSdsMwl8PMvgZbe68SkhnZn3zlbNN8Uh86Xz9zJAQ7WL61m9jtn7Z5aKxXzYUoOtC5cGvMV7BApwxJSeeBSo/qYNz1qExvvyi3NFuW8KT2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776246442; c=relaxed/simple;
	bh=MN+ryav8kfP/cVU+7aZ3zePN5ndKzBBBgoNjGgnt9Ac=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ZLjWQij4OYgsoE7B9StSZlnx5U7xlOBfAmWw25Jv5mbPOis3GcU6k+sDhJRZzqrM1JIKQzgjVnwC3TKmfS5xLywBoXDzVc73c9+o4BnRcBKS753LUOvu8KQISGlCAuoUGtDsCzmTBxP5mfD6OBlM9625yqmY6qi2Og1efvfIxKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C6ydmzmE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C6ydmzmE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C052C19424;
	Wed, 15 Apr 2026 09:47:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776246441;
	bh=MN+ryav8kfP/cVU+7aZ3zePN5ndKzBBBgoNjGgnt9Ac=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=C6ydmzmE+d7FqnhKfKlRtmc+zwhFytVpElRLQh6hWsjnDdHIP900LUxzGL+rOWAQt
	 xx3wzkqwfvrMxqWZbrqLjF0KyZAINZXXe4Bg2GilfBM35xhRN/Cyu4jryLk12Pl9m5
	 nKnTczfs3K6cPxPurNEz+QeOuogoSmZoXbtSRo6gWxc7DIoBECyCq2UVyaYPsEv1RS
	 cRp4eazRv0U4jCWuBT8C7A6aakyoH3dVok+rE62059FK8x8M+rEARJtPZbbzhFfv7v
	 Th7ZSfT8nBaZM+xAzHHUi28dUDSDIlUxVh9xwlHzV4rIqwV0d9En01vlVBo/58U9Ga
	 Sx6wp5iCuQEbw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC net-next v4 14/14] xsk: optimize xsk_build_skb for
 batch copy-mode fast path
Reply-To: sashiko@lists.linux.dev
To: "Jason Xing" <kerneljasonxing@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260415082654.21026-15-kerneljasonxing@gmail.com>
References: <20260415082654.21026-15-kerneljasonxing@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 15 Apr 2026 09:47:20 +0000
Message-Id: <20260415094721.7C052C19424@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Sashiko AI review found 2 potential issue(s):
- [High] An SKB memory leak occurs when xsk_build_skb() returns an error fo=
r a newly assigned SKB.
- [Medium] The prefetch instruction uses the raw AF_XDP descriptor address =
without extracting the offset, creating an invalid pointer in unaligned mod=
e.
--

commit 7bdeef673e571c57c404cb8d05446f46b3e2676e
Author: Jason Xing <kernelxing@tencent.com>

xsk: optimize xsk_build_skb for batch copy-mode fast path

This commit introduces three targeted optimizations for the batch
copy-mode TX hot path in XDP sockets, including replacing skb_store_bits()
with memcpy(), inlining UMEM address computation, and prefetching the
next descriptor's UMEM data.

> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> index 3b3969adfd23f..0fccb0c8cbe90 100644
> --- a/net/core/skbuff.c
> +++ b/net/core/skbuff.c
> @@ -751,14 +751,28 @@ int xsk_alloc_batch_skb(struct xdp_sock *xs, u32 nb=
_pkts, u32 nb_descs, int *err
>  	if (total_truesize)
>  		refcount_add(total_truesize, &xs->sk.sk_wmem_alloc);
> =20
> -	/* Phase 3: Build SKBs with packet data */
> +	/* Phase 3: Build SKBs with packet data. */
> +	struct xsk_buff_pool *pool =3D xs->pool;
> +	void *pool_addrs =3D pool->addrs;
> +	bool unaligned =3D pool->unaligned;
> +
>  	for (j =3D 0; j < alloc_descs; j++) {
> +		u64 addr =3D descs[j].addr;
> +		void *buffer;
> +
> +		if (unaligned)
> +			addr =3D xp_unaligned_add_offset_to_addr(addr);
> +		buffer =3D pool_addrs + addr;
> +
> +		if (j + 1 < alloc_descs)
> +			prefetch(pool_addrs + descs[j + 1].addr);

Does this prefetch use the raw AF_XDP descriptor address without extracting
the offset?

In unaligned mode, an AF_XDP descriptor addr field encodes a chunk offset
in its upper 16 bits. While xp_unaligned_add_offset_to_addr() is used to
decode the current descriptor address, the prefetch directly adds
descs[j + 1].addr to pool_addrs.

Could this result in an out-of-bounds pointer in unaligned mode, failing to
hide memory latency and causing cache pollution?

> +
>  		if (!xs->skb) {
>  			skb =3D skbs[skb_count - 1 - k];
>  			k++;
>  		}
> =20
> -		skb =3D xsk_build_skb(xs, skb, &descs[j]);
> +		skb =3D xsk_build_skb(xs, skb, &descs[j], buffer);
>  		if (IS_ERR(skb)) {
>  			*err =3D PTR_ERR(skb);
>  			break;

Can this leak the newly assigned SKB if xsk_build_skb() returns an error?

If xsk_build_skb() fails, it returns ERR_PTR(err) and the loop breaks. Since
k was already incremented, the cleanup loop in Phase 4 (while (k < i)
kfree_skb(...)) reclaims unused SKBs starting from the current k, skipping
the failed SKB at index k - 1.

Could a malicious userspace program exploit this to systematically leak SKBs
by triggering metadata errors?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260415082654.2102=
6-1-kerneljasonxing@gmail.com?part=3D14
