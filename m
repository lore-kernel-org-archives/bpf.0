Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A13A2673B0
	for <bpf@vger.kernel.org>; Fri, 24 Apr 2026 22:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777071178; cv=none; b=qX+r1WaLVnI9PeQwDt/W/uniXF4TAkEhOg7s+viZe6EwY4c+O2q+2WzZerh0KUPC8Lc8dlKDgJQvcAU4/lFtGEv9Nb+sQukxLViQnzHH9Zwt7nAK88uTmVBDz5IYadI6KzkoqSrskK7obuO1l0zWHKKfaE6Fkbu2t7apERMjvb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777071178; c=relaxed/simple;
	bh=JIXHnpufnDRGgTHQqw9crICvYLHbjf6LdQ0lC/ChYPE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=k7p4Z1MTmwa+1YhGyIucxg3adIjCjT8803qFMGgj/YEk4glersZXk9wPq8sgmpepo0uox1cEWx17jx/pzE4kpftvXg0CuaK+0gHyp4W+bKYfVWbSvktkz4WhO9vqWrvRqEwb7qQCIOoXJvhHZ5wqN0GfaRfvdjLF2IdY9fK7ZNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kkLtIKNf; arc=none smtp.client-ip=74.125.82.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kkLtIKNf"
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-12c19d23b19so10972884c88.0
        for <bpf@vger.kernel.org>; Fri, 24 Apr 2026 15:52:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777071176; x=1777675976; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eZWMxLyyMlB5BMHmdJIzbecsE0ejq1c354uJCXvxQ/w=;
        b=kkLtIKNfWfMOFMaMPYU6X1arRr5ctSksNpPovsD1sANb9rZGps2CP0vtIBhgmMXaCd
         7YCo11gzCm92ndseKKfQzHvfHpXXkD8sSRgXwD90mdwPS4cFcJDQaLfp3MUhHpbvkBD5
         xUYET4GSs5Ta7kFlOGKn/kNYrZdR7/tLacJmRX2W304K48dJQ45PdCvnP3ip8VH8/15p
         HtxAUeJjmdZUbrGr2O04lGxY+AszCu8MXYVaDAnlr7Cy+MdWZdgQbtNTO7Ir/4WcO3Cs
         PJFA2/KUVWGbHRATootN418CPXh/iJIwcGa3BsvQl4b6eJbyxWui5KmcDA9ALVzbSBSl
         nZ8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777071176; x=1777675976;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eZWMxLyyMlB5BMHmdJIzbecsE0ejq1c354uJCXvxQ/w=;
        b=GS1qRTW1SkcEmqj+D2CsriRQl+dZZ6pB0QejT9KknLKblD/aPJReGCUwLRpNdbd6oo
         RohujMFEL7WoXP2mGtPN5PnpkyvXNEKg6X4efy8/9Um13/8ruN3E+RdlRWjZiqTvuWgz
         /pI23UGshhjnHXaDNT5y7Uxph4YQxTDBnOdzvF2pRcHyqJeYFrvNqUvBx+sAn7uCcgAO
         bApuSCt+ADJapnYurSKQzCSu1cp3yxEz3sIdh5inIU9G9p+UJPx0DJjLSpr7mKIN2EVL
         YFo9jBCyPJq4kMSAk1cOkWP2iyvba1Mw9QCNSf5hueBqzuJN273ojp8+TQA8h6OFArrt
         nMgQ==
X-Gm-Message-State: AOJu0Yxr6DcRmsAzgBJE7BQQAy9kyMwS1i/NhreIBLyyX77OtZf0K/B7
	teizqhZxjt1liU8qHC1oracy3j1T41e656X9zIkzW94Y3xMC64U1/ePeUy/Vai/L
X-Gm-Gg: AeBDietClC0S3NGuKLziWlAP+hbnUKJdnRC7RVVL+V9bUxTBrsgz7J8GCeZBGIxnf4u
	yVFhFoGAyF7iRSFfMYEGSHvzrxoQea/A7Q6B7lScDy8eo5kAtaTd/f661NkbTYiigxBxkokWehF
	lVJ2/DJk6G0hju8qTS569j6/eN0riB3GHt0tkq3gB6Wc65V51rFyUvs60MZNeOn8mY46ZAuLXUb
	6SGM3/UdRDwtF3qZVpMTD+G/SRyX8JJYBrIAZOhOCBZR3D8xLeOqsIwmjjKScVKG0gRqYrmiZfK
	Py5450COOLoDRo/FvX0xNctzS/13A9xhk6dt/oIYBtKgg40LcEWVikekYXBm4ZJFovKLIjSXewT
	JkONDc7yhqMTgwrfIg9uk3BHNrJI/FvqATx3Gaqxir6yG1GvKM7wKl3RVvHcGGHf7ypOSx9RBXM
	SPVTc2JTdWozwbfpdl1bWRxD0yVkN5XP8GC/kZa/zDGJUk5Ccg0KTDdNHye510li+eLIocDEy36
	Q58EysjjOOsYlJ0cZQ=
X-Received: by 2002:a05:7301:1693:b0:2d4:7656:4ec1 with SMTP id 5a478bee46e88-2e47873a687mr19135501eec.17.1777071176351;
        Fri, 24 Apr 2026 15:52:56 -0700 (PDT)
Received: from ezingerman-fedora-PF4V722J.thefacebook.com ([2620:10d:c090:500::1:b6b2])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2e53d2cff04sm33019868eec.23.2026.04.24.15.52.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2026 15:52:55 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org
Cc: daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	eddyz87@gmail.com,
	shung-hsi.yu@suse.com,
	paul.chaignon@gmail.com,
	harishankar.vishwanathan@gmail.com
Subject: [PATCH bpf-next v3 0/4] bpf: replace min/max fields with struct cnum{32,64}
Date: Fri, 24 Apr 2026 15:52:41 -0700
Message-ID: <20260424-cnums-everywhere-rfc-v1-v3-0-ca434b39a486@gmail.com>
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
v2 -> v1:
- Fixes in source code comments highlighted by bot+bpf-ci.
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
[v2] https://lore.kernel.org/bpf/c4fb60bafd526ae2d92b86e2250255aef0ba5ee1.camel@gmail.com/T/

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
 kernel/bpf/cnum_defs.h                             |  230 ++++
 kernel/bpf/log.c                                   |   24 +-
 kernel/bpf/states.c                                |   16 +-
 kernel/bpf/verifier.c                              | 1406 ++++++--------------
 .../testing/selftests/bpf/prog_tests/reg_bounds.c  |   90 +-
 .../testing/selftests/bpf/progs/verifier_bounds.c  |   89 +-
 .../testing/selftests/bpf/progs/verifier_subreg.c  |    6 +-
 12 files changed, 1056 insertions(+), 1086 deletions(-)
---
base-commit: fd30cf86e1194ab067661a0ab3e0769a5600848b
change-id: 20260421-cnums-everywhere-rfc-v1-79ef787fd571
