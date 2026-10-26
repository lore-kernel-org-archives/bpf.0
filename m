Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.216.51
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793025128;
	b=auw8poGE0IHl8fe5dWwbwpstveQI2ShkSGwkGg9saqavs0V1JXW93BqjCkgc9QC6TIn0
	 GDtqXqX3/mQN7Mwm4+/IvKsvrrCgx2HCmSXGqsP4BWpuMOoInhUwBU3lCKaWoCasOuA9B
	 MmYbSkLpJujXH5vO6tP+F510KcXB1NcG5YjbS/SJwZvJArp7y22XC+imDgRM2fG6sXVCX
	 nvPgTjJ/NQ+aGmgmV6p75dCcuvKlUyzUPA9VcKAuFyabqUP8uIlNbCIH9Pu+0TTy/M6U+
	 SYrsgIA/WoPt3QF9lTXwWyLqiflqKC+au0EiHpsAhyD6+8RAvWCeUKsoMuHZ3lgvt5g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793025128;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=VMmBhwH3f++U+Fny1silggx8Fp4rLIZ5/kJA7+I6Zec=;
	b=BDOvh/0J2LOs8lIDDLektSJ81U7WBQYoXmsSl3KJyLrlWDLpvwqGg5wuLMjW187rTtBY
	 NGhHAr3212vdKO2DB1h1GVQrOETqeKtH+v2QWRlaWM2HoSN81pB1ydqIm7mAUCVpVds9R
	 6cqcSZ0H7PvIaUT43EFiSSAz3P+FIZoc2uuMLK/1/YaZ7UcKJjwoJ9p7cPA+GsFfH2fVu
	 3Fjzb4t2haQSh4L/TQx3lKBg6dJ0w7l9MqEaOjw01/hftUBd+u7MY6qiVf6/6LZyRxsp/
	 7RG4hVLKKKtNk7I79YfqVlMLL8tHXW0fRAW9adI12S8+FpZWTLvTQGZyH8OG7I7WjPw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=fvFl2JqY;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.216.51
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5DDF606A31B
	for <bpf@vger.kernel.org>; Mon, 26 Oct 2026 14:32:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D5DDF606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=fvFl2JqY
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-3acb11973c3so2032077a91.3
        for <bpf@vger.kernel.org>; Mon, 26 Oct 2026 07:32:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793025127; cv=none;
        d=google.com; s=arc-20260327;
        b=Jq+VqW1VsKm3MoJ+pd8pSKMX+g2Wb6ms7pH7360LMPxchWaqK9977ZfXJ7RcJgF66B
         qaNNsEn3E1+bOyUhZGBh6SiSEaIFOfrqFWjy8BA1KP0zJeTzoRGjJy0BBgMvqqxNJf/p
         QYRkQDueO/zmPtlfmtolI/BcJkznKbWUq4MEiyM1KerD0uuC/dcILCXdXX89LsJqOFU6
         JxmbOaSzMsatvZnoLUAX98lSJbBFAfFRT4Ku5mlQ0q4aG9UEh8DwOLw5kX8p9iVyxcIK
         LkQGpEtnWHp+qCMc1+d90UrUDGr/45h1lKNXlrcFLFmYFBKotPVzeTBcavLNVFmdctao
         oA1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=VMmBhwH3f++U+Fny1silggx8Fp4rLIZ5/kJA7+I6Zec=;
        fh=/+/Ip1TorElR3KFkkcfdOYfcxjcNltR8B1Ch6ADVHoY=;
        b=O8wW6T/lPHD+dJCnB02qGetHVQZt+VH/L3S14lzMnQe99EVXv8CrYS/nkrOyXzBXkl
         NmrwZVUl+qMwzQn1IdRQPWjcArqHbHDRMBOgpSgp0SOQeohC8lZfqiK8q+clvDDK4ITN
         JHjIGS2Tm3kSTfQX3gM0sa17dMZSwr30G4tg9scuE4JKqgPSk00NhYBPX+HRDXValex3
         IlPMkrlA4cau8NLN2/B6l7viNbKcd+YsGj/4jB0ntnWFCF9c8gX9rPKeTl/BV8Y+JcUZ
         J88yD3kCJopeX/qngVI58Q/jVEZfLBl22ZwRsPJNUKmYTxGfTUzNH9qRcxp06pUmkezb
         /Y9g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793025127; x=1793629927; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VMmBhwH3f++U+Fny1silggx8Fp4rLIZ5/kJA7+I6Zec=;
        b=fvFl2JqYiK++L9Zn0vfo8qjsAtt8ULXmy4jRMsZWyhMJnRIQKO5Rgi7jeprM6MVIy4
         /gpHjU/ILM64eE/DWyLU9CpYZROq10UOYB88q2H+bNRGWt/4itLRlgb7IHZmz254KEUJ
         uyBnRxmPFfHjF2N0bUVo2B5byPKdjvv7n7yrws+I97JBI3bkCFzeSNxO5vtbSRwE8MiE
         0HiZelCG6u9CtDzypVlb7C/Us/VsX4+woXWZYwOacQWphQIEBAJvEiYJ4K0eVNFK4BwU
         YE9lJnKghkc2gPV7RauLtKpoQWBEQz+XeynSq1pXEe+p1iupFPzxs9UqunTA7XvO5dcC
         ZFBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793025127; x=1793629927;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=VMmBhwH3f++U+Fny1silggx8Fp4rLIZ5/kJA7+I6Zec=;
        b=ah5jdz/sp8cysr+ARAuoBLOqYCC9SmNzQXu8egYPdUa9MrAWskIqoB0C2u8C7w6lgA
         jKGkAa2gnvwCZlMm0hMzbGIIRGLb5nA2J15+N4btm0aA751GauvHssXu7aBafkv9Z7HY
         Eg8pW2dEtLkW4+jPU2cUkg8DN07A8+7H+kFOhIcymJYPdMEM9fBgv0okmgGegzOQYN59
         Ct95ws2v4nEplzR7PnQum+AkRb/I+z7kwjlDfMjYYd2y718Uv6wOE/j8+SiLetBkypiL
         2zIrUv4mT3zjYLvdZQdVTUY2b0PYqQ/+4ohpvagUukuomsVuyY11l7+L/9Lq5eGCHTGm
         YR0Q==
X-Forwarded-Encrypted: i=1; AKwUvBywgvPXENINa+kW86U3xQleAVk7Qh2twOy/lYkGIOJyMW9b0/WtkRL0qS3dzKourutHKPE=@vger.kernel.org
X-Gm-Message-State: AFq9FYJKozSHE2QxsURzx7CfZQe6t5QvD9621ydX/+XfMtQVR/aD3dza
	qOL9nRf18IuypChgL7pECXzGN5B7fsKh+zyuLOL1w/GOeHdtmJ9gxxrAiTTKxM5s+JVgzhZXmaW
	yCJHhH04FOL4mp6OFaSWl/6jIjNeKy+Y=
X-Gm-Gg: AYBFou3jY+yNoRkJTZsFhe4k1i1W4XBwFBX4SNuJ/yfW7/msg9pfDe3pbgGo9GNsrE8
	acduM31HMaefa1LclMG9taeW1368szGQhuO/ivbjXNeuUUdFl0tzK4+JaqExS+qRHK/EBkYGgJh
	OLZeBzg30bmWKeAlyEyZ667OfEBStLnB4vO6rBGJiThu1q63pkONIUw4J7Q+ejIK5AUJKDyjHtd
	8gKQCZFiZ50lKz682TVLoD/ABKY5K3+jcToTNWjDgAWEyz/IVGqvQGUpqe2pguX6oauoqQ5mTQb
	2dx+Io4jJE/zghhaYrGY6h+dwZ6v/ul6i2x3dpVK1pLs/SRtWdI6TBMxWknObAPr3tac7ElaIwJ
	FMBMMEw7q6/vD1rXbuvrLwXg8CAlcocL+panucDI=
X-Received: by 2002:a17:90b:5644:b0:3ab:d45c:59da with SMTP id
 98e67ed59e1d1-3adeafd21a8mr5767380a91.40.1793025126904; Mon, 26 Oct 2026
 07:32:06 -0700 (PDT)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261024091256.17918-1-testwrzwrz@gmail.com> <20261024141157.59301-1-testwrzwrz@gmail.com>
 <20261024141157.59301-2-testwrzwrz@gmail.com> <at82NLzM7g8HGgum@boxer> <20261026142705.4564-1-testwrzwrz@gmail.com>
In-Reply-To: <20261026142705.4564-1-testwrzwrz@gmail.com>
From: Magnus Karlsson <magnus.karlsson@gmail.com>
Date: Mon, 26 Oct 2026 16:31:54 +0200
X-Gm-Features: AclHuK89CEpPcFuQ9Zkf80L7rIP62d6arcQxEpIyB7BJW5pfRLgwLFs5gMXbiL8
Message-ID: <CAJ8uoz0XZg8K2g3eBXOajV3TsA-1Sz3D6t-G2+BYw2YX7A4K=Q@mail.gmail.com>
Subject: Re: [PATCH net v2 1/2] xsk: defer software checksum until the skb is complete
To: Rongzheng Wang <testwrzwrz@gmail.com>
Cc: Maciej Fijalkowski <maciej.fijalkowski@intel.com>, 
	Magnus Karlsson <magnus.karlsson@intel.com>, Jason Xing <kerneljasonxing@gmail.com>, 
	Stanislav Fomichev <sdf@google.com>, Jesper Dangaard Brouer <hawk@kernel.org>, stable@vger.kernel.org, 
	netdev@vger.kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 26 Oct 2026 at 16:30, Rongzheng Wang <testwrzwrz@gmail.com> wrote:
>
> Hi Maciej,
>
> Thanks for the review.
>
> Yes. xsk_skb_metadata() is only called for the first descriptor when
> skb is NULL; continuation fragments do not call it. So
> skb->ip_summed == CHECKSUM_PARTIAL means the first fragment requested
> the checksum.
>
> I'll preserve unlikely() around pool->tx_sw_csum like this:
>
>     static int xsk_skb_sw_csum(struct sk_buff *skb,
>                                struct xsk_buff_pool *pool)
>     {
>             if (unlikely(pool->tx_sw_csum &&
>                          skb->ip_summed == CHECKSUM_PARTIAL))
>                     return skb_checksum_help(skb);
>
>             return 0;
>     }
>
> For the drop path: xsk_drop_skb() increments tx_invalid_descs and
> consumes the skb; sendto() returns the error from skb_checksum_help().
> Since the descriptors are already consumed, retrying is not useful. The
> current metadata validation makes the malformed-packet path effectively
> unreachable, so this is a defensive drop.
>
> I verified the propagation in a local QEMU test kernel. For the test
> only, I temporarily changed xsk_skb_sw_csum() to:
>
>     static int xsk_skb_sw_csum(struct sk_buff *skb,
>                                struct xsk_buff_pool *pool)
>     {
>             if (unlikely(pool->tx_sw_csum &&
>                          skb->ip_summed == CHECKSUM_PARTIAL))
>                     return -EINVAL;
>
>             return 0;
>     }
>
> and ran test_xdp_metadata. It failed at the first generate_packet()
> sendto:
>
>     generate_packet:FAIL:sendto unexpected sendto: actual -1 < expected 0
>     Summary: 0/0 PASSED, 0 SKIPPED, 1/0 FAILED
>     TEST_RC=1
>
> The normal kernel still passes. The test harness does not print errno,
> so I can only state that sendto() returned -1; the injected error was
> -EINVAL. I restored the source after the test.
>
> Magnus suggested a distinct counter for malformed packets. I agree that
> would be more precise than tx_invalid_descs, but I'd prefer to do that
> in a separate patch instead of extending the UAPI in this stable fix.

Correct. If we decide to do anything like that, it should be a
separate patch for net-next at some later point in time.

Thanks: Magnus

> I'll address the remaining feedback and send v3 as a new thread.
>
> Thanks,
> Rongzheng
>
