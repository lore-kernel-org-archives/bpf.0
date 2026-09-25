Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 522CF4DE73C;
	Fri, 25 Sep 2026 18:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790362563; cv=none; b=ObWHBpN4mp8Jy0u5P9BIvDt/XDueVPspJuuPBOYhPunuLzGxl/jaXrk/8vpWYS/SWMpweXbLZfDCApuUOwyhYagQKMzkN1eYQCAgkXQVRFIrfvd6EC43HvcPHG3XckDfwdDM2jzd3hLn6OvqLTYj7NEV2vnrvegZ4v1LgwgTdRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790362563; c=relaxed/simple;
	bh=KYbYyy/P/SSc49e+mHSVZOBrwgnfinK5f7UwqvB/Mk0=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iBPtZg+29rmd2LYQL0KtDgD18Y0Y1gThFNIxfTj/qyTgwjh7K1ddAIvraWCBoaWte9Ztf2AcO1xLcTnyvjRkJTpWHegGjV83UWmgtY47AXOuMaaYwJHE6dif6ChD4fvDBmI/BQD66bfdpZYMgEB2+wFrqS1iA5Qbz8RfBgWqxRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UFcXywDv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UFcXywDv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6C7E1F00893;
	Fri, 25 Sep 2026 18:56:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790362561;
	bh=D5t1nNTnRAh6E8zgjsq0UjKW40/ILQljh97iV4gr1JQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=UFcXywDvWw+gCLeO3p2odx9J+3InPf8kUerQ2OZ0LN4/wzLGoiiKv3IQHaw2bFHq6
	 JXjqVGRtJ8LHzvpQQjBB3GRxh4Cx/FRFM70XG5U8kWwQdhCp9mKOJ9MfwlHI5Ce7d5
	 oV8uY0fZH1Pf1xKhV1yetEci+vdCu/+YBBtQhczY0DW1KnU7udb9VcqSq6QuUS28EX
	 gRHJS8cS7ubUhgH1yA3spvaXaTWlw0jKgzAGKek40zW8jjTPMCopXmvS63SBOk8D/8
	 EG2zdt8cXCSW6LvJk5E80MJOVPc/ui6XlrAMIeoeppBGhg6jCcmr2jFEetBcTm6df2
	 zNDEyOiEfTELQ==
Subject:
 Re: [PATCH net-next v8 05/12] gve: refactor gve_init_priv for reset path
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
Date: Fri, 25 Sep 2026 18:56:00 +0000
Message-ID: <179036256026.2160803.15321844410832511125@kernel.org>
In-Reply-To: <20260924185316.2831077-6-hramamurthy@google.com>
References: <20260924185316.2831077-6-hramamurthy@google.com>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] The commit message says "These changes are only code movement, no
  functional change".
- [Low] gve_write_version() is renamed to gve_adminq_write_version(),
  putting it in the gve_adminq_* namespace.

Pre-existing issues:
- [Medium] Existing AdminQ leak, fixed later in this series by "gve:
  simplify reset logic".
- [Medium] Existing teardown ordering issue, fixed later in this series.

--

gve: refactor gve_init_priv for reset path

This commit moves AdminQ setup and device property negotiation out of
gve_init_priv(). As a result, gve_init_priv() and
gve_adminq_get_device_properties() run only once, from gve_probe(). A new
gve_adminq_init() writes the driver version and allocates the AdminQ, a
new gve_setup_device() handles per-reset device setup, and
gve_reset_recovery() calls these helpers directly.

> These changes are only code movement, no functional change.

[Severity: Low]
Is this accurate? The patch seems to change behaviour in a few places.

The driver version is now written from gve_adminq_init():

int gve_adminq_init(struct gve_priv *priv)
{
	...
	gve_adminq_write_version(&reg_bar->driver_version);
	return gve_adminq_alloc(priv);
}

gve_reset_recovery() also calls gve_adminq_init(), so the version string
is now written to the device on every reset and resume. Before this
patch, gve_write_version() was called only once, from gve_probe().

The order in gve_probe() also changes. The version write now comes after
the max_tx_queues/max_rx_queues register reads and after
alloc_etherdev_mqs(). AdminQ allocation, driver compatibility
verification and describe device now run before ctrl_ops is set, before
map_db_bar(), before the workqueue is allocated, and before
gve_set_probe_in_progress().

In gve_reset_recovery(), a gve_open() failure is now handled as:

	if (was_up) {
		err = gve_open(priv->dev);
		if (err)
			return err;
	}

It no longer does goto err, so the "Reset failed! !!! DISABLING ALL
QUEUES !!!" message and the gve_turndown() call are skipped.

Callers such as gve_handle_reset() ignore the return value of
gve_reset(). At this commit, then, the reset code does not log a reset
that fails during queue bring-up.

The only related note is the v3 changelog below the --- line, and that
text is dropped when the patch is applied.

Later in the series, "gve: simplify reset logic" replaces
gve_reset_recovery() with gve_recover(), which logs "Recover failed!"
when queue setup fails, so the missing log is fixed there. The version
rewrite and the probe reordering are still present at the end of the
series.

Could the commit message describe these changes rather than saying there
is no functional change?

> diff --git a/drivers/net/ethernet/google/gve/gve.h b/drivers/net/ethernet/google/gve/gve.h
> index 1bc5e32b6618e..48cc8a6be186c 100644
> --- a/drivers/net/ethernet/google/gve/gve.h
> +++ b/drivers/net/ethernet/google/gve/gve.h
> @@ -1253,6 +1253,8 @@ static inline bool gve_is_clock_enabled(struct gve_priv *priv)
>  	return priv->nic_ts_report;
>  }
>  
> +void gve_adminq_write_version(u8 __iomem *driver_version_register);
> +

[Severity: Low]
This isn't a bug, but the naming and placement here don't quite match.
The function now has a gve_adminq_* name, but it is still defined in
gve_main.c. Its prototype goes in gve.h rather than gve_adminq.h, which
is where gve_adminq_init() and the other gve_adminq_* functions are
declared.

The only caller is gve_adminq_init() in gve_adminq.c, so the adminq code
now calls back into gve_main.c. This is probably because
gve_version_prefix is static in gve_main.c.

Would it be cleaner to keep the old name, or to move the function and its
declaration next to the rest of the adminq code?

[ ... ]

> diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/ethernet/google/gve/gve_main.c
> index addfd8dc1a1a2..2fe280cf7e680 100644
> --- a/drivers/net/ethernet/google/gve/gve_main.c
> +++ b/drivers/net/ethernet/google/gve/gve_main.c
> @@ -2415,6 +2415,35 @@ static void gve_set_buf_sizes(struct gve_priv *priv)
>  		priv->header_buf_size = device_info->header_buf_size;
>  }
>  
> +static int gve_setup_device(struct gve_priv *priv)
> +{
> +	int err;
> +
> +	priv->num_registered_pages = 0;
> +
> +	priv->xsk_pools = bitmap_zalloc(priv->rx_cfg.max_queues, GFP_KERNEL);
> +	if (!priv->xsk_pools) {
> +		err = -ENOMEM;
> +		goto err;
> +	}
> +
> +	gve_set_netdev_xdp_features(priv);
> +	if (!gve_is_gqi(priv))
> +		priv->dev->xdp_metadata_ops = &gve_xdp_metadata_ops;
> +
> +	err = gve_setup_device_resources(priv);
> +	if (err)
> +		goto err_free_xsk_bitmap;

[Severity: Medium]
This is a pre-existing issue, but gve_setup_device_resources() allocates
the stats report, and every reset frees and reallocates it. Is the
teardown order for that buffer safe?

gve_free_stats_report() does:

	timer_delete_sync(&priv->stats_report_timer);
	dma_free_coherent(&priv->pdev->dev, priv->stats_report_len,
			  priv->stats_report, priv->stats_report_bus);

Nothing drains stats_report_task before this. If gve_stats_report_task()
is already queued or running, could gve_handle_report_stats() access the
freed stats_report buffer or the rings during reset, suspend or remove?

"gve: simplify reset logic" later in the series appears to fix this by
adding cancel_work_sync(&priv->stats_report_task) to
gve_free_stats_report() and gve_queues_stop().

[ ... ]

> @@ -2566,15 +2541,32 @@ static int gve_reset_recovery(struct gve_priv *priv, bool was_up)
>  {
>  	int err;
>  
> -	err = gve_init_priv(priv, true);
> -	if (err)
> +	err = gve_adminq_init(priv);
> +	if (err) {
> +		dev_err(&priv->pdev->dev,
> +			"Failed to alloc admin queue: err=%d\n", err);
>  		goto err;
> +	}

[Severity: Medium]
This isn't a bug introduced by this patch, but does the reset path that
skips normal teardown leak the previous AdminQ here?

With gve_reset(priv, false):

gve_reset()
  gve_reset_and_teardown()
    gve_trigger_reset()
      gve_adminq_release()
        gve_clear_admin_queue_ok(priv);
    gve_teardown_priv_resources()
      gve_adminq_free()
        if (!gve_get_admin_queue_ok(priv))
            return;

gve_adminq_free() therefore returns early and never calls
dma_pool_free() or dma_pool_destroy().

gve_reset_recovery()->gve_adminq_init()->gve_adminq_alloc() then
overwrites priv->adminq_pool and priv->adminq. The old dma_pool and its
AdminQ buffer would be lost on each such reset.

This seems to be fixed later in the series by "gve: simplify reset
logic", which removes gve_reset_and_teardown() and gve_trigger_reset().

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260924185316.2831077-1-hramamurthy%40google.com
