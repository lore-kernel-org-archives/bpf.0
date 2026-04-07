Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EED4F39479B
	for <bpf@vger.kernel.org>; Tue,  7 Apr 2026 16:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775578913; cv=pass; b=SI03LSENbijDikMrmhAc5kB5cuzeowf8Olq1WhkRWwHyd3pLtxhZ5EdV0UJUdi0gLI8SvkXHjGz9bZAyG33VAKgIBqdcwYpTAyMf1t8x570nbO3U+YZ34XyQLc7oqfYwk+cr98nXOFecCBkZYddF3AYyTjMj0/pfx1VOfXDk9YY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775578913; c=relaxed/simple;
	bh=k1d82CGv7mOJ2Lx9p3Hk5KaPrNMkMHnDXaDyU1Ck/i8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=robWXN6/ltUs5rs3NDkoNPviUyLTlJWzTEuCLh8DkmI4I0Za93/kQDZw3gP3sVH42hOMYOurXZpgR5Mbcm9qumJAguQNY0Xuv1dwxnk1BDpo10IjaLn20X/QbzfuCzMv/4SClBT9YCdc7KaThuC5Bl1iZrEXCdo4CX/ib9zm7Jo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P1iApQL8; arc=pass smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P1iApQL8"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-488aa77a06eso40040685e9.0
        for <bpf@vger.kernel.org>; Tue, 07 Apr 2026 09:21:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775578910; cv=none;
        d=google.com; s=arc-20240605;
        b=dB2qO0GcMquvo7qNk1Wm3Z2oYHFwzBlKk5maP9C1Z4/SbOqL/thulHVvOKcODOpd0Q
         w7HMWooFOMy4TfRn18m/kyAZd4bewMjwb1SvZ+weCdDSSvs0BWK8xNOyII1qzsoMXw+B
         dC6zLVMOLin1Yc9E8sJgxOSznY5nJXrUXLk2L5UxmTaksOo4b9SXtmyiC1VKAElamtku
         6Xkm83FLHpP0WAxYDBai5vprEt6IE1yc2otEI2DohJILcyIfLR2o/iuydCo9RyRu++3w
         TQV6+8N+cmaIFZLFpTGGUS7IyVx1KE2hFTFWNQV+G2hSCM9VHgOmwtZG53/biqXgwANU
         uvMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rPreAbVnUwz4mIxi7jJaEIX2sTInEbGiRej21rNh4GI=;
        fh=hfRje2veXRgnK/5UbF368BTRuTdPC/oA5JvW+CkXkIA=;
        b=WflBAeSZqyj0jH3xMxdNEqM+S5mRArNCmdy0o5uHexyEmR6vNJSjYaAgLqLLHKqDA3
         12b2uEiKWJZWqs+Hbn9NQp0See5Sf7xCEoV/7zRFXxNvolYVH85pyy9m4/QGfdtjMC0F
         Z6lSFDcHH1hq6TM+YGir2WbE+8cHju6TC+W8fS3SeEYwYqA03oo+Z063Oy0d6fKyzyBc
         bjBo6fWLTAACZ5UDNFMr7y1OhIFsikj0z9Cx5d1IpluK7TajFQtrkmrzR98QmxQdAL7T
         KQCjSpvDIZBib24lDBK4zYM0Y3iEzcZdycY7ivK/DU8ODaNRqFGIXReZO0LLoJMSBMtg
         B8qg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775578910; x=1776183710; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rPreAbVnUwz4mIxi7jJaEIX2sTInEbGiRej21rNh4GI=;
        b=P1iApQL8odiIZ+2thHWURUPJ1s+/AavACjtclfJF//gBxCr22rs+zj6vuIjWLFyDqM
         Ts6rSr5tWh2+vp5ztkfTPpeWCLqJd3yx6YP0gzAvPi59n22Aw00c08C2YwavzP+MRsAu
         p3dOb1uiog5XtyQvRm8Bm0udsOPtHp47RbgOsX4y+RHH3dwZB2qP2ttmPSHV6dbxsG09
         QeKqKHhJ25m5y+l/dV5DL2+CpK17YJqmpoYBvcn1h0Yk2Tl3j8n1X95/Hx+PSZh8s+lm
         bxd+MM00NQKdJAYy0sLlDC0qXojM9MC//TGGiKLdhq7VIKL+1ruY+vb5wkRW09m5hMNo
         t4Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775578910; x=1776183710;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rPreAbVnUwz4mIxi7jJaEIX2sTInEbGiRej21rNh4GI=;
        b=kv4HJH/sQ7EFHULZxNGZxf2Oe9DRl4vHGJs97kGNy0cl1oK1yI9MuH7ckm26tfoZha
         pue2P4vevMRla6Pa8qeW/wScRsLI1MfSAGBiN26fk1fsuxPl3KE2IWik3l76sx0kA2aL
         BZAo6OOWtEoRRhUZgQJ3m5qNNWBRDWOXgHiGOJVJyCGUNED6M83SriyaBEorxtQjj9k+
         QEWY5rxNM/LsrhEJFqRSTYLG5Qvvc8fOJ0RXtAd44N1/Q7zwoxZr0cXmPA7gLTmOEOxz
         4pj3xYAan8Iqlnk2jzBrPh3Y85Kt/huYL8lXBISWTwW5Z0lBWjE9W5eNib/RE/FcPFKE
         wLVA==
X-Gm-Message-State: AOJu0YxSCiBskreVPG2RuY9OV2PcadJEDg1kcD+X2HBnXZzppbsu7OuL
	Pv/djzNYvNBUd8w09nmB0FoWt34JRNG2DmrX5onOVbrjvFKqCMk9oyfEgiutNfBRLh4EpUrbBIH
	IqYfpwt8EAl+VeaKx0S31LEpQ5qK8AQU=
X-Gm-Gg: AeBDieszl1uPiEyMxxBO4r66Eb62Hk/S2jYTYAediWGk071KhCmOHtBJ8uG4H4ekoaF
	6d6f7gXkPzVh5Ql5gRDCaJXZwyTsTqAA+wPWbO9fWQk+p94OlqheK3JjExTO6wIrgj2hu1TdMVi
	AA3cVeYwxJ65BpXiLJ+K6UsukgB1ejqriaWWBOY3nK93nZHo1RLrupDWIULUT/fP4pBh5X5MwbO
	Kf0dsFMuxUgUdVuXJqYZZqFPj2aiS7twmtvbnh4Cc8/q2HiM0vOd1ziwirwjan4nGMgVmeXmUVZ
	Ri0Rq5slwRaVyjBmGRK32CH3MSiNx/rzh2zE+XSauqD6++lx60HNcPevQ5RgZjXmtCPTuxsFIid
	EF7Ge3GAUbT+9sGmSQMcE0Mu/Fw==
X-Received: by 2002:a05:6000:25c8:b0:437:711c:8754 with SMTP id
 ffacd0b85a97d-43d29267feemr26738524f8f.7.1775578909988; Tue, 07 Apr 2026
 09:21:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260407045730.13359-1-emil@etsalapatis.com> <20260407045730.13359-6-emil@etsalapatis.com>
In-Reply-To: <20260407045730.13359-6-emil@etsalapatis.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 7 Apr 2026 09:21:37 -0700
X-Gm-Features: AQROBzBxxEPawVa5ik8Ni4KRhG1u40KXRJ0WFu4M7r1gq2GORlu6KmgRYxxXUiY
Message-ID: <CAADnVQLCyP+NzO9-332JO+dBe=EDEOr+ax+-ZrvAqJ9yTNYyEA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 5/9] selftests/bpf: Add basic libarena scaffolding
To: Emil Tsalapatis <emil@etsalapatis.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Daniel Borkmann <daniel@iogearbox.net>, Eduard <eddyz87@gmail.com>, Song Liu <song@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 6, 2026 at 9:57=E2=80=AFPM Emil Tsalapatis <emil@etsalapatis.co=
m> wrote:
>
> Add initial code for an arena-based BPF library. The current commit
> introduces a test runner and Makefile for the library. Library code
> can be added just by including the source file in the library's src/
> subdirectory. Future commits will introduce the library code itself.
>
> The current commit also includes a standalone test runner. This is
> to keep libarena self-contained and testable even when copied out
> of the kernel tree. Subsequent commits add integration with test_progs.
>
> Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
> ---
>  tools/testing/selftests/bpf/.gitignore        |   1 +
>  tools/testing/selftests/bpf/Makefile          |  15 ++
>  tools/testing/selftests/bpf/libarena/Makefile |  50 ++++++
>  .../selftests/bpf/libarena/include/common.h   |  49 ++++++
>  .../bpf/libarena/include/selftest_helpers.h   |  81 ++++++++++
>  .../selftests/bpf/libarena/include/userapi.h  |  26 +++
>  .../bpf/libarena/selftests/selftest.c         | 153 ++++++++++++++++++
>  .../bpf/libarena/selftests/selftest.h         |  12 ++
>  .../selftests/bpf/libarena/src/common.bpf.c   |  65 ++++++++
>  9 files changed, 452 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/libarena/Makefile
>  create mode 100644 tools/testing/selftests/bpf/libarena/include/common.h
>  create mode 100644 tools/testing/selftests/bpf/libarena/include/selftest=
_helpers.h
>  create mode 100644 tools/testing/selftests/bpf/libarena/include/userapi.=
h
>  create mode 100644 tools/testing/selftests/bpf/libarena/selftests/selfte=
st.c
>  create mode 100644 tools/testing/selftests/bpf/libarena/selftests/selfte=
st.h
>  create mode 100644 tools/testing/selftests/bpf/libarena/src/common.bpf.c
>
> diff --git a/tools/testing/selftests/bpf/.gitignore b/tools/testing/selft=
ests/bpf/.gitignore
> index bfdc5518ecc8..7f1960d6b59e 100644
> --- a/tools/testing/selftests/bpf/.gitignore
> +++ b/tools/testing/selftests/bpf/.gitignore
> @@ -49,3 +49,4 @@ verification_cert.h
>  *.BTF.base
>  usdt_1
>  usdt_2
> +libarena/test_libarena
> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftes=
ts/bpf/Makefile
> index f75c4f52c028..0d332c991023 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile
> @@ -153,6 +153,7 @@ override define CLEAN
>         $(Q)$(RM) -r $(TEST_KMODS)
>         $(Q)$(RM) -r $(EXTRA_CLEAN)
>         $(Q)$(MAKE) -C test_kmods clean
> +       $(Q)$(MAKE) -C libarena clean
>         $(Q)$(MAKE) docs-clean
>  endef
>
> @@ -739,6 +740,17 @@ $(VERIFY_SIG_HDR): $(VERIFICATION_CERT)
>          echo "};"; \
>          echo "unsigned int test_progs_verification_cert_len =3D $$(wc -c=
 < $<);") > $@
>
> +LIBARENA_MAKE_ARGS =3D \
> +               BPFTOOL=3D"$(BPFTOOL)" \
> +               INCLUDE_DIR=3D"$(HOST_INCLUDE_DIR)" \
> +               LIBBPF_INCLUDE=3D"$(HOST_INCLUDE_DIR)" \
> +               BPFOBJ=3D"$(BPFOBJ)" \
> +               LDLIBS=3D"$(LDLIBS) -lzstd" \
> +               CLANG=3D"$(CLANG)" \
> +               BPF_CFLAGS=3D"$(BPF_CFLAGS) $(CLANG_CFLAGS)" \
> +               BPF_TARGET_ENDIAN=3D"$(BPF_TARGET_ENDIAN)" \
> +               Q=3D"$(Q)"
> +
>  # Define test_progs test runner.
>  TRUNNER_TESTS_DIR :=3D prog_tests
>  TRUNNER_BPF_PROGS_DIR :=3D progs
> @@ -931,3 +943,6 @@ override define INSTALL_RULE
>                 rsync -a $(OUTPUT)/$$DIR/*.bpf.o $(INSTALL_PATH)/$$DIR;\
>         done
>  endef
> +
> +test_libarena: $(INCLUDE_DIR)/vmlinux.h $(BPFOBJ)
> +       +$(MAKE) -C libarena $@ $(LIBARENA_MAKE_ARGS)
> diff --git a/tools/testing/selftests/bpf/libarena/Makefile b/tools/testin=
g/selftests/bpf/libarena/Makefile
> new file mode 100644
> index 000000000000..151ab6d0509c
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/libarena/Makefile
> @@ -0,0 +1,50 @@
> +# SPDX-License-Identifier: LGPL-2.1 OR BSD-2-Clause
> +# Copyright (c) 2026 Meta Platforms, Inc. and affiliates.
> +
> +.PHONY: clean
> +
> +LIBARENA=3D$(abspath .)
> +
> +
> +LIBARENA_SOURCES =3D $(wildcard $(LIBARENA)/src/*.bpf.c) $(wildcard $(LI=
BARENA)/selftests/*.bpf.c)
> +LIBARENA_OBJECTS =3D $(notdir $(LIBARENA_SOURCES:.bpf.c=3D.bpf.o))
> +
> +INCLUDES =3D -I$(LIBARENA)/include -I$(LIBARENA)/..
> +ifneq ($(INCLUDE_DIR),)
> +INCLUDES +=3D -I$(INCLUDE_DIR)
> +endif
> +ifneq ($(LIBBPF_INCLUDE),)
> +INCLUDES +=3D -I$(LIBBPF_INCLUDE)
> +endif
> +
> +# ENABLE_ATOMICS_TESTS required because we use arena spinlocks
> +override BPF_CFLAGS +=3D -DENABLE_ATOMICS_TESTS
> +override BPF_CFLAGS +=3D -O2 -Wno-incompatible-pointer-types-discards-qu=
alifiers
> +override BPF_CFLAGS +=3D $(INCLUDES)
> +
> +CFLAGS =3D -O2 -no-pie
> +CFLAGS +=3D $(INCLUDES)
> +
> +vpath %.bpf.c $(LIBARENA)/src $(LIBARENA)/selftests
> +vpath %.c $(LIBARENA)/src $(LIBARENA)/selftests
> +
> +all: test_libarena
> +
> +test_libarena: selftest.c $(BPFOBJ) libarena.skel.h
> +       $(call msg,BINARY,libarena,$@)
> +       $(Q)$(CLANG) $(CFLAGS) $< $(BPFOBJ) $(LDLIBS) -o $@
> +
> +libarena.skel.h: main.bpf.o
> +       $(call msg,GEN-SKEL,libarena,$@)
> +       $(Q)$(BPFTOOL) gen skeleton $< name "libarena" > $@
> +
> +main.bpf.o: $(LIBARENA_OBJECTS)
> +       $(call msg,GEN-OBJ,libarena,$@)
> +       $(Q)$(BPFTOOL) gen object $@ $^
> +
> +%.bpf.o: %.bpf.c
> +       $(call msg,CLNG-BPF,libarena,$@)
> +       $(Q)$(CLANG) $(BPF_CFLAGS) $(BPF_TARGET_ENDIAN) -c $< -o $@
> +
> +clean:
> +       $(Q)rm -f *.skel.h *.bpf.o test_libarena
> diff --git a/tools/testing/selftests/bpf/libarena/include/common.h b/tool=
s/testing/selftests/bpf/libarena/include/common.h
> new file mode 100644
> index 000000000000..544a398a0d1e
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/libarena/include/common.h
> @@ -0,0 +1,49 @@
> +// SPDX-License-Identifier: LGPL-2.1 OR BSD-2-Clause
> +/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
> +#pragma once
> +
> +#ifdef __BPF__

Are you trying to re-use this common.h in user space code?

> +
> +#include <vmlinux.h>
> +
> +#include "bpf_experimental.h"
> +#include "bpf_arena_common.h"
> +#include "bpf_arena_spin_lock.h"
> +
> +#include <asm-generic/errno.h>
> +
> +#ifndef __BPF_FEATURE_ADDR_SPACE_CAST
> +#error "Arena allocators require bpf_addr_space_cast feature"
> +#endif
> +
> +#define arena_stdout(fmt, ...) bpf_stream_printk(1, (fmt), ##__VA_ARGS__=
)
> +#define arena_stderr(fmt, ...) bpf_stream_printk(2, (fmt), ##__VA_ARGS__=
)
> +
> +#ifndef __maybe_unused
> +#define __maybe_unused __attribute__((__unused__))
> +#endif
> +
> +#define private(name) SEC(".data." #name) __hidden __attribute__((aligne=
d(8)))
> +
> +#define ARENA_PAGES (1UL << (32 - __builtin_ffs(__PAGE_SIZE) + 1))
> +
> +struct {
> +       __uint(type, BPF_MAP_TYPE_ARENA);
> +       __uint(map_flags, BPF_F_MMAPABLE);
> +       __uint(max_entries, ARENA_PAGES); /* number of pages */
> +#if defined(__TARGET_ARCH_arm64) || defined(__aarch64__)
> +        __ulong(map_extra, (1ull << 32)); /* start of mmap() region */
> +#else
> +        __ulong(map_extra, (1ull << 44)); /* start of mmap() region */
> +#endif
> +} arena __weak SEC(".maps");
> +
> +extern const volatile u32 zero;
> +
> +int arena_fls(__u64 word);
> +
> +#endif /* __BPF__ */
> +
> +struct arena_get_base_args {
> +       void __arena *arena_base;
> +};

If so, then how above suppose to compile in user space?
__arena is not defined yet.

> diff --git a/tools/testing/selftests/bpf/libarena/include/selftest_helper=
s.h b/tools/testing/selftests/bpf/libarena/include/selftest_helpers.h
> new file mode 100644
> index 000000000000..ee445d8f5b26
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/libarena/include/selftest_helpers.h
> @@ -0,0 +1,81 @@
> +// SPDX-License-Identifier: LGPL-2.1 OR BSD-2-Clause
> +/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
> +#pragma once
> +
> +#include <errno.h>
> +#include <stdlib.h>
> +#include <unistd.h>
> +#include <sys/mman.h>
> +
> +#include <bpf/libbpf.h>
> +#include <bpf/bpf.h>
> +
> +static inline int libarena_run_prog(int prog_fd)
> +{
> +       LIBBPF_OPTS(bpf_test_run_opts, opts);
> +       int ret;
> +
> +       ret =3D bpf_prog_test_run_opts(prog_fd, &opts);
> +       if (ret)
> +               return ret;
> +
> +       return opts.retval;
> +}
> +
> +static inline int libarena_get_arena_base(int arena_get_base_fd,
> +                                         void **arena_base)
> +{
> +       LIBBPF_OPTS(bpf_test_run_opts, opts);
> +       struct arena_get_base_args args =3D { .arena_base =3D NULL };
> +       int ret;
> +
> +       opts.ctx_in =3D &args;
> +       opts.ctx_size_in =3D sizeof(args);
> +
> +       ret =3D bpf_prog_test_run_opts(arena_get_base_fd, &opts);
> +       if (ret)
> +               return ret;
> +       if (opts.retval)
> +               return opts.retval;
> +
> +       *arena_base =3D args.arena_base;
> +       return 0;
> +}
> +
> +static inline int libarena_get_globals_pages(int arena_get_base_fd,
> +                                            size_t arena_all_pages,
> +                                            u64 *globals_pages)
> +{
> +       size_t pgsize =3D sysconf(_SC_PAGESIZE);
> +       void *arena_base;
> +       ssize_t i;
> +       u8 *vec;
> +       int ret;
> +
> +       ret =3D libarena_get_arena_base(arena_get_base_fd, &arena_base);
> +       if (ret)
> +               return ret;
> +
> +       if (!arena_base)
> +               return -EINVAL;
> +
> +       vec =3D calloc(arena_all_pages, sizeof(*vec));
> +       if (!vec)
> +               return -ENOMEM;
> +
> +       if (mincore(arena_base, arena_all_pages * pgsize, vec) < 0) {
> +               ret =3D -errno;
> +               free(vec);
> +               return ret;
> +       }
> +
> +       *globals_pages =3D 0;
> +       for (i =3D arena_all_pages - 1; i >=3D 0; i--) {
> +               if (!(vec[i] & 0x1))
> +                       break;
> +               *globals_pages +=3D 1;
> +       }
> +
> +       free(vec);
> +       return 0;
> +}
> diff --git a/tools/testing/selftests/bpf/libarena/include/userapi.h b/too=
ls/testing/selftests/bpf/libarena/include/userapi.h
> new file mode 100644
> index 000000000000..b4ac6bc9bd79
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/libarena/include/userapi.h
> @@ -0,0 +1,26 @@
> +// SPDX-License-Identifier: LGPL-2.1 OR BSD-2-Clause
> +/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
> +#pragma once
> +
> +#include <stdint.h>
> +
> +/*
> + * Header for the userspace C programs that load
> + * and initialize the BPF code.
> + */
> +
> +#define __arena
> +
> +typedef uint8_t u8;
> +typedef uint16_t u16;
> +typedef uint32_t u32;
> +typedef uint64_t u64;
> +typedef int8_t s8;
> +typedef int16_t s16;
> +typedef int32_t s32;
> +typedef int64_t s64;
> +
> +/* Dummy "definition" for userspace. */
> +#define arena_spinlock_t u64
> +
> +#include "common.h"

ohh. So user space _must_ include userapi.h first ?
Why is this not part of common.h ?
Why bother with extra userapi.h header?

> diff --git a/tools/testing/selftests/bpf/libarena/selftests/selftest.c b/=
tools/testing/selftests/bpf/libarena/selftests/selftest.c
> new file mode 100644
> index 000000000000..b69adc7baaab
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/libarena/selftests/selftest.c
> @@ -0,0 +1,153 @@
> +// SPDX-License-Identifier: LGPL-2.1 OR BSD-2-Clause
> +/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
> +
> +#define _GNU_SOURCE
> +#include <assert.h>
> +#include <errno.h>
> +#include <stdio.h>
> +#include <string.h>
> +#include <unistd.h>
> +
> +#include <bpf/libbpf.h>
> +#include <bpf/bpf.h>
> +
> +#include <sys/mman.h>
> +#include <sys/resource.h>
> +#include <sys/sysinfo.h>
> +
> +#include <userapi.h>
> +#include <selftest_helpers.h>
> +
> +#include "../libarena.skel.h"
> +typedef struct libarena selftest;
> +#define selftest__open libarena__open
> +#define selftest__open_and_load libarena__open_and_load
> +#define selftest__load libarena__load
> +#define selftest__attach libarena__attach
> +#define selftest__destroy libarena__destroy

I don't like this obfuscation.
What's the point of these #define-s?

> +
> +static bool verbose =3D false;
> +static int testno =3D 1;
> +
> +static int
> +run_prog_verbose(int prog_fd)
> +{
> +       char buf[1024];
> +       int ret, err;
> +
> +       ret =3D libarena_run_prog(prog_fd);
> +
> +       if (ret)
> +               fprintf(stderr, "error %d in %s\n", ret, __func__);
> +
> +       if (verbose) {
> +               printf("BPF stdout:\n");
> +               while ((err =3D bpf_prog_stream_read(prog_fd, 1, buf, 102=
4, NULL)) > 0)
> +                       printf("%.*s", err, buf);
> +
> +               if (err)
> +                       return err;
> +
> +               printf("BPF stderr:\n");
> +               while ((err =3D bpf_prog_stream_read(prog_fd, 2, buf, 102=
4, NULL)) > 0)
> +                       printf("%.*s", err, buf);
> +
> +               if (err)
> +                       return err;
> +       }
> +
> +       return ret;
> +}
> +
> +static int libbpf_print_fn(enum libbpf_print_level level,
> +               const char *format, va_list args)
> +{
> +       if (level =3D=3D LIBBPF_DEBUG)
> +               return 0;
> +       return vfprintf(stderr, format, args);
> +}
> +
> +int run_test(selftest *skel, const struct bpf_program *prog)
> +{
> +       int prog_fd;
> +       int ret;
> +
> +       ret =3D libarena_run_prog(bpf_program__fd(skel->progs.arena_alloc=
_reserve));
> +       if (ret)
> +               return ret;
> +
> +       prog_fd =3D bpf_program__fd(prog);
> +       if (prog_fd < 0)
> +               return prog_fd;
> +
> +       return run_prog_verbose(prog_fd);
> +}
> +
> +#define TEST(__test)                                   \
> +int run_##__test(void)                                 \
> +{                                                      \
> +       selftest *skel;                                 \
> +       int ret;                                        \
> +                                                       \
> +       skel =3D selftest__open_and_load();               \
> +       if (!skel) {                                    \
> +               ret =3D -EINVAL;                          \
> +               goto error_no_destroy;                  \
> +       }                                               \
> +                                                       \
> +       ret =3D selftest__attach(skel);                   \
> +       if (ret)                                        \
> +               goto error;                             \
> +                                                       \
> +       ret =3D run_test(skel, skel->progs.__test);       \
> +       if (ret)                                        \
> +               goto error;                             \
> +                                                       \
> +       selftest__destroy(skel);                        \
> +                                                       \
> +       printf("ok %d - %s\n", testno++, #__test);      \
> +       return 0;                                       \
> +                                                       \
> +error:                                                 \
> +       selftest__destroy(skel);                        \
> +error_no_destroy:                                      \
> +       printf("not ok %d - %s\n", testno++, #__test);  \
> +       return ret;                                     \
> +}
> +
> +static void
> +banner(const char *progpath)
> +{
> +       char *name =3D basename(progpath);
> +
> +       printf("%s\n", name);
> +
> +       printf("=3D=3D=3D %s =3D=3D=3D\n", "libarena selftests");
> +}
> +
> +int main(int argc, char *argv[])
> +{
> +       int ret;
> +
> +       struct rlimit rlim =3D {
> +               .rlim_cur =3D RLIM_INFINITY,
> +               .rlim_max =3D RLIM_INFINITY,
> +       };
> +
> +       banner(argv[0]);
> +
> +       for (int i =3D 1; i < argc; i++) {
> +               if (strcmp(argv[i], "-v") =3D=3D 0 || strcmp(argv[i], "--=
verbose") =3D=3D 0)
> +                       verbose =3D true;
> +       }
> +
> +       ret =3D setrlimit(RLIMIT_MEMLOCK, &rlim);

where did you copy this from?
It wasn't necessary for very long time.

> +       if (ret) {
> +               perror("setrlimit");
> +               return ret;
> +       }
> +
> +       libbpf_set_print(libbpf_print_fn);
> +
> +       return 0;
> +}
> diff --git a/tools/testing/selftests/bpf/libarena/selftests/selftest.h b/=
tools/testing/selftests/bpf/libarena/selftests/selftest.h
> new file mode 100644
> index 000000000000..b1cbff4d343b
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/libarena/selftests/selftest.h
> @@ -0,0 +1,12 @@
> +// SPDX-License-Identifier: LGPL-2.1 OR BSD-2-Clause
> +/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
> +#pragma once
> +
> +#define ALLOC_SELFTEST(func, ...)              \
> +       do {                            \
> +               int ret =3D func(__VA_ARGS__);    \
> +               if (ret) {              \
> +                       arena_stderr("SELFTEST %s FAIL: %d", #func, ret);=
       \
> +                       return ret;     \
> +               }                       \
> +       } while (0)

I'm not excited about yet another special macro that hides control flow.
Pls stick to ASSERT*() family.

pw-bot: cr
