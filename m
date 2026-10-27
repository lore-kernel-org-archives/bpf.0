Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793092254;
	b=iBpnWFfbTSlTHYsSq5QkTS3Sykm4uMbW/5L+VEn8elzwDlodSJB2GokKw/GqnSg7nmJ0
	 GAyhxJgv1GHSIb1zWQdRn0Iw/WFF99FQHRW8Gv5kFBUlV9oo3Gsx5k16TjfR4cvBQBSDu
	 C2wIa7H7aXq4HLCS1NbOIQdxHpkcVe7+EGUXYwBY/fqShdHI6/X6w44tUxniJ9TPqaazC
	 AzEYH0LwIwhOFjNVcLw+ZgqWSmFuyu9YCroQ7ZLzbbYCK/ZZyF60vdxOLlRCGK6I475Qr
	 XO6tKVEbyLcK/1AK5jYQCPRS/CnB/LXVbecV7L6qb7qHEPmPJJEYhKMx3036N+sWaJQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793092254;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=u/flFy7ABkA1eA9YdJuR33AjqMLm+c8/F20IoDK/Kt4=;
	b=1LI6KvD/5fcSnERovjhG3f2XLqLIFYMMdImmviIUQPBctL96CWsQv9CFd0ppTPWc7jBS
	 U38zEtjlNv6lT8+tEz+qvq+nvOff7Xb6ztDh57kA03C5px9L7Js3S6QuJ7e9ni8eePMEW
	 72upHyICf7yj4MpkV78hn92PrFsewD4AIkZNdbFehf5fs5EHRJHwcOHM1DJ3Vk75nQ2vL
	 XTtBIQ7Ri0qyqI2aejprcmrgf23zL6fq5BYZQ9WWywQebQlCdryENHi+RVvTWJ+0ba1BI
	 2QLe12qgB0+ZeSRvMH/goaIHGCwKpPvmjMojJ7hRg/Gl2tilclFmOxTukHEWOskLv4Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gAcbwxK7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ED6D606A31E;
	Tue, 27 Oct 2026 09:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gAcbwxK7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE63F1F01828;
	Tue, 27 Oct 2026 09:10:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793092253;
	bh=u/flFy7ABkA1eA9YdJuR33AjqMLm+c8/F20IoDK/Kt4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=gAcbwxK7JAN0bXoYlG36I7L0p+Gxz/+fWu2Z5DcnwpErAYl7FZSjs6UMHUQRsBQvx
	 fo1ookShiG+ckmXWBsp45AMJKN5p8LHWdQbWsVbOQea/fLKGruqGBgA8zEgC5NN37f
	 GXMO4N8DapcKw0DcTZ3E/7LtPfaGPgFb5do6ypdDQ2kQZu6n2tAUVtRslFVyZNheW0
	 1xLgvKj8+ZLW2HG7aEqpucUN2Aby3T3yN3O1q4o661u5MUQmM1DkwTAUYehfSCZGCV
	 OvX6iJUKdGY+spIXUUcPEFK2k8yVwZBt36+yPhB0Mj7Up8b+MbLpIl+t3eaP86nEcc
	 cJ2LxBJTosqCg==
Subject:
 Re: [PATCH net 2/6] net: stmmac: drop split frames on AF_XDP zero-copy RX
From: netdev-bot+sashiko@kernel.org
To: lorenzo.bianconi@oss.qualcomm.com
Cc: maxime.chevallier@bootlin.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com, ast@kernel.org,
 daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
 sdf@fomichev.me, Jose.Abreu@synopsys.com, boon.leong.ong@intel.com,
 o.rempel@pengutronix.de, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org
Date: Tue, 27 Oct 2026 09:10:52 +0000
Message-ID: <179309225249.3134.13360572151220701495@kernel.org>
In-Reply-To: <20261023-stmmac-xdp-fixes-v1-2-efb37e19f5bd@oss.qualcomm.com>
References: <20261023-stmmac-xdp-fixes-v1-2-efb37e19f5bd@oss.qualcomm.com>
X-sashiko-severity: Medium
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

Critical: 0 · High: 0 (2) · Medium: 1 (2) · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The commit message does not describe one behaviour change the
  patch makes, and nothing explains the second Fixes tag.

Pre-existing issues:
- [High] On GMAC4/XGMAC, stmmac_rx() in native (non-ZC) XDP mode still
  handles split RX frames wrongly at this commit.
- [High] On AF_XDP zero-copy XDP_PASS, stmmac_dispatch_skb_zc() ignores
  the csum_none bit from the descriptor status.
- [Medium] In stmmac_rx(), if napi_build_skb() fails on the first
  descriptor of a multi-descriptor frame, the code does `rx_dropped++;…
- [Medium] priv->xstats.rx_dropped and priv->xstats.rx_errors are device-
  wide `unsigned long` counters.

--

net: stmmac: drop split frames on AF_XDP zero-copy RX

When stmmac_rx_zc() drops a frame that spans more than one RX descriptor,
it now sets error, so the remaining descriptors are freed and the tail is
not handled as a new frame. The dwmac100/dwmac1000 descriptor callbacks now
return rx_not_ls together with discard_frame for non-last descriptors. The
discard_frame checks in stmmac_rx_zc() and stmmac_rx() change from == to &.

> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index fba21599a5e15..3fa2c15222d88 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -5710,18 +5710,21 @@ static int stmmac_rx_zc(struct stmmac_priv *priv, int limit, u32 queue)
>  		if (priv->extend_desc)
>  			stmmac_rx_extended_status(priv, &priv->xstats,
>  						  rx_q->dma_erx + entry);
> -		if (unlikely(status == discard_frame)) {
> -			xsk_buff_free(buf->xdp);
> -			buf->xdp = NULL;
> -			dirty++;
> +
> +		if (unlikely(!error && (status & discard_frame))) {
>  			error = 1;
>  			if (!priv->hwts_rx_en)
>  				rx_errors++;
>  		}

[Severity: High]
This is a pre-existing issue, but with this test, a dwmac4 frame that only
has csum_none set still reaches the XDP program. That covers an L4 payload
checksum error without RDES3 ERROR_SUMMARY. On XDP_PASS the frame goes to
stmmac_dispatch_skb_zc(), and that function never receives status:

stmmac_dispatch_skb_zc() {
    ...
	if (unlikely(!coe) || !stmmac_has_ip_ethertype(skb))
		skb_checksum_none_assert(skb);
	else
		skb->ip_summed = CHECKSUM_UNNECESSARY;
    ...
}

dwmac4_dma_rx_chan_op_mode() always sets MTL_OP_MODE_DIS_TCP_EF, so the
hardware does not drop these frames. dwmac4_wrback_get_rx_status() reports
them with no discard_frame:

	if (rdes1 & RDES1_IP_PAYLOAD_ERROR) {
		x->ip_payload_err++;
		ret |= csum_none;
	}

Can a packet with a bad TCP/UDP checksum get marked CHECKSUM_UNNECESSARY
on the AF_XDP zero-copy XDP_PASS path and be delivered to sockets?

stmmac_rx() checks (status & csum_none) before it sets
CHECKSUM_UNNECESSARY. Should stmmac_dispatch_skb_zc() do the same check?
The gap is still there at the end of the series.

[ ... ]

> @@ -5730,8 +5733,9 @@ static int stmmac_rx_zc(struct stmmac_priv *priv, int limit, u32 queue)
>  		if (likely(status & rx_not_ls)) {
>  			xsk_buff_free(buf->xdp);
>  			buf->xdp = NULL;
> +			rx_dropped++;
> +			error = 1;
>  			dirty++;
> -			count++;
>  			goto read_again;
>  		}

[Severity: Medium]
This is a pre-existing issue, but the rx_dropped count added here is added
to the device-wide counter at the end of stmmac_rx_zc():

	priv->xstats.rx_dropped += rx_dropped;
	priv->xstats.rx_errors += rx_errors;

stmmac_rx() does the same thing, and stmmac_dispatch_skb_zc() does
priv->xstats.rx_dropped++. These are plain unsigned long read-modify-writes
with no lock, no atomic and no per-queue split.

NAPI polls for different RX queues can finish at the same time on
different CPUs. Can they lose increments here, so that stmmac_get_stats64()
under-reports rx_dropped and rx_errors?

[ ... ]

> @@ -5898,7 +5902,8 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
>  
>  		if (priv->extend_desc)
>  			stmmac_rx_extended_status(priv, &priv->xstats, rx_q->dma_erx + entry);
> -		if (unlikely(status == discard_frame)) {
> +
> +		if (unlikely(status & discard_frame)) {
>  			page_pool_put_page(rx_q->page_pool, buf->page, 0, true);
>  			buf->page = NULL;
>  			error = 1;

[Severity: Medium]
The commit message does not seem to describe this change or explain the
second Fixes tag:

    Fixes: 644b8437ccef9e ("net: stmmac: dwmac4: report Rx checksum errors in status")

Is this change from == to & the actual fix for 644b8437ccef9e?
dwmac4_wrback_get_rx_status() sets ret = discard_frame on
RDES3_ERROR_SUMMARY. It then ORs in csum_none on RDES1_IP_HDR_ERROR or
RDES1_IP_PAYLOAD_ERROR, so it can return discard_frame | csum_none.

The old status == discard_frame test missed that value. Frames with CRC,
overflow, watchdog or giant errors that also failed the IP checksum were
passed to the stack in stmmac_rx(), or to XDP/XSK in stmmac_rx_zc().

The fix looks correct. However, the body only covers the AF_XDP zero-copy
1:1 drop and the dwmac100/dwmac1000 descriptor change, and this hunk
changes the regular non-XDP RX path on every GMAC4/XGMAC system.

Could the commit message describe this change and the 644b8437ccef9e
regression it fixes?

[Severity: High]
This is a pre-existing issue, but does stmmac_rx() in native XDP mode
still mishandle split frames on GMAC4/XGMAC? For a non-last descriptor,
dwmac4_wrback_get_rx_status() returns rx_not_ls without discard_frame:

	if (likely(!(rdes3 & RDES3_LAST_DESCRIPTOR)))
		return rx_not_ls;

So the discard_frame drain above never starts, and the XDP program sees
the first fragment as a complete frame. On XDP_DROP:

				if (xdp_res & STMMAC_XDP_CONSUMED) {
					...
					skb = NULL;

					if (unlikely((status & rx_not_ls)))
						goto read_again;

skb is NULL and error is still 0. The tail then goes through XDP again
and can be passed to the stack as a new packet.

On XDP_TX or XDP_REDIRECT the code does goto next, which clears
in_progress. The next iteration resets len to 0, so stmmac_rx_buf1_len()
reports the full dma_buf_sz for the tail. Can that expose stale page_pool
contents that DMA did not write for this frame?

This is the same kind of bug the patch fixes for stmmac_rx_zc(), but here
stmmac_rx() is only covered for dwmac100/dwmac1000. The next patch in the
series, "net: stmmac: drop multi-buffer frames in XDP mode", appears to
fix it. That patch sets error on rx_not_ls in XDP mode, drops frames that
use buf2_len, and makes the XDP_CONSUMED path goto next.

[Severity: Medium]
This is a pre-existing issue, but stmmac_rx() has a similar problem when
napi_build_skb() fails on the first descriptor of a multi-descriptor
frame:

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

error is not set, so drain_data jumps to read_again with skb == NULL and
error == 0. If allocation succeeds on the next descriptor of the same
frame, the if (!skb) branch builds a new skb from only the tail fragment.

At the last descriptor, pskb_trim(skb, len) does nothing. len still
includes the dropped first fragment, so it is larger than skb->len.

Does this pass the tail to the stack as a standalone packet with its FCS
still attached, and count the frame against the budget twice? Should this
path set error so the rest of the frame is drained?

At the end of the series this only happens in non-XDP mode, because XDP
mode now sets error on rx_not_ls.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261023-stmmac-xdp-fixes-v1-0-efb37e19f5bd%40oss.qualcomm.com
