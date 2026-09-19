Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25612395ADE
	for <bpf@vger.kernel.org>; Sat, 19 Sep 2026 02:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789783217; cv=none; b=uysU7EGjpXLg8mPanccFl7KOfnrd0WgA1DP/TytmR0WItr/zPos/2VXQZU25aCpDIkyIFgqm8ULi8oaNl8llvJlJq5axcQCQrk8MH7G2hAmx1Bx83kiyiluIy8kznS7hC2qQw2HNO0PyiveOnaIe77aLuphpcm+n1/KryU2V4ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789783217; c=relaxed/simple;
	bh=wyw+b1er/SxYHoduAcWaAmQV8lX57flossZ8SGtCdQI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=f2wILGNZsQ/b0PuQGhjD9wbEKSf3Si7KcOOZyogu9lirSheOtVc66ZVnu+bcch1nADMbSQIKzaeavDJ5fkClpbVO0dicFkEjfhEoXms7ymDl/GWSZhnYsJODTyC2g9J8gzgwljIwtn+1bmZ9tv6GvGMa4c+F954aW3EXBAbKCA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rg/rI8qn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rg/rI8qn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95B401F000FF;
	Sat, 19 Sep 2026 02:00:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789783215;
	bh=1F7gHY8sPVrXLMtEzEarN1p4VvcpVEKhD8Xl5juup34=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Rg/rI8qn2+eoGlpEsUwoXcRLWva3QM5PXtxQUWkcngsGqrW4Fmz9zguHfRG2lA+qV
	 dnTn0e1n7784jgKDjHc6/uQcPf1PeZc+InJG4z4Dd6kzdb/iIxO7iWmkLAaZSLaMWE
	 g/8jGl74dcpENxNpGb//qadKe0lkLF0nly0SnDXW4qH7bLiXQNeT6nglr5KihshBVd
	 IgzbT1gJpHt1Cb+gkJg/I/XbN1rO5zk1Xq7zy1oJPsxkeAZS3DfFPxcxmWt8rI5GPk
	 c39NTJ1OCj3TiN7qBRA0OljK4/dg97wK6a6V3hlWXcSyeM3NSaTn85AVt2BwMzMVXZ
	 1FQBudBZyl5VA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v16 net-next 2/2] octeontx2-pf: add mqprio bandwidth
 offload for NIX TX schedulers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ratheesh Kannoth" <rkannoth@marvell.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260918015906.1255204-3-rkannoth@marvell.com>
References: <20260918015906.1255204-1-rkannoth@marvell.com>
 <20260918015906.1255204-3-rkannoth@marvell.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 19 Sep 2026 02:00:15 +0000
Message-Id: <20260919020015.95B401F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] net: octeontx2: TOCTOU race in otx2_mqprio_netdev_tc_work() appl=
ies stale TC map
- [Medium] net: octeontx2: Fragile error rollback in otx2_mqprio_restore_ol=
d() risks ENOMEM
--

commit 422c585ce4a53f6ab1d9b75ad9b1360545a98293
Author: Ratheesh Kannoth <rkannoth@marvell.com>

octeontx2-pf: add mqprio bandwidth offload for NIX TX schedulers

Adds TC_SETUP_QDISC_MQPRIO offload for channel-mode mqprio with rate shaping
on PF and VF RVU netdevices. It programs per-queue MDQ CIR/PIR for non-QoS
transmit queues via the NIX TX scheduler mailbox and bounces the netdev to
rebuild the TX scheduler hierarchy on configuration changes.

> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c b/drive=
rs/net/ethernet/marvell/octeontx2/nic/otx2_tc.c
> index ddb46b580c3b6..edd7c02efb47f 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c
[ ... ]
> @@ -1600,14 +1620,802 @@ static int otx2_setup_tc_block(struct net_device=
 *netdev,
[ ... ]
> +static void otx2_mqprio_netdev_tc_work(struct work_struct *work)
> +{
> +	struct otx2_mqprio *mqprio =3D container_of(work, struct otx2_mqprio,
> +						  netdev_tc_work);
> +	struct otx2_nic *pfvf =3D container_of(mqprio, struct otx2_nic, mqprio);
> +
> +	if (!pfvf->mqprio.rate_limit || !pfvf->old_mq_snap)
> +		return;
> +
> +	rtnl_lock();
> +	otx2_mqprio_apply_snap_netdev(pfvf->netdev, pfvf->old_mq_snap);
> +	rtnl_unlock();
> +}

[Severity: Medium]
Could this lead to a race condition against a concurrent tc qdisc deletion?

In otx2_mqprio_netdev_tc_work, the shared state pfvf->mqprio.rate_limit is
evaluated outside the rtnl_lock, but the state application is done inside i=
t.
When an mqprio replace operation fails, it schedules this workqueue to
asynchronously restore the old netdev TC mapping.

If an administrator concurrently issues a tc qdisc del, the delete operation
holds rtnl_lock, clears the TC mappings to 0, and disables offload. Meanwhi=
le,
the workqueue thread locklessly checks pfvf->mqprio.rate_limit, finds it
true, and waits for rtnl_lock.

Once the delete finishes, the workqueue acquires the lock and unconditional=
ly
re-applies the old TC mapping onto the now-cleared netdev. This leaves the
netdev's TC routing state incorrectly mapped (num_tc > 0) even after the
mqprio qdisc has been removed, potentially misrouting or dropping traffic.

Should this condition be checked inside the RTNL critical section instead?

[ ... ]
> +static int otx2_mqprio_restore_old(struct otx2_nic *pfvf)
> +{
> +	struct mq_offload_snap *snap =3D pfvf->old_mq_snap;
> +	struct net_device *netdev =3D pfvf->netdev;
> +	u16 num_txq =3D pfvf->hw.non_qos_queues;
> +	int tc, txq, err;
> +
> +	if (!snap)
> +		return 0;
> +
> +	err =3D otx2_mqprio_alloc_cache(pfvf, false);
> +	if (err)
> +		return err;

[Severity: Medium]
Can this trigger an ENOMEM failure during error recovery?

When otx2_setup_tc_mqprio fails (e.g., during hardware programming), it
invokes otx2_mqprio_restore_old to revert. This function then calls
otx2_mqprio_alloc_cache(pfvf, false).

Passing false for the replacing parameter deliberately bypasses the
cache-reuse optimization, forcing an unnecessary devm_kcalloc allocation.
Because this error recovery runs when operations fail, which can coincide w=
ith
memory pressure, this introduces a fallible allocation step into a critical
unwind path.

If memory allocation fails during this error rollback, the rollback aborts,
leaving the hardware and software states inconsistent (hardware contains
partial new limits, software is missing the restored limits).

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918015906.1255=
204-1-rkannoth@marvell.com?part=3D2
