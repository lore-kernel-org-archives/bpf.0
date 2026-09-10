Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E98F443F4DD;
	Thu, 10 Sep 2026 22:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789078436; cv=none; b=nSxIS08WKeYJlf7qy8zgxVykXkRdd/zq3v3Kbii98MZZXaNImZsX3qzTZChfDGfZiXkEZEUL2IBxfUhixeSiBGvOsF1O2xtsxyjW7bZVH3e8fhAXxXxd0bjOvBbDa5DeuDMjVuK0DS8RLRprNBTxlN/L9RRw81Di8WUFJKZRm4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789078436; c=relaxed/simple;
	bh=QbQoS/YkVCeEqhy6q0zjJrkaSP68fs3TVomseBTEP5g=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KDaT5z5Mu9u2mgjA7SVMikaqJKhn0yVU22WqE4RW4OyzJ2stJrVPXf3393u4HcjI04oPUMyGa0HIjFiePjfduA36tgf+xNztEbDyIOAVGhkXP//x9KkK5qhps2+TZAN3Vdjdo5zoj0B0b+fRbxNNQhtwyx+FbowsGNo/Px2TmT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c5AYKinx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c5AYKinx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 822331F000FF;
	Thu, 10 Sep 2026 22:13:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789078434;
	bh=kvP8Oc1VjduY0uNGZdxviNpAfaHQ10pxyPT3+Lk7qVg=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=c5AYKinxSFqBt/0ClCs0+zPOsfHpmZCpuD2KQVcm6HRCMH5NBmIiSA0aUqKDk4rhv
	 /tcn0uwmEO9DRv1XiHT+tgIUa6AeZAVpHlTrwMNSIeCJuZJJGwzZ4LpkFNfYIlnyI2
	 Exfh+4+FJOlHm9q+uEMBWcgV/R4Unl2kU6CPtp4TYpOAIts1lXLIgAPRwmyOzDIcQb
	 m8xTDImYq5r8yDOvVOEE3EVgmfiBJsCEutaNBfqzH58eGucdH6W/TV8YcJ4Ism6YUY
	 LxLGiL8PrSGxJG5xvzOaSiX+AqwXuGJZXY1Do92pgSyIGF2BwHDfzJEFaJ+U09n/hG
	 qY0WcDn4T9peQ==
Subject:
 Re: [PATCH net-next v6 05/12] gve: refactor gve_init_priv for reset path
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
Date: Thu, 10 Sep 2026 22:13:53 +0000
Message-ID: <178907843311.219967.13433516854329401694@kernel.org>
In-Reply-To: <20260909191136.3811892-6-hramamurthy@google.com>
References: <20260909191136.3811892-6-hramamurthy@google.com>
X-sashiko-severity: Low
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

Critical: 0 · High: 0 · Medium: 0 (1) · Low: 1

- [Low] In `gve_reset_recovery()`
  (drivers/net/ethernet/google/gve/gve_main.c:2561-2564) a `gve_open()`…

Pre-existing issues:
- [Medium] Hardware-state divergence after a failed queue bring-up in
  reset recovery: when `gve_reset_recovery()` gets an error from…

--

gve: refactor gve_init_priv for reset path

gve_init_priv() is reduced to only populating priv with device properties
so it can be called once from gve_probe(), with the new gve_adminq_init()
and gve_setup_device() helpers taking over adminq allocation and device
setup. gve_reset_recovery() now calls those helpers directly instead of
going through gve_init_priv().

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

[Severity: Low]

The gve_open() failure in gve_reset_recovery() changes from "goto err" to
"return err", so it no longer reaches the shared label:

err:
	dev_err(&priv->pdev->dev, "Reset failed! !!! DISABLING ALL QUEUES !!!\n");
	gve_turndown(priv);
	return err;

Is dropping the "Reset failed" message and the gve_turndown(priv) call on
that path intended?  A failing gve_open() during recovery (for example
gve_queues_mem_alloc() returning -ENOMEM under memory pressure) now
returns silently to gve_reset(), which only prints its own message.

The commit message says:

    These changes are only code movement, no functional change.

Would it be worth mentioning this behaviour change above the "---" line so
it survives in git history?  The v3 changelog note "don't free device
resources if gve_open() fails in the reset path" is below the cut and does
not mention the lost diagnostic or the skipped gve_turndown().

For what it is worth, the later commit "gve: simplify reset logic"
(84559f54c263) restores both: gve_recover() sends a gve_open() failure to
its teardown_device label, which logs "Recover failed! !!! DISABLING ALL
QUEUES !!!" and calls gve_teardown_device().

[Severity: Medium]

This isn't a bug introduced by this patch, but the same "return err" path
leaves the device without any reset after a partially completed queue
bring-up, and the refactor is a good opportunity to ask about it.

When gve_open() -> gve_queues_start() fails after gve_register_qpls() or
after some queues were created, it takes its reset label, and because
GVE_PRIV_FLAGS_RESET_IN_PROGRESS is set it skips the reset and frees the
ring and QPL memory instead:

reset:
	if (gve_get_reset_in_progress(priv))
		goto stop_and_free_rings;
	gve_reset_and_teardown(priv, true);
...
stop_and_free_rings:
	gve_tx_stop_rings(priv, gve_num_tx_queues(priv));
	gve_rx_stop_rings(priv, priv->rx_cfg.num_queues);
	gve_queues_mem_remove(priv);
	return err;

gve_register_qpls() and gve_create_rings() rely on the assumption that
"this failure will trigger a reset - no need to clean up", but on this path
no gve_adminq_free()/gve_adminq_release() runs, so nothing writes
GVE_DRIVER_STATUS_RESET_MASK.

Can the NIC then be left with queues created and page lists registered that
reference DMA memory the driver has just released?  The baseline code had
the same gap, since its "goto err" only logged and called gve_turndown().

Here too the end of the series appears to close this: gve_recover() routes
the gve_open() failure to gve_teardown_device(), which calls
gve_adminq_free() and therefore gve_adminq_release().

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260909191136.3811892-1-hramamurthy%40google.com
