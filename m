Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=67.231.156.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794448648;
	b=LWhMT7p+ZWZyLUQf8VcsB1QSItDjnmIFnfcBeeRpJoCEi7Nje8psrj++N/JQFKaUAuCi
	 QVz+Yca/kE/nS8ZK0UCRHYzVTvuhwSyrUwD5HUK5Ban52AZRJ3YzoTgqzurNCsCIjtNxX
	 TrJ2PZIN8AkcmmW9pbi+fj4TNd9YH97TfxEJheujI/4Pva3Zgj3TUFJw/cIY6OpzPJqHA
	 0rQNvY/ppP3D3aY3ybsmRLSjT0N3/wHutspQCbsGNzdnmwhvPrp7hSQQ4L1fPvABxhiPS
	 np7vpxrwzOyfG1/AqUPZTIgGqD4U/10gmkQhHGKYiPF1oxAQ34lnNfhLAP74jGidaQQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794448648;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:Content-Transfer-Encoding:
	 In-Reply-To:X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version;
	bh=KGCRrDaZbOc+T5yUFcwFcqH1W5IHrxyX5ByXMpcohnA=;
	b=VekhB+989YxTVTImiWw5mTuTqos20PI1CLzr87kSgUpMCsX2ffhH4WeIKAsqZTK0wXHo
	 IbXZeFlueNrf3AO0zQiijtSx2F9WfEvffCoZ2ZYjb93bDmSFnBeubw2ZHHVF7bTDQw9uu
	 1jPhtHdOC4FFxUpOqbkIgqbc2avEuUCcOqTEmIyP6SmJd618tixiGxASEgsQPXUAt4DMt
	 eAUCMZUiqVeKDv21xSq5T7RL8/VeobIHY3hA+f9XPoQyNJ/hXxpZFiCtpG3UCtqhTrm8X
	 zNRDGetOiH0Oyye+8iavfhj6K+thHRRyVvxakTaA5/mDTDsNDgYYRonI6Ly6Nr5IhaQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=marvell.com;
	spf=pass smtp.mailfrom=marvell.com;
	dkim=pass header.d=marvell.com header.i=@marvell.com header.a=rsa-sha256 header.s=pfpt0220 header.b=FZN2fjIY;
	arc=none smtp.remote-ip=67.231.156.173
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86F06606A886;
	Thu, 12 Nov 2026 01:57:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 86F06606A886
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.a=rsa-sha256 header.s=pfpt0220 header.b=FZN2fjIY
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ABNQAAM2940652;
	Wed, 11 Nov 2026 17:57:01 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=K
	GCRrDaZbOc+T5yUFcwFcqH1W5IHrxyX5ByXMpcohnA=; b=FZN2fjIYZofqhjkxw
	U0wcA6imUUVzPg7ZQJ8doRMNcIjtnZ4jxyZKqPuU3UHXkNfFpuMSCdKXM7nojuBq
	uGJ+rM4PMcyeZlpMKHvcr4HwTqmeL+fSsgEQR154K0q5cKl/iCcdV4R4+M9iLrm2
	hZ3J8Uor1icMBavzPBkWOeY7f2e8wy47EpA+zWzXhiR5FgAtRutDXUcdKnizRMhC
	FrM9UFVN4zulQm0OOgRiwSglHQ6a89I+RL4hcYC5JjnAC2nppDur+Ajv8ZIok7uE
	SmxB1HV+FVEshB0cPH8rVVjJE6Tj03lbXIJQF+K8iEuHLAzIgm727BxZOvaRnrym
	nbV+g==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4hvp3jvf17-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Nov 2026 17:57:01 -0800 (PST)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 11 Nov 2026 17:56:57 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Wed, 11 Nov 2026 17:56:57 -0800
Received: from rkannoth-OptiPlex-7090 (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id 94CEF3F707D;
	Wed, 11 Nov 2026 17:56:55 -0800 (PST)
Date: Thu, 12 Nov 2026 07:26:54 +0530
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <netdev-bot+sashiko@kernel.org>
CC: <bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <netdev@vger.kernel.org>, <andrew+netdev@lunn.ch>, <ast@kernel.org>,
        <daniel@iogearbox.net>, <davem@davemloft.net>, <edumazet@kernel.org>,
        <hawk@kernel.org>, <john.fastabend@gmail.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <sdf@fomichev.me>, <sgoutham@marvell.com>,
        <horms@kernel.org>
Subject: Re: [PATCH v21 net-next 1/2] octeontx2: use atomic bitops for PF/VF
 and rep flags
Message-ID: <avUc5kA5hfi8MiBW@rkannoth-OptiPlex-7090>
References: <20261109033154.2161803-2-rkannoth@marvell.com>
 <179443274883.2199510.3348914597691786144@kernel.org>
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
In-Reply-To: <179443274883.2199510.3348914597691786144@kernel.org>
X-Authority-Analysis: v=2.4 cv=N968hG9B c=1 sm=1 tr=0 ts=6af51ced cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=QXcCYyLzdtTjyudCfB6f:22 a=VwQbUJbxAAAA:8
 a=9R54UkLUAAAA:8 a=M5GUcnROAAAA:8 a=QR35sanbWkD7n226fW0A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=YTcpBFlVQWkNscrzJ_Dz:22 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEyMDAwNyBTYWx0ZWRfX+N7RQeq3Cdqy
 OkkeU17AILg3MaFllowtryA6PpIf4HikcQnEyW3CIJVIpBm1gCQGnMyTcXmVSfQ+uhl79QwtPXs
 UvAotty7kSiz0O0KysSjd/VdSs5ABE92TBkrbkUoxO02k5XO5/4I0W0/vDTzgu4OldCdt4QxtTN
 UR5bAhySfdTuZeyeGC7fbO+JVmzuV0tyAlRXEN/YMTHxELF0M0v5wnmM0jBf5Z5P91cA5cmOFrX
 df3uLdQ3eTlI1vEVzbKd0rFYxgCKChnPhDWA0wemUOA49UXyNRmN2wkZ0QgtwnkipAmLyezE8z5
 /L6gY69ofQnJ6thvI/GEEv1QnNpvVpCx7OKZzCssKOol1buI9/PWMOXH6AggYrhe0ZrHf8gnLio
 4ssIWqRzgc1dOs9hBwLJ6kzcT0IcotRIkUj6mnIV1LWrRewXE2E06gOR0eoCmkcYuVjIIt8vujM
 e3+81KoXiMVeR6Uyh3g==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEyMDAwNyBTYWx0ZWRfXyhTW9Vho0HXX
 HnopxjuwHFuXC9EUv0kxZty193scRVgWbNBBFSRNXFAD+VjxzcZS91a/kH5x9sKR7qhIGNeWG5i
 imP3HADXC0p2fpQLta99TpFHRkK+XnQ=
X-Proofpoint-ORIG-GUID: kue9KG_JfSP4nexyIAl_CsfV2ZZb4uRP
X-Proofpoint-GUID: kue9KG_JfSP4nexyIAl_CsfV2ZZb4uRP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-11_06,2026-11-11_03,2025-10-01_01

On 2026-11-12 at 03:02:28, netdev-bot+sashiko@kernel.org (netdev-bot+sashiko@kernel.org) wrote:
> Thank you for your contribution! Sashiko AI review found 4 potential
> issue(s) to consider.
>
> Critical: 0 (1) · High: 1 (4) · Medium: 2 (1) · Low: 1

v21 is RESEND of v20

v20 sashiko comments reply : https://lore.kernel.org/netdev/atV60YxlUUmKoOD7@rkannoth-OptiPlex-7090/

>
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
>
> - [High] otx2_sync_flags_from_rep()
>   (drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h) is the only…
> - [Medium] The commit message hides that this patch fixes a real bug, and
>   it has no Fixes: tag.
> - [Medium] Before this patch, `priv->flags = rep->flags` always cleared
>   OTX2_FLAG_INTF_DOWN on the eswitch PF context before calling into the…
> - [Low] The commit message says the flags now use atomic bitops and that
>   otx2_sync_flags_from_rep() publishes representor flags "without…
>
> Pre-existing issues:
> - [Critical] rvu_rep_state_evt_handler()
>   (drivers/net/ethernet/marvell/octeontx2/nic/rep.c) does `rep_id =…
> - [High] rep->stats_wrk is set up with INIT_DELAYED_WORK in
>   rvu_rep_create().
> - [High] In rvu_rep_destroy()
>   (drivers/net/ethernet/marvell/octeontx2/nic/rep.c),…
> - [High] rvu_rep_mcam_flow_init()
>   (drivers/net/ethernet/marvell/octeontx2/nic/rep.c) builds and sends…
> - [High] Any PF or VF, including a VF owned by a guest since the PF
>   forwards all VF mbox messages to AF, can send REP_EVENT_NOTIFY with…
> - [Medium] rvu_rep_setup_tc_cb() calls rvu_rep_mcam_flow_init(rep) on
>   every tc callback while OTX2_FLAG_TC_FLOWER_SUPPORT is clear in…
>
> --
>
> octeontx2: use atomic bitops for PF/VF and rep flags
>
> This converts the otx2_nic and rep_dev flags from u64 masks to unsigned
> long bitmaps, updated through set_bit()/clear_bit()/test_bit() helpers.
> In rvu_rep_setup_tc_cb(), the full-word assignment is replaced by
> otx2_sync_flags_from_rep(), which copies a mask of representor-owned bits
> onto the eswitch PF context. The representor VF-initialized flag moves
> from BIT_ULL(0) in rep.h to OTX2_FLAG_REP_VF_INITIALIZED (bit 21).
>
> > Switch PF/VF and representor flags from non-atomic u64 masks to unsigned
> > long bitmaps with set_bit/clear_bit/test_bit.  Add helpers and
> > otx2_sync_flags_from_rep() to publish representor-owned flags onto the PF
> > mailbox context with a masked WRITE_ONCE, giving lockless NAPI readers a
> > consistent word without clearing PF-owned bits.
>
> [Severity: Low]
> Is "without clearing PF-owned bits" accurate? otx2_sync_flags_from_rep()
> does a plain READ_ONCE()/mask/WRITE_ONCE() read-modify-write of
> dst->flags. Every other writer of that word now uses set_bit() or
> clear_bit().
>
> If an atomic update to a PF-owned bit lands between the read and the
> write, it gets overwritten. So the guarantee only holds when nothing else
> is writing at the same time. There are more details on this below, at
> otx2_sync_flags_from_rep().
>
> Could the commit message also say which concurrent update problem the
> atomic conversion is meant to fix?
>
> > Relocate representor VF initialization to OTX2_FLAG_REP_VF_INITIALIZED
> > (bit 21).
>
> [Severity: Medium]
> Is this only a relocation? Before this patch, rvu_rep_setup_tc_cb() did:
>
>     priv->flags = rep->flags;
>
> That overwrote the whole flags word of the eswitch PF otx2_nic, including
> OTX2_FLAG_REP_MODE_ENABLED, which rvu_rep_probe() sets.
>
> The removed RVU_REP_VF_INITIALIZED was also BIT_ULL(0), the same bit as
> OTX2_FLAG_RX_TSTAMP_ENABLED. The callback only gets past its first check
> when that bit is set, so the bit was copied onto priv every time.
>
> Once REP_MODE_ENABLED was cleared, otx2_tx_napi_handler() stopped taking
> these branches:
>
>     if (otx2_test_flag(pfvf, OTX2_FLAG_REP_MODE_ENABLED))
>         ndev = pfvf->reps[qidx]->netdev;
>     ...
>     if (otx2_test_flag(pfvf, OTX2_FLAG_REP_MODE_ENABLED))
>         qidx = 0;
>     txq = netdev_get_tx_queue(ndev, qidx);
>
> Instead it fell back to pfvf->netdev, which rvu_rep_setup_tc_cb() had
> pointed at rep->netdev. That netdev comes from alloc_etherdev() and has a
> single TX queue, and qidx was no longer clamped. Doesn't that index past
> dev->_tx[] and then write DQL state beyond it?
>
> If so, this patch includes a fix. Would a Fixes: tag and a description of
> the old behaviour help with stable backports?
>
> The mask also changes one more behaviour: OTX2_FLAG_TC_MARK_ENABLED now
> stays set in priv instead of being cleared on every representor tc
> callback. Is that intended, and is it worth mentioning in the commit
> message?
>
> > diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
> > index 8417af94a02a0..f3158e293d864 100644
> > --- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
> > +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
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
> Can this lose concurrent updates to PF-owned bits in priv->flags?
>
> The only caller is rvu_rep_setup_tc_cb(), which runs from the tc block
> callback under rtnl. Other writers of the same word don't hold rtnl. One
> example is the devlink eswitch path:
>
> otx2_devlink_eswitch_mode_set()
>     case DEVLINK_ESWITCH_MODE_LEGACY:
>         rvu_rep_destroy(pfvf);
>             otx2_set_flag(priv, OTX2_FLAG_INTF_DOWN);
>
> This runs under the devlink lock only; unregister_netdev() takes rtnl
> later. rvu_rep_napi_init() clears INTF_DOWN on the same devlink path, and
> the mbox up-handler work sets and clears OTX2_FLAG_PORT_UP.
>
> If one of those set_bit()/clear_bit() calls lands between the READ_ONCE()
> and the WRITE_ONCE() here, the stale word gets written back.
>
> If the INTF_DOWN set is lost, the eswitch PF still looks up after
> teardown. otx2_napi_handler() can then re-arm the CINT, and
> rvu_rep_remove() runs destroy a second time:
>
>     if (!otx2_test_flag(priv, OTX2_FLAG_INTF_DOWN))
>         rvu_rep_destroy(priv);
>
> That second destroy calls unregister_netdev()/free_netdev() on netdevs
> that are already freed, and calls kfree(priv->reps) a second time.
>
> If the INTF_DOWN clear in rvu_rep_napi_init() is lost instead, the CQ
> interrupts are never re-enabled, because otx2_napi_handler() returns
> early:
>
>     if (otx2_test_flag(pfvf, OTX2_FLAG_INTF_DOWN))
>         return workdone;
>
> Would updating only the masked bits with assign_bit(), or using a cmpxchg
> loop, avoid this?
>
> [ ... ]
>
> > diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
> > index 7dc0ce669d0b7..777e7156badb7 100644
> > --- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
> > +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
>
> [ ... ]
>
> > @@ -907,11 +907,11 @@ static int otx2_mbox_up_handler_rep_event_up_notify(struct otx2_nic *pf,
> >
> >  	if (info->event == RVU_EVENT_PORT_STATE) {
> >  		if (info->evt_data.port_state) {
> > -			pf->flags |= OTX2_FLAG_PORT_UP;
> > +			otx2_set_flag(pf, OTX2_FLAG_PORT_UP);
> >  			netif_carrier_on(netdev);
> >  			netif_tx_start_all_queues(netdev);
> >  		} else {
> > -			pf->flags &= ~OTX2_FLAG_PORT_UP;
> > +			otx2_clear_flag(pf, OTX2_FLAG_PORT_UP);
> >  			netif_tx_stop_all_queues(netdev);
> >  			netif_carrier_off(netdev);
> >  		}
>
> [Severity: High]
> This isn't a bug introduced by this patch, but can any PF or VF forge
> this event for a PF it doesn't own?
>
> On the AF side, rvu_mbox_handler_rep_event_notify() only range-checks the
> target:
>
>     if (!is_pf_func_valid(rvu, req->pcifunc))
>         return -EINVAL;
>
> It doesn't check that the sender is rvu->rep_pcifunc.
> rvu_rep_up_notify() then forwards the event and evt_data to
> rvu_get_pf(event->pcifunc). The PF forwards VF mailbox messages to AF
> through otx2_forward_vf_mbox_msgs(), so a VF owned by a guest can send
> this as well.
>
> On the victim PF, port_state=0 stops TX and drops carrier. port_state=1
> sets OTX2_FLAG_PORT_UP, and from then on otx2_handle_link_event() ignores
> real CGX link events until the next otx2_open():
>
>     if (otx2_test_flag(pf, OTX2_FLAG_PORT_UP))
>         return;
>
> Should AF reject REP_EVENT_NOTIFY from anything other than the
> representor PF?
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
> This is a pre-existing issue, but where does rvu_rep_mcam_flow_init()
> take priv->mbox.lock? The loop allocates and sends NPC_MCAM_ALLOC_ENTRY
> messages on priv->mbox without the lock, and the exit path then does:
>
> exit:
>     ...
>     mutex_unlock(&priv->mbox.lock);
>
> Neither this function nor rvu_rep_setup_tc_cb() calls mutex_lock().
>
> Suppose another context holds the mutex at that point, such as the
> rvu_rep_get_stats() worker. Doesn't this release that holder's lock and
> let mailbox messages from both contexts interleave? If nobody holds it,
> this is an unbalanced unlock, which lockdep would report.
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
> [Severity: Medium]
> This isn't a bug introduced by this patch, but does this leak
> rep->flow_cfg and rep->flow_cfg->flow_ent?
>
> rvu_rep_mcam_flow_init() always assigns new kzalloc()/kcalloc() results
> to rep->flow_cfg and rep->flow_cfg->flow_ent. It only sets
> OTX2_FLAG_TC_FLOWER_SUPPORT when allocated > 0.
>
> So if AF returns no entries, a mailbox call fails, or the flow_ent
> allocation fails, the next tc callback calls it again and the previous
> allocations are lost. The return value is also ignored here.
>
> Separately, rvu_rep_destroy() only does kfree(rep->flow_cfg), so flow_ent
> is never freed on teardown.
>
> >
> >  	priv->netdev = rep->netdev;
> > -	priv->flags = rep->flags;
> > +	otx2_sync_flags_from_rep(priv, &rep->flags);
>
> [Severity: Medium]
> Does this change how otx2_tc_del_flow() handles representor rules during
> teardown?
>
> The old full-word assignment always cleared OTX2_FLAG_INTF_DOWN on priv,
> because rep->flags never carried that bit. With the mask, priv keeps its
> real INTF_DOWN value.
>
> rvu_rep_destroy() sets INTF_DOWN before unregister_netdev(rep->netdev).
> Unregistering sends FLOW_CLS_DESTROY through this callback, and for
> police rules otx2_tc_del_flow() then skips the policer and mcast group
> cleanup:
>
>     if (otx2_test_flag(nic, OTX2_FLAG_INTF_DOWN))
>         goto free_mcam_flow;
>
> otx2_free_hw_resources() skips cn10k_free_all_ipolicers() for
> otx2_rep_dev() devices, and AF's nix_lf_free handler doesn't free
> bandwidth profiles. Can each switch from switchdev to legacy mode leak
> ingress policer leaf profiles?
>
> There is a similar change in rvu_rep_create(). Between register_netdev()
> and rvu_rep_napi_init(), otx2_tc_add_flow() now rejects representor
> offload with "Interface not initialized". Is that intended?
>
> [ ... ]
>
> > @@ -303,9 +303,9 @@ static void rvu_rep_state_evt_handler(struct otx2_nic *priv,
> >  	rep_id = rvu_rep_get_repid(priv, info->pcifunc);
> >  	rep = priv->reps[rep_id];
> >  	if (info->evt_data.vf_state)
> > -		rep->flags |= RVU_REP_VF_INITIALIZED;
> > +		set_bit(OTX2_FLAG_REP_VF_INITIALIZED, &rep->flags);
> >  	else
> > -		rep->flags &= ~RVU_REP_VF_INITIALIZED;
> > +		clear_bit(OTX2_FLAG_REP_VF_INITIALIZED, &rep->flags);
> >  }
>
> [Severity: Critical]
> This is a pre-existing issue, but what happens here when
> rvu_rep_get_repid() doesn't find info->pcifunc? It returns -EINVAL:
>
>     for (rep_id = 0; rep_id < priv->rep_cnt; rep_id++)
>         if (priv->rep_pf_map[rep_id] == pcifunc)
>             return rep_id;
>     return -EINVAL;
>
> In that case priv->reps[-22] is read from memory before the array, and
> set_bit() or clear_bit() writes through that pointer. priv->reps can also
> be NULL before switchdev mode is enabled. It can also be freed memory,
> because rvu_rep_destroy() calls kfree() on it without setting it to NULL.
>
> Can a VF reach this? AF's rvu_mbox_handler_rep_event_notify() only checks
> is_pf_func_valid(). rvu_rep_up_notify() forwards the sender's event bits
> and only sets the header pcifunc:
>
>     msg->hdr.pcifunc = event->pcifunc;
>     msg->event = event->event;
>
> So the body pcifunc arrives as 0. A REP_EVENT_NOTIFY with
> event=RVU_EVENT_PFVF_STATE aimed at the representor PF would reach this
> handler through
> otx2_mbox_up_handler_rep_event_up_notify()->rvu_event_up_notify(), and
> the lookup would miss.
>
> Should rep_id be checked here, and should AF validate the sender?
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
> [Severity: High]
> This isn't a bug introduced by this patch, but is rep->stats_wrk ever
> cancelled? rvu_rep_get_stats64() ends with:
>
>     schedule_delayed_work(&rep->stats_wrk, msecs_to_jiffies(100));
>
> The only cancel_delayed_work_sync() in rep.c is for priv->refill_wrk.
>
> rvu_rep_destroy() and the rvu_rep_create() error unwind both call
> free_netdev(rep->netdev). That frees the rep_dev (netdev_priv) while the
> delayed work embedded in it may still be pending. unregister_netdev()
> itself sends link notifications that call ndo_get_stats64, so the work is
> likely armed during teardown.
>
> Wouldn't rvu_rep_get_stats() then run about 100ms later on freed memory?
>
>     rep = container_of(del_work, struct rep_dev, stats_wrk);
>     priv = rep->mdev;
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
> This is a pre-existing issue, but the rest of this loop does:
>
>         unregister_netdev(rep->netdev);
>         rvu_rep_devlink_port_unregister(rep);
>         free_netdev(rep->netdev);
>         kfree(rep->flow_cfg);
>
> rep comes from netdev_priv() of a netdev that rvu_rep_create() allocated
> with alloc_etherdev(sizeof(*rep)). Isn't rep->flow_cfg read after
> free_netdev() has already freed that memory?
>
> [ ... ]
>
> --
> Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261109033154.2161803-1-rkannoth%40marvell.com
