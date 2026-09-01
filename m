Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E9C338552C
	for <bpf@vger.kernel.org>; Tue,  1 Sep 2026 13:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788268286; cv=none; b=tXNkI6lgBTeKiURmKHSSNuG41qKHSxve3AKWCLwbJBKrQQpLWYC0s3MCuvVLrg3HOc7aHjg8q/VTNDkPgqZ5KjS4cOM4AIuiD3JaJHdP6DXWpjZprWWEdnQjdo6P9J0DdVpod/yTQEvi1rLKqSEichAQlaa/y7BBnOpTiVRVKkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788268286; c=relaxed/simple;
	bh=Gd2bpJk1wJf+OkTxQ+bj3nV97uII/AZ+Q9XOB9fExp0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=dXnGagof2WXzeWT0srikf9q68Q6Jp/heFyhiSWhoUckO4lxQklTYC4vl0t6IrQ8BqYekzRebpb5jCXczAnCYUHGVeahjSp0POaKqguSSQbwAr9rNCVbg27avl3PCWlkjQ5fVNzdo7KfJjsequx/g3M/qUUegix4tZBYM9vDz82E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hGsyg2uX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hGsyg2uX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 626A71F00ADB;
	Tue,  1 Sep 2026 13:11:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788268284;
	bh=lbV36oYiPadjYvftPDnbbVUSXODy5Gm1OSShgSh9nJc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hGsyg2uX9TZ/AA6AR8CzjwDr6fxEsWm0I7mFR20N3KNknOlF4+H1HwLbZ0sg/uHy/
	 mYGUU8OGu+Wsn8ZCvW3z3IF/FnBt6Sx2eVGgHLXeg5JFpBaTwqFvl6rSfKgtx09Px6
	 oitdtY2/vGpP/wgJ9kgQ4F0u4nmDcudXUQ37Zpzolmi3SNSIcN8wdXKML7jIVXLhuh
	 hRDT0P+TjiSkO6c06C61kd5i4LF2aqKGY0kqckXQSkmOYN3+xsDHPdWZRnuWeSXHkg
	 61mfKc/cQOkYd/jXlrCgOBCQUk4f8MBUCSc+ses+qC3xjC+HXaJG3MsSMBrQVXYFwt
	 kdi6L6vD0Brhg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 net-next 2/2] octeontx2-pf: add mqprio bandwidth
 offload for NIX TX schedulers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ratheesh Kannoth" <rkannoth@marvell.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260831131014.2639581-3-rkannoth@marvell.com>
References: <20260831131014.2639581-1-rkannoth@marvell.com>
 <20260831131014.2639581-3-rkannoth@marvell.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 01 Sep 2026 13:11:23 +0000
Message-Id: <20260901131124.626A71F00ADB@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:
- [High] otx2_nix_tm_set_queue_shaper and otx2_nix_tm_clear_queue_shaper se=
t the mailbox level to NIX_TXSCH_LVL_MDQ while using SMQ indices, leading t=
o guaranteed AF driver validation failures.
- [High] A failure during initial mqprio setup bypasses hardware error clea=
nup, leaving the device in an inconsistent state.
- [High] A successful `tc qdisc replace` with an identical handle is mistak=
enly identified as a failure rollback, reverting the hardware configuration.
- [Medium] Failed mqprio replace permanently disables bandwidth offload bec=
ause the rollback path fails to restore `pfvf->mqprio.rate_limit`.
- [Medium] Memory allocation failure during qdisc deletion aborts teardown,=
 leaking active hardware shapers.
--

commit 3ab815bb73b8a877ec97fa639742f0ab5d81b757
Author: Ratheesh Kannoth <rkannoth@marvell.com>

octeontx2-pf: add mqprio bandwidth offload for NIX TX schedulers

This commit adds TC_SETUP_QDISC_MQPRIO handling for channel-mode mqprio with
TC_MQPRIO_SHAPER_BW_RATE. It enables shaping each non-QoS transmit queue by
programming MDQ CIR/PIR on hw.non_qos_queues.

> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c b/d=
rivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
> --- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
> @@ -615,6 +615,142 @@ void otx2_get_mac_from_af(struct net_device *netdev)
>  }
>  EXPORT_SYMBOL(otx2_get_mac_from_af);
> =20
> +static int
> +otx2_nix_tmq_reg_write(struct otx2_nic *pfvf, int cnt,
> +		       u64 reg_addr[MAX_REGS_PER_MBOX_MSG],
> +		       u64 reg_val[MAX_REGS_PER_MBOX_MSG])
> +{
> +	struct mbox *mbox =3D &pfvf->mbox;
> +	struct nix_txschq_config *req;
> +	int i, err;
> +
> +	mutex_lock(&mbox->lock);
> +	req =3D otx2_mbox_alloc_msg_nix_txschq_cfg(mbox);
> +	if (!req) {
> +		mutex_unlock(&mbox->lock);
> +		return -ENOMEM;
> +	}
> +
> +	req->lvl =3D NIX_TXSCH_LVL_MDQ;

[Severity: High]
Will this cause the AF driver to reject the configuration mailbox messages?

In otx2_nix_tm_set_queue_shaper(), the MDQ register addresses are computed
using the SMQ index. The AF driver's validation function extracts the
index from the register address and validates it against the bounds of the
NIX_TXSCH_LVL_MDQ pool, which has a different size than the SMQ pool.

[ ... ]
> +int otx2_nix_tm_set_queue_shaper(struct otx2_nic *pfvf,
> +				 int txq, u64 minrate, u64 maxrate)
> +{
[ ... ]
> +	req->lvl =3D NIX_TXSCH_LVL_MDQ;

[Severity: High]
Similar to the concern above, setting the mailbox level to NIX_TXSCH_LVL_MDQ
inline here while relying on SMQ indices appears to guarantee AF driver
validation failures during any qdisc add operation.

> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c b/drive=
rs/net/ethernet/marvell/octeontx2/nic/otx2_tc.c
> --- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c
[ ... ]
> +static int otx2_mqprio_restore_old(struct otx2_nic *pfvf)
> +{
[ ... ]
> +	if (otx2_mqprio_mdq_allocated(pfvf)) {
> +		err =3D otx2_nix_tm_clear_queue_shaper(pfvf);
> +		if (err)
> +			return err;
> +	}
> +
> +	err =3D otx2_mqprio_up(pfvf);
> +	if (err)
> +		return err;

[Severity: Medium]
Does this rollback path permanently disable bandwidth offload?

If an ndo_open() failure occurs during tc qdisc replace,
otx2_mqprio_restart_netdev() explicitly clears pfvf->mqprio.rate_limit to
false. Here in otx2_mqprio_restore_old(), the rate_limit flag is not set
back to true before calling otx2_mqprio_up(). As a result, otx2_mqprio_up()
will exit early without configuring the hardware shapers.

[ ... ]
> +static int otx2_teardown_tc_mqprio(struct otx2_nic *pfvf,
> +				   struct tc_mqprio_qopt_offload *mqprio)
> +{
> +	bool had_mqprio =3D pfvf->mqprio.rate_limit;
> +	struct tc_mqprio_qopt *qopt =3D &mqprio->qopt;
> +	struct net_device *netdev =3D pfvf->netdev;
> +	bool if_up =3D netif_running(netdev);
> +	bool rollback;
> +	int err;
> +
> +	qopt->hw =3D 0;
> +
> +	/* tc qdisc replace runs setup on the new mqprio before destroying the
> +	 * old one. Ignore teardown from the replaced instance once the new
> +	 * handle is committed in otx2_setup_tc_mqprio().
> +	 */
> +	if (mqprio->handle && mqprio->handle !=3D pfvf->mqprio.handle) {
> +		if (pfvf->cur_mq_snap)
> +			otx2_mqprio_snap_commit(pfvf);
> +		return 0;
> +	}

[Severity: High]
If a fresh qdisc add fails halfway through (for example, during
otx2_nix_tm_set_queue_shaper), could this bypass hardware cleanup?

During a failed initial setup, pfvf->mqprio.handle would still be 0, while
the incoming mqprio->handle from the generic TC layer is non-zero. This
condition would evaluate to true, treating the failure as a post-replace
teardown and returning 0 without performing the actual cleanup.

> +
> +	if (mqprio->handle && mqprio->handle =3D=3D pfvf->mqprio.handle &&
> +	    pfvf->old_mq_snap) {
> +		rollback =3D pfvf->cur_mq_snap;
> +
> +		err =3D otx2_mqprio_restore_old(pfvf);
> +		if (err)
> +			return err;

[Severity: High]
Could this inadvertently trigger a rollback during a successful tc qdisc
replace?=20

If the user issues a replace command utilizing the exact same handle as the
existing qdisc, this condition evaluates to true and appears to call
otx2_mqprio_restore_old(), overriding the newly installed configuration with
the old one.

[Severity: Medium]
If memory allocation fails during a qdisc deletion, will this leak the acti=
ve
hardware shapers?

When deleting a qdisc, the code falls into this block because the handles
match and old_mq_snap exists. It then calls otx2_mqprio_restore_old(), which
uses devm_kcalloc(). If that allocation fails, the function returns early
here, completely bypassing the actual hardware teardown in otx2_mqprio_down=
().

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831131014.2639=
581-1-rkannoth@marvell.com?part=3D2
