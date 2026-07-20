Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F27F3BB9F5
	for <bpf@vger.kernel.org>; Mon, 20 Jul 2026 13:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784555902; cv=none; b=fVSycfBtbLAYcn7t/tbx5zgz3yJJeL2L10EeLImLRnoy2whgKEXhX/fvoq71Ffkn8FNxaXYS+2l2I6j5VwI16jqtxPgHX5y+XdAyFvjrn+B+ZQsvvMnPFvoVkOg8tnSc1gknrravIDPf3Z1HpRK+MRjVwwlTfPhTpwiuPnzdugY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784555902; c=relaxed/simple;
	bh=iwDbLfFzN6tbAv5XP4bEw8t+SqlXR/Xp870DlDmo+XM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ZcnxwpcQO23ZR5YWi/UJgt96bZwFyPeLqQMWpOlfph/Zf8j852+cX96M0E/T8K241u9ot0ZtSa4JwzoZA6UbB9mLxt2HXzCWHtjv2BIC59W0bmtmatG38mXcbwVPg1Wrmr0Y6UhMeECnwJSmXApjFsDC5VdzXxKheCHrCYnzByU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LyBPiqY0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LyBPiqY0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE7AD1F00A3A;
	Mon, 20 Jul 2026 13:58:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784555901;
	bh=xU6+UMrMETECGNj5kz3HFIDMespXd1Gl/N3B2EmeFnE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LyBPiqY0vU8bl1Y7N2ijbyIdKklqH9DLRrPcG6mVd6jvl26Fpg07P4D6WNPSfrhSR
	 TDklpC9TMxFM4oxAtwPw4OmgEWTrV8XKXTqgH2NXOR8RWhnmDDZb1YGtZf5k99Wzsr
	 RCY+01oB2ZfzbPwgmO5USgAmt9ybjlYHEGc4PEwgo3EvfifcERRbzcrq3mSxAgEq54
	 DWZ+AdUENt8jhdW7nKTNuF+OFl0AHbZE0w822w4TqrB/MzKPkj4OVdBa15FyNwgQ0b
	 5RXpiBz3VvuH08Y8YTjBtMLuS1Ip1vBkzDwRkT2OrZDgvyFqTZrKg9qBqu8t4/ATt0
	 LBYn29sJTY4PA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 net 3/6] xsk: provide sufficient space in
 pool->tx_descs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Maciej Fijalkowski" <maciej.fijalkowski@intel.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260719135609.147823-4-maciej.fijalkowski@intel.com>
References: <20260719135609.147823-1-maciej.fijalkowski@intel.com>
 <20260719135609.147823-4-maciej.fijalkowski@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 20 Jul 2026 13:58:20 +0000
Message-Id: <20260720135820.EE7AD1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Heap Buffer Overflow in batched Tx descriptor API when a share=
d XDP socket has a larger Tx ring.
--

--- Patch [3]: [PATCH v4 net 3/6] xsk: provide sufficient space in pool->tx=
_descs ---
commit 16fadec5330bdab35c81e060269bbbba543bb7cd
Author: Maciej Fijalkowski <maciej.fijalkowski@intel.com>

xsk: provide sufficient space in pool->tx_descs

The temporary Tx descriptor array in an XSK buffer pool is sized from the Tx
ring of the socket that creates the pool. This commit sizes the temporary
descriptor array to the larger of the first Tx ring and the device's
xdp_zc_max_segs capability to prevent stalls in batch parsing for shared-UM=
EM.

> diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> index 12a845d012f6f..091792d1d82de 100644
> --- a/net/xdp/xsk.c
> +++ b/net/xdp/xsk.c
[ ... ]
> @@ -1557,7 +1558,8 @@ static int xsk_bind(struct socket *sock, struct soc=
kaddr_unsized *addr, int addr
>  			 * utilizes
>  			 */
>  			if (xs->tx && !xs->pool->tx_descs) {
> -				err =3D xp_alloc_tx_descs(xs->pool, xs);
> +				err =3D xp_alloc_tx_descs(xs->pool, xs,
> +							dev->xdp_zc_max_segs);

[Severity: Critical]
This is a pre-existing issue, but does this logic leave the system vulnerab=
le
to a heap buffer overflow?

When a primary socket is configured with a small Tx ring, pool->tx_descs is
allocated with a small capacity. If a secondary shared-UMEM socket is then
bound with a much larger Tx ring, this check skips reallocating or resizing
pool->tx_descs.

Later, during batch reading, xsk_tx_peek_release_desc_batch() can overflow
this array:

net/xdp/xsk.c:xsk_tx_peek_release_desc_batch()
    ...
    nb_pkts =3D xskq_cons_read_desc_batch(xs->tx, pool, nb_pkts);
    ...

Since nb_pkts is not clamped to pool->tx_descs_nentries, the batch size
can exceed the allocated capacity. This leads to an out-of-bounds write
when xskq_cons_read_desc_batch() copies descriptors:

net/xdp/xsk_queue.h:xskq_cons_read_desc_batch()
    ...
    descs[nb_entries] =3D ring->desc[idx];
    ...

The same out-of-bounds write can occur in the fallback path:

net/xdp/xsk.c:xsk_tx_peek_release_fallback()
    ...
    while (nb_pkts < max_entries && xsk_tx_peek_desc(pool, &descs[nb_pkts]))
        nb_pkts++;
    ...

Since max_entries isn't clamped to the actual allocated capacity, couldn't
this corrupt adjacent kernel memory?

>  				if (err) {
>  					xp_put_pool(xs->pool);
>  					xs->pool =3D NULL;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260719135609.1478=
23-1-maciej.fijalkowski@intel.com?part=3D3
