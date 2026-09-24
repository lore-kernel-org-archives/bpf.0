Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F26238B7B0
	for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 01:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790214279; cv=none; b=IGjP6TVbKIzozb7nwZcZRhAwXNK7AdenPBxyQj/R5HNumooc9O4VzWdzpedKq6CVWW3qo7Y7xg9GqhE7hLJaw34ghasijyJo6dYCNI00MRUtCLD53A+l6RVg8ONR0MU4G4tnTjdf1oIaC1z3XMgUr3wW04JDRme3yWiNeVPipFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790214279; c=relaxed/simple;
	bh=9FLTsGHQU41tAFmZRJnWfnrFQmunYK9m72d+mRGatwU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=IRpcjeBzNHfp2TFEhljn6p2RcsqEdUiHB84xG78c2JPRO5AJ0HVT3e7J6uO9tPvrUZUpyIXUi7HPeGs/jjbVhYp622i9RAlea3QV1dLvEmMY/+QFXkcewDkT2VYXy8DIzcIywDc1mO3pP3yFVVf8YMG0eXBvj7WM0e3HNCGcq7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rwm8fbyj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rwm8fbyj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8963E1F00893;
	Thu, 24 Sep 2026 01:44:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790214276;
	bh=AYgVtkmZcCqL3S4XQtx7IVWtw2nAk/VYKrtudwiuZCs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Rwm8fbyjGUiRayydFoywChwtl5Ya3zCUOnYz/QQbZj10yeNmWtjyV62iafaCKy8iu
	 oNQNNVcDhHOMyWAW6L0Yvna49nVON9D7+1pN0J1hW0JrbIZ0S3mSSWLmL+4fO55Bei
	 DROmXSkbscBPZeAyZ0c1EYL5IEoju8+Qs2RS4CwYdfEw5v659qcQ4+oh2WwivB8p5G
	 uJ6kdyhgPUBsLuKpea6Etxg9rxIgrHjPUi7NlSeTiOdj3a2e7hFvt5ApUPutxAOGA+
	 kL6X6Vwlbpswy6ILTiRe+CrZvkkaOo6YgdzrRNLMUadEfKPHImtBrVEnKo2unbOwVG
	 mcmlsi0DdpZQg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next 8/8] eth: mpnic: add basic Rx handling
Reply-To: sashiko-reviews@lists.linux.dev
To: "Daniel Zahka" <daniel.zahka@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260922-linux-mpnic-v1-8-236844f53072@gmail.com>
References: <20260922-linux-mpnic-v1-0-236844f53072@gmail.com>
 <20260922-linux-mpnic-v1-8-236844f53072@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 24 Sep 2026 01:44:36 +0000
Message-Id: <20260924014436.8963E1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] net: mpnic: unbounded NAPI budget in mpnic_poll causes fairness vi=
olation
- [High] net: mpnic: missing descriptor sequence validation causes NULL poi=
nter dereference
- [Medium] net: mpnic: direct DMA sync on page pool buffers breaks memory p=
roviders
--

commit a0a26aee27284ff3d767cd871801499330442f84
Author: Daniel Zahka <daniel.zahka@gmail.com>

eth: mpnic: add basic Rx handling

This commit introduces basic receive handling for the mpnic driver. It=20
assembles frames using completion descriptors, merging contiguous payload
fragments, and utilizes a batched page reference strategy to manage=20
xdp_buff allocations.

> diff --git a/drivers/net/ethernet/meta/mpnic/mpnic_txrx.c b/drivers/net/e=
thernet/meta/mpnic/mpnic_txrx.c
> --- a/drivers/net/ethernet/meta/mpnic/mpnic_txrx.c
> +++ b/drivers/net/ethernet/meta/mpnic/mpnic_txrx.c
[ ... ]
> +static void
> +mpnic_pkt_prepare(struct mpnic_napi_vector *nv, u64 rcd,
> +		  struct mpnic_rcq_state *state, struct mpnic_q_triad *qt)
> +{
[ ... ]
> +	/* Short-cut the end calculation if the page is fully consumed */
> +	pg_end =3D fin ? page_size(page) : mpnic_hdr_pg_end(pg_off, len);
> +	frame_sz =3D pg_end - pg_start;
> +
> +	dma_sync_single_range_for_cpu(nv->dev, page_pool_get_dma_addr(page),
> +				      pg_start, frame_sz, DMA_FROM_DEVICE);

[Severity: Medium]
Does this break the abstraction for memory providers like dmabuf?=20
Using dma_sync_single_range_for_cpu() directly on page pool buffers bypasse=
s=20
the standard page pool synchronization hooks like page_pool_dma_sync_for_cp=
u()=20
or page_pool_dma_sync_netmem_for_cpu().

> +
> +	xdp_init_buff(buff, frame_sz, &qt->xdp_rxq);
> +	xdp_prepare_buff(buff, page_address(page) + pg_start,
> +			 pg_off - pg_start, len, true);
> +	net_prefetch(buff->data);
> +
> +	state->add_frag_failed =3D false;
> +}
> +
> +static void
> +mpnic_add_rx_frag(struct mpnic_napi_vector *nv, u64 rcd,
> +		  struct mpnic_rcq_state *state, struct mpnic_q_triad *qt)
> +{
[ ... ]
> +	truesz =3D (fin ? page_size(page) : ALIGN(pg_off + len, 128)) - pg_off;
> +
> +	dma_sync_single_range_for_cpu(nv->dev, page_pool_get_dma_addr(page),
> +				      pg_off, truesz, DMA_FROM_DEVICE);

[Severity: Medium]
Similarly here, does direct use of dma_sync_single_range_for_cpu() on the=20
payload fragments circumvent the required page pool wrappers?

> +
> +	if (!xdp_buff_add_frag(buff, page_to_netmem(page), pg_off, len,
> +			       truesz)) {

[Severity: High]
Can a malformed descriptor sequence crash the kernel here?

If the hardware delivers a payload (PAY_AL) descriptor before a header=20
(HDR_AL) descriptor, mpnic_pkt_prepare() won't be called, so the buffer=20
won't be properly initialized. The data_hard_start field would remain NULL,=
=20
causing xdp_buff_add_frag() to compute an invalid pointer for the=20
skb_shared_info.

> +		state->payld.pagecnt_bias++;
> +		state->add_frag_failed =3D true;
> +	}
> +}
[ ... ]
> +static int mpnic_clean_rcq(struct mpnic_napi_vector *nv,
> +			   struct mpnic_q_triad *qt, int budget)
> +{
[ ... ]
> +	while (packets < budget) {
> +		u64 rcd;
> +
> +		if ((*raw_rcd & cpu_to_le64(MPNIC_RCD_DONE)) !=3D done)
> +			break;
> +
> +		dma_rmb();
> +
> +		rcd =3D le64_to_cpu(*raw_rcd);
> +
> +		switch (FIELD_GET(MPNIC_RCD_TYPE, rcd)) {
> +		case MPNIC_RCD_TYPE_HDR_AL:
> +			if (FIELD_GET(MPNIC_RCD_HDR_SUBTYPE, rcd) =3D=3D
> +			    MPNIC_RCD_HDR_SUBTYPE_HDR)
> +				mpnic_pkt_prepare(nv, rcd, state, qt);
> +			break;
> +		case MPNIC_RCD_TYPE_PAY_AL:
> +			mpnic_add_rx_frag(nv, rcd, state, qt);
> +			break;
> +		case MPNIC_RCD_TYPE_META: {
> +			struct sk_buff *skb =3D NULL;
> +
> +			if (likely(!(rcd &
> +				     MPNIC_RCD_META_UNCORRECTABLE_ERR_MASK) &&
> +				   !state->add_frag_failed))
> +				skb =3D xdp_build_skb_from_buff(&state->pkt);

[Severity: High]
If a metadata (META) descriptor is received before any header descriptor=20
(HDR_AL), could xdp_build_skb_from_buff() also attempt to operate on an=20
uninitialized state->pkt and dereference a NULL data_hard_start?

> +
> +			if (likely(skb))
> +				napi_gro_receive(&nv->napi, skb);
> +			else
> +				mpnic_put_pkt_buff(&state->pkt, true);
> +
> +			state->pkt.data_hard_start =3D NULL;
> +			packets++;
> +			break;
> +		}
> +		}
[ ... ]
>  static int mpnic_poll(struct napi_struct *napi, int budget)
>  {
>  	struct mpnic_napi_vector *nv =3D container_of(napi,
>  						    struct mpnic_napi_vector,
>  						    napi);
> -	int i;
> +	int i, j, work_done =3D 0;
> =20
>  	for (i =3D 0; i < nv->txt_count; i++)
>  		mpnic_clean_tcq(nv, &nv->qt[i], budget);
> =20
> +	for (j =3D 0; j < nv->rxt_count; j++, i++)
> +		work_done +=3D mpnic_clean_rcq(nv, &nv->qt[i], budget);

[Severity: High]
Does this allow the total work done to dramatically exceed the NAPI limit?

The full budget is unconditionally passed to every RX queue without dividing
or subtracting the work already done. A NAPI vector with multiple RX queues
handling a burst could process nv->rxt_count * budget packets, potentially
defeating softirq fairness mechanisms and causing high system latency.

> +
>  	for (i =3D 0; i < nv->txt_count; i++)
>  		mpnic_commit_cq_head(&nv->qt[i].cmpl);
> =20
> -	if (likely(napi_complete_done(napi, 0)))
> +	if (work_done >=3D budget)
> +		return budget;
> +
> +	if (likely(napi_complete_done(napi, work_done)))
>  		mpnic_nv_irq_rearm(nv);
> =20
> -	return 0;
> +	return work_done;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260922-linux-mpni=
c-v1-0-236844f53072@gmail.com?part=3D8
