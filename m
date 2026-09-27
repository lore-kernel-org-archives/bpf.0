Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E747B2E92B3;
	Sun, 27 Sep 2026 15:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790524207; cv=none; b=NgzpDxKIiMDt1oHNuyL8HISbSkRO4T5cMCObCPRxIjHhrxgRKVrp4AivC47rj0NbYI86qOmesmiinYQ1R2AndnWUVe2osuWmZMXq/jGRRuGeu4vPUHj76Ig+KM35bOwvirZf3/PlPUk3Psg92xNdSe594NJowKBgT63sG6dUT/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790524207; c=relaxed/simple;
	bh=kMHMvYsOYyURgJnZ51FiM/O9pbBxT7cGgsS99iHcpos=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=cCBOvMZBD+HrJt6ksJlXEd2SIs7NPBja2v0tx8khvKFCJ5M3xzM9vpXMRY/JoxeUwztRqfk9yOYhag8ZvfZkv5PL+ARKZVxBmQyuf7Dkvz0PgWOE1met1vI5tmO3YrHEmt1p/flCIb/wxZUcSRaUiAPCfDryWJ7xM6GBmON1igg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YAw2MdcG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YAw2MdcG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D1FA1F00893;
	Sun, 27 Sep 2026 15:50:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790524205;
	bh=vfPAAm2fRHGIv8nJIKeFZ/5AgGoyxyLCQC9UidiHY2E=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YAw2MdcG8/vP1y/jPfGzxQBXcVfRB7VM0w8kd1GBPJN2nngxd35Q2q/ioADJLMU8p
	 1cmYQK+isHPdQQYuGRXKnhSbcLMULLHdMXkbDuM+IQPBhjQD3DfiRrVfdbZzZxpsGq
	 2OZJBPQFfJPYC7S1gxUspysxspJYenZO/X2o5F7dGHTXWDHcQHfmUSgm5RkEqrn9qG
	 yVYKz9Vaye8w5Gu/ECWQRR0MBbzct0dPMtQwJdlgez0hNE17FfpFT4g340XT9DQ9A+
	 +acW88KhnSPEh7icN2gRqV2fNB1Trf/rUN/bam0S4A0x9BGf+j9A8U1GDZMuX4Ua/Y
	 cOaTGHW1wfMSg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v4 05/15] net: stmmac: serialize and retain PHC
 configuration across reset
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Hilliard" <james.hilliard1@gmail.com>
Cc: linux-sunxi@lists.linux.dev, bpf@vger.kernel.org
In-Reply-To: <20260926-submit-stmmac-reset-fixes-v1-v4-5-ec1c0250b3c9@gmail.com>
References: <20260926-submit-stmmac-reset-fixes-v1-v4-0-ec1c0250b3c9@gmail.com>
 <20260926-submit-stmmac-reset-fixes-v1-v4-5-ec1c0250b3c9@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 27 Sep 2026 15:50:05 +0000
Message-Id: <20260927155005.9D1FA1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] net: stmmac: divide by zero in stmmac_ptp_restore() on single-shot=
 PEROUT
- [Medium] net: stmmac: frequency adjustment lost in stmmac_dl_ts_coarse_se=
t()
--

commit 04a85bc09b8c93cccea45ce07b1d943738de8a9b
Author: James Hilliard <james.hilliard1@gmail.com>
Subject: net: stmmac: serialize and retain PHC configuration across reset

This commit retains PHC configuration such as frequency correction, PEROUT
requests, and EXTTS selection across hardware resets. It serializes
timestamp writers and devlink mode updates using a new mutex, and adds a
common replay helper for reset transactions.

> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/=
net/ethernet/stmicro/stmmac/stmmac_main.c
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
[ ... ]
> @@ -7708,6 +7722,8 @@ static int stmmac_dl_ts_coarse_set(struct devlink *=
dl, u32 id,
>  	 * reconfigure the systime, subsecond increment and addend.
>  	 */
>  	stmmac_update_subsecond_increment(priv);
> +	write_unlock_irqrestore(&priv->ptp_lock, flags);
> +	mutex_unlock(&priv->ptp_mutex);
> =20
>  	return 0;
>  }

[Severity: Medium]
Does this code lose the currently active frequency adjustment when the devl=
ink
coarse mode is changed?

When a user sets the devlink phc_coarse_adj parameter,
stmmac_dl_ts_coarse_set() calls stmmac_update_subsecond_increment().
Looking at stmmac_update_subsecond_increment(), it reconfigures the hardware
with priv->default_addend without accounting for the active adjustment:

stmmac_update_subsecond_increment() {
    ...
    priv->default_addend =3D div_u64(temp, priv->plat->clk_ptp_rate);
    stmmac_config_addend(priv, priv->ptpaddr, priv->default_addend);
}

Since it does not reapply the cached priv->ptp_scaled_ppm, would this cause
the hardware to run unadjusted while the cached ptp_scaled_ppm implies to
the PTP daemon that an active adjustment is still present?

> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c b/drivers/n=
et/ethernet/stmicro/stmmac/stmmac_ptp.c
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c
[ ... ]
> +int stmmac_ptp_restore(struct stmmac_priv *priv)
> +{
[ ... ]
> +	for (i =3D 0; !ret && i < STMMAC_PPS_MAX; i++) {
> +		struct stmmac_pps_cfg cfg =3D priv->pps[i];
> +
> +		if (!(priv->ptp_perout & BIT(i)))
> +			continue;
> +		stmmac_get_systime(priv, priv->ptpaddr, &ns);
> +		period =3D timespec64_to_ns(&cfg.period);
> +		/* Retain phase, but move an expired target into the future. */
> +		cfg.start =3D stmmac_calc_tas_basetime(timespec64_to_ktime(cfg.start),
> +						     ns + PTP_SAFE_TIME_OFFSET_NS, period);

[Severity: High]
Can this cause a division by zero panic when restoring a single-shot PEROUT
request?

If a user configures a single-shot PTP PEROUT pulse, its period is 0.
When a MAC reset occurs later (such as an MTU change), stmmac_ptp_restore()
attempts to replay the PEROUT request and passes the period (0) as the
cycle_time argument to stmmac_calc_tas_basetime().

Looking at stmmac_calc_tas_basetime() in stmmac_tc.c:

struct timespec64 stmmac_calc_tas_basetime(...) {
    ...
    } else {
        s64 n;
        ktime_t base_time;

        n =3D div64_s64(ktime_sub_ns(current_time, old_base_time),
                      cycle_time);

If the target time is in the past, taking this else branch with
cycle_time =3D 0 will trigger a 64-bit divide error. Should single-shot
requests skip this phase recalculation?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260926-submit-stm=
mac-reset-fixes-v1-v4-0-ec1c0250b3c9@gmail.com?part=3D5
