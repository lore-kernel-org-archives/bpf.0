Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D767737DAA3
	for <bpf@vger.kernel.org>; Sun, 23 Aug 2026 02:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787450490; cv=none; b=pqIzdUmnlrtZViQppKA0nXyNElNJCZC+srOGM7JdL5pEdpNanTURdiR2Xo1c/HADAKfudRXzwsz8omxadJ+T1emay/iwX35pw9ZlrjQCts4D5w8Kyh+ncYE2R5LPuMytW+g9GtdYgzua3ezdfG9z4kt/tFFoZn2Yo95EMDAsslU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787450490; c=relaxed/simple;
	bh=UE9Zi5pmTB2E7vKiifdidWmPBGzUzFyOqlt2PYF9+DA=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=dTfrOeSbZeeB9BfGMq2sssSuAI+XPZcq/j1p8vQ3m2Jc65LN9Fo6Imj18xvCloJmVY74r3dsSM1CLgtUGBVyRkkJsZc06pjONve0JvMrHhwvkQGW2c6pAttkjBLr/UFTqBoXNJFyTEMqWG9CCmXxbRaoyoQZcK3Gb90Zxau19AE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z3NVZovF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z3NVZovF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DCD81F00A3A;
	Sun, 23 Aug 2026 02:01:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787450488;
	bh=k2ZpuDLWCpTqbAXmDI8oeZXZMeQOqB1bvhah3uX0St8=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=Z3NVZovF+xJG6a0comY3oHEa4oReQWfUqA98/CKfMweDjG/q9FcZP/EtRp5Yi33rO
	 vwKAMmD27jtuziAkWq2Qhwppl0P+X3oVvqrdwkL0JXdr7F2rYreAma9YKWu19/cyYS
	 OYaaH6RKPct66JYsVurI9DKDC8c6pq7eUh6c9dzA/buYoKVca0bIYLPqy6fQIsOeB+
	 sb7C7O5RpnELudzF0YPaS9zLMM4M62W41IZ4byDxaMIXyKGPZZSo3waQGBFkdnZXt1
	 CWCLedUypNwshsMkEgc6sJxrBURJUYeG7lPujue9PTIi/E2rrEgdbWTfoQkOk8sEpO
	 IDzJn2lP4kabw==
Content-Type: multipart/mixed; boundary="===============5692812760472591581=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <55896f58afb15a9dc7885ecde76ca861854084146a31c2eacf21370411f19158@mail.kernel.org>
In-Reply-To: <20260823010900.1730708-9-nickolay.lysenko@gmail.com>
References: <20260823010900.1730708-9-nickolay.lysenko@gmail.com>
Subject: Re: [PATCH bpf-next v6 8/9] selftests/bpf: move shared build definitions into Makefile.buildvars
From: bot+bpf-ci@kernel.org
To: nickolay.lysenko@gmail.com,bpf@vger.kernel.org
Cc: ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,memxor@gmail.com,nickolay.lysenko@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Sun, 23 Aug 2026 02:01:28 +0000 (UTC)

--===============5692812760472591581==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
> index 57907859c210..fe838bb23bcd 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile

[ ... ]

> @@ -5,109 +5,21 @@ include ../../../scripts/Makefile.include
>
>  CXX ?= $(CROSS_COMPILE)g++
>
> -TOOLSDIR := $(abspath ../../..)
> -LIBDIR := $(TOOLSDIR)/lib
> -BPFDIR := $(LIBDIR)/bpf
> -TOOLSINCDIR := $(TOOLSDIR)/include
> -TOOLSARCHINCDIR := $(TOOLSDIR)/arch/$(SRCARCH)/include
> -BPFTOOLDIR := $(TOOLSDIR)/bpf/bpftool
> -APIDIR := $(TOOLSINCDIR)/uapi
> -ifneq ($(O),)
> -GENDIR := $(O)/include/generated
> -else
> -GENDIR := $(abspath ../../../../include/generated)
> -endif
> -GENHDR := $(GENDIR)/autoconf.h
> -PKG_CONFIG ?= $(CROSS_COMPILE)pkg-config

[ ... ]

> -# Check whether clang supports BPF address sanitizer (requires LLVM 22+)
> -CLANG_HAS_ARENA_ASAN := $(shell echo 'int x;' | \
> -	$(CLANG) --target=bpf -fsanitize=kernel-address \
> -	-mllvm -asan-shadow-addr-space=1 \
> -	-x c -c - -o /dev/null 2>/dev/null && echo 1)
> -
>  # Order correspond to 'make run_tests' order
>  TEST_GEN_PROGS = test_verifier test_tag test_maps test_lru_map test_progs \
>  	test_sockmap \

[ ... ]

>  include ../lib.mk
> +include Makefile.buildvars

[ ... ]

> diff --git a/tools/testing/selftests/bpf/Makefile.buildvars b/tools/testing/selftests/bpf/Makefile.buildvars
> new file mode 100644
> index 000000000000..75e4cfddeb62
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/Makefile.buildvars

[ ... ]

> +PCAP_CFLAGS	:= $(shell $(PKG_CONFIG) --cflags libpcap 2>/dev/null && echo "-DTRAFFIC_MONITOR=1")
> +PCAP_LIBS	:= $(shell $(PKG_CONFIG) --libs libpcap 2>/dev/null)
> +LDLIBS += $(PCAP_LIBS)
> +# Unlike the pre-split Makefile, this file is included after ../lib.mk
> +# (top level) or without it (runner), so COMMON_CFLAGS is prepended to
> +# preserve the original include-search order.
> +LIB_MK_CFLAGS := $(CFLAGS)
> +CFLAGS = $(COMMON_CFLAGS) $(PCAP_CFLAGS) $(LIB_MK_CFLAGS)

The comment says this preserves the original include-search order, but
does this handle inherited CFLAGS correctly?

In the pre-split Makefile, the assembly was `CFLAGS += $(COMMON_CFLAGS)
$(PCAP_CFLAGS)` executed before `include ../lib.mk`, producing:

  [env CFLAGS] [COMMON_CFLAGS] [PCAP_CFLAGS] [lib.mk additions]

After this patch, `LIB_MK_CFLAGS := $(CFLAGS)` captures the environment
value plus lib.mk's additions, and the new `CFLAGS =` puts that snapshot
last:

  [COMMON_CFLAGS] [PCAP_CFLAGS] [env CFLAGS] [lib.mk additions]

So an exported CFLAGS moves from first to after COMMON_CFLAGS/PCAP_CFLAGS.
Two observable consequences when CFLAGS is set in the environment (e.g. a
distro/packaging build where rpmbuild and dpkg-buildpackage both export
CFLAGS):

* `-O` level flips. COMMON_CFLAGS contains `$(OPT_FLAGS)`, which defaults
  to `-O0`. Previously an environment `-O2` was overridden by the
  selftests' `-O0`; now the environment `-O2` comes last and wins. Anything
  that depends on the selftests being built at -O0 by default (and on
  RELEASE=1 being the way to opt into -O2) changes behaviour.

* `-I` search order flips for environment-supplied include paths, which is
  exactly what the comment and the changelog claim is preserved. The claim
  is accurate only when CFLAGS is empty at the include point.

Separately, USERCFLAGS is no longer the final entry:
`-Wno-unused-command-line-argument` (LLVM builds) and
`-DHAS_BPF_ARENA_ASAN` are appended after it, and the matching
`LDFLAGS += $(SAN_LDFLAGS)` now lands after lib.mk's
`LDFLAGS += $(USERLDFLAGS)` instead of before it. lib.mk documents
USERCFLAGS/USERLDFLAGS as the user's extension point.

Could LIB_MK_CFLAGS capture only lib.mk's additions, or should the
comment/changelog be narrowed to say the order is preserved for lib.mk's
own additions rather than claiming it is identical?

> +
> +ifneq ($(LLVM),)
> +# Silence some warnings when compiled with clang
> +CFLAGS += -Wno-unused-command-line-argument
> +endif
> +
> +# Check whether clang supports BPF address sanitizer (requires LLVM 22+)
> +CLANG_HAS_ARENA_ASAN := $(shell echo 'int x;' | \
> +	$(CLANG) --target=bpf -fsanitize=kernel-address \
> +	-mllvm -asan-shadow-addr-space=1 \
> +	-x c -c - -o /dev/null 2>/dev/null && echo 1)

This probe moved from before the ../lib.mk include to after it, changing
which $(CLANG) it uses. Does this need to be documented?

Before the patch the probe sat at Makefile line 106, before
`include ../lib.mk` (Makefile:188), so $(CLANG) was
`tools/scripts/Makefile.include`'s `CLANG ?= clang`. After the patch it
lives in Makefile.buildvars, which is included at Makefile:101, after
../lib.mk. lib.mk:3-10 does:

  ifneq ($(LLVM),)
  ifneq ($(filter %/,$(LLVM)),)
  LLVM_PREFIX := $(LLVM)
  else ifneq ($(filter -%,$(LLVM)),)
  LLVM_SUFFIX := $(LLVM)
  endif
  CLANG := $(LLVM_PREFIX)clang$(LLVM_SUFFIX)

That `CLANG :=` overrides the `?=` default, so for `make LLVM=-22` or
`make LLVM=/opt/llvm/bin/` the probe now runs a different compiler than
it used to. The result is not cosmetic: CLANG_HAS_ARENA_ASAN gates
`LIBARENA_ASAN_SKEL := libarena/libarena_asan.skel.h` and
`CFLAGS += -DHAS_BPF_ARENA_ASAN` (Makefile.buildvars lines 170-173), and
LIBARENA_ASAN_SKEL is a member of TRUNNER_EXTRA_SOURCES. So on a host
whose default `clang` is older than the LLVM-selected one, the set of
built artifacts and the test_progs preprocessor state change with this
commit.

The new value is arguably the correct one (the BPF objects are compiled
with the post-lib.mk $(CLANG)), but two things argue for making it
explicit:

1. The changelog states "No rules or recipes are changed; definitions keep
   their order" and then calls out exactly two evaluation-time changes (the
   CFLAGS prepend and CLANG_SYS_INCLUDES becoming immediate). This is a
   third one, and unlike those two it changes what gets built.

2. The sibling probe `CLANG_CPUV4` (Makefile lines 19-21) deliberately
   stayed before ../lib.mk. After this patch the two clang capability
   probes in the same build disagree about which clang they are testing,
   which is a new inconsistency that will confuse the next person to touch
   either.

Either move CLANG_CPUV4 into Makefile.buildvars as well so both probes use
the resolved $(CLANG), or note the change in the changelog?

Regarding the commit message itself:

>     selftests/bpf: move shared build definitions into Makefile.buildvars
>
>     Move the definitions that are not rules into Makefile.buildvars:
>     output-tree layout, libbpf/bpftool binary locations,
>     BPF_CFLAGS/COMMON_CFLAGS assembly, libelf/libpcap probes, endianness
>     and clang feature detection, signing key paths, the permissive-mode
>     knob with its skip_on_fail and skip_if_missing helpers, the srctree
>     fallback, PKG_CONFIG and the libarena skeleton names.

[ ... ]

>     Definitions nothing outside the Makefile reads also stay: CXX in its
>     original place; BPFTOOLDIR, HOST_BPFOBJ, BPF_TARGET_ENDIAN, CLANG_CFLAGS
>     and VERIFY_SIG_HDR in a block right after the include, since they derive
>     from Makefile.buildvars values.

There are two small accuracy items in the final paragraph. First,
"BPFTOOLDIR, HOST_BPFOBJ, BPF_TARGET_ENDIAN, CLANG_CFLAGS and
VERIFY_SIG_HDR ... since they derive from Makefile.buildvars values" - four
of the five do (TOOLSDIR, HOST_BUILD_DIR, IS_LITTLE_ENDIAN,
CLANG_SYS_INCLUDES respectively), but `VERIFY_SIG_HDR := verification_cert.h`
(Makefile:109) is a bare literal with no dependency on anything. It was at
old Makefile line 765 and has been relocated ~650 lines earlier for no
reason the changelog gives; it could have stayed where it was, which would
have kept it next to the `$(VERIFY_SIG_HDR): $(VERIFICATION_CERT)` rule
that consumes it.

Second, "and the libarena skeleton names" in the list of what moved reads
as if all of them moved. LIBARENA_SKEL and LIBARENA_ASAN_SKEL moved;
LIBARENA_BENCH_SKEL (Makefile line ~657) stayed in the Makefile.

Could these be clarified?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/32610372822
--===============5692812760472591581==--
