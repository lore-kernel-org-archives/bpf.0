Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793290834;
	b=0biQ5nNWiSaUcdeiYoOjmQhbp3gBXytKyDS1ElbejZqpB0JgONSXGuyJAzviSp66rnlK
	 KnhS4QzKSLK8LTG02LL6c/1Lw20wGFxqvan/zj6NNnZqlySGRPIOiJXuBs6FfID4yn8Ro
	 w/CB6uRWqZd4GlGWlfop/5Dr6y+eanu9KsqVcMp+gE/5r9scI7A6dxfy7q4d+dFPCfXCx
	 SKUQn88NLyPbVvbo0LKR1W66JY8c4wiWyce3JOnZTpzxtLknclqpNIQW0voDBcD2Vqq1O
	 BdoRkTVCcDi4+w959uOHce7L1Qbb/3dO+V35k3qDvJYXCgQU6TJg6RXqieZK6RkjW/A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793290834;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=GbjBaFU35t2rg+7gzM36NO66S27XSvjJxWT20wHlSEA=;
	b=VhVTS4CYD3falRbCBRLGElnVM22u+fG02lSjf/J40nFiqnQFq0vZXydp/2lEy9QA9Nqv
	 OzM0bEk7qexGNbat0WYeb8oaWaKpiLWgvkqGY+mr5JQTYQ+elh1xe1KzJ/glHtUv9QipS
	 De2TLmKYy6sABqsdXjppaaw/KXvTGiB2Q9jiVzNTjqLn2lcN8rR3utjLkaWUqrakqTIeR
	 Y5xL5LdcVI4h2Bbu+T86iS2wTNVY6KCKhQAEJXpKd3inttqgNk1n8Vnn9WoX+nvnMep1n
	 ugK9sUguR1UJmLc8P0iKclujeJSDzeHTTDdJ7DJ1lWjHg0QTRxu321gj2zKiCoLdkTQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AQcaiq5v;
	arc=none smtp.remote-ip=209.85.214.180
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19608606A31A
	for <bpf@vger.kernel.org>; Thu, 29 Oct 2026 16:20:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 19608606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AQcaiq5v
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2e8f2c3ad6bso15453235ad.1
        for <bpf@vger.kernel.org>; Thu, 29 Oct 2026 09:20:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793290833; x=1793895633; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=GbjBaFU35t2rg+7gzM36NO66S27XSvjJxWT20wHlSEA=;
        b=AQcaiq5vN+0xZtN+5zpXtfJGPxkFmBj/Y7WcnS1Mbuf5SP2UG3IVDmXYdR2PA6nfn1
         VwVDRkZNCba3LtIU8bSx5xYeQVcNGJwUjJTv7bYFiVaVSazBk0bKOiWf3VgoIK5wvoag
         TkZt7O+3QSEV7z7xub6JSqgskS/uSmIZa9Y1gNS1FUWKDky49qjGfwWWvQjGADybnLTw
         7uUpJW+U5o3xYZnPtDR2hgmIJdjL3Ch2UJ/9n8ekHaX2AjChSo/OAMmeQA6P2V5OSH5W
         Q57npHaJ6c7tP0WNjiK9GXAvXGK4OWhZL6hOCDdChCTxxP/iinnrZmbkEcZkIxB2ZcUf
         JfLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793290833; x=1793895633;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GbjBaFU35t2rg+7gzM36NO66S27XSvjJxWT20wHlSEA=;
        b=Jfe31IxImnq+1laiahNi8i0DKVczm0/hYlpdAyVk8DAG5Tjwz3yR9EDToSUFg1VcV9
         oFET8wKRY1Eh6egv1CgjLoKpNiOHmJCtSS0a9sVyQRHsDDiWJnNmARs/fFEoZxNLf1IH
         J+1uA5cHlPi3s8ZSbMQPV6fAWzHwGGJEDn+WU329mPs/eKrqhMPc22p7UvHcqoS/SAgL
         iGEz9J9uEzAJipYFa3Ak1CSRGOmBVN+vYqaTbxVG49cdJKBc6FGJNOUffGZ8SK3vJg4G
         6mY+Lrd3rNA3ymnRAdZajR5+3OS5XlRQUyMkRsTrTSYJkgFyD9aGAUc55AFdWFw9hXcW
         k5UA==
X-Forwarded-Encrypted: i=1; AKwUvBxt19y0L2DEpGSgZWN1ET15tv9gNEvEoOZpzFqLeiYMqO4SfulbsjuCzx6ZYOjidyTuPEo=@vger.kernel.org
X-Gm-Message-State: AFq9FYL/WumgJxkgVk21WK698jSGcUCGDK0zjR/15HYHNjIurIKIr6Xw
	wnFTr6v9QJF83BTYoeRA29cGkqkZsUhbU9URvjVv4e2NHhHw1YtGsuNR
X-Gm-Gg: AYBFou1ZFUITFx0hVQLVyjWFvIKxQNKZG7n6advuP4IA/eIhCYj+5xSemPqj6nk8Xps
	chZRoAVL9PM190jhKfcYBnqaR/7nReaz/eS1nKVPTXIuhaiVnDryfSm10fH+q4KFO0TXgBa9d/q
	A/9y1Vieo1Q0WNxMsRosKrI727zrfUwyAJBQsYfsqgukrl6JmXtXkEb0imaYe99m0RxTsk9RFi7
	6dJ94x1bzGjc7DHawOzQA4OOtph1uO9rixPLziIkj43SwQdkc7uL2qBcmVI2iAX+Nkchtq8wOoC
	K0BhV4XMXmOxtCULbdn6h5/gdjvrpdKJrIVm88GAovzryXOkc8mpVJclFtOfuhGPOmjZatUv2lU
	v+NA8OpBlPd33Nls09EIf1+eJsXKu8QwEGADU4Da23KS/XSPjNcisiIYemM+G9LLEkaetcy/qPq
	CkLdC6nC7Uwu8dUvXoMJQfdMKjctazx6quvXZO0zLVa4TMn3dyTgRWukF/KusYmWzGbyoW9n+F1
	CqmJ+HajEHlpol3x0aM+bfGjFeLSISuwpufs0Q8pYLdtGvNOjbQCBHYoNTbWIrYUsnLfvNTl5nB
	NtrKjSH/bRj95KpifIDzWhnI8fQx4mt6dqmXWaFNUaojIM/IL9YAR1XxkuojObS6UGsUdq627eQ
	aloUHp6muXJep6bdHH0kjsZ89zPRBxSAvMDiRBOKXM40TOpRdMqiqKl6k8w/WSenVdDc7cvsxs9
	/0a7S9XIMKa22TKiBRqtE=
X-Received: by 2002:a17:903:1b6d:b0:2dd:c100:4b82 with SMTP id d9443c01a7336-2eb00486351mr55897625ad.57.1793290833082;
        Thu, 29 Oct 2026 09:20:33 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.245])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eae6ce0f45sm36819225ad.70.2026.10.29.09.20.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 09:20:32 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: torvalds@linux-foundation.org
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	bpf@vger.kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	Alexei Starovoitov <ast@kernel.org>
Subject: [GIT PULL] BPF fixes for 7.4-rc1
Date: Thu, 29 Oct 2026 16:20:29 +0000
Message-ID: <20261029162030.1312952-1-alexei.starovoitov@gmail.com>
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

Hi Linus,

The following changes since commit 17bb0e2f6c8043f70a693a5f3797471cbed354c8:

  Merge tag 'pci-v7.4-changes' of git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci (2026-10-23 15:34:47 -1000)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git tags/bpf-fixes

for you to fetch changes up to c8a8a68d3ab4a06c8f5a13a8c00275351c8239b4:

  bpf: Don't re-sort subprog_info[] for every new subprogram (2026-10-28 04:20:25 +0000)

----------------------------------------------------------------
- Remove BPF_F_ARENA_SCALAR flag and .arena.data section in libbpf
  that were added for rust-bpf in this merge window. We found
  a cleaner approach that does it on compiler side instead of
  kernel/libbpf. No released kernel has them. (Alexei Starovoitov)

- Fix bpf_send_signal_task() returning -EPERM when it is called from
  a kernel thread (Aditya Sharma)

- Various fixes (Alexei Starovoitov):
    - Use emit_rsb_call() to call bpf_unwind_target() in x86 JIT to
      fix objtool warning during the build
    - Fix scalar evolution: clear delta of a widened register, don't
      widen a pointer to a buffer, don't clamp a register whose type
      changed in the loop, and reset the range of a clamped packet
      pointer
    - Finish the insn in the state that maybe_fork_scalars() splits
      off, so that pruning doesn't drop it at the head of a counted
      loop
    - Preserve the registers that carry stack arguments across
      arch_bpf_timed_may_goto() on x86-64, arm64 and riscv64
    - Don't re-sort subprog_info[] for every new subprogram
    - Fix flaky map_kptr and rcu_reentry selftests

- Use memmove() in bpf_skb_load_bytes(), bpf_skb_load_bytes_relative()
  and bpf_xdp_load_bytes(), since the destination can be a slice of
  the same packet (Ayushman Rout)

- Fixes and follow-ups for scalar evolution: reject pointer operands
  in 32-bit recurrences and latches, don't intersect with the current
  register range on clamp to avoid a false 'verifier bug', avoid false
  infinite loop reports, and recognize a 32-bit copy of the induction
  variable (Eduard Zingerman)

- Fix out-of-bounds write to btf->types[] for split BTF and propagate
  btf_add_type() errors in btf_check_all_metas() (Feng Yang)

- Fix use-after-free in bpf_timer callback that fires after its inner
  map was freed (Mani Tofigh)

- Fix x86 JIT stopping before jumps converge: size backward jumps by
  the insns they jump over (Mykyta Yatsenko)

- Fix use-after-free of struct_ops trampoline: dissociate struct_ops
  progs before the grace period of the map (Qiliang Yuan)

- Validate stack argument reads against the caller state to fix
  out-of-bounds read in the verifier, and reject callbacks with stack
  arguments (Weiming Shi)

- Tie borrowed iterator results and pointers loaded from trusted
  fields to the lifetime of their source, so that iterator next,
  destroy and reference release invalidate them (Xu Yunxiang)

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
----------------------------------------------------------------
Aditya Sharma (2):
      bpf: Remove nmi_uaccess_okay() check in bpf_send_signal_common()
      selftests/bpf: Test bpf_send_signal_task() from kernel thread context

Alexei Starovoitov (27):
      Merge branch 'bpf-fix-a-struct_ops-use-after-free-behind-a-flaky-assoc_in_timer-test'
      bpf, x86: Use emit_rsb_call() to call bpf_unwind_target()
      Merge branch 'bpf-fix-x86-jit-stopping-before-jumps-converge'
      Merge branch 'bpf-fix-bpf_send_signal_task-from-kernel-thread-context'
      Merge branch 'bpf-track-borrowed-iterator-result-lifetimes'
      Merge branch 'bpf-fixes-and-follow-ups-for-32-64-bit-scalar-evolution'
      selftests/bpf: Remove tests for global data in arena
      libbpf: Remove .arena.data
      libbpf: Keep format strings of bpf_printk() in .rodata
      selftests/bpf: Remove tests for arena access through numbers
      bpf: Remove BPF_F_ARENA_SCALAR
      bpf, x86: Remove r0_on_stack from fetching atomics in arena
      bpf: Clear delta of a register that scalar evolution widens
      selftests/bpf: Test that a widened register is not linked
      selftests/bpf: Wait for the last maps of map_kptr to be freed
      selftests/bpf: Avoid a page fault in rcu_reentry while the handler is armed
      bpf: Don't widen a pointer to a buffer in scalar evolution
      selftests/bpf: Test a loop that moves a pointer to a buffer
      bpf: Don't clamp a register whose type changed in the loop
      bpf: Reset the range of a packet pointer that scalar evolution clamps
      selftests/bpf: Test the clamp of pointers in scalar evolution
      bpf: Finish the insn in the state that maybe_fork_scalars() splits off
      selftests/bpf: Test maybe_fork_scalars() at the head of a counted loop
      bpf: Keep stack arguments in arch_bpf_timed_may_goto()
      selftests/bpf: Test stack arguments across may_goto
      Merge branch 'bpf-remove-bpf_f_arena_scalar-fix-scalar-evolution-and-scalar-forks'
      bpf: Don't re-sort subprog_info[] for every new subprogram

Ayushman Rout (1):
      bpf: Use memmove() to load bytes from an skb and an xdp_buff

Eduard Zingerman (11):
      bpf: Reject pointer operands for 32-bit recurrences/latches
      bpf: Do not intersect with current register range on clamp
      bpf: Avoid false infinite loop reports after changes in SCEV clamping
      bpf: Check the iteration count before the predicted exit value
      bpf: (zext32 (zext32 X)) -> (zext32 X) SCEV simplification rule
      bpf: Print 32-bit SCEV bounds as 32-bit numbers
      selftests/bpf: Pointer operands for 32-bit recurrences/latches
      selftests/bpf: Cases with empty range error under old clamping logic
      selftests/bpf: Cases for SCEV interaction with infinite loop detection
      selftests/bpf: 32-bit copy of the counter compared at the latch
      selftests/bpf: Restore stack pointer subrange pruning coverage

Feng Yang (2):
      bpf: Propagate btf_add_type() errors in btf_check_all_metas()
      bpf: Fix out-of-bounds btf->types write for split BTF

Mani Tofigh (1):
      bpf: Fix bpf_timer callback running on a freed map

Mykyta Yatsenko (2):
      bpf: Size backward jumps by the insns they jump over
      selftests/bpf: Test JIT jumps which change at a repeated image length

Qiliang Yuan (4):
      bpf: Protect the struct_ops association with a spinlock
      bpf: Dissociate struct_ops progs before the grace period of the map
      selftests/bpf: Test freeing a struct_ops map under a running prog
      selftests/bpf: Wait for the struct_ops map to be freed in assoc_in_timer

Weiming Shi (2):
      bpf: Validate stack arg reads against caller state
      selftests/bpf: Test missing and callback stack arguments

Xu Yunxiang (2):
      bpf: Track borrowed iterator results by default
      selftests/bpf: Test borrowed iterator result lifetimes

 Documentation/bpf/bpf_iterators.rst                |   10 +
 arch/arm64/net/bpf_jit_comp.c                      |    5 -
 arch/arm64/net/bpf_timed_may_goto.S                |   10 +-
 arch/riscv/net/bpf_timed_may_goto.S                |   27 +-
 arch/x86/net/bpf_jit_comp.c                        |  176 +--
 arch/x86/net/bpf_timed_may_goto.S                  |    3 +
 include/linux/bpf.h                                |   10 +-
 include/linux/bpf_verifier.h                       |    9 +-
 include/linux/btf.h                                |    1 +
 include/linux/filter.h                             |    1 -
 include/uapi/linux/bpf.h                           |    6 -
 kernel/bpf/bpf_struct_ops.c                        |   29 +-
 kernel/bpf/btf.c                                   |   26 +-
 kernel/bpf/core.c                                  |   12 +-
 kernel/bpf/fixups.c                                |   39 -
 kernel/bpf/helpers.c                               |   11 +-
 kernel/bpf/log.c                                   |    8 +
 kernel/bpf/scev.c                                  |   65 +-
 kernel/bpf/states.c                                |   36 +-
 kernel/bpf/syscall.c                               |    4 -
 kernel/bpf/verifier.c                              |  205 ++--
 kernel/trace/bpf_trace.c                           |    9 +-
 net/core/filter.c                                  |    6 +-
 tools/include/uapi/linux/bpf.h                     |    6 -
 tools/lib/bpf/bpf_helpers.h                        |   18 +-
 tools/lib/bpf/libbpf.c                             |  433 +-------
 tools/testing/selftests/bpf/Makefile               |   12 +-
 tools/testing/selftests/bpf/Makefile.buildvars     |   25 -
 tools/testing/selftests/bpf/Makefile.skel          |   18 +-
 .../bpf/prog_tests/arena_scalar_blinded.c          |   21 -
 .../selftests/bpf/prog_tests/data_in_arena.c       |  216 ----
 tools/testing/selftests/bpf/prog_tests/jit_insns.c |   59 +
 tools/testing/selftests/bpf/prog_tests/map_kptr.c  |    5 +
 .../testing/selftests/bpf/prog_tests/rcu_reentry.c |   19 +-
 .../testing/selftests/bpf/prog_tests/send_signal.c |  106 ++
 .../bpf/prog_tests/test_struct_ops_assoc.c         |   37 +-
 tools/testing/selftests/bpf/prog_tests/verifier.c  |    2 -
 tools/testing/selftests/bpf/progs/arena_noarena.c  |   15 -
 .../bpf/progs/btf__verifier_stack_arg_order.c      |   10 +
 tools/testing/selftests/bpf/progs/data_in_arena.c  |  112 --
 .../selftests/bpf/progs/data_in_arena_decl.c       |   37 -
 .../selftests/bpf/progs/data_in_arena_extern.c     |   20 -
 .../selftests/bpf/progs/data_in_arena_fail.c       |   20 -
 .../selftests/bpf/progs/data_in_arena_nomap.c      |   20 -
 .../selftests/bpf/progs/data_in_arena_rust.rs      |   73 --
 tools/testing/selftests/bpf/progs/iters_testmod.c  |  370 +++++++
 .../bpf/progs/struct_ops_assoc_in_timer.c          |   16 +
 .../selftests/bpf/progs/test_send_signal_kern.c    |   29 +
 tools/testing/selftests/bpf/progs/verifier_arena.c |   15 +
 .../selftests/bpf/progs/verifier_arena_scalar.c    | 1155 --------------------
 .../testing/selftests/bpf/progs/verifier_bounds.c  |   41 +
 tools/testing/selftests/bpf/progs/verifier_scev.c  |  504 ++++++++-
 .../selftests/bpf/progs/verifier_stack_arg.c       |  119 ++
 .../selftests/bpf/progs/verifier_stack_arg_order.c |  121 +-
 .../selftests/bpf/progs/verifier_stack_ptr.c       |   30 +-
 .../selftests/bpf/progs/verifier_vfs_accept.c      |   17 +
 .../selftests/bpf/progs/verifier_vfs_reject.c      |   19 +
 .../testing/selftests/bpf/test_kmods/bpf_testmod.c |   25 +
 .../testing/selftests/bpf/test_kmods/bpf_testmod.h |    4 +
 .../selftests/bpf/test_kmods/bpf_testmod_kfunc.h   |    5 +
 tools/testing/selftests/bpf/test_loader.c          |    2 -
 61 files changed, 1884 insertions(+), 2580 deletions(-)
 delete mode 100644 tools/testing/selftests/bpf/prog_tests/arena_scalar_blinded.c
 delete mode 100644 tools/testing/selftests/bpf/prog_tests/data_in_arena.c
 delete mode 100644 tools/testing/selftests/bpf/progs/data_in_arena.c
 delete mode 100644 tools/testing/selftests/bpf/progs/data_in_arena_decl.c
 delete mode 100644 tools/testing/selftests/bpf/progs/data_in_arena_extern.c
 delete mode 100644 tools/testing/selftests/bpf/progs/data_in_arena_fail.c
 delete mode 100644 tools/testing/selftests/bpf/progs/data_in_arena_nomap.c
 delete mode 100644 tools/testing/selftests/bpf/progs/data_in_arena_rust.rs
 delete mode 100644 tools/testing/selftests/bpf/progs/verifier_arena_scalar.c
