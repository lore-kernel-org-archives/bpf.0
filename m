Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CC5458E2A9
	for <bpf@vger.kernel.org>; Thu, 10 Sep 2026 19:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789067518; cv=none; b=YNQQdhQlkNKVZ5zxXT/SUvfnYbBK3BQPC8Yo4HPh6oeMtmOh2jo0ei8NbYcPaO3yPpHy00GyFLjxEg7BxnqJMpZ3c8yZ/k/Q9uzlH1mWCV3Di8ugUjmqbWJ1slBSOqwzcD7pI60P/GC8keaC/p+hmCRjL+h3ud+7gb25ch1Yl5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789067518; c=relaxed/simple;
	bh=adqn5x6gVvLnk967S0BJyHoEI35Rxgoylr9+NtmrIXE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=g7lSVLt2ig++FoCDPzqv4zJX5h/bMc0eW2Gos83NG9tHKTuI7GsCu4U1fCnvj6dUzpz/E/2BWqmHTmn9EdqvSfLtwR4Tj9WXTTkh+JKjY49gu9OyJEIFatX+dTBDKsd3jAuIDMf/f8yIghO52pOKmcqbzf6AStIWsjkvftUeiWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Eoj66l5f; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Eoj66l5f"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00DCC1F00898;
	Thu, 10 Sep 2026 19:11:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789067517;
	bh=vMrGKgBwfVXEmgNI1zs1oCxe3yFiNn8dSnUFWYAMJjU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Eoj66l5f2o72AGWhvMpkj3uYwmnU7shjQHjrsngYi5T6QZI4s3n/YsjWAOKvxLOT8
	 BZOvVmTWqFUlWM94HnOGxLARHyQcHPG29+v6pdqcdk/eKUSoz5irxj0H7P7GbIid16
	 GC66lTD+PNVE7ew7mG/IkQErnLuy/HSRa16IKPCHX6apEqvdMe2cySsNRw9Y/Ogq/R
	 B4mc+9joxy+lK4XmgiL32lkkcW0+BsYBDDcH8aAe0y4DGFZTQkXGgLytyJLnT49WUk
	 EONRmOomBfZpqZCPNe3MRaROxAhStcSRsIdJDp7f4PMoyvNvTKqWhv57ih5IkLiMoV
	 trLPdjrc+niEg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v6 06/12] gve: simplify reset logic
Reply-To: sashiko-reviews@lists.linux.dev
To: "Harshitha Ramamurthy" <hramamurthy@google.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260909191136.3811892-7-hramamurthy@google.com>
References: <20260909191136.3811892-1-hramamurthy@google.com>
 <20260909191136.3811892-7-hramamurthy@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 10 Sep 2026 19:11:56 +0000
Message-Id: <20260910191157.00DCC1F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Silent state loss of AF_XDP configuration and hardware flow rules =
after device reset.
--

commit bcda352ad7c739e9f63ce9eefb6fb5309a234230
Author: Joshua Washington <joshwash@google.com>

gve: simplify reset logic

This commit simplifies the GVE reset logic by removing recursive resets,
avoiding resets during teardown, and decomposing allocation/teardown of
control plane resources.

> diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/eth=
ernet/google/gve/gve_main.c
> --- a/drivers/net/ethernet/google/gve/gve_main.c
> +++ b/drivers/net/ethernet/google/gve/gve_main.c
[ ... ]
> @@ -590,7 +594,22 @@ static void gve_free_notify_blocks(struct gve_priv *=
priv)
>  	priv->msix_vectors =3D NULL;
>  }
> =20
> -static int gve_setup_device_resources(struct gve_priv *priv)
> +static void gve_free_control_plane_resources(struct gve_priv *priv)
> +{
> +	bitmap_free(priv->xsk_pools);
> +	priv->xsk_pools =3D NULL;

[Severity: High]
This is a pre-existing issue, but does this cause a silent state loss of
AF_XDP configuration after a device reset?

Because the driver clears xsk_pools without restoring the state, any active
AF_XDP applications could silently stop receiving traffic and require a
manual restart to recover after a routine reset (such as from a TX timeout
or an ethtool reset). This breaks the ABI contract for AF_XDP, making the
networking features permanently unusable after a transparent recovery.

> +
> +	kvfree(priv->ptype_lut_dqo);
> +	priv->ptype_lut_dqo =3D NULL;
> +
> +	gve_free_stats_report(priv);
> +	gve_free_notify_blocks(priv);
> +	gve_free_counter_array(priv);
> +	gve_free_rss_config_cache(priv);
> +	gve_free_flow_rule_caches(priv);

[Severity: High]
This is a pre-existing issue, but does this destroy the software cache of
ethtool flow rules without restoring them?

User-configured hardware flow rules appear to be permanently deleted from
both the hardware and the software cache upon a device reset. They are never
restored to the hardware, requiring manual user intervention to reapply
them.

> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260909191136.3811=
892-1-hramamurthy@google.com?part=3D6
