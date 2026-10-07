Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80A613B19CF
	for <bpf@vger.kernel.org>; Wed,  7 Oct 2026 09:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791366311; cv=none; b=d6PBOL4UUMAftUt5Gh0qxblxR97jUKTfy3UqJz2vAowrrY9fGLPvLEgg8qHhp0P92wQ9tdFyU9fJGT/UUKvjQKksoDdH9ecequH11PPP4MCN/FDirJ+a1AvcJ7tNin6vVgcJX49CdAYIlRBwi+P+ZzE4GRS63JDEdlW8OY//pss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791366311; c=relaxed/simple;
	bh=2oC22v6OKQcW/ltW/fz+7NDSkHFzft9fuBdVgQobhMw=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=f23+7/2le7vyhRuHjzEhjw50W/KDDbs1mXF/B0AOOAY4x6Jioxew2QVSlLY0mGB+ZLdebtmaMDcO7XdBZLbXnTFmh2NnU8AYuSOd6snu84pM1g0ySNoWe65C8yTyGnR1f/EMTkMkD1GNNmo9oMj8AdQaPCF9It86hWeZtM/RPEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MRycP4Vb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MRycP4Vb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC0381F0089C;
	Wed,  7 Oct 2026 09:45:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791366300;
	bh=MgU+nAU95s7n0ZInRTvfUuiI/6j0ss1ynMGxd+AFfBw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MRycP4VbFvDGnnJeKVgflVe+bZwbxyd0X7nzVsxuOfB5ZJP8AR/Qj8SCk5XyjZmFO
	 JXfMrSgjEH47wiiXrHDfYDstih5WNlvCWYMXF7ugczVgzEU4gddqCsXn9X43ZRZDwo
	 U1Tu9dJZhD472u7Sq31Qg2BrpyT4HNKeMS7HjdhMY0qsYPpbAVIb4zcR+pp/sisJvU
	 K+nTGUtWzaXjnaUKw/hOE0KEhR7M4Vu7HvnIFgR+/srSC3Cw3XlEAFOxrlEQ+PxKtT
	 BXLjIt16RcRDZvo8Gzu8CVb9D5KikhotCtyiVXOb9kRTcIHcBOH3OMKeaiRp9xoxsB
	 /9nu0AMq/DesA==
Message-ID: <sashiko-outbox-162817@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v19 net-next 2/2] octeontx2: add mqprio bandwidth
 offload for NIX TX schedulers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ratheesh Kannoth" <rkannoth@marvell.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20261006094357.840823-3-rkannoth@marvell.com>
References: <20261006094357.840823-1-rkannoth@marvell.com>
 <20261006094357.840823-3-rkannoth@marvell.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 07 Oct 2026 09:45:00 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:
- [High] net: Use-After-Free due to TOCTOU race in workqueue cancellation d=
uring device removal
- [High] tc: heap Out-of-Bounds write in otx2_mqprio_restore_old via XDP de=
tach
- [Medium] net: permanent lock-out of TX queue reduction due to old_mq_snap=
 state leak
- [Medium] tc: otx2_tc_can_offload() incorrectly evaluates hw_features inst=
ead of features
- [Medium] tc: inappropriate use of devm_ allocations for dynamic runtime q=
disc configuration
--

commit 1bd3302261ac3d0844dd5a4c5059dd408da6cacc
Author: Ratheesh Kannoth <rkannoth@marvell.com>
octeontx2: add mqprio bandwidth offload for NIX TX schedulers

This patch adds TC_SETUP_QDISC_MQPRIO offload with TC_MQPRIO_SHAPER_BW_RATE
on PF and VF netdevs. It programs per-queue MDQ CIR/PIR via the NIX TX
scheduler mailbox and reconfigures the netdev to apply the changes.

> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c b/drive=
rs/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
> --- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
> @@ -2924,6 +2935,12 @@ static int otx2_xdp_setup(struct otx2_nic *pf, str=
uct bpf_prog *prog)
>  	bool if_up =3D netif_running(pf->netdev);
>  	struct bpf_prog *old_prog;
> =20
> +	if (prog && pf->mqprio.rate_limit) {
> +		netdev_err(dev,
> +			   "XDP: cannot attach while mqprio bandwidth offload is active\n");
> +		return -EOPNOTSUPP;
> +	}

[Severity: High]
Does this condition inadvertently allow XDP detach to proceed while MQPRIO
is active? If prog is NULL during a detach, this check is bypassed.
Detaching XDP decreases hw.non_qos_queues, which later leads to an
out-of-bounds array access in otx2_mqprio_restore_old() when restoring the
old layout.

> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c b/drive=
rs/net/ethernet/marvell/octeontx2/nic/otx2_tc.c
> --- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c
> @@ -1600,14 +1619,907 @@ static int otx2_setup_tc_block(struct net_device=
 *netdev,
[ ... ]
> +static int otx2_mqprio_alloc_cache(struct otx2_nic *pfvf, bool replacing)
> +{
> +	u16 num_txq =3D pfvf->hw.non_qos_queues;
> +	u64 *min_rate, *max_rate;
[ ... ]
> +	min_rate =3D devm_kcalloc(pfvf->dev, num_txq, sizeof(*min_rate), GFP_KE=
RNEL);
> +	max_rate =3D devm_kcalloc(pfvf->dev, num_txq, sizeof(*max_rate), GFP_KE=
RNEL);

[Severity: Medium]
Are devm_kcalloc() and devm_kfree() appropriate here? Since
otx2_mqprio_alloc_cache() is called during arbitrary runtime configurations
like adding or replacing a qdisc, using devres allocations will repeatedly
append nodes to the device devres list and require O(N) traversals on every
update. Should this use standard kcalloc() instead to tie the cache
lifecycle to the qdisc rather than the device probe/remove lifecycle?

> +static int otx2_mqprio_snap_copy(struct otx2_nic *pfvf,
> +				 struct mq_offload_snap **dst,
> +				 const struct tc_mqprio_qopt_offload *mqprio)
> +{
[ ... ]
> +	if (!*dst) {
> +		snap =3D devm_kzalloc(pfvf->dev, sizeof(*snap), GFP_KERNEL);

[Severity: Medium]
Similar to the rate cache allocations, does this dynamic allocation during
runtime need to use devm_kzalloc()? Repeated qdisc modifications might
endlessly append to the devres list.

> +static void otx2_mqprio_defer_netdev_tc_restore(struct otx2_nic *pfvf)
> +{
> +	if (READ_ONCE(pfvf->mqprio.defer_tc_work))
> +		return;
> +	schedule_work(&pfvf->mqprio.netdev_tc_work);
> +}

[Severity: High]
Could this lockless check introduce a TOCTOU race during device removal? If
the shutdown thread in otx2_shutdown_tc_mqprio() sets defer_tc_work and
calls cancel_work_sync() locklessly exactly after this check evaluates to
false but before schedule_work() runs, the work could be queued after the
cancellation attempt.

> +static int otx2_mqprio_restore_old(struct otx2_nic *pfvf)
> +{
> +	struct mq_offload_snap *snap =3D pfvf->old_mq_snap;
> +	struct net_device *netdev =3D pfvf->netdev;
> +	u16 num_txq =3D pfvf->hw.non_qos_queues;
[ ... ]
> +	for (tc =3D 0; tc < snap->num_tc; tc++) {
> +		u64 min_rate =3D snap->min_rate[tc];
> +		u64 max_rate =3D snap->max_rate[tc];
> +
> +		for (txq =3D snap->offset[tc];
> +		     txq < snap->offset[tc] + snap->count[tc]; txq++) {
> +			pfvf->mqprio.min_rate[txq] =3D min_rate;
> +			pfvf->mqprio.max_rate[txq] =3D max_rate;

[Severity: High]
Could this loop write out-of-bounds into the min_rate and max_rate arrays if
the number of active queues is reduced while MQPRIO is active?

If an XDP program is detached, hw.non_qos_queues shrinks.
otx2_mqprio_alloc_cache() will then allocate smaller arrays based on the
new num_txq count, but this loop restores rates using the old, larger indic=
es
stored in snap->offset and snap->count.

> +static void otx2_mqprio_clear_sw(struct otx2_nic *pfvf)
> +{
> +	struct net_device *netdev =3D pfvf->netdev;
> +
> +	pfvf->mqprio.rate_limit =3D false;
> +	otx2_mqprio_clear_replace_state(pfvf);
> +	if (!otx2_mqprio_keep_netdev_tc(pfvf))
> +		netdev_set_num_tc(netdev, 0);
> +	otx2_mqprio_free_cache(pfvf);
> +}

[Severity: Medium]
Is there a state leak here for pfvf->old_mq_snap? This teardown path clears
the rate cache and resets rate_limit, but it leaves old_mq_snap allocated.
Later, otx2_set_channels() permanently blocks TX queue reduction because
old_mq_snap is still non-NULL, effectively locking users out of modifying
channel counts via ethtool after removing an mqprio qdisc.

> +static bool otx2_tc_can_offload(struct net_device *netdev)
> +{
> +	return !!(netdev->hw_features & NETIF_F_HW_TC);
> +}

[Severity: Medium]
Should this check netdev->features instead of netdev->hw_features? By
evaluating device capabilities rather than the currently enabled features,
this allows mqprio setup to succeed even if the user explicitly disabled
hardware TC offload via ethtool.

> +void otx2_shutdown_tc_mqprio(struct otx2_nic *nic)
> +{
> +	WRITE_ONCE(nic->mqprio.defer_tc_work, true);
> +	/* Publish defer_tc_work before cancel_work_sync(). */
> +	smp_wmb();
> +	cancel_work_sync(&nic->mqprio.netdev_tc_work);
> +	rtnl_lock();

[Severity: High]
This pairs with the lockless check in otx2_mqprio_defer_netdev_tc_restore().
By setting the flag and calling cancel_work_sync() outside of rtnl_lock(),
it leaves a race window where work might be scheduled immediately after
cancellation completes. When the device is later unregistered and freed,
the lingering queued work could execute and trigger a use-after-free on
the freed device structure.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261006094357.8408=
23-1-rkannoth@marvell.com?part=3D2
