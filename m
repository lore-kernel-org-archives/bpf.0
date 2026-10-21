Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792616513;
	b=XmNwk3y5b3ADCgFTO5dNGgRWKOTT/ZnqBoVw6MVvs3W4V2m9DC99feBSM5o+4jfOL/BC
	 fKpUOG+GuBpLAB60QptD6qv5ltm3mSpoZ69kGkSMmMdd0YJ1C36rgnUrLDxWlRDrVo1M/
	 ZEDqamOItL3A4zHx0A08pfQpcvN6/Fp2VO2YSQbwVuDFSokjgnk70mfsRR/EQ9nJ6L3Mv
	 W0j0/wZDK4GLgFH05grA2npmJ4gbblRT0Reek5c5211fuiske6Yb1Vbvm0E3w0yywmiBC
	 Xj/CixT011s4jkuPJQGbO+CllhNeJfnsWyVm28kykZzamNosQuC3eyLz3UEIHTee6pg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792616513;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=gm2EGCkjZQIzUOL4p7UH6cFajwQ4jyO1KjxHxA8FdfI=;
	b=YucN89jd7t8H6kM4X9ITD4mC+PUNgq4olXkz4q6R2/Gqn5PCykaxnVa9XmEPT4fAnXtH
	 R59eL4vzA/dL08JZETl96eI4NVFnHoKX6cU5wpRuWy002lfYGKGKLe07NjChG8muOveoA
	 Tv13lhFVThnB6lgQKUdMJ+nF4b6XbWXEBWZKN7EhREuDM6QigFu1vYa0vXhPRV3If4h1u
	 seuZhajBhaZBDlnaPCWNPg6BuPBIKLYwu9jop8Y5QiFF1gSLExVZKU47z9LnKjuqvxZOs
	 abg6+iceb7A5r6zydlv98Wp7gS2iNMmbCU3Ru6sD1aX1qtSf9fg20nyueqXCanXkNzA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=io6046rI;
	arc=none smtp.remote-ip=209.85.216.49
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED30F606A31B
	for <bpf@vger.kernel.org>; Wed, 21 Oct 2026 21:01:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ED30F606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=io6046rI
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-3ac5b090d16so151507a91.0
        for <bpf@vger.kernel.org>; Wed, 21 Oct 2026 14:01:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792616511; x=1793221311; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gm2EGCkjZQIzUOL4p7UH6cFajwQ4jyO1KjxHxA8FdfI=;
        b=io6046rIfSJlP4oRf+LPjmxOty6eC3PJihU5HeZSHJWKOd1VJXZ5xHfukkp4/23ihS
         EuNkGjn67cb3ppV7ypEYkiM8HVts1EjL0kRot216SnHhD6FSz+NZ1AhE4DPZZ8g8tzgp
         0veeoDqSckyXY9W9F73hkmfJgWhr1T6GdvxKL/D4MAKEoNggikE+oCjZp1rEZPfS/0Dn
         x9Rqgl3WQ8b+/PwHTeHffBAvjS1tHqASOmArxooVQA9bn+2WqibCqtNba7JllY46b6I2
         JeA2klX8HaLE6K9xF+e9DCgMEQ1hCiEEdk87QhZBoQoMJVFZqMXNleCMNvligJIJ0KMD
         Vgyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792616511; x=1793221311;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=gm2EGCkjZQIzUOL4p7UH6cFajwQ4jyO1KjxHxA8FdfI=;
        b=DbmlKClfoxKr22Ntag+9e9eHCOQSdkPUSZzjJBHJWJaOmBJy2zxqher1anpsKZxioy
         oRRYdMuRw00G8zZ1/qYmUXZ44ZCkDkUjPxmAnT01EFWskiT7Lm437gfL+sOKSJOXOvPU
         J1PNxT/ekWJ5K/AqVO93MdAoB4INsybJQQBBQREMSCAXxwplh2IYSOTrYteisafZqbRK
         YuI9MsxnMFJkkzic8XlD64fWeFQTAX09f6csZo0Yg6q/j0WaUzi3M3HDljDQDxJXB37l
         g7e2foIub3FME8eguiIC+vhITZngyFXYDepxN/EBp6RS/cbypL4d1UcUZyYv04NAGc23
         O4Zg==
X-Forwarded-Encrypted: i=1; AKwUvBxZDxJv4g8Rrq12ELf33mEvhiBsb2kFsBCrVt9eTCVTwWCaNRBaASajBmb1EZQpKagY3mo=@vger.kernel.org
X-Gm-Message-State: AFq9FYLRQ6XeYEfF0TjJiPQQF4qRyCzcg943b7voOIc0s4ku91l7q1zw
	0zQBH4fjuBVbcp56NPrbI8TdoOGGBpAcbu691QK8J6Hhu/D47EmCoLJZ
X-Gm-Gg: AYBFou36BIxpYxRjD9BprgJx4YCeNMUHqg4tS1ropmV7cCkpnHQ/j67fiuN46KVsl2H
	p6ZNnO8ZKMXsb9kHEVnsiV3pxhX6ZUZnJvdd5ZJ8LYa47R5NiV/QBuURfhRy2WlhfMyT7pT2HVS
	E8TOuBCrI6qaJb8mr/zXyGVbBWgvJRQVy2VH1jLQnmRagmh/o0vB6FkaAGWFS3F6GRMi6meFbUJ
	JYrFUt1/O/yDu0B0gS3oZP6vY8VPt0lvkyYo3uz/T9HkMhdYl7vshbcBXZ2DRVL6DwnG4k3w4X7
	BLWBH5gULHShn930ZrT7EbgXB/sxdQAtWHPs9HCRn2MiDLc+k3coKttAI7zAxMBdTgwRhVzz4gu
	Kif+ge+bC4jV3nLNkWcfOWhYCcGbONk90170Zyr0Q6h/g3Imb9PHn7kMNBs8GtW7220yUrurSGW
	e5rx23PPI8qws7hHDpKQlc7JXG8F6MvObYJZNExTeDbjeVXiTl2hobrpSlUw5ClozNvGyQLh5dV
	MOPqSkGQbaEPY/8CmgbjyGhfTFrTZVPMHsXS6+6jDqYVF+X5bkReDCzLWA4QdJQ08++WERFhnJn
	10MCy+y7SemGcCcb/PEgKOy6HgCI481cYZ6lZJ5Ld+uXnuaxyrJaLvpXJfcbNBR1Cu+JQ3QPkTi
	9Eswqj8Tq3c19LPwuXXr9fr3se2ehwmzsAaI/yJnk5UIB9w==
X-Received: by 2002:a17:90a:e7ce:b0:3ab:b39f:41ca with SMTP id 98e67ed59e1d1-3ada6c9d37cmr232042a91.31.1792616510398;
        Wed, 21 Oct 2026 14:01:50 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.249])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ada48a55d5sm1006137a91.9.2026.10.21.14.01.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 14:01:49 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: torvalds@linux-foundation.org
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	bpf@vger.kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	Alexei Starovoitov <ast@kernel.org>
Subject: [GIT PULL] BPF changes for 7.4
Date: Wed, 21 Oct 2026 21:01:45 +0000
Message-ID: <20261021210147.3450677-1-alexei.starovoitov@gmail.com>
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Linus,

The following changes since commit ff47652a4b66c067c765a7ad464d930b5a9367cc:

  Merge tag 'cifs-fixes-7.3-rc6' of https://git.manguebit.org/linux (2026-10-02 14:04:11 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git tags/bpf-next-7.4

for you to fetch changes up to b116ac6087541d3d98031e786adbe9c733cd6df3:

  selftests/bpf: Time tc_edt from its first packet with data (2026-10-21 17:50:51 +0000)

There is one trivial conflict with your current tree, in kernel/bpf/token.c,
between commit
  64cbb36448ff ("file: make struct fd_prepare const and kill its err field")
from vfs tree and commit
  f52b699c8863 ("bpf: Don't leak the inode when token creation fails")
from bpf-next.

That's what Mark reported:
https://lore.kernel.org/linux-next/atZBAZTtUd6mr09s@sirena.co.uk/

and there will be a trivial conflict in mm/internal.h with mm tree:
  ("mm/hugetlb: localize struct huge_bootmem_page")
removes lines next to __copy_remote_mm_str() added by
  69d38c792c53 ("mm: Add copy_remote_mm_str()")

https://lore.kernel.org/linux-next/arD9mGTj9upScb9t@sirena.co.uk/

----------------------------------------------------------------
Major changes:

- Introduce scalar evolution (SCEV) analysis in the verifier. It infers
  how registers and stack slots change in a loop and lets the verifier
  check bounded loops with induction variables as ranges instead of
  walking every iteration. The number of processed insns drops
  ten fold in programs with loops (Eduard Zingerman)

- Add 'callx' instruction: indirect call of a static BPF subprogram.
  The address is taken with ld_imm64 or loaded from read-only data.
  Supported by x86-64, arm64 and riscv64 JITs (Alexei Starovoitov,
  Pu Lehui)

- Add unwind_goto and unwind_exit instructions, so that Rust panic or
  C++ exception can run destructors of every frame it passes through.
  The normal path is free of unwind code. Supported by x86-64 and arm64
  JITs (Alexei Starovoitov)

- Support programs compiled by rust-bpf: treat load and store through
  a number as arena access with BPF_F_ARENA_SCALAR, accept rust
  names in BTF (Alexei Starovoitov)

- Raise BPF program stack size from 512 bytes to 2 KiB on x86-64 and
  arm64 (Kumar Kartikeya Dwivedi)

- Support struct, union and __int128 up to 16 bytes passed and returned
  by value in BPF subprograms and kfuncs, and fix x86-64 and arm64
  trampolines for such arguments (Yonghong Song)

- Introduce a common way to attach struct_ops to a cgroup via bpf_link.
  bpf_tcp_ops is the first user and mirrors TCP sock_ops callbacks
  (Martin KaFai Lau, Amery Hung)

- Describe inlined functions in BTF. New kinds tell where the inline
  sites are and how to fetch the arguments there.
  CONFIG_DEBUG_INFO_BTF_INLINE keeps it apart from the main BTF
  in .BTF.inline section or in btf_vmlinux_inline.ko
  (Alan Maguire)

- Fix many memory safety, lifetime and locking bugs in BPF core,
  verifier, iterators, local storage, dynptr, devmap, cpumap and
  seg6local (Josef Bacik, Alexei Starovoitov)

- Diff stat is dominated by selftests and by removal of lib/test_bpf.c.
  Its 16k lines of instruction tests were converted to BPF selftests
  that BPF CI runs on every architecture it covers (Daniel Borkmann)

Other features and fixes:

- Add KASAN checks to memory accesses of JITed programs on x86-64
  (Alexis Lothoré)

- Complete unification of helper, kfunc and subprog argument checks
  in the verifier (Amery Hung)

- Add bpf_copy_from_user_mm[_str]() kfuncs (Anastasios Papagiannis)

- Various features and fixes (Daniel Borkmann):
    - Add .bpf keyring for program signature verification, modelled
      after dm-verity keyring, and support ML-DSA in signing tools
    - Emit shorter and faster code in x86-64 JIT for patterns that
      LLVM generates
    - Fix various issues in gotox handling

- Let BPF LSM set xattrs at inode creation with bpf_inode_init_xattr()
  (David Windsor, Daniel Borkmann)

- Use sleepable page allocation in sleepable arena paths. Fix races
  between arena free, allocation and user page fault.
  (Emil Tsalapatis)

- Switch BPF crypto from lskcipher to AES-CBC and AES-ECB libraries
  (Eric Biggers)

- Add bpf_proactive_reclaim() kfunc (Hui Zhu)

- Render decl_tags in libbpf btf_dump and add tests for bpftool C dump
  (Ihor Solodrai)

- Speed up tracing_multi attach on x86 (Jiri Olsa)

- Various features and fixes (Kumar Kartikeya Dwivedi):
    - Add BPF_PROG_STREAM_OPEN command to read BPF streams through
      a file descriptor with poll support
    - Let kernel structs publish arena pointers with __arena type tag
    - Fix __uninit kfunc output buffers and fastcall rewrite with
      indirect stack accesses
    - Refuse CO-RE relocations for signed programs

- Add enqueue_rcvq and dequeue_rcvq hooks to bpf_tcp_ops to adjust
  sk_rcvlowat and avoid unnecessary wakeups (Kuniyuki Iwashima)

- Add bpf_ksock_sendto() kfunc and allow ksock connect and send
  from bpf_wq (Mahe Tardy)

- Fix racy plt target update in arm64 bpf_arch_text_poke()
  (Matthew Wood)

- Restructure BPF selftests Makefile as a layered build
  (Mykola Lysenko)

- Speed up hash map lookups for u32 and u64 keys (Mykyta Yatsenko)

- Add signed div/mod, movsx, bswap and gotol to MIPS JITs, signed
  div/mod to parisc JITs (Nicholas Dudar, Johan Almbladh)

- Fix stack overflow in build ID parser on 32-bit (Nickolai Zeldovich)

- Add stack arguments, signed arena loads and gotox to riscv64 JIT.
  Pu Lehui is now co-maintainer of riscv BPF JITs (Pu Lehui, Chen Pei,
  Feng Jiang)

- Add bpf_call_rcu() and bpf_call_rcu_tasks_trace() kfuncs. Support
  fetching and/or/xor atomics in arena on x86-64 (Puranjay Mohan)

- Fix flaky selftests, selftests with clang 23 and bpf-gcc
  (Qiliang Yuan, KaFai Wan, Vineet Gupta)

- Fix builds broken by fatal resolve_btfids warnings, BTF generation
  on ARC, and define arch_cmpxchg_local() on arc, hexagon and openrisc
  (Sasha Levin)

- Reduce memory use of hash maps by up to 50% per element
  (T.J. Mercier)

- Mark pointer fields of sched_ext ops arguments as trusted (Tejun Heo)

- Remove legacy bpf_asm, bpf_dbg and bpf_jit_disasm tools (Xia Yan)

- Fix index overflow in queue and stack maps, arena range tree after
  allocation failure, tail call loop after freplace detach, lost signal
  in bpf_send_signal() (Yuan Chen)

- Many more fixes and cleanups

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
----------------------------------------------------------------
Alan Maguire (23):
      btf: Extend UAPI to support BTF location (inline site) info
      libbpf: Add support for BTF kinds LOC[_PARAM|_PROTO|SEC]
      selftests/bpf: Test helper support for BTF_KIND_LOC[_PARAM|_PROTO|SEC]
      selftests/bpf: Add LOC_PARAM, LOC_PROTO, LOCSEC to field iter tests
      selftests/bpf: Add LOC_PARAM, LOC_PROTO, LOCSEC to dedup split tests
      selftests/bpf: BTF distill tests to ensure LOC[_PARAM|_PROTO] add to split BTF
      bpftool: Handle multi-split BTF by supporting multiple base BTFs
      bpftool: Document support for multi-split BTF
      bpftool: Add ability to dump LOC_PARAM, LOC_PROTO and LOCSEC
      selftests/bpf: Test bpftool dump of BTF location info
      Documentation/bpf: Describe new location-related BTF kinds
      bpf: Verify BTF_KIND_LOC_PARAM vlen, flags
      bpftool: Update func representation to include function signature
      selftests/bpf: Fix up bpftool btf dump test for signatures
      resolve_btfids: Populate BTF link section
      kbuild, btf: Expose vmlinux inline BTF through sysfs
      btf: Preserve string relocation maps for split BTF
      btf: Relocate and expose module inline BTF
      selftests/bpf: Test BTF sysfs inline representations
      selftests/bpf: Add a test verifying inline information
      btf: Fix size/vlen validation for BTF_KIND_LOC_PARAM
      selftests/bpf: Fix btf_inline to use .text section as base
      selftests/bpf: Enable CONFIG_DEBUG_INFO_BTF_INLINE for CI

Alexei Starovoitov (127):
      Merge branch 'bpf-allow-arena-pointers-in-by-value-returns'
      Merge branch 'bpf-keyring-and-signed-loader-ml-dsa-support'
      Merge branch 'bpftool-selftests-add-tests-for-c-dump-and-fix-a-dropped-type'
      Merge branch 'bpf-add-support-for-kasan-checks-in-jited-programs'
      Merge git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf 7.3-rc2
      Merge branch 'unify-helper-and-kfunc-argument-checks'
      Merge branch 'bpf-support-by-value-struct-and-__int128-arguments'
      selftests/bpf: Wait for links to come up in lwt_ip_encap
      Merge branch 'bpf-add-user-memory-access-kfuncs-for-mm_struct'
      Merge branch 'bpf-a-common-way-to-attach-struct_ops-to-a-cgroup'
      Merge branch 'bpf-lsm-xattrs-at-inode-creation-support'
      Merge branch 'fix-generic-__uninit-kfunc-output-buffers'
      Merge branch 'bpf-add-bpf_call_rcu-and-bpf_call_rcu_tasks_trace'
      Merge branch 'bpf-mips-add-signed-div-mod-support'
      Merge branch 'bpf-mips-add-bpf_movsx-support-to-the-jits'
      Merge branch 'bpf-arena-handle-memory-max-on-fault-in-with-reclaim'
      Merge branch 'bpf-arena-fix-range_tree-consistency-on-allocation-failure'
      bpf: Fix infinite loop in check_max_stack_depth()
      selftests/bpf: Test recursion through a global function and a callback
      bpf: Keep functions with address taken when removing dead code
      bpf: Prepare static analysis passes for callx instruction
      bpf: Add callx instruction to call bpf subprogs indirectly
      bpf: Add callx calls to the call graph
      bpf, x86: Add JIT support for callx
      bpf, arm64: Add JIT support for callx
      bpf: Discover subprogs described by func_info
      bpf: Recognize pointers to functions in read-only maps
      libbpf: Support pointers to static functions in data when linking
      libbpf: Resolve pointers to functions in read-only data
      libbpf: Treat .data.rel.ro as read-only data
      libbpf: Support pointers to functions in read-only data in light skeleton
      selftests/bpf: Add tests for callx
      selftests/bpf: Add tests for callx through pointers in read-only data
      bpf, docs: Document callx instruction
      Merge branch 'bpf-indirect-calls-of-bpf-subprogs-callx'
      Merge branch 'support-inline-functions-in-btf'
      Merge git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf 7.3-rc4
      Merge branch 'fix-fastcall-rewrite-with-indirect-stack-accesses'
      Merge branch 'raise-bpf-program-stack-size-to-2kib'
      selftests/bpf: Fix build of callx tests with GCC
      Merge branch 'follow-ups-for-verifier-errors-set'
      Merge branch 'bpf-expose-cgroup-preorder-attachment-state-to-userspace'
      Merge branch 'bpf-fix-loop-detection-for-re-arming-async-callbacks'
      selftests/bpf: Run callx prog_tests once
      bpf, x86: Fix timed may_goto with private stack
      selftests/bpf: Add test for timed may_goto with private stack
      bpf: Adjust pc-relative insn copied into its own patch
      selftests/bpf: Add tests for pc-relative insn copied into its own patch
      bpf: Fix overflow of jump offset in may_goto expansion
      selftests/bpf: Add tests for may_goto with far target
      bpf: Don't converge a loop on an iterator that was created anew
      selftests/bpf: Add tests for iterator created anew in its loop
      Merge branch 'bpf-fixes-for-may_goto-insn-patching-and-iterator-loops'
      Merge branch 'misc-bpf-gotox-fixes'
      Merge branch 'file-descriptor-interface-for-bpf-streams'
      Merge branch 'bpf-mips-add-jit-support-for-v4-instructions'
      Merge branch 'unify-subprog-argument-checks'
      Merge branch 'btf-inline-functionality-followups'
      Merge branch 'libbpf-render-decl_tags-in-btf_dump'
      Merge branch 'make-sleepable-arena-paths-use-sleepable-alloc_pages'
      Merge git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf 7.3-rc5
      bpf: Allow bitwise ops, shifts and mul/div on pointers with CAP_PERFMON
      selftests/bpf: Add tests for ALU on pointers with CAP_PERFMON
      bpf: Treat load and store through a number as arena access
      selftests/bpf: Add tests for arena access through numbers
      bpf: Allow names of Rust types and functions in BTF
      selftests/bpf: Add tests for names of Rust types and functions in BTF
      bpf: Allow arguments without names in static functions in BTF
      selftests/bpf: Add test for arguments without names in static functions
      bpf: Allow a variable in DATASEC that is smaller than its type
      bpftool: Skip pieces of variables in DATASEC
      selftests/bpf: Add tests for a variable that is smaller than its type
      libbpf: Keep global data in arena when the object has .arena.data
      libbpf: Keep format strings of bpf_printk() in .rodata.str
      selftests/bpf: Add test for global data in arena
      selftests/bpf: Add test for global data of a program in Rust
      selftests/bpf: Fix data_in_arena test with GCC
      selftests/bpf: Format data_in_arena_rust.rs with rustfmt
      Merge branch 'bpf-use-scalar-evolution-to-widen-bounded-loops'
      Merge branch 'bpf-test_run-fix-false-ebadmsg-with-bpf_f_test_skb_checksum_complete'
      Merge branch 'bpf-add-bpf_tcp_ops-hooks-for-tcp-autolowat'
      Merge branch 'riscv-bpf-support-indirect-calls-to-bpf-subprogs-callx'
      Merge branch 'riscv-bpf-prepare-for-upcoming-daily-ci'
      Merge branch 'bpf-riscv-add-support-for-indirect-jumps'
      Merge branch 'kbuild-bpf-support-inline-info-in-btf'
      bpf: Reject BTF ids with the same address in tracing_multi link
      selftests/bpf: Test tracing_multi link with BTF ids of the same address
      Merge branch 'inline-btf-followups'
      Merge branch 'bpf-htab-reduce-memory-use-of-hash-maps'
      Merge branch 'selftests-bpf-fix-prog_tests-framework-self-tests'
      Merge branch 'bpf-fix-task-work-scheduling-races'
      Merge branch 'selftests-bpf-fix-the-bpffs-handling-of-cgroup_hierarchical_stats'
      Merge branch 'bpf-two-trampoline-cleanups'
      Merge branch 'bpf-x86-support-fetching-and-or-xor-atomics-in-arena'
      Merge branch 'bpf-follow-up-by-value-struct-and-__int128-argument-support'
      Merge branch 'bpftool-fail-map-dump-for-maps-that-can-t-be-iterated'
      bpf: Clear sk_refcnt of a clone before its storage is linked
      bpf: Link the first element after its storage is published
      bpf: Don't take an extension for a writable raw tracepoint program
      Merge branch 'bpf-memory-safety-lifetime-and-locking-fixes'
      bpf: Don't take a program with a target program for an iterator
      bpf: Don't let an extension reach further into the context than its target
      bpf: Don't take an extension for a function that runs sleepable
      bpf: Refuse the prologue for an extension that cannot take it
      bpf: Unclone the skb for kfuncs that write through a dynptr
      bpf: Use memmove() to store bytes in an xdp_buff
      Merge branch 'bpf-memory-safety-lifetime-and-locking-fixes-followups'
      Merge branch 'bpf-zero-extend-the-index-in-inlined-bpf_get_func_arg'
      Merge branch 'selftests-bpf-fix-selftests-fails-with-clang23'
      Merge branch 'bpf-fix-incorrect-handling-of-user-flags-by-percpu-map-updates'
      bpf: Refuse the prologue for an extension if callers keep packet pointers
      Merge branch 'fix-some-arena-paper-cuts'
      Merge branch 'bpf-fix-builds-broken-by-fatal-resolve_btfids-warnings'
      Merge branch 'refuse-co-re-relocations-for-a-signed-program'
      Merge branch 'bpf-fix-arena-memory-incoherence'
      bpf: Add unwind_goto and unwind_exit insns
      bpf, x86: Support unwind_goto and unwind_exit
      bpf, arm64: Support unwind_goto and unwind_exit
      selftests/bpf: Add tests for unwind_goto and unwind_exit
      selftests/bpf: Add a C++ prog with exceptions
      Merge branch 'bpf-unwinding-with-unwind_goto-and-unwind_exit'
      Merge branch 'bpf-add-bpf_ksock_sendto-kfunc'
      bpf: Make unwind_exit of an exception callback exit in JITs
      bpf: Reject unwind_goto and unwind_exit in offloaded progs
      selftests/bpf: Test unwind_exit of an exception callback
      Merge branch 'bpf-support-32-bit-linear-scalar-evolution'
      Merge branch 'bpf-fixes-for-unwind_goto-and-unwind_exit'

Alexis Lothoré (eBPF Foundation) (9):
      selftests/bpf: Allocate a larger timeout for connection
      bpf: mark instructions accessing program stack
      bpf: add BPF_JIT_KASAN for KASAN instrumentation of JITed programs
      bpf, x86: refactor BPF_ST management in do_jit
      bpf, x86: emit KASAN checks in x86 JITed programs
      bpf, x86: enable KASAN for JITed programs on x86
      selftests/bpf: make cmdline_contains stricter
      selftests/bpf: add helpers for KASAN in JIT testing
      selftests/bpf: add tests to validate KASAN on JIT programs

Amery Hung (38):
      bpf: Pass call metadata through shared argument checks
      bpf: Address check_func_arg() arguments by argno
      bpf: Only compare func_id against BPF_FUNC_* for helper calls
      bpf: Only compare func_id against kfunc BTF IDs for kfunc calls
      bpf: Clarify unused and scalar function argument types
      bpf: Unify kfunc argument kinds with enum bpf_arg_type
      bpf: Classify kfunc arguments the verifier ignores
      bpf: Align helper and kfunc ARG_PTR_TO_PROG_AUX handling
      bpf: Set OBJ_RELEASE when generating kfunc argument types
      bpf: Set MEM_UNINIT and dynptr subtypes when generating kfunc arg types
      bpf: Set MEM_RCU when generating kfunc argument types
      bpf: Resolve BTF ID of ARG_PTR_TO_BTF_ID in kfunc bpf_func_proto
      bpf: Resolve ARG_PTR_TO_MEM | MEM_FIXED_SIZE size in kfunc bpf_func_proto
      bpf: Consolidate runtime argument type resolution
      bpf: Consolidate nullable argument validation
      bpf: Drop redundant BTF pointer helper write rejection
      bpf: Consolidate helper and kfunc PTR_TO_BTF_ID argument matching
      bpf: Admit kfunc argument registers through check_reg_type()
      bpf: Consolidate function call pkt_access validation
      selftests/bpf: Test kfunc packet memory direct writes
      bpf: Consolidate release argument validation
      selftests/bpf: Test nullable per-CPU kptr identity after exchange
      bpf: Check helper and kfunc arguments in one path
      bpf: Allow all struct_ops to use bpf_dynptr_from_skb()
      bpf: tcp: Support selected sock_ops callbacks as struct_ops
      bpf: tcp: Support parse/len/write header option hooks in bpf_tcp_ops
      selftests/bpf: Add test for bpf_tcp_ops header option hooks
      bpf: Fix kfunc BTF parameter lookups after wide arguments
      bpf: Identify subprog calls in argument metadata
      bpf: Build argument prototypes for subprog calls
      bpf: Check subprog scalar arguments in the common path
      bpf: Check global subprog untrusted arguments in the common path
      bpf: Check subprog context arguments in the common path
      bpf: Check subprog arena arguments in the common path
      bpf: Check subprog dynptr arguments in the common path
      bpf: Check global subprog BTF-ID arguments in the common path
      bpf: Check global subprog memory arguments in the common path
      bpf: Check all subprog arguments in the common path

Anastasios Papagiannis (5):
      mm: Add copy_remote_mm_str()
      exec: Clear bprm->mm before dropping its reference
      bpf: Add user memory access kfuncs for mm_struct
      bpf: Mark linux_binprm->mm as trusted-or-null
      selftests/bpf: Test mm_struct user memory kfuncs with linux_binprm

Andrii Nakryiko (8):
      Merge branch 'bpf-fix-queue-stack-map-u32-index-overflow'
      Merge branch 'libbpf-move-section-defined-program-flags-to-prog_flags'
      Merge branch 'libbpf-fix-array-comparison-in-btf-dedup'
      Merge branch 'bpftool-improve-perf-counter-reporting'
      Merge branch 'libbpf-improve-bpf-load-performance-by-selectively-loading-module-btfs'
      Merge branch 'bpftool-consume-ring-buffer-maps-with-event_pipe'
      libbpf: Fix static linking of externs placed in allocated sections
      selftests/bpf: Add linked_externs test for externs in allocated sections

Arnd Bergmann (1):
      bpf: Add printf attributes

Bradley Morgan (1):
      bpf: btf: Make alloc_obj_fields array const

Chen Pei (6):
      bpf, riscv: Add support for signed arena loads
      selftests/bpf: Enable arena LDSX tests for riscv64
      bpf, riscv: Add support for indirect jumps
      selftests/bpf: Enable gotox tests for riscv64
      selftests/bpf: Enable gotox liveness test for riscv64
      selftests/bpf: Enable instruction array test for riscv64

Colin Ian King (2):
      selftests/bpf: test_xsk: Fix spelling mistake "conigure" -> "configure"
      selftests/bpf: Fix spelling mistakes in descr literal strings

Daniel Borkmann (59):
      bpf, keys: Add a bpf keyring for program signature validation
      bpf: Refuse caller-supplied keyrings when the bpf one is active
      bpf: Raise the bound on a program's signature size
      bpftool: Support ML-DSA program signing
      selftests/bpf: Add a test for the sealed bpf keyring
      selftests/bpf: Rebuild signed lskels when signing key changes
      selftests/bpf: Rename the verify_sig_setup.sh setup into setup-rsa
      selftests/bpf: Add an end-to-end ML-DSA signed loader test
      selftests/bpf: Allow appending to guest kernel cmdline in vmtest.sh
      selftests/bpf: Add tests for bpf keyring in signed loader
      Documentation/bpf: Document the bpf keyring and improve examples
      bpf, lsm: Reject writes into the BPF LSM program context
      bpf, lsm: Mark the BPF LSM hook overrides noinline
      selftests/bpf: Test that the BPF LSM context is read-only
      selftests/bpf: Add verifier tests for the __ctx_out plumbing
      selftests/bpf: Add tests for BPF LSM inode init labelling
      bpf: Avoid quadratic successor rescan in bpf_compute_scc
      bpf: Bound the number of indirect jump edges in a program
      bpf: Rebase the exception callback subprog when dead subprogs are removed
      bpf: Leave out the hidden exit edge of a subprogram without an exit
      bpf: Cache the jump table of a subprogram during CFG discovery
      bpf: Reject indirect jumps that leave their subprogram
      bpf: Don't remove indirect jump targets in the nop removal pass
      bpf: Clear insn array jitted pointers on map reuse
      bpf: Clear the insn array used flag with release semantics
      bpf: Retarget indirect jump targets across prologue prepends
      selftests/bpf: Add tests for the indirect jump edge limit
      selftests/bpf: Add a test for a tail call in a subprogram without an exit
      selftests/bpf: Add tests for indirect jumps across subprograms
      selftests/bpf: Add a test for gotox nop targets
      selftests/bpf: Add tests for gotox targets across prologue prepends
      selftests/bpf: Add a test for an exception callback behind a dead subprog
      selftests/bpf: Fix gcc -Wreturn-type error in the tail call subprog test
      Merge branch 'follow-ups-for-verifier-errors-set'
      Merge branch 'bpf-follow-up-for-scalar-evolution-series'
      bpf, x86: Drop redundant REX prefixes from zero and sign extensions
      bpf, x86: Omit the displacement byte for zero offsets
      bpf, x86: Shorten the stack adjusts and the tail call counter loads
      bpf, x86: Use shorter test and cmp encodings for immediates
      bpf, x86: Compare against 0, 127 and -128 with the adjusted condition
      bpf, x86: Use movzx for byte and word masks and a not for xor with -1
      bpf, x86: Consolidate the ALU, shift and neg encodings into helpers
      bpf, x86: Use shorter and faster forms for some ALU immediates
      bpf, x86: Swap 16-bit values with bswap and shr, not ror and movzx
      bpf, x86: Use BMI2 shifts also when the count is in rcx
      bpf, x86: Fold the PROBE_MEM address computation into a lea
      bpf, x86: Compare the PROBE_MEM address range with a shift
      bpf, x86: Divide by constants via multiplication with a magic number
      bpf, x86: Multiply by 3, 5 and 9 with lea
      bpf, x86: Use emit_sub_rsp() for the trampoline stack
      bpf, x86: Shorten the cast to a user address
      selftests/bpf: Add JIT instruction tests
      selftests/bpf: Remove the old test_bpf module
      bpf, s390: Mask the count of 32-bit shifts by register
      selftests/bpf: Restore the je <-> jmp distance in convergence check
      selftests/bpf: Follow-up to JIT instruction tests
      bpf: Free the subprog jump tables once the CFG passes are done
      bpf: Don't echo user-supplied map info fields back to userspace
      bpf, x86: Mask the shift counts of the magic number division

Darren Carreras (1):
      libbpf: Avoid overflow in BTF.ext bounds check

David Windsor (2):
      bpf: Support passing context output arguments to kfuncs
      bpf, lsm: Let BPF LSM provide xattrs at inode creation

Eduard Zingerman (67):
      Merge branch 'simplify-min-max-contains-and-normalize-cnum-implementation'
      Merge branch 'bpf-support-aggregate-return-values-up-to-16-bytes'
      bpf: Record raw memory arguments during argument checking
      bpf: Check read access for helper input/output buffers
      selftests/bpf: Cover helper memory access permissions
      bpf: Represent stack access effects with arg_access_info
      bpf: Describe helper stack accesses with arg_access_info
      bpf: Describe kfunc stack accesses with arg_access_info
      bpf: Track may_write flags in liveness
      bpf: Summarize may write stack slots in insn_aux_data
      bpf: Summarize live stack slots in insn_aux_data
      bpf: Summarize regs that may hold a frame pointer in insn_aux_data
      bpf: Record write effects for atomic operations in liveness.c
      bpf: Fix arg_track_xfer() for atomic stack spills and fills
      bpf: Derive global subprog stack liveness from BTF signatures
      bpf: Compute parameters liveness in bpf_compute_live_registers()
      bpf: Add tnum_alignment()
      bpf: Add cnum{32,64}_union()
      bpf: Add cnum64_intersect_linear()
      bpf: Expose bpf_rev_opcode() and bpf_flip_opcode()
      bpf: Expose bpf_grow_stack_state()
      bpf: Expose bpf_verbose_snum()
      bpf: Allow subrange relations for PTR_TO_STACK in regsafe()
      bpf: Representation for intervals with steps
      bpf: Varying offset access support for PTR_TO_BTF_ID pointers
      bpf: Save DFS postorder numbers for program instructions
      bpf: Move the live-register and SCC printout to a standalone function
      bpf: Compute immediate dominators
      bpf: Compute loop hierarchy
      bpf: Add bpf_set_reg_range()
      bpf: Add bpf_mark_reg_known_scalar()
      bpf: Add bpf_reg_union() and bpf_reg_union_compatible()
      bpf: Add bpf_split_cur_state()
      bpf: Add bpf_same_memory_origin()
      bpf: Add bpf_spill_size()
      bpf: Record basic-block ends in insn_aux_data
      bpf: Allow precision backtracking between overlapping checkpoints
      bpf: Compute scalar evolution expressions for loops
      bpf: Use SCEV to widen bounded loops
      bpf: Avoid widening registers that hinder exact stack-slot tracking
      bpf: Bpf_func_state size optimization
      selftests/bpf: __msg_next tag for matching messages on consecutive lines
      selftests/bpf: Bound UNIX socket path loops by sun_path size
      selftests/bpf: Test for stack-pointer subrange pruning
      selftests/bpf: Tests for may_write stack-liveness tracking
      selftests/bpf: Tests for may_def marks of atomic RMW operations
      selftests/bpf: Tests for stack pointer spills/fills through atomics
      selftests/bpf: Tests for map special cases in bpf_helper_stack_access_bytes()
      selftests/bpf: Tests for BTF-based global subprog stack liveness
      selftests/bpf: Test for register liveness of subprogram arguments
      selftests/bpf: Tests for register base/step arithmetic
      selftests/bpf: Tests for register base/step state pruning
      selftests/bpf: Tests for varying offset access to PTR_TO_BTF_ID
      selftests/bpf: Tests for loop hierarchy computation
      selftests/bpf: Tests for immediate dominator computation
      selftests/bpf: Tests for SCEV analysis and loop widening
      bpf: Use div64_u64{,_rem}() in scev.c
      resolve_btfids: Build separate main and inline BTF objects
      bpf: More precise stack liveness effects for global func params
      bpf: Avoid duplicate declaration for BPF_SCEV_REGS_NUM
      bpf: Reg_bounds_sync() comment fixup
      selftests/bpf: Stack effects of scalar/dynptr global subprog params
      selftests/bpf: Harden __msg pattern for global_callee_btf_arg
      selftests/bpf: Harden __msg patterns for step_movsx_bounds_on_line
      selftests/bpf: BPF_F_ANY_ALIGNMENT for byte_array_size_spanning()
      bpf: Support 32-bit linear scalar evolution
      selftests/bpf: Tests for 32-bit scalar evolution bounds computation

Emil Tsalapatis (16):
      selftests/bpf: libarena: Normalize SPDX headers across files
      selftests/bpf: libarena: Inline nonatomic bitmap operations
      selftests/bpf: libarena: Disable IRQs during allocation
      selftests/bpf: libarena: Add calloc() call
      selftests/bpf: libarena: Add a benchmark for malloc()/calloc()
      selftests/bpf: libarena: Optimize and make public arena_memset
      bpf: Use an llist for page allocations
      bpf: Add sleepable argument to bpf_alloc_pages()
      bpf: Add sleepable arena page allocation path
      selftests/bpf: Test large allocations for both sleepable/nonsleepable arena users
      bpf: Directly store kfunc desc index in instruction off field
      bpf: Support per-call-site kfunc specialization
      selftests/bpf: Test per-call site function specialization
      bpf: Revalidate faulted arena pages before installing user mappings
      bpf: Fix arena race between page free and alloc leading to incoherency
      selftests/bpf: Add arena allocation race tests

Eric Biggers (1):
      bpf: crypto: Use AES-CBC and AES-ECB libraries

Ethan Nelson-Moore (1):
      samples/bpf: Remove unused hash_func01.h header

Eva Kurchatova (1):
      samples/bpf: Build the BPF programs with -fms-extensions

Feng Jiang (2):
      riscv, bpf: Add BPF stack arguments support for RV64 JIT
      selftests/bpf: Enable stack argument tests for RV64

Fuyu Zhao (2):
      libbpf: Support selective kernel module BTF loading via bpf_object_open_opts
      selftests/bpf: Add tests for selective module BTF loading

Geliang Tang (1):
      bpf: Drop duplicate check_app_limited in tcp_bpf_push

Hao Sun (4):
      bpf: Fix uninit read for non-fetch atomics on partially spilled slots
      selftests/bpf: Test non-fetch atomic on a narrow stack spill
      bpf: Fix uninit read for helper mem args on partially spilled slots
      selftests/bpf: Test helper read of a narrow stack spill

Hui Su (5):
      bpftool: Fix CPU IDs in per-CPU map output
      bpftool: Fix sparse CPU IDs in prog profile
      bpf: Report BPF_F_PREORDER in cgroup program queries
      selftests/bpf: Test querying BPF_F_PREORDER cgroup attachments
      bpftool: Add support for BPF_F_PREORDER cgroup attach flag

Hui Zhu (2):
      mm/bpf: Add bpf_proactive_reclaim kfunc
      selftests/bpf: Add bpf_proactive_reclaim test

Ihor Solodrai (14):
      selftests/bpf: Add compare_text_to_expected() helper
      selftests/bpf: Modernize btf_dump test scaffolding
      selftests/bpf: Compare btf_dump expected output in-process
      selftests/bpf: NUL-terminate bpftool command output
      selftests/bpf: Add tests for bpftool btf dump format c
      bpftool: Don't drop a type in the sorted C dump
      selftests/bpf: Refactor cb_refs selftests
      libbpf: Walk types in btf_dump_resize(), not in mark_referenced()
      libbpf: Render decl_tags in btf_dump
      selftests/bpf: Add ASSERT_TEXT_EQ()
      selftests/bpf: Test btf_dump rendering of decl_tags
      selftests/bpf: Show the tag kflag in the raw BTF dump helper
      selftests/bpf: Skip callx switch table test for clang-22 with cpu=v4
      libbpf: Start v1.9 development cycle

Jianlin Shi (5):
      bpf: Roll back stream capacity when allocation fails
      bpf: Fix stream capacity leak in staging path
      bpf: Return partial progress from bpf_stream_read on fault
      bpf: Reject oversized bpf_stream_vprintk output with -E2BIG
      selftests/bpf: Cover stream capacity and partial read edge cases

Jiayuan Chen (7):
      libbpf: Fix usdt attach failure when nop10 crosses page boundary
      selftests/bpf: Add test for usdt probe with page-crossing nop10
      bpf: arena: Allocate the fault-in page outside the lock
      selftests/bpf: Add read_cgroup_file() to cgroup_helpers
      selftests/bpf: Add a test for arena fault-in under memory.max
      bpf: Fix verifier WARN on narrow read of bpf_tcp_sock u64 fields
      selftests/bpf: Test narrow read of bpf_tcp_sock u64 fields

Jiri Olsa (1):
      bpf, x86: Use global buffer for trampoline size generation

Johan Almbladh (2):
      bpf, mips: Add JIT support for unconditional BSWAP
      bpf, mips: Add JIT support for JMP32_JA

Josef Bacik (37):
      bpf: Use the frame mem type in devmap egress XDP
      bpf: Forbid sleeping in hash map for_each callbacks
      bpf: Don't leak the inode when token creation fails
      bpf: Don't hand out a linked element as extra element
      bpf: Reject sleepable programs for task_vma iterator
      bpf: Forbid sleeping in bpf_find_vma() callbacks
      bpf: Look at all 64 bits of a BPF_JSET mask on 32-bit
      bpf: Don't let bpf_skb_adjust_room() use up the MSS
      bpf: Read the probe of a perf event under event_mutex
      bpf: Don't saturate owner_refcnt on the last unpin
      bpf: Validate the SRH which End.DT6 uncovers in End.BPF
      bpf: Pull the inner header for End.DT6 in End.BPF
      bpf: Update the SRH state if End.B6 fails late
      bpf: Fix NULL deref in the sk_storage map iterator
      bpf: Hold the socket in the sk_storage map iterator
      bpf: Bound the nesting that the BTF show code follows
      bpf: Check the new program of an iterator link update
      bpf: Fix stale offload->prog pointer after realloc
      bpf: Don't bind a program to a netdev that goes away
      bpf: Keep a program until its bpf_wq callback has ended
      bpf: Count sleepable callbacks as sleepable map users
      bpf: Check the maps that sleepable callbacks use
      bpf: Assume no bounds for buffers behind a tail call
      bpf: Don't take an extension for an iterator program
      bpf: Assume no bounds for a writable tp with tail calls
      bpf: Keep iterator programs off special map fields
      bpf: Free what map_free() unlinks for sleepable readers
      bpf: Keep values of a dead owner for sleepable programs
      bpf: Keep the symbols of a program until it has ended
      bpf: Use the socket of a sk_lookup test run under RCU
      bpf, cpumap: Hold the device of frames in the queue
      bpf: Drop packet pointers behind kfuncs writing an skb
      bpf: Let bpf_dynptr_write() mark a global function
      bpf: Don't take a dynptr argument for a local dynptr
      bpf: Follow the head if an skb is written from a slice
      bpf: Use memmove() to store bytes in an skb
      bpf: Refuse packet slices for packet-changing helpers

KaFai Wan (7):
      selftests/bpf: Fix prog_tests framework subtest count checks
      selftests/bpf: Skip expected_msgs subtests when stdout is not saved
      selftests/bpf: Skip compare_text subtest when stdout is not saved
      bpf: Determine freplace staticness from BTF linkage
      selftests/bpf: Fix stack_arg precision backtracking log expectation
      selftests/bpf: Fix stack arg pruning test JOIN log expectation
      selftests/bpf: Use _exit() in uprobe_multi_test clone-ed child

Karl Mehltretter (1):
      bpf, docs: Fix two struct names in btf.rst and kfuncs.rst

Kumar Kartikeya Dwivedi (78):
      Merge branch 'selftests-bpf-fixes-and-improvements-for-libarena'
      Merge branch 'bpf-fix-stream-capacity-read-and-oversize-handling'
      Merge branch 'bpf-riscv-add-support-for-signed-arena-loads'
      selftests/bpf: Resolve bpftool through bpftool_helpers in core_reloc
      bpf: Reject oversized stream read buffers
      selftests/bpf: Cover oversized stream read buffers
      Merge branch 'add-bpf-stack-arguments-support-for-rv64'
      Merge branch 'selftests-bpf-restructure-the-makefile-as-a-layered-build'
      selftests/bpf: Allow privileged preparation for capability tests
      bpf: Check __uninit kfunc output buffers as write-only
      bpf: Fix generic __uninit kfunc output buffers
      selftests/bpf: Cover generic __uninit output initialization
      bpf: Support multiple __uninit kfunc output arguments
      selftests/bpf: Cover __uninit kfunc output argument slots
      bpf: Preserve stack initialization for generic output buffers
      selftests/bpf: Cover generic output stack initialization
      Merge branch 'bpf-keep-target-extended-until-its-last-freplace-link-detaches'
      Merge branch 'bpftool-fix-sparse-cpu-ids'
      bpf: Check fastcall stack contract once for all stack accesses
      selftests/bpf: Test fastcall rewrite with indirect stack accesses
      bpf: Add accessors for verifier stack slots
      bpf: Widen the stack slot index in the jump history
      bpf: Store linked registers in the jump history as an array
      bpf: Track backtracking stack slots with bitmaps
      bpf: Track scratched stack slots with a bitmap
      bpf: Treat unknown-size stack reads as reaching the frame top
      bpf: Size liveness stack masks by the stack each frame uses
      bpf: Grow the verifier id scratch on demand
      selftests/bpf: Cover the tail call caller stack depth limit
      selftests/bpf: Check that narrow stack stores define no slot
      selftests/bpf: Check liveness merge of masks with different widths
      bpf: Size the per-frame verifier structures for a 2 KiB stack
      bpf: Bound program stack use by a per-program limit
      selftests/bpf: Add load conditions on the program stack limit
      selftests/bpf: Give the 512-byte stack boundary tests a 2 KiB twin
      bpf, x86: Allow programs 2 KiB of stack
      bpf, arm64: Allow programs 2 KiB of stack
      selftests/bpf: Test the 2 KiB stack budget
      bpf: Return the id scratch to a fixed array sized for the stack budget
      bpf: Correct verifier diagnostic attribution for stack reads
      selftests/bpf: Test verifier stack-read diagnostic attribution
      bpf: Drop dead spill diagnostic condition
      bpf: Report non-sleepable kfunc programs accurately
      bpf: Check callx operand before requiring JIT support
      bpf: Skip zero-length stream writes
      bpf: Add file descriptor interface for program streams
      libbpf: Add bpf_prog_stream_open()
      bpftool: Add option to wait for program stream output
      selftests/bpf: Test program stream file descriptors
      selftests/bpf: Test non-sleepable kfunc context
      bpf: Correct Program Structure diagnostic context
      selftests/bpf: Test Program Structure diagnostic context
      bpftool: Exit from the stream wait signal handler with _exit()
      Merge branch 'bpf-support-programs-compiled-by-rust-bpf'
      Merge branch 'bpf-destroy-callee-local-dynptrs-on-subprog-return'
      bpf, riscv: Fix stack-passed arguments for indirect trampolines
      Merge branch 'bpf-reject-btf-ids-with-the-same-address-in-tracing_multi-link'
      Merge branch 'bpf-various-x86-64-bpf-jit-improvements'
      Merge branch 'bpf-enforce-trusted-btf-id-argument-provenance'
      bpf: Check exclusive maps once the program digest is final
      selftests/bpf: Bind an exclusive map through a continuous fd_array
      libbpf: Keep the fd_array fill index out of bpf_program__clone()
      selftests/bpf: Clone a program that calls a module kfunc
      bpf: Add the __arena and __nullable BTF type tags
      bpf: Recognize __nullable on pointer members of kernel structs
      bpf: Turn loads of __arena pointer members into arena pointers
      selftests/bpf: Test __nullable pointer members
      selftests/bpf: Test __arena pointer members
      selftests/bpf: Move the no-arena tests out of objects with an arena map
      libbpf: Bind the arena of an object to every program in it
      selftests/bpf: Test arena binding by libbpf
      bpf: Set up the arena base only in functions that use it
      libbpf: Render the arena type tag with its address space
      selftests/bpf: Test the address space rendering of the arena type tag
      selftests/bpf: Test an arena kfunc argument passed from a subprogram
      bpf: Refuse CO-RE relocations for a signed program
      selftests/bpf: Test that a signed program with CO-RE relocations is refused
      selftests/bpf: Test unwinding from R0: R2 subprog

Kuniyuki Iwashima (10):
      bpf: tcp: Convert deny-list for bpf_{get,set}sockopt() to allow-list.
      bpf: tcp: Add a new per-socket flag and kfunc for bpf_tcp_ops.
      selftest: bpf: Use bpf_tcp_ops_set_flags() in bpf_tcp_ops_hdr.c.
      bpf: tcp: Guard fast-path bpf_tcp_ops_call() under per-socket flag.
      bpf: tcp: Check BPF_SOCK_OPS_TEST_FLAG() after cgroup_bpf_enabled(CGROUP_SOCK_OPS).
      bpf: tcp: Introduce bpf_tcp_ops.{enqueue,dequeue}_rcvq().
      tcp: Split out __tcp_set_rcvlowat().
      bpf: mptcp: Don't support BPF_TCP_OPS_FLAG_RCVQ.
      bpf: tcp: Add kfunc to adjust sk->sk_rcvlowat.
      selftest: bpf: Add test for bpf_tcp_ops.{enqueue,dequeue}_rcvq().

Leon Hwang (4):
      selftests/bpf: Avoid flaky resize value test for percpu data
      bpftool: Compute map size of light skeletons at runtime
      bpf: Initialize ftrace_managed in bpf_trampoline_get()
      bpf: Drop unnecessary ftrace_location() in register/unregister/modify_fentry_multi()

Luis Vieira (3):
      libbpf: Fix program log buffer size validation
      libbpf: Validate ELF symbol table entry size
      libbpf: Fix cleanup on invalid CO-RE relocation offsets

Madhav Khosla (1):
      selftests/bpf: Fix csum_partial() dropping trailing byte on odd length

Mahe Tardy (6):
      libbpf: fix log level propagation for light skeleton loaders
      bpf: Allow ksock connect/send calls from wq
      selftests/bpf: Test ksock connect/send calls from wq
      bpf: Add bpf_ksock_sendto() kfunc
      selftests/bpf: Test ksock sendto()
      selftests/bpf: Test forbidden bpf_ksock_sendto() LSM attach

Marco Vedovati (1):
      tools/include: Add Linux-syscall-note to uapi/linux/types.h

Martin KaFai Lau (11):
      bpf: Remove __rcu tagging in st_link->map
      bpf: Make struct_ops tasks_rcu grace period optional
      bpf: Add bpf_struct_ops accessor helpers
      bpf: Remove unnecessary prog_list_prog() check
      bpf: Replace prog_list_prog() check with direct pl->prog and pl->link check
      bpf: Add prog_list_init_item(), prog_list_replace_item(), and prog_list_id()
      bpf: Move LSM trampoline unlink into bpf_cgroup_link_auto_detach()
      bpf: Add a few bpf_cgroup_array_* helper functions
      bpf: Add infrastructure to support attaching struct_ops to cgroups
      libbpf: Support attaching struct_ops to a cgroup
      selftests/bpf: Test attaching struct_ops to a cgroup

Masoud Aghasi (3):
      bpf: Fix incorrect handling of user flags in bpf_percpu_array_update
      bpf: Fix incorrect handling of user flags by percpu hash map updates
      selftests/bpf: Add tests for percpu map flags combination

Matthew Wood (1):
      bpf, arm64: Fix racy plt target update in bpf_arch_text_poke()

Maxim Skokov (5):
      bpf: test_run: Fix false -EBADMSG after skb leaves CHECKSUM_COMPLETE
      selftests/bpf: Cover test_run csum validation after bpf_skb_change_tail()
      bpftool: Print ENOTSUPP as "Operation not supported"
      bpftool: Fail map dump for maps that can't be iterated
      selftests/bpf: Test bpftool map dump on maps that can't be iterated

Michal Luczaj (1):
      selftests/bpf: Clean up sa_family_t-stringifier

Mingpei CAO (3):
      libbpf: Fix array comparison in BTF dedup
      selftests/bpf: Test array element comparison in BTF dedup
      libbpf: Reject local struct_ops bitfields before data access

Mykola Lysenko (9):
      selftests/bpf: Keep headers off the generic link command line
      selftests/bpf: Drop stale lines, restore two header dependencies
      selftests/bpf: Factor the permissive-mode skip suffix into a helper
      selftests/bpf: Generate the signing key and certificate once
      selftests/bpf: Generate verifier/tests.h in a regular recipe
      selftests/bpf: Derive the bench object list from the sources
      selftests/bpf: Extract BPF skeleton generation into a helper script
      selftests/bpf: Move shared build definitions into Makefile.buildvars
      selftests/bpf: Build each test runner instance in its own sub-make

Mykyta Yatsenko (5):
      libbpf: Defer arena map size check to load time
      bpftool: Accept zero perf counter snapshots
      bpftool: Group profile events by CPU
      bpftool: Scale counters and report cycles per run
      bpf: Speed up htab lookups for u32/u64 keys

Nicholas Dudar (7):
      bpf, parisc: Add support for BPF_SDIV and BPF_SMOD in the parisc64 JIT
      bpf, parisc: Add support for BPF_SDIV and BPF_SMOD in the parisc32 JIT
      bpf, mips: Factor out div/mod emission helpers
      MIPS: uasm: Add signed div/mod and sign-extension emitters
      bpf, mips: Add support for BPF_SDIV and BPF_SMOD
      bpf, mips: Factor register moves into helpers
      bpf, mips: Add support for BPF_MOVSX in the JITs

Nicholas Velten (1):
      bpf: Annotate data races on bpf_lru_node type

Nickolai Zeldovich (1):
      lib/buildid: reject file offsets that do not fit in pgoff_t

Petr Pavlu (1):
      resolve_btfids: Fix the --fatal_warnings exit status

Pu Lehui (8):
      riscv, bpf: Remap BPF_REG_0 and RV_REG_TCC
      bpf: Adjust bpf_func to account for CFI offset in bpf_jit_free on riscv
      MAINTAINERS: Add myself as co-maintainer of riscv bpf
      riscv, bpf: Support indirect calls to bpf subprogs (callx)
      selftests/bpf: Enable callx related testcases for RV64
      selftests/bpf: Avoid jiffies quantization error in setget_sockopt
      selftests/bpf: Update qemu config for riscv64 in vmtest.sh
      selftests/bpf: Update DENYLIST.riscv64

Puranjay Mohan (8):
      bpf: Add bpf_call_rcu() kfunc
      selftests/bpf: Add tests for bpf_call_rcu()
      bpf: Add bpf_call_rcu_tasks_trace() kfunc
      selftests/bpf: Add a test for bpf_call_rcu_tasks_trace()
      bpf: Look at frame 0 when telling async callback entries apart
      selftests/bpf: Add timer tests for a re-arming callback with a loop
      bpf, x86: Support fetching AND/OR/XOR atomics in arena
      selftests/bpf: Test fetching AND/OR/XOR atomics in arena

Qiliang Yuan (11):
      selftests/bpf: Use its own netns in flow_dissector_skb_less_direct_attach
      selftests/bpf: Report a failure to register the session key in test_progs
      selftests/bpf: Expect at least one tp_recursion miss in missed
      selftests/bpf: Create the vxlan devices of test_tunnel with their MAC
      selftests/bpf: Accept unnamed dma-bufs in the dmabuf_iter default test
      selftests/bpf: Keep the bpffs of cgroup_hierarchical_stats private
      selftests/bpf: Unmount the bpffs that cgroup_hierarchical_stats mounted
      selftests/bpf: Record only the test ICMP echo in tc8 of tc_netkit_scrub
      selftests/bpf: Expect at least one kprobe miss in missed/perf_kprobe
      selftests/bpf: Run the cpumask map insert tests only for the test task
      selftests/bpf: Time tc_edt from its first packet with data

Quanye Yang (1):
      bpf: Annotate bpf_obj_memcpy with data_race

Sanghyun Park (1):
      bpf: Fix program BTF use-after-free in sleepable programs

Sasha Levin (5):
      ARC: Strip libgcc debug information when generating BTF
      locking/atomic: arc, hexagon, openrisc: Define arch_cmpxchg_local()
      bpf: Drop unused entries from special_kfunc_list again
      bpf: Don't reference arena kfuncs when arena isn't built
      bpf: Fix ksock build with BPF_LSM=y and SECURITY_NETWORK=n

Sean Young (1):
      selftests/bpf: Convert lirc_mode2 to prog_tests and extend coverage

Sebastian Andrzej Siewior (1):
      selftests/bpf: Replace %pK output with 0

Shakeel Butt (1):
      bpf, cgroup: Fix cgroup struct_ops query for a second attach type

Sudip Mukherjee (1):
      libbpf: Fix debian kernel version information parsing

T.J. Mercier (2):
      bpf: htab: Split htab_elem_lru and htab_elem_pcpu off of htab_elem
      bpf: htab: Reduce elem_size by 8 bytes for small key sizes

Tejun Heo (1):
      bpf: sched_ext: Mark ops argument container pointer fields as trusted

Tianyi Chen (2):
      bpftool: Read ring buffer maps with event_pipe
      selftests/bpf: Cover bpftool ring buffer event_pipe

Tiezhu Yang (2):
      selftests/bpf: Add test for indirect struct_ops trampoline
      selftests/bpf: Drop subtest descriptions in jit_insns_arena

Toke Høiland-Jørgensen (8):
      bpftool: Set BPF_F_XDP_DEV_BOUND_ONLY flag non-destructively
      selftests/bpf: Set BPF program flags non-destructively
      libbpf: Move section-defined program flags to prog_flags
      selftests/bpf: Check for flag presence in bpf_program__flags()
      libbpf: Add bpf_program__add_flags() and bpf_program__clear_flags()
      selftests/bpf: Add assertions for bpf_program__{add,clear}_flags()
      selftests/bpf: Adopt bpf_program__add_flags() helper
      bpftool: Adopt bpf_program__add_flags() helper

Tw (1):
      libbpf: Fix for the potential undefined behavior due to shifting

Usama Arif (1):
      bpf: Avoid redundant IRQ save on bucket locks

Vineet Gupta (4):
      selftests/bpf: Name the remaining placeholder programs dummy_test [NFC]
      selftests/bpf: Report placeholder tests as SKIP, not OK
      selftests/bpf: Enable some of the blocked cpuv4 instruction tests for bpf-gcc
      selftests/bpf: Fix linked_externs with bpf-gcc

Vinicius Sampaio (3):
      bpf: Simplify cnum contains() by removing redundant branches
      bpf: Simplify cnum normalize() by dropping unnecessary comparisons
      bpf: Avoid redundant min()/max() in cnum signed bounds

Woojin Ji (2):
      bpf: Zero-extend the index in inlined bpf_get_func_arg()
      selftests/bpf: Test out-of-range index bits in bpf_get_func_arg()

Xia Yan (1):
      tools/bpf: Remove legacy BPF tools

Xu Yunxiang (2):
      bpf: Destroy callee-local dynptrs on subprog return
      selftests/bpf: Test dynptr teardown on subprog return

Yiyang Chen (2):
      bpf: Enforce trusted BTF ID argument provenance
      selftests/bpf: Cover trusted BTF ID argument provenance

Yonghong Song (47):
      bpf: Factor check_global_ret_scalar_reg() out of the global return check
      bpf: Add helpers to describe the R0: R2 return register pair
      bpf: Wire up JIT support for 16-byte kfunc returns
      bpf: Handle R2 as a return register in precision backtracking
      bpf: Account R2 of register-pair returns in live register analysis
      bpf: Add verifier support for 16-byte returns in R0: R2
      bpf: Enable aggregate return types up to 16 bytes
      selftests/bpf: Add C tests for 16-byte returns in R0: R2
      selftests/bpf: Add inline-asm and subprog tests for R0: R2 returns
      Documentation/bpf: Document up to 16-byte kfunc return values in R0: R2
      bpf: Record each half of a paired return value in verifier diagnostics
      bpf: Drop the recursion depth argument of btf_type_is_scalar_struct()
      bpf: Add btf_type_is_arena_ptr()
      bpf: Let the by-value struct walk take the kinds of member it accepts
      bpf: Let a by-value struct nest arrays and structs freely
      bpf: Report which member makes a kfunc return type unsupported
      bpf: Allow a global function to return arena pointers by value
      bpf: Allow arena pointers in a by-value kfunc return
      selftests/bpf: Check the member named for an unsupported kfunc return type
      selftests/bpf: Test global functions returning arena pointers by value
      selftests/bpf: Test kfuncs returning arena pointers by value
      docs/bpf: Document arena pointers in a by-value return
      bpf: Read a kfunc's __sz argument only when it is in a register
      selftests/bpf: Add a test for an __int128 by-value argument
      bpf: Rename bpf_subprog_info::arg_cnt to arg_slot_cnt
      bpf: Index global function arguments by argument slot
      bpf: Support by-value struct arguments up to 16 bytes
      bpf: Support __int128 as a by-value function argument
      bpf: Rename bpf_call_summary::num_params to arg_slot_cnt
      bpf: Recognize by-value struct and __int128 kfunc arguments
      bpf: Prepare kfunc arguments for the JIT from an ABI description
      bpf, x86: Move kfunc arguments into the x86-64 calling convention
      bpf, arm64: Place trampoline arguments by the arm64 calling convention
      bpf, arm64: Move kfunc arguments into the arm64 calling convention
      selftests/bpf: Add C tests for by-value arguments up to 16 bytes
      selftests/bpf: Add inline-asm tests for by-value arguments
      selftests/bpf: Add tests for by-value kfunc arguments
      bpf: Pack bpf_insn_aux_data flags into bit fields
      bpf, x86: Pass a trampoline's stack arguments by the calling convention
      selftests/bpf: Test trampoline stack args in a program that can tail call
      selftests/bpf: Test by-value __int128 kfunc arguments at an odd slot
      bpf: Describe a BPF function to its trampoline as one u64 per slot
      bpf, x86: Place trampoline arguments by the x86-64 calling convention
      selftests/bpf: Test trampoline args around a 16-byte aligned stack arg
      selftests/bpf: Test trampoline args of a BPF function at an odd slot
      bpf: Refuse a trampoline on an unreliable static function with stack args
      selftests/bpf: Test trampolines on more BPF functions with stack args

Yuan Chen (12):
      bpftool: Fix spurious batch file read error
      bpftool: Fix bypass of the batch line length check by comments
      bpf: Fix queue/stack map u32 index overflow
      selftests/bpf: Add regression test for queue/stack map size limit
      bpf: Fix range_tree_clear inconsistency on kmalloc_nolock failure in arena
      bpf: Fix range_tree_set inconsistency on kmalloc_nolock failure in arena
      bpf: Keep target extended until its last freplace link detaches
      selftests/bpf: Verify is_extended with multiple freplace links
      bpf: Roll back freplace link state when bpf_arch_text_poke() fails
      bpftool: Fix out-of-bounds read in kprobe_multi link info dump
      bpftool: Fix inverted tracefs validation when scanning /proc/mounts
      bpf: Claim the per-CPU send_signal irq_work before filling it

Yun Lu (6):
      selftests/bpf: Clean up child when task_work__open() fails
      selftests/bpf: Fix map fd leak in no-BTF wq test
      bpf: Fix NULL task dereference in task work cancellation
      selftests/bpf: Add task work cancellation race test
      bpf: Prevent task work context reuse while irq_work is busy
      selftests/bpf: Add task work BUSY window test

Zhixing Chen (1):
      selftests/bpf: Guard link cleanup in fexit_bpf2bpf

 .gitignore                                         |     1 +
 Documentation/admin-guide/kernel-parameters.txt    |    16 +
 Documentation/bpf/bpf_design_QA.rst                |    11 +-
 Documentation/bpf/bpf_devel_QA.rst                 |    16 +-
 Documentation/bpf/btf.rst                          |    85 +-
 Documentation/bpf/clang-notes.rst                  |     7 +-
 Documentation/bpf/kfuncs.rst                       |   126 +-
 Documentation/bpf/linux-notes.rst                  |    31 +-
 Documentation/bpf/signing.rst                      |   283 +-
 Documentation/networking/filter.rst                |   241 +-
 .../networking/net_cachelines/tcp_sock.rst         |     1 +
 MAINTAINERS                                        |     6 +-
 Makefile                                           |     1 +
 arch/arc/Makefile                                  |     9 +-
 arch/arc/include/asm/cmpxchg.h                     |     4 +
 arch/arc/lib/Makefile                              |     8 +
 arch/arm64/net/bpf_jit_comp.c                      |   312 +-
 arch/hexagon/include/asm/cmpxchg.h                 |     6 +
 arch/loongarch/net/bpf_jit.c                       |     6 +-
 arch/m68k/configs/amiga_defconfig                  |     1 -
 arch/m68k/configs/apollo_defconfig                 |     1 -
 arch/m68k/configs/atari_defconfig                  |     1 -
 arch/m68k/configs/bvme6000_defconfig               |     1 -
 arch/m68k/configs/hp300_defconfig                  |     1 -
 arch/m68k/configs/mac_defconfig                    |     1 -
 arch/m68k/configs/multi_defconfig                  |     1 -
 arch/m68k/configs/mvme147_defconfig                |     1 -
 arch/m68k/configs/mvme16x_defconfig                |     1 -
 arch/m68k/configs/q40_defconfig                    |     1 -
 arch/m68k/configs/sun3_defconfig                   |     1 -
 arch/m68k/configs/sun3x_defconfig                  |     1 -
 arch/mips/include/asm/uasm.h                       |     8 +
 arch/mips/mm/uasm-mips.c                           |    12 +
 arch/mips/mm/uasm.c                                |    24 +-
 arch/mips/net/bpf_jit_comp.c                       |    57 +-
 arch/mips/net/bpf_jit_comp.h                       |     6 +-
 arch/mips/net/bpf_jit_comp32.c                     |   109 +-
 arch/mips/net/bpf_jit_comp64.c                     |   139 +-
 arch/openrisc/include/asm/cmpxchg.h                |     2 +
 arch/parisc/net/bpf_jit.h                          |     2 +
 arch/parisc/net/bpf_jit_comp32.c                   |    29 +-
 arch/parisc/net/bpf_jit_comp64.c                   |    35 +-
 arch/parisc/net/bpf_jit_core.c                     |    14 +
 arch/powerpc/configs/ppc64_defconfig               |     1 -
 arch/powerpc/net/bpf_jit_comp.c                    |     6 +-
 arch/riscv/net/bpf_jit.h                           |     4 +
 arch/riscv/net/bpf_jit_comp64.c                    |   142 +-
 arch/riscv/net/bpf_jit_core.c                      |    30 +-
 arch/riscv/net/bpf_timed_may_goto.S                |     8 +-
 arch/s390/configs/debug_defconfig                  |     1 -
 arch/s390/configs/defconfig                        |     1 -
 arch/s390/net/bpf_jit_comp.c                       |    36 +-
 arch/x86/Kconfig                                   |     1 +
 arch/x86/net/bpf_jit_comp.c                        |  1808 ++-
 arch/x86/net/bpf_timed_may_goto.S                  |    10 +-
 crypto/Makefile                                    |     3 -
 crypto/bpf_crypto_skcipher.c                       |    83 -
 drivers/net/ethernet/netronome/nfp/bpf/verifier.c  |     2 +-
 fs/bpf_fs_kfuncs.c                                 |    99 +
 fs/exec.c                                          |     7 +-
 include/asm-generic/vmlinux.lds.h                  |    31 +
 include/linux/bpf-cgroup-defs.h                    |     1 +
 include/linux/bpf-cgroup.h                         |    64 +-
 include/linux/bpf.h                                |   230 +-
 include/linux/bpf_compiler_types.h                 |    21 +
 include/linux/bpf_crypto.h                         |    24 -
 include/linux/bpf_local_storage.h                  |    13 +
 include/linux/bpf_lsm.h                            |    11 +-
 include/linux/bpf_verifier.h                       |   564 +-
 include/linux/btf.h                                |    65 +-
 include/linux/cnum.h                               |     3 +
 include/linux/filter.h                             |    83 +
 include/linux/ftrace.h                             |     1 +
 include/linux/key.h                                |     2 +
 include/linux/mm.h                                 |     8 +-
 include/linux/module.h                             |     4 +
 include/linux/tcp.h                                |     7 +
 include/linux/tnum.h                               |     2 +
 include/net/tcp.h                                  |   248 +-
 include/uapi/linux/bpf.h                           |   126 +-
 include/uapi/linux/btf.h                           |    83 +-
 include/uapi/linux/keyctl.h                        |     1 +
 kernel/bpf/Kconfig                                 |    26 +
 kernel/bpf/Makefile                                |    10 +-
 kernel/bpf/arena.c                                 |   408 +-
 kernel/bpf/arraymap.c                              |     8 +-
 kernel/bpf/backtrack.c                             |   158 +-
 kernel/bpf/bpf_insn_array.c                        |    19 +-
 kernel/bpf/bpf_iter.c                              |    31 +-
 kernel/bpf/bpf_local_storage.c                     |    66 +-
 kernel/bpf/bpf_lru_list.c                          |     9 +-
 kernel/bpf/bpf_lsm.c                               |    26 +-
 kernel/bpf/bpf_lsm_proto.c                         |    19 +-
 kernel/bpf/bpf_struct_ops.c                        |   142 +-
 kernel/bpf/btf.c                                   |  1313 +-
 kernel/bpf/btf_vmlinux_inline.c                    |    29 +
 kernel/bpf/cfg.c                                   |   361 +-
 kernel/bpf/cgroup.c                                |   500 +-
 kernel/bpf/cnum.c                                  |    36 +
 kernel/bpf/cnum_defs.h                             |    81 +-
 kernel/bpf/const_fold.c                            |    10 +-
 kernel/bpf/core.c                                  |   271 +-
 kernel/bpf/cpumap.c                                |    35 +-
 kernel/bpf/crypto.c                                |   288 +-
 kernel/bpf/devmap.c                                |     1 +
 kernel/bpf/diagnostics.c                           |    71 +-
 kernel/bpf/diagnostics.h                           |     1 +
 kernel/bpf/disasm.c                                |    12 +-
 kernel/bpf/fixups.c                                |   555 +-
 kernel/bpf/hashtab.c                               |   422 +-
 kernel/bpf/helpers.c                               |   322 +-
 kernel/bpf/keys.c                                  |    73 +
 kernel/bpf/liveness.c                              |  1075 +-
 kernel/bpf/log.c                                   |    32 +-
 kernel/bpf/loops.c                                 |   616 +
 kernel/bpf/map_in_map.c                            |    11 +-
 kernel/bpf/map_iter.c                              |    83 +-
 kernel/bpf/offload.c                               |    25 +-
 kernel/bpf/queue_stack_maps.c                      |     3 +
 kernel/bpf/range_tree.c                            |    52 +-
 kernel/bpf/ringbuf.c                               |     4 +-
 kernel/bpf/scev.c                                  |  2916 ++++
 kernel/bpf/states.c                                |   326 +-
 kernel/bpf/stream.c                                |   273 +-
 kernel/bpf/syscall.c                               |   146 +-
 kernel/bpf/sysfs_btf.c                             |   149 +-
 kernel/bpf/task_iter.c                             |    12 +-
 kernel/bpf/tnum.c                                  |    11 +
 kernel/bpf/token.c                                 |     5 +-
 kernel/bpf/trampoline.c                            |    48 +-
 kernel/bpf/verifier.c                              |  6557 +++++---
 kernel/module/main.c                               |     7 +
 kernel/trace/bpf_trace.c                           |    26 +-
 kernel/trace/trace.h                               |     3 -
 lib/Kconfig.debug                                  |    31 +-
 lib/Makefile                                       |     1 -
 lib/buildid.c                                      |     4 +
 lib/test_bpf.c                                     | 15934 -------------------
 mm/bpf_memcontrol.c                                |    65 +-
 mm/internal.h                                      |    13 +-
 mm/memory.c                                        |    43 +-
 mm/nommu.c                                         |    43 +-
 mm/util.c                                          |    60 +
 net/bpf/test_run.c                                 |    27 +-
 net/core/bpf_ksock.c                               |   121 +-
 net/core/bpf_sk_storage.c                          |    96 +-
 net/core/filter.c                                  |    98 +-
 net/core/ptp_classifier.c                          |     8 +-
 net/core/sock_map.c                                |    17 +-
 net/ipv4/Makefile                                  |     1 +
 net/ipv4/af_inet.c                                 |     3 +-
 net/ipv4/bpf_tcp_ca.c                              |    16 +
 net/ipv4/bpf_tcp_ops.c                             |   453 +
 net/ipv4/tcp.c                                     |    21 +-
 net/ipv4/tcp_bpf.c                                 |     1 -
 net/ipv4/tcp_fastopen.c                            |     2 +
 net/ipv4/tcp_input.c                               |    52 +-
 net/ipv4/tcp_nv.c                                  |     2 +-
 net/ipv4/tcp_output.c                              |   147 +-
 net/ipv4/tcp_timer.c                               |     7 +-
 net/sched/bpf_qdisc.c                              |     2 -
 samples/bpf/Makefile                               |     1 +
 samples/bpf/hash_func01.h                          |    55 -
 scripts/Makefile.btf                               |     7 +
 scripts/gen-btf.sh                                 |    31 +-
 scripts/link-vmlinux.sh                            |     8 +-
 scripts/package/kernel.spec                        |    10 +-
 security/bpf/hooks.c                               |     1 +
 security/keys/process_keys.c                       |    25 +
 tools/bpf/.gitignore                               |     7 -
 tools/bpf/Makefile                                 |   101 +-
 tools/bpf/bpf_asm.c                                |    52 -
 tools/bpf/bpf_dbg.c                                |  1398 --
 tools/bpf/bpf_exp.l                                |   198 -
 tools/bpf/bpf_exp.y                                |   668 -
 tools/bpf/bpf_jit_disasm.c                         |   334 -
 tools/bpf/bpftool/Documentation/bpftool-btf.rst    |     7 +-
 tools/bpf/bpftool/Documentation/bpftool-cgroup.rst |    25 +-
 tools/bpf/bpftool/Documentation/bpftool-map.rst    |    14 +-
 tools/bpf/bpftool/Documentation/bpftool-prog.rst   |    25 +-
 tools/bpf/bpftool/bash-completion/bpftool          |    65 +-
 tools/bpf/bpftool/btf.c                            |   337 +-
 tools/bpf/bpftool/btf_dumper.c                     |    11 +
 tools/bpf/bpftool/cgroup.c                         |    99 +-
 tools/bpf/bpftool/common.c                         |    51 +
 tools/bpf/bpftool/feature.c                        |     3 -
 tools/bpf/bpftool/gen.c                            |    26 +-
 tools/bpf/bpftool/link.c                           |     4 +-
 tools/bpf/bpftool/main.c                           |    61 +-
 tools/bpf/bpftool/main.h                           |     7 +-
 tools/bpf/bpftool/map.c                            |   135 +-
 tools/bpf/bpftool/map_perf_ring.c                  |    87 +-
 tools/bpf/bpftool/prog.c                           |   306 +-
 tools/bpf/bpftool/sign.c                           |    24 +-
 tools/bpf/bpftool/skeleton/profiler.bpf.c          |    29 +-
 tools/bpf/bpftool/tracelog.c                       |     2 +-
 tools/bpf/resolve_btfids/Build                     |     1 +
 tools/bpf/resolve_btfids/btf_colors.c              |   145 +
 tools/bpf/resolve_btfids/btf_colors.h              |    24 +
 tools/bpf/resolve_btfids/main.c                    |   430 +-
 tools/include/uapi/linux/bpf.h                     |   126 +-
 tools/include/uapi/linux/btf.h                     |    83 +-
 tools/include/uapi/linux/types.h                   |     2 +-
 tools/lib/bpf/bpf.c                                |    21 +
 tools/lib/bpf/bpf.h                                |    27 +-
 tools/lib/bpf/bpf_gen_internal.h                   |    13 +-
 tools/lib/bpf/bpf_helpers.h                        |    18 +-
 tools/lib/bpf/btf.c                                |   426 +-
 tools/lib/bpf/btf.h                                |    50 +
 tools/lib/bpf/btf_dump.c                           |   220 +-
 tools/lib/bpf/btf_iter.c                           |    18 +
 tools/lib/bpf/btf_relocate.c                       |     7 +-
 tools/lib/bpf/elf.c                                |     2 +-
 tools/lib/bpf/features.c                           |    82 +
 tools/lib/bpf/gen_loader.c                         |   172 +-
 tools/lib/bpf/libbpf.c                             |  1214 +-
 tools/lib/bpf/libbpf.h                             |    41 +-
 tools/lib/bpf/libbpf.map                           |    13 +
 tools/lib/bpf/libbpf_internal.h                    |    13 +-
 tools/lib/bpf/libbpf_probes.c                      |    11 +-
 tools/lib/bpf/libbpf_version.h                     |     2 +-
 tools/lib/bpf/linker.c                             |    31 +-
 tools/lib/bpf/skel_internal.h                      |    48 +-
 tools/lib/bpf/usdt.c                               |     4 +
 tools/testing/selftests/bpf/.gitignore             |     1 -
 tools/testing/selftests/bpf/DENYLIST.riscv64       |     1 +
 tools/testing/selftests/bpf/Makefile               |   779 +-
 tools/testing/selftests/bpf/Makefile.buildvars     |   187 +
 tools/testing/selftests/bpf/Makefile.runner        |   125 +
 tools/testing/selftests/bpf/Makefile.skel          |   167 +
 tools/testing/selftests/bpf/README.rst             |     2 +-
 tools/testing/selftests/bpf/bench.c                |     6 +
 .../testing/selftests/bpf/benchs/bench_libarena.c  |   210 +
 .../selftests/bpf/benchs/run_bench_libarena.sh     |    31 +
 tools/testing/selftests/bpf/bpf_kfuncs.h           |    19 +-
 .../selftests/bpf/bpftool_btf_dump_sorted.expected |    48 +
 .../bpf/bpftool_btf_dump_unsorted.expected         |    48 +
 tools/testing/selftests/bpf/bpftool_helpers.c      |     9 +-
 tools/testing/selftests/bpf/bpftool_helpers.h      |     1 +
 tools/testing/selftests/bpf/btf_helpers.c          |    45 +-
 tools/testing/selftests/bpf/cgroup_helpers.c       |    67 +
 tools/testing/selftests/bpf/cgroup_helpers.h       |     4 +
 tools/testing/selftests/bpf/config                 |     9 +-
 tools/testing/selftests/bpf/gen_bpf_skel.sh        |    99 +
 tools/testing/selftests/bpf/libarena/Makefile      |    31 +-
 .../bpf/libarena/benchs/bench_malloc.bpf.c         |    51 +
 .../bpf/libarena/include/bpf_arena_spin_lock.h     |     2 +-
 .../selftests/bpf/libarena/include/bpf_atomic.h    |     2 +-
 .../selftests/bpf/libarena/include/bpf_may_goto.h  |     1 +
 .../bpf/libarena/include/libarena/bitmap.h         |    30 +-
 .../bpf/libarena/include/libarena/common.h         |    71 +
 .../bpf/libarena/selftests/test_bitmap.bpf.c       |     3 +
 .../testing/selftests/bpf/libarena/src/asan.bpf.c  |    21 +-
 .../selftests/bpf/libarena/src/bitmap.bpf.c        |    18 -
 .../testing/selftests/bpf/libarena/src/buddy.bpf.c |    44 +-
 .../selftests/bpf/libarena/src/common.bpf.c        |    27 +-
 tools/testing/selftests/bpf/network_helpers.c      |    46 +-
 tools/testing/selftests/bpf/network_helpers.h      |    15 +-
 .../selftests/bpf/prog_tests/aggregate_arg.c       |    11 +
 .../selftests/bpf/prog_tests/aggregate_ret.c       |    53 +
 .../selftests/bpf/prog_tests/arena_atomics.c       |    53 +
 .../testing/selftests/bpf/prog_tests/arena_memcg.c |   196 +
 .../testing/selftests/bpf/prog_tests/arena_race.c  |   320 +
 .../bpf/prog_tests/arena_scalar_blinded.c          |    21 +
 .../selftests/bpf/prog_tests/attach_probe.c        |     4 +-
 .../selftests/bpf/prog_tests/bpf_insn_array.c      |   653 +-
 tools/testing/selftests/bpf/prog_tests/bpf_nf.c    |    14 +-
 tools/testing/selftests/bpf/prog_tests/bpf_qdisc.c |     2 +
 .../testing/selftests/bpf/prog_tests/bpf_tcp_ops.c |   560 +
 .../selftests/bpf/prog_tests/bpf_tcp_ops_hdr.c     |    77 +
 .../selftests/bpf/prog_tests/bpf_verif_scale.c     |     2 +-
 .../selftests/bpf/prog_tests/bpftool_btf_dump.c    |   297 +
 .../selftests/bpf/prog_tests/bpftool_map_dump.c    |   133 +
 .../selftests/bpf/prog_tests/bpftool_ringbuf.c     |   417 +
 tools/testing/selftests/bpf/prog_tests/btf.c       |   258 +-
 .../selftests/bpf/prog_tests/btf_dedup_split.c     |   116 +
 .../testing/selftests/bpf/prog_tests/btf_distill.c |   106 +
 tools/testing/selftests/bpf/prog_tests/btf_dump.c  |   414 +-
 .../selftests/bpf/prog_tests/btf_field_iter.c      |    31 +-
 .../testing/selftests/bpf/prog_tests/btf_inline.c  |   114 +
 .../bpf/prog_tests/btf_module_allowlist.c          |   162 +
 tools/testing/selftests/bpf/prog_tests/btf_rust.c  |   142 +
 tools/testing/selftests/bpf/prog_tests/btf_sysfs.c |    87 +-
 tools/testing/selftests/bpf/prog_tests/btf_write.c |    34 +
 tools/testing/selftests/bpf/prog_tests/call_rcu.c  |   275 +
 .../selftests/bpf/prog_tests/callx_func_ptr_map.c  |   208 +
 .../selftests/bpf/prog_tests/callx_rodata_lskel.c  |    75 +
 tools/testing/selftests/bpf/prog_tests/cb_refs.c   |    48 -
 .../bpf/prog_tests/cgroup_getset_retval.c          |     2 +-
 .../bpf/prog_tests/cgroup_hierarchical_stats.c     |     4 +-
 .../selftests/bpf/prog_tests/cgroup_mprog_opts.c   |    71 +-
 .../selftests/bpf/prog_tests/clone_module_kfunc.c  |    30 +
 .../selftests/bpf/prog_tests/copy_from_user_bprm.c |    65 +
 .../testing/selftests/bpf/prog_tests/core_reloc.c  |    10 +-
 .../selftests/bpf/prog_tests/data_in_arena.c       |   216 +
 .../testing/selftests/bpf/prog_tests/dmabuf_iter.c |     5 +-
 .../testing/selftests/bpf/prog_tests/exceptions.c  |    11 +-
 .../selftests/bpf/prog_tests/fexit_bpf2bpf.c       |    22 +-
 .../testing/selftests/bpf/prog_tests/file_reader.c |    15 +
 .../selftests/bpf/prog_tests/flow_dissector.c      |     2 +-
 .../bpf/prog_tests/flow_dissector_classification.c |     2 +-
 .../selftests/bpf/prog_tests/global_data_init.c    |    96 +-
 tools/testing/selftests/bpf/prog_tests/jit_insns.c |  3155 ++++
 tools/testing/selftests/bpf/prog_tests/kasan.c     |   479 +
 .../testing/selftests/bpf/prog_tests/kernel_flag.c |    22 +-
 .../testing/selftests/bpf/prog_tests/kfunc_call.c  |     2 +-
 .../selftests/bpf/prog_tests/kprobe_multi_test.c   |     3 +-
 .../selftests/bpf/prog_tests/ksock_sendto.c        |   108 +
 tools/testing/selftests/bpf/prog_tests/ksock_wq.c  |    29 +-
 .../selftests/bpf/prog_tests/linked_externs.c      |   120 +
 .../testing/selftests/bpf/prog_tests/lirc_mode2.c  |   334 +
 .../bpf/prog_tests/lsm_inode_init_xattr.c          |   399 +
 .../selftests/bpf/prog_tests/lwt_ip_encap.c        |    53 +
 tools/testing/selftests/bpf/prog_tests/map_excl.c  |    37 +
 .../selftests/bpf/prog_tests/may_goto_far.c        |    92 +
 .../selftests/bpf/prog_tests/may_goto_priv_stack.c |    41 +
 .../bpf/prog_tests/memcg_proactive_reclaim.c       |   130 +
 tools/testing/selftests/bpf/prog_tests/missed.c    |     8 +-
 .../selftests/bpf/prog_tests/percpu_alloc.c        |   254 +
 .../bpf/prog_tests/prog_tests_framework.c          |    43 +-
 .../selftests/bpf/prog_tests/queue_stack_map.c     |    29 +
 .../selftests/bpf/prog_tests/select_reuseport.c    |    16 +-
 .../selftests/bpf/prog_tests/signed_loader.c       |   646 +-
 .../selftests/bpf/prog_tests/skb_csum_complete.c   |    39 +
 tools/testing/selftests/bpf/prog_tests/snprintf.c  |     4 +-
 .../selftests/bpf/prog_tests/socket_helpers.h      |    12 +
 .../selftests/bpf/prog_tests/sockmap_listen.c      |    22 +-
 tools/testing/selftests/bpf/prog_tests/sockopt.c   |     4 +-
 tools/testing/selftests/bpf/prog_tests/stream.c    |   553 +
 .../bpf/prog_tests/struct_ops_private_stack.c      |    31 +
 .../selftests/bpf/prog_tests/summarization.c       |    21 +-
 tools/testing/selftests/bpf/prog_tests/tailcalls.c |   116 +
 .../selftests/bpf/prog_tests/tcp_autolowat.c       |   350 +
 .../bpf/prog_tests/test_struct_ops_arena.c         |   195 +
 .../bpf/prog_tests/test_struct_ops_multi_args.c    |    57 +-
 .../bpf/prog_tests/test_struct_ops_nullable.c      |    62 +
 .../selftests/bpf/prog_tests/test_task_work.c      |   696 +-
 .../testing/selftests/bpf/prog_tests/test_tc_edt.c |    13 +-
 .../testing/selftests/bpf/prog_tests/test_tunnel.c |    13 +-
 tools/testing/selftests/bpf/prog_tests/timer.c     |    33 +
 .../selftests/bpf/prog_tests/tracing_multi.c       |    99 +
 .../selftests/bpf/prog_tests/tracing_struct.c      |   217 +-
 .../selftests/bpf/prog_tests/unwind_attach.c       |   130 +
 .../testing/selftests/bpf/prog_tests/unwind_cxx.c  |    99 +
 .../selftests/bpf/prog_tests/uprobe_multi_test.c   |     4 +-
 tools/testing/selftests/bpf/prog_tests/usdt.c      |    54 +
 tools/testing/selftests/bpf/prog_tests/verifier.c  |    45 +
 .../selftests/bpf/prog_tests/verify_pkcs7_sig.c    |     4 +-
 tools/testing/selftests/bpf/prog_tests/wq.c        |     5 +-
 .../selftests/bpf/prog_tests/xdp_adjust_frags.c    |     3 +
 .../selftests/bpf/prog_tests/xdp_devmap_attach.c   |     5 +
 .../selftests/bpf/prog_tests/xdp_metadata.c        |     4 +-
 tools/testing/selftests/bpf/prog_tests/xsk.c       |     2 +-
 .../selftests/bpf/progs/aggregate_arg_func.c       |   188 +
 .../selftests/bpf/progs/aggregate_arg_kfunc.c      |   239 +
 .../selftests/bpf/progs/aggregate_ret_func.c       |   383 +
 .../selftests/bpf/progs/aggregate_ret_kfunc.c      |   203 +
 .../bpf/progs/aggregate_ret_kfunc_arena.c          |   121 +
 .../selftests/bpf/progs/aggregate_ret_target.c     |    29 +
 tools/testing/selftests/bpf/progs/arena_atomics.c  |   211 +-
 tools/testing/selftests/bpf/progs/arena_kfunc.c    |    67 +-
 tools/testing/selftests/bpf/progs/arena_memcg.c    |    23 +
 tools/testing/selftests/bpf/progs/arena_noarena.c  |    39 +
 tools/testing/selftests/bpf/progs/arena_race.c     |   166 +
 .../selftests/bpf/progs/async_stack_depth.c        |    75 +
 .../testing/selftests/bpf/progs/bpf_iter_netlink.c |     4 +-
 tools/testing/selftests/bpf/progs/bpf_iter_tcp4.c  |    11 +-
 tools/testing/selftests/bpf/progs/bpf_iter_tcp6.c  |    11 +-
 tools/testing/selftests/bpf/progs/bpf_iter_udp4.c  |     4 +-
 tools/testing/selftests/bpf/progs/bpf_iter_udp6.c  |     4 +-
 tools/testing/selftests/bpf/progs/bpf_iter_unix.c  |     7 +-
 tools/testing/selftests/bpf/progs/bpf_misc.h       |    28 +-
 ...bpf_qdisc_fail__invalid_dynptr_returned_slice.c |    76 +
 tools/testing/selftests/bpf/progs/bpf_tcp_ops.c    |   141 +
 .../testing/selftests/bpf/progs/bpf_tcp_ops_hdr.c  |   106 +
 .../testing/selftests/bpf/progs/bpf_tracing_net.h  |     2 +
 .../testing/selftests/bpf/progs/bpftool_ringbuf.c  |    47 +
 .../selftests/bpf/progs/btf__stack_arg_precision.c |     3 +-
 .../bpf/progs/btf__verifier_stack_arg_order.c      |     3 +-
 .../selftests/bpf/progs/btf_module_allowlist.c     |    13 +
 tools/testing/selftests/bpf/progs/call_rcu.c       |   110 +
 tools/testing/selftests/bpf/progs/call_rcu_fail.c  |   114 +
 tools/testing/selftests/bpf/progs/callx_rodata.c   |    75 +
 tools/testing/selftests/bpf/progs/cb_refs.c        |     5 +
 .../bpf/{ => progs}/cgroup_getset_retval_hooks.h   |     0
 .../selftests/bpf/progs/cgrp_kfunc_failure.c       |     8 +-
 .../selftests/bpf/progs/compute_live_registers.c   |    80 +-
 .../selftests/bpf/progs/copy_from_user_bprm.c      |    69 +
 .../testing/selftests/bpf/progs/cpumask_failure.c  |     4 +-
 .../testing/selftests/bpf/progs/cpumask_success.c  |     6 +
 tools/testing/selftests/bpf/progs/data_in_arena.c  |   112 +
 .../selftests/bpf/progs/data_in_arena_decl.c       |    37 +
 .../selftests/bpf/progs/data_in_arena_extern.c     |    20 +
 .../selftests/bpf/progs/data_in_arena_fail.c       |    20 +
 .../selftests/bpf/progs/data_in_arena_nomap.c      |    20 +
 .../selftests/bpf/progs/data_in_arena_rust.rs      |    73 +
 tools/testing/selftests/bpf/progs/dynptr_fail.c    |   113 +-
 .../selftests/bpf/progs/exceptions_dead_subprog.c  |    40 +
 .../testing/selftests/bpf/progs/exceptions_fail.c  |     2 +-
 tools/testing/selftests/bpf/progs/file_reader.c    |   129 +
 .../selftests/bpf/progs/freplace_ret_pair.c        |    12 +
 .../selftests/bpf/progs/get_func_args_test.c       |    36 +
 tools/testing/selftests/bpf/progs/irq.c            |    17 +-
 tools/testing/selftests/bpf/progs/iters.c          |   388 +-
 .../selftests/bpf/progs/iters_state_safety.c       |     3 +
 tools/testing/selftests/bpf/progs/iters_testmod.c  |    18 +-
 .../testing/selftests/bpf/progs/jit_insns_arena.c  |   111 +
 tools/testing/selftests/bpf/progs/kasan.c          |   502 +
 tools/testing/selftests/bpf/progs/kasan_harden.c   |    52 +
 tools/testing/selftests/bpf/progs/ksock_common.h   |     2 +
 .../selftests/bpf/progs/ksock_lsm_verifier.c       |    25 +-
 tools/testing/selftests/bpf/progs/ksock_sendto.c   |    59 +
 tools/testing/selftests/bpf/progs/ksock_wq.c       |    80 +-
 tools/testing/selftests/bpf/progs/linked_arena1.c  |    42 +
 tools/testing/selftests/bpf/progs/linked_arena2.c  |    22 +
 tools/testing/selftests/bpf/progs/lirc_mode2.c     |    32 +
 tools/testing/selftests/bpf/progs/lsm.c            |     5 +-
 .../selftests/bpf/progs/lsm_inode_init_xattr.c     |    98 +
 .../bpf/progs/lsm_inode_init_xattr_budget.c        |    37 +
 .../bpf/progs/lsm_inode_init_xattr_value.c         |    47 +
 tools/testing/selftests/bpf/progs/map_excl.c       |     3 +-
 tools/testing/selftests/bpf/progs/map_kptr_fail.c  |    10 +-
 tools/testing/selftests/bpf/progs/map_ptr_kern.c   |     2 +-
 .../selftests/bpf/progs/may_goto_priv_stack.c      |    52 +
 .../selftests/bpf/progs/mem_rdonly_untrusted.c     |     3 +-
 .../selftests/bpf/progs/memcg_proactive_reclaim.c  |    34 +
 .../selftests/bpf/progs/percpu_alloc_fail.c        |    35 +
 tools/testing/selftests/bpf/progs/preempt_lock.c   |    26 +
 tools/testing/selftests/bpf/progs/rbtree_fail.c    |     4 +-
 .../selftests/bpf/progs/refcounted_kptr_fail.c     |     9 +-
 .../selftests/bpf/progs/res_spin_lock_fail.c       |     2 +-
 tools/testing/selftests/bpf/progs/setget_sockopt.c |     4 +-
 .../selftests/bpf/progs/skb_csum_complete.c        |    46 +
 tools/testing/selftests/bpf/progs/stack_arg.c      |     3 +-
 tools/testing/selftests/bpf/progs/stack_arg_fail.c |    13 +-
 .../testing/selftests/bpf/progs/stack_arg_kfunc.c  |     3 +-
 .../selftests/bpf/progs/stack_arg_precision.c      |     8 +-
 tools/testing/selftests/bpf/progs/stream.c         |    48 +
 tools/testing/selftests/bpf/progs/stream_fail.c    |     2 +-
 .../bpf/progs/struct_ops_arena_autobind.c          |    64 +
 .../selftests/bpf/progs/struct_ops_arena_member.c  |   109 +
 .../progs/struct_ops_arena_member_fail__mismatch.c |    45 +
 .../struct_ops_arena_member_fail__mismatch_mem.c   |    54 +
 .../progs/struct_ops_arena_member_fail__no_arena.c |    24 +
 .../progs/struct_ops_arena_member_fail__union.c    |    34 +
 .../progs/struct_ops_arena_member_fail__write.c    |    36 +
 .../bpf/progs/struct_ops_arena_member_fail__xchg.c |    40 +
 .../bpf/progs/struct_ops_arena_member_render.c     |    85 +
 .../selftests/bpf/progs/struct_ops_multi_args.c    |    14 +-
 .../selftests/bpf/progs/struct_ops_nullable.c      |    82 +
 .../selftests/bpf/progs/struct_ops_nullable_fail.c |    28 +
 .../bpf/progs/struct_ops_nullable_fail__percpu.c   |    28 +
 .../bpf/progs/struct_ops_nullable_probed__plain.c  |    26 +
 .../bpf/progs/struct_ops_nullable_probed__scalar.c |    26 +
 .../progs/struct_ops_nullable_probed__untrusted.c  |    45 +
 .../bpf/progs/struct_ops_private_stack_fail.c      |    47 +-
 .../bpf/progs/struct_ops_private_stack_large.c     |    51 +
 .../selftests/bpf/progs/tailcall_freplace_multi.c  |    27 +
 .../selftests/bpf/progs/tailcall_large_stack.c     |    62 +
 .../selftests/bpf/progs/task_kfunc_failure.c       |    10 +-
 tools/testing/selftests/bpf/progs/task_work_busy.c |   325 +
 tools/testing/selftests/bpf/progs/task_work_fail.c |     2 +-
 tools/testing/selftests/bpf/progs/task_work_race.c |   126 +
 tools/testing/selftests/bpf/progs/tcp_autolowat.c  |   294 +
 .../selftests/bpf/progs/test_global_func1.c        |    65 +
 .../selftests/bpf/progs/test_global_func5.c        |     2 +-
 .../bpf/progs/test_global_func_deep_stack.c        |    33 +-
 .../selftests/bpf/progs/test_global_percpu_data.c  |    10 +-
 .../selftests/bpf/progs/test_kfunc_dynptr_param.c  |     2 +-
 .../selftests/bpf/progs/test_lirc_mode2_kern.c     |    26 -
 .../selftests/bpf/progs/test_skc_to_unix_sock.c    |     2 +-
 tools/testing/selftests/bpf/progs/test_snprintf.c  |     4 +-
 tools/testing/selftests/bpf/progs/test_tc_edt.c    |    13 +-
 tools/testing/selftests/bpf/progs/test_tc_link.c   |    10 +
 tools/testing/selftests/bpf/progs/timer.c          |    60 +-
 tools/testing/selftests/bpf/progs/timer_failure.c  |    29 +
 .../bpf/progs/tracing_stack_arg_tailcall_tgt.c     |    59 +
 .../bpf/progs/tracing_stack_arg_tailcall_tracer.c  |    23 +
 .../selftests/bpf/progs/tracing_struct_int128.c    |    45 +
 .../bpf/progs/tracing_struct_int128_tgt.c          |   101 +
 .../bpf/progs/tracing_struct_int128_tracer.c       |    77 +
 tools/testing/selftests/bpf/progs/unwind_attach.c  |    66 +
 tools/testing/selftests/bpf/progs/unwind_cxx.cpp   |   150 +
 .../selftests/bpf/progs/verifier_aggregate_arg.c   |   200 +
 .../selftests/bpf/progs/verifier_aggregate_ret.c   |   179 +
 tools/testing/selftests/bpf/progs/verifier_arena.c |    48 +
 .../selftests/bpf/progs/verifier_arena_large.c     |    64 +-
 .../selftests/bpf/progs/verifier_arena_scalar.c    |  1155 ++
 .../selftests/bpf/progs/verifier_bounds_step.c     |   544 +
 .../selftests/bpf/progs/verifier_bpf_fastcall.c    |   169 +
 tools/testing/selftests/bpf/progs/verifier_bswap.c |     3 +-
 .../bpf/progs/verifier_btf_array_access.c          |   577 +
 tools/testing/selftests/bpf/progs/verifier_callx.c |  1086 ++
 .../selftests/bpf/progs/verifier_callx_rodata.c    |   903 ++
 tools/testing/selftests/bpf/progs/verifier_cfg.c   |    79 +
 tools/testing/selftests/bpf/progs/verifier_ctx.c   |     2 +-
 .../selftests/bpf/progs/verifier_global_ptr_args.c |    44 +-
 .../selftests/bpf/progs/verifier_global_subprogs.c |    33 +-
 tools/testing/selftests/bpf/progs/verifier_gotol.c |     1 +
 tools/testing/selftests/bpf/progs/verifier_gotox.c |   137 +-
 .../bpf/progs/verifier_helper_access_var_len.c     |   336 +-
 .../bpf/progs/verifier_helper_packet_access.c      |     4 +-
 tools/testing/selftests/bpf/progs/verifier_idoms.c |   377 +
 .../selftests/bpf/progs/verifier_jit_convergence.c |     7 +
 .../selftests/bpf/progs/verifier_jit_inline.c      |     2 +-
 .../bpf/progs/verifier_kfunc_packet_access.c       |    47 +
 .../selftests/bpf/progs/verifier_kfunc_uninit.c    |   242 +
 .../bpf/progs/verifier_kfunc_uninit_multi.c        |   113 +
 .../selftests/bpf/progs/verifier_large_stack.c     |   425 +
 tools/testing/selftests/bpf/progs/verifier_ldsx.c  |    36 +-
 .../selftests/bpf/progs/verifier_live_stack.c      |   676 +-
 .../selftests/bpf/progs/verifier_load_acquire.c    |     1 +
 .../selftests/bpf/progs/verifier_loop_hierarchy.c  |   346 +
 tools/testing/selftests/bpf/progs/verifier_lsm.c   |    13 +
 .../selftests/bpf/progs/verifier_lsm_init_xattr.c  |   245 +
 .../selftests/bpf/progs/verifier_map_in_map.c      |     3 +-
 .../bpf/progs/verifier_map_lookup_refine.c         |     2 +-
 .../selftests/bpf/progs/verifier_may_goto_1.c      |   121 +
 tools/testing/selftests/bpf/progs/verifier_movsx.c |     3 +-
 tools/testing/selftests/bpf/progs/verifier_mtu.c   |    88 +
 .../selftests/bpf/progs/verifier_percpu_addr.c     |     1 +
 .../selftests/bpf/progs/verifier_private_stack.c   |     1 +
 .../selftests/bpf/progs/verifier_raw_stack.c       |    25 +
 .../selftests/bpf/progs/verifier_ref_tracking.c    |     6 +-
 tools/testing/selftests/bpf/progs/verifier_scev.c  |  3451 ++++
 tools/testing/selftests/bpf/progs/verifier_sdiv.c  |     3 +-
 tools/testing/selftests/bpf/progs/verifier_sock.c  |    58 +-
 .../selftests/bpf/progs/verifier_spill_fill.c      |    43 +
 .../selftests/bpf/progs/verifier_stack_arg.c       |     8 +-
 .../selftests/bpf/progs/verifier_stack_arg_order.c |     8 +-
 .../selftests/bpf/progs/verifier_stack_ptr.c       |    89 +
 .../selftests/bpf/progs/verifier_store_release.c   |     1 +
 .../selftests/bpf/progs/verifier_tailcall.c        |    57 +
 .../testing/selftests/bpf/progs/verifier_unpriv.c  |    37 +
 .../testing/selftests/bpf/progs/verifier_unwind.c  |  1240 ++
 .../bpf/progs/verifier_value_illegal_alu.c         |   173 +-
 .../testing/selftests/bpf/progs/verifier_var_off.c |    32 +
 .../selftests/bpf/progs/verifier_vfs_reject.c      |     6 +-
 tools/testing/selftests/bpf/progs/verifier_xadd.c  |    27 +
 .../selftests/bpf/progs/wakeup_source_fail.c       |     2 +-
 tools/testing/selftests/bpf/progs/wq_failures.c    |     4 +-
 tools/testing/selftests/bpf/test_btf.h             |     2 +-
 tools/testing/selftests/bpf/test_kmod.sh           |    73 -
 .../testing/selftests/bpf/test_kmods/bpf_testmod.c |   461 +-
 .../testing/selftests/bpf/test_kmods/bpf_testmod.h |    79 +
 .../selftests/bpf/test_kmods/bpf_testmod_kfunc.h   |   153 +
 tools/testing/selftests/bpf/test_lirc_mode2.sh     |    41 -
 tools/testing/selftests/bpf/test_lirc_mode2_user.c |   177 -
 tools/testing/selftests/bpf/test_loader.c          |   102 +-
 tools/testing/selftests/bpf/test_progs.c           |     5 +-
 tools/testing/selftests/bpf/test_progs.h           |     3 +
 tools/testing/selftests/bpf/testing_helpers.c      |   133 +-
 tools/testing/selftests/bpf/testing_helpers.h      |    11 +
 tools/testing/selftests/bpf/trace_helpers.c        |    39 +
 tools/testing/selftests/bpf/trace_helpers.h        |     2 +
 tools/testing/selftests/bpf/unpriv_helpers.c       |    35 +-
 tools/testing/selftests/bpf/unpriv_helpers.h       |     4 +
 tools/testing/selftests/bpf/usdt_2.c               |    16 +
 tools/testing/selftests/bpf/verifier/basic_call.c  |     2 +-
 tools/testing/selftests/bpf/verifier/calls.c       |   132 +-
 tools/testing/selftests/bpf/verifier/map_kptr.c    |     4 +-
 tools/testing/selftests/bpf/verify_sig_setup.sh    |    63 +-
 tools/testing/selftests/bpf/veristat.c             |     4 +-
 tools/testing/selftests/bpf/vmtest.sh              |    22 +-
 tools/testing/selftests/bpf/xdp_hw_metadata.c      |     2 +-
 tools/testing/selftests/hid/Makefile               |     2 +
 tools/testing/selftests/net/Makefile               |     1 -
 tools/testing/selftests/net/config                 |     1 -
 tools/testing/selftests/net/psock_lib.h            |     2 +-
 tools/testing/selftests/net/test_bpf.sh            |    11 -
 570 files changed, 60809 insertions(+), 26361 deletions(-)
 delete mode 100644 crypto/bpf_crypto_skcipher.c
 create mode 100644 include/linux/bpf_compiler_types.h
 delete mode 100644 include/linux/bpf_crypto.h
 create mode 100644 kernel/bpf/btf_vmlinux_inline.c
 create mode 100644 kernel/bpf/keys.c
 create mode 100644 kernel/bpf/loops.c
 create mode 100644 kernel/bpf/scev.c
 delete mode 100644 lib/test_bpf.c
 create mode 100644 net/ipv4/bpf_tcp_ops.c
 delete mode 100644 samples/bpf/hash_func01.h
 delete mode 100644 tools/bpf/.gitignore
 delete mode 100644 tools/bpf/bpf_asm.c
 delete mode 100644 tools/bpf/bpf_dbg.c
 delete mode 100644 tools/bpf/bpf_exp.l
 delete mode 100644 tools/bpf/bpf_exp.y
 delete mode 100644 tools/bpf/bpf_jit_disasm.c
 create mode 100644 tools/bpf/resolve_btfids/btf_colors.c
 create mode 100644 tools/bpf/resolve_btfids/btf_colors.h
 create mode 100644 tools/testing/selftests/bpf/Makefile.buildvars
 create mode 100644 tools/testing/selftests/bpf/Makefile.runner
 create mode 100644 tools/testing/selftests/bpf/Makefile.skel
 create mode 100644 tools/testing/selftests/bpf/benchs/bench_libarena.c
 create mode 100755 tools/testing/selftests/bpf/benchs/run_bench_libarena.sh
 create mode 100644 tools/testing/selftests/bpf/bpftool_btf_dump_sorted.expected
 create mode 100644 tools/testing/selftests/bpf/bpftool_btf_dump_unsorted.expected
 create mode 100755 tools/testing/selftests/bpf/gen_bpf_skel.sh
 create mode 100644 tools/testing/selftests/bpf/libarena/benchs/bench_malloc.bpf.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/aggregate_arg.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/aggregate_ret.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/arena_memcg.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/arena_race.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/arena_scalar_blinded.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/bpf_tcp_ops.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/bpf_tcp_ops_hdr.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/bpftool_btf_dump.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/bpftool_map_dump.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/bpftool_ringbuf.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/btf_inline.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/btf_module_allowlist.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/btf_rust.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/call_rcu.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/callx_func_ptr_map.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/callx_rodata_lskel.c
 delete mode 100644 tools/testing/selftests/bpf/prog_tests/cb_refs.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/clone_module_kfunc.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/copy_from_user_bprm.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/data_in_arena.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/jit_insns.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/kasan.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/ksock_sendto.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/linked_externs.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/lirc_mode2.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/lsm_inode_init_xattr.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/may_goto_far.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/may_goto_priv_stack.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/memcg_proactive_reclaim.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/skb_csum_complete.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/tcp_autolowat.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/test_struct_ops_nullable.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/unwind_attach.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/unwind_cxx.c
 create mode 100644 tools/testing/selftests/bpf/progs/aggregate_arg_func.c
 create mode 100644 tools/testing/selftests/bpf/progs/aggregate_arg_kfunc.c
 create mode 100644 tools/testing/selftests/bpf/progs/aggregate_ret_func.c
 create mode 100644 tools/testing/selftests/bpf/progs/aggregate_ret_kfunc.c
 create mode 100644 tools/testing/selftests/bpf/progs/aggregate_ret_kfunc_arena.c
 create mode 100644 tools/testing/selftests/bpf/progs/aggregate_ret_target.c
 create mode 100644 tools/testing/selftests/bpf/progs/arena_memcg.c
 create mode 100644 tools/testing/selftests/bpf/progs/arena_noarena.c
 create mode 100644 tools/testing/selftests/bpf/progs/arena_race.c
 create mode 100644 tools/testing/selftests/bpf/progs/bpf_qdisc_fail__invalid_dynptr_returned_slice.c
 create mode 100644 tools/testing/selftests/bpf/progs/bpf_tcp_ops.c
 create mode 100644 tools/testing/selftests/bpf/progs/bpf_tcp_ops_hdr.c
 create mode 100644 tools/testing/selftests/bpf/progs/bpftool_ringbuf.c
 create mode 100644 tools/testing/selftests/bpf/progs/btf_module_allowlist.c
 create mode 100644 tools/testing/selftests/bpf/progs/call_rcu.c
 create mode 100644 tools/testing/selftests/bpf/progs/call_rcu_fail.c
 create mode 100644 tools/testing/selftests/bpf/progs/callx_rodata.c
 rename tools/testing/selftests/bpf/{ => progs}/cgroup_getset_retval_hooks.h (100%)
 create mode 100644 tools/testing/selftests/bpf/progs/copy_from_user_bprm.c
 create mode 100644 tools/testing/selftests/bpf/progs/data_in_arena.c
 create mode 100644 tools/testing/selftests/bpf/progs/data_in_arena_decl.c
 create mode 100644 tools/testing/selftests/bpf/progs/data_in_arena_extern.c
 create mode 100644 tools/testing/selftests/bpf/progs/data_in_arena_fail.c
 create mode 100644 tools/testing/selftests/bpf/progs/data_in_arena_nomap.c
 create mode 100644 tools/testing/selftests/bpf/progs/data_in_arena_rust.rs
 create mode 100644 tools/testing/selftests/bpf/progs/exceptions_dead_subprog.c
 create mode 100644 tools/testing/selftests/bpf/progs/freplace_ret_pair.c
 create mode 100644 tools/testing/selftests/bpf/progs/jit_insns_arena.c
 create mode 100644 tools/testing/selftests/bpf/progs/kasan.c
 create mode 100644 tools/testing/selftests/bpf/progs/kasan_harden.c
 create mode 100644 tools/testing/selftests/bpf/progs/ksock_sendto.c
 create mode 100644 tools/testing/selftests/bpf/progs/linked_arena1.c
 create mode 100644 tools/testing/selftests/bpf/progs/linked_arena2.c
 create mode 100644 tools/testing/selftests/bpf/progs/lirc_mode2.c
 create mode 100644 tools/testing/selftests/bpf/progs/lsm_inode_init_xattr.c
 create mode 100644 tools/testing/selftests/bpf/progs/lsm_inode_init_xattr_budget.c
 create mode 100644 tools/testing/selftests/bpf/progs/lsm_inode_init_xattr_value.c
 create mode 100644 tools/testing/selftests/bpf/progs/may_goto_priv_stack.c
 create mode 100644 tools/testing/selftests/bpf/progs/memcg_proactive_reclaim.c
 create mode 100644 tools/testing/selftests/bpf/progs/skb_csum_complete.c
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_arena_autobind.c
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_arena_member.c
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_arena_member_fail__mismatch.c
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_arena_member_fail__mismatch_mem.c
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_arena_member_fail__no_arena.c
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_arena_member_fail__union.c
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_arena_member_fail__write.c
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_arena_member_fail__xchg.c
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_arena_member_render.c
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_nullable.c
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_nullable_fail.c
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_nullable_fail__percpu.c
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_nullable_probed__plain.c
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_nullable_probed__scalar.c
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_nullable_probed__untrusted.c
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_private_stack_large.c
 create mode 100644 tools/testing/selftests/bpf/progs/tailcall_freplace_multi.c
 create mode 100644 tools/testing/selftests/bpf/progs/tailcall_large_stack.c
 create mode 100644 tools/testing/selftests/bpf/progs/task_work_busy.c
 create mode 100644 tools/testing/selftests/bpf/progs/task_work_race.c
 create mode 100644 tools/testing/selftests/bpf/progs/tcp_autolowat.c
 delete mode 100644 tools/testing/selftests/bpf/progs/test_lirc_mode2_kern.c
 create mode 100644 tools/testing/selftests/bpf/progs/tracing_stack_arg_tailcall_tgt.c
 create mode 100644 tools/testing/selftests/bpf/progs/tracing_stack_arg_tailcall_tracer.c
 create mode 100644 tools/testing/selftests/bpf/progs/tracing_struct_int128_tgt.c
 create mode 100644 tools/testing/selftests/bpf/progs/tracing_struct_int128_tracer.c
 create mode 100644 tools/testing/selftests/bpf/progs/unwind_attach.c
 create mode 100644 tools/testing/selftests/bpf/progs/unwind_cxx.cpp
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_aggregate_arg.c
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_aggregate_ret.c
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_arena_scalar.c
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_bounds_step.c
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_btf_array_access.c
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_callx.c
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_callx_rodata.c
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_idoms.c
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_kfunc_packet_access.c
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_kfunc_uninit.c
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_kfunc_uninit_multi.c
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_large_stack.c
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_loop_hierarchy.c
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_lsm_init_xattr.c
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_scev.c
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_unwind.c
 delete mode 100755 tools/testing/selftests/bpf/test_kmod.sh
 delete mode 100755 tools/testing/selftests/bpf/test_lirc_mode2.sh
 delete mode 100644 tools/testing/selftests/bpf/test_lirc_mode2_user.c
 delete mode 100755 tools/testing/selftests/net/test_bpf.sh
