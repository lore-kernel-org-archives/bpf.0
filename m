Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=207.54.77.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794317127;
	b=yEX+a47jY90gYe/bwh4k/IglMr+g7cwG1N5obQ/wLZxfqCNMfha5gtnLB2ne9DKmqZjH
	 vMrE6qM4OkeXBLKNJYwQ/5lukJXAGME23ozMUU0YIVGHT6YEIOztIj7B/Ei0+AL+EzFMc
	 8E6VhFVcn0KjIbPTbtUXLnbaHyzFSuDKX3PzXmaQg5GcVZ25Tmosi11PQjeX8r90aH7YS
	 v15HNlinw9vt3qEvC+QmXNCxaOBYWjcN65tKIgI94KdgbOZHtGjhV+0L6vnUU2mSK//fr
	 U82e2NHlHDlm4BWGigbRxKP+NfGxeILGpB9q7pmd7pj8Njx/ZCcDT+UX621J8iGU+pg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794317127;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-Amp-Result:X-Amp-File-Uploaded:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer;
	bh=4FMAuWBrqgwOPsdp0mVXAaEVFwnsyImbjiqIUcEpunM=;
	b=v7iEN5CKVykuF+NyAzVfwb1AeXXCEJRGoaQvqLZGKsYTZBwva+vuumeGcs36S3FnLSiq
	 vcvJ5V9+9Vcsn4RR368nPj5Pjqx0Dp3GO5wklNPqa0j+shdmm2Hb+dkr+S2EmtHynxOhU
	 kGE8ucg5yCx+t678iBD+Z7qVzfhNxJXgUgQXzH7uNjOjvcDtUagRVQngmKMX4qK1ee8Ra
	 kejbq+23AVFcA2OUMiP/PxOqnj9iEt02MKejyEhKVKo1WyrgtPQlBd6pMj4pEUYj6kf8n
	 XR0B7noEVjG1LtjKJM6aEDdr08LQFwKFp5suK+jQvsRR/q8Sgpa7+MDg9pTxICHi55g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mobileye.com;
	spf=pass smtp.mailfrom=mobileye.com;
	arc=none smtp.remote-ip=207.54.77.50
Received: from esa3.hc555-34.eu.iphmx.com (esa3.hc555-34.eu.iphmx.com [207.54.77.50])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64714606A338;
	Tue, 10 Nov 2026 13:25:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 64714606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mobileye.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mobileye.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=mobileye.com; i=@mobileye.com; q=dns/txt; s=MoEyIP;
  t=1794317123; x=1825853123;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=L3zGOwCrEzfPFM2n3MQKHzeJZx/dRxHQYbMLSMc6Ouk=;
  b=V0kg3afN2I43JgGGnbgXPmx98gM2lWebTEQyGkdTCdM0QkNAhF1hL39h
   4gjcgdy2+FSO0bD+uCFqjmSjUV9+glbW4EBGvxMSbCRwHNcXMfucai5Ru
   Yh8fsQ62H/I779tSZDp7P+mewAIWs08S55k0X0u7pmCa4ni5FuCS2lBqE
   xql+vaVoG4LSKnasGjm+EYt1K8YwZ66eDRqb/ghUTdTGYj0uJ34uXsbI8
   E/bpeSfgg2fT1Gm8YgiFjoptBO20OZyOnRoaYrmpiUJgK/VIQ2Zqhpl0S
   olSBFp9fTonV5dG5jFDrMH/BfOUj7CekmPnI5j12OSjTjwjjZcMX1sk0W
   A==;
X-CSE-ConnectionGUID: 1X3Eq3HWSwW2H+8428Svhg==
X-CSE-MsgGUID: ButTyVF4Tb+dKrATDMjbIw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from unknown (HELO ces02_data.me-corp.lan) ([146.255.191.134])
  by esa3.hc555-34.eu.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2026 15:22:53 +0200
X-CSE-ConnectionGUID: 3rGpzVSPRgian0EVCvcgFA==
X-CSE-MsgGUID: vRks8qPuQauHDpNDFZpK5Q==
Received: from unknown (HELO epgd071.me-corp.lan) ([10.154.54.2])
  by ces02_data.me-corp.lan with SMTP; 10 Nov 2026 15:30:57 +0200
Received: by epgd071.me-corp.lan (sSMTP sendmail emulation); Tue, 10 Nov 2026 15:22:51 +0200
From: Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>
Date: Tue, 10 Nov 2026 15:20:58 +0200
Subject: [PATCH v6 1/6] riscv: probes: reject probes inside an LR/SC
 sequence
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
Content-Transfer-Encoding: 7bit
Message-Id: <20261110-lrsc-only-v6-1-bafc3cc0fcae@mobileye.com>
References: <20261110-lrsc-only-v6-0-bafc3cc0fcae@mobileye.com>
In-Reply-To: <20261110-lrsc-only-v6-0-bafc3cc0fcae@mobileye.com>
To: Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
 Will Deacon <will@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
 Mark Rutland <mark.rutland@arm.com>, Gary Guo <gary@garyguo.net>, 
 Yury Norov <yury.norov@gmail.com>, 
 Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
 Chao-ying Fu <chao-ying.fu@globalfoundries.com>, 
 Conor Dooley <conor.dooley@microchip.com>, torvalds@linux-foundation.org, 
 olof@lixom.net, aleksa.paunovic@htecgroup.com, arikalo@gmail.com, 
 Boqun Feng <boqun@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 Emil Tsalapatis <emil@etsalapatis.com>, 
 Ihor Solodrai <ihor.solodrai@linux.dev>, 
 Luke Nelson <luke.r.nels@gmail.com>, Xi Wang <xi.wang@gmail.com>, 
 =?utf-8?q?Bj=C3=B6rn_T=C3=B6pel?= <bjorn@kernel.org>, 
 Pu Lehui <pulehui@huawei.com>, Puranjay Mohan <puranjay@kernel.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, Oleg Nesterov <oleg@redhat.com>, 
 Miguel Ojeda <ojeda@kernel.org>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Tamir Duberstein <tamird@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>, 
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>, Boqun Feng <boqun@kernel.org>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Vladimir.Kondratiev@mobileye.com, bpf@vger.kernel.org, 
 linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 Jonathan Corbet <corbet@lwn.net>, 
 Charlie Jenkins <thecharlesjenkins@gmail.com>, 
 Nam Cao <namcao@linutronix.de>, rust-for-linux@vger.kernel.org, 
 Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>
X-Mailer: b4 0.16.0

A kprobe or uprobe replaces an instruction with a breakpoint. The trap
clears the hart's reservation, so if the breakpoint sits on the lr, on
the sc, or on any instruction between them, the sc fails, the loop
branches back to the lr and the probe fires again. The sequence never
completes.

This has always been possible on RISC-V, because cmpxchg and the
conditional atomics are LR/SC loops. Once Zaamo is disabled every
kernel atomic is such a loop, and so is every atomic in userspace built
for the same hart, so the chance of a probe landing in one grows
accordingly. arm64 has the same problem and rejects probes inside an
exclusive-load/store-exclusive region.

Teach the shared instruction decoder to reject lr and sc themselves.
This covers both kprobes and uprobes.

For the instructions between them, use the rules for a constrained
LR/SC sequence: at most 16 instructions between lr and sc, all base
integer instructions other than loads, stores, JALR, FENCE, SYSTEM and
backward jumps or branches, or their compressed forms. Scan forward
from the probed instruction. Reaching an sc through permitted
instructions only means the probe sits inside a sequence; any other
instruction, an lr, the end of the window or the end of the readable
text means it does not. Only a sequence that follows these rules is
guaranteed to make progress, so a probe inside any other one is
already on unsupported ground. Scanning forward rather than tracking
state from the start of the function also keeps an lr that has no sc,
such as the one in __cmpwait() before wrs.nto, from affecting probes
later in the same function.

kprobes scan the kernel text up to the end of the enclosing symbol.
uprobes have only the probed instruction copied, so they read the
text that follows it from the task, which the caller's mmap_lock
allows.

This is independent of the rest of the series. cmpxchg is already an
LR/SC loop today, so the problem exists on every kernel; it only
becomes easier to hit once every atomic is such a loop.

Signed-off-by: Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>
---
 arch/riscv/include/asm/insn.h          | 28 ++++++++++
 arch/riscv/kernel/probes/decode-insn.c | 94 ++++++++++++++++++++++++++++++++++
 arch/riscv/kernel/probes/decode-insn.h |  7 +++
 arch/riscv/kernel/probes/kprobes.c     | 15 ++++--
 arch/riscv/kernel/probes/uprobes.c     | 31 +++++++++++
 5 files changed, 172 insertions(+), 3 deletions(-)

diff --git a/arch/riscv/include/asm/insn.h b/arch/riscv/include/asm/insn.h
index c3005573e8c9..f5de81753bec 100644
--- a/arch/riscv/include/asm/insn.h
+++ b/arch/riscv/include/asm/insn.h
@@ -10,11 +10,16 @@
 
 #define RV_INSN_FUNCT3_MASK	GENMASK(14, 12)
 #define RV_INSN_FUNCT3_OPOFF	12
+#define RV_INSN_FUNCT5_MASK	GENMASK(31, 27)
+#define RV_INSN_FUNCT5_OPOFF	27
+#define RV_INSN_FUNCT7_MASK	GENMASK(31, 25)
+#define RV_INSN_FUNCT7_OPOFF	25
 #define RV_INSN_OPCODE_MASK	GENMASK(6, 0)
 #define RV_INSN_OPCODE_OPOFF	0
 #define RV_INSN_FUNCT12_OPOFF	20
 
 #define RV_ENCODE_FUNCT3(f_)	(RVG_FUNCT3_##f_ << RV_INSN_FUNCT3_OPOFF)
+#define RV_ENCODE_FUNCT5(f_)	(RVG_FUNCT5_##f_ << RV_INSN_FUNCT5_OPOFF)
 #define RV_ENCODE_FUNCT12(f_)	(RVG_FUNCT12_##f_ << RV_INSN_FUNCT12_OPOFF)
 
 /* The bit field of immediate value in I-type instruction */
@@ -136,7 +141,13 @@
 
 /* parts of opcode for RVG*/
 #define RVG_OPCODE_FENCE	0x0f
+#define RVG_OPCODE_OP_IMM	0x13
 #define RVG_OPCODE_AUIPC	0x17
+#define RVG_OPCODE_OP_IMM_32	0x1b
+#define RVG_OPCODE_AMO		0x2f
+#define RVG_OPCODE_OP		0x33
+#define RVG_OPCODE_LUI		0x37
+#define RVG_OPCODE_OP_32	0x3b
 #define RVG_OPCODE_BRANCH	0x63
 #define RVG_OPCODE_JALR		0x67
 #define RVG_OPCODE_JAL		0x6f
@@ -188,6 +199,17 @@
 #define RVG_FUNCT12_EBREAK	0x1
 #define RVG_FUNCT12_SRET	0x102
 
+/* parts of funct5 code for A extension */
+#define RVG_FUNCT5_LR		0x02
+#define RVG_FUNCT5_SC		0x03
+
+/*
+ * The AMO funct3 field holds the access width: 010 for .w, 011 for .d.
+ * Matching bits 14:13 alone accepts both and nothing else.
+ */
+#define RVG_AMO_WIDTH_MASK	GENMASK(14, 13)
+#define RVG_AMO_WIDTH_WD	BIT(13)
+
 #define RVG_MATCH_AUIPC		(RVG_OPCODE_AUIPC)
 #define RVG_MATCH_JALR		(RV_ENCODE_FUNCT3(JALR) | RVG_OPCODE_JALR)
 #define RVG_MATCH_JAL		(RVG_OPCODE_JAL)
@@ -200,6 +222,8 @@
 #define RVG_MATCH_BGEU		(RV_ENCODE_FUNCT3(BGEU) | RVG_OPCODE_BRANCH)
 #define RVG_MATCH_EBREAK	(RV_ENCODE_FUNCT12(EBREAK) | RVG_OPCODE_SYSTEM)
 #define RVG_MATCH_SRET		(RV_ENCODE_FUNCT12(SRET) | RVG_OPCODE_SYSTEM)
+#define RVG_MATCH_LR		(RV_ENCODE_FUNCT5(LR) | RVG_AMO_WIDTH_WD | RVG_OPCODE_AMO)
+#define RVG_MATCH_SC		(RV_ENCODE_FUNCT5(SC) | RVG_AMO_WIDTH_WD | RVG_OPCODE_AMO)
 #define RVC_MATCH_C_BEQZ	(RVC_ENCODE_FUNCT3(C_BEQZ) | RVC_OPCODE_C1)
 #define RVC_MATCH_C_BNEZ	(RVC_ENCODE_FUNCT3(C_BNEZ) | RVC_OPCODE_C1)
 #define RVC_MATCH_C_J		(RVC_ENCODE_FUNCT3(C_J) | RVC_OPCODE_C1)
@@ -227,6 +251,8 @@
 #define RVC_MASK_C_EBREAK	0xffff
 #define RVG_MASK_EBREAK		0xffffffff
 #define RVG_MASK_SRET		0xffffffff
+#define RVG_MASK_LR		(RV_INSN_FUNCT5_MASK | RVG_AMO_WIDTH_MASK | RV_INSN_OPCODE_MASK)
+#define RVG_MASK_SC		(RV_INSN_FUNCT5_MASK | RVG_AMO_WIDTH_MASK | RV_INSN_OPCODE_MASK)
 
 #define __INSN_LENGTH_MASK	_UL(0x3)
 #define __INSN_LENGTH_GE_32	_UL(0x3)
@@ -262,6 +288,8 @@ __RISCV_INSN_FUNCS(c_ebreak, RVC_MASK_C_EBREAK, RVC_MATCH_C_EBREAK)
 __RISCV_INSN_FUNCS(ebreak, RVG_MASK_EBREAK, RVG_MATCH_EBREAK)
 __RISCV_INSN_FUNCS(sret, RVG_MASK_SRET, RVG_MATCH_SRET)
 __RISCV_INSN_FUNCS(fence, RVG_MASK_FENCE, RVG_MATCH_FENCE);
+__RISCV_INSN_FUNCS(lr, RVG_MASK_LR, RVG_MATCH_LR)
+__RISCV_INSN_FUNCS(sc, RVG_MASK_SC, RVG_MATCH_SC)
 
 /* special case to catch _any_ system instruction */
 static __always_inline bool riscv_insn_is_system(u32 code)
diff --git a/arch/riscv/kernel/probes/decode-insn.c b/arch/riscv/kernel/probes/decode-insn.c
index 433d9035b888..6a4f55b07d04 100644
--- a/arch/riscv/kernel/probes/decode-insn.c
+++ b/arch/riscv/kernel/probes/decode-insn.c
@@ -4,11 +4,99 @@
 #include <linux/kprobes.h>
 #include <linux/module.h>
 #include <linux/kallsyms.h>
+#include <linux/bug.h>
 #include <asm/sections.h>
 
 #include "decode-insn.h"
 #include "simulate-insn.h"
 
+/*
+ * Can insn sit between the lr and the sc of a constrained LR/SC sequence?
+ * The ISA allows base integer instructions there, except loads, stores,
+ * JALR, FENCE, SYSTEM, backward jumps and taken backward branches, plus
+ * their compressed forms. Backward branches are treated as not allowed:
+ * the retry branch follows the sc, so one inside the body is not a
+ * constrained sequence.
+ */
+static bool __kprobes riscv_insn_is_lrsc_body(u32 insn)
+{
+	u32 funct3;
+
+	if (GET_INSN_LENGTH(insn) == 2) {
+		switch (insn & RVC_INSN_OPCODE_MASK) {
+		case RVC_OPCODE_C0:
+			/* c.addi4spn; the rest of the quadrant is loads and stores */
+			return (insn & RVC_INSN_FUNCT3_MASK) == 0;
+		case RVC_OPCODE_C1:
+			/* Arithmetic, c.j, c.jal and branches, bit 12 is the offset sign */
+			if (riscv_insn_is_c_j(insn) || riscv_insn_is_c_jal(insn) ||
+			    riscv_insn_is_c_beqz(insn) || riscv_insn_is_c_bnez(insn))
+				return !(insn & BIT(12));
+			return true;
+		case RVC_OPCODE_C2:
+			funct3 = (insn & RVC_INSN_FUNCT3_MASK) >> RVC_INSN_FUNCT3_OPOFF;
+			if (funct3 == 0)	/* c.slli */
+				return true;
+			if (funct3 == 4)	/* c.mv, c.add, but not c.jr, c.jalr, c.ebreak */
+				return !riscv_insn_is_c_jr(insn) &&
+				       !riscv_insn_is_c_jalr(insn) &&
+				       !riscv_insn_is_c_ebreak(insn);
+			return false;	/* stack loads and stores */
+		}
+		return false;
+	}
+
+	switch (insn & RV_INSN_OPCODE_MASK) {
+	case RVG_OPCODE_OP_IMM:
+	case RVG_OPCODE_OP_IMM_32:
+	case RVG_OPCODE_LUI:
+	case RVG_OPCODE_AUIPC:
+		return true;
+	case RVG_OPCODE_OP:
+	case RVG_OPCODE_OP_32:
+		/* funct7 0 or 0x20 is base I; anything else is M, B or another extension */
+		return !((insn & RV_INSN_FUNCT7_MASK) & ~(0x20U << RV_INSN_FUNCT7_OPOFF));
+	case RVG_OPCODE_BRANCH:
+	case RVG_OPCODE_JAL:
+		/* forward only, bit 31 is the offset sign */
+		return !(insn & BIT(31));
+	}
+	return false;
+}
+
+/*
+ * Does the instruction at the start of buf lie inside a constrained LR/SC
+ * sequence? Such a sequence holds at most RISCV_LRSC_MAX_BODY instructions
+ * between the lr and the sc, all from the set above. Walk forward from the
+ * probed instruction: reaching an sc through permitted instructions only
+ * means the probe sits in the body; anything else, including an lr that
+ * opens a new sequence, means it does not. The walk stops at the end of
+ * buf, so a short buffer only makes the answer more permissive.
+ */
+bool __kprobes riscv_probe_in_lrsc_body(const u16 *buf, size_t len)
+{
+	size_t off = 0;
+	u32 insn;
+	int n;
+
+	for (n = 0; n <= RISCV_LRSC_MAX_BODY; n++) {
+		if (off + 2 > len)
+			return false;
+		insn = buf[off / 2];
+		if (GET_INSN_LENGTH(insn) == 4) {
+			if (off + 4 > len)
+				return false;
+			insn |= (u32)buf[off / 2 + 1] << 16;
+		}
+		if (riscv_insn_is_sc(insn))
+			return true;
+		if (!riscv_insn_is_lrsc_body(insn))
+			return false;
+		off += GET_INSN_LENGTH(insn);
+	}
+	return false;
+}
+
 /* Return:
  *   INSN_REJECTED     If instruction is one not allowed to kprobe,
  *   INSN_GOOD_NO_SLOT If instruction is supported but doesn't use its slot.
@@ -23,6 +111,12 @@ riscv_probe_decode_insn(probe_opcode_t *addr, struct arch_probe_insn *api)
 	 */
 	RISCV_INSN_REJECTED(system,		insn);
 	RISCV_INSN_REJECTED(fence,		insn);
+	/*
+	 * The breakpoint trap drops the reservation, so a probe on either
+	 * end of an LR/SC sequence makes the SC fail on every retry.
+	 */
+	RISCV_INSN_REJECTED(lr,			insn);
+	RISCV_INSN_REJECTED(sc,			insn);
 
 	/*
 	 * Simulate instructions list:
diff --git a/arch/riscv/kernel/probes/decode-insn.h b/arch/riscv/kernel/probes/decode-insn.h
index 42269a7d676d..aa1b0d363545 100644
--- a/arch/riscv/kernel/probes/decode-insn.h
+++ b/arch/riscv/kernel/probes/decode-insn.h
@@ -15,4 +15,11 @@ enum probe_insn {
 enum probe_insn __kprobes
 riscv_probe_decode_insn(probe_opcode_t *addr, struct arch_probe_insn *asi);
 
+/* A constrained LR/SC sequence has at most this many instructions between lr and sc */
+#define RISCV_LRSC_MAX_BODY	16
+/* Bytes from the probed instruction through the farthest possible sc */
+#define RISCV_LRSC_SCAN_BYTES	((RISCV_LRSC_MAX_BODY + 1) * 4)
+
+bool __kprobes riscv_probe_in_lrsc_body(const u16 *buf, size_t len);
+
 #endif /* _RISCV_KERNEL_KPROBES_DECODE_INSN_H */
diff --git a/arch/riscv/kernel/probes/kprobes.c b/arch/riscv/kernel/probes/kprobes.c
index 9e2afabf94e8..1ade363910c9 100644
--- a/arch/riscv/kernel/probes/kprobes.c
+++ b/arch/riscv/kernel/probes/kprobes.c
@@ -49,19 +49,28 @@ static void __kprobes arch_simulate_insn(struct kprobe *p, struct pt_regs *regs)
 	post_kprobe_handler(p, kcb, regs);
 }
 
+/*
+ * Walk the instructions from the enclosing symbol up to addr to check that
+ * addr is an instruction boundary. Then reject a probe inside an LR/SC
+ * sequence: the breakpoint trap drops the reservation, so the SC would fail
+ * and the loop would hit the probe again on every retry. The sequence is
+ * recognised by a forward scan with the constrained-sequence rules, as for
+ * uprobes, so an lr that is not followed by an sc (as in __cmpwait()) does
+ * not taint the rest of the function.
+ */
 static bool __kprobes arch_check_kprobe(unsigned long addr)
 {
-	unsigned long tmp, offset;
+	unsigned long tmp, size, offset;
 
 	/* start iterating at the closest preceding symbol */
-	if (!kallsyms_lookup_size_offset(addr, NULL, &offset))
+	if (!kallsyms_lookup_size_offset(addr, &size, &offset))
 		return false;
 
 	tmp = addr - offset;
 
 	while (tmp <= addr) {
 		if (tmp == addr)
-			return true;
+			return !riscv_probe_in_lrsc_body((u16 *)addr, size - offset);
 
 		tmp += GET_INSN_LENGTH(*(u16 *)tmp);
 	}
diff --git a/arch/riscv/kernel/probes/uprobes.c b/arch/riscv/kernel/probes/uprobes.c
index eb177d0ce8ab..d97a10262166 100644
--- a/arch/riscv/kernel/probes/uprobes.c
+++ b/arch/riscv/kernel/probes/uprobes.c
@@ -28,6 +28,34 @@ unsigned long uprobe_get_swbp_addr(struct pt_regs *regs)
 	return instruction_pointer(regs);
 }
 
+/*
+ * Is the instruction at addr inside a constrained LR/SC sequence? Only the
+ * probed instruction was copied, so read the text that follows it from the
+ * task. The caller holds mmap_lock, as uprobe_write_opcode() requires too.
+ * Text that cannot be read ends the scan early, which accepts the probe.
+ */
+static bool uprobe_in_lrsc_body(struct mm_struct *mm, unsigned long addr)
+{
+	u16 buf[RISCV_LRSC_SCAN_BYTES / sizeof(u16)];
+	struct vm_area_struct *vma;
+	struct page *page;
+	size_t got = 0;
+	int len;
+
+	while (got < sizeof(buf)) {
+		len = min_t(size_t, sizeof(buf) - got,
+			    PAGE_SIZE - offset_in_page(addr + got));
+		page = get_user_page_vma_remote(mm, addr + got, FOLL_FORCE, &vma);
+		if (IS_ERR(page))
+			break;
+		uprobe_copy_from_page(page, addr + got, (void *)buf + got, len);
+		put_page(page);
+		got += len;
+	}
+
+	return riscv_probe_in_lrsc_body(buf, got);
+}
+
 int arch_uprobe_analyze_insn(struct arch_uprobe *auprobe, struct mm_struct *mm,
 			     unsigned long addr)
 {
@@ -53,6 +81,9 @@ int arch_uprobe_analyze_insn(struct arch_uprobe *auprobe, struct mm_struct *mm,
 		return -EINVAL;
 	}
 
+	if (uprobe_in_lrsc_body(mm, addr))
+		return -EINVAL;
+
 	return 0;
 }
 

-- 
2.43.0

