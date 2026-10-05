Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D45503E008F;
	Mon,  5 Oct 2026 21:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791234994; cv=none; b=PBlfpCOTaLMFjFOueQhMSIRbRVNlqC65jVPmi3+Zzwm7UG/VN8L/WqmB8obSv4P61NdPMu+0wj9lSNOZoBrlBw1z4MSRges0trX3yIav6yrxUS/DhsMNrQIAz8OOF8QV6C+5iAe9hJ9taKvdBMtUt35Om5tbZln618cOei1vBVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791234994; c=relaxed/simple;
	bh=vlgXhN3e7nRfRr0bz6tNROGI5MLkTy+0od85aeFC05w=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kXRhQtYICnI6xSxi+bTnwf3yd/4c2OUt6jVWSY9XrCelKh5ZYcqH2knV/yVYKYyMEGd/ODAdDIqKQhihNbR77o+WbTeCEG1JNEv9WWcbbbFX+mnTWQPn5jtp2PtnkXf/JVORK+ZeEg2xYWCxU9iqZycAnb2EedEb/cO3vioxiFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bTYfzgnR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bTYfzgnR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB3DF1F00899;
	Mon,  5 Oct 2026 21:16:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791234988;
	bh=YdzZmoxRoZM+UMpL7Eq9SHs9ftgxVclJGjtJeClfYhA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=bTYfzgnRLN+71jSvBERhtSZO3zSjb+mLxaRNWxGUJLayHcjkcTmlTlb6phLm0RktH
	 cGJyJ4VmroXI2jHiyIZjpBqk1j3kvnHzwSs2p3lqd7RWfazybkVldiDGR+2ezlNWxs
	 G8sDRskjHQO8ivpJTpIRRnnQHnmWQQFmR+8r1AsjC6gQxgQh3yKI8U37OAklGtNYxU
	 5h2RJn53JbUrz94DHxAS84FkyB4+G5RLpme2Doqjlo120Cvh+rRv8jXnIy0XDeb1dx
	 MCf5N6TSHFQhj3yRdwz0owqQ9t/k74HfADaT1cJs7VxH0Nwb0rSaq2iw/cMxmCQTkz
	 5Vnc+ARNgr0cQ==
Subject: Re: [PATCH net-next v3 2/2] net: stmmac: rework stmmac_rx to support
 XDP rx multi-buff
From: netdev-bot+sashiko@kernel.org
To: lorenzo.bianconi@oss.qualcomm.com
Cc: maxime.chevallier@bootlin.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com, ast@kernel.org,
 daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
 sdf@fomichev.me, Jose.Abreu@synopsys.com, boon.leong.ong@intel.com,
 netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org
Date: Mon, 05 Oct 2026 21:16:27 +0000
Message-ID: <179123498740.434549.17434194748750363367@kernel.org>
In-Reply-To: <20261004-stmmac-rx-mb-v3-2-50fa171af9ec@oss.qualcomm.com>
References: <20261004-stmmac-rx-mb-v3-2-50fa171af9ec@oss.qualcomm.com>
X-sashiko-severity: Medium
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

Critical: 0 · High: 0 · Medium: 2 · Low: 3

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] stmmac_rx() now gathers every buffer of a frame into one
  xdp_buff.
- [Medium] stmmac_rx() now hands a multi-buffer xdp_buff (head plus frags
  in the head page's skb_shared_info) to the XDP program.
- [Low] Several 'In addition' bullets in the commit message describe the
  parent tree's behaviour wrongly.
- [Low] Rejected in the baseline decision; kept here because
  requires_validation is set.
- [Low] In stmmac_rx(), the non-PASS verdict branch (if (IS_ERR(skb)))
  still has the comment '/* Clear skb as it was set as status by the XDP…

--

net: stmmac: rework stmmac_rx to support XDP rx multi-buff

This reworks stmmac_rx() to accumulate all descriptors of a frame into a
single xdp_buff, so the XDP program runs on the full, possibly fragmented,
packet. A partial skb is no longer saved in rx_q->state across NAPI polls;
the in-progress xdp_buff is saved there instead. XDP_PASS frames are built
into an skb with napi_build_skb() and xdp_update_skb_frags_info(), and FCS
stripping moves to a new stmmac_xdp_shrink_tail() helper.

> Build the xdp_buff by accumulating all the descriptors that make up a
> frame, so the XDP program runs on the full (possibly fragmented) packet
> instead of just the first buffer.

[Severity: Low]
This isn't a bug, but could the scope be stated more precisely? When XDP is
enabled, stmmac_xdp_set_prog() still rejects dev->mtu > ETH_DATA_LEN and
still turns off SPH:

	priv->sph_active = priv->sph_capable && !stmmac_xdp_is_enabled(priv);

So the program only sees fragmented xdp_buffs for oversized frames that the
MAC accepts at MTU 1500 through GMAC_CONFIG_JE or the XGMAC GPSL setting.

Would it help to say in the commit message that the jumbo MTU restriction
for XDP stays in place?

[ ... ]

> - release all buffers belonging to a frame when it is dropped on RX
>   errors, instead of leaking the ones already attached to the xdp_buff;
> - drop the whole frame when the number of fragments exceeds
>   MAX_SKB_FRAGS, instead of delivering a truncated one;

[ ... ]

> - skip zero-length fragments, which can happen for non-first
>   descriptors when split-header (SPH) is enabled.

[Severity: Low]
Are these bullets accurate when compared with the parent tree?

On the leak claim: the parent stmmac_rx() built no xdp_buff frags. On
error it called dev_kfree_skb(skb) on an skb marked with
skb_mark_for_recycle(), which returns the attached page_pool frags.

On the truncation claim: the parent called
skb_add_rx_frag(skb, skb_shinfo(skb)->nr_frags, ...) with no bound, so it
would not have delivered a truncated frame.

On zero-length fragments: the parent already had the
"} else if (buf1_len) {" and "if (buf2_len) {" guards.

These read like changelog notes from an earlier revision of the patch.
Could they be reworded to describe the change against the current tree?

> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index b2d20628ed214..3098fd6df1582 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c

[ ... ]

> @@ -5874,135 +5996,94 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)

[ ... ]

>  		} else if (buf1_len) {
> -			dma_sync_single_for_cpu(priv->device, buf->addr,
> -						buf1_len, dma_dir);
> -			skb_add_rx_frag(skb, skb_shinfo(skb)->nr_frags,
> -					buf->page, buf->page_offset, buf1_len,
> -					priv->dma_conf.dma_buf_sz);
> +			if (!stmmac_build_xdp_frags(priv, rx_q, buf1_len,
> +						    buf->page,
> +						    buf->page_offset,
> +						    dma_dir, &ctx.xdp)) {
> +				if (!error)
> +					rx_dropped++;
> +				error = 1;
> +			}
>  			buf->page = NULL;
>  		}
>  
>  		if (buf2_len) {
> -			dma_sync_single_for_cpu(priv->device, buf->sec_addr,
> -						buf2_len, dma_dir);
> -			skb_add_rx_frag(skb, skb_shinfo(skb)->nr_frags,
> -					buf->sec_page, 0, buf2_len,
> -					priv->dma_conf.dma_buf_sz);
> +			if (!stmmac_build_xdp_frags(priv, rx_q, buf2_len,
> +						    buf->sec_page, 0,
> +						    dma_dir, &ctx.xdp)) {
> +				if (!error)
> +					rx_dropped++;
> +				error = 1;
> +			}
>  			buf->sec_page = NULL;
>  		}
> +		frames++;

[ ... ]

> +		skb = stmmac_xdp_run_prog(priv, &ctx.xdp);

[Severity: Medium]
Can this pass a multi-buffer xdp_buff to an XDP program that was loaded
without BPF_F_XDP_HAS_FRAGS?

stmmac_build_xdp_frags() calls xdp_buff_add_frag(), which sets
XDP_FLAGS_HAS_FRAGS. stmmac_xdp_run_prog() then runs whatever program is
attached, and the driver never checks prog->aux->xdp_has_frags.
stmmac_xdp_set_prog() only gates the attach on MTU:

	if (prog && dev->mtu > ETH_DATA_LEN) {

These frames can still arrive at MTU 1500. GMAC_CORE_INIT always sets
GMAC_CONFIG_JE, XGMAC sets GPSL to XGMAC_JUMBO_LEN, and dma_buf_sz is 1536.
On cores with buffer2, a 1537 to 3072 byte frame fills buf1 and buf2 of one
descriptor and becomes a head plus one frag. Larger frames span several
descriptors.

A program that never opted in to frags sees only the head through
data/data_end, but its verdict applies to the whole frame.

Also, stmmac_dvr_probe() still advertises:

	ndev->xdp_features = NETDEV_XDP_ACT_BASIC | NETDEV_XDP_ACT_REDIRECT |
			     NETDEV_XDP_ACT_XSK_ZEROCOPY;

Should NETDEV_XDP_ACT_RX_SG be advertised here? And should programs
without xdp_has_frags either be rejected or kept away from frags-bearing
buffers?

> +		/* Due xdp_adjust_tail: DMA sync for_device
> +		 * cover max len CPU touch
> +		 */
> +		sync_len = ctx.xdp.data_end - ctx.xdp.data_hard_start;
> +		sync_len = max(sync_len, pre_len);
> +
> +		/* For Not XDP_PASS verdict */
> +		if (IS_ERR(skb)) {
> +			unsigned int xdp_res = -PTR_ERR(skb);
> +
> +			if (xdp_res & STMMAC_XDP_CONSUMED) {
> +				stmmac_xdp_put_buff(rx_q, &ctx.xdp, sync_len,
> +						    true);
> +				rx_dropped++;
> +			} else if (xdp_res & (STMMAC_XDP_TX |
> +					      STMMAC_XDP_REDIRECT)) {
> +				xdp_status |= xdp_res;
> +			}

[Severity: Medium]
What happens on XDP_TX when ctx.xdp carries frags? Does the frame go out
truncated to the head buffer?

The path is:

__stmmac_xdp_run_prog()
  stmmac_xdp_xmit_back()
    xdp_convert_buff_to_frame()
    stmmac_xdp_xmit_xdpf()

The converted frame keeps the frags flag, but xdpf->len covers only the
linear head. stmmac_xdp_xmit_xdpf() sets up one descriptor and marks it as
both first and last:

	stmmac_set_tx_dma_entry(tx_q, entry, buf_type, dma_addr, xdpf->len,
				false);
	stmmac_set_tx_dma_last_segment(tx_q, entry);
	...
	stmmac_prepare_tx_desc(priv, tx_desc, 1, xdpf->len,
			       csum, priv->descriptor_mode, true, true,
			       xdpf->len);

The frags are never mapped or queued, yet the action is counted as
successful. The EST SDU check also measures only the head:

	    xdpf->len > priv->est->max_sdu[queue]) {

The frag pages are not leaked, because stmmac_tx_clean() returns them via
xdp_return_frame_rx_napi().

Oversized XDP_TX frames were also truncated before this patch. The
difference is that the program now sees the whole frame and returns
XDP_TX for it.

Should frags-bearing frames be dropped on XDP_TX until
stmmac_xdp_xmit_xdpf() can transmit multiple descriptors?

> +
> +			/* Clear skb as it was set as status by
> +			 * the XDP program
> +			 */
> +			frames = 0;

[Severity: Low]
This isn't a bug, but the comment still talks about clearing skb. The code
now resets frames instead, and skb is a loop-local variable that is never
cleared. Could the comment say that the in-progress frame state is being
dropped?

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261004-stmmac-rx-mb-v3-0-50fa171af9ec%40oss.qualcomm.com
