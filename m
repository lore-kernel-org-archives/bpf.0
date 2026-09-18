Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 123BC4A99DC;
	Fri, 18 Sep 2026 07:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789718280; cv=none; b=OKgC73H6Kirf4tPBBL9aIlYQCzAp5paEG9cNslLKh+aoDTUIoCPFNygw0gAS8QuLu0Yfz3MG5WxbcRljpwcR1hoGkvNMmocmWOgzFeUi91BRNSx6jWVVVHuIZuuxQHBTdNHOMC4sCwEhqATHG4cx2dkRDcZz9Pm417QG9N0sgfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789718280; c=relaxed/simple;
	bh=MZYhPsKYpV4K0X/ymrBFg4ipu+xwD4qvhRSNcagNgx4=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CuR0wWXjWVr0DZ6Kq5R0zN46eaQjkxk9HZERnfGDzASaHhJU++XHgJf8pvBi8rCXjzYdCEQ6VMxg13f0GyH9ylo5GV7UkyumzayVR387VO6z5PQ8KkZvZFW6ufNup14HVgp+l//c+gQ/U6b4JpicXhT4c3+ni1a6rfxLXl+lq8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jgyBjHn2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jgyBjHn2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CAF81F0089A;
	Fri, 18 Sep 2026 07:57:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789718273;
	bh=YX7RZjOK1uJv49KoaMsDYRHurBp1N1bh4T7i7LsoRj4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=jgyBjHn2K/3kE2lnbTVG+QMnRoDN0BsCXyVQoQDqsdr2iOMnYf2Imbfu7PvxCCtsB
	 dRGxOFxsWUPITt2WcUqK68aH3wqVSRuqthn+3TMT3b+7JvDQ24Rm13/0J3Zi2czJDT
	 opDQHN4OObp+GamPK5XAbBojFPpdXt6RJ+J1CDHnttwCWP6pkPmPAi0xZ/Poshj/8V
	 SZacsQKPG1r7W5ImgxuH7VT2EkaP6P4ZJ4zzx3aVQrbd53ThRy/Qr4P2POOf0rywqb
	 bcm78qx++dStxVxOj6VTmQPWgo0omgFVJhs1v+Uvy7LX2mkSGwCX4i2RObMcNmNMp9
	 IBG8kzUltVdmQ==
Subject: Re: [PATCH net-next v7 11/12] gve: add ctrl ops for queue operations
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
Date: Fri, 18 Sep 2026 07:57:52 +0000
Message-ID: <178971827222.22033.18083740945510647866@kernel.org>
In-Reply-To: <20260916165533.2187434-12-hramamurthy@google.com>
References: <20260916165533.2187434-12-hramamurthy@google.com>
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

- [Low] After this patch converts gve_create_rings()/gve_destroy_rings()
  in drivers/net/ethernet/google/gve/gve_main.c to call…

--

gve: add ctrl ops for queue operations

This adds create_queues and destroy_queues to struct gve_ctrl_ops, moves the
bulk queue create/destroy sequences from gve_create_rings()/gve_destroy_rings()
in gve_main.c into gve_adminq_create_queues()/gve_adminq_destroy_queues(), and
wires them up in gve_adminq_ops. Described as code movement with no functional
change.

> diff --git a/drivers/net/ethernet/google/gve/gve_adminq.c b/drivers/net/ethernet/google/gve/gve_adminq.c
> index f0218d78bc5d1..450341b70968d 100644
> --- a/drivers/net/ethernet/google/gve/gve_adminq.c
> +++ b/drivers/net/ethernet/google/gve/gve_adminq.c
> @@ -943,6 +943,30 @@ static void gve_set_default_rss_sizes(struct gve_priv *priv)
>  	}
>  }
>  
> +int gve_adminq_destroy_queues(struct gve_priv *priv)
> +{
> +	int num_tx_queues = gve_num_tx_queues(priv);
> +	int err;
> +
> +	err = gve_adminq_destroy_tx_queues(priv, 0, num_tx_queues);

[ ... ]

> +	err = gve_adminq_destroy_rx_queues(priv, priv->rx_cfg.num_queues);

[ ... ]

> @@ -1791,3 +1815,29 @@ void gve_adminq_teardown_mgmt_irq(struct gve_priv *priv)
>  		priv->mgmt_irq_requested = false;
>  	}
>  }
> +
> +int gve_adminq_create_queues(struct gve_priv *priv)
> +{
> +	int num_tx_queues = gve_num_tx_queues(priv);
> +	int err;
> +
> +	err = gve_adminq_create_tx_queues(priv, 0, num_tx_queues);

[ ... ]

> +	err = gve_adminq_create_rx_queues(priv, priv->rx_cfg.num_queues);

[ ... ]

> diff --git a/drivers/net/ethernet/google/gve/gve_adminq.h b/drivers/net/ethernet/google/gve/gve_adminq.h
> index 0b48e9f2a82ae..d696e4932a8b9 100644
> --- a/drivers/net/ethernet/google/gve/gve_adminq.h
> +++ b/drivers/net/ethernet/google/gve/gve_adminq.h
> @@ -628,6 +628,8 @@ int gve_adminq_configure_device_resources(struct gve_priv *priv,
>  					  dma_addr_t db_array_bus_addr,
>  					  u32 num_ntfy_blks);
>  int gve_adminq_deconfigure_device_resources(struct gve_priv *priv);
> +int gve_adminq_create_queues(struct gve_priv *priv);
> +int gve_adminq_destroy_queues(struct gve_priv *priv);
>  int gve_adminq_create_tx_queues(struct gve_priv *priv, u32 start_id, u32 num_queues);
>  int gve_adminq_destroy_tx_queues(struct gve_priv *priv, u32 start_id, u32 num_queues);
      ^^^^

[Severity: Low]
This isn't a bug, but after this patch is it still necessary to export the
four bulk helpers from gve_adminq.h?

With gve_create_rings() and gve_destroy_rings() converted to
priv->ctrl_ops->create_queues() / priv->ctrl_ops->destroy_queues(), the only
remaining references to gve_adminq_create_tx_queues(),
gve_adminq_create_rx_queues(), gve_adminq_destroy_tx_queues() and
gve_adminq_destroy_rx_queues() are their definitions in gve_adminq.c and the
calls from the two new wrappers in the same file:

  gve_adminq_create_queues()
      gve_adminq_create_tx_queues()
      gve_adminq_create_rx_queues()

  gve_adminq_destroy_queues()
      gve_adminq_destroy_tx_queues()
      gve_adminq_destroy_rx_queues()

All four definitions precede those call sites, so could they be made static
and their declarations dropped from the header, leaving only the
ctrl_ops-backed gve_adminq_create_queues()/gve_adminq_destroy_queues() in the
shared header? Keeping the AdminQ-specific helpers visible module-wide leaves
an entry point that bypasses the ops indirection this series is introducing.

> diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/ethernet/google/gve/gve_main.c
> index 44669b2f25d7d..33af1437b3c04 100644
> --- a/drivers/net/ethernet/google/gve/gve_main.c
> +++ b/drivers/net/ethernet/google/gve/gve_main.c
> @@ -886,33 +886,16 @@ static int gve_unregister_qpls(struct gve_priv *priv)
>  
>  static int gve_create_rings(struct gve_priv *priv)
>  {
> -	int num_tx_queues = gve_num_tx_queues(priv);
>  	int err;
>  	int i;
>  
> -	err = gve_adminq_create_tx_queues(priv, 0, num_tx_queues);
> +	err = priv->ctrl_ops->create_queues(priv);

[ ... ]

> @@ -1067,26 +1050,12 @@ static int gve_queues_mem_alloc(struct gve_priv *priv,
>  
>  static int gve_destroy_rings(struct gve_priv *priv)
>  {
> -	int num_tx_queues = gve_num_tx_queues(priv);
>  	int err;
>  
> -	err = gve_adminq_destroy_tx_queues(priv, 0, num_tx_queues);
> +	err = priv->ctrl_ops->destroy_queues(priv);

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260916165533.2187434-1-hramamurthy%40google.com
