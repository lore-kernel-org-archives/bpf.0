Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 198AD51FCB3;
	Tue, 13 Oct 2026 15:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791905230; cv=none; b=CKxIM/q+NdXHwuDdoywuz50Mof+RfG4r+kyytPAiJT+58hEC5gko5jIG9mWuNsERd2wFmWD4xOA6/LKYJVovXKRYhtzWkruI8HT/HzFA4dmoYNoG5yPM9uRH4ncIkJHnDuy/2NFO7QQUjkt1N4tiRx5ROVxynb1d8QKUW04B6gY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791905230; c=relaxed/simple;
	bh=OiyDxKMaWi5WSg9WKDOm7Q1oQh/8coDXTs0lEotlLbA=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=d+7E7z9t7EZa2AzI/jXpUfGEmM71RpiuNtkH53bl+BAckvhA1e1dn4wR1Voh7J6IQyPPkeZboCmsIsAIv4W6ppcf6oKoiFVwQoSJL+Y45aN5+lmTioz/sje0YExX1Bx0/lcCAWqEdECtEzptiisSljyXwMbrEa5/wdVcdpBnpYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n17LqzD5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n17LqzD5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5C981F000FF;
	Tue, 13 Oct 2026 15:27:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791905227;
	bh=R8S3NY57BMMYZek8JXFwtsc6w4ekQrWVkELly8pYpXE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=n17LqzD5siqrk9lbUKaMdGLHDkDLjAjNrOy6Tl9TIfbk62LN/BxzEnxmNOFfNg8hI
	 9hNxLKLgvS+hQKSwwbQO0Gf++Yh/OvSldoO5/mTcYllIjsnphcPXW46NYVpgAeOxkF
	 LtHqg/FzeOMjVX6ET9fTHgU/wD7AZMADbdUyyK0S50Vw8IqPfTGUFjXpPwX8QKXk7K
	 pY9cr00Phjcv3HoeL0/+twYYBfcqUA7gMFKYqkIXnEqYBEZx49S7GoSiSbShdVCMlg
	 MmKroUPEBahgbnqwsPH4goWJFA3VXDyx98yjPaICvBRwH0EpOE0BRFIlSQ6Efy0Kd1
	 hpUE1E7KXIYMA==
Subject: Re: [PATCH net-next 1/2] net: stmmac: fix XDP TX DMA address for
 compound RX pages
From: netdev-bot+sashiko@kernel.org
To: lorenzo.bianconi@oss.qualcomm.com
Cc: maxime.chevallier@bootlin.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com, ast@kernel.org,
 daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
 sdf@fomichev.me, boon.leong.ong@intel.com, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org
Date: Tue, 13 Oct 2026 15:27:06 +0000
Message-ID: <179190522641.434549.12034764335349832312@kernel.org>
In-Reply-To:
 <20261012-stmmac-xdp-tx-pre-fixes-v1-1-05fd0c90f7e1@oss.qualcomm.com>
References:
 <20261012-stmmac-xdp-tx-pre-fixes-v1-1-05fd0c90f7e1@oss.qualcomm.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 0 (1) · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The commit message describes a bug that the current driver
  cannot reach.

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but on cores with
  normal (non-enhanced) descriptors in ring mode, which is the default…

--

net: stmmac: fix XDP TX DMA address for compound RX pages

This commit changes stmmac_xdp_xmit_xdpf() to use virt_to_head_page()
instead of virt_to_page() when it looks up the page_pool DMA address for
the XDP_TX head buffer. The goal is that a data pointer sitting in a tail
page of a compound RX page still resolves to the DMA base of the head page.

> RX pages become compound as soon as dma_buf_sz needs more than one page
> (pp_params.order = order_base_2(num_pages) > 0), which happens from an
> MTU around 3000 bytes once dma_buf_sz reaches 4096. If an XDP program
> moves the data forward with bpf_xdp_adjust_head() by more than about a
> page, xdpf->data points into a tail page whose struct page has no DMA
> address: page_pool_get_dma_addr() then returns a bogus bus address, and
> dma_sync_single_for_device() together with the TX descriptor transmit
> from the wrong location.

[Severity: Medium]

Can the driver reach this configuration today? stmmac_xdp_set_prog()
refuses to attach a program when the MTU is above ETH_DATA_LEN:

drivers/net/ethernet/stmicro/stmmac/stmmac_xdp.c:stmmac_xdp_set_prog() {
    ...
	if (prog && dev->mtu > ETH_DATA_LEN) {
		/* For now, the driver doesn't support XDP functionality with
		 * jumbo frames so we return error.
		 */
		NL_SET_ERR_MSG_MOD(extack, "Jumbo frames not supported");
		return -EOPNOTSUPP;
	}
    ...
}

stmmac_change_mtu() blocks the other order too:

	if (stmmac_xdp_is_enabled(priv) && new_mtu > ETH_DATA_LEN) {
		netdev_dbg(priv->dev, "Jumbo frames not supported for XDP\n");
		return -EINVAL;
	}

When XDP is enabled the MTU is at most 1500, so stmmac_set_bfsize() returns
DEFAULT_BUFSIZE (1536). Then in __alloc_dma_rx_desc_resources():

	dma_buf_sz_pad = stmmac_rx_offset(priv) + dma_conf->dma_buf_sz +
			 SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
	num_pages = DIV_ROUND_UP(dma_buf_sz_pad, PAGE_SIZE);
	...
	pp_params.order = order_base_2(num_pages);

dma_buf_sz_pad stays below PAGE_SIZE, so num_pages is 1 and the order is 0.
stmmac_rx() also sets frame_sz to a single page.

On an order-0 page, virt_to_page() and virt_to_head_page() return the same
struct page. Does this change behaviour at runtime in any configuration the
driver currently allows?

The threshold in the message also looks off. By the driver's own sizing,
dma_buf_sz reaches 4096 once the MTU goes above roughly 2022, not 3000.

The later patch in the series, "net: stmmac: disable TX checksum offload
for jumbo frames on bugged cores", only adds a csum override. It does not
lift the XDP/jumbo restriction, so the described trigger still can't happen
at the end of the series.

The change is reasonable hardening, and it matches the existing
virt_to_head_page(ctx.xdp.data) use in stmmac_rx(). Could the message
describe it as hardening, or as a prerequisite for jumbo or multi-buffer
XDP? Could the Fixes: tag also be reconsidered? As written, stable will
treat this as a fix for a reachable DMA corruption bug.

> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index b8b4de4c5b1a7..ca61ab449e32b 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -5301,7 +5301,7 @@ static int stmmac_xdp_xmit_xdpf(struct stmmac_priv *priv, int queue,
>  			struct page *page;
>  
>  			page = frag ? skb_frag_page(frag)
> -				    : virt_to_page(xdpf->data);
> +				    : virt_to_head_page(xdpf->data);
>  			dma_addr = page_pool_get_dma_addr(page);
>  			if (frag)
>  				dma_addr += skb_frag_off(frag);

[Severity: High]

This isn't a bug introduced by this patch, but it has the same symptom.
On cores with normal (non-enhanced) descriptors in ring mode, the default
when chain_mode is not set, can the XDP_TX path in stmmac_xdp_xmit_xdpf()
make the DMA engine fetch part of the frame from an address that was never
programmed?

stmmac_rx() builds the xdp_buff with a full-page frame_sz:

	bufsz = DIV_ROUND_UP(priv->dma_conf.dma_buf_sz, PAGE_SIZE) * PAGE_SIZE;
	...
	xdp_init_buff(&ctx.xdp, bufsz, &rx_q->xdp_rxq);

That means an XDP program can use bpf_xdp_adjust_tail() to grow the frame
well past 2047 bytes and return XDP_TX, even with the MTU at 1500.

Further down in stmmac_xdp_xmit_xdpf(), only TDES2 is programmed:

		stmmac_set_desc_addr(priv, desc, dma_addr);
		stmmac_prepare_tx_desc(priv, desc, !i, len, csum,
				       priv->descriptor_mode, !!i, last_frame,
				       xdp_get_frame_len(xdpf));

With normal descriptors, the call chain
stmmac_prepare_tx_desc()->ndesc_prepare_tx_desc()->norm_set_tx_desc_len_on_ring()
splits the length between buffer 1 and buffer 2:

	unsigned int buffer1_max_length = BUF_SIZE_2KiB - 1;

	if (unlikely(len > buffer1_max_length)) {
		p->des1 |= cpu_to_le32(FIELD_PREP(TDES1_BUFFER2_SIZE_MASK,
						  len - buffer1_max_length) |
				       FIELD_PREP(TDES1_BUFFER1_SIZE_MASK,
						  buffer1_max_length));

In ring mode, TDES3 holds the buffer 2 address. That is why jumbo_frm() in
ring_mode.c sets it explicitly:

	desc->des3 = cpu_to_le32(lower_32_bits(des2) + BUF_SIZE_4KiB);

The XDP path never writes des3, and ndesc_release_tx_desc() only clears
des0 and des1:

	memset(p, 0, offsetof(struct dma_desc, des2));

So des3 still holds either 0 (from the coherent allocation, or after
clean_desc3() runs on completion) or a stale buffer address. Would the MAC
then read len - 2047 bytes from that address and transmit them?

Without an IOMMU, this could send arbitrary memory out on the wire. With
an IOMMU, the read would fault and TX DMA would be restarted.

ndev->xdp_features is set unconditionally, so nothing blocks XDP on these
cores. The behaviour goes back to be8b38a722e6, which added XDP_TX.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261012-stmmac-xdp-tx-pre-fixes-v1-0-05fd0c90f7e1%40oss.qualcomm.com
