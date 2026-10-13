Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 677EF480DF7;
	Tue, 13 Oct 2026 17:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791912803; cv=none; b=L/QDy7sev5Lp9Cl80TUNS8vx9/hhfsZpnRmSW7/jC1vfTjiyQXDSGTtayDc6/LMIC99MZqoN9LoL53zUpWEajk/FBdHK2nX/wUlzCfd8fzUAEemjqlI+2LjgI7Vc38l9mggrYhOgDrgYRcTVjhJlu/RWep0k90lNKgWKR26LvsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791912803; c=relaxed/simple;
	bh=HN/u8Q9WI36JC0Kz+NGJtgk9BjLNQANbjWAxhMI0kXs=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mcnnAo/IPuyuLsGxr3vwrtMANsTmwKMy00e23SskJnWlYJXzd42dfh4qWtV5PbpHO4V8QDSvZeNgabx0umxpQI27UvLXcuLgZk7nzb+nNqOGX9aDrmnqtyNseE0DQsATiBToa13/R/dxjjdhqges6zI4kPyHLaq0ARgsharCsFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U36JkaS+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U36JkaS+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 376651F000FF;
	Tue, 13 Oct 2026 17:33:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791912801;
	bh=zpVULbRYJKU83CTGHL5CwhzORJ7BhBP+deYnB7SA/2g=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=U36JkaS+gfg/tWQkQkHmkOMrP9aMpVn3g5B20hkYlkGSkVX434slElgGX5QfG+E+X
	 BaP71Qo/vRe+vXrXrML/E+M7rMJIvVRWtbRgwKL3nm7Vo1jPDC7OF+w46JpDD3KKCg
	 hcSPbphOh+AXmu8frVu2Nl7nD9mATi6uKjf8L56pgAoDakbniO+mI1qxisGhxTinqX
	 ZmKCNltnUasboTGjSm9viDM4Xnx2dkYKtyGhzYCH4NwRjEkCSkl+GhVdNykQBfjKVF
	 8zlJ3wWQHpaA8tgn1R6OPH8wPNJ7RDbWDcuTO/8lKj+dJesfcUlWOGFq4E38ryqhIn
	 H3/yiMy2QTXlQ==
Subject: Re: [PATCH net-next v6 4/4] net: stmmac: rework stmmac_rx to support
 XDP rx multi-buff
From: netdev-bot+sashiko@kernel.org
To: lorenzo.bianconi@oss.qualcomm.com
Cc: maxime.chevallier@bootlin.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com, ast@kernel.org,
 daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
 sdf@fomichev.me, Jose.Abreu@synopsys.com, boon.leong.ong@intel.com,
 netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 bpf@vger.kernel.org
Date: Tue, 13 Oct 2026 17:33:19 +0000
Message-ID: <179191279975.434549.8306729661220801505@kernel.org>
In-Reply-To: <20261012-stmmac-rx-mb-v6-4-2225050915c1@oss.qualcomm.com>
References: <20261012-stmmac-rx-mb-v6-4-2225050915c1@oss.qualcomm.com>
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

Critical: 0 · High: 0 (1) · Medium: 1 (2) · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] stmmac_build_skb() now calls skb_metadata_set(skb, metasize)
  (stmmac_main.c:5847), so the XDP metadata sits right before skb->data.
- [Low] The commit message says the old stmmac_rx() had two bugs on
  multi-descriptor frames, and that accumulating the frame before…

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but this patch
  fixes it without saying so, and the net portion of the series leaves…
- [Medium] This problem wasn't introduced by this patch, but
  stmmac_construct_skb_zc() (AF_XDP zero-copy XDP_PASS path) allocates a…
- [Medium] This problem wasn't introduced by this patch, but
  dwmac4_wrback_get_rx_status() loads RDES1 and RDES2 before it loads…

--

net: stmmac: rework stmmac_rx to support XDP rx multi-buff

This commit reworks stmmac_rx() so that all descriptors of a frame are
collected into an xdp_buff before the XDP program runs. On XDP_PASS the
skb is built from that xdp_buff with napi_build_skb() and
xdp_update_skb_frags_info(). The in-progress xdp_buff is kept in
rx_q->state across NAPI polls, XDP metadata is passed to the skb, the
FCS is stripped with a driver-local tail shrink, and
NETDEV_XDP_ACT_RX_SG is advertised.

> For those multi-descriptor frames the old code was buggy as well: it ran
> the XDP program once per descriptor buffer, so for a multi-descriptor
> frame the program was also invoked on continuation buffers holding
> mid-frame payload. It also subtracted ETH_FCS_LEN from the first buffer
> even when it was not the last descriptor (its second buffer empty),
> dropping four bytes from the middle of the frame while marking the FCS as
> already stripped and skipping the final pskb_trim(). Accumulating the
> whole frame before running XDP fixes both.

[Severity: Low]
Does this describe the code being replaced? The parent commit "net:
stmmac: drop multi-buffer frames in XDP mode" added this check, and this
patch removes it:

    /* We do not support SG in XDP mode */
    if (unlikely(!error && (status & rx_not_ls) &&
                 stmmac_xdp_is_enabled(priv))) {
        rx_dropped++;
        error = 1;
    }

With a program attached, every non-last descriptor is marked as an error
before it reaches the block that runs the program and does:

    if (stmmac_xdp_is_enabled(priv) && !buf2_len) {
        buf1_len -= ETH_FCS_LEN;
        fcs_stripped = true;
    }

In XDP mode only single-descriptor frames get there. Neither problem
seems reachable in the parent.

The message also does not say what actually changes relative to the
parent. Multi-descriptor frames that used to be dropped in XDP mode now
go to programs loaded with BPF_F_XDP_HAS_FRAGS.

Could the commit message describe that change instead?

> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index 8c08d44fdbd39..fd04368543c23 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c

[ ... ]

> @@ -5801,6 +5807,118 @@ static int stmmac_rx_zc(struct stmmac_priv *priv, int limit, u32 queue)

[ ... ]

> +static struct sk_buff *stmmac_build_skb(struct xdp_buff *xdp)
> +{
> +	struct skb_shared_info *sinfo = xdp_get_shared_info_from_buff(xdp);
> +	u32 metasize = xdp->data - xdp->data_meta;
> +	struct sk_buff *skb;
> +	u8 num_frags = 0;
> +
> +	if (unlikely(xdp_buff_has_frags(xdp)))
> +		num_frags = sinfo->nr_frags;
> +
> +	skb = napi_build_skb(xdp->data_hard_start, xdp->frame_sz);
> +	if (!skb)
> +		return NULL;
> +
> +	skb_mark_for_recycle(skb);
> +	skb_reserve(skb, xdp->data - xdp->data_hard_start);
> +	skb_put(skb, xdp->data_end - xdp->data);
> +	if (metasize)
> +		skb_metadata_set(skb, metasize);

[Severity: Medium]
Now that the regular RX path sets metadata, does the software VLAN
stripping later in stmmac_rx() corrupt it?

When priv->hw->hw_vlan_en is false (GMAC 3.x and dwmac100 cores),
stmmac_rx() calls stmmac_rx_vlan(), which does this for a tagged frame:

    memmove(skb->data + VLAN_HLEN, veth, ETH_ALEN * 2);
    skb_pull(skb, VLAN_HLEN);

The metadata is not moved. eth_type_trans() then sets mac_header at the
pulled data, and skb_metadata_end() returns skb_mac_header(skb).

So data_meta as seen by TC/BPF would cover
[orig_data + 4 - metasize, orig_data + 4). The first 4 metadata bytes
are lost, and the last 4 bytes are the old start of the destination MAC.

skb_reorder_vlan_header() and the skb_postpull_data_move()/skb_data_move()
helpers move the metadata together with the data. Should
stmmac_rx_vlan() do the same?

[Severity: Medium]
This is a pre-existing issue, not one introduced by this patch. The
AF_XDP zero-copy counterpart, stmmac_construct_skb_zc(), still sets the
metadata length without copying the metadata:

    skb = napi_alloc_skb(&ch->rxtx_napi,
                         xdp->data_end - xdp->data_hard_start);
    ...
    skb_reserve(skb, xdp->data - xdp->data_hard_start);
    memcpy(__skb_put(skb, datasize), xdp->data, datasize);
    if (metasize)
        skb_metadata_set(skb, metasize);

The bytes in front of skb->data in the new skb are uninitialized
headroom, not what the program wrote with bpf_xdp_adjust_meta().
xdp_build_skb_from_zc() in net/core/xdp.c copies from xdp->data_meta
before it sets the metadata length.

Should the ZC XDP_PASS path copy the metadata too?

[ ... ]

> @@ -5900,19 +6019,11 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
>  				rx_errors++;
>  		}
>  

[Severity: Medium]
This isn't a bug introduced by this patch, but the status used here
comes from dwmac4_wrback_get_rx_status(). That function loads the other
descriptor words before the ownership word and has no barrier after the
OWN check:

    u32 rdes1 = le32_to_cpu(p->des1);
    u32 rdes2 = le32_to_cpu(p->des2);
    u32 rdes3 = le32_to_cpu(p->des3);
    ...
    if (unlikely(rdes3 & RDES3_OWN))
        return dma_own;

If the DMA write-back lands between these loads, can a descriptor with
OWN already clear be paired with stale read-format RDES1/RDES2 contents?

That could give wrong checksum-error bits (and CHECKSUM_UNNECESSARY), a
spurious discard_frame from the filter-fail bits, or wrong PTP stats.
The XGMAC descriptor ops use dma_rmb() for this.

Would reading RDES3 first, followed by dma_rmb(), be needed here?

[ ... ]

> @@ -5922,121 +6033,89 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)

[ ... ]

> -		if (!skb) {
> -			unsigned int head_pad_len;
> -
> -			/* XDP program may expand or reduce tail */
> -			buf1_len = ctx.xdp.data_end - ctx.xdp.data;
> -
> -			skb = napi_build_skb(page_address(buf->page),
> -					     rx_q->napi_skb_frag_size);
> -			if (!skb) {
> -				page_pool_recycle_direct(rx_q->page_pool,
> -							 buf->page);
> -				buf->page = NULL;
> -				rx_dropped++;
> -				count++;
> -				goto drain_data;
> -			}

[Severity: High]
This is a pre-existing issue, not one introduced by this patch, but this
hunk also removes an existing crash path that the commit message does
not mention.

Without XDP, the old code uses skb == NULL as the only start-of-frame
marker. If napi_build_skb() fails on the first descriptor of a
multi-descriptor frame, the code reaches drain_data with skb still NULL
and error still 0:

    drain_data:
        if (likely(status & rx_not_ls))
            goto read_again;

The next continuation descriptor then goes through the if (!skb)
head-building branch. With no program attached, stmmac_xdp_run_prog()
returns ERR_PTR(0), which is NULL. A new skb is then built from
mid-frame payload.

With SPH active, stmmac_rx_buf1_len() returns 0 for non-first
descriptors:

    if (priv->sph_active && len)
        return 0;

So the rebuilt skb has an empty linear area and all of its data in
frags. pskb_trim(skb, len) does nothing because len > skb->len. Can
that then reach:

stmmac_rx()
  eth_type_trans()
    eth_skb_pull_mac()
      __skb_pull()
        BUG()    /* skb->len < skb->data_len */

Without SPH, a piece of mid-frame payload is passed up as a standalone
Ethernet frame.

The new code builds the skb only at the last descriptor and sends a
stmmac_build_skb() failure to error_free_frag, so the problem is gone
after this patch. "net: stmmac: drop multi-buffer frames in XDP mode"
only covers XDP mode, and this rework has no Fixes tag. Backports that
take only the Fixes-tagged patches would keep the crash.

Should the napi_build_skb() failure path be fixed separately for net,
for example by setting error so the rest of the frame is drained? Should
this commit message also mention it?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261012-stmmac-rx-mb-v6-0-2225050915c1%40oss.qualcomm.com
