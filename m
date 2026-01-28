Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4BD6280331
	for <bpf@vger.kernel.org>; Wed, 28 Jan 2026 02:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769567257; cv=pass; b=j9AQzqqwBIlFbl4SdNKVieau1ZymAaCpqdey3CI5mgZJ1gh4jiy3ov73Mx7BvLi2RSSN0I9daIIsOiHAGtzGebgXgjVcAIKzmc+4iukMBALyxsG45SGbv2plnwgvoIwhFMrgECRNGJGl2GFEBwso//iuXDSKGEK1AB/cW5Km4GA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769567257; c=relaxed/simple;
	bh=Z4Q3HZh8f4WhsbyZSOXDGdsA4LJDtLlMul2VOmmrkUM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bo8vMjZzesZ7DkT58EyPiFsXfK4RYRncadwQ1jyHqx5OX9fL0sgEc7qiTyWn3YLpASerfmw8ctEliSqzstHDkZwiMT092olEL1tRVTwi291812RveCYdYC5Jx8RKnh1iFxk/jZJ41ymu1csN4p8IKj08HYFytPSpvyaMF4sfe3o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Upcje++P; arc=pass smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Upcje++P"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4806e0f6b69so1716005e9.3
        for <bpf@vger.kernel.org>; Tue, 27 Jan 2026 18:27:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769567254; cv=none;
        d=google.com; s=arc-20240605;
        b=dABFxglgnO1oVL0HECLjga6CNUF2QIEUHl3yZziOzfkGRcCtAPykyrp9jxU9jRjzbc
         sjk1ngWWdSlt2LRnp+pd0AHvqCAu9v+D+FU+fN1is6JXv61TfzatD8XK6PBGwwg81YWA
         0NhXSgLReJY5WUmfu8HlqsPZogkICc0vQ9UoBMIgqE2mZGXqNGJt/CBUPlHh3M0U6gCS
         eIKTMRGYRgPcrtAqPheTQctwRNm0uxG9BaUfAXoXYAkN0oa5jtC9Tx9DXTxxYApNLqU7
         j7jm6egl4UqwNENHddZMH56TsNnjoTF4GuF4YxHCzSdfZ2K8fqJnv/MV2+gTqVe+dTnj
         JNqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Gov23pzdl7hI2wHgOIFiQFVk6nsJ7fj6VSSOhXFOsaw=;
        fh=07919j3mEGtUJ+mScCnPzO16vurW6cKq9ZaYr312Wzs=;
        b=IT85WeYXmbGEsbPDImkvGxHu+gejUs31/TTi1P29w6J/Kdwcql9EIzNYDDpnGKuO5E
         darxPvjArnm1WIvYYahsRqAfT42/A4wbfwa8c74yH63tC8tO6KM9LuK0Cwnw1RW+kvZI
         KXHbRoI11a37pSURcjsDiM9nFRzOFqI6rS8yw3zL9cCLBtTDQa/WQKxygIkQJqgUelcs
         Nvde7InFIOiWppwk97hJL77JIT3/PfHiJH+mjdoNHHBSSGNAxkQ5JKwPtzkTxlnbyVzR
         9mBOCY9uyBSGvDeh3sM0g3oVzuyGJWljLDMTtDAxkJ4FmCvhc1ZrVLxkdphgKCKnpbWX
         ajyg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769567254; x=1770172054; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gov23pzdl7hI2wHgOIFiQFVk6nsJ7fj6VSSOhXFOsaw=;
        b=Upcje++PHYpvVJUwDC6DolZv6iOXvZMhuwQXAc5aWUixO44Mk29epcdlNBKAr+RX7Y
         vF25C2K59nZHNaRTt+s4Bz+iKv15x8N55cHxxbMyYmu832tW+P2huYcfd0dnWXz/wIDr
         cPZQLDAzfACh7aIVwmkh4DcZoNBZ3/SMF0fyY8lgb5eFjGCgZda2iT9Vh/Oa2PbxD7p3
         x65VMoUz+t/1wWB+HFJ1VmXwmeHvm6gIs3wrwiMaZO5Of+UHAMretlW5g6LjYUsLSLi0
         V7zV5rQZ98XZguxWbBdmSMdyv1lTPKxGInT12XIDnML6JP4A2Ade9NS0AfuwoF6bJ+Tq
         aAiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769567254; x=1770172054;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Gov23pzdl7hI2wHgOIFiQFVk6nsJ7fj6VSSOhXFOsaw=;
        b=FT1JdwEOY3X1b9A0BSJ1qOZjj513BIJNQqyyaemYSorXDnTgivh7ByNz2DegvwpncO
         gr/TjkP/ZphUE0f6LZ/txEZ9LW6bPjZ0fr2iJBTh6uKI2moqBZcQVW02ZRwapUNvIxpL
         8pxVE4ORtwQ9V4Hhs2ePEBRq67J8N6FuB/W7aD0dnTIS+Cxs5UPDTYyfhaKgLKK4OdX7
         8Qdmp7X8fUo9cdeD1FdFnc+kbrfg6/8369kd4r2Qg75AdHMZWmXljRC9V51mtxtV+yFk
         WU1ZYghHG/wuxLFXGlpV57yy6bn6xX8jAvt6xdAyFhd+jSeLz/waIYlQEJfOQ7tJtM1g
         ZO6A==
X-Gm-Message-State: AOJu0Yz3YRtFyjU7bP6FzIMxCKIKIGP2rgcEuLwV8rgSZtTUUthVIF81
	r22jwjG/3m7c2dwXXpQDOdLfVB27k1hKRxazfWabdfIUXKLDs4QRs9wlx86W+2W5ZzYp5fMOENJ
	snJ7+CMPW6jmemM9mUxhCGaHwDi4sypA=
X-Gm-Gg: AZuq6aKl2VkZdLTkHgvWEWhg8IbPmwH+YWQuuGydY/cVP3cTKJsvqiZSisgdi60evto
	I6zOK3umMD91ZA+BrtkhzcdCfKuFSez8XaybPxp+Jci1Yx18q7jHpiwUYkOUs3j19S8zYhbOKDS
	GEtNlBD3Ym83FdkLbKm7ndZkII/xeaql6krgD/pXVaAm7PaRGLU0MbKujgbZvqRB+3SXcJkyiEs
	v+nqD2v+ia+o9JAc9+HGcRdoz3/vLeA0o70OEkCVjJlqLz9Mb9IKDUtc2LqHVUMFR+jik6YQHE+
	znD5jD9ydhmBG5mqIgotHWoSKWqjq8HwpUvyZ+D89OEv7C0AYFCV0YrbVPgkPepHJmRgE2bkAHC
	LDnk4S7gECs03yMse6QWg9geC
X-Received: by 2002:a05:600c:4507:b0:477:9dc1:b706 with SMTP id
 5b1f17b1804b1-48069c47cabmr42098505e9.19.1769567253766; Tue, 27 Jan 2026
 18:27:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260127181610.86376-1-emil@etsalapatis.com> <20260127181610.86376-7-emil@etsalapatis.com>
In-Reply-To: <20260127181610.86376-7-emil@etsalapatis.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 27 Jan 2026 18:27:22 -0800
X-Gm-Features: AZwV_QgJmrIWMlM70UYg7GFl8IbKEc7X5lLLrwevCmzB0UZ_OBTNYFavoa-6lgI
Message-ID: <CAADnVQJfsRxjE1Znoh-BQf6JZG2AmWra=1+zn0PFm+OqMogcqA@mail.gmail.com>
Subject: Re: [PATCH v2 06/13] selftests: bpf: Add arena ASAN runtime to libarena
To: Emil Tsalapatis <emil@etsalapatis.com>
Cc: bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Eduard <eddyz87@gmail.com>, 
	etsal@meta.com, Ihor Solodrai <ihor.solodrai@linux.dev>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Puranjay Mohan <puranjay@kernel.org>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 27, 2026 at 10:16=E2=80=AFAM Emil Tsalapatis <emil@etsalapatis.=
com> wrote:
>
> From: Emil Tsalapatis <etsal@meta.com>
>
> Add an address sanitizer (ASAN) runtime to the arena library. The
> ASAN runtime implements the functions injected into BPF binaries
> by LLVM sanitization is supported and enabled.
>
> The runtime also includes functions called explicitly by memory
> allocation code to mark memory as poisoned/unpoisoned to ASAN.
> This code is a no-op when sanitization is turned off.
>
> Signed-off-by: Emil Tsalapatis (Meta) <emil@etsalapatis.com>
> ---
>  tools/testing/selftests/bpf/.gitignore        |   1 +
>  .../selftests/bpf/libarena/include/asan.h     | 133 +++++
>  .../selftests/bpf/libarena/src/asan.bpf.c     | 463 ++++++++++++++++++
>  3 files changed, 597 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/libarena/include/asan.h
>  create mode 100644 tools/testing/selftests/bpf/libarena/src/asan.bpf.c
>
> diff --git a/tools/testing/selftests/bpf/.gitignore b/tools/testing/selft=
ests/bpf/.gitignore
> index 96b4a7e37427..3d176d3b2cc1 100644
> --- a/tools/testing/selftests/bpf/.gitignore
> +++ b/tools/testing/selftests/bpf/.gitignore
> @@ -49,3 +49,4 @@ verification_cert.h
>  *.BTF_ids
>  *.BTF.base
>  libarena/test_libarena
> +libarena/test_libarena_asan
> diff --git a/tools/testing/selftests/bpf/libarena/include/asan.h b/tools/=
testing/selftests/bpf/libarena/include/asan.h
> new file mode 100644
> index 000000000000..be50b23fb491
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/libarena/include/asan.h
> @@ -0,0 +1,133 @@
> +#pragma once
> +
> +struct asan_init_args {
> +       u64 arena_all_pages;
> +       u64 arena_globals_pages;
> +};
> +
> +int asan_init(struct asan_init_args *args);
> +
> +/* Parameters usable by userspace. */
> +extern volatile u64 __asan_shadow_memory_dynamic_address;
> +extern volatile bool asan_reported;
> +extern volatile bool asan_inited;
> +extern volatile bool asan_report_once;
> +extern volatile bool asan_emit_stack;
> +
> +#ifdef __BPF__
> +
> +#define ASAN_SHADOW_SHIFT 3
> +#define ASAN_SHADOW_SCALE (1ULL << ASAN_SHADOW_SHIFT)
> +#define ASAN_GRANULE_MASK ((1ULL << ASAN_SHADOW_SHIFT) - 1)
> +#define ASAN_GRANULE(addr) ((s8)((u32)(u64)((addr)) & ASAN_GRANULE_MASK)=
)
> +
> +#define __noasan __attribute__((no_sanitize("address")))
> +
> +#ifdef BPF_ARENA_ASAN
> +
> +/*
> + * Defined as char * to get 1-byte granularity for pointer arithmetic.
> + */
> +typedef s8 __arena s8a;
> +
> +/*
> + * Address to shadow map translation.
> + */
> +static inline
> +s8a *mem_to_shadow(void __arena __arg_arena *addr)
> +{
> +       return (s8a *)(((u32)(u64)addr >> ASAN_SHADOW_SHIFT) + __asan_sha=
dow_memory_dynamic_address);
> +}
> +
> +/*
> + * Helper for directly reading the shadow map.
> + */
> +static inline __noasan
> +s8 asan_shadow_value(void __arena __arg_arena *addr)
> +{
> +       return *(s8a *)mem_to_shadow(addr);
> +}
> +
> +__weak __noasan
> +bool asan_ready(void)
> +{
> +       return __asan_shadow_memory_dynamic_address;
> +}
> +
> +/*
> + * Shadow map manipulation helpers.
> + */
> +int asan_poison(void __arena *addr, s8 val, size_t size);
> +int asan_unpoison(void __arena *addr, size_t size);
> +bool asan_shadow_set(void __arena *addr);
> +s8 asan_shadow_value(void __arena *addr);
> +
> +/*
> + * Dummy calls to ensure the ASAN runtime's BTF information is present
> + * in every object file when compiling the runtime and local BPF code
> + * separately. The runtime calls are injected into the LLVM IR file
> + */
> +#define DECLARE_ASAN_LOAD_STORE_SIZE(size)                             \
> +       void __asan_store##size(void *addr);                            \
> +       void __asan_store##size##_noabort(void *addr);  \
> +       void __asan_load##size(void *addr);                             \
> +       void __asan_load##size##_noabort(void *addr);   \
> +       void __asan_report_store##size(void *addr);                     \
> +       void __asan_report_store##size##_noabort(void *addr);           \
> +       void __asan_report_load##size(void *addr);                      \
> +       void __asan_report_load##size##_noabort(void *addr);
> +
> +DECLARE_ASAN_LOAD_STORE_SIZE(1);
> +DECLARE_ASAN_LOAD_STORE_SIZE(2);
> +DECLARE_ASAN_LOAD_STORE_SIZE(4);
> +DECLARE_ASAN_LOAD_STORE_SIZE(8);
> +
> +#define DECLARE_ASAN_LOAD_STORE(size)                          \
> +       void __asan_store##size(void *addr);                    \
> +       void __asan_store##size##_noabort(void *addr);          \
> +       void __asan_load##size(void *addr);                     \
> +       void __asan_load##size##_noabort(void *addr);           \
> +       void __asan_report_store##size(void *addr);             \
> +       void __asan_report_store##size##_noabort(void *addr);   \
> +       void __asan_report_load##size(void *addr);              \
> +       void __asan_report_load##size##_noabort(void *addr);
> +
> +#define ASAN_DUMMY_CALLS_SIZE(size, arg)               \
> +do {                                                   \
> +       __asan_store##size((arg));                      \
> +       __asan_store##size##_noabort((arg));            \
> +       __asan_load##size((arg));                       \
> +       __asan_load##size##_noabort((arg));             \
> +       __asan_report_store##size((arg));               \
> +       __asan_report_store##size##_noabort((arg));     \
> +       __asan_report_load##size((arg));                \
> +       __asan_report_load##size##_noabort((arg));      \
> +} while (0)
> +
> +#define ASAN_DUMMY_CALLS_ALL(arg)      \
> +do {                                   \
> +       ASAN_DUMMY_CALLS_SIZE(1, (arg));        \
> +       ASAN_DUMMY_CALLS_SIZE(2, (arg));        \
> +       ASAN_DUMMY_CALLS_SIZE(4, (arg));        \
> +       ASAN_DUMMY_CALLS_SIZE(8, (arg));        \
> +} while (0)
> +
> +__weak __attribute__((no_sanitize_address))
> +int asan_dummy_call() {
> +       /* Use the shadow map base to prevent it from being optimized out=
. */
> +       if (__asan_shadow_memory_dynamic_address)
> +               ASAN_DUMMY_CALLS_ALL(NULL);
> +
> +       return 0;
> +}
> +#else /* BPF_ARENA_ASAN */
> +
> +static inline int asan_poison(void __arena *addr, s8 val, size_t size) {=
 return 0; }
> +static inline int asan_unpoison(void __arena *addr, size_t size) { retur=
n 0; }
> +static inline bool asan_shadow_set(void __arena *addr) { return 0; }
> +static inline s8 asan_shadow_value(void __arena *addr) { return 0; }
> +__weak bool asan_ready(void) { return true; }
> +
> +#endif /* BPF_ARENA_ASAN */
> +
> +#endif /* __BPF__ */
> diff --git a/tools/testing/selftests/bpf/libarena/src/asan.bpf.c b/tools/=
testing/selftests/bpf/libarena/src/asan.bpf.c
> new file mode 100644
> index 000000000000..34b62c6e0aae
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/libarena/src/asan.bpf.c
> @@ -0,0 +1,463 @@
> +/*
> + * SPDX-License-Identifier: GPL-2.0
> + * Copyright (c) 2024-2025 Meta Platforms, Inc. and affiliates.
> + * Copyright (c) 2024-2025 Emil Tsalapatis <etsal@meta.com>
> + */
> +#include <common.h>
> +#include <asan.h>
> +
> +#ifdef BPF_ARENA_ASAN
> +
> +#pragma clang attribute push(__attribute__((no_sanitize("address"))), \
> +                            apply_to =3D function)
> +
> +#define SHADOW_ALL_ZEROES ((u64)-1)
> +
> +/*
> + * Canary variable for ASAN violations. Set to the offending address.
> + */
> +volatile u64 asan_violated =3D 0;
> +
> +/*
> + * Shadow map occupancy map.
> + */
> +volatile u64 __asan_shadow_memory_dynamic_address;
> +
> +volatile bool asan_reported =3D false;
> +volatile bool asan_inited =3D false;
> +
> +/*
> + * Set during program load.
> + */
> +volatile bool asan_report_once =3D false;
> +volatile bool asan_emit_stack =3D false;
> +
> +/*
> + * BPF does not currently support the memset/memcpy/memcmp intrinsics.
> + */
> +__always_inline int asan_memset(s8a __arg_arena *dst, s8 val, size_t siz=
e)
> +{
> +       int i;
> +
> +       /*
> +        * Switching this to a may_goto confuses the verifier and
> +        * prevents verification on bpf-next as of late December 2025.
> +        */
> +       bpf_for(i, 0, size) {
> +               dst[i] =3D val;
> +       }

Have you tried
int zero =3D 0;
for (int i =3D zero; i < size; i++)

like existing arena selftest do?

> +       return 0;
> +}
> +
> +/* Validate a 1-byte access, always within a single byte. */
> +static __always_inline bool memory_is_poisoned_1(s8a *addr)
> +{
> +       s8 shadow_value =3D asan_shadow_value(addr);
> +
> +       /* Byte is 0, access is valid. */
> +       if (likely(!shadow_value))
> +               return false;
> +
> +       /*
> +        * Byte is non-zero. Access is valid if granule offset in [0, sha=
dow_value),
> +        * so the memory is poisoned if shadow_value is negative or small=
er than
> +        * the granule's value.
> +        */
> +
> +       return ASAN_GRANULE(addr) >=3D shadow_value;
> +}
> +
> +/* Validate a 2- 4-, 8-byte access, spans up to 2 bytes. */
> +static __always_inline bool memory_is_poisoned_2_4_8(s8a *addr, u64 size=
)
> +{
> +       u64 end =3D (u64)addr + size - 1;
> +
> +       /*
> +        * Region fully within a single byte (addition didn't
> +        * overflow above ASAN_GRANULE).
> +        */
> +       if (likely(ASAN_GRANULE(end) >=3D size - 1))
> +               return memory_is_poisoned_1((s8a *)end);
> +
> +       /*
> +        * Otherwise first byte must be fully unpoisoned, and second byte
> +        * must be unpoisoned up to the end of the accessed region.
> +        */
> +
> +       return asan_shadow_value(addr) || memory_is_poisoned_1((s8a *)end=
);
> +}
> +
> +/*
> + * Explicit ASAN check.
> + */
> +__weak bool asan_shadow_set(void __arena __arg_arena *addr)
> +{
> +       return memory_is_poisoned_1(addr);
> +}
> +
> +static __always_inline u64 first_nonzero_byte(u64 addr, size_t size)
> +{

I'd think this one and asan_report() can weak noinline instead
to reduce the load on the verifier.
Have you tried making some of them global?

> +       while (size && can_loop) {
> +               if (unlikely(*(s8a *)addr))
> +                       return addr;
> +               addr +=3D 1;
> +               size -=3D 1;
> +       }
> +
> +       return SHADOW_ALL_ZEROES;
> +}
> +
> +static __always_inline bool memory_is_poisoned_n(s8a *addr, u64 size)
> +{
> +       u64 ret;
> +       u64 start;
> +       u64 end;
> +
> +       /* Size of [start, end] is end - start + 1. */
> +       start =3D (u64)mem_to_shadow(addr);
> +       end =3D (u64)mem_to_shadow(addr + size - 1);
> +
> +       ret =3D first_nonzero_byte(start, (end - start) + 1);
> +       if (likely(ret =3D=3D SHADOW_ALL_ZEROES))
> +               return false;
> +
> +       return __builtin_expect(ret !=3D end || ASAN_GRANULE(addr + size =
- 1) >=3D
> +                                                     *(s8a *)end, false)=
;

that's the same as unlikely(), right? Why open code?

> +
> +static __always_inline int asan_report(s8a __arg_arena *addr, size_t sz,
> +                                      bool write)
> +{
> +       /* Only report the first ASAN violation. */
> +       if (asan_reported && asan_report_once)
> +               return 0;
> +
> +       asan_reported =3D true;
> +
> +       asan_violated =3D (u64)addr;
> +
> +       if (asan_emit_stack) {
> +               arena_stderr("Memory violation for address %p (0x%lx) for=
 %s of size %ld",
> +                               addr, (u64)addr, write ? "write" : "read"=
, sz);
> +               bpf_stream_print_stack();
> +       }
> +
> +       return 0;
> +}
> +
> +static __always_inline bool check_asan_args(s8a *addr, size_t size,
> +                                           bool *result)
> +{
> +       bool valid =3D true;
> +
> +       /* Size 0 accesses are valid even if the address is invalid. */
> +       if (unlikely(size =3D=3D 0))
> +               goto confirmed_valid;
> +
> +       /*
> +        * Wraparound is possible for extremely high size. Possible if th=
e size
> +        * is a misinterpreted negative number.
> +        */
> +       if (unlikely(addr + size < addr))
> +               goto confirmed_invalid;
> +
> +       return false;
> +
> +confirmed_invalid:
> +       valid =3D false;
> +
> +       /* FALLTHROUGH */
> +confirmed_valid:
> +       *result =3D valid;
> +
> +       return true;
> +}
> +
> +static __always_inline bool check_region_inline(void *ptr, size_t size,
> +                                               bool write)
> +{
> +       s8a *addr =3D (s8a *)(u64)ptr;
> +       bool is_poisoned, is_valid;
> +
> +       if (check_asan_args(addr, size, &is_valid)) {
> +               if (!is_valid)
> +                       asan_report(addr, size, write);
> +               return is_valid;
> +       }
> +
> +       switch (size) {
> +       case 1:
> +               is_poisoned =3D memory_is_poisoned_1(addr);
> +               break;
> +       case 2:
> +       case 4:
> +       case 8:
> +               is_poisoned =3D memory_is_poisoned_2_4_8(addr, size);
> +               break;
> +       default:
> +               is_poisoned =3D memory_is_poisoned_n(addr, size);
> +       }
> +
> +       if (is_poisoned) {
> +               asan_report(addr, size, write);
> +               return false;
> +       }
> +
> +       return true;
> +}
> +
> +/*
> + * __alias is not supported for BPF so define *__noabort() variants as w=
rappers.
> + */
> +#define DEFINE_ASAN_LOAD_STORE(size)                                    =
       \
> +       __hidden void __asan_store##size(void *addr)                     =
      \
> +       {                                                                =
      \
> +               check_region_inline(addr, size, true);                   =
      \
> +       }                                                                =
      \
> +       __hidden void __always_inline __asan_store##size##_noabort(void *=
addr) \
> +       {                                                                =
      \
> +               check_region_inline(addr, size, true);                   =
      \
> +       }                                                                =
      \
> +       __hidden void __asan_load##size(void *addr)                      =
      \
> +       {                                                                =
      \
> +               check_region_inline(addr, size, false);                  =
      \
> +       }                                                                =
      \
> +       __hidden void __asan_load##size##_noabort(void *addr)            =
      \
> +       {                                                                =
      \
> +               check_region_inline(addr, size, false);                  =
      \
> +       }                                                                =
      \
> +       __hidden void __asan_report_store##size(void *addr)              =
      \
> +       {                                                                =
      \
> +               asan_report((s8a *)addr, size, true);                    =
      \
> +       }                                                                =
      \
> +       __hidden void __asan_report_store##size##_noabort(void *addr)    =
      \
> +       {                                                                =
      \
> +               asan_report((s8a *)addr, size, true);                    =
      \
> +       }                                                                =
      \
> +       __hidden void __asan_report_load##size(void *addr)               =
      \
> +       {                                                                =
      \
> +               asan_report((s8a *)addr, size, false);                   =
      \
> +       }                                                                =
      \
> +       __hidden void __asan_report_load##size##_noabort(void *addr)     =
      \
> +       {                                                                =
      \
> +               asan_report((s8a *)addr, size, false);                   =
      \
> +       }
> +
> +DEFINE_ASAN_LOAD_STORE(1);
> +DEFINE_ASAN_LOAD_STORE(2);
> +DEFINE_ASAN_LOAD_STORE(4);
> +DEFINE_ASAN_LOAD_STORE(8);
> +
> +void __asan_storeN(void *addr, ssize_t size)
> +{
> +       check_region_inline(addr, size, true);
> +}
> +
> +void __asan_loadN(void *addr, ssize_t size)
> +{
> +       check_region_inline(addr, size, false);
> +}
> +
> +/*
> + * We currently do not sanitize globals.
> + */
> +void __asan_register_globals(void *globals, size_t n)
> +{
> +}
> +
> +void __asan_unregister_globals(void *globals, size_t n)
> +{
> +}
> +
> +/*
> + * We do not currently have memcpy/memmove/memset intrinsics
> + * in LLVM. Do not implement sanitization.
> + */
> +void *__asan_memcpy(void *d, const void *s, size_t n)
> +{
> +       return NULL;
> +}
> +
> +void *__asan_memmove(void *d, const void *s, size_t n)
> +{
> +       return NULL;
> +}
> +
> +void *__asan_memset(void *p, int c, size_t n)
> +{
> +       return NULL;
> +}
> +
> +/*
> + * Poisoning code, used when we add more freed memory to the allocator b=
y:
> + *     a) pulling memory from the arena segment using bpf_arena_alloc_pa=
ges()
> + *     b) freeing memory from application code
> + */
> +__hidden __noasan int asan_poison(void __arena *addr, s8 val, size_t siz=
e)
> +{
> +       s8a *shadow;
> +       size_t len;
> +
> +       /*
> +        * Poisoning from a non-granule address makes no sense: We can on=
ly allocate
> +        * memory to the application that with a granule-aligned starting=
 address,
> +        * and bpf_arena_alloc_pages returns page-aligned memory. A non-a=
ligned
> +        * addr then implies we're freeing a different address than the o=
ne we
> +        * allocated.
> +        */
> +       if (unlikely((u64)addr & ASAN_GRANULE_MASK))
> +               return -EINVAL;
> +
> +       /*
> +        * We cannot free an unaligned region because it'd be possible th=
at we
> +        * cannot describe the resulting poisoning state of the granule i=
n
> +        * the ASAN encoding.
> +        *
> +        * Every granule represents a region of memory that looks like th=
e
> +        * following (P for poisoned bytes, C for clear):
> +        *
> +        * <Clear>  <Poisoned>
> +        * [ C C C ... P P ]
> +        *
> +        * The value of the granule's shadow map is the number of clear b=
ytes in
> +        * it. We cannot represent granules with the following state:
> +        *
> +        * [ P P ... C C ... P P ]
> +        *
> +        * That would be possible if we could free unaligned regions, so =
prevent that.
> +        *
> +        */
> +       if (unlikely(size & ASAN_GRANULE_MASK))
> +               return -EINVAL;

kasan_poison() in the kernel has the same logic without the comments.
The comments are nice, but please make a big comment somewhere
that the algorithm is the same as KASAN. Is it actually?
So reviewers don't need to triple check the bit math.

> +
> +       shadow =3D mem_to_shadow(addr);
> +       len =3D size >> ASAN_SHADOW_SHIFT;
> +
> +       asan_memset(shadow, val, len);
> +
> +       return 0;
> +}
