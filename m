Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AF2E3CD8B1
	for <bpf@vger.kernel.org>; Tue,  7 Apr 2026 16:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775579978; cv=pass; b=DPhXaeeuSdMTGlIVYnWxLs8SJY7rBggUTnBCPg8OyLn1HHYcGe7zSDgV5AN2OTqA/gYUtbJiBlPNJEUX38z+olBDRhAG96JMTyzrKHySFE+JapAJTnPVJcSOK8A/izGXfRLAJAkOQNLA2vvXpsl7z+GMNRwWnuwecb/5kw1rWDI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775579978; c=relaxed/simple;
	bh=GQcbAvJ/YTX3dIQmNkqPl3UJ3ysWzauFYaLZ5ifTtZ8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CLqh2Ev87NvmTKLMCPr5iTYy04fCKzJDWCA1lYQp4Q/3+IF02TALxwoODJ08q6DL7ZVv1BarI9hZhS/MGFuEQ9sxd5tB0PuFjJ+JfKcC1VEZYclcno+SrCQBvwJ1OlW3/j3yGojJemYy+M/P5vk8hAIOiPt2EMqVLfwF1gg3uLA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BO6kpeSo; arc=pass smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BO6kpeSo"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4888375f735so48539245e9.3
        for <bpf@vger.kernel.org>; Tue, 07 Apr 2026 09:39:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775579974; cv=none;
        d=google.com; s=arc-20240605;
        b=D5yp3QRqYhNOqCR/0UXhr0je6uw3SKjTKsGzasnflLUOcHRys/cHbXZsugeXzfvV8I
         DljMyJmLMy5yBjzL8xh3M+2lrJBWVaZ0/1libIhR+z+RRfCQ707dF/3TuAxivQLxOMFs
         BQXxuj65RiUQkGfAIUGagPtpZG5iMVawuUBtwG23uRLcWtC6aDuRhg0AuXWniYOCi/23
         tRogcsAWkMOeReAScGgNu3vAo1pOkTDCj0c8Q8AxaNlHynLMLKpnO0yMBS3ORcPbHMYX
         CVRdInHKF/rZARf+TKckrzlgJnDaGW8vOaFMtlLz9Qq7UhF++5bl51boxBBZcGSa5tsK
         6uiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=b/caHJC6PsoawenoFbeZklZR/0R7CDRrxMKBDvWmhgU=;
        fh=hfRje2veXRgnK/5UbF368BTRuTdPC/oA5JvW+CkXkIA=;
        b=IVOKItfb4lJXv9mwt7IQP0LdJy81ltVTcF6dlY3EtHrqLRsVgPpyvQnEGXhfkGZaRz
         lVfq92Q8zkdHGg0/wfDoXlDkJwDAM8Eb23aHcIb/0LTpPPb2FjXqCe21pfL8f61wVixP
         845dsnlweYDEwF3rSnnT0lZjCcpm1JnTG/TQ6d/IPMYeLCnJOZtzOxt3t6hRLFaAs+5Y
         oBMQQuV0lBsSJ+LwbtB9Y4ex9yJyK3QmZhclIJm8/TUQAEYAirSkoqb/s0wDT2gM5y9Y
         h3umWYhkExynnaY2U1Tg+ad5yqoAhyV1qZu3uSP+KIqQbjS7HaQD3fFVppHIMMtYeaN8
         6cYg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775579974; x=1776184774; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b/caHJC6PsoawenoFbeZklZR/0R7CDRrxMKBDvWmhgU=;
        b=BO6kpeSoKnpmSlymkOrXrBNfuWMykAgaunkcATgIkQCRThunIDeqZ745h+ro0EeVRP
         hLUcAwMMEOlPMnanubx2IWx3BiFuhWTS9trsL800RycXy/GVYb13ujrihvcEscVx9i7c
         dFUQQ4NPUwjXnMZfL//1KHHhVOMzZZF6tcH8R0AJrdG3iN6+uiNawLeUCRiRNHjdYqs7
         QaPfAyfbgcgWtaHKfwXCrBGG3OL4lTNNYVwukHUI2FjysQaMsU1/n6VuD8Vz0T7Z7KLG
         fXMpfw0SgSFOmYpu1eMzfqzKs/ADyRnPHw6nUVuebr1O3eI1JvigKrNnz6Gva5FVKsbm
         oDZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775579974; x=1776184774;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=b/caHJC6PsoawenoFbeZklZR/0R7CDRrxMKBDvWmhgU=;
        b=DOcP+1kFOMgOzcdA0rXiLdAroRWCYX30+kg9IeWMJZva/RHuPi5EYyz44oOO+hldJ7
         F3XEA5balRdXJhzELhCTslOvDOWRt15zFXjw0Ms4T8dQzjS8aF2aibOX86fcSZiS1aiP
         MVBnbGER0+VimJY2ECfTVGQWCTx6FYvG9oF30qmVov9d4eZC/C6UA8Q2hpmHiv1/9xAj
         3pg0iZloEK8jyxceu6IUF+UoCURZIx3IBOMLnfOKTsMn3ucdP91wp1nW6H1gCk8yzA4I
         QTg3TMTdS84MCFQVQgLGLQiIA7ivIgRorsI8hAkx2+5RH9Xj5Gp1LxBx2s8rmWHIKaCU
         JxUQ==
X-Gm-Message-State: AOJu0YwilyTmksjk7JPf2djMvNvVndwp6BfzRxyQvDNcVeE2bvAI43H5
	5HhHB3/4nxpozxz7K7+lyLAKk5vyFlyawh3EbWxChsWFZYfHBUPQvGePoTxppIfq7E9ttV57HM1
	jeB6btgwVZeTlNt5hF9cD9m6VQqmElmU=
X-Gm-Gg: AeBDieuIovw880esXret4YBm5fztt4ltUv/BiWZYl4/OPWBvN2p8CSuY8iN/KBnZvpw
	YzvNJwFUJ6fEW+L86I41BMn/6+vnNPU1+oazCL39mOc/UBDeyIzTxSiTCDC0Idbrk0g8OLPdDKg
	GMdC8OeQQ2fkD+iqMPt13+vfFUc2Xa9KkazEMNSwSJqaGNQ5BIxfRKwZeySdUMBjfGFo7yqCUen
	8TRXdL3Nn6Sqi9FXfyigWPW9HJ2FlPjUmMEFWGA/UicLB0q7XkRLZMapYcv8ciO3rEw1SGrPCev
	OHbPMbO0GU3RCjlFvyYU/oaERk8lBUfkvrBO3WORYNUlijDBnpDm/xyRa1ereZS+RFkIexnKncQ
	XcnY8JGBXiu7LFQfCkaGCu0M3Bg==
X-Received: by 2002:a05:600c:a318:b0:485:39b2:a47c with SMTP id
 5b1f17b1804b1-488997dd6camr173599725e9.25.1775579973447; Tue, 07 Apr 2026
 09:39:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260407045730.13359-1-emil@etsalapatis.com> <20260407045730.13359-7-emil@etsalapatis.com>
In-Reply-To: <20260407045730.13359-7-emil@etsalapatis.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 7 Apr 2026 09:39:21 -0700
X-Gm-Features: AQROBzAj3jUUndvdkYntpUvlGyizMSJPkpHVkH8Q5hlDWhb_wB-Gs4KIDwraDHs
Message-ID: <CAADnVQLHFZE3AFzP3gtZKvcaX+3hbp3pCw3JLqEtpdoQ+OUf7g@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 6/9] selftests/bpf: Add arena ASAN runtime to libarena
To: Emil Tsalapatis <emil@etsalapatis.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Daniel Borkmann <daniel@iogearbox.net>, Eduard <eddyz87@gmail.com>, Song Liu <song@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 6, 2026 at 9:57=E2=80=AFPM Emil Tsalapatis <emil@etsalapatis.co=
m> wrote:
>
> Add an address sanitizer (ASAN) runtime to the arena library. The
> ASAN runtime implements the functions injected into BPF binaries
> by LLVM sanitization when ASAN is enabled during compilation.
>
> The runtime also includes functions called explicitly by memory
> allocation code to mark memory as poisoned/unpoisoned to ASAN.
> This code is a no-op when sanitization is turned off.
>
> Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
> ---
>  .../selftests/bpf/libarena/include/asan.h     | 124 ++++
>  .../selftests/bpf/libarena/include/common.h   |   1 +
>  .../selftests/bpf/libarena/src/asan.bpf.c     | 539 ++++++++++++++++++
>  .../selftests/bpf/libarena/src/common.bpf.c   |   1 +
>  4 files changed, 665 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/libarena/include/asan.h
>  create mode 100644 tools/testing/selftests/bpf/libarena/src/asan.bpf.c
>
> diff --git a/tools/testing/selftests/bpf/libarena/include/asan.h b/tools/=
testing/selftests/bpf/libarena/include/asan.h
> new file mode 100644
> index 000000000000..d2eeabba3ffc
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/libarena/include/asan.h
> @@ -0,0 +1,124 @@
> +// SPDX-License-Identifier: LGPL-2.1 OR BSD-2-Clause
> +/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
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

not a helpful comment.

> +extern volatile u64 __asan_shadow_memory_dynamic_address;
> +extern volatile u32 asan_reported;
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

not a good comment either.

> +typedef s8 __arena s8a;
> +
> +/*
> + * Address to shadow map translation.
> + */

delete it too.

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

what? Whole new helper just to avoid typing *(s8a *) ?

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

delete the comment.

> +int asan_poison(void __arena *addr, s8 val, size_t size);
> +int asan_unpoison(void __arena *addr, size_t size);
> +bool asan_shadow_set(void __arena *addr);
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
> +__weak __noasan
> +int asan_dummy_call(void) {
> +       /* Use the shadow map base to prevent it from being optimized out=
. */
> +       if (__asan_shadow_memory_dynamic_address)
> +               ASAN_DUMMY_CALLS_ALL(NULL);
> +
> +       return 0;
> +}

so every bpf prog with arena will have this asan_dummy_call() function
just for BTF info?
It doesn't smell right.
I think it's a bug on LLVM side. It should be preserving BTF
when it emits calls to __asan*.

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
> diff --git a/tools/testing/selftests/bpf/libarena/include/common.h b/tool=
s/testing/selftests/bpf/libarena/include/common.h
> index 544a398a0d1e..f48395358d1d 100644
> --- a/tools/testing/selftests/bpf/libarena/include/common.h
> +++ b/tools/testing/selftests/bpf/libarena/include/common.h
> @@ -39,6 +39,7 @@ struct {
>  } arena __weak SEC(".maps");
>
>  extern const volatile u32 zero;
> +extern volatile u64 asan_violated;
>
>  int arena_fls(__u64 word);
>
> diff --git a/tools/testing/selftests/bpf/libarena/src/asan.bpf.c b/tools/=
testing/selftests/bpf/libarena/src/asan.bpf.c
> new file mode 100644
> index 000000000000..b3fae0ed020c
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/libarena/src/asan.bpf.c
> @@ -0,0 +1,539 @@
> +// SPDX-License-Identifier: LGPL-2.1 OR BSD-2-Clause
> +/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
> +#include <vmlinux.h>
> +#include <common.h>
> +#include <asan.h>
> +
> +/*
> + * Address sanitizer (ASAN) for arena-based BPF programs. The
> + * sanitizer tracks valid arena memory and triggers an error
> + * when poisoned memory is read or written to. Starting point
> + * was the KASAN implementation in mm/.

KASAN part of the comment looks obsolete and not really helpful
in isolation. "Starting point was.." so?
How is it different ?
If it said "inspired by KASAN" that would be read differently.
Or just delete it.

> + *
> + * The API
> + * -------
> + *
> + * The implementation includes two kinds of components: Implementation
> + * of ASAN hooks injected by LLVM into the program, and API calls that
> + * allocators use to mark memory as valid or invalid. The full list is:
> + *
> + * LLVM stubs:
> + *
> + * void __asan_{load, store}<size>(void *addr)
> + *     Checks whether an access is valid. All variations covered
> + *     by check_region_inline().
> + *
> + * void __asan_{store, load}((void *addr, ssize_t size)
> + *
> + * void __asan_report_{load, store}<size>(void *addr)
> + *     Report an access violation for the program. Used when LLVM
> + *     uses direct code generation for shadow map checks.
> + *
> + * void *__asan_memcpy(void *d, const void *s, size_t n)
> + * void *__asan_memmove(void *d, const void *s, size_t n)
> + * void *__asan_memset(void *p, int c, size_t n)
> + *     Hooks for ASAN instrumentation of the LLVM mem* builtins.
> + *     Currently unimplemented just like the builtins themselves.
> + *
> + * API methods:
> + *
> + * asan_init()
> + *     Initialize the ASAN map for the arena.
> + *
> + * asan_poison()
> + *     Mark a region of memory as poisoned. Accessing poisoned memory
> + *     causes asan_report() to fire. Invoked during free().
> + *
> + * asan_unpoison()
> + *     Mark a region as unpoisoned after alloc().
> + *
> + * asan_shadow_set()
> + *     Check a byte's validity directly.
> + *
> + * The Algorithm In Brief
> + * ----------------------
> + * Each group of 8 bytes is mapped to a "granule" in the shadow map. Thi=
s
> + * granule is the size of the byte and describes which bytes are valid.
> + * Possible values are:
> + *
> + * 0: All bytes are valid. Makes checks in the middle of an allocated re=
gion
> + * (most of them) fast.
> + * (0, 7]: How many consecutive bytes are valid, starting from the lowes=
t one.
> + * The tradeoff is that we can't poison individual bytes in the middle o=
f a
> + * valid region.
> + * [0x80, 0xff]: Special poison values, can be used to denote specific e=
rror
> + * modes (e.g., recently freed vs uninitialized memory).
> + *
> + * The mapping between a memory location and its shadow is:
> + * shadow_addr =3D shadow_base + (addr >> 3). We retain the 8:1 data:sha=
dow
> + * ratio of existing ASAN implementations as a compromise between tracki=
ng
> + * granularity and space usage/scan overhead.
> + */
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
> +volatile u32 asan_reported =3D false;
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

and? I don't get what comment is trying to say.

> + */
> +__weak int asan_memset(s8a __arg_arena *dst, s8 val, size_t size)

right above the comment said __asan_memset is not implemented.
Yet this is an implementation. What is significance of double underscore?

> +{
> +       size_t i;
> +
> +       for (i =3D zero; i < size && can_loop; i++)
> +               dst[i] =3D val;
> +
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
> +/* Validate a 2- 4-, 8-byte access, shadow spans up to 2 bytes. */
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

the comment is too terse to be useful.

> + */
> +__weak bool asan_shadow_set(void __arena __arg_arena *addr)
> +{
> +       return memory_is_poisoned_1(addr);
> +}
> +
> +static __always_inline u64 first_nonzero_byte(u64 addr, size_t size)
> +{
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

__builtin_expect ? Use unlikely().

> +}
> +
> +__weak int asan_report(s8a __arg_arena *addr, size_t sz,
> +                                      bool write)
> +{
> +       u32 reported =3D __sync_val_compare_and_swap(&asan_reported, fals=
e, true);
> +
> +       /* Only report the first ASAN violation. */
> +       if (reported && asan_report_once)
> +               return 0;
> +
> +       asan_violated =3D (u64)addr;
> +
> +       if (asan_emit_stack) {
> +               arena_stderr("Memory violation for address %p (0x%lx) for=
 %s of size %ld",
> +                               addr, (u64)addr, write ? "write" : "read"=
, sz);
> +               bpf_stream_print_stack(BPF_STDERR);
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
> +        * Wraparound is possible for values close to the the edge of the
> +        * 4GiB boundary of the arena (last valid address is 1UL << 32 - =
1).
> +        *
> +        *
> +        * The wraparound detection below works for small sizes.check_asa=
n_args is
> +        * always called from the builtin ASAN checks, so 1 <=3D size <=
=3D 64. We do
> +        * not implement storeN/loadN, so size is guaranteed to be in tha=
t range.
> +        * Even if we did, sane storeN/loadN intrinsics are not expected =
to have
> +        * a large enough size that
> +        *
> +        * - addr + size  > MAX_U32
> +        * - (u32)(addr + size) > (u32) addr
> +        *
> +        * which would defeat wraparound detection.
> +        */
> +       if (unlikely((u32)(u64)(addr + size) < (u32)(u64)addr))
> +               goto confirmed_invalid;
> +
> +       return false;

in this path the result will stay uninitialized. Bug or not?

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

I have allergy to bool arguments.
Please use 'u32 flags' from the day one and human readable
enum, so the callsites are easy to read.

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
> +#define DEFINE_ASAN_LOAD_STORE(size)                                  \
> +       __hidden void __asan_store##size(void *addr)                  \
> +       {                                                             \
> +               check_region_inline(addr, size, true);                \
> +       }                                                             \
> +       __hidden void __asan_store##size##_noabort(void *addr)        \
> +       {                                                             \
> +               check_region_inline(addr, size, true);                \
> +       }                                                             \
> +       __hidden void __asan_load##size(void *addr)                   \
> +       {                                                             \
> +               check_region_inline(addr, size, false);               \
> +       }                                                             \
> +       __hidden void __asan_load##size##_noabort(void *addr)         \
> +       {                                                             \
> +               check_region_inline(addr, size, false);               \

unlike here where false vs true is not meaningful without
reading the prototype.

> +       }                                                             \
> +       __hidden void __asan_report_store##size(void *addr)           \
> +       {                                                             \
> +               asan_report((s8a *)addr, size, true);                 \
> +       }                                                             \
> +       __hidden void __asan_report_store##size##_noabort(void *addr) \
> +       {                                                             \
> +               asan_report((s8a *)addr, size, true);                 \
> +       }                                                             \
> +       __hidden void __asan_report_load##size(void *addr)            \
> +       {                                                             \
> +               asan_report((s8a *)addr, size, false);                \
> +       }                                                             \
> +       __hidden void __asan_report_load##size##_noabort(void *addr)  \
> +       {                                                             \
> +               asan_report((s8a *)addr, size, false);                \
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
> +       arena_stderr("ASAN: Unexpected %s call", __func__);
> +       return NULL;
> +}
> +
> +void *__asan_memmove(void *d, const void *s, size_t n)
> +{
> +       arena_stderr("ASAN: Unexpected %s call", __func__);
> +       return NULL;
> +}
> +
> +void *__asan_memset(void *p, int c, size_t n)
> +{
> +       arena_stderr("ASAN: Unexpected %s call", __func__);
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
> +        * memory to the application that has a granule-aligned starting =
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
> +        */
> +       if (unlikely(size & ASAN_GRANULE_MASK))
> +               return -EINVAL;
> +
> +       shadow =3D mem_to_shadow(addr);
> +       len =3D size >> ASAN_SHADOW_SHIFT;
> +
> +       asan_memset(shadow, val, len);
> +
> +       return 0;
> +}
> +
> +/*
> + * Unpoisoning code for marking memory as valid during allocation calls.
> + *
> + * Very similar to asan_poison, except we need to round up instead of
> + * down, then partially poison the last granule if necessary.
> + *
> + * Partial poisoning is useful for keeping the padding poisoned. Allocat=
ions
> + * are granule-aligned, so we we're reserving granule-aligned sizes for =
the
> + * allocation. However, we want to still treat accesses to the padding a=
s
> + * invalid. Partial poisoning takes care of that. Freeing and poisoning =
the
> + * memory is still done in granule-aligned sizes and repoisons the alrea=
dy
> + * poisoned padding.
> + */
> +__hidden __noasan int asan_unpoison(void __arena *addr, size_t size)
> +{
> +       size_t partial =3D size & ASAN_GRANULE_MASK;
> +       s8a *shadow;
> +       size_t len;
> +
> +       /*
> +        * We cannot allocate in the middle of the granule. The ASAN shad=
ow
> +        * map encoding only describes regions of memory where every gran=
ule
> +        * follows this format (P for poisoned, C for clear):
> +        *
> +        * <Clear>  <Poisoned>
> +        * [ C C C ... P P ]
> +        *
> +        * This is so we can use a single number in [0, ASAN_SHADOW_SCALE=
)
> +        * to represent the poison state of the granule.
> +        */
> +       if (unlikely((u64)addr & ASAN_GRANULE_MASK))
> +               return -EINVAL;
> +
> +       shadow =3D mem_to_shadow(addr);
> +       len =3D size >> ASAN_SHADOW_SHIFT;
> +
> +       asan_memset(shadow, 0, len);
> +
> +       /*
> +        * If we are allocating a non-granule aligned region, we need to =
adjust
> +        * the last byte of the shadow map to list how many bytes in the =
granule
> +        * are unpoisoned. If the region is aligned, then the memset call=
 above
> +        * was enough.
> +        */
> +       if (partial)
> +               shadow[len] =3D partial;
> +
> +       return 0;
> +}
> +
> +/*
> + * Initialize ASAN state when necessary. Triggered from userspace before
> + * allocator startup.
> + */
> +SEC("syscall")
> +__hidden __noasan int asan_init(struct asan_init_args *args)
> +{
> +       u64 globals_pages =3D args->arena_globals_pages;
> +       u64 all_pages =3D args->arena_all_pages;
> +       u64 shadowmap, shadow_pgoff;

shadowmap stands out. shadow_map ?

> +       u64 shadow_pages;
> +
> +       if (asan_inited)
> +               return 0;
> +
> +       /*
> +        * Round up the shadow map size to the nearest page.
> +        */
> +       shadow_pages =3D all_pages >> ASAN_SHADOW_SHIFT;
> +       if ((all_pages & ((1 << ASAN_SHADOW_SHIFT) -1 )))
> +               shadow_pages +=3D 1;
> +
> +       /*
> +        * Make sure the numbers provided by userspace are sane.
> +        */

not a helpful comment.

> +       if (all_pages > (1ULL << 32) / __PAGE_SIZE) {
> +               arena_stderr("error: arena size %lx too large", all_pages=
);
> +               return -EINVAL;
> +       }
> +
> +       if (globals_pages > all_pages) {
> +               arena_stderr("error: globals %lx do not fit in arena %lx"=
, globals_pages, all_pages);
> +               return -EINVAL;
> +       }
> +
> +       if (globals_pages + shadow_pages > all_pages) {
> +               arena_stderr("error: globals %lx do not leave room for sh=
adow map %lx (arena pages %lx)",
> +                       globals_pages, shadow_pages, all_pages);
> +               return -EINVAL;
> +       }
> +
> +       shadow_pgoff =3D all_pages - shadow_pages - globals_pages;
> +       __asan_shadow_memory_dynamic_address =3D shadow_pgoff * __PAGE_SI=
ZE;
> +
> +       /*
> +        * Allocate the last (1/ASAN_SHADOW_SCALE)th of an arena's pages =
for the map
> +        * We find the offset and size from the arena map.
> +        *
> +        * The allocated map pages are zeroed out, meaning all memory is =
marked as valid
> +        * even if it's not allocated already. This is expected: Since th=
e actual memory
> +        * pages are not allocated, accesses to it will trigger page faul=
ts and will be
> +        * reported through BPF streams. Any pages allocated through bpf_=
arena_alloc_pages
> +        * should be poisoned by the allocator right after the call succe=
eds.
> +        */
> +       shadowmap =3D (u64)bpf_arena_alloc_pages(
> +               &arena, (void __arena *)__asan_shadow_memory_dynamic_addr=
ess,
> +               shadow_pages, NUMA_NO_NODE, 0);
> +       if (!shadowmap) {
> +               arena_stderr("Could not allocate shadow map\n");
> +
> +               __asan_shadow_memory_dynamic_address =3D 0;
> +
> +               return -ENOMEM;
> +       }
> +
> +       asan_inited =3D true;
> +
> +       return 0;
> +}
> +
> +#pragma clang attribute pop
> +
> +#endif /* BPF_ARENA_ASAN */
> +
> +__weak char _license[] SEC("license") =3D "GPL";
> diff --git a/tools/testing/selftests/bpf/libarena/src/common.bpf.c b/tool=
s/testing/selftests/bpf/libarena/src/common.bpf.c
> index cbb729290d3c..31acb259ec5a 100644
> --- a/tools/testing/selftests/bpf/libarena/src/common.bpf.c
> +++ b/tools/testing/selftests/bpf/libarena/src/common.bpf.c
> @@ -1,6 +1,7 @@
>  // SPDX-License-Identifier: LGPL-2.1 OR BSD-2-Clause
>  /* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
>  #include <common.h>
> +#include <asan.h>
>
>  const volatile u32 zero =3D 0;
>
> --
> 2.53.0
>
