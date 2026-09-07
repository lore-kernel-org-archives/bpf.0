Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED4681C01;
	Mon,  7 Sep 2026 00:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788739440; cv=none; b=dbsmM4DH0f0zvjJZBvoaJD/qJGNGg8j4o3yCFXQRP6eY1Ea3i+QOcAU5Z2x94C01sLeGpjaUZbiF14IjbpQ7X1bNdYqJ3DigcTO+yz/fgXo4ok37KwCux2JlI/5+QC94ZIbCCNty3CYOcDGxCWtFtoKG9cA2Z9BODWmuWiPBCDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788739440; c=relaxed/simple;
	bh=5ENVvjsG4VnuZfw61g42l8JO4nmrxiGlxxKXHgtdsUY=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=I7Yd6COBNAMvicktHwvIFqJKNhkqykFc4GCyQLeYyZVo4Y7qqGdyJFlvKGd7Ydw9Dz4T78LOsn5w3XoZKXclMkNDPuivWPG6BnwTlZeWD6hoZ4wLZsyQfUx+kKOMZkYFkL+As7ePVt9oVLhRhKPkxlTq7tTHT4BJwCCy9VmAwrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FUEiX5WE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FUEiX5WE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51B3D1F00A3A;
	Mon,  7 Sep 2026 00:03:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788739438;
	bh=dT05OVP7silxBFfd897SLbac3Pcgns4PtYvllnO/4ZU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=FUEiX5WELDLQEocvCkgbLw71rXR8SFS0GLw35osIDs4/ViIl4ixe4SkPQKXhjBh6X
	 2LzUK6+B4TABq0v6H0l/Lq5uJ50rNzPUM7W1ggDsoQOp+vfK9PM1Oxdbl/NBzHn5bV
	 lzUYd2jB6w5LVpwYhWxEKKJGsjlF9tOEsjkSjbvdIfR1z5vcqGRkbh+7zcuvdqb9yl
	 vwlY9oeVeTtCMb1p7e//Wgw5sqGqQEM/Yc6CxuxIXLpqBnSlXmmyyhMY35IVYS2sQo
	 CQEIAjpzW652qTsG7okQhv4+k+ddN4nAVFT5BmGIB9MJKKFViyBq14YFWclj3N6J+k
	 mXkRuzPA+BqnQ==
Subject:
 Re: [PATCH net-next v5 05/12] gve: refactor gve_init_priv for reset path
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
Date: Mon, 07 Sep 2026 00:03:56 +0000
Message-ID: <178873943686.219967.9095534715316547963@kernel.org>
In-Reply-To: <20260903215606.31633-6-hramamurthy@google.com>
References: <20260903215606.31633-6-hramamurthy@google.com>
X-sashiko-severity: Low
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

Critical: 0 · High: 0 · Medium: 0 · Low: 4

- [Low] gve_reset_recovery() error-path change contradicts the "only code
  movement, no functional change" claim: when gve_open() fails during…
- [Low] Folding gve_adminq_write_version() into the new gve_adminq_init()
  changes when and how often the driver version register is written,…
- [Low] Duplicated / misattributed error reporting: the new gve_probe()
  call site prints "Could not get device information: err=%d" for any…
- [Low] Stale comment in gve_probe(): the "Set default and supported
  features" block still says features "might be set in other locations…

--

gve: refactor gve_init_priv for reset path

This splits gve_init_priv() so that device property negotiation and
AdminQ setup happen once in gve_probe(), introduces gve_adminq_init()
and gve_setup_device(), and makes gve_reset_recovery() call the setup
helpers directly.

A few questions on the "no functional change" claim and on the new
diagnostics below.

> diff --git a/drivers/net/ethernet/google/gve/gve.h b/drivers/net/ethernet/google/gve/gve.h
> index 1bc5e32b6618e..48cc8a6be186c 100644
> --- a/drivers/net/ethernet/google/gve/gve.h
> +++ b/drivers/net/ethernet/google/gve/gve.h
> @@ -1253,6 +1253,8 @@ static inline bool gve_is_clock_enabled(struct gve_priv *priv)
>  	return priv->nic_ts_report;
>  }
>  
> +void gve_adminq_write_version(u8 __iomem *driver_version_register);
> +
>  /* gqi napi handler defined in gve_main.c */
>  int gve_napi_poll(struct napi_struct *napi, int budget);
>  
> diff --git a/drivers/net/ethernet/google/gve/gve_adminq.c b/drivers/net/ethernet/google/gve/gve_adminq.c
> index f420a8e1dd3df..a62cb7a921d07 100644
> --- a/drivers/net/ethernet/google/gve/gve_adminq.c
> +++ b/drivers/net/ethernet/google/gve/gve_adminq.c

[ ... ]

> @@ -355,6 +357,14 @@ int gve_adminq_alloc(struct device *dev, struct gve_priv *priv)
>  	return 0;
>  }
>  
> +int gve_adminq_init(struct gve_priv *priv)
> +{
> +	struct gve_registers __iomem *reg_bar = priv->reg_bar0;
> +
> +	gve_adminq_write_version(&reg_bar->driver_version);
> +	return gve_adminq_alloc(priv);
> +}
> +

[Severity: Low]
Folding the version write into gve_adminq_init() changes when and how
often the driver version register is written, so is the commit message
statement "These changes are only code movement, no functional change"
accurate here?

Before this patch the string was written exactly once per probe, from
gve_probe(), and before max_tx_queues/max_rx_queues were read.  After
this patch gve_reset_recovery() also calls gve_adminq_init(), so the
version string is re-emitted to the device on every gve_reset() (ethtool
reset, device-requested reset from the service task, adminq timeout) and
on gve_resume().

struct gve_registers::driver_version is a single byte write port that
gve_adminq_write_version() feeds a byte at a time, so re-writing it
looks harmless from the driver side, but it is a device-visible change.
Is re-writing the version on each AdminQ re-init intentional, and could
the changelog say so?

>  void gve_adminq_release(struct gve_priv *priv)
>  {
>  	int i = 0;

[ ... ]

> diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/ethernet/google/gve/gve_main.c
> index 08859611a96e4..16ce55c6d74f6 100644
> --- a/drivers/net/ethernet/google/gve/gve_main.c
> +++ b/drivers/net/ethernet/google/gve/gve_main.c

[ ... ]

> @@ -2566,15 +2541,32 @@ static int gve_reset_recovery(struct gve_priv *priv, bool was_up)
>  {
>  	int err;
>  
> -	err = gve_init_priv(priv, true);
> -	if (err)
> +	err = gve_adminq_init(priv);
> +	if (err) {
> +		dev_err(&priv->pdev->dev,
> +			"Failed to alloc admin queue: err=%d\n", err);
>  		goto err;
> +	}
> +
> +	err = gve_adminq_verify_driver_compatibility(priv);
> +	if (err) {
> +		dev_err(&priv->pdev->dev,
> +			"Could not verify driver compatibility: err=%d\n", err);
> +		goto err_free_adminq;
> +	}
> +
> +	err = gve_setup_device(priv);
> +	if (err)
> +		goto err_free_adminq;
>  	if (was_up) {
>  		err = gve_open(priv->dev);
>  		if (err)
> -			goto err;
> +			return err;

[Severity: Low]
Is this error path change also covered by "These changes are only code
movement, no functional change"?

Previously a gve_open() failure here fell into the err: label:

err:
	dev_err(&priv->pdev->dev, "Reset failed! !!! DISABLING ALL QUEUES !!!\n");
	gve_turndown(priv);

Now it returns silently, so the "Reset failed!" message is no longer
printed when gve_open() fails during reset or resume recovery, for
example on an -ENOMEM from gve_queues_mem_alloc().  The path is
reachable from both gve_reset()->gve_reset_recovery(priv, true) and
gve_resume()->gve_reset_recovery(priv, priv->up_before_suspend).

The gve_turndown(priv) call looks like a no-op at that point, since it
returns early unless gve_get_napi_enabled(priv) is set and every caller
reaching gve_reset_recovery() with was_up already turned the device
down, so the observable difference appears to be only the missing
dev_err().

The behaviour change is described in the post-"---" v3 notes as "don't
free device resources if gve_open() fails in the reset path", but the
old err: label did not free device resources either, it only logged and
called gve_turndown().  Could that note be reworded, or the change
mentioned in the commit message proper?

Note the next patch in the series, "gve: simplify reset logic", turns
this into gve_recover() where a gve_open() failure does
"goto teardown_device;" and the log message comes back, so this only
affects the intermediate state.

>  	}
>  	return 0;
> +
> +err_free_adminq:
> +	gve_adminq_free(priv);
>  err:
>  	dev_err(&priv->pdev->dev, "Reset failed! !!! DISABLING ALL QUEUES !!!\n");
>  	gve_turndown(priv);
> @@ -2617,7 +2609,7 @@ int gve_reset(struct gve_priv *priv, bool attempt_teardown)
>  	return err;
>  }
>  
> -static void gve_write_version(u8 __iomem *driver_version_register)
> +void gve_adminq_write_version(u8 __iomem *driver_version_register)
>  {
>  	const char *c = gve_version_prefix;
>  
> @@ -2850,7 +2842,6 @@ static int gve_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
>  		goto abort_with_pci_region;
>  	}
>  
> -	gve_write_version(&reg_bar->driver_version);
>  	/* Get max queues to alloc etherdev */
>  	max_tx_queues = ioread32be(&reg_bar->max_tx_queues);
>  	max_rx_queues = ioread32be(&reg_bar->max_rx_queues);

[Severity: Low]
Related to the gve_adminq_init() comment above: this removal also
reverses the probe-time ordering between the driver version write and
the reads of max_tx_queues/max_rx_queues.  The version string is now
written later, from gve_adminq_init(), after the netdev has been
allocated.  Does the device care about that ordering?

> @@ -2897,13 +2888,28 @@ static int gve_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
>  	priv->rx_cfg.packet_buffer_size = GVE_DEFAULT_RX_BUFFER_SIZE;
>  	priv->max_rx_buffer_size = GVE_DEFAULT_RX_BUFFER_SIZE;
>  
> +	err = gve_adminq_init(priv);
> +	if (err) {
> +		dev_err(&priv->pdev->dev,
> +			"Failed to alloc admin queue: err=%d\n", err);
> +		goto abort_with_netdev;
> +	}
> +
> +	priv->device_info.queue_format = GVE_QUEUE_FORMAT_UNSPECIFIED;
> +	err = gve_adminq_get_device_properties(priv);
> +	if (err) {
> +		dev_err(&priv->pdev->dev,
> +			"Could not get device information: err=%d\n", err);
> +		goto abort_with_adminq;
> +	}

[Severity: Low]
Is this dev_err() redundant, and misleading for one of the two failure
causes?  gve_adminq_get_device_properties() in gve_adminq.c already logs
each sub-step:

	err = gve_adminq_verify_driver_compatibility(priv);
	if (err) {
		dev_err(&priv->pdev->dev,
			"Could not verify driver compatibility: err=%d\n", err);
		return err;
	}

	/* Get the initial information we need from the device */
	err = gve_adminq_describe_device(priv);
	if (err) {
		dev_err(&priv->pdev->dev,
			"Could not get device information: err=%d\n", err);
		return err;
	}

So a VERIFY_DRIVER_COMPATIBILITY failure during probe prints the correct
"Could not verify driver compatibility" line and is then followed by
"Could not get device information", and a DESCRIBE_DEVICE failure prints
the same line twice.

Would dropping the dev_err() at this call site, or making the helper
silent and logging only in the callers, be preferable?  The reset path
added in this patch does the latter, calling
gve_adminq_verify_driver_compatibility() directly and logging itself.

[Severity: Low]
Separate from the hunk itself: while this region of gve_probe() is being
rearranged, is the feature comment a little higher up in the same
function still accurate?

	/* Set default and supported features.
	 *
	 * Features might be set in other locations as well (such as
	 * `gve_adminq_describe_device`).
	 */
	dev->hw_features = NETIF_F_HIGHDMA;

After this series gve_adminq_describe_device() and
gve_enable_supported_features() only fill priv->device_info; the netdev
feature bits (NETIF_F_GRO_HW, NETIF_F_GSO_UDP_L4, NETIF_F_NTUPLE, plus
netif_set_tso_max_size()) are set in gve_init_priv() in gve_main.c.  The
only remaining reference to priv->dev->features in gve_adminq.c is the
read in the create RX queue path.  Should the comment point at
gve_init_priv() instead?

>  	/* Set adminq ctrl ops */
>  	priv->ctrl_ops = &gve_adminq_ops;
>  
>  	err = priv->ctrl_ops->map_db_bar(priv);
>  	if (err) {
>  		err = -ENOMEM;
> -		goto abort_with_netdev;
> +		goto abort_with_adminq;
>  	}
>  
>  	gve_set_probe_in_progress(priv);

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260903215606.31633-1-hramamurthy%40google.com
