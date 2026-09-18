Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 505F34A2054;
	Fri, 18 Sep 2026 07:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789718273; cv=none; b=ALdY/ArJtZz1L3ueL5b0UgrcP7otHpzO0XFbkE8ai+2NCY1BpV9rAm5zxMEj5x2j3Vswa9gKTLEK7EtjBXvnef4OvYRWN25rjKDHzY6xR57wal/0uTiZcmt8r2mgItI3jH4OjqhS18c4qnNmVEOyQ92RU9esarPQ9nLDa5fWkf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789718273; c=relaxed/simple;
	bh=FG85INJ3bwf9QjFDdFLjq0sVxz+NIkDGmiTj8A+LpOw=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=X8PiqQ8hf+yNryhcESNnVG8ork3kOB2pOxDTcu9DF+bT+6aEijDIz9esUfQ8dDvARlEl913/AfAwZDoUrjAmq4Tyf8JwwcTtyDc+KSZvDesP+/wdpvdYyhc3uKgwlTDnZw1WYI7Um63L+JtbOYcbI983E3xpMkaOi+U/KCjJXDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hPML0SL5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hPML0SL5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DE051F00898;
	Fri, 18 Sep 2026 07:57:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789718266;
	bh=7WY2nNEObBFshuCD3Ko75OhEq00Sxv7L983qEQM1ZMk=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=hPML0SL5zsMmNLQw4TNhxYYCHhbssbuiUXzJjnlCUyV0dkWfB32tvec2YvJzuebKx
	 /q39XAlFamuEiH9+kh8eiSu+PBhRg2C/43XpDsPKEmvGFntKqvBer7dNqxOwoloG84
	 YmLTUdDKZjFMOMUynfhYw0Hpi7gQKOPdL+83ENqvaGoBirePGNPTEtiQ41qT0yqrjx
	 WYkcddtRvLFgwSPie6AdLSq8FYr6CZ141xTb3QORheDCFUB1IefDw5oA3Jl3reQ15K
	 8cHIEArS1HGswu4LLg+KYuqIjWR2eZijiOutccBNxr42ND4yFFtlIOUw7UDLfN73pQ
	 BzBEZ6TAhht1g==
Subject:
 Re: [PATCH net-next v7 05/12] gve: refactor gve_init_priv for reset path
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
Date: Fri, 18 Sep 2026 07:57:44 +0000
Message-ID: <178971826461.22033.10772687252386116393@kernel.org>
In-Reply-To: <20260916165533.2187434-6-hramamurthy@google.com>
References: <20260916165533.2187434-6-hramamurthy@google.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider:

Critical: 0 · High: 0 · Medium: 1 · Low: 0 (3)

- [Medium] The commit message states "These changes are only code
  movement, no functional change", but the patch makes two device-…

Pre-existing issues:
- [Low] Claim: after a failed reset recovery the reworked error path in
  gve_reset_recovery() frees the AdminQ (err_free_adminq ->…
- [Low] Claim: on the forced-teardown reset path, gve_trigger_reset() ->
  gve_adminq_release() clears GVE_PRIV_FLAGS_ADMIN_QUEUE_OK…
- [Low] Claim: during reset recovery with RESET_IN_PROGRESS set, a
  partial queue-creation failure in gve_create_rings() (TX queues…

--

gve: refactor gve_init_priv for reset path

This splits gve_init_priv() into a probe-only property-setting helper plus
new gve_adminq_init() and gve_setup_device() helpers, and makes
gve_reset_recovery() call those helpers directly instead of re-running the
full init path. The device-property negotiation now happens once, in
gve_probe().

> diff --git a/drivers/net/ethernet/google/gve/gve_adminq.c b/drivers/net/ethernet/google/gve/gve_adminq.c
> index f420a8e1dd3df..a62cb7a921d07 100644
> --- a/drivers/net/ethernet/google/gve/gve_adminq.c
> +++ b/drivers/net/ethernet/google/gve/gve_adminq.c

[ ... ]

> @@ -355,6 +357,14 @@ int gve_adminq_alloc(struct device *dev, struct gve_priv *priv)
>  	return 0;
>  }
>  
> +int gve_adminq_init(struct gve_priv *priv)
> +{
> +	struct gve_registers __iomem *reg_bar = priv->reg_bar0;
> +
> +	gve_adminq_write_version(&reg_bar->driver_version);
> +	return gve_adminq_alloc(priv);
> +}
> +
>  void gve_adminq_release(struct gve_priv *priv)
>  {
>  	int i = 0;

[Severity: Low]

Note: the finding id above should read gpe-6-astra-4-11 as supplied; the
correct value is:

This isn't a bug introduced by this patch, but while gve_adminq_release()
is being kept as an exported helper here, does the forced-teardown reset
path leak the AdminQ DMA pool?

gve_adminq_release() clears the ok flag while the buffer is still
allocated:

	gve_clear_device_rings_ok(priv);
	gve_clear_device_resources_ok(priv);
	gve_clear_admin_queue_ok(priv);

and gve_adminq_free() bails out on that same flag before freeing:

	if (!gve_get_admin_queue_ok(priv))
		return;
	gve_adminq_release(priv);
	dma_pool_free(priv->adminq_pool, priv->adminq, priv->adminq_bus_addr);
	dma_pool_destroy(priv->adminq_pool);

On gve_reset(priv, false) the sequence is gve_trigger_reset() ->
gve_adminq_release(), then gve_teardown_priv_resources() ->
gve_adminq_free(), which returns early, so dma_pool_free() and
dma_pool_destroy() never run and recovery overwrites priv->adminq and
priv->adminq_pool.

The next patch in the series, "gve: simplify reset logic", removes
gve_clear_admin_queue_ok() from gve_adminq_release() and drops
gve_trigger_reset(), so this appears to be addressed there.

> diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/ethernet/google/gve/gve_main.c
> index addfd8dc1a1a2..2fe280cf7e680 100644
> --- a/drivers/net/ethernet/google/gve/gve_main.c
> +++ b/drivers/net/ethernet/google/gve/gve_main.c

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
> +
> +	err = gve_adminq_verify_driver_compatibility(priv);
> +	if (err) {
> +		dev_err(&priv->pdev->dev,
> +			"Could not verify driver compatibility: err=%d\n", err);
> +		goto err_free_adminq;
> +	}
> +
> +	err = gve_setup_device(priv);
> +	if (err)
> +		goto err_free_adminq;
>  	if (was_up) {
>  		err = gve_open(priv->dev);
>  		if (err)
> -			goto err;
> +			return err;
>  	}
>  	return 0;

[Severity: Medium]

The commit message says:

    These changes are only code movement, no functional change.

Two changes in the reset path look like more than code movement.

First, a failed reopen now returns directly instead of falling through to
the err label, so the "Reset failed! !!! DISABLING ALL QUEUES !!!" message
and gve_turndown(priv) are no longer executed when gve_open() fails during
recovery. Is dropping the diagnostic and the turndown call intended?

Second, gve_adminq_init() streams the driver version string into the MMIO
version register:

	gve_adminq_write_version(&reg_bar->driver_version);
	return gve_adminq_alloc(priv);

Before this patch gve_write_version() had exactly one call site, in
gve_probe(). Now gve_reset_recovery() -> gve_adminq_init() writes the
version register again on every reset. Is that repeated write to the
device version register expected?

Could the commit message describe both of these instead of stating no
functional change?

Related, the v3 note below the --- line says "don't free device resources
if gve_open() fails in the reset path", but the pre-patch gve_open()
failure path did not free device resources; it logged the reset failure
and called gve_turndown().

> +
> +err_free_adminq:
> +	gve_adminq_free(priv);

[Severity: Low]

This is a pre-existing issue rather than something introduced here, but
after this path runs the netdev stays registered while the AdminQ has been
freed. gve_adminq_free() leaves the pointers dangling:

	if (!gve_get_admin_queue_ok(priv))
		return;
	gve_adminq_release(priv);
	dma_pool_free(priv->adminq_pool, priv->adminq, priv->adminq_bus_addr);
	dma_pool_destroy(priv->adminq_pool);

At this commit gve_open() has no state validation, so a subsequent
"ip link set dev ethX up" would issue AdminQ commands into the released
DMA buffer and touch the freed notify-block state. The baseline behaved
the same way (the free lived in the gve_init_priv() err path), and the
following patch, "gve: simplify reset logic", adds the guard:

	if (!gve_get_device_resources_ok(priv)) {
		dev_err(&priv->pdev->dev,
			"Attempting to open netdev without resources. Device must be reset.");
		return -ENODEV;
	}

so the hole looks closed later in the series.

>  err:
>  	dev_err(&priv->pdev->dev, "Reset failed! !!! DISABLING ALL QUEUES !!!\n");
>  	gve_turndown(priv);

[Severity: Low]

This isn't introduced by this patch either, but with the new direct return
on gve_open() failure there is still no hardware reset on that path. If
gve_create_rings() fails after some TX queues were already created, with
GVE_PRIV_FLAGS_RESET_IN_PROGRESS set gve_queues_start() takes:

stop_and_free_rings:
	gve_tx_stop_rings(priv, gve_num_tx_queues(priv));
	gve_rx_stop_rings(priv, priv->rx_cfg.num_queues);
	gve_queues_mem_remove(priv);
	return err;

which frees the ring memory without destroying the device queues or
unregistering the QPLs, and gve_reset_recovery() then returns with the
device still holding references to that memory. The baseline only logged
and called gve_turndown() here, which also performs no device reset.

The following patch, "gve: simplify reset logic", routes this failure to
gve_teardown_device() -> gve_reset_device(), which waits for
GVE_DEVICE_STATUS_DEVICE_IS_RESET, so the dangling state does not persist
at the end of the series.

> @@ -2617,7 +2609,7 @@ int gve_reset(struct gve_priv *priv, bool attempt_teardown)
>  	return err;
>  }
>  
> -static void gve_write_version(u8 __iomem *driver_version_register)
> +void gve_adminq_write_version(u8 __iomem *driver_version_register)
>  {
>  	const char *c = gve_version_prefix;
>  
> @@ -2850,7 +2842,6 @@ static int gve_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
>  		goto abort_with_pci_region;
>  	}
>  
> -	gve_write_version(&reg_bar->driver_version);
>  	/* Get max queues to alloc etherdev */
>  	max_tx_queues = ioread32be(&reg_bar->max_tx_queues);
>  	max_rx_queues = ioread32be(&reg_bar->max_rx_queues);

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260916165533.2187434-1-hramamurthy%40google.com
