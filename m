Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAFBB42E409;
	Thu,  8 Oct 2026 22:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791497033; cv=none; b=CyQ/qNtA6MfaK9riNKjoAraz9EbXz7Vgn5NomZBuYlF2U4+KLHslqwBjnRKrk+r+aZPNjwumvoyC7LDOLn3guIKT8zTsL2yxAP1zWVFFNQ/zrLWQ96ahnOpHbJaoAKpST40Upx6UnWO/hLZ7NyXNMrakg/GJffOuSokMFeC02eM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791497033; c=relaxed/simple;
	bh=uW8xAq+kT2uPydbaHnpoUJnrC1uhobnhX2n7DLwq9lg=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UiZuxJWdjyFdJHyYDcUtPRg6fH8MSXpyqdr87qqAd+0VJvK/8XEk2jPz2ApS1RKfvAhA5Eeoxo/ZoI/BNb8WzPO5JmMyWpFRJPW2blKxrAOFT3mQJ6kszS+/BMQKbDupDCXH8N+70RqSc8MRYuG3d3aIfzVdaspfrxsZWFZWx0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PCj+nDv2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PCj+nDv2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F2541F00893;
	Thu,  8 Oct 2026 22:03:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791497031;
	bh=H71LY/qIbTaE4K5cPQ97cERMkdFiBj3SwCKAC1VMl+M=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=PCj+nDv2YmDOdsMFw+WZEOpdWpjlN4DMYZXmVZLatIJI5R7WUPdVyH5ZHqbaYIovu
	 687QvEU2vAIm+2D834BQJjjH6054bK2ZjCP1Gvsc3Se9so10tADXZd4rp8V/dyRcGJ
	 dkcPiBVr+1uS0RBP0bfFi9DmNCIfH6DXhr6RQsE3ou6SWLdiwoa3JRJ8WbFYa8cSij
	 Cru2bidItoVHNBD+lPH2ltgjfX5R8wlyKIMdd/5Oh03XXbdQqFo70f7VTCWpFWlrMg
	 SOIqjjnhzqWPjAEAtGkOshYFHMjqe1BYFq0MNEnWFl0CIZNACGQT5hqn6i6FrWxSKY
	 EpJ7GJn+yjzZQ==
Subject: Re: [PATCH net-next v4 2/2] net: stmmac: rework stmmac_rx to support
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
Date: Thu, 08 Oct 2026 22:03:49 +0000
Message-ID: <179149702992.434549.11258705725205285914@kernel.org>
In-Reply-To: <20261006-stmmac-rx-mb-v4-2-efa4ca974e3d@oss.qualcomm.com>
References: <20261006-stmmac-rx-mb-v4-2-efa4ca974e3d@oss.qualcomm.com>
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

Critical: 0 · High: 1 · Medium: 1 · Low: 2

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The patch advertises NETDEV_XDP_ACT_RX_SG, and stmmac_rx() now
  gives the XDP program a multi-buffer xdp_buff.
- [Medium] XDP programs loaded without BPF_F_XDP_HAS_FRAGS
  (prog->aux->xdp_has_frags == false) now receive multi-buffer…
- [Low] The rework quietly fixes a live RX bug in the previous
  stmmac_rx() for multi-descriptor frames when XDP is attached.
- [Low] The new stmmac_build_skb() computes metasize = xdp->data -
  xdp->data_meta and calls skb_metadata_set(skb, metasize).

--

net: stmmac: rework stmmac_rx to support XDP rx multi-buff

This commit reworks stmmac_rx() so that all descriptors of a frame are
collected into one xdp_buff. The XDP program then runs on the full,
possibly fragmented, packet, and on XDP_PASS the skb is built from that
xdp_buff. The in-progress xdp_buff is kept in rx_q->state across NAPI
polls, the FCS is stripped with a new stmmac_xdp_shrink_tail() helper,
and NETDEV_XDP_ACT_RX_SG is advertised.

> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index 28e9f8438f93f..742866466526e 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c

[ ... ]

> @@ -5758,6 +5763,118 @@ static int stmmac_rx_zc(struct stmmac_priv *priv, int limit, u32 queue)

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

[Severity: Low]
This isn't a bug, but the skb_metadata_set() call changes behavior, and
the commit message doesn't list it.

The old XDP_PASS path (napi_build_skb() + skb_reserve() + skb_put()) never
set the skb metadata length. Metadata written with bpf_xdp_adjust_meta()
was therefore dropped. With this patch it is carried into the skb, and
TC/BPF programs can read it through data_meta.

Could this be added to the list of changes in the commit message?

[ ... ]

> @@ -5873,121 +5996,89 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
>  		buf2_len = stmmac_rx_buf2_len(priv, p, status, len);
>  		len += buf2_len;
>  
> -		/* ACS is disabled; strip manually. */
> -		if (likely(!(status & rx_not_ls)))
> -			len -= ETH_FCS_LEN;
> -
> -		if (!skb) {
> -			unsigned int pre_len, sync_len;
> -
> -			/* Each frame starts here: reset the FCS handling */
> -			fcs_stripped = false;
> -
> +		if (!frames) {
>  			dma_sync_single_for_cpu(priv->device, buf->addr,
>  						buf1_len, dma_dir);
>  			net_prefetch(page_address(buf->page) +
>  				     buf->page_offset);
>  
> -			if (stmmac_xdp_is_enabled(priv) && !buf2_len) {
> -				buf1_len -= ETH_FCS_LEN;
> -				fcs_stripped = true;
> -			}
> -

[ ... ]

> -			/* For Not XDP_PASS verdict */
> -			if (IS_ERR(skb)) {
> -				unsigned int xdp_res = -PTR_ERR(skb);
> -
> -				if (xdp_res & STMMAC_XDP_CONSUMED) {
> -					page_pool_put_page(rx_q->page_pool,
> -							   virt_to_head_page(ctx.xdp.data),
> -							   sync_len, true);
> -					buf->page = NULL;
> -					rx_dropped++;
> -					goto next;
> -				} else if (xdp_res & (STMMAC_XDP_TX |
> -						      STMMAC_XDP_REDIRECT)) {
> -					xdp_status |= xdp_res;
> -					buf->page = NULL;
> -					goto next;
> -				}
> -			}
> -		}

[Severity: Low]
Does this rework also fix an existing RX bug for multi-descriptor frames
when XDP is attached?

In the old stmmac_rx(), XDP ran on the first buffer only. After a
CONSUMED, TX or REDIRECT verdict, the goto next above reset in_progress
and skb even when rx_not_ls was still set on that descriptor. The next
continuation descriptor was then handled as the start of a new frame,
so XDP ran on mid-frame payload.

The removed !buf2_len branch also subtracted ETH_FCS_LEN from a first
buffer that was not the last one. That dropped 4 bytes from the middle of
the frame, and setting fcs_stripped skipped the final pskb_trim().

The commit message says frames like this do reach this path with XDP
enabled, but it calls the change groundwork. Could the commit message
describe the old behavior? Could a minimal fix with a Fixes: tag also be
sent, so that stable kernels get it?

[ ... ]

> +		skb = stmmac_xdp_run_prog(priv, &ctx.xdp);
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

[Severity: High]
What happens on XDP_TX now that ctx.xdp can carry frags?

stmmac_xdp_xmit_back() converts the buffer with
xdp_convert_buff_to_frame(). That keeps the frags flag but sets
xdpf->len to the linear head only. The frame is then passed to
stmmac_xdp_xmit_xdpf() with no xdp_frame_has_frags() check, and that
function programs a single descriptor:

stmmac_xdp_xmit_xdpf() {
    ...
	dma_sync_single_for_device(priv->device, dma_addr,
				   xdpf->len, DMA_BIDIRECTIONAL);
    ...
	stmmac_set_tx_dma_last_segment(tx_q, entry);
    ...
	stmmac_prepare_tx_desc(priv, tx_desc, 1, xdpf->len,
			       csum, priv->descriptor_mode, true, true,
			       xdpf->len);
    ...
}

No descriptor points at the fragment pages, and they are never synced for
the device. A frame that spans several RX buffers would therefore be sent
truncated to its first buffer. Nothing leaks, because the fragments are
freed on TX completion, but the data on the wire is wrong.

The EST check in the same function only compares the linear length:

	    xdpf->len > priv->est->max_sdu[queue]) {

So an oversized multi-buffer frame would also get past the max_sdu limit.

GMAC_CORE_INIT in dwmac4.h always sets GMAC_CONFIG_JE. With the default
1536 byte buffers, a remote sender can produce such frames even at MTU
1500.

Should XDP_TX drop frames with frags, by returning STMMAC_XDP_CONSUMED,
until stmmac_xdp_xmit_xdpf() can chain one descriptor per fragment?

The ndo_xdp_xmit path in stmmac_xdp_xmit() has the same single-descriptor
limitation, but that code was already there before this patch.

[ ... ]

> @@ -8022,6 +8121,7 @@ static int __stmmac_dvr_probe(struct device *device,
>  	ndev->hw_features = NETIF_F_SG | NETIF_F_IP_CSUM | NETIF_F_IPV6_CSUM |
>  			    NETIF_F_RXCSUM;
>  	ndev->xdp_features = NETDEV_XDP_ACT_BASIC | NETDEV_XDP_ACT_REDIRECT |
> +			     NETDEV_XDP_ACT_RX_SG |
>  			     NETDEV_XDP_ACT_XSK_ZEROCOPY;

[Severity: Medium]
With RX_SG advertised, what stops programs loaded without
BPF_F_XDP_HAS_FRAGS from receiving multi-buffer xdp_buffs?

stmmac_xdp_set_prog() in stmmac_xdp.c only checks the MTU:

stmmac_xdp_set_prog() {
    ...
	if (prog && dev->mtu > ETH_DATA_LEN) {
    ...
}

It never checks prog->aux->xdp_has_frags. stmmac_rx() also calls
stmmac_xdp_run_prog() on ctx.xdp whether or not it has frags.

GMAC4 always enables jumbo frames, so the MTU limit does not keep out
frames longer than one RX buffer. A single-buffer program would decide
the verdict for the whole frame after seeing only data..data_end. On
XDP_PASS, payload the program never inspected goes up the stack. On
XDP_TX, the frame is truncated as described above.

Other RX_SG drivers handle this case. mvneta, bnxt, ice, mlx5 and ionic
reject such programs at attach time. aq_ring.c and fbnic_txrx.c drop such
frames at runtime. For example, aq_ring.c does:

    if (xdp_buff_has_frags(xdp) && !prog->aux->xdp_has_frags)
        goto out_aborted;

Should stmmac do the same for programs that are not frags-aware?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261006-stmmac-rx-mb-v4-0-efa4ca974e3d%40oss.qualcomm.com
