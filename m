Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AFE22E401;
	Mon,  7 Sep 2026 00:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788739436; cv=none; b=dKS63NzrMvysdXe+u23QE7jV6z0OA4jRHDR41ctiyKFNbgdy5zm61r9+APTtY+agfub78lIivElrxKfwgH4b1/V377yrKAhS9raQ7+vK3rKmVZcfjYoIW2UJABGoZ1pN1Som2k8QFkN+4vHjewYF9Bm0CXCt3sNHO9pYO1nZIAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788739436; c=relaxed/simple;
	bh=WC5YPFMgHVtwDE7hem+m0waMrMTakwDcFX80oG20pms=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mwoU5gocpgzLhAoIeRQE08UaevBiXkxMLkuoymS7LtVEpPA+XlFc6fHCmuGn3y82uw+t4wWXtncQ1jIbpKWjmwH2S3kGsweYNtwQU6alhiM9XZ0hId8ZBkc/+9ZmCiSlMkzG6wF2/Vw1u9RHeue3uO/avfF3Ao+Rht5vnZvcUWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bl6qqQSR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bl6qqQSR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84C5C1F00A3A;
	Mon,  7 Sep 2026 00:03:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788739434;
	bh=ECOrYA0cpj6y5Jadj+BhOX8T+CCQ8iodDMe4wWyjnNU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Bl6qqQSRbwZ8pYJkivIyyIteS0GEy/Kq4kbkPsJqBQduNCWA8byFhMk9JytkbyYwq
	 OYdnyrXaoLYsN6zC2iUcY/fLhJWEi+wknICbcLGGmasMCFBzqLEsMV/ORHBUMibo+A
	 ttflt+i8AGzceBWqkIfgG3J9VbI40dyI5OK/7vylvL7fP64Y04LeGCfNSjoiJUIXvQ
	 WC65WdZDGtFa1z4H+pkwitq+uwI+3dDc+IRwZat8A/u5TpuKvaHHMAfT5+b5orQkX9
	 z+qb33EmuWPwtfu7EPA36uizSM9Njcfb+X490GWWexfKn0yGlNdy966Ysft+SfreK1
	 S069sacahgDJg==
Subject: Re: [PATCH net-next v5 01/12] gve: add struct gve_device_info to hold
 device properties
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
Date: Mon, 07 Sep 2026 00:03:53 +0000
Message-ID: <178873943304.219967.4275641978466508716@kernel.org>
In-Reply-To: <20260903215606.31633-2-hramamurthy@google.com>
References: <20260903215606.31633-2-hramamurthy@google.com>
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

- [Medium] The ETH_MIN_MTU validation now applies to a different value
  than before, contradicting the commit message claim that these changes…
- [Low] `struct gve_priv` still declares `bool default_min_ring_size;`
  (drivers/net/ethernet/google/gve/gve.h:849) and `u16…
- [Low] The newly added `struct gve_device_info` declares `u16
  max_tx_queues;` and `u16 max_rx_queues;`…
- [Low] The comment above the netdev feature initialization in
  `gve_probe()` (drivers/net/ethernet/google/gve/gve_main.c, target…

--

gve: add struct gve_device_info to hold device properties

This adds struct gve_device_info to hold the properties negotiated with
the device, converts gve_adminq_describe_device() and its helpers to fill
that structure, and moves the code that applies those properties to priv
into gve_init_priv().  The commit message states the changes are refactors
only with no functional change.

> diff --git a/drivers/net/ethernet/google/gve/gve.h b/drivers/net/ethernet/google/gve/gve.h
> index c280ff35ee771..021adb9108dff 100644
> --- a/drivers/net/ethernet/google/gve/gve.h
> +++ b/drivers/net/ethernet/google/gve/gve.h
> @@ -797,6 +797,34 @@ struct gve_ptp {
>  	struct gve_priv *priv;
>  };
>  
> +struct gve_device_info {
> +	enum gve_queue_format queue_format;
> +	u16 default_tx_queues;
> +	u16 default_rx_queues;
> +	u16 max_tx_queues;
> +	u16 max_rx_queues;

[Severity: Low]
Who fills in max_tx_queues and max_rx_queues?  gve_fill_device_info() in
gve_adminq.c sets tx_pages_per_qpl, max_registered_pages,
num_event_counters, mac, max_mtu, default_tx/rx_queues and the four
ring-size fields, but never these two, and nothing reads them either.

Meanwhile the one consumer that needs device queue maxima,
gve_set_num_queues(), still derives them from priv->tx_cfg.max_queues and
priv->rx_cfg.max_queues (read from the BAR registers in gve_probe()) while
this patch converts the defaults to come from device_info:

	priv->tx_cfg.max_queues =
		min_t(int, priv->tx_cfg.max_queues, priv->num_ntfy_blks / 2);
	...
	if (device_info->default_tx_queues > 0)
		priv->tx_cfg.num_queues = min_t(int,
						device_info->default_tx_queues,
						priv->tx_cfg.num_queues);

Would it be clearer to either populate the two fields in
gve_fill_device_info() and have gve_set_num_queues() use them, or drop them
until there is a producer?  As it stands a later MailboxQ consumer reading
device_info->max_tx_queues in AdminQ mode would see 0.

> +	u16 default_tx_ring_size;
> +	u16 default_rx_ring_size;
> +	u16 max_tx_ring_size;
> +	u16 max_rx_ring_size;
> +	u16 min_tx_ring_size;
> +	u16 min_rx_ring_size;
> +	u16 max_mtu;
> +	u8 mac[ETH_ALEN];
> +	u16 max_rx_buffer_size;
> +	u16 header_buf_size;
> +	u32 max_flow_rules;
> +	u16 rss_key_size;
> +	u16 rss_lut_size;
> +	u16 tx_pages_per_qpl;
> +	u16 num_event_counters;
> +	u64 max_registered_pages;
> +	bool default_min_ring_size;
> +	bool nic_timestamp_supported;
> +	bool modify_ring_size_enabled;
> +	bool cache_rss_config;
> +};
> +

[ ... ]

> diff --git a/drivers/net/ethernet/google/gve/gve_adminq.c b/drivers/net/ethernet/google/gve/gve_adminq.c
> index f05f4895f4c74..512349c5517f4 100644
> --- a/drivers/net/ethernet/google/gve/gve_adminq.c
> +++ b/drivers/net/ethernet/google/gve/gve_adminq.c

[ ... ]

> @@ -190,7 +190,7 @@ void gve_parse_device_option(struct gve_priv *priv,
>  
>  		/* device has not provided min ring size */
>  		if (option_length == GVE_DEVICE_OPTION_NO_MIN_RING_SIZE)
> -			priv->default_min_ring_size = true;
> +			priv->device_info.default_min_ring_size = true;

[Severity: Low]
Should the now-orphaned copies in struct gve_priv be removed in the same
patch?  This was the only writer of priv->default_min_ring_size, and
gve_enable_supported_features() now reads info->default_min_ring_size, so
gve.h still carries

	bool default_min_ring_size;

with no writer and no reader.

The same applies to priv->default_num_queues: gve_set_queue_properties() in
gve_main.c no longer assigns it and gve_set_num_queues() now reads
device_info->default_tx_queues / default_rx_queues, yet gve.h keeps

	u16 default_num_queues; /* default num queues to set up */

Both priv fields stay 0/false forever after this change, and the comment
describes behaviour no code implements.  A follow-on MailboxQ patch reading
priv->default_num_queues (always 0, meaning "no default") or
priv->default_min_ring_size (always false, meaning "device provided
minimums") would get the opposite of what the device reported.

>  		break;
>  	case GVE_DEV_OPT_ID_FLOW_STEERING:
>  		if (option_length < sizeof(**dev_op_flow_steering) ||

[ ... ]

> @@ -946,77 +949,105 @@ static void gve_enable_supported_features(struct gve_priv *priv,
>  					  const struct gve_device_option_modify_ring
>  					  *dev_op_modify_ring)
>  {
> +	struct gve_device_info *info = &priv->device_info;
> +
>  	/* Before control reaches this point, the page-size-capped max MTU from
>  	 * the gve_device_descriptor field has already been stored in
> -	 * priv->dev->max_mtu. We overwrite it with the true max MTU below.
> +	 * device_info->max_mtu. We overwrite it with the true max MTU below.
>  	 */
>  	if (dev_op_jumbo_frames &&
>  	    (supported_features_mask & GVE_SUP_JUMBO_FRAMES_MASK)) {
>  		dev_info(&priv->pdev->dev,
>  			 "JUMBO FRAMES device option enabled.\n");
> -		priv->dev->max_mtu = be16_to_cpu(dev_op_jumbo_frames->max_mtu);
> +		info->max_mtu = be16_to_cpu(dev_op_jumbo_frames->max_mtu);
>  	}

[ ... ]

>  	if (dev_op_flow_steering &&
>  	    (supported_features_mask & GVE_SUP_FLOW_STEERING_MASK)) {
>  		if (dev_op_flow_steering->max_flow_rules) {
> -			priv->max_flow_rules =
> +			info->max_flow_rules =
>  				be32_to_cpu(dev_op_flow_steering->max_flow_rules);
> -			priv->dev->hw_features |= NETIF_F_NTUPLE;

[Severity: Low]
Does this leave the comment in gve_probe() pointing at the wrong function?
gve_main.c still says:

	/* Set default and supported features.
	 *
	 * Features might be set in other locations as well (such as
	 * `gve_adminq_describe_device`).
	 */
	dev->hw_features = NETIF_F_HIGHDMA;

After this change gve_adminq_describe_device() and
gve_enable_supported_features() only record properties into
struct gve_device_info, and the NETIF_F_NTUPLE update lives in
gve_init_priv().  Should the comment reference gve_init_priv() instead?

>  			dev_info(&priv->pdev->dev,
>  				 "FLOW STEERING device option enabled with max rule limit of %u.\n",
> -				 priv->max_flow_rules);
> +				 info->max_flow_rules);
>  		}
>  	}

[ ... ]

> @@ -1097,18 +1129,9 @@ int gve_adminq_describe_device(struct gve_priv *priv)
>  			 "Driver is running with GQI QPL queue format.\n");
>  	}
>  
> +	gve_fill_device_info(priv, descriptor);
>  	gve_set_default_rss_sizes(priv);
>  
> -	err = gve_set_mtu(priv, descriptor);
> -	if (err)
> -		goto free_device_descriptor;
> -
> -	priv->num_event_counters = be16_to_cpu(descriptor->counters);
> -
> -	gve_set_mac(priv, descriptor);
> -
> -	gve_set_queue_properties(priv, descriptor);
> -
>  	gve_enable_supported_features(priv, supported_features_mask,
>  				      dev_op_jumbo_frames, dev_op_dqo_qpl,
>  				      dev_op_buffer_sizes, dev_op_flow_steering,

[ ... ]

> @@ -1595,6 +1618,8 @@ int gve_set_num_ntfy_blks(struct gve_priv *priv)
>  
>  void gve_set_num_queues(struct gve_priv *priv)
>  {
> +	struct gve_device_info *device_info = &priv->device_info;
> +
>  	priv->tx_cfg.max_queues =
>  		min_t(int, priv->tx_cfg.max_queues, priv->num_ntfy_blks / 2);
>  	priv->rx_cfg.max_queues =
> @@ -1602,10 +1627,13 @@ int gve_set_num_ntfy_blks(struct gve_priv *priv)
>  
>  	priv->tx_cfg.num_queues = priv->tx_cfg.max_queues;
>  	priv->rx_cfg.num_queues = priv->rx_cfg.max_queues;
> -	if (priv->default_num_queues > 0) {
> -		priv->tx_cfg.num_queues = min_t(int, priv->default_num_queues,
> +	if (device_info->default_tx_queues > 0)
> +		priv->tx_cfg.num_queues = min_t(int,
> +						device_info->default_tx_queues,
>  						priv->tx_cfg.num_queues);
> -		priv->rx_cfg.num_queues = min_t(int, priv->default_num_queues,
> +
> +	if (device_info->default_rx_queues > 0)
> +		priv->rx_cfg.num_queues = min_t(int,
> +						device_info->default_rx_queues,
>  						priv->rx_cfg.num_queues);
> -	}
>  }

[ ... ]

> diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/ethernet/google/gve/gve_main.c
> index 9cc343a162712..d3882de584e36 100644
> --- a/drivers/net/ethernet/google/gve/gve_main.c
> +++ b/drivers/net/ethernet/google/gve/gve_main.c

[ ... ]

> -void gve_set_queue_properties(struct gve_priv *priv,
> -			      struct gve_device_descriptor *descriptor)
> +static void gve_set_queue_properties(struct gve_priv *priv)
>  {
> -	/* set default descriptor counts */
> -	gve_set_default_desc_cnt(priv, descriptor);
> +	struct gve_device_info *device_info = &priv->device_info;
>  
> -	priv->max_registered_pages = be64_to_cpu(descriptor->max_registered_pages);
> -	priv->tx_pages_per_qpl = be16_to_cpu(descriptor->tx_pages_per_qpl);
> -	priv->default_num_queues = be16_to_cpu(descriptor->default_num_queues);
> +	gve_set_desc_cnt(priv);
> +	priv->max_registered_pages = device_info->max_registered_pages;
> +	priv->tx_pages_per_qpl = device_info->tx_pages_per_qpl;
>  }
>  
> -int gve_set_mtu(struct gve_priv *priv,
> -		struct gve_device_descriptor *descriptor)
> +static int gve_set_mtu(struct gve_priv *priv)
>  {
> +	struct gve_device_info *device_info = &priv->device_info;
>  	u16 mtu;
>  
> -	mtu = be16_to_cpu(descriptor->mtu);
> +	mtu = device_info->max_mtu;
>  	if (mtu < ETH_MIN_MTU) {
>  		dev_err(&priv->pdev->dev, "MTU %d below minimum MTU\n", mtu);
>  		return -EINVAL;
>  	}
>  	priv->dev->max_mtu = mtu;
> +	priv->dev->mtu = mtu;
>  
>  	return 0;
>  }

[Severity: Medium]
Is the ETH_MIN_MTU check still validating the same value?  The commit
message says:

    These changes are refactors only, no functional change.

Before this patch, gve_adminq_describe_device() called
gve_set_mtu(priv, descriptor), which checked be16_to_cpu(descriptor->mtu)
and returned -EINVAL before gve_enable_supported_features() could overwrite
priv->dev->max_mtu from the JUMBO_FRAMES option, and the jumbo value itself
was never re-checked.

Now gve_fill_device_info() stores descriptor->mtu into
device_info->max_mtu unchecked, gve_enable_supported_features() may
overwrite it with dev_op_jumbo_frames->max_mtu, and gve_init_priv() checks
whatever value survived.

So two device-supplied combinations change outcome:

  descriptor->mtu < ETH_MIN_MTU plus a valid jumbo max_mtu:
    probe used to fail with -EINVAL, now succeeds.

  valid descriptor->mtu plus a JUMBO_FRAMES option advertising
  max_mtu < ETH_MIN_MTU (for example 0):
    probe used to succeed and register the netdev, now fails with -EINVAL
    and the device is unusable.

The end of the series still validates device_info->max_mtu, so this is not
restored by a later patch.  Could the commit message mention the moved
validation point, or could the check be kept on the descriptor MTU?

> -void gve_set_mac(struct gve_priv *priv,
> -		 struct gve_device_descriptor *descriptor)
> +static void gve_set_mac(struct gve_priv *priv)
>  {
> +	struct gve_device_info *device_info = &priv->device_info;
>  	u8 *mac;
>  
> -	mac = descriptor->mac;
> +	mac = device_info->mac;
>  	eth_hw_addr_set(priv->dev, mac);
>  	dev_info(&priv->pdev->dev, "MAC addr: %pM\n", mac);
>  }
>  

[ ... ]

> @@ -2507,12 +2523,34 @@ static int gve_init_priv(struct gve_priv *priv, bool skip_describe_device)
>  		netif_set_tso_max_size(priv->dev, GVE_DQO_TX_MAX);
>  	}
>  
> -	priv->dev->mtu = priv->dev->max_mtu;
> +	if (gve_set_mtu(priv)) {
> +		err = -EINVAL;
> +		goto err;
> +	}
> +
> +	priv->num_event_counters = device_info->num_event_counters;
> +
> +	gve_set_mac(priv);
> +
> +	gve_set_queue_properties(priv);
> +	priv->modify_ring_size_enabled = device_info->modify_ring_size_enabled;
> +
> +	gve_set_buf_sizes(priv);
> +
> +	priv->max_flow_rules = device_info->max_flow_rules;
> +	if (priv->max_flow_rules)
> +		priv->dev->hw_features |= NETIF_F_NTUPLE;

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260903215606.31633-1-hramamurthy%40google.com
