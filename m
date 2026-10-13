Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA1003F105B;
	Tue, 13 Oct 2026 17:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791912801; cv=none; b=bwi2WZDWX7Bh9V0On6uDSDqYTPJ9wj5pzamiC3qSlDNIAfEDcco/pqbjU39Q/LoBi7L5P4LvF1mnEyhN0xWmVMY86I8jqSbxTJkVZAuR4WC28hdjDWDCeQS4cCSm8Kb8ADKaypvvAacvOPM8OcJthEqD6N2uS/FK5JnKeNdHZL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791912801; c=relaxed/simple;
	bh=YvnjC/1j3psrZH90/fo3p5cuWukWGChqwlSP0rIYgmo=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uvd7wv5dQpTsuM2O5c01sR2zOI3TTpyPqYueJTrjuolXE6PoDo7+pQ0dezmMMV70X+0jm+2SBCr89bkm4UFU7sADtLeL4UrwwGnJY7tU7HdpG3MZQPjaq/gyPar8MJgWcn7C3oAWl96AAqsOaEWAZRdkLNb3kzpQ6f3yvWnJeGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d3nHJ8Qi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d3nHJ8Qi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E6871F00893;
	Tue, 13 Oct 2026 17:33:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791912799;
	bh=bBRf53pMIfyuuiOhSsHdY8uKkWujYlRWexBE8JF+aUs=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=d3nHJ8QijHS5/DXzynWJbIehkPjkkxammNYzH6mzW/rfuPMHS5lPkwvirb7Eemrx6
	 jWw4qZiI5xZwuSNxJMrm+hEh5u1asGJtEfvHWY4wN2wDzA+zA+L4XKxWL5375cO6Bs
	 2U/f7H9WNqkQDXMxpX1kfNzqlLIw6iKSsxoKzcnwynIinuL07Yj4IaJUgdix90LFkO
	 g4RsCsXTaGY2vNCPAZOuvStYgByKtyH2COv9mtWaNAQl2lM5RtbwKi+JQPA8LLPhPV
	 mCCn/wAvWmkSLn1i+sXruE4MB7Oi49J4AASheOD24WVbVgyk4VwQgrImxDXfdw/zIc
	 Nq0uxj4zAyXKA==
Subject:
 Re: [PATCH net-next v6 3/4] net: stmmac: drop multi-buffer frames in XDP mode
From: netdev-bot+sashiko@kernel.org
To: lorenzo.bianconi@oss.qualcomm.com
Cc: maxime.chevallier@bootlin.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com, ast@kernel.org,
 daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
 sdf@fomichev.me, Jose.Abreu@synopsys.com, boon.leong.ong@intel.com,
 netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 bpf@vger.kernel.org
Date: Tue, 13 Oct 2026 17:33:18 +0000
Message-ID: <179191279813.434549.3430159176112634847@kernel.org>
In-Reply-To: <20261012-stmmac-rx-mb-v6-3-2225050915c1@oss.qualcomm.com>
References: <20261012-stmmac-rx-mb-v6-3-2225050915c1@oss.qualcomm.com>
X-sashiko-severity: Medium
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

Critical: 0 · High: 0 · Medium: 2 (1) · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] On GMAC4/XGMAC, a frame that fills buffer 1 and buffer 2 of a
  single descriptor gets past the new 'We do not support SG in XDP mode'…
- [Medium] The new XDP guard in stmmac_rx() and the drain logic (`if
  (status & rx_not_ls) goto read_again;`, `in_progress = status &…

Pre-existing issues:
- [Medium] dwmac4_wrback_get_rx_status() sets ret = discard_frame when
  RDES3_ERROR_SUMMARY is set (CRC, receive error, overflow, watchdog,…

--

net: stmmac: drop multi-buffer frames in XDP mode

With an XDP program attached, this commit makes stmmac_rx() mark a frame
as errored when it sees a non-last descriptor. It then drains every
descriptor of that frame and counts it once in rx_dropped. The
XDP_CONSUMED re-parse path is removed, so both XDP verdict branches now
finish the packet through next.

> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index 426bb68c9bbce..8c08d44fdbd39 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -5893,18 +5893,24 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
>  
>  		if (priv->extend_desc)
>  			stmmac_rx_extended_status(priv, &priv->xstats, rx_q->dma_erx + entry);
> -		if (unlikely(status == discard_frame)) {
> -			page_pool_put_page(rx_q->page_pool, buf->page, 0, true);
> -			buf->page = NULL;
> +
> +		if (unlikely(!error && status == discard_frame)) {
>  			error = 1;
>  			if (!priv->hwts_rx_en)
>  				rx_errors++;
>  		}

[Severity: Medium]
This is a pre-existing issue and wasn't introduced by this patch. Should
this check test the bit instead of comparing for equality? The
rx_frame_status values are bit flags, and dwmac4_wrback_get_rx_status()
can return discard_frame | csum_none:

dwmac4_wrback_get_rx_status() {
	...
	if (unlikely(rdes3 & RDES3_ERROR_SUMMARY)) {
		...
		ret = discard_frame;
	}
	...
	if (rdes1 & RDES1_IP_HDR_ERROR) {
		x->ip_hdr_err++;
		ret |= csum_none;
	}
	...
	if (rdes1 & RDES1_IP_PAYLOAD_ERROR) {
		x->ip_payload_err++;
		ret |= csum_none;
	}
	...
}

Take a frame that has an error summary bit (CRC, overflow, giant, ...)
and also an IP header or payload error. The status is 0x3, so it fails
status == discard_frame and goes to XDP or the stack as a good frame.

The stack path gets CHECKSUM_NONE and checks the checksum in software,
so the XDP path is the one mainly affected. This patch only adds
!error && to the same comparison, and the comparison is unchanged at
the end of the series.

>  
> -		if (unlikely(error && (status & rx_not_ls)))
> -			goto read_again;
> +		/* We do not support SG in XDP mode */
> +		if (unlikely(!error && (status & rx_not_ls) &&
> +			     stmmac_xdp_is_enabled(priv))) {
> +			rx_dropped++;
> +			error = 1;
> +		}

[Severity: Medium]
Does this guard catch a frame that fits in one descriptor but spills
into buffer 2? It only tests rx_not_ls, so a last descriptor with data
in both buf1 and buf2 gets past it.

On GMAC4/XGMAC, stmmac_rx_check_buf2_cap() returns true whenever
set_sec_addr exists. It ignores SPH and XDP:

stmmac_rx_check_buf2_cap() {
	return priv->hw->desc && priv->hw->desc->set_sec_addr;
}

So stmmac_rx_refill() arms sec_page, and dwmac4_set_sec_addr() sets
RDES3_BUFFER2_VALID_ADDR.

With MTU 1500 (dma_buf_sz 1536) and GMAC_CONFIG_JE always set, a peer
can send a 1537..3072 byte frame. It lands in one descriptor with LS
set, so buf1_len is 1536 and buf2_len is non-zero.

Further down in stmmac_rx(), the xdp_buff is built from buffer 1 only,
and the FCS isn't stripped:

	if (stmmac_xdp_is_enabled(priv) && !buf2_len) {
		buf1_len -= ETH_FCS_LEN;
		fcs_stripped = true;
	}

	xdp_init_buff(&ctx.xdp, bufsz, &rx_q->xdp_rxq);
	xdp_prepare_buff(&ctx.xdp, page_address(buf->page),
			 buf->page_offset, buf1_len, true);

Wouldn't the XDP program see a truncated frame here?

On XDP_TX and XDP_REDIRECT, the truncated buffer 1 is forwarded.
buf->sec_page stays in the slot, so the buffer 2 data is dropped. On
XDP_PASS, a buffer 1 that the program may have modified is followed by
an unmodified buffer 2 frag.

So for this case the subject line ("drop multi-buffer frames in XDP
mode") doesn't hold. Commit 88095728511e ("net: stmmac: fix rx
Scatter-Gather support") already lists this as a known limitation.

The later patch in this series, "net: stmmac: rework stmmac_rx to
support XDP rx multi-buff", fixes it by adding buf2 as an xdp frag. The
standalone net/stable portion would still have the gap. Should frames
with buf2_len != 0 also be dropped here while XDP is enabled?

>  
>  		if (unlikely(error)) {
> +			if (status & rx_not_ls)
> +				goto read_again;
> +

[Severity: Medium]
Does this drain work on enh_desc and norm_desc cores? The new XDP guard
and this goto read_again both expect stmmac_rx_status() to return
rx_not_ls for a non-last descriptor.

Only dwmac4_wrback_get_rx_status() and the dwxgmac2 rx_status do that.
The legacy parsers return plain discard_frame:

enh_desc_get_rx_status() / ndesc_get_rx_status() {
	...
	if (unlikely(!(rdes0 & RDES0_LAST_DESCRIPTOR))) {
		x->rx_length++;
		return discard_frame;
	}
	...
}

ndev->xdp_features is set unconditionally, so XDP is advertised on
these cores too.

On dwmac1000/dwmac100, the first descriptor of a split frame sets
error = 1 and counts rx_errors, not rx_dropped. rx_not_ls is clear, so
the code takes goto next and doesn't drain. The next iteration then
resets error, len and skb.

The last descriptor is then parsed as a new frame with len == 0. In
that case stmmac_rx_buf1_len() returns min(dma_buf_sz, plen), and plen
is the full frame length.

Could this give XDP (and the stack on XDP_PASS) a mid-payload frame?
Its length would run up to dma_buf_sz and cover stale page_pool bytes
that this packet didn't write.

The commit message says this outcome is removed ("drain and release
every descriptor - including the last"), but it is still there at the
end of the series.

Whether it can happen depends on the legacy MAC delivering a frame
larger than dma_buf_sz at MTU 1500. dwmac1000_core_init() leaves JE/2K
off but doesn't set WD, so frames up to 2048 bytes can reach the FIFO.
Whether they reach memory without ES set depends on how the hardware is
configured, for example store-and-forward with FEF=0 versus threshold
mode.

>  			dev_kfree_skb(skb);
>  			goto next;
>  		}

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261012-stmmac-rx-mb-v6-0-2225050915c1%40oss.qualcomm.com
