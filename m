Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2318139DBF5
	for <bpf@vger.kernel.org>; Thu,  3 Sep 2026 20:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788466714; cv=none; b=bFoLiYJWw3GoKlcpm2HWJwF9K83YUyHAZSI9STVwl5nVigcQSrejJdclp6qnpu1tG6P7vUcZACrPTCDVB7iZPAecDGDg3qljx5b78F+RAxFuLzROQQ5Rtt0Qg1PLk87pOwz6rQRgU3iQOmpFYqx70shf+5B4+XZ1OLvbWHVXfYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788466714; c=relaxed/simple;
	bh=Pf0D0igSeXL+nnNxK736IKxUY2oIry6x0hSpPh5ZcD0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=WrF+ZcYn5y/dlcgIlS6VlVuwOMQcdRpC9A0ySWihOAIUCXVzFmKpr2r1sAbW+XhSPtP8rqgqD/4c1zc8U5R1oHgOuYPXIupenlWxf3wzJzzl+97ZyfxLXeRgqZLln21BUKHPCrRokFz329kRK50QzwO+j3E1YpUa6lNoDUiTXqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c9mTVRqn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c9mTVRqn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98F331F000E9;
	Thu,  3 Sep 2026 20:18:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788466705;
	bh=Kj410esl7THuWWt5vH4S7ktmrmZ2vCeygGiPL1mZl/4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=c9mTVRqnqjKnCO9PI9EwPrqNgip4Oh36VMZ++pFC5zfkjcPBEIzcmlEBm5pZ/yXGd
	 Ys6sHWZgvlwIJyfvi0fQ5vOTfr4Xp6EuBcZ8c4tQR94GC8g8N1Kd7WG9U3i8LdrwjZ
	 +6Ez1Pb9JSYIrNkWKa7i+qch5Io6KNrUrcn090ybKfnWAewqvmVwvl00IDJThai72i
	 XcM1EqLhtyqlvLB7d+8ojZWtsCB3KMXnjZKIJpCrqpFGRU+/8hqf1X0VB5MRLUcrVd
	 24+iKAt8Khb4sLGq4JmO4p1t8VeCYO946jlCHJqTd/PvIfZveu0HE0QrZy0YGRNR5v
	 qOyOZV7dK7OkA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v3 1/4] net: stmmac: propagate PTP init failures in
 stmmac_setup_ptp()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Lorenzo Bianconi" <lorenzo.bianconi@oss.qualcomm.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260902-stmmac-est-reapply-after-open-v3-1-e72a6df5a7ef@oss.qualcomm.com>
References: <20260902-stmmac-est-reapply-after-open-v3-0-e72a6df5a7ef@oss.qualcomm.com>
 <20260902-stmmac-est-reapply-after-open-v3-1-e72a6df5a7ef@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 03 Sep 2026 20:18:25 +0000
Message-Id: <20260903201825.98F331F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Propagating stmmac_init_timestamping() return value causes network=
 interface open/resume to fail on hardware without PTP support.
--

commit 9136103951651df9ef9668b2743b64e0da023618
Author: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>

net: stmmac: propagate PTP init failures in stmmac_setup_ptp()

This patch modifies stmmac_setup_ptp() to return an error code instead of
swallowing PTP setup failures. This ensures that failures like a broken
reference clock prevent the schedule from getting stuck during taprio offlo=
ad.

> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/=
net/ethernet/stmicro/stmmac/stmmac_main.c
> index d576059c04df9..47295845371aa 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -937,18 +937,27 @@ static int stmmac_init_timestamping(struct stmmac_p=
riv *priv)
>  	return 0;
>  }
> =20
> -static void stmmac_setup_ptp(struct stmmac_priv *priv)
> +static int stmmac_setup_ptp(struct stmmac_priv *priv)
>  {
>  	int ret;
> =20
>  	ret =3D clk_prepare_enable(priv->plat->clk_ptp_ref);
> -	if (ret < 0)
> +	if (ret < 0) {
>  		netdev_warn(priv->dev,
>  			    "failed to enable PTP reference clock: %pe\n",
>  			    ERR_PTR(ret));
> +		return ret;
> +	}
> +
> +	ret =3D stmmac_init_timestamping(priv);
> +	if (ret) {
> +		clk_disable_unprepare(priv->plat->clk_ptp_ref);
> +		return ret;
> +	}

[Severity: High]
Does this unexpectedly propagate a failure when the MAC hardware lacks PTP
capabilities?

In stmmac_init_timestamping(), if the hardware does not support PTP, it
returns -EOPNOTSUPP:

	if (!(priv->dma_cap.time_stamp || priv->dma_cap.atime_stamp)) {
		netdev_info(priv->dev, "PTP not supported by HW\n");
		return -EOPNOTSUPP;
	}

By returning this error here, will it prevent devices without PTP support
from initializing correctly?

> +
> +	stmmac_ptp_register(priv);
> =20
> -	if (stmmac_init_timestamping(priv) =3D=3D 0)
> -		stmmac_ptp_register(priv);
> +	return 0;
>  }
> =20
>  static void stmmac_release_ptp(struct stmmac_priv *priv)
> @@ -4153,10 +4162,12 @@ static int __stmmac_open(struct net_device *dev,
>  	ret =3D stmmac_hw_setup(dev);
>  	if (ret < 0) {
>  		netdev_err(priv->dev, "%s: Hw setup failed\n", __func__);
> -		goto init_error;
> +		return ret;
>  	}
> =20
> -	stmmac_setup_ptp(priv);
> +	ret =3D stmmac_setup_ptp(priv);
> +	if (ret)
> +		goto ptp_error;

[Severity: High]
Could propagating the -EOPNOTSUPP return value cause the network interface
bring-up to fail completely?

Prior to this patch, stmmac_setup_ptp() ignored the return value, allowing
non-PTP hardware to seamlessly skip PTP setup. Since the error is now handl=
ed,
it seems like bringing up the interface (e.g., via ip link set up) will jump
to ptp_error and abort the open process for hardware without PTP.

[ ... ]
> @@ -8318,13 +8330,12 @@ int stmmac_resume(struct device *dev)
>  	ret =3D stmmac_hw_setup(ndev);
>  	if (ret < 0) {
>  		netdev_err(priv->dev, "%s: Hw setup failed\n", __func__);
> -		stmmac_legacy_serdes_power_down(priv);
> -		mutex_unlock(&priv->lock);
> -		rtnl_unlock();
> -		return ret;
> +		goto error_unlock;
>  	}
> =20
> -	stmmac_init_timestamping(priv);
> +	ret =3D stmmac_init_timestamping(priv);
> +	if (ret)
> +		goto error_stop_dma;

[Severity: High]
Does this introduce a similar issue during system resume?

If stmmac_init_timestamping() returns -EOPNOTSUPP for hardware lacking PTP,
this looks like it will abort the resume process and leave the interface
broken after the system wakes up.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260902-stmmac-est=
-reapply-after-open-v3-0-e72a6df5a7ef@oss.qualcomm.com?part=3D1
