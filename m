Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2EDB502555;
	Mon, 28 Sep 2026 22:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790632830; cv=none; b=ofHbemsFQhAW9Tghe95DjErn+8QGFraGTrI3+0gzuPrz8zY2BINXYlaPpkzT2xGOg0FQl95SoJM4evlX36bgG3bpDrfDNHoLCorV/c9gC46VYuRTOh/hb+U+hD1RTXIp6B1rGau7Au5pOPIYAuhALpEjMZFsQo9Ar/DUlLNJUpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790632830; c=relaxed/simple;
	bh=NNX/pmu2FjcdhfML/qI6f+r5KnBHjf5VxiIM6PKvx7o=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Woe4bTpaqPnswxBgk+c+lUAyAF0LiWESguRNZfAS9UVTj22ka+6sZY9UowyiplWkEczMZMJKVF03Q5J0Ys/M3SfWEj9mTg+BIdws4PSLPN0EHoqP+og0TATcjGgQ6fu+ZvB86PSuNsaWFG/E9MQPPRCDOwCTdxwdESQLVJI7JK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QjF96pOa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QjF96pOa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D2851F000FF;
	Mon, 28 Sep 2026 22:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790632828;
	bh=kajGctEfzzP4JBdcbGmdLckNkmrOhNOxklsYgfjBPs4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QjF96pOaceoVUjdA2sY1q3SzB1Gxk0BMSneypHeNK/vEl+wuGQxgZTM21aXfIyqnX
	 UxtXLU9GxdthYvXLm0r7tTjYkF2iygNPZCNomW2vARMmvncAHKAeJFG0Fib8GAlpwY
	 rDB6lb4XuwDWQ/38Cvl7+sOve4Sd6SfNujlLVwb0R9EbtT8iO3mwFJ3H2oRyYl2FX1
	 Ma8FINCm8jzFbhkbTEph8PYENBwRRygsoCtwFPA6dIYpoJMyNBbnCf4jlEN+WWidB1
	 1C8fLg9j+Rdf/b8GPturbnCMiziTV6BYllYCCJYyJT5er/94gVNkdM5XiuXlXMS9KG
	 5VvW6H5JcVwJw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v5 15/19] net: stmmac: restore TC offloads
 before restarting DMA
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Hilliard" <james.hilliard1@gmail.com>
Cc: linux-sunxi@lists.linux.dev, bpf@vger.kernel.org
In-Reply-To: <20260927-submit-stmmac-reset-fixes-v1-v5-15-feec6c14dd06@gmail.com>
References: <20260927-submit-stmmac-reset-fixes-v1-v5-0-feec6c14dd06@gmail.com>
 <20260927-submit-stmmac-reset-fixes-v1-v5-15-feec6c14dd06@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 28 Sep 2026 22:00:27 +0000
Message-Id: <20260928220028.1D2851F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] net: stmmac: restoring failed TAPRIO schedule uses stale base ti=
me
--

commit 8c820a1d24ead26f459c2d60dccc5c98e5feaf2f
Author: James Hilliard <james.hilliard1@gmail.com>

net: stmmac: restore TC offloads before restarting DMA

This commit adjusts the restoration of TC offloads in stmmac to occur
before restarting DMA during hardware setup or resume. It also modifies
TAPRIO configuration to validate replacements separately, only publishing
the new schedule upon success and falling back to the old schedule if
programming fails.

> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c b/drivers/ne=
t/ethernet/stmicro/stmmac/stmmac_tc.c
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
[ ... ]
> @@ -1032,48 +1091,43 @@ static int tc_taprio_configure(struct stmmac_priv=
 *priv,
[ ... ]
> -	ret =3D __stmmac_setup_est(priv);
> +	mutex_lock(&priv->est_lock);
> +	ret =3D __stmmac_setup_est(priv, est);
>  	if (ret)
> -		goto disable;
> +		goto restore;
> =20
>  	ret =3D tc_config_preemption(priv, extack, qopt->mqprio.preemptible_tcs=
);
>  	if (ret)
> -		goto disable;
> -
> -	priv->est.enable =3D true;
> -	kfree(gcl);
> +		goto restore;
> =20
> +	priv->est =3D *est;
>  	mutex_unlock(&priv->est_lock);
> +free_est:
> +	kfree(est);
> +	return ret;
> =20
> -	return 0;
> +restore:
> +	/* A failed hardware update must not publish the rejected schedule. */
> +	if (stmmac_est_configure(priv, priv, &priv->est,
> +				 priv->plat->clk_ptp_rate, priv->est.enable))

[Severity: Medium]
Will this restore operation use a stale base time that is in the past?

If __stmmac_setup_est() succeeds with the new schedule but the subsequent
tc_config_preemption() fails, the code jumps to the restore label.

This restore path calls stmmac_est_configure() directly on the old
priv->est. Because it bypasses __stmmac_setup_est() for the restoration,
it skips calculating a valid future base time via stmmac_calc_tas_basetime()
and appears to write the old base time register values back to the hardware.

Could this lead to hardware schedule malfunctions, such as loop errors
or a failure to start, since the old base time lies in the past?

> +		netdev_err(priv->dev, "failed to restore EST\n");
> +	mutex_unlock(&priv->est_lock);
> +	goto free_est;
> =20
>  disable:
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260927-submit-stm=
mac-reset-fixes-v1-v5-0-feec6c14dd06@gmail.com?part=3D15
