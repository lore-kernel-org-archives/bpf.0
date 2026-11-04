Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793811144;
	b=j4VPv1biSY42rIDYrfeDqN9js5yizufB0mGBpFUIbqPWddBGrUR/O4RMbTeGG+HrmrL7
	 O7a5jV5FpicDjXwi/fVJc0zMOmYBQfZO87x7Kh5o9vjbjG1ED1cfu7EhJqjKAH8JLnREw
	 Vtgg1HjeH6WyQ4Iu/gHxseeb2hDzholRKVJJCWB0Wjid0kMrva5563qhFNa1ILmpM48AM
	 nUTpehxHZckUfwOQayxvweJZxY79gc3pwOdcFMfAyAgPnHRUDkecpYxny4xS7foWj1gFi
	 E/tQf2VWpW8LFYqHWWEta0FHi3/URJfDDt3L+Pqe4IWPnDgrN5UnFS0gvldMTPnXSdw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793811144;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Mime-Version:
	 Content-Transfer-Encoding:Content-Type:Date:Message-Id:Cc:Subject:
	 From:To:X-Mailer:References:In-Reply-To;
	bh=mDQelrr4Kh/Jq4lqD8Bd1ygw8a8v5DRiulkfJQImUaA=;
	b=SwAr3elqSw7OxwT0WejGub80w74i7yDN3DLMdFEBxloTb+fT+Gysjfab+vjgFeo5qypR
	 IxIHlECiaDu2T1B3bek9WMsspcncB0GAkiOiMnbGiY5sNxw23HLHNzw+FW75ZFKhSlwEf
	 lZyvhmkU+phBdKqG6GQXTxXr4XIW0hCMJ9+IQ6aWtXBW6esSd7yBOVHoX/PXteT+VecmN
	 +3GpEyUF7sW/GJlZbzboy+NsyQdmbw4/Ppgvuq2Sm3eCEsQBAvatwIOp6/lhEc43zhMmB
	 frtiEzLmEk30860yCJnp4IHiIE94O6QeHz/o314WC6GaINeOn8wqmvPhFdix1lcXlTg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kvAlMHA9;
	arc=none smtp.remote-ip=209.85.216.49
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E895606D81E
	for <bpf@vger.kernel.org>; Wed,  4 Nov 2026 16:52:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5E895606D81E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kvAlMHA9
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-3ada8bc2380so499515a91.3
        for <bpf@vger.kernel.org>; Wed, 04 Nov 2026 08:52:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793811144; x=1794415944; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=mDQelrr4Kh/Jq4lqD8Bd1ygw8a8v5DRiulkfJQImUaA=;
        b=kvAlMHA9YpLVp95q/S6+rfIKB0rxBFrfLZZgcxl9tkXcKRkQztUBTwOrAwv1bYnEZh
         qDB1aza7sd7sCkFjHBgbTr5ONi7xasnnWnCMi3ZChAbqAIz43AtJgQH3k5eE7vHhu81s
         a/gxOxiNC2yAXPRow31/dN3IIgNd3T99tw940mkHjn4kRm7FfmfUBHFenV0rEbEQyWQL
         FhiKhaB64QHMEzInvtZs2J9qRFs2LQzbdCgHc3iKCCKThQI3QIo4EmxmOra02M2gpiiQ
         rfTN9Xgt5EltN0laDIAcJhL3bE61iNfw35jRRqPFxcu2WlCzSTaKzJ7BnZOYk1NW8jyC
         2NYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793811144; x=1794415944;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mDQelrr4Kh/Jq4lqD8Bd1ygw8a8v5DRiulkfJQImUaA=;
        b=hSQXwbwRBk4C1tizfl1ltwaLEOvrG6kLUevYVdyZxW+Aamtlajmg3LzW5xxO1hP7er
         oB1qV5YV/3x46HCl9GyGrJQ3h/f5uZuWx69vc0Z1YJqEcBcqfEqmpW59wTFlhVqcOi1r
         Sl+zqZgh8q1fBUbU0pVaak7cUdqNniDUr/GpoCWtXBBw6lusIHa10dMklSuqKdeUamtF
         iI9/3ZUuZoIXbXV8+jqrdOf1PVzXdei0YIq6ebkW4ejD3IbEa32Wogtk+XdeUNZ6OsKL
         4f10yqLXzRedLxKLr7lBukR1GM1KQn+XjGVqbekbyxYxAiG+T9MPiNTwnZVhruyKpcw+
         +kIw==
X-Gm-Message-State: APuU4Z/L+rfAGkH2mxwYYqpAS4Sqsgj9oNBE7PuPyT+BO0sik8+YSvnL
	mRPlzUZO2nO5lUAyVVF5jx55jwNN+f2M4yR7G92WZ+r/MaILDaSLPbtbS3me9Q==
X-Gm-Gg: AYBFou25Hc8GTSAtkc7wvTG03KbJzcIpHMGfzKxAhBc/KBTgTmTtSsYbGt3/O0Vd7C5
	l8/59O9FfLPvDDXmHwIi30WM1t13UjJxCz+WE5jhQY8uqVRp/ZtrNkLcl+aNZCy7WMbB9yHJBen
	9HSklPQ067jVTqhszZ1itiCsLAF+zJ5r69kNYojcbm/Tu/IL7pJZ2kgWD414gM1uuGkZjSvhKI5
	Q88huN8CYxMPb9rAgAA3g2hoH2MLTuX361Fhn/+1qmU4x06W0zuOLjoQ0NuC2SJsmEk3sW4Du6a
	yf8d+8JXjIDMDghR5iPk2sqFnEX1sC1QwXO/t2chTQCaZ7oCHycWpB/gzQo1DyJrmn54/jj85nM
	RwJeDhSqs8UHQTVQon8IZ1t3VB6K5SwkXFrgRFhxLo71WWcECJ4+ukkoulGink3i9vu0yZODOXf
	uMemEfQ0NsaA4daob8ZspvupLON6RjcpziRsxESqn5/HBhcwR7/Or9C5qMmzEpe4GRNQvP66CPW
	t3ZPDFHeF6jmHVaReAF6Gu9FBKTNH/3DoI6FJECj0q0MD8sHo34MtBOL5Hxa+HwB8riMGE6gCnz
	ld+VcunHW7pbTB2059YHybMn/j6imgEcfuZtyIQOk7RXH/GdFLXPcEjRJM8qC+kvh/9Xnh/ek/s
	NlNX/fqJ6P4IVWMaLMvWNBPLnNaOqTzs8uA==
X-Received: by 2002:a17:90a:fc4d:b0:3b0:ac2c:1619 with SMTP id 98e67ed59e1d1-3b0ac2c19c0mr685175a91.39.1793811143452;
        Wed, 04 Nov 2026 08:52:23 -0800 (PST)
Received: from localhost ([153.61.198.252])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b09445a7f6sm4685568a91.6.2026.11.04.08.52.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Nov 2026 08:52:22 -0800 (PST)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 04 Nov 2026 16:52:22 +0000
Message-Id: <DMMKZAEHX53I.49LHFPRSGLX4@gmail.com>
Cc: <bpf@vger.kernel.org>, "network dev" <netdev@vger.kernel.org>
Subject: Re: [PATCH net] net: reject a negative TCP header offset in
 qdisc_pkt_len_segs_init()
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Paolo Abeni" <pabeni@redhat.com>, <sashiko-reviews@lists.linux.dev>
X-Mailer: aerc 0.20.1-355-gf870624f6c37
References: <20261101194433.2637113-1-alexei.starovoitov@gmail.com>
 <sashiko-outbox-194018@kernel.org> <DML39PMNWP8Q.7K2P5T3AG8LP@gmail.com>
 <f029172d-855b-4e93-8a86-d4aff72c9abb@redhat.com>
In-Reply-To: <f029172d-855b-4e93-8a86-d4aff72c9abb@redhat.com>

On Wed Nov 4, 2026 at 8:41 AM UTC, Paolo Abeni wrote:
> On 11/2/26 23:46, Alexei Starovoitov wrote:
>> On Mon, Nov 02, 2026 at 11:44 AM sashiko-bot@kernel.org <sashiko-bot@ker=
nel.org> wrote:
>>>> +		/* A header in front of skb->data gives a negative offset. */
>>>> +		if ((int)hdr_len < 0 ||
>>>> +		    !pskb_may_pull(skb, hdr_len + sizeof(struct tcphdr)))
>>>>   			return SKB_DROP_REASON_SKB_BAD_GSO;
>>>
>>> [Severity: High]
>>> Should the (int)hdr_len < 0 check be placed immediately after hdr_len i=
s
>>> computed rather than only inside the SKB_GSO_TCPV4 | SKB_GSO_TCPV6 bran=
ch?
>>=20
>> No. It's already explained in the commit log.
>>=20
>>> When (int)hdr_len < -8, hdr_len + sizeof(struct udphdr) wraps to an
>>> unsigned int in [0x80000008, 0xffffffff] (> INT_MAX), which triggers
>>> DEBUG_NET_WARN_ON_ONCE(len > INT_MAX) in
>>> include/linux/skbuff.h:pskb_may_pull_reason() before returning
>>> SKB_DROP_REASON_SKB_BAD_GSO.
>>=20
>> Not a bug. That's CONFIG_DEBUG_NET only and the warn is right:
>> the header is stale.
>>=20
>>> Can this write uh->len (and uh->check in bnxt_sw_udp_gso_xmit() and
>>> enetc_tso_hdr_csum()) before the start of the header buffer when
>>> skb_transport_offset(skb) < -4?
>>=20
>> No. The driver doesn't see this offset.
>>=20
>>> Third, for other GSO types (such as SKB_GSO_FRAGLIST, SKB_GSO_UDP,
>>> SKB_GSO_SCTP, or SKB_GSO_ESP), hdr_len remains 2^32 - |offset| at the e=
nd
>>> of qdisc_pkt_len_segs_init():
>>>
>>> When (gso_segs - 1) * |offset| > skb->len, can qdisc_skb_cb(skb)->pkt_l=
en
>>> underflow in 32-bit unsigned arithmetic to ~4.29 GiB (exceeding
>>> QDISC_PKT_LEN_MAX), causing deficit-based schedulers such as drr_dequeu=
e()
>>> and ets_dequeue() to spin in their deficit-refill loops?
>>=20
>> No.
>
> FTR the nipa sashiko instance dismissed the above concerns autonomously:
>
> https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261101194433.263711=
3-1-alexei.starovoitov@gmail.com
>
> you can reasonably safely refer only to such instance when submitting
> patches to net/net-next.

Nice. I'll borrow your mechanism.

