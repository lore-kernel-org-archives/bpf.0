Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80C0012D21B
	for <bpf@vger.kernel.org>; Sat, 15 Aug 2026 02:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786760077; cv=none; b=Le7cPjq4M5qmsrDTA4/zzHYxcvmqjzzY6ctRsDb5FkxZgsaOWnQgldwwuNxGhz6l998BgCE5x0EKWAZR0x703TtigQpxTkDg2xLTXDKcdCKwjcxT3yIdMWAaZ8yBSpfIMjOx6xVhdsTOKAlXPOByyFPqBG0TeTSKYGZt5kYh67g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786760077; c=relaxed/simple;
	bh=pxATmt8+Wojg5eyeDCbJ+BvP7d1ZNF3KIgsRP8ujZMc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=iPvKA7wVMi0dmMSjAGWGMwvhIUP4CQtSlyflwh24TKM38nc/RR85PXu1gNvI6FBk/4FELuKWFnzX+ifOto3qB6HYx74fjLN/h8FEmm1kKyBOt+O9wqzl0yMC9RLPYvK2sZhT2LIJpan/gLguqYSFcjqiC0F9redfI6Es+8B6bLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WhSLc5NX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WhSLc5NX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A5451F00A3A;
	Sat, 15 Aug 2026 02:14:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786760076;
	bh=zpqNATiPwzW59QJem1Gyro4LyHKdZwLNdQalznlVAo4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WhSLc5NXWwtvl3UbXBPhq+zzMM6HlV+k+UsRKOx0v447XfQK5DM4eusKtWmLg3jCa
	 jioJbnize7728U3wexVD9WpBkvq5wvyP3T+Gcle439jtlChadYdChNzreXL/au9EnD
	 1sSPqnZYHN4BWLsfooRw3GnNqS2t70fQNLJJM/1KeGGzu66ZujX0krNjTZpnau5R5N
	 673d25fYLWT71IHYs68PIjXGyG/st6Igrxbp5URyBnj1hD8Dq/Hxq8pt4SMHcRcvll
	 titBYhIr0aFSaQARqqQWTLjC2dwKBm3NmigDEY43mgTZ/BEcDRzA7GikkFpcL+++pS
	 NQyptb/r2TfJA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v4 04/15] gve: add struct gve_device_info to
 hold device properties
Reply-To: sashiko-reviews@lists.linux.dev
To: "Harshitha Ramamurthy" <hramamurthy@google.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260814021406.3044324-5-hramamurthy@google.com>
References: <20260814021406.3044324-1-hramamurthy@google.com>
 <20260814021406.3044324-5-hramamurthy@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 15 Aug 2026 02:14:35 +0000
Message-Id: <20260815021436.3A5451F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] The driver ignores the hardware-requested default queue limits a=
nd blindly allocates the maximum number of queues due to an uninitialized v=
ariable introduced during refactoring.
- [Low] The conditional assignment of `max_rx_buffer_size` incorrectly drop=
s valid device limits that are smaller than the driver's default size.
--

--- Patch [4]: [PATCH net-next v4 04/15] gve: add struct gve_device_info to=
 hold device properties ---
commit 7fded5d146c6551cb7cea8119862eccd51e6f61f
Author: Harshitha Ramamurthy <hramamurthy@google.com>

gve: add struct gve_device_info to hold device properties

This commit introduces a new gve_device_info structure to hold negotiated
device properties for both AdminQ and upcoming MailboxQ modes. It refactors
gve_adminq_describe_device and its children to populate this structure and
centralizes device property initialization in gve_init_priv.

> diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/eth=
ernet/google/gve/gve_main.c
> --- a/drivers/net/ethernet/google/gve/gve_main.c
> +++ b/drivers/net/ethernet/google/gve/gve_main.c

[ ... ]

> -void gve_set_queue_properties(struct gve_priv *priv,
> -			      struct gve_device_descriptor *descriptor)
> +static void gve_set_queue_properties(struct gve_priv *priv)
>  {
> -	/* set default descriptor counts */
> -	gve_set_default_desc_cnt(priv, descriptor);
> +	struct gve_device_info *device_info =3D &priv->device_info;
> =20
> -	priv->max_registered_pages =3D be64_to_cpu(descriptor->max_registered_p=
ages);
> -	priv->tx_pages_per_qpl =3D be16_to_cpu(descriptor->tx_pages_per_qpl);
> -	priv->default_num_queues =3D be16_to_cpu(descriptor->default_num_queues=
);
> +	gve_set_desc_cnt(priv);
> +	priv->max_registered_pages =3D device_info->max_registered_pages;
> +	priv->tx_pages_per_qpl =3D device_info->tx_pages_per_qpl;
>  }

[Severity: Medium]
Does this leave priv->default_num_queues uninitialized?

The previous code initialized it from the descriptor. The new device_info
struct holds default_tx_queues and default_rx_queues, but it appears
priv->default_num_queues is no longer being populated.

Because of this, will gve_set_num_queues() bypass device-suggested queue
limits and always allocate the maximum possible number of queues since the
check for priv->default_num_queues > 0 will fail?

[ ... ]

> +static void gve_set_buf_sizes(struct gve_priv *priv)
> +{
> +	struct gve_device_info *device_info =3D &priv->device_info;
> +
> +	if (device_info->max_rx_buffer_size > priv->max_rx_buffer_size)
> +		priv->max_rx_buffer_size =3D device_info->max_rx_buffer_size;

[Severity: Low]
Is it intentional to only update priv->max_rx_buffer_size if the device
limit is strictly greater than the driver's current default?

The previous implementation in gve_enable_supported_features() applied the
device value unconditionally. Does this conditional check discard valid
hardware limits if they happen to be smaller than the driver's default size?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260814021406.3044=
324-1-hramamurthy@google.com?part=3D4
