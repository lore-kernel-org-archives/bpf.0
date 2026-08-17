Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6623839D6D5;
	Mon, 17 Aug 2026 16:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786985962; cv=none; b=HRfZ5qIhZsq5ssv+Kruayk+CzIPJ3KTNVYn7hnfiqtDrTTQwfhcvY3nJmZm6V+zXy8w0Aqcgl7z91pnynY4gbM8jc1nlVaoOcy5Di5aJDMyU7sg3+Ed/MqpyDqIxKMe7xg/z8v5Plbp+U46cpfnINTL8lqsuqKkho/eHl0wH19k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786985962; c=relaxed/simple;
	bh=T4j0QwJ5SKB+nVxr1EGSvOBJI5cRnqNh7YogoerRrh0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QLlTQ65UqnFjnf24gUWmXmpr7UFaz5qRICqAzubeWXd2v3kvDOt4sjoSgz1MME/sKuCQLLixv5kZl45HRmrvCg3Ur57MMwxRbtmVDK1L2uE5O3nttVQeNzafhlr6DyZTb3eL/N90rotTuqlj2Q9ZaOMpZhHTauV+yvm7R2czvNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oWxeJtuQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oWxeJtuQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 874E51F000E9;
	Mon, 17 Aug 2026 16:59:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786985960;
	bh=svkV7SueWeJHLxrXS4vFaivJMc2Tl5qf+IeM7UwftSM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=oWxeJtuQpU8JDZamirEgYf3t2HgXGVkVPKZ8Di4ksEVwPNT/prmEO0EVlgmgwppzY
	 p8eHUM1EhUDsJG4v9TycGVrFoNItrHeOLWQpyBJIx+Dh9LstJriMCBXGL4rMqIZsM7
	 3cfwgn2JUIS4qhcxWRC8OLIPYxjBeQTMvzwyXAyqsflF587KfIfcrUNNZDTySW1PG2
	 VeyOTJCpTHi5alZOZ+7Rk7Wg6el+WBnuHKXljascbeluR7JVmxgidDmO5MEyFFC+rR
	 asz9dXGtX8ZhOzl5jTU4W2wGBhEGGLPyjp+U+ivYBI8QEMo7eRIxvtotMP+nPaKjFw
	 TFjmDZMUokiIQ==
From: Jakub Kicinski <kuba@kernel.org>
To: cyy@cyyself.name
Cc: Jakub Kicinski <kuba@kernel.org>,
	sukhdeeps@marvell.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	almasrymina@google.com,
	hawk@kernel.org,
	richardcochran@gmail.com,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3] net: atlantic: convert RX path to page_pool
Date: Mon, 17 Aug 2026 09:59:19 -0700
Message-ID: <20260817165919.3422774-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <tencent_F771B81731B921458D6F7CBF82ECDA888E08@qq.com>
References: <tencent_F771B81731B921458D6F7CBF82ECDA888E08@qq.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email says "Comment about PTP queue index looks legit, I haven't
investigated the rest."
---
net: atlantic: convert RX path to page_pool

This converts the atlantic RX buffers from hand-rolled high-order page
allocation plus a page-flip reuse scheme to page_pool fragments, registers
the RX (and PTP RX) xdp_rxq with MEM_TYPE_PAGE_POOL, and drops the
PageFlips/PageReuses/PageFrees ethtool counters that described the old
scheme.  A few questions below about the ownership transfers and about
what the commit message describes.

> net: atlantic: convert RX path to page_pool

[Severity: Low]
The subject and the body scope this to the RX path:

  "ensures every RX path either keeps the ring's fragment reference for
   reposting or hands it to the skb/xdp_buff for later recycling"

but the patch also changes TX completion behaviour in aq_ring_tx_clean(),
replacing xdp_return_frame_rx_napi() with xdp_return_frame().  That change
is only documented in an in-code comment.

The difference is real once this patch lands, because __xdp_return()
honours napi_direct only for MEM_TYPE_PAGE_POOL:

	case MEM_TYPE_PAGE_POOL:
		netmem = netmem_compound_head(netmem);
		if (napi_direct && xdp_return_frame_no_direct())
			napi_direct = false;
		page_pool_put_full_netmem(netmem_get_pp(netmem), netmem,
					  napi_direct);

so all XDP TX completions lose direct NAPI recycling, and frames arriving
via ndo_xdp_xmit() from a foreign pool are no longer pushed into that
pool's lock-free cache.  Could the commit message mention this TX-side
semantic change?

> diff --git a/drivers/net/ethernet/aquantia/atlantic/aq_ptp.c b/drivers/net/ethernet/aquantia/atlantic/aq_ptp.c
> index 558ac9237f75..3a40d986cd67 100644
> --- a/drivers/net/ethernet/aquantia/atlantic/aq_ptp.c
> +++ b/drivers/net/ethernet/aquantia/atlantic/aq_ptp.c

[ ... ]

> @@ -1192,12 +1193,23 @@ int aq_ptp_ring_alloc(struct aq_nic_s *aq_nic)
>  	if (err)
>  		goto err_exit_ptp_tx;
>  
> +	err = xdp_rxq_info_reg(&aq_ptp->ptp_rx.xdp_rxq, aq_nic->ndev,
> +			       rx_ring_idx, aq_ptp->napi.napi_id);
> +	if (err < 0)
> +		goto err_exit_ptp_rx;

[Severity: Low]
Is rx_ring_idx the right value for the queue_index argument here?  It comes
from aq_ptp_ring_idx(), which is documented in aq_ptp.h as a hardware
descriptor ring index:

	/* Index must to be 8 (8 TCs) or 16 (4 TCs).
	 * It depends from Traffic Class mode.
	 */
	static inline unsigned int aq_ptp_ring_idx(const enum aq_tc_mode tc_mode)

The peer call site in aq_vec_ring_alloc() passes the netdev queue index
instead:

		if (xdp_rxq_info_reg(&ring->xdp_rxq,
				     aq_nic->ndev, idx,
				     self->napi.napi_id) < 0) {

Note it passes idx, not idx_ring.  queue_index is exported to BPF as
xdp_md->rx_queue_index and is what AF_XDP compares against the bound queue
id, and 8 or 16 is outside the range the driver advertises with:

	err = netif_set_real_num_rx_queues(self->ndev,
					   self->aq_vecs * cfg->tcs);

__xdp_rxq_info_reg() stores the value verbatim without any range check:

	xdp_rxq->dev = dev;
	xdp_rxq->queue_index = queue_index;

The clean paths already treat the PTP ring as queue 0 via
skb_record_rx_queue(skb, is_ptp_ring ? 0 : AQ_NIC_RING2QMAP(...)), so
should this registration use 0 (or the netdev queue id) as well?

> diff --git a/drivers/net/ethernet/aquantia/atlantic/aq_ring.c b/drivers/net/ethernet/aquantia/atlantic/aq_ring.c
> index e1193c6719d9..9dd881710594 100644
> --- a/drivers/net/ethernet/aquantia/atlantic/aq_ring.c
> +++ b/drivers/net/ethernet/aquantia/atlantic/aq_ring.c

[ ... ]

> @@ -346,7 +284,11 @@ bool aq_ring_tx_clean(struct aq_ring_s *self)
>  			++self->stats.tx.packets;
>  			self->stats.tx.bytes += xdp_get_frame_len(buff->xdpf);
>  			u64_stats_update_end(&self->stats.tx.syncp);
> -			xdp_return_frame_rx_napi(buff->xdpf);
> +			/* Frames queued via ndo_xdp_xmit() may come from a
> +			 * page pool owned by another NAPI context: no direct
> +			 * recycling.
> +			 */
> +			xdp_return_frame(buff->xdpf);
>  		}

[Severity: High]
This isn't a regression introduced by this patch, but the pre-existing
ndo_xdp_xmit accounting in aq_xdp_xmit() becomes more expensive once the
frames are page_pool backed.  aq_xdp_xmit() keeps submitting after a
failure and returns a count:

	for (i = 0; i < num_frames; i++) {
		struct xdp_frame *xdpf = frames[i];

		if (aq_nic_xmit_xdpf(aq_nic, ring, xdpf) == NETDEV_TX_BUSY)
			drop++;
	}

	return num_frames - drop;

The core treats the return value as the length of a consumed prefix,
bq_xmit_all() in kernel/bpf/devmap.c:

	/* If not all frames have been transmitted, it is our
	 * responsibility to free them
	 */
	for (i = sent; unlikely(i < to_send); i++)
		xdp_return_frame_rx_napi(bq->q[i]);

and aq_nic_xmit_xdpf() returns NETDEV_TX_BUSY without freeing xdpf when
aq_nic_map_xdp() fails on dma_map_single()/skb_frag_dma_map():

	frags = aq_nic_map_xdp(aq_nic, xdpf, tx_ring);
	if (likely(frags))
		err = aq_nic->aq_hw_ops->hw_ring_tx_xmit(aq_nic->aq_hw, tx_ring,
							 frags);

So if a middle frame fails while a later one is queued successfully, the
core frees a frame that is still sitting in the TX ring, and the frame that
actually failed is never released.

After this patch, can that first frame then be released a second time here
through xdp_return_frame() -> page_pool_put_full_netmem(), underflowing
pp_ref_count and recycling a page the NIC is still DMAing from?  And does
the never-released frame hold a pool fragment forever, so the new
page_pool_destroy() call in aq_ring_free() stalls?

Would returning the length of the successfully transmitted prefix (breaking
out of the loop on the first failure) fix the accounting?

[ ... ]

> @@ -546,8 +489,11 @@ static bool aq_add_rx_fragment(struct device *dev,
>  	do {
>  		skb_frag_t *frag;
>  
> -		if (unlikely(sinfo->nr_frags >= MAX_SKB_FRAGS))
> +		if (unlikely(sinfo->nr_frags >= MAX_SKB_FRAGS)) {
> +			/* Attached frags must reach xdp_return_buff() */
> +			xdp_buff_set_frags_flag(xdp);
>  			return true;
> +		}
>  
>  		frag = &sinfo->frags[sinfo->nr_frags++];
>  		buff_ = &ring->buff_ring[buff_->next];
> @@ -571,6 +517,11 @@ static bool aq_add_rx_fragment(struct device *dev,
>  		if (page_is_pfmemalloc(buff_->rxdata.page))
>  			xdp_buff_set_frag_pfmemalloc(xdp);
>  
> +		/* The frag's page pool reference is owned by the xdp_buff
> +		 * from now on.
> +		 */
> +		buff_->rxdata.page = NULL;
> +
>  	} while (!buff_->is_eop);

[Severity: Low]
This isn't a bug, but the reported validation is:

  "smoke-tested with native XDP PASS, DROP, and ABORTED actions"
  at "MTU 1500"

Those three verdicts are exactly the paths that simply call
xdp_return_buff() in the new code.  The hunks with the ownership transfers
do not appear to be covered:

 - the per-fragment transfer above plus the new xdp_buff_set_frags_flag()
   on the MAX_SKB_FRAGS abort
 - the two buff->rxdata.page = NULL sites in __aq_ring_rx_clean()
 - XDP_TX and XDP_REDIRECT in aq_xdp_run_prog(), which lost their
   aq_get_rxpages_xdp() reference acquisition and now rely entirely on the
   caller having nulled buff->rxdata.page
 - the PTP RX ring, newly registered with MEM_TYPE_PAGE_POOL and sharing
   __aq_ring_xdp_clean()

Multi-buffer XDP cannot be reached at MTU 1500: aq_ring_rx_alloc() sets
self->frame_max = AQ_CFG_RX_FRAME_MAX (2048) and aq_xdp_setup() only allows
a larger MTU for frags-capable programs:

	if (prog && !prog->aux->xdp_has_frags) {
		if (ndev->mtu > AQ_CFG_RX_FRAME_MAX) {

so aq_add_rx_fragment() is never entered in that test.  Could the multi-
buffer, XDP_TX/XDP_REDIRECT and PTP-ring paths be exercised too (for
example at MTU 9000 with an xdp.frags program), so the fragment ownership
transfers are covered by more than inspection?

[ ... ]

> @@ -851,6 +803,11 @@ static int __aq_ring_xdp_clean(struct aq_ring_s *rx_ring,
>  		xdp_init_buff(&xdp, frame_sz, &rx_ring->xdp_rxq);
>  		xdp_prepare_buff(&xdp, hard_start, rx_ring->page_offset,
>  				 buff->len, false);
> +		/* The xdp_buff owns the buffer's page pool reference from
> +		 * here on; it comes back through the MEM_TYPE_PAGE_POOL
> +		 * memory model on every XDP verdict.
> +		 */
> +		buff->rxdata.page = NULL;

[Severity: High]
This is a pre-existing issue and the loops are untouched by the diff, but
since this patch reworks buffer ownership inside this function it may be
worth fixing here: the two descriptor-chain walks earlier in
__aq_ring_xdp_clean() are unbounded.  The RSC completion walk:

			do {
				if (buff_->next >= rx_ring->size) {
					err = -EIO;
					goto err_exit;
				}
				next_ = buff_->next;
				buff_ = &rx_ring->buff_ring[next_];
				is_rsc_completed =
					aq_ring_dx_in_range(rx_ring->sw_head,
							    next_,
							    rx_ring->hw_head);

				if (unlikely(!is_rsc_completed))
					break;
				...
			} while (!buff_->is_eop);

and the error-drain walk right below it follow buff->next, which for LRO
descriptors is copied straight out of the hardware write-back in
hw_atl_b0_hw_ring_rx_receive():

			if (buff->is_lro) {
				/* LRO */
				buff->next = rxd_wb->next_desc_ptr;

Can a cyclic chain A->B->A, where both entries are inside the
[sw_head, hw_head] window and neither has is_eop set, spin here forever
with BH disabled in the NAPI poll?  The non-XDP sibling
__aq_ring_rx_clean() bounds the identical walk:

				if (unlikely(!is_rsc_completed) ||
				    frag_cnt > MAX_SKB_FRAGS) {
					err = 0;
					goto err_exit;
				}

Should the XDP path carry the same hop counter?

>  		if (!buff->is_eop) {
>  			if (aq_add_rx_fragment(dev, rx_ring, buff, &xdp)) {
>  				u64_stats_update_begin(&rx_ring->stats.rx.syncp);

[ ... ]
-- 
pw-bot: cr
