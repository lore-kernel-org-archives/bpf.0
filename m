Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22CD213D51E
	for <bpf@vger.kernel.org>; Thu,  9 Apr 2026 00:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775693903; cv=none; b=ieZGKbANqodiOVGZqY/j9H/PdXL6ImuKEGTml+Ak6rDiJGj6p5lGHFo+b4yP1biU1P8Nde/K4WnQRJO8GyG4st0NTQrQtovKm9OYgibgGRp6eI2F9nMAnHIi2+bKYGPOhheLybNoXZqnrsjoGtDD3x77Z2rx4Q4SWaKsFacoEv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775693903; c=relaxed/simple;
	bh=iikOEJhoVVsmchKJ9jTX98v9o1gCQhU8Uqeqe5e1h5o=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=Vsfl+GbV6QMAsj9QYVWYroiCxIZlAk8R4Dlrn7ZPHW+P2WVZG1vk+sfRB8ItAbHiC1Mct5oTewqAaJeVkNAVo95Rsnjl8y3ycA47vqzEyUaUQ6hI6ogQQaeuvQk51EF9ltH7QD94A/VIDz4dDuviUHzQPeiWOHxxTa/EWI9Z+s4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=RSKKbCh9; arc=none smtp.client-ip=74.125.82.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="RSKKbCh9"
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-2cd339aeab4so207106eec.0
        for <bpf@vger.kernel.org>; Wed, 08 Apr 2026 17:18:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1775693901; x=1776298701; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bSsUx+8szH7wKhAXpJkNZR2tFt0dpjdi4+mk3Ll7jjg=;
        b=RSKKbCh9phxvP0go/Kwxmx6RVc0GIVkN70EoFLu6+xVu1CJM8zwotxxRB97tJBq2M0
         n8ANuDB/KgBplY/zZU7No3mqaKPLiTO8sJukCN19xmUfBrVVkg8L4D+sYjeoUgLvH+H8
         Acy3uY3em7L08rJ0SvQj1qMJaZ7i6ELhlZVU2E+RKG0zbh+OrO4/Diempggcxwm+NiaY
         ZRrQOmG/oZybpQJX0a5+A1EETewwW6GVAK7cMxttrlWSnKuOJQHkyPQWgwJs83lUtkoj
         dt4Dp2MH4A+qiiFE2mTX+/PA/zDVWz+CAiPvk6OnIQ5Qdmp/plmAnZf4o1q+kIDC0QjF
         +Msw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775693901; x=1776298701;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bSsUx+8szH7wKhAXpJkNZR2tFt0dpjdi4+mk3Ll7jjg=;
        b=XwaZupHT/nxw90yGgT6hmjPaIAzcyIx9DCrvDGS9xsXmP5bK8HKjybxt4ysS63PYBD
         uX1q2y8k6e7A4KEYoThroCSIdvfGZNfTYCunxFu9ltG73jwmVCiDJ+wccPFG9J+rAJ85
         +e8pBlsdr7n0+S8ags24R8SnDRVHEPmFAQKcJmvvlCbEkpn5XiKwXDxJFYnjSAxhTEE+
         Qe6JvXP6u75gt/YMDxG4M8jRQT2CAxqcgydjvfYmsvjqszpJRxPwFYMZa4lIGssMadnS
         hXLkcjT8DnnNjPawB74jR0JzdfFEJy/TXwSoQoZso2q0yahQmy8Qzq2L4TftEyP+OKuq
         Bp3A==
X-Gm-Message-State: AOJu0YwtiZQ0moAiG6JpxLPZIuqENg69AHqrZ5AdmNG3WW5Itg+JPy+2
	x3AMRhXS/RFkCp3nMoGLv0dsLB8KtaAAPjPGUZwacZ6//ZB08zvFByUEMqCe6gR3cMA=
X-Gm-Gg: AeBDievjOy+law27X4NEoMhFUKoDNXrMBKt+IKvMGG+zK5YB9WD8aDF5zeZMAwFrSv6
	XL72vGvPSRxsmtck9Ud7F/w9src/I3PWg9/Gz0kCDLWCB4polHTua3R57ORsHZKP4UUxwUhf6Jl
	pAqLd8dZluE5F1jxANXYf8eDwyQCoX6LXd3qum9/mV7SUFq5SkVLlNl1KQrTyl5EGMoGWGCm43H
	ShVcsD5aPckd0AmfD13yz2KOhoLmeNZsCsT2eL8r7k9t7wJmzG/aqxEgOEMpLD8v0Reisp/aEFs
	TU7z/Ap92Gf6rgZ6ccqy1+hP9XdPhsc2QtSYTnAv8MOwAp5PlDcv0IXZU7zuruGz99BfszGPVXx
	FPglOEiophT0Pi+wI3Et3RUZEnVN9+J0pIWav+euM2yCRvrqwxHMyAZCA2GR4OjzEM2/E7WMViE
	TTkU+H
X-Received: by 2002:a05:7300:8c03:b0:2d0:239a:23c9 with SMTP id 5a478bee46e88-2d40defb854mr841470eec.16.1775693900990;
        Wed, 08 Apr 2026 17:18:20 -0700 (PDT)
Received: from localhost ([2620:10d:c090:600::68e1])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2cc6e17e0bdsm19646856eec.31.2026.04.08.17.18.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Apr 2026 17:18:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 08 Apr 2026 20:18:18 -0400
Message-Id: <DHO6YBPIPV5A.ZIBDPIXBG1NT@etsalapatis.com>
Cc: "bpf" <bpf@vger.kernel.org>, "Alexei Starovoitov" <ast@kernel.org>,
 "Andrii Nakryiko" <andrii@kernel.org>, "Kumar Kartikeya Dwivedi"
 <memxor@gmail.com>, "Daniel Borkmann" <daniel@iogearbox.net>, "Eduard"
 <eddyz87@gmail.com>, "Song Liu" <song@kernel.org>
Subject: Re: [PATCH bpf-next v4 5/9] selftests/bpf: Add basic libarena
 scaffolding
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>, "Emil Tsalapatis"
 <emil@etsalapatis.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260407045730.13359-1-emil@etsalapatis.com>
 <20260407045730.13359-6-emil@etsalapatis.com>
 <CAADnVQLCyP+NzO9-332JO+dBe=EDEOr+ax+-ZrvAqJ9yTNYyEA@mail.gmail.com>
In-Reply-To: <CAADnVQLCyP+NzO9-332JO+dBe=EDEOr+ax+-ZrvAqJ9yTNYyEA@mail.gmail.com>

On Tue Apr 7, 2026 at 12:21 PM EDT, Alexei Starovoitov wrote:
> On Mon, Apr 6, 2026 at 9:57=E2=80=AFPM Emil Tsalapatis <emil@etsalapatis.=
com> wrote:
>>
>> Add initial code for an arena-based BPF library. The current commit
>> introduces a test runner and Makefile for the library. Library code
>> can be added just by including the source file in the library's src/
>> subdirectory. Future commits will introduce the library code itself.
>>
>> The current commit also includes a standalone test runner. This is
>> to keep libarena self-contained and testable even when copied out
>> of the kernel tree. Subsequent commits add integration with test_progs.
>>
>> Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
>> ---
>>  tools/testing/selftests/bpf/.gitignore        |   1 +
>>  tools/testing/selftests/bpf/Makefile          |  15 ++
>>  tools/testing/selftests/bpf/libarena/Makefile |  50 ++++++
>>  .../selftests/bpf/libarena/include/common.h   |  49 ++++++
>>  .../bpf/libarena/include/selftest_helpers.h   |  81 ++++++++++
>>  .../selftests/bpf/libarena/include/userapi.h  |  26 +++
>>  .../bpf/libarena/selftests/selftest.c         | 153 ++++++++++++++++++
>>  .../bpf/libarena/selftests/selftest.h         |  12 ++
>>  .../selftests/bpf/libarena/src/common.bpf.c   |  65 ++++++++
>>  9 files changed, 452 insertions(+)
>>  create mode 100644 tools/testing/selftests/bpf/libarena/Makefile
>>  create mode 100644 tools/testing/selftests/bpf/libarena/include/common.=
h
>>  create mode 100644 tools/testing/selftests/bpf/libarena/include/selftes=
t_helpers.h
>>  create mode 100644 tools/testing/selftests/bpf/libarena/include/userapi=
.h
>>  create mode 100644 tools/testing/selftests/bpf/libarena/selftests/selft=
est.c
>>  create mode 100644 tools/testing/selftests/bpf/libarena/selftests/selft=
est.h
>>  create mode 100644 tools/testing/selftests/bpf/libarena/src/common.bpf.=
c
>>
>> diff --git a/tools/testing/selftests/bpf/.gitignore b/tools/testing/self=
tests/bpf/.gitignore
>> index bfdc5518ecc8..7f1960d6b59e 100644
>> --- a/tools/testing/selftests/bpf/.gitignore
>> +++ b/tools/testing/selftests/bpf/.gitignore
>> @@ -49,3 +49,4 @@ verification_cert.h
>>  *.BTF.base
>>  usdt_1
>>  usdt_2
>> +libarena/test_libarena
>> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selfte=
sts/bpf/Makefile
>> index f75c4f52c028..0d332c991023 100644
>> --- a/tools/testing/selftests/bpf/Makefile
>> +++ b/tools/testing/selftests/bpf/Makefile
>> @@ -153,6 +153,7 @@ override define CLEAN
>>         $(Q)$(RM) -r $(TEST_KMODS)
>>         $(Q)$(RM) -r $(EXTRA_CLEAN)
>>         $(Q)$(MAKE) -C test_kmods clean
>> +       $(Q)$(MAKE) -C libarena clean
>>         $(Q)$(MAKE) docs-clean
>>  endef
>>
>> @@ -739,6 +740,17 @@ $(VERIFY_SIG_HDR): $(VERIFICATION_CERT)
>>          echo "};"; \
>>          echo "unsigned int test_progs_verification_cert_len =3D $$(wc -=
c < $<);") > $@
>>
>> +LIBARENA_MAKE_ARGS =3D \
>> +               BPFTOOL=3D"$(BPFTOOL)" \
>> +               INCLUDE_DIR=3D"$(HOST_INCLUDE_DIR)" \
>> +               LIBBPF_INCLUDE=3D"$(HOST_INCLUDE_DIR)" \
>> +               BPFOBJ=3D"$(BPFOBJ)" \
>> +               LDLIBS=3D"$(LDLIBS) -lzstd" \
>> +               CLANG=3D"$(CLANG)" \
>> +               BPF_CFLAGS=3D"$(BPF_CFLAGS) $(CLANG_CFLAGS)" \
>> +               BPF_TARGET_ENDIAN=3D"$(BPF_TARGET_ENDIAN)" \
>> +               Q=3D"$(Q)"
>> +
>>  # Define test_progs test runner.
>>  TRUNNER_TESTS_DIR :=3D prog_tests
>>  TRUNNER_BPF_PROGS_DIR :=3D progs
>> @@ -931,3 +943,6 @@ override define INSTALL_RULE
>>                 rsync -a $(OUTPUT)/$$DIR/*.bpf.o $(INSTALL_PATH)/$$DIR;\
>>         done
>>  endef
>> +
>> +test_libarena: $(INCLUDE_DIR)/vmlinux.h $(BPFOBJ)
>> +       +$(MAKE) -C libarena $@ $(LIBARENA_MAKE_ARGS)
>> diff --git a/tools/testing/selftests/bpf/libarena/Makefile b/tools/testi=
ng/selftests/bpf/libarena/Makefile
>> new file mode 100644
>> index 000000000000..151ab6d0509c
>> --- /dev/null
>> +++ b/tools/testing/selftests/bpf/libarena/Makefile
>> @@ -0,0 +1,50 @@
>> +# SPDX-License-Identifier: LGPL-2.1 OR BSD-2-Clause
>> +# Copyright (c) 2026 Meta Platforms, Inc. and affiliates.
>> +
>> +.PHONY: clean
>> +
>> +LIBARENA=3D$(abspath .)
>> +
>> +
>> +LIBARENA_SOURCES =3D $(wildcard $(LIBARENA)/src/*.bpf.c) $(wildcard $(L=
IBARENA)/selftests/*.bpf.c)
>> +LIBARENA_OBJECTS =3D $(notdir $(LIBARENA_SOURCES:.bpf.c=3D.bpf.o))
>> +
>> +INCLUDES =3D -I$(LIBARENA)/include -I$(LIBARENA)/..
>> +ifneq ($(INCLUDE_DIR),)
>> +INCLUDES +=3D -I$(INCLUDE_DIR)
>> +endif
>> +ifneq ($(LIBBPF_INCLUDE),)
>> +INCLUDES +=3D -I$(LIBBPF_INCLUDE)
>> +endif
>> +
>> +# ENABLE_ATOMICS_TESTS required because we use arena spinlocks
>> +override BPF_CFLAGS +=3D -DENABLE_ATOMICS_TESTS
>> +override BPF_CFLAGS +=3D -O2 -Wno-incompatible-pointer-types-discards-q=
ualifiers
>> +override BPF_CFLAGS +=3D $(INCLUDES)
>> +
>> +CFLAGS =3D -O2 -no-pie
>> +CFLAGS +=3D $(INCLUDES)
>> +
>> +vpath %.bpf.c $(LIBARENA)/src $(LIBARENA)/selftests
>> +vpath %.c $(LIBARENA)/src $(LIBARENA)/selftests
>> +
>> +all: test_libarena
>> +
>> +test_libarena: selftest.c $(BPFOBJ) libarena.skel.h
>> +       $(call msg,BINARY,libarena,$@)
>> +       $(Q)$(CLANG) $(CFLAGS) $< $(BPFOBJ) $(LDLIBS) -o $@
>> +
>> +libarena.skel.h: main.bpf.o
>> +       $(call msg,GEN-SKEL,libarena,$@)
>> +       $(Q)$(BPFTOOL) gen skeleton $< name "libarena" > $@
>> +
>> +main.bpf.o: $(LIBARENA_OBJECTS)
>> +       $(call msg,GEN-OBJ,libarena,$@)
>> +       $(Q)$(BPFTOOL) gen object $@ $^
>> +
>> +%.bpf.o: %.bpf.c
>> +       $(call msg,CLNG-BPF,libarena,$@)
>> +       $(Q)$(CLANG) $(BPF_CFLAGS) $(BPF_TARGET_ENDIAN) -c $< -o $@
>> +
>> +clean:
>> +       $(Q)rm -f *.skel.h *.bpf.o test_libarena
>> diff --git a/tools/testing/selftests/bpf/libarena/include/common.h b/too=
ls/testing/selftests/bpf/libarena/include/common.h
>> new file mode 100644
>> index 000000000000..544a398a0d1e
>> --- /dev/null
>> +++ b/tools/testing/selftests/bpf/libarena/include/common.h
>> @@ -0,0 +1,49 @@
>> +// SPDX-License-Identifier: LGPL-2.1 OR BSD-2-Clause
>> +/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
>> +#pragma once
>> +
>> +#ifdef __BPF__
>
> Are you trying to re-use this common.h in user space code?
>
>> +
>> +#include <vmlinux.h>
>> +
>> +#include "bpf_experimental.h"
>> +#include "bpf_arena_common.h"
>> +#include "bpf_arena_spin_lock.h"
>> +
>> +#include <asm-generic/errno.h>
>> +
>> +#ifndef __BPF_FEATURE_ADDR_SPACE_CAST
>> +#error "Arena allocators require bpf_addr_space_cast feature"
>> +#endif
>> +
>> +#define arena_stdout(fmt, ...) bpf_stream_printk(1, (fmt), ##__VA_ARGS_=
_)
>> +#define arena_stderr(fmt, ...) bpf_stream_printk(2, (fmt), ##__VA_ARGS_=
_)
>> +
>> +#ifndef __maybe_unused
>> +#define __maybe_unused __attribute__((__unused__))
>> +#endif
>> +
>> +#define private(name) SEC(".data." #name) __hidden __attribute__((align=
ed(8)))
>> +
>> +#define ARENA_PAGES (1UL << (32 - __builtin_ffs(__PAGE_SIZE) + 1))
>> +
>> +struct {
>> +       __uint(type, BPF_MAP_TYPE_ARENA);
>> +       __uint(map_flags, BPF_F_MMAPABLE);
>> +       __uint(max_entries, ARENA_PAGES); /* number of pages */
>> +#if defined(__TARGET_ARCH_arm64) || defined(__aarch64__)
>> +        __ulong(map_extra, (1ull << 32)); /* start of mmap() region */
>> +#else
>> +        __ulong(map_extra, (1ull << 44)); /* start of mmap() region */
>> +#endif
>> +} arena __weak SEC(".maps");
>> +
>> +extern const volatile u32 zero;
>> +
>> +int arena_fls(__u64 word);
>> +
>> +#endif /* __BPF__ */
>> +
>> +struct arena_get_base_args {
>> +       void __arena *arena_base;
>> +};
>
> If so, then how above suppose to compile in user space?
> __arena is not defined yet.
>
>> diff --git a/tools/testing/selftests/bpf/libarena/include/selftest_helpe=
rs.h b/tools/testing/selftests/bpf/libarena/include/selftest_helpers.h
>> new file mode 100644
>> index 000000000000..ee445d8f5b26
>> --- /dev/null
>> +++ b/tools/testing/selftests/bpf/libarena/include/selftest_helpers.h
>> @@ -0,0 +1,81 @@
>> +// SPDX-License-Identifier: LGPL-2.1 OR BSD-2-Clause
>> +/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
>> +#pragma once
>> +
>> +#include <errno.h>
>> +#include <stdlib.h>
>> +#include <unistd.h>
>> +#include <sys/mman.h>
>> +
>> +#include <bpf/libbpf.h>
>> +#include <bpf/bpf.h>
>> +
>> +static inline int libarena_run_prog(int prog_fd)
>> +{
>> +       LIBBPF_OPTS(bpf_test_run_opts, opts);
>> +       int ret;
>> +
>> +       ret =3D bpf_prog_test_run_opts(prog_fd, &opts);
>> +       if (ret)
>> +               return ret;
>> +
>> +       return opts.retval;
>> +}
>> +
>> +static inline int libarena_get_arena_base(int arena_get_base_fd,
>> +                                         void **arena_base)
>> +{
>> +       LIBBPF_OPTS(bpf_test_run_opts, opts);
>> +       struct arena_get_base_args args =3D { .arena_base =3D NULL };
>> +       int ret;
>> +
>> +       opts.ctx_in =3D &args;
>> +       opts.ctx_size_in =3D sizeof(args);
>> +
>> +       ret =3D bpf_prog_test_run_opts(arena_get_base_fd, &opts);
>> +       if (ret)
>> +               return ret;
>> +       if (opts.retval)
>> +               return opts.retval;
>> +
>> +       *arena_base =3D args.arena_base;
>> +       return 0;
>> +}
>> +
>> +static inline int libarena_get_globals_pages(int arena_get_base_fd,
>> +                                            size_t arena_all_pages,
>> +                                            u64 *globals_pages)
>> +{
>> +       size_t pgsize =3D sysconf(_SC_PAGESIZE);
>> +       void *arena_base;
>> +       ssize_t i;
>> +       u8 *vec;
>> +       int ret;
>> +
>> +       ret =3D libarena_get_arena_base(arena_get_base_fd, &arena_base);
>> +       if (ret)
>> +               return ret;
>> +
>> +       if (!arena_base)
>> +               return -EINVAL;
>> +
>> +       vec =3D calloc(arena_all_pages, sizeof(*vec));
>> +       if (!vec)
>> +               return -ENOMEM;
>> +
>> +       if (mincore(arena_base, arena_all_pages * pgsize, vec) < 0) {
>> +               ret =3D -errno;
>> +               free(vec);
>> +               return ret;
>> +       }
>> +
>> +       *globals_pages =3D 0;
>> +       for (i =3D arena_all_pages - 1; i >=3D 0; i--) {
>> +               if (!(vec[i] & 0x1))
>> +                       break;
>> +               *globals_pages +=3D 1;
>> +       }
>> +
>> +       free(vec);
>> +       return 0;
>> +}
>> diff --git a/tools/testing/selftests/bpf/libarena/include/userapi.h b/to=
ols/testing/selftests/bpf/libarena/include/userapi.h
>> new file mode 100644
>> index 000000000000..b4ac6bc9bd79
>> --- /dev/null
>> +++ b/tools/testing/selftests/bpf/libarena/include/userapi.h
>> @@ -0,0 +1,26 @@
>> +// SPDX-License-Identifier: LGPL-2.1 OR BSD-2-Clause
>> +/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
>> +#pragma once
>> +
>> +#include <stdint.h>
>> +
>> +/*
>> + * Header for the userspace C programs that load
>> + * and initialize the BPF code.
>> + */
>> +
>> +#define __arena
>> +
>> +typedef uint8_t u8;
>> +typedef uint16_t u16;
>> +typedef uint32_t u32;
>> +typedef uint64_t u64;
>> +typedef int8_t s8;
>> +typedef int16_t s16;
>> +typedef int32_t s32;
>> +typedef int64_t s64;
>> +
>> +/* Dummy "definition" for userspace. */
>> +#define arena_spinlock_t u64
>> +
>> +#include "common.h"
>
> ohh. So user space _must_ include userapi.h first ?
> Why is this not part of common.h ?
> Why bother with extra userapi.h header?
>
>> diff --git a/tools/testing/selftests/bpf/libarena/selftests/selftest.c b=
/tools/testing/selftests/bpf/libarena/selftests/selftest.c
>> new file mode 100644
>> index 000000000000..b69adc7baaab
>> --- /dev/null
>> +++ b/tools/testing/selftests/bpf/libarena/selftests/selftest.c
>> @@ -0,0 +1,153 @@
>> +// SPDX-License-Identifier: LGPL-2.1 OR BSD-2-Clause
>> +/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
>> +
>> +#define _GNU_SOURCE
>> +#include <assert.h>
>> +#include <errno.h>
>> +#include <stdio.h>
>> +#include <string.h>
>> +#include <unistd.h>
>> +
>> +#include <bpf/libbpf.h>
>> +#include <bpf/bpf.h>
>> +
>> +#include <sys/mman.h>
>> +#include <sys/resource.h>
>> +#include <sys/sysinfo.h>
>> +
>> +#include <userapi.h>
>> +#include <selftest_helpers.h>
>> +
>> +#include "../libarena.skel.h"
>> +typedef struct libarena selftest;
>> +#define selftest__open libarena__open
>> +#define selftest__open_and_load libarena__open_and_load
>> +#define selftest__load libarena__load
>> +#define selftest__attach libarena__attach
>> +#define selftest__destroy libarena__destroy
>
> I don't like this obfuscation.
> What's the point of these #define-s?
>
>> +
>> +static bool verbose =3D false;
>> +static int testno =3D 1;
>> +
>> +static int
>> +run_prog_verbose(int prog_fd)
>> +{
>> +       char buf[1024];
>> +       int ret, err;
>> +
>> +       ret =3D libarena_run_prog(prog_fd);
>> +
>> +       if (ret)
>> +               fprintf(stderr, "error %d in %s\n", ret, __func__);
>> +
>> +       if (verbose) {
>> +               printf("BPF stdout:\n");
>> +               while ((err =3D bpf_prog_stream_read(prog_fd, 1, buf, 10=
24, NULL)) > 0)
>> +                       printf("%.*s", err, buf);
>> +
>> +               if (err)
>> +                       return err;
>> +
>> +               printf("BPF stderr:\n");
>> +               while ((err =3D bpf_prog_stream_read(prog_fd, 2, buf, 10=
24, NULL)) > 0)
>> +                       printf("%.*s", err, buf);
>> +
>> +               if (err)
>> +                       return err;
>> +       }
>> +
>> +       return ret;
>> +}
>> +
>> +static int libbpf_print_fn(enum libbpf_print_level level,
>> +               const char *format, va_list args)
>> +{
>> +       if (level =3D=3D LIBBPF_DEBUG)
>> +               return 0;
>> +       return vfprintf(stderr, format, args);
>> +}
>> +
>> +int run_test(selftest *skel, const struct bpf_program *prog)
>> +{
>> +       int prog_fd;
>> +       int ret;
>> +
>> +       ret =3D libarena_run_prog(bpf_program__fd(skel->progs.arena_allo=
c_reserve));
>> +       if (ret)
>> +               return ret;
>> +
>> +       prog_fd =3D bpf_program__fd(prog);
>> +       if (prog_fd < 0)
>> +               return prog_fd;
>> +
>> +       return run_prog_verbose(prog_fd);
>> +}
>> +
>> +#define TEST(__test)                                   \
>> +int run_##__test(void)                                 \
>> +{                                                      \
>> +       selftest *skel;                                 \
>> +       int ret;                                        \
>> +                                                       \
>> +       skel =3D selftest__open_and_load();               \
>> +       if (!skel) {                                    \
>> +               ret =3D -EINVAL;                          \
>> +               goto error_no_destroy;                  \
>> +       }                                               \
>> +                                                       \
>> +       ret =3D selftest__attach(skel);                   \
>> +       if (ret)                                        \
>> +               goto error;                             \
>> +                                                       \
>> +       ret =3D run_test(skel, skel->progs.__test);       \
>> +       if (ret)                                        \
>> +               goto error;                             \
>> +                                                       \
>> +       selftest__destroy(skel);                        \
>> +                                                       \
>> +       printf("ok %d - %s\n", testno++, #__test);      \
>> +       return 0;                                       \
>> +                                                       \
>> +error:                                                 \
>> +       selftest__destroy(skel);                        \
>> +error_no_destroy:                                      \
>> +       printf("not ok %d - %s\n", testno++, #__test);  \
>> +       return ret;                                     \
>> +}
>> +
>> +static void
>> +banner(const char *progpath)
>> +{
>> +       char *name =3D basename(progpath);
>> +
>> +       printf("%s\n", name);
>> +
>> +       printf("=3D=3D=3D %s =3D=3D=3D\n", "libarena selftests");
>> +}
>> +
>> +int main(int argc, char *argv[])
>> +{
>> +       int ret;
>> +
>> +       struct rlimit rlim =3D {
>> +               .rlim_cur =3D RLIM_INFINITY,
>> +               .rlim_max =3D RLIM_INFINITY,
>> +       };
>> +
>> +       banner(argv[0]);
>> +
>> +       for (int i =3D 1; i < argc; i++) {
>> +               if (strcmp(argv[i], "-v") =3D=3D 0 || strcmp(argv[i], "-=
-verbose") =3D=3D 0)
>> +                       verbose =3D true;
>> +       }
>> +
>> +       ret =3D setrlimit(RLIMIT_MEMLOCK, &rlim);
>
> where did you copy this from?
> It wasn't necessary for very long time.
>
>> +       if (ret) {
>> +               perror("setrlimit");
>> +               return ret;
>> +       }
>> +
>> +       libbpf_set_print(libbpf_print_fn);
>> +
>> +       return 0;
>> +}
>> diff --git a/tools/testing/selftests/bpf/libarena/selftests/selftest.h b=
/tools/testing/selftests/bpf/libarena/selftests/selftest.h
>> new file mode 100644
>> index 000000000000..b1cbff4d343b
>> --- /dev/null
>> +++ b/tools/testing/selftests/bpf/libarena/selftests/selftest.h
>> @@ -0,0 +1,12 @@
>> +// SPDX-License-Identifier: LGPL-2.1 OR BSD-2-Clause
>> +/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
>> +#pragma once
>> +
>> +#define ALLOC_SELFTEST(func, ...)              \
>> +       do {                            \
>> +               int ret =3D func(__VA_ARGS__);    \
>> +               if (ret) {              \
>> +                       arena_stderr("SELFTEST %s FAIL: %d", #func, ret)=
;       \
>> +                       return ret;     \
>> +               }                       \
>> +       } while (0)
>
> I'm not excited about yet another special macro that hides control flow.
> Pls stick to ASSERT*() family.

Reusing test_progs.h would require us to other include the header in
libarena or complicate exporting it. Since as it is right now it's not
immediately exportable, I can everything to ASSERT and we can either
factor them out of test_progs.h later if necessary.

>
> pw-bot: cr

