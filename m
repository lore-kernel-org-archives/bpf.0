Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2405F3672B3
	for <bpf@vger.kernel.org>; Wed,  1 Jul 2026 04:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782880405; cv=none; b=LKygKkRdBbGay/bk5ChcJnfY1MsvVm2Rd174SYK0ZEjZGOhrvgVEQMktbDlYb3inDMuIaRbsLDPB0JmQbmvPMOE4UoqPW0SFvSsJMHJuAT/Cjrp37OEch6sW8Q2Kklz69+X6vI7kl/Hjtja3JuAXyD13n66a99Xhjg0X7l1jSuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782880405; c=relaxed/simple;
	bh=abaD1ySu7ipCnu/svldfXxvxiN40uIdlbvLF5VDxDm0=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=A7luBhw4gA+oDL8kMY89Wrz8cqtUgK4Os8fgBfAqbxzFq6Bk1bREhiFmeIjZkqpOFikHPixqkpqWncW7YkHOUtY0N29Esw978QJ7KnP08knVDou2YBap20BnAtJfcJBSYsuSOgf8bVVIFTA7J/afuHGg177q7iWHZQldvn8CNV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=fZ7vtUSS; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="fZ7vtUSS"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-5174a3d9598so857471cf.3
        for <bpf@vger.kernel.org>; Tue, 30 Jun 2026 21:33:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1782880403; x=1783485203; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7JFnhUGNiJGMgO/9UIZJZRQSjxvia9MLUfaUovDlDsw=;
        b=fZ7vtUSS6hxHUF4VSSNdD78sFcxRXppiveb9lVkMDjFSpPA7B/XilMrpbDDs7TmRmj
         EWdTEDq1GY60FZDkrkwS5blsnqbpQK7NwSfOlCPKgk8AsGQaPtJPbtMiaUIsjK5Kr2Fx
         KI0qBAIFo8pL2rmbYaG8QeRKOAHe5EU6PthEs4tw/s4sced9j/7gBufzTaX/0BzzfjnZ
         8RshE83DB7Q/iqtwajDSQe31D/R7GIIZIV0BsZDIZCh+g3VBHB6jL72TSnUNmSw4m2Sv
         zxsed1/WliZe+lrDdcmx2hf/nWrRukIqct6vwzBAMs5f41SEHA2IQSflTTkVXv8W6vRe
         ipYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782880403; x=1783485203;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7JFnhUGNiJGMgO/9UIZJZRQSjxvia9MLUfaUovDlDsw=;
        b=TISmXg1yP4vqVyeCZfpztoh3nRWczKhDXcqB4bi0bemtc5DvnT5XaXKqwVc6CdexuG
         Nnw6vGL8Gu3QzfCLIwxk9CyDf6zncv+FjE3EfZO6BCFbtMmiVLsrqZ8ZCzwo/X5b0ky+
         CTky9aGMsTZI6C2oudB1Pep6CjMTuORKNp/F/gHCDVoEKCWmgWtYOGd+07dTF+wIMOQ+
         jRvw9PnlxFYouyqCe4GfIKmoTyaG3LXXyUVL5+KJlBAKtQoJ7Nq1p3e2CaxFriQVegAh
         4in1TM+LWT7WMCjZl/qENtWtrnZXN9cOx84Vb4mOKXR6+3JisJ4+GzayBJbDsa38ap66
         b7Xg==
X-Forwarded-Encrypted: i=1; AFNElJ+A5IRbYVs66EfxputhC1JbqT2wd1NvXRkXHzlKLLKTzGmCzT/oMMpc4smrlyjHjq2Mmdw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyX1GwqcFeqE4XY1PMXTRAqBkGDjmrgDlcvwGNpoh+ssJVfaDEz
	UtBDyqqQ2VDwK8cp0mfIA5vM7MYaOLU2b/KTjqL74a535dwyNLUbR6+IaYLz07UC4SQ=
X-Gm-Gg: AfdE7clz7tPTmtU2v69aKnwh96yTO5NC6eU7gwwEwKhfTDECo6VhGHJb5kujZshPv0Z
	22uLrZB3Ogc98yonPZzHCL0LCFfRWkllcalNxzYCGZSCkzbOzaRJvOCoQq0oAhnmDl2/TMm6k69
	55IGaR/Gw9fEgO0MwyH2fu5TCt6HdK6Fu0Qm2cfuNN7Cd4m0QVgewKsdDWZfP05hgrax6/rlbNv
	hzyGb9sC55W1jd4QgDSHXGgzpvCD5XkaM2kdTKeqnQGlNz/M/pzYXfGwIIIfiws0f8oO+uNzHk8
	I3nB3KomjCCWrMcBSkbCspiJ51PFHr0zSjCsBraF/V6u0pu8aP6uWCyILkXb1yem5q5tBmFaS9a
	t1W+JehbAf0AKfWpzqg0ahplyMjPbhYoRQCQhijyf/swLEqpURdnpsUHWqxUWo/+mtaWQPLYFsl
	C4KIm/mTrIcAM=
X-Received: by 2002:a05:622a:994:b0:51a:8c97:9378 with SMTP id d75a77b69052e-51c26b4f1a5mr1620561cf.64.1782880403072;
        Tue, 30 Jun 2026 21:33:23 -0700 (PDT)
Received: from localhost ([198.58.242.173])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8f3612d3c32sm10102926d6.32.2026.06.30.21.33.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jun 2026 21:33:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 01 Jul 2026 00:33:22 -0400
Message-Id: <DJMYCTO2998L.263329XHVJN1B@etsalapatis.com>
Cc: <ast@kernel.org>, <andrii@kernel.org>, <memxor@gmail.com>,
 <daniel@iogearbox.net>, <eddyz87@gmail.com>, <mattbobrowski@google.com>,
 <song@kernel.org>
Subject: Re: [PATCH bpf-next 4/5] selftests/bpf: Add arena-based bitmap data
 structure
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Ihor Solodrai" <ihor.solodrai@linux.dev>, "Emil Tsalapatis"
 <emil@etsalapatis.com>, <bpf@vger.kernel.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260618085626.19633-1-emil@etsalapatis.com>
 <20260618085626.19633-5-emil@etsalapatis.com>
 <c09d9126-6de1-4aec-8755-ad34a1ab9dcf@linux.dev>
In-Reply-To: <c09d9126-6de1-4aec-8755-ad34a1ab9dcf@linux.dev>

On Tue Jun 30, 2026 at 5:44 PM EDT, Ihor Solodrai wrote:
> On 6/18/26 1:56 AM, Emil Tsalapatis wrote:
>> Add an arena-based word-aligned bitmap data struture. The
>> structure is useful as a building block, e.g., sched-ext
>> uses it to represent cpumask structures.
>>=20
>> Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
>> ---
>>  .../bpf/libarena/include/libarena/bitmap.h    |  31 +++
>>  .../selftests/bpf/libarena/src/bitmap.bpf.c   | 191 ++++++++++++++++++
>>  2 files changed, 222 insertions(+)
>>  create mode 100644 tools/testing/selftests/bpf/libarena/include/libaren=
a/bitmap.h
>>  create mode 100644 tools/testing/selftests/bpf/libarena/src/bitmap.bpf.=
c
>>=20
>> diff --git a/tools/testing/selftests/bpf/libarena/include/libarena/bitma=
p.h b/tools/testing/selftests/bpf/libarena/include/libarena/bitmap.h
>> new file mode 100644
>> index 000000000000..11623a82e66a
>> --- /dev/null
>> +++ b/tools/testing/selftests/bpf/libarena/include/libarena/bitmap.h
>> @@ -0,0 +1,31 @@
>> +#pragma once
>> +
>> +#define BITS_PER_BYTE		8
>> +#define BYTES_TO_BITS(nb)	((nb) * BITS_PER_BYTE)
>> +
>> +#define BITS_PER_LONG		(sizeof(long) * BITS_PER_BYTE)
>> +#define BITS_TO_LONGS(nr)	(((nr) + BITS_PER_LONG - 1) / BITS_PER_LONG)
>> +#define BIT_MASK(nr)		(1UL << ((nr) % BITS_PER_LONG))
>> +#define BIT_WORD(nr)		((nr) / BITS_PER_LONG)
>> +
>> +struct bitmap {
>> +	u64 bits[0];
>> +};
>> +
>> +struct bitmap __arena *bmp_alloc(size_t bits);
>> +void bmp_free(struct bitmap __arena *bmp);
>> +
>> +void bmp_set_bit(u32 bit, struct bitmap __arena *bmp);
>> +void bmp_clear_bit(u32 bit, struct bitmap __arena *bmp);
>> +bool bmp_test_bit(u32 bit, struct bitmap __arena *bmp);
>> +bool bmp_test_and_clear_bit(u32 bit, struct bitmap __arena *bmp);
>> +
>> +void bmp_clear(size_t bits, struct bitmap __arena *bmp);
>> +void bmp_and(size_t bits, struct bitmap __arena *dst, struct bitmap __a=
rena *src1, struct bitmap __arena *src2);
>> +void bmp_or(size_t bits, struct bitmap __arena *dst, struct bitmap __ar=
ena *src1, struct bitmap __arena *src2);
>> +bool bmp_empty(size_t bits, struct bitmap __arena *bmp);
>> +void bmp_copy(size_t bits, struct bitmap __arena *dst, struct bitmap __=
arena *src);
>> +
>> +bool bmp_intersects(size_t bits, struct bitmap __arena *arg1, struct bi=
tmap __arena *arg2);
>> +bool bmp_subset(size_t bits, struct bitmap __arena *big, struct bitmap =
__arena *small);
>> +void bmp_print(size_t bits, struct bitmap __arena *bmp);
>> diff --git a/tools/testing/selftests/bpf/libarena/src/bitmap.bpf.c b/too=
ls/testing/selftests/bpf/libarena/src/bitmap.bpf.c
>> new file mode 100644
>> index 000000000000..a8ca814aa0c8
>> --- /dev/null
>> +++ b/tools/testing/selftests/bpf/libarena/src/bitmap.bpf.c
>> @@ -0,0 +1,191 @@
>> +// SPDX-License-Identifier: LGPL-2.1 OR BSD-2-Clause
>> +/*
>> + * Copyright (c) 2025-2026 Meta Platforms, Inc. and affiliates.
>> + * Copyright (c) 2025-2026 Emil Tsalapatis <emil@etsalapatis.com>
>> + */
>> +
>> +#include <libarena/common.h>
>> +
>> +#include <libarena/asan.h>
>> +#include <libarena/bitmap.h>
>> +
>> +__weak
>> +struct bitmap __arena *bmp_alloc(size_t bits)
>> +{
>> +	struct bitmap __arena *bmp;
>> +	size_t size =3D BITS_TO_LONGS(bits) * sizeof(bmp->bits[0]);
>> +
>> +	/* Assume long-aligned masks. */
>> +	if (bits % BITS_PER_LONG)
>> +		return NULL;
>
> I think this check may be dropped.
>
> There is code below to handle non-aligned bits (bmp_last_word_mask
> etc), but here we forbid them, so masking doesn't run.
>
> And you mentioned in the cover that this is supposed to be used as
> cpumask, but nr_cpu_ids is unlikely to be a multiple of 64, right?
>
>

How about keeping the check here and removing the unaligned bit handling
below? We don't test for it either, and I can't currently think of any
good use cases for it. So we can make sure here that the caller knows
the bit size should be word aligned.

>> +
>> +	bmp =3D (struct bitmap __arena *)arena_malloc(size);
>> +	if (!bmp)
>> +		return NULL;
>> +
>> +	bmp_clear(bits, bmp);
>> +
>> +	return bmp;
>> +}
>> +
>> +__weak
>> +void bmp_free(struct bitmap __arena *bmp)
>> +{
>> +	arena_free(bmp);
>> +}
>> +
>> +__weak
>> +void bmp_set_bit(u32 bit, struct bitmap __arena *bmp)
>> +{
>> +	bmp->bits[BIT_WORD(bit)] |=3D BIT_MASK(bit);
>> +}
>> +
>> +__weak
>> +void bmp_clear_bit(u32 bit, struct bitmap __arena *bmp)
>> +{
>> +	bmp->bits[BIT_WORD(bit)] &=3D ~BIT_MASK(bit);
>> +}
>> +
>> +__weak
>> +bool bmp_test_bit(u32 bit, struct bitmap __arena *bmp)
>> +{
>> +	return bmp->bits[BIT_WORD(bit)] & BIT_MASK(bit);
>> +}
>> +
>> +__weak
>> +bool bmp_test_and_clear_bit(u32 bit, struct bitmap __arena *bmp)
>> +{
>> +	u64 val =3D BIT_MASK(bit);
>> +	u32 idx =3D BIT_WORD(bit);
>> +	u64 actual;
>> +
>> +	do {
>> +		u64 old =3D bmp->bits[idx];
>> +
>> +		if (!(old & val))
>> +			return false;
>> +
>> +		u64 new =3D old & ~val;
>> +		actual =3D cmpxchg(&bmp->bits[idx], old, new);
>
> bmp_test_and_clear_bit() is atomic, but bmp_set_bit() and
> bmp_clear_bit() aren't.
>
> So the concurrent set/clear on the same word can lose updates (last
> writer wins), right?  Only test_and_clear seems to be safe
> cross-CPU. Are we missing test_and_set?
>

Yes, set/clear are not atomic and we are missing test and set. I can add
those.

> There is a doc on atomic bitops [1], and apparently in the kernel
> there is a convention to have a non-atomic variant for each RMW atomic
> operation, prefixed with '__', for example: test_and_clear_bit() and
> __test_and_clear_bit().
>
> Maybe libarena should follow the same convention?
>

Yeah let's do that. AFAIK we only have cmpxchg for atomics so I'll use
it for the logic. It's expensive, but I don't think we can generate
anything like x86's btsl.

> [1] https://docs.kernel.org/core-api/wrappers/atomic_bitops.html

>
>
>> +
>> +		if (actual =3D=3D old)
>> +			return true;
>> +
>> +	} while (can_loop);
>> +
>> +	return false;
>> +}
>> +
>> [...]

