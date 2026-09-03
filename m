Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4480F37BE80
	for <bpf@vger.kernel.org>; Thu,  3 Sep 2026 20:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788466718; cv=none; b=Wwdh5iXcxyL1hc2+xKEf0Tzq5W0DDWPHv+p986lF1oK25km1VnuZ48EiWSdYmZFcnab4RJd+JgrdkRdHF6lEq/Xue7/j0+4u9fxfIHgTeP2ET8Au8OxC3RrC+JVvUf5uFW/JmgPDVQ0lYHueSBqfl9f0S0UIdWUGRKc7HsfVyPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788466718; c=relaxed/simple;
	bh=y4bzWxHG6b76ZuARi4J766aLlg3aIIx5AlErwuBgGM0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=pNXIA6BRxmHjrn56iKgEhuQJakdyam61Wna4AijHfZXDa34VjPM70QXosFzrVy1aOyrmWpkoUcJv502mosoEB6D4JQrwRGssYxpF2s+9eDbsTj8EcO8SJZ8QT6XSwVMnQoh3FovcP/4PRYmnrNgrbDQMi4X46RGnMsfQO9lqFnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G8gtPOfg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G8gtPOfg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5834A1F00A3D;
	Thu,  3 Sep 2026 20:18:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788466706;
	bh=75QhO10cI1+JOlBaaHdkilNnYbGoWEmUtX4ABWYL+x0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=G8gtPOfg5lJmDv8YpsrytxCH2WhLvh3stXEN7pGR02vHGoaJvqgEJDASIatU16WCe
	 n2LXbxQa3LjAB6iQsuXEiIq/16MEQJhzwG5eGqXe7zbbAjF4Rdf7LiQRAFIyrWemBk
	 BNoHTh5XaDmuDdnUdZ1isKn0fpa+I0BlcCJoZYcnwdDfeBwlwxTDh8R1IwejE6mNpd
	 c7KJWK9zYCrqs3NP6vYLSJYAfeak8sFdhZYmAaNXuH1fFmNNGoxYwGG7E8N51HcoIE
	 NXzLU4TQt0vzG1HmEe+Y902NWRzJ6ZG+wvRJMW+eg/zCFaOf/+1RU/HZ7BKdOGFEFQ
	 OBXSjlap4PxKA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v3 4/4] net: stmmac: re-apply taprio offload in
 __stmmac_open() and stmmac_resume()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Lorenzo Bianconi" <lorenzo.bianconi@oss.qualcomm.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260902-stmmac-est-reapply-after-open-v3-4-e72a6df5a7ef@oss.qualcomm.com>
References: <20260902-stmmac-est-reapply-after-open-v3-0-e72a6df5a7ef@oss.qualcomm.com>
 <20260902-stmmac-est-reapply-after-open-v3-4-e72a6df5a7ef@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 03 Sep 2026 20:18:25 +0000
Message-Id: <20260903201826.5834A1F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Calling `tc qdisc add dev <eth> parent root taprio ...` when t=
he interface is down causes a system crash due to uninitialized locks and d=
isabled hardware clocks.
--

commit f82312d096c2ce72658ffac1182f1169293623b9
Author: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>

net: stmmac: re-apply taprio offload in __stmmac_open() and stmmac_resume()

This commit re-applies the taprio offload in __stmmac_open() and=20
stmmac_resume() after PTP is up because a core soft reset clears the=20
MTL_EST registers. It introduces a new __stmmac_setup_est() utility=20
routine to handle the hardware schedule configuration, updating how=20
tc_taprio_configure() applies these settings atomically.

> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_est.c b/drivers/n=
et/ethernet/stmicro/stmmac/stmmac_est.c
> index f15d4d046aa74..49edfebbc39e0 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_est.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_est.c

[ ... ]

> +int __stmmac_setup_est(struct stmmac_priv *priv)
> +{
> +	struct timespec64 current_time, time;
> +	ktime_t current_time_ns, basetime;
> +	u64 cycle_time;
> +	int err;
> +
> +	lockdep_assert_held(&priv->est_lock);
> +
> +	priv->ptp_clock_ops.gettime64(&priv->ptp_clock_ops, &current_time);

[Severity: Critical]
This is a pre-existing issue, but since the hardware access is refactored
into this helper, it highlights a crash if called when the interface is dow=
n.

If tc_taprio_configure() is called while the interface is down, it reaches
here and invokes the gettime64() callback. The stmmac_get_time() function
attempts to acquire priv->ptp_lock. However, rwlock_init(&priv->ptp_lock)
only occurs in stmmac_ptp_register() during __stmmac_open().

Does this code trigger a panic (e.g., on PREEMPT_RT or with PROVE_LOCKING)
because it uses an uninitialized lock when the interface has never been
opened?

> +	current_time_ns =3D timespec64_to_ktime(current_time);

[ ... ]

> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c b/drivers/ne=
t/ethernet/stmicro/stmmac/stmmac_tc.c
> index be48bcabdadca..9745c9bae33c1 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c

[ ... ]

> @@ -1053,51 +1067,44 @@ static int tc_taprio_configure(struct stmmac_priv=
 *priv,
>  			gates &=3D ~BIT(0);
>  			break;
>  		default:
> -			return -EOPNOTSUPP;
> +			ret =3D -EOPNOTSUPP;
> +			goto free_gcl;
>  		}
> =20
> -		priv->est.gcl[i] =3D delta_ns | (gates << wid);
> +		gcl[i] =3D delta_ns | (gates << wid);
>  	}
> =20
> -	mutex_lock(&priv->est_lock);
> -	/* Adjust for real system time */
> -	priv->ptp_clock_ops.gettime64(&priv->ptp_clock_ops, &current_time);
> -	current_time_ns =3D timespec64_to_ktime(current_time);
> -	time =3D stmmac_calc_tas_basetime(qopt->base_time, current_time_ns,
> -					qopt->cycle_time);
> -
> -	priv->est.btr[0] =3D (u32)time.tv_nsec;
> -	priv->est.btr[1] =3D (u32)time.tv_sec;
> +	memset(&priv->est, 0, sizeof(priv->est));
> +	memcpy(priv->est.gcl, gcl, sizeof(priv->est.gcl));
> +	priv->est.gcl_size =3D size;
> =20
> -	qopt_time =3D ktime_to_timespec64(qopt->base_time);
> -	priv->est.btr_reserve[0] =3D (u32)qopt_time.tv_nsec;
> -	priv->est.btr_reserve[1] =3D (u32)qopt_time.tv_sec;
> +	time =3D ktime_to_timespec64(qopt->base_time);
> +	priv->est.btr_reserve[0] =3D (u32)time.tv_nsec;
> +	priv->est.btr_reserve[1] =3D (u32)time.tv_sec;
> =20
> -	ctr =3D qopt->cycle_time;
>  	priv->est.ctr[0] =3D do_div(ctr, NSEC_PER_SEC);
>  	priv->est.ctr[1] =3D (u32)ctr;
> =20
>  	priv->est.ter =3D qopt->cycle_time_extension;
> -
>  	tc_taprio_map_maxsdu_txq(priv, qopt);
> =20
> -	ret =3D stmmac_est_configure(priv, priv, &priv->est,
> -				   priv->plat->clk_ptp_rate, true);
> -	mutex_unlock(&priv->est_lock);
> -	if (ret) {
> -		netdev_err(priv->dev, "failed to configure EST\n");
> +	ret =3D __stmmac_setup_est(priv);

[Severity: Critical]
This isn't a bug introduced by this patch, but does tc_taprio_configure()
need to verify netif_running() before calling this helper?

When a user configures a TAPRIO qdisc via tc while the interface is down,
the PTP reference clock (clk_ptp_ref) is still disabled. Calling
__stmmac_setup_est() unconditionally accesses MAC PTP and EST hardware
registers.=20

Can accessing these registers without their corresponding clocks enabled
cause a synchronous bus fault or system hang on some platforms?

> +	if (ret)
>  		goto disable;
> -	}
> =20
>  	ret =3D stmmac_fpe_map_preemption_class(priv, priv->dev, extack,
>  					      qopt->mqprio.preemptible_tcs);
>  	if (ret)
>  		goto disable;
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260902-stmmac-est=
-reapply-after-open-v3-0-e72a6df5a7ef@oss.qualcomm.com?part=3D4
