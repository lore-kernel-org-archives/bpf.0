Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A709366810
	for <bpf@vger.kernel.org>; Thu, 12 Mar 2026 23:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773359369; cv=none; b=ZFw+/9EUVsLBJAowxLlBXpisEI0ViezxcCHKt6XKFtfD2DL1FL8OZOTWQA1DmN0NdulNU8TB9BJAAUYNT0urzy5ZYFUa9MYPEeMAxpD47lSXxAgdu959QCk8aBtFjQVFSatjh1tN1PI0xt6EfNW2KZHfW4ZMsBQklnXke3hLMmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773359369; c=relaxed/simple;
	bh=+7/tIkm/FLHNj/N66xuzwBAfQ1iSHVbWgXvVYGrb0PI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=awtfzKupVMDwf7efGvtb+F3d/vmyxr9oOAotcvMB1oE15NmyDHplg01KMlQKRfgGwp17aInfjwieKAZ8C3KZKklcR9QHmqOoaZnc9e5B4Obf6ac+9Cx1GaCFyarDYu259u7JrdhB4CAfuGsKIdHc/rE4rnsH/3SXzEuCdmVFt4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IR28Zdx5; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IR28Zdx5"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4852e09e23dso13259435e9.0
        for <bpf@vger.kernel.org>; Thu, 12 Mar 2026 16:49:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773359365; x=1773964165; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1UpwmbOu/UBDZNePrCUY+8ysYtbVZFRG4kHgdJUurhg=;
        b=IR28Zdx546ozPhw48Lh9MZZv0zeQnogHKtLEOMUYQP/lh/mzmRVnipxm/2x2+zFw1F
         Rp7bjvobTf1FkvBaxF6YhbxZhNvK8TbDDge1kfGroPOkDPbOATqmPD/hv1cGeLHo7kuE
         wXQ+lOyuvtPgDQE92j9O2BXTuSYOhmv1hLBUlgGNv93OvVJIHFyE6z8Kj6V1eh5B6K30
         EF8OxK/YncS7Hu6o7fRa9I1rE9n+ZJLLnLHKjmvgfcNEAFR/KPerQwuD0y1Db3L6edq3
         sNIGRiRrJkzVJyxpA55fkq2x2C7MtDQk0TLxGpxqHh6BddtOUYA3FFW2zvUisYAODHq/
         C+jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773359365; x=1773964165;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1UpwmbOu/UBDZNePrCUY+8ysYtbVZFRG4kHgdJUurhg=;
        b=TnXthNepwaYhs1S8xFfPzOAvsnOhNcht3JRpWxv0iLyAd4qP3RU1TZr3/4uViryCVm
         lmmM76fs/Z8hEBNqennvre8GfRS/9ClwyyM64DIdBSFCwpupC3Qtvqh9oxkkLweb5B8r
         02eEl1vF/XLZYZUZ41oNHKsjzK9jlLSAGfmL1JnyrNwnDxDOVVHbuxHWATv94GDvl3/a
         y8PEE/GN7FOoOyAFtevfoNB9fs+BGSgMiCdNNGJQU0HVNRv8cWdMJcswK553FXqY4smk
         5YmBH1CivGjga0MxV8J+s6f/mTiMh5iRVlI/iUlRXqRCLHGFHVeYrU8M5p5uM8J0QGBo
         er+w==
X-Gm-Message-State: AOJu0YyK4jaZq6K5u1wyF+uOqpJnUMC7fXGRgaSgRysVDOuZzim4eTsB
	8r3pm/xLus2I/1ahrh/ahk7TEapnFWU1D3kGCYm80P9/RSMNSTWjMR9Z
X-Gm-Gg: ATEYQzz1YGhSjloKGpTkLYqR/xGBDHgwSSlWbicSOYZjvpAiFb/o0T79yQysEt7zOaX
	+DvAEMYByo4GdghmpXZik37fH3O2xK1Zs3sb1EPsiZmhndaa+m/txerJmW9LuVeR7DrA6fs1DdL
	py24wpJm+Sha/1CriK632jXYYY5O9+iNRYzhqZsLzutOvKFpQnFrRqXsUJGdyDwhm2cN9aTB73T
	T9PKVZuWI421qmvJlsGqfWjl3M9zpCqdiiPdGY1x9vFBqw+soNRjhuUGCpucJrbmxC3iPagbkgj
	zzEIWBcZmGzTyF9jsPP8KAT0x2FIJmx9FfHpPzvCP8kUXjw6IM0aBseav3ThMJdgL+LPULKz4v4
	n6o1S3EnghjLWF9vhoD1q2GAhsQhKnHGpa3wxeHYX/JAvFjiT3lzgqACKwHTF7F9IxOavlG3er5
	6bN8+jxvpDy+Ib2eCWuaUxgOKousr1ViWbiA==
X-Received: by 2002:a05:600c:4583:b0:485:3a86:6392 with SMTP id 5b1f17b1804b1-485566faaffmr16476185e9.20.1773359365367;
        Thu, 12 Mar 2026 16:49:25 -0700 (PDT)
Received: from localhost ([2a01:4b00:bd1f:f500:f867:fc8a:5174:5755])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4854b5e912fsm436612205e9.2.2026.03.12.16.49.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 16:49:24 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com,
 eddyz87@gmail.com, Mykyta Yatsenko <yatsenko@meta.com>
Subject: Re: [PATCH bpf-next] bpftool: Allow explicitly skip llvm, libbfd
 and libcrypto dependencies
In-Reply-To: <CAEf4Bza9U5yftY0CCLv28K_rjw7ATsQeDh6S-2gHCz0eSdH0mg@mail.gmail.com>
References: <20260312-b4-bpftool_build-v1-1-1aadfecaf534@meta.com>
 <CAEf4Bza9U5yftY0CCLv28K_rjw7ATsQeDh6S-2gHCz0eSdH0mg@mail.gmail.com>
Date: Thu, 12 Mar 2026 23:49:22 +0000
Message-ID: <87ikb0a9rx.fsf@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Andrii Nakryiko <andrii.nakryiko@gmail.com> writes:

> On Thu, Mar 12, 2026 at 10:13=E2=80=AFAM Mykyta Yatsenko
> <mykyta.yatsenko5@gmail.com> wrote:
>>
>> From: Mykyta Yatsenko <yatsenko@meta.com>
>>
>> Introduce SKIP_LLVM, SKIP_LIBBFD, and SKIP_CRYPTO build flags that let
>> users build bpftool without these optional dependencies.
>>
>> SKIP_LLVM=3D1 skips LLVM even when detected. SKIP_LIBBFD=3D1 prevents the
>> libbfd JIT disassembly fallback when LLVM is absent. Together, they
>> produce a bpftool with no disassembly support.
>>
>> SKIP_CRYPTO=3D1 excludes sign.c and removes the -lcrypto link dependency.
>> Inline stubs in main.h return errors with a clear message if signing
>> functions are called at runtime.
>>
>> Use BPFTOOL_WITHOUT_CRYPTO (not HAVE_LIBCRYPTO_SUPPORT) as the C
>> define, following the BPFTOOL_WITHOUT_SKELETONS naming convention for
>> bpftool-internal build config, leaving HAVE_LIBCRYPTO_SUPPORT free for
>> proper feature detection in the future.
>>
>> All three flags are propagated through the selftests Makefile to bpftool
>> sub-builds.
>>
>> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
>> ---
>>  tools/bpf/bpftool/Makefile           | 29 +++++++++++++++++++++++++----
>>  tools/bpf/bpftool/main.c             |  7 +++++++
>>  tools/bpf/bpftool/main.h             | 14 ++++++++++++++
>>  tools/testing/selftests/bpf/Makefile |  8 ++++++++
>>  4 files changed, 54 insertions(+), 4 deletions(-)
>>
>> diff --git a/tools/bpf/bpftool/Makefile b/tools/bpf/bpftool/Makefile
>> index 519ea5cb8ab1..4f83a7ec81a5 100644
>> --- a/tools/bpf/bpftool/Makefile
>> +++ b/tools/bpf/bpftool/Makefile
>> @@ -97,6 +97,12 @@ RM ?=3D rm -f
>>
>>  FEATURE_USER =3D .bpftool
>>
>> +# Skip optional dependencies: LLVM (JIT disasm), libbfd (fallback
>> +# disasm), libcrypto (program signing).
>> +SKIP_LLVM ?=3D
>> +SKIP_LIBBFD ?=3D
>> +SKIP_CRYPTO ?=3D
>> +
>>  FEATURE_TESTS :=3D clang-bpf-co-re
>>  FEATURE_TESTS +=3D llvm
>>  FEATURE_TESTS +=3D libcap
>> @@ -130,8 +136,8 @@ include $(FEATURES_DUMP)
>>  endif
>>  endif
>>
>> -LIBS =3D $(LIBBPF) -lelf -lcrypto -lz
>> -LIBS_BOOTSTRAP =3D $(LIBBPF_BOOTSTRAP) -lelf -lcrypto -lz
>> +LIBS =3D $(LIBBPF) -lelf $(CRYPTO_LIBS) -lz
>> +LIBS_BOOTSTRAP =3D $(LIBBPF_BOOTSTRAP) -lelf $(CRYPTO_LIBS) -lz
>
> you use CRYPTO_LIBS here, but actually set it much later. It works
> because of lazy LIBS_BOOSTRAP definition with '=3D', right?
yes, that's because =3D
> But maybe we
> can move LIBS/LIBS_BOOSTRAP to later when all the stuff is well
> defined?
Let me try.
>
>>
>>  ifeq ($(feature-libelf-zstd),1)
>>  LIBS +=3D -lzstd
>> @@ -150,7 +156,12 @@ all: $(OUTPUT)bpftool
>>  SRCS :=3D $(wildcard *.c)
>>
>>  ifeq ($(feature-llvm),1)
>> -  # If LLVM is available, use it for JIT disassembly
>> +ifneq ($(SKIP_LLVM),1)
>> +HAS_LLVM :=3D 1
>> +endif
>> +endif
>> +
>> +ifeq ($(HAS_LLVM),1)
>>    CFLAGS  +=3D -DHAVE_LLVM_SUPPORT
>>    LLVM_CONFIG_LIB_COMPONENTS :=3D mcdisassembler all-targets
>>    # llvm-config always adds -D_GNU_SOURCE, however, it may already be i=
n CFLAGS
>> @@ -165,6 +176,7 @@ ifeq ($(feature-llvm),1)
>>    endif
>>    LDFLAGS +=3D $(shell $(LLVM_CONFIG) --ldflags)
>>  else
>> +  ifneq ($(SKIP_LIBBFD),1)
>>    # Fall back on libbfd
>>    ifeq ($(feature-libbfd),1)
>>      LIBS +=3D -lbfd -ldl -lopcodes
>> @@ -186,15 +198,24 @@ else
>>        CFLAGS +=3D -DDISASM_INIT_STYLED
>>      endif
>>    endif
>> +  endif # SKIP_LIBBFD
>>  endif
>>  ifeq ($(filter -DHAVE_LLVM_SUPPORT -DHAVE_LIBBFD_SUPPORT,$(CFLAGS)),)
>>    # No support for JIT disassembly
>>    SRCS :=3D $(filter-out jit_disasm.c,$(SRCS))
>>  endif
>>
>> +ifeq ($(SKIP_CRYPTO),1)
>> +  CFLAGS +=3D -DBPFTOOL_WITHOUT_CRYPTO
>> +  HOST_CFLAGS +=3D -DBPFTOOL_WITHOUT_CRYPTO
>> +  SRCS :=3D $(filter-out sign.c,$(SRCS))
>> +else
>> +  CRYPTO_LIBS :=3D -lcrypto
>> +endif
>> +
>>  BPFTOOL_BOOTSTRAP :=3D $(BOOTSTRAP_OUTPUT)bpftool
>>
>> -BOOTSTRAP_OBJS =3D $(addprefix $(BOOTSTRAP_OUTPUT),main.o common.o json=
_writer.o gen.o btf.o sign.o)
>> +BOOTSTRAP_OBJS =3D $(addprefix $(BOOTSTRAP_OUTPUT),main.o common.o json=
_writer.o gen.o btf.o $(if $(CRYPTO_LIBS),sign.o))
>>  $(BOOTSTRAP_OBJS): $(LIBBPF_BOOTSTRAP)
>>
>>  OBJS =3D $(patsubst %.c,$(OUTPUT)%.o,$(SRCS)) $(OUTPUT)disasm.o
>> diff --git a/tools/bpf/bpftool/main.c b/tools/bpf/bpftool/main.c
>> index a829a6a49037..c91e1a6e1a1e 100644
>> --- a/tools/bpf/bpftool/main.c
>> +++ b/tools/bpf/bpftool/main.c
>> @@ -131,6 +131,11 @@ static int do_version(int argc, char **argv)
>>         const bool has_skeletons =3D false;
>>  #else
>>         const bool has_skeletons =3D true;
>> +#endif
>> +#ifdef BPFTOOL_WITHOUT_CRYPTO
>> +       const bool has_crypto =3D false;
>> +#else
>> +       const bool has_crypto =3D true;
>>  #endif
>>         bool bootstrap =3D false;
>>         int i;
>> @@ -163,6 +168,7 @@ static int do_version(int argc, char **argv)
>>                 jsonw_start_object(json_wtr);   /* features */
>>                 jsonw_bool_field(json_wtr, "libbfd", has_libbfd);
>>                 jsonw_bool_field(json_wtr, "llvm", has_llvm);
>> +               jsonw_bool_field(json_wtr, "crypto", has_crypto);
>>                 jsonw_bool_field(json_wtr, "skeletons", has_skeletons);
>>                 jsonw_bool_field(json_wtr, "bootstrap", bootstrap);
>>                 jsonw_end_object(json_wtr);     /* features */
>> @@ -181,6 +187,7 @@ static int do_version(int argc, char **argv)
>>                 printf("features:");
>>                 print_feature("libbfd", has_libbfd, &nb_features);
>>                 print_feature("llvm", has_llvm, &nb_features);
>> +               print_feature("crypto", has_crypto, &nb_features);
>>                 print_feature("skeletons", has_skeletons, &nb_features);
>>                 print_feature("bootstrap", bootstrap, &nb_features);
>>                 printf("\n");
>> diff --git a/tools/bpf/bpftool/main.h b/tools/bpf/bpftool/main.h
>> index 1130299cede0..169392a4552d 100644
>> --- a/tools/bpf/bpftool/main.h
>> +++ b/tools/bpf/bpftool/main.h
>> @@ -293,6 +293,20 @@ struct kernel_config_option {
>>  int read_kernel_config(const struct kernel_config_option *requested_opt=
ions,
>>                        size_t num_options, char **out_values,
>>                        const char *define_prefix);
>> +#ifndef BPFTOOL_WITHOUT_CRYPTO
>>  int bpftool_prog_sign(struct bpf_load_and_run_opts *opts);
>>  __u32 register_session_key(const char *key_der_path);
>> +#else
>> +static inline int bpftool_prog_sign(struct bpf_load_and_run_opts *opts)
>> +{
>> +       p_err("program signing requires libcrypto");
>
> we should probably say that "bpftool was built without signing
> support". It could be confusing to end-user as they might have
> libcrypto installed on their system, but this functionality will still
> not work
Agree
>
>> +       return -ENOTSUP;
>> +}
>> +
>> +static inline __u32 register_session_key(const char *key_der_path)
>> +{
>> +       p_err("program signing requires libcrypto");
>> +       return -1;
>> +}
>> +#endif
>>  #endif
>> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selfte=
sts/bpf/Makefile
>> index 869b582b1d1f..e27501c06b56 100644
>> --- a/tools/testing/selftests/bpf/Makefile
>> +++ b/tools/testing/selftests/bpf/Makefile
>> @@ -41,6 +41,8 @@ LIBELF_LIBS   :=3D $(shell $(PKG_CONFIG) libelf --libs=
 2>/dev/null || echo -lelf)
>>
>>  SKIP_DOCS      ?=3D
>>  SKIP_LLVM      ?=3D
>> +SKIP_LIBBFD    ?=3D
>> +SKIP_CRYPTO    ?=3D
>>
>>  ifeq ($(srctree),)
>>  srctree :=3D $(patsubst %/,%,$(dir $(CURDIR)))
>> @@ -333,6 +335,9 @@ $(DEFAULT_BPFTOOL): $(wildcard $(BPFTOOLDIR)/*.[ch] =
$(BPFTOOLDIR)/Makefile)    \
>>                     OUTPUT=3D$(HOST_BUILD_DIR)/bpftool/                 =
         \
>>                     LIBBPF_OUTPUT=3D$(HOST_BUILD_DIR)/libbpf/           =
         \
>>                     LIBBPF_DESTDIR=3D$(HOST_SCRATCH_DIR)/               =
         \
>> +                   SKIP_LLVM=3D$(SKIP_LLVM)                            =
         \
>> +                   SKIP_LIBBFD=3D$(SKIP_LIBBFD)                        =
         \
>> +                   SKIP_CRYPTO=3D$(SKIP_CRYPTO)                        =
         \
>>                     prefix=3D DESTDIR=3D$(HOST_SCRATCH_DIR)/ install-bin
>>
>>  ifneq ($(CROSS_COMPILE),)
>> @@ -345,6 +350,9 @@ $(CROSS_BPFTOOL): $(wildcard $(BPFTOOLDIR)/*.[ch] $(=
BPFTOOLDIR)/Makefile)   \
>>                     OUTPUT=3D$(BUILD_DIR)/bpftool/                      =
          \
>>                     LIBBPF_OUTPUT=3D$(BUILD_DIR)/libbpf/                =
          \
>>                     LIBBPF_DESTDIR=3D$(SCRATCH_DIR)/                    =
          \
>> +                   SKIP_LLVM=3D$(SKIP_LLVM)                            =
          \
>> +                   SKIP_LIBBFD=3D$(SKIP_LIBBFD)                        =
          \
>> +                   SKIP_CRYPTO=3D$(SKIP_CRYPTO)                        =
          \
>>                     prefix=3D DESTDIR=3D$(SCRATCH_DIR)/ install-bin
>>  endif
>>
>>
>> ---
>> base-commit: ca0f39a369c5f927c3d004e63a5a778b08a9df94
>> change-id: 20260312-b4-bpftool_build-fe7d37d535bd
>>
>> Best regards,
>> --
>> Mykyta Yatsenko <yatsenko@meta.com>
>>
