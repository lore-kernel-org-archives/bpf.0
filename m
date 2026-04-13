Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 456E63806AC
	for <bpf@vger.kernel.org>; Mon, 13 Apr 2026 17:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776102458; cv=none; b=QFFV6ub0DOPD8yDk4MDnldmMuLYddRVIm8lxPCmA/B2pZ1jk+wmtAz6kPWMk0MWJZ3w0ke3z/tWVGaJj3rBd523enpM6vWAtuK7J+9D5+HEV24nDWgLb4boDFBky9ctohlsc28Uja0gG3kgVaENOBMncAnP4iNFE6eb+IgViepE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776102458; c=relaxed/simple;
	bh=WYItnxyAdG1DAILRleXnBOrEZO2MOkvLRn72vSIg/Rw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=NySKGNUNMT4Q36Yx2O0moBFxkOh8YLoqUgeXdRFSctSVskB8gqxEO3qBZHgZ30X5UEF9P1eZP/zkZEw7S7GbUAb3uPnPuKSMiKM2Mz3We6mbr9HADDNA83NOC0qivVYHtdvQIPEVm6dfJhfOBZ1fbDg3JL1pWg3nT9dtYp4lPBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m4Q3s/4A; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m4Q3s/4A"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-827270d50d4so4316948b3a.3
        for <bpf@vger.kernel.org>; Mon, 13 Apr 2026 10:47:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776102455; x=1776707255; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5U3zLcBlOFy62T2rGG7FmmNCG0tnEIUF7FapnvpR6+E=;
        b=m4Q3s/4AYV2kOyZ2tIUHP5x14X+daIMI21ByiNNLuSJgYiqU9Xlp5LJOezWMmhTbL0
         l1JpwKsDsu/e0hwKbvjHOrgJ6eaJIdklkBE6n3RoHVmcgbZ9hv6HePUjb2QSAbfuTyPW
         WzCrYG96Th7mq0L+5AAvn4HEfwkDdLLplJL3TGfN1WUs2RmUUZDuA5lDibIBu/waU/6I
         KaG6DVVq280lg65/6zijezUiGXuIToAB8kDcvtaxEglT5Gja5U9qkF0fo9qth0neLu0n
         7y8FDDYfk7WA1PiaB+gmh/QVyRlOGgeS+L0dNYgNv849xRbh0Dzc/SGHV/6XQldkjo0H
         uLNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776102455; x=1776707255;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5U3zLcBlOFy62T2rGG7FmmNCG0tnEIUF7FapnvpR6+E=;
        b=pwAAnHL7nA/if6mcrNXmdeaJHA441PPQ3v87grwwwygfq/QvPB8m11xfbCN5lRdAq5
         NAFKi3THhGxOMpjTPjIGIgDbDSimnRhzLRqBvPmgLYWXazlpBckrx9Tjm9hBGnS/SOQf
         O60QNSUvc1nrYO6MqXvTcjXsdbNBodQV0jxWmlr0d0wGpO3Da6kQLDeas1TfzD4aenYd
         mUZ6pUE0tggrs5G66noVd+lcbOMyonScvXFBy1EcVtVFNwVVWJRVZwon9+9Y4VRuaUA9
         ImHGRurlp0y77rfJI7YfzlTUs2W4dzFcT1aWmM9kYeage896hR2wcceBy2Px3XEHp4Qb
         rcGw==
X-Gm-Message-State: AOJu0YxEqFzLY3nx41F5Shj3XJFdIfcXjWRyqpUMtpVQg3rAvfBxEu4L
	iTUqHnWwcB157rDqmwW1rovM+C+rm22rg5FT7DTmebVPw+f1JsNnyCgR
X-Gm-Gg: AeBDiesWb7jrP08ggLcSMPeNoH89JeTyDsCBPpklOWTZNRb+YsvDl3Ni1EuJx62N+Ea
	rDckBXGue4j4WWYSEeFjICPxtfhzcdAoyRw6Hnit44dtff+AF1gOmm1Oy1kFkVG8rxLXDMGCv8C
	g4Z2A8ejl8azj5WYV1vIrCNOLMFhNxUx4pewePnI/EdW7ZeHGEtTcXmtUVlgKa04orzeAWFUApe
	Z40oTLaXjd0ah+u4vhJ4+WyFCUkK8iLH1HTGYYZ8KHSrzn/+fAWlo/qjEa/kedU6WVw05Wx28/T
	/1ISGxYC3ja8kmHD7I0s7r1X4jfyONgLlxPMsujsEu1F5DPiP7i2xX3pXFL/uFOun0u7b1QN++h
	nfkbKFKMq06oC6pZf2p/GmbbwBzwY8Xie9WkkQUH9teVkFAOAhHQK7R1FOlOuphCIoO0Txja9lV
	dbfARpUubErbw3dDGEKONjvErPWHhWubNIJ+Y5flG4O7nhpTzVwE/u4LXt1rGL6B+EXFDIX7Ul2
	Ul5Oc4Di6HRHloW4jgWHmQR+3GV3XzvHSdaMpvpf3VJKrWL6EhpMvI6W65sYw==
X-Received: by 2002:aa7:88cc:0:b0:82f:91f:bf35 with SMTP id d2e1a72fcca58-82f0c269357mr15141133b3a.3.1776102455325;
        Mon, 13 Apr 2026 10:47:35 -0700 (PDT)
Received: from localhost.localdomain ([2601:600:837f:c470:1879:8422:922b:e5d3])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f278046e2sm6834731b3a.42.2026.04.13.10.47.34
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 13 Apr 2026 10:47:34 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: torvalds@linux-foundation.org
Cc: bpf@vger.kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org,
	memxor@gmail.com,
	eddyz87@gmail.com
Subject: [GIT PULL] BPF changes for 7.1
Date: Mon, 13 Apr 2026 10:47:31 -0700
Message-ID: <20260413174732.87983-1-alexei.starovoitov@gmail.com>
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

The following changes since commit d8a9a4b11a137909e306e50346148fc5c3b63f9d:

  Merge tag 'v7.0-rc6-smb3-client-fix' of git://git.samba.org/sfrench/cifs-2.6 (2026-04-02 21:04:28 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git tags/bpf-next-7.1

for you to fetch changes up to 71b500afd2f7336f5b6c6026f2af546fc079be26:

  Merge branch 'bpf-fix-short-ipv4-ipv6-handling-in-test_run_skb' (2026-04-12 15:42:57 -0700)

----------------------------------------------------------------
There are two trivial conflicts:
  . between powerpc and bpf-next trees in selftests/bpf
    https://lore.kernel.org/all/adTxB7PjvXi5N4EB@sirena.org.uk/
  . between rcu and bpf-next in include/linux/rcupdate.h
    rcu_trace_implies_rcu_gp() was deleted with Paul's ack.
    It was introduced for BPF and only used by BPF.


- Welcome new BPF maintainers: Kumar Kartikeya Dwivedi, Eduard Zingerman
  while Martin KaFai Lau reduced his load to Reviwer.

- Lots of fixes everywhere from many first time contributors. Thank you All.

- Diff stat is dominated by mechanical split of verifier.c into
  multiple components: backtrack.c (backtracking logic and jump history),
  states.c (state equivalence), cfg.c (control flow graph, postorder,
  strongly connected components), liveness.c (register and stack liveness),
  fixups.c (post-verification passes: instruction patching, dead code removal,
  bpf_loop inlining, finalize fastcall).
  8k line were moved. verifier.c still stands at 20k lines.
  Further refactoring is planned for the next release.

- Replace dynamic stack liveness with static stack liveness based on
  data flow analysis. It improved the verification time by 2x for some
  programs and equally reduced memory consumption. New logic is
  in liveness.c and supported by constant folding in const_fold.c
  (Eduard Zingerman, Alexei Starovoitov)

- Introduce BTF layout to ease addition of new BTF kinds (Alan Maguire)

- Use kmalloc_nolock() universally in BPF local storage (Amery Hung)

- Fix several bugs in linked registers delta tracking (Daniel Borkmann)

- Improve verifier support of arena pointers (Emil Tsalapatis)

- Improve verifier tracking of register bounds in min/max and tnum
  domains (Harishankar Vishwanathan, Paul Chaignon, Hao Sun)

- Further extend support for implicit arguments in the verifier
  (Ihor Solodrai)

- Add support for nop,nop5 instruction combo for USDT probes in libbpf
  (Jiri Olsa)

- Support merging multiple module BTFs (Josef Bacik)

- Extend applicability of bpf_kptr_xchg (Kaitao Cheng)

- Retire rcu_trace_implies_rcu_gp() (Kumar Kartikeya Dwivedi)

- Support variable offset context access for 'syscall' programs
  (Kumar Kartikeya Dwivedi)

- Migrate bpf_task_work and dynptr to kmalloc_nolock() (Mykyta Yatsenko)

- Fix UAF in in open-coded task_vma iterator (Puranjay Mohan)

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
----------------------------------------------------------------
Abhishek Dubey (1):
      selftests/bpf: Enable test for instruction array on arm64

Alan Maguire (12):
      selftests/bpf: Handle !CONFIG_SMC in bpf_smc.c
      btf: Add BTF kind layout encoding to UAPI
      libbpf: Support layout section handling in BTF
      libbpf: Use layout to compute an unknown kind size
      libbpf: Add layout encoding support
      libbpf: BTF validation can use layout for unknown kinds
      libbpf: Support sanitization of BTF layout for older kernels
      btf: Support kernel parsing of BTF with layout info
      selftests/bpf: Test kind encoding/decoding
      kbuild, bpf: Specify "layout" optional feature
      libbpf: Allow use of feature cache for non-token cases
      selftests/bpf: Add BTF sanitize test covering BTF layout

Alexei Starovoitov (69):
      Merge branch 'bpf-consolidate-pointer-offset-tracking-in-var_off'
      Merge git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf before 7.0-rc1
      Merge branch 'selftests-bpf-fix-flaky-build_id-test'
      Merge git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf after 7.0-rc1
      Merge branch 'bpf-expand-the-usage-scenarios-of-bpf_kptr_xchg'
      Merge git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf before 7.0-rc2
      Merge branch 'bpf-s390-implement-get_preempt_count'
      Merge branch 'bpf-fsession-support-for-s390'
      Merge branch 'libbpf-make-optimized-uprobes-backward-compatible'
      Merge branch 'allow-fixed-offsets-for-ptr_to_ctx'
      Merge branch 'bpf-allow-void-return-type-for-global-subprogs'
      Merge git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf 7.0-rc3
      Merge branch 'always-allow-sleepable-and-fmod_ret-programs-on-syscalls'
      Merge branch 'bpf-support-for-non_null-ptr-detection-with-jeq-jne-with-register-operand'
      Merge branch 'fix-test_cgroup_iter_memcg-issues-found-during-back-porting'
      Merge branch 'optimize-bounds-refinement-by-reordering-deductions'
      Merge branch 'bpf-relax-8-frame-limitation-for-global-subprogs'
      Merge branch 'bpf-consolidate-sleepable-context-checks-in-verifier'
      Merge branch 'libbpf-add-bpf_program__clone-for-individual-program-loading'
      Merge git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf 7.0-rc5
      bpf: Support 32-bit scalar spills in stacksafe()
      selftests/bpf: Test 32-bit scalar spill pruning in stacksafe()
      Merge branch 'bpf-add-multi-level-pointer-parameter-support-for-trampolines'
      bpf: Fix variable length stack write over spilled pointers
      selftests/bpf: Test variable length stack write
      selftests/bpf: Make reg_bounds test more robust
      Merge branch 'bpf-classify-block-device-hooks-and-add-selftests'
      Merge branch 'bpf-fix-abuse-of-kprobe_write_ctx-via-freplace'
      Merge branch 'bpf-migrate-bpf_task_work-and-file-dynptr-to-kmalloc_nolock'
      Merge branch 'task-local-data-bug-fixes-and-improvement'
      Merge branch 'fix-invariant-violations-and-improve-branch-detection'
      Merge git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf 7.0-rc6+
      bpf: Do register range validation early
      bpf: Sort subprogs in topological order after check_cfg()
      selftests/bpf: Add tests for subprog topological ordering
      bpf: Add bpf_compute_const_regs() and bpf_prune_dead_branches() passes
      bpf: Move verifier helpers to header
      bpf: Add helper and kfunc stack access size resolution
      Merge branch 'bpf-prep-patches-for-static-stack-liveness'
      Merge branch 'bpf-fix-torn-writes-in-non-prealloc-htab-with-bpf_f_lock'
      Merge branch 'bpf-fix-end-of-list-detection-in-cgroup_storage_get_next_key'
      Merge branch 'allow-variable-offsets-for-syscall-ptr_to_ctx'
      Merge branch 'properly-load-values-from-insn_arays-with-non-zero-offsets'
      Merge branch 'tracing-fix-kprobe-attachment-when-module-shadows-vmlinux-symbol'
      Merge branch 'allow-referenced-dynptr-to-be-overwritten-when-siblings-exists'
      Merge branch 'bpf-fix-and-improve-open-coded-task_vma-iterator'
      Merge branch 'selftests-bpf-test-btf-sanitization'
      bpf: Add spis_*() helpers for 4-byte stack slot bitmasks
      selftests/bpf: update existing tests due to liveness changes
      selftests/bpf: adjust verifier_log buffers
      selftests/bpf: add new tests for static stack liveness analysis
      bpf: poison dead stack slots
      Merge branch 'bpf-static-stack-liveness-data-flow-analysis'
      Merge branch 'use-kmalloc_nolock-universally-in-bpf-local-storage'
      Merge branch 'selftests-bpf-impose-global-ordering-for-test-decl_tags'
      bpf: Delete unused variable
      bpf: Move checks for reserved fields out of the main pass
      bpf: Simplify do_check_insn()
      bpf: Move fixup/post-processing logic from verifier.c into fixups.c
      bpf: Move compute_insn_live_regs() into liveness.c
      bpf: Move check_cfg() into cfg.c
      bpf: Move state equivalence logic to states.c
      bpf: Move backtracking logic to backtrack.c
      bpf: Move BTF checking logic into check_btf.c
      Merge branch 'bpf-split-verifier-c'
      Merge branch 'bpf-add-the-missing-fsession'
      Merge patch series "bpf: Fix OOB in pcpu_init_value and add a test"
      selftests/bpf: Use memfd_create instead of shm_open in cgroup_iter_memcg
      Merge branch 'bpf-fix-short-ipv4-ipv6-handling-in-test_run_skb'

Alexis Lothoré (eBPF Foundation) (2):
      selftests/bpf: drop test_bpftool.sh
      selftests/bpf: remove unused toggle in tc_tunnel

Amery Hung (14):
      selftests/bpf: Update task local data license
      bpf: Do not allow deleting local storage in NMI
      bpf: Add warning to detect memory leak in bpf_selem_unlink_nofail()
      selftests/bpf: Fix compiler warnings in task_local_data.h
      selftests/bpf: Fix task_local_data data allocation size
      selftests/bpf: Simplify task_local_data memory allocation
      selftests/bpf: Make sure TLD_DEFINE_KEY runs first
      selftests/bpf: Remove TLD_READ_ONCE() in the user space header
      selftests/bpf: Improve task local data documentation and fix potential memory leak
      bpf: Allow overwriting referenced dynptr when refcnt > 1
      selftests/bpf: Test overwriting referenced dynptr
      selftests/bpf: Remove kmalloc tracing from local storage create bench
      bpf: Use kmalloc_nolock() universally in local storage
      bpf: Remove gfp_flags plumbing from bpf_local_storage_update()

Anand Kumar Shaw (1):
      bpf: Add missing XDP_ABORTED handling in cpumap

Andrey Grodzovsky (4):
      libbpf: Optimize kprobe.session attachment for exact function names
      selftests/bpf: Add tests for kprobe.session optimization
      bpf: Prefer vmlinux symbols over module symbols for unqualified kprobes
      selftests/bpf: Add tests for kprobe attachment with duplicate symbols

Andrii Nakryiko (5):
      Merge branch 'libbpf-bpftool-support-merging-split-btfs'
      Merge branch 'selftests-bpf-fix-bpf_cookie-failures'
      Merge branch 'optimize-kprobe-session-attachment-for-exact-function-names'
      Merge branch 'add-btf-layout-to-btf'
      Merge branch 'libbpf-clarify-raw-address-single-kprobe-attach-behavior'

Anton Protopopov (2):
      bpf: Do not ignore offsets for loads from insn_arrays
      selftests/bpf: Add more tests for loading insn arrays with offsets

Carlos Llamas (1):
      bpf: Switch CONFIG_CFI_CLANG to CONFIG_CFI

Christian Brauner (2):
      bpf: classify block device hooks appropriately
      selftests/bpf: add block device management selftests

Cupertino Miranda (2):
      bpf: detect non null pointer with register operand in JEQ/JNE.
      selftests/bpf: tests to non_null ptr detection using register operand in JEQ/JNE

Daniel Borkmann (13):
      selftests/bpf: Add few tests for alu32 shift value tracking and zext
      bpf: Fix linked reg delta tracking when src_reg == dst_reg
      bpf: Clear delta when clearing reg id for non-{add,sub} ops
      selftests/bpf: Add tests for delta tracking when src_reg == dst_reg
      selftests/bpf: Add tests for stale delta leaking through id reassignment
      bpf: Propagate error from visit_tailcall_insn
      bpf: Fix ld_{abs,ind} failure path analysis in subprogs
      bpf: Remove static qualifier from local subprog pointer
      selftests/bpf: Add tests for ld_{abs,ind} failure path in subprogs
      bpf: Drop pkt_end markers on arithmetic to prevent is_pkt_ptr_branch_taken
      selftests/bpf: Add test for stale pkt range after scalar arithmetic
      bpf: Enforce regsafe base id consistency for BPF_ADD_CONST scalars
      selftests/bpf: Add test for add_const base_id consistency

David Carlier (1):
      bpf: Use RCU-safe iteration in dev_map_redirect_multi() SKB path

Eduard Zingerman (21):
      selftests/bpf: Migrate align.c tests to test_loader framework
      bpf: split check_reg_sane_offset() in two parts
      bpf: use reg->var_off instead of reg->off for pointers
      nfp: bpf: remove references to bpf_reg_state->off for pointers
      bpf: rename bpf_reg_state->off to bpf_reg_state->delta
      bpf: Extract program_returns_void() for clarity
      bpf: extract check_global_subprog_return_code() for clarity
      bpf: better naming for __reg_deduce_bounds() parts
      bpf: share several utility functions as internal API
      bpf: save subprogram name in bpf_subprog_info
      bpf: make liveness.c track stack with 4-byte granularity
      bpf: 4-byte precise clean_verifier_state
      bpf: prepare liveness internal API for static analysis pass
      bpf: introduce forward arg-tracking dataflow analysis
      bpf: record arg tracking results in bpf_liveness masks
      bpf: simplify liveness to use (callsite, depth) keyed func_instances
      bpf: change logging scheme for live stack analysis
      selftests/bpf: fix __jited_unpriv tag name
      selftests/bpf: make str_has_pfx return pointer past the prefix
      selftests/bpf: impose global ordering for test decl_tags
      selftests/bpf: inline TEST_TAG constants in test_loader.c

Emil Tsalapatis (7):
      bpf: Factor out program return value calculation
      bpf: Allow void global functions in the verifier
      selftests: bpf: Add tests for void global subprogs
      bpf: Only enforce 8 frame call stack limit for all-static stacks
      selftests/bpf: Add deep call stack selftests
      bpf: Allow instructions with arena source and non-arena dest registers
      selftests/bpf: Add tests for non-arena/arena operations

Eric Biggers (1):
      bpf: Remove inclusions of crypto/sha1.h

Eyal Birger (1):
      bpf: Clarify BPF_RB_NO_WAKEUP behavior for bpf_ringbuf_discard()

Feng Yang (2):
      bpf: test_run: Fix the null pointer dereference issue in bpf_lwt_xmit_push_encap
      selftests/bpf: Add selftests for the invocation of bpf_lwt_xmit_push_encap

Gregory Bell (2):
      selftests/bpf: fix flaky build_id test
      selftests/bpf: align build_id test mapping to 64K page size

Gustavo A. R. Silva (1):
      bpf: Avoid -Wflex-array-members-not-at-end warnings

Hao Sun (1):
      bpf: Simplify tnum_step()

Hari Bathini (3):
      bpf: Do not increment tailcall count when prog is NULL
      selftests/bpf: Test accounting of tail calls when prog is NULL
      selftests/bpf: Improve test coverage for kfunc call

Harishankar Vishwanathan (3):
      bpf: Refactor reg_bounds_sanity_check
      bpf: Exit early if reg_bounds_sync gets invalid inputs
      bpf: Simulate branches to prune based on range violations

Hoyeon Lee (3):
      libbpf: Use direct error codes for kprobe/uprobe attach
      libbpf: Clarify raw-address single kprobe attach behavior
      selftests/bpf: Add test for raw-address single kprobe attach

Hui Zhu (2):
      selftests/bpf: Remove kmem subtest from cgroup_iter_memcg
      selftests/bpf: Use bpf_core_enum_value for stats in cgroup_iter_memcg

Ihor Solodrai (5):
      selftests/bpf: Fix flakiness of task_local_storage/sys_enter_exit
      selftests/bpf: Bump path and command buffer sizes in bpftool_helpers.c
      libbpf: Start v1.8 development cycle
      bpf: Support struct btf_struct_meta via KF_IMPLICIT_ARGS
      selftests/bpf: Update kfuncs using btf_struct_meta to new variants

Ilya Leoshkevich (4):
      s390/bpf: Do not increment tailcall count when prog is NULL
      s390: Introduce bpf_get_lowcore() kfunc
      bpf/s390: Implement get_preempt_count()
      s390/bpf: Zero-extend bpf prog return values and kfunc arguments

Jiayuan Chen (4):
      selftests/bpf: Improve tc_tunnel test reliability
      selftests/bpf: Fix sockmap_multi_channels reliability
      bpf: Drop task_to_inode and inet_conn_established from lsm sleepable hooks
      bpf: Fix use-after-free in offloaded map/prog info fill

Jiri Olsa (6):
      libbpf: Add uprobe syscall feature detection
      libbpf: Add support to detect nop,nop5 instructions combo for usdt probe
      selftests/bpf: Emit nop,nop5 instructions combo for x86_64 arch
      selftests/bpf: Add test for checking correct nop of optimized usdt
      selftests/bpf: Add usdt trigger bench
      bpf: Fix block device hooks names

Josef Bacik (3):
      libbpf: Support appending split BTF in btf__add_btf()
      bpftool: Support merging multiple module BTFs in btf dump
      selftests/bpf: Add test for btf__add_btf() with split BTF sources

Kaitao Cheng (5):
      bpf: allow calling bpf_kptr_xchg while holding a lock
      bpf: allow using bpf_kptr_xchg even if the NON_OWN_REF flag is set
      selftests/bpf: Add supplementary tests for bpf_kptr_xchg
      bpf: allow using bpf_kptr_xchg even if the MEM_RCU flag is set
      selftests/bpf: Add test case for rbtree nodes that contain both bpf_refcount and kptr fields.

Keisuke Nishimura (1):
      bpf: Fix refcount check in check_struct_ops_btf_id()

Kexin Sun (1):
      bpf: update outdated comment for refactored btf_check_kfunc_arg_match()

Kumar Kartikeya Dwivedi (14):
      bpf: Relax fixed offset check for PTR_TO_CTX
      selftests/bpf: Add tests for ctx fixed offset support
      bpf: Update MAINTAINERS file for general BPF entry
      bpf: Support variable offsets for syscall PTR_TO_CTX
      bpf: Enable unaligned accesses for syscall ctx
      selftests/bpf: Convert ctx tests from ASM to C
      selftests/bpf: Add syscall ctx variable offset tests
      selftests/bpf: Test modified syscall ctx for ARG_PTR_TO_CTX
      selftests/bpf: Add tests for unaligned syscall ctx accesses
      selftests/bpf: Add tests for syscall ctx accesses beyond U16_MAX
      selftests/bpf: Allow prog name matching for tests with __description
      bpf: Retire rcu_trace_implies_rcu_gp()
      bpf: Extract bpf_get_linfo_file_line
      bpf: Make find_linfo widely available

Lang Xu (2):
      bpf: Fix OOB in pcpu_init_value
      selftests/bpf: Add test for cgroup storage OOB read

Leon Hwang (2):
      bpf: Fix abuse of kprobe_write_ctx via freplace
      selftests/bpf: Add test to verify the fix of kprobe_write_ctx abuse

Maciej Fijalkowski (2):
      xsk: avoid double checking against rx queue being full
      xsk: use __xsk_rcv_zc_safe for ZC multi-buffer Rx processing

Martin KaFai Lau (2):
      Merge branch 'fix-the-null-pointer-dereference-issue-in-bpf_lwt_xmit_push_encap'
      bpf: Remove ipv6_bpf_stub usage in test_run

Menglong Dong (7):
      bpf,s390: introduce emit_store_stack_imm64() for trampoline
      bpf,s390: add fsession support for trampolines
      selftests/bpf: factor out get_func_* tests for fsession
      selftests/bpf: Test access to ringbuf position with map pointer
      bpf: add missing fsession to the verifier log
      docs/bpf: add missing fsession attach type to docs
      bpftool: add missing fsession to the usage and docs of bpftool

MingTao Huang (1):
      bpf: Fix stale offload->prog pointer after constant blinding

Mykyta Yatsenko (10):
      bpftool: Allow explicitly skip llvm, libbfd and libcrypto dependencies
      libbpf: Introduce bpf_program__clone()
      selftests/bpf: Use bpf_program__clone() in veristat
      selftests/bpf: Test bpf_program__clone() attach_btf_id override
      selftests/bpf: Suppress veristat error messages in non-verbose mode
      bpf: Migrate bpf_task_work to kmalloc_nolock
      bpf: Migrate dynptr file to kmalloc_nolock
      libbpf: Fix BTF handling in bpf_program__clone()
      bpf: Use copy_map_value_locked() in alloc_htab_elem() for BPF_F_LOCK
      selftests/bpf: Add torn write detection test for htab BPF_F_LOCK

Paul Chaignon (6):
      bpf: Avoid one round of bounds deduction
      selftests/bpf: Test case for refinement improvement using 64b bounds
      bpf: Use bpf_verifier_env buffers for reg_set_min_max
      selftests/bpf: Cover invariant violation case from syzbot
      selftests/bpf: Remove invariant violation flags
      selftests/bpf: Fix reg_bounds to match new tnum-based refinement

Puranjay Mohan (8):
      bpf, arm64: Use ORR-based MOV for general-purpose registers
      bpf: Consolidate sleepable checks in check_helper_call()
      bpf: Consolidate sleepable checks in check_kfunc_call()
      bpf: Consolidate sleepable checks in check_func_call()
      bpftool: Enable aarch64 ISA extensions for JIT disassembly
      bpf: fix mm lifecycle in open-coded task_vma iterator
      bpf: switch task_vma iterator from mmap_lock to per-VMA locks
      bpf: return VMA snapshot from task_vma iterator

Qi Tang (1):
      selftests/bpf: add test for nullable PTR_TO_BUF access

Saket Kumar Bhaskar (1):
      selftests/bpf: Add powerpc support for get_preempt_count() in selftest

Sechang Lim (1):
      bpf: Fix RCU stall in bpf_fd_array_map_clear()

Slava Imameev (2):
      bpf: Support pointer param types via SCALAR_VALUE for trampolines
      selftests/bpf: Add trampolines single and multi-level pointer params test coverage

Sun Jian (10):
      selftests/bpf: bpf_cookie: Skip kprobe_multi tests without bpf_testmod
      selftests/bpf: bpf_cookie: Make perf_event subtest trigger reliably
      selftests/bpf: filter by pid to avoid cross-test interference
      selftests/bpf: drop serial restriction
      selftests/bpf: Skip livepatch test when prerequisites are missing
      selftests/bpf: Avoid spurious failures perf_link
      selftests/bpf: Isolate fmod_ret hooks by pid
      selftests/bpf: move trampoline_count to dedicated bpf_testmod target
      bpf: reject short IPv4/IPv6 inputs in bpf_prog_test_run_skb
      selftests/bpf: cover short IPv4/IPv6 inputs with adjust_room

Tiezhu Yang (1):
      selftests/bpf: Add alignment flag for test_verifier 190 testcase

Varun R Mallya (4):
      selftests/bpf: Fix const qualifier warning in fexit_bpf2bpf.c
      selftests/bpf: Improve connect_force_port test reliability
      selftests/bpf: Add test for struct_ops __ref argument in any position
      selftests/bpf: Add test to ensure kprobe_multi is not sleepable

Venkat Rao Bagalkote (1):
      selftests/bpf: Remove test_access_variable_array

Viktor Malik (5):
      selftests/bpf: Split module_attach into subtests
      bpf: Always allow sleepable programs on syscalls
      bpf: Always allow fmod_ret programs on syscalls
      selftests/bpf: Move sleepable refcounted_kptr tests to syscalls
      selftests/bpf: Speed up module_attach test

Weiming Shi (3):
      bpf: fix end-of-list detection in cgroup_storage_get_next_key()
      selftests/bpf: add get_next_key boundary test for cgroup_storage
      bpf: reject negative CO-RE accessor indices in bpf_core_parse_spec()

Weixie Cui (1):
      bpf: propagate kvmemdup_bpfptr errors from bpf_prog_verify_signature

haoyu.lu (1):
      bpf,arc_jit: Fix missing newline in pr_err messages

 Documentation/bpf/drgn.rst                         |     4 +-
 Documentation/bpf/libbpf/program_types.rst         |     4 +
 MAINTAINERS                                        |     7 +-
 arch/arc/net/bpf_jit_arcv2.c                       |     8 +-
 arch/arm64/net/bpf_jit.h                           |     4 +-
 arch/s390/kernel/Makefile                          |     2 +
 arch/s390/kernel/bpf.c                             |    12 +
 arch/s390/net/bpf_jit_comp.c                       |   157 +-
 drivers/net/ethernet/netronome/nfp/bpf/jit.c       |    18 +-
 drivers/net/ethernet/netronome/nfp/bpf/verifier.c  |    12 +-
 include/linux/bpf-cgroup.h                         |     2 +-
 include/linux/bpf.h                                |    10 +-
 include/linux/bpf_local_storage.h                  |    15 +-
 include/linux/bpf_verifier.h                       |   423 +-
 include/linux/btf_ids.h                            |     2 +-
 include/linux/filter.h                             |     1 -
 include/linux/rcupdate.h                           |    12 -
 include/uapi/linux/bpf.h                           |     4 +-
 include/uapi/linux/btf.h                           |    12 +
 kernel/bpf/Makefile                                |     3 +-
 kernel/bpf/arraymap.c                              |     4 +-
 kernel/bpf/backtrack.c                             |   934 ++
 kernel/bpf/bpf_cgrp_storage.c                      |    11 +-
 kernel/bpf/bpf_inode_storage.c                     |    11 +-
 kernel/bpf/bpf_local_storage.c                     |   157 +-
 kernel/bpf/bpf_lsm.c                               |     7 +-
 kernel/bpf/bpf_task_storage.c                      |    11 +-
 kernel/bpf/btf.c                                   |    86 +-
 kernel/bpf/cfg.c                                   |   872 +
 kernel/bpf/check_btf.c                             |   463 +
 kernel/bpf/const_fold.c                            |   396 +
 kernel/bpf/core.c                                  |    95 +-
 kernel/bpf/cpumap.c                                |     5 +-
 kernel/bpf/devmap.c                                |     5 +-
 kernel/bpf/fixups.c                                |  2457 +++
 kernel/bpf/hashtab.c                               |     6 +-
 kernel/bpf/helpers.c                               |   243 +-
 kernel/bpf/liveness.c                              |  2400 ++-
 kernel/bpf/local_storage.c                         |     2 +-
 kernel/bpf/log.c                                   |    62 +-
 kernel/bpf/memalloc.c                              |    33 +-
 kernel/bpf/offload.c                               |    10 +-
 kernel/bpf/states.c                                |  1563 ++
 kernel/bpf/syscall.c                               |    44 +-
 kernel/bpf/task_iter.c                             |   151 +-
 kernel/bpf/tnum.c                                  |    46 +-
 kernel/bpf/verifier.c                              | 16046 ++++++-------------
 kernel/trace/trace_kprobe.c                        |     8 +
 net/bpf/test_run.c                                 |    49 +-
 net/core/bpf_sk_storage.c                          |    23 +-
 net/ipv6/addrconf.c                                |     1 +
 net/xdp/xsk.c                                      |    18 +-
 net/xdp/xsk_queue.h                                |    16 +-
 scripts/Makefile.btf                               |     2 +
 tools/bpf/bpftool/Documentation/bpftool-btf.rst    |    11 +-
 tools/bpf/bpftool/Documentation/bpftool-prog.rst   |     2 +-
 tools/bpf/bpftool/Makefile                         |    30 +-
 tools/bpf/bpftool/bash-completion/bpftool          |     8 +-
 tools/bpf/bpftool/btf.c                            |   121 +-
 tools/bpf/bpftool/jit_disasm.c                     |    11 +-
 tools/bpf/bpftool/main.c                           |     7 +
 tools/bpf/bpftool/main.h                           |    14 +
 tools/bpf/bpftool/prog.c                           |     2 +-
 tools/bpf/resolve_btfids/main.c                    |     1 +
 tools/include/uapi/linux/bpf.h                     |     4 +-
 tools/include/uapi/linux/btf.h                     |    12 +
 tools/lib/bpf/btf.c                                |   623 +-
 tools/lib/bpf/btf.h                                |    20 +
 tools/lib/bpf/features.c                           |    53 +
 tools/lib/bpf/libbpf.c                             |   240 +-
 tools/lib/bpf/libbpf.h                             |    44 +-
 tools/lib/bpf/libbpf.map                           |     6 +
 tools/lib/bpf/libbpf_internal.h                    |     9 +
 tools/lib/bpf/libbpf_probes.c                      |    40 +-
 tools/lib/bpf/libbpf_version.h                     |     2 +-
 tools/lib/bpf/relo_core.c                          |     2 +
 tools/lib/bpf/usdt.c                               |    47 +-
 tools/testing/selftests/bpf/.gitignore             |     2 +
 tools/testing/selftests/bpf/Makefile               |    17 +-
 tools/testing/selftests/bpf/bench.c                |     4 +
 .../bpf/benchs/bench_local_storage_create.c        |    21 +-
 tools/testing/selftests/bpf/benchs/bench_trigger.c |    60 +
 .../selftests/bpf/benchs/run_bench_uprobes.sh      |     2 +-
 tools/testing/selftests/bpf/bpf_experimental.h     |   174 +-
 tools/testing/selftests/bpf/bpftool_helpers.c      |    15 +-
 tools/testing/selftests/bpf/cgroup_iter_memcg.h    |     2 -
 .../bpf/prog_tests/access_variable_array.c         |    16 -
 tools/testing/selftests/bpf/prog_tests/align.c     |   712 -
 .../selftests/bpf/prog_tests/attach_probe.c        |   213 +
 .../testing/selftests/bpf/prog_tests/bpf_cookie.c  |    29 +-
 tools/testing/selftests/bpf/prog_tests/bpf_gotox.c |   123 +-
 .../selftests/bpf/prog_tests/bpf_insn_array.c      |     2 +-
 tools/testing/selftests/bpf/prog_tests/btf_kind.c  |   226 +
 .../selftests/bpf/prog_tests/btf_sanitize.c        |    97 +
 tools/testing/selftests/bpf/prog_tests/btf_write.c |   111 +
 .../selftests/bpf/prog_tests/cgroup_iter_memcg.c   |    35 +-
 .../selftests/bpf/prog_tests/cgroup_storage.c      |    47 +
 .../selftests/bpf/prog_tests/clone_attach_btf_id.c |    78 +
 .../selftests/bpf/prog_tests/connect_force_port.c  |    26 +-
 tools/testing/selftests/bpf/prog_tests/empty_skb.c |    40 +-
 .../testing/selftests/bpf/prog_tests/exceptions.c  |     9 +-
 .../selftests/bpf/prog_tests/fexit_bpf2bpf.c       |    26 +-
 .../selftests/bpf/prog_tests/get_func_args_test.c  |    25 +-
 .../selftests/bpf/prog_tests/get_func_ip_test.c    |    28 +-
 .../testing/selftests/bpf/prog_tests/htab_reuse.c  |   169 +-
 .../selftests/bpf/prog_tests/iter_buf_null_fail.c  |     9 +
 .../testing/selftests/bpf/prog_tests/kfunc_call.c  |     2 +
 .../selftests/bpf/prog_tests/kprobe_multi_test.c   |   108 +-
 .../testing/selftests/bpf/prog_tests/linked_list.c |     4 +-
 .../bpf/prog_tests/livepatch_trampoline.c          |    20 +-
 tools/testing/selftests/bpf/prog_tests/lsm_bdev.c  |   221 +
 tools/testing/selftests/bpf/prog_tests/lwt_misc.c  |     9 +
 .../selftests/bpf/prog_tests/modify_return.c       |     8 +-
 .../selftests/bpf/prog_tests/module_attach.c       |   173 +-
 tools/testing/selftests/bpf/prog_tests/perf_link.c |    20 +-
 .../testing/selftests/bpf/prog_tests/probe_user.c  |    29 +-
 tools/testing/selftests/bpf/prog_tests/rbtree.c    |     6 +
 .../testing/selftests/bpf/prog_tests/reg_bounds.c  |    53 +-
 .../selftests/bpf/prog_tests/sockmap_basic.c       |    17 +-
 tools/testing/selftests/bpf/prog_tests/spin_lock.c |     5 +-
 .../selftests/bpf/prog_tests/summarization.c       |     2 +-
 .../selftests/bpf/prog_tests/task_local_data.h     |   104 +-
 .../selftests/bpf/prog_tests/task_local_storage.c  |    16 +-
 .../selftests/bpf/prog_tests/test_bpf_smc.c        |     6 +-
 .../selftests/bpf/prog_tests/test_global_funcs.c   |     2 +
 .../bpf/prog_tests/test_struct_ops_multi_args.c    |     9 +
 .../bpf/prog_tests/test_task_local_data.c          |     2 +-
 .../selftests/bpf/prog_tests/test_tc_tunnel.c      |    17 +-
 .../selftests/bpf/prog_tests/trampoline_count.c    |    17 +-
 tools/testing/selftests/bpf/prog_tests/usdt.c      |    92 +
 tools/testing/selftests/bpf/prog_tests/verifier.c  |    10 +-
 .../selftests/bpf/prog_tests/verifier_log.c        |     6 +-
 .../bpf/progs/bench_local_storage_create.c         |    11 -
 tools/testing/selftests/bpf/progs/bpf_gotox.c      |    31 +
 tools/testing/selftests/bpf/progs/bpf_misc.h       |    68 +-
 tools/testing/selftests/bpf/progs/bpf_smc.c        |    28 +-
 .../selftests/bpf/progs/cgroup_iter_memcg.c        |    18 +-
 tools/testing/selftests/bpf/progs/cgroup_storage.c |    43 +
 .../selftests/bpf/progs/clone_attach_btf_id.c      |    13 +
 .../selftests/bpf/progs/connect_force_port4.c      |    10 +-
 .../selftests/bpf/progs/connect_force_port6.c      |    10 +-
 tools/testing/selftests/bpf/progs/dynptr_fail.c    |   115 +
 tools/testing/selftests/bpf/progs/empty_skb.c      |     7 +
 tools/testing/selftests/bpf/progs/exceptions.c     |    14 +
 .../selftests/bpf/progs/exceptions_assert.c        |     6 +-
 .../testing/selftests/bpf/progs/exceptions_fail.c  |    34 +-
 .../selftests/bpf/progs/freplace_int_with_void.c   |    11 +
 tools/testing/selftests/bpf/progs/freplace_void.c  |    10 +
 .../bpf/progs/get_func_args_fsession_test.c        |    37 +
 .../selftests/bpf/progs/get_func_args_test.c       |    38 -
 .../bpf/progs/get_func_ip_fsession_test.c          |    21 +
 .../testing/selftests/bpf/progs/get_func_ip_test.c |    23 -
 tools/testing/selftests/bpf/progs/htab_reuse.c     |    16 +
 tools/testing/selftests/bpf/progs/irq.c            |     4 +-
 .../selftests/bpf/progs/iter_buf_null_fail.c       |    39 +
 tools/testing/selftests/bpf/progs/iters.c          |     6 +-
 .../testing/selftests/bpf/progs/kfunc_call_test.c  |    98 +
 .../selftests/bpf/progs/kprobe_multi_session.c     |    10 +
 .../selftests/bpf/progs/kprobe_multi_sleepable.c   |    25 +
 .../testing/selftests/bpf/progs/kprobe_write_ctx.c |    19 +
 .../testing/selftests/bpf/progs/kptr_xchg_inline.c |     4 +-
 tools/testing/selftests/bpf/progs/lsm_bdev.c       |    96 +
 tools/testing/selftests/bpf/progs/lwt_misc.c       |    22 +
 tools/testing/selftests/bpf/progs/map_ptr_kern.c   |    17 +
 .../selftests/bpf/progs/mem_rdonly_untrusted.c     |     2 +-
 tools/testing/selftests/bpf/progs/modify_return.c  |    13 +
 .../selftests/bpf/progs/percpu_alloc_fail.c        |     4 +-
 tools/testing/selftests/bpf/progs/preempt_lock.c   |     6 +-
 .../selftests/bpf/progs/rbtree_search_kptr.c       |   290 +
 .../testing/selftests/bpf/progs/refcounted_kptr.c  |     4 +-
 .../selftests/bpf/progs/refcounted_kptr_fail.c     |     2 +-
 .../selftests/bpf/progs/struct_ops_multi_args.c    |    35 +
 tools/testing/selftests/bpf/progs/tailcall3.c      |     5 +-
 .../selftests/bpf/progs/task_local_data.bpf.h      |     4 +-
 .../bpf/progs/test_access_variable_array.c         |    19 -
 .../selftests/bpf/progs/test_global_func3.c        |    18 +-
 .../selftests/bpf/progs/test_global_func7.c        |     2 +-
 .../bpf/progs/test_global_func_deep_stack.c        |    95 +
 .../selftests/bpf/progs/test_module_attach.c       |    63 +-
 .../testing/selftests/bpf/progs/test_probe_user.c  |    13 +-
 .../selftests/bpf/progs/test_trampoline_count.c    |    12 +-
 tools/testing/selftests/bpf/progs/test_usdt.c      |    12 +
 tools/testing/selftests/bpf/progs/trigger_bench.c  |    10 +-
 tools/testing/selftests/bpf/progs/uninit_stack.c   |     1 +
 tools/testing/selftests/bpf/progs/verifier_align.c |   581 +
 tools/testing/selftests/bpf/progs/verifier_arena.c |   130 +
 .../bpf/progs/verifier_async_cb_context.c          |     4 +-
 .../testing/selftests/bpf/progs/verifier_bounds.c  |    87 +-
 tools/testing/selftests/bpf/progs/verifier_ctx.c   |   569 +-
 .../selftests/bpf/progs/verifier_ctx_ptr_param.c   |    68 +
 .../bpf/progs/verifier_direct_packet_access.c      |    65 +-
 .../selftests/bpf/progs/verifier_div_mod_bounds.c  |    18 +-
 .../selftests/bpf/progs/verifier_global_subprogs.c |   114 +-
 tools/testing/selftests/bpf/progs/verifier_gotox.c |     4 +-
 .../bpf/progs/verifier_helper_packet_access.c      |     2 +-
 .../bpf/progs/verifier_helper_value_access.c       |     4 +-
 .../testing/selftests/bpf/progs/verifier_int_ptr.c |     2 +-
 .../bpf/progs/verifier_jeq_infer_not_null.c        |    54 +
 .../testing/selftests/bpf/progs/verifier_ld_ind.c  |   142 +
 .../selftests/bpf/progs/verifier_linked_scalars.c  |   175 +
 .../selftests/bpf/progs/verifier_live_stack.c      |  2411 ++-
 .../selftests/bpf/progs/verifier_liveness_exp.c    |   139 +
 .../testing/selftests/bpf/progs/verifier_loops1.c  |     3 +-
 .../selftests/bpf/progs/verifier_meta_access.c     |     2 +-
 .../selftests/bpf/progs/verifier_private_stack.c   |     8 +-
 .../selftests/bpf/progs/verifier_scalar_ids.c      |    46 +-
 .../selftests/bpf/progs/verifier_spill_fill.c      |    96 +-
 .../selftests/bpf/progs/verifier_stack_ptr.c       |     4 +-
 .../bpf/progs/verifier_subprog_precision.c         |     8 +-
 .../selftests/bpf/progs/verifier_subprog_topo.c    |   226 +
 .../testing/selftests/bpf/progs/verifier_subreg.c  |   165 +
 .../testing/selftests/bpf/progs/verifier_unpriv.c  |     6 +-
 .../selftests/bpf/progs/verifier_value_ptr_arith.c |    10 +-
 .../bpf/progs/verifier_xdp_direct_packet_access.c  |    64 +-
 tools/testing/selftests/bpf/test_bpftool.py        |   174 -
 tools/testing/selftests/bpf/test_bpftool.sh        |    11 -
 .../testing/selftests/bpf/test_kmods/bpf_testmod.c |    81 +-
 .../testing/selftests/bpf/test_kmods/bpf_testmod.h |     3 +
 .../selftests/bpf/test_kmods/bpf_testmod_kfunc.h   |     1 +
 tools/testing/selftests/bpf/test_loader.c          |   248 +-
 tools/testing/selftests/bpf/test_progs.c           |    45 +-
 tools/testing/selftests/bpf/test_progs.h           |     1 +
 tools/testing/selftests/bpf/testing_helpers.c      |     9 +-
 tools/testing/selftests/bpf/testing_helpers.h      |     1 +
 tools/testing/selftests/bpf/uprobe_multi.c         |    19 +-
 tools/testing/selftests/bpf/uprobe_multi.ld        |     4 +-
 tools/testing/selftests/bpf/usdt.h                 |     2 +
 tools/testing/selftests/bpf/usdt_1.c               |    18 +
 tools/testing/selftests/bpf/usdt_2.c               |    16 +
 tools/testing/selftests/bpf/verifier/calls.c       |     9 +-
 tools/testing/selftests/bpf/verifier/junk_insn.c   |     6 +-
 tools/testing/selftests/bpf/verifier/sleepable.c   |     2 +-
 tools/testing/selftests/bpf/veristat.c             |   103 +-
 233 files changed, 24746 insertions(+), 14262 deletions(-)
 create mode 100644 arch/s390/kernel/bpf.c
 create mode 100644 kernel/bpf/backtrack.c
 create mode 100644 kernel/bpf/cfg.c
 create mode 100644 kernel/bpf/check_btf.c
 create mode 100644 kernel/bpf/const_fold.c
 create mode 100644 kernel/bpf/fixups.c
 create mode 100644 kernel/bpf/states.c
 delete mode 100644 tools/testing/selftests/bpf/prog_tests/access_variable_array.c
 delete mode 100644 tools/testing/selftests/bpf/prog_tests/align.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/btf_kind.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/btf_sanitize.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/clone_attach_btf_id.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/iter_buf_null_fail.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/lsm_bdev.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/lwt_misc.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/test_struct_ops_multi_args.c
 create mode 100644 tools/testing/selftests/bpf/progs/clone_attach_btf_id.c
 create mode 100644 tools/testing/selftests/bpf/progs/freplace_int_with_void.c
 create mode 100644 tools/testing/selftests/bpf/progs/freplace_void.c
 create mode 100644 tools/testing/selftests/bpf/progs/get_func_args_fsession_test.c
 create mode 100644 tools/testing/selftests/bpf/progs/get_func_ip_fsession_test.c
 create mode 100644 tools/testing/selftests/bpf/progs/iter_buf_null_fail.c
 create mode 100644 tools/testing/selftests/bpf/progs/kprobe_multi_sleepable.c
 create mode 100644 tools/testing/selftests/bpf/progs/lsm_bdev.c
 create mode 100644 tools/testing/selftests/bpf/progs/lwt_misc.c
 create mode 100644 tools/testing/selftests/bpf/progs/rbtree_search_kptr.c
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_multi_args.c
 delete mode 100644 tools/testing/selftests/bpf/progs/test_access_variable_array.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_global_func_deep_stack.c
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_align.c
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_ctx_ptr_param.c
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_liveness_exp.c
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_subprog_topo.c
 delete mode 100644 tools/testing/selftests/bpf/test_bpftool.py
 delete mode 100755 tools/testing/selftests/bpf/test_bpftool.sh
 create mode 100644 tools/testing/selftests/bpf/usdt_1.c
 create mode 100644 tools/testing/selftests/bpf/usdt_2.c
