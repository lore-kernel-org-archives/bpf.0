Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com [74.125.228.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 711FD4BE44E
	for <bpf@vger.kernel.org>; Mon, 28 Sep 2026 14:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790606801; cv=none; b=h+hpe83auzXinRVUpcGSMwzxOA+vX7ECMq/yEV2OPgFogYZJDruGxsAp8YpSVSSh89XLGdOMUs8e9ExtsLRuso3ndqzKRKNgfbwr2bIENmtg2VZG1B3ZMYOfQUBHljiCctQs1LVoCFWFo5Bzzb75bbNaVHB4ORyhttspVzLi7Sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790606801; c=relaxed/simple;
	bh=Mxdsegz/f6SfW/W1yVtNzPmYxPN1DuFg9BF5rq+BMVI=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=QXukgq/dKLX2yKOat9TPTpZ68LNSTflYhQ4Wuu3SEnuw28RELMWExC3460gCI2qwuUtQPywgg2h0kkRh34fC5LklQP9dL4xssIcPV4veAG/g8NXemIiWuuJD8asQAevb0N2kFTmMk7Xn+G3xRM0S4gHgmk1Co884De3S6+Jz71A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RLttq78j; arc=none smtp.client-ip=74.125.228.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RLttq78j"
Received: by mail-ej2-f12.google.com with SMTP id a640c23a62f3a-c264788fd58so452433066b.1
        for <bpf@vger.kernel.org>; Mon, 28 Sep 2026 07:46:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790606795; x=1791211595; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=+BzQWTZX6iqBr8XFpPdn+cC/M+GkFXRiq+JKGKUAH6k=;
        b=RLttq78jOWPm1N6+b7G/IA13FsDWGKrv5ASqkR+tpqcVhuEDrGlJLeHCR3Byv/q5CW
         hq+OZo0TXAtaC6d5DJYKwtv+KtubXot+kIPOFYyVYfXBynoCGlCqsMqyv3oeX54JCTV3
         sPbclve5SU0jyNBL7/egHH1txbIrzN0rASgpiaFEJ+PD33kxtrU4BHuOeLIL1/18arKj
         xyApZXRlCXsazeIAzRXzXdVEiyZtu3YKytwEGXT75Pf45WWYUEeGJUDYAh3KEcuzoGlH
         6rjORcNvAtnpb0xUo3nqrByJ5Pwo4vkGwwggz6t1ahzTLBaRFlACjFMWAbDit5DQeekX
         E9mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790606795; x=1791211595;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+BzQWTZX6iqBr8XFpPdn+cC/M+GkFXRiq+JKGKUAH6k=;
        b=roTbin9YZw+lUjysv7cq+j1fbfZWt1JO13LkexzTkAtwYHgvTlbXc8IDI+hFHBIK34
         nHeEY/rKxTXxiBxLgcMYUzm38mW1gOwpHcBrwxey1VOoiEPqel00smVyTLmdZ+RJcMsn
         F+DI9u1YxnKHuCOgX9ARkGDzdsdNcovMxKgL95cUx+PvDR7QbKYTFzTRBVI3uKrWxyQg
         kLwWhavpP7xhKde8/1UjKGSfFfxBOmooCZDZ3oikdOmQMgsBLChZIUiUW0mRShrk+2R4
         k2R35EvSItRQSs4PWsprmwvKoYkQeLwgXw4eY0Rq94bPrHvs/5OuKACTeSQK1aq9HJwF
         6d3g==
X-Forwarded-Encrypted: i=1; AKwUvBxzgKuoViQyBLAS8cv1mwg6gw+8zOeJ68csV9mvmPZRmlthsgqpa9kKJI7aMGz40MV11qU=@vger.kernel.org
X-Gm-Message-State: AFuF++kCPqG4H7QCo9VziqtpxZvZc5iI3JwTWdXitvBfs35141HJ8voo
	BFW79L6WmpukyUV3fQDKXCfp2IBlTUa7T4C8Q4BYW66tC8CRCEJlKT69
X-Gm-Gg: AYBFou3vX9oYWxkjrNR14pOsiClvWwQkn9GrG8nXPgrsOc4Mxp4lzpRiHIyanPVvy1F
	cumiInhr/jY6Z4DBWVwDlWCHagwW56YwpBgsCLe/H63erxm5tBoG78TIHOjiH1/OG9FbK2mmX7f
	ppxhtqPwV44+02bIdD0rJX2JymGW9oE5diafO9Y3V0wBFupLT5ZiscS4v1iKrUQFuSPzzOJrrDa
	7eFMaIBWC2ZrI6CFKXsXFYSI6vU3fc0Et7xL0dwYSG5uFvJZZCPNwzk87AA+yIiqTYBuXazi79D
	kcCny+BraQ5yr3ISdmqKIacvthChEA8xdWbafSp8ftBUH+3OsBmMXndcg3uECPUxNeVbJtvMfv+
	GLKiQ0qJyl6PF1Wm9FHsjeL3iZrO9DvFB+p/p/uXZvV+P/gP7LTnmHYbYk70fbriun6m6XMbpwI
	So8WPJmwxa2QJ7EsFc1PV/LmMBCeKW/O5hpPkPhzSp9OpeTFxaAuKa67SARl5YFRAaBlddBnejn
	1Q=
X-Received: by 2002:a17:907:c71b:b0:c24:e1e9:69c with SMTP id a640c23a62f3a-c2ae9347addmr774979466b.0.1790606795319;
        Mon, 28 Sep 2026 07:46:35 -0700 (PDT)
Received: from localhost ([2600:4040:9399:4000:e553:72e5:7d37:c7ef])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2b769429ddsm356642866b.51.2026.09.28.07.46.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Sep 2026 07:46:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 28 Sep 2026 10:46:31 -0400
Message-Id: <DLR14RY3N3LF.3J84UDH79H9PS@gmail.com>
Cc: <alexanderduyck@fb.com>, <kuba@kernel.org>, <kernel-team@meta.com>,
 <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
 <pabeni@redhat.com>, <ast@kernel.org>, <daniel@iogearbox.net>,
 <hawk@kernel.org>, <john.fastabend@gmail.com>, <sdf@fomichev.me>,
 <dimitri.daskalakis1@gmail.com>, <mohsin.bashr@gmail.com>,
 <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
 <bpf@vger.kernel.org>
Subject: Re: [PATCH net-next v2 4/8] eth: mpnic: implement Tx queue
 allocation and cleanup
From: "Daniel Zahka" <daniel.zahka@gmail.com>
To: <netdev-bot+sashiko@kernel.org>, <daniel.zahka@gmail.com>
X-Mailer: aerc 0.21.0-threadmapfix
References: <20260924-linux-mpnic-v2-4-4badc9b58b9e@gmail.com>
 <179055370187.3145.16714537922103048975@kernel.org>
In-Reply-To: <179055370187.3145.16714537922103048975@kernel.org>

On Sun Sep 27, 2026 at 8:01 PM EDT, netdev-bot+sashiko wrote:
> Thank you for your contribution! Sashiko AI review found 3 potential
> issue(s) to consider.
>
> Critical: 0 =C2=B7 High: 2 =C2=B7 Medium: 0 =C2=B7 Low: 1
>
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwor=
k
> know by including "pw-bot: cr" as a separate line at the end of your repl=
y
> (one such reply per series is enough).
>
> - [High] net: mpnic: missing bounds check on hardware completion head
>   causes NULL deref
> - [High] net: mpnic: integer underflow in desc_cnt causes massive out-of-
>   bounds unmaps
> - [Low] struct mpnic_ring::deferred_meta is documented as '-1 if the
>   doorbell is in sync with the tail', yet at this commit the rings come=
=E2=80=A6
>
> --
>
> eth: mpnic: implement Tx queue allocation and cleanup
>
> This adds the Tx ring structures and the per-NAPI-vector allocation of
> queue triads, descriptor memory and interrupts. It also adds completion
> processing, where a single completion reports a work queue head and can
> release many packets. The queues are not yet enabled in hardware.
>
>> diff --git a/drivers/net/ethernet/meta/mpnic/mpnic_txrx.c b/drivers/net/=
ethernet/meta/mpnic/mpnic_txrx.c
>> new file mode 100644
>> index 0000000000000..853976e11b032
>> --- /dev/null
>> +++ b/drivers/net/ethernet/meta/mpnic/mpnic_txrx.c
>> @@ -0,0 +1,495 @@
>
> [ ... ]
>
>> +static void mpnic_ring_init(struct mpnic_ring *ring, u32 __iomem *doorb=
ell,
>> +			    int q_idx)
>> +{
>> +	ring->doorbell =3D doorbell;
>> +	ring->q_idx =3D q_idx;
>> +}
>
> [Severity: Low]
> This isn't a bug at this point in the series, but the struct mpnic_ring
> comment in mpnic_txrx.h describes deferred_meta like this:
>
> 	/* TWQ only, index of the metadata descriptor of the last packet
> 	 * placed in the ring without ringing the doorbell, -1 if the
> 	 * doorbell is in sync with the tail.
> 	 */
> 	s32 deferred_meta;
>
> mpnic_alloc_napi_vector() gets the rings from kzalloc_flex(), and
> mpnic_ring_init() never sets deferred_meta. So the field starts at 0, not
> -1.
>
> Would it make sense to set deferred_meta to -1 in mpnic_ring_init(), so t=
he
> field matches its comment from the start?
>
> Nothing reads deferred_meta in this commit. The later patch "eth: mpnic:
> start and stop the Tx HW queues" adds mpnic_enable_twq(), which sets tail
> and head to 0 and deferred_meta to -1 on every enable. In mpnic_open()
> that runs before mpnic_napi_enable() and netif_tx_wake_all_queues(), so
> this only affects the intermediate state of the series.
>

Hmm, I guess the comment is slightly ahead of the implementation (next
patch)... I suppose introducing deferred_meta later would probably be
the solution, but to me that would be a bit out of place, given the
other ring fields are really initialized in that next patch.

> [ ... ]
>
>> @@ -0,0 +1,495 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/* Copyright (c) Meta Platforms, Inc. and affiliates. */
>> +
>> +#include <linux/bitfield.h>
>> +#include <linux/dma-mapping.h>
>> +#include <linux/pci.h>
>> +#include <linux/slab.h>
>> +
>> +#include "mpnic.h"
>> +#include "mpnic_netdev.h"
>> +#include "mpnic_txrx.h"
>> +
>> +struct mpnic_xmit_cb {
>> +	u32 bytecount;
>> +	u8 desc_count;
>> +};
>> +
>> +#define MPNIC_XMIT_CB(__skb) ((struct mpnic_xmit_cb *)((__skb)->cb))
>> +
>> +/* Leave the interrupt moderation counters alone when arming or masking=
 */
>> +#define MPNIC_TIM_PARAM_CFG_PRESERVE_MASK \
>> +	(MPNIC_TIM_CTL1_UPD_IGN_LONG_EVENT_CNT | \
>> +	 MPNIC_TIM_CTL1_UPD_IGN_LONG_TIME_CNT | \
>> +	 MPNIC_TIM_CTL1_UPD_IGN_SHORT_TIME_CNT)
>> +
>> +static void mpnic_nv_irq_disable(struct mpnic_napi_vector *nv)
>> +{
>> +	mpnic_wr64(nv->mpd, MPNIC_TIM_CTL1(nv->qt[0].cmpl.q_idx),
>> +		   MPNIC_TIM_PARAM_CFG_PRESERVE_MASK |
>> +		   MPNIC_TIM_CTL1_MASK_EN | MPNIC_TIM_CTL1_MASK);
>> +}
>> +
>> +static void mpnic_nv_irq_rearm(struct mpnic_napi_vector *nv)
>> +{
>> +	/* Rearming a single queue on a given IRQ rearms all the other
>> +	 * queues mapped to the same IRQ.
>> +	 */
>> +	mpnic_wr64(nv->mpd, MPNIC_TIM_CTL1(nv->qt[0].cmpl.q_idx),
>> +		   MPNIC_TIM_PARAM_CFG_PRESERVE_MASK | MPNIC_TIM_CTL1_MASK_EN);
>> +}
>> +
>> +static void mpnic_nv_irq_trigger(struct mpnic_napi_vector *nv)
>> +{
>> +	mpnic_wr64(nv->mpd, MPNIC_TIM_CTL1(nv->qt[0].cmpl.q_idx),
>> +		   MPNIC_TIM_PARAM_CFG_PRESERVE_MASK |
>> +		   MPNIC_TIM_CTL1_MASK_EN | MPNIC_TIM_CTL1_TRIGGER);
>> +}
>> +
>> +static unsigned int mpnic_desc_unused(struct mpnic_ring *ring)
>> +{
>> +	return (ring->head - ring->tail - 1) & ring->size_mask;
>> +}
>> +
>> +static struct netdev_queue *mpnic_txring_txq(const struct net_device *d=
ev,
>> +					     const struct mpnic_ring *ring)
>> +{
>> +	return netdev_get_tx_queue(dev, ring->q_idx);
>> +}
>> +
>> +static void mpnic_unmap_single_twd(struct device *dev, __le64 *twd)
>> +{
>> +	u64 raw_twd =3D le64_to_cpu(*twd);
>> +
>> +	dma_unmap_single(dev, FIELD_GET(MPNIC_TWD_ADDR, raw_twd),
>> +			 FIELD_GET(MPNIC_TWD_LEN, raw_twd), DMA_TO_DEVICE);
>> +}
>> +
>> +static void mpnic_unmap_page_twd(struct device *dev, __le64 *twd)
>> +{
>> +	u64 raw_twd =3D le64_to_cpu(*twd);
>> +
>> +	dma_unmap_page(dev, FIELD_GET(MPNIC_TWD_ADDR, raw_twd),
>> +		       FIELD_GET(MPNIC_TWD_LEN, raw_twd), DMA_TO_DEVICE);
>> +}
>> +
>> +static void mpnic_clean_twq0(struct mpnic_napi_vector *nv, int napi_bud=
get,
>> +			     struct mpnic_ring *ring, bool discard,
>> +			     unsigned int hw_head)
>> +{
>> +	u64 total_bytes =3D 0, total_packets =3D 0;
>> +	unsigned int head =3D ring->head;
>> +	struct netdev_queue *txq;
>> +	unsigned int clean_desc;
>> +
>> +	clean_desc =3D (hw_head - head) & ring->size_mask;
>> +
>> +	while (clean_desc) {
>> +		struct sk_buff *skb =3D ring->tx_buf[head];
>> +		unsigned int desc_cnt;
>> +
>> +		desc_cnt =3D MPNIC_XMIT_CB(skb)->desc_count;
>> +		if (desc_cnt > clean_desc)
>> +			break;
>> +
>> +		ring->tx_buf[head] =3D NULL;
>> +
>> +		clean_desc -=3D desc_cnt;
>> +
>> +		/* Step over the metadata descriptor */
>> +		head++;
>> +		head &=3D ring->size_mask;
>> +		desc_cnt--;
>> +
>> +		mpnic_unmap_single_twd(nv->dev, &ring->desc[head]);
>> +		head++;
>> +		head &=3D ring->size_mask;
>> +		desc_cnt--;
>> +
>> +		while (desc_cnt--) {
>
> [Severity: High]
> What happens here if desc_count is 0 or 1? desc_cnt is an unsigned
> int, and it is decremented twice unconditionally before the frag loop:
> once for the metadata descriptor and once for the head descriptor.
>
> With desc_count =3D=3D 0 the desc_cnt > clean_desc check passes and
> clean_desc is left unchanged. The second decrement then wraps desc_cnt
> around to UINT_MAX. The frag loop calls mpnic_unmap_page_twd() about
> four billion times, walking round and round the ring. Each call hands
> whatever address and length it finds to dma_unmap_page() from softirq
> context.
>
> With desc_count =3D=3D 1, mpnic_unmap_single_twd() is already applied to
> the following slot, which does not belong to this packet. The same
> wrap happens after that.
>
> desc_count lives in skb->cb and is only written by the xmit path added
> later in the series. This relies on every skb in tx_buf carrying a
> sane count. It also relies on hw_head never covering a packet whose
> descriptors are still being written. A device reporting a head that
> runs ahead of what was posted is enough to get here.
>
> Would it make sense to reject desc_cnt < 2 with a WARN_ON_ONCE()
> before stepping over the metadata descriptor? Possibly
> desc_cnt > MPNIC_MAX_SKB_DESC should be rejected as well.
>

Not reachable. We control the desc_count that is put into the control
block on xmit. We know that we allocate a primary metadata desc and at
least one dma mapped region for the skb head.

>> +			mpnic_unmap_page_twd(nv->dev, &ring->desc[head]);
>> +			head++;
>> +			head &=3D ring->size_mask;
>> +		}
>> +
>> +		total_bytes +=3D MPNIC_XMIT_CB(skb)->bytecount;
>> +		total_packets++;
>> +
>> +		napi_consume_skb(skb, napi_budget);
>> +	}
>> +
>> +	if (!total_bytes)
>> +		return;
>> +
>> +	ring->head =3D head;
>> +
>> +	if (discard)
>> +		return;
>> +
>> +	txq =3D mpnic_txring_txq(nv->napi.dev, ring);
>> +	netif_txq_completed_wake(txq, total_packets, total_bytes,
>> +				 mpnic_desc_unused(ring),
>> +				 MPNIC_TX_DESC_WAKEUP);
>> +}
>> +
>> +static void mpnic_commit_cq_head(struct mpnic_ring *cmpl)
>> +{
>> +	u32 head =3D cmpl->head;
>> +
>> +	/* The tail shadows the last value written to the doorbell, so a
>> +	 * completion queue which has not moved costs no MMIO write.
>> +	 */
>> +	if (cmpl->tail !=3D head) {
>> +		cmpl->tail =3D head;
>> +		writeq(head & cmpl->size_mask, cmpl->doorbell);
>> +	}
>> +}
>> +
>> +static void mpnic_clean_tcq(struct mpnic_napi_vector *nv,
>> +			    struct mpnic_q_triad *qt, int napi_budget)
>> +{
>> +	struct mpnic_ring *cmpl =3D &qt->cmpl;
>> +	__le64 *raw_tcd, done;
>> +	u32 head =3D cmpl->head;
>> +	s32 head0 =3D -1;
>> +
>> +	done =3D (head & (cmpl->size_mask + 1)) ? 0 : cpu_to_le64(MPNIC_TCD_DO=
NE);
>> +	raw_tcd =3D &cmpl->desc[head & cmpl->size_mask];
>> +
>> +	/* Walk the completion queue collecting the heads reported by NIC.
>> +	 * Only the first work queue is enabled and no packet asks for a
>> +	 * timestamp, so every completion is a plain head update and the
>> +	 * descriptor type does not have to be decoded.
>> +	 */
>> +	while ((*raw_tcd & cpu_to_le64(MPNIC_TCD_DONE)) =3D=3D done) {
>> +		u64 tcd;
>> +
>> +		dma_rmb();
>> +
>> +		tcd =3D le64_to_cpu(*raw_tcd);
>> +		head0 =3D FIELD_GET(MPNIC_TCD_TYPE0_HEAD0, tcd);
>> +
>> +		raw_tcd++;
>> +		head++;
>> +
>> +		if (unlikely(!(head & cmpl->size_mask))) {
>> +			done ^=3D cpu_to_le64(MPNIC_TCD_DONE);
>> +			raw_tcd =3D &cmpl->desc[0];
>> +		}
>> +	}
>> +
>> +	cmpl->head =3D head;
>> +
>> +	if (head0 >=3D 0)
>> +		mpnic_clean_twq0(nv, napi_budget, &qt->sub0, false, head0);
>> +}
>> +
>> +static int mpnic_poll(struct napi_struct *napi, int budget)
>> +{
>> +	struct mpnic_napi_vector *nv =3D container_of(napi,
>> +						    struct mpnic_napi_vector,
>> +						    napi);
>> +	int i;
>> +
>> +	for (i =3D 0; i < nv->txt_count; i++)
>> +		mpnic_clean_tcq(nv, &nv->qt[i], budget);
>> +
>> +	for (i =3D 0; i < nv->txt_count; i++)
>> +		mpnic_commit_cq_head(&nv->qt[i].cmpl);
>> +
>> +	if (likely(napi_complete_done(napi, 0)))
>> +		mpnic_nv_irq_rearm(nv);
>> +
>> +	return 0;
>> +}
>> +
>> +static irqreturn_t mpnic_msix_clean_rings(int __always_unused irq, void=
 *data)
>> +{
>> +	struct mpnic_napi_vector *nv =3D data;
>> +
>> +	napi_schedule_irqoff(&nv->napi);
>> +
>> +	return IRQ_HANDLED;
>> +}
>> +
>> +static void mpnic_free_napi_vector(struct mpnic_net *mpn,
>> +				   struct mpnic_napi_vector *nv)
>> +{
>> +	int i;
>> +
>> +	for (i =3D 0; i < nv->txt_count; i++)
>> +		mpn->tx[nv->qt[i].sub0.q_idx] =3D NULL;
>> +
>> +	mpnic_free_irq(nv->mpd, nv->v_idx, nv);
>> +	netif_napi_del_locked(&nv->napi);
>> +	mpn->napi[nv->v_idx - MPNIC_NON_NAPI_VECTORS] =3D NULL;
>> +	kfree(nv);
>> +}
>> +
>> +void mpnic_free_napi_vectors(struct mpnic_net *mpn)
>> +{
>> +	int i;
>> +
>> +	for (i =3D 0; i < mpn->num_napi; i++)
>> +		if (mpn->napi[i])
>> +			mpnic_free_napi_vector(mpn, mpn->napi[i]);
>> +}
>> +
>> +static void mpnic_ring_init(struct mpnic_ring *ring, u32 __iomem *doorb=
ell,
>> +			    int q_idx)
>> +{
>> +	ring->doorbell =3D doorbell;
>> +	ring->q_idx =3D q_idx;
>> +}
>> +
>> +static int mpnic_alloc_napi_vector(struct mpnic_dev *mpd,
>> +				   struct mpnic_net *mpn, unsigned int idx)
>> +{
>> +	u32 __iomem *uc_addr =3D READ_ONCE(mpd->uc_addr0);
>> +	struct mpnic_napi_vector *nv;
>> +	int err;
>> +
>> +	/* Doorbells are plain pointers into the register window, they have
>> +	 * no way of noticing that it went away.
>> +	 */
>> +	if (!uc_addr)
>> +		return -EIO;
>> +
>> +	nv =3D kzalloc_flex(*nv, qt, 1);
>> +	if (!nv)
>> +		return -ENOMEM;
>> +
>> +	nv->txt_count =3D 1;
>> +	nv->mpd =3D mpd;
>> +	nv->dev =3D mpd->dev;
>> +	nv->v_idx =3D idx + MPNIC_NON_NAPI_VECTORS;
>> +
>> +	mpn->napi[idx] =3D nv;
>> +	netif_napi_add_config_locked(mpn->netdev, &nv->napi, mpnic_poll, idx);
>> +	netif_napi_set_irq_locked(&nv->napi,
>> +				  pci_irq_vector(to_pci_dev(mpd->dev),
>> +						 nv->v_idx));
>> +
>> +	snprintf(nv->name, sizeof(nv->name), "%s-TxRx-%u",
>> +		 mpn->netdev->name, idx);
>> +
>> +	err =3D mpnic_request_irq(mpd, nv->v_idx, mpnic_msix_clean_rings, 0,
>> +				nv->name, nv);
>> +	if (err)
>> +		goto err_napi_del;
>> +
>> +	mpnic_ring_init(&nv->qt[0].sub0, &uc_addr[MPNIC_TWQ_TAIL(idx, 0)], idx=
);
>> +	mpnic_ring_init(&nv->qt[0].cmpl, &uc_addr[MPNIC_TCQ_HEAD(idx)], idx);
>> +	mpn->tx[idx] =3D &nv->qt[0].sub0;
>> +
>> +	return 0;
>> +
>> +err_napi_del:
>> +	netif_napi_del_locked(&nv->napi);
>> +	mpn->napi[idx] =3D NULL;
>> +	kfree(nv);
>> +	return err;
>> +}
>> +
>> +int mpnic_alloc_napi_vectors(struct mpnic_net *mpn)
>> +{
>> +	unsigned int i;
>> +	int err;
>> +
>> +	for (i =3D 0; i < mpn->num_napi; i++) {
>> +		err =3D mpnic_alloc_napi_vector(mpn->mpd, mpn, i);
>> +		if (err)
>> +			goto err_free_vectors;
>> +	}
>> +
>> +	return 0;
>> +
>> +err_free_vectors:
>> +	mpnic_free_napi_vectors(mpn);
>> +
>> +	return err;
>> +}
>> +
>> +static void mpnic_free_ring_resources(struct device *dev,
>> +				      struct mpnic_ring *ring)
>> +{
>> +	kvfree(ring->tx_buf);
>> +	ring->tx_buf =3D NULL;
>> +
>> +	/* If size is not set there are no descriptors present */
>> +	if (!ring->size)
>> +		return;
>> +
>> +	dma_free_coherent(dev, ring->size, ring->desc, ring->dma);
>> +	ring->size_mask =3D 0;
>> +	ring->size =3D 0;
>> +}
>> +
>> +static int mpnic_alloc_ring_desc(struct mpnic_net *mpn,
>> +				 struct mpnic_ring *ring, u32 count)
>> +{
>> +	struct device *dev =3D mpn->netdev->dev.parent;
>> +	size_t size;
>> +
>> +	size =3D ALIGN(array_size(sizeof(*ring->desc), count), 4096);
>> +
>> +	ring->desc =3D dma_alloc_coherent(dev, size, &ring->dma,
>> +					GFP_KERNEL | __GFP_NOWARN);
>> +	if (!ring->desc)
>> +		return -ENOMEM;
>> +
>> +	ring->size_mask =3D count - 1;
>> +	ring->size =3D size;
>> +
>> +	return 0;
>> +}
>> +
>> +static void mpnic_free_tx_qt_resources(struct mpnic_net *mpn,
>> +				       struct mpnic_q_triad *qt)
>> +{
>> +	struct device *dev =3D mpn->netdev->dev.parent;
>> +
>> +	mpnic_free_ring_resources(dev, &qt->cmpl);
>> +	mpnic_free_ring_resources(dev, &qt->sub0);
>> +}
>> +
>> +static int mpnic_alloc_tx_qt_resources(struct mpnic_net *mpn,
>> +				       struct mpnic_q_triad *qt)
>> +{
>> +	int err;
>> +
>> +	err =3D mpnic_alloc_ring_desc(mpn, &qt->sub0, mpn->txq_size);
>> +	if (err)
>> +		return err;
>> +
>> +	qt->sub0.tx_buf =3D kvzalloc_objs(*qt->sub0.tx_buf, mpn->txq_size,
>> +					GFP_KERNEL | __GFP_NOWARN);
>> +	if (!qt->sub0.tx_buf) {
>> +		err =3D -ENOMEM;
>> +		goto err_free_qt;
>> +	}
>> +
>> +	err =3D mpnic_alloc_ring_desc(mpn, &qt->cmpl, mpn->txq_size);
>> +	if (err)
>> +		goto err_free_qt;
>> +
>> +	return 0;
>> +
>> +err_free_qt:
>> +	mpnic_free_tx_qt_resources(mpn, qt);
>> +	return err;
>> +}
>> +
>> +static void mpnic_free_nv_resources(struct mpnic_net *mpn,
>> +				    struct mpnic_napi_vector *nv)
>> +{
>> +	int i;
>> +
>> +	for (i =3D 0; i < nv->txt_count; i++)
>> +		mpnic_free_tx_qt_resources(mpn, &nv->qt[i]);
>> +}
>> +
>> +static int mpnic_alloc_nv_resources(struct mpnic_net *mpn,
>> +				    struct mpnic_napi_vector *nv)
>> +{
>> +	int i, err;
>> +
>> +	for (i =3D 0; i < nv->txt_count; i++) {
>> +		err =3D mpnic_alloc_tx_qt_resources(mpn, &nv->qt[i]);
>> +		if (err)
>> +			goto err_free_qt_resources;
>> +	}
>> +
>> +	return 0;
>> +
>> +err_free_qt_resources:
>> +	while (i--)
>> +		mpnic_free_tx_qt_resources(mpn, &nv->qt[i]);
>> +	return err;
>> +}
>> +
>> +void mpnic_free_resources(struct mpnic_net *mpn)
>> +{
>> +	int i;
>> +
>> +	for (i =3D 0; i < mpn->num_napi; i++)
>> +		mpnic_free_nv_resources(mpn, mpn->napi[i]);
>> +}
>> +
>> +int mpnic_alloc_resources(struct mpnic_net *mpn)
>> +{
>> +	int i, err;
>> +
>> +	for (i =3D 0; i < mpn->num_napi; i++) {
>> +		err =3D mpnic_alloc_nv_resources(mpn, mpn->napi[i]);
>> +		if (err)
>> +			goto err_free_resources;
>> +	}
>> +
>> +	return 0;
>> +
>> +err_free_resources:
>> +	while (i--)
>> +		mpnic_free_nv_resources(mpn, mpn->napi[i]);
>> +
>> +	return err;
>> +}
>> +
>> +int mpnic_set_netif_queues(struct mpnic_net *mpn)
>> +{
>> +	int i, j, err;
>> +
>> +	err =3D netif_set_real_num_tx_queues(mpn->netdev, mpn->num_tx_queues);
>> +	if (err)
>> +		return err;
>> +
>> +	for (i =3D 0; i < mpn->num_napi; i++) {
>> +		struct mpnic_napi_vector *nv =3D mpn->napi[i];
>> +
>> +		for (j =3D 0; j < nv->txt_count; j++)
>> +			netif_queue_set_napi(mpn->netdev, nv->qt[j].sub0.q_idx,
>> +					     NETDEV_QUEUE_TYPE_TX, &nv->napi);
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +void mpnic_reset_netif_queues(struct mpnic_net *mpn)
>> +{
>> +	int i, j;
>> +
>> +	for (i =3D 0; i < mpn->num_napi; i++) {
>> +		struct mpnic_napi_vector *nv =3D mpn->napi[i];
>> +
>> +		for (j =3D 0; j < nv->txt_count; j++)
>> +			netif_queue_set_napi(mpn->netdev, nv->qt[j].sub0.q_idx,
>> +					     NETDEV_QUEUE_TYPE_TX, NULL);
>> +	}
>> +}
>> +
>> +void mpnic_napi_disable(struct mpnic_net *mpn)
>> +{
>> +	int i;
>> +
>> +	for (i =3D 0; i < mpn->num_napi; i++) {
>> +		napi_disable_locked(&mpn->napi[i]->napi);
>> +
>> +		mpnic_nv_irq_disable(mpn->napi[i]);
>> +	}
>> +}
>> +
>> +void mpnic_napi_enable(struct mpnic_net *mpn)
>> +{
>> +	int i;
>> +
>> +	for (i =3D 0; i < mpn->num_napi; i++)
>> +		napi_enable_locked(&mpn->napi[i]->napi);
>> +
>> +	/* Force the first interrupt on each vector to guarantee that any
>> +	 * completions posted during bringup are processed.
>> +	 */
>> +	for (i =3D 0; i < mpn->num_napi; i++)
>> +		mpnic_nv_irq_trigger(mpn->napi[i]);
>> +
>> +	mpnic_wrfl(mpn->mpd);
>> +}
>
> [Severity: High]
> Is hw_head used here without any check against what was actually
> posted? It comes straight from the TCD read in mpnic_clean_tcq(), and
> clean_desc is derived only from its distance to ring->head. It is never
> compared with ring->tail.
>
> The device could report a head beyond the last descriptor the driver
> posted, for example through a firmware bug or a completion type that
> mpnic_clean_tcq() does not decode. clean_desc then covers slots that
> were never filled. tx_buf comes from kvzalloc_objs(), and only the
> metadata slot of each packet holds an skb. So ring->tx_buf[head] is
> NULL there, and MPNIC_XMIT_CB(skb)->desc_count dereferences a NULL
> pointer from NAPI context.
>
> Could clean_desc be clamped to the number of in-flight descriptors,
> i.e. (ring->tail - head) & ring->size_mask? Alternatively, could the
> loop bail out with a WARN_ON_ONCE() when it finds an empty tx_buf
> slot? Ignoring a bogus completion seems preferable to taking the host
> down.

We trust the device to fill out this completion field correctly.
