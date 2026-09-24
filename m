Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3A9D3CF673;
	Thu, 24 Sep 2026 02:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790215542; cv=none; b=GUWIvX+oFFI9huPPN05dHLPkkT6G/9D4y4bDaIU4VKELKAkPdykzr9QNKK+rtj68S2SMPB6aHVgXiR485+baCzSTEL4oG7dxiiGhRYeT90l+zHpFQGhqzOzUWQWEvRh4e25yJQWJU5fSYbli7k9NQAt1baDeT8BvYLHQ+EzazUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790215542; c=relaxed/simple;
	bh=b74Iz/saENDXZAGOEFsebd/GZ++5KGmcHj5CmxLtzrw=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WHJT+AnRAUZsry5I/WtZJqUaVBAboSpcF/5RG+Rg0zeGNu73uM5QuKxGtLWX9BUHqHw9fCq7yA+XbZNnCdFPXgi1lYlzEJp9xWxIl4DeH0QNpcJurpBphogVkM+zMc4PAD9SOM+dvC6Us4tIxb2/5xvwZ74bmCrn4jbtIQ2HWzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fj/MmNgC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fj/MmNgC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 874161F000FF;
	Thu, 24 Sep 2026 02:05:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790215540;
	bh=muVdrR6ImlPxD0R3iLyz6Aa32j2BAVUEUHlQ/Gbmhd0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=fj/MmNgC7FTTuVBX4fjcM9CoR4Xg+h7QStZ2WhbXxK2G+HW9ra+zyZiZ1CEworSeQ
	 8O0N9giMOOqqTzfPDf1yJLBIy9hFFVlZ073fmnmJ3jo5JWX1dlvV9pBjK6TRcC7/W3
	 nvna6tI9xMT3S99T3W+vQkZ0BZl4af+qwr6COxmppWqsClHSlRz2s7IGVtRWGE+VMY
	 EoZ7lxWpaswE9eJ4nm2moaiEIlfaWimYvTUnBuaatWeBUFMyxIwmd0G3SVaDzoWcde
	 eAESd3I8qG3AaSea6ZaRALeHppO924tGp5Kbz44Rz18lS8KKIxXlKBbRcTFfLPIjcI
	 GDHKxZTQ4PPHQ==
Subject: Re: [PATCH net-next 7/8] eth: mpnic: implement Rx queue allocation
 and cleanup
From: netdev-bot+sashiko@kernel.org
To: daniel.zahka@gmail.com
Cc: alexanderduyck@fb.com, kuba@kernel.org, kernel-team@meta.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
 john.fastabend@gmail.com, sdf@fomichev.me, dimitri.daskalakis1@gmail.com,
 mohsin.bashr@gmail.com, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 bpf@vger.kernel.org
Date: Thu, 24 Sep 2026 02:05:39 +0000
Message-ID: <179021553913.2160803.3546397730187880772@kernel.org>
In-Reply-To: <20260922-linux-mpnic-v1-7-236844f53072@gmail.com>
References: <20260922-linux-mpnic-v1-7-236844f53072@gmail.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The Rx engines are added to an idle wait whose timeout is only
  logged, and teardown then frees memory the device writes into.
- [Low] The two comments about Rx buffer batching disagree with each
  other and with the code.

--

eth: mpnic: implement Rx queue allocation and cleanup

This adds the Rx side of the mpnic queue triad: a header buffer queue
and a payload buffer queue, both fed from one page pool per triad, plus
an Rx completion queue. Buffers are posted to the device in batches, and
the device is set up to leave XDP headroom and skb_shared_info tailroom.
Teardown releases any partially assembled frame and the buffers still
posted.

> diff --git a/drivers/net/ethernet/meta/mpnic/mpnic_txrx.c b/drivers/net/ethernet/meta/mpnic/mpnic_txrx.c
> index f4ad8caf6ce66..6d2123bee97b4 100644
> --- a/drivers/net/ethernet/meta/mpnic/mpnic_txrx.c
> +++ b/drivers/net/ethernet/meta/mpnic/mpnic_txrx.c

[ ... ]

> @@ -335,6 +336,109 @@ static void mpnic_clean_tcq(struct mpnic_napi_vector *nv,

[ ... ]

> +/* Descriptors are only handed to the device in whole batches, so the slot
> + * the device is working on and everything up to the next batch boundary
> + * stay untouched while it does.
> + */
> +static unsigned int mpnic_bdq_desc_unused(struct mpnic_ring *bdq)
> +{
> +	return (ALIGN_DOWN(bdq->head - 1, MPNIC_BDQ_BATCH_SIZE) - bdq->tail) &
> +	       bdq->size_mask;
> +}
> +
> +static unsigned int __mpnic_fill_bdq(struct mpnic_ring *bdq)
> +{
> +	unsigned int i = bdq->tail;
> +	unsigned int count;
> +
> +	for (count = mpnic_bdq_desc_unused(bdq); count; count--) {
> +		struct page *page;
> +
> +		page = page_pool_dev_alloc_pages(bdq->page_pool);
> +		if (!page)
> +			break;
> +
> +		bdq->rx_buf[i] = page;
> +		mpnic_bd_prep(bdq, i, page);
> +
> +		i++;
> +		i &= bdq->size_mask;
> +	}
> +
> +	return i;
> +}
> +
> +static void __mpnic_bdq_commit_tail(struct mpnic_ring *bdq, unsigned int tail)
> +{
> +	if (bdq->tail != tail) {
> +		bdq->tail = tail;
> +
> +		writeq(tail, bdq->doorbell);
> +	}
> +}

[Severity: Low]
This isn't a bug, but is the comment on mpnic_bdq_desc_unused() accurate?

__mpnic_fill_bdq() stops as soon as page_pool_dev_alloc_pages() returns
NULL. __mpnic_bdq_commit_tail() then writes that tail to the doorbell,
so a tail that is not on a 64 descriptor boundary can reach the device.
In that case descriptors are not handed over in whole batches.

It also looks like the slot at head - 1 stays untouched because of the
"head - 1" term. Whole-batch posting is not what protects it. The
ALIGN_DOWN only holds back up to 63 more slots that have already been
consumed.

The comment on MPNIC_BDQ_BATCH_SIZE in mpnic_txrx.h gives a different
reason for batching:

 * doorbell. The device consumes whatever the doorbell points at, this is
 * purely to keep the driver from writing the CSR for every descriptor.

Could the two comments be made consistent with each other and with what
the refill code actually does?

[ ... ]

> @@ -760,6 +1081,9 @@ void mpnic_wait_all_queues_idle(struct mpnic_dev *mpd)
>  		{ MPNIC_TQS_IDLE(0), MPNIC_TQS_IDLE_CNT, "TQS" },
>  		{ MPNIC_TDE_IDLE(0), MPNIC_TDE_IDLE_CNT, "TDE" },
>  		{ MPNIC_TCQ_IDLE(0), MPNIC_TCQ_IDLE_CNT, "TCQ" },
> +		{ MPNIC_HPQ_IDLE(0), MPNIC_HPQ_IDLE_CNT, "HPQ" },
> +		{ MPNIC_PPQ_IDLE(0), MPNIC_PPQ_IDLE_CNT, "PPQ" },
> +		{ MPNIC_RCQ_IDLE(0), MPNIC_RCQ_IDLE_CNT, "RCQ" },
>  	};
>  	u32 non_idle_bitmap;
>  	int err;

[Severity: Medium]
What happens in mpnic_stop() if one of the new Rx engines is still busy
when this wait times out?

mpnic_wait_all_queues_idle() returns void. It only logs on timeout:

	err = read_poll_timeout(mpnic_non_idle_queues, non_idle_bitmap,
				!non_idle_bitmap, 20, 500000, false, mpd,
				queues, ARRAY_SIZE(queues));
	if (err)
		mpnic_idle_dump(mpd, queues, ARRAY_SIZE(queues),
				non_idle_bitmap, err);

mpnic_stop() then keeps tearing down:

	mpnic_disable(mpn);
	mpnic_wait_all_queues_idle(mpn->mpd);
	mpnic_flush(mpn);

	mpnic_reset_netif_queues(mpn);
	mpnic_free_resources(mpn);

mpnic_flush()->mpnic_clean_bdq() hands every posted HPQ/PPQ page back to
the pool with page_pool_put_full_page(). After that,
mpnic_free_resources()->mpnic_free_nv_resources()->
mpnic_free_rx_qt_resources() frees the RCQ ring with dma_free_coherent()
and calls page_pool_destroy(), which unmaps and frees the pages.

The earlier commit "eth: mpnic: start and stop the Tx HW queues" says
disabling a queue "only stops the device picking up new work, it does
not tell us that the work already fetched has been retired". If so, a
DMA_FROM_DEVICE write could still be in flight after a timeout. Examples
are descriptors the prefetcher has already fetched, or a frame the RDE
is partway through.

Could such a write land in RCQ memory or Rx pages that have already been
unmapped and possibly reused? That would cause an IOMMU fault, or silent
memory corruption on systems without an IOMMU. Before this patch, no
device-written Rx buffers were covered by this best-effort wait.

Whether this can happen depends on whether a non-idle Rx engine can
still complete DMA after the timeout. fbnic_down() follows the same
ordering. Would it make sense to return the timeout to mpnic_stop() and
avoid freeing device-writable memory (or reset the device first) when
the queues never go idle?

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260922-linux-mpnic-v1-0-236844f53072%40gmail.com
