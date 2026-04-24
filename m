Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 719552D3A86
	for <bpf@vger.kernel.org>; Fri, 24 Apr 2026 08:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777018682; cv=none; b=GoUu8BIVQ28gkCRUNScl7Igzc/hqzzjLCxo48yXF3dn9dZClutKZ8t2jP2ecIEcdA7As6XPYjsIQ8ZZvBr1c5ZjCQUBZeSivTsBY+wq8locugq8efKg7wNoQF/0oda2hpNt8eViwL3+qwhfi7I8cFAZOfldKn3bxING9iDQTGk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777018682; c=relaxed/simple;
	bh=expAHzdlUUJYwgQiH7coRcv89OJQMG0Nz9Wq6BvCKNo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=IAVRxBNcrKPqJ6gVR6bGRptJwfdXX+CYUWqizIyxj2keq+omKthp25G9oZuGWF+hn0iKkyd5QxAN9HCpb8aK5gOiWU98czPe3HVatWjKf8q9vdaVwIOExXeVXL3L7Fv+pGYbR6jb0bM1zGn11d6/voybJl18ni83iRjwEboHJd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rdnYASIO; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rdnYASIO"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-82f8bf96b46so3747438b3a.2
        for <bpf@vger.kernel.org>; Fri, 24 Apr 2026 01:18:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777018680; x=1777623480; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2HDvI/BuQCfSZTuB4ilorJkFNxenQtdnx2DZ/63M+Fw=;
        b=rdnYASIOflmW24zt4vpgsH/7c24Z1+if91U31oovkEmUGEPfMiGdVuI2IrVuUYVWfx
         Od45xAtdV8GgYtlkpB8TUU6f86hzYp7/o37IVBte9KAt0ghw9RF95bn1XwtyIav61byD
         dk8ZF2qGJr6CmYxuQ5MeTjzDd18IOXZqhwVgSIkzVWS2A2S7PZZc3qG0r9U5Gw/iZoYA
         9qcLfnllVcIGmSf1VHn5dScRogrkQyT1NXKEul/+wy+2kuG+6s51xiV29A8Xm10sKrML
         IQn+3mk0zRvENYQwhPJpQ8TXAoMaT6Brt2UdTzA5ub8gMhwsA7bIiK/hY+lzc/TjWAZf
         n2iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777018680; x=1777623480;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2HDvI/BuQCfSZTuB4ilorJkFNxenQtdnx2DZ/63M+Fw=;
        b=CQ4gHrlAgb60XoCXMOhUS/JvNd0twhqvn1OJsCITnrs2d5VZ2KrmyG5LcKQ3ja0Da2
         0PpnZ8Kgdm1pe5jVBuN7z3WT1XGsSpntt92NCBdg9+YfTYY4P860Bou61O+mwVWD3NM1
         szZDu/xZEReaTkFMgI2KinPMMj3MwhoNd6VEg7WenamT3RB3uZ4k00NRM6w5bwepKlTE
         wZbtGQRZByy7GMLxfGfMn2oRKkAuiawB1+Iflu6r8wB/2hYAQNru/11x7xMI/BFejSHn
         mE7Ggz+esIayyawLP8PanZ71aVzWrnByR3oEnc3Z2tY9qvOfjiSY4csdR8i2Sx8MaSiw
         CbRA==
X-Gm-Message-State: AOJu0YwNYBVWbCi41FVLsRrqGsTJF+p0TWVBpd16fQ+jMR23toaOUzHR
	HzPkgOE8j2Y6Ah3tI/gnT0RDJtSCj1AmrW5tod9f91bEbdDGxHDJTaiuBi3pAA==
X-Gm-Gg: AeBDietbkkustu6gsWYM63REg/jARLCsy6yo0xh695YAtalrrbG64DNG9HTdUa3A6z6
	VaOJ10ilxRJQLXhYGVEqvVRPj0WM/NXOot2vpDR0/n2UOhMruprtMBJVsY4cbUQof0w9cSe7RId
	ia1Pv09UbLRHrmiEzv5mC0388lX+uRvTu1KLLeeB/vQiMlF2Zbk0bkwxtxsuldcUbjUYpElbmfP
	qFB/Wlo3IHq5MrvbMzwX+ftYOUF0ux4Yw4xRVb6FLJeyk1GRb0Cl7+ZTtxVMH9Yf7vxzYTt8f1R
	J863lj0R1XJlQJxILO5k1RuezXodNAf401Fed6hYaoRLjnq2XnLjc38oIf+p3PeaTionchI4wqv
	XbCnY6UTajXaOEucX9oKdXReoVNxmOACrebmGi27+Batvm3l9Ev+yIGU1B3cxKtoIHnL7VVXq0X
	m4xkJJUsp5j1KZ1OoeOv7oAs+MmDP7898MVzYgVL/vWzbZxZb9Sm4LEjKPLsY=
X-Received: by 2002:a05:6a00:2d1f:b0:82c:e19d:cabd with SMTP id d2e1a72fcca58-82f8c7ee387mr31948249b3a.10.1777018680411;
        Fri, 24 Apr 2026 01:18:00 -0700 (PDT)
Received: from honey-badger ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f8ec06cbfsm26604340b3a.58.2026.04.24.01.17.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2026 01:17:59 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	shung-hsi.yu@suse.com,
	paul.chaignon@gmail.com,
	harishankar.vishwanathan@gmail.com,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v2 0/4] bpf: replace min/max fields with struct cnum{32,64}
Date: Fri, 24 Apr 2026 01:17:39 -0700
Message-ID: <20260424-cnums-everywhere-rfc-v1-v2-0-57091924c9d7@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Change-ID: 20260421-cnums-everywhere-rfc-v1-79ef787fd571
Content-Transfer-Encoding: 8bit

This RFC replaces s64, u64, s32, u32 scalar range domains tracked by
verifier by a pair of circular numbers (cnums): one for 64-bit domain
and another for 32-bit domain. Each cnum represents a range as a
single arc on the circular number line, from which signed and unsigned
bounds are derived on demand. See also wrapped intervals
representation as in [1].

The use of such representation simplifies arithmetic and conditions
handling in verifier.c and allows to express 32 <-> 64 bit deductions
in a more mathematically rigorous way.

[1] https://jorgenavas.github.io/papers/ACM-TOPLAS-wrapped.pdf

Changelog
=========
RFCv1 -> v2:
- Dropped RFC tag.
- Dropped cnum{32,64}_mul(), too much complexity and no veristat
  or selftests gains.
- cnum32_from_cnum64() normalizes to CNUM32_EMPTY when input
  cnum64.size >= U32_MAX, previously only checked for > U32_MAX
  (bot+bpf-ci).
- cnum32_from_cnum64() and cnum64_cnum32_intersect() now check for
  empty inputs (sashiko).
- In regs_refine_cond_op() case BPF_JSLT use cnum{32,64}_from_srange
  constructors instead of unsigned variants (sashiko).
- cnum{32,64}_intersect_with{,_urange,_srange}() helpers added
  (Alexei)

[RFCv1] https://lore.kernel.org/bpf/0c47b0b7ea476647746806c46fded4353be885f7.camel@gmail.com/T/

Patch set layout
================

Patch #1 introduces the cnum (circular number) data type and basic
operations: intersection, addition, multiplication, negation, 32-to-64
and 64-to-32 projections.

CBMC based proofs for these operations are available at [2].
(The proofs lag behind the current patch set and need an update if
this RFC moves further. Although, I don't expect any significant
changes).

[2] https://github.com/eddyz87/cnum-verif

Patch #2 mechanically converts all direct accesses to bpf_reg_state's
min/max fields to use accessor functions, preparing for the field
replacement.

Patch #3 replaces the eight independent min/max fields in
bpf_reg_state with two cnum fields. The signed and unsigned bounds are
derived on demand from the cnum via the accessor functions.
This eliminates the separate signed<->unsigned cross-deduction logic,
simplifies reg_bounds_sync(), regs_refine_cond_op() and some
arithmetic operations.

Patch #4 adds selftest cases for improved 32->64 range refinements
enabled by cnum64_cnum32_intersect().

Precision trade-offs
====================

A cnum represents a contiguous arc on the circular number line.
Current master tracks four independent ranges (s64, u64, s32, u32)
whose intersection could implicitly represent value sets that are
two disjoint arcs on the circle - something a single cnum cannot.

Cnums lose precision when a cross-domain conditional comparison
(e.g., unsigned comparison on a register with a signed-derived range)
produces an intersection that would be two disjoint arcs.
The cnum must over-approximate by returning one of the input arcs.
E.g. a pair of ranges u64:[1,U64_MAX] s:[-1,1] represents a set of two
values: {-1,1}, this can only be approximated as a set of three values
by cnum: {-1,0,1}.

Cnums gain precision in arithmetic: when addition, subtraction or
multiplication causes register value to cross both signed and unsigned
min/max boundaries. Current master resets the register as unbound in
such cases, while cnums preserve the exact wrapping arc.

In practice precision loss turned out to matter only for a set of
specifically crafted selftests from reg_bounds.c (see patch #3 for
more details). On the other hand, precision gains are observable for a
set real-life programs.

Verification performance measurements
=====================================

Tested on 6683 programs across four corpora: Cilium (134 programs),
selftests (4635), sched_ext (376), and Meta internal BPF corpus
(1540). Program verification verdicts are identical across all four
program sets - no program changes between success and failure.

Instruction count comparison (cnum vs signed/unsigned pair):
- 83 programs improve, 44 regress, 6596 unchanged
- Total saved: ~290K insns, total added: 10K insns
- Largest improvements:
  -26% insns in a internal network firewall program;
  -47% insns in rusty/wd40 sched_ext schedulers.
- Largest regression: +24% insns in one Cilium program (5062 insns
  added).

Raw performance data is at the bottom of the email.

Raw verification performance metrics
====================================

Filtered out by -f insns_pct>5 -f !insns<10000

========= selftests: master vs cnums-everywhere-v2 =========

File  Program  Insns (A)  Insns (B)  Insns (DIFF)
----  -------  ---------  ---------  ------------

Total progs: 4665
total_insns diff min:  -15.71%
total_insns diff max:   45.45%
 -20 .. -10  %: 3
  -5 .. 0    %: 6
   0 .. 5    %: 4654
  45 .. 50   %: 2

========= scx: master vs cnums-everywhere-v2 =========

File             Program         Insns (A)  Insns (B)  Insns     (DIFF)
---------------  --------------  ---------  ---------  ----------------
scx_rusty.bpf.o  rusty_enqueue       39842      22053  -17789 (-44.65%)
scx_rusty.bpf.o  rusty_stopping      37738      19949  -17789 (-47.14%)
scx_wd40.bpf.o   wd40_stopping       37729      19880  -17849 (-47.31%)

Total progs: 376
total_insns diff min:  -47.31%
total_insns diff max:   19.61%
 -50 .. -40  %: 3
  -5 .. 0    %: 5
   0 .. 5    %: 366
   5 .. 15   %: 1
  15 .. 20   %: 1

========= meta: master vs cnums-everywhere-v2 =========

File                               Program     Insns (A)  Insns (B)  Insns     (DIFF)
---------------------------------  ----------  ---------  ---------  ----------------
<meta-internal-firewall-program>   ...egress   222327     164648     -57679 (-25.94%)
<meta-internal-firewall-program>   ..._tc_eg   222839     164772     -58067 (-26.06%)
<meta-internal-firewall-program>   ...egress   222327     164648     -57679 (-25.94%)
<meta-internal-firewall-program>   ..._tc_eg   222839     164772     -58067 (-26.06%)

Total progs: 1540
total_insns diff min:  -26.06%
total_insns diff max:    6.69%
 -30 .. -20  %: 4
 -15 .. -5   %: 6
  -5 .. 0    %: 36
   0 .. 5    %: 1493
   5 .. 10   %: 1

========= cilium: master vs cnums-everywhere-v2 =========

File        Program                          Insns (A)  Insns (B)  Insns    (DIFF)
----------  -------------------------------  ---------  ---------  ---------------
bpf_host.o  tail_handle_ipv4_cont_from_host      20962      26024  +5062 (+24.15%)
bpf_host.o  tail_handle_ipv6_cont_from_host      17036      18672   +1636 (+9.60%)

Total progs: 134
total_insns diff min:   -3.32%
total_insns diff max:   24.15%
  -5 .. 0    %: 12
   0 .. 5    %: 120
   5 .. 15   %: 1
  20 .. 25   %: 1

---
Eduard Zingerman (4):
      bpf: representation and basic operations on circular numbers
      bpf: use accessor functions for bpf_reg_state min/max fields
      bpf: replace min/max fields with struct cnum{32,64}
      selftests/bpf: new cases handled by 32->64 range refinements

 drivers/net/ethernet/netronome/nfp/bpf/verifier.c  |    8 +-
 include/linux/bpf_verifier.h                       |   71 +-
 include/linux/cnum.h                               |   80 ++
 kernel/bpf/Makefile                                |    2 +-
 kernel/bpf/cnum.c                                  |  120 ++
 kernel/bpf/cnum_defs.h                             |  233 ++++
 kernel/bpf/log.c                                   |   24 +-
 kernel/bpf/states.c                                |   16 +-
 kernel/bpf/verifier.c                              | 1405 ++++++--------------
 .../testing/selftests/bpf/prog_tests/reg_bounds.c  |   90 +-
 .../testing/selftests/bpf/progs/verifier_bounds.c  |   89 +-
 .../testing/selftests/bpf/progs/verifier_subreg.c  |    6 +-
 12 files changed, 1059 insertions(+), 1085 deletions(-)
---
base-commit: fd30cf86e1194ab067661a0ab3e0769a5600848b
change-id: 20260421-cnums-everywhere-rfc-v1-79ef787fd571
