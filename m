Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793092260;
	b=hA+knpKWFM0zmadA54P0X5d19nO1qvddtMuGLhwKrBezacphoZz+wGq31isWLCPeDOdL
	 ELGzZk96wE7vSO4sUo27/4zdBgUtNVlAnGvt3zvvxtfazvQ74N15P6E602Qx17hFdTZ6X
	 IUiMHwId6dfQzkaqewiS+TNk/T9Tg+IaCe6Quh19tDkCQ5tpDYbro1eKmTp3u8NctkW5/
	 4fYiV+Y3Wh4OF6ZroytI+ynyeBvff0gyMIjWHaM/HLoWNt0PSBnxK39Ov17z1dq8JzwXe
	 G0OaphMGmG7I/N85jhoNgwN8hNp7aOe712obOH23DAaIRZSVzEJz4ClidXp+RK0mvSg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793092260;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=NMwzOBgLak0sHODIyBF4CYGTZyqMPZeg2NfCnH9H41E=;
	b=W8Iuf7p2D41bSXv0AZfLqAf91yqyNhlbc0qlbvibnXWeTw+NciMsrBlGzaH4SRgjEgqz
	 vIPw7ERw6Wa7XWAHQzsTaeGXsa4cTmSW2ErsnPd9iJKo7R3HU8MH1qKX+ekfLMpvDncrU
	 cKtYiqeUmJEzLrYrHyJN0oLh/AMZRKttPx3jP2HYsF92MrqfbCx7KP42uTKYU0M8B+VKZ
	 rTRAgd2V+IlIKJsRzP+5h6oQVX1ZvAHVazAxeODn7aRfo1sqeqZuqAlfdaOo1zft7PUTR
	 RWddxEgrSUwZGl9569F+ERYX/DzbDTJwJr5vQK4AnPRtvu+KUBb1IEO+SU911mHJqkw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ivj4YrMJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65E90606A31D;
	Tue, 27 Oct 2026 09:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ivj4YrMJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 473211F01825;
	Tue, 27 Oct 2026 09:10:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793092260;
	bh=NMwzOBgLak0sHODIyBF4CYGTZyqMPZeg2NfCnH9H41E=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Ivj4YrMJUMYBYm++ZtfNi8DsvatmvdbpZhlDJ/0FzEzKVTh4qKyW2ctQlHCPBDo2x
	 e/6nOVVWxx3NOxYdLBnAA4ny7IwV7xP/svJzlQ+2x9qLK07sHBK0FhDzea706Y6iBo
	 QeBjfnKuwCFiuC5og/0i+ybPPaBgg98We38cW14aizhB3MYTGdOM7t2eMvz1vySB/h
	 wrgJJdQWYInNndHboKVqsOPQIW8rYFtLKEUjnrFfElGuAfz6AmJSfkmDrfpSeZk2Dz
	 CToDXnRpczImzHyOIZ+UhAOF37BUdxppn/3K05DJuYbGZ0ZRODkJnc8qlgBbjPSfuc
	 Z/n+7Dn/jRrFg==
Subject: Re: [PATCH net 6/6] net: stmmac: fix XDP RX buffer DMA sync length
From: netdev-bot+sashiko@kernel.org
To: lorenzo.bianconi@oss.qualcomm.com
Cc: maxime.chevallier@bootlin.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com, ast@kernel.org,
 daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
 sdf@fomichev.me, Jose.Abreu@synopsys.com, boon.leong.ong@intel.com,
 o.rempel@pengutronix.de, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org
Date: Tue, 27 Oct 2026 09:10:58 +0000
Message-ID: <179309225887.3134.17502896212947474889@kernel.org>
In-Reply-To: <20261023-stmmac-xdp-fixes-v1-6-efb37e19f5bd@oss.qualcomm.com>
References: <20261023-stmmac-xdp-fixes-v1-6-efb37e19f5bd@oss.qualcomm.com>
X-sashiko-severity: High
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

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 0 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] In stmmac_rx()
  (drivers/net/ethernet/stmicro/stmmac/stmmac_main.c), the length passed…

--

net: stmmac: fix XDP RX buffer DMA sync length

This commit changes the XDP path in stmmac_rx() so that pre_len and
sync_len are measured from data_hard_start, and buf->page_offset is no
longer subtracted. That matches the page_pool DMA window, which now
starts at offset 0. The goal is for page_pool_put_page() on the
consumed XDP path to sync the whole region the CPU touched.

> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index 32b2c5834c340..c51358c51fae7 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -5980,8 +5980,7 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
>  			xdp_prepare_buff(&ctx.xdp, page_address(buf->page),
>  					 buf->page_offset, buf1_len, true);
>  
> -			pre_len = ctx.xdp.data_end - ctx.xdp.data_hard_start -
> -				  buf->page_offset;
> +			pre_len = ctx.xdp.data_end - ctx.xdp.data_hard_start;
>  
>  			ctx.priv = priv;
>  			ctx.desc = p;
> @@ -5991,8 +5990,7 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
>  			/* Due xdp_adjust_tail: DMA sync for_device
>  			 * cover max len CPU touch
>  			 */
> -			sync_len = ctx.xdp.data_end - ctx.xdp.data_hard_start -
> -				   buf->page_offset;
> +			sync_len = ctx.xdp.data_end - ctx.xdp.data_hard_start;
>  			sync_len = max(sync_len, pre_len);

[Severity: High]

Does this cover the furthest point the CPU touched if the XDP program
grows the tail and then shrinks it again before it returns?

The comment says the sync covers the "max len CPU touch". However,
max(sync_len, pre_len) only looks at data_end before the program runs
and after it returns. bpf_xdp_adjust_tail() writes to the grown area
when the tail grows:

net/core/filter.c:bpf_xdp_adjust_tail() {
    ...
	/* Clear memory area on grow, can contain uninit kernel memory */
	if (offset > 0)
		memset(xdp->data_end, 0, offset);

	xdp->data_end = data_end;
    ...
}

A later negative adjust only moves data_end back.

Take a 64 byte frame at page_offset 256 and a program that does
adjust_tail(+512), then adjust_tail(-512), then returns XDP_DROP. Both
pre_len and sync_len end up at the original end, around 316. The memset
dirtied the cache lines in [316, 828), but this call does not clean
them:

    page_pool_put_page(rx_q->page_pool,
                       virt_to_head_page(ctx.xdp.data),
                       sync_len, true);

__page_pool_dma_sync_for_device() caps the length at p.max_len but
never extends it. The direct recycle cache does no further sync.
stmmac_rx_refill() gives the buffer back to the device after dma_wmb(),
with no more cache maintenance.

max_len is dma_buf_sz + stmmac_rx_offset(priv), which is 1792 with
dma_buf_sz = 1536. So that range lies inside the window the device DMAs
into.

On a non-coherent platform, could one of those dirty lines be evicted
after the device has written the next frame into the recycled page, and
corrupt that frame? It looks like the same failure the commit message
describes:

    Dirty cache lines in the tail of the frame can be written back
    after the device has DMA'd a new frame into that page.

The commit message names "grow the tail" as a trigger and says "the
whole CPU-touched window is synced". The max(pre, post) approach was
already there before this patch.

Would it be better for the STMMAC_XDP_CONSUMED path to sync the full
pool window instead of checking only the two endpoints? Passing
p.max_len, or using page_pool_recycle_direct(), would do that.

>  
>  			/* For Not XDP_PASS verdict */

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261023-stmmac-xdp-fixes-v1-0-efb37e19f5bd%40oss.qualcomm.com
