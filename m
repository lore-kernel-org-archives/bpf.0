Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AC4537F727;
	Thu,  8 Oct 2026 22:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791497031; cv=none; b=ljfwDgyZ4EUoVoQcUZADxBywfhTCl7YmT7jl7hVunD0DFeXSpi8/IWe/jBy2vDTTUr2pE7M4ojyxBjwtyfRRVFI6hUiWPZjINnBkIAgv7UvuEQ+qdAcjRcEbLamJLt1Q9P/Qhe7k5BdBYXdWA7JC0PXFgYMTcjJDYMnk2CZsFWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791497031; c=relaxed/simple;
	bh=85aRWqim8zIrqoeVHE1j6Tc/Re6ohlXV3CZG7oB9jME=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZQSAVkZDJZBd+dUK1l1PHL0EVns/GNJGFJ33xYRmyPnOYpeSy9YEhajggHbr2i4dNBAZLM2GfvTXCnTZO0Jd1lDRkXAYRaMTtki9sHuDO9mQCA/AKfEVrSNYp77guDD+r6w1ETHNEWSe7MoYXptJEetHA4wUEyCn8iP5hg++og4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kJShRurT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kJShRurT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C19631F000FF;
	Thu,  8 Oct 2026 22:03:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791497029;
	bh=M9TqBZxaUzksUyOlcNYVIPYjBwH9t5EqBxtLbuk/h/s=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=kJShRurTZI0qoySyHOdc5/xqt7gNcTAUv+p67pWEltQh1qgfwx2glUECgE8rYDvbH
	 i5Fu4DRx4MoXpvEANrncPzPsRn6SZBzDqjnSalIOyUad9FWuazlWAvaH7yd1uk5F9y
	 VOxR+bXfCInDdgiJDMwiYANHBrcs60yV6eWbg1oZsc+S64QONqnWQ/YTeLUU7qIuN0
	 JlwPGGAiqEjoQCop0d/ec5x1GVKtXAXi/Y8KUSxijPWMKMBjy6ihvjS0jxbF+OE7c7
	 t0sDjoPl829SrM87I+2f4MVFxXBYCRz8pGBEvSsH+K3LIzW5nOil6ZA6wScYiipdAo
	 kF2dbtEnkXEAw==
Subject: Re: [PATCH net-next v4 1/2] net: stmmac: take ownership of saved RX
 state at poll entry
From: netdev-bot+sashiko@kernel.org
To: lorenzo.bianconi@oss.qualcomm.com
Cc: maxime.chevallier@bootlin.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com, ast@kernel.org,
 daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
 sdf@fomichev.me, Jose.Abreu@synopsys.com, boon.leong.ong@intel.com,
 netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org
Date: Thu, 08 Oct 2026 22:03:48 +0000
Message-ID: <179149702833.434549.9158656960490952093@kernel.org>
In-Reply-To: <20261006-stmmac-rx-mb-v4-1-efa4ca974e3d@oss.qualcomm.com>
References: <20261006-stmmac-rx-mb-v4-1-efa4ca974e3d@oss.qualcomm.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 0 (2) · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] At this commit, stmmac_rx() handles an XDP non-PASS verdict
  (STMMAC_XDP_CONSUMED, plus TX/REDIRECT) with `goto next` even when the…
- [Low] The commit message suggests that releasing the saved partial skb
  at teardown already existed.

Pre-existing issues:
- [Medium] In stmmac_rx_zc(), the 'XSK pool expects RX frame 1:1 mapped
  to XSK buffer' branch handles a non-last descriptor (rx_not_ls) by…
- [Medium] In stmmac_rx() at this commit, if napi_build_skb() fails on a
  first descriptor that has rx_not_ls set, the code recycles the page,…

--

net: stmmac: take ownership of saved RX state at poll entry

This patch changes stmmac_rx() and stmmac_rx_zc() so that each poll takes
the saved partial-frame state at entry and clears it right away. The state
is saved again only if the frame is still incomplete. The saved skb is also
freed, and state_saved cleared, in stmmac_reset_rx_queue() and
__free_dma_rx_desc_resources().

> The saved state is also dropped when the queue parameters are reset, not
> only when the ring is destroyed: stmmac_reset_rx_queue() is reached from
> __stmmac_open(), stmmac_xdp_open(), stmmac_resume() and
> stmmac_enable_rx_queue(). Otherwise a partial frame saved before suspend
> (or before a queue is disabled and re-enabled) survives while cur_rx and
> dirty_rx are re-armed, and the first poll resumes that stale skb with
> descriptors from the freshly initialized ring. Teardown still releases it
> in __free_dma_rx_desc_resources().

[Severity: Low]
Is the last sentence accurate? Before this patch,
__free_dma_rx_desc_resources() did not free rx_q->state.skb or clear
rx_q->state_saved. Nothing outside stmmac_rx() referenced state.skb.

The first hunk of this patch is what adds the teardown release:

+	dev_kfree_skb_any(rx_q->state.skb);
+	rx_q->state.skb = NULL;
+	rx_q->state_saved = false;

That hunk seems to fix a separate problem. A partial skb leaked on close or
MTU change. A stale state_saved/state.skb also survived
stmmac_disable_rx_queue() and stmmac_enable_rx_queue() after the page_pool
had been destroyed.

Could the commit message describe this as part of the fix, rather than as
existing behaviour?

> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index 0cfd14d240022..28e9f8438f93f 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c

[ ... ]

> @@ -5665,6 +5672,7 @@ static int stmmac_rx_zc(struct stmmac_priv *priv, int limit, u32 queue)
>  
>  		if (unlikely(error && (status & rx_not_ls)))
>  			goto read_again;
> +
>  		if (unlikely(error)) {
>  			count++;
>  			continue;

[Severity: Medium]
This is a pre-existing issue, not one introduced by this patch. It is in
the continuation handling this patch reworks. Just below, a non-last
descriptor is handled like this:

		/* XSK pool expects RX frame 1:1 mapped to XSK buffer */
		if (likely(status & rx_not_ls)) {
			xsk_buff_free(buf->xdp);
			buf->xdp = NULL;
			dirty++;
			count++;
			goto read_again;
		}

This branch sets neither error nor len. Won't the last descriptor of the
frame then pass both error checks with len still 0?

In that case, stmmac_rx_buf1_len(priv, p, status, 0) returns
min(dma_buf_sz, plen). For a multi-descriptor frame that is dma_buf_sz.
The tail is then run through XDP and delivered as a complete frame,
either by XDP_PASS through stmmac_dispatch_skb_zc() or by redirect to the
XSK. That frame starts in the middle of the real frame and is padded with
stale UMEM bytes.

The same thing happens across polls. The save at the end of stmmac_rx_zc()
records state.error = 0 and state.len = 0 for this continuation.

Should the rest of this frame be marked for discard here?

[ ... ]

> @@ -5909,24 +5922,12 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
>  							   sync_len, true);
>  					buf->page = NULL;
>  					rx_dropped++;
> -
> -					/* Clear skb as it was set as
> -					 * status by XDP program.
> -					 */
> -					skb = NULL;
> -
> -					if (unlikely((status & rx_not_ls)))
> -						goto read_again;
> -
> -					count++;
> -					continue;
> +					goto next;

[Severity: High]
Before this change, an STMMAC_XDP_CONSUMED verdict on a descriptor with
rx_not_ls set went back to read_again and kept the running len. Now it
jumps to next:, which does this:

next:
		in_progress = false;
		skb = NULL;
		count++;

The top of the loop then resets the length:

		if (!in_progress) {
			skb = NULL;
			error = 0;
			len = 0;
		}

Doesn't this make the remaining descriptors of the same hardware frame get
parsed as a new frame? The STMMAC_XDP_TX/STMMAC_XDP_REDIRECT branch below
also reaches next: in the same state.

Here is an example on a core with buf2 (dwmac4/xgmac, dma_buf_sz = 1536,
order-0 sec_page). Jumbo frames are accepted there because GMAC_CORE_INIT
includes GMAC_CONFIG_JE. Take a 9000 byte frame whose first descriptor is
dropped by XDP:

  - The second descriptor is treated as a frame start, which leaves len at
    3072.
  - On the last descriptor, stmmac_rx_buf1_len() returns 1536.
  - stmmac_rx_buf2_len() then returns 9000 - 4608 = 4392 from this line:

	return plen > len ? plen - len : 0;

Would skb_add_rx_frag() on buf->sec_page with 4392 bytes then cover more
than the 4096 byte page? Only 1320 of those bytes are valid, so stale
page_pool data would reach the stack.

Mid-frame data would also go to XDP and to the stack as a separate frame.

The follow-up commit "net: stmmac: rework stmmac_rx to support XDP rx
multi-buff" seems to address this, since it runs XDP only after the last
descriptor. This patch has Fixes: tags and could be backported on its own.
Could the rx_not_ls continuation for the STMMAC_XDP_CONSUMED case be kept
in this patch?

[ ... ]

> @@ -5983,10 +5984,8 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
>  		/* Remove FCS if needed */
>  		if (!fcs_stripped && pskb_trim(skb, len)) {
>  			dev_kfree_skb_any(skb);
> -			skb = NULL;
>  			rx_dropped++;
> -			count++;
> -			continue;
> +			goto next;
>  		}
>  
>  		stmmac_get_rx_hwtstamp(priv, p, np, skb);

[Severity: Medium]
This isn't a bug introduced by this patch, but there is a related frame
boundary problem earlier in stmmac_rx(). Suppose napi_build_skb() fails on
the first descriptor of a frame that has rx_not_ls set:

			skb = napi_build_skb(page_address(buf->page),
					     rx_q->napi_skb_frag_size);
			if (!skb) {
				page_pool_recycle_direct(rx_q->page_pool,
							 buf->page);
				buf->page = NULL;
				rx_dropped++;
				count++;
				goto drain_data;
			}
	...
drain_data:
		if (likely(status & rx_not_ls))
			goto read_again;

When the code goes back to read_again, error is still 0 and skb is NULL.
Won't the next descriptor of the same frame take the !skb path again? That
would run XDP on mid-frame data and build a new skb from the remaining
fragments.

If that second allocation succeeds, a truncated frame is delivered. The
pskb_trim(skb, len) check above doesn't catch it, because pskb_trim()
returns 0 when len is larger than skb->len:

	return (len < skb->len) ? __pskb_trim(skb, len) : 0;

The follow-up commit "net: stmmac: rework stmmac_rx to support XDP rx
multi-buff" removes this path. It calls stmmac_build_skb() only after the
last descriptor and sends failures to error_free_frag.

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261006-stmmac-rx-mb-v4-0-efa4ca974e3d%40oss.qualcomm.com
