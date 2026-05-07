Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56A6F481AA3
	for <bpf@vger.kernel.org>; Thu,  7 May 2026 19:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778181480; cv=none; b=qxmRw07d0MUu4uZiDTe4v6F/PDwP4PMUjlQTBioiVxMe8SUNg4sjUv0aW5s5e8WcrwLvuSizU1ui9Q2pwkoPIwoKlv3PdqPMih0Rq4jZIu4K0yNTEuWLuSjJpzVdzUHtZbHeOrJqlecxeHxU9IibQ+eFVO8pMeK0h6yJjNnA5hI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778181480; c=relaxed/simple;
	bh=GQaTAbbNJ6PkNCwc32ZayIPwSeDV1+KRbeSqb7XLem0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=VeSZsNSwKxgCVcwL7sWjMG2jIPFhR8nGkYhlPELu1whIEpvTkEuqOfXL8ngun7GRAStMxbJaK3PpI+U6RKNeR88DX87DPXYBf6eNZSGaB1tEm8HajjslzaZaqw+YOCUdRk49FQLeNCLgjR3WrDdLmH1pABQzBnXX1qB6o/e17xA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mGILXtb2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mGILXtb2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D03CCC2BCC4;
	Thu,  7 May 2026 19:17:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778181479;
	bh=GQaTAbbNJ6PkNCwc32ZayIPwSeDV1+KRbeSqb7XLem0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=mGILXtb27q2Q9VkjUXpe7pcTaRSkxci0kZMqNuwg/RQ6Ud/OpIyfrIFC2PrLBfFxm
	 26/dgO/F2py1GRiYdFaiflSg8TIy3VJJFwSKKslDyd+Ck54bCHNvURUbVBrgZw9Asd
	 Wcx5hfZ1EiOSsEztTo+RLakSHNvhsc5hvWnKX12ltwpQtmwtc4P2VkJBnaMiDHr9D0
	 5tPst0TRJGFpnSk2Pgmb2o0C0q2gX0edGYpIRyUbxkWGN0caTPuuz1JdEMite3gKh6
	 mOQiHCHXvhL4A3bTSLvIT2q6urpWrgCGZii42XbsR9iDC7eRcnzHuqqS7kOMOw21Lw
	 JU/56F5nmkq1w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v9 6/7] net: bcmgenet: add XDP statistics
 counters
Reply-To: sashiko@lists.linux.dev
To: "Nicolai Buchwitz" <nb@tipi-net.de>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260506095553.55357-7-nb@tipi-net.de>
References: <20260506095553.55357-7-nb@tipi-net.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 07 May 2026 19:17:59 +0000
Message-Id: <20260507191759.D03CCC2BCC4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Global XDP statistics are updated concurrently from multiple NAP=
I contexts without synchronization, leading to data races, lost increments,=
 and rapid overflows.
--

commit 04cdeba59fa183a07b2fd6c8dba32b2dd262ae4d
Author: Nicolai Buchwitz <nb@tipi-net.de>

net: bcmgenet: add XDP statistics counters

Exposes per-action XDP counters via ethtool -S. These counters use the
existing soft MIB infrastructure and are incremented alongside existing
driver statistics in bcmgenet_run_xdp().

> --- a/drivers/net/ethernet/broadcom/genet/bcmgenet.c
> +++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
[ ... ]
> @@ -2432,6 +2440,7 @@ static unsigned int bcmgenet_run_xdp(struct bcmgene=
t_rx_ring *ring,
> =20
>  	switch (act) {
>  	case XDP_PASS:
> +		priv->mib.xdp_pass++;

Since the driver supports multiple RX queues, bcmgenet_run_xdp() can be
executed concurrently by independent NAPI polling instances on different
CPUs.=20

Will these non-atomic read-modify-write operations on the shared priv->mib
structure lead to data races and lost increments?

>  		return XDP_PASS;
>  	case XDP_TX:
[ ... ]
> --- a/drivers/net/ethernet/broadcom/genet/bcmgenet.h
> +++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.h
> @@ -156,6 +156,13 @@ struct bcmgenet_mib_counters {
>  	u32	tx_dma_failed;
>  	u32	tx_realloc_tsb;
>  	u32	tx_realloc_tsb_failed;
> +	u32	xdp_pass;

Because XDP processes packets at high rates, could these 32-bit packet
counters overflow rapidly under heavy traffic?

Would it be safer to maintain these XDP counters as 64-bit values on a
per-queue basis, using u64_stats_t, and aggregate them when queried?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260506095553.5535=
7-1-nb@tipi-net.de?part=3D6
