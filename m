Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ADBB149C7B
	for <bpf@vger.kernel.org>; Wed, 29 Apr 2026 14:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777473244; cv=none; b=c/HCCjCdYnJSl9mLWWuHKYdwV2fDGUi1QsUUh1Vbk9Y37kjBHRiWf49QlSmgGyajS7Xamd6pYbXTpOR2G78X2HeNhYIdAtNLC/yuaIHKfjLp2AnPyKOC1A0wVr+EYzwC62hiFrH4BxR1uihob7I4pYgGUog1RaGsJZT3fJYvVXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777473244; c=relaxed/simple;
	bh=Onck2A9kuvyxA3Ckz5w9SOkb+sBXBeX3IvicFlfl4B0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=UMEERmL4V324cOM4SRQc5D2elB01VUL/NlWel5btAA5doyDF5tco+KErof/7aV30zlHfdhhXM4vqBfjlYQTGWhan5N5ljvR+oacyYJmRsUblToeSOsWBoREL3X2ovsMvMjz8/XmNanL4lAcWGoerMc3LpLa2islt3QaM3HQRglk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=EnlZ9Z2W; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="EnlZ9Z2W"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-483487335c2so124990445e9.2
        for <bpf@vger.kernel.org>; Wed, 29 Apr 2026 07:34:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1777473241; x=1778078041; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zYWd8DzHDTVwvddvghcLTXOoR8SxE1D9Qd52QojVIBA=;
        b=EnlZ9Z2WTqc9QIp4yGIHOslrHU2/3ueTStFpokXp00kIPuEKRDpst2IyLkBzbG6dQY
         8LUJjCT+eH8koxTZsYbhyweXoZNzBu30C5cNX/XkQhxWqlu1nygq7hWdc/mfyjojbXzU
         9pdSI2kQ88jts/9gduhqtoVyENutzV/wb+yqgmSv/Sv1Tznl68iFkP0mNhaQZFlk7DiZ
         89gpraQbuxG0V7gDL4hpfKcOg7Lp0Y41k9UvzmGjzLjUN6NPVreuAcy4wx84MaZEtoss
         IIrD/WgtN8RWADR0GE+b7obUMM4haLKNuMG/ZgGebKIEN4b6omooYrD70hiNEym605y/
         sMww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777473241; x=1778078041;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zYWd8DzHDTVwvddvghcLTXOoR8SxE1D9Qd52QojVIBA=;
        b=pK0kuE+V+3kMqY04IThLWj1r+qIRplnPzHqOD6zAG0JL6T+33kTY6jwGOBeHZmlBHh
         P6a+Mq1KBB3x6fuMVZzT3aVx6xbx5VgfqHGJtcegA4CfVsO3iOHaZ55/9e425eAs9QDY
         jBGQi1Z9x1JY/hVeveEi1e92zjwOE176+UN4GjlnqHtLvtPFaNTNtYx93QLyYzVpB4eZ
         2z3qXaQfQ5n1N0R+4OMAjfRZug58OloSpXs7lV6cXDCXh5xmEZR4ODJbd3V13Mm2KmL5
         vPBOLyHJvlL7KvsWP7Jy6X4rRoCrAdjXDpxyk672No5ExOwFGpVyjx3GOYCdrH/aEOKb
         2rWw==
X-Gm-Message-State: AOJu0Yy9xjeu4JQontePMqKHgl25A0QOxotYD+dox659sussq4BVDNOW
	1c2PlwjjgcebPzeK8ymaqnsDxJmcoJAflX+uXZtgTlA8jW6YigJgDKj5xf/wKwGCx7w=
X-Gm-Gg: AeBDiev1kmc37TFar02lxUolrOzGZVuXhHe9Be2ItalFGhqNaAyTrN3s2XYdikZL/LS
	N+WFkNWcLyP+jtOOQ5HERFF4JqrYdCgbT6tdiyZbWzc9bfoWbDHScxJKHdWp+8E9pEDpKVjWLkX
	oH5vhSmbwpuHs1fbjTedw9e2voR77bBXy/5JkNO42QSR4g5p16/h8xAWL+7JBZW6U78ectOOcei
	3sBrGgqu5EDOMCedwupgI5j4yBh8jyEZVZVAxCb26uxOeTnj9XjmGGHHM09emYM3nmSS6uRwQhF
	P61pRXY3VTtLFel1f4sSaq4/D8ZCiyVg8TKU2aMTMKr9G307mdGlFFfaa+/rhaGcpfnJAq3qcPJ
	2WH+Atr8pOVMHq3mT84ViayIkeCy3tPk3MOlNwQYkC8xnEs0zuriyUJbRdLSpZvc/i8b0QT/1q0
	DB/0VnP+lEiG0jSDqLxJLVrf7S
X-Received: by 2002:a05:600c:c048:b0:489:1ae1:4eb9 with SMTP id 5b1f17b1804b1-48a77b233e4mr80077815e9.28.1777473241313;
        Wed, 29 Apr 2026 07:34:01 -0700 (PDT)
Received: from localhost ([2804:7f0:b765:105d:ce28:aaff:fe86:149c])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-62982135605sm1206762137.1.2026.04.29.07.33.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 07:33:59 -0700 (PDT)
From: =?utf-8?q?Ricardo_B=2E_Marli=C3=A8re?= <rbm@suse.com>
Subject: [PATCH bpf-next v9 00/11] selftests/bpf: Tolerate partial builds
 across kernel configs
Date: Wed, 29 Apr 2026 11:33:42 -0300
Message-Id: <20260429-selftests-bpf_misconfig-v9-0-c311f06b4791@suse.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAMYW8mkC/43O3U7DMAwF4FeZck3A+U+54j0QQk7qbEWsnZquG
 pr27qRFSFWlwi5tH386V5apbyiz592V9TQ2uenaMlQPOxYP2O6JN3WZmQRpQYPgmT7TQHnIPJz
 S+7HJsWtTs+c6KkXJRGNrZOX71FNqLrP8ykqUt3QZ2NvPJZ/DB8VhgqdswEw89NjGw7T6TT8dM
 Q/UT4lDk4eu/5prjmI2/200Cg5cIWkZAZOz6SWfMz3G7jjXGOWSUduMLEwC6wCUB6zqFaOWjN1
 mVGGMdyiE0NKquGL0nYwuTFUJnQxQqpNbMWbBCLPNmMKAqgGNRF95XDF2yfzRxhbGUSIMBjQms
 WLcnYwrDILzJDwISXrF+AUj/TbjCxMSyJgqV4cYFsztdvsGROgnD+wCAAA=
X-Change-ID: 20260401-selftests-bpf_misconfig-4c33ef5c56da
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 Shuah Khan <shuah@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>
Cc: bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev, 
 Alan Maguire <alan.maguire@oracle.com>, 
 "Ricardo B. Marliere" <rbm@suse.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1777473237; l=10103;
 i=rbm@suse.com; h=from:subject:message-id;
 bh=Onck2A9kuvyxA3Ckz5w9SOkb+sBXBeX3IvicFlfl4B0=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgguRCc5X8/UX9M40lkMnr//aFGOhce
 x5ezt8MFNUFlqYAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QEh/sUMAtVkikL9XGLrzNUaJLU27fFXsw4IhFJKPgnxjos1Ld9rga0VQ1Q+NltlOgAZu87jWLnZ
 G8JfUfCSlYwI=
X-Developer-Key: i=rbm@suse.com; a=openssh;
 fpr=SHA256:pzhe0fJpYLz+3cZ33FFPhIfaUElk9CXPFFXmalIH+1g

Currently the BPF selftests can only be built by using the minimum kernel
configuration defined in tools/testing/selftests/bpf/config*. This poses a
problem in distribution kernels that may have some of the flags disabled or
set as module. For example, we have been running the tests regularly in
openSUSE Tumbleweed [1] [2] but to work around this fact we created a
special package [3] that build the tests against an auxiliary vmlinux with
the BPF Kconfig. We keep a list of known issues that may happen due to,
amongst other things, configuration mismatches [4] [5].

The maintenance of this package is far from ideal, especially for
enterprise kernels. The goal of this series is to enable the common usecase
of running the following in any system:

```sh
make -C tools/testing/selftests install \
     SKIP_TARGETS= \
     TARGETS=bpf \
     BPF_STRICT_BUILD=0 \
     O=/lib/modules/$(uname -r)/build
```

As an example, the following script targeting a minimal config can be used
for testing:

```sh
make defconfig
scripts/config --file .config \
               --enable DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT \
               --enable DEBUG_INFO_BTF \
               --enable BPF_SYSCALL \
               --enable BPF_JIT
make olddefconfig
make -j$(nproc)
make -j$(nproc) -C tools/testing/selftests install \
     SKIP_TARGETS= \
     TARGETS=bpf \
     BPF_STRICT_BUILD=0
```

This produces a test_progs binary with 585 subtests, against the total of
717. Many of them will still fail or be skipped at runtime due to lack of
symbols, but at least there will be a clear way of building the tests.

[1]: https://openqa.opensuse.org/tests/5811715
[2]: https://openqa.opensuse.org/tests/5811730
[3]: https://src.opensuse.org/rmarliere/kselftests
[4]: https://github.com/openSUSE/kernel-qe/blob/main/kselftests_known_issues.yaml
[5]: https://openqa.opensuse.org/tests/5811730/logfile?filename=run_kselftests-config_mismatches.txt

---
Changes in v9:
- Also pass KBUILD_OUTPUT=$(KMOD_O_VALID) when invoking kbuild so an
  inherited command-line KBUILD_OUTPUT cannot disagree with O= (patch 2)
- Note BPFOBJ remains a normal prereq intentionally (patch 5)
- Sub-shell isolate cd/CC and use $@ for $(RM); gate the BTFIDS
  pretty-print on $(V) so verbose mode does not double-print (patch 6)
- Restrict permissive compile-failure tolerance and partial-link to
  test_progs%; runners with strong cross-object references (test_maps)
  keep strict semantics (patches 6 and 8)
- Link to v8: https://patch.msgid.link/20260428-selftests-bpf_misconfig-v8-0-bf02cf97dbcb@suse.com

Changes in v8:
- In permissive mode, keep source changes to already-built tests
  triggering relinks, while using recipe-time $(wildcard ...) to pick
  up fresh .test.o files without duplicate linker inputs (patch 8)
- Resolve relative O=/KBUILD_OUTPUT before recursing into test_kmods,
  and only treat it as a kernel build dir when it contains
  Module.symvers (patch 2)
- Note in the commit message that PERMISSIVE-mode bisecting here needs
  the next two patches (patch 6)
- Clarify in the commit message that order-only skeleton prereqs do not
  break the new-skel-via-local-header case (patch 5)
- Exclude not-built tests from the success count so summary and JSON
  report them only as skipped (patch 7)
- Tighten commit messages for accuracy and clarity
- Link to v7: https://patch.msgid.link/20260416-selftests-bpf_misconfig-v7-0-a078e18012e4@suse.com

Changes in v7:
- Use $(abspath) for KMOD_O so relative O= paths resolve correctly
  when make -C changes directory (patch 2)
- Guard make clean against missing KDIR unconditionally; there is
  nothing to clean when kernel headers are absent (patch 2)
- Drop explicit $(TRUNNER_TEST_OBJS) from linker filter in strict mode;
  $^ already contains them as normal prerequisites (patch 8)
- Link to v6: https://patch.msgid.link/20260416-selftests-bpf_misconfig-v6-0-7efeab504af1@suse.com

Changes in v6:
- Add --ignore-missing-args to -extras rsync so out-of-tree permissive
  builds do not abort when .ko files are absent (patch 2)
- Use $(abspath) for KMOD_O so relative O= paths resolve correctly
  when make -C changes directory (patch 2)
- Guard make clean against missing KDIR unconditionally so cleaning
  does not abort when kernel headers are absent (patch 2)
- Remove stale skeleton headers in early-exit paths when .bpf.o is
  missing on incremental builds (patch 3)
- Fix strict-mode skeleton rules: use && before temp file cleanup so
  bpftool failures are not masked by rm -f exit code (patch 3)
- Track test filter selection separately from not_built so -t/-n flags
  are respected for unbuilt tests (patch 7)
- Make TRUNNER_TEST_OBJS order-only only in permissive mode, preserving
  incremental relinking in strict builds (patch 8)
- Drop explicit $(TRUNNER_TEST_OBJS) from linker filter in strict mode;
  they are already in $^ as normal prerequisites (patch 8)
- Reorder: move skip-unbuilt-tests patch before partial-linking patch
  for bisectability
- Link to v5: https://patch.msgid.link/20260415-selftests-bpf_misconfig-v5-0-03d0a52a898a@suse.com

Changes in v5:
- Add BPF_STRICT_BUILD toggle as patch 1 so every subsequent patch
  gates tolerance behind PERMISSIVE from the start, making the series
  bisectable with strict-by-default at every point
- Fix O= commit message; make parent cp conditional (patch 2)
- Tolerate linked skeleton failures (patch 3)
- Skip feature detection for emit_tests (patch 4)
- Clarify bench is all-or-nothing in commit message (patch 8)
- Move stack_mprotect() to testing_helpers.c, drop weak stubs (patch 9)
- Report not-built tests as "SKIP (not built)" in output (patch 10)
- Drop overly broad 2>/dev/null || true from install rsync; rely solely
  on --ignore-missing-args which already handles absent files (patch 11)
- Link to v4: https://patch.msgid.link/20260406-selftests-bpf_misconfig-v4-0-9914f50efdf7@suse.com

Changes in v4:
- Drop the test_kmods kselftest module flow patch: lib.mk gen_mods_dir
  invokes $(MAKE) -C $(TEST_GEN_MODS_DIR) without forwarding
  RESOLVE_BTFIDS, breaking ASAN and GCC BPF CI builds (Makefile.modfinal
  cannot find resolve_btfids in the kbuild output tree)
- Link to v3:
  https://patch.msgid.link/20260406-selftests-bpf_misconfig-v3-0-587a1114263c@suse.com

Changes in v3:
- Split test_kmods patch into two: fix KDIR handling (O= passthrough,
  EXTRA_CFLAGS/EXTRA_LDFLAGS clearing) and wire into lib.mk via
  TEST_GEN_MODS_DIR
- Pass O= through to the kernel module build so artifacts land in the
  output tree, not the source tree
- Clear EXTRA_CFLAGS and EXTRA_LDFLAGS when invoking the kernel build to
  prevent host flags (e.g. -static) leaking into module compilation
- Replace the bespoke test_kmods pattern rule with lib.mk module
  infrastructure (TEST_GEN_MODS_DIR); lib.mk now drives build and clean
  lifecycle
- Make the .ko copy step resilient: emit SKIP instead of failing when a
  module is absent
- Expand the uprobe weak stub comment in bpf_cookie.c to explain why
  noinline is required
- Link to v2:
  https://patch.msgid.link/20260403-selftests-bpf_misconfig-v2-0-f06700380a9d@suse.com

Changes in v2:
- Skip test_kmods build/clean when KDIR directory does not exist
- Use `Module.symvers` instead of `.config` for in-tree detection
- Fix skeleton order-only prereqs commit message
- Guard BTFIDS step when .test.o is absent
- Add `__weak stack_mprotect()` stubs in `bpf_cookie.c` and `iters.c`
- Link to v1:
  https://patch.msgid.link/20260401-selftests-bpf_misconfig-v1-0-3ae42c0af76f@suse.com

To: Alexei Starovoitov <ast@kernel.org>
To: Daniel Borkmann <daniel@iogearbox.net>
To: Andrii Nakryiko <andrii@kernel.org>
To: Martin KaFai Lau <martin.lau@linux.dev>
To: Eduard Zingerman <eddyz87@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: Song Liu <song@kernel.org>
To: Yonghong Song <yonghong.song@linux.dev>
To: Jiri Olsa <jolsa@kernel.org>
To: Shuah Khan <shuah@kernel.org>
To: Nathan Chancellor <nathan@kernel.org>
To: Nick Desaulniers <nick.desaulniers+lkml@gmail.com>
To: Bill Wendling <morbo@google.com>
To: Justin Stitt <justinstitt@google.com>
Cc: bpf@vger.kernel.org
Cc: linux-kselftest@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: llvm@lists.linux.dev
Assisted-by: {codex,claude}
Tested-by: Alan Maguire <alan.maguire@oracle.com>
Signed-off-by: Ricardo B. Marliere <rbm@suse.com>

---
Ricardo B. Marlière (11):
      selftests/bpf: Add BPF_STRICT_BUILD toggle
      selftests/bpf: Fix test_kmods KDIR to honor O= and distro kernels
      selftests/bpf: Tolerate BPF and skeleton generation failures
      selftests/bpf: Avoid rebuilds when running emit_tests
      selftests/bpf: Make skeleton headers order-only prerequisites of .test.d
      selftests/bpf: Tolerate test file compilation failures
      selftests/bpf: Skip tests whose objects were not built
      selftests/bpf: Allow test_progs to link with a partial object set
      selftests/bpf: Tolerate benchmark build failures
      selftests/bpf: Provide weak definitions for cross-test functions
      selftests/bpf: Tolerate missing files during install

 tools/testing/selftests/bpf/Makefile               | 177 ++++++++++++++-------
 .../testing/selftests/bpf/prog_tests/bpf_cookie.c  |  17 +-
 tools/testing/selftests/bpf/prog_tests/iters.c     |   2 -
 tools/testing/selftests/bpf/prog_tests/test_lsm.c  |  22 ---
 tools/testing/selftests/bpf/test_kmods/Makefile    |  30 +++-
 tools/testing/selftests/bpf/test_progs.c           |  53 +++++-
 tools/testing/selftests/bpf/test_progs.h           |   1 +
 tools/testing/selftests/bpf/testing_helpers.c      |  17 ++
 tools/testing/selftests/bpf/testing_helpers.h      |   1 +
 9 files changed, 225 insertions(+), 95 deletions(-)
---
base-commit: 9f5b3ffc3f1dac7204e32eeeff84bc5cc55c393e
change-id: 20260401-selftests-bpf_misconfig-4c33ef5c56da

Best regards,
--  
Ricardo B. Marlière <rbm@suse.com>

