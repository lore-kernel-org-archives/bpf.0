Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6E6124676D
	for <bpf@vger.kernel.org>; Wed, 24 Jun 2026 13:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782308017; cv=none; b=BUS83ooKb6hBnVaKuKMt5HhxccM07v5CWXgkeOmb6I2txmVg4ONQCrYvZWV9v8+KiwGIkmATnL/atinoP5Yqz7f2o+mgLBv3SUrg+Txt7Tp1RoDbURju8nMsvzs2ly+/v0iQQkkwU8cOeVAwy1JX4aujuA+ZpyQb4er3rweBFVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782308017; c=relaxed/simple;
	bh=R1ON8QB96O3g5Rg4jy1/+jt5aEGm1YWrTGtgndXWioA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=aRWHIs14r23y9zWpOyLQ281xn7UhZfKAMrQuDLdmjyl6k9DYzyslB+Fi5KbWuhfOFAMUiJBgbC+zY7QfeQj9v+1NrnBQ83bwqF1uS8W8qa/I05hFUTG0uuqxNJUv+8iGZZb+sIWyohtthHekE/QAZf/AH1Oe2KPgMfBDKh8ueAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WQ3peRhb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WQ3peRhb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30E331F000E9;
	Wed, 24 Jun 2026 13:33:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782308016;
	bh=BpSnQzkCZBKaBJpLVkSjZybzz7RY2LOiKZ2h3AV/TuU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WQ3peRhbwQknJtk06ilE4OZUt8MFtzIdl7NLJHMwD5EtMkMs4qKhkNHV/2kMLTsU6
	 /QWia/b2gwaylwJuNu3igasBQqr+6YSsFH87W6y1i82jQQf49KCQCgtWEm73g57sEp
	 uZz7QtJiIyn4Grc8WrBRa0+ndRBsBXQ5Q3DbpVA0lHHmQ9mL0NwRr6Udw75R1EmCL6
	 2ItIdzr1xR8JPuCU6KasaeImEUSHk60FzO91lopvkKyoFgLgoDfL+uR2w6GTqm/dVK
	 Mg4uRimo+66/1w9oki1ArtBIhRC5+tVc3EbZ3u7a/gyTobdtSYdoBwHtEclqntVU6d
	 TVAysTn8vu9aQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net 5/7] xsk: reclaim invalid multi-buffer Tx descs in
 ZC path
Reply-To: sashiko-reviews@lists.linux.dev
To: "Maciej Fijalkowski" <maciej.fijalkowski@intel.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260623133240.1048434-6-maciej.fijalkowski@intel.com>
References: <20260623133240.1048434-1-maciej.fijalkowski@intel.com>
 <20260623133240.1048434-6-maciej.fijalkowski@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 24 Jun 2026 13:33:35 +0000
Message-Id: <20260624133336.30E331F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Heap Buffer Overflow (OOB Write) in `xsk_tx_peek_release_fallback(=
)` due to array size mismatch in shared UMEM configuration.
--

commit 6ddf04bf3e0869241f35a9093870aefb3a5e86f2
Author: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Subject: xsk: reclaim invalid multi-buffer Tx descs in ZC path

This commit addresses an issue in the zero-copy Tx batching path where
multi-buffer packets with an invalid descriptor could leave earlier
descriptors consumed but unreturned to userspace. It handles invalid
multi-buffer packets as a unit, queuing reclaim-only descriptors to the
completion ring, and gates the batched path while a same-pool bind waits
for pre-existing readers.

> diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> --- a/net/xdp/xsk.c
> +++ b/net/xdp/xsk.c
> @@ -576,9 +588,20 @@ static u32 xsk_tx_peek_release_fallback(struct xsk_b=
uff_pool *pool, u32 max_entr
> =20
>  u32 xsk_tx_peek_release_desc_batch(struct xsk_buff_pool *pool, u32 nb_pk=
ts)
>  {
> +	struct xsk_tx_batch batch =3D {};
>  	struct xdp_sock *xs;
> +	u32 cq_cached_prod;
> =20
>  	rcu_read_lock();
> +
> +	/* Pairs with the release stores in xp_prepare_xsk_tx_share() and
> +	 * xp_finish_xsk_tx_share(). If bind is converting a singular Tx pool
> +	 * to shared, do not enter the singular batched path.
> +	 */
> +	if (smp_load_acquire(&pool->tx_share_pending))
> +		goto out;
> +	if (unlikely(pool->reclaim_descs))
> +		goto out;
>  	if (!list_is_singular(&pool->xsk_tx_list)) {
>  		/* Fallback to the non-batched version */
>  		rcu_read_unlock();

[Severity: High]
This is a pre-existing issue, but can the fallback path overwrite the
pool->tx_descs array?

In xsk_bind(), when a shared pool is created, pool->tx_descs is allocated
using xp_alloc_tx_descs() based on the first socket's nentries. If the first
socket is configured with a very small TX ring (for example, 2 entries),
pool->tx_descs is sized to match.

If a second socket with a larger TX ring is then bound to the same shared
pool, pool->tx_descs is not reallocated to accommodate the larger capacity.

When the batched path sees multiple sockets and falls back to the non-batch=
ed
version:

static u32 xsk_tx_peek_release_fallback(struct xsk_buff_pool *pool, u32 max=
_entries)
{
	struct xdp_desc *descs =3D pool->tx_descs;
	u32 nb_pkts =3D 0;

	while (nb_pkts < max_entries && xsk_tx_peek_desc(pool, &descs[nb_pkts]))
		nb_pkts++;
    ...
}

Does this loop write up to max_entries (the driver's budget, typically 64)
into the descs array, causing an out-of-bounds write past the initial small
allocation limit?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260623133240.1048=
434-1-maciej.fijalkowski@intel.com?part=3D5
