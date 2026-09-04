Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE87843B4AA
	for <bpf@vger.kernel.org>; Fri,  4 Sep 2026 21:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788558996; cv=none; b=IR6WD2EJawz+zT4/VZSDzWrdC8oQ5SnwWFOB7Pfqnoy3FVoQvZIRVCezi1gqC7V4Mp2oYpSOVe2YeIRmCKK28OtwnH002SlGGUZIuYo2yFs7pSUfj61oPjcL9HMh3QdXDewh4rTBQqfI+RuNhe8+YqDBLdY6vWOPRfmsxuZhhtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788558996; c=relaxed/simple;
	bh=Fj8UeaVIdFI7WHFtECoORCyCyVAzre0hN3SPsiYPm1I=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=JtptqRx4doj3SxUPDjxvsy31mPvOx8XS4FeLOdTY0NVgK+fsrvzqN3apzn1kqnwWOuL8AeF047FbAkJOnWwyLYoWQDxX+WQoneqj51dDDl2FNMWbs1oND4986Zvu8ikV9Sz0afLQevdGzymYJhF+IdyF2wfg7bRz8ri/ZSZBD70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g6dVFhFy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g6dVFhFy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D98E61F00A3F;
	Fri,  4 Sep 2026 21:56:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788558993;
	bh=ozdlqzYwjoBngWbbNXrtdIHYKWBGgWmwnCQFta8p9h8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=g6dVFhFyB7DbaP8KwZu2FuiTYfK7CK5vIWlQKbJCoguRIX8ej5fwm1oiAj0lU8n+g
	 R7duvYitcDTR3Ek9VBQbhfCgZ7XsNz6mFnAtMztovPUtx5vo9TbgR2EcbcSljKZv8W
	 MKoYjtCmjhbK8+nr0Cmip/+bAK42p9GsA7tkPN05E8UCV1SAYIw6gY6FGxjzXNFXw3
	 Wj/l09/4APuN9jXHTBDBQrr+8vMYmQp4kGa2RTz7BLJaqeCbW5pqH1nWp8M+ChpG54
	 2Oc3MY9uRCYJa9EkO9BN6x42IJPWDbpwcciSZgRdZS1tOxa27WFd4wD83A07ggXtaV
	 HA1e6Jn0Cj0Pw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v5 07/12] gve: add gve_ctrl_ops for gve
 initialization/teardown sequences
Reply-To: sashiko-reviews@lists.linux.dev
To: "Harshitha Ramamurthy" <hramamurthy@google.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260903215606.31633-8-hramamurthy@google.com>
References: <20260903215606.31633-1-hramamurthy@google.com>
 <20260903215606.31633-8-hramamurthy@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 04 Sep 2026 21:56:32 +0000
Message-Id: <20260904215632.D98E61F00A3F@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The ethtool callback `gve_set_rxfh` bypasses the `gve_ctrl_ops` =
abstraction by calling `gve_adminq_configure_rss` directly.
--

commit 10b1b0685ff2bac01a7188b6c0dc5c2a0e9dae42
Author: Joshua Washington <joshwash@google.com>

gve: add gve_ctrl_ops for gve initialization/teardown sequences

Driver initialization and teardown involve a number of control plane
operations that need to be defined for gve_probe to operate in both
mailbox and adminq modes.

> diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/eth=
ernet/google/gve/gve_main.c
> index acd09e9f416c1..5ad7a8f9bbddb 100644
> --- a/drivers/net/ethernet/google/gve/gve_main.c
> +++ b/drivers/net/ethernet/google/gve/gve_main.c
[ ... ]
> @@ -1815,6 +1820,7 @@ static int gve_xdp(struct net_device *dev, struct n=
etdev_bpf *xdp)
> =20
>  int gve_init_rss_config(struct gve_priv *priv, u16 num_queues)
>  {
> +	const struct gve_ctrl_ops *ops =3D priv->ctrl_ops;
>  	struct gve_rss_config *rss_config =3D &priv->rss_config;
>  	struct ethtool_rxfh_param rxfh =3D {0};
>  	u16 i;
> @@ -1830,15 +1836,17 @@ int gve_init_rss_config(struct gve_priv *priv, u1=
6 num_queues)
> =20
>  	rxfh.hfunc =3D ETH_RSS_HASH_TOP;
> =20
> -	return gve_adminq_configure_rss(priv, &rxfh);
> +	return ops->configure_rss(priv, &rxfh);
>  }

[Severity: Medium]
While this function is updated to use the new ops->configure_rss abstractio=
n,
does gve_set_rxfh() in drivers/net/ethernet/google/gve/gve_ethtool.c also n=
eed
to be updated?

It appears to still call gve_adminq_configure_rss() directly:

drivers/net/ethernet/google/gve/gve_ethtool.c:gve_set_rxfh() {
    ...
	if (!priv->rss_key_size || !priv->rss_lut_size)
		return -EOPNOTSUPP;

	err =3D gve_adminq_configure_rss(priv, rxfh);
    ...
}

Should this also be calling ops->configure_rss() to prevent bypassing the
abstraction and potentially causing undefined behavior when alternative con=
trol
plane modes are used?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260903215606.3163=
3-1-hramamurthy@google.com?part=3D7
