Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAFB16BB5B
	for <bpf@vger.kernel.org>; Fri, 24 Jul 2026 02:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784858595; cv=pass; b=hjzinE1bkNuQEJQ9gdCn69LtC0MxlWtQa5qxOYGSzDMJcC3qByMhMLhMSFeVBieZIHFTxCReXCVd0Ew+3uQg7c/csnJP8VcHX86FaYa+V/nQVyVzY+GeJD5EesymQJbu0LO9MinEDTBidquBx68bsP1O9eYWb39FsUEmJNCJmug=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784858595; c=relaxed/simple;
	bh=aKiQJVqlrW0K6BlzCzmgWZ5eml54wQtIn11u0O1p6QM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t/84WZdYkIl8KY/3Inh+X+1CtaFwJJsiPdN3loWBXanT+8IgLpej5eLG7w/hsWH22EYFYP4S89B7+068XGl1wzkLGJNVDAisJch78dcmF7dTzR5s5WLF4R/ewnLjM6E73eu9W3rZr0nFc4Jb24NxkeAxjHwrQcWozgen8nbLLqk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hMsAZSZt; arc=pass smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hMsAZSZt"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-69e2266b07fso1990927a12.2
        for <bpf@vger.kernel.org>; Thu, 23 Jul 2026 19:03:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784858591; cv=none;
        d=google.com; s=arc-20260327;
        b=D2kEtQoESZuS6PMxmN6XXdqYDHFKKxu8XgD6T21NTJ/T8usBKxqT/Nz15jVlas0FlF
         Fn4dJYblFLQ/RK0n8lCnVwTRGppnZEqptFRchiouQ3GsQE7Z+EefqKrbmMQdbfFSL7s2
         YxjpucLp37yDhhXVOFoeLiaLivSU5a0tKO7dbhEnNMkT2FC5UxO3G0gvVuoHSUG8plwG
         b/YaA9/j99Stwt+VEWZCT15+IOIO9w7QTzL2D8U0DTCtNZpKLIuNGuGbCoROq+Yq9UvU
         4yQJKROYCiyXzBG30IxzSxCASJrmC1i+0eZH7vtY+krXVlszPqeGaxmT1vdrKYNnatHU
         WlmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=CKsEgErnEprzco8bxG2BhtOzbqaqC8PsYP+HEUVBceA=;
        fh=FthGvuR3K9/4OOpgmQJp7FB64mSmSiZB6V3xeZ/77Q8=;
        b=cYv4GiJH05v1yZwiB3xorV0nVjx7pfC6V8tWvJ9x5f0CP2pVi9xjJXtiwrTqcB5hQW
         Syj3oil1uCgdtZ/sICHxbnsFWPrww5IW9tucI2xFlpoCpuLAdh40sR6vVKCen1H3guBw
         OUiw0XVfA5Lmr0XDrlFKWYJCujmt77rz7bAJZBiGEZ1JkMsAoDeuhPhmLv+W0FNx+gJO
         JxSgS7siCITCXkCeddM61VxAdGKUeWV0r/3LKnc0kNCfNIASxVaUnvWHBsq5M7GwwwzP
         wi3pql8W2OzT3FZR2rMB8Sr6cO2DtHYxXtcsKCL2fTniVYXqQ74Y49mIiaB8CG0y0l0V
         +qgQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784858591; x=1785463391; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=CKsEgErnEprzco8bxG2BhtOzbqaqC8PsYP+HEUVBceA=;
        b=hMsAZSZtUq23LoiJr4A9kIOWgmqBInkEnOCU7SpNVeX+cwKSCGwnDFPQUu6Y3lNTuX
         YT8+pNjT4akfn2siskRd//7EUIKsUpvHYQnBh+92MFfk3sxTxcJI4ShYFGEvUzGPcYW/
         r8RZxBjhm2R2TqpUr3+smcwx3aKd96BtvWP+H0QjyvhzOaM0uHecAMvtObIJGDd9pp4k
         JCtjM9suT0ASClfSEATktw1r+lucUejvLwzA7PvjRzgx7gYJg7EQ4N+wDvvwqfvrWrnK
         spfziiSx45wGaJQW6MRtKSz1Yq+hSlJ9/Q2COG/xS3KJDfqtzaCsYUIvNVQwIjnnCv6M
         IZwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784858591; x=1785463391;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CKsEgErnEprzco8bxG2BhtOzbqaqC8PsYP+HEUVBceA=;
        b=qNkpwhIqh0pvShNNKk4N6jN67TgJ9B5xFmYNRz0XQtJiiQEXHp1WNA3ghudlZJTLR4
         77z3IJZ8tCDRJaDMxOnNpFwGSkBAbNjbBnOkNQutjMZ2Y4gQ3BiaM7QyScwvRP49wcYk
         3lVmR8q4Fr4owZuAiju7raKOmU/sXzgy4Yn1QYLbL+JlXWTT+BBXzudPBY05J3VRw44W
         CaYuGsIDxh1NF0gEXdMiEQgiijb2gBMux5ZUhZkcKD5IJGFXGDJH65toz3pUaqtpyYWF
         tdHURGl01oCeONZFfqh6BNfwHPucpNplPFDQdoxghX3NXbQpcBoqYsD1If8mQExPiKBg
         zAKw==
X-Gm-Message-State: AOJu0Yycb2c+qhajBYwxHU+unwOlhRqnufp2lsHyRethYHURHLGxrh9M
	b1k9c503lQYa49EqNHSWD8FQdn5ha5KaQjzx1yM8wcV46xKd3Mi3t9oOzvkDdExd/yCb3xMLbtV
	J34uwih2KDjFj4kCE4uZ3h0A4WNyDj2s=
X-Gm-Gg: AR+sD10J4wCIppz6cZSpASJRZbA109iGaxygyWlR1pBol1ZY9yjSOfx7TvU9qqiczIS
	wkXxHUTuJXVeZ3wgowkdughdyqIiyp/Lq2aFoj/HzEvp5ezmmIkNet5wN7hIgt38mu9sdjfbqCE
	OCmQ6CWDK92aerCfTrNforiwnjrvFdXkxBz+ypahLsx6Sw2dZ2LJEjP9rFEM3cMkWZLlx1MFjpG
	exGnphlyRmuaNZVj6b62ZYOiwwDbaudWifzzMqQ61de2HhdRNn/AlNLWPFRyRYUSIaR6Ud9pxH2
	SHhsoQmT/nh9FPvuEh39jvQp1HkJpQ==
X-Received: by 2002:a17:907:72c9:b0:c16:2a6d:86da with SMTP id
 a640c23a62f3a-c1c509a3daemr230567366b.54.1784858590892; Thu, 23 Jul 2026
 19:03:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260722040830.387979-1-nickolay.lysenko@gmail.com>
 <20260722040830.387979-3-nickolay.lysenko@gmail.com> <ffaa53ae46ded031e578996ce6f69d4a19fead29.camel@gmail.com>
In-Reply-To: <ffaa53ae46ded031e578996ce6f69d4a19fead29.camel@gmail.com>
From: Mykola Lysenko <nickolay.lysenko@gmail.com>
Date: Thu, 23 Jul 2026 19:02:58 -0700
X-Gm-Features: AUfX_myK8BeFpoLe9_JwaMF8lUm8-AYLhFjG3YbgIJn_3mlnEV494xytHxgUp9w
Message-ID: <CAMtxOX1xeg86pO8+EOiD_M+-Bjr4ko26UgVOc3NWE5Vtx+O9JQ@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next v3 2/3] selftests/bpf: move shared build
 definitions into Makefile.buildvars
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, martin.lau@linux.dev, song@kernel.org, 
	yonghong.song@linux.dev, jolsa@kernel.org, memxor@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 22, 2026 at 4:12=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Tue, 2026-07-21 at 21:08 -0700, Mykola Lysenko wrote:
>
> ...
>
> >  tools/testing/selftests/bpf/Makefile          | 169 +---------------
> >  .../testing/selftests/bpf/Makefile.buildvars  | 191 ++++++++++++++++++
> >  2 files changed, 202 insertions(+), 158 deletions(-)
> >  create mode 100644 tools/testing/selftests/bpf/Makefile.buildvars
> >
> > diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selft=
ests/bpf/Makefile
> > index 09e5be201..ce589f102 100644
> > --- a/tools/testing/selftests/bpf/Makefile
> > +++ b/tools/testing/selftests/bpf/Makefile
> > @@ -3,93 +3,28 @@ include ../../../build/Build.include
> >  include ../../../scripts/Makefile.arch
> >  include ../../../scripts/Makefile.include
> >
> > -CXX ?=3D $(CROSS_COMPILE)g++
> > -OBJCOPY ?=3D $(CROSS_COMPILE)objcopy
> > -
> > -CURDIR :=3D $(abspath .)
> > -TOOLSDIR :=3D $(abspath ../../..)
> > -LIBDIR :=3D $(TOOLSDIR)/lib
> > -BPFDIR :=3D $(LIBDIR)/bpf
> > -TOOLSINCDIR :=3D $(TOOLSDIR)/include
> > -TOOLSARCHINCDIR :=3D $(TOOLSDIR)/arch/$(SRCARCH)/include
> > -BPFTOOLDIR :=3D $(TOOLSDIR)/bpf/bpftool
> > -APIDIR :=3D $(TOOLSINCDIR)/uapi
> > -ifneq ($(O),)
> > -GENDIR :=3D $(O)/include/generated
> > -else
> > -GENDIR :=3D $(abspath ../../../../include/generated)
> > -endif
> > -GENHDR :=3D $(GENDIR)/autoconf.h
> > -PKG_CONFIG ?=3D $(CROSS_COMPILE)pkg-config
> >
> > -ifneq ($(wildcard $(GENHDR)),)
> > -  GENFLAGS :=3D -DHAVE_GENHDR
> > +# BPF_GCC and TEST_KMODS are needed before lib.mk is included (they ga=
te
> > +# the flavor list and TEST_GEN_FILES), while Makefile.buildvars can on=
ly
> > +# be included after it, so they are defined here - once - and exported
> > +# for the runner sub-makes, whose Makefile.buildvars include picks the=
m
> > +# up from the environment.
> > +ifeq ($(origin BPF_GCC),undefined)
> > +BPF_GCC :=3D $(shell command -v bpf-gcc;)
> >  endif
> > +export BPF_GCC TEST_KMODS
> >
> > -BPF_GCC              ?=3D $(shell command -v bpf-gcc;)
> > -ifdef ASAN
> > -SAN_CFLAGS   ?=3D -fsanitize=3Daddress -fno-omit-frame-pointer
> > -else
> > -SAN_CFLAGS   ?=3D
> > -endif
> > -SAN_LDFLAGS  ?=3D $(SAN_CFLAGS)
> > -RELEASE              ?=3D
> > -OPT_FLAGS    ?=3D $(if $(RELEASE),-O2,-O0)
> > -
> > -LIBELF_CFLAGS        :=3D $(shell $(PKG_CONFIG) libelf --cflags 2>/dev=
/null)
> > -LIBELF_LIBS  :=3D $(shell $(PKG_CONFIG) libelf --libs 2>/dev/null || e=
cho -lelf)
> > -
> > -SKIP_DOCS    ?=3D
> > -SKIP_LLVM    ?=3D
> > -SKIP_LIBBFD  ?=3D
> > -SKIP_CRYPTO  ?=3D
>
> Since these SKIP_* are not used by the Makefile.runner,
> let's keep them in the Makefile.

Done, moved back (submake_extras and the VMLINUX_BTF block too - you
are right that the runner reads none of them).

>
> > -
> > -# When BPF_STRICT_BUILD is 1, any BPF object, skeleton, test object, o=
r
> > -# benchmark compilation failure is fatal. Set to 0 to tolerate failure=
s
> > -# and continue building the remaining tests.
> > -BPF_STRICT_BUILD ?=3D 1
> > -PERMISSIVE :=3D $(filter 0,$(BPF_STRICT_BUILD))
> > -
> > -ifeq ($(srctree),)
> > -srctree :=3D $(patsubst %/,%,$(dir $(CURDIR)))
> > -srctree :=3D $(patsubst %/,%,$(dir $(srctree)))
> > -srctree :=3D $(patsubst %/,%,$(dir $(srctree)))
> > -srctree :=3D $(patsubst %/,%,$(dir $(srctree)))
> > -endif
> >
> > -COMMON_CFLAGS =3D -g $(OPT_FLAGS) -rdynamic -std=3Dgnu11              =
           \
> > -       -Wall -Werror -fno-omit-frame-pointer                         \
> > -       -Wno-unused-but-set-variable                                  \
> > -       $(GENFLAGS) $(SAN_CFLAGS) $(LIBELF_CFLAGS)                    \
> > -       -I$(CURDIR) -I$(INCLUDE_DIR) -I$(GENDIR) -I$(LIBDIR)          \
> > -       -I$(TOOLSINCDIR) -I$(TOOLSARCHINCDIR) -I$(APIDIR) -I$(OUTPUT) \
> > -       -I$(CURDIR)/libarena/include
> > -LDFLAGS +=3D $(SAN_LDFLAGS)
> > -LDLIBS +=3D $(LIBELF_LIBS) -lz -lrt -lpthread
> > -
> > -PCAP_CFLAGS  :=3D $(shell $(PKG_CONFIG) --cflags libpcap 2>/dev/null &=
& echo "-DTRAFFIC_MONITOR=3D1")
> > -PCAP_LIBS    :=3D $(shell $(PKG_CONFIG) --libs libpcap 2>/dev/null)
> > -LDLIBS +=3D $(PCAP_LIBS)
> > -CFLAGS +=3D $(COMMON_CFLAGS) $(PCAP_CFLAGS)
> >
> >  # Some utility functions use LLVM libraries
> >  jit_disasm_helpers.c-CFLAGS =3D $(LLVM_CFLAGS)
> >
> > -ifneq ($(LLVM),)
> > -# Silence some warnings when compiled with clang
> > -CFLAGS +=3D -Wno-unused-command-line-argument
> > -endif
> >
> >  # Check whether bpf cpu=3Dv4 is supported or not by clang
> >  ifneq ($(shell $(CLANG) --target=3Dbpf -mcpu=3Dhelp 2>&1 | grep 'v4'),=
)
> >  CLANG_CPUV4 :=3D 1
> >  endif
> >
> > -# Check whether clang supports BPF address sanitizer (requires LLVM 22=
+)
> > -CLANG_HAS_ARENA_ASAN :=3D $(shell echo 'int x;' | \
> > -     $(CLANG) --target=3Dbpf -fsanitize=3Dkernel-address \
> > -     -mllvm -asan-shadow-addr-space=3D1 \
> > -     -x c -c - -o /dev/null 2>/dev/null && echo 1)
> >
> >  # Order correspond to 'make run_tests' order
> >  TEST_GEN_PROGS =3D test_verifier test_tag test_maps test_lru_map test_=
progs \
> > @@ -132,9 +67,8 @@ TEST_PROGS :=3D test_kmod.sh \
> >  TEST_PROGS_EXTENDED :=3D \
> >       ima_setup.sh verify_sig_setup.sh
> >
> > -TEST_KMODS :=3D bpf_testmod.ko bpf_test_no_cfi.ko bpf_test_modorder_x.=
ko \
> > +TEST_KMODS ?=3D bpf_testmod.ko bpf_test_no_cfi.ko bpf_test_modorder_x.=
ko \
>               ^^
> Is there a reason for this change?

Not anymore. It was a leftover from when the definition lived in
both files. Patch 2 no longer touches TEST_KMODS (or
TEST_KMOD_TARGETS, or the VMLINUX_BTF block).

>
> >       bpf_test_modorder_y.ko bpf_test_rqspinlock.ko
> > -TEST_KMOD_TARGETS =3D $(addprefix $(OUTPUT)/,$(TEST_KMODS))
> >
> >  # Compile but not part of 'make run_tests'
> >  TEST_GEN_PROGS_EXTENDED =3D \
> > @@ -150,9 +84,6 @@ TEST_GEN_PROGS_EXTENDED =3D \
> >
> >  TEST_GEN_FILES +=3D $(TEST_KMODS) liburandom_read.so urandom_read sign=
-file uprobe_multi
> >
> > -ifneq ($(V),1)
> > -submake_extras :=3D feature_display=3D0
> > -endif
>
> Makefile.runner does not include Makefile.features, so I don't think
> this should be moved.

Done, submake_extras is back in the Makefile.

>
> >
> >  # override lib.mk's default rules
> >  OVERRIDE_TARGETS :=3D 1
> > @@ -188,6 +119,8 @@ override OUTPUT :=3D $(patsubst %/,%,$(OUTPUT))
> >  endif
> >  endif
> >
> > +include Makefile.buildvars
> > +
> >  ifneq ($(SKIP_LLVM),1)
> >  ifeq ($(feature-llvm),1)
> >    LLVM_CFLAGS  +=3D -DHAVE_LLVM_SUPPORT
> > @@ -213,30 +146,6 @@ ifeq ($(feature-llvm),1)
> >  endif
> >  endif
> >
> > -SCRATCH_DIR :=3D $(OUTPUT)/tools
> > -BUILD_DIR :=3D $(SCRATCH_DIR)/build
> > -INCLUDE_DIR :=3D $(SCRATCH_DIR)/include
> > -BPFOBJ :=3D $(BUILD_DIR)/libbpf/libbpf.a
> > -ifneq ($(CROSS_COMPILE),)
> > -HOST_BUILD_DIR               :=3D $(BUILD_DIR)/host
> > -HOST_SCRATCH_DIR     :=3D $(OUTPUT)/host-tools
> > -HOST_INCLUDE_DIR     :=3D $(HOST_SCRATCH_DIR)/include
> > -else
> > -HOST_BUILD_DIR               :=3D $(BUILD_DIR)
> > -HOST_SCRATCH_DIR     :=3D $(SCRATCH_DIR)
> > -HOST_INCLUDE_DIR     :=3D $(INCLUDE_DIR)
> > -endif
> > -HOST_BPFOBJ :=3D $(HOST_BUILD_DIR)/libbpf/libbpf.a
> > -RESOLVE_BTFIDS :=3D $(HOST_BUILD_DIR)/resolve_btfids/resolve_btfids
> > -VMLINUX_BTF_PATHS ?=3D $(if $(O),$(O)/vmlinux)                        =
 \
> > -                  $(if $(KBUILD_OUTPUT),$(KBUILD_OUTPUT)/vmlinux)    \
> > -                  ../../../../vmlinux                                \
> > -                  /sys/kernel/btf/vmlinux                            \
> > -                  /boot/vmlinux-$(shell uname -r)
>
> General nit: definitions in this file do not always follow the same
> order the definitions had in the original Makefile, which makes it
> somewhat harder to review.

Reordered. Makefile.buildvars now keeps the original Makefile's
definition order throughout. The one deviation is called out in a
comment: CFLAGS is assembled by prepending COMMON_CFLAGS (the file is
included after lib.mk at the top level, where the original text ran
before it), which also required keeping CFLAGS recursively expanded
the way the original was.

>
> > -VMLINUX_BTF ?=3D $(abspath $(firstword $(wildcard $(VMLINUX_BTF_PATHS)=
)))
> > -ifeq ($(VMLINUX_BTF),)
> > -$(error Cannot find a vmlinux for VMLINUX_BTF at any of "$(VMLINUX_BTF=
_PATHS)")
> > -endif
> >
> >  # Define simple and short `make test_progs`, `make test_maps`, etc tar=
gets
> >  # to build individual tests.
> > @@ -314,15 +223,6 @@ $(TEST_KMOD_TARGETS): $(addprefix test_kmods/,$(TE=
ST_KMODS))
> >       $(Q)$(if $(PERMISSIVE),if [ -f test_kmods/$(@F) ]; then )cp test_=
kmods/$(@F) $@$(if $(PERMISSIVE),; fi)
> >
> >
> > -DEFAULT_BPFTOOL :=3D $(HOST_SCRATCH_DIR)/sbin/bpftool
> > -ifneq ($(CROSS_COMPILE),)
> > -CROSS_BPFTOOL :=3D $(SCRATCH_DIR)/sbin/bpftool
> > -TRUNNER_BPFTOOL :=3D $(CROSS_BPFTOOL)
> > -USE_BOOTSTRAP :=3D ""
> > -else
> > -TRUNNER_BPFTOOL :=3D $(DEFAULT_BPFTOOL)
> > -USE_BOOTSTRAP :=3D "bootstrap/"
> > -endif
> >
> >  $(TEST_GEN_PROGS) $(TEST_GEN_PROGS_EXTENDED): $(BPFOBJ)
> >
> > @@ -344,7 +244,6 @@ $(OUTPUT)/test_maps: $(TESTING_HELPERS)
> >  $(OUTPUT)/test_verifier: $(TESTING_HELPERS) $(CAP_HELPERS) $(UNPRIV_HE=
LPERS)
> >  $(OUTPUT)/xsk.o: $(BPFOBJ)
> >
> > -BPFTOOL ?=3D $(DEFAULT_BPFTOOL)
> >  $(DEFAULT_BPFTOOL): $(wildcard $(BPFTOOLDIR)/*.[ch] $(BPFTOOLDIR)/Make=
file)    \
> >                   $(HOST_BPFOBJ) | $(HOST_BUILD_DIR)/bpftool
> >       $(Q)$(MAKE) $(submake_extras)  -C $(BPFTOOLDIR)                  =
      \
> > @@ -437,45 +336,6 @@ $(RESOLVE_BTFIDS): $(HOST_BPFOBJ) | $(HOST_BUILD_D=
IR)/resolve_btfids     \
> >               HOSTPKG_CONFIG=3D'$(PKG_CONFIG)' \
> >               OUTPUT=3D$(HOST_BUILD_DIR)/resolve_btfids/ BPFOBJ=3D$(HOS=
T_BPFOBJ)
> >
> > -# Get Clang's default includes on this system, as opposed to those see=
n by
> > -# '--target=3Dbpf'. This fixes "missing" files on some architectures/d=
istros,
> > -# such as asm/byteorder.h, asm/socket.h, asm/sockios.h, sys/cdefs.h et=
c.
> > -#
> > -# Use '-idirafter': Don't interfere with include mechanics except wher=
e the
> > -# build would have failed anyways.
> > -define get_sys_includes
> > -$(shell $(1) $(2) -v -E - </dev/null 2>&1 \
> > -     | sed -n '/<...> search starts here:/,/End of search list./{ s| \=
(/.*\)|-idirafter \1|p }') \
> > -$(shell $(1) $(2) -dM -E - </dev/null | grep '__riscv_xlen ' | awk '{p=
rintf("-D__riscv_xlen=3D%d -D__BITS_PER_LONG=3D%d", $$3, $$3)}') \
> > -$(shell $(1) $(2) -dM -E - </dev/null | grep '__loongarch_grlen ' | aw=
k '{printf("-D__BITS_PER_LONG=3D%d", $$3)}') \
> > -$(shell $(1) $(2) -dM -E - </dev/null | grep -E 'MIPS(EL|EB)|_MIPS_SZ(=
PTR|LONG) |_MIPS_SIM |_ABI(O32|N32|64) ' | awk '{printf("-D%s=3D%s ", $$2, =
$$3)}')
> > -endef
> > -
> > -# Determine target endianness.
> > -IS_LITTLE_ENDIAN :=3D $(shell $(CC) -dM -E - </dev/null | \
> > -                     grep 'define __BYTE_ORDER__ __ORDER_LITTLE_ENDIAN=
__')
> > -MENDIAN:=3D$(if $(IS_LITTLE_ENDIAN),-mlittle-endian,-mbig-endian)
> > -BPF_TARGET_ENDIAN:=3D$(if $(IS_LITTLE_ENDIAN),--target=3Dbpfel,--targe=
t=3Dbpfeb)
> > -
> > -ifneq ($(CROSS_COMPILE),)
> > -CLANG_TARGET_ARCH =3D --target=3D$(notdir $(CROSS_COMPILE:%-=3D%))
> > -endif
> > -
> > -CLANG_SYS_INCLUDES =3D $(call get_sys_includes,$(CLANG),$(CLANG_TARGET=
_ARCH))
> > -BPF_CFLAGS =3D -g -Wall -Werror -D__TARGET_ARCH_$(SRCARCH) $(MENDIAN) =
 \
> > -          -I$(INCLUDE_DIR) -I$(CURDIR) -I$(APIDIR)                   \
> > -          -I$(CURDIR)/libarena/include                               \
> > -          -I$(abspath $(OUTPUT)/../usr/include)                      \
> > -          -std=3Dgnu11                                                =
 \
> > -          -fno-strict-aliasing                                       \
> > -          -Wno-microsoft-anon-tag                                    \
> > -          -fms-extensions                                            \
> > -          -Wno-compare-distinct-pointer-types                        \
> > -          -Wno-initializer-overrides                                 \
> > -          #
> > -# TODO: enable me -Wsign-compare
> > -
> > -CLANG_CFLAGS =3D $(CLANG_SYS_INCLUDES)
> >
> >  $(OUTPUT)/test_l4lb_noinline.o: BPF_CFLAGS +=3D -fno-inline
> >  $(OUTPUT)/test_xdp_noinline.o: BPF_CFLAGS +=3D -fno-inline
> > @@ -756,10 +616,6 @@ $(OUTPUT)/$(TRUNNER_BINARY): $(if $(filter test_pr=
ogs%,$1),$(if $(PERMISSIVE),$$
> >
> >  endef
> >
> > -VERIFY_SIG_SETUP :=3D $(CURDIR)/verify_sig_setup.sh
> > -VERIFY_SIG_HDR :=3D verification_cert.h
> > -VERIFICATION_CERT   :=3D $(BUILD_DIR)/signing_key.der
> > -PRIVATE_KEY :=3D $(BUILD_DIR)/signing_key.pem
> >
> >  $(VERIFICATION_CERT) $(PRIVATE_KEY): $(VERIFY_SIG_SETUP)
> >       $(Q)mkdir -p $(BUILD_DIR)
> > @@ -790,14 +646,11 @@ LIBARENA_BPF_DEPS :=3D $(wildcard libarena/Makefi=
le               \
> >                                libarena/selftests/*           \
> >                                libarena/*.bpf.o)
> >
> > -LIBARENA_SKEL :=3D libarena/libarena.skel.h
> >
> >  $(LIBARENA_SKEL): $(INCLUDE_DIR)/vmlinux.h $(BPFOBJ) $(LIBARENA_BPF_DE=
PS)
> >       +$(MAKE) -C libarena libarena.skel.h $(LIBARENA_MAKE_ARGS)
> >
> >  ifneq ($(CLANG_HAS_ARENA_ASAN),)
> > -LIBARENA_ASAN_SKEL :=3D libarena/libarena_asan.skel.h
> > -CFLAGS +=3D -DHAS_BPF_ARENA_ASAN
> >
> >  $(LIBARENA_ASAN_SKEL): $(INCLUDE_DIR)/vmlinux.h $(BPFOBJ) $(LIBARENA_B=
PF_DEPS)
> >       +$(MAKE) -C libarena libarena_asan.skel.h $(LIBARENA_MAKE_ARGS)
> > diff --git a/tools/testing/selftests/bpf/Makefile.buildvars b/tools/tes=
ting/selftests/bpf/Makefile.buildvars
> > new file mode 100644
> > index 000000000..7b468ddf8
> > --- /dev/null
> > +++ b/tools/testing/selftests/bpf/Makefile.buildvars
> > @@ -0,0 +1,191 @@
> > +# SPDX-License-Identifier: GPL-2.0
> > +#
> > +# Shared toolchain, path and flag definitions for the BPF selftests bu=
ild.
> > +# Included by both Makefile (the top level) and Makefile.runner (one
> > +# test-runner instance).
> > +#
> > +# Requirements at include time:
> > +#   - $(OUTPUT) is set to an absolute path
> > +#   - tools/build/Build.include, tools/scripts/Makefile.arch and
> > +#     tools/scripts/Makefile.include have been included (for SRCARCH e=
tc.)
>
> Nit: let's minimize these comments.

Trimmed to three lines.

>
> > +
> > +CXX ?=3D $(CROSS_COMPILE)g++
> > +PKG_CONFIG ?=3D $(CROSS_COMPILE)pkg-config
> > +TOOLSDIR :=3D $(abspath ../../..)
> > +LIBDIR :=3D $(TOOLSDIR)/lib
> > +BPFDIR :=3D $(LIBDIR)/bpf
> > +TOOLSINCDIR :=3D $(TOOLSDIR)/include
> > +TOOLSARCHINCDIR :=3D $(TOOLSDIR)/arch/$(SRCARCH)/include
> > +BPFTOOLDIR :=3D $(TOOLSDIR)/bpf/bpftool
> > +APIDIR :=3D $(TOOLSINCDIR)/uapi
> > +ifneq ($(O),)
> > +GENDIR :=3D $(O)/include/generated
> > +else
> > +GENDIR :=3D $(abspath ../../../../include/generated)
> > +endif
> > +GENHDR :=3D $(GENDIR)/autoconf.h
> > +
> > +ifneq ($(wildcard $(GENHDR)),)
> > +  GENFLAGS :=3D -DHAVE_GENHDR
> > +endif
> > +
> > +ifeq ($(srctree),)
> > +srctree :=3D $(abspath ../../../..)
> > +endif
> > +
> > +ifdef ASAN
> > +SAN_CFLAGS   ?=3D -fsanitize=3Daddress -fno-omit-frame-pointer
> > +else
> > +SAN_CFLAGS   ?=3D
> > +endif
> > +SAN_LDFLAGS  ?=3D $(SAN_CFLAGS)
> > +RELEASE              ?=3D
> > +OPT_FLAGS    ?=3D $(if $(RELEASE),-O2,-O0)
> > +
> > +LIBELF_CFLAGS        :=3D $(shell $(PKG_CONFIG) libelf --cflags 2>/dev=
/null)
> > +LIBELF_LIBS  :=3D $(shell $(PKG_CONFIG) libelf --libs 2>/dev/null || e=
cho -lelf)
> > +
> > +SKIP_DOCS    ?=3D
> > +SKIP_LLVM    ?=3D
> > +SKIP_LIBBFD  ?=3D
> > +SKIP_CRYPTO  ?=3D
> > +
> > +# When BPF_STRICT_BUILD is 1, any BPF object, skeleton, test object, o=
r
> > +# benchmark compilation failure is fatal. Set to 0 to tolerate failure=
s
> > +# and continue building the remaining tests.
> > +BPF_STRICT_BUILD ?=3D 1
> > +PERMISSIVE :=3D $(filter 0,$(BPF_STRICT_BUILD))
> > +
> > +# BPF_GCC and TEST_KMODS are defined once in the main Makefile (they
> > +# are needed there before lib.mk) and arrive here via the environment;
> > +# TEST_KMODS=3D on the command line disables the modules.
> > +TEST_KMOD_TARGETS =3D $(addprefix $(OUTPUT)/,$(TEST_KMODS))
>
> In the next patch, let's inline TEST_KMOD_TARGETS in EXTRA_FILES and
> drop this definition alongside the comment. Might as well keep
> TEST_KMOD_TARGETS in the main Makefile for patch #2, to minimize the chur=
n.

Done: patch 2 leaves TEST_KMOD_TARGETS in the Makefile,
patch 3 inlines the addprefix at its single use in EXTRA_FILES.

>
> > +
> > +# Output-tree layout. Defined before COMMON_CFLAGS on purpose: CFLAGS
> > +# below is expanded immediately and references $(INCLUDE_DIR).
> > +SCRATCH_DIR :=3D $(OUTPUT)/tools
> > +BUILD_DIR :=3D $(SCRATCH_DIR)/build
> > +INCLUDE_DIR :=3D $(SCRATCH_DIR)/include
> > +BPFOBJ :=3D $(BUILD_DIR)/libbpf/libbpf.a
> > +ifneq ($(CROSS_COMPILE),)
> > +HOST_BUILD_DIR               :=3D $(BUILD_DIR)/host
> > +HOST_SCRATCH_DIR     :=3D $(OUTPUT)/host-tools
> > +HOST_INCLUDE_DIR     :=3D $(HOST_SCRATCH_DIR)/include
> > +else
> > +HOST_BUILD_DIR               :=3D $(BUILD_DIR)
> > +HOST_SCRATCH_DIR     :=3D $(SCRATCH_DIR)
> > +HOST_INCLUDE_DIR     :=3D $(INCLUDE_DIR)
> > +endif
> > +HOST_BPFOBJ :=3D $(HOST_BUILD_DIR)/libbpf/libbpf.a
> > +RESOLVE_BTFIDS :=3D $(HOST_BUILD_DIR)/resolve_btfids/resolve_btfids
> > +
> > +DEFAULT_BPFTOOL :=3D $(HOST_SCRATCH_DIR)/sbin/bpftool
> > +ifneq ($(CROSS_COMPILE),)
> > +CROSS_BPFTOOL :=3D $(SCRATCH_DIR)/sbin/bpftool
> > +TRUNNER_BPFTOOL :=3D $(CROSS_BPFTOOL)
> > +USE_BOOTSTRAP :=3D
> > +else
> > +TRUNNER_BPFTOOL :=3D $(DEFAULT_BPFTOOL)
> > +USE_BOOTSTRAP :=3D bootstrap/
> > +endif
> > +BPFTOOL ?=3D $(DEFAULT_BPFTOOL)
> > +
> > +COMMON_CFLAGS =3D -g $(OPT_FLAGS) -rdynamic -std=3Dgnu11              =
   \
> > +       -Wall -Werror -fno-omit-frame-pointer                         \
> > +       -Wno-unused-but-set-variable                                  \
> > +       $(GENFLAGS) $(SAN_CFLAGS) $(LIBELF_CFLAGS)                    \
> > +       -I$(CURDIR) -I$(INCLUDE_DIR) -I$(GENDIR) -I$(LIBDIR)          \
> > +       -I$(TOOLSINCDIR) -I$(TOOLSARCHINCDIR) -I$(APIDIR) -I$(OUTPUT) \
> > +       -I$(CURDIR)/libarena/include
> > +LDFLAGS +=3D $(SAN_LDFLAGS)
> > +LDLIBS +=3D $(LIBELF_LIBS) -lz -lrt -lpthread
> > +
> > +PCAP_CFLAGS  :=3D $(shell $(PKG_CONFIG) --cflags libpcap 2>/dev/null &=
& echo "-DTRAFFIC_MONITOR=3D1")
> > +PCAP_LIBS    :=3D $(shell $(PKG_CONFIG) --libs libpcap 2>/dev/null)
> > +LDLIBS +=3D $(PCAP_LIBS)
> > +# Prepend rather than append: the include-search order must stay
> > +# "$(COMMON_CFLAGS) first, lib.mk additions after" regardless of wheth=
er
> > +# lib.mk was included before this file (top level) or not at all (runn=
er).
> > +CFLAGS :=3D $(COMMON_CFLAGS) $(PCAP_CFLAGS) $(CFLAGS)
> > +
> > +ifneq ($(LLVM),)
> > +# Silence some warnings when compiled with clang
> > +CFLAGS +=3D -Wno-unused-command-line-argument
> > +endif
> > +
> > +# Check whether clang supports BPF address sanitizer (requires LLVM 22=
+)
> > +CLANG_HAS_ARENA_ASAN :=3D $(shell echo 'int x;' | \
> > +     $(CLANG) --target=3Dbpf -fsanitize=3Dkernel-address \
> > +     -mllvm -asan-shadow-addr-space=3D1 \
> > +     -x c -c - -o /dev/null 2>/dev/null && echo 1)
> > +ifneq ($(CLANG_HAS_ARENA_ASAN),)
> > +CFLAGS +=3D -DHAS_BPF_ARENA_ASAN
> > +endif
> > +
> > +VMLINUX_BTF_PATHS ?=3D $(if $(O),$(O)/vmlinux)                        =
 \
> > +                  $(if $(KBUILD_OUTPUT),$(KBUILD_OUTPUT)/vmlinux)    \
> > +                  ../../../../vmlinux                                \
> > +                  /sys/kernel/btf/vmlinux                            \
> > +                  /boot/vmlinux-$(shell uname -r)
> > +VMLINUX_BTF ?=3D $(abspath $(firstword $(wildcard $(VMLINUX_BTF_PATHS)=
)))
> > +ifeq ($(VMLINUX_BTF),)
> > +$(error Cannot find a vmlinux for VMLINUX_BTF at any of "$(VMLINUX_BTF=
_PATHS)")
> > +endif
>
> VMLINUX_BTF{,_PATHS} don't seem to be used by Makefile.runner.

Moved back to the Makefile.

>
> > +# Get Clang's default includes on this system, as opposed to those see=
n by
> > +# '--target=3Dbpf'. This fixes "missing" files on some architectures/d=
istros,
> > +# such as asm/byteorder.h, asm/socket.h, asm/sockios.h, sys/cdefs.h et=
c.
> > +#
> > +# Use '-idirafter': Don't interfere with include mechanics except wher=
e the
> > +# build would have failed anyways.
> > +define get_sys_includes
> > +$(shell $(1) $(2) -v -E - </dev/null 2>&1 \
> > +     | sed -n '/<...> search starts here:/,/End of search list./{ s| \=
(/.*\)|-idirafter \1|p }') \
> > +$(shell $(1) $(2) -dM -E - </dev/null | grep '__riscv_xlen ' | awk '{p=
rintf("-D__riscv_xlen=3D%d -D__BITS_PER_LONG=3D%d", $$3, $$3)}') \
> > +$(shell $(1) $(2) -dM -E - </dev/null | grep '__loongarch_grlen ' | aw=
k '{printf("-D__BITS_PER_LONG=3D%d", $$3)}') \
> > +$(shell $(1) $(2) -dM -E - </dev/null | grep -E 'MIPS(EL|EB)|_MIPS_SZ(=
PTR|LONG) |_MIPS_SIM |_ABI(O32|N32|64) ' | awk '{printf("-D%s=3D%s ", $$2, =
$$3)}')
> > +endef
> > +
> > +# Determine target endianness.
> > +IS_LITTLE_ENDIAN :=3D $(shell $(CC) -dM -E - </dev/null | \
> > +                     grep 'define __BYTE_ORDER__ __ORDER_LITTLE_ENDIAN=
__')
> > +MENDIAN :=3D $(if $(IS_LITTLE_ENDIAN),-mlittle-endian,-mbig-endian)
> > +BPF_TARGET_ENDIAN :=3D $(if $(IS_LITTLE_ENDIAN),--target=3Dbpfel,--tar=
get=3Dbpfeb)
> > +
> > +ifneq ($(CROSS_COMPILE),)
> > +CLANG_TARGET_ARCH =3D --target=3D$(notdir $(CROSS_COMPILE:%-=3D%))
> > +endif
> > +
> > +CLANG_SYS_INCLUDES :=3D $(call get_sys_includes,$(CLANG),$(CLANG_TARGE=
T_ARCH))
> > +BPF_CFLAGS =3D -g -Wall -Werror -D__TARGET_ARCH_$(SRCARCH) $(MENDIAN) =
 \
> > +          -I$(INCLUDE_DIR) -I$(CURDIR) -I$(APIDIR)                   \
> > +          -I$(CURDIR)/libarena/include                               \
> > +          -I$(abspath $(OUTPUT)/../usr/include)                      \
> > +          -std=3Dgnu11                                                =
 \
> > +          -fno-strict-aliasing                                       \
> > +          -Wno-microsoft-anon-tag                                    \
> > +          -fms-extensions                                            \
> > +          -Wno-compare-distinct-pointer-types                        \
> > +          -Wno-initializer-overrides                                 \
> > +          #
> > +# TODO: enable me -Wsign-compare
> > +
> > +CLANG_CFLAGS =3D $(CLANG_SYS_INCLUDES)
> > +
> > +# Signing key/cert shared by the signed light skeletons and test_progs=
.
> > +VERIFY_SIG_SETUP :=3D $(CURDIR)/verify_sig_setup.sh
> > +VERIFY_SIG_HDR :=3D verification_cert.h
> > +VERIFICATION_CERT :=3D $(BUILD_DIR)/signing_key.der
> > +PRIVATE_KEY :=3D $(BUILD_DIR)/signing_key.pem
> > +
> > +# libarena skeletons, built by the libarena/ sub-make (driven by the t=
op
> > +# level Makefile); test_progs and its flavors depend on the headers.
> > +LIBARENA_SKEL :=3D libarena/libarena.skel.h
> > +ifneq ($(CLANG_HAS_ARENA_ASAN),)
> > +LIBARENA_ASAN_SKEL :=3D libarena/libarena_asan.skel.h
> > +endif
> > +
> > +ifneq ($(V),1)
> > +submake_extras :=3D feature_display=3D0
> > +endif
