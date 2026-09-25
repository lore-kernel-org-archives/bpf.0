Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3759D4E06D2;
	Fri, 25 Sep 2026 18:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790362566; cv=none; b=UQC8LPQmNJaFoGR99i6ZSMvuucBCJf7B+scEFbaqPxm2f8EINSFb0JG2B7r+Sie4xnmKDFxsjIBXua1sLiFNrk6zgxGLHQgx9ke2+41F1WivOuaQSyNuGp1z4MOStZqvtmDthGHmU91dsY7m3pUQY+1OWQmOEm0M9XWDzv2+YkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790362566; c=relaxed/simple;
	bh=gMJwU5epKZD7lpitwGwyBFY8Jl6Py6bdjB4TJ0RDPv8=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Tgnjji3ZfL4yWlm+x8/kovo4pjpIoSv2alzMDSU9FdeaBgXvKFoPmrAvrKAm8dVSeYK8o4wHd71mwH6bKIsrIePJQoDQOlQU40xo1388Qws8n5JxFOWei/LSaHGUwnmaIODZXbdDpgeMK1K4Rsgy0PhyLrRzH4GiFubsqOOdyoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K4qi0rMm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K4qi0rMm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B0411F000FF;
	Fri, 25 Sep 2026 18:56:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790362563;
	bh=LR2PEn8hF7FSafePyXKD5qOVnYo0qZa5ZPvxDJ7Y7Tg=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=K4qi0rMmyML/IgZtIq7x0oHvOMsVV9G4yGpAgLM7HxOsGrjCWJxr6cziq9DB1xfvL
	 bo93M98ENP5US2S6Rqd3xPSnXf9nwG7vv3ATM5wP7baCxKMKS7bp/GfiHKgkJTkjgx
	 MUEIKvLTvxfmG3qY/OeTeE46YNRw/soYCj5UlAUFQIMYYY84TptmUxMY4NHD/Or1jr
	 lHli/IzDsjZc2r00fvW9Ud8G6SwlbKkykYfE/Q4roV6P0JxT2tu2rXKFR57jSzbkpx
	 7NSyTpuoOB/hoseT2d0JCVJrnGwhdypf4YslNtZii0UWwBDA/2j40HPImAlQi8l+EF
	 QdEs0JE52PsnQ==
Subject: Re: [PATCH net-next v8 06/12] gve: simplify reset logic
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
Date: Fri, 25 Sep 2026 18:56:02 +0000
Message-ID: <179036256202.2160803.12978678207911420221@kernel.org>
In-Reply-To: <20260924185316.2831077-7-hramamurthy@google.com>
References: <20260924185316.2831077-7-hramamurthy@google.com>
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
issue(s) to consider.

Critical: 0 · High: 2 (1) · Medium: 2 (2) · Low: 3 (1)

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] After a failed recovery, an unprivileged user can crash the
  kernel with an ethtool query.
- [High] When gve_recover() fails during a reset while the interface is
  up (service-task reset, ethtool reset, flow-rule timeout, or…
- [Medium] gve_teardown_control_plane_resources() (gve_main.c) now calls
  gve_teardown_clock().
- [Medium] The commit message does not mention several user-visible
  changes to error handling, and one of its design statements is not…
- [Low] This patch removed gve_queues_mem_remove() from
  gve_queues_start()'s error path.
- [Low] The commit fixes a real unbounded recursive reset but has no
  Fixes: tag.
- [Low] Item 2 of the commit message describes the old bug this way:
  gve_close() during gve_shutdown triggers a hardware reset and then…

Pre-existing issues:
- [High] This bug predates the patch, which rewrites the same path
  without fixing it.
- [Medium] This race predates the patch.
- [Medium] The moved and new reset triggers in gve_add_flow_rule(),
  gve_del_flow_rule() and gve_set_features() fire only on -ETIME, which…
- [Low] gve_handle_reset() re-checks do_reset under rtnl and the netdev
  lock, but that does not cover a service task that read device_status…

--

gve: simplify reset logic

This reworks the gve reset path to remove recursive resets and resets
during teardown. It separates control plane allocation from device setup,
adds gve_reset_device() and gve_teardown_device(), and replaces
gve_reset_recovery() with gve_recover(). Flow rule timeout handling moves
from the adminq layer into the ethtool callers.

>     1) Removing recursive resets. Recursive resets have two major issues.
>        First, there is the potential for stack overflows if resets are
>        invoked too many times in a row. Second, long recursive calls mean
>        that GVE never gives up the RTNL lock, or at the very least holds it
>        for too long. If a reset must occur anywhere during the
>        reset/recovery path, it should be scheduled as a separate task.

[Severity: Medium]
Is the last sentence still accurate? gve_reset() is still called inline,
under rtnl, from the reset label in gve_queues_start(), the reset label in
gve_close(), gve_add_flow_rule() and gve_del_flow_rule().

The commit message also doesn't mention several user-visible changes.

gve_queues_start() now ends with "return gve_reset(priv, false)". If the
inline reset recovers, ndo_open and gve_adjust_config() (ethtool -L/-G,
XDP attach, XSK) return 0 after a queue creation failure.

Every failure in gve_recover() now goes to teardown_device and calls
gve_teardown_device(). That includes gve_queues_mem_alloc() and
gve_queues_start() failures after the control plane is already up.
gve_teardown_device() frees the admin queue, the notify block IRQs, the
management IRQ and MSI-X. The old gve_reset_recovery() kept the control
plane configured when only gve_open() failed.

gve_open() now returns -ENODEV until the user runs an explicit ethtool
reset.

After a failed recovery nothing schedules a retry. With the management IRQ
freed, the device can no longer request one.

Could the commit message describe these changes? Also, is it intended that
the device stays unusable until someone resets it manually?

>     2) Removing resets during the teardown portion of reset. This is partly
>        covered by removing recursive resets, but the primary goal in this
>        case is to allow the driver to complete teardown in a more direct
>        manner. Before this patch, gve_close() when called as part of
>        gve_shutdown, could end up triggering a hardware reset, then attempt
>        to close again. In such a case, destroying hardware queues would
>        inevitably fail, causing a loop. gve_close() is no longer called
>        directly in gve_reset() breaking any possibility of this loop.

[Severity: Low]
Can the loop described here actually happen? In the old code,
gve_reset_and_teardown() reset the hardware before the second gve_close():

gve_reset_and_teardown()
  gve_trigger_reset()
    gve_adminq_release()  <- clears DEVICE_RINGS_OK and DEVICE_RESOURCES_OK
  gve_close()
    gve_queues_stop()     <- only destroys rings if rings_ok is set

The second close therefore skipped queue destruction.

The loop that could happen went through the flow rule -ETIME reset inside
gve_teardown_device_resources() (see the comment on
gve_adminq_configure_flow_rule() below). Could this paragraph describe
that path instead?

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
Before this patch, the removed code could recurse without bound while
holding rtnl:

gve_adminq_configure_flow_rule()      <- returns -ETIME
  gve_reset(priv, true)
    gve_teardown_priv_resources()
      gve_teardown_device_resources()
        gve_flow_rules_reset()
          gve_adminq_configure_flow_rule()  <- -ETIME again
            gve_reset(priv, true)
              ...

The old gve_reset() had no reset_in_progress guard. Since this patch fixes
that, should it carry a Fixes: tag?

Fixes: 57718b60df9b ("gve: Add flow steering adminq commands")

[ ... ]

> diff --git a/drivers/net/ethernet/google/gve/gve_flow_rule.c b/drivers/net/ethernet/google/gve/gve_flow_rule.c
> index 2c80cda28ef30..fae552f4ad6fb 100644
> --- a/drivers/net/ethernet/google/gve/gve_flow_rule.c
> +++ b/drivers/net/ethernet/google/gve/gve_flow_rule.c
> @@ -278,6 +278,11 @@ int gve_add_flow_rule(struct gve_priv *priv, struct ethtool_rxnfc *cmd)
>  		goto out;
>  
>  	err = gve_adminq_add_flow_rule(priv, rule, fsp->location);
> +	if (err == -ETIME) {

[Severity: Medium]
This isn't a bug introduced by this patch, but these reset triggers fire
only on -ETIME. That applies here, in gve_del_flow_rule(), and in the new
gve_schedule_reset() call in gve_set_features(). The driver returns -ETIME
only when the device itself reports
GVE_ADMINQ_COMMAND_ERROR_DEADLINE_EXCEEDED.

A real AQ hang on the host side returns a different error from
gve_adminq_kick_and_wait():

	if (!gve_adminq_wait_for_cmd(priv, head)) {
		dev_err(&priv->pdev->dev, "AQ commands timed out, need to reset AQ\n");
		priv->adminq_timeouts++;
		return -ENOTRECOVERABLE;

Should -ENOTRECOVERABLE also trigger a reset in these paths?

> +		dev_err(&priv->pdev->dev,
> +			"Timeout to add flow rule, trigger reset.");
> +		gve_reset(priv, false);
> +	}

[ ... ]

> diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/ethernet/google/gve/gve_main.c
> index 2fe280cf7e680..07135c52a7078 100644
> --- a/drivers/net/ethernet/google/gve/gve_main.c
> +++ b/drivers/net/ethernet/google/gve/gve_main.c

[ ... ]

> +static void gve_teardown_control_plane_resources(struct gve_priv *priv)
>  {
>  	int err;
>  
>  	/* Tell device its resources are being freed */
>  	if (gve_get_device_resources_ok(priv)) {

[ ... ]

> +		gve_teardown_clock(priv);
>  		err = gve_adminq_deconfigure_device_resources(priv);

[Severity: Medium]
Can the device DMA into a freed nic_ts_report buffer here?

gve_teardown_clock() calls gve_ptp_release() and then dma_free_coherent()
on priv->nic_ts_report. The device writes that buffer when it services
GVE_ADMINQ_REPORT_NIC_TIMESTAMP. The free now happens before
gve_adminq_deconfigure_device_resources(). It also happens before
gve_reset_device()->gve_adminq_free(), which does the hardware reset.

The kdoc on gve_reset_device() says the teardown commands can fail and
that the hardware reset is the only guarantee the device has stopped
accessing shared memory. The commit message makes a similar claim.

Here is the sequence I'm worried about. An earlier report timestamp
command times out on the host side. gve_adminq_kick_and_wait() then
returns -ENOTRECOVERABLE without cancelling the command in hardware. If
the teardown commands also time out, the device may still complete the
stale command after dma_free_coherent() has run.

The old service task reset path called gve_trigger_reset() before
gve_teardown_clock(). The teardown_clock label in
gve_setup_control_plane_resources() has the same ordering.

Would it be safer to free nic_ts_report in
gve_free_control_plane_resources(), after gve_adminq_free()?

[ ... ]

> @@ -1415,16 +1472,14 @@ static int gve_queues_start(struct gve_priv *priv,
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
> +stop_rings:
> +	gve_queues_stop(priv);
>  	return err;
>  }

[Severity: Low]
The header comment above gve_queues_start() still says:

 * No memory is allocated. Passed-in memory is freed on errors.

The stop_rings path now only calls gve_queues_stop(), and callers free the
queue memory themselves. Should the comment be updated to match?

> @@ -1435,70 +1490,55 @@ static int gve_open(struct net_device *dev)

[ ... ]

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
>  		err = gve_unregister_qpls(priv);
>  		if (err)
> -			goto err;
> -		gve_clear_device_rings_ok(priv);
> +			goto reset;
>  	}

[ ... ]

> +reset:
> +	err = gve_reset(priv, true);
> +	return err;
>  }

[Severity: High]
This is a pre-existing issue, but this patch rewrites the same path. Can
the new rings end up with a stale napi pointer when gve_close() falls
into this reset from gve_adjust_config()?

gve_adjust_config() allocates the new rings before it closes. On DQO-RDA,
gve_rx_create_page_pool() stores .napi = &priv->ntfy_blocks[ntfy_id].napi
in each new page pool:

gve_adjust_config()
  gve_queues_mem_alloc()       <- page pools point into old ntfy_blocks
  gve_close()
    gve_reset(priv, true)
      gve_free_control_plane_resources()
        gve_free_notify_blocks()   <- kvfree(priv->ntfy_blocks)
      gve_recover()                <- allocates a new ntfy_blocks
  gve_queues_start()           <- pool->p.napi is stale

If recovery succeeds, gve_close() returns 0. The rings are then started,
and the RX recycle path reads napi->list_owner from the freed array in
page_pool_napi_local().

If recovery fails, gve_adjust_config() calls gve_queues_mem_free() on the
unstarted rings. page_pool_destroy()->page_pool_disable_direct_recycling()
->napi_assert_will_not_race() then reads the stale napi.

Should gve_adjust_config() drop and re-allocate its pre-allocated rings
when gve_close() had to reset?

> @@ -1833,9 +1873,7 @@ int gve_adjust_config(struct gve_priv *priv,
>  	if (err) {
>  		netif_err(priv, drv, priv->dev,
>  			  "Adjust config failed to start new queues, !!! DISABLING ALL QUEUES !!!\n");
> -		/* No need to free on error: ownership of resources is lost after
> -		 * calling gve_queues_start.
> -		 */
> +		gve_queues_mem_remove(priv);
>  		gve_turndown(priv);
>  		return err;
>  	}

[Severity: High]
Can gve_adjust_config() run after a failed recovery and oops on a NULL
priv->ntfy_blocks?

When gve_recover() fails during a reset with the interface up,
gve_teardown_device() sets priv->ntfy_blocks, priv->xsk_pools, priv->tx
and priv->rx to NULL. netif_running() stays true.

Only gve_open() checks gve_get_device_resources_ok(). gve_adjust_config()
doesn't, and it is reached from ethtool -L/-G, the HW-GRO toggle, XDP
attach and XSK enable. gve_close() succeeds because rings_ok is clear.
The start path then does this:

gve_adjust_config()
  gve_queues_start()
    gve_tx_start_rings()
      gve_tx_add_to_block()
        block = &priv->ntfy_blocks[ntfy_idx];   <- ntfy_blocks is NULL
        block->tx = tx;

gve_xsk_pool_disable() looks similar. It does
clear_bit(qid, priv->xsk_pools) and dereferences
priv->ntfy_blocks[priv->rx[qid].ntfy_id] with only a netif_running()
check.

Should these paths also bail out when device resources are not set up?

[ ... ]

> @@ -2235,7 +2276,8 @@ static void gve_handle_reset(struct gve_priv *priv)
>  	if (gve_get_do_reset(priv)) {
>  		rtnl_lock();
>  		netdev_lock(priv->dev);
> -		gve_reset(priv, false);
> +		if (gve_get_do_reset(priv))
> +			gve_reset(priv, false);

[Severity: Low]
This isn't a bug introduced by this patch, but the re-check can't tell a
stale request from a new one.

gve_handle_status() calls gve_set_do_reset() without any lock, based on a
device_status value it read earlier. Suppose a concurrent gve_reset() from
ethtool or a flow rule timeout clears do_reset after that read. The
service task can still set the flag afterwards. Once the first reset
finishes, the service task sees do_reset set here and runs a second full
reset.

Is that redundant reset expected?

>  		netdev_unlock(priv->dev);
>  		rtnl_unlock();
>  	}

[ ... ]

> +	if (setup_queues) {
> +		struct gve_tx_alloc_rings_cfg tx_alloc_cfg = {0};
> +		struct gve_rx_alloc_rings_cfg rx_alloc_cfg = {0};
> +
> +		gve_get_curr_alloc_cfgs(priv, &tx_alloc_cfg, &rx_alloc_cfg);
> +
> +		err = gve_queues_mem_alloc(priv, &tx_alloc_cfg, &rx_alloc_cfg);
>  		if (err)
> -			return err;
> +			goto teardown_device;
> +
> +		err = gve_queues_start(priv, &tx_alloc_cfg, &rx_alloc_cfg);
> +		if (err)
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
Can an unprivileged user oops the kernel with ethtool -x after this path
runs?

A queue allocation failure, such as -ENOMEM from gve_queues_mem_alloc(),
now frees the whole control plane:

gve_teardown_device()
  gve_free_control_plane_resources()
    gve_free_rss_config_cache()   <- hash_key/hash_lut freed, rss_config zeroed

The netdev stays registered, and priv->rss_key_size, priv->rss_lut_size
and priv->cache_rss_config stay set. ETHTOOL_GRSSH and ETHTOOL_GRXFHINDIR
don't need CAP_NET_ADMIN:

__dev_ethtool()
  gve_get_rxfh()        <- only checks rss_key_size/rss_lut_size
    gve_get_rss_config_cache()
      memcpy(rxfh->key, rss_config->hash_key, priv->rss_key_size);  <- NULL

Early failures such as adminq init could already leave the caches NULL
before this patch. With this patch, queue-level recovery failures also
reach this state.

Should gve_get_rxfh() check that the RSS cache exists?

[ ... ]

> -	/* Set it all back up */
> -	err = gve_reset_recovery(priv, was_up);
> +	disable_work(&priv->service_task);
> +	gve_reset_device(priv);

[Severity: Medium]
This is a pre-existing issue, but disable_work() does not wait for a
service task that is already running.

gve_service_task()->gve_handle_link_status() takes neither rtnl nor the
netdev lock. It uses the napi enabled bit as a gate before
netif_carrier_on():

	if (!gve_get_napi_enabled(priv))
		return;

	if (link_status == netif_carrier_ok(priv->dev))
		return;

	if (link_status) {
		...
		netif_carrier_on(priv->dev);

A service task that has already passed the gve_get_napi_enabled() check
can turn the carrier back on after gve_turndown() above has turned it
off. The carrier then stays up while the device is torn down.

How is the link state update meant to be serialized against
gve_turndown() here?

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260924185316.2831077-1-hramamurthy%40google.com
