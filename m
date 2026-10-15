Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C437D3B8D4A;
	Thu, 15 Oct 2026 02:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792030396; cv=none; b=PkkZtqGHzWGS72CsFh+99x0hLCfT4pdOBGd9i7jM7/mBNfHzmcla0lURl19aOhlosBGGZxh2Cg99o0ypynMhu5N2TbT7W4+/BTYn6yW1F3UNFQ25m47Vwqk7v5PdIDTRASeJBtraQEvFBRCNKeSWIIVlqBiPdQchUybdcj7jTDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792030396; c=relaxed/simple;
	bh=WGJX87hElh292WZVYtRLZBfChMDrssz4BrC4YxUPGV8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ptBC33w5qw2qsymMej7Aqf9NIoAA2LM4PDhp0VdTbJeUPSqtMaLP4Gvcb9MQlmaYVkr5Z1ZoS3thCVAwXd26w9y2Yvos0xuDK1kHzDrTptsetqtfE/L4bHQRRyssEU/jCOzrpk7ZaT96cWHyqUPLeF1TyiKCR7qfWCJ0Y599ltU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=NN/dX5GT; arc=none smtp.client-ip=115.124.30.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="NN/dX5GT"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1792030384; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=JBK5MtrbNOToG3i1rm+lE1KNxMqjgadGnGOGQQ4TX6U=;
	b=NN/dX5GT1mLBvZoTufCmDp3xW7PrMZZpTVWPKbgw1/9WeJeZKWnzU595856MnPAG+8hub2FLKpPRewuN0wQZbLyU+Bv+oD2B/4GbOtl3RELjnfbAMDFRmxl8RH+kcWZKnAMbQbJsMF/JwJw2Q32gP+GQxzSRPaOZHymaSUeoS+c=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037009110;MF=cp0613@linux.alibaba.com;NM=1;PH=DS;RN=27;SR=0;TI=SMTPD_---0XCqJ00E_1792030358;
Received: from DESKTOP-S9E58SO.localdomain(mailfrom:cp0613@linux.alibaba.com fp:SMTPD_---0XCqJ00E_1792030358 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 15 Oct 2026 10:13:03 +0800
From: Chen Pei <cp0613@linux.alibaba.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	memxor@gmail.com,
	bjorn@kernel.org,
	puranjay@kernel.org
Cc: eddyz87@gmail.com,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	emil@etsalapatis.com,
	ihor.solodrai@linux.dev,
	pulehui@huawei.com,
	pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	luke.r.nels@gmail.com,
	xi.wang@gmail.com,
	shuah@kernel.org,
	rgbi3307@gmail.com,
	guoren@kernel.org,
	bpf@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next 0/3] riscv: bpf: Add BPF private stack support
Date: Thu, 15 Oct 2026 10:12:35 +0800
Message-ID: <20261015021238.5657-1-cp0613@linux.alibaba.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series adds private-stack support to the RV64 BPF JIT.

The verifier rejects a struct_ops program that requests a private stack
with -EACCES when the JIT does not report
bpf_jit_supports_private_stack(), and sched_ext requests one for its
dispatch callback, so no sched_ext scheduler can load on riscv64 today.

Allocation, the 16-byte guard regions at both ends, the guard value and
the lifetime handling follow arm64, x86-64 and powerpc64. What is
specific to riscv64 is where the pointers end up:

 - Every BPF stack access goes through BPF_REG_FP (S5), so pointing S5
   at the top of the per-CPU area and leaving SP on the kernel stack is
   all the JIT has to do. S5 is callee-saved and each subprog derives
   its own, so bpf2bpf calls need no extra save and restore.
 - The outgoing stack-argument area stays in the kernel frame: callers
   write it relative to SP while callees read it relative to RV_REG_FP.
   Unlike x86-64, no register here is shared with the private-stack
   frame pointer, so no verifier-side exclusion is needed and stack
   arguments keep working together with a private stack. arm64 already
   does the same, and patch 3 measures the three ranges at run time and
   pins them in the disassembly.
 - The per-CPU lookup is emitted after the tail-call entry point. A
   program using a private stack can still be entered as a tail-call
   target, at RV_TAILCALL_OFFSET, so it has to set up its own S5 there;
   and since that offset is a constant added to the target's bpf_func,
   everything in front of it must be the same size in every program.

The base address is materialized with absolute moves, as on arm64,
x86-64 and powerpc64. Those three reach the per-CPU offset through gs:,
TPIDR or r13 and only have to move the base into a register; riscv64 has
no such register, so the address of __per_cpu_offset is loaded here too.
A PC-relative pair is not an option for the base itself: the dynamic
per-CPU area is vmalloc'd, further from the JIT region than auipc
reaches, which is why the whole setup is ten instructions on the sv39
kernel tested here. __per_cpu_offset is a kernel-image symbol and could
use the emit_addr() form that insn_is_mov_percpu_addr() already uses, at
the same two instructions; unifying the two needs an extra_pass argument
and an error return in bpf_jit_build_prologue(), which also touches
bpf_jit_comp32.c, so it is left as is. Both constants are fixed before
the offset-convergence loop, so the prologue length is stable across
passes.

RV32 does not declare support and keeps the existing behaviour; the
prologue signature is unchanged, so bpf_jit_comp32.c needs no edit.

Testing
=======
QEMU virt rv64, an 8 vCPU SMP kernel and a 1 vCPU UP kernel, source tree
clean at the head of this series, selftests built from these patches, no
private-stack related failures. On UP, kfunc_call/subprog,
kfunc_call/subprog_lskel and scx_simple are not run: all three fail the
same way on the unpatched base.

 - verifier_private_stack, struct_ops_private_stack,
   private_stack_runtime
 - tailcalls, stack_arg, subprogs, fentry_fexit, kfunc_call,
   percpu_alloc, async_stack_depth, arena_atomics, arena_ldsx
 - may_goto_priv_stack, may_goto_far, verifier_may_goto_1,
   verifier_may_goto_2
 - scx_simple on SMP

Chen Pei (3):
  riscv: bpf: Add BPF private stack support
  selftests/bpf: Enable private stack tests for riscv64
  selftests/bpf: Add a runtime test for private stack and stack
    arguments

 arch/riscv/net/bpf_jit.h                      |   1 +
 arch/riscv/net/bpf_jit_comp64.c               |  42 +++++-
 arch/riscv/net/bpf_jit_core.c                 |  84 +++++++++--
 .../selftests/bpf/private_stack_runtime.h     |  12 ++
 .../bpf/prog_tests/private_stack_runtime.c    |  83 +++++++++++
 .../bpf/prog_tests/struct_ops_private_stack.c |   3 +-
 .../bpf/progs/private_stack_runtime.c         | 140 ++++++++++++++++++
 .../bpf/progs/verifier_private_stack.c        |  41 ++++-
 8 files changed, 392 insertions(+), 14 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/private_stack_runtime.h
 create mode 100644 tools/testing/selftests/bpf/prog_tests/private_stack_runtime.c
 create mode 100644 tools/testing/selftests/bpf/progs/private_stack_runtime.c

-- 
2.50.1

