Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A976D3B0597;
	Tue, 22 Sep 2026 15:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790090663; cv=none; b=DM6AUHClOQ1yPMVdHVpNsoEuO+OT4M8tNJCq62iOxQ/7LnrBD9jVjX9RJskgiGJWd1WTJs/wMnf2ogbHo5J8d+lw1Fdr2up+1UKQEf4i0YeZ683sFTo3rKw2asK1k0b1gkXr2eXZLRCZJ8NutqaIZknNvrmgacF4E9XBp5E1rqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790090663; c=relaxed/simple;
	bh=q/XRhxMFde8XIYuNei9CGSftqh0qhQLWAGRhC2Hu3X4=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OHGzd3RLKPi6V6sw2FHy1deAFQrrqo9MoYHBePM1DfH++gvHzjS+yhtnhs6qi5ETPnU+JoZ5pjD6WJry8hDFTAGoT0PazG4wjY39X+rr0LGbUj3+S6v0RzGLm/g5DRJrJtxqlyTlorKNWKNL9Y/2E1t4GddRXPrA5UV9BQT4uzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bvqC0t1w; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bvqC0t1w"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8349F1F00893;
	Tue, 22 Sep 2026 15:24:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790090661;
	bh=5TPkxdbhS6TT4rsbpRuXg269XY09+Drk3QiXnZyIKow=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=bvqC0t1w2oVHGD1V/n7O4txWzZB8n08UchCwoOTkjT8nioaUbmZO7P5syinvsbuFR
	 pOL07m1/Vr2upPm/1ERzXQHWcN/vszVEvhiXWUP7AZI3oZ+M/M79fdxTCZ77Q4N47h
	 AOeBLS+VMJipcprKcmsnOM6GPCWoJmhjD4hmIhA4tFLJmXCCkUKQoqnfgbdaoceumn
	 NWOfp2un5VpLOsf2Mee+99l/LNnQ/oFwa7JmgkWSpv0qF9WpDwDNyBd6eoyOoJAETU
	 kLUMNsIxKJF3BIZ7tP0xTWLSfH+dYmgYxLqTaBqkSGRLTeIO3/xLKKtnvGpgiIigxO
	 oBzbHryjojang==
Subject: Re: [PATCH net-next] net: stmmac: rework stmmac_rx to support XDP rx
 multi-buff
From: netdev-bot+sashiko@kernel.org
To: lorenzo.bianconi@oss.qualcomm.com
Cc: maxime.chevallier@bootlin.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com, ast@kernel.org,
 daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
 sdf@fomichev.me, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org
Date: Tue, 22 Sep 2026 15:24:20 +0000
Message-ID: <179009066006.2160803.5369744103643817334@kernel.org>
In-Reply-To: <20260918-stmmac-rx-mb-v1-1-0b4517d404af@oss.qualcomm.com>
References: <20260918-stmmac-rx-mb-v1-1-0b4517d404af@oss.qualcomm.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 6 potential
issue(s) to consider.

Critical: 0 · High: 2 · Medium: 3 (1) · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] stmmac_rx(): after stmmac_build_skb() fails (napi_build_skb()
  returns NULL), the code does `rx_dropped++; count++; goto read_again;`…
- [High] The patch introduces a new invariant — 'rx_q->state_saved ==
  true implies rx_q->state.xdp holds a valid in-progress xdp_buff' — but…
- [Medium] stmmac_rx() now ends with an unconditional `rx_q->state_saved
  = !first_desc;` (line 6056).
- [Medium] The new RX code can hand the XDP program a fragmented xdp_buff
  (stmmac_build_xdp_frags() calls xdp_buff_set_frags_flag() and fills…
- [Medium] The commit subject and message state that the XDP program now
  'runs on the full (possibly fragmented) packet instead of just the…
- [Low] Concern (assessed as a false positive): stmmac_build_xdp_frags()
  recycles the excess page via page_pool_put_full_page() once…

Pre-existing issues:
- [Medium] Concern (assessed as not reportable): stmmac_rx_buf2_len()
  returns the unsigned expression 'plen - len' with no check that plen…

--

net: stmmac: rework stmmac_rx to support XDP rx multi-buff

The RX path now accumulates every descriptor of a frame into a single
xdp_buff so the XDP program sees the whole (possibly fragmented) packet, and
builds the skb from that buffer with napi_build_skb() plus
xdp_update_skb_frags_info(). The in-progress xdp_buff is stored in
rx_q->state instead of a partially built skb so it survives a NAPI poll
boundary.

A few questions below about the new failure paths and the saved state.

> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac.h b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
> index 4fc96b317d79..69bdbbf4b920 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac.h
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
> @@ -132,7 +132,7 @@ struct stmmac_rx_queue {
>  	dma_addr_t dma_rx_phy;
>  	unsigned int state_saved;
>  	struct {
> -		struct sk_buff *skb;
> +		struct xdp_buff xdp;
>  		unsigned int len;
>  		unsigned int error;
>  	} state;

> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index bf9e7e4cb1c3..1de8d9626c64 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c

[ ... ]

> @@ -5735,6 +5737,82 @@ static int stmmac_rx_zc(struct stmmac_priv *priv, int limit, u32 queue)
>  	return failure ? limit : (int)count;
>  }
>  
> +static void
> +stmmac_xdp_put_buff(struct stmmac_rx_queue *rx_q, struct xdp_buff *xdp,
> +		    int sync_len)
> +{
> +	struct skb_shared_info *sinfo = xdp_get_shared_info_from_buff(xdp);
> +	int i;
> +
> +	if (likely(!xdp_buff_has_frags(xdp)))
> +		goto out;
> +
> +	for (i = 0; i < sinfo->nr_frags; i++)
> +		page_pool_put_full_page(rx_q->page_pool,
> +					skb_frag_page(&sinfo->frags[i]), true);
> +out:
> +	page_pool_put_page(rx_q->page_pool, virt_to_head_page(xdp->data),
> +			   sync_len, true);
> +}
> +
> +static struct sk_buff *stmmac_build_skb(struct xdp_buff *xdp)
> +{
> +	struct skb_shared_info *sinfo = xdp_get_shared_info_from_buff(xdp);
> +	u32 metasize = xdp->data - xdp->data_meta;
> +	struct sk_buff *skb;
> +	u8 num_frags;
> +
> +	if (unlikely(xdp_buff_has_frags(xdp)))
> +		num_frags = sinfo->nr_frags;
> +
> +	skb = napi_build_skb(xdp->data_hard_start, xdp->frame_sz);
> +	if (!skb)
> +		return ERR_PTR(-ENOMEM);
> +
> +	skb_mark_for_recycle(skb);
> +	skb_reserve(skb, xdp->data - xdp->data_hard_start);
> +	skb_put(skb, xdp->data_end - xdp->data);
> +	if (metasize)
> +		skb_metadata_set(skb, metasize);
> +
> +	if (unlikely(xdp_buff_has_frags(xdp)))
> +		xdp_update_skb_frags_info(skb, num_frags, sinfo->xdp_frags_size,
> +					  num_frags * xdp->frame_sz,
> +					  xdp_buff_get_skb_flags(xdp));
> +	return skb;
> +}
> +
> +static void stmmac_build_xdp_frags(struct stmmac_priv *priv,
> +				   struct stmmac_rx_queue *rx_q,
> +				   unsigned int len, struct page *page,
> +				   unsigned int offset,
> +				   enum dma_data_direction dma_dir,
> +				   struct xdp_buff *xdp)
> +{
> +	struct skb_shared_info *sinfo = xdp_get_shared_info_from_buff(xdp);
> +	dma_addr_t dma_addr = page_pool_get_dma_addr(page) + offset;
> +
> +	dma_sync_single_for_cpu(priv->device, dma_addr, len, dma_dir);
> +
> +	if (!xdp_buff_has_frags(xdp)) {
> +		xdp_buff_set_frags_flag(xdp);
       ^^^^

[Severity: Medium]

This marks buffers that are subsequently passed to the XDP program as
multi-buffer, but the advertised feature mask in stmmac_dvr_probe() is
unchanged:

	ndev->xdp_features = NETDEV_XDP_ACT_BASIC | NETDEV_XDP_ACT_REDIRECT |
			     NETDEV_XDP_ACT_XSK_ZEROCOPY;

Should NETDEV_XDP_ACT_RX_SG be set here, so core and userspace (netlink
NETDEV_A_DEV_XDP_FEATURES, bpftool, the AF_XDP selftests) can tell that this
NAPI callback may hand non-linear buffers to a program?

The commit message says the XDP program now "runs on the full (possibly
fragmented) packet instead of just the first buffer". Is that reachable with
this patch alone? stmmac_xdp_set_prog() is untouched and still has:

	if (prog && dev->mtu > ETH_DATA_LEN) {
		NL_SET_ERR_MSG_MOD(extack, "Jumbo frames not supported");
		return -EOPNOTSUPP;
	}
	...
	priv->sph_active = priv->sph_capable && !stmmac_xdp_is_enabled(priv);

so with a program attached the MTU is at most 1500 and split-header is off,
and stmmac_set_bfsize() then returns at least DEFAULT_BUFSIZE, which holds a
whole frame in one descriptor. Should the gating rework come with this
patch, or should the message describe the change as preparatory?

> +		sinfo->xdp_frags_size = 0;
> +		sinfo->nr_frags = 0;
> +	}
> +
> +	if (sinfo->nr_frags < MAX_SKB_FRAGS) {
> +		skb_frag_t *frag = &sinfo->frags[sinfo->nr_frags++];
> +
> +		skb_frag_fill_page_desc(frag, page, offset, len);
> +		sinfo->xdp_frags_size += len;
> +
> +		if (page_is_pfmemalloc(page))
> +			xdp_buff_set_frag_pfmemalloc(xdp);
> +	} else {
> +		page_pool_put_full_page(rx_q->page_pool, page, true);
> +	}
> +}
> +

[ ... ]

> @@ -5780,9 +5859,10 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
>  		u32 hash;
>  
>  		if (!count && rx_q->state_saved) {
> -			skb = rx_q->state.skb;
> +			ctx.xdp = rx_q->state.xdp;
>  			error = rx_q->state.error;
>  			len = rx_q->state.len;
> +			first_desc = false;

[Severity: High]

This restore assumes that state_saved == true implies state.xdp holds a
valid in-progress buffer. Is that invariant maintained everywhere?

stmmac_rx_zc() still ends with:

	if (status & rx_not_ls) {
		rx_q->state_saved = true;
		rx_q->state.error = error;
		rx_q->state.len = len;
	}

and never writes rx_q->state.xdp. If an AF_XDP socket is unbound after a
multi-descriptor frame straddled the budget boundary, the next non-zero-copy
stmmac_rx() takes the branch above with first_desc = false and a state.xdp
that was never written, and the first non-zero buf1_len/buf2_len reaches
stmmac_build_xdp_frags():

	struct skb_shared_info *sinfo = xdp_get_shared_info_from_buff(xdp);
	...
	sinfo->xdp_frags_size = 0;
	sinfo->nr_frags = 0;

with sinfo == data_hard_start + frame_sz - SKB_DATA_ALIGN(sizeof(struct
skb_shared_info)). For a zeroed state that is a write near (void *)-320.
Should stmmac_rx_zc() either store a buffer too, or leave state_saved clear?

Separately, is anything releasing state.xdp on teardown?
dma_free_rx_skbufs() and __free_dma_rx_desc_resources() only walk
buf_pool[], while the head page and the already-collected fragments were
detached from it (buf->page = NULL, buf->sec_page = NULL), so
page_pool_destroy() would still see them in flight.

And after a reconfiguration that reuses the same struct stmmac_rx_queue with
a fresh rx_q->page_pool (ethtool ring/channel change, MTU change, XDP
attach/detach, tx-timeout reset), state_saved is still set, so the stale
buffer is restored, written to, and finally returned with
page_pool_put_page(rx_q->page_pool, ...) of a different pool than the one
that owns those pages. Should the init/teardown paths clear state_saved and
release state.xdp?

>  		} else {
>  			rx_q->state_saved = false;
>  			skb = NULL;

[ ... ]

> @@ -5831,6 +5911,10 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
>  		if (unlikely(error && (status & rx_not_ls)))
>  			goto read_again;
>  		if (unlikely(error)) {
> +			if (!first_desc) {
> +				stmmac_xdp_put_buff(rx_q, &ctx.xdp, -1);
> +				first_desc = true;
> +			}
>  			dev_kfree_skb(skb);
>  			skb = NULL;
>  			count++;

[ ... ]

> @@ -5866,6 +5948,28 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
>  			xdp_init_buff(&ctx.xdp, bufsz, &rx_q->xdp_rxq);
>  			xdp_prepare_buff(&ctx.xdp, page_address(buf->page),
>  					 buf->page_offset, buf1_len, true);
> +			first_desc = false;
> +			buf->page = NULL;
> +		} else if (buf1_len) {
> +			stmmac_build_xdp_frags(priv, rx_q, buf1_len, buf->page,
> +					       buf->page_offset, dma_dir,
> +					       &ctx.xdp);
> +			buf->page = NULL;
> +		}
> +
> +		if (buf2_len) {
> +			stmmac_build_xdp_frags(priv, rx_q, buf2_len,
> +					       buf->sec_page, buf->page_offset,
> +					       dma_dir, &ctx.xdp);
> +			buf->sec_page = NULL;
> +		}
> +
> +		if (likely(status & rx_not_ls))
> +			goto read_again;
> +
> +		first_desc = true;
> +		if (!skb) {
> +			unsigned int pre_len, sync_len;
>  
>  			pre_len = ctx.xdp.data_end - ctx.xdp.data_hard_start -
>  				  buf->page_offset;

[ ... ]

> @@ -5906,7 +6007,6 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
>  				} else if (xdp_res & (STMMAC_XDP_TX |
>  						      STMMAC_XDP_REDIRECT)) {
>  					xdp_status |= xdp_res;
> -					buf->page = NULL;
>  					skb = NULL;
>  					count++;
>  					continue;

[Severity: Medium]

An XDP_TX verdict is treated as a successful hand-off here, but is the TX
side fragment aware? stmmac_xdp_xmit_xdpf() never tests
xdp_frame_has_frags(); it maps xdpf->data for xdpf->len, programs one
descriptor and then calls:

	stmmac_set_tx_dma_last_segment(tx_q, entry);

xdp_update_frame_from_buff() copies xdp->flags into the frame but leaves
xdpf->len as the linear head length only, the total being
xdp_get_frame_len() = xdpf->len + sinfo->xdp_frags_size. Can a fragmented
buffer therefore be transmitted with only the head on the wire while still
counted as STMMAC_XDP_TX?

stmmac_xdp_set_prog() also calls xdp_features_set_redirect_target(dev,
false), which states that this xmit path cannot take scatter-gather frames.
Should fragmented frames be linearised or refused before XDP_TX?

> @@ -5914,51 +6014,13 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
>  			}
>  		}
>  
> -		if (!skb) {
> -			unsigned int head_pad_len;
> -
> -			/* XDP program may expand or reduce tail */
> -			buf1_len = ctx.xdp.data_end - ctx.xdp.data;
> -
> -			skb = napi_build_skb(page_address(buf->page),
> -					     rx_q->napi_skb_frag_size);
> -			if (!skb) {
> -				page_pool_recycle_direct(rx_q->page_pool,
> -							 buf->page);
> -				rx_dropped++;
> -				count++;
> -				goto drain_data;
> -			}
> -

[ ... ]

> -drain_data:
> -		if (likely(status & rx_not_ls))
> +		skb = stmmac_build_skb(&ctx.xdp);
> +		if (IS_ERR(skb)) {
> +			stmmac_xdp_put_buff(rx_q, &ctx.xdp, -1);
> +			rx_dropped++;
> +			count++;
>  			goto read_again;
> -		if (!skb)
> -			continue;
> +		}

[Severity: High]

When napi_build_skb() inside stmmac_build_skb() fails, skb keeps
ERR_PTR(-ENOMEM) and len keeps the aborted frame's length, and the jump
lands on read_again:, which sits below the per-frame reset:

		} else {
			rx_q->state_saved = false;
			skb = NULL;
			error = 0;
			len = 0;
		}

read_again:

Is the next frame then processed with the error pointer and the stale length
still in place?

If the next descriptor reports discard_frame, the error path above runs
dev_kfree_skb(skb), and dev_kfree_skb() is consume_skb(), which only checks
for NULL before calling skb_unref(). Can that dereference ERR_PTR(-ENOMEM)
in softirq context?

The gate ahead of stmmac_xdp_run_prog() is "if (!skb)", which is false for a
non-NULL error pointer, so the program is skipped for the following frame
and that frame is then rebuilt by stmmac_build_skb() and passed to
napi_gro_receive(). Does this silently bypass the attached program for one
frame?

With split-header active, the stale non-zero len makes stmmac_rx_buf1_len()
return 0 and stmmac_rx_buf2_len() compute the unsigned

	return plen - len;

which wraps when the following frame is shorter than the aborted one. That
value is then used as the dma_sync_single_for_cpu() size and as the fragment
length in stmmac_build_xdp_frags(). Would resetting skb and len (or using
continue, as the pre-patch code effectively did by falling through
drain_data into "if (!skb) continue;") be safer here?

>  
>  		/* Got entire packet into SKB. Finish it. */
>  

[ ... ]

> @@ -5991,9 +6053,9 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
>  		count++;
>  	}
>  
> -	if (status & rx_not_ls || skb) {
> -		rx_q->state_saved = true;
> -		rx_q->state.skb = skb;
> +	rx_q->state_saved = !first_desc;
> +	if (!first_desc) {
> +		rx_q->state.xdp = ctx.xdp;
>  		rx_q->state.error = error;
>  		rx_q->state.len = len;
>  	}

[Severity: Medium]

This assignment is now unconditional. netpoll polls with a zero budget:

net/core/netpoll.c:poll_one_napi()
	/* We explicitly pass the polling call a budget of 0 to
	 * indicate that we are clearing the Tx path only.
	 */
	work = napi->poll(napi, 0);

and stmmac_napi_poll_rx() forwards that budget to stmmac_rx() with no early
return. With limit == 0 the while (count < limit) body never runs, so
first_desc keeps its initialiser value true and state_saved is cleared while
state.xdp still owns the head page plus the fragments collected so far,
which were detached from buf_pool with buf->page = NULL.

Can this orphan those page pool pages, and can the remaining descriptors of
that frame then be parsed as the start of a new frame, with
xdp_prepare_buff() run on a middle or last descriptor? The previous tail
condition "if (status & rx_not_ls || skb)" left state_saved untouched in
that case, since status is 0 and skb is NULL.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260918-stmmac-rx-mb-v1-1-0b4517d404af%40oss.qualcomm.com
