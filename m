Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=206.189.79.184
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792561288;
	b=OSx9FKbTdRBSxpwurCXW4+JjYrJtNnL+PCHJOwUew6P566Om3kB3WwnsYAtGo5AS4bDv
	 NXo8xhtGI+GrnH6V/xPeBmKROhsyfcpkVuFlqy+DUujBERDZTeQF1n6sqo8N+qnqUCGLw
	 E7d4+Bo9zldHX3ZmaisUSJzQvYPLUHPi0/DIIaAXlpoCynWG5mwnId5e2KMa2D/14ySdd
	 PSQyH1VsnxZHpFNJa77of8fXeL1mZ/QF9t154rJOQ9dSyFiRForLVmTMJoTtbWn7M9GoY
	 +JydeaupeR5aTR+smCDX92KQ3j0glD1+1vra6WcK+5LTa5cABC0GLc4YzS3fqd68ZRw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792561288;
	h=DMARC-Filter:Received:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-CM-TRANSID:X-CM-SenderInfo:
	 X-CM-DELIVERINFO:X-Coremail-Antispam;
	bh=7tGr2G9dPpN3/hJ8Ir8T7P1L4B1B/fvMVriZ1W2nXF8=;
	b=liinfdh8oX7AvQdchuskq/VeQ+c8IzIJQSHP+o5a9Q+uvb5V8i6JBd+TqPGTy+nIkAPS
	 3f0tWkZCKNjLIsBEGnBZv2X4SB0EH+5yXMYKBbRcuk/TFhsVAIZ+Y/h7FinG+4Xq9SVQk
	 Vzpn+RMIWidHfv5ZKYxfqK3YSJB8TmDqdSgPvf8jncf1+hgz/giFZVyphl98WEKofFTeO
	 WOwXyeSFLLnR3RW2+CQWWc8yKKbdpiT5GDbVTK5eajTZtHepyKX9PRlUXZmmkI4quj4u7
	 9HuKbirvjV0VQlS3ZuCY8I83mDi4i3iLWyEH/U5/ghS06BhVrxjkjypvq6V+UY/54rA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=zju.edu.cn;
	spf=pass smtp.mailfrom=zju.edu.cn;
	arc=none smtp.remote-ip=206.189.79.184
Received: from zg8tmja2lje4os43os4xodqa.icoremail.net (zg8tmja2lje4os43os4xodqa.icoremail.net [206.189.79.184])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C827D606A319;
	Wed, 21 Oct 2026 05:41:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C827D606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from zju.edu.cn (unknown [10.162.163.215])
	by mtasvr (Coremail) with SMTP id _____wC3UOReUNhqAXmsAQ--.16635S3;
	Wed, 21 Oct 2026 13:40:46 +0800 (CST)
Received: from lutetium.localdomain (unknown [10.162.163.215])
	by mail-app4 (Coremail) with UTF8SMTPA id zi_KCgBXJ5xeUNhqcCJmAA--.33421S2;
	Wed, 21 Oct 2026 13:40:46 +0800 (CST)
From: tangyazhou@zju.edu.cn
Subject: [PATCH bpf-next v2 0/8] bpf: Add UHMUL and SHMUL instructions
Date: Wed, 21 Oct 2026 13:40:34 +0800
Message-Id: <20261021-bpf-hmul-v2-0-88e260099f7d@outlook.com>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWOyQ6CMBRFf4W8tSV9FQFd+R+GBcPDlmghHQhD+
 HdbXN7cc4cdLBlFFh7JDoZmZdWogxCXBFpZ6zcx1QUNgoscuUDWTD2TX/9hGe+oyQW/3rISAj4
 Z6tVyVr0gUpoWB9Xfsb4ZqHWxKbJSWTea9Vyd8UzEAX7HgmdYoEixzHkhBEPmwou13uTon9vgU
 +p82mqojuP4AetZVp29AAAA
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
 linux-arm-kernel@lists.infradead.org, linux-riscv@lists.infradead.org, 
 Shahab Vahedi <list+bpf@vahedi.org>, Russell King <linux@armlinux.org.uk>, 
 Tiezhu Yang <yangtiezhu@loongson.cn>, Hengqi Chen <hengqi.chen@gmail.com>, 
 Johan Almbladh <johan.almbladh@anyfinetworks.com>, 
 Paul Burton <paulburton@kernel.org>, 
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, 
 Helge Deller <deller@gmx.de>, Hari Bathini <hbathini@linux.ibm.com>, 
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
 Naveen N Rao <naveen@kernel.org>, Luke Nelson <luke.r.nels@gmail.com>, 
 Xi Wang <xi.wang@gmail.com>, Ilya Leoshkevich <iii@linux.ibm.com>, 
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
 "David S. Miller" <davem@davemloft.net>, Wang YanQing <udknight@gmail.com>, 
 Jakub Kicinski <kuba@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 linux-doc@vger.kernel.org, Tianci Cao <ziye@zju.edu.cn>, 
 Yazhou Tang <tangyazhou518@outlook.com>, 
 Shenghao Yuan <shenghaoyuan0928@163.com>, 
 Alexei Starovoitov <ast@kernel.org>
X-Mailer: b4 0.15.2
X-CM-TRANSID:zi_KCgBXJ5xeUNhqcCJmAA--.33421S2
X-CM-SenderInfo: qssvjiasrsq6lmxovvfxof0/1tbiBgALCmrXxB0b0QAAsp
X-CM-DELIVERINFO: =?B?PkyhEgXKKxbFmtjJiESix3B1w3vD7IpoGYuur0o+r46DyAi5OfOO+T4vrW4FyUBIyu
	9q9Nte+2zWzrdkvaZkVwVQI+GRiybpQic3i2BEeUHGie+C93CiqEVoxiU6Y2X07Xr/HRvj
	en1rIj0bnrIH+DqfznhIXCWny1l/Jp05GaoLbDgTu32AZZBC8J+1WBlzaiJF2g==
X-Coremail-Antispam: 1Uk129KBj93XoW3AF1ktFyrJFykCFy5AFW3CFX_yoWxJrWDpF
	4DGr9xGFZ2gFy0vws7Za9ruFy5Xa1rCr43GrykJ3yUJas0qrykXr4Sgw15Z3s8tF1jg3WF
	vryj9rnY934kZagCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUBKb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AK
	xVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI0UMc
	02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUtVWrXwAv7VC2z280aVAF
	wI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0Y48IcxkI7V
	AKI48G6xCjnVAKz4kxM4IIrI8v6xkF7I0E8cxan2IY04v7M4kE6xkIj40Ew7xC0wCF04k2
	0xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI
	8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Wrv_Gr1UMIIYrxkI7VAKI48J
	MIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJw
	CI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2
	z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8vksDUUUUU==

This patchset adds unsigned and signed high-half multiplication to the BPF
ISA. UHMUL returns the high 64 bits of an unsigned 64-by-64-bit product,
while SHMUL does the same for a signed product.

Both operations are BPF_ALU64 BPF_MUL variants selected by insn->off.
off == 0 remains the existing low-half multiplication, while off == 1
and off == 2 select UHMUL and SHMUL, respectively. The immediate forms
use the usual sign-extended 32-bit BPF immediate.

The patchset adds interpreter, disassembler, verifier, and documentation
support, along with JIT support for x86-64, arm64 and riscv64. Unsupported
JIT and hardware offload backends reject the variants to avoid compiling
them as ordinary multiplication. For now, the verifier computes exact
results for constant operands and otherwise conservatively marks the
destination unknown.

Patch 8/8 uses raw bytecode for UHMUL and SHMUL because LLVM support has
not been merged yet. Once it is available, the raw encodings can be
replaced with the uh*= and sh*= mnemonics. The corresponding LLVM patch
is available for review at:

  https://github.com/llvm/llvm-project/pull/234076

The instruction design is inspired by the UHMUL and SHMUL operations in
sBPF (Solana's BPF variant). Patch 1/8 describes the encoding and
immediate-semantics differences.

Apologies for the delay in sending v2. I was tied up with other commitments
over the past month.

---
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
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-riscv@lists.infradead.org
Cc: Shahab Vahedi <list+bpf@vahedi.org>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Tiezhu Yang <yangtiezhu@loongson.cn>
Cc: Hengqi Chen <hengqi.chen@gmail.com>
Cc: Johan Almbladh <johan.almbladh@anyfinetworks.com>
Cc: Paul Burton <paulburton@kernel.org>
Cc: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
Cc: Helge Deller <deller@gmx.de>
Cc: Hari Bathini <hbathini@linux.ibm.com>
Cc: Christophe Leroy (CS GROUP) <chleroy@kernel.org>
Cc: Naveen N Rao <naveen@kernel.org>
Cc: Luke Nelson <luke.r.nels@gmail.com>
Cc: Xi Wang <xi.wang@gmail.com>
Cc: Ilya Leoshkevich <iii@linux.ibm.com>
Cc: Heiko Carstens <hca@linux.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Cc: David S. Miller <davem@davemloft.net>
Cc: Wang YanQing <udknight@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org

---
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

 .../bpf/standardization/instruction-set.rst        |  37 +++-
 arch/arc/net/bpf_jit_core.c                        |   3 +
 arch/arm/net/bpf_jit_32.c                          |   3 +
 arch/arm64/include/asm/insn.h                      |   4 +
 arch/arm64/lib/insn.c                              |   6 +
 arch/arm64/net/bpf_jit.h                           |   6 +
 arch/arm64/net/bpf_jit_comp.c                      |  15 +-
 arch/loongarch/net/bpf_jit.c                       |   3 +
 arch/mips/net/bpf_jit_comp32.c                     |   3 +
 arch/mips/net/bpf_jit_comp64.c                     |   3 +
 arch/parisc/net/bpf_jit_comp32.c                   |   3 +
 arch/parisc/net/bpf_jit_comp64.c                   |   3 +
 arch/powerpc/net/bpf_jit_comp32.c                  |   3 +
 arch/powerpc/net/bpf_jit_comp64.c                  |   3 +
 arch/riscv/net/bpf_jit.h                           |   5 +
 arch/riscv/net/bpf_jit_comp32.c                    |   3 +
 arch/riscv/net/bpf_jit_comp64.c                    |  18 +-
 arch/s390/net/bpf_jit_comp.c                       |   3 +
 arch/sparc/net/bpf_jit_comp_64.c                   |   3 +
 arch/x86/net/bpf_jit_comp.c                        |  48 +++++
 arch/x86/net/bpf_jit_comp32.c                      |   3 +
 drivers/net/ethernet/netronome/nfp/bpf/verifier.c  |   6 +
 include/linux/filter.h                             |  38 ++++
 include/uapi/linux/bpf.h                           |   6 +
 kernel/bpf/core.c                                  |  41 +++-
 kernel/bpf/disasm.c                                |  18 ++
 kernel/bpf/verifier.c                              |  68 +++++-
 tools/include/uapi/linux/bpf.h                     |   6 +
 tools/testing/selftests/bpf/prog_tests/verifier.c  |   2 +
 .../selftests/bpf/prog_tests/verifier_hmul_arena.c |  19 ++
 tools/testing/selftests/bpf/progs/verifier_hmul.c  | 235 +++++++++++++++++++++
 .../selftests/bpf/progs/verifier_hmul_arena.c      |  70 ++++++
 .../bpf/progs/verifier_value_illegal_alu.c         |   7 +-
 33 files changed, 671 insertions(+), 23 deletions(-)
---
base-commit: 3a65f38d928a2699ebcec72a2d60bdb8fcde8284
change-id: 20261021-bpf-hmul-40deb6203548

Best regards,
--  
Yazhou Tang <tangyazhou518@outlook.com>

