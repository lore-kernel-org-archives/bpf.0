Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51CFB384CE9;
	Sat, 10 Oct 2026 10:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791629848; cv=none; b=HWiEK9mIJOWcrHWvhIEraCMwFyeSLAdkTaD92aTeU+fTNodWRlW1WbAmKWj89ri10i7cuW+rlND9I5fjJL7H65wi7OQJwLwQljcutztBbTew2xXv765WiQsuO5/UcovNwLiBSGb8L1TB1jODpBGgVOdfEalx7dU5Acklm9H7VOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791629848; c=relaxed/simple;
	bh=cwm5DNwAu0CDUpLqJsDDo8rUGTGKkOUxW/yV/9FZ6Xs=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nnr4s7pWRm0EYBLmd8GaBwkRJAQnD6dka6zduh+JHG9QZ5BZkixIJDrlF0abddOeA9OmsLYTK7It7jl8qqlif3/a5229FdaViOArRNm9V0kzg83PowYKJe5m/r5q4LZYjnmD0uP2JQadLWAN/T5IEzXUyizfNng5tYtEROiI4Gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kkqbBt7y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kkqbBt7y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBD8E1F000FF;
	Sat, 10 Oct 2026 10:57:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791629847;
	bh=a7k3/CAsEeS2L41xv7Fo+0FZ409bJISrc+W99HD0fHo=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=kkqbBt7y29ZJYSw6CQ8z8mR83Ms5C1LwbHBcfoncdh1R3XWP1GGlofCjMRzqGPiDQ
	 mETTEnDWMPR0xbs00ykL/XPQb5S3Bc7MNeAJAHhMc41qCZYbP0sEmsoBbJh4yOPzqc
	 8rwbA8STV0YRl5ergnM7ydNXkdJUjZxR3uAQ8LJhD/TlN7Dtz6S8mEyVTiQVJJbvVZ
	 r0gCOvu5b20kgOY+Tsr5bt0wPOXn/b2n+TAyMmmUfpFx0qdjrVFAqBMK2S02qJYeiJ
	 +mpO0HRkFhsI3KUaFD93ChtQEBucd2G+jm79fAH8lwGJmeCir2O9xmS0CwqbtdAc9w
	 w13D7JJ/VcX8g==
Subject: Re: [PATCH net-next v5 1/3] net: stmmac: take ownership of saved RX
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
Date: Sat, 10 Oct 2026 10:57:25 +0000
Message-ID: <179162984531.434549.17106244500953312801@kernel.org>
In-Reply-To: <20261009-stmmac-rx-mb-v5-1-c38fa4eaa138@oss.qualcomm.com>
References: <20261009-stmmac-rx-mb-v5-1-c38fa4eaa138@oss.qualcomm.com>
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

Critical: 0 · High: 2 (2) · Medium: 0 (1) · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] At this commit, stmmac_rx() can still treat the middle or last
  descriptor of one hardware frame as the start of a new frame.
- [High] bpf: packet injection via dropped jumbo frames in stmmac_rx_zc

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but it sits in the
  stmmac_rx_zc() continuation logic this patch changes, and it is still…
- [High] This problem wasn't introduced by this patch, but this patch's
  resume handling relies on it and the commit message describes the…
- [Medium] In stmmac_rx() at this commit, when napi_build_skb() fails on
  a descriptor that is not the last one, the code increments rx_dropped…

--

net: stmmac: take ownership of saved RX state at poll entry

This patch makes stmmac_rx() and stmmac_rx_zc() take the saved
partial-frame state at poll entry and save it again only if the frame is
still incomplete. It also drops the saved state in stmmac_reset_rx_queue()
and __free_dma_rx_desc_resources(). For non-PASS XDP verdicts on non-last
descriptors, both verdicts now go back to read_again and keep the running
frame length.

> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index b8b4de4c5b1a7..6128e6d9504c8 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c

[ ... ]

> @@ -5691,6 +5696,8 @@ static int stmmac_rx_zc(struct stmmac_priv *priv, int limit, u32 queue)
>  		if (!buf->xdp)
>  			break;
>  
> +		in_progress = status & rx_not_ls;
> +
>  		if (priv->extend_desc)
>  			stmmac_rx_extended_status(priv, &priv->xstats,
>  						  rx_q->dma_erx + entry);
> @@ -5705,6 +5712,7 @@ static int stmmac_rx_zc(struct stmmac_priv *priv, int limit, u32 queue)
>  
>  		if (unlikely(error && (status & rx_not_ls)))
>  			goto read_again;
> +
>  		if (unlikely(error)) {
>  			count++;
>  			continue;

[Severity: High]
This is a pre-existing issue, but this patch reworks how
stmmac_rx_zc() carries error and len across descriptors and polls.
Should the dropped-head case be covered here too?

When a frame spans more than one XSK descriptor, the 1:1 mapping
check throws away the non-last descriptors:

		/* XSK pool expects RX frame 1:1 mapped to XSK buffer */
		if (likely(status & rx_not_ls)) {
			xsk_buff_free(buf->xdp);
			buf->xdp = NULL;
			dirty++;
			count++;
			goto read_again;
		}

That path never sets error. When the loop reaches the last descriptor
of the same frame, error is still 0, so both error checks are
skipped. The tail buffer then goes to __stmmac_xdp_run_prog() as if
it were a complete frame.

On XDP_PASS, stmmac_dispatch_skb_zc() builds an skb from it and
passes it up the stack. On XDP_REDIRECT, the AF_XDP socket receives
it.

The tail starts in the middle of the original payload, at an offset
the sender can predict from the RX buffer size. Can an on-link peer
send a jumbo frame (GMAC4 sets GMAC_CONFIG_JE) whose payload holds a
complete Ethernet/IP header at that offset?

The MAC address, VLAN and other hardware filters only check the outer
frame. The kernel would instead receive the crafted inner frame.

With this patch the same state can also cross a poll boundary. If the
budget runs out right after the head is dropped, in_progress is true
and error 0 is saved. The next poll then treats the tail the same
way.

Would setting error = 1 before the goto be enough? The error branches
only free buf->xdp and bump dirty when the current descriptor itself
reports discard_frame. Wouldn't the remaining descriptors of a
dropped frame then keep their XSK buffers and not be counted in
dirty? It looks like the drop path also has to release each
continuation buffer.

Later in the series stmmac_rx() is reworked to collect all
descriptors of a frame. stmmac_rx_zc() keeps this drop path, so the
problem is still present at the end of the series.

[Severity: High]
This is a pre-existing issue, but this patch reworks the continuation
state in stmmac_rx_zc(). Is the multi-descriptor case handled correctly
right after this point?

Non-last descriptors are dropped without setting error and without adding
their bytes to len:

		/* XSK pool expects RX frame 1:1 mapped to XSK buffer */
		if (likely(status & rx_not_ls)) {
			xsk_buff_free(buf->xdp);
			buf->xdp = NULL;
			dirty++;
			count++;
			goto read_again;
		}

So for an error-free frame that spans several XSK descriptors, the
continuation state is always error 0 and len 0. The last descriptor then
reaches:

		buf1_len = stmmac_rx_buf1_len(priv, p, status, len);
		...
		buf->xdp->data_end = buf->xdp->data + buf1_len;

With len 0 and SPH disabled, stmmac_rx_buf1_len() returns
min(dma_buf_sz, plen). Here plen is the total frame length, not the number
of bytes in the last buffer.

Doesn't that make data_end cover stale UMEM bytes past the real tail? If
the XSK rx frame size is smaller than dma_buf_sz, can it even point past
the chunk?

On XDP_PASS, stmmac_dispatch_skb_zc() copies this into an skb. When coe is
set and the ethertype is IP, it sets CHECKSUM_UNNECESSARY without checking
csum_none. On REDIRECT, the AF_XDP socket gets the same frame.

The head of the frame is dropped, and its tail plus stale data is
delivered as a standalone frame. An on-link peer can trigger this by
sending a frame longer than the XSK rx frame size, because GMAC4 always
sets GMAC_CONFIG_JE. The code is unchanged later in the series.

[ ... ]

> @@ -5950,23 +5963,21 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
>  					buf->page = NULL;
>  					rx_dropped++;
>  
> -					/* Clear skb as it was set as
> -					 * status by XDP program.
> -					 */
> -					skb = NULL;
> -
> -					if (unlikely((status & rx_not_ls)))
> +					if (unlikely((status & rx_not_ls))) {
> +						skb = NULL;
>  						goto read_again;
> -
> -					count++;
> -					continue;
> +					}
> +					goto next;
>  				} else if (xdp_res & (STMMAC_XDP_TX |
>  						      STMMAC_XDP_REDIRECT)) {
>  					xdp_status |= xdp_res;
>  					buf->page = NULL;
> -					skb = NULL;
> -					count++;
> -					continue;
> +
> +					if (unlikely((status & rx_not_ls))) {
> +						skb = NULL;
> +						goto read_again;
> +					}

[Severity: High]
After jumping to read_again with skb == NULL, could the next descriptor of
the same hardware frame still be parsed as a new frame?

In stmmac_rx(), skb == NULL is the only marker for the start of a frame.
The next descriptor therefore enters the frame-start block again:

		if (!skb) {
			...
			/* Each frame starts here: reset the FCS handling */
			fcs_stripped = false;
			...
			if (stmmac_xdp_is_enabled(priv) && !buf2_len) {
				buf1_len -= ETH_FCS_LEN;
				fcs_stripped = true;
			}

			xdp_init_buff(&ctx.xdp, bufsz, &rx_q->xdp_rxq);
			xdp_prepare_buff(&ctx.xdp, page_address(buf->page),
					 buf->page_offset, buf1_len, true);

Because len is now kept, stmmac_rx_buf1_len() returns
min(dma_buf_sz, plen - len) for the last descriptor, and that can be 0 to
3 bytes. For example, on GMAC4 take a 3074-byte frame whose first
descriptor holds 3072 bytes in buf1 + buf2. The last descriptor then
holds 2 bytes.

Can buf1_len -= ETH_FCS_LEN then wrap to 0xFFFFFFFE, so that
xdp_prepare_buff() sets data_end = data - 2?

Suppose the XDP program returns XDP_PASS for that continuation. buf1_len
is recomputed as data_end - data and passed to skb_put(skb, buf1_len).
The tail wraps to below end, so skb_over_panic() does not fire. An skb
with len close to 4GB then goes to eth_type_trans() and the stack, with
no FCS trim because fcs_stripped is set.

If the continuation holds 4 or more bytes, the tail of a dropped or
redirected frame is instead shown to XDP as a standalone Ethernet frame,
and delivered on PASS.

The XDP_CONSUMED branch above already worked this way, and this change
puts XDP_TX and XDP_REDIRECT on the same path. The commit message says:

    Resetting the frame state there makes the
    remaining descriptors of the same hardware frame get parsed as a new
    frame

Isn't that still the case after this patch?

Later in the series, "net: stmmac: rework stmmac_rx to support XDP rx
multi-buff" collects the whole frame into an xdp_buff, runs XDP only at
the last descriptor, and strips the FCS with stmmac_xdp_shrink_tail().
That resolves this. Since this patch carries Fixes: tags, could it be
backported without that rework?

> +					goto next;
>  				}
>  			}
>  		}

[ ... ]

> @@ -6023,10 +6034,8 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
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

[Severity: Medium]
This isn't a bug introduced by this patch, but what happens here if
napi_build_skb() failed on an earlier non-last descriptor of the same
frame?

That path leaves skb NULL and does not set error:

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

Because rx_not_ls is set, drain_data goes back to read_again. The next
descriptor then builds a new skb from the remaining mid-frame bytes.

This also works across a budget boundary. The saved state is in_progress
with skb NULL, error 0 and a nonzero len.

At the last descriptor, pskb_trim(skb, len) gets the full frame length.
That is larger than skb->len, so it returns 0 without trimming.

Doesn't that hand napi_gro_receive() a truncated frame that starts with
mid-frame payload and still carries the FCS? Doesn't it also over-count
rx_bytes?

This path goes away later in the series with "net: stmmac: rework
stmmac_rx to support XDP rx multi-buff". There, stmmac_build_skb() is
only called at the last descriptor, and a failure goes to error_free_frag.

[ ... ]

> @@ -8378,6 +8388,9 @@ static void stmmac_reset_rx_queue(struct stmmac_priv *priv, u32 queue)
>  {
>  	struct stmmac_rx_queue *rx_q = &priv->dma_conf.rx_queue[queue];
>  
> +	dev_kfree_skb_any(rx_q->state.skb);
> +	rx_q->state.skb = NULL;
> +	rx_q->state_saved = false;
>  	rx_q->cur_rx = 0;
>  	rx_q->dirty_rx = 0;
>  }

[Severity: High]
This is a pre-existing issue, but the commit message calls the resumed
ring freshly initialized:

    survives while cur_rx and dirty_rx are re-armed, and the first poll
    resumes that stale skb with descriptors from the freshly initialized
    ring.

Is the ring actually rebuilt on the stmmac_resume() path?

Suppose stmmac_rx_refill() hits a GFP_ATOMIC page_pool allocation failure
in the last poll before suspend. It breaks out and leaves the entries
between dirty_rx and cur_rx without pages:

		buf->page = page_pool_alloc_pages(rx_q->page_pool, gfp);
		if (!buf->page)
			break;

On resume the sequence is then:

stmmac_resume()
  stmmac_reset_queues_param()
    stmmac_reset_rx_queue()
      frees state.skb, returning its pages to the page pool
      zeroes cur_rx and dirty_rx
  stmmac_clear_descriptors()
    init_rx_desc on every descriptor
  stmmac_hw_setup()
    stmmac_init_dma_engine()
      RX tail pointer set to buf_alloc_num

On GMAC4, dwmac4_rd_init_rx_desc() only sets OWN | BUF1V | IOC in des3.
It does not restore des0/des1, which write-back overwrote with status
data. On enhanced/normal descriptors, des2 still holds the old page's DMA
address.

Could the DMA then write to an address built from write-back status bits,
or into a page that was just released to the page pool?

When stmmac_rx() later reaches such an entry, buf->page is NULL. The call
napi_build_skb(page_address(buf->page), ...) then uses a bogus address.

Before this patch, the stale skb was resumed and then freed on its first
completion while the descriptor still referenced its page. So the
page-release part already existed.

The same structure is still there at the end of the series, where
stmmac_reset_rx_queue() calls stmmac_xdp_put_buff() on the saved
xdp_buff.

Does the resume path need to rebuild the missing RX buffers and
descriptor addresses, and handle allocation failure, before it restarts
RX DMA?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261009-stmmac-rx-mb-v5-0-c38fa4eaa138%40oss.qualcomm.com
