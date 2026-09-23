Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA2AE3C10B5
	for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 19:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790192757; cv=none; b=an4tgVA2m/MYcaWfIY3mv81EzkF+lQlGUwwesJXLO/fADXGL1mgpfjUz6CU7f53GhHkLannWR6hOW/EMZVNMpvvtMG+q+BVNYSpj0Qa+Mf5c1+NXyVFZ+xOr9Pd5Fq2UUZ/uv8lKWI1U5pA+VjKywkaPgUgndVrTzaIO/5qs5gU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790192757; c=relaxed/simple;
	bh=cdaE+UJCNywjSOq0NRW7pH5ntFL5QrQvsX1QDoq3dwE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=U+E5KFO3+SWVxR70A3FwtRNtY9viZG3nNz3yg2xoY7GRd5H7AwS5m3F6p14oieT+qXD9gCNl/yjHNVvxeoXku8phv6bUgyFW/GSkwulm6Pi5gWgp1850w8kGf7valONAR8AY8CNweZuyDtoZe0I14PPCK+STZnzNHWWmpFCkH3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LtscIjUE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LtscIjUE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 220251F000FF;
	Wed, 23 Sep 2026 19:45:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790192756;
	bh=kJH0Rdun86rylOPmzAABs9knIIapOnueDgsTl8Mhs0o=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LtscIjUECDvDx1u2eRD4Z3cxmif6DOhU+pqLP7TiY4naFAhz0W+wEpriTkJcL76eF
	 vcNT9tq3qcVLhRxD7ckncOUJR2sdgVpiBbZqlDiAvF/PKrPnJvcs9etrUSCuGCzEEe
	 fUJRp4Js/ZxSJQx8U6IXJ9N6FKVo2tUgrP+rAD+fTXZjeAAh8kxGcH+kk43CXba80q
	 69/yowxzkEyrsb71WcioBQYBGp2qBS9rgCf37w+YRrzTA3FiMZ2WsPrp6QhP6le0xJ
	 DK+ounY+Zk3lsSDYjlGyH7NjekXNjgZbWZEVTYllOySzzqQg2JzVMJpgXj2VYa4kSL
	 FrgN9u54z+OQQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v2 7/9] gve: disable NAPI when registering XSK pools
 in QPL mode
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joshua Washington" <joshwash@google.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260922194533.631387-8-joshwash@google.com>
References: <20260922194533.631387-1-joshwash@google.com>
 <20260922194533.631387-8-joshwash@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Sep 2026 19:45:55 +0000
Message-Id: <20260923194556.220251F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Critical] gve: double disable/enable of identical NAPI instance causes d=
eadlock/panic
- [High] gve: missing NAPI schedule for DQO queues causes permanent stall
--

commit fca9a2d42c21eb316a02fe534db2369308d03e28
Author: Joshua Washington <joshwash@google.com>

gve: disable NAPI when registering XSK pools in QPL mode

This commit disables NAPI when registering the XSK memory pool for QPL
interfaces to quiesce traffic and prevent race conditions.

> diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/eth=
ernet/google/gve/gve_main.c
> index 49ae2b8c6a270..f2bd4011de23f 100644
> --- a/drivers/net/ethernet/google/gve/gve_main.c
> +++ b/drivers/net/ethernet/google/gve/gve_main.c
> @@ -1626,6 +1626,40 @@ static int gve_xdp_xmit(struct net_device *dev, in=
t n,
>  	return -EOPNOTSUPP;
>  }
> =20
> +static void gve_disable_xsk_napis(struct gve_priv *priv, u16 qid)
> +{
> +	struct napi_struct *napi_rx, *napi_tx;
> +	u16 tx_qid;
> +
> +	napi_rx =3D &priv->ntfy_blocks[priv->rx[qid].ntfy_id].napi;
> +	napi_disable_locked(napi_rx);
> +
> +	tx_qid =3D gve_xdp_tx_queue_id(priv, qid);
> +	napi_tx =3D &priv->ntfy_blocks[priv->tx[tx_qid].ntfy_id].napi;
> +	napi_disable_locked(napi_tx);

[Severity: Critical]
Does this double-disable the same NAPI instance in symmetric configurations?

Since XDP TX queues share the same NAPI block as RX queues in the default
symmetric configuration, napi_rx and napi_tx resolve to the exact same poin=
ter.
Calling napi_disable_locked() twice on the same NAPI instance will cause a
deadlock since it will spin forever waiting for the NAPI state to change.

> +}
> +
> +static void gve_enable_xsk_napis(struct gve_priv *priv, u16 qid)
> +{
> +	struct napi_struct *napi_rx, *napi_tx;
> +	u16 tx_qid;
> +
> +	napi_rx =3D &priv->ntfy_blocks[priv->rx[qid].ntfy_id].napi;
> +	napi_enable_locked(napi_rx);
> +
> +	tx_qid =3D gve_xdp_tx_queue_id(priv, qid);
> +	napi_tx =3D &priv->ntfy_blocks[priv->tx[tx_qid].ntfy_id].napi;
> +	napi_enable_locked(napi_tx);

[Severity: Critical]
Similarly, will enabling the same NAPI instance twice trigger a BUG_ON()
panic inside napi_enable_locked()?

> +
> +	if (gve_is_gqi(priv)) {
> +		if (gve_rx_work_pending(&priv->rx[qid]))
> +			napi_schedule(napi_rx);
> +
> +		if (gve_tx_clean_pending(priv, &priv->tx[tx_qid]))
> +			napi_schedule(napi_tx);
> +	}

[Severity: High]
Does this logic leave DQO queues permanently stalled if an interrupt fires
while NAPI is disabled?

This exclusively checks for pending work and schedules NAPI on GQI formats,
completely neglecting DQO formats. If an interrupt fired while NAPI was
disabled, the hardware interrupt remains masked forever.

> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260922194533.6313=
87-1-joshwash@google.com?part=3D7
