Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.30.119
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793786665;
	b=1kl4lMyWMihTVCR8ko1ILpbJtmViSkdNrspCVii3fv4iYz8SwGI1+wJMXRfBM+SbZpfx
	 zYDXn3EXGr8iQTqfb8SxbndvIZb43s7J0CX0GLr8NtvbAWiZyTmg0qVhxgGtkcdf1t7bs
	 64l/7Bpu+S11znJb+bpAc/bgc4nADYp6nMQjBv61l2qvTe/KMIN3eR9js+Wj4j7LZyqeM
	 EoMfbr2xNypZ5YJIsjK5JqsCzKpsv0wmHK4f+s71N4dc5TVsxU9LD6DXxTe/2/V7FO5tc
	 7OmNi0l84lKhKr70Ksg5rohAIFVbN6zai1qVMxHEOUfeCSBrtORI2MUlqUR5bT/EHhg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793786665;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=MGGIrCRkMY2tw6CcNj/MCmch+qG0XHux1S4w4kckfr0=;
	b=CfmvfqIK6V6sPLnIWkSOoUYLlf2elq7dX89ypn/GfUjNVw77E/+ckmCl6dvfpzvx4hd9
	 bbaDB1aN3uqNxLQ8IPQs0W3g3McXyl6sRBZTTiFvjZeJktCrgWV45OX2DVTl4wZNmMSrt
	 ehSzjLDAu/JLUYFqGDSOMhFZqHQ1+MRST8IcCRKY7lH3gT9tRkxI9NzLQfW/qM0NgfiIx
	 t+KPN2Uet1+2rKZ2XLdgMUHCwM1TbX7WSgYgN01U4M8QaiJxtUx+aUORqt2zI+4PlyCDs
	 +4uhVgppV64126gHyGoxLZVPId+UJBzLqPVTheYNR3msPE85Goe9TE/hfFrLW37YicQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.alibaba.com;
	spf=pass smtp.mailfrom=linux.alibaba.com;
	dkim=pass header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=W8GFFAQE;
	arc=none smtp.remote-ip=115.124.30.119
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 140E9606A31B;
	Wed,  4 Nov 2026 10:04:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 140E9606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=W8GFFAQE
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1793786659; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=MGGIrCRkMY2tw6CcNj/MCmch+qG0XHux1S4w4kckfr0=;
	b=W8GFFAQEtk+ehX5Hhr1k/61DxOBmxlI0M9fHwV10sppXtzjO1v/tSptzPYA9SzQcMKCvg6ipfC6khg9DvjEXqIDu/wGakDU7IoP3EwCTxiXq+b5E6lT9oACMtgt8mHxdSQixmvo2C1QFBHbaHDR40k4zqvMHJaA+mF4SJs1jeFU=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R331e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037026112;MF=cp0613@linux.alibaba.com;NM=1;PH=DS;RN=27;SR=0;TI=SMTPD_---0XE5SaXm_1793786652;
Received: from DESKTOP-S9E58SO.localdomain(mailfrom:cp0613@linux.alibaba.com fp:SMTPD_---0XE5SaXm_1793786652 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 04 Nov 2026 18:04:17 +0800
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
Subject: [PATCH v2 bpf-next 0/3] riscv: bpf: Add BPF private stack support
Date: Wed,  4 Nov 2026 18:04:08 +0800
Message-ID: <20261104100411.997-1-cp0613@linux.alibaba.com>
X-Mailer: git-send-email 2.43.0
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

This series adds private-stack support to the RV64 BPF JIT.

The verifier rejects a struct_ops program that requests a private stack
with -EACCES when the JIT does not report
bpf_jit_supports_private_stack(), and sched_ext requests one for its
dispatch callback, so no sched_ext scheduler can load on riscv64 today.

Allocation, the guard value and the lifetime handling follow arm64,
x86-64 and powerpc64; the 16-byte two-copy guard layout follows arm64
and powerpc64, since x86-64 uses an 8-byte guard with a single copy.
What is specific to riscv64 is where the pointers end up:

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
reaches, which is why the whole setup is ten instructions on the kernel
tested here. __per_cpu_offset is a kernel-image symbol and on that
kernel lands in the sign-extended 32-bit range, so emit_imm() renders it
in two instructions through its 32-bit fast path - what an emit_addr()
pair would cost, and the form insn_is_mov_percpu_addr() already uses;
unifying the two needs an extra_pass argument and an error return in
bpf_jit_build_prologue(), which also touches bpf_jit_comp32.c, so it is
left as is. Both constants are fixed before the offset-convergence loop,
so the prologue length is stable across passes.

RV32 does not declare support and keeps the existing behaviour; the
prologue signature is unchanged, so bpf_jit_comp32.c needs no edit.

Changes since v1:
 - Patch 1 commit message: guard layout credited to arm64 and powerpc64,
   value alone to x86-64; __per_cpu_offset described as a choice.
 - Patch 3: test_private_stack_runtime() renamed to
   serial_test_private_stack_runtime(), and the stack-argument skip
   prints a reason.

Testing
=======
QEMU virt rv64, an 8 vCPU SMP kernel and a 1 vCPU UP kernel, both built
on the base commit below, source tree clean at the head of this series,
selftests built from these patches. There are no private-stack related
failures, and no run logged a BUG, WARNING, panic, unknown opcode or
guard corruption. On UP, kfunc_call/subprog, kfunc_call/subprog_lskel
and scx_simple are not run: all three fail the same way on the unpatched
base.

 - verifier_private_stack, struct_ops_private_stack,
   private_stack_runtime.
 - tailcalls, stack_arg, subprogs, fentry_fexit, kfunc_call,
   percpu_alloc, async_stack_depth, arena_atomics, arena_ldsx.
 - verifier_stack_arg, stack_arg_precision.
 - may_goto_priv_stack, may_goto_far, verifier_may_goto_1,
   verifier_may_goto_2.
 - scx_simple.
 - sched_ext runner sweep on SMP: 40 cases, 39 pass. enable_cmask fails
   because its ops.enable() takes a struct scx_cmask __arena pointer and
   riscv64 does not implement bpf_jit_supports_arena_args().

Chen Pei (3):
  riscv: bpf: Add BPF private stack support
  selftests/bpf: Enable private stack tests for riscv64
  selftests/bpf: Add a runtime test for private stack and stack
    arguments

 arch/riscv/net/bpf_jit.h                      |   1 +
 arch/riscv/net/bpf_jit_comp64.c               |  42 +++++-
 arch/riscv/net/bpf_jit_core.c                 |  84 +++++++++--
 .../selftests/bpf/private_stack_runtime.h     |  12 ++
 .../bpf/prog_tests/private_stack_runtime.c    |  84 +++++++++++
 .../bpf/prog_tests/struct_ops_private_stack.c |   3 +-
 .../bpf/progs/private_stack_runtime.c         | 140 ++++++++++++++++++
 .../bpf/progs/verifier_private_stack.c        |  41 ++++-
 8 files changed, 393 insertions(+), 14 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/private_stack_runtime.h
 create mode 100644 tools/testing/selftests/bpf/prog_tests/private_stack_runtime.c
 create mode 100644 tools/testing/selftests/bpf/progs/private_stack_runtime.c


base-commit: 8fb43ffc3327d12d57d3fbe6f4820b5a522de0d1
-- 
2.50.1

