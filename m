Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E32A23AEF4E
	for <bpf@vger.kernel.org>; Sun, 23 Aug 2026 19:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787514184; cv=none; b=bibkuidmbAJSdViQ4CXt53/OyUHAhDwDnZ0tKB+cuX2hO2d4f2Uc92xN0DBhmnlitpVw/wV+HNUGXu2MXXtcl2unfp9eFEeot/t00YFsizhCwG/+X1Q2+WtMLLjLVOddaTSprknQ/gaVYZhDKH1ywq+i4T+2V4kyD84lcUNYPv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787514184; c=relaxed/simple;
	bh=tDHS+HT8VAGE+O0E00sSWFYXECzy3VDpLNuUb29YAi8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Fc+97QATreYT3+tgaKXsxybuEA2STdXwiCfBIb4jb9r8h16sOr1/HICd1fw53vVfDtbdtpjko1o0rJYfTWeN0tLNcNqgOnxjcUQIFroa+yRTtT7iUFt5GEpbMIosIIwOK2y9tQm5vPut5XyZeYkYrqvr5yBr5CDD3gcqrnKTG80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZHgvPJ/v; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZHgvPJ/v"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-38e7109321dso1795174a91.3
        for <bpf@vger.kernel.org>; Sun, 23 Aug 2026 12:43:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787514181; x=1788118981; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=9RK79dwS2xRUzbYXA+7y9Odd9EfBxnmUCqXOjykQU2A=;
        b=ZHgvPJ/vhwkxvRYYKim3/rtRUSlB0VgD76JwD9oJU1uZEEIY84wS/Ja9mv4v7y72cd
         gWdzD4YeDAEBKbNUwmiFyVcfIi30zzakVZP2YT5VOUPHgP+pUjm6t2vFdVsv+sT5edIp
         fVOq/dnZmvAYTe8hWFnCcLFDWtyI8aS/LOJhbbMYCFCCitDZabft0FKiIPFU8LeyU2Qw
         8dHJGqGydRiq+P0hwU55/Peko4wyDrR52P5qvThRO6FGQJr7BqMQYwHm5tTQ6ii+zFFz
         yT/aLdwr9cmOAcqVLwWRjaS5nlP95+jYf6+BwBWd6Qqe8KWIPy04aHNkzpDUW1usEuas
         Mq7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787514181; x=1788118981;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9RK79dwS2xRUzbYXA+7y9Odd9EfBxnmUCqXOjykQU2A=;
        b=piXXh/bfs9gPWFJW1xSLS3kSgMoRMMLExr9jFxfSlcV0g8jv+2PaTDaPE9ESdA8CRt
         ayigiel5DvJzziucke7ze6pB/a27cFvr9lgeN0hl5x10jwYmQXBDjqfUEc2wdqHGuPYN
         f6V/sF9hQg0eSfaTv2SkWYFd8607iQ/XBEJlKDsgqxrjz/2mVb2dQZOKsmDF/ktQNXag
         cmljSKjXoEIv1WWMVnJUH7K4CWBbW0opqqwxE4uUxnoYvfCYGFxz7UN8x4WEzetIbLsM
         DPgMizzAJqZgr+QfMjEcU9R3Sbwi6Z+h1Y/frdJdWadgE6xGLoDQbQucmIl/Gmalnlvy
         DE0g==
X-Gm-Message-State: AFuF++nPpeXIKt+5AAFWmYrtoLun3lLvyJNKfobTBFTW3Id7JK3rBPTb
	fEUg/WAy1O4+otl6+qJ9XXDw8vsALk8k+yb929UP+83pZBGwQbRX70UEhs6dkQNQ
X-Gm-Gg: AR+sD125u1AKb8PRnppiKSxqUk5sZxQ1Rbv07T5c93zw4oKUJw3X231s5ZsHdgnfoVA
	Pp/DkAMIddbbM0v9uNxboQet09b0RMFYRCqyAmS9hqTWkRaqaVUHWCl5jFlYbZtfHwtfuiiTPvB
	LIwTh4UR7G45FMJowuSaHFtK8PmspuRK0DzeeleN9QonwyZak9FwlOQ6kgSYcAGpXIYXTwJRjPr
	EMbajCO1GDFcXnUrAMqKVkv9hiMZVyKhFTBoKTfjpuqr2yPi0VLR/Y1+wouuVfejricyiZhMK12
	LqZcMBf2wZfwkqGXUzgbGPQKczkZQJmNUIO+vHiE1qndAa63rSgpTUUk5VKhMwF9THokI8qG32P
	+NrdQdcJoKxi9PWAOKFK82e54vbwpH61clF+AIA+3atIUu/o8qFwSoAh4Hudyb7ADRQ6Y+w9m4z
	dAW2q1N1j0ZlzifdR8XzTyVzdDXDwrYyfu2FaoU0kX+NsKwqo4ZKFPUr2oFZ/D+9pqUSgnSajlr
	epsh0YSj0oTYz4/LCGp7EFByjQBVVLRdrZMhoWC4cPD/xINJFJWbUI=
X-Received: by 2002:a17:90b:1b42:b0:37f:fd1f:d30f with SMTP id 98e67ed59e1d1-395c3a06ffcmr34907992a91.12.1787514180946;
        Sun, 23 Aug 2026 12:43:00 -0700 (PDT)
Received: from powertower.tail474ae1.ts.net (d173-181-19-173.bchsia.telus.net. [173.181.19.173])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-395e4b2af01sm6839723a91.14.2026.08.23.12.42.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Aug 2026 12:43:00 -0700 (PDT)
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
Subject: [PATCH bpf-next v7 0/9] selftests/bpf: restructure the Makefile as a layered build
Date: Sun, 23 Aug 2026 12:42:32 -0700
Message-ID: <20260823194241.3415152-1-nickolay.lysenko@gmail.com>
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

The series opens with six small stand-alone changes, each usable
(or droppable) on its own: patch 1 filters headers off the generic
link rule's command line (gcc tolerates a stray .h there, clang
refuses); patch 2 drops four stale target-specific lines that name
objects nothing builds - restoring the two dependencies of value
among them in working form (flow_dissector_load.h against the
binary; cgroup_getset_retval_hooks.h by moving it under progs/,
where the blanket header prerequisite of the BPF object rules covers
it) - plus three never-referenced linked-skeleton dependency-map
entries, a no-op CURDIR override and the OBJCOPY definition nothing
reads; patch 3 factors the eleven
identical permissive-mode "remove the target, print SKIP, report
success" recipe tails into a skip_on_fail helper; patch 4 makes the
signing key generation race-free under -j; patch 5 turns the
verifier/tests.h $(shell)-in-recipe into a regular recipe; patch 6
derives the bench object list from the sources with a wildcard. The
restructure itself is three steps, each independently buildable and
each producing byte-identical artifacts:

  7) the four near-identical skeleton generation recipes move into a
     parameterized helper script (gen_bpf_skel.sh);
  8) shared (non-rule) definitions move into Makefile.buildvars;
  9) each test runner instance (test_progs, test_progs-<flavor>,
     test_maps) becomes its own plain-make sub-make (Makefile.runner),
     with the BPF object and skeleton rules both sides share in
     Makefile.skel, replacing the eval/escaping layer.

After the series the top Makefile owns everything that exists once
(toolchain setup, the libbpf/bpftool/resolve_btfids sub-builds,
vmlinux.h, all userspace objects the runners link, the default
flavor's BPF objects and skeletons, standalone binaries, and the
lib.mk run/install contract), while every runner instance is an
ordinary single-flavor makefile with no escaping. Total line count is
roughly a wash; the point is the structure, not the size.

Validation (each patch, x86_64, identical toolchains, clean builds):
3,031 BPF objects and 5,517 skeleton headers byte-identical to the
current Makefile's output - except the one object whose header
patch 2 moves (and its skeletons), which differs only in the
source-path strings recorded in BTF/debug info, verified by
comparing the objects with those sections stripped - with identical
build-artifact file lists through patch 8. For the end state
additionally: all userspace objects and binaries byte-identical
except (a) bench (from patch 6 on) and test_maps, which differ only
in object link order, proven by relinking the current Makefile's
objects in the new order and comparing bytes, (b) the test_progs binaries and two test
objects that embed the moved header's skeleton or record its path,
and (c) the flavor output directories, which no longer contain their
21 duplicate copies each of the shared userspace objects (the
flavored binaries link the shared objects); emit_tests output and
the installed tree identical; BPF CI green on manual pre-submission
runs of the full series and of every cumulative intermediate
(patch 1, patches 1-2, ..., patches 1-8) across x86_64 gcc/llvm,
aarch64 and s390x, including the GCC-BPF, ASAN and veristat jobs;
and all 78 benchmarks produce identical outcomes on old- and
new-built bench binaries.

v6 -> v7 (BPF CI AI review of v6, all findings verified):
- patch 8: an exported CFLAGS/LDFLAGS changed position - the split
  had put Makefile.buildvars' flags in front of the environment's
  instead of after them, so e.g. an exported -O2 overrode the
  selftests' -O0 and environment -I paths moved behind the tree's.
  The Makefile now snapshots the inherited flags before including
  lib.mk and Makefile.buildvars rebuilds both variables as
  [inherited] [its own] [lib.mk's additions]; the runner sub-makes
  start from the same snapshot (handed down in the environment)
  rather than from the assembled value. With CFLAGS, LDFLAGS,
  USERCFLAGS and USERLDFLAGS all set, the top-level and runner-side
  values are now identical to the current Makefile's
- patch 9: CLANG is passed to the runner sub-makes like CC, so the
  clang feature probe in Makefile.buildvars tests the LLVM=-selected
  compiler there too (it fell back to plain clang, and could disagree
  with the top level on HAS_BPF_ARENA_ASAN); the unflavored in-tree
  instance recognizes a tree reached through a symlink (realpath of
  OUTPUT against CURDIR; the two compared a logical and a physical
  path); the userspace objects depend on the tests.h of the runner
  that includes them only, instead of every object on both; the
  objects order against $(TRUNNER_BPFTOOL) rather than $(BPFTOOL),
  which is the sub-make that installs libbpf's internal headers into
  $(INCLUDE_DIR) when cross-compiling as well; the dead BPF_GCC export
  is gone (the bpf_gcc flavor gets it as its compiler parameter)
- patch 2: the '-fno-inline' pair had been ineffective since commit
  74b5a5968fe8 (2019), not since the .bpf.o rename: the compile recipe
  expands a simply-expanded copy of BPF_CFLAGS, which a target-specific
  append cannot reach - the changelog said so incorrectly
- every commit message was checked claim by claim against its diff
  and its parent tree, and every hunk against the message: stale
  statements left over from earlier respins are corrected, the
  behaviour deltas the runner patch carries are now listed in its
  message, and stock comments that had been reworded along the way
  are back to their original text
- patch 4: the genkey pattern rule is narrowed to the signing_key
  stem ($(BUILD_DIR)/%_key.pem %_key.der) - the .pem/.der form matched
  every such file under tools/build; the changelog now says the
  two-target race is a prerequisite for patch 9 rather than reachable
  today (nothing lists $(PRIVATE_KEY) as a prerequisite before then)
- patch 7: gen_bpf_skel.sh checks for PRIVATE_KEY/VERIFICATION_CERT
  before creating any intermediate (the ${VAR:?} expansion fired after
  them, skipping the cleanup); the changelog notes that intermediates
  are named after the output header now (foo.linked1.o, not
  foo.bpf.linked1.o)
- patch 2: retitled (it restores two header dependencies, not only
  drops lines) and the flow_dissector_load.h dependency sits on the
  line that already lists the binary's helper object
- patch 6, 8: changelog corrections (bench list tail, VERIFY_SIG_HDR,
  LIBARENA_BENCH_SKEL, the third evaluation-time change: the arena
  ASAN probe runs after lib.mk resolves CLANG)
- Acked-by on patches 4 and 7 kept through the small code changes
  above
- v6: https://lore.kernel.org/bpf/20260823010900.1730708-1-nickolay.lysenko@gmail.com/

v5 -> v6 (all on review of v5 - thanks Eduard!):
- the permissive-mode missing-input guards at the top of the skeleton
  recipes are restored, factored into a skip_if_missing helper next
  to skip_on_fail: when a BPF object's compile already failed and was
  skipped, the skeleton skips quietly again (SKIP-SKEL and nothing
  else) instead of running bpftool against the missing file first
  (reported by Sashiko AI review on v5 patch 6; v5 had regressed the
  guards away, changing permissive-mode build logs)
- patch 2: cgroup_getset_retval_hooks.h moves under progs/ next to
  its BPF consumer instead of growing a hand-written per-flavor
  dependency line - the blanket progs/*.h prerequisite covers it
  (suggested by Eduard)
- patch 2 also picks up the three linked-skeleton -deps map entries
  (xsk_xdp_progs, xdp_hw_metadata, xdp_features) that were dead on
  arrival - added without ever being listed in LINKED_SKELS, the only
  reader of that map - instead of letting them disappear silently
  with the machinery in patch 9
- patch 7: the Makefile.buildvars include is hoisted to directly
  after ../lib.mk, ahead of the Makefile.feature evaluation, so the
  srctree fallback and PKG_CONFIG live only in Makefile.buildvars and
  the top Makefile's duplicates are gone (suggested by Eduard)
- patch 8: the userspace objects the runners link are built once by
  the main Makefile from per-runner lists in Makefile.buildvars; the
  runner loses its object compile rules, disables make's built-in
  rules so a missing object is an error instead of a silent rebuild
  with default flags, and the flavored instances link the shared
  objects instead of compiling identical copies (patch by Eduard,
  replacing the HELPER_OBJS pre-build arrangement and its
  keep-in-sync invariant)
- the rules for one flavor's BPF objects and skeletons move into
  Makefile.skel, instantiated by the main Makefile
  for the default flavor and by Makefile.runner for the flavored
  instances - bench, xskxceiver, xdp_*, test_cpp and the install list
  depend on exactly the skeletons they consume again (cold "make
  bench" builds 19 BPF objects and 19 skeletons instead of the full
  default-flavor pass), and the default-skels indirection with its
  delegation rules is gone; Makefile.skel is self-contained - the
  hand-maintained skeleton metadata (demand lists, LINKED_SKELS with
  its -deps map, the blacklist, the header list, per-source flag
  overrides) sits next to the derivations and rules that read it,
  and Makefile.buildvars keeps only definitions shared between files
  (the Makefile.skel split suggested by Eduard)
- the buildvars move set is trimmed to match: CXX, BPFTOOLDIR,
  HOST_BPFOBJ, BPF_TARGET_ENDIAN, CLANG_CFLAGS and VERIFY_SIG_HDR are
  read by nothing outside the main Makefile and stay in it
- the bench object list derivation is split out of the runner patch
  into its own lead patch (6), which also carries the resulting bench
  link-order change; rebasing onto current bpf-next, the new bpf_for
  and libarena benchmarks are picked up by the derived list, and the
  xskxceiver/xdp decoupling commit is untouched by the series (those
  standalone binaries keep their stock rules and exact dependencies)
- the runner patch carries a FORCE comment; each patch cleans up only
  its own comment and blank-line leftovers (suggested by Eduard)
- Acked-by collected on patches 1, 3, 4, 5 and 7 (patch 7 was acked
  as v5 patch 6; it since gained the skip_if_missing guards above)
- the RFC tag is dropped - the direction question the RFC asked has
  its answer in the v5 review
- v5: https://lore.kernel.org/bpf/20260804170156.1709916-1-nickolay.lysenko@gmail.com/

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

Mykola Lysenko (9):
  selftests/bpf: keep headers off the generic link command line
  selftests/bpf: drop stale lines, restore two header dependencies
  selftests/bpf: factor the permissive-mode skip suffix into a helper
  selftests/bpf: generate the signing key and certificate once
  selftests/bpf: generate verifier/tests.h in a regular recipe
  selftests/bpf: derive the bench object list from the sources
  selftests/bpf: extract BPF skeleton generation into a helper script
  selftests/bpf: move shared build definitions into Makefile.buildvars
  selftests/bpf: build each test runner instance in its own sub-make

 tools/testing/selftests/bpf/Makefile          | 741 ++++--------------
 .../testing/selftests/bpf/Makefile.buildvars  | 196 +++++
 tools/testing/selftests/bpf/Makefile.runner   | 199 +++++
 tools/testing/selftests/bpf/Makefile.skel     | 141 ++++
 tools/testing/selftests/bpf/gen_bpf_skel.sh   |  99 +++
 .../bpf/prog_tests/cgroup_getset_retval.c     |   2 +-
 .../{ => progs}/cgroup_getset_retval_hooks.h  |   0
 7 files changed, 795 insertions(+), 583 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/Makefile.buildvars
 create mode 100644 tools/testing/selftests/bpf/Makefile.runner
 create mode 100644 tools/testing/selftests/bpf/Makefile.skel
 create mode 100755 tools/testing/selftests/bpf/gen_bpf_skel.sh
 rename tools/testing/selftests/bpf/{ => progs}/cgroup_getset_retval_hooks.h (100%)


base-commit: a284ed47ec1fd4aa63d2318d87f457cc421a93b5
-- 
2.43.0

