Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793477562;
	b=ksv6dXmr976ckLBNrRvEGM2uJOuMvZIjxq6zmjtlyAR/z8WPY0JM2/+mTMoYTG7dMtdq
	 6OvbDG+9nTntIOtTAHEIYUXaH9MInUOdiswEbauL5RGuEy4fozZJRjvu/CfTbYIYzud08
	 iYcAdP/f9ts05ZUOKPoo0imzYbKAMDBMaim/Ze+dd/91HAC6PYRr/OmX89/d+kifmWX86
	 I1UcP3Vlrll70uO1w9OcQMlpokZ3PTqGmgEOeybBZFGSRDCzMR5eXnaCaFf+ZnAOU7s/A
	 tmq1nBGymUR6DewrqmSM+EZ2qjLbCgEhG2SIZwt9Kugy+8VGeBs0YZI7xFdGJoczDRA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793477562;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=+jLmvJ5t53axHFDMbwy4AxcIHS6SnEcNicwbVHTR+jM=;
	b=mlseZJAy/hjvxw0Oy7/Jf7b4NlK/CymjQbf1kxlLz9t4EumzdWdo0yLJgsHHXPd++oMF
	 JtVOsn7ilFH1Izun6MjTcnR153UDv9PSqrcRRbAqFCZ3RLj9cO/BnBh+DpK3xzvL7xfaA
	 AXulVymiSCP+JQaOYtKBWfY9kn9gGK9qOBPMlQiBJstytFamEnR6noYsGg7DTraD84RAL
	 kMSuBgK8K3gtrx9epe5D4WPZj25v4q23JDW7cmwUBH7sDorERpJDQe73eu0G++sFYfC4/
	 /ELOIw5jBFT/78VGnxMqLjqLxVpM9qbq7q3E/7kXOXTkln+cM9q8ZGvzkcjY6tvBxkA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="jV6ZN2w/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4395E606A31A
	for <bpf@vger.kernel.org>; Sat, 31 Oct 2026 20:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jV6ZN2w/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97D3B1F000C1;
	Sat, 31 Oct 2026 20:12:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793477561;
	bh=+jLmvJ5t53axHFDMbwy4AxcIHS6SnEcNicwbVHTR+jM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jV6ZN2w/Yo9iqBo0VQBb2qBPNJWk+Yn6Br2Sk8AZYsdwANaw0Z/8cEP6hMmQqmodQ
	 t9GZZkTP66494ycEvjp4XIz4DKVQPngSRYWPzPMN6dcj4Tx69PrunHYeS72Ht/C6Uh
	 NbiZ+wMj783rlAuBwDcVhckyXccieNp+wCagDMgRGosHzC84jW8cX3WMhMdC9+qmct
	 cwpD3IqELBXOurAOw/hcuoZ588AgfJirfWuqnrVEq+MWiaR0W67xu872oSx+FIP5tE
	 P/0FWzZcSCVZm8shbE9JkoUlwHFrQ0oK67oIUHQCi4MDVgLKIWpvRXMRtMvo4dVfX+
	 a0GZm47Kju/PA==
Message-ID: <sashiko-outbox-192109@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net] octeontx2-pf: fix XDP frames freed as skbs on
 interface down
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nicolai Buchwitz" <nb@tipi-net.de>
Cc: bpf@vger.kernel.org
In-Reply-To: <20261030-nb-otx2-xdp-cqe-cleanup-net-v1-1-710635c0f504@tipi-net.de>
References: <20261030-nb-otx2-xdp-cqe-cleanup-net-v1-1-710635c0f504@tipi-net.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 31 Oct 2026 20:12:41 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] octeontx2-pf: missing xsk_tx_completed() call in otx2_cleanup_tx=
_cqes()
--

commit 40946781f760bef2ef894a136c752dbc204d2650
Author: Nicolai Buchwitz <nb@tipi-net.de>

octeontx2-pf: fix XDP frames freed as skbs on interface down

This commit updates otx2_cleanup_tx_cqes() to handle CQ_XDP completions via
otx2_xdp_snd_pkt_handler() instead of freeing pending xdp_frame pointers wi=
th
dev_kfree_skb_any() during interface teardown or XDP program replacement.

> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c b/dri=
vers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
> index 90af9b9044aa0..e3b07e5335fb8 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
> @@ -1332,6 +1332,7 @@ void otx2_cleanup_tx_cqes(struct otx2_nic *pfvf, st=
ruct otx2_cq_queue *cq)
>  	struct nix_cqe_tx_s *cqe;
>  	struct netdev_queue *txq;
>  	int processed_cqe =3D 0;
> +	int xsk_frames =3D 0;
>  	struct sg_list *sg;
>  	int qidx;
> =20
> @@ -1348,6 +1349,10 @@ void otx2_cleanup_tx_cqes(struct otx2_nic *pfvf, s=
truct otx2_cq_queue *cq)
> =20
>  		if (!cqe)
>  			continue;
> +		if (cq->cq_type =3D=3D CQ_XDP) {
> +			otx2_xdp_snd_pkt_handler(pfvf, sq, cqe, &xsk_frames);
> +			continue;
> +		}

[Severity: Medium]
Does otx2_cleanup_tx_cqes() also need to pass xsk_frames to
xsk_tx_completed() after draining the loop?

When AF_XDP zero-copy TX descriptors are reaped in
drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c:

otx2_xdp_snd_pkt_handler() {
	...
	sg =3D &sq->sg[snd_comp->sqe_id];
	if (sg->flags & OTX2_AF_XDP_FRAME) {
		(*xsk_frames)++;
		return;
	}
	...
}

the handler only increments xsk_frames and relies on the caller to publish
the completions to sq->xsk_pool, as done in the normal NAPI completion path=
 via
otx2_tx_napi_handler() -> otx2_zc_submit_pkts():

	if (*xsk_frames)
		xsk_tx_completed(xsk_pool, *xsk_frames);

In otx2_cleanup_tx_cqes(), xsk_frames is accumulated across the while
(cq->pend_cqe) loop, but it is never read afterwards. If an interface with =
an
active AF_XDP zero-copy TX socket is brought down or has its XDP program
replaced while AF_XDP TX completions are pending in a CQ_XDP queue, wouldn't
those completion ring entries be leaked without calling
xsk_tx_completed(sq->xsk_pool, xsk_frames)?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261030-nb-otx2-xd=
p-cqe-cleanup-net-v1-1-710635c0f504@tipi-net.de?part=3D1
