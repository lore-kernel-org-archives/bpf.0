Received: from mail-ej2-f0.google.com (mail-ej2-f0.google.com [74.125.228.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2F763D79FD
	for <bpf@vger.kernel.org>; Tue, 18 Aug 2026 13:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787060157; cv=none; b=QAsHOZhr3esdpITt1J+HxV+kGulz67DWLnJa1plp6huhW11dPT0Nbn3kgblkeiQBLzUoBxWFq8A4PAgqMyANe72HHbVfwNCz89xRChlJ8h3YdRscW1oU1IDnuzKK2wkOevGsaDjPY0mcZzfAhdhHs8hvJF7GUYaxDGF1hXZLRkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787060157; c=relaxed/simple;
	bh=69PmcPI3dm7Faoq28h94RmUiPIMu2QEtxtKq+uOtgsI=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=rg4essuwAjLk01cpZUqokolLW4SwywCUtEg7Bx9KQd5uHIBMxJe3o9xg+9POqHjbsVxnCLlA1Dd/18v5keHx0RpU7nHaqyUbCAiqTQhrW3Eu01AcxBq2YTzmt0+iZzgLvE4f2VtBxORU13VtGSNkMVhT5lfYDFK6iXlDghxt0bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MXVPyzRi; arc=none smtp.client-ip=74.125.228.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MXVPyzRi"
Received: by mail-ej2-f0.google.com with SMTP id a640c23a62f3a-c16772d888aso174082066b.1
        for <bpf@vger.kernel.org>; Tue, 18 Aug 2026 06:35:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787060154; x=1787664954; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=co96cHXVTim0XeUqP04qIzrXjrThFIBTNFHixkplh6I=;
        b=MXVPyzRizjJ3uzesSy1YTetc3KaNv93xS5i2AGuUoPdK5er5kAe3eSAzhLIWuGK5gD
         4p7dKjKPUq177cQemLu0fLDZgyhJ3AmD1M8pivcHCWYo5yr5XI81MtKhVMOfDVVNVGZf
         ZVptxcACUzM5uh2tiBDLuqj3gbzy2aBlPzdennDAspNBCwhRD9n2Vcg+JKMSoOrPhCWI
         8WIbri7bh+2VfL4TSxSO0mq24h2/pa+7tLj9/TjmA5SQ06idnDpvrRjwi8OxERfLpxgW
         k1UGent7YFPI+fbNoXC5BfkUdKHQIX3kVpu76U93m4STEzVfFlBKUQwQKBpzrHQgZskM
         T8NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787060154; x=1787664954;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=co96cHXVTim0XeUqP04qIzrXjrThFIBTNFHixkplh6I=;
        b=ZC58etwD3u5y1AGHdygosXe430eZVNiLbEzX+FJTj5LtxZHwp6zXkxZAhf8BKi/MDJ
         8bntnAGHg8i6hNAHt8xHHWBt3gWAeaRSC2yaggwA7gAPmEN0bdBNoqCnwOctfpnjBiZd
         8fFEkhzGKNYOKHOi2E8pUH2HYJgTJgmtriWsqVDktRt98cbdFVLkNbq9jcwUF5NRgWlm
         0QAWu64sB0k7XBHtDU8J6MTSZDy8tDetKvVEr/Mg0iMy4XGDcpnu50AhTmX6NRdjp+HR
         I/eeqQrjo9jPrV2GDcOngKVMDy9H+cZa8Takjt3wuXlzriGMAFTmMm1/4DxU0Cv4DbXQ
         dz4A==
X-Forwarded-Encrypted: i=1; AHgh+RqR456mWKi6sYLb7lnabmBOpqddVNMNxiwtItLJv6DKaLmK1uCOJzbWTHoUTpftvmUm2UQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YytTEroeczCG4L3gj7xq2JgiMlhqMGMv2Be8EDFfGS2T7ART+PS
	r6M9zlJJi3Dq96j1kd/K/egAHqVU1ygnQb9ddyDR5fjLeo+48+znJtNu
X-Gm-Gg: AR+sD12JuEGn+atEioHrzXZ3A5PAS4N8I/bOhmtljTxO3AOw9x4vQ7poIEZS4JCWk9M
	Q2vZRFvqUQPQ/L5qRoGEj0yywWUc+SrV2lSV4omm95uVfnInboVhEXnmZKreNG54N4mrdGOo0HZ
	YWQh043fdWK0L0xFX3h6symK5bFM8TAhpEvK9ncsyobEOPRYE6QbnE1TnLfpu63cE1X/C5SAEmQ
	YWmIA/jLRLfBEwMJbtVSPkj/pavMzd5nCgB9Tmt6M5FjaEh5an6Bc2x3M5sZX+vfUA6Bhg+Mkmp
	zehPaNk/gJ5Al6R3XBKOoJ2ULTdO3NJchpwHuz69c9UyiUJmYZDN0WJQps6C1rQ1uN6yXFbzXRV
	Bqi39CbR3j/yzpst7E8NdKlmZX5e2oFcuLuQb7aw4kceJrpQh1ot3mfPWDEp4y0tXfSAQh2aWg0
	88P9RjGs2Giw2x3Je019CEY4wxqHtKQ7je4QQMHUR+QW87T/c5rJoEyWjGe1ZJ5OgalYtP44qzR
	mRsDZOHu1PwGJ7oRs6lqs2/zh/We1xbHOfCYdpLKMufPdjpJoObrdxxqOhnAs1j64uIuXuHnpPv
	o+eIeOEYL47lgTVNuQBWV0QGgh8=
X-Received: by 2002:a17:907:b052:20b0:c1f:8145:820c with SMTP id a640c23a62f3a-c2129c1beeamr1154813466b.2.1787060153608;
        Tue, 18 Aug 2026 06:35:53 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2185b732a4sm162691866b.30.2026.08.18.06.35.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Aug 2026 06:35:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 18 Aug 2026 15:35:52 +0200
Message-Id: <DKS3YCAMWONO.2NVVH8IPARH7Y@gmail.com>
Cc: <loongarch@lists.linux.dev>, <linux-kernel@vger.kernel.org>, "Vincent
 Li" <vincent.mc.li@gmail.com>, <bpf@vger.kernel.org>
Subject: Re: [PATCH v1] LoongArch: Fix __smp_mb__{before,after}_atomic()
From: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
To: "Tiezhu Yang" <yangtiezhu@loongson.cn>, "Huacai Chen"
 <chenhuacai@kernel.org>
X-Mailer: aerc 0.21.0
References: <20260817035908.460-1-yangtiezhu@loongson.cn>
 <3103b3b4-5c0d-ed87-2e15-31a4d2289ec5@loongson.cn>
In-Reply-To: <3103b3b4-5c0d-ed87-2e15-31a4d2289ec5@loongson.cn>

On Tue Aug 18, 2026 at 3:28 PM CEST, Tiezhu Yang wrote:
> On 2026/8/17 =E4=B8=8A=E5=8D=8811:59, Tiezhu Yang wrote:
>> When testing the BPF selftest "sudo ./test_progs -t timer_lockup", there
>> is a kernel lockup and panic:
>
> ...
>
>> With this patch, the lockless "store-before-load" ordering is enforced b=
y
>> the DBAR instruction. The BPF timer_lockup selftest was stressed for 500=
0
>> consecutive loops on a physical LoongArch machine without encountering a=
ny
>> further lockups or warnings:
>>
>>    for i in {1..5000}; do sudo ./test_progs -t timer_lockup; done
>
> ...
>
>> diff --git a/arch/loongarch/include/asm/barrier.h b/arch/loongarch/inclu=
de/asm/barrier.h
>> index 4b663f197706..adfe343dfa65 100644
>> --- a/arch/loongarch/include/asm/barrier.h
>> +++ b/arch/loongarch/include/asm/barrier.h
>> @@ -57,8 +57,8 @@
>>   #define __WEAK_LLSC_MB		"			\n"
>>   #endif
>>
>> -#define __smp_mb__before_atomic()	barrier()
>> -#define __smp_mb__after_atomic()	barrier()
>> +#define __smp_mb__before_atomic()	__smp_mb()
>> +#define __smp_mb__after_atomic()	__smp_mb()
>>
>>   /**
>>    * array_index_mask_nospec() - generate a ~0 mask when index < size, 0=
 otherwise
>
> Hi all,
>
> To address the soft lockup while avoiding the performance overhead of
> executing two separate instructions, I think there is a more elegant
> way to fix this directly in the BPF core helper:
>
> We can replace atomic_inc() and smp_mb__after_atomic() with a single
> atomic_fetch_add() in bpf_timer_cancel(). This consolidates the logic
> into a single native atomic operation with full ordering, which not
> only guarantees the store-load order to eliminate the deadlock but
> also improves the performance for weak memory model architectures.
>
> Any thoughts on this approach?
>
> ```
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index c18f1e16edee..ee2b3a4dcc05 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -1591,9 +1591,7 @@ BPF_CALL_1(bpf_timer_cancel, struct bpf_async_kern
> *, async)
>           */
>          if (!cur_t)
>                  goto drop;
> -       atomic_inc(&t->cancelling);
> -       /* Need full barrier after relaxed atomic_inc */
> -       smp_mb__after_atomic();
> +       atomic_fetch_add(1, &t->cancelling);
>          inc =3D true;
>          if (atomic_read(&cur_t->cancelling)) {
>                  /* We're cancelling timer t, while some other timer
> callback is
> ```
>
> I tested the above diff, the BPF timer_lockup selftest was stressed
> for 5000 consecutive loops on a physical LoongArch machine without
> encountering any further lockups or warnings.

There is a full barrier in both cases. I don't know what performance improv=
ement
will be achieved by changing this. Don't you need to fix the lowering for
smp_mb__after_atomic() anyway? It's used in several other places in the ker=
nel.

>
> If you are OK with this change of bpf code, I will send a bpf patch
> later.
>
> Thanks,
> Tiezhu

