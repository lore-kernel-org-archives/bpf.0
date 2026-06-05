Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18B4039A06B
	for <bpf@vger.kernel.org>; Fri,  5 Jun 2026 03:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780631831; cv=pass; b=BTz6yTVIRL0qrKMzu+U0zt/MZEd60PHlPEQddv5f97FpMdJ8u8W2nnM7vbXcnGgEgbCELUol/M/xJxXKTJVRXu1NQNKFcL9EWbImD5dLd+hurk6ENmVlQxzITfjJOZExhd8YhCnVHHm3NPFIeautPA2x4UsdcQ9MTykTgIKkwy0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780631831; c=relaxed/simple;
	bh=eVq2gnoXxl2DuLtBj8boz7pphOMQCCoquCQz50iid5g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p9OPcpKI7WUc7Pn3CDEFGK6kO27jR9lVlfiKnbkWVPewgmkvlw/g+VNwMb8BhuyvK7CdUSHVjXVAJ0RM+H0ThsV0LKa22ajcSd165ylWwLrDJ9C2/1WqcDLnRGZzlyu/Fj+e/hdmV7OnIiM0P1bXn4llkl3KwF6VfSyi5JkyndY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=n8lZai3H; arc=pass smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="n8lZai3H"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2c0b1a48855so69965ad.0
        for <bpf@vger.kernel.org>; Thu, 04 Jun 2026 20:57:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780631829; cv=none;
        d=google.com; s=arc-20240605;
        b=RMB02y0+vtOxNdRWJ8FbeRbjyGEBJOsYqpqYW4ypPxZeFzC0gtL8Ls5hHihD/+GVRf
         GaYJwwDVAGSVXprKP+3Ay+fHR7m+ShEIUsKY8q0HbFyenb7tLOMCk20RveVdJbQSh5pV
         5PJ48yjaHuPQyvmaQaSxHhknh+PC63lHGmrogMT3PFQIs1fYiMevmS8pJZ+iHTpRpZ/N
         QGZDfj1Rm3QieK2eYXWAf7iBEnuwgz4pbTv/x5p4thgiExNzwxs4bMROj5Jcz4JlRQeo
         CO0A3N2eS1021GQqvDQe50fZzwbHBv+N7oG0ptRs+jTfmoVsU45B/dLEVCi5p+duHFz1
         L7/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=iq7W9i9+xoLlnps1Syt0aIJ4mwxy1YJhpqJiWdE/ptE=;
        fh=pBRMLRLsTevk5jI9r+ECqmpxJf34zczB2kpuS6cNtOU=;
        b=Qa995PkZsNjDWXikQwmHwr7kYJFvNAx+Rt3x/NBi4/ZydPMHXV+fKZcY1rejwQdq/H
         9Cp/nxhhMoGRKrFgV7lO3syVqdIlIF1yOpYWwSjgW7lLhcsQzNaO4caW+XMB1O3Y6AeO
         7bOp4h4UjfcpWoRH1V2AQeKC6pwqY4qF0YSA6dFqBzZxDxtEVwpmnDZ5MbCF/fixhoao
         5fQypL3yzFhffPICsDt2CV4DU/YX2F/TMlqSFxqEWnwaRYd4ZdaafQLLOPfN8SCobCZe
         G6+p1Yf9UGBF0017kGdeVLgJUPiRXF2tYphlsmY7XF3qQ9od2RuGgqlDqpu1VD9v66Bk
         uRmg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780631829; x=1781236629; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iq7W9i9+xoLlnps1Syt0aIJ4mwxy1YJhpqJiWdE/ptE=;
        b=n8lZai3H4v3BbVZA+3Oba6iuRKSNhymWHZrs8k6phs0Rj8J1C1lpFwwSkeGNU6nstv
         2zTypFSvZPIlwUTTFIpMBI52RWTNXKwkvquBJNG5aR4U0TQFPN3K9h4QFdXTq55oWFci
         3j6QDlBjc3jUvzj7PtIOvqG/yNoAX1CCier9Rq99R1MwJPVyjrJ53l5endyVWEhJiQHD
         xZoTp+mwtT9lzm24WfZ5yWntfOF9/qiqU6TT6tQThP+puq8yA6EBBV9k6gLwazCWiaT9
         LFKMByzt4W5PZznS+RSYcmbI7hhRTuzrOg8Smj3BaVkV5TYxrYf8+edQBpvmOAeZ3MeE
         KHjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780631829; x=1781236629;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iq7W9i9+xoLlnps1Syt0aIJ4mwxy1YJhpqJiWdE/ptE=;
        b=hMmhmmHhFXXUe0bMbB/GvnRm8Q1Oz3cdta3Hsy5T4UWTdibWMyb12ksFmXqesxVbO8
         MdK4zVCLQ1noCuLbOPWad027bORmBLNWoZLmrLgRxm9/EAY0t48+OSuujR6fDye1YQ15
         +0r2j1xyPlcNy3aXDLehJ0zNoco4fmqd2tpbM6X9BC+qdg7RU2FtDweEnbQSmbj+z4eg
         6IB4A7mrAHUCY5chDx9TAj669holxrPLh8ASrI6xdrV7BMW4FhQKo3wcMWuF6hH6Y5gn
         U1BGxTUlaR5+sdJOy2sHWe8y68G95btqe5Mf6PzdaIh79CSzmIoYJYKO3AN2rYk5OjDz
         9SwA==
X-Forwarded-Encrypted: i=1; AFNElJ8OBtnSnoyzxRKZUiBys+7n9T+zsUoEcd6rcM7p4P5J2L4EPiaBdq1+L6ILLqLHXfuC9TE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAHS4w4dTuP0VM6G6uahCY5lZBWl7roiM+cVrdLBIAbBNI3b80
	tQVxMdk33tlts2PfSIYe4J+LrbsXJA6u+kXYIxgjUVKk9euUMA64ZHEhAhZg5d7HulNt1W1S7m6
	Fb9SoLvBu4AYT0WXIe95CNRu1COSCgQc0Xzma+Za5
X-Gm-Gg: Acq92OFDOFm5DngXKfGPcoayJ2knNdarLky96LjhEwDcsscHW8mBZzG9/zdJ03E8BOJ
	Qz7HUXyQ2EDnlUr2vYa9gamEqLo/WU0jAfX6CnAVgoRczXJ8mphbZgA+KxMKOGWE1SgcdOOMhBQ
	2TngD9M37bxj+cYheloV+cEV6hsp4MGPOqRxOV/IQpcrYDwp7Jovk4CZLNgYlL8B4p+EiN74Gv/
	LvoKsg15Or/yBoY4mQeYauW76u5zAvWnKru/NVgYdH/7BPnNvXTfyK4Ej9wAzVOh6XGzF41yKg/
	ii2Awcj3t2W9tgiXaTeg5m1tztXY6NCDu0JZKlx3znDcttQAselE0Rs/FGPTPWP6gAe5ZTf4Y+3
	t5k46NSEho51xL9SJiUY=
X-Received: by 2002:a17:903:1aed:b0:2b9:e831:5e5c with SMTP id
 d9443c01a7336-2c1eb72a130mr645275ad.4.1780631828851; Thu, 04 Jun 2026
 20:57:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260602235900.3050782-1-hramamurthy@google.com> <20260602235900.3050782-15-hramamurthy@google.com>
In-Reply-To: <20260602235900.3050782-15-hramamurthy@google.com>
From: Harshitha Ramamurthy <hramamurthy@google.com>
Date: Thu, 4 Jun 2026 20:56:57 -0700
X-Gm-Features: AVHnY4LNyIXn-v77q7_757OSS5W3GEkr_HncoLwG4fOF5npzYI-WF-Xu3jhkP8U
Message-ID: <CAEAWyHedn-5QgbuiyPA2UkpyMH6Y7Bw35JhEUjLp+k7+-a9NGA@mail.gmail.com>
Subject: Re: [PATCH net-next v2 14/15] gve: add ctrl ops to for queue operations
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
> Add the next few control ops to
>
> - create queues
> - destroy queues
>
> These changes are just moving existing code into ops, no functional
> change.
>
> Reviewed-by: Willem de Bruijn <willemb@google.com>
> Reviewed-by: Jordan Rhee <jordanrhee@google.com>
> Signed-off-by: Harshitha Ramamurthy <hramamurthy@google.com>
> ---
> Changes in v2:
> - Fixed typo in commit message (exisiting -> existing)
>
>  drivers/net/ethernet/google/gve/gve.h        |  4 ++
>  drivers/net/ethernet/google/gve/gve_adminq.c | 50 ++++++++++++++++++++
>  drivers/net/ethernet/google/gve/gve_adminq.h |  3 +-
>  drivers/net/ethernet/google/gve/gve_main.c   | 41 ++++------------
>  4 files changed, 65 insertions(+), 33 deletions(-)
>
> diff --git a/drivers/net/ethernet/google/gve/gve.h b/drivers/net/ethernet=
/google/gve/gve.h
> index b2e578b3d450..4283cb9b49de 100644
> --- a/drivers/net/ethernet/google/gve/gve.h
> +++ b/drivers/net/ethernet/google/gve/gve.h
> @@ -841,6 +841,8 @@ struct gve_device_info {
>   * @configure_rss: Set up default RSS configuration
>   * @setup_stats_report: Set up DMA region for stats report (AdminQ only)
>   * @reset_flow_rules: Flush all flow rules from device
> + * @create_queues: Sends commands to the device to create TX/RX queues.
> + * @destroy_queues: Sends commands to the device to destroy TX/RX queues=
.
>   */
>  struct gve_ctrl_ops {
>         int (*map_db_bar)(struct gve_priv *priv);
> @@ -859,6 +861,8 @@ struct gve_ctrl_ops {
>                                   dma_addr_t stats_report_addr,
>                                   u64 interval_ms); /* AQ-specific */
>         int (*reset_flow_rules)(struct gve_priv *priv);
> +       int (*create_queues)(struct gve_priv *priv);
> +       int (*destroy_queues)(struct gve_priv *priv);
>  };
>
>  struct gve_priv {
> diff --git a/drivers/net/ethernet/google/gve/gve_adminq.c b/drivers/net/e=
thernet/google/gve/gve_adminq.c
> index 5dc5c63cee32..799381d24c71 100644
> --- a/drivers/net/ethernet/google/gve/gve_adminq.c
> +++ b/drivers/net/ethernet/google/gve/gve_adminq.c
> @@ -941,6 +941,30 @@ static void gve_set_default_rss_sizes(struct gve_pri=
v *priv)
>         }
>  }
>
> +int gve_adminq_destroy_queues(struct gve_priv *priv)
> +{
> +       int num_tx_queues =3D gve_num_tx_queues(priv);
> +       int err;
> +
> +       err =3D gve_adminq_destroy_tx_queues(priv, 0, num_tx_queues);
> +       if (err) {
> +               netif_err(priv, drv, priv->dev,
> +                         "failed to destroy tx queues\n");
> +               /* This failure will trigger a reset - no need to clean u=
p */
> +               return err;
> +       }
> +       netif_dbg(priv, drv, priv->dev, "destroyed tx queues\n");
> +       err =3D gve_adminq_destroy_rx_queues(priv, priv->rx_cfg.num_queue=
s);
> +       if (err) {
> +               netif_err(priv, drv, priv->dev,
> +                         "failed to destroy rx queues\n");
> +               /* This failure will trigger a reset - no need to clean u=
p */
> +               return err;
> +       }
> +       netif_dbg(priv, drv, priv->dev, "destroyed rx queues\n");
> +       return err;
> +}
> +
>  static void gve_enable_supported_features(struct gve_priv *priv,
>                                           u32 supported_features_mask,
>                                           const struct gve_device_option_=
jumbo_frames
> @@ -1822,3 +1846,29 @@ void gve_adminq_teardown_mgmt_irq(struct gve_priv =
*priv)
>                 priv->mgmt_irq_requested =3D false;
>         }
>  }
> +
> +int gve_adminq_create_queues(struct gve_priv *priv)
> +{
> +       int num_tx_queues =3D gve_num_tx_queues(priv);
> +       int err;
> +
> +       err =3D gve_adminq_create_tx_queues(priv, 0, num_tx_queues);
> +       if (err) {
> +               netif_err(priv, drv, priv->dev, "failed to create %d tx q=
ueues\n",
> +                         num_tx_queues);
> +               return err;
> +       }
> +       netif_dbg(priv, drv, priv->dev, "created %d tx queues\n",
> +                 num_tx_queues);
> +
> +       err =3D gve_adminq_create_rx_queues(priv, priv->rx_cfg.num_queues=
);
> +       if (err) {
> +               netif_err(priv, drv, priv->dev, "failed to create %d rx q=
ueues\n",
> +                         priv->rx_cfg.num_queues);
> +               return err;
> +       }
> +       netif_dbg(priv, drv, priv->dev, "created %d rx queues\n",
> +                 priv->rx_cfg.num_queues);
> +
> +       return err;
> +}
> diff --git a/drivers/net/ethernet/google/gve/gve_adminq.h b/drivers/net/e=
thernet/google/gve/gve_adminq.h
> index ff656fb4f113..03e8318f7327 100644
> --- a/drivers/net/ethernet/google/gve/gve_adminq.h
> +++ b/drivers/net/ethernet/google/gve/gve_adminq.h
> @@ -628,6 +628,8 @@ int gve_adminq_configure_device_resources(struct gve_=
priv *priv,
>                                           dma_addr_t db_array_bus_addr,
>                                           u32 num_ntfy_blks);
>  int gve_adminq_deconfigure_device_resources(struct gve_priv *priv);
> +int gve_adminq_create_queues(struct gve_priv *priv);
> +int gve_adminq_destroy_queues(struct gve_priv *priv);
>  int gve_adminq_create_tx_queues(struct gve_priv *priv, u32 start_id, u32=
 num_queues);
>  int gve_adminq_destroy_tx_queues(struct gve_priv *priv, u32 start_id, u3=
2 num_queues);
>  int gve_adminq_create_single_rx_queue(struct gve_priv *priv, u32 queue_i=
ndex);
> @@ -661,5 +663,4 @@ int gve_adminq_request_db_info(struct gve_priv *priv)=
;
>  void gve_adminq_free_db_resources(struct gve_priv *priv);
>  int gve_adminq_setup_mgmt_irq(struct gve_priv *priv);
>  void gve_adminq_teardown_mgmt_irq(struct gve_priv *priv);
> -
>  #endif /* _GVE_ADMINQ_H */
> diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/eth=
ernet/google/gve/gve_main.c
> index 9d00093826e3..dfc734d8bec9 100644
> --- a/drivers/net/ethernet/google/gve/gve_main.c
> +++ b/drivers/net/ethernet/google/gve/gve_main.c
> @@ -841,33 +841,18 @@ static int gve_unregister_qpls(struct gve_priv *pri=
v)
>
>  static int gve_create_rings(struct gve_priv *priv)
>  {
> -       int num_tx_queues =3D gve_num_tx_queues(priv);
>         int err;
>         int i;
>
> -       err =3D gve_adminq_create_tx_queues(priv, 0, num_tx_queues);
> +       err =3D priv->ctrl_ops->create_queues(priv);
>         if (err) {
> -               netif_err(priv, drv, priv->dev, "failed to create %d tx q=
ueues\n",
> -                         num_tx_queues);
> -               /* This failure will trigger a reset - no need to clean
> -                * up
> -                */
> -               return err;
> -       }
> -       netif_dbg(priv, drv, priv->dev, "created %d tx queues\n",
> -                 num_tx_queues);
> -
> -       err =3D gve_adminq_create_rx_queues(priv, priv->rx_cfg.num_queues=
);
> -       if (err) {
> -               netif_err(priv, drv, priv->dev, "failed to create %d rx q=
ueues\n",
> -                         priv->rx_cfg.num_queues);
> +               netif_err(priv, drv, priv->dev,
> +                         "failed to create queues\n");

Commenting on Sashiko's report:
https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260602235900.3050782-=
1-hramamurthy%40google.com

"The commit message states "These changes are just moving existing code
into ops, no functional change." but on the failure path the driver now
emits two error messages instead of one. Is this intended?"

Will remove double logging in v3.

>                 /* This failure will trigger a reset - no need to clean
>                  * up
>                  */
>                 return err;
>         }
> -       netif_dbg(priv, drv, priv->dev, "created %d rx queues\n",
> -                 priv->rx_cfg.num_queues);
>
>         if (gve_is_gqi(priv)) {
>                 /* Rx data ring has been prefilled with packet buffers at=
 queue
> @@ -1022,26 +1007,16 @@ static int gve_queues_mem_alloc(struct gve_priv *=
priv,
>
>  static int gve_destroy_rings(struct gve_priv *priv)
>  {
> -       int num_tx_queues =3D gve_num_tx_queues(priv);
>         int err;
>
> -       err =3D gve_adminq_destroy_tx_queues(priv, 0, num_tx_queues);
> +       err =3D priv->ctrl_ops->destroy_queues(priv);
> +
>         if (err) {
> -               netif_err(priv, drv, priv->dev,
> -                         "failed to destroy tx queues\n");
>                 /* This failure will trigger a reset - no need to clean u=
p */
> -               return err;
> -       }
> -       netif_dbg(priv, drv, priv->dev, "destroyed tx queues\n");
> -       err =3D gve_adminq_destroy_rx_queues(priv, priv->rx_cfg.num_queue=
s);
> -       if (err) {
>                 netif_err(priv, drv, priv->dev,
> -                         "failed to destroy rx queues\n");
> -               /* This failure will trigger a reset - no need to clean u=
p */
> -               return err;
> +                         "failed to destroy queues\n");
>         }
> -       netif_dbg(priv, drv, priv->dev, "destroyed rx queues\n");
> -       return 0;
> +       return err;
>  }
>
>  static void gve_queues_mem_free(struct gve_priv *priv,
> @@ -2450,6 +2425,8 @@ static const struct gve_ctrl_ops gve_adminq_ops =3D=
 {
>         .free_db_resources      =3D gve_adminq_free_db_resources,
>         .setup_mgmt_irq         =3D gve_adminq_setup_mgmt_irq,
>         .teardown_mgmt_irq      =3D gve_adminq_teardown_mgmt_irq,
> +       .create_queues          =3D gve_adminq_create_queues,
> +       .destroy_queues         =3D gve_adminq_destroy_queues,
>  };
>
>  static int gve_init_priv(struct gve_priv *priv)
> --
> 2.54.0.1013.g208068f2d8-goog
>
