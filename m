Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58C7637C924
	for <bpf@vger.kernel.org>; Thu, 16 Apr 2026 12:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776342097; cv=none; b=cHY4AKSAW8SAIHo5KpNYvTdVkgmClPB/EmdcfqTifF8dp/plddNDiF5Igx2QKFjft8wcEVhhG3pteevNlblsiXdNJyihgllvmu/qT9iFEoLLofSQMbK+3UmbrRwoaRWM6YcpVpuSI6Nuy7ZUPNWxGPJsZz0clTyWsF9rkAHJQ7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776342097; c=relaxed/simple;
	bh=aFMfy235NadKRoXDD8SkRdUsVFyQgdSOUFZTSrN0W9A=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=IxAocgii2x3e1Drvph9Db/C+r63DZ3heYJzD6Op2oLEydJM8Bh8iBanNMmoff6Q3jvDLCMYihhxOzC9BptOsj56hux9gREGByyqu7o4x3Hv/NVqb6rSCozUCK1DpQgsfBezs+d+9J5S7hn62+kOz63JBIsBPPGiO0R20hQjPZeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=P+AqTHb2; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="P+AqTHb2"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-488b3f8fa2bso5700525e9.1
        for <bpf@vger.kernel.org>; Thu, 16 Apr 2026 05:21:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1776342093; x=1776946893; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=R+K+lZ/LpIxF9orBTJ08OrUHOhfiRF/rFqyHa5p603o=;
        b=P+AqTHb2JjAEwAUVTS5+1poYXrA+7+Sc8NPqro3EKmQPV09ftJ+vhjQx4yevX4kg5x
         4xkRBNYDGDA8wqNp3aZt14WaALiaYSkwQnMGvgoAavWYXE7PATYtuPp7HJK9mvZxSQca
         cBO603N4UkwEPvokOc1KfTjVs6CRH55gUyGZVGkknK9A/gjEpBNiPQLA+9kX00+MW3nI
         6fPXX3jWIb+gJ8USmpljNjgXvGyuXMmQrawp50QJnAvq42vtrdsvRbgIlcKzZjxWIKTH
         X0ofhMRC98f7GdQwscsTANlp3pa5NIqDOEGbhTYuW9mkRYsCST6XNPqHZWiGq4NKRKjk
         C+Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776342093; x=1776946893;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R+K+lZ/LpIxF9orBTJ08OrUHOhfiRF/rFqyHa5p603o=;
        b=ihBfSqQTH03xaas3mC7rlxgMMYjMkFcUfWfgyZbb9mnrLkgTh/LmUQO1juRZaJncnN
         mYcsooZrZ09REMSHpMcE7rjlxpxEY8V4WCQNQpeuK0aDyuwu7Untv8Vw5fLOy6+ARatw
         tXT1meDudojqEvtod+mFE/tPQjL+7u2fMjHP5hy9eVpusd/OmfsZ/tvSrQwEOhFFvHaj
         +V920FH7hQq3dcqFi8vpe7TB3h4euOMNlU8wSZunjXXPiH2xlSdugDaYAnHXX/nUGkgm
         HcjAKK6zxOz0cBBpHheaNatBcmIFAr8vRodUzMT1Qzes1HBNfuvOoFKlYWaJRozXNxlt
         5q2g==
X-Gm-Message-State: AOJu0YwF9tfrrJXcbZHCCUaYRwSUDhiDBIeAQP49QiWl7B6rIwviuJvC
	2J9bIPMf88YOcczxOQjirpPlEF2pgMfRk8ntzi/Wk5lNaCuOffFbo2/QwGjQMaHdmQY=
X-Gm-Gg: AeBDieurAS+8Yuafaz9uCG1za/weN2kW9QLbVKx8U1pKAVVVYMJnMSrOuyCA9ZQjC81
	sgtnDr4o5YL/YHpLz0F/8Whz+rMgW2EZZ+2eHsvCoPrvILMYO9pCoPz+EhLhPZyVoPcHBriS0hZ
	UKWJKyCfzFQzLStrk47fUF5wgmxf5NrhCaxVptZaL11l62LwYwNzBBvAap/LqrrIdlyRuadcKWO
	/f2YCSzoEcfXhXWdI1lbiXi4bl6Cx+jC5y3JPZctoesXgLQY3CRenqTcxmXLrnRcBPlO11I1yWm
	S8x8+GgKQYcUmiQ3RMYqBl+QBXFJg0tpn8/19dKMjMgDSS44Fpn5n6+m45V+NXgxB9SGAsxwTCo
	nxmyJZtMSTZNqgyX8bS+saryu5HcgHTMFImiGnCMMeekMbhN5jZmmWNYbfkMD5+qzRLV8EkuBsC
	xKe1StKQFLyXA=
X-Received: by 2002:a05:600c:a216:b0:488:8be1:ca3a with SMTP id 5b1f17b1804b1-488f47f247dmr29688655e9.15.1776342092627;
        Thu, 16 Apr 2026 05:21:32 -0700 (PDT)
Received: from localhost ([2804:7f0:b765:e41:ce28:aaff:fe86:149c])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2de8c10ad3dsm7428385eec.3.2026.04.16.05.21.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2026 05:21:31 -0700 (PDT)
From: =?utf-8?q?Ricardo_B=2E_Marli=C3=A8re?= <rbm@suse.com>
Subject: [PATCH bpf-next v6 00/11] selftests/bpf: Tolerate partial builds
 across kernel configs
Date: Thu, 16 Apr 2026 09:21:17 -0300
Message-Id: <20260416-selftests-bpf_misconfig-v6-0-7efeab504af1@suse.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAD3U4GkC/43O3WqEMBAF4FdZct20+Vd71fcopYxxsqZUXTKub
 Fl890ZLQQRpL2fmzMe5M8IUkdjz6c4STpHi0OfBPZyYb6E/I49NnpkSygkjJCf8DCPSSLy+hPc
 ukh/6EM/ceK0xWG9dAyx/XxKGeFvlV5ajvMfbyN5+LnStP9CPC7xkayDkdYLet8vqN/3UAY2Yl
 kQbaRzS11pzkqv5Z6NJcsE1oFFeQChceKEr4aMfurXGpLaMPmZUZoJwhRC6FFA1O0ZvGXfM6Mz
 YsgAppVFO+x1j/smYzFSVNMEKDE0odozdMNIeMzYzQjcCrIKyKmHDzPP8DRMGvQoXAgAA
X-Change-ID: 20260401-selftests-bpf_misconfig-4c33ef5c56da
To: Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1776342088; l=7716;
 i=rbm@suse.com; h=from:subject:message-id;
 bh=aFMfy235NadKRoXDD8SkRdUsVFyQgdSOUFZTSrN0W9A=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgguRCc5X8/UX9M40lkMnr//aFGOhce
 x5ezt8MFNUFlqYAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QOJ1R3ACMjFKDZ55i9avz+4DHzUqh3Y0QihDBMMf7TuYWrSRwLAf6Oqh9IhWXP84Ayte8iuKejE
 lGj+sbx01Pgs=
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

This produces a test_progs binary with 583 subtests, against the total of
714. Many of them will still fail or be skipped at runtime due to lack of
symbols, but at least there will be a clear way of building the tests.

[1]: https://openqa.opensuse.org/tests/5811715
[2]: https://openqa.opensuse.org/tests/5811730
[3]: https://src.opensuse.org/rmarliere/kselftests
[4]: https://github.com/openSUSE/kernel-qe/blob/main/kselftests_known_issues.yaml
[5]: https://openqa.opensuse.org/tests/5811730/logfile?filename=run_kselftests-config_mismatches.txt

Assisted-by: {codex,claude}
Tested-by: Alan Maguire <alan.maguire@oracle.com>
Signed-off-by: Ricardo B. Marliere <rbm@suse.com>
---
Changes in v6:
- Add --ignore-missing-args to -extras rsync so out-of-tree permissive
  builds do not abort when .ko files are absent (patch 2)
- Remove stale skeleton headers in early-exit paths when .bpf.o is
  missing on incremental builds (patch 3)
- Fix strict-mode skeleton rules: use && before temp file cleanup so
  bpftool failures are not masked by rm -f exit code (patch 3)
- Track test filter selection separately from not_built so -t/-n flags
  are respected for unbuilt tests (patch 7)
- Make TRUNNER_TEST_OBJS order-only only in permissive mode, preserving
  incremental relinking in strict builds (patch 8)
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

 tools/testing/selftests/bpf/Makefile               | 165 ++++++++++++++-------
 .../testing/selftests/bpf/prog_tests/bpf_cookie.c  |  17 ++-
 tools/testing/selftests/bpf/prog_tests/iters.c     |   3 +-
 tools/testing/selftests/bpf/prog_tests/test_lsm.c  |  22 ---
 tools/testing/selftests/bpf/test_kmods/Makefile    |  24 ++-
 tools/testing/selftests/bpf/test_progs.c           |  50 ++++++-
 tools/testing/selftests/bpf/test_progs.h           |   1 +
 tools/testing/selftests/bpf/testing_helpers.c      |  17 +++
 tools/testing/selftests/bpf/testing_helpers.h      |   1 +
 9 files changed, 208 insertions(+), 92 deletions(-)
---
base-commit: 1f5ffc672165ff851063a5fd044b727ab2517ae3
change-id: 20260401-selftests-bpf_misconfig-4c33ef5c56da

Best regards,
--  
Ricardo B. Marlière <rbm@suse.com>

