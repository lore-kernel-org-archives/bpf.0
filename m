Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793483746;
	b=WeTWxoTAk+DD1M9ShUY6VcyfmmFXKOXkws8gjG+DKF6tSOw9SGac2xQBegtx0kHY0uXn
	 A7Sp6M1MQsFqA8s1cSQ8FUGddUDo51abgg1q3ER4wIuwHN5U7MfvDIkYVfHqRqudrKPsa
	 a27ewwwgEYXc7a6u1dNBt/oTH4MZlJ0jB4+W31vIUImvJhac8L8Ti23VZ64a1J336pp+7
	 i3UOkQGv3tDBIz4+UMQW65fRU0t5zkuTb6+mnVnnjMBdXAP9SEV5zhtybSsqxycIsfmhn
	 jHyTq78YyeP1A24gBqL9mqYsYw17N5ogeH86waIC/XytLN5pugs/p8pLbaCA5nk6VWQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793483746;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=Jg7i7q1DgYvhGzWlk/ZdxM3YNf1jaZBszSChCeRrm3M=;
	b=iIbS4A7Lr6iIfWpO2a6C18CLOErwPnsvFHaAau07zJGRmabEhFXJYAdorWFvyxMc26Mq
	 1HhbfSIkBeWeR9epif0gVkVxtJJ16ASjbsKw0qDU6XlvQjXS6aUc/P7ubvJfg1CrhoQaH
	 qleWUuqbK86Y/cf7OFzeqZHx8GVl1I0yIg4ieuXy5vmoIh7kzddT/F6P6DyzVVcvERkZT
	 c8Cu4ncy6Y0ye7huInQ46EoDaxHEF32vch51+TRBpD8WQffChLpl/PC9YN7t9Yp9Maepo
	 o3qK/6bhNf3QTchYakiueDpo0XA90nvns0srZvsHmzg2/zvhmIng0KQdZMkJQsaaWcw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Z3BKwfSr;
	arc=none smtp.remote-ip=209.85.216.53
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1021B606A31A
	for <bpf@vger.kernel.org>; Sat, 31 Oct 2026 21:55:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1021B606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Z3BKwfSr
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-3adac5c10e3so1142060a91.0
        for <bpf@vger.kernel.org>; Sat, 31 Oct 2026 14:55:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793483745; x=1794088545; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Jg7i7q1DgYvhGzWlk/ZdxM3YNf1jaZBszSChCeRrm3M=;
        b=Z3BKwfSre+zZZtuJWjR92n8bazWEqWYMeo5jVERkxSj+qrfI6OYrwQT99XgzTJsnFg
         5jcHeGiKrbDh7eL2nj5S/V+1F2xgNCaTELrkVwGW5xzJaId7/PH/pIcIe17gQ9h9Kmrd
         pnKFg0NowUkFtQBZ93Qtn6fcyiXWbX9WBpZZD8xioP7wBo0LwsV/cXQUGjPFjX5NEhN5
         edbTcFbPvCjy+iopw3ezd+BvzVz2E4pbtGPfYJEdbis+rzKVbgpmlwLczYY6JS0U95U2
         29mHGdG5tpTk7uGXuah3eSFHOzr8AfJ30MVVRCMBkkHitNaCq6LZA9RQ2DUJSo0AgWC5
         y9OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793483745; x=1794088545;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Jg7i7q1DgYvhGzWlk/ZdxM3YNf1jaZBszSChCeRrm3M=;
        b=JYt6DH7pVvi371VMX1P0Zqc/+iWafOmWIWvbBOAcmS4YvlXCVVwsOBqVKe/yNqLHz3
         HjmkhrD53NE+dpnvjEOWgIe9ykIGB7wJ5JyFnL47pqjLIqPR7T6GmANzkPZ7/gUEFgDw
         +kylTthDxJRfyUiFINJ2CFjlWIa603tEU4bu7ymNqYl/0uSfJ6UsgrIh3QT3365i54+e
         LRbC8Mgusdh8dtlAKkQoZNtdqNtEfOyc8QmYv6rkludQlBakeVrjXRo2Bl6aBXmZQwXh
         4IiRmUNSawlZ+2AFW11+iwYvdbO0ZRbQ84oXoMDykuxmhOYkYhl7o8bEiXRAfkNvIdtx
         nCiQ==
X-Gm-Message-State: AFq9FYJqpZc1IQa6nr9MLcMpQ+OoesDKQ08oe/N/IsXoMSLGE7bU60zs
	Hqm3a4jMGOPXNEFCZc/w9s6UudmM4pjWa+R1q/7rwOKHs2XlTEwXqXKetYlW3Q==
X-Gm-Gg: AYBFou0Sy7pVvhqdSvt3rOIYXeUF62MRsaRBvv0M36XougbTgIaX6pYzVYv+suoiZis
	58XcSoi9dGOuC6R6+BvZAu7zlR08VxOBLf3TUtWOFuibi9T2eMMu/lTBUtS8PcxLUAbjMS06jZP
	lDNmAkoW/8Rmtc/C8suCpj4iAEJRSTdgkm4t+aZPNXObt238miDdGMY0+m7e6F+wP34zWw0BFVU
	DseV4wT4M7iaoP0tAyuh4kBhws+1rE9Z0LenI5u8+tNtYsRAWC/hQ/+RCQgslKYIWjCQXmZOrlA
	Z1KfH+tjjc3nAAFg3m3KY1TTH2YZe1vR/utaNQAPD8J8/p2Fsx7dXHUzIxc63RBIZFOEJU6U+fk
	XuwFDlSlc/AzdkEfNDeAKNoS66JVKPDE6JfAcde2rjHXeBol5cw9GvyuBnkbUfsuwwPNvAX6r65
	21G+dXqxXolopw6pAkJ9NJh3ZB9/abL+AlEWtprmqHPpnFV0z5TbaO/szDB447SqjcpGhfwCvYX
	lrfXxeU6HZyt1cZQ2mjfIiNPHyaN33rpRRL0eRi+tl8oRFHC3K8XDBmDcPd22UB4wsYxhTSO1EO
	Z+MznLCDIcsFeTotBOSIFFP1egZ2gUYw086+fes0rtW3Ah6Tdp+R3r/ft3mpu0dcK2VJNvFy8TG
	G1er3Bw+rk0Cbenl+uuFmVjuodpbqE6Uaw8Rww1ndvNa9GymqlqXmaC4AJIfyrHJCJw7S/2F71w
	==
X-Received: by 2002:a17:90b:534c:b0:3a0:abc3:afb5 with SMTP id 98e67ed59e1d1-3ae897f5d26mr4766844a91.34.1793483745268;
        Sat, 31 Oct 2026 14:55:45 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.246])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae6e98afe3sm12854336a91.12.2026.10.31.14.55.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2026 14:55:44 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf v2 0/9] bpf: One may_goto time slice per prog invocation
Date: Sat, 31 Oct 2026 21:55:34 +0000
Message-ID: <20261031215543.682284-1-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

may_goto stops a loop that the verifier cannot bound: after 250 ms the loop
must exit. The count and the timestamp are in the stack frame of the
function that contains the loop. So the limit is for one call of a subprog,
not for one invocation of a prog. Loops that nest across calls multiply it,
and 9 insns lock up a cpu:

  main:                 sub:
  1: call sub           1: may_goto 2f
     may_goto 2f           goto 1b
     goto 1b            2: r0 = 0
  2: r0 = 1                exit
     exit

This series uses one count and one timestamp for all may_goto of a prog, in
per-cpu memory of the prog. The main prog sets them in its first insns.
When the time is up each loop ends at its next may_goto, in any function.

There is nothing in the stack frame any more, and nothing at the entry or
at an exit of a subprog. The C code of may_goto, helpers, kfuncs and
trampolines do not change. The callers of async callbacks save and restore
count and timestamp.

 - Patch 1: the interpreter can run a prog with the timed form of may_goto.
   Then the kernel crashes. This fix does not depend on the other patches.
 - Patches 2-4 change three selftests that rely on a time slice for each
   frame.
 - Patch 5 adds per-cpu insns to the JIT of s390. It is the only JIT with
   timed may_goto that doesn't have them.
 - Patch 6 passes a pointer to arch_bpf_timed_may_goto() in place of an
   offset in the stack frame. It removes code from six archs.
 - Patch 7 is the change.
 - Patch 8 ends bpf_loop() and bpf_for_each_map_elem() when the time is up.
 - Patch 9 has the tests.

What changes for a prog:
 - The 250 ms are for all loops of an invocation, not for each frame.
 - When the time is up, a function that is called after that makes no
   iteration. Today each call has a new time slice.

Count and timestamp are per-cpu, so a second invocation of the same prog on
the same cpu shares them with the first one. The error is on the long side:
the first one gets more time. None is stopped before it is 250 ms old.

All progs with may_goto get different code: 56 of 493 progs of scx, none of
Cilium. The series adds 1.8% to their JITed code, and they use 25% less
stack. On x86-64 (Zen 5) a call of a function with may_goto is cheaper than
before, and an iteration of an empty loop costs 0.09 nsec more.

Tested on x86-64: test_progs, test_progs-no_alu32, test_progs-cpuv4,
test_progs-bpf_gcc and test_verifier have no new failure. The same is true
for test_progs with KASAN, and for test_progs and test_verifier with
mitigations on. On arm64 the new tests pass in QEMU. On s390 test_progs did
not run: progs for the per-cpu insn and for may_goto pass in QEMU. riscv,
loongarch and powerpc are compile tested only.

v1 was patches 7 and 8 of [1]. I dropped them from v2 of that series [2].
v1 -> v2:
 - v1 also had a count in per-cpu memory. A subprog took it at its entry
   and gave it back at each exit. The insns at the exit changed R2, which
   is a part of a 16-byte return value (Ihor). Now each may_goto uses the
   per-cpu count, and there are no insns at the entry and at exits.
 - Each read of the clock walked the stack to find the prog. Now may_goto
   has the address.
 - Add patches 1-6 and 8.

[1] https://lore.kernel.org/bpf/20261026025943.404450-1-alexei.starovoitov@gmail.com/
[2] https://lore.kernel.org/bpf/20261027190314.1440199-1-alexei.starovoitov@gmail.com/

Signed-off-by: Alexei Starovoitov <ast@kernel.org>

Alexei Starovoitov (9):
  bpf: Emit timed may_goto for JITed progs only
  selftests/bpf: Don't cast a pointer to .bss in arena_htab_asm
  selftests/bpf: Give the first loop of cond_break5 an end
  selftests/bpf: End the loop of parallel_test_bitmap after 50 ms
  s390/bpf: Support internal-only MOV instruction to resolve per-CPU
    addrs
  bpf: Pass a pointer to arch_bpf_timed_may_goto()
  bpf: One may_goto time slice per prog invocation
  bpf: End bpf_loop() when the time of may_goto is up
  selftests/bpf: Test one may_goto time slice per prog invocation

 arch/arm64/net/bpf_timed_may_goto.S           |  12 +-
 arch/loongarch/net/bpf_timed_may_goto.S       |  10 +-
 arch/powerpc/net/bpf_timed_may_goto.S         |   9 +-
 arch/riscv/net/bpf_timed_may_goto.S           |  10 +-
 arch/s390/net/bpf_jit_comp.c                  |  22 +-
 arch/s390/net/bpf_timed_may_goto.S            |   8 +-
 arch/x86/net/bpf_jit_comp.c                   |  12 -
 arch/x86/net/bpf_timed_may_goto.S             |   5 +-
 include/linux/bpf.h                           |   2 +
 include/linux/bpf_verifier.h                  |   4 +
 include/linux/filter.h                        |   8 +
 kernel/bpf/core.c                             |  33 +
 kernel/bpf/fixups.c                           | 149 ++-
 kernel/bpf/helpers.c                          |  19 +-
 kernel/bpf/verifier.c                         |   7 +
 .../selftests/test_parallel_bitmap.bpf.c      |  10 +
 .../selftests/bpf/prog_tests/may_goto_far.c   |  24 +-
 .../selftests/bpf/prog_tests/timed_may_goto.c | 195 ++++
 .../testing/selftests/bpf/progs/arena_htab.c  |   2 -
 .../selftests/bpf/progs/timed_may_goto.c      | 898 ++++++++++++++++++
 .../selftests/bpf/progs/timed_may_goto_ext.c  |  23 +
 .../selftests/bpf/progs/timed_may_goto_user.c | 311 ++++++
 .../bpf/progs/verifier_bpf_fastcall.c         |  72 +-
 .../bpf/progs/verifier_iterating_callbacks.c  |   6 +-
 .../selftests/bpf/progs/verifier_may_goto_1.c |  32 +-
 25 files changed, 1734 insertions(+), 149 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/timed_may_goto.c
 create mode 100644 tools/testing/selftests/bpf/progs/timed_may_goto.c
 create mode 100644 tools/testing/selftests/bpf/progs/timed_may_goto_ext.c
 create mode 100644 tools/testing/selftests/bpf/progs/timed_may_goto_user.c


base-commit: d89e1d186ec9271bf78e62771779e9fc03bf0fc3
-- 
2.55.0

