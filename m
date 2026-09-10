Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5179D3DDDA1;
	Thu, 10 Sep 2026 22:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789078434; cv=none; b=uVb0KOjmbzM27zZ7xol9LNVBg9FATgawgtKebMR4IzyozE2SSj7Q2z9fQxUKbOJhK3lv7IDXY2b/9ezXgIZiSSVtlkWBGvl2zUs9zrMLkTbF20P2carxAkwH1UgvL2tjaLEyZ5Ru4CzyB8kfl2bSUdgeaJnwptRLk26gRkD2MN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789078434; c=relaxed/simple;
	bh=TH1fEbP2k4BmopJ4z1U2mkvLKw1fQLDiLd+a8AqPa8A=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qrpTvyDUFx0x6ycOAmZ2TRRpLOmbVsIh1uB4tkWVPUQdntMfCZtd47x9NYj+MYRA0b7/rvoI/ZqQR+iKtez8FSRAVIzFFtQle9q6NqSEAPW4jiCJpm/e6HnhHVnNKXMR2fJNIloPc4Xc+hr+uVQv/48RERnEkTX9dpOpqIhiJwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QeTIWLk2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QeTIWLk2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0D3B1F00893;
	Thu, 10 Sep 2026 22:13:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789078432;
	bh=gcfVqyi3bSSOO/DVQ4TIe/SiIuRbmRSjKcADJEFMvlI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=QeTIWLk2AdN6PmpKc/bI4oDy6eAxb+uifaFag8jz7nFnFkTmLE4o5Q8HzIhLOMAmk
	 I9pH3240NeK0R78WBGnuUCvcgbjHSK/JriErFd69VzoFNAUHeXfIxuo5ZX0rzdpcQN
	 Jq1dW98driD+lRfz3ekiCWrV7P31SZ5tuKQi+ouqIndGRiGZmuR5sfYssRtoEaq7oc
	 32eVKouKr+02UtYCtTW4IU5cD8n4LRsSuaPCn5yu/q62SuZi/Jv2+HySYAxX349c91
	 idbjCLnXZxaG9FciRObauHjU5G9nc4eYTHQJfO4up3HZiSLPtDrrsVwuvVmMT5TPNT
	 QgKvTdWgb9kOg==
Subject: Re: [PATCH net-next v6 04/12] gve: introduce
 gve_adminq_get_device_properties()
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
Date: Thu, 10 Sep 2026 22:13:51 +0000
Message-ID: <178907843138.219967.17268659724650641980@kernel.org>
In-Reply-To: <20260909191136.3811892-5-hramamurthy@google.com>
References: <20260909191136.3811892-5-hramamurthy@google.com>
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

- [Low] gve_adminq_get_device_properties()
  (drivers/net/ethernet/google/gve/gve_adminq.c:1148) bundles…

Pre-existing issues:
- [Medium] gve_adminq_verify_driver_compatibility()
  (drivers/net/ethernet/google/gve/gve_adminq.c:1264, moved verbatim…

--

gve: introduce gve_adminq_get_device_properties()

This adds gve_adminq_get_device_properties(), a helper that runs the
VERIFY_DRIVER_COMPATIBILITY and DESCRIBE_DEVICE admin queue commands in
sequence, and moves the driver-info allocation and fill-in from
gve_main.c into gve_adminq_verify_driver_compatibility().  The commit
message describes it as pure code movement with no functional change.

No Link: tags present in the commit header.

> diff --git a/drivers/net/ethernet/google/gve/gve_adminq.c b/drivers/net/ethernet/google/gve/gve_adminq.c
> index 046155ae7d669..f420a8e1dd3df 100644
> --- a/drivers/net/ethernet/google/gve/gve_adminq.c
> +++ b/drivers/net/ethernet/google/gve/gve_adminq.c

[ ... ]

> @@ -1143,6 +1145,27 @@ int gve_adminq_describe_device(struct gve_priv *priv)
>  	return err;
>  }
>  
> +int gve_adminq_get_device_properties(struct gve_priv *priv)
> +{
> +	int err;
> +
> +	err = gve_adminq_verify_driver_compatibility(priv);
> +	if (err) {
> +		dev_err(&priv->pdev->dev,
> +			"Could not verify driver compatibility: err=%d\n", err);
> +		return err;
> +	}
> +
> +	/* Get the initial information we need from the device */
> +	err = gve_adminq_describe_device(priv);
> +	if (err) {
> +		dev_err(&priv->pdev->dev,
> +			"Could not get device information: err=%d\n", err);
> +		return err;
> +	}
> +	return 0;
> +}

[Severity: Low]
Should this helper also carry the state handling that gve_init_priv()
currently performs around the same two commands?

gve_init_priv() in gve_main.c does this before calling
gve_adminq_describe_device():

	priv->num_registered_pages = 0;

	if (skip_describe_device)
		goto setup_device;

	device_info->queue_format = GVE_QUEUE_FORMAT_UNSPECIFIED;
	/* Get the initial information we need from the device */
	err = gve_adminq_describe_device(priv);

The queue_format reset matters because gve_adminq_describe_device()
consumes the incoming value:

	} else if (device_info->queue_format == GVE_GQI_RDA_FORMAT) {
		dev_info(&priv->pdev->dev,
			 "Driver is running with GQI RDA queue format.\n");

A caller that invokes gve_adminq_get_device_properties() with a stale
non-zero device_info.queue_format would keep the previous format and end
up with supported_features_mask left at 0, silently disabling jumbo
frames, buffer sizes, modify-ring, flow steering, RSS and timestamps.

For the record, this does not appear to be reachable anywhere: at this
commit gve_adminq_get_device_properties() has no callers, only the
prototype in gve_adminq.h and the definition, and gve_init_priv() still
calls gve_adminq_describe_device() directly with the reset in place.  By
the end of the series the concern is resolved rather than left latent:
the single call site in gve_probe() does

	priv->device_info.queue_format = GVE_QUEUE_FORMAT_UNSPECIFIED;
	err = gve_adminq_get_device_properties(priv);

skip_describe_device no longer exists in the driver, and
priv->num_registered_pages = 0 has moved into gve_setup_device().  Would
it be worth a note in the commit message that the surrounding state
handling stays with the caller?

> @@ -1205,20 +1228,53 @@ int gve_adminq_report_stats(struct gve_priv *priv, u64 stats_report_len,
>  	return gve_adminq_execute_cmd(priv, &cmd);
>  }
>  
> -int gve_adminq_verify_driver_compatibility(struct gve_priv *priv,
> -					   u64 driver_info_len,
> -					   dma_addr_t driver_info_addr)
> +int gve_adminq_verify_driver_compatibility(struct gve_priv *priv)
>  {
> +	struct gve_driver_info *driver_info;
>  	union gve_adminq_command cmd;
> +	dma_addr_t driver_info_bus;
> +	int err;
> +
> +	driver_info = dma_alloc_coherent(&priv->pdev->dev,
> +					 sizeof(struct gve_driver_info),
> +					 &driver_info_bus, GFP_KERNEL);
> +	if (!driver_info)
> +		return -ENOMEM;

[ ... ]

> -	return gve_adminq_execute_cmd(priv, &cmd);
> +	err = gve_adminq_execute_cmd(priv, &cmd);
> +
> +	/* It's ok if the device doesn't support this */
> +	if (err == -EOPNOTSUPP)
> +		err = 0;
> +
> +	dma_free_coherent(&priv->pdev->dev,
> +			  sizeof(struct gve_driver_info),
> +			  driver_info, driver_info_bus);
> +	return err;
>  }

[Severity: Medium]
This isn't a bug introduced by this patch, but is it safe to hand
driver_info back to the DMA allocator when the admin queue timed out?

The identical sequence lived in gve_verify_driver_compatibility() in
gve_main.c before the move, so this is only being relocated here.

On the timeout path gve_adminq_kick_and_wait() has already rung the
doorbell and gives up without quiescing the queue:

	gve_adminq_kick_cmd(priv, head);
	if (!gve_adminq_wait_for_cmd(priv, head)) {
		dev_err(&priv->pdev->dev, "AQ commands timed out, need to reset AQ\n");
		priv->adminq_timeouts++;
		return -ENOTRECOVERABLE;
	}

The VERIFY_DRIVER_COMPATIBILITY descriptor still carries
driver_info_bus, so after gve_adminq_execute_cmd() returns
-ENOTRECOVERABLE the buffer is released while the device may still
fetch it.  Can the NIC read driver_info after dma_free_coherent() has
returned it to the allocator?

The same unconditional-free-after-execute pattern is used by
gve_adminq_register_page_list(), gve_adminq_execute_extended_cmd() and
gve_adminq_describe_device(), so if this is worth addressing it looks
like a separate change rather than something for this code movement.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260909191136.3811892-1-hramamurthy%40google.com
