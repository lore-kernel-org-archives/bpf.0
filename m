Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3E2B4570C9;
	Thu, 23 Jul 2026 16:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784824201; cv=none; b=jnnhif9NHbCFtbMbetKUHPoxbqYW1O4HHNm7w6IcH0h+1Icf8pMO+JESKiQfikr8x4D8m0VDp4vq9tcREDfvuOfZ2N1WHyyx+tYOFeoFjtQi7wwrRfd2X1uXUAED8tK+tnt1l5y7PWyuJHeSHaJ1y9o2xf+e2SoeB3919qo/Mfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784824201; c=relaxed/simple;
	bh=FjgixsGEkiICfW4AAyiJ6GcUgNRvrRd8/9gGb+zjX1Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aFjL3qp9E5yXBzOU4y67c4NKf+1Z2jhyxD4TONTRmE/V9sPmjKAUrK18kjV3F7EHUxdn3d5XIKvKZs+/kBJZKkKCZMsMRC1oWNuOWqD3469wLuFFbS82fmxSv/IPQD0KCtZmISWfuFmg8XAFzZNZig2Lv3qRKN6oDRjBw0IpvFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U+328OFu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U+328OFu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70DD61F00A3A;
	Thu, 23 Jul 2026 16:29:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784824190;
	bh=b20K/8ddWSRGjEqK8nPsPuodkJZA0HrEnPd+8bVOpiI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=U+328OFuVX/PMvfNDRXnmoAdDxWKF3iKJw9z6gMG2xNFsiXRHx/1CFsFU8wPjSHbT
	 w2R+vHMm+mLvalxYe6PV0l4geZEubwkEtkWzszEblRv0CtpalVAegRbcVAhja7a/ns
	 FNqLtyurR/8c5vGJyGTOtwH0kPClK6XMwYxw/7c7B8EQTXLP+dQWttQdMa0NAxMLJP
	 3+JlzPWeqi8cg3AEXPncPvAl5L2X3Qx3ky+TsH/lcUfJXVXViohpOMCcTLlzxQk1yt
	 uXGrG5dDtNFWXNTmObcZHAbiziRzjpSiKyJb36Ykh9IIiadnG7an4w3ek8Xjvk/nvh
	 LljY5T+XZ5WQA==
From: Jakub Kicinski <kuba@kernel.org>
To: maciej.fijalkowski@intel.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	magnus.karlsson@intel.com,
	stfomichev@gmail.com,
	pabeni@redhat.com,
	horms@kernel.org,
	bjorn@kernel.org,
	kerneljasonxing@gmail.com,
	kernelxing@tencent.com
Subject: Re: [PATCH v4 net 4/6] xsk: reclaim invalid Tx descriptors in ZC batch path
Date: Thu, 23 Jul 2026 09:29:47 -0700
Message-ID: <20260723162947.747377-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260719135609.147823-5-maciej.fijalkowski@intel.com>
References: <20260719135609.147823-5-maciej.fijalkowski@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
xsk: reclaim invalid Tx descriptors in ZC batch path

This change parses ZC Tx batches in packet units so that descriptors
belonging to invalid or oversize packets are appended to the CQ address
area for userspace reclaim instead of being silently consumed. New
per-pool state (reclaim_descs, tx_zc_pending_descs) sequences reclaim
publication against outstanding driver-visible Tx completions.

Fixes: cf24f5a5feea ("xsk: add support for AF_XDP multi-buffer on Tx path")

> diff --git a/Documentation/networking/af_xdp.rst b/Documentation/networking/af_xdp.rst
> index 50d92084a49c..cc3f0d16b28f 100644
> --- a/Documentation/networking/af_xdp.rst
> +++ b/Documentation/networking/af_xdp.rst
> @@ -504,21 +506,25 @@ will be treated as an invalid descriptor.
>  These are the semantics for producing packets onto AF_XDP Tx ring
>  consisting of multiple frames:
>  
> -* When an invalid descriptor is found, all the other
> -  descriptors/frames of this packet are marked as invalid and not
> -  completed. The next descriptor is treated as the start of a new
> -  packet, even if this was not the intent (because we cannot guess
> -  the intent). As before, if your program is producing invalid
> -  descriptors you have a bug that must be fixed.
> +* When an invalid descriptor is found, the complete packet is treated as
> +  invalid. The kernel consumes descriptors through the descriptor marking
> +  the end of the packet and returns all their frame addresses through the
> +  COMPLETION ring. A standalone invalid descriptor is treated as a
> +  one-descriptor invalid packet. The descriptor following the end of the
> +  invalid packet is treated as the start of a new packet. As before, if
> +  your program is producing invalid descriptors you have a bug that must
> +  be fixed. Rejected descriptors are reported in the ``tx_invalid_descs``
> +  statistic.

[Medium]
Is the "Rejected descriptors are reported in the tx_invalid_descs
statistic" claim accurate for the oversize case?

Looking at xskq_cons_read_desc_batch(), the xdp_zc_max_segs overflow path
sets drain based on nr_frags alone:

    if (nr_frags == pool->xdp_zc_max_segs)
        drain = true;

Every individual descriptor in the oversize packet passed
xskq_cons_is_valid_desc(), so invalid_descs (bumped only from that
per-descriptor helper) is never incremented in this path.

Should the documentation distinguish the oversize case, or should the
oversize drain also increment tx_invalid_descs so the documented
observability signal matches reality?

> @@ -504,21 +506,25 @@ will be treated as an invalid descriptor.
>  * For copy mode, the maximum supported number of frames in a packet is
> -  equal to CONFIG_MAX_SKB_FRAGS + 1. If it is exceeded, all
> -  descriptors accumulated so far are dropped and treated as
> -  invalid. To produce an application that will work on any system
> -  regardless of this config setting, limit the number of frags to 18,
> -  as the minimum value of the config is 17.
> +  equal to CONFIG_MAX_SKB_FRAGS + 1. If it is exceeded, all descriptors
> +  through the end of the oversized packet are consumed, treated as invalid,
> +  and their frame addresses are returned through the COMPLETION ring. To
> +  produce an application that will work on any system regardless of this
> +  config setting, limit the number of frags to 18, as the minimum value of
> +  the config is 17.

[ ... ]

> diff --git a/include/net/xsk_buff_pool.h b/include/net/xsk_buff_pool.h
> index f5e737a83055..2bb1d122b1bc 100644
> --- a/include/net/xsk_buff_pool.h
> +++ b/include/net/xsk_buff_pool.h
> @@ -78,6 +78,9 @@ struct xsk_buff_pool {
>  	u32 chunk_size;
>  	u32 chunk_shift;
>  	u32 frame_len;
> +	u32 tx_descs_nentries;
> +	u32 reclaim_descs;
> +	u32 tx_zc_pending_descs;
>  	u32 xdp_zc_max_segs;

[High]
How are pool->reclaim_descs and pool->tx_zc_pending_descs unwound when
the Tx path stops without producing further completions?

The gate in xsk_tx_peek_release_desc_batch() is:

    if (unlikely(READ_ONCE(pool->reclaim_descs)))
        goto out;

The only place these two fields are cleared is xsk_tx_completed() when
enough driver-visible completions arrive. What happens if:

    - the netdev is brought down via ndo_stop mid-flight,
    - the socket unbinds/closes while reclaim_descs is nonzero,
    - the ZC driver resets and drops in-flight descriptors,
    - link goes down and the pending Tx never completes?

In each of these cases xsk_tx_completed() is never called with the
outstanding count, pool->reclaim_descs stays nonzero forever, and every
subsequent xsk_tx_peek_release_desc_batch() early-returns. The reclaim
CQ slots that xskq_prod_write_addr_batch() has already written are never
made visible to userspace because the CQ producer is never advanced.

In a shared-UMEM pool, one socket tearing down mid-drain would block ZC
batch Tx for every peer socket on that pool. There does not seem to be
any teardown path (xsk_release, xp_disable_drv_zc/xp_enable_drv_zc,
driver rebind) that zeroes these new fields.

Similarly, xs->drain_cont is per-socket state that can persist across
close. If the socket goes away mid-drain, is anything expected to reset
the pool-level counters that were set on its behalf?

> diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> index 091792d1d82d..f906d51b6699 100644
> --- a/net/xdp/xsk.c
> +++ b/net/xdp/xsk.c
> @@ -499,6 +499,23 @@ void __xsk_map_flush(struct list_head *flush_list)
>  
>  void xsk_tx_completed(struct xsk_buff_pool *pool, u32 nb_entries)
>  {
> +	u32 reclaim_descs = READ_ONCE(pool->reclaim_descs);
> +
> +	if (unlikely(reclaim_descs)) {
> +		u32 pending_descs = READ_ONCE(pool->tx_zc_pending_descs);
> +
> +		if (nb_entries < pending_descs) {
> +			WRITE_ONCE(pool->tx_zc_pending_descs,
> +				   pending_descs - nb_entries);
> +			xskq_prod_submit_n(pool->cq, nb_entries);
> +			return;
> +		}
> +
> +		WRITE_ONCE(pool->tx_zc_pending_descs, 0);
> +		nb_entries += reclaim_descs;
> +		WRITE_ONCE(pool->reclaim_descs, 0);
> +	}
> +
>  	xskq_prod_submit_n(pool->cq, nb_entries);
>  }
>  EXPORT_SYMBOL(xsk_tx_completed);

[High]
Is memory ordering between reclaim_descs and tx_zc_pending_descs
sufficient here?

The writer in xsk_tx_commit_batch() publishes tx_zc_pending_descs first,
then reclaim_descs:

    WRITE_ONCE(pool->tx_zc_pending_descs,
               batch->tx_descs + cq_pending_descs);
    WRITE_ONCE(pool->reclaim_descs, batch->reclaim_descs);

The reader here loads reclaim_descs first, then tx_zc_pending_descs.
WRITE_ONCE / READ_ONCE prevent tearing and compiler reordering but do
not emit CPU barriers.

On weakly-ordered architectures, if the reader observes
reclaim_descs != 0 but a stale tx_zc_pending_descs == 0, the

    if (nb_entries < pending_descs)

branch is skipped, reclaim_descs is added to nb_entries, and the CQ is
advanced past the driver-visible Tx slots that were supposed to precede
the reclaim entries. This is the ordering the commit message says the
new fields exist to enforce ("CQ is positional. Descriptors already
written but not submitted must complete before any reclaim-only
descriptors appended below").

Should the flag store use smp_store_release() paired with an
smp_load_acquire() on the reader, or an explicit smp_wmb/smp_rmb between
the two fields on each side?

[High]
Is this sequence safe against concurrent xsk_tx_completed() callers on
the same pool?

    reclaim_descs = READ_ONCE(pool->reclaim_descs);
    if (unlikely(reclaim_descs)) {
        ...
        WRITE_ONCE(pool->tx_zc_pending_descs, 0);
        nb_entries += reclaim_descs;
        WRITE_ONCE(pool->reclaim_descs, 0);
    }

xsk_tx_completed() is EXPORT_SYMBOL and called by several drivers
(i40e, ice, ixgbe, mlx5, virtio_net, gve, ...). virtio_net in
particular can invoke it from more than one context.

If two callers both READ_ONCE(reclaim_descs) = R, both take the reclaim
branch, and both add R to their local nb_entries before clearing
reclaim_descs, do they not together publish 2*R reclaim entries on the
CQ, releasing the same UMEM frame addresses to userspace twice?

The existing CQ producer paths (xsk_cq_reserve_locked /
xsk_cq_cancel_locked) already take pool->cq->cq_cached_prod_lock
precisely because the CQ can be produced from multiple contexts. Should
the new RMW on reclaim_descs / tx_zc_pending_descs extend that lock
coverage, or use an atomic RMW / cmpxchg?

> @@ -574,24 +591,157 @@ static u32 xsk_tx_peek_release_fallback(struct xsk_buff_pool *pool, u32 max_entr
>  	return nb_pkts;
>  }
>  
> +static void xsk_tx_commit_batch(struct xsk_buff_pool *pool,
> +				struct xsk_tx_batch *batch)
> +{
> +	u32 nb_descs = xsk_tx_batch_cq_descs(batch);
> +	u32 cq_cached_prod;
> +
> +	if (!nb_descs)
> +		return;
> +
> +	cq_cached_prod = pool->cq->cached_prod;
> +	xskq_prod_write_addr_batch(pool->cq, pool->tx_descs, nb_descs);
> +
> +	if (unlikely(batch->reclaim_descs)) {
> +		u32 cq_pending_descs;
> +
> +		/* CQ is positional. Descriptors already written but not
> +		 * submitted must complete before any reclaim-only descriptors
> +		 * appended below.
> +		 */
> +		cq_pending_descs = cq_cached_prod - xskq_get_prod(pool->cq);
> +
> +		WRITE_ONCE(pool->tx_zc_pending_descs,
> +			   batch->tx_descs + cq_pending_descs);
> +		WRITE_ONCE(pool->reclaim_descs, batch->reclaim_descs);
> +		if (unlikely(!pool->tx_zc_pending_descs))
> +			xsk_tx_completed(pool, 0);
> +	}
> +}
> +
> +static struct xsk_tx_batch
> +__xsk_tx_peek_release_desc_batch(struct xsk_buff_pool *pool, struct xdp_sock *xs,
> +				 struct xdp_desc *descs, u32 max_descs)
> +{
> +	struct xsk_tx_batch batch = {};
> +	u32 entries;
> +
> +	entries = xskq_cons_nb_entries(xs->tx, max_descs);
> +	if (!entries)
> +		return batch;
> +
> +	batch = xskq_cons_read_desc_batch(xs, pool, descs, max_descs);
> +	if (!xsk_tx_batch_cq_descs(&batch)) {
> +		xs->tx->queue_empty_descs++;
> +	} else {
> +		__xskq_cons_release(xs->tx);
> +		xs->sk.sk_write_space(&xs->sk);
> +	}
> +	return batch;
> +}

[Medium]
Is queue_empty_descs the right counter to bump when the batch returned
zero because of the budget_limited path?

xskq_cons_read_desc_batch() can return

    batch = { tx_descs = 0, reclaim_descs = 0, budget_limited = true }

when it reads descriptors mid-packet, hits nb_entries == max before the
end-of-packet descriptor, and rewinds cached_cons. In that case the
queue is not empty; the caller was just out of budget. Should this case
be distinguished from a truly-empty consumer queue for the userspace
statistic?

> @@ -603,19 +753,16 @@ u32 xsk_tx_peek_release_desc_batch(struct xsk_buff_pool *pool, u32 nb_pkts)
> [ ... ]
> +	batch = umem_shared ?
> +		xsk_tx_peek_release_shared_desc_batch(pool, nb_pkts) :
> +		__xsk_tx_peek_release_desc_batch(pool, xs,
> +						 pool->tx_descs,
> +						 nb_pkts);
> +	xsk_tx_commit_batch(pool, &batch);

[High]
xsk_tx_peek_release_desc_batch() checks pool->reclaim_descs under only
rcu_read_lock():

    if (unlikely(READ_ONCE(pool->reclaim_descs)))
        goto out;

and xsk_tx_commit_batch() later overwrites both fields unconditionally
with WRITE_ONCE. If two producers pass the gating check concurrently
(the batch API is not documented as single-threaded, and the pre-existing
shared-UMEM CQ producer paths already require cq_cached_prod_lock), can
one batch's pending-drain accounting silently overwrite the other's,
causing reclaim entries to be published before the driver-visible
descriptors from the other batch have completed?

> diff --git a/net/xdp/xsk_queue.h b/net/xdp/xsk_queue.h
> index 3e3fbb73d23e..1bc42c8902f4 100644
> --- a/net/xdp/xsk_queue.h
> +++ b/net/xdp/xsk_queue.h
> @@ -263,17 +274,18 @@ static inline void parse_desc(struct xsk_queue *q, struct xsk_buff_pool *pool,
>  	parsed->mb = xp_mb_desc(desc);
>  }
>  
> -static inline
> -u32 xskq_cons_read_desc_batch(struct xsk_queue *q, struct xsk_buff_pool *pool,
> -			      u32 max)
> +static inline struct xsk_tx_batch
> +xskq_cons_read_desc_batch(struct xdp_sock *xs, struct xsk_buff_pool *pool,
> +			  struct xdp_desc *descs, u32 max)
>  {
[ ... ]
>  		descs[nb_entries] = ring->desc[idx];
>  		cached_cons++;
>  		parse_desc(q, pool, &descs[nb_entries], &parsed);
>  		if (unlikely(!parsed.valid))
> -			break;
> +			drain = true;
> +
> +		nr_frags++;
> +		nb_entries++;

[Medium]
descs[nb_entries] is populated from ring->desc[idx] before parse_desc()
even for invalid descriptors, and xsk_tx_commit_batch() later writes
descs[i].addr straight into the CQ via xskq_prod_write_addr_batch() for
the reclaim range. No xp_aligned_validate_desc / xp_unaligned_validate_desc
range check is applied to invalid-descriptor addr values before they
appear on the CQ.

In XDP_SHARED_UMEM configurations where multiple sockets share a CQ, does
this allow one socket to publish an arbitrary attacker-chosen 64-bit
value into the shared CQ by submitting a single invalid Tx descriptor?

Downstream code that treats CQ entries as UMEM offsets (e.g. paths that
feed them back through xp_raw_get_data on subsequent Tx) would then
operate on that raw value. Prior semantics dropped invalid-descriptor
addresses silently.

Should the reclaim CQ entry be sanitized (masked to a frame-aligned base
or omitted) rather than published verbatim?
