Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4B762E06ED
	for <bpf@vger.kernel.org>; Sat, 26 Sep 2026 00:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790382965; cv=none; b=YTGHJCYlU78PY+XMYFOwjkkMphaVgHscSUxabt8eY9W9js18BFRJX1oZ56OfKQvezEHHJVMVqNyVWTOH6LlvRSMJLAOpriB2eS+cgsNXiYiNNprgA5myLv955qjj2PkEOO3BYGTF0JoW0wD4qbC2HXHzGXTUM/npCjeVWpgAukw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790382965; c=relaxed/simple;
	bh=Ua2zuctLiWp32yLVMzUOTFaHGm9mZqG+tYtypeW8wMY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=gtMhvMbtOrPucf57HMo5dOHTOdDmfMba+Zv/0MvtChrP0N3RBqE/Sl38ztSWcqsNfTJYkmFaFFIjsQdI9JOALv7zgHRRmaMddIuLQOL3VBBWDFhyPRlj4AnQDNbZM9EBwCZ+ZH/hjvK9CjRR18s9bL+vlBGHXtEASxMJPTja+Rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U5zK9YXw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U5zK9YXw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45E161F000FF;
	Sat, 26 Sep 2026 00:36:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790382963;
	bh=F1qeGI2VWE4x/r8SskhqMRA3x2buDJXieBZwouf9G/k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=U5zK9YXwvP6IeYPSe5o0TsJjXsaXHZYT+UK7dl/pqWdkvKbkkcyU+8FoJGGgt3xfo
	 12C7cMrPqRH8jG9SKoVcwqcaZpXjX01crzNqgq7fTgwh5oWXOmNB9io7VeHDg9VwMO
	 kvJGYS2EwjsUBC9lT5D327TPSFKa9JNmAwTXa3h3vHhTQkHs4+apsH2QNQE3oRRqub
	 1v/RcYB6u6HdvmKqc4gAdiOqTXLSvytO7EPJ+LITV+DEsGjOGYmOsieLfGzHo6EFTx
	 Q0dux2aEnXOWzrEe3SUeDgW5czjgXOnI/l3Ij51AKDuruugTOwt5e5QUNGxseBgOhr
	 sJLWlJNfL4Jlg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v2 8/8] eth: mpnic: add basic Rx handling
Reply-To: sashiko-reviews@lists.linux.dev
To: "Daniel Zahka" <daniel.zahka@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260924-linux-mpnic-v2-8-4badc9b58b9e@gmail.com>
References: <20260924-linux-mpnic-v2-0-4badc9b58b9e@gmail.com>
 <20260924-linux-mpnic-v2-8-4badc9b58b9e@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 26 Sep 2026 00:36:02 +0000
Message-Id: <20260926003603.45E161F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] net: mpnic: rx starvation in mpnic_poll due to sequential queue pr=
ocessing
- [Medium] net: mpnic: NULL pointer dereference on META descriptor without =
HDR
- [Medium] net: mpnic: NULL pointer dereference on PAY descriptor without H=
DR
--

commit a3920f68fea82b63522bdc2a1f1ed39c3a9d052a
Author: Daniel Zahka <daniel.zahka@gmail.com>

    eth: mpnic: add basic Rx handling
   =20
    A frame arrives as a run of completion descriptors: one header
    address/length descriptor, one address/length descriptor per payload
    page, and a metadata descriptor that closes the frame. The frame is
    assembled in an xdp_buff as the descriptors come in and handed to the
    stack when the metadata descriptor arrives.

[ ... ]

> diff --git a/drivers/net/ethernet/meta/mpnic/mpnic_txrx.c b/drivers/net/e=
thernet/meta/mpnic/mpnic_txrx.c
> index 389a9e5476c6e..edb07b7f334bd 100644
> --- a/drivers/net/ethernet/meta/mpnic/mpnic_txrx.c
> +++ b/drivers/net/ethernet/meta/mpnic/mpnic_txrx.c

[ ... ]

> +static void
> +mpnic_add_rx_frag(u64 rcd, struct mpnic_rcq_state *state,
> +		  struct mpnic_q_triad *qt)
> +{
> +	unsigned int pg_off =3D FIELD_GET(MPNIC_RCD_AL_BUFF_OFF, rcd);
> +	unsigned int pg_idx =3D FIELD_GET(MPNIC_RCD_AL_BUFF_ID, rcd);
> +	unsigned int len =3D FIELD_GET(MPNIC_RCD_AL_BUFF_LEN, rcd);
> +	bool fin =3D FIELD_GET(MPNIC_RCD_AL_PAGE_FIN, rcd);
> +	struct xdp_buff *buff =3D &state->pkt.buff;
> +	unsigned int truesz;
> +	struct page *page;
> +
> +	page =3D mpnic_page_pool_get(&state->payld, &qt->sub1, pg_idx);
> +	qt->sub1.head =3D (pg_idx + 1) & qt->sub1.size_mask;
> +
> +	truesz =3D (fin ? page_size(page) : ALIGN(pg_off + len, 128)) - pg_off;
> +
> +	page_pool_dma_sync_for_cpu(qt->sub1.page_pool, page, pg_off, truesz);
> +
> +	if (!xdp_buff_add_frag(buff, page_to_netmem(page), pg_off, len,
> +			       truesz)) {

[Severity: Medium]
Will this crash if a PAY_AL descriptor arrives before a HDR_AL descriptor?

If the hardware delivers a malformed sequence or drops a descriptor,
state->pkt.buff.data_hard_start might be NULL here. The call to
xdp_buff_add_frag() would then calculate the skb_shared_info pointer relati=
ve
to NULL minus SKB_DATA_ALIGN. Writing to sinfo->nr_frags at this invalid
memory address would cause an immediate page fault.

Is there a missing check to verify an active frame was properly started?

> +		state->payld.pagecnt_bias++;
> +		state->pkt.add_frag_failed =3D true;
> +	}
> +}

[ ... ]

> +static int mpnic_clean_rcq(struct mpnic_napi_vector *nv,
> +			   struct mpnic_q_triad *qt, int budget)
> +{
> +	struct mpnic_ring *rcq =3D &qt->cmpl;
> +	struct mpnic_rcq_state *state;
> +	unsigned int packets =3D 0;
> +	__le64 *raw_rcd, done;
> +	u32 head =3D rcq->head;
> +
> +	done =3D (head & (rcq->size_mask + 1)) ? 0 : cpu_to_le64(MPNIC_RCD_DONE=
);
> +	raw_rcd =3D &rcq->desc[head & rcq->size_mask];
> +	state =3D rcq->state;
> +
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
> +				mpnic_pkt_prepare(rcd, state, qt);
> +			break;
> +		case MPNIC_RCD_TYPE_PAY_AL:
> +			mpnic_add_rx_frag(rcd, state, qt);
> +			break;
> +		case MPNIC_RCD_TYPE_META: {
> +			struct sk_buff *skb =3D NULL;
> +
> +			if (likely(!(rcd &
> +				     MPNIC_RCD_META_UNCORRECTABLE_ERR_MASK) &&
> +				   !state->pkt.add_frag_failed))
> +				skb =3D xdp_build_skb_from_buff(&state->pkt.buff);

[Severity: Medium]
Could this trigger a NULL pointer dereference when accessing unmapped memor=
y?

If no preceding MPNIC_RCD_TYPE_HDR_AL descriptor was received for the frame,
state->pkt.buff.data_hard_start remains NULL. The driver then blindly calls
xdp_build_skb_from_buff(), passing the uninitialized buffer to
napi_build_skb(NULL, 0). The core network stack passes NULL to ksize(), whi=
ch
returns 0, leading to an integer underflow when subtracting SKB_DATA_ALIGN.
The resulting pointer is memset, causing an immediate crash.

Should we validate that a valid header descriptor was previously received
to initialize the buffer before attempting to build the SKB?

> +
> +			if (likely(skb))
> +				napi_gro_receive(&nv->napi, skb);
> +			else
> +				mpnic_put_pkt_buff(&state->pkt, true);

[ ... ]

> +static int mpnic_poll(struct napi_struct *napi, int budget)
> +{
> +	struct mpnic_napi_vector *nv =3D container_of(napi,
> +						    struct mpnic_napi_vector,
> +						    napi);
> -	int i;
> +	int i, j, work_done =3D 0;
> =20
>  	for (i =3D 0; i < nv->txt_count; i++)
>  		mpnic_clean_tcq(nv, &nv->qt[i], budget);
> =20
> +	if (likely(budget))
> +		for (j =3D 0; j < nv->rxt_count; j++, i++)
> +			work_done +=3D mpnic_clean_rcq(nv, &nv->qt[i],
> +						     budget - work_done);

[Severity: High]
Can this permanently bias NAPI budget allocation and starve higher-indexed =
Rx
queues?

The loop unconditionally starts at index 0 and passes the remaining NAPI
budget (budget - work_done) to each subsequent queue. If the first queue
continuously exhausts the entire budget under heavy load, budget - work_done
becomes 0 for the remaining queues.

Because the loop does not remember its position across NAPI poll cycles, it
will always restart at queue 0, permanently starving higher-indexed queues.
Could a high rate of traffic to the first queue cause a complete denial of
service for flows hashed to other queues on the same NAPI vector?

> +
>  	for (i =3D 0; i < nv->txt_count; i++)
>  		mpnic_commit_cq_head(&nv->qt[i].cmpl);

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260924-linux-mpni=
c-v2-0-4badc9b58b9e@gmail.com?part=3D8
