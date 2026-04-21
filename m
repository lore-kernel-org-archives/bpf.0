Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C8EF36F41C
	for <bpf@vger.kernel.org>; Tue, 21 Apr 2026 20:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776804516; cv=none; b=BtHn4rieSeyyoN1JTjTbuKplrbDa6VW+phSc34N9bGRfFkWt8mpSevF2GWAE1RsweRnEFeBX7GT1k4e8XGiynop2NFiDM54Cii89JuDqvT/CR5GC2V7YmRzq5keNttWemkybtcbMOZuzCehNXjVqyg/jwBWMY4u9Pg+Ek0ql8Wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776804516; c=relaxed/simple;
	bh=zyUQKLtuuZ8Xq0JJQUzcAGnh89Yj5OpAMx5tl5GB7b0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Pt+FHMY2vw+ab9pmfoQw+yISq+nytOhrYQ4MQo3Y/qvVHTdOLCo02OI0D57IMUm/6NehEAy26CpA+1PyuK6AdojRR7K2AEke4Y3M7eBZGGL+irWM+aspQ62ls0IQpCBQTnn9UCRyFV3b2rshpe6FvEXQBPole4kz85UdEGpgps8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qflV/ucP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qflV/ucP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BE26C2BCB0;
	Tue, 21 Apr 2026 20:48:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776804516;
	bh=zyUQKLtuuZ8Xq0JJQUzcAGnh89Yj5OpAMx5tl5GB7b0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=qflV/ucPeHazZCbve9k+X1JqZTNpBteFpDW2z0QOA+g2hVYBbu8oaavt0EZhivcum
	 heUXYfhNIL+ZI0TfAKiKxqceHa/v28rt/IMfV25eUNKUkyVXcv7iR8wkh1UgCd6mT4
	 pp7BMjZRXg35Bj9WIuZ4jvQu44jlWZ4n/kmL9R/l4osQuen31WixLVAxMzfbtels6d
	 br5d9qJBhaAiHU9bFEJlo2djFjXvRyV/bz129OUljtJ52VmQhwOc4koYM4h+BhK/Va
	 N3wMSQFDzxzYTenjT1J+LOrC6TbsyptZsGDr9kYQyFZ1t/gHxYPCqWh1+Px0ONdQsf
	 kRqw5tNPAGNjA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v8 4/8] selftests/bpf: Add arena ASAN runtime
 to libarena
Reply-To: sashiko@lists.linux.dev
To: "Emil Tsalapatis" <emil@etsalapatis.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260421165037.4736-5-emil@etsalapatis.com>
References: <20260421165037.4736-5-emil@etsalapatis.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 21 Apr 2026 20:48:35 +0000
Message-Id: <20260421204836.0BE26C2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Sashiko AI review found 5 potential issue(s):
- [High] Silent failure and incomplete shadow map updates in `asan_memset` =
and `first_nonzero_byte` due to BPF loop limits.
- [High] `__asan_memcpy`, `__asan_memmove`, and `__asan_memset` stubs silen=
tly drop memory operations, causing uninitialized data usage.
- [High] Concurrent execution of `asan_init` corrupts the shadow map base a=
ddress due to a TOCTOU race condition.
- [High] ASAN memory access hooks lack runtime initialization checks, leadi=
ng to false positives and invalid memory access.
- [Medium] Missing BTF anchors for variable-sized and intrinsic ASAN memory=
 stubs.
--

commit b77770f7adb86bf4a4f23e524cb1dfc5e9e8a79e
Author: Emil Tsalapatis <emil@etsalapatis.com>

selftests/bpf: Add arena ASAN runtime to libarena

This adds an address sanitizer (ASAN) runtime to the arena library.
The ASAN runtime implements functions injected into BPF binaries by LLVM
sanitization when ASAN is enabled.

> diff --git a/tools/testing/selftests/bpf/libarena/include/asan.h b/tools/=
testing/selftests/bpf/libarena/include/asan.h
> new file mode 100644
> index 0000000000000..eb9fc69d9eb04
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/libarena/include/asan.h
[ ... ]
> +/*
> + * Force LLVM to emit BTF information for the stubs,
> + * because the ASAN pass in LLVM by itself doesn't.
> + */
> +#define ASAN_LOAD_STORE_SIZE(size)		\
> +	__asan_store##size,			\
> +	__asan_store##size##_noabort,		\
> +	__asan_load##size,			\
> +	__asan_load##size##_noabort,		\
> +	__asan_report_store##size,		\
> +	__asan_report_store##size##_noabort,	\
> +	__asan_report_load##size,		\
> +	__asan_report_load##size##_noabort
> +
> +__attribute__((used))
> +static void (*__asan_btf_anchors[])(intptr_t) =3D {
> +	ASAN_LOAD_STORE_SIZE(1),
> +	ASAN_LOAD_STORE_SIZE(2),
> +	ASAN_LOAD_STORE_SIZE(4),
> +	ASAN_LOAD_STORE_SIZE(8),
> +};

Are there missing anchors for __asan_loadN, __asan_storeN, __asan_memcpy,
__asan_memmove, and __asan_memset here? The LLVM ASAN pass can inject
calls to these for variable-sized or intrinsic struct accesses, which
could lead to BPF linking failures if their BTF information is stripped.

> diff --git a/tools/testing/selftests/bpf/libarena/src/asan.bpf.c b/tools/=
testing/selftests/bpf/libarena/src/asan.bpf.c
> new file mode 100644
> index 0000000000000..7e0aaab3803f9
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/libarena/src/asan.bpf.c
[ ... ]
> +__weak int asan_memset(s8a __arg_arena *dst, s8 val, size_t size)
> +{
> +	size_t i;
> +
> +	for (i =3D zero; i < size && can_loop; i++)
> +		dst[i] =3D val;
> +
> +	return 0;
> +}

Does this silently leave the remainder of the shadow memory unpoisoned if
the loop terminates early due to the can_loop BPF runtime limit? If a
large allocation causes this to hit the budget, returning 0 might cause
callers like asan_unpoison to proceed, leading to false positives on
subsequent accesses to the remainder.

[ ... ]
> +static __always_inline u64 first_nonzero_byte(u64 addr, size_t size)
> +{
> +	while (size && can_loop) {
> +		if (unlikely(*(s8a *)addr))
> +			return addr;
> +		addr +=3D 1;
> +		size -=3D 1;
> +	}
> +
> +	return SHADOW_ALL_ZEROES;
> +}

Similarly, could this return SHADOW_ALL_ZEROES inappropriately if the loop
terminates early from the can_loop limit? This might mask use-after-free
bugs if the scan is incomplete.

[ ... ]
> +static __always_inline bool check_region_inline(intptr_t ptr, size_t siz=
e,
> +						u32 flags)
> +{
> +	s8a *addr =3D (s8a *)(u64)ptr;
> +	bool is_poisoned, is_valid;

Should this function check if the ASAN runtime has been initialized,
perhaps by calling asan_ready()? If a BPF program executes before
userspace invokes asan_init, __asan_shadow_memory_dynamic_address would
remain 0. This could cause the checks to read from offset 0 in user memory
instead of the shadow map, leading to unpredictable false positives.

[ ... ]
> +/*
> + * We do not currently have memcpy/memmove/memset intrinsics
> + * in LLVM. Do not implement sanitization.
> + */
> +void *__asan_memcpy(void *d, const void *s, size_t n)
> +{
> +	arena_stderr("ASAN: Unexpected %s call", __func__);
> +	return NULL;
> +}
> +
> +void *__asan_memmove(void *d, const void *s, size_t n)
> +{
> +	arena_stderr("ASAN: Unexpected %s call", __func__);
> +	return NULL;
> +}
> +
> +void *__asan_memset(void *p, int c, size_t n)
> +{
> +	arena_stderr("ASAN: Unexpected %s call", __func__);
> +	return NULL;
> +}

If the LLVM ASAN pass intercepts intrinsic memory operations and replaces
them with these external calls, will the actual memory operations be
completely dropped? Returning NULL here without performing the copy or set
might leave the destination structs uninitialized, which could corrupt
application data.

[ ... ]
> +SEC("syscall")
> +__weak __noasan int asan_init(struct asan_init_args *args)
> +{
> +	u64 globals_pages =3D args->arena_globals_pages;
> +	u64 all_pages =3D args->arena_all_pages;
> +	u64 shadow_map, shadow_pgoff;
> +	u64 shadow_pages;
> +
> +	if (asan_inited)
> +		return 0;
[ ... ]
> +	shadow_map =3D (u64)bpf_arena_alloc_pages(
> +		&arena, (void __arena *)__asan_shadow_memory_dynamic_address,
> +		shadow_pages, NUMA_NO_NODE, 0);
> +	if (!shadow_map) {
> +		arena_stderr("Could not allocate shadow map\n");
> +
> +		__asan_shadow_memory_dynamic_address =3D 0;
> +
> +		return -ENOMEM;
> +	}
> +
> +	asan_inited =3D true;
> +
> +	return 0;
> +}

Is there a TOCTOU race condition here that could corrupt the shadow map
base address?

If two userspace threads bypass the if (asan_inited) check simultaneously,
both could attempt bpf_arena_alloc_pages() at the same target address. The
second thread's allocation would fail, taking the error path and setting
__asan_shadow_memory_dynamic_address to 0, while the first thread might
have already set asan_inited to true.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260421165037.4736=
-1-emil@etsalapatis.com?part=3D4
