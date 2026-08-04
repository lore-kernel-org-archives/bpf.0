Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 783B546DFE7
	for <bpf@vger.kernel.org>; Tue,  4 Aug 2026 18:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785869225; cv=none; b=r9zdUYzcfAdj0GGK94PL66VLa/FRIYie1eW/1vTEd1yXoBkL/xZagfgSiB+nGjTGVVORUIxJO0rlyq8nbzl3P+VmJcNiDB8cjZLptUK9qkMY4L/+9LVEo/GU4GHW/RlvaZnojPP17GIll/+eiCFwOBpzrYaLUotKHZlblqwV8/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785869225; c=relaxed/simple;
	bh=4TzE55tyn0av401NZCGB6IIERLmTE/RlIn5+r3dQH9U=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=JF4A0h+MWZc713Hmo2oUlUxGt8c5O29a+sKeHNS9rjncCDRWvN3whCE7VM34Y1TUdU6vIWELoZZt06NlFbSUoib1dp59W0brNClxXbij19ujNBQkG7EMuroDEUPYkK4up9o4XPZbQAzigB45wPvuhgAZBWJHWzv9Iyf/TcCVEIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N27f3Iq2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N27f3Iq2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 385851F00A3A;
	Tue,  4 Aug 2026 18:47:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785869224;
	bh=P0eL9HhfbmgunNNCnN0BwT92dRgM6vm9iw/KxIhkGvU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=N27f3Iq2MuOgv8seqL0r5QNVraGCq5A7ysVVPOHD1CCcprtwd0B7XIBT6wUDL2e97
	 hcCWS4Bwh0RPpep1qGzVfyWggMITZPDB4aNQ6VQxSIjwIdsD2Ut1bFbY08dJNbvLDn
	 imEQPMz2hfe2ar+kSV1daGgeT+S9jeuK3xMtMLo6TjJTwYVyeYmUiUgtKufStA7SlT
	 jI/JJZ7zF3d6zrUqcZ5RLOdBp6tIPEK0sxv4Lu9pgNKIBfAumE8yjrfFBp8uIZdVHk
	 32eDWxRS49hXwfdVLdwDv94xjiTgfFqiKhIjJuUKpPsvkZkUIUgmkrEaex7Y2c4wMK
	 6dHh/7WiBFNKg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v3 12/15] gve: introduce new methods to handle
 IRQ doorbells
Reply-To: sashiko-reviews@lists.linux.dev
To: "Harshitha Ramamurthy" <hramamurthy@google.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260803184630.3813311-13-hramamurthy@google.com>
References: <20260803184630.3813311-1-hramamurthy@google.com>
 <20260803184630.3813311-13-hramamurthy@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 04 Aug 2026 18:47:03 +0000
Message-Id: <20260804184704.385851F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Mismatch between commit message, code comments, and actual imple=
mentation for `free_db_resources`.
--

--- Patch [12]: [PATCH net-next v3 12/15] gve: introduce new methods to han=
dle IRQ doorbells ---
commit d17b52783c19c7cb12a008b8dab81756b1b45ee7
Author: Joshua Washington <joshwash@google.com>

gve: introduce new methods to handle IRQ doorbells

This commit introduces new methods to struct gve_ctrl_ops for configuring
device resources like counter arrays and IRQ doorbell indices. It shifts
doorbell management and GQ ring counter setup from notify_block methods
into these new callbacks.

>   - Similar to above, move free logic out of
>     gve_adminq_free_db_resources() and rename all introduced methods
>     from *free_db_resources to *release_db_resources to reflect the
>     behavioral change.

[Severity: Medium]
This isn't a bug, but the changelog states the methods were renamed to
*release_db_resources. The code still uses the name *free_db_resources.

> diff --git a/drivers/net/ethernet/google/gve/gve.h b/drivers/net/ethernet=
/google/gve/gve.h
> index 8766ea62baf17..f3cfc9d0cdec6 100644
> --- a/drivers/net/ethernet/google/gve/gve.h
> +++ b/drivers/net/ethernet/google/gve/gve.h
> @@ -836,6 +836,8 @@ struct gve_device_info {
>   *                  structures stored in @priv to be used during initial=
ization.
>   * @set_num_ntfy_blks: Sets no. of vectors into @priv to be used during
>   *                     initialization.
> + * @request_db_info: Request and store doorbell information into @priv
> + * @free_db_resources: Free DMA memory holding doorbell info (AdminQ onl=
y)

[Severity: Medium]
Is this comment still accurate? Since the logic to free DMA memory was moved
out of gve_adminq_free_db_resources(), it appears this method only
deconfigures device resources now, and the DMA memory is freed separately
by gve_free_irq_db_indices().

>   * @get_ptype_map: Learn packet type map from device and store it in @pr=
iv
>   * @configure_rss: Set up default RSS configuration

[ ... ]

> diff --git a/drivers/net/ethernet/google/gve/gve_adminq.c b/drivers/net/e=
thernet/google/gve/gve_adminq.c
> index cb0e7005dd3ca..f1ac55cc5b10f 100644
> --- a/drivers/net/ethernet/google/gve/gve_adminq.c
> +++ b/drivers/net/ethernet/google/gve/gve_adminq.c

[ ... ]

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
> +}

[Severity: Medium]
Should this function be named gve_adminq_release_db_resources() instead, to
match the intention stated in the changelog?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260803184630.3813=
311-1-hramamurthy@google.com?part=3D12
