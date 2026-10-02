Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E02A547F764;
	Fri,  2 Oct 2026 10:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790935595; cv=none; b=f78oXfFKQC0wLszgBUaXPfzkNsp46K3UW3OylnB4hy1I8MwS8pXuTdQFd8oDVx8n/kOjkS0DC4TUoX1243yOjzsbrTckXyZIxj3/BmSeG4OgL40zplHWBeOoPOXAQ307yk/ywJL1+jgA6HMVTXBuAKy4TVmUcB6D/8Qub5vL6/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790935595; c=relaxed/simple;
	bh=sg5XPxr+0NK8TxpryNto3ximduc2YpH9F/POD31dh4c=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PMUTibbEgCDGY83f9nhRE6G3FZqCjproW/gNX0TSJGkxZwzTDi7Waqhm0BHu1zWOsuVrtYjoLbg/JKOJv6X9Ye1j2sxyZ2Ec3HgVWDS6Mz27zR7kOAm3TQ2kfb9ypHOdSOrrPBiloYZGik0PIR61KbJs/DMeSR9OsIIj+lLcvKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BTwlWyX0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BTwlWyX0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FB351F000FF;
	Fri,  2 Oct 2026 10:06:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790935593;
	bh=wL3tKzHArkV/NLxYqjZrSeMlCKtl7sY5Rb6UGr62UBw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=BTwlWyX06pt2jewFQr+1DJhH0Gz4hgYSW+FKasESTP4l7fyPiKw8PxWhmTP0KjcJc
	 +HmoEYEAHL4oI16B3vpvfm1QHqJ34d4AMiz6PwAM9UkGt8yRi0zVhthLJmmjNbqUH+
	 0UN0duum+Ph4WPOM+e6eqW/GtmyUrOz74bymbFD1yJNrZWocjptD59PZQoFHEvW7B0
	 T72+CbpY60SQnkuJKSGUs7FnIVBULSYba+i/Uu7apgMcqg0NMoiMJcU1Na5sNuTLYt
	 5YP4bzF2cKlTVL3GM45pORUWfEGXGFnjvKPLNHV5GB2NRePsA/2wucg7LbfgbF3SpP
	 3D4JezXsaNdEw==
Subject:
 Re: [PATCH net-next v9 05/12] gve: refactor gve_init_priv for reset path
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
Date: Fri, 02 Oct 2026 10:06:31 +0000
Message-ID: <179093559163.434549.8853251921845038273@kernel.org>
In-Reply-To: <20260930190428.1130007-6-hramamurthy@google.com>
References: <20260930190428.1130007-6-hramamurthy@google.com>
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
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 (1) · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The commit message says "These changes are only code movement,
  no functional change".

Pre-existing issues:
- [Medium] This problem wasn't introduced by this patch, but a hard reset
  leaks the AdminQ dma_pool and its buffer.

--

gve: refactor gve_init_priv for reset path

This patch splits gve_init_priv() so that gve_probe() now does the AdminQ
setup (the new gve_adminq_init()) and the device property negotiation
(gve_adminq_get_device_properties()). Device setup moves into a new
gve_setup_device() helper. gve_reset_recovery() now calls
gve_adminq_init(), gve_adminq_verify_driver_compatibility() and
gve_setup_device() directly, instead of gve_init_priv(priv, true).

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

[Severity: Medium]
This isn't a bug introduced by this patch, but does a hard reset leak the
AdminQ dma_pool and its buffer here?

A hard reset is gve_reset(priv, false), or gve_reset() after gve_close()
fails. Either way it goes through:

gve_reset_and_teardown()
  gve_trigger_reset()
    gve_adminq_release()
      gve_clear_admin_queue_ok(priv);
  gve_teardown_priv_resources()
    gve_adminq_free()

gve_adminq_free() then returns early, because ADMIN_QUEUE_OK is already
clear:

void gve_adminq_free(struct gve_priv *priv)
{
	if (!gve_get_admin_queue_ok(priv))
		return;
	gve_adminq_release(priv);
	dma_pool_free(priv->adminq_pool, priv->adminq, priv->adminq_bus_addr);
	dma_pool_destroy(priv->adminq_pool);
	...
}

So dma_pool_free() and dma_pool_destroy() never run. Then
gve_adminq_init() here calls gve_adminq_alloc(), which puts new
allocations in priv->adminq_pool and priv->adminq. The old pool and
buffer are lost.

The same thing seems to happen when gve_teardown_device_resources() calls
gve_trigger_reset() after a failed AdminQ command.

The baseline gve_init_priv(priv, true) path leaked in the same way. The
later "gve: simplify reset logic" patch in this series appears to fix it.
That patch makes gve_adminq_release() static and calls it only from
gve_adminq_free(). It also stops gve_adminq_release() from clearing
ADMIN_QUEUE_OK and removes gve_trigger_reset().

> +	if (err) {
> +		dev_err(&priv->pdev->dev,
> +			"Failed to alloc admin queue: err=%d\n", err);
>  		goto err;
> +	}
> +

[ ... ]

>  	if (was_up) {
>  		err = gve_open(priv->dev);
>  		if (err)
> -			goto err;
> +			return err;

[Severity: Medium]
The commit message says:

  These changes are only code movement, no functional change.

Is that accurate? The patch seems to change behaviour in a few places.

First, gve_adminq_init() writes the version string before it allocates
the AdminQ:

	gve_adminq_write_version(&reg_bar->driver_version);
	return gve_adminq_alloc(priv);

gve_reset_recovery() now calls this helper. That means the driver version
string is written to the BAR0 driver_version register on every reset,
resume and recovery. Before this patch, gve_write_version() ran only once,
from gve_probe(). gve_recover() still does this at the end of the series.

Second, the order of device accesses in gve_probe() changes. The version
write now comes after the max_tx_queues/max_rx_queues ioread32be() reads
and after alloc_etherdev_mqs(). AdminQ registration,
VERIFY_DRIVER_COMPATIBILITY and DESCRIBE_DEVICE now run before ctrl_ops is
set, before map_db_bar() and before alloc_ordered_workqueue().

Third, when gve_open() fails here, the old goto err path logged "Reset
failed! !!! DISABLING ALL QUEUES !!!" and called gve_turndown(). Now the
function just returns. Neither gve_reset() nor gve_resume() logs the
error, so a failed re-open after reset or resume leaves nothing in the log.

The only place this is mentioned is the v3 changelog below the ---
line, and that text is dropped when the patch is applied. The changelog
says "don't free device resources if gve_open() fails in the reset path".
The baseline err label did not free device resources either, though.

The later "gve: simplify reset logic" patch adds a "Failed to start
queues ... DISABLING ALL QUEUES" message in gve_recover(). At this commit,
though, the message is missing.

Could the commit message describe these changes, instead of calling the
patch only code movement?

>  	}
>  	return 0;

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260930190428.1130007-1-hramamurthy%40google.com
