Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.174
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795378817;
	b=JCZ/OccpYSLfiI7Xko1EPHyP842lnxRuws6ZPiD/0pnxDJqPWkHJAhsRHT6RZlBpCiPm
	 P9geoVgPyot8wJkZB+gWxHGJkY977svA9fPWQxKN+cMq/kyx5DBDx4OF0ZsnsO2/xsVbH
	 fGnZ6ix/zJNzxBAU64mw6XnoZQWlr7XLpmomCwABTgYtrB5lZZnvPei/qswg4b20KG84K
	 doKjC/hYknl9YqOJc/KFe+RcAuHodeLFWRLav3cZldeReYWs0fe50WGAht8ZQgi+g+kwh
	 KkW1qjniGp1VoxMHV+uu8hEjp1ob4O4uZhwQe/pczs18UWDu4gO2rj5ccA3ATaZytuQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795378817;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=kC307rNk6+C1niL7I+z7w4CvnqbVu1GxCYbOm7Tl96M=;
	b=TaAuNWV0YnbygCcrs5qIYyuRNuZmdhYeR4ABS3SwDfqy24MX+bxuv5SgJOWpTL10HDoZ
	 uP1SX4dPQeBFDocb5ldQqa5K4Q6E+jo7wZdPJ+VmdkVolpqPbYjMxzRIkMEXUSorUnX90
	 uaQsuEBIyhSDKq4N1Vg5eeoOYWQu5emUbtrsS78z5d8E3Cjp7PEAc4yhNJux+NcQRLzc+
	 qw+wuDhcfjgKT//DSACY/S2fSzJ4XcGkkkZ+F6vPHXcRX1HiO8QHmmAKT8fVzAK68UdIJ
	 DwXQAFoqPN8jaDgH4OXu/WvDvcmUNgs+hVP+tlTZq/BhZyNDkFBEH5IrGBBoYZGr4tA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xsgrvLte;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.174
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B46D6606A31E
	for <bpf@vger.kernel.org>; Sun, 22 Nov 2026 20:20:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B46D6606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xsgrvLte
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2f048476ab9so17739455ad.0
        for <bpf@vger.kernel.org>; Sun, 22 Nov 2026 12:20:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795378816; cv=none;
        d=google.com; s=arc-20260327;
        b=sFuPa0r7TKk7eSrvoswJYD4WAvfeGlm4K46PTGjlviBhUAFyl/z76KvMVhgBC1GBCm
         ZbCMuVv5HUv+8g/3+FqBHhD/BW9Mpf2l/b7+IZdV/ElmY+fQP/AJscH9L+Uvy8K9R20j
         HL15+o2lrpC4g8g6ekredNOzWjfSJLcn+4xH24AQUgSfapuahAdjcxesmBe8CJQqg5Dy
         RC4XtKZ/up1QgQwkVnZP/StyFNxh9pOAV/MNlrxqLcvqr6iWACrXeUEj9ZFKjSgNACtM
         /2qj98ckXwyqE8aVWrpvmSigQ7qtfM4LhAQbOUVSsObQKsNKQr0fWj2MfwcdhyvxZrwt
         zdUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=kC307rNk6+C1niL7I+z7w4CvnqbVu1GxCYbOm7Tl96M=;
        fh=UjC9U0Efy8hxN3MsRMI9g6fVxVT9SHLP4fmnexm2g98=;
        b=YO/nylCvi9DjODhNnbbB4KKLmlExu8i+xYMs7cf0PlecRrL2JKDVbU+k0IsEj5vHFV
         u+uADsdv5qEDuOILMdQgrjedD8LtI2VGbuBK4zk/5yzXZNU33pDuJ9e/tFow4pw2AJjP
         HVPuIVLXc812mpZppYyAj2aYtFn6msk0LRDxfAjbpEy0mRD+xT82sCZgjSa7KxcnDdj/
         E1klQeXtPhP5z8RvOf4+Dn97Lkik+mx+4uBqAPSIpAkbVl6E6WWxDhUOUhw8KSEeOG+H
         LkuaY+HfMDNx/niofH3lQni4Lw4QE6OW4VkoWtBFvIqvVOBtBvrogxVA+nx6YMFXnH3u
         q6rQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795378816; x=1795983616; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=kC307rNk6+C1niL7I+z7w4CvnqbVu1GxCYbOm7Tl96M=;
        b=xsgrvLteeAUUvjJzZ5BZEvywpZJbedVUEn4pL+xUny4QNb2ce5CkYBrs49QaDiMDhn
         lwIwGhl2LPPKX5+lQ3nbRnhDsNAjDk2bGodR9NJDOkvu8qRxKS1mPeJBtkPEy//VRWCf
         vb8a0wNpJl+ez2af53JCGawfY0NgRPiGJAoT9kqVvHRlud29kDS6YiQCGoPOyo7pv9z3
         oxuOQWT/aKgqi5Hippc888/bWoTnlnIIs1WT9rcDTKmf2eVgfFyCgIKxtl0GnxRoZpUq
         Q3G5e+oTrsby+2XPOffYjbMpLiUD+TsfDgN6MTJppbgNx7JPgkGKELYH38RAXW0ZMvug
         mmXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795378816; x=1795983616;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kC307rNk6+C1niL7I+z7w4CvnqbVu1GxCYbOm7Tl96M=;
        b=1FuNaWl9Csilt4xhSyjfpDuec5hiuhggKg6aZN+aEjGhQY/sXpYIrGY24YFT6HzIeY
         8r7IuckJrLs9tJeRrAMB/TqAyJfOvqH7W831UFwN9JecHs4FnmPSSFmCDl1Sl+l8RYbZ
         ivlqagHIcvDItvFVal5smLxqkIpRaZQbbyi0EZviMgvfTFQ5LV8BlfmnDKExabKKFJLm
         2Qi2z4dwrWRNQ0v6ZLQ9/wC8C1gHcb9rM47AnKEhNKXVY+R1wY9CU9OPRx/nvxdnd+en
         B1BFLWrc6V22zgTHgan5t1x6C9YJZ18xxL+6u4jaxuBXpVjvx4T0ZuW16MHTcGiS5QZ3
         y32Q==
X-Forwarded-Encrypted: i=1; AL+hErF75L3QXKSG8Fwdi0/pfy/bIy3by0qb6XQdHFNxJEpCREPKxawCkQJQwrYFmDJ12LLdfZc=@vger.kernel.org
X-Gm-Message-State: APuU4Z8qLdgO0/uNm1SfOXQQinazAf/fmt6OGr5TFKIqy0ScbGO21rZ6
	gi0V2owvgfseBBewlH/ANNIp6+BYfbD2sa7pzNMay+3HiiHqB3p2OHQR/ST9QMKZuj78A6hzuuV
	2C5UThqZhV9VulFakfR1x70m89tcccMM=
X-Gm-Gg: AZFdTZfOji1rj+IrQYjTRoDo92bFVRE+JWcObqvfeAgkQ9SURC755srgI3lCXWalznO
	Reva64tEbauMm4ZdXGplO41+76fuQopwk3U9xAxN4Z3sVl/L5R+84B9RicV6hcmpGckStrPWNQG
	cxdM9kFyp7PeBaJ8CRJ7VFfHjm4NQxQKSn7mdg1bLCRuxURCWSUwordESex7BbUhzANIEISsO2G
	o9FLEi+M1MLnthMDvkn01RHgRWWadI6HPfIIwVRJmdowjabmMFyKVsjhK5MkKkQOsbtm2/H+mfa
	yuI0icvArCIo7yLdMutY74PFzTd2bVcbAMgAwGHyYKssAFD8VhkEPplqZtb5qrVnko3H91Wlc9U
	Q4hJ5KKxjTdQsTQ9s7hsFlKu0WWxtIdOdH/SOmrjmLdCFI2VM4QI6NkSCk9bWfIcqZSLe8fc=
X-Received: by 2002:a17:90b:442c:b0:3a8:9b79:e6ea with SMTP id
 98e67ed59e1d1-3b41cb235cbmr8580615a91.59.1795378815937; Sun, 22 Nov 2026
 12:20:15 -0800 (PST)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <MA0PR01MB921746F36D90C7080287ACC9FD782@MA0PR01MB9217.INDPRD01.PROD.OUTLOOK.COM>
 <9d8cdde77beedce76aaaa1c5a7a788dc@tipi-net.de>
In-Reply-To: <9d8cdde77beedce76aaaa1c5a7a788dc@tipi-net.de>
From: Sam Edwards <cfsworks@gmail.com>
Date: Sun, 22 Nov 2026 12:20:03 -0800
X-Gm-Features: Aa3M54o84M-uX2uQ_qZeHIKjUVqNqkyoSTJtgWDoyviNh_-BeSJ3m7iO-KDBvI8
Message-ID: <CAH5Ym4h8-1mc+DX0Si7XROeGn9M72bQC+ooM05Y7ZmgTo+ON4w@mail.gmail.com>
Subject: Re: [PATCH net] net: stmmac: retry a failed RX refill from a timer
To: Nicolai Buchwitz <nb@tipi-net.de>
Cc: Anandu Padinhare <Anandu.Padinhare@electrifex.com>, maxime.chevallier@bootlin.com, 
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org, 
	kuba@kernel.org, pabeni@redhat.com, mcoquelin.stm32@gmail.com, 
	alexandre.torgue@foss.st.com, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>, David Wu <david.wu@rock-chips.com>, 
	stable@vger.kernel.org, netdev@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 22, 2026 at 10:01=E2=80=AFAM Nicolai Buchwitz <nb@tipi-net.de> =
wrote:
>
> Hi Anandu
>
> On 20.11.2026 08:49, Anandu Padinhare wrote:
>
> > [...]
>
> > @@ -6164,6 +6205,8 @@ static int stmmac_napi_poll_rx(struct napi_struct
> > *napi, int budget)
> >       u64_stats_update_end(&rxq_stats->napi_syncp);
> >
> >       work_done =3D stmmac_rx(priv, budget, chan);
> > +     if (unlikely(stmmac_rx_refill_needed(priv, chan)))
> > +             stmmac_rx_refill_timer_arm(ch);
>
> After a successful retry, doesn't this leave the last received frame in
> the ring until the next RX irq? Could the poll refill first?

Do you mean "first as well" or "first instead"? Because "instead" can
cause avoidable packet loss:
1) Initially, network is idle and ring is full of empty DMA buffers
2) A burst of exactly one ring's worth of packets arrives
3) The RX irq fires and stmmac_rx() attempts its refill-first (none
needed) then depletes the ring to the maximally-dirty state; the
refill timer is armed
4) During the 10ms timer period, more traffic arrives
5) The RX irq doesn't fire again because no additional DMA is
happening: there are no usable buffers in the ring. So we're forced to
wait out the timer.
6) Any packets during this time (beyond the RxFIFO's capacity) are
discarded by the hardware

But, "first as well" sounds good to me: before entering the main loop,
refill 1 buffer (if possible) just to ensure either the IRQ fires
again immediately (if the FIFO is holding onto another packet for us),
or the inaccessible ring slot is clean (if the FIFO is empty).

Cheers,
Sam

>
> > [...]
>
> Regards,
> Nicolai
