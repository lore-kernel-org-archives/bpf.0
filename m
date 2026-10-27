Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.133.104.62
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793125497;
	b=TWZhHCY0xDOoiICLgxr+g2QZGb4JIJb7iPv4WF3utnwOQ/sU9orZqZLSbsKpNSJf8Ky/
	 2vnxJ7Xk19dAAuFEBQkwQ3axogR0iHH3+vS65Fxz9EHDox/VZAmc4+0N9G6NDNTGWH50/
	 1/HGqxdLdVmMMSrgfz+W+jN/RI6ZyUlcVCcGXBQJcy/OExcUz1omED9g/rv2pN2ccKeqc
	 gHTnF3oP6bF+oU78ra4ja2A4fhOADJv4Y4BGOZa8JORXRhwtbeij67viHU9gm8ygB8pWj
	 nCbVtTP0XOCjB8pxaoucjZ/rmae1ayItBcDKIDqLdJTKHVjHP/uR7fAxjRgmSaS7cIA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793125497;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Virus-Scanned;
	bh=pogH7MaxX81LVoe9JFBh0t2gs21FBFtWlqG07AmSFMM=;
	b=kFMjJwik530ExuISY5z5I1Sz/SBA5RzArviI5aFnAPSzoIWUIEeXOiOtyo5BZwh5JmLd
	 Z0WMwhCiAYKB8mNkZRAbFmRzLVq49xiEhb+RrEImzZlzEGeg7ME0auYvKlrPj1dEmHtyy
	 V6CYstLqssC7MDQZAPg88edukAoWYWLCP9h/EBVUv/XGbvwTMQxTPZV2mfGaRxBn/ELlF
	 TaGblmSFkVub1h40gVKh4grR4URdZpi6ENK+RMJLBitumdB64Tg0HEGYHFZlkqQi9A99e
	 R9TOOSIfR+qnVtFC6QeL+ip6yuazJZ7JeMW+EgIHI8GTaloYS3dXFpnfmfAfP5grdRg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=iogearbox.net;
	spf=pass smtp.mailfrom=iogearbox.net;
	dkim=pass header.d=iogearbox.net header.i=@iogearbox.net header.a=rsa-sha256 header.s=default2302 header.b="K5WHh/IR";
	arc=none smtp.remote-ip=213.133.104.62
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A713606A331
	for <bpf@vger.kernel.org>; Tue, 27 Oct 2026 18:24:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7A713606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=iogearbox.net header.i=@iogearbox.net header.a=rsa-sha256 header.s=default2302 header.b=K5WHh/IR
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=pogH7MaxX81LVoe9JFBh0t2gs21FBFtWlqG07AmSFMM=; b=K5WHh/IR1OxnbRlgILdgfJVG73
	CGyZfziiRY3qlm+GpvTv+WCfvPoBz54IbGK1Mm+OlnwhaHG5D7AE6GXWVeMvww43GW12yvFMiuZcw
	0TSDG0iVxmOZUrCFCxgb7FMcti3hC7I3lu2GY5YsK6EcO6b6l7RA2YrARTCJAx4exEPXCxOAsImSU
	9AMF/GqIYqKEdZwbmKmA0brkt+fzdJV8Hl45cNYQJ/maTcOrPo8i/glWCeDtU1FLdvbkAaxjK/pk+
	TLvxpDQVkkGP3SioLQIaqUvErZZGy9G3Atnbzpp2BJ9UbsfPVjX4itaNYbLDaT0NuEzjURdpfCKh2
	nPaddi6Q==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1xLlqy-000Imx-0C;
	Tue, 27 Oct 2026 19:24:56 +0100
From: Daniel Borkmann <daniel@iogearbox.net>
To: puranjay@kernel.org
Cc: memxor@gmail.com,
	ast@kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH bpf-next 18/21] bpf, arm64: Multiply by constants with shifts, adds and subs
Date: Tue, 27 Oct 2026 19:24:42 +0100
Message-ID: <20261027182445.1156335-19-daniel@iogearbox.net>
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

LLVM turns a multiplication by a power of two into a shift, but keeps
the other constants as a multiplication, so these reach the JIT as
BPF_MUL with BPF_K and were emitted as a move of the constant and a mul,
which takes two cycles on Neoverse N2 and later and four for the 64-bit
form on N1. Emit shifts, adds and subs instead: by 2^n a shift, by
2^n + 1 an add of the register shifted left, by 2^n - 1 a shift and a
sub, each also negated and, but for the negated 2^n + 1, times 2^m, at
most two instructions. A shifted operand beyond four takes a cycle more
than one up to four on N1 through V3, so only the forms of at most two
cycles are taken, which never fall behind the mul, and the other
constants keep it. The multiplication by 0 is a move, by -1 a negation
and by 1 nothing beyond the zero extension of the 32-bit form.

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
 arch/arm64/net/bpf_jit_comp.c | 93 ++++++++++++++++++++++++++++++++++-
 1 file changed, 91 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
index 08b95e3acaab..5995b925b900 100644
--- a/arch/arm64/net/bpf_jit_comp.c
+++ b/arch/arm64/net/bpf_jit_comp.c
@@ -832,6 +832,93 @@ static bool emit_div_const(const struct bpf_insn *insn, struct jit_ctx *ctx)
 	return true;
 }
 
+/*
+ * Multiply dst by a constant with shifts, adds and subs, at most two
+ * instructions where the move of the constant and the multiply are two slower
+ * ones: by 2^n a shift, by 2^n + 1 an add of the shifted register, by 2^n - 1
+ * a shift and a sub, each also negated and, but for the negated 2^n + 1,
+ * times 2^m. The multiply takes two cycles on Neoverse N2 and later and a
+ * shifted operand beyond four a cycle more than one by up to four on N1
+ * through V3, so only the forms of two cycles at most are taken, which never
+ * fall behind the multiply. The sign of the 32-bit constant serves the low 32
+ * bits of the product as well as its unsigned value. Returns false for the
+ * constants left to mul.
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
@@ -2182,8 +2269,10 @@ static int build_insn(const struct bpf_verifier_env *env, const struct bpf_insn
 		break;
 	case BPF_ALU | BPF_MUL | BPF_K:
 	case BPF_ALU64 | BPF_MUL | BPF_K:
-		emit_a64_mov_i(is64, tmp, imm, ctx);
-		emit(A64_MUL(is64, dst, dst, tmp), ctx);
+		if (!emit_mul_const(is64, dst, tmp, imm, ctx)) {
+			emit_a64_mov_i(is64, tmp, imm, ctx);
+			emit(A64_MUL(is64, dst, dst, tmp), ctx);
+		}
 		break;
 	case BPF_ALU | BPF_DIV | BPF_K:
 	case BPF_ALU64 | BPF_DIV | BPF_K:
-- 
2.43.0

