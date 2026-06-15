Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6759E19F11B
	for <bpf@vger.kernel.org>; Mon, 15 Jun 2026 18:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781546948; cv=none; b=uF/bDEeHILHkUUPSNTbC4XyMSAajvw7AR/IAoOIgb24d67y7q3CshbErSmBt2xIdWUw+UczP/7NYm3per1Qh+ZidjMmJYZ6eDOl6saViNMKYiCbgGN1BPllVsvpbhMbI0WxKNDWL9IfHOqtowbUulr2SluFQWlseMJRAX/x7QC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781546948; c=relaxed/simple;
	bh=9J0BOyPSkMsIFG8enutjLxcUiWkU8SwoydtfV4i0ePo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=D8nu//V2zQP8sdXpfMUVcQew/01POENlVKIIlSaAtPE89yw/B3A7p+Kuq7MZh7ZR7RjdeRyEQJY2joEwaCtX5knTsW58k6f3Nxyh4rRhIN/AUjpqzhRAn61hnaM297WXA3ciJJSnL4pvoixb2i1Wdi2JRY8mga+JIR1NXfsFLac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VSob7iCw; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VSob7iCw"
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-4884c016034so53512b6e.1
        for <bpf@vger.kernel.org>; Mon, 15 Jun 2026 11:09:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781546944; x=1782151744; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eMUH5MZaZuLIIyHKZkg/dSiC6JKbtuEphPKiOLsdEE4=;
        b=VSob7iCw9BcaRSuqJDmE1M3veqrgui20y6kYl0sIKP8AcX+wmvLSwZY496xrzFmOQe
         eXBT9ryqulFaukIezMcfSVWnHoIu1KQqXEeTjSPu61W7Pi0ljjeh6wgUL90PWmetgC7s
         kA8SsQo2t3ihZt7O3l61YV6vfYt63oRUFNZWiPS6ZPDh+sh4pNeL+oNxoIb+a5cPqXqz
         X1NttQDODBDl+qd2kg4v4DL2fupHCTuk6l9hQD0wniK/l6E+IYPqEdFLOkwk4uTgK4eF
         1/Mw6KI+A3jORr85uAHt/6Y9+ugWfdYxt5h0EtSHY7FQpGHHypu1jCeypBtKEsSeU/37
         zT6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781546944; x=1782151744;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eMUH5MZaZuLIIyHKZkg/dSiC6JKbtuEphPKiOLsdEE4=;
        b=QX+K9WapOu986hQJ0sXd71Hx3qrMAsJLB064MMjEr/O23t1pwJ7Ed4/oXpcNrz4nx1
         qoPVoSYyxjalbvGEaW/mLn1B6owCIhdyDqxsB/Iu6GNpL0y/bVNINuowHWxtfQEfcIKY
         nbhfnKzapeCG8zlE3DEP+MJ9/jy3z5WBFG8mHDPIbNbpJw7PnaNL4CYpX0jIsK6HezyC
         B2aYceUElthkVpGVxuOOSOn7kpmJtvV51PhW8pWFzRD3BtMUs5SK6hOwACcZHAfjs/Jh
         R2GFRXsBRmmA2973V2DhPQ4zzpEhIpjdCxiXkUPYeMQFQH/FGtEhaOBbXXnQV2iZiPyH
         A32Q==
X-Gm-Message-State: AOJu0Yx/mLh3jylxxdw69OLuG5MMSXQ6hcU9YvGuQnh7lfwAyP++MEFe
	mXKJCvYPlMN5KW9GhgBeqorsORi46t18EugAckDHYTLOnyTBA/ieU1bV
X-Gm-Gg: Acq92OFyldd+Mkv5JBeOEDjMtZR10IIMxfW7POUqxQ8bC/M6l1QWK0Xw4h5bzp6n7YY
	TBSZbAv7jaHVn9QqpPej1rJITJs5E2WKiTmUedQfkoElBf703/G3yr2uthkak+VE1/FkM5wzDsF
	oWu9oWA3iKvL1vJBmgNQnZR+TywbigZsl1oGt6bguZNXeT8gZ6NxkpU12JcHXhxb5FDBobJ7q8r
	1B1onQG7nBHWaZPvNNbn089ElAUDR3s9ze9zrYCwFT3NDMVBoF4zJaTeBycN+38INBmXTd4KlOL
	dGXbtdBl+QFTA3rLjjGWFcYF3pjqMRuJTPgfeCkRRmWYls9r0kPgrut+kTP6S/4xGXQIpAhtNfe
	Q0X1REQrY+uxXt9KoJBNMq7ZrNNBO+iQBVwMIuyOrKF6TFxyibt/MuPNRrY7LMGfy23coY3CQSO
	M08+AsDf+cV2gwDdNvCjGGToNj5g0dco7MILo6+CcICBkr7YHD7cTVBxXL0dkt1YeXO0P93hVt4
	Ez/d/ShUvNpx0jE5R61QfvnNNm28ZFYDGmfftaQE14+T3xdDNhN1WPF5lhW+w==
X-Received: by 2002:a05:6808:1307:b0:450:bbed:7a75 with SMTP id 5614622812f47-48741ab6e0emr10075677b6e.28.1781546943850;
        Mon, 15 Jun 2026 11:09:03 -0700 (PDT)
Received: from MacBookPro.lan ([2600:6c4e:600:3c6:100c:91d9:c41d:6cb7])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4875dfb4574sm3103480b6e.16.2026.06.15.11.09.01
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 15 Jun 2026 11:09:02 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: torvalds@linux-foundation.org
Cc: bpf@vger.kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	memxor@gmail.com,
	eddyz87@gmail.com,
	tj@kernel.org
Subject: [GIT PULL] BPF changes for 7.2
Date: Mon, 15 Jun 2026 11:08:57 -0700
Message-ID: <20260615180858.15938-1-alexei.starovoitov@gmail.com>
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

The following changes since commit e7ae89a0c97ce2b68b0983cd01eda67cf373517d:

  Linux 7.1-rc5 (2026-05-24 13:48:06 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git tags/bpf-next-7.2

for you to fetch changes up to e4287bf34f97a88c7d9322f5bde828724c073a6b:

  selftests/bpf: Work around llvm stack overflow in crypto progs (2026-06-15 00:19:44 -0700)

----------------------------------------------------------------
There are two conflicts:

trivial merge conflict in include/linux/bpf.h
https://lore.kernel.org/all/aiamrLm8DnCP6dbw@sirena.org.uk/

not so simple merge conflict in kernel/bpf/inode.c
https://lore.kernel.org/all/8906796e-0542-46d2-bb92-9e49642d86dc@iogearbox.net/

Major changes:

- Recover from BPF arena page faults using a scratch page and
  add ptep_try_set() for lockless empty-slot installs on x86 and arm64.
  It allows BPF kfuncs access arena pointers directly.
  The 'arena_direct_access' stable branch was created for this work and
  was pulled into sched-ext and bpf-next trees
  (Tejun Heo, Kumar Kartikeya Dwivedi)

- Lift old restriction and support 6+ arguments in BPF programs and kfuncs
  on x86 and arm64 (Yonghong Song, Puranjay Mohan)

Other features and fixes:

- Add 24-bit BTF vlen and reclaim unused bits in the BTF UAPI to ease
  addition of new BTF kinds (Alan Maguire)

- Raise the maximum BPF call chain depth from 8 to 16 frames
  (Alexei Starovoitov)

- Refactor object relationship tracking in the verifier and fix a
  dynptr use-after-free bug (Amery Hung)

- Harden the signed program loader and reject exclusive maps as inner
  maps (Daniel Borkmann)

- Replace the verifier min/max bounds fields with a circular number
  (cnum) representation and improve 32->64 bit range refinements
  (Eduard Zingerman)

- Introduce the arena library and runtime (libarena) with a buddy
  allocator, rbtree and SPMC queue data structures, ASAN support and a
  parallel test harness. Allow subprograms to return arena pointers and
  switch to a BTF type-tag based __arena annotation (Emil Tsalapatis)

- Cache build IDs in the sleepable stackmap path and avoid faultable
  build ID reads under mm locks (Ihor Solodrai)

- Introduce the tracing_multi link to attach a single BPF program to
  many kernel functions at once. Allow specifying the uprobe_multi
  target via FD (Jiri Olsa)

- Extend the bpf_list family of kfuncs with bpf_list_add/del(),
  and bpf_list_is_first/is_last/empty() (Kaitao Cheng)

- Extend the BPF syscall with common attributes support for prog_load,
  btf_load and map_create (Leon Hwang)

- Wrap rhashtable as BPF map (Mykyta Yatsenko, Herbert Xu)

- Add sleepable support for tracepoint programs and fix deadlocks
  in LRU map due to NMI reentry (Mykyta Yatsenko)

- Fix OOB access in bpf_flow_keys, fix nullness analysis of inner
  arrays, enforce write checks for global subprograms (Nuoqi Gui)

- Report the maximum combined stack depth and print a breakdown of
  instructions processed per subprogram (Paul Chaignon)

- Add an XDP load-balancer benchmark and arm64 JIT support for stack
  arguments (Puranjay Mohan)

- Add kfuncs to traverse over wakeup_sources (Samuel Wu)

- Allow sleepable BPF programs to use LPM trie maps directly
  (Vlad Poenaru)

- Many more fixes and cleanups across the verifier, BTF, sockmap, devmap,
  bpffs, security hooks, s390/riscv/loongarch JITs, rqspinlock, libbpf,
  bpftool, selftests.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
----------------------------------------------------------------
Aaron Tomlin (1):
      libbpf: Report error when a negative kprobe offset is specified

Alan Maguire (7):
      bpf: Extend BTF UAPI vlen, kinds to use unused bits
      libbpf: Adjust btf_vlen() to return a __u32
      bpftool: Support 24-bit vlen
      selftests/bpf: Fix up btf/invalid test for extended kind
      selftests/bpf: Fix up __u16 vlen assumptions
      Documentation/bpf: Update btf doc with updated vlen, kind sizes
      bpf: Export cnum_umin/umax() helpers for netronome driver

Alexei Starovoitov (48):
      Merge branch 'bpf-extend-btf-uapi-vlen-kinds-to-use-unused-bits'
      Merge branch 'bpf-prepare-to-support-stack-arguments'
      Merge branch 'bpf-replace-min-max-fields-with-struct-cnum-32-64'
      Merge branch 'selftests-bpf-use-local-types-for-kfunc-declarations'
      Merge branch 'introduce-arena-library-and-runtime'
      Merge branch 'bpf-range_within-must-check-cnum-ranges-instead-of-min-max-pairs'
      Merge git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf 7.1-rc3
      Merge branch 'selftests-bpf-add-xdp-load-balancer-benchmark'
      Merge branch 'bpf-extend-bpf-syscall-with-common-attributes-support'
      Merge branch 'bpf-support-stack-arguments-for-bpf-functions-and-kfuncs'
      Merge branch 'bpf-maximum-combined-stack-depth'
      Merge branch 'support-bpf-traversal-of-wakeup-sources'
      Merge branch 'bpf-follow-up-fixes-for-stack-argument-support'
      Merge branch 'bpf-follow-up-fixes-for-bpf-syscall-common-attributes'
      Merge branch 'selftests-bpf-xdp-lb-benchmark-fixes'
      Merge branch 'bpf-extend-the-bpf_list-family-of-apis'
      Merge git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf 7.1-rc5
      Merge branch 'arena_direct_access'
      Merge branch 'bpf-align-syscall-writeback-behavior-with-user-declared-size'
      Merge branch 'bpf-arm64-stack-argument-fixes'
      Merge branch 'refactor-verifier-object-relationship-tracking'
      Merge branch 'more-gen_loader-fixes'
      Merge branch 'minimize-annotations-for-arena-programs'
      Merge branch 'more-gen_loader-fixes-2'
      bpf: Take mmap_lock in zap_pages()
      Merge branch 'bpf-introduce-resizable-hash-map'
      Merge branch 'object-relationship-tracking-refactor-followup'
      Merge branch 'selftests-bpf-tolerate-partial-builds-across-kernel-configs'
      Merge branch 'bpf-check-tail-zero-of-bpf_map_info-and-bpf_prog_info'
      Merge branch 'risc-v-jit-support-for-bpf_get_current_task-_btf'
      Merge branch 'bpf-update-transport_header-when-encapsulating-udp-tunnel-in-lwt'
      Merge branch 'bpf-fix-sysctl-new-value-handling-in-__cgroup_bpf_run_filter_sysctl'
      Merge branch 'add-validation-for-bpf_set_retval-helper'
      Merge branch 'selftests-bpf-libarena-add-initial-data-structures'
      Merge branch 'bpf-verifier-fix-ptr_to_flow_keys-constant-offset-oob'
      Merge branch 'bpf-tracing_multi-link'
      Merge branch 'bpf-fix-lru-nmi-tracepoint-re-entry-deadlock'
      Merge branch 'bpf-lpm_trie-allow-sleepable-bpf-programs-to-use-lpm-tries'
      Merge branch 'selftests-bpf-fix-tests-for-llvm23-true-signature'
      Merge branch 'fix-kptr-dtor-deadlock'
      Merge branch 'bpf-fix-generic-devmap-egress-skb-sharing'
      Merge branch 'bpf-fix-setting-retval-to-eperm-for-cgroup-hooks-not-returning-errno'
      bpf: Raise maximum call chain depth to 16 frames
      Merge branch 'bpf-allow-uprobe_multi-binary-specified-by-file-descriptor'
      Merge branch 'tools-build-bpf-append-extra_cflags-and-host_extracflags'
      Merge branch 'bpf-fix-bpf_get-setsockopt-to-tos-for-ipv4-mapped-ipv6-socket'
      Merge branch 'bpf-skmsg-some-fixes-for-skmsg'
      selftests/bpf: Work around llvm stack overflow in crypto progs

Alexis Lothoré (eBPF Foundation) (4):
      selftests/bpf: Fix uprobe_multi usage message
      selftests/bpf: Make btf_dump use xdp_dummy rather than xdping_kern
      selftests/bpf: Drop xdping tool
      selftests/bpf: ignore call depth accounting for retbleed in verifier tests

Amery Hung (21):
      selftests/bpf: Trace bpf_local_storage_update to debug flaky local storage tests
      bpf: Refactor dynptr mutability tracking
      bpf: Simplify mark_stack_slot_obj_read() and callers
      bpf: Unify dynptr handling in the verifier
      bpf: Assign reg->id when getting referenced kptr from ctx
      bpf: Preserve reg->id of pointer objects after null-check
      bpf: Refactor object relationship tracking and fix dynptr UAF bug
      bpf: Remove redundant dynptr arg check for helper
      bpf: Unify referenced object tracking in verifier
      bpf: Unify release handling for helpers and kfuncs
      bpf: Fix dynptr ref counting to scan all call frames
      selftests/bpf: Test creating dynptr from dynptr data and slice
      selftests/bpf: Test using slice after invalidating dynptr clone
      selftests/bpf: Test using file dynptr after the reference on file is dropped
      selftests/bpf: Test using dynptr after freeing the underlying object
      bpf: Silence unused-but-set-variable warning in bpf_for_each_reg_in_vstate_mask
      bpf: Fix dead error check on acquire_reference() in check_kfunc_call
      bpf: Check acquire_reference() error for "__ref" struct_ops arguments
      bpf: Compare parent_id in refsafe() for REF_TYPE_PTR
      bpf: Remove WARN_ON_ONCE in check_ids()
      selftests/bpf: Use bpf_dynptr_slice() to read file dynptr in leak test

Andrii Nakryiko (1):
      Merge branch 'bpf-implement-stack_map_get_build_id_offset_sleepable'

Antoine Tenart (2):
      libbpf: Fix deduplication of typedef with base definitions
      selftests/bpf: Ensure typedef are deduplicated in split BTF

Carlos Llamas (1):
      libbpf: Fix UAF in strset__add_str()

Daniel Borkmann (17):
      libbpf: Drop redundant self-loop in emit_check_err
      libbpf: Skip hash computation when loader generation failed
      libbpf: Also reset {insn,data}_cur on realloc failure
      libbpf: Skip endianness swap when loader generation failed
      bpf: Reject exclusive maps as inner maps in map-in-map
      bpf: Drop redundant hash_buf from map_get_hash operation
      libbpf: Skip initial_value override on signed loaders
      libbpf: Skip max_entries override on signed loaders
      selftests/bpf: Test that exclusive maps are rejected in map-in-map
      bpf: Reject exclusive maps for bpf_map_elem iterators
      libbpf: Guard add_data() against size overflow
      selftests/bpf: Keep verifier_map_ptr exercising ops pointer access
      selftests/bpf: Test that exclusive maps are rejected as iter targets
      selftests/bpf: Cover exclusive map create-time validation
      selftests/bpf: Test signed loader error paths
      selftests/bpf: Inspect the signature verdict exposed to BPF LSM
      bpf: Tighten cgroup storage cookie checks for prog arrays

David Windsor (2):
      bpf: Reject sleepable BPF_LSM_CGROUP programs at load time
      selftests/bpf: Add test for sleepable lsm_cgroup rejection

Dawei Feng (3):
      bpf: NUL-terminate replaced sysctl value
      bpf: use kvfree() for replaced sysctl write buffer
      bpf: Restore sysctl new-value from 1 to 0

Deepanshu Kartikey (1):
      bpf: fix UAF by restoring RCU-delayed inode freeing in bpffs

Eduard Zingerman (6):
      bpf: representation and basic operations on circular numbers
      bpf: use accessor functions for bpf_reg_state min/max fields
      bpf: replace min/max fields with struct cnum{32,64}
      selftests/bpf: new cases handled by 32->64 range refinements
      bpf: range_within() must check cnum ranges instead of min/max pairs
      selftests/bpf: a test for proper cnums compare in is_state_visited()

Emil Tsalapatis (20):
      selftests/bpf: Add ifdef guard for WRITE_ONCE macro in bpf_atomic.h
      selftests/bpf: Add basic libarena scaffolding
      selftests/bpf: Move arena-related headers into libarena
      selftests/bpf: Add arena ASAN runtime to libarena
      selftests/bpf: Add ASAN support for libarena selftests
      selftests/bpf: Add buddy allocator for libarena
      selftests/bpf: Add selftests for libarena buddy allocator
      selftests/bpf: Reuse stderr parsing for libarena ASAN tests
      selftests/bpf: Rename libarena malloc/free methods
      selftests/bpf: libarena: Add "arena" BTF type tag to __arena qualifier
      verifier: parse BTF type tags for function arguments
      bpf: Allow subprogs to return arena pointers
      selftests/bpf: Remove __arg_arena from the codebase
      selftests/bpf: libarena: Directly return arena pointers from functions
      selftests/bpf: Add tests for the new type-tag based __arena identifier
      MAINTAINERS: BPF: Add self as reviewer and run parse_maintainers.pl
      selftests/bpf: libarena: Add rbtree data structure
      selftests/bpf: libarena: Add spmc queue data structure
      selftests/bpf: libarena: parallel test harness and spmc parallel selftest
      selftests/bpf: Avoid spurious spmc parallel selftest errors in libarena

Ethan Nelson-Moore (1):
      selftests/bpf: correct CONFIG_PPC64 macro name in comment

Gabriele Monaco (2):
      rqspinlock: Fix order in raw_res_spin_(un)lock_irq to allow schedule
      selftsets/bpf: Retry map update on helper_fill_hashmap()

Gregory Bell (2):
      selftests/bpf: Use local type for flow_offload_tuple_rhash in xdp_flowtable
      selftests/bpf: Use local type for bpf_fou_encap in test_tunnel_kern

Herbert Xu (1):
      rhashtable: Use irq work for shrinking

Ian Rogers (1):
      bpftool: Restrict feature tests during bootstrap compilation

Ihor Solodrai (4):
      selftests/bpf: Use both hrtimer enqueue helpers in vmlinux test
      bpf: Factor out stack_map build ID helpers
      bpf: Avoid faultable build ID reads under mm locks
      bpf: Cache build IDs in sleepable stackmap path

Jakub Sitnicki (1):
      bpf: Add Jiayuan Chen to sockmap maintainers

Jerome Marchand (1):
      selftests/bpf: Page out as late as possible in file_reader

Jie Meng (1):
      bpf: Exhaustive test coverage for signed division and modulo

Jiri Olsa (37):
      bpf: Remove obsolete WARN_ON call
      ftrace: Add ftrace_hash_count function
      ftrace: Add ftrace_hash_remove function
      ftrace: Add add_ftrace_hash_entry function
      bpf: Use mutex lock pool for bpf trampolines
      bpf: Add struct bpf_trampoline_ops object
      bpf: Move trampoline image setup into bpf_trampoline_ops callbacks
      bpf: Add bpf_trampoline_add/remove_prog functions
      bpf: Add struct bpf_tramp_node object
      bpf: Factor fsession link to use struct bpf_tramp_node
      bpf: Add multi tracing attach types
      bpf: Move sleepable verification code to btf_id_allow_sleepable
      bpf: Add bpf_trampoline_multi_attach/detach functions
      bpf: Add support for tracing multi link
      bpf: Add support for tracing_multi link cookies
      bpf: Add support for tracing_multi link session
      bpf: Add support for tracing_multi link fdinfo
      libbpf: Add bpf_object_cleanup_btf function
      libbpf: Add bpf_link_create support for tracing_multi link
      libbpf: Add btf_type_is_traceable_func function
      libbpf: Add support to create tracing multi link
      selftests/bpf: Add tracing multi skel/pattern/ids attach tests
      selftests/bpf: Add tracing multi skel/pattern/ids module attach tests
      selftests/bpf: Add tracing multi intersect tests
      selftests/bpf: Add tracing multi cookies test
      selftests/bpf: Add tracing multi session test
      selftests/bpf: Add tracing multi attach fails test
      selftests/bpf: Add tracing multi verifier fails test
      selftests/bpf: Add tracing multi attach benchmark test
      selftests/bpf: Add tracing multi attach rollback tests
      bpf: Guard __get_user acesss with access_ok for uprobe_multi data
      bpf: Use user_path_at for path resolution in uprobe_multi
      bpf: Add support to specify uprobe_multi target via file descriptor
      libbpf: Add path_fd to struct bpf_link_create_opts
      selftests/bpf: Add uprobe_multi path_fd test
      selftests/bpf: Add uprobe_multi path_fd fail tests
      selftests/bpf: Fix typo in verify_umulti_link_info

Justin Suess (2):
      bpf: Reject bpf_obj_drop() from tracing progs
      bpf: Cancel special fields on map value recycle

KP Singh (3):
      libbpf: Reject non-exclusive metadata maps in the signed loader
      selftests/bpf: Adjust verifier_map_ptr for the map's excl field
      bpf: Expose signature verdict via bpf_prog_aux

Kaitao Cheng (9):
      bpf: refactor __bpf_list_del to take list node pointer
      bpf: clear list node owner and unlink before drop
      bpf: allow non-owning list-node args via __nonown_allowed
      bpf: Introduce the bpf_list_del kfunc.
      bpf: refactor __bpf_list_add to take insertion point via **prev_ptr
      bpf: Add bpf_list_add to insert node after a given list node
      bpf: add bpf_list_is_first/last/empty kfuncs
      selftests/bpf: Add test cases for bpf_list_del/add/is_first/is_last/empty
      bpf: Clear rb node linkage when freeing bpf_rb_root

Kees Cook (1):
      libbpf: Use strscpy() in kernel code for skel_map_create()

Kumar Kartikeya Dwivedi (6):
      Merge branch 'bpf-add-support-for-sleepable-tracepoint-programs'
      bpf: Recover arena kernel faults with scratch page
      Merge branch 'keep-dynamic-inner-array-lookups-nullable'
      Merge branch 'bpf-enforce-btf-pointer-write-checks-for-global-args'
      selftests/bpf: Exercise unsafe obj drops from tracing progs
      selftests/bpf: Exercise kptr map update lifetime

Kuniyuki Iwashima (1):
      sockmap: Fix use-after-free in udp_bpf_recvmsg()

Leo Yan (8):
      bpftool: Pass host flags to bootstrap libbpf
      bpftool: Avoid adding EXTRA_CFLAGS to HOST_CFLAGS
      bpftool: Append extra host flags
      libbpf: Initialize CFLAGS before including Makefile.include
      tools/bpf: build: Append extra cflags
      selftests/bpf: Initialize operation name before use
      selftests/bpf: Use common CFLAGS for urandom_read
      selftests/bpf: Avoid static LLVM linking for cross builds

Leon Hwang (20):
      bpf: Extend BPF syscall with common attributes support
      libbpf: Add support for extended BPF syscall
      bpf: Refactor reporting log_true_size for prog_load
      bpf: Add syscall common attributes support for prog_load
      bpf: Add syscall common attributes support for btf_load
      bpf: Add syscall common attributes support for map_create
      libbpf: Add syscall common attributes support for map_create
      selftests/bpf: Add tests to verify map create failure log
      bpf: Check tail zero of bpf_common_attr using offsetofend
      libbpf: Add OPTS_VALID() for log_opts in bpf_map_create
      selftests/bpf: Use -1 as token_fd in map create failure test
      selftests/bpf: Add test to verify checking padding bytes for BPF syscall common attributes
      bpf: Fix race between bpf_map_new_fd() and close_fd()
      bpf: Check tail zero of bpf_map_info
      bpf: Check tail zero of bpf_prog_info
      selftests/bpf: Add tests to verify checking padding bytes for bpf_[map,prog]_info
      bpf: Update transport_header when encapsulating UDP tunnel in lwt
      selftests/bpf: Add tests to verify the fix of encapsulating VxLAN in lwt
      bpf: Fix bpf_get/setsockopt to tos for ipv4-mapped ipv6 socket
      selftests/bpf: Add test to verify the fix for bpf_setsockopt() helper

Lin Ma (1):
      selftests/bpf: Cover tail-call cgroup storage prog-array checks

Martin KaFai Lau (2):
      Merge branch 'selftests-bpf-drop-xdping-tool'
      bpf: Update bpf maintainers

Matt Bobrowski (2):
      selftests/bpf: Fix off-by-one in bpf_cpumask_populate related selftest
      bpf: clean up btf_scan_decl_tags()

Maxim Khmelevskii (1):
      s390/bpf: Inline smp_processor_id and current_task

Michael Bommarito (1):
      libbpf: Harden parse_vma_segs() path parsing

Mykyta Yatsenko (22):
      bpf: Add sleepable support for raw tracepoint programs
      bpf: Add bpf_prog_run_array_sleepable()
      bpf: Add sleepable support for classic tracepoint programs
      bpf: Verifier support for sleepable tracepoint programs
      libbpf: Add section handlers for sleepable tracepoints
      selftests/bpf: Add tests for sleepable tracepoint programs
      rhashtable: Add rhashtable_next_key() API
      rhashtable: Add selftest for rhashtable_next_key()
      bpf: Implement resizable hashmap basic functions
      bpf: Implement iteration ops for resizable hashtab
      bpf: Allow special fields in resizable hashtab
      bpf: Optimize word-sized keys for resizable hashtable
      libbpf: Support resizable hashtable
      selftests/bpf: Add basic tests for resizable hash map
      selftests/bpf: Add BPF iterator tests for resizable hash map
      bpftool: Add rhash map documentation
      selftests/bpf: Add resizable hashmap to benchmarks
      selftests/bpf: Fix flaky file_reader test
      rhashtable: Fix rhashtable_next_key() build warnings
      bpf: Fix NMI/tracepoint re-entry deadlock on lru locks
      Documentation/bpf: Refresh map_lru_hash_update.dot for rqspinlock
      selftests/bpf: Stress LRU rqspinlock recovery paths

Nuoqi Gui (6):
      bpf: Fold reg->var_off into PTR_TO_FLOW_KEYS bounds check
      selftests/bpf: add tests for PTR_TO_FLOW_KEYS offset bounds
      bpf: Keep dynamic inner array lookups nullable
      selftests/bpf: Cover dynamic inner array lookup nullability
      bpf: Enforce write checks for BTF pointer helper access
      selftests/bpf: Cover writable BTF field global subprog args

Paul Chaignon (7):
      bpf: Print breakdown of insns processed by subprogs
      selftests/bpf: Test insns processed breakdown
      bpf: Report maximum combined stack depth
      selftests/bpf: Test reported max stack depth
      veristat: Report max stack depth
      selftests/bpf: Override EXTRA_LDFLAGS for static builds
      selftests/bpf: Fix test for refinement of single-value tnum

Paul Moore (1):
      bpf: Fix security_bpf_prog_load() error handling

Paul Moses (2):
      bpf: Validate BTF repeated field counts before expansion
      selftests/bpf: Add BTF repeated field count overflow test

Puranjay Mohan (15):
      selftests/bpf: Add bench_force_done() for early benchmark completion
      selftests/bpf: Add BPF batch-timing library
      selftests/bpf: Add bpf-nop benchmark for timing overhead baseline
      selftests/bpf: Add XDP load-balancer common definitions
      selftests/bpf: Add XDP load-balancer BPF program
      selftests/bpf: Add XDP load-balancer benchmark driver
      selftests/bpf: Add XDP load-balancer benchmark run script
      bpf, arm64: Map BPF_REG_0 to x8 instead of x7
      bpf, arm64: Add JIT support for stack arguments
      selftests/bpf: Enable stack argument tests for arm64
      selftests/bpf: Fix cold_lru producing zero batch_hash in XDP LB benchmark
      selftests/bpf: Fix expired UDP LRU entries in XDP LB benchmark
      selftests/bpf: Filter timing outliers with IQR in batch-timing library
      bpf, arm64: Fix redundant MOV and clarify stack arg comments
      selftests/bpf: Use at least 10 args in stack argument tests

Ricardo B. Marlière (11):
      selftests/bpf: Add BPF_STRICT_BUILD toggle
      selftests/bpf: Fix test_kmods KDIR to honor O= and distro kernels
      selftests/bpf: Tolerate BPF and skeleton generation failures
      selftests/bpf: Avoid rebuilds when running emit_tests
      selftests/bpf: Make skeleton headers order-only prerequisites of .test.d
      selftests/bpf: Tolerate test file compilation failures
      selftests/bpf: Skip tests whose objects were not built
      selftests/bpf: Allow test_progs to link with a partial object set
      selftests/bpf: Tolerate benchmark build failures
      selftests/bpf: Provide weak definitions for cross-test functions
      selftests/bpf: Tolerate missing files during install

Roman Kvasnytskyi (1):
      selftests/bpf: Reject unsupported -k option in vmtest.sh

Samuel Wu (2):
      PM: wakeup: Add kfuncs to traverse over wakeup_sources
      selftests/bpf: Add tests for wakeup_sources kfuncs

Sean Young (1):
      selftests/bpf: Fix test_lirc test

Sechang Lim (3):
      bpf: Fix NULL pointer dereference in bpf_task_from_vpid()
      bpf, sockmap: fix integer overflow in bpf_msg_pop_data() bounds check
      selftests/bpf: add test for bpf_msg_pop_data() overflow

Siddharth Nayyar (1):
      bpftool: Fix typo in struct_ops map FD generation for light skeleton

Song Chen (1):
      bpf: Reject registration of duplicated kfunc

Suchit Karunakaran (1):
      bpf: replace pop/push emptiness check with bpf_list_empty()

Sun Jian (2):
      bpf: Run generic devmap egress prog on private skb
      selftests/bpf: Cover generic devmap egress last-dst rewrite

Taegu Ha (1):
      bpf: reject overlarge global subprog argument sizes

Tejun Heo (8):
      mm: Add ptep_try_set() for lockless empty-slot installs
      bpf: Add sleepable variant of bpf_arena_alloc_pages for kernel callers
      bpf: Add bpf_struct_ops_for_each_prog()
      bpf/arena: Add bpf_arena_map_kern_vm_start() and bpf_prog_arena()
      bpf: Fix bpf_arena_handle_page_fault() redefinition without CONFIG_BPF_SYSCALL
      bpf: Replace scratch PTE atomically when allocating arena pages
      arm64: mm: Complete the PTE store in ptep_try_set()
      arm64: mm: Remove misleading pte_none() comment from ptep_try_set()

Tiezhu Yang (1):
      libbpf: Add __NR_bpf definition for LoongArch

Varun R Mallya (2):
      selftests/bpf: use host CPU features in JIT disassembler
      bpf, riscv: inline bpf_get_current_task() and bpf_get_current_task_btf()

Vlad Poenaru (2):
      bpf: Allow LPM map access from sleepable BPF programs
      bpf: Allow sleepable programs to use LPM trie maps directly

Weiming Shi (2):
      bpf, sockmap: reject overflowing copy + len in bpf_msg_push_data()
      bpf, sockmap: Fix wrong rsge offset in bpf_msg_push_data()

Woojin Ji (2):
      bpftool: Use libbpf error code for flow dissector query
      selftests/bpf: Add arena direct-value one-past-end reject test

Xu Kuohai (5):
      selftests/bpf: Restrict bpf_set_retval argument in sk_bypass_prot_mem
      bpf: Add validation for bpf_set_retval argument
      selftests/bpf: Add tests for bpf_set_retval validation
      bpf: Fix setting retval to -EPERM for cgroup hooks not returning errno
      selftests/bpf: Add retval test for bool and errno LSM cgroup hooks

Yonghong Song (41):
      bpf: Remove unused parameter from check_map_kptr_access()
      bpf: Fix tail_call_reachable leak
      bpf: Remove WARN_ON_ONCE in check_kfunc_mem_size_reg()
      bpf: Refactor to avoid redundant calculation of bpf_reg_state
      bpf: Refactor to handle memory and size together
      bpf: Rename existing argno to arg
      bpf: Prepare verifier logs for upcoming kfunc stack arguments
      bpf: Introduce bpf register BPF_REG_PARAMS
      bpf: Reuse MAX_BPF_FUNC_ARGS for maximum number of arguments
      bpf: Convert bpf_get_spilled_reg macro to static inline function
      bpf: Remove copy_register_state wrapper function
      bpf: Add helper functions for r11-based stack argument insns
      bpf: Set sub->arg_cnt earlier in btf_prepare_func_args()
      bpf: Support stack arguments for bpf functions
      bpf: Refactor jmp history to use dedicated spi/frame fields
      bpf: Add precision marking and backtracking for stack argument slots
      bpf: Refactor record_call_access() to extract per-arg logic
      bpf: Use arg_is_fp() in has_fp_args()
      bpf: Extend liveness analysis to track stack argument slots
      bpf: Reject stack arguments in non-JITed programs
      bpf: Prepare architecture JIT support for stack arguments
      bpf: Enable r11 based insns
      bpf: Support stack arguments for kfunc calls
      bpf: Reject stack arguments if tail call reachable
      bpf: Disable private stack for x86_64 if stack arguments used
      bpf,x86: Implement JIT support for stack arguments
      selftests/bpf: Add tests for BPF function stack arguments
      selftests/bpf: Add tests for stack argument validation
      selftests/bpf: Add BTF fixup for __naked subprog parameter names
      selftests/bpf: Add verifier tests for stack argument validation
      selftests/bpf: Add precision backtracking test for stack arguments
      bpf: Validate outgoing stack args when btf_prepare_func_args fails
      selftests/bpf: Add test for stack arg read without caller write
      selftests/bpf: Log arg_track_join for stack arg slots in liveness analysis
      bpf: Fix arg_track_join log to use sa prefix for stack arg slots
      bpf: Clean up redundant stack arg checks for non-JITed programs
      bpf,x86: Fix exception unwinding with outgoing stack arguments
      selftests/bpf: Add exception tests with stack arguments
      selftests/bpf: Keep int return type for tailcall subprogs
      selftests/bpf: Adjust fexit_bpf2bpf ctx layout for llvm23 true signature
      selftests/bpf: Fix bpf_iter/task_vma test

Yuyang Huang (2):
      bpf: fix BPF_PROG_QUERY OOB write and cgroup backward compat
      selftests/bpf: add verification for BPF_PROG_QUERY attr size boundaries

Zhang Cen (1):
      bpf, sockmap: keep sk_msg copy state in sync

Zhao Zhang (1):
      bpf: Reject fragmented frames in devmap

 Documentation/bpf/btf.rst                          |    6 +-
 Documentation/bpf/kfuncs.rst                       |   36 +-
 Documentation/bpf/map_lru_hash_update.dot          |   44 +-
 MAINTAINERS                                        |   34 +-
 arch/arm64/include/asm/pgtable.h                   |   28 +
 arch/arm64/mm/fault.c                              |   10 +-
 arch/arm64/net/bpf_jit_comp.c                      |  152 +-
 arch/arm64/net/bpf_timed_may_goto.S                |    8 +-
 arch/loongarch/net/bpf_jit.c                       |   52 +-
 arch/powerpc/net/bpf_jit_comp.c                    |   54 +-
 arch/riscv/net/bpf_jit_comp64.c                    |   61 +-
 arch/s390/net/bpf_jit_comp.c                       |   81 +-
 arch/x86/include/asm/pgtable.h                     |   12 +
 arch/x86/mm/fault.c                                |   12 +-
 arch/x86/net/bpf_jit_comp.c                        |  205 +-
 drivers/base/power/power.h                         |    7 +
 drivers/base/power/wakeup.c                        |   71 +-
 drivers/net/ethernet/netronome/nfp/bpf/verifier.c  |    8 +-
 fs/bpf_fs_kfuncs.c                                 |    2 +-
 fs/verity/measure.c                                |    4 +-
 include/asm-generic/rqspinlock.h                   |   14 +-
 include/linux/bpf-cgroup.h                         |    5 +-
 include/linux/bpf.h                                |  282 +-
 include/linux/bpf_defs.h                           |   19 +
 include/linux/bpf_lsm.h                            |    6 +
 include/linux/bpf_types.h                          |    2 +
 include/linux/bpf_verifier.h                       |  301 +-
 include/linux/btf.h                                |    7 +-
 include/linux/btf_ids.h                            |    1 +
 include/linux/cnum.h                               |   82 +
 include/linux/filter.h                             |   27 +-
 include/linux/ftrace.h                             |    9 +
 include/linux/pgtable.h                            |   43 +
 include/linux/rhashtable.h                         |    4 +-
 include/linux/syscalls.h                           |    3 +-
 include/linux/trace_events.h                       |   12 +
 include/trace/bpf_probe.h                          |    2 -
 include/uapi/linux/bpf.h                           |   32 +-
 include/uapi/linux/btf.h                           |   26 +-
 kernel/bpf/Makefile                                |    2 +-
 kernel/bpf/arena.c                                 |  315 +-
 kernel/bpf/arraymap.c                              |   14 +-
 kernel/bpf/backtrack.c                             |   82 +-
 kernel/bpf/bpf_lru_list.c                          |  165 +-
 kernel/bpf/bpf_lru_list.h                          |   25 +-
 kernel/bpf/bpf_lsm.c                               |   20 +
 kernel/bpf/bpf_struct_ops.c                        |   63 +-
 kernel/bpf/btf.c                                   |  318 +-
 kernel/bpf/cgroup.c                                |   65 +-
 kernel/bpf/cnum.c                                  |  120 +
 kernel/bpf/cnum_defs.h                             |  247 ++
 kernel/bpf/const_fold.c                            |    8 +
 kernel/bpf/core.c                                  |   27 +-
 kernel/bpf/devmap.c                                |   19 +
 kernel/bpf/fixups.c                                |   27 +-
 kernel/bpf/hashtab.c                               |  840 +++-
 kernel/bpf/helpers.c                               |  204 +-
 kernel/bpf/inode.c                                 |   13 +-
 kernel/bpf/liveness.c                              |  183 +-
 kernel/bpf/log.c                                   |  132 +-
 kernel/bpf/lpm_trie.c                              |    8 +-
 kernel/bpf/map_in_map.c                            |    5 +-
 kernel/bpf/map_iter.c                              |    7 +-
 kernel/bpf/stackmap.c                              |  215 +-
 kernel/bpf/states.c                                |   67 +-
 kernel/bpf/syscall.c                               |  312 +-
 kernel/bpf/trampoline.c                            |  671 +++-
 kernel/bpf/verifier.c                              | 4174 ++++++++++----------
 kernel/events/core.c                               |    9 +
 kernel/trace/bpf_trace.c                           |  334 +-
 kernel/trace/ftrace.c                              |   35 +-
 kernel/trace/trace_syscalls.c                      |  110 +-
 lib/rhashtable.c                                   |  102 +
 lib/test_bpf.c                                     |  363 +-
 lib/test_rhashtable.c                              |   75 +
 net/bpf/bpf_dummy_struct_ops.c                     |   14 +-
 net/bpf/test_run.c                                 |   68 +-
 net/core/filter.c                                  |  112 +-
 net/core/lwt_bpf.c                                 |   12 +
 net/ipv4/udp_bpf.c                                 |    9 +
 tools/bpf/Makefile                                 |    1 +
 tools/bpf/bpftool/Documentation/bpftool-map.rst    |    2 +-
 tools/bpf/bpftool/Makefile                         |   20 +-
 tools/bpf/bpftool/btf.c                            |   17 +-
 tools/bpf/bpftool/btf_dumper.c                     |    4 +-
 tools/bpf/bpftool/gen.c                            |   18 +-
 tools/bpf/bpftool/map.c                            |    2 +-
 tools/bpf/bpftool/net.c                            |    4 +-
 tools/build/feature/test-bpf.c                     |    2 +
 tools/include/uapi/linux/bpf.h                     |   33 +-
 tools/include/uapi/linux/btf.h                     |   26 +-
 tools/lib/bpf/Makefile                             |   17 +-
 tools/lib/bpf/bpf.c                                |   67 +-
 tools/lib/bpf/bpf.h                                |   25 +-
 tools/lib/bpf/btf.c                                |   54 +-
 tools/lib/bpf/btf.h                                |    2 +-
 tools/lib/bpf/btf_dump.c                           |   24 +-
 tools/lib/bpf/features.c                           |    8 +
 tools/lib/bpf/gen_loader.c                         |   92 +-
 tools/lib/bpf/libbpf.c                             |  473 ++-
 tools/lib/bpf/libbpf.h                             |   15 +
 tools/lib/bpf/libbpf.map                           |    1 +
 tools/lib/bpf/libbpf_internal.h                    |    4 +
 tools/lib/bpf/libbpf_probes.c                      |    3 +
 tools/lib/bpf/relo_core.c                          |   16 +-
 tools/lib/bpf/skel_internal.h                      |    5 +
 tools/lib/bpf/strset.c                             |   62 +-
 tools/lib/bpf/usdt.c                               |   16 +-
 tools/testing/selftests/bpf/.gitignore             |    1 -
 tools/testing/selftests/bpf/Makefile               |  267 +-
 tools/testing/selftests/bpf/README.rst             |    2 +-
 tools/testing/selftests/bpf/bench.c                |   26 +-
 tools/testing/selftests/bpf/bench.h                |    1 +
 tools/testing/selftests/bpf/bench_bpf_timing.h     |   50 +
 .../bpf/benchs/bench_bpf_hashmap_full_update.c     |   34 +-
 .../bpf/benchs/bench_bpf_hashmap_lookup.c          |   31 +-
 tools/testing/selftests/bpf/benchs/bench_bpf_nop.c |   84 +
 .../selftests/bpf/benchs/bench_bpf_timing.c        |  298 ++
 .../testing/selftests/bpf/benchs/bench_htab_mem.c  |   35 +-
 tools/testing/selftests/bpf/benchs/bench_xdp_lb.c  | 1124 ++++++
 .../selftests/bpf/benchs/run_bench_xdp_lb.sh       |   79 +
 tools/testing/selftests/bpf/bpf_arena_alloc.h      |    2 +-
 tools/testing/selftests/bpf/bpf_arena_htab.h       |   11 +-
 tools/testing/selftests/bpf/bpf_arena_list.h       |    2 +-
 tools/testing/selftests/bpf/bpf_arena_strsearch.h  |    6 +-
 tools/testing/selftests/bpf/bpf_experimental.h     |   84 +-
 tools/testing/selftests/bpf/bpf_kfuncs.h           |    8 +-
 tools/testing/selftests/bpf/config                 |    3 +-
 tools/testing/selftests/bpf/default.profraw        |  Bin 0 -> 160 bytes
 tools/testing/selftests/bpf/jit_disasm_helpers.c   |   13 +-
 tools/testing/selftests/bpf/libarena/Makefile      |   92 +
 .../bpf/{ => libarena/include}/bpf_arena_common.h  |    5 +-
 .../include}/bpf_arena_spin_lock.h                 |   17 +-
 .../bpf/{ => libarena/include}/bpf_atomic.h        |    4 +-
 .../selftests/bpf/libarena/include/bpf_may_goto.h  |   84 +
 .../selftests/bpf/libarena/include/libarena/asan.h |  101 +
 .../bpf/libarena/include/libarena/buddy.h          |   81 +
 .../bpf/libarena/include/libarena/common.h         |   93 +
 .../bpf/libarena/include/libarena/rbtree.h         |   83 +
 .../selftests/bpf/libarena/include/libarena/spmc.h |   27 +
 .../bpf/libarena/include/libarena/userspace.h      |  138 +
 .../bpf/libarena/selftests/st_asan_buddy.bpf.c     |  258 ++
 .../bpf/libarena/selftests/st_asan_common.h        |   52 +
 .../bpf/libarena/selftests/st_buddy.bpf.c          |  209 +
 .../libarena/selftests/test_parallel_spmc.bpf.c    |  669 ++++
 .../bpf/libarena/selftests/test_progs_compat.h     |   15 +
 .../bpf/libarena/selftests/test_rbtree.bpf.c       |  968 +++++
 .../bpf/libarena/selftests/test_spmc.bpf.c         |  194 +
 .../testing/selftests/bpf/libarena/src/asan.bpf.c  |  553 +++
 .../testing/selftests/bpf/libarena/src/buddy.bpf.c |  903 +++++
 .../selftests/bpf/libarena/src/common.bpf.c        |   52 +
 .../selftests/bpf/libarena/src/rbtree.bpf.c        | 1047 +++++
 .../testing/selftests/bpf/libarena/src/spmc.bpf.c  |  234 ++
 .../selftests/bpf/prog_tests/arena_direct_value.c  |   73 +
 .../selftests/bpf/prog_tests/arena_spin_lock.c     |    7 -
 .../selftests/bpf/prog_tests/bpf_attr_size.c       |  124 +
 .../testing/selftests/bpf/prog_tests/bpf_cookie.c  |   17 +-
 tools/testing/selftests/bpf/prog_tests/bpf_nf.c    |   22 +-
 tools/testing/selftests/bpf/prog_tests/bpf_qdisc.c |    8 +
 tools/testing/selftests/bpf/prog_tests/btf.c       |   45 +-
 .../selftests/bpf/prog_tests/btf_dedup_split.c     |   51 +-
 tools/testing/selftests/bpf/prog_tests/btf_dump.c  |    4 +-
 tools/testing/selftests/bpf/prog_tests/cb_refs.c   |    4 +-
 .../selftests/bpf/prog_tests/cgrp_local_storage.c  |   15 +-
 .../testing/selftests/bpf/prog_tests/ctx_rewrite.c |   17 +-
 .../testing/selftests/bpf/prog_tests/exceptions.c  |    7 +
 .../testing/selftests/bpf/prog_tests/file_reader.c |   22 +-
 .../selftests/bpf/prog_tests/fill_link_info.c      |    2 +-
 .../testing/selftests/bpf/prog_tests/htab_update.c |    4 +-
 tools/testing/selftests/bpf/prog_tests/iters.c     |    2 -
 .../testing/selftests/bpf/prog_tests/kfunc_call.c  |    2 +-
 tools/testing/selftests/bpf/prog_tests/libarena.c  |  253 ++
 .../selftests/bpf/prog_tests/libarena_asan.c       |   93 +
 .../testing/selftests/bpf/prog_tests/linked_list.c |   37 +-
 .../selftests/bpf/prog_tests/lru_lock_nmi.c        |  243 ++
 .../testing/selftests/bpf/prog_tests/lsm_cgroup.c  |   79 +
 .../selftests/bpf/prog_tests/lwt_ip_encap.c        |  145 +
 tools/testing/selftests/bpf/prog_tests/map_excl.c  |  122 +
 tools/testing/selftests/bpf/prog_tests/map_init.c  |  192 +
 tools/testing/selftests/bpf/prog_tests/map_kptr.c  |   66 +-
 .../selftests/bpf/prog_tests/refcounted_kptr.c     |    8 +-
 .../testing/selftests/bpf/prog_tests/reg_bounds.c  |   90 +-
 tools/testing/selftests/bpf/prog_tests/rhash.c     |  183 +
 .../selftests/bpf/prog_tests/setget_sockopt.c      |   78 +
 .../selftests/bpf/prog_tests/signed_loader.c       | 1135 ++++++
 .../bpf/prog_tests/sleepable_tracepoints.c         |  142 +
 .../selftests/bpf/prog_tests/sockmap_basic.c       |   48 +
 tools/testing/selftests/bpf/prog_tests/spin_lock.c |    4 +-
 tools/testing/selftests/bpf/prog_tests/stack_arg.c |  139 +
 .../selftests/bpf/prog_tests/stack_arg_fail.c      |   10 +
 .../selftests/bpf/prog_tests/stack_arg_precision.c |   10 +
 tools/testing/selftests/bpf/prog_tests/tailcalls.c |  186 +
 .../testing/selftests/bpf/prog_tests/task_kfunc.c  |   42 +-
 .../selftests/bpf/prog_tests/task_local_storage.c  |    1 +
 tools/testing/selftests/bpf/prog_tests/test_lsm.c  |   22 -
 .../selftests/bpf/prog_tests/test_xdp_veth.c       |  166 +-
 .../selftests/bpf/prog_tests/tracing_multi.c       |  960 +++++
 .../selftests/bpf/prog_tests/uprobe_multi_test.c   |   94 +-
 tools/testing/selftests/bpf/prog_tests/verifier.c  |    8 +
 .../selftests/bpf/prog_tests/verifier_log.c        |    1 +
 tools/testing/selftests/bpf/prog_tests/vmlinux.c   |   45 +-
 .../selftests/bpf/prog_tests/wakeup_source.c       |  118 +
 tools/testing/selftests/bpf/progs/arena_atomics.c  |    2 +-
 .../testing/selftests/bpf/progs/arena_spin_lock.c  |    3 +-
 .../selftests/bpf/progs/bench_bpf_timing.bpf.h     |   69 +
 .../selftests/bpf/progs/bpf_iter_bpf_rhash_map.c   |   34 +
 .../selftests/bpf/progs/bpf_iter_task_vmas.c       |    2 +-
 tools/testing/selftests/bpf/progs/bpf_misc.h       |    1 +
 tools/testing/selftests/bpf/progs/bpf_nop_bench.c  |   14 +
 .../bpf_qdisc_dynptr_use_after_invalidate_clone.c  |   74 +
 .../bpf/progs/bpf_qdisc_fail__invalid_dynptr.c     |   68 +
 .../bpf_qdisc_fail__invalid_dynptr_cross_frame.c   |   74 +
 .../progs/bpf_qdisc_fail__invalid_dynptr_slice.c   |   70 +
 tools/testing/selftests/bpf/progs/bpf_qdisc_fq.c   |   11 +-
 .../selftests/bpf/progs/btf__stack_arg_precision.c |   24 +
 .../bpf/progs/btf__verifier_stack_arg_order.c      |   49 +
 .../selftests/bpf/progs/cgrp_kfunc_failure.c       |   18 +-
 .../selftests/bpf/progs/cgrp_ls_sleepable.c        |   18 +
 .../selftests/bpf/progs/compute_live_registers.c   |    2 +-
 .../testing/selftests/bpf/progs/cpumask_failure.c  |   10 +-
 .../testing/selftests/bpf/progs/cpumask_success.c  |    2 +-
 tools/testing/selftests/bpf/progs/crypto_bench.c   |   21 +-
 tools/testing/selftests/bpf/progs/crypto_sanity.c  |   21 +-
 tools/testing/selftests/bpf/progs/dynptr_fail.c    |   74 +-
 tools/testing/selftests/bpf/progs/dynptr_success.c |    6 +-
 tools/testing/selftests/bpf/progs/exceptions.c     |  114 +
 tools/testing/selftests/bpf/progs/fexit_bpf2bpf.c  |   13 +-
 tools/testing/selftests/bpf/progs/file_reader.c    |    2 +-
 .../testing/selftests/bpf/progs/file_reader_fail.c |   64 +-
 tools/testing/selftests/bpf/progs/htab_update.c    |    4 +-
 tools/testing/selftests/bpf/progs/irq.c            |    4 +-
 tools/testing/selftests/bpf/progs/iters.c          |    6 +-
 .../selftests/bpf/progs/iters_state_safety.c       |   18 +-
 tools/testing/selftests/bpf/progs/iters_testmod.c  |    4 +-
 .../selftests/bpf/progs/iters_testmod_seq.c        |   16 +-
 tools/testing/selftests/bpf/progs/linked_list.c    |   71 +
 tools/testing/selftests/bpf/progs/lpm_trie_bench.c |    2 +-
 tools/testing/selftests/bpf/progs/lru_lock_nmi.c   |   33 +
 tools/testing/selftests/bpf/progs/lsm_cgroup.c     |   30 +
 tools/testing/selftests/bpf/progs/map_kptr.c       |   89 +-
 tools/testing/selftests/bpf/progs/map_kptr_fail.c  |    4 +-
 .../selftests/bpf/progs/percpu_alloc_fail.c        |    4 +-
 tools/testing/selftests/bpf/progs/rbtree_fail.c    |    6 +-
 .../testing/selftests/bpf/progs/refcounted_kptr.c  |  441 ++-
 .../selftests/bpf/progs/refcounted_kptr_fail.c     |    2 +-
 tools/testing/selftests/bpf/progs/rhash.c          |  248 ++
 tools/testing/selftests/bpf/progs/setget_sockopt.c |   23 +
 .../selftests/bpf/progs/sk_bypass_prot_mem.c       |    2 +
 tools/testing/selftests/bpf/progs/stack_arg.c      |  273 ++
 tools/testing/selftests/bpf/progs/stack_arg_fail.c |  114 +
 .../testing/selftests/bpf/progs/stack_arg_kfunc.c  |  166 +
 .../selftests/bpf/progs/stack_arg_precision.c      |  135 +
 tools/testing/selftests/bpf/progs/stream.c         |    2 +-
 tools/testing/selftests/bpf/progs/stream_fail.c    |    2 +-
 .../selftests/bpf/progs/tailcall_bpf2bpf2.c        |    5 +-
 .../bpf/progs/tailcall_bpf2bpf_hierarchy1.c        |   13 +-
 .../bpf/progs/tailcall_bpf2bpf_hierarchy2.c        |   24 +-
 .../bpf/progs/tailcall_bpf2bpf_hierarchy3.c        |   13 +-
 .../bpf/progs/tailcall_bpf2bpf_hierarchy_fentry.c  |   13 +-
 .../selftests/bpf/progs/tailcall_cgrp_storage.c    |   44 +
 .../bpf/progs/tailcall_cgrp_storage_no_storage.c   |   26 +
 .../bpf/progs/tailcall_cgrp_storage_owner.c        |   32 +
 .../selftests/bpf/progs/task_kfunc_failure.c       |   62 +-
 .../selftests/bpf/progs/task_kfunc_success.c       |   13 +-
 .../selftests/bpf/progs/task_local_storage.c       |   19 +
 tools/testing/selftests/bpf/progs/task_work_fail.c |    6 +-
 .../testing/selftests/bpf/progs/test_bpf_nf_fail.c |    8 +-
 .../selftests/bpf/progs/test_fill_link_info.c      |    2 +-
 .../selftests/bpf/progs/test_global_func3.c        |   52 +-
 .../selftests/bpf/progs/test_kfunc_dynptr_param.c  |   11 +-
 .../bpf/progs/test_kfunc_param_nullable.c          |    2 +-
 .../selftests/bpf/progs/test_lirc_mode2_kern.c     |    4 +-
 .../selftests/bpf/progs/test_lwt_ip_encap.c        |  155 +-
 .../selftests/bpf/progs/test_ringbuf_map_key.c     |   11 +-
 .../selftests/bpf/progs/test_signed_loader.c       |   18 +
 .../selftests/bpf/progs/test_signed_loader_data.c  |   20 +
 .../selftests/bpf/progs/test_signed_loader_lsm.c   |   30 +
 .../selftests/bpf/progs/test_signed_loader_map.c   |   28 +
 .../bpf/progs/test_sleepable_tracepoints.c         |  112 +
 .../bpf/progs/test_sleepable_tracepoints_fail.c    |   18 +
 .../bpf/progs/test_sockmap_msg_pop_data.c          |   27 +
 .../testing/selftests/bpf/progs/test_tunnel_kern.c |   13 +-
 tools/testing/selftests/bpf/progs/test_vmlinux.c   |    4 +-
 .../selftests/bpf/progs/test_wakeup_source.c       |   92 +
 .../selftests/bpf/progs/tracing_multi_attach.c     |   39 +
 .../bpf/progs/tracing_multi_attach_module.c        |   25 +
 .../selftests/bpf/progs/tracing_multi_bench.c      |   12 +
 .../selftests/bpf/progs/tracing_multi_check.c      |  214 +
 .../selftests/bpf/progs/tracing_multi_fail.c       |   18 +
 .../bpf/progs/tracing_multi_intersect_attach.c     |   41 +
 .../selftests/bpf/progs/tracing_multi_rollback.c   |   43 +
 .../bpf/progs/tracing_multi_session_attach.c       |   65 +
 .../selftests/bpf/progs/tracing_multi_verifier.c   |   31 +
 .../selftests/bpf/progs/user_ringbuf_fail.c        |    4 +-
 tools/testing/selftests/bpf/progs/verifier_arena.c |   69 +-
 .../selftests/bpf/progs/verifier_arena_globals1.c  |    2 +-
 .../selftests/bpf/progs/verifier_arena_globals2.c  |    2 +-
 .../selftests/bpf/progs/verifier_arena_large.c     |    2 +-
 .../selftests/bpf/progs/verifier_bits_iter.c       |    4 +-
 .../testing/selftests/bpf/progs/verifier_bounds.c  |  130 +-
 .../selftests/bpf/progs/verifier_bpf_fastcall.c    |   27 +-
 .../selftests/bpf/progs/verifier_flow_keys.c       |   97 +
 .../selftests/bpf/progs/verifier_global_ptr_args.c |   21 +-
 .../selftests/bpf/progs/verifier_global_subprogs.c |   20 +-
 .../selftests/bpf/progs/verifier_jit_inline.c      |    4 +-
 tools/testing/selftests/bpf/progs/verifier_ldsx.c  |    8 +-
 .../selftests/bpf/progs/verifier_liveness_exp.c    |    2 +-
 tools/testing/selftests/bpf/progs/verifier_lsm.c   |    9 +
 .../selftests/bpf/progs/verifier_map_in_map.c      |   40 +
 .../testing/selftests/bpf/progs/verifier_map_ptr.c |   36 +-
 .../selftests/bpf/progs/verifier_may_goto_1.c      |   12 +-
 .../selftests/bpf/progs/verifier_private_stack.c   |   30 +-
 .../selftests/bpf/progs/verifier_ref_tracking.c    |    8 +-
 .../selftests/bpf/progs/verifier_scalar_ids.c      |   25 +-
 tools/testing/selftests/bpf/progs/verifier_sdiv.c  |   64 +-
 .../selftests/bpf/progs/verifier_set_retval.c      |  107 +
 tools/testing/selftests/bpf/progs/verifier_sock.c  |   15 +-
 .../selftests/bpf/progs/verifier_stack_arg.c       |  447 +++
 .../selftests/bpf/progs/verifier_stack_arg_order.c |  185 +
 .../testing/selftests/bpf/progs/verifier_subreg.c  |    6 +-
 .../selftests/bpf/progs/verifier_tailcall_jit.c    |    1 +
 .../selftests/bpf/progs/verifier_vfs_reject.c      |   10 +-
 tools/testing/selftests/bpf/progs/wakeup_source.h  |   22 +
 .../selftests/bpf/progs/wakeup_source_fail.c       |   76 +
 tools/testing/selftests/bpf/progs/wq_failures.c    |    2 +-
 tools/testing/selftests/bpf/progs/xdp_flowtable.c  |    7 +-
 tools/testing/selftests/bpf/progs/xdp_lb_bench.c   |  647 +++
 tools/testing/selftests/bpf/progs/xdping_kern.c    |  183 -
 tools/testing/selftests/bpf/test_kmods/Makefile    |   30 +-
 .../testing/selftests/bpf/test_kmods/bpf_testmod.c |   79 +
 .../selftests/bpf/test_kmods/bpf_testmod_kfunc.h   |   33 +
 tools/testing/selftests/bpf/test_lirc_mode2_user.c |    6 +-
 tools/testing/selftests/bpf/test_loader.c          |  187 +-
 tools/testing/selftests/bpf/test_maps.c            |   23 +-
 tools/testing/selftests/bpf/test_progs.c           |   55 +-
 tools/testing/selftests/bpf/test_progs.h           |    3 +
 tools/testing/selftests/bpf/test_xdping.sh         |  103 -
 tools/testing/selftests/bpf/testing_helpers.c      |   18 +
 tools/testing/selftests/bpf/testing_helpers.h      |    1 +
 tools/testing/selftests/bpf/trace_helpers.c        |    7 +-
 tools/testing/selftests/bpf/trace_helpers.h        |    1 +
 tools/testing/selftests/bpf/uprobe_multi.c         |    4 +-
 tools/testing/selftests/bpf/verifier/calls.c       |   86 +-
 tools/testing/selftests/bpf/verifier/sleepable.c   |   17 +-
 tools/testing/selftests/bpf/veristat.c             |   13 +-
 tools/testing/selftests/bpf/vmtest.sh              |    2 +-
 tools/testing/selftests/bpf/xdp_lb_bench_common.h  |  112 +
 tools/testing/selftests/bpf/xdping.c               |  254 --
 tools/testing/selftests/bpf/xdping.h               |   13 -
 349 files changed, 27886 insertions(+), 4963 deletions(-)
 create mode 100644 include/linux/bpf_defs.h
 create mode 100644 include/linux/cnum.h
 create mode 100644 kernel/bpf/cnum.c
 create mode 100644 kernel/bpf/cnum_defs.h
 create mode 100644 tools/testing/selftests/bpf/bench_bpf_timing.h
 create mode 100644 tools/testing/selftests/bpf/benchs/bench_bpf_nop.c
 create mode 100644 tools/testing/selftests/bpf/benchs/bench_bpf_timing.c
 create mode 100644 tools/testing/selftests/bpf/benchs/bench_xdp_lb.c
 create mode 100755 tools/testing/selftests/bpf/benchs/run_bench_xdp_lb.sh
 create mode 100644 tools/testing/selftests/bpf/default.profraw
 create mode 100644 tools/testing/selftests/bpf/libarena/Makefile
 rename tools/testing/selftests/bpf/{ => libarena/include}/bpf_arena_common.h (93%)
 rename tools/testing/selftests/bpf/{progs => libarena/include}/bpf_arena_spin_lock.h (97%)
 rename tools/testing/selftests/bpf/{ => libarena/include}/bpf_atomic.h (98%)
 create mode 100644 tools/testing/selftests/bpf/libarena/include/bpf_may_goto.h
 create mode 100644 tools/testing/selftests/bpf/libarena/include/libarena/asan.h
 create mode 100644 tools/testing/selftests/bpf/libarena/include/libarena/buddy.h
 create mode 100644 tools/testing/selftests/bpf/libarena/include/libarena/common.h
 create mode 100644 tools/testing/selftests/bpf/libarena/include/libarena/rbtree.h
 create mode 100644 tools/testing/selftests/bpf/libarena/include/libarena/spmc.h
 create mode 100644 tools/testing/selftests/bpf/libarena/include/libarena/userspace.h
 create mode 100644 tools/testing/selftests/bpf/libarena/selftests/st_asan_buddy.bpf.c
 create mode 100644 tools/testing/selftests/bpf/libarena/selftests/st_asan_common.h
 create mode 100644 tools/testing/selftests/bpf/libarena/selftests/st_buddy.bpf.c
 create mode 100644 tools/testing/selftests/bpf/libarena/selftests/test_parallel_spmc.bpf.c
 create mode 100644 tools/testing/selftests/bpf/libarena/selftests/test_progs_compat.h
 create mode 100644 tools/testing/selftests/bpf/libarena/selftests/test_rbtree.bpf.c
 create mode 100644 tools/testing/selftests/bpf/libarena/selftests/test_spmc.bpf.c
 create mode 100644 tools/testing/selftests/bpf/libarena/src/asan.bpf.c
 create mode 100644 tools/testing/selftests/bpf/libarena/src/buddy.bpf.c
 create mode 100644 tools/testing/selftests/bpf/libarena/src/common.bpf.c
 create mode 100644 tools/testing/selftests/bpf/libarena/src/rbtree.bpf.c
 create mode 100644 tools/testing/selftests/bpf/libarena/src/spmc.bpf.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/arena_direct_value.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/bpf_attr_size.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/libarena.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/libarena_asan.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/lru_lock_nmi.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/rhash.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/signed_loader.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/sleepable_tracepoints.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/stack_arg.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/stack_arg_fail.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/stack_arg_precision.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/tracing_multi.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/wakeup_source.c
 create mode 100644 tools/testing/selftests/bpf/progs/bench_bpf_timing.bpf.h
 create mode 100644 tools/testing/selftests/bpf/progs/bpf_iter_bpf_rhash_map.c
 create mode 100644 tools/testing/selftests/bpf/progs/bpf_nop_bench.c
 create mode 100644 tools/testing/selftests/bpf/progs/bpf_qdisc_dynptr_use_after_invalidate_clone.c
 create mode 100644 tools/testing/selftests/bpf/progs/bpf_qdisc_fail__invalid_dynptr.c
 create mode 100644 tools/testing/selftests/bpf/progs/bpf_qdisc_fail__invalid_dynptr_cross_frame.c
 create mode 100644 tools/testing/selftests/bpf/progs/bpf_qdisc_fail__invalid_dynptr_slice.c
 create mode 100644 tools/testing/selftests/bpf/progs/btf__stack_arg_precision.c
 create mode 100644 tools/testing/selftests/bpf/progs/btf__verifier_stack_arg_order.c
 create mode 100644 tools/testing/selftests/bpf/progs/lru_lock_nmi.c
 create mode 100644 tools/testing/selftests/bpf/progs/rhash.c
 create mode 100644 tools/testing/selftests/bpf/progs/stack_arg.c
 create mode 100644 tools/testing/selftests/bpf/progs/stack_arg_fail.c
 create mode 100644 tools/testing/selftests/bpf/progs/stack_arg_kfunc.c
 create mode 100644 tools/testing/selftests/bpf/progs/stack_arg_precision.c
 create mode 100644 tools/testing/selftests/bpf/progs/tailcall_cgrp_storage.c
 create mode 100644 tools/testing/selftests/bpf/progs/tailcall_cgrp_storage_no_storage.c
 create mode 100644 tools/testing/selftests/bpf/progs/tailcall_cgrp_storage_owner.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_signed_loader.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_signed_loader_data.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_signed_loader_lsm.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_signed_loader_map.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_sleepable_tracepoints.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_sleepable_tracepoints_fail.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_sockmap_msg_pop_data.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_wakeup_source.c
 create mode 100644 tools/testing/selftests/bpf/progs/tracing_multi_attach.c
 create mode 100644 tools/testing/selftests/bpf/progs/tracing_multi_attach_module.c
 create mode 100644 tools/testing/selftests/bpf/progs/tracing_multi_bench.c
 create mode 100644 tools/testing/selftests/bpf/progs/tracing_multi_check.c
 create mode 100644 tools/testing/selftests/bpf/progs/tracing_multi_fail.c
 create mode 100644 tools/testing/selftests/bpf/progs/tracing_multi_intersect_attach.c
 create mode 100644 tools/testing/selftests/bpf/progs/tracing_multi_rollback.c
 create mode 100644 tools/testing/selftests/bpf/progs/tracing_multi_session_attach.c
 create mode 100644 tools/testing/selftests/bpf/progs/tracing_multi_verifier.c
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_flow_keys.c
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_set_retval.c
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_stack_arg.c
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_stack_arg_order.c
 create mode 100644 tools/testing/selftests/bpf/progs/wakeup_source.h
 create mode 100644 tools/testing/selftests/bpf/progs/wakeup_source_fail.c
 create mode 100644 tools/testing/selftests/bpf/progs/xdp_lb_bench.c
 delete mode 100644 tools/testing/selftests/bpf/progs/xdping_kern.c
 delete mode 100755 tools/testing/selftests/bpf/test_xdping.sh
 create mode 100644 tools/testing/selftests/bpf/xdp_lb_bench_common.h
 delete mode 100644 tools/testing/selftests/bpf/xdping.c
 delete mode 100644 tools/testing/selftests/bpf/xdping.h
