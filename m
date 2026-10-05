Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 263363E833E;
	Mon,  5 Oct 2026 21:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791234991; cv=none; b=ettKvd0YA4TwauYzhB5LBbeIbVN60595IcSZFohIjEFWCwNOTQAS/tjXT0+zpXKvL8fi5C7VQ64lroePjo1va2u9bH7foG5wM9uSgDlyoyroKFNcB5QxBmwf2EMTQq8XL6oAWHib4KfH8oEwvylLzUz9pim51/PtmirJ04V/r9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791234991; c=relaxed/simple;
	bh=NRCcXqT1RWKTbBZ1wp4O+ALbvdAJomEJ14ksRfJa5O0=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aZNwXHkE9WLu6MVibjzjHcNglc4FEIHBDNPk2F77xzQ9T6iB/z5+5Uwv0FyVP1f9XBGDEgHeeBX/ZF5JYnl70WQvJLwhdGhPj4f2QQKLFE9WiyC7e5MvgkVM/y9khcfRTDUMzfXvcqfOZ3TIqucS5YTFmgoCC5bkq11ZYz/wa88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U9hEDN7k; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U9hEDN7k"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22A881F00898;
	Mon,  5 Oct 2026 21:16:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791234987;
	bh=l8zDm9e1xHnYMUq1q62pJ6OOsloulGmM1Wyx7GdvjYE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=U9hEDN7kGCij1ILVCpFuMKyXOGyKYgTqZ2i/qUau8MN4HTp5ri+yrW2zKmA2NDvul
	 xZWFv8qQ+7iF/i0Wf9bxEohMEnGvxuTccOtngyopmIFr/+e/kZIyXUYgPswbXvVZEF
	 FdvXxu3uv3IxmavrOgbklp6CFqrMtWtS41speuoeM/6wCCAqCBbCyPpeRds43Nt/za
	 EwdD+Ho8pECrPwLMBwZCIH+qwI2OZOvp2Q9O3sdYK1lMQrhCiSAjoXqUGptL7/8TH9
	 V7GgD8pfIKE4rDk7TatTmNQvGm+uevN9dWKJMw+K59O7RYeONX3/zWIJQBlxeIvw6r
	 KKcLMFqGJNDVQ==
Subject: Re: [PATCH net-next v3 1/2] net: stmmac: take ownership of saved RX
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
Date: Mon, 05 Oct 2026 21:16:25 +0000
Message-ID: <179123498568.434549.2388087192931853745@kernel.org>
In-Reply-To: <20261004-stmmac-rx-mb-v3-1-50fa171af9ec@oss.qualcomm.com>
References: <20261004-stmmac-rx-mb-v3-1-50fa171af9ec@oss.qualcomm.com>
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

Critical: 0 · High: 1 (1) · Medium: 0 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] At the reviewed commit, stmmac_rx() resets skb/error/len at the
  top of the loop only when `!in_progress`, instead of whenever count >…
- [Low] The commit message leaves out one of the behaviour changes.

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but it remains at
  the end of the series and the patch reworks the same continuation-…

--

net: stmmac: take ownership of saved RX state at poll entry

This patch changes stmmac_rx() and stmmac_rx_zc() so they take the saved
RX state at poll entry and clear it right away. The state is saved again
only if the frame is still incomplete, which a new in_progress flag tracks.
The patch also frees any saved partial skb in
__free_dma_rx_desc_resources() and stmmac_reset_rx_queue().

> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index 0c381ae0d0ffa..b2d20628ed214 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c

[ ... ]

> @@ -5652,6 +5657,8 @@ static int stmmac_rx_zc(struct stmmac_priv *priv, int limit, u32 queue)
>  		if (!buf->xdp)
>  			break;
>  
> +		in_progress = status & rx_not_ls;
> +
>  		if (priv->extend_desc)
>  			stmmac_rx_extended_status(priv, &priv->xstats,
>  						  rx_q->dma_erx + entry);

[Severity: High]
This isn't a bug introduced by this patch, but this patch reworks the
continuation state in stmmac_rx_zc(), so it seems worth raising here. Can
a frame that spans more than one descriptor be delivered with the wrong
length?

The non-LS branch drops the buffer without updating len or setting error:

	/* XSK pool expects RX frame 1:1 mapped to XSK buffer */
	if (likely(status & rx_not_ls)) {
		xsk_buff_free(buf->xdp);
		buf->xdp = NULL;
		dirty++;
		count++;
		goto read_again;
	}

The LS descriptor is then handled as a complete frame with len == 0:

	buf1_len = stmmac_rx_buf1_len(priv, p, status, len);
	len += buf1_len;
	...
	buf->xdp->data_end = buf->xdp->data + buf1_len;

stmmac_rx_buf1_len() returns min(dma_buf_sz, plen - len), so buf1_len
comes from the total frame length. The LS buffer only holds the tail of
the frame, though. Also, the hardware buffer size for an XSK queue is
xsk_pool_get_rx_frame_size() (see stmmac_set_queue_rx_buf_size()), not
dma_buf_sz.

stmmac_xdp_enable_pool() only requires frame_size >= ETH_FRAME_LEN +
VLAN_HLEN * 2, and its comment says "XDP ZC does not span multiple
frame". However, dwmac4 sets GMAC_CONFIG_JE in GMAC_CORE_INIT. So jumbo
frames from the wire are accepted and split across descriptors.

For example, with 4K chunks frame_size is 3840. A 5000-byte frame leaves
1160 real bytes in the LS buffer, but data_end = data + 1532. The XDP
program, AF_XDP or stmmac_construct_skb_zc() would then see a frame whose
L2 header comes from the sender's payload, followed by 372 stale umem
bytes. If frame_size is in [1522, 1536), data_end can also run a few
bytes past the end of the chunk.

The new in_progress tracking only carries error and len, and both are 0
here, so it doesn't change this.

Would it work to set error = 1 for a non-LS descriptor in ZC mode? The new
in_progress tracking would then carry the drop state across poll and
DMA-owned boundaries. The follow-up patch in the series doesn't touch
stmmac_rx_zc().

[ ... ]

> @@ -5788,25 +5796,28 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)

[ ... ]

> -		if (!count && rx_q->state_saved) {
> -			skb = rx_q->state.skb;
> -			error = rx_q->state.error;
> -			len = rx_q->state.len;
> -		} else {
> -			rx_q->state_saved = false;
> +		if (!in_progress) {
>  			skb = NULL;
>  			error = 0;
>  			len = 0;
>  		}
> -
>  read_again:
>  		if (count >= limit)
>  			break;
> @@ -5835,6 +5846,8 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
>  
>  		prefetch(np);
>  
> +		in_progress = status & rx_not_ls;
> +
>  		if (priv->extend_desc)
>  			stmmac_rx_extended_status(priv, &priv->xstats, rx_q->dma_erx + entry);
>  		if (unlikely(status == discard_frame)) {

[Severity: High]
Can len carry over into a new frame when an XDP program returns XDP_TX
or XDP_REDIRECT on the first, non-LS descriptor of a multi-descriptor
frame?

in_progress is set from status & rx_not_ls before the XDP verdict, and
the TX/REDIRECT path doesn't clear it:

	} else if (xdp_res & (STMMAC_XDP_TX |
			      STMMAC_XDP_REDIRECT)) {
		xdp_status |= xdp_res;
		buf->page = NULL;
		skb = NULL;
		count++;
		continue;
	}

The next iteration skips the !in_progress reset. len is kept while skb
is NULL, so the continuation descriptor is treated as the start of a
frame.

If plen - len is 1 to 3 bytes, stmmac_rx_buf1_len() returns that value
and stmmac_rx_buf2_len() returns 0. Then this code:

	if (stmmac_xdp_is_enabled(priv) && !buf2_len) {
		buf1_len -= ETH_FCS_LEN;
		fcs_stripped = true;
	}

wraps buf1_len to about 0xfffffffd. xdp_prepare_buff() then sets
data_end about 4GiB past data. On XDP_PASS, this later code would hit
skb_over_panic():

	buf1_len = ctx.xdp.data_end - ctx.xdp.data;
	...
	skb_put(skb, buf1_len);

dwmac4 sets GMAC_CONFIG_JE, so a remote sender can choose the frame
length.

Before this patch, the XDP_CONSUMED plus rx_not_ls goto read_again path
already kept len. The mid-frame TX/REDIRECT route looks new, though.

The next patch in the series, "net: stmmac: rework stmmac_rx to support
XDP rx multi-buff", removes this path. After it, the XDP program only runs
after the LS descriptor, and the FCS is stripped by
stmmac_xdp_shrink_tail(), which bounds-checks the offset.

This patch carries Fixes: tags. Could it be backported to stable without
that rework?

[ ... ]

> @@ -8339,6 +8352,9 @@ static void stmmac_reset_rx_queue(struct stmmac_priv *priv, u32 queue)
>  {
>  	struct stmmac_rx_queue *rx_q = &priv->dma_conf.rx_queue[queue];
>  
> +	dev_kfree_skb_any(rx_q->state.skb);
> +	rx_q->state.skb = NULL;
> +	rx_q->state_saved = false;
>  	rx_q->cur_rx = 0;
>  	rx_q->dirty_rx = 0;
>  }

[Severity: Low]
The commit message says:

    Release a saved partial skb when the RX ring is destroyed.

That covers the __free_dma_rx_desc_resources() hunk. The
stmmac_reset_rx_queue() hunk doesn't destroy the ring, though. It runs
through stmmac_reset_queues_param() from __stmmac_open(),
stmmac_xdp_open() and stmmac_resume(), and is also called directly from
stmmac_enable_rx_queue().

Before this patch, stmmac_reset_rx_queue() only cleared cur_rx and
dirty_rx. So after stmmac_resume(), the first poll could add descriptors
from the re-armed ring to the partial skb saved before suspend.

Could the commit message also mention the open, resume and queue-enable
change? The patch carries Fixes: tags and may go to stable.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261004-stmmac-rx-mb-v3-0-50fa171af9ec%40oss.qualcomm.com
