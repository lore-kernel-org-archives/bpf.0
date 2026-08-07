Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2438718CC13
	for <bpf@vger.kernel.org>; Fri,  7 Aug 2026 20:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786136398; cv=none; b=MhDuiFkwx19iIvayk9XxTKFvTOilT8RqiDtwmLT9u7tdcFiPLDWAYm4NRL9OJX6wL2Qscz6gMEqmPGJtB3wckBO/nVpIVBFIPBzc4I+s/qRZoEkst5Guy5Gz33G624WtB2Zl8O08aTV/giJZUsxDX3DgXJjFdHsXLLjg1lQqESQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786136398; c=relaxed/simple;
	bh=8YaaxDcF5e4glp3YpfARZjG61K4Cj58f2FFG2Nok33I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tAvr2a08H6aNPoFEWTg1D9cUF77PdBWJOFstborIbh6R1ckMeWJ2EB2rte3WjRMATwEL4lcSYRA5jJ+ZDLdVZYI98htXwb7Q5PZjspXXWlyTo7UoH2LzX8px4PdCmKqzNv94loJxwXSGPqhLScn8DyTlchwn5PuQWKslJ8/zZGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qvGHl8ai; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qvGHl8ai"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-39266382df6so1071015a91.3
        for <bpf@vger.kernel.org>; Fri, 07 Aug 2026 13:59:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786136396; x=1786741196; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/mwVbxk9N8xkaeLVL0QdcBxmw/GCnCpkP0bKeEVOebM=;
        b=qvGHl8aiwO35ua4zX4LoxA2sm4StZIZhU+3lXQUTT52JeWd6iTANdGkqLKuS6MgGoH
         pCGmczwShbzGkrt20gtk5aYrkbVbbdN3OP0oFONUQ/bzVSfsqjAEr4OuS3PqO3C+kIOh
         dSU18+azfo4XjdexiPvq2JXEJrAVtmvRSjajeIDw0BiE+f8r67Rf9G54z3TUKlE5zcj1
         oZFj2IhaF98zJInj6ZyQhofD4x7sN0tePfsz2e2m1H1Jjqo/Fc5QoKXU7xM/ey52rPz3
         +WvtjAS61wPZNFZTQ5uIkM6wCZd5vBrG/MWalv/1vedL1Ouk70+LAi/sOoywyZGxoK+p
         k9vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786136396; x=1786741196;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/mwVbxk9N8xkaeLVL0QdcBxmw/GCnCpkP0bKeEVOebM=;
        b=WfdBTPbXNgQxb2/OUgXKDuhKyCJU2t7s4VeyFEoXMh6gXCpTooyXlQKR9LO9Z7Zj96
         pZaphwKTuPeBlVNJLkXMskN4r4p77YTdGLP6Hrm9DM9rH1TTxtEsl1ZHzxFIaO4spN3L
         QEBt4A3bVscF4UX2WW3LNu1vAPCPaKxLRxvuoTr32RnzbqKaadUWIcVbgDJN9TwRcJqn
         VF4vwPm1ARRIRD4mQRKvbFipigpluKBihYX/lKgsKbhPcg5U9AD9MkojGJqkJlqUW/cn
         2g4FHNhfaB03U8jXlRyxpLljNHjii5Tqonuerp5IQBh4RVhxf0skGQ/gbtK7QpuU6bEm
         BKvg==
X-Gm-Message-State: AOJu0YzEum6sKyPl0qzzPH6XOZIQdbYCYqXAppvancX/c3HXF+ByEc2W
	MaAc/CFF958g9MAIJWCra7rgH/uIcOdVWGZ8uBz5SWwPnGm0pMG2Tw7JjhDLCIeV
X-Gm-Gg: AR+sD12xo157AQX18mDOIjS1talyi4Y+Y5i7wRM7pM/IxQoixmQsSW0BetDQqDPS+Fe
	J/fSqYrlmGzFlh4Ht7FI9TMLe8OS6l4mkHYhG1bq7HCQuLkJiHJnI9tajld7BnFl56x4Ol+9KrN
	VupXjtsL58Xl/lM4cjIkJ30cIzdtc+Cq5Iy+N0VOuSDBiWt8l3HCytGWd3VIMDKt4mW8bsXUweW
	f1PzuIua1NvfjUpW9XBb286aFwiTk4BzEnxRcVhR4DP5r/axxPHEQPoheVCOC6uwxY9siTzUWFI
	MZ3NEZLR7FjSwMKf086YK+bA02XI3W26OTllrTkeb06lX4SFcPMoJx52GIluzZy0xze7t//Zh/n
	VP7Ih9jU4y2u6liITQQxAwIGYyexp6LdaZQKbedR/i+Ige24yvHm13cSkFwHk9AKDK2GpIJ8EJU
	JWeYk1cd4hJBCLFb0Di3ZmS1Bj5wOAhNbcc0Dm5TT+oVM6eTHvm1NYE83f2b0en0h3/9fmExkBr
	pWwSNSy/UjxijQjhrmK0okhLaHwDGAgvYkOmTvG9tI5
X-Received: by 2002:a17:90b:3806:b0:38e:7080:b4c0 with SMTP id 98e67ed59e1d1-3903c5cfbccmr24074876a91.10.1786136396218;
        Fri, 07 Aug 2026 13:59:56 -0700 (PDT)
Received: from ezingerman-fedora-PF4V722J.thefacebook.com ([2620:10d:c090:500::5:1cba])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-141019b4244sm9799783c88.4.2026.08.07.13.59.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 13:59:55 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org
Cc: daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	eddyz87@gmail.com,
	memxor@gmail.com,
	iii@linux.ibm.com,
	gimm78064@gmail.com,
	info@starlabs.sg
Subject: [PATCH bpf-next v4 0/7] bpf: infer zext_dst based on static register liveness analysis
Date: Fri,  7 Aug 2026 13:59:29 -0700
Message-ID: <20260807-static-zext-v4-0-b6c270013c77@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Change-ID: 20260731-static-zext-938cd128273c
Content-Transfer-Encoding: 8bit

Min-gyu Kim reported a bug in 32-bit operations zero extension
handling [1]. The same issue was independently identified by
STAR Labs SG. The bug was introduced by the commit [2].
The tl;dr of the bug is that the verifier does not carry zero
extension marks across pruning points. The detailed mechanism is
described in patch #3.

Fix this by reworking zero extension logic to avoid main-path based
subreg_def tracking, and instead extend the live registers analysis to
track upper register halves' liveness.

As noted in the commit message for patch #3:

  There is one notable drop in precision: whenever a BPF subprogram is
  called, all 64 bits of parameter registers are presumed to be used.
  The assumption is that such a drop in precision would not inflict
  noticeable performance penalty.

Ilya, could you please help with testing this conjecture?
Min-gyu, could you please test the proposed fix against your
reproducer?

Side note:
Patch #1 is a small refactoring for disasm.c, as patch #3 adds a new
location where bpf_verbose_insn() is called and there as well I have
to wrangle with the newline added by the disasm code.

[1] https://lore.kernel.org/bpf/CAGKGUv=sOuqQtA1Ub-5JXfA4FPosJFYKAQE4B79cK+P1erxqtg@mail.gmail.com/
[2] commit 107e16979905 ("bpf: disable and remove registers chain based liveness")

Changelog:
v1 -> v2:
- fixed BPF_JMP32 handling, these no longer for zero extension (sashiko)
- removed dead code in print_insn_for_graph() (bot+bpf-ci)
- reworked bpf_is_reg64() to drop dead code (sashiko, bot+bpf-ci)

v2 -> v3:
- fix for proper s390x calling convention all call parameters are now
  zero extended if necessary (sashiko)
- fix for PTR_TO_ARENA alu operations to set zext_dst when needs_zext
  is set, in order for such operations to be zero extended (sashiko)
- updated bpf_is_reg64() to handle BPR_PROBE_MEM{,32} loads in order
  to avoid a false positive from sashiko.

v3 -> v4:
- fix to properly handle address space cast instructions for
  arena maps with BPF_F_NO_USER_CONV (sashiko):
  - extracted is_addr_space_cast32() utility function,
    for use in bpf_do_misc_fixups() and bpf_is_reg64();
  - made bpf_is_reg64() aware of such address space casts.
- added a note about report from STAR Labs SG.

v1: https://lore.kernel.org/bpf/20260731-static-zext-v1-0-98a4dc73e94b@gmail.com/T/
v2: https://lore.kernel.org/bpf/20260731-static-zext-v2-0-da4aa161e8c5@gmail.com/T/
v3: https://lore.kernel.org/bpf/20260802-static-zext-v3-0-3456b2604574@gmail.com/T/

---
Eduard Zingerman (7):
      bpf: do not print a newline after disassembly in bpf_verbose_insn()
      bpf: extract is_addr_space_cast32() utility function
      bpf: move bpf_is_reg64() to fixups.c
      bpf: track upper 32-bit register halves' liveness in compute_live_registers()
      bpf: infer zext_dst based on static register liveness analysis
      bpf: simplify the bpf_is_reg64()
      selftests/bpf: verify zext_dst annotations for various instructions

 include/linux/bpf_verifier.h                      |   7 +-
 kernel/bpf/backtrack.c                            |   1 +
 kernel/bpf/disasm.c                               |  68 ++--
 kernel/bpf/fixups.c                               | 100 ++++--
 kernel/bpf/liveness.c                             | 109 ++++--
 kernel/bpf/verifier.c                             | 204 +----------
 tools/bpf/bpftool/xlated_dumper.c                 |  19 +-
 tools/testing/selftests/bpf/disasm_helpers.c      |   3 +-
 tools/testing/selftests/bpf/prog_tests/verifier.c |   2 +
 tools/testing/selftests/bpf/progs/verifier_zext.c | 392 ++++++++++++++++++++++
 10 files changed, 596 insertions(+), 309 deletions(-)
---
base-commit: 41c129fdc28b6414d259da72679567c5e72a55dd
change-id: 20260731-static-zext-938cd128273c
