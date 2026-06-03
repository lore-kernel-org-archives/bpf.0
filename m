Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7EFC4DC547
	for <bpf@vger.kernel.org>; Wed,  3 Jun 2026 23:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780531169; cv=none; b=WtrwxgcE7hoaExZXB6CBSw4t8aywP7rhHKT0MGtFiKqnGMAkj+95J3GmDnTYL9vLlfF7wIa6y59st/OY5qbpYpxl9D4NxDeXSqIeYWOCW93QvYsPArpddSXUfDL6tdeAO8/RifG7L6JPyfF4zvSDMqhaH2FcpUPFV/igrJrM3hE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780531169; c=relaxed/simple;
	bh=8Jjp1m5wPOkkwdBvVlQudzrb18UBqxjz9fyAMxIxF10=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=D9FUk0ZWb6KmckkfG2cxxgKRYbI9H++63XzQd6s+zNqmb6GjE1iS8s5yE0xu/uXLR7/3RAyUNItQPdS61uU3RW46s5XRJK2W5CHlDwn6EIdoEW7E31+t2hZyXm8YpjSYQz9gyE8zUe3W5IwgRTbM2sZsEGbBVopB0y9i2cw27ZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YONGCQoO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YONGCQoO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A22E1F00898;
	Wed,  3 Jun 2026 23:59:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780531168;
	bh=ISVhDk4ykrJZZJQcYFeN8TtA4PPx2bY9bmqFeAawEQ0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YONGCQoOJmI2iJL7QshQAgj9n3tijTjAEu86+3cVKrPqwAlBwVNKl2ruYShttXmsZ
	 tqLPQVR4nu38x3vSFODOb025uVoaKQ9QMLQ5kFJ+d89ISfRefubdbf7ImOVLAa+CLM
	 XLJ4M5yfV+gu+3HUqQDa7f6ODQrmELBkHOCy2XcCTvR2KdPlVguOLCVywYxHWo8Izl
	 AnTRc2SmPsifQJIcS/cBR5gSlB/qcFpfCsyDiucxelJf3h/djKK5Gqpa5+GhthSKK0
	 8wIOlQsloA9k0DlqarEfuORSsq88YMGes252rymFawIQPfbF/8EYLzCEhFyEwZqiAu
	 w6pvWYv8CmlGA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v2 05/15] gve: add struct gve_device_info to
 hold device properties
Reply-To: sashiko-reviews@lists.linux.dev
To: "Harshitha Ramamurthy" <hramamurthy@google.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260602235900.3050782-6-hramamurthy@google.com>
References: <20260602235900.3050782-6-hramamurthy@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 03 Jun 2026 23:59:28 +0000
Message-Id: <20260603235928.9A22E1F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Uninitialized boolean check leads to out-of-bounds read of device =
options for minimum ring sizes.
--

commit 81dd3f8c245cbe096c0cfd21c5c45aa1925ab1d3
Author: Harshitha Ramamurthy <hramamurthy@google.com>
gve: add struct gve_device_info to hold device properties

This commit refactors the driver to store device properties in a new
gve_device_info structure instead of gve_device_descriptor, paving the way
for the upcoming MailboxQ mode. Device option parsing and feature enabling
are updated to use this new structure.

> diff --git a/drivers/net/ethernet/google/gve/gve_adminq.c b/drivers/net/e=
thernet/google/gve/gve_adminq.c
> index 77203184efbdc..06db2ccd0b898 100644
> --- a/drivers/net/ethernet/google/gve/gve_adminq.c
> +++ b/drivers/net/ethernet/google/gve/gve_adminq.c
> @@ -190,7 +190,7 @@ void gve_parse_device_option(struct gve_priv *priv,
> =20
>  		/* device has not provided min ring size */
>  		if (option_length =3D=3D GVE_DEVICE_OPTION_NO_MIN_RING_SIZE)
> -			priv->default_min_ring_size =3D true;
> +			priv->device_info.default_min_ring_size =3D true;
>  		break;
>  	case GVE_DEV_OPT_ID_FLOW_STEERING:

[ ... ]

> @@ -946,77 +949,105 @@ static void gve_enable_supported_features(struct g=
ve_priv *priv,
>  					  const struct gve_device_option_modify_ring
>  					  *dev_op_modify_ring)
>  {
> +	struct gve_device_info *info =3D &priv->device_info;

[ ... ]

>  	/* Read and store ring size ranges given by device */
>  	if (dev_op_modify_ring &&
>  	    (supported_features_mask & GVE_SUP_MODIFY_RING_MASK)) {
> -		priv->modify_ring_size_enabled =3D true;
> -		priv->max_rx_desc_cnt =3D
> +		info->modify_ring_size_enabled =3D true;
> +		info->max_rx_ring_size =3D
>  			be16_to_cpu(dev_op_modify_ring->max_rx_ring_size);
> -		priv->max_tx_desc_cnt =3D
> +		info->max_tx_ring_size =3D
>  			be16_to_cpu(dev_op_modify_ring->max_tx_ring_size);
>  		if (priv->default_min_ring_size) {

[Severity: High]
Does this code still read the correct boolean?=20

Since gve_parse_device_option() was updated to set=20
priv->device_info.default_min_ring_size, but this check still looks
at the un-refactored priv->default_min_ring_size (which remains false),
won't we unconditionally enter the else block?

If the device sends the short 8-byte MODIFY_RING option, could this
lead to an out-of-bounds read into the header of the next packed
device option, misinterpreting its option_id as the minimum ring sizes?

>  			/* If device hasn't provided minimums, use default minimums */
> -			priv->min_tx_desc_cnt =3D GVE_DEFAULT_MIN_TX_RING_SIZE;
> -			priv->min_rx_desc_cnt =3D GVE_DEFAULT_MIN_RX_RING_SIZE;
> +			info->min_tx_ring_size =3D GVE_DEFAULT_MIN_TX_RING_SIZE;
> +			info->min_rx_ring_size =3D GVE_DEFAULT_MIN_RX_RING_SIZE;
>  		} else {
> -			priv->min_rx_desc_cnt =3D be16_to_cpu(dev_op_modify_ring->min_rx_ring=
_size);
> -			priv->min_tx_desc_cnt =3D be16_to_cpu(dev_op_modify_ring->min_tx_ring=
_size);
> +			info->min_rx_ring_size =3D
> +				be16_to_cpu(dev_op_modify_ring->min_rx_ring_size);
> +			info->min_tx_ring_size =3D
> +				be16_to_cpu(dev_op_modify_ring->min_tx_ring_size);
>  		}
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260602235900.3050=
782-1-hramamurthy@google.com?part=3D5
