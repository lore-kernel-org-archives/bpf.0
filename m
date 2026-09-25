Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04C564E50D8;
	Fri, 25 Sep 2026 18:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790362567; cv=none; b=Ihg7fEAsclCfEyxUt/yrV4o7c1Sar7FF99v6iy8icgCJcPFBeDGgXAzL+6bIvEZM5xTIpsW5ohPPIsNBCTYfCWX+mD1RCmGP5vzjgkOSnITPySdOojAgzqJ9dxA2pZ7HJYCmPnJA+7H5Pk3eG0QvBJi3XjU8otLZ0cKoOqFwhZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790362567; c=relaxed/simple;
	bh=Vi9/ctP9bxnXd7uZ/D39ocy+oA824qEedJPwGSY5+uI=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qJz5gOHoBDdlK23fa3w3b+66mpG6s2QKFdO9ZDvb3X9f+YGl15f6+lu3tGn8EQTTp60tvKKowJYdUCbSupAHgBYZZft8fZWH0WgrmARTYgFzNh3Sn244JBoO+Rj5h9fFTfVVdEYoZ/4VlLWi4/cQNrtm2SCXjv5/v+rF12T3LAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cPuNt6mM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cPuNt6mM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 801C11F00893;
	Fri, 25 Sep 2026 18:56:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790362565;
	bh=l6BG7YG9ySIhGeHDhYD3h7r5nx5Jqr2P+Co8MSeNEjI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=cPuNt6mMWggLqp5M43C2foPR4WqvZp2L++ZSxF46RvrzSopTTFO/+W5Lv9DO9u5qB
	 5FgbN9E6jCJdT7GaZE5ofduhG0AsRr4wmYhZM3Oul0Fy+CTE3i2fIdxAl5NmNZWwL7
	 zEEc8YuOw17yAR7qU9Z9boJ3ncbPFyokBov+/IsixiMbnaOrsRkhZulVDVb2r2oFH1
	 AiH5n2UWbVjOuZIaIKE0bSR411pQAi3pZ+hLq9k+CsVuHaq0Pt+E9LCBSNnZfIrz6L
	 nX3N7gT1h1TEwx9owhbQaASCBnr9AW98vA77D2hjZnsG/42K7arzoTfOT0LImJ8r+X
	 rIwGXeFjDK9ng==
Subject: Re: [PATCH net-next v8 07/12] gve: add gve_ctrl_ops for gve
 initialization/teardown sequences
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
Date: Fri, 25 Sep 2026 18:56:04 +0000
Message-ID: <179036256409.2160803.7834032519830054759@kernel.org>
In-Reply-To: <20260924185316.2831077-8-hramamurthy@google.com>
References: <20260924185316.2831077-8-hramamurthy@google.com>
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

- [Low] The kernel-doc for `struct gve_ctrl_ops` in
  drivers/net/ethernet/google/gve/gve.h says `@setup_stats_report` is…
- [Low] This patch changes the prototype to `int
  gve_adminq_get_ptype_map_dqo(struct gve_priv *priv);`, but…

--

gve: add gve_ctrl_ops for gve initialization/teardown sequences

This commit adds get_ptype_map, configure_rss, setup_stats_report and
reset_flow_rules callbacks to struct gve_ctrl_ops. The control plane
setup and teardown paths in gve_main.c now call them through
priv->ctrl_ops. gve_adminq_get_ptype_map_dqo() also changes: it now
writes into priv->ptype_lut_dqo directly and no longer takes a ptype_lut
argument.

> diff --git a/drivers/net/ethernet/google/gve/gve.h b/drivers/net/ethernet/google/gve/gve.h
> index 026d685ecaee3..e0583e8cd2cdb 100644
> --- a/drivers/net/ethernet/google/gve/gve.h
> +++ b/drivers/net/ethernet/google/gve/gve.h
> @@ -833,12 +833,24 @@ struct gve_device_info {
>   *                  structures stored in @priv to be used during initialization.
>   * @set_num_ntfy_blks: Sets no. of vectors into @priv to be used during
>   *                     initialization.
> + * @get_ptype_map: Learn packet type map from device and store it in @priv
> + * @configure_rss: Set up default RSS configuration
> + * @setup_stats_report: Set up DMA region for stats report (AdminQ only)
> + * @reset_flow_rules: Flush all flow rules from device
>   */
>  struct gve_ctrl_ops {
>  	int (*map_db_bar)(struct gve_priv *priv);
>  	void (*unmap_db_bar)(struct gve_priv *priv);
>  	void (*set_num_queues)(struct gve_priv *priv);
>  	int (*set_num_ntfy_blks)(struct gve_priv *priv);
> +	int (*get_ptype_map)(struct gve_priv *priv);
> +	int (*configure_rss)(struct gve_priv *priv,
> +			     struct ethtool_rxfh_param *param);
> +	int (*setup_stats_report)(struct gve_priv *priv,
> +				  u64 stats_report_len,
> +				  dma_addr_t stats_report_addr,
> +				  u64 interval_ms); /* AQ-specific */

[Severity: Low]
This isn't a bug, but is setup_stats_report meant to be optional for
back-ends other than AdminQ?

The kernel-doc says "(AdminQ only)" and the member has an "AQ-specific"
comment. Someone writing a future mailbox ops table could read that as
permission to leave the op NULL.

Both call sites use it without a NULL check, though. In
gve_setup_control_plane_resources():

	err = ops->setup_stats_report(priv, priv->stats_report_len,
				      priv->stats_report_bus,
				      GVE_STATS_REPORT_TIMER_PERIOD);

and in gve_teardown_control_plane_resources():

	err = ops->setup_stats_report(priv, 0, 0x0,
				      GVE_STATS_REPORT_TIMER_PERIOD);

A NULL call can't happen today. The only table, gve_adminq_ops, sets the
op to gve_adminq_report_stats(). Later in the series, release_db_resources
gets the same "(AdminQ only)" label and is also called without a NULL
check.

Could the kernel-doc say whether the op must always be provided, with
non-AdminQ back-ends supplying a stub? Or should the call sites check for
NULL?

[ ... ]

> diff --git a/drivers/net/ethernet/google/gve/gve_adminq.h b/drivers/net/ethernet/google/gve/gve_adminq.h
> index fe1e8868cdfe2..5e51c060e2372 100644
> --- a/drivers/net/ethernet/google/gve/gve_adminq.h
> +++ b/drivers/net/ethernet/google/gve/gve_adminq.h
> @@ -652,8 +652,7 @@ int gve_adminq_report_nic_ts(struct gve_priv *priv,
>  			     dma_addr_t nic_ts_report_addr);
>  
>  struct gve_ptype_lut;
> -int gve_adminq_get_ptype_map_dqo(struct gve_priv *priv,
> -				 struct gve_ptype_lut *ptype_lut);
> +int gve_adminq_get_ptype_map_dqo(struct gve_priv *priv);

[Severity: Low]
This isn't a bug, but now that the ptype_lut argument is gone, is the
"struct gve_ptype_lut;" forward declaration above still needed?

Nothing else in gve_adminq.h refers to that type. The declaration is also
still there at the end of the series.

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260924185316.2831077-1-hramamurthy%40google.com
