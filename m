Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3CBD35CB76;
	Thu, 10 Sep 2026 02:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789007859; cv=none; b=c6cP8RmBmXnS0yw2Ts2GbIQNR0HKvQuD1U6R0u0pePIDsbcGjMX06dRKeOHN59K0dpyBT2GUAOyAksJzCUnhPbsODvy12OoNjEzgJ2HENfTFIBjJ2/dM5Z38VphQgBvpBtq7Cv6ErLfc+gaJSb535kknB9nZbomhFP4aRCuc9k0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789007859; c=relaxed/simple;
	bh=+DVDRwLYQ/eFIy7qPd4F+ucmXGMJPte/CWyGylB8GFs=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ryrnWhP2ZOWc6REKcdQxloRLWGWSMIXK9gGu6Y3sZQVkP+Be290BsiGcyxANpCyI/zeMfRvQLsi8n1sGBJi9gARsL+fv788dJ4LJUupJMC9y/rSF+MaXuBwzdLQLb+4fqSckG4EztbuxGUK56LLvHypiwJgsxbpD810z96kFW5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=Hos31upA; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="Hos31upA"
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68A1kGLF4088477;
	Wed, 9 Sep 2026 19:37:30 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=N
	Bakmn4E5UUGyT2rfoijT09Wm5/8GdDaQWhhanX65rU=; b=Hos31upATI2Qap8Iz
	eLnkJNyzOy7PtiOckr365vsD3R5wnmMe+9Nah7GRRs4hAi036wJBlcRporbPyyCr
	P2d9n38OSUxyohWPalqH22HFpGlv5tny0J7ntsfaYm6g5sK6zsrJIniQfajxmD6R
	MfvP0uaq1fWuh+Bgl3ij5dqfqjGQhB5Qs7pNSrN1BZB5r4NVcAFkAhAmq60wHlpl
	1bsLaNwHgYPRcCJK+DE09s1sLB3jAIeJkb40rsIyXvU8zdY/xNLy/O/dTRmisFYt
	6zU8NlVFVlvlnd3JY0T6aZa3CrcbSc0nn8r/ANTE9+BvJNGncTYOxJpjoa1mM5pD
	fQmZA==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4gkcxnswy8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 09 Sep 2026 19:37:30 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 9 Sep 2026 19:37:28 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Wed, 9 Sep 2026 19:37:28 -0700
Received: from rkannoth-OptiPlex-7090 (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id 720EE3F707A;
	Wed,  9 Sep 2026 19:37:27 -0700 (PDT)
Date: Thu, 10 Sep 2026 08:07:21 +0530
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <sashiko-reviews@lists.linux.dev>
CC: <bpf@vger.kernel.org>
Subject: Re: [PATCH v14 net-next] octeontx2-pf: add mqprio bandwidth offload
 for NIX TX schedulers
Message-ID: <aqIX4cqmpW-cYFCt@rkannoth-OptiPlex-7090>
References: <20260908062437.251739-1-rkannoth@marvell.com>
 <20260909062543.851BF1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260909062543.851BF1F00A3A@smtp.kernel.org>
X-Authority-Analysis: v=2.4 cv=K923jCWI c=1 sm=1 tr=0 ts=6aa217ea cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=8nJEP1OIZ-IA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=TtqV-g6YmW1Jfm2GSLaY:22 a=VwQbUJbxAAAA:8
 a=M5GUcnROAAAA:8 a=c92rfblmAAAA:8 a=xQo9HMWJ6pKdc7UIQ1MA:9 a=3ZKOabzyN94A:10
 a=wPNLvfGTeEIA:10 a=OBjm3rFKGHvpk9ecZwUJ:22 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-ORIG-GUID: I3v0T_B8giAkWuE2pQr7jBHj7YfjhWx9
X-Proofpoint-GUID: I3v0T_B8giAkWuE2pQr7jBHj7YfjhWx9
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTEwMDAyNiBTYWx0ZWRfXzcUoijriucbd
 pSsyCEpYeiHRDr1FuJ8HU2sr/dKQPU2SxWNfaqRwIdkEisiFE4S9+i7a4+MIHYwnuqt1nxSjGPb
 MzozSDhk7/AkAERSvGrtyCK54IdZZHw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTEwMDAyNiBTYWx0ZWRfX/DhZxsMKtvE9
 zLeqs1dNGH5KabbFXc2ZjzN6nRhEXo3i2h2f28eamyuXSwuKLSaz9DqfoRrlcN604RAFsIl06ID
 nvpydX0PWfjhNzwNsMtyAFgebVm/WZvXqAkgYLarrjIFkDxOpTOP60Y/At5HTN8N0L2is3cwCrt
 ik/ubnnYi+YjY5DgVBIQRN5IaiG4dIPQUzfRjBsHdxFaNgUO2VmGBrqgaeOqjiBaC/xyT6gr2Su
 uaSeIE9l/ILgABgS6VQ05//TMJF8nlNpJvbGPZr/F6r4Le1zal0wttvek93znC7lhDcf8zNYWJ6
 m8n3/+MwXsqSOfrz8zuUmsEw3t+mgGfcrQJcY23U/Du6wauEe/hwloJwbx5zqxEhLtzNSP3DuJO
 Vs3Qc/T5DSmqLdw43z2J0/nFtR0dNaRri5A8LszNHXeT79/pCmmRB5smENl7x5tmhiaqZik2FPe
 izD5HyzQiS5H1rH425w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-10_01,2026-09-09_02,2025-10-01_01

On 2026-09-09 at 11:55:43, sashiko-bot@kernel.org (sashiko-bot@kernel.org) wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [High] Data Race / Invalid Cast: Mixing atomic bit operations with non-atomic bitwise operations on `u64 pf->flags` causes data races and memory corruption.
I agree that non-atomic accesses to pf->flags present an existing race condition across the driver.

In this patch (targeted for net-next), the flag accesses relevant to this change have been updated. To address the broader existing issue properly,
I will send a separate bug fix patch targeted for net to convert all remaining pf->flags accesses to atomic bitops (set_bit/clear_bit/test_bit).

As part of this commit (to net-next), all data races w.r.t to the flags (reported by sashiko) are fixed. I agree, there is an exisiting issue
of data races as flag is not set atomically elsewhere. we will convert all access to flags to set_bit/clear_bit as patch to net (as a fix patch).

> - [Medium] State Desynchronization: Failing to clear hardware shapers in `otx2_mqprio_down()` skips software state cleanup, permanently bricking mqprio state.

If otx2_mqprio_down() fails, it is typically due to an underlying mailbox communication failure with the AF, which we log to alert the user.
Because the hardware communication channel is compromised at that point, attempting additional mailbox calls to recover hardware state is likely to fail as well.

> --
>
> commit e74bdebdda4c26c75ad9a6fe1f2ba38bec570025
> Author: Ratheesh Kannoth <rkannoth@marvell.com>
> Subject: octeontx2-pf: add mqprio bandwidth offload for NIX TX schedulers
>
> This commit adds mqprio bandwidth offload for channel-mode mqprio with
> TC_MQPRIO_SHAPER_BW_RATE. It programs per-queue MDQ CIR/PIR through the NIX
> TX scheduler mailbox for each non-QoS transmit queue. The patch also manages
> the tearing down and rebuilding of the TX scheduler hierarchy when adding or
> replacing the qdisc.
>
> Link: https://lore.kernel.org/netdev/20260904031553.3196916-1-rkannoth@marvell.com/
>
> > diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
> > --- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
> > +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
> > @@ -907,11 +907,13 @@ static int otx2_mbox_up_handler_rep_event_up_notify(struct otx2_nic *pf,
> >
> >  	if (info->event == RVU_EVENT_PORT_STATE) {
> >  		if (info->evt_data.port_state) {
> > -			pf->flags |= OTX2_FLAG_PORT_UP;
> > +			set_bit(__builtin_ctzll(OTX2_FLAG_PORT_UP),
> > +				(unsigned long *)&pf->flags);
>
> [Severity: High]
> Could mixing atomic bit operations here with non-atomic bitwise operations
> elsewhere cause data races and memory corruption?
>
> For example, otx2_open() updates pf->flags using non-atomic read-modify-write
> operations:
>
>     pf->flags &= ~OTX2_FLAG_INTF_DOWN;
>     pf->flags &= ~OTX2_FLAG_PORT_UP;
>
> If an asynchronous link event triggers the mbox handler to update
> OTX2_FLAG_PORT_UP atomically while otx2_open() is non-atomically
> modifying pf->flags, the atomic updates could be overwritten and lost.
>
> Additionally, casting a u64 pointer to an unsigned long pointer for
> atomic operations can corrupt memory on 32-bit big-endian architectures.
>
> [ ... ]
>
> > diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c
> > --- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c
> > +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c
> [ ... ]
> > +int otx2_mqprio_down(struct otx2_nic *pfvf)
> > +{
> > +	int err = 0;
> > +
> > +	if (!pfvf->mqprio.rate_limit)
> > +		return 0;
> > +
> > +	if (netif_running(pfvf->netdev) &&
> > +	    otx2_mqprio_mdq_allocated(pfvf))
> > +		err = otx2_nix_tm_clear_queue_shaper(pfvf);
> > +
> > +	if (err) {
> > +		netdev_err(pfvf->netdev,
> > +			   "mqprio: failed to clear hardware shapers: %d\n",
> > +			   err);
> > +		return err;
>
> [Severity: Medium]
> Does returning early here permanently desynchronize the software state if
> clearing the hardware shapers fails?
>
> When removing the mqprio qdisc via a tc qdisc del command, the kernel
> calls ndo_setup_tc with hw=0 and ignores the return value. If
> otx2_nix_tm_clear_queue_shaper() fails (for instance, due to a mailbox
> timeout), returning early skips the call to otx2_mqprio_clear_sw().
>
> Since the kernel unconditionally destroys the qdisc software object, the
> driver will continue to incorrectly enforce rates during ndo_open and
> reject features like XDP, PFC, and HTB because it falsely believes
> mqprio is still active.
>
> > +	}
> > +
> > +	otx2_mqprio_clear_sw(pfvf);
> > +
> > +	return 0;
> > +}
>
> --
> Sashiko AI review · https://sashiko.dev/#/patchset/20260908062437.251739-1-rkannoth@marvell.com?part=1
>
