Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795704631;
	b=Cd8NUnNJO3Yb22ONx35nJ224+n/Y9SIjrA4IvYg/uKpMKEBHGM4NO11RYfcP7bOmDGbB
	 VWr+vwkvmYk3TSxWYUE6FGz7KENKrnIT/+aiPDyAMYp1BgsA6V4Tflv1OysvkRjp4v32t
	 Sn2wJdX77ovZPK3iCDtGeflUR32JVJevgJGcVnh6S1yVZRXhD0GM4D1LvKnxn5+2Tnlw5
	 cuiw8QVQh/j0xWGEhYfCbSTlK676qjeFj+J4mJAx+Lq9B2y+QNveq2o3506YauY+TNQWd
	 yfV/CdzF21kaLFqL6QB5HaUSgg3B4Twj45aGf2DmbvMc8Gz30xWqP/kCSUm9na2DEgQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795704631;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=tU3UXJgwi6ZtFFA0yj6phXlxRTX8RBgqFHdyXavkSKY=;
	b=d+iAoC/ydA9F/yavgUWf30HLQFdASf5C9zpl+tQVeYSX0mjtIvXJvtrILllhwgV51Tdv
	 2HOY21APTmobubx5/EfZTG2ehZKCpDJQ3Zy5oSsHipTI+69ppbIbdHLig9WktyaJiY5RJ
	 oULuQDB9hf3JqSc4w0oQOOX5JN36ijMTp4+7YsXMEMdI8xBnQb5qjehk4SLxWkLTXZ8FU
	 w1f20hI/foqU8cFCsJ1FDmNMwyrkyE+zMc35Pd+IMK3s76qyISgk+rhlooUMFKD2x3V/F
	 J+fe+vE2n6Fp/5vAhjQsg9Xi9U5a/3aXqDKYSWB2NYv83WxWYxQECBvcj8k0wp4Pixw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=b8dLbiGh;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15B1B606A329;
	Thu, 26 Nov 2026 14:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=b8dLbiGh
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 362E61F000C6;
	Thu, 26 Nov 2026 14:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795704630;
	bh=tU3UXJgwi6ZtFFA0yj6phXlxRTX8RBgqFHdyXavkSKY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=b8dLbiGh4UnheWOuB4pacuOD2yW26oLEacXbPYb71h7Wsn3zofScGjXdt/MFURPKl
	 ZvG15626NYEMQeZ0RVE3pxmznKLOIIRZoOLSeKk/zCdPlvJutRfnJCG+0FTqAcFSe6
	 9ronHxyoVMh51ztnk9wL4ixBhln/7DuL0E3h5QfhQ0eBzsXeLazhw9bO8Uv3YeKTcQ
	 AHtLALwK/vOxikVj41ng5t7D3uRQkplVdakocaNdnHCRcZqKWqUBKOQl/EJh24Lka2
	 3brL46lJc1ffJRaVfei0uEf/NP+CBebLtZpUdWgyDp4ipd/DT5u2K5kasx6N5tYt7v
	 J6laNAAp9b60A==
Subject: Re: [PATCH net-next v13 5/5] net: stmmac: rework stmmac_rx to support
 XDP rx multi-buff
From: netdev-bot+sashiko@kernel.org
To: lorenzo.bianconi@oss.qualcomm.com
Cc: maxime.chevallier@bootlin.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com, ast@kernel.org,
 daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
 sdf@fomichev.me, Jose.Abreu@synopsys.com, boon.leong.ong@intel.com,
 horms@kernel.org, andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com,
 martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
 jolsa@kernel.org, emil@etsalapatis.com, ihor.solodrai@linux.dev,
 matthew.gerlach@altera.com, boon.khai.ng@altera.com, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org, nb@tipi-net.de
Date: Thu, 26 Nov 2026 14:50:28 +0000
Message-ID: <179570462877.3135.11557910879568810263@kernel.org>
In-Reply-To: <20261125-stmmac-rx-mb-v13-5-0f6bac53e8d5@oss.qualcomm.com>
References: <20261125-stmmac-rx-mb-v13-5-0f6bac53e8d5@oss.qualcomm.com>
X-sashiko-severity: Low
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

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] In stmmac_rx()
  (drivers/net/ethernet/stmicro/stmmac/stmmac_main.c:6056), the FCS is…

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but the patch
  extends it.

--

net: stmmac: rework stmmac_rx to support XDP rx multi-buff

This reworks stmmac_rx() to collect all the descriptors of a frame in an
xdp_buff. XDP programs loaded with BPF_F_XDP_HAS_FRAGS now see the whole
fragmented packet, and the skb is built with xdp_build_skb_from_buff().
The in-progress xdp_buff is saved in rx_q->state across NAPI polls, and
the FCS is stripped with xdp_buff_shrink_tail().

> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index 7896364c43e95..56355d80ba161 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c

[ ... ]

> @@ -5999,120 +6014,79 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)

[ ... ]

> +		n_descs++;
>  
> -drain_data:
>  		if (likely(status & rx_not_ls))
>  			goto read_again;
> -		if (!skb)
> -			goto next;
>  
> -		/* Got entire packet into SKB. Finish it. */
> +		/* ACS is disabled; strip manually. */
> +		len -= ETH_FCS_LEN;
> +		if (xdp_buff_shrink_tail(&ctx.xdp, ETH_FCS_LEN)) {
> +			if (!error)
> +				rx_dropped++;
> +			error = 1;
> +		}

[Severity: Low]
Is skb->truesize overstated when a frame spans several buffers and the
last buffer holds only FCS bytes (1 to 4 bytes)?

For a fragmented xdp_buff, xdp_buff_shrink_tail() calls
xdp_frags_shrink_tail(). That function returns the FCS-only page to the
pool through xdp_buff_shrink_data(), but it only adjusts nr_frags and
xdp_frags_size:

net/core/xdp.c:xdp_frags_shrink_tail() {
    ...
	sinfo->nr_frags -= n_frags_free;
	sinfo->xdp_frags_size -= len_free;
    ...
}

sinfo->xdp_frags_truesize still counts the xdp->frame_sz that
stmmac_build_xdp_frags() charged for that page through
xdp_buff_add_frag(). If at least one fragment is left,
xdp_build_skb_from_buff() uses that value unchanged:

net/core/xdp.c:xdp_build_skb_from_buff() {
    ...
		tsize = sinfo->xdp_frags_truesize ? : nr_frags * xdp->frame_sz;
    ...
}

As a result, skb->truesize includes a full page_pool allocation
(PAGE_SIZE << order) for a page that has already been released.

In the common case the old code fixed this up. pskb_trim(), removed
below, went through ___pskb_trim()->skb_condense() (skb->sk is NULL on
RX), which pulled small leftover frags into the head and recomputed
truesize.

The commit message says the new truesize "is more accurate". Does that
hold for this case?

>  
> -		/* Remove FCS if needed */
> -		if (!fcs_stripped && pskb_trim(skb, len)) {
> -			dev_kfree_skb_any(skb);
> -			rx_dropped++;
> +		if (unlikely(error))
> +			goto error_free_frag;
> +
> +		ctx.desc = p;
> +		ctx.ndesc = np;
> +
> +		skb = stmmac_xdp_run_prog(priv, &ctx.xdp);
> +		/* For Not XDP_PASS verdict */
> +		if (IS_ERR(skb)) {
> +			unsigned int xdp_res = -PTR_ERR(skb);
> +
> +			if (xdp_res & STMMAC_XDP_CONSUMED) {
> +				__xdp_return_buff(&ctx.xdp, true);
> +				rx_dropped++;
> +			} else if (xdp_res & (STMMAC_XDP_TX |
> +					      STMMAC_XDP_REDIRECT)) {
> +				xdp_status |= xdp_res;
> +			}
>  			goto next;
>  		}

[Severity: High]
This issue was not introduced by this patch, but the patch makes it
wider. With the stmmac_xdp_run_prog() change, programs with
xdp_has_frags can now return XDP_TX on fragmented buffs. Is the direct
recycling done when the TX completes safe here?

stmmac_tx_clean() returns XDP_TX frames like this:

drivers/net/ethernet/stmicro/stmmac/stmmac_main.c:stmmac_tx_clean() {
    ...
		if (xdpf &&
		    tx_q->tx_skbuff_dma[entry].buf_type == STMMAC_TXBUF_T_XDP_TX) {
			xdp_return_frame_rx_napi(xdpf);
    ...
}

xdp_return_frame_rx_napi() calls __xdp_return() with napi_direct set to
true. That path ends in page_pool_recycle_in_cache(), which writes
pool->alloc.cache[pool->alloc.count++] with no locking.

stmmac_tx_clean() runs from stmmac_napi_poll_tx() on ch->tx_napi. That
is not the ch->rx_napi which owns and refills rx_q->page_pool.

stmmac_xdp_xmit_back() also picks the TX queue by CPU through
stmmac_xdp_get_tx_queue(priv, smp_processor_id()). The completion can
therefore run on a different channel's tx_napi.

The pool is created without pp_params.napi, so page_pool has no way to
detect the foreign context.

Some setups put the two NAPI contexts on different CPUs:

  - MSI with independent rx/tx IRQ affinity, for example 4 RX and 2 TX
    queues on 4 CPUs
  - irqbalance
  - threaded NAPI
  - busy polling

In those setups rx_napi can pop from pool->alloc.cache while tx_napi
pushes into it from another CPU. With this patch, rx_napi uses that
cache more, through __xdp_return_buff(&ctx.xdp, true) and
page_pool_put_full_page(..., true).

Could the racing alloc.count updates lose a page, so that the pool never
drains? Could they also hand the same page out twice, so that two RX
descriptors DMA into it, or a page is DMA-written while the stack still
owns it?

This race already exists for head pages. With fragmented XDP_TX,
xdp_return_frame_rx_napi() now also direct-recycles every fragment page
from that context.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261125-stmmac-rx-mb-v13-0-0f6bac53e8d5%40oss.qualcomm.com
