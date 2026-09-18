Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 013134A1E1B;
	Fri, 18 Sep 2026 07:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789718274; cv=none; b=SlEfXrkOVGseipLQJLhTVJGvvijHl+t5KNrr+TiSMp1BPXAgbGnEmo/MLxKiK7CztUwF1WxTNbIDu2APYEyk4gFxIsdfQ9V9K2sDahHPnmGeJZ1029i72rHm6cbvaTLBNSqC4CPLbpxEHuqbZWCB3plw/vIePjuPdkmSt0Iub0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789718274; c=relaxed/simple;
	bh=PV88ity/1n7Vxg7eiSuNXK7/f2saivIiOn4rDXBOALc=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AhEKBZeKcOqT3viIKl/nC8rU8WiHC3O4rbJKZIcqr3lPNGU8Y+hOHi4L+VtQm2LVzcjVct1VYOGRiidsEV7vocEct+uBwr/m6z4Zwu1OjHRt6/Ohf4tCl2NMjlBENUe7ngu1QrnokBfh9YEk9Sm1zZGu2X9nSaKndnzhRhA+w4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MX8j097C; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MX8j097C"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA1341F000FF;
	Fri, 18 Sep 2026 07:57:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789718268;
	bh=CTV5bKK2QoBsVLHWhh1OkjDqqs6Ks2Xgx8l98FIbbg0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=MX8j097C7EmEn414NaLXVLa+0hpMiVI+Zm6yorsRg/NJAGWPnfz1p/gidMiABeGK5
	 8BS0wMwIJsBnKfzMp2VZlQM3nm/zOm+85BfFNgTWdqrd4Ti1q+fTnVuWAdImBA/kVm
	 zuTyoCF0L2fE+8QnD//jNM1qNvp1052VRnqgRAeffn/8fp+LfRfyDkJA3EoCrHS0i3
	 t85l/r5lgvMMVHDy+pCJUFjugmu0jzuHhdftwTpvRk6mYwg05rVgFfHHVmoeg0UZTI
	 o9aJr/OtQUCWdtzxHg6R1xpSTak2t7F6lzDbtPUWE0L9f0MgedcuUuPSme7KBZ93fV
	 WXhTVRPmCvYZA==
Subject: Re: [PATCH net-next v7 06/12] gve: simplify reset logic
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
Date: Fri, 18 Sep 2026 07:57:46 +0000
Message-ID: <178971826647.22033.15667934166032456970@kernel.org>
In-Reply-To: <20260916165533.2187434-7-hramamurthy@google.com>
References: <20260916165533.2187434-7-hramamurthy@google.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 7 potential
issue(s) to consider:

Critical: 0 · High: 1 · Medium: 4 (2) · Low: 2

- [High] gve_recover()'s new failure path calls gve_teardown_device()
  (e.g. when gve_open() fails on queue-memory allocation), freeing all…
- [Medium] The -ETIME (admin-queue timeout) reset trigger was removed
  from the shared helper gve_adminq_configure_flow_rule() and re-added…
- [Medium] gve_mgmnt_intr() now silently discards the management
  interrupt whenever DEVICE_RESOURCES_OK is clear.
- [Medium] gve_queues_start()'s `reset:` path returns gve_reset()'s
  status instead of the original error, so a successful reset converts a…
- [Medium] Queue-creation failure during reset recovery frees device-
  owned ring memory before the hardware reset.
- [Low] The patch removes a synchronous gve_reset() on admin-queue
  timeout from the shared flow-rule helper, which fixes a genuine…
- [Low] The commit message uses a `deconfigure_device_resources` failure
  as its example of a path that 'preempts its reset with another reset…

Pre-existing issues:
- [Medium] Failed queue setup during reset recovery omits
  gve_unreg_xdp_info(), leaking the XDP memory-model reference on DQO…
- [Medium] A service task that already observed GVE_PRIV_FLAGS_DO_RESET
  can block on RTNL while a concurrent direct gve_reset() (ethtool/flow-…

--

gve: simplify reset logic

This reworks the gve reset path: recursive resets and resets during
teardown are removed, allocation is split from device setup, and the
hardware reset is now performed before shared resources are freed.

> gve: simplify reset logic
>
> [ ... ]
>
> 2) Removing resets during teardown. This is partly covered by removing
>    recursive resets, but the primary goal in this case is to ensure that
>    the driver is capable of actually executing a hardware reset if
>    something goes wrong with a control plane operation. As it stands, if
>    `deconfigure_device_resources` fails, for example, GVE will preempt
>    its reset with another reset without actually invoking a hardware
>    reset, which could actually help with recovery.

[Severity: Low]
Is the deconfigure_device_resources example accurate?  In the baseline that
branch calls gve_trigger_reset(), which is just a wrapper for
gve_adminq_release():

gve_teardown_device_resources()
	err = gve_adminq_deconfigure_device_resources(priv);
	if (err) {
		dev_err(...);
		gve_trigger_reset(priv);
	}

and gve_adminq_release() does perform the hardware reset and waits for the
device to acknowledge it:

	iowrite32be(GVE_DRIVER_STATUS_RESET_MASK, &priv->reg_bar0->driver_status);
	while (!(ioread32be(&priv->reg_bar0->device_status)
			& GVE_DEVICE_STATUS_DEVICE_IS_RESET))

The path that really recursed is the flow-rule -ETIME case, where
gve_adminq_configure_flow_rule() called gve_reset() from inside teardown.
Could the changelog name that case instead?

> diff --git a/drivers/net/ethernet/google/gve/gve_adminq.c b/drivers/net/ethernet/google/gve/gve_adminq.c
> index a62cb7a921d07..901673d2e2648 100644
> --- a/drivers/net/ethernet/google/gve/gve_adminq.c
> +++ b/drivers/net/ethernet/google/gve/gve_adminq.c

[ ... ]

> @@ -1377,12 +1376,8 @@ gve_adminq_configure_flow_rule(struct gve_priv *priv,
>  			sizeof(struct gve_adminq_configure_flow_rule),
>  			flow_rule_cmd);
>  
> -	if (err == -ETIME) {
> -		dev_err(&priv->pdev->dev, "Timeout to configure the flow rule, trigger reset");
> -		gve_reset(priv, true);
> -	} else if (!err) {
> +	if (!err)
>  		priv->flow_rules_cache.rules_cache_synced = false;
> -	}
>  
>  	return err;
>  }

[Severity: Medium]
This helper has three callers, but the -ETIME handling is re-added below only
for the add and delete cases.  Does the third caller lose reset on timeout?

gve_set_features()          /* ethtool -K <dev> ntuple off */
  gve_flow_rules_reset()
    ops->reset_flow_rules() == gve_adminq_reset_flow_rules()
      gve_adminq_configure_flow_rule()

gve_adminq_reset_flow_rules() just forwards the return value:

	return gve_adminq_configure_flow_rule(priv, &flow_rule_cmd);

and gve_set_features() does:

	err = gve_flow_rules_reset(priv);
	if (err)
		goto revert_features;

so an admin-queue timeout there no longer starts recovery, while before this
patch it called gve_reset(priv, true).  The v3 changelog says "only reset when
failing to program flow rules as ethtool op", and gve_set_features() is such
an ethtool op, so was this call site simply missed?

[Severity: Low]
Removing this gve_reset() also fixes a real recursion: teardown calls
gve_flow_rules_reset(), so an adminq timeout during gve_reset(),
gve_remove() or gve_suspend() re-entered gve_reset() from inside teardown.
Should the patch carry a Fixes: tag for 6f3bc487565d ("gve: Add flow steering
ethtool support")?  The trailers currently only have Reviewed-by and
Signed-off-by lines.

> diff --git a/drivers/net/ethernet/google/gve/gve_flow_rule.c b/drivers/net/ethernet/google/gve/gve_flow_rule.c
> index 2c80cda28ef30..fae552f4ad6fb 100644
> --- a/drivers/net/ethernet/google/gve/gve_flow_rule.c
> +++ b/drivers/net/ethernet/google/gve/gve_flow_rule.c
> @@ -278,6 +278,11 @@ int gve_add_flow_rule(struct gve_priv *priv, struct ethtool_rxnfc *cmd)
>  		goto out;
>  
>  	err = gve_adminq_add_flow_rule(priv, rule, fsp->location);
> +	if (err == -ETIME) {
> +		dev_err(&priv->pdev->dev,
> +			"Timeout to add flow rule, trigger reset.");
> +		gve_reset(priv, false);
> +	}
>  
>  out:
>  	kvfree(rule);
> @@ -290,9 +295,17 @@ int gve_add_flow_rule(struct gve_priv *priv, struct ethtool_rxnfc *cmd)
>  int gve_del_flow_rule(struct gve_priv *priv, struct ethtool_rxnfc *cmd)
>  {
>  	struct ethtool_rx_flow_spec *fsp = (struct ethtool_rx_flow_spec *)&cmd->fs;
> +	int err;
>  
>  	if (!priv->max_flow_rules)
>  		return -EOPNOTSUPP;
>  
> -	return gve_adminq_del_flow_rule(priv, fsp->location);
> +	err = gve_adminq_del_flow_rule(priv, fsp->location);
> +	if (err == -ETIME) {
> +		dev_err(&priv->pdev->dev,
> +			"Timeout to delete flow rule, trigger reset.");
> +		gve_reset(priv, false);
> +	}
> +
> +	return err;
>  }
> diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/ethernet/google/gve/gve_main.c
> index 2fe280cf7e680..82bf2c5fed3f2 100644
> --- a/drivers/net/ethernet/google/gve/gve_main.c
> +++ b/drivers/net/ethernet/google/gve/gve_main.c

[ ... ]

> @@ -270,6 +271,10 @@ static irqreturn_t gve_mgmnt_intr(int irq, void *arg)
>  {
>  	struct gve_priv *priv = arg;
>  
> +	/* Device resources are not okay; consider the interrupt spurious. */
> +	if (!gve_get_device_resources_ok(priv))
> +		return IRQ_HANDLED;
> +
>  	queue_work(priv->gve_wq, &priv->service_task);
>  	return IRQ_HANDLED;
>  }

[Severity: Medium]
Can this drop a device-requested reset?

The mgmt vector is requested in gve_alloc_notify_blocks() during the
allocation phase, while gve_set_device_resources_ok() only runs at the very
end of gve_setup_control_plane_resources(), after several blocking adminq
round trips.  Any event arriving in that window, including
GVE_DEVICE_STATUS_RESET_MASK, is acked as handled and thrown away.

The only consumer of that bit is gve_service_task():

	u32 status = ioread32be(&priv->reg_bar0->device_status);

	gve_handle_status(priv, status);

and it only runs when the service task is queued.  On the paths that call
gve_recover() with setup_queues == false (gve_reset(priv, true) from
gve_close(), and gve_resume() when up_before_suspend is false) there is no
queue_work() from gve_queues_start(), so nothing re-samples device_status
after the flag is set again.

Since disable_work()/enable_work() already stop the service task across
reset, and gve_reset() returns early on reset_in_progress, would simply
queueing the work (a no-op while disabled) or re-reading device_status after
gve_set_device_resources_ok() avoid the lost-event window?

[ ... ]

> @@ -1416,10 +1465,11 @@ static int gve_queues_start(struct gve_priv *priv,
>  reset:
>  	if (gve_get_reset_in_progress(priv))
>  		goto stop_and_free_rings;
> -	gve_reset_and_teardown(priv, true);
> -	/* if this fails there is nothing we can do so just ignore the return */
> -	gve_reset_recovery(priv, false);
> -	/* return the original error */
> +
> +	/* Attempt to reset. If reset is successful, gve_queues_start was
> +	 * successful.
> +	 */
> +	err = gve_reset(priv, false);
>  	return err;
>  stop_and_free_rings:
>  	gve_tx_stop_rings(priv, gve_num_tx_queues(priv));

[Severity: Medium]
Returning gve_reset()'s status here reports success for a queue start that
failed.  Can that silently discard a requested configuration?

In gve_queues_start() these two assignments happen only after
gve_register_qpls() succeeds:

	priv->header_split_enabled = rx_alloc_cfg->enable_header_split;
	priv->rx_cfg.packet_buffer_size = rx_alloc_cfg->packet_buffer_size;

The earlier priv->rx_cfg = *rx_alloc_cfg->qcfg_rx does not carry them,
because gve_rx_get_curr_alloc_cfg() sets cfg->qcfg_rx = &priv->rx_cfg, so an
ethtool rx-buf-len or tcp-data-split change lives only in the temporary
alloc cfg.

If gve_init_rss_config() or gve_register_qpls() fails, we jump to reset, and
gve_reset() -> gve_recover() -> gve_open() -> gve_get_curr_alloc_cfgs()
rebuilds the rings from the stale priv values, while gve_open(),
gve_adjust_config() and gve_set_ringparam() all see 0.  Would committing the
requested configuration before entering reset recovery, or propagating the
original error, be preferable?

[Severity: Medium]
The commit message says "shared resources between the device and driver are
not freed until after the hardware reset has completed".  Does the
stop_and_free_rings path below meet that guarantee during reset recovery?

gve_create_rings() returns on partial success without cleaning up, for
example TX queues created and RX creation failing:

	err = gve_adminq_create_rx_queues(priv, priv->rx_cfg.num_queues);
	if (err) {
		/* This failure will trigger a reset - no need to clean
		 * up
		 */
		return err;
	}

With reset_in_progress set by the enclosing gve_reset(), we then take
stop_and_free_rings and call gve_queues_mem_remove(), which dma_free_coherent()s
the ring memory and releases the QPL pages while those queues are still
registered with the device.  The hardware reset only happens afterwards in
gve_recover() -> gve_teardown_device() -> gve_reset_device(), whose teardown
adminq commands can block before the reset register write.  Could the device
still write into that freed memory?

[Severity: Medium]
This isn't a bug introduced by this patch, but the same stop_and_free_rings
path never calls gve_unreg_xdp_info(), so the XDP memory-model reference on
DQO page pools looks leaked.

gve_reg_xdp_info() registers the pool:

	xdp_rxq_info_reg_mem_model(&rx->xdp_rxq, MEM_TYPE_PAGE_POOL,
				   rx->dqo.page_pool);

and __xdp_reg_mem_model() takes an extra reference:

	if (type == MEM_TYPE_PAGE_POOL)
		page_pool_use_xdp_mem(allocator, mem_allocator_disconnect, mem);

while gve_rx_free_ring_dqo() only does one page_pool_destroy().  Since
xdp_rxq_info_unreg() is reached only from gve_unreg_xdp_info(), does the pool
and mem-model id stay around after a failed queue start with XDP enabled on
DQO?

[ ... ]

> @@ -2514,30 +2554,7 @@ static int gve_init_priv(struct gve_priv *priv)
>  	return 0;
>  }
>  
> -static void gve_teardown_priv_resources(struct gve_priv *priv)
> -{
> -	gve_teardown_device_resources(priv);
> -	gve_adminq_free(priv);
> -	bitmap_free(priv->xsk_pools);
> -	priv->xsk_pools = NULL;
> -}
> -
> -static void gve_trigger_reset(struct gve_priv *priv)
> -{
> -	/* Reset the device by releasing the AQ */
> -	gve_adminq_release(priv);
> -}
> -
> -static void gve_reset_and_teardown(struct gve_priv *priv, bool was_up)
> -{
> -	gve_trigger_reset(priv);
> -	/* With the reset having already happened, close cannot fail */
> -	if (was_up)
> -		gve_close(priv->dev);
> -	gve_teardown_priv_resources(priv);
> -}
> -
> -static int gve_reset_recovery(struct gve_priv *priv, bool was_up)
> +static int gve_recover(struct gve_priv *priv, bool setup_queues)
>  {
>  	int err;
>  
> @@ -2545,62 +2562,67 @@ static int gve_reset_recovery(struct gve_priv *priv, bool was_up)
>  	if (err) {
>  		dev_err(&priv->pdev->dev,
>  			"Failed to alloc admin queue: err=%d\n", err);
> -		goto err;
> +		goto teardown_device;
>  	}
>  
>  	err = gve_adminq_verify_driver_compatibility(priv);
>  	if (err) {
>  		dev_err(&priv->pdev->dev,
>  			"Could not verify driver compatibility: err=%d\n", err);
> -		goto err_free_adminq;
> +		goto teardown_device;
>  	}
>  
>  	err = gve_setup_device(priv);
>  	if (err)
> -		goto err_free_adminq;
> -	if (was_up) {
> +		goto teardown_device;
> +
> +	if (setup_queues) {
>  		err = gve_open(priv->dev);
>  		if (err)
> -			return err;
> +			goto teardown_device;
>  	}
> +
>  	return 0;
>  
> -err_free_adminq:
> -	gve_adminq_free(priv);
> -err:
> -	dev_err(&priv->pdev->dev, "Reset failed! !!! DISABLING ALL QUEUES !!!\n");
> -	gve_turndown(priv);
> +teardown_device:
> +	dev_err(&priv->pdev->dev, "Recover failed! !!! DISABLING ALL QUEUES !!!\n");
> +	gve_teardown_device(priv);
>  	return err;
>  }

[Severity: High]
Routing a gve_open() failure into gve_teardown_device() frees the whole
control plane while the netdev stays registered and administratively
running.  Can that be dereferenced afterwards?

gve_teardown_device() -> gve_free_control_plane_resources() calls
gve_free_rss_config_cache():

	kfree(rss_config->hash_key);
	kfree(rss_config->hash_lut);

	memset(rss_config, 0, sizeof(*rss_config));

and gve_free_notify_blocks(), which leaves priv->ntfy_blocks NULL, while
priv->cache_rss_config, priv->rss_key_size and priv->rss_lut_size (set in
gve_init_priv()) are untouched and nothing closes the interface.

Only gve_open() got the new resources_ok gate, so ETHTOOL_GRSSH still
reaches gve_get_rxfh() -> gve_get_rss_config_cache():

	memcpy(rxfh->key, rss_config->hash_key, priv->rss_key_size);

with hash_key == NULL, and ETHTOOL_GRSSH is one of the commands that skips
the ns_capable(net->user_ns, CAP_NET_ADMIN) check in net/ethtool/ioctl.c.

An ethtool channel change is a second route: gve_adjust_queues() still sees
netif_running(priv->dev) true, so gve_adjust_config() -> gve_queues_start()
-> gve_tx_start_rings() -> gve_tx_add_to_block() runs:

	struct gve_notify_block *block = &priv->ntfy_blocks[ntfy_idx];
	struct gve_tx_ring *tx = &priv->tx[queue_idx];

	block->tx = tx;

on a NULL array.  Should these entry points also be rejected (or the netdev
detached) while control-plane resources are gone?

>  
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

[Severity: Medium]
This is a pre-existing issue, but the new early return only covers
overlapping resets, not a stale pending request.  gve_handle_reset() samples
the bit before taking the locks and never rechecks it:

	if (gve_get_do_reset(priv)) {
		rtnl_lock();
		netdev_lock(priv->dev);
		gve_reset(priv, false);

If a direct gve_reset() from the ethtool or flow-rule path completes while
the worker is blocked on RTNL, it clears both do_reset and
reset_in_progress (and disable_work() does not wait for an already running
worker), so the worker performs a second full reset once it gets the locks.
Would rechecking do_reset after acquiring the locks be reasonable?

>  
> -	/* If we aren't attempting to teardown normally, just go turndown and
> -	 * reset right away.
> -	 */
> -	if (!attempt_teardown) {
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
>  	}
>  
> -	/* Set it all back up */
> -	err = gve_reset_recovery(priv, was_up);
> +	disable_work(&priv->service_task);
> +	gve_reset_device(priv);
> +	gve_queues_stop(priv);
> +	gve_queues_mem_remove(priv);
> +	gve_free_control_plane_resources(priv);
> +
> +	enable_work(&priv->service_task);
> +	err = gve_recover(priv, was_up && !skip_queue_setup);
> +	if (err)
> +		dev_info(&priv->pdev->dev,
> +			 "Failed to recover in reset: %d\n", err);
> +
>  	gve_clear_reset_in_progress(priv);
>  	priv->reset_cnt++;
>  	priv->interface_up_cnt = 0;

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260916165533.2187434-1-hramamurthy%40google.com
