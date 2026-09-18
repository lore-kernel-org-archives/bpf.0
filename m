Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8F473B1022;
	Fri, 18 Sep 2026 07:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789718270; cv=none; b=FJpHOvWjs3m+fx003Ejgr/eccjlRUK4XXpBib9NOgsaPX0xbvk8404Ai4h9prb2UTrSbnDQzaTIcoprYOdsi+lVZVlNmEbKKPFiVjRGCP/MiHr0+pVQLBwR30sodyKGrG0taC5XWSO158arEy+5OOqKH7h5Ng0YRXfktLKCfptY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789718270; c=relaxed/simple;
	bh=MMR69YaO+zXaquHTr37sbAjRaYia7zGEOXc1PyzZ+wo=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=S8J98f4k/Sv2wSTHtVDQW54YyJy+q5m7KXYjdXiCCNmYobfSRD2yvBPz5PO18YeTbHx7M2PsPZ15UiFt2mMwA+TFJ75egjKA8h2Prv3OxvLC9gG0vik7Ob+xo+4sD9Sde7mWR+xhzrgy5M29vbADuHQd5nAIsumCjKodNtw1DH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=asjycebj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="asjycebj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 265921F00893;
	Fri, 18 Sep 2026 07:57:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789718264;
	bh=uRYFR7VhMJSe1YZXN1ukco9BvC0N+S2oQBVZKcntiJ0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=asjycebjct0RJOshiCdehBzz/sfwdYFhMy0uO2Joc/ZmXvxcM2Sj6ida4k0e5/q0y
	 hCZy2FzpM+Q4yBmq9hU3QAx6ZBliYHCm/jOHjpV5Uld1SCyhkvL3zs9+cM7lFYmBMw
	 OouUNAfHuhTAzLx1jGqyE5Qv/9bacpvFydO5j9cRFOjAAoIiCA30/ERI2pDPWWnyxn
	 su4VkGHrIKjXFMad5LawaZJl7O/bw6zwJIAffxrfTgVEnJe6/nWWsmT2mWF/FSr1u9
	 AimBpJLqgZivVJCeDK/bbK+4PcxUh9Ohc66qsJxlU2Zn+HaXEP3YzRYFwd/RhTil27
	 D9KFDoPXwscuw==
Subject: Re: [PATCH net-next v7 01/12] gve: add struct gve_device_info to hold
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
Date: Fri, 18 Sep 2026 07:57:42 +0000
Message-ID: <178971826267.22033.6974245749239964332@kernel.org>
In-Reply-To: <20260916165533.2187434-2-hramamurthy@google.com>
References: <20260916165533.2187434-2-hramamurthy@google.com>
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

Critical: 0 · High: 0 (2) · Medium: 0 · Low: 2

- [Low] The new `struct gve_device_info` introduces `max_tx_queues` /
  `max_rx_queues` members that no code in the tree ever writes or reads,…
- [Low] `gve_set_buf_sizes()`
  (drivers/net/ethernet/google/gve/gve_main.c) turns the baseline's…

Pre-existing issues:
- [High] The device-descriptor option parser trusts device-controlled
  length metadata and can read far outside the 4096-byte DMA buffer.
- [High] Unbounded device-provided RSS sizes plus a u16 truncation let
  the RSS query read past the 4096-byte response buffer and hand the…

--

gve: add struct gve_device_info to hold device properties

This adds struct gve_device_info as the single place holding the
properties negotiated with the device, redirects the AdminQ describe
path to fill it, and moves the code that applies those properties to
struct gve_priv into gve_init_priv().

No Link: tags in the commit header.

A few questions below.

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
                      ^^^^^^^^^^^^^

[Severity: Low]
Is anything writing or reading max_tx_queues and max_rx_queues?

gve_fill_device_info() fills mac, mtu, counters, the default and the
min/max ring sizes and the default tx/rx queue counts, but leaves these two
at zero, and the only consumer of the queue counts, gve_set_num_queues(),
still takes the maximums from priv:

	priv->tx_cfg.max_queues =
		min_t(int, priv->tx_cfg.max_queues, priv->num_ntfy_blks / 2);
	...
	if (device_info->default_tx_queues > 0)
		priv->tx_cfg.num_queues = min_t(int,
						device_info->default_tx_queues,
						priv->tx_cfg.num_queues);

In the other direction, this patch removes the last writers of
priv->default_num_queues and priv->default_min_ring_size in struct gve_priv,
but both declarations stay with no readers left.  priv->default_min_ring_size
now also shadows the identically named and typed field in gve_device_info
that gve_parse_device_option() writes.

Would it be cleaner to drop those two now unused gve_priv fields, and either
fill max_tx_queues/max_rx_queues here or add them when MailboxQ starts using
them?  Following the rest of the series (up to 70ee8341a456) the state is
unchanged: still no writer or reader for either field.

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

[Severity: High]
This isn't a bug introduced by this patch, but since the option parser is
being restructured here: can this parser read outside the 4096-byte DMA
buffer?

gve_adminq_describe_device() allocates the descriptor from priv->adminq_pool,
which is created with GVE_ADMINQ_BUFFER_SIZE (4096), and tells the device
available_length = GVE_ADMINQ_BUFFER_SIZE.  Nothing validates
descriptor->total_length, a __be16 that can be up to 65535:

gve_adminq.c:gve_get_next_option() {
	option_end = (void *)(option + 1) + be16_to_cpu(option->option_length);
	descriptor_end = (void *)descriptor + be16_to_cpu(descriptor->total_length);

	return option_end > descriptor_end ? NULL : (struct gve_device_option *)option_end;
}

With total_length set to 65535 and num_device_options >= 2, does the loop in
gve_process_device_options() advance dev_opt up to roughly 61 KB past the end
of the allocation?

gve_parse_device_option() then dereferences option->option_id,
option->option_length and option->required_features_mask at that address, and
stores (void *)(option + 1) into the dev_op_* pointers that
gve_enable_supported_features() dereferences afterwards to set queue format,
MTU, RSS sizes and ring size ranges.

gve_get_next_option() also reads option->option_length before it is
established that a complete 8-byte option header lies inside the buffer.

Would clamping total_length to GVE_ADMINQ_BUFFER_SIZE and bounds checking
each option header before dereferencing it be appropriate here?

[ ... ]

> @@ -946,77 +949,105 @@ static void gve_enable_supported_features(struct gve_priv *priv,

[ ... ]

>  	if (dev_op_rss_config &&
>  	    (supported_features_mask & GVE_SUP_RSS_CONFIG_MASK)) {
> -		priv->rss_key_size =
> +		info->rss_key_size =
>  			be16_to_cpu(dev_op_rss_config->hash_key_size);
> -		priv->rss_lut_size =
> +		info->rss_lut_size =
>  			be16_to_cpu(dev_op_rss_config->hash_lut_size);
> -		priv->cache_rss_config = false;
> +		info->cache_rss_config = false;

[Severity: High]
This is a pre-existing issue as well, not introduced by this patch, but the
sizes recorded here are taken from the device with no maximum and no check
that key plus LUT bytes fit in a response buffer.  They reach
priv->rss_key_size / priv->rss_lut_size through gve_init_priv().

gve_adminq_query_rss_config() allocates one 4096-byte adminq_pool object and
passes available_length = GVE_ADMINQ_BUFFER_SIZE, then:

gve_adminq.c:gve_adminq_process_rss_query() {
	u16 hash_lut_length;
	...
	hash_lut_length = priv->rss_lut_size * sizeof(*rxfh->indir);

	if (sizeof(*descriptor) + priv->rss_key_size + hash_lut_length != total_memory_length) {
		...
		return -EINVAL;
	}
	...
		for (i = 0; i < priv->rss_lut_size; i++)
			rxfh->indir[i] = be32_to_cpu(lut[i]);
}

With rss_lut_size = 16384, 16384 * 4 == 65536 wraps to 0 in the u16
hash_lut_length, so the check reduces to 8 + rss_key_size ==
total_memory_length.  Does the loop then read 65536 bytes out of the
4096-byte descriptor?

Since the RSS device option also sets cache_rss_config = false,
gve_get_rxfh() uses this device query path, and gve_get_rxfh_indir_size()
returns priv->rss_lut_size, so the ethtool core copies the whole indir array
back to userspace.  Even without the wrap, any key plus LUT size totalling
more than 4096 passes as long as the device supplies a matching total_length.

Should rss_key_size and rss_lut_size be clamped where they are recorded, and
the computed length be validated against GVE_ADMINQ_BUFFER_SIZE rather than
only against the device supplied total_length?

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
The commit message says:

    Most of these changes are refactors only, except for one:
    with the introduction of the central struct gve_device_info,
    in AdminQ mode, gve_set_mtu() now also validates the device
    provided mtu value from jumbo frames device option.

Is the buffer size handling a second behaviour change?  Before this patch
gve_enable_supported_features() wrote both fields unconditionally:

		priv->max_rx_buffer_size =
			be16_to_cpu(dev_op_buffer_sizes->packet_buffer_size);
		priv->header_buf_size =
			be16_to_cpu(dev_op_buffer_sizes->header_buffer_size);

so a device advertising the buffer sizes option with packet_buffer_size == 0
ended up with priv->max_rx_buffer_size == 0, overwriting the
GVE_DEFAULT_RX_BUFFER_SIZE value that gve_probe() installed.  With the new
guards in gve_set_buf_sizes() the probe-time default is kept instead.

The v5 changelog entry "honor device provided rx buffer size correctly"
describes this, but it sits below the --- line and does not end up in git
history.  Could the commit message call out this change too?

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260916165533.2187434-1-hramamurthy%40google.com
