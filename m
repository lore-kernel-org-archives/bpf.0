Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD429457E79;
	Thu, 10 Sep 2026 22:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789078438; cv=none; b=GiDt6C7fKTMqdKk1zUBzc1JTDjjGJHbqEOrhU8bYens0x+H1Hnpl1vIV0gC1x3S4Yvm6WDN0yhuCzSSR5TfJsjADYNAcXvlfX3C/pbU9ESA4eVKflsL48U5ZAdOxVl2ZDv7Cyc1skT/xks2KACCeDdaS8llIlHPJ3z0TlUIurOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789078438; c=relaxed/simple;
	bh=GW27kSNAiYsMWHGEo6vteZK+E8LuuLD6ovkej5VaiQ4=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LayhW8D1U9P4UA9105NBZGzRfE3htCMDlXRSdJecjWEdj2oaOBc64V7IgEQPYnpaV0Z3TZ4bkESea+pTESqtHAx5/pyovJfth8T/t4eJ98/Nm8JeBnyYTZVXMa1Y7B12NSDNcwoBKlXc3qsW1DRcKI3EE2IWiTPTp17wy3HeI1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kLfG1sca; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kLfG1sca"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 445151F00893;
	Thu, 10 Sep 2026 22:13:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789078436;
	bh=pPLqidj/PV0YkU7qNTi1oDxKhrqDwQ28FA7vI2cznK4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=kLfG1sca9uzAGHjXVLsqS4OlxZay6v8atzLjS9pRGNVFs/jy8WsuHJYli35RgFtAx
	 HsWg/KeDXsr9CcU2MkTqoM1vR98eKJfAZ1l5WDGcpmIWR7c+JMR7W/9sDLrg+D58HP
	 Bmg3Uty7Mywi13Hel09W1zYD5i8L23ZrrB9kVewiq1H3eYvBh5FWc0fxh0DvQ/aPUg
	 VIvEC5+pU2nWtfg5CWk2g1lwyMh4+mDJ7oWUZc3XqfET9yTmlqpRb9Y2YJh+XN3b5G
	 HbxNEAm6njmSUkrqzuuT/xBDYu6wOPg5bNp9B6HXpDDoZCJV+zY1pKyrebVRQe0/HY
	 d5AbyMFL9/Lhw==
Subject: Re: [PATCH net-next v6 06/12] gve: simplify reset logic
From: netdev-bot+sashiko@kernel.org
To: hramamurthy@google.com
Cc: netdev@vger.kernel.org, joshwash@google.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
 john.fastabend@gmail.com, sdf@fomichev.me, jordanrhee@google.com,
 willemb@google.com, nktgrg@google.com, maolson@google.com, thostet@google.com,
 jacob.e.keller@intel.com, debarghyak@google.com, kees@kernel.org,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 przemyslaw.kitszel@intel.com
Date: Thu, 10 Sep 2026 22:13:54 +0000
Message-ID: <178907843486.219967.15219569295959777862@kernel.org>
In-Reply-To: <20260909191136.3811892-7-hramamurthy@google.com>
References: <20260909191136.3811892-7-hramamurthy@google.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider:

Critical: 0 · High: 2 (1) · Medium: 1 · Low: 0

- [High] Inconsistent work quiescing across the new gve_teardown_device()
  call sites leaves priv->stats_report_task able to run after…
- [High] The new reset/close flow releases data-plane DMA before the
  hardware reset that revokes the device's access to it.
- [Medium] gve_mgmnt_intr() now returns IRQ_NONE without queueing
  priv->service_task whenever GVE_PRIV_FLAGS_DEVICE_RESOURCES_OK is…

Pre-existing issues:
- [High] After gve_reset() fails to recover (gve_recover() ->
  teardown_device), the netdev is left administratively UP (nothing…

--

Here is the report.

gve: simplify reset logic

This reworks the gve reset path: recursive resets and resets during
teardown are removed, allocation is split from device setup, and a single
gve_teardown_device() / gve_recover() pair replaces the old
gve_reset_and_teardown() / gve_reset_recovery() helpers.

A few questions on the new teardown ordering and work-item quiescing
below.

> diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/ethernet/google/gve/gve_main.c
> index 2fe280cf7e680..87388856ff6c5 100644
> --- a/drivers/net/ethernet/google/gve/gve_main.c
> +++ b/drivers/net/ethernet/google/gve/gve_main.c
> @@ -270,6 +270,10 @@ static irqreturn_t gve_mgmnt_intr(int irq, void *arg)
>  {
>  	struct gve_priv *priv = arg;
>  
> +	/* Device resources are not okay; consider the interrupt spurious. */
> +	if (!gve_get_device_resources_ok(priv))
> +		return IRQ_NONE;
> +
>  	queue_work(priv->gve_wq, &priv->service_task);
>  	return IRQ_HANDLED;
>  }

[Severity: Medium]
Can this drop a management notification instead of latching it?

The mgmt vector is live from gve_alloc_notify_blocks()/setup_mgmt_irq()
until it is released, but device_resources_ok is only set at the end of
gve_setup_control_plane_resources() and is cleared at the very start of
gve_teardown_control_plane_resources(). So for the whole teardown window
inside gve_teardown_device(), and for gve_recover()'s
adminq_init/verify/setup_device phase, this returns IRQ_NONE without
queueing the service task.

gve_service_task() is the only reader of reg_bar0->device_status (it feeds
gve_handle_status() for the device-requested-reset bit and the link
handling), and the only other re-sample point is the
queue_work(priv->gve_wq, &priv->service_task) at the end of
gve_queues_start(). When gve_recover() runs with setup_queues == false
(was_up false, or gve_reset(priv, true) from gve_close()'s reset path),
gve_open() is never called:

	if (setup_queues) {
		err = gve_open(priv->dev);

Is a device reset request or link transition asserted in that window
recovered anywhere, or is it lost until the next unrelated open?

Since gve_reset() already brackets the teardown with
disable_work()/enable_work(&priv->service_task), would keeping the
unconditional queue_work() here be equivalent for exclusion purposes
without discarding the notification? Also, for a dedicated (non-shared)
MSI-X vector, repeatedly returning IRQ_NONE feeds the core spurious
interrupt detector.

[ ... ]

> -static void gve_trigger_reset(struct gve_priv *priv);
> -
> -static void gve_teardown_device_resources(struct gve_priv *priv)
> +/**
> + * gve_teardown_control_plane_resources() - Request the device to release any
> + * shared allocated resources.

[ ... ]

> +static void gve_teardown_device(struct gve_priv *priv)
> +{
> +	gve_teardown_control_plane_resources(priv);
> +	gve_adminq_free(priv);
> +	/*
> +	 * Free any resources shared with the device only after we have a
> +	 * guarantee that the device will not try to access such resources.
> +	 * Device commands in gve_teardown_control_plane_resources can fail, in
> +	 * which case, device resources won't be relinquished until
> +	 * gve_adminq_free is called to trigger a device reset.
> +	 */
> +	gve_free_control_plane_resources(priv);
> +}
> +

[Severity: High]
Is priv->stats_report_task guaranteed to be quiesced by the time
gve_free_control_plane_resources() -> gve_free_stats_report() frees the
coherent buffer?

gve_free_stats_report() only stops the timer and frees:

	if (!priv->stats_report)
		return;

	timer_delete_sync(&priv->stats_report_timer);
	dma_free_coherent(&priv->pdev->dev, priv->stats_report_len,
			  priv->stats_report, priv->stats_report_bus);
	priv->stats_report = NULL;

The only cancel_work_sync(&priv->stats_report_task) added by this patch is
in gve_queues_stop(), which the teardown paths only reach when the
interface was up (gve_reset() calls it under if (was_up); gve_remove(),
gve_shutdown() and gve_suspend() reach it only via gve_close()).

gve_set_priv_flags() in gve_ethtool.c arms the timer with no
netif_running() check:

	if (flags & BIT(0)) {
		mod_timer(&priv->stats_report_timer,
			  round_jiffies(jiffies +
					msecs_to_jiffies(priv->stats_report_timer_period)));
	}

so with report-stats enabled on a down interface the chain
gve_stats_report_timer() -> gve_stats_report_schedule() ->
queue_work(priv->gve_wq, &priv->stats_report_task) can leave the work
pending across gve_teardown_device(). gve_handle_report_stats() then does:

	struct stats *stats = priv->stats_report->stats;
	...
	be64_add_cpu(&priv->stats_report->written_count, 1);

which is either a write into the just-freed DMA coherent buffer or a NULL
dereference once priv->stats_report has been set to NULL. In gve_remove()
the pending item is only drained by destroy_workqueue(), i.e. after
gve_teardown_device() has already freed it.

Would it be simpler to do the cancel_work_sync(&priv->stats_report_task)
inside gve_free_stats_report() (or in gve_teardown_device()) so every call
site is covered regardless of whether the interface was up?

[ ... ]

> @@ -1435,6 +1472,12 @@ static int gve_open(struct net_device *dev)
>  	struct gve_priv *priv = netdev_priv(dev);
>  	int err;
>  
> +	if (!gve_get_device_resources_ok(priv)) {
> +		dev_err(&priv->pdev->dev,
> +			"Attempting to open netdev without resources. Device must be reset.");
> +		return -ENODEV;
> +	}
> +

[Severity: High]
This isn't a bug introduced by this patch (the baseline
gve_reset_recovery() error path also left the interface up with
priv->xsk_pools == NULL after gve_teardown_priv_resources()), but since
this patch restructures exactly that path and adds the resources_ok gate
here, should the other user-reachable entry points get the same gate?

After gve_recover() takes its teardown_device label, the netdev is still
administratively up (nothing calls dev_close()), while
gve_teardown_device() has set priv->xsk_pools = NULL,
priv->ptype_lut_dqo = NULL, priv->tx/priv->rx = NULL, freed the notify
blocks, and dma_pool_free()d the adminq buffer while priv->adminq keeps
its stale pointer.

gve_xsk_pool_disable() only bounds-checks the queue id:

	if (qid >= priv->rx_cfg.num_queues)
		return -EINVAL;

	clear_bit(qid, priv->xsk_pools);

and closing an AF_XDP zero-copy socket reaches ndo_bpf(XDP_SETUP_XSK_POOL,
pool == NULL) without any netif_running() test (xp_clear_dev() /
xp_disable_drv_zc()), so this is a clear_bit() on a NULL bitmap.
gve_set_priv_flags() likewise memsets priv->stats_report->stats when
report-stats is turned off, and gve_adjust_queues()/gve_adjust_config()
issue adminq commands through the freed priv->adminq while netif_running()
is true.

The failed-recovery precondition is easy to reach now that
gve_add_flow_rule()/gve_del_flow_rule() call gve_reset(priv, false) on
-ETIME, and gve_recover() bails out to teardown_device when e.g.
gve_adminq_verify_driver_compatibility() times out.

> @@ -1451,41 +1494,16 @@ static int gve_open(struct net_device *dev)
>  	return 0;
>  }
>  
> -static int gve_queues_stop(struct gve_priv *priv)
> +static void gve_queues_stop(struct gve_priv *priv)
>  {
> -	int err;
> +	gve_unreg_xdp_info(priv);
> +	gve_drain_page_cache(priv);
>  
> -	netif_carrier_off(priv->dev);
> -	if (gve_get_device_rings_ok(priv)) {
> -		gve_turndown(priv);
> -		gve_drain_page_cache(priv);
> -		err = gve_destroy_rings(priv);
> -		if (err)
> -			goto err;
> -		err = gve_unregister_qpls(priv);
> -		if (err)
> -			goto err;
> -		gve_clear_device_rings_ok(priv);
> -	}
>  	timer_delete_sync(&priv->stats_report_timer);
> -
> -	gve_unreg_xdp_info(priv);
> +	cancel_work_sync(&priv->stats_report_task);
>  
>  	gve_tx_stop_rings(priv, gve_num_tx_queues(priv));
>  	gve_rx_stop_rings(priv, priv->rx_cfg.num_queues);
> -
> -	priv->interface_down_cnt++;
> -	return 0;
> -
> -err:
> -	/* This must have been called from a reset due to the rtnl lock
> -	 * so just return at this point.
> -	 */
> -	if (gve_get_reset_in_progress(priv))
> -		return err;
> -	/* Otherwise reset before returning */
> -	gve_reset_and_teardown(priv, true);
> -	return gve_reset_recovery(priv, false);
>  }
>  
>  static int gve_close(struct net_device *dev)
> @@ -1493,12 +1511,30 @@ static int gve_close(struct net_device *dev)
>  	struct gve_priv *priv = netdev_priv(dev);
>  	int err;
>  
> -	err = gve_queues_stop(priv);
> -	if (err)
> -		return err;
> +	gve_turndown(priv);
> +
> +	/* Surrender to reset if the queue destroying adminq cmds fail. Reset
> +	 * will not re-enable the interface.
> +	 */
> +	if (gve_get_device_rings_ok(priv)) {
> +		gve_clear_device_rings_ok(priv);
> +		err = gve_destroy_rings(priv);
> +		if (err)
> +			goto reset;
> +		err = gve_unregister_qpls(priv);
> +		if (err)
> +			goto reset;
> +	}
>  
> +	gve_queues_stop(priv);
>  	gve_queues_mem_remove(priv);
> +	priv->interface_down_cnt++;
>  	return 0;
> +
> +reset:
> +	gve_queues_stop(priv);
> +	err = gve_reset(priv, true);
> +	return err;
>  }

[Severity: High]
On this new reset: label, is it safe to release the ring buffers before
the hardware reset?

gve_destroy_rings() or gve_unregister_qpls() failing (typically -ETIME
from gve_adminq_kick_and_wait() -> gve_adminq_wait_for_cmd()) means the
NIC never acknowledged that it stopped using those queues. gve_queues_stop()
then does:

	gve_tx_stop_rings(priv, gve_num_tx_queues(priv));
	gve_rx_stop_rings(priv, priv->rx_cfg.num_queues);

which for DQO returns RX buffer pages via gve_free_to_page_pool()/
gve_free_qpl_page_dqo(), dma_unmaps pending TX buffers
(gve_tx_clean_pending_packets() -> gve_unmap_packet()) and memsets the
descriptor/completion rings and q_resources.

The point at which the device is guaranteed to have stopped touching that
memory only comes later, in gve_reset() -> gve_teardown_device() ->
gve_adminq_free() -> gve_adminq_release():

	iowrite32be(GVE_DRIVER_STATUS_RESET_MASK, &priv->reg_bar0->driver_status);
	while (!(ioread32be(&priv->reg_bar0->device_status)
			& GVE_DEVICE_STATUS_DEVICE_IS_RESET)) { ... }

The pre-patch code returned from gve_queues_stop() before stopping the
rings on a destroy failure, and gve_reset_and_teardown() called
gve_trigger_reset() (which blocks until DEVICE_IS_RESET) first. Should the
hardware reset happen before gve_queues_stop() here?

The commit message applies exactly this reasoning to the control plane:

    With the new reset functionality, shared resources between the device
    and driver are not freed until after the hardware reset has completed

Does the same invariant hold for the data-plane rings and buffers on this
path?

[ ... ]

> -int gve_reset(struct gve_priv *priv, bool attempt_teardown)
> +int gve_reset(struct gve_priv *priv, bool skip_queue_setup)
>  {
>  	bool was_up = netif_running(priv->dev);
>  	int err;
>  
> +	if (gve_get_reset_in_progress(priv))
> +		return 0;
> +
>  	dev_info(&priv->pdev->dev, "Performing reset\n");
>  	gve_clear_do_reset(priv);
>  	gve_set_reset_in_progress(priv);
> -	/* If we aren't attempting to teardown normally, just go turndown and
> -	 * reset right away.
> -	 */
> -	if (!attempt_teardown) {
> +
> +	if (was_up) {
>  		gve_turndown(priv);
> -		gve_reset_and_teardown(priv, was_up);
> -	} else {
> -		/* Otherwise attempt to close normally */
> -		if (was_up) {
> -			err = gve_close(priv->dev);
> -			/* If that fails reset as we did above */
> -			if (err)
> -				gve_reset_and_teardown(priv, was_up);
> +		if (gve_get_device_rings_ok(priv)) {
> +			gve_clear_device_rings_ok(priv);
> +			gve_destroy_rings(priv);
> +			gve_unregister_qpls(priv);
>  		}
> -		/* Clean up any remaining resources */
> -		gve_teardown_priv_resources(priv);
> +		gve_queues_stop(priv);
>  	}

[Severity: High]
Same ordering question here, with the added detail that the return values
of gve_destroy_rings() and gve_unregister_qpls() are not inspected at all,
so gve_queues_stop() unmaps/recycles the ring memory unconditionally,
including for a device whose adminq is not responding.

There is a mirror of this on the recovery side: with RESET_IN_PROGRESS
set, a create-rings failure makes gve_queues_start() take
stop_and_free_rings:

	stop_and_free_rings:
		gve_tx_stop_rings(priv, gve_num_tx_queues(priv));
		gve_rx_stop_rings(priv, priv->rx_cfg.num_queues);
		gve_queues_mem_remove(priv);

which frees the coherent rings and QPL pages even though some TX queues
may already have been created in hardware, with the reset handshake only
happening later when gve_recover() calls gve_teardown_device(). Can the
NIC still be writing into those pages at that point?

>  
> -	/* Set it all back up */
> -	err = gve_reset_recovery(priv, was_up);
> +	disable_work(&priv->service_task);
> +	gve_teardown_device(priv);
> +	gve_queues_mem_remove(priv);
> +
> +	enable_work(&priv->service_task);
> +	err = gve_recover(priv, was_up && !skip_queue_setup);
> +	if (err)
> +		dev_info(&priv->pdev->dev,
> +			 "Failed to recover in reset: %d\n", err);
> +

[Severity: High]
Only priv->service_task is disabled around gve_teardown_device() here.
When was_up is false, gve_queues_stop() (the sole
cancel_work_sync(&priv->stats_report_task) call site) is skipped, so a
stats work item queued by the timer can run concurrently with
gve_free_stats_report(). Should priv->stats_report_task be quiesced here
too?

[ ... ]

> @@ -2943,8 +2952,9 @@ static int gve_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
>  	queue_work(priv->gve_wq, &priv->service_task);
>  	return 0;
>  
> -abort_with_gve_init:
> -	gve_teardown_priv_resources(priv);
> +abort_teardown_device:
> +	disable_work(&priv->stats_report_task);
> +	gve_teardown_device(priv);

[Severity: High]
Is this disabling the intended work item? During probe, the stats work has
no producer yet (its only producer is the timer armed by
gve_queues_start() or by ethtool on a registered netdev), while
priv->service_task is queueable at this point because gve_setup_device()
already set device_resources_ok and the mgmt IRQ is requested. Every other
teardown site in this patch uses disable_work_sync(&priv->service_task).

Should this be disable_work_sync(&priv->service_task) instead, or in
addition?

> @@ -2976,7 +2986,8 @@ static void gve_remove(struct pci_dev *pdev)
>  	void __iomem *reg_bar = priv->reg_bar0;
>  
>  	unregister_netdev(netdev);
> -	gve_teardown_priv_resources(priv);
> +	disable_work_sync(&priv->service_task);
> +	gve_teardown_device(priv);
>  	destroy_workqueue(priv->gve_wq);

[Severity: High]
For an interface that was already down, unregister_netdev() does not call
gve_close(), so nothing cancels priv->stats_report_task before
gve_teardown_device() frees priv->stats_report. destroy_workqueue() then
drains the pending stats work after the free. Does the ordering here need
a disable_work_sync(&priv->stats_report_task) as well?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260909191136.3811892-1-hramamurthy%40google.com
