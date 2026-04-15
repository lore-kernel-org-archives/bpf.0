Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35A6D38B7C9
	for <bpf@vger.kernel.org>; Wed, 15 Apr 2026 20:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776286773; cv=none; b=bofwEInnOLyI0NFT+03gw8knFmZRtLtyssY4pEpAOkRzCJ4SukM9Zwy/tWbvCL8Op4dyQg98/JnlRJdd0z12DcY03wSqdLE51oWZ8yM9Xflc8rbeGc6Q0uoti5e5eAqT+BQDhPy1T+3IUzuH6AANHhjpKGC4zdyy3DjN3dW5xPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776286773; c=relaxed/simple;
	bh=C5gBCOFN02YFIPa38DguA50umMdPOwESOAOxPNJ9NUA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Kbv6Mb9YeSLg0hMr9tmC71q2XcSSZfF0K0mMliDX/f0Ufx3cBOwOZxTAJTTtUsW4EmrKqzwb5gjeUsH7WtbCHRXSjoibEIu8eGMKWFOXsbvtpuOmVySXgxZl0qhqIOOm8uLSnKSfPUdEUJP+37Uxdq0hwRmqVTU7d0WKimpiEtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=VDO/C2Xr; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="VDO/C2Xr"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4888375f735so72230765e9.3
        for <bpf@vger.kernel.org>; Wed, 15 Apr 2026 13:59:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1776286769; x=1776891569; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DO9HplCybn97GiKk5RDH2mrlnKl7NOYl76LLXkcuT3o=;
        b=VDO/C2XrvyaT9qnR0KBzGDJdbBtQbFCbYGkYSOILMY/SizWIB6uFZaTyI9lM7fOUeO
         K/w5brHCPf2tZcueLE4d2i1h4STdYJvEJDBv2dduwotVgrWLCSChlj6f46c+rjPFhZI7
         mJUt6ZWFW/Htv/6QSgH/p7hj2SbXt3wrRg9PSqus863wHXC+/snhVxeismac9kdFu3TG
         +tuVy7vdO61UQkoUcIZwDCCMuHD4yqYWXf3sxsufewJIezskftwM2Q1rmcePslbMME6y
         3H42BsQ/m5VCetTGoOnfKt4YDIh2mI3bCG4+Sn0ZeOd6fHnx3z3/Nb3W/2Q7OzZf+8dM
         FQgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776286769; x=1776891569;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DO9HplCybn97GiKk5RDH2mrlnKl7NOYl76LLXkcuT3o=;
        b=Xbz9DoSAjOvqMPcQojujvF0OV7B6kdUubspjUwA0IZNgNPB6HVgnR6WwSypBV8rDOX
         tBQiEyl+MEdYdoJdrAIMveZQoQSZC1JTLxLvH8FxJBbtPaRoqpJkWR+EBDV03J7ZEHVj
         kc3lvubOnCVHhGkUHiISKSZyfdi3zXIsdtO2NL0nz4zIremeKIaHpnztUMnBmAOr1M5Z
         WB8NcisZnMG0Mdng5RoOhGyHny5KNBEL9GVvXBDvZ/tHsmTywPQga8lEGeGGaLbrQr66
         iWqIun0CMqu51C5IkoTJPJPTh3wB9r1IkZ4YmFfSa+CaDHGXt3JAs2njQryumBHiz08k
         FfaA==
X-Gm-Message-State: AOJu0YxxaMfYdjSgG378e4iNAJ+KoAGflQfmTK8/D2xlEKvOFwsTWQI0
	7Ce84wiyIbPj5/kuVcTukQcAYp2/FvUEaS7cMf5cr+F5I2pCH1CCzKA/8iCumeMGI2I=
X-Gm-Gg: AeBDietrfWpRdR7RPjVX4a6EY/tb16i+ywE3WC7nttDyVil/6isoOHot1j0Te6sZV2g
	FR0NpVb3rOI/Kk7bHcaR0DAQQAb7eDuhp6gJ+3pL1YeE/1dACWQJeWEivqYawFVb5RTWmhe87K6
	vJwv19dir/BQWIMgeAutEw/0D6SDPd16HPagXVQuLUHOQVOeqevjJa4KKYAQ/3WwnVlkDz8SFSI
	wcG9I4jGe+3tgwgumw5ASXNeA52fKdN0v/lECZ5XWjEZoAxS5g5MzVERuIBvOSfoNQa6TVUZJvi
	MUyy6/WhNhYvqta208qziJY8anT0nQrEGLruT1pHbNlfotZmSWo2mZMfIEITvzQJJZWqkWvK2Kq
	eWLWeT4XPABxEm2Lf3UlcX+QcQ8aIl638J1n1+yf/bjFdxz4VzWDnP49gPhaPHhhCU49qXa/CHz
	SwwiRETBHiymcDQ0Q0pOZvbg==
X-Received: by 2002:a05:600d:d:b0:488:d243:8da9 with SMTP id 5b1f17b1804b1-488d67b8cf3mr246577685e9.1.1776286769537;
        Wed, 15 Apr 2026 13:59:29 -0700 (PDT)
Received: from localhost ([2804:7f0:b765:e41:ce28:aaff:fe86:149c])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2de8eb8443csm4463723eec.14.2026.04.15.13.59.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 13:59:28 -0700 (PDT)
From: =?utf-8?q?Ricardo_B=2E_Marli=C3=A8re?= <rbm@suse.com>
Subject: [PATCH bpf-next v5 00/11] selftests/bpf: Tolerate partial builds
 across kernel configs
Date: Wed, 15 Apr 2026 17:59:18 -0300
Message-Id: <20260415-selftests-bpf_misconfig-v5-0-03d0a52a898a@suse.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIACf832kC/43O3WrDMAwF4Fcpvp43/6fZ1d5jlOE4UuOxJMVyQ
 0vJu8/JGIRC2S4lHX2cGyNIEYi97m4swRQpjkMZ7NOOhc4PR+CxLTNTQjlhhOQEX5iBMvHmhB9
 9pDAOGI/cBK0BbbCu9ax8nxJgvKzyOytRPsAls8PPhc7NJ4S8wEu28QS8SX4I3bL6Tb/0njKkJ
 dFFymO6rjUnuZp/NpokF1x7MCoIj5XDNzoTPIexX2tMasvox4wqDApXCaH3wtftHaO3jHvM6ML
 YfeWllEY5He4Y80/GFKaupUErAFusNsw8z9+Q5+p40AEAAA==
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1776286764; l=6888;
 i=rbm@suse.com; h=from:subject:message-id;
 bh=C5gBCOFN02YFIPa38DguA50umMdPOwESOAOxPNJ9NUA=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgguRCc5X8/UX9M40lkMnr//aFGOhce
 x5ezt8MFNUFlqYAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QHiVqXbsKTSDkzpDj3MdBOyhMdP9j9qW/Ti/+H3Ry57FO1XzI+JrpWyrQdnT2Oz3Jw2tFj1AxGv
 IRaitS3fw7wU=
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
      selftests/bpf: Allow test_progs to link with a partial object set
      selftests/bpf: Tolerate benchmark build failures
      selftests/bpf: Provide weak definitions for cross-test functions
      selftests/bpf: Skip tests whose objects were not built
      selftests/bpf: Tolerate missing files during install

 tools/testing/selftests/bpf/Makefile               | 160 ++++++++++++++-------
 .../testing/selftests/bpf/prog_tests/bpf_cookie.c  |  17 ++-
 tools/testing/selftests/bpf/prog_tests/iters.c     |   3 +-
 tools/testing/selftests/bpf/prog_tests/test_lsm.c  |  22 ---
 tools/testing/selftests/bpf/test_kmods/Makefile    |  24 +++-
 tools/testing/selftests/bpf/test_progs.c           |  44 +++++-
 tools/testing/selftests/bpf/test_progs.h           |   1 +
 tools/testing/selftests/bpf/testing_helpers.c      |  17 +++
 tools/testing/selftests/bpf/testing_helpers.h      |   1 +
 9 files changed, 199 insertions(+), 90 deletions(-)
---
base-commit: 1f5ffc672165ff851063a5fd044b727ab2517ae3
change-id: 20260401-selftests-bpf_misconfig-4c33ef5c56da

Best regards,
--  
Ricardo B. Marlière <rbm@suse.com>

