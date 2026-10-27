Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793127797;
	b=WiWjho01oCjMhxRVH+ni89WXqA1CrpRWbxwcB48j6ol4F0gQfZpuKBc8jAva04vtzbFY
	 EI21lkegdOQnOvFdzqiKsDwjtzX6mm51bzsNOQ7oEqs7aWt6MA40D6WBIi1XEquCLSHk5
	 Fvd5x8kVqfc50Z5MC/nm0XoA6zmMxKerWl0c7xEqUcSFjmt8K1d8tOHB/myTZLWDXQZx8
	 ou5x/UzSj3yaNbFsA90Wts+sVaU84KF8OKmm3dDqaBPYH51os2kAnnV0/vOMOQpVe00gg
	 zT+7nEKJamUPTy6hVvGYjNNi7XWIF78eK+F2W7TtZYvzrfLKO6XOCl0vkSn+j1Fz/Qw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793127797;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=qyPxCmrKETihz94QtuIeATQMP0DCIh8n7znBDGvtQFM=;
	b=bEqyPonNxN3ACQ4nd0w5wLPAaeFU6Lmc0FuR4Mz6n5p2Y7VCSrP2xtrT8Y8oVNJCzoQk
	 9N7zn0PJfLFSsn8JsBqqyzdDd5CKfOXfoMiGVqYDDHP/1IapZ1OIGzPbW3YBqM5GDGQwk
	 R23ir9MPNiou9q4U7YG7SC5x58Xc2fsxDzvh29lcsfXBt/zy5OwuUivpG0IR01CCRwqT0
	 dn0ZgYpmeDvBZsTSGGUEFt9gCUEuCfn3T5pgyK7YFLNOE+kR3tDH2/TaiU1CImnfUMLbE
	 Xif+h0V+L77eSHnShAsDokKZyOgpeRNUJcYwOlpRzwPYd9MBNy6EAHuSGzzmjSWV1PA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SyZY3uab;
	arc=none smtp.remote-ip=209.85.214.179
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57C3C606A31A
	for <bpf@vger.kernel.org>; Tue, 27 Oct 2026 19:03:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 57C3C606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SyZY3uab
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2e985106c0cso1070895ad.2
        for <bpf@vger.kernel.org>; Tue, 27 Oct 2026 12:03:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793127797; x=1793732597; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=qyPxCmrKETihz94QtuIeATQMP0DCIh8n7znBDGvtQFM=;
        b=SyZY3uab8eHvrBpZWgqyzM50OB8bWFukvcFamGB7a3cvnaoOPFOe4hPIKOF/uFXprg
         Sy9RohETtGD/MPoawXPB0ujkIzokEjlae70xUXtYjXI61ESWGRrMpAeVXpOU9ccVTu4+
         c6PGUYMcrbN5qvrnOWJozqpyTMW+qktcHzP6pdv0tcPwK7RUr3WP5oPvHnC5qgVGUAt7
         BYQ705yNZSqObvG/msoR4N1aXaiUKkZl6wdSBoF9bHfHKuGZs7KSaiLK+TRM/deXXkT7
         tnKHNyWHjaW4vY8v0Lvl5tGAClyX9oHHe2dkDfTWgXn4ZJVsQEXH46u5ZhY46xY5V30N
         Zt7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793127797; x=1793732597;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qyPxCmrKETihz94QtuIeATQMP0DCIh8n7znBDGvtQFM=;
        b=VKD6skCpcrhdiusFlPQW8HVoXw0ykna/CG8SavmgKIi1mDEVh0zY2xJ2CWCySM0Oq6
         qu9B/JoKGss6kMrqG5ldVXJzMab+qsybK5GBBSLcL9YxsOi76dKuksjYmq1mrnK38zyi
         Sxy9u5U50BKJC5eoF5ah29ty2f3AFizDOYLiLhRGYGCrsW5CJm7yzOsPiPZBZdAelTn2
         gx3Lzkd9T3NT4U7t25feR0UMYJGlj5I93ag5U89Ah9TjbMOcgBUHfWqBZYq929DJKgs+
         se2b3nqTG3VE9JOUgQ//GfaWWiXUXRPOjE5yUewkU8qskmCeWKwhGx14ZOunmulRNLqZ
         akCw==
X-Gm-Message-State: AFq9FYKhmp5OERej1+BvmWcNSjF8/Zmkuz8z89+vipcMuOKQmlUL8/14
	GJs7wHL+MQhn/gwa0SVzNTFxY2KjM3LWdVjXoX+XO1LocfAVZVcVWOI7KfiMNA==
X-Gm-Gg: AYBFou2gmZP0YiiESOoIeZB7wKXrMCWquikNbBvDKkvbeFcXWsNoU4JIShbfPYqGXCK
	j/0EiHalxr6AiMUQNl8B84Xw7iUWcKjgFfFMa1fEz/3L5p4s6G97iCGvhSDY0NGyUab9QFGJJHV
	1EM00xUE1gciQJvDkZUPAt8VcdawMAOR7jKwLCL4FyW/wvBeNTcAa9AjdHGKnhxY9tkQ9YgFUrR
	LoZO5uxYX+IjGDBohbydFK5Pkuz7fgjSDriPiE2lVkgcEkQX7b32s1JMyrRlHpgmpFDixHJs0iU
	geBPtELwHFtInawIqTF7Oc8yWfzD08ot5OL8e6vSENYB0PHX9Eomebcw1GQBj5R7mqREiCkO4As
	/70DpeAt6wyj3l4aicdh0DaH61d+CmasmRIITkd4DC6MtpwOzlqvt3Bqpi4qGimS6OgcC9JmbNx
	du10qXQuWIaHS451NdyvZnzoHH9FUemQuH6yvLj75zP0E/ots7dRwoMPW50E7tcJYQJ04FR+R+y
	YJhSOYLIV1FegM4eTPlPnHwELwk8b/JpKhagtDAN6hWY7uZVPJYTqs9yZJJD/ojaNQSFb/8jUg3
	RnJFqj6UJPlZTiMlYKeSpingFKnyzxQytSZdX37d/qDDhjaboG/PkrCsgqQv6opRVk5mq9w8g+6
	pBzV2I8JpoxEX5Pnr1La6xmgYEl0hsGy2js06VzjxuMiWXp+IXHR2HZooISxM6wl2NMcU80h1RA
	==
X-Received: by 2002:a17:902:e5c6:b0:2e8:21a7:dd02 with SMTP id d9443c01a7336-2eb00590629mr2130375ad.58.1793127796254;
        Tue, 27 Oct 2026 12:03:16 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.253])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eae6bdd4c8sm13327765ad.28.2026.10.27.12.03.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 12:03:15 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH v2 bpf 00/19] bpf: Remove BPF_F_ARENA_SCALAR, fix scalar evolution and scalar forks
Date: Tue, 27 Oct 2026 19:02:55 +0000
Message-ID: <20261027190314.1440199-1-alexei.starovoitov@gmail.com>
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

This series removes BPF_F_ARENA_SCALAR and fixes bugs in scalar evolution,
in maybe_fork_scalars() and in the trampoline of may_goto. The groups of
patches do not depend on each other.

v1 was Part 1 of "bpf: Stack in arena and a verifier that joins states"
[1]. Parts 2 and 3 of that series are not here.

 - Patches 1-6 remove BPF_F_ARENA_SCALAR, .arena.data and what came with
   them. The flag lets a prog access arena through plain numbers, for
   languages that have no address spaces. The compiler can emit one
   addr_space_cast for each pointer instead. That is cheaper than one more
   insn for each access. No released kernel has the flag.
 - Patches 7-8: scalar evolution does not clear 'delta' in a register that
   it widens. Then the verifier calculates an incorrect range for a linked
   register, and an unsafe prog loads.
 - Patches 9-10 make two selftests reliable: map_kptr and rcu_reentry.
 - Patches 11-12: scalar evolution widens a pointer to a buffer
   (PTR_TO_BUF). The verifier rejects an access to a buffer at a variable
   offset. Thus it rejects a correct loop over the per-cpu values of a map
   element.
 - Patches 13-15: two bugs in the clamp of scalar evolution. A pointer that
   the loop invalidates becomes a scalar with the range of the offsets of
   the pointer. A packet pointer keeps a range that is not valid for its
   new offsets. In the two cases an unsafe prog loads and crashes the
   kernel.
 - Patches 16-17: maybe_fork_scalars() splits a state in two and verifies
   the second state later, from the same insn. In a loop that scalar
   evolution counted, pruning drops the second state. Then no one verifies
   one of the two values, and a prog that reads out of bounds loads.
 - Patches 18-19: arch_bpf_timed_may_goto() does not save the registers in
   which the JITs pass stack arguments. After may_goto such an argument is
   not what the verifier knows about it. An unsafe prog crashes the kernel.

Tests on x86-64, compared with the same tests on the base:

  test_progs, test_progs-no_alu32, test_progs-cpuv4,   no new failure
  test_progs-bpf_gcc, test_verifier, test_maps
  test_progs with KASAN                                no new failure
  veristat, 36 weekly builds of Cilium, 5032 progs     same verdicts,
                                                       insns -0.03%
  veristat, sched-ext/scx, 563 progs                   same verdicts
  veristat, selftests from clang 21, clang 24 and GCC  see below

In the selftests the verdict changes only for the tests of this series and
for the tests of .arena.data. The change in Cilium is from patch 16. arm64
is compile tested.

v1 -> v2:
 - Rebase on the fixes for scalar evolution from Eduard.
 - Drop "bpf: One time slice of may_goto for a run of a prog" and its
   tests. The patch has bugs. The insns at the exit of a subprog change R2,
   which is a part of a 16-byte return value (Ihor). A nested run of the
   prog starts the time slice again. I will send it as a separate series.
 - Patch 7: use clear_scalar_id() (Daniel).
 - Drop "bpf: Fix a false verifier bug in the clamp of scalar evolution"
   and its tests. Commit 0c33d612bdd5 ("bpf: Do not intersect with current
   register range on clamp") fixes the bug in a better way (Eduard).
 - Patch 5: name the two schedulers in C that set the flag.
 - Patch 11: correct the reason why two selftests load today.
 - Add patches 10, 13-15 and 18-19.
 - Add patches 16-17. They were patch 46 and a part of patch 75 in v1. The
   bug is in the tree today (Ihor). The log in v1 said that no prog is
   affected. That was wrong.

[1] https://lore.kernel.org/bpf/20261026025943.404450-1-alexei.starovoitov@gmail.com/

Signed-off-by: Alexei Starovoitov <ast@kernel.org>

Alexei Starovoitov (19):
  selftests/bpf: Remove tests for global data in arena
  libbpf: Remove .arena.data
  libbpf: Keep format strings of bpf_printk() in .rodata
  selftests/bpf: Remove tests for arena access through numbers
  bpf: Remove BPF_F_ARENA_SCALAR
  bpf, x86: Remove r0_on_stack from fetching atomics in arena
  bpf: Clear delta of a register that scalar evolution widens
  selftests/bpf: Test that a widened register is not linked
  selftests/bpf: Wait for the last maps of map_kptr to be freed
  selftests/bpf: Avoid a page fault in rcu_reentry while the handler is
    armed
  bpf: Don't widen a pointer to a buffer in scalar evolution
  selftests/bpf: Test a loop that moves a pointer to a buffer
  bpf: Don't clamp a register whose type changed in the loop
  bpf: Reset the range of a packet pointer that scalar evolution clamps
  selftests/bpf: Test the clamp of pointers in scalar evolution
  bpf: Finish the insn in the state that maybe_fork_scalars() splits off
  selftests/bpf: Test maybe_fork_scalars() at the head of a counted loop
  bpf: Keep stack arguments in arch_bpf_timed_may_goto()
  selftests/bpf: Test stack arguments across may_goto

 arch/arm64/net/bpf_jit_comp.c                 |    5 -
 arch/arm64/net/bpf_timed_may_goto.S           |   10 +-
 arch/riscv/net/bpf_timed_may_goto.S           |   27 +-
 arch/x86/net/bpf_jit_comp.c                   |   63 +-
 arch/x86/net/bpf_timed_may_goto.S             |    3 +
 include/linux/bpf_verifier.h                  |    8 +-
 include/linux/filter.h                        |    1 -
 include/uapi/linux/bpf.h                      |    6 -
 kernel/bpf/core.c                             |    9 +-
 kernel/bpf/fixups.c                           |   39 -
 kernel/bpf/scev.c                             |   18 +-
 kernel/bpf/syscall.c                          |    4 -
 kernel/bpf/verifier.c                         |   97 +-
 tools/include/uapi/linux/bpf.h                |    6 -
 tools/lib/bpf/bpf_helpers.h                   |   18 +-
 tools/lib/bpf/libbpf.c                        |  433 +-----
 tools/testing/selftests/bpf/Makefile          |   12 +-
 .../testing/selftests/bpf/Makefile.buildvars  |   25 -
 tools/testing/selftests/bpf/Makefile.skel     |   18 +-
 .../bpf/prog_tests/arena_scalar_blinded.c     |   21 -
 .../selftests/bpf/prog_tests/data_in_arena.c  |  216 ---
 .../selftests/bpf/prog_tests/map_kptr.c       |    5 +
 .../selftests/bpf/prog_tests/rcu_reentry.c    |   19 +-
 .../selftests/bpf/prog_tests/verifier.c       |    2 -
 .../selftests/bpf/progs/arena_noarena.c       |   15 -
 .../selftests/bpf/progs/data_in_arena.c       |  112 --
 .../selftests/bpf/progs/data_in_arena_decl.c  |   37 -
 .../bpf/progs/data_in_arena_extern.c          |   20 -
 .../selftests/bpf/progs/data_in_arena_fail.c  |   20 -
 .../selftests/bpf/progs/data_in_arena_nomap.c |   20 -
 .../selftests/bpf/progs/data_in_arena_rust.rs |   73 --
 .../selftests/bpf/progs/verifier_arena.c      |   15 +
 .../bpf/progs/verifier_arena_scalar.c         | 1155 -----------------
 .../selftests/bpf/progs/verifier_bounds.c     |   41 +
 .../selftests/bpf/progs/verifier_scev.c       |  209 ++-
 .../selftests/bpf/progs/verifier_stack_arg.c  |  119 ++
 tools/testing/selftests/bpf/test_loader.c     |    2 -
 37 files changed, 525 insertions(+), 2378 deletions(-)
 delete mode 100644 tools/testing/selftests/bpf/prog_tests/arena_scalar_blinded.c
 delete mode 100644 tools/testing/selftests/bpf/prog_tests/data_in_arena.c
 delete mode 100644 tools/testing/selftests/bpf/progs/data_in_arena.c
 delete mode 100644 tools/testing/selftests/bpf/progs/data_in_arena_decl.c
 delete mode 100644 tools/testing/selftests/bpf/progs/data_in_arena_extern.c
 delete mode 100644 tools/testing/selftests/bpf/progs/data_in_arena_fail.c
 delete mode 100644 tools/testing/selftests/bpf/progs/data_in_arena_nomap.c
 delete mode 100644 tools/testing/selftests/bpf/progs/data_in_arena_rust.rs
 delete mode 100644 tools/testing/selftests/bpf/progs/verifier_arena_scalar.c


base-commit: 9ce722236a20e7a913b54df8b6098ec6324ba58a
-- 
2.55.0

