Received: from mail-wm2-f7.google.com (mail-wm2-f7.google.com [74.125.225.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4DF92BEC55
	for <bpf@vger.kernel.org>; Thu, 20 Aug 2026 19:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787254086; cv=none; b=I52ukIxv1AtzMmOK/sdc7ndSGY6AQRypPlWLTy380AFLbRnT0o0qxM3AB57flM6Kx3FseHgDookfyH8SDdHB+zU2pU9T+3tpDq2/0zpI8xPUtZgE0ZupAk0w25TkNyJwvnhszpuYnd+DQT3kDw+3i4R32PTzashPOx2Eyv8+0QM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787254086; c=relaxed/simple;
	bh=/2golh+DZj7e+88AlqhMTcnLZK5ZchvAMK71sJ38rAU=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=h6D2cVSwCSpr/funaGy6nyrPwePp+wx8gs5b+01bwvtmxtzBI2Q0ZX4VXTx2aIEyxCkRnWKIr2A7hyWjL88NwXmtlahDIF/nJvv8AyBGVGG2AZE9SW/L9RVnOjahZ3BLc3gN6lnSerEdP2ScyeDV2h4FGqk8ywZgq1QnU6o5+Ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NyM1wRFn; arc=none smtp.client-ip=74.125.225.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NyM1wRFn"
Received: by mail-wm2-f7.google.com with SMTP id 5b1f17b1804b1-49987f48039so412165e9.0
        for <bpf@vger.kernel.org>; Thu, 20 Aug 2026 12:28:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787254082; x=1787858882; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=uemxqtGhV2C7D/1S+JK/ZhHv3WUnvR7x5H3CzBPQF2w=;
        b=NyM1wRFnyyoqfuq98TY024RMy70LZOh5TovyNRYpkzWdUtQtOAyZIo1yL2EZSVZNTL
         goNZeA2gvPYgqwOJ1VYDMwqn9XfMzBUYf2YKoYQh5VRacgPqwjjo4hig0qo86ITl87HG
         JJja70RNzF8uLGNaGuRFIe8emFPFUoKFcDHrGyf+naVFsbI4OxE5deGvXFf/uDBQXeuE
         gZeiC5LQqP5/IA6oGuOmae3dmLhtxL+8Zsjq1L26RXS1ekU4U4/J4LoZtb13UpNSeqpy
         BONl7j9o3+fIx4W8mk8ZAZhlOzqIV7sEjtP/mvc6Jd5Os3AjZ6jVXDbqTixg9iov/Ck/
         KUBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787254082; x=1787858882;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uemxqtGhV2C7D/1S+JK/ZhHv3WUnvR7x5H3CzBPQF2w=;
        b=PvILE8DwORTSmkZT1+HgirAoNNRdh41ckBbJueC3rddgS8YzHjpFL0qgu8MoNzYCuG
         M8mLASjGsfwRu0enx/R5qa/KyTUdYj2wVORyijTwj9TPT4CKqJNpunup4t1Gsu7/hfMb
         hcP+oYay664qDJmT10nUAcoijOMBlCsf4OCftKk0QtB5zEE+cEJFmIWFsj4mLhK8HJjW
         3rqahFoQ/THmikK3QMbhXJ7ZM0lrIF7fraU59Xubx1hK3IUsmzUPFKscu2pVPzKubzqD
         KWRMSdaDyfOfNFWzdq3RRLqZ3LOp03BO0pmlzumpvjwKGiSBE5eJ5p2L6TwfIZrkiTJh
         0eVA==
X-Gm-Message-State: AOJu0YxFIitB31r/nSWrFyubaWsupz4djCLWI/2h3n2bLVcFhUcrARxf
	PqudteX5f/B41eqQWCTSyySE5RVW5CGZA4LVxjZwju2MDZI1NnIs/rRv
X-Gm-Gg: AR+sD11s04pZLyyWr8yCH84blJ9hAd0wcIaV7tBKreZYdZNNfWH1Gb5OqPLHMB6D8iI
	BQ0TuVldYAj6kHTIhTzcRcspMyW1NwZBrbGWCCW0x28JSP4sJdpm6Prcq4a8/RbnwSFYoPsb4NA
	SEet7csS8umoBXrocFnEx8M4H5dKxX2BKfug4c+06SXxjfvwP36Xue04PXvxXTBd8f9ip2ZGR2+
	SWLPMvK/dME5ICc/F2xG2VH8/Q8oOQbX1sVlyVxEhWlxRdKJ+9SVWolHZxExuEq8A6EDLND+2JG
	vfyM0T/XQC9upaw5NFRz33WCwfjg5gRyh2reRz3yiNG7vGmjyH9GqsCIcF4rLoAjA7U9Kw4luVA
	4UIozVeqMS5rTYuRb57gMD35j/nCR1U/QrxaNvsecbVc11dhFnJqoQKElewl2D/s4aPs8LmRwf+
	CmPiiygWOU/z64uTRrCKC6HIFCabu3+jH5QNI6XEl2CtNNCRwOcx0pq3jGlrnUBI1EleMcLdP/j
	g7beNlB14Qz5iKtPoiUIQKfjzlpqzVlR4YftdYRuSTi/glY4krvffeLgX5d9X9ryvdXtUq2leln
	nWVBeE3+gmvBTF8p4KenFyjSmtA=
X-Received: by 2002:a05:600c:474a:b0:499:b65d:124f with SMTP id 5b1f17b1804b1-499b845709amr19655495e9.11.1787254081474;
        Thu, 20 Aug 2026 12:28:01 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482b14d05a6sm16104141f8f.35.2026.08.20.12.28.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Aug 2026 12:28:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 20 Aug 2026 21:28:00 +0200
Message-Id: <DKU0P1YGJWHF.3PPZPRDGZX4I3@gmail.com>
Cc: <bpf@vger.kernel.org>
Subject: Re: [PATCH 3/6] selftests/bpf: libarena: Disable IRQs during
 allocation
From: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
To: <sashiko-reviews@lists.linux.dev>, "Emil Tsalapatis"
 <emil@etsalapatis.com>
X-Mailer: aerc 0.21.0
References: <20260817191616.11071-1-emil@etsalapatis.com>
 <20260817191616.11071-4-emil@etsalapatis.com>
 <20260817192833.63B111F000E9@smtp.kernel.org>
In-Reply-To: <20260817192833.63B111F000E9@smtp.kernel.org>

On Mon Aug 17, 2026 at 9:28 PM CEST, sashiko-bot wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
>
> Pre-existing issues:
> - [High] Unhandled lock failure path in `buddy_alloc` and `buddy_alloc_fr=
om_new_chunk` leaks newly allocated memory chunks.
> --
>
> --- Patch [3]: [PATCH 3/6] selftests/bpf: libarena: Disable IRQs during a=
llocation ---
> commit 33cf3ed979bbaa281367dbd5d393dc12a91a1af9
> Author: Emil Tsalapatis <emil@etsalapatis.com>
>
> selftests/bpf: libarena: Disable IRQs during allocation
>
> This commit updates the buddy allocator in libarena to use IRQ-saving
> spinlocks to prevent ABBA deadlocks. These deadlocks were observed with
> sched_ext schedulers when an IRQ interrupts an allocation and subsequentl=
y
> attempts to take runqueue locks.
>
>> diff --git a/tools/testing/selftests/bpf/libarena/src/buddy.bpf.c b/tool=
s/testing/selftests/bpf/libarena/src/buddy.bpf.c
>> index c674ee5cfcc1d..2490ab1396de0 100644
>> --- a/tools/testing/selftests/bpf/libarena/src/buddy.bpf.c
>> +++ b/tools/testing/selftests/bpf/libarena/src/buddy.bpf.c
>
> [ ... ]
>
>> @@ -730,9 +727,10 @@ static u64 buddy_alloc_from_existing_chunks(struct =
buddy __arena *buddy, int ord
>>   */
>>  static u64 buddy_alloc_from_new_chunk(struct buddy __arena *buddy, stru=
ct buddy_chunk __arena *chunk, int order)
>>  {
>> +	unsigned long flags;
>>  	u64 address;
>>
>> -	if (buddy_lock(buddy))
>> +	if (buddy_lock(buddy, flags))
>>  		return (u64)NULL;
>
> [Severity: High]
> This isn't a bug introduced by this patch, but does this leak the newly
> allocated arena chunk if the lock acquisition fails?
>
> When buddy_alloc() needs more memory, it allocates a chunk and passes it
> here:
>
> buddy_alloc()
>   chunk =3D buddy_chunk_get(buddy);
>   if (chunk)
>     address =3D buddy_alloc_from_new_chunk(buddy, chunk, order);
>
> If buddy_lock() fails in buddy_alloc_from_new_chunk() (for example, retur=
ning
> an error like -ETIMEDOUT under heavy contention), it returns NULL without
> linking the new chunk to buddy->first_chunk.
>
> The NULL return then propagates up to buddy_alloc(), which discards the c=
hunk
> pointer completely without freeing it. Since BPF MCS spinlocks can fail u=
nder
> heavy task load, could this predictably exhaust arena memory?
>
> Should this error path call bpf_arena_free_pages() on the orphaned chunk
> before returning?
>

The rest are meh, but this one seems plausible. Please check and follow up.

>>
>>
>> @@ -745,7 +743,7 @@ static u64 buddy_alloc_from_new_chunk(struct buddy _=
_arena *buddy, struct buddy_
>>
>>  	address =3D buddy_chunk_alloc(buddy->first_chunk, order);
>>
>> -	buddy_unlock(buddy);
>> +	buddy_unlock(buddy, flags);
>>
>>  	return (u64)address;
>>  }
>
> [ ... ]

