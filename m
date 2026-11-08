Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.133.104.62
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794166117;
	b=pcngYvsGRod07ivhgV8h1kqA6ikaBPNw5nuuuWNpmLeCDG4Dpwnzrq4kslvvIVpHZwp5
	 UcuxPauZ0+n9MVIFumkLXYV1WgUDrnORvSmZGo8d4o/3xBYeley6upCslqBOOvUH5RB45
	 JHXOlHEehL6azjj5TBm9a2DIwDoDcnNTiNfJMm5TwTW/bbdK6KRxqfqO6CQ0OOiyFtwky
	 l+gBzK6JjeuV0soNzTNyLMos85RMDJWzCq/6P8E37NqCklvLJVJ3sNmXnwVtnF3hIajv3
	 Gc9AQQ50sMq70uo6QoGdozbPz/jeSyjXc1/5Kqu0rzoPF9JpyaPqEIxdS3Ou6nUAUmQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794166117;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Virus-Scanned;
	bh=5fhWDWDq2+wyRkVopuIWVXtvtkpDy+j7OmGI8JMHEww=;
	b=3aTB1TyzV6M7HCSHu657fxna4FVFhAhqISbUoV7Xg1/5BlsrvsyJBZJxoCeylOWwYWl3
	 A8CduVuYR9m6MKMwY4mVrvojKQ02otJLCM4cjNQxu+7zA2FPIdzsQyggjgTvhKXAtxoAD
	 jvAEfdFk8g8fhsmdlEmegBhVRJtLXUo5+i4GYhoJ7bNM27R61I8Pfr8trCXNlIYVtZwqm
	 2oovDvs3yIaHQmEpKxgzJmSkQ+NFBQeGDccd7FGi34imcN0sieynffR7gL1M+9y3405r1
	 Ewc3yvoOxtT93EWBhdQ+0qNOVNiafal2AmDUNGQN84juhSTI2atM8yKvSpeLojxTF6w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=iogearbox.net;
	spf=pass smtp.mailfrom=iogearbox.net;
	dkim=pass header.d=iogearbox.net header.i=@iogearbox.net header.a=rsa-sha256 header.s=default2302 header.b=q4oRYRYR;
	arc=none smtp.remote-ip=213.133.104.62
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4DFD606A31C
	for <bpf@vger.kernel.org>; Sun,  8 Nov 2026 19:28:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C4DFD606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.a=rsa-sha256 header.s=default2302 header.b=q4oRYRYR
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=5fhWDWDq2+wyRkVopuIWVXtvtkpDy+j7OmGI8JMHEww=; b=q4oRYRYRhitDIiw0jD/06B4rrc
	y645wSjmeIGTktx9fKH2aA5gIVLwstvXF0ouHpHRwYphcF2OO6u7LOctd1EOyYr0ieUjQE+PlYLij
	rtlaTopoHsHfvLqgmoSV8dCpfmAOydW95dbt0K5wLh5dMRxR84fT3rwpO68895JY0j++dxOW1iT+L
	I3EOihevrmRB09X6XvdoIyKZExoPvEvM8ub1gFawZ68XSsoKHUZNhs5K13HklbCmNC4hXS2/zNpvO
	0ActlhHa0b/8sXrlWWDAeXPj0/aIi22OIy+7xDlLcGLh+U5+iAHlQxnfF9nbyplyn9AYAsW7Y+3sF
	Jdkkn5Lw==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1xQ8Z8-000PtN-2B;
	Sun, 08 Nov 2026 20:28:35 +0100
From: Daniel Borkmann <daniel@iogearbox.net>
To: ast@kernel.org
Cc: puranjay@kernel.org,
	memxor@gmail.com,
	xukuohai@huaweicloud.com,
	bpf@vger.kernel.org
Subject: [PATCH bpf-next v3 21/24] bpf, arm64: Multiply by constants with shifts, adds and subs
Date: Sun,  8 Nov 2026 20:26:47 +0100
Message-ID: <58268de43cde336b82eaf7ac27b26cea7bcf299c.1794165614.git.daniel@iogearbox.net>
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

LLVM leaves a multiplication by a constant other than a power of two as
is, and the JIT emitted it as a mov of the constant and a mul of two to
four cycles.

For constants of the form 2^n, 2^n + 1 or 2^n - 1, optionally negated
or multiplied by 2^m, emit at most two shifts, adds or subs instead.
Only sequences of at most two cycles are used, so they are never slower
than the mul.

A multiplication by 0 becomes a mov, by -1 a neg, and by 1 nothing
beyond the zero extension of the 32-bit variant.

Before/after for r1 *= 3, r1 *= 7 and r1 *= 24:

  d280006a  mov x10, #0x3
  9b0a7c00  mul x0, x0, x10
  8b000400  add x0, x0, x0, lsl #1

  d28000ea  mov x10, #0x7
  9b0a7c00  mul x0, x0, x10
  d37df00a  lsl x10, x0, #3
  cb000140  sub x0, x10, x0

  d280030a  mov x10, #0x18
  9b0a7c00  mul x0, x0, x10
  8b000400  add x0, x0, x0, lsl #1
  d37df000  lsl x0, x0, #3

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 arch/arm64/net/bpf_jit.h      | 12 ++++-
 arch/arm64/net/bpf_jit_comp.c | 86 ++++++++++++++++++++++++++++++++++-
 2 files changed, 94 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/net/bpf_jit.h b/arch/arm64/net/bpf_jit.h
index 7566698a38a8..3bc88db350f7 100644
--- a/arch/arm64/net/bpf_jit.h
+++ b/arch/arm64/net/bpf_jit.h
@@ -227,11 +227,19 @@
 #define A64_MOVK(sf, Rd, imm16, shift) A64_MOVEW(sf, Rd, imm16, shift, KEEP)
 
 /* Add/subtract (shifted register) */
-#define A64_ADDSUB_SREG(sf, Rd, Rn, Rm, type) \
-	aarch64_insn_gen_add_sub_shifted_reg(Rd, Rn, Rm, 0, \
+#define A64_ADDSUB_SHIFT(sf, Rd, Rn, Rm, shift, type) \
+	aarch64_insn_gen_add_sub_shifted_reg(Rd, Rn, Rm, shift, \
 		A64_VARIANT(sf), AARCH64_INSN_ADSB_##type)
+#define A64_ADDSUB_SREG(sf, Rd, Rn, Rm, type) \
+	A64_ADDSUB_SHIFT(sf, Rd, Rn, Rm, 0, type)
 /* Rd = Rn OP Rm */
 #define A64_ADD(sf, Rd, Rn, Rm)  A64_ADDSUB_SREG(sf, Rd, Rn, Rm, ADD)
+/* Rd = Rn + (Rm << shift) */
+#define A64_ADD_LSL(sf, Rd, Rn, Rm, shift) \
+	A64_ADDSUB_SHIFT(sf, Rd, Rn, Rm, shift, ADD)
+/* Rd = Rn - (Rm << shift) */
+#define A64_SUB_LSL(sf, Rd, Rn, Rm, shift) \
+	A64_ADDSUB_SHIFT(sf, Rd, Rn, Rm, shift, SUB)
 #define A64_SUB(sf, Rd, Rn, Rm)  A64_ADDSUB_SREG(sf, Rd, Rn, Rm, SUB)
 #define A64_SUBS(sf, Rd, Rn, Rm) A64_ADDSUB_SREG(sf, Rd, Rn, Rm, SUB_SETFLAGS)
 /* Rd = -Rm */
diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
index 53b2647c6a1b..b8d765d6ab07 100644
--- a/arch/arm64/net/bpf_jit_comp.c
+++ b/arch/arm64/net/bpf_jit_comp.c
@@ -693,6 +693,86 @@ static bool emit_tb(bool nonzero, u8 reg, int bit, int i, s16 off, struct jit_ct
 	return true;
 }
 
+/*
+ * dst *= 2^n, 2^n + 1 or 2^n - 1, negated or, but for -(2^n + 1), times 2^m,
+ * in at most two shifts, adds or subs of two cycles, never slower than the
+ * mul. The low 32 bits of the product are those of the signed or unsigned imm.
+ */
+static bool emit_mul_const(bool is64, u8 dst, u8 tmp, s32 imm, struct jit_ctx *ctx)
+{
+	u64 c = imm < 0 ? -(u64)(s64)imm : imm;
+	int tz, n;
+
+	switch (imm) {
+	case 0:
+		emit_a64_mov_i(is64, dst, 0, ctx);
+		return true;
+	case 1:
+		/* The 32-bit variant still zero extends */
+		if (!is64)
+			emit(A64_MOV(0, dst, dst), ctx);
+		return true;
+	case -1:
+		emit(A64_NEG(is64, dst, dst), ctx);
+		return true;
+	}
+	/* The odd part of the magnitude and the power of two taken off it */
+	tz = __ffs(c);
+	c >>= tz;
+	if (c == 1) {
+		if (imm > 0)
+			emit(A64_LSL(is64, dst, dst, tz), ctx);
+		else
+			emit(A64_SUB_LSL(is64, dst, A64_ZR, dst, tz), ctx);
+		return true;
+	}
+	if (imm > 0) {
+		if (is_power_of_2(c - 1)) {
+			n = ilog2(c - 1);
+			/* The add of two cycles and the shift, three */
+			if (n > 4 && tz)
+				return false;
+			emit(A64_ADD_LSL(is64, dst, dst, dst, n), ctx);
+			if (tz)
+				emit(A64_LSL(is64, dst, dst, tz), ctx);
+			return true;
+		}
+		if (is_power_of_2(c + 1)) {
+			n = ilog2(c + 1);
+			/* The shift and the sub of two cycles, three */
+			if (tz > 4)
+				return false;
+			emit(A64_LSL(is64, tmp, dst, n + tz), ctx);
+			emit(A64_SUB_LSL(is64, dst, tmp, dst, tz), ctx);
+			return true;
+		}
+	} else {
+		if (is_power_of_2(c + 1)) {
+			n = ilog2(c + 1);
+			if (!tz) {
+				emit(A64_SUB_LSL(is64, dst, dst, dst, n), ctx);
+				return true;
+			}
+			/* The shift and the sub of two cycles, three */
+			if (n + tz > 4)
+				return false;
+			emit(A64_LSL(is64, tmp, dst, tz), ctx);
+			emit(A64_SUB_LSL(is64, dst, tmp, dst, n + tz), ctx);
+			return true;
+		}
+		if (!tz && is_power_of_2(c - 1)) {
+			n = ilog2(c - 1);
+			/* The add of two cycles and the neg, three */
+			if (n > 4)
+				return false;
+			emit(A64_ADD_LSL(is64, dst, dst, dst, n), ctx);
+			emit(A64_NEG(is64, dst, dst), ctx);
+			return true;
+		}
+	}
+	return false;
+}
+
 /* generated main prog prologue:
  *      bti c // if CONFIG_ARM64_BTI_KERNEL
  *      mov x9, lr
@@ -2049,8 +2129,10 @@ static int build_insn(const struct bpf_verifier_env *env, const struct bpf_insn
 		break;
 	case BPF_ALU | BPF_MUL | BPF_K:
 	case BPF_ALU64 | BPF_MUL | BPF_K:
-		emit_a64_mov_i(is64, tmp, imm, ctx);
-		emit_a64_mul(is64, dst, tmp, off, ctx);
+		if (off || !emit_mul_const(is64, dst, tmp, imm, ctx)) {
+			emit_a64_mov_i(is64, tmp, imm, ctx);
+			emit_a64_mul(is64, dst, tmp, off, ctx);
+		}
 		break;
 	case BPF_ALU | BPF_DIV | BPF_K:
 	case BPF_ALU64 | BPF_DIV | BPF_K:
-- 
2.43.0

