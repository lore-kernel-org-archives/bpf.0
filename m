Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F19AC37756F
	for <bpf@vger.kernel.org>; Fri,  5 Jun 2026 03:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780630915; cv=pass; b=WNo5w5fv+1yk/KShZ7SEw5N+3A2BCfNF7tcbbaAtt/UNRYDAdjIPV/4XRXYlbWDhdKjYqd2dZg6vlV7jr+m1GpCbJydhqianx7t6DJtLyv9Wh3syPNVijR0KoDcnd+9lqRz+cUjw/Tz3ilqb9KpIOX0iWIX23hhL6PylUFmKqKY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780630915; c=relaxed/simple;
	bh=eGCEm9OPC7WdXzEUoowen9BuZuShye6xTxIjLk/tTLY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ld8D/BMux8tBl2+Q2MwgiOCmdeqiP7e1jgbG7wBbsiw9t1LdRAuAIjx+oNzmveB8jQmmLqxO+ESxKL+xUvFlApMWFrrpPyIj0vfPhpbPBLYbmHusEZBEtk1IZcV1AkiEUvtpNp2j20CC6+nb7hjiGMMvIg+U7ZgN17NOoynaCsI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MACYrUUN; arc=pass smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MACYrUUN"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2bf2d865383so42155ad.1
        for <bpf@vger.kernel.org>; Thu, 04 Jun 2026 20:41:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780630913; cv=none;
        d=google.com; s=arc-20240605;
        b=bkLGaVhBKSBK1GcJva8phsCk456N751LKpK4cjTyRKDIsddSJLy1Y3iTUTd7qTcKd1
         J+/DhqirmEzq4zF1nJnudAY54H9k0C2uMgS0w42Y78EGb3yDjKi6ah+fbs0aO8ZgIPyS
         gYm7t/gLVe7n1OL2TLmWOf82u/73c2cnRnFGlZHVh1eCPF18USs0wRG0hLbeVH687lvK
         VeGowbkVefR7owYLiTU1Mvbin2qiFvobzJQQBEU5SuIJGt7iuWGzARv0o7QqqivM2d44
         +aSBiZXex9/wjN4GLpjOH0pxdVVglBZ26WfjRUHeZJe4/hO2DSiHwoxopACyliAdTii7
         Vj3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Ceuq4fqgPta3jeOPTygEvNTBZ1gtxFFoAFHP7IeAjCg=;
        fh=8IEgg+j9L5Bkm8/WyFxsEuUdLo8EnzROT5NL7L9+a80=;
        b=JjAcSDtI4Eck7Ak8jaiL5aRgiHRn9DqIjViIqWcumDc3k/nf38+9/Vk5p2B8KVBRxu
         y3oEUb98MfyWKl5Sykjp5NJ0bSVZ8vJUrng0gBuNDquG1TPttrh2yumPW4i2wl/UUUxE
         cTqblKZbzZzHeUJ6PDiy4URyV+tGrlC43S4sqfrlppri9O43PcUfZUmQl1T7e80ZrXmU
         i1V0WBS8XJvDjNS2HzEFkSDYGx3Kp3I1/rls3pQWAYPR6WuO3RtRk6sGzV0P0GVjRKQe
         t3u1ufusw6vrfnqA8jv9wkQCRwmSEkXJv+FErtaIIk7SRuU2l70vaRSRjSlADAHuynfb
         jZNQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780630913; x=1781235713; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ceuq4fqgPta3jeOPTygEvNTBZ1gtxFFoAFHP7IeAjCg=;
        b=MACYrUUNZFez4jZ/lXozDCvCtMIDtEdL1hitaPfGTqHGeSn8VnSLrD76j0vGFz05Bw
         E1JJXScj9e4XAOPkzZxapMRlzV4aB7Jcln4p9+/M8+cKuSyTWOW9VdjRYjSlaksm0kyA
         3j4EZF7nU93kROoDwXUclk1gAMjQ7AwMpItcA/KN+PGS1L/k5KRqwuGs4ZMXsAph5CJt
         hbqHWLUJwqRT86PhQ1/qC1y9o0aW9FktnLLCN9Ki5ASohtrWjLL1IWuLTxla8vBewu8o
         udVAbJGTIKr03uwkqnCOOasIEXbhxybFrSXGA339bMs5DIhPI4SjX0TX2PmOy2/lP5b7
         QLOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780630913; x=1781235713;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ceuq4fqgPta3jeOPTygEvNTBZ1gtxFFoAFHP7IeAjCg=;
        b=MjCT5DYXRWUNSgbTuFgDDpXnSfgV19OWykGy5Y0jFr085w3c3xVpLY5SgT+KkfkA4z
         /VoA4RliFrnENw8FvUB24rm4EnFuCBmJ8aMPXhfM7ndrzT2Rk54c2YAkvbZTw+WgCk+l
         TSusvPZPgT5/9AX7GOhTzQ9c9ReclusavRLRFbl+qAM/90/0q3Rl6nyHBxc5Xddrl+XN
         wTk20BYlI8i2MEhO5aRjOlQakG1LR0Z5Ma3DYGVH/iogTvhJaPBG9PhHzYXVguGAr8M4
         nhFLVPAADnNDmKkUYFwuHj115lfVg05o4PzgoeKGFk5NnwwJiF8ojlbF2dzg8U5jy/9P
         3D3Q==
X-Forwarded-Encrypted: i=1; AFNElJ9W15s8Kf6gGxyqr3JZvA4omSBc1Na/ibkuOGN9sxVeLtPzLhPaGyftEm5h9aP01ESr67E=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxHK5r7wdpTHejE46H2XpmZQLtmMsYqv6k25L4mSvpwLe/yX10
	agqlCNS8of/iwXl0ROWFZtj/1QQM10iSE7P5o9VOA1PIhu4t18YSpr4DJ3rVmuI0rCZpamxUSuj
	110CT3nFRIanDHgUDGNkPJNdP4/CO8toqYrG0MSnB
X-Gm-Gg: Acq92OHv9uNtRXcXAh58QyJyRv5dAhFpP1Oc4xDvbDiWmrXGceI1kD4k8r4CekKvhf+
	Zu93ZeuGs8kAUmBFAkWcClhodc1oZz8vifRvebaIshkWdNp6pUr+G8Dpq6cJwIHDv8bdT9KZdcs
	aAOieB0C+jS/w9mykHyMTUG5AyPlBPwGBvuN5WzxovYjzQG6U+CTBD/nRFZmYArkz6uo1ibGeDV
	JG+EALXdBX6Zm1r8bceY5H45RhCjv05qMC7GPkW1z9R6hhOsNsRbIz0jVXqaCeXHZ7Hvn5xdUQn
	gLFgwUFPk0EFFnukzsJrJ7rLchF5Uzb/FhTKQRdCy6hBZrs8jezbk2OlmjjXipR4x1NAKpoQIUd
	G9Js8sY5a/VpZmVTT1aQ=
X-Received: by 2002:a17:903:41d0:b0:2c0:c877:8095 with SMTP id
 d9443c01a7336-2c1eb72a55emr574515ad.2.1780630912554; Thu, 04 Jun 2026
 20:41:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260602235900.3050782-1-hramamurthy@google.com> <20260602235900.3050782-3-hramamurthy@google.com>
In-Reply-To: <20260602235900.3050782-3-hramamurthy@google.com>
From: Harshitha Ramamurthy <hramamurthy@google.com>
Date: Thu, 4 Jun 2026 20:41:40 -0700
X-Gm-Features: AVHnY4KtZ1UUobwVDAvmG8aRjJ3MDRoZKzyGvXpEAt-RDwCE67_lbB7xedj11ko
Message-ID: <CAEAWyHeiBGH46U_bz82rzoZ7ig0+2B0K-h9qpDmfLZ-zHjHV+Q@mail.gmail.com>
Subject: Re: [PATCH net-next v2 02/15] gve: refactor initialization with
 helper functions
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
> In the interest of commonizing code, refactor gve_probe()
> and gve_init_priv() with a few helper functions that can
> be expanded and utilized in upcoming patches that add the
> mailbox ABI to the driver. The helper functions are:
>
> - gve_set_num_ntfy_blks()
> - gve_set_num_queues()
>
> Reorder code to combine lines that accomplish a similar objective
> like setting defaults. Move setting HW-GRO and UDP GSO support out
> of an Adminq method into gve_init_priv().
>
> These changes are just code movement, no functional change.
>
> Reviewed-by: Willem de Bruijn <willemb@google.com>
> Reviewed-by: Jordan Rhee <jordanrhee@google.com>
> Signed-off-by: Harshitha Ramamurthy <hramamurthy@google.com>
> ---
>  drivers/net/ethernet/google/gve/gve_adminq.c |   8 --
>  drivers/net/ethernet/google/gve/gve_main.c   | 108 +++++++++++--------
>  2 files changed, 65 insertions(+), 51 deletions(-)
>
> diff --git a/drivers/net/ethernet/google/gve/gve_adminq.c b/drivers/net/e=
thernet/google/gve/gve_adminq.c
> index 70ffed8b52c3..dfeabddfb396 100644
> --- a/drivers/net/ethernet/google/gve/gve_adminq.c
> +++ b/drivers/net/ethernet/google/gve/gve_adminq.c
> @@ -1117,14 +1117,6 @@ int gve_adminq_describe_device(struct gve_priv *pr=
iv)
>
>         gve_set_default_rss_sizes(priv);
>
> -       /* DQO supports HW-GRO and UDP_GSO */
> -       if (gve_is_dqo(priv)) {
> -               u64 additional_features =3D NETIF_F_GRO_HW | NETIF_F_GSO_=
UDP_L4;
> -
> -               priv->dev->hw_features |=3D additional_features;
> -               priv->dev->features |=3D additional_features;
> -       }
> -
>         priv->max_registered_pages =3D
>                                 be64_to_cpu(descriptor->max_registered_pa=
ges);
>         mtu =3D be16_to_cpu(descriptor->mtu);
> diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/eth=
ernet/google/gve/gve_main.c
> index 30bf6df4ebc5..b9542ef36b29 100644
> --- a/drivers/net/ethernet/google/gve/gve_main.c
> +++ b/drivers/net/ethernet/google/gve/gve_main.c
> @@ -2398,65 +2398,32 @@ static const struct xdp_metadata_ops gve_xdp_meta=
data_ops =3D {
>         .xmo_rx_timestamp       =3D gve_xdp_rx_timestamp,
>  };
>
> -static int gve_init_priv(struct gve_priv *priv, bool skip_describe_devic=
e)
> +static int gve_set_num_ntfy_blks(struct gve_priv *priv)
>  {
>         int num_ntfy;
> -       int err;
> -
> -       /* Set up the adminq */
> -       err =3D gve_adminq_alloc(&priv->pdev->dev, priv);
> -       if (err) {
> -               dev_err(&priv->pdev->dev,
> -                       "Failed to alloc admin queue: err=3D%d\n", err);
> -               return err;
> -       }
> -
> -       err =3D gve_verify_driver_compatibility(priv);
> -       if (err) {
> -               dev_err(&priv->pdev->dev,
> -                       "Could not verify driver compatibility: err=3D%d\=
n", err);
> -               goto err;
> -       }
> -
> -       priv->num_registered_pages =3D 0;
> -
> -       if (skip_describe_device)
> -               goto setup_device;
>
> -       priv->queue_format =3D GVE_QUEUE_FORMAT_UNSPECIFIED;
> -       /* Get the initial information we need from the device */
> -       err =3D gve_adminq_describe_device(priv);
> -       if (err) {
> -               dev_err(&priv->pdev->dev,
> -                       "Could not get device information: err=3D%d\n", e=
rr);
> -               goto err;
> -       }
> -       priv->dev->mtu =3D priv->dev->max_mtu;
>         num_ntfy =3D pci_msix_vec_count(priv->pdev);
>         if (num_ntfy <=3D 0) {
>                 dev_err(&priv->pdev->dev,
>                         "could not count MSI-x vectors: err=3D%d\n", num_=
ntfy);
> -               err =3D num_ntfy;
> -               goto err;
> +               return num_ntfy;
>         } else if (num_ntfy < GVE_MIN_MSIX) {
>                 dev_err(&priv->pdev->dev, "gve needs at least %d MSI-x ve=
ctors, but only has %d\n",
>                         GVE_MIN_MSIX, num_ntfy);
> -               err =3D -EINVAL;
> -               goto err;
> +               return -EINVAL;
>         }
>
> -       /* Big TCP is only supported on DQO */
> -       if (!gve_is_gqi(priv))
> -               netif_set_tso_max_size(priv->dev, GVE_DQO_TX_MAX);
> -
> -       priv->rx_copybreak =3D GVE_DEFAULT_RX_COPYBREAK;
>         /* gvnic has one Notification Block per MSI-x vector, except for =
the
>          * management vector
>          */
>         priv->num_ntfy_blks =3D (num_ntfy - 1) & ~0x1;
>         priv->mgmt_msix_idx =3D priv->num_ntfy_blks;
> -       priv->numa_node =3D dev_to_node(&priv->pdev->dev);
>
> +       return 0;
> +}
> +
> +static void gve_set_num_queues(struct gve_priv *priv)
> +{
>         priv->tx_cfg.max_queues =3D
>                 min_t(int, priv->tx_cfg.max_queues, priv->num_ntfy_blks /=
 2);
>         priv->rx_cfg.max_queues =3D
> @@ -2470,18 +2437,73 @@ static int gve_init_priv(struct gve_priv *priv, b=
ool skip_describe_device)
>                 priv->rx_cfg.num_queues =3D min_t(int, priv->default_num_=
queues,
>                                                 priv->rx_cfg.num_queues);
>         }
> -       priv->tx_cfg.num_xdp_queues =3D 0;
>
>         dev_info(&priv->pdev->dev, "TX queues %d, RX queues %d\n",
>                  priv->tx_cfg.num_queues, priv->rx_cfg.num_queues);
>         dev_info(&priv->pdev->dev, "Max TX queues %d, Max RX queues %d\n"=
,
>                  priv->tx_cfg.max_queues, priv->rx_cfg.max_queues);
> +}
> +
> +static int gve_init_priv(struct gve_priv *priv, bool skip_describe_devic=
e)
> +{
> +       int err;
> +
> +       /* Set up the adminq */
> +       err =3D gve_adminq_alloc(&priv->pdev->dev, priv);
> +       if (err) {
> +               dev_err(&priv->pdev->dev,
> +                       "Failed to alloc admin queue: err=3D%d\n", err);
> +               return err;
> +       }
> +
> +       priv->num_registered_pages =3D 0;
> +
> +       if (skip_describe_device)
> +               goto setup_device;
> +
> +       err =3D gve_verify_driver_compatibility(priv);
> +       if (err) {
> +               dev_err(&priv->pdev->dev,
> +                       "Could not verify driver compatibility: err=3D%d\=
n", err);
> +               goto err;
> +       }

Addressing Sashiko's report:
https://sashiko.dev/#/patchset/20260602235900.3050782-1-hramamurthy%40googl=
e.com

"Does moving this driver compatibility check below the early-exit bypass th=
e
critical capability handshake during reset recovery?"

Yes, this needs to also be called in the reset path. Will fix in v3.


> +
> +       /* Get the initial information we need from the device */
> +       priv->queue_format =3D GVE_QUEUE_FORMAT_UNSPECIFIED;
> +       err =3D gve_adminq_describe_device(priv);
> +       if (err) {
> +               dev_err(&priv->pdev->dev,
> +                       "Could not get device information: err=3D%d\n", e=
rr);
> +               goto err;
> +       }
> +
> +       err =3D gve_set_num_ntfy_blks(priv);
> +       if (err) {
> +               dev_err(&priv->pdev->dev,
> +                       "Could not setup notify blocks: err=3D%d\n", err)=
;
> +               goto err;
> +       }
> +
> +       gve_set_num_queues(priv);
> +
> +       if (gve_is_dqo(priv)) {
> +               /* DQO supports HW-GRO and UDP_GSO */
> +               u64 additional_features =3D NETIF_F_GRO_HW | NETIF_F_GSO_=
UDP_L4;
> +
> +               priv->dev->hw_features |=3D additional_features;
> +               priv->dev->features |=3D additional_features;
>
> -       if (!gve_is_gqi(priv)) {
>                 priv->tx_coalesce_usecs =3D GVE_TX_IRQ_RATELIMIT_US_DQO;
>                 priv->rx_coalesce_usecs =3D GVE_RX_IRQ_RATELIMIT_US_DQO;
> +
> +               /* Big TCP is only supported on DQO */
> +               netif_set_tso_max_size(priv->dev, GVE_DQO_TX_MAX);
>         }
>
> +       priv->dev->mtu =3D priv->dev->max_mtu;
> +       priv->numa_node =3D dev_to_node(&priv->pdev->dev);
> +       priv->tx_cfg.num_xdp_queues =3D 0;
> +       priv->rx_copybreak =3D GVE_DEFAULT_RX_COPYBREAK;
>         priv->ts_config.tx_type =3D HWTSTAMP_TX_OFF;
>         priv->ts_config.rx_filter =3D HWTSTAMP_FILTER_NONE;
>
> --
> 2.54.0.1013.g208068f2d8-goog
>
