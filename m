Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FE38352C5B
	for <bpf@vger.kernel.org>; Sun, 23 Aug 2026 21:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787519105; cv=none; b=lyPzRO7jJWJnKlWORxMtSpdQZtOdSLuRDwYOrChdpoI4MUmki/VI4kEpw34/sfPLeLIgKkCpKpU+yy+wo0StT7RytZD5707SvyHqMlfPqXnmGQ2imIA2bZNbwQVvWaxRvdaYYJdJZFET5DLZE/7Q/dOgnlbVvZRmRXOotzAOND4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787519105; c=relaxed/simple;
	bh=TdLPf0TwQxyIGBAKSuD/+Np+ed9t6iOarszJv77/hCE=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=VkXkVajdmdfPZaj4lhqWWEUf0fJB2bAXq5PUS27gS+tgQw76EHfLCegysFuRteIrFZgPXD8V5Rtc/nZK6wpDAW5jM3blamlYrhUR1U3j00jSO0RG73jQ1izf/GDLQknDGAu3Ky3MDffyqV5gkmElhw5ZEO2LF86/FqxTJ3Q3fJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PmJxHs2r; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PmJxHs2r"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 769151F000E9;
	Sun, 23 Aug 2026 21:05:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787519103;
	bh=99lZjKyhc1mbBPDrJaHUVJhj29KWiy8TPXLY2PX1vKI=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=PmJxHs2rbFs/78HgjCuJvi1G00JRoeC6mcmuMniXpw0VWF3tvlW9dl0AW/LHF8PMu
	 UpvupST5XVy5lcuGQG55hfMKpYOhUgWGPOJ2JpP/w+6OUvFDydEOYV+K0X/uDpbHkH
	 klKMyZ3aBw4kUUyOjwVO69pyE26uZFnsgIbVF20pQTH2km53QJIlDHP0biDQXcQQSp
	 ZTwfcuPD67BTnb9b8+19dRUDVQFJR/QNKTeqUXtEQZcrpdVZHMO45ng47k6pk9nUq/
	 6cq8YjOmKxTPGOGdCo9k2j9Vas+xlTltEKia9orK7Mk7yMtafXbtASGrkW5bhlnxZH
	 wVYeqxpD1c+9g==
Content-Type: multipart/mixed; boundary="===============8947748123915798385=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <0d5046cc308a268dbc6ec6d61f05e6632343b92ad46be892135bcb0561b1beae@mail.kernel.org>
In-Reply-To: <20260823194241.3415152-10-nickolay.lysenko@gmail.com>
References: <20260823194241.3415152-10-nickolay.lysenko@gmail.com>
Subject: Re: [PATCH bpf-next v7 9/9] selftests/bpf: build each test runner instance in its own sub-make
From: bot+bpf-ci@kernel.org
To: nickolay.lysenko@gmail.com,bpf@vger.kernel.org
Cc: ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,memxor@gmail.com,nickolay.lysenko@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Sun, 23 Aug 2026 21:05:03 +0000 (UTC)

--===============8947748123915798385==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> Replace the DEFINE_TEST_RUNNER/DEFINE_TEST_RUNNER_RULES double-expansion
> machinery - whose rules never appear in the source as written, are
> invisible to make's own debugging facilities, and are easy to break
> for one flavor while testing another - with Makefile.runner: one
> sub-make invocation per test runner
> instance (test_progs, test_progs-no_alu32, test_progs-cpuv4,
> test_progs-bpf_gcc, test_maps), each in its own single-flavor namespace
> written in plain make - no define/eval layer, no per-flavor guards,
> no accumulating vpath directives.
> The main Makefile keeps everything that exists once - tool sub-builds,
> vmlinux.h, signing keys, tests.h generation, standalone binaries and
> the kselftest lib.mk contract - and delegates to the runner through
> explicit per-instance rules.
> The rules for one flavor's BPF objects and skeletons live in
> Makefile.skel, instantiated by the main Makefile for the default
> flavor and by each runner sub-make that builds BPF objects. lib.mk's
> install rule copies the default flavor's BPF objects - the files the
> flat copy of every flavor's objects resolved to before. No file is
> built twice in one build: the main Makefile produces the default
> flavor's artifacts before the unflavored test_progs sub-make runs,
> and each flavored runner writes its own subdirectory plus its binary
> in $(OUTPUT) (the bpftool
> link in $(OUTPUT) is refreshed by both unflavored sub-makes, as
> before).
> The runner instances link userspace objects the main Makefile
> builds once; the
> flavored instances link the shared objects instead of compiling
> their own identical copies.

This isn't a bug, but the wrapping looks unusual here. Several lines
break after only a few words in the middle of a sentence (e.g., "with
Makefile.runner: one / sub-make invocation per test runner / instance"
and "and each flavored runner writes its own subdirectory plus its
binary / in $(OUTPUT) (the bpftool / link in $(OUTPUT) is refreshed").

Could the changelog be reflowed to a consistent width? Kernel changelogs
are conventionally wrapped at around 72-75 columns with blank lines
between paragraphs.

> Smaller behaviour changes that come with the move, for the record:
> the skeleton recipes' build-log lines take the msg helper's format
> and stream, the shared userspace objects log as CC rather than
> EXT-OBJ/LIB-OBJ, and TEST-HDR lines lose their runner tag; the signed
> light-skeleton rule lists the key and certificate it uses as
> prerequisites; the extras copy skips an empty file list and, in
> permissive mode, does not wait for files whose build was skipped;
> $(OUTPUT)/test_maps waits for the same shared prerequisites as the
> other runners; the bare-name convenience targets for the
> linked-skeleton constituents (make linked_funcs1.bpf.o) are gone; the
> .d include no longer special-cases the clean, docs-clean and
> emit_tests goals,
> which a runner sub-make never runs; and the test objects' first-build
> ordering lists only the generated headers the runner itself consumes,
> the rest being built by the main Makefile before any runner starts.

This isn't a bug, but the behaviour changes paragraph is written as one
sentence with roughly ten semicolon-separated clauses spanning about 20
lines. At least two of these are user-visible interface changes (the
bare-name convenience targets like "make linked_funcs1.bpf.o" are gone,
and the .d include no longer special-cases clean/docs-clean/emit_tests)
rather than cosmetic log changes.

Could this be turned into a bulleted list with the interface-affecting
changes called out separately?

> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile

[ ... ]

> @@ -672,76 +416,109 @@
>  	+$(MAKE) -C libarena libarena_asan.skel.h $(LIBARENA_MAKE_ARGS)
>  endif
>
> -# Define test_progs test runner.
> -TRUNNER_TESTS_DIR := prog_tests
> -TRUNNER_BPF_PROGS_DIR := progs
> -TRUNNER_EXTRA_SOURCES := test_progs.c		\
> -			 cgroup_helpers.c	\
> -			 trace_helpers.c	\
> -			 network_helpers.c	\
> -			 testing_helpers.c	\
> -			 btf_helpers.c		\
> -			 cap_helpers.c		\
> -			 unpriv_helpers.c 	\
> -			 sysctl_helpers.c	\
> -			 netlink_helpers.c	\
> -			 jit_disasm_helpers.c	\
> -			 io_helpers.c		\
> -			 test_loader.c		\
> -			 xsk.c			\
> -			 disasm.c		\
> -			 disasm_helpers.c	\
> -			 json_writer.c 		\
> -			 $(VERIFY_SIG_HDR)		\
> -			 flow_dissector_load.h	\
> -			 ip_check_defrag_frags.h	\
> -			 bpftool_helpers.c	\
> -			 usdt_1.c usdt_2.c	\
> -			 $(LIBARENA_SKEL)	\
> -			 $(LIBARENA_ASAN_SKEL)
> -TRUNNER_LIB_SOURCES := find_bit.c
> -TRUNNER_EXTRA_FILES := $(OUTPUT)/urandom_read				\
> -		       $(OUTPUT)/liburandom_read.so			\
> -		       $(OUTPUT)/xdp_synproxy				\
> -		       $(OUTPUT)/sign-file				\
> -		       $(OUTPUT)/uprobe_multi				\
> -		       $(TEST_KMOD_TARGETS)				\
> -		       ima_setup.sh 					\
> -		       $(VERIFY_SIG_SETUP)				\
> -		       $(wildcard progs/btf_dump_test_case_*.c)		\
> -		       $(wildcard progs/*.bpf.o)
> -TRUNNER_BPF_BUILD_RULE := CLANG_BPF_BUILD_RULE
> -TRUNNER_BPF_CFLAGS := $(BPF_CFLAGS) $(CLANG_CFLAGS) -DENABLE_ATOMICS_TESTS
> -$(eval $(call DEFINE_TEST_RUNNER,test_progs))
> +# Generated test list headers
> +
> +define gen_tests_hdr
> +	$(call msg,TEST-HDR,,$@)
> +	$(Q)(echo '/* Generated header, do not edit */';		\
> +		  sed -n -E 's/^void (serial_)?test_([a-zA-Z0-9_]+)\((void)?\).*/DEFINE_TEST(\2)/p'	\
> +		$(@D)/*.c | sort) > $@
> +endef
> +
> +prog_tests/tests.h: $(wildcard prog_tests/*.c)
> +	$(gen_tests_hdr)
> +
> +map_tests/tests.h: $(wildcard map_tests/*.c)
> +	$(gen_tests_hdr)
> +
> +# Test runner instances, one sub-make each (see Makefile.runner).
>
> -# Define test_progs-no_alu32 test runner.
> -TRUNNER_BPF_BUILD_RULE := CLANG_NOALU32_BPF_BUILD_RULE
> -TRUNNER_BPF_CFLAGS := $(BPF_CFLAGS) $(CLANG_CFLAGS)
> -$(eval $(call DEFINE_TEST_RUNNER,test_progs,no_alu32))
> +# The LLVM feature-probe results and TEST_KMODS are exported
> +# to the runner sub-makes. CC is passed explicitly instead: exporting it
> +# would also leak lib.mk's CC into the libbpf sub-build, which computes
> +# its own. ('export NAME' on an undefined
> +# variable creates an empty one, so these stay below the definitions.)
> +export LLVM_LDLIBS LLVM_LDFLAGS TEST_KMODS
> +export INHERITED_CFLAGS INHERITED_LDFLAGS
>
> -# Define test_progs-cpuv4 test runner.
> +RUNNER_MAKE := $(MAKE) -f Makefile.runner OUTPUT=$(OUTPUT) CC='$(CC)'	\
> +	       CLANG='$(CLANG)'
> +
> +# Everything a runner instance references but does not know how to build.
> +RUNNER_PREREQS := $(INCLUDE_DIR)/vmlinux.h $(BPFOBJ) $(BPFTOOL)		\
> +		  $(TRUNNER_BPFTOOL) $(RESOLVE_BTFIDS)			\
> +		  $(OUTPUT)/veristat					\
> +		  $(VERIFY_SIG_HDR) $(PRIVATE_KEY) $(VERIFICATION_CERT)	\
> +		  $(LIBARENA_SKEL) $(LIBARENA_ASAN_SKEL)		\
> +		  prog_tests/tests.h map_tests/tests.h			\
> +		  $(RUNNER_OBJS)					\
> +		  $(OUTPUT)/urandom_read $(OUTPUT)/liburandom_read.so	\
> +		  $(OUTPUT)/xdp_synproxy $(OUTPUT)/sign-file		\
> +		  $(OUTPUT)/uprobe_multi $(TEST_KMOD_TARGETS)
> +
> +# The main Makefile cannot tell whether $(OUTPUT)/test_progs is stale -
> +# only the runner sub-make knows its full dependency graph. FORCE makes
> +# the delegating rules below always run; their dependents still rebuild
> +# on mtime only.
> +FORCE:
> +
> +# The default flavor's BPF objects and skeletons are consumed here as
> +# well as inside the runner sub-makes: bench, xskxceiver, xdp_* and
> +# test_cpp depend on individual skeletons, and lib.mk's
> +# install rule copies the BPF objects. Instantiate the shared rules
> +# (Makefile.skel) for the default flavor, so those consumers depend on
> +# exactly the files they use; the unflavored runners' delegation rules
> +# below list the whole set as prerequisites, so those sub-makes find the
> +# files this Makefile owns up to date.
> +RDIR := $(OUTPUT)
> +FLAVOR :=
> +BINARY := test_progs
> +BPF_CC := $(CLANG)
> +BPF_CC_MSG := CLNG-BPF
> +BPF_SYS_INCLUDES := $(CLANG_SYS_INCLUDES)
> +BPF_CC_FLAGS := -O2 $(BPF_TARGET_ENDIAN) -mcpu=v3
> +BPF_DEFINES := -DENABLE_ATOMICS_TESTS
> +include Makefile.skel
> +
> +DEFAULT_RUNNER_ARGS := RUNNER=test_progs FLAVOR= TESTS_DIR=prog_tests	\
> +	BPF_CC='$(BPF_CC)' BPF_CC_MSG=$(BPF_CC_MSG)			\
> +	BPF_SYS_INCLUDES='$(BPF_SYS_INCLUDES)'				\
> +	BPF_CC_FLAGS='$(BPF_CC_FLAGS)' BPF_DEFINES=$(BPF_DEFINES)
> +
> +$(OUTPUT)/test_progs: $(RUNNER_PREREQS) $(BPF_OBJS) $(ALL_SKELS) FORCE
> +	+$(Q)$(RUNNER_MAKE) $(DEFAULT_RUNNER_ARGS)
> +
> +$(OUTPUT)/test_progs-no_alu32: $(RUNNER_PREREQS) FORCE
> +	+$(Q)$(RUNNER_MAKE) RUNNER=test_progs FLAVOR=no_alu32 TESTS_DIR=prog_tests \
> +		BPF_CC='$(CLANG)' BPF_CC_MSG=CLNG-BPF BPF_SYS_INCLUDES='$(CLANG_SYS_INCLUDES)'	\
> +		BPF_CC_FLAGS='-O2 $(BPF_TARGET_ENDIAN) -mcpu=v2'
> +
>  ifneq ($(CLANG_CPUV4),)
> -TRUNNER_BPF_BUILD_RULE := CLANG_CPUV4_BPF_BUILD_RULE
> -TRUNNER_BPF_CFLAGS := $(BPF_CFLAGS) $(CLANG_CFLAGS) -DENABLE_ATOMICS_TESTS
> -$(eval $(call DEFINE_TEST_RUNNER,test_progs,cpuv4))
> +$(OUTPUT)/test_progs-cpuv4: $(RUNNER_PREREQS) FORCE
> +	+$(Q)$(RUNNER_MAKE) RUNNER=test_progs FLAVOR=cpuv4 TESTS_DIR=prog_tests \
> +		BPF_CC='$(CLANG)' BPF_CC_MSG=CLNG-BPF BPF_SYS_INCLUDES='$(CLANG_SYS_INCLUDES)'	\
> +		BPF_CC_FLAGS='-O2 $(BPF_TARGET_ENDIAN) -mcpu=v4'		\
> +		BPF_DEFINES=-DENABLE_ATOMICS_TESTS
>  endif

This isn't a bug, but since DEFAULT_RUNNER_ARGS already factors the
clang argument list, would a shared CLANG_RUNNER_ARGS (with just -mcpu=
and BPF_DEFINES varying per flavor) read better than repeating
BPF_CC/BPF_CC_MSG/BPF_SYS_INCLUDES in each of the three clang flavor
recipes?

> diff --git a/tools/testing/selftests/bpf/Makefile.runner b/tools/testing/selftests/bpf/Makefile.runner
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/Makefile.runner
> @@ -0,0 +1,199 @@
> +# SPDX-License-Identifier: GPL-2.0
> +#
> +# Build one BPF test-runner instance: test_progs, one of its flavors
> +# (no_alu32, cpuv4, bpf_gcc), or test_maps.

[ ... ]

> +# Keep in sync with the CFLAGS/LDFLAGS additions in ../lib.mk, in its
> +# order (the selftests include path is spelled from srctree here; lib.mk
> +# spells it from its own directory).
> +ifneq ($(LLVM),)
> +CFLAGS += -Wno-address-of-packed-member
> +CFLAGS += -Wno-gnu-variable-sized-type-not-at-end
> +endif
> +CFLAGS += -D_GNU_SOURCE=
> +CFLAGS += -I$(srctree)/tools/testing/selftests
> +CFLAGS += $(USERCFLAGS)
> +LDFLAGS += $(USERLDFLAGS)

The runner rebuilds the CFLAGS that ../lib.mk used to add, but spells
the selftests include path from $(srctree) instead of lib.mk's
$(top_srcdir). These are not equivalent.

lib.mk derives its path from a realpath, so it is always absolute:

  tools/testing/selftests/lib.mk:61  top_srcdir = $(selfdir)/../../..
  tools/testing/selftests/lib.mk:203 CFLAGS += -I${top_srcdir}/tools/testing/selftests

$(srctree) is exported by the kernel top-level Makefile and is relative
for common cases: '.' for an in-tree build and '..' for a build in a
subdirectory of the source tree. Makefile.buildvars' fallback only fires
when srctree is empty, so it does not normalize a relative value.

The test-object recipe compiles with the working directory changed to
the output directory:

  $(Q)(cd $(@D) && $(CC) -I. $(CFLAGS) -MMD -MT $@ -c $(CURDIR)/$< $(LDLIBS) -o $(@F))

so a relative -I is resolved against $(RDIR), not against the source
tree, and the flag silently names a non-existent directory when the bpf
selftests are built through the kernel top level.

The only include in prog_tests/ or map_tests/ that needs that directory
is prog_tests/test_xsk.h's #include "../kselftest.h", and it is
satisfied earlier by COMMON_CFLAGS' -I$(CURDIR), so this does not break
today. Using an absolute spelling here would keep the runner's
compilation environment identical to the top level's in every
configuration. Was the relative-srctree case considered?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/32662817569
--===============8947748123915798385==--
