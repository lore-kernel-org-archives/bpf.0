Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3110B3DB997
	for <bpf@vger.kernel.org>; Thu, 15 Oct 2026 02:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792031738; cv=none; b=shkkSpIlrwSh3jqFO1/Yjdgmr8xOYTXyovtIU5HSuJVo8yVTRQwmVamwnH36xMIWCw+uYeVhFV64wuFG5VO5UAdWnvcfAfY2V1YQDk40N9OKRa3AeXbiFiCbfp7zN08cYtn5ZneK2+71GDubqxAjNP6svi9ikd5v18342Tr0MPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792031738; c=relaxed/simple;
	bh=PzeWdLDqgxFQ7MLqBz9wd9x7F891iFXtgH/474BHLo8=;
	h=Message-ID:From:Subject:To:In-Reply-To:References:Content-Type:
	 Date; b=DCv0hALaKpbRxqyDnWmX8SRoV52wA2SLtc2YrboDJV1bJMJGWAltdJ1gfSmU4dR4oZjH+GSGLSJcGjm5IvdUAqlvHL00Vz183xVKQPiaiXkkbssfg4rHTL4NwtpyOB5yZEnZW6IOao4ghZcT5s29dFdjKqW7w97bmqhGnlcnkwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TDSDHW36; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TDSDHW36"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F5CC1F000C4;
	Thu, 15 Oct 2026 02:35:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792031735;
	bh=ar8ovlt/TSj+9J1OTZe1vScbY5bjqecE+RU7JfHOQY0=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=TDSDHW36DIztXmpl+H3MKLBVEZcHq7niDaS4Ggtd76ry8tegtovsRQk9uDlg/eVLB
	 9VsWlQbf+Js/0+MhUjNGN84xfhBtMvp9KxMbc3iSZPXdhrodnbPO1mR7VbddzzTwWA
	 3YXi1lkqX5t4+MmEmtYryCVjcmpgBvvpN4U/zJ9FirquOnJI2BAdlA5mjV/9Vnk1s8
	 qmvw10AN+ojTnl85dzfaY0t143w027h+5t6IcdPTs4/pDF0Wf++iGmmqZJaf0L5A+O
	 xQQRYvsHVEqensX+61L1TWIkB/LgELKPxMHX+/0eGH7ILD2TMSDcbpm7J1xI/0QMWN
	 NZTs847pU/7iw==
Message-ID: <sashiko-outbox-172159@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v20 net-next 1/2] octeontx2: use atomic bitops for PF/VF
 and rep flags
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ratheesh Kannoth" <rkannoth@marvell.com>, bpf@vger.kernel.org
In-Reply-To: <20261014023431.1775238-2-rkannoth@marvell.com>
References: <20261014023431.1775238-1-rkannoth@marvell.com>
 <20261014023431.1775238-2-rkannoth@marvell.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 15 Oct 2026 02:35:35 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [Critical] octeontx2: panic and cross-interface resource corruption from =
rvu_rep_setup_tc_cb
- [High] net: octeontx2: non-atomic RMW in otx2_sync_flags_from_rep() clobb=
ers concurrent flags updates
- [Medium] net/octeontx2: leak of TC_MARK_ENABLED flag and mark_flows refco=
unt on error
- [Medium] net/octeontx2: missing return value check in otx2_config_hwtstam=
p_set
--

commit add59cc125681c120e908ba8a2b3ddcdb3d109fd
Author: Ratheesh Kannoth <rkannoth@marvell.com>

octeontx2: use atomic bitops for PF/VF and rep flags

This commit converts PF/VF and representor flags from non-atomic u64 masks
to unsigned long bitmaps using atomic set_bit/clear_bit operations. It also
introduces helpers to synchronize representor-owned flags onto the PF
mailbox context safely.

> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h b/d=
rivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
> --- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h

[ ... ]

> +static inline void otx2_sync_flags_from_rep(struct otx2_nic *dst,
> +					    unsigned long *src_flags)
> +{
> +	unsigned long src =3D READ_ONCE(*src_flags);
> +	unsigned long new_flags;
> +
> +	new_flags =3D (READ_ONCE(dst->flags) & ~OTX2_REP_SYNC_FLAGS_MASK) |
> +		    (src & OTX2_REP_SYNC_FLAGS_MASK);
> +	WRITE_ONCE(dst->flags, new_flags);
> +}

[Severity: High]
Does this non-atomic read-modify-write sequence clobber concurrent updates?

While this patch transitions to atomic bitops like set_bit and clear_bit, t=
his
helper uses a non-atomic READ_ONCE, bitwise mask, and WRITE_ONCE sequence. =
If
an asynchronous handler (like otx2_mbox_up_handler_rep_event_up_notify)
modifies a flag such as OTX2_FLAG_PORT_UP concurrently using otx2_set_flag,
the WRITE_ONCE here will blindly overwrite the memory word.

This can silently discard the concurrent atomic update and lose critical st=
ate
transitions.

> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/rep.c b/drivers/n=
et/ethernet/marvell/octeontx2/nic/rep.c
> --- a/drivers/net/ethernet/marvell/octeontx2/nic/rep.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/rep.c

[ ... ]

>  	priv->netdev =3D rep->netdev;
> -	priv->flags =3D rep->flags;
> +	otx2_sync_flags_from_rep(priv, &rep->flags);
>  	priv->pcifunc =3D rep->pcifunc;
>  	priv->flow_cfg =3D rep->flow_cfg;

[Severity: Critical]
Does this assignment permanently corrupt the master device's hardware and
software states?

By overwriting priv->netdev, priv->pcifunc, and priv->flow_cfg with the
representor's values to trick the TC offload routines, this creates a major
data race and cross-interface resource corruption.

If an RX or TX error occurs before any TC rules are configured, routines li=
ke
otx2_check_rcv_errors will dereference a NULL pfvf->netdev, causing an
immediate kernel panic. Furthermore, during hardware teardown,
otx2_free_hw_resources will send MBOX commands using the corrupted pcifunc,
freeing the representor's NIX LF instead of its own and leaking resources.

> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c b/drive=
rs/net/ethernet/marvell/octeontx2/nic/otx2_tc.c
> --- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c

[ ... ]

> @@ -505,7 +505,7 @@ static int otx2_tc_parse_actions(struct otx2_nic *nic,
>  			mark =3D act->mark;
>  			req->match_id =3D mark & OTX2_RX_MATCH_ID_MASK;
>  			req->op =3D NIX_RX_ACTION_DEFAULT;
> -			nic->flags |=3D OTX2_FLAG_TC_MARK_ENABLED;
> +			otx2_set_flag(nic, OTX2_FLAG_TC_MARK_ENABLED);
>  			refcount_inc(&nic->flow_cfg->mark_flows);
>  			break;

[Severity: Medium]
If the flow parsing or addition fails later in the function, does this leak
the TC_MARK_ENABLED flag and the mark_flows refcount?

The flag and refcount are updated immediately during parsing. If a subseque=
nt
action validation fails, or if otx2_tc_add_flow fails later on, the error
cleanup paths (like the free_leaf label) do not appear to revert the mark
flag or decrement the refcount.

This leaves the fast path unconditionally executing skb->mark =3D parse->ma=
tch_id
for all packets even if the rule was never successfully installed.

> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c b/drive=
rs/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
> --- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c

[ ... ]

> @@ -2550,7 +2550,7 @@ int otx2_config_hwtstamp_set(struct net_device *net=
dev,
>  					   "One-step time stamping is not supported");
>  			return -ERANGE;
>  		}
> -		pfvf->flags |=3D OTX2_FLAG_PTP_ONESTEP_SYNC;
> +		otx2_set_flag(pfvf, OTX2_FLAG_PTP_ONESTEP_SYNC);
>  		schedule_delayed_work(&pfvf->ptp->synctstamp_work,
>  				      msecs_to_jiffies(500));
>  		fallthrough;
>  	case HWTSTAMP_TX_ON:
>  		otx2_config_hw_tx_tstamp(pfvf, true);
>  		break;

[Severity: Medium]
Should the return values of otx2_config_hw_tx_tstamp and
otx2_config_hw_rx_tstamp be checked here?

These hardware configuration functions can fail due to memory allocation is=
sues
or mailbox timeouts. By ignoring their return values, the function can retu=
rn
success to userspace and update the software state (pfvf->tstamp), leaving
userspace silently failing to receive hardware timestamps because the softw=
are
and hardware states are mismatched.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261014023431.1775=
238-1-rkannoth@marvell.com?part=3D1
