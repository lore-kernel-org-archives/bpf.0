Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32BD345C701;
	Thu, 24 Sep 2026 16:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790265839; cv=none; b=qsrfk88LnTUWb2PPxGjxR425x/wkq5KQPi6aKgjHg2R4OOgsvl5u1PvnymJuQgTc0vXU1thPou3K1WDIlNiOtg6gjkZVRLDH0dwjbCVngFu8+duVkRoAsAYEbO3kZTOKbVYbSCwaVtjcM9zp1C7/ehbaBOpvTujqppPgv5FQrbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790265839; c=relaxed/simple;
	bh=Sa1/qDLMq+tYta7ZCBv9zJU8VA4elnBVV453rQvqSOk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VYxiuzeBerrHeWFfaQQx3D6TAgXXAcyLf/vdn393n/v0TGYqDlojZlBgkZ8fd+IJFaTOI4W+nQxwvoN85EF84nFNI4t32UchhDXpZ7Yn6LEZc0Bv0EoiTG5qMk8Wwojo7uHg0g7JbhfuY4bLEZuEiLCAvyPNEpKJVQNWkGrA+C0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LDbyQXln; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LDbyQXln"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEC121F00893;
	Thu, 24 Sep 2026 16:03:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790265838;
	bh=OM3eGpDyQZdA9PcB/PacFp6f2It8XyGLpi/Yv1iOnlU=;
	h=From:To:Cc:Subject:Date;
	b=LDbyQXlnH9NJRVRlxLBYbHLzMECjhp8Tew/7uzkglhJkgDQyRr8/xs5/zDtBF+0CL
	 Lk5eYCZXhGYAY6ontCJvLTIKfCeVrER8lqFT01uCOeS8UqZE1xQWcJ2De5v4FwJFgG
	 25LdeVt66XFzk6enOVBZhXkbrg5UW7wcjF0xdFyGbb3TnrwtWhHoqyQdIgXkNye0mq
	 oAvlrfO44TK0C908aSeaTVAZokOwTWMjVfYH0tqoBq8R38U2Xz1TN41QlS2GeUzK6B
	 urZ/B9e+FJPkLpYMfpcXBk9vTKpFMZ6ut3CJlUxZLdMH0mxPOp7kTZoJzf4s7x+w1u
	 yNGUpxnwOji3g==
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
	"Tejun Heo" <tj@kernel.org>,
	"David Vernet" <void@manifault.com>,
	"Andrea Righi" <arighi@nvidia.com>,
	"Changwoo Min" <changwoo@igalia.com>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v2 0/3] bpf, x86: Support fetching AND/OR/XOR atomics in arena
Date: Thu, 24 Sep 2026 09:03:46 -0700
Message-ID: <20260924160354.531101-1-puranjay@kernel.org>
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
Changes in v2:
- Patch 1: drop the initial load in the arena lowering instead of adding a
  second exception table entry, per Alexei's review. A losing CMPXCHG
  reloads RAX from memory, so the loop converges without it and the CMPXCHG
  is left as the only insn that can fault. This removes the entry the
  verifier had not reserved, and with it the aux->num_exentries rescan in
  bpf_int_jit_compile() that v1 needed to account for it.
- Patch 1: say in the changelog that the bpf_jit_supports_insn() rejection
  is dropped, since that is what newly admits these programs, and that the
  arena form now always executes at least two locked CMPXCHGs.
- Patch 1: rename the shared "mem32 extable bug" message, which the atomic
  path can now raise, let the non-arena caller pass NULL for the fault and
  resume out-params, correct the INSN_LEN comment about where the bound is
  enforced, and drop an unrelated whitespace hunk.
- Patch 2: keep one __c11_atomic_fetch_*() per operation with the result
  discarded. v1 converted every case to the fetching form, which left the
  non-fetching lowering with no coverage at all, on every architecture
  rather than just x86.
- Patch 2: add both R0-aliased forms to the uaf test too. v1 only exercised
  them on live pages, so the BPF_REG_AX substitution never reached the
  exception table, which is the part patch 1 actually adds.
- Patch 2: order the new globals so they open fewer holes in .addr_space.1,
  and correct the comment about why arm64 stays out of the uaf test.
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
has LDCLRAL/LDSETAL/LDEORAL, so all three already accept these in an
arena. arm64 without LSE rejects every arena RMW atomic and is unaffected
either way, since the CMPXCHG that such a lowering would need is not
available there in an arena either.

Patch 1 emits the loop with R12-indexed addressing and without the initial
load. A CMPXCHG that loses the comparison loads the current contents into
RAX, so the loop converges from whatever R0 already holds, and the value it
stores is computed from RAX, which by definition equalled memory whenever
the store happened. That leaves the CMPXCHG as the only insn that can
fault, so the one entry the verifier already reserved is enough and nothing
has to touch aux->num_exentries. The entry resumes past the whole loop
rather than past the faulting instruction, with the fetch destination
cleared, so a fault cannot re-enter the loop. The first CMPXCHG compares
against an unrelated value, so the arena form executes at least two locked
CMPXCHGs every time; the non-arena lowering therefore keeps its load.

Patch 2 makes the selftests cover this. The existing arena and/or/xor tests
discarded the returned value, so clang emitted the non-fetching instruction
and the fetching one was never exercised. That was deliberate:
commit 2897b1e2a2f4 ("selftests/bpf: Fix arena_atomics failure due to llvm
change") switched them to __c11_atomic_fetch_*() with memory_order_relaxed
to dodge the limitation patch 1 removes. They now check the old
value via __sync_fetch_and_*(), while keeping one __c11_atomic_fetch_*()
per operation with the result discarded so the non-fetching lowering does
not lose its only coverage. A new fetch_r0 test pins the two register
assignments the JIT special-cases, and both also go into the uaf test,
since the BPF_REG_AX substitution only reaches the exception table when
such an access faults. x86 is dropped from the uaf exclusion list.

Patch 3 fixes a sched_ext comment that justifies a hand-rolled cmpxchg loop
by naming the x86 bpf_jit_supports_insn() rejection patch 1 removes. The
loop still has to stay: LSE is compiled in unconditionally since commit
6191b25d8bd9 ("arm64: Unconditionally enable LSE support"), but the switch
is still dynamic, so an ARMv8.0 CPU runs LL/SC and the arm64 JIT keeps
rejecting arena RMW atomics there. Only the reason was stale.

Puranjay Mohan (3):
  bpf, x86: Support fetching AND/OR/XOR atomics in arena
  selftests/bpf: Test fetching AND/OR/XOR atomics in arena
  sched_ext: Stop citing the x86 JIT for the cmask cmpxchg loop

 arch/x86/net/bpf_jit_comp.c                   | 236 ++++++++++++------
 tools/sched_ext/include/scx/cid.bpf.h         |   8 +-
 .../selftests/bpf/prog_tests/arena_atomics.c  |  38 +++
 .../selftests/bpf/progs/arena_atomics.c       | 156 +++++++++---
 4 files changed, 318 insertions(+), 120 deletions(-)


base-commit: 4f3a5eae895b9995e93425a75235d8f1f3268caa
-- 
2.53.0-Meta

