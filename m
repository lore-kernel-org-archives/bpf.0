Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 778353B8BC7;
	Fri, 25 Sep 2026 18:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790362561; cv=none; b=GvuE3hsfy9kHcNKbWiko47gvC7hFePp6VjFTyjN4FA9LLgqUv1MYyiGOW8KC2/odjT6Xy3dhpn3o9iH7cO+ip4DyS8+9pmAHpYFaMXNtOS0/A2XNu9hFtLnaVfgFBCWju36sHcBY9WEXfV4P4yyDVSzWHoLN0bIBS2zi/33F0hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790362561; c=relaxed/simple;
	bh=iKrd0+yFZiZlM33+Ed6nMS/sF+DBUAb53J99/61lCuQ=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=T12W/GMFUkhtDLRvx/nE+hwxNULK8zDwcKfejsWib95fTKnH6+Kusou0rUpnTFTJN5ZOZoSo1FNfg9VSJv20ITp1rNhhbY1jnnl3L4MWOLHAets5TNGW+GDJShIqUYC9m9sFcdV+j/AhrsDyMzBLxZarENEHtjHOV4gcQEi3sj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=libqQbVl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="libqQbVl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A99D21F000FF;
	Fri, 25 Sep 2026 18:55:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790362560;
	bh=VZHfcniCQanKr3rg3FuXnJEl8s+jjzU702WD7HYr1Gw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=libqQbVl5Jb8uMZnW2XTCXteaDRha5HrrqWoxsJ/fYQPpM0G8dF8K/RLU5HFoRJRl
	 r6Erqy/u4GbXQwKO71+F+k6RXaNzXcS94p++LCdu9sUqESLp+rTyyF8ztegs2Q4siF
	 vAN32FbDnwOnfd4Olx1uc0ghJqDgj7VmWUUbfkIrif6GHqw8D92dFe10Ei/vmY//26
	 48L2xt0qwtk+rhX2xn+dIhflw4Z1YyJu39pydXta99nMO6O1dpr4CUS3g4e5Sp3CQv
	 rPl2uLSa7XSrzRZnGUW/4Ag8qI1JGFk9qIUyQ6SMevpOBJ1hyPY8gmHVkpYA+2BZ4f
	 GXF6cW5tEWAGQ==
Subject: Re: [PATCH net-next v8 01/12] gve: add struct gve_device_info to hold
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
Date: Fri, 25 Sep 2026 18:55:58 +0000
Message-ID: <179036255814.2160803.6358571892223666195@kernel.org>
In-Reply-To: <20260924185316.2831077-2-hramamurthy@google.com>
References: <20260924185316.2831077-2-hramamurthy@google.com>
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

- [Low] The commit message says the only functional change is that
  gve_set_mtu() "now also validates" the jumbo-frames MTU.
- [Low] The refactor leaves unused state and a stale comment behind.

--

gve: add struct gve_device_info to hold device properties

This commit adds struct gve_device_info to hold the properties negotiated
with the device, in preparation for an upcoming MailboxQ mode.
gve_adminq_describe_device() now fills this structure. gve_init_priv() then
copies the values into gve_priv through gve_set_mtu(), gve_set_mac(),
gve_set_queue_properties() and gve_set_buf_sizes().

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
This isn't a bug, but gve_fill_device_info() never fills in max_tx_queues
or max_rx_queues, and nothing reads them.

gve_set_num_queues() still takes its maximums from priv->tx_cfg.max_queues
and priv->rx_cfg.max_queues, which gve_probe() reads from the register BAR.

Should these fields be dropped until MailboxQ needs them, or should
gve_set_num_queues() use them?

Along the same lines, struct gve_priv still declares:

	bool default_min_ring_size;
	...
	u16 default_num_queues; /* default num queues to set up */

All readers and writers now go through priv->device_info, so these two
fields are always zero. Can they be removed?

The comment in gve_probe() also still names gve_adminq_describe_device()
as a place where features may be set:

	/* Set default and supported features.
	 *
	 * Features might be set in other locations as well (such as
	...

This patch moved the last such write (NETIF_F_NTUPLE) into gve_init_priv().

All three of these still seem to be present at the end of the series.

[ ... ]

> diff --git a/drivers/net/ethernet/google/gve/gve_adminq.c b/drivers/net/ethernet/google/gve/gve_adminq.c
> index f05f4895f4c74..512349c5517f4 100644
> --- a/drivers/net/ethernet/google/gve/gve_adminq.c
> +++ b/drivers/net/ethernet/google/gve/gve_adminq.c

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

> diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/ethernet/google/gve/gve_main.c
> index 9cc343a162712..d3882de584e36 100644
> --- a/drivers/net/ethernet/google/gve/gve_main.c
> +++ b/drivers/net/ethernet/google/gve/gve_main.c

[ ... ]

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

[ ... ]

> +static void gve_set_buf_sizes(struct gve_priv *priv)
> +{
> +	struct gve_device_info *device_info = &priv->device_info;
> +
> +	if (device_info->max_rx_buffer_size)
> +		priv->max_rx_buffer_size = device_info->max_rx_buffer_size;
> +
> +	if (gve_is_dqo(priv) &&
> +	    priv->max_rx_buffer_size > GVE_DEFAULT_RX_BUFFER_SIZE)
> +		priv->rx_cfg.packet_buffer_size = priv->max_rx_buffer_size;
> +
> +	if (device_info->header_buf_size)
> +		priv->header_buf_size = device_info->header_buf_size;
> +}

[Severity: Low]
The commit message says:

  Most of these changes are refactors only, except for one:
  with the introduction of the central struct gve_device_info,
  in AdminQ mode, gve_set_mtu() now also validates the device
  provided mtu value from jumbo frames device option.

Does this cover all the behaviour changes in the patch?

Before this patch, gve_adminq_describe_device() called
gve_set_mtu(priv, descriptor) before gve_enable_supported_features(). That
checked descriptor->mtu against ETH_MIN_MTU. The jumbo frames max_mtu then
overwrote dev->max_mtu without a check.

After this patch, gve_fill_device_info() stores descriptor->mtu in
device_info->max_mtu, and gve_enable_supported_features() overwrites it
with the jumbo value. gve_set_mtu() then checks only that final value.

So when the jumbo frames option is present, descriptor->mtu is not checked
at all. A device that reports descriptor->mtu below 68 together with a
valid jumbo max_mtu used to fail probe, and now it probes. Isn't the check
moved to a different value, rather than added?

There is a second change in gve_set_buf_sizes(). It now copies
max_rx_buffer_size and header_buf_size only when they are non-zero.

Before, a BUFFER_SIZES option that reported packet_buffer_size == 0 set
priv->max_rx_buffer_size to 0. Now the field keeps the
GVE_DEFAULT_RX_BUFFER_SIZE value set in gve_probe(). That changes the
result of checks like this one in gve_set_rx_buf_len_config():

	if (!gve_is_dqo(priv) || priv->max_rx_buffer_size < SZ_4K) {

The v5 changelog note "honor device provided rx buffer size correctly" is
below the --- line, so it won't end up in the git history.

Could the commit message describe both of these changes?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260924185316.2831077-1-hramamurthy%40google.com
