Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0388F47C107;
	Fri,  2 Oct 2026 10:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790935593; cv=none; b=ES/FTqu9D+T3NTjQGLiWVMpSSZiV715KBCww0vuoJgOqURbc1SS4o7870ZcaFKh+L8vzgLCfQQOLQ9MhNOKkKnVnG4nI8YesZOo496JW0/x5o8WfPKQM820eX2GFAT+mAbWTyUvPWsx1xMw/KZ6QK3UHa5aQrqkJ47jeotTHjF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790935593; c=relaxed/simple;
	bh=F13b0R0F50Ki9Kao4aki7gMCaSgvUZfux0cKYfTJHwE=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=U3RPb6jDthRq8IxT8tkz6l4Tg2gL9Aeue7iVjnCKDmnBlwVerI+lyI79mtID4ugZZ8niyIaNBZTo4Yo5JA3prU8xSOXH43NGFp2T7UP0eqMm79xdbVgU5ZAqEiYDVLqUGE5I5eht5f7MSxLpAltnbInuUIGTeW5ZEZStCJmerNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i09l51kW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i09l51kW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FCB41F00893;
	Fri,  2 Oct 2026 10:06:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790935591;
	bh=VvJGGKKpGgk1tFymTpWUCzgDeSqJMbrn9SKrYFWD9G8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=i09l51kWYF1bbliM2qMkNVOgwE3WxX7qkw4KUS8qRaE3/Tpal3lrEYfhsfNmdjIQH
	 BmPEt/RI0kgl2bwopvlpOS6164K7t/iCbxJ0eFRstoBfAAdGO2A+WKeLqjksQ0+FrQ
	 3DYHIuvW4nyNSs1bA5lo7+B40OcBToW1SgZk7EabFmGa55h9Mw/s4aliyktT/HRyAL
	 a6ozORcwky3QSAHMUwdLHyhhHAaBfZe4vxw6KXvOjxIkKZAdMY9BKIHCiy9/ZTmXmL
	 vRe+7PZUgKYJ1RIZnXBQw3bp34nnlnyIqvJpA33LHvyJ2lTHa/sfu9UsVJ9j7n1C/o
	 PQezQQIPsr03w==
Subject: Re: [PATCH net-next v9 01/12] gve: add struct gve_device_info to hold
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
Date: Fri, 02 Oct 2026 10:06:29 +0000
Message-ID: <179093558968.434549.7290640298828217045@kernel.org>
In-Reply-To: <20260930190428.1130007-2-hramamurthy@google.com>
References: <20260930190428.1130007-2-hramamurthy@google.com>
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

- [Low] Dead and unused struct fields after the refactor.
- [Low] Stale comment in gve_probe().
- [Low] The commit message does not mention a behaviour change in
  gve_set_buf_sizes().

--

gve: add struct gve_device_info to hold device properties

This patch adds struct gve_device_info to hold the properties negotiated
with the device. gve_adminq_describe_device() now fills that struct
instead of writing directly into gve_priv. The helpers that copy these
properties into priv and the netdev now run from gve_init_priv(), so the
upcoming MailboxQ mode can reuse them.

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
Are max_tx_queues and max_rx_queues meant to be used somewhere?
gve_fill_device_info() doesn't set them, and nothing reads them.

gve_set_num_queues() still takes its limits from priv->tx_cfg.max_queues
and priv->rx_cfg.max_queues. gve_probe() reads those from BAR0:

	priv->tx_cfg.max_queues =
		min_t(int, priv->tx_cfg.max_queues, priv->num_ntfy_blks / 2);

If a later path such as MailboxQ fills device_info->max_*_queues, would
that value be ignored without any warning?

Every reader and writer of these gve_priv fields has also moved to
device_info, but the old declarations are still there:

struct gve_priv {
	...
	bool default_min_ring_size;
	...
	u16 default_num_queues; /* default num queues to set up */
	...
};

Nothing assigns them any more, so they are always 0. The comment still
describes default_num_queues as if it holds a real value. Could these
fields be removed as part of this change?

> +	u16 default_tx_ring_size;

[ ... ]

> diff --git a/drivers/net/ethernet/google/gve/gve_adminq.c b/drivers/net/ethernet/google/gve/gve_adminq.c
> index f05f4895f4c74..512349c5517f4 100644
> --- a/drivers/net/ethernet/google/gve/gve_adminq.c
> +++ b/drivers/net/ethernet/google/gve/gve_adminq.c

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

[Severity: Low]
This isn't a bug, but NETIF_F_NTUPLE is now set in gve_init_priv(), so
gve_adminq_describe_device() no longer changes netdev features.

The comment above the netdev feature setup in gve_probe() still names
gve_adminq_describe_device as another place where features might be set.
Should it name gve_init_priv() instead?

[ ... ]

> diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/ethernet/google/gve/gve_main.c
> index 9cc343a162712..d3882de584e36 100644
> --- a/drivers/net/ethernet/google/gve/gve_main.c
> +++ b/drivers/net/ethernet/google/gve/gve_main.c
> @@ -2398,57 +2398,71 @@ static const struct xdp_metadata_ops gve_xdp_metadata_ops = {

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
The commit message leaves out a behaviour change here. It says the only
change that isn't a refactor is the MTU validation.

Before this patch, gve_enable_supported_features() copied the
BUFFER_SIZES option into priv whenever the option was present, zeros
included:

	priv->max_rx_buffer_size =
		be16_to_cpu(dev_op_buffer_sizes->packet_buffer_size);
	priv->header_buf_size =
		be16_to_cpu(dev_op_buffer_sizes->header_buffer_size);

With the new nonzero guards, a device that sends packet_buffer_size == 0
now leaves priv->max_rx_buffer_size at the default that gve_probe() sets:

	priv->max_rx_buffer_size = GVE_DEFAULT_RX_BUFFER_SIZE;

Before the patch it would have been 0. This value is the upper limit
used when choosing the DQO packet_buffer_size and when checking ethtool
rx-buf-len.

For header_buf_size, a negotiated 0 can no longer clear a nonzero value
already in priv. Today this code in gve_init_priv() only runs from
probe, where priv is zeroed, so nothing changes yet. It still doesn't
fit the goal of device_info being the one source of negotiated state.

Should the guards be dropped, or should the commit message mention this
change?

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260930190428.1130007-1-hramamurthy%40google.com
