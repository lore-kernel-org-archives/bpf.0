Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8026B54EEBD
	for <bpf@vger.kernel.org>; Fri, 16 Oct 2026 17:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792170821; cv=none; b=NTbRBAS3q7WFVUPnZyvy6B00v6B68wAZUPicEh3vuB/dmWi3g1D2F+lIyZSXshIL4YnncoDlO07flvfP7Ar3ifYBepporhOqTfyp4qcSIZEiK4C1LyAIIeHoqwtmmEVImoz/ykTT5dVWW2fCo/1prqdQvZvLxJjrpSl0rrxhbUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792170821; c=relaxed/simple;
	bh=4SDgajCRTJvuLekO7Xe4e8MqM/HPmzsCEvAS5mrAMKQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JY+chwUFiOrkiXevqvW45OtAYQxRWsdJ+l7InP3ShhzbHCQgIKLe0FzaNs1xI93AJyGU1EWXwp+Y2Ca2IHljzGwtLmKNhFlWdQPAPtFjYxYu7HM9yC8KhxMDCTgJrZvFirLXFYoyKY/UgsXj3BjdHRYNVhtxlcvbwYYwUwuL2s8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e8CTzAt/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e8CTzAt/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B16C51F000C5;
	Fri, 16 Oct 2026 17:13:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792170816;
	bh=KAJ8oz7I82PPEDXrrEHS/AfKb4bKst8phVHBDapjvLo=;
	h=From:To:Cc:Subject:Date;
	b=e8CTzAt/l71EydUdcxdfnmMN296XU4IxMkw9hSrM5ASXqzjBxXSLhoUe0aicqpu+k
	 IToORPLfNEItL6CbvIetyRPNgX5tlwjLC/qtlJNGZ2tyJu6vhX/WByuyMzpcPz32BD
	 cGsnlkV8SZ0+mtZopsFmKUG8PmLW27ESuEWN6nyFpbF6kNcMZJKm1qxZDS7IkNU04/
	 MZRIEja9XHEqV62U0dez/6AmUnQPMN3hvcEbr9TVYKB7a+rDSAE5sUK69PnLZvzyXr
	 wQs+L6hWrLfwtJ7+gmibB6e+0jF5/mEve1DCwmm/s60WwN9x9DpMHdR/BTC9AEhnWY
	 shmBOHCevyM8A==
From: Puranjay Mohan <puranjay@kernel.org>
To: bpf@vger.kernel.org
Cc: Puranjay Mohan <puranjay@kernel.org>,
	"Alexei Starovoitov" <ast@kernel.org>,
	"Daniel Borkmann" <daniel@iogearbox.net>,
	"Andrii Nakryiko" <andrii@kernel.org>,
	"Martin KaFai Lau" <martin.lau@linux.dev>,
	"Eduard Zingerman" <eddyz87@gmail.com>,
	"Kumar Kartikeya Dwivedi" <memxor@gmail.com>,
	"Song Liu" <song@kernel.org>,
	"Yonghong Song" <yonghong.song@linux.dev>,
	"Tejun Heo" <tj@kernel.org>
Subject: [PATCH bpf-next v5 0/3] bpf, x86: Support fetching AND/OR/XOR atomics in arena
Date: Fri, 16 Oct 2026 10:13:11 -0700
Message-ID: <20261016171319.1623447-1-puranjay@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changelog:
v1: https://lore.kernel.org/all/20260923165301.3463007-1-puranjay@kernel.org/
v2: https://lore.kernel.org/all/20260924160354.531101-1-puranjay@kernel.org/
v3: https://lore.kernel.org/all/20260925134828.2012199-2-puranjay@kernel.org/
v4: https://lore.kernel.org/all/20261014125017.1426212-1-puranjay@kernel.org/

Changes in v5:
- Patch 1: support these ops for accesses through a number too, instead of
  refusing them, per Alexei. BPF_F_ARENA_SCALAR accesses keep their
  address in BPF_REG_AX, where the loop saves R0, so for those R0 is
  saved on the stack with push and pop, as the div and mod lowering does.
  An R0 operand stays in that stack slot: the new value is built from it,
  RAX ends up holding the old value that R0 is to return, and the slot is
  dropped instead of popped. Both exception table entries resume before
  the pop, so a fault leaves the stack balanced. Accesses through an
  arena pointer are emitted exactly as in v4. The refusal in v4 also hid
  the reason: programs passed the verifier and then failed to load with
  ENOTSUPP and an empty log, where the verifier used to say the atomic is
  not allowed.
- Patch 2: the fetching and/or/xor tests in verifier_arena_scalar now
  have to load and pass on x86-64 as well as arm64, at both widths and
  with the operand in a register and in R0. Two more run a fetching or
  against a freed page, with the operand in a register and in R0, so that
  the access faults, and check that the fetched register comes back 0 and
  that R0 is left alone. The page holds a nonzero value first, so that an
  access which did not fault would show, and R0 is compared with a value
  derived from the page address, as a constant comparison would be decided
  by the verifier and dropped. The 32-bit operands have bits set above 32.
- Patch 2: read the address back after the faulting access, in both the
  freed-page tests and uaf. A fault that missed the JIT's exception table
  entry would be recovered by the arena mapping its zeroed scratch page and
  the access would succeed, which the checks on the registers alone could
  not tell apart. uaf now faults on the page after the freed one, as the
  freed page's 32-bit address is 0 and the address check was empty.
- Patch 2: skip the uaf register checks on powerpc64, whose JIT does not
  clear the fetched register of a faulting atomic yet.
- Rebased.

Changes in v4:
- Patch 1: go back to the v1 lowering, keeping the load of the old value
  and giving it a second exception table entry, per Tejun's review. v2 and
  v3 dropped the load so that the CMPXCHG was the only faulting insn, but
  the first CMPXCHG then almost always loses, so every operation paid for
  an extra locked CMPXCHG and the fetching insn ended up more expensive on
  x86 than the load and CMPXCHG loop it is meant to replace. The extra
  entry is accounted for in bpf_int_jit_compile() again, as in v1. The
  cleanups from v2 stay.
- Patch 1: refuse these ops when dst_reg is BPF_REG_AX (replaced in v5).
- Patch 1: correct the commit message, which claimed to add the
  reg2pt_regs[BPF_REG_AX] entry that BPF_F_ARENA_SCALAR already added, and
  update the extable sizing comment.
- Patch 2: keep each *_noreturn_value in its operation's block and the or
  block's u32s first. v3 grouped them, leaving two 4-byte holes in
  .addr_space.1 that clang-17 fails to build.
- Patch 2: check the register state after the r0 forms in uaf fault: the
  fetched register is cleared and the address register is untouched. Use
  values with high bits set in fetch_r0. Correct the comment about which
  spelling selects the non-fetching insn.
- Patch 3: say in the commit message that x86-64 schedulers built from this
  header need a kernel whose JIT accepts these ops, and that already-set
  bits now cost a locked write. Describe the comment that is actually being
  removed.

Changes in v3:
- Patch 2: keep the 32-bit non-fetching and/or/xor as well.
- Patch 2: guard the new uaf asm on __BPF_FEATURE_ADDR_SPACE_CAST, since
  textual addr_space_cast needs LLVM 19.
- Patch 3: use __sync_fetch_and_or/and in cid.bpf.h and delete the cmpxchg
  loop, rather than only rewording the comment that justified it.

Changes in v2:
- Patch 1: drop the initial load in the arena lowering instead of adding a
  second exception table entry (reverted in v4).
- Patch 1: note the dropped bpf_jit_supports_insn() rejection in the
  changelog, rename the shared "mem32 extable bug" message, let the
  non-arena caller pass NULL for the out-params, correct the INSN_LEN
  comment, and drop an unrelated whitespace hunk.
- Patch 2: keep non-fetching coverage, add the R0-aliased forms to uaf,
  and correct the comment about why arm64 stays out of uaf.
- Patch 3: new.

A fetching AND/OR/XOR against arena memory is rejected on x86-64:

  BPF_ATOMIC stores into R1 arena is not allowed

x86-64 has no single instruction for these, so the JIT lowers them to a
CMPXCHG loop. The loop performs two memory accesses, the load of the old
value and the CMPXCHG itself, and either can fault when the arena page
goes away. The verifier reserves one exception table entry per
instruction, so there was nowhere to record the second one and
bpf_jit_supports_insn() refused the three opcodes instead.

x86-64 is the only architecture that needs this. riscv64 has native
AMOAND/AMOOR/AMOXOR with fetch, s390 has LAN/LAO/LAX, and arm64 with LSE
has LDCLRAL/LDSETAL/LDEORAL, so these already work in an arena, as does
powerpc64. arm64 without LSE and loongarch reject every arena RMW atomic,
CMPXCHG included, so nothing can be lowered there either way.

Patch 1 emits the loop with R12-indexed addressing and gives the load and
the CMPXCHG an exception table entry each. Both resume past the whole loop
rather than past the faulting instruction, with the fetch destination
cleared, so a fault cannot re-enter the loop. The JIT accounts for the
extra entry by rescanning the instruction stream in bpf_int_jit_compile()
before the extable is sized; s390 does the same in bpf_jit_alloc() for
its BPF_XCHG lowering. The resulting code is the same load and CMPXCHG
loop as the non-arena lowering, which is what programs hand-roll today,
minus the early exit a hand-rolled loop can take when the value is
already as wanted. The loop needs RAX, so R0 is saved in BPF_REG_AX. An
access through a number keeps its address there, and every arena access
in Rust is one, so those save R0 on the stack instead, as div and mod do.

Patch 2 makes the selftests cover this. The existing arena and/or/xor tests
discarded the returned value, so clang emitted the non-fetching instruction
and the fetching one was never exercised. That was deliberate:
commit 2897b1e2a2f4 ("selftests/bpf: Fix arena_atomics failure due to llvm
change") switched them to __c11_atomic_fetch_*() with memory_order_relaxed
to dodge the limitation patch 1 removes. They now check the old value via
__sync_fetch_and_*(), while keeping a __c11_atomic_fetch_*() of each width
per operation with the result discarded so the non-fetching lowering keeps
its coverage. A new fetch_r0 test pins the two register assignments the
JIT special-cases, and both also go into the uaf test, since the
BPF_REG_AX substitution only reaches the exception table when such an
access faults. x86 is dropped from the uaf exclusion list. Accesses through
a number are covered in verifier_arena_scalar.

Patch 3 drops the hand-rolled cmpxchg loop in sched_ext's cid.bpf.h, which
only existed because of the x86 restriction patch 1 removes, and uses the
fetching atomics directly. The loop was not a portability fallback either:
arm64 without LSE rejects every arena read-modify-write including CMPXCHG,
and riscv without Zacas rejects only CMPXCHG, so the loop is strictly
worse than a fetching OR there.

Testing
=======

test_progs arena_atomics passes on x86-64, arm64 and s390x, and
verifier_arena_scalar on x86-64 and arm64, the architectures that take
BPF_F_ARENA_SCALAR.

tools/sched_ext builds, and scx_qmap - the only in-tree user of the cmask
helpers - lowers them to 17 atomic_fetch_or and 4 atomic_fetch_and with no
CMPXCHG left in the cmask helpers. Nothing in test_progs exercises cmask_*.
The uaf test faults on the load; the CMPXCHG entry is only reached when the
page goes away between the two accesses, which no test can arrange.

Puranjay Mohan (3):
  bpf, x86: Support fetching AND/OR/XOR atomics in arena
  selftests/bpf: Test fetching AND/OR/XOR atomics in arena
  sched_ext: Use fetching atomics for cmask instead of a cmpxchg loop

 arch/x86/net/bpf_jit_comp.c                   | 295 +++++++++++++-----
 tools/sched_ext/include/scx/cid.bpf.h         |  79 +----
 .../selftests/bpf/prog_tests/arena_atomics.c  |  53 ++++
 .../selftests/bpf/progs/arena_atomics.c       | 211 ++++++++++---
 .../bpf/progs/verifier_arena_scalar.c         | 256 +++++++++++++++
 5 files changed, 707 insertions(+), 187 deletions(-)


base-commit: 242d8416f60cef4864d1a9de0943bd3f299e960c
-- 
2.53.0-Meta

