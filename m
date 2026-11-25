Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.30.99
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795609319;
	b=D7PPqvbMW6gZTlLYNLWFl9TuoKaFVLp/fHQ/wzrbOG6Pi999ByEaZnLttyaaA91jnzve
	 8iZQUKIAI894CVpX2p9R9lS2oSwFPgi5rp5GK4ItNaZdmXqqYxhh3wq290h6A+EEQEeOl
	 gOW9QSO/9oqUlp5BuqHV7GfmGNwGUbu9OOnCabgtlq39IBUS1kSF0pWnRSWOBvg5EpwZx
	 AxNvBIg4b9zV5GtKiBy9akkOoBoIY9lwYnZBj5HipwE0fpjKCbN6V801cwB8zVhoLOuib
	 tlo7bCc3gOtGZLQkmTqe69DhYnRUYgUbHZ0qJk8wtUD/NaqtpDX1lATR55yosrEc90A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795609319;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=6pE97X/Hn04iXAcuWJw94ha23fj8mepdZBbL3FYiqqc=;
	b=2DAi8bHfhmW1iZ908a5sSiig2OoT6t35ZJBoxDZCtFoFPQl2a1Fp803jSD0rJyzcWITN
	 PeO8pwNowGjWXo2Fb+zpvj2ZuKvGIfnClAWCayXe18FqfnyC7hBVCnc4WkW+0S+Ytf9J9
	 eq7z0ydOxTDn2BUVEIrDDelErrI1TU2yUZL3UllwjPxIh+0S6aUI5fbTO6QWfRdRm3Eg9
	 4idolWV5qTkWH5m73yqiRntSovg+kkkYf74mD5K5FVjHeAiQsCdUd4ti/0PLzMNYa8+fS
	 cCVJFJnsrWHgZnOvfXWSXJEw59mN/cUnYWf+/9L+GGTKD6lxsucfsPBav+O6x07xgcw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.alibaba.com;
	spf=pass smtp.mailfrom=linux.alibaba.com;
	dkim=pass header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=OrErzfAk;
	arc=none smtp.remote-ip=115.124.30.99
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84C28606A337;
	Wed, 25 Nov 2026 12:21:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 84C28606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=OrErzfAk
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1795609306; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=6pE97X/Hn04iXAcuWJw94ha23fj8mepdZBbL3FYiqqc=;
	b=OrErzfAkCQuYrBoJPOvFVIWFF15jOJGt52eZfad6+e8RMMd3+RIYXhSc4XzFInzwVmXqfschTa4oGCuelT+fqhN1oOwpRlklM4528bGwf0Y36ZK9rlMhWy+Pt14x6MrLcyw/+Uc+e5EYFT6THPurPosE3qrYmg4FvWZyj/kk91Y=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R891e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037009110;MF=cp0613@linux.alibaba.com;NM=1;PH=DS;RN=28;SR=0;TI=SMTPD_---0XFRiiym_1795609286;
Received: from DESKTOP-S9E58SO.localdomain(mailfrom:cp0613@linux.alibaba.com fp:SMTPD_---0XFRiiym_1795609286 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 25 Nov 2026 20:21:44 +0800
From: Chen Pei <cp0613@linux.alibaba.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	memxor@gmail.com,
	bjorn@kernel.org,
	puranjay@kernel.org,
	alexei.starovoitov@gmail.com
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
Subject: [PATCH v4 bpf-next 0/3] riscv: bpf: Add BPF private stack support
Date: Wed, 25 Nov 2026 20:21:23 +0800
Message-ID: <20261125122126.939-1-cp0613@linux.alibaba.com>
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
x86-64 and powerpc64; the 16 byte two-copy guard layout follows arm64
and powerpc64, since x86-64 uses an 8 byte guard with a single copy.
What is specific to riscv64 is where the pointers end up:

 - Every BPF stack access goes through BPF_REG_FP (S5), so pointing S5
   at the top of the per-CPU area and leaving SP on the kernel stack is
   all the JIT has to do. S5 is callee-saved and each subprog derives
   its own, so bpf2bpf calls need no extra save and restore.
 - The outgoing stack argument area stays in the kernel frame: callers
   write it relative to SP while callees read it relative to RV_REG_FP.
   Unlike x86-64, no register here is shared with the private-stack
   frame pointer, so no verifier-side exclusion is needed and stack
   arguments keep working together with a private stack. arm64 already
   does the same, and patch 3 tests that combination.
 - The per-CPU lookup is emitted after the tail call entry point. A
   program using a private stack can still be entered as a tail call
   target, at RV_TAILCALL_OFFSET, so it has to set up its own S5 there;
   and since that offset is a constant added to the target's bpf_func,
   everything in front of it must be the same size in every program.

The base address is materialized with absolute moves, as on arm64,
x86-64 and powerpc64, which reach the per-CPU offset through gs:, TPIDR
or r13; riscv64 has no such register, so the address of __per_cpu_offset
is loaded too. Patch 1 has the detail, including why emit_imm() is a
choice there and why the prologue length stays fixed across passes.

RV32 does not declare support and keeps the existing behaviour; the
prologue signature is unchanged, so bpf_jit_comp32.c needs no edit.

Changes since v3:
 - Patch 3: Reviewed-by tag added.
 - Rebased onto 8dfce13340ae.

Changes since v2:
 - Patch 1: PRIV_STACK_GUARD_VAL moved to bpf_jit.h.
 - Patch 3: The test redone as two asm programs in
   progs/verifier_stack_arg.c.

Changes since v1:
 - Patch 1 commit message: guard layout credited to arm64 and powerpc64,
   value alone to x86-64; __per_cpu_offset described as a choice.
 - Patch 3: test_private_stack_runtime() renamed to
   serial_test_private_stack_runtime(), and the stack argument skip
   prints a reason.

Testing
=======
QEMU virt rv64, an 8 vCPU SMP kernel and a 1 vCPU UP kernel, both built
at the head of this series on the base commit below, source tree clean,
selftests built from these patches. There are no private-stack related
failures, and the private-stack suites logged no BUG, WARNING, unknown
opcode or guard corruption.

 - verifier_private_stack, struct_ops_private_stack.
 - tailcalls, stack_arg, subprogs, fentry_fexit, percpu_alloc,
   async_stack_depth, arena_atomics, stack_arg_precision.
 - verifier_stack_arg, including patch 3's test.
 - may_goto_priv_stack, may_goto_far, verifier_may_goto_1,
   verifier_may_goto_2.
 - on SMP, scx_simple and the sched_ext runner sweep: 40 cases, 39 pass.
   enable_cmask fails because its ops.enable() takes a struct scx_cmask
   __arena pointer and riscv64 does not implement
   bpf_jit_supports_arena_args().
 - patch 3's test again on x86-64 and arm64, so all three architectures
   it is gated on have run it.

Chen Pei (3):
  riscv: bpf: Add BPF private stack support
  selftests/bpf: Enable private stack tests for riscv64
  selftests/bpf: Test a private stack together with stack arguments

 arch/riscv/net/bpf_jit.h                      |  2 +
 arch/riscv/net/bpf_jit_comp64.c               | 42 +++++++++-
 arch/riscv/net/bpf_jit_core.c                 | 82 +++++++++++++++++--
 .../bpf/prog_tests/struct_ops_private_stack.c |  3 +-
 .../bpf/progs/verifier_private_stack.c        | 41 +++++++++-
 .../selftests/bpf/progs/verifier_stack_arg.c  | 49 +++++++++++
 6 files changed, 205 insertions(+), 14 deletions(-)


base-commit: 8dfce13340aeba06d1b68cc7648f37762244be65
-- 
2.50.1

