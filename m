Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD69840B0E6;
	Sat, 10 Oct 2026 10:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791629852; cv=none; b=FAA/EKJ8A4G0saztQ63cO360RBVwaFXN/vieuRCgukfgt4XEd90Dy5d+40qXCGmxXL/DpXT/TffmHQEk6Me4nrKi4mOUmNqHVXn5KxCyi7/M+ThfpjQXlOpxDnHKmUk+vRQz2sJJFfGPrbn7tXfTES6XNH4lflA6Ow8kwnYO56I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791629852; c=relaxed/simple;
	bh=uawOCfbsiBFggH1wMiR3f+wFvOcEYnPLWd8E+WRChgU=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bJu/ndFr5ZCA0wksEOgJfAJGWX5t7nMd9VM6yLHmWUzkw5Qb11i1ahCkwrQzTBMMAJy1i7bTDWmAhQEdPVKUSjOOFCMoeV2UHcE2rbc+LhBmIFkpqlfjD8dLsTrgmyLbVr71iCMhRH8hxOJw67Pup4TaxbZrE4R2nGYv1/yaylU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JBK8Fgly; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JBK8Fgly"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 762DF1F000FF;
	Sat, 10 Oct 2026 10:57:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791629850;
	bh=XfNqeS/7RwepVt8hLkWsUT90dSBSnIFgJotqTQm7YhI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=JBK8FglyBJEnZSm+9Hw+rY9FkSIvWw+Ai3kebSWPoQoZRdyjztMfKRPsW/aLyD649
	 /1h+x8wCaCowiTwdIR2ATMQM5wmNgx/cAhAiY8R5ndNBGWTTTSzj1wi+0+7ZQmAIap
	 tkNXYnZzLIY/1Q/HKc/nuk5cproJG6hV8nkD5d38WTT6AIK/jONZF6Bn1Mp/FG6P20
	 wUkRGhYpgPtuDat2d47UZqjFMWKXeVEoE8RbPMjkS/xM3MwhaFvHqEa60+gpuZM8K5
	 uqDXnyAjnS94O5m5f5UBFM1voAXxmJPHyCThZTOpChBNE1eX/G9jh7uWfr4BO5Yr2P
	 mhzwmATFkW0WQ==
Subject: Re: [PATCH net-next v5 3/3] net: stmmac: allow non-linear xdp_buff in
 XDP mode
From: netdev-bot+sashiko@kernel.org
To: lorenzo.bianconi@oss.qualcomm.com
Cc: maxime.chevallier@bootlin.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com, ast@kernel.org,
 daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
 sdf@fomichev.me, Jose.Abreu@synopsys.com, boon.leong.ong@intel.com,
 netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org
Date: Sat, 10 Oct 2026 10:57:28 +0000
Message-ID: <179162984899.434549.17187989527760653595@kernel.org>
In-Reply-To: <20261009-stmmac-rx-mb-v5-3-c38fa4eaa138@oss.qualcomm.com>
References: <20261009-stmmac-rx-mb-v5-3-c38fa4eaa138@oss.qualcomm.com>
X-sashiko-severity: Critical
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

Critical: 1 · High: 2 (2) · Medium: 2 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Critical] Out-of-bounds read in the AF_XDP zero-copy RX path,
  triggerable by a remote peer.
- [High] XDP_TX and ndo_xdp_xmit frames longer than buffer1 of a legacy
  (normal or enhanced) TX descriptor are programmed wrongly.
- [High] On XDP_TX of the head buffer, stmmac_xdp_xmit_xdpf() computes
  the DMA address as `page_pool_get_dma_addr(virt_to_page(xdpf->data)) +…
- [Medium] On bugged_jumbo cores (snps,dwmac-3.40a, snps,dwmac-3.610,
  snps,dwmac-3.710 per stmmac_probe_config_dt()), TX checksum insertion…
- [Medium] net/stmmac: silent drop of jumbo frames with non-SG XDP

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but the patch
  makes it much easier to hit.
- [High] This problem wasn't introduced by this patch, but the patch
  exposes it to XDP and to XDP_TX/redirect.

--

net: stmmac: allow non-linear xdp_buff in XDP mode

This commit removes the check that rejected attaching an XDP program
when the MTU is above ETH_DATA_LEN. It also removes the check that
refused to raise the MTU above ETH_DATA_LEN while XDP is enabled. The
reason given is that the RX path now builds multi-buffer xdp_buffs.

> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index be2cba8fcbc6d..cbeb43011c4bd 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -6351,12 +6351,6 @@ static int stmmac_change_mtu(struct net_device *dev, int new_mtu)
>  		txfifosz = priv->dma_cap.tx_fifo_size;
>  
>  	txfifosz /= priv->plat->tx_queues_to_use;
> -
> -	if (stmmac_xdp_is_enabled(priv) && new_mtu > ETH_DATA_LEN) {
> -		netdev_dbg(priv->dev, "Jumbo frames not supported for XDP\n");
> -		return -EINVAL;
> -	}
> -

[Severity: Critical]

Can this lead to an out-of-bounds read in the AF_XDP zero-copy RX path?

ZC RX only runs while an XDP program is attached. Before this patch,
that kept dma_conf.dma_buf_sz at 1536.

With XDP attached and, say, MTU 9000, stmmac_setup_dma_desc() now picks
BUF_SIZE_16KiB. For a ZC queue, stmmac_set_queue_rx_buf_size() programs
the hardware buffer size from the pool:

    buf_size = xsk_pool_get_rx_frame_size(rx_q->xsk_pool);

So a jumbo frame gets split across several descriptors. stmmac_rx_zc()
still assumes a 1:1 mapping. It drops the non-last buffers without
adding to len or setting error:

    /* XSK pool expects RX frame 1:1 mapped to XSK buffer */
    if (likely(status & rx_not_ls)) {
        xsk_buff_free(buf->xdp);
        buf->xdp = NULL;
        dirty++;
        count++;
        goto read_again;
    }

When the last descriptor arrives, len is still 0, so stmmac_rx_buf1_len()
returns about the full frame length:

    return min_t(unsigned int, priv->dma_conf.dma_buf_sz, plen - len);

stmmac_rx_zc() then sets:

    buf->xdp->data_end = buf->xdp->data + buf1_len;

This puts data_end about 9000 bytes past data. The XSK chunk only holds
xsk_pool_get_rx_frame_size() bytes.

Three consumers would then read past the chunk:

  - the BPF program
  - the memcpy() in stmmac_construct_skb_zc() on XDP_PASS
  - xdp_convert_zc_to_xdp_frame() on XDP_TX

They would read neighbouring UMEM chunks, or fault past the end of the
UMEM mapping in NAPI context.

Both orders seem to reach this state:

  - bind the pool at MTU 1500, then raise the MTU here
  - raise the MTU first, then attach the program

The mtu + ETH_PAD_LEN <= frame_size check in xp_assign_dev() only runs
at bind time. stmmac_xdp_enable_pool() only requires frame_size >=
ETH_FRAME_LEN + VLAN_HLEN * 2, and its comment says "XDP ZC does not
span multiple frame".

The commit message says "XDP can operate on frames bigger than
ETH_DATA_LEN". That doesn't seem to hold for the ZC path, and the driver
still advertises NETDEV_XDP_ACT_XSK_ZEROCOPY.

Should the MTU limit stay in place while an XSK pool is bound, or be
checked against xsk_pool_get_rx_frame_size()?

[Severity: High]

This is a pre-existing issue, but this patch exposes it to XDP programs
and to XDP_TX/redirect. In chain mode (forced for dwmac-sun8i, or with
chain_mode=1), does the RX length accounting match what the hardware
writes?

chain_mode_ops has no set_16kib_bfsize, so stmmac_set_bfsize() picks
dma_buf_sz = BUF_SIZE_16KiB for len > BUF_SIZE_8KiB. The descriptor
init caps hardware buffer1:

enh_desc_init_rx_desc():
    bfsize1 = min(bfsize, BUF_SIZE_8KiB);

ndesc_init_rx_desc() caps it at 2047. Chain mode has no buffer2,
because des3 is the next-descriptor pointer.

stmmac_rx_buf1_len() still returns the full software size for every
non-last descriptor:

    if (status & rx_not_ls)
        return priv->dma_conf.dma_buf_sz;

For the last descriptor, the unsigned plen - len wraps (for example
9022 - 16368), so min_t() returns dma_buf_sz again.

Wouldn't a 9022-byte frame then become a ~32 KiB xdp_buff that is
mostly stale data from recycled page_pool pages? The XDP program would
see that data, and XDP_TX would send it back out. The non-XDP skb path
builds from the same xdp_buff and looks affected in the same way.

>  	new_mtu = STMMAC_ALIGN(new_mtu);
>  
>  	/* If condition true, FIFO is too small or MTU too large */
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_xdp.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_xdp.c
> index 9af9e0cb366c3..f6b3e8628a7cf 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_xdp.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_xdp.c
> @@ -109,14 +109,6 @@ int stmmac_xdp_set_prog(struct stmmac_priv *priv, struct bpf_prog *prog,
>  
>  	if_running = netif_running(dev);
>  
> -	if (prog && dev->mtu > ETH_DATA_LEN) {
> -		/* For now, the driver doesn't support XDP functionality with
> -		 * jumbo frames so we return error.
> -		 */
> -		NL_SET_ERR_MSG_MOD(extack, "Jumbo frames not supported");
> -		return -EOPNOTSUPP;
> -	}
> -

[Severity: Medium]
Removing both checks entirely means a single-buffer XDP program can now
be combined with a jumbo MTU. Neither stmmac_xdp_set_prog() nor
stmmac_change_mtu() looks at prog->aux->xdp_has_frags. That allows the
setup in either order:

  - attach a program without frags support at MTU 9000
  - raise the MTU while such a program is attached

After that, any frame that spans more than one RX buffer arrives as an
xdp_buff with frags. stmmac_xdp_run_prog() then skips the program:

    if (likely(!xdp_buff_has_frags(xdp) || prog->aux->xdp_has_frags))
        res = __stmmac_xdp_run_prog(priv, prog, xdp);

res stays at STMMAC_XDP_CONSUMED, so the frame is dropped. All traffic
larger than one RX buffer is blackholed. The user got no error when
setting this up that would explain why.

Other multi-buffer capable drivers reject this combination up front.
mvneta, for example, refuses to attach a program without xdp_has_frags
when the MTU exceeds its single-buffer size. It also refuses the
matching MTU change while such a program is loaded.

Should these two checks be kept, but applied only when the program
lacks xdp_has_frags? If so, is ETH_DATA_LEN still the right threshold,
or should it be the largest frame that fits in one RX buffer?

[Severity: High]

With XDP now allowed at jumbo MTU, can stmmac_xdp_xmit_xdpf() program
legacy (normal or enhanced) TX descriptors with buffers longer than
buffer1?

stmmac_xdp_xmit_xdpf() writes one descriptor per buffer. It sets only
des2 and passes the full length:

    stmmac_set_desc_addr(priv, desc, dma_addr);
    stmmac_prepare_tx_desc(priv, desc, !i, len, csum,
                           priv->descriptor_mode, !!i, last_frame,
                           xdp_get_frame_len(xdpf));

In ring mode, enh_set_tx_desc_len_on_ring() moves the excess into the
buffer2 size field when len > 4096:

    if (unlikely(len > buffer1_max_length)) {
        p->des1 |= cpu_to_le32(FIELD_PREP(ETDES1_BUFFER2_SIZE_MASK,
                               len - buffer1_max_length) |

norm_set_tx_desc_len_on_ring() does the same above 2047. The DMA engine
then reads buffer2 from des3, which the XDP path never sets. It is
usually 0, or a stale value.

The skb path handles this in stmmac_xmit() through
stmmac_is_jumbo_frm(), with jumbo_frm() in ring_mode.c doing:

    desc->des3 = cpu_to_le32(lower_32_bits(des2) + BUF_SIZE_4KiB);

In chain mode, des3 is the next-descriptor pointer and the length is
masked with ETDES1_BUFFER1_SIZE_MASK. A 9018-byte frame would go out
truncated.

Should stmmac_xdp_xmit_xdpf() split oversized buffers the same way the
skb path does?

[Severity: High]

Does stmmac_xdp_xmit_xdpf() still compute the right DMA address for the
head buffer, now that RX pages can be compound?

    page = frag ? skb_frag_page(frag)
                : virt_to_page(xdpf->data);
    dma_addr = page_pool_get_dma_addr(page);

The offset added afterwards (sizeof(*xdpf) + xdpf->headroom) is relative
to the head page. virt_to_page() returns the page that contains
xdpf->data.

At jumbo MTU, __alloc_dma_rx_desc_resources() now ends up with
pp_params.order = order_base_2(num_pages) > 0 while XDP is enabled.

Suppose a program moves data forward with bpf_xdp_adjust_head() by more
than about a page and returns XDP_TX. Then xdpf->data is in a tail page,
and the tail page doesn't hold the page_pool DMA address. Wouldn't
dma_sync_single_for_device() and the TX descriptor get a bogus bus
address?

stmmac_xdp_put_buff() in the same file already uses
virt_to_head_page(xdp->data) for the same buffer.

[Severity: Medium]

The bugged_jumbo cores are snps,dwmac-3.40a, snps,dwmac-3.610 and
snps,dwmac-3.710. On these, stmmac_fix_features() disables TX checksum
insertion at jumbo MTUs:

    if (priv->plat->bugged_jumbo && (dev->mtu > ETH_DATA_LEN))
        features &= ~NETIF_F_CSUM_MASK;

stmmac_xdp_xmit_xdpf() makes its own decision:

    bool csum = !priv->plat->tx_queues_cfg[queue].coe_unsupported;

enh_desc_prepare_tx_desc() then sets TX_CIC_FULL.

Now that XDP is allowed at MTU > ETH_DATA_LEN, wouldn't XDP_TX and
redirected jumbo frames on these cores go out with full checksum
insertion enabled? That is what the bugged_jumbo workaround is meant to
avoid.

[Severity: High]

This isn't a bug introduced by this patch, but the patch makes it much
easier to hit. Further down in stmmac_xdp_set_prog(), the result of the
reopen is ignored and the function returns 0:

    if (if_running && need_update)
        stmmac_xdp_open(dev);

If stmmac_xdp_open() fails, its error paths have already freed the DMA
resources:

init_error:
    free_dma_desc_resources(priv, &priv->dma_conf);

The NAPIs that stmmac_xdp_release() disabled stay disabled, and the
device stays IFF_UP.

The next ndo_stop or XDP toggle reaches __stmmac_disable_all_queues():

    if (queue < rx_queues_cnt)
        napi_disable(&ch->rx_napi);

napi_disable() on a NAPI that is already disabled loops forever in
napi_disable_locked() while holding RTNL.

Any path that gets past that calls free_dma_desc_resources() again.
__free_dma_rx_desc_resources() doesn't clear dma_rx, buf_pool or
page_pool, so that would be a double free.

With this patch, attaching or detaching XDP at jumbo MTU makes the
reopen fill every RX ring entry with order-2/3 page_pool pages. These
are allocated with GFP_ATOMIC and can fail on a fragmented system.

Should the stmmac_xdp_open() error be propagated, with the device state
cleaned up?

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261009-stmmac-rx-mb-v5-0-c38fa4eaa138%40oss.qualcomm.com
