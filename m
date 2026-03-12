Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59CE326C3BD
	for <bpf@vger.kernel.org>; Thu, 12 Mar 2026 20:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773347654; cv=pass; b=iNDSI3AYV4dthR2lNo0MTbPcWCP3lEX0J/EApmWqaKaCuxaPGS8jzJfh3+/RTbpA3Gd3JyEcxEoEBZe5vke/f6tTACNfXVj6gv/2+8NQV1QAF7+vm5u8ZCeVgYUdhHgbISAeSb9QkZOa9+heIIV+3J2WY8nOTDrn+OAmw13iEA0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773347654; c=relaxed/simple;
	bh=REkgyPOsoMmt+BDi8gxrYxYTjUEIkWd5fNko3XOOhdw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L3CDYesQWDkVe3eSM1f1FmFyDocAE18jGfhDIRBff8gznfd29vsL1DLjJnorXCzyaRrq2A/+0HT1nxRAiwKbb2MKlgDjgpQ50cMfO2sD/TSG5Sh+a2G1a7wlrKVHZxx/zHM4CqXbAqpda4hyi6G4ZBrg/6tMVxCMc8DdDhr0zK8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=THyi2bcM; arc=pass smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="THyi2bcM"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2ad9a9be502so9519225ad.0
        for <bpf@vger.kernel.org>; Thu, 12 Mar 2026 13:34:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773347653; cv=none;
        d=google.com; s=arc-20240605;
        b=kf2YWO2WMcQzb+PW7ZVh8YZAFAZReQ03U0piHYlqrWIrRmDYGfjsv0rAYRWjYu2U65
         tp9S+xQwoWL1yloaekzAmd1ihfws8K2fE5m0Rsll6hHz6clpTXRZ5dj6fqKqV+KlWw7Z
         mxE6XkN+DFqbA+nIfBZUwjf8XXB6gKD/bdgR2txfWouN8pfMMp+ff54G0R5VczJawVr6
         ZAh+rmx4p/9LuwKR69xORJcFga1hCm2w2e0LDlW61tu/s6nUrhZtPvxfRnoxNseNem35
         wDKNadzp3JxWA6RKdwgnovHf0FRLd21DDPB5tYjtocuTOT2N2YhMDuub08EtIb0aeozc
         m2ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=yuqwt7SboaiAshh9qWLr4cZIh44VvNFQFoQo44yiokc=;
        fh=mV8Uwy03aTQpEc71kkKqimIDFbwq2oIhKiU5zAUO9K0=;
        b=cF2nC8/YJEarrnA+B5D97nqoU0ddu+2gZz6Su3JFBJSfrUfLot4KApbtcNO+GhU4Df
         y8PnR9CowhakI4kQMak+j4H0gWqQx7Ui+rCLIsnPlibWIg7UOhZBYoRZqEWF6f9k+i0P
         o7SIgGDqvlZvQVmD5MDupyGonHRbwnO5kJp1rnAU9IXh/3bAuRuYmn+/MYw69nNAazL2
         egIBOmSe2+1iH9sZXp1rPQG9BGUko2TRM0M0aKL1R0YuI4eNF5RYQ7ZtVX1stGxIQ5fq
         DkohyR+dw778FD6Qr5jwa1F+djI15KEDi5EirIp6kvl/VwGbgWbG43MRj3+rlNtYsZmq
         /zuA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773347653; x=1773952453; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yuqwt7SboaiAshh9qWLr4cZIh44VvNFQFoQo44yiokc=;
        b=THyi2bcM37xvPZ0WqewMqImlIfDLg/4w6Mr/Ua9Hs0/LUcEvFiineNwh0ARpMxnZ9z
         M8JLB75dxWTnxK4DxS4jfcDVBZBTUUmEg+KLL/bVdEwl6/JXf1njZje/Cn+KAyz6yR1p
         J/5kCXH1oOi6d3iWMGjASQ+zQf4lpeO6Ye23tgkmYAFbDle/7zufwwYdjbCHcHPqK6hL
         Qh2vANe65Al+FhzQc2+Mi/dhOgY9+bAHaRqYrb8PpqrHKZ+mWe4qhJcz+HmNm3T7dbL3
         jVoCc3sobdNlo9ssRiPwWz4vd/YKSynlE+I1njdyq2j/TdaJiKoQdvOb7axaCYbax7Dy
         TrZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773347653; x=1773952453;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yuqwt7SboaiAshh9qWLr4cZIh44VvNFQFoQo44yiokc=;
        b=J7vErM8HV31dtZajKuDTck0tLQAgxLhwpx/WfFO7uYG/9Oxi5srbAWhgM3N6hHs6r8
         WILpR2ntfnsZ1FyIsxRoOdogD3rVsKVKUyyLYuDe3kbLHlHXLSg6Rx0+UfosHkZ2fZ5c
         qf0lCKV42AyAcD8g/xT+RAfbkSIgl1viGD/OBqC6oD60EQs3yH9Uj3r7xpxOIpJist/1
         3RkSrfoQ4MJ7eUYKVPH8tn+xANmTE+th5dCW8h9MRVSXZQzCQXv+bhleDywET+nIOkn2
         ZOJSVJwIQU3StIogZWDotyDjWZ39UikXBLZPKfhFgapqKe8rJ006oLIEOM8/qntiSqm3
         yrFg==
X-Gm-Message-State: AOJu0YzHSe+nUAMsKfN4mpzzdoB9anuwxDDPVNzM+kW3WK8bB6Yd7n9h
	mSmLmkZCsWvgX4UW4j9DXBVl6zl+40OA562rOcSJ05k8GMhVOrurMl6fV4VWT4xEY1QyW2jxszy
	x7Qtlt/JGxL639WNU1SHgyLUzZjPomPxQ2pKA
X-Gm-Gg: ATEYQzx84hr91Q/LIgHDwaHsTETDKN9I4lk/DHBVCIH/n+b6dstoFnSSMeZn1uPBcdi
	TC/wzI5YkRUaupb9ofhEi1JLtc4R6iIRGG9Ovm7bSsNBfUnPwAWscVdyXDSS70US4HvYcwu1op2
	ZJ/BmoV0jvfzhUgGBDgC9gpzxIC8pp4H249zvTqlqHqwwzLBJ4ZVaOIS+I2UVU4v0RqcRUDZSHR
	dXXtjFmJJ7tai3adiXspBZUuYHEVD8RKPJFjKfMG7URrV1ZwhTs2zxCjn6Q83NgmvzRU/Hj7euS
	QwJ5h7VspVQ1T5e2nHsbKdM=
X-Received: by 2002:a17:903:1b6f:b0:2ae:8272:deb0 with SMTP id
 d9443c01a7336-2aecaa12568mr7835765ad.15.1773347652564; Thu, 12 Mar 2026
 13:34:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260312-b4-bpftool_build-v1-1-1aadfecaf534@meta.com>
In-Reply-To: <20260312-b4-bpftool_build-v1-1-1aadfecaf534@meta.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 12 Mar 2026 13:33:59 -0700
X-Gm-Features: AaiRm516IoFcVA0VlvHZENECHy1nMKZtoViyPaixl4KDbnUwMtavcVmkS8FW1YI
Message-ID: <CAEf4Bza9U5yftY0CCLv28K_rjw7ATsQeDh6S-2gHCz0eSdH0mg@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpftool: Allow explicitly skip llvm, libbfd and
 libcrypto dependencies
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, eddyz87@gmail.com, 
	Mykyta Yatsenko <yatsenko@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 12, 2026 at 10:13=E2=80=AFAM Mykyta Yatsenko
<mykyta.yatsenko5@gmail.com> wrote:
>
> From: Mykyta Yatsenko <yatsenko@meta.com>
>
> Introduce SKIP_LLVM, SKIP_LIBBFD, and SKIP_CRYPTO build flags that let
> users build bpftool without these optional dependencies.
>
> SKIP_LLVM=3D1 skips LLVM even when detected. SKIP_LIBBFD=3D1 prevents the
> libbfd JIT disassembly fallback when LLVM is absent. Together, they
> produce a bpftool with no disassembly support.
>
> SKIP_CRYPTO=3D1 excludes sign.c and removes the -lcrypto link dependency.
> Inline stubs in main.h return errors with a clear message if signing
> functions are called at runtime.
>
> Use BPFTOOL_WITHOUT_CRYPTO (not HAVE_LIBCRYPTO_SUPPORT) as the C
> define, following the BPFTOOL_WITHOUT_SKELETONS naming convention for
> bpftool-internal build config, leaving HAVE_LIBCRYPTO_SUPPORT free for
> proper feature detection in the future.
>
> All three flags are propagated through the selftests Makefile to bpftool
> sub-builds.
>
> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> ---
>  tools/bpf/bpftool/Makefile           | 29 +++++++++++++++++++++++++----
>  tools/bpf/bpftool/main.c             |  7 +++++++
>  tools/bpf/bpftool/main.h             | 14 ++++++++++++++
>  tools/testing/selftests/bpf/Makefile |  8 ++++++++
>  4 files changed, 54 insertions(+), 4 deletions(-)
>
> diff --git a/tools/bpf/bpftool/Makefile b/tools/bpf/bpftool/Makefile
> index 519ea5cb8ab1..4f83a7ec81a5 100644
> --- a/tools/bpf/bpftool/Makefile
> +++ b/tools/bpf/bpftool/Makefile
> @@ -97,6 +97,12 @@ RM ?=3D rm -f
>
>  FEATURE_USER =3D .bpftool
>
> +# Skip optional dependencies: LLVM (JIT disasm), libbfd (fallback
> +# disasm), libcrypto (program signing).
> +SKIP_LLVM ?=3D
> +SKIP_LIBBFD ?=3D
> +SKIP_CRYPTO ?=3D
> +
>  FEATURE_TESTS :=3D clang-bpf-co-re
>  FEATURE_TESTS +=3D llvm
>  FEATURE_TESTS +=3D libcap
> @@ -130,8 +136,8 @@ include $(FEATURES_DUMP)
>  endif
>  endif
>
> -LIBS =3D $(LIBBPF) -lelf -lcrypto -lz
> -LIBS_BOOTSTRAP =3D $(LIBBPF_BOOTSTRAP) -lelf -lcrypto -lz
> +LIBS =3D $(LIBBPF) -lelf $(CRYPTO_LIBS) -lz
> +LIBS_BOOTSTRAP =3D $(LIBBPF_BOOTSTRAP) -lelf $(CRYPTO_LIBS) -lz

you use CRYPTO_LIBS here, but actually set it much later. It works
because of lazy LIBS_BOOSTRAP definition with '=3D', right? But maybe we
can move LIBS/LIBS_BOOSTRAP to later when all the stuff is well
defined?

>
>  ifeq ($(feature-libelf-zstd),1)
>  LIBS +=3D -lzstd
> @@ -150,7 +156,12 @@ all: $(OUTPUT)bpftool
>  SRCS :=3D $(wildcard *.c)
>
>  ifeq ($(feature-llvm),1)
> -  # If LLVM is available, use it for JIT disassembly
> +ifneq ($(SKIP_LLVM),1)
> +HAS_LLVM :=3D 1
> +endif
> +endif
> +
> +ifeq ($(HAS_LLVM),1)
>    CFLAGS  +=3D -DHAVE_LLVM_SUPPORT
>    LLVM_CONFIG_LIB_COMPONENTS :=3D mcdisassembler all-targets
>    # llvm-config always adds -D_GNU_SOURCE, however, it may already be in=
 CFLAGS
> @@ -165,6 +176,7 @@ ifeq ($(feature-llvm),1)
>    endif
>    LDFLAGS +=3D $(shell $(LLVM_CONFIG) --ldflags)
>  else
> +  ifneq ($(SKIP_LIBBFD),1)
>    # Fall back on libbfd
>    ifeq ($(feature-libbfd),1)
>      LIBS +=3D -lbfd -ldl -lopcodes
> @@ -186,15 +198,24 @@ else
>        CFLAGS +=3D -DDISASM_INIT_STYLED
>      endif
>    endif
> +  endif # SKIP_LIBBFD
>  endif
>  ifeq ($(filter -DHAVE_LLVM_SUPPORT -DHAVE_LIBBFD_SUPPORT,$(CFLAGS)),)
>    # No support for JIT disassembly
>    SRCS :=3D $(filter-out jit_disasm.c,$(SRCS))
>  endif
>
> +ifeq ($(SKIP_CRYPTO),1)
> +  CFLAGS +=3D -DBPFTOOL_WITHOUT_CRYPTO
> +  HOST_CFLAGS +=3D -DBPFTOOL_WITHOUT_CRYPTO
> +  SRCS :=3D $(filter-out sign.c,$(SRCS))
> +else
> +  CRYPTO_LIBS :=3D -lcrypto
> +endif
> +
>  BPFTOOL_BOOTSTRAP :=3D $(BOOTSTRAP_OUTPUT)bpftool
>
> -BOOTSTRAP_OBJS =3D $(addprefix $(BOOTSTRAP_OUTPUT),main.o common.o json_=
writer.o gen.o btf.o sign.o)
> +BOOTSTRAP_OBJS =3D $(addprefix $(BOOTSTRAP_OUTPUT),main.o common.o json_=
writer.o gen.o btf.o $(if $(CRYPTO_LIBS),sign.o))
>  $(BOOTSTRAP_OBJS): $(LIBBPF_BOOTSTRAP)
>
>  OBJS =3D $(patsubst %.c,$(OUTPUT)%.o,$(SRCS)) $(OUTPUT)disasm.o
> diff --git a/tools/bpf/bpftool/main.c b/tools/bpf/bpftool/main.c
> index a829a6a49037..c91e1a6e1a1e 100644
> --- a/tools/bpf/bpftool/main.c
> +++ b/tools/bpf/bpftool/main.c
> @@ -131,6 +131,11 @@ static int do_version(int argc, char **argv)
>         const bool has_skeletons =3D false;
>  #else
>         const bool has_skeletons =3D true;
> +#endif
> +#ifdef BPFTOOL_WITHOUT_CRYPTO
> +       const bool has_crypto =3D false;
> +#else
> +       const bool has_crypto =3D true;
>  #endif
>         bool bootstrap =3D false;
>         int i;
> @@ -163,6 +168,7 @@ static int do_version(int argc, char **argv)
>                 jsonw_start_object(json_wtr);   /* features */
>                 jsonw_bool_field(json_wtr, "libbfd", has_libbfd);
>                 jsonw_bool_field(json_wtr, "llvm", has_llvm);
> +               jsonw_bool_field(json_wtr, "crypto", has_crypto);
>                 jsonw_bool_field(json_wtr, "skeletons", has_skeletons);
>                 jsonw_bool_field(json_wtr, "bootstrap", bootstrap);
>                 jsonw_end_object(json_wtr);     /* features */
> @@ -181,6 +187,7 @@ static int do_version(int argc, char **argv)
>                 printf("features:");
>                 print_feature("libbfd", has_libbfd, &nb_features);
>                 print_feature("llvm", has_llvm, &nb_features);
> +               print_feature("crypto", has_crypto, &nb_features);
>                 print_feature("skeletons", has_skeletons, &nb_features);
>                 print_feature("bootstrap", bootstrap, &nb_features);
>                 printf("\n");
> diff --git a/tools/bpf/bpftool/main.h b/tools/bpf/bpftool/main.h
> index 1130299cede0..169392a4552d 100644
> --- a/tools/bpf/bpftool/main.h
> +++ b/tools/bpf/bpftool/main.h
> @@ -293,6 +293,20 @@ struct kernel_config_option {
>  int read_kernel_config(const struct kernel_config_option *requested_opti=
ons,
>                        size_t num_options, char **out_values,
>                        const char *define_prefix);
> +#ifndef BPFTOOL_WITHOUT_CRYPTO
>  int bpftool_prog_sign(struct bpf_load_and_run_opts *opts);
>  __u32 register_session_key(const char *key_der_path);
> +#else
> +static inline int bpftool_prog_sign(struct bpf_load_and_run_opts *opts)
> +{
> +       p_err("program signing requires libcrypto");

we should probably say that "bpftool was built without signing
support". It could be confusing to end-user as they might have
libcrypto installed on their system, but this functionality will still
not work

> +       return -ENOTSUP;
> +}
> +
> +static inline __u32 register_session_key(const char *key_der_path)
> +{
> +       p_err("program signing requires libcrypto");
> +       return -1;
> +}
> +#endif
>  #endif
> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftes=
ts/bpf/Makefile
> index 869b582b1d1f..e27501c06b56 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile
> @@ -41,6 +41,8 @@ LIBELF_LIBS   :=3D $(shell $(PKG_CONFIG) libelf --libs =
2>/dev/null || echo -lelf)
>
>  SKIP_DOCS      ?=3D
>  SKIP_LLVM      ?=3D
> +SKIP_LIBBFD    ?=3D
> +SKIP_CRYPTO    ?=3D
>
>  ifeq ($(srctree),)
>  srctree :=3D $(patsubst %/,%,$(dir $(CURDIR)))
> @@ -333,6 +335,9 @@ $(DEFAULT_BPFTOOL): $(wildcard $(BPFTOOLDIR)/*.[ch] $=
(BPFTOOLDIR)/Makefile)    \
>                     OUTPUT=3D$(HOST_BUILD_DIR)/bpftool/                  =
        \
>                     LIBBPF_OUTPUT=3D$(HOST_BUILD_DIR)/libbpf/            =
        \
>                     LIBBPF_DESTDIR=3D$(HOST_SCRATCH_DIR)/                =
        \
> +                   SKIP_LLVM=3D$(SKIP_LLVM)                             =
        \
> +                   SKIP_LIBBFD=3D$(SKIP_LIBBFD)                         =
        \
> +                   SKIP_CRYPTO=3D$(SKIP_CRYPTO)                         =
        \
>                     prefix=3D DESTDIR=3D$(HOST_SCRATCH_DIR)/ install-bin
>
>  ifneq ($(CROSS_COMPILE),)
> @@ -345,6 +350,9 @@ $(CROSS_BPFTOOL): $(wildcard $(BPFTOOLDIR)/*.[ch] $(B=
PFTOOLDIR)/Makefile)   \
>                     OUTPUT=3D$(BUILD_DIR)/bpftool/                       =
         \
>                     LIBBPF_OUTPUT=3D$(BUILD_DIR)/libbpf/                 =
         \
>                     LIBBPF_DESTDIR=3D$(SCRATCH_DIR)/                     =
         \
> +                   SKIP_LLVM=3D$(SKIP_LLVM)                             =
         \
> +                   SKIP_LIBBFD=3D$(SKIP_LIBBFD)                         =
         \
> +                   SKIP_CRYPTO=3D$(SKIP_CRYPTO)                         =
         \
>                     prefix=3D DESTDIR=3D$(SCRATCH_DIR)/ install-bin
>  endif
>
>
> ---
> base-commit: ca0f39a369c5f927c3d004e63a5a778b08a9df94
> change-id: 20260312-b4-bpftool_build-fe7d37d535bd
>
> Best regards,
> --
> Mykyta Yatsenko <yatsenko@meta.com>
>
