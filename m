Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793838403;
	b=TUD34Z8x/lMXf6FZKb4qZMQ+cR/WNG/ARxvbNjwqtmWiKwTO6ihf3a55AkLlw9/Kss7/
	 1TJJUXLhIIF0JTO3IrYtMQ6oOAIMtjWqKJi1Mp6v4Nb1VhqIWYPt5AmMmsZjuQ7bfzey0
	 IxertoCRPZFtNqc7ehNEexxj5RGjDrNFHJCrzOoCk4ZL4/QJ/p+79PqP25oiW1ZFCDOoN
	 ZF36Vk0Ck32RAnBubuhLuxGmrFXHT9fMUvRBzb3sxpCRF1m3GFIp8FLORJZMVV3PEruow
	 I6xOqINhgtW8zez5m7Mv5Ovh57TeSLzhVbhotU73qbZ534+3CMxS3q3aQq1D8gGR7Ng==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793838403;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=CwXKbQAV0SKUBCKeaDmQyuZbmqiB7VLocRCm8PA2gNU=;
	b=hhdG/bHLO0U0jP3EDAEEppFJNMOXBaLQ3MWeXfUE5+b92bSQmzJOcvb87NXoZ1MdYP2d
	 1WBYD/XR6nZJcxh4TvyN2NPvKtwmliubDPDOzfnn40jYSj7c9IntyzVC0HCpLJbJKG6Hp
	 QyfxVNNDNGPt6g3rYpre8dRRiMR3J95I5jmPd1Xy7UZYILsgF6ClJDOMVe2DFHrtwGX9x
	 Jp34IFKknWR51JvSUQB+CfL38QalLn4wkZwbz/shhY1HzocnQcaAJg4eQLlOIS3GfVqtt
	 69cyEv8SMn921J6SoCUOQ+bvu4rUZbrGx4BGVQ+7pssQzx2Z82W5hVyF/G5+Woi8zUQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PeZ+jq7z;
	arc=none smtp.remote-ip=209.85.215.176
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96C90606A31B
	for <bpf@vger.kernel.org>; Thu,  5 Nov 2026 00:26:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 96C90606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PeZ+jq7z
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-cd67cc518a6so844232a12.1
        for <bpf@vger.kernel.org>; Wed, 04 Nov 2026 16:26:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793838402; x=1794443202; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=CwXKbQAV0SKUBCKeaDmQyuZbmqiB7VLocRCm8PA2gNU=;
        b=PeZ+jq7z7z9VV01iY+srFx4v1jnbjWRxkrAiizOCbkhE20Amw+760Ui3WLfUq3AaGK
         QOE8G4yiNq9Xb4VD4OJumICovfPK3c7GaWRi2YsFNLOuGohQZyMD1Z+w24a5iI8v18c2
         RrzU5QHIorVxj88iU8olOBKnwXvmxhlu3E7Cq/75XaPLEChG/SwQcvOXIRq3S108yiZ9
         KaANVfOFs1hBUR5MSkEyOEqu6HN7Wcv+yR4NW2TGNAnQN5pe8Rr5Xnz7N5mZtV+DhQC6
         amHi5MQPaWG0hcYKJz8SAxW2xPgALIVVPsxlKSYQeKRg3S7JjQPpJ0T3GkTJHwTmx7nC
         Ajmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793838402; x=1794443202;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CwXKbQAV0SKUBCKeaDmQyuZbmqiB7VLocRCm8PA2gNU=;
        b=WPvW4sbwgy79jRIz6XKDM4AKf98XGFWHnqHUs4M7nHUF/+qR4TUqLeNuBxk2k/pwtB
         hke1vrhfw6+5gDr9mgaUG7tT1rOkjR6HqDeZrqstRQpMv9cym4p4yzEOQd0pACVWJZK/
         M4cyoCWjjBXbw+A/I6flC9R3gdpGBJeCuVEOICzedFPnACiJT8mzA6mMJSCuhDpQvRs1
         OTb07QC3iWzZsgVOJvH05Rp/8QRWghOOxE1pVMo+JqxgV4AqEXrT8/bkW3Mh4VG0kLZG
         Rs9ieF4QOA0+F8GPq0mMj0wxDUNEa9viJDIwPWdaM1XAS8oN/I0lWq9qtpUyyCtbDJg7
         ifWw==
X-Forwarded-Encrypted: i=1; AKwUvBxWkqY1FMI94faPwAoMGcqJEo48eMGqEylx/wH+pTJuCagBS8ZutA6bRcPbpP05f10fqzc=@vger.kernel.org
X-Gm-Message-State: APuU4Z9T89WrIsqhXmbBo1K4CcJqSof6EGt7WyKCva4A9XsELbY3bhGU
	EgeykoEtatkMmBNJ5dEHpOnCZfy5fI7f33EDQieUZh0l4j0bgigKpIbT
X-Gm-Gg: AYBFou1zCsSI6V8vuF7Dj3rkak8RUR3HBN/xqn8LDgBajtEYMXM2crI22kbt/kFY4XH
	NbqcqUxuHnBBpbhmqb5yEIEQpC+FQFyZ4w8qc7xU3+DZKmpQNbjHfBZ6mqdc6ZcktrEAEZou6UB
	3frCgPZUPcd5+QRMTFzL7WH6mBInBq+baC8SwbJEKjP4Y/dQVPca5jvdtjZofGCrleP1pZVxE+H
	tSbVlI0eDDUuYMBTZFdyKVEW4v28ib7uDbrG0XTNDrS04CE+e2Leeh1p6bNa1mSnU40TG4jf4I9
	enSJezZMatsYr0nrum7gnVEj0rva5Um0ZLtMOQk+LK0ufFD5Tae/M/nGEWYVKQ47+n3k2GZ7J6l
	PmwF+McD1ZTghUj3oA/fFrKmcOL/ufRQBMxDOyEnLduZ+escGJEd9f6jEZESTZJwtwmkHfrSz9g
	Fm/+7h0v/DtwzO2ieJMfY16ty/lm5X74GV+qOfWZUQd7rAZxCPuqVRkkf3z10T3ptF2vPvLFoVE
	HbnoTDNbwhTT7j/LUBKQCRoJD10IzclpDj9lT/nDUKjcgRxSq6YTWHsm2Dr1cGDpQtydcz0BXxl
	r+fDkxH2C336BBK1HH8GC87qRfwsxJCQG712PoADJJPW2px1fY+RaJA0ZSI93gnpcAYpcdAsdsE
	Yj0s=
X-Received: by 2002:a17:903:1a30:b0:2e3:598:75b8 with SMTP id d9443c01a7336-2eb364b0dc1mr171242215ad.27.1793838401772;
        Wed, 04 Nov 2026 16:26:41 -0800 (PST)
Received: from [192.168.0.226] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ed08bd5ab2sm11649895ad.5.2026.11.04.16.26.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 16:26:41 -0800 (PST)
Message-ID: <74784940b7a6dcd4fee6f3008307ee6b04d65bc3.camel@gmail.com>
Subject: Re: [PATCH bpf-next 16/37] bpf: Count loops whose first value or
 bound is a range
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org
Cc: daniel@iogearbox.net, andrii@kernel.org, memxor@gmail.com
Date: Wed, 04 Nov 2026 17:26:39 -0700
In-Reply-To: <DMMMYOKCCSS2.15GTRVXFVMHTL@gmail.com>
References: <20261103234104.208239-1-alexei.starovoitov@gmail.com>
	 <20261103234104.208239-17-alexei.starovoitov@gmail.com>
	 <f1e784a5de228293bc4fe21a5cfcc60d93a4400d.camel@gmail.com>
	 <DMMMYOKCCSS2.15GTRVXFVMHTL@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-2.fc44) 
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Wed, 2026-11-04 at 18:25 +0000, Alexei Starovoitov wrote:

...

> The value that ends the loop depends on (bound - first value) % step.
>=20
>   for (u64 i =3D first; i > 0; i -=3D 2)
>=20
>   first   i at the latch     _count()
>   -----   ----------------   ---------------------
>   10      10 8 6 4 2 0       5
>   11      11 9 7 5 3 1 -1    none, -1 wraps around
>   12      12 10 8 6 4 2 0    6
>=20
> For 10..12 both ends have a count, and 11 wraps around.
> A range needs a check that holds for each remainder.
> The value that ends the loop is less than a step behind the bound.
> Here the worst one is 0 - 2 + 1 =3D -1, so 10..12 has no count.
> The same check rejects [10, 10], and _count() accepts 10.
>=20
> The options
>=20
> Four ways to get a count for constants and for ranges:
>=20
>   option                           what breaks
>   -------------------------------  ------------------------------
>   _count() for constants and       nothing, it is two functions
>   _max() for ranges (the patch)
>   _max() from two _count() calls   11 in the example
>   _count() as _max() of [c, c]     constants lose counts
>   one function on top of cnums     the same as [c, c]
>=20
> Two _count() calls
>=20
> The overflow check in _count() is exact for one first value.
> It passes for both ends in the example, so it says nothing about 11.
> The check has to come from the bound, and that is what _max() does.
> _count() also returns false when the latch is false at first.
> 'low' of 'i =3D 0; i < (n & 15)' is _count(0, 1, 0), which is false.
> The division is all that the two can share.
>=20
> _max() of [c, c]
>=20
> The two differ in what must not wrap around and in '!=3D'.
>=20
>                 _count()                     _max()
>   -----------   --------------------------   ----------------------------
>   wrap around   first + step * count         bound + step - 1 for '<'
>   '!=3D'          step divides bound - first   step is 1 or -1, each firs=
t
>                                              value in front of each bound
>=20
> post32_lt, post32_sgt and post32_slt_max end the loop at U32_MAX,
> S32_MIN and S32_MAX. The check of _max() gives them no count.
> pre_ne, post_ne and pre_ne_wrap_up have a step of 2.
> The '!=3D' rule of _max() gives them no count.
>=20
> _max() can restore both with branches for constants.
> That is the same two calculations in one function.
> imo it's better to keep _count() as is.
> It's exact and the tests cover it.
>=20
> But I'm open to any other approach that my bots couldn't think of.

I have a sketch that extracts cnum64/cnum32/tnum/base/step from
bpf_reg_state as `struct scalar` plus a set of arithmetic operations
and moves scev.c to use this abstraction.
This removes `bias`, `domain_range` and unifies _count and _max
variants, separate 32-bit into 64-bit embeddings.
Can share tomorrow after cleanup if you are interested.
