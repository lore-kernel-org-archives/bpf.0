Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C95F82D3225;
	Mon, 19 Oct 2026 02:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792375541; cv=none; b=L4CJIRQX41gIqjIELnXzqWE9srr3KjhPyXg6CfpvBXvNM/TrH7688qO6sy65fEYTmycezvVZ2Bv9Nw2Wwe3q4poyNhSYYJuNt510aMOOJAleTVNGG/OQQTO+QN4aFgNMd9battnLm1SdUa+XflaiLsVRHRBGo1dQDczIOLeNEBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792375541; c=relaxed/simple;
	bh=lwinPgx0CZ5wkbiMfYEdcgDi7tlb+oggJPtWf5y7XTo=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Quh9fKfvVnwrFrnSoKaZKWKENqzPtNbfa87UwtEgUYdWm6ohcB2NXCur8PLTRpGnR9eH99UdnWwBn3jF2ZPPgJAonHuufv2OQll7LiAiQnPiF5otWBXh3LUQ4QPXq0bO/Bik7WPW59ueHvUXhgdWf1QK28zsdRAVfF8crGdUZM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=WIIjeBbT; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="WIIjeBbT"
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69J1ISuU3916939;
	Sun, 18 Oct 2026 19:05:11 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=I
	NOT/SaBinoe041hZslNrW+vQOeY5Fukiv1QSBycCuI=; b=WIIjeBbTH4Qn/w4wj
	czFbUT/qY4zGv1nv4QT9miR0WPpaepIOoVk819DY4W1kxu3V7na27sP7JKuJFgIv
	O36SwLXa16b1e//ZAMq7lO+fd5+zyFTZzaOoiTFDcrDSS+4BKGp5UKkE5fmfMb8/
	7bGDQ1A+pNf02DRrHuz9bfNUDWcjaUaqqp7dSSX6wQn7Ce0zZEvQ/4RWDaS4+htU
	i0iJtwlznPcB8AjMMVdfzxXRHDvu73O+CsArx30KdupmASC06S/AzgUjkQMUmWie
	E6XhLbkSVAq9uJ+0KQyXGZeQnzzPKWAPOy3XGjs1JAFteKKNEGSGDJWE8gLpv7vV
	CAZsA==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4hc6cj3t3r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 18 Oct 2026 19:05:11 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Sun, 18 Oct 2026 19:05:10 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Sun, 18 Oct 2026 19:05:10 -0700
Received: from rkannoth-OptiPlex-7090 (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id 64A7D3F7067;
	Sun, 18 Oct 2026 19:05:06 -0700 (PDT)
Date: Mon, 19 Oct 2026 07:35:05 +0530
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <netdev-bot+sashiko@kernel.org>
CC: <bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <netdev@vger.kernel.org>, <andrew+netdev@lunn.ch>, <ast@kernel.org>,
        <daniel@iogearbox.net>, <davem@davemloft.net>, <edumazet@kernel.org>,
        <hawk@kernel.org>, <john.fastabend@gmail.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <sdf@fomichev.me>, <sgoutham@marvell.com>,
        <horms@kernel.org>
Subject: Re: [PATCH v20 net-next 1/2] octeontx2: use atomic bitops for PF/VF
 and rep flags
Message-ID: <atV60YxlUUmKoOD7@rkannoth-OptiPlex-7090>
References: <20261014023431.1775238-2-rkannoth@marvell.com>
 <179229176614.3135.15223480028363952634@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <179229176614.3135.15223480028363952634@kernel.org>
X-Proofpoint-ORIG-GUID: yOgbeG6t8Ef6b9oNz5lrWVVinyW8myd-
X-Authority-Analysis: v=2.4 cv=L7KI0OT8 c=1 sm=1 tr=0 ts=6ad57ad7 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=EAYMVhzMl8SCOHhVQcBL:22 a=9R54UkLUAAAA:8
 a=M5GUcnROAAAA:8 a=VwQbUJbxAAAA:8 a=tH0sOK6vZEEzpobvoDgA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=YTcpBFlVQWkNscrzJ_Dz:22 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDAwNyBTYWx0ZWRfX26JiLCpNVWJM
 RxswE7h+kdtK4Ih37m0+Q13Uw44SmqGWfuhtRtJlZ1o5CZQRk1nhYjFKuvWC0FavUyu7mbHI5AM
 puGUl502OGvRMzNGanA1fSKdzcGb75zpPU0Leg6zvpV8k+lMY43DZVsOyM1aE2RmP93ZhTr1Ls3
 b7ekCPslhglL3LCQ85R5WFxk4FZNTE1zuaiYaJDs5T6Dk5HdSxrgG0tezrcEpKFAwjrtfHgtHXE
 xiHcaql6GxvnpPpWH69D/ca9QAIv/iI5d/sNi1/k7XVvDaIouMtkaIXne37BU6xFXQZtxcuMgSM
 1Nx2l9jm21QSysOTU1AJ/qis2FhXCNbWiqADVCRxS74/r/mdiBIX1jh+EQmdkMIWZpmj/TohSNa
 hvhUFHPa6Ehgi3RzjCFDm/zY2HP56//C2OumBQyr406VLmm3LLMS1jfjEo2GpYM9UENk6iCuEkJ
 rKFmnFojxsHGKN3XUOA==
X-Proofpoint-GUID: yOgbeG6t8Ef6b9oNz5lrWVVinyW8myd-
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDAwNyBTYWx0ZWRfX3tKH7b3p2Bxb
 WgzRzh2NmscBLM01kZ9ZBQn52I6hP8NrYyAswa8rBtnAkMnQg804J46C8ImNmHZPQ4QeVJAUUX3
 lTZfHv4U0PLlv4mei/5eH5SDktCwJPM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_01,2026-10-14_01,2025-10-01_01

On 2026-10-18 at 08:19:26, netdev-bot+sashiko@kernel.org (netdev-bot+sashiko@kernel.org) wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential
> issue(s) to consider.
>
> Critical: 0 (1) · High: 1 (3) · Medium: 1 (5) · Low: 0
>
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
>
> - [High] otx2_sync_flags_from_rep() (otx2_common.h:625-634) updates
>   priv->flags with a non-atomic read-modify-write: `new =…
This is not a regression from this patch. The race already existed, and the patch narrows it.

> - [Medium] The commit message presents this patch as a cleanup that
>   switches flag updates to atomic bitops.
the fix to the representor path is a side effect of this patch, not its purpose

>
> Pre-existing issues:
> - [Critical] rvu_rep_get_stats64() calls
>   schedule_delayed_work(&rep->stats_wrk, 100ms) whenever…
> - [High] rvu_rep_setup_tc_cb() ignores the return value of
>   rvu_rep_mcam_flow_init() and then publishes rep->flow_cfg as…
> - [High] rvu_rep_destroy() reads rep->flow_cfg after freeing the memory
>   that holds rep.
> - [High] rvu_rep_mcam_flow_init() builds and sends AF mailbox messages on
>   priv->mbox (otx2_mbox_alloc_msg_npc_mcam_alloc_entry() /…
> - [Medium] The new comment on OTX2_REP_SYNC_FLAGS_MASK says only
>   MCAM_ENTRIES_ALLOC, NTUPLE_SUPPORT, TC_FLOWER_SUPPORT and…
> - [Medium] In otx2_tc_del_flow(), deleting any marked flower rule clears
>   OTX2_FLAG_TC_MARK_ENABLED even if other marked rules are still…
> - [Medium] rvu_rep_mcam_flow_init() zero-allocates rep->flow_cfg with
>   kzalloc_objs() and never sets mark_flows to 1.
> - [Medium] In otx2_config_hwtstamp_set() (otx2_pf.c), a direct switch
>   from HWTSTAMP_TX_ONESTEP_SYNC to HWTSTAMP_TX_ON leaves…
> - [Medium] The representor flow_cfg lifecycle leaks memory in two ways.
>
> --
>
> octeontx2: use atomic bitops for PF/VF and rep flags
>
> This converts the otx2_nic and rep_dev flags from u64 masks to unsigned
> long bitmaps updated with set_bit()/clear_bit()/test_bit(). It also adds
> otx2_sync_flags_from_rep(), which copies a masked set of representor-owned
> bits onto the shared PF context. The representor VF-initialized flag moves
> to OTX2_FLAG_REP_VF_INITIALIZED (bit 21).
>
> > diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
> > index 3c7275d545bba..0dc4c44e521d9 100644
> > --- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
> > +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
> > @@ -482,6 +482,41 @@ struct pf_irq_data {
> >  	int mdevs;
> >  };
> >
> > +enum otx2_flag_bits {
> > +	OTX2_FLAG_RX_TSTAMP_ENABLED,
>
> [ ... ]
>
> > +	OTX2_FLAG_TC_MARK_ENABLED,
> > +	OTX2_FLAG_REP_MODE_ENABLED,
> > +	OTX2_FLAG_PORT_UP,
> > +	OTX2_FLAG_IPSEC_OFFLOAD_ENABLED,
> > +	OTX2_FLAG_REP_VF_INITIALIZED,
> > +	OTX2_FLAG_MAX,
> > +};
> > +
> > +/* Representor-owned flags copied onto the PF mailbox context in
> > + * rvu_rep_setup_tc_cb().  All other bits are owned by the PF/VF netdev.
> > + */
> > +#define OTX2_REP_SYNC_FLAGS_MASK				\
> > +	(BIT(OTX2_FLAG_MCAM_ENTRIES_ALLOC) |			\
> > +	 BIT(OTX2_FLAG_NTUPLE_SUPPORT) |			\
> > +	 BIT(OTX2_FLAG_TC_FLOWER_SUPPORT) |			\
> > +	 BIT(OTX2_FLAG_REP_VF_INITIALIZED))
>
> [Severity: Medium]
> This isn't a bug introduced by this patch, but does this comment get the
> owner of OTX2_FLAG_TC_MARK_ENABLED right?
>
> On the representor path, rvu_rep_setup_tc_cb() points priv->flow_cfg at
> rep->flow_cfg. otx2_tc_parse_actions() then does:
>
>     otx2_set_flag(nic, OTX2_FLAG_TC_MARK_ENABLED);
>     refcount_inc(&nic->flow_cfg->mark_flows);
>
> So the bit lives on the shared priv, but the counter is per-rep.
> otx2_tc_del_flow() then clears the shared bit based on one rep's counter.
>
> Say rep A and rep B both have skbedit mark rules and the rule on rep B is
> deleted. Wouldn't otx2_rcv_pkt_handler() then stop setting skb->mark for
> rep A's traffic?
>
>     if (otx2_test_flag(pfvf, OTX2_FLAG_TC_MARK_ENABLED))
>         skb->mark = parse->match_id;
>
> Before this patch, priv->flags = rep->flags wiped the bit on every
> callback, so representor marking was already broken. This patch changes
> how it fails, but the new comment now describes TC_MARK_ENABLED as owned
> by the PF/VF netdev.
>
> [ ... ]
>
> > @@ -593,6 +607,32 @@ struct otx2_nic {
> >  	unsigned long		*af_xdp_zc_qidx;
> >  };
> >
>
> [ ... ]
>
> > +static inline void otx2_sync_flags_from_rep(struct otx2_nic *dst,
> > +					    unsigned long *src_flags)
> > +{
> > +	unsigned long src = READ_ONCE(*src_flags);
> > +	unsigned long new_flags;
> > +
> > +	new_flags = (READ_ONCE(dst->flags) & ~OTX2_REP_SYNC_FLAGS_MASK) |
> > +		    (src & OTX2_REP_SYNC_FLAGS_MASK);
> > +	WRITE_ONCE(dst->flags, new_flags);
> > +}
>
> [Severity: High]
> Can this read-modify-write lose a concurrent set_bit() or clear_bit() on
> priv->flags?
>
> Every other writer of this word now uses atomic bitops. Any update that
> lands between the READ_ONCE() and the WRITE_ONCE() here is overwritten
> with the stale value.
>
> rvu_rep_setup_tc_cb() runs from the flower block callback under rtnl
> only. rvu_rep_destroy() and rvu_rep_create()->rvu_rep_napi_init() are
> called from otx2_devlink_eswitch_mode_set() holding only the devlink
> instance lock. During that time the rep netdevs and their TC blocks are
> still registered:
>
> CPU1 (tc flower on a rep)
> rvu_rep_setup_tc_cb()
>   otx2_sync_flags_from_rep()
>     new_flags = (READ_ONCE(dst->flags) & ~MASK) | ...
>
> CPU2 (devlink eswitch mode legacy)
> rvu_rep_destroy()
>   otx2_set_flag(priv, OTX2_FLAG_INTF_DOWN);
>
> CPU1
>     WRITE_ONCE(dst->flags, new_flags);   <- INTF_DOWN lost
>
> If INTF_DOWN is lost, otx2_napi_handler() would re-arm the CQ interrupt
> through NIX_LF_CINTX_ENA_W1S during teardown. rvu_rep_remove() would
> later see INTF_DOWN clear and call rvu_rep_destroy() a second time on the
> already freed priv->reps.
>
> The opposite direction looks possible too. The clear of INTF_DOWN in
> rvu_rep_napi_init() could be undone, and the representor datapath would
> never get its interrupts re-enabled.
>
> Would set_mask_bits(&dst->flags, OTX2_REP_SYNC_FLAGS_MASK,
> src & OTX2_REP_SYNC_FLAGS_MASK), or a try_cmpxchg() loop, match what the
> commit message says about atomic bitops and "without clearing PF-owned
> bits"?
>
> > diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
> > index 7dc0ce669d0b7..777e7156badb7 100644
> > --- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
> > +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
>
> [ ... ]
>
> > @@ -2538,8 +2538,8 @@ int otx2_config_hwtstamp_set(struct net_device *netdev,
> >
> >  	switch (config->tx_type) {
> >  	case HWTSTAMP_TX_OFF:
> > -		if (pfvf->flags & OTX2_FLAG_PTP_ONESTEP_SYNC)
> > -			pfvf->flags &= ~OTX2_FLAG_PTP_ONESTEP_SYNC;
> > +		if (otx2_test_flag(pfvf, OTX2_FLAG_PTP_ONESTEP_SYNC))
> > +			otx2_clear_flag(pfvf, OTX2_FLAG_PTP_ONESTEP_SYNC);
> >
> >  		cancel_delayed_work(&pfvf->ptp->synctstamp_work);
> >  		otx2_config_hw_tx_tstamp(pfvf, false);
> > @@ -2550,7 +2550,7 @@ int otx2_config_hwtstamp_set(struct net_device *netdev,
> >  					   "One-step time stamping is not supported");
> >  			return -ERANGE;
> >  		}
> > -		pfvf->flags |= OTX2_FLAG_PTP_ONESTEP_SYNC;
> > +		otx2_set_flag(pfvf, OTX2_FLAG_PTP_ONESTEP_SYNC);
> >  		schedule_delayed_work(&pfvf->ptp->synctstamp_work,
> >  				      msecs_to_jiffies(500));
> >  		fallthrough;
>
> [Severity: Medium]
> This is a pre-existing issue, but what clears OTX2_FLAG_PTP_ONESTEP_SYNC
> when the mode switches straight from HWTSTAMP_TX_ONESTEP_SYNC to
> HWTSTAMP_TX_ON?
>
> Only the HWTSTAMP_TX_OFF case clears it. The HWTSTAMP_TX_ON case only
> does:
>
>     case HWTSTAMP_TX_ON:
>         otx2_config_hw_tx_tstamp(pfvf, true);
>         break;
>
> otx2_set_txtstamp() would keep taking the one-step branch for PTP Sync
> packets. It rewrites the origin timestamp and never sets
> SKBTX_IN_PROGRESS, so the requested two-step mode isn't applied until
> there is an OFF request in between.
>
> > diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c
> > index dee38d5c7f65b..8877af348a090 100644
> > --- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c
> > +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c
>
> [ ... ]
>
> > @@ -505,7 +505,7 @@ static int otx2_tc_parse_actions(struct otx2_nic *nic,
> >  			mark = act->mark;
> >  			req->match_id = mark & OTX2_RX_MATCH_ID_MASK;
> >  			req->op = NIX_RX_ACTION_DEFAULT;
> > -			nic->flags |= OTX2_FLAG_TC_MARK_ENABLED;
> > +			otx2_set_flag(nic, OTX2_FLAG_TC_MARK_ENABLED);
> >  			refcount_inc(&nic->flow_cfg->mark_flows);
> >  			break;
>
> [Severity: Medium]
> This isn't a bug introduced by this patch, but for representors, is
> mark_flows ever initialized before this refcount_inc()?
>
> rvu_rep_mcam_flow_init() allocates rep->flow_cfg with kzalloc_objs() and
> never sets mark_flows. The only refcount_set(&flow_cfg->mark_flows, 1) is
> in otx2_mcam_entry_init(), which representors don't use.
>
> A rule such as "tc filter add dev <rep> ... action skbedit mark N" would
> then go through:
>
> rvu_rep_setup_tc_cb()->otx2_setup_tc_cls_flower()->otx2_tc_add_flow()
>   ->otx2_tc_prepare_flow()->otx2_tc_parse_actions()
>     refcount_inc(&nic->flow_cfg->mark_flows);   /* from 0 */
>
> That fires the "addition on 0; use-after-free" warning in
> refcount_warn_saturate() and saturates the counter. After that,
> refcount_dec_and_test() in otx2_tc_del_flow() always returns false.
>
> otx2_sync_flags_from_rep() now keeps TC_MARK_ENABLED on priv across
> callbacks, so this broken counter is the only thing that decides when the
> flag gets cleared.
>
> [ ... ]
>
> > @@ -1195,12 +1195,12 @@ static int otx2_tc_del_flow(struct otx2_nic *nic,
> >  	/* Disable TC MARK flag if they are no rules with skbedit mark action */
> >  	if (flow_node->req.match_id)
> >  		if (!refcount_dec_and_test(&flow_cfg->mark_flows))
> > -			nic->flags &= ~OTX2_FLAG_TC_MARK_ENABLED;
> > +			otx2_clear_flag(nic, OTX2_FLAG_TC_MARK_ENABLED);
>
> [Severity: Medium]
> This is a pre-existing issue, but is this condition inverted?
>
> otx2_mcam_entry_init() sets mark_flows to 1, and each FLOW_ACTION_MARK
> adds one. With two marked rules the count is 3. Deleting one brings it to
> 2, refcount_dec_and_test() returns false, and the flag is cleared.
>
> Because of the base reference, deleting mark rules never brings the
> counter to 0. Wouldn't every delete of a marked rule clear
> OTX2_FLAG_TC_MARK_ENABLED, so that otx2_rcv_pkt_handler() stops setting
> skb->mark for the rules still installed?
>
> [ ... ]
>
> > diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/rep.c b/drivers/net/ethernet/marvell/octeontx2/nic/rep.c
> > index 0f5d5642d3f7a..7df82c22cc12b 100644
> > --- a/drivers/net/ethernet/marvell/octeontx2/nic/rep.c
> > +++ b/drivers/net/ethernet/marvell/octeontx2/nic/rep.c
> > @@ -93,9 +93,9 @@ static int rvu_rep_mcam_flow_init(struct rep_dev *rep)
> >  	rep->flow_cfg->max_flows = allocated;
> >
> >  	if (allocated) {
> > -		rep->flags |= OTX2_FLAG_MCAM_ENTRIES_ALLOC;
> > -		rep->flags |= OTX2_FLAG_NTUPLE_SUPPORT;
> > -		rep->flags |= OTX2_FLAG_TC_FLOWER_SUPPORT;
> > +		set_bit(OTX2_FLAG_MCAM_ENTRIES_ALLOC, &rep->flags);
> > +		set_bit(OTX2_FLAG_NTUPLE_SUPPORT, &rep->flags);
> > +		set_bit(OTX2_FLAG_TC_FLOWER_SUPPORT, &rep->flags);
> >  	}
>
> [Severity: High]
> This isn't a bug introduced by this patch, but does
> rvu_rep_mcam_flow_init() ever take priv->mbox.lock?
>
> It allocates and sends AF messages without the lock:
>
>     while (allocated < count) {
>         req = otx2_mbox_alloc_msg_npc_mcam_alloc_entry(&priv->mbox);
>         ...
>         if (otx2_sync_mbox_msg(&priv->mbox))
>             goto exit;
>
> and then unlocks unconditionally at the exit label:
>
> exit:
>     ...
>     mutex_unlock(&priv->mbox.lock);
>
> Its only caller, rvu_rep_setup_tc_cb(), holds rtnl but not the mbox
> mutex. rvu_rep_get_stats(), rvu_eswitch_config() and the otx2_tc_*
> helpers all serialize on priv->mbox.lock.
>
> Can these MCAM allocation messages interleave with the stats work's
> mailbox traffic and corrupt the shared mbox region?
>
> And if another task holds mbox.lock at that point, doesn't this
> mutex_unlock() release that task's critical section?
>
> [Severity: Medium]
> This is also a pre-existing issue, but do rep->flow_cfg and its flow_ent
> leak here?
>
> rvu_rep_mcam_flow_init() allocates a new flow_cfg and flow_ent on every
> call and never frees the previous ones. It also doesn't free flow_cfg
> when the flow_ent kcalloc() fails:
>
>     rep->flow_cfg = kzalloc_objs(struct otx2_flow_config, 1);
>     ...
>     rep->flow_cfg->flow_ent = kcalloc(count, sizeof(u16), GFP_KERNEL);
>     if (!rep->flow_cfg->flow_ent)
>         return -ENOMEM;
>
> rvu_rep_setup_tc_cb() calls it again on every TC callback while
> TC_FLOWER_SUPPORT stays clear, including FLOW_CLS_STATS from dumps.
> TC_FLOWER_SUPPORT stays clear after a flow_ent allocation failure, a
> mailbox failure, or an MCAM allocation that returns zero entries.
>
> Separately, rvu_rep_destroy() only does kfree(rep->flow_cfg).
> flow_cfg->flow_ent is never freed, and the MCAM entries allocated for the
> rep's pcifunc are never released to the AF.
>
> > @@ -109,14 +109,14 @@ static int rvu_rep_setup_tc_cb(enum tc_setup_type type,
> >  	struct rep_dev *rep = cb_priv;
> >  	struct otx2_nic *priv = rep->mdev;
> >
> > -	if (!(rep->flags & RVU_REP_VF_INITIALIZED))
> > +	if (!test_bit(OTX2_FLAG_REP_VF_INITIALIZED, &rep->flags))
> >  		return -EINVAL;
> >
> > -	if (!(rep->flags & OTX2_FLAG_TC_FLOWER_SUPPORT))
> > +	if (!test_bit(OTX2_FLAG_TC_FLOWER_SUPPORT, &rep->flags))
> >  		rvu_rep_mcam_flow_init(rep);
>
> [Severity: High]
> This isn't a bug introduced by this patch, but what happens when
> rvu_rep_mcam_flow_init() returns -ENOMEM here?
>
> The return value is dropped, and rep->flow_cfg is published below in one
> of two broken states:
>
> - NULL, if kzalloc_objs() failed.
> - With zeroed list heads, if the flow_ent kcalloc() failed, because that
>   path skips INIT_LIST_HEAD().
>
> FLOW_CLS_REPLACE bails out early because TC_FLOWER_SUPPORT is clear.
> FLOW_CLS_DESTROY, however, goes straight to:
>
> otx2_setup_tc_cls_flower()->otx2_tc_del_flow()
>   ->otx2_tc_get_entry_by_cookie()
>       list_for_each_entry(tmp, &flow_cfg->flow_list_tc, list)
>
> Wouldn't that dereference a NULL flow_cfg, or follow a NULL ->next from a
> zeroed list head? tc core issues the destroy when a skip_sw replace fails,
> and when a non-skip_hw filter is deleted.
>
> >
> >  	priv->netdev = rep->netdev;
> > -	priv->flags = rep->flags;
> > +	otx2_sync_flags_from_rep(priv, &rep->flags);
> >  	priv->pcifunc = rep->pcifunc;
> >  	priv->flow_cfg = rep->flow_cfg;
>
> [Severity: Medium]
> This change looks like it fixes a real bug, but the commit message only
> hints at it:
>
>   ... giving lockless NAPI readers a consistent word without clearing
>   PF-owned bits.
>
>   Relocate representor VF initialization to OTX2_FLAG_REP_VF_INITIALIZED
>   (bit 21).
>
> Before this patch, priv->flags = rep->flags overwrote every PF-owned bit
> on the shared rep PF otx2_nic. rvu_rep_probe() sets
> OTX2_FLAG_REP_MODE_ENABLED on priv, but rep->flags never has it, so any
> flower callback on a representor cleared it.
>
> The old RVU_REP_VF_INITIALIZED was BIT_ULL(0), the same bit as
> OTX2_FLAG_RX_TSTAMP_ENABLED. The callback only proceeds when that bit is
> set, so the copy also set RX_TSTAMP_ENABLED on priv.
>
> With REP_MODE_ENABLED cleared, otx2_tx_napi_handler() uses pfvf->netdev,
> which the callback has just set to the last rep's netdev. It also stops
> forcing qidx to 0:
>
>     if (otx2_test_flag(pfvf, OTX2_FLAG_REP_MODE_ENABLED))
>         qidx = 0;
>     txq = netdev_get_tx_queue(ndev, qidx);
>
> That means netdev_tx_completed_queue() could update a netdev_queue past
> the single TX queue that alloc_etherdev() allocates for the rep.
>
> Should the commit message describe this representor TX/RX breakage and
> carry a Fixes: tag so it gets picked up for stable? Something like:
>
> Fixes: 6c40ca957fe5 ("octeontx2-pf: Adds TC offload support")
>
> [ ... ]
>
> > @@ -382,7 +382,7 @@ static void rvu_rep_get_stats64(struct net_device *dev,
> >  {
> >  	struct rep_dev *rep = netdev_priv(dev);
> >
> > -	if (!(rep->flags & RVU_REP_VF_INITIALIZED))
> > +	if (!test_bit(OTX2_FLAG_REP_VF_INITIALIZED, &rep->flags))
> >  		return;
> >
> >  	stats->rx_packets = rep->stats.rx_frames;
>
> [Severity: Critical]
> This is a pre-existing issue, but is stats_wrk ever cancelled before the
> rep netdev is freed?
>
> Further down, rvu_rep_get_stats64() does:
>
>     schedule_delayed_work(&rep->stats_wrk, msecs_to_jiffies(100));
>
> stats_wrk is embedded in struct rep_dev, which is netdev_priv(rep->netdev).
> Neither rvu_rep_destroy() nor the rvu_rep_create() error path calls
> cancel_delayed_work_sync() before free_netdev().
>
> unregister_netdev() itself re-arms the work through the RTM_DELLINK
> message:
>
> unregister_netdev()->...->rtnl_fill_ifinfo()->rtnl_fill_stats()
>   ->dev_get_stats()->rvu_rep_get_stats64()
>     schedule_delayed_work(&rep->stats_wrk, ...)
>
> Any stats read does the same, including unprivileged ones such as
> /proc/net/dev or ip -s link.
>
> About 100ms after free_netdev(), wouldn't the timer fire from freed
> memory? rvu_rep_get_stats() would then do container_of() on the freed rep,
> dereference rep->mdev and take priv->mbox.lock.
>
> There is also an ordering question in rvu_rep_create().
> INIT_DELAYED_WORK(&rep->stats_wrk, rvu_rep_get_stats) runs only after
> register_netdev(). Can the RTM_NEWLINK stats fill schedule the work before
> it is initialized?
>
> [ ... ]
>
> > @@ -632,7 +632,7 @@ void rvu_rep_destroy(struct otx2_nic *priv)
> >  	int rep_id;
> >
> >  	rvu_eswitch_config(priv, false);
> > -	priv->flags |= OTX2_FLAG_INTF_DOWN;
> > +	otx2_set_flag(priv, OTX2_FLAG_INTF_DOWN);
> >  	rvu_rep_free_cq_rsrc(priv);
> >  	for (rep_id = 0; rep_id < priv->rep_cnt; rep_id++) {
> >  		rep = priv->reps[rep_id];
>
> [Severity: High]
> This isn't a bug introduced by this patch, but doesn't the rest of this
> loop read rep after it has been freed?
>
>         unregister_netdev(rep->netdev);
>         rvu_rep_devlink_port_unregister(rep);
>         free_netdev(rep->netdev);
>         kfree(rep->flow_cfg);
>
> In rvu_rep_create(), rep comes from netdev_priv(ndev), so it lives inside
> the netdev allocation. Once unregister_netdev() has completed,
> free_netdev() normally drops the last device reference and frees that
> memory.
>
> kfree(rep->flow_cfg) then loads the pointer from freed memory. With slab
> poisoning that means kfree() of a poison value. With init_on_free,
> flow_cfg leaks. KASAN would report the access on every
> rvu_rep_destroy().
>
> [ ... ]
>
> --
> Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261014023431.1775238-1-rkannoth%40marvell.com
