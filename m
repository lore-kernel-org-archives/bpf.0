Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAC7114A8B;
	Mon,  7 Sep 2026 00:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788739446; cv=none; b=lP99z3WtGmwef7NVGy+jPYJ6n3ZAxG+bkGIXVuCwNSVaAUHC3gS5RdBPKuTwCLPfdEMN7FaSORg8a0UUFhK+nJmUIC7DJcKphRP38wVu6oNvsASlxDXYiGN8eCCqy9J32w+7e9qWM5VNQrD1m96PGuSQyfzvqIPe6MEwjEPmmH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788739446; c=relaxed/simple;
	bh=M7HjaAhMt4jz2uFUbMFIA2zbUpYOJ94VdfJPw0Easgw=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nk9qfKPkbpfwFMoaI6ogfCjG8zrqz3SFndS1PnSNFWSfc87JSTdjpkyl8Q0pFv6iRSiyAd0Ey9Nr4ytw7voz90+n7H0NOmzuYMfoGTRz28uC3Tm0s5bySjbXtA4J+8zIe/eyNFGsJvlZPk6TqsQyymIw45OQ5FrG5a5pAd6WbR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PXlgEFPc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PXlgEFPc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 333B91F00A3D;
	Mon,  7 Sep 2026 00:03:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788739440;
	bh=rT7AEJfUzOnTf/jz9odfyQKeXNlW5LPhIjwGLBWSA0A=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=PXlgEFPcIm20uqyqKGAP2AYxrfRpn0kjoPYWNO+h8xJhO2LxXAKOCL8E/+AL0oxMk
	 QnDUEpnB7lcE6AOHIG7YJ62Gm1ubJ07OjtJxM32mt/wXlHhvsNXjLV+QgSFIRU296M
	 j1gSvrr/b8jJl+jg00IVYpBtg2GPX2I9VsGQwvfqVzuFHP6A1na54FrSWqXFDKHQxF
	 tK4mVVjnfFsQJyyxdxrncbtzwp2gYW9lwa831U/MKAZQmcXQV1egWRlWyF0HrzjI7o
	 rrjoMWIjzeEyAAm3libQSAPGCG9Zxb6GE9gczFUXvjuQQXy2IqUqGRg5CKrDOhVwIF
	 xfc7T0JHQN0CA==
Subject: Re: [PATCH net-next v5 06/12] gve: simplify reset logic
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
Date: Mon, 07 Sep 2026 00:03:58 +0000
Message-ID: <178873943876.219967.7325362894489420354@kernel.org>
In-Reply-To: <20260903215606.31633-7-hramamurthy@google.com>
References: <20260903215606.31633-7-hramamurthy@google.com>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider:

Critical: 0 · High: 0 (1) · Medium: 0 · Low: 2

- [Low] The patch silently fixes a real pre-existing adminq DMA/dma_pool
  leak without a Fixes: tag and without disclosing it in the commit…
- [Low] Commit message goal 2 misdescribes the pre-patch defect and
  overstates the change.

Pre-existing issues:
- [High] The stats-report DMA buffer can be freed while
  priv->stats_report_task is queued or running, giving a NULL-pointer…

--

gve: simplify reset logic

This reworks the gve reset path: recursive resets and resets issued from
the teardown path are removed, control plane resource allocation is split
from device setup, and resources shared with the device are only freed
after gve_adminq_free() has reset the hardware.  Flow rule timeout
handling moves from the adminq layer into the ethtool add/delete entry
points.

A few questions on the changelog and on the stats report worker below.

[Severity: Low]
The changelog says:

    2) Removing resets during teardown. ... As it stands, if
       `deconfigure_device_resources` fails, for example, GVE will preempt
       its reset with another reset without actually invoking a hardware
       reset, which could actually help with recovery.

Is the "without actually invoking a hardware reset" part accurate?

gve_trigger_reset() was just a call to gve_adminq_release(), and that
function does poke the reset registers and wait for the device:

	iowrite32be(GVE_DRIVER_STATUS_RESET_MASK, &priv->reg_bar0->driver_status);
	while (!(ioread32be(&priv->reg_bar0->device_status)
			& GVE_DEVICE_STATUS_DEVICE_IS_RESET)) {

(older revisions zero adminq_pfn and poll it instead).  So a hardware
reset did happen on that path; what was missing afterwards was the
adminq/dma_pool teardown, see the next comment.

Also, is "Removing resets during teardown" fully true after this change?
The new gve_close() still has a reset label calling gve_reset(priv, true)
when gve_destroy_rings() or gve_unregister_qpls() fails, and both
gve_shutdown() and gve_suspend() call gve_close(), so queue teardown can
still perform a full hardware reset plus recovery before the caller tears
the device down again.  Could the changelog mention that remaining path?

> diff --git a/drivers/net/ethernet/google/gve/gve_adminq.c b/drivers/net/ethernet/google/gve/gve_adminq.c
> index a62cb7a921d07..901673d2e2648 100644
> --- a/drivers/net/ethernet/google/gve/gve_adminq.c
> +++ b/drivers/net/ethernet/google/gve/gve_adminq.c

[ ... ]

> @@ -394,7 +394,6 @@ void gve_adminq_release(struct gve_priv *priv)
>  	}
>  	gve_clear_device_rings_ok(priv);
>  	gve_clear_device_resources_ok(priv);
> -	gve_clear_admin_queue_ok(priv);
>  }
>  
>  void gve_adminq_free(struct gve_priv *priv)

[Severity: Low]
Does this one-line removal fix a pre-existing leak of the adminq buffer
and its dma_pool?

Before this patch gve_adminq_release() cleared admin_queue_ok, and
gve_adminq_free() starts with an early return keyed off that same bit:

	void gve_adminq_free(struct gve_priv *priv)
	{
		if (!gve_get_admin_queue_ok(priv))
			return;
		gve_adminq_release(priv);
		dma_pool_free(priv->adminq_pool, priv->adminq, priv->adminq_bus_addr);
		dma_pool_destroy(priv->adminq_pool);

so every caller of gve_trigger_reset() skipped the dma_pool_free() and
dma_pool_destroy() that followed:

gve_reset_and_teardown()
  gve_trigger_reset()             /* gve_adminq_release(), clears admin_queue_ok */
  gve_teardown_priv_resources()
    gve_adminq_free()             /* early return, pool and buffer leaked */

The same happened for the three error branches in
gve_teardown_device_resources().  Would it make sense to split this into
its own patch with a Fixes: tag, or at least mention the leak in the
changelog?  As written the fix is buried in a ~350 line refactor and
stable tooling has nothing to pick up.

[ ... ]

> diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/ethernet/google/gve/gve_main.c
> index 16ce55c6d74f6..acd09e9f416c1 100644
> --- a/drivers/net/ethernet/google/gve/gve_main.c
> +++ b/drivers/net/ethernet/google/gve/gve_main.c

[ ... ]

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

[Severity: High]
This isn't a bug introduced by this patch, since before it nothing
cancelled stats_report_task at all, but the new cancel_work_sync() only
runs on the interface-up path.  Should it live in gve_free_stats_report()
or gve_teardown_device() instead so it covers the down-interface cases?

gve_free_stats_report() only synchronizes the timer before freeing the
coherent buffer:

	timer_delete_sync(&priv->stats_report_timer);
	dma_free_coherent(&priv->pdev->dev, priv->stats_report_len,
			  priv->stats_report, priv->stats_report_bus);
	priv->stats_report = NULL;

An already queued stats_report_task survives that.  The timer can be
armed from ethtool with the interface down, there is no netif_running()
or resource-state check in gve_set_priv_flags():

	if (flags & BIT(0)) {
		mod_timer(&priv->stats_report_timer,
			  round_jiffies(jiffies +
				msecs_to_jiffies(priv->stats_report_timer_period)));
	}

and gve_stats_report_timer() -> gve_stats_report_schedule() queues
priv->stats_report_task, whose gve_handle_report_stats() writes into the
buffer:

	be64_add_cpu(&priv->stats_report->written_count, 1);

Can that write land on a NULL priv->stats_report, or into memory
dma_free_coherent() has already released?  The paths that skip
gve_queues_stop() look like:

gve_reset() with was_up == false   /* ethtool --reset all on a down iface */
  disable_work(&priv->service_task)  /* stats_report_task not disabled */
  gve_teardown_device()
    gve_free_control_plane_resources()
      gve_free_stats_report()

> @@ -2514,30 +2542,7 @@ static int gve_init_priv(struct gve_priv *priv)
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
> @@ -2545,62 +2550,66 @@ static int gve_reset_recovery(struct gve_priv *priv, bool was_up)

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
>  
> -	/* Set it all back up */
> -	err = gve_reset_recovery(priv, was_up);
> +	disable_work(&priv->service_task);
> +	gve_teardown_device(priv);
> +	gve_queues_mem_remove(priv);

Following the comment above: with was_up == false, gve_queues_stop() is
not called here, so the new cancel_work_sync(&priv->stats_report_task) is
skipped while gve_teardown_device() frees the stats report buffer.  Only
service_task is covered by disable_work() here.

[ ... ]

> @@ -2981,7 +2991,8 @@ static void gve_remove(struct pci_dev *pdev)
>  	void __iomem *reg_bar = priv->reg_bar0;
>  
>  	unregister_netdev(netdev);
> -	gve_teardown_priv_resources(priv);
> +	disable_work_sync(&priv->service_task);
> +	gve_teardown_device(priv);
>  	destroy_workqueue(priv->gve_wq);

Same question for removal of a down interface: stats_report_task is not
synchronized before gve_teardown_device() frees priv->stats_report.

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260903215606.31633-1-hramamurthy%40google.com
