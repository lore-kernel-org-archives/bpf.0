Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5C494302FC
	for <bpf@vger.kernel.org>; Fri, 21 Aug 2026 09:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787303211; cv=none; b=chxmjlqmLNGK+Z9ZTm7shBZXTt7umZG4bGGSaruXzqpox9QNRrxH9ki4Z5PALJH0KEJrtMi8cvl+gMwaRGSORabF0KnLB0AGXtu1CEOCxCjeESHHB/eve0s92CWANkvW198UAuqdzl4dBSZd8DKUvE4rBVmNeVX4OmsDnDq9ZNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787303211; c=relaxed/simple;
	bh=2uq3WUZJgk551keae/ann2DmCSbrBvuvo2/Va79DhSM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=q3aHipUMsSdj6rIrBJo/+RQRkDKGrXT/F/P45xeBSF0sIJNxsYgZFeH1RlajqIq6UFjq2btx0HIOD0TNrd6WbwFXMib0FFUVTkAVtTv9+kn9ZS8kxyMgpEy/2SXo7uQj7FVZjmg7dKar2JMQRnMUFnYeNxDX0+ep8smPz+4YfvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NfQWvlYA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NfQWvlYA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBC191F000E9;
	Fri, 21 Aug 2026 09:06:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787303201;
	bh=VkZJ60IBDAXA8hDSp/CJtWShHIRKIy/8zqNSLgcR5zI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NfQWvlYA0Qpcq5KP0aZ+lJYeQ5UE9jYQ7+l7GKOTEtVXeNvMFXhHeTHLXhLp/if/l
	 do6ZLTVeT1SRDru/pr1MhUjXiAMfVIwRKFXB9sKL2IYl/5a61D04doro7hyj1WABus
	 S6A5SPwtL8XrZrWkiGWdwPGOZmkLQiL6hpixbMo6HbmUDHZanNtjnKNO836qX5+rnD
	 J0U+lw50mtUW8BjaryuQ7jujdkfFUX9lGGMgQ8XUrd26chIYZdSbUA4RGJoml95bsV
	 lU0POhhpRXVDjds3Iyx3ZowFRiH6BpJXgYI99FE0HoCW5A71WrHgSsJ8WALE7TfZ/b
	 A6fYfR3qRWk2Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net] octeontx2-pf: fix NULL deref of af_xdp_zc_qidx on
 rep setup
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ratheesh Kannoth" <rkannoth@marvell.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260820090533.2681578-1-rkannoth@marvell.com>
References: <20260820090533.2681578-1-rkannoth@marvell.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 21 Aug 2026 09:06:40 +0000
Message-Id: <20260821090640.DBC191F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Concurrent NAPI execution during AF_XDP pool setup/disable causes =
data races and Use-After-Free.
- [High] Disabling AF_XDP zero-copy leaves the receive queue permanently di=
sabled and lacking a page_pool.
- [High] The AF_XDP zero-copy RSS reconfiguration logic fails to remove the=
 AF_XDP queue from hardware RSS and desyncs from ethtool.
- [High] Prematurely cancelling a work item before unregistering the networ=
k device allows it to be re-queued, leading to a Use-After-Free.
- [High] Incorrect index calculation for attaching the XSK buffer pool to X=
DP queues.
--

--- Patch [1]: [PATCH net] octeontx2-pf: fix NULL deref of af_xdp_zc_qidx o=
n rep setup ---
commit c986623a4193b783891a92b6914ca95ab75cf969
Author: Suman Ghosh <sumang@marvell.com>

octeontx2-pf: fix NULL deref of af_xdp_zc_qidx on rep setup

This commit adds NULL checks for af_xdp_zc_qidx before calling test_bit()
in several paths (RSS, ethtool, XSK, pool init) to prevent a NULL pointer
dereference during representor setup in devlink eswitch mode.

> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c b/d=
rivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
> index 3d253132a17f0..8a36ab8ab19ed 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
> @@ -333,7 +333,8 @@ int otx2_set_rss_table(struct otx2_nic *pfvf, int ctx=
_id, const u32 *ind_tbl)
>  	/* Get memory to put this msg */
>  	for (idx =3D 0; idx < rss->rss_size; idx++) {
>  		/* Ignore the queue if AF_XDP zero copy is enabled */
> -		if (test_bit(ind_tbl[idx], pfvf->af_xdp_zc_qidx))
> +		if (pfvf->af_xdp_zc_qidx &&
> +		    test_bit(ind_tbl[idx], pfvf->af_xdp_zc_qidx))
>  			continue;

[Severity: High]
This isn't a bug introduced by this patch, but does this continue statement
leave the NIX_AQ_CTYPE_RSS initialization message unsent for this index?

If the message is skipped, the hardware RSS table might still point to the
AF_XDP queue. This could cause normal RSS traffic to be incorrectly routed
to the AF_XDP queue.

[ ... ]

[Severity: High]
This is a pre-existing issue in otx2_common.c, but does otx2_sq_init() use
the correct variable for checking XDP queues?

The function currently checks:

    if (qidx > pfvf->hw.xdp_queues)
        otx2_attach_xsk_buff(pfvf, sq, (qidx - pfvf->hw.xdp_queues));

Since XDP queues start at the tx_queues offset, should this check instead
evaluate against pfvf->hw.tx_queues? If tx_queues differs from the number
of XDP (RX) queues, this logic might skip attaching the XSK buffer pool to
the correct XDP queues and instead attach it to normal TX queues.

> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c b/=
drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c
> index a0340f3422bf9..9bee1b91eeaa6 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c
> @@ -939,7 +939,8 @@ static int otx2_get_rxfh(struct net_device *dev,
> =20
>  	for (idx =3D 0; idx < rss->rss_size; idx++) {
>  		/* Ignore if the rx queue is AF_XDP zero copy enabled */
> -		if (test_bit(rss->ind_tbl[idx], pfvf->af_xdp_zc_qidx))
> +		if (pfvf->af_xdp_zc_qidx &&
> +		    test_bit(rss->ind_tbl[idx], pfvf->af_xdp_zc_qidx))
>  			continue;
>  		indir[idx] =3D rss->ind_tbl[idx];
>  	}

[Severity: High]
This is a pre-existing issue, but does skipping this index leave it
unmodified (typically zero) in the ethtool output?

If the index is skipped rather than properly mapped, ethtool might falsely
report queue 0, causing a silent desynchronization with the actual hardware
state.

> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_xsk.c b/driv=
ers/net/ethernet/marvell/octeontx2/nic/otx2_xsk.c
> index 7d67b4cbaf716..0e8a6a6486c4a 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_xsk.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_xsk.c
> @@ -193,7 +193,8 @@ int otx2_xsk_wakeup(struct net_device *dev, u32 queue=
_id, u32 flags)
> =20
>  void otx2_attach_xsk_buff(struct otx2_nic *pfvf, struct otx2_snd_queue *=
sq, int qidx)
>  {
> -	if (test_bit(qidx, pfvf->af_xdp_zc_qidx))
> +	if (pfvf->af_xdp_zc_qidx &&
> +	    test_bit(qidx, pfvf->af_xdp_zc_qidx))
>  		sq->xsk_pool =3D xsk_get_pool_from_qid(pfvf->netdev, qidx);
>  }

[Severity: High]
This is a pre-existing issue in otx2_xsk.c, but is it safe to call
otx2_clean_up_rq() in otx2_xsk_pool_enable() without first stopping the
receive queue or disabling NAPI?

If NAPI is not disabled (e.g., via napi_disable()), the NAPI softirq could
concurrently execute otx2_napi_handler(). This could lead to a
use-after-free as the xdp_rxq_info and hardware buffers are destroyed while
still in use, potentially corrupting the hardware completion queue ring.

[Severity: High]
This is another pre-existing issue in otx2_xsk.c, but does
otx2_xsk_pool_disable() leave the receive queue permanently disabled?

The function disables the hardware queue context via otx2_clean_up_rq() ->
otx2_xsk_ctx_disable(), but doesn't appear to re-enable it or recreate the
standard page_pool buffers for the queue. If otx2_set_rss_table() still
points normal RSS traffic to this queue, the packets could be permanently
dropped until the device is administratively brought down and up.

[Severity: High]
This is a pre-existing issue in otx2_pf.c, but can the reset_task be safely
cancelled while the device is still UP?

In otx2_remove(), cancel_work_sync(&pf->reset_task) is called before
unregister_netdev() shuts down the device. Since interrupts are still
active, could an incoming hardware error interrupt (otx2_q_intr_handler)
fire immediately after the cancellation and place the work item back on
the workqueue? Once the netdev is freed, the subsequently executed
reset_task would dereference freed memory.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260820090533.2681=
578-1-rkannoth@marvell.com?part=3D1
