Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 955393AAF68
	for <bpf@vger.kernel.org>; Tue, 18 Aug 2026 03:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787023726; cv=none; b=F0JH+DjSiXc2DoqbcTQr2XkIdFqGqOUkwmFB+/gGDJozB4SzRPtxvcc9pmOnA7c1ex75zvkFelT7oVtywMrAZkfIEJtFXrw5ISFFsrpTjwyGIV//b5njVlMD/DUMBAd8CGIEFxuFRzF8yzqZwBf4EbVFYfUPFmeVdDIQd2t6cZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787023726; c=relaxed/simple;
	bh=PLqG9S0QtFXsRHstXjLOLNOzbnPaTXeumHHsJqOWSZY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=p+y0k0GnsdLA/Yvz34HvKKu8M30PBn01oJDMEGpadhsiO0umnTes4DU0A4yfe8yfyjUK0oiWZ23h4Bz0uHDA+qljVBlwJIEsfHmIPK5OE628LqoK3Nl32nYNLFyefeUdgTzD35oIyZbWPltW1vF+2YNqkI3IYwQWmB1LnioZwn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KCsVIdd8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KCsVIdd8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1ACAD1F000E9;
	Tue, 18 Aug 2026 03:28:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787023724;
	bh=c7bFNfPnpDjcR9k/0cXzxGUpdo7G2xO0MpJ0PJlN6D4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KCsVIdd8DM2zpDIeST7jIei24gmibxMdhkcMgnFeRG+FRsAnh5l7Of9V5a38aNDq9
	 R7A+0J3d6kz/u4iiIGT3s3DuU5XiZdNxeelbbh0RTT6A3sw7AeEhMJSaYK8trdLMEx
	 ALZNZwR+oe9/5fLzROeC5QZLXLtov34tPXePhVcbDFcnVFw5TJF9w9pSTu3zsWC6IY
	 NANoJHYe6uTUS7gWQ9mK6c+KBsN/Yx4DQ2NlTdvgVrcH+dH5T026hvuLnsS3dagfb3
	 rk8angmbhZwiRc77N26TxbIPsXQi1NbcffXL/KtD2nSNpAkYXvVR2REN4qpPSeDqum
	 c1eg7EGuVV9nQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 net-next] octeontx2-pf: add mqprio bandwidth offload
 for NIX TX schedulers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ratheesh Kannoth" <rkannoth@marvell.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260817032747.1765883-1-rkannoth@marvell.com>
References: <20260817032747.1765883-1-rkannoth@marvell.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 18 Aug 2026 03:28:43 +0000
Message-Id: <20260818032844.1ACAD1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:

New issues:
- [High] tc qdisc replace operations result in irretrievable state desynchr=
onization and data loss on failure or kernel rejection.
- [High] otx2_mqprio_down drops software state unconditionally, causing sta=
te desynchronization if clearing hardware shapers fails.
- [High] Network interface becomes permanently unusable if otx2_mqprio_up f=
ails during otx2_open.
- [Medium] Error path in otx2_mqprio_restart_netdev attempts to configure h=
ardware shaping on freed TX scheduler queues.

Pre-existing issues:
- [High] Stale TL4 topology from HTB teardown persists and can silently sta=
rve MQPRIO transmit queues.
--

--- Patch [1]: [PATCH v9 net-next] octeontx2-pf: add mqprio bandwidth offlo=
ad for NIX TX schedulers ---
commit 21ed8a8824a04ea734aff8a63ea014ef8f15499f
Author: Ratheesh Kannoth <rkannoth@marvell.com>
Subject: octeontx2-pf: add mqprio bandwidth offload for NIX TX schedulers

This commit adds TC_SETUP_QDISC_MQPRIO handling for channel-mode mqprio
with TC_MQPRIO_SHAPER_BW_RATE. It enables offloading programs for
per-transmit-queue MDQ CIR/PIR shapers on non-QoS queues.

> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c b/d=
rivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
> --- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c

[ ... ]

> @@ -786,7 +786,20 @@ int otx2_txschq_config(struct otx2_nic *pfvf, int lv=
l, int prio, bool txschq_for
>  		req->num_regs++;
>  		/* MDQ config */
> -		parent =3D schq_list[NIX_TXSCH_LVL_TL4][prio];
> +		if (pfvf->mqprio.rate_limit) {
> +			/* TODO: Not an mqprio bug - stale TL4 topology is left when
> +			 * HTB is torn down without clearing NIX_AF_TL4X_TOPOLOGY;
> +			 * the AF does not reset it on schq realloc. MQPRIO parents
> +			 * every MDQ under TL4[0] with schedule priority 0, so a
> +			 * reused TL4 can retain HTB RR_PRIO/PRIO_ANCHOR and starve
> +			 * some TX queues until topology is reprogrammed here or HTB
> +			 * teardown is fixed to restore defaults.
> +			 */
> +			parent =3D schq_list[NIX_TXSCH_LVL_TL4][0];
> +		} else {
> +			parent =3D schq_list[NIX_TXSCH_LVL_TL4][prio];
> +		}

[Severity: High]
This isn't a bug introduced by this patch, but does reusing the TL4 node
here without clearing the stale NIX_AF_TL4X_TOPOLOGY configuration left
behind by HTB cause MQPRIO transmit queues to be unexpectedly starved?

When the HTB qdisc offload is torn down, the driver fails to reset the
NIX_AF_TL4X_TOPOLOGY register. If MQPRIO is subsequently enabled, it
explicitly parents all its MDQs under TL4[0]. Since TL4[0] was not reset,
it retains the stale RR_PRIO or PRIO_ANCHOR settings from HTB, which could
incorrectly affect the newly attached MQPRIO queues.

[ ... ]

> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c b/drive=
rs/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
> --- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c

[ ... ]

> @@ -1980,6 +1980,16 @@ int otx2_open(struct net_device *netdev)
>  	if (err)
>  		goto err_free_mem;
> =20
> +	/* TODO: otx2_mqprio_up() failure here aborts the entire ndo_open()
> +	 * path even though mqprio_rate_limit and the rate cache remain set.
> +	 * Routine ip link set up or driver reset with active mqprio offload
> +	 * can leave the interface stuck down until the qdisc is removed and
> +	 * reapplied.
> +	 */
> +	err =3D otx2_mqprio_up(pf);
> +	if (err)
> +		goto err_free_hw;

[Severity: High]
Does a failure here leave the network interface permanently unusable?

If otx2_mqprio_up() encounters an error during otx2_open(), the driver
aborts the interface open and tears down hardware resources via
err_free_hw. However, it fails to clear pfvf->mqprio.rate_limit and the
rate caches.=20

Any subsequent attempts to bring the interface up will blindly call
otx2_mqprio_up() again, leaving the interface stuck in an administratively
down state until the qdisc is manually removed.

[ ... ]

> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c b/drive=
rs/net/ethernet/marvell/octeontx2/nic/otx2_tc.c
> --- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c

[ ... ]

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
> +	if (err)
> +		netdev_err(pfvf->netdev,
> +			   "mqprio: failed to clear hardware shapers: %d; some TX queues may =
retain bandwidth limits\n",
> +			   err);
> +
> +	/* TODO: mqprio_down() clears mqprio_rate_limit, netdev TC mappings,
> +	 * and the rate cache even when otx2_nix_tm_clear_queue_shaper() fails
> +	 * partway through the MDQ batch. Software then reports offload as
> +	 * inactive while some queues may retain programmed CIR/PIR, so a later
> +	 * mqprio_up() or re-setup can shape with the wrong effective rates.
> +	 */
> +	otx2_mqprio_clear_sw(pfvf);
> +
> +	return err;
> +}

[Severity: High]
Can clearing the software state unconditionally here lead to silent,
persistent rate limiting if clearing the hardware shapers fails?

If a user deletes the MQPRIO qdisc or an error triggers otx2_mqprio_down(),
and the hardware mailbox communication fails in
otx2_nix_tm_clear_queue_shaper(), the function logs an error but still
calls otx2_mqprio_clear_sw().=20

This completely wipes the driver's software state, making it impossible to
clear the hardware limits in subsequent operations while the hardware
shapers remain active.

[ ... ]

> +static int otx2_mqprio_restart_netdev(struct net_device *netdev, bool ra=
te_limit)
> +{

[ ... ]

> +	err =3D ops->ndo_open(netdev);
> +	if (err) {
> +		int down_err;
> +
> +		netdev_err(netdev,
> +			   "Failed to restart device after mqprio change: %d\n",
> +			   err);
> +		down_err =3D otx2_mqprio_down(pfvf);

[Severity: Medium]
Does this error path attempt to configure hardware shaping on freed TX
scheduler queues?

If ops->ndo_open() fails, the error path executes otx2_free_hw_resources(),
which frees the TX schedulers. It then calls otx2_mqprio_down() here, which
sees netif_running() as true (because dev_close was skipped) and attempts
to send mailbox messages to clear the shapers on the now-freed queues.=20
The AF rejects these messages, resulting in spurious firmware errors.

[ ... ]

> +static int otx2_setup_tc_mqprio(struct net_device *netdev,
> +				struct tc_mqprio_qopt_offload *mqprio)
> +{

[ ... ]

> +cleanup:
> +	/* Clear hardware offload on this rejected request so a failed replace
> +	 * does not leave tc reporting offload for driver state that was torn
> +	 * down while the previous mqprio remains grafted.
> +	 */
> +	qopt->hw =3D 0;
> +	if (replacing) {
> +		otx2_mqprio_replace_failed_msg(netdev, extack);
> +		pfvf->mqprio_replace_pending =3D false;
> +		return err ? err : -EIO;
> +	}

[Severity: High]
Does this cleanup path fail to roll back hardware and software state to the
old qdisc's configuration if a tc qdisc replace operation fails?

During a qdisc replace, otx2_mqprio_alloc_cache() is called earlier which
immediately frees the old rate cache. If hardware programming fails, or if
the kernel later rejects the qdisc before grafting, this cleanup path
explicitly skips hardware and cache rollback.=20

The kernel retains the old qdisc, but the driver uses the new configuration
or zeroes, leading to state desynchronization and incorrect bandwidth
shaping. A similar bypass happens in otx2_teardown_tc_mqprio() when
pfvf->mqprio_replace_pending is true, leaving the rejected config active.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260817032747.1765=
883-1-rkannoth@marvell.com?part=3D1
