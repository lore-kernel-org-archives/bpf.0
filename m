Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8071A33AD91
	for <bpf@vger.kernel.org>; Sun,  7 Jun 2026 22:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780871392; cv=pass; b=IPToHzaGRJdQqd3sYXFCozZ0meWAWhUuD787f/jZYpmmokE823LJ4WCcgcAsGsehaTIyD6qz2SPOydvlYdjXR0yIA64HcfUOQg6PHVV9RyGEY7tRtWaGu6wLTRactSW/PdQygqpTrZm4FLBZ7R/oJO9NPbbye6NGN4A/lvVjsrQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780871392; c=relaxed/simple;
	bh=bwU2wJi6+s4So0DKvsJXr/g5IEZ/zUTklWmD227eNa4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Qob8z6C6CXWyf5dAIS2fMuALLRuiqmhc/qjCFf9SHOoY8aZgD03P4FPz+JgnI6hlC8wXVZ00ruhwWWgJbrR9XdM5svxGBUhZracHP9AEl99F2L6GNXqqwGe4WD4X8Vmn2ykIqynTBqOjFtqDEtIRTO2S6uRfxkBDhZRJxC/cWro=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lmRaanGO; arc=pass smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lmRaanGO"
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-39677aed4d3so32450631fa.2
        for <bpf@vger.kernel.org>; Sun, 07 Jun 2026 15:29:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780871389; cv=none;
        d=google.com; s=arc-20240605;
        b=RbUu+42MLLk7jM19FchT5sGsFdzzyPi/cDSrZ6NCsdTcd0HpCrY6aMaPdx5BmM3dG0
         pd5+R5lrBMKfAwopVvIaYNtmLHkSmqTmHSjatt61Pv45ZDp78lWWNzF35a0XOWK9OSeV
         hTkT8rKTv4zJKw8oFCpNYJ7ORisi8EWBdTMYeH0XA20QSwbIA/2HU7PLpWWZF1p2A1mI
         zjOa68P/gkv2EEnL8iXVwNZRNOfpMnKXNEamX6ObFBOpH+pe2x9OKlxyd7hfoPnr1HWA
         Rc1Rr2KRQtqr3QoiWvSn8OUNXf6bh9LnYL+I/E1mD1z+wfoC+m3zuxTXjOPMCGxgPHSv
         /aIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2iQO6jFNS2s7fAuLZXtMklLeueanAFJEP8trKvyAlT4=;
        fh=wXY54U4yn14OE/q9cDa3ftFBZlYPYHWVdfexrpLYy+k=;
        b=CmRCdflj4hh3S77PXwURRFsI83U45ChU5Q0P7xmMevw3Rhkq8wtZi6D4T2JYgMaQB5
         zLYww3Nb9yyJ6mURqU9OLZciC3SpPzpXJrW9BYdApDNGYB8q05WRDOLr0FG1JeLOma0J
         lc6kz5Kpg60xPtbC9WOSP7goKSAL4EA2QrU700WgaXLuBCSynunm1673E5Kc5eVU1y39
         XP1pTIoh4D1RsRwCYQVKNyJ/SQIXw5GQJmu3TTtfbtYJgWI7fEUBcSM1LSTTbaC+PrcH
         oBoODFsWa2QJPLWU+A/DzFpz4hpeli6nTDVGxXxJBDqL0pAcXVz527U3UjUQM9Tq6TcM
         UYbQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780871389; x=1781476189; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2iQO6jFNS2s7fAuLZXtMklLeueanAFJEP8trKvyAlT4=;
        b=lmRaanGO6gKfgs314zfwJDi4eE37c1WY+D20QFNy/mz26WRyCq9e0Qi65aMmZ7Ezxy
         3TcaWIsbH41PoKwVwOfdxh7Jf1CpT/UPGI2h3aq2nLCh4FoV7CqmPtcAP2H+MtdObM6E
         4QHxZfY8iBOhENoicLRcq6jmoxApnS1KqZKwZALilcI1S6XZCtOHSYZqJMZ3UoQCcAee
         eyt1vnbNC+sToHBpmgwBOCbIM1yvNEO8X6qZ2NTI1r1HavGG0sTrsrO3TYycyJprWCSs
         ebpcdnw4vdWs5CdnMMi+PrZNVgdWBoY9rBkmeenoBPfOFbFKyle7M9Vs8IpRxgmFaIcu
         XoOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780871389; x=1781476189;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2iQO6jFNS2s7fAuLZXtMklLeueanAFJEP8trKvyAlT4=;
        b=mRDNdGXAiiYRmmdRTwmJTkwOVLk1EG6ybjvDisxv3Zo/uKTAwpU6gZ2F9zd3wT2nnf
         Qd7qG9dlPmdWzuEDStft7rhfBRN5T/uT2hiPg2WPqr31uffeVLi1NT+KsBp6uzzT5eUP
         vX0W5tB+hXks31wnoY4SgfqB4VnsmdYtMD97Bzzqowq1zxsVHBdK99R+HcHFN4G6Txmv
         MA98LxVqYnbjYcCRfjwM4IBIXe6ojhJlEWe5s5cvd1crPHyp5lIYiPLfq5ixXrKMhq8d
         iNgVoLi/ew/pklIkvzIvaiEc5DasjllJW6fP1K5NBden6VURJQpjmncDbaUzABr1YoGH
         HO8g==
X-Forwarded-Encrypted: i=1; AFNElJ/nXGR6hKWhl2YOPmaq2hc3aws63GxyTJqI/mYCXLMB8DV90LaE5BpIFLIq7YaeaWqiatE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOCT7+a6HC/MTfIUuGTg1GdanMvLSntBdpF1pGPJYv4Biaz85f
	qbFi024klBORO40Ln05DQrX4gcLzNCxnWt5QmUMdkl9zdUo587c/9zW4ZQ8Gu1Oawd/3wzlfQ1S
	bK1W2UbYoYZZSdFK96Udc/0DO1GDIOQ2h/SvUsQYs
X-Gm-Gg: Acq92OFLIJ/wl6/t6/TQDB/3hcOefktRUddq8tKCr3Hk8Q8kY4y0VUMu6mTm8iYvA9E
	TgwnrWX7r5YMuz50I8UcD+p8veFizAFL0Lse62Miym3Hw+mWkUMx7L23lJj2cOKelNi0lYp4dQE
	hYhZGsbkkNBzgH+DnfvEPGY57SJvmPFMcOvnZPCaNx1NOBVhK/9Ex1ZsFc7M/kO89Cs/c/9YjS2
	SKho3ISj/YaTnGkqJPu4hidqZJCOwa8z/xYDdb4epjc6q2yH+zZd/XajAoffZECfdniAVfVD8nh
	zGwBtWKmrkEodpvkB8pP/Yo7iUYj+4qDXkDvlB6cdxzLU79cXPU=
X-Received: by 2002:a2e:bc87:0:b0:396:8029:e2e5 with SMTP id
 38308e7fff4ca-396d0a29fe6mr33570011fa.18.1780871388353; Sun, 07 Jun 2026
 15:29:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260602235900.3050782-1-hramamurthy@google.com> <20260602235900.3050782-12-hramamurthy@google.com>
In-Reply-To: <20260602235900.3050782-12-hramamurthy@google.com>
From: Joshua Washington <joshwash@google.com>
Date: Sun, 7 Jun 2026 15:29:36 -0700
X-Gm-Features: AVVi8CcnDHB_jYDkuIWCgxnY-uGZ_dRpZ-qj0F5MZzE6jNQTIx2gxTcbBZVRQqU
Message-ID: <CALuQH+W=ZeKk9Z55Hd6FdhG3+uyad1T3y+ZKXbe+oxpOO2u6pQ@mail.gmail.com>
Subject: Re: [PATCH net-next v2 11/15] gve: split up notify block allocation
 and setup paths
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
> Before this patch, notify block allocation and setup occurred in the same
> method. This all occurred before gve_adminq_configure_device_resources,
> which populates the irq_db_indicies array, a DMA region with BAR offsets
> for MSI-X vectors.
>
> The coming mailbox mode will require notify blocks to be set up only
> after receiving the IRQ doorbell offsets, as the request does not work
> with a supplied DMA buffer in the way that admin queue mode does. The
> intended flow in that case would be:
>
> 1) allocate notify blocks
> 2) request doorbell information
> 3) set up MSI-X vectors based on doorbell info
>
> This ordering also works for admin queue mode, so it will be updated to
> match.
>
> Reviewed-by: Willem de Bruijn <willemb@google.com>
> Reviewed-by: Jordan Rhee <jordanrhee@google.com>
> Signed-off-by: Joshua Washington <joshwash@google.com>
> Signed-off-by: Harshitha Ramamurthy <hramamurthy@google.com>
> ---
>  drivers/net/ethernet/google/gve/gve.h      |   2 +
>  drivers/net/ethernet/google/gve/gve_main.c | 158 ++++++++++++---------
>  2 files changed, 89 insertions(+), 71 deletions(-)
>
> diff --git a/drivers/net/ethernet/google/gve/gve.h b/drivers/net/ethernet=
/google/gve/gve.h
> index 939b245ed562..e173c14bdc08 100644
> --- a/drivers/net/ethernet/google/gve/gve.h
> +++ b/drivers/net/ethernet/google/gve/gve.h
> @@ -673,6 +673,7 @@ struct gve_notify_block {
>         struct gve_tx_ring *tx; /* tx rings on this block */
>         struct gve_rx_ring *rx; /* rx rings on this block */
>         u32 irq;
> +       bool irq_requested;
>  };
>
>  /* Tracks allowed and current rx queue settings */
> @@ -953,6 +954,7 @@ struct gve_priv {
>         u64 link_speed;
>         bool up_before_suspend; /* True if dev was up before suspend */
>
> +       bool mgmt_irq_requested;
>         struct gve_ptype_lut *ptype_lut_dqo;
>
>         /* Must be a power of two. */
> diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/eth=
ernet/google/gve/gve_main.c
> index 06df6d8ad429..98970508ae54 100644
> --- a/drivers/net/ethernet/google/gve/gve_main.c
> +++ b/drivers/net/ethernet/google/gve/gve_main.c
> @@ -425,6 +425,24 @@ int gve_napi_poll_dqo(struct napi_struct *napi, int =
budget)
>         return work_done;
>  }
>
> +static void gve_free_notify_blocks(struct gve_priv *priv)
> +{
> +       pci_disable_msix(priv->pdev);
> +       if (priv->irq_db_indices) {
> +               dma_free_coherent(&priv->pdev->dev,
> +                                 priv->num_ntfy_blks *
> +                                 sizeof(*priv->irq_db_indices),
> +                                 priv->irq_db_indices,
> +                                 priv->irq_db_indices_bus);
> +               priv->irq_db_indices =3D NULL;
> +       }
> +
> +       kvfree(priv->ntfy_blocks);
> +       priv->ntfy_blocks =3D NULL;
> +       kvfree(priv->msix_vectors);
> +       priv->msix_vectors =3D NULL;
> +}
> +
>  static const struct cpumask *gve_get_node_mask(struct gve_priv *priv)
>  {
>         if (priv->numa_node =3D=3D NUMA_NO_NODE)
> @@ -436,11 +454,9 @@ static const struct cpumask *gve_get_node_mask(struc=
t gve_priv *priv)
>  static int gve_alloc_notify_blocks(struct gve_priv *priv)
>  {
>         int num_vecs_requested =3D priv->num_ntfy_blks + 1;
> -       const struct cpumask *node_mask;
> -       unsigned int cur_cpu;
>         int vecs_enabled;
> -       int i, j;
>         int err;
> +       int i;
>
>         priv->msix_vectors =3D kvzalloc_objs(*priv->msix_vectors,
>                                            num_vecs_requested);
> @@ -454,7 +470,7 @@ static int gve_alloc_notify_blocks(struct gve_priv *p=
riv)
>                 dev_err(&priv->pdev->dev, "Could not enable min msix %d/%=
d\n",
>                         GVE_MIN_MSIX, vecs_enabled);
>                 err =3D vecs_enabled;
> -               goto abort_with_msix_vectors;
> +               goto abort;
>         }
>         if (vecs_enabled !=3D num_vecs_requested) {
>                 int new_num_ntfy_blks =3D (vecs_enabled - 1) & ~0x1;
> @@ -477,15 +493,6 @@ static int gve_alloc_notify_blocks(struct gve_priv *=
priv)
>                         priv->rx_cfg.num_queues =3D priv->rx_cfg.max_queu=
es;
>         }
>
> -       /* Setup Management Vector  - the last vector */
> -       snprintf(priv->mgmt_msix_name, sizeof(priv->mgmt_msix_name), "gve=
-mgmnt@pci:%s",
> -                pci_name(priv->pdev));
> -       err =3D request_irq(priv->msix_vectors[priv->mgmt_msix_idx].vecto=
r,
> -                         gve_mgmnt_intr, 0, priv->mgmt_msix_name, priv);
> -       if (err) {
> -               dev_err(&priv->pdev->dev, "Did not receive management vec=
tor.\n");
> -               goto abort_with_msix_enabled;
> -       }
>         priv->irq_db_indices =3D
>                 dma_alloc_coherent(&priv->pdev->dev,
>                                    priv->num_ntfy_blks *
> @@ -493,15 +500,65 @@ static int gve_alloc_notify_blocks(struct gve_priv =
*priv)
>                                    &priv->irq_db_indices_bus, GFP_KERNEL)=
;
>         if (!priv->irq_db_indices) {
>                 err =3D -ENOMEM;
> -               goto abort_with_mgmt_vector;
> +               goto abort;
>         }
>
>         priv->ntfy_blocks =3D kvzalloc(priv->num_ntfy_blks *
>                                      sizeof(*priv->ntfy_blocks), GFP_KERN=
EL);
>         if (!priv->ntfy_blocks) {
>                 err =3D -ENOMEM;
> -               goto abort_with_irq_db_indices;
> +               goto abort;
> +       }
> +       return 0;
> +
> +abort:
> +       gve_free_notify_blocks(priv);
> +       return err;
> +}
> +
> +static void gve_teardown_notify_blocks(struct gve_priv *priv)
> +{
> +       int i;
> +
> +       if (!priv->ntfy_blocks)
> +               return;
> +
> +       for (i =3D 0; i < priv->num_ntfy_blks; i++) {
> +               struct gve_notify_block *block =3D &priv->ntfy_blocks[i];
> +
> +               if (!block->irq_requested)
> +                       continue;
> +
> +               irq_set_affinity_hint(priv->msix_vectors[i].vector,
> +                                     NULL);
> +               free_irq(priv->msix_vectors[i].vector, block);
> +               block->irq =3D 0;
> +               block->irq_requested =3D false;
> +       }
> +
> +       if (priv->mgmt_irq_requested) {
> +               free_irq(priv->msix_vectors[priv->mgmt_msix_idx].vector, =
priv);
> +               priv->mgmt_irq_requested =3D false;
> +       }
> +}
> +
> +static int gve_setup_notify_blocks(struct gve_priv *priv)
> +{
> +       const struct cpumask *node_mask;
> +       unsigned int cur_cpu;
> +       int i;
> +       int err;
> +
> +       /* Setup Management Vector  - the last vector */
> +       snprintf(priv->mgmt_msix_name, sizeof(priv->mgmt_msix_name),
> +                "gve-mgmnt@pci:%s", pci_name(priv->pdev));
> +       err =3D request_irq(priv->msix_vectors[priv->mgmt_msix_idx].vecto=
r,
> +                         gve_mgmnt_intr, 0, priv->mgmt_msix_name, priv);
> +       if (err) {
> +               dev_err(&priv->pdev->dev, "Did not receive management vec=
tor.\n");
> +               return err;
>         }
> +       priv->mgmt_irq_requested =3D true;
>
>         /* Setup the other blocks - the first n-1 vectors */
>         node_mask =3D gve_get_node_mask(priv);
> @@ -519,9 +576,10 @@ static int gve_alloc_notify_blocks(struct gve_priv *=
priv)
>                 if (err) {
>                         dev_err(&priv->pdev->dev,
>                                 "Failed to receive msix vector %d\n", i);
> -                       goto abort_with_some_ntfy_blocks;
> +                       goto abort;
>                 }
>                 block->irq =3D priv->msix_vectors[msix_idx].vector;
> +               block->irq_requested =3D true;
>                 irq_set_affinity_and_hint(block->irq,
>                                           cpumask_of(cur_cpu));
>                 block->irq_db_index =3D &priv->irq_db_indices[i].index;
> @@ -535,61 +593,12 @@ static int gve_alloc_notify_blocks(struct gve_priv =
*priv)
>                         cur_cpu =3D cpumask_first(node_mask);
>         }
>         return 0;
> -abort_with_some_ntfy_blocks:
> -       for (j =3D 0; j < i; j++) {
> -               struct gve_notify_block *block =3D &priv->ntfy_blocks[j];
> -               int msix_idx =3D j;
>
> -               irq_set_affinity_hint(priv->msix_vectors[msix_idx].vector=
,
> -                                     NULL);
> -               free_irq(priv->msix_vectors[msix_idx].vector, block);
> -               block->irq =3D 0;
> -       }
> -       kvfree(priv->ntfy_blocks);
> -       priv->ntfy_blocks =3D NULL;
> -abort_with_irq_db_indices:
> -       dma_free_coherent(&priv->pdev->dev, priv->num_ntfy_blks *
> -                         sizeof(*priv->irq_db_indices),
> -                         priv->irq_db_indices, priv->irq_db_indices_bus)=
;
> -       priv->irq_db_indices =3D NULL;
> -abort_with_mgmt_vector:
> -       free_irq(priv->msix_vectors[priv->mgmt_msix_idx].vector, priv);
> -abort_with_msix_enabled:
> -       pci_disable_msix(priv->pdev);
> -abort_with_msix_vectors:
> -       kvfree(priv->msix_vectors);
> -       priv->msix_vectors =3D NULL;
> +abort:
> +       gve_teardown_notify_blocks(priv);
>         return err;
>  }
>
> -static void gve_free_notify_blocks(struct gve_priv *priv)
> -{
> -       int i;
> -
> -       if (!priv->msix_vectors)
> -               return;
> -
> -       /* Free the irqs */
> -       for (i =3D 0; i < priv->num_ntfy_blks; i++) {
> -               struct gve_notify_block *block =3D &priv->ntfy_blocks[i];
> -               int msix_idx =3D i;
> -
> -               irq_set_affinity_hint(priv->msix_vectors[msix_idx].vector=
,
> -                                     NULL);
> -               free_irq(priv->msix_vectors[msix_idx].vector, block);
> -               block->irq =3D 0;
> -       }
> -       free_irq(priv->msix_vectors[priv->mgmt_msix_idx].vector, priv);
> -       kvfree(priv->ntfy_blocks);
> -       priv->ntfy_blocks =3D NULL;
> -       dma_free_coherent(&priv->pdev->dev, priv->num_ntfy_blks *
> -                         sizeof(*priv->irq_db_indices),
> -                         priv->irq_db_indices, priv->irq_db_indices_bus)=
;
> -       priv->irq_db_indices =3D NULL;
> -       pci_disable_msix(priv->pdev);
> -       kvfree(priv->msix_vectors);
> -       priv->msix_vectors =3D NULL;
> -}
>
>  static void gve_free_control_plane_resources(struct gve_priv *priv)
>  {
> @@ -743,6 +752,7 @@ static void gve_teardown_control_plane_resources(stru=
ct gve_priv *priv)
>
>  static void gve_teardown_device(struct gve_priv *priv)
>  {
> +       gve_teardown_notify_blocks(priv);

Sashiko says:
In gve_remove(), the patch series reordered the teardown sequence to call
destroy_workqueue() before gve_teardown_device().
Because gve_teardown_device() (via gve_teardown_notify_blocks()) is what
calls free_irq() to release the management interrupt, the interrupt remains
active while and after the workqueue is destroyed.
If a management interrupt fires during this window, gve_mgmnt_intr() will
[queue the service task on the work queue].
Can this sequence trigger a use-after-free by enqueuing work on the destroy=
ed
workqueue?

This will be fixed by the disable_work() change in patch 9.


>         gve_teardown_control_plane_resources(priv);
>         gve_adminq_free(priv);
>         /*
> @@ -2463,13 +2473,16 @@ static int gve_setup_device(struct gve_priv *priv=
)
>
>         err =3D gve_alloc_control_plane_resources(priv);
>         if (err)
> -               goto err;
> +               return err;
> +
>         err =3D gve_setup_control_plane_resources(priv);
>         if (err)
> -               goto err;
> +               return err;
> +
> +       err =3D gve_setup_notify_blocks(priv);
> +       if (err)
> +               return err;
>         return 0;
> -err:
> -       return err;
>  }
>
>  static const struct gve_ctrl_ops gve_adminq_ops =3D {
> @@ -2591,6 +2604,9 @@ int gve_reset(struct gve_priv *priv, bool skip_queu=
e_setup)
>                 gve_unregister_qpls(priv);
>         }
>
> +       gve_teardown_notify_blocks(priv);
> +       gve_teardown_control_plane_resources(priv);
> +

Sashiko says:
...
The newly added gve_teardown_control_plane_resources(priv) call already
invokes gve_teardown_clock() internally when device_resources_ok is
set, so is the standalone gve_teardown_clock(priv) call further down
now redundant?

Will remove the redundant call.

>         /* Reset the device by releasing the AQ. Rings and other resource=
s
>          * within the NIC are implicitly destroyed if commands fail.
>          */
> --
> 2.54.0.1013.g208068f2d8-goog
>


--=20

Joshua Washington | Software Engineer | joshwash@google.com | (414) 366-442=
3
