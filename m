Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47DD92D0C94
	for <bpf@vger.kernel.org>; Sat, 12 Sep 2026 10:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789210590; cv=none; b=CThjpcBv5iP7BWpZaugyfrDp4LUz69pJV313C8qr3pEcscVKT9hnh2gXCWQV79dq1lUCk+95oPDyOEsVBw26f74uXMbzvti9Ud4G7pOm81NnoULmJR4o44jq7ONyo756FC7YgTuZx5Gy1vjfGn4p/aR44qIGusvxGhHdQnXv7aI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789210590; c=relaxed/simple;
	bh=ZPU+MA4AQOuUJBvYAW2v2Xv43mX/KlhAc/k5Lj6k0KE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=d+naq2qK6B2/dvqw+tAJGTtZq4mFnIgs/fg2flRWJ9BDBSMJY4MHL+YN/g1T1oSITX4IOu0KWlF7dbxRhVx9FGiGdB+tvshp5JwRTEEZ2lvKv40lMA2x6tPR+1rOjnpRJhWge8Ts6Pb9Bc/QGio5zfYXFNPn/y9JMLaAXaa733k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k8mr3V3J; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k8mr3V3J"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3E251F000FF;
	Sat, 12 Sep 2026 10:56:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789210588;
	bh=hs3orKu9GK5m8dcp8ZdKQyeGp7d1gUKoRWxcT0LfoXQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=k8mr3V3JB3Y3sa9YoAgfU6g1mfVJqKnuxovDwAPbh/YEXkwJO8cbmcpna7Rns62Fh
	 DxrtsgxOGeuDTEghexqzjOrBiEWpx5oaKrgFN5yQlPm6V7r12YhqVpZsyYpSxspV9w
	 Gx+43VJH2FuhEDBlAo8n7s794gvv1UZEfQzNCKdjzQdwWDP3DeiQq+i6XXS4mxsW3N
	 HzF15IxX4TtUlW/jpoEpVySuotFiaftD2Q4yYSNGKhKrNfxRpdJIM4OgCIO8eErgPn
	 WX3QdicqMg8BAEG6mef/J3FJNSMpAuFAoxC3jntUmdiWa3TFj1pT8NRaip1zqHjAiz
	 MAYjI5vGuqxJw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v15 net-next 1/2] octeontx2: use atomic bitops for PF/VF
 and rep flags
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ratheesh Kannoth" <rkannoth@marvell.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260911105521.689565-2-rkannoth@marvell.com>
References: <20260911105521.689565-1-rkannoth@marvell.com>
 <20260911105521.689565-2-rkannoth@marvell.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 12 Sep 2026 10:56:28 +0000
Message-Id: <20260912105628.B3E251F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

Pre-existing issues:
- [High] TC offload setup on representors corrupts the shared physical func=
tion (PF) device state by locklessly overwriting its netdev and clobbering =
its flags via a non-atomic bitwise sync loop.
- [High] Inverted logic in `otx2_tc_del_flow()` prematurely disables TC MAR=
K hardware offload when any single mark rule is deleted.
- [High] Missing cancellation of `stats_wrk` leads to a Use-After-Free duri=
ng representor teardown.
- [High] `rvu_rep_mcam_flow_init()` interacts with the mailbox without acqu=
iring its lock and executes an unbalanced `mutex_unlock()`.
--

commit 5dc6aa35da96ae18ff3fd015c81c420c4cead463
Author: Ratheesh Kannoth <rkannoth@marvell.com>

octeontx2: use atomic bitops for PF/VF and rep flags

This commit replaces non-atomic u64 flag read-modify-write operations
with unsigned long bitmaps across the octeontx2 driver. It introduces
helpers for atomic bitwise flag updates and representor state sync.

> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h b/d=
rivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
> index eecee612b7b2c..7e09c1444a6d5 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
> @@ -594,6 +595,34 @@ struct otx2_nic {
>  	unsigned long		*af_xdp_zc_qidx;
>  };
> =20
> +static inline void otx2_set_flag(struct otx2_nic *nic, unsigned int flag)
> +{
> +	set_bit(flag, &nic->flags);
> +}
> +
> +static inline void otx2_clear_flag(struct otx2_nic *nic, unsigned int fl=
ag)
> +{
> +	clear_bit(flag, &nic->flags);
> +}
> +
> +static inline bool otx2_test_flag(struct otx2_nic *nic, unsigned int fla=
g)
> +{
> +	return test_bit(flag, &nic->flags);
> +}
> +
> +static inline void otx2_sync_flags_from_rep(struct otx2_nic *dst,
> +					    unsigned long *src_flags)
> +{
> +	unsigned int flag;
> +
> +	for (flag =3D 0; flag <=3D OTX2_REP_VF_INITIALIZED; flag++) {
> +		if (test_bit(flag, src_flags))
> +			set_bit(flag, &dst->flags);
> +		else
> +			clear_bit(flag, &dst->flags);
> +	}
> +}

[Severity: High]
This isn't a bug introduced by this patch, but does this loop corrupt
the physical function (PF) state by blindly overwriting its flags?

If a TC rule is configured on a representor, rvu_rep_setup_tc_cb() calls
this sync loop. It iteratively clears all global PF-specific flags (like
OTX2_FLAG_REP_MODE_ENABLED and OTX2_FLAG_INTF_DOWN) that aren't set
on the local representor, breaking datapath routing.

Additionally, is this 22-step bitwise copy susceptible to race conditions
with concurrent interrupt state changes since the updates are not atomic as
a single block?

> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c b/drive=
rs/net/ethernet/marvell/octeontx2/nic/otx2_tc.c
> index 039fd47ebf522..ddb46b580c3b6 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c
> @@ -1195,12 +1195,12 @@ static int otx2_tc_del_flow(struct otx2_nic *nic,
>  	/* Disable TC MARK flag if they are no rules with skbedit mark action */
>  	if (flow_node->req.match_id)
>  		if (!refcount_dec_and_test(&flow_cfg->mark_flows))
> -			nic->flags &=3D ~OTX2_FLAG_TC_MARK_ENABLED;
> +			otx2_clear_flag(nic, OTX2_FLAG_TC_MARK_ENABLED);

[Severity: High]
This is a pre-existing issue, but does this inverted logic prematurely
disable TC MARK hardware offload when any single mark rule is deleted?

Because the base refcount is 1, deleting a rule drops the count to > 0,
causing refcount_dec_and_test() to return false. The logical NOT operator
inverts this to true, triggering the clear flag while other flows are
still active.

> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/rep.c b/drivers/n=
et/ethernet/marvell/octeontx2/nic/rep.c
> index 0f5d5642d3f7a..8a8c0088fd204 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/nic/rep.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/rep.c
> @@ -93,9 +93,9 @@ static int rvu_rep_mcam_flow_init(struct rep_dev *rep)
>  	rep->flow_cfg->max_flows =3D allocated;
> =20
>  	if (allocated) {
> -		rep->flags |=3D OTX2_FLAG_MCAM_ENTRIES_ALLOC;
> -		rep->flags |=3D OTX2_FLAG_NTUPLE_SUPPORT;
> -		rep->flags |=3D OTX2_FLAG_TC_FLOWER_SUPPORT;
> +		set_bit(OTX2_FLAG_MCAM_ENTRIES_ALLOC, &rep->flags);
> +		set_bit(OTX2_FLAG_NTUPLE_SUPPORT, &rep->flags);
> +		set_bit(OTX2_FLAG_TC_FLOWER_SUPPORT, &rep->flags);
>  	}

[Severity: High]
This isn't a bug introduced by this patch, but does this function interact
with the mailbox without acquiring its lock and execute an unbalanced
mutex_unlock?

When called by rvu_rep_setup_tc_cb(), the function enters without acquiring
priv->mbox.lock, issues mailbox allocation commands directly, and
unconditionally unlocks the mutex right before this block on the exit path.
This could trigger a lockdep splat or panic, and risks ring corruption.

> @@ -109,14 +109,14 @@ static int rvu_rep_setup_tc_cb(enum tc_setup_type t=
ype,
>  	struct rep_dev *rep =3D cb_priv;
>  	struct otx2_nic *priv =3D rep->mdev;
> =20
> -	if (!(rep->flags & RVU_REP_VF_INITIALIZED))
> +	if (!test_bit(OTX2_REP_VF_INITIALIZED, &rep->flags))
>  		return -EINVAL;
> =20
> -	if (!(rep->flags & OTX2_FLAG_TC_FLOWER_SUPPORT))
> +	if (!test_bit(OTX2_FLAG_TC_FLOWER_SUPPORT, &rep->flags))
>  		rvu_rep_mcam_flow_init(rep);
> =20
>  	priv->netdev =3D rep->netdev;
> -	priv->flags =3D rep->flags;
> +	otx2_sync_flags_from_rep(priv, &rep->flags);
>  	priv->pcifunc =3D rep->pcifunc;
>  	priv->flow_cfg =3D rep->flow_cfg;

[Severity: High]
This is a pre-existing issue, but does this locklessly overwrite the shared
PF's netdev with the representor's netdev?

By reassigning priv->netdev to rep->netdev, subsequent TX completions in
otx2_tx_napi_handler() will incorrectly route packets to this single
representor's netdev.

> @@ -382,7 +382,7 @@ static void rvu_rep_get_stats64(struct net_device *de=
v,
>  {
>  	struct rep_dev *rep =3D netdev_priv(dev);
> =20
> -	if (!(rep->flags & RVU_REP_VF_INITIALIZED))
> +	if (!test_bit(OTX2_REP_VF_INITIALIZED, &rep->flags))
>  		return;
> =20
>  	stats->rx_packets =3D rep->stats.rx_frames;

[ ... ]

> @@ -632,7 +632,7 @@ void rvu_rep_destroy(struct otx2_nic *priv)
>  	int rep_id;
> =20
>  	rvu_eswitch_config(priv, false);
> -	priv->flags |=3D OTX2_FLAG_INTF_DOWN;
> +	otx2_set_flag(priv, OTX2_FLAG_INTF_DOWN);
>  	rvu_rep_free_cq_rsrc(priv);
>  	for (rep_id =3D 0; rep_id < priv->rep_cnt; rep_id++) {
>  		rep =3D priv->reps[rep_id];

[Severity: High]
This is a pre-existing issue, but can this lead to a Use-After-Free during
representor teardown?

If a user queries interface statistics (e.g., via ip -s link),
rvu_rep_get_stats64() schedules the delayed work stats_wrk. If the
representor is destroyed via rvu_rep_destroy() before the timer expires,
the struct is unregistered and freed without canceling the pending work.
When the timer fires, the workqueue executes and accesses the freed memory.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260911105521.6895=
65-1-rkannoth@marvell.com?part=3D1
