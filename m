Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A32A45921FF
	for <bpf@vger.kernel.org>; Thu, 10 Sep 2026 19:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789067518; cv=none; b=BYq4VyyJXg81Reo7B34SXNh3YRQIZUOM700WliAh1VstBI13uKYAyPy5qXa1uj/xcKDp9IyiBNriHc3RA2nxIBb2v/YHZnSFRulkMnuO4a+8osLXJdUxVhS3yuzZ7VBR1lCgYJxPvBrlol9GmJwIlyVBWalU+JpZUbDbpim8J8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789067518; c=relaxed/simple;
	bh=xJGdi3fl0rxPMiBcCa6QNwByUS2VlDMhm+htbUcairE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Rrjysb+c8ddSH3D85Xwfne4JmwifFB3Kc/qhGRc2d03kkyvkMp3oKmBwERZLIhwio+xfPNmAgi48Abs8GoB+CSC7Qq4q8R57i3BK2ffuzEkEVBCJW2HTslCyX/7qdy8KNci70g2OwJ3UMl/JahWWss619aL9eOiC5jkXj9E2Xds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HPhWywdC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HPhWywdC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 436B31F000FF;
	Thu, 10 Sep 2026 19:11:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789067516;
	bh=QBoA9I8oha6mw02oz7FFZy0vyFA2MiQGDM+nb0h73Rg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HPhWywdClE58D0nNJiNpQxby5ObJO34NnEEF36OzqrSLG6HIrXRlLGY5sphrX2Vi9
	 S66N+MBOyl/TuWWwsrbnowq4BG29XJgBByXmflLmRscDXZvhYJDYe/15Lg7i8AS54x
	 pe4xpLtGhXSbsRNMP+5D6Qu8lGhMWBAPAKAvtQDiNEyA21HJgyw//SZric4kuy9MBT
	 2ZcR9upZ8KBQrPOE6ucJz52qXOfdvIi2CseQTxHsYec7Rt16FmS4JYylvBsTZiK48V
	 8gXBTPqYDCrhucXD90KBoVLJiYwj0VMWHvOfYeNvjtR4YQhizgW+KQZbyTQASYJ6zX
	 QBAfPMCPTSPTQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v6 01/12] gve: add struct gve_device_info to
 hold device properties
Reply-To: sashiko-reviews@lists.linux.dev
To: "Harshitha Ramamurthy" <hramamurthy@google.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260909191136.3811892-2-hramamurthy@google.com>
References: <20260909191136.3811892-1-hramamurthy@google.com>
 <20260909191136.3811892-2-hramamurthy@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 10 Sep 2026 19:11:55 +0000
Message-Id: <20260910191156.436B31F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Leftover fields `default_min_ring_size` and `default_num_queues` in=
 `struct gve_priv` are completely unused and should have been removed.
--

commit 1e8912b037c461a4e97b883a09cc8e52ac72a6ed
Author: Harshitha Ramamurthy <hramamurthy@google.com>

gve: add struct gve_device_info to hold device properties

This commit introduces struct gve_device_info to encapsulate device
properties in preparation for MailboxQ support. It updates the driver logic
to populate and read from this new structure instead of setting the fields
directly in struct gve_priv.

> diff --git a/drivers/net/ethernet/google/gve/gve.h b/drivers/net/ethernet=
/google/gve/gve.h
> index c280ff35ee771..021adb9108dff 100644
> --- a/drivers/net/ethernet/google/gve/gve.h
> +++ b/drivers/net/ethernet/google/gve/gve.h
> @@ -797,6 +797,34 @@ struct gve_ptp {
>  	struct gve_priv *priv;
>  };
> =20
> +struct gve_device_info {
> +	enum gve_queue_format queue_format;
> +	u16 default_tx_queues;
> +	u16 default_rx_queues;
[ ... ]
> +	bool default_min_ring_size;
> +	bool nic_timestamp_supported;
> +	bool modify_ring_size_enabled;
> +	bool cache_rss_config;
> +};
> +
>  struct gve_priv {
>  	struct net_device *dev;

[Severity: Low]
With the introduction of struct gve_device_info and the migration of the lo=
gic
to use device_info.default_min_ring_size and device_info.default_tx_queues /
device_info.default_rx_queues, should the old fields default_min_ring_size
and default_num_queues be removed from struct gve_priv?

Looking at struct gve_priv in gve.h, these fields appear to be left over:

struct gve_priv {
    ...
    bool default_min_ring_size;
    ...
    u16 default_num_queues; /* default num queues to set up */
    ...
};

They seem to be completely unused now and are left occupying memory as dead
code.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260909191136.3811=
892-1-hramamurthy@google.com?part=3D1
