Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=207.54.77.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795019065;
	b=Eykq5ayRj9821gkTKPJ0B0My+fb6Vi/z5z7By4Qw1OQA6D+5Yz33UkvJW9OTztzDwrF8
	 xdfutSQoM8HtsVWXmUPSiHmJ9xuQ7W7s0wNTVulkyDwrK2WStQ1mHZr4uAAhZsW4YzWZh
	 ezhYtRakxZxUexcGPLD1+/Iy2vacJF62SOeBRysj12lfdomMpzguTU1F9VSq2i5U8D51l
	 lnzAMwMANcJbrP8JDZN2soOYzmLsv4MY3EI0obvNl6kEiABxu8wwJoq4p5bPzPNTDdNz5
	 Vmn2Q3mVQuYicsAYdZUBoALdHZGRqk8ZOdcIQ62lduJY9T1xW5gGTbwvfzR05rr7rvA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795019065;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-Amp-Result:X-Amp-File-Uploaded:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer;
	bh=wgBb/spOBECTHzoZVBUWGl/wJOrQV6Mtg/YJhR6+LRA=;
	b=KUYT12GCkMk6tbuvZVliMMlk7gThDMm0nGtQSFCFKbCf2TcAseK7Lni8zDJ/3R5EgRwu
	 q5xB4lta45TcForM8Sim/pKq8tFe0KSvzIasAOs+KIp5iw5MUElQWwfYb1CCyhuK+veKz
	 YZAqIG9Lox0gmF3PsB4qQarZMe+Q4MYUy9mX2zVCTOgfFQKadbphERt65z9wXd4Nu3Huu
	 TKAGM7dxEKARCkEbkYrEhCkPwZ99ZPwPLKnKuMKKTn65Ufl3Yy5W/+EbN2paYI+NC5/pW
	 l5Isc39wLJpFSmo30bLtUtQuCfwhZbBgUOYYcoOfY7ZY+rN1e4wCmDm8Ds5MjurGScA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mobileye.com;
	spf=pass smtp.mailfrom=mobileye.com;
	arc=none smtp.remote-ip=207.54.77.171
Received: from esa4.hc555-34.eu.iphmx.com (esa4.hc555-34.eu.iphmx.com [207.54.77.171])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A35C960A2600;
	Wed, 18 Nov 2026 16:24:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A35C960A2600
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mobileye.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mobileye.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=mobileye.com; i=@mobileye.com; q=dns/txt; s=MoEyIP;
  t=1795019064; x=1826555064;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=fcd49kVJzJ12RU3HuvAHngbViD5m3z6w2VosOrnx+qE=;
  b=T1/CzCe3fMuih/96eGPQg8jwZEFwHjDPMIteZVcH+73+IDw3/0sW7LSW
   VfaH66ylyBWsbkvhbEh9jiCP6utFTyYe4c+bBNtsIY75mhbKhIpyolRWu
   WrP10pLI9Bw7vGypxP0e+ew8je81QPGdRZRbAjnjgi07sOIdZE9aCWHIk
   hQAukR4UyziJvEO1xc2vf+EKZAG4+8ypgZyoegPFmX4M4p3LYNqsURVIJ
   RxT+JYQpZr4k8f1MZMBWQ6jSPlqXR/t4WEBXZq5rL0wnov3HR7gcrpBQI
   Y2016fT7vJjt3sQw1l5/ExRyaeSKbIEUhVG8X63362dSwVnI8zodK1iX1
   A==;
X-CSE-ConnectionGUID: 7hq+D6BLQP2GkvduBaDk8Q==
X-CSE-MsgGUID: EOQjBCLTQzaDAKC/L+g5jg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from unknown (HELO ces03_data.me-corp.lan) ([146.255.191.134])
  by esa4.hc555-34.eu.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2026 18:24:13 +0200
X-CSE-ConnectionGUID: h3wVPQP9R0CsiHQMMj0RIg==
X-CSE-MsgGUID: npZIQfbFQJKv35GuVl/X+Q==
Received: from unknown (HELO epgd071.me-corp.lan) ([10.154.54.2])
  by ces03_data.me-corp.lan with SMTP; 18 Nov 2026 18:32:19 +0200
Received: by epgd071.me-corp.lan (sSMTP sendmail emulation); Wed, 18 Nov 2026 18:24:12 +0200
From: Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>
Date: Wed, 18 Nov 2026 18:24:00 +0200
Subject: [PATCH v7 4/6] riscv, bpf: emit LR/SC loops when Zaamo is disabled
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
Message-Id: <20261118-lrsc-only-v7-4-602dcf4c1921@mobileye.com>
References: <20261118-lrsc-only-v7-0-602dcf4c1921@mobileye.com>
In-Reply-To: <20261118-lrsc-only-v7-0-602dcf4c1921@mobileye.com>
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
 Randy Dunlap <rdunlap@infradead.org>, 
 Andrew Jones <ajones@ventanamicro.com>, Boqun Feng <boqun@kernel.org>
Cc: Jisheng Zhang <jszhang@kernel.org>, linux-riscv@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Vladimir.Kondratiev@mobileye.com, 
 bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, 
 Charlie Jenkins <thecharlesjenkins@gmail.com>, 
 Nam Cao <namcao@linutronix.de>, rust-for-linux@vger.kernel.org, 
 Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>
X-Mailer: b4 0.16.0

A kernel built with CONFIG_RISCV_ISA_ZAAMO disabled is meant for a
hart where AMO instructions are emulated by an M-mode trap. The BPF JIT
still encodes amo* instructions for the BPF atomic read-modify-write
operations, so every such operation takes that trap.

Emit an LR/SC loop for BPF_ADD, BPF_AND, BPF_OR, BPF_XOR, their
BPF_FETCH forms and BPF_XCHG when Zaamo is disabled, on RV32 and RV64.
The sequences follow the Zalrsc variants in
arch/riscv/include/asm/atomic.h and the existing LR/SC loop of
emit_cmpxchg(): a relaxed op discards the old value; a fetch op is
fully ordered with a plain lr, sc.rl and a trailing fence rw,rw, and
returns the old value. BPF_CMPXCHG is unchanged; it already uses
amocas with Zacas and an LR/SC loop otherwise.

The JIT encodes instructions as integers, so no assembler constraint
applies and both paths stay compiled. The choice is a plain
IS_ENABLED() test, the same compile-time decision the rest of the
kernel makes. The hart advertises "a" either way, so a runtime
extension check would not tell the two cases apart.

An arena (BPF_PROBE_ATOMIC) access needs an exception table entry for
each instruction that may fault. The verifier reserves one entry per
atomic instruction, but an LR/SC loop can fault on either the lr or the
sc. Count the extra entries once the instruction offsets converge,
before the image is allocated, and add an entry for the sc that shares
the fixup of the lr, so a fault skips the retry and the result move.

Co-developed-by: Chao-ying Fu <chao-ying.fu@globalfoundries.com>
Signed-off-by: Chao-ying Fu <chao-ying.fu@globalfoundries.com>
Signed-off-by: Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>
---
 arch/riscv/net/bpf_jit.h        |   1 +
 arch/riscv/net/bpf_jit_comp32.c |  84 +++++++++++++++++++++++++++++--
 arch/riscv/net/bpf_jit_comp64.c | 109 +++++++++++++++++++++++++++++++++++++++-
 arch/riscv/net/bpf_jit_core.c   |  29 +++++++++++
 4 files changed, 217 insertions(+), 6 deletions(-)

diff --git a/arch/riscv/net/bpf_jit.h b/arch/riscv/net/bpf_jit.h
index 419b9d795f2a..8c1301289ea8 100644
--- a/arch/riscv/net/bpf_jit.h
+++ b/arch/riscv/net/bpf_jit.h
@@ -79,6 +79,7 @@ struct rv_jit_context {
 	int nexentries;
 	int ex_insn_off;
 	int ex_jmp_off;
+	int ex_sc_off;		/* sc in an lr/sc pair; 0 if unused */
 	unsigned long flags;
 	int stack_size;
 	int tcc_offset;
diff --git a/arch/riscv/net/bpf_jit_comp32.c b/arch/riscv/net/bpf_jit_comp32.c
index a9e0bd5cc81d..0fa0c013549a 100644
--- a/arch/riscv/net/bpf_jit_comp32.c
+++ b/arch/riscv/net/bpf_jit_comp32.c
@@ -874,11 +874,70 @@ static int emit_load_r64(const s8 *dst, const s8 *src, s16 off,
 	return 0;
 }
 
-static int emit_bpf_atomic(s8 dst, const s8 *src, const s8 *rs,
-			   struct rv_jit_context *ctx,
-			   const struct bpf_insn *insn)
+/*
+ * Read-modify-write via lr/sc for kernels built without Zaamo. T0 holds
+ * the address. T1/T2 are not BPF registers; the address was copied out of
+ * lo(rd) before this is called, so clobbering T2 is fine. A fetch op
+ * (including XCHG) is fully ordered as in asm/atomic.h: plain lr, sc.rl
+ * and a trailing fence rw,rw.
+ */
+static int emit_bpf_atomic_lrsc(s8 dst, const s8 *rs, s32 imm,
+				struct rv_jit_context *ctx)
+{
+	bool is_fetch = (imm & BPF_FETCH) || (imm == BPF_XCHG);
+	bool xchg = imm == BPF_XCHG;
+	u8 rl = is_fetch ? 1 : 0;
+	u8 old = RV_REG_T1;
+	u8 tmp = RV_REG_T2;
+	int lr_off, jmp_off;
+	s32 op = xchg ? BPF_XCHG : imm & ~BPF_FETCH;
+
+	switch (op) {
+	case BPF_ADD:
+	case BPF_AND:
+	case BPF_OR:
+	case BPF_XOR:
+	case BPF_XCHG:
+		break;
+	default:
+		return -1;
+	}
+
+	lr_off = ctx->ninsns;
+	emit(rv_lr_w(old, 0, dst, 0, 0), ctx);
+
+	switch (op) {
+	case BPF_ADD:
+		emit(rv_add(tmp, old, lo(rs)), ctx);
+		break;
+	case BPF_AND:
+		emit(rv_and(tmp, old, lo(rs)), ctx);
+		break;
+	case BPF_OR:
+		emit(rv_or(tmp, old, lo(rs)), ctx);
+		break;
+	case BPF_XOR:
+		emit(rv_xor(tmp, old, lo(rs)), ctx);
+		break;
+	}
+
+	if (xchg)
+		emit(rv_sc_w(tmp, lo(rs), dst, 0, rl), ctx);
+	else
+		emit(rv_sc_w(tmp, tmp, dst, 0, rl), ctx);
+
+	jmp_off = ninsns_rvoff(lr_off - ctx->ninsns);
+	emit(rv_bne(tmp, RV_REG_ZERO, jmp_off >> 1), ctx);
+	if (is_fetch) {
+		emit_fence_rw_rw(ctx);
+		emit(rv_addi(lo(rs), old, 0), ctx);
+	}
+	return 0;
+}
+
+static int emit_bpf_atomic_amo(s8 dst, const s8 *rs, s32 imm,
+			       struct rv_jit_context *ctx)
 {
-	s32 imm = insn->imm;
 	bool is_fetch = (imm & BPF_FETCH) || (imm == BPF_XCHG);
 	s8 fetch_reg = is_fetch ? lo(rs) : RV_REG_ZERO;
 	int aq = is_fetch ? 1 : 0;
@@ -907,6 +966,23 @@ static int emit_bpf_atomic(s8 dst, const s8 *src, const s8 *rs,
 	default:
 		return -1;
 	}
+	return 0;
+}
+
+static int emit_bpf_atomic(s8 dst, const s8 *src, const s8 *rs,
+			   struct rv_jit_context *ctx,
+			   const struct bpf_insn *insn)
+{
+	s32 imm = insn->imm;
+	bool is_fetch = (imm & BPF_FETCH) || (imm == BPF_XCHG);
+	int ret;
+
+	if (IS_ENABLED(CONFIG_RISCV_ISA_ZAAMO))
+		ret = emit_bpf_atomic_amo(dst, rs, imm, ctx);
+	else
+		ret = emit_bpf_atomic_lrsc(dst, rs, imm, ctx);
+	if (ret)
+		return ret;
 
 	if (is_fetch) {
 		emit(rv_addi(hi(rs), RV_REG_ZERO, 0), ctx);
diff --git a/arch/riscv/net/bpf_jit_comp64.c b/arch/riscv/net/bpf_jit_comp64.c
index 01fe66774f02..4807b5800f62 100644
--- a/arch/riscv/net/bpf_jit_comp64.c
+++ b/arch/riscv/net/bpf_jit_comp64.c
@@ -573,6 +573,80 @@ static int emit_atomic_ld_st(u8 rd, u8 rs, const struct bpf_insn *insn,
 	return 0;
 }
 
+/*
+ * Read-modify-write via lr/sc for kernels built without Zaamo, matching
+ * the Zalrsc sequences in arch/riscv/include/asm/atomic.h. A relaxed op
+ * discards the old value. A fetch op (including XCHG) is fully ordered
+ * the way emit_cmpxchg() is: plain lr, sc.rl and a trailing fence rw,rw.
+ * It writes the old value back to val. T2/T3 are not BPF registers; addr
+ * may already be T1.
+ */
+static void emit_atomic_lrsc(u8 addr, u8 val, bool is64, s32 imm,
+			     struct rv_jit_context *ctx)
+{
+	bool fetch = imm & BPF_FETCH;
+	u8 rl = fetch ? 1 : 0;
+	u8 old = RV_REG_T2;
+	u8 tmp = RV_REG_T3;
+	int lr_off, jmp_off;
+	s32 op = imm == BPF_XCHG ? BPF_XCHG : imm & ~BPF_FETCH;
+
+	lr_off = ctx->ninsns;
+	ctx->ex_insn_off = ctx->ninsns;
+	emit(is64 ? rv_lr_d(old, 0, addr, 0, 0) :
+	     rv_lr_w(old, 0, addr, 0, 0), ctx);
+
+	if (op != BPF_XCHG) {
+		if (!is64 && op == BPF_ADD)
+			emit(rv_addw(tmp, old, val), ctx);
+		else if (op == BPF_ADD)
+			emit_add(tmp, old, val, ctx);
+		else if (op == BPF_AND)
+			emit_and(tmp, old, val, ctx);
+		else if (op == BPF_OR)
+			emit_or(tmp, old, val, ctx);
+		else if (op == BPF_XOR)
+			emit_xor(tmp, old, val, ctx);
+
+		ctx->ex_sc_off = ctx->ninsns;
+		emit(is64 ? rv_sc_d(tmp, tmp, addr, 0, rl) :
+		     rv_sc_w(tmp, tmp, addr, 0, rl), ctx);
+	} else {
+		ctx->ex_sc_off = ctx->ninsns;
+		emit(is64 ? rv_sc_d(tmp, val, addr, 0, rl) :
+		     rv_sc_w(tmp, val, addr, 0, rl), ctx);
+	}
+
+	/* Branch offset is relative to this instruction, back to the lr. */
+	jmp_off = ninsns_rvoff(lr_off - ctx->ninsns);
+	emit(rv_bne(tmp, RV_REG_ZERO, jmp_off >> 1), ctx);
+
+	if (fetch) {
+		emit_fence_rw_rw(ctx);
+		emit_mv(val, old, ctx);
+		if (!is64)
+			emit_zextw(val, val, ctx);
+	}
+	ctx->ex_jmp_off = ctx->ninsns;
+}
+
+static bool is_atomic_lrsc_op(s32 imm)
+{
+	switch (imm) {
+	case BPF_ADD:
+	case BPF_AND:
+	case BPF_OR:
+	case BPF_XOR:
+	case BPF_ADD | BPF_FETCH:
+	case BPF_AND | BPF_FETCH:
+	case BPF_OR | BPF_FETCH:
+	case BPF_XOR | BPF_FETCH:
+	case BPF_XCHG:
+		return true;
+	}
+	return false;
+}
+
 static int emit_atomic_rmw(u8 rd, u8 rs, const struct bpf_insn *insn,
 			   struct rv_jit_context *ctx)
 {
@@ -601,6 +675,12 @@ static int emit_atomic_rmw(u8 rd, u8 rs, const struct bpf_insn *insn,
 		rd = RV_REG_T1;
 	}
 
+	/* Without Zaamo, every op except cmpxchg is an lr/sc loop. */
+	if (!IS_ENABLED(CONFIG_RISCV_ISA_ZAAMO) && is_atomic_lrsc_op(imm)) {
+		emit_atomic_lrsc(rd, rs, is64, imm, ctx);
+		return 0;
+	}
+
 	switch (imm) {
 	/* lock *(u32/u64 *)(dst_reg + off16) <op>= src_reg */
 	case BPF_ADD:
@@ -732,8 +812,8 @@ bool ex_handler_bpf(const struct exception_table_entry *ex,
 }
 
 /* For accesses to BTF pointers, add an entry to the exception table */
-static int add_exception_handler(const struct bpf_insn *insn, int dst_reg,
-				 struct rv_jit_context *ctx)
+static int add_exception_handler_one(const struct bpf_insn *insn, int dst_reg,
+				     struct rv_jit_context *ctx)
 {
 	struct exception_table_entry *ex;
 	unsigned long pc;
@@ -804,6 +884,31 @@ static int add_exception_handler(const struct bpf_insn *insn, int dst_reg,
 	return 0;
 }
 
+/*
+ * An lr/sc pair faults on either instruction. Both entries share the fixup
+ * that follows the loop, so a probe fault skips the retry and the result move.
+ */
+static int add_exception_handler(const struct bpf_insn *insn, int dst_reg,
+				 struct rv_jit_context *ctx)
+{
+	int sc_off = ctx->ex_sc_off;
+	int jmp_off = ctx->ex_jmp_off;
+	int ret;
+
+	ctx->ex_sc_off = 0;
+	/* Offset discovery runs before the image exists. Entries are added later. */
+	if (!ctx->insns)
+		return 0;
+
+	ret = add_exception_handler_one(insn, dst_reg, ctx);
+	if (ret || sc_off <= 0)
+		return ret;
+
+	ctx->ex_insn_off = sc_off;
+	ctx->ex_jmp_off = jmp_off;
+	return add_exception_handler_one(insn, dst_reg, ctx);
+}
+
 static int gen_jump_or_nops(void *target, void *ip, u32 *insns, bool is_call)
 {
 	s64 rvoff;
diff --git a/arch/riscv/net/bpf_jit_core.c b/arch/riscv/net/bpf_jit_core.c
index cbfcd287ea16..cba0d34c3e6f 100644
--- a/arch/riscv/net/bpf_jit_core.c
+++ b/arch/riscv/net/bpf_jit_core.c
@@ -16,6 +16,34 @@
 /* Number of iterations to try until offsets converge. */
 #define NR_JIT_ITERATIONS	32
 
+/*
+ * The verifier reserves one extable slot per BPF_PROBE_ATOMIC. Without
+ * Zaamo a read-modify-write atomic is an lr/sc loop that can fault on
+ * either instruction, so reserve a second slot for the sc.
+ */
+static void rv_jit_add_lrsc_exentries(struct bpf_prog *prog)
+{
+	const struct bpf_insn *insn = prog->insnsi;
+	int i;
+
+	if (IS_ENABLED(CONFIG_RISCV_ISA_ZAAMO) || __riscv_xlen != 64)
+		return;
+
+	for (i = 0; i < prog->len; i++, insn++) {
+		if (BPF_CLASS(insn->code) != BPF_STX ||
+		    BPF_MODE(insn->code) != BPF_PROBE_ATOMIC ||
+		    bpf_atomic_is_load_store(insn))
+			continue;
+		if (BPF_SIZE(insn->code) != BPF_W &&
+		    BPF_SIZE(insn->code) != BPF_DW)
+			continue;
+		/* amocas is a single faulting instruction. */
+		if (insn->imm == BPF_CMPXCHG && rv_ext_enabled(ZACAS))
+			continue;
+		prog->aux->num_exentries++;
+	}
+}
+
 static int build_body(struct rv_jit_context *ctx, bool extra_pass, int *offset)
 {
 	const struct bpf_prog *prog = ctx->prog;
@@ -100,6 +128,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_verifier_env *env, struct bpf_pr
 		if (ctx->ninsns == prev_ninsns) {
 			if (jit_data->header)
 				break;
+			rv_jit_add_lrsc_exentries(prog);
 			/* obtain the actual image size */
 			extable_size = prog->aux->num_exentries *
 				sizeof(struct exception_table_entry);

-- 
2.43.0

