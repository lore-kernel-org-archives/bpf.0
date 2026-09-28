Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E67033E2756;
	Mon, 28 Sep 2026 00:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790553710; cv=none; b=N58+lvuVivHLj7wYHVZgUEvABPUJwDX+w523ocVFpRxzZW4IJQtW/kIYqZGpzgYa6M/IVEXY4PuGcq7E6y2BGMo4QyPPWEJi8D3HDapXg2df2MZAnHw7br7sR8GmMZRcXmiY7710h9xkuUNo5KQD3OUNGwzQ+bY9cxn9en8O6l0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790553710; c=relaxed/simple;
	bh=V2wZtyIdiMb1vda24lS8zQNtRQJCfayx+xvl0sozs2I=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NyAsurQgKTpGBxxcAyCleIQts5Khv40qKhHlAIty7BOFk9sR7IHluFYgfELkppApiNAxTAhWVq73b7quNqdAuEcIFH9nS1GX4Lu1TkmJnK1xwOr8Il3fBSltvkqJCTD1uU7u8rmTpSjztH18pW1NL6S1S/3No3Xxo+Ogo4MqEKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nDDT73vh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nDDT73vh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F6951F00899;
	Mon, 28 Sep 2026 00:01:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790553703;
	bh=JmHga8hWBYnlsVmfbKPndUXHjXG0cPkWr/zxKrrb6h8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=nDDT73vhTmQzzTsgXEBlvtFXV8Pw4sQi1Ko6lOTeFz7IHfiPkKhW3ywmHy8ANiyoW
	 lh73hk83eYk4wc45M+F8k7l4zUh065t6KrSrpI4IxN43nUwj8ShCNyeZ8fanycCn8+
	 ae/t3HkBVM4120Xh+LlHrvEbdjuovGy0uBwuVExl7Lbvs6/8nkv+ALMIiw6MzTYmei
	 0ocIRUKszN7E9SsQotf1aGHX1Eh1S/zxAKw/Un3IHuUQaY2twQgmlrxYP08pNLsVYe
	 strphzvAzSVS4t2c7m/RJ/gzcRUia/4pM78yQzofETNO8enZ2pqK24iHuLmrX4lJCs
	 K0eJ1sS38YQOg==
Subject: Re: [PATCH net-next v2 4/8] eth: mpnic: implement Tx queue allocation
 and cleanup
From: netdev-bot+sashiko@kernel.org
To: daniel.zahka@gmail.com
Cc: alexanderduyck@fb.com, kuba@kernel.org, kernel-team@meta.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
 john.fastabend@gmail.com, sdf@fomichev.me, dimitri.daskalakis1@gmail.com,
 mohsin.bashr@gmail.com, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 bpf@vger.kernel.org
Date: Mon, 28 Sep 2026 00:01:41 +0000
Message-ID: <179055370187.3145.16714537922103048975@kernel.org>
In-Reply-To: <20260924-linux-mpnic-v2-4-4badc9b58b9e@gmail.com>
References: <20260924-linux-mpnic-v2-4-4badc9b58b9e@gmail.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider.

Critical: 0 · High: 2 · Medium: 0 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] net: mpnic: missing bounds check on hardware completion head
  causes NULL deref
- [High] net: mpnic: integer underflow in desc_cnt causes massive out-of-
  bounds unmaps
- [Low] struct mpnic_ring::deferred_meta is documented as '-1 if the
  doorbell is in sync with the tail', yet at this commit the rings come…

--

eth: mpnic: implement Tx queue allocation and cleanup

This adds the Tx ring structures and the per-NAPI-vector allocation of
queue triads, descriptor memory and interrupts. It also adds completion
processing, where a single completion reports a work queue head and can
release many packets. The queues are not yet enabled in hardware.

> diff --git a/drivers/net/ethernet/meta/mpnic/mpnic_txrx.c b/drivers/net/ethernet/meta/mpnic/mpnic_txrx.c
> new file mode 100644
> index 0000000000000..853976e11b032
> --- /dev/null
> +++ b/drivers/net/ethernet/meta/mpnic/mpnic_txrx.c
> @@ -0,0 +1,495 @@

[ ... ]

> +static void mpnic_ring_init(struct mpnic_ring *ring, u32 __iomem *doorbell,
> +			    int q_idx)
> +{
> +	ring->doorbell = doorbell;
> +	ring->q_idx = q_idx;
> +}

[Severity: Low]
This isn't a bug at this point in the series, but the struct mpnic_ring
comment in mpnic_txrx.h describes deferred_meta like this:

	/* TWQ only, index of the metadata descriptor of the last packet
	 * placed in the ring without ringing the doorbell, -1 if the
	 * doorbell is in sync with the tail.
	 */
	s32 deferred_meta;

mpnic_alloc_napi_vector() gets the rings from kzalloc_flex(), and
mpnic_ring_init() never sets deferred_meta. So the field starts at 0, not
-1.

Would it make sense to set deferred_meta to -1 in mpnic_ring_init(), so the
field matches its comment from the start?

Nothing reads deferred_meta in this commit. The later patch "eth: mpnic:
start and stop the Tx HW queues" adds mpnic_enable_twq(), which sets tail
and head to 0 and deferred_meta to -1 on every enable. In mpnic_open()
that runs before mpnic_napi_enable() and netif_tx_wake_all_queues(), so
this only affects the intermediate state of the series.

[ ... ]

> @@ -0,0 +1,495 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) Meta Platforms, Inc. and affiliates. */
> +
> +#include <linux/bitfield.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/pci.h>
> +#include <linux/slab.h>
> +
> +#include "mpnic.h"
> +#include "mpnic_netdev.h"
> +#include "mpnic_txrx.h"
> +
> +struct mpnic_xmit_cb {
> +	u32 bytecount;
> +	u8 desc_count;
> +};
> +
> +#define MPNIC_XMIT_CB(__skb) ((struct mpnic_xmit_cb *)((__skb)->cb))
> +
> +/* Leave the interrupt moderation counters alone when arming or masking */
> +#define MPNIC_TIM_PARAM_CFG_PRESERVE_MASK \
> +	(MPNIC_TIM_CTL1_UPD_IGN_LONG_EVENT_CNT | \
> +	 MPNIC_TIM_CTL1_UPD_IGN_LONG_TIME_CNT | \
> +	 MPNIC_TIM_CTL1_UPD_IGN_SHORT_TIME_CNT)
> +
> +static void mpnic_nv_irq_disable(struct mpnic_napi_vector *nv)
> +{
> +	mpnic_wr64(nv->mpd, MPNIC_TIM_CTL1(nv->qt[0].cmpl.q_idx),
> +		   MPNIC_TIM_PARAM_CFG_PRESERVE_MASK |
> +		   MPNIC_TIM_CTL1_MASK_EN | MPNIC_TIM_CTL1_MASK);
> +}
> +
> +static void mpnic_nv_irq_rearm(struct mpnic_napi_vector *nv)
> +{
> +	/* Rearming a single queue on a given IRQ rearms all the other
> +	 * queues mapped to the same IRQ.
> +	 */
> +	mpnic_wr64(nv->mpd, MPNIC_TIM_CTL1(nv->qt[0].cmpl.q_idx),
> +		   MPNIC_TIM_PARAM_CFG_PRESERVE_MASK | MPNIC_TIM_CTL1_MASK_EN);
> +}
> +
> +static void mpnic_nv_irq_trigger(struct mpnic_napi_vector *nv)
> +{
> +	mpnic_wr64(nv->mpd, MPNIC_TIM_CTL1(nv->qt[0].cmpl.q_idx),
> +		   MPNIC_TIM_PARAM_CFG_PRESERVE_MASK |
> +		   MPNIC_TIM_CTL1_MASK_EN | MPNIC_TIM_CTL1_TRIGGER);
> +}
> +
> +static unsigned int mpnic_desc_unused(struct mpnic_ring *ring)
> +{
> +	return (ring->head - ring->tail - 1) & ring->size_mask;
> +}
> +
> +static struct netdev_queue *mpnic_txring_txq(const struct net_device *dev,
> +					     const struct mpnic_ring *ring)
> +{
> +	return netdev_get_tx_queue(dev, ring->q_idx);
> +}
> +
> +static void mpnic_unmap_single_twd(struct device *dev, __le64 *twd)
> +{
> +	u64 raw_twd = le64_to_cpu(*twd);
> +
> +	dma_unmap_single(dev, FIELD_GET(MPNIC_TWD_ADDR, raw_twd),
> +			 FIELD_GET(MPNIC_TWD_LEN, raw_twd), DMA_TO_DEVICE);
> +}
> +
> +static void mpnic_unmap_page_twd(struct device *dev, __le64 *twd)
> +{
> +	u64 raw_twd = le64_to_cpu(*twd);
> +
> +	dma_unmap_page(dev, FIELD_GET(MPNIC_TWD_ADDR, raw_twd),
> +		       FIELD_GET(MPNIC_TWD_LEN, raw_twd), DMA_TO_DEVICE);
> +}
> +
> +static void mpnic_clean_twq0(struct mpnic_napi_vector *nv, int napi_budget,
> +			     struct mpnic_ring *ring, bool discard,
> +			     unsigned int hw_head)
> +{
> +	u64 total_bytes = 0, total_packets = 0;
> +	unsigned int head = ring->head;
> +	struct netdev_queue *txq;
> +	unsigned int clean_desc;
> +
> +	clean_desc = (hw_head - head) & ring->size_mask;
> +
> +	while (clean_desc) {
> +		struct sk_buff *skb = ring->tx_buf[head];
> +		unsigned int desc_cnt;
> +
> +		desc_cnt = MPNIC_XMIT_CB(skb)->desc_count;
> +		if (desc_cnt > clean_desc)
> +			break;
> +
> +		ring->tx_buf[head] = NULL;
> +
> +		clean_desc -= desc_cnt;
> +
> +		/* Step over the metadata descriptor */
> +		head++;
> +		head &= ring->size_mask;
> +		desc_cnt--;
> +
> +		mpnic_unmap_single_twd(nv->dev, &ring->desc[head]);
> +		head++;
> +		head &= ring->size_mask;
> +		desc_cnt--;
> +
> +		while (desc_cnt--) {

[Severity: High]
What happens here if desc_count is 0 or 1? desc_cnt is an unsigned
int, and it is decremented twice unconditionally before the frag loop:
once for the metadata descriptor and once for the head descriptor.

With desc_count == 0 the desc_cnt > clean_desc check passes and
clean_desc is left unchanged. The second decrement then wraps desc_cnt
around to UINT_MAX. The frag loop calls mpnic_unmap_page_twd() about
four billion times, walking round and round the ring. Each call hands
whatever address and length it finds to dma_unmap_page() from softirq
context.

With desc_count == 1, mpnic_unmap_single_twd() is already applied to
the following slot, which does not belong to this packet. The same
wrap happens after that.

desc_count lives in skb->cb and is only written by the xmit path added
later in the series. This relies on every skb in tx_buf carrying a
sane count. It also relies on hw_head never covering a packet whose
descriptors are still being written. A device reporting a head that
runs ahead of what was posted is enough to get here.

Would it make sense to reject desc_cnt < 2 with a WARN_ON_ONCE()
before stepping over the metadata descriptor? Possibly
desc_cnt > MPNIC_MAX_SKB_DESC should be rejected as well.

> +			mpnic_unmap_page_twd(nv->dev, &ring->desc[head]);
> +			head++;
> +			head &= ring->size_mask;
> +		}
> +
> +		total_bytes += MPNIC_XMIT_CB(skb)->bytecount;
> +		total_packets++;
> +
> +		napi_consume_skb(skb, napi_budget);
> +	}
> +
> +	if (!total_bytes)
> +		return;
> +
> +	ring->head = head;
> +
> +	if (discard)
> +		return;
> +
> +	txq = mpnic_txring_txq(nv->napi.dev, ring);
> +	netif_txq_completed_wake(txq, total_packets, total_bytes,
> +				 mpnic_desc_unused(ring),
> +				 MPNIC_TX_DESC_WAKEUP);
> +}
> +
> +static void mpnic_commit_cq_head(struct mpnic_ring *cmpl)
> +{
> +	u32 head = cmpl->head;
> +
> +	/* The tail shadows the last value written to the doorbell, so a
> +	 * completion queue which has not moved costs no MMIO write.
> +	 */
> +	if (cmpl->tail != head) {
> +		cmpl->tail = head;
> +		writeq(head & cmpl->size_mask, cmpl->doorbell);
> +	}
> +}
> +
> +static void mpnic_clean_tcq(struct mpnic_napi_vector *nv,
> +			    struct mpnic_q_triad *qt, int napi_budget)
> +{
> +	struct mpnic_ring *cmpl = &qt->cmpl;
> +	__le64 *raw_tcd, done;
> +	u32 head = cmpl->head;
> +	s32 head0 = -1;
> +
> +	done = (head & (cmpl->size_mask + 1)) ? 0 : cpu_to_le64(MPNIC_TCD_DONE);
> +	raw_tcd = &cmpl->desc[head & cmpl->size_mask];
> +
> +	/* Walk the completion queue collecting the heads reported by NIC.
> +	 * Only the first work queue is enabled and no packet asks for a
> +	 * timestamp, so every completion is a plain head update and the
> +	 * descriptor type does not have to be decoded.
> +	 */
> +	while ((*raw_tcd & cpu_to_le64(MPNIC_TCD_DONE)) == done) {
> +		u64 tcd;
> +
> +		dma_rmb();
> +
> +		tcd = le64_to_cpu(*raw_tcd);
> +		head0 = FIELD_GET(MPNIC_TCD_TYPE0_HEAD0, tcd);
> +
> +		raw_tcd++;
> +		head++;
> +
> +		if (unlikely(!(head & cmpl->size_mask))) {
> +			done ^= cpu_to_le64(MPNIC_TCD_DONE);
> +			raw_tcd = &cmpl->desc[0];
> +		}
> +	}
> +
> +	cmpl->head = head;
> +
> +	if (head0 >= 0)
> +		mpnic_clean_twq0(nv, napi_budget, &qt->sub0, false, head0);
> +}
> +
> +static int mpnic_poll(struct napi_struct *napi, int budget)
> +{
> +	struct mpnic_napi_vector *nv = container_of(napi,
> +						    struct mpnic_napi_vector,
> +						    napi);
> +	int i;
> +
> +	for (i = 0; i < nv->txt_count; i++)
> +		mpnic_clean_tcq(nv, &nv->qt[i], budget);
> +
> +	for (i = 0; i < nv->txt_count; i++)
> +		mpnic_commit_cq_head(&nv->qt[i].cmpl);
> +
> +	if (likely(napi_complete_done(napi, 0)))
> +		mpnic_nv_irq_rearm(nv);
> +
> +	return 0;
> +}
> +
> +static irqreturn_t mpnic_msix_clean_rings(int __always_unused irq, void *data)
> +{
> +	struct mpnic_napi_vector *nv = data;
> +
> +	napi_schedule_irqoff(&nv->napi);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static void mpnic_free_napi_vector(struct mpnic_net *mpn,
> +				   struct mpnic_napi_vector *nv)
> +{
> +	int i;
> +
> +	for (i = 0; i < nv->txt_count; i++)
> +		mpn->tx[nv->qt[i].sub0.q_idx] = NULL;
> +
> +	mpnic_free_irq(nv->mpd, nv->v_idx, nv);
> +	netif_napi_del_locked(&nv->napi);
> +	mpn->napi[nv->v_idx - MPNIC_NON_NAPI_VECTORS] = NULL;
> +	kfree(nv);
> +}
> +
> +void mpnic_free_napi_vectors(struct mpnic_net *mpn)
> +{
> +	int i;
> +
> +	for (i = 0; i < mpn->num_napi; i++)
> +		if (mpn->napi[i])
> +			mpnic_free_napi_vector(mpn, mpn->napi[i]);
> +}
> +
> +static void mpnic_ring_init(struct mpnic_ring *ring, u32 __iomem *doorbell,
> +			    int q_idx)
> +{
> +	ring->doorbell = doorbell;
> +	ring->q_idx = q_idx;
> +}
> +
> +static int mpnic_alloc_napi_vector(struct mpnic_dev *mpd,
> +				   struct mpnic_net *mpn, unsigned int idx)
> +{
> +	u32 __iomem *uc_addr = READ_ONCE(mpd->uc_addr0);
> +	struct mpnic_napi_vector *nv;
> +	int err;
> +
> +	/* Doorbells are plain pointers into the register window, they have
> +	 * no way of noticing that it went away.
> +	 */
> +	if (!uc_addr)
> +		return -EIO;
> +
> +	nv = kzalloc_flex(*nv, qt, 1);
> +	if (!nv)
> +		return -ENOMEM;
> +
> +	nv->txt_count = 1;
> +	nv->mpd = mpd;
> +	nv->dev = mpd->dev;
> +	nv->v_idx = idx + MPNIC_NON_NAPI_VECTORS;
> +
> +	mpn->napi[idx] = nv;
> +	netif_napi_add_config_locked(mpn->netdev, &nv->napi, mpnic_poll, idx);
> +	netif_napi_set_irq_locked(&nv->napi,
> +				  pci_irq_vector(to_pci_dev(mpd->dev),
> +						 nv->v_idx));
> +
> +	snprintf(nv->name, sizeof(nv->name), "%s-TxRx-%u",
> +		 mpn->netdev->name, idx);
> +
> +	err = mpnic_request_irq(mpd, nv->v_idx, mpnic_msix_clean_rings, 0,
> +				nv->name, nv);
> +	if (err)
> +		goto err_napi_del;
> +
> +	mpnic_ring_init(&nv->qt[0].sub0, &uc_addr[MPNIC_TWQ_TAIL(idx, 0)], idx);
> +	mpnic_ring_init(&nv->qt[0].cmpl, &uc_addr[MPNIC_TCQ_HEAD(idx)], idx);
> +	mpn->tx[idx] = &nv->qt[0].sub0;
> +
> +	return 0;
> +
> +err_napi_del:
> +	netif_napi_del_locked(&nv->napi);
> +	mpn->napi[idx] = NULL;
> +	kfree(nv);
> +	return err;
> +}
> +
> +int mpnic_alloc_napi_vectors(struct mpnic_net *mpn)
> +{
> +	unsigned int i;
> +	int err;
> +
> +	for (i = 0; i < mpn->num_napi; i++) {
> +		err = mpnic_alloc_napi_vector(mpn->mpd, mpn, i);
> +		if (err)
> +			goto err_free_vectors;
> +	}
> +
> +	return 0;
> +
> +err_free_vectors:
> +	mpnic_free_napi_vectors(mpn);
> +
> +	return err;
> +}
> +
> +static void mpnic_free_ring_resources(struct device *dev,
> +				      struct mpnic_ring *ring)
> +{
> +	kvfree(ring->tx_buf);
> +	ring->tx_buf = NULL;
> +
> +	/* If size is not set there are no descriptors present */
> +	if (!ring->size)
> +		return;
> +
> +	dma_free_coherent(dev, ring->size, ring->desc, ring->dma);
> +	ring->size_mask = 0;
> +	ring->size = 0;
> +}
> +
> +static int mpnic_alloc_ring_desc(struct mpnic_net *mpn,
> +				 struct mpnic_ring *ring, u32 count)
> +{
> +	struct device *dev = mpn->netdev->dev.parent;
> +	size_t size;
> +
> +	size = ALIGN(array_size(sizeof(*ring->desc), count), 4096);
> +
> +	ring->desc = dma_alloc_coherent(dev, size, &ring->dma,
> +					GFP_KERNEL | __GFP_NOWARN);
> +	if (!ring->desc)
> +		return -ENOMEM;
> +
> +	ring->size_mask = count - 1;
> +	ring->size = size;
> +
> +	return 0;
> +}
> +
> +static void mpnic_free_tx_qt_resources(struct mpnic_net *mpn,
> +				       struct mpnic_q_triad *qt)
> +{
> +	struct device *dev = mpn->netdev->dev.parent;
> +
> +	mpnic_free_ring_resources(dev, &qt->cmpl);
> +	mpnic_free_ring_resources(dev, &qt->sub0);
> +}
> +
> +static int mpnic_alloc_tx_qt_resources(struct mpnic_net *mpn,
> +				       struct mpnic_q_triad *qt)
> +{
> +	int err;
> +
> +	err = mpnic_alloc_ring_desc(mpn, &qt->sub0, mpn->txq_size);
> +	if (err)
> +		return err;
> +
> +	qt->sub0.tx_buf = kvzalloc_objs(*qt->sub0.tx_buf, mpn->txq_size,
> +					GFP_KERNEL | __GFP_NOWARN);
> +	if (!qt->sub0.tx_buf) {
> +		err = -ENOMEM;
> +		goto err_free_qt;
> +	}
> +
> +	err = mpnic_alloc_ring_desc(mpn, &qt->cmpl, mpn->txq_size);
> +	if (err)
> +		goto err_free_qt;
> +
> +	return 0;
> +
> +err_free_qt:
> +	mpnic_free_tx_qt_resources(mpn, qt);
> +	return err;
> +}
> +
> +static void mpnic_free_nv_resources(struct mpnic_net *mpn,
> +				    struct mpnic_napi_vector *nv)
> +{
> +	int i;
> +
> +	for (i = 0; i < nv->txt_count; i++)
> +		mpnic_free_tx_qt_resources(mpn, &nv->qt[i]);
> +}
> +
> +static int mpnic_alloc_nv_resources(struct mpnic_net *mpn,
> +				    struct mpnic_napi_vector *nv)
> +{
> +	int i, err;
> +
> +	for (i = 0; i < nv->txt_count; i++) {
> +		err = mpnic_alloc_tx_qt_resources(mpn, &nv->qt[i]);
> +		if (err)
> +			goto err_free_qt_resources;
> +	}
> +
> +	return 0;
> +
> +err_free_qt_resources:
> +	while (i--)
> +		mpnic_free_tx_qt_resources(mpn, &nv->qt[i]);
> +	return err;
> +}
> +
> +void mpnic_free_resources(struct mpnic_net *mpn)
> +{
> +	int i;
> +
> +	for (i = 0; i < mpn->num_napi; i++)
> +		mpnic_free_nv_resources(mpn, mpn->napi[i]);
> +}
> +
> +int mpnic_alloc_resources(struct mpnic_net *mpn)
> +{
> +	int i, err;
> +
> +	for (i = 0; i < mpn->num_napi; i++) {
> +		err = mpnic_alloc_nv_resources(mpn, mpn->napi[i]);
> +		if (err)
> +			goto err_free_resources;
> +	}
> +
> +	return 0;
> +
> +err_free_resources:
> +	while (i--)
> +		mpnic_free_nv_resources(mpn, mpn->napi[i]);
> +
> +	return err;
> +}
> +
> +int mpnic_set_netif_queues(struct mpnic_net *mpn)
> +{
> +	int i, j, err;
> +
> +	err = netif_set_real_num_tx_queues(mpn->netdev, mpn->num_tx_queues);
> +	if (err)
> +		return err;
> +
> +	for (i = 0; i < mpn->num_napi; i++) {
> +		struct mpnic_napi_vector *nv = mpn->napi[i];
> +
> +		for (j = 0; j < nv->txt_count; j++)
> +			netif_queue_set_napi(mpn->netdev, nv->qt[j].sub0.q_idx,
> +					     NETDEV_QUEUE_TYPE_TX, &nv->napi);
> +	}
> +
> +	return 0;
> +}
> +
> +void mpnic_reset_netif_queues(struct mpnic_net *mpn)
> +{
> +	int i, j;
> +
> +	for (i = 0; i < mpn->num_napi; i++) {
> +		struct mpnic_napi_vector *nv = mpn->napi[i];
> +
> +		for (j = 0; j < nv->txt_count; j++)
> +			netif_queue_set_napi(mpn->netdev, nv->qt[j].sub0.q_idx,
> +					     NETDEV_QUEUE_TYPE_TX, NULL);
> +	}
> +}
> +
> +void mpnic_napi_disable(struct mpnic_net *mpn)
> +{
> +	int i;
> +
> +	for (i = 0; i < mpn->num_napi; i++) {
> +		napi_disable_locked(&mpn->napi[i]->napi);
> +
> +		mpnic_nv_irq_disable(mpn->napi[i]);
> +	}
> +}
> +
> +void mpnic_napi_enable(struct mpnic_net *mpn)
> +{
> +	int i;
> +
> +	for (i = 0; i < mpn->num_napi; i++)
> +		napi_enable_locked(&mpn->napi[i]->napi);
> +
> +	/* Force the first interrupt on each vector to guarantee that any
> +	 * completions posted during bringup are processed.
> +	 */
> +	for (i = 0; i < mpn->num_napi; i++)
> +		mpnic_nv_irq_trigger(mpn->napi[i]);
> +
> +	mpnic_wrfl(mpn->mpd);
> +}

[Severity: High]
Is hw_head used here without any check against what was actually
posted? It comes straight from the TCD read in mpnic_clean_tcq(), and
clean_desc is derived only from its distance to ring->head. It is never
compared with ring->tail.

The device could report a head beyond the last descriptor the driver
posted, for example through a firmware bug or a completion type that
mpnic_clean_tcq() does not decode. clean_desc then covers slots that
were never filled. tx_buf comes from kvzalloc_objs(), and only the
metadata slot of each packet holds an skb. So ring->tx_buf[head] is
NULL there, and MPNIC_XMIT_CB(skb)->desc_count dereferences a NULL
pointer from NAPI context.

Could clean_desc be clamped to the number of in-flight descriptors,
i.e. (ring->tail - head) & ring->size_mask? Alternatively, could the
loop bail out with a WARN_ON_ONCE() when it finds an empty tx_buf
slot? Ignoring a bogus completion seems preferable to taking the host
down.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260924-linux-mpnic-v2-0-4badc9b58b9e%40gmail.com
