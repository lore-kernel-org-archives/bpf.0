Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CA8E35F5EA
	for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 03:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790220208; cv=none; b=ELu4wC7GWjWZhYVscM+QsnLc4hAhe+c4Xkwqh9YrNhz2bVm0/gKtfHMexE898NFVjWlor/vPqaZ3pwQMKtIohI3F6HNS1wjaMGoqe/JwkrjJ6kqu8hmH3sT+LzDHe9wv6OlkF/8F3lZKTKIk+WlaRIybO6wjLzIjcLTyptLAxN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790220208; c=relaxed/simple;
	bh=lqRw069GrO/ym6jo0ZyMHoDXFq3REjXdA8tkx/hZFf8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=tP3m+ImJrZ/2MlU9Z440x9F+YruOekVmU5+P3GjFw9kQ3VHsnzroYmZgLAteu2ssR13XbIN/ta5X+y0XPlH7jVQjWErx6ofORUIi39hGo4rtjXgQulU5AcpuE9Ssi5gsCykOSwfJSNAFRMmct8xnOIjBoMq7j2gDuc2z7Sbqpag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AU65pAm1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AU65pAm1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EA6C1F00893;
	Thu, 24 Sep 2026 03:23:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790220207;
	bh=za7Gu/oCU7Daaj1/PA75Ioiw+tKdGB60cL25fDZqKh8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AU65pAm1NVIC0YymWxZM8S/LD9vXeIHT9sxzieJymar/cksywU7KdzRjI5hrn+TIa
	 7ybdy7bAqneCTNNzINPVtvcBdTHNOifDlmNVgw1UgBy++R2qDa0UASb0DzBj+0P3wk
	 VFOiogsUi40h5WDQJFv2kKept38jc9PpRcREH4RmUsVo9FQgV6KBIftCAnhCA1IC85
	 PPpgjRgMlkkonjmrxuhZgVlN1UykFFcHIR3us4jcp6giUS4vuvmMb3NgY8MIoey3rk
	 xUfT48rZPmn7zSMI41sIr/bpwpnULk0Umx24+NUoggHi87ngxWRYYO3SiIqPzApzLI
	 bdtlLhi1Sz7rQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v17 net-next 2/2] octeontx2: add mqprio bandwidth
 offload for NIX TX schedulers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ratheesh Kannoth" <rkannoth@marvell.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260923032217.1732753-3-rkannoth@marvell.com>
References: <20260923032217.1732753-1-rkannoth@marvell.com>
 <20260923032217.1732753-3-rkannoth@marvell.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 24 Sep 2026 03:23:26 +0000
Message-Id: <20260924032327.0EA6C1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] core: race condition and UAF in teardown due to inverted netdev un=
register ordering
--

commit ccdaeef10f51af218ecef73bdbd0e10716a461fd
Author: Ratheesh Kannoth <rkannoth@marvell.com>

octeontx2: add mqprio bandwidth offload for NIX TX schedulers

This commit adds TC_SETUP_QDISC_MQPRIO offload with
TC_MQPRIO_SHAPER_BW_RATE on PF and VF netdevs. It programs per-queue
MDQ CIR/PIR via the NIX TX scheduler mailbox and caches rates in
software.

> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c b/drive=
rs/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
> --- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
[ ... ]
> @@ -3420,11 +3439,13 @@ static int otx2_probe(struct pci_dev *pdev, const=
 struct pci_device_id *id)
>  	otx2_sriov_vfcfg_cleanup(pf);
>  err_pf_sriov_init:
>  	otx2_unregister_dl(pf);
> -	otx2_shutdown_tc(pf);
>  err_mcam_flow_del:
>  	otx2_mcam_flow_del(pf);
>  err_unreg_netdev:
> +	otx2_shutdown_tc(pf);
>  	unregister_netdev(netdev);

[Severity: High]
Does this sequence introduce a use-after-free race during teardown?

By moving otx2_shutdown_tc() before unregister_netdev(), the device is
still visible to the networking stack and can receive RTNL-protected
configuration commands like ndo_setup_tc.

If a concurrent tc qdisc command executes ndo_setup_tc() right after
otx2_shutdown_tc() has run, it could access freed structures like
cur_mq_snap or re-arm mqprio.netdev_tc_work, which would then execute
after the device is completely destroyed. Should unregister_netdev()
be called first to provide the RTNL barrier before destroying TC
resources?

[ ... ]
> @@ -3622,6 +3643,7 @@ static void otx2_remove(struct pci_dev *pdev)
>  	otx2_cgx_config_linkevents(pf, false);
> =20
>  	otx2_unregister_dl(pf);
> +	otx2_shutdown_tc(pf);
>  	unregister_netdev(netdev);

[Severity: High]
Is the same race condition present here in the PF removal path?

It appears otx2_shutdown_tc() frees TC structures and cancels workqueues
without holding RTNL, while unregister_netdev() is what prevents further
ndo_ops from executing. Moving otx2_shutdown_tc() above
unregister_netdev() seems to break the LIFO teardown order.

[ ... ]
> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c b/drive=
rs/net/ethernet/marvell/octeontx2/nic/otx2_vf.c
> --- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c
[ ... ]
> @@ -840,6 +842,7 @@ static void otx2vf_remove(struct pci_dev *pdev)
>  #endif
> =20
>  	otx2_unregister_dl(vf);
> +	otx2_shutdown_tc(vf);
>  	unregister_netdev(netdev);

[Severity: High]
Could this VF teardown sequence trigger the same use-after-free if
a user space process configures mqprio offload concurrently with driver
removal?

Like the PF driver, otx2_shutdown_tc() is called before the netdev
unregistration barrier.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260923032217.1732=
753-1-rkannoth@marvell.com?part=3D2
