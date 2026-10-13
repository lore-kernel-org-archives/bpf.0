Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10094502777
	for <bpf@vger.kernel.org>; Tue, 13 Oct 2026 12:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791893416; cv=none; b=HwGiB7l8NFhJfzqg915lPwho9QDR9RHLl/sMBFpqcHesIEbGYuCNcm/6a9RuTPUkOqscoHOp2IELUxWK0zoQy23TrOUrfwMUlMMflsXAq+WyQJfQLDrg+3sxNbdK2FN2mVAnFApt61r9CMRGW7XsAEpB0bpD6I6U+jKwXyDuIOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791893416; c=relaxed/simple;
	bh=GHWdQu+f0vsqmE0Oh4jBnx4v1gT5ojrAst+iMVUPEAE=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=cB+Dx18WLDJnmcQx4JPQSa8zDN7GK7Zs4YrX4M7H7jYZa3teR8hw4b9HIqUjcBJnGuJRR0KGg4WhMz47LwYXO08bJAvBxJ3CB/T18H85Nr4ohM7rbE/iyWkQVt/0sSFOUHfidBNNUkliPjUJ2odxxT1/X6vkU6G+yGPyWyPyChw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ig2jQkNa; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ig2jQkNa"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-5350cc60b51so40112751cf.1
        for <bpf@vger.kernel.org>; Tue, 13 Oct 2026 05:10:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791893413; x=1792498213; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ZwDcYbyR4G0p8mjK2+d3aSe5iFBybz7TX246PNHq5QQ=;
        b=Ig2jQkNaA1K+vtjBiOjpdMsWNhpRql5RrL+/HIF+2dgQzGqgwwNW4jVCBh6QgvqxR3
         dwMhee5D8yP+nWaWZnAKwNhRPkjyGHpf8Au/0obfH1JO90ETFQtzLfMTv9/Z0VDiNlWn
         01MRQMuVZU8oVpLuhv0dYM1wSQKoZ3xAbh1NZnm2qGetIGgqBjB7bsWRApvd1iSqFdxk
         fAKJFQDu6c5ODzEw4W/ZV+t/NXOUcB0vqW9B1iOijux5s5DGxtQ3sF4r8o6I7MGQSRSi
         D3fm8tZL3gKf4NU7aQvFTzGnYGR8v7eP8+hC1D7J1BC+QTXE1AzPMBWxGq8IxDpWOx4N
         S9TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791893413; x=1792498213;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZwDcYbyR4G0p8mjK2+d3aSe5iFBybz7TX246PNHq5QQ=;
        b=2Hr2bC+Pwi87PlNB8ZHR6aMKXbvq6IQ+sBdxKILbzAb3OfcjF1wWyFGoiD+GIW0+ip
         CH1GjbF4mHIKRPHuZsCw6F5zJETzYyXID0oamf1NQIuhoPMwbpRfsK+oYyV/xMPEZ7uZ
         tUNAGrlaJfVEszinQ5wjsBBvRErPJyHb2MAI6tPMWDiHhRN7pyv3rj7yULZkWwflJNif
         Te2YYBoopdpqXc/OGK6LmwAsfKJ/bzEwtjkC+ZymyHgaSt+ow3Qb2bQFvWBs8rdmCgJ9
         0vNQaxj6h8YVFJ77Y/nXkq5SNWLdSRm3O4iPZMbIblIHAmYYhjPn3zXA0wW+Xc5tgjLr
         ZEUQ==
X-Forwarded-Encrypted: i=1; AKwUvBy+MZmupnPOh6KzkwH3TFdfaic2aivLskgo2sW9Uxmc1sWU4V+wI7nVUucro2cXqQjSFms=@vger.kernel.org
X-Gm-Message-State: AFq9FYI2ku+mRIj3P4EXyk3VrfBRLN0QJR+vR71JFOektxWBxO30PhrL
	9mmM96gEVMMJZ3wI1iFMWnp09NRAkuMBA6JYvqa+bLQPXyWmVIim/ofa
X-Gm-Gg: AYBFou1zsoAfiwhSz4MkeGzrcvJUeIOj8fqr3B2MJD3YligoqtYujWnWoTqT97L/wZN
	zNuhPjAFWpFgu4455aA483wu26kgm6RNqSLLMFLqTsbFPsCs8KvYVE+NWmVPMnGfcNfu28B/OB0
	QPLAG5gg8ka3Sy4YkOrRr4NJT4LVfhvlSRJiM9Z4OSRgdUKWWQspKL6mvjespxRP/+m+i19hdHu
	VzOnAQFFWmGq6UBDcscuND+BbCkq/haEwYoNZz1xTxw8ykJuNXR+UPdj7OKxpBw3peXKL6woBrr
	jfuOtmgj1IhaYfZAExYU23Bx4LAj7vKGUcWhkzBoO5B0AIoY+Z3sRLSLMelzXaa0F8YgMByfnLU
	3Xaemnb5sVsvLSHNoyGk7KFsV502M/efZHDOPOxJvUmpyQdduJibY36PTTBMXvEMQcpA35bOsO8
	XYlYotQ1lI1gyYe97tMNDEoei7L3ZiPNhw92q90RWwQpuinqqU+EQfXI9AkwF8Lpb+bKSqwF5fD
	f8=
X-Received: by 2002:a05:622a:418c:b0:535:a5f7:d585 with SMTP id d75a77b69052e-535a5f7f25bmr202748801cf.63.1791893412622;
        Tue, 13 Oct 2026 05:10:12 -0700 (PDT)
Received: from localhost ([2600:4040:9399:4000:e553:72e5:7d37:c7ef])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5359b731a6csm100608961cf.11.2026.10.13.05.10.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Oct 2026 05:10:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 13 Oct 2026 08:10:10 -0400
Message-Id: <DM3P78HRJL1J.YHAVDLG84633@gmail.com>
Cc: <alexanderduyck@fb.com>, <kuba@kernel.org>, <kernel-team@meta.com>,
 <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <pabeni@redhat.com>,
 <ast@kernel.org>, <daniel@iogearbox.net>, <hawk@kernel.org>,
 <john.fastabend@gmail.com>, <sdf@fomichev.me>, <edumazet@kernel.org>,
 <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <bpf@vger.kernel.org>
Subject: Re: [PATCH net-next v2 1/4] eth: mpnic: count packets, bytes, and
 drops per ring
From: "Daniel Zahka" <daniel.zahka@gmail.com>
To: <netdev-bot+sashiko@kernel.org>, <daniel.zahka@gmail.com>
X-Mailer: aerc 0.21.0-threadmapfix
References: <20261012-mpnic-counters3-v2-1-8afba81c2d5a@gmail.com>
 <179189313386.434549.472154311742280420@kernel.org>
In-Reply-To: <179189313386.434549.472154311742280420@kernel.org>

On Tue Oct 13, 2026 at 8:05 AM EDT, netdev-bot+sashiko wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider.
>
> Critical: 0 =C2=B7 High: 0 =C2=B7 Medium: 1 =C2=B7 Low: 0
>
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwor=
k
> know by including "pw-bot: cr" as a separate line at the end of your repl=
y
> (one such reply per series is enough).
>
> - [Medium] In mpnic_clean_rcq()
>   (drivers/net/ethernet/meta/mpnic/mpnic_txrx.c), an Rx frame the driver=
=E2=80=A6
>
> --
>
> eth: mpnic: count packets, bytes, and drops per ring
>
> This commit adds packet, byte, drop and error counters to each Tx work,
> Tx completion and Rx completion ring in the mpnic driver. The counters ar=
e
> reported through ndo_get_stats64. An RCU-protected base snapshot holds th=
e
> totals folded in from rings that have been torn down.
>
>> diff --git a/drivers/net/ethernet/meta/mpnic/mpnic_txrx.c b/drivers/net/=
ethernet/meta/mpnic/mpnic_txrx.c
>> index 5495e9a9aa651..d5185e64f804c 100644
>> --- a/drivers/net/ethernet/meta/mpnic/mpnic_txrx.c
>> +++ b/drivers/net/ethernet/meta/mpnic/mpnic_txrx.c
>
> [ ... ]
>
>> @@ -594,13 +612,20 @@ static int mpnic_clean_rcq(struct mpnic_napi_vecto=
r *nv,
>> =20
>>  			if (likely(!(rcd &
>>  				     MPNIC_RCD_META_UNCORRECTABLE_ERR_MASK) &&
>> -				   !state->pkt.add_frag_failed))
>> +				   !state->pkt.add_frag_failed)) {
>> +				bytes +=3D xdp_get_buff_len(&state->pkt.buff);
>>  				skb =3D xdp_build_skb_from_buff(&state->pkt.buff);
>> +			}
>> =20
>> -			if (likely(skb))
>> +			if (likely(skb)) {
>>  				napi_gro_receive(&nv->napi, skb);
>> -			else
>> +			} else {
>>  				mpnic_put_pkt_buff(&state->pkt, true);
>> +				if (rcd & MPNIC_RCD_META_UNCORRECTABLE_ERR_MASK)
>> +					errors++;
>> +				else
>> +					dropped++;
>> +			}
>> =20
>>  			state->pkt.buff.data_hard_start =3D NULL;
>>  			packets++;
>
> [Severity: Medium]
> Is rx_bytes undercounted for frames that are dropped because
> state->pkt.add_frag_failed is set?
>
> mpnic_add_rx_frag() sets add_frag_failed when xdp_buff_add_frag() fails.
> That happens once nr_frags reaches MAX_SKB_FRAGS and the fragment cannot
> be coalesced:
>
> mpnic_add_rx_frag() {
>     ...
> 	if (!xdp_buff_add_frag(buff, page_to_netmem(page), pg_off, len,
> 			       truesz)) {
> 		state->payld.pagecnt_bias++;
> 		state->pkt.add_frag_failed =3D true;
> 	}
> }
>
> For such a frame the guarded branch above is skipped, so nothing is added
> to bytes. skb stays NULL and the uncorrectable error bit is clear, so
> dropped++ runs. packets++ runs unconditionally.
>
> The frame is then counted in rcq.packets through packets - errors, but it
> adds nothing to rcq.bytes:
>
>> @@ -619,6 +644,13 @@ static int mpnic_clean_rcq(struct mpnic_napi_vector=
 *nv,
>> =20
>>  	rcq->head =3D head;
>> =20
>> +	u64_stats_update_begin(&rcq->stats.syncp);
>> +	u64_stats_add(&rcq->stats.rcq.packets, packets - errors);
>> +	u64_stats_add(&rcq->stats.rcq.bytes, bytes);
>> +	u64_stats_add(&rcq->stats.rcq.dropped, dropped);
>> +	u64_stats_add(&rcq->stats.rcq.errors, errors);
>> +	u64_stats_update_end(&rcq->stats.syncp);
>
> mpnic_get_stats64() and mpnic_stats_fold_rings() report these values as
> rx_packets and rx_bytes. The rtnl_link_stats64 kernel-doc says rx_packets
> includes packets dropped by the driver, and that rx_bytes corresponds to
> rx_packets.
>
> The v2 changelog says:
>
>   - count Rx frames dropped by the driver in rx_packets and rx_bytes
>
> That seems true only for the xdp_build_skb_from_buff() failure path.
>
> The same counters are used by mpnic_get_queue_stats_rx(), which is added
> later in this series in "eth: mpnic: report per-queue stats". The code
> looks the same at the end of the series, apart from the new alloc_failed
> counter.
>
> Moving the bytes +=3D line out of the guarded branch might not be enough =
by
> itself. __xdp_buff_add_frag() returns before it adds the rejected
> fragment to xdp_frags_size:
>
> 	} else if (unlikely(nr_frags =3D=3D MAX_SKB_FRAGS)) {
> 		return false;
> 	} else {
> 	...
> 	sinfo->xdp_frags_size +=3D size;
>
> Would it work to track the lengths reported by the descriptors separately
> here? If not, should the changelog be reworded?

This is intentional. Summing the bytes of dropped parts of the payload
and using that to adjust the rx byte count is a large change that I
don't think is worth it, given that with our supported MTU size each skb
should have a max of 4 frags.
