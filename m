Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BF2638836C
	for <bpf@vger.kernel.org>; Mon,  6 Apr 2026 16:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775491894; cv=none; b=miCHvsu5e0lwTGx0mSmaLdE9Szrih9s61CGQJMqBqqntyBQugMt1flEeuGDZuCMqUROvv4BL3hGwYkNZbJis+3/Kpy2GcLjAVhvsAKoxL+jkzx98boa/yfkHPIRYY2KAYp8LEfQ778s2BCkAFX+4Ph+0G0VIQbfUfjn30GZZzBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775491894; c=relaxed/simple;
	bh=ArgOU95qRvvNq5EYMPlzVjOtmEEPyIXcwsThZmdALLU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=l85HJWBXQWNrXm0Z1NogCkTzRdepl0MuFIyw+Qilu/w8JlqULESPEs8creKjdL7BE+HW/3Az0Y33MPiZekIHNZz4wgX7OZwiDwY7aaApwbhABqvzelXL88+j/by9G1jQx8MzKqDaLx3jeq1DFEcXJiUMEcqhzmHgDJ1ivu3Rdh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Git/Asxe; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Git/Asxe"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-488a041eae5so16983085e9.1
        for <bpf@vger.kernel.org>; Mon, 06 Apr 2026 09:11:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1775491890; x=1776096690; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=o9sN4dQ77cdHfplJS7dhEnKxehvVdqPa8hIuKQeJ1sw=;
        b=Git/AsxetiR48SYNAc6nr3z4lTxtZFDOoFVh6yhCUyJmmFOYHd4ELUTSxfqpuGnjmB
         PadBZOuQQCIXhJkFuUXCTqPa0FrKFwtiNUl69sQQYACkS1zH0nrCnylHkNMb9pUsyAPG
         nYrk1tG++SD8Ck+cqHzop/PF/O5Dfb94twv/OLpeb3DzQacQgcJvt1VKnwoTU7kB09mY
         qTiGvqcQuab3UhnpR38jxx+dAoYyyPNXWmy6FyIEZ7MwXKewsnuLN2DAI4RB9P8luo04
         ERuDOjmVzKfzdV47oeWotbKrj9j0e/B+MGoEy1GirYUDpl3dPlkHMNYRhmO3bzpjfEEq
         D/5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775491890; x=1776096690;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o9sN4dQ77cdHfplJS7dhEnKxehvVdqPa8hIuKQeJ1sw=;
        b=AMIoo2KRzeiFL9DHlbWNqPlHaT7A2fAu+9zhtM0L6E3f+EO16Ekz5mVjh1YuVjC8f/
         NifpUBXr548kn2cJbqa3OzABhOgHnVdMdDxH6hq+8XxtnAp+xMUX17Pwx6n+k1Ory47x
         krM57ZavPx4fKCNv/saQXadW3jSqIreMH6Clc/QTmeXdHe9xsx98Fd7ywAjx5DeOnNkR
         tmiHy8V3hGP9HaZndPPu/0TsGVB+WyY2oXlODzXdbdZFZCGCCod22xTvpdhA1DfDlhJj
         ++RRBTtmiAyENe7N844ivwACSB/XpBLDwmR55UuDd1LWsuoqGVrgC55qIl1PFBcVmaCc
         DYAw==
X-Gm-Message-State: AOJu0Yx8quEPZpZhsJbXZxHf8ct2Mx0KhrlUbi26jnWkglLc1Bo5Ivmg
	y5c6GVNY2kf/4rKLZfKXQAiko2dG0Uw/znogEd2WVEww0vHjjusiIHZspRNbd2hjH5dusCf25fT
	e8ThY
X-Gm-Gg: AeBDievznQpJTD8dXckSPsMsBksuegqkd/ch5fnOZTnVdXEuEnUeonf5ktYY5u+c/GH
	tML0meK4DYjGGhry6/pfzu7TO8KqfwSUhSUhbNxTfd0TqiKyVZtSfGhEVBetNApeW+YvaaQGo3J
	ht+3+jqQkN+un2ul4kixKUKfoo8PV8Y1Iu0pj16DvDLYnDKbs1LGdxAFkbdk7aKAa7cSsMB7DUY
	AZwKUliUPko8c5tslqYH2MzJwqsPOcQ/UW5q9x3dyoxGxp88kcjqMP/lPAs5WixPcvRCBJsHSIf
	EC3b1gOP8d5RSt47/ympqQRp8zIx4q3DZCVi4IRnRXGXVTe7hWKNroCCUsDDe0dKSRNVjKfRIj3
	UezM25FKt66H8cjmWunHH/4vn/KSpEbVYEJotg/vVtecfmAgjAWFfQ6EMqxEz8Yksk4fUnHsR8k
	bSSm24Htj9Wo3rGgMdyfnD5Ys=
X-Received: by 2002:a05:600d:12:b0:485:3d3e:1675 with SMTP id 5b1f17b1804b1-4889971dbf4mr138978625e9.8.1775491890483;
        Mon, 06 Apr 2026 09:11:30 -0700 (PDT)
Received: from localhost ([2804:7f0:b767:120d:a4df:3777:2c55:2b95])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-60582b562bfsm17281537137.0.2026.04.06.09.11.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2026 09:11:29 -0700 (PDT)
From: =?utf-8?q?Ricardo_B=2E_Marli=C3=A8re?= <rbm@suse.com>
Subject: [PATCH v3 00/11] selftests/bpf: Tolerate partial builds across
 kernel configs
Date: Mon, 06 Apr 2026 13:11:22 -0300
Message-Id: <20260406-selftests-bpf_misconfig-v3-0-587a1114263c@suse.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIACrb02kC/4XOTQ6CMBAF4KuYrq0OLeLPynsYY0qZSo0U0ikEQ
 7i7LW7cGJdv8ubLmxiht0jstJqYx8GSbV0Mcr1iulbujtxWMTMBooAcMk74NAEpEC87c2ss6dY
 Ze+e5lhLNTu+KSrH43Xk0dlzky/WTqS8fqEPiUqNUhLz0yuk6nSLHHY5h2ygK6FOjthRa/1rGD
 VmS/u8YMg5cKsyFBmX2hTlTT7jRbcPSjEF8M/I3IyJjoNgDyAOoY/XFzPP8Bui8ldw4AQAA
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
 =?utf-8?q?Ricardo_B=2E_Marli=C3=A8re?= <rbm@suse.com>
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=openssh-sha256; t=1775491886; l=4599;
 i=rbm@suse.com; h=from:subject:message-id;
 bh=ArgOU95qRvvNq5EYMPlzVjOtmEEPyIXcwsThZmdALLU=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgguRCc5X8/UX9M40lkMnr//aFGOhce
 x5ezt8MFNUFlqYAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QN+3AuGyAVB98N94X/jHHKGCwEsduJGzrTLiK2iADVWsta0LBaieNypC1lG6o/dUkgxmP4sVyPf
 AoXdf4cGh+QA=
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
make -j$(nproc) -C tools/testing/selftests SKIP_TARGETS= TARGETS=bpf install
```

This produces a test_progs binary with 579 subtests, against the total of
708. Many of them will still fail or be skipped at runtime due to lack of
symbols, but at least there will be a clear way of building the tests.

[1]: https://openqa.opensuse.org/tests/5811715
[2]: https://openqa.opensuse.org/tests/5811730
[3]: https://src.opensuse.org/rmarliere/kselftests
[4]: https://github.com/openSUSE/kernel-qe/blob/main/kselftests_known_issues.yaml
[5]: https://openqa.opensuse.org/tests/5811730/logfile?filename=run_kselftests-config_mismatches.txt

Assisted-by: {codex,claude}
Signed-off-by: Ricardo B. Marlière <rbm@suse.com>
---
Changes in v3:
- Split test_kmods patch into two: fix KDIR handling (O= passthrough, EXTRA_CFLAGS/EXTRA_LDFLAGS clearing) and wire into lib.mk via TEST_GEN_MODS_DIR
- Pass O= through to the kernel module build so artifacts land in the output tree, not the source tree
- Clear EXTRA_CFLAGS and EXTRA_LDFLAGS when invoking the kernel build to prevent host flags (e.g. -static) leaking into module compilation
- Replace the bespoke test_kmods pattern rule with lib.mk module infrastructure (TEST_GEN_MODS_DIR); lib.mk now drives build and clean lifecycle
- Make the .ko copy step resilient: emit SKIP instead of failing when a module is absent
- Expand the uprobe weak stub comment in bpf_cookie.c to explain why noinline is required
- Link to v2: https://patch.msgid.link/20260403-selftests-bpf_misconfig-v2-0-f06700380a9d@suse.com

Changes in v2:
- Skip test_kmods build/clean when KDIR directory does not exist
- Use `Module.symvers` instead of `.config` for in-tree detection
- Fix skeleton order-only prereqs commit message
- Guard BTFIDS step when .test.o is absent
- Add `__weak stack_mprotect()` stubs in `bpf_cookie.c` and `iters.c`
- Link to v1: https://patch.msgid.link/20260401-selftests-bpf_misconfig-v1-0-3ae42c0af76f@suse.com

---
Ricardo B. Marlière (11):
      selftests/bpf: Fix test_kmods KDIR to honor O= and distro kernels
      selftests/bpf: Route test_kmods through the kselftest module flow
      selftests/bpf: Tolerate BPF and skeleton generation failures
      selftests/bpf: Avoid rebuilds when running emit_tests
      selftests/bpf: Make skeleton headers order-only prerequisites of .test.d
      selftests/bpf: Tolerate test file compilation failures
      selftests/bpf: Allow test_progs to link with a partial object set
      selftests/bpf: Tolerate benchmark build failures
      selftests/bpf: Provide weak definitions for cross-test functions
      selftests/bpf: Skip tests whose objects were not built
      selftests/bpf: Tolerate missing files during install

 tools/testing/selftests/bpf/Makefile               | 135 +++++++++++++--------
 .../testing/selftests/bpf/prog_tests/bpf_cookie.c  |  24 +++-
 tools/testing/selftests/bpf/prog_tests/iters.c     |  10 +-
 tools/testing/selftests/bpf/test_kmods/Makefile    |  15 ++-
 tools/testing/selftests/bpf/test_progs.c           |   7 +-
 5 files changed, 129 insertions(+), 62 deletions(-)
---
base-commit: a1aa9ef47c299c5bbc30594d3c2f0589edf908e6
change-id: 20260401-selftests-bpf_misconfig-4c33ef5c56da

Best regards,
--  
Ricardo B. Marlière <rbm@suse.com>

