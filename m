Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFC4148425D
	for <bpf@vger.kernel.org>; Tue,  4 Aug 2026 17:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785862957; cv=none; b=adAa4uS+M29cFijddDqlivszwITx1GU+S5W7UaXXte1C18qUaU6lGb/ztoGqb3fSVqo7ksppGxSQoTE688kGuMGqL44Eh+67ggfZs0tYxG01MHY8Kzg7H+GrEVQ41CZcTHhxmvFnfQk60K61XVm+Op0/P53m8NRgEYeH5uUUHEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785862957; c=relaxed/simple;
	bh=EX21IYyCbiN3ecrOKbmwzwt0Mf0DUN+CMzfWd1DuStE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iAs7EcKA0DGM7u3wdmQVr68g+n0xKyN0gE17LXOs0wFUPAO7INZHpz+NFpGfJwr4L5VcRNQXcCxFFAb+lo1fe5O2bBKLj70vycg/o/O0wLNHtl2CWrY1tXTga/CMjuWJ0vDc/m/lPcdl7yjlMx9iXm/tjJpZwJR/ju1cuLSUbLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AEggD2CO; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AEggD2CO"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-8487b7b3fc8so33585b3a.3
        for <bpf@vger.kernel.org>; Tue, 04 Aug 2026 10:02:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785862935; x=1786467735; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZMnK/Ij5fHT6Ki4avrZe1JUksCo6jpsv5pBTWt5t0UE=;
        b=AEggD2COSeB2b+2JERvS29ZyMPjjgtwCygHPqjMsoo/0bZhAb7/2v7ajI4Hc9AKjHu
         noFM6Tsw6CLSqz3wwj5GR+iq2Ris0fQ1sCx2T4PmUii3YewnsTIUWK7ob4XQrhGCuaj0
         LZ7gNLc0TpouEIPs0JwcGU8hiXT/AGDdpkN8ijCoAT0k6VJlonj4G/TssNE/bQrSY0XD
         ByaFEux4duJPTfEbf+juGHoBiYDoiYgupkT4QfPwsCLCEfQB5gUNqlmsnZBNrcF1wIz8
         1+odO7d1PLQ6PbU4iiMivpaGi98pu27D7YpR23arbwgbSOjZJERzkJ0Vvvbx6bdmwP4/
         DJeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785862935; x=1786467735;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZMnK/Ij5fHT6Ki4avrZe1JUksCo6jpsv5pBTWt5t0UE=;
        b=e4GFwEndV1axGnKhabHQ6eQIOSKcqx51TmAUZqiNGpaTDCGhazj5H0bQLuB7+SLMnh
         0CE2uO26ayvoZTDjfel/qtialg/a2OIKupXmDOwKBfO1YM5pBjOyzqB+dbJEqufKrIuh
         egZe/A1Qe7QBxmn/7QSSbrwLl+rsoDOtxrh3B3dn+daSIeI0470NwNdhEYvBr0nYJVtp
         cuJjn13kY3+JIctkQ+B9icZkNEHSsVFJ/gGjVJ7toIBJxkTHASA9fmXx4ZZHqjovRBN5
         ix319HvM1jN7Ivb3zXJpwGfWz6cJh4q6Ce3JfbHB0mpqOOyeZLM8cf0TbgoE+dlKHgiO
         CZQw==
X-Gm-Message-State: AOJu0Yy0RgoQ2m2yL+mBGTZiiV8W9jZFj6hIhy/eH7QaDCqiB09DF8eB
	HzrAWoSlI/XS5caRavbbSfIWW4YF0Im6yWgg5DX1qUnE7I5OpOHAXgNRZov0Uu4k3Dw=
X-Gm-Gg: AR+sD13PstLdQi2a2uAZdJ9TgJAJdYtJgJkUf4KcoHyrQtx0/BsPUuK4otp3MWfFDHF
	EHDliDZ81tu5IRQuC+mFE59yud5NredbvswThLqdPy4V+LQbBNa9W0VaftIBb92BCInu911z4Dr
	nI8xl2iXcHJDDO+PrHRedrMWF6aEcfxNK2Wo22mLp93Yc4Eh8h3ZHx3Tv9Qmd+So42jE66YZwLJ
	Xq3lmVI1eVXM+wkox1kdCTV/wuBpz0ihGh09VSVY0Tf4sF7Ln+Zh0Ckmwp8LdgBWh5i17tS4Sxl
	A2JM80d/1PzaBBotd6U8bRjPU/8gqf4jUYUIEHv6SNnIc/R75dNDduVgKoGh5BfB1QWnAxaH3Xf
	3oiAIzv54+SCkLEQeYLFEllW2eqSe1D0TViaAQ1YA2bt6wUSJBGrNk/vhSGJ16VS9BHXOCEhz3M
	ATvyRakjY4jJw77YJFoCW/ZUJ1ackK/VPz3DRLo0thF9xBVrDeulsqGHseBKYtPaD8vuyJLPIGv
	/9XYLuIjjY=
X-Received: by 2002:a05:6a00:10cb:b0:848:19f4:3b52 with SMTP id d2e1a72fcca58-84f2e12ca0cmr263169b3a.38.1785862935375;
        Tue, 04 Aug 2026 10:02:15 -0700 (PDT)
Received: from powertower.localdomain ([64.180.35.234])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84f2e4d3926sm55508b3a.28.2026.08.04.10.02.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 10:02:14 -0700 (PDT)
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
	nickolay.lysenko@gmail.com
Subject: [RFC PATCH bpf-next v5 0/8] selftests/bpf: restructure the Makefile as a layered build
Date: Tue,  4 Aug 2026 10:01:48 -0700
Message-ID: <20260804170156.1709916-1-nickolay.lysenko@gmail.com>
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

The series opens with five small stand-alone changes, each usable
(or droppable) on its own: patch 1 filters headers off the generic
link rule's command line (gcc tolerates a stray .h there, clang
refuses); patch 2 drops four stale target-specific lines that name
objects nothing builds - redeclaring the two dependencies of value
among them in forms that work (flow_dissector_load.h against the
binary; cgroup_getset_retval_hooks.h against the BPF objects, which
the progs/*.h blanket does not cover) - plus a no-op CURDIR override;
patch 3 factors the eleven identical permissive-mode "remove the
target, print SKIP, report success" recipe tails into a skip_on_fail
helper; patch 4 makes the signing key generation race-free under -j;
patch 5 turns the verifier/tests.h $(shell)-in-recipe into a regular
recipe. The restructure itself is three steps, each independently
buildable and each producing byte-identical artifacts:

  6) the four near-identical skeleton generation recipes move into a
     parameterized helper script (gen_bpf_skel.sh);
  7) shared (non-rule) definitions move into Makefile.buildvars;
  8) each test runner instance (test_progs, test_progs-<flavor>,
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
2,960/2,960 BPF objects and 5,376/5,376 skeleton headers byte-identical
to the current Makefile's output, with identical build-artifact file
lists. For the end state additionally: all 989 userspace objects and
binaries byte-identical except bench and test_maps, which differ only
in object link order, proven by relinking the current Makefile's
objects in the new order and comparing bytes; emit_tests output and
the installed tree identical; BPF CI green on a manual pre-submission
run across x86_64 gcc/llvm, aarch64 and s390x (including GCC-BPF, ASAN
and veristat jobs); and all 76 benchmarks produce identical outcomes
on old- and new-built bench binaries.

v4 -> v5:
- the four stale target-specific lines (test_l4lb_noinline /
  test_xdp_noinline -fno-inline, flow_dissector_load.o /
  cgroup_getset_retval_hooks.o header deps) move out of the runner
  patch into a leading cleanup patch (which also redeclares the
  flow_dissector_load.h and cgroup_getset_retval_hooks.h
  dependencies, the two of the four with value, in working form), preceded by a patch filtering headers off the
  generic link command line so every intermediate state builds with
  either compiler - the series is now 6 patches; per-patch validation
  notes leave the commit messages - validation for every patch is
  summarized above instead.
- the permissive-mode skip suffix becomes the skip_on_fail helper in
  its own patch before the restructure, so the script patch's new
  skeleton recipes never carry the open-coded tails and the buildvars
  patch stays a pure move; the signing-key race fix and the
  verifier/tests.h recipe conversion likewise become their own
  patches instead of riding inside the runner patch.
- runner patch sheds incidental churn: the '# Some utility functions
  use LLVM libraries' comment moves to Makefile.runner together with
  the jit_disasm_helpers CFLAGS line it describes; the notdir
  convenience rule, the generic compile rule, BPF_GCC's stock ?=
  probe and surrounding blank lines are left exactly as they are in
  the current Makefile.
- buildvars patch: moving the srctree fallback and PKG_CONFIG into
  Makefile.buildvars put them after ../../../build/Makefile.feature is
  parsed, which captures both at parse time - in a standalone build
  srctree was empty there, so the LLVM feature probe targeted
  /tools/build/feature, failed with stderr discarded, and feature-llvm
  silently read 0: the jit-disassembler helpers compiled into their
  -EOPNOTSUPP stubs and the __jited verifier tests
  (verifier_private_stack, verifier_jit_inline, verifier_jit_convergence,
  verifier_tailcall_jit) silently flipped to SKIP, confirmed in the v4
  BPF CI logs ("llvm: [ OFF ]" in the feature display). Both now stay
  untouched at their original positions in the Makefile, with guarded
  copies kept in Makefile.buildvars for the runner sub-makes (found by
  the bpf-ci AI reviewer).
- buildvars patch: the changelog now names both evaluation-time changes
  (CFLAGS prepend, CLANG_SYS_INCLUDES immediate assignment) instead of
  claiming a single exception (bpf-ci AI reviewer).
- runner patch: the commit message no longer claims the light-skeleton
  demand lists are derived from #include lines - that derivation was
  dropped in v4; the lists stay hand-maintained (found by Sashiko AI
  review).

- v4: https://lore.kernel.org/bpf/20260724042600.175440-1-nickolay.lysenko@gmail.com/

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

Mykola Lysenko (8):
  selftests/bpf: keep headers off the generic link command line
  selftests/bpf: drop stale and no-op lines
  selftests/bpf: factor the permissive-mode skip suffix into a helper
  selftests/bpf: generate the signing key and certificate once
  selftests/bpf: generate verifier/tests.h in a regular recipe
  selftests/bpf: extract BPF skeleton generation into a helper script
  selftests/bpf: move shared build definitions into Makefile.buildvars
  selftests/bpf: build each test runner instance in its own sub-make

 tools/testing/selftests/bpf/Makefile          | 742 ++++--------------
 .../testing/selftests/bpf/Makefile.buildvars  | 171 ++++
 tools/testing/selftests/bpf/Makefile.runner   | 320 +++++++
 tools/testing/selftests/bpf/gen_bpf_skel.sh   |  93 ++
 4 files changed, 751 insertions(+), 575 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/Makefile.buildvars
 create mode 100644 tools/testing/selftests/bpf/Makefile.runner
 create mode 100755 tools/testing/selftests/bpf/gen_bpf_skel.sh


base-commit: 7f333f85f83da9a20a60a1d8bf518c4ae0818e5a
-- 
2.43.0

