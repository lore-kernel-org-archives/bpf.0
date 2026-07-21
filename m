Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3032471404
	for <bpf@vger.kernel.org>; Tue, 21 Jul 2026 19:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784662899; cv=none; b=oYULpuzTIXFSFhOC6KY2epCj2pdI94KFVqineZeHDlkHAldqNCqdg+E6FLfHaR9d/5BBxw6mjjV1jF3zZEdkjqfGzkCpbHfVd7vUxWenhSlbvpPC5n1X+08NC0YCZ9BgcLwoNKYMEqD6xUtkrWBnn/0jFuB7t0R79tQjdLa+Fx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784662899; c=relaxed/simple;
	bh=0GFJGUpJPupKlp6BWR2qYbhPJhmAcNGQX2I8MbPaVRI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nph7K9hS/HyT43TEcTiiQnDhEIYPtyNyNCfMHE59ePTonlS74/RUHhijaIh87weqPORBHIkv4MXzmHu/9yd88118Ea1Ibj/iUzfqEDn6iKk7LW+Ey9Z/V5tONlgpnZ5tmEvrNUpm0Q+c5tHsl8R+PN4cAoYCZ5/bRegHff4/U7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c5U0m+Y3; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c5U0m+Y3"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-84864086bfeso12499146b3a.1
        for <bpf@vger.kernel.org>; Tue, 21 Jul 2026 12:41:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784662897; x=1785267697; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=cOgxoZIEPooamKcdQ3jZyytzK2hQCdcCEVeQPJDuiwc=;
        b=c5U0m+Y3rZIw/k4kZ7Rjel7zeFDcv8K1Be2H9PNvr9L1keZW6/M0BAjLRs5G6nl35+
         PaFs9LF/Ky9mTeiWb7HCqXuCZEk7Dp5Aiar3AuErncSrMw2m/S7gb02aQPjGsqE7i9hP
         O7XSRTFVHEOH64v47bm+/x5IDmnqufsZsovIJIcdhs+MGEGYaHBaudB49fEsRQP+yLca
         Gmm5eN7XxcRcjtoBvnCvetMnBZnvSLCxkepJUOxlgm599uXbdjtRBeB6O37cv5QNkDZv
         5Ju83OphpU3uhE1AnpPhClDBbD7gerfxTZhBgwOY7C+eyqRH0tW4sfptn+tm4/dDoMGu
         n4lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784662897; x=1785267697;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cOgxoZIEPooamKcdQ3jZyytzK2hQCdcCEVeQPJDuiwc=;
        b=PFn5cLESiztk4O9tNTGm75WgHu8XeNxpcrKCbcwVcvjGw4j6pvAtZvH+l1rhxC/awZ
         ehTP2fUjeAyrP2WY0ddHiYXTlOaOZPtNYwR9qiYa5RFNr/9AhdrDzKgDWEZuAIL4ztJw
         ANheDFt9reB0/DIsVNsrwxetRQM+AH3oDeSTre0/5WaxO1ZzsWFpumunic3YOGuCNe3c
         pxc675lLfbJRc6v0mdAMj9jNB8h9Vq89Ag6JtRjvV4W4XynzZYRjkCu5kxMNgn2Qhfru
         yIE2FenopvOi3jP4vRCkjrTPW6EFemGKgdDNjTlaVE6Ye4jK4nAir+0y6efcDjlA7BdM
         26iA==
X-Gm-Message-State: AOJu0YyZasbTYhUnVOUXzsYm6lmeZu1JC9YULEjgXfYMUZRY9C31nSWy
	2CmDu2+K1bzlrJ/otNXUuUwncg8qmmwSByIKBhF8YcCQLCwRvLQ0qhRC0M70ZovJ
X-Gm-Gg: AR+sD133KARU/lW3EZeABut8aTqE5Qff4dGHeBk3uUoXx96AvLrUsotSebWm3uHLRl/
	g+9bE1VyGx+df4URuGmDKP9JZdo7lFMfP3wfjCw84rIwb/PpVwwtKVQ9tgbSOxJ+8r1HNDwMRos
	3zTXVxwhN0PWD0ZHcRUtrp25z706X6GTFwd9A+KGbg3hWfpHqL7GDqcyPfKZlBVSoCx43TdU0tE
	piYqCeFFmvbzs61tOcfvI07s61xSbOS0eBxjF6ppkWK1z7khAwcoNTrfkeqhat3OmuM573V8dp6
	hgbGaKStiPqPM97mVrIAEtvjEK9+Bb1ARm6d300fLnnRF2et9anehfgLXaLYLLZnhXeTOOFJN9V
	IHUiWMeUT89m5qsuYtMhl93FZQp7JMBJk6OEMSWFQ8PxqIBRoXYLdMLrrd1QguQZrUqfzou81Qy
	Y1yyvlq1H5tGroXN147Q/x1C7v
X-Received: by 2002:a05:6a00:1f18:b0:84e:43f:7188 with SMTP id d2e1a72fcca58-84e043f7261mr4882786b3a.12.1784662896930;
        Tue, 21 Jul 2026 12:41:36 -0700 (PDT)
Received: from powertower.localdomain ([64.180.35.234])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84e17237761sm214934b3a.4.2026.07.21.12.41.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2026 12:41:36 -0700 (PDT)
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
Subject: [RFC PATCH bpf-next v2 0/3] selftests/bpf: restructure the Makefile as a layered build
Date: Tue, 21 Jul 2026 12:41:08 -0700
Message-ID: <20260721194111.334795-1-nickolay.lysenko@gmail.com>
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

