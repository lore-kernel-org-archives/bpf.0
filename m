Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 154F91A9FBA
	for <bpf@vger.kernel.org>; Sat,  8 Aug 2026 08:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786179412; cv=none; b=hgl7zPPdniMy2Jc4OBCdu7bsv0EAG+QZYHbZiHLu5caUyfr741gg6gYewGL/sdnMv1bxpQ52i3lkv84cGr88XPNebnwsvIx6unq+88OEUlM+VXPEyDslnzTyAK3YU6oUjLN3IAxoy+cwccit/plxA8461xgJCJJd17SOsOi8Zi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786179412; c=relaxed/simple;
	bh=NRtfBuzt+mXeik74mMBt42I7Y4cyhLLfAWAKpQGkBwE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=KXNiGozACAGSX1F1/k0KXoU2Tk2tsvTP5O/J2/tztUZONewCmttZZ11jM5gwzX51wmeBdtPBBjy5RYAZ22DGhttRm3tFD8x2Rc6eNDqzVhW7Mzmoc33fZTfWcmYPPl+ncljLGz9zbHFH5LlgGCGFuGPuodn4T6cO5b+EibFbkOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sn21WY0z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sn21WY0z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 833651F000E9;
	Sat,  8 Aug 2026 08:56:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786179410;
	bh=OPYDE4XGFNbDYR03dMO9NJEkP15AmUFNIzRANvwsjkI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Sn21WY0zB8FugK5XNd0HmtUuqequlOk74zcFlTCQ9VWow3Pl4koq398Dh6wjsIQpr
	 S5c5x4XlyG1ZzTJJBCA79ItU/CGj/XZHk5w39vZdOTXlK3eeGdrBjEXS0qa/7Hy3m2
	 BRQ3e8P45rdPXK0DT3lmRgEHRqABoloHpHVAjnzRa0wAam38SRLbBqgdEKv+8/pd/n
	 dSuWdqvTIlcxz45M1OextEdJdS7tTtN/a9oWPyWHH7dptUd6VtNizpvvK1wRrUo+gf
	 ARgXz9smY4tzG56nb7dbA22ELSVZAr2bAwRAtMYgRwngo1vkSjVyWMupF2T+zRJYJJ
	 WifT8RJZBLtNQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v3] net: atlantic: convert RX path to page_pool
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yangyu Chen" <cyy@cyyself.name>
Cc: bpf@vger.kernel.org
In-Reply-To: <tencent_F771B81731B921458D6F7CBF82ECDA888E08@qq.com>
References: <tencent_F771B81731B921458D6F7CBF82ECDA888E08@qq.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 08 Aug 2026 08:56:49 +0000
Message-Id: <20260808085650.833651F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 6 potential issue(=
s) to consider:

New issues:
- [High] Missing `dma_sync_single_for_device` on locally recycled RX buffer=
s.

Pre-existing issues:
- [Critical] Kernel crash when `XDP_TX` is returned for a packet on the PTP=
 RX ring due to a missing PTP TX ring mapping.
- [Critical] Garbage packet injection and state machine desynchronization w=
hen an XDP packet exceeds the MAX_SKB_FRAGS limit.
- [High] Infinite NAPI polling loop when receiving an oversized packet.
- [High] Concurrent execution of `u64_stats_update_begin` on `tx.syncp` cor=
rupts seqcount.
- [High] Lockless concurrent access to TX ring descriptors in `aq_xdp_xmit`.
--

--- Patch [1]: [PATCH net-next v3] net: atlantic: convert RX path to page_p=
ool ---
commit 6897c00e6a396ede4252845d65592374630adc51
Author: Yangyu Chen <cyy@cyyself.name>

net: atlantic: convert RX path to page_pool

The driver is converted to use page_pool fragments for RX buffers instead of
dev_alloc_pages() and a hand-rolled page-flip scheme. The PTP RX ring's
xdp_rxq is also registered to use the MEM_TYPE_PAGE_POOL memory model.

Link: https://lore.kernel.org/lkml/tencent_1F173E0FC1606D2AC704DC9C98AF1098=
4607@qq.com/
Link: https://lore.kernel.org/lkml/tencent_7DB01BE7F8FA056BB5F11D3570CF636C=
4309@qq.com/

> diff --git a/drivers/net/ethernet/aquantia/atlantic/aq_ptp.c b/drivers/ne=
t/ethernet/aquantia/atlantic/aq_ptp.c
> index 558ac9237f759..3a40d986cd678 100644
> --- a/drivers/net/ethernet/aquantia/atlantic/aq_ptp.c
> +++ b/drivers/net/ethernet/aquantia/atlantic/aq_ptp.c
> @@ -1192,12 +1193,23 @@ int aq_ptp_ring_alloc(struct aq_nic_s *aq_nic)
>  	if (err)
>  		goto err_exit_ptp_tx;
> =20

[Severity: Critical]
This is a pre-existing issue, but could this cause a kernel panic from a
NULL pointer dereference? In aq_ptp_ring_alloc(), the PTP TX ring is
allocated but not registered in the global aq_nic->aq_ring_tx array:

aq_ptp_ring_alloc()
    err =3D aq_ring_tx_alloc(&aq_ptp->ptp_tx, aq_nic, ...);

If an XDP program is attached and returns XDP_TX for a packet received on
the PTP RX ring, the tx_ring lookup evaluates to NULL:

aq_xdp_run_prog()
    tx_ring =3D aq_nic->aq_ring_tx[rx_ring->idx];
    result =3D aq_nic_xmit_xdpf(aq_nic, tx_ring, xdpf);

> +	err =3D xdp_rxq_info_reg(&aq_ptp->ptp_rx.xdp_rxq, aq_nic->ndev,
> +			       rx_ring_idx, aq_ptp->napi.napi_id);
[ ... ]
> diff --git a/drivers/net/ethernet/aquantia/atlantic/aq_ring.c b/drivers/n=
et/ethernet/aquantia/atlantic/aq_ring.c
> index e1193c6719d9d..9dd8817105942 100644
> --- a/drivers/net/ethernet/aquantia/atlantic/aq_ring.c
> +++ b/drivers/net/ethernet/aquantia/atlantic/aq_ring.c
> @@ -14,120 +14,37 @@
> -static int aq_get_rxpages(struct aq_ring_s *self, struct aq_ring_buff_s =
*rxbuf)
> +static int aq_get_rxpages(struct aq_ring_s *self, struct aq_ring_buff_s =
*rxbuf)
>  {
> -	unsigned int order =3D self->page_order;
[ ... ]
> +	unsigned int size =3D self->page_offset + self->frame_max +
> +			    self->tail_size;
> +	unsigned int pg_off;
>  	struct page *page;
> =20
> -	if (rxbuf->rxdata.page) {
[ ... ]
> +	/* Buffers whose page was not passed up the stack are reposted
> +	 * with the data they already carry discarded.
> +	 */
> +	if (rxbuf->rxdata.page)
> +		return 0;

[Severity: High]
Are we missing a dma_sync_single_for_device() call for the locally
recycled buffer?

When a packet is smaller than the header copy threshold, its payload is
copied to a newly allocated SKB and its page is recycled directly. The CPU
reads the data after a dma_sync_single_range_for_cpu() call, but when the
page is passed back to the hardware, the lack of
dma_sync_single_for_device() might allow the CPU cache to overwrite DMA
memory while the NIC writes the next packet.

> +	page =3D page_pool_dev_alloc_frag(self->pg_pool, &pg_off, size);
[ ... ]
> @@ -346,7 +284,11 @@ bool aq_ring_tx_clean(struct aq_ring_s *self)
>  			++self->stats.tx.packets;
>  			self->stats.tx.bytes +=3D xdp_get_frame_len(buff->xdpf);
>  			u64_stats_update_end(&self->stats.tx.syncp);
> -			xdp_return_frame_rx_napi(buff->xdpf);
> +			/* Frames queued via ndo_xdp_xmit() may come from a

[Severity: High]
This is a pre-existing issue, but might this lead to a corrupted seqcount
and infinite loops for readers on 32-bit systems?

Writers to a u64_stats_sync block must be mutually exclusive and disable
preemption. However, this code updates tx.syncp locklessly from the NAPI
poll context in aq_ring_tx_clean():

aq_ring_tx_clean()
    if (buff->skb) {
        u64_stats_update_begin(&self->stats.tx.syncp);

While aq_ptp_xmit() updates the exact same syncp block holding a spinlock
in process or softirq context:

aq_ptp_xmit()
    spin_lock_irqsave(&aq_nic->aq_ptp->ptp_ring_lock, irq_flags);
    ...
    u64_stats_update_begin(&ring->stats.tx.syncp);

> +			 * page pool owned by another NAPI context: no direct
> +			 * recycling.
> +			 */
> +			xdp_return_frame(buff->xdpf);
>  		}
> =20
>  out:
[ ... ]
> @@ -437,22 +379,15 @@ int aq_xdp_xmit(struct net_device *dev, int num_fra=
mes,
>  }

[Severity: High]
This is a pre-existing issue, but could this cause lockless concurrent
access to TX ring descriptors?

If the number of online CPUs exceeds the number of hardware queues, multiple
CPUs will map to the same ring and invoke aq_nic_xmit_xdpf() simultaneously
without any locks:

aq_xdp_xmit()
    vec =3D cpu % aq_cfg->vecs;
    ring =3D aq_nic->aq_ring_tx[AQ_NIC_CFG_TCVEC2RING(aq_cfg, 0, vec)];
    for (i =3D 0; i < num_frames; i++) {
        ...
        if (aq_nic_xmit_xdpf(aq_nic, ring, xdpf) =3D=3D NETDEV_TX_BUSY)

> =20
>  static struct sk_buff *aq_xdp_build_skb(struct xdp_buff *xdp,
> -					struct net_device *dev,
> -					struct aq_ring_buff_s *buff)
[ ... ]
> @@ -546,8 +489,11 @@ static bool aq_add_rx_fragment(struct device *dev,
>  	do {
>  		skb_frag_t *frag;
> =20
> -		if (unlikely(sinfo->nr_frags >=3D MAX_SKB_FRAGS))
> +		if (unlikely(sinfo->nr_frags >=3D MAX_SKB_FRAGS)) {
> +			/* Attached frags must reach xdp_return_buff() */
> +			xdp_buff_set_frags_flag(xdp);
>  			return true;
> +		}
> =20
>  		frag =3D &sinfo->frags[sinfo->nr_frags++];
>  		buff_ =3D &ring->buff_ring[buff_->next];

[Severity: Critical]
This is a pre-existing issue, but does this abandon trailing fragments
without marking them as cleaned?

When a packet exceeds MAX_SKB_FRAGS, aq_add_rx_fragment() returns true
early:

aq_add_rx_fragment()
    if (unlikely(sinfo->nr_frags >=3D MAX_SKB_FRAGS)) {
        ...
        return true;
    }

Then __aq_ring_xdp_clean() skips further processing of those fragments:

__aq_ring_xdp_clean()
    if (!buff->is_eop) {
        if (aq_add_rx_fragment(dev, rx_ring, buff, &xdp)) {
            ...
            xdp_return_buff(&xdp);
            continue;
        }
    }

The uncleaned hardware descriptors are left behind. On the next loop
iteration, the driver will treat these uncleaned payload fragments as the
start of a completely new packet, potentially injecting garbage or bypassing
header checks.

> @@ -674,6 +625,7 @@ static int __aq_ring_rx_clean(struct aq_ring_s *self,=
 struct napi_struct *napi,
>  			err =3D -ENOMEM;
>  			goto err_exit;
>  		}
> +		skb_mark_for_recycle(skb);

[Severity: High]
This is a pre-existing issue, but can this create an infinite NAPI polling
loop when receiving an oversized packet?

In __aq_ring_rx_clean(), when a packet spanning more than MAX_SKB_FRAGS is
received:

__aq_ring_rx_clean()
    if (unlikely(!is_rsc_completed) ||
        frag_cnt > MAX_SKB_FRAGS) {
        err =3D 0;
        goto err_exit;
    }

The error handler jumps to err_exit without advancing self->sw_head. This
would trap the driver into processing the exact same failing packet
continuously on every poll iteration, leading to a denial of service for
the affected RX queue.

>  		if (is_ptp_ring)
>  			buff->len -=3D
>  				aq_ptp_extract_ts(self->aq_nic, skb_hwtstamps(skb),

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/tencent_F771B81731B=
921458D6F7CBF82ECDA888E08@qq.com?part=3D1
