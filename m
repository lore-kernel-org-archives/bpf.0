Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53D604DC55F
	for <bpf@vger.kernel.org>; Wed,  3 Jun 2026 23:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780531172; cv=none; b=T996XcBJ9wZ6gVvUXzhw3zQRz/tzGnJlS1S6Uvm3C/4rNWiZ2Y3UNK/Eqg7znmf8lEY+Cyq7I40P/6AfJnyTOVBxHSHr+yACA1Ai6s91/uIQE/AgPnenFEddQgOscT1J/pMYs8F2XOtpsLwxA8SC87XZA3BSxFxCc/vxphsIof4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780531172; c=relaxed/simple;
	bh=LKDL4uIxF/56QIbFytYPs+Ij6NeD8+T++Rd/RTWNulM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=IlSAxceI4ClKStYiOeXGGyZCXpb4vQg4gaPgGZQN45OjRdOBg8QaRXyqyyhWvDonOV3Udos3k9o7J85lyOlk9U9g6oSeEVZPnqG3eRNhOaRuPxYQSAu3qkmBldWU3eLgMX79FwiftEhJVBuhuPa7mqF9WxFxZu7k++GDxiD+O/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fubgAX8G; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fubgAX8G"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E4FE1F00899;
	Wed,  3 Jun 2026 23:59:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780531171;
	bh=tvZ+TAbm/GYdeQVqd0PeS22e7n43YrPW33dFVxAxBSo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fubgAX8GVIEDDq+7xZwFld7NSSj3rTF4y0NbgTqqb5MBVdf56p+aT1odOYSQjrbAy
	 gCWPyyCkYMb20DV2tn0fd7i3fHOa75OnuXa4Kh4CDaKG1hx41TDvSAad+/jPp0MI5i
	 61fMhQEMVeDDpXpGxPX0+XfVLQfswcT/lpgEgORE7k0hNL46n9om/bhPDiPwrtbqof
	 KaAkL0Sr9g+d23oQOCpJvlfJUOJh/1vGdQ6IslSGkEXHK8T/lJuPLR3J0LSuXItvZ7
	 PeEZNJjuMBmfPO65GAWLHS+Flbf8iPEp/f/kX7WFVKjoeDdwG1Q+fS4829Bb8DfXlJ
	 cZUUtnDKZbsbg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v2 12/15] gve: introduce new methods to handle
 IRQ doorbells
Reply-To: sashiko-reviews@lists.linux.dev
To: "Harshitha Ramamurthy" <hramamurthy@google.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260602235900.3050782-13-hramamurthy@google.com>
References: <20260602235900.3050782-13-hramamurthy@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 03 Jun 2026 23:59:30 +0000
Message-Id: <20260603235931.1E4FE1F00899@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] DMA memory for irq_db_indices and counter_array is freed before th=
e hardware is guaranteed to be stopped, allowing the hardware to corrupt ke=
rnel memory if admin queue commands time out or fail.
--

commit e39d080d71706978b42ac097e883fbae5157b9ec
Author: Joshua Washington <joshwash@google.com>

gve: introduce new methods to handle IRQ doorbells

This commit introduces request_db_info and free_db_resources to
struct gve_ctrl_ops to encapsulate the configuration of device resources
(counter arrays and IRQ doorbell indices). It also manages GQ ring counters
in request_db_info.

> diff --git a/drivers/net/ethernet/google/gve/gve_adminq.c b/drivers/net/e=
thernet/google/gve/gve_adminq.c
> index d814108deeefe..259dcd617216c 100644
> --- a/drivers/net/ethernet/google/gve/gve_adminq.c
> +++ b/drivers/net/ethernet/google/gve/gve_adminq.c
[ ... ]
> @@ -1719,3 +1719,74 @@ void gve_adminq_set_num_queues(struct gve_priv *pr=
iv)
[ ... ]
> +int gve_adminq_request_db_info(struct gve_priv *priv)
> +{
[ ... ]
> +	err =3D gve_adminq_configure_device_resources(priv,
> +						    priv->counter_array_bus,
> +						    priv->num_event_counters,
> +						    priv->irq_db_indices_bus,
> +						    priv->num_ntfy_blks);
> +	if (unlikely(err)) {
> +		dev_err(&priv->pdev->dev,
> +			"could not setup device_resources: err=3D%d\n", err);
> +		err =3D -ENXIO;
> +		goto abort_with_irq_db_indices;
> +	}
> +
> +	for (i =3D 0; i < priv->num_ntfy_blks; i++)
> +		priv->ntfy_blocks[i].irq_db_index =3D
> +			&priv->irq_db_indices[i].index;
> +	return 0;
> +
> +abort_with_irq_db_indices:
> +	dma_free_coherent(&priv->pdev->dev, priv->num_ntfy_blks *
> +			  sizeof(*priv->irq_db_indices),
> +			  priv->irq_db_indices, priv->irq_db_indices_bus);
> +	priv->irq_db_indices =3D NULL;
> +abort_with_counter_array:
> +	gve_free_counter_array(priv);
> +	return err;
> +}

[Severity: High]
Does this error path introduce a use-after-free window?=20

If the configure command in gve_adminq_configure_device_resources() times
out (e.g. returns -ETIME), the hardware might still be running and attempti=
ng
to access the memory.

Since we immediately free the DMA memory via dma_free_coherent() and
gve_free_counter_array() before the hardware is guaranteed to be stopped, c=
an
the hardware overwrite reallocated kernel memory?

> +
> +void gve_adminq_free_db_resources(struct gve_priv *priv)
> +{
> +	int err;
> +
> +	/* Log error in deconfigure device, but don't fail. This is only ever
> +	 * called as a reset is about to be triggered, so it would be redundant
> +	 * to trigger a reset.
> +	 */
> +	err =3D gve_adminq_deconfigure_device_resources(priv);
> +	if (err)
> +		dev_err(&priv->pdev->dev,
> +			"Could not deconfigure device resources: err=3D%d\n",
> +			err);
> +
> +	dma_free_coherent(&priv->pdev->dev, priv->num_ntfy_blks *
> +			  sizeof(*priv->irq_db_indices),
> +			  priv->irq_db_indices, priv->irq_db_indices_bus);
> +	priv->irq_db_indices =3D NULL;
> +	gve_free_counter_array(priv);
> +}

[Severity: High]
Could freeing the DMA memory here cause memory corruption?=20

In an earlier patch in this series ('gve: simplify reset logic'), the teard=
own
logic was explicitly fixed to delay freeing shared resources until after
gve_adminq_free() triggers a device reset.

However, gve_teardown_device() executes gve_teardown_control_plane_resource=
s()
(which now calls ops->free_db_resources()) before gve_adminq_free():

drivers/net/ethernet/google/gve/gve_main.c:gve_teardown_device() {
	...
	gve_teardown_notify_blocks(priv);
	gve_teardown_control_plane_resources(priv);
	gve_adminq_free(priv);
	...
}

If the deconfigure command in gve_adminq_deconfigure_device_resources() tim=
es
out or fails, the active hardware might continue writing to the freed DMA
memory since the device hasn't been reset yet.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260602235900.3050=
782-1-hramamurthy@google.com?part=3D12
