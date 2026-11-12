Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=67.231.156.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794448588;
	b=cSZxRsnUsyrG4/97D5p8uwQHCOmZ5P8gmLBinDp/w0ccxoSmv9+7PQz5VAAJSG+6b7sZ
	 WXhNL/O/evcBqfHjmXaYHF6vE8r6XTCrJYrKr8bOSv1ZN0kOtMmsUJ+7jp/LKOcn/BrDq
	 rOVV3pTOEkrTYln+jHTN4V6M/iDMVuqi8WpHIiSoSAZkqgH6jhCjoh82XVArZ7q2+VoUz
	 7Be6Z/F7KnlkkRq2GW6pkfRrMhbXm1WONFs0ZCdNDRt2ZqEt303rkD30CsxRT3EF39Eo4
	 fcIWFjEETTpEDY/BZ/U8Qbv3D1hqhTucwTxSpDUzF80wD5yfLgXyUTH5yGIEmMxYyMg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794448588;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:Content-Transfer-Encoding:
	 In-Reply-To:X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version;
	bh=sH82aJinOwU/auh0UowH2agtcCGxckvw29bIK55uTgc=;
	b=4xsnATUvF59kBgr383/c0b1E62Yx6VKcpZab+VHQCEvugX9Lmq9dkP8/q9Gm5R5F2DMD
	 2uv7wbyNdc0Wngtwtv1PDkUMSXaYKIOEYn02WiCLLqI6uhB0xzGbemLShwiZUhcw6q5nQ
	 v0Enbzfm2cyj8XTKhSmWex82ekXmrrNwkIWbvM8L5wmL7Ul9nWt3Epqq3VyuzryO1kFlL
	 w/rciJ9nBWj5xdaQmPKWMzvjlFC6r9aig9bU3c8uWGWHxAFU6ie/GGQ/e7frgqePfupXO
	 DeEPWgo2IXvjO0ygiPMP9X/47yUApckXxxp+BqAAZHqgakcVJqGeUDHPSBL8SZ4tqmA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=marvell.com;
	spf=pass smtp.mailfrom=marvell.com;
	dkim=pass header.d=marvell.com header.i=@marvell.com header.a=rsa-sha256 header.s=pfpt0220 header.b=bjMzEDFf;
	arc=none smtp.remote-ip=67.231.156.173
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5800606A31C;
	Thu, 12 Nov 2026 01:56:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E5800606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=marvell.com header.i=@marvell.com header.a=rsa-sha256 header.s=pfpt0220 header.b=bjMzEDFf
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ABNPeuD1486503;
	Wed, 11 Nov 2026 17:55:54 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=s
	H82aJinOwU/auh0UowH2agtcCGxckvw29bIK55uTgc=; b=bjMzEDFfUzFF+597b
	K/PJtTkWrwOhGcjslwyLqtHyA5gwFD6z3+Exb4qAzeutRSehUl3BkQ2JX7WUGTYZ
	yUIdkOtSpM7wGPycQO/7SwZYLu2ESknJhKPDCKXbppCp22EJvygIumHvja6xkNKy
	iK0LopoAxf5cufrIUib6p4IxPJrFW7Y4JULECcfkczxXFxkqabGyr5IS7JvI9rB1
	mx1FoWuPK4yW9BAu2ehcJavcb5hXc1JG7Cu7WCk1KTLt/RQnU+LgI/ceacVtXrWR
	lpJKd+MoG1Qmnx2hBr4nRAYspPH6SbzjCF/n5j8zBN43DjHFFD1y9dTntnZYrcdm
	zQqPQ==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4hw15ursp1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Nov 2026 17:55:54 -0800 (PST)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 11 Nov 2026 17:55:50 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Wed, 11 Nov 2026 17:55:50 -0800
Received: from rkannoth-OptiPlex-7090 (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id 148023F704C;
	Wed, 11 Nov 2026 17:55:47 -0800 (PST)
Date: Thu, 12 Nov 2026 07:25:46 +0530
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <netdev-bot+sashiko@kernel.org>
CC: <bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <netdev@vger.kernel.org>, <andrew+netdev@lunn.ch>, <ast@kernel.org>,
        <daniel@iogearbox.net>, <davem@davemloft.net>, <edumazet@kernel.org>,
        <hawk@kernel.org>, <john.fastabend@gmail.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <sdf@fomichev.me>, <sgoutham@marvell.com>,
        <horms@kernel.org>
Subject: Re: [PATCH v21 net-next 2/2] octeontx2: add mqprio bandwidth offload
 for NIX TX schedulers
Message-ID: <avUcot9x14Mdygbn@rkannoth-OptiPlex-7090>
References: <20261109033154.2161803-3-rkannoth@marvell.com>
 <179443275039.2199510.3340754433806692028@kernel.org>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <179443275039.2199510.3340754433806692028@kernel.org>
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEyMDAwNyBTYWx0ZWRfX3b7cbojaNHtd
 TEexKqfRXwQhc20sp4/azeDfIsiMpYCUEZ3uL84piLS1d0oBXaVbpC7LHod7D00EP58JtLO77dQ
 k9snteADp3hvuSlXzyouimBb68ME/aw=
X-Authority-Analysis: v=2.4 cv=Mev5KJ/f c=1 sm=1 tr=0 ts=6af51caa cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=qit2iCtTFQkLgVSMPQTB:22 a=VwQbUJbxAAAA:8
 a=9R54UkLUAAAA:8 a=M5GUcnROAAAA:8 a=ZdTbOKM-kNqAQcYRi60A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=YTcpBFlVQWkNscrzJ_Dz:22 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: IQhou4BB1WHuIsKMMKbFLkeVFBOp9-Ou
X-Proofpoint-ORIG-GUID: IQhou4BB1WHuIsKMMKbFLkeVFBOp9-Ou
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEyMDAwNyBTYWx0ZWRfX50ajPsHLmA41
 NYElfPDVqF5e6aWLnA8DlO2YJiT9mBzKkFlf+EIxsMEhe2GJuSpW3YhPmPQvCMk7SwGBmJQ+ImW
 KXnueNT+T7jbogDiR7lvwr/iN41dqHDQZKsgAsq5a+/re1aOrP7U4XtdAY9mVlEC2Pfmw3cWL5v
 kWFGPyzFbJNNlSaohzMGmQbU02F69XXrghRKu+KA1MedvNcHNtci9BrSfKNAW2sOCm+pvShzOQM
 iZn2r/woMXHHou+XDNMCDMsjIRe++14gEx39tpVfGtGu+alfM6a8Z02SGJMySH5e1q07gZn71g+
 M0b9NfGzWJ1820mHYxJ02qzExMQkd8qwNOnDy5F/hUOwZ5Gy6cA76zSrPQjQ8AvTGdHZPgUSgH4
 4AySX0+n+rK8qD+bGkG94GVGmO7UzsUUT5eO/pC+7Aw+93RRG/4i4P48oWNp+M63ZaksIltC0DM
 SMcx9b4M+k3Z0emrrNA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-11_06,2026-11-11_03,2025-10-01_01

On 2026-11-12 at 03:02:30, netdev-bot+sashiko@kernel.org (netdev-bot+sashiko@kernel.org) wrote:
> Thank you for your contribution! Sashiko AI review found 11 potential
> issue(s) to consider.
>
> Critical: 0 · High: 0 · Medium: 6 · Low: 5

v21 is a RESEND of v20.

Sashiko comments reply for v20: https://lore.kernel.org/netdev/atV491xfWzf9YqV_@rkannoth-OptiPlex-7090/

>
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
>
> - [Medium] Replacing an offloaded mqprio with a software taprio stops TX
>   on the interface.
> - [Medium] With mqprio rate limiting active, otx2_txsch_alloc() requests
>   hw.non_qos_queues SMQs but still only one TL4.
> - [Medium] Setup and teardown use different notions of 'offload enabled'.
> - [Medium] When otx2_mqprio_down() fails, otx2_teardown_tc_mqprio()
>   returns immediately and skips otx2_mqprio_restart_netdev(netdev,…
> - [Medium] The new otx2_mqprio_up() failure branch in otx2_open() jumps
>   to the new err_free_hw label.
> - [Medium] octeontx2-pf: premature otx2_mcam_flow_del() in otx2_probe()
>   error path
> - [Low] The commit message leaves out several changes that reach code
>   paths unrelated to mqprio.
> - [Low] otx2_mqprio_restart_netdev(), called from ndo_setup_tc, clears
>   and sets __LINK_STATE_START on netdev->state directly.
> - [Low] The new comment in otx2_config_sched_shaping() calls 65536 'the
>   kernel-side default burst when HTB does not supply an explicit value'.
> - [Low] The comment on otx2_mqprio_keep_netdev_tc() says it detects a new
>   software mqprio that installed its TC layout before the old offloaded…
> - [Low] In otx2_setup_tc_mqprio(), the cleanup path for a failed replace
>   is entered mid-loop when otx2_nix_tm_set_queue_shaper() fails.
>
> --
>
> octeontx2: add mqprio bandwidth offload for NIX TX schedulers
>
> This commit adds TC_SETUP_QDISC_MQPRIO offload with the bw_rlimit shaper
> for octeontx2 PF and VF netdevs. It programs per-queue MDQ CIR/PIR through
> the NIX TX scheduler mailbox.
>
> The TX scheduler cannot be reprogrammed live, so every mqprio add, replace
> and delete bounces the netdev through ndo_stop()/ndo_open(). Cached rates
> are restored from otx2_mqprio_up(), and replace operations are staged in
> snapshots.
>
> > diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
> > index f4047b0d5d963..b4a738cf9a8b7 100644
> > --- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
> > +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
>
> [ ... ]
>
> > @@ -651,7 +784,11 @@ int otx2_txschq_config(struct otx2_nic *pfvf, int lvl, int prio, bool txschq_for
> >  						(u64)hw->smq_link_type);
> >  		req->num_regs++;
> >  		/* MDQ config */
> > -		parent = schq_list[NIX_TXSCH_LVL_TL4][prio];
> > +		if (pfvf->mqprio.rate_limit)
> > +			parent = schq_list[NIX_TXSCH_LVL_TL4][0];
> > +		else
> > +			parent = schq_list[NIX_TXSCH_LVL_TL4][prio];
> > +
> >  		req->reg[1] = NIX_AF_MDQX_PARENT(schq);
> >  		req->regval[1] = parent << 16;
> >  		req->num_regs++;
>
> [Severity: Medium]
> With rate_limit set, otx2_txsch_alloc() asks for hw.non_qos_queues SMQs
> but still only one TL4. Every MDQ then becomes a child of TL4[0] with
> MDQ_SCHEDULE = dwrr_val (priority 0).
>
> Is NIX_AF_TL4X_TOPOLOGY for TL4[0] programmed anywhere on this path?
>
> As far as I can tell, TL4X_TOPOLOGY is only written from nic/qos.c. The AF
> reset clears only PARENT and SCHEDULE:
>
> drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c:nix_reset_tx_schedule() {
> 	case NIX_TXSCH_LVL_TL4:
> 		tlx_parent   = NIX_AF_TL4X_PARENT(schq);
> 		tlx_schedule = NIX_AF_TL4X_SCHEDULE(schq);
> }
>
> The HTB teardown in otx2_qos_free_hw_schq() does reset the topology, but
> only best-effort. If the mailbox fails it warns and frees the schq anyway.
>
> TL4[0] may have been last used by another function, or by an HTB teardown
> whose reset failed. Can it then keep a non-zero RR_PRIO/PRIO_ANCHOR? If
> so, the priority-0 MDQ children would not form a single DWRR group, and
> per-queue shaping could behave unexpectedly.
>
> The patch acknowledges this later with:
>
> 	netdev_warn_once(netdev,
> 			 "mqprio: bandwidth offload uses TL4[0] without explicit topology programming; verify scheduling if limits look wrong\n");
>
> Would it make sense to program TL4[0] TOPOLOGY with an RR_PRIO that
> matches the MDQ priority when several MDQs are attached?
>
> [ ... ]
>
> > diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
> > index 777e7156badb7..f51161e8b5949 100644
> > --- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
> > +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
> > @@ -2008,6 +2008,15 @@ int otx2_open(struct net_device *netdev)
> >  	if (err)
> >  		goto err_free_mem;
> >
> > +	/* Fail closed: abort open if cached mqprio shapers cannot be restored. */
> > +	err = otx2_mqprio_up(pf);
> > +	if (err) {
> > +		netdev_err(pf->netdev,
> > +			   "mqprio: failed to restore shapers during open: %d\n",
> > +			   err);
> > +		goto err_free_hw;
> > +	}
>
> [Severity: Medium]
> Does this new error path leak pf->refill_wrk?
>
> otx2_init_hw_resources()->otx2_config_nix_queues() has just allocated it:
>
> 	pfvf->refill_wrk = devm_kcalloc(pfvf->dev, pfvf->qset.cq_cnt,
> 					sizeof(struct refill_work), GFP_KERNEL);
>
> err_free_hw only runs otx2_free_hw_resources() and otx2_free_queue_mem().
> Neither of them frees refill_wrk. The only devm_kfree() of it is in
> otx2_stop().
>
> When the open fails from otx2_mqprio_restart_netdev(), OTX2_FLAG_INTF_DOWN
> is set before netif_close(). otx2_stop() then returns early, so the
> allocation is never released.
>
> With rate_limit active, a persistent shaper mailbox failure would leak
> cq_cnt * sizeof(struct refill_work) on every admin up attempt until the
> driver is unbound.
>
> The older error labels after otx2_init_hw_resources() have the same gap.
> This patch adds a new way to reach it from userspace.
>
> [ ... ]
>
> > @@ -2281,6 +2291,7 @@ int otx2_stop(struct net_device *netdev)
> >  	for (qidx = 0; qidx < netdev->num_tx_queues; qidx++)
> >  		netdev_tx_reset_queue(netdev_get_tx_queue(netdev, qidx));
> >
> > +	synchronize_net();
> >  	otx2_free_queue_mem(qset);
>
> [Severity: Low]
> This isn't a bug, but several changes here affect paths outside mqprio,
> and the commit message does not mention them.
>
> synchronize_net() now runs on every ndo_stop. That covers admin down,
> otx2_change_mtu(), ethtool channel and ring changes, XDP attach/detach,
> and the reset task. Under RTNL it becomes synchronize_rcu_expedited().
>
> What race does it close? If it fixes an existing problem with
> otx2_free_queue_mem(), could it go in a separate patch with a Fixes: tag?
>
> otx2_txschq_stop() now zeroes hw.txschq_cnt[] for every caller. After a
> stop, otx2_get_smq_idx() returns 0 instead of the last SMQ. Existing users
> such as otx2_pfc_update_sq_smq_mapping() and otx2_qos_disable_sq() will
> see this.
>
> The PF and VF probe/remove ordering also changes:
>
>   - otx2_init_tc() and otx2vf_mcam_flow_init() now run before
>     register_netdev()
>   - otx2_shutdown_tc() moves to right after unregister_netdev()
>   - the error labels are rewired
>
> There are also comment-only edits in qos.c and otx2_get_egress_burst_cfg().
>
> Could the commit message describe these changes, or could they be split
> out?
>
> [ ... ]
>
> > diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c
> > index 8877af348a090..b34a86259e786 100644
> > --- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c
> > +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c
>
> [ ... ]
>
> > +static int otx2_mqprio_restore_old(struct otx2_nic *pfvf)
> > +{
> > +	struct mq_offload_snap *snap = pfvf->old_mq_snap;
> > +	struct net_device *netdev = pfvf->netdev;
> > +	u16 num_txq = pfvf->hw.non_qos_queues;
> > +	int tc, txq, err;
> > +
> > +	if (!snap)
> > +		return 0;
> > +
> > +	err = otx2_mqprio_alloc_cache(pfvf, false);
> > +	if (err) {
> > +		netdev_err(netdev,
> > +			   "mqprio: rollback failed to allocate rate cache: %d\n",
> > +			   err);
> > +		return err;
> > +	}
>
> [Severity: Low]
> The replace path in otx2_setup_tc_mqprio() can reach cleanup because
> otx2_nix_tm_set_queue_shaper() failed partway through the loop. At that
> point pfvf->mqprio.min_rate[]/max_rate[] and pfvf->mqprio.flags already
> hold part of the new config, and rate_limit is true.
>
> If otx2_mqprio_alloc_cache() fails here, we return before refilling the
> cache from old_mq_snap. Does that leave the partially-new rates cached
> with rate_limit still set, while the old qdisc stays root?
>
> The same applies if otx2_nix_tm_clear_queue_shaper() fails further down.
> The cache is restored, but the hardware keeps the partially-new shapers.
>
> On the restore_err branch in otx2_setup_tc_mqprio(), no deferred TC
> restore is scheduled. num_tc therefore stays 0 after mqprio_destroy() of
> the failed qdisc. From then on, otx2_mqprio_up() would re-apply the mixed
> rate set on every ndo_open().
>
> [ ... ]
>
> > +/* Offloaded mqprio replaced by software mqprio installs netdev TC layout in
> > + * mqprio_init() before the old offload instance is destroyed during graft.
> > + */
> > +static bool otx2_mqprio_keep_netdev_tc(struct otx2_nic *pfvf)
> > +{
> > +	struct Qdisc *qdisc = rtnl_dereference(pfvf->netdev->qdisc);
> > +
> > +	return qdisc && qdisc->ops && !strcmp(qdisc->ops->id, "mqprio");
> > +}
>
> [Severity: Low]
> Can this match the offloaded mqprio that is being destroyed, and not only
> a new software mqprio?
>
> dev_shutdown() puts the root qdisc while dev->qdisc still points at it:
>
> net/sched/sch_generic.c:dev_shutdown() {
> 	qdisc_put(rtnl_dereference(dev->qdisc));
> 	rcu_assign_pointer(dev->qdisc, &noop_qdisc);
> }
>
> When offload is active, mqprio_destroy() leaves num_tc to the driver:
>
> net/sched/sch_mqprio.c:mqprio_destroy() {
> 	if (priv->hw_offload && dev->netdev_ops->ndo_setup_tc)
> 		mqprio_disable_offload(sch);
> 	else
> 		netdev_set_num_tc(dev, 0);
> }
>
> This happens on unregister, and in __dev_change_net_namespace(), which
> calls netif_close() and then dev_shutdown(). In both cases
> otx2_mqprio_clear_sw() would see "mqprio" and skip
> netdev_set_num_tc(netdev, 0).
>
> After a netns move, the stale TC layout would stay while only the default
> mq is attached. skb_tx_hash() would keep limiting queue selection to the
> old TC offset/count until a new mqprio is installed.
>
> > +static void otx2_mqprio_clear_sw(struct otx2_nic *pfvf)
> > +{
> > +	struct net_device *netdev = pfvf->netdev;
> > +
> > +	pfvf->mqprio.rate_limit = false;
> > +	otx2_mqprio_clear_replace_state(pfvf);
> > +	if (!otx2_mqprio_keep_netdev_tc(pfvf)) {
> > +		struct Qdisc *root = rtnl_dereference(netdev->qdisc);
> > +
> > +		if (root && root->ops && !strcmp(root->ops->id, "taprio"))
> > +			netdev_warn(netdev,
> > +				    "mqprio: offload teardown cleared the TC layout of the new %s\n",
> > +				    root->ops->id);
> > +		netdev_set_num_tc(netdev, 0);
> > +	}
>
> [Severity: Medium]
> Does replacing an offloaded mqprio with a software taprio stop TX on the
> interface?
>
> Consider "tc qdisc replace dev X root taprio ..." without full offload:
>
>   1. taprio_change() installs its layout with netdev_set_num_tc() and
>      netdev_set_tc_queue().
>   2. qdisc_graft() publishes taprio as dev->qdisc and destroys the old
>      mqprio.
>   3. Because hw_offload is set, mqprio_destroy() calls ndo_setup_tc()
>      with hw=0.
>   4. otx2_teardown_tc_mqprio() reaches otx2_mqprio_clear_sw(), either
>      directly or through otx2_mqprio_down()/otx2_mqprio_restart_netdev().
>
> Here the root is detected as "taprio" and the warning is printed, but
> netdev_set_num_tc(netdev, 0) still runs.
>
> otx2 returns -EOPNOTSUPP for TAPRIO caps, so taprio uses
> taprio_dequeue_tc_priority():
>
> net/sched/sch_taprio.c:taprio_dequeue_tc_priority() {
> 	int num_tc = netdev_get_num_tc(dev);
> 	...
> 	for (tc = num_tc - 1; tc >= 0; tc--) {
> }
>
> With num_tc == 0 this loop never runs, so dequeue always returns NULL.
>
> Should the TC layout also be kept for taprio, or for any new root that
> owns it?
>
> [ ... ]
>
> > +static int otx2_mqprio_restart_netdev(struct net_device *netdev, bool rate_limit)
> > +{
>
> [ ... ]
>
> > +	if (running) {
> > +		clear_bit(__LINK_STATE_START, &netdev->state);
> > +		smp_mb__after_atomic(); /* Commit netif_running(). */
> > +	}
>
> [ ... ]
>
> > +		otx2_set_flag(pfvf, OTX2_FLAG_INTF_DOWN);
> > +		/* visible to otx2_stop() on other cpus */
> > +		smp_wmb();
> > +		netif_close(netdev);
> > +	}
>
> [Severity: Low]
> Is it ok for a driver to clear and set __LINK_STATE_START directly from
> ndo_setup_tc()? I couldn't find another driver under drivers/net that
> does this. The bit is owned by the core open/close helpers.
>
> When ndo_open() fails, netif_close() is also called from inside the qdisc
> operation. A failed "tc qdisc add/replace/del ... mqprio" can then take
> the interface administratively down. That includes a delete, which the
> core cannot veto. IFF_UP is cleared and NETDEV_GOING_DOWN/NETDEV_DOWN are
> sent.
>
> The commit message only says the netdev is bounced through
> ndo_stop()/ndo_open(). Could it mention that a tc command can close the
> interface?
>
> [ ... ]
>
> > +static bool otx2_tc_can_offload(struct net_device *netdev)
> > +{
> > +	return !!(netdev->hw_features & NETIF_F_HW_TC);
> > +}
> > +
> > +static int otx2_teardown_tc_mqprio(struct otx2_nic *pfvf,
> > +				   struct tc_mqprio_qopt_offload *mqprio)
> > +{
>
> [ ... ]
>
> > +	if (pfvf->mqprio.replace_setup_done && pfvf->cur_mq_snap) {
> > +		err = 0;
> > +		if (pfvf->mqprio.replace_graft_done || !tc_can_offload(netdev)) {
> > +			otx2_mqprio_snap_commit(pfvf);
> > +		} else {
>
> [Severity: Medium]
> otx2_tc_can_offload() checks netdev->hw_features. This check uses the
> core tc_can_offload(), which checks netdev->features. Can the two
> disagree in the default configuration?
>
> Both otx2_probe() and otx2vf_probe() add NETIF_F_HW_TC to hw_features
> after "netdev->features |= netdev->hw_features". So hw-tc-offload is off
> by default, and qdisc_offload_graft_helper() never sends TC_ROOT_GRAFT:
>
> net/sched/sch_api.c:qdisc_offload_graft_helper() {
> 	if (!tc_can_offload(dev) || !dev->netdev_ops->ndo_setup_tc)
> 		return;
> }
>
> As a result, this branch always commits.
>
> Suppose a replacement mqprio passes otx2_setup_tc_mqprio() and then fails
> later in qdisc_create(). For example, an estimator on a TCQ_F_MQROOT
> qdisc goes to err_out4 and ->destroy().
>
> Wouldn't the rejected config be committed as old_mq_snap? The hardware
> shapers and netdev TC layout would keep enforcing it while the old qdisc
> stays root.
>
> Separately, on the PF NETIF_F_HW_TC is only in hw_features when
> OTX2_FLAG_TC_FLOWER_SUPPORT is set. Is it intended that MDQ shaping is
> refused on PFs without flower/MCAM support? The commit message says the
> feature applies to PF and VF netdevs, without that qualification.
>
> [ ... ]
>
> > +	if (if_up) {
> > +		err = otx2_mqprio_down(pfvf);
> > +		if (err) {
> > +			if (extack)
> > +				NL_SET_ERR_MSG_FMT_MOD(extack,
> > +						       "mqprio: teardown incomplete (%d)",
> > +						       err);
> > +			netdev_err(netdev,
> > +				   "mqprio: offload teardown incomplete (%d); driver state may not match removed qdisc\n",
> > +				   err);
> > +			return err;
> > +		}
> > +
> > +		err = otx2_mqprio_restart_netdev(netdev, false);
>
> [Severity: Medium]
> If otx2_nix_tm_clear_queue_shaper() fails inside otx2_mqprio_down(), the
> software state has already been released through otx2_mqprio_clear_sw().
> otx2_mqprio_down() explains this as:
>
> 	/* The core cannot veto qdisc teardown, so always release software
> 	 * state.  The netdev restart that follows reallocates the TX
> 	 * scheduler, which drops any shaper left programmed.
> 	 */
>
> On this error path, though, we return before otx2_mqprio_restart_netdev(),
> so no restart follows. Doesn't that leave the MDQ CIR/PIR limits and the
> widened SMQ allocation in place, with rate_limit false and num_tc 0?
>
> mqprio_disable_offload() is void, so "tc qdisc del" looks successful to
> the user. The stale limits would remain until an unrelated
> ndo_stop()/ndo_open().
>
> Should the restart still happen when the clear fails?
>
> [ ... ]
>
> > diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/qos.c b/drivers/net/ethernet/marvell/octeontx2/nic/qos.c
> > index 2ede0b84e5f52..732fff75ab0be 100644
> > --- a/drivers/net/ethernet/marvell/octeontx2/nic/qos.c
> > +++ b/drivers/net/ethernet/marvell/octeontx2/nic/qos.c
> > @@ -118,6 +118,9 @@ static void otx2_config_sched_shaping(struct otx2_nic *pfvf,
> >  	/* configure PIR */
> >  	maxrate = (node->rate > node->ceil) ? node->rate : node->ceil;
> >
> > +	/* 65536 is the kernel-side default burst when HTB does not supply an
> > +	 * explicit value, not the NIX hardware maximum (CN10K_MAX_BURST_SIZE).
> > +	 */
> >  	cfg->regval[*num_regs] =
> >  		otx2_get_txschq_rate_regval(pfvf, maxrate, 65536);
>
> [Severity: Low]
> This isn't a bug, but is this comment accurate? struct tc_htb_qopt_offload
> has no burst member, so HTB offload can never supply an explicit burst,
> and 65536 is always used.
>
> The comment in otx2_nix_tm_set_queue_shaper() ("Use the same 65536 byte
> default as the HTB shaper path") repeats the same idea.
>
> [ ... ]
>
> > @@ -3420,11 +3437,13 @@ static int otx2_probe(struct pci_dev *pdev, const struct pci_device_id *id)
> >  	otx2_sriov_vfcfg_cleanup(pf);
> >  err_pf_sriov_init:
> >  	otx2_unregister_dl(pf);
> > -	otx2_shutdown_tc(pf);
> >  err_mcam_flow_del:
> >  	otx2_mcam_flow_del(pf);
> >  err_unreg_netdev:
> > +	otx2_shutdown_tc_mqprio(pf);
> >  	unregister_netdev(netdev);
> > +err_shutdown_tc:
> > +	otx2_shutdown_tc(pf);
> >  err_ipsec_clean:
> >  	cn10k_ipsec_clean(pf);
> >  err_mcs_free:
>
> [Severity: Medium]
> Does the new label ordering stop otx2_shutdown_tc() from doing
> anything on the late probe error paths?
>
> Before this patch, err_pf_sriov_init ran otx2_shutdown_tc() and only
> then fell through to otx2_mcam_flow_del(). With this patch, a failure
> in otx2_register_dl(), otx2_sriov_vfcfg_init(), the af_xdp_zc_qidx
> bitmap_zalloc() or otx2_dcbnl_set_ops() unwinds like this:
>
>   err_mcam_flow_del:  otx2_mcam_flow_del()
>   err_unreg_netdev:   otx2_shutdown_tc_mqprio(), unregister_netdev()
>   err_shutdown_tc:    otx2_shutdown_tc()
>
> otx2_mcam_flow_del() goes through otx2_destroy_mcam_flows(), which
> clears OTX2_FLAG_MCAM_ENTRIES_ALLOC.
>
> otx2_shutdown_tc() then calls otx2_destroy_tc_flow_list(). That
> function returns early when OTX2_FLAG_MCAM_ENTRIES_ALLOC is clear, so
> it no longer walks flow_cfg->flow_list_tc.
>
> Any otx2_tc_flow nodes added while the netdev was registered are
> therefore never freed. The window is small, and installing flower
> rules needs CAP_NET_ADMIN.
>
> The ordering is also now the reverse of otx2_remove() after this
> patch. There, otx2_shutdown_tc() runs right after unregister_netdev(),
> and otx2_mcam_flow_del() runs later.
>
> The unwind already reaches err_del_mcam_entries by fallthrough from
> err_shutdown_tc/err_ipsec_clean/err_mcs_free. err_del_mcam_entries
> calls otx2_mcam_flow_del() again, so the call at err_mcam_flow_del
> looks redundant.
>
> Could that first call be dropped, with the labels folded, so the probe
> error path mirrors otx2_remove()? Or is there a reason the MCAM flows
> have to be deleted before unregister_netdev() here?
>
> --
> Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261109033154.2161803-1-rkannoth%40marvell.com
