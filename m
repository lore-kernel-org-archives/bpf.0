Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87F49445AD6
	for <bpf@vger.kernel.org>; Mon, 10 Aug 2026 19:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786390968; cv=none; b=AOp2bmYRJeYNo2q4oQ/R9UC300/yUtY1ImlPeIt6HXEkdrJNByop95u2ReO3myqQxljzKNGrztxxtDQ8TQGJ1tUjpqfWK9oCaVCWm4bDGeBahrb0EjFg3XdOUwCqsj76i+orj7ZR1uvuDp4Z4GVtyqfpQZ92niOYHTtZtT6H2uM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786390968; c=relaxed/simple;
	bh=Hk594hdwS7QJIe27+T3Bu2SM2HFbOs4lT7K2z/+GFME=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gGM4kaD0/Q4YjjeQnqKH5OUeuF7k3rrkxXDoVesBOj0qV2jBLW7g7YZzaJhg32ePBIsCOIMtCw8uI3oDs+Re+oGWZAz+kVYde+jcvyr86L9q3oZQ4ihL8g7jxG/PQhZ8sqfUtyBDFpjJOXG/gG9Fo/SQ51TlBmGkVnxFMAhgYic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HUaLiHrM; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HUaLiHrM"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-c20363107f4so239360766b.2
        for <bpf@vger.kernel.org>; Mon, 10 Aug 2026 12:42:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786390956; x=1786995756; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ETizRDkZW/a1S1LbEYcAVrtgMKkSx6oqA1ooR3uQg+4=;
        b=HUaLiHrM/xCRVYl+oQAmC4H/DSZvtoEb9hKKbC5saXTW6csu3SYfocDwDDIVpdykax
         /hDRk39a0CPV69cWQlDfNsfpnVBaebrw9uMYjpFR10H00QLEabfDv6+jqRstecIHyN6O
         S7iT4QwQwSwE7CJoxURjdTwDpBu8OCxl8MLgdy3IIa9ixOBr5x0Gqbt9xDNEiRr5Y+q7
         HVvvQoT1tLMc8rPMjy6CP2w8I4xhWKow1XwUT2N0bnPU15WytmM8Sud9IRxJb3f4Iyqw
         fMSMy/padGnkbHL9og1w+d2whC5+3ArFLbHKEsTaaWK/CaXp6t9eZQca2v2z6RHOnW1B
         gv4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786390956; x=1786995756;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ETizRDkZW/a1S1LbEYcAVrtgMKkSx6oqA1ooR3uQg+4=;
        b=HEuJzuW8mO8JrttvYf0br8+vs7cCabGQwF6jtm6tlgowDfBCaEMNbtA1pRy8TWrLr6
         zCnns+k0hD41Vr8pEyEHf48x0oX6tZ2LVOAzdzldB1dPa2aCyVYIPvmzK2VjvMrhYAHA
         0UF4+zBDgV3fHNhomOM8dVYO9ydGp0pMQ58tXok7LNduIQHicZFv+nXAUPbPqhpM/1K6
         xALwhcfSuVa+g7jngGzSqA0Rdcpk2X7D4tKw2TCz3fMhoggVEj485xE32YmETOXGXFza
         M0pRbXRZFvcharACfzEYgAsZmI22Jif9DT0Ws3eazmp9jL5sp1walDUarPMI3vTtaKkE
         fbIw==
X-Forwarded-Encrypted: i=1; AHgh+RoI7HXtioZXR3ilKyjQEGrezoRjRZXfm310T9ZrxassriPk2LmvSOP9uLAg4yGpF41YryQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQVTo33uy6G5LbnjQZXhF42Cbsw0wdc3sZMXOVyd1DTihbBdpD
	u8XZFIxoC/LcvsTDyd1DV4d5KBCe2Pwo/qP1v42rBYf9YGj41xv8uB/C
X-Gm-Gg: AR+sD10uH+VR/SRyEiHjiD0Mj1Egxi+sQfO+Y0enH7piUMPIsay7FRszkNhWcpQdD//
	Vu99AJFeFnEdUsWkeZCStGlndT3l9TDrL3LWE2Frs6vPWJYJg6+exTvYXA+ePBQvwqlJ1CcQcum
	udTSa90R7EINQtqDrzO4XGnKAin5TW54eETPkZ94Li/6RSjKQWwz0fcybLseXtdSHhdqOMOoQle
	v8rOAbHTrYL4T5k3d/3ZjelQSMXFdrT9KH5WB8s2g9OWifkhp/DujS+Euw1GA1NTnOp063wbC/W
	4nVtrnsyEO+OLh+54d57EvUBkOr60wVBjbQ5ckn1oWmMTXnMtzZ/XTWRYu+wkmS2VHLXOwNZZGS
	hIDslLPOrHFdtkWiUFsufWNeIl6oBsS8t0xjDpHldXpS+hfi0gs04dWt8I9WF2OBgybhSuU+rhK
	Utc1e83QvWBLTRxFMjFw8kTs/pFAY09CyB/p3E+rWBTdb2XdWbk9Twv3HZ9PmYqsoo
X-Received: by 2002:a17:906:eecd:b0:c16:29eb:e81a with SMTP id a640c23a62f3a-c20c6d16e46mr216166266b.29.1786390955742;
        Mon, 10 Aug 2026 12:42:35 -0700 (PDT)
Received: from TurinLinux.. ([187.15.140.84])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2080a6f414sm430309066b.17.2026.08.10.12.42.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2026 12:42:35 -0700 (PDT)
From: Nicholas Dudar <main.kalliope@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	tsbogend@alpha.franken.de,
	johan.almbladh@anyfinetworks.com,
	paulburton@kernel.org
Cc: martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	emil@etsalapatis.com,
	ihor.solodrai@linux.dev,
	philmd@oss.qualcomm.com,
	bpf@vger.kernel.org,
	linux-mips@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v3 3/3] bpf, mips: Add support for BPF_SDIV and BPF_SMOD
Date: Mon, 10 Aug 2026 15:42:15 -0400
Message-Id: <20260810194215.3754591-4-main.kalliope@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260810194215.3754591-1-main.kalliope@gmail.com>
References: <20260810194215.3754591-1-main.kalliope@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The MIPS JITs handle BPF_DIV and BPF_MOD without inspecting insn->off,
which distinguishes BPF_SDIV and BPF_SMOD. Signed operations therefore
use unsigned instructions, or unsigned helpers for ALU64 on 32-bit
MIPS, and produce unsigned results for negative operands.

Pass insn->off unchanged through immediate validation and register
emission, and interpret it only in div/mod-specific paths. Use signed
DIV/DDIV for pre-R6 and DIV/MOD/DDIV/DMOD for R6. On 32-bit MIPS, use
div64_s64() and a signed remainder helper for ALU64. Keep the signed
quotient signed while computing that remainder, and keep signed
immediates out of the unsigned power-of-two shift/mask rewrite.

check_alu_op() rejects immediate zero divisors. bpf_do_misc_fixups()
rewrites signed immediate -1 and guards register divisors that are zero
or, for signed operations, -1 before JIT compilation. The ALU32 paths
continue to zero-extend their results.

The remaining test_bpf failures are five MOVSX, eight BSWAP, three
MEMSX, and one JMP32_JA. MOVSX and MEMSX will be addressed separately;
Johan Almbladh is handling BSWAP and JMP32_JA.

Found while auditing BPF JIT handling of signed div/mod.

Assisted-by: Codex:gpt-5.6-sol
Link: https://lore.kernel.org/bpf/CAM1=_QS79dDBfaaNQXnWd61AqHd1M4o9aDMMiftnoJveNr=FZg@mail.gmail.com/
Link: https://lore.kernel.org/bpf/CAM1=_QQ7XiJEozaetLt_+kVn91YAXWpJK_pyfT9=paXseW=wwA@mail.gmail.com/
Signed-off-by: Nicholas Dudar <main.kalliope@gmail.com>
---
 arch/mips/net/bpf_jit_comp.c   | 35 ++++++++++++++++-------
 arch/mips/net/bpf_jit_comp.h   |  4 +--
 arch/mips/net/bpf_jit_comp32.c | 29 ++++++++++++-------
 arch/mips/net/bpf_jit_comp64.c | 51 +++++++++++++++++++++-------------
 4 files changed, 78 insertions(+), 41 deletions(-)

diff --git a/arch/mips/net/bpf_jit_comp.c b/arch/mips/net/bpf_jit_comp.c
index 320180330fb3..f14de6d73122 100644
--- a/arch/mips/net/bpf_jit_comp.c
+++ b/arch/mips/net/bpf_jit_comp.c
@@ -208,7 +208,7 @@ void emit_mov_r(struct jit_context *ctx, u8 dst, u8 src)
 }
 
 /* Validate ALU immediate range */
-bool valid_alu_i(u8 op, s32 imm)
+bool valid_alu_i(u8 op, s32 imm, s16 off)
 {
 	switch (BPF_OP(op)) {
 	case BPF_NEG:
@@ -237,6 +237,9 @@ bool valid_alu_i(u8 op, s32 imm)
 		return imm == 0 || (imm > 0 && is_power_of_2(imm));
 	case BPF_DIV:
 	case BPF_MOD:
+		/* Do not use unsigned shift/mask rewrites for signed div/mod. */
+		if (off == 1)
+			return false;
 		/* imm must be an 17-bit power of two */
 		return (u32)imm <= 0x10000 && is_power_of_2((u32)imm);
 	}
@@ -339,29 +342,41 @@ void emit_alu_i(struct jit_context *ctx, u8 dst, s32 imm, u8 op)
 }
 
 /* ALU division operation (32-bit) */
-static void emit_div(struct jit_context *ctx, u8 dst, u8 src)
+static void emit_div(struct jit_context *ctx, u8 dst, u8 src, s16 off)
 {
 	if (cpu_has_mips32r6) {
-		emit(ctx, divu_r6, dst, dst, src);
+		if (off == 1)
+			emit(ctx, div_r6, dst, dst, src);
+		else
+			emit(ctx, divu_r6, dst, dst, src);
 	} else {
-		emit(ctx, divu, dst, src);
+		if (off == 1)
+			emit(ctx, div, dst, src);
+		else
+			emit(ctx, divu, dst, src);
 		emit(ctx, mflo, dst);
 	}
 }
 
 /* ALU modulo operation (32-bit) */
-static void emit_mod(struct jit_context *ctx, u8 dst, u8 src)
+static void emit_mod(struct jit_context *ctx, u8 dst, u8 src, s16 off)
 {
 	if (cpu_has_mips32r6) {
-		emit(ctx, modu, dst, dst, src);
+		if (off == 1)
+			emit(ctx, mod, dst, dst, src);
+		else
+			emit(ctx, modu, dst, dst, src);
 	} else {
-		emit(ctx, divu, dst, src);
+		if (off == 1)
+			emit(ctx, div, dst, src);
+		else
+			emit(ctx, divu, dst, src);
 		emit(ctx, mfhi, dst);
 	}
 }
 
 /* ALU register operation (32-bit) */
-void emit_alu_r(struct jit_context *ctx, u8 dst, u8 src, u8 op)
+void emit_alu_r(struct jit_context *ctx, u8 dst, u8 src, u8 op, s16 off)
 {
 	switch (BPF_OP(op)) {
 	/* dst = dst & src */
@@ -407,11 +422,11 @@ void emit_alu_r(struct jit_context *ctx, u8 dst, u8 src, u8 op)
 		break;
 	/* dst = dst / src */
 	case BPF_DIV:
-		emit_div(ctx, dst, src);
+		emit_div(ctx, dst, src, off);
 		break;
 	/* dst = dst % src */
 	case BPF_MOD:
-		emit_mod(ctx, dst, src);
+		emit_mod(ctx, dst, src, off);
 		break;
 	}
 	clobber_reg(ctx, dst);
diff --git a/arch/mips/net/bpf_jit_comp.h b/arch/mips/net/bpf_jit_comp.h
index a37fe20818eb..0ddedb733dd1 100644
--- a/arch/mips/net/bpf_jit_comp.h
+++ b/arch/mips/net/bpf_jit_comp.h
@@ -163,7 +163,7 @@ void emit_mov_i(struct jit_context *ctx, u8 dst, s32 imm);
 void emit_mov_r(struct jit_context *ctx, u8 dst, u8 src);
 
 /* Validate ALU/ALU64 immediate range */
-bool valid_alu_i(u8 op, s32 imm);
+bool valid_alu_i(u8 op, s32 imm, s16 off);
 
 /* Rewrite ALU/ALU64 immediate operation */
 bool rewrite_alu_i(u8 op, s32 imm, u8 *alu, s32 *val);
@@ -172,7 +172,7 @@ bool rewrite_alu_i(u8 op, s32 imm, u8 *alu, s32 *val);
 void emit_alu_i(struct jit_context *ctx, u8 dst, s32 imm, u8 op);
 
 /* ALU register operation (32-bit) */
-void emit_alu_r(struct jit_context *ctx, u8 dst, u8 src, u8 op);
+void emit_alu_r(struct jit_context *ctx, u8 dst, u8 src, u8 op, s16 off);
 
 /* Atomic read-modify-write (32-bit) */
 void emit_atomic_r(struct jit_context *ctx, u8 dst, u8 src, s16 off, u8 code);
diff --git a/arch/mips/net/bpf_jit_comp32.c b/arch/mips/net/bpf_jit_comp32.c
index 40a878b672f5..6619182b5ef3 100644
--- a/arch/mips/net/bpf_jit_comp32.c
+++ b/arch/mips/net/bpf_jit_comp32.c
@@ -512,7 +512,7 @@ static void emit_mul_r64(struct jit_context *ctx,
 	clobber_reg64(ctx, dst);
 }
 
-/* Helper function for 64-bit modulo */
+/* Helper function for unsigned 64-bit modulo */
 static u64 jit_mod64(u64 a, u64 b)
 {
 	u64 rem;
@@ -521,13 +521,22 @@ static u64 jit_mod64(u64 a, u64 b)
 	return rem;
 }
 
+/* Helper function for signed 64-bit modulo */
+static s64 jit_smod64(s64 a, s64 b)
+{
+	s64 quot = div64_s64(a, b);
+
+	return a - quot * b;
+}
+
 /* ALU div/mod register (64-bit) */
-static void emit_divmod_r64(struct jit_context *ctx,
-			    const u8 dst[], const u8 src[], u8 op)
+static void emit_divmod_r64(struct jit_context *ctx, const u8 dst[],
+			    const u8 src[], u8 op, s16 off)
 {
 	const u8 *r0 = bpf2mips32[BPF_REG_0]; /* Mapped to v0-v1 */
 	const u8 *r1 = bpf2mips32[BPF_REG_1]; /* Mapped to a0-a1 */
 	const u8 *r2 = bpf2mips32[BPF_REG_2]; /* Mapped to a2-a3 */
+	bool is_signed = off == 1;
 	int exclude, k;
 	u32 addr = 0;
 
@@ -546,11 +555,11 @@ static void emit_divmod_r64(struct jit_context *ctx,
 	switch (BPF_OP(op)) {
 	/* dst = dst / src */
 	case BPF_DIV:
-		addr = (u32)&div64_u64;
+		addr = is_signed ? (u32)&div64_s64 : (u32)&div64_u64;
 		break;
 	/* dst = dst % src */
 	case BPF_MOD:
-		addr = (u32)&jit_mod64;
+		addr = is_signed ? (u32)&jit_smod64 : (u32)&jit_mod64;
 		break;
 	}
 	emit_mov_i(ctx, MIPS_R_T9, addr);
@@ -1516,9 +1525,9 @@ int build_insn(const struct bpf_insn *insn, struct jit_context *ctx)
 	case BPF_ALU | BPF_MUL | BPF_K:
 	case BPF_ALU | BPF_DIV | BPF_K:
 	case BPF_ALU | BPF_MOD | BPF_K:
-		if (!valid_alu_i(BPF_OP(code), imm)) {
+		if (!valid_alu_i(BPF_OP(code), imm, off)) {
 			emit_mov_i(ctx, MIPS_R_T6, imm);
-			emit_alu_r(ctx, lo(dst), MIPS_R_T6, BPF_OP(code));
+			emit_alu_r(ctx, lo(dst), MIPS_R_T6, BPF_OP(code), off);
 		} else if (rewrite_alu_i(BPF_OP(code), imm, &alu, &val)) {
 			emit_alu_i(ctx, lo(dst), val, alu);
 		}
@@ -1546,7 +1555,7 @@ int build_insn(const struct bpf_insn *insn, struct jit_context *ctx)
 	case BPF_ALU | BPF_MUL | BPF_X:
 	case BPF_ALU | BPF_DIV | BPF_X:
 	case BPF_ALU | BPF_MOD | BPF_X:
-		emit_alu_r(ctx, lo(dst), lo(src), BPF_OP(code));
+		emit_alu_r(ctx, lo(dst), lo(src), BPF_OP(code), off);
 		emit_zext_ver(ctx, dst);
 		break;
 	/* dst = imm (64-bit) */
@@ -1599,7 +1608,7 @@ int build_insn(const struct bpf_insn *insn, struct jit_context *ctx)
 		 * and then do the operation on this register.
 		 */
 		emit_mov_se_i64(ctx, tmp, imm);
-		emit_divmod_r64(ctx, dst, tmp, BPF_OP(code));
+		emit_divmod_r64(ctx, dst, tmp, BPF_OP(code), off);
 		break;
 	/* dst = dst & src (64-bit) */
 	/* dst = dst | src (64-bit) */
@@ -1629,7 +1638,7 @@ int build_insn(const struct bpf_insn *insn, struct jit_context *ctx)
 	/* dst = dst % src (64-bit) */
 	case BPF_ALU64 | BPF_DIV | BPF_X:
 	case BPF_ALU64 | BPF_MOD | BPF_X:
-		emit_divmod_r64(ctx, dst, src, BPF_OP(code));
+		emit_divmod_r64(ctx, dst, src, BPF_OP(code), off);
 		break;
 	/* dst = htole(dst) */
 	/* dst = htobe(dst) */
diff --git a/arch/mips/net/bpf_jit_comp64.c b/arch/mips/net/bpf_jit_comp64.c
index 2520e1db7ab7..db027c2d9221 100644
--- a/arch/mips/net/bpf_jit_comp64.c
+++ b/arch/mips/net/bpf_jit_comp64.c
@@ -198,29 +198,42 @@ static void emit_alu_i64(struct jit_context *ctx, u8 dst, s32 imm, u8 op)
 }
 
 /* ALU division operation (64-bit) */
-static void emit_div64(struct jit_context *ctx, u8 dst, u8 src)
+static void emit_div64(struct jit_context *ctx, u8 dst, u8 src, s16 off)
 {
 	if (cpu_has_mips64r6) {
-		emit(ctx, ddivu_r6, dst, dst, src);
+		if (off == 1)
+			emit(ctx, ddiv_r6, dst, dst, src);
+		else
+			emit(ctx, ddivu_r6, dst, dst, src);
 	} else {
-		emit(ctx, ddivu, dst, src);
+		if (off == 1)
+			emit(ctx, ddiv, dst, src);
+		else
+			emit(ctx, ddivu, dst, src);
 		emit(ctx, mflo, dst);
 	}
 }
 
 /* ALU modulo operation (64-bit) */
-static void emit_mod64(struct jit_context *ctx, u8 dst, u8 src)
+static void emit_mod64(struct jit_context *ctx, u8 dst, u8 src, s16 off)
 {
 	if (cpu_has_mips64r6) {
-		emit(ctx, dmodu, dst, dst, src);
+		if (off == 1)
+			emit(ctx, dmod, dst, dst, src);
+		else
+			emit(ctx, dmodu, dst, dst, src);
 	} else {
-		emit(ctx, ddivu, dst, src);
+		if (off == 1)
+			emit(ctx, ddiv, dst, src);
+		else
+			emit(ctx, ddivu, dst, src);
 		emit(ctx, mfhi, dst);
 	}
 }
 
 /* ALU register operation (64-bit) */
-static void emit_alu_r64(struct jit_context *ctx, u8 dst, u8 src, u8 op)
+static void emit_alu_r64(struct jit_context *ctx, u8 dst, u8 src, u8 op,
+			 s16 off)
 {
 	switch (BPF_OP(op)) {
 	/* dst = dst << src */
@@ -257,15 +270,15 @@ static void emit_alu_r64(struct jit_context *ctx, u8 dst, u8 src, u8 op)
 		break;
 	/* dst = dst / src */
 	case BPF_DIV:
-		emit_div64(ctx, dst, src);
+		emit_div64(ctx, dst, src, off);
 		break;
 	/* dst = dst % src */
 	case BPF_MOD:
-		emit_mod64(ctx, dst, src);
+		emit_mod64(ctx, dst, src, off);
 		break;
 	default:
 		/* Width-generic operations */
-		emit_alu_r(ctx, dst, src, op);
+		emit_alu_r(ctx, dst, src, op, off);
 	}
 	clobber_reg(ctx, dst);
 }
@@ -686,9 +699,9 @@ int build_insn(const struct bpf_insn *insn, struct jit_context *ctx)
 	case BPF_ALU | BPF_AND | BPF_K:
 	case BPF_ALU | BPF_XOR | BPF_K:
 	case BPF_ALU | BPF_LSH | BPF_K:
-		if (!valid_alu_i(BPF_OP(code), imm)) {
+		if (!valid_alu_i(BPF_OP(code), imm, off)) {
 			emit_mov_i(ctx, MIPS_R_T4, imm);
-			emit_alu_r(ctx, dst, MIPS_R_T4, BPF_OP(code));
+			emit_alu_r(ctx, dst, MIPS_R_T4, BPF_OP(code), off);
 		} else if (rewrite_alu_i(BPF_OP(code), imm, &alu, &val)) {
 			emit_alu_i(ctx, dst, val, alu);
 		}
@@ -708,10 +721,10 @@ int build_insn(const struct bpf_insn *insn, struct jit_context *ctx)
 	case BPF_ALU | BPF_MUL | BPF_K:
 	case BPF_ALU | BPF_DIV | BPF_K:
 	case BPF_ALU | BPF_MOD | BPF_K:
-		if (!valid_alu_i(BPF_OP(code), imm)) {
+		if (!valid_alu_i(BPF_OP(code), imm, off)) {
 			emit_sext(ctx, dst, dst);
 			emit_mov_i(ctx, MIPS_R_T4, imm);
-			emit_alu_r(ctx, dst, MIPS_R_T4, BPF_OP(code));
+			emit_alu_r(ctx, dst, MIPS_R_T4, BPF_OP(code), off);
 		} else if (rewrite_alu_i(BPF_OP(code), imm, &alu, &val)) {
 			emit_sext(ctx, dst, dst);
 			emit_alu_i(ctx, dst, val, alu);
@@ -726,7 +739,7 @@ int build_insn(const struct bpf_insn *insn, struct jit_context *ctx)
 	case BPF_ALU | BPF_OR | BPF_X:
 	case BPF_ALU | BPF_XOR | BPF_X:
 	case BPF_ALU | BPF_LSH | BPF_X:
-		emit_alu_r(ctx, dst, src, BPF_OP(code));
+		emit_alu_r(ctx, dst, src, BPF_OP(code), off);
 		emit_zext_ver(ctx, dst);
 		break;
 	/* dst = dst >> src */
@@ -745,7 +758,7 @@ int build_insn(const struct bpf_insn *insn, struct jit_context *ctx)
 	case BPF_ALU | BPF_MOD | BPF_X:
 		emit_sext(ctx, dst, dst);
 		emit_sext(ctx, MIPS_R_T4, src);
-		emit_alu_r(ctx, dst, MIPS_R_T4, BPF_OP(code));
+		emit_alu_r(ctx, dst, MIPS_R_T4, BPF_OP(code), off);
 		emit_zext_ver(ctx, dst);
 		break;
 	/* dst = imm (64-bit) */
@@ -782,9 +795,9 @@ int build_insn(const struct bpf_insn *insn, struct jit_context *ctx)
 	case BPF_ALU64 | BPF_MUL | BPF_K:
 	case BPF_ALU64 | BPF_DIV | BPF_K:
 	case BPF_ALU64 | BPF_MOD | BPF_K:
-		if (!valid_alu_i(BPF_OP(code), imm)) {
+		if (!valid_alu_i(BPF_OP(code), imm, off)) {
 			emit_mov_i(ctx, MIPS_R_T4, imm);
-			emit_alu_r64(ctx, dst, MIPS_R_T4, BPF_OP(code));
+			emit_alu_r64(ctx, dst, MIPS_R_T4, BPF_OP(code), off);
 		} else if (rewrite_alu_i(BPF_OP(code), imm, &alu, &val)) {
 			emit_alu_i64(ctx, dst, val, alu);
 		}
@@ -811,7 +824,7 @@ int build_insn(const struct bpf_insn *insn, struct jit_context *ctx)
 	case BPF_ALU64 | BPF_MUL | BPF_X:
 	case BPF_ALU64 | BPF_DIV | BPF_X:
 	case BPF_ALU64 | BPF_MOD | BPF_X:
-		emit_alu_r64(ctx, dst, src, BPF_OP(code));
+		emit_alu_r64(ctx, dst, src, BPF_OP(code), off);
 		break;
 	/* dst = htole(dst) */
 	/* dst = htobe(dst) */
