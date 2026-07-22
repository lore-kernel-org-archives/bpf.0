Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06D683E92A9
	for <bpf@vger.kernel.org>; Wed, 22 Jul 2026 04:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784693331; cv=none; b=LeW/5LaEfgkqu7ImIBb2d+TVFGLwnzpZmiSlU+xYF7wlVyr/CIg2xXy1PYJ00EvdI4lpK/2C6rOvDmUR12uqk272gytAbMM4nesY3Fw5x6flo8omqPNX9hcC/q/LEL7r5bNEdccId7QbtTu71fRR3rxvudwUq5tZA6FlfhosUD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784693331; c=relaxed/simple;
	bh=a751mP+Y0KDpGuMlJ84CNsZAZHWIywBtGkKQsAqYnSw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tc9cIRaz6q7NpNh4MSQ+CQW6AmanImm2TSS7qvzO5OeP3/akrfB7DAr4bbqSRDoFZuOKN08Nzc6nnoM5xU09eCednuf5FVGrLoR4U3H+lYDoTBZ81XcFDTF+cUyz8oXcUJUG+k3x+l3WyvL5cmUDLbxj+GYEcGC1Xi7xauoNsYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CT2+VvF0; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CT2+VvF0"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2cad8076b01so143757725ad.2
        for <bpf@vger.kernel.org>; Tue, 21 Jul 2026 21:08:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784693329; x=1785298129; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=qnKli+eKKkk80jbtPiN0sga99UwdQ/kgVNfsS7/mryw=;
        b=CT2+VvF0GaBaXiCImVE0jzuqTcgE8JwvUa1b9fPR1I+WtXWfdGmeQ2mGdwRInO8PeU
         RutMvjNGGTEgtVyj645npmn0Vw5vaJwiW0CnEIcCFRsVhzcMOmmEy9kB7pqNdJqT3xuB
         i8Q4BX/IQ8XtT389hX5B7gPkquC3q+jQJ3c3b847VjQoQ/pNZjstwMk7lHuSi24LGPKX
         tuoHpcF4s99WajOjDnJLgokvh0mcZrn5ivoZZEhtsqCLhZiTL3R0OfayZLWgs8UubIJ1
         4J+E8DKW8efPk2B5L8w5YSfGHMomchtCpmbcKqX8ZjJcLk54ioreqO6+WbHmCgpxfv1n
         xegw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784693329; x=1785298129;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qnKli+eKKkk80jbtPiN0sga99UwdQ/kgVNfsS7/mryw=;
        b=nMK0l5aN3N5rFiBKexVHgqHAWg6BE2GiOffcGvEJ1f/xU0/W9RIE6okMx26NemFqsB
         ZKRpzhrkkiDnhM/oA8urhRc+AP9J2U511pTBdb3KCPdByptuqmttUymOwALnQKEQuLjk
         B8a93fEOiuYSr5amm+3m6mU+Zd/QkcyQYcvzOsdt3K+vIa6/DwnMY++vjCkO1VQTGENV
         cppifBzmd0iPn24NdCYZtMkmPa5rrODDjXwkUZrBOrMEEf4teXIJzgMiK4DpQdsRTW9K
         eM7L6LwtO2YlpafAoPRZxaywuTMoswv0y9WVQAojN5GwgHnBSo0D+QJK4E2UqJDgKINt
         ADuQ==
X-Gm-Message-State: AOJu0YznXsxQd1m/ljarRJQi8XG6dBOpS9+hX86cxKZ85PiflqaAUpMi
	O0uohptF7c1mVnVQzpbqaZO9bWMf+cx6pkD/vwixX/agHTs0NuhFQQPanOPpLztq
X-Gm-Gg: AR+sD135DKbhv8GSCoDTSMEEZ88fghQ88WCJ1KmQyCNbF1t90rpCq5aJ4T0nzsLU5Kw
	L6pIMGgCSaB+fT+C2NqOhofEeH96LUTQYqBeWj4U2j1UPg1OPo8GB6rE2hzfkbpQP6D3c03jmD1
	6mrlhRbMkMrk6oawLxp5lY+F+uTSmUXae1HPlwFRJS3U9vWBzj7kHXk+X05q+Io3qtx4cDZG3zr
	hPj+SAA+XYvBEHHumSZkKVxVHD3P/Bg+Td8Xoj5S/P85c31Atof1RTxcypF5VlIPN8IpOjLx5qt
	b4zrLGI9LYrLeQmpm0IKHgZ78gNc3ygwKuhkv7C/H7DUx0DNJMr3cNzKcnd+yV/IhQrqpKFnvdz
	kzgSJxWPP0VBmpNeZUvkkj/G4JzoxXCy5VZGKTcNNuyIjkxmozswV1gM61UXeFpfne1e5nDsndH
	nmVRTW5Rd3+sz4S+wdNZ0a+3rQ
X-Received: by 2002:a17:903:988:b0:2cc:f5aa:9513 with SMTP id d9443c01a7336-2cf34821a87mr243521545ad.10.1784693329244;
        Tue, 21 Jul 2026 21:08:49 -0700 (PDT)
Received: from powertower.localdomain ([64.180.35.234])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf8f2e987asm6843235ad.51.2026.07.21.21.08.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2026 21:08:48 -0700 (PDT)
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
Subject: [RFC PATCH bpf-next v3 0/3] selftests/bpf: restructure the Makefile as a layered build
Date: Tue, 21 Jul 2026 21:08:27 -0700
Message-ID: <20260722040830.387979-1-nickolay.lysenko@gmail.com>
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

 tools/testing/selftests/bpf/Makefile          | 950 +++++-------------
 .../testing/selftests/bpf/Makefile.buildvars  | 204 ++++
 tools/testing/selftests/bpf/Makefile.runner   | 316 ++++++
 tools/testing/selftests/bpf/gen_bpf_skel.sh   |  97 ++
 4 files changed, 886 insertions(+), 681 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/Makefile.buildvars
 create mode 100644 tools/testing/selftests/bpf/Makefile.runner
 create mode 100755 tools/testing/selftests/bpf/gen_bpf_skel.sh


base-commit: 5eb8921371c6fd117d4a328b6053dfda38707df8
-- 
2.43.0

