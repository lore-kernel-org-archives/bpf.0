Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE18F21A453
	for <bpf@vger.kernel.org>; Sun,  7 Jun 2026 22:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780872362; cv=pass; b=NlOQzEZp8rs+6AW6ARN67l3j77LBuB43vbyWBMJWkWYoTtMRaAA4HOrbesJ+KgWt2oYiLTye/wIJ4Jb+qhoKHuM6ukpHIXJ6IZ3/lPJsxhbDaalPlMQHGwH3LqHTGcc4/abXC/xW3rl0OsaERjQj/JS4z7FErrWrG4HbJozupgQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780872362; c=relaxed/simple;
	bh=Od3p1nZs4kL3mf+3N8X53ZY1nJanxX/3Ne+1K2ANvDs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bXtPmuQDxbWGrnLZZOehkL+PKJnijv86sw5bhgoJB1b8Y2VcdAK6vu2HgrnKrP+NRoQ92qdR9NrBj/UQ68nJIBndoggQrA4Ljf3ghZiRsRo/gKlSiHD4/z0rhTTpCqAlBB6SGITQ5E5DrGRPTnaLWDsMRs/gWLJ+dMQHLoF5gDI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=onOFzriG; arc=pass smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="onOFzriG"
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5aa2c25c632so3934964e87.1
        for <bpf@vger.kernel.org>; Sun, 07 Jun 2026 15:46:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780872359; cv=none;
        d=google.com; s=arc-20240605;
        b=S58Hc55D/m+IoQdcEN/wPHkyBmOIuxr4dfeZ3SKvTuxLKoDwEXKeqcBwIjvcu5kTcG
         h3cij8HKYxjq5it/ZcOjq9LUnJMB9ZwousEnwMIrGEnEpB7tQmpntY5P6uiGQpJSmKYm
         Q83ofioszhwDUWgsTcJ9wqD0GprhoBpk6aQyhrK0wGyt5q7BnEJ/I+hWtfKWCJkj3kj6
         ZQCswMUMzVY1Jv0HQcY9fXPr3cZxG9oXN1ouW+YDGRes18ga9K0FbzSbcuxDEQcD1c5z
         G2qL720sA5bJLdOF6VrLOaGeQsuRQ56+eYHZTXOUPvKO1WLmR4rDwlfp4p9DFWFd4NCn
         qBzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=mPhv20V/FZQuAxtv7EsKC5FmW4XMVDs9irxFJuAaIpw=;
        fh=M7MHeyurcVmQXJEBBYv17iMPfJROQeQ3bouNduby3DE=;
        b=ITI0RIRTFetl+LK8GsKBDvW+oD4JigFkJoh9ZVDZwdIg+v5XXgcS66wGKcQrrJI/ZD
         /mDiHSZTVHj3AzgPfX/8MG6ZTQBdZy7T1J6VroXi8xXVX0vsEXK4Rahi/SdsJqANUcYO
         csOJus26Ko3F955NB1iqjjfQYRgDtJJjGWYyxmwuOwJF/8SkalS36JrBE1KPDIlNzq3+
         klmWA4mDcZYwuLEqqdLPbyxaRTmc3EFyecFsxHZVHjuYpjpsVBaPfemur3J6uUjlA21H
         VAaUMqacSZWuJom1NYIlZpoMu8WHqhy9EaXSjujUvov0kiYlAkmzTw9DoSoDHppRTrMi
         CjUA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780872359; x=1781477159; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mPhv20V/FZQuAxtv7EsKC5FmW4XMVDs9irxFJuAaIpw=;
        b=onOFzriGuBqRkBSRoOn3IE6HC+khQcud2kKwKq/EwdBl5NH3WhH7XrfMwGs5dNjPwu
         unlWpCSCoPQvDo24dCisnOK15CWeoybebshz1RVEh2LhvZgaV7iWCnalneMoYzsJv9i7
         V+z0WxpGLqv3OvQxnidVJ8xP/3yLWIbvkIuUq//cmlStY8r6Amf7b2ZwDu4M/BbUXHf/
         wlvG1uhCHlXDvvvS5dmYyz1rFfL/KTfZDaFF2r5PKtLStiA37US636PcjT6djrDYdFrR
         HBIno/ND4BNsG7Wo7bs7XvwqxelViJ63ArldCUYtB/WrEcIE/wJgZw7fIgdKxzUaWV1u
         gDzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780872359; x=1781477159;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mPhv20V/FZQuAxtv7EsKC5FmW4XMVDs9irxFJuAaIpw=;
        b=jw7Jk877yrkkWLfLJ0asjtAqsssrdJMDECJK4pfuabRfCGCERoHOgZ/zoy/HBHgMWu
         J6wuoDwfaW74tke1gN+QLXB5RUpTO5KJvVp+eb8XabbgerkxMHgmhHGWomPnyc+vhQst
         jDwEhutowOIK2wV9wJNIaKSuTAYKuI1Dv7rGbhoI0w1cQ5h8pqUaciCuYkNkvXb8dmgq
         Ht9+QeKmtBqUMvyXKc/Qt1ieTrakyfz3klS++3jRrNz+V0tlekVZ1VFkZdgQdFxXyXQ0
         nn2LwMCn4FuLPchc0cbOiVnov4GoKtHTwIhUQW3wQNZWyhgWSVwcvE7+FvUz4W9uCxuy
         Cybg==
X-Forwarded-Encrypted: i=1; AFNElJ/rQ2m0Il8HM4WKk1I7NZ9HodF2BgKnVqNO4p8Qut8sqimvXxDXdqNka1izLQgB7JO3hJE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxl3YsRcroT6LHHvXG2L91l7vrwIDXXWKGPLtmmBYaiwdo8v3uW
	diqMUvD1w7WAU2+6h7BMCAS1y0yf7H1GCmbHR/Modg/vkmzDS0NrRzyAMPwXsIrRhxYg9kARCJG
	8MzcXzCtSl3owgeN82gr0cs5XTHXNDBzfekES0fxM
X-Gm-Gg: Acq92OExzWflNHRADUqqFYFaE82vgWtdRgglyzeooo+yUfrAR/v4vQuJlw7cb1IP3MY
	wSAAzOxMmOTYW4AvWi7xCx60+AT8PKjLho+jqxCZvqnhtmO0mXgXxMQ4up0Leclz4NTUohXLIGo
	OsiMrjYofabubgpMUhwKwcP10BR83ZDXom2NHZJ8RYw7X96jX55dPTGncAjubTzVbLfAPGPBQve
	h2ZPzmBRHVo8I5H/GHaQOg8enUhcpefA1ZSqezpygOe/5KIBeHosp6aPJTiCx6Y1EUaum8sP2tx
	DlydSEm8iu9oQXYDTZFBfsDBusDwledLjKM/wXAaWIwSBmJ2W6BMbw2M0FkpAw==
X-Received: by 2002:a05:6512:124c:b0:5aa:8822:c947 with SMTP id
 2adb3069b0e04-5aa8822c990mr3551512e87.49.1780872358521; Sun, 07 Jun 2026
 15:45:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260602235900.3050782-1-hramamurthy@google.com> <20260602235900.3050782-16-hramamurthy@google.com>
In-Reply-To: <20260602235900.3050782-16-hramamurthy@google.com>
From: Joshua Washington <joshwash@google.com>
Date: Sun, 7 Jun 2026 15:45:45 -0700
X-Gm-Features: AVVi8CfPT-3xuSXsUVnCEjKf1TGsQF-RmVKjI02NtfRoQCkSd3d7nafaupH8rR0
Message-ID: <CALuQH+UZNck+eaDb97CWb4NYEzzHTfOT7sLbKrTefePb2dChWQ@mail.gmail.com>
Subject: Re: [PATCH net-next v2 15/15] gve: add link status/speed ctrl ops
To: Harshitha Ramamurthy <hramamurthy@google.com>
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net, 
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
> From: Joshua Washington <joshwash@google.com>
>
> Refactor link status check to use a control plane op. Introduce
> new op for retrieving the link status in AQ mode. This op reads
> the link status from the device status register and stores the
> value in priv.
>
> Also add an op for retrieving link speed in AQ mode which calls into
> gve_adminq_report_link_speed.
>
> Reviewed-by: Willem de Bruijn <willemb@google.com>
> Reviewed-by: Jordan Rhee <jordanrhee@google.com>
> Signed-off-by: Joshua Washington <joshwash@google.com>
> Signed-off-by: Harshitha Ramamurthy <hramamurthy@google.com>
> ---
>  drivers/net/ethernet/google/gve/gve.h         |  5 ++++
>  drivers/net/ethernet/google/gve/gve_adminq.c  |  9 ++++++++
>  drivers/net/ethernet/google/gve/gve_adminq.h  |  1 +
>  drivers/net/ethernet/google/gve/gve_ethtool.c |  3 +--
>  drivers/net/ethernet/google/gve/gve_main.c    | 23 +++++++++++--------
>  5 files changed, 29 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/net/ethernet/google/gve/gve.h b/drivers/net/ethernet=
/google/gve/gve.h
> index 4283cb9b49de..c8ebbbb93942 100644
> --- a/drivers/net/ethernet/google/gve/gve.h
> +++ b/drivers/net/ethernet/google/gve/gve.h
> @@ -843,6 +843,8 @@ struct gve_device_info {
>   * @reset_flow_rules: Flush all flow rules from device
>   * @create_queues: Sends commands to the device to create TX/RX queues.
>   * @destroy_queues: Sends commands to the device to destroy TX/RX queues=
.
> + * @report_link_status: Set link status into @priv->link_up
> + * @report_link_speed: Set link status into @priv->link_speed

Sashiko says:
Should this read "Set link speed into @priv->link_speed" instead? ...

Will fix in v3.

>   */
>  struct gve_ctrl_ops {
>         int (*map_db_bar)(struct gve_priv *priv);
> @@ -863,6 +865,8 @@ struct gve_ctrl_ops {
>         int (*reset_flow_rules)(struct gve_priv *priv);
>         int (*create_queues)(struct gve_priv *priv);
>         int (*destroy_queues)(struct gve_priv *priv);
> +       int (*report_link_status)(struct gve_priv *priv);
> +       int (*report_link_speed)(struct gve_priv *priv);
>  };
>
>  struct gve_priv {
> @@ -964,6 +968,7 @@ struct gve_priv {
>
>         /* Gvnic device link speed from hypervisor. */
>         u64 link_speed;
> +       bool link_up;
>         bool up_before_suspend; /* True if dev was up before suspend */
>
>         bool mgmt_irq_requested;
> diff --git a/drivers/net/ethernet/google/gve/gve_adminq.c b/drivers/net/e=
thernet/google/gve/gve_adminq.c
> index 799381d24c71..b33633555b71 100644
> --- a/drivers/net/ethernet/google/gve/gve_adminq.c
> +++ b/drivers/net/ethernet/google/gve/gve_adminq.c
> @@ -1872,3 +1872,12 @@ int gve_adminq_create_queues(struct gve_priv *priv=
)
>
>         return err;
>  }
> +
> +int gve_adminq_report_link_status(struct gve_priv *priv)
> +{
> +       u32 status;
> +
> +       status =3D ioread32be(&priv->reg_bar0->device_status);
> +       priv->link_up =3D !!(GVE_DEVICE_STATUS_LINK_STATUS_MASK & status)=
;
> +       return 0;
> +}
> diff --git a/drivers/net/ethernet/google/gve/gve_adminq.h b/drivers/net/e=
thernet/google/gve/gve_adminq.h
> index 03e8318f7327..82413369dec9 100644
> --- a/drivers/net/ethernet/google/gve/gve_adminq.h
> +++ b/drivers/net/ethernet/google/gve/gve_adminq.h
> @@ -643,6 +643,7 @@ int gve_adminq_report_stats(struct gve_priv *priv, u6=
4 stats_report_len,
>                             dma_addr_t stats_report_addr, u64 interval);
>  int gve_adminq_verify_driver_compatibility(struct gve_priv *priv);
>  int gve_adminq_get_device_properties(struct gve_priv *priv);
> +int gve_adminq_report_link_status(struct gve_priv *priv);
>  int gve_adminq_report_link_speed(struct gve_priv *priv);
>  int gve_adminq_add_flow_rule(struct gve_priv *priv, struct gve_adminq_fl=
ow_rule *rule, u32 loc);
>  int gve_adminq_del_flow_rule(struct gve_priv *priv, u32 loc);
> diff --git a/drivers/net/ethernet/google/gve/gve_ethtool.c b/drivers/net/=
ethernet/google/gve/gve_ethtool.c
> index 54b623b678ce..aaf5b8b1671b 100644
> --- a/drivers/net/ethernet/google/gve/gve_ethtool.c
> +++ b/drivers/net/ethernet/google/gve/gve_ethtool.c
> @@ -749,12 +749,11 @@ static int gve_get_link_ksettings(struct net_device=
 *netdev,
>         int err =3D 0;
>
>         if (priv->link_speed =3D=3D 0)
> -               err =3D gve_adminq_report_link_speed(priv);
> +               err =3D priv->ctrl_ops->report_link_speed(priv);

Sashiko says:
---
This is a pre-existing issue, but I have a question about the timeout handl=
ing
inside gve_adminq_report_link_speed().

If gve_adminq_execute_cmd() returns a timeout error, the function drops the
error and immediately frees the DMA memory via dma_free_coherent(). However=
,
since a host CPU timeout does not guarantee the NIC has aborted the DMA
operation, could the hardware eventually execute a DMA write to the provide=
d
bus address after the memory has been reallocated, causing memory corruptio=
n?
This is another pre-existing issue, but could this ethtool call trigger a
use-after-free if a previous device reset failed?

If a device reset fails, gve_adminq_free() destroys the adminq_pool and fre=
es
the DMA memory backing priv->adminq. If user-space subsequently issues an
ethtool command like gve_get_link_ksettings, the driver invokes
report_link_speed() and eventually gve_adminq_issue_cmd().

If the device's tail counter was reset to 0, and the host's head counter is
still 0, could gve_adminq_issue_cmd() write the command payload into the
now-dangling priv->adminq buffer?
---

I think that this is a larger scale issue that affects all admin queue
commands that could time out. I think a solution here would be:

1) submit a net fix to allocate from dma pool in gve_amdinq_report_link_spe=
ed
2) follow up with a patch that invokes a reset on a timed out AQ command.

As far as any cross-reset failures go, that would require a much
larger behavioral change in the driver, as the driver assumes that if
the actual hardware reset fails, it is an =E2=80=9Cunrecoverable platform
error=E2=80=9D and makes no promises about future driver behavior.

>
>         cmd->base.speed =3D priv->link_speed;
>
>         cmd->base.duplex =3D DUPLEX_FULL;
> -
>         return err;
>  }
>
> diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/eth=
ernet/google/gve/gve_main.c
> index dfc734d8bec9..181ec6919051 100644
> --- a/drivers/net/ethernet/google/gve/gve_main.c
> +++ b/drivers/net/ethernet/google/gve/gve_main.c
> @@ -1475,15 +1475,15 @@ static int gve_close(struct net_device *dev)
>         return err;
>  }
>
> -static void gve_handle_link_status(struct gve_priv *priv, bool link_stat=
us)
> +static void gve_handle_link_status(struct gve_priv *priv)
>  {
>         if (!gve_get_napi_enabled(priv))
>                 return;
>
> -       if (link_status =3D=3D netif_carrier_ok(priv->dev))
> +       if (priv->link_up =3D=3D netif_carrier_ok(priv->dev))
>                 return;
>
> -       if (link_status) {
> +       if (priv->link_up) {

Sashiko says:
Is there a time-of-check to time-of-use race here?
Because priv->link_up is read twice in quick succession without protection,
and could be modified concurrently by gve_adminq_report_link_status() runni=
ng
in the lockless service_task workqueue, can the value change between the tw=
o
checks?
Would using READ_ONCE() and saving the result to a local variable prevent
unintended compiler optimizations and state changes?

Will fix in v3.

>                 netdev_info(priv->dev, "Device link is up.\n");
>                 netif_carrier_on(priv->dev);
>         } else {
> @@ -1510,7 +1510,6 @@ static int gve_set_xdp(struct gve_priv *priv, struc=
t bpf_prog *prog,
>  {
>         struct bpf_prog *old_prog;
>         int err =3D 0;
> -       u32 status;
>
>         old_prog =3D READ_ONCE(priv->xdp_prog);
>         if (!netif_running(priv->dev)) {
> @@ -1537,8 +1536,8 @@ static int gve_set_xdp(struct gve_priv *priv, struc=
t bpf_prog *prog,
>                 bpf_prog_put(old_prog);
>
>  out:
> -       status =3D ioread32be(&priv->reg_bar0->device_status);
> -       gve_handle_link_status(priv, GVE_DEVICE_STATUS_LINK_STATUS_MASK &=
 status);
> +       priv->ctrl_ops->report_link_status(priv);
> +       gve_handle_link_status(priv);
>         return err;
>  }
>
> @@ -1971,11 +1970,11 @@ static void gve_turnup(struct gve_priv *priv)
>
>  static void gve_turnup_and_check_status(struct gve_priv *priv)
>  {
> -       u32 status;
> +       const struct gve_ctrl_ops *ops =3D priv->ctrl_ops;
>
>         gve_turnup(priv);
> -       status =3D ioread32be(&priv->reg_bar0->device_status);
> -       gve_handle_link_status(priv, GVE_DEVICE_STATUS_LINK_STATUS_MASK &=
 status);
> +       ops->report_link_status(priv);
> +       gve_handle_link_status(priv);
>  }
>
>  static struct gve_notify_block *gve_get_tx_notify_block(struct gve_priv =
*priv,
> @@ -2299,12 +2298,14 @@ static void gve_service_task(struct work_struct *=
work)
>  {
>         struct gve_priv *priv =3D container_of(work, struct gve_priv,
>                                              service_task);
> +       const struct gve_ctrl_ops *ops =3D priv->ctrl_ops;
>         u32 status =3D ioread32be(&priv->reg_bar0->device_status);
>
>         gve_handle_status(priv, status);
>
>         gve_handle_reset(priv);
> -       gve_handle_link_status(priv, GVE_DEVICE_STATUS_LINK_STATUS_MASK &=
 status);
> +       ops->report_link_status(priv);
> +       gve_handle_link_status(priv);
>  }
>
>  static void gve_set_netdev_xdp_features(struct gve_priv *priv)
> @@ -2427,6 +2428,8 @@ static const struct gve_ctrl_ops gve_adminq_ops =3D=
 {
>         .teardown_mgmt_irq      =3D gve_adminq_teardown_mgmt_irq,
>         .create_queues          =3D gve_adminq_create_queues,
>         .destroy_queues         =3D gve_adminq_destroy_queues,
> +       .report_link_status     =3D gve_adminq_report_link_status,
> +       .report_link_speed      =3D gve_adminq_report_link_speed,
>  };
>
>  static int gve_init_priv(struct gve_priv *priv)
> --
> 2.54.0.1013.g208068f2d8-goog
>


--=20

Joshua Washington | Software Engineer | joshwash@google.com | (414) 366-442=
3
