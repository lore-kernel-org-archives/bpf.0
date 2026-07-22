Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 883F830E0C0
	for <bpf@vger.kernel.org>; Wed, 22 Jul 2026 23:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784761974; cv=none; b=QygjEYzOUOiE2yOXVkmKarcUYYqOUOamUNqIoVopHTzIGYSQ8ZDUrMTW3vB0422PG9qD6jnSaar/VrhNw5IMQQXJu88XGF243qqVJbeTB6fR8pxB1CclWTJEsQifBAbuqIBC70/h/noDvnAo0nf7vm6H8oOna9srRDPYal2hyac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784761974; c=relaxed/simple;
	bh=yIr/G/nZBveit2TA1EX/dX5hoXK7wTSAkgqg081dB1o=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PiTz/qBA98Rratlys1gbSNGAbEj/O8vORhA1ogIEraOp4pAXVuvPbzIhZG6lglDe3A1gWAYxNpj2EBKPFxBGdwxAVCu2aOMyWfS9vwLbs1PPEXpE62MUB4c0mBN4aBwOPWPi0Rm/D4ju9i7Dlr1Pc9s0qydex8cOhD1B/WHhusw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IRha5TBZ; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IRha5TBZ"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2cca0c5799eso536885ad.0
        for <bpf@vger.kernel.org>; Wed, 22 Jul 2026 16:12:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784761972; x=1785366772; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=O6APm+gAi5Dg8syRfKyCs0skoOuqLVgVFk+wEWz0KiM=;
        b=IRha5TBZFV2HUhLJgdqfnMbh5JRO9/6FxZZa3keJ/b6FzQWOc+LI68MpK3NonXLgzx
         DQihTabKsheGWcMktHe/V588Y5DDjlAZNv6SdQNgi2LmxQyLq6ISPWv8PZt2Nhg8k8u0
         qv4kzjYg+8AqQxxRmq0Jst1Ks33pC9GLLfubcRKPORfJQHdAZNu55+Qwe0hRGspCjDZX
         qDawUrY1wtGVP2mc3B2nXOUr7biYhm7hcyTLmpG/Lm11TUS7/YQUAMOFWTh/NBCoLV0j
         vrUeBr5yOXGrhCLOnztL89bc8XDfA6i2HbYVtcYnVpCBQutqAJ2B3Vb1O2uFP6ahkIKc
         H1KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784761972; x=1785366772;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=O6APm+gAi5Dg8syRfKyCs0skoOuqLVgVFk+wEWz0KiM=;
        b=UGJe8IS0gY0BmsU6inbTVgK1817PkMxy9L+S4fYN1z+4pQP3YYBa2OzoryqQsqaRt+
         HQNa2kksktl2RqVSpAooR2p5zm2uybpd2UAkGFCNLJ1AoQpt5GbN8qHPhRuB3LQgehtg
         UryogxdsfrQemp23crlSNI6oijQ+xfUoQJUR4OoW9jYiMCuNPun9ILSmd+iqWfUw55rm
         zAXaJWBg8ktciK2vOiwOR1D3GZcMyrSzTe6KvFtPrMYih/VbCICUCBG6hxIyHaaEQU87
         kv+lkQjV02cDfzek5UaFDZpMicrG7GS8HQk3poxDuwXQZKRo0EIj1Zt5BRAefwGOzNX5
         C4TA==
X-Forwarded-Encrypted: i=1; AHgh+RrTZZJts+9+uVPj7f8/b8JOM8dfEiAYzEYcdt72I5oDLe9Px5TClgBpmdjvscqoTYoN2m0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNCiz/fjCP8aQcwYg0dF2MjiXPB6tMi6ub+hudKtmv2sT8pmt7
	i9dBHg/utvAsxC1QshvmBau34unltUMoakGCpNtgpbS6v/qsSa9yk/au
X-Gm-Gg: AR+sD10XI9wsqIB2AfkZx79T50UfiKMavO10IWLp2aG0yNkFllXyyzWsPsSxugu0MpM
	IesqVcoBJ7/HpkFTQ5j8Sc41TMNh1pUrg3c7+MoAwnV2rC/J6A8gB+7P74yudAwlDbPnvUNWsoe
	zTAPJBFC1BeErSeMF+woXb8ltpi4rgMl7M/NgxpgiNusNdZg8zCh7dsBjaSFxVMK+vjagg9yp8t
	3/23p6W5/IyQbLkxZrCip3Mn1GeiDInJM++rkt0U+IjB5Pg8I2/nREAo5wxy5vKKBtN036dDag9
	OpXGtPNFNh0oa8qewoRZ2HS3Wh6jHV6RUwjctI2B9E+oaEn4xfdK+ZVBJYZbrhWLBxkBMMDlnaw
	uPkN3ULWY5vNrLU4O5bP3n8Sm9U5zfv4b1KYsBt7CqA4Lu3pyddAgQgwih8AgVHlkKf8bX8gW0w
	D+Crj40k2bosLm5RG6GCuZuwkrYamMpSywFQDgTyYImsRAxAx7coDeD88zy3psZJnGnhAIrw==
X-Received: by 2002:a05:6a21:4c0e:b0:3c3:fb32:a004 with SMTP id adf61e73a8af0-3c44b04b17bmr534896637.34.1784761971778;
        Wed, 22 Jul 2026 16:12:51 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:d806:89cb:d651:6dc8? ([2620:10d:c090:500::1:d474])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3147dc1b99esm13003700eec.3.2026.07.22.16.12.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 16:12:50 -0700 (PDT)
Message-ID: <ffaa53ae46ded031e578996ce6f69d4a19fead29.camel@gmail.com>
Subject: Re: [RFC PATCH bpf-next v3 2/3] selftests/bpf: move shared build
 definitions into Makefile.buildvars
From: Eduard Zingerman <eddyz87@gmail.com>
To: Mykola Lysenko <nickolay.lysenko@gmail.com>, bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, 	song@kernel.org, yonghong.song@linux.dev,
 jolsa@kernel.org, memxor@gmail.com
Date: Wed, 22 Jul 2026 16:12:49 -0700
In-Reply-To: <20260722040830.387979-3-nickolay.lysenko@gmail.com>
References: <20260722040830.387979-1-nickolay.lysenko@gmail.com>
	 <20260722040830.387979-3-nickolay.lysenko@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (3.60.1-1.fc44) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2026-07-21 at 21:08 -0700, Mykola Lysenko wrote:

...

>  tools/testing/selftests/bpf/Makefile          | 169 +---------------
>  .../testing/selftests/bpf/Makefile.buildvars  | 191 ++++++++++++++++++
>  2 files changed, 202 insertions(+), 158 deletions(-)
>  create mode 100644 tools/testing/selftests/bpf/Makefile.buildvars
>=20
> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftes=
ts/bpf/Makefile
> index 09e5be201..ce589f102 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile
> @@ -3,93 +3,28 @@ include ../../../build/Build.include
>  include ../../../scripts/Makefile.arch
>  include ../../../scripts/Makefile.include
> =20
> -CXX ?=3D $(CROSS_COMPILE)g++
> -OBJCOPY ?=3D $(CROSS_COMPILE)objcopy
> -
> -CURDIR :=3D $(abspath .)
> -TOOLSDIR :=3D $(abspath ../../..)
> -LIBDIR :=3D $(TOOLSDIR)/lib
> -BPFDIR :=3D $(LIBDIR)/bpf
> -TOOLSINCDIR :=3D $(TOOLSDIR)/include
> -TOOLSARCHINCDIR :=3D $(TOOLSDIR)/arch/$(SRCARCH)/include
> -BPFTOOLDIR :=3D $(TOOLSDIR)/bpf/bpftool
> -APIDIR :=3D $(TOOLSINCDIR)/uapi
> -ifneq ($(O),)
> -GENDIR :=3D $(O)/include/generated
> -else
> -GENDIR :=3D $(abspath ../../../../include/generated)
> -endif
> -GENHDR :=3D $(GENDIR)/autoconf.h
> -PKG_CONFIG ?=3D $(CROSS_COMPILE)pkg-config
> =20
> -ifneq ($(wildcard $(GENHDR)),)
> -  GENFLAGS :=3D -DHAVE_GENHDR
> +# BPF_GCC and TEST_KMODS are needed before lib.mk is included (they gate
> +# the flavor list and TEST_GEN_FILES), while Makefile.buildvars can only
> +# be included after it, so they are defined here - once - and exported
> +# for the runner sub-makes, whose Makefile.buildvars include picks them
> +# up from the environment.
> +ifeq ($(origin BPF_GCC),undefined)
> +BPF_GCC :=3D $(shell command -v bpf-gcc;)
>  endif
> +export BPF_GCC TEST_KMODS
> =20
> -BPF_GCC		?=3D $(shell command -v bpf-gcc;)
> -ifdef ASAN
> -SAN_CFLAGS 	?=3D -fsanitize=3Daddress -fno-omit-frame-pointer
> -else
> -SAN_CFLAGS	?=3D
> -endif
> -SAN_LDFLAGS	?=3D $(SAN_CFLAGS)
> -RELEASE		?=3D
> -OPT_FLAGS	?=3D $(if $(RELEASE),-O2,-O0)
> -
> -LIBELF_CFLAGS	:=3D $(shell $(PKG_CONFIG) libelf --cflags 2>/dev/null)
> -LIBELF_LIBS	:=3D $(shell $(PKG_CONFIG) libelf --libs 2>/dev/null || echo=
 -lelf)
> -
> -SKIP_DOCS	?=3D
> -SKIP_LLVM	?=3D
> -SKIP_LIBBFD	?=3D
> -SKIP_CRYPTO	?=3D

Since these SKIP_* are not used by the Makefile.runner,
let's keep them in the Makefile.

> -
> -# When BPF_STRICT_BUILD is 1, any BPF object, skeleton, test object, or
> -# benchmark compilation failure is fatal. Set to 0 to tolerate failures
> -# and continue building the remaining tests.
> -BPF_STRICT_BUILD ?=3D 1
> -PERMISSIVE :=3D $(filter 0,$(BPF_STRICT_BUILD))
> -
> -ifeq ($(srctree),)
> -srctree :=3D $(patsubst %/,%,$(dir $(CURDIR)))
> -srctree :=3D $(patsubst %/,%,$(dir $(srctree)))
> -srctree :=3D $(patsubst %/,%,$(dir $(srctree)))
> -srctree :=3D $(patsubst %/,%,$(dir $(srctree)))
> -endif
> =20
> -COMMON_CFLAGS =3D -g $(OPT_FLAGS) -rdynamic -std=3Dgnu11				\
> -	  -Wall -Werror -fno-omit-frame-pointer				\
> -	  -Wno-unused-but-set-variable					\
> -	  $(GENFLAGS) $(SAN_CFLAGS) $(LIBELF_CFLAGS)			\
> -	  -I$(CURDIR) -I$(INCLUDE_DIR) -I$(GENDIR) -I$(LIBDIR)		\
> -	  -I$(TOOLSINCDIR) -I$(TOOLSARCHINCDIR) -I$(APIDIR) -I$(OUTPUT)	\
> -	  -I$(CURDIR)/libarena/include
> -LDFLAGS +=3D $(SAN_LDFLAGS)
> -LDLIBS +=3D $(LIBELF_LIBS) -lz -lrt -lpthread
> -
> -PCAP_CFLAGS	:=3D $(shell $(PKG_CONFIG) --cflags libpcap 2>/dev/null && e=
cho "-DTRAFFIC_MONITOR=3D1")
> -PCAP_LIBS	:=3D $(shell $(PKG_CONFIG) --libs libpcap 2>/dev/null)
> -LDLIBS +=3D $(PCAP_LIBS)
> -CFLAGS +=3D $(COMMON_CFLAGS) $(PCAP_CFLAGS)
> =20
>  # Some utility functions use LLVM libraries
>  jit_disasm_helpers.c-CFLAGS =3D $(LLVM_CFLAGS)
> =20
> -ifneq ($(LLVM),)
> -# Silence some warnings when compiled with clang
> -CFLAGS +=3D -Wno-unused-command-line-argument
> -endif
> =20
>  # Check whether bpf cpu=3Dv4 is supported or not by clang
>  ifneq ($(shell $(CLANG) --target=3Dbpf -mcpu=3Dhelp 2>&1 | grep 'v4'),)
>  CLANG_CPUV4 :=3D 1
>  endif
> =20
> -# Check whether clang supports BPF address sanitizer (requires LLVM 22+)
> -CLANG_HAS_ARENA_ASAN :=3D $(shell echo 'int x;' | \
> -	$(CLANG) --target=3Dbpf -fsanitize=3Dkernel-address \
> -	-mllvm -asan-shadow-addr-space=3D1 \
> -	-x c -c - -o /dev/null 2>/dev/null && echo 1)
> =20
>  # Order correspond to 'make run_tests' order
>  TEST_GEN_PROGS =3D test_verifier test_tag test_maps test_lru_map test_pr=
ogs \
> @@ -132,9 +67,8 @@ TEST_PROGS :=3D test_kmod.sh \
>  TEST_PROGS_EXTENDED :=3D \
>  	ima_setup.sh verify_sig_setup.sh
> =20
> -TEST_KMODS :=3D bpf_testmod.ko bpf_test_no_cfi.ko bpf_test_modorder_x.ko=
 \
> +TEST_KMODS ?=3D bpf_testmod.ko bpf_test_no_cfi.ko bpf_test_modorder_x.ko=
 \
              ^^
Is there a reason for this change?

>  	bpf_test_modorder_y.ko bpf_test_rqspinlock.ko
> -TEST_KMOD_TARGETS =3D $(addprefix $(OUTPUT)/,$(TEST_KMODS))
> =20
>  # Compile but not part of 'make run_tests'
>  TEST_GEN_PROGS_EXTENDED =3D \
> @@ -150,9 +84,6 @@ TEST_GEN_PROGS_EXTENDED =3D \
> =20
>  TEST_GEN_FILES +=3D $(TEST_KMODS) liburandom_read.so urandom_read sign-f=
ile uprobe_multi
> =20
> -ifneq ($(V),1)
> -submake_extras :=3D feature_display=3D0
> -endif

Makefile.runner does not include Makefile.features, so I don't think
this should be moved.

> =20
>  # override lib.mk's default rules
>  OVERRIDE_TARGETS :=3D 1
> @@ -188,6 +119,8 @@ override OUTPUT :=3D $(patsubst %/,%,$(OUTPUT))
>  endif
>  endif
> =20
> +include Makefile.buildvars
> +
>  ifneq ($(SKIP_LLVM),1)
>  ifeq ($(feature-llvm),1)
>    LLVM_CFLAGS  +=3D -DHAVE_LLVM_SUPPORT
> @@ -213,30 +146,6 @@ ifeq ($(feature-llvm),1)
>  endif
>  endif
> =20
> -SCRATCH_DIR :=3D $(OUTPUT)/tools
> -BUILD_DIR :=3D $(SCRATCH_DIR)/build
> -INCLUDE_DIR :=3D $(SCRATCH_DIR)/include
> -BPFOBJ :=3D $(BUILD_DIR)/libbpf/libbpf.a
> -ifneq ($(CROSS_COMPILE),)
> -HOST_BUILD_DIR		:=3D $(BUILD_DIR)/host
> -HOST_SCRATCH_DIR	:=3D $(OUTPUT)/host-tools
> -HOST_INCLUDE_DIR	:=3D $(HOST_SCRATCH_DIR)/include
> -else
> -HOST_BUILD_DIR		:=3D $(BUILD_DIR)
> -HOST_SCRATCH_DIR	:=3D $(SCRATCH_DIR)
> -HOST_INCLUDE_DIR	:=3D $(INCLUDE_DIR)
> -endif
> -HOST_BPFOBJ :=3D $(HOST_BUILD_DIR)/libbpf/libbpf.a
> -RESOLVE_BTFIDS :=3D $(HOST_BUILD_DIR)/resolve_btfids/resolve_btfids
> -VMLINUX_BTF_PATHS ?=3D $(if $(O),$(O)/vmlinux)				\
> -		     $(if $(KBUILD_OUTPUT),$(KBUILD_OUTPUT)/vmlinux)	\
> -		     ../../../../vmlinux				\
> -		     /sys/kernel/btf/vmlinux				\
> -		     /boot/vmlinux-$(shell uname -r)

General nit: definitions in this file do not always follow the same
order the definitions had in the original Makefile, which makes it
somewhat harder to review.

> -VMLINUX_BTF ?=3D $(abspath $(firstword $(wildcard $(VMLINUX_BTF_PATHS)))=
)
> -ifeq ($(VMLINUX_BTF),)
> -$(error Cannot find a vmlinux for VMLINUX_BTF at any of "$(VMLINUX_BTF_P=
ATHS)")
> -endif
> =20
>  # Define simple and short `make test_progs`, `make test_maps`, etc targe=
ts
>  # to build individual tests.
> @@ -314,15 +223,6 @@ $(TEST_KMOD_TARGETS): $(addprefix test_kmods/,$(TEST=
_KMODS))
>  	$(Q)$(if $(PERMISSIVE),if [ -f test_kmods/$(@F) ]; then )cp test_kmods/=
$(@F) $@$(if $(PERMISSIVE),; fi)
> =20
> =20
> -DEFAULT_BPFTOOL :=3D $(HOST_SCRATCH_DIR)/sbin/bpftool
> -ifneq ($(CROSS_COMPILE),)
> -CROSS_BPFTOOL :=3D $(SCRATCH_DIR)/sbin/bpftool
> -TRUNNER_BPFTOOL :=3D $(CROSS_BPFTOOL)
> -USE_BOOTSTRAP :=3D ""
> -else
> -TRUNNER_BPFTOOL :=3D $(DEFAULT_BPFTOOL)
> -USE_BOOTSTRAP :=3D "bootstrap/"
> -endif
> =20
>  $(TEST_GEN_PROGS) $(TEST_GEN_PROGS_EXTENDED): $(BPFOBJ)
> =20
> @@ -344,7 +244,6 @@ $(OUTPUT)/test_maps: $(TESTING_HELPERS)
>  $(OUTPUT)/test_verifier: $(TESTING_HELPERS) $(CAP_HELPERS) $(UNPRIV_HELP=
ERS)
>  $(OUTPUT)/xsk.o: $(BPFOBJ)
> =20
> -BPFTOOL ?=3D $(DEFAULT_BPFTOOL)
>  $(DEFAULT_BPFTOOL): $(wildcard $(BPFTOOLDIR)/*.[ch] $(BPFTOOLDIR)/Makefi=
le)    \
>  		    $(HOST_BPFOBJ) | $(HOST_BUILD_DIR)/bpftool
>  	$(Q)$(MAKE) $(submake_extras)  -C $(BPFTOOLDIR)			       \
> @@ -437,45 +336,6 @@ $(RESOLVE_BTFIDS): $(HOST_BPFOBJ) | $(HOST_BUILD_DIR=
)/resolve_btfids	\
>  		HOSTPKG_CONFIG=3D'$(PKG_CONFIG)' \
>  		OUTPUT=3D$(HOST_BUILD_DIR)/resolve_btfids/ BPFOBJ=3D$(HOST_BPFOBJ)
> =20
> -# Get Clang's default includes on this system, as opposed to those seen =
by
> -# '--target=3Dbpf'. This fixes "missing" files on some architectures/dis=
tros,
> -# such as asm/byteorder.h, asm/socket.h, asm/sockios.h, sys/cdefs.h etc.
> -#
> -# Use '-idirafter': Don't interfere with include mechanics except where =
the
> -# build would have failed anyways.
> -define get_sys_includes
> -$(shell $(1) $(2) -v -E - </dev/null 2>&1 \
> -	| sed -n '/<...> search starts here:/,/End of search list./{ s| \(/.*\)=
|-idirafter \1|p }') \
> -$(shell $(1) $(2) -dM -E - </dev/null | grep '__riscv_xlen ' | awk '{pri=
ntf("-D__riscv_xlen=3D%d -D__BITS_PER_LONG=3D%d", $$3, $$3)}') \
> -$(shell $(1) $(2) -dM -E - </dev/null | grep '__loongarch_grlen ' | awk =
'{printf("-D__BITS_PER_LONG=3D%d", $$3)}') \
> -$(shell $(1) $(2) -dM -E - </dev/null | grep -E 'MIPS(EL|EB)|_MIPS_SZ(PT=
R|LONG) |_MIPS_SIM |_ABI(O32|N32|64) ' | awk '{printf("-D%s=3D%s ", $$2, $$=
3)}')
> -endef
> -
> -# Determine target endianness.
> -IS_LITTLE_ENDIAN :=3D $(shell $(CC) -dM -E - </dev/null | \
> -			grep 'define __BYTE_ORDER__ __ORDER_LITTLE_ENDIAN__')
> -MENDIAN:=3D$(if $(IS_LITTLE_ENDIAN),-mlittle-endian,-mbig-endian)
> -BPF_TARGET_ENDIAN:=3D$(if $(IS_LITTLE_ENDIAN),--target=3Dbpfel,--target=
=3Dbpfeb)
> -
> -ifneq ($(CROSS_COMPILE),)
> -CLANG_TARGET_ARCH =3D --target=3D$(notdir $(CROSS_COMPILE:%-=3D%))
> -endif
> -
> -CLANG_SYS_INCLUDES =3D $(call get_sys_includes,$(CLANG),$(CLANG_TARGET_A=
RCH))
> -BPF_CFLAGS =3D -g -Wall -Werror -D__TARGET_ARCH_$(SRCARCH) $(MENDIAN)	\
> -	     -I$(INCLUDE_DIR) -I$(CURDIR) -I$(APIDIR)			\
> -	     -I$(CURDIR)/libarena/include				\
> -	     -I$(abspath $(OUTPUT)/../usr/include)			\
> -	     -std=3Dgnu11		 					\
> -	     -fno-strict-aliasing 					\
> -	     -Wno-microsoft-anon-tag					\
> -	     -fms-extensions						\
> -	     -Wno-compare-distinct-pointer-types			\
> -	     -Wno-initializer-overrides					\
> -	     #
> -# TODO: enable me -Wsign-compare
> -
> -CLANG_CFLAGS =3D $(CLANG_SYS_INCLUDES)
> =20
>  $(OUTPUT)/test_l4lb_noinline.o: BPF_CFLAGS +=3D -fno-inline
>  $(OUTPUT)/test_xdp_noinline.o: BPF_CFLAGS +=3D -fno-inline
> @@ -756,10 +616,6 @@ $(OUTPUT)/$(TRUNNER_BINARY): $(if $(filter test_prog=
s%,$1),$(if $(PERMISSIVE),$$
> =20
>  endef
> =20
> -VERIFY_SIG_SETUP :=3D $(CURDIR)/verify_sig_setup.sh
> -VERIFY_SIG_HDR :=3D verification_cert.h
> -VERIFICATION_CERT   :=3D $(BUILD_DIR)/signing_key.der
> -PRIVATE_KEY :=3D $(BUILD_DIR)/signing_key.pem
> =20
>  $(VERIFICATION_CERT) $(PRIVATE_KEY): $(VERIFY_SIG_SETUP)
>  	$(Q)mkdir -p $(BUILD_DIR)
> @@ -790,14 +646,11 @@ LIBARENA_BPF_DEPS :=3D $(wildcard libarena/Makefile=
		\
>  				 libarena/selftests/*		\
>  				 libarena/*.bpf.o)
> =20
> -LIBARENA_SKEL :=3D libarena/libarena.skel.h
> =20
>  $(LIBARENA_SKEL): $(INCLUDE_DIR)/vmlinux.h $(BPFOBJ) $(LIBARENA_BPF_DEPS=
)
>  	+$(MAKE) -C libarena libarena.skel.h $(LIBARENA_MAKE_ARGS)
> =20
>  ifneq ($(CLANG_HAS_ARENA_ASAN),)
> -LIBARENA_ASAN_SKEL :=3D libarena/libarena_asan.skel.h
> -CFLAGS +=3D -DHAS_BPF_ARENA_ASAN
> =20
>  $(LIBARENA_ASAN_SKEL): $(INCLUDE_DIR)/vmlinux.h $(BPFOBJ) $(LIBARENA_BPF=
_DEPS)
>  	+$(MAKE) -C libarena libarena_asan.skel.h $(LIBARENA_MAKE_ARGS)
> diff --git a/tools/testing/selftests/bpf/Makefile.buildvars b/tools/testi=
ng/selftests/bpf/Makefile.buildvars
> new file mode 100644
> index 000000000..7b468ddf8
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/Makefile.buildvars
> @@ -0,0 +1,191 @@
> +# SPDX-License-Identifier: GPL-2.0
> +#
> +# Shared toolchain, path and flag definitions for the BPF selftests buil=
d.
> +# Included by both Makefile (the top level) and Makefile.runner (one
> +# test-runner instance).
> +#
> +# Requirements at include time:
> +#   - $(OUTPUT) is set to an absolute path
> +#   - tools/build/Build.include, tools/scripts/Makefile.arch and
> +#     tools/scripts/Makefile.include have been included (for SRCARCH etc=
.)

Nit: let's minimize these comments.

> +
> +CXX ?=3D $(CROSS_COMPILE)g++
> +PKG_CONFIG ?=3D $(CROSS_COMPILE)pkg-config
> +TOOLSDIR :=3D $(abspath ../../..)
> +LIBDIR :=3D $(TOOLSDIR)/lib
> +BPFDIR :=3D $(LIBDIR)/bpf
> +TOOLSINCDIR :=3D $(TOOLSDIR)/include
> +TOOLSARCHINCDIR :=3D $(TOOLSDIR)/arch/$(SRCARCH)/include
> +BPFTOOLDIR :=3D $(TOOLSDIR)/bpf/bpftool
> +APIDIR :=3D $(TOOLSINCDIR)/uapi
> +ifneq ($(O),)
> +GENDIR :=3D $(O)/include/generated
> +else
> +GENDIR :=3D $(abspath ../../../../include/generated)
> +endif
> +GENHDR :=3D $(GENDIR)/autoconf.h
> +
> +ifneq ($(wildcard $(GENHDR)),)
> +  GENFLAGS :=3D -DHAVE_GENHDR
> +endif
> +
> +ifeq ($(srctree),)
> +srctree :=3D $(abspath ../../../..)
> +endif
> +
> +ifdef ASAN
> +SAN_CFLAGS	?=3D -fsanitize=3Daddress -fno-omit-frame-pointer
> +else
> +SAN_CFLAGS	?=3D
> +endif
> +SAN_LDFLAGS	?=3D $(SAN_CFLAGS)
> +RELEASE		?=3D
> +OPT_FLAGS	?=3D $(if $(RELEASE),-O2,-O0)
> +
> +LIBELF_CFLAGS	:=3D $(shell $(PKG_CONFIG) libelf --cflags 2>/dev/null)
> +LIBELF_LIBS	:=3D $(shell $(PKG_CONFIG) libelf --libs 2>/dev/null || echo=
 -lelf)
> +
> +SKIP_DOCS	?=3D
> +SKIP_LLVM	?=3D
> +SKIP_LIBBFD	?=3D
> +SKIP_CRYPTO	?=3D
> +
> +# When BPF_STRICT_BUILD is 1, any BPF object, skeleton, test object, or
> +# benchmark compilation failure is fatal. Set to 0 to tolerate failures
> +# and continue building the remaining tests.
> +BPF_STRICT_BUILD ?=3D 1
> +PERMISSIVE :=3D $(filter 0,$(BPF_STRICT_BUILD))
> +
> +# BPF_GCC and TEST_KMODS are defined once in the main Makefile (they
> +# are needed there before lib.mk) and arrive here via the environment;
> +# TEST_KMODS=3D on the command line disables the modules.
> +TEST_KMOD_TARGETS =3D $(addprefix $(OUTPUT)/,$(TEST_KMODS))

In the next patch, let's inline TEST_KMOD_TARGETS in EXTRA_FILES and
drop this definition alongside the comment. Might as well keep
TEST_KMOD_TARGETS in the main Makefile for patch #2, to minimize the churn.

> +
> +# Output-tree layout. Defined before COMMON_CFLAGS on purpose: CFLAGS
> +# below is expanded immediately and references $(INCLUDE_DIR).
> +SCRATCH_DIR :=3D $(OUTPUT)/tools
> +BUILD_DIR :=3D $(SCRATCH_DIR)/build
> +INCLUDE_DIR :=3D $(SCRATCH_DIR)/include
> +BPFOBJ :=3D $(BUILD_DIR)/libbpf/libbpf.a
> +ifneq ($(CROSS_COMPILE),)
> +HOST_BUILD_DIR		:=3D $(BUILD_DIR)/host
> +HOST_SCRATCH_DIR	:=3D $(OUTPUT)/host-tools
> +HOST_INCLUDE_DIR	:=3D $(HOST_SCRATCH_DIR)/include
> +else
> +HOST_BUILD_DIR		:=3D $(BUILD_DIR)
> +HOST_SCRATCH_DIR	:=3D $(SCRATCH_DIR)
> +HOST_INCLUDE_DIR	:=3D $(INCLUDE_DIR)
> +endif
> +HOST_BPFOBJ :=3D $(HOST_BUILD_DIR)/libbpf/libbpf.a
> +RESOLVE_BTFIDS :=3D $(HOST_BUILD_DIR)/resolve_btfids/resolve_btfids
> +
> +DEFAULT_BPFTOOL :=3D $(HOST_SCRATCH_DIR)/sbin/bpftool
> +ifneq ($(CROSS_COMPILE),)
> +CROSS_BPFTOOL :=3D $(SCRATCH_DIR)/sbin/bpftool
> +TRUNNER_BPFTOOL :=3D $(CROSS_BPFTOOL)
> +USE_BOOTSTRAP :=3D
> +else
> +TRUNNER_BPFTOOL :=3D $(DEFAULT_BPFTOOL)
> +USE_BOOTSTRAP :=3D bootstrap/
> +endif
> +BPFTOOL ?=3D $(DEFAULT_BPFTOOL)
> +
> +COMMON_CFLAGS =3D -g $(OPT_FLAGS) -rdynamic -std=3Dgnu11			\
> +	  -Wall -Werror -fno-omit-frame-pointer				\
> +	  -Wno-unused-but-set-variable					\
> +	  $(GENFLAGS) $(SAN_CFLAGS) $(LIBELF_CFLAGS)			\
> +	  -I$(CURDIR) -I$(INCLUDE_DIR) -I$(GENDIR) -I$(LIBDIR)		\
> +	  -I$(TOOLSINCDIR) -I$(TOOLSARCHINCDIR) -I$(APIDIR) -I$(OUTPUT)	\
> +	  -I$(CURDIR)/libarena/include
> +LDFLAGS +=3D $(SAN_LDFLAGS)
> +LDLIBS +=3D $(LIBELF_LIBS) -lz -lrt -lpthread
> +
> +PCAP_CFLAGS	:=3D $(shell $(PKG_CONFIG) --cflags libpcap 2>/dev/null && e=
cho "-DTRAFFIC_MONITOR=3D1")
> +PCAP_LIBS	:=3D $(shell $(PKG_CONFIG) --libs libpcap 2>/dev/null)
> +LDLIBS +=3D $(PCAP_LIBS)
> +# Prepend rather than append: the include-search order must stay
> +# "$(COMMON_CFLAGS) first, lib.mk additions after" regardless of whether
> +# lib.mk was included before this file (top level) or not at all (runner=
).
> +CFLAGS :=3D $(COMMON_CFLAGS) $(PCAP_CFLAGS) $(CFLAGS)
> +
> +ifneq ($(LLVM),)
> +# Silence some warnings when compiled with clang
> +CFLAGS +=3D -Wno-unused-command-line-argument
> +endif
> +
> +# Check whether clang supports BPF address sanitizer (requires LLVM 22+)
> +CLANG_HAS_ARENA_ASAN :=3D $(shell echo 'int x;' | \
> +	$(CLANG) --target=3Dbpf -fsanitize=3Dkernel-address \
> +	-mllvm -asan-shadow-addr-space=3D1 \
> +	-x c -c - -o /dev/null 2>/dev/null && echo 1)
> +ifneq ($(CLANG_HAS_ARENA_ASAN),)
> +CFLAGS +=3D -DHAS_BPF_ARENA_ASAN
> +endif
> +
> +VMLINUX_BTF_PATHS ?=3D $(if $(O),$(O)/vmlinux)				\
> +		     $(if $(KBUILD_OUTPUT),$(KBUILD_OUTPUT)/vmlinux)	\
> +		     ../../../../vmlinux				\
> +		     /sys/kernel/btf/vmlinux				\
> +		     /boot/vmlinux-$(shell uname -r)
> +VMLINUX_BTF ?=3D $(abspath $(firstword $(wildcard $(VMLINUX_BTF_PATHS)))=
)
> +ifeq ($(VMLINUX_BTF),)
> +$(error Cannot find a vmlinux for VMLINUX_BTF at any of "$(VMLINUX_BTF_P=
ATHS)")
> +endif

VMLINUX_BTF{,_PATHS} don't seem to be used by Makefile.runner.

> +# Get Clang's default includes on this system, as opposed to those seen =
by
> +# '--target=3Dbpf'. This fixes "missing" files on some architectures/dis=
tros,
> +# such as asm/byteorder.h, asm/socket.h, asm/sockios.h, sys/cdefs.h etc.
> +#
> +# Use '-idirafter': Don't interfere with include mechanics except where =
the
> +# build would have failed anyways.
> +define get_sys_includes
> +$(shell $(1) $(2) -v -E - </dev/null 2>&1 \
> +	| sed -n '/<...> search starts here:/,/End of search list./{ s| \(/.*\)=
|-idirafter \1|p }') \
> +$(shell $(1) $(2) -dM -E - </dev/null | grep '__riscv_xlen ' | awk '{pri=
ntf("-D__riscv_xlen=3D%d -D__BITS_PER_LONG=3D%d", $$3, $$3)}') \
> +$(shell $(1) $(2) -dM -E - </dev/null | grep '__loongarch_grlen ' | awk =
'{printf("-D__BITS_PER_LONG=3D%d", $$3)}') \
> +$(shell $(1) $(2) -dM -E - </dev/null | grep -E 'MIPS(EL|EB)|_MIPS_SZ(PT=
R|LONG) |_MIPS_SIM |_ABI(O32|N32|64) ' | awk '{printf("-D%s=3D%s ", $$2, $$=
3)}')
> +endef
> +
> +# Determine target endianness.
> +IS_LITTLE_ENDIAN :=3D $(shell $(CC) -dM -E - </dev/null | \
> +			grep 'define __BYTE_ORDER__ __ORDER_LITTLE_ENDIAN__')
> +MENDIAN :=3D $(if $(IS_LITTLE_ENDIAN),-mlittle-endian,-mbig-endian)
> +BPF_TARGET_ENDIAN :=3D $(if $(IS_LITTLE_ENDIAN),--target=3Dbpfel,--targe=
t=3Dbpfeb)
> +
> +ifneq ($(CROSS_COMPILE),)
> +CLANG_TARGET_ARCH =3D --target=3D$(notdir $(CROSS_COMPILE:%-=3D%))
> +endif
> +
> +CLANG_SYS_INCLUDES :=3D $(call get_sys_includes,$(CLANG),$(CLANG_TARGET_=
ARCH))
> +BPF_CFLAGS =3D -g -Wall -Werror -D__TARGET_ARCH_$(SRCARCH) $(MENDIAN)	\
> +	     -I$(INCLUDE_DIR) -I$(CURDIR) -I$(APIDIR)			\
> +	     -I$(CURDIR)/libarena/include				\
> +	     -I$(abspath $(OUTPUT)/../usr/include)			\
> +	     -std=3Dgnu11		 					\
> +	     -fno-strict-aliasing 					\
> +	     -Wno-microsoft-anon-tag					\
> +	     -fms-extensions						\
> +	     -Wno-compare-distinct-pointer-types			\
> +	     -Wno-initializer-overrides					\
> +	     #
> +# TODO: enable me -Wsign-compare
> +
> +CLANG_CFLAGS =3D $(CLANG_SYS_INCLUDES)
> +
> +# Signing key/cert shared by the signed light skeletons and test_progs.
> +VERIFY_SIG_SETUP :=3D $(CURDIR)/verify_sig_setup.sh
> +VERIFY_SIG_HDR :=3D verification_cert.h
> +VERIFICATION_CERT :=3D $(BUILD_DIR)/signing_key.der
> +PRIVATE_KEY :=3D $(BUILD_DIR)/signing_key.pem
> +
> +# libarena skeletons, built by the libarena/ sub-make (driven by the top
> +# level Makefile); test_progs and its flavors depend on the headers.
> +LIBARENA_SKEL :=3D libarena/libarena.skel.h
> +ifneq ($(CLANG_HAS_ARENA_ASAN),)
> +LIBARENA_ASAN_SKEL :=3D libarena/libarena_asan.skel.h
> +endif
> +
> +ifneq ($(V),1)
> +submake_extras :=3D feature_display=3D0
> +endif
