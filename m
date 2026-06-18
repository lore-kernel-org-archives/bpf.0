Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC5123DE45A
	for <bpf@vger.kernel.org>; Thu, 18 Jun 2026 09:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781776064; cv=none; b=U1t9yqQa3NL/MDMGBmxtNMcJ4dOrZ+pK321cIbYTJtMV9FMa7b58jAXF0loHTf5P/ILCo5NVb4QkLrWEsvjsE7At52qvKh34RDSNrQcJHQeYAZKtA0WauKJjEAny7Mc4IEG9uza9Olrr5+NCiRnBwQF9B+FA5oKoR/ES5jb0W+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781776064; c=relaxed/simple;
	bh=6yCH4rixQKXhkNsp2C8lqQr56BdhbwExcXpxtjQ8C+U=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=AepUgNoSrwCE4/46c24KcspP2Q0KZV1zP12Rg/iWBMe2Mw07Wl4F7h4YsFOYFfzS5+OZfPwUFNx6j+z2mkUuTrJ0yr7iWpKOy3bNSpfTeiUfYLGGYWdIODKmBPKuUrZ1LdGwVpsVakIxnR3SbftU2/39l8CSM0bFz8a3gevE3Og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BAbbevzp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BAbbevzp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70EE21F00A3D;
	Thu, 18 Jun 2026 09:47:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781776060;
	bh=IY2S1bXutB83YA35mztxOVVIFyKHlRI/wQkqCbGY9NE=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=BAbbevzpR6rH4OpyaewGvVFxkAhXcbh5CcYUI0WUnt7ztavGVC4VG5pm+olEPxFjq
	 113ONQnEKrjp77OAB9cJKFGqF3s1yrnrnk5YOTMOR5JYH0cdZpOCqY1qCmCaOQAQyd
	 Qa6tU7qmN568swn0IExwkt9RznuZIuEl9h7VIjKTdf73TCrI9sCfY4szZmkYe7dY65
	 3D/8skJsH/EhYaOEaurT/FDKz7VfQHZtLiaEEkunECSQJq1lKDQrHJVRwAsYdFdsxX
	 1SzSs6fclD8XC4hTiw0E15mvVzHbkExuILdUVqJAVyLtQ+zQdLYgJW9xChj8TTeNx2
	 NPeNCchhHTQMA==
Content-Type: multipart/mixed; boundary="===============8966313666933752693=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <40db9b9c3e32c6f24f119d4e4c7c27af76d19393d278e9aa6bb8006631f5d92d@mail.kernel.org>
In-Reply-To: <20260618085626.19633-5-emil@etsalapatis.com>
References: <20260618085626.19633-5-emil@etsalapatis.com>
Subject: Re: [PATCH bpf-next 4/5] selftests/bpf: Add arena-based bitmap data structure
From: bot+bpf-ci@kernel.org
To: emil@etsalapatis.com,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,memxor@gmail.com,daniel@iogearbox.net,eddyz87@gmail.com,mattbobrowski@google.com,song@kernel.org,emil@etsalapatis.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Thu, 18 Jun 2026 09:47:40 +0000 (UTC)

--===============8966313666933752693==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/libarena/include/libarena/bitmap.h b/tools/testing/selftests/bpf/libarena/include/libarena/bitmap.h
> new file mode 100644
> index 000000000000..11623a82e66a
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/libarena/include/libarena/bitmap.h
> @@ -0,0 +1,31 @@
> +#pragma once
> +
> +#define BITS_PER_BYTE		8

Should bitmap.h include an SPDX-License-Identifier header? The companion
implementation file bitmap.bpf.c includes the standard tags:

    // SPDX-License-Identifier: LGPL-2.1 OR BSD-2-Clause
    /*
     * Copyright (c) 2025-2026 Meta Platforms, Inc. and affiliates.
     * Copyright (c) 2025-2026 Emil Tsalapatis <emil@etsalapatis.com>
     */

while the header begins directly with #pragma once. Every other header in
this libarena series (common.h, asan.h, buddy.h) carries these tags.

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

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/27749630149
--===============8966313666933752693==--
