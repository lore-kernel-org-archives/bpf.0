Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F8271C28E;
	Mon,  7 Sep 2026 00:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788739438; cv=none; b=mqIS9Pf0/6oSlqmg6DlCJB4wJhw2iByf5yayzBJD/u6rhJHT2tvOuYZ5kABYOOO5rgLB4L7vrTbgu6aD7CVpMu4lsF/3gU1rijg4NjcBD95SkA5xGi/Lee61vwvW24W/frYxjoAQHuNeTabMqpcom0OryakSN+tx92sThvEEJRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788739438; c=relaxed/simple;
	bh=S9b+YANEwZh0DNTIMtEmB1EEe1VN2A5pYmZTM46mLqI=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ChRaInILjT2zBqBheAqwXYEd7Z4PPlc6CoctOiw8vxiMlAuHcf+BGvsyfJQVYnNJ30Cnh98F2YlBbgiOyjRFZJe28ouTr1FvVaFdMUJW8bQYmsHAAZ2FY39neY/fYJ01HvcwvoVJ0A9jI3tZLe5/onZGGyuRifIbZ7+1Np+zVIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NQYNAQPm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NQYNAQPm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69F9D1F00A3E;
	Mon,  7 Sep 2026 00:03:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788739436;
	bh=dBAVXpRq9j8exUAB0qOhqAhM42w+AauIp+cYmifz4qM=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=NQYNAQPmDPv+wt4ut6xISrX8cvO579MHPjZlmmbJJCZERqhtcGpgo+ndXbtLiYWWU
	 qSTqjeJajRFYuheqvxLT66huVB7cMizkrlH6zTMdh5ZPCAYh35czLJiZ2zCnWcFUsp
	 SJXUOB8wDiOwb4V5obeqp3jP7a8PFyoz5WXXN5DRL8yUpo2DHm/o2Y92Kst9iWnFRy
	 IcbGHn/PlcfTABzEjho1YmjZgBYtbafpPCl85rjA8UiFYaWJhUXxPmJaANunHn1Wpn
	 Q2e9s/feiwHayZrMdxFd5w1qM7qAkVbYhvYYdqYABwSw4joXm4F4lXD/xpJOHynF2m
	 82kTwH+ScZoYA==
Subject: Re: [PATCH net-next v5 02/12] gve: introduce control plane operations
 structure
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
Date: Mon, 07 Sep 2026 00:03:54 +0000
Message-ID: <178873943498.219967.6969502968707920039@kernel.org>
In-Reply-To: <20260903215606.31633-3-hramamurthy@google.com>
References: <20260903215606.31633-3-hramamurthy@google.com>
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

- [Low] New indirect control-plane op return value is discarded in
  gve_probe().

--

gve: introduce control plane operations structure

This adds a gve_ctrl_ops structure to abstract control plane operations
between the existing Adminq ABI and an upcoming Mailbox ABI, and moves the
doorbell BAR map/unmap into the first two ops. Only the Adminq ops are
populated by this patch, and gve_probe()/gve_remove() now call through
priv->ctrl_ops.

> diff --git a/drivers/net/ethernet/google/gve/gve.h b/drivers/net/ethernet/google/gve/gve.h
> index 021adb9108dff..56148ea3cfbf5 100644
> --- a/drivers/net/ethernet/google/gve/gve.h
> +++ b/drivers/net/ethernet/google/gve/gve.h
> @@ -825,6 +825,16 @@ struct gve_device_info {
>  	bool cache_rss_config;
>  };
>  
> +/**
> + * struct gve_ctrl_ops - Control plane operations structure
> + * @map_db_bar: Maps the doorbell BAR for the device and store in @priv.
> + * @unmap_db_bar: Unmaps the doorbell BAR previously mapped by @map_db_bar.
> + */
> +struct gve_ctrl_ops {
> +	int (*map_db_bar)(struct gve_priv *priv);
> +	void (*unmap_db_bar)(struct gve_priv *priv);
> +};

[ ... ]

> diff --git a/drivers/net/ethernet/google/gve/gve_adminq.c b/drivers/net/ethernet/google/gve/gve_adminq.c
> index 512349c5517f4..08d8e49d563eb 100644
> --- a/drivers/net/ethernet/google/gve/gve_adminq.c
> +++ b/drivers/net/ethernet/google/gve/gve_adminq.c
> @@ -1637,3 +1637,24 @@ void gve_set_num_queues(struct gve_priv *priv)
> +int gve_adminq_map_db_bar(struct gve_priv *priv)
> +{
> +	struct pci_dev *pdev = priv->pdev;
> +	void __iomem *db_bar;
> +
> +	db_bar = pci_iomap(pdev, GVE_DOORBELL_BAR, 0);
> +	if (!db_bar) {
> +		dev_err(&pdev->dev, "Failed to map doorbell bar!\n");
> +		return -ENOMEM;
> +	}
> +	priv->db_bar2 = db_bar;
> +	return 0;
> +}

[ ... ]

> diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/ethernet/google/gve/gve_main.c
> index d3882de584e36..93b714e1d1307 100644
> --- a/drivers/net/ethernet/google/gve/gve_main.c
> +++ b/drivers/net/ethernet/google/gve/gve_main.c

[ ... ]

> @@ -2937,19 +2934,27 @@ static int gve_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
>  	priv->rx_cfg.packet_buffer_size = GVE_DEFAULT_RX_BUFFER_SIZE;
>  	priv->max_rx_buffer_size = GVE_DEFAULT_RX_BUFFER_SIZE;
>  
> +	/* Set adminq ctrl ops */
> +	priv->ctrl_ops = &gve_adminq_ops;
> +
> +	err = priv->ctrl_ops->map_db_bar(priv);
> +	if (err) {
> +		err = -ENOMEM;
                ^^^^

[Severity: Low]
Is the err = -ENOMEM; assignment here intentional?  The new op is declared
as returning an int errno in struct gve_ctrl_ops, and
gve_adminq_map_db_bar() already returns 0 or -ENOMEM and prints its own
dev_err(), so the captured value is overwritten before it is ever used.

With only the Adminq implementation present the resulting errno happens to
be identical, so there is no change in behaviour today.  Once the Mailbox
op mentioned in the commit message is added, would an -EINVAL, -EIO,
-ENODEV or -EPROBE_DEFER from map_db_bar() be reported to the PCI core as
-ENOMEM instead?  -EPROBE_DEFER in particular would turn a deferred probe
into a hard failure.

The other failure sites in gve_probe(), for example gve_init_priv() and
register_netdev(), propagate err unchanged, so would just dropping the
err = -ENOMEM; line match the surrounding convention?

> +		goto abort_with_netdev;
> +	}
> +
>  	gve_set_probe_in_progress(priv);
>  	priv->gve_wq = alloc_ordered_workqueue("gve", 0);
>  	if (!priv->gve_wq) {
>  		dev_err(&pdev->dev, "Could not allocate workqueue");
>  		err = -ENOMEM;
> -		goto abort_with_netdev;
> +		goto abort_with_unmap_db_bar;
>  	}

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260903215606.31633-1-hramamurthy%40google.com
