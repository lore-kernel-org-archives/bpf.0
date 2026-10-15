Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF0FD33F58D
	for <bpf@vger.kernel.org>; Thu, 15 Oct 2026 02:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792031738; cv=none; b=jfX8lHdJXWUw32yNjeuClgajZ9ArH6AYS5HV3ZdgyxJ+IY4ePycGFX21P9VuW8VwevJwzpLA162gayh/Lrp8M0qeuzsZ6UQxcaP8IGsbx6Yy5RwwW88h3nmFYu13eFTBsXpHi5gnDWW6ZariA2y1t1m+37Lh2UBkdvMW8eN74VU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792031738; c=relaxed/simple;
	bh=h1GkGWb2EYTqF04dwMe6I5mXO/832cqbtmVoRtVhwxI=;
	h=Message-ID:From:Subject:To:In-Reply-To:References:Content-Type:
	 Date; b=mMOu11yC2EJCyCd6JkKB5yAHKXTmYHX7MbKFQE9Wt3OxqU0FpGnoT+ArXEKuP3tkfYpskCOM5tlxFFtHzDPH+sC3s35oaluOnWBeZUyU+nBAG6eRELBsofzjchs2iS+VyoyWM3zLJ4P2nbW4bUm2GdqkqPMhIxFrBlz+OteGcSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CjjADsEB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CjjADsEB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3435C1F000C5;
	Thu, 15 Oct 2026 02:35:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792031736;
	bh=3Y09eRs/swjXtb9KsQV++pC3dSnZ8NOGApf/rtDW2rY=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=CjjADsEBCoglDRBQc+SPjdVhTZYRf9LDQh+tWeV+SqZVrnmotfGMfeZOf94Tn/9rf
	 yW6DDMQGTbmVT3a21OIju63c6CEhMlvR9eMJc8QwQMdoL1vgVZdCNYhyjVVzHaeXPX
	 VS/F1GgVr38eRf/VDLbjz7cka/zyBTP8wvTBEzxpY2Pw1ta716spxo0E/BjgYYjQ1I
	 8K7gRNeg7RKQ+/zQibxeIcHlK8fwzplRRrfcOvaI+Lp80ggXbjl53vHLERybmTSus2
	 HLT3YwnDoV3ERbo3+Bo81o6DtwU67kBPDBnK5kwutVOFGfOSZ+X0Igl8jSX8f9FoGD
	 IFxP/UWSB6iTA==
Message-ID: <sashiko-outbox-172160@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v20 net-next 2/2] octeontx2: add mqprio bandwidth
 offload for NIX TX schedulers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ratheesh Kannoth" <rkannoth@marvell.com>, bpf@vger.kernel.org
In-Reply-To: <20261014023431.1775238-3-rkannoth@marvell.com>
References: <20261014023431.1775238-1-rkannoth@marvell.com>
 <20261014023431.1775238-3-rkannoth@marvell.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 15 Oct 2026 02:35:35 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] net/octeontx2: incomplete mqprio teardown on shaper clear failure
--

commit eaf43a97d16b9d31a19d30a97316304bd2d66c74
Author: Ratheesh Kannoth <rkannoth@marvell.com>
Subject: octeontx2: add mqprio bandwidth offload for NIX TX schedulers

This commit adds TC_SETUP_QDISC_MQPRIO offload with TC_MQPRIO_SHAPER_BW_RATE
on PF and VF netdevs. It programs per-queue MDQ CIR/PIR via the NIX TX
scheduler mailbox and handles live reprogramming by bouncing the netdev.

> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c b/drive=
rs/net/ethernet/marvell/octeontx2/nic/otx2_tc.c
> index 8877af348a090..b34a86259e786 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c
[ ... ]
> @@ -1886,6 +1886,22 @@ static void otx2_mqprio_clear_sw(struct otx2_nic *=
pfvf)
> +int otx2_mqprio_down(struct otx2_nic *pfvf)
> +{
> +	int err =3D 0;
> +
> +	if (!pfvf->mqprio.rate_limit)
> +		return 0;
> +
> +	if (netif_running(pfvf->netdev) &&
> +	    otx2_mqprio_mdq_allocated(pfvf))
> +		err =3D otx2_nix_tm_clear_queue_shaper(pfvf);
> +
> +	/* The core cannot veto qdisc teardown, so always release software
> +	 * state.  The netdev restart that follows reallocates the TX
> +	 * scheduler, which drops any shaper left programmed.
> +	 */
> +	if (err)
> +		netdev_warn(pfvf->netdev,
> +			    "mqprio: failed to clear hardware shapers: %d; releasing offload =
state\n",
> +			    err);
> +
> +	otx2_mqprio_clear_sw(pfvf);
> +
> +	return err;
> +}
[ ... ]
> @@ -2012,6 +2013,17 @@ static int otx2_teardown_tc_mqprio(struct otx2_nic=
 *pfvf,
> +	if (if_up) {
> +		err =3D otx2_mqprio_down(pfvf);
> +		if (err) {
> +			if (extack)
> +				NL_SET_ERR_MSG_FMT_MOD(extack,
> +						       "mqprio: teardown incomplete (%d)",
> +						       err);
> +			netdev_err(netdev,
> +				   "mqprio: offload teardown incomplete (%d); driver state may not m=
atch removed qdisc\n",
> +				   err);
> +			return err;

[Severity: Medium]
Will this early return on error bypass the required netdev restart?

If otx2_nix_tm_clear_queue_shaper() fails inside otx2_mqprio_down(), the
software state is cleared via otx2_mqprio_clear_sw(), but returning
here skips otx2_mqprio_restart_netdev().=20

This seems to leave the hardware and software states permanently
desynchronized. The hardware would continue applying mqprio topology and
bandwidth shaping while the software state considers it disabled. Since
the comment in otx2_mqprio_down() states that the netdev restart that
follows will reallocate the tx scheduler and drop any shaper left
programmed, skipping the restart appears to contradict the recovery
strategy.

Would it be safer to proceed with the netdev restart even if the hardware
shaper clearing fails?

> +		}
> +
> +		err =3D otx2_mqprio_restart_netdev(netdev, false);
> +		if (err) {

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261014023431.1775=
238-1-rkannoth@marvell.com?part=3D2
