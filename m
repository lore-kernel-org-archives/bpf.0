Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8662A3CB55D;
	Sun, 27 Sep 2026 09:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790501382; cv=none; b=kxorpbtP4hRsiAI5APcZkoX7ar0L3yRLiIu1DUijD7Xr7cRNR3t5PDvRb1ZRIJXxWYTeIScsDSt2oVmk4vdUOlNgPDs2JXzzXuMla3sNRH1ZKUPmhDYr//YJUI57rAccjdRtUa3OnpHtp2OivGKdrrgYhL+kDDNu6NpZxISEzn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790501382; c=relaxed/simple;
	bh=IFnVrC7cOmYnwsVUuV+ximSvsG8lyZd9rCyAvXxT+kw=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=j1q/VSF3HvkcGSSk10ZdPY+OOTF1WdHEY/BUMC8MyLIt86IcRsxEjmN9NrLfBnTCjJmiu62hUTkC6cXKNzoyhg5XOQlflwyqvHPX41L+iFy37m8i0Nz5M/NYwPF5OZz23vOSPwBBTMVWYrym9Y768yPGCKS7P05U5co6y5qn6wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J9oCRj5/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J9oCRj5/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06B621F000FF;
	Sun, 27 Sep 2026 09:29:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790501380;
	bh=INavZqeMc0eO79yHUbiOt6/BYPBdvZYebGmXYLddT6k=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=J9oCRj5/vYAvbUhX/S4umkjI9p3UllemN0NrOCqWLldFTzh60d9k8IsCRWShZC1RG
	 VF0Dhl1HU0wnpFnwi2pXO/YDEQeti2SwyS9+zrUDAq7GQnJ6MatyaPcqn4d8JVKzHn
	 iuDC9pHc5x9/NzcCAfzOJk1B7+I3UkD9vcejnn3pISmJm6RrBaEFFxR9gVsufJ5yrC
	 wz3WU18dkR8KmP4OkBa86G36p6m1gUE0xMa0l2xmZ2X1ez+dq2zNqDLxCdennubyhF
	 +HxyzN+WYJGtWUPSnSOFOzguMuGBJ5VSf4VMukDGMZYcqoMPC+scF1drkHPp7YTmgF
	 LsSvTS97hLPjQ==
Subject: Re: [PATCH net v3] net: stmmac: fix rx Scatter-Gather support
From: netdev-bot+sashiko@kernel.org
To: lorenzo.bianconi@oss.qualcomm.com
Cc: maxime.chevallier@bootlin.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
 Jose.Abreu@synopsys.com, ast@kernel.org, daniel@iogearbox.net,
 hawk@kernel.org, john.fastabend@gmail.com, sdf@fomichev.me,
 netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org
Date: Sun, 27 Sep 2026 09:29:38 +0000
Message-ID: <179050137856.2160803.6310706653062051206@kernel.org>
In-Reply-To: <20260923-stmmac-rx-sg-fix-v3-1-ed26fea7180d@oss.qualcomm.com>
References: <20260923-stmmac-rx-sg-fix-v3-1-ed26fea7180d@oss.qualcomm.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 5 potential
issue(s) to consider.

Critical: 0 · High: 3 (2) · Medium: 1 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The new XDP FCS strip in stmmac_rx() (`if
  (stmmac_xdp_is_enabled(priv) && !buf2_len) { buf1_len -= ETH_FCS_LEN;…
- [High] The page_pool sync length no longer matches its offset base on
  the XDP_CONSUMED path.
- [High] Out-of-bounds buffer2 fragment after an XDP_TX/REDIRECT verdict
  in the middle of a frame.
- [Medium] stmmac_rx() removes the FCS with the wrong length when XDP has
  changed the frame.
- [Low] Some new or kept comments do not match the code.

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but the same
  unbacked buffer2 DMA destination is still reachable on AF_XDP zero-…
- [High] This problem wasn't introduced by this patch, but in
  stmmac_rx(), when napi_build_skb() fails, buf->page is returned to the…

--

net: stmmac: fix rx Scatter-Gather support

This patch enables the secondary RX buffer (buffer2) for non-SPH frames on
GMAC4/XGMAC cores. Frames larger than dma_buf_sz should then no longer spill
into an unmapped address. It also moves the page_pool sync window to page
offset 0, and strips the FCS by trimming the assembled skb with pskb_trim()
(or from the XDP buffer for single-buffer frames).

> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index d5a984ad864f2..36ecd32921c8e 100644
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

[Severity: Low]
This isn't a bug, but is "buffer2 is never handed to the hardware there"
accurate? In ring mode with dma_buf_sz == BUF_SIZE_16KiB, legacy cores do
program DES3 as a second buffer in ring_mode.c:

    static void init_desc3(struct dma_desc *p)
    {
            p->des3 = cpu_to_le32(le32_to_cpu(p->des2) + BUF_SIZE_8KiB);
    }

refill_desc3() does the same thing.

The comments in stmmac_rx_buf2_len() have the same problem. The
"/* GMAC4 or last descriptor */" label no longer matches the new condition,
because the code after it now runs for GMAC4 with SPH active, or for the
last descriptor. The block comment above it still says "'plen - len' always
gives the correct length of buf2", but the patch adds a clamp there.

> +	return priv->hw->desc && priv->hw->desc->set_sec_addr;
> +}

[ ... ]

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

[Severity: High]
Does the XDP_CONSUMED recycle path still sync the right range after this
change?

With XDP loaded, stmmac_xdp_set_prog() forces SPH off:

    priv->sph_active = priv->sph_capable && !stmmac_xdp_is_enabled(priv);

So before this patch, pp_params.offset in XDP mode was always equal to
buf->page_offset.

stmmac_rx() still computes sync_len relative to buf->page_offset:

    sync_len = ctx.xdp.data_end - ctx.xdp.data_hard_start -
               buf->page_offset;
    ...
    page_pool_put_page(rx_q->page_pool,
                       virt_to_head_page(ctx.xdp.data),
                       sync_len, true);

__page_pool_dma_sync_for_device() then syncs starting at the pool offset:

    dma_sync_size = min(dma_sync_size, pool->p.max_len);
    __dma_sync_single_for_device(pool->p.dev, dma_addr + pool->p.offset,
                                 dma_sync_size, pool->p.dma_dir);

With offset now 0, wouldn't this sync [0, sync_len) instead of
[page_offset, page_offset + sync_len)? The last page_offset bytes the CPU
touched would not be cleaned for the device. That is up to 258 bytes, and it
includes the Ethernet header that an XDP_TX program may have rewritten
before the TX ring filled up.

On non-coherent platforms, could a dirty line left there be written back
over the next frame DMA'd into the recycled page? One case is
dma_sync_single_for_cpu() on the unaligned buf->addr, which cleans and
invalidates the first line.

This can happen for XDP_DROP or XDP_ABORTED after the program wrote the
packet, for a failed XDP_REDIRECT, or for XDP_TX with a full TX ring.

[ ... ]

> @@ -5099,7 +5101,7 @@ static inline void stmmac_rx_refill(struct stmmac_priv *priv, u32 queue)
>  				break;
>  		}
>  
> -		if (priv->sph_active && !buf->sec_page) {
> +		if (stmmac_rx_check_buf2_cap(priv) && !buf->sec_page) {
>  			buf->sec_page = page_pool_alloc_pages(rx_q->page_pool, gfp);
>  			if (!buf->sec_page)
>  				break;

[Severity: High]
This isn't a bug introduced by this patch, but it concerns how refill
reuses buf->page. In stmmac_rx(), when napi_build_skb() fails, the page is
recycled but buf->page still points at it:

    skb = napi_build_skb(page_address(buf->page),
                         rx_q->napi_skb_frag_size);
    if (!skb) {
            page_pool_recycle_direct(rx_q->page_pool,
                                     buf->page);
            rx_dropped++;
            count++;
            goto drain_data;
    }

stmmac_rx_refill() only allocates when !buf->page, so it re-arms the
descriptor with the recycled page. The same page also sits in the pool's
direct cache, and the next page_pool_alloc_pages() can hand it out again.

Refill now also allocates sec_page for every consumed secondary buffer on
GMAC4/XGMAC, which makes that reuse more likely. Can two descriptors end up
DMAing into the same page, with both owners later recycling it?

Should buf->page be set to NULL after page_pool_recycle_direct()?

> @@ -5110,10 +5112,8 @@ static inline void stmmac_rx_refill(struct stmmac_priv *priv, u32 queue)
>  		buf->addr = page_pool_get_dma_addr(buf->page) + buf->page_offset;
>  
>  		stmmac_set_desc_addr(priv, p, buf->addr);
> -		if (priv->sph_active)
> -			stmmac_set_desc_sec_addr(priv, p, buf->sec_addr, true);
> -		else
> -			stmmac_set_desc_sec_addr(priv, p, buf->sec_addr, false);
> +		stmmac_set_desc_sec_addr(priv, p, buf->sec_addr,
> +					 stmmac_rx_check_buf2_cap(priv));

[Severity: High]
This is a pre-existing issue, and the commit message already says AF_XDP
zero-copy is not covered. Still, the same unbacked buffer2 can be reached
on XGMAC ZC queues. stmmac_rx_refill_zc() does:

    stmmac_set_desc_sec_addr(priv, rx_desc, 0, false);

and dwxgmac2_set_sec_addr() ignores is_valid:

    static void dwxgmac2_set_sec_addr(struct dma_desc *p, dma_addr_t addr, bool is_valid)
    {
            p->des2 = cpu_to_le32(lower_32_bits(addr));
            p->des3 = cpu_to_le32(upper_32_bits(addr));
    }

stmmac_set_queue_rx_buf_size() gives a ZC queue a buffer size of
xsk_pool_get_rx_frame_size(), which is about 3840 bytes with 4 KiB chunks.
XGMAC_CORE_INIT_RX accepts frames up to 16368 bytes.

On a ZC queue, would a frame that overflows buffer1 be written to DMA
address 0? That would give the same SMMU fault this patch fixes, or a write
to physical address 0 on systems without an IOMMU.

[ ... ]

> @@ -5190,14 +5193,15 @@ static unsigned int stmmac_rx_buf2_len(struct stmmac_priv *priv,
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

[Severity: High]
buffer2 is now enabled in non-SPH mode, which is always the case with XDP
loaded. Can this return more than dma_buf_sz?

When the XDP program returns TX or REDIRECT on a non-last descriptor,
stmmac_rx() does:

    } else if (xdp_res & (STMMAC_XDP_TX |
                          STMMAC_XDP_REDIRECT)) {
            xdp_status |= xdp_res;
            buf->page = NULL;
            skb = NULL;
            count++;
            continue;
    }

The top of the loop then resets len to 0 even though the frame isn't
finished. The next descriptor is handled as a new frame, and on the last
descriptor plen - len is no longer limited to one descriptor.

For example, take GMAC4 with dma_buf_sz 1536 and a 6000 byte frame. desc0
is transmitted, and desc1 (the last one) gets buf1_len 1536 and buf2_len
4464.

If XDP then returns PASS for that chunk, stmmac_rx() does:

    dma_sync_single_for_cpu(priv->device, buf->sec_addr,
                            buf2_len, dma_dir);
    skb_add_rx_frag(skb, skb_shinfo(skb)->nr_frags,
                    buf->sec_page, 0, buf2_len,
                    priv->dma_conf.dma_buf_sz);

sec_page is an order-0 page here. Wouldn't the fragment run past the end of
the page, so that adjacent memory and stale pool contents reach the stack?
GMAC4 accepts frames up to about 9018 bytes with JE set, and XGMAC up to
16368.

Before this patch, buf2_len was always 0 without SPH.

[ ... ]

> @@ -5809,24 +5814,25 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
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
> +			if (stmmac_xdp_is_enabled(priv) && !buf2_len) {
> +				buf1_len -= ETH_FCS_LEN;
> +				fcs_stripped = true;
> +			}

[Severity: High]
Is buf1_len guaranteed to be at least ETH_FCS_LEN here, and is this always
the last descriptor?

On GMAC4/XGMAC, an XDP_CONSUMED verdict on a non-last descriptor does goto
read_again with skb = NULL, and len keeps the bytes counted so far. The next
descriptor then enters this block as if it were a new frame.

Take a frame of n * 2 * dma_buf_sz + r bytes with r = 1..3, for example 3073
to 3075 bytes with dma_buf_sz 1536. The last descriptor gets
buf1_len = min(dma_buf_sz, plen - len) = r from stmmac_rx_buf1_len() and
buf2_len = 0, so this subtraction wraps:

    buf1_len -= ETH_FCS_LEN;

xdp_prepare_buff() then gets data_end < data, and on XDP_PASS this passes a
value around 0xfffffffd to skb_put():

    buf1_len = ctx.xdp.data_end - ctx.xdp.data;
    ...
    skb_put(skb, buf1_len);

Could this send an skb with len around 4 GiB to eth_type_trans() and the IP
stack, where later trims can put the tail past the napi frag?

On legacy cores without set_sec_addr, stmmac_rx_buf2_len() returns 0 for
every descriptor, so !buf2_len doesn't mean last descriptor there either.
Wouldn't the first descriptor of a multi-descriptor frame lose 4 bytes of
payload, and the final pskb_trim() then be skipped so the real FCS stays at
the tail?

Before this patch the strip only happened on the last descriptor. buf1_len
there was min(dma_buf_sz, plen), so it could not be 1..3.

> +
>  			xdp_init_buff(&ctx.xdp, bufsz, &rx_q->xdp_rxq);
>  			xdp_prepare_buff(&ctx.xdp, page_address(buf->page),
>  					 buf->page_offset, buf1_len, true);
> @@ -5926,6 +5932,15 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
>  
>  		/* Got entire packet into SKB. Finish it. */
>  
> +		/* Remove FCS if needed */
> +		if (!fcs_stripped && pskb_trim(skb, len)) {

[Severity: Medium]
Does len still match the skb here when an XDP program has changed the size
of the frame?

For a frame that uses buffer2 on the first descriptor, fcs_stripped stays
false. On XDP_PASS the skb head is built from the adjusted XDP boundaries:

    buf1_len = ctx.xdp.data_end - ctx.xdp.data;
    ...
    skb_reserve(skb, head_pad_len);
    skb_put(skb, buf1_len);

len, however, comes only from the descriptor lengths minus ETH_FCS_LEN. It
never includes the bpf_xdp_adjust_head() or bpf_xdp_adjust_tail() delta.

pskb_trim() takes an absolute length and does nothing when len >= skb->len:

    return (len < skb->len) ? __pskb_trim(skb, len) : 0;

So wouldn't a program that pushes N bytes lose N bytes of payload from the
tail? And wouldn't one that pulls or shrinks by 4 or more bytes leave the
FCS in place?

Would pskb_trim(skb, skb->len - ETH_FCS_LEN) be more robust here?

> +			dev_kfree_skb_any(skb);
> +			skb = NULL;
> +			rx_dropped++;
> +			count++;
> +			continue;
> +		}

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260923-stmmac-rx-sg-fix-v3-1-ed26fea7180d%40oss.qualcomm.com
