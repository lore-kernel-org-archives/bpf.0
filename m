Return-Path: <SRS0=9Oao=SO=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9349BC282DE
	for <bpf@archiver.kernel.org>; Fri, 12 Apr 2019 22:00:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AD422084D
	for <bpf@archiver.kernel.org>; Fri, 12 Apr 2019 22:00:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="GlkMrMoK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727160AbfDLWAD (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 12 Apr 2019 18:00:03 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46616 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727154AbfDLWAD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 12 Apr 2019 18:00:03 -0400
Received: by mail-wr1-f65.google.com with SMTP id t17so13678105wrw.13
        for <bpf@vger.kernel.org>; Fri, 12 Apr 2019 15:00:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1Ci9G/d/xZdPNXlJhIHN17X5m5I4GPdqFBwP5h6Pl64=;
        b=GlkMrMoKb1tJ1zlr0jy1TCNDh4+ldsTVBkoe4ebZI3JANS/UH5QfLcx9NP+WlDBxCw
         CmVnYYFgIHtWROYMKvHRxXFet9VtCX3pgot1pKvlJ9Rq7MZmePfQUrKy72+GKkxxrxca
         6GOIuaaEwsirUCjarNNReBL7nnXKK0ziaxU+jxSWJKElYfEBvGBBBhasLs7aV16lHqfB
         dyyN/sDHDRxRDX46wkBXmlhCeb/+NLTBfhGBNyqmk/p/GhrJKDgDiTehOJVTnwGhNuFM
         sZYD5Q/UqgFEZWmwYOWW85/fUo5mV4tNDe8uzaBPW3m0HhMoMJom4dCIbhCJK1UP6A6u
         IMSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1Ci9G/d/xZdPNXlJhIHN17X5m5I4GPdqFBwP5h6Pl64=;
        b=uauPJuPLOFieK7SW8h8Ad4opibPB7yrUColIF+nyDCQxq4k2t7KWESgndDes/tGUw8
         RBtvkto1Ntnb4lqIaMuWJOkJ7Rs27cR88d8LY+RKWfczNqLwz/CETPs3CGT071svVhqb
         z/jVnwKOc/lL3ujrZ54ho+w5ecfXGpPhcRendbGEjgb97WERc6lDA09cGRi4Toa5v+Vb
         yjN9zwqRy2L9e/wDH5xRIFJBuf4hLu1lCsT4e21tlpO9AyfQ53+6Q/DGJHTpaFHtl5gc
         Nc19jorE7Nmj6+SE1e+O6oFQQ1GARazxB7S5xLaLMC+YcnikFAMt2+rnv+l1XlpetsK/
         cz/Q==
X-Gm-Message-State: APjAAAWn/5sRCXhs+OCum9YElGcLNHpVdzra8wjPxbwOrgDTDXwsViIM
        3+euSYI+vT/CVDGWwSBFPfmTbQ==
X-Google-Smtp-Source: APXvYqy4WH1s1sv2HIweJ1/W8Svp3JRlzKOHimgH1B3Gxv9oLtC8lLXVn+bY5Cz0Fp1v+H9cxvnJkA==
X-Received: by 2002:adf:ce8c:: with SMTP id r12mr18363004wrn.60.1555106400823;
        Fri, 12 Apr 2019 15:00:00 -0700 (PDT)
Received: from cbtest28.netronome.com ([217.38.71.146])
        by smtp.gmail.com with ESMTPSA id f1sm8490764wml.28.2019.04.12.14.59.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 12 Apr 2019 15:00:00 -0700 (PDT)
From:   Jiong Wang <jiong.wang@netronome.com>
To:     alexei.starovoitov@gmail.com, daniel@iogearbox.net
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org,
        oss-drivers@netronome.com, Jiong Wang <jiong.wang@netronome.com>,
        "David S . Miller" <davem@davemloft.net>,
        Paul Burton <paul.burton@mips.com>,
        Wang YanQing <udknight@gmail.com>,
        Zi Shen Lim <zlim.lnx@gmail.com>,
        Shubham Bansal <illusionist.neo@gmail.com>,
        "Naveen N . Rao" <naveen.n.rao@linux.ibm.com>,
        Sandipan Das <sandipan@linux.ibm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Jakub Kicinski <jakub.kicinski@netronome.com>
Subject: [PATCH v3 bpf-next 00/19] bpf: eliminate zero extensions for sub-register writes
Date:   Fri, 12 Apr 2019 22:59:33 +0100
Message-Id: <1555106392-20117-1-git-send-email-jiong.wang@netronome.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

v3:
  - remove redundant check in "propagate_liveness_reg". (Jakub)
  - add extra check in "mark_reg_read" to prune more search. (Jakub)
  - re-implemented "prog_flags" passing mechanism, removed use of
    global switch inside libbpf.
  - enabled high 32-bit randomization beyond "test_verifier" and
    "test_progs". Now it should have been enabled for all possible
    tests. Re-run all tests, haven't noticed regression.
  - remove RFC tag.

v2:
  - rebased on top of bpf-next master.
  - added comments for what is sub-register def index. (Edward, Alexei)
  - removed patch 1 which turns bit mask from enum to macro. (Alexei)
  - removed sysctl/bpf_jit_32bit_opt. (Alexei)
  - merged sub-register def insn index into reg state. (Alexei)
  - change test methodology (Alexei):
      + instead of simple unit tests on x86_64 for which this optimization
        doesn't enabled due to there is hardware support, poison high
        32-bit for whose def identified as safe to do so. this could let
        the correctness of this patch set checked when daily bpf selftest
        ran which delivers very stressful test on host machine like x86_64.
      + hi32 poisoning is gated by a new BPF_F_TEST_RND_HI32 prog flags.
      + BPF_F_TEST_RND_HI32 is enabled for all tests of "test_progs" and
        "test_verifier", the latter needs minor tweak on two unit tests,
        please see the patch for the change.
      + introduced a new global variable "libbpf_test_mode" into libbpf.
        once it is set to true, it will set BPF_F_TEST_RND_HI32 for all the
        later PROG_LOAD syscall, the goal is to easy the enable of hi32
        poison on exsiting testsuite.
        we could also introduce new APIs, for example "bpf_prog_test_load",
        then use -Dbpf_prog_load=bpf_prog_test_load to migrate tests under
        test_progs, but there are several load APIs, and such new API need
        some change on struture like "struct bpf_prog_load_attr".
      + removed old unit tests. it is based on insn scan and requires quite
        a few test_verifier generic code change. given hi32 randomization
        could offer good test coverage, the unit tests doesn't add much
        extra test value.
  - enhanced register width check ("is_reg64") when record sub-register
    write, now, it returns more accurate width.
  - Re-run all tests under "test_progs" and "test_verifier" on x86_64, no
    regression. Fixed a couple of bugs exposed:
      1. ctx field size transformation was not taken into account.
      2. insn patch could cause lost of original aux data which is
         important for ctx field conversion.
      3. return value for propagate_liveness was wrong and caused
         regression on processed insn number.
      4. helper call arg wasn't handled properly that path prune may cause
         64-bit read info in pruned path lost.
  - Re-run Cilium bpf prog for processed-insn-number benchmarking, no
    regression.

eBPF ISA specification requires high 32-bit cleared when low 32-bit
sub-register is written. This applies to destination register of
ALU32/LD_H/B/W etc. JIT back-ends must guarantee this semantic when doing
code-gen.

x86-64 and arm64 ISA has the same semantics, so the corresponding JIT
back-end doesn't need to do extra work. However, 32-bit arches (arm, nfp
etc.) and some other 64-bit arches (powerpc, sparc etc), need explicitly
zero extension sequence to meet such semantic.

This is important, because for C code like the following:

  u64_value = (u64) u32_value
  ... other uses of u64_value

compiler could exploit the semantic described above and save those zero
extensions for extending u32_value to u64_value. Hardware, runtime, or BPF
JIT back-ends, are responsible for guaranteeing this. Some benchmarks shows
~40% sub-register writes out of total insns, meaning ~40% extra code-gen
and could go up for arches requiring two shifts for zero extension. All
these are because JIT back-end needs to do extra code-gen for all such
instructions, always.

However this is not always necessary in case u32 value is never cast into a
u64, which is quite normal in real life program. So, it would be really
good if we could identify those places where such type cast happened, and
only do zero extensions for them, not for the others. This could save a lot
of BPF code-gen.

Algo
====
We could use insn scan based static analysis to tell whether one
sub-register def doesn't need zero extension. However, using such static
analysis, we must do conservative assumption at branching point where
multiple uses could be introduced. So, for any sub-register def that is
active at branching point, we need to mark it as needing zero extension.
This could introducing quite a few false alarms, for example ~25% on
Cilium bpf_lxc.

It will be far better to use dynamic data-flow tracing which verifier
fortunately already has and could be easily extend to serve the purpose of
this patch set.

 - Record indices of instructions that do sub-register def (write). And
   these indices need to stay with function state so path pruning and bpf
   to bpf function call could be handled properly.

   These indices are kept up to date while doing insn walk.

 - A full register read on an active sub-register def marks the def insn as
   needing zero extension on dst register.

 - A new sub-register write overrides the old one.

   A new full register write makes the register free of zero extension on
   dst register.

 - When propagating register read64 during path pruning, it also marks def
   insns whose defs are hanging active sub-register, if there is any read64
   from shown from the equal state.

 The core patch in this set is patch 4.

Benchmark
=========
 - I estimate the JITed image could be 25% smaller on average on all these
   affected arches (nfp, arm, x32, risv, ppc, sparc, s390).

 - The implementation is based on existing register read liveness tracking
   infrastructure, so it is dynamic tracking and would trace all possible
   code paths, therefore, it shouldn't be any false alarm.

   For Cilium bpf_lxc, there is ~11500 insns in the compiled binary (use
   latest LLVM snapshot, and with -mcpu=v3 -mattr=+alu32 enabled), 4460 of
   them has sub-register writes (~40%). Calculated by:

    cat dump | grep -P "\tw" | wc -l       (ALU32)
    cat dump | grep -P "r.*=.*u32" | wc -l (READ_W)
    cat dump | grep -P "r.*=.*u16" | wc -l (READ_H)
    cat dump | grep -P "r.*=.*u8" | wc -l  (READ_B)

   After this patch set enabled, 647 out of those 4460 are identified as
   really needing zero extension on the destination, then it is safe for
   JIT back-ends to eliminate zero extension for all the other instructions
   which is ~85% of all those sub-register write insns or 33% of total
   insns. It is a significant save.

   For those 647 insns marked as needing zero extension, part of them are
   setting up u64 parameters for help calls, remaining ones are those whose
   sub-register defs really have 64-bit reads.

ToDo
====
 - eBPF doesn't have zero extension instruction, so lshift and rshift are
   used to do it, meaning two native insns while JIT back-ends could just
   use one truncate insn if they understand the lshift + rshift is just
   doing zero extension.

   There are three approaches to fix this:

     - Minor change on back-end JIT hook, also pass aux_insn information to
       back-ends so they could have per insn information and they could do
       zero extension for the marked insn themselves using the most
       efficient native insn.

    - Introduce zero extension insn for eBPF. Then verifier could insert
      the new zext insn instead of lshift + rshift. zext could be JITed
      more efficiently.

      NOTE: existing MOV64 can't be used as zero extension insn, because
            after zext optimization enabled, MOV64 doesn't necessarily
            clear high 32-bit.

    - Otherwise JIT back-ends need to do peephole to catch lshift + rshift
      and turn them into native zext.

 - In this set, for JIT back-ends except NFP, I have only enabled the
   optimization for ALU32 instructions, while it could be easily enabled
   for load instruction.

Reviews
=======
 - Fixed the missing handling on callee-saved for bpf-to-bpf call,
   sub-register defs therefore moved to frame state. (Jakub Kicinski)
 - Removed redundant "cross_reg". (Jakub Kicinski)
 - Various coding styles & grammar fixes. (Jakub Kicinski, Quentin Monnet)

Cc: David S. Miller <davem@davemloft.net>
Cc: Paul Burton <paul.burton@mips.com>
Cc: Wang YanQing <udknight@gmail.com>
Cc: Zi Shen Lim <zlim.lnx@gmail.com>
Cc: Shubham Bansal <illusionist.neo@gmail.com>
Cc: Naveen N. Rao <naveen.n.rao@linux.ibm.com>
Cc: Sandipan Das <sandipan@linux.ibm.com>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Jakub Kicinski <jakub.kicinski@netronome.com>

Jiong Wang (19):
  bpf: refactor propagate_liveness to eliminate duplicated for loop
  bpf: refactor propagate_liveness to eliminate code redundance
  bpf: factor out reg and stack slot propagation into
    "propagate_liveness_reg"
  bpf: refactor "check_reg_arg" to eliminate code redundancy
  bpf: split read liveness into REG_LIVE_READ64 and REG_LIVE_READ32
  bpf: mark lo32 writes that should be zero extended into hi32
  bpf: reduce false alarm by refining helper call arg types
  bpf: insert explicit zero extension insn when hardware doesn't do it
    implicitly
  bpf: introduce new bpf prog load flags "BPF_F_TEST_RND_HI32"
  bpf: randomize high 32-bit when BPF_F_TEST_RND_HI32 is set
  libbpf: add "prog_flags" to
    bpf_program/bpf_prog_load_attr/bpf_load_program_attr
  selftests: enable hi32 randomization for all tests
  arm: bpf: eliminate zero extension code-gen
  powerpc: bpf: eliminate zero extension code-gen
  s390: bpf: eliminate zero extension code-gen
  sparc: bpf: eliminate zero extension code-gen
  x32: bpf: eliminate zero extension code-gen
  riscv: bpf: eliminate zero extension code-gen
  nfp: bpf: eliminate zero extension code-gen

 arch/arm/net/bpf_jit_32.c                          |  22 +-
 arch/powerpc/net/bpf_jit_comp64.c                  |   7 +-
 arch/riscv/net/bpf_jit_comp.c                      |  32 +-
 arch/s390/net/bpf_jit_comp.c                       |  13 +-
 arch/sparc/net/bpf_jit_comp_64.c                   |   8 +-
 arch/x86/net/bpf_jit_comp32.c                      |  32 +-
 drivers/net/ethernet/netronome/nfp/bpf/jit.c       | 119 +++---
 drivers/net/ethernet/netronome/nfp/bpf/main.h      |   2 +
 drivers/net/ethernet/netronome/nfp/bpf/verifier.c  |  12 +
 include/linux/bpf.h                                |   4 +
 include/linux/bpf_verifier.h                       |  14 +-
 include/linux/filter.h                             |   1 +
 include/uapi/linux/bpf.h                           |  18 +
 kernel/bpf/core.c                                  |  10 +-
 kernel/bpf/helpers.c                               |   2 +-
 kernel/bpf/syscall.c                               |   4 +-
 kernel/bpf/verifier.c                              | 407 +++++++++++++++++++--
 net/core/filter.c                                  |  28 +-
 tools/include/uapi/linux/bpf.h                     |  18 +
 tools/lib/bpf/bpf.c                                |   1 +
 tools/lib/bpf/bpf.h                                |   1 +
 tools/lib/bpf/libbpf.c                             |   3 +
 tools/lib/bpf/libbpf.h                             |   1 +
 tools/testing/selftests/bpf/Makefile               |  10 +-
 .../selftests/bpf/prog_tests/bpf_verif_scale.c     |   1 +
 tools/testing/selftests/bpf/test_sock_addr.c       |   1 +
 tools/testing/selftests/bpf/test_sock_fields.c     |   1 +
 tools/testing/selftests/bpf/test_socket_cookie.c   |   1 +
 tools/testing/selftests/bpf/test_stub.c            |  40 ++
 tools/testing/selftests/bpf/test_verifier.c        |   6 +-
 30 files changed, 669 insertions(+), 150 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/test_stub.c

-- 
2.7.4

