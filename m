Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28D1446AA85
	for <bpf@vger.kernel.org>; Tue,  4 Aug 2026 18:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785869222; cv=none; b=LV3IwBMJznyu6o/eaIr0uu/vAxXAKa0SIYE3YbXprpMHfmkQ5/ENUKWoDLU1ZkocLCEdh4Nk0R4W7IeCtU1eK41J1A8BKqb9MX+AdOSklbBMu9LnRK+M+B0iV1wRF1uu8zgNH86LlNMWVdHK6vG2mt9sqJH/GEiiEw87fYDg6xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785869222; c=relaxed/simple;
	bh=AXjk0zT1T6mwa9r37KYLqI1j42142poaugDy6pWeiLY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=SwU3d00MjH2M0PvhAQDe29+mC4VVxohk8otKMV+/hHolAVAuujk1Lj+95heDSyHqw7xjiqQli3XxJAQEz167vG87ptT/0Xn2k8hKGof/M/WVoNsbXdcqC116ixAVCjtqIqvBA7C24T4zZMjQl2ReJ6m8Bz369GS3x4w+Rr2GECI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EZ2HwJ2j; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EZ2HwJ2j"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 899C21F00A3A;
	Tue,  4 Aug 2026 18:47:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785869220;
	bh=LMtqr1HDgMT/GTjOtWTkQq0adNePMqkS2+Ofcng1Nr4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EZ2HwJ2jg2u8lVHNj6/ckjyU0N+Vy2KrcwI7ZRpo7Awn0flYduby4bhT9tuaFxP04
	 ONjpMrOsp7gwcitc59oLUEOlDYq9WUW6r9jt9sW12qaKVDf7kAyf0LoyTH3qeLHg0P
	 dj+IGH0huQefE6jnZJyqGlyiDTNIWqv9uCM55HE+dxSXUMY/tZx+m+iVcVDYVbMWzT
	 oe1axeAuF9VvQd3pdn6GVWq/nmbhIhDZu3G8s3BFcUmE6/+Kjjb62wpl3RbyAXpSE2
	 lB55wASVkzCos2f/nJipY/wHsjf7R4ucoZ7So2iVvNu0mJwYEXoRGsNhUZl5ttNe5L
	 uUED9RTtd9EKw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v3 04/15] gve: add struct gve_device_info to
 hold device properties
Reply-To: sashiko-reviews@lists.linux.dev
To: "Harshitha Ramamurthy" <hramamurthy@google.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260803184630.3813311-5-hramamurthy@google.com>
References: <20260803184630.3813311-1-hramamurthy@google.com>
 <20260803184630.3813311-5-hramamurthy@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 04 Aug 2026 18:46:59 +0000
Message-Id: <20260804184700.899C21F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The refactored gve_set_buf_sizes() logic silently ignores hardwa=
re-requested max_rx_buffer_size limits if they are smaller than the default.
--

--- Patch [4]: [PATCH net-next v3 04/15] gve: add struct gve_device_info to=
 hold device properties ---
commit 604b13a249f6db1d11e788325b47c9f96325ca0e
Author: Harshitha Ramamurthy <hramamurthy@google.com>

gve: add struct gve_device_info to hold device properties

In the current AdminQ mode, device properties are written into struct
gve_device_descriptor that is allocated in shared memory between the driver
and device. This patch introduces struct gve_device_info to hold all
properties negotiated in either mode to prepare for the upcoming MailboxQ
mode. Device initialization logic is refactored to use this new structure
without any intended functional changes.

> diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/eth=
ernet/google/gve/gve_main.c
> --- a/drivers/net/ethernet/google/gve/gve_main.c
> +++ b/drivers/net/ethernet/google/gve/gve_main.c

[ ... ]

> +static void gve_set_buf_sizes(struct gve_priv *priv)
> +{
> +	struct gve_device_info *device_info =3D &priv->device_info;
> +
> +	if (device_info->max_rx_buffer_size > priv->max_rx_buffer_size)
> +		priv->max_rx_buffer_size =3D device_info->max_rx_buffer_size;

[Severity: Medium]
Does this logic silently ignore hardware-requested buffer size limits if
they are smaller than the initial default?

Before this refactoring, gve_enable_supported_features() applied the
hardware limit unconditionally:

priv->max_rx_buffer_size =3D
    be16_to_cpu(dev_op_buffer_sizes->packet_buffer_size);

With this conditional check in gve_set_buf_sizes(), if the device advertises
a max_rx_buffer_size smaller than what priv->max_rx_buffer_size was initial=
ly
set to, the driver will ignore the hardware limit.

Could this cause the device configuration to fail or buffers to overflow if
the hardware cannot handle the larger default buffers?

> +
> +	if (gve_is_dqo(priv) &&
> +	    priv->max_rx_buffer_size > GVE_DEFAULT_RX_BUFFER_SIZE)
> +		priv->rx_cfg.packet_buffer_size =3D priv->max_rx_buffer_size;
> +
> +	if (device_info->header_buf_size)
> +		priv->header_buf_size =3D device_info->header_buf_size;
> +}

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260803184630.3813=
311-1-hramamurthy@google.com?part=3D4
