Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E1933128DF
	for <bpf@vger.kernel.org>; Wed, 15 Jul 2026 14:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784124526; cv=none; b=tv2+Fzg9iHHmWRbGCP29ogeVtrSsAztk1w7o0s0mfav+W4ZIkLksU3iqVsGicie83M9Iv2xh129Q8aZ5qwXL2HKBr8NtTBDfQoE2MSeCFN+MS0h3EGItkrm4jzDtvBVuQPWeMuhRnEKGhfDkWtOqoyQ72HVfw0KQaNKSm1QumzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784124526; c=relaxed/simple;
	bh=NZMBYxpr7+h22waLWdJ6wU2aVcDR3ZbIx9cI4ZVE2bE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=uqLdjpirIVghb1IjxsZpW5e2moG7sK1JbNa9zpIkiDAN978kslwptGE2U00JtqlylWkfuk0k8xMozxsMxYpYdfQm2ZkvbJgb4z0B3OepkV1eMSmHoNFzWTDB2ZsIXYX6J7PJH5YxeRDAg7oZsTINo6YXSQ3FojRSXZhslWeUS3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dw6KZrS4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dw6KZrS4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 873211F000E9;
	Wed, 15 Jul 2026 14:08:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784124524;
	bh=vlrAHjYi0rWK+Yy3LM2pvm0/GbxCvyLAsLfk73J7Pzw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dw6KZrS4MPgZ0UmaQ8932E4FtSADEl/DOu6hBK+/luJPXX9zoR0IGobyxOuU5osOj
	 gyNPRqfOgzhjCkBnBcRtqz5yNTXXnSC82LSjqo/6Fe6pKLsn/gFo0Zewx01w9Qg1j/
	 OEfcWXfFOZt9zjoi7NTQ6qn2DnAcmS2PjMA4FlXqTXx+mceanWNFMye478SRygtQ9i
	 iLHPXppetry2aNq2lLF0JDb/eTXDzb0YR0MIhsnpjObuH5WfXtHzUjC+wfNK1kU0Vp
	 TLqv84jvlV+g+qgwHu+YtZwpQr+xEY+7m/j+SBNjYFh342dxB+IWdHkVFi/qDKNicS
	 UvFlW08xMIE6Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 net 3/6] xsk: provide sufficient space in
 pool->tx_descs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Maciej Fijalkowski" <maciej.fijalkowski@intel.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260714140722.111645-4-maciej.fijalkowski@intel.com>
References: <20260714140722.111645-1-maciej.fijalkowski@intel.com>
 <20260714140722.111645-4-maciej.fijalkowski@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 15 Jul 2026 14:08:44 +0000
Message-Id: <20260715140844.873211F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Heap buffer overflow in AF_XDP TX batch processing due to undersiz=
ed `pool->tx_descs` in shared UMEM configurations.
--

--- Patch [3]: [PATCH v3 net 3/6] xsk: provide sufficient space in pool->tx=
_descs ---
commit 6f635cabf694299ed3f7be4ce0e5f328e6bd90e0
Author: Maciej Fijalkowski <maciej.fijalkowski@intel.com>

xsk: provide sufficient space in pool->tx_descs

The temporary Tx descriptor array in an XSK buffer pool is currently
sized from the Tx ring of the socket that creates the pool.

[ ... ]

> Size the temporary descriptor array to the larger of the first Tx ring
> and the device's xdp_zc_max_segs capability. This keeps the array large
> enough to inspect one maximum-sized valid packet. Larger shared Tx rings
> do not require further resizing, as they can be processed over multiple
> batches.

[Severity: High]
This is a pre-existing issue, but is the statement that larger shared Tx
rings do not require further resizing accurate?

If a secondary socket shares the UMEM and has a much larger TX ring than
the first socket, pool->tx_descs is not resized, locking its size to
max(first_socket_nentries, dev->xdp_zc_max_segs).

However, the batch reading functions don't seem to bound their reads to
the allocated size of the array. They appear to read up to the driver's
budget (e.g., 64) and the current socket's available elements.=20

Could this cause a heap buffer overflow when writing into descs?

net/xdp/xsk.c:xsk_tx_peek_release_fallback() {
    ...
	while (nb_pkts < max_entries && xsk_tx_peek_desc(pool, &descs[nb_pkts]))
		nb_pkts++;
    ...
}

net/xdp/xsk_queue.h:xskq_cons_read_desc_batch() {
    ...
	while (cached_cons !=3D q->cached_prod && nb_entries < max) {
		...
		descs[nb_entries] =3D ring->desc[idx];
		cached_cons++;
    ...
}

If a user binds a minimal first socket (e.g. 2 entries) and a large shared
second socket, the softirq batch process could write past the end of the
array. Since ring->desc is memory-mapped to userspace, could an attacker
control the overwritten heap memory?

> diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> index 43791647cf182..385a3f4a1b320 100644
> --- a/net/xdp/xsk.c
> +++ b/net/xdp/xsk.c
> @@ -1557,7 +1558,8 @@ static int xsk_bind(struct socket *sock, struct soc=
kaddr_unsized *addr, int addr
>  			 * utilizes
>  			 */
>  			if (xs->tx && !xs->pool->tx_descs) {
> -				err =3D xp_alloc_tx_descs(xs->pool, xs);
> +				err =3D xp_alloc_tx_descs(xs->pool, xs,
> +							dev->xdp_zc_max_segs);

This isn't a bug introduced by this patch, but since tx_descs is not
reallocated if it already exists, the array size is permanently frozen
to the first socket's size.

Should the array be resized to accommodate the largest shared ring, or
should the batch readers be updated to cap their reads to the array's
actual size?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260714140722.1116=
45-1-maciej.fijalkowski@intel.com?part=3D3
