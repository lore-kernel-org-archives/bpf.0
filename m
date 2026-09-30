Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A62413ABDA5;
	Wed, 30 Sep 2026 04:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790743922; cv=none; b=ZwgU8zohrZe0cSwPx9ndl+GEIcc7TEq1knxIr4L5+v8TYHiMWAgojNzdbjrbCgRoV/vFifsJfHCG/25BZ8y5/lALeERp90MuB76INKZTyOFvPBPQVNlczP6VJLWqpgyDNCPddgrxXqA9Vlp2o4V3Qf0yZF0XBsfxp8dVTVsdwB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790743922; c=relaxed/simple;
	bh=bk53o5MYOf6hBxB1c5nkw+1ySuQuy9+w3T1VW705wRc=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TjIYEnGNFB99kXUvZx+L+Da3m7KoJHj2sFaf2l08P1jrY2HQU+VF9s/fQ0n810wTSatJ5VPgGiamGQZL3Rexn6t9vggVAe2JMWZMk725j4lOkwcxhkyvcfGSD6wswdawqotcfbAYab/NKLOSfR8GMf/ctY8grqea5IkT2dP9SU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NIleUemb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NIleUemb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C4D61F0089A;
	Wed, 30 Sep 2026 04:51:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790743913;
	bh=tPXIT2nqcec1cCoXxFHOdeZ6K7R8HcdS9MsTHdmtiZ4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=NIleUemb9ki0t4yHJkqgEQjy6agc4ZWWvd4R79NTnfrcQchPoGT4j1ukKXZDxqtPM
	 rzZ38z+h4l8bBSBAgjYf926Ol5GyYyrJUWpXjoKxf6X85J6gTONLdC3q+ipNk5mFiE
	 gDyPkI3Cfiv4hTyiUBSXsNMC9M2+epIv62/oBpOZaC6NMq6+h2Y8Wvy5bjzQJo7wJv
	 BcKjXBLmKyrpbeFp4618gWTNEZX2yJN67Bb3zdpSajqdQow42tQyCWYlmHNDqicr7q
	 xyKGWeroC5f2PmMjDHWhaSm4PQ5OQETnyAAt8v4GCgpygNm4+F3yhJrKMvhCmO8BUS
	 +CIO1mQzAwXYA==
Subject: Re: [PATCH net v4 10/15] net: stmmac: use the tracked datapath
 restart for XSK pool changes
From: netdev-bot+sashiko@kernel.org
To: james.hilliard1@gmail.com
Cc: linux@armlinux.org.uk, andrew@lunn.ch, hkallweit1@gmail.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 qiangqing.zhang@nxp.com, rmk+kernel@armlinux.org.uk,
 maxime.chevallier@bootlin.com, andrew+netdev@lunn.ch,
 mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com, ansuelsmth@gmail.com,
 yangtiezhu@loongson.cn, chenhuacai@kernel.org, ast@kernel.org,
 daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
 sdf@fomichev.me, fancer.lancer@gmail.com, quic_jsuraj@quicinc.com,
 richardcochran@gmail.com, Joao.Pinto@synopsys.com, vladimir.oltean@nxp.com,
 boon.leong.ong@intel.com, weifeng.voon@intel.com, yoong.siang.song@intel.com,
 linusw@kernel.org, martin.blumenstingl@googlemail.com,
 magnus.karlsson@intel.com, maciej.fijalkowski@intel.com, horms@kernel.org,
 bjorn@kernel.org, thierry.reding@kernel.org, jonathanh@nvidia.com,
 wens@kernel.org, jernej.skrabec@gmail.com, samuel@sholland.org,
 edumazet@kernel.org, richard.genoud@bootlin.com, alastair@d-silva.org,
 mripard@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org,
 zhaojinming@uniontech.com, lorenzo.bianconi@oss.qualcomm.com,
 dinghui1111@163.com, linux-tegra@vger.kernel.org, linux-sunxi@lists.linux.dev
Date: Wed, 30 Sep 2026 04:51:50 +0000
Message-ID: <179074391068.434549.14131617452660607242@kernel.org>
In-Reply-To:
 <20260926-submit-stmmac-reset-fixes-v1-v4-10-ec1c0250b3c9@gmail.com>
References:
 <20260926-submit-stmmac-reset-fixes-v1-v4-10-ec1c0250b3c9@gmail.com>
X-sashiko-severity: High
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

Critical: 0 · High: 1 · Medium: 3 (2) · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The all-queue restart now reports AF_XDP TX completions a second
  time for buffers that were already returned on another, still-attached…
- [Medium] In stmmac_xdp_xmit_zc()
  (drivers/net/ethernet/stmicro/stmmac/stmmac_main.c), the patch changes…
- [Medium] stmmac_xdp_enable_pool() and stmmac_xdp_disable_pool() in
  drivers/net/ethernet/stmicro/stmmac/stmmac_xdp.c now restart the whole…
- [Medium] Because pool attach and detach now restart every queue,
  pending AF_XDP TX work on an unrelated zero-copy queue can be left…
- [Low] stmmac_xdp_xmit_zc() now returns true at entry when carrier is
  down, even if XSK TX descriptors are still pending in the user TX ring.

Pre-existing issues:
- [Medium] At this commit, stmmac_xdp_release() calls
  stmmac_stop_all_dma(), which only clears the SR/ST bits and does not…
- [Medium] stmmac_set_queue_rx_buf_size() picks the XSK frame size only
  when `rx_q->xsk_pool && rx_q->buf_alloc_num`.

--

net: stmmac: use the tracked datapath restart for XSK pool changes

This commit drops the per-queue XSK pool enable/disable helpers. When a
pool is attached or removed while XDP is running, it now does a full
stmmac_xdp_release()/stmmac_xdp_open() restart instead. It also makes
stmmac_xdp_xmit_zc() return early while carrier is down, restores TBS in
stmmac_xdp_open(), and unwinds a failed reopen.

> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index 22a65c1c16810..618e01772ab86 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c

[ ... ]

> @@ -2756,6 +2757,12 @@ static bool stmmac_xdp_xmit_zc(struct stmmac_priv *priv, u32 queue, u32 budget)
>  	bool work_done = true;
>  	u32 tx_set_ic_bit = 0;
>  
> +	/* Nothing can be submitted while the link is down. Let NAPI complete;
> +	 * userspace can retry ndo_xsk_wakeup() once carrier has returned.
> +	 */
> +	if (!netif_carrier_ok(priv->dev))
> +		return true;
> +

[Severity: Medium]
Can AF_XDP zero-copy TX stall after a link flap with this change?

Before this patch, the carrier check inside the loop set work_done = false.
stmmac_tx_clean() then returned budget, and rxtx_napi kept polling until
carrier came back. With the early return, stmmac_tx_clean() takes the other
branch:

stmmac_tx_clean() {
    ...
	work_done = stmmac_xdp_xmit_zc(priv, queue, STMMAC_XSK_TX_BUDGET_MAX);
	if (work_done)
		xmits = budget - 1;
	else
		xmits = budget;
    ...
}

NAPI then completes. Nothing seems to reschedule rxtx_napi on link up,
because stmmac_mac_link_up() doesn't call napi_schedule(). A kick made
during the outage also fails:

stmmac_xsk_wakeup() {
    ...
	if (test_bit(STMMAC_DOWN, &priv->state) ||
	    !netif_carrier_ok(priv->dev))
		return -ENETDOWN;
    ...
}

Descriptors queued during the outage stay unsent until userspace kicks
again after carrier returns, or until RX traffic raises an IRQ on that
channel. An application blocked in poll() with no RX on the channel would
not recover.

This applies to every carrier-down period, not only pool changes, and the
commit message doesn't mention it. Would it be better as a separate patch
that describes the new behaviour?

[Severity: Low]
This isn't a bug, but a true return can now also mean "carrier down,
nothing drained". The comment in stmmac_tx_clean() still says:

		/* For XSK TX, we try to send as many as possible.
		 * If XSK work done (XSK TX desc empty and budget still
		 * available), return "budget - 1" to reenable TX IRQ.

The trailing comment in stmmac_xdp_xmit_zc() also still says true is only
returned when budget remains and the XSK TX desc peek is empty. Should
both comments be updated?

[ ... ]

> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_xdp.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_xdp.c
> index 7ecb7addd2ea7..907ac49a1b764 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_xdp.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_xdp.c

[ ... ]

> @@ -34,23 +33,23 @@ static int stmmac_xdp_enable_pool(struct stmmac_priv *priv,
>  	need_update = priv->datapath == STMMAC_DATAPATH_RUNNING &&
>  		      stmmac_xdp_is_enabled(priv);
>  
> -	if (need_update) {
> -		napi_disable(&ch->rx_napi);
> -		napi_disable(&ch->tx_napi);
> -		stmmac_disable_rx_queue(priv, queue);
> -		stmmac_disable_tx_queue(priv, queue);
> -	}
> +	if (need_update)
> +		stmmac_xdp_release(priv->dev);

[Severity: Medium]
Is a full device restart intended on every AF_XDP bind and unbind?

stmmac_xdp_release() does the following:
- detaches the netdev;
- calls phylink_replay_link_begin(), which runs phylink_link_down() and
  netif_carrier_off();
- frees all IRQs, stops all DMA channels and frees every RX/TX ring.

stmmac_xdp_open() then rebuilds everything, and phylink_replay_link_end()
turns carrier back on.

Before this patch, only the target queue was restarted. Now each bind or
unbind appears to cause a carrier off/on transition: RTM_NEWLINK events,
operstate changes, a carrier_down_count increment, and possible bonding or
team failover. It also drops in-flight traffic on all unrelated queues.

The operation can now fail for reasons that have nothing to do with the
target queue, such as re-requesting IRQs or allocating rings for other
queues. On failure, the whole interface stays detached, with phylink
stopped and PTP released.

In the attach path, if the socket didn't force XDP_ZEROCOPY,
xp_assign_dev() falls back to copy mode. bind() can then succeed while the
interface is dead.

The commit message says "Pause all queues and MAC link resolution". It
doesn't mention the carrier flap or the effect on other traffic. Could that
be spelled out?

>  
>  	set_bit(queue, priv->af_xdp_zc_qps);
>  
>  	if (need_update) {
> -		stmmac_enable_rx_queue(priv, queue);
> -		stmmac_enable_tx_queue(priv, queue);
> -		napi_enable(&ch->rxtx_napi);
> -
> -		err = stmmac_xsk_wakeup(priv->dev, queue, XDP_WAKEUP_RX);
> -		if (err)
> +		err = stmmac_xdp_open(priv->dev);
> +		if (err) {
> +			clear_bit(queue, priv->af_xdp_zc_qps);
> +			xsk_pool_dma_unmap(pool, STMMAC_RX_DMA_ATTR);
> +			netdev_err(priv->dev, "failed reopening after XSK pool attach: %pe; interface remains detached\n",
> +				   ERR_PTR(err));
>  			return err;
> +		}
> +
> +		/* The pool is installed even if link resolution is still pending. */
> +		napi_schedule(&priv->channel[queue].rxtx_napi);

[Severity: Medium]
What happens to pending XSK TX work on other zero-copy queues after this
restart?

Take a queue A that already has an active pool, with its NAPI polling
because work_done == false (for example, the TX ring was nearly full).
stmmac_xdp_release() disables A's NAPI, cancels the TX hrtimers and frees
A's TX ring.

stmmac_xdp_open() re-enables NAPI via stmmac_enable_all_queues(), but
napi_enable() doesn't schedule a poll. netif_device_attach() only wakes the
netdev TX queues.

Only channel[queue].rxtx_napi for the newly attached queue is scheduled
here, and stmmac_xdp_disable_pool() schedules nothing. Queue A is left with
no pending completions, no armed timer and no NAPI poll. Its XSK TX work
stays stalled until userspace kicks again or RX traffic arrives on
channel A.

xsk_poll() only calls xsk_wakeup() on entry, so a TX-only application
already blocked in poll() for POLLOUT would not be woken. Should every
queue with an XSK pool be rescheduled after a successful reopen?

[Severity: Medium]
This is a pre-existing issue, but now that this napi_schedule() drives the
initial ZC refill, can RBSZ end up programmed with the wrong size?

stmmac_set_queue_rx_buf_size() only uses the XSK frame size when buffers
have already been allocated:

	if (rx_q->xsk_pool && rx_q->buf_alloc_num)
		buf_size = xsk_pool_get_rx_frame_size(rx_q->xsk_pool);
	else
		buf_size = priv->dma_conf->dma_buf_sz;

__init_dma_rx_desc_rings() ignores the return value of
stmmac_alloc_rx_buffers_zc(). If the fill ring is still empty at bind time,
buf_alloc_num is 0 and stmmac_xdp_open() programs dma_buf_sz. The later
stmmac_rx_refill_zc() only advances the tail pointer and never reprograms
RBSZ.

The programmed size would only exceed the real buffer size for XSK frame
sizes from 1522 to 1535 bytes. The removed stmmac_enable_rx_queue() used
the same ordering.

[ ... ]

> @@ -73,24 +72,21 @@ static int stmmac_xdp_disable_pool(struct stmmac_priv *priv, u16 queue)
>  	need_update = priv->datapath == STMMAC_DATAPATH_RUNNING &&
>  		      stmmac_xdp_is_enabled(priv);
>  
> -	if (need_update) {
> -		napi_disable(&ch->rxtx_napi);
> -		stmmac_disable_rx_queue(priv, queue);
> -		stmmac_disable_tx_queue(priv, queue);
> -		synchronize_rcu();
> -	}
> +	if (need_update)
> +		stmmac_xdp_release(priv->dev);

[Severity: High]
Could this restart report TX completions a second time to a pool that
stays attached on another queue?

When stmmac_tx_clean() completes an XSK TX descriptor, it counts it but
leaves buf_type set:

		if (tx_q->tx_skbuff_dma[entry].buf_type == STMMAC_TXBUF_T_XSK_TX)
			tx_q->xsk_frames_done++;

The slot stays STMMAC_TXBUF_T_XSK_TX until an skb transmit reuses it.

A pool change on queue B now goes through stmmac_xdp_release() ->
free_dma_desc_resources() for every queue. For queue A,
dma_free_tx_skbufs() walks all dma_tx_size entries:

	for (i = 0; i < dma_conf->dma_tx_size; i++)
		stmmac_free_tx_buffer(priv, dma_conf, queue, i);

	if (tx_q->xsk_pool && tx_q->xsk_frames_done) {
		xsk_tx_completed(tx_q->xsk_pool, tx_q->xsk_frames_done);

stmmac_free_tx_buffer() counts every stale XSK_TX slot again.
xsk_tx_completed() ends in xskq_prod_submit_n(), which advances the
producer without checking cached_prod:

static inline void xskq_prod_submit_n(struct xsk_queue *q, u32 nb_entries)
{
	__xskq_prod_submit(q, q->ring->producer + nb_entries);
}

Userspace would then see stale addresses in queue A's completion ring as
newly completed, and later completions would be misaligned. The
application could then reuse UMEM frames the kernel still owns. The old
per-queue restart never touched queue A's ring.

Should buf_type be reset on completion, or should teardown count only the
dirty_tx..cur_tx range?

>  
>  	xsk_pool_dma_unmap(pool, STMMAC_RX_DMA_ATTR);

[Severity: Medium]
This is a pre-existing issue, but is DMA guaranteed to be idle before the
rings are freed and the pool is unmapped here?

At this commit, stmmac_xdp_release() does:

	stmmac_stop_all_dma(priv);

	/* Release and free the Rx/Tx resources */
	free_dma_desc_resources(priv, priv->dma_conf);

	/* Disable the MAC Rx/Tx */
	stmmac_mac_set(priv, priv->ioaddr, false);

dwmac4_dma_stop_rx() and dwmac4_dma_stop_tx() only clear the SR/ST bits;
they don't wait for the stopped state. An in-flight frame or descriptor
write-back could therefore land in freed rings or unmapped UMEM.

The removed per-queue helpers used the same stop-then-free pattern, and
their synchronize_rcu() never drained DMA.

A later patch in this series appears to address this: "net: stmmac: retain
DMA memory until hardware shutdown completes" adds stmmac_drain_dma()
before free_dma_desc_resources() in stmmac_xdp_release().

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260926-submit-stmmac-reset-fixes-v1-v4-0-ec1c0250b3c9%40gmail.com
