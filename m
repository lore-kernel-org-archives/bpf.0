Received: from mail-qk2-f12.google.com (mail-qk2-f12.google.com [74.125.230.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EBB34D597F
	for <bpf@vger.kernel.org>; Mon, 28 Sep 2026 15:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790608672; cv=none; b=mgOXwFGZ5fOVOH9Fl+FUiXvKla9HUVMSWCiqjWO653GAzPGan7z93dNmi/1eyAF6dSO+L16THqAhyHEwk5mD2xDKFgYKj156YEdtqH4xs+cslAjRBweJdTptOJ7JRO1ayLGjzcDX9uELOkUxLV8+9htn47+FDhWXOisRr4iH2Dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790608672; c=relaxed/simple;
	bh=MoQp/jgMtWtqRzOkADRju/3eEnGawtzKyzwHaFmhq6M=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=MIZmNrB8+5bCjUx3EkqHZGFg2xexoljouqKGSIexxfV3fqn4OdFgh9TiMMmOK4AYNA3CdfYbqH/3yJYtsZFrvREmJ78LPyGxrAcr5wO5o7Kbr09dJyydTHOPXFjZjqG8z5xkRByHuWPIElB3fAiU2CXIRu6i4KZ9UG1i3jZWpYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mzAwhJrY; arc=none smtp.client-ip=74.125.230.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mzAwhJrY"
Received: by mail-qk2-f12.google.com with SMTP id d75a77b69052e-52fb76ec395so29764161cf.2
        for <bpf@vger.kernel.org>; Mon, 28 Sep 2026 08:17:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790608667; x=1791213467; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ZV1VjMg9qIgs6SKBKtPynhg7qw1pn60aw3c/594G53U=;
        b=mzAwhJrY/IOSVy6pIUpd9UGJyf0c3Yhdguu96XKS3iRqHgH1/GHiiQY49kQsIvc9UR
         JezkTZFrz4QCgRmupc6bEZenURFxhi0vHd1QSkMsDcwcM86mAwvpajsguvYlN13VIn2U
         pqyRzSiL8LVPAsoZG8LsQxIPdfWfYO40HYoZ7pJklhmoKfscCtV8hguCfbSj5N+KAVKF
         jwMQge4Jo5RRUexWNrhSxcBV+0xMNhmgoT1giQgEtlKk+5TY0EEY6sstwNK80VGoiTz4
         U5GJLArPa6/r7v1c+cJmCMJbQrl6ij9vHEbeSPtpv4cnZKmtp4ZoUK714MYrJJCVy+xv
         sG4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790608667; x=1791213467;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZV1VjMg9qIgs6SKBKtPynhg7qw1pn60aw3c/594G53U=;
        b=br21iEUFn9T47BH4OFx6m4R3d7Iyw3VzljiMzTgpa2iqgh5HCmKvAcM3bjoLFWRHMr
         2xkylhmyxxFvFtpmelJnRHE93u2xSDPMkbh+YpXMeMIxDFoGhC2+W3+I7SVZ4uEwsf2+
         rZCHHvZMVwDc81oaMCpwMjYMUU4UGvzrK/v/cZTG5hU2ee6+kmn3sv3Lf2DyPJqzTVRf
         D6bQRI0UaM+NdY1ds5riaQM92EiA3XRCJoQFxUbH/IBgEkPIdvQfRQz0sFxqIERbsWUo
         6wjJxhHkaH/OtYwvkT4dTw83zzUkv0n4HMy+0n4pLOsj/MTApXcX3dnNoQRDOxDm0nnl
         NmEg==
X-Forwarded-Encrypted: i=1; AKwUvBxG5yqi5ftnQt57gy8wUptG9rJSE84ZPFVOxhK1CtPTrjwiSNYiIXRnuK9PMJni3/dVhzU=@vger.kernel.org
X-Gm-Message-State: AFuF++nc9IzIuqN32kEhavgX65r3D5S8XLc4wzWHBQ+lxgQfM1Qiw9vv
	sun0zPQJKpGUQPDQqIoxZa77HMZpzHYtQxnwPL+MuptTyZ8v1DhS/9v5
X-Gm-Gg: AYBFou0HF8FQbkkPNo4mJPddnqcXYmEHvsAhmk7NeYip9e4FrXdyI+XJ0hVe+eyLK+C
	6ChLhkL1Qu6Hw+4cR2MUls7Lm65+qxgnhXcHy/Nmi5CYB0EU+W5EZb+VErEScBwzCpAVCJjyP9g
	ad6N1jk1fb5uNNFbE4VUkSfMeF4cwVMfz8kdFoAFT+M3C9fgxK3zfh/n/0ZNy/o03cbk/NwgI4d
	s39gfvMOBAWpbD4YzNbQ3M1uIeqf2f0JRRitJnxPGr4aY1q+3De4i7yorJ3xRXrzPh83VHV65bu
	lEWyxff9Yoj+W+qigs8tvpfX7XOgv8nG9gJ63rtWTEYsZ3gAHu+rKD54ruuOz85V89/VkBSijiY
	95dB1419eZsRncTQfbYNnY9kHlsHjLTkz1yUfD42Mz8Bcwnd5Kf3Jq4YUiBem/ndt2evnqRUedh
	Qv/bgVlBZKo3paJXHRZ+j+P3qTsYLM7vgHjQJpGViLwKSpXSm66qdt4tfgcc7ed57RJTz//SNpJ
	n4=
X-Received: by 2002:a05:622a:508:b0:530:2cc6:c8ad with SMTP id d75a77b69052e-5330b5ad6e9mr224448801cf.19.1790608666743;
        Mon, 28 Sep 2026 08:17:46 -0700 (PDT)
Received: from localhost ([2600:4040:9399:4000:e553:72e5:7d37:c7ef])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5332242ae75sm65540811cf.29.2026.09.28.08.17.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Sep 2026 08:17:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 28 Sep 2026 11:17:42 -0400
Message-Id: <DLR1SNM0T642.1TU5R4E1EQQ32@gmail.com>
Cc: <alexanderduyck@fb.com>, <kuba@kernel.org>, <kernel-team@meta.com>,
 <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
 <pabeni@redhat.com>, <ast@kernel.org>, <daniel@iogearbox.net>,
 <hawk@kernel.org>, <john.fastabend@gmail.com>, <sdf@fomichev.me>,
 <dimitri.daskalakis1@gmail.com>, <mohsin.bashr@gmail.com>,
 <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
 <bpf@vger.kernel.org>
Subject: Re: [PATCH net-next v2 8/8] eth: mpnic: add basic Rx handling
From: "Daniel Zahka" <daniel.zahka@gmail.com>
To: <netdev-bot+sashiko@kernel.org>, <daniel.zahka@gmail.com>
X-Mailer: aerc 0.21.0-threadmapfix
References: <20260924-linux-mpnic-v2-8-4badc9b58b9e@gmail.com>
 <179055370821.3145.15563353156431464401@kernel.org>
In-Reply-To: <179055370821.3145.15563353156431464401@kernel.org>

On Sun Sep 27, 2026 at 8:01 PM EDT, netdev-bot+sashiko wrote:
> Thank you for your contribution! Sashiko AI review found 4 potential
> issue(s) to consider.
>
> Critical: 0 =C2=B7 High: 0 =C2=B7 Medium: 4 =C2=B7 Low: 0
>
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwor=
k
> know by including "pw-bot: cr" as a separate line at the end of your repl=
y
> (one such reply per series is enough).
>
> - [Medium] Rx buffer queues can starve for good after a page allocation
>   failure.
> - [Medium] mpnic_clean_rcq() never checks that a frame is in progress
>   before handling a descriptor.
> - [Medium] mpnic_page_pool_get() indexes ring->rx_buf[idx] with the raw
>   18-bit MPNIC_RCD_AL_BUFF_ID from the completion descriptor (up to=E2=80=
=A6
> - [Medium] The descriptor fields BUFF_OFF (16 bits) and BUFF_LEN (14
>   bits) are used without range checks to build the skb head, frame_sz,=E2=
=80=A6
>
> --
>
> eth: mpnic: add basic Rx handling
>
> This commit adds Rx completion processing to the mpnic driver. Each frame
> is built in an xdp_buff from three kinds of descriptor: a header
> descriptor, one payload descriptor per page and a closing metadata
> descriptor. The frame is then passed to GRO, and pages are shared between
> frames using a batched page_pool reference bias.
>
>> diff --git a/drivers/net/ethernet/meta/mpnic/mpnic_txrx.c b/drivers/net/=
ethernet/meta/mpnic/mpnic_txrx.c
>> index 389a9e5476c6e..edb07b7f334bd 100644
>> --- a/drivers/net/ethernet/meta/mpnic/mpnic_txrx.c
>> +++ b/drivers/net/ethernet/meta/mpnic/mpnic_txrx.c
>> @@ -405,6 +405,34 @@ static void mpnic_fill_qt_bdqs(struct mpnic_q_triad=
 *qt)
>
> [ ... ]
>
>> +static struct page *
>> +mpnic_page_pool_get(struct mpnic_pg_ctxt *pg_ctxt, struct mpnic_ring *r=
ing,
>> +		    u32 idx)
>> +{
>> +	struct page *page =3D pg_ctxt->page;
>> +
>> +	if (unlikely(pg_ctxt->idx !=3D idx)) {
>> +		if (pg_ctxt->pagecnt_bias &&
>> +		    !page_pool_unref_page(page, pg_ctxt->pagecnt_bias))
>> +			page_pool_put_unrefed_page(page->pp, page, -1, true);
>> +
>> +		page =3D ring->rx_buf[idx];
>> +		page_pool_fragment_page(page, MPNIC_PAGECNT_BIAS_MAX);
>
> [Severity: Medium]
> Here idx is the raw MPNIC_RCD_AL_BUFF_ID field from the completion
> descriptor. mpnic_pkt_prepare() and mpnic_add_rx_frag() pass it through
> unchanged. The field is 18 bits wide (up to 262143), but rx_buf[] only
> has hpq_size/ppq_size entries (256 by default).
>
> Could a bad buffer ID from the device read past the end of rx_buf[]?
> page_pool_fragment_page() would then write pp_ref_count through
> whatever pointer it found there.
>
> An in-range ID for a slot the device already completed seems like it
> would also reset the refcount of a page that in-flight skbs still own.
>
> mpnic_bd_prep() only posts IDs in [0, size_mask], so this needs a faulty
> or misbehaving device. Would it be worth masking idx with
> ring->size_mask, or rejecting IDs that are out of range?
>

Comment addressed in v1.

> [ ... ]
>
>> @@ -417,6 +445,87 @@ static void mpnic_flush_pg_ctxt(struct mpnic_pg_ctx=
t *ctxt, bool napi)
>>  	}
>>  }
>> =20
>> +static unsigned int mpnic_hdr_pg_start(unsigned int pg_off)
>> +{
>
> [ ... ]
>
>> +	if (ALIGN(MPNIC_RX_HROOM, 128) > MPNIC_RX_HROOM &&
>> +	    pg_off =3D=3D ALIGN(MPNIC_RX_HROOM, 128))
>> +		return 0;
>> +
>> +	return pg_off - MPNIC_RX_HROOM;
>> +}
>
> [Severity: Medium]
> If the device reports a BUFF_OFF smaller than MPNIC_RX_HROOM, does this
> unsigned subtraction wrap around and produce a huge pg_start?
>
> The BUFF_OFF (16 bits) and BUFF_LEN (14 bits) fields are used without
> range checks in a few other places:
>
> - mpnic_hdr_pg_end() can return values well beyond PAGE_SIZE. These
>   feed frame_sz in mpnic_pkt_prepare(), which decides where
>   skb_shared_info is written.
>
> - With fin set and pg_off larger than page_size(page), frame_sz in
>   mpnic_pkt_prepare() and truesz in mpnic_add_rx_frag() both underflow.
>
> - In mpnic_add_rx_frag(), a payload frag with pg_off + len past
>   page_size(page) would expose adjacent memory to the stack.
>
> The same values also set the page_pool_dma_sync_for_cpu() ranges.
>
> A device that follows the configured HROOM/TROOM/MAX_HEADER_BYTES layout
> should not produce these values. Would a sanity check against
> page_size(page) still be worth adding?
>

We trust the offset field written by the device.

> [ ... ]
>
>> @@ -442,23 +551,99 @@ static void mpnic_put_pkt_buff(struct mpnic_pkt_ct=
xt *ctxt, bool napi)
>>  	page_pool_put_full_page(page->pp, page, napi);
>>  }
>> =20
>> +static int mpnic_clean_rcq(struct mpnic_napi_vector *nv,
>> +			   struct mpnic_q_triad *qt, int budget)
>> +{
>
> [ ... ]
>
>> +		switch (FIELD_GET(MPNIC_RCD_TYPE, rcd)) {
>> +		case MPNIC_RCD_TYPE_HDR_AL:
>> +			if (FIELD_GET(MPNIC_RCD_HDR_SUBTYPE, rcd) =3D=3D
>> +			    MPNIC_RCD_HDR_SUBTYPE_HDR)
>> +				mpnic_pkt_prepare(rcd, state, qt);
>> +			break;
>> +		case MPNIC_RCD_TYPE_PAY_AL:
>> +			mpnic_add_rx_frag(rcd, state, qt);
>> +			break;
>> +		case MPNIC_RCD_TYPE_META: {
>> +			struct sk_buff *skb =3D NULL;
>> +
>> +			if (likely(!(rcd &
>> +				     MPNIC_RCD_META_UNCORRECTABLE_ERR_MASK) &&
>> +				   !state->pkt.add_frag_failed))
>> +				skb =3D xdp_build_skb_from_buff(&state->pkt.buff);
>> +
>> +			if (likely(skb))
>> +				napi_gro_receive(&nv->napi, skb);
>> +			else
>> +				mpnic_put_pkt_buff(&state->pkt, true);
>> +
>> +			state->pkt.buff.data_hard_start =3D NULL;
>
> [Severity: Medium]
> Nothing checks that a frame is in progress before a PAY_AL or META
> descriptor is handled. state->pkt.buff.data_hard_start is zero at
> start and is set back to NULL after every META.
>
> Suppose a PAY_AL arrives without a preceding HDR descriptor.
> mpnic_add_rx_frag() then calls xdp_buff_add_frag(), which writes to
> skb_shared_info at an address based on a NULL data_hard_start and a
> stale frame_sz.
>
> A META in the same state would take the success branch:
>
> mpnic_clean_rcq()
>   xdp_build_skb_from_buff()
>     napi_build_skb(NULL, frame_sz)
>
> Only the error path, mpnic_put_pkt_buff(), checks data_hard_start.
>
> Can either of these cause a NULL pointer dereference in NAPI context?
>
> HDR_AL descriptors whose subtype is not MPNIC_RCD_HDR_SUBTYPE_HDR are
> skipped silently, so a frame that starts that way would hit the same
> path.
>
> The opposite case is also possible. mpnic_pkt_prepare() overwrites
> state->pkt.buff without releasing the page_pool references of an
> unfinished frame. Could that leak pages and stall page_pool_destroy()?
>
> fbnic_pkt_prepare() has a WARN_ON_ONCE(xdp->data_hard_start) at this
> point, and mpnic_pkt_prepare() drops it. Would it make sense to keep it?
>
> All of this needs the device to break the HDR, PAY_AL*, META ordering.
>

Same comment responded to in v1.

> [ ... ]
>
>> +	rcq->head =3D head;
>> +
>> +	/* Allocate buffers, force dma_wmb(), and then start writing tails */
>> +	mpnic_fill_qt_bdqs(qt);
>> +
>> +	return packets;
>> +}
>> +
>>  static int mpnic_poll(struct napi_struct *napi, int budget)
>>  {
>
> [ ... ]
>
>> -	if (likely(napi_complete_done(napi, 0)))
>> +	if (work_done >=3D budget)
>> +		return budget;
>> +
>> +	if (likely(napi_complete_done(napi, work_done)))
>>  		mpnic_nv_irq_rearm(nv);
>
> [Severity: Medium]
> mpnic_clean_rcq() is the only runtime caller of mpnic_fill_qt_bdqs().
> __mpnic_fill_bdq() simply stops when the page pool allocation fails:
>
> 		page =3D page_pool_dev_alloc_pages(bdq->page_pool);
> 		if (!page)
> 			break;
>
> The shortfall is never reported back, because mpnic_clean_rcq() only
> returns the packet count. mpnic_poll() then completes NAPI and re-arms
> the IRQ anyway.
>
> Say the allocation fails while the device has no posted buffers left,
> or fewer than the 16-descriptor HPQ/PPQ drop threshold. The device then
> drops incoming frames without writing any RCQ completions. What would
> schedule NAPI again in that case?
>
> There doesn't seem to be a timer, a service task, a forced IRQ trigger,
> or a return of the full budget to retry the refill. The only
> mpnic_nv_irq_trigger() call is in mpnic_napi_enable(). The only way out
> seems to be a Tx completion on the same vector.
>
> Could a receive-mostly queue stay stuck until the interface is brought
> down and up again?
>
> [ ... ]

Valid. We prefer to address this in a small follow up series.=20
