Received: from mail-qk2-f42.google.com (mail-qk2-f42.google.com [74.125.230.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B225F4A1E03
	for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 18:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790275090; cv=none; b=MwIqL7aJiDT5JNmHgMcpbyPEbmyY6hrme03qxPVHHabg95IhUqPsY/rPkBjCd4t0HVAS7VkS5GgOqAcxwxv85iGgRZmm6xpYGhxLp47ZwmrSAngVXXZu4lQx4sBPaijmgnrHcOts/C8azb8VCNrUx01fJB/GAnMpRQS822ZqiN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790275090; c=relaxed/simple;
	bh=jDMyY25SD1agu2yAoZSbI5/zI0MpNNINxARme0aA7Oo=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=Z9YSnTEtRk9xLH1t4XfJX6DXXxRYo0mwrR5Vc27JG/02gubUQIygoMapQtp1kPJX+NUu3ZMhsHhdLkJG/EtT5Ak19uoivYJrHgjjsRv32EXeheq0mo6bduFUoikzRjHlbtUIayVERpVPfMIPirtJJStDSxR30AD2jI/XljDIw3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lSDMKa1k; arc=none smtp.client-ip=74.125.230.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lSDMKa1k"
Received: by mail-qk2-f42.google.com with SMTP id d75a77b69052e-5329fc7b325so1374871cf.0
        for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 11:38:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790275087; x=1790879887; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=GnbJYTVPTH+t9CBzvhTBcaoylRbGcUGhspi/wCC4yTE=;
        b=lSDMKa1ktkgWsHhG22rAk35Adcd9GfDZ1Ga5IqZffXhvj7zbKLKHWrIRACrcxEUfjF
         6BCa7ageQpHNMdQZzAnIfYgcPHxQ8wCwIcMOl2/1adAdMj8iTbD/C/4YaU+RZThrJZcL
         NxbvwwqpSxNCaUpkC7bsUfYdd8lNUtNw898xkmqyu6rmkT12BV1wIJhslwGjvcAqb9mT
         +Ca57rWRu9NnzYyq1C+LpCR3Q9hgHqq17zI/wytlC8Ku5HvzbXtoMAd2HVmh8zQEEJlw
         /68ssrMXfX+bK4Hj6pPYgwMDF9nDMMS38XUTLyfAhkNZ92OSoiyqCQ5WfHRoK1iOsqxZ
         zLuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790275087; x=1790879887;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GnbJYTVPTH+t9CBzvhTBcaoylRbGcUGhspi/wCC4yTE=;
        b=uf9Gai1JrYqA1BtG4jnFlLB0V6eAu7JalpMJ9Q5SVSlruTTqaHQsINmjUY3dadyM+Q
         rGLDHGgsaJz0fShSTGzcMu2Q0HCfIUoWIjl3MCjIhKH28zu/rnLhKcaRmob02VUlkx5X
         SYxmiacYMVezXvO50KGdDScaLVskBA71foz5IEF1oaES3ltz8opRnaTgLZWx/afueRMH
         FJdcOB3PYLpqdSUKaiPMimOgB0DTN6kAEPY8OH1aRoZDjA56WY4ZbypAQ8upZkoQvw1E
         eDzYpewMcn5R88/4EjIcZGFziMSskfDO/fS5asSzI5sN7U/fOaW5J1ldxI4IoNU25RBJ
         p6Ug==
X-Forwarded-Encrypted: i=1; AKwUvBywL+VFbtLe2pGc4EXnVxBJ0A8z2U9WcP3zTg7ai/wcPWsGSZp4K2k0m0tDDrgm5sPhfsc=@vger.kernel.org
X-Gm-Message-State: AFuF++ksWkFx0cJX1SFMGUq/DY2LLXjbfdBq5iYFZ74NnGiEGcYU4IMD
	egySk50q+bq4cnOCkgB/ZYoUu6OLHZTcPUkBWRTQXY2pqP00eEaDC1cT
X-Gm-Gg: AYBFou11w/aGUrPiKIi5BsYY3vLv2RLGiKZH4V7g+//huVUfSmns44w7ctI4BrNd1bv
	2PRWSQ9kVUFyh36teVfyOBZHqHyKAMqvvT00YfygK5t2S1p5b3SfGT48kwS+gRabfTpmd31cZj4
	wCBW0xTaM21y5v+cLmbJGCu2fpGj5/pHPyy+v42Bhr7OEFyunanlUX6mPXcriqdxTQB5nibtXI6
	+w8DxGWfao04egGsB8kqOkZ4bEHL1PSP2GDnPuo8aqQoWVlV5uG9xrRPO5ffkuM3G852uS241TJ
	3Zhs3lABbMSnI5ghco7kedmxNsIx0vRk65Y4Qany8zAy1bLC1gTLw5vmAZ58/03Tmnu9z3MpKwW
	Nhr6SMVnQgCKJ2eQgAT8ah4ddKg7ZunwoHVGvx/PsEldcHUAJJYMHf3B0+aRuuFvFVJ/ySu3Bji
	i0B1LAOkWyThg5T3hvTJTxHuaWrylqH/n1hBM/avRtNQZQfPKvqDbHNsYkACJusW7VUk5kIvVSv
	3w=
X-Received: by 2002:a05:620a:29c6:b0:93b:d7a2:dd2a with SMTP id af79cd13be357-93c43d2d07bmr24945185a.58.1790275087360;
        Thu, 24 Sep 2026 11:38:07 -0700 (PDT)
Received: from localhost ([2600:4040:9399:4000:e553:72e5:7d37:c7ef])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93c43d197a9sm8862685a.12.2026.09.24.11.38.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Sep 2026 11:38:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 24 Sep 2026 14:38:05 -0400
Message-Id: <DLNRJWK0BDHR.FFTQ30OYFSVG@gmail.com>
Cc: <alexanderduyck@fb.com>, <kuba@kernel.org>, <kernel-team@meta.com>,
 <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
 <pabeni@redhat.com>, <ast@kernel.org>, <daniel@iogearbox.net>,
 <hawk@kernel.org>, <john.fastabend@gmail.com>, <sdf@fomichev.me>,
 <dimitri.daskalakis1@gmail.com>, <mohsin.bashr@gmail.com>,
 <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
 <bpf@vger.kernel.org>
Subject: Re: [PATCH net-next 8/8] eth: mpnic: add basic Rx handling
From: "Daniel Zahka" <daniel.zahka@gmail.com>
To: <netdev-bot+sashiko@kernel.org>, <daniel.zahka@gmail.com>
X-Mailer: aerc 0.21.0-threadmapfix
References: <20260922-linux-mpnic-v1-8-236844f53072@gmail.com>
 <179021554059.2160803.14215479693472875817@kernel.org>
In-Reply-To: <179021554059.2160803.14215479693472875817@kernel.org>

On Wed Sep 23, 2026 at 10:05 PM EDT, netdev-bot+sashiko wrote:
> Thank you for your contribution! Sashiko AI review found 6 potential
> issue(s) to consider.
>
> Critical: 0 =C2=B7 High: 1 =C2=B7 Medium: 5 =C2=B7 Low: 0
>
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwor=
k
> know by including "pw-bot: cr" as a separate line at the end of your repl=
y
> (one such reply per series is enough).
>
> - [High] net: mpnic: missing descriptor sequence validation causes NULL
>   pointer dereference
> - [Medium] mpnic_poll() calls mpnic_clean_rcq() even when budget is 0.
> - [Medium] When page_pool_dev_alloc_pages() returns NULL,
>   __mpnic_fill_bdq() stops refilling and returns the partial tail.
> - [Medium] mpnic_pkt_prepare() re-initialises state->pkt with
>   xdp_init_buff()/xdp_prepare_buff() without checking whether a frame is=
=E2=80=A6
> - [Medium] mpnic_page_pool_get() indexes ring->rx_buf[idx] with idx =3D
>   FIELD_GET(MPNIC_RCD_AL_BUFF_ID, rcd), an 18-bit device-written field=E2=
=80=A6
> - [Medium] The device-supplied completion fields BUFF_OFF (16 bits) and
>   BUFF_LEN (14 bits) are never checked against page_size(page),=E2=80=A6
>
> --
>
> eth: mpnic: add basic Rx handling
>
> This adds Rx completion processing to mpnic. A frame is assembled into an
> xdp_buff from a header descriptor, one descriptor per payload page and a
> closing metadata descriptor, and then handed to the stack. Page reference=
s
> are taken in batches per page instead of once per frame.
>
>> diff --git a/drivers/net/ethernet/meta/mpnic/mpnic_txrx.c b/drivers/net/=
ethernet/meta/mpnic/mpnic_txrx.c
>> index 6d2123bee97b4..9878ea5a2f8e1 100644
>> --- a/drivers/net/ethernet/meta/mpnic/mpnic_txrx.c
>> +++ b/drivers/net/ethernet/meta/mpnic/mpnic_txrx.c
>> @@ -402,6 +402,34 @@ static void mpnic_fill_qt_bdqs(struct mpnic_q_triad=
 *qt)
>>  	__mpnic_bdq_commit_tail(&qt->sub1, ppq_i);
>>  }
>> =20
>> +/* Take one of the references batched on the page at @idx. If the devic=
e
>> + * has moved on to a new page, first drop the unused references left on
>> + * the previous one.
>> + */
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
> Can idx index past the end of ring->rx_buf[] here?
>

Like I mentioned about the head field in the tx completion descriptor,
we don't harden against device produced completion fields like this.

> idx comes straight from the completion descriptor:
>
>     unsigned int pg_idx =3D FIELD_GET(MPNIC_RCD_AL_BUFF_ID, rcd);
>
> MPNIC_RCD_AL_BUFF_ID is an 18-bit field (DESC_GENMASK(33, 16)). rx_buf[]
> is sized by hpq_size/ppq_size, which is 256 entries by default.
>
> Both callers mask the value only when they update head:
>
>     qt->sub0.head =3D (pg_idx + 1) & qt->sub0.size_mask;
>
> If the device reports a BUFF_ID at or above the ring size, the pointer
> read from past the end of rx_buf[] is written through by
> page_pool_fragment_page(). It is then passed to page_address(), used for
> the DMA sync and attached to the skb.
>
> A conforming device only echoes IDs the driver posted, so hitting this
> needs buggy firmware or an untrusted device. Would it make sense to mask
> idx with ring->size_mask before the lookup?
>
> [ ... ]
>
>> @@ -414,9 +442,90 @@ static void mpnic_flush_pg_ctxt(struct mpnic_pg_ctx=
t *ctxt, bool napi)
>>  	}
>>  }
>> =20
>> -static void mpnic_put_pkt_buff(struct mpnic_pkt_ctxt *ctxt, bool napi)
>> +static unsigned int mpnic_hdr_pg_start(unsigned int pg_off)
>> +{
>> +	/* The headroom of the first header may be larger than
>> +	 * MPNIC_RX_HROOM due to alignment. So account for that by just
>> +	 * making the page offset 0 if we are starting at the first header.
>> +	 */
>> +	if (ALIGN(MPNIC_RX_HROOM, 128) > MPNIC_RX_HROOM &&
>> +	    pg_off =3D=3D ALIGN(MPNIC_RX_HROOM, 128))
>> +		return 0;
>> +
>> +	return pg_off - MPNIC_RX_HROOM;
>> +}
>
> [ ... ]
>
>> +static void
>> +mpnic_pkt_prepare(struct mpnic_napi_vector *nv, u64 rcd,
>> +		  struct mpnic_rcq_state *state, struct mpnic_q_triad *qt)
>> +{
>> +	unsigned int pg_off =3D FIELD_GET(MPNIC_RCD_AL_BUFF_OFF, rcd);
>> +	unsigned int pg_idx =3D FIELD_GET(MPNIC_RCD_AL_BUFF_ID, rcd);
>> +	unsigned int len =3D FIELD_GET(MPNIC_RCD_AL_BUFF_LEN, rcd);
>> +	bool fin =3D FIELD_GET(MPNIC_RCD_AL_PAGE_FIN, rcd);
>> +	unsigned int frame_sz, pg_start, pg_end;
>> +	struct xdp_buff *buff =3D &state->pkt;
>> +	struct page *page;
>> +
>> +	pg_start =3D mpnic_hdr_pg_start(pg_off);
>> +
>> +	page =3D mpnic_page_pool_get(&state->hdr, &qt->sub0, pg_idx);
>> +	qt->sub0.head =3D (pg_idx + 1) & qt->sub0.size_mask;
>> +
>> +	/* Short-cut the end calculation if the page is fully consumed */
>> +	pg_end =3D fin ? page_size(page) : mpnic_hdr_pg_end(pg_off, len);
>> +	frame_sz =3D pg_end - pg_start;
>
> [Severity: High]
> What happens if a PAY_AL or META descriptor reaches this switch without
> a header descriptor opening the frame first?
>
> In that case state->pkt.data_hard_start is NULL. Either the previous
> META cleared it, or no header has been seen since the queue was
> enabled. Nothing on the PAY_AL or META paths checks for this.
>
> For PAY_AL, mpnic_add_rx_frag() first takes a reference through
> mpnic_page_pool_get(). It then calls xdp_buff_add_frag(), which finds
> skb_shared_info through xdp_get_shared_info_from_buff(), computed from
> data_hard_start + frame_sz. With data_hard_start NULL, and frame_sz and
> flags left over from the previous frame, the frag is written through a
> wild pointer near address zero.
>
> For META, the build path runs unless the error bit or add_frag_failed
> is set. add_frag_failed may also be stale from the previous frame.
> xdp_build_skb_from_buff() then calls napi_build_skb() with a NULL
> data_hard_start. On a queue that has never seen a header, xdp->rxq may
> also be unset when rxq->mem.type is read. mpnic_put_pkt_buff() already
> copes with a NULL data_hard_start, but it only runs after the build
> path has failed.
>
> As with the other descriptor trust issues above, a conforming device
> should always open a frame with a header descriptor, so reaching this
> needs buggy or untrusted firmware. The result is a host crash rather
> than a dropped frame, though.
>
> Would it make sense to check state->pkt.data_hard_start in the PAY_AL
> and META cases and drop the descriptor when no frame is being
> assembled? On the PAY_AL path that would also mean returning the
> reference taken by mpnic_page_pool_get(), the same way the
> xdp_buff_add_frag() failure path does.
>

We trust the descriptor stream to be sequenced correctly.

> [Severity: Medium]
> Should BUFF_OFF and BUFF_LEN from the completion be range checked before
> they are used here?
>

Won't fix.

> Neither value is checked against page_size(page), MPNIC_RX_HROOM or
> MPNIC_RX_TROOM:
>
> - mpnic_hdr_pg_start() returns pg_off - MPNIC_RX_HROOM as an unsigned
>   value, so it wraps if pg_off is below the headroom.
>
> - mpnic_hdr_pg_end() can return an end past the page, and
>   frame_sz =3D pg_end - pg_start can wrap. After that,
>   xdp_build_skb_from_buff()->napi_build_skb(data_hard_start, frame_sz)
>   would place and zero skb_shared_info outside the page.
>
> - In mpnic_add_rx_frag(), truesz underflows when fin is set and pg_off is
>   larger than the page:
>
>     truesz =3D (fin ? page_size(page) : ALIGN(pg_off + len, 128)) - pg_of=
f;
>
>   The frag [pg_off, pg_off + len) is also attached with no check that it
>   stays inside the page, which would expose adjacent memory through the
>   skb.
>
> The dma_sync_single_range_for_cpu() calls use the same unchecked ranges.
>
> A conforming device honours the headroom and tailroom programmed in
> mpnic_set_rde_cfg() and stays within the page size, so hitting this needs
> buggy or untrusted hardware.
>
>> +
>> +	dma_sync_single_range_for_cpu(nv->dev, page_pool_get_dma_addr(page),
>> +				      pg_start, frame_sz, DMA_FROM_DEVICE);
>> +
>> +	xdp_init_buff(buff, frame_sz, &qt->xdp_rxq);
>> +	xdp_prepare_buff(buff, page_address(page) + pg_start,
>> +			 pg_off - pg_start, len, true);
>
> [Severity: Medium]
> What happens here to a frame that is still being assembled when a new
> header descriptor arrives?
>
> mpnic_clean_rcq() calls mpnic_pkt_prepare() for every header descriptor.
> It does not check whether state->pkt.data_hard_start is still set by an
> earlier frame that never got its META descriptor:
>
>     case MPNIC_RCD_TYPE_HDR_AL:
>         if (FIELD_GET(MPNIC_RCD_HDR_SUBTYPE, rcd) =3D=3D
>             MPNIC_RCD_HDR_SUBTYPE_HDR)
>             mpnic_pkt_prepare(nv, rcd, state, qt);
>
> In that case xdp_init_buff() clears buff->flags and xdp_prepare_buff()
> replaces data_hard_start. The old frame's header page reference from
> mpnic_page_pool_get() and its frag references from xdp_buff_add_frag()
> can no longer be reached.
>
> The META path and mpnic_flush() cannot release them either, because
> mpnic_flush() only calls mpnic_put_pkt_buff() on the current state->pkt.
> Could the page pool pages leak here, leaving page_pool_destroy() waiting
> forever on inflight pages?
>
> The code does not show whether the hardware can produce HDR, [PAY_AL ...]=
,
> HDR without a META in between. fbnic has a

We trust that the hw cannot produce this sequence.

> WARN_ON_ONCE(pkt->buff.data_hard_start) for this case. Would a similar
> check here, plus releasing the old frame, make sense?
>
> [ ... ]
>
>> @@ -439,23 +548,97 @@ static void mpnic_put_pkt_buff(struct mpnic_pkt_ct=
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
>> +	while (packets < budget) {
>
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
>>  	struct mpnic_napi_vector *nv =3D container_of(napi,
>>  						    struct mpnic_napi_vector,
>>  						    napi);
>> -	int i;
>> +	int i, j, work_done =3D 0;
>> =20
>>  	for (i =3D 0; i < nv->txt_count; i++)
>>  		mpnic_clean_tcq(nv, &nv->qt[i], budget);
>> =20
>> +	for (j =3D 0; j < nv->rxt_count; j++, i++)
>> +		work_done +=3D mpnic_clean_rcq(nv, &nv->qt[i], budget);
>
> [Severity: Medium]
> Is it safe to do the Rx side of the poll when budget is 0?
>

Will address in v2.

> netpoll calls napi->poll(napi, 0) via
> netpoll_poll_dev()->poll_napi()->poll_one_napi(), and netconsole can reac=
h
> that path from any context. With budget 0 the descriptor loop in
> mpnic_clean_rcq() is skipped, but the refill still runs:
>
> mpnic_clean_rcq()
>   mpnic_fill_qt_bdqs()
>     __mpnic_fill_bdq()
>       page_pool_dev_alloc_pages()
>
> The allocation happens whenever mpnic_bdq_desc_unused() is non-zero, for
> example after an earlier allocation failure.
>
> Documentation/networking/napi.rst says "Rx specific APIs like page pool o=
r
> XDP cannot be used at all when budget is 0".
>
> The page_pool allocation fast path, __page_pool_get_cached(), and
> page_pool_refill_alloc_cache() access pool->alloc.cache and the ptr_ring
> consumer side without taking a lock.
>
> The pool was created with .napi =3D &nv->napi. That means
> page_pool_napi_local() allows direct recycling into alloc.cache from
> softirq on the NAPI's list_owner CPU, and netpoll's poll_owner does not
> exclude that.
>
> Could this corrupt alloc.cache or the ring and hand out the same page
> twice? Skipping Rx cleaning and refill when budget is 0 would avoid it.
>
>> +
>>  	for (i =3D 0; i < nv->txt_count; i++)
>>  		mpnic_commit_cq_head(&nv->qt[i].cmpl);
>> =20
>> -	if (likely(napi_complete_done(napi, 0)))
>> +	if (work_done >=3D budget)
>> +		return budget;
>> +
>> +	if (likely(napi_complete_done(napi, work_done)))
>>  		mpnic_nv_irq_rearm(nv);
>
> [Severity: Medium]
> Can Rx stop for good after a run of allocation failures?
>
> When page_pool_dev_alloc_pages() returns NULL, __mpnic_fill_bdq() just
> stops:
>
>     page =3D page_pool_dev_alloc_pages(bdq->page_pool);
>     if (!page)
>         break;
>
> mpnic_clean_rcq() returns only the packet count. So whenever
> work_done < budget, mpnic_poll() completes NAPI and rearms the IRQ, even
> if the refill did not succeed.
>
> If allocations keep failing, successive polls can drain HPQ/PPQ until no
> buffers are posted. The device then has nothing to DMA into and raises no
> Rx interrupts. The only napi_schedule() in the driver is in
> mpnic_msix_clean_rings().
>
> Rx would then stay stopped after memory is available again, until a Tx
> completion on the same vector triggers a poll or the interface is taken
> down and up. Should the poll stay scheduled, or set up a retry, when the
> BDQs could not be refilled?
>

This will be addressed in v2. napi depletion check was improperly left
out of this posting.

>> =20
>> -	return 0;
>> +	return work_done;
>>  }
>
> [ ... ]

