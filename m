Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26B9022A7E4
	for <bpf@vger.kernel.org>; Sat,  7 Feb 2026 02:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770429900; cv=none; b=aUucFyz2BK6VT2+JHoJBwloSAYY5Qn038GXPZadPpb00cbsr16hpSI3QQFKOfriPAaJ38XI1XSXZPXUjwtOY6GIqZJIUpgoJYyUTRHaGHPh9pQg0Wt9WuxyqsHkC0/UVH7AfqQxGrIp2ZBSuWbU/MiFB9bQO+LQNzuHduLkueNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770429900; c=relaxed/simple;
	bh=USkIO0bfQqYxCwLmKw3DXy834I19hTdSxOFB40a16Jk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=S5EZIe9K1AuLPOecGimd21eyXPVJ8ACwqUfI51C61JyNQSpvmJTDUQTg0RggsF8MldP2Gj3btwqeq0Nbhq7Jihw0J/fmWOgesQwl85vRA7xkdAHxBdelY8jtN/maDZ9ApnPX4MY2+4O2QDLhCphgIjEsTHRyR3fSFsQ4msLnmvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hFeLEalC; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hFeLEalC"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-c551edc745eso1232981a12.2
        for <bpf@vger.kernel.org>; Fri, 06 Feb 2026 18:04:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770429899; x=1771034699; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0iMzAXf+dsgf5IYiXYKHsqceRPaGuZ8aFLEw1vja51g=;
        b=hFeLEalCxy2z2xh6etxi20TuPWfycOrmfYzYnpbVTA5m2wELgPvwYXG8W1wzYHcOwl
         EAu8lyDUfX3N0Je17uKZQ5JBgyWZ/R35FXqxu2gpU0pQE/SOL+62hxzq9AFiJh+4KM8C
         snfciyHU/Eprz1iPE/kCKvDYvyjonqqUEs0AYEXX2h7MdL5dtzq2vf4j524mNmBtSTCG
         4u9SIe8xdXd4OrIOhmF/OhcrnVNd5sJyJKyjLvMIQc3zQy2H4ALihaN12zJOqXoQLmDB
         1HYtwixu9PTR04iRwLeh0effSIJI5vVQutCWl9AHx8JQHuNZbRRKlbR5aHX67CBqy65k
         FNnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770429899; x=1771034699;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0iMzAXf+dsgf5IYiXYKHsqceRPaGuZ8aFLEw1vja51g=;
        b=xLDXpk6fsLvAAxujlXEkY5hJmR0CDTodtqVm6QG3JaDm6gqfRVMmzMhzDb/5z81evB
         LK07rhvxKf1SG8ANkrg0I6GNsG4FPKsPCE6hy2Ih51A5Iu9mu9vA8ciyl3cZ/fFmTOsX
         EAy3kTEeaI8BXKL9vZFxNYP76iN7nwW42o9KfpF8xBAr4y+VkflseZn7XlrITXP0wuJt
         R1ioe5U0vXVCQq52gTEV0iZj8FqY/RvCX99FNG3sAYEsphbLOrUptMEYQB5/VfQD43T5
         Nxowjj1vRojAEFkx9oTxG74Fx6s7t4hjCfK+OxM5gofneTBBUCVR2AvvLzoIUY4h/izG
         tU/Q==
X-Gm-Message-State: AOJu0YyqNZuXmdMRM3cOL++WkPjL1PWH1D9+TY9PlHYV/ntVNL/192Xs
	kDiDMshgr79l1RoOjyj/K+ixVmOxdYQ9teC3rjJlIpnwLt20JYGcJZBV
X-Gm-Gg: AZuq6aKC8Pu8JkqjOE2w8VlWk/t7swHKGT0VaMNNEE56vaYQgzVXkpp685/VEmkdVEC
	de8+Uj6auDQsOaeIhCqOtXC01xQ2KJjDo36HKy1nbu9fWu3HXoY3101I4KUF+lf2QXrKn83dBJi
	DMK5gZttR5+XkwBii2Na1MRY3mxt3ZosSAoQRGnRyNHKREGql/DIGC+ydesoUuU1pncVBWgGFgK
	REzQaDDKiM6BDTmI5QezUjG0v+7vvYqlwPoaPVxXW1DuozYaWpHn/dtAgPwkhKRq1RIgkC06iyG
	cZYwcTurIAqao6zJ0a2tyZWm3k56IqGtMXSbWk9x+ICXx++2mefOMtNku4HjCk9wKy8Choykq/F
	nGHtMQ+70q7tYC9WRPoQufBHPa5hlv6N++1UBMuMhAh9Vo04k7eThVvefpM0O2i1yRdjoJMhPAw
	7K2YMJP0RfQ1R0cS6MtBCrT7rP1G+/4fAr7vOe6KdKOQWGbLPT2j+993ZS5Oj5I8vP7JKgK15tG
	Ssw8dp7uAMwB0WmqqQLtZkg3Jyw4ocIsy2tJrMsJzvaSy4fsA==
X-Received: by 2002:a17:90b:4fc9:b0:340:ec8f:82d8 with SMTP id 98e67ed59e1d1-354b3c84d4dmr4728103a91.12.1770429899211;
        Fri, 06 Feb 2026 18:04:59 -0800 (PST)
Received: from localhost.localdomain ([2601:600:837f:c6b0:18cf:ab6c:cac0:3007])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-824418ccb2asm3419250b3a.58.2026.02.06.18.04.58
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 06 Feb 2026 18:04:58 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: torvalds@linux-foundation.org
Cc: bpf@vger.kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org
Subject: [GIT PULL] BPF changes for 7.0
Date: Fri,  6 Feb 2026 18:04:55 -0800
Message-ID: <20260207020456.36237-1-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Linus,

The following changes since commit c537e12daeecaecdcd322c56a5f70659d2de7bde:

  Merge tag 'bpf-fixes' of git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf (2026-01-13 21:21:13 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git tags/bpf-next-7.0

for you to fetch changes up to db975debcb8c4cd367a78811bc1ba84c83f854bd:

  Merge branch 'remove-task-and-cgroup-local-storage-percpu-counters' (2026-02-06 14:48:05 -0800)

----------------------------------------------------------------
There is a trivial conflict between ftrace and bpf-next trees:
https://lore.kernel.org/all/aYC09rYDOvkNNOaA@sirena.org.uk/

- Support associating BPF program with struct_ops (Amery Hung)

- Switch BPF local storage to rqspinlock and remove recursion
  detection counters which were causing false positives (Amery Hung)

- Fix live registers marking for indirect jumps (Anton Protopopov)

- Introduce execution context detection BPF helpers (Changwoo Min)

- Improve verifier precision for 32bit sign extension pattern
  (Cupertino Miranda)

- Optimize BTF type lookup by sorting vmlinux BTF and doing
  binary search (Donglin Peng)

- Allow states pruning for misc/invalid slots in iterator loops
  (Eduard Zingerman)

- In preparation for ASAN support in BPF arenas teach libbpf to
  move global BPF variables to the end of the region and enable
  arena kfuncs while holding locks (Emil Tsalapatis)

- Introduce support for implicit arguments in kfuncs and migrate a
  number of them to new API. This is a prerequisite for cgroup
  sub-schedulers in sched-ext (Ihor Solodrai)

- Fix incorrect copied_seq calculation in sockmap (Jiayuan Chen)

- Fix ORC stack unwind from kprobe_multi (Jiri Olsa)

- Speed up fentry attach by using single ftrace direct ops
  in BPF trampolines (Jiri Olsa)

- Require frozen map for calculating map hash (KP Singh)

- Fix lock entry creation in TAS fallback in rqspinlock
  (Kumar Kartikeya Dwivedi)

- Allow user space to select cpu in lookup/update operations on
  per-cpu array and hash maps (Leon Hwang)

- Make kfuncs return trusted pointers by default (Matt Bobrowski)

- Introduce "fsession" support where single BPF program is
  executed upon entry and exit from traced kernel function
  (Menglong Dong)

- Allow bpf_timer and bpf_wq use in all programs types
  (Mykyta Yatsenko, Andrii Nakryiko, Kumar Kartikeya Dwivedi,
   Alexei Starovoitov)

- Make KF_TRUSTED_ARGS the default for all kfuncs and clean up
  their definition across the tree (Puranjay Mohan)

- Allow BPF arena calls from non-sleepable context (Puranjay Mohan)

- Improve register id comparison logic in the verifier and extend
  linked registers with negative offsets (Puranjay Mohan)

- In preparation for BPF-OOM introduce kfuncs to access memcg events
  (Roman Gushchin)

- Use CFI compatible destructor kfunc type (Sami Tolvanen)

- Add bitwise tracking for BPF_END in the verifier (Tianci Cao)
      
- Add range tracking for BPF_DIV and BPF_MOD in the verifier
  (Yazhou Tang)

- Make BPF selftests work with 64k page size (Yonghong Song)

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
----------------------------------------------------------------
Alan Maguire (2):
      libbpf: Add debug messaging in dedup equivalence/identity matching
      selftests/bpf: Support when CONFIG_VXLAN=m

Alexei Starovoitov (51):
      Merge branch 'bpf-cpumap-improve-error-propagation-in-cpu_map_update_elem'
      Merge branch 'bpf-verifier-improvement-in-32bit-shift-sign-extension-pattern'
      Merge git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf after 6.19-rc1
      Merge branch 'bpf-optimize-recursion-detection-on-arm64'
      Merge branch 'mm-bpf-kfuncs-to-access-memcg-data'
      Merge branch 'allow-calling-kfuncs-from-raw_tp-programs'
      Merge branch 'remove-kf_sleepable-from-arena-kfuncs'
      Merge branch 'bpf-calls-to-bpf_loop-should-have-an-scc-and-accumulate-backedges'
      Merge branch 'bpf-unify-state-pruning-handling-of-invalid-misc-stack-slots'
      Merge branch 'bpf-make-kf_trusted_args-default'
      Merge branch 'memcg-accounting-for-bpf-arena'
      Merge branch 'bpf-verifier-allow-calling-arena-functions-when-holding-bpf-lock'
      Merge branch 'bpf-introduce-bpf_f_cpu-and-bpf_f_all_cpus-flags-for-percpu-maps'
      Merge branch 'bpf-selftests-fixes-for-gcc-bpf-16'
      Merge branch 'use-correct-destructor-kfunc-types'
      Merge branch 'fix-a-few-selftest-failure-due-to-64k-page'
      bpf: Recognize special arithmetic shift in the verifier
      selftests/bpf: Add tests for s>>=31 and s>>=63
      Merge branch 'bpf-recognize-special-arithmetic-shift-in-the-verifier'
      Merge branch 'properly-load-insn-array-values-with-offsets'
      Merge git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf after rc5
      Merge branch 'bpf-live-registers-computation-with-gotox'
      Merge branch 'bpf-fix-linked-register-tracking'
      Merge branch 'bpf-kernel-functions-with-kf_implicit_args'
      Merge branch 'bpf-add-range-tracking-for-bpf_div-and-bpf_mod'
      Merge branch 'bpf-fix-memory-access-flags-in-helper-prototypes'
      Merge branch 'bpf-x86-inline-bpf_get_current_task-for-x86_64'
      Merge branch 'bpf-support-bpf_get_func_arg-for-bpf_trace_raw_tp'
      Merge branch 'bpf-add-kfunc-bpf_strncasecmp'
      Merge branch 'bpf-fsession-support'
      Merge branch 'selftests-bpf-introduce-execution-context-detection-helpers'
      Merge branch 'selftests-bpf-migrate-a-few-bpftool-testing-scripts'
      Merge branch 'bpf-fix-fionread-and-copied_seq-issues'
      Merge branch 'bpf-fix-verifier_bug_if-to-account-for-bpf_call'
      Merge branch 'bpf-tail-calls-in-sleepable-programs'
      Merge branch 'bpf-unify-special-map-field-validation-in-verifier'
      Merge branch 'bpf-arm64-add-fsession-support'
      Merge branch 'bpf-verifier-improve-state-pruning-for-scalar-registers'
      Merge branch 'bpf-add-bpf_stream_print_stack-kfunc'
      bpf: Enable bpf_timer and bpf_wq in any context
      bpf: Introduce bpf_timer_cancel_async() kfunc
      selftests/bpf: Add a test to stress bpf_timer_start and map_delete race
      bpf: Tighten conditions when timer/wq can be called synchronously
      selftests/bpf: Add a testcase for deadlock avoidance
      bpf: Add a recursion check to prevent loops in bpf_timer
      selftests/bpf: Strengthen timer_start_deadlock test
      Merge branch 'bpf-add-bitwise-tracking-for-bpf_end'
      Merge branch 'bpf-improve-linked-register-tracking'
      Merge branch 'fix-for-bpf_wq-retry-loop-during-free'
      bpf: Prevent reentrance into call_rcu_tasks_trace()
      Merge branch 'fix-some-corner-cases-in-xskxceiver'

Alexis Lothoré (eBPF Foundation) (3):
      selftests/bpf: Add a few helpers for bpftool testing
      selftests/bpf: convert test_bpftool_metadata.sh into test_progs framework
      selftests/bpf: convert test_bpftool_map_access.sh into test_progs framework

Amery Hung (23):
      bpf: Allow verifier to fixup kernel module kfuncs
      bpf: Support associating BPF program with struct_ops
      libbpf: Add support for associating BPF program with struct_ops
      selftests/bpf: Test BPF_PROG_ASSOC_STRUCT_OPS command
      selftests/bpf: Test ambiguous associated struct_ops
      selftests/bpf: Test getting associated struct_ops in timer callback
      bpf: Select bpf_local_storage_map_bucket based on bpf_local_storage
      bpf: Convert bpf_selem_unlink_map to failable
      bpf: Convert bpf_selem_link_map to failable
      bpf: Convert bpf_selem_unlink to failable
      bpf: Change local_storage->lock and b->lock to rqspinlock
      bpf: Remove task local storage percpu counter
      bpf: Remove cgroup local storage percpu counter
      bpf: Remove unused percpu counter from bpf_local_storage_map_free
      bpf: Prepare for bpf_selem_unlink_nofail()
      bpf: Support lockless unlink when freeing map or local storage
      bpf: Switch to bpf_selem_unlink_nofail in bpf_local_storage_{map_free, destroy}
      selftests/bpf: Update sk_storage_omem_uncharge test
      selftests/bpf: Update task_local_storage/recursion test
      selftests/bpf: Update task_local_storage/task_storage_nodeadlock test
      selftests/bpf: Remove test_task_storage_map_stress_lookup
      selftests/bpf: Choose another percpu variable in bpf for btf_dump test
      selftests/bpf: Fix outdated test on storage->smap

Andrii Nakryiko (8):
      Merge branch 'support-associating-bpf-programs-with-struct_ops'
      Merge branch 'libbpf-move-arena-variables-out-of-the-zero-page'
      Merge branch 'resolve_btfids-support-for-btf-modifications'
      Merge branch 'improve-the-performance-of-btf-type-lookups-with-binary-search'
      Merge branch 'ftrace-bpf-use-single-direct-ops-for-bpf-trampolines'
      Merge branch 'x86-fgraph-bpf-fix-orc-stack-unwind-from-kprobe_multi'
      Merge branch 'bpf-avoid-locks-in-bpf_timer-and-bpf_wq'
      Merge branch 'bpf-fix-conditions-when-timer-wq-can-be-called'

Anton Protopopov (5):
      bpf: Return proper address for non-zero offsets in insn array
      bpf: Return EACCES for incorrect access to insn array
      selftests/bpf: Add tests for loading insn array values with offsets
      bpf: Properly mark live registers for indirect jumps
      selftests/bpf: Extend live regs tests with a test for gotox

Changwoo Min (3):
      selftests/bpf: Introduce execution context detection helpers
      selftests/bpf: Add tests for execution context helpers
      selftests/bpf: Make bpf get_preempt_count() work for v6.14+ kernels

Cupertino Miranda (2):
      bpf: verifier improvement in 32bit shift sign extension pattern
      selftests/bpf: add verifier sign extension bound computation tests.

Daniel Borkmann (1):
      bpf: Remove leftover accounting in htab_map_mem_usage after rqspinlock

Daniel Gomez (1):
      bpf: crypto: replace -EEXIST with -EBUSY

Donglin Peng (11):
      libbpf: Add BTF permutation support for type reordering
      selftests/bpf: Add test cases for btf__permute functionality
      tools/resolve_btfids: Support BTF sorting feature
      libbpf: Optimize type lookup with binary search for sorted BTF
      libbpf: Verify BTF sorting
      btf: Optimize type lookup with binary search
      btf: Verify BTF sorting
      bpf: Skip anonymous types in type lookup for performance
      bpf: Optimize the performance of find_bpffs_btf_enums
      btf: Refactor the code by calling str_is_empty
      resolve_btfids: Refactor the sort_btf_by_name function

Eduard Zingerman (4):
      bpf: bpf_scc_visit instance and backedges accumulation for bpf_loop()
      selftests/bpf: test cases for bpf_loop SCC and state graph backedges
      bpf: allow states pruning for misc/invalid slots in iterator loops
      selftests/bpf: iterator based loop and STACK_MISC states pruning

Emil Tsalapatis (12):
      selftests/bpf: Explicitly account for globals in verifier_arena_large
      bpf/verifier: Do not limit maximum direct offset into arena map
      libbpf: Turn relo_core->sym_off unsigned
      libbpf: Move arena globals to the end of the arena
      selftests/bpf: Add tests for the arena offset of globals
      bpf: Check active lock count in in_sleepable_context()
      bpf: Allow calls to arena functions while holding spinlocks
      selftests/bpf: add tests for arena kfuncs under lock
      bpf: Add bpf_stream_print_stack stack dumping kfunc
      selftests/bpf: Add selftests for bpf_stream_print_stack
      bpf: Allow BPF stream kfuncs while holding a lock
      selftests/bpf: Add selftests for stream functions under lock

Guillaume Gonnet (1):
      bpf: Fix tcx/netkit detach permissions when prog fd isn't given

Gyutae Bae (2):
      bpftool: Add 'prepend' option for tcx attach to insert at chain start
      selftests/bpf: Add perfbuf multi-producer benchmark

Ihor Solodrai (26):
      resolve_btfids: Rename object btf field to btf_path
      resolve_btfids: Factor out load_btf()
      resolve_btfids: Introduce enum btf_id_kind
      resolve_btfids: Always build with -Wall -Werror
      kbuild: Sync kconfig when PAHOLE_VERSION changes
      lib/Kconfig.debug: Set the minimum required pahole version to v1.22
      selftests/bpf: Run resolve_btfids only for relevant .test.o objects
      resolve_btfids: Change in-place update with raw binary output
      scripts/gen-btf.sh: Fix .btf.o generation when compiling for RISCV
      resolve_btfids: Implement --patch_btfids
      scripts/gen-btf.sh: Reduce log verbosity
      bpf: Refactor btf_kfunc_id_set_contains
      bpf: Introduce struct bpf_kfunc_meta
      bpf: Verifier support for KF_IMPLICIT_ARGS
      resolve_btfids: Introduce finalize_btf() step
      resolve_btfids: Support for KF_IMPLICIT_ARGS
      selftests/bpf: Add tests for KF_IMPLICIT_ARGS
      bpf: Migrate bpf_wq_set_callback_impl() to KF_IMPLICIT_ARGS
      HID: Use bpf_wq_set_callback kernel function
      bpf: Migrate bpf_task_work_schedule_* kfuncs to KF_IMPLICIT_ARGS
      bpf: Migrate bpf_stream_vprintk() to KF_IMPLICIT_ARGS
      selftests/bpf: Migrate struct_ops_assoc test to KF_IMPLICIT_ARGS
      bpf: Remove __prog kfunc arg annotation
      bpf,docs: Document KF_IMPLICIT_ARGS flag
      scripts/gen-btf.sh: Use CONFIG_SHELL for execution
      bpftool: Fix dependencies for static build

JP Kobryn (1):
      bpf: selftests: selftests for memcg stat kfuncs

Jiayuan Chen (3):
      bpf, sockmap: Fix incorrect copied_seq calculation
      bpf, sockmap: Fix FIONREAD for sockmap
      selftests/bpf: Add tests for FIONREAD and copied_seq

Jiri Olsa (20):
      arm64/ftrace,bpf: Fix partial regs after bpf_prog_run
      selftests/bpf: Add test for bpf_override_return helper
      ftrace,bpf: Remove FTRACE_OPS_FL_JMP ftrace_ops flag
      ftrace: Make alloc_and_copy_ftrace_hash direct friendly
      ftrace: Export some of hash related functions
      ftrace: Add update_ftrace_direct_add function
      ftrace: Add update_ftrace_direct_del function
      ftrace: Add update_ftrace_direct_mod function
      bpf: Add trampoline ip hash table
      ftrace: Factor ftrace_ops ops_func interface
      bpf,x86: Use single ftrace_ops for direct calls
      bpf: Allow sleepable programs to use tail calls
      selftests/bpf: Add test for sleepable program tailcalls
      x86/fgraph: Fix return_to_handler regs.rsp value
      x86/fgraph,bpf: Switch kprobe_multi program stack unwind to hw_regs path
      selftests/bpf: Fix kprobe multi stacktrace_ips test
      selftests/bpf: Add stacktrace ips test for kprobe/kretprobe
      selftests/bpf: Add stacktrace ips test for fentry/fexit
      selftests/bpf: Allow to benchmark trigger with stacktrace
      ftrace: Fix direct_functions leak in update_ftrace_direct_del

Jose E. Marchesi (2):
      bpf: adapt selftests to GCC 16 -Wunused-but-set-variable
      bpf: GCC requires function attributes before the declarator

KP Singh (2):
      bpf: Limit bpf program signature size
      bpf: Require frozen map for calculating map hash

Kery Qi (1):
      selftests/bpf: Fix resource leak in serial_test_wq on attach failure

Kohei Enju (2):
      bpf: cpumap: propagate underlying error in cpu_map_update_elem()
      selftests/bpf: add tests for attaching invalid fd

Kumar Kartikeya Dwivedi (3):
      rqspinlock: Fix TAS fallback lock entry creation
      bpf: Check for running wq callback when freeing bpf_async_cb
      bpf: Reset prog callback in bpf_async_cancel_and_free()

Kuniyuki Iwashima (2):
      bpf: Use sk_is_inet() and sk_is_unix() in __cgroup_bpf_run_filter_sock_addr().
      bpf: Don't check sk_fullsock() in bpf_skc_to_unix_sock().

Larysa Zaremba (2):
      selftests/xsk: properly handle batch ending in the middle of a packet
      selftests/xsk: fix number of Tx frags in invalid packet

Leon Hwang (11):
      bpf: Introduce BPF_F_CPU and BPF_F_ALL_CPUS flags
      bpf: Add BPF_F_CPU and BPF_F_ALL_CPUS flags support for percpu_array maps
      bpf: Add BPF_F_CPU and BPF_F_ALL_CPUS flags support for percpu_hash and lru_percpu_hash maps
      bpf: Copy map value using copy_map_value_long for percpu_cgroup_storage maps
      bpf: Add BPF_F_CPU and BPF_F_ALL_CPUS flags support for percpu_cgroup_storage maps
      libbpf: Add BPF_F_CPU and BPF_F_ALL_CPUS flags support for percpu maps
      selftests/bpf: Add cases to test BPF_F_CPU and BPF_F_ALL_CPUS flags
      selftests/bpf: Harden cpu flags test for lru_percpu_hash map
      bpf: Add bpf_jit_supports_fsession()
      bpf, arm64: Add fsession support
      selftests/bpf: Enable get_func_args and get_func_ip tests on arm64

Luis Gerhorst (2):
      bpf: Fix verifier_bug_if to account for BPF_CALL
      bpf: Test nospec after dead stack write in helper

Martin KaFai Lau (2):
      Merge branch 'bpf-misc-changes-around-af_unix'
      Merge branch 'remove-task-and-cgroup-local-storage-percpu-counters'

Matt Bobrowski (9):
      bpf: annotate file argument as __nullable in bpf_lsm_mmap_file
      selftests/bpf: add test case for BPF LSM hook bpf_lsm_mmap_file
      bpf: return PTR_TO_BTF_ID | PTR_TRUSTED from BPF kfuncs by default
      bpf: drop KF_ACQUIRE flag on BPF kfunc bpf_get_root_mem_cgroup()
      selftests/bpf: assert BPF kfunc default trusted pointer semantics
      selftests/bpf: update verifier test for default trusted pointer semantics
      bpf: Revert "bpf: drop KF_ACQUIRE flag on BPF kfunc bpf_get_root_mem_cgroup()"
      bpf: add new BPF_CGROUP_ITER_CHILDREN control option
      selftests/bpf: cover BPF_CGROUP_ITER_CHILDREN control option

Menglong Dong (17):
      bpf, x86: inline bpf_get_current_task() for x86_64
      selftests/bpf: test the jited inline of bpf_get_current_task
      bpf: support bpf_get_func_arg() for BPF_TRACE_RAW_TP
      selftests/bpf: test bpf_get_func_arg() for tp_btf
      bpf: add fsession support
      bpf: use the least significant byte for the nr_args in trampoline
      bpf: change prototype of bpf_session_{cookie,is_return}
      bpf: support fsession for bpf_session_is_return
      bpf: support fsession for bpf_session_cookie
      bpf,x86: introduce emit_store_stack_imm64() for trampoline
      bpf,x86: add fsession support for x86_64
      libbpf: add fsession support
      bpftool: add fsession support
      selftests/bpf: add testcases for fsession
      selftests/bpf: test bpf_get_func_* for fsession
      selftests/bpf: add testcases for fsession cookie
      selftests/bpf: test fsession mixed with fentry and fexit

Mykyta Yatsenko (15):
      bpf: Consistently use reg_state() for register access in the verifier
      bpf: Add __force annotations to silence sparse warnings
      bpf: Factor out timer deletion helper
      bpf: Remove unnecessary arguments from bpf_async_set_callback()
      bpf: Introduce lock-free bpf_async_update_prog_callback()
      bpf: Simplify bpf_timer_cancel()
      selftests/bpf: Remove xxd util dependency
      bpf: Introduce struct bpf_map_desc in verifier
      bpf: Consolidate special map field validation in verifier
      bpf: Add verifier support for bpf_timer argument in kfuncs
      selftests/bpf: Refactor timer selftests
      selftests/bpf: Add stress test for timer async cancel
      selftests/bpf: Verify bpf_timer_cancel_async works
      selftests/bpf: Add timer stress test in NMI context
      selftests/bpf: Removed obsolete tests

Nathan Chancellor (1):
      scripts/gen-btf.sh: Ensure initial object in gen_btf_o is ELF with correct endianness

Paul Chaignon (2):
      bpf: Fix bpf_xdp_store_bytes proto for read-only arg
      selftests/bpf: Test access from RO map from xdp_store_bytes

Puranjay Mohan (34):
      bpf: move recursion detection logic to helpers
      bpf: arm64: Optimize recursion detection by not using atomics
      bpf: arm64: Fix sparse warnings
      bpf: allow calling kfuncs from raw_tp programs
      selftests: bpf: fix tests with raw_tp calling kfuncs
      bpf: arena: populate vm_area without allocating memory
      bpf: arena: use kmalloc_nolock() in place of kvcalloc()
      bpf: arena: make arena kfuncs any context safe
      selftests: bpf: test non-sleepable arena allocations
      selftests/bpf: Fix verifier_arena_large/big_alloc3 test
      selftests/bpf: veristat: fix printing order in output_stats()
      bpf: Make KF_TRUSTED_ARGS the default for all kfuncs
      bpf: Remove redundant KF_TRUSTED_ARGS flag from all kfuncs
      bpf: net: netfilter: drop dead NULL checks
      bpf: xfrm: drop dead NULL check in bpf_xdp_get_xfrm_state()
      HID: bpf: drop dead NULL checks in kfuncs
      selftests: bpf: Update kfunc_param_nullable test for new error message
      selftests: bpf: Update failure message for rbtree_fail
      selftests: bpf: fix test_kfunc_dynptr_param
      selftests: bpf: fix cgroup_hierarchical_stats
      selftests: bpf: Fix test_bpf_nf for trusted args becoming default
      bpf: syscall: Introduce memcg enter/exit helpers
      bpf: arena: Reintroduce memcg accounting
      bpf: Replace __opt annotation with __nullable for kfuncs
      bpf: Preserve id of register in sync_linked_regs()
      selftests: bpf: Add test for multiple syncs from linked register
      bpf: verifier: Make sync_linked_regs() scratch registers
      bpf: Let the verifier assign ids on stack fills
      bpf: Clear singular ids for scalars in is_state_visited()
      bpf: Relax maybe_widen_reg() constraints
      bpf: Relax scalar id equivalence for state pruning
      selftests/bpf: Add a test for ids=0 to verifier_scalar_ids test
      bpf: Support negative offsets, BPF_SUB, and alu32 for linked register tracking
      selftests/bpf: Add tests for improved linked register tracking

Qiliang Yuan (1):
      bpf/verifier: Optimize ID mapping reset in states_equal

Roman Gushchin (6):
      mm: declare memcg_page_state_output() in memcontrol.h
      mm: introduce BPF kfuncs to deal with memcg pointers
      mm: introduce bpf_get_root_mem_cgroup() BPF kfunc
      mm: introduce BPF kfuncs to access memcg statistics and events
      MAINTAINERS: add an entry for MM BPF extensions
      mm: drop mem_cgroup_usage() declaration from memcontrol.h

Sami Tolvanen (4):
      bpf: crypto: Use the correct destructor kfunc type
      bpf: net_sched: Use the correct destructor kfunc type
      selftests/bpf: Use the correct destructor kfunc type
      bpf, btf: Enforce destructor kfunc type with CFI

Song Chen (1):
      bpf: Remove an unused parameter in check_func_proto

SungRock Jung (1):
      bpf: Update BPF_PROG_RUN documentation

T.J. Mercier (1):
      bpf: Fix bpf_seq_read docs for increased buffer size

Thorsten Blum (1):
      bpf: Replace snprintf("%s") with strscpy

Tianci Cao (2):
      bpf: Add bitwise tracking for BPF_END
      selftests/bpf: Add tests for BPF_END bitwise tracking

Tim Bird (1):
      bpf: Add SPDX license identifiers to a few files

Uros Bizjak (1):
      x86/bpf: Avoid emitting LOCK prefix for XCHG atomic ops

Varun R Mallya (1):
      libbpf: Fix OOB read in btf_dump_get_bitfield_value

WanLi Niu (1):
      bpftool: Make skeleton C++ compatible with explicit casts

Yazhou Tang (2):
      bpf: Add range tracking for BPF_DIV and BPF_MOD
      selftests/bpf: Add tests for BPF_DIV and BPF_MOD range tracking

Yonghong Song (6):
      selftests/bpf: Fix dmabuf_iter/lots_of_buffers failure with 64K page
      selftests/bpf: Fix sk_bypass_prot_mem failure with 64K page
      selftests/bpf: Fix verifier_arena_globals1 failure with 64K page
      selftests/bpf: Fix map_kptr test failure
      selftests/bpf: Fix task_local_data failure with 64K page
      selftests/bpf: Fix xdp_pull_data failure with 64K page

Yuzuki Ishiyama (2):
      bpf: add bpf_strncasecmp kfunc
      selftests/bpf: Test kfunc bpf_strncasecmp

Zesen Liu (2):
      bpf: Fix memory access flags in helper prototypes
      bpf: Require ARG_PTR_TO_MEM with memory flag

 Documentation/bpf/bpf_prog_run.rst                 |    3 +-
 Documentation/bpf/kfuncs.rst                       |  260 ++--
 Documentation/process/changes.rst                  |    4 +-
 Documentation/scheduler/sched-ext.rst              |    1 -
 MAINTAINERS                                        |   11 +
 Makefile                                           |   15 +-
 arch/arm64/net/bpf_jit_comp.c                      |   75 +-
 arch/x86/Kconfig                                   |    1 +
 arch/x86/include/asm/ftrace.h                      |    2 +-
 arch/x86/kernel/ftrace_64.S                        |    5 +-
 arch/x86/net/bpf_jit_comp.c                        |   88 +-
 drivers/hid/bpf/hid_bpf_dispatch.c                 |    5 +-
 drivers/hid/bpf/progs/hid_bpf_helpers.h            |    8 +-
 fs/bpf_fs_kfuncs.c                                 |   23 +-
 fs/verity/measure.c                                |    2 +-
 include/asm-generic/rqspinlock.h                   |    2 +-
 include/linux/bpf-cgroup.h                         |    4 +-
 include/linux/bpf.h                                |  178 ++-
 include/linux/bpf_local_storage.h                  |   29 +-
 include/linux/bpf_mprog.h                          |   10 +
 include/linux/bpf_verifier.h                       |   14 +-
 include/linux/btf.h                                |    9 +-
 include/linux/filter.h                             |    1 +
 include/linux/ftrace.h                             |   31 +-
 include/linux/ftrace_regs.h                        |   25 +
 include/linux/memcontrol.h                         |   19 +
 include/linux/skmsg.h                              |   70 +-
 include/linux/tnum.h                               |    5 +
 include/uapi/linux/bpf.h                           |   28 +
 init/Kconfig                                       |    2 +-
 kernel/bpf/Makefile                                |   12 +-
 kernel/bpf/arena.c                                 |  405 +++++-
 kernel/bpf/arraymap.c                              |   29 +-
 kernel/bpf/bpf_cgrp_storage.c                      |   62 +-
 kernel/bpf/bpf_inode_storage.c                     |    6 +-
 kernel/bpf/bpf_insn_array.c                        |    4 +-
 kernel/bpf/bpf_iter.c                              |    2 +-
 kernel/bpf/bpf_local_storage.c                     |  408 ++++--
 kernel/bpf/bpf_lsm.c                               |    5 +-
 kernel/bpf/bpf_lsm_proto.c                         |   19 +
 kernel/bpf/bpf_struct_ops.c                        |   88 ++
 kernel/bpf/bpf_task_storage.c                      |  154 +-
 kernel/bpf/btf.c                                   |  228 ++-
 kernel/bpf/cgroup.c                                |    6 +-
 kernel/bpf/cgroup_iter.c                           |   26 +-
 kernel/bpf/core.c                                  |   15 +-
 kernel/bpf/cpumap.c                                |   21 +-
 kernel/bpf/cpumask.c                               |    2 +-
 kernel/bpf/crypto.c                                |   10 +-
 kernel/bpf/hashtab.c                               |  105 +-
 kernel/bpf/helpers.c                               |  698 +++++----
 kernel/bpf/inode.c                                 |   42 +-
 kernel/bpf/local_storage.c                         |   27 +-
 kernel/bpf/map_iter.c                              |    2 +-
 kernel/bpf/offload.c                               |   12 +-
 kernel/bpf/range_tree.c                            |    5 +-
 kernel/bpf/ringbuf.c                               |    1 +
 kernel/bpf/rqspinlock.c                            |    7 +-
 kernel/bpf/stream.c                                |   24 +-
 kernel/bpf/syscall.c                               |  173 ++-
 kernel/bpf/tnum.c                                  |   16 +
 kernel/bpf/token.c                                 |    1 +
 kernel/bpf/trampoline.c                            |  320 ++++-
 kernel/bpf/verifier.c                              | 1487 +++++++++++++++-----
 kernel/sched/ext.c                                 |    8 +-
 kernel/trace/Kconfig                               |    3 +
 kernel/trace/bpf_trace.c                           |   84 +-
 kernel/trace/ftrace.c                              |  407 +++++-
 lib/Kconfig.debug                                  |   13 +-
 mm/Makefile                                        |    3 +
 mm/bpf_memcontrol.c                                |  193 +++
 mm/memcontrol-v1.h                                 |    1 -
 mm/memcontrol.c                                    |   16 +
 net/bpf/test_run.c                                 |    1 +
 net/core/bpf_sk_storage.c                          |   21 +-
 net/core/filter.c                                  |   34 +-
 net/core/skmsg.c                                   |   30 +-
 net/core/xdp.c                                     |    2 +-
 net/ipv4/tcp_bpf.c                                 |   25 +-
 net/ipv4/udp_bpf.c                                 |   23 +-
 net/netfilter/nf_conntrack_bpf.c                   |   22 +-
 net/netfilter/nf_flow_table_bpf.c                  |    2 +-
 net/netfilter/nf_nat_bpf.c                         |    2 +-
 net/sched/bpf_qdisc.c                              |   20 +-
 net/xfrm/xfrm_state_bpf.c                          |    2 +-
 scripts/Makefile.btf                               |   21 +-
 scripts/Makefile.modfinal                          |    5 +-
 scripts/Makefile.vmlinux                           |    2 +-
 scripts/gen-btf.sh                                 |  147 ++
 scripts/link-vmlinux.sh                            |   43 +-
 tools/bpf/bpftool/Documentation/bpftool-net.rst    |   30 +-
 tools/bpf/bpftool/Makefile                         |    4 +-
 tools/bpf/bpftool/bash-completion/bpftool          |    9 +-
 tools/bpf/bpftool/common.c                         |    1 +
 tools/bpf/bpftool/gen.c                            |    8 +-
 tools/bpf/bpftool/net.c                            |   31 +-
 tools/bpf/resolve_btfids/Makefile                  |    3 +-
 tools/bpf/resolve_btfids/main.c                    |  954 +++++++++++--
 tools/include/uapi/linux/bpf.h                     |   28 +
 tools/lib/bpf/bpf.c                                |   20 +
 tools/lib/bpf/bpf.h                                |   29 +
 tools/lib/bpf/bpf_helpers.h                        |    6 +-
 tools/lib/bpf/btf.c                                |  305 +++-
 tools/lib/bpf/btf.h                                |   42 +
 tools/lib/bpf/btf_dump.c                           |    9 +
 tools/lib/bpf/libbpf.c                             |   95 +-
 tools/lib/bpf/libbpf.h                             |   37 +-
 tools/lib/bpf/libbpf.map                           |    3 +
 tools/sched_ext/README.md                          |    1 -
 tools/testing/selftests/bpf/.gitignore             |    4 +-
 tools/testing/selftests/bpf/DENYLIST.s390x         |    1 +
 tools/testing/selftests/bpf/Makefile               |   26 +-
 tools/testing/selftests/bpf/bench.c                |    4 +
 tools/testing/selftests/bpf/bench.h                |    1 +
 tools/testing/selftests/bpf/benchs/bench_trigger.c |    1 +
 .../selftests/bpf/benchs/run_bench_ringbufs.sh     |    5 +
 tools/testing/selftests/bpf/bpf_experimental.h     |   85 +-
 tools/testing/selftests/bpf/bpf_kfuncs.h           |    3 -
 tools/testing/selftests/bpf/bpftool_helpers.c      |   74 +
 tools/testing/selftests/bpf/bpftool_helpers.h      |   11 +
 tools/testing/selftests/bpf/cgroup_iter_memcg.h    |   18 +
 .../selftests/bpf/map_tests/task_storage_map.c     |  128 --
 .../testing/selftests/bpf/prog_tests/arena_list.c  |   20 +-
 tools/testing/selftests/bpf/prog_tests/bpf_gotox.c |  208 +++
 tools/testing/selftests/bpf/prog_tests/bpf_nf.c    |    5 +-
 .../selftests/bpf/prog_tests/bpftool_maps_access.c |  371 +++++
 .../selftests/bpf/prog_tests/bpftool_metadata.c    |  144 ++
 tools/testing/selftests/bpf/prog_tests/btf_dump.c  |    4 +-
 .../testing/selftests/bpf/prog_tests/btf_permute.c |  244 ++++
 .../testing/selftests/bpf/prog_tests/cgroup_iter.c |   12 +
 .../selftests/bpf/prog_tests/cgroup_iter_memcg.c   |  223 +++
 .../testing/selftests/bpf/prog_tests/dmabuf_iter.c |    2 +-
 tools/testing/selftests/bpf/prog_tests/exe_ctx.c   |   59 +
 .../selftests/bpf/prog_tests/fsession_test.c       |  140 ++
 .../selftests/bpf/prog_tests/get_func_args_test.c  |    4 +
 .../selftests/bpf/prog_tests/get_func_ip_test.c    |    2 +
 tools/testing/selftests/bpf/prog_tests/iters.c     |    8 +-
 .../selftests/bpf/prog_tests/kfunc_implicit_args.c |   10 +
 .../selftests/bpf/prog_tests/kprobe_multi_test.c   |   44 +
 tools/testing/selftests/bpf/prog_tests/map_kptr.c  |   23 +
 .../selftests/bpf/prog_tests/percpu_alloc.c        |  335 +++++
 .../selftests/bpf/prog_tests/resolve_btfids.c      |    4 +-
 .../selftests/bpf/prog_tests/sk_bypass_prot_mem.c  |    7 +-
 .../selftests/bpf/prog_tests/sockmap_basic.c       |  294 +++-
 .../selftests/bpf/prog_tests/stacktrace_ips.c      |  120 +-
 .../selftests/bpf/prog_tests/string_kfuncs.c       |    1 +
 tools/testing/selftests/bpf/prog_tests/tailcalls.c |   74 +
 .../selftests/bpf/prog_tests/task_local_data.h     |    4 +-
 .../selftests/bpf/prog_tests/task_local_storage.c  |   10 +-
 .../bpf/prog_tests/test_struct_ops_assoc.c         |  191 +++
 .../bpf/prog_tests/test_task_local_data.c          |    2 +-
 tools/testing/selftests/bpf/prog_tests/test_xsk.c  |    4 +-
 tools/testing/selftests/bpf/prog_tests/timer.c     |  250 +++-
 .../bpf/prog_tests/timer_start_deadlock.c          |   33 +
 .../bpf/prog_tests/timer_start_delete_race.c       |  137 ++
 .../selftests/bpf/prog_tests/tracing_failure.c     |    2 +-
 tools/testing/selftests/bpf/prog_tests/verifier.c  |   10 +
 tools/testing/selftests/bpf/prog_tests/wq.c        |    5 +-
 .../selftests/bpf/prog_tests/xdp_cpumap_attach.c   |   19 +-
 .../selftests/bpf/prog_tests/xdp_pull_data.c       |   16 +-
 tools/testing/selftests/bpf/progs/arena_list.c     |   11 +
 .../bpf/progs/cgroup_hierarchical_stats.c          |    6 +-
 .../selftests/bpf/progs/cgroup_iter_memcg.c        |   39 +
 .../selftests/bpf/progs/compute_live_registers.c   |   41 +
 .../testing/selftests/bpf/progs/cpumask_failure.c  |    2 +-
 tools/testing/selftests/bpf/progs/dynptr_fail.c    |    2 +-
 tools/testing/selftests/bpf/progs/file_reader.c    |    2 +-
 tools/testing/selftests/bpf/progs/free_timer.c     |   10 +
 tools/testing/selftests/bpf/progs/fsession_test.c  |  179 +++
 .../selftests/bpf/progs/get_func_args_test.c       |   84 +-
 .../testing/selftests/bpf/progs/get_func_ip_test.c |   23 +
 tools/testing/selftests/bpf/progs/iters.c          |  140 ++
 tools/testing/selftests/bpf/progs/iters_css.c      |    9 +-
 .../selftests/bpf/progs/kfunc_implicit_args.c      |   41 +
 .../selftests/bpf/progs/kprobe_multi_override.c    |   15 +
 .../bpf/progs/kprobe_multi_session_cookie.c        |   15 +-
 tools/testing/selftests/bpf/progs/local_storage.c  |   19 +-
 tools/testing/selftests/bpf/progs/map_kptr.c       |   18 +
 tools/testing/selftests/bpf/progs/map_kptr_fail.c  |    4 +-
 .../selftests/bpf/progs/percpu_alloc_array.c       |   32 +
 tools/testing/selftests/bpf/progs/rbtree_fail.c    |    2 +-
 tools/testing/selftests/bpf/progs/rcu_read_lock.c  |   10 +
 .../bpf/progs/read_bpf_task_storage_busy.c         |   38 -
 .../selftests/bpf/progs/sk_storage_omem_uncharge.c |   12 +-
 tools/testing/selftests/bpf/progs/stacktrace_ips.c |   27 +
 tools/testing/selftests/bpf/progs/stream.c         |   53 +
 tools/testing/selftests/bpf/progs/stream_fail.c    |    6 +-
 .../selftests/bpf/progs/string_kfuncs_failure1.c   |    6 +
 .../selftests/bpf/progs/string_kfuncs_failure2.c   |    1 +
 .../selftests/bpf/progs/string_kfuncs_success.c    |    7 +
 .../testing/selftests/bpf/progs/struct_ops_assoc.c |  105 ++
 .../bpf/progs/struct_ops_assoc_in_timer.c          |   77 +
 .../selftests/bpf/progs/struct_ops_assoc_reuse.c   |   75 +
 .../struct_ops_kptr_return_fail__wrong_type.c      |    2 +-
 .../selftests/bpf/progs/tailcall_sleepable.c       |   43 +
 .../selftests/bpf/progs/task_local_data.bpf.h      |    2 +-
 .../selftests/bpf/progs/task_ls_recursion.c        |   14 +-
 .../selftests/bpf/progs/task_storage_nodeadlock.c  |    7 +-
 tools/testing/selftests/bpf/progs/task_work.c      |    7 +-
 tools/testing/selftests/bpf/progs/task_work_fail.c |    8 +-
 .../testing/selftests/bpf/progs/task_work_stress.c |    4 +-
 tools/testing/selftests/bpf/progs/test_bpf_nf.c    |    7 -
 .../testing/selftests/bpf/progs/test_bpf_nf_fail.c |   57 +
 .../selftests/bpf/progs/test_btf_decl_tag.c        |    2 +-
 tools/testing/selftests/bpf/progs/test_ctx.c       |   48 +
 .../selftests/bpf/progs/test_kfunc_dynptr_param.c  |    5 +-
 .../bpf/progs/test_kfunc_param_nullable.c          |    2 +-
 .../selftests/bpf/progs/test_sockmap_pass_prog.c   |   14 +
 tools/testing/selftests/bpf/progs/test_tc_tunnel.c |   21 +-
 tools/testing/selftests/bpf/progs/timer.c          |  118 +-
 .../selftests/bpf/progs/timer_start_deadlock.c     |   70 +
 .../selftests/bpf/progs/timer_start_delete_race.c  |   66 +
 tools/testing/selftests/bpf/progs/trigger_bench.c  |   46 +-
 .../selftests/bpf/progs/uprobe_multi_session.c     |    7 +-
 .../bpf/progs/uprobe_multi_session_cookie.c        |   15 +-
 .../bpf/progs/uprobe_multi_session_recursive.c     |   11 +-
 tools/testing/selftests/bpf/progs/verifier_arena.c |  223 +++
 .../selftests/bpf/progs/verifier_arena_globals1.c  |   87 ++
 .../selftests/bpf/progs/verifier_arena_globals2.c  |   49 +
 .../selftests/bpf/progs/verifier_arena_large.c     |   50 +-
 .../bpf/progs/verifier_async_cb_context.c          |    8 +-
 .../testing/selftests/bpf/progs/verifier_bounds.c  |    2 +-
 tools/testing/selftests/bpf/progs/verifier_bswap.c |   43 +
 .../bpf/progs/verifier_default_trusted_ptr.c       |   29 +
 .../selftests/bpf/progs/verifier_div_mod_bounds.c  | 1149 +++++++++++++++
 .../selftests/bpf/progs/verifier_global_ptr_args.c |    2 +-
 .../bpf/progs/verifier_helper_restricted.c         |  111 --
 .../selftests/bpf/progs/verifier_jit_inline.c      |   20 +
 .../bpf/progs/verifier_kfunc_prog_types.c          |    6 +-
 .../selftests/bpf/progs/verifier_linked_scalars.c  |  336 ++++-
 tools/testing/selftests/bpf/progs/verifier_lsm.c   |   31 +-
 .../selftests/bpf/progs/verifier_scalar_ids.c      |   53 +-
 .../testing/selftests/bpf/progs/verifier_subreg.c  |  153 ++
 .../testing/selftests/bpf/progs/verifier_unpriv.c  |   22 +
 .../bpf/progs/verifier_value_illegal_alu.c         |    7 +-
 tools/testing/selftests/bpf/progs/verifier_xdp.c   |   35 +
 tools/testing/selftests/bpf/progs/wq_failures.c    |    4 +-
 tools/testing/selftests/bpf/test_bpftool_map.sh    |  398 ------
 .../testing/selftests/bpf/test_bpftool_metadata.sh |   85 --
 .../selftests/bpf/test_kmods/bpf_testmod-events.h  |   10 +
 .../testing/selftests/bpf/test_kmods/bpf_testmod.c |  122 +-
 .../selftests/bpf/test_kmods/bpf_testmod_kfunc.h   |   12 +-
 tools/testing/selftests/bpf/trace_helpers.h        |   12 +
 tools/testing/selftests/bpf/verifier/calls.c       |    2 +-
 .../selftests/bpf/verifier/direct_value_access.c   |    4 +-
 tools/testing/selftests/bpf/verifier/precise.c     |    4 +-
 tools/testing/selftests/bpf/veristat.c             |    2 +-
 .../testing/selftests/hid/progs/hid_bpf_helpers.h  |    8 +-
 248 files changed, 13312 insertions(+), 2953 deletions(-)
 create mode 100644 kernel/bpf/bpf_lsm_proto.c
 create mode 100644 mm/bpf_memcontrol.c
 create mode 100755 scripts/gen-btf.sh
 create mode 100644 tools/testing/selftests/bpf/bpftool_helpers.c
 create mode 100644 tools/testing/selftests/bpf/bpftool_helpers.h
 create mode 100644 tools/testing/selftests/bpf/cgroup_iter_memcg.h
 delete mode 100644 tools/testing/selftests/bpf/map_tests/task_storage_map.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/bpftool_maps_access.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/bpftool_metadata.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/btf_permute.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/cgroup_iter_memcg.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/exe_ctx.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/fsession_test.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/kfunc_implicit_args.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/test_struct_ops_assoc.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/timer_start_deadlock.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/timer_start_delete_race.c
 create mode 100644 tools/testing/selftests/bpf/progs/cgroup_iter_memcg.c
 create mode 100644 tools/testing/selftests/bpf/progs/fsession_test.c
 create mode 100644 tools/testing/selftests/bpf/progs/kfunc_implicit_args.c
 delete mode 100644 tools/testing/selftests/bpf/progs/read_bpf_task_storage_busy.c
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_assoc.c
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_assoc_in_timer.c
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_assoc_reuse.c
 create mode 100644 tools/testing/selftests/bpf/progs/tailcall_sleepable.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_ctx.c
 create mode 100644 tools/testing/selftests/bpf/progs/timer_start_deadlock.c
 create mode 100644 tools/testing/selftests/bpf/progs/timer_start_delete_race.c
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_arena_globals1.c
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_arena_globals2.c
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_default_trusted_ptr.c
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_div_mod_bounds.c
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_jit_inline.c
 delete mode 100755 tools/testing/selftests/bpf/test_bpftool_map.sh
 delete mode 100755 tools/testing/selftests/bpf/test_bpftool_metadata.sh
