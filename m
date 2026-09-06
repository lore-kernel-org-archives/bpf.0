Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B87D3537FD
	for <bpf@vger.kernel.org>; Sun,  6 Sep 2026 15:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788709375; cv=none; b=g9k1DpaCRqzpe9wpDA0p9GLmwsBfCCDGbsYb77BxWqrWO2k2ERTUzbDHMnkUDsqmWdhXPqNMe1LtRxZKOsf1B1Hw7/1Ej7uw4C/EsxqgF2/8Da3s4SCJEdarPrJMUro533w7foOqGPVEQXL8fEi1Qcv2RY6PQnxQ8d7TIAJZehE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788709375; c=relaxed/simple;
	bh=PbpRO+38pw4uuL8kzKp09oykn4fBZTQ/nyXtB2TkFdY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qz3BHzm1IbTdDM7h2l7l7cQNG66dO7BGMhpVBc+8BCpoCuYB7o2qHHpqVk+4FLfgO32QiWQg84lhGWEaw65x7/mOq3ybu2qQd/rjrAWLEOnY8pjhQAH7D1BYcgyMHTugewVc4/9SAWjlmYqnbDxBT/Cct/OUddF7ik39FLoIk1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I0BFxGQm; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I0BFxGQm"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2d91ff7d9acso22350805ad.3
        for <bpf@vger.kernel.org>; Sun, 06 Sep 2026 08:42:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788709372; x=1789314172; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=7V9iSTI4qAocLoUUsz3V4qWmM9T2kyGOVf2V+V/aSYw=;
        b=I0BFxGQm3Xrjav4EnXajotAH3saknRRe7MVG+dofsZ+VM1ZBERTtGCx3z751b9Xvao
         +jU/DzIBV1wMxTAdOWOK8qdL6753hfShMb/jKrhIqYBuToh8rexmIo1kBFICRYVMko29
         LypAxyinreAqjsY+sob/fhhIV2NN/OEkT/lJpyD8eZJEmul/p0kwaPTysjvhC2T0CByf
         G3RVkTEr90ql0yi2VZ1PU7GPIU8jVJswEEZOC1gJ9toIkRPxOgwWbZMiNEoXtDUunSgv
         7sjTANf8INm15QI8LvTdckCCkZrSzPjv8M0GrVRxxvgVdmjol/fK242pYPBLPOOEnkKs
         Gifg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788709372; x=1789314172;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7V9iSTI4qAocLoUUsz3V4qWmM9T2kyGOVf2V+V/aSYw=;
        b=pBJBU/qGmEYrFgc1DWwOz7SgVp/HKg/GUQTVd+FnMbacIUuVB8dFFGkKjo/ut4+7dv
         ZjO33lys1yGhg07kRVnbUWP008QwwqhZ3UaIuyF/AYo9AKEV9ZcknzrQz/7u/GKkn72P
         nIpPPBtElxY/6BKr/2OCSNfIWWWnnC5JzIX8tN+pqsXDB5SB8FfRC3kM4u60xzKQBFnP
         /UUrbX4HiLt6ya80vWyVlj3T7zPpEk5p/wv/Od6jp+CtQYULmtZlzIUy0F88m8jDpr0n
         qJsjHvJYyYPSToyo9UDW5c2c52NTdfrq4GPgtTudvXwqbYvAMDyixRZ7T4yLsP5jSUi9
         sRHA==
X-Gm-Message-State: AFuF++lym7posa10ODo/M9gAC8DKxR9954m3gwhTGQnjl3nYVw/knW6s
	n0/htDXq1uHeUMOo7CceAdTBdyBtq4zWMOW+Zbie6LE1bkeKdjfsMuG6
X-Gm-Gg: AYBFou18x+UGfmpz3Nv2Q6M6nGoTjnxVZpHFAVAW7h7eT8O0gKZWFGeHHyBY4lV9YiQ
	0KyDs2ktSzsL1hxrTEeKVW7QOHWiFX6OQ5sLqjfnOV+CZMgsL0VizuBAwvSkPWz3xgPImvtODX6
	Ljeat2nNmkyshEXAxNVdv0iJqpX1Ae5lVHDPATYLmEF+a9ug/9v6ekz1kkNUGFcPXKPv3iX4uEN
	HIQ757H8i4gsRuoGWN2cj0dyOJ3UX9PYJ/5DGW3gHzS2QsROZ5uQm74VPFcG8t8jyKXVFKBVNps
	Rlrq43NFuoilGXXpY180tDSRtQ/YL0YnYvPXsXkq8b9HJsBVi2Z236VDoRjEzAI/p/jtfEqgcFc
	9mI/7Aximmk+oPtmKO3E74l3R1LaVd0gcIDUngIOJ49ohWknrMIXvDmt90ef7hDAaCpwLVNkPQY
	25FJKPJU1p7D71Wmj84Qt1YcUY4QDVP0t7/2CwVDyqXlwh1NhsHWms6ZzODhwEKtQXbIj+aYv6r
	ATdQuSVQKV/BdH3SmBHCjmTLdrEAIqTULeY+AZs6tGc4VM4dE/rNYomkCF4WmRKOuGpmd4obcK+
	3BZinEE8FUI=
X-Received: by 2002:a17:902:e805:b0:2db:3b35:1ac6 with SMTP id d9443c01a7336-2db3b351c2emr95471045ad.5.1788709372411;
        Sun, 06 Sep 2026 08:42:52 -0700 (PDT)
Received: from localhost.localdomain ([47.33.33.219])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3339a62be87sm18928162eec.6.2026.09.06.08.42.51
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 06 Sep 2026 08:42:51 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: torvalds@linux-foundation.org
Cc: bpf@vger.kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	memxor@gmail.com,
	eddyz87@gmail.com
Subject: [GIT PULL] BPF fixes for 7.3-rc2
Date: Sun,  6 Sep 2026 08:42:49 -0700
Message-ID: <20260906154249.75894-1-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linus,

The following changes since commit 91ec2035134982b98fab0609a9fd8480e8217dc1:

  Merge tag 'net-next-7.3' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next (2026-08-20 08:16:04 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git tags/bpf-fixes

for you to fetch changes up to 536b523b407397c8d3967c020ce7aad70a0ea030:

  bpf, riscv: Make arena support depend on ZACAS (2026-09-06 16:23:12 +0200)

----------------------------------------------------------------
The PR mainly contains verifier fixes that address bugs reported
by Nicholas Carlini.

- Fix incorrect non-NULL inference in pointer comparisons: pointer
  types that may be NULL at runtime, pointers with unbounded offsets,
  JMP32 comparisons with zero, and imprecise zero registers
  (Eduard Zingerman)

- Fix precision tracking for half-dead zero spills, ld_abs/ld_ind
  implicit subprog exit, bpf_loop() callbacks, linked scalar ids and
  NULL call arguments (Eduard Zingerman)

- Reject BPF_PSEUDO_FUNC reference to the main program, fix zero
  extension of arena 32-bit cmpxchg, don't rewrite bpf_fastcall
  patterns entered by a jump (Eduard Zingerman)

- Fix percpu map update and BPF_F_CPU validation with sparse CPU IDs
  (Hui Su)

- Fix NULL-ptr-derefs in bpf_snprintf_btf() for void and VAR types,
  and reject key-less BTF for hash maps (Jiayuan Chen)

- Fix out-of-bounds access in disassembler on invalid LDSX instruction,
  mark siginfo of signal tracepoints as scalar and sched_process_wait
  argument as nullable, mark faultable stack helpers as sleepable,
  reject tail calls and legacy packet loads from callbacks,
  enforce rbtree callback lock restrictions for resilient locks,
  require MEM_PERCPU for percpu kptr stores,
  clear NON_OWN_REF after RCU protection ends,
  mark NULL kptr stores precise,
  preserve inner map identity in callback frames,
  reject non-scalar bpf_loop() iteration counts
  (Kumar Kartikeya Dwivedi)

- Fix trampoline allocation slowdown on x86 by using EXECMEM_MODULE_DATA
  (Mike Rapoport)

- Keep bpf_refcount_acquire() nullable for borrowed RCU kptrs and reject
  untrusted allocated-object pointers (Ning Ding)

- Fix special fields handling in recycled rhtab elements
  (Nuoqi Gui, Yuan Chen)

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
----------------------------------------------------------------
Alexei Starovoitov (6):
      Merge branch 'bpf-fix-null-ptr-derefs-when-showing-a-void-btf-type'
      Merge branch 'misc-bug-fixes-part-1'
      Merge branch 'misc-bug-fixes-part-2'
      Merge branch 'misc-bug-fixes-part-3'
      Merge branch 'misc-bug-fixes-part-4'
      Merge branch 'bpf-add-missing-precision-propagation-after-bpf_register_is_null-calls'

Chen Pei (1):
      bpf, riscv: Make arena support depend on ZACAS

Eduard Zingerman (34):
      bpf: check_cond_jmp_op(): properly infer if register is null
      selftests/bpf: a demo for check_cond_jmp_op() non-null inference bug
      bpf: don't downgrade half-dead scalar zero spills to STACK_ZERO
      selftests/bpf: half-dead scalar zero stack spill test
      bpf: backtrack_insn(): Handle ld_{abs,ind} subprog exit edge
      selftests/bpf: Precision tracking across BPF_ABS subprog exit
      bpf: backtracking shouldn't clear outer frame R1-R5 for callbacks
      selftests/bpf: test case for unsafe pruning of bpf_loop checkpoints
      bpf: reject BPF_PSEUDO_FUNC reference to the main program
      selftests/bpf: BPF_PSEUDO_FUNC reference to the main program
      bpf: zero extend the result of an arena 32-bit cmpxchg
      bpf: update disasm.c to print BPF_PROBE_ATOMIC as atomics
      selftests/bpf: check zero extension of an arena 32-bit cmpxchg
      bpf: don't rewrite bpf_fastcall patterns entered by a jump
      selftests/bpf: bpf_fastcall patterns entered by a jump
      bpf: Don't infer non-NULL from a pointer with an unbounded offset
      selftests/bpf: No non-NULL inference from unbounded offset pointers
      bpf: Don't resurrect a scalar id dropped by collect_linked_regs()
      selftests/bpf: Check the linked regs cap for the compared register
      bpf: Don't predict JMP32 pointer vs zero comparisons
      selftests/bpf: Check that JMP32 pointer vs zero jumps are not predicted
      bpf: Mark the zero register precise for a register-form NULL check
      selftests/bpf: No non-NULL inference from an imprecise zero register
      bpf: mark a NULL call argument precise
      selftests/bpf: precision of a NULL helper argument
      bpf: mark a NULL memory argument of a call precise
      selftests/bpf: precision of a NULL global subprogram memory argument
      bpf: mark a NULL kfunc argument precise
      selftests/bpf: precision of a NULL kfunc argument
      bpf: mark a NULL BTF_ID argument of a global subprogram precise
      selftests/bpf: precision of a NULL global subprogram BTF_ID argument
      bpf: propagate mark_chain_precision() errors out of loop_flag_is_zero()
      bpf: use mark_arg_precision() in check_mem_size_reg()
      Merge branch 'fix-bpf_loop-syzbot-report'

Florian Westphal (1):
      selftests/bpf: Add tests to assert that netfilter progs cannot write to skb

Hui Su (3):
      bpf: Fix infinite loop in pcpu_freelist push with one possible CPU
      bpf: Fix BPF_F_CPU validation for sparse CPU IDs
      bpf: Fix percpu map update indexing with sparse CPU IDs

Jiayuan Chen (8):
      bpf: Fix REG INVARIANTS VIOLATION on speculative pointer arithmetic
      selftests/bpf: Add reg-invariants test for speculative pointer arithmetic
      bpf: Reject key-less BTF for hash maps
      bpf: Fix NULL-ptr-deref when showing a void BTF type
      bpf: Fix NULL-ptr-deref in btf_var_show()
      selftests/bpf: Add test for key-less BTF hash map
      selftests/bpf: Add test for showing a void BTF type
      selftests/bpf: Fix flaky bpf_nf test when random NAT port is 0

Kumar Kartikeya Dwivedi (31):
      bpf: Reject invalid LDSX instruction in disassembly
      selftests/bpf: Test invalid DW LDSX diagnostics
      bpf: Mark signal tracepoint siginfo arguments as scalar
      selftests/bpf: Cover signal tracepoint siginfo sentinels
      bpf: Reject tail calls directly from callback frames
      selftests/bpf: Test direct tail calls from callbacks
      bpf: Reject resilient lock operations in rbtree callbacks
      selftests/bpf: Reject resilient unlock in rbtree callback
      bpf: Mark sched_process_wait argument as nullable
      selftests/bpf: Test sched_process_wait nullable argument
      bpf: Mark syscall helpers as sleepable
      selftests/bpf: Check syscall helpers in timer callbacks
      bpf: Check ancestor frames for rbtree callbacks
      selftests/bpf: Check rbtree callback restrictions in subprogs
      bpf: Mark bpf_btf_find_by_name_kind() as sleepable
      selftests/bpf: Test btf lookup helper sleepability
      bpf: Mark faultable stack helpers as sleepable
      selftests/bpf: Check faultable stack helper contexts
      bpf: Reject legacy packet loads from callbacks
      selftests/bpf: Reject legacy packet loads from callbacks
      bpf: Require MEM_PERCPU for percpu kptr stores
      selftests/bpf: Reject non-percpu values in percpu kptr fields
      bpf: Clear NON_OWN_REF after RCU protection ends
      selftests/bpf: Reject graph kptr use after RCU unlock
      selftests/bpf: Test timer field on recycled rhtab element
      bpf: Mark NULL kptr stores precise
      selftests/bpf: Test imprecise scalar kptr stores
      bpf: Preserve inner map identity in callback frames
      selftests/bpf: Test inner map identities in callbacks
      bpf: Reject non-scalar bpf_loop iteration counts
      selftests/bpf: Test pointer bpf_loop iteration count rejection

Mike Rapoport (Microsoft) (1):
      x86/bpf: Make arch_bpf_trampoline_size allocate from EXECMEM_MODULE_DATA

Ning Ding (4):
      bpf: Keep refcount_acquire nullable for borrowed RCU kptrs
      selftests/bpf: Test borrowed refcount acquisition nullability
      bpf: Reject untrusted allocated-object pointers
      selftests/bpf: Reject refcount acquisition after RCU unlock

Nuoqi Gui (2):
      bpf: Cancel special fields when recycling rhtab elements
      selftests/bpf: Test rhtab kptr cancellation semantics

Yonghong Song (1):
      selftests/bpf: Bound the offset accumulator in __tld_fetch_key()

Yuan Chen (1):
      bpf: Preserve special fields in recycled rhtab elements

 arch/riscv/net/bpf_jit_comp64.c                    |  10 +-
 arch/x86/net/bpf_jit_comp.c                        |   8 +-
 include/linux/bpf.h                                |   3 +-
 include/linux/bpf_verifier.h                       |  16 +-
 include/linux/filter.h                             |   1 -
 kernel/bpf/arraymap.c                              |   5 +-
 kernel/bpf/backtrack.c                             |  62 ++---
 kernel/bpf/bpf_iter.c                              |   2 +-
 kernel/bpf/btf.c                                   |  27 ++-
 kernel/bpf/cfg.c                                   |   3 +
 kernel/bpf/core.c                                  |   5 -
 kernel/bpf/disasm.c                                |  50 ++--
 kernel/bpf/fixups.c                                |   7 +-
 kernel/bpf/hashtab.c                               |  29 +--
 kernel/bpf/local_storage.c                         |   5 +-
 kernel/bpf/percpu_freelist.c                       |  35 ++-
 kernel/bpf/percpu_freelist.h                       |   1 +
 kernel/bpf/stackmap.c                              |   2 +
 kernel/bpf/states.c                                |  11 +-
 kernel/bpf/syscall.c                               |   2 +
 kernel/bpf/verifier.c                              | 259 +++++++++++++++++----
 .../selftests/bpf/prog_tests/btf_map_keyless.c     |  59 +++++
 tools/testing/selftests/bpf/prog_tests/rhash.c     |   6 +
 .../testing/selftests/bpf/prog_tests/rhash_timer.c | 141 +++++++++++
 .../selftests/bpf/prog_tests/snprintf_btf.c        |  79 +++++++
 tools/testing/selftests/bpf/prog_tests/timer_mim.c |  29 ++-
 tools/testing/selftests/bpf/progs/iters.c          |  39 ++++
 tools/testing/selftests/bpf/progs/map_kptr_fail.c  |  37 +++
 .../selftests/bpf/progs/percpu_alloc_fail.c        |  59 +++++
 tools/testing/selftests/bpf/progs/preempt_lock.c   |  52 +++++
 .../testing/selftests/bpf/progs/raw_tp_null_fail.c |  53 +++++
 tools/testing/selftests/bpf/progs/rbtree_fail.c    |  84 +++++++
 tools/testing/selftests/bpf/progs/rcu_read_lock.c  |   6 +-
 .../testing/selftests/bpf/progs/refcounted_kptr.c  |  61 +++++
 .../selftests/bpf/progs/refcounted_kptr_fail.c     | 150 ++++++++++++
 tools/testing/selftests/bpf/progs/rhash.c          | 112 +++++++++
 tools/testing/selftests/bpf/progs/rhash_timer.c    |  98 ++++++++
 .../selftests/bpf/progs/snprintf_btf_void.c        |  24 ++
 .../selftests/bpf/progs/tailcall_callback.c        |  16 ++
 .../selftests/bpf/progs/task_local_data.bpf.h      |   3 +
 tools/testing/selftests/bpf/progs/test_bpf_nf.c    |   8 +-
 .../testing/selftests/bpf/progs/timer_mim_reject.c |  84 ++++++-
 .../bpf/progs/verifier_async_cb_context.c          |  98 ++++++++
 .../testing/selftests/bpf/progs/verifier_bounds.c  |  41 ++++
 .../selftests/bpf/progs/verifier_bpf_fastcall.c    | 110 +++++++++
 tools/testing/selftests/bpf/progs/verifier_cfg.c   |  14 ++
 .../selftests/bpf/progs/verifier_cgroup_storage.c  |  29 +++
 .../selftests/bpf/progs/verifier_global_ptr_args.c |  24 ++
 .../bpf/progs/verifier_iterating_callbacks.c       |  17 ++
 .../bpf/progs/verifier_jeq_infer_not_null.c        | 193 +++++++++++++++
 .../testing/selftests/bpf/progs/verifier_ld_ind.c  |  96 ++++++++
 .../selftests/bpf/progs/verifier_netfilter_ctx.c   |  78 +++++++
 .../selftests/bpf/progs/verifier_precision.c       | 100 ++++++++
 .../selftests/bpf/progs/verifier_scalar_ids.c      |  13 +-
 .../selftests/bpf/progs/verifier_spill_fill.c      |  40 ++++
 .../bpf/progs/verifier_subprog_precision.c         |  63 ++++-
 tools/testing/selftests/bpf/progs/verifier_zext.c  |  26 +++
 tools/testing/selftests/bpf/verifier/pseudo_func.c |  45 ++++
 58 files changed, 2555 insertions(+), 175 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/btf_map_keyless.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/rhash_timer.c
 create mode 100644 tools/testing/selftests/bpf/progs/rhash_timer.c
 create mode 100644 tools/testing/selftests/bpf/progs/snprintf_btf_void.c
 create mode 100644 tools/testing/selftests/bpf/verifier/pseudo_func.c
