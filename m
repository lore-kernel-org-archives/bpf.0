Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F7FF3672BE
	for <bpf@vger.kernel.org>; Sun,  7 Jun 2026 22:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780870864; cv=pass; b=fK5KHlxKbNSNv/PMNHwOr4ylHp1Hyf9Tdtqf4hMJtpGfPV2y+rh9AvgmKPA8MnUYXo0eA5mLNaF0DNKL9T1sUjheGg/Gbgl14Nh8VisozJWOwexJI3i+SJynXFl1yDJxLzFuJIpFyjYEuLXf3p+6nvVcExVxiUa0dXQB7UUre1c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780870864; c=relaxed/simple;
	bh=T6YwFFiTbPP97v757nRZ+9uWVRo/lyTa0S+9iCExjcg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mR1cKiSTUUpx/dJSEa5z9WuldKaYVdGACPVAlC0e5Aynp7fJHtSdV3Rr6czOtANymSdCuJuhOJizuRsbN8qd16f0hmaahHXZhepv+UA6lbYV51MnDW9b1SuB7xqgptESim2n37MKtDrNtZcHkZtAo9RS7A5f7Oi983X9eLP5NWo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZIJVEWLz; arc=pass smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZIJVEWLz"
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5aa68d65d24so4027767e87.1
        for <bpf@vger.kernel.org>; Sun, 07 Jun 2026 15:21:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780870861; cv=none;
        d=google.com; s=arc-20240605;
        b=TgkKtQdob73xfFQsAufil4wBUKviaY5haX6dlYHs8g5OmZWKUK4K/L7DpIibfLX31/
         8ceID6VOrCc///ZpGxHDZ/+dpHUSh9o1Ryw84Y4HyV8nHjFt+vd8ETuQ3umio0L66yz6
         UYVi3oPUIZIFRTVxs4mgtCkituCBNs2B7kWMEha+cdKdaaR6qegXwj3n+Tkr9OKEkPlS
         IZ8qM3hO5xjYsLO/TceOwCHfZ1WU/sE6H8udAc+O2gPX/00+Q/ltPamvIKN9sSY7+368
         xQFC9YybqDzcZhS6ZBB3tfopqAYC9v68rSHa66ZETsm8sr6Axmo4oCaTtKBQ4cUCMQTC
         RvNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=jGIia5G0AYz7TuXl0xL7gGzZZX+99+FeG3Bq4CNQgwQ=;
        fh=QMLFliMdACPnsayVx2gxno75EgX0+FRWN0t24zA5jX4=;
        b=gQeB/rNi2w7cuB2jPjiIz+bUrJV08Vuo37sxGmUUDpJABKIn7Ayyq34KXCOyEFYlqg
         9WBz1vOiJXVcVZIMGllroSlYSdIz1SCx+lmahnME9lWowXx0oE9tNFRqdt7zv68nptw3
         MQkDgNU7sDkoenD9BNZnxjE+zqwx3jhA3dY4HL9/HQbBk1+xW+rMT1cbc5EHRrG1nOeI
         GCEqBkD/jI8Q0vunQ8pXR7esam3hvMYEkeZllQNTGGeSDvc/IMHiiZj4EFU1aCdYdxoG
         YL4+03JRr0VPBCAwWHUM/R7uoT12qWICH5vU/AeOU0A6fDh19K9Jh3WIfXxTeXggDhlF
         iEjQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780870861; x=1781475661; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jGIia5G0AYz7TuXl0xL7gGzZZX+99+FeG3Bq4CNQgwQ=;
        b=ZIJVEWLz3Sbn8b3KDqtZF0jBM52LnHK8XkqMB9mwRWXsiuGDJdn6TEhDEtnytdaB3+
         iLqkCTTZlqMo4J1/oK7S8szTSDaiDD4Z3JXtM5VSOztk5floqxiFyaEYTXt5cNzO+IBx
         uRQjjiMjdPsN4kTaDcfpuXDeG++Gr7oDdnSp0NgSVd+FUCpcqWMnGcmkzQPi8HFb5MFn
         pBGxxHG682ONZI7UKk1u8A0AVcpZwAlRwET4euM/AGau7Aq6Hp2LBz2uPvhNFLrGfEVO
         uILILvLgqkMwdepxjwoR7JfSWQV5uvFQtiWTKYSGE3LjiCH3Mi/abTwyTPlqjfAQa+td
         sHhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780870861; x=1781475661;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jGIia5G0AYz7TuXl0xL7gGzZZX+99+FeG3Bq4CNQgwQ=;
        b=NrcJu1DJawJu0S272kJnZv/e3K07hVFIQjjC8oLOIO3l2pjVufICL2lQpOTpypxWa1
         wd2zjb0gw6kZWA707cL31tYSBdSnwHjmhrncEa5QzrhKstidIw+cgziixtj+MkIRMPI4
         TYlVK9DVZ/jk4FHz4yehhzUkdqUGvr3HWKAn5ZsR4TauuSbViFjFBQoYso1c38uyrSIh
         Jsyx2fEwv6CCBJS8ZEwCUAxzH5Gpex+rDtnvkaG94WAn6+420CXibLaMWAto0NcQKXPd
         sxSlZTGLTrrNNoME3pos0u0FnOlv1p+XZ/BYcVjy2K/P8WC+ZZbVUYSEjx8eG+UA6x9H
         fwuA==
X-Forwarded-Encrypted: i=1; AFNElJ8vjgHS+nxsTyL3XjLuunnCMxMRUCpqP+MJTsKVHQhAFvQOxpeW13ESm7ihXuWkrTQQ6Yk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCM3vSysO4tVXayWPNJMeS4cUTDa0q7NSWTTDi0GGiKCvS0IOs
	+95SskNW+7Ec+pIiEXeGk4ZBo1aXAF5WVQphsY4/QYPWoEZaZJbmBTlcYj3jBrRNf0PzPf8TEB2
	rbrfX+vynWLFNDpP0PPrPTITGNlxK2WFZZdLFVxfd
X-Gm-Gg: Acq92OHgxMDJ45av/qj7EVYl5VU1pXFLOxxd6MJIOJbtTX2i0F/6hnWOwd6NocIeZ80
	wODDwGU1dLiu9+QlwghcglwiPGJ8qkhz5F7iFtlMG0PZGhTHX4HISTmw4gdv2a7xunjao6A91hI
	Lh55EMFR/geVUBHHVNzIMfSyDUXVyoSq41khIPYv8jHfSzoh/S1xdGY9rE1eRr1IhX9t4K4dAj/
	MDhsSuENf+qOmEdGwYK2NSEHDFdeBN020WutE3nw6RvP1Mav+XcFja0n3cKcgTKcbdyoDB4dHwH
	Jul3o5kqjCqHqIsTM3krV+LkW1S0okQiJ1hJRU5+PXQfUhr2koo=
X-Received: by 2002:a05:6512:130e:b0:5aa:7126:c663 with SMTP id
 2adb3069b0e04-5aa87b62d6cmr3803061e87.5.1780870859914; Sun, 07 Jun 2026
 15:20:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260602235900.3050782-1-hramamurthy@google.com> <20260602235900.3050782-10-hramamurthy@google.com>
In-Reply-To: <20260602235900.3050782-10-hramamurthy@google.com>
From: Joshua Washington <joshwash@google.com>
Date: Sun, 7 Jun 2026 15:20:45 -0700
X-Gm-Features: AVVi8CdrECp-zIcI6YlZ7lvGGsH49-3nsjbOqboeShrrgKzgJxGBp8074-qJf9A
Message-ID: <CALuQH+UK3Q_TgGnGEZwTq13+_skqsDU_9Pi99=dq8AzrD-hD+g@mail.gmail.com>
Subject: Re: [PATCH net-next v2 09/15] gve: simplify reset logic
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
> Current GVE reset logic is quite complex, with a number of methods with
> similar names and functionalities. This complexity has allowed a number
> of bugs to enter the reset/recovery path, including the potential for
> reset loops if an operation fails during teardown.
>
> Simplify the reset path by doing the following:
> 1) Removing recursive resets. Recursive resets have two major issues.
>    First, there is the potential for stack overflows if resets are
>    invoked too many times in a row. Second, long recursive calls mean
>    that GVE never gives up the RTNL lock, or at the very least holds it
>    for too long. If a reset must occur anywhere during the
>    reset/recovery path, it should be scheduled as a separate task.
> 2) Removing resets during teardown. This is partly covered by removing
>    recursive resets, but the primary goal in this case is to ensure that
>    the driver is capable of actually executing a hardware reset if
>    something goes wrong with a control plane operation. As it stands, if
>    `deconfigure_device_resources` fails, for example, GVE will preempt
>    its reset with another reset without actually invoking a hardware
>    reset, which could actually help with recovery.
> 3) Decompose allocation/de-allocation and setup/teardown. Performing
>    allocation and setup for each control plane system (RSS, ptype map,
>    etc) leaves many more error conditions to handle, causing teardown in
>    the case of failures to be much more complex than they need to be.
>    This will also be useful to better align a major behavioral change
>    in mailbox mode, which will use separate response buffers instead to
>    get data from the device instead of a pre-allocated shared memory
>    region.
>
> With the new reset functionality, shared resources between the device
> and driver are not freed until after the hardware reset has completed
> in the event that `deconfigure_device_resources` fails, meaning that the
> device could potentially still be holding on to shared memory.
>
> Reviewed-by: Willem de Bruijn <willemb@google.com>
> Reviewed-by: Jordan Rhee <jordanrhee@google.com>
> Signed-off-by: Joshua Washington <joshwash@google.com>
> Signed-off-by: Harshitha Ramamurthy <hramamurthy@google.com>
> ---
> Changes in v2:
> - Fixed typos in commit message (recursive, preempt)
> - Fixed a kdoc warning
>
>  drivers/net/ethernet/google/gve/gve.h         |   2 +-
>  drivers/net/ethernet/google/gve/gve_adminq.c  |   5 +-
>  drivers/net/ethernet/google/gve/gve_adminq.h  |   1 -
>  drivers/net/ethernet/google/gve/gve_ethtool.c |   2 +-
>  drivers/net/ethernet/google/gve/gve_main.c    | 338 +++++++++---------
>  5 files changed, 167 insertions(+), 181 deletions(-)
>
> diff --git a/drivers/net/ethernet/google/gve/gve.h b/drivers/net/ethernet=
/google/gve/gve.h
> index 72588d201e5d..c2e68fd97de5 100644
> --- a/drivers/net/ethernet/google/gve/gve.h
> +++ b/drivers/net/ethernet/google/gve/gve.h
> @@ -1347,7 +1347,7 @@ struct page_pool *gve_rx_create_page_pool(struct gv=
e_priv *priv,
>
>  /* Reset */
>  void gve_schedule_reset(struct gve_priv *priv);
> -int gve_reset(struct gve_priv *priv, bool attempt_teardown);
> +int gve_reset(struct gve_priv *priv, bool skip_queue_setup);
>  void gve_get_curr_alloc_cfgs(struct gve_priv *priv,
>                              struct gve_tx_alloc_rings_cfg *tx_alloc_cfg,
>                              struct gve_rx_alloc_rings_cfg *rx_alloc_cfg)=
;
> diff --git a/drivers/net/ethernet/google/gve/gve_adminq.c b/drivers/net/e=
thernet/google/gve/gve_adminq.c
> index e7956d2768b6..84b548467a0c 100644
> --- a/drivers/net/ethernet/google/gve/gve_adminq.c
> +++ b/drivers/net/ethernet/google/gve/gve_adminq.c
> @@ -363,7 +363,7 @@ int gve_adminq_init(struct gve_priv *priv)
>         return gve_adminq_alloc(priv);
>  }
>
> -void gve_adminq_release(struct gve_priv *priv)
> +static void gve_adminq_release(struct gve_priv *priv)
>  {
>         int i =3D 0;
>
> @@ -392,7 +392,6 @@ void gve_adminq_release(struct gve_priv *priv)
>         }
>         gve_clear_device_rings_ok(priv);
>         gve_clear_device_resources_ok(priv);
> -       gve_clear_admin_queue_ok(priv);
>  }
>
>  void gve_adminq_free(struct gve_priv *priv)
> @@ -1377,7 +1376,7 @@ gve_adminq_configure_flow_rule(struct gve_priv *pri=
v,
>
>         if (err =3D=3D -ETIME) {
>                 dev_err(&priv->pdev->dev, "Timeout to configure the flow =
rule, trigger reset");
> -               gve_reset(priv, true);
> +               gve_reset(priv, false);

Sashiko says:
The commit message states recursive resets and resets during teardown
are removed, but this site still calls gve_reset() from inside an adminq
command issued during teardown.
The reachable chain is:
  gve_remove() / gve_shutdown() / gve_suspend()
    -> gve_teardown_device()
       -> gve_teardown_control_plane_resources()
          -> gve_flow_rules_reset()
             -> gve_adminq_reset_flow_rules()
                -> gve_adminq_configure_flow_rule()
                   -> gve_reset(priv, false)   /* on -ETIME */

The spirit of this patch was to disallow resets during teardown _in
the reset path_, but the commit message was verbose enough as it was.
Resets due to errors as part of graceful teardown are not inherently
problematic, as the point is to teardown the device regardless. In a
case like this, only a single reset would be triggered.

However, Claude does allude to a good point in that the scope of
-ETIME failures to destroy flow rules could instead be limited to
ethtool operations. I will make this change in v3.

>         } else if (!err) {
>                 priv->flow_rules_cache.rules_cache_synced =3D false;
>         }
> diff --git a/drivers/net/ethernet/google/gve/gve_adminq.h b/drivers/net/e=
thernet/google/gve/gve_adminq.h
> index d07e9c6f279d..12d2d1347e21 100644
> --- a/drivers/net/ethernet/google/gve/gve_adminq.h
> +++ b/drivers/net/ethernet/google/gve/gve_adminq.h
> @@ -621,7 +621,6 @@ static_assert(sizeof(union gve_adminq_command) =3D=3D=
 64);
>
>  int gve_adminq_init(struct gve_priv *priv);
>  void gve_adminq_free(struct gve_priv *priv);
> -void gve_adminq_release(struct gve_priv *priv);
>  int gve_adminq_describe_device(struct gve_priv *priv);
>  int gve_adminq_configure_device_resources(struct gve_priv *priv,
>                                           dma_addr_t counter_array_bus_ad=
dr,
> diff --git a/drivers/net/ethernet/google/gve/gve_ethtool.c b/drivers/net/=
ethernet/google/gve/gve_ethtool.c
> index dc2213b5ce24..54b623b678ce 100644
> --- a/drivers/net/ethernet/google/gve/gve_ethtool.c
> +++ b/drivers/net/ethernet/google/gve/gve_ethtool.c
> @@ -651,7 +651,7 @@ static int gve_user_reset(struct net_device *netdev, =
u32 *flags)
>
>         if (*flags =3D=3D ETH_RESET_ALL) {
>                 *flags =3D 0;
> -               return gve_reset(priv, true);
> +               return gve_reset(priv, false);
>         }
>
>         return -EOPNOTSUPP;
> diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/eth=
ernet/google/gve/gve_main.c
> index 746ff69a28dd..f8289f478e5b 100644
> --- a/drivers/net/ethernet/google/gve/gve_main.c
> +++ b/drivers/net/ethernet/google/gve/gve_main.c
> @@ -591,7 +591,22 @@ static void gve_free_notify_blocks(struct gve_priv *=
priv)
>         priv->msix_vectors =3D NULL;
>  }
>
> -static int gve_setup_device_resources(struct gve_priv *priv)
> +static void gve_free_control_plane_resources(struct gve_priv *priv)
> +{
> +       bitmap_free(priv->xsk_pools);
> +       priv->xsk_pools =3D NULL;
> +
> +       kvfree(priv->ptype_lut_dqo);
> +       priv->ptype_lut_dqo =3D NULL;
> +
> +       gve_free_stats_report(priv);
> +       gve_free_notify_blocks(priv);
> +       gve_free_counter_array(priv);
> +       gve_free_rss_config_cache(priv);
> +       gve_free_flow_rule_caches(priv);
> +}
> +
> +static int gve_alloc_control_plane_resources(struct gve_priv *priv)
>  {
>         int err;
>
> @@ -600,16 +615,42 @@ static int gve_setup_device_resources(struct gve_pr=
iv *priv)
>                 return err;
>         err =3D gve_alloc_rss_config_cache(priv);
>         if (err)
> -               goto abort_with_flow_rule_caches;
> +               goto abort;
>         err =3D gve_alloc_counter_array(priv);
>         if (err)
> -               goto abort_with_rss_config_cache;
> +               goto abort;
>         err =3D gve_alloc_notify_blocks(priv);
>         if (err)
> -               goto abort_with_counter;
> +               goto abort;
>         err =3D gve_alloc_stats_report(priv);
>         if (err)
> -               goto abort_with_ntfy_blocks;
> +               goto abort;
> +
> +       if (!gve_is_gqi(priv)) {
> +               priv->ptype_lut_dqo =3D kvzalloc_obj(*priv->ptype_lut_dqo=
,
> +                                                  GFP_KERNEL);
> +               if (!priv->ptype_lut_dqo) {
> +                       err =3D -ENOMEM;
> +                       goto abort;
> +               }
> +       }
> +
> +       priv->xsk_pools =3D bitmap_zalloc(priv->rx_cfg.max_queues, GFP_KE=
RNEL);
> +       if (!priv->xsk_pools) {
> +               err =3D -ENOMEM;
> +               goto abort;
> +       }
> +
> +       return 0;
> +abort:
> +       gve_free_control_plane_resources(priv);
> +       return err;
> +}
> +
> +static int gve_setup_control_plane_resources(struct gve_priv *priv)
> +{
> +       int err =3D 0;
> +
>         err =3D gve_adminq_configure_device_resources(priv,
>                                                     priv->counter_array_b=
us,
>                                                     priv->num_event_count=
ers,
> @@ -619,20 +660,15 @@ static int gve_setup_device_resources(struct gve_pr=
iv *priv)
>                 dev_err(&priv->pdev->dev,
>                         "could not setup device_resources: err=3D%d\n", e=
rr);
>                 err =3D -ENXIO;
> -               goto abort_with_stats_report;
> +               return err;
>         }
>
>         if (!gve_is_gqi(priv)) {
> -               priv->ptype_lut_dqo =3D kvzalloc_obj(*priv->ptype_lut_dqo=
);
> -               if (!priv->ptype_lut_dqo) {
> -                       err =3D -ENOMEM;
> -                       goto abort_with_stats_report;
> -               }
>                 err =3D gve_adminq_get_ptype_map_dqo(priv, priv->ptype_lu=
t_dqo);
>                 if (err) {
>                         dev_err(&priv->pdev->dev,
>                                 "Failed to get ptype map: err=3D%d\n", er=
r);
> -                       goto abort_with_ptype_lut;
> +                       goto deconfigure_device;
>                 }
>         }
>
> @@ -647,7 +683,7 @@ static int gve_setup_device_resources(struct gve_priv=
 *priv)
>         err =3D gve_init_rss_config(priv, priv->rx_cfg.num_queues);
>         if (err) {
>                 dev_err(&priv->pdev->dev, "Failed to init RSS config");
> -               goto abort_with_clock;
> +               goto teardown_clock;
>         }
>
>         err =3D gve_adminq_report_stats(priv, priv->stats_report_len,
> @@ -659,67 +695,61 @@ static int gve_setup_device_resources(struct gve_pr=
iv *priv)
>         gve_set_device_resources_ok(priv);
>         return 0;
>
> -abort_with_clock:
> +teardown_clock:
>         gve_teardown_clock(priv);
> -abort_with_ptype_lut:
> -       kvfree(priv->ptype_lut_dqo);
> -       priv->ptype_lut_dqo =3D NULL;
> -abort_with_stats_report:
> -       gve_free_stats_report(priv);
> -abort_with_ntfy_blocks:
> -       gve_free_notify_blocks(priv);
> -abort_with_counter:
> -       gve_free_counter_array(priv);
> -abort_with_rss_config_cache:
> -       gve_free_rss_config_cache(priv);
> -abort_with_flow_rule_caches:
> -       gve_free_flow_rule_caches(priv);
> -
> +deconfigure_device:
> +       gve_adminq_deconfigure_device_resources(priv);
>         return err;
>  }
>
> -static void gve_trigger_reset(struct gve_priv *priv);
> -
> -static void gve_teardown_device_resources(struct gve_priv *priv)
> +/*
> + * Request the device to release any allocated shared resources.
> + *
> + * If any part of the teardown step fails, the failure is documented, bu=
t is
> + * otherwise ignored. It is expected that a device reset is triggered
> + * immediately after tearing down device resources, which would clear an=
y
> + * lingering state on the device.
> + */
> +static void gve_teardown_control_plane_resources(struct gve_priv *priv)
>  {
>         int err;
>
>         /* Tell device its resources are being freed */
>         if (gve_get_device_resources_ok(priv)) {
>                 err =3D gve_flow_rules_reset(priv);
> -               if (err) {
> +               if (err)
>                         dev_err(&priv->pdev->dev,
>                                 "Failed to reset flow rules: err=3D%d\n",=
 err);
> -                       gve_trigger_reset(priv);
> -               }
>                 /* detach the stats report */
>                 err =3D gve_adminq_report_stats(priv, 0, 0x0, GVE_STATS_R=
EPORT_TIMER_PERIOD);
> -               if (err) {
> +               if (err)
>                         dev_err(&priv->pdev->dev,
>                                 "Failed to detach stats report: err=3D%d\=
n", err);
> -                       gve_trigger_reset(priv);
> -               }
> +               gve_teardown_clock(priv);
>                 err =3D gve_adminq_deconfigure_device_resources(priv);
> -               if (err) {
> +               if (err)
>                         dev_err(&priv->pdev->dev,
>                                 "Could not deconfigure device resources: =
err=3D%d\n",
>                                 err);
> -                       gve_trigger_reset(priv);
> -               }
>         }
>
> -       kvfree(priv->ptype_lut_dqo);
> -       priv->ptype_lut_dqo =3D NULL;
> -
> -       gve_free_flow_rule_caches(priv);
> -       gve_free_rss_config_cache(priv);
> -       gve_free_counter_array(priv);
> -       gve_free_notify_blocks(priv);
> -       gve_free_stats_report(priv);
> -       gve_teardown_clock(priv);
>         gve_clear_device_resources_ok(priv);
>  }
>
> +static void gve_teardown_device(struct gve_priv *priv)
> +{
> +       gve_teardown_control_plane_resources(priv);
> +       gve_adminq_free(priv);
> +       /*
> +        * Free any resources shared with the device only after we have a
> +        * guarantee that the device will not try to access such resource=
s.
> +        * Device commands in gve_teardown_control_plane_resources can fa=
il, in
> +        * which case, device resources won't be relinquished until
> +        * gve_adminq_free is called to trigger a device reset.
> +        */
> +       gve_free_control_plane_resources(priv);
> +}
> +
>  static int gve_unregister_qpl(struct gve_priv *priv,
>                               struct gve_queue_page_list *qpl)
>  {
> @@ -1160,8 +1190,6 @@ void gve_schedule_reset(struct gve_priv *priv)
>         queue_work(priv->gve_wq, &priv->service_task);
>  }
>
> -static void gve_reset_and_teardown(struct gve_priv *priv, bool was_up);
> -static int gve_reset_recovery(struct gve_priv *priv, bool was_up);
>  static void gve_turndown(struct gve_priv *priv);
>  static void gve_turnup(struct gve_priv *priv);
>
> @@ -1272,11 +1300,12 @@ static int gve_reg_xdp_info(struct gve_priv *priv=
, struct net_device *dev)
>         return err;
>  }
>
> -
>  static void gve_drain_page_cache(struct gve_priv *priv)
>  {
>         int i;
>
> +       if (!priv->rx)
> +               return;
>         for (i =3D 0; i < priv->rx_cfg.num_queues; i++)
>                 page_frag_cache_drain(&priv->rx[i].page_cache);
>  }
> @@ -1419,10 +1448,11 @@ static int gve_queues_start(struct gve_priv *priv=
,
>  reset:
>         if (gve_get_reset_in_progress(priv))
>                 goto stop_and_free_rings;
> -       gve_reset_and_teardown(priv, true);
> -       /* if this fails there is nothing we can do so just ignore the re=
turn */
> -       gve_reset_recovery(priv, false);
> -       /* return the original error */
> +
> +       /* Attempt to reset. If reset is successful, gve_queues_start was
> +        * successful.
> +        */
> +       err =3D gve_reset(priv, false);
>         return err;
>  stop_and_free_rings:
>         gve_tx_stop_rings(priv, gve_num_tx_queues(priv));

Sashiko says:
This is a pre-existing issue, but in the stop_and_free_rings error path
inside gve_queues_start(), the rx arrays are freed via
gve_queues_mem_remove(priv) without unregistering the XDP rxq structures.
Could this leak xdp_rxq info and leave dangling pointers in the network
stack?

I will submit a fix separately for this behavior, since it is a
pre-existing issue.

> @@ -1438,6 +1468,12 @@ static int gve_open(struct net_device *dev)
>         struct gve_priv *priv =3D netdev_priv(dev);
>         int err;
>
> +       if (!gve_get_device_resources_ok(priv)) {
> +               dev_err(&priv->pdev->dev,
> +                       "Attempting to open netdev without resources. Dev=
ice must be reset.");
> +               return -ENODEV;
> +       }
> +
>         gve_get_curr_alloc_cfgs(priv, &tx_alloc_cfg, &rx_alloc_cfg);
>
>         err =3D gve_queues_mem_alloc(priv, &tx_alloc_cfg, &rx_alloc_cfg);
> @@ -1454,41 +1490,18 @@ static int gve_open(struct net_device *dev)
>         return 0;
>  }
>
> -static int gve_queues_stop(struct gve_priv *priv)
> +static void gve_queues_stop(struct gve_priv *priv)
>  {
> -       int err;
> -
> -       netif_carrier_off(priv->dev);
> -       if (gve_get_device_rings_ok(priv)) {
> -               gve_turndown(priv);
> -               gve_drain_page_cache(priv);
> -               err =3D gve_destroy_rings(priv);
> -               if (err)
> -                       goto err;
> -               err =3D gve_unregister_qpls(priv);
> -               if (err)
> -                       goto err;
> -               gve_clear_device_rings_ok(priv);
> -       }
> -       timer_delete_sync(&priv->stats_report_timer);
> +       gve_turndown(priv);
>
>         gve_unreg_xdp_info(priv);
> +       gve_drain_page_cache(priv);
> +
> +       timer_delete_sync(&priv->stats_report_timer);
> +       cancel_work_sync(&priv->stats_report_task);
>
>         gve_tx_stop_rings(priv, gve_num_tx_queues(priv));
>         gve_rx_stop_rings(priv, priv->rx_cfg.num_queues);
> -
> -       priv->interface_down_cnt++;
> -       return 0;
> -
> -err:
> -       /* This must have been called from a reset due to the rtnl lock
> -        * so just return at this point.
> -        */
> -       if (gve_get_reset_in_progress(priv))
> -               return err;
> -       /* Otherwise reset before returning */
> -       gve_reset_and_teardown(priv, true);
> -       return gve_reset_recovery(priv, false);
>  }
>
>  static int gve_close(struct net_device *dev)
> @@ -1496,12 +1509,28 @@ static int gve_close(struct net_device *dev)
>         struct gve_priv *priv =3D netdev_priv(dev);
>         int err;
>
> -       err =3D gve_queues_stop(priv);
> -       if (err)
> -               return err;
> +       gve_queues_stop(priv);
> +
> +       /* Surrender to reset if the queue destroying adminq cmds fail. R=
eset
> +        * will not re-enable the interface.
> +        */
> +       if (gve_get_device_rings_ok(priv)) {
> +               gve_clear_device_rings_ok(priv);
> +               err =3D gve_destroy_rings(priv);
> +               if (err)
> +                       goto reset;
> +               err =3D gve_unregister_qpls(priv);
> +               if (err)
> +                       goto reset;
> +       }
>
>         gve_queues_mem_remove(priv);
> +       priv->interface_down_cnt++;
>         return 0;
> +
> +reset:
> +       err =3D gve_reset(priv, true);
> +       return err;
>  }
>
>  static void gve_handle_link_status(struct gve_priv *priv, bool link_stat=
us)
> @@ -2420,25 +2449,17 @@ static int gve_setup_device(struct gve_priv *priv=
)
>  {
>         int err;
>
> -       priv->xsk_pools =3D bitmap_zalloc(priv->rx_cfg.max_queues, GFP_KE=
RNEL);
> -       if (!priv->xsk_pools) {
> -               err =3D -ENOMEM;
> -               goto err;
> -       }
> -
>         gve_set_netdev_xdp_features(priv);
>         if (!gve_is_gqi(priv))
>                 priv->dev->xdp_metadata_ops =3D &gve_xdp_metadata_ops;
>
> -       err =3D gve_setup_device_resources(priv);
> +       err =3D gve_alloc_control_plane_resources(priv);
>         if (err)
> -               goto err_free_xsk_bitmap;
> -
> +               goto err;
> +       err =3D gve_setup_control_plane_resources(priv);
> +       if (err)
> +               goto err;
>         return 0;
> -
> -err_free_xsk_bitmap:
> -       bitmap_free(priv->xsk_pools);
> -       priv->xsk_pools =3D NULL;
>  err:
>         return err;
>  }
> @@ -2513,30 +2534,7 @@ static int gve_init_priv(struct gve_priv *priv)
>         return 0;
>  }
>
> -static void gve_teardown_priv_resources(struct gve_priv *priv)
> -{
> -       gve_teardown_device_resources(priv);
> -       gve_adminq_free(priv);
> -       bitmap_free(priv->xsk_pools);
> -       priv->xsk_pools =3D NULL;
> -}
> -
> -static void gve_trigger_reset(struct gve_priv *priv)
> -{
> -       /* Reset the device by releasing the AQ */
> -       gve_adminq_release(priv);
> -}
> -
> -static void gve_reset_and_teardown(struct gve_priv *priv, bool was_up)
> -{
> -       gve_trigger_reset(priv);
> -       /* With the reset having already happened, close cannot fail */
> -       if (was_up)
> -               gve_close(priv->dev);
> -       gve_teardown_priv_resources(priv);
> -}
> -
> -static int gve_reset_recovery(struct gve_priv *priv, bool was_up)
> +static int gve_recover(struct gve_priv *priv, bool setup_queues)
>  {
>         int err;
>
> @@ -2549,54 +2547,52 @@ static int gve_reset_recovery(struct gve_priv *pr=
iv, bool was_up)
>
>         err =3D gve_setup_device(priv);
>         if (err)
> -               goto err_free_adminq;
> -       if (was_up) {
> +               goto err;
> +       if (setup_queues) {
>                 err =3D gve_open(priv->dev);
>                 if (err)
> -                       goto err_free_device;
> +                       goto err;
>         }
>         return 0;
>
> -err_free_device:
> -       gve_teardown_device_resources(priv);
> -       bitmap_free(priv->xsk_pools);
> -       priv->xsk_pools =3D NULL;
> -err_free_adminq:
> -       gve_adminq_free(priv);
>  err:
> -       dev_err(&priv->pdev->dev, "Reset failed! !!! DISABLING ALL QUEUES=
 !!!\n");
> -       gve_turndown(priv);
> +       dev_err(&priv->pdev->dev, "Recover failed! !!! DISABLING ALL QUEU=
ES !!!\n");
> +       gve_teardown_device(priv);
>         return err;
>  }
>
> -int gve_reset(struct gve_priv *priv, bool attempt_teardown)
> +int gve_reset(struct gve_priv *priv, bool skip_queue_setup)
>  {
>         bool was_up =3D netif_running(priv->dev);
>         int err;
>
> +       if (gve_get_reset_in_progress(priv))
> +               return 0;
> +
>         dev_info(&priv->pdev->dev, "Performing reset\n");
>         gve_clear_do_reset(priv);
>         gve_set_reset_in_progress(priv);
> -       /* If we aren't attempting to teardown normally, just go turndown=
 and
> -        * reset right away.
> -        */
> -       if (!attempt_teardown) {
> -               gve_turndown(priv);
> -               gve_reset_and_teardown(priv, was_up);
> -       } else {
> -               /* Otherwise attempt to close normally */
> -               if (was_up) {
> -                       err =3D gve_close(priv->dev);
> -                       /* If that fails reset as we did above */
> -                       if (err)
> -                               gve_reset_and_teardown(priv, was_up);
> -               }
> -               /* Clean up any remaining resources */
> -               gve_teardown_priv_resources(priv);
> +
> +       if (was_up) {
> +               gve_queues_stop(priv);
> +               gve_destroy_rings(priv);
> +               gve_unregister_qpls(priv);
>         }

Sashiko says:
If a background task executes gve_reset() after gve_suspend() or
gve_shutdown() has already freed priv->adminq, wouldn't this unconditional
call to gve_destroy_rings(priv) write to the freed admin queue ring buffer?
The previous code appeared to verify that device rings were still okay
before attempting to tear them down.

This is a legitimate concern. Will add a check on device_rings_ok() in v3.

>
> -       /* Set it all back up */
> -       err =3D gve_reset_recovery(priv, was_up);
> +       /* Reset the device by releasing the AQ. Rings and other resource=
s
> +        * within the NIC are implicitly destroyed if commands fail.
> +        */
> +       gve_adminq_free(priv);
> +
> +       gve_queues_mem_remove(priv);
> +       gve_teardown_clock(priv);
> +       gve_free_control_plane_resources(priv);
> +
> +       err =3D gve_recover(priv, was_up && !skip_queue_setup);
> +       if (err)
> +               dev_info(&priv->pdev->dev,
> +                        "Failed to recover in reset: %d\n", err);
> +
>         gve_clear_reset_in_progress(priv);
>         priv->reset_cnt++;
>         priv->interface_up_cnt =3D 0;
> @@ -2928,7 +2924,7 @@ static int gve_probe(struct pci_dev *pdev, const st=
ruct pci_device_id *ent)
>         if (err) {
>                 dev_err(&priv->pdev->dev,
>                         "Could not setup device: err=3D%d\n", err);
> -               goto abort_with_wq;
> +               goto abort_teardown_device;
>         }
>
>         if (!gve_is_gqi(priv) && !gve_is_qpl(priv))
> @@ -2936,7 +2932,7 @@ static int gve_probe(struct pci_dev *pdev, const st=
ruct pci_device_id *ent)
>
>         err =3D register_netdev(dev);
>         if (err)
> -               goto abort_with_gve_init;
> +               goto abort_teardown_device;
>
>         dev_info(&pdev->dev, "GVE version %s\n", gve_version_str);
>         dev_info(&pdev->dev, "GVE queue format %d\n", (int)priv->queue_fo=
rmat);
> @@ -2944,8 +2940,8 @@ static int gve_probe(struct pci_dev *pdev, const st=
ruct pci_device_id *ent)
>         queue_work(priv->gve_wq, &priv->service_task);
>         return 0;
>
> -abort_with_gve_init:
> -       gve_teardown_priv_resources(priv);
> +abort_teardown_device:
> +       gve_teardown_device(priv);
>
>  abort_with_wq:
>         destroy_workqueue(priv->gve_wq);
> @@ -2977,8 +2973,8 @@ static void gve_remove(struct pci_dev *pdev)
>         void __iomem *reg_bar =3D priv->reg_bar0;
>
>         unregister_netdev(netdev);
> -       gve_teardown_priv_resources(priv);
>         destroy_workqueue(priv->gve_wq);
> +       gve_teardown_device(priv);

Sashiko says:
Since gve_teardown_device() is responsible for freeing the notify blocks an=
d
interrupts, does tearing down the workqueue first expose us to a
use-after-free if gve_mgmnt_intr() fires and calls
queue_work(priv->gve_wq, &priv->service_task)?

If I understand correctly, instead of destroying the work queue first,
the following order is better:
1) All work items on the queue should be disabled. disable_work()
ensures that no subsequent work items using a given work struct can be
scheduled.
2) gve_teardown_device(), disabling anything that would attempt to schedule=
 work
3) destroy_workqueue()

If there are no objections to this, I will implement in v3.

>         priv->ctrl_ops->unmap_db_bar(priv);
>         free_netdev(netdev);
>         pci_iounmap(pdev, reg_bar);
> @@ -2996,13 +2992,9 @@ static void gve_shutdown(struct pci_dev *pdev)
>
>         rtnl_lock();
>         netdev_lock(netdev);
> -       if (was_up && gve_close(priv->dev)) {
> -               /* If the dev was up, attempt to close, if close fails, r=
eset */
> -               gve_reset_and_teardown(priv, was_up);
> -       } else {
> -               /* If the dev wasn't up or close worked, finish tearing d=
own */
> -               gve_teardown_priv_resources(priv);
> -       }
> +       if (was_up)
> +               gve_close(priv->dev);
> +       gve_teardown_device(priv);
>         netdev_unlock(netdev);
>         rtnl_unlock();
>  }
> @@ -3017,13 +3009,9 @@ static int gve_suspend(struct device *dev)
>         priv->suspend_cnt++;
>         rtnl_lock();
>         netdev_lock(netdev);
> -       if (was_up && gve_close(priv->dev)) {
> -               /* If the dev was up, attempt to close, if close fails, r=
eset */
> -               gve_reset_and_teardown(priv, was_up);
> -       } else {
> -               /* If the dev wasn't up or close worked, finish tearing d=
own */
> -               gve_teardown_priv_resources(priv);
> -       }
> +       if (was_up)
> +               gve_close(priv->dev);
> +       gve_teardown_device(priv);

Sashiko says:
With the new structure, when gve_close() hits its reset: label during
shutdown or suspend it calls gve_reset(priv, true), which runs
gve_recover() and re-initializes adminq plus the full control plane via
gve_setup_device(). gve_shutdown()/gve_suspend() then immediately call
gve_teardown_device(), which performs a second adminq_free and a second
hardware reset.
The previous gve_reset_and_teardown() path on this same condition did
not invoke gve_reset_recovery(). On a wedged device during PCI shutdown
or suspend, every adminq command can take its full timeout, and the new
flow runs through these commands twice.
Is this re-setup-then-teardown sequence on the shutdown/suspend close
failure path intended? Would it be preferable to skip recovery when the
caller is about to immediately tear the device down?

While skipping recovery would be nice, I would prefer to do it in a
way that does not greatly increase the complexity of the reset
functionality.

I am considering following up on this work, adding
netif_device_attach/detach semantics, which the reset patch can
leverage to understand whether it should attempt to recreate queues as
part of recovery from a reset without adding unnecessary driver state
or branching logic.

>         priv->up_before_suspend =3D was_up;
>         netdev_unlock(netdev);
>         rtnl_unlock();
> @@ -3040,7 +3028,7 @@ static int gve_resume(struct device *dev)
>         priv->resume_cnt++;
>         rtnl_lock();
>         netdev_lock(netdev);
> -       err =3D gve_reset_recovery(priv, priv->up_before_suspend);
> +       err =3D gve_recover(priv, priv->up_before_suspend);
>         netdev_unlock(netdev);
>         rtnl_unlock();
>         return err;
> --
> 2.54.0.1013.g208068f2d8-goog
>


--=20

Joshua Washington | Software Engineer | joshwash@google.com | (414) 366-442=
3
