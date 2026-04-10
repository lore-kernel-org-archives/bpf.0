Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15495392820
	for <bpf@vger.kernel.org>; Fri, 10 Apr 2026 23:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775865509; cv=none; b=aI3Qu+LtPveUaF38W6zLLhx3c4tONiQEIUINbsnKSQYNlBj6E0lDytSsv0pAE1BDW558j2GdY+1FlPLYrbq7+aW1zyE+1TUKHn5Bov6Q9DooKo8cmkTP1y+1FmhH+rYM0Nf6XyfB7P8kksM+DbtFIG1t46IDd4jffAwPFQz5w9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775865509; c=relaxed/simple;
	bh=lTW8gJ6XqZKVFjyGvbPyfgu3a0sy75jdhQOtl/3+JGY=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=QtMiHE7KrB7chegwAkE+PBPOFVlwK8PriFuZDLWPMQQqPJCKYciI+1oWhf4/EopDuMCu+QStkresekwZwA9/167Pp0P4tkmpYnTlarxUCU7U3WnasS6XeClF9bw6msOYrP2mPlYsu5PbBuh5Cbx2q9K/pXAMzFbt58okDxJ1MLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=t1bojsqi; arc=none smtp.client-ip=74.125.82.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="t1bojsqi"
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-2d5ead6a34eso1507962eec.0
        for <bpf@vger.kernel.org>; Fri, 10 Apr 2026 16:58:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1775865507; x=1776470307; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lTW8gJ6XqZKVFjyGvbPyfgu3a0sy75jdhQOtl/3+JGY=;
        b=t1bojsqijQTl4vS1CF049wB4LWgLZ7buIORkE+TBOTONQuzWFTpSuTZTFWTBmhSkgx
         8rMCj63s2PWJAbZRsQZHfu4RR04ucI0s7PsbVmo1+/s+sEPgmGOppsfu/RLjc3i1u5+T
         byjkDKz10N4DKvuIkCg6OM0dBr3C3t5NXo6/Hnftjdk8x6XVrTc7dZeifVhbMhJIDtlT
         whleEErCt+65+5rcrPeVurEAmkqLFEz1LDVqiSwE7PxqlL8tA4M/w+ynyIi/MMMKQgl4
         QmphpLH9G54hUrgyNV3li+5+oK1jxizoswJtUPsfCD6sYtEYIIuOJUiamQB4X+g31CEo
         N0cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775865507; x=1776470307;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lTW8gJ6XqZKVFjyGvbPyfgu3a0sy75jdhQOtl/3+JGY=;
        b=WRyQytf93x/xLG5Yet96kfRqJ8YpV0DTf/tYeldguu/PT7Wkl/Qic62vJ1P/I7c3l9
         g6fGRdBPmsPqP5KEiz0UOdwWIlDsJ5VZIUumiRpmZUAU9uurH2CMFikAQBsMkaZyGYam
         FPRSHm+pEHPC9yDfIsPY8tusEBH8o/HMKpG2AIKf4ZY/fLalxq3s9TCCExkXdUYmp+6R
         /sGUHic76pWN5ZMK47Nzy+Bu/y/eWkH4kLyNxEGHc8mvenxfaUZI+vLdh6TXyTh88ZCv
         cXIC95iI7a3FTnnXcwnO/TLfPcCIIy0YKAAxtlTVV+2APYETOOCMhmz4mA75GWhGM151
         q8sg==
X-Forwarded-Encrypted: i=1; AJvYcCVKdwaZ9ag9iv5mH0kZv0zg3CxXro79vv7G7WXgpsU6I3NlfWTB+9JHj0cvJXL6u2sr9wE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMQ7gTKnA58xbIrc0H+L7lNfDc3KRZHBkJVzK6/OcaHohDq8Bk
	Y8pNbGAg3C78Xa96i3lXjebPE0f9WvDKrH6TyNOlX1taykjPl9HryhvA1wlRlumrePQ=
X-Gm-Gg: AeBDievhpUdXNdSQStTTrQ/2QJbaldJkeiceM2IZoHXxJj3/pCjV64xHGQuhfIhMII2
	M4uq6AZNS/+q0Rb2O77s8IA57rRfn4j4K/WN3PbayeznJ1J5yrl4R/KjnMxqi15Zk7/GtGoCKrF
	54pRhhvy/xBZ5JlM9ZCYpTwSiiCwC9JNznJM6OfrqWIBztSr1mfXevSEwJFnLEvBNA0tF036cTB
	tTSW+LrlTQ2YfWxSiqs8dRzZEVcn1NKsdD2WaXRGx5Kw84rAykaJugKKSix0WWqHBG0vB7wNHgk
	MBGBI7BvM4ekr46wmVTszo7gyuruRW2lqpQbuZYhYGT+HlWbOjp7nptnmQNUkf52Dp9JzGEXRsP
	q1cThTNs0/J+pB78mcWtw+3kSa/DS01C8R+aU4mttGPrl88v/AyeE8C16NaB+oI/Dxu0FSbLVRF
	Hz2Zul
X-Received: by 2002:a05:7022:ec07:b0:128:d3de:c9e4 with SMTP id a92af1059eb24-12c34ef7f15mr2977286c88.30.1775865507128;
        Fri, 10 Apr 2026 16:58:27 -0700 (PDT)
Received: from localhost ([2620:10d:c090:600::9619])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2d561cd2c09sm8181848eec.18.2026.04.10.16.58.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Apr 2026 16:58:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 10 Apr 2026 19:58:24 -0400
Message-Id: <DHPVS6FFSIZH.2T64S402G32E0@etsalapatis.com>
Cc: "Emil Tsalapatis" <emil@etsalapatis.com>, "Kumar Kartikeya Dwivedi"
 <memxor@gmail.com>, "bpf" <bpf@vger.kernel.org>, "Alexei Starovoitov"
 <ast@kernel.org>, "Andrii Nakryiko" <andrii@kernel.org>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "Eduard" <eddyz87@gmail.com>
Subject: Re: [PATCH bpf-next v5 5/9] selftests/bpf: Add basic libarena
 scaffolding
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Song Liu" <song@kernel.org>, "Alexei Starovoitov"
 <alexei.starovoitov@gmail.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260410163041.8063-1-emil@etsalapatis.com>
 <20260410163041.8063-6-emil@etsalapatis.com>
 <CAPhsuW6f58hx-2AW+X9kwT0oOsRZHW1RA7meWnMjuniJNoMgow@mail.gmail.com>
 <CAP01T76gQXua1e+-zQxHcO2W9XHVe23t+QCCT3bWR_UyRWL27Q@mail.gmail.com>
 <DHPQZ0PMVOS8.OYBETSS0OQ34@etsalapatis.com>
 <CAPhsuW5ZAxvMy2LeHOc_QjuEViwK-MmPGNf4kjopAnLsPTO3_A@mail.gmail.com>
 <CAADnVQKU-ki0azXbZROivqVrajGZ_yHuwJj5U-=byFCOxKpSmQ@mail.gmail.com>
 <CAPhsuW7rxqMBQXGems3KxiPRv-wwV5HaiJk_mPCvizhiGF+JWA@mail.gmail.com>
In-Reply-To: <CAPhsuW7rxqMBQXGems3KxiPRv-wwV5HaiJk_mPCvizhiGF+JWA@mail.gmail.com>

On Fri Apr 10, 2026 at 7:06 PM EDT, Song Liu wrote:
> On Fri, Apr 10, 2026 at 3:50=E2=80=AFPM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> [...]
>> >
>> > There is also tools/sched_ext/include/scx/bpf_arena_common.h, which
>>
>> imo tools/sched_ext are bitrotting. I wouldn't be surprised
>> if they're removed. It's not really a library or a tool.
>
> Hmm.. In this case, we can probably ignore tools/sched_ext.
> I guess we can also ignore selftests/sched_ext? It is not getting
> a lot of active development either.
>
>> > is similar to bpf_arena_common.h in selftests/bpf. We can have sched_e=
xt
>> > include this version of bpf_arena_common.h. However, it seems weird to
>> > have sched_ext code include a header in selftests/bpf. Therefore, I th=
ink
>> > it makes more sense to move libarena to tools/lib/. WDYT?
>>
>> I wouldn't. In general tools/lib/ is not a place for generic libraries.
>> libbpf is there because it's needed to build the kernel.
>> libarena is in selftest/bpf, because it's needed for selftests.
>> The kernel itself doesn't need it.
>> I would remove some of the libs from tools/lib/.
>
> Assuming both tools/sched_ext and selftest/sched_ext are bitrotting,
> selftests/bpf is likely the only user of libarena in the longer term.
> In this case, I agree it makes sense to keep libarena inside selftests/bp=
f.
>

The selftest/sched_ext selftests are being actively tested on the CI,
but for libarena specifically they don't use arenas.=20

I think keeping stale BPF headers in tools/sched_ext is not an issue -=20
in fact we can remove the header from there right now. The only user
of bpf_arena_common.h in tools/sched_ext is scx_sdt.c and is mostly
there to demonstrate how to use arenas in the first place. Most of the
contents of the header are for compatibility with older Clang and pahole
versions, but we explicitly don't support those and can remove them.
The scheduler is also not actively being expanded either, so we don't
need to worry about importing new features from selftests/bpf.

> Thanks,
> Song

