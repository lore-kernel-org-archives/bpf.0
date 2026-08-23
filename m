Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0592937A836
	for <bpf@vger.kernel.org>; Sun, 23 Aug 2026 01:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787447368; cv=none; b=bQzux/i13gYu9oqIE+uUK7vbojE22D8ZoumE+Nk0cHBe5YXo4IE5rqsplmwMM1wIZET62YI6qd9mu/at0JpOAKXpdaTFWbUAZLZCD28ldiMywgoA0oF6wjWZQUmxLAPN6ad+5wwU5ANCVuFHOq3GWzbcAKkjfKXbyz91TWNmlMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787447368; c=relaxed/simple;
	bh=Xan4vJZCB5TZsjt2mx2cHcFS1RSzNrCxD8qgU2FFA/k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=L/Uhx51X0pkLtdcYLuhYuQDz+SNKbm8oQOJSXMj5+2rvO6WmHk14QLn0FrKBjSl83CH4uvdpI1RALeGv/AcXxG6bhc/fk2K4QrY9Ailu5nObCPwoCFkr1OMVY8rIUfbZ2tMoCGYko9RFRWWirTwf00FDnJ4fZrz7wVprsgqVg3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WrukjR1Q; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WrukjR1Q"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-38759bcd877so2682186a91.2
        for <bpf@vger.kernel.org>; Sat, 22 Aug 2026 18:09:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787447360; x=1788052160; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=o/gH69iTHpDhaF44vGh2D3DmfkRNEJwYrKIE9aO+tfA=;
        b=WrukjR1Q9Tvhxneo5wIBRpCdXSLxG/q3AjurUJv9ivl8fn8b0ryN1yIAWSq2thDeQs
         F45kq/LjgI6LTnWhAPuXWVVnZwoOHg8F6XDUOej1gBKS/3iaM5VLnms6OvF98KSS0Eaq
         /saSczepMaIrumaBCVMWXcwX9gFz28mWsGU0iyVRqwWgocL7w4dx8UBvUGKWxkBQgaUP
         2wRqM4SrzuztyCPqqq9UbSrhBOPPcX+SEf89eFe5Upl1Jk+zqNSE7AX2bHZOCWfk2hdR
         dPihOz6swjMlOkNMwYbC++24tXSGvuehVjD9pb5EKSP7oLPIudSJ0E90u1XbJwtwhiz4
         ocNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787447360; x=1788052160;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=o/gH69iTHpDhaF44vGh2D3DmfkRNEJwYrKIE9aO+tfA=;
        b=QoneAt3KyWRlDx0gWpqXVCqPfb5am/lzoe4sXl1zKzvcgSTfVehA/ldl7JWbIF69WM
         jI2oo6b+qiy9zo94IQ4fUhnI61TbVrR2VtHA7qtCLBlCjYwkpvvuqoJ4C9Wsp3pqBkeR
         E89LthVgwVzUHEzdr2RN1gA/1LCaRkvA+HFfuQrlmkvg9xOx/NjWcTZQ8pYqu+atpLuS
         B88tsNui6IDoTOKXw4FAhkZaG5+b5yn6aEe8Y7LW6fKS4+JmmFfaguLUzxdT3dOvhZJb
         MC/gxj8LpWt0iOX+/MD9MFdjftBcYF8IoqHvY03nwjjFD/FclLrBY87WHqnaiHGMJvEn
         yr0Q==
X-Gm-Message-State: AFuF++khQZeOBTbZOYXcGALv+9HB1BFUo8f6oRxN9P2+6bHvOcCj0blB
	9NRAKLcYCrYr0C5zpUPj7TVz7nPuYeSCzqBO8jqw2s6DT+w7QApoHElwDSKMVzbo
X-Gm-Gg: AR+sD10UN0kjfxteXTVYKOxyXd3MXbXRaDvzEQ168inHuSfbA9QclBjndoivRSrVhXO
	MHCF1/0MeygYGcK/vwhH0iozkmyeWrreZaRpjQmeCZk8S/631RxtI6logBj/5Fa+aqrbpPEFAho
	CPgwu+FqK9e3BIeyfcV209TgD6ZWOBLxMJRQRhlzX5Sce73wMzMvlTM9IYFFj6hGhnkFOEryp59
	tx7J3fZYr2lkvHZif/zR2XKbR9bbcgcKs2zE0fy5Q6JKLdopTpyEF/JHsHb4SHoyftjNbQuxuCS
	SK3Nc7UOq2rVuZKWODywuibNKbgS8y/ahlHdNiKA8TfUm2Y7wRAUd3WCG8J3aZ2/D9Ty4IUvJkL
	68RSm9q2kjHcnTxi8vgnn/oWTDCIlrNBWPSs14Ujk7/VYVFMUt23cs6MSluObcF1r1GzmjjtXTS
	Pk+UEjqFe1bTU86fk8UzehksqT10nVMmLZ3vs1bkFVGuSYfiKE4jCgoTGR6vMsnT0qppyL4HaI/
	QFj2HLso5o7XxpJXP1RfQmfBxATG75GAEH4buluCpyxUhhhx4YU94k=
X-Received: by 2002:a17:90b:39ab:b0:393:19a3:4e5 with SMTP id 98e67ed59e1d1-395df686f1dmr14020217a91.16.1787447360261;
        Sat, 22 Aug 2026 18:09:20 -0700 (PDT)
Received: from powertower.tail474ae1.ts.net (d173-181-19-173.bchsia.telus.net. [173.181.19.173])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-395e4b240e7sm4219994a91.13.2026.08.22.18.09.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Aug 2026 18:09:19 -0700 (PDT)
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
Subject: [PATCH bpf-next v6 0/9] selftests/bpf: restructure the Makefile as a layered build
Date: Sat, 22 Aug 2026 18:08:51 -0700
Message-ID: <20260823010900.1730708-1-nickolay.lysenko@gmail.com>
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
  selftests/bpf: drop stale and no-op lines
  selftests/bpf: factor the permissive-mode skip suffix into a helper
  selftests/bpf: generate the signing key and certificate once
  selftests/bpf: generate verifier/tests.h in a regular recipe
  selftests/bpf: derive the bench object list from the sources
  selftests/bpf: extract BPF skeleton generation into a helper script
  selftests/bpf: move shared build definitions into Makefile.buildvars
  selftests/bpf: build each test runner instance in its own sub-make

 tools/testing/selftests/bpf/Makefile          | 736 ++++--------------
 .../testing/selftests/bpf/Makefile.buildvars  | 185 +++++
 tools/testing/selftests/bpf/Makefile.runner   | 175 +++++
 tools/testing/selftests/bpf/Makefile.skel     | 143 ++++
 tools/testing/selftests/bpf/gen_bpf_skel.sh   |  93 +++
 .../bpf/prog_tests/cgroup_getset_retval.c     |   2 +-
 .../{ => progs}/cgroup_getset_retval_hooks.h  |   0
 7 files changed, 749 insertions(+), 585 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/Makefile.buildvars
 create mode 100644 tools/testing/selftests/bpf/Makefile.runner
 create mode 100644 tools/testing/selftests/bpf/Makefile.skel
 create mode 100755 tools/testing/selftests/bpf/gen_bpf_skel.sh
 rename tools/testing/selftests/bpf/{ => progs}/cgroup_getset_retval_hooks.h (100%)


base-commit: 669e4fa766000ae4137bb02eb22ce75ba78ad32d
-- 
2.43.0

