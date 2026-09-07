Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BACAC15E8B;
	Mon,  7 Sep 2026 00:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788739446; cv=none; b=b/o9r8abinlkExWABYtLzoiIqWvuX617tVIYNLzVjVGMR9r8KdS0pz1jdRUExqXqSoHYk2erjhriadCDlPigPU6YjcXauS6026odTi7y4xvJEB68NL6F8HzaPIq9rg2UkUED1oivByj8ELtkWT5Y52pi1XUgtjIKpQvovNCwrU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788739446; c=relaxed/simple;
	bh=6x43Rbn8+5CZxYE2IpxCBwBEl9sSznn/hzAIiIuY3PY=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZkXmUHafajH0gWavni2vG1vlMmsWTzwTdGjy1H28J3S1JLIBDQAU/kT+8dhfaruMiOU8FrQzBZC/YA6iomAgtdrjTtzPgd16f/RZB5Qrd8/cvn7jABO/NuPJPNScy3tuEaUl6c7MfetOTQa6ptAcxpcoFEs3Gd1M2e7HGghynFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IjDW1qTZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IjDW1qTZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03AC21F00A3E;
	Mon,  7 Sep 2026 00:04:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788739444;
	bh=YDdlF+7dXxwUPGzVqGGqD2fkqBfXKvMIltAZTnmqLxg=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=IjDW1qTZcUPpCYJ7EdAoq+TgfDzPJ5mMAH/Rc52fS3SHluQWpWe5P6+QK5cCkU2/t
	 X37Nj/fFZC17n1PbHnIMdNpGRkoeMKalzBkrjLBB0vfcODxpB6A867eETt3M1rtD8B
	 FtI70bmC34e8C/gMQr8GLR3o5R4JBPcDaKJeqVYpgm/sX8ZS+JHmNhWkuI3/1xVINX
	 cCcpsCY8Ht5bf7Np/SeWFOxyb4JiBfDGmgp6sJSE886uHWFvY+TONjJhtIUOo8Jtdk
	 Pd4u/M9Kymm50io5Exg7LVV7TjeLGyP1FTLURL8Spdv5isihfoqyTQQUl6mB9EyxSz
	 vzq+P1+bVyVYg==
Subject: Re: [PATCH net-next v5 09/12] gve: introduce new methods to handle
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
Date: Mon, 07 Sep 2026 00:04:02 +0000
Message-ID: <178873944256.219967.7449126605108572079@kernel.org>
In-Reply-To: <20260903215606.31633-10-hramamurthy@google.com>
References: <20260903215606.31633-10-hramamurthy@google.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 4 potential
issue(s) to consider:

Critical: 0 · High: 0 · Medium: 1 · Low: 3

- [Medium] The commit message does not describe what the patch actually
  does.
- [Low] The patch adds `gve_ntfy_to_msix_idx()` in gve.h — an identity
  function that ignores its `priv` argument and returns `ntfy_blk_idx`…
- [Low] The replacement error log in
  `gve_setup_control_plane_resources()`…
- [Low] The new kernel-doc for `struct gve_ctrl_ops` (gve.h:837-839)
  describes the two new callbacks purely in terms of doorbells —…

--

gve: introduce new methods to handle IRQ doorbells

This adds request_db_info and release_db_resources callbacks to
struct gve_ctrl_ops, wires the AdminQ implementations into
gve_setup_control_plane_resources() and
gve_teardown_control_plane_resources(), and moves the irq_db_indices DMA
buffer allocation into new helpers in gve_main.c.

A few questions below about the changelog and some of the hunks.

>     Introduce `request_db_info` and `release_db_resources` to
>     `struct gve_ctrl_ops`. These encapsulate the configuration of device
>     resources (counter arrays and IRQ doorbell indices) which vary between
>     Admin Queue and Mailbox modes. Registration and de-registratino of IRQ
>     dorrbell indices with the device will be managed by these new methods
>     instead of occurring directly in notify_block setup/teardown methods.
>     Similarly, GQ ring counters will be managed in `request_db_info`.

[Severity: Medium]
Does the changelog match what the diff does?

"Registration and de-registratino of IRQ dorrbell indices with the device
will be managed by these new methods instead of occurring directly in
notify_block setup/teardown methods" — registration with the device was
not in the notify-block methods before this patch. As the diff itself
shows, gve_setup_control_plane_resources() already called
gve_adminq_configure_device_resources() and
gve_teardown_control_plane_resources() already called
gve_adminq_deconfigure_device_resources(). The new callbacks are invoked
from those same two functions.

What actually leaves gve_alloc_notify_blocks()/gve_free_notify_blocks()
is the dma_alloc_coherent()/dma_free_coherent() of priv->irq_db_indices,
which moves into the new gve_alloc_irq_db_indices()/
gve_free_irq_db_indices() helpers called from
gve_alloc_control_plane_resources()/gve_free_control_plane_resources() —
not into the new ops — plus the per-block

	block->irq_db_index = &priv->irq_db_indices[i].index;

assignment, which moves into gve_adminq_request_db_info().

"Similarly, GQ ring counters will be managed in `request_db_info`" also
looks stale relative to the code. Per the v3 changelog the counter array
allocation was moved back into gve_alloc_control_plane_resources(), and
gve_adminq_request_db_info() only forwards priv->counter_array_bus to the
device exactly as the removed code did.

Two further changes in the diff are not mentioned at all: the new
gve_ntfy_to_msix_idx() indirection, and the reordering of the counter
array and irq db indices allocation and free relative to the notify
blocks and the stats report. Could the changelog be updated to describe
these?

Also, "de-registratino" and "dorrbell" are typos.

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
Should this kernel-doc also mention the event counter array?

The only implementation does more than doorbells:
gve_adminq_request_db_info() passes priv->counter_array_bus and
priv->num_event_counters into gve_adminq_configure_device_resources(),
and gve_adminq_release_db_resources() calls
gve_adminq_deconfigure_device_resources(), which revokes the device's
hold on the counter array as well as the doorbell index array. No other
hook in struct gve_ctrl_ops covers the counter array, so a future
Mailbox implementer following this description would not know it has to
register and revoke priv->counter_array.

The "(AdminQ only)" annotation on release_db_resources also reads as
optional, but both call sites dereference it unconditionally — the
release_db_resources: label in gve_setup_control_plane_resources() and
the call in gve_teardown_control_plane_resources() — so every
implementation of the table must provide it.

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
What is this helper for in this patch?  It returns its argument unchanged
and ignores priv, and it is still an identity function at the end of the
series.  It is also unrelated to the doorbell-info ops the changelog
describes, so a reader cannot tell what mapping is intended later or
verify that a future non-identity version will be correct.

Could it be introduced in the patch that actually needs a non-trivial
mapping, or at least described in the changelog?

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
> index 619ef46a7b30a..a160d36f718b9 100644
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

> @@ -528,13 +533,14 @@ static void gve_teardown_notify_blocks(struct gve_priv *priv)
>  
>  	for (i = 0; i < priv->num_ntfy_blks; i++) {
>  		struct gve_notify_block *block = &priv->ntfy_blocks[i];
> +		int msix_idx = gve_ntfy_to_msix_idx(priv, i);
>  
>  		if (!block->irq_requested)
>  			continue;
>  
> -		irq_set_affinity_hint(priv->msix_vectors[i].vector,
> +		irq_set_affinity_hint(priv->msix_vectors[msix_idx].vector,
>  				      NULL);
> -		free_irq(priv->msix_vectors[i].vector, block);
> +		free_irq(priv->msix_vectors[msix_idx].vector, block);
>  		block->irq = 0;
>  		block->irq_requested = false;
>  	}
> @@ -563,12 +569,11 @@ static int gve_setup_notify_blocks(struct gve_priv *priv)
>  	}
>  	priv->mgmt_irq_requested = true;
>  
> -	/* Setup the other blocks - the first n-1 vectors */
>  	node_mask = gve_get_node_mask(priv);
>  	cur_cpu = cpumask_first(node_mask);
>  	for (i = 0; i < priv->num_ntfy_blks; i++) {
>  		struct gve_notify_block *block = &priv->ntfy_blocks[i];
> -		int msix_idx = i;
> +		int msix_idx = gve_ntfy_to_msix_idx(priv, i);
>  
>  		snprintf(block->name, sizeof(block->name), "gve-ntfy-blk%d@pci:%s",
>  			 i, pci_name(priv->pdev));
> @@ -578,14 +583,13 @@ static int gve_setup_notify_blocks(struct gve_priv *priv)
>  				  IRQF_NO_AUTOEN, block->name, block);
>  		if (err) {
>  			dev_err(&priv->pdev->dev,
> -				"Failed to receive msix vector %d\n", i);
> +				"Failed to receive msix vector %d\n", msix_idx);

[Severity: Low]
Is this part of the same intended change?  Two unrelated bits ride along
in this hunk: the "/* Setup the other blocks - the first n-1 vectors */"
comment describing the vector layout is dropped, and this error message
now prints msix_idx rather than the notify block index i, while
block->name a few lines above is still built from i.  With
gve_ntfy_to_msix_idx() being an identity function the printed value is
unchanged today, but the message no longer names the notify block that
failed.

>  			goto abort;
>  		}
>  		block->irq = priv->msix_vectors[msix_idx].vector;
>  		block->irq_requested = true;
>  		irq_set_affinity_and_hint(block->irq,
>  					  cpumask_of(cur_cpu));
> -		block->irq_db_index = &priv->irq_db_indices[i].index;
>  
>  		cur_cpu = cpumask_next(cur_cpu, node_mask);
>  		/* Wrap once CPUs in the node have been exhausted, or when

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

[Severity: Low]
Is the missing '\n' here intentional?  Without it the message stays in
the printk continuation buffer and the next unrelated kernel message can
end up spliced onto the same line.

The new text also drops the error code that the removed message carried
("could not setup device_resources: err=%d\n"), and duplicates the log
that gve_adminq_request_db_info() already emits for the same failure:

	if (unlikely(err)) {
		dev_err(&priv->pdev->dev,
			"could not setup device_resources: err=%d\n", err);
		return -ENXIO;
	}

Would dropping this dev_err(), or adding '\n' plus err=%d, be preferable?

>  		return err;
>  	}
>  
> @@ -681,7 +682,7 @@ static int gve_setup_control_plane_resources(struct gve_priv *priv)
>  		if (err) {
>  			dev_err(&priv->pdev->dev,
>  				"Failed to get ptype map: err=%d\n", err);
> -			goto deconfigure_device;
> +			goto release_db_resources;
>  		}
>  	}
>  
> @@ -711,8 +712,8 @@ static int gve_setup_control_plane_resources(struct gve_priv *priv)
>  
>  teardown_clock:
>  	gve_teardown_clock(priv);
> -deconfigure_device:
> -	gve_adminq_deconfigure_device_resources(priv);
> +release_db_resources:
> +	ops->release_db_resources(priv);
>  	return err;
>  }
>  
> @@ -745,12 +746,7 @@ static void gve_teardown_control_plane_resources(struct gve_priv *priv)
>  			dev_err(&priv->pdev->dev,
>  				"Failed to detach stats report: err=%d\n", err);
>  		gve_teardown_clock(priv);
> -
> -		err = gve_adminq_deconfigure_device_resources(priv);
> -		if (err)
> -			dev_err(&priv->pdev->dev,
> -				"Could not deconfigure device resources: err=%d\n",
> -				err);
> +		ops->release_db_resources(priv);
>  	}
>  
>  	gve_clear_device_resources_ok(priv);

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260903215606.31633-1-hramamurthy%40google.com
