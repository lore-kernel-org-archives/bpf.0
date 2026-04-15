Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4406033508E
	for <bpf@vger.kernel.org>; Wed, 15 Apr 2026 09:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776245903; cv=none; b=IbnwufJNNVPMSjWK0VWqzO/OiQTaWtlg3Jnyvk5UL4WL+W+iGeoghcaK0hc+8wLCeoIMMrNPNOUfn/oF1etnYnOTZzoqOEjvXrV7/Jxsu+a60dTGlDZ9oSSrD1ublUZz8SwnDEa3tcX2gmsLFdgF1kk5TuRowd+vVUvBpsgU598=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776245903; c=relaxed/simple;
	bh=zwgYlL19DvhIVwWyFTh/KrcLCLhUUdYW0ZJXOZ2NGjI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=sMuO6IDbBgJNdvfhIMhlGJFamY5yVoU7CAJK32OmRNf5inPoaVbVvaYZZIdLIwfm2Sp5rRwGOAnI9wLhSLmfeWXDvMw1Q9lNpeSXsZcgTwSnWkwxofVhwahKPKeiErGYpt6RbDLKZZ2ZzgKT5Dq9j4Z2pMgqH9lMMTX2pPKHjQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kLDBGRZC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kLDBGRZC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79A76C19424;
	Wed, 15 Apr 2026 09:38:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776245902;
	bh=zwgYlL19DvhIVwWyFTh/KrcLCLhUUdYW0ZJXOZ2NGjI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=kLDBGRZCPYmTFkTDOAsU/I3BN0l5P/TV/I+6E73eoCGQHHBojnfCyB6Plrxs5H/Ii
	 CsnTUOZJYHZ6/D7gm+xGYdrrDFB0H6mC/4j+9poQSvWzk2cwywHF7HYWpnKkjt0K9g
	 ktOVrZKrKteTO4tUp0cjUBxtBx7u0iuaUlds0grI3N2noV5fzJxSjJWfsClEi9HB6C
	 UMlK/hDLNBe6Awf6RjUCvPwrN+iPaYvLYYoxSJPCvRA5QpydyMjwJy4OZab0gnyuBZ
	 /H66haqVBOhSOy5chl/Eny0twe+XV6BrqDNqROjEdVRggvjeMtbryZbkt+i072vbZN
	 bnvtv8TLgxoJA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC net-next v4 04/14] xsk: cache data buffers to avoid
 frequently calling kmalloc_reserve
Reply-To: sashiko@lists.linux.dev
To: "Jason Xing" <kerneljasonxing@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260415082654.21026-5-kerneljasonxing@gmail.com>
References: <20260415082654.21026-5-kerneljasonxing@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 15 Apr 2026 09:38:21 +0000
Message-Id: <20260415093822.79A76C19424@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Sashiko AI review found 2 potential issue(s):
- [High] Cached data buffers are consumed without validating current alloca=
tion flags, potentially violating memory placement constraints.
- [Medium] Meaningful code and commit message mismatch regarding cache refi=
ll logic.
--

commit 5a442e9c44f0a64a147908843084cffe5e2fed9f
Author: Jason Xing <kernelxing@tencent.com>

xsk: cache data buffers to avoid frequently calling kmalloc_reserve

This commit introduces a per-socket data buffer cache for small packets
to reduce kmalloc_reserve() overhead. It adds bulk allocation from
skb_small_head_cache and persists unused buffers across batch cycles.

>     Inside the Phase-1 per-descriptor loop, when a small packet needs a
>     data buffer and the cache is empty, a single kmem_cache_alloc_bulk()
>     refills it with generic_xmit_batch objects. Subsequent small packets
>     pop directly from the cache. Large packets bypass the cache entirely
>     and fall back to kmalloc_reserve(). Unused buffers remain in the
>     cache for the next batch.

Is this description accurate? Looking at the implementation below, the bulk
allocation happens outside the Phase-1 loop. If the cache runs empty during
the loop, it appears to fall back to kmalloc_reserve() for each subsequent
packet rather than refilling the cache via kmem_cache_alloc_bulk(). Could
the commit message be updated to match the actual execution flow?

> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> index c7e42c2966cdd..3b3969adfd23f 100644
> --- a/net/core/skbuff.c
> +++ b/net/core/skbuff.c
[ ... ]
> @@ -709,10 +718,17 @@ int xsk_alloc_batch_skb(struct xdp_sock *xs, u32 nb=
_pkts, u32 nb_descs, int *err
> =20
>  			skb =3D skbs[skb_count - 1 - i];
>  			skbuff_clear(skb);
> -			data =3D kmalloc_reserve(&size, gfp_mask, node, skb);
> -			if (unlikely(!data)) {
> -				*err =3D -ENOBUFS;
> -				break;
> +			if (dc_count &&
> +			    SKB_HEAD_ALIGN(size) <=3D SKB_SMALL_HEAD_CACHE_SIZE) {

If the socket's sk_allocation (which populates gfp_mask) was modified to
require restricted memory placement (e.g. __GFP_DMA), could this code use a
standard memory buffer left over from a previous batch?

While the bulk allocation check before the loop correctly avoids allocating
from skb_small_head_cache if KMALLOC_NOT_NORMAL_BITS is set, the
consumption path here only checks dc_count. Does this need to validate
gfp_mask against KMALLOC_NOT_NORMAL_BITS before consuming from the cache,
to ensure memory placement constraints are not bypassed?

> +				data =3D dc[--dc_count];
> +				size =3D SKB_SMALL_HEAD_CACHE_SIZE;
> +			} else {
> +				data =3D kmalloc_reserve(&size, gfp_mask,
> +						       node, skb);
> +				if (unlikely(!data)) {
> +					*err =3D -ENOBUFS;
> +					break;
> +				}
>  			}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260415082654.2102=
6-1-kerneljasonxing@gmail.com?part=3D4
