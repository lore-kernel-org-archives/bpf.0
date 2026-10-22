Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.243.164.118
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792685718;
	b=1kXOKwzgDtSUfGzpLqlwXsAkP4RrQVw3b275AdrGU59NtuUzqLwZ6raJ3yDMYsMASETz
	 AXLtbqyXmVzCVataPhLrWLkZ9uPq2qP4FH3RzqpzzXsT3Zpk2X+bCXVohMRJKwEwE2wzV
	 /eO2duoWSTQBxPVVJgkHwJeSzbG+JUfcpJ3xee5SyhVWd1nKWBlyBUEvwC6KGDNuKVRIm
	 NBHVvJFX4cYoDOGGFtQ9kgo83Hk2pjcsjlePjyBiR2OaxL4pF9gnH+vfuJUxRZQI6Tnvt
	 3ap5TaFDDHib19OelUQf/uU0p6k0HnAS5B0AQucinMRVVvLquQTA5Dg544gkpFwdLBg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792685718;
	h=DMARC-Filter:Received:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-CM-TRANSID:X-CM-SenderInfo:
	 X-CM-DELIVERINFO:X-Coremail-Antispam;
	bh=obDlDbdY2/BWJKzFMODIKLSvK6uu3G1Rbvoh6xXqbCk=;
	b=fEC0ww7G0q8eJn8BTBpMNTyyLUyKXBAWIcn0shOx1sP2GeqfXxdJSjmGToF4Xk86E02x
	 Zf2+uxORyeiJ4/7JtaJn3jHxUJ+ZvleFAUjpN44Xzvtv5DtDu+f8ZhVCi8j0s2immY02z
	 7EVGK6PwBZJjuTE+6VeKB8orZtNU4NuZ8yrb5+/KtOeZDw1kePz67ilwQwcUZ7lAb+D1K
	 i/7Ka69IU6PqsbUYcRwtMoVXvegels2bTx4sJ615jm2oBufpG5Ly1iS38vuZcKKZPKHbR
	 9PTbM2sDFysPSE4zmg1g6d9J7FIhW1LHG4Qu66z9QV6PQ3WMntIfhucPFzYPQDbHQAw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=zju.edu.cn;
	spf=pass smtp.mailfrom=zju.edu.cn;
	arc=none smtp.remote-ip=162.243.164.118
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E3A8606A322;
	Thu, 22 Oct 2026 16:15:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4E3A8606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from zju.edu.cn (unknown [10.192.73.73])
	by mtasvr (Coremail) with SMTP id _____wB3JOZ+NtpqSki0AQ--.13536S3;
	Fri, 23 Oct 2026 00:14:55 +0800 (CST)
Received: from [127.0.0.1] (unknown [10.192.73.73])
	by mail-app2 (Coremail) with UTF8SMTPA id zC_KCgDHHXx8Ntpqp5N8AA--.36932S2;
	Fri, 23 Oct 2026 00:14:52 +0800 (CST)
From: Yazhou Tang <tangyazhou@zju.edu.cn>
Subject: [PATCH bpf-next v3 0/7] bpf: Add UHMUL and SHMUL instructions
Date: Fri, 23 Oct 2026 00:14:36 +0800
Message-Id: <20261023-bpf-hmul-v3-0-b99e808cb28b@outlook.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/1WOzQ6CMBCEX8Xs2ZLtivx44j2MB34WKQoltCUo4
 d0tmJh4nMzMN7OA4VGxgcthgZEnZZTuvTgdD1A2eX9noSqvgZAiiSRFMdSi6dxThFhxERGezmE
 CPj6MXKt5R11hS/U8W7h9HeOKlku7kbZso4zV42tfneTe2AYwlTGGMpYUyCTCmEhIYf2LV/5ut
 MverQu4ckHZ79yJfs3/axMJFEnCnohpWsdVpp19av0ISt3BbV3XD8sIvfj4AAAA
X-Change-ID: 20261021-bpf-hmul-40deb6203548
To: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
 David Vernet <void@manifault.com>, bpf@ietf.org
Cc: John Fastabend <john.fastabend@gmail.com>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 Emil Tsalapatis <emil@etsalapatis.com>, 
 Ihor Solodrai <ihor.solodrai@linux.dev>, Quentin Monnet <qmo@kernel.org>, 
 Puranjay Mohan <puranjay@kernel.org>, Xu Kuohai <xukuohai@huaweicloud.com>, 
 =?utf-8?q?Bj=C3=B6rn_T=C3=B6pel?= <bjorn@kernel.org>, 
 Pu Lehui <pulehui@huawei.com>, Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Luke Nelson <luke.r.nels@gmail.com>, Xi Wang <xi.wang@gmail.com>, 
 Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, 
 Tianci Cao <ziye@zju.edu.cn>, Yazhou Tang <tangyazhou518@outlook.com>, 
 Shenghao Yuan <shenghaoyuan0928@163.com>, 
 Alexei Starovoitov <ast@kernel.org>
X-Mailer: b4 0.15.2
X-CM-TRANSID:zC_KCgDHHXx8Ntpqp5N8AA--.36932S2
X-CM-SenderInfo: qssvjiasrsq6lmxovvfxof0/1tbiAgMMCmrZFZ1PGwAAso
X-CM-DELIVERINFO: =?B?m1C4XwXKKxbFmtjJiESix3B1w3vD7IpoGYuur0o+r46DyAi5OfOO+T4vrW4FyUBIyu
	9q9Oa3CVJL3/JTjWRYkCOtDw9n8WrOW4hsJjfayCOUkuD2xiGrZ8t1LzQ4GYNN2j7ijD2y
	+UYAa8tO1tZGO/9TSUZHlfcxsfLxYWtvTcNJVJbCOW91GDA26I+2YDirVBl7Hw==
X-Coremail-Antispam: 1Uk129KBj93XoWxZw48Aw4UJw1xZFykZFyruFX_yoW7Jw1fpF
	4kGr13GFZ2gFy0kws7ua9ruFy5Xa1Fkr13Crs3J3yUJF1aqr1kXF4S9F1Yvwn8JF12g3WY
	vry29ryv9348ZagCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUU9Kb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWUJVW8JwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I
	8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AK
	xVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7xvr2IYc2Ij64
	vIr40E4x8a64kEw24lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2Ij64vIr41l4I8I
	3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxV
	WUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAF
	wI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcI
	k0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j
	6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU7a0PDUUUU

This patchset adds unsigned and signed high-half multiplication to the BPF
ISA. UHMUL returns the high 64 bits of an unsigned 64-by-64-bit product,
while SHMUL does the same for a signed product.

Both operations are BPF_ALU64 BPF_MUL variants selected by insn->off.
off == 0 remains the existing low-half multiplication, while off == 1
and off == 2 select UHMUL and SHMUL, respectively. The immediate forms
use the usual sign-extended 32-bit BPF immediate.

The patchset adds interpreter, disassembler, verifier, and documentation
support, along with JIT support for x86-64, arm64 and riscv64. JITs opt
in through bpf_jit_supports_hmul(). The verifier rejects HMUL when the
program is offloaded to hardware or JIT compilation is requested but
the JIT does not support HMUL. UHMUL and SHMUL remain available through
the interpreter when JIT compilation is disabled. For now, the verifier
computes exact results for constant operands and otherwise
conservatively marks the destination unknown.

Patch 7/7 uses raw bytecode for UHMUL and SHMUL because LLVM support has
not been merged yet. Once it is available, the raw encodings can be
replaced with the uh*= and sh*= mnemonics. The corresponding LLVM patch
is available for review at:

  https://github.com/llvm/llvm-project/pull/234076

The instruction design is inspired by the UHMUL and SHMUL operations in
sBPF (Solana's BPF variant). Patch 1/7 describes the encoding and
immediate-semantics differences.

---
Changes in v3:
- Make HMUL JIT support opt-in and check it in the verifier, replacing
  the per-backend rejection patch. (Alexei)
- Move bpf_insn_is_hmul() into the x86 JIT patch and simplify it.
- Link to v2: https://patch.msgid.link/20261021-bpf-hmul-v2-0-88e260099f7d@outlook.com

Changes in v2:
- Introduce a new conformance group "divmul64v2" for UHMUL/SHMUL. (bot+bpf-ci)
- Shorten the name of bpf_mul_variant. (Alexei)
- Remove redundant validation for off field in interpreter. (Alexei)
- Split arena test to two separate files.
- Link to v1: https://patch.msgid.link/20260917041712.1860722-1-tangyazhou@zju.edu.cn

Changes in v1:
- Add JIT support on arm64 and riscv64. (Alexei)
- Fix the HMUL check on PowerPC JIT backend. (Sashiko AI reviewer)
- Link to RFC: https://lore.kernel.org/bpf/20260902070534.2141812-1-tangyazhou@zju.edu.cn/

To: bpf@vger.kernel.org
To: Alexei Starovoitov <ast@kernel.org>
To: Daniel Borkmann <daniel@iogearbox.net>
To: Andrii Nakryiko <andrii@kernel.org>
To: Eduard Zingerman <eddyz87@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: David Vernet <void@manifault.com>
To: bpf@ietf.org
Cc: John Fastabend <john.fastabend@gmail.com>
Cc: Martin KaFai Lau <martin.lau@linux.dev>
Cc: Song Liu <song@kernel.org>
Cc: Yonghong Song <yonghong.song@linux.dev>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Emil Tsalapatis <emil@etsalapatis.com>
Cc: Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: Quentin Monnet <qmo@kernel.org>
Cc: Puranjay Mohan <puranjay@kernel.org>
Cc: Xu Kuohai <xukuohai@huaweicloud.com>
Cc: Björn Töpel <bjorn@kernel.org>
Cc: Pu Lehui <pulehui@huawei.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Luke Nelson <luke.r.nels@gmail.com>
Cc: Xi Wang <xi.wang@gmail.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org

---
Tianci Cao (3):
      bpf: Add UHMUL and SHMUL instructions
      bpf, x86: JIT UHMUL and SHMUL on x86-64
      bpf: Add verifier support for UHMUL and SHMUL

Yazhou Tang (4):
      bpf, arm64: JIT UHMUL and SHMUL
      bpf, riscv: JIT UHMUL and SHMUL on RV64
      bpf: Refactor ALU instruction variant validation
      selftests/bpf: Add bytecode tests for UHMUL and SHMUL

 .../bpf/standardization/instruction-set.rst        |  37 +++-
 arch/arm64/include/asm/insn.h                      |   4 +
 arch/arm64/lib/insn.c                              |   6 +
 arch/arm64/net/bpf_jit.h                           |   6 +
 arch/arm64/net/bpf_jit_comp.c                      |  20 +-
 arch/riscv/net/bpf_jit.h                           |   5 +
 arch/riscv/net/bpf_jit_comp64.c                    |  23 +-
 arch/x86/net/bpf_jit_comp.c                        |  53 +++++
 include/linux/filter.h                             |  34 +++
 include/uapi/linux/bpf.h                           |   6 +
 kernel/bpf/core.c                                  |  47 ++++-
 kernel/bpf/disasm.c                                |  18 ++
 kernel/bpf/verifier.c                              |  81 ++++++-
 tools/include/uapi/linux/bpf.h                     |   6 +
 tools/testing/selftests/bpf/prog_tests/verifier.c  |   2 +
 .../selftests/bpf/prog_tests/verifier_hmul_arena.c |  19 ++
 tools/testing/selftests/bpf/progs/verifier_hmul.c  | 235 +++++++++++++++++++++
 .../selftests/bpf/progs/verifier_hmul_arena.c      |  74 +++++++
 .../bpf/progs/verifier_value_illegal_alu.c         |   7 +-
 19 files changed, 660 insertions(+), 23 deletions(-)
---
base-commit: b116ac6087541d3d98031e786adbe9c733cd6df3
change-id: 20261021-bpf-hmul-40deb6203548

Best regards,
--  
Yazhou Tang <tangyazhou518@outlook.com>

