Received: from mail-ej2-f10.google.com (mail-ej2-f10.google.com [74.125.228.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38615D531
	for <bpf@vger.kernel.org>; Tue, 18 Aug 2026 14:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787061924; cv=none; b=PLHMZlzIrhsDRAb8QniKPFitS1H6ECHufcXvIQxl/YAhhLMM80ClkuET4X8w/L3S0u5EyVfZhZQgfJaX8GY1vaJCvkIvxPxWVaq5rBUg6gurXFloAQJJpNA4AUWT7rYmJfp8RMvTfD384dvqbTa+AnhyR+MuL/5bYlEzoT0Tbm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787061924; c=relaxed/simple;
	bh=6lN7JRMhV++fUWBRY/mOyEZ6HBCxjfX02lNtSVCMpUg=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=CO/97Zy+sJuGdB91JcS4sM76sFppk1MelZZmiVeY/W8PyeF1+qEsofj4Zbt4quqXQZx6JVgDGKqX1CJvV0rehkiwevKETfQ/EytV1AjylOYIGdM6OhWTjE93OK25vhNMdNqyu+gCEvZPQJLTDVVxJbSiza5DROWpiqDpp34kFHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hWnAAPQv; arc=none smtp.client-ip=74.125.228.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hWnAAPQv"
Received: by mail-ej2-f10.google.com with SMTP id a640c23a62f3a-c2142244006so35530166b.1
        for <bpf@vger.kernel.org>; Tue, 18 Aug 2026 07:05:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787061921; x=1787666721; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=8J8uVRc1aTCENx69srR/YmAYw9UpjNQQND8eHx6fKtQ=;
        b=hWnAAPQvsn8q4ieYhxBLS0l2dlDwcusBC6NyPuLYLeULqSOZEP7S052MJiyCjTBpuG
         7kYCgpwVN1exOwGGYy5ym0Dd3Wd8BPEbAVXvyLyIsSaMNAo2VG8Ndghf9Q1XmD/B2bxA
         /2lLyfglwM3x91nRW+zJnkcJSjNtGSa9/HYtWqBdpJXcaynD8ln7HHPCHtAb8uZ8msIS
         H8VXxSvbMBgJTbi6jGQg9scKcFkfuslB42UxkNPq2Gk1mPu4/PBCUAMwMxQNgzug/ZUA
         wAhTVwDCwYSV3b21LNYCafNtq2LnAgDu9DQm7lRWpWwpjp26wxC5wMm2jKmfBW5NzV9F
         cSOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787061921; x=1787666721;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8J8uVRc1aTCENx69srR/YmAYw9UpjNQQND8eHx6fKtQ=;
        b=Y4n908MlZEPxz2WWKkrjYZaoBdIwTIqKtcnABP4jiZPzP5oHlqXTr4CpTHQ6GFA1hG
         GXuMa/QvNwcqcer2SkTL+DxLLYKV5QmVbnqHeVJfmz30oIgxhbLTWmI5HszvnN4pRhPh
         ONpfoavgvS5JKZnk0r/Zkbz8CfjbaX/p2+orQprq56VtoW+/hQJO3MUaBwMshMpNP/Da
         dUKvRdNXN55FZHFaHCYqmIjzTd3pWBBkW5D165Nhtr8atWvb7/ugGBpYVErxHgQ5AcZ7
         UWm8dMq4jXtMrrsV/Pl7BLpL5pDJFgrN8VRS//VnDlvUqZAt+41kxJexlTZmmG0s34MB
         h7Xg==
X-Forwarded-Encrypted: i=1; AHgh+RraaoSYAgH/OXIi/F6Rm38Kcqu1fElox2Uv8jE3SRMR737S6Kxg+ojXV/tUn16clnxK32Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzZ45pXoSkxA81pQoPPd4jfhswP1TzEra+Djaepkmyyz4Qi8+Y
	GJ0zJNjN3ZXFvqSCNjWp1WOWoasNkJ0ZbvVCajFJ3ZREChFADNAxz1Wl
X-Gm-Gg: AR+sD10sJhW5vGChkYeQJg/QixXlaQKfUfRl5jyfzda2FZGT+MXI7fFKEicDh2HwOoW
	DtJfORghXS/nOeKkEPkPBJCLRYiGgCYPyhzLTsV/Fdy4b4wsJIkF94RYg3vKpkzETTnL2hqDJKH
	Z67nQ8OAVvxjNrBNexeDOOE/iyXcEbOpgkVpTeTKOA49otvPZ2yNMB4AaJEHkMc1QZI+UolLa75
	Q5wk4Xvc9/JiYA8MWR3rOCto2j3xIHZDoK4eaOiD0BENAA2kaJSbawBlpnqiXhDYjQLsS4LhNJd
	WpkJWfL0RCxcW3IKlNXU4kbDAnPaCbR+/MELueTQUEP+XseIM66jTuRzGCV2uMGbn4Tp+cYLb46
	4QgdoBOcTIhNaBiPZK5yMa3AdnJyP2tVtnuwoPbaHt0+teZAfy1K/1gtg/anltXjZvtyu8e5sHv
	u09hb4O9ow4BD5g9q/7jT/eeSxswdxoaO6OkO4+BZj8iZ7FmGb8SbgrBjN76KX1zEDt3Ip4DKEU
	ggEYUVFUe1zAV5IwHl8ioPKQCE+PH2n31FcuP9x+QBUu1ufDtDHkXRsyViBRVVL9VMwcr7MhnMB
	4qrId5v0owMSgRNk7itGll3ikSU=
X-Received: by 2002:a17:906:c147:b0:c16:785:cfb6 with SMTP id a640c23a62f3a-c218d9ba609mr329965666b.3.1787061921093;
        Tue, 18 Aug 2026 07:05:21 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2187d269dbsm144722766b.7.2026.08.18.07.05.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Aug 2026 07:05:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 18 Aug 2026 16:05:20 +0200
Message-Id: <DKS4KWIT8C5I.2THOLN7FKRRJT@gmail.com>
Cc: <loongarch@lists.linux.dev>, <linux-kernel@vger.kernel.org>, "Vincent
 Li" <vincent.mc.li@gmail.com>, <bpf@vger.kernel.org>
Subject: Re: [PATCH v1] LoongArch: Fix __smp_mb__{before,after}_atomic()
From: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
To: "Tiezhu Yang" <yangtiezhu@loongson.cn>, "Huacai Chen"
 <chenhuacai@kernel.org>
X-Mailer: aerc 0.21.0
References: <20260817035908.460-1-yangtiezhu@loongson.cn>
 <3103b3b4-5c0d-ed87-2e15-31a4d2289ec5@loongson.cn>
 <DKS3YCAMWONO.2NVVH8IPARH7Y@gmail.com>
 <48ade10d-dd1f-ac6f-e827-d76a81183486@loongson.cn>
In-Reply-To: <48ade10d-dd1f-ac6f-e827-d76a81183486@loongson.cn>

On Tue Aug 18, 2026 at 3:50 PM CEST, Tiezhu Yang wrote:
> On 2026/8/18 =E4=B8=8B=E5=8D=889:35, Kumar Kartikeya Dwivedi wrote:
>> On Tue Aug 18, 2026 at 3:28 PM CEST, Tiezhu Yang wrote:
>>> On 2026/8/17 =E4=B8=8A=E5=8D=8811:59, Tiezhu Yang wrote:
>>>> When testing the BPF selftest "sudo ./test_progs -t timer_lockup", the=
re
>>>> is a kernel lockup and panic:
>>>
>>> ...
>>>
>>>> With this patch, the lockless "store-before-load" ordering is enforced=
 by
>>>> the DBAR instruction. The BPF timer_lockup selftest was stressed for 5=
000
>>>> consecutive loops on a physical LoongArch machine without encountering=
 any
>>>> further lockups or warnings:
>>>>
>>>>     for i in {1..5000}; do sudo ./test_progs -t timer_lockup; done
>>>
>>> ...
>>>
>>>> diff --git a/arch/loongarch/include/asm/barrier.h b/arch/loongarch/inc=
lude/asm/barrier.h
>>>> index 4b663f197706..adfe343dfa65 100644
>>>> --- a/arch/loongarch/include/asm/barrier.h
>>>> +++ b/arch/loongarch/include/asm/barrier.h
>>>> @@ -57,8 +57,8 @@
>>>>    #define __WEAK_LLSC_MB		"			\n"
>>>>    #endif
>>>>
>>>> -#define __smp_mb__before_atomic()	barrier()
>>>> -#define __smp_mb__after_atomic()	barrier()
>>>> +#define __smp_mb__before_atomic()	__smp_mb()
>>>> +#define __smp_mb__after_atomic()	__smp_mb()
>>>>
>>>>    /**
>>>>     * array_index_mask_nospec() - generate a ~0 mask when index < size=
, 0 otherwise
>>>
>>> Hi all,
>>>
>>> To address the soft lockup while avoiding the performance overhead of
>>> executing two separate instructions, I think there is a more elegant
>>> way to fix this directly in the BPF core helper:
>>>
>>> We can replace atomic_inc() and smp_mb__after_atomic() with a single
>>> atomic_fetch_add() in bpf_timer_cancel(). This consolidates the logic
>>> into a single native atomic operation with full ordering, which not
>>> only guarantees the store-load order to eliminate the deadlock but
>>> also improves the performance for weak memory model architectures.
>>>
>>> Any thoughts on this approach?
>>>
>>> ```
>>> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
>>> index c18f1e16edee..ee2b3a4dcc05 100644
>>> --- a/kernel/bpf/helpers.c
>>> +++ b/kernel/bpf/helpers.c
>>> @@ -1591,9 +1591,7 @@ BPF_CALL_1(bpf_timer_cancel, struct bpf_async_ker=
n
>>> *, async)
>>>            */
>>>           if (!cur_t)
>>>                   goto drop;
>>> -       atomic_inc(&t->cancelling);
>>> -       /* Need full barrier after relaxed atomic_inc */
>>> -       smp_mb__after_atomic();
>>> +       atomic_fetch_add(1, &t->cancelling);
>>>           inc =3D true;
>>>           if (atomic_read(&cur_t->cancelling)) {
>>>                   /* We're cancelling timer t, while some other timer
>>> callback is
>>> ```
>>>
>>> I tested the above diff, the BPF timer_lockup selftest was stressed
>>> for 5000 consecutive loops on a physical LoongArch machine without
>>> encountering any further lockups or warnings.
>>
>> There is a full barrier in both cases. I don't know what performance imp=
rovement
>> will be achieved by changing this.
>
> We performed benchmarking using UnixBench on a physical LoongArch
> machine, the UnixBench score is different (amadd.w + dbar < amadd_db.w).
>

I mean, this function is already quite heavy. We have multiple fully ordere=
d
atomics (refcount bumps/drops, xchg(), etc.) spread across the operation. D=
o you
observe any measurable speedup in the throughput of this function?  The sec=
ond
question is whether timer cancellation is really frequent. In practice, I d=
on't
think that is the case.  The actual hrtimer_cancel() in itself is heavy and
waits synchronously for the callback to finish.

I'm not opposed to it or anything, I just don't think it's worth it in this
case. If the latency of cancel is a problem there are other bigger opportun=
ities
to pursue than this.

>> Don't you need to fix the lowering for
>> smp_mb__after_atomic() anyway? It's used in several other places in the =
kernel.
>
> The LoongArch architecture-level fix for smp_mb__after_atomic() is
> a fundamental bug fix that will be pushed separately to the LoongArch
> tree. This BPF-layer change is intended as a generic, cross-architecture
> performance optimization.
>
> Thanks,
> Tiezhu

