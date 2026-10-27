Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.133.104.62
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793125511;
	b=S0GSWjJ4+99Euk9iqURgSulp0kmW6mr4hHs12gpZBu1CnG4uM89i6Tv6LqwohuWwAiuC
	 i9+r5cwKtKddejyT84reJg+x194shwxMWdbr//OKjR70dZPqtAc97Gr4rmtPEnyS5aAUQ
	 D1nl1vGRceEcpRNIVkkBrmLlrpM38poHxzxUDiwlAREcfXLEfbcWQjQ0pNnZ1HTyg2UYd
	 WYV7rYMMM3ziZeVQX1a6U7X2/BJmw+XR/OpUVHic3LzrgqYqsRIGWo7ib07uJqbrocOyp
	 mUM1hLKDYY4TnlbJl2FRU1wP3ZUa2OKeibYOiQ2QrUgpewWfNS1x2m8NYfEd6dAgszA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793125511;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Virus-Scanned;
	bh=dFZ89UQ8uf6Qu8sRKzWpFinAc0gfVGaqGSokL9UyvXU=;
	b=tjka+ilk2thc8QSpIJ/ToS577BbcWdS2kNt0Ek273KUESJtA34tTWfWv0nXu9u/JCw8f
	 uFV30CiiY6YiLWtEoqPk6InkcmrfDnYGxyD0iU4dcnUT91v8fzQ4uuebCaAfsXnRCbq8u
	 VYiWKEDazEYUuWUs9aogWSiJ47RZ1NVjRf/Xw6+RKaLeuhxlxF+rzQfWwgzA8JB+8BiI1
	 rJ6JS4pVhouWc0M4sY3JiMupTNuK2qPRWmNw3m1xgYxgcnQhV9Ul+tC6nuLVkaVomcqLw
	 OzAECibkEVH/C2xDcdxdnwsH2plQj6UnVO97eFjLkO4A41xwmmsxVyLkBdF/8rM/vsQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=iogearbox.net;
	spf=pass smtp.mailfrom=iogearbox.net;
	dkim=pass header.d=iogearbox.net header.i=@iogearbox.net header.a=rsa-sha256 header.s=default2302 header.b=LvcbbnMn;
	arc=none smtp.remote-ip=213.133.104.62
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31462606A336
	for <bpf@vger.kernel.org>; Tue, 27 Oct 2026 18:24:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 31462606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=iogearbox.net header.i=@iogearbox.net header.a=rsa-sha256 header.s=default2302 header.b=LvcbbnMn
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=dFZ89UQ8uf6Qu8sRKzWpFinAc0gfVGaqGSokL9UyvXU=; b=LvcbbnMnrqQJhrQKIC959T+SXv
	6Bjb6j1lQVh2mv4+djuqRVkhPZC4kt2OdRwRrjpNqa/RNO/5cj1MQcKVZ5M+QXrfex4NKq/NarHQv
	yJOetyEDL5CJlQK0Zx7jfj+kl0kufUfM8ZS4L/85vLM4wr1CgKmvU7jZCn3sLsa+mOD1ikAq2QeX2
	G3wwMBHH4H/AEWqrt2RgxmOY3IKGKuk0EZntS3hXFdGz+hwASO10J1jrqBAlrbFpHTj7rjrVS5Rs1
	PpGgNsUt3rGZBLcU8qRuIcOEmEvoZ1eKyU0nPwSXTRNwt0muOM5wjdVzQnt2vJpptj0dOwjIMzqHk
	4xC3gZhQ==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1xLlqy-000In9-2K;
	Tue, 27 Oct 2026 19:24:56 +0100
From: Daniel Borkmann <daniel@iogearbox.net>
To: puranjay@kernel.org
Cc: memxor@gmail.com,
	ast@kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH bpf-next 19/21] bpf, arm64: Split 24-bit immediates of add, sub and equality compares
Date: Tue, 27 Oct 2026 19:24:43 +0100
Message-ID: <20261027182445.1156335-20-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261027182445.1156335-1-daniel@iogearbox.net>
References: <20261027182445.1156335-1-daniel@iogearbox.net>
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
X-Virus-Scanned: Clear (ClamAV 1.4.6/28166/Tue Oct 27 07:24:12 2026)

An add, sub or compare with an immediate that neither the plain nor the
shifted 12-bit field takes moved the immediate into a register first,
two moves for most immediates up to 24 bits and then the add. Take two
adds or subs instead, of the upper 12 bits shifted and of the lower 12:
an instruction fewer, at a cycle more on the path of the operand, as the
two depend on each other where the moves did not, so an immediate that a
single move produces keeps the move. A compare for equality takes the
upper 12 bits off into a scratch register and compares against the lower
12, as the subtraction keeps equality.

Before/after for r2 += 0x22880 and if r1 == 0x12345 goto ...:

  d285100a  mov x10, #0x2880
  f2a0004a  movk x10, #0x2, lsl #16
  8b0a0021  add x1, x1, x10
  91408821  add x1, x1, #0x22, lsl #12
  91220021  add x1, x1, #0x880

  d28468aa  mov x10, #0x2345
  f2a0002a  movk x10, #0x1, lsl #16
  eb0a001f  cmp x0, x10
  54000040  b.eq ...
  d140480a  sub x10, x0, #0x12, lsl #12
  f10d155f  cmp x10, #0x345
  54000040  b.eq ...

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 arch/arm64/net/bpf_jit_comp.c | 113 ++++++++++++++++++++++------------
 1 file changed, 74 insertions(+), 39 deletions(-)

diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
index 5995b925b900..ce72039515ff 100644
--- a/arch/arm64/net/bpf_jit_comp.c
+++ b/arch/arm64/net/bpf_jit_comp.c
@@ -133,42 +133,40 @@ static inline void emit_u32_data(const u32 data, struct jit_ctx *ctx)
 }
 
 /*
- * A 32-bit immediate, sign extended for the 64-bit variant: a single movz
- * or movn when one half is zero or all ones and the other half agrees with
- * the sign the 64-bit variant extends, a single orr when it is a bitmask
- * immediate, and the pair of a movz or movn with a movk otherwise.
+ * The single instruction for a 32-bit immediate, sign extended for the
+ * 64-bit variant: a movz or movn when one half is zero or all ones and the
+ * other half agrees with the sign the 64-bit variant extends, an orr when
+ * it is a bitmask immediate, else AARCH64_BREAK_FAULT.
  */
-static inline void emit_a64_mov_i(const int is64, const int reg,
-				  const s32 val, struct jit_ctx *ctx)
+static u32 a64_mov_i_single(const int is64, const int reg, const s32 val)
 {
 	u16 hi = val >> 16;
 	u16 lo = val & 0xffff;
-	u32 insn;
 
-	if (hi == 0xffff) {
-		emit(A64_MOVN(is64, reg, (u16)~lo, 0), ctx);
-		return;
-	}
-	if (!hi) {
-		emit(A64_MOVZ(is64, reg, lo, 0), ctx);
-		return;
-	}
+	if (hi == 0xffff)
+		return A64_MOVN(is64, reg, (u16)~lo, 0);
+	if (!hi)
+		return A64_MOVZ(is64, reg, lo, 0);
 	/* The 64-bit variant has the upper half set or clear with the sign */
-	if (!lo && (!is64 || !(hi & 0x8000))) {
-		emit(A64_MOVZ(is64, reg, hi, 16), ctx);
-		return;
-	}
-	if (lo == 0xffff && (!is64 || (hi & 0x8000))) {
-		emit(A64_MOVN(is64, reg, (u16)~hi, 16), ctx);
-		return;
-	}
+	if (!lo && (!is64 || !(hi & 0x8000)))
+		return A64_MOVZ(is64, reg, hi, 16);
+	if (lo == 0xffff && (!is64 || (hi & 0x8000)))
+		return A64_MOVN(is64, reg, (u16)~hi, 16);
+	return A64_ORR_I(is64, reg, A64_ZR, val);
+}
+
+/* A 32-bit immediate in its single instruction, or a movz or movn with a movk */
+static inline void emit_a64_mov_i(const int is64, const int reg,
+				  const s32 val, struct jit_ctx *ctx)
+{
+	u16 hi = val >> 16;
+	u16 lo = val & 0xffff;
+	u32 insn = a64_mov_i_single(is64, reg, val);
 
-	insn = A64_ORR_I(is64, reg, A64_ZR, val);
 	if (insn != AARCH64_BREAK_FAULT) {
 		emit(insn, ctx);
 		return;
 	}
-
 	if (hi & 0x8000) {
 		emit(A64_MOVN(is64, reg, (u16)~hi, 16), ctx);
 		emit(A64_MOVK(is64, reg, lo, 0), ctx);
@@ -363,19 +361,52 @@ static bool is_addsub_imm(u32 imm)
 	return !(imm & ~0xfff) || !(imm & ~0xfff000);
 }
 
-static inline void emit_a64_add_i(const bool is64, const int dst, const int src,
-				  const int tmp, const s32 imm, struct jit_ctx *ctx)
+/* An immediate below 2^24 that neither add nor sub takes goes in two of them */
+static bool is_addsub_imm24(u32 imm)
+{
+	return !(imm & ~0xffffff);
+}
+
+/*
+ * dst = src + imm, or src - imm: with the immediate when an add or sub takes
+ * it, with the negated one in the other, else in two of them with the upper
+ * 12 bits shifted and the lower 12 when the move of the immediate takes two
+ * instructions, one fewer at a cycle more on the path of src, as the two
+ * depend on each other. The rest takes the move, which is off the path, and
+ * the add or sub of the register.
+ */
+static void emit_a64_addsub_i(const bool is64, const int dst, const int src, const int tmp,
+			      const s32 imm, bool sub, struct jit_ctx *ctx)
 {
+	const enum aarch64_insn_adsb_type op = sub ? AARCH64_INSN_ADSB_SUB : AARCH64_INSN_ADSB_ADD;
+	const enum aarch64_insn_adsb_type neg = sub ? AARCH64_INSN_ADSB_ADD : AARCH64_INSN_ADSB_SUB;
+	const enum aarch64_insn_variant variant = A64_VARIANT(is64);
+	const bool split = a64_mov_i_single(is64, tmp, imm) == AARCH64_BREAK_FAULT;
+	const u32 nimm = -(u32)imm;
+
 	if (is_addsub_imm(imm)) {
-		emit(A64_ADD_I(is64, dst, src, imm), ctx);
-	} else if (is_addsub_imm(-(u32)imm)) {
-		emit(A64_SUB_I(is64, dst, src, -imm), ctx);
+		emit(aarch64_insn_gen_add_sub_imm(dst, src, imm, variant, op), ctx);
+	} else if (is_addsub_imm(nimm)) {
+		emit(aarch64_insn_gen_add_sub_imm(dst, src, nimm, variant, neg), ctx);
+	} else if (split && is_addsub_imm24(imm)) {
+		emit(aarch64_insn_gen_add_sub_imm(dst, src, imm & 0xfff000, variant, op), ctx);
+		emit(aarch64_insn_gen_add_sub_imm(dst, dst, imm & 0xfff, variant, op), ctx);
+	} else if (split && is_addsub_imm24(nimm)) {
+		emit(aarch64_insn_gen_add_sub_imm(dst, src, nimm & 0xfff000, variant, neg), ctx);
+		emit(aarch64_insn_gen_add_sub_imm(dst, dst, nimm & 0xfff, variant, neg), ctx);
 	} else {
 		emit_a64_mov_i(is64, tmp, imm, ctx);
-		emit(A64_ADD(is64, dst, src, tmp), ctx);
+		emit(aarch64_insn_gen_add_sub_shifted_reg(dst, src, tmp, AARCH64_INSN_SHIFT_LSL, 0,
+							  variant, op), ctx);
 	}
 }
 
+static inline void emit_a64_add_i(const bool is64, const int dst, const int src,
+				  const int tmp, const s32 imm, struct jit_ctx *ctx)
+{
+	emit_a64_addsub_i(is64, dst, src, tmp, imm, false, ctx);
+}
+
 /*
  * There are 3 types of AArch64 LDR/STR (immediate) instruction:
  * Post-index, Pre-index, Unsigned offset.
@@ -2212,14 +2243,7 @@ static int build_insn(const struct bpf_verifier_env *env, const struct bpf_insn
 		break;
 	case BPF_ALU | BPF_SUB | BPF_K:
 	case BPF_ALU64 | BPF_SUB | BPF_K:
-		if (is_addsub_imm(imm)) {
-			emit(A64_SUB_I(is64, dst, dst, imm), ctx);
-		} else if (is_addsub_imm(-(u32)imm)) {
-			emit(A64_ADD_I(is64, dst, dst, -imm), ctx);
-		} else {
-			emit_a64_mov_i(is64, tmp, imm, ctx);
-			emit(A64_SUB(is64, dst, dst, tmp), ctx);
-		}
+		emit_a64_addsub_i(is64, dst, dst, tmp, imm, true, ctx);
 		break;
 	case BPF_ALU | BPF_AND | BPF_K:
 	case BPF_ALU64 | BPF_AND | BPF_K:
@@ -2429,6 +2453,17 @@ static int build_insn(const struct bpf_verifier_env *env, const struct bpf_insn
 			emit(A64_CMP_I(is64, dst, cmp_imm), ctx);
 		} else if (is_addsub_imm(-(u32)cmp_imm)) {
 			emit(A64_CMN_I(is64, dst, -cmp_imm), ctx);
+		} else if ((jmp_op == BPF_JEQ || jmp_op == BPF_JNE) &&
+			   a64_mov_i_single(is64, tmp, imm) == AARCH64_BREAK_FAULT &&
+			   (is_addsub_imm24(imm) || is_addsub_imm24(-(u32)imm))) {
+			/* Equal when the lower 12 bits remain once the upper 12 are taken off */
+			if (is_addsub_imm24(imm)) {
+				emit(A64_SUB_I(is64, tmp, dst, imm & 0xfff000), ctx);
+				emit(A64_CMP_I(is64, tmp, imm & 0xfff), ctx);
+			} else {
+				emit(A64_ADD_I(is64, tmp, dst, -(u32)imm & 0xfff000), ctx);
+				emit(A64_CMN_I(is64, tmp, -(u32)imm & 0xfff), ctx);
+			}
 		} else {
 			emit_a64_mov_i(is64, tmp, cmp_imm, ctx);
 			emit(A64_CMP(is64, dst, tmp), ctx);
-- 
2.43.0

