Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F38852D2C0;
	Wed, 16 Sep 2026 23:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789601764; cv=none; b=WHb3z0nmH5TXRFjMePQY0H8xHAYK5nhwS/rHtNSQWnDhw6RR93UOaq1lrddcCuoKT01MpuQ3Utod+A5bDnh/UGGcxzOogZcrd+dvOEOvI71c+wLr1iAILbMzmROUrRRbmapAMp+XAKgwIkR2N+NA6SPCK2c9ZSkwVqDBUJvN+/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789601764; c=relaxed/simple;
	bh=DmAmUwXQCZH/5zjY1OpTFiVr8099K87UzumzCeLR1go=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=O6V3gQhA79zgxopP7a89/LixJpmX5zk4hyeWfwzD7sYno0wobuKsS9eAhin7JUXh/BAaxvHFZ3OO2xS3QxBgGqJ0qxDz9BgQRjG5K4wOo67Ny1AWfV76Ja0gjKt1r70PaacvAbd/0Rr3XPAwVmUri1XNz3eOMx96/Y3vZcxU//I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hZHe5zmL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hZHe5zmL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 923501F00893;
	Wed, 16 Sep 2026 23:36:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789601762;
	bh=eCuzUlCpBSagSCXgVWeEMtoVnAGgoZr+advm+yEOsQE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=hZHe5zmLby3E/q1c3f3d3RMuJ8QSDR7iWaW86jQbagSqaqVbxXKYgKFz3xbBC2BNS
	 vsVwpAKl0SMh2mb6dN0wo8LeLnEwRamVJQrZeB8L4VTf8JsRL5IrkFRXHJY/E+UXI3
	 EqE8Q9cp5EdkNsFH/VaZK9e4N5u0VdCRbvUIQT46Etq0mzIc1om2TrS/nkpYURGR0I
	 Cy/lssPHiaMyJBNHaexA41RJdtCLytKsIEN9j5/lcOKJ67rK1xR0o9E/m5hEujiie2
	 RSnoElsJ+068fnhi8o9yaNTFNG0isa4LYWpI8HEt5/ZidUdCjgJoYPTs6tq2/6AZ1n
	 BunwZdSnek8cw==
Subject: Re: [PATCH v3 net 7/7] net: enetc: drain and cancel one-step TX
 tstamp queue when going down
From: netdev-bot+sashiko@kernel.org
To: vladimir.oltean@nxp.com
Cc: netdev@vger.kernel.org, zefir.kurtisi@westermo.com, claudiu.manoil@nxp.com,
 wei.fang@nxp.com, xiaoning.wang@nxp.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
 john.fastabend@gmail.com, sdf@fomichev.me, horms@kernel.org,
 richardcochran@gmail.com, yangbo.lu@nxp.com, ioana.ciornei@nxp.com,
 imx@lists.linux.dev, linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Date: Wed, 16 Sep 2026 23:36:01 +0000
Message-ID: <178960176110.22033.17058557096563845963@kernel.org>
In-Reply-To: <20260915222735.1016937-8-vladimir.oltean@nxp.com>
References: <20260915222735.1016937-8-vladimir.oltean@nxp.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 4 potential
issue(s) to consider:

Critical: 0 · High: 0 (1) · Medium: 4 · Low: 0

- [Medium] The drain/cancel/flag-reset is added to enetc_stop(), which is
  not only the "going down" path but also the generic "pause traffic"…
- [Medium] The new cancel_work_sync() + skb_queue_purge(&priv->tx_skbs) +
  clear_bit_unlock(ENETC_TX_ONESTEP_TSTAMP_IN_PROGRESS) sequence in…
- [Medium] The patch's justification footnote accepts that
  enetc_tx_onestep_tstamp() can call enetc_start_xmit() after…
- [Medium] The new unconditional
  clear_bit_unlock(ENETC_TX_ONESTEP_TSTAMP_IN_PROGRESS) in enetc_stop()…

Pre-existing issues:
- [High] enetc_tx_onestep_tstamp() (enetc.c:2996-2998) dequeues an skb
  from priv->tx_skbs and calls enetc_start_xmit() while discarding the…

--

net: enetc: drain and cancel one-step TX tstamp queue when going down

The patch cancels the priv->tx_onestep_tstamp work item, purges the
priv->tx_skbs queue and resets ENETC_TX_ONESTEP_TSTAMP_IN_PROGRESS in
enetc_stop(), after napi_disable(), so that no deferred one-step PTP Sync
packet survives ifdown or driver unbind.

> diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c b/drivers/net/ethernet/freescale/enetc/enetc.c
> index 62cdcaab3f3fb..892490ff1ebee 100644
> --- a/drivers/net/ethernet/freescale/enetc/enetc.c
> +++ b/drivers/net/ethernet/freescale/enetc/enetc.c
> @@ -3110,6 +3110,10 @@ void enetc_stop(struct net_device *ndev)
>  		napi_disable(&priv->int_vector[i]->napi);
>  	}
>  
> +	cancel_work_sync(&priv->tx_onestep_tstamp);

[Severity: Medium]
The commit message says the late frame submitted by the work item "will be
put in the disabled TX BD ring, where nothing will happen with it until
enetc_free_rxtx_rings() later reclaims its memory".  Does that cover the
hardware producer index as well?

enetc_map_tx_buffs() ends in enetc_update_tx_ring_tail():

	/* includes wmb() */
	enetc_wr_reg_hot(tx_ring->tpir, tx_ring->next_to_use);

so a submission that lands after enetc_disable_tx_bdrs() advances
ENETC_TBPIR and tx_ring->next_to_use.  Neither enetc_stop(),
enetc_free_tx_ring() nor enetc_assign_tx_resource() rolls those back, and
enetc_setup_txbdr() adopts the register values instead of clearing them on
ENETC v1:

	/* For ENETC v1, clearing PI/CI registers for Tx not supported,
	 * adjust sw indexes
	 */
	tx_ring->next_to_use = enetc_txbdr_rd(hw, idx, ENETC_TBPIR);
	tx_ring->next_to_clean = enetc_txbdr_rd(hw, idx, ENETC_TBCIR) &
				 ENETC_TBCIR_IDX_MASK;

	if (tx_ring->next_to_use != tx_ring->next_to_clean &&
	    !is_enetc_rev1(si)) {

After enetc_reconfigure() (enetc_stop(); enetc_free_rxtx_rings(); new
resources; enetc_setup_bdrs(); enetc_start();) an ENETC v1 part would come
back up with TBPIR != TBCIR on a freshly allocated, zero-filled BD ring, and
the driver's next_to_clean would point at a scrubbed swbd whose skb and DMA
mapping were already released by enetc_free_tx_frame().  Should the stop or
teardown path reconcile TBPIR with next_to_use, or keep the one-step frame
out of the disabled ring in the first place?

> +	skb_queue_purge(&priv->tx_skbs);

[Severity: Medium]
enetc_stop() is also the generic "pause traffic" helper, not only the going
down path.  It has three callers: enetc_close(), enetc_reconfigure() and
enetc_set_coalesce().  In the last two the interface stays administratively
up, so is the unconditional purge here dropping one-step Sync packets for
which the driver already returned NETDEV_TX_OK in enetc_start_xmit()?

	if (enetc_cb->flag & ENETC_F_TX_ONESTEP_SYNC_TSTAMP) {
		if (test_and_set_bit_lock(ENETC_TX_ONESTEP_TSTAMP_IN_PROGRESS,
					  &priv->flags)) {
			skb_queue_tail(&priv->tx_skbs, skb);
			return NETDEV_TX_OK;
		}
	}

That would make ethtool -C, XDP program attach/detach and hwtstamp
reconfiguration silently discard accepted PTP Sync frames.

Related to the same call sites, the footnote's reclaim argument does not seem
to hold for enetc_set_coalesce(), which is just:

	if (netif_running(ndev) && changed) {
		/* reconfigure the operation mode of h/w interrupts,
		 * traffic needs to be paused in the process
		 */
		enetc_stop(ndev);
		enetc_start(ndev);
	}

There is no enetc_free_rxtx_rings() in between, so a descriptor left in the
ring by the flushed work item is not reclaimed but transmitted once the ring
is re-enabled.  Should the drain live in enetc_close() instead, or be
conditional on the interface actually going down?

[Severity: High]
This isn't a bug introduced by this patch, but it limits what the new purge
can reclaim.  enetc_tx_onestep_tstamp() discards the return value of
enetc_start_xmit():

	skb = skb_dequeue(&priv->tx_skbs);
	if (skb)
		enetc_start_xmit(skb, priv->ndev);

enetc_start_xmit() has NETDEV_TX_BUSY exits (the LSO and TSO paths, plus the
linear one):

		if (enetc_bd_unused(tx_ring) < ENETC_TXBDS_NEEDED(count)) {
			netif_stop_subqueue(ndev, tx_ring->index);
			return NETDEV_TX_BUSY;
		}

which neither transmit nor free the skb, because only a qdisc caller can
requeue it.  Does the work item leak that skb, given the dequeued reference
is the only one left?

The one-step branch has already run test_and_set_bit_lock() before those
returns, so does ENETC_TX_ONESTEP_TSTAMP_IN_PROGRESS also stay set with no
packet in flight?  The work item is only rescheduled from
enetc_clean_tx_ring() on a one-step TX completion, and that schedule_work()
happens inside the cleanup loop while tx_ring->next_to_clean is published
only after the loop, so the worker can observe a stale, nearly-full ring:

enetc_poll() -> enetc_clean_tx_ring()
	schedule_work(&priv->tx_onestep_tstamp);   /* inside the loop */
	...
	tx_ring->next_to_clean = i;                /* after the loop */

Such an abandoned skb is neither on priv->tx_skbs for the new
skb_queue_purge() nor in a TX ring for enetc_free_rxtx_rings(), so it would
survive ifdown and unbind too.

> +	clear_bit_unlock(ENETC_TX_ONESTEP_TSTAMP_IN_PROGRESS, &priv->flags);

[Severity: Medium]
The peer consumer touches exactly this state under the TX lock:

enetc_tx_onestep_tstamp()
	netif_tx_lock_bh(priv->ndev);
	clear_bit_unlock(ENETC_TX_ONESTEP_TSTAMP_IN_PROGRESS, &priv->flags);
	skb = skb_dequeue(&priv->tx_skbs);

Should the new drain and flag reset take netif_tx_lock_bh() as well?
netif_tx_stop_all_queues() only sets QUEUE_STATE_DRV_XOFF, it is not
netif_tx_disable() and takes no per-queue TX lock, so an ndo_start_xmit that
already passed the netif_xmit_frozen_or_stopped() check inside
HARD_TX_LOCK can still be running enetc_start_xmit() concurrently, and
enetc_start_xmit() has no ENETC_TX_DOWN test.

For the ndo_stop path this looks harmless, since __dev_close_many() calls
dev_deactivate_many(head, true) and waits for some_qdisc_is_busy() before
ndo_stop.  But enetc_set_coalesce() and enetc_reconfigure() call enetc_stop()
on a live interface with no qdisc deactivation, so:

CPU A                                  CPU B
enetc_start_xmit()                     enetc_stop()
                                       -> skb_queue_purge(&priv->tx_skbs)
                                       -> clear_bit_unlock(IN_PROGRESS)
-> test_and_set_bit_lock(IN_PROGRESS)
-> skb_queue_tail(&priv->tx_skbs, skb)

In the enetc_reconfigure() case the racing frame is released by
enetc_free_rxtx_rings() -> enetc_free_tx_frame(), which produces no TX
completion, so nothing calls schedule_work(&priv->tx_onestep_tstamp) again.
enetc_start() clears only ENETC_TX_DOWN and enetc_tx_onestep_tstamp_init() is
just INIT_WORK plus skb_queue_head_init:

	INIT_WORK(&priv->tx_onestep_tstamp, enetc_tx_onestep_tstamp);
	skb_queue_head_init(&priv->tx_skbs);

so can the IN_PROGRESS bit stay set for the rest of the up cycle, with every
subsequent one-step Sync appended to priv->tx_skbs and never sent?

[Severity: Medium]
This clear also releases the gate that enforces the MAC's "one single-step
frame in flight" rule, and the commit message accepts that cancel_work_sync()
may join the work item only after it pushed its frame into the disabled ring.

enetc_set_coalesce() then re-enables the same ring without reinitializing it,
via enetc_start() -> enetc_enable_txbdr():

	tbmr = enetc_txbdr_rd(hw, idx, ENETC_TBMR);
	tbmr |= ENETC_TBMR_EN;
	enetc_txbdr_wr(hw, idx, ENETC_TBMR, tbmr);

so the stale one-step descriptor is fetched and transmitted at a point where
the gate is already clear.  A new one-step Sync accepted right after
enetc_start() reprograms the single global single-step register:

	val |= ENETC_SET_SINGLE_STEP_OFFSET(offset);
	if (udp)
		val |= ENETC_PM0_SINGLE_STEP_CH;
	enetc_port_mac_wr(si, ENETC_PM0_SINGLE_STEP, val);

Can the correction field offset and the UDP checksum selector then be applied
to the wrong frame?  And when the stale frame finally completes, its
schedule_work() makes enetc_tx_onestep_tstamp() clear a gate that now belongs
to the newer frame, so does the one-in-flight invariant stay broken for
subsequent frames as well?

> +
>  	enetc_clear_interrupts(priv);
>  }
>  EXPORT_SYMBOL_GPL(enetc_stop);

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260915222735.1016937-1-vladimir.oltean%40nxp.com
