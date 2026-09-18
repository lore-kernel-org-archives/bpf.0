Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 812F94A8431;
	Fri, 18 Sep 2026 07:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789718278; cv=none; b=aqvSkt8Zm0yPHpX3D0nsdOo5oYyOlLVc4uh0ji/fjwOSMhd31YamXKCA+uV6uy+7ydskfItVAODJm6W/oOfshSq0qc6kvpcMg5peTv25p6brGpoDZlXYt9p8zrFejAMnTD8GNq8C9Bnrq6zLT9BwIjS+r2EN4OwEEIPcnc6JrQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789718278; c=relaxed/simple;
	bh=eM9TE6rlZW+qXZJZRCn20O3HAxKbTjdpLCAnhb6HnTA=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=amI7J81EiSm+pnpcZn/yzq80S7fqJfUrrsNonplAmgIRZirG9vlQizlr7TQar10b4IAdEsS8rTi8JmpTYkIL5SD1D6pm2ktEGNKs7uf0DFwkokfvRNBa/KDFnKtSgyLFTtREexKp1MqcA88j/GFv+6LZy3FliFOX62HGfPyWI7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CZaWFX96; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CZaWFX96"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB3E71F00893;
	Fri, 18 Sep 2026 07:57:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789718272;
	bh=auBBBPqW4WS18iOgvM8nbgLIyfiyEKUlZm9wiw30US4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=CZaWFX965ekRXGVp9MmEdTmBv0zhuDH/4E4p9Sh4TamQR1qxx5czCSGf5kivyybme
	 rWMjEUmq33fk+Oeq9+pJlPM/WINlE1seNkCqqNFMX0e4Loh9iEWwaxULIu+SdrIdgN
	 rUbzvYiS+TD+9+hQpimf3VPReFM1AWB3iUMQqMONv4W+jX9iMNEPl7YOt2EXOYXF9y
	 3bUWhIEcBlUmZFWlapPBpsr2DqNf00EcVAdqrEaPzvqmBACEJRwKBMwdP6nbup97F/
	 1IHVjzxsIHY+pXfzuJskG4v4MO+wAFIO3O3L5pfXll61lNTTQulOE5PsGKKghZ66+O
	 58HUZQSdoZQjw==
Subject: Re: [PATCH net-next v7 09/12] gve: introduce new methods to handle
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
Date: Fri, 18 Sep 2026 07:57:50 +0000
Message-ID: <178971827030.22033.12345107033294461327@kernel.org>
In-Reply-To: <20260916165533.2187434-10-hramamurthy@google.com>
References: <20260916165533.2187434-10-hramamurthy@google.com>
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

Critical: 0 · High: 0 · Medium: 0 · Low: 1

- [Low] The new kernel-doc for `struct gve_ctrl_ops` understates the
  contract of the two new callbacks and mislabels one as optional-…

--

gve: introduce new methods to handle IRQ doorbells

This adds request_db_info and release_db_resources callbacks to struct
gve_ctrl_ops, moves the counter array and IRQ doorbell index DMA
allocations into their own helpers, and establishes the notify block to
IRQ doorbell index relationship inside the new ops instead of in the
notify block setup path.

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
Does this kernel-doc match what the callbacks actually do?

gve_adminq_request_db_info() registers the event counter array with the
device in addition to the IRQ doorbell indices:

	err = gve_adminq_configure_device_resources(priv,
						    priv->counter_array_bus,
						    priv->num_event_counters,
						    priv->irq_db_indices_bus,
						    priv->num_ntfy_blks);

and gve_adminq_release_db_resources() tears that same registration down
via gve_adminq_deconfigure_device_resources(). This patch removes the only
other place the counter array was registered, from
gve_setup_control_plane_resources(), so the counter array semantics now
live entirely in these ops. The commit message itself says the ops
"encapsulate the configuration of device resources (counter arrays and IRQ
doorbell indices)", which the doc text does not mention.

Also, could the "(AdminQ only)" annotation be misread as "may be NULL"?
Both new callbacks are dereferenced unconditionally:

gve_setup_control_plane_resources()
	err = ops->request_db_info(priv);
	...
release_db_resources:
	ops->release_db_resources(priv);

gve_teardown_control_plane_resources()
	ops->release_db_resources(priv);

so every ops table has to populate them. Today only gve_adminq_ops exists
and it sets both, so nothing breaks, but for the Mailbox ops table this
series is preparing an implementer following the doc literally could set up
doorbells only and leave the counter array unregistered, or leave the
pointer NULL.

> @@ -844,6 +847,8 @@ struct gve_ctrl_ops {
>  	void (*unmap_db_bar)(struct gve_priv *priv);
>  	void (*set_num_queues)(struct gve_priv *priv);
>  	int (*set_num_ntfy_blks)(struct gve_priv *priv);
> +	int (*request_db_info)(struct gve_priv *priv);
> +	void (*release_db_resources)(struct gve_priv *priv);
>  	int (*get_ptype_map)(struct gve_priv *priv);
>  	int (*configure_rss)(struct gve_priv *priv,
>  			     struct ethtool_rxfh_param *param);

[ ... ]

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
> +
> +void gve_adminq_release_db_resources(struct gve_priv *priv)
> +{
> +	int err;
> +
> +	/* Log error in deconfigure device, but don't fail. This is only ever
> +	 * called as a reset is about to be triggered, so it would be redundant
> +	 * to trigger a reset.
> +	 */
> +	err = gve_adminq_deconfigure_device_resources(priv);
> +	if (err)
> +		dev_err(&priv->pdev->dev,
> +			"Could not deconfigure device resources: err=%d\n",
> +			err);
> +}

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260916165533.2187434-1-hramamurthy%40google.com
