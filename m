Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98DE0362120;
	Thu, 10 Sep 2026 22:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789078440; cv=none; b=DVtvHaxfSlXFCEfWsW5HYvaOkCA/DoCs+51C+qnoWroKlmNV3v3gE4jVcSIsov+cL09EQsTBZlEH5oyHeeM2E9c9Xqi4xvNOwVhkWuTOylpR8E6mAZz+64JZvec4qEGILm3LlBlVQo6aKhHdg8b2lpiDBoKale+agckj2BvYDpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789078440; c=relaxed/simple;
	bh=7yK/TIHpVsbMAw0teH1HgTXxMjWKHZckgDgaInlB+Vg=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Hqj6ig8l6S7pG7tIJaxL3JTqysyaI7PA3J65NPmIOGpgQEl173gW/2PicFNNx0bf8gwKPFbSddw1tsgPImYs7Emj/s8GeX+1zPKEwiBfegxiIbNJJMVi6S99lLmajqMcR31Dfev7wyo+i9foSsBr5HhskheNo1hnnI9dtKJVTv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ailoK8+n; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ailoK8+n"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10B3D1F000FF;
	Thu, 10 Sep 2026 22:13:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789078438;
	bh=mquJLk7fjjw8PG25skZ6fbBCwq7kkJfpMvnsF0zOoTI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=ailoK8+nNEJTT0S03S7zS0kv7BiCSXCkEJawL0rsf4Vl3csyLQeuBcpdfsQ4cCSKI
	 Dsaer9a2chJioaN6igHMj+2WFJt1kGoQ/uBu6WOZPp5p0WDXdktdZnpS8i/HGu8DtA
	 2suozf7sxlte08lqdKqy1i0Uv4ptbbR32Vm8oCzzXkPvhjcoDkOXp9JoyCejcPMNkS
	 QNFmWsI1O0QKiqFJdancIh3sklRmZyrcRYCsLgoxFkQUK7qUI8vLJBVtbMNOqilnw2
	 DLle3c0jTALz8817HUBlyTcTXp5v1fG1MoPHEXyFHCbUeoZ9CDuOPb+dDrHmQ6xZtj
	 Ft2jmZQzAaZzw==
Subject: Re: [PATCH net-next v6 09/12] gve: introduce new methods to handle
 IRQ doorbells
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
Date: Thu, 10 Sep 2026 22:13:56 +0000
Message-ID: <178907843664.219967.14210316170815119158@kernel.org>
In-Reply-To: <20260909191136.3811892-10-hramamurthy@google.com>
References: <20260909191136.3811892-10-hramamurthy@google.com>
X-sashiko-severity: Low
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

Critical: 0 · High: 0 · Medium: 0 · Low: 3

- [Low] Undisclosed changes in the commit message: besides the two new
  `gve_ctrl_ops` callbacks, this patch (a) adds a brand-new no-op inline…
- [Low] The new error log in `gve_setup_control_plane_resources()` —
  `dev_err(&priv->pdev->dev, "Failed to get db info");` at…
- [Low] The kernel-doc added for `struct gve_ctrl_ops` understates the
  contract of the two new callbacks.

--

gve: introduce new methods to handle IRQ doorbells

This patch adds request_db_info and release_db_resources callbacks to
struct gve_ctrl_ops so that the device-resource configuration can differ
between Admin Queue and Mailbox modes. It also moves the association of
IRQ doorbell indices with notify blocks into the new callbacks.

A few questions on the changes below.

> diff --git a/drivers/net/ethernet/google/gve/gve.h b/drivers/net/ethernet/google/gve/gve.h
> index f624a3e385e4c..6c46c842070b7 100644
> --- a/drivers/net/ethernet/google/gve/gve.h
> +++ b/drivers/net/ethernet/google/gve/gve.h
> @@ -834,6 +834,9 @@ struct gve_device_info {
>   *                  structures stored in @priv to be used during initialization.
>   * @set_num_ntfy_blks: Sets no. of vectors into @priv to be used during
>   *                     initialization.
> + * @request_db_info: Request and store doorbell information into @priv
> + * @release_db_resources: Release device hold on DMA memory holding doorbell
> + *			  info (AdminQ only)

[Severity: Low]
Does this kernel-doc describe the full contract of the two callbacks?

The only implementation also registers and revokes the event counter
array, not just the doorbell index array:

  gve_adminq_request_db_info()
    gve_adminq_configure_device_resources(priv,
                                         priv->counter_array_bus,
                                         priv->num_event_counters,
                                         priv->irq_db_indices_bus,
                                         priv->num_ntfy_blks);

  gve_adminq_release_db_resources()
    gve_adminq_deconfigure_device_resources(priv);

The commit message itself says the ops "encapsulate the configuration of
device resources (counter arrays and IRQ doorbell indices)", which
matches the code but not the doc.

This matters because the same patch moves gve_free_counter_array() into
gve_free_control_plane_resources(), so the counter-array coherent buffer
is now freed on the strength of release_db_resources() having told the
device to stop using it. Should the doc mention the counter array so a
future mailbox implementation does not skip that part and leave the
device DMAing into freed memory?

>   * @get_ptype_map: Learn packet type map from device and store it in @priv
>   * @configure_rss: Set up default RSS configuration
>   * @setup_stats_report: Set up DMA region for stats report (AdminQ only)

[ ... ]

> @@ -1164,6 +1169,11 @@ static inline u32 gve_rx_idx_to_ntfy(struct gve_priv *priv, u32 queue_idx)
>  	return (priv->num_ntfy_blks / 2) + queue_idx;
>  }
>  
> +static inline u32 gve_ntfy_to_msix_idx(struct gve_priv *priv, u32 ntfy_blk_idx)
> +{
> +	return ntfy_blk_idx;
> +}
> +

[Severity: Low]
Could the commit message say something about this helper? It is a new
identity function whose priv argument is unused, and it is wired into
both gve_setup_notify_blocks() and gve_teardown_notify_blocks() in this
patch, but the changelog only mentions the two new gve_ctrl_ops members.

As written it encodes the AdminQ assumption that the management vector
is the last one (priv->mgmt_msix_idx == priv->num_ntfy_blks), which is
not stated anywhere. Would a short comment help?

The same applies to the resource movement further down: the
irq_db_indices DMA buffer is moved out of gve_alloc_notify_blocks() /
gve_free_notify_blocks() into new helpers, and the alloc/free order in
gve_alloc_control_plane_resources() / gve_free_control_plane_resources()
changes. The only note about that is in the v3 changelog below the ---
line, which does not end up in git history.

>  static inline bool gve_is_qpl(struct gve_priv *priv)
>  {
>  	return priv->queue_format == GVE_GQI_QPL_FORMAT ||
> diff --git a/drivers/net/ethernet/google/gve/gve_adminq.c b/drivers/net/ethernet/google/gve/gve_adminq.c
> index 1176e13fafc0c..b89825a85db82 100644
> --- a/drivers/net/ethernet/google/gve/gve_adminq.c
> +++ b/drivers/net/ethernet/google/gve/gve_adminq.c
> @@ -1718,3 +1718,40 @@ void gve_adminq_unmap_db_bar(struct gve_priv *priv)
>  
>  	pci_iounmap(pdev, priv->db_bar2);
>  }
> +
> +int gve_adminq_request_db_info(struct gve_priv *priv)
> +{
> +	int err;
> +	int i;
> +
> +	err = gve_adminq_configure_device_resources(priv,
> +						    priv->counter_array_bus,
> +						    priv->num_event_counters,
> +						    priv->irq_db_indices_bus,
> +						    priv->num_ntfy_blks);
> +	if (unlikely(err)) {
> +		dev_err(&priv->pdev->dev,
> +			"could not setup device_resources: err=%d\n", err);
> +		return -ENXIO;
> +	}
> +
> +	for (i = 0; i < priv->num_ntfy_blks; i++)
> +		priv->ntfy_blocks[i].irq_db_index =
> +			&priv->irq_db_indices[i].index;
> +	return 0;
> +}

[ ... ]

> diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/ethernet/google/gve/gve_main.c
> index d2f974a0cc877..84efcdea6be96 100644
> --- a/drivers/net/ethernet/google/gve/gve_main.c
> +++ b/drivers/net/ethernet/google/gve/gve_main.c
> @@ -203,6 +203,30 @@ static void gve_free_counter_array(struct gve_priv *priv)
>  	priv->counter_array = NULL;
>  }
>  
> +static int gve_alloc_irq_db_indices(struct gve_priv *priv)
> +{
> +	priv->irq_db_indices =
> +		dma_alloc_coherent(&priv->pdev->dev,
> +				   priv->num_ntfy_blks *
> +				   sizeof(*priv->irq_db_indices),
> +				   &priv->irq_db_indices_bus, GFP_KERNEL);
> +	if (!priv->irq_db_indices)
> +		return -ENOMEM;
> +
> +	return 0;
> +}
> +
> +static void gve_free_irq_db_indices(struct gve_priv *priv)
> +{
> +	if (!priv->irq_db_indices)
> +		return;
> +
> +	dma_free_coherent(&priv->pdev->dev, priv->num_ntfy_blks *
> +			  sizeof(*priv->irq_db_indices),
> +			  priv->irq_db_indices, priv->irq_db_indices_bus);
> +	priv->irq_db_indices = NULL;
> +}
> +

[ ... ]

> @@ -611,9 +614,10 @@ static void gve_free_control_plane_resources(struct gve_priv *priv)
>  	kvfree(priv->ptype_lut_dqo);
>  	priv->ptype_lut_dqo = NULL;
>  
> -	gve_free_stats_report(priv);
> -	gve_free_notify_blocks(priv);
> +	gve_free_irq_db_indices(priv);
>  	gve_free_counter_array(priv);
> +	gve_free_notify_blocks(priv);
> +	gve_free_stats_report(priv);
>  	gve_free_rss_config_cache(priv);
>  	gve_free_flow_rule_caches(priv);
>  }
> @@ -626,15 +630,18 @@ static int gve_alloc_control_plane_resources(struct gve_priv *priv)
>  	if (err)
>  		return err;
>  	err = gve_alloc_rss_config_cache(priv);
> -	if (err)
> -		goto abort;
> -	err = gve_alloc_counter_array(priv);
>  	if (err)
>  		goto abort;
>  	err = gve_alloc_notify_blocks(priv);
>  	if (err)
>  		goto abort;
>  	err = gve_alloc_stats_report(priv);
> +	if (err)
> +		goto abort;
> +	err = gve_alloc_counter_array(priv);
> +	if (err)
> +		goto abort;
> +	err = gve_alloc_irq_db_indices(priv);
>  	if (err)
>  		goto abort;
>  
> @@ -664,15 +671,9 @@ static int gve_setup_control_plane_resources(struct gve_priv *priv)
>  	const struct gve_ctrl_ops *ops = priv->ctrl_ops;
>  	int err;
>  
> -	err = gve_adminq_configure_device_resources(priv,
> -						    priv->counter_array_bus,
> -						    priv->num_event_counters,
> -						    priv->irq_db_indices_bus,
> -						    priv->num_ntfy_blks);
> -	if (unlikely(err)) {
> -		dev_err(&priv->pdev->dev,
> -			"could not setup device_resources: err=%d\n", err);
> -		err = -ENXIO;
> +	err = ops->request_db_info(priv);
> +	if (err) {
> +		dev_err(&priv->pdev->dev, "Failed to get db info");
>  		return err;
>  	}

[Severity: Low]
Is the missing "\n" here intentional? Without a terminating newline the
printk record stays open for continuation, so unrelated output can be
appended to this line. The message it replaces, and the next dev_err()
in this same function, both terminate and include the error code:

	dev_err(&priv->pdev->dev,
		"Failed to get ptype map: err=%d\n", err);

The message also looks redundant, since the only implementation,
gve_adminq_request_db_info(), already logs the same failure with the
error code before returning -ENXIO.

>  
> @@ -681,7 +682,7 @@ static int gve_setup_control_plane_resources(struct gve_priv *priv)
>  		if (err) {
>  			dev_err(&priv->pdev->dev,
>  				"Failed to get ptype map: err=%d\n", err);
> -			goto deconfigure_device;
> +			goto release_db_resources;
>  		}
>  	}

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260909191136.3811892-1-hramamurthy%40google.com
