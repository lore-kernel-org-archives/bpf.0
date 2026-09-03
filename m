Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDF61305680
	for <bpf@vger.kernel.org>; Thu,  3 Sep 2026 01:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788400555; cv=none; b=FDOe3JVeGrqVCNVa8XmKH1QWgqzsNPrJIUi6CL5a/LlErchhECrNA4Tfo18egYM1lpU/Svi2sqakWMq0Anm3gYL+hNj3rZevfSYdNLl6MDNoOjr47wO7QKnWyRTjdaB8SjH4U0YwwPNIUIq2Fa7m3kecbAMJ9jaABwtQFF7GCRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788400555; c=relaxed/simple;
	bh=+qkukFSgBputYoSrMxHTvZ5cBGEGGdkUQJct9BMUFQE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Ku0vZ9g0w3FERbV8qoBhhmJFMY78tMAtkWiKF+Vxqyt6uXK9hZ+HG6Kqi+WKTUVGXnl3Pi7n8DBuPEUo4QW400m4N88mvsMew9A05BL2LStEJmfaRFhUcmx4FFMw1YSBmYmrtkFYSTEatalhwrqwzae6U+H40r463X6Q7si+3yI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fb7a1OZk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fb7a1OZk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 696E01F000E9;
	Thu,  3 Sep 2026 01:55:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788400553;
	bh=MfnNhzONlvK9tSib4+4VjQ3TJ70PlwNrDOSBEYPIW84=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Fb7a1OZk30AuG8vf7fHUuEMBFsAOajkXMwPK3855EyIpPN8bEgp3TGuS/G4S8Ezrk
	 3axfkS9OQbNkV0YJtxxP1u86bSjOMnPmszgAlSy+YRPRtbXdR4Ob79WtYre8zSDpae
	 L7eMMHKJKuVGJfUddmQYwxQ2Q+KaQ1qIP32Pn8wd8HoeAqACXOVeO40ei7nZjpmQ2A
	 Virr1Vgx/JcM9hYBfzKG4xIJyIy2NoJXTWgNaD7TlBU7O1vOssppJAvLBhoLCcPn9T
	 33ilSkkXLloQVRNltldsqc8sGrYx5k2to2IB181xGtOugkzzeOsY3TK2X4OzwxvJRz
	 SuikiMWKdcCwg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 net-next] octeontx2-pf: add mqprio bandwidth offload
 for NIX TX schedulers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ratheesh Kannoth" <rkannoth@marvell.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260902015500.2985371-1-rkannoth@marvell.com>
References: <20260902015500.2985371-1-rkannoth@marvell.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 03 Sep 2026 01:55:52 +0000
Message-Id: <20260903015553.696E01F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] Rolling back mqprio configuration after an ndo_open() failure prog=
rams hardware shapers using invalid/freed SMQ indices (SMQ 0).
- [Medium] Early return in otx2_teardown_tc_mqprio() on restore failure lea=
ves stale replace state, hijacking future qdisc operations.
- [Medium] Hardware failure during mqprio teardown abandons software state,=
 causing permanent desynchronization and feature denial.
--

commit 6413eab5a10115c63a46dacd6bbe4921e9bd1678
Author: Ratheesh Kannoth <rkannoth@marvell.com>

octeontx2-pf: add mqprio bandwidth offload for NIX TX schedulers

This commit adds TC_SETUP_QDISC_MQPRIO offload for channel-mode mqprio
with TC_MQPRIO_SHAPER_BW_RATE. It rebuilds the TX scheduler hierarchy
by bouncing the netdev on mqprio add, replace, and delete, and includes
rollback logic using snapshots to recover from setup failures.

> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c b/drive=
rs/net/ethernet/marvell/octeontx2/nic/otx2_tc.c
> index 039fd47ebf522..5efa0b4d27d53 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c
[ ... ]
> +static bool otx2_mqprio_mdq_allocated(struct otx2_nic *pfvf)
> +{
> +	return pfvf->hw.txschq_cnt[NIX_TXSCH_LVL_MDQ] !=3D 0;
> +}
> +
> +static int otx2_mqprio_restore_old(struct otx2_nic *pfvf)
> +{
> +	struct mq_offload_snap *snap =3D pfvf->old_mq_snap;
> +	struct net_device *netdev =3D pfvf->netdev;
> +	u16 num_txq =3D pfvf->hw.non_qos_queues;
> +	int tc, txq, err;
[ ... ]
> +	if (otx2_mqprio_mdq_allocated(pfvf)) {
> +		err =3D otx2_nix_tm_clear_queue_shaper(pfvf);
> +		if (err)
> +			return err;
> +	}

[Severity: High]
When ndo_open() fails and we fall back to otx2_mqprio_restore_old(), will
otx2_mqprio_mdq_allocated() falsely return true here?

It looks like otx2_txschq_stop() frees schedulers and zeroes txschq_list,
but does not zero txschq_cnt. If that happens,
otx2_nix_tm_clear_queue_shaper() will iterate over the non-zero count,
reading smq =3D 0 from the zeroed txschq_list, and send an invalid mailbox
command for SMQ 0. This could abort the configuration rollback or corrupt
hardware state.

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
> +	if (err) {
> +		netdev_err(pfvf->netdev,
> +			   "mqprio: failed to clear hardware shapers: %d; some TX queues may =
retain bandwidth limits\n",
> +			   err);
> +		return err;
> +	}

[Severity: Medium]
If clearing the hardware shapers fails (e.g. due to a transient mailbox
timeout), this early return skips the call to otx2_mqprio_clear_sw(pfvf).

Does this abandon the software state and cause a permanent desynchronizatio=
n?
The driver will retain pfvf->mqprio.rate_limit =3D true while the kernel has
already deleted the qdisc, permanently blocking features like XDP or PFC.

[ ... ]
> +static int otx2_teardown_tc_mqprio(struct otx2_nic *pfvf,
> +				   struct tc_mqprio_qopt_offload *mqprio)
> +{
> +	bool had_mqprio =3D pfvf->mqprio.rate_limit;
> +	struct tc_mqprio_qopt *qopt =3D &mqprio->qopt;
> +	struct net_device *netdev =3D pfvf->netdev;
> +	bool if_up =3D netif_running(netdev);
> +	int err;
> +
> +	qopt->hw =3D 0;
> +
> +	/* tc qdisc replace runs setup on the new mqprio before destroying the
> +	 * old one. replace_setup_done and TC_ROOT_GRAFT distinguish stale
> +	 * old-instance teardown from graft failure after setup.
> +	 */
> +	if (pfvf->mqprio.replace_setup_done && pfvf->cur_mq_snap) {
> +		if (pfvf->mqprio.replace_graft_done) {
> +			otx2_mqprio_snap_commit(pfvf);
> +		} else {
> +			err =3D otx2_mqprio_restore_old(pfvf);
> +			if (err)
> +				return err;

[Severity: Medium]
If otx2_mqprio_restore_old() returns an error (such as the SMQ 0 failure
noted above), this early return skips clearing the replace state flags
via otx2_mqprio_clear_replace_state().

Could this leave a stale replace state that permanently hijacks future
qdisc operations and prevents the offload from ever being cleanly torn
down?

> +		}
> +		otx2_mqprio_clear_replace_state(pfvf);
> +		return 0;
> +	}
> +
> +	/* Skip the netdev restart when mqprio offload was not active. */
> +	if (!had_mqprio)
> +		return 0;
> +
> +	if (if_up) {
> +		int down_err, err;
> +
> +		down_err =3D otx2_mqprio_down(pfvf);
> +		err =3D otx2_mqprio_restart_netdev(netdev, false);
> +		if (err)
> +			return err;
> +		return down_err;
> +	}

[Severity: Medium]
Following up on the issue in otx2_mqprio_down() above, if that function
fails and doesn't clear the software state, we then call
otx2_mqprio_restart_netdev(netdev, false).

Since the rate_limit flag is still true in the uncleared software state,
won't this netdev restart accidentally restore the hardware offload that
was just torn down by the kernel?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260902015500.2985=
371-1-rkannoth@marvell.com?part=3D1
