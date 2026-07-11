Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2B74309F1B
	for <bpf@vger.kernel.org>; Sat, 11 Jul 2026 19:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783799114; cv=none; b=PLOaLVZXQPYXSSrC26Zdy2WxsKLSmp9hckRdH8FDqfUP6yreBBMVNhMzX+YuESLiLljvMe8fJGN0PjnaLsPC3sI0ZTzjkcrWMpvz2uhjV2MlSpYyABEog+vhrn6COMkOu8Z/6g1ozjlShNtiMXTaUv8YaaQSuvN2m8AId1xoP7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783799114; c=relaxed/simple;
	bh=pXLBgm9SsqdqxlFk+Qqj2vGMiEnWqL37XKnlfceKPKc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=E1a25m1FHeOFy0UhBEyUsYU6Nr2KjiclQFWall3xq3ud4MEMv7qbNeRvcHS4EFv6qVCCMu14NFbCNcKzG/fInfI4bWChJBWtEeZlKRrd7pdRivos436qG8Fjh2jQSbYakrzcQSzLo3UmarNIvmyDy6PVe/nIK7rdOlwGOogx6cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hVlbE/Xo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hVlbE/Xo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BDB41F000E9;
	Sat, 11 Jul 2026 19:45:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783799112;
	bh=fMR1Ko5fkE/vibauu5x3vtfvBOixicLzMB6Ny/7VHds=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hVlbE/XoAjTb8eDXOXXu+6b3MQ1S6QfMWzxUTTRJ/LYd88g83BzlVSvaZpZENy3JP
	 VcQuy4qVZZqH0WPeP9OpngXtwM9WKN+P4eafbmK5xq7YJ8dvtV98fg3OqnCFBvmT6O
	 G7BG3OPvMqqq2M6YPMQEB63roe+U1GzuhjiEGXg6CHzG3Q1C1P0REpGaPu7k3vKuaY
	 ZiyZ8+fo4Hj/OJQljmHkFftCGsDe/bgmR1IKrPe22tGHTNRORJX3RzfyjRbtzO9NuR
	 ZW/0DR/zzsyMqD67xPO/1L2cpwIdwpRZqSYxN+9iBQS+7SbibUnc29WoXmTniWBNGE
	 xVAlPV2HoBDKQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 net 3/5] xsk: reclaim invalid multi-buffer Tx descs
 in ZC path
Reply-To: sashiko-reviews@lists.linux.dev
To: "Maciej Fijalkowski" <maciej.fijalkowski@intel.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260710194424.84844-4-maciej.fijalkowski@intel.com>
References: <20260710194424.84844-1-maciej.fijalkowski@intel.com>
 <20260710194424.84844-4-maciej.fijalkowski@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 11 Jul 2026 19:45:11 +0000
Message-Id: <20260711194512.6BDB41F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Critical] Infinite loop and CPU soft lockup in NAPI context when process=
ing an incomplete multi-buffer packet on a shared UMEM socket.
- [High] Permanent TX queue stall or deadlock when a valid multi-buffer pac=
ket on a shared UMEM socket exceeds the TX ring size of the first bound soc=
ket.
--

--- Patch [3]: [PATCH v2 net 3/5] xsk: reclaim invalid multi-buffer Tx desc=
s in ZC path ---
commit 1dba20f5d7f0672e2b323a1eff536a35b9369bb8
Author: Maciej Fijalkowski <maciej.fijalkowski@intel.com>

xsk: reclaim invalid multi-buffer Tx descs in ZC path

The zero-copy Tx batch parser stops when it encounters an invalid
descriptor. If this happens after one or more continuation descriptors,
the Tx consumer can be advanced past fragments that are neither submitted
to the driver nor returned to userspace through the completion ring.
This patch parses Tx batches in packet units and reclaims descriptors
belonging to invalid or oversized packets.

> diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> index 43791647cf182..7d8b42c4c214b 100644
> --- a/net/xdp/xsk.c
> +++ b/net/xdp/xsk.c

[ ... ]

> @@ -574,22 +591,169 @@ static u32 xsk_tx_peek_release_fallback(struct xsk=
_buff_pool *pool, u32 max_entr
[ ... ]
> +static struct xsk_tx_batch
> +__xsk_tx_peek_release_desc_batch(struct xsk_buff_pool *pool, struct xdp_=
sock *xs,
> +				 struct xdp_desc *descs, u32 max_descs)
> +{
> +	struct xsk_tx_batch batch =3D {};
> +	u32 entries;
> +
> +	entries =3D xskq_cons_nb_entries(xs->tx, max_descs);
> +	if (!entries)
> +		return batch;
> +
> +	batch =3D xskq_cons_read_desc_batch(xs, pool, descs, entries);
                                                                   ^^^^^^^

[Severity: Critical]
Does passing the number of available fragments as the 'max' boundary hide t=
he
true budget limit from the reader?

If an unprivileged user space application sharing a UMEM pool submits an
incomplete multi-buffer packet without an EOP, xskq_cons_read_desc_batch()
reaches the end of the available fragments and evaluates (nb_entries =3D=3D=
 max)
to true. It incorrectly flags the batch as budget_limited and un-reads the
descriptors.

In xsk_tx_peek_release_shared_desc_batch(), this false budget_limited flag
combined with sufficient global CQ space causes budget_exhausted to become
true. When the loop finishes with no progress, it resets the budgets and
jumps to 'again'. Since the queue state is completely unchanged, could this
result in a permanent infinite loop and a CPU soft lockup in NAPI context?

> +	if (!xsk_tx_batch_cq_descs(&batch)) {
> +		xs->tx->queue_empty_descs++;
> +		if (batch.consumed_descs) {
> +			__xskq_cons_release(xs->tx);
> +			xs->sk.sk_write_space(&xs->sk);
> +		}
> +		return batch;
> +	}
> +
> +	__xskq_cons_release(xs->tx);
> +	xs->sk.sk_write_space(&xs->sk);
> +	return batch;
> +}

[ ... ]

>  u32 xsk_tx_peek_release_desc_batch(struct xsk_buff_pool *pool, u32 nb_pk=
ts)
>  {
> +	struct xsk_tx_batch batch =3D {};
>  	struct xdp_sock *xs;
> +	u32 cq_cached_prod;
> =20
>  	rcu_read_lock();
> +	if (unlikely(READ_ONCE(pool->reclaim_descs)))
> +		goto out;
> +	nb_pkts =3D min(nb_pkts, pool->tx_descs_nentries);
                  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

[Severity: High]
Does this strict cap on the batch size to the TX ring size of the first bou=
nd
socket cause issues for subsequent sockets with larger rings?

If a shared UMEM pool has a first socket with a small TX ring (e.g., 32),
pool->tx_descs_nentries becomes 32. If a second socket binds with a larger
TX ring (e.g., 128) and submits a valid multi-buffer packet larger than 32
fragments, this capped value restricts max_descs and remaining in
xsk_tx_peek_release_shared_desc_batch().

The reader will only be able to inspect up to pool->tx_descs_nentries
fragments, never reaching the EOP of the larger packet. The reader un-reads
the fragments and sets budget_limited to true.

If budget_left >=3D remaining (because remaining is artificially small),
budget_exhausted evaluates to false, causing the function to silently return
0. Could this permanently stall the TX queue for the socket?

> +	if (!nb_pkts)
> +		goto out;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260710194424.8484=
4-1-maciej.fijalkowski@intel.com?part=3D3
