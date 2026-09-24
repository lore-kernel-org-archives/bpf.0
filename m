Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DB3149B218;
	Thu, 24 Sep 2026 14:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790261350; cv=none; b=RNITHQ8SIp+/t9vmFmF07X4D2n+hvlM/saREECZeJgR1Pl0dxWnlEooywnOQGhONGf3BiLnD+Ck6DOvEcIUHuY6eDAuXoWEjGUm8RxtGGyAZS+S0i8Jr7f1RDfxupzDPp3TkRjNW3xwD4Ey2ak0G0HUmAATvpRqKPDvERsv7EzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790261350; c=relaxed/simple;
	bh=Y4Q60JYPgzuLgSdL31/XQPMalyxZs7pbcsvCH4HGR64=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SJsvuKOdpRI+MnAPlMpCmzyj47KjBsdH2r3pID9e7r849g3BcEXzOr9xJ5cem37OT/HbLLtV9qj+ZbFcxE9YTQe+iPDhYmRAC+QEFzMNz535u0s8F9FU4luGSSeGvNc2UtmLyoaVZc0eRhni1itCvJ5/HhbNMSY2KJBvQk8NJhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Go7cVRob; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Go7cVRob"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A970B1F00893;
	Thu, 24 Sep 2026 14:48:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790261339;
	bh=nBIQB+nzz/jwkDc1kQV1tGt83B/UlGxQBbZIfubGGn8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Go7cVRobOOISOrB+DmpuDzI9a7NZtgTRnFHejvo7inQ06un3bMpTZYSOcIuWE/yZl
	 FHFc5aPIR5F0WeypTk6uWJXjv/CNZ2knE1GG+vllZbBqhO4+MfSUcdpL/DzuIZAhQi
	 RXY3/P2BnRNogTMrKXmWhTqGvfXub9sSQI3agFfAAtDBFAHheE5ktmksLrS4f0W4zl
	 UHhLMiS0ATSRE4JBNG4YyJekl0G+Dwq4ZFZufRxHTDNEEuAtZSH/hU2zDgpzgi49sj
	 chnc1I1esyiW1WEjBuDZxeKjE5xQdbC4jnfl5tLbY/adKH6qK9HtPPLgaqdiagG5mi
	 yr648KduE7y1w==
Subject: Re: [PATCH net v2] net: stmmac: fix rx Scatter-Gather support
From: netdev-bot+sashiko@kernel.org
To: lorenzo.bianconi@oss.qualcomm.com
Cc: maxime.chevallier@bootlin.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
 Jose.Abreu@synopsys.com, ast@kernel.org, daniel@iogearbox.net,
 hawk@kernel.org, john.fastabend@gmail.com, sdf@fomichev.me,
 netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org
Date: Thu, 24 Sep 2026 14:48:58 +0000
Message-ID: <179026133819.2160803.14223522369614655586@kernel.org>
In-Reply-To: <20260921-stmmac-rx-sg-fix-v2-1-b6d88c5ac2d7@oss.qualcomm.com>
References: <20260921-stmmac-rx-sg-fix-v2-1-b6d88c5ac2d7@oss.qualcomm.com>
X-sashiko-severity: Critical
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 10 potential
issue(s) to consider.

Critical: 2 · High: 2 (1) · Medium: 4 · Low: 2

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Critical] stmmac_rx() strips the FCS from multi-buffer frames with
  skb_trim(skb, len), but skb_trim() -> __skb_trim() ->…
- [Critical] With buffer2 now armed for non-SPH RX on GMAC4/XGMAC, an
  XDP_TX/XDP_REDIRECT verdict taken on a non-final descriptor of a…
- [High] The new XDP FCS strip in stmmac_rx() performs `buf1_len -=
  ETH_FCS_LEN` (line 5836) with no check that buf1_len >= ETH_FCS_LEN;…
- [High] stmmac_rx_check_buf2_cap() equates 'has a set_sec_addr op' with
  'can program (and disable) an independent secondary RX buffer', but…
- [Medium] The patch hard-codes pp_params.offset = 0 for every mode while
  stmmac_rx() still computes the partial device-sync length relative to…
- [Medium] The commit message attributes the SMMU fault to buffer2 never
  being backed for non-SPH frames, but dwmac4_set_sec_addr() gates DMA…
- [Medium] An oversized frame can now carry data in buffer2 (or in
  following descriptors) that is invisible to the attached XDP program…
- [Medium] The final `skb_trim(skb, len)` uses the accumulated hardware
  DMA length, which is fixed before the XDP program runs, while the…
- [Low] stmmac_rx_buf2_len() keeps the comment block asserting "Thus
  'plen - len' always gives the correct length of buf2" and scoping its…
- [Low] Concern that stmmac_rx_buf2_len()'s new condition lets GMAC4 with
  SPH disabled take the 'buffer2 is completely full' shortcut (return…

Pre-existing issues:
- [High] On the napi_build_skb() failure path in stmmac_rx() (line
  5897-5905) the page is returned to the page pool with…

--

net: stmmac: fix rx Scatter-Gather support

The patch allocates and programs the secondary RX buffer (buffer2) for
non-split-header frames on cores that expose a set_sec_addr descriptor op,
widens the page pool sync window to cover both buffers in every mode, and
replaces the per-buffer FCS removal with a skb_trim() on the assembled
frame.

Link: https://lore.kernel.org/r/20260916-stmmac-rx-sg-fix-v1-1-b49b7b8f725f@oss.qualcomm.com

A few questions below.

> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index 1fb5f804ea234..299355d6bf5fc 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -1629,6 +1629,16 @@ static void stmmac_clear_descriptors(struct stmmac_priv *priv,
>  		stmmac_clear_tx_descriptors(priv, dma_conf, queue);
>  }
>  
> +static bool stmmac_rx_check_buf2_cap(struct stmmac_priv *priv)
> +{
> +	/* Only cores that can program an independent secondary RX buffer
> +	 * (used for scatter-gather overflow or split-header payload) back
> +	 * buffer2. Legacy cores have no set_sec_addr op, so buffer2 is
> +	 * never handed to the hardware there.
> +	 */
> +	return priv->hw->desc && priv->hw->desc->set_sec_addr;
> +}

[Severity: High]

Does the presence of a set_sec_addr op really imply the core can also
disable buffer2?  dwmac4_set_sec_addr() honours the flag:

drivers/net/ethernet/stmicro/stmmac/dwmac4_descs.c:
	if (buf2_valid)
		p->des3 |= cpu_to_le32(RDES3_BUFFER2_VALID_ADDR);
	else
		p->des3 &= cpu_to_le32(~RDES3_BUFFER2_VALID_ADDR);

while dwxgmac2_set_sec_addr() ignores its is_valid argument entirely:

drivers/net/ethernet/stmicro/stmmac/dwxgmac2_descs.c:
static void dwxgmac2_set_sec_addr(struct dma_desc *p, dma_addr_t addr, bool is_valid)
{
	p->des2 = cpu_to_le32(lower_32_bits(addr));
	p->des3 = cpu_to_le32(upper_32_bits(addr));
}

The AF_XDP zero-copy refill path still does

	stmmac_set_desc_sec_addr(priv, rx_desc, 0, false);

in stmmac_rx_refill_zc() and then hands the descriptor to the DMA, and
stmmac_alloc_rx_buffers_zc() never programs a secondary address at all.
On XGMAC the false is discarded, so the descriptor stays armed with
buffer2 at DMA address 0 - the same unmapped-secondary-buffer condition
(iova=0x00000000) this patch is fixing for the non-ZC path.  XGMAC_CORE_INIT_RX
programs GPSL to XGMAC_JUMBO_LEN, so the MAC accepts frames far larger
than the XSK frame size used as dma_buf_sz.

The commit message acknowledges the gap:

  AF_XDP zero-copy RX is not covered by this change: a ZC queue still
  programs buffer2 at DMA address 0 (and XGMAC has no buffer2-valid bit),
  so an oversized frame overflowing buffer1 can still trigger the same
  SMMU translation fault. Handling is planned as a follow-up.

Since the fault class the patch claims to close stays reachable, would it
make sense to program a mapped buffer2 on ZC queues (or refuse ZC on cores
without a valid bit) here rather than relying on a flag the XGMAC
descriptor writer discards?  The new helper's comment also documents
semantics XGMAC does not implement.

>  
>  /**
>   * stmmac_init_rx_buffers - init the RX descriptor buffer.
>   * @priv: driver private structure
> @@ -1659,16 +1669,13 @@ static int stmmac_init_rx_buffers(struct stmmac_priv *priv,
>  		buf->page_offset = stmmac_rx_offset(priv);
>  	}
>  
> -	if (priv->sph_active && !buf->sec_page) {
> +	if (stmmac_rx_check_buf2_cap(priv) && !buf->sec_page) {
>  		buf->sec_page = page_pool_alloc_pages(rx_q->page_pool, gfp);
>  		if (!buf->sec_page)
>  			return -ENOMEM;
>  
>  		buf->sec_addr = page_pool_get_dma_addr(buf->sec_page);
>  		stmmac_set_desc_sec_addr(priv, p, buf->sec_addr, true);
> -	} else {
> -		buf->sec_page = NULL;
> -		stmmac_set_desc_sec_addr(priv, p, buf->sec_addr, false);
>  	}

[Severity: Medium]

Should the commit message mention that this doubles the RX ring memory
footprint?  On GMAC4/XGMAC configurations where SPH is not active
(STMMAC_FLAG_SPH_DISABLE, !dma_cap.sphen, or any attached XDP program,
which forces sph_active to false) every descriptor now pins two page pool
pages instead of one.

pp_params.pool_size stays at dma_conf->dma_rx_size while twice as many
pages are in flight, so a share of recycles now falls back to the page
allocator on the RX hot path.

Also, the commit message says buffer2 "was neither allocated nor backed by
a valid mapping".  For GMAC4 the removed else branch cleared
RDES3_BUFFER2_VALID_ADDR, which gates DMA writes to buffer2, whereas
dwxgmac2_set_sec_addr() has no such bit at all.  Which core produced the
quoted fault, and could the description distinguish the two cases?

>  
>  	buf->addr = page_pool_get_dma_addr(buf->page) + buf->page_offset;
> @@ -2256,13 +2263,8 @@ static int __alloc_dma_rx_desc_resources(struct stmmac_priv *priv,
>  	pp_params.nid = dev_to_node(priv->device);
>  	pp_params.dev = priv->device;
>  	pp_params.dma_dir = xdp_prog ? DMA_BIDIRECTIONAL : DMA_FROM_DEVICE;
> -	pp_params.offset = stmmac_rx_offset(priv);
> -	pp_params.max_len = dma_conf->dma_buf_sz;
> -
> -	if (priv->sph_active) {
> -		pp_params.offset = 0;
> -		pp_params.max_len += stmmac_rx_offset(priv);
> -	}
> +	pp_params.offset = 0;
> +	pp_params.max_len = dma_conf->dma_buf_sz + stmmac_rx_offset(priv);

[Severity: Medium]

With offset forced to 0 in every mode, does the partial device sync on the
XDP consumed path still cover the region the CPU touched?  stmmac_rx()
still computes the length relative to buf->page_offset:

			sync_len = ctx.xdp.data_end - ctx.xdp.data_hard_start -
				   buf->page_offset;
			...
					page_pool_put_page(rx_q->page_pool,
							   virt_to_head_page(ctx.xdp.data),
							   sync_len, true);

and page_pool starts the sync at pool->p.offset, capping but never
extending the supplied length:

net/core/page_pool.c:__page_pool_dma_sync_for_device() {
	dma_sync_size = min(dma_sync_size, pool->p.max_len);
	__dma_sync_single_for_device(pool->p.dev, dma_addr + pool->p.offset,
				     dma_sync_size, pool->p.dma_dir);
}

So the window is shifted down by page_offset: the headroom gets synced and
the last page_offset bytes (258 with XDP headroom) of the touched region do
not, before the page is recycled to the RX DMA.  Previously XDP always ran
with offset = stmmac_rx_offset(), because sph_active is forced false while a
program is attached, so the base matched the subtraction.

Would adding buf->page_offset back into sync_len (or keeping offset at
stmmac_rx_offset() and only widening max_len) be the intent here?

>  
>  	rx_q->page_pool = page_pool_create(&pp_params);
>  	if (IS_ERR(rx_q->page_pool)) {

[ ... ]

> @@ -5142,7 +5142,9 @@ static unsigned int stmmac_rx_buf1_len(struct stmmac_priv *priv,
>  	unsigned int plen = 0, hlen = 0;
>  	int coe = priv->hw->rx_csum;
>  
> -	/* Not first descriptor, buffer is always zero */
> +	/* Not first descriptor, SPH enabled: buffer1 only carries the
> +	 * split header of the first descriptor, so it is zero here.
> +	 */
>  	if (priv->sph_active && len)
>  		return 0;
>  
> @@ -5153,14 +5155,16 @@ static unsigned int stmmac_rx_buf1_len(struct stmmac_priv *priv,
>  		return hlen;
>  	}
>  
> -	/* First descriptor, not last descriptor and not split header */
> +	/* Not last descriptor and not split header: buffer1 is fully filled */
>  	if (status & rx_not_ls)
>  		return priv->dma_conf.dma_buf_sz;
>  
>  	plen = stmmac_get_rx_frame_len(priv, p, coe);
>  
> -	/* First descriptor and last descriptor and not split header */
> -	return min_t(unsigned int, priv->dma_conf.dma_buf_sz, plen);
> +	/* Last descriptor and not split header: buffer1 holds the remaining
> +	 * bytes of the frame, up to dma_buf_sz
> +	 */
> +	return min_t(unsigned int, priv->dma_conf.dma_buf_sz, plen - len);
>  }
>  
>  static unsigned int stmmac_rx_buf2_len(struct stmmac_priv *priv,
> @@ -5170,8 +5174,7 @@ static unsigned int stmmac_rx_buf2_len(struct stmmac_priv *priv,
>  	int coe = priv->hw->rx_csum;
>  	unsigned int plen = 0;
>  
> -	/* Not split header, buffer is not available */
> -	if (!priv->sph_active)
> +	if (!stmmac_rx_check_buf2_cap(priv))
>  		return 0;
>  
>  	/* For GMAC4, when split header is enabled, in some rare cases, the
> @@ -5188,14 +5191,15 @@ static unsigned int stmmac_rx_buf2_len(struct stmmac_priv *priv,
>  	 * Thus 'plen - len' always gives the correct length of buf2.
>  	 */
>  
> -	/* Not GMAC4 and not last descriptor */
> -	if (priv->plat->core_type != DWMAC_CORE_GMAC4 && (status & rx_not_ls))
> +	/* Not GMAC4, or non-SPH and not last descriptor */
> +	if ((priv->plat->core_type != DWMAC_CORE_GMAC4 || !priv->sph_active) &&
> +	    (status & rx_not_ls))
>  		return priv->dma_conf.dma_buf_sz;
>  
>  	/* GMAC4 or last descriptor */
>  	plen = stmmac_get_rx_frame_len(priv, p, coe);
>  
> -	return plen - len;
> +	return plen > len ? plen - len : 0;
>  }

[Severity: Critical]

The new clamp guards plen < len, but there is no upper bound on the
result.  Can buf2_len end up larger than the page backing sec_page?

In stmmac_rx() an XDP_TX/XDP_REDIRECT verdict abandons the frame with
continue rather than goto read_again, even when rx_not_ls is set:

				} else if (xdp_res & (STMMAC_XDP_TX |
						      STMMAC_XDP_REDIRECT)) {
					xdp_status |= xdp_res;
					buf->page = NULL;
					skb = NULL;
					count++;
					continue;

count has been incremented, so at the loop head the saved-state branch is
not taken and len is reset while the remaining descriptors of the same
frame are still in the ring:

		} else {
			rx_q->state_saved = false;
			skb = NULL;
			error = 0;
			len = 0;
		}

Those descriptors are then parsed as a fresh frame with len starting at 0,
while plen on the last descriptor is the full frame length.  For a 9000
byte frame with dma_buf_sz 1536: buf1_len = min(1536, 9000 - 3072) = 1536,
then buf2_len = 9000 - 4608 = 4392, which exceeds both dma_buf_sz and the
order-0 page holding sec_page.  That value is used unchecked:

		if (buf2_len) {
			dma_sync_single_for_cpu(priv->device, buf->sec_addr,
						buf2_len, dma_dir);
			skb_add_rx_frag(skb, skb_shinfo(skb)->nr_frags,
					buf->sec_page, 0, buf2_len,
					priv->dma_conf.dma_buf_sz);

sph_active is forced false whenever an XDP program is attached
(stmmac_xdp_set_prog()), so the configuration where buffer2 is newly armed
is exactly the XDP one, and GMAC_CORE_INIT sets GMAC_CONFIG_JE so the MAC
accepts oversized frames even at MTU 1500.  Before this patch buf2_len was
hard zero outside SPH, so this was unreachable.

Should buf2_len be clamped to dma_buf_sz, and should that verdict path use
goto read_again while rx_not_ls is set?

[Severity: Low]

This isn't a bug, but the retained comment block still asserts "Thus
'plen - len' always gives the correct length of buf2" while the return is
now guarded with plen > len ? plen - len : 0.

The block also scopes its reasoning to "For GMAC4, when split header is
enabled", although the function now serves the non-SPH scatter-gather case
too, including XGMAC.  The trailing "/* GMAC4 or last descriptor */" label
no longer matches the condition above it either.

>  
>  static int stmmac_xdp_xmit_xdpf(struct stmmac_priv *priv, int queue,

[ ... ]

> @@ -5807,24 +5812,31 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
>  		len += buf2_len;
>  
>  		/* ACS is disabled; strip manually. */
> -		if (likely(!(status & rx_not_ls))) {
> -			if (buf2_len) {
> -				buf2_len -= ETH_FCS_LEN;
> -				len -= ETH_FCS_LEN;
> -			} else if (buf1_len) {
> -				buf1_len -= ETH_FCS_LEN;
> -				len -= ETH_FCS_LEN;
> -			}
> -		}
> +		if (likely(!(status & rx_not_ls)))
> +			len -= ETH_FCS_LEN;
>  
>  		if (!skb) {
>  			unsigned int pre_len, sync_len;
>  
> +			/* Each frame starts here: reset the FCS handling */
> +			fcs_stripped = false;
> +
>  			dma_sync_single_for_cpu(priv->device, buf->addr,
>  						buf1_len, dma_dir);
>  			net_prefetch(page_address(buf->page) +
>  				     buf->page_offset);
>  
> +			/* The XDP program must not see the FCS. This only
> +			 * applies to a single-buffer frame (buf2_len == 0),
> +			 * where the whole frame and its FCS sit in buffer1;
> +			 * otherwise the FCS is stripped from the assembled
> +			 * frame with skb_trim().
> +			 */
> +			if (stmmac_xdp_is_enabled(priv) && !buf2_len) {
> +				buf1_len -= ETH_FCS_LEN;
> +				fcs_stripped = true;
> +			}
> +

[Severity: High]

Is buf1_len guaranteed to be at least ETH_FCS_LEN at this point?  The old
code guarded the equivalent subtraction with else if (buf1_len).

stmmac_rx_buf1_len() now returns min_t(unsigned int, dma_buf_sz,
plen - len), which legitimately yields 1..3 on a last descriptor reached
while skb is still NULL and len is non-zero.  Two ways to get there:

  - an XDP CONSUMED verdict on an earlier descriptor does goto read_again
    with len already accumulated
  - napi_build_skb() fails, goto drain_data falls through to read_again

buf2_len is 0 in exactly that case thanks to the new
plen > len ? plen - len : 0 clamp, so this block runs and buf1_len wraps
to roughly 4 GiB.  The wrapped value becomes the data_len argument of
xdp_prepare_buff(), producing an xdp_buff with data_end below data for the
program, and on XDP_PASS it is recomputed as

			buf1_len = ctx.xdp.data_end - ctx.xdp.data;

and passed to skb_put(), which would hit skb_over_panic().

Separately, is !buf2_len a sound test for "single-buffer frame"?  On cores
without set_sec_addr, stmmac_rx_buf2_len() always returns 0, so this would
strip 4 payload bytes from buffer1 of a non-last descriptor and set
fcs_stripped so the real FCS is never removed.

Would testing !(status & rx_not_ls) and buf1_len >= ETH_FCS_LEN cover both?
The len -= ETH_FCS_LEN above is unguarded in the same way.

>  			xdp_init_buff(&ctx.xdp, bufsz, &rx_q->xdp_rxq);
>  			xdp_prepare_buff(&ctx.xdp, page_address(buf->page),
>  					 buf->page_offset, buf1_len, true);

[Severity: Medium]

Now that buffer2 is populated for non-SPH RX, the xdp_buff is built from
buffer1 only and the has-frags flag is never set, yet sec_page is appended
to the skb with skb_add_rx_frag() afterwards and delivered on XDP_PASS.

Can an XDP filter be bypassed by an oversized frame whose tail lands in
buffer2, since the program inspects a shorter packet than the stack
receives?  On TX/REDIRECT the tail is dropped instead.

The commit message documents the limitation:

  Native XDP currently only supports single-buffer (linear) frames. An
  oversized frame accepted by the MAC (jumbo enabled) is received via
  buffer2; the XDP program only sees buffer1, so on a TX/REDIRECT verdict
  the frame is forwarded truncated.

stmmac_xdp_set_prog() caps the MTU at 1500, but GMAC_CONFIG_JE in
GMAC_CORE_INIT and GPSL = XGMAC_JUMBO_LEN mean the MAC still accepts
oversized frames from the wire.  Would dropping frames that span buffers
while a native XDP program is attached be preferable until multi-buffer
support lands?

> @@ -5924,6 +5936,10 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
>  
>  		/* Got entire packet into SKB. Finish it. */
>  
> +		/* Remove FCS if needed */
> +		if (!fcs_stripped)
> +			skb_trim(skb, len);
> +

[Severity: Critical]

Does this strip the FCS for frames assembled from more than one buffer?
skb_trim() refuses to touch a non-linear skb:

include/linux/skbuff.h:__skb_set_length() {
	if (WARN_ON(skb_is_nonlinear(skb)))
		return;
	...
}

net/core/skbuff.c:skb_trim() {
	if (skb->len > len)
		__skb_trim(skb, len);
}

Any frame where buffer2 or a following descriptor was attached with
skb_add_rx_frag() has skb->data_len != 0, so skb_is_nonlinear() is true.
For those frames this call emits a WARN_ON() splat and leaves the four FCS
bytes in skb->len, while rx_bytes is accounted with the shorter len.

With SPH active on GMAC4/XGMAC, buffer1 carries only the split header and
the payload always lands in buffer2, so this would fire for essentially
every received IP packet, once per packet.  Should this be pskb_trim() or
__pskb_trim() instead?

[Severity: Medium]

len is finalized from the descriptor lengths before the program runs,
while the skb head is built from the XDP-adjusted length:

			/* XDP program may expand or reduce tail */
			buf1_len = ctx.xdp.data_end - ctx.xdp.data;

If an XDP_PASS program calls bpf_xdp_adjust_tail() or
bpf_xdp_adjust_head() on a frame that spans buffer1 and buffer2, does
skb->len still correspond to len?

A shrink larger than ETH_FCS_LEN makes skb->len < len, so the trim does
nothing and the FCS stays in the frame; a smaller adjustment is partially
undone by the trim.  rx_bytes is accounted from len as well.

This is masked today by the non-linear skb_trim() behaviour above, but
becomes a live length error once that call is converted to pskb_trim().

[Severity: High]

This isn't a bug introduced by this patch, but the napi_build_skb()
failure path earlier in stmmac_rx() recycles the page without clearing
buf->page:

			skb = napi_build_skb(page_address(buf->page),
					     rx_q->napi_skb_frag_size);
			if (!skb) {
				page_pool_recycle_direct(rx_q->page_pool,
							 buf->page);
				rx_dropped++;
				count++;
				goto drain_data;
			}

Every other consumption site in the function sets buf->page = NULL.
stmmac_rx_refill() only allocates when buf->page is NULL:

		if (!buf->page) {
			buf->page = page_pool_alloc_pages(rx_q->page_pool, gfp);

so the descriptor is re-armed with the DMA address of a page already
returned to the pool, which page_pool_alloc_pages() may have handed to
another entry or skb.

Does this patch make the interleaving easier to hit, given that two pool
pages per descriptor are now in flight while pp_params.pool_size stays at
dma_rx_size?

>  		stmmac_get_rx_hwtstamp(priv, p, np, skb);
>  
>  		if (priv->hw->hw_vlan_en)

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260921-stmmac-rx-sg-fix-v2-1-b6d88c5ac2d7%40oss.qualcomm.com
