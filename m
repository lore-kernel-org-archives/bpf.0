Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.229.6
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793643910;
	b=zJRHFWTWNWbgzzALVWsgglA000v1UJL+FHgSmqebsz35pQ7iMMJx6YYgIWEnr4K2pGMx
	 JHNE4b7rKiWaOpUKimcwqP718t279AoDrksbmUZRJf7nBa9CosisENzg3bjVbykOLA1bU
	 XHgcoopali74A9ioUiTthYPcaudMyLORPV/Ckea5R32Uq5MWNxp7ynhroByN9AcSljKJg
	 4dx+YiD4cNRm0EsewX9ghnWcpdvFZcaY8ApNd1nDFUYZB9+6IlOaSo/ppd6jA6x2hor8h
	 tQ8aiHPf//R9PVvRuzOwRl5GV09tIW3XDkNpOLwuDCm5GJOBoEwkAbmRF64nkp4X6xA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793643910;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=Z41mKtHOm7Mi5CS6B12EWoUXhaoVqMrutmZJokfP2gM=;
	b=bwyEWS5OJYFdp/ta/iYxVhKDXudYrYg0HG1DjljGO9NAxCYCXdiXl2lanqBPRU2nWnmi
	 VplJ4Ilv4SWqU87UOKt6EHLmBsaClJ2o4YdNCmxFOAMippmqZbNDiFfGjs+pZd9IWDBGu
	 /cXE0V05DpdnWcLXF6/chzp4Bco5KFOKalCPBZfgvZGSFmmWeqd7QgDoM4c/hhaZfU3XL
	 Rz8ch4PwZpS3pf6puJUPftHQcHUvhiY5oVxhA5QcYnRO1ZWGWYtlrhhWYploqdztpAQfQ
	 KH5x2GOer4lFFT65qNbjlAYcEX92DIMvP/Bw4ixIj1OQ7005IjUpo8vQKCe7bmGFClA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wRJX0RF8;
	arc=none smtp.remote-ip=74.125.229.6
Received: from mail-dy2-f6.google.com (mail-dy2-f6.google.com [74.125.229.6])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 697CC606A329
	for <bpf@vger.kernel.org>; Mon,  2 Nov 2026 18:25:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 697CC606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wRJX0RF8
Received: by mail-dy2-f6.google.com with SMTP id 5a478bee46e88-3537f63c9e6so1350488eec.1
        for <bpf@vger.kernel.org>; Mon, 02 Nov 2026 10:25:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793643909; x=1794248709; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Z41mKtHOm7Mi5CS6B12EWoUXhaoVqMrutmZJokfP2gM=;
        b=wRJX0RF8HzOJ5vHpbUCAKfZVjV3IC026OA9dQPQiz8FmPUdyqsaFHt8LcpZ43ExlRJ
         V131kcsJQSQmh60QT+FT7u391++5YsW/YO1DbR+WV8QL6E8eYBo3gGcPwCrAgWVG5rBl
         xPlLnxQ9m5+fvTxjr/g4bwZc0JGUnpU3natXbNrqN3XDX/Q6L7zzd4F6iGzyKrsPQItj
         Xqx1Ed0Gcr6oSkwDipSu2F2AE2yVj9CdZEI/GzDD2emXcMnfxaEAOEUnQ52JLAyxCcTe
         vMadz6FaT/RD/UTS6WJ220Qt5fRzD49ZSypC9hgqQxdy3e/lboRbOgyp1bUDlnQ3/dgj
         PATA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793643909; x=1794248709;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Z41mKtHOm7Mi5CS6B12EWoUXhaoVqMrutmZJokfP2gM=;
        b=cs9n6lag0GSYldn9LeiiwczbtN8UGyN7wtpRmchLyFEbUCHA9tQAVO1xH6J+j2eR8h
         8Z1qXFTHzL8TAkMmEFxlOkP7YOwpXdC01ce2TJDYK3XF3nP48VGfokQlt1K6WHbFZIsM
         q4djaRrNKjA+hl6OqRjdaXbwQdDy4862VyzPC5K1NnNcIPYMf+EiEZ+T2cmYkinNOO18
         cd+uacQ7rNRZ7BNVuDy0bGIGfmtlZh2Yapw23e7XA0KqI0OVqXT4VTUezh9ZjTtxPZm2
         sxXuUV/jlNioKL9Htb9Vq+jITTK7Qrps6Sb0jeULIB0uA5LsrcIIEId02rcQS9fq3x8P
         Bw/Q==
X-Forwarded-Encrypted: i=1; AKwUvBx/pD6Nsd4zxWFgSQ3WaMpEQMZh2WLwv7Mdxt6g5hGO9AWA3Zgrr6NFokA28mAp7lB1Kf8=@vger.kernel.org
X-Gm-Message-State: AFq9FYL5gUmkHYFH7SeW4NeKPLkcoa2etPvux+H391ygGDYhqkBJnJXk
	pXY6MTNAeZNZGH1KP2XsjRb4L2YDeLKHmqkW5n+VTfrt1NIYzYxTZa4p
X-Gm-Gg: AYBFou1Puf9ZCY5tfdgXhgBQNAVhOwCRzFCWEZEnHiyUExjD6WfdXdMKeLFOfRBpVBy
	ZHeNtiWbPCN7RI/W9BN/OX9zTKAC6JKv8iINkqIs19tgW0s7ij10ShVS8OHj4+0EmMRw0nlYK/u
	YxQXltWyFIBAz0CqDKfpDK7fPYpA8JQ+xH9tI+JNJ9HGAt9i7Ta+vJd5G/zGv2MVkL6jlJr91qD
	6lEH8iT3ksuLuRHG6qUM89wDacqYioYuIX5qvfY4vRFmVcThNAFmSuGuVOHsnn7GMHy3YgYkYDO
	U+04QCI9MvGkTrDK1DdOlXsu37cxSnuPEQ16eGl8o99gJsu2a9TUoiBN1tQ2jZ7uFTh1OX8lsJ7
	2QqWoBLjqxPa5WD0GHG8A17uxI9z8R1gRbO1EXc4luqrtlO7ENYWdXwpvrCD0SmpOeKiDa0fpuM
	HFKzLiSwetI51Yy+og8sTrncvpY9UNTvR0qgR/bBGJ3tAc2cxpC0On/dx8CWVU8KTzwBnRsmOnz
	WKGGQKs6nkTi6OJA+XpxTPMvw13TT09mEAGU2wY1XMF1Gi69bRRFrT4ZJnhi7eBteh6sZeLQEPT
	1VBcnR7jSGOkCh2+te4Kgzo=
X-Received: by 2002:a05:7022:ef12:b0:14d:ef19:246f with SMTP id a92af1059eb24-1ac5f36d5cbmr18049891c88.45.1793643909092;
        Mon, 02 Nov 2026 10:25:09 -0800 (PST)
Received: from localhost ([2a03:2880:9ff:42::])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1ac1854da78sm46557054c88.6.2026.11.02.10.25.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 10:25:08 -0800 (PST)
Date: Mon, 2 Nov 2026 10:25:04 -0800
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Rongzheng Wang <testwrzwrz@gmail.com>
Cc: netdev@vger.kernel.org, 
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>, Magnus Karlsson <magnus.karlsson@intel.com>, 
	Jason Xing <kerneljasonxing@gmail.com>, Jesper Dangaard Brouer <hawk@kernel.org>, stable@vger.kernel.org, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v4 2/2] selftests/bpf: cover AF_XDP multi-buffer TX
 software checksum
Message-ID: <aujU8-MBZ9LrhFMd@devvm16445.scu0.facebook.com>
References: <20261030023248.78802-1-testwrzwrz@gmail.com>
 <20261030023248.78802-3-testwrzwrz@gmail.com>
 <auT51NbSPvKJwgiD@devvm16445.scu0.facebook.com>
 <20261031013143.42509-1-testwrzwrz@gmail.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261031013143.42509-1-testwrzwrz@gmail.com>

On 10/31, Rongzheng Wang wrote:
> > Any reason you're not reading the real value from
> > /proc/sys/net/core/max_skb_frags ?
> 
> The test wants to exercise the maximum supported number of frames, but also
> needs to run on every build. CONFIG_MAX_SKB_FRAGS ranges from 17 to 45, so
> using the minimum (17, i.e. 18 frames) gives the largest bound that works
> everywhere. af_xdp.rst documents the same limit:
> 
>   "For copy mode, the maximum supported number of frames in a packet is
>    equal to CONFIG_MAX_SKB_FRAGS + 1."
> 
> xsk checks MAX_SKB_FRAGS directly (net/xdp/xsk.c), not
> net.core.max_skb_frags. I also set net.core.max_skb_frags=4 and ran
> xdp_metadata; it still passes, which confirms xsk does not consume that
> sysctl. Reading it in this test would not tell us the xsk limit, and would
> only reduce coverage if it is lowered.
> 
> CONFIG_MAX_SKB_FRAGS is compile-time and has no userspace interface, so 18
> frames is the portable upper bound. That is why I used 17.

Sure, people can set max_skb_frags to < CONFIG_MAX_SKB_FRAGS, but I
don't think we are gonna do it on our runners. So for the purpose of
this test we can essentially assume CONFIG_MAX_SKB_FRAGS ==
max_skb_frags.

I'm just trying to understand whether on the builds that have
CONFIG_MAX_SKB_FRAGS > 17 we want to exercise all CONFIG_MAX_SKB_FRAGS
or we are ok wit just 17.. But we probably aren't going to bump
CONFIG_MAX_SKB_FRAGS on upstream kernels anytime soon..

Acked-by: Stanislav Fomichev <sdf@fomichev.me>
