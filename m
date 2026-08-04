Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79F9146AF08
	for <bpf@vger.kernel.org>; Tue,  4 Aug 2026 18:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785869224; cv=none; b=A0j6AsGnQ9Nqj+pV7fSrFrSs/4w3twq54BOf3SeQ4kfH0u7v+4crUcrZtb8ZkDM0eleoh48Qp5SlCL16O4wI3/lMy0ELwSajeARNd78kpLgKdv57fNxylPJNfl539YA1SBzXgltu8AVxEkrGbbw2KPWK28lJH7MSpfUp9O4DQw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785869224; c=relaxed/simple;
	bh=6JIdO+Ix/M44VruAAM8qj8uGaHRKm6U6XqfajnF+jt4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=gyd9rN+WODFP4eZFdMYCreJVTYakQI1USBtuxcKW0MqRYuBKX3bjic4amdia5ZeyTRo3alznTjzZO59mK2m4eUp1snuzu0oILciC4Or8Zt0O5Z6YvN0ropSad+WMaOoEQ9Cprpao8aGCSLCmc82E/LE7XnO1dDt/53h5hiEhSx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c6t3icUg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c6t3icUg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A76B1F000E9;
	Tue,  4 Aug 2026 18:47:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785869223;
	bh=EIx1jkHl05rAp0PU0L+8jDF54D/ATGhitT+a6BGstnI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=c6t3icUgsTkKYn5eUSsHacmv7HlkXKZD66yPC15bUAhE1VysfE+HxLY4qEi8u/dJ+
	 y+K4ttusNm8UXlMolKZ8etRsxNWXA+DnLx6dMT5B3pEu5xVK8JNMPXag9ll0LTmvrE
	 zgI3bMgs7T1CoPgAk23w2VotIHAReN/H9sN0BMY7vN46KId1A/xt8CII+hTkJ8+0fT
	 71eJ+qWsF+2kOu0owcm2gu1MkQD2ostzXmTaf1zvvG+rgMYCNnbmWK1n5egCerAiMi
	 Fangse0/bbveb0ap7jhk1RThX+6LOZelzWqSXpmz/5TxD4YyHw0Jtl/SdcyOP6tclR
	 7OMO1U+8iV3PA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v3 10/15] gve: add gve_ctrl_ops for gve
 initialization/teardown sequences
Reply-To: sashiko-reviews@lists.linux.dev
To: "Harshitha Ramamurthy" <hramamurthy@google.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260803184630.3813311-11-hramamurthy@google.com>
References: <20260803184630.3813311-1-hramamurthy@google.com>
 <20260803184630.3813311-11-hramamurthy@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 04 Aug 2026 18:47:02 +0000
Message-Id: <20260804184703.3A76B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Incomplete abstraction of `configure_rss` leaves a direct depend=
ency on AdminQ in the ethtool path.
--

--- Patch [10]: [PATCH net-next v3 10/15] gve: add gve_ctrl_ops for gve ini=
tialization/teardown sequences ---
commit fa76396ec69ce2dfc47469d3f87210437b9df3b5
Author: Joshua Washington <joshwash@google.com>

gve: add gve_ctrl_ops for gve initialization/teardown sequences

Driver initialization and teardown involve a number of control plane
operations that need to be defined for gve_probe to operate in both
mailbox and adminq modes.

> diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/eth=
ernet/google/gve/gve_main.c
> index 578520e107930..c347661faac00 100644
> --- a/drivers/net/ethernet/google/gve/gve_main.c
> +++ b/drivers/net/ethernet/google/gve/gve_main.c

[ ... ]

> @@ -1809,6 +1814,7 @@ static int gve_xdp(struct net_device *dev, struct n=
etdev_bpf *xdp)
> =20
>  int gve_init_rss_config(struct gve_priv *priv, u16 num_queues)
>  {
> +	const struct gve_ctrl_ops *ops =3D priv->ctrl_ops;
>  	struct gve_rss_config *rss_config =3D &priv->rss_config;
>  	struct ethtool_rxfh_param rxfh =3D {0};
>  	u16 i;
> @@ -1824,15 +1830,17 @@ int gve_init_rss_config(struct gve_priv *priv, u1=
6 num_queues)
> =20
>  	rxfh.hfunc =3D ETH_RSS_HASH_TOP;
> =20
> -	return gve_adminq_configure_rss(priv, &rxfh);
> +	return ops->configure_rss(priv, &rxfh);
>  }

[Severity: Medium]
Since this abstracts the RSS configuration for non-adminq modes, does the
ethtool configuration path also need to be updated to use this new abstract=
ion?

Currently, gve_set_rxfh() in drivers/net/ethernet/google/gve/gve_ethtool.c
still calls the adminq-specific function directly:

drivers/net/ethernet/google/gve/gve_ethtool.c:gve_set_rxfh() {
	...
	if (!priv->rss_key_size || !priv->rss_lut_size)
		return -EOPNOTSUPP;

	err =3D gve_adminq_configure_rss(priv, rxfh);
	if (err) {
		NL_SET_ERR_MSG_MOD(extack, "Fail to configure RSS config");
		return err;
	}
	...
}

Could this cause issues when configuring RSS via ethtool on a device using
a different backend, since it bypasses ops->configure_rss()?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260803184630.3813=
311-1-hramamurthy@google.com?part=3D10
