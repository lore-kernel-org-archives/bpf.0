Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7B2F3D333D
	for <bpf@vger.kernel.org>; Tue,  2 Jun 2026 13:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780405402; cv=none; b=To37eZkLYzSnIv/aHHL/jQTtdHH0rfcPrk9K5HjQifBwrPaT4QY+/k/iArCl8I/H5SuaROfo4T9jcY/QKoVu2zVYR13ctNlGqvexmcGgjGushrMmZlojjDw5wiYtR/wrexbGaXLTCMxx+EDXe02wICsk9Id1YNwhfxGY11SYldg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780405402; c=relaxed/simple;
	bh=rJsmItp2I+IsMvRWdNLHtOcwfpWnzpUY+Dzn99vyML4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=CAWkBCaYRpZrib73ZzTQXpANMEzF2+7aiOw9xz3+cTyLxeOeZQibEjsv+fxZRvYnquV3WqMwJa+htq7sxuKJF1FOmO0XT66G8VNKtgAcvbGkhkjAgMRbdeZoAk4BLF21hNRRGZkRevsxwXx82o9USCNOUlkzcbSbR3pX/OdGB70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=cgMAJSjy; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="cgMAJSjy"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-68be16c61d1so8259107a12.2
        for <bpf@vger.kernel.org>; Tue, 02 Jun 2026 06:03:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1780405399; x=1781010199; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0CbjwfPGz7Z6S5cKpxIXcT7bWJOB7qDRzRoA/RSxXZI=;
        b=cgMAJSjyiAgtSalRrabl/By3vlB0q014UGw3fJhxMAWIX1R1c5VkGOuC/XtCoePwIO
         1bX3I5EiofrNmwsugi4OAQeQc3bsiLmLsTgY+VzMKLwXXjgYz9TMdAEuB983w2ZVxuIl
         vhIQe7np09CO+t6vv3IpWdZPlxNU6So8WVRk/pEu3AmXajqIrgmSd+NcAmYK4BnnsGp/
         0uYyQabryzBaLHYHVbMsrJZbq6OPqj6F0QqXkjGBWb9fd2wzHNGawlEvZ5ktmwjZZCTn
         qvLz0DclgdykNJoVRkcNlBTHXaoT+B3mOgWI1JJTngZa7plcCTsQRk+/QApVZQmaqsAh
         fT0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780405399; x=1781010199;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0CbjwfPGz7Z6S5cKpxIXcT7bWJOB7qDRzRoA/RSxXZI=;
        b=fnFM0H/wpF+fawwU7T2LmXdKfml9j1PhQV4yMqhzfPBDaQsAMcSrsBCnjlKg+GhJEf
         EYNhQazelM5lDlV63C81dP/3X/wehXOuPmuLpknlHRXljct4NU6z5HxYXFKD4f32l2Fl
         Km8XyvOMQP0UQO3zcz6GuA1QyJISEnm+bZxMndltQTDhhytCpCauXjTy8XSBGKsd4hCw
         4r1Yea4nObvxLzrZ9kLxlZNGr6VhOyPYViuSdhtWeIViqx5idTiFgbSkViRKp64HIT7M
         xUUAyDLkIFJOdXQF0/CGKWgh8jOy558pFmDtY0aAaayD30l5F7jicDOXJTDp3L32Ibxn
         z8zg==
X-Gm-Message-State: AOJu0Yzkp7IBxVJQRBCOshPM7DDxnePHRnUCXTX61UwaHwbHprqRqkf8
	buzFfDHZ0SyDG03ZHgYsqJ35SuwubbAmGyMKyiGgxJkuK1/oCx+scK4TmumYDQqUCGU=
X-Gm-Gg: Acq92OGUSbQnRoYJWtqMp+N3t6M/pCKwmJcd+zNffWOW5Q4uSrbG7wH2nCuqoCC++OL
	aZ1UAK095INqyU2/1QupuikTSu6vxHkCeuLGJWazTPiUAenuu5Fu1TZ7nuBp4+SYa3HuQovrdvc
	vFNZoMOFjeryuLljHTfaV47sqBuR5NeIP35qswdFH3KTrsbO1ML3ndjYCfaiWGZJYeZEkg0Dnr7
	ipAySw7K9fkj2zm4M1AQqIne3RqWVv7TmdFF4kjPmZB8AGuHch9Qog8irIQJiXIC4lJKkjN5Fmz
	m6+07QXCRS4/K7fC2ri2IYGjaMqbSC5gN554n4KSxhJ5NEEVwDqtvmj2o75aEXJ4ftIprJJi/9i
	dtcQEyy7x6fgj0XlG9tYdvluOtEniVlwwtdS2wO1P6cWz5D3HS39WjGOfzbE+Bh5IE3oyOL5vYy
	Lrciia8Figu063ar6XXdpnCA==
X-Received: by 2002:a05:6402:26d3:b0:68c:eb73:391a with SMTP id 4fb4d7f45d1cf-68ceb733d45mr7355871a12.11.1780405399001;
        Tue, 02 Jun 2026 06:03:19 -0700 (PDT)
Received: from localhost ([2804:7f0:b765:e15:ce28:aaff:fe86:149c])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-68ceb867d22sm3376320a12.27.2026.06.02.06.03.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 06:03:18 -0700 (PDT)
From: =?utf-8?q?Ricardo_B=2E_Marli=C3=A8re?= <rbm@suse.com>
Subject: [PATCH bpf-next RESEND v12 00/11] selftests/bpf: Tolerate partial
 builds across kernel configs
Date: Tue, 02 Jun 2026 10:02:49 -0300
Message-Id: <20260602-selftests-bpf_misconfig-v12-0-27f898b3ba26@suse.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAHnUHmoC/43STU/jMBAG4L+CcibsjL/NiQNcOcARrdDYGbdBN
 EVxqECo/32dopUiS4EebY8fv7bnq8k89pyb64uvZuRDn/v9UAYoLi+auKVhw23flYlGgDCgANv
 Mr2niPOU2vKXnXZ/jfkj9plVRSk46atNRU3a/jZz6jxP91JTSduCPaV54uHu8u79t/n7X5Pfww
 nGaj5gXA2Vuw0hD3M5T//f92VGeeJwrtn2e9uPnKfEBT/qv2Q7YQiuJlYhAyZp0k98zX8X97hT
 jIJaMXGdEYRIYCyAdkO8qRi4Zs87IwmhnCRGVMDJWjDqTUYXxHlXSwKlLtmL0gkG9zujCgOyAt
 CDnHVWMWTI/pDGFsZyYggZFCSvGnsnYwhBYx+gABauKcQtGuHXGFSYkEDF524UYKsYvGb/O+MJ
 EiVg+PSjr60shLBwJP/QfzFAnQZDE8jimhvBcaO5kLoEsuahSt+yd4/H4D5vX6EnQAwAA
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1780405395; l=11389;
 i=rbm@suse.com; h=from:subject:message-id;
 bh=rJsmItp2I+IsMvRWdNLHtOcwfpWnzpUY+Dzn99vyML4=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgguRCc5X8/UX9M40lkMnr//aFGOhce
 x5ezt8MFNUFlqYAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QCvp45dsT9eotFjwweBoT25rLKWkQVQaU7hfj5yBNZRJL1vCP23jcS45Bl6gTUGeJNVu2JpEVj9
 g2LAGiv7acA4=
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

This produces a test_progs binary with 592 subtests, against the total of
727. Many of them will still fail or be skipped at runtime due to lack of
symbols, but at least there will be a clear way of building the tests.

[1]: https://openqa.opensuse.org/tests/5811715
[2]: https://openqa.opensuse.org/tests/5811730
[3]: https://src.opensuse.org/rmarliere/kselftests
[4]: https://github.com/openSUSE/kernel-qe/blob/main/kselftests_known_issues.yaml
[5]: https://openqa.opensuse.org/tests/5811730/logfile?filename=run_kselftests-config_mismatches.txt

---
Changes in v12:
- Rebase from 11 to 8 commits: split the test_kmods KDIR patch into a
  pure KDIR fix (no PERMISSIVE) and a separate tolerance patch; squash
  the BPF_STRICT_BUILD toggle with its first PERMISSIVE user; squash
  the four test_progs partial-build patches into one; move the install
  fix to immediately follow the first PERMISSIVE user
- Link to v11: https://patch.msgid.link/20260430-selftests-bpf_misconfig-v11-0-e11f7a8c4fdc@suse.com

Changes in v11:
- Gate the BTFIDS pretty-print on $(filter 1,$(V)) so V=0 and V=2 still
  print the marker; only V=1 suppresses it (patch 6)
- Use asm volatile ("") in the uprobe_multi_func_{1,2,3} weak stubs to
  match the strong definitions in prog_tests/uprobe_multi_test.c
  (patch 10)
- Link to v10: https://patch.msgid.link/20260430-selftests-bpf_misconfig-v10-0-cd302a31af16@suse.com

Changes in v10:
- Drop $(wildcard $^) from the bench link recipe so cc fails cleanly on
  the first missing input and the || fallback emits one SKIP-LINK line
  instead of a wall of undefined-reference errors; also makes make -n
  accurate (patch 9)
- Include <alloca.h> in testing_helpers.c for alloca() (patch 10)
- Link to v9: https://patch.msgid.link/20260429-selftests-bpf_misconfig-v9-0-c311f06b4791@suse.com

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
 tools/testing/selftests/bpf/testing_helpers.c      |  18 +++
 tools/testing/selftests/bpf/testing_helpers.h      |   1 +
 9 files changed, 226 insertions(+), 95 deletions(-)
---
base-commit: b93c55b4932dd7e32dca8cf34a3443cc87a02906
change-id: 20260401-selftests-bpf_misconfig-4c33ef5c56da

Best regards,
--  
Ricardo B. Marlière <rbm@suse.com>

