Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793659621;
	b=U6oJF29qduKNNwkaxGAZsBAmI9FQpFjU4P/IgxOQDScdpk2p2bQYOAOrz5uMeNs9Zk3W
	 YpcxRj0lHyT4g/7dC2vpTlULTrjLgBf7u2KiWll24dfrYUk7msB+bPMphck3p07HzzprB
	 celcEvhZpOEPfj27LPviaPFLCQZORJPvI2GV9a9l7iVJ1o42pjlOGK1R1LmgBUMxrF2+o
	 8GK0Y9/WljsDVxKH/mcjg+8Oh+4/2sqS3z5cFVk4FQu1h1HSrWwzqoO80X1elGpmuIvtL
	 cMsBOl2nQG3aFuYE2o7tu713AnrnfRuOtZxjvJbUvMBkbwpikS4rb85jXHSLj26HZig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793659621;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Content-Type:Date:
	 Message-Id:Cc:Subject:From:To:In-Reply-To:References:
	 Content-Transfer-Encoding:MIME-Version;
	bh=vXkfhgcH6rL/dKIELLPsFfXbm/yMJGywtKtor6k+GYY=;
	b=X+kXGdzH01kscQc/Z/xSgLmgxuXaAlY8eIXMFRKv/KOAmNrPi2tWgBPLpIGAgV0MDuKW
	 mxcYLa7MdoBxMlN2unNaHdgfCLNEJxeKNegwbO0gdY0hPrB91Zvjzu9tPnifc0y5rd3tq
	 AMSNRF4w8/uYn0FbEucOwNU00TVA9pHlyHL5biwCA27gmY8HcgLXUHrLsb2nYIuKesrkM
	 U78C5Oa01sn06QVJv4UmisDPk7jlqN28ckVZpTQJEpR9XQAqC/3Cg+j3kr2KqzENVzM89
	 +XI3Yc0FIzVYVu9kTGo/bso6031FWCV9GQuw43+URjRqRicGpHfLKWCI0kYd092yAJw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=z+MbB4xi;
	arc=none smtp.remote-ip=209.85.216.51
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32DFD606A327
	for <bpf@vger.kernel.org>; Mon,  2 Nov 2026 22:47:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 32DFD606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=z+MbB4xi
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-3ad2b3b1c02so1895932a91.1
        for <bpf@vger.kernel.org>; Mon, 02 Nov 2026 14:47:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793659620; x=1794264420; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=vXkfhgcH6rL/dKIELLPsFfXbm/yMJGywtKtor6k+GYY=;
        b=z+MbB4xi3xkJ3ve8hOeP7OMN9bucgGpLOFhoPFfVeQe0jAvg9UUM6sifEU6892jqBa
         cO+xR5cCTbayMIpotvPVvNp+kRnbf1Nu70+Kyz/HSVeHNxWhQIK+TZiVkgUBR2Ti4BX+
         9SvrCoz7yTYiSB1NwCWi6yE6neuWRf5ZmOCu2euKxPIKZ+wwL/D9e1eJRH7GdQyyLpe5
         tK/hINW2Cwb7+kZBrVDsQXvmlRyfbGlQjio9f9cWMHDN21cBNdl/24Wc+4DZnEQtNEaY
         A2a/esaQEVjxzBmj5iJUivzAiYyF7uyiLo5XWCN4j5ADUCS0EPOhcmpt7jCRozKUVYvc
         3DEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793659620; x=1794264420;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vXkfhgcH6rL/dKIELLPsFfXbm/yMJGywtKtor6k+GYY=;
        b=QNhgl/drCNmUCifERhC3LO6t5wbx5NGNyKOSJPJRdlAxEvDhm9W6VAHCVxNdlzVwr8
         OiFd7tL8rIm2tAPKsdMBHW+VA7kdcCI3tFYAv1uWwkpkGSmoPGTW7RU60JwUY+cyMgmU
         rLv+BCdg4r0XHB+n1gc24DunZ0gKUwmCzJSS3kqRbToJp9RMnwv4FDWZ5pli5F1OTcYO
         Zga9AcysU0Ki/ZKuwdMxFvZi674oViwbUTr35roq2FtHbsV1JmqsgFVqNSYYhpHS7qg1
         TMRCY7HcD3RxG6xcp4a1h79/oL7X9JK0GJm73L44FyMXETmv/2WfiaVbZ/iXn8sD6Zrs
         IoQg==
X-Gm-Message-State: APuU4Z+j1pW47XtXQa1kCNkK3EnglgVs74jbWzCHKG2I4xT30Cw1VFRd
	wgBIUxdytL5nE4EKSYU6WfP4wOJ71rM595Fm8SaAzP8lrkr5QoildUI7
X-Gm-Gg: AYBFou2cUqJNMTMzHvGoz4kcq4ZLKK9KLMWi5l6Q8rUn7pwAKHZGoWOHOHDSfkapYB8
	+avziaIoUCkqUoHSoDK3Q6RPrJ2wvQENPYzwGIuujqfKUa4h3N3Rx7FztvUQkn8uMqcGHholslX
	VmYra+knjeKyPOnzmm1O1y/65R9O+LsnOHhkY0cjsaDxB+wFp09e0Mf1e3gV6+El/OUXJVn/Xzf
	rpHi+u1FXeCHZGSW4q4AgPpex8AXm0m8jJiY23hkjEpdZ2D7Zdp4tkzAYWBYwRE9VUhHiViILLb
	nJu+l/fcpfpb2nkvfYuL2BLCMSfxbYVTAvMa7mXGgcCM46cGNja2T/qJFIwxvyC7r7pXG5fKy5T
	ubOsGRA26pqB8lPegaj9LTGwdje2jE2ZHC+KzmRuxtYN5bvVltNH1lNj6xAqLlJNZsWhOrGtC7m
	9Nh9bm+ttjjatoPoF/TFo5obGhbuxLtaxiy1BRvAMCPd9FDyB2pVXdisG5NCGZ7Jxux9H6lqjDy
	fG2B7U3LM0REZnn+mpYCnelAQUJZw52Dap/tm43aswmDOvhkMbHQa/j/9u2kYNwzGGZJzaEkfyO
	iEqFjKgy/qX+nK3CNLQAynWHd5xBcHTtfwCD/z6oVXLoc9SQ92zawb+Nf4Pa17sq2OI5Pk/Wo1T
	NIKq8faD7hE+jcOfXGQDOqkWULNrpSjDk1Q==
X-Received: by 2002:a17:90b:28c7:b0:3ac:83c1:2bd with SMTP id 98e67ed59e1d1-3ae897f33cemr8956221a91.28.1793659620222;
        Mon, 02 Nov 2026 14:47:00 -0800 (PST)
Received: from localhost ([153.61.198.247])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae8805ebc8sm9308679a91.3.2026.11.02.14.46.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Nov 2026 14:46:59 -0800 (PST)
Content-Type: text/plain; charset=UTF-8
Date: Mon, 02 Nov 2026 22:46:59 +0000
Message-Id: <DML39PMNWP8Q.7K2P5T3AG8LP@gmail.com>
Cc: <bpf@vger.kernel.org>
Subject: Re: [PATCH net] net: reject a negative TCP header offset in
 qdisc_pkt_len_segs_init()
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: <sashiko-reviews@lists.linux.dev>
In-Reply-To: <sashiko-outbox-194018@kernel.org>
References: <20261101194433.2637113-1-alexei.starovoitov@gmail.com> <sashiko-outbox-194018@kernel.org>
Content-Transfer-Encoding: 8bit
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Mon, Nov 02, 2026 at 11:44 AM sashiko-bot@kernel.org <sashiko-bot@kernel.org> wrote:
>> +		/* A header in front of skb->data gives a negative offset. */
>> +		if ((int)hdr_len < 0 ||
>> +		    !pskb_may_pull(skb, hdr_len + sizeof(struct tcphdr)))
>>  			return SKB_DROP_REASON_SKB_BAD_GSO;
>
> [Severity: High]
> Should the (int)hdr_len < 0 check be placed immediately after hdr_len is
> computed rather than only inside the SKB_GSO_TCPV4 | SKB_GSO_TCPV6 branch?

No. It's already explained in the commit log.

> When (int)hdr_len < -8, hdr_len + sizeof(struct udphdr) wraps to an
> unsigned int in [0x80000008, 0xffffffff] (> INT_MAX), which triggers
> DEBUG_NET_WARN_ON_ONCE(len > INT_MAX) in
> include/linux/skbuff.h:pskb_may_pull_reason() before returning
> SKB_DROP_REASON_SKB_BAD_GSO.

Not a bug. That's CONFIG_DEBUG_NET only and the warn is right:
the header is stale.

> Can this write uh->len (and uh->check in bnxt_sw_udp_gso_xmit() and
> enetc_tso_hdr_csum()) before the start of the header buffer when
> skb_transport_offset(skb) < -4?

No. The driver doesn't see this offset.

> Third, for other GSO types (such as SKB_GSO_FRAGLIST, SKB_GSO_UDP,
> SKB_GSO_SCTP, or SKB_GSO_ESP), hdr_len remains 2^32 - |offset| at the end
> of qdisc_pkt_len_segs_init():
>
> When (gso_segs - 1) * |offset| > skb->len, can qdisc_skb_cb(skb)->pkt_len
> underflow in 32-bit unsigned arithmetic to ~4.29 GiB (exceeding
> QDISC_PKT_LEN_MAX), causing deficit-based schedulers such as drr_dequeue()
> and ets_dequeue() to spin in their deficit-refill loops?

No.
