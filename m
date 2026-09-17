Received: from fraori-sdnproxy-3.icoremail.net (fraori-sdnproxy-3.icoremail.net [132.226.202.154])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9CAC3BB114
	for <bpf@vger.kernel.org>; Thu, 17 Sep 2026 04:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=132.226.202.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789618672; cv=none; b=D/gW+6WItLnygG1oL3jfe2oIaEel5S5O4siVvu1BrYWO+WPcoOxhJd0j5gT5HS4gHMkcL8u9SLE+eU0xDWXfRJQBk6CcMPE3mhtoJ8FuRWG3Labgdh17gP5yYfNM0AXB5IHAfMcYYWhUgiYpPLJ4RXas/+gUuPCEHpGp/8652wU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789618672; c=relaxed/simple;
	bh=bk/CZ/fzvPfrOaUOT71UDcjzcf0q4/K/ErWnTHIsvRI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GGzCIcv6qqcCWeAG1md0Bu/ENqij03Q5VJTcr6ZRs1wrUJeTuACvqlgACrTrwlYqoZYatD8CyG0GGw4cEtRJADcDAlU+4V6HPPJY5BxjWyOo+Iv5yUKdXwzw3+JNdhJ4W5ETOoqIpShRwDVBCoOHYwCR4cD2V72UehTXK400nR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=132.226.202.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from zju.edu.cn (unknown [10.162.163.215])
	by mtasvr (Coremail) with SMTP id _____wCntizTaatqixMdAQ--.3694S3;
	Thu, 17 Sep 2026 12:17:24 +0800 (CST)
Received: from lutetium.tail477849.ts.net (unknown [10.162.163.215])
	by mail-app1 (Coremail) with SMTP id yy_KCgA3OqTSaatqEeuJBA--.2235S2;
	Thu, 17 Sep 2026 12:17:22 +0800 (CST)
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
Subject: [PATCH bpf-next 0/8] bpf: Add UHMUL and SHMUL instructions
Date: Thu, 17 Sep 2026 12:17:04 +0800
Message-ID: <20260917041712.1860722-1-tangyazhou@zju.edu.cn>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:yy_KCgA3OqTSaatqEeuJBA--.2235S2
X-CM-SenderInfo: qssvjiasrsq6lmxovvfxof0/1tbiAgERCmqq8RoVXQAAs7
X-CM-DELIVERINFO: =?B?TZ7aQgXKKxbFmtjJiESix3B1w3vD7IpoGYuur0o+r46DyAi5OfOO+T4vrW4FyUBIyu
	9q9BMXZiQifGBAu8ehqrOKaOragjxlbeodaCWWWjQfTKBB61ytTkjJPC7qLy1LZLEI2CAC
	gnVyKwjqgyo6YpBUhAm7n7Mz6b9PGK8/rdf+Px2wn4sg/VzEg5PabqxzMCvszA==
X-Coremail-Antispam: 1Uk129KBj93XoWxZw45Jw47tr43tr1fZFWrWFX_yoW5Kr48pF
	s5Gr9xCa9FgFy09w1xZanrury5JF40kr43CF1rurW5t3WqqFyxXr4fKw15ArZ8AF4jq3WF
	vryY9rn8C34kZagCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUU9Eb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AK
	xVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI0UMc
	02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAF
	wI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0Y48IcxkI7V
	AKI48G6xCjnVAKz4kxM4IIrI8v6xkF7I0E8cxan2IY04v7MxAIw28IcxkI7VAKI48JMxC2
	0s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI
	0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE
	14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20x
	vaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8
	JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU801v3UUUUU==

From: Yazhou Tang <tangyazhou518@outlook.com>

This patchset adds unsigned and signed high-half multiplication to the BPF
ISA. UHMUL returns the high 64 bits of an unsigned 64-by-64-bit product,
while SHMUL does the same for a signed product.

Both operations are BPF_ALU64 BPF_MUL variants selected by insn->off.
off == 0 remains the existing low-half multiplication, while off == 1
and off == 2 select UHMUL and SHMUL, respectively. The immediate forms
use the usual sign-extended 32-bit BPF immediate.

The patchset adds interpreter, disassembler, verifier, documentation, and
JIT support on x86-64, arm64 and riscv64. Unsupported JIT and hardware
offload backends reject the variants to avoid compiling them as ordinary
multiplication. For now, the verifier computes exact results for constant
operands and otherwise conservatively marks the destination unknown.

Patch 8/8 uses raw bytecode for UHMUL and SHMUL because LLVM support has
not been merged yet. Once it is available, the raw encodings can be
replaced with the uh*= and sh*= mnemonics. A draft LLVM implementation
is available at:

  https://github.com/ADSWT518/llvm-project/tree/bpf-hmul-insn

We plan to finalize and submit it as an LLVM pull request after the
kernel-side ISA changes are merged.

The instruction design is inspired by the UHMUL and SHMUL operations in
sBPF (Solana's BPF variant). Patch 1/8 describes the encoding and
immediate-semantics differences.

---

Change log:

v1:
1. Add JIT support on arm64 and riscv64. (Alexei)
2. Fix the HMUL check on PowerPC JIT backend. (Sashiko AI reviewer)

RFC: https://lore.kernel.org/bpf/20260902070534.2141812-1-tangyazhou@zju.edu.cn/

Tianci Cao (3):
  bpf: Add UHMUL and SHMUL instructions
  bpf, x86: JIT UHMUL and SHMUL on x86-64
  bpf: Add verifier support for UHMUL and SHMUL

Yazhou Tang (5):
  bpf, arm64: JIT UHMUL and SHMUL
  bpf, riscv: JIT UHMUL and SHMUL on RV64
  bpf: Reject UHMUL/SHMUL in unsupported backends
  bpf: Refactor ALU instruction variant validation
  selftests/bpf: Add bytecode tests for UHMUL and SHMUL

 .../bpf/standardization/instruction-set.rst   |  26 +-
 arch/arc/net/bpf_jit_core.c                   |   3 +
 arch/arm/net/bpf_jit_32.c                     |   3 +
 arch/arm64/include/asm/insn.h                 |   4 +
 arch/arm64/lib/insn.c                         |   6 +
 arch/arm64/net/bpf_jit.h                      |   6 +
 arch/arm64/net/bpf_jit_comp.c                 |  15 +-
 arch/loongarch/net/bpf_jit.c                  |   3 +
 arch/mips/net/bpf_jit_comp32.c                |   3 +
 arch/mips/net/bpf_jit_comp64.c                |   3 +
 arch/parisc/net/bpf_jit_comp32.c              |   3 +
 arch/parisc/net/bpf_jit_comp64.c              |   3 +
 arch/powerpc/net/bpf_jit_comp32.c             |   3 +
 arch/powerpc/net/bpf_jit_comp64.c             |   3 +
 arch/riscv/net/bpf_jit.h                      |   5 +
 arch/riscv/net/bpf_jit_comp32.c               |   3 +
 arch/riscv/net/bpf_jit_comp64.c               |  18 +-
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
 31 files changed, 641 insertions(+), 18 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_hmul.c

-- 
2.55.0

