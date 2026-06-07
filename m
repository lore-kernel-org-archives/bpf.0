Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 297B1332637
	for <bpf@vger.kernel.org>; Sun,  7 Jun 2026 22:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780871962; cv=pass; b=Nv/4DhL8tsvmResJjme3Nurc4LHJafC3+1ogu0jph5DvHalBdB0oELlNUboiSbShtf1ZuJEaBXtIq9qNbhLErWOPCJYnYCYpD/OVd/p7L1SPhuIA+KwkGXX3SALmJJDl0gOA2HQ9hL6qKHKC8LFvrJTsBZPEGzrPM24/nY20C1E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780871962; c=relaxed/simple;
	bh=+4mYuEEkjpSNx57Rsctj9s4xcox12ds3O2xGUt/EI7o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iexuN9LWdwKntCZn3968ONn4Y9AR6l/D/jNBNyPeDot1FbyGnqGqL+jaUsk9tm6pRAsL6K7+w1PsT66De63F4LCATGpxtiLvDkfiWqTNfyfCTC0d1DXNxYBlblmalqx/HFZ8C1W8qovme+p2Zj2WsBrrKo4/fOr54k5juGNPqUs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jqqeFzbV; arc=pass smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jqqeFzbV"
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-3967620ceabso35934251fa.0
        for <bpf@vger.kernel.org>; Sun, 07 Jun 2026 15:39:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780871959; cv=none;
        d=google.com; s=arc-20240605;
        b=kHY2khrzAwRacysv0FLWIpYMaiELKEkUqcV6bJ47ewb93sLPYQ2BwZoA7/EBCdRVke
         YFC8Rtj6kHqqXVoK+FNJXuZWHdWsHZ/75FmSX2JX9EH6634Uf5XIcIMkhH98Va0yS+Kk
         ZHL+6ip+94lwbHV9uQxJZmjFS8JwmEU3lMzFjuEiCy3s+swyDEwOu/7pWg3vYpLa/zAe
         rWDNu3moV/s8H2PXHUuHwEHVSO7Qmfj07sLGz0G5jIFwdCSJlc/0O6D3mnSAo3HYseCY
         2oI8OhKnBSP16kEpw7noPAUdu/ZFofsQE99KjnVAOE24BZMubpvFZG6++tqfx36os65G
         1oSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=qEabNRu6O8V8GUgPf9A0UcDW6n2grWo6MuT1e8VBwSo=;
        fh=F7fnsUODBanozFpCTv+7ru516vLaX9ddCbIbIjkj8vs=;
        b=B6YJBPPrF53NnQaOmfdiDLnt2xeUMv8FFLyZegGrjgKHznVn2vwyIujT/c7X9L22Ay
         H3MVwCH1tuMXn8m6gJ+GC/7QovoNYPzNvn+Miaa3Nlp1wmO/HIahAKJrJgh5dZ3kiH8U
         UakHHXNILoDHOTWfOhrnSDi7jv9Ec7qpzwCl376z+IyKZLj0QyRRGGOApK/Rst8an3Qd
         u5JTzYJvHSczm0R6BLCjYmp2i13tz7qA9wk6B1B7hILFhR4Egp5v1vMCkWEJ2eQxV7D8
         Dix9cQgMVDdyfJFAQTKVEOnXX7pRB4nKSGrSztrDzcKAP66A70dm5EGhnWaQc6iccgo9
         c32A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780871959; x=1781476759; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qEabNRu6O8V8GUgPf9A0UcDW6n2grWo6MuT1e8VBwSo=;
        b=jqqeFzbVUFDB5+sHNIx65aXlnVIDx8cstAD1PVHTx2HklgcbiXUvi3AAzMI9vaojqi
         jjsLQY3ySGNKmfjpShPn0Subu5owGAK44OZowh8ECKAmlumKLjTe101pY7Y1WnIVKqBi
         Nu6S5Xni3yxh0ReILMJCgHrWhFppqbqPWscEdIfFJB2U34mEtYJtblTMB5xhV3H+J3nt
         jKmr5oRSz+L0Qjcl1L7GByeYbftVAPau512WezRkf8WC/PcKp3rMeOv5IneBVm/M7Gzv
         E7ikNPLVJp/K1QqAMmwydRjWI2ye9aC/hXlkABmHOu2BKq8xKCREOicy56yLWgKkv7uw
         XhQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780871959; x=1781476759;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qEabNRu6O8V8GUgPf9A0UcDW6n2grWo6MuT1e8VBwSo=;
        b=WR7qmXdKQ98e18YM/JQlh3QjVqpfAso+Ve3Uw/ck8xeehlzW+gKvLv2I3TN2yJ3dv/
         oiZPJjBIOnOkOZbiHOJmwRswpcY22l/r30PTe8Swcb5Q+m+qn3gTKUI1BWbjJMoZ1SHw
         brreiH3cYjbBD/cL3DK0MnN/j1PHI9lKAuGZ8yJ/WkuaSWzptsko1Lc7RAOdZylCD754
         lfB9cQXnw/qmLSgM27MBM7ror+fF3UqTykVSjyzRZGZR//kqrnHpx4uxbIvQmQYJYg1Z
         QqtnN1ybarf7sx7l4EJl8xiJaYCJ8wvqhBFqhfAw7IRdbj8tvMAwR2L9zrAE2WCPAPKR
         MVGw==
X-Forwarded-Encrypted: i=1; AFNElJ/81NYbJ1ZvroyVImEugfuKAN+a79iieYalWw4jxH6SlRyZQ9gSAEYAD3P4ZW0c13dsaJA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUDtrw2S5uD8giuZHtQTThQnByrbwcxEqZLYPY+LjhYF4hbcBM
	pGyzohVHW1DKDjmEyA0YwAhg/RydqPvQNAziHU9GlFSZDPtC7o4lfu7Mk7EXh+M1pF1SuwhPz6B
	BTWJeBxTrEl00iyvyKmNedO6hU77H2Jz3YkvgZHaP
X-Gm-Gg: Acq92OE2rsud7NC3Y5lTZ+hybYRDRI6t3uyt6jwpcUDA6124k93XwJMXNRE+7I2sUwb
	LygJY2xbBceKkCi5aZif9dldVMHQDH0Rmc2/+Nv2su5LPFu+4zrUL6535Yh+SBlvkV33Z+avwvn
	COX/2WzFZvpUpHq+ZjxM8c7baB9xLgrDnTYDP/VRmRapSIPIkFsj6ZpzjM70KWcgk0C8+V3EIHK
	cdzeeMylcE3k/LboUdb/JoKRtC3iYeGYm37fJXrn/Ev5ejalVaIt1vASJVB/7HUnqUVgauIj0VI
	O8TsDSSlOz3714zB8TuDc6rJfJiLpVkaCl/5J2oAXsyPuPV8Ibf3EaAe78v/nA==
X-Received: by 2002:a2e:a9a1:0:b0:396:a826:a278 with SMTP id
 38308e7fff4ca-396d0975cfamr35123311fa.19.1780871959031; Sun, 07 Jun 2026
 15:39:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260602235900.3050782-1-hramamurthy@google.com> <20260602235900.3050782-14-hramamurthy@google.com>
In-Reply-To: <20260602235900.3050782-14-hramamurthy@google.com>
From: Joshua Washington <joshwash@google.com>
Date: Sun, 7 Jun 2026 15:39:06 -0700
X-Gm-Features: AVVi8CcMiPI765Ff_RGoQb-Kf01bLpzY3qJ3FGUiOV6UbzlpFmpvBmvXzg6zsAg
Message-ID: <CALuQH+XHrmb-2zjVagWi=+gSowvTC67CSU09XMPwhtMSVszZjw@mail.gmail.com>
Subject: Re: [PATCH net-next v2 13/15] gve: setup and teardown management interrupts
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
> Introduce control ops to setup/teardown control plane IRQs. Admin
> queue-specific functionality is moved to admin queue files.
>
> Reviewed-by: Willem de Bruijn <willemb@google.com>
> Reviewed-by: Jordan Rhee <jordanrhee@google.com>
> Signed-off-by: Joshua Washington <joshwash@google.com>
> Signed-off-by: Harshitha Ramamurthy <hramamurthy@google.com>
> ---
>  drivers/net/ethernet/google/gve/gve.h        |  4 +++
>  drivers/net/ethernet/google/gve/gve_adminq.c | 32 ++++++++++++++++++++
>  drivers/net/ethernet/google/gve/gve_adminq.h |  2 ++
>  drivers/net/ethernet/google/gve/gve_main.c   | 28 ++++++-----------
>  4 files changed, 47 insertions(+), 19 deletions(-)
>
> diff --git a/drivers/net/ethernet/google/gve/gve.h b/drivers/net/ethernet=
/google/gve/gve.h
> index 6db5fbc0b321..b2e578b3d450 100644
> --- a/drivers/net/ethernet/google/gve/gve.h
> +++ b/drivers/net/ethernet/google/gve/gve.h
> @@ -835,6 +835,8 @@ struct gve_device_info {
>   *                     initialization.
>   * @request_db_info: Request and store doorbell information into @priv
>   * @free_db_resources: Free DMA memory holding doorbell info (AdminQ onl=
y)
> + * @setup_mgmt_irq: Setup control plane IRQ
> + * @teardown_mgmt_irq: Teardown control plane IRQ
>   * @get_ptype_map: Learn packet type map from device and store it in @pr=
iv
>   * @configure_rss: Set up default RSS configuration
>   * @setup_stats_report: Set up DMA region for stats report (AdminQ only)
> @@ -847,6 +849,8 @@ struct gve_ctrl_ops {
>         int (*set_num_ntfy_blks)(struct gve_priv *priv);
>         int (*request_db_info)(struct gve_priv *priv);
>         void (*free_db_resources)(struct gve_priv *priv);
> +       int (*setup_mgmt_irq)(struct gve_priv *priv);
> +       void (*teardown_mgmt_irq)(struct gve_priv *priv);
>         int (*get_ptype_map)(struct gve_priv *priv);
>         int (*configure_rss)(struct gve_priv *priv,
>                              struct ethtool_rxfh_param *param);
> diff --git a/drivers/net/ethernet/google/gve/gve_adminq.c b/drivers/net/e=
thernet/google/gve/gve_adminq.c
> index 259dcd617216..5dc5c63cee32 100644
> --- a/drivers/net/ethernet/google/gve/gve_adminq.c
> +++ b/drivers/net/ethernet/google/gve/gve_adminq.c
> @@ -1790,3 +1790,35 @@ void gve_adminq_free_db_resources(struct gve_priv =
*priv)
>         priv->irq_db_indices =3D NULL;
>         gve_free_counter_array(priv);
>  }
> +
> +static irqreturn_t gve_mgmnt_intr(int irq, void *arg)
> +{
> +       struct gve_priv *priv =3D arg;
> +
> +       queue_work(priv->gve_wq, &priv->service_task);
> +       return IRQ_HANDLED;
> +}
> +
> +int gve_adminq_setup_mgmt_irq(struct gve_priv *priv)
> +{
> +       int err;
> +
> +       snprintf(priv->mgmt_msix_name, sizeof(priv->mgmt_msix_name),
> +                "gve-mgmnt@pci:%s", pci_name(priv->pdev));
> +       err =3D request_irq(priv->msix_vectors[priv->mgmt_msix_idx].vecto=
r,
> +                         gve_mgmnt_intr, 0, priv->mgmt_msix_name, priv);
> +       if (err)
> +               return err;
> +
> +       priv->mgmt_irq_requested =3D true;
> +
> +       return 0;
> +}
> +
> +void gve_adminq_teardown_mgmt_irq(struct gve_priv *priv)
> +{
> +       if (priv->mgmt_irq_requested) {
> +               free_irq(priv->msix_vectors[priv->mgmt_msix_idx].vector, =
priv);
> +               priv->mgmt_irq_requested =3D false;
> +       }
> +}
> diff --git a/drivers/net/ethernet/google/gve/gve_adminq.h b/drivers/net/e=
thernet/google/gve/gve_adminq.h
> index 985b1aefea6e..ff656fb4f113 100644
> --- a/drivers/net/ethernet/google/gve/gve_adminq.h
> +++ b/drivers/net/ethernet/google/gve/gve_adminq.h
> @@ -659,5 +659,7 @@ int gve_adminq_set_num_ntfy_blks(struct gve_priv *pri=
v);
>  void gve_adminq_set_num_queues(struct gve_priv *priv);
>  int gve_adminq_request_db_info(struct gve_priv *priv);
>  void gve_adminq_free_db_resources(struct gve_priv *priv);
> +int gve_adminq_setup_mgmt_irq(struct gve_priv *priv);
> +void gve_adminq_teardown_mgmt_irq(struct gve_priv *priv);
>
>  #endif /* _GVE_ADMINQ_H */
> diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/eth=
ernet/google/gve/gve_main.c
> index 55f48aee125e..9d00093826e3 100644
> --- a/drivers/net/ethernet/google/gve/gve_main.c
> +++ b/drivers/net/ethernet/google/gve/gve_main.c
> @@ -267,14 +267,6 @@ static void gve_free_stats_report(struct gve_priv *p=
riv)
>         priv->stats_report =3D NULL;
>  }

Sashiko says:
This is a pre-existing issue, but does this function fail to cancel
the stats_report_task?

This issue predates this patch series; will have to introduce a net
patch to fix.

>
> -static irqreturn_t gve_mgmnt_intr(int irq, void *arg)
> -{
> -       struct gve_priv *priv =3D arg;
> -
> -       queue_work(priv->gve_wq, &priv->service_task);
> -       return IRQ_HANDLED;
> -}
> -
>  static irqreturn_t gve_intr(int irq, void *arg)
>  {
>         struct gve_notify_block *block =3D arg;
> @@ -499,6 +491,7 @@ static int gve_alloc_notify_blocks(struct gve_priv *p=
riv)
>
>  static void gve_teardown_notify_blocks(struct gve_priv *priv)
>  {
> +       const struct gve_ctrl_ops *ops =3D priv->ctrl_ops;
>         int i;
>
>         if (!priv->ntfy_blocks)
> @@ -518,29 +511,24 @@ static void gve_teardown_notify_blocks(struct gve_p=
riv *priv)
>                 block->irq_requested =3D false;
>         }
>
> -       if (priv->mgmt_irq_requested) {
> -               free_irq(priv->msix_vectors[priv->mgmt_msix_idx].vector, =
priv);
> -               priv->mgmt_irq_requested =3D false;
> -       }
> +       ops->teardown_mgmt_irq(priv);
>  }

Sashiko says:
This isn't a bug introduced by this patch, but is it possible for the
management IRQ to fire after the workqueue is destroyed?

Again, this will be fixed with changes in gve: Simplify Reset Logic.

>
>  static int gve_setup_notify_blocks(struct gve_priv *priv)
>  {
> +       const struct gve_ctrl_ops *ops =3D priv->ctrl_ops;
>         const struct cpumask *node_mask;
>         unsigned int cur_cpu;
>         int i;
>         int err;
>
> -       /* Setup Management Vector  - the last vector */
> -       snprintf(priv->mgmt_msix_name, sizeof(priv->mgmt_msix_name),
> -                "gve-mgmnt@pci:%s", pci_name(priv->pdev));
> -       err =3D request_irq(priv->msix_vectors[priv->mgmt_msix_idx].vecto=
r,
> -                         gve_mgmnt_intr, 0, priv->mgmt_msix_name, priv);
> +       /* Setup Management Vector */
> +       err =3D ops->setup_mgmt_irq(priv);
>         if (err) {
> -               dev_err(&priv->pdev->dev, "Did not receive management vec=
tor.\n");
> +               dev_err(&priv->pdev->dev,
> +                       "Did not receive management vector.\n");
>                 return err;
>         }
> -       priv->mgmt_irq_requested =3D true;
>
>         node_mask =3D gve_get_node_mask(priv);
>         cur_cpu =3D cpumask_first(node_mask);
> @@ -2460,6 +2448,8 @@ static const struct gve_ctrl_ops gve_adminq_ops =3D=
 {
>         .configure_rss          =3D gve_adminq_configure_rss,
>         .request_db_info        =3D gve_adminq_request_db_info,
>         .free_db_resources      =3D gve_adminq_free_db_resources,
> +       .setup_mgmt_irq         =3D gve_adminq_setup_mgmt_irq,
> +       .teardown_mgmt_irq      =3D gve_adminq_teardown_mgmt_irq,
>  };
>
>  static int gve_init_priv(struct gve_priv *priv)
> --
> 2.54.0.1013.g208068f2d8-goog
>


--=20

Joshua Washington | Software Engineer | joshwash@google.com | (414) 366-442=
3
