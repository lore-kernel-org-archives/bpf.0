Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C9C215624B
	for <bpf@vger.kernel.org>; Thu,  9 Apr 2026 00:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775695096; cv=none; b=sYkFsDBQAFnFaiywVjq6BPLwvCGXMQHchvRPIlseINazYOQnojw0lHV3dtmI1gCd7JGRZ4RiGYvV3H7StxBWIGYr9+h69ans+OJJNKqy76H/+FgkbML6hTFRDo7ce2J0/X8hiWRZc664PNPg4nXsUesxo4LRLfjfVBUXzLrEao0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775695096; c=relaxed/simple;
	bh=PuOF4JMjsCZrLWZPObNwV4J5wONDX8aHTlSRiGIh8Xk=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=QIWm8s6w698PjFvJzTTO0pL2YAKbmE5XGK8GF8waWxTWQ3ZW7fWX7Zfj5Zfe26lXRe0TDFe+tdjHg+upZeiA9JrlKaKnIfGA1JRSym3SKC2ZjGtjp7ogvGadSQYHuUkJCBrOMCVApG0hWp6FyIKPn/p/M8uFszOqy3KLVZJ34iA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=oQlNUgqv; arc=none smtp.client-ip=74.125.82.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="oQlNUgqv"
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-2d3eb307324so81575eec.0
        for <bpf@vger.kernel.org>; Wed, 08 Apr 2026 17:38:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1775695093; x=1776299893; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jW9K2ZnZxV+4bLTlBi9A8eJJXyATmFBjc1aKWBx43fc=;
        b=oQlNUgqv1hTsfYeU56h0nvAUgamw6GdevJZid8B5jWISHK9iHVek6Gjek74y04A4Vm
         Hmedmp+2qCk9nJsIBEa1nvUa28Xjkp2683sh2IUPY23K1F4P8se0bb3awuZUujrbVvpU
         0f7KByl/aE3SmYIAqdew3/aAn9Tg3BzDZ9md0QpR0bMezjtXCyBgM9Uf3KhgU8nfRiZ2
         UXoqlHlpLVoiTcWRVSiOi6A/jh9r12USuaQOosCWw56ld6lJ++jMCG1GrLdm5pNV5TB4
         ugQzw5gts5Ixu+3L85UwUMJ2iKEnyy7gyAYBrw+NOx0qHeA5+oxeeEl71f0aXVhFLjNl
         NE0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775695093; x=1776299893;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jW9K2ZnZxV+4bLTlBi9A8eJJXyATmFBjc1aKWBx43fc=;
        b=X+1BRa+cOUtXFVOl/jr5IDa476XgAnGvYwvCzRcnZbyIdUH7WiGR3yVtdNtcghU+xa
         CEZb5cEcvUhAYc37ryMiveoqTh4pBL8gvaWXne0QaEP2DGsIbPdG0xIxLLr3fE09V4/8
         ThEldwB8zWn88bHec+LlurEkAgXriNvWzdkBuhLpP6TnB7ta2aEd+qEMGoWkKSES0495
         OvXEpXilxRDlzQuQY+rCdrYfL+ELJcWw8UlJwfu1HKuvXjKlqlV1Uo5Q59ydTeF415+e
         Yv+AOSIxMoRx7oq558/0i41AaU6C9SqcnEPykxsiv9f7ZN0vIUmWH40Q4NehqoFc1iHq
         i7Dw==
X-Gm-Message-State: AOJu0YzdADfg/RQK/2JMR1hSOg5QIqDwNGdiu6/0ip836/nF0Mb58gP1
	V1jnxAmDxLGlEeYoBuilSJy5Tv85rjVLUts9irbFgi/rPKiG5i07zsao0qZonWqgo1A=
X-Gm-Gg: AeBDievFNDN2uB6o7Ngqkiillxf9LwqCpypUVOjG8e4DqicK4gtHprDNMqsZ0v6DbxY
	g+EJCClIgXBh6ZvX6nZpLZNxGFmCC3aHa9ZYNUkj0Nkirdc4g8z1qEu1H+d7IoRxhO9qVaJzedx
	KyiPdZy4hq5Z1Q2MV3N7lfTsrocLIxhrO7mXW4L8j69UxeD5/GQOeGp15nFCLqmiDor0noS1kJD
	sD98JnCB7sGsd12iMvXch8uK/VnDeDhgEWoZ0dPEaxqgk/2lWeoBiP7zyE0QGOySO8A8BFvWg2v
	06Mq8AEH8kcWwLrxNdkAOZZecXVUa1SPBaybELILc+Wxs1TSetUMXCCg4OLK2x3pm1lvsSBdWyU
	bRChiBm8kn9D5yL5opGKxHa5f1xLxlBunjI0LnP75oqlpRfF9UVV6khdeTSsYnUsfQv/P5KlDta
	fDlJchVzFF5BAkauc=
X-Received: by 2002:a05:7300:4316:b0:2c1:82c2:bc31 with SMTP id 5a478bee46e88-2d40fce76c1mr673719eec.10.1775695092708;
        Wed, 08 Apr 2026 17:38:12 -0700 (PDT)
Received: from localhost ([2620:10d:c090:600::68e1])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2cf1af62347sm16538822eec.22.2026.04.08.17.38.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Apr 2026 17:38:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 08 Apr 2026 20:38:10 -0400
Message-Id: <DHO7DJ574EL1.8O0NIINEBJMR@etsalapatis.com>
Cc: "bpf" <bpf@vger.kernel.org>, "Alexei Starovoitov" <ast@kernel.org>,
 "Andrii Nakryiko" <andrii@kernel.org>, "Kumar Kartikeya Dwivedi"
 <memxor@gmail.com>, "Daniel Borkmann" <daniel@iogearbox.net>, "Eduard"
 <eddyz87@gmail.com>, "Song Liu" <song@kernel.org>
Subject: Re: [PATCH bpf-next v4 6/9] selftests/bpf: Add arena ASAN runtime
 to libarena
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>, "Emil Tsalapatis"
 <emil@etsalapatis.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260407045730.13359-1-emil@etsalapatis.com>
 <20260407045730.13359-7-emil@etsalapatis.com>
 <CAADnVQLHFZE3AFzP3gtZKvcaX+3hbp3pCw3JLqEtpdoQ+OUf7g@mail.gmail.com>
In-Reply-To: <CAADnVQLHFZE3AFzP3gtZKvcaX+3hbp3pCw3JLqEtpdoQ+OUf7g@mail.gmail.com>

On Tue Apr 7, 2026 at 12:39 PM EDT, Alexei Starovoitov wrote:
> On Mon, Apr 6, 2026 at 9:57=E2=80=AFPM Emil Tsalapatis <emil@etsalapatis.=
com> wrote:
>>
>> Add an address sanitizer (ASAN) runtime to the arena library. The
>> ASAN runtime implements the functions injected into BPF binaries
>> by LLVM sanitization when ASAN is enabled during compilation.
>>
>> The runtime also includes functions called explicitly by memory
>> allocation code to mark memory as poisoned/unpoisoned to ASAN.
>> This code is a no-op when sanitization is turned off.
>>
>> Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
>> ---
>>  .../selftests/bpf/libarena/include/asan.h     | 124 ++++
>>  .../selftests/bpf/libarena/include/common.h   |   1 +
>>  .../selftests/bpf/libarena/src/asan.bpf.c     | 539 ++++++++++++++++++
>>  .../selftests/bpf/libarena/src/common.bpf.c   |   1 +
>>  4 files changed, 665 insertions(+)
>>  create mode 100644 tools/testing/selftests/bpf/libarena/include/asan.h
>>  create mode 100644 tools/testing/selftests/bpf/libarena/src/asan.bpf.c
>>
>> diff --git a/tools/testing/selftests/bpf/libarena/include/asan.h b/tools=
/testing/selftests/bpf/libarena/include/asan.h
>> new file mode 100644
>> index 000000000000..d2eeabba3ffc
>> --- /dev/null
>> +++ b/tools/testing/selftests/bpf/libarena/include/asan.h
>> @@ -0,0 +1,124 @@
>> +// SPDX-License-Identifier: LGPL-2.1 OR BSD-2-Clause
>> +/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
>> +#pragma once
>> +
>> +struct asan_init_args {
>> +       u64 arena_all_pages;
>> +       u64 arena_globals_pages;
>> +};
>> +
>> +int asan_init(struct asan_init_args *args);
>> +
>> +/* Parameters usable by userspace. */
>
> not a helpful comment.
>
>> +extern volatile u64 __asan_shadow_memory_dynamic_address;
>> +extern volatile u32 asan_reported;
>> +extern volatile bool asan_inited;
>> +extern volatile bool asan_report_once;
>> +extern volatile bool asan_emit_stack;
>> +
>> +#ifdef __BPF__
>> +
>> +#define ASAN_SHADOW_SHIFT 3
>> +#define ASAN_SHADOW_SCALE (1ULL << ASAN_SHADOW_SHIFT)
>> +#define ASAN_GRANULE_MASK ((1ULL << ASAN_SHADOW_SHIFT) - 1)
>> +#define ASAN_GRANULE(addr) ((s8)((u32)(u64)((addr)) & ASAN_GRANULE_MASK=
))
>> +
>> +#define __noasan __attribute__((no_sanitize("address")))
>> +
>> +#ifdef BPF_ARENA_ASAN
>> +
>> +/*
>> + * Defined as char * to get 1-byte granularity for pointer arithmetic.
>> + */
>
> not a good comment either.
>
>> +typedef s8 __arena s8a;
>> +
>> +/*
>> + * Address to shadow map translation.
>> + */
>
> delete it too.
>
>> +static inline
>> +s8a *mem_to_shadow(void __arena __arg_arena *addr)
>> +{
>> +       return (s8a *)(((u32)(u64)addr >> ASAN_SHADOW_SHIFT) + __asan_sh=
adow_memory_dynamic_address);
>> +}
>> +
>> +/*
>> + * Helper for directly reading the shadow map.
>> + */
>> +static inline __noasan
>> +s8 asan_shadow_value(void __arena __arg_arena *addr)
>> +{
>> +       return *(s8a *)mem_to_shadow(addr);
>> +}
>
> what? Whole new helper just to avoid typing *(s8a *) ?
>
>> +
>> +__weak __noasan
>> +bool asan_ready(void)
>> +{
>> +       return __asan_shadow_memory_dynamic_address;
>> +}
>> +
>> +/*
>> + * Shadow map manipulation helpers.
>> + */
>
> delete the comment.
>
>> +int asan_poison(void __arena *addr, s8 val, size_t size);
>> +int asan_unpoison(void __arena *addr, size_t size);
>> +bool asan_shadow_set(void __arena *addr);
>> +
>> +/*
>> + * Dummy calls to ensure the ASAN runtime's BTF information is present
>> + * in every object file when compiling the runtime and local BPF code
>> + * separately. The runtime calls are injected into the LLVM IR file
>> + */
>> +#define DECLARE_ASAN_LOAD_STORE_SIZE(size)                             =
\
>> +       void __asan_store##size(void *addr);                            =
\
>> +       void __asan_store##size##_noabort(void *addr);  \
>> +       void __asan_load##size(void *addr);                             =
\
>> +       void __asan_load##size##_noabort(void *addr);   \
>> +       void __asan_report_store##size(void *addr);                     =
\
>> +       void __asan_report_store##size##_noabort(void *addr);           =
\
>> +       void __asan_report_load##size(void *addr);                      =
\
>> +       void __asan_report_load##size##_noabort(void *addr);
>> +
>> +DECLARE_ASAN_LOAD_STORE_SIZE(1);
>> +DECLARE_ASAN_LOAD_STORE_SIZE(2);
>> +DECLARE_ASAN_LOAD_STORE_SIZE(4);
>> +DECLARE_ASAN_LOAD_STORE_SIZE(8);
>> +
>> +#define ASAN_DUMMY_CALLS_SIZE(size, arg)               \
>> +do {                                                   \
>> +       __asan_store##size((arg));                      \
>> +       __asan_store##size##_noabort((arg));            \
>> +       __asan_load##size((arg));                       \
>> +       __asan_load##size##_noabort((arg));             \
>> +       __asan_report_store##size((arg));               \
>> +       __asan_report_store##size##_noabort((arg));     \
>> +       __asan_report_load##size((arg));                \
>> +       __asan_report_load##size##_noabort((arg));      \
>> +} while (0)
>> +
>> +#define ASAN_DUMMY_CALLS_ALL(arg)      \
>> +do {                                   \
>> +       ASAN_DUMMY_CALLS_SIZE(1, (arg));        \
>> +       ASAN_DUMMY_CALLS_SIZE(2, (arg));        \
>> +       ASAN_DUMMY_CALLS_SIZE(4, (arg));        \
>> +       ASAN_DUMMY_CALLS_SIZE(8, (arg));        \
>> +} while (0)
>> +
>> +__weak __noasan
>> +int asan_dummy_call(void) {
>> +       /* Use the shadow map base to prevent it from being optimized ou=
t. */
>> +       if (__asan_shadow_memory_dynamic_address)
>> +               ASAN_DUMMY_CALLS_ALL(NULL);
>> +
>> +       return 0;
>> +}
>
> so every bpf prog with arena will have this asan_dummy_call() function
> just for BTF info?
> It doesn't smell right.
> I think it's a bug on LLVM side. It should be preserving BTF
> when it emits calls to __asan*.

This only gets emitted for programs compiled with ASAN, so it's not
there by default. That being said, the issue is ultimately that LLVM
doesn't inject debug info for the __asan functions. I've been able to=20
remove the dummy calls by adding a postprocessing step in LLVM's
AddressSanitizer (github.com/etsal/llvm-project/tree/asan-emit-dinfo).
I've also gotten the dummy definitions removed by replacing them with
a function pointer array, like so:

/* Only required when compiled with ASAN flags */
static void (* __asan_btf[])(void *) {
	ASAN_LOAD_STORE_SIZE(1),
	ASAN_LOAD_STORE_SIZE(2),
	ASAN_LOAD_STORE_SIZE(4),
	ASAN_LOAD_STORE_SIZE(8),
};

Wdyt about either keeping the dummy calls or using the function pointer
array for now, then removing it if/once an LLVM-side solution gets accepted=
?

>
>> +#else /* BPF_ARENA_ASAN */
>> +
>> +static inline int asan_poison(void __arena *addr, s8 val, size_t size) =
{ return 0; }
>> +static inline int asan_unpoison(void __arena *addr, size_t size) { retu=
rn 0; }
>> +static inline bool asan_shadow_set(void __arena *addr) { return 0; }
>> +static inline s8 asan_shadow_value(void __arena *addr) { return 0; }
>> +__weak bool asan_ready(void) { return true; }
>> +
>> +#endif /* BPF_ARENA_ASAN */
>> +
>> +#endif /* __BPF__ */
>> diff --git a/tools/testing/selftests/bpf/libarena/include/common.h b/too=
ls/testing/selftests/bpf/libarena/include/common.h
>> index 544a398a0d1e..f48395358d1d 100644
>> --- a/tools/testing/selftests/bpf/libarena/include/common.h
>> +++ b/tools/testing/selftests/bpf/libarena/include/common.h
>> @@ -39,6 +39,7 @@ struct {
>>  } arena __weak SEC(".maps");
>>
>>  extern const volatile u32 zero;
>> +extern volatile u64 asan_violated;
>>
>>  int arena_fls(__u64 word);
>>
>> diff --git a/tools/testing/selftests/bpf/libarena/src/asan.bpf.c b/tools=
/testing/selftests/bpf/libarena/src/asan.bpf.c
>> new file mode 100644
>> index 000000000000..b3fae0ed020c
>> --- /dev/null
>> +++ b/tools/testing/selftests/bpf/libarena/src/asan.bpf.c
>> @@ -0,0 +1,539 @@
>> +// SPDX-License-Identifier: LGPL-2.1 OR BSD-2-Clause
>> +/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
>> +#include <vmlinux.h>
>> +#include <common.h>
>> +#include <asan.h>
>> +
>> +/*
>> + * Address sanitizer (ASAN) for arena-based BPF programs. The
>> + * sanitizer tracks valid arena memory and triggers an error
>> + * when poisoned memory is read or written to. Starting point
>> + * was the KASAN implementation in mm/.
>
> KASAN part of the comment looks obsolete and not really helpful
> in isolation. "Starting point was.." so?
> How is it different ?
> If it said "inspired by KASAN" that would be read differently.
> Or just delete it.
>
>> + *
>> + * The API
>> + * -------
>> + *
>> + * The implementation includes two kinds of components: Implementation
>> + * of ASAN hooks injected by LLVM into the program, and API calls that
>> + * allocators use to mark memory as valid or invalid. The full list is:
>> + *
>> + * LLVM stubs:
>> + *
>> + * void __asan_{load, store}<size>(void *addr)
>> + *     Checks whether an access is valid. All variations covered
>> + *     by check_region_inline().
>> + *
>> + * void __asan_{store, load}((void *addr, ssize_t size)
>> + *
>> + * void __asan_report_{load, store}<size>(void *addr)
>> + *     Report an access violation for the program. Used when LLVM
>> + *     uses direct code generation for shadow map checks.
>> + *
>> + * void *__asan_memcpy(void *d, const void *s, size_t n)
>> + * void *__asan_memmove(void *d, const void *s, size_t n)
>> + * void *__asan_memset(void *p, int c, size_t n)
>> + *     Hooks for ASAN instrumentation of the LLVM mem* builtins.
>> + *     Currently unimplemented just like the builtins themselves.
>> + *
>> + * API methods:
>> + *
>> + * asan_init()
>> + *     Initialize the ASAN map for the arena.
>> + *
>> + * asan_poison()
>> + *     Mark a region of memory as poisoned. Accessing poisoned memory
>> + *     causes asan_report() to fire. Invoked during free().
>> + *
>> + * asan_unpoison()
>> + *     Mark a region as unpoisoned after alloc().
>> + *
>> + * asan_shadow_set()
>> + *     Check a byte's validity directly.
>> + *
>> + * The Algorithm In Brief
>> + * ----------------------
>> + * Each group of 8 bytes is mapped to a "granule" in the shadow map. Th=
is
>> + * granule is the size of the byte and describes which bytes are valid.
>> + * Possible values are:
>> + *
>> + * 0: All bytes are valid. Makes checks in the middle of an allocated r=
egion
>> + * (most of them) fast.
>> + * (0, 7]: How many consecutive bytes are valid, starting from the lowe=
st one.
>> + * The tradeoff is that we can't poison individual bytes in the middle =
of a
>> + * valid region.
>> + * [0x80, 0xff]: Special poison values, can be used to denote specific =
error
>> + * modes (e.g., recently freed vs uninitialized memory).
>> + *
>> + * The mapping between a memory location and its shadow is:
>> + * shadow_addr =3D shadow_base + (addr >> 3). We retain the 8:1 data:sh=
adow
>> + * ratio of existing ASAN implementations as a compromise between track=
ing
>> + * granularity and space usage/scan overhead.
>> + */
>> +
>> +#ifdef BPF_ARENA_ASAN
>> +
>> +#pragma clang attribute push(__attribute__((no_sanitize("address"))), \
>> +                            apply_to =3D function)
>> +
>> +#define SHADOW_ALL_ZEROES ((u64)-1)
>> +
>> +/*
>> + * Canary variable for ASAN violations. Set to the offending address.
>> + */
>> +volatile u64 asan_violated =3D 0;
>> +
>> +/*
>> + * Shadow map occupancy map.
>> + */
>> +volatile u64 __asan_shadow_memory_dynamic_address;
>> +
>> +volatile u32 asan_reported =3D false;
>> +volatile bool asan_inited =3D false;
>> +
>> +/*
>> + * Set during program load.
>> + */
>> +volatile bool asan_report_once =3D false;
>> +volatile bool asan_emit_stack =3D false;
>> +
>> +/*
>> + * BPF does not currently support the memset/memcpy/memcmp intrinsics.
>
> and? I don't get what comment is trying to say.
>
>> + */
>> +__weak int asan_memset(s8a __arg_arena *dst, s8 val, size_t size)
>
> right above the comment said __asan_memset is not implemented.
> Yet this is an implementation. What is significance of double underscore?
>
>> +{
>> +       size_t i;
>> +
>> +       for (i =3D zero; i < size && can_loop; i++)
>> +               dst[i] =3D val;
>> +
>> +       return 0;
>> +}
>> +
>> +/* Validate a 1-byte access, always within a single byte. */
>> +static __always_inline bool memory_is_poisoned_1(s8a *addr)
>> +{
>> +       s8 shadow_value =3D asan_shadow_value(addr);
>> +
>> +       /* Byte is 0, access is valid. */
>> +       if (likely(!shadow_value))
>> +               return false;
>> +
>> +       /*
>> +        * Byte is non-zero. Access is valid if granule offset in [0, sh=
adow_value),
>> +        * so the memory is poisoned if shadow_value is negative or smal=
ler than
>> +        * the granule's value.
>> +        */
>> +
>> +       return ASAN_GRANULE(addr) >=3D shadow_value;
>> +}
>> +
>> +/* Validate a 2- 4-, 8-byte access, shadow spans up to 2 bytes. */
>> +static __always_inline bool memory_is_poisoned_2_4_8(s8a *addr, u64 siz=
e)
>> +{
>> +       u64 end =3D (u64)addr + size - 1;
>> +
>> +       /*
>> +        * Region fully within a single byte (addition didn't
>> +        * overflow above ASAN_GRANULE).
>> +        */
>> +       if (likely(ASAN_GRANULE(end) >=3D size - 1))
>> +               return memory_is_poisoned_1((s8a *)end);
>> +
>> +       /*
>> +        * Otherwise first byte must be fully unpoisoned, and second byt=
e
>> +        * must be unpoisoned up to the end of the accessed region.
>> +        */
>> +
>> +       return asan_shadow_value(addr) || memory_is_poisoned_1((s8a *)en=
d);
>> +}
>> +
>> +/*
>> + * Explicit ASAN check.
>
> the comment is too terse to be useful.
>
>> + */
>> +__weak bool asan_shadow_set(void __arena __arg_arena *addr)
>> +{
>> +       return memory_is_poisoned_1(addr);
>> +}
>> +
>> +static __always_inline u64 first_nonzero_byte(u64 addr, size_t size)
>> +{
>> +       while (size && can_loop) {
>> +               if (unlikely(*(s8a *)addr))
>> +                       return addr;
>> +               addr +=3D 1;
>> +               size -=3D 1;
>> +       }
>> +
>> +       return SHADOW_ALL_ZEROES;
>> +}
>> +
>> +static __always_inline bool memory_is_poisoned_n(s8a *addr, u64 size)
>> +{
>> +       u64 ret;
>> +       u64 start;
>> +       u64 end;
>> +
>> +       /* Size of [start, end] is end - start + 1. */
>> +       start =3D (u64)mem_to_shadow(addr);
>> +       end =3D (u64)mem_to_shadow(addr + size - 1);
>> +
>> +       ret =3D first_nonzero_byte(start, (end - start) + 1);
>> +       if (likely(ret =3D=3D SHADOW_ALL_ZEROES))
>> +               return false;
>> +
>> +       return __builtin_expect(ret !=3D end || ASAN_GRANULE(addr + size=
 - 1) >=3D
>> +                                                     *(s8a *)end, false=
);
>
> __builtin_expect ? Use unlikely().
>
>> +}
>> +
>> +__weak int asan_report(s8a __arg_arena *addr, size_t sz,
>> +                                      bool write)
>> +{
>> +       u32 reported =3D __sync_val_compare_and_swap(&asan_reported, fal=
se, true);
>> +
>> +       /* Only report the first ASAN violation. */
>> +       if (reported && asan_report_once)
>> +               return 0;
>> +
>> +       asan_violated =3D (u64)addr;
>> +
>> +       if (asan_emit_stack) {
>> +               arena_stderr("Memory violation for address %p (0x%lx) fo=
r %s of size %ld",
>> +                               addr, (u64)addr, write ? "write" : "read=
", sz);
>> +               bpf_stream_print_stack(BPF_STDERR);
>> +       }
>> +
>> +       return 0;
>> +}
>> +
>> +static __always_inline bool check_asan_args(s8a *addr, size_t size,
>> +                                           bool *result)
>> +{
>> +       bool valid =3D true;
>> +
>> +       /* Size 0 accesses are valid even if the address is invalid. */
>> +       if (unlikely(size =3D=3D 0))
>> +               goto confirmed_valid;
>> +
>> +       /*
>> +        * Wraparound is possible for values close to the the edge of th=
e
>> +        * 4GiB boundary of the arena (last valid address is 1UL << 32 -=
 1).
>> +        *
>> +        *
>> +        * The wraparound detection below works for small sizes.check_as=
an_args is
>> +        * always called from the builtin ASAN checks, so 1 <=3D size <=
=3D 64. We do
>> +        * not implement storeN/loadN, so size is guaranteed to be in th=
at range.
>> +        * Even if we did, sane storeN/loadN intrinsics are not expected=
 to have
>> +        * a large enough size that
>> +        *
>> +        * - addr + size  > MAX_U32
>> +        * - (u32)(addr + size) > (u32) addr
>> +        *
>> +        * which would defeat wraparound detection.
>> +        */
>> +       if (unlikely((u32)(u64)(addr + size) < (u32)(u64)addr))
>> +               goto confirmed_invalid;
>> +
>> +       return false;
>
> in this path the result will stay uninitialized. Bug or not?
>
>> +
>> +confirmed_invalid:
>> +       valid =3D false;
>> +
>> +       /* FALLTHROUGH */
>> +confirmed_valid:
>> +       *result =3D valid;
>> +
>> +       return true;
>> +}
>> +
>> +static __always_inline bool check_region_inline(void *ptr, size_t size,
>> +                                               bool write)
>
> I have allergy to bool arguments.
> Please use 'u32 flags' from the day one and human readable
> enum, so the callsites are easy to read.
>
>> +{
>> +       s8a *addr =3D (s8a *)(u64)ptr;
>> +       bool is_poisoned, is_valid;
>> +
>> +       if (check_asan_args(addr, size, &is_valid)) {
>> +               if (!is_valid)
>> +                       asan_report(addr, size, write);
>> +               return is_valid;
>> +       }
>> +
>> +       switch (size) {
>> +       case 1:
>> +               is_poisoned =3D memory_is_poisoned_1(addr);
>> +               break;
>> +       case 2:
>> +       case 4:
>> +       case 8:
>> +               is_poisoned =3D memory_is_poisoned_2_4_8(addr, size);
>> +               break;
>> +       default:
>> +               is_poisoned =3D memory_is_poisoned_n(addr, size);
>> +       }
>> +
>> +       if (is_poisoned) {
>> +               asan_report(addr, size, write);
>> +               return false;
>> +       }
>> +
>> +       return true;
>> +}
>> +
>> +/*
>> + * __alias is not supported for BPF so define *__noabort() variants as =
wrappers.
>> + */
>> +#define DEFINE_ASAN_LOAD_STORE(size)                                  \
>> +       __hidden void __asan_store##size(void *addr)                  \
>> +       {                                                             \
>> +               check_region_inline(addr, size, true);                \
>> +       }                                                             \
>> +       __hidden void __asan_store##size##_noabort(void *addr)        \
>> +       {                                                             \
>> +               check_region_inline(addr, size, true);                \
>> +       }                                                             \
>> +       __hidden void __asan_load##size(void *addr)                   \
>> +       {                                                             \
>> +               check_region_inline(addr, size, false);               \
>> +       }                                                             \
>> +       __hidden void __asan_load##size##_noabort(void *addr)         \
>> +       {                                                             \
>> +               check_region_inline(addr, size, false);               \
>
> unlike here where false vs true is not meaningful without
> reading the prototype.
>
>> +       }                                                             \
>> +       __hidden void __asan_report_store##size(void *addr)           \
>> +       {                                                             \
>> +               asan_report((s8a *)addr, size, true);                 \
>> +       }                                                             \
>> +       __hidden void __asan_report_store##size##_noabort(void *addr) \
>> +       {                                                             \
>> +               asan_report((s8a *)addr, size, true);                 \
>> +       }                                                             \
>> +       __hidden void __asan_report_load##size(void *addr)            \
>> +       {                                                             \
>> +               asan_report((s8a *)addr, size, false);                \
>> +       }                                                             \
>> +       __hidden void __asan_report_load##size##_noabort(void *addr)  \
>> +       {                                                             \
>> +               asan_report((s8a *)addr, size, false);                \
>> +       }
>> +
>> +DEFINE_ASAN_LOAD_STORE(1);
>> +DEFINE_ASAN_LOAD_STORE(2);
>> +DEFINE_ASAN_LOAD_STORE(4);
>> +DEFINE_ASAN_LOAD_STORE(8);
>> +
>> +void __asan_storeN(void *addr, ssize_t size)
>> +{
>> +       check_region_inline(addr, size, true);
>> +}
>> +
>> +void __asan_loadN(void *addr, ssize_t size)
>> +{
>> +       check_region_inline(addr, size, false);
>> +}
>> +
>> +/*
>> + * We currently do not sanitize globals.
>> + */
>> +void __asan_register_globals(void *globals, size_t n)
>> +{
>> +}
>> +
>> +void __asan_unregister_globals(void *globals, size_t n)
>> +{
>> +}
>> +
>> +/*
>> + * We do not currently have memcpy/memmove/memset intrinsics
>> + * in LLVM. Do not implement sanitization.
>> + */
>> +void *__asan_memcpy(void *d, const void *s, size_t n)
>> +{
>> +       arena_stderr("ASAN: Unexpected %s call", __func__);
>> +       return NULL;
>> +}
>> +
>> +void *__asan_memmove(void *d, const void *s, size_t n)
>> +{
>> +       arena_stderr("ASAN: Unexpected %s call", __func__);
>> +       return NULL;
>> +}
>> +
>> +void *__asan_memset(void *p, int c, size_t n)
>> +{
>> +       arena_stderr("ASAN: Unexpected %s call", __func__);
>> +       return NULL;
>> +}
>> +
>> +/*
>> + * Poisoning code, used when we add more freed memory to the allocator =
by:
>> + *     a) pulling memory from the arena segment using bpf_arena_alloc_p=
ages()
>> + *     b) freeing memory from application code
>> + */
>> +__hidden __noasan int asan_poison(void __arena *addr, s8 val, size_t si=
ze)
>> +{
>> +       s8a *shadow;
>> +       size_t len;
>> +
>> +       /*
>> +        * Poisoning from a non-granule address makes no sense: We can o=
nly allocate
>> +        * memory to the application that has a granule-aligned starting=
 address,
>> +        * and bpf_arena_alloc_pages returns page-aligned memory. A non-=
aligned
>> +        * addr then implies we're freeing a different address than the =
one we
>> +        * allocated.
>> +        */
>> +       if (unlikely((u64)addr & ASAN_GRANULE_MASK))
>> +               return -EINVAL;
>> +
>> +       /*
>> +        * We cannot free an unaligned region because it'd be possible t=
hat we
>> +        * cannot describe the resulting poisoning state of the granule =
in
>> +        * the ASAN encoding.
>> +        *
>> +        * Every granule represents a region of memory that looks like t=
he
>> +        * following (P for poisoned bytes, C for clear):
>> +        *
>> +        * <Clear>  <Poisoned>
>> +        * [ C C C ... P P ]
>> +        *
>> +        * The value of the granule's shadow map is the number of clear =
bytes in
>> +        * it. We cannot represent granules with the following state:
>> +        *
>> +        * [ P P ... C C ... P P ]
>> +        *
>> +        * That would be possible if we could free unaligned regions, so=
 prevent that.
>> +        */
>> +       if (unlikely(size & ASAN_GRANULE_MASK))
>> +               return -EINVAL;
>> +
>> +       shadow =3D mem_to_shadow(addr);
>> +       len =3D size >> ASAN_SHADOW_SHIFT;
>> +
>> +       asan_memset(shadow, val, len);
>> +
>> +       return 0;
>> +}
>> +
>> +/*
>> + * Unpoisoning code for marking memory as valid during allocation calls=
.
>> + *
>> + * Very similar to asan_poison, except we need to round up instead of
>> + * down, then partially poison the last granule if necessary.
>> + *
>> + * Partial poisoning is useful for keeping the padding poisoned. Alloca=
tions
>> + * are granule-aligned, so we we're reserving granule-aligned sizes for=
 the
>> + * allocation. However, we want to still treat accesses to the padding =
as
>> + * invalid. Partial poisoning takes care of that. Freeing and poisoning=
 the
>> + * memory is still done in granule-aligned sizes and repoisons the alre=
ady
>> + * poisoned padding.
>> + */
>> +__hidden __noasan int asan_unpoison(void __arena *addr, size_t size)
>> +{
>> +       size_t partial =3D size & ASAN_GRANULE_MASK;
>> +       s8a *shadow;
>> +       size_t len;
>> +
>> +       /*
>> +        * We cannot allocate in the middle of the granule. The ASAN sha=
dow
>> +        * map encoding only describes regions of memory where every gra=
nule
>> +        * follows this format (P for poisoned, C for clear):
>> +        *
>> +        * <Clear>  <Poisoned>
>> +        * [ C C C ... P P ]
>> +        *
>> +        * This is so we can use a single number in [0, ASAN_SHADOW_SCAL=
E)
>> +        * to represent the poison state of the granule.
>> +        */
>> +       if (unlikely((u64)addr & ASAN_GRANULE_MASK))
>> +               return -EINVAL;
>> +
>> +       shadow =3D mem_to_shadow(addr);
>> +       len =3D size >> ASAN_SHADOW_SHIFT;
>> +
>> +       asan_memset(shadow, 0, len);
>> +
>> +       /*
>> +        * If we are allocating a non-granule aligned region, we need to=
 adjust
>> +        * the last byte of the shadow map to list how many bytes in the=
 granule
>> +        * are unpoisoned. If the region is aligned, then the memset cal=
l above
>> +        * was enough.
>> +        */
>> +       if (partial)
>> +               shadow[len] =3D partial;
>> +
>> +       return 0;
>> +}
>> +
>> +/*
>> + * Initialize ASAN state when necessary. Triggered from userspace befor=
e
>> + * allocator startup.
>> + */
>> +SEC("syscall")
>> +__hidden __noasan int asan_init(struct asan_init_args *args)
>> +{
>> +       u64 globals_pages =3D args->arena_globals_pages;
>> +       u64 all_pages =3D args->arena_all_pages;
>> +       u64 shadowmap, shadow_pgoff;
>
> shadowmap stands out. shadow_map ?
>
>> +       u64 shadow_pages;
>> +
>> +       if (asan_inited)
>> +               return 0;
>> +
>> +       /*
>> +        * Round up the shadow map size to the nearest page.
>> +        */
>> +       shadow_pages =3D all_pages >> ASAN_SHADOW_SHIFT;
>> +       if ((all_pages & ((1 << ASAN_SHADOW_SHIFT) -1 )))
>> +               shadow_pages +=3D 1;
>> +
>> +       /*
>> +        * Make sure the numbers provided by userspace are sane.
>> +        */
>
> not a helpful comment.
>
>> +       if (all_pages > (1ULL << 32) / __PAGE_SIZE) {
>> +               arena_stderr("error: arena size %lx too large", all_page=
s);
>> +               return -EINVAL;
>> +       }
>> +
>> +       if (globals_pages > all_pages) {
>> +               arena_stderr("error: globals %lx do not fit in arena %lx=
", globals_pages, all_pages);
>> +               return -EINVAL;
>> +       }
>> +
>> +       if (globals_pages + shadow_pages > all_pages) {
>> +               arena_stderr("error: globals %lx do not leave room for s=
hadow map %lx (arena pages %lx)",
>> +                       globals_pages, shadow_pages, all_pages);
>> +               return -EINVAL;
>> +       }
>> +
>> +       shadow_pgoff =3D all_pages - shadow_pages - globals_pages;
>> +       __asan_shadow_memory_dynamic_address =3D shadow_pgoff * __PAGE_S=
IZE;
>> +
>> +       /*
>> +        * Allocate the last (1/ASAN_SHADOW_SCALE)th of an arena's pages=
 for the map
>> +        * We find the offset and size from the arena map.
>> +        *
>> +        * The allocated map pages are zeroed out, meaning all memory is=
 marked as valid
>> +        * even if it's not allocated already. This is expected: Since t=
he actual memory
>> +        * pages are not allocated, accesses to it will trigger page fau=
lts and will be
>> +        * reported through BPF streams. Any pages allocated through bpf=
_arena_alloc_pages
>> +        * should be poisoned by the allocator right after the call succ=
eeds.
>> +        */
>> +       shadowmap =3D (u64)bpf_arena_alloc_pages(
>> +               &arena, (void __arena *)__asan_shadow_memory_dynamic_add=
ress,
>> +               shadow_pages, NUMA_NO_NODE, 0);
>> +       if (!shadowmap) {
>> +               arena_stderr("Could not allocate shadow map\n");
>> +
>> +               __asan_shadow_memory_dynamic_address =3D 0;
>> +
>> +               return -ENOMEM;
>> +       }
>> +
>> +       asan_inited =3D true;
>> +
>> +       return 0;
>> +}
>> +
>> +#pragma clang attribute pop
>> +
>> +#endif /* BPF_ARENA_ASAN */
>> +
>> +__weak char _license[] SEC("license") =3D "GPL";
>> diff --git a/tools/testing/selftests/bpf/libarena/src/common.bpf.c b/too=
ls/testing/selftests/bpf/libarena/src/common.bpf.c
>> index cbb729290d3c..31acb259ec5a 100644
>> --- a/tools/testing/selftests/bpf/libarena/src/common.bpf.c
>> +++ b/tools/testing/selftests/bpf/libarena/src/common.bpf.c
>> @@ -1,6 +1,7 @@
>>  // SPDX-License-Identifier: LGPL-2.1 OR BSD-2-Clause
>>  /* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
>>  #include <common.h>
>> +#include <asan.h>
>>
>>  const volatile u32 zero =3D 0;
>>
>> --
>> 2.53.0
>>

