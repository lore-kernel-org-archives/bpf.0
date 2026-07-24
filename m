Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44667175A99
	for <bpf@vger.kernel.org>; Fri, 24 Jul 2026 04:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784867180; cv=none; b=pQipRNdbuqHdGSYSevX6J2fl7zwppUQsbIxD7+1Su0lED6/OIKmFvYrt+Erw32mW2Pxral2FSVi2pfgjVn3z9IDGzC7CSZX/WbcDh+FXIxT5r7Z2YTabAx3dTFwhgqHD8ISXwrHepPoq1qvmy4gcObsh510UBpscQEI2X0b5WNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784867180; c=relaxed/simple;
	bh=ijPWs2xVksAmAB5hovnsUjVdUQBp1OkedN4DUHOGrrE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Bob+Yi28MOPNza+sXPKJZhKn+Sd4ByhAuN12iuIHFG8B2bSX7vTyHrWbaIV5alIh7nUFHK0wb1fq+uO0cDb2qxt2cgE2bjh/Jtuqu5C+U1+6P+XgkZCatzBGti0amnzVgZsD1OxW+kt8dBGtot0OUjEvPmw1Va7ULpoxPcwArGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YIjITw+b; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YIjITw+b"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2cca0c5799eso376115ad.0
        for <bpf@vger.kernel.org>; Thu, 23 Jul 2026 21:26:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784867178; x=1785471978; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=DKY6IXvIHIW6veKFhlZ9Co6g1obJc5pSTuCyVlsA160=;
        b=YIjITw+b10gwmnYDzIk67GVI9g4njmv1Qr/CV8EJmbvQEVHBdO4c0Y7yyCcpuMInmK
         iBZ8WJ1d3uTsjXklHA3v3u1DpniUxlvZ2VATtqilgmOeLX9vsZLi6xj9tWkgsbNuQTN5
         5n4z81ZZdxPnddSwhVpd9z/AWZTV9yICCExl6caJMPz/bLXdHrkBdGtchpQWbkfDp5jM
         aFtLJVDCVh/8Km0digJjiiKpmqAO6MnAc2LvRdqz+4Jb1caGt57W+ayBAtAoekip5ApT
         w6TCpCqpGjSIYhkY6G+jXBQUeHiv+cMOwZK2qj2S19yWjboYxf5Q9U0sNF43J4FQfeSf
         auHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784867178; x=1785471978;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DKY6IXvIHIW6veKFhlZ9Co6g1obJc5pSTuCyVlsA160=;
        b=cLkeMKikUH70wL86xx7FbJTuGi3zqULgDXCsOYh7dfAUutdnxq6JSWFGrXDGokN4YN
         V/Bbux5KPbTQXoXfR4ZQzpz6uNhZtV1+GxleqCvxhojTKG8Oo0NOYF4PEZdyoowyF9Wr
         x8NqcPMziKTGKhABhwN4lrr9CJXy3c9VHgquhIfRyuEdH8/S1fiHiT9hLmbDTW7uMu4p
         dzBQMe7rI9jHl9Wn8ASkcqvNYVw0kYXxbCqjWTjapiWCpNRNX3a1fF44C3xRWc4noJyF
         HdulKHnkkjzDSQ/QL2IWzKrVevAw2lugFg2QVX12IZkVW9mwWnwKj06R9lLPn1eg0gY5
         YJ9w==
X-Gm-Message-State: AOJu0YzVOUfcMHLTj6tbFK5/LMk6Q8XUPBr1BAKU6UmbQm3+wY85xzPI
	T+dDgyD89IIBPtO6+cAscSbWHC14cvlj6cUaqX2FYbr0n6kNV8viJmrGQuu8SmM3
X-Gm-Gg: AR+sD12VdAKmCafdGzJ6N0Oy0Zt2u8zn0i1Z7mpRmcSdkcJDbP6N7KlUBtzYqyr2bam
	WtJ5pDQu6jUwrilujMNpZg5xpRyi/jGMaAEsSxLydYAJUBehOmjadCgLzboHLkxyhqzY7IRGJ37
	WmWwTW7c6Cs6xUwcx3jyDoa3u+9U9a/vgCEk8bnTNzdSMIco2rl7JEb+OaPJPz/8ujtFeW/6Qnw
	orTZEnv+KM+U+huk89EpuCLBIj0moeSRv8MrgI09KKxXLZ3iEPDkOLz4YoZ7PodZOm4uQyIvSld
	allsnNbtYnHjqrkDUglDy0iqEflAdNZjp24IErN9XTtB3b6A46BxB+ptNIthSqS0PjDuK0xu2gp
	q6YXqcGpWYf0h8O6k/5rltkeZyk8OWgUP5JSb6Ld90ecjbQ1GWyNv+3SSCQ/XKIhKpAKxG0WrOS
	cjM8u18lvmebze7HPcRKxpCYoXyWfT2Dgh
X-Received: by 2002:a17:902:eccd:b0:2bf:27b2:4b80 with SMTP id d9443c01a7336-2cfa6b7a7c2mr67782935ad.14.1784867178521;
        Thu, 23 Jul 2026 21:26:18 -0700 (PDT)
Received: from powertower.tail474ae1.ts.net ([64.180.35.234])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf8f0072a8sm44437015ad.34.2026.07.23.21.26.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 21:26:17 -0700 (PDT)
From: Mykola Lysenko <nickolay.lysenko@gmail.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	memxor@gmail.com,
	Mykola Lysenko <nickolay.lysenko@gmail.com>
Subject: [RFC PATCH bpf-next v4 0/3] selftests/bpf: restructure the Makefile as a layered build
Date: Thu, 23 Jul 2026 21:25:57 -0700
Message-ID: <20260724042600.175440-1-nickolay.lysenko@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The BPF selftests Makefile has grown to ~1,100 lines, with much of the
complexity concentrated in the DEFINE_TEST_RUNNER double-expansion
machinery: the per-runner rules are written in $$-escaped make and
eval'd once per flavor, so the rules that actually run never appear in
the source, are invisible to make's own debugging facilities, and are
easy to break for one flavor while testing another.

This series restructures the build in three steps, each independently
buildable and each producing byte-identical artifacts:

  1) the four near-identical skeleton generation recipes move into a
     parameterized helper script (gen_bpf_skel.sh);
  2) shared (non-rule) definitions move into Makefile.buildvars;
  3) each test runner instance (test_progs, test_progs-<flavor>,
     test_maps) becomes its own plain-make sub-make (Makefile.runner),
     replacing the eval/escaping layer.

After the series the top Makefile owns everything that exists once
(toolchain setup, the libbpf/bpftool/resolve_btfids sub-builds,
vmlinux.h, shared helper objects, standalone binaries, and the lib.mk
run/install contract), while every runner instance is an ordinary
single-flavor makefile with no escaping. Total line count is roughly a
wash; the point is the structure, not the size.

Sent as RFC to gather feedback on the overall direction.

Validation (each patch, x86_64, identical toolchains, clean builds):
2,948/2,948 BPF objects, 5,352/5,352 skeleton headers and 1,413/1,413
userspace objects byte-identical to the current Makefile's output. For
the end state additionally: 20/22 binaries byte-identical, and the two
exceptions (bench, test_maps) differ only in object link order, proven
by relinking the current Makefile's objects in the new order and
comparing bytes; emit_tests output and the installed tree identical;
BPF CI green on a manual pre-submission run across x86_64 gcc/llvm,
aarch64 and s390x (including GCC-BPF, ASAN and veristat jobs); and all
76 benchmarks produce identical outcomes on old- and new-built bench
binaries.

v3 -> v4:
- fix patch 2: "export BPF_GCC TEST_KMODS" preceded the TEST_KMODS
  definition, and 'export NAME' on an undefined variable creates it
  empty, turning the ?= default into a no-op - the kernel test modules
  were silently neither built nor installed and every BPF CI
  test-runner job failed with "Can't find bpf_testmod.ko" (caught by
  BPF CI; not reproducible locally where TEST_KMODS is overridden).
  The definitions now precede the export, with a comment on the trap.
- addressed Eduard's (partial) review of patch 3: header comment
  trimmed; CHECK_FEAT cosmetic reverted; the stock named helper
  variables and per-binary dependency lines are kept (HELPER_OBJS is
  defined from them); map_tests/tests.h added to the runner
  prerequisites; the include-derived skeleton lists are dropped from
  this series in favor of the current hand-maintained lists (the
  derivation can be a follow-up); the per-flavor BPF compiler
  differences became plain sub-make parameters, removing the runner's
  only conditional compile block; content the series does not change
  (helper variables and dependency lines, docs and resolve_btfids
  rules, uprobe_multi, verifier/tests.h, the libarena targets) keeps
  its original file position, so it appears as context rather than
  churn in the diff
- addressed Eduard's review of patch 2: Makefile.buildvars keeps the
  definitions in the order they had in the original Makefile; knobs
  the runner never reads (SKIP_*, submake_extras, VMLINUX_BTF,
  TEST_KMOD_TARGETS) stay in the main Makefile (TEST_KMOD_TARGETS is
  inlined at its single runner use); patch 2 no longer touches
  TEST_KMODS, TEST_KMOD_TARGETS or the VMLINUX_BTF block at all - they
  keep their current positions, and the export the runners need moves
  to patch 3 next to the LLVM-probe export; file header comments
  trimmed
- addressed Eduard's review of patch 1: the gen_bpf_skel.sh interface
  shrinks to --name/--skel/--subskel/--lskel/--sign - the
  linked/llinked intermediate infix is derived inside the script,
  --sign is a boolean taking the key and certificate from
  $PRIVATE_KEY/$VERIFICATION_CERT in the environment, the build-log
  lines moved into the make recipes ($(call msg,...)), and the unused
  --no-determinism-check escape hatch is gone (the determinism check
  is unconditional)
- v3: https://lore.kernel.org/bpf/20260722040830.387979-1-nickolay.lysenko@gmail.com/

v2 -> v3:
- BPF_GCC and TEST_KMODS are defined once (main Makefile, which needs
  them before lib.mk) and exported to the runner sub-makes instead of
  being duplicated in Makefile.buildvars, where the copies could
  silently drift (reported by Sashiko AI review)
- the permissive-mode runner link rule keeps the current Makefile's
  incremental semantics: test objects existing at parse time are
  normal prerequisites again, so editing a test source relinks the
  runner (reported by Sashiko AI review; v2 had regressed this to
  order-only)
- v2: https://lore.kernel.org/bpf/20260721194111.334795-1-nickolay.lysenko@gmail.com/

v1 -> v2:
- rebased onto current bpf-next: ported the semantics of commit
  0b236ac75d04 ("selftests/bpf: Fix make install target") - bpftool
  installed under tools/sbin/, *.BTF files installed - into the new
  install rule (resolves the CI apply conflict against v1)
- gen_bpf_skel.sh is a prerequisite of every skeleton rule, so editing
  the script regenerates the headers (reported by Sashiko AI review)
- the shared helper objects the top Makefile pre-builds now depend on
  a superset of the prerequisites the runner-side object rule uses
  (libarena skeletons, both generated tests.h headers), closing a
  window where the unflavored test_progs and test_maps sub-makes could
  both consider a shared helper object stale and recompile it
  concurrently in the shared output directory (reported by Sashiko AI
  review)
- v1: https://lore.kernel.org/bpf/20260721174909.8044-1-nickolay.lysenko@gmail.com/

Mykola Lysenko (3):
  selftests/bpf: extract BPF skeleton generation into a helper script
  selftests/bpf: move shared build definitions into Makefile.buildvars
  selftests/bpf: build each test runner instance in its own sub-make

 tools/testing/selftests/bpf/Makefile          | 942 +++++-------------
 .../testing/selftests/bpf/Makefile.buildvars  | 160 ++++
 tools/testing/selftests/bpf/Makefile.runner   | 325 ++++++
 tools/testing/selftests/bpf/gen_bpf_skel.sh   |  93 ++
 4 files changed, 866 insertions(+), 654 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/Makefile.buildvars
 create mode 100644 tools/testing/selftests/bpf/Makefile.runner
 create mode 100755 tools/testing/selftests/bpf/gen_bpf_skel.sh


base-commit: 87267b89459813cb50ab5377e076b639c07b4491
-- 
2.43.0

