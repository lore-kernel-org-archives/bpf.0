Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 145ED3F54B6
	for <bpf@vger.kernel.org>; Fri,  5 Jun 2026 03:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780631114; cv=pass; b=FwWDTetEgtyNBQM4TkNZFrM7E1RWsfYEcX0vnxmSgdMtHQE2m0hA0EvQFvwQ2yLPwB3vkw4Z2YY7Hy8GhVuRrICAgMecZl9y7gHJtRcxFG7ffDCPkM3kdbbv1C4+fqhZInSbkssLX1Pp20PQIakn7cx4IHmXzVYKd01NmfjQvlw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780631114; c=relaxed/simple;
	bh=mGqFACtGrSVINwFpO8ywF5lUfVtL0d5zetuzyjG/2Gw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ofAtHnW+jNaNEtz59hXczhYoU6ToejBWlW86d7jV8Mtn6ddZwZC2/+BmxmSGOPn8LgofemB/9c5XGXZ0mRamsThd7we9ZgsGCdiiS5IuREtLopSi0KQN36nDz+mu0m1E3OVxPAfpLIboIKlb+LWOlefdPApHGSynwUQru7oN0uA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qa8bfypT; arc=pass smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qa8bfypT"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2bf2911f93cso41135ad.1
        for <bpf@vger.kernel.org>; Thu, 04 Jun 2026 20:45:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780631111; cv=none;
        d=google.com; s=arc-20240605;
        b=e7mHL5N21o8A6u4TdcSfu4iMpJnSD5oIrEfpM8CUDorEiT2PxGpLTRx8sLlmz4KIll
         Yf96w3KgrBbkLJ0eEFrn8jHLCJyrCo+Tu5VnT6Jsve5r+S8JJOg4uUHhPh5FHByJvI2i
         SHb4QjT3dCs0QeijqDH0cw2Prw5B/TcnqzCGMUZO7eK9Zfni2iEBUdY75y+29kevIrcn
         BHsojOwgQDKw+XVeRnPjA7+1hc1x02DExIezAfqdCeApuRszlLUYpcGhsbbWSiM72IDE
         xPx/h8nmnRdI8tM/UBobtB+eA2Z6dFnsFNJvBt4heVAd4iz1HBGXcSXau1WHMauqGIhz
         /60Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=eEbenGZPReLJ9DhbGUrqCibVr6fOdJSY9PicD1Cn1dc=;
        fh=3MWJPvGRW+kAgdY0pbc4jV7EFijTiFIs5t4gGnKFtd4=;
        b=HZY+b0a1Pl/RUGEVxA2/ovaCGB/mFctIRGYcfAo6FfG4ksSB3h+F9EJvR1awUxF58B
         09QmwNQz2x3rNhsIA2aSUtG+bsvmG40fsvNrQE6eTJ5Q4DN/NDzN0YGp7ad0SQpb2swd
         1I23AdCG8RknYsZNrnkotORxAma4/3yzl2/i8vRKbIX4B+1p+fmgPzHDSmLSLSiTtWBf
         kndeD3ALIStCyY2LHg29jlHjtXjBHCWzNirP1/KNXYcJaPjAwAbMPLLW/dWFli49ktk5
         3aN1GR0Yrdu90DJZcJ2wef78LDa/uK9O0+rf3U9HI0gHKG5INcHah9ivwwm3Ys6z0GcI
         C5LQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780631111; x=1781235911; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eEbenGZPReLJ9DhbGUrqCibVr6fOdJSY9PicD1Cn1dc=;
        b=qa8bfypTvgSr+vdwXK3WVY45UJgBgHzVXDtE88+cvsy+9tAXIe3nH/gxXANt1CkKKJ
         NXOInGEj+2xMPhmG1eroeulOdi1SACHelfjUop5Wci9q/Q+P6AgO9wRbZuPG9HdZ090i
         Q0TYwKbGmfbwkk4bxjMegt7uUeuy45UO3ULC7xYfuESX+it/de8AyIacJdSAnMzFfKuE
         d8g2W0BiVWmq7K2FCRBPqA0vyha4Mw76tZuvbIBW6uMBGxMoLup4mC9FKNMELZ4m0NoD
         Z4BV63+Nu8A3RyyphbU4bs8nBLfeOCvqcBx4mLBvzJbs34aOl9IL7ExXxHRqXdbMgl/M
         /TmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780631111; x=1781235911;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eEbenGZPReLJ9DhbGUrqCibVr6fOdJSY9PicD1Cn1dc=;
        b=Jqk/t2BlAovgrLoi+eniWhDsIjG4COpeaYsPI5YIDGBshJ1t2uze1dF3SB/0w/AuN0
         6lrc8PnYJt7SrLI60wFc54iBPFWhC09oVZDUIcj9eyj1pbrbmtLq0PFwRC2cOuoeIOBw
         f1f81erKBvSk8vkf5WZDN6RJ3vTBh1SpE4EwHCVXs+a/dqA+u+zlfS2t7pVgkjIVnDQT
         0L4Jx0PK985WYNzVq5KWx0htgtUudr/HLkFaSENt3xfhlc8XOR3OYsWMz9+aPYyD8Dvz
         A9G6p26alcXSdE7MW/jepMCBTfiX5NLcwBLRSfLZILjloa0E2WNjYsBKTcAof208tnF8
         MtGg==
X-Forwarded-Encrypted: i=1; AFNElJ8Z3Nszj2x8pcPS8ZpHW+IEQpxxw/0IeMUUOFEJAyXHihymFmPdr4hImjXZLvsSeKjPXdo=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywoe7eFFMz/U8iMaPtWDRi6gc8yR99jZkAqChEKqyZM0vOgdEVx
	lBhRt8wcuTji0urRuYFvVx87RXqaOGf/npIuuSXULx9Ic5vIabHjw+DL8eeS421oB04pCAqOTe5
	G7EL/vKOFRZVU7fMPC5Yotvw6I920xA54YIySkdJb
X-Gm-Gg: Acq92OGJ+y6qWxzXF7GTtckstDgyT48Iym528VrGcpDBs0Ft6T/7eLhDaha/UhZhxGA
	zMZqXn0Vuyv48T3jS02FWpm5wz7XgdWxRg7O2jpcSYw3HqkfzBHS3F8T6JykKROJrRKGWfcRhHU
	GhUUbW3FXRjKEFIZwWAHT1jD//KgBJ1hoV6EEsWwQl40dRuNEnvCmDhvuFfIGdhcOosXMZPFiSS
	LkQM1f4fVF13DP24rzuZfy3PJd1HpKcsYosIDU//B5KiD6IEa40qVjR704rF6cCv4yoblj/l1Vh
	oWpYT8WLaz1VcSvagkMDIlKFpHRpCveMxYXvb2XH9nOZ2osMKVu7Z0+ybF9DgYc199LsoVZTWhA
	J7bqnAceD2JTzolZxk6E=
X-Received: by 2002:a17:902:c948:b0:2bd:508b:f3ab with SMTP id
 d9443c01a7336-2c1eb5075ddmr661945ad.15.1780631110621; Thu, 04 Jun 2026
 20:45:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260602235900.3050782-1-hramamurthy@google.com> <20260602235900.3050782-6-hramamurthy@google.com>
In-Reply-To: <20260602235900.3050782-6-hramamurthy@google.com>
From: Harshitha Ramamurthy <hramamurthy@google.com>
Date: Thu, 4 Jun 2026 20:44:58 -0700
X-Gm-Features: AVHnY4J8S28WHbP5CLUzYI5Qe8QMIovQG4XNwGosNLc-2fJQzqpl6dUv5fQ5A_Y
Message-ID: <CAEAWyHcH8zfquuRh-U0_2U8CEUz_kpNFLqyA-N1mN=u4VLNFRg@mail.gmail.com>
Subject: Re: [PATCH net-next v2 05/15] gve: add struct gve_device_info to hold
 device properties
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
> In the current AdminQ mode, device properties are written into
> struct gve_device_descriptor that is allocated in shared memory
> between the driver and device. In the upcoming MailboxQ mode,
> these properties will be returned in the response of a mailbox
> message. Hence, add struct gve_device_info as the structure that
> holds all the properties that are negotiated with the device in
> either mode.
>
> Change the AdminQ mode method gve_adminq_describe_device()
> and the functions it calls to fill up device information
> into this newly introduced struct gve_device_info. Move a
> few helper functions and code that set device properties
> in the priv structure into gve_init_priv(). So now
> gve_init_priv() calls/does the following:
>
> - gve_set_mtu()
> - gve_set_mac()
> - gve_set_queue_properties()
> - gve_set_buf_sizes()
> - set flow steering and RSS properties
> - set other priv properties
>
> When MailboxQ support is added, device information will be filled
> into the same structure and the same gve_init_priv() path would be
> used to set device properties to ensure common code reusage.
>
> These changes are refactors only, no functional change.
>
> Reviewed-by: Willem de Bruijn <willemb@google.com>
> Reviewed-by: Jordan Rhee <jordanrhee@google.com>
> Signed-off-by: Harshitha Ramamurthy <hramamurthy@google.com>
> ---
>  drivers/net/ethernet/google/gve/gve.h        |  29 +++++
>  drivers/net/ethernet/google/gve/gve_adminq.c | 113 +++++++++++--------
>  drivers/net/ethernet/google/gve/gve_adminq.h |   6 -
>  drivers/net/ethernet/google/gve/gve_main.c   | 101 ++++++++++++-----
>  4 files changed, 169 insertions(+), 80 deletions(-)
>
> diff --git a/drivers/net/ethernet/google/gve/gve.h b/drivers/net/ethernet=
/google/gve/gve.h
> index 645175a5dfae..086a315f42c1 100644
> --- a/drivers/net/ethernet/google/gve/gve.h
> +++ b/drivers/net/ethernet/google/gve/gve.h
> @@ -796,6 +796,34 @@ struct gve_ptp {
>         struct gve_priv *priv;
>  };
>
> +struct gve_device_info {
> +       enum gve_queue_format queue_format;
> +       u16 default_tx_queues;
> +       u16 default_rx_queues;
> +       u16 max_tx_queues;
> +       u16 max_rx_queues;
> +       u16 default_tx_ring_size;
> +       u16 default_rx_ring_size;
> +       u16 max_tx_ring_size;
> +       u16 max_rx_ring_size;
> +       u16 min_tx_ring_size;
> +       u16 min_rx_ring_size;
> +       u16 max_mtu;
> +       u8 mac[ETH_ALEN];
> +       u16 max_rx_buffer_size;
> +       u16 header_buf_size;
> +       u32 max_flow_rules;
> +       u16 rss_key_size;
> +       u16 rss_lut_size;
> +       u16 tx_pages_per_qpl;
> +       u16 num_event_counters;
> +       u64 max_registered_pages;
> +       bool default_min_ring_size;
> +       bool nic_timestamp_supported;
> +       bool modify_ring_size_enabled;
> +       bool cache_rss_config;
> +};
> +
>  struct gve_priv {
>         struct net_device *dev;
>         struct gve_tx_ring *tx; /* array of tx_cfg.num_queues */
> @@ -928,6 +956,7 @@ struct gve_priv {
>         struct gve_nic_ts_report *nic_ts_report;
>         dma_addr_t nic_ts_report_bus;
>         u64 last_sync_nic_counter; /* Clock counter from last NIC TS repo=
rt */
> +       struct gve_device_info device_info;
>  };
>
>  enum gve_service_task_flags_bit {
> diff --git a/drivers/net/ethernet/google/gve/gve_adminq.c b/drivers/net/e=
thernet/google/gve/gve_adminq.c
> index 77203184efbd..06db2ccd0b89 100644
> --- a/drivers/net/ethernet/google/gve/gve_adminq.c
> +++ b/drivers/net/ethernet/google/gve/gve_adminq.c
> @@ -70,7 +70,7 @@ void gve_parse_device_option(struct gve_priv *priv,
>
>                 dev_info(&priv->pdev->dev,
>                          "Gqi raw addressing device option enabled.\n");
> -               priv->queue_format =3D GVE_GQI_RDA_FORMAT;
> +               priv->device_info.queue_format =3D GVE_GQI_RDA_FORMAT;
>                 break;
>         case GVE_DEV_OPT_ID_GQI_RDA:
>                 if (option_length < sizeof(**dev_op_gqi_rda) ||
> @@ -190,7 +190,7 @@ void gve_parse_device_option(struct gve_priv *priv,
>
>                 /* device has not provided min ring size */
>                 if (option_length =3D=3D GVE_DEVICE_OPTION_NO_MIN_RING_SI=
ZE)
> -                       priv->default_min_ring_size =3D true;
> +                       priv->device_info.default_min_ring_size =3D true;
>                 break;
>         case GVE_DEV_OPT_ID_FLOW_STEERING:
>                 if (option_length < sizeof(**dev_op_flow_steering) ||
> @@ -922,10 +922,13 @@ int gve_adminq_destroy_rx_queues(struct gve_priv *p=
riv, u32 num_queues)
>
>  static void gve_set_default_rss_sizes(struct gve_priv *priv)
>  {
> -       if (!gve_is_gqi(priv)) {
> -               priv->rss_key_size =3D GVE_RSS_KEY_SIZE;
> -               priv->rss_lut_size =3D GVE_RSS_INDIR_SIZE;
> -               priv->cache_rss_config =3D true;
> +       struct gve_device_info *device_info =3D &priv->device_info;
> +
> +       if (device_info->queue_format =3D=3D GVE_DQO_RDA_FORMAT ||
> +           device_info->queue_format =3D=3D GVE_DQO_QPL_FORMAT) {
> +               device_info->rss_key_size =3D GVE_RSS_KEY_SIZE;
> +               device_info->rss_lut_size =3D GVE_RSS_INDIR_SIZE;
> +               device_info->cache_rss_config =3D true;
>         }
>  }
>
> @@ -946,77 +949,105 @@ static void gve_enable_supported_features(struct g=
ve_priv *priv,
>                                           const struct gve_device_option_=
modify_ring
>                                           *dev_op_modify_ring)
>  {
> +       struct gve_device_info *info =3D &priv->device_info;
> +
>         /* Before control reaches this point, the page-size-capped max MT=
U from
>          * the gve_device_descriptor field has already been stored in
> -        * priv->dev->max_mtu. We overwrite it with the true max MTU belo=
w.
> +        * device_info->max_mtu. We overwrite it with the true max MTU be=
low.
>          */
>         if (dev_op_jumbo_frames &&
>             (supported_features_mask & GVE_SUP_JUMBO_FRAMES_MASK)) {
>                 dev_info(&priv->pdev->dev,
>                          "JUMBO FRAMES device option enabled.\n");
> -               priv->dev->max_mtu =3D be16_to_cpu(dev_op_jumbo_frames->m=
ax_mtu);
> +               info->max_mtu =3D be16_to_cpu(dev_op_jumbo_frames->max_mt=
u);
>         }
>
>         if (dev_op_buffer_sizes &&
>             (supported_features_mask & GVE_SUP_BUFFER_SIZES_MASK)) {
> -               priv->max_rx_buffer_size =3D
> +               info->max_rx_buffer_size =3D
>                         be16_to_cpu(dev_op_buffer_sizes->packet_buffer_si=
ze);
> -               priv->header_buf_size =3D
> +               info->header_buf_size =3D
>                         be16_to_cpu(dev_op_buffer_sizes->header_buffer_si=
ze);
>                 dev_info(&priv->pdev->dev,
>                          "BUFFER SIZES device option enabled with max_rx_=
buffer_size of %u, header_buf_size of %u.\n",
> -                        priv->max_rx_buffer_size, priv->header_buf_size)=
;
> -               if (gve_is_dqo(priv) &&
> -                   priv->max_rx_buffer_size > GVE_DEFAULT_RX_BUFFER_SIZE=
)
> -                       priv->rx_cfg.packet_buffer_size =3D
> -                               priv->max_rx_buffer_size;
> +                        info->max_rx_buffer_size, info->header_buf_size)=
;
>         }
>
>         /* Read and store ring size ranges given by device */
>         if (dev_op_modify_ring &&
>             (supported_features_mask & GVE_SUP_MODIFY_RING_MASK)) {
> -               priv->modify_ring_size_enabled =3D true;
> -               priv->max_rx_desc_cnt =3D
> +               info->modify_ring_size_enabled =3D true;
> +               info->max_rx_ring_size =3D
>                         be16_to_cpu(dev_op_modify_ring->max_rx_ring_size)=
;
> -               priv->max_tx_desc_cnt =3D
> +               info->max_tx_ring_size =3D
>                         be16_to_cpu(dev_op_modify_ring->max_tx_ring_size)=
;
>                 if (priv->default_min_ring_size) {

Sashiko's report:

"Does this code still read the correct boolean?
Since gve_parse_device_option() was updated to set
priv->device_info.default_min_ring_size, but this check still looks
at the un-refactored priv->default_min_ring_size (which remains false),
won't we unconditionally enter the else block?"

Correct, this needs to now check for info->default_min_ring_size. Will
fix in v3.

>                         /* If device hasn't provided minimums, use defaul=
t minimums */
> -                       priv->min_tx_desc_cnt =3D GVE_DEFAULT_MIN_TX_RING=
_SIZE;
> -                       priv->min_rx_desc_cnt =3D GVE_DEFAULT_MIN_RX_RING=
_SIZE;
> +                       info->min_tx_ring_size =3D GVE_DEFAULT_MIN_TX_RIN=
G_SIZE;
> +                       info->min_rx_ring_size =3D GVE_DEFAULT_MIN_RX_RIN=
G_SIZE;
>                 } else {
> -                       priv->min_rx_desc_cnt =3D be16_to_cpu(dev_op_modi=
fy_ring->min_rx_ring_size);
> -                       priv->min_tx_desc_cnt =3D be16_to_cpu(dev_op_modi=
fy_ring->min_tx_ring_size);
> +                       info->min_rx_ring_size =3D
> +                               be16_to_cpu(dev_op_modify_ring->min_rx_ri=
ng_size);
> +                       info->min_tx_ring_size =3D
> +                               be16_to_cpu(dev_op_modify_ring->min_tx_ri=
ng_size);
>                 }
>         }
>
>         if (dev_op_flow_steering &&
>             (supported_features_mask & GVE_SUP_FLOW_STEERING_MASK)) {
>                 if (dev_op_flow_steering->max_flow_rules) {
> -                       priv->max_flow_rules =3D
> +                       info->max_flow_rules =3D
>                                 be32_to_cpu(dev_op_flow_steering->max_flo=
w_rules);
> -                       priv->dev->hw_features |=3D NETIF_F_NTUPLE;
>                         dev_info(&priv->pdev->dev,
>                                  "FLOW STEERING device option enabled wit=
h max rule limit of %u.\n",
> -                                priv->max_flow_rules);
> +                                info->max_flow_rules);
>                 }
>         }
>
>         if (dev_op_rss_config &&
>             (supported_features_mask & GVE_SUP_RSS_CONFIG_MASK)) {
> -               priv->rss_key_size =3D
> +               info->rss_key_size =3D
>                         be16_to_cpu(dev_op_rss_config->hash_key_size);
> -               priv->rss_lut_size =3D
> +               info->rss_lut_size =3D
>                         be16_to_cpu(dev_op_rss_config->hash_lut_size);
> -               priv->cache_rss_config =3D false;
> +               info->cache_rss_config =3D false;
>                 dev_dbg(&priv->pdev->dev,
>                         "RSS device option enabled with key size of %u, l=
ut size of %u.\n",
> -                       priv->rss_key_size, priv->rss_lut_size);
> +                       info->rss_key_size, info->rss_lut_size);
>         }
>
>         if (dev_op_nic_timestamp &&
>             (supported_features_mask & GVE_SUP_NIC_TIMESTAMP_MASK))
> -               priv->nic_timestamp_supported =3D true;
> +               info->nic_timestamp_supported =3D true;
> +}
> +
> +static void gve_fill_device_info(struct gve_priv *priv,
> +                                struct gve_device_descriptor *descriptor=
)
> +{
> +       struct gve_device_info *device_info =3D &priv->device_info;
> +       u16 default_num_queues;
> +
> +       device_info->tx_pages_per_qpl =3D
> +                               be16_to_cpu(descriptor->tx_pages_per_qpl)=
;
> +       device_info->max_registered_pages =3D
> +                               be64_to_cpu(descriptor->max_registered_pa=
ges);
> +       device_info->num_event_counters =3D be16_to_cpu(descriptor->count=
ers);
> +       ether_addr_copy(device_info->mac, descriptor->mac);
> +       device_info->max_mtu =3D  be16_to_cpu(descriptor->mtu);
> +
> +       default_num_queues =3D be16_to_cpu(descriptor->default_num_queues=
);
> +       device_info->default_tx_queues =3D default_num_queues;
> +       device_info->default_rx_queues =3D default_num_queues;
> +       device_info->default_tx_ring_size =3D
> +                               be16_to_cpu(descriptor->tx_queue_entries)=
;
> +       device_info->default_rx_ring_size =3D
> +                               be16_to_cpu(descriptor->rx_queue_entries)=
;
> +
> +       /* set default ranges */
> +       device_info->max_tx_ring_size =3D device_info->default_tx_ring_si=
ze;
> +       device_info->max_rx_ring_size =3D device_info->default_rx_ring_si=
ze;
> +       device_info->min_tx_ring_size =3D device_info->default_tx_ring_si=
ze;
> +       device_info->min_rx_ring_size =3D device_info->default_rx_ring_si=
ze;
>  }
>
>  int gve_adminq_describe_device(struct gve_priv *priv)
> @@ -1027,6 +1058,7 @@ int gve_adminq_describe_device(struct gve_priv *pri=
v)
>         struct gve_device_option_jumbo_frames *dev_op_jumbo_frames =3D NU=
LL;
>         struct gve_device_option_modify_ring *dev_op_modify_ring =3D NULL=
;
>         struct gve_device_option_rss_config *dev_op_rss_config =3D NULL;
> +       struct gve_device_info *device_info =3D &priv->device_info;
>         struct gve_device_option_gqi_rda *dev_op_gqi_rda =3D NULL;
>         struct gve_device_option_gqi_qpl *dev_op_gqi_qpl =3D NULL;
>         struct gve_device_option_dqo_rda *dev_op_dqo_rda =3D NULL;
> @@ -1070,26 +1102,26 @@ int gve_adminq_describe_device(struct gve_priv *p=
riv)
>          * DqoRda, DqoQpl, GqiRda, GqiQpl. Use GqiQpl as default.
>          */
>         if (dev_op_dqo_rda) {
> -               priv->queue_format =3D GVE_DQO_RDA_FORMAT;
> +               device_info->queue_format =3D GVE_DQO_RDA_FORMAT;
>                 dev_info(&priv->pdev->dev,
>                          "Driver is running with DQO RDA queue format.\n"=
);
>                 supported_features_mask =3D
>                         be32_to_cpu(dev_op_dqo_rda->supported_features_ma=
sk);
>         } else if (dev_op_dqo_qpl) {
> -               priv->queue_format =3D GVE_DQO_QPL_FORMAT;
> +               device_info->queue_format =3D GVE_DQO_QPL_FORMAT;
>                 supported_features_mask =3D
>                         be32_to_cpu(dev_op_dqo_qpl->supported_features_ma=
sk);
>         }  else if (dev_op_gqi_rda) {
> -               priv->queue_format =3D GVE_GQI_RDA_FORMAT;
> +               device_info->queue_format =3D GVE_GQI_RDA_FORMAT;
>                 dev_info(&priv->pdev->dev,
>                          "Driver is running with GQI RDA queue format.\n"=
);
>                 supported_features_mask =3D
>                         be32_to_cpu(dev_op_gqi_rda->supported_features_ma=
sk);
> -       } else if (priv->queue_format =3D=3D GVE_GQI_RDA_FORMAT) {
> +       } else if (device_info->queue_format =3D=3D GVE_GQI_RDA_FORMAT) {
>                 dev_info(&priv->pdev->dev,
>                          "Driver is running with GQI RDA queue format.\n"=
);
>         } else {
> -               priv->queue_format =3D GVE_GQI_QPL_FORMAT;
> +               device_info->queue_format =3D GVE_GQI_QPL_FORMAT;
>                 if (dev_op_gqi_qpl)
>                         supported_features_mask =3D
>                                 be32_to_cpu(dev_op_gqi_qpl->supported_fea=
tures_mask);
> @@ -1097,18 +1129,9 @@ int gve_adminq_describe_device(struct gve_priv *pr=
iv)
>                          "Driver is running with GQI QPL queue format.\n"=
);
>         }
>
> +       gve_fill_device_info(priv, descriptor);
>         gve_set_default_rss_sizes(priv);
>
> -       err =3D gve_set_mtu(priv, descriptor);
> -       if (err)
> -               goto free_device_descriptor;
> -
> -       priv->num_event_counters =3D be16_to_cpu(descriptor->counters);
> -
> -       gve_set_mac(priv, descriptor);
> -
> -       gve_set_queue_properties(priv, descriptor);
> -
>         gve_enable_supported_features(priv, supported_features_mask,
>                                       dev_op_jumbo_frames, dev_op_dqo_qpl=
,
>                                       dev_op_buffer_sizes, dev_op_flow_st=
eering,
> diff --git a/drivers/net/ethernet/google/gve/gve_adminq.h b/drivers/net/e=
thernet/google/gve/gve_adminq.h
> index ed5cb052a52d..831759d30f44 100644
> --- a/drivers/net/ethernet/google/gve/gve_adminq.h
> +++ b/drivers/net/ethernet/google/gve/gve_adminq.h
> @@ -655,11 +655,5 @@ int gve_adminq_report_nic_ts(struct gve_priv *priv,
>  struct gve_ptype_lut;
>  int gve_adminq_get_ptype_map_dqo(struct gve_priv *priv,
>                                  struct gve_ptype_lut *ptype_lut);
> -void gve_set_queue_properties(struct gve_priv *priv,
> -                             struct gve_device_descriptor *descriptor);
> -int gve_set_mtu(struct gve_priv *priv,
> -               struct gve_device_descriptor *descriptor);
> -void gve_set_mac(struct gve_priv *priv,
> -                struct gve_device_descriptor *descriptor);
>
>  #endif /* _GVE_ADMINQ_H */
> diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/eth=
ernet/google/gve/gve_main.c
> index 338dc0b3249a..1aeee916471f 100644
> --- a/drivers/net/ethernet/google/gve/gve_main.c
> +++ b/drivers/net/ethernet/google/gve/gve_main.c
> @@ -2380,6 +2380,8 @@ static int gve_set_num_ntfy_blks(struct gve_priv *p=
riv)
>
>  static void gve_set_num_queues(struct gve_priv *priv)
>  {
> +       struct gve_device_info *device_info =3D &priv->device_info;
> +
>         priv->tx_cfg.max_queues =3D
>                 min_t(int, priv->tx_cfg.max_queues, priv->num_ntfy_blks /=
 2);
>         priv->rx_cfg.max_queues =3D
> @@ -2387,12 +2389,14 @@ static void gve_set_num_queues(struct gve_priv *p=
riv)
>
>         priv->tx_cfg.num_queues =3D priv->tx_cfg.max_queues;
>         priv->rx_cfg.num_queues =3D priv->rx_cfg.max_queues;
> -       if (priv->default_num_queues > 0) {
> -               priv->tx_cfg.num_queues =3D min_t(int, priv->default_num_=
queues,
> +       if (device_info->default_tx_queues > 0)
> +               priv->tx_cfg.num_queues =3D min_t(int,
> +                                               device_info->default_tx_q=
ueues,
>                                                 priv->tx_cfg.num_queues);
> -               priv->rx_cfg.num_queues =3D min_t(int, priv->default_num_=
queues,
> +       if (device_info->default_rx_queues > 0)
> +               priv->rx_cfg.num_queues =3D min_t(int,
> +                                               device_info->default_rx_q=
ueues,
>                                                 priv->rx_cfg.num_queues);
> -       }
>
>         dev_info(&priv->pdev->dev, "TX queues %d, RX queues %d\n",
>                  priv->tx_cfg.num_queues, priv->rx_cfg.num_queues);
> @@ -2400,54 +2404,69 @@ static void gve_set_num_queues(struct gve_priv *p=
riv)
>                  priv->tx_cfg.max_queues, priv->rx_cfg.max_queues);
>  }
>
> -static void gve_set_default_desc_cnt(struct gve_priv *priv,
> -                                    const struct gve_device_descriptor *=
descriptor)
> +static void gve_set_desc_cnt(struct gve_priv *priv)
>  {
> -       priv->tx_desc_cnt =3D be16_to_cpu(descriptor->tx_queue_entries);
> -       priv->rx_desc_cnt =3D be16_to_cpu(descriptor->rx_queue_entries);
> +       struct gve_device_info *device_info =3D &priv->device_info;
>
> -       /* set default ranges */
> -       priv->max_tx_desc_cnt =3D priv->tx_desc_cnt;
> -       priv->max_rx_desc_cnt =3D priv->rx_desc_cnt;
> -       priv->min_tx_desc_cnt =3D priv->tx_desc_cnt;
> -       priv->min_rx_desc_cnt =3D priv->rx_desc_cnt;
> +       priv->tx_desc_cnt =3D device_info->default_tx_ring_size;
> +       priv->rx_desc_cnt =3D device_info->default_rx_ring_size;
> +       priv->max_tx_desc_cnt =3D device_info->max_tx_ring_size;
> +       priv->max_rx_desc_cnt =3D device_info->max_rx_ring_size;
> +       priv->min_tx_desc_cnt =3D device_info->min_tx_ring_size;
> +       priv->min_rx_desc_cnt =3D device_info->min_rx_ring_size;
>  }
>
> -void gve_set_queue_properties(struct gve_priv *priv,
> -                             struct gve_device_descriptor *descriptor)
> +static void gve_set_queue_properties(struct gve_priv *priv)
>  {
> -       /* set default descriptor counts */
> -       gve_set_default_desc_cnt(priv, descriptor);
> +       struct gve_device_info *device_info =3D &priv->device_info;
>
> -       priv->max_registered_pages =3D be64_to_cpu(descriptor->max_regist=
ered_pages);
> -       priv->tx_pages_per_qpl =3D be16_to_cpu(descriptor->tx_pages_per_q=
pl);
> -       priv->default_num_queues =3D be16_to_cpu(descriptor->default_num_=
queues);
> +       gve_set_desc_cnt(priv);
> +       priv->max_registered_pages =3D device_info->max_registered_pages;
> +       priv->tx_pages_per_qpl =3D device_info->tx_pages_per_qpl;
>  }
>
> -int gve_set_mtu(struct gve_priv *priv,
> -               struct gve_device_descriptor *descriptor)
> +static int gve_set_mtu(struct gve_priv *priv)
>  {
> +       struct gve_device_info *device_info =3D &priv->device_info;
>         u16 mtu;
>
> -       mtu =3D be16_to_cpu(descriptor->mtu);
> +       mtu =3D device_info->max_mtu;
>         if (mtu < ETH_MIN_MTU) {
>                 dev_err(&priv->pdev->dev, "MTU %d below minimum MTU\n", m=
tu);
>                 return -EINVAL;
>         }
>         priv->dev->max_mtu =3D mtu;
> +       priv->dev->mtu =3D priv->dev->max_mtu;
>
>         return 0;
>  }
>
> -void gve_set_mac(struct gve_priv *priv,
> -                struct gve_device_descriptor *descriptor)
> +static void gve_set_mac(struct gve_priv *priv)
>  {
> -       eth_hw_addr_set(priv->dev, descriptor->mac);
> -       dev_info(&priv->pdev->dev, "MAC addr: %pM\n", descriptor->mac);
> +       struct gve_device_info *device_info =3D &priv->device_info;
> +
> +       eth_hw_addr_set(priv->dev, device_info->mac);
> +       dev_info(&priv->pdev->dev, "MAC addr: %pM\n", device_info->mac);
> +}
> +
> +static void gve_set_buf_sizes(struct gve_priv *priv)
> +{
> +       struct gve_device_info *device_info =3D &priv->device_info;
> +
> +       if (device_info->max_rx_buffer_size > priv->max_rx_buffer_size)
> +               priv->max_rx_buffer_size =3D device_info->max_rx_buffer_s=
ize;
> +
> +       if (gve_is_dqo(priv) &&
> +           priv->max_rx_buffer_size > GVE_DEFAULT_RX_BUFFER_SIZE)
> +               priv->rx_cfg.packet_buffer_size =3D priv->max_rx_buffer_s=
ize;
> +
> +       if (device_info->header_buf_size)
> +               priv->header_buf_size =3D device_info->header_buf_size;
>  }
>
>  static int gve_init_priv(struct gve_priv *priv, bool skip_describe_devic=
e)
>  {
> +       struct gve_device_info *device_info =3D &priv->device_info;
>         int err;
>
>         /* Set up the adminq */
> @@ -2463,11 +2482,13 @@ static int gve_init_priv(struct gve_priv *priv, b=
ool skip_describe_device)
>         if (skip_describe_device)
>                 goto setup_device;
>
> -       priv->queue_format =3D GVE_QUEUE_FORMAT_UNSPECIFIED;
> +       device_info->queue_format =3D GVE_QUEUE_FORMAT_UNSPECIFIED;
>         err =3D gve_adminq_get_device_properties(priv);
>         if (err)
>                 goto err;
>
> +       priv->queue_format =3D priv->device_info.queue_format;
> +
>         err =3D gve_set_num_ntfy_blks(priv);
>         if (err) {
>                 dev_err(&priv->pdev->dev,
> @@ -2491,12 +2512,34 @@ static int gve_init_priv(struct gve_priv *priv, b=
ool skip_describe_device)
>                 netif_set_tso_max_size(priv->dev, GVE_DQO_TX_MAX);
>         }
>
> -       priv->dev->mtu =3D priv->dev->max_mtu;
> +       if (gve_set_mtu(priv)) {
> +               err =3D -EINVAL;
> +               goto err;
> +       }
> +
> +       priv->num_event_counters =3D device_info->num_event_counters;
> +
> +       gve_set_mac(priv);
> +
> +       gve_set_queue_properties(priv);
> +       priv->modify_ring_size_enabled =3D device_info->modify_ring_size_=
enabled;
> +
> +       gve_set_buf_sizes(priv);
> +
> +       priv->max_flow_rules =3D device_info->max_flow_rules;
> +       if (priv->max_flow_rules)
> +               priv->dev->hw_features |=3D NETIF_F_NTUPLE;
> +
> +       priv->rss_key_size =3D device_info->rss_key_size;
> +       priv->rss_lut_size =3D device_info->rss_lut_size;
> +       priv->cache_rss_config =3D device_info->cache_rss_config;
> +
>         priv->numa_node =3D dev_to_node(&priv->pdev->dev);
>         priv->tx_cfg.num_xdp_queues =3D 0;
>         priv->rx_copybreak =3D GVE_DEFAULT_RX_COPYBREAK;
>         priv->ts_config.tx_type =3D HWTSTAMP_TX_OFF;
>         priv->ts_config.rx_filter =3D HWTSTAMP_FILTER_NONE;
> +       priv->nic_timestamp_supported =3D device_info->nic_timestamp_supp=
orted;
>
>  setup_device:
>         priv->xsk_pools =3D bitmap_zalloc(priv->rx_cfg.max_queues, GFP_KE=
RNEL);
> --
> 2.54.0.1013.g208068f2d8-goog
>
