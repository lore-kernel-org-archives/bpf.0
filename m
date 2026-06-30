Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4305331F9B3
	for <bpf@vger.kernel.org>; Tue, 30 Jun 2026 21:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782855864; cv=none; b=jYE/pLqR3MMdsGjYcH+3phHqtpvFvrfC3lK2d1fmUC+lQR57BWpP9Dp5+zVmFOwOaOgXAPydryJdkBLntNJUCTPaVO2d4IJRqkgwqQut9UIaERJUEl7togXs+uSI1fbsex4PHv2Z4tzslx++w7dVG3m8pQoBALHtKCvR8WoUbyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782855864; c=relaxed/simple;
	bh=6wkGu6eTznIVCzjwreDJgGMwiKZHPI4G0NWpmB3az9c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KH7CoP7TEFs4OqmnAqTZzQwZuXS9HJHv2cZGcfQBH7fdPPtOPC5H/E918aZ/sNvRLS3cteKkQvolpE9ELc8k3sRpbC9Z5iNWwMwU0CIscolhQwcErm4DDEuixruNkS9/CmtLQ1fia1DfJ7VmSvs82JXSfkqqiRWVu9MeQg/GmDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=DdIIJ46F; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="DdIIJ46F"
Message-ID: <c09d9126-6de1-4aec-8755-ad34a1ab9dcf@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782855856;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D8UqCd0rCtV8qA7MxVLBmSkDIJH8LxXoE/ZkXrKylTA=;
	b=DdIIJ46F5bFE8BDeEOt+2DgCL1nJJcvwCv83gw64CbjvWhD5lAqZDxXskLa89S2yeBnH3C
	khErKEvwRhjdt1a6Yn4AxU+8hGqqXbgc1XKy55nu1Bb9zQAi0PhTPZFOkyyYypJvqatKde
	hv19TtBnCqVcRtnj/qag039xy/BfKzk=
Date: Tue, 30 Jun 2026 14:44:10 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 4/5] selftests/bpf: Add arena-based bitmap data
 structure
To: Emil Tsalapatis <emil@etsalapatis.com>, bpf@vger.kernel.org
Cc: ast@kernel.org, andrii@kernel.org, memxor@gmail.com,
 daniel@iogearbox.net, eddyz87@gmail.com, mattbobrowski@google.com,
 song@kernel.org
References: <20260618085626.19633-1-emil@etsalapatis.com>
 <20260618085626.19633-5-emil@etsalapatis.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <20260618085626.19633-5-emil@etsalapatis.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 6/18/26 1:56 AM, Emil Tsalapatis wrote:
> Add an arena-based word-aligned bitmap data struture. The
> structure is useful as a building block, e.g., sched-ext
> uses it to represent cpumask structures.
> 
> Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
> ---
>  .../bpf/libarena/include/libarena/bitmap.h    |  31 +++
>  .../selftests/bpf/libarena/src/bitmap.bpf.c   | 191 ++++++++++++++++++
>  2 files changed, 222 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/libarena/include/libarena/bitmap.h
>  create mode 100644 tools/testing/selftests/bpf/libarena/src/bitmap.bpf.c
> 
> diff --git a/tools/testing/selftests/bpf/libarena/include/libarena/bitmap.h b/tools/testing/selftests/bpf/libarena/include/libarena/bitmap.h
> new file mode 100644
> index 000000000000..11623a82e66a
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/libarena/include/libarena/bitmap.h
> @@ -0,0 +1,31 @@
> +#pragma once
> +
> +#define BITS_PER_BYTE		8
> +#define BYTES_TO_BITS(nb)	((nb) * BITS_PER_BYTE)
> +
> +#define BITS_PER_LONG		(sizeof(long) * BITS_PER_BYTE)
> +#define BITS_TO_LONGS(nr)	(((nr) + BITS_PER_LONG - 1) / BITS_PER_LONG)
> +#define BIT_MASK(nr)		(1UL << ((nr) % BITS_PER_LONG))
> +#define BIT_WORD(nr)		((nr) / BITS_PER_LONG)
> +
> +struct bitmap {
> +	u64 bits[0];
> +};
> +
> +struct bitmap __arena *bmp_alloc(size_t bits);
> +void bmp_free(struct bitmap __arena *bmp);
> +
> +void bmp_set_bit(u32 bit, struct bitmap __arena *bmp);
> +void bmp_clear_bit(u32 bit, struct bitmap __arena *bmp);
> +bool bmp_test_bit(u32 bit, struct bitmap __arena *bmp);
> +bool bmp_test_and_clear_bit(u32 bit, struct bitmap __arena *bmp);
> +
> +void bmp_clear(size_t bits, struct bitmap __arena *bmp);
> +void bmp_and(size_t bits, struct bitmap __arena *dst, struct bitmap __arena *src1, struct bitmap __arena *src2);
> +void bmp_or(size_t bits, struct bitmap __arena *dst, struct bitmap __arena *src1, struct bitmap __arena *src2);
> +bool bmp_empty(size_t bits, struct bitmap __arena *bmp);
> +void bmp_copy(size_t bits, struct bitmap __arena *dst, struct bitmap __arena *src);
> +
> +bool bmp_intersects(size_t bits, struct bitmap __arena *arg1, struct bitmap __arena *arg2);
> +bool bmp_subset(size_t bits, struct bitmap __arena *big, struct bitmap __arena *small);
> +void bmp_print(size_t bits, struct bitmap __arena *bmp);
> diff --git a/tools/testing/selftests/bpf/libarena/src/bitmap.bpf.c b/tools/testing/selftests/bpf/libarena/src/bitmap.bpf.c
> new file mode 100644
> index 000000000000..a8ca814aa0c8
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/libarena/src/bitmap.bpf.c
> @@ -0,0 +1,191 @@
> +// SPDX-License-Identifier: LGPL-2.1 OR BSD-2-Clause
> +/*
> + * Copyright (c) 2025-2026 Meta Platforms, Inc. and affiliates.
> + * Copyright (c) 2025-2026 Emil Tsalapatis <emil@etsalapatis.com>
> + */
> +
> +#include <libarena/common.h>
> +
> +#include <libarena/asan.h>
> +#include <libarena/bitmap.h>
> +
> +__weak
> +struct bitmap __arena *bmp_alloc(size_t bits)
> +{
> +	struct bitmap __arena *bmp;
> +	size_t size = BITS_TO_LONGS(bits) * sizeof(bmp->bits[0]);
> +
> +	/* Assume long-aligned masks. */
> +	if (bits % BITS_PER_LONG)
> +		return NULL;

I think this check may be dropped.

There is code below to handle non-aligned bits (bmp_last_word_mask
etc), but here we forbid them, so masking doesn't run.

And you mentioned in the cover that this is supposed to be used as
cpumask, but nr_cpu_ids is unlikely to be a multiple of 64, right?


> +
> +	bmp = (struct bitmap __arena *)arena_malloc(size);
> +	if (!bmp)
> +		return NULL;
> +
> +	bmp_clear(bits, bmp);
> +
> +	return bmp;
> +}
> +
> +__weak
> +void bmp_free(struct bitmap __arena *bmp)
> +{
> +	arena_free(bmp);
> +}
> +
> +__weak
> +void bmp_set_bit(u32 bit, struct bitmap __arena *bmp)
> +{
> +	bmp->bits[BIT_WORD(bit)] |= BIT_MASK(bit);
> +}
> +
> +__weak
> +void bmp_clear_bit(u32 bit, struct bitmap __arena *bmp)
> +{
> +	bmp->bits[BIT_WORD(bit)] &= ~BIT_MASK(bit);
> +}
> +
> +__weak
> +bool bmp_test_bit(u32 bit, struct bitmap __arena *bmp)
> +{
> +	return bmp->bits[BIT_WORD(bit)] & BIT_MASK(bit);
> +}
> +
> +__weak
> +bool bmp_test_and_clear_bit(u32 bit, struct bitmap __arena *bmp)
> +{
> +	u64 val = BIT_MASK(bit);
> +	u32 idx = BIT_WORD(bit);
> +	u64 actual;
> +
> +	do {
> +		u64 old = bmp->bits[idx];
> +
> +		if (!(old & val))
> +			return false;
> +
> +		u64 new = old & ~val;
> +		actual = cmpxchg(&bmp->bits[idx], old, new);

bmp_test_and_clear_bit() is atomic, but bmp_set_bit() and
bmp_clear_bit() aren't.

So the concurrent set/clear on the same word can lose updates (last
writer wins), right?  Only test_and_clear seems to be safe
cross-CPU. Are we missing test_and_set?

There is a doc on atomic bitops [1], and apparently in the kernel
there is a convention to have a non-atomic variant for each RMW atomic
operation, prefixed with '__', for example: test_and_clear_bit() and
__test_and_clear_bit().

Maybe libarena should follow the same convention?

[1] https://docs.kernel.org/core-api/wrappers/atomic_bitops.html


> +
> +		if (actual == old)
> +			return true;
> +
> +	} while (can_loop);
> +
> +	return false;
> +}
> +
> [...]

