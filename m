Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF7FD332906;
	Fri, 25 Sep 2026 13:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790342828; cv=none; b=hexRKjZbOP9iq0qqyXRhxs+oExdtZEV8xpBXAZhgMc08D6T5Iupb2yse916nTJ/fQOvIkEKk7rb+mWiuPtYeLY5zi2YNplDMmy19u9H1aJmLUmO/P0ZacH2qu0MA04YJ8k6+nLyS92grHEjZoPhM06gJLt9WDqKyxNYMIvCOwEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790342828; c=relaxed/simple;
	bh=8/SFrT9TKeBgmCWLZWFAYTj2Xqovw6tqN9BkTabzbD4=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dDTbCYvWsCDucCZ2lSWU0LGtN2jqsndl6vMm4nTbz+h68NXqilQJzTL9u621AhK9Io4isjBx+AazaNotGkXXlCj1Om10PV8F1ze89SKdw8dvWRqNu4PYTUfKDV87JB+ihIGLO0k09QlpOnzZyVaJJWkTKXqJx13Nt8Yc6saWm7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hmr9KJ7V; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hmr9KJ7V"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF9A71F00893;
	Fri, 25 Sep 2026 13:27:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790342822;
	bh=VD6FgJ9svZjAMPBnEBckl3XokQ600+zqEuofdo3YE4I=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Hmr9KJ7VixG3UBMg7vOIZapDA1hh/Y4+vkWD8tojHBLRZrUxV2iw1Ul0CacJ0t1iv
	 fv4nFhCFRrFfMWK+twPtcacTNUz0hQIzqdpyBGVtq5Mk3P/fbOr0cN7Bksc6hti/eF
	 c9QtheEJQ1KKtyPbQulxFPGhUKShJwYS6n0O5fb0I+yJHKLaTctYdu+cgmG/1qcLjz
	 BRsVQt7R4XKgKCbIubfP73SoE6sX5Rwp9c+HqdUWT/eR/Z8Xu9A5RLprccH9bJUIi/
	 WBPd1IMCAtPVu/VCa/BqYbWNA49QWQh5xZ0PzG/86/oCKF2iUC1g2IbiyimhI7elo5
	 SXb6l1kdavAGg==
Subject:
 Re: [PATCH net-next v2] net: stmmac: add XDP multi-buff support for TX side
From: netdev-bot+sashiko@kernel.org
To: lorenzo.bianconi@oss.qualcomm.com
Cc: maxime.chevallier@bootlin.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com, ast@kernel.org,
 daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
 sdf@fomichev.me, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org
Date: Fri, 25 Sep 2026 13:27:01 +0000
Message-ID: <179034282133.2160803.6796326011241134301@kernel.org>
In-Reply-To: <20260924-b4-stmmac-xmit-mb-v2-1-003347b7bc25@oss.qualcomm.com>
References: <20260924-b4-stmmac-xmit-mb-v2-1-003347b7bc25@oss.qualcomm.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 2 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The patch adds multi-buffer (frag) handling to
  stmmac_xdp_xmit_xdpf() in…
- [Medium] In stmmac_xdp_xmit_xdpf()
  (drivers/net/ethernet/stmicro/stmmac/stmmac_main.c), the patch removes…
- [Low] A new comment in stmmac_xdp_xmit_xdpf()
  (drivers/net/ethernet/stmicro/stmmac/stmmac_main.c:5332-5334) reads…

--

net: stmmac: add XDP multi-buff support for TX side

This commit extends stmmac_xdp_xmit_xdpf() so it can send XDP frames that
carry fragments. The frame head and each frag are mapped and placed in
their own TX descriptor. The OWN bit on the first descriptor is set only
after all the descriptors are filled in.

Link: https://lore.kernel.org/r/20260923-b4-stmmac-xmit-mb-v1-1-a71a1c522142@oss.qualcomm.com

> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index bf9e7e4cb1c31..089281ef9e612 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -5239,77 +5239,117 @@ static unsigned int stmmac_rx_buf2_len(struct stmmac_priv *priv,
>  static int stmmac_xdp_xmit_xdpf(struct stmmac_priv *priv, int queue,
>  				struct xdp_frame *xdpf, bool dma_map)
>  {

[ ... ]

> -	if (stmmac_tx_avail(priv, queue) < STMMAC_TX_THRESH(priv))
> +	if (unlikely(xdp_frame_has_frags(xdpf)))
> +		num_frames += sinfo->nr_frags;

[Severity: Medium]
Can a frame with frags reach this function from either caller?

On the ndo_xdp_xmit path, stmmac_xdp_set_prog() still registers the
redirect target without SG support:

drivers/net/ethernet/stmicro/stmmac/stmmac_xdp.c:stmmac_xdp_set_prog() {
    ...
	if (prog)
		xdp_features_set_redirect_target(dev, false);
    ...
}

The static mask in stmmac_dvr_probe() is only NETDEV_XDP_ACT_BASIC,
NETDEV_XDP_ACT_REDIRECT and NETDEV_XDP_ACT_XSK_ZEROCOPY. Because
NETDEV_XDP_ACT_NDO_XMIT_SG is never set, devmap drops fragmented frames
before they get to stmmac_xdp_xmit():

kernel/bpf/devmap.c:__xdp_enqueue() {
    ...
	if (unlikely(!(dev->xdp_features & NETDEV_XDP_ACT_NDO_XMIT_SG) &&
		     xdp_frame_has_frags(xdpf)))
		return -EOPNOTSUPP;
    ...
}

is_valid_dst() does the same check on the broadcast path.

On the XDP_TX path, stmmac_xdp_xmit_back() only gets frames built by the
stmmac RX path, and that path never builds a multi-buffer xdp_buff. The
driver has no xdp_buff_add_frag() or xdp_buff_set_frags() calls.
stmmac_xdp_set_prog() also rejects XDP when mtu > ETH_DATA_LEN,
stmmac_change_mtu() blocks jumbo MTU while XDP is loaded, and SPH is turned
off for XDP.

If so, the frag loop, the skb_frag_dma_map() and skb_frag_off() handling,
and the multi-descriptor error_dma_unmap unwind can't be run or tested. The
subject "add XDP multi-buff support for TX side" also doesn't match what
the driver advertises.

Should this patch advertise NDO_XMIT_SG as well, for example by calling
xdp_features_set_redirect_target(dev, true)?

[ ... ]

> +		stmmac_set_tx_dma_entry(tx_q, entry, buf_type, dma_addr, len,
> +					dma_map && frag);
> +		stmmac_set_desc_addr(priv, desc, dma_addr);
> +		stmmac_prepare_tx_desc(priv, desc, !i, len, csum,
> +				       priv->descriptor_mode, !!i, last_frame,
> +				       xdp_get_frame_len(xdpf));
> +		tx_q->xdpf[entry] = last_frame ? xdpf : NULL;
> +		if (last_frame) {
> +			stmmac_set_tx_dma_last_segment(tx_q, entry);
> +			break;
> +		}
>  
> -	stmmac_prepare_tx_desc(priv, tx_desc, 1, xdpf->len,
> -			       csum, priv->descriptor_mode, true, true,
> -			       xdpf->len);

[Severity: Medium]
Does this drop the dma_wmb() that used to come before the OWN bit on the
normal single-buffer XDP_TX and ndo_xdp_xmit path?

The old call passed is_fs=1 and tx_own=true. That hit the barrier in
enh_desc_prepare_tx_desc(), and the dwmac4 and dwxgmac2 versions have the
same one:

drivers/net/ethernet/stmicro/stmmac/enh_desc.c:enh_desc_prepare_tx_desc() {
    ...
	if (is_fs && tx_own)
		/* When the own bit, for the first frame, has to be set, all
		 * descriptors for the same frame has to be set before, to
		 * avoid race condition.
		 */
		dma_wmb();

	p->des0 = cpu_to_le32(tdes0);
}

Now the first descriptor is prepared with is_fs=1 and tx_own=0, and the
frag descriptors with is_fs=0. Neither combination reaches the barrier.
OWN on first_entry is set later by stmmac_set_tx_owner(). Every
implementation of that is a plain read-modify-write with no barrier:

static void enh_desc_set_tx_owner(struct dma_desc *p)
{
	p->des0 |= cpu_to_le32(ETDES0_OWN);
}

dwmac100 and dwmac1000 cores have no tail pointer.
dwmac_enable_dma_transmission() only writes DMA_CHAN_XMT_POLL_DEMAND, and a
DMA that is already running keeps fetching owned descriptors. On a weakly
ordered CPU, can the DMA see OWN=1 before the new des1/des2 buffer length
and address? It could then send a stale address left over from the slot's
earlier use.

stmmac_xmit() has the same pattern, but that is not new. Would adding a
dma_wmb() just before stmmac_set_tx_owner() on first_entry restore the old
ordering?

[ ... ]

> +	/* Set the OWN bit on the first descriptor now that all descriptors
> +	 * for this skb are populated.
> +	 */

[Severity: Low]
This isn't a bug, but this comment appears to come from stmmac_xmit(). This
function transmits an xdp_frame and does not use an skb.

> +	desc = stmmac_get_tx_desc(priv, tx_q, first_entry);
> +	stmmac_set_tx_owner(priv, desc);
> +	tx_q->cur_tx = STMMAC_NEXT_ENTRY(entry, priv->dma_conf.dma_tx_size);
>  	stmmac_enable_dma_transmission(priv, priv->ioaddr, queue);

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260924-b4-stmmac-xmit-mb-v2-1-003347b7bc25%40oss.qualcomm.com
