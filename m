Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F2C949B5A3;
	Thu, 10 Sep 2026 22:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789078432; cv=none; b=ffN6E3JFYg9PZdDBaTLdHrL9PuMb4rkoOXJYwLQGa5J2LB23vJtQAZx8TZ7P2v+JCfL1vKiLHceDdyUhRmfFB2Kd8UoXhRFdbSA2X9GEijMAakzJxt/cxm+crLt8FiAyi4gMxbSE7ezQGULHFNUK32pvBeGR2rLawANBRz9oE88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789078432; c=relaxed/simple;
	bh=aVaPhzFJe0kiVgrN+krqPQXtueIVryKDfM0tDSAmv+M=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rwagjaQszuu3mW15KRyWee9h+NdKyObrk3wynq53PvbOzL+S5nWmGRDm/SED3GIZokq9kT3nrAKuWXazQf9R1D6ocscWDJhGWS3jg8ymvRFqys0Dz0HYU9QRezo8oiyNPNuv5VcBN7lNC9EsFa0XE4EILnojD27gtLUliv3EOY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BU65/p1F; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BU65/p1F"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A5FD1F000FF;
	Thu, 10 Sep 2026 22:13:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789078431;
	bh=uhBenbHPmIXUhZifIELN6Fcx9o0WllfIGn7Pt9L8k0U=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=BU65/p1FDRdeUJYG/JyEjNRqeF4taGqUlSUQnm9SDc5Pmwt5Ck2hSC6NWCGO655Rg
	 6BvkBFBiwk2s49S2KfsFbE5oUReMMWYvJS739hNXb2jAYnulbAyw1229lDvPekLIbe
	 YyRNJKfLSnGQgY4GTsc3awrWPe1Ql7WNm/F8pm44rSsUkdtq5Fv/JxI4eXAkb7QnJO
	 lDQ5C8/TeRCLz10He4/g4TfzUsBNQIp+/JQvibirzcfTvH0sGuvo/VggH5YKxh0Ua2
	 WAezkB6S9+a4n6l2uQ7KQAGOv3QtwDkqcZiZ9R+8ksL6qKVZ/et8zz8NdWF2XJOB/K
	 K4yn8m8zBD8IA==
Subject: Re: [PATCH net-next v6 01/12] gve: add struct gve_device_info to hold
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
Date: Thu, 10 Sep 2026 22:13:49 +0000
Message-ID: <178907842956.219967.4077695444710153181@kernel.org>
In-Reply-To: <20260909191136.3811892-2-hramamurthy@google.com>
References: <20260909191136.3811892-2-hramamurthy@google.com>
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

Critical: 0 · High: 0 · Medium: 0 · Low: 2

- [Low] After this patch, struct gve_priv still declares `u16
  default_num_queues; /* default num queues to set up */` (gve.h:856)…
- [Low] Stale comment: gve_probe() still states "Features might be set in
  other locations as well (such as `gve_adminq_describe_device`)."…

--

gve: add struct gve_device_info to hold device properties

This adds struct gve_device_info as a single place to hold the properties
negotiated with the device, converts gve_adminq_describe_device() and its
helpers to fill that structure, and moves the code that applies those
properties to priv/netdev into gve_init_priv().

A couple of questions on leftovers from the conversion.

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
>  		break;

[ ... ]

> @@ -946,77 +949,105 @@ static void gve_enable_supported_features(struct gve_priv *priv,

[ ... ]

>  	if (dev_op_flow_steering &&
>  	    (supported_features_mask & GVE_SUP_FLOW_STEERING_MASK)) {
>  		if (dev_op_flow_steering->max_flow_rules) {
> -			priv->max_flow_rules =
> +			info->max_flow_rules =
>  				be32_to_cpu(dev_op_flow_steering->max_flow_rules);
> -			priv->dev->hw_features |= NETIF_F_NTUPLE;
>  			dev_info(&priv->pdev->dev,
>  				 "FLOW STEERING device option enabled with max rule limit of %u.\n",
> -				 priv->max_flow_rules);
> +				 info->max_flow_rules);
>  		}
>  	}

[Severity: Low]
With this hunk, the NETIF_F_NTUPLE assignment leaves the describe-device
path entirely, so is the comment in gve_probe() now stale?

drivers/net/ethernet/google/gve/gve_main.c:gve_probe() {
	/* Set default and supported features.
	 *
	 * Features might be set in other locations as well (such as
	 * `gve_adminq_describe_device`).
	 */
	dev->hw_features = NETIF_F_HIGHDMA;
	...
}

A grep of gve_adminq.c at this commit shows no remaining write to
priv->dev->hw_features (only dev_err() logging and a read of
priv->dev->features in gve_adminq_create_rx_queue()), since the only such
write moved to gve_init_priv():

	priv->max_flow_rules = device_info->max_flow_rules;
	if (priv->max_flow_rules)
		priv->dev->hw_features |= NETIF_F_NTUPLE;

Should the comment point at gve_init_priv() instead, given a second
describe-device implementation (MailboxQ) is being added on top of this?

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
> @@ -1602,10 +1627,13 @@ void gve_set_num_queues(struct gve_priv *priv)
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

[Severity: Low]
Should the now-unused copies of these fields be dropped from struct
gve_priv in the same patch?

After this conversion, struct gve_priv still declares:

	bool default_min_ring_size;
	...
	u16 default_num_queues; /* default num queues to set up */

but nothing in drivers/net/ethernet/google/gve/ writes or reads either one
any more.  The last writer of priv->default_num_queues was
gve_set_queue_properties(), which became gve_fill_device_info() setting
device_info->default_tx_queues/default_rx_queues, and the last reader is
this gve_set_num_queues() hunk.  Similarly gve_parse_device_option() now
sets priv->device_info.default_min_ring_size and
gve_enable_supported_features() reads info->default_min_ring_size.

A grep at this commit only finds the declarations:

	drivers/net/ethernet/google/gve/gve.h
	  822:	bool default_min_ring_size;    /* gve_device_info */
	  849:	bool default_min_ring_size;    /* gve_priv, no users */
	  856:	u16 default_num_queues;        /* gve_priv, no users */

Since the leftover gve_priv fields share names with live gve_device_info
members, could later code (for instance the MailboxQ path) read
priv->default_num_queues or priv->default_min_ring_size and silently get
0/false?

> diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/ethernet/google/gve/gve_main.c
> index 9cc343a162712..d3882de584e36 100644
> --- a/drivers/net/ethernet/google/gve/gve_main.c
> +++ b/drivers/net/ethernet/google/gve/gve_main.c

[ ... ]

> @@ -2507,12 +2523,34 @@ static int gve_init_priv(struct gve_priv *priv, bool skip_describe_device)
> +	priv->max_flow_rules = device_info->max_flow_rules;
> +	if (priv->max_flow_rules)
> +		priv->dev->hw_features |= NETIF_F_NTUPLE;
> +

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260909191136.3811892-1-hramamurthy%40google.com
