Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792431515;
	b=MRyQ+oZES4okm1xK7A3wHPf90hvbIJkD2GwVDXrb+SnOU0eJLTL0sXvhXHmLr6rx5pBj
	 zz/fF4+3dsXnCfufBa6qrZ0atWwUoP5MVKW8W+NMk69mMazDp+me3+Zja/6W5ccQPrScZ
	 Ex+thrcpD6NCoPV8JTC9vbnV2cpVIqTBke3HbRp9ON77++gMZPdqxzNo1m8xyyL/+RA9y
	 yEMiBup++d5sGf7oUiobY9WRubA7Rdo9vBbuipMdVKQSTmWrsEB1ysBA+axL/I6SLDqyx
	 c/qAB9Ng2s80y4zNGvpx6ITK94cR6GzhIAMwjjBhH8x7lMXX0QIQqIzDLDXijhDcNWw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792431515;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=OhYDrX64R6g4NIIcUmBdVZ5TPioNZZovMeTZXST8PaY=;
	b=RMVXkjdpa+Nveh8CJQwMSA/pHMzBQhpvYTaYwPPR4tGR/3+IVZ6RMIqTuEf2QwXmADPC
	 U0x7AqePacNIvKiP8j/CxddC4QV9+N1ypqQV/YeatKUhTFoQl9UB6QBFfGIgelAZgk1IZ
	 JdJajUiDOoL9BsvcvIccsaLUpLP770jy8hirF3REFKviwN247zeefD3rJtaw5/a6fjtxl
	 vooWE3GXT+p/qxCip3EUTk4qufJySfxTsq52n3S7scL4KFCVzZmcfgRGUvHxq4HjgZIzv
	 GiGKP6yiKS/7gDWvo4fFonc9c7toph3M117U/lRzgmWdULo/yMbLOSNsSZdLLMUb51g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KLxwrvaA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C3A6606A332;
	Mon, 19 Oct 2026 17:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KLxwrvaA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96FBF1F000C6;
	Mon, 19 Oct 2026 17:38:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792431514;
	bh=OhYDrX64R6g4NIIcUmBdVZ5TPioNZZovMeTZXST8PaY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=KLxwrvaA/6JqtvkzyPD62LRueq9U06zH6SLQPLcJlwxWipwfTi4c21FsVPgskv9Vd
	 FtKWGNSFJMYlON/T0yUFBCakXmsJVbolPfxGMitXwloWJ+hB5N36QTub7/gmQ+tiVG
	 gHGW+cimBUZwCVuTR/mEousnLGNpTHA1M1FjiP8O2m8N6dyjilhNGr5PChbb+UAI+Q
	 e2Sewrcz/mcmXqjDPF4ZcoOUUq1S9i9bPUG03gnce6rmpJTQMjnkCQOWVYc954e4q5
	 cKTO1c67kKsZtmWt7NJ6aZcZTA+Yfe8Yh30XzglmdhB9DZZSJ37b2J+n3+GMJZes/V
	 YFsW0xUaSRK6Q==
Subject: Re: [PATCH net-next v8 1/5] net: stmmac: take ownership of saved RX
 state at poll entry
From: netdev-bot+sashiko@kernel.org
To: lorenzo.bianconi@oss.qualcomm.com
Cc: maxime.chevallier@bootlin.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com, ast@kernel.org,
 daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
 sdf@fomichev.me, Jose.Abreu@synopsys.com, boon.leong.ong@intel.com,
 netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 bpf@vger.kernel.org
Date: Mon, 19 Oct 2026 17:38:33 +0000
Message-ID: <179243151310.3135.16032115262445521338@kernel.org>
In-Reply-To: <20261018-stmmac-rx-mb-v8-1-5f58c0b25849@oss.qualcomm.com>
References: <20261018-stmmac-rx-mb-v8-1-5f58c0b25849@oss.qualcomm.com>
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

- [Low] The authorship and Signed-off-by chain disagree.

Pre-existing issues:
- [High] At this commit, stmmac_rx() still uses `skb == NULL` to decide
  that a descriptor starts a new frame.
- [High] This problem wasn't introduced by this patch, but the commit
  message relies on it being absent.

--

net: stmmac: take ownership of saved RX state at poll entry

This commit makes stmmac_rx() and stmmac_rx_zc() take the saved
partial-frame state at poll entry. A new in_progress flag tracks whether
a frame is still incomplete, and the state is saved again only in that
case. It also frees the saved skb in stmmac_reset_rx_queue() and in
__free_dma_rx_desc_resources().

> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
> Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>
> Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>

[Severity: Low]
This isn't a bug, but the author field and the Signed-off-by chain don't
match. The commit author is Lorenzo Bianconi. The first Signed-off-by is
James Hilliard, and there is no Co-developed-by tag.

If James wrote the patch, should it carry a "From: James Hilliard
<james.hilliard1@gmail.com>" line so git credits him as the author? If
Lorenzo is the author, does James's sign-off need a matching
Co-developed-by tag?

The other patches in the series carry only Lorenzo's sign-off. That
suggests this patch was written by James and picked into the series.

> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index 53782ab55e125..8fd2acb25fb60 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c

[ ... ]

> @@ -5958,9 +5970,7 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
>  						      STMMAC_XDP_REDIRECT)) {
>  					xdp_status |= xdp_res;
>  					buf->page = NULL;
> -					skb = NULL;
> -					count++;
> -					continue;
> +					goto next;
>  				}
>  			}
>  		}

[Severity: High]
This is a pre-existing issue, and this patch doesn't change how it
behaves. What happens here when the XDP verdict is taken on a descriptor
that still has rx_not_ls set?

stmmac_rx() uses skb == NULL to mean a new frame is starting. The goto
next now also clears in_progress, and error stays 0. The remaining
descriptors of the same hardware frame would then each be handled as the
first descriptor of a new frame.

The XDP_CONSUMED branch just above has the same shape:

	skb = NULL;

	if (unlikely((status & rx_not_ls)))
		goto read_again;

So does the napi_build_skb() failure path:

	if (!skb) {
		page_pool_recycle_direct(rx_q->page_pool,
					 buf->page);
		buf->page = NULL;
		rx_dropped++;
		count++;
		goto drain_data;
	}

In each of these three cases, could the middle and tail descriptors be
passed to XDP and built into an skb with a stale or zero len? Could
buf1_len then underflow and produce an skb length near 4G?

An on-link peer can reach this by sending a frame that spans several
descriptors while an XDP program returns a non-PASS verdict. A
napi_build_skb() failure on such a frame reaches it too.

Later patches in this series seem to fix it. "net: stmmac: drop
multi-buffer frames in XDP mode" sets error on non-last descriptors when
XDP is attached. "net: stmmac: rework stmmac_rx to support XDP rx
multi-buff" runs XDP and stmmac_build_skb() only on the last descriptor
and sends build failures to error_free_frag.

[ ... ]

> @@ -8399,6 +8408,9 @@ static void stmmac_reset_rx_queue(struct stmmac_priv *priv, u32 queue)
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
This isn't a bug introduced by this patch, but the commit message says
that, without this change, the first poll "resumes that stale skb with
descriptors from the freshly initialized ring". Is the ring actually
re-initialized on the stmmac_resume() path?

stmmac_resume() does:

	stmmac_reset_queues_param(priv);

	stmmac_free_tx_skbufs(priv);
	stmmac_clear_descriptors(priv, &priv->dma_conf);

	ret = stmmac_hw_setup(ndev);

None of these calls refills buf_pool or rewrites the descriptor buffer
addresses. stmmac_clear_rx_descriptors() calls stmmac_init_rx_desc() on
every entry. On dwmac4 that only sets the owner bits:

static void dwmac4_rd_init_rx_desc(struct dma_desc *p, int disable_rx_ic,
				   u8 descriptor_mode, int end, int bfsize)
{
	dwmac4_set_rx_owner(p, disable_rx_ic);
}

Suppose stmmac_rx_refill() hit a page_pool allocation failure before
suspend:

		if (!buf->page) {
			buf->page = page_pool_alloc_pages(rx_q->page_pool, gfp);
			if (!buf->page)
				break;
		}

Then the entries between dirty_rx and cur_rx still have buf->page ==
NULL. On resume, cur_rx and dirty_rx are reset to 0 and every descriptor
goes back to the DMA. When one of those entries completes, can
stmmac_rx() call page_address(buf->page) and napi_build_skb() on a NULL
page?

There is a similar problem on dwmac4/xgmac. Descriptors that the hardware
writes back between napi_disable() in stmmac_suspend() and
stmmac_stop_all_dma() have RDES0/RDES1 overwritten with status words.
If those descriptors are given back to the DMA, would it write to a
bogus buffer address?

The resume sequence is the same at the end of the series.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261018-stmmac-rx-mb-v8-0-5f58c0b25849%40oss.qualcomm.com
