Return-Path: <SRS0=dSBe=R5=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E06FC43381
	for <bpf@archiver.kernel.org>; Tue, 26 Mar 2019 18:06:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4E512082F
	for <bpf@archiver.kernel.org>; Tue, 26 Mar 2019 18:06:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="rt4za1jL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727492AbfCZSGg (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 26 Mar 2019 14:06:36 -0400
Received: from mail-wr1-f41.google.com ([209.85.221.41]:40130 "EHLO
        mail-wr1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732369AbfCZSGf (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 26 Mar 2019 14:06:35 -0400
Received: by mail-wr1-f41.google.com with SMTP id t5so15435081wri.7
        for <bpf@vger.kernel.org>; Tue, 26 Mar 2019 11:06:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IOikUeECF/r7GX29Pc2+VvZqIYMcB9McX9L7DZ5QQrE=;
        b=rt4za1jLk6ISzW/ToMTCyXeVpR+EF19GmKPTkV8qcRQZHFE5Cjjzc5PcTzy4Ejh2lQ
         oAD14y8iRCfl1O3onWJxTt70J1qC3MFqvJQMKnEr0AS24iAJwdWL8U6iEueoQXR/6ASq
         poqgpLeDtCpX57nBuzGQwhtJvk5y61Lbjhl7Eju+BIcEcsXInHzQ7kLtWWTfoXazCJfA
         /2Z9pXU3i5v5Q2le/oJJhYHQ2NWK6/YVFy//KTOl+/L/VjppRf8JRJtI/D3TPCY4oKzb
         ho7Le4trGgKFcwWx6OTZgorL7yPDtzewmHUXNonU1+2ovLa8WFaLQ3iKFLP7gn5FrOe8
         X9KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IOikUeECF/r7GX29Pc2+VvZqIYMcB9McX9L7DZ5QQrE=;
        b=GGNDv5pT3/KBHvZQQcAjfIPhL1TIhMeE1QX6EWE3ClMeGYGI59RSgda0zBWnseqlUe
         HVQdf4k6iSYh1LkL/79BEqfbSbfqkJNqNIVjCMd/Dwh/qUeBpoixLTZOZZbMnTVXUGOp
         tyLkCF5w2/CDEhHFNSBqq8SGTPVj9FqLsF1B/bqtfvLGIKRS/Mf9vDwZyZKaIx376HYE
         m9dMCGCEsyCDCUk2FnryU5YzHriNTAdLp7lWzGkuESmtXAWc6tdh64aDAH790MtUxsKP
         njElHcHvF6m+lmcrAdw2EZU4w427VMlq8vYhzoYXCUHl3AL2r/o5ntSkgy0gM8ck9v8y
         5n1g==
X-Gm-Message-State: APjAAAWIMdaxmoWdvCErLJqSOGTQM4eWkKdLt+meD4n4OoinyQ+5ihO1
        /GMp1bcerkrjuIl4r2NuCSm2VQ==
X-Google-Smtp-Source: APXvYqwZDbKYIhXbA6xhvoeUwb4w8EIXRYupKmI9glHw3FBeLy1TLjdF3T7VtlhHOMaE00VVvitvRA==
X-Received: by 2002:adf:e4c2:: with SMTP id v2mr17110758wrm.124.1553623593430;
        Tue, 26 Mar 2019 11:06:33 -0700 (PDT)
Received: from cbtest28.netronome.com ([217.38.71.146])
        by smtp.gmail.com with ESMTPSA id i28sm36697534wrc.32.2019.03.26.11.06.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 26 Mar 2019 11:06:32 -0700 (PDT)
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
Subject: [PATCH/RFC bpf-next 00/16] bpf: eliminate zero extensions for sub-register writes
Date:   Tue, 26 Mar 2019 18:05:23 +0000
Message-Id: <1553623539-15474-1-git-send-email-jiong.wang@netronome.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

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

Tetsting
========
A couple of unit tests have been added including cases for path pruning
etc. It would be great if any affected host arch could apply this patch set
then test bpf selftest under sub-register code-gen mode, test_progs which
contains quite a few C programs will be a very good coverage.

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
   for load instruction. I could do a follow up patch set for this.

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

Jiong Wang (16):
  bpf: turn "enum bpf_reg_liveness" into bit representation
  bpf: refactor propagate_live implementation
  bpf: split read liveness into REG_LIVE_READ64 and REG_LIVE_READ32
  bpf: mark sub-register writes that really need zero extension to high
    bits
  bpf: reduce false alarm by refining "enum bpf_arg_type"
  bpf: new sysctl "bpf_jit_32bit_opt"
  bpf: insert explicit zero extension instructions when
    bpf_jit_32bit_opt is true
  arm: bpf: eliminate zero extension code-gen
  powerpc: bpf: eliminate zero extension code-gen
  s390: bpf: eliminate zero extension code-gen
  sparc: bpf: eliminate zero extension code-gen
  x32: bpf: eliminate zero extension code-gen
  riscv: bpf: eliminate zero extension code-gen
  nfp: bpf: eliminate zero extension code-gen
  selftests: bpf: new field "xlated_insns" for insn scan test after
    verification
  selftests: bpf: unit testcases for zero extension insertion pass

 Documentation/sysctl/net.txt                      |  15 +
 arch/arm/net/bpf_jit_32.c                         |  22 +-
 arch/powerpc/net/bpf_jit_comp64.c                 |   7 +-
 arch/riscv/net/bpf_jit_comp.c                     |  32 +-
 arch/s390/net/bpf_jit_comp.c                      |  13 +-
 arch/sparc/net/bpf_jit_comp_64.c                  |   8 +-
 arch/x86/net/bpf_jit_comp32.c                     |  32 +-
 drivers/net/ethernet/netronome/nfp/bpf/jit.c      | 119 ++--
 drivers/net/ethernet/netronome/nfp/bpf/main.h     |   2 +
 drivers/net/ethernet/netronome/nfp/bpf/verifier.c |  12 +
 include/linux/bpf.h                               |   4 +
 include/linux/bpf_verifier.h                      |  23 +-
 include/linux/filter.h                            |   2 +
 kernel/bpf/core.c                                 |  18 +-
 kernel/bpf/helpers.c                              |   2 +-
 kernel/bpf/verifier.c                             | 216 +++++--
 net/core/filter.c                                 |  28 +-
 net/core/sysctl_net_core.c                        |   9 +
 tools/testing/selftests/bpf/test_verifier.c       | 220 +++++++-
 tools/testing/selftests/bpf/verifier/zext.c       | 651 ++++++++++++++++++++++
 20 files changed, 1286 insertions(+), 149 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/verifier/zext.c

-- 
2.7.4

