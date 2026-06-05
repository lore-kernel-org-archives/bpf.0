Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 585E03F23C9
	for <bpf@vger.kernel.org>; Fri,  5 Jun 2026 03:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780631547; cv=pass; b=qFISgIpfEcOp2EJDWItguEOhVCLv0THamkZlHHjl0roy1Xiu4bI6M0lsr9rceU9UpIDoD9hkJhk98sfEdn2CiaXEfC+ARixs/0vqUXBBzeRNKf/9SyQN7P8xCV8izt46TcccrmTRfw9Tp7zYZyE0iaJwr28jPMYfNkTApja0W0A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780631547; c=relaxed/simple;
	bh=mytLMrMXYhL+18GEQ9PIr2rS/CufdsXi7gDjg2qZmPQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sxddblboPd+VjbQSwGC8vpHoAxKzEt/dl5ULLqrrFaMc3cf7ncJcS3qb7YEBy373a+AZqQwq15AF30R0za4oyuqKvbkmeHFMl+L2PklAonGihCbxOmoRXtUfVsWqLowiLleqyOhANhilFJrko1eU8UAk7EMb3zslJL/2iFi2wV4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rgOBgZST; arc=pass smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rgOBgZST"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2bf2d865383so43215ad.1
        for <bpf@vger.kernel.org>; Thu, 04 Jun 2026 20:52:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780631544; cv=none;
        d=google.com; s=arc-20240605;
        b=aDj0hAe4lA9XmaqaJAZxUwh6oHtAm1n80ooyjzgLvzWkfB0PdBSBjcLt4iB6TKpFAn
         n6uRihyf2Et18BLBq8lltrCwo0qIil35BvSQuLynWMVlP+ITJ1ynSLdkqYI66zphgFfe
         zvpd6GAZ/xcWG8yU9/rj3EdqJoweSaWk2INK0PrBPwN2O7BpO5IYiw8g4klRpAd8FCJj
         np9Gqn6Qk22LzIKlQSrozlr5M4c/GRhMRF4eB2r9hU2dJ+Z9sS8ugHYwJD3xHAMD0V5v
         gFB6CR5OjGBXEDV1SRWzaVthimRoYnMyS1gMV2GD3yPMdD8/OhFbsXqhKcHdUX8e/O0s
         1n2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=jZCfIZfLvmWGjkXuJlov1g2353YW7lR2ub/+EINb1fQ=;
        fh=tY+lw5q2VGmh6i6Raupu4zbs10lsTpOxCrv4KNW1ets=;
        b=HOeWWnHylJySZPNXRnGIPahfdW4aydLg3oWMpMbfDs8v6ZskXErNlniIaUrZ8kRjJZ
         KTZbDd9c0Wi5WmcU1aaHMRwpaQWj29O97omUqhgS8QV0tqg62PfXl3V3gNohEFV0lXqi
         5i+yhbEup/pwbuFCZ4LQX9Kj3osciTiC1vPxA9bERwdomRxFqRju+kOpYFdG6dUyzx2q
         fFUJwjZdSg4OxWkUOJwQFkKiC/CcR3UpMQZp/PB0UGLJQ4uMfXC69eIsyfajaq3iFDbs
         BYhoqjrLQMYPgLtieY8ZVrSuWeR2EVdXC4n9dqjDG2Ed7aZCLUfwA/W9aL2h6XgtJnIj
         vR8w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780631544; x=1781236344; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jZCfIZfLvmWGjkXuJlov1g2353YW7lR2ub/+EINb1fQ=;
        b=rgOBgZST1M4UwKR2L/1mHL2nUXDx54EBLd0JMzm6xzO4jFGUyoamQdAoUK24Yvav5y
         uHGTKjZ97AvThKex1Ez5Ntr1EZ6buAkLGH7Hin/fcTZg6Ld+jQHis+j4LczFFEUYs0zx
         JS938/QmxoH7t+VRSKmCEKmyZ8Sa3QJ2jugDcoTwZwAn9hzklW5c+wPpROOPWqKcXMT8
         Bg3SzpkjKxEZ2HGts8JeaAKGwOSRAi1kwcK8JCDEsVxPt9EPySg8LUDlJ62w8lb2duG4
         s3VO581Nrzv15VGJmQZjqSk3hoJ3VnLmooi4AdCOfwdgpYVp+UoIZH6nOrfy8xcZ1AMc
         yr4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780631544; x=1781236344;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jZCfIZfLvmWGjkXuJlov1g2353YW7lR2ub/+EINb1fQ=;
        b=hNMGyf1eTQYFtW1n7BXlhN3mopIx1HQ+lLIpu42kYw8XhgnJy2UoE75pWZPXxy30zB
         h2VQgM2ReOzgrlPXkW/duqhTCU8T16zEVgJtZRiMWeQ3kwMfGeaw2WM+lX/vNCQNUl40
         Gv8t4n3aJjr/G0Rin076yr13Z8l9rvmQOx0BaYYsIWNXab4hqMfWp+VgBy4gDNj/iPMp
         GoDG1Rbcs2Vf5rHKXQ6Ryg4XD7g4MDk/aMhMefc8/Y471DsU4x/UCVGD8hxOq15j9Vwn
         gYpZVvJQvj6NUdxH9ebaAv0deVxmy6z0+RCw56uYb6fFwErhtfI6Hl6fp/48oB2tP5bM
         BZtA==
X-Forwarded-Encrypted: i=1; AFNElJ8HQcQgkRQNinmJaOT7hRYRhn0t+89+PzOiB40PqqMrkfJZTKCCN6MILZetKKRG6KdnbYs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTzAzNAfZiQqP3fgkhlf2JGW/TZiU6s4/YfbFji6zi0BSWZoze
	49zyWY1Y8H/yw59iZw8lOutZRktE7K5q5KWnwlqtHJoL+gUillAgRuV94dBa4NryWwHc6Ae6UqL
	8zEtOCwY7Jmyn06aP7BhdFwqL3JOnaEPb0UM/nzJj
X-Gm-Gg: Acq92OHfxJsndgmedAoCVy3rl2Mn8Y8sg5tSgye0/bqVp+xyWYRfdf5FB+Z9mRKOVJJ
	dsqC+gs+JzlIru7On+UFyZqqV87FhS2gdSZLEFEUJ2KScLPVG5/lOgAaFSHv+liadbr2ZLBZXxF
	QZdTUsOlWYNipEX1eqviUI3KblzOK6p8LWE3ossHWQNhF3Eq8eFSE5vgpxksOgJJWmhVKTl39KL
	ZUInLF5wWuhIHbeKekGRBIIteoDVlhQGfMMel2tfNaVH92UzMMmDVWTqEmjI3HEzb9Rbp1fY+5L
	T4iGS/81zDQihVcUysg+Wd/XHsEfNl2u77axTL6mkXecvjb+OdQBSTnaGRTfbhNX0F6E4P2a2tJ
	rkN3KxK0AMQxOW8GGsbk=
X-Received: by 2002:a17:903:2a90:b0:2c1:ee6e:be1e with SMTP id
 d9443c01a7336-2c1ee6eca49mr225255ad.28.1780631544010; Thu, 04 Jun 2026
 20:52:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260602235900.3050782-1-hramamurthy@google.com> <20260602235900.3050782-9-hramamurthy@google.com>
In-Reply-To: <20260602235900.3050782-9-hramamurthy@google.com>
From: Harshitha Ramamurthy <hramamurthy@google.com>
Date: Thu, 4 Jun 2026 20:52:11 -0700
X-Gm-Features: AVHnY4IHATH3pq3hK4RRmg04nYb43242eE0Wp-CgeWqd2H3oXD6pRB1wcTgJBAM
Message-ID: <CAEAWyHerBjRnLvE92_w0YEknTAaDAkHsWB6Pts7+fLVqdgcLrQ@mail.gmail.com>
Subject: Re: [PATCH net-next v2 08/15] gve: refactor gve_init_priv for reset path
To: netdev@vger.kernel.org
Cc: joshwash@google.com, andrew+netdev@lunn.ch, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, ast@kernel.org, 
	daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com, 
	sdf@fomichev.me, willemb@google.com, jordanrhee@google.com, 
	jfraker@google.com, nktgrg@google.com, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 2, 2026 at 4:59=E2=80=AFPM Harshitha Ramamurthy
<hramamurthy@google.com> wrote:
>
> The driver does not need to renegotiate all properties with
> the device on a reset since those should stay constant through
> a reset. Hence change gve_init_priv() into a method that only
> sets these properties into the priv structure and hence needs
> to be only called once during gve_probe().
>
> To achieve this end state of gve_init_priv(), do the following:
> - introduce gve_adminq_init() which writes the driver version register
>   and allocates the AdminQ and call it in gve_probe()
> - move gve_adminq_get_device_properties() into gve_probe()
> - introduce gve_setup_device() which deals with device setup logic and
>   call it in gve_probe()
> - resetting no. of registered pages is moved into gve_register_qpls()
>   since that is a QPL specific property.
>
> With these changes, gve_adminq_get_device_properties() and
> gve_init_priv() are only called once during gve_probe.
> gve_reset_recovery() can now bypass full initialization and call these
> targeted setup functions directly.
>
> This prepares the driver to add mailbox mode's control plane
> initialization and device properties negotiation in the same place
> as is done in AdminQ mode in the upcoming patches when adding the
> mailbox ABI.
>
> These changes are only code movement, no functional change.
>
> Reviewed-by: Willem de Bruijn <willemb@google.com>
> Reviewed-by: Jordan Rhee <jordanrhee@google.com>
> Signed-off-by: Harshitha Ramamurthy <hramamurthy@google.com>
> ---
>  drivers/net/ethernet/google/gve/gve.h        |   2 +
>  drivers/net/ethernet/google/gve/gve_adminq.c |  12 +-
>  drivers/net/ethernet/google/gve/gve_adminq.h |   2 +-
>  drivers/net/ethernet/google/gve/gve_main.c   | 132 +++++++++++--------
>  4 files changed, 92 insertions(+), 56 deletions(-)
>
> diff --git a/drivers/net/ethernet/google/gve/gve.h b/drivers/net/ethernet=
/google/gve/gve.h
> index bd48c3d7a2b2..72588d201e5d 100644
> --- a/drivers/net/ethernet/google/gve/gve.h
> +++ b/drivers/net/ethernet/google/gve/gve.h
> @@ -1252,6 +1252,8 @@ static inline bool gve_is_clock_enabled(struct gve_=
priv *priv)
>         return priv->nic_ts_report;
>  }
>
> +void gve_adminq_write_version(u8 __iomem *driver_version_register);
> +
>  /* gqi napi handler defined in gve_main.c */
>  int gve_napi_poll(struct napi_struct *napi, int budget);
>
> diff --git a/drivers/net/ethernet/google/gve/gve_adminq.c b/drivers/net/e=
thernet/google/gve/gve_adminq.c
> index 923a5c737258..e7956d2768b6 100644
> --- a/drivers/net/ethernet/google/gve/gve_adminq.c
> +++ b/drivers/net/ethernet/google/gve/gve_adminq.c
> @@ -296,8 +296,10 @@ gve_process_device_options(struct gve_priv *priv,
>         return 0;
>  }
>
> -int gve_adminq_alloc(struct device *dev, struct gve_priv *priv)
> +static int gve_adminq_alloc(struct gve_priv *priv)
>  {
> +       struct device *dev =3D &priv->pdev->dev;
> +
>         priv->adminq_pool =3D dma_pool_create("adminq_pool", dev,
>                                             GVE_ADMINQ_BUFFER_SIZE, 0, 0)=
;
>         if (unlikely(!priv->adminq_pool))
> @@ -353,6 +355,14 @@ int gve_adminq_alloc(struct device *dev, struct gve_=
priv *priv)
>         return 0;
>  }
>
> +int gve_adminq_init(struct gve_priv *priv)
> +{
> +       struct gve_registers __iomem *reg_bar =3D priv->reg_bar0;
> +
> +       gve_adminq_write_version(&reg_bar->driver_version);
> +       return gve_adminq_alloc(priv);
> +}
> +
>  void gve_adminq_release(struct gve_priv *priv)
>  {
>         int i =3D 0;
> diff --git a/drivers/net/ethernet/google/gve/gve_adminq.h b/drivers/net/e=
thernet/google/gve/gve_adminq.h
> index ac3ef9fd8d24..d07e9c6f279d 100644
> --- a/drivers/net/ethernet/google/gve/gve_adminq.h
> +++ b/drivers/net/ethernet/google/gve/gve_adminq.h
> @@ -619,7 +619,7 @@ union gve_adminq_command {
>
>  static_assert(sizeof(union gve_adminq_command) =3D=3D 64);
>
> -int gve_adminq_alloc(struct device *dev, struct gve_priv *priv);
> +int gve_adminq_init(struct gve_priv *priv);
>  void gve_adminq_free(struct gve_priv *priv);
>  void gve_adminq_release(struct gve_priv *priv);
>  int gve_adminq_describe_device(struct gve_priv *priv);
> diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/eth=
ernet/google/gve/gve_main.c
> index d693caed7e3d..746ff69a28dd 100644
> --- a/drivers/net/ethernet/google/gve/gve_main.c
> +++ b/drivers/net/ethernet/google/gve/gve_main.c
> @@ -797,6 +797,8 @@ static int gve_register_qpls(struct gve_priv *priv)
>         int err;
>         int i;
>
> +       priv->num_registered_pages =3D 0;
> +

Commenting on Sashiko's report:

"When gve_reset_recovery() runs with was_up=3Dfalse, gve_open() is not
called and gve_register_qpls() is not reached, so num_registered_pages
is no longer zeroed on that path. Is that intentional, given the
symmetry with gve_unregister_qpl() decrements?

Although this number will get reset every time queues are created, to
be more symmetric, resetting this in gve_recover() which calls
gve_setup_device or in gve_setup_device is better. Will fix in v3.

>         num_tx_qpls =3D gve_num_tx_qpls(&priv->tx_cfg, gve_is_qpl(priv));
>         num_rx_qpls =3D gve_num_rx_qpls(&priv->rx_cfg, gve_is_qpl(priv));
>
> @@ -2414,6 +2416,33 @@ static void gve_set_buf_sizes(struct gve_priv *pri=
v)
>                 priv->header_buf_size =3D device_info->header_buf_size;
>  }
>
> +static int gve_setup_device(struct gve_priv *priv)
> +{
> +       int err;
> +
> +       priv->xsk_pools =3D bitmap_zalloc(priv->rx_cfg.max_queues, GFP_KE=
RNEL);

Commenting on Sashiko's report:

"This is a pre-existing issue, but does this allocation cause an XDP socket
DMA mapping leak and silently break XDP sockets during a device reset?
When a device reset occurs, such as from a transmit timeout, the teardown
process frees the priv->xsk_pools bitmap without unmapping the active XDP
socket DMA mappings."

Will send a separate net fix for this pre-existing issue.

> +       if (!priv->xsk_pools) {
> +               err =3D -ENOMEM;
> +               goto err;
> +       }
> +
> +       gve_set_netdev_xdp_features(priv);
> +       if (!gve_is_gqi(priv))
> +               priv->dev->xdp_metadata_ops =3D &gve_xdp_metadata_ops;
> +
> +       err =3D gve_setup_device_resources(priv);
> +       if (err)
> +               goto err_free_xsk_bitmap;
> +
> +       return 0;
> +
> +err_free_xsk_bitmap:
> +       bitmap_free(priv->xsk_pools);
> +       priv->xsk_pools =3D NULL;
> +err:
> +       return err;
> +}
> +
>  static const struct gve_ctrl_ops gve_adminq_ops =3D {
>         .map_db_bar             =3D gve_adminq_map_db_bar,
>         .unmap_db_bar           =3D gve_adminq_unmap_db_bar,
> @@ -2421,36 +2450,18 @@ static const struct gve_ctrl_ops gve_adminq_ops =
=3D {
>         .set_num_ntfy_blks      =3D gve_adminq_set_num_ntfy_blks,
>  };
>
> -static int gve_init_priv(struct gve_priv *priv, bool skip_describe_devic=
e)
> +static int gve_init_priv(struct gve_priv *priv)
>  {
>         struct gve_device_info *device_info =3D &priv->device_info;
>         int err;
>
> -       /* Set up the adminq */
> -       err =3D gve_adminq_alloc(&priv->pdev->dev, priv);
> -       if (err) {
> -               dev_err(&priv->pdev->dev,
> -                       "Failed to alloc admin queue: err=3D%d\n", err);
> -               return err;
> -       }
> -
> -       priv->num_registered_pages =3D 0;
> -
> -       if (skip_describe_device)
> -               goto setup_device;
> -
> -       device_info->queue_format =3D GVE_QUEUE_FORMAT_UNSPECIFIED;
> -       err =3D gve_adminq_get_device_properties(priv);
> -       if (err)
> -               goto err;
> -
>         priv->queue_format =3D priv->device_info.queue_format;
>
>         err =3D priv->ctrl_ops->set_num_ntfy_blks(priv);
>         if (err) {
>                 dev_err(&priv->pdev->dev,
>                         "Could not setup notify blocks: err=3D%d\n", err)=
;
> -               goto err;
> +               return err;
>         }
>
>         priv->ctrl_ops->set_num_queues(priv);
> @@ -2473,10 +2484,8 @@ static int gve_init_priv(struct gve_priv *priv, bo=
ol skip_describe_device)
>                 netif_set_tso_max_size(priv->dev, GVE_DQO_TX_MAX);
>         }
>
> -       if (gve_set_mtu(priv)) {
> -               err =3D -EINVAL;
> -               goto err;
> -       }
> +       if (gve_set_mtu(priv))
> +               return -EINVAL;
>
>         priv->num_event_counters =3D device_info->num_event_counters;
>
> @@ -2501,30 +2510,7 @@ static int gve_init_priv(struct gve_priv *priv, bo=
ol skip_describe_device)
>         priv->ts_config.tx_type =3D HWTSTAMP_TX_OFF;
>         priv->ts_config.rx_filter =3D HWTSTAMP_FILTER_NONE;
>         priv->nic_timestamp_supported =3D device_info->nic_timestamp_supp=
orted;
> -
> -setup_device:
> -       priv->xsk_pools =3D bitmap_zalloc(priv->rx_cfg.max_queues, GFP_KE=
RNEL);
> -       if (!priv->xsk_pools) {
> -               err =3D -ENOMEM;
> -               goto err;
> -       }
> -
> -       gve_set_netdev_xdp_features(priv);
> -       if (!gve_is_gqi(priv))
> -               priv->dev->xdp_metadata_ops =3D &gve_xdp_metadata_ops;
> -
> -       err =3D gve_setup_device_resources(priv);
> -       if (err)
> -               goto err_free_xsk_bitmap;
> -
>         return 0;
> -
> -err_free_xsk_bitmap:
> -       bitmap_free(priv->xsk_pools);
> -       priv->xsk_pools =3D NULL;
> -err:
> -       gve_adminq_free(priv);
> -       return err;
>  }
>
>  static void gve_teardown_priv_resources(struct gve_priv *priv)
> @@ -2554,15 +2540,29 @@ static int gve_reset_recovery(struct gve_priv *pr=
iv, bool was_up)
>  {
>         int err;
>
> -       err =3D gve_init_priv(priv, true);
> -       if (err)
> +       err =3D gve_adminq_init(priv);
> +       if (err) {
> +               dev_err(&priv->pdev->dev,
> +                       "Failed to alloc admin queue: err=3D%d\n", err);
>                 goto err;
> +       }
> +
> +       err =3D gve_setup_device(priv);
> +       if (err)
> +               goto err_free_adminq;
>         if (was_up) {
>                 err =3D gve_open(priv->dev);
>                 if (err)
> -                       goto err;
> +                       goto err_free_device;
>         }
>         return 0;
> +
> +err_free_device:
> +       gve_teardown_device_resources(priv);
> +       bitmap_free(priv->xsk_pools);
> +       priv->xsk_pools =3D NULL;
> +err_free_adminq:
> +       gve_adminq_free(priv);

"If gve_open() fails here, the error path tears down device resources (free=
ing
priv->ntfy_blocks) and the admin queue DMA pool via gve_adminq_free().
However, the net_device remains registered. If a user subsequently attempts=
 to
bring the interface up, gve_open() is invoked again. Because gve_open()
currently does not check if resources are initialized, it proceeds to call
gve_queues_start()."

Correct, if gve_open() fails, will just return error instead. Will fix in v=
3.

>  err:
>         dev_err(&priv->pdev->dev, "Reset failed! !!! DISABLING ALL QUEUES=
 !!!\n");
>         gve_turndown(priv);
> @@ -2605,7 +2605,7 @@ int gve_reset(struct gve_priv *priv, bool attempt_t=
eardown)
>         return err;
>  }
>
> -static void gve_write_version(u8 __iomem *driver_version_register)
> +void gve_adminq_write_version(u8 __iomem *driver_version_register)
>  {
>         const char *c =3D gve_version_prefix;
>
> @@ -2838,7 +2838,6 @@ static int gve_probe(struct pci_dev *pdev, const st=
ruct pci_device_id *ent)
>                 goto abort_with_pci_region;
>         }
>
> -       gve_write_version(&reg_bar->driver_version);
>         /* Get max queues to alloc etherdev */
>         max_tx_queues =3D ioread32be(&reg_bar->max_tx_queues);
>         max_rx_queues =3D ioread32be(&reg_bar->max_rx_queues);
> @@ -2885,13 +2884,28 @@ static int gve_probe(struct pci_dev *pdev, const =
struct pci_device_id *ent)
>         priv->rx_cfg.packet_buffer_size =3D GVE_DEFAULT_RX_BUFFER_SIZE;
>         priv->max_rx_buffer_size =3D GVE_DEFAULT_RX_BUFFER_SIZE;
>
> +       err =3D gve_adminq_init(priv);
> +       if (err) {
> +               dev_err(&priv->pdev->dev,
> +                       "Failed to alloc admin queue: err=3D%d\n", err);
> +               goto abort_with_netdev;
> +       }
> +
> +       priv->device_info.queue_format =3D GVE_QUEUE_FORMAT_UNSPECIFIED;
> +       err =3D gve_adminq_get_device_properties(priv);
> +       if (err) {
> +               dev_err(&priv->pdev->dev,
> +                       "Could not get device information: err=3D%d\n", e=
rr);
> +               goto abort_with_adminq;
> +       }
> +
>         /* Set adminq ctrl ops */
>         priv->ctrl_ops =3D &gve_adminq_ops;
>
>         err =3D priv->ctrl_ops->map_db_bar(priv);
>         if (err) {
>                 err =3D -ENOMEM;
> -               goto abort_with_netdev;
> +               goto abort_with_adminq;
>         }
>
>         gve_set_probe_in_progress(priv);
> @@ -2906,10 +2920,17 @@ static int gve_probe(struct pci_dev *pdev, const =
struct pci_device_id *ent)
>         priv->tx_cfg.max_queues =3D max_tx_queues;
>         priv->rx_cfg.max_queues =3D max_rx_queues;
>
> -       err =3D gve_init_priv(priv, false);
> +       err =3D gve_init_priv(priv);
>         if (err)
>                 goto abort_with_wq;
>
> +       err =3D gve_setup_device(priv);
> +       if (err) {
> +               dev_err(&priv->pdev->dev,
> +                       "Could not setup device: err=3D%d\n", err);
> +               goto abort_with_wq;
> +       }
> +
>         if (!gve_is_gqi(priv) && !gve_is_qpl(priv))
>                 dev->netmem_tx =3D NETMEM_TX_DMA;
>
> @@ -2932,6 +2953,9 @@ static int gve_probe(struct pci_dev *pdev, const st=
ruct pci_device_id *ent)
>  abort_with_unmap_db_bar:
>         priv->ctrl_ops->unmap_db_bar(priv);
>
> +abort_with_adminq:
> +       gve_adminq_free(priv);
> +
>  abort_with_netdev:
>         free_netdev(dev);
>
> --
> 2.54.0.1013.g208068f2d8-goog
>
