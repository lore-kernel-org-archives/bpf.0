Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1E262628D;
	Sun, 27 Sep 2026 10:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790504145; cv=none; b=HT6YRmHPiz4VVOWHZ6M5hG7DywVJJl37BWL4zOy2dfTfU1xOe9lUJamhu9ZpvvhAEX78oc57AzwQu8OnAMlTLV0mLlcctmvH8OQFq1JzjCSUMax7UL8FXAa79dtmd3frustRzsB+x5KIiq1T6mqN9yf4mx3CuVl/BvriE6+sW5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790504145; c=relaxed/simple;
	bh=+axvxBg0e2oRL+5cdTkYJ9oAbVqtB4JyPb4ohPV/DQE=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UhNRPmsIzJrvq3feCedDWZwvHfwh0YBlCu7ExBPnKwWFJU6N75ZSYop7WOlgeyFwT1Mx1V01f4uTT5NFnSY0z+Uau27/hJgoUArHAWzbU2v5rUNk3Iv3+PIMbDv+EYgmmYHuA7PeuiR88Gr230VlrSHkJ8AnKra/23rMJddzn5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P0LvstUh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P0LvstUh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70FB71F000FF;
	Sun, 27 Sep 2026 10:15:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790504143;
	bh=i3ORYuE1lemrIpc3k3mvap+Y1TJv7srw+CrOudaTYP8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=P0LvstUhrpLbGB1Ybykq4MfPVgGmarP94LAEQ0qVeGDUpGG05TbClgD1+ULSwj/oE
	 DR1GCp047nqz+wQsH0s/qqyMrnBTnx/uEM+NwhiKXSlImt1Ff0jo0ugsUCP3V/C920
	 XTS4LaDP4xMZW0X81P8MEcik5QlqohtaZoIqLClyh+emavmqEMDJUFN543SbOzB/kn
	 c0BsQxkJqpdrDxYpCdquCx5DMOa2WNZ4AUHq4N7TeuTA6FrwlJoQuZlF6BBzoCfI3g
	 a81axRwsBoFPB3Sh+N5fjEXD0bcNSMea4uQKJneIODrEo/3UaGFXltzgRGQNW/YHML
	 Mp6iFxNXJNXKw==
Subject:
 Re: [PATCH net-next] net: stmmac: add XDP multi-buff support for TX side
From: netdev-bot+sashiko@kernel.org
To: lorenzo.bianconi@oss.qualcomm.com
Cc: maxime.chevallier@bootlin.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com, ast@kernel.org,
 daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
 sdf@fomichev.me, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org
Date: Sun, 27 Sep 2026 10:15:41 +0000
Message-ID: <179050414194.2160803.16900055348380255895@kernel.org>
In-Reply-To: <20260923-b4-stmmac-xmit-mb-v1-1-a71a1c522142@oss.qualcomm.com>
References: <20260923-b4-stmmac-xmit-mb-v1-1-a71a1c522142@oss.qualcomm.com>
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

Critical: 0 · High: 0 (1) · Medium: 4 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The commit says it adds XDP multi-buff TX support, but no
  multi-buff frame can reach the new code.
- [Medium] In stmmac_xdp_xmit_xdpf(), the ring-availability check changed
  from `stmmac_tx_avail(priv, queue) < STMMAC_TX_THRESH(priv)`…
- [Medium] stmmac_xdp_xmit_xdpf() now does `tx_q->tx_count_frames +=
  num_frames` but still sets the IC bit only when…
- [Medium] The patch changes how the XDP TX path hands descriptors to the
  DMA, and in doing so drops the dma_wmb() before the OWN bit is set.
- [Low] The new comment in stmmac_xdp_xmit_xdpf() was copied word for
  word from stmmac_xmit() and says the OWN bit is set 'now that all…

Pre-existing issues:
- [High] stmmac_xdp_xmit_xdpf() computes `tx_q->tx_count_frames %
  priv->tx_coal_frames[queue]` without checking that…

--

net: stmmac: add XDP multi-buff support for TX side

This commit extends stmmac_xdp_xmit_xdpf() to transmit XDP frames with
fragments. The frame head and each frag are mapped and programmed into
their own TX descriptor. The OWN bit on the first descriptor is set once
all descriptors are populated.

> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index bf9e7e4cb1c31..41ccde6371ecd 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -5239,77 +5239,114 @@ static unsigned int stmmac_rx_buf2_len(struct stmmac_priv *priv,
>  static int stmmac_xdp_xmit_xdpf(struct stmmac_priv *priv, int queue,
>  				struct xdp_frame *xdpf, bool dma_map)
>  {

[ ... ]

> -	if (stmmac_tx_avail(priv, queue) < STMMAC_TX_THRESH(priv))
> +	if (unlikely(xdp_frame_has_frags(xdpf)))
> +		num_frames += sinfo->nr_frags;
> +

[Severity: Medium]
After this patch, can a frame with frags actually reach this code?

stmmac_xdp_set_prog() still registers the redirect target without SG
support:

drivers/net/ethernet/stmicro/stmmac/stmmac_xdp.c:stmmac_xdp_set_prog() {
    ...
	if (prog)
		xdp_features_set_redirect_target(dev, false);
    ...
}

The probe-time mask in stmmac_dvr_probe() has neither
NETDEV_XDP_ACT_NDO_XMIT_SG nor NETDEV_XDP_ACT_RX_SG:

	ndev->xdp_features = NETDEV_XDP_ACT_BASIC | NETDEV_XDP_ACT_REDIRECT |
			     NETDEV_XDP_ACT_XSK_ZEROCOPY;

Because of that, __xdp_enqueue() and is_valid_dst() in kernel/bpf/devmap.c
drop frag frames before ndo_xdp_xmit is called:

	if (unlikely(!(dev->xdp_features & NETDEV_XDP_ACT_NDO_XMIT_SG) &&
		     xdp_frame_has_frags(xdpf)))
		return -EOPNOTSUPP;

The XDP_TX side (stmmac_xdp_xmit_back()->stmmac_xdp_xmit_xdpf()) is
blocked too. The stmmac RX path never builds multi-buff xdp_buffs; there
is no xdp_buff_add_frag() or xdp_buff_set_frags() in the driver. Also,
stmmac_xdp_set_prog() still refuses XDP when mtu > ETH_DATA_LEN.

So none of these can run: the skb_frag_dma_map() branch, the page_pool frag
branch, the multi-descriptor loop, and the error_dma_unmap unwind.

Should this patch also advertise NETDEV_XDP_ACT_NDO_XMIT_SG (and build
multi-buff frames on RX), so that the multi-buff TX support described in
the commit message can be used?

> +	if (stmmac_tx_avail(priv, queue) < num_frames)
>  		return STMMAC_XDP_CONSUMED;

[Severity: Medium]
Is the STMMAC_TX_THRESH() reserve meant to go away for linear frames too?

Before, XDP stopped using the ring once fewer than dma_tx_size / 4
descriptors were free. Now a single-buffer frame (num_frames == 1) can take
every free slot of the TX ring it shares with the stack. The XDP path never
stops the netdev TX queue.

stmmac_tx_clean() wakes the stack queue only above the threshold:

	    stmmac_tx_avail(priv, queue) > STMMAC_TX_THRESH(priv)) {

Once XDP fills the ring, the next stmmac_xmit() or stmmac_tso_xmit() call
with the queue still awake takes the hard error path:

			/* This is a hard error, log it. */
			netdev_err(priv->dev,
				   "%s: Tx Ring full when queue awake\n",
				   __func__);
		}
		return NETDEV_TX_BUSY;

Can sustained XDP_TX or redirect traffic starve stack traffic this way?

The XSK zero-copy path in stmmac_xdp_xmit_zc() uses the same ring and keeps
a reserve for this reason:

		/* We are sharing with slow path and stop XSK TX desc submission when
		 * available TX ring is less than threshold.
		 */
		if (unlikely(stmmac_tx_avail(priv, queue) < STMMAC_TX_XSK_AVAIL) ||

Would a check like avail < max(STMMAC_TX_THRESH(priv), num_frames) keep the
old behaviour and still account for frags?

[ ... ]

> +		stmmac_set_desc_addr(priv, desc, dma_addr);
> +		stmmac_prepare_tx_desc(priv, desc, !i, len, csum,
> +				       priv->descriptor_mode, !!i, last_frame,
> +				       xdp_get_frame_len(xdpf));

[ ... ]

> -	stmmac_prepare_tx_desc(priv, tx_desc, 1, xdpf->len,
> -			       csum, priv->descriptor_mode, true, true,
> -			       xdpf->len);
> +		entry = STMMAC_NEXT_ENTRY(entry, priv->dma_conf.dma_tx_size);
> +		i++;
> +	}
> +	tx_q->tx_count_frames += num_frames;
> 
> -	tx_q->tx_count_frames++;
> +	if (!(tx_q->tx_count_frames % priv->tx_coal_frames[queue])) {

[Severity: Medium]
Can tx_count_frames step over every multiple of tx_coal_frames here?

tx_count_frames now grows by num_frames, so the exact-multiple test can be
skipped. With the default tx_coal_frames of 25, a step from 24 to 26 misses
25. With an even threshold such as 64, one single-buffer frame followed by
2-descriptor frames keeps the counter odd, so the IC bit is never set.

stmmac_xmit() and stmmac_tso_xmit() already handle batched increments by
checking whether the threshold was crossed:

	else if (tx_packets > priv->tx_coal_frames[queue])
		set_ic = true;
	else if ((tx_q->tx_count_frames %
		  priv->tx_coal_frames[queue]) < tx_packets)
		set_ic = true;

Without a check like that, TX completion reclaim depends on the hrtimer.
__stmmac_set_coalesce() accepts tx-usecs 0 when tx-frames is non-zero, and
in that case stmmac_tx_timer_arm() returns early:

	if (!tx_coal_timer)
		return;

Would completions then stall until something else triggers TX cleaning?

[Severity: High]
This isn't a bug introduced by this patch, but since this line is being
rewritten: can priv->tx_coal_frames[queue] be zero here?

__stmmac_set_coalesce() rejects only the case where both values are zero:

	if ((ec->tx_coalesce_usecs == 0) &&
	    (ec->tx_max_coalesced_frames == 0))
		return -EINVAL;

So "ethtool -C ethX tx-usecs 1000 tx-frames 0" stores tx_coal_frames[queue]
= 0. stmmac_xmit(), stmmac_tso_xmit() and stmmac_xdp_xmit_zc() all guard
the modulo:

	else if (!priv->tx_coal_frames[queue])
		set_ic = false;

With that setting and an XDP program attached, each XDP_TX verdict
(stmmac_xdp_xmit_back()) and each ndo_xdp_xmit redirect (stmmac_xdp_xmit())
would divide by zero in softirq context. That traps on x86.

The old code had the same unguarded "% priv->tx_coal_frames[queue] == 0".
Could a zero check be added while this code is being reworked?

[ ... ]

> +	/* Set the OWN bit on the first descriptor now that all descriptors
> +	 * for this skb are populated.
> +	 */

[Severity: Low]
This isn't a bug, but this comment was copied from stmmac_xmit() and talks
about an skb. This function sends an xdp_frame and its frags.

> +	desc = stmmac_get_tx_desc(priv, tx_q, first_entry);
> +	stmmac_set_tx_owner(priv, desc);

[Severity: Medium]
Does this need a dma_wmb() before stmmac_set_tx_owner()?

The old code called stmmac_prepare_tx_desc() with is_fs = 1 and
tx_own = true. In that case every backend issues a barrier before writing
the OWN word. For example, enh_desc_prepare_tx_desc():

	if (is_fs && tx_own)
		/* When the own bit, for the first frame, has to be set, all
		 * descriptors for the same frame has to be set before, to
		 * avoid race condition.
		 */
		dma_wmb();

The loop now passes tx_own = !!i, which is false for the first descriptor,
so that barrier never runs. The set_tx_owner callbacks that now set OWN are
plain read-modify-writes, for example:

static void dwmac4_set_tx_owner(struct dma_desc *p)
{
	p->des3 |= cpu_to_le32(TDES3_OWN);
}

The common single-buffer XDP_TX and ndo_xdp_xmit case is affected as well.
On dwmac4 and xgmac, the tail pointer update after wmb() in
stmmac_flush_tx_descriptors() hides the missing barrier. dwmac100, dwmac1000
and sun8i have no set_tx_tail_ptr, so a running TX DMA fetches the
descriptor as soon as it sees OWN.

On weakly ordered architectures, can the device see OWN before the buffer
address and length stores of the same descriptor? For multi-buff, can it
see OWN before the following descriptors are written? It could then
transmit from a stale address or length.

stmmac_xmit() has the same pattern, but for the XDP path this is new.

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260923-b4-stmmac-xmit-mb-v1-1-a71a1c522142%40oss.qualcomm.com
