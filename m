Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.133.104.62
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794166090;
	b=VTytNoR1wH0mke3YrhuvQDL/cT6ox+kYGpVJ16ChUwTxm70gSAYnpMsKo03JyJWjbx7H
	 D/Td9imYCW/ruvbx4v/2MzYYbxgn2Qut1BSznIaCa8lXkQwn5elXGrajPtQHuDUn+VuoI
	 rhd0Fb4EifMx8qx8kHu5G1wbpTBCJdxrGAw30STsdrj5J8jHbTogL/cYbNqiRsfnygdu4
	 rAfEkI8H2xbIRW7D7wCuhdi0xiRAY7lIwVE2h+8cYt3xv3o3HBej1QsTx82mQQwBoqxwV
	 JcsmUfh5P3vAoQUgtVqPyTKBLaruaeE/PViwuQdR3hVA4Fq3Ev5W2P5hdO7DEG3gSTQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794166090;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Virus-Scanned;
	bh=S+vyTw2VWykbBBqOe9AKhrQSOD9LSvPZKjMnj6y9IVY=;
	b=CKsrIgnGypxWGm2plnwTFfX6s0aG5Q3i+81X/9YZIGPbiuGB6Z7j5yJP4X/q9jPEhRru
	 OmoQDyftEpfOgjOmAIr0Y/NxdW9X2YyD8D9J4Jmk1b8lBBKh3FErVbi4TEhJ4PJZ98uZC
	 qiKvwQfVw1cGgif2EHqssFQNgPNwB5sC9q3jeaOcli/ZqiMNW1/pV6nRpmUjUc02AA0EJ
	 /vga8m7aqN9chVFZag3I3tkLIr92dqjTKwubqXP2WT0Rmy79isgMLMea8L7GA7VjIVjZA
	 GHhcX1ZqT5YSWlyT4yGcWOCFMZlsnK4HZlQ3filyYdj/NSAsEgftuH81+hzOVgQM9WQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=iogearbox.net;
	spf=pass smtp.mailfrom=iogearbox.net;
	dkim=pass header.d=iogearbox.net header.i=@iogearbox.net header.a=rsa-sha256 header.s=default2302 header.b=CswSQiSv;
	arc=none smtp.remote-ip=213.133.104.62
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F2F5606A31C
	for <bpf@vger.kernel.org>; Sun,  8 Nov 2026 19:28:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5F2F5606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.a=rsa-sha256 header.s=default2302 header.b=CswSQiSv
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=S+vyTw2VWykbBBqOe9AKhrQSOD9LSvPZKjMnj6y9IVY=; b=CswSQiSvx8+iOzZkZYHf4MJ96I
	W8XYGtlEEJHQzAwDvnnEjhdyir7nTYiEGdz4sRIcXGYg5LGg0YKWIeNoSitSeRTQ+6s7EbaLi/0se
	eG223QTfV+B2n1fu/rdvOiIPe0UWGadXVJRqgnQLuLKbvlCRCpYuRttRHUZBAWSjx/6YQOzJhNm6Y
	3yqGnetXW9Kh0YKZk/jlWLlRWRrC92qSykK3sGKuCktLkBCE3gBVDSfVNcj/D6LEoV/iNhV+/h4o0
	4UV7TTrLTzUdVuYbFSkE8f9KoeuX7UG2c7J5EfDypRauXm4Frlg+6uuNHcvgQJSO4UV+vjLKwtpxa
	mfgG9Ahw==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1xQ8Yg-000PqV-38;
	Sun, 08 Nov 2026 20:28:07 +0100
From: Daniel Borkmann <daniel@iogearbox.net>
To: ast@kernel.org
Cc: puranjay@kernel.org,
	memxor@gmail.com,
	xukuohai@huaweicloud.com,
	bpf@vger.kernel.org
Subject: [PATCH bpf-next v3 15/24] bpf, arm64: Zero extend the arena offset in register offset accesses
Date: Sun,  8 Nov 2026 20:26:41 +0100
Message-ID: <ac8f9bf5349238dc16ff7ee4214286f5e5d33d6d.1794165614.git.daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1794165614.git.daniel@iogearbox.net>
References: <cover.1794165614.git.daniel@iogearbox.net>
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
X-Virus-Scanned: Clear (ClamAV 1.4.6/28177/Sun Nov  8 07:23:52 2026)

An arena access added the 32-bit arena offset register to the arena
base with a 64-bit add. That relies on the verifier to keep the upper
32 bits zero, and any slip there would let the access escape the 4GB
arena.

Use the register offset form with UXTW instead. It zero extends the
offset as part of the access, which keeps the access within the arena
and its guard pages. Without an immediate offset, this saves the add.
With one, the add moves to the base, and an offset that does not fit
the add immediate needs an extra mov.

The atomics and load-acquire/store-release have no register offset
form. For them, add the arena offset to the base with UXTW instead.

Update the arm64 expectations of the Arena LDSX Disasm test in
verifier_ldsx to the new form.

Before/after for r0 = *(u64 *)(r1 + 0) and r0 = *(u64 *)(r1 + 8) in the
arena:

  8b1c000b  add x11, x0, x28
  f9400168  ldr x8, [x11]
  f8604b88  ldr x8, [x28, w0, uxtw]

  8b1c000b  add x11, x0, x28
  f9400568  ldr x8, [x11, #8]
  9100238b  add x11, x28, #0x8
  f8604968  ldr x8, [x11, w0, uxtw]

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 arch/arm64/net/bpf_jit_comp.c                 | 90 +++++++++++++------
 .../selftests/bpf/progs/verifier_ldsx.c       | 24 ++---
 2 files changed, 75 insertions(+), 39 deletions(-)

diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
index 083d8c383f5b..fb56b439ee20 100644
--- a/arch/arm64/net/bpf_jit_comp.c
+++ b/arch/arm64/net/bpf_jit_comp.c
@@ -461,6 +461,26 @@ static void emit_ldst(const u8 code, const u8 rt, const u8 rn, const s32 off,
 	}
 }
 
+/*
+ * Load or store at the arena base, plus off added into tmp_addr, plus reg zero
+ * extended from 32 bits in the access, which keeps it in the arena and its
+ * guard whatever the upper bits of reg hold.
+ */
+static void emit_arena_ldst(const u8 code, const u8 rt, const u8 reg, const s32 off,
+			    const u8 tmp_addr, const u8 tmp, struct jit_ctx *ctx)
+{
+	u8 base = bpf2a64[ARENA_VM_START];
+	int scale;
+
+	if (off) {
+		emit_a64_add_i(1, tmp_addr, base, tmp, off, ctx);
+		base = tmp_addr;
+	}
+	emit(aarch64_insn_gen_load_store_reg(rt, base, reg, AARCH64_INSN_EXTEND_UXTW,
+					     0, a64_ldst_size(code, &scale),
+					     a64_ldst_type(code, A64_LDST_REG)), ctx);
+}
+
 /* generated main prog prologue:
  *      bti c // if CONFIG_ARM64_BTI_KERNEL
  *      mov x9, lr
@@ -846,6 +866,7 @@ static int emit_atomic_ld_st(const struct bpf_insn *insn, struct jit_ctx *ctx)
 	const u8 dst = bpf2a64[insn->dst_reg];
 	const u8 src = bpf2a64[insn->src_reg];
 	const u8 tmp = bpf2a64[TMP_REG_1];
+	const u8 tmp2 = bpf2a64[TMP_REG_2];
 	u8 reg;
 
 	switch (imm) {
@@ -860,12 +881,21 @@ static int emit_atomic_ld_st(const struct bpf_insn *insn, struct jit_ctx *ctx)
 		return -EINVAL;
 	}
 
-	if (off) {
-		emit_a64_add_i(1, tmp, reg, tmp, off, ctx);
-		reg = tmp;
-	}
+	/*
+	 * The arena base with the offset first and the arena offset zero
+	 * extended onto it, see emit_arena_ldst()
+	 */
 	if (arena) {
-		emit(A64_ADD(1, tmp, reg, arena_vm_base), ctx);
+		u8 base = arena_vm_base;
+
+		if (off) {
+			emit_a64_add_i(1, tmp, base, tmp, off, ctx);
+			base = tmp;
+		}
+		emit(A64_ADD_UXTW(tmp2, base, reg), ctx);
+		reg = tmp2;
+	} else if (off) {
+		emit_a64_add_i(1, tmp, reg, tmp, off, ctx);
 		reg = tmp;
 	}
 
@@ -919,17 +949,27 @@ static int emit_lse_atomic(const struct bpf_insn *insn, struct jit_ctx *ctx)
 	const u8 src = bpf2a64[insn->src_reg];
 	const u8 tmp = bpf2a64[TMP_REG_1];
 	const u8 tmp2 = bpf2a64[TMP_REG_2];
+	const u8 tmp3 = bpf2a64[TMP_REG_3];
 	const bool isdw = BPF_SIZE(code) == BPF_DW;
 	const bool arena = BPF_MODE(code) == BPF_PROBE_ATOMIC;
 	const s16 off = insn->off;
 	u8 reg = dst;
 
-	if (off) {
-		emit_a64_add_i(1, tmp, reg, tmp, off, ctx);
-		reg = tmp;
-	}
+	/*
+	 * The arena base with the offset first and the arena offset zero
+	 * extended onto it, see emit_arena_ldst()
+	 */
 	if (arena) {
-		emit(A64_ADD(1, tmp, reg, arena_vm_base), ctx);
+		u8 base = arena_vm_base;
+
+		if (off) {
+			emit_a64_add_i(1, tmp, base, tmp, off, ctx);
+			base = tmp;
+		}
+		emit(A64_ADD_UXTW(tmp3, base, reg), ctx);
+		reg = tmp3;
+	} else if (off) {
+		emit_a64_add_i(1, tmp, reg, tmp, off, ctx);
 		reg = tmp;
 	}
 
@@ -1564,7 +1604,6 @@ static int build_insn(const struct bpf_verifier_env *env, const struct bpf_insn
 	const u8 tmp = bpf2a64[TMP_REG_1];
 	const u8 tmp2 = bpf2a64[TMP_REG_2];
 	const u8 tmp3 = bpf2a64[TMP_REG_3];
-	const u8 arena_vm_base = bpf2a64[ARENA_VM_START];
 	const s16 off = insn->off;
 	const s32 imm = insn->imm;
 	const int i = insn - ctx->prog->insnsi;
@@ -2062,11 +2101,6 @@ static int build_insn(const struct bpf_verifier_env *env, const struct bpf_insn
 	case BPF_LDX | BPF_PROBE_MEM32SX | BPF_B:
 	case BPF_LDX | BPF_PROBE_MEM32SX | BPF_H:
 	case BPF_LDX | BPF_PROBE_MEM32SX | BPF_W:
-		if (BPF_MODE(insn->code) == BPF_PROBE_MEM32 ||
-		    BPF_MODE(insn->code) == BPF_PROBE_MEM32SX) {
-			emit(A64_ADD(1, tmp2, src, arena_vm_base), ctx);
-			src = tmp2;
-		}
 		off_adj = off;
 		if (BPF_MODE(insn->code) == BPF_PROBE_MEM ||
 		    BPF_MODE(insn->code) == BPF_PROBE_MEMSX) {
@@ -2086,7 +2120,11 @@ static int build_insn(const struct bpf_verifier_env *env, const struct bpf_insn
 			emit(A64_MOVZ(1, dst, 0, 0), ctx);
 			emit(A64_B(2), ctx);
 		}
-		emit_ldst(code, dst, src, off_adj, tmp, ctx);
+		if (BPF_MODE(insn->code) == BPF_PROBE_MEM32 ||
+		    BPF_MODE(insn->code) == BPF_PROBE_MEM32SX)
+			emit_arena_ldst(code, dst, src, off, tmp2, tmp, ctx);
+		else
+			emit_ldst(code, dst, src, off_adj, tmp, ctx);
 
 		ret = add_exception_handler(insn, ctx, dst);
 		if (ret)
@@ -2117,14 +2155,13 @@ static int build_insn(const struct bpf_verifier_env *env, const struct bpf_insn
 	case BPF_ST | BPF_PROBE_MEM32 | BPF_H:
 	case BPF_ST | BPF_PROBE_MEM32 | BPF_W:
 	case BPF_ST | BPF_PROBE_MEM32 | BPF_DW:
-		if (BPF_MODE(insn->code) == BPF_PROBE_MEM32) {
-			emit(A64_ADD(1, tmp3, dst, arena_vm_base), ctx);
-			dst = tmp3;
-		}
 		/* A zero comes from the zero register, any other imm through a register */
 		if (imm)
 			emit_a64_mov_i(1, tmp, imm, ctx);
-		emit_ldst(code, imm ? tmp : A64_ZR, dst, off, tmp2, ctx);
+		if (BPF_MODE(insn->code) == BPF_PROBE_MEM32)
+			emit_arena_ldst(code, imm ? tmp : A64_ZR, dst, off, tmp3, tmp2, ctx);
+		else
+			emit_ldst(code, imm ? tmp : A64_ZR, dst, off, tmp2, ctx);
 
 		ret = add_exception_handler(insn, ctx, DONT_CLEAR);
 		if (ret)
@@ -2145,11 +2182,10 @@ static int build_insn(const struct bpf_verifier_env *env, const struct bpf_insn
 	case BPF_STX | BPF_PROBE_MEM32 | BPF_H:
 	case BPF_STX | BPF_PROBE_MEM32 | BPF_W:
 	case BPF_STX | BPF_PROBE_MEM32 | BPF_DW:
-		if (BPF_MODE(insn->code) == BPF_PROBE_MEM32) {
-			emit(A64_ADD(1, tmp2, dst, arena_vm_base), ctx);
-			dst = tmp2;
-		}
-		emit_ldst(code, src, dst, off, tmp, ctx);
+		if (BPF_MODE(insn->code) == BPF_PROBE_MEM32)
+			emit_arena_ldst(code, src, dst, off, tmp2, tmp, ctx);
+		else
+			emit_ldst(code, src, dst, off, tmp, ctx);
 
 		ret = add_exception_handler(insn, ctx, DONT_CLEAR);
 		if (ret)
diff --git a/tools/testing/selftests/bpf/progs/verifier_ldsx.c b/tools/testing/selftests/bpf/progs/verifier_ldsx.c
index 8084a428d9e2..232082428cb9 100644
--- a/tools/testing/selftests/bpf/progs/verifier_ldsx.c
+++ b/tools/testing/selftests/bpf/progs/verifier_ldsx.c
@@ -274,18 +274,18 @@ __jited("movslq	0x10(%rdi,%r12), %r15")
 __jited("movswq	0x18(%rdi,%r12), %r15")
 __jited("movsbq	0x20(%rdi,%r12), %r15")
 __arch_arm64
-__jited("add	x11, x8, x28")
-__jited("ldrsw	x21, [x11, #0x10]")
-__jited("add	x11, x8, x28")
-__jited("ldrsh	x21, [x11, #0x18]")
-__jited("add	x11, x8, x28")
-__jited("ldrsb	x21, [x11, #0x20]")
-__jited("add	x11, x0, x28")
-__jited("ldrsw	x22, [x11, #0x10]")
-__jited("add	x11, x0, x28")
-__jited("ldrsh	x22, [x11, #0x18]")
-__jited("add	x11, x0, x28")
-__jited("ldrsb	x22, [x11, #0x20]")
+__jited("add	x11, x28, #0x10")
+__jited("ldrsw	x21, [x11, w8, uxtw]")
+__jited("add	x11, x28, #0x18")
+__jited("ldrsh	x21, [x11, w8, uxtw]")
+__jited("add	x11, x28, #0x20")
+__jited("ldrsb	x21, [x11, w8, uxtw]")
+__jited("add	x11, x28, #0x10")
+__jited("ldrsw	x22, [x11, w0, uxtw]")
+__jited("add	x11, x28, #0x18")
+__jited("ldrsh	x22, [x11, w0, uxtw]")
+__jited("add	x11, x28, #0x20")
+__jited("ldrsb	x22, [x11, w0, uxtw]")
 __arch_riscv64
 __jited("add	t2, t6, s7")
 __jited("lw	s3, 0x10(t2)")
-- 
2.43.0

