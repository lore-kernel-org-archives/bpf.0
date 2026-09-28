Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A903440655;
	Mon, 28 Sep 2026 00:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790553717; cv=none; b=Br/oLVio3GXTT+BN1JVmAGVr+GFjE6Ic9fz2UnOzLvUV03cuSRsQkZGo9fHDwMZt1d7JctGkR9V+O4891Rsjbl5H1Fnhstj5SNqE/iqTtrtJUBI7ca2cdUj020HS2LOE7cehEmywhIJOLlqVAYjq5wZ24iHU0bAXrTZzHY5q0xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790553717; c=relaxed/simple;
	bh=2h0tflcmwnYpCOw/vbGnneBRJd6jEAnLgMup0fdJs2I=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=g7IMrZsFXHNrGt7wYWVHhcquxuTUe2zDk/sS75TD9rV2/wHG+WSP7qelS/7b1XIUWs/FK7NlnUpQs0SzaEIY6HbVXEDUJrmx6GSHq5jfN/MgkP8iaeblXneSybmIsH+C9dVe7BdyitI0+6w7NuMUZ7ksfD0Oj3gWFfBmyfLzx+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cF0Kpb9/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cF0Kpb9/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC08F1F0089D;
	Mon, 28 Sep 2026 00:01:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790553709;
	bh=8HvkItHrjkvkLU4V8IA1lneV5KPSLS/NbyYtngKNnhU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=cF0Kpb9/NeZmQlOGIIf3UHUK0USLXl4kc5rQF5qW9FriwBfr+EPe97YsOWPD+tpWT
	 GtncYrBSsOUyrrBxjycUWlmE05y6EW4zzmDIWkegip2PcXLQWVFi23xRJUGAwH2mEM
	 9ExE8fafzV1PApTTfest6nIGVqxIbNeNkmXNw9hXXUWXgGdOwS1AQobRrf5xQRb3ct
	 iFnE+EVleawAVVtXCIVo0GB11s5dx5UrEql9e/ATpF9nYkALQE94VMLW4yI94I484I
	 iH7Rt/YKcbAmAvFj2n7XGoNR1ZpfDfzsHkw1r7Rok4WIzJsqZC7hYnN2W5Ser4kFHk
	 gIuC9omqPnEqw==
Subject: Re: [PATCH net-next v2 8/8] eth: mpnic: add basic Rx handling
From: netdev-bot+sashiko@kernel.org
To: daniel.zahka@gmail.com
Cc: alexanderduyck@fb.com, kuba@kernel.org, kernel-team@meta.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
 john.fastabend@gmail.com, sdf@fomichev.me, dimitri.daskalakis1@gmail.com,
 mohsin.bashr@gmail.com, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 bpf@vger.kernel.org
Date: Mon, 28 Sep 2026 00:01:48 +0000
Message-ID: <179055370821.3145.15563353156431464401@kernel.org>
In-Reply-To: <20260924-linux-mpnic-v2-8-4badc9b58b9e@gmail.com>
References: <20260924-linux-mpnic-v2-8-4badc9b58b9e@gmail.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 4 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 4 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] Rx buffer queues can starve for good after a page allocation
  failure.
- [Medium] mpnic_clean_rcq() never checks that a frame is in progress
  before handling a descriptor.
- [Medium] mpnic_page_pool_get() indexes ring->rx_buf[idx] with the raw
  18-bit MPNIC_RCD_AL_BUFF_ID from the completion descriptor (up to…
- [Medium] The descriptor fields BUFF_OFF (16 bits) and BUFF_LEN (14
  bits) are used without range checks to build the skb head, frame_sz,…

--

eth: mpnic: add basic Rx handling

This commit adds Rx completion processing to the mpnic driver. Each frame
is built in an xdp_buff from three kinds of descriptor: a header
descriptor, one payload descriptor per page and a closing metadata
descriptor. The frame is then passed to GRO, and pages are shared between
frames using a batched page_pool reference bias.

> diff --git a/drivers/net/ethernet/meta/mpnic/mpnic_txrx.c b/drivers/net/ethernet/meta/mpnic/mpnic_txrx.c
> index 389a9e5476c6e..edb07b7f334bd 100644
> --- a/drivers/net/ethernet/meta/mpnic/mpnic_txrx.c
> +++ b/drivers/net/ethernet/meta/mpnic/mpnic_txrx.c
> @@ -405,6 +405,34 @@ static void mpnic_fill_qt_bdqs(struct mpnic_q_triad *qt)

[ ... ]

> +static struct page *
> +mpnic_page_pool_get(struct mpnic_pg_ctxt *pg_ctxt, struct mpnic_ring *ring,
> +		    u32 idx)
> +{
> +	struct page *page = pg_ctxt->page;
> +
> +	if (unlikely(pg_ctxt->idx != idx)) {
> +		if (pg_ctxt->pagecnt_bias &&
> +		    !page_pool_unref_page(page, pg_ctxt->pagecnt_bias))
> +			page_pool_put_unrefed_page(page->pp, page, -1, true);
> +
> +		page = ring->rx_buf[idx];
> +		page_pool_fragment_page(page, MPNIC_PAGECNT_BIAS_MAX);

[Severity: Medium]
Here idx is the raw MPNIC_RCD_AL_BUFF_ID field from the completion
descriptor. mpnic_pkt_prepare() and mpnic_add_rx_frag() pass it through
unchanged. The field is 18 bits wide (up to 262143), but rx_buf[] only
has hpq_size/ppq_size entries (256 by default).

Could a bad buffer ID from the device read past the end of rx_buf[]?
page_pool_fragment_page() would then write pp_ref_count through
whatever pointer it found there.

An in-range ID for a slot the device already completed seems like it
would also reset the refcount of a page that in-flight skbs still own.

mpnic_bd_prep() only posts IDs in [0, size_mask], so this needs a faulty
or misbehaving device. Would it be worth masking idx with
ring->size_mask, or rejecting IDs that are out of range?

[ ... ]

> @@ -417,6 +445,87 @@ static void mpnic_flush_pg_ctxt(struct mpnic_pg_ctxt *ctxt, bool napi)
>  	}
>  }
>  
> +static unsigned int mpnic_hdr_pg_start(unsigned int pg_off)
> +{

[ ... ]

> +	if (ALIGN(MPNIC_RX_HROOM, 128) > MPNIC_RX_HROOM &&
> +	    pg_off == ALIGN(MPNIC_RX_HROOM, 128))
> +		return 0;
> +
> +	return pg_off - MPNIC_RX_HROOM;
> +}

[Severity: Medium]
If the device reports a BUFF_OFF smaller than MPNIC_RX_HROOM, does this
unsigned subtraction wrap around and produce a huge pg_start?

The BUFF_OFF (16 bits) and BUFF_LEN (14 bits) fields are used without
range checks in a few other places:

- mpnic_hdr_pg_end() can return values well beyond PAGE_SIZE. These
  feed frame_sz in mpnic_pkt_prepare(), which decides where
  skb_shared_info is written.

- With fin set and pg_off larger than page_size(page), frame_sz in
  mpnic_pkt_prepare() and truesz in mpnic_add_rx_frag() both underflow.

- In mpnic_add_rx_frag(), a payload frag with pg_off + len past
  page_size(page) would expose adjacent memory to the stack.

The same values also set the page_pool_dma_sync_for_cpu() ranges.

A device that follows the configured HROOM/TROOM/MAX_HEADER_BYTES layout
should not produce these values. Would a sanity check against
page_size(page) still be worth adding?

[ ... ]

> @@ -442,23 +551,99 @@ static void mpnic_put_pkt_buff(struct mpnic_pkt_ctxt *ctxt, bool napi)
>  	page_pool_put_full_page(page->pp, page, napi);
>  }
>  
> +static int mpnic_clean_rcq(struct mpnic_napi_vector *nv,
> +			   struct mpnic_q_triad *qt, int budget)
> +{

[ ... ]

> +		switch (FIELD_GET(MPNIC_RCD_TYPE, rcd)) {
> +		case MPNIC_RCD_TYPE_HDR_AL:
> +			if (FIELD_GET(MPNIC_RCD_HDR_SUBTYPE, rcd) ==
> +			    MPNIC_RCD_HDR_SUBTYPE_HDR)
> +				mpnic_pkt_prepare(rcd, state, qt);
> +			break;
> +		case MPNIC_RCD_TYPE_PAY_AL:
> +			mpnic_add_rx_frag(rcd, state, qt);
> +			break;
> +		case MPNIC_RCD_TYPE_META: {
> +			struct sk_buff *skb = NULL;
> +
> +			if (likely(!(rcd &
> +				     MPNIC_RCD_META_UNCORRECTABLE_ERR_MASK) &&
> +				   !state->pkt.add_frag_failed))
> +				skb = xdp_build_skb_from_buff(&state->pkt.buff);
> +
> +			if (likely(skb))
> +				napi_gro_receive(&nv->napi, skb);
> +			else
> +				mpnic_put_pkt_buff(&state->pkt, true);
> +
> +			state->pkt.buff.data_hard_start = NULL;

[Severity: Medium]
Nothing checks that a frame is in progress before a PAY_AL or META
descriptor is handled. state->pkt.buff.data_hard_start is zero at
start and is set back to NULL after every META.

Suppose a PAY_AL arrives without a preceding HDR descriptor.
mpnic_add_rx_frag() then calls xdp_buff_add_frag(), which writes to
skb_shared_info at an address based on a NULL data_hard_start and a
stale frame_sz.

A META in the same state would take the success branch:

mpnic_clean_rcq()
  xdp_build_skb_from_buff()
    napi_build_skb(NULL, frame_sz)

Only the error path, mpnic_put_pkt_buff(), checks data_hard_start.

Can either of these cause a NULL pointer dereference in NAPI context?

HDR_AL descriptors whose subtype is not MPNIC_RCD_HDR_SUBTYPE_HDR are
skipped silently, so a frame that starts that way would hit the same
path.

The opposite case is also possible. mpnic_pkt_prepare() overwrites
state->pkt.buff without releasing the page_pool references of an
unfinished frame. Could that leak pages and stall page_pool_destroy()?

fbnic_pkt_prepare() has a WARN_ON_ONCE(xdp->data_hard_start) at this
point, and mpnic_pkt_prepare() drops it. Would it make sense to keep it?

All of this needs the device to break the HDR, PAY_AL*, META ordering.

[ ... ]

> +	rcq->head = head;
> +
> +	/* Allocate buffers, force dma_wmb(), and then start writing tails */
> +	mpnic_fill_qt_bdqs(qt);
> +
> +	return packets;
> +}
> +
>  static int mpnic_poll(struct napi_struct *napi, int budget)
>  {

[ ... ]

> -	if (likely(napi_complete_done(napi, 0)))
> +	if (work_done >= budget)
> +		return budget;
> +
> +	if (likely(napi_complete_done(napi, work_done)))
>  		mpnic_nv_irq_rearm(nv);

[Severity: Medium]
mpnic_clean_rcq() is the only runtime caller of mpnic_fill_qt_bdqs().
__mpnic_fill_bdq() simply stops when the page pool allocation fails:

		page = page_pool_dev_alloc_pages(bdq->page_pool);
		if (!page)
			break;

The shortfall is never reported back, because mpnic_clean_rcq() only
returns the packet count. mpnic_poll() then completes NAPI and re-arms
the IRQ anyway.

Say the allocation fails while the device has no posted buffers left,
or fewer than the 16-descriptor HPQ/PPQ drop threshold. The device then
drops incoming frames without writing any RCQ completions. What would
schedule NAPI again in that case?

There doesn't seem to be a timer, a service task, a forced IRQ trigger,
or a return of the full budget to retry the refill. The only
mpnic_nv_irq_trigger() call is in mpnic_napi_enable(). The only way out
seems to be a Tx completion on the same vector.

Could a receive-mostly queue stay stuck until the interface is brought
down and up again?

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260924-linux-mpnic-v2-0-4badc9b58b9e%40gmail.com
