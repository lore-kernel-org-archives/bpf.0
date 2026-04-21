Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7657F37E2F6
	for <bpf@vger.kernel.org>; Tue, 21 Apr 2026 10:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776767345; cv=none; b=guJb1XjyiPQCMCFKy786wSxXGL2+LER4EJDDolOU99WkwSsLl8ZlQv3NiOffmBomWsLGL1kcZ7/K3jzJPaaORw+ljLzVrvNRShi+TFUFJ5YO5kU4L7V4r67H3xuN4idbIgD/C5q58wAiqnAebXJ10zUmJftPkqMbTVDtsuwiPA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776767345; c=relaxed/simple;
	bh=qXx/V6fdA/I8PLM0xCpdaazycU25fr9/g9s1DB8G04g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=t7jXI5/GirB21JVtwfEIKUOU5agSNEI5CWrBDc9X61bXW2ncE7uHEa1appWHQLbxpbHOfNuB0JthZfebo6E43E1yjeZsnnWQchfVnpLsdgK1IacPzL+jk54KwMl2DbE6TA0ovPAkg4bt9ZUwRuUpZS6ZtXMwc2RUlsIXDH1dJBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CEVfzsah; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CEVfzsah"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-8296dabef74so3603534b3a.1
        for <bpf@vger.kernel.org>; Tue, 21 Apr 2026 03:29:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776767343; x=1777372143; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lvnf99Qndqpfcgl/cE028JHij2RygPxj8tfoL14lzbY=;
        b=CEVfzsahH5s2qHQ1zNFdlIJQHCxVcG853v1XojPxGja/DnW2dpfvhAQqfBFUXP2Gdn
         9akns7WUeZndVFXr5mpACxdedl/Y0bKTdYCP/UMeN515sCDO2DD8nunwt8JYYMUlCeJJ
         5xhUwJH/Ck73y6M12bbYopv9TLeltyJRGRzcgRc70we9tfJiyg9OjP4aDMQsF7xF0O2/
         6yzPgUVjfx/M1ZCBew6KT4i7do0kNZb3y8h+tph1H4WUTZ2N4vxY3UUn8s5H9Mg8teVg
         FX0brBhoMjdPW73t0LtgOIuPhJfpcmFJK+ZIsZdYeCFC7mpwbUVpMHV12V4sAkarWS7X
         izaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776767343; x=1777372143;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lvnf99Qndqpfcgl/cE028JHij2RygPxj8tfoL14lzbY=;
        b=b2GJbh/tgtkJGo0ebr3t57emQVEm40txpx44e8KjN9ikkdatAvtBT6yXAAfdmV/Djy
         hUmMYQFaVTaKir5PQDoxH6Ky9UAxte2xL+8BGbmJaliVPJ0u9Rh2z27cOW//nPVuBWWX
         OMps3BUhQG86M3lMObmunSHhy66ToHOx7BNNiq5aA3L1dOIuCmZtjzYqMWEXARBkMU+m
         nJPrenust9ZdBdACYRhsbd4mzrd2Pru/RUx51XIG+fJFmkk6ZUrkgZRYWKnUaOQJxLiO
         ICGXea9phgtddsGJPq5kfQruOhT4uiAQNn6DdwEqXvxdcLL88acQRu16qdUjqyOvflzl
         OqoA==
X-Gm-Message-State: AOJu0YzHFhM0DLHWGFWmJii6X2nArSN+pu3O1x3MBiWd/ILqnNjjWdbv
	/C0B14BIQV9vGRRQtLS4B+S5Ri5MgK8hWdAG+dYE1wFW0e3D4HuhlPACGnSU975m
X-Gm-Gg: AeBDievjwQlUr/FRhXmSUh11HO9mtSRDwTYaXOcfGMJnrxzXANnBu9aq4vI5fp+oxaV
	XvWbXGbgMPrbX9lQi5IPHThoQHv67Mmp81ULwXMjyO6NVwEGLVumriEG0Wj4JODWQCREivFYuRI
	Tu/xo6nwHMh0k7Lbl3eosJA7Bttsc2za0hduHbw3yoq0M5FeuWlaQeRKHpqX52uz18OJ2uShXR6
	Bux5t3jkMEgEBFFnRL0NM0GQYKnM4hCRozNFhmHWfg+wyo+oVp5w5z+Wq6CyurBuVuFIINXdt2r
	ObTO9Mgr1meo5MdfdglxrUtJ+CoUdG9B5JB3zHarcUgDnAcB3tNoiE6vUIvv2kSIUZGkLqHdKxW
	BoQxEIt/1qfwjP+1j8x5OjBiK2QLvN9s35EVKEaGnoN0p8joA+ijgy+UZwKT4V1RdCmmiS9ujIH
	c8jPWnsw+BdIv4ptN1pGwtk493QpAh5LfAYLQN77ECO8/KweTXVGtKo03T25nj4KMLW24hY5LIW
	YonPA==
X-Received: by 2002:a05:6a00:4502:b0:82c:70a8:faee with SMTP id d2e1a72fcca58-82f8c830903mr17430922b3a.6.1776767343385;
        Tue, 21 Apr 2026 03:29:03 -0700 (PDT)
Received: from ezingerman-fedora-PF4V722J ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f8e981c07sm16135000b3a.1.2026.04.21.03.29.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 03:29:03 -0700 (PDT)
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
Subject: [PATCH RFC bpf-next 0/4] bpf: replace min/max fields with struct cnum{32,64}
Date: Tue, 21 Apr 2026 03:28:48 -0700
Message-ID: <20260421-cnums-everywhere-rfc-v1-v1-0-8f8e98537f48@gmail.com>
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
- 104 programs improve, 44 regress, 6564 unchanged
- Total saved: ~290K insns, total added: 10K insns
- Largest improvements:
  -26% insns in a internal network firewall program;
  -47% insns in rusty/wd40 sched_ext schedulers.
- Largest regression: +24% insns in one Cilium program (5062 insns
  added).

Raw performance data is at the bottom of the email.

Debug metrics
=============

To understand the practical impact of the precision trade-offs,
two debug counters were added (here [3]):

- isec_overapprox: counts how many times cnum_intersect() in
  conditional branch refinement had to collapse two disjoint arcs into
  one, losing precision that the signed/unsigned pair could represent.

- crossing_poles: counts how many times an ALU operation produces a
  cnum that crosses both the unsigned (0/U_MAX) and signed
  (S_MAX/S_MIN) boundaries simultaneously. Such cnums cannot be
  represented as a pair of signed and unsigned ranges.

Across 6683 programs:
- crossing_poles fires 551K times for 21% of programs.
- isec_overapprox fires 119K times for 12% of programs,
  most programs have only 1-5 hits. The bulk comes from a few large
  sched_ext and profiling programs.
- 801 programs have crossing_poles > 0 with isec_overapprox = 0.
- 202 programs have isec_overapprox > 0 with crossing_poles = 0.

[3] https://github.com/eddyz87/bpf/tree/cnums-everywhere-squashed

Raw verification performance metrics
====================================

========= selftests: master vs experiment =========

File                       Program                              Insns (A)  Insns (B)  Insns  (DIFF)
-------------------------  -----------------------------------  ---------  ---------  -------------
verifier_bounds.bpf.o      deduce64_from_32_before_block_start         11         16   +5 (+45.45%)
verifier_bounds.bpf.o      deduce64_from_32_wrapping_32bit             11         16   +5 (+45.45%)
verifier_live_stack.bpf.o  st_imm_join_with_multi_off                  23         16   -7 (-30.43%)

Total progs: 4633
total_insns diff min:  -30.43%
total_insns diff max:   45.45%
 -35 .. -25  %: 1
 -20 .. -10  %: 3
  -5 .. 0    %: 6
   0 .. 5    %: 4621
  45 .. 50   %: 2

========= scx: master vs experiment =========

File             Program           Insns (A)  Insns (B)  Insns     (DIFF)
---------------  ----------------  ---------  ---------  ----------------
scx_rusty.bpf.o  rusty_enqueue         39842      22053  -17789 (-44.65%)
scx_rusty.bpf.o  rusty_stopping        37738      19949  -17789 (-47.14%)
scx_wd40.bpf.o   wd40_stopping         37729      19880  -17849 (-47.31%)

Total progs: 376
total_insns diff min:  -47.31%
total_insns diff max:   19.61%
 -50 .. -40  %: 3
 -10 .. 0    %: 12
   0 .. 5    %: 359
   5 .. 15   %: 1
  15 .. 20   %: 1

========= meta: master vs experiment =========

File                               Program     Insns (A)  Insns (B)  Insns     (DIFF)
---------------------------------  ----------  ---------  ---------  ----------------
<meta-internal-firewall-program>   ...egress   222327     164648     -57679 (-25.94%)
<meta-internal-firewall-program>   ..._tc_eg   222839     164772     -58067 (-26.06%)
<meta-internal-firewall-program>   ...egress   222327     164648     -57679 (-25.94%)
<meta-internal-firewall-program>   ..._tc_eg   222839     164772     -58067 (-26.06%)

Total progs: 1540
total_insns diff min:  -32.75%
total_insns diff max:    6.69%
 -35 .. -25  %: 5
 -15 .. -5   %: 7
  -5 .. 0    %: 55
   0 .. 5    %: 1472
   5 .. 10   %: 1

========= cilium: master vs experiment =========

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
 include/linux/cnum.h                               |   76 ++
 kernel/bpf/Makefile                                |    2 +-
 kernel/bpf/cnum.c                                  |  114 ++
 kernel/bpf/cnum_defs.h                             |  432 ++++++
 kernel/bpf/log.c                                   |   24 +-
 kernel/bpf/states.c                                |   16 +-
 kernel/bpf/verifier.c                              | 1403 +++++---------------
 .../testing/selftests/bpf/prog_tests/reg_bounds.c  |   90 +-
 .../testing/selftests/bpf/progs/verifier_bounds.c  |   89 +-
 .../testing/selftests/bpf/progs/verifier_subreg.c  |    6 +-
 12 files changed, 1232 insertions(+), 1099 deletions(-)
---
base-commit: 0aa6378695b8c67146130812f635f07c4898f171
change-id: 20260421-cnums-everywhere-rfc-v1-79ef787fd571
