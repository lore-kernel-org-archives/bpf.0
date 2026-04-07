Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CED57389444
	for <bpf@vger.kernel.org>; Tue,  7 Apr 2026 17:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775581964; cv=pass; b=bpk34yzM5bHnWl1A23C0BH0Ac/IOfTo0RPg3XUUGZisvqYLXjl7Zt98nQKkyqMtq6s/9Vb737ik2GepK659V533WOjwJl5WUOM78KbRgO8wxwX2JEikaTfO/lXMY6nXlX6jbZN7Fed/WP468BTJmu9KFcYR91N7AtBqKSiyHRqM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775581964; c=relaxed/simple;
	bh=92Ml59fsGJ5zLxrx35D1mcnQEPbaXhUSGw9NbxZA+tM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jrlzpteH2k04SSPWz47Xu50l6a9xC58f+vRcrdw0JW/kYzHyiYfSqXAhsQGlm1mTBqQkhJcTfQiXnYZQdsUwPdmQxAaxV2zvBRBipGBhob29a/mmTPYea92b/3VCW2OiH+CrsR/WXow+dM/CPQwbLqpimc3fL0ddXiFcKZzK0oE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VR/Dzj0M; arc=pass smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VR/Dzj0M"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4852b81c73aso44500715e9.3
        for <bpf@vger.kernel.org>; Tue, 07 Apr 2026 10:12:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775581961; cv=none;
        d=google.com; s=arc-20240605;
        b=GB6pFgjp4nCxjXQI0hQksP2FoDIHPfIPNqD4utNhUmxVnHbb+5hnBapQek0pzGgEHC
         S6J2x8UteXjDvkUWPZ5NW+pA4Ul71kNJ5bjNNVlUCbzRU3YUMtekWUyN3VgSiFEOAJ1R
         VSX0JAOB6q2/EA/RAk9h+q6nQL5SQP3weoKK2w+YnBjxrj7S8ez8oyH+fgo3znq9A0oi
         p1RT23FkqnAt+k5UdwbhNifUXiODsro/qqxL1LtFgI5y0pnlmUc1aJjoNNr5+YfX0281
         lYM9kQyNj+pyNjxU5US8NCSTlHdzdzuIbG/SI/jAlRhMd4GgX1sVTK8a4C36Z7tSX0iz
         VuDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9Sb3YGV2bObc5s9PidxbLzrdcEo+gkHzDilhu2uwcjA=;
        fh=hfRje2veXRgnK/5UbF368BTRuTdPC/oA5JvW+CkXkIA=;
        b=V2JyJfRRCKQ1QOoQsUYqClB1jpdLyX7bhD07Osntnlx91ZOLpuOlc3bys4XCHDpXRc
         5tpyKNFFzfz87W+RlE7f6V0hzC6U/+ygeByAB6uaV8gRLJ4On3DG9WjxufqKTXRf3x1j
         GMTBgUWHvOTOmRyNczcB5y2QjeYKpmdv0ncJIxxM+WThgnbO8b9G5xO/XW/TJ5iY4O8O
         16LFJ7kK/kZFP/7dOzOJIIbfOlJckKls641LmGN31hgmrHRU89cU5cFpWEsTWFRsmZ6P
         v2foFp9xaSDSI6RVkvTQNIKA/QQTCjTVEfhOglRqodPyjTAko5KZZvcs7+gAOwb0lzAZ
         QhDg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775581961; x=1776186761; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9Sb3YGV2bObc5s9PidxbLzrdcEo+gkHzDilhu2uwcjA=;
        b=VR/Dzj0MqoZaeTT24j6/2+9rz9QYgfaHdNCxmKt7GwbO/SrraACAzYPEvoo4r1A0Pt
         JKF6luajfrVcvhtFJLloQdUzvQxUIJsQPnoT7VrTafit95/fQQAt3qQvw8J7rmgHf3HC
         xwCAz9ZkK6zpOkHmc3A72kXwgY0Hsss+XKBwOfHyYwmkn+/aieb3tEa2c/86VmjxYjKB
         FDKWebFA3IbtngtRSHRWi4FdL3zPzMUKoQSiHIswJfWExiMLs9tM2zEQr0ElmanVb60g
         QNOzMwhLqvaf39390x5c++LZLAZp8ZVeiVrOEL5WCUu8sXcMVJfK8crXI/bLSBl3D98y
         kLhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775581961; x=1776186761;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9Sb3YGV2bObc5s9PidxbLzrdcEo+gkHzDilhu2uwcjA=;
        b=e2NNG/h04o34HOcv1xYiXBHD28uVhwjc19vZGzAmACJ/rZdNKTyxIVS1i0abnGaSHg
         v2EQKxF62Fv/A5fiW6Yl2qcAiS8Ry46+kI4sRUDgMfJIF0OKZCPKExqGo+4L76BOLRCZ
         vyVmtULdUSTQv2ZsYUzOF9Mjk0C++nzyu8SebDsJQHKIC+tvlAaKeQgVUbD/0ESBcQwJ
         m/2jaJ9cMlTkimdpr/Ns41tTtRa0cHD+FiC56krlAdUY5TYO/haUjo7h/VsO4Gq4N53A
         4169IPTSkebFxidB3BOYXsJFjD5o66D47ktzaV0ytGoGMqXn37pkkJySrstwuCQce+91
         +SGg==
X-Gm-Message-State: AOJu0Yzbw90dE0aDkz6eW2XFzOrB4lSIsJ7sxV5fpvFaX2OYN8AHQp8i
	jJqKjfYoZsR+oy06Nn70ej7nWiK4aHYfVHgaZ/lwVIwHSQ5e2Z8LCKnMIDW/b1sRCCHrrQ0HB5x
	v1HkOVHDtzysqO/I+0heGGJRDapE/joI=
X-Gm-Gg: AeBDiesmqfD7XNHtHD8jPBeEPFqsRzLXqzZTpcKgm4HjVJAB3AP2Q357u3WwhgfpCx+
	uHCc9AV6pYyCvoMZlTIJYg3+95ek6xrZx/+rsz24o/iH4Wlvc4rPDDk1AFrmSJTEjGFqT9eLg2F
	edEDlTiTlLwGLAPGuWW0/lr3mxYWARUp0UtMoerNAYW7ZnAbKjeu5JzkahWjZpOI9KuRKEz2hqo
	nZbsLmSVgoy0ZHrb9PeC4Hpt2m3OndI2FFWkclT9T+qd1Eb5o/MBImr/4jeKACiamc3NmiMuoGy
	xwqT2F2LmLppLZ2HrMdbj/E8Is5cyTCLmI+WKS+7YMp217xvLQb1PYWhEc1PBbUDV7IszvBDCvW
	/VdJUr0JXYav/WlO8vbfMam1sBA==
X-Received: by 2002:a05:600c:4b23:b0:488:a723:ea53 with SMTP id
 5b1f17b1804b1-488a723ebddmr100174425e9.7.1775581961042; Tue, 07 Apr 2026
 10:12:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260407045730.13359-1-emil@etsalapatis.com> <20260407045730.13359-8-emil@etsalapatis.com>
In-Reply-To: <20260407045730.13359-8-emil@etsalapatis.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 7 Apr 2026 10:12:29 -0700
X-Gm-Features: AQROBzC59AiExtJlToeIIn77F_ZXJcmBOwt6AEfB8yVUh9MDrrR9WOFiL8rgMZc
Message-ID: <CAADnVQKNBdYrbXV-6BapQrwPxCpZDkD__VvkfzKBEtKC3iwP+A@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 7/9] selftests/bpf: Add ASAN support for
 libarena selftests
To: Emil Tsalapatis <emil@etsalapatis.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Daniel Borkmann <daniel@iogearbox.net>, Eduard <eddyz87@gmail.com>, Song Liu <song@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 6, 2026 at 9:57=E2=80=AFPM Emil Tsalapatis <emil@etsalapatis.co=
m> wrote:
>
> Expand the arena library selftest infrastructure to support
> address sanitization. Add the compiler flags necessary to
> compile the library under ASAN when supported.
>
> Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
> ---
>  tools/testing/selftests/bpf/.gitignore        |  1 +
>  tools/testing/selftests/bpf/Makefile          | 13 +++++-
>  tools/testing/selftests/bpf/libarena/Makefile | 31 ++++++++++++-
>  .../bpf/libarena/include/selftest_helpers.h   | 28 +++++++++++
>  .../selftests/bpf/libarena/include/userapi.h  |  1 +
>  .../bpf/libarena/selftests/selftest.c         | 27 ++++++++++-
>  .../bpf/libarena/selftests/st_asan_common.h   | 46 +++++++++++++++++++
>  7 files changed, 143 insertions(+), 4 deletions(-)
>  create mode 100644 tools/testing/selftests/bpf/libarena/selftests/st_asa=
n_common.h
>
> diff --git a/tools/testing/selftests/bpf/.gitignore b/tools/testing/selft=
ests/bpf/.gitignore
> index 7f1960d6b59e..50fa79b2daac 100644
> --- a/tools/testing/selftests/bpf/.gitignore
> +++ b/tools/testing/selftests/bpf/.gitignore
> @@ -50,3 +50,4 @@ verification_cert.h
>  usdt_1
>  usdt_2
>  libarena/test_libarena
> +libarena/test_libarena_asan
> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftes=
ts/bpf/Makefile
> index 0d332c991023..f10e865338f6 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile
> @@ -751,6 +751,13 @@ LIBARENA_MAKE_ARGS =3D \
>                 BPF_TARGET_ENDIAN=3D"$(BPF_TARGET_ENDIAN)" \
>                 Q=3D"$(Q)"
>
> +# libarena_asan.skel.h currently requires LLVM 22. For now,
> +# only integrate the non-ASAN version with test_progs.
> +LIBARENA_SKEL :=3D libarena/libarena.skel.h
> +
> +$(LIBARENA_SKEL): $(INCLUDE_DIR)/vmlinux.h $(BPFOBJ)
> +       +$(MAKE) -C libarena libarena.skel.h $(LIBARENA_MAKE_ARGS)
> +
>  # Define test_progs test runner.
>  TRUNNER_TESTS_DIR :=3D prog_tests
>  TRUNNER_BPF_PROGS_DIR :=3D progs
> @@ -774,7 +781,8 @@ TRUNNER_EXTRA_SOURCES :=3D test_progs.c              =
 \
>                          flow_dissector_load.h  \
>                          ip_check_defrag_frags.h        \
>                          bpftool_helpers.c      \
> -                        usdt_1.c usdt_2.c
> +                        usdt_1.c usdt_2.c      \
> +                        $(LIBARENA_SKEL)
>  TRUNNER_LIB_SOURCES :=3D find_bit.c
>  TRUNNER_EXTRA_FILES :=3D $(OUTPUT)/urandom_read                         =
 \
>                        $(OUTPUT)/liburandom_read.so                     \
> @@ -946,3 +954,6 @@ endef
>
>  test_libarena: $(INCLUDE_DIR)/vmlinux.h $(BPFOBJ)
>         +$(MAKE) -C libarena $@ $(LIBARENA_MAKE_ARGS)
> +
> +test_libarena_asan: $(INCLUDE_DIR)/vmlinux.h $(BPFOBJ)
> +       +$(MAKE) -C libarena $@ $(LIBARENA_MAKE_ARGS)
> diff --git a/tools/testing/selftests/bpf/libarena/Makefile b/tools/testin=
g/selftests/bpf/libarena/Makefile
> index 151ab6d0509c..c988da56c863 100644
> --- a/tools/testing/selftests/bpf/libarena/Makefile
> +++ b/tools/testing/selftests/bpf/libarena/Makefile
> @@ -8,6 +8,7 @@ LIBARENA=3D$(abspath .)
>
>  LIBARENA_SOURCES =3D $(wildcard $(LIBARENA)/src/*.bpf.c) $(wildcard $(LI=
BARENA)/selftests/*.bpf.c)
>  LIBARENA_OBJECTS =3D $(notdir $(LIBARENA_SOURCES:.bpf.c=3D.bpf.o))
> +LIBARENA_OBJECTS_ASAN =3D $(notdir $(LIBARENA_SOURCES:.bpf.c=3D_asan.bpf=
.o))
>
>  INCLUDES =3D -I$(LIBARENA)/include -I$(LIBARENA)/..
>  ifneq ($(INCLUDE_DIR),)
> @@ -17,6 +18,13 @@ ifneq ($(LIBBPF_INCLUDE),)
>  INCLUDES +=3D -I$(LIBBPF_INCLUDE)
>  endif
>
> +ASAN_FLAGS =3D -fsanitize=3Dkernel-address -fno-stack-protector -fno-bui=
ltin
> +ASAN_FLAGS +=3D -mllvm -asan-instrument-address-spaces=3D1 -mllvm -asan-=
shadow-addr-space=3D1
> +ASAN_FLAGS +=3D -mllvm -asan-use-stack-safety=3D0 -mllvm -asan-stack=3D0
> +ASAN_FLAGS +=3D -mllvm -asan-kernel=3D1
> +ASAN_FLAGS +=3D -mllvm -asan-constructor-kind=3Dnone
> +ASAN_FLAGS +=3D -mllvm -asan-destructor-kind=3Dnone
> +
>  # ENABLE_ATOMICS_TESTS required because we use arena spinlocks
>  override BPF_CFLAGS +=3D -DENABLE_ATOMICS_TESTS
>  override BPF_CFLAGS +=3D -O2 -Wno-incompatible-pointer-types-discards-qu=
alifiers
> @@ -28,23 +36,42 @@ CFLAGS +=3D $(INCLUDES)
>  vpath %.bpf.c $(LIBARENA)/src $(LIBARENA)/selftests
>  vpath %.c $(LIBARENA)/src $(LIBARENA)/selftests
>
> -all: test_libarena
> +all: test_libarena test_libarena_asan
> +
> +test_libarena_asan: selftest.c $(BPFOBJ) libarena_asan.skel.h
> +       $(call msg,BINARY,libarena,$@)
> +       $(Q)$(CLANG) $(CFLAGS) -DBPF_ARENA_ASAN $< $(BPFOBJ) $(LDLIBS) -o=
 $@
>
>  test_libarena: selftest.c $(BPFOBJ) libarena.skel.h
>         $(call msg,BINARY,libarena,$@)
>         $(Q)$(CLANG) $(CFLAGS) $< $(BPFOBJ) $(LDLIBS) -o $@
>
> +skeletons: libarena.skel.h libarena_asan.skel.h
> +.PHONY: skeletons
> +
> +libarena_asan.skel.h: main_asan.bpf.o
> +       $(call msg,GEN-SKEL,libarena,$@)
> +       $(Q)$(BPFTOOL) gen skeleton $< name "libarena_asan" > $@
> +
>  libarena.skel.h: main.bpf.o
>         $(call msg,GEN-SKEL,libarena,$@)
>         $(Q)$(BPFTOOL) gen skeleton $< name "libarena" > $@
>
> +main_asan.bpf.o: $(LIBARENA_OBJECTS_ASAN)
> +       $(call msg,GEN-OBJ,libarena,$@)
> +       $(Q)$(BPFTOOL) gen object $@ $^
> +
>  main.bpf.o: $(LIBARENA_OBJECTS)
>         $(call msg,GEN-OBJ,libarena,$@)
>         $(Q)$(BPFTOOL) gen object $@ $^
>
> +%_asan.bpf.o: %.bpf.c
> +       $(call msg,CLNG-BPF,libarena,$@)
> +       $(Q)$(CLANG) $(BPF_CFLAGS) $(ASAN_FLAGS) -DBPF_ARENA_ASAN $(BPF_T=
ARGET_ENDIAN) -c $< -o $@
> +
>  %.bpf.o: %.bpf.c
>         $(call msg,CLNG-BPF,libarena,$@)
>         $(Q)$(CLANG) $(BPF_CFLAGS) $(BPF_TARGET_ENDIAN) -c $< -o $@
>
>  clean:
> -       $(Q)rm -f *.skel.h *.bpf.o test_libarena
> +       $(Q)rm -f *.skel.h *.bpf.o *.linked*.o test_libarena test_libaren=
a_asan
> diff --git a/tools/testing/selftests/bpf/libarena/include/selftest_helper=
s.h b/tools/testing/selftests/bpf/libarena/include/selftest_helpers.h
> index ee445d8f5b26..0cb3fdddd535 100644
> --- a/tools/testing/selftests/bpf/libarena/include/selftest_helpers.h
> +++ b/tools/testing/selftests/bpf/libarena/include/selftest_helpers.h
> @@ -79,3 +79,31 @@ static inline int libarena_get_globals_pages(int arena=
_get_base_fd,
>         free(vec);
>         return 0;
>  }
> +
> +static inline int libarena_asan_init(int arena_get_base_fd,
> +                                    int asan_init_fd,
> +                                    size_t arena_all_pages)
> +{
> +       LIBBPF_OPTS(bpf_test_run_opts, opts);
> +       struct asan_init_args args;
> +       u64 globals_pages;
> +       int ret;
> +
> +       ret =3D libarena_get_globals_pages(arena_get_base_fd,
> +                                        arena_all_pages, &globals_pages)=
;
> +       if (ret)
> +               return ret;
> +
> +       args =3D (struct asan_init_args){
> +               .arena_all_pages =3D arena_all_pages,
> +               .arena_globals_pages =3D globals_pages,
> +       };
> +
> +       opts.ctx_in =3D &args;
> +       opts.ctx_size_in =3D sizeof(args);
> +
> +       ret =3D bpf_prog_test_run_opts(asan_init_fd, &opts);
> +       if (ret)
> +               return ret;
> +       return opts.retval;
> +}
> diff --git a/tools/testing/selftests/bpf/libarena/include/userapi.h b/too=
ls/testing/selftests/bpf/libarena/include/userapi.h
> index b4ac6bc9bd79..5d3a851fb65a 100644
> --- a/tools/testing/selftests/bpf/libarena/include/userapi.h
> +++ b/tools/testing/selftests/bpf/libarena/include/userapi.h
> @@ -24,3 +24,4 @@ typedef int64_t s64;
>  #define arena_spinlock_t u64
>
>  #include "common.h"
> +#include "asan.h"
> diff --git a/tools/testing/selftests/bpf/libarena/selftests/selftest.c b/=
tools/testing/selftests/bpf/libarena/selftests/selftest.c
> index b69adc7baaab..2bd8363ea614 100644
> --- a/tools/testing/selftests/bpf/libarena/selftests/selftest.c
> +++ b/tools/testing/selftests/bpf/libarena/selftests/selftest.c
> @@ -18,6 +18,17 @@
>  #include <userapi.h>
>  #include <selftest_helpers.h>
>
> +#include "selftest.h"
> +
> +#ifdef BPF_ARENA_ASAN
> +#include "../libarena_asan.skel.h"
> +typedef struct libarena_asan selftest;
> +#define selftest__open libarena_asan__open
> +#define selftest__open_and_load libarena_asan__open_and_load
> +#define selftest__load libarena_asan__load
> +#define selftest__attach libarena_asan__attach
> +#define selftest__destroy libarena_asan__destroy

ohh. I see. So you want to double compile the same bpf code
with and without asan and reuse the tests?
I guess #defines are fine then.

> +#else
>  #include "../libarena.skel.h"
>  typedef struct libarena selftest;
>  #define selftest__open libarena__open
> @@ -25,6 +36,7 @@ typedef struct libarena selftest;
>  #define selftest__load libarena__load
>  #define selftest__attach libarena__attach
>  #define selftest__destroy libarena__destroy
> +#endif
>
>  static bool verbose =3D false;
>  static int testno =3D 1;
> @@ -69,6 +81,7 @@ static int libbpf_print_fn(enum libbpf_print_level leve=
l,
>
>  int run_test(selftest *skel, const struct bpf_program *prog)
>  {
> +       size_t arena_pages =3D (1UL << 32) / sysconf(_SC_PAGESIZE);
>         int prog_fd;
>         int ret;
>
> @@ -76,6 +89,15 @@ int run_test(selftest *skel, const struct bpf_program =
*prog)
>         if (ret)
>                 return ret;
>
> +#ifdef BPF_ARENA_ASAN
> +       ret =3D libarena_asan_init(
> +               bpf_program__fd(skel->progs.arena_get_base),
> +               bpf_program__fd(skel->progs.asan_init),
> +               arena_pages);
> +       if (ret)
> +               return ret;
> +#endif
> +
>         prog_fd =3D bpf_program__fd(prog);
>         if (prog_fd < 0)
>                 return prog_fd;
> @@ -119,10 +141,13 @@ static void
>  banner(const char *progpath)
>  {
>         char *name =3D basename(progpath);
> +       bool is_asan;
>
> +       /* Check if our BPF programs are ASAN-capable using strstr on the=
 prog name. */
>         printf("%s\n", name);
> +       is_asan =3D strstr(name, "_asan");
>
> -       printf("=3D=3D=3D %s =3D=3D=3D\n", "libarena selftests");
> +       printf("=3D=3D=3D %s %s=3D=3D=3D\n", "libarena selftests", is_asa=
n ? "(asan) " : "");
>  }
>
>  int main(int argc, char *argv[])
> diff --git a/tools/testing/selftests/bpf/libarena/selftests/st_asan_commo=
n.h b/tools/testing/selftests/bpf/libarena/selftests/st_asan_common.h
> new file mode 100644
> index 000000000000..a907c9b45651
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/libarena/selftests/st_asan_common.h
> @@ -0,0 +1,46 @@
> +// SPDX-License-Identifier: LGPL-2.1 OR BSD-2-Clause
> +/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
> +
> +#pragma once
> +
> +#define ST_PAGES 64
> +
> +#define ASAN_MAP_STATE(addr)                                            =
     \
> +       do {                                                             =
    \
> +               arena_stdout("%s:%d ASAN %lx -> (val: %x gran: %x set: [%=
s])", \
> +                          __func__, __LINE__, addr,                     =
    \
> +                          asan_shadow_value((addr)), ASAN_GRANULE(addr),=
    \
> +                          asan_shadow_set((addr)) ? "yes" : "no");      =
    \
> +       } while (0)
> +
> +/*
> + * Emit an error and force the current function to exit if the ASAN
> + * violation state is unexpected. Reset the violation state after.
> + */
> +#define ASAN_VALIDATE_ADDR(cond, addr)                                  =
     \
> +       do {                                                             =
    \
> +               asm volatile("" ::: "memory");                           =
    \
> +               if ((asan_violated !=3D 0) !=3D (cond)) {                =
        \
> +                       arena_stdout("%s:%d ASAN asan_violated %lx", __fu=
nc__, \
> +                                  __LINE__, (u64)asan_violated);        =
    \
> +                       ASAN_MAP_STATE((addr));                          =
    \
> +                       return -EINVAL;                                  =
    \
> +               }                                                        =
    \
> +               asan_violated =3D 0;                                     =
      \
> +       } while (0)
> +
> +#define ASAN_VALIDATE()                                                 =
\
> +       do {                                                            \
> +               if ((asan_violated)) {                                  \
> +                       arena_stdout("%s:%d Found ASAN violation at %lx",=
 \
> +                                  __func__, __LINE__, asan_violated);  \
> +                       return -EINVAL;                                 \
> +               }                                                       \
> +       } while (0)

ASAN_VALIDATE_ADDR has to be a macro, but the other two can
be static inline functions.
