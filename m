Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 433873AC0D8
	for <bpf@vger.kernel.org>; Mon, 17 Aug 2026 21:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787001992; cv=none; b=QgGdH1YU6zZ0I5qq5ewQvA/CjFeJ1+KRxXb70ghJvfLGLpr4cccFL6yBKgylxVDwouEL+8v/f4AKSNYg94X41UJgvP+YdF/jBbMz/UX2efNZSoIReFAARiyjWAXs8vjsVz35jhbbrgOdJFqm3buokexUrBPiP530Vav6NOYtR2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787001992; c=relaxed/simple;
	bh=36gMOd7KbBmXFJBcD0tw+XU9NIIwwK/z+46r9iuPAqg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=pT+YwKDXnS9iOiTm5CFjqpX8EN88JPBtatZ3iqPEXRx0WLejv7vzLui3p41KpHUh8WDvpmgHhACHG6+1o6zes3rYPqAI4IOW2nRCAsSR+AgtaCneulbvGuGBNWYyhrhH1jvqE1VQ1J0e4UdaJrms2VjWlAGG3kRo+xb1eYwuOWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=H7LCVjFW; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="H7LCVjFW"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=w+8Fcp+YjihkkGlgNfaES0TDUec0LrCeQTapv0YH6+k=; b=H7LCVjFWH1YCpOsQl2GnKT0ZbQ
	kp7XlOhTnBnyFzB2L4UF1kdxeuch7fsUZb8VOio2GbsApT9FKMKK61VzWy40/soMZEb8xTNQSTsT+
	Jp8RHQ5SIxa1wwx8k2OrtcR12uTmfbO5HLnIde9qFgp7bLF7bshrx6i/0nvFY2SG0w0ABbtLX1bu+
	ieHanNAYzhiTABixdHUnOuuta7mPwrFR8yQ+yStVfyIvbuYjdQaEPPKzMrxTBz+P2sn8w0CxJkqAw
	yqlBpBgQb9kZ2yVoCzg8onrAnDFrTnQ3Uumjn1+JULQ73/JieET9ST+icjiWsvQVB7Xv5e3XqrpSQ
	N8/7nCNg==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1ww4qf-000H54-00;
	Mon, 17 Aug 2026 23:26:25 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: torvalds@linux-foundation.org
Cc: bpf@vger.kernel.org,
	alexei.starovoitov@gmail.com,
	daniel@iogearbox.net,
	andrii@kernel.org,
	memxor@gmail.com,
	eddyz87@gmail.com
Subject: [GIT PULL] BPF changes for 7.3
Date: Mon, 17 Aug 2026 23:26:22 +0200
Message-ID: <20260817212624.902049-1-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/28095/Mon Aug 17 08:23:59 2026)

Hi Linus,

The following changes since commit a13307e97d5c54b65720bb71fa379960ded1e51a:

  Merge tag 'bpf-fixes' of git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf (2026-08-07 08:08:57 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git tags/bpf-next-7.3

for you to fetch changes up to f79066c784022fda83f5936559a1af414e41b603:

  selftests/bpf: Add tests for a store on a fault prone qdisc pointer (2026-08-17 19:31:53 +0200)

----------------------------------------------------------------
Major changes:

- Redesign the verifier error reporting: failures now carry source and
  instruction annotations along with the causal event history that led
  to them, making program rejections far easier to debug and repair
  (Kumar Kartikeya Dwivedi)

- Add arena argument support to kfuncs and struct_ops through the new
  __arena and __arena__nullable suffixes (Tejun Heo, Puranjay Mohan,
  Kumar Kartikeya Dwivedi, Ihor Solodrai)

- Signed BPF program loader rework to accommodate both BPF and security
  community needs where the kernel runs the signature verification at
  BPF_PROG_LOAD time before the LSM admission hook (Daniel Borkmann)

- Add a set of ksock kfuncs which let BPF LSM and syscall programs
  create, connect and send on UDP sockets in order to emit telemetry
  data (Mahe Tardy)

- Unify helper and kfunc call argument verification and classify kfunc
  arguments purely from BTF into a generated bpf_func_proto which is
  computed once at add-call time (Amery Hung)

Other features and fixes:

- Enable EXECMEM_ROX_CACHE for BPF allocations on x86 (Mike Rapoport)

- Add bidirectional VLAN support to bpf_fib_lookup() through the new
  BPF_FIB_LOOKUP_VLAN and BPF_FIB_LOOKUP_VLAN_INPUT flags
  (Avinash Duduskar)

- Infer zext_dst from static register liveness analysis to fix 32-bit
  zero-extension semantics, and remove the artificial limitations on
  pointer types eligible for spilling (Eduard Zingerman)

- Inline the numeric open-coded iterator kfuncs so that bpf_for() loops
  no longer pay a kfunc call on every iteration (Puranjay Mohan)

- Add an arena-based bitmap data structure to libarena along with
  serial and parallel selftests (Emil Tsalapatis)

- Teach resolve_btfids to discover kfuncs from the kernel's BTF ID sets
  and to emit kfunc BTF decl tags, reducing the kernel build's
  dependency on pahole features (Ihor Solodrai)

- Add BPF_F_ADJ_ROOM_DECAP_* flags to bpf_skb_adjust_room() so that
  tunnel decapsulation can update the GSO and encapsulation state of
  the skb (Nick Hudson)

- Fix the ring buffer pending_pos walk and the available-data
  accounting on 32-bit position wrap (Israel Téllez García)

- Add memory usage accounting for arena maps and fix an mmap_lock
  deadlock on arena lock failure (Jiayuan Chen)

- Add tracing_multi link info support to the kernel UAPI and bpftool,
  and refactor the stack map code to run with preemption disabled
  (Jiri Olsa)

- Support BPF_F_EGRESS in bpf_redirect_peer() to emit the skb in the
  egress direction of the target's peer device (Jordan Rife)

- Add a KF_SPINLOCK_SAFE kfunc flag so that providers, in particular
  modules, can declare kfuncs safe to call under bpf_spin_lock instead
  of relying on the verifier's hard-coded allowlist (Kaitao Cheng)

- Introduce global percpu data for BPF programs with libbpf probing
  and bpftool skeleton support, and stop exposing uninitialized kernel
  heap memory when copying per-CPU map values (Leon Hwang)

- Add s390 JIT support for load-acquire and store-release instructions
  (Maxim Khmelevskii)

- Fix a CFI mismatch in the task work callback and an arm64 KASAN
  false positive after bpf_throw() (Mykyta Yatsenko)

- Reject writes through untrusted BTF pointers and bound the
  rdonly/rdwr_buf_size kfunc arguments (Nicholas Dudar)

- Invalidate RCU pointers only after the final spin unlock and account
  for preempt and IRQ disabled regions as overlapping RCU protection
  (Ning Ding)

- Support mixing bpf2bpf calls and tail calls on RV64, add signed
  operations and 32-bit atomics to the RV32 JIT, and add timed may_goto
  support (Pu Lehui, Kuan-Wei Chiu, Feng Jiang)

- Fix a use-after-free on mm_struct in bpf_find_vma() for foreign tasks
  and an mmap_lock leak in the irq_work path (Sanghyun Park)

- Populate mmap-able BPF array map memory lazily which makes mmap() O(1)
  instead of proportional to the map size (Song Liu)

- Introduce a jit_required flag and reject programs with inlined
  helpers when no JIT is available, where the interpreter would
  otherwise jump into an invalid address (Tiezhu Yang)

- Fix the x86 JIT per-CPU address resolution into an extended register
  where the REX prefix dropped the high destination register bit
  (Vineet Gupta)

- Reject MEM_ALLOC BTF accesses past object bounds, arena frees below
  the arena base, and mixed arena and ordinary atomic paths
  (Yiyang Chen)

- Fix the trampoline handling of 128-bit arguments and of return values
  larger than 8 bytes (Yonghong Song)

- Ensure that any fault prone load is rewritten with exception table
  handling, and fix the arena load-acquire and atomic fetch handling
  in the x86, arm64, riscv and s390 JITs (Daniel Borkmann)

- Many more fixes and cleanups across the verifier, arena, trampolines,
  sockmap, cgroup, ring buffer, x86/arm64/riscv/s390 JITs, libbpf,
  bpftool, resolve_btfids and selftests.

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>

----------------------------------------------------------------
Alexei Starovoitov (3):
      Merge branch 'bpf-bpf_redirect_peer-egress-redirection'
      Merge branch 'bpf-preserve-scalar-zero-spills-for-stack-reads'
      Merge branch 'modernize-resolve_btfids-selftest'

Alexis Lothoré (eBPF Foundation) (2):
      selftests/bpf: Remove redundant config option from selftests fragments
      selftests/bpf: Fix comment style in network_helpers.c

Amery Hung (26):
      bpf: Remove dynptr check in check_stack_range_initialized()
      bpf: Factor out raw_mode-related fields in bpf_call_arg_meta
      bpf: Pass argno to callees in check_func_arg() instead of argno_from_reg(regno)
      bpf: Unify helper and kfunc allocation-size argument handling
      selftests/bpf: Test kfunc returning zero-sized allocation buffer
      bpf: Drop redundant pkt_access from bpf_call_arg_meta
      bpf: Unify helper and kfunc call argument meta
      bpf: Disable raw mode for bloom filter map_peek
      bpf: Zero kfunc arg meta before error paths can read it
      bpf: Drop process_timer_func wrappers
      bpf: Unify const map ptr argument checking for helpers and kfuncs
      bpf: Split kfunc map argument into __const_map and __map
      bpf: Pass kfunc meta to mem and mem_size check
      bpf: Check helper and kfunc mem+size arguments identically
      selftests/bpf: Test map lookup result refinement
      bpf: Check fixed-size mem args of helpers and kfuncs the same way
      bpf: Rename ARG_CONST_SIZE{,_OR_ZERO} to ARG_MEM_SIZE{,_OR_ZERO}
      bpf: Fold __szk const size handling into the scalar arg path
      selftests/bpf: Test __szk precision with a NULL nullable buffer
      bpf: Classify kfunc mem_size args from BTF without register state
      bpf: Handle NULL kfunc pointer args without a KF_ARG_PTR_TO_NULL type
      bpf: Distinguish fixed- and variable-size kfunc mem args with MEM_FIXED_SIZE
      bpf: Classify kfunc pointer arguments from BTF, resolve type against the register
      bpf: Tag nullable kfunc pointer args with PTR_MAYBE_NULL
      bpf: Classify scalar kfunc arguments from BTF
      bpf: Generate kfunc argument prototype at add-call time

Andrii Nakryiko (14):
      libbpf: fix -Wformat warnings from format/argument type mismatches
      bpftool: Strip all -Wformat* flags from bootstrap libbpf build
      Merge branch 'tools-bpf-bpftool-fix-vmlinux-btf-state-cleanup'
      Merge branch 'bpf-copy-per-cpu-map-value-padding-in-copy_map_value_long'
      Merge branch 'bpf-tracing_multi-link-info-support'
      Merge branch 'resolve_btfids-discover-kfuncs-from-btf-id-sets'
      Merge branch 'bpf-inline-the-numeric-open-coded-iterator-kfuncs'
      Merge branch 'bpf-disable-preemption-in-stack-map-code'
      Merge branch 'bpf-fix-sleepable-check-for-tracing-lsm-prog'
      Merge branch 'bpf-introduce-global-percpu-data'
      Merge branch 'selftests-bpf-fix-for-veristat-file-prog-filters-processing'
      selftests/bpf: Use ping_command() for IPv6 pings in lwt_ip_encap
      selftests/bpf: Make pyperf600 a success again
      selftests/bpf: Retry stat generation in cgroup_iter_memcg

Avinash Duduskar (4):
      bpf: Add BPF_FIB_LOOKUP_VLAN flag to bpf_fib_lookup() helper
      bpf: Add BPF_FIB_LOOKUP_VLAN_INPUT flag to bpf_fib_lookup() helper
      selftests/bpf: Add bpf_fib_lookup() VLAN flag tests
      selftests/bpf: Fix fib_lookup VLAN tests on hosts with forwarding on

Changwoo Min (1):
      selftests/bpf: Remove duplicate copies of the arena spinlock qnodes

Daniel Borkmann (40):
      Merge git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf 7.2-rc2
      bpf: Resolve and cache fd_array objects at load time
      bpf: Verify signed loader metadata at load time
      libbpf: Drop in-loader metadata check for load-time verification
      bpftool: Check EVP_Digest when computing excl_prog_hash
      bpftool: Cover loader metadata with the program signature
      selftests/bpf: Adjust bpf_map layout in verifier_map_ptr
      selftests/bpf: Verify load-time signed loader metadata
      Documentation/bpf: Add BPF signing and enforcement doc
      selftests/bpf: Close fd on unexpected success in signed loader
      bpf: Fix vmlinux BTF prep race in bpf_get_btf_vmlinux
      bpf: Give vmlinux BTF init its own mutex
      bpf: Account insn_aux_data allocation in bpf_check
      bpf: Account scratch buffer in bpf_prog_calc_tag
      bpf: Fix security_bpf_map_create error handling
      bpf: Drop scalar id on sign-extending narrowing stack fills
      selftests/bpf: Add test for scalar id on sign-extending stack fill
      bpf: Check load-acquire src ptr type before the load
      selftests/bpf: Add load-acquire test for dst_reg == src_reg from ctx
      bpf: Disable preemption in __bpf_get_stack
      bpf: Reject load-acquire from pointers requiring fault protection
      bpf, riscv: Add and use bpf_atomic_is_load_acq() helper
      bpf, x86: Fix exception table metadata for arena load-acquire
      bpf, arm64: Fix exception table metadata for arena load-acquire
      selftests/bpf: Add arena fault test for load-acquire
      selftests/bpf: Add load-acquire test for probe-memory pointer types
      Merge git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf 7.2-rc7
      bpf: Derive the atomic load register in one place
      bpf, riscv: Clear fetch destination on faulting arena atomic
      bpf, x86: Clear fetch destination on faulting arena atomic
      bpf, arm64: Clear fetch destination on faulting arena atomic
      bpf, s390: Clear fetch destination on faulting arena atomic
      selftests/bpf: Add arena fault tests for atomics with fetch
      bpf: Keep fault protection when merging pointer types
      bpf: Treat a fault prone PTR_TO_MEM as a pointer type mismatch
      bpf: Reject a store through a fault prone pointer
      bpf: Rewrite any fault prone load out of a mem or btf_id pointer
      selftests/bpf: Add tests for pointer type merge at a shared load
      selftests/bpf: Add tests for fault prone loads out of RCU pointers
      selftests/bpf: Add tests for a store on a fault prone qdisc pointer

Eduard Zingerman (27):
      bpf: Remove artificial limitations on pointer types eligible for spilling
      selftests/bpf: Test cases for missing spill types
      Merge branch 'fix-for-untrusted-btf-pointer-writes'
      Merge branch 'introduce-jit_required-to-prevent-a-kernel-panic'
      Merge branch 'fixes-for-tailcall-with-subprog-and-callback'
      Merge branch 'fix-leftover-issues-of-the-unify-bpf_call_arg_meta-patchset'
      Merge branch 'fix-unique-field-logic-in-btf'
      Merge git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf 7.2-rc5
      bpf: Resolve map lookup result type at lookup time
      Merge branch 'resolve_btfids-implement-btf-tags-emission-for-kfuncs'
      bpf: Do not print a newline after disassembly in bpf_verbose_insn()
      bpf: Extract is_addr_space_cast32() utility function
      bpf: Move bpf_is_reg64() to fixups.c
      bpf: Track upper 32-bit register halves' liveness in compute_live_registers()
      bpf: Infer zext_dst based on static register liveness analysis
      bpf: Simplify the bpf_is_reg64()
      selftests/bpf: Verify zext_dst annotations for various instructions
      Merge branch 'add-arena-argument-support-to-kfuncs-and-struct_ops'
      Merge branch 'bpf-compare-iterator-types-during-state-pruning'
      Merge branch 'improve-stack-depth-verification-stats-output'
      Merge branch 'add-resolve_btfids-support-for-__arena-kfunc-suffix'
      selftests/bpf: Fix for veristat file/prog filters processing
      selftests/bpf: Exercise veristat filtering logic in a selftest
      selftests/bpf: Guarantee zero termination for veristat test buffers
      Merge branch 'bpf-x86-fix-per-cpu-address-resolution-into-an-extended-register'
      Merge branch 'redesign-verification-errors'
      Merge branch 'bpf-reject-mixed-arena-and-ordinary-atomic-paths'

Emil Tsalapatis (7):
      selftests/bpf: libarena: Replace leftover st_ prefix with test_
      selftests/bpf: libarena: Fix can-loop zero variable definition
      selftests/bpf: libarena: Clean up allocation state before buddy tests
      selftests/bpf: Add arena-based bitmap data structure
      selftests/bpf: libarena: Add bitmap selftests
      selftests/bpf: libarena: Add parallel bitmap selftest
      selftests/bpf: veristat: Minimize map size during verification

Feng Jiang (4):
      bpf, riscv: Fix extable handling for arena load_acquire
      bpf, riscv: Add support for timed may_goto
      selftests/bpf: Test timed may_goto preserves R0-R5
      selftests/bpf: Enable timed may_goto tests for riscv64

Feng Yang (6):
      selftests/bpf: Fix memory leak in msg_alloc_iov
      selftests/bpf: Fix extra free of subtest_state->name
      selftests/bpf: Fix incorrect error checking for pthread_create
      selftests/bpf: Fix missing allocation null checks in test_progs.c
      selftests/bpf: Use calloc to allocate subtest_states
      selftests/bpf: Fix memory leak on subtest_states reallocation

Guillaume Maudoux (1):
      selftests/bpf: Mask socket type flags in mptcpify prog

Hui Zhu (2):
      bpf: Fix UAF in bpf_trampoline_multi_attach_free on update failure
      bpf: Make bpf_trampoline_multi_detach return void

Ihor Solodrai (20):
      tools/bpf: Sync btf_ids.h to tools
      selftests/bpf: Modernize resolve_btfids test scaffolding
      selftests/bpf: Fix resolve_btfids test reads of BTF ID sets in PIE builds
      selftests/bpf: Add kfunc set test to resolve_btfids
      MAINTAINERS: BPF: Add self as reviewer
      resolve_btfids: Implement generic ensure_mem() to grow arrays
      resolve_btfids: Index BTF ID symbols by address
      resolve_btfids: Keep collected kfuncs in a rbtree
      libbpf: Export btf__find_by_name_kind_own()
      resolve_btfids: Fix the _impl lookup for module BTF
      HID: bpf: Make syscall kfunc flags match the struct_ops set
      resolve_btfids: Discover kfuncs from BTF ID sets
      resolve_btfids: Enforce consistent kfunc flags across BTF ID sets
      resolve_btfids: Deduplicate BTF after btf2btf transformations
      resolve_btfids: Process KF_ARENA_* flags in resolve_btfids
      selftests/bpf: Verify arena type tags in resolve_btfids test
      resolve_btfids: Emit bpf_kfunc and bpf_fastcall decl tags
      selftests/bpf: Verify decl tags emission in resolve_btfids test
      docs, resolve_btfids: Document kfunc BTF annotation emission
      selftests/bpf: Fix selftest build after filter.h update

Israel Téllez García (3):
      bpf: Fix pending_pos walk on 32-bit ring position wrap
      bpf: Fix available-data accounting on 32-bit wrap in overwrite mode
      libbpf: Fix ring buffer consumer loop on 32-bit position wrap

JP Kobryn (1):
      Documentation/bpf: make it clear that kfuncs should be non-static

Jianlin Shi (1):
      docs: bpf: Document BPF_RB_OVERWRITE_POS in bpf_ringbuf_query

Jiayuan Chen (8):
      selftests/bpf: Fix test_maps sockmap failure
      bpf: Pass arena instead of scratch_page to the pte callbacks
      bpf: Add memory usage for arena
      selftests/bpf: Run arena tests serially
      selftests/bpf: Add tests for memory usage for arena
      bpftool: Skip prog/map that disappears while looking it up by name
      selftests/bpf: Report the real error from libarena parallel workers
      bpf: Fix mmap_lock deadlock on arena lock failure

Jiri Olsa (14):
      bpf: Add tracing_multi link info support
      selftests/bpf: Add tracing_multi link info tests
      bpftool: Add tracing_multi link info output
      bpf: Factor stackid_init function from __bpf_get_stackid
      bpf: Factor stackid_fastpath function from __bpf_get_stackid
      bpf: Factor stackid_new_bucket from __bpf_get_stackid
      bpf: Use stack id functions instead of __bpf_get_stackid
      bpf: Disable preemption in bpf_get_stackid
      bpf: Factor callchain_store function from __bpf_get_stack
      bpf: Factor callchain_finalize function from __bpf_get_stack
      bpf: Remove trace_in argument from __bpf_get_stack
      bpf: Clear buf on error in __bpf_get_task_stack
      bpf: Avoid changing callchain in bpf_get_stack_pe
      bpf: Avoid changing callchain in bpf_get_stackid_pe

Jordan Rife (2):
      bpf: Support BPF_F_EGRESS with bpf_redirect_peer
      selftests/bpf: Add tests for bpf_redirect_peer with BPF_F_EGRESS

Junseo Lim (4):
      lwt_bpf: Restore reserved headroom after xmit program
      bpf: Disallow bpf_{g,s}etsockopt() in cgroup UNIX getname hooks
      bpf: Reject negative optlen in cgroup getsockopt hook
      selftests/bpf: Exercise negative optlen in cgroup getsockopt hook

Jérémy Jean (1):
      bpf: Harden bloom filter sizing and indexing on 32-bit kernels

Kaitao Cheng (3):
      bpf: Add KF_SPINLOCK_SAFE flag for kfuncs under bpf_spin_lock
      bpf: Mark existing lock-safe kfuncs with KF_SPINLOCK_SAFE
      selftests/bpf: Test module kfunc calls under spin lock

Kuan-Wei Chiu (3):
      riscv, bpf: Add support for BPF_SDIV and BPF_SMOD in RV32 JIT
      riscv, bpf: Add support for BPF_MOVSX in RV32 JIT
      riscv, bpf: Add 32 bit atomic operations to RV32 JIT

Kumar Kartikeya Dwivedi (73):
      Merge branch 'selftests-bpf-libarena-cleanup-and-bitmap-struct'
      Merge branch 'bpf-reject-mem_alloc-btf-accesses-past-bounds'
      Merge branch 'bpf-remove-artificial-limitations-on-pointer-types-eligable-for-spilling'
      selftests/bpf: Add untrusted BTF write regression
      Merge branch 'verify-bpf-signed-loader-at-load-time'
      Merge branch 'misc-bpf-fixes-from-sashiko-findings'
      Merge branch 'bpf-bound-rdonly-rdwr_buf_size-kfunc-return-size'
      Merge branch 'bpf-require-an-owned-cpumask-for-bpf_cpumask_populate'
      Merge branch 'bpf-fix-warning-in-bpf_trampoline_multi_detach'
      Merge branch 'bpf-bidirectional-vlan-support-for-bpf_fib_lookup'
      Merge branch 'unify-helper-and-kfunc-call_arg_meta'
      Merge git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf 7.2-rc4
      Merge branch 'bpf-add-memory-usage-for-arena-and-selftest'
      Merge branch 'bpf-reject-arena-frees-below-the-arena-base'
      Merge branch 'bpf-disallow-interpreter-fallback-for-interpreter-unsupported-insns'
      Merge branch 'selftests-bpf-fix-compilation-with-release-1'
      bpf: Zero queue and stack outputs on lock failure
      Merge branch 'selftests-bpf-a-few-edge-case-fixes'
      Merge branch 'mixing-bpf2bpf-and-tailcalls-for-rv64'
      Merge branch 'riscv-bpf-add-support-for-signed-operations-and-32-bit-atomics'
      bpf: Fix offset warn check for bpf_res_spin_lock
      bpf: Preserve unique-field state across nested structs
      bpf: Mark bpf_refcount field as unique
      selftests/bpf: Test duplicate unique fields in nested structs
      selftests/bpf: Test duplicate bpf_refcount fields
      Merge branch 'bpf-x86-enable-execmem_rox_cache-for-bpf-allocations'
      Merge branch 'bpf-riscv-add-timed-may_goto-support'
      Merge branch 'bpf-fix-warning-in-bpf_tracing_link_release'
      Merge branch 's390-bpf-support-load-acquire-and-store-release-instructions'
      Merge branch 'selftests-bpf-fix-several-issues-in-test_progs-c'
      bpf: Allow bpf_res_spin_lock() in all contexts
      Merge branch 'bpf-fix-trampoline-handling-of-128-bit-values'
      Merge branch 'generate-bpf_func_proto-for-kfunc'
      Merge branch 'bpf-invalidate-rcu-pointers-after-final-spin-unlock'
      Merge branch 'bpf-allow-selected-kfuncs-under-bpf_spin_lock'
      Merge branch 'bpf-track-overlapping-rcu-protection'
      bpf: Rename 'early' BTF checking as a preparation phase
      bpf: Split subprogram and kfunc collection
      bpf: Collect kfuncs after resolving program resources
      bpf: Reject tracing/freplace progs for struct_ops with arena args
      selftests/bpf: Test attach rejection for struct_ops arena programs
      bpf: Track verifier instruction stats for each subprogram
      bpf: Attribute async callback instructions to verification roots
      bpf: Show more useful info in stack depth stats
      selftests/bpf: Adjust veristat stack depth parsing
      selftests/bpf: Test stack depth stats without BTF subprog names
      selftests/bpf: Test subprogram instruction statistics
      Merge branch 'bpf-fix-trampoline-image-uaf-on-multi-detach-failure'
      resolve_btfids: Emit arena attributes from kfunc parameter suffixes
      selftests/bpf: Test resolve_btfids arena argument suffixes
      bpf: Fix func_info_aux desync after dead code elimination
      Merge branch 'bpf-arm64-__arena-kfunc-and-struct_ops-arguments'
      bpf: Add verifier diagnostics report helpers
      bpf: Add source and instruction diagnostic context
      bpf: Add verifier diagnostic event log
      bpf: Prune verifier diagnostics when switching paths
      bpf: Track verifier register diagnostic events
      bpf: Track verifier reference diagnostic events
      bpf: Track verifier context diagnostic events
      bpf: Report Register Type Safety errors
      bpf: Report Memory Safety bounds errors
      bpf: Report Resource Lifetime reference leaks
      bpf: Report Call Type Safety argument errors
      bpf: Report Execution Context Safety errors
      bpf: Report Program Structure CFG errors
      bpf: Report Policy helper and kfunc errors
      bpf: Preserve R0 lineage across helper calls
      bpf: Use canonical stack argument names in diagnostics
      bpf: Correct kfunc argument diagnostics
      selftests/bpf: Test kfunc argument diagnostics
      bpf: Preserve source attribution without source text
      bpf: Distinguish function references in policy diagnostics
      selftests/bpf: Test pseudo-function policy diagnostics

Leon Hwang (24):
      bpf: Copy per-CPU map value padding in copy_map_value_long()
      selftests/bpf: Verify no non-zeroed kernel heap memory exposure
      bpf: Mark tracing_multi trampolines as ftrace managed
      selftests/bpf: Test fentry link after tracing_multi link
      bpf: Disallow interpreter fallback for arena-related insns
      bpf: Disallow interpreter fallback for gotox insn
      bpf: Disallow interpreter fallback for BPF_ADDR_PERCPU insn
      bpf: Fix WARNING in bpf_tracing_link_release
      selftests/bpf: Verify no warning when close fexit link
      bpf: Fix sleepable check for tracing/lsm prog
      selftests/bpf: Verify rejection of sleepable tracing prog
      bpf: Trim special_kfunc_list in verifier
      bpf: Drop duplicate blank lines in kernel/bpf/
      bpf: Factor out check_map_mem_read helper in verifier
      bpf: Introduce global percpu data
      libbpf: Probe percpu data feature
      libbpf: Add support for global percpu data
      bpftool: Generate skeleton for global percpu data
      selftests/bpf: Add tests to verify global percpu data
      selftests/bpf: Test direct reading/writing read-only percpu_array map
      selftests/bpf: Test verifier log for global percpu data
      selftests/bpf: Verify bpf_iter for global percpu data
      libbpf: Avoid unnecessary mmap resize for percpu data maps
      selftests/bpf: Improve readability in iter test for percpu data

Mahe Tardy (11):
      bpf: Add bpf_icmp_send kfunc
      selftests/bpf: Add bpf_icmp_send kfunc cgroup_skb tests
      selftests/bpf: Add bpf_icmp_send kfunc cgroup_skb IPv6 tests
      selftests/bpf: Add bpf_icmp_send recursion test
      selftests/bpf: Add bpf_icmp_send no route test
      bpf: Fix unused nskb warning in bpf_icmp_send
      net: Add connect_socket() helper
      bpf: Add ksock kfuncs
      selftests/bpf: Add ksock kfunc test
      selftests/bpf: Test forbidden bpf_ksock_send() LSM attach
      selftests/bpf: Add ksock test for async callback guard

Malaya Kumar Rout (1):
      selftests/bpf: Fix memory leak in msg_alloc_iov error path

Matt Bobrowski (1):
      bpf: update BPF LSM maintainer list

Maxim Khmelevskii (6):
      s390/bpf: Replace ly instruction with llgf
      selftests/bpf: Add test for bpf_get_smp_processor_id
      selftests/bpf: Skip res_spin_lock_stress if no perf support
      s390/bpf: Add emit_ldx and emit_stx functions
      s390/bpf: Support load-acquire and store-release instructions
      s390/bpf: Enable atomics tests for s390

Michal Luczaj (2):
      bpf: Extract shared reqsk-to-listener upgrade
      bpf, sockmap: Use sock_hold() instead of refcount_inc_not_zero() in lookup

Mike Rapoport (Microsoft) (5):
      bpf: dispatcher: Allocate bpf_dispatcher->rw_image with vzalloc()
      bpf: Drop __weak from bpf_jit_alloc_exec() and bpf_jit_free_exec()
      bpf: alloc_prog_pack(): Skip ROX management for already ROX memory
      bpf, x86: Make sure allocation in arch_bpf_trampoline_size() is writable
      x86/bpf: Enable EXECMEM_ROX_CACHE for BPF allocations

Mykyta Yatsenko (2):
      bpf: Fix CFI mismatch in task work callback
      bpf: Fix arm64 KASAN false positive after bpf_throw

Naveed Khan (1):
      libbpf: Fix double-free of distilled base BTF on .BTF.ext parse error

Nicholas Dudar (5):
      bpf: Reject writes through untrusted BTF pointers
      bpf: Reject rdonly/rdwr_buf_size kfunc arguments that exceed u32 max
      selftests/bpf: Add test for oversized rdonly/rdwr_buf_size kfunc argument
      bpf: Require a BPF cpumask for bpf_cpumask_populate()
      selftests/bpf: Test bpf_cpumask_populate() rejects a borrowed cpumask

Nick Hudson (6):
      bpf: Name the enum for BPF_FUNC_skb_adjust_room flags
      bpf: Refactor masks for ADJ_ROOM flags and encap validation
      bpf: Add BPF_F_ADJ_ROOM_DECAP_* flags for tunnel decapsulation
      bpf: Allow new DECAP flags and add guard rails
      bpf: Clear decap state on skb_adjust_room shrink path
      selftests/bpf: tc_tunnel - validate decap GSO and encapsulation state

Ning Ding (6):
      bpf: Invalidate RCU pointers after final spin unlock
      selftests/bpf: Test RCU pointer invalidation after spin unlock
      bpf: Account for preempt and IRQ state in RCU protection
      selftests/bpf: Test overlapping RCU protection
      bpf: Compare iterator types during state pruning
      selftests/bpf: Test RCU iterator state pruning

Pu Lehui (15):
      bpf: Sync tail_call_reachable with callee state on entry
      bpf: Reject callback subprogs invoke tailcall
      selftests/bpf: Add testcases for callback with tailcall
      bpf: Extract the is_struct_ops_tramp helper
      riscv, bpf: Fix memory leak in bpf_jit_free
      riscv, bpf: Using kvzalloc_objs to allocate cache buffer
      riscv, bpf: Fix kernel stack corruption in tailcall with CFI
      riscv, bpf: Add RV_TAILCALL_OFFSET macro to format tailcall offset
      riscv, bpf: Mixing bpf2bpf and tailcalls
      selftests/bpf: Remove tailcalls tests from DENYLIST.riscv64
      bpf: Fix potential UAF in bpf_netns_link_update_prog
      bpf: Fix potential UAF when reading bpf link info
      bpf, cgroup: Fix invalid storage access after __cgroup_bpf_attach failed
      bpf, cgroup: Fix storage null-ptr-deref after replacing prog
      riscv, bpf: Fix missing sign-ext for signed 1-byte and 2-byte kfunc args

Puranjay Mohan (14):
      bpf, arm64: Optimize cast_user code generation
      libarena: Use compiler load-acquire/store-release in bpf_atomic.h
      bpf: Correct the overflow check comment in bpf_iter_num_next()
      bpf: Inline bpf_iter_num_new() kfunc
      bpf: Inline bpf_iter_num_next() kfunc
      bpf: Inline bpf_iter_num_destroy() as a no-op
      selftests/bpf: Verify inlined numeric iterator shape with __xlated
      selftests/bpf: Add bpf_for() benchmark
      bpf, arm64: Fix stack-passed arguments for indirect trampolines
      bpf, arm64: JIT __arena kfunc argument rebasing
      bpf, arm64: Convert struct_ops arena arguments in the trampoline
      selftests/bpf: Add arm64 JIT-sequence tests for __arena kfunc arguments
      selftests/bpf: Enable __arena argument tests on arm64
      selftests/bpf: Test a multi-slot argument before a struct_ops arena argument

Ricardo B. Marlière (4):
      docs/bpf: Document BPF_STRICT_BUILD=0 to tolerate test build failures
      selftests/bpf: Fix make install target
      selftests/bpf: Fix lsm_bdev dev_t encoding mismatch
      libbpf: Search /lib64 and /lib in resolve_full_path()

Sanghyun Park (2):
      bpf: Fix use-after-free on mm_struct in bpf_find_vma()
      bpf: Fix mmap_lock leak in irq_work path

Sechang Lim (3):
      bpf,lsm: Drop bpf_prog_free from sleepable_lsm_hooks
      bpf, sockmap: Disallow update and delete from tc, xdp, socket_filter and flow_dissector
      selftests/bpf: Drop tc/xdp/flow_dissector/socket_filter sockmap mutation tests

Shivaji Kant (2):
      bpf: Allow IP_TRANSPARENT and IPV6_TRANSPARENT in bpf_{set,get}sockopt()
      selftests/bpf: Add IP_TRANSPARENT and IPV6_TRANSPARENT to setget_sockopt

Song Liu (1):
      bpf: Populate mmap-able array map memory lazily

Tejun Heo (10):
      bpf: Support __arena and __arena__nullable kfunc argument suffixes
      bpf: Support __arena and __arena__nullable on struct_ops arguments
      bpf, x86: JIT __arena kfunc argument rebasing
      bpf, x86: Convert struct_ops arena arguments in the trampoline
      selftests/bpf: Add kfunc __arena and __arena__nullable argument tests
      selftests/bpf: Add JIT-sequence tests for __arena kfunc arguments
      selftests/bpf: Add struct_ops __arena and __arena__nullable argument tests
      bpf, x86: Fix stack-passed arguments for indirect trampolines
      selftests/bpf: Test stack-passed struct_ops arena arguments
      arm64: insn: Add encoder for ADD/SUB (extended register)

Thomas Weißschuh (1):
      tools/resolve_btfids: Include libsubcmd headers directly from source tree

Tiezhu Yang (5):
      bpf: Use BPF_CALL_IMM macro consistently in bpf_do_misc_fixups
      bpf: Introduce jit_required flag and remove bpf_prog_has_kfunc_call()
      bpf: Reject programs with inlined helpers if JIT is not available
      selftests/bpf: Add get_preempt_count() support for RISC-V
      selftests/bpf: Enable timed may_goto tests for LoongArch

Tushar Vyavahare (1):
      selftests/xsk: Decouple xskxceiver and xdp apps from test_progs objects

Viktor Malik (4):
      selftests/bpf: Check malloc result with ASSERT_NEQ in test_loader
      selftests/bpf: Check malloc result with ASSERT_NEQ in test_sha256
      selftests/bpf: Silence array bounds warning in global_map_resize
      selftests/bpf: Silence maybe-uninitialized compiler warning in libarena

Vineet Gupta (6):
      selftests/bpf: map_kptr: Expect BPF_ST reject msg on cpuv4 toolchains
      selftests/bpf: Add --no-error-summary to skip end-of-run error log dump
      selftests/bpf: Report failed subtest count in test_progs summary
      selftests/bpf: vmtest.sh: Preserve command quoting when running in the VM
      bpf, x86: Fix per-CPU address resolution into an extended register
      selftests/bpf: Check per-CPU address resolution per register

Weimin Xiong (2):
      unix: Use kvmalloc_array() for BPF iterator batches
      tcp: Use kvmalloc_array() for BPF iterator batches

Woojin Ji (2):
      bpf: Preserve scalar zero spills for stack reads
      selftests/bpf: Cover stack reads from zero spills

Xu Kuohai (1):
      bpf: Eliminate dup/restore of insn_aux_data

Xu Xin (1):
      bpf: Log error code on trampoline unlink failure

Yichong Chen (2):
      tools/bpf/bpftool: Reset vmlinux BTF after map commands
      tools/bpf/bpftool: Reset vmlinux BTF after struct_ops commands

Yiyang Chen (6):
      bpf: Reject MEM_ALLOC BTF accesses past object bounds
      selftests/bpf: Cover MEM_ALLOC access past object bounds
      bpf: Reject arena frees below the arena base
      selftests/bpf: Cover scalar arena frees below the base
      bpf: Check pointer type for all atomic RMW paths
      selftests/bpf: Cover mixed arena and stack atomics

Yonghong Song (6):
      selftests/bpf: Rename libarena struct bitmap to struct arena_bitmap
      bpf: Reject >8 byte return values on return-reading trampoline paths
      bpf, x86: Fix trampoline stack size for 128-bit arguments
      selftests/bpf: Add tests for >8 byte return value and 128-bit arguments
      bpf: Remove unused BTF_FMODEL_STRUCT_ARG
      selftests/bpf: Fix chained_global_func_calls_success() for cpu v4

Yuan Chen (2):
      libbpf: Skip bpf_object__probe_loading() when BPF token is in use
      bpftool: Fix double close in map dump

luoliang (1):
      bpftool: Use btf_vlen()/btf_kind()/btf_kflag() helpers consistently

 Documentation/bpf/bpf_devel_QA.rst                 |    5 +-
 Documentation/bpf/index.rst                        |    1 +
 Documentation/bpf/kfuncs.rst                       |   99 +-
 Documentation/bpf/signing.rst                      |  497 +++
 Documentation/process/changes.rst                  |    5 -
 MAINTAINERS                                        |    6 +-
 arch/arm64/include/asm/insn.h                      |   23 +
 arch/arm64/lib/insn.c                              |   60 +
 arch/arm64/net/bpf_jit.h                           |   11 +
 arch/arm64/net/bpf_jit_comp.c                      |  227 +-
 arch/riscv/net/Makefile                            |    2 +-
 arch/riscv/net/bpf_jit.h                           |    1 +
 arch/riscv/net/bpf_jit_comp32.c                    |  111 +-
 arch/riscv/net/bpf_jit_comp64.c                    |  158 +-
 arch/riscv/net/bpf_jit_core.c                      |    5 +-
 arch/riscv/net/bpf_timed_may_goto.S                |   47 +
 arch/s390/net/bpf_jit_comp.c                       |  213 +-
 arch/x86/mm/init.c                                 |    4 +-
 arch/x86/net/bpf_jit_comp.c                        |  178 +-
 drivers/hid/bpf/hid_bpf_dispatch.c                 |   10 +-
 include/linux/bpf.h                                |  123 +-
 include/linux/bpf_ksock.h                          |   36 +
 include/linux/bpf_verifier.h                       |  173 +-
 include/linux/btf.h                                |    2 +
 include/linux/filter.h                             |   70 +-
 include/linux/socket.h                             |    2 +
 include/uapi/linux/bpf.h                           |  117 +-
 kernel/bpf/Makefile                                |    2 +-
 kernel/bpf/arena.c                                 |   43 +-
 kernel/bpf/arraymap.c                              |   72 +-
 kernel/bpf/backtrack.c                             |    5 +-
 kernel/bpf/bloom_filter.c                          |   19 +-
 kernel/bpf/bpf_iter.c                              |   17 +-
 kernel/bpf/bpf_lsm.c                               |    5 +-
 kernel/bpf/bpf_struct_ops.c                        |   68 +-
 kernel/bpf/btf.c                                   |  100 +-
 kernel/bpf/cfg.c                                   |   38 +-
 kernel/bpf/cgroup.c                                |   35 +-
 kernel/bpf/check_btf.c                             |   14 +-
 kernel/bpf/const_fold.c                            |   12 +-
 kernel/bpf/core.c                                  |   95 +-
 kernel/bpf/cpumask.c                               |    6 +-
 kernel/bpf/diagnostics.c                           | 2359 +++++++++++++
 kernel/bpf/diagnostics.h                           |  111 +
 kernel/bpf/disasm.c                                |   68 +-
 kernel/bpf/dispatcher.c                            |    5 +-
 kernel/bpf/fixups.c                                |  254 +-
 kernel/bpf/hashtab.c                               |    2 -
 kernel/bpf/helpers.c                               |  116 +-
 kernel/bpf/liveness.c                              |  120 +-
 kernel/bpf/log.c                                   |   11 -
 kernel/bpf/mmap_unlock_work.h                      |   51 +-
 kernel/bpf/net_namespace.c                         |   17 +-
 kernel/bpf/queue_stack_maps.c                      |    9 +-
 kernel/bpf/ringbuf.c                               |    6 +-
 kernel/bpf/rqspinlock.c                            |    8 +-
 kernel/bpf/stackmap.c                              |  351 +-
 kernel/bpf/states.c                                |    3 +-
 kernel/bpf/syscall.c                               |  142 +-
 kernel/bpf/task_iter.c                             |   48 +-
 kernel/bpf/trampoline.c                            |   73 +-
 kernel/bpf/verifier.c                              | 3525 +++++++++++++-------
 kernel/trace/bpf_trace.c                           |  119 +-
 net/core/Makefile                                  |    3 +
 net/core/bpf_ksock.c                               |  328 ++
 net/core/filter.c                                  |  506 ++-
 net/core/lwt_bpf.c                                 |   15 +-
 net/core/sock_map.c                                |    8 +-
 net/ipv4/tcp_ipv4.c                                |    4 +-
 net/socket.c                                       |   32 +-
 net/unix/af_unix.c                                 |    4 +-
 scripts/Makefile.btf                               |    4 +-
 tools/bpf/bpftool/Makefile                         |    2 +-
 tools/bpf/bpftool/btf.c                            |   13 +-
 tools/bpf/bpftool/btf_dumper.c                     |   14 +-
 tools/bpf/bpftool/common.c                         |    4 +
 tools/bpf/bpftool/gen.c                            |   55 +-
 tools/bpf/bpftool/link.c                           |  133 +
 tools/bpf/bpftool/map.c                            |   16 +-
 tools/bpf/bpftool/sign.c                           |   24 +-
 tools/bpf/bpftool/struct_ops.c                     |    4 +
 tools/bpf/bpftool/xlated_dumper.c                  |   19 +-
 tools/bpf/resolve_btfids/Makefile                  |    5 +-
 tools/bpf/resolve_btfids/main.c                    |  476 ++-
 tools/include/linux/btf_ids.h                      |   78 +-
 tools/include/uapi/linux/bpf.h                     |  117 +-
 tools/lib/bpf/bpf_gen_internal.h                   |    4 +-
 tools/lib/bpf/btf.c                                |   20 +-
 tools/lib/bpf/btf.h                                |    2 +
 tools/lib/bpf/btf_dump.c                           |    4 +-
 tools/lib/bpf/btf_relocate.c                       |    8 +-
 tools/lib/bpf/elf.c                                |    2 +-
 tools/lib/bpf/features.c                           |   35 +
 tools/lib/bpf/gen_loader.c                         |   95 +-
 tools/lib/bpf/libbpf.c                             |  183 +-
 tools/lib/bpf/libbpf.map                           |    1 +
 tools/lib/bpf/libbpf_internal.h                    |    5 +-
 tools/lib/bpf/nlattr.c                             |    2 +-
 tools/lib/bpf/relo_core.c                          |   22 +-
 tools/lib/bpf/ringbuf.c                            |    2 +-
 tools/lib/bpf/skel_internal.h                      |   55 +-
 tools/lib/bpf/usdt.c                               |   33 +-
 tools/sched_ext/include/scx/compat.bpf.h           |    2 +-
 tools/testing/selftests/bpf/DENYLIST.riscv64       |    1 -
 tools/testing/selftests/bpf/Makefile               |   32 +-
 tools/testing/selftests/bpf/README.rst             |    4 +-
 tools/testing/selftests/bpf/bench.c                |    4 +
 tools/testing/selftests/bpf/benchs/bench_bpf_for.c |  104 +
 .../selftests/bpf/benchs/run_bench_bpf_for.sh      |   15 +
 tools/testing/selftests/bpf/bpf_experimental.h     |    7 +
 tools/testing/selftests/bpf/config.aarch64         |    1 -
 tools/testing/selftests/bpf/config.ppc64el         |    1 -
 tools/testing/selftests/bpf/config.riscv64         |    1 -
 tools/testing/selftests/bpf/config.s390x           |    1 -
 tools/testing/selftests/bpf/config.x86_64          |    1 -
 tools/testing/selftests/bpf/disasm_helpers.c       |    3 +-
 .../bpf/libarena/include/bpf_arena_spin_lock.h     |    7 +-
 .../selftests/bpf/libarena/include/bpf_atomic.h    |   20 +
 .../bpf/libarena/include/libarena/bitmap.h         |   34 +
 .../bpf/libarena/include/libarena/common.h         |    2 +-
 .../bpf/libarena/include/libarena/userspace.h      |    2 +-
 .../{st_asan_buddy.bpf.c => test_asan_buddy.bpf.c} |   10 +-
 .../{st_asan_common.h => test_asan_common.h}       |    0
 .../bpf/libarena/selftests/test_bitmap.bpf.c       |  394 +++
 .../selftests/{st_buddy.bpf.c => test_buddy.bpf.c} |    8 +-
 .../libarena/selftests/test_parallel_bitmap.bpf.c  |  190 ++
 .../libarena/selftests/test_parallel_spmc.bpf.c    |    9 +-
 .../selftests/bpf/libarena/src/bitmap.bpf.c        |  245 ++
 .../selftests/bpf/libarena/src/common.bpf.c        |   16 +-
 tools/testing/selftests/bpf/network_helpers.c      |   28 +-
 tools/testing/selftests/bpf/network_helpers.h      |    5 +
 .../selftests/bpf/prog_tests/arena_atomics.c       |    2 +-
 .../selftests/bpf/prog_tests/arena_direct_value.c  |    2 +-
 .../testing/selftests/bpf/prog_tests/arena_htab.c  |    2 +-
 .../testing/selftests/bpf/prog_tests/arena_list.c  |    2 +-
 .../selftests/bpf/prog_tests/arena_mem_usage.c     |  122 +
 .../selftests/bpf/prog_tests/arena_spin_lock.c     |    2 +-
 .../selftests/bpf/prog_tests/arena_strsearch.c     |    2 +-
 tools/testing/selftests/bpf/prog_tests/bpf_qdisc.c |    2 +
 .../testing/selftests/bpf/prog_tests/bpf_tcp_ca.c  |   12 +
 tools/testing/selftests/bpf/prog_tests/btf.c       |   48 +
 .../selftests/bpf/prog_tests/cgroup_iter_memcg.c   |   43 +
 .../selftests/bpf/prog_tests/fexit_bpf2bpf.c       |   71 +-
 .../testing/selftests/bpf/prog_tests/fib_lookup.c  |  741 +++-
 .../selftests/bpf/prog_tests/fill_link_info.c      |  242 ++
 .../bpf/prog_tests/get_smp_processor_id.c          |   45 +
 .../selftests/bpf/prog_tests/global_data_init.c    |  336 ++
 .../selftests/bpf/prog_tests/global_map_resize.c   |    8 +-
 .../selftests/bpf/prog_tests/icmp_send_kfunc.c     |  292 ++
 .../testing/selftests/bpf/prog_tests/kfunc_call.c  |    4 +
 tools/testing/selftests/bpf/prog_tests/ksock.c     |  130 +
 tools/testing/selftests/bpf/prog_tests/ksock_wq.c  |   45 +
 tools/testing/selftests/bpf/prog_tests/libarena.c  |   28 +-
 .../selftests/bpf/prog_tests/libarena_asan.c       |   10 +-
 .../testing/selftests/bpf/prog_tests/linked_list.c |    1 +
 tools/testing/selftests/bpf/prog_tests/lsm_bdev.c  |    3 +-
 .../selftests/bpf/prog_tests/lwt_ip_encap.c        |   11 +-
 tools/testing/selftests/bpf/prog_tests/mptcp.c     |   13 +-
 .../selftests/bpf/prog_tests/rcu_read_lock.c       |    2 +
 .../selftests/bpf/prog_tests/res_spin_lock.c       |   20 +
 .../selftests/bpf/prog_tests/resolve_btfids.c      |  270 +-
 tools/testing/selftests/bpf/prog_tests/sha256.c    |    4 +-
 .../selftests/bpf/prog_tests/signed_loader.c       | 1033 +++++-
 .../selftests/bpf/prog_tests/sockmap_basic.c       |   52 -
 tools/testing/selftests/bpf/prog_tests/sockopt.c   |   22 +
 tools/testing/selftests/bpf/prog_tests/stream.c    |    6 +
 tools/testing/selftests/bpf/prog_tests/tailcalls.c |   55 +
 .../testing/selftests/bpf/prog_tests/task_kfunc.c  |    8 +
 .../testing/selftests/bpf/prog_tests/tc_redirect.c |   68 +
 .../selftests/bpf/prog_tests/test_map_uninit.c     |   68 +
 .../bpf/prog_tests/test_struct_ops_arena.c         |  128 +
 .../selftests/bpf/prog_tests/test_tc_tunnel.c      |    1 -
 .../selftests/bpf/prog_tests/test_veristat.c       |  113 +-
 .../selftests/bpf/prog_tests/tracing_failure.c     |   20 +
 .../selftests/bpf/prog_tests/tracing_multi.c       |   69 +
 .../selftests/bpf/prog_tests/tracing_struct.c      |   36 +
 tools/testing/selftests/bpf/prog_tests/verifier.c  |   16 +
 tools/testing/selftests/bpf/progs/arena_atomics.c  |   18 +-
 tools/testing/selftests/bpf/progs/arena_kfunc.c    |  243 ++
 .../testing/selftests/bpf/progs/arena_kfunc_jit.c  |  118 +
 .../testing/selftests/bpf/progs/arena_mem_usage.c  |   40 +
 .../testing/selftests/bpf/progs/arena_spin_lock.c  |    7 +
 tools/testing/selftests/bpf/progs/bpf_for_bench.c  |   32 +
 tools/testing/selftests/bpf/progs/bpf_misc.h       |    9 +-
 .../bpf/progs/bpf_qdisc_fail__untrusted_write.c    |   65 +
 .../testing/selftests/bpf/progs/bpf_tracing_net.h  |    5 +
 tools/testing/selftests/bpf/progs/btf_data.c       |   40 +
 .../selftests/bpf/progs/cgrp_kfunc_failure.c       |    2 +-
 tools/testing/selftests/bpf/progs/cpumask_common.h |    2 +-
 .../testing/selftests/bpf/progs/cpumask_failure.c  |   31 +-
 .../testing/selftests/bpf/progs/cpumask_success.c  |    6 +-
 tools/testing/selftests/bpf/progs/dynptr_fail.c    |    8 +-
 .../testing/selftests/bpf/progs/fentry_sleepable.c |   18 +
 tools/testing/selftests/bpf/progs/fib_lookup.c     |   57 +
 .../selftests/bpf/progs/freplace_cls_redirect.c    |   34 -
 .../selftests/bpf/progs/get_smp_processor_id.c     |   20 +
 tools/testing/selftests/bpf/progs/icmp_send.c      |  123 +
 tools/testing/selftests/bpf/progs/iters.c          |   83 +
 .../selftests/bpf/progs/iters_task_failure.c       |   46 +
 .../testing/selftests/bpf/progs/kfunc_call_fail.c  |   72 +
 .../testing/selftests/bpf/progs/kfunc_call_test.c  |   12 +
 tools/testing/selftests/bpf/progs/ksock_common.h   |   78 +
 tools/testing/selftests/bpf/progs/ksock_lsm.c      |   72 +
 .../selftests/bpf/progs/ksock_lsm_verifier.c       |   35 +
 tools/testing/selftests/bpf/progs/ksock_wq.c       |   62 +
 .../testing/selftests/bpf/progs/linked_list_fail.c |   23 +
 tools/testing/selftests/bpf/progs/map_kptr.c       |   12 +
 tools/testing/selftests/bpf/progs/map_kptr_fail.c  |    9 +
 .../selftests/bpf/progs/mem_rdonly_untrusted.c     |  236 +-
 tools/testing/selftests/bpf/progs/mptcpify.c       |    2 +-
 tools/testing/selftests/bpf/progs/pyperf.h         |   12 +-
 tools/testing/selftests/bpf/progs/rcu_read_lock.c  |   76 +
 .../selftests/bpf/progs/refcounted_kptr_fail.c     |    9 +
 tools/testing/selftests/bpf/progs/setget_sockopt.c |    2 +
 .../selftests/bpf/progs/sockmap_verdict_prog.c     |   14 +-
 tools/testing/selftests/bpf/progs/stream.c         |  147 +
 .../testing/selftests/bpf/progs/struct_ops_arena.c |  139 +
 .../selftests/bpf/progs/struct_ops_arena_attach.c  |   25 +
 .../selftests/bpf/progs/struct_ops_arena_fail.c    |   20 +
 .../selftests/bpf/progs/tailcall_callback.c        |   81 +
 .../selftests/bpf/progs/task_kfunc_common.h        |   14 +
 .../selftests/bpf/progs/task_kfunc_failure.c       |   75 +-
 .../selftests/bpf/progs/task_kfunc_success.c       |  195 ++
 .../bpf/progs/tcp_ca_untrusted_btf_write.c         |   26 +
 .../selftests/bpf/progs/test_fill_link_info.c      |    6 +
 .../selftests/bpf/progs/test_global_percpu_data.c  |   89 +
 .../selftests/bpf/progs/test_signed_loader.c       |    9 +-
 .../selftests/bpf/progs/test_sockmap_update.c      |   48 -
 tools/testing/selftests/bpf/progs/test_tc_peer.c   |   22 +
 tools/testing/selftests/bpf/progs/test_tc_tunnel.c |   91 +-
 .../testing/selftests/bpf/progs/tracing_failure.c  |    6 +
 .../bpf/progs/tracing_multi_intersect_attach.c     |    8 +
 .../selftests/bpf/progs/tracing_struct_int128.c    |   18 +
 tools/testing/selftests/bpf/progs/verifier_arena.c |   72 +-
 .../selftests/bpf/progs/verifier_basic_stack.c     |    6 +-
 .../testing/selftests/bpf/progs/verifier_bounds.c  |    2 +-
 .../selftests/bpf/progs/verifier_bpf_fastcall.c    |   32 +-
 .../selftests/bpf/progs/verifier_global_subprogs.c |   10 +-
 tools/testing/selftests/bpf/progs/verifier_gotox.c |   25 +
 .../bpf/progs/verifier_helper_access_var_len.c     |    6 +-
 .../bpf/progs/verifier_helper_value_access.c       |    2 +-
 .../selftests/bpf/progs/verifier_load_acquire.c    |   44 +
 .../selftests/bpf/progs/verifier_map_in_map.c      |    3 +-
 .../bpf/progs/verifier_map_lookup_refine.c         |   73 +
 .../testing/selftests/bpf/progs/verifier_map_ptr.c |   23 +-
 .../selftests/bpf/progs/verifier_may_goto_1.c      |   67 +
 .../selftests/bpf/progs/verifier_mem_size_reg.c    |   28 +
 .../selftests/bpf/progs/verifier_percpu_addr.c     |   72 +
 .../selftests/bpf/progs/verifier_private_stack.c   |   15 +-
 .../selftests/bpf/progs/verifier_scalar_ids.c      |   56 +
 .../selftests/bpf/progs/verifier_sockmap_mutate.c  |   12 +-
 .../selftests/bpf/progs/verifier_spill_fill.c      |   68 +
 .../bpf/progs/verifier_subprog_insn_stats.c        |  223 ++
 .../testing/selftests/bpf/progs/verifier_uninit.c  |    1 +
 .../testing/selftests/bpf/progs/verifier_unpriv.c  |   18 +
 .../testing/selftests/bpf/progs/verifier_var_off.c |  116 +-
 .../selftests/bpf/progs/verifier_vfs_reject.c      |    6 +-
 tools/testing/selftests/bpf/progs/verifier_zext.c  |  392 +++
 tools/testing/selftests/bpf/progs/veristat_bar.c   |    3 +
 tools/testing/selftests/bpf/progs/veristat_foo.c   |   31 +
 tools/testing/selftests/bpf/progs/xdp_dummy.c      |    6 +
 .../testing/selftests/bpf/test_kmods/bpf_testmod.c |  131 +-
 .../testing/selftests/bpf/test_kmods/bpf_testmod.h |   14 +
 .../selftests/bpf/test_kmods/bpf_testmod_kfunc.h   |   13 +
 tools/testing/selftests/bpf/test_loader.c          |    2 +-
 tools/testing/selftests/bpf/test_progs.c           |   91 +-
 tools/testing/selftests/bpf/test_progs.h           |    3 +-
 tools/testing/selftests/bpf/test_sockmap.c         |    3 +-
 tools/testing/selftests/bpf/test_verifier.c        |    2 +-
 tools/testing/selftests/bpf/verifier/calls.c       |   18 +-
 tools/testing/selftests/bpf/veristat.c             |  122 +-
 tools/testing/selftests/bpf/vmtest.sh              |   13 +-
 272 files changed, 18968 insertions(+), 3417 deletions(-)
 create mode 100644 Documentation/bpf/signing.rst
 create mode 100644 arch/riscv/net/bpf_timed_may_goto.S
 create mode 100644 include/linux/bpf_ksock.h
 create mode 100644 kernel/bpf/diagnostics.c
 create mode 100644 kernel/bpf/diagnostics.h
 create mode 100644 net/core/bpf_ksock.c
 create mode 100644 tools/testing/selftests/bpf/benchs/bench_bpf_for.c
 create mode 100755 tools/testing/selftests/bpf/benchs/run_bench_bpf_for.sh
 create mode 100644 tools/testing/selftests/bpf/libarena/include/libarena/bitmap.h
 rename tools/testing/selftests/bpf/libarena/selftests/{st_asan_buddy.bpf.c => test_asan_buddy.bpf.c} (98%)
 rename tools/testing/selftests/bpf/libarena/selftests/{st_asan_common.h => test_asan_common.h} (100%)
 create mode 100644 tools/testing/selftests/bpf/libarena/selftests/test_bitmap.bpf.c
 rename tools/testing/selftests/bpf/libarena/selftests/{st_buddy.bpf.c => test_buddy.bpf.c} (97%)
 create mode 100644 tools/testing/selftests/bpf/libarena/selftests/test_parallel_bitmap.bpf.c
 create mode 100644 tools/testing/selftests/bpf/libarena/src/bitmap.bpf.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/arena_mem_usage.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/get_smp_processor_id.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/icmp_send_kfunc.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/ksock.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/ksock_wq.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/test_map_uninit.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/test_struct_ops_arena.c
 create mode 100644 tools/testing/selftests/bpf/progs/arena_kfunc.c
 create mode 100644 tools/testing/selftests/bpf/progs/arena_kfunc_jit.c
 create mode 100644 tools/testing/selftests/bpf/progs/arena_mem_usage.c
 create mode 100644 tools/testing/selftests/bpf/progs/bpf_for_bench.c
 create mode 100644 tools/testing/selftests/bpf/progs/bpf_qdisc_fail__untrusted_write.c
 create mode 100644 tools/testing/selftests/bpf/progs/fentry_sleepable.c
 delete mode 100644 tools/testing/selftests/bpf/progs/freplace_cls_redirect.c
 create mode 100644 tools/testing/selftests/bpf/progs/get_smp_processor_id.c
 create mode 100644 tools/testing/selftests/bpf/progs/icmp_send.c
 create mode 100644 tools/testing/selftests/bpf/progs/ksock_common.h
 create mode 100644 tools/testing/selftests/bpf/progs/ksock_lsm.c
 create mode 100644 tools/testing/selftests/bpf/progs/ksock_lsm_verifier.c
 create mode 100644 tools/testing/selftests/bpf/progs/ksock_wq.c
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_arena.c
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_arena_attach.c
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_arena_fail.c
 create mode 100644 tools/testing/selftests/bpf/progs/tailcall_callback.c
 create mode 100644 tools/testing/selftests/bpf/progs/tcp_ca_untrusted_btf_write.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_global_percpu_data.c
 delete mode 100644 tools/testing/selftests/bpf/progs/test_sockmap_update.c
 create mode 100644 tools/testing/selftests/bpf/progs/tracing_struct_int128.c
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_map_lookup_refine.c
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_mem_size_reg.c
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_percpu_addr.c
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_subprog_insn_stats.c
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_zext.c
 create mode 100644 tools/testing/selftests/bpf/progs/veristat_bar.c
 create mode 100644 tools/testing/selftests/bpf/progs/veristat_foo.c
