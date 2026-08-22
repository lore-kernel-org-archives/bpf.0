Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FEB533A9E1
	for <bpf@vger.kernel.org>; Sat, 22 Aug 2026 10:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787396188; cv=none; b=FjLZE5+YFFRCy5oc1861L6qkraoOGlI/yFHnd3N7Qc2YIZWb/sLrw3XWYrH3UlElcSBzVa6lTq24sY8U2im373G4T3Mv2UUMnhu+3nicCdEscpOYsehtzlBcwdw9vD7qoMK1Lux56a6ybUxBOxfO1b3kz3rkV478Of2309lyr1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787396188; c=relaxed/simple;
	bh=5QmGFk51zpdy4IJ2pTcjiHQT+LOfD5jaI+5/KeMMjTY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=lOTLyZgbFQ0eXXs1cO3DAr0HuAbxJ+aN9hk0L/BLC7OP6q8RxZa1IRHURtI2my5nv5Ca/sSwlpPf5nTdwCK+fL+Mi42WXtR1wJapB4Kl1UaWtTWYkvQnmI5+s6ySgJW2AjiV2b9mwogFuLJY3utSE4nBbptaZ9akzxvyXdwqGyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cN7SaP9C; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cN7SaP9C"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 106C21F000E9;
	Sat, 22 Aug 2026 10:56:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787396187;
	bh=InvLANqUpikTzGMjEzr79b9W9nvXusG/dIRnGYe5Y2o=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cN7SaP9CIy2JFUXqd+yj2rmPE4AmpKZbN8tkodSkbMRCISkJtSWjM1/zV+msUCl3w
	 T1Kpe1Jy7k/t4F3gCM8lGJWLJkdlDMBac0kVsrkKHfSn32kw5HfVHNRHbBbtEWnnl7
	 a0ecW1TH7ICvIr+IRsWB3q9Wn1WumpekHQ/rU58FHj2+EF/0zzw2fMVRd0pvXKLJrF
	 2jCK4hwyrVepDomywCQpw2BrOFqZjpU7v3+ptNh2O3AU03mmMuht8K64DOPb5xqYH7
	 msPUc0FnFq4hYPs+y67hwEU0OFsnoNLwFnhwQH6vGIhzy1wUOzmMVY24c3O+7FfbzZ
	 uFEQmHgTShOOA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 net] octeontx2-pf: fix NULL deref of af_xdp_zc_qidx
 on rep setup
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ratheesh Kannoth" <rkannoth@marvell.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260821105536.2998765-1-rkannoth@marvell.com>
References: <20260821105536.2998765-1-rkannoth@marvell.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 22 Aug 2026 10:56:26 +0000
Message-Id: <20260822105627.106C21F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The patch adds NULL checks before test_bit() but misses set_bit() =
and clear_bit() on af_xdp_zc_qidx, leaving a probe race condition that lead=
s to a NULL pointer dereference.
- [High] NAPI is not disabled during XSK pool setup, causing a data race on=
 the completion queue.
- [High] Incorrect conditional check for XDP queues when attaching XSK buff=
er pools leads to misconfiguration and breaks zero-copy TX.
--

--- Patch [1]: [PATCH v2 net] octeontx2-pf: fix NULL deref of af_xdp_zc_qid=
x on rep setup ---
commit 5f1a1574e7a51207651e67a7a10d7e4ef025c443
Author: Suman Ghosh <sumang@marvell.com>

octeontx2-pf: fix NULL deref of af_xdp_zc_qidx on rep setup

af_xdp_zc_qidx tracks receive queues using AF_XDP zero-copy and is
allocated during PF/VF probe. Representors and other non-AF_XDP paths
leave the pointer NULL, but several call sites used test_bit() on it
unconditionally.

Switching to devlink eswitch mode creates representors and runs
otx2_init_hw_resources(), which reaches otx2_pool_aq_init() and oopses
when dereferencing the NULL bitmap. Add NULL checks before every
af_xdp_zc_qidx test_bit() use in the RSS, ethtool, XSK, and pool init
paths.

> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c b/d=
rivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
> index ca73a94db7943..175992188c18a 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
[ ... ]
> @@ -333,7 +333,8 @@ int otx2_set_rss_table(struct otx2_nic *pfvf, int ctx=
_id, const u32 *ind_tbl)
>  	/* Get memory to put this msg */
>  	for (idx =3D 0; idx < rss->rss_size; idx++) {
>  		/* Ignore the queue if AF_XDP zero copy is enabled */
> -		if (test_bit(ind_tbl[idx], pfvf->af_xdp_zc_qidx))
> +		if (pfvf->af_xdp_zc_qidx &&
> +		    test_bit(ind_tbl[idx], pfvf->af_xdp_zc_qidx))

[Severity: High]
This isn't a bug introduced by this patch, but since we are adding NULL
checks for test_bit() on af_xdp_zc_qidx, are we missing similar NULL checks
for set_bit() and clear_bit()?

Looking at otx2_probe() in
drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c, register_netdev()
is called before pf->af_xdp_zc_qidx is allocated:

drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c:otx2_probe() {
    ...
    err =3D register_netdev(netdev);
    ...
}

This creates a race window where a userspace program could immediately open
an AF_XDP socket and bind it, invoking otx2_xsk_pool_enable() which calls
set_bit() on the still-NULL pointer:

drivers/net/ethernet/marvell/octeontx2/nic/otx2_xsk.c:otx2_xsk_pool_enable(=
) {
    ...
    set_bit(qidx, pf->af_xdp_zc_qidx);
    ...
}

Could this lead to a NULL pointer dereference?

[Severity: High]
This is also a pre-existing issue, but does the queue index boundary check
in otx2_sq_init() correctly identify XDP queues when attaching XSK buffers?

Looking at drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c:

drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c:otx2_sq_init() {
    ...
    if (qidx > pfvf->hw.xdp_queues)
        otx2_attach_xsk_buff(pfvf, sq, (qidx - pfvf->hw.xdp_queues));
    ...
}

If there are more normal TX queues than XDP queues (for example, 4 TX queues
and 2 XDP queues), normal TX queues (indexed 0 to 3) will evaluate to true
(e.g., 3 > 2) and erroneously receive an XSK pool.

Concurrently, the first XDP queue (index 2) would fail the evaluation
(2 > 2 is false) and its xsk_pool remains NULL.

Could this break zero-copy TX on the first XDP queue and corrupt normal
TX queues when otx2_tx_napi_handler() injects packets concurrently?

[ ... ]
> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_xsk.c b/driv=
ers/net/ethernet/marvell/octeontx2/nic/otx2_xsk.c
> index 7d67b4cbaf716..0e8a6a6486c4a 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_xsk.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_xsk.c
[ ... ]
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
This is a pre-existing issue, but looking at how AF_XDP pools are enabled
in otx2_xsk_pool_enable() in this same file, it modifies the completion
queue hardware context without first disabling NAPI:

drivers/net/ethernet/marvell/octeontx2/nic/otx2_xsk.c:otx2_xsk_pool_enable(=
) {
    ...
    otx2_clean_up_rq(pf, qidx);
    ...
}

drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c:otx2_cleanup_rx_cqes=
() {
    ...
    while (cq->pend_cqe) {
        cqe =3D (struct nix_cqe_rx_s *)otx2_get_next_cqe(cq);
    ...
}

If traffic arrives concurrently and otx2_napi_handler() in softirq context
polls the same completion queue simultaneously, can this cause a data race
and corrupt the completion queue?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260821105536.2998=
765-1-rkannoth@marvell.com?part=3D1
