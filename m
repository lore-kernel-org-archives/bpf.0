Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60071309EE7
	for <bpf@vger.kernel.org>; Fri,  7 Aug 2026 02:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786068899; cv=pass; b=T65miQC4NGD+Zdxj8gExthxbnQ3c7p/sCkmKbNMVpPSAbXGYWsuD/5WmcecTZwMDyiUkVoEcfggpcmCqSpz0uV4ABvqcN8GobHmatuVi51tvkvO1V2PcHmD/Sn7CClPfRGg4myA/+cYXCpVCQNpDLnhFW3KnHozvgD7f7Xvpn84=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786068899; c=relaxed/simple;
	bh=s+xKiFHJBBy/E7iKJRql1oR+GWR7kgeVVxD2wlIPY08=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=avxdxeO9gj6/ansYL9JSmAOZxSx5EgMZcrTR15jwUTM2Dh/d1nO7+g3sP+dgO9LdVAC5NgCPkgxp9KJRtfa6F3orlIdUSDj01MSnQQWf1WzkgNYXbXNqJM3kUNlxINRR7lqE9uQUwcx/Yo+wNo1YzS3Dz1ccSoKSAd85HIhkhqI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=K3LTefH5; arc=pass smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="K3LTefH5"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2cede6375caso55445ad.0
        for <bpf@vger.kernel.org>; Thu, 06 Aug 2026 19:14:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786068897; cv=none;
        d=google.com; s=arc-20260327;
        b=cgrPLzZlpnT2uSSJPrb47wzOuNsA1INSTrGsoxH0/s73lvPLi4bhmtManv9IgsUoN6
         SkhN7yrNfWio32WYp3XEJ0OFKgponEtRH2X/LBz1bvot8hTgRmGt6XVRFlOqb9bS4uz/
         38+ITMxncjtn5b5RsGvEjiDs9z5Xc8iKdZT2P899O0M3MkzHc2p3rwpEj9c03Qj2UGIg
         Q0v+46qRWsz3N6DaHDFVV70wWL1EawSgVHipo4LD2QkbpE0eF/YKkkYnVNs7UcWXl5jZ
         5VkX6zNqUk60GJKqZahtyyoFIw4Kd5mMR/+0Ytr3WjOpmTBdcBcmP5btAJGq29Dfn7+/
         WUvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2P5MhNiHPzKjEEF/TkYbXp0YfkRl5rdJJLPIXj8lWFI=;
        fh=TbTKcWHCSfiSP5Y7MuNR1Z2J1w6NjpFBF/THDL/Qo7I=;
        b=mPpJqhFQWH+3Oiklq23w2FAAtXx3AdbIX9+hxICTeGlRZKjlGzPeqwfapgs3BNSlI2
         EXmu0oGDWXh+XUrAFMKdpZFcDltTxGXI1LqF/FZm4Tj2vHQ97foZ5UUt9k4IytJe3Y/s
         /nM1h1CnbVXlu4xzU9NQlL1nTgEsATxWKAw6GrYnv8mNDM6jmaX8feoWOfWmYEjAaRYY
         v9wuV5vCVDVFGUFhy9vDUWiV7ZN8zjAGw7BfnrzCkPGdQM9lBZWoXWo9yQ8QAuZc4cCA
         n4WLQ2Z3geJeA3pmQEORkkU6RzNEV3p0az58Z577DGPwoyo9YeEiNgFDXI9zwAbEMUrF
         ZXLQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786068897; x=1786673697; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2P5MhNiHPzKjEEF/TkYbXp0YfkRl5rdJJLPIXj8lWFI=;
        b=K3LTefH5BHEqZAn/f9tXFDCsqIsuXO0JPfre/2jnhnU2SE3l4yqKOuogNsDYjFs0Pk
         Yaqm3rd91Nd86xr2yYMOxHzLM+riyI6JjxwuQM0AS7GOCUymCBZIuf5yWt18i3qJDKrt
         I7EO0oAGVvmhPusCgCCcgdQtcwjbFsTrsN5siwsOErRQe1yXYfN1RUkg3IVXXPI/BN7R
         ByB1Eh4rS4encG3jkJFClrxu5coMV9uROdVyOwNwDDKxZfRtzMFfG1c5doaJU6Cy0Li3
         van9d6e6G7RSC0U/ZceXTFz7kfpRIorgoN/rtxM21PpQleKWv9Il9On5wYq6Ihju4fj3
         0zeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786068897; x=1786673697;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2P5MhNiHPzKjEEF/TkYbXp0YfkRl5rdJJLPIXj8lWFI=;
        b=JlHDuI+VzJWpMjpExhyObqkpOO1+c7s9iF+MFEXyrCz3B2pj2F60MCYaMzemh8bJ/x
         /56Qs3c2NX3RpGHMKPz1mj6JIE21+ZzPiMEJxYYODelmDFkrwGp+dlWNtSob5YQV3DnR
         jGRaZc9dw/JYHzwBP5E3ulSy5BmTroTTmd1GfHguUe1g9cQMrBifmkO0H3m12Adk0bx1
         DD+aRTzd2qMlceFuPLfhXdZRMiEn/tvGtoM0thztK1R592sA6LcKlUN1dOyovVHW5rKy
         Q9O/tGDhmWMhwA7Nf7QvxibIGC7/SKpC5212YL82FmoPWabB4TBtLLjaX08KJqd8sZlO
         /RsA==
X-Forwarded-Encrypted: i=1; AHgh+RrGqmfJkQB5B9y3QP4Q9spahLpJesG/+a4lUI+8q0rICrusPB+SVfUmZCokxD5Rw3dTl68=@vger.kernel.org
X-Gm-Message-State: AOJu0YzeKo5L6jDI5C3P7b3Iu2B+D9kdaS8ofDzwsSeDdLiOkKGqnBSr
	4zlf82vO+MIwwrZqIKFeOtv/8wwm+br+286STGJ9Kid6HXDPJxntyQXcJzoo2nxtGTDLhJegxl/
	MuJAbZmQb6S4w2ciI9JbbKdWf+EonkhfFmYfLN+Bs
X-Gm-Gg: AR+sD10AWFMoHDHC8WrjhaLPP8/LobHY6B3NQwM4VsAkVMUM5Ljoo4UP/ER/JkYNZo0
	P1GuJ7qWD76AcpLmvvA7fsM5wTVUYFU2StVl5BckOZF/RrAziB6yUaAT5N5sXAxbZa9tC0IDd9a
	L7rOD7hdGB3WF6bF5Fdf1DVNvqqrE9ryQbvkqNnML5bxSGjAUvzBWaCYHGbXIXUXZT2oA1GYbLo
	G860g5CgHMtjeoDJdGMxokmNujQ2sHrr/Z9Ka1ENpY5FLxVVYuQ/xO94BnMOe0fk2S7BQOVI/7u
	CvSYI7ZQ9IGbr6fJSW9yxtbDBOBozZ4LIO9QyUpwRnfp9PmzINVBCamb+wkAnD3HHKVjvxX82uc
	8MFFZ68bRHUWIxb3qnmzbHa88tutMFRb2mNsE0mYe5XaE9A==
X-Received: by 2002:a17:903:3113:b0:2c6:99be:9dd with SMTP id
 d9443c01a7336-2d120453f39mr3897575ad.12.1786068896136; Thu, 06 Aug 2026
 19:14:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260803184630.3813311-1-hramamurthy@google.com>
 <20260803184630.3813311-5-hramamurthy@google.com> <6bb3205d-e9b9-4f18-8d8a-5bde4d014084@intel.com>
In-Reply-To: <6bb3205d-e9b9-4f18-8d8a-5bde4d014084@intel.com>
From: Harshitha Ramamurthy <hramamurthy@google.com>
Date: Thu, 6 Aug 2026 19:14:45 -0700
X-Gm-Features: AUfX_myuze9JU7w6bPUkVxEX0R5VeDbSrPzG_JXTCAzhpHfrqxcV_HlAKdjaei0
Message-ID: <CAEAWyHewnJ3DpbeaMiYcHnbpFz09weW6FBfvmX1FcFX2g1AFAg@mail.gmail.com>
Subject: Re: [PATCH net-next v3 04/15] gve: add struct gve_device_info to hold
 device properties
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: netdev@vger.kernel.org, joshwash@google.com, andrew+netdev@lunn.ch, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org, 
	john.fastabend@gmail.com, sdf@fomichev.me, jordanrhee@google.com, 
	willemb@google.com, nktgrg@google.com, maolson@google.com, thostet@google.com, 
	jacob.e.keller@intel.com, debarghyak@google.com, kees@kernel.org, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 6, 2026 at 12:19=E2=80=AFAM Przemek Kitszel
<przemyslaw.kitszel@intel.com> wrote:
>
> On 8/3/26 20:46, Harshitha Ramamurthy wrote:
> > In the current AdminQ mode, device properties are written into
> > struct gve_device_descriptor that is allocated in shared memory
> > between the driver and device. In the upcoming MailboxQ mode,
> > these properties will be returned in the response of a mailbox
> > message. Hence, add struct gve_device_info as the structure that
> > holds all the properties that are negotiated with the device in
> > either mode.
> >
> > Change the AdminQ mode method gve_adminq_describe_device()
> > and its children to fill up device information into this newly
> > introduced struct gve_device_info. Move a few helper functions
> > and code that set device properties in the priv structure into
> > gve_init_priv(). So now gve_init_priv() calls/does the following:
> >
> > - gve_set_mtu()
> > - gve_set_mac()
> > - gve_set_queue_properties()
> > - gve_set_buf_sizes()
> > - set flow steering and RSS properties
> > - set other priv properties
> >
> > When MailboxQ support is added, device information will be filled
> > into the same structure and the same gve_init_priv() path would be
> > used to set device properties to ensure common code reusage.
> >
> > These changes are refactors only, no functional change.
> >
> > Reviewed-by: Willem de Bruijn <willemb@google.com>
> > Reviewed-by: Jordan Rhee <jordanrhee@google.com>
> > Signed-off-by: Harshitha Ramamurthy <hramamurthy@google.com>
> > ---
> > Changes in v3:
> > - Read default_min_ring_size from device info instead of priv
> >
> >   drivers/net/ethernet/google/gve/gve.h        |  29 +++++
> >   drivers/net/ethernet/google/gve/gve_adminq.c | 115 +++++++++++-------=
-
> >   drivers/net/ethernet/google/gve/gve_adminq.h |   6 -
> >   drivers/net/ethernet/google/gve/gve_main.c   | 101 +++++++++++-----
> >   4 files changed, 170 insertions(+), 81 deletions(-)
> >
> > diff --git a/drivers/net/ethernet/google/gve/gve.h b/drivers/net/ethern=
et/google/gve/gve.h
> > index c280ff35ee77..021adb9108df 100644
> > --- a/drivers/net/ethernet/google/gve/gve.h
> > +++ b/drivers/net/ethernet/google/gve/gve.h
> > @@ -797,6 +797,34 @@ struct gve_ptp {
> >       struct gve_priv *priv;
> >   };
> >
> > +struct gve_device_info {
> > +     enum gve_queue_format queue_format;
> > +     u16 default_tx_queues;
> > +     u16 default_rx_queues;
> > +     u16 max_tx_queues;
> > +     u16 max_rx_queues;
> > +     u16 default_tx_ring_size;
> > +     u16 default_rx_ring_size;
> > +     u16 max_tx_ring_size;
> > +     u16 max_rx_ring_size;
> > +     u16 min_tx_ring_size;
> > +     u16 min_rx_ring_size;
> > +     u16 max_mtu;
> > +     u8 mac[ETH_ALEN];
> > +     u16 max_rx_buffer_size;
> > +     u16 header_buf_size;
> > +     u32 max_flow_rules;
> > +     u16 rss_key_size;
> > +     u16 rss_lut_size;
> > +     u16 tx_pages_per_qpl;
> > +     u16 num_event_counters;
> > +     u64 max_registered_pages;
> > +     bool default_min_ring_size;
> > +     bool nic_timestamp_supported;
> > +     bool modify_ring_size_enabled;
> > +     bool cache_rss_config;
> > +};
>
> you could save some bytes of the struct size by reordering fields

I did run pahole on this struct previously:

$pahole -C gve_device_info gve.ko
struct gve_device_info {
enum gve_queue_format      queue_format;         /*     0     4 */
u16                        default_tx_queues;    /*     4     2 */
u16                        default_rx_queues;    /*     6     2 */
u16                        max_tx_queues;        /*     8     2 */
u16                        max_rx_queues;        /*    10     2 */
u16                        default_tx_ring_size; /*    12     2 */
u16                        default_rx_ring_size; /*    14     2 */
u16                        max_tx_ring_size;     /*    16     2 */
u16                        max_rx_ring_size;     /*    18     2 */
u16                        min_tx_ring_size;     /*    20     2 */
u16                        min_rx_ring_size;     /*    22     2 */
u16                        max_mtu;              /*    24     2 */
u8                         mac[6];               /*    26     6 */
u16                        max_rx_buffer_size;   /*    32     2 */
u16                        header_buf_size;      /*    34     2 */
u32                        max_flow_rules;       /*    36     4 */
u16                        rss_key_size;         /*    40     2 */
u16                        rss_lut_size;         /*    42     2 */
u16                        tx_pages_per_qpl;     /*    44     2 */
u16                        num_event_counters;   /*    46     2 */
u64                        max_registered_pages; /*    48     8 */
bool                       default_min_ring_size; /*    56     1 */
bool                       nic_timestamp_supported; /*    57     1 */
bool                       modify_ring_size_enabled; /*    58     1 */
bool                       cache_rss_config;     /*    59     1 */

/* size: 64, cachelines: 1, members: 25 */
/* padding: 4 */
};

>
> > +
> >   struct gve_priv {
> >       struct net_device *dev;
> >       struct gve_tx_ring *tx; /* array of tx_cfg.num_queues */
> > @@ -929,6 +957,7 @@ struct gve_priv {
> >       struct gve_nic_ts_report *nic_ts_report;
> >       dma_addr_t nic_ts_report_bus;
> >       u64 last_sync_nic_counter; /* Clock counter from last NIC TS repo=
rt */
> > +     struct gve_device_info device_info;
> >   };
>
>
> [..]
>
> > -int gve_set_mtu(struct gve_priv *priv,
> > -             struct gve_device_descriptor *descriptor)
> > +static int gve_set_mtu(struct gve_priv *priv)
> >   {
> > +     struct gve_device_info *device_info =3D &priv->device_info;
> >       u16 mtu;
> >
> > -     mtu =3D be16_to_cpu(descriptor->mtu);
> > +     mtu =3D device_info->max_mtu;
> >       if (mtu < ETH_MIN_MTU) {
> >               dev_err(&priv->pdev->dev, "MTU %d below minimum MTU\n", m=
tu);
> >               return -EINVAL;
> >       }
> >       priv->dev->max_mtu =3D mtu;
> > +     priv->dev->mtu =3D priv->dev->max_mtu;
>
> nit: I would just use `=3D mtu`
>
> >
> >       return 0;
> >   }
> >
> > -void gve_set_mac(struct gve_priv *priv,
> > -              struct gve_device_descriptor *descriptor)
> > +static void gve_set_mac(struct gve_priv *priv)
> >   {
> > -     eth_hw_addr_set(priv->dev, descriptor->mac);
> > -     dev_info(&priv->pdev->dev, "MAC addr: %pM\n", descriptor->mac);
> > +     struct gve_device_info *device_info =3D &priv->device_info;
> > +
> > +     eth_hw_addr_set(priv->dev, device_info->mac);
> > +     dev_info(&priv->pdev->dev, "MAC addr: %pM\n", device_info->mac);
> > +}
>
> whole function is rewritten (in git sense), and it was just added in
> previous commit
>
> one way to avoid that is to extract "mac" variable in the prev patch,
> and here only update the assignement and function signature

Makes sense, will be easier to review the diff. Will make this change.

>
> > +
> > +static void gve_set_buf_sizes(struct gve_priv *priv)
> > +{
> > +     struct gve_device_info *device_info =3D &priv->device_info;
> > +
> > +     if (device_info->max_rx_buffer_size > priv->max_rx_buffer_size)
> > +             priv->max_rx_buffer_size =3D device_info->max_rx_buffer_s=
ize;
> > +
> > +     if (gve_is_dqo(priv) &&
> > +         priv->max_rx_buffer_size > GVE_DEFAULT_RX_BUFFER_SIZE)
> > +             priv->rx_cfg.packet_buffer_size =3D priv->max_rx_buffer_s=
ize;
> > +
> > +     if (device_info->header_buf_size)
> > +             priv->header_buf_size =3D device_info->header_buf_size;
> >   }
> >
> >   static int gve_init_priv(struct gve_priv *priv, bool skip_describe_de=
vice)
> >   {
> > +     struct gve_device_info *device_info =3D &priv->device_info;
> >       int err;
> >
> >       /* Set up the adminq */
> > @@ -2514,7 +2533,7 @@ static int gve_init_priv(struct gve_priv *priv, b=
ool skip_describe_device)
> >       if (skip_describe_device)
> >               goto setup_device;
> >
> > -     priv->queue_format =3D GVE_QUEUE_FORMAT_UNSPECIFIED;
> > +     device_info->queue_format =3D GVE_QUEUE_FORMAT_UNSPECIFIED;
> >       /* Get the initial information we need from the device */
> >       err =3D gve_adminq_describe_device(priv);
> >       if (err) {
> > @@ -2523,6 +2542,8 @@ static int gve_init_priv(struct gve_priv *priv, b=
ool skip_describe_device)
> >               goto err;
> >       }
> >
> > +     priv->queue_format =3D priv->device_info.queue_format;
> > +
> >       err =3D gve_set_num_ntfy_blks(priv);
> >       if (err) {
> >               dev_err(&priv->pdev->dev,
> > @@ -2546,12 +2567,34 @@ static int gve_init_priv(struct gve_priv *priv,=
 bool skip_describe_device)
> >               netif_set_tso_max_size(priv->dev, GVE_DQO_TX_MAX);
> >       }
> >
> > -     priv->dev->mtu =3D priv->dev->max_mtu;
> > +     if (gve_set_mtu(priv)) {
> > +             err =3D -EINVAL;
> > +             goto err;
> > +     }
> > +
> > +     priv->num_event_counters =3D device_info->num_event_counters;
> > +
> > +     gve_set_mac(priv);
> > +
> > +     gve_set_queue_properties(priv);
> > +     priv->modify_ring_size_enabled =3D device_info->modify_ring_size_=
enabled;
> > +
> > +     gve_set_buf_sizes(priv);
> > +
> > +     priv->max_flow_rules =3D device_info->max_flow_rules;
> > +     if (priv->max_flow_rules)
> > +             priv->dev->hw_features |=3D NETIF_F_NTUPLE;
> > +
> > +     priv->rss_key_size =3D device_info->rss_key_size;
> > +     priv->rss_lut_size =3D device_info->rss_lut_size;
> > +     priv->cache_rss_config =3D device_info->cache_rss_config;
>
> I don't know, especially with your MailboxQ coming next, if following
> makes sense, but I wonder why you have to copy whole device info into
> priv (or IOW, hold two copies of most params)?

For the upcoming mailboxQ control plane path, device properties will
be negotiated with the device before the priv structure is available.
Hence this struct is introduced to hold device properties. Also the
idea is that gve_device_info contains properties negotiated
with/returned by the device while priv tracks active driver
configuration properties.

>
> Alternative will be to use variables from device info everywhere,
> you could even achieve that without any code changes via struct_group
>
> > +
> >       priv->numa_node =3D dev_to_node(&priv->pdev->dev);
> >       priv->tx_cfg.num_xdp_queues =3D 0;
> >       priv->rx_copybreak =3D GVE_DEFAULT_RX_COPYBREAK;
> >       priv->ts_config.tx_type =3D HWTSTAMP_TX_OFF;
> >       priv->ts_config.rx_filter =3D HWTSTAMP_FILTER_NONE;
> > +     priv->nic_timestamp_supported =3D device_info->nic_timestamp_supp=
orted;
> >
> >   setup_device:
> >       priv->xsk_pools =3D bitmap_zalloc(priv->rx_cfg.max_queues, GFP_KE=
RNEL);
>
