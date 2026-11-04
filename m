Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793816739;
	b=e78UdH/hg6kf7jcFQ1HGQHGiREfzY9NgwQUDF8F3NXLgSt0dKobxisGEKdkC9sBcvrpo
	 SM7Qizc85pKdWyCOfdWDZS3tP9aSiBdkBWKP5RNOQm7WUWaaGVF0bQIshQozE4dNuGBFI
	 VJ1rfoJpD6FPqkeOSbOs5AJVfkf1aZYa4OP0KBUr//CSXHhB1IZ7XmXZ3c7QpLoCGYZ2k
	 ATWnD9cz70gRxr0mo448IJzWwI57gHEsqY/3lQblOjp8h85ugZR2maSe0l9TaBwawd9aj
	 9JLzfBjazTwQIQ5UZx8l8FsgOHnRjxiwKHfma6cKjwYGbYHqLnNrcnO02+ANYgTFXLg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793816739;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:Content-Transfer-Encoding:MIME-Version;
	bh=2McMLcZm4/1G062uRME8RW0Y6yWfN7E/pVq9UFcISOw=;
	b=LV4rgtPWKOFOOx2a2SAGODMkT+ZdGg+NJmtuUHHcq1w4sFBl2ON79w8HLyx5ae0cyeAv
	 g1prt1/BPOEi+t9jOIqsXEt/FPfpcwAjeSzuAW26Hyxx6g899GLQ/srPkOsi/gbCaZyEw
	 rf+RGd6j3aVJpetjElt/dFji61z3+uvqcyGOYVfLhSAGn19Q7icODCC9RWtntTRlS8wH1
	 ohSxlk0pFgH4oEZrYuLt33kT5zCNDRreIi3VXVgadKwc7N4fz4r8f9FIWANd0Kp3EdVuu
	 MAwI8uVBaWuHpqDKzKTXgbNNNftFXy6nCm9EDB1uacUuvBoCyycr9EQThNERXfDFZpQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=aMcsUmhp;
	arc=none smtp.remote-ip=209.85.210.173
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DBB6606A328
	for <bpf@vger.kernel.org>; Wed,  4 Nov 2026 18:25:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0DBB6606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=aMcsUmhp
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-8a0673d9bd2so701159b3a.3
        for <bpf@vger.kernel.org>; Wed, 04 Nov 2026 10:25:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793816738; x=1794421538; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2McMLcZm4/1G062uRME8RW0Y6yWfN7E/pVq9UFcISOw=;
        b=aMcsUmhpOa7Up5ie6WoXMzXjyg42Zev8F+uGBn0SbaLFXXR5RoE2aMgV97p2RcjFJT
         zmiKy6ywuHH71rtSw9ynZMuWgtWf6SotKWlH+aR5BoeS+zSTUwaKC8BaotD6TCgEQTp7
         qTPnkTwkmGISvHs0Bv9vuSwCutpMOkKYOkTnfIAn0GS5LyJGlwFtAHqXcjI42tX5EBcN
         yQJHcqJkM1Nb4VpIljXOg9hFd+4C4l/AuxRqq/CANU2Qjnxd9AvjR3W9cSNn5ZF49lBJ
         vsJVJMAr1nMsIzRf+T0QDjayMz+XweKjXwEwYBVV3+LRIkKGS4IMAEQlHQGmBi9ghXi9
         IGgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793816738; x=1794421538;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2McMLcZm4/1G062uRME8RW0Y6yWfN7E/pVq9UFcISOw=;
        b=v4kQa31ujrnyR9d5+5vC03n6rWY7u9oCSFx5aVY+NwXeEhcbDl+HaaDGPBKhdTcNxx
         wtVFxsR0MxnwF94wu3N/a9TdMXMV0LAO+yTUJLOE/UOhbTFjNZh6J5EXkLijWlgoAvxg
         MPonZDEhxmP0h0BGWG1MUQ2NQIsD3sH8m4S5vbvq53fCMa2YhcEmnIOaiawcxH8EE3dq
         mgShF9hZJ89d8f2N4fcUWZX18FqfHWMXch6AZ1WUq8oGlT+8mVGiw5rNP0UsL9xQKxk+
         SQ4UoZv7g4EpqAcfaXA6IIrLn2lHIWTI6qRy25nXkiNhuLadDGNcZlNR34joK9/e52/R
         y1Og==
X-Forwarded-Encrypted: i=1; AKwUvBxqyyvlDNT9UoPRH485X3kSYSw7PGBQ3diSRmfR2FeoSbqZD2JU1VvXr3uGwxl59IelFf0=@vger.kernel.org
X-Gm-Message-State: APuU4Z/COB97DnZYYgnKMvlNFE8m/T62b7ffiK0AbDIeNz5lzm1PFbql
	54HMlctcY24wI7uerbNx66tqK/okWXYNIuhaCF72UZWl/jFS5MMsGzBsHl9OxQ==
X-Gm-Gg: AYBFou0RAVr+5vP6wp9KGnvudaQnMsvqrYOcIv9pTq+GMubNrPniGGPeb+kQobGTHKE
	q0flz9jmNzLtgJzf4Tl1v7Hms8L/2l0n8HAjnwNbqxh2Ir0SYcTRhA5kZaVXwqF7ysGY29WQ4qo
	rAhiBMVSiH5/yLWd0tCa74vMJe21o6Gpw7rIoK2okzblmWCT1XfFbxjUWWsV2iK9fjNWSVHsZzi
	IOsbJrAR/i869g7tTCUFlh8C5rnTmCQ3ml9KAoULr+RLm2qEHFy2Jkhwl86xxNGaJuz2fuhsuhZ
	VilziK8eWW2pg2ogqWg46L+pJHs9HUvSzrkvVAb07rLObbXlFa6oB0hqjqOscYYdJGarUWw7Mpq
	EHH1k7nD3qtnM2MHBoJH643g1CJk+XknxJk6XtYTKnWmZ9TpNjHPI4eke7G4xZWRiXVcidv9Nh9
	hCq3RpFkNXEjr/2iCMbf8zhzPUJ0P579TYxJgSqBcqZHCwvOSW6tm+e87jxDjQOOfAC5ND+vF9R
	MW64qXrJGjHUq4MPPhb4J1+Y1tzUdI3VSOQp7tGDTEf7n53SP1BSoXJYcM3X10TfCzInluQsrhN
	E21dMSpH4y4h+hzsvTptKLH638mZNNwFxK5lS9ZOgMpWH2BIUDsQCmgnM14qqAVeb60HbNLzq8u
	vAwIksM2gLnhWMntrkF9urYP6dNNTq3fq/eA=
X-Received: by 2002:a05:6a00:b82:b0:870:c2db:da2c with SMTP id d2e1a72fcca58-8a9bddbf8ebmr15105846b3a.25.1793816738252;
        Wed, 04 Nov 2026 10:25:38 -0800 (PST)
Received: from localhost ([153.61.198.240])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8b09c024a45sm1250460b3a.56.2026.11.04.10.25.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Nov 2026 10:25:37 -0800 (PST)
Content-Type: text/plain; charset=UTF-8
Date: Wed, 04 Nov 2026 18:25:36 +0000
Message-Id: <DMMMYOKCCSS2.15GTRVXFVMHTL@gmail.com>
Cc: <daniel@iogearbox.net>, <andrii@kernel.org>, <memxor@gmail.com>
Subject: Re: [PATCH bpf-next 16/37] bpf: Count loops whose first value or
 bound is a range
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Eduard Zingerman" <eddyz87@gmail.com>, <bpf@vger.kernel.org>
In-Reply-To: <f1e784a5de228293bc4fe21a5cfcc60d93a4400d.camel@gmail.com>
References: <20261103234104.208239-1-alexei.starovoitov@gmail.com> <20261103234104.208239-17-alexei.starovoitov@gmail.com> <f1e784a5de228293bc4fe21a5cfcc60d93a4400d.camel@gmail.com>
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

On Tue, Nov 03, 2026 at 11:26 PM Eduard Zingerman <eddyz87@gmail.com> wrote:
> On Tue, 2026-11-03 at 23:40 +0000, Alexei Starovoitov wrote:
>
>> +/* What is known about a scalar or about the offset of a pointer. */
>>  struct scev_value {
>> -	u64 value;	/* scalar value or a pointer offset */
>> +	u64 umin, umax;
>> +	s64 smin, smax;
>> +	u32 u32_min, u32_max;
>> +	s32 s32_min, s32_max;
>>  	int ptr_reg;	/* SCEV register identifying the pointer origin, or -1. */
>>  };
>
> Nice set of improvements.

Thanks for the quick review. Much appreciate it.

> Quick question: can the above use cnum{32,64} instead of direct bounds?
> Reason being, that I thought compute_backedge_taken_count() can be
> expressed in terms of cnums as well, in which case there would be no
> need to split it as two functions.

Yes. Will switch to r64 + r32 in a follow up.
scev_value_add() becomes cnum64_add() + cnum32_add().
It's more precise too. [-1, 0] + 1 is [0, 1] for an unsigned compare.
The direct bounds make it [0, U64_MAX].

cnums don't remove the split though. They merge signed and unsigned.
The split is between constants and ranges.

> cnums aside, it appears surprising that both compute_backedge_taken_count()
> and compute_backedge_taken_max() are necessary.
> For example, I'd expect that compute_backedge_taken_max() should be
> expressible using compute_backedge_taken_count() as:
>
>   high  := compute_backedge_taken_count(..., min(initial), step, max(bound), ...);
>   low   := compute_backedge_taken_count(..., max(initial), step, min(bound), ...);
>   ... overflow check for iv with `low` and `high` ...
>
> Or vice-versa, compute_backedge_taken_count() seem to be expressible
> as a special case for compute_backedge_taken_max() with ranges
> [initial, initial] and [bound, bound].
>
> Is there some precision loss I don't understand?

well... Below _count() and _max() are the two functions.

The problem

The value that ends the loop depends on (bound - first value) % step.

  for (u64 i = first; i > 0; i -= 2)

  first   i at the latch     _count()
  -----   ----------------   ---------------------
  10      10 8 6 4 2 0       5
  11      11 9 7 5 3 1 -1    none, -1 wraps around
  12      12 10 8 6 4 2 0    6

For 10..12 both ends have a count, and 11 wraps around.
A range needs a check that holds for each remainder.
The value that ends the loop is less than a step behind the bound.
Here the worst one is 0 - 2 + 1 = -1, so 10..12 has no count.
The same check rejects [10, 10], and _count() accepts 10.

The options

Four ways to get a count for constants and for ranges:

  option                           what breaks
  -------------------------------  ------------------------------
  _count() for constants and       nothing, it is two functions
  _max() for ranges (the patch)
  _max() from two _count() calls   11 in the example
  _count() as _max() of [c, c]     constants lose counts
  one function on top of cnums     the same as [c, c]

Two _count() calls

The overflow check in _count() is exact for one first value.
It passes for both ends in the example, so it says nothing about 11.
The check has to come from the bound, and that is what _max() does.
_count() also returns false when the latch is false at first.
'low' of 'i = 0; i < (n & 15)' is _count(0, 1, 0), which is false.
The division is all that the two can share.

_max() of [c, c]

The two differ in what must not wrap around and in '!='.

                _count()                     _max()
  -----------   --------------------------   ----------------------------
  wrap around   first + step * count         bound + step - 1 for '<'
  '!='          step divides bound - first   step is 1 or -1, each first
                                             value in front of each bound

post32_lt, post32_sgt and post32_slt_max end the loop at U32_MAX,
S32_MIN and S32_MAX. The check of _max() gives them no count.
pre_ne, post_ne and pre_ne_wrap_up have a step of 2.
The '!=' rule of _max() gives them no count.

_max() can restore both with branches for constants.
That is the same two calculations in one function.
imo it's better to keep _count() as is.
It's exact and the tests cover it.

But I'm open to any other approach that my bots couldn't think of.

> Also, you'd consider it a nit, but compute_backedge_taken_count() has
> a nice set of comments explaining where each condition is coming from.

Makes sense. Will add such comments to _max() in follow up.

