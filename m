Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82ADA48AE36
	for <bpf@vger.kernel.org>; Mon, 12 Oct 2026 11:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791805700; cv=none; b=RyP2SXk4KqhuS0f1nOWcWx0uB7cxG9+KhBjwnYPCctNgkQvGr+m8TzLUWE9fD3g5UNOouSP7NhYmWSD2IVc6SU1FFkU9gWOd+lEK511P4KKnPW/awHC1fBs6gzbQf29NNooQFH2D1eKhVY8jLqmaCy9lEZH5zZHcjJGuuliUWMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791805700; c=relaxed/simple;
	bh=0oxDBpOhzf70gCV6Rcb98poq3pdLezeW/LliRDDx8QM=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=EB6mmEGGg+GCaZqgBJhp6QUYbzuFBzmY5iWYy1ictoMJpTCCDXcJOxfm3XqzwKNxYO3Mw/pKDkRVnCTPhyUlcTaJIE5H1IWfScpjpA/AQ97NwwY2DEvPXQWI7ZhEq2QTDDhbI7DlewH3OFy6uPDiN8EJNHsu0DhCQjWuy1LNMLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m1/0/QC8; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m1/0/QC8"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-5339199d8c3so18973911cf.0
        for <bpf@vger.kernel.org>; Mon, 12 Oct 2026 04:48:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791805696; x=1792410496; darn=vger.kernel.org;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Me7p/ggVeagEeCEw7m+G/8lxfOB/uR4E2Mzy17xQ+jU=;
        b=m1/0/QC8DpttAw8dnF6lwZAOsXEkBxPp1Ai1iIlPX8NMelLMJLNvI17/G4L5EzRZjV
         eBjk7wys/OuqfXl5WaAdcy3SrgIh4y2oFhDuoy4Bxq4MgeRIC30/SPVGV73dKwjGzY7M
         0O6VHXeu4RZW/C52RgJC92oM6L7lDgxFdhITnLvovOy7njJbgMg2IvgK4+bCBDW2PYfz
         LbrobViA8v79E+Dzno/gXhMzGsDtSPsD14IrY/nzDQJDjJqFT0tTXcemTDAxk64yRLp1
         CBY2q6ykxx53uZXWyWN+HLullWoX3NjH13OIZ5Z9DfjVqBOT6bNcxSySnTSkIrkptk9t
         oqoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791805696; x=1792410496;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Me7p/ggVeagEeCEw7m+G/8lxfOB/uR4E2Mzy17xQ+jU=;
        b=PmMwKa92gHQX+4dlHRZVZ92C6nquGMIYq1a80NZEAk7F2wjNthlHv0bKQC6Igy6vTJ
         KzYvIalSY1LcQzKVsf3LO9bjBng71Uy2Hb3ezBRvRVWY0XI/DzmyBIcW1wPpulC+7wdC
         0hrE4F80IcjXPf4+mQw2lsgF3RDs6OUfKOa5kaFmKRUbUOCW3hzECZ2v9ijOqEAvutqC
         jcg2gOKXBfPWRe9+m/xatIl/QOIjGmC5Ktn+Vo3R8umTVS4ndaNwk16pfe9h/xKAasKf
         yG4Jh8H6TbKdJR3hszfW3qroQS8O6+waoPLGszdX79TXJO8YDZ22JdSMowe2CmC5deuF
         TNtg==
X-Forwarded-Encrypted: i=1; AKwUvBzfL6KYZnSUYQ1s/srk5vVhQqlKGOP1bQfKeTgQFUHPgW6f0Pl2J8xbw7MY95oBmERLRSM=@vger.kernel.org
X-Gm-Message-State: AFq9FYKqC+dnjM7NLUmIkcev9bkJuPdnHxocfS3fwZgE/aZ3DimYvr3h
	P7Sa52W0S+raXCRnzzIQjz1MiFvEcc6Vb2stHWMnE8NW9dWnETYXl1DX
X-Gm-Gg: AYBFou25qvVDWx1ZnjwttjvinPHbo7b+EFR81NvSDTTyaSWmP9e0343OBRAC2dxqsw6
	aNC1tzq3JctZLgDZoE3pUjyoJBfhSLWejfqhPXQeWnyYWMf08oTXmUKyrlmcXJIJn+ulK/6WIu0
	nRoa+N3KQXzIoE5hYqTVz/5n33m45u0g5sUWHzQihdql6z4LFK84CfqkA50HI7aUrx32khZHPHM
	QvZvVJcq6R2S9S9YJ00xRCobwZN3zRh+oHrLiFWn3+Cb12F4XyHxaD11KgB8ytSh+7QBXMxe9zr
	sPkxrqwSdApAF1Fi47O9j0hPWox/42MEI80RyqhvQxMoyIGerpLutx/tEm8fFp7GS5Ajj4UvP/5
	LriyG7ri3mIyPM2/j6BIA56K2BmEMjLu6JUdIT5Jz+5lwkDCArq7vvwpLYPXZTlPHNFItRQ6y28
	OvNpXUArJAAv7WA07r+VOY5a9phLQY03mD2L0GpjRWw5hdTIUtAEULDbulAjp0+bXkv1IJCfadv
	lQ=
X-Received: by 2002:a05:622a:34a:b0:535:1fe8:1f6e with SMTP id d75a77b69052e-5359fac509cmr151798411cf.12.1791805696150;
        Mon, 12 Oct 2026 04:48:16 -0700 (PDT)
Received: from localhost ([2600:4040:9399:4000:e553:72e5:7d37:c7ef])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91b550de014sm93335216d6.44.2026.10.12.04.48.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Oct 2026 04:48:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 12 Oct 2026 07:48:13 -0400
Message-Id: <DM2U3VVRLFCT.27LGHISXCP8MM@gmail.com>
To: <netdev-bot+sashiko@kernel.org>, <daniel.zahka@gmail.com>
Cc: <alexanderduyck@fb.com>, <kuba@kernel.org>, <kernel-team@meta.com>,
 <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <pabeni@redhat.com>,
 <ast@kernel.org>, <daniel@iogearbox.net>, <hawk@kernel.org>,
 <john.fastabend@gmail.com>, <sdf@fomichev.me>, <edumazet@kernel.org>,
 <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <bpf@vger.kernel.org>
Subject: Re: [PATCH net-next 1/4] eth: mpnic: count packets, bytes, and
 drops per ring
From: "Daniel Zahka" <daniel.zahka@gmail.com>
X-Mailer: aerc 0.21.0-threadmapfix
References: <20261009-mpnic-counters3-v1-1-7dc7644cc500@gmail.com>
 <179163314562.434549.8676548639859788609@kernel.org>
In-Reply-To: <179163314562.434549.8676548639859788609@kernel.org>

On Sat Oct 10, 2026 at 7:52 AM EDT, netdev-bot+sashiko wrote:
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
> - [Medium] mpnic_clean_rcq()
>   (drivers/net/ethernet/meta/mpnic/mpnic_txrx.c) leaves good Rx frames=E2=
=80=A6
>
> --
>
> eth: mpnic: count packets, bytes, and drops per ring
>
> This commit adds packet, byte and drop counters to the Tx work, Tx
> completion and Rx completion rings, and reports them through
> ndo_get_stats64. Rx frames that the device flagged with an uncorrectable
> error count as errors, and any other Rx failure counts as a drop.
>
>> diff --git a/drivers/net/ethernet/meta/mpnic/mpnic_txrx.c b/drivers/net/=
ethernet/meta/mpnic/mpnic_txrx.c
>> index 5495e9a9aa651..4bf6404941158 100644
>> --- a/drivers/net/ethernet/meta/mpnic/mpnic_txrx.c
>> +++ b/drivers/net/ethernet/meta/mpnic/mpnic_txrx.c
>
> [ ... ]
>
>> @@ -591,16 +609,25 @@ static int mpnic_clean_rcq(struct mpnic_napi_vecto=
r *nv,
>>  			break;
>>  		case MPNIC_RCD_TYPE_META: {
>>  			struct sk_buff *skb =3D NULL;
>> +			u32 pkt_bytes =3D 0;
>> =20
>>  			if (likely(!(rcd &
>>  				     MPNIC_RCD_META_UNCORRECTABLE_ERR_MASK) &&
>> -				   !state->pkt.add_frag_failed))
>> +				   !state->pkt.add_frag_failed)) {
>> +				pkt_bytes =3D xdp_get_buff_len(&state->pkt.buff);
>>  				skb =3D xdp_build_skb_from_buff(&state->pkt.buff);
>> +			}
>> =20
>> -			if (likely(skb))
>> +			if (likely(skb)) {
>>  				napi_gro_receive(&nv->napi, skb);
>> -			else
>> +				bytes +=3D pkt_bytes;
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
> [ ... ]
>
>> @@ -619,6 +646,13 @@ static int mpnic_clean_rcq(struct mpnic_napi_vector=
 *nv,
>> =20
>>  	rcq->head =3D head;
>> =20
>> +	u64_stats_update_begin(&rcq->stats.syncp);
>> +	u64_stats_add(&rcq->stats.rcq.packets, packets - dropped - errors);
>> +	u64_stats_add(&rcq->stats.rcq.bytes, bytes);
>> +	u64_stats_add(&rcq->stats.rcq.dropped, dropped);
>> +	u64_stats_add(&rcq->stats.rcq.errors, errors);
>> +	u64_stats_update_end(&rcq->stats.syncp);
>> +
>
> [Severity: Medium]
> Should rx_packets and rx_bytes still count frames that the device
> reported as good but the driver then dropped?
>
> In the MPNIC_RCD_TYPE_META branch, two cases reach dropped++ while
> MPNIC_RCD_META_UNCORRECTABLE_ERR_MASK is clear:
>
>   - mpnic_add_rx_frag() set state->pkt.add_frag_failed
>   - xdp_build_skb_from_buff() returned NULL
>
> Subtracting dropped here takes those frames out of rcq.packets. Their
> bytes are lost as well, because bytes +=3D pkt_bytes only runs when an sk=
b
> was built. When xdp_build_skb_from_buff() fails, pkt_bytes has already
> been computed and is then thrown away.
>
> mpnic_get_stats64() and mpnic_aggregate_ring_rcq_counters() pass these
> values directly into rx_packets and rx_bytes. The rtnl_link_stats64
> kernel-doc in include/uapi/linux/if_link.h says:
>
>  * @rx_packets: Number of good packets received by the interface.
>  *   For hardware interfaces counts all good packets received from the de=
vice
>  *   by the host, including packets which host had to drop at various sta=
ges
>  *   of processing (even in the driver).
>  ...
>  * @rx_bytes: Number of good received bytes, corresponding to @rx_packets=
.
>
> Leaving out frames the hardware flagged as uncorrectable matches this,
> since they go to rx_errors. Good frames dropped for lack of resources go
> to rx_dropped, but by this text they should also be counted in
> rx_packets and rx_bytes.
>
> Could this subtract only errors from packets, and add pkt_bytes in the
> dropped case too?
>
> The later commits in the series ("eth: mpnic: report per-queue stats",
> "eth: mpnic: count Tx queue stops and wakes" and "eth: mpnic: count Rx
> allocation failures") keep both the packets - dropped - errors
> subtraction and the byte counting that only happens on success. So the
> problem is still there at the end of the series.

hmmm, I suppose that is technically correct. I wonder how many drivers
correctly handle skb allocation failures this way. I'll send a v2.

pw-bot: cr
