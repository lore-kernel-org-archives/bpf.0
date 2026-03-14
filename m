Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D78A18EB0
	for <bpf@vger.kernel.org>; Sat, 14 Mar 2026 08:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773476537; cv=none; b=KpxENllskLFDE/0NfYxCMoTWfZ/A0xn424pNJ6HhrzJ+V8rQFX9t4b0CHk94veSO/SY5OkkF7doh19QTBXyjyyElNDJk14SiERXqpVkmRlXCcePmwPgIsGKopD99otwctr1yEIS/fKA4noDX830iRz5At97JhsukuPZ1Zb2C+yI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773476537; c=relaxed/simple;
	bh=0g3EkGgNCZvQiEuyfJeFxyNwMRwUfwQ01w/Zn1aXDL8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UH1H7NTOWoehOokZKdHjlXAMc71vLS51Rbo9JnekPvi8BJTxRdvye90BD1yWDwwv2zCyocBoqDxHDsREj4hZo49Fg+NWetQPLa1g7V63Fee/iW6cL05wmAeLiN/kF3QA1ar99O/mpQC/zwTaj1KMd0LBoQ2pTmSc8RjzfoclfNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ypma7PKx; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ypma7PKx"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2ab46931cf1so29585805ad.0
        for <bpf@vger.kernel.org>; Sat, 14 Mar 2026 01:22:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773476536; x=1774081336; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Bf4YVj94uBUW+tFJKJRpV0cCZPxT/+Q8jbshvKXcr24=;
        b=Ypma7PKxTLj+aWzXomFBBZJ6xdsfeP07IbPjvLbtTngNuY3vxXruKEpRc0KpBsyjfC
         G1/P2XGkKG21Y0hefn+yDq/Yv4YAUXSmYPmYDO7S8j08i71sp4QBUqrgjmKGaaqAashr
         HHjcQ5lcDGR0RWVZbpHbIVPPxoWeuwDH/Bihsi5/X1ikCVL851pW3G6VYCwR+nc++gB0
         MfJEpQ0o9MgcvF6jVdhxfhSapyUUzTcqcL25T5TFYyM2zbxwOCr6cS+w4zNDCs497D6E
         DWbVfxCWSMW7k/DdLFv7ElKQQMkwvK06w5vwt6m5fZRgUGSoOzqVf7EDNrEKxXGmLOLx
         AdSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773476536; x=1774081336;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Bf4YVj94uBUW+tFJKJRpV0cCZPxT/+Q8jbshvKXcr24=;
        b=Ds3QK22PH32XgBiEQ0fV5FXNOE3ggEhWXZsdp8uptIlk1bupg3OhuoYgb35IIvAR0n
         bzGWzVbg+USLO9v33ZPAJ2xIGuE4elDa8cl/UAGdMbm+gm++0yRJEdd/7n+qF5GpjtD2
         LRbpOonaEUsy/EBeXMfLqLOSV55J1HrP6GJ4CdgTvrc3VDNjoCEcxngb1bWZR1HwCCcb
         4vRUwDq0FfF+x+RLvAfv9MsEisgGzrmQadZ1sBeMPYbqfvOXDE1EUbIyzAwN66QXoZa8
         gi7Wyq0yJSmfFttYWy/TE79eFnCoWxWGuAjGI0qe7UkHEsYHWt4t6bpBF4176GMjKjZN
         y3FQ==
X-Forwarded-Encrypted: i=1; AJvYcCUdcK8xehaLbSXbHBlOF1gvLBl6CKN7AKf2kKvqftqEelXc/ftMq3H16EEQkM7r1cQy2Nk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/IfzGsul9HTOpfyJYCdYf6q/3bkonE75rLeGR/sFPWn3X42SE
	sxwiuXU6WNK8Gc20PhfP7WmUpFspfEDt5nhNAsg0522WEJa1r0Mi2TqJ
X-Gm-Gg: ATEYQzyKPRXywOJ+DKFfA9o7cPf3obkVYAMLkb+T6bC3uI40m3sm5aa7ByVtvCgp2OL
	Kb5wvexyPFH+hrXu4qh1of8G+8ros1XO1mBfOePk2kjlAWwt1M3IkcWPWHg+UDeaa2BdfBkcd8b
	SXusS4Ep1xcQnjFx76lDyeU/aQyFS+m4ZoDqAAGiI7UIMkaZKrbxsDwL+I++Jb8BfZhG8YIL1vQ
	bEc1F++6a5iB2L1Gqk8l3x7apI4pjQ0Eu03B+FBq5W1Gjbe07XqqZsLmLJCM/KA/PG4QvOYF7un
	zT9hLYB5bDFRmSdxowSjTdcG38zeD7HMbQv9mZgi71Qxssa5VFAg7P/4vjrpdI6aHU5B4AzWnz4
	b8MzV2b2Vkoo5th9xK0Qjjq7C4XLghzi6N5xKQDutg7y3MEaD2MuKWKo9GD/I7scm68yL+rbG3K
	zqY+MQE0Jp3hzYljTdTi9Y4pePCI6mBVSB1FGui0pNGx13jK7hUMs=
X-Received: by 2002:a17:903:1a28:b0:2ae:c981:2a1c with SMTP id d9443c01a7336-2aeca645a6amr63923925ad.25.1773476535916;
        Sat, 14 Mar 2026 01:22:15 -0700 (PDT)
Received: from [192.168.0.56] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2aece7ee6c6sm45317015ad.48.2026.03.14.01.22.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Mar 2026 01:22:15 -0700 (PDT)
Message-ID: <bff0a144925370ba4c34be610f910a8ca0f91efb.camel@gmail.com>
Subject: Re: [PATCH bpf-next v3 0/3] Optimize bounds refinement by
 reordering deductions
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>,  Andrii Nakryiko <andrii@kernel.org>, Shung-Hsi Yu
 <shung-hsi.yu@suse.com>, Paul Chaignon <paul.chaignon@gmail.com>,  bpf
 <bpf@vger.kernel.org>
Date: Sat, 14 Mar 2026 01:22:12 -0700
In-Reply-To: <CAADnVQKw-8ZBy3H+kP_nvtFY=8neF1Lm3tuVoQ=OpKrxb-qj8w@mail.gmail.com>
References: <cover.1773401138.git.paul.chaignon@gmail.com>
	 <ede050cd3a7ac94a839c2960a8a09b1dcd1f0777.camel@gmail.com>
	 <CAADnVQKw-8ZBy3H+kP_nvtFY=8neF1Lm3tuVoQ=OpKrxb-qj8w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.1 (3.58.1-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2026-03-13 at 19:18 -0700, Alexei Starovoitov wrote:
> On Fri, Mar 13, 2026 at 3:02=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.c=
om> wrote:
> > have and land this patch-set. I'll share details on cnums later in a
> > separate email, but tldr is that cnum representation is strictly less
> > precise compared to combination of signed and unsigned ranges
> > (probably this was obvious in the hindsight).
>=20
> Understood. Applied the patches,
> but I thought that the main advantage of circular representation
> that it represents both, since the sign is "absorbed" by the circle.
> What did the paper claim?

Actually, the paper [0] does not compare wrapped intervals to a pair
of signed and unsigned domains tracked in sync. It compares wrapped
intervals to one or the other.

Probably this was obvious from the beginning, but I had to
re-implement reg_bounds_sync() to understand the problem.
When signed and unsigned intervals are tracked separately,
this can describe two arcs on the "number circle".
For example, consider a pair of 32-bit ranges, signed [-128, 127]
and unsigned [1, U32_MAX]. When combined, these describe two arcs:
[-128, -1] and [1, 127]. However, a single wrapped interval will
approximate the above as [-128, 127], loosing some precision.

This example is taken from one of the tests in the reg_bounds.c.
I hit it while rewriting logic deducing 64-bit bounds from 32-bit
bounds, implementation that used intersection of cnums defined
by signed and unsigned intervals failed to refine the following case:

  ACTUAL   FALSE1: scalar(u64=3D[0; U64_MAX],u32=3D[1; 4294967295],s64=3D[0=
xffffffffffffff80; 0x7f],s32=3D[0xffffff80; 0x7f])
  EXPECTED FALSE1: scalar(u64=3D[1; U64_MAX],u32=3D[1; 4294967295],s64=3D[0=
xffffffffffffff80; 0x7f],s32=3D[0xffffff80; 0x7f])
                               ^-- here

Hence, the final implementation passing all the tests has to consider
signed and unsigned domains separately (see [1]).

Thus, we cannot replace signed / unsigned ranges with a single wrapped
interval w/o dropping some precision.

I'd argue that complete re-implementation of reg_bounds_sync() in
cnums does look a bit simpler compared to current code, but one needs
to take into account the supporting code in [2] and [3].

On the bright side, I noticed that current code inferring 64-bit
bounds from 32-bit ranges does not handle several cases, namely:


N*2^32                   (N+1)*2^32                (N+2)*2^32              =
  (N+3)*2^32
||--|=3D=3D=3D=3D=3D|----|----------||--|=3D=3D=3D=3D=3D|---------------||-=
-|=3D=3D=3D=3D=3D|------------|--||
    |< b >|    |              |< b >|                   |< b >|            =
|
               |              |                               |            =
|
               |<-------------+--------- a -------------------|----------->=
|
                              |                               |
                              |<-------- t ------------------>|

Or with b crossing the U32_MAX / 0 boundary:

N*2^32                   (N+1)*2^32                (N+2)*2^32              =
  (N+3)*2^32
||=3D=3D=3D|---------|------|=3D=3D=3D||=3D=3D=3D|----------------|=3D=3D=
=3D||=3D=3D=3D|---------|------|=3D=3D=3D||
 |b >|         |      |< b||b >|                |< b||b >|         |      |=
< b|
               |      |                                  |         |
               |<-----+----------------- a --------------+-------->|
                      |                                  |
                      |<---------------- t ------------->|

(a is a 64-bit range, b is a 32-bit range, t is a refined 64-bit range,
 such that =E2=88=80 v =E2=88=88 a, (u32)a =E2=88=88 b: v =E2=88=88 t)

cnum based code handling such cases (see [1,4]) is a tad simpler
conceptually compared to interval based code (see [5]).
But it is doable in both domains.

So, unless people agree with me that [1] is easier to understand /
maintain, there is little reason to switch to wrapped intervals.

[0] https://jorgenavas.github.io/papers/ACM-TOPLAS-wrapped.pdf
[1] https://github.com/eddyz87/bpf/blob/cnum-sync-bounds/kernel/bpf/verifie=
r.c#L2521
[2] https://github.com/eddyz87/bpf/blob/cnum-sync-bounds/kernel/bpf/cnum_de=
fs.h
[3] https://github.com/eddyz87/bpf/blob/cnum-sync-bounds/kernel/bpf/cnum.c
[4] https://github.com/eddyz87/cnum-verif/blob/master/cnum.c#L92
[5] https://github.com/eddyz87/cnum-verif/blob/master/cnum.c#L171
