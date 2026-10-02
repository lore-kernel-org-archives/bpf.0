Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8FAB48035A;
	Fri,  2 Oct 2026 10:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790935598; cv=none; b=ZuWIf3xvMOHDzjj+FYod2fe2lu74OS5uNERftX0V4ieg+EU1yu8jyIorm8LeARnSW4m8jk0okvYIuA11kRGNYzD/o4G26CunWAPkjXVR4jpcf7jNmPKT+R8BB3GK+2IWtX6ln7P8kwom2uzqc+2BhTbF/xXPS0UgYL5piD81wMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790935598; c=relaxed/simple;
	bh=qyn+r9DxFvgRmLQyDyv12XANhWRqJ6QD+nEYBsT2p0A=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=E7dY3/CSlJC5mniSa64nODTSAjnL4YjXVcOGX++G4eD+NFtWB20mIWmu2U89OakDbdZQXdK0immbnJcv4WHN1EIjOAQ1gBjAYyJXzU5VQ1Hhw0HEUpfLE+whDIZp5xpSYD9++BUmqhNluojFFt5zbEfITV/7UzgqYNfFxBGLar0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d7Z3V/g/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d7Z3V/g/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2401A1F00893;
	Fri,  2 Oct 2026 10:06:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790935595;
	bh=hhX5HZEdHZettWXaLXBRqdeLMh5idcAqvJqYRukNN7w=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=d7Z3V/g/btBaI/VQmuVibwbm9RxzWgLBY8GK44N4Kdvm7QB+VUQnGNqTWE5lmOHlD
	 CTm0PIZKXOCwsne29jzpnieq6ff4VEP+i2bRCvtwNNaHYYVSuNJbqBhuAPHWf/5zLL
	 ZV5eVEzvf1GpG7LsmoT3H7+wIw+VioCjZaMbPTLsKBTRz60OxTTg57e6iK0JEFSD/A
	 8jfotZT9VbGEHoYvWQsvfOjz3MRhzvZ2G6ti5F63RYkizEEqYzDpjTjxRY8FK+HkJ0
	 aTLjspvYKzNTBwde/W1b+xlygU9nTZgmBcH6U5M0zOHC/GX/PZUpuA6uZiFgFMj3kb
	 +y+G88xSvX9Hg==
Subject: Re: [PATCH net-next v9 06/12] gve: simplify reset logic
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
Date: Fri, 02 Oct 2026 10:06:33 +0000
Message-ID: <179093559372.434549.9856875950011939081@kernel.org>
In-Reply-To: <20260930190428.1130007-7-hramamurthy@google.com>
References: <20260930190428.1130007-7-hramamurthy@google.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 8 potential
issue(s) to consider.

Critical: 0 · High: 1 (3) · Medium: 2 (3) · Low: 5

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] If gve_open() fails inside gve_recover(priv, true), queue memory
  that the device may still reference is freed and the device is never…
- [Medium] In gve_recover(), when setup_queues is true and gve_open()
  fails, the function returns early and skips netif_device_attach(),…
- [Medium] On a running DQO RDA interface with XDP loaded,
  gve_xsk_pool_enable() sets the xsk_pools bit, registers the pool and…
- [Low] gve_reset() now has a single graceful path.
- [Low] When gve_recover() fails (gve_adminq_init,
  verify_driver_compatibility or gve_setup_device), it now calls…
- [Low] The patch fixes a real unbounded recursion in the baseline:
  gve_adminq_configure_flow_rule() called gve_reset(priv, true) on…
- [Low] Item 2 of the commit message says that, before this patch,
  gve_close() during gve_shutdown could trigger a hardware reset and…
- [Low] The comment above gve_queues_start() still says 'No memory is
  allocated.

Pre-existing issues:
- [High] gve_adjust_config() allocates the new rings
  (gve_queues_mem_alloc) before calling gve_close().
- [High] After a failed gve_recover() (teardown_device path),
  priv->xsk_pools, priv->ntfy_blocks and priv->stats_report are NULL,…
- [High] gve_get_stats() (ndo_get_stats64) checks 'if (priv->rx)' and 'if
  (priv->tx)' and then walks the ring arrays with no lock or RCU…
- [Medium] gve_reset() uses the non-sync
  disable_work(&priv->service_task), which does not wait for a service…
- [Medium] gve_shutdown() and gve_suspend() sample was_up =
  netif_running() before disable_work_sync() and before taking RTNL and…
- [Medium] gve_add_flow_rule(), gve_del_flow_rule() and the new NTUPLE-
  disable branch in gve_set_features() start a reset only when the error…

--

gve: simplify reset logic

This commit reworks the gve reset path to remove recursive resets and
resets triggered during teardown. It splits control plane allocation from
device setup, and gve_reset() now tears down queues and the control plane
directly before calling gve_recover(). Shared memory is meant to be freed
only after the hardware reset done in gve_adminq_free().

> 2) Removing resets during the teardown portion of reset. This is partly
>    covered by removing recursive resets, but the primary goal in this
>    case is to allow the driver to complete teardown in a more direct
>    manner. Before this patch, gve_close() when called as part of
>    gve_shutdown, could end up triggering a hardware reset, then attempt
>    to close again. In such a case, destroying hardware queues would
>    inevitably fail, causing a loop. gve_close() is no longer called
>    directly in gve_reset() breaking any possibility of this loop.

[Severity: Low]
Is this description of the old behaviour accurate? In the baseline,
gve_reset_and_teardown() calls gve_trigger_reset() first, and
gve_adminq_release() ends with:

	gve_clear_device_rings_ok(priv);
	gve_clear_device_resources_ok(priv);
	gve_clear_admin_queue_ok(priv);

The second gve_close() -> gve_queues_stop() destroys rings only under
gve_get_device_rings_ok(). So it skips gve_destroy_rings() and
gve_unregister_qpls() entirely.

The loop that did exist was the recursive gve_reset() from
gve_adminq_configure_flow_rule() on -ETIME during teardown, via
gve_teardown_device_resources() -> gve_flow_rules_reset().

Could the commit message describe that mechanism instead?

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

[Severity: Low]
Removing this call fixes a real unbounded recursion. In the baseline,
gve_reset(priv, true) was called on -ETIME, and teardown then called
gve_flow_rules_reset() again with no reset-in-progress guard:

gve_reset()
  gve_teardown_device_resources()
    gve_flow_rules_reset()
      gve_adminq_configure_flow_rule()   <- -ETIME
        gve_reset()
          ...

The patch also carries other fixes that the commit message doesn't
mention:

  - cancel_work_sync(&priv->stats_report_task) in gve_free_stats_report()
  - cancelling the PTP worker
  - the NULL priv->rx check in gve_drain_page_cache()

Should these be split out, or at least get a Fixes: tag, rather than
going in under "simplify reset logic"?

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

[Severity: Medium]
This is a pre-existing issue, which the patch moves and copies. Should this
also handle -ENOTRECOVERABLE?

gve_adminq_parse_err() returns -ETIME when the device completes a command
with a DEADLINE_EXCEEDED status. A real driver-side timeout in
gve_adminq_kick_and_wait() returns -ENOTRECOVERABLE instead, and that
triggers no reset.

Later gve_adminq_execute_cmd() calls then fail with -EINVAL through the
tail != head check. The admin queue stays unusable until something else
resets the device.

The same -ETIME-only check is used in gve_del_flow_rule() and in the new
NTUPLE disable branch in gve_set_features().

[ ... ]

> diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/ethernet/google/gve/gve_main.c
> index 2fe280cf7e680..3ca0f8dba683a 100644
> --- a/drivers/net/ethernet/google/gve/gve_main.c
> +++ b/drivers/net/ethernet/google/gve/gve_main.c

[ ... ]

> @@ -590,7 +591,80 @@ static void gve_free_notify_blocks(struct gve_priv *priv)

[ ... ]

> +static void gve_queues_mem_remove(struct gve_priv *priv)
> +{
> +	struct gve_tx_alloc_rings_cfg tx_alloc_cfg = {0};
> +	struct gve_rx_alloc_rings_cfg rx_alloc_cfg = {0};
> +
> +	gve_get_curr_alloc_cfgs(priv, &tx_alloc_cfg, &rx_alloc_cfg);
> +	gve_queues_mem_free(priv, &tx_alloc_cfg, &rx_alloc_cfg);
> +	priv->tx = NULL;
> +	priv->rx = NULL;
> +}

[Severity: High]
This is a pre-existing issue. gve_get_stats() checks priv->rx and priv->tx
and then walks the ring arrays with no lock or RCU protection:

gve_get_stats() {
	if (priv->rx) {
		for (ring = 0; ring < priv->rx_cfg.num_queues; ring++) {
			do {
				start = u64_stats_fetch_begin(&priv->rx[ring].statss);
	...
}

dev_get_stats() callers such as /proc/net/dev hold neither rtnl nor the
netdev lock. Here gve_queues_mem_free() kvfree()s the arrays before
priv->tx and priv->rx are cleared, with no grace period.

Can a concurrent /proc/net/dev read dereference freed ring memory when
this runs from gve_reset(), gve_close() or gve_teardown_device()?

[ ... ]

> @@ -1335,15 +1393,16 @@ static void gve_rx_stop_rings(struct gve_priv *priv, int num_rings)

[ ... ]

>  /* The passed-in queue memory is stored into priv and the queues are made live.

[Severity: Low]
This isn't a bug, but the rest of this comment still reads:

 * No memory is allocated. Passed-in memory is freed on errors.

After this patch, the stop_rings path only calls gve_queues_stop().
gve_open() and gve_adjust_config() now call gve_queues_mem_remove()
themselves.

On the reset path, gve_reset() frees the passed-in rings and
gve_recover() -> gve_open() allocates new ones.

Should the comment be updated to match?

[ ... ]

> @@ -1415,16 +1473,14 @@ static int gve_queues_start(struct gve_priv *priv,
>  
>  reset:
>  	if (gve_get_reset_in_progress(priv))
> -		goto stop_and_free_rings;
> -	gve_reset_and_teardown(priv, true);
> -	/* if this fails there is nothing we can do so just ignore the return */
> -	gve_reset_recovery(priv, false);
> -	/* return the original error */
> -	return err;
> -stop_and_free_rings:
> -	gve_tx_stop_rings(priv, gve_num_tx_queues(priv));
> -	gve_rx_stop_rings(priv, priv->rx_cfg.num_queues);
> -	gve_queues_mem_remove(priv);
> +		goto stop_rings;
> +
> +	/* Attempt to reset. If reset is successful, gve_queues_start was
> +	 * successful with the new config.
> +	 */
> +	return gve_reset(priv, false);

[Severity: Medium]
Before this patch, this path returned the original error. Now it returns
the result of gve_reset(), so a successful recovery is reported to the
caller as success. Can this break an AF_XDP zero-copy bind?

On a running DQO RDA interface with XDP loaded:

gve_xsk_pool_enable()
  set_bit(qid, priv->xsk_pools)
  gve_configure_rings_xdp()
    gve_adjust_config()
      gve_queues_start()
        gve_create_rings() fails
        return gve_reset(priv, false)
          gve_free_control_plane_resources()    <- frees xsk_pools
          gve_recover()
            gve_alloc_control_plane_resources() <- new, empty bitmap
            gve_open() -> gve_reg_xdp_info()    <- no XSK pool found

gve_xsk_pool_enable() then sees 0, and xp_assign_dev() marks the socket
zero-copy, even though the queue now uses an ordinary page pool.

Wouldn't the socket then silently receive no traffic?

> +stop_rings:
> +	gve_queues_stop(priv);
>  	return err;
>  }
>  
> @@ -1435,70 +1491,55 @@ static int gve_open(struct net_device *dev)
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
This is a pre-existing issue, and this check fences only gve_open().

After a failed gve_recover() takes the teardown_device path,
priv->xsk_pools, priv->ntfy_blocks and priv->stats_report are NULL, and
the admin queue dma_pool is destroyed. netif_running() usually stays true,
because gve_reset() was called from the service task or ethtool with the
interface up.

netif_device_detach() blocks ethtool and dev_open, but ndo_bpf and
ndo_set_features are still reachable. Could these then oops or use freed
memory?

AF_XDP zero-copy bind:
  gve_xsk_pool_enable()
    set_bit(qid, priv->xsk_pools)   <- NULL bitmap

gve_xsk_pool_disable() does clear_bit() on the same NULL bitmap.

ethtool -K (GRO_HW) or XDP attach:
  gve_set_features() / gve_set_xdp()
    gve_adjust_config()
      gve_close()                    <- succeeds, rings_ok is false
      gve_queues_start()
        gve_tx_start_rings()         <- indexes NULL priv->ntfy_blocks
        gve_register_qpls()
          gve_adminq_execute_cmd()   <- freed admin queue

Would a gve_get_device_resources_ok() check in gve_adjust_config() and in
the XSK pool paths help here?

>  	gve_get_curr_alloc_cfgs(priv, &tx_alloc_cfg, &rx_alloc_cfg);
>  
>  	err = gve_queues_mem_alloc(priv, &tx_alloc_cfg, &rx_alloc_cfg);
>  	if (err)
>  		return err;
>  
> -	/* No need to free on error: ownership of resources is lost after
> -	 * calling gve_queues_start.
> -	 */
>  	err = gve_queues_start(priv, &tx_alloc_cfg, &rx_alloc_cfg);
> -	if (err)
> +	if (err) {
> +		gve_queues_mem_remove(priv);
>  		return err;
> +	}

[Severity: High]
Can this free memory that the device still references, without the
device ever being reset?

When gve_open() is called from gve_recover(priv, true), reset_in_progress
is set. A failure in gve_register_qpls() or gve_create_rings() inside
gve_queues_start() therefore goes from the reset label straight to
stop_rings:

reset:
	if (gve_get_reset_in_progress(priv))
		goto stop_rings;

Neither function rolls back on failure. gve_register_qpls() leaves the
earlier QPLs registered. gve_create_rings() may already have created all
TX queues, whose q_resources the device writes to ("This failure will
trigger a reset - no need to clean up").

gve_queues_mem_remove() here then unmaps and frees the QPL pages,
descriptor rings and q_resources.

gve_recover() then returns err and deliberately keeps the admin queue, so
gve_adminq_free() never resets the device. DEVICE_RINGS_OK was never set,
so a later gve_close() won't destroy those queues either.

That seems to conflict with the guarantee, in both the commit message and
the gve_reset_device() kdoc, that shared memory is freed only after the
device has been reset.

[ ... ]

> -static int gve_queues_stop(struct gve_priv *priv)
> +static int gve_close(struct net_device *dev)
>  {
> +	struct gve_priv *priv = netdev_priv(dev);
>  	int err;
>  
> -	netif_carrier_off(priv->dev);
> +	gve_turndown(priv);
> +
> +	/* Surrender to reset if the queue destroying adminq cmds fail. Reset
> +	 * will not re-enable the interface.
> +	 */
>  	if (gve_get_device_rings_ok(priv)) {
> -		gve_turndown(priv);
> -		gve_drain_page_cache(priv);
> +		gve_clear_device_rings_ok(priv);
>  		err = gve_destroy_rings(priv);
>  		if (err)
> -			goto err;
> +			goto reset;

[ ... ]

> +reset:
> +	err = gve_reset(priv, true);
> +	return err;
>  }

[Severity: High]
This is a pre-existing issue, and the rewritten reset label keeps it.

gve_adjust_config() allocates the new rings with gve_queues_mem_alloc()
before calling gve_close(). On DQO RDA, gve_rx_create_page_pool() stores
a pointer into the notify block array in each new page pool:

    .napi = &priv->ntfy_blocks[ntfy_id].napi,

Suppose gve_destroy_rings() or gve_unregister_qpls() fails here. Then
gve_reset(priv, true) runs gve_free_control_plane_resources() ->
gve_free_notify_blocks(), which kvfree()s priv->ntfy_blocks.
gve_recover() then allocates a new array.

If gve_reset() returns 0, gve_adjust_config() carries on with:

    err = gve_queues_start(priv, tx_alloc_cfg, rx_alloc_cfg);

The pre-allocated rings passed in still have page pools pointing at the
freed ntfy_blocks. Can page_pool_napi_local(), or
page_pool_disable_direct_recycling() via gve_rx_stop_ring_dqo(), then
dereference freed memory?

If recovery fails instead, gve_adjust_config() calls
gve_queues_mem_free() on the same rings, and page_pool_destroy() sees the
same stale napi pointer.

This is reachable from gve_set_features(), gve_adjust_queues() or
gve_set_xdp() when an admin queue destroy command fails.

[ ... ]

> @@ -2545,62 +2557,79 @@ static int gve_reset_recovery(struct gve_priv *priv, bool was_up)

[ ... ]

> +	if (setup_queues) {
> +		/* On failure, hold on to the control plane to give a
> +		 * chance for the queues to be brought up later.
> +		 */
>  		err = gve_open(priv->dev);
> -		if (err)
> +		if (err) {
> +			dev_err(&priv->pdev->dev,
> +				"Failed to start queues: err=%d, !!! DISABLING ALL QUEUES !!!\n",
> +				err);
>  			return err;
> +		}
>  	}
> +
> +	/* undo any detach from an earlier failure */
> +	netif_device_attach(priv->dev);
> +
>  	return 0;

[Severity: Medium]
If setup_queues is true and gve_open() fails, this returns before
netif_device_attach(). The comment says the control plane is kept so the
queues can be brought up later. But if an earlier gve_recover() failure
had detached the netdev, won't it stay detached?

For example:

gve_reset() -> gve_recover() fails -> netif_device_detach()
gve_suspend()
gve_resume()
  gve_recover(priv, up_before_suspend = true)
    gve_setup_device() succeeds
    gve_open() fails
    return err            <- netif_device_attach() skipped

device_resources_ok is set at that point. But __dev_open() and the
ethtool ops return -ENODEV, so the queues can't be brought up without
rebinding the driver.

>  
> -err_free_adminq:
> -	gve_adminq_free(priv);
> -err:
> -	dev_err(&priv->pdev->dev, "Reset failed! !!! DISABLING ALL QUEUES !!!\n");
> -	gve_turndown(priv);
> +teardown_device:
> +	dev_err(&priv->pdev->dev, "Recover failed: err=%d, detaching device\n",
> +		err);
> +	netif_device_detach(priv->dev);
> +	gve_teardown_device(priv);
>  	return err;
>  }

[Severity: Low]
When gve_recover() fails here, the netdev is detached and
gve_teardown_device() frees MSI-X, the management IRQ and the admin queue.

With the device not present, the ethtool ioctl and netlink paths return
-ENODEV, so gve_user_reset() can't be reached. __dev_open() refuses the
device as well. With the management IRQ gone, nothing can queue
service_task for a device-requested reset either.

Before this patch, a failed gve_reset_recovery() only freed the admin
queue and turned the queues down, so a later ethtool --reset could retry.

Is it intended that one transient failure in gve_adminq_init(),
gve_adminq_verify_driver_compatibility() or gve_setup_device() now leaves
the NIC unusable until the driver is rebound or a suspend/resume cycle
runs? The v9 changelog mentions this, but the commit message doesn't.

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
>  	}

[Severity: Low]
gve_reset() now always takes the graceful path. With the interface up, it
sends the destroy-queue and unregister-QPL commands first. It then sends
the flow-rule reset, stats detach and deconfigure commands in
gve_teardown_control_plane_resources(). All of this happens before
gve_adminq_free() actually resets the device.

That now also covers resets requested through the service task: device
status RESET_MASK, TX timeout and RX errors. Before this patch,
gve_handle_reset() called gve_reset(priv, false), which released the
admin queue first and skipped every admin queue command.

On a device that has stopped processing the admin queue, won't the first
batch command stall for about two seconds while rtnl_lock and the netdev
lock are held?

gve_handle_reset()
  gve_reset(priv, false)
    gve_destroy_rings()
      gve_adminq_destroy_tx_queues()
        gve_adminq_kick_and_wait()   <- times out

Later commands fail fast through the tail != head check in
gve_adminq_execute_cmd(), so the stall is limited to about one timeout.

Was dropping the reset-hardware-first ordering for device-requested
resets intended? The commit message doesn't mention it.

>  
> -	/* Set it all back up */
> -	err = gve_reset_recovery(priv, was_up);
> +	disable_work(&priv->service_task);

[Severity: Medium]
This is a pre-existing issue. disable_work() doesn't wait for a service
task that is already running.

gve_service_task() -> gve_handle_link_status() checks
gve_get_napi_enabled() and netif_carrier_ok() without rtnl or the netdev
lock, and may call netif_carrier_on().

If that runs at the same time as gve_turndown() in a gve_reset() triggered
by ethtool or a flow rule, can the carrier be turned back on while the
queues are disabled mid-reset? If the reset takes longer than
watchdog_timeo, this could also cause a spurious tx_timeout.

> +	gve_reset_device(priv);
> +	gve_queues_stop(priv);
> +	gve_queues_mem_remove(priv);
> +	gve_free_control_plane_resources(priv);

[ ... ]

> @@ -2991,17 +3022,16 @@ static void gve_shutdown(struct pci_dev *pdev)
>  	struct gve_priv *priv = netdev_priv(netdev);
>  	bool was_up = netif_running(priv->dev);
>  
> -	netif_device_detach(netdev);
> +	disable_work_sync(&priv->service_task);
>  
>  	rtnl_lock();
>  	netdev_lock(netdev);
> -	if (was_up && gve_close(priv->dev)) {
> -		/* If the dev was up, attempt to close, if close fails, reset */
> -		gve_reset_and_teardown(priv, was_up);
> -	} else {
> -		/* If the dev wasn't up or close worked, finish tearing down */
> -		gve_teardown_priv_resources(priv);
> -	}
> +	if (was_up)
> +		gve_close(priv->dev);
> +
> +	/* detach here because gve_close() might attach in recovery */
> +	netif_device_detach(netdev);
> +	gve_teardown_device(priv);

[Severity: Medium]
This is a pre-existing issue. was_up is sampled before
disable_work_sync(), rtnl_lock() and netdev_lock().

If the interface is opened in that window, gve_close() is skipped. Then
gve_teardown_device() frees ntfy_blocks and the rings while NAPI is still
enabled. Could that lead to a use-after-free from NAPI?

The added disable_work_sync() makes this window slightly wider.
gve_suspend() follows the same pattern.

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260930190428.1130007-1-hramamurthy%40google.com
