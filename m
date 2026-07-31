Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E8D63630AE
	for <bpf@vger.kernel.org>; Fri, 31 Jul 2026 22:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785536839; cv=none; b=rugRp1g1o+ebLIFCGZ51L5pTH+LW1RLle/sw47+2Mx8GB0TTLpdHWgp3pv7ah10REYzsoZR+ltOriJyTsgAw62ANPnyfLsPmWOHX/eaSx8vbfhvUKUqdSzKnafcvINFmEoS6RhFEZdMjEw7CcuO+ycI51s9Zah4eU2xF/frxPto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785536839; c=relaxed/simple;
	bh=DZNOxoC1FfiPSCjxmkljU1WBbL5rxp+8ONKhhRPnx04=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=jKuYG8i2kHzglMe59P4XAGsFO7Bd1hYRV+0G14pkmGvJkJpr7IuqL2sqfv2znyrATcqfGTaINWYx9LM0gMjVAfTdIEus/ed9XMdt7ImXsA5ZYB34Iny7QMmqopfSZNBOQcVMsqBqDaDU5mh+5ha9n/232VkFelKdvPpZB8Z8Q3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KCoLDiQP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KCoLDiQP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 350651F00AC4;
	Fri, 31 Jul 2026 22:27:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785536838;
	bh=YrNRilwwtyWOBp6+BMRy/ppSWm8fsjyjpTEEqaprP7Q=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=KCoLDiQPGqCtx0kgSZOOcWf6iKQb17a5iQKsHbTvnsiVzGISn4W5tW64eaVghm5cr
	 9nUtBxiEtzqh0C2n9JcjF+QPsrWN2iDc6BeSWiiNQCgnzwQdyuWdlAFr7M4xhLfyPI
	 g33rtR/n9s5ClBkIafKNilNXBA/efl7gIRwyLh2KzaMX7WDXrehKkQNK9wZt8F/p79
	 yW7/7b0xRFHyrZTPdNgkRPGC6fzjGhKK9wCwPxjZ6O8Oek1sIWm+xz3Wi8KXBAe/Fk
	 U8PnSaQc8W5ebpaoiYxpi9cjeK7TtlRz6blsNgq4e3PsQwEe8+y2+77rsWA/oDrpWV
	 FUHr6hqSfwAuQ==
Content-Type: multipart/mixed; boundary="===============0706035036033358921=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <26de96afd813486d7e90ef7dea4c4d7e3e98b8400fb372cddac4a2f568502189@mail.kernel.org>
In-Reply-To: <20260724042600.175440-3-nickolay.lysenko@gmail.com>
References: <20260724042600.175440-3-nickolay.lysenko@gmail.com>
Subject: Re: [RFC PATCH bpf-next v4 2/3] selftests/bpf: move shared build definitions into Makefile.buildvars
From: bot+bpf-ci@kernel.org
To: nickolay.lysenko@gmail.com,bpf@vger.kernel.org
Cc: ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,memxor@gmail.com,nickolay.lysenko@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Fri, 31 Jul 2026 22:27:17 +0000 (UTC)

--===============0706035036033358921==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
> index 2ed953b84409..1843679fc0e2 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile

[ ... ]

> @@ -213,21 +149,8 @@ ifeq ($(feature-llvm),1)
>  endif
>  endif
>
> -SCRATCH_DIR := $(OUTPUT)/tools
> -BUILD_DIR := $(SCRATCH_DIR)/build
> -INCLUDE_DIR := $(SCRATCH_DIR)/include
> -BPFOBJ := $(BUILD_DIR)/libbpf/libbpf.a
> -ifneq ($(CROSS_COMPILE),)
> -HOST_BUILD_DIR		:= $(BUILD_DIR)/host
> -HOST_SCRATCH_DIR	:= $(OUTPUT)/host-tools
> -HOST_INCLUDE_DIR	:= $(HOST_SCRATCH_DIR)/include
> -else
> -HOST_BUILD_DIR		:= $(BUILD_DIR)
> -HOST_SCRATCH_DIR	:= $(SCRATCH_DIR)
> -HOST_INCLUDE_DIR	:= $(INCLUDE_DIR)
> -endif
> -HOST_BPFOBJ := $(HOST_BUILD_DIR)/libbpf/libbpf.a
> -RESOLVE_BTFIDS := $(HOST_BUILD_DIR)/resolve_btfids/resolve_btfids
> +include Makefile.buildvars
> +
>  VMLINUX_BTF_PATHS ?= $(if $(O),$(O)/vmlinux)				\
>  		     $(if $(KBUILD_OUTPUT),$(KBUILD_OUTPUT)/vmlinux)	\
>  		     ../../../../vmlinux				\

The srctree fallback block moved into Makefile.buildvars, but that file is
included after ../../../build/Makefile.feature has already been parsed. Does
this break the feature-llvm probe for standalone builds?

In the pre-image, the ordering was:

  include ../../../scripts/Makefile.include
  <srctree fallback at old line 53-58>
  include ../lib.mk
  $(eval include ../../../build/Makefile.feature)  # old line 183/186

After the patch:

  include ../../../scripts/Makefile.include
  include ../lib.mk
  $(eval include ../../../build/Makefile.feature)  # new line 119/122
  include Makefile.buildvars                        # srctree defined here

Makefile.feature line 2 does:

  feature_dir := $(srctree)/tools/build/feature

This is an immediate assignment, so it captures srctree when
Makefile.feature is parsed. In a standalone 'cd tools/testing/selftests/bpf
&& make' build, srctree is not in the environment and nothing in the earlier
include chain defines it - none of tools/build/Build.include,
tools/scripts/Makefile.arch, tools/scripts/Makefile.include or
tools/testing/selftests/lib.mk contain a srctree assignment.

Consequently feature_dir becomes '/tools/build/feature' instead of
'<tree>/tools/build/feature', and the probe at Makefile.feature:11 runs:

  $(MAKE) ... -C /tools/build/feature ...

The '-C /tools/build/feature' fails because the directory does not exist,
stderr is discarded, and the probe silently yields feature-llvm=0.

This flips the conditional at Makefile:127-150 off, so LLVM_CFLAGS never
gains -DHAVE_LLVM_SUPPORT and LLVM_LDLIBS/LLVM_LDFLAGS stay empty.
jit_disasm_helpers.c then compiles its '#else' stub whose get_jited_program_text()
returns -EOPNOTSUPP, and test_loader.c:1442-1449 turns every __jited expectation
into test__skip() with "tests are built w/o LLVM development libs". The six
progs/ files that use __jited stop running, and test_progs loses
-DHAVE_LLVM_SUPPORT and the LLVM libraries it previously linked.

This contradicts the commit message's "Build artifacts are byte-identical
before and after this change" claim for the standard build invocation
documented in Documentation/bpf/bpf_devel_QA.rst:459.

The srctree fallback belongs with BPF_GCC in the "needed before lib.mk"
group that the commit message already identifies, for the same reason -
it is consumed before Makefile.buildvars is included. The same applies to
PKG_CONFIG, which is used in Makefile.feature at lines 178/183 but is now
only defined in Makefile.buildvars.

> diff --git a/tools/testing/selftests/bpf/Makefile.buildvars b/tools/testing/selftests/bpf/Makefile.buildvars
> new file mode 100644
> index 000000000000..ef12018fa254
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/Makefile.buildvars
> @@ -0,0 +1,165 @@
> +# SPDX-License-Identifier: GPL-2.0
> +#
> +# Shared toolchain, path and flag definitions for the BPF selftests
> +# build, included by both Makefile and Makefile.runner. Definitions
> +# follow the order they had in the Makefile before the split.
> +
> +CXX ?= $(CROSS_COMPILE)g++
> +OBJCOPY ?= $(CROSS_COMPILE)objcopy
> +
> +CURDIR := $(abspath .)
> +
> +TOOLSDIR := $(abspath ../../..)
> +LIBDIR := $(TOOLSDIR)/lib
> +BPFDIR := $(LIBDIR)/bpf
> +TOOLSINCDIR := $(TOOLSDIR)/include
> +TOOLSARCHINCDIR := $(TOOLSDIR)/arch/$(SRCARCH)/include
> +BPFTOOLDIR := $(TOOLSDIR)/bpf/bpftool
> +APIDIR := $(TOOLSINCDIR)/uapi
> +ifneq ($(O),)
> +GENDIR := $(O)/include/generated
> +else
> +GENDIR := $(abspath ../../../../include/generated)
> +endif
> +GENHDR := $(GENDIR)/autoconf.h
> +PKG_CONFIG ?= $(CROSS_COMPILE)pkg-config

Same ordering issue: PKG_CONFIG was defined before ../lib.mk in the
pre-image, but now it is only defined here in Makefile.buildvars, which is
reached after Makefile.feature has already been parsed.

Makefile.feature uses PKG_CONFIG at parse time:

  ifneq ($(PKG_CONFIG),)
    $(foreach package,$(FEATURE_PKG_CONFIG),$(call feature_pkg_config,$(package)))

with immediate assignments at lines 178-179:

  FEATURE_CHECK_CFLAGS-$(1)  := $(shell $(PKG_CONFIG) --cflags $(1) 2>/dev/null)
  FEATURE_CHECK_LDFLAGS-$(1) := $(shell $(PKG_CONFIG) --libs $(1) 2>/dev/null)

Nothing parsed before Makefile.buildvars defines PKG_CONFIG, so the ifneq
guard becomes false and the pkg-config-derived FEATURE_CHECK_*FLAGS block is
skipped.

> +ifeq ($(srctree),)
> +srctree := $(patsubst %/,%,$(dir $(CURDIR)))
> +srctree := $(patsubst %/,%,$(dir $(srctree)))
> +srctree := $(patsubst %/,%,$(dir $(srctree)))
> +srctree := $(patsubst %/,%,$(dir $(srctree)))
> +endif

[ ... ]

> +ifneq ($(CROSS_COMPILE),)
> +CLANG_TARGET_ARCH = --target=$(notdir $(CROSS_COMPILE:%-=%))
> +endif
> +
> +# Immediate on purpose: expanding get_sys_includes forks several shells.
> +CLANG_SYS_INCLUDES := $(call get_sys_includes,$(CLANG),$(CLANG_TARGET_ARCH))

The commit message states "Definitions keep the order they had in the
Makefile; the only exception is called out in a comment (CFLAGS is prepended
rather than appended, as this file is included after lib.mk)."

However, CLANG_SYS_INCLUDES also changed from recursive assignment ('=') to
immediate assignment (':='):

  pre  (Makefile:463): CLANG_SYS_INCLUDES = $(call get_sys_includes,$(CLANG),$(CLANG_TARGET_ARCH))
  post (buildvars:139): CLANG_SYS_INCLUDES := $(call get_sys_includes,$(CLANG),$(CLANG_TARGET_ARCH))

The inline comment explains the fork-count motivation, but this is a second
evaluation-time change beyond the CFLAGS exception documented in the
changelog. It happens to be benign at this commit since CLANG and
CLANG_TARGET_ARCH are already final, but any later target-specific or
conditional override of CLANG would silently stop affecting CLANG_SYS_INCLUDES.

Would it be worth mentioning this change in the commit message too?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/30582411360
--===============0706035036033358921==--
