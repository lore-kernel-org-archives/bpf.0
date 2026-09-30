Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58B66367B8C
	for <bpf@vger.kernel.org>; Wed, 30 Sep 2026 02:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790735418; cv=none; b=VPtpHHVIHgSJAti2njVW22NDJZMvy4KLCVCTl9TupPL/31GGq7O15xRzI+vpOW1sxZVnW6n5BMjnYNuUn/jCiheqMVujJsZX+/sJWtEqquK095oNdnFcIE7bdRqRh4mBIChSvx4bivzBtS/vNtPpza4vYE5M586HZ+SeHRhMCSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790735418; c=relaxed/simple;
	bh=G8clY763CvSekOm37sZP6vdefBYHGxLW2a16XfizbXo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ktsMS0edCdECap6gn1iyYQslWNZCkAOwRyjSCK30GtXp0w/2YR904+tcK6bxVQOKsuXHDTj7eN8pMTt1I5hyl0fz8vBdsySEeewpYpXwkLJXPKLRXdsZWoBtB0ht169RxSCY3fpgKQJqtA/DIyVH/vXflUuohue2bbIUSibiDtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y8298qlo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y8298qlo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF89B1F00893;
	Wed, 30 Sep 2026 02:30:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790735416;
	bh=NfItEexbH25vBoebe86+hrPqZlkRY0F/UPnuLLJ2pr4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Y8298qloPx7G/kSdfEkYroRSUp9tcjonIDz0UKbkmy/Kxx4AAVTb9tWCBo40SDXWi
	 /Qj3HRl3VFdretr7n8xBEqltcyNNN2SzwfthwifREhakNwb8lahwCcCTnhMmL7wQt1
	 GQtFQJts8peyKe4J58EJ2amdyv4sYQiOXdst+CD4oJ7OQZZWatynHDMU9wqpcsPzrb
	 IEXuI8a+0D/KUlRld8xeJ5TyFK5za055DAnTZVKK1dvnz2uCI/dtaVYhO/abLDkvuB
	 6luRKbeEm9Q9OuhW/M53AB5GUL1QglzUBXO3z7Izp6IzlE9wdXrqOk8ICocDLU5lQr
	 dvP1WFWpKbiDw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v18 net-next 2/2] octeontx2: add mqprio bandwidth
 offload for NIX TX schedulers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ratheesh Kannoth" <rkannoth@marvell.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260929022915.2704627-3-rkannoth@marvell.com>
References: <20260929022915.2704627-1-rkannoth@marvell.com>
 <20260929022915.2704627-3-rkannoth@marvell.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 30 Sep 2026 02:30:16 +0000
Message-Id: <20260930023016.BF89B1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] tc: use-after-free in otx2_mqprio_netdev_tc_work due to premature =
work cancellation
- [Medium] tc: mqprio offload state leak blocks future channel configuration
--

commit c282f822793fe3053caf590664f822dd8c83b2e9
Author: Ratheesh Kannoth <rkannoth@marvell.com>

octeontx2: add mqprio bandwidth offload for NIX TX schedulers

This commit adds TC_SETUP_QDISC_MQPRIO offload with
TC_MQPRIO_SHAPER_BW_RATE on PF and VF netdevs. It programs per-queue MDQ
CIR/PIR via the NIX TX scheduler mailbox and introduces a work item for
restoring TC configurations.

> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c b/=
drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c
> --- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c
[ ... ]
> @@ -287,6 +287,21 @@ static int otx2_set_channels(struct net_device *dev,
>  		return -EINVAL;
>  	}
> =20
> +	if (pfvf->mqprio.rate_limit &&
> +	    (channel->tx_count !=3D pfvf->hw.tx_queues ||
> +	     channel->rx_count !=3D pfvf->hw.rx_queues)) {
> +		netdev_info(dev,
> +			    "Not permitted to change channel count while MQ prio is active\n"=
);
> +		return -EINVAL;
> +	}
> +
> +	if ((pfvf->old_mq_snap || pfvf->cur_mq_snap) &&
> +	    channel->tx_count < pfvf->hw.tx_queues) {
> +		netdev_err(dev,
> +			   "Cannot reduce TX queues after mqprio bandwidth offload was config=
ured\n");
> +		return -EINVAL;
> +	}

[Severity: Medium]
Because pfvf->old_mq_snap is never cleared upon qdisc deletion (as seen
in otx2_mqprio_clear_sw below), will this permanently block reducing TX
queues via ethtool until the driver is reloaded?

[ ... ]
> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c b/drive=
rs/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
> --- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
[ ... ]
> @@ -3622,7 +3641,9 @@ static void otx2_remove(struct pci_dev *pdev)
>  	otx2_cgx_config_linkevents(pf, false);
> =20
>  	otx2_unregister_dl(pf);
> +	otx2_shutdown_tc_mqprio(pf);
>  	unregister_netdev(netdev);

[Severity: High]
Could calling otx2_shutdown_tc_mqprio() before unregister_netdev() lead
to a use-after-free?

Concurrent netlink operations might queue work via
otx2_mqprio_defer_netdev_tc_restore() while waiting on rtnl_lock(). Once
the remove path finishes unregistering and frees the netdev, the deferred
work could execute, access the freed pfvf->netdev, and corrupt memory.

[ ... ]
> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c b/drive=
rs/net/ethernet/marvell/octeontx2/nic/otx2_tc.c
> --- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c
[ ... ]
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
Will this leak pfvf->old_mq_snap when the qdisc is deleted? The teardown
path clears the software state by calling otx2_mqprio_clear_sw(), but
neither this function nor otx2_teardown_tc_mqprio() frees the snapshot.

[ ... ]
> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c b/drive=
rs/net/ethernet/marvell/octeontx2/nic/otx2_vf.c
> --- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c
[ ... ]
> @@ -840,7 +841,9 @@ static void otx2vf_remove(struct pci_dev *pdev)
>  #endif
> =20
>  	otx2_unregister_dl(vf);
> +	otx2_shutdown_tc_mqprio(vf);
>  	unregister_netdev(netdev);

[Severity: High]
Does this exhibit the same use-after-free risk as the PF remove path
above, where pending tc setup work could be deferred and executed after
unregister_netdev() has completed?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260929022915.2704=
627-1-rkannoth@marvell.com?part=3D2
