Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794436902;
	b=tyfneguWVDcS883Pal5capYnvAg8OmNh97o8ABD/io0UEiPUR4atAeoAhHcjeN0IHF4y
	 +QOTxD2b4VtSq3io8ZnGwvcUaHrNaaMOj0dWpQcjxhv2ujEV70JLfwD7vKzMw63/9H7xa
	 k4P0CBp5tcE2KICGxW8tPOHMdX/Rx7jltsL3ZU4SfHsNr36+8g7qnhb5Q4OB5MjbQEz3V
	 AGNhrI40ZWIMHlAdWIZqAAT/gGWDBHhrhJzw5OXmw+vIv6wjHCSoKQJgmjUwsvEAKnIK5
	 dNo1FJFUN9kP8HNsjEhGvTILC29mlJl5RvtjvjSUIoJ0lE0tQ5AMZyp0RQusDZsNMQw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794436902;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=YXZE4/JCiF0eACXrRw2VIV6D7SpvemyMj7K6scSqWvc=;
	b=0g22U73FmauiNgdmH5saOoQ0XJ6ePl3tXBUj2TQbXkIMlKT6nmpvt0rpeGNd15g4fVLp
	 gMtHL8EN7A6WXl/7pasjx48ZCzJ53Dsg+gc9dY5Ocw67I51wSJ0Jh9keP60gijMxx/em6
	 Bu+zSTsSCWA9aP5+r1/FFwghdo7EVU8cb39G6YZkGMluU2I5kw8EnOILZSDehq6VwhJfw
	 WXw+SZV2+AS4eHrKyv6xlMFZKsLRplwBba2Buoq73XrPKkhU/oorLa/MmQ2jOux+jg1xZ
	 iVi5C42qFieWdOncFVppc+juoYdyxPrAMvfQNFO5Dp96OeG+FWVTRgfgHfD1slwbTxw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Bid5kCCS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0649360A5BE0;
	Wed, 11 Nov 2026 22:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Bid5kCCS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B2321F00ACC;
	Wed, 11 Nov 2026 22:41:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794436901;
	bh=YXZE4/JCiF0eACXrRw2VIV6D7SpvemyMj7K6scSqWvc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Bid5kCCSu5WypSvc7Yy6AMkIfdUDrJWusTlL6nlybv/UiOv7dlV09KEKfNBGlnJP8
	 Mo8DovxcVZhczOzVDrvnyRhRfAI6mKNGf4k5MQXl9i2KUjR9F5VhUthV46nUQXx5oy
	 STo1r6hrkydhg3ZeViNw3zqvmgw7dlrVsfUYk5zaTfKclmxpMN9J8Z8wox2WT7IKsv
	 osRhc3iDgQbp5YtFlgScoTScFaPYL4heyGJWa9ouZh26p8aSDk5HV1dteEtMysO3T2
	 x8jITzi8cuxxVCv/Gsk+HL1rUbt2a/M9cq/w4vZu93JIaAHruDGz4yZLzJq29ZqG7T
	 JrV5qY+YEVpbg==
Subject:
 Re: [PATCH net-next v1 10/11] eth: fbnic: Support RX buffers it cannot split
From: netdev-bot+sashiko@kernel.org
To: bjorn@kernel.org
Cc: magnus.karlsson@intel.com, maciej.fijalkowski@intel.com, sdf@fomichev.me,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, corbet@lwn.net, skhan@linuxfoundation.org,
 rdunlap@infradead.org, alexanderduyck@fb.com, kernel-team@meta.com,
 andrew+netdev@lunn.ch, hawk@kernel.org, ilias.apalodimas@linaro.org,
 ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
 asml.silence@gmail.com, axboe@kernel.dk, andrii@kernel.org, eddyz87@gmail.com,
 memxor@gmail.com, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, jolsa@kernel.org, emil@etsalapatis.com,
 ihor.solodrai@linux.dev, netdev@vger.kernel.org, bpf@vger.kernel.org,
 io-uring@vger.kernel.org, almasrymina@google.com, mike.marciniszyn@gmail.com,
 bestswngs@gmail.com, razor@blackwall.org, dw@davidwei.uk,
 aleksander.lobakin@intel.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, stuclar@meta.com
Date: Wed, 11 Nov 2026 22:41:39 +0000
Message-ID: <179443689907.2199510.5966675063900520158@kernel.org>
In-Reply-To: <20261110102039.1002605-11-bjorn@kernel.org>
References: <20261110102039.1002605-11-bjorn@kernel.org>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 2 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] fbnic_config_drop_mode() in
  drivers/net/ethernet/meta/fbnic/fbnic_txrx.c changes the drop mode in…
- [Medium] eth: fbnic: incomplete split-buffer checks in
  fbnic_bd_one_desc() callers
- [Low] (Baseline: rejected.) At this commit none of the whole-buffer
  code can run.

--

eth: fbnic: Support RX buffers it cannot split

The patch lets fbnic RX queues use a page pool provider without
MP_CAP_FRAG. Each such buffer gets a single reference, the queue is
programmed so each header and payload takes its own buffer, and packets
that break this are dropped. Header split is now set per queue, and link
up only modifies the drop mode in RDE_CTL0.

> diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
> index bfaa284e497eb..d96c957d6fbad 100644
> --- a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
> +++ b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c

[ ... ]

> @@ -1644,6 +1693,9 @@ fbnic_alloc_qt_page_pools(struct fbnic_net *fbn, struct fbnic_q_triad *qt,
>  		return PTR_ERR(pp);
>  
>  	qt->sub0.page_pool = pp;
> +	qt->hdr_max = 0;
> +	if (!page_pool_supports_frag(pp))
> +		qt->hdr_max = fbnic_whole_hdr_max(FBNIC_RX_HROOM);

[Severity: Low]
This isn't a bug, but can this branch be reached at this commit?

Both fbnic page pools are still created without PP_FLAG_MEM_PROVIDER.
That means no provider without MP_CAP_FRAG can be attached (xsk_pp only
advertises MP_CAP_READABLE), so page_pool_supports_frag() is always true
here.

As a result, qt->hdr_max stays 0. The whole-buffer paths in
fbnic_bd_one_desc(), fbnic_page_pool_init() and fbnic_enable_rcq() are
not used until the later patch "eth: fbnic: Support AF_XDP page pool zero
copy" sets PP_FLAG_MEM_PROVIDER.

Could the commit message say that a later patch in the series enables
this?

>  	if (netif_rxq_has_unreadable_mp(fbn->netdev, rxq_idx)) {
>  		pp_params.order = get_order(rx_page_size);
>  		pp_params.max_len = rx_page_size;

[ ... ]

> @@ -2693,20 +2750,32 @@ static void fbnic_config_drop_mode_rcq(struct fbnic_napi_vector *nv,
>  	fbnic_ring_wr32(rcq, FBNIC_QUEUE_RDE_CTL0, rcq_ctl);
>  }
>  
> +static u32 fbnic_rcq_hds_thresh(const struct fbnic_net *fbn,
> +				const struct fbnic_ring *rcq)
> +{
> +	const struct fbnic_q_triad *qt;
> +
> +	qt = container_of_const(rcq, struct fbnic_q_triad, cmpl);
> +	return qt->hdr_max ? : fbn->hds_thresh;
> +}
> +
> +/* Only the drop mode: a queue start may write the rest of the register */
>  void fbnic_config_drop_mode(struct fbnic_net *fbn, bool txp)
>  {
> -	bool hds;
> +	struct fbnic_ring *rcq;
> +	u32 drop_mode, rcq_ctl;
>  	int i, t;
>  
> -	hds = fbn->hds_thresh < FBNIC_HDR_BYTES_MIN;
> -
> +	drop_mode = fbnic_drop_mode(fbn, txp);
>  	for (i = 0; i < fbn->num_napi; i++) {
>  		struct fbnic_napi_vector *nv = fbn->napi[i];
>  
>  		for (t = 0; t < nv->rxt_count; t++) {
> -			struct fbnic_q_triad *qt = &nv->qt[nv->txt_count + t];
> -
> -			fbnic_config_drop_mode_rcq(nv, &qt->cmpl, txp, hds);
> +			rcq = &nv->qt[nv->txt_count + t].cmpl;
> +			rcq_ctl = fbnic_ring_rd32(rcq, FBNIC_QUEUE_RDE_CTL0);
> +			FIELD_MODIFY(FBNIC_QUEUE_RDE_CTL0_DROP_MODE_MASK,
> +				     &rcq_ctl, drop_mode);
> +			fbnic_ring_wr32(rcq, FBNIC_QUEUE_RDE_CTL0, rcq_ctl);

[Severity: Medium]
Does anything serialize this read-modify-write of FBNIC_QUEUE_RDE_CTL0
against a queue restart?

fbnic_config_drop_mode() is called from fbnic_phylink_mac_link_up():

fbnic_phylink.c:fbnic_phylink_mac_link_up() {
    ...
	fbn->tx_pause = tx_pause;
	fbnic_config_drop_mode(fbn, tx_pause);
    ...
}

That runs from the phylink_resolve() work item. The work item holds
pl->state_mutex and the phy locks, but not rtnl or the netdev instance
lock.

The queue start path runs under the netdev instance lock and writes the
whole register from per-queue state:

fbnic_queue_start()
  __fbnic_nv_restart()
    fbnic_enable_rcq()
      fbnic_config_drop_mode_rcq()
        fbnic_ring_wr32(rcq, FBNIC_QUEUE_RDE_CTL0, rcq_ctl);

Suppose the link up worker reads CTL0. A queue start then writes a new
CTL0 with a different EN_HDR_SPLIT, derived from qt->hdr_max. The worker
then writes its saved copy back.

Wouldn't the restarted queue keep the old EN_HDR_SPLIT, which no longer
matches the MAX_HDR, PAYLD_OFF and PAYLD_PG_CL values in CTL1? Nothing
corrects it until the next restart of that queue.

At this commit qt->hdr_max is always 0, so the written-back value still
matches. Later in the series, "eth: fbnic: Support AF_XDP page pool zero
copy" makes hdr_max and MIN_HROOM (from qt->rx_hroom) truly per queue.

After that, an AF_XDP bind or unbind that overlaps a link up event could
leave the queue misconfigured. For example, a stale EN_HDR_SPLIT on a
non-SG AF_XDP queue would make every packet multi-buffer, and
fbnic_run_xdp() would drop it.

>  		}
>  	}
>  }

[ ... ]

> @@ -993,6 +1000,19 @@ static unsigned int fbnic_hdr_pg_end(unsigned int pg_off, unsigned int len)
>  	return ALIGN(pg_off, 128) - FBNIC_RX_HROOM;
>  }
>  
> +/* A buffer that cannot be split has one reference and takes one descriptor */
> +static bool fbnic_bd_one_desc(struct fbnic_napi_vector *nv,
> +			      const struct fbnic_ring *bdq, unsigned int idx,
> +			      bool ok)
> +{
> +	if (likely(page_pool_supports_frag(bdq->page_pool) ||
> +		   (bdq->rx_buf[idx].pagecnt_bias == 1 && ok)))
> +		return true;
> +
> +	netdev_err_once(nv->napi.dev, "Bad descriptor for a whole RX buffer\n");
> +	return false;
> +}
> +
>  static void fbnic_pkt_prepare(struct fbnic_napi_vector *nv, u64 rcd,
>  			      struct fbnic_pkt_buff *pkt,
>  			      struct fbnic_q_triad *qt)

[Severity: Medium]
Do the two callers of fbnic_bd_one_desc() check enough to catch a
whole buffer that the device splits across more than one completion?

The commit message says packets that break the one descriptor per
buffer rule are dropped. Each caller only checks half of that
condition, though.

In fbnic_add_rx_frag() the ok argument is only !pg_off, and
FBNIC_RCD_AL_PAGE_FIN is not checked. Suppose a payload buffer ends up
holding more than one payload. The first completion then has
pg_off == 0 and PAGE_FIN == 0, so it passes. fbnic_page_pool_get_data()
drops pagecnt_bias from 1 to 0, and the packet takes the only reference
to the netmem.

That reference can then go back to the pool through
page_pool_put_full_netmem(), or be handed to the AF_XDP socket. The
device still has the buffer open at that point and may DMA the next
payload into it. The next completion for that buffer is rejected
because pagecnt_bias is now 0, but the buffer has already been
released by then.

fbnic_pkt_prepare() has the opposite gap. It checks only PAGE_FIN, not
where the header sits in the buffer. Suppose two headers land in the
same header buffer. The first completion has PAGE_FIN == 0 and is
rejected before fbnic_page_pool_get_head() runs, so pagecnt_bias stays
at 1.

The second completion has PAGE_FIN == 1 at a non-zero offset. It still
sees pagecnt_bias == 1 and is accepted. An xdp_buff is then built from
the middle of a buffer that was meant to hold a single header.

A conforming device should not do either of these with the MAX_HDR,
PAYLD_OFF and PAYLD_PG_CL values programmed in fbnic_enable_rcq().
However, these checks exist to catch the case where it does.

Should both callers require that the completion starts the buffer and
also closes it, i.e. a zero offset and PAGE_FIN set? Passing the rcd
into fbnic_bd_one_desc() and doing both checks there might keep the
header and payload paths from drifting apart again.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261110102039.1002605-1-bjorn%40kernel.org
