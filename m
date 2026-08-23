Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FBA0344DBD
	for <bpf@vger.kernel.org>; Sun, 23 Aug 2026 02:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787451997; cv=none; b=Jj8n50SAjXjS5NfpDD4Qiatigcnhw7x2Md9fSnVA1ArO86BoZBumgCK6CW/xnjuxTPbS/bYCQcUsHBdMoNHZ0EjRzlfRA4TgDz55+PAUEfxw+tVTjx0AfzJgccCRwICRTnd2WNf4HGray+7Y/MGLQ6H8es7uWX8busWWdmy8o5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787451997; c=relaxed/simple;
	bh=X1P/73ZS0GQCUX4HdGqN1uajdPJz7fK+qVh+6ekDEfY=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=JL6e+h9qtnI75ifsWJzqUhd6oyzwbEbHpNMv0z0A6D7LBC843Cmo3HwoSgQYCy4zTXx6HBIk52YkKDUWNQQsIhZDce53yzZ60iVYo8uWiExEP1fudFetOQy/e/QdrLCS9pb5BUlPpdC2XcLDZk8JCUUGRBP6V6m5aus99+WBAm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lAg+NV7a; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lAg+NV7a"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5728E1F000E9;
	Sun, 23 Aug 2026 02:26:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787451995;
	bh=bfKf22E1fEab3xtUdLRCCMAS9e+N3IR+om5Y2fHYtyI=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=lAg+NV7aq3+KLZn30+NaEDowEw8L+Fo3WmDP64u8fF+8tN2m6eNZOMhhEcy3ShMfR
	 Eo4250rxgzbIIPtJ6nlb6l1MDfoiz/BonuScjk3NNo3AM5NsGkDSHb44O23GIF+Eax
	 Phtf4tGcSHpWOlWD0SKhEtT4mF9lM37YSgOOihXncuIAM661PLq0b5H/ydVo5sHsdL
	 r1GzNZfJk+HfXeUFisboQDLo+3UcC/NvvAVnhfN2vhxvXsEc5eQWzaSagOowqOrht7
	 7EYEr7DSVhEVdRHAtfa0QGt0NaprV91c6uA8gQfIDjz/AGxT4Gz8Vs9UQQmzby91EB
	 N9ZPDbjusqZ3Q==
Content-Type: multipart/mixed; boundary="===============7743045459044147856=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <cead4064befa79408fdf50f4c6d9e08c91b4e38093ba9c17d71823b94462b408@mail.kernel.org>
In-Reply-To: <20260823010900.1730708-10-nickolay.lysenko@gmail.com>
References: <20260823010900.1730708-10-nickolay.lysenko@gmail.com>
Subject: Re: [PATCH bpf-next v6 9/9] selftests/bpf: build each test runner instance in its own sub-make
From: bot+bpf-ci@kernel.org
To: nickolay.lysenko@gmail.com,bpf@vger.kernel.org
Cc: ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,memxor@gmail.com,nickolay.lysenko@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Sun, 23 Aug 2026 02:26:35 +0000 (UTC)

--===============7743045459044147856==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
> index fe838bb23bcd..22f3a261dc16 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile

[ ... ]

> @@ -256,9 +246,26 @@ $(OUTPUT)/test_sock_fields: $(CGROUP_HELPERS) $(TESTING_HELPERS)
>  $(OUTPUT)/test_tag: $(TESTING_HELPERS)
>  $(OUTPUT)/test_lirc_mode2_user: $(TESTING_HELPERS)
>  $(OUTPUT)/flow_dissector_load: $(TESTING_HELPERS)
> -$(OUTPUT)/test_maps: $(TESTING_HELPERS)
>  $(OUTPUT)/test_verifier: $(TESTING_HELPERS) $(CAP_HELPERS) $(UNPRIV_HELPERS)
> -$(OUTPUT)/xsk.o: $(BPFOBJ)
> +
> +# The userspace objects the runner instances link (RUNNER_OBJS, see
> +# Makefile.buildvars) are built here, once, so that no runner sub-make
> +# ever writes a file this Makefile also builds.
> +#
> +# $(BPFTOOL) is a prerequisite because its sub-make is what installs
> +# libbpf's internal headers (bpf/hashmap.h, bpf/libbpf_internal.h) into
> +# $(INCLUDE_DIR); without it, trace_helpers.c races the install and can
> +# silently pick up the source-tree copies instead.
> +RUNNER_OBJS := $(sort $(RUNNER_OBJS-test_progs) $(RUNNER_OBJS-test_maps)\
> +		      $(RUNNER_LIB_OBJS-test_progs))
> +$(RUNNER_OBJS): $(VERIFY_SIG_HDR) prog_tests/tests.h map_tests/tests.h	\
> +		$(BPFOBJ) $(BPFTOOL)

Does making both tests.h headers prerequisites of the entire merged
RUNNER_OBJS set cause unnecessary rebuilds?

The generators (seen later in this patch as prog_tests/tests.h and
map_tests/tests.h rules) rewrite their outputs with '> $@' whenever any
.c in their directory is newer, so the mtime changes even when the
DEFINE_TEST list is unchanged.

With this rule, touching a single map_tests/*.c file regenerates
map_tests/tests.h and then forces recompilation of all 22 RUNNER_OBJS
including test_progs.o, testing_helpers.o, and all the helper objects
that never include map_tests/tests.h. The reverse also holds: editing
prog_tests/*.c now rebuilds test_maps.o.

In the pre-image each runner's objects depended only on its own tests.h
(the TRUNNER_EXTRA_OBJS rule was instantiated per runner). Only
test_progs.c includes prog_tests/tests.h and only test_maps.c includes
map_tests/tests.h, so would something like this work instead:

  $(RUNNER_OBJS): $(VERIFY_SIG_HDR) $(BPFOBJ) $(BPFTOOL)
  $(OUTPUT)/test_progs.o: prog_tests/tests.h
  $(OUTPUT)/test_maps.o: map_tests/tests.h

[ ... ]

> diff --git a/tools/testing/selftests/bpf/Makefile.runner b/tools/testing/selftests/bpf/Makefile.runner
> new file mode 100644
> index 000000000000..a15efef2c8a1
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/Makefile.runner
> @@ -0,0 +1,175 @@
> +# SPDX-License-Identifier: GPL-2.0
> +#
> +# Build one BPF test-runner instance: test_progs, one of its flavors
> +# (no_alu32, cpuv4, bpf_gcc), or test_maps.
> +#
> +# Each instance is an independent sub-make with its own output directory,
> +# so everything here is written in plain make - no $$-escaping, no eval,
> +# no per-flavor guards. This file is always invoked by the main Makefile,
> +# never directly: all shared prerequisites (libbpf, bpftool, vmlinux.h,
> +# veristat, userspace objects, signing key, generated tests.h, extra
> +# binaries and - for the unflavored instances - the default flavor's
> +# BPF objects and skeletons) are built by the main Makefile *before*
> +# this one runs and are referenced below as plain files.
> +#
> +# Parameters (all passed on the sub-make command line):
> +#   OUTPUT      absolute path of the selftests output directory
> +#   RUNNER      base binary name: test_progs | test_maps
> +#   FLAVOR      flavor suffix: empty | no_alu32 | cpuv4 | bpf_gcc
> +#   TESTS_DIR   directory with the test sources: prog_tests | map_tests
> +#   BPF_CC      compiler for progs/*.c BPF objects ($(CLANG) or
> +#               $(BPF_GCC)); empty for test_maps, which builds none
> +#   BPF_CC_MSG  build-log tag: CLNG-BPF | GCC-BPF
> +#   BPF_CC_FLAGS
> +#               compiler-specific flags (-O2, target/-mcpu or gcc knobs)
> +#   BPF_SYS_INCLUDES
> +#               system include flags matching BPF_CC
> +#   BPF_DEFINES extra defines for BPF objects (e.g. -DENABLE_ATOMICS_TESTS)
> +#   CC          C compiler (as resolved by lib.mk in the main Makefile)
> +#   LLVM_CFLAGS/LLVM_LDLIBS/LLVM_LDFLAGS
> +#               results of the top-level LLVM feature probe

[ ... ]

> +
> +include ../../../build/Build.include
> +include ../../../scripts/Makefile.arch
> +include ../../../scripts/Makefile.include
> +
> +# Same message helpers as ../lib.mk, which only the top level includes.
> +ifeq ($(V),1)
> +Q =
> +msg =
> +else
> +Q = @
> +msg = @printf '  %-8s%s %s%s\n' "$(1)" "$(if $(2), [$(2)])" "$(notdir $(3))" "$(if $(4), $(4))";
> +MAKEFLAGS += --no-print-directory
> +endif
> +
> +include Makefile.buildvars

Does Makefile.buildvars get the correct CLANG value when LLVM is a
prefixed or suffixed toolchain?

Makefile.buildvars runs a feature probe that affects the build graph:

  # Makefile.buildvars:93-97
  CLANG_HAS_ARENA_ASAN := $(shell echo 'int x;' | \
      $(CLANG) --target=bpf -fsanitize=kernel-address \
      -mllvm -asan-shadow-addr-space=1 \
      -x c -c - -o /dev/null 2>/dev/null && echo 1)

  # Makefile.buildvars:170-173
  ifneq ($(CLANG_HAS_ARENA_ASAN),)
  LIBARENA_ASAN_SKEL := libarena/libarena_asan.skel.h
  CFLAGS += -DHAS_BPF_ARENA_ASAN
  endif

In the top-level make, ../lib.mk defines CLANG when LLVM is set:

  ifneq ($(LLVM),)
  ifneq ($(filter %/,$(LLVM)),)
  LLVM_PREFIX := $(LLVM)
  else ifneq ($(filter -%,$(LLVM)),)
  LLVM_SUFFIX := $(LLVM)
  endif
  CLANG := $(LLVM_PREFIX)clang$(LLVM_SUFFIX)

so the top-level probe uses the versioned or prefixed compiler.

However, Makefile.runner does not include ../lib.mk and the parameters
comment says CC is passed on the command line but CLANG is not. The
only definition in scope here is scripts/Makefile.include's fallback:

  CLANG ?= clang

and the export statement in the main Makefile is:

  export LLVM_CFLAGS LLVM_LDLIBS LLVM_LDFLAGS BPF_GCC TEST_KMODS

which does not export CLANG, LLVM, LLVM_PREFIX, or LLVM_SUFFIX.

So when LLVM names a prefixed or suffixed toolchain (LLVM=-19,
LLVM=/path/to/llvm/bin/), every runner sub-make re-runs the probe with
plain 'clang' and can produce a different LIBARENA_ASAN_SKEL /
CFLAGS=-DHAS_BPF_ARENA_ASAN result from the top-level make.

If the versioned clang supports arena ASAN and plain clang does not (or
is missing), the top-level builds libarena/libarena_asan.skel.h and
adds it to RUNNER_PREREQS but the runner compiles without
-DHAS_BPF_ARENA_ASAN. Then prog_tests/libarena_asan.c's entire body is
guarded by #ifdef HAS_BPF_ARENA_ASAN and the test silently reports SKIP
on a toolchain that supports the feature.

If plain clang supports arena ASAN and the versioned one does not, the
runner sets LIBARENA_ASAN_SKEL and puts it in GENERATED_HDRS, which is
a prerequisite of the $(TEST_DEPS) rule. The main Makefile did not
build that file, the runner has no recipe (Makefile.skel's rules are
static pattern, and built-in rules are off), so the build fails with
'No rule to make target libarena/libarena_asan.skel.h'.

Should CLANG be passed on the RUNNER_MAKE command line like CC, or
should Makefile.runner repeat lib.mk's LLVM_PREFIX/LLVM_SUFFIX/CLANG
derivation?

> +
> +# Keep in sync with the CFLAGS/LDFLAGS additions in ../lib.mk.
> +CFLAGS += -D_GNU_SOURCE=
> +CFLAGS += -I$(srctree)/tools/testing/selftests

[ ... ]

> +# Non-flavored in-srctree builds receive special treatment, in particular
> +# we do not need to copy extra resources (see e.g. test_btf_dump_case()).
> +.PHONY: extras
> +extras: $(if $(PERMISSIVE),$(wildcard $(EXTRA_FILES)),$(EXTRA_FILES)) | $(RDIR)
> +ifneq ($(FLAVOR):$(OUTPUT),:$(CURDIR))
> +ifneq ($(strip $(EXTRA_FILES)),)
> +	$(call msg,EXT-COPY,$(BINARY),$(notdir $(EXTRA_FILES)))
> +	$(Q)rsync -aq $(if $(PERMISSIVE),--ignore-missing-args) $(EXTRA_FILES) $(RDIR)/
> +endif
> +endif

Does the guard that skips the unflavored in-tree extras copy still work
when the build directory is reached through a symlink?

The pre-image compared:

  ifneq ($2:$(OUTPUT),:$(shell pwd))

where both sides came from '$(shell pwd)' (lib.mk sets OUTPUT that way
for in-tree builds), so they matched by construction.

The new comparison uses $(CURDIR), which is make's getcwd() result with
symlinks resolved, while $(OUTPUT) is inherited from the parent make's
'$(shell pwd)', which prints $PWD when it is a valid name for the
current directory - a logical path.

When the build directory is reached through a symlink:

  cd /build/linux/tools/testing/selftests/bpf  # symlink
  make

$(OUTPUT) and $(CURDIR) name the same directory with different strings,
the condition becomes true, and the unflavored in-tree build runs the
EXT-COPY branch it is documented to skip: rsync of the $(OUTPUT)/...
entries onto themselves plus flat copies of
progs/btf_dump_test_case_*.c and progs/*.bpf.o into the source
directory.

Would comparing $(OUTPUT) against '$(shell pwd)' or comparing
$(realpath) / $(abspath) of both sides restore the pre-image behaviour?

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/32610372822
--===============7743045459044147856==--
