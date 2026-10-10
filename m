Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D2A93F7AAB;
	Sat, 10 Oct 2026 10:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791629850; cv=none; b=vESz965z7GIme3bYSefrwuqxldOAh8lrdeZTk+sUCbXkhfBuRgj3Tx8Q5iea6eEnMx+V4qT66WuIaupWPCmsHV2Yzytps/fKY+UsSbLhtzaE+7xkQGIwq5lAZN6LNLN9AK81b5bpi8jB9T7T/duDqiaTN1mPE86tIiwSxdid1CI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791629850; c=relaxed/simple;
	bh=IfInewqaRmE5XoZppArwZjbhSVmaByRJqXTTCga6c0w=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fEryh/uWM99wSU3+68afUeIAdNjUQW2BBClp9LEhu9l2eYZsVrnU3zt5VWCqZXu4BGleHbxORzGQFBqsl+gIxeVuHTJCvpCsn5Kskv3Bk3RV/8+glknxxc45DklF5AnU2AT/i82RAOA96FWARZ48SOPF7nDcWk3HjLNFabfgeFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MmwOjrGm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MmwOjrGm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B7051F00893;
	Sat, 10 Oct 2026 10:57:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791629848;
	bh=cDpzh8snde2DrbYD3nbEyBcY5NRzic5bDOx/g+dEz1c=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=MmwOjrGmRMH+qpCx1I1c0Deu/rOECANW5EcEiwGerYumiQ2110aJhf0WahtVLY4nd
	 8rbYbi7t4IBqwQz86CrXKo357Ig0n2v/HNDvnoxR4gDoXFBkA1W5u81jAxkoMSvEeZ
	 VngUcur0H/V9hPgRZIMMwaXft/62+cZSiQj5r3iSsxFph27BJUMtVOYwmGA57G6xw+
	 IdTL7VwIhEBf4jt60/uouqxZnEwbVE+1DCtKSiPjXhQ2h5RYq03PZqQ7+JLsyeoefv
	 a3yASxhuLWK23zXAZwT4+r0siWJRdy3mkEVbUvhnYG8PItJWzTOF9TjSE14MOmjxty
	 ER8vhW5NPMnmg==
Subject: Re: [PATCH net-next v5 2/3] net: stmmac: rework stmmac_rx to support
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
Date: Sat, 10 Oct 2026 10:57:27 +0000
Message-ID: <179162984714.434549.15271899639928787617@kernel.org>
In-Reply-To: <20261009-stmmac-rx-mb-v5-2-c38fa4eaa138@oss.qualcomm.com>
References: <20261009-stmmac-rx-mb-v5-2-c38fa4eaa138@oss.qualcomm.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 4 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 2 (2) · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] net: stmmac: OOB read in stmmac_rx_zc() for multi-buffer frames
- [Medium] Real RX bug fixes are bundled into a net-next feature rework
  that has no Fixes: tag.
- [Medium] The patch now attaches XDP metadata to the skb in
  stmmac_build_skb() (skb_metadata_set(skb, metasize)).
- [Low] The new error branch in stmmac_rx() frees both buf->page and
  buf->sec_page for every descriptor seen while `error` is set.

Pre-existing issues:
- [Medium] This problem wasn't introduced by this patch, but the AF_XDP
  zero-copy XDP_PASS path still loses metadata contents.
- [Medium] This problem wasn't introduced by this patch, but RX
  descriptor reads have no DMA read ordering.

--

net: stmmac: rework stmmac_rx to support XDP rx multi-buff

This reworks stmmac_rx() so all descriptors of a frame are collected into
an xdp_buff before the XDP program runs. The skb is then built from that
xdp_buff with napi_build_skb() and xdp_update_skb_frags_info(). The
in-progress xdp_buff is kept in rx_q->state across NAPI polls,
NETDEV_XDP_ACT_RX_SG is advertised, XDP metadata is carried into the skb,
and the FCS is stripped by a new stmmac_xdp_shrink_tail() helper.

> For those multi-descriptor frames the old code was buggy as well: it ran
> the XDP program once per descriptor buffer, so for a multi-descriptor
> frame the program was also invoked on continuation buffers holding
> mid-frame payload. It also subtracted ETH_FCS_LEN from the first buffer
> even when it was not the last descriptor (its second buffer empty),
> dropping four bytes from the middle of the frame while marking the FCS as
> already stripped and skipping the final pskb_trim(). Accumulating the
> whole frame before running XDP fixes both.

[ ... ]

> Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>

[Severity: Medium]
The paragraph above describes two existing RX bugs in stmmac_rx():

- the XDP program runs once per descriptor buffer.
- ETH_FCS_LEN is subtracted from buffer1 of a non-last descriptor
  whenever stmmac_xdp_is_enabled(priv) && !buf2_len.

The old path also lost XDP metadata on XDP_PASS.
xdp_prepare_buff() was called with meta_valid=true, but
skb_metadata_set() was never called.

The FCS strip logic came from 88095728511e ("net: stmmac: fix rx
Scatter-Gather support"). That commit carries Fixes: 88ebe2cf7f3f, so it
is headed for stable. The per-descriptor XDP invocation goes back to
5fabb01207a2 and be8b38a722e6 from 2021.

GMAC4 sets GMAC_CONFIG_JE unconditionally. So even at MTU 1500 with XDP
loaded, a remote peer can send a frame that spans several descriptors.
The mid-frame FCS strip additionally needs stmmac_rx_check_buf2_cap() to
be false, which is the case on legacy cores.

Here these fixes are only side effects of a patch that also adds
NETDEV_XDP_ACT_RX_SG and multi-buffer support. The only trailer is
Signed-off-by. The first patch in this series ("net: stmmac: take
ownership of saved RX state at poll entry") does carry Fixes: tags.

Could the fixes go in a separate patch with Fixes: tags, so they can be
picked up for net and stable? As it stands, stable trees that take
88095728511e will keep the per-descriptor XDP run, the mid-frame FCS
strip and the dropped metadata.

> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index 6128e6d9504c8..be2cba8fcbc6d 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c

[ ... ]

> @@ -5798,6 +5804,118 @@ static int stmmac_rx_zc(struct stmmac_priv *priv, int limit, u32 queue)
>  	return failure ? limit : (int)count;
>  }
>  

[Severity: High]
This isn't a bug introduced by this patch. The commit message calls
this work groundwork for XDP on frames that span several descriptors,
though, and the AF_XDP zero-copy receive path still mishandles such
frames. stmmac_rx_zc() releases every non-last descriptor of a frame
without adding its length to len:

drivers/net/ethernet/stmicro/stmmac/stmmac_main.c:stmmac_rx_zc() {
    ...
	/* XSK pool expects RX frame 1:1 mapped to XSK buffer */
	if (likely(status & rx_not_ls)) {
		xsk_buff_free(buf->xdp);
		buf->xdp = NULL;
		dirty++;
		count++;
		goto read_again;
	}
    ...
	buf1_len = stmmac_rx_buf1_len(priv, p, status, len);
    ...
}

When the last descriptor arrives, len is still 0, or whatever was
saved at the previous poll boundary. stmmac_rx_buf1_len() therefore
computes min(dma_buf_sz, plen - len) from the full frame length, not
from the bytes left for this descriptor. For a frame longer than
dma_buf_sz that gives dma_buf_sz. The DMA only wrote the last
plen - (n - 1) * dma_buf_sz bytes into this XSK buffer.

buf->xdp->data_end is then set from that value. The XDP program, an
AF_XDP socket on XDP_REDIRECT, and stmmac_construct_skb_zc() on
XDP_PASS all receive the tail of the frame plus whatever was left in
the UMEM chunk, presented as a complete packet. The head of the frame
is silently lost, and none of this is counted in rx_dropped.

As noted above, GMAC4 sets GMAC_CONFIG_JE unconditionally. A remote
peer can therefore already send such frames while an XSK pool is
bound, whatever the MTU check in stmmac_xdp_set_prog() allows.

Fixing only the len accounting would still hand userspace the tail of
the frame as if it were a whole packet. Should stmmac_rx_zc() instead
mark the frame as errored on the first rx_not_ls descriptor? The last
descriptor would then be released too, and the whole frame accounted
as dropped.

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
This isn't a bug introduced by this patch, but the AF_XDP zero-copy
XDP_PASS path still loses the metadata contents.
stmmac_construct_skb_zc() copies only the packet bytes into the new skb:

drivers/net/ethernet/stmicro/stmmac/stmmac_main.c:stmmac_construct_skb_zc() {
    ...
	skb_reserve(skb, xdp->data - xdp->data_hard_start);
	memcpy(__skb_put(skb, datasize), xdp->data, datasize);
	if (metasize)
		skb_metadata_set(skb, metasize);
    ...
}

skb_metadata_set() only records meta_len. The bytes in
[xdp->data_meta, xdp->data) are never copied.

Take a program that calls bpf_xdp_adjust_meta() and returns XDP_PASS,
on the path stmmac_rx_zc()->stmmac_dispatch_skb_zc()->
stmmac_construct_skb_zc(). Would a TC/BPF program then read
uninitialized skb headroom through data_meta?

Other drivers such as i40e copy from xdp->data_meta instead. The commit
message says metadata is now carried into the skb. Should the ZC path
get the same treatment?

> +
> +	if (unlikely(xdp_buff_has_frags(xdp)))
> +		xdp_update_skb_frags_info(skb, num_frags, sinfo->xdp_frags_size,
> +					  num_frags * xdp->frame_sz,
> +					  xdp_buff_get_skb_flags(xdp));
> +	return skb;
> +}

[ ... ]

> @@ -5891,19 +6010,24 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
>  		if (priv->extend_desc)
>  			stmmac_rx_extended_status(priv, &priv->xstats, rx_q->dma_erx + entry);
>  		if (unlikely(status == discard_frame)) {
> -			page_pool_put_page(rx_q->page_pool, buf->page, 0, true);
> -			buf->page = NULL;
>  			error = 1;
>  			if (!priv->hwts_rx_en)
>  				rx_errors++;
>  		}

[Severity: Medium]
This is a pre-existing issue, but is a DMA read barrier missing between
the ownership check and the reads of the other descriptor words?
dwmac4_wrback_get_rx_status() loads des1 and des2 before it checks
RDES3_OWN:

drivers/net/ethernet/stmicro/stmmac/dwmac4_descs.c:dwmac4_wrback_get_rx_status() {
	u32 rdes1 = le32_to_cpu(p->des1);
	u32 rdes2 = le32_to_cpu(p->des2);
	u32 rdes3 = le32_to_cpu(p->des3);
    ...
	if (unlikely(rdes3 & RDES3_OWN))
		return dma_own;
    ...
}

stmmac_rx() has no dma_rmb() after its dma_own check either. On weakly
ordered CPUs such as arm64, could des1/des2 be read before the DMA
writeback and des3 after it?

If so, a stale rdes1 could be missing RDES1_IP_PAYLOAD_ERROR or
RDES1_IP_HDR_ERROR, and a frame with a bad checksum would be marked
CHECKSUM_UNNECESSARY. Stale rdes2 bits could also cause spurious
filter-fail drops.

>  
> -		if (unlikely(error && (status & rx_not_ls)))
> -			goto read_again;
> -
>  		if (unlikely(error)) {
> -			dev_kfree_skb(skb);
> -			goto next;
> +			page_pool_put_page(rx_q->page_pool, buf->page, 0, true);
> +			buf->page = NULL;
> +			if (buf->sec_page) {
> +				page_pool_put_page(rx_q->page_pool,
> +						   buf->sec_page, 0, true);
> +				buf->sec_page = NULL;
> +			}

[Severity: Low]
This frees buf->sec_page for every descriptor seen while error is set.
On GMAC4, dwmac4_wrback_get_rx_status() returns discard_frame for RX
timestamp context descriptors:

	if (unlikely(rdes3 & RDES3_CONTEXT_DESCRIPTOR))
		return discard_frame;

The DMA writes only descriptor words for those slots, so their pages are
still valid. With hwts_rx_en, every timestamped frame is followed by such
a slot.

Before this patch, discard_frame released only buf->page and sec_page
stayed attached. Continuation descriptors of an errored frame also kept
their pages.

Is it intended that each context slot now hands two DMA-mapped pages
back to the page_pool? stmmac_rx_refill() then has to allocate a new
sec_page with GFP_ATOMIC for each one. It stops at the first allocation
failure, so this adds one more way for ring re-arming to stall under
memory pressure.

> +
> +			if (status & rx_not_ls)
> +				goto read_again;
> +
> +			goto error_free_frag;
>  		}

[ ... ]

> @@ -5913,131 +6037,89 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)

[ ... ]

> +		skb = stmmac_build_skb(&ctx.xdp);
> +		if (!skb) {
> +			rx_dropped++;
> +			goto error_free_frag;
> +		}
> +
> +		/* Got entire packet into SKB. Finish it. */
>  		stmmac_get_rx_hwtstamp(priv, p, np, skb);
>  
>  		if (priv->hw->hw_vlan_en)

[Severity: Medium]
stmmac_build_skb() now calls skb_metadata_set(skb, metasize). That
assumes the metadata sits directly before the MAC header, because
skb_metadata_end() returns skb_mac_header(skb).

When hw_vlan_en is false, stmmac_rx_vlan() pops the tag by moving the
MAC addresses forward. This happens on dwmac100/dwmac1000 cores with
NETIF_F_HW_VLAN_CTAG_RX set, for example:

drivers/net/ethernet/stmicro/stmmac/stmmac_main.c:stmmac_rx_vlan() {
    ...
		memmove(skb->data + VLAN_HLEN, veth, ETH_ALEN * 2);
		skb_pull(skb, VLAN_HLEN);
    ...
}

The metadata stays where it is, and eth_type_trans() then sets the MAC
header VLAN_HLEN bytes further in. For VLAN-tagged frames, would TC/BPF
programs reading data_meta lose the first 4 metadata bytes and see 4
bytes of the original destination MAC in their place?

The core helper skb_reorder_vlan_header() moves the metadata along with
the header:

net/core/skbuff.c:skb_reorder_vlan_header() {
    ...
	meta_len = skb_metadata_len(skb);
	if (meta_len) {
		meta = skb_metadata_end(skb) - meta_len;
		memmove(meta + VLAN_HLEN, meta, meta_len);
	}
    ...
}

Before this patch the metadata was dropped (meta_len 0) rather than
misaligned.

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261009-stmmac-rx-mb-v5-0-c38fa4eaa138%40oss.qualcomm.com
