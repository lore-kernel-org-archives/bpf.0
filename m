Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99B8E17D6
	for <bpf@vger.kernel.org>; Fri,  4 Sep 2026 02:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788489260; cv=none; b=JChJd1nnwAhKpyCz4wJDHf+TeaVrMMuF0UcW2bN3WCMtJp63ObWMmfP9k9ok6+KTrtEKvRgCEhWzmDTBXr797nvDZwE4o5btsP7fD7dF5Xmb9GUaZV98N6tag3FX/YpBHkPD2Hii3a2rjZdG+jZsYS2rUKU3JGQRt6qKj2AKT3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788489260; c=relaxed/simple;
	bh=ai/TFdmwvyCDGLS23Ip65D3OUc/ce8CRzO7+RfsUeo8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=gwiS+GWtHluSbRmvU61vDWXrSoMgxld9iavirWZ6bfq/GW0UGOqtByPTJn3E5BkUaprzttPYdPkLBIlaltCbs5e0dRTDe62aYp5VScF2Z0j6izdvVoT93azR7aBI55cLElix/NYbOACb8S//QKMpbEdrNHaN9QP81iUoVBhLjTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G9HzcdCM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G9HzcdCM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 055601F000E9;
	Fri,  4 Sep 2026 02:34:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788489259;
	bh=H7hBSrdkmAoUxTWWgrGJPEBhNJNeU7su4diInB9tC+4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=G9HzcdCMsaq/HHY8BxO7JhHhJwOQbMpw/LNns93CciF9ocmn2blvveKpftthv/zfW
	 qa+rF2JPxnaqtqA5M79JieOibtA0uxuOSJIA71XqUgHL2cAZcu4tDJNDyOFJ/NT7in
	 OfCzwQziNIxg3O9A/Jy0LgWybf9ufRfxa+sEjMIzLgrNOMAZXmp5jbwIXmULWHRfyt
	 /l8KRcGPLCPwLAzm3opKmq6yiIUXsZNS8e8/LiPSCDWgCZGchRqZ5VgR/fhwE+kTeu
	 SCWGpxS/+mcmNOOnBFqPJ8k3Lrkp/xaUNg5KNMW+GlsOkjNsi/0m8iPYNcxNkQBqmW
	 mY1eFiAj70SHg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v12 net-next] octeontx2-pf: add mqprio bandwidth offload
 for NIX TX schedulers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ratheesh Kannoth" <rkannoth@marvell.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260903023324.3078284-1-rkannoth@marvell.com>
References: <20260903023324.3078284-1-rkannoth@marvell.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 04 Sep 2026 02:34:18 +0000
Message-Id: <20260904023419.055601F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Divide-by-zero in SMQ lookup during MQPRIO rollback
--

commit ba1788f860ad0c3ea2631aca0bfc1b979830add7
Author: Ratheesh Kannoth <rkannoth@marvell.com>
Subject: octeontx2-pf: add mqprio bandwidth offload for NIX TX schedulers

This commit adds TC_SETUP_QDISC_MQPRIO offload for channel-mode mqprio using
the NIX TX scheduler mailbox. It programs per-queue MDQ shapers and handles
mqprio setup, replacement, and teardown by restarting the netdev and
caching active rates.

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
> +	/* otx2_mqprio_restart_netdev() clears rate_limit when ndo_open() fails=
. */
> +	pfvf->mqprio.rate_limit =3D true;
> +
> +	err =3D otx2_mqprio_up(pfvf);

[Severity: High]
Can this lead to a divide-by-zero if ndo_open() fails during the replacemen=
t?

In otx2_setup_tc_mqprio(), if otx2_mqprio_restart_netdev() fails (e.g., due
to an allocation failure), the interface is left stopped and the TX schedul=
ers
are freed, setting pfvf->hw.txschq_cnt[NIX_TXSCH_LVL_SMQ] to 0.

The error path then calls this function, otx2_mqprio_restore_old(), which
unconditionally sets rate_limit to true and calls otx2_mqprio_up() to resto=
re
the shapers.

otx2_mqprio_up() calls otx2_nix_tm_set_queue_shaper(), which eventually
invokes otx2_get_smq_idx():

otx2_common.h:otx2_get_smq_idx() {
    ...
    idx =3D qidx % pfvf->hw.txschq_cnt[NIX_TXSCH_LVL_SMQ];
    smq =3D pfvf->hw.txschq_list[NIX_TXSCH_LVL_SMQ][idx];
    ...
}

Since txschq_cnt is 0, won't this cause a divide-by-zero panic, or silently
evaluate to an out-of-bounds index on architectures that do not trap on
integer division, leading to malformed configuration commands being sent
to the hardware?

> +	if (err)
> +		return err;
> +
> +	otx2_mqprio_snap_free(pfvf, &pfvf->cur_mq_snap);
> +
> +	return 0;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260903023324.3078=
284-1-rkannoth@marvell.com?part=3D1
