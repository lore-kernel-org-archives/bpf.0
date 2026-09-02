Received: from zg8tmja2lje4os43os4xodqa.icoremail.net (zg8tmja2lje4os43os4xodqa.icoremail.net [206.189.79.184])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 829963A9D99
	for <bpf@vger.kernel.org>; Wed,  2 Sep 2026 07:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=206.189.79.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788332795; cv=none; b=I+W7VPLStnTFGoxcvcfMxx3QACFAisYOQ4ZUEoo1TuKVuOYe+qo0rN0d1ac072+R8g5Tfbor30pvkT5+Xsnq1TcGk7731bN2xzQD9QF1wsXOmoi1oQBrTSO0KHeobG6Ih3aGQU+COEf3FyIOVmugyMJVr14kjsPZxOc73bI37As=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788332795; c=relaxed/simple;
	bh=cTKV+JJ5/uIiJU8B2+nyDwjE8cNyPN3GGVldBMcKSL4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IIFGQyGYg936xSdu6MYkBe22CR4hO7opyN/JoLB6XClTzhArhRB/fxNmX//qy05pXpgP6Ec469YQlo0Cy6fkWeYPGxScjtAeIkS17i2cp417m6FaXEMEfzVVXIruYGIcVTfoX/GvMGen1XZrOJxkT4LjPEDNPAJQuTCWutPbOx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=206.189.79.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from zju.edu.cn (unknown [10.14.28.207])
	by mtasvr (Coremail) with SMTP id _____wDX33_YypdqBhXjAA--.34538S3;
	Wed, 02 Sep 2026 15:06:01 +0800 (CST)
Received: from lutetium.tail477849.ts.net (unknown [10.14.28.207])
	by mail-app2 (Coremail) with SMTP id zC_KCgAXhsvXypdq4h1IBA--.23237S2;
	Wed, 02 Sep 2026 15:05:59 +0800 (CST)
From: Yazhou Tang <tangyazhou@zju.edu.cn>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	eddyz87@gmail.com
Cc: daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	tangyazhou518@outlook.com,
	shenghaoyuan0928@163.com,
	ziye@zju.edu.cn
Subject: [RFC PATCH bpf-next 0/6] bpf: Add UHMUL and SHMUL instructions
Date: Wed,  2 Sep 2026 15:05:28 +0800
Message-ID: <20260902070534.2141812-1-tangyazhou@zju.edu.cn>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zC_KCgAXhsvXypdq4h1IBA--.23237S2
X-CM-SenderInfo: qssvjiasrsq6lmxovvfxof0/1tbiBgMBCmqV2RkiOAABsq
X-CM-DELIVERINFO: =?B?zzX5ZAXKKxbFmtjJiESix3B1w3vD7IpoGYuur0o+r46DyAi5OfOO+T4vrW4FyUBIyu
	9q9HB9RydHY5jW4uktguz+UT2aor+rpKCW5kcHLnWvXriHdtjYH1uH/ad7OQNRHqIHXY+Z
	gBWaf/9ZhuekqXAZ5/SajSQOojjjHCsCaNNUtK084wrjKm0pkm+mfsaWne7lUw==
X-Coremail-Antispam: 1Uk129KBj93XoWxZw45tFy7AFW7KF47Gr4UAwc_yoW5Cw47pF
	s5Gr9xGa9Fgry093WxZanrury5XF409w43CF15urWUJ3WqqryIqr4fKw15AFZ8A3WYq3WF
	vryY9rn8G34kZagCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUU9Kb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Cr1j6rxdM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I
	8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AK
	xVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7xvr2IYc2Ij64
	vIr40E4x8a64kEw24lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2Ij64vIr41l4I8I
	3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxV
	WUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAF
	wI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcI
	k0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j
	6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU7xwIDUUUU

From: Yazhou Tang <tangyazhou518@outlook.com>

This patchset adds unsigned and signed high-half multiplication to the BPF
ISA. UHMUL returns the high 64 bits of an unsigned 64-by-64-bit product,
while SHMUL does the same for a signed product.

Both operations are BPF_ALU64 BPF_MUL variants selected by insn->off.
off == 0 remains the existing low-half multiplication, while off == 1
and off == 2 select UHMUL and SHMUL, respectively. The immediate forms
use the usual sign-extended 32-bit BPF immediate.

The patchset adds interpreter, disassembler, verifier, documentation, and
x86-64 JIT support. Unsupported JIT and hardware offload backends reject
the variants to avoid compiling them as ordinary multiplication. For
now, the verifier computes exact results for constant operands and
otherwise conservatively marks the destination unknown.

Patch 6/6 uses raw bytecode for UHMUL and SHMUL because LLVM support has
not been merged yet. Once it is available, the raw encodings can be
replaced with the uh*= and sh*= mnemonics. A draft LLVM implementation
is available at:

  https://github.com/ADSWT518/llvm-project/tree/bpf-hmul-insn

We plan to finalize and submit it as an LLVM pull request after the
kernel-side ISA changes are merged.

The instruction design is inspired by the UHMUL and SHMUL operations in
Solana sBPF. Patch 1/6 describes the encoding and immediate-semantics
differences.

Feedback on the encoding, immediate semantics, and initial verifier
model would be appreciated.

Tianci Cao (3):
  bpf: Add UHMUL and SHMUL instructions
  bpf, x86: JIT UHMUL and SHMUL on x86-64
  bpf: Add verifier support for UHMUL and SHMUL

Yazhou Tang (3):
  bpf: Reject UHMUL/SHMUL in unsupported JITs
  bpf: Refactor ALU instruction variant validation
  selftests/bpf: Add bytecode tests for UHMUL and SHMUL

 .../bpf/standardization/instruction-set.rst   |  26 +-
 arch/arc/net/bpf_jit_core.c                   |   3 +
 arch/arm/net/bpf_jit_32.c                     |   3 +
 arch/arm64/net/bpf_jit_comp.c                 |   3 +
 arch/loongarch/net/bpf_jit.c                  |   3 +
 arch/mips/net/bpf_jit_comp32.c                |   3 +
 arch/mips/net/bpf_jit_comp64.c                |   3 +
 arch/parisc/net/bpf_jit_comp32.c              |   3 +
 arch/parisc/net/bpf_jit_comp64.c              |   3 +
 arch/powerpc/net/bpf_jit_comp32.c             |   3 +
 arch/powerpc/net/bpf_jit_comp64.c             |   3 +
 arch/riscv/net/bpf_jit_comp32.c               |   3 +
 arch/riscv/net/bpf_jit_comp64.c               |   3 +
 arch/s390/net/bpf_jit_comp.c                  |   3 +
 arch/sparc/net/bpf_jit_comp_64.c              |   3 +
 arch/x86/net/bpf_jit_comp.c                   |  48 +++
 arch/x86/net/bpf_jit_comp32.c                 |   3 +
 .../net/ethernet/netronome/nfp/bpf/verifier.c |   6 +
 include/linux/filter.h                        |  39 +++
 include/uapi/linux/bpf.h                      |  10 +
 kernel/bpf/core.c                             |  45 ++-
 kernel/bpf/disasm.c                           |  18 ++
 kernel/bpf/verifier.c                         |  69 ++++-
 tools/include/uapi/linux/bpf.h                |  10 +
 .../selftests/bpf/prog_tests/verifier.c       |   2 +
 .../selftests/bpf/progs/verifier_hmul.c       | 284 ++++++++++++++++++
 .../bpf/progs/verifier_value_illegal_alu.c    |   9 +-
 27 files changed, 598 insertions(+), 13 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_hmul.c

-- 
2.43.0

