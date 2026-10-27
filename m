Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.133.104.62
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793125496;
	b=5VXWw642OQHD8ulft+rwCYZMKijh7Ojx0ob51ZXBYo5M/eswkaP/hQlZdUWU5yrCaL6C
	 IKUEzBOr/+H2KA8mZ6iyXeyrW/I7BaIrdy0Cq4z46tqYGrmDDfBEiSLtEXwSyZI/+81EW
	 QzqvRPDoxCqV1TW7IRNzUfHPB1Tr60oPFYkDwNGsRbpVx4ACCsigZpxDoEMZYWGEIfwnq
	 5G93IO58qKiwn1qyCI/UX7ZQsVg+g4imXLmh5xy6p2EadfdcScr0gq3mKGQVrh/gR/L78
	 uFkg4iOg7HchMMN3LzHx5lqXMA3xC1K90IRUXYwJQyRGT/Is/0UdTfeDpKs6qyYi0ug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793125496;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Virus-Scanned;
	bh=bf8IwCkP4ytpo0RGVm+AJyjAabRwW0zVq9NPb8s3Qrk=;
	b=JF0j/NkEtzX8G7Bm0Z9uwhV9OqgGYWMVDtLpvVWLJlKcZaTGCyc0RayF2q6DKELM+ms7
	 wQ7FBmYzf0DLu5qxTVGH7lFEyptEBDuIjs0UinEyETDX/eA/NGWdwvZQA8lm3IKYfls5U
	 gfzyn+01opP6lEGO87mURGbABsfVCaqiO+C2m19OGmeQBh04Pu3NkYJ9BWwkqoX02B25e
	 Z23MwAsqeNDdC1kNLG3fqT/3kQq6IOdlekh9WmcwUfb58II2jK706vTv53uX7hzPwnAPp
	 EUoOy4qfn9Bj19psEGplk9ld5uscDEyMYL2m6hOsgAXT0USdlSSwCTz+gNrzTsrEtHw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=iogearbox.net;
	spf=pass smtp.mailfrom=iogearbox.net;
	dkim=pass header.d=iogearbox.net header.i=@iogearbox.net header.a=rsa-sha256 header.s=default2302 header.b=UWk4YZa6;
	arc=none smtp.remote-ip=213.133.104.62
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CBC860A260C
	for <bpf@vger.kernel.org>; Tue, 27 Oct 2026 18:24:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1CBC860A260C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=iogearbox.net header.i=@iogearbox.net header.a=rsa-sha256 header.s=default2302 header.b=UWk4YZa6
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=bf8IwCkP4ytpo0RGVm+AJyjAabRwW0zVq9NPb8s3Qrk=; b=UWk4YZa68WG8pYolIeMxVQ9Qvq
	9ud5s8p3hzffLIoEHGAbKazGyzL0bN5ia4X2kNZft4xTJpDniqHisfqNFbpxj0UNDGyZ+mS0W+0Zf
	MgK4gfu5jjEL2d2xlH63uHCy2tLs/JlJ40qux9KeTKkZe8JwTMBLIqndxYBs5OufG5iNJAhzYhO84
	3mSdx4OX+bqTu5Q5qt7NjDCJG0wrwzvtVzXaZMfOLdCL2lwqoLaiZYknBGE7TnSJUt8vtlEvVUw9w
	XKS9Ml7fvhZyxWpFIarAAUDBZmqThNRPxGHmzNLOTSu6OBqntXTGa2aa1mqHK+OzKiydq810O8R/o
	YcKoHm/g==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1xLlqw-000ImT-2B;
	Tue, 27 Oct 2026 19:24:54 +0100
From: Daniel Borkmann <daniel@iogearbox.net>
To: puranjay@kernel.org
Cc: memxor@gmail.com,
	ast@kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH bpf-next 15/21] bpf, arm64: Divide by constants via multiplication with a magic number
Date: Tue, 27 Oct 2026 19:24:39 +0100
Message-ID: <20261027182445.1156335-16-daniel@iogearbox.net>
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

LLVM strength-reduces 32-bit divisions by a constant into a 64-bit
multiplication, but has no high-half multiply for the 64-bit ones, so
these reach the JIT as BPF_DIV/BPF_MOD with BPF_K and were emitted as
udiv or sdiv, which take 5 to 20 cycles on Neoverse N1 through V3 and
block the one divider of the core until done, whereas umulh and smulh
take 3 cycles and issue twice per cycle on N2 and later, 5 cycles on N1.
Cilium divides by NSEC_PER_SEC this way in its monotonic clock helper,
which conntrack, NAT and the load balancer run for every entry they
stamp or check.

Emit the multiplication with a magic number from bpf_magic_udiv() and
bpf_magic_sdiv() instead, as the x86 JIT does: an unsigned division
becomes an umulh and a shift, with the sub/add/shift correction when the
magic number needs 65 bits, which an even divisor avoids by shifting the
dividend by its trailing zeros first, a signed one an smulh, an optional
add or sub of the dividend, an asr and the add of the sign bit, with the
shifts of the corrections folded into the adds. A modulo takes the
quotient back with an msub. A power of two is a shift or a mask, and in
the signed case a shift with the bias of 2^k - 1 for a negative dividend
taken from the sign mask. Divisors 0 and +-1, unsigned divisors above
2^63 (negative imm32) and the 32-bit divisions stay with udiv/sdiv.

On the dependent path the unsigned division by 100 goes from the 20
cycles that llvm-mca models for the udiv down to 5 on Neoverse N2, V1
and V2 and 7 on N1, for five more instructions, where no division takes
more than six more and no modulo more than seven. The emitted sequences
were run on qemu-system-aarch64 against the C division for the divisors
from -2100 to 2099 and random ones, signed and unsigned, with dividends
at the extremes, around the divisor and a multiple of it, and at random.

Before/after for r1 /= 1000000000:

  d299400a  mov x10, #0xca00
  f2a7734a  movk x10, #0x3b9a, lsl #16
  9aca0800  udiv x0, x0, x10

  d2e0088a  mov x10, #0x44000000000000
  f2d705ea  movk x10, #0xb82f, lsl #32
  f2b4136a  movk x10, #0xa09b, lsl #16
  f28b4a6a  movk x10, #0x5a53
  d349fc0b  lsr x11, x0, #9
  9bca7d6a  umulh x10, x11, x10
  d34bfd40  lsr x0, x10, #11

Before/after for r1 s/= 10 and r1 s/= 8:

  d280014a  mov x10, #0xa
  9aca0c00  sdiv x0, x0, x10

  b203e7ea  mov x10, #0x6666666666666666
  f28cccea  movk x10, #0x6667
  9b4a7c0a  smulh x10, x0, x10
  9342fd4a  asr x10, x10, #2
  8b4afd40  add x0, x10, x10, lsr #63

  d280010a  mov x10, #0x8
  9aca0c00  sdiv x0, x0, x10

  937ffc0a  asr x10, x0, #63
  8b4af40a  add x10, x0, x10, lsr #61
  9343fd40  asr x0, x10, #3

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 arch/arm64/net/bpf_jit.h      |   5 ++
 arch/arm64/net/bpf_jit_comp.c | 139 ++++++++++++++++++++++++++++++++++
 2 files changed, 144 insertions(+)

diff --git a/arch/arm64/net/bpf_jit.h b/arch/arm64/net/bpf_jit.h
index a6dfff8c645f..7c681a822c06 100644
--- a/arch/arm64/net/bpf_jit.h
+++ b/arch/arm64/net/bpf_jit.h
@@ -306,6 +306,11 @@
 	A64_VARIANT(sf), AARCH64_INSN_DATA3_MSUB)
 /* Rd = Rn * Rm */
 #define A64_MUL(sf, Rd, Rn, Rm) A64_MADD(sf, Rd, A64_ZR, Rn, Rm)
+/* Rd = (Rn * Rm) >> 64, unsigned and signed */
+#define A64_UMULH(Rd, Rn, Rm) aarch64_insn_gen_data3(Rd, A64_ZR, Rn, Rm, \
+	AARCH64_INSN_VARIANT_64BIT, AARCH64_INSN_DATA3_UMULH)
+#define A64_SMULH(Rd, Rn, Rm) aarch64_insn_gen_data3(Rd, A64_ZR, Rn, Rm, \
+	AARCH64_INSN_VARIANT_64BIT, AARCH64_INSN_DATA3_SMULH)
 
 /* Logical (shifted register) */
 #define A64_LOGIC_SREG(sf, Rd, Rn, Rm, type) \
diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
index b21e744dab6a..d14a5cf6e032 100644
--- a/arch/arm64/net/bpf_jit_comp.c
+++ b/arch/arm64/net/bpf_jit_comp.c
@@ -593,6 +593,141 @@ static bool adjust_cmp_imm(u8 *op, s32 *imm)
 	return true;
 }
 
+/*
+ * Divide dst by the immediate of a 64-bit division through a multiplication
+ * with the magic number from bpf_magic_udiv() or bpf_magic_sdiv(): the high
+ * half of the product from umulh or smulh, shifted, with the corrections per
+ * Hacker's Delight. The quotient is built in tmp with tmp2 as scratch, the
+ * dividend stays in dst until a modulo takes the quotient back with msub.
+ * Returns false for the divisors left to udiv and sdiv.
+ */
+static bool emit_div_const(const struct bpf_insn *insn, struct jit_ctx *ctx)
+{
+	const bool is_mod = BPF_OP(insn->code) == BPF_MOD;
+	const bool is_signed = insn->off == 1;
+	const u8 dst = bpf2a64[insn->dst_reg];
+	const u8 tmp = bpf2a64[TMP_REG_1];
+	const u8 tmp2 = bpf2a64[TMP_REG_2];
+	const u8 q = is_mod ? tmp : dst;
+	const s32 imm = insn->imm;
+	struct bpf_div_magic mag;
+	int corr = 0, pre = 0, s;
+
+	if (is_signed) {
+		const u64 ad = imm < 0 ? -(u64)(s64)imm : imm;
+
+		/* |d| >= 2, the verifier already rewrote d == -1 */
+		if (imm >= -1 && imm <= 1)
+			return false;
+		/*
+		 * By a power of two with shifts: 2^k - 1 added to a negative
+		 * dividend rounds the arithmetic shift toward zero, the bias
+		 * is the low k bits of the sign mask, the sign bit itself for
+		 * k = 1. The modulo clears the low k bits of the biased
+		 * dividend for the multiple to subtract. A negative divisor
+		 * negates the quotient off the shift and keeps the remainder.
+		 */
+		if (is_power_of_2(ad)) {
+			const int k = ilog2(ad);
+
+			if (k == 1) {
+				emit(A64_ADD_LSR(1, tmp, dst, dst, 63), ctx);
+			} else {
+				emit(A64_ASR(1, tmp, dst, 63), ctx);
+				emit(A64_ADD_LSR(1, tmp, dst, tmp, 64 - k), ctx);
+			}
+			if (is_mod) {
+				emit(A64_AND_I(1, tmp, tmp, ~(ad - 1)), ctx);
+				emit(A64_SUB(1, dst, dst, tmp), ctx);
+			} else if (imm > 0) {
+				emit(A64_ASR(1, dst, tmp, k), ctx);
+			} else {
+				emit(A64_SUB_ASR(1, dst, A64_ZR, tmp, k), ctx);
+			}
+			return true;
+		}
+		bpf_magic_sdiv(imm, &mag);
+		/* q += n for d > 0 and m < 0, q -= n for d < 0 and m > 0 */
+		if (imm > 0 && (s64)mag.m < 0)
+			corr = 1;
+		else if (imm < 0 && (s64)mag.m > 0)
+			corr = -1;
+	} else {
+		/* d >= 2, a negative imm is a divisor above 2^63 */
+		if (imm < 2)
+			return false;
+		if (is_power_of_2(imm)) {
+			if (is_mod)
+				emit(A64_AND_I(1, dst, dst, imm - 1), ctx);
+			else
+				emit(A64_LSR(1, dst, dst, ilog2(imm)), ctx);
+			return true;
+		}
+		bpf_magic_udiv(imm, 0, &mag);
+		/*
+		 * Shift the dividend by the trailing zeros of an even divisor
+		 * first, the magic number of the odd part then fits without
+		 * the add sequence.
+		 */
+		if (mag.add && !(imm & 1)) {
+			pre = __ffs(imm) & 31;
+			bpf_magic_udiv(imm >> pre, pre, &mag);
+			if (mag.add)
+				return false;
+		}
+	}
+	s = mag.s;
+	/*
+	 * The shift is at most 63, or 64 with the add sequence which shifts
+	 * by s - 1 and needs s >= 1. Never hit for d >= 2, kept as a guard
+	 * against an unencodable count.
+	 */
+	if (s > 64 - !mag.add || (mag.add && !s))
+		return false;
+
+	/* tmp = mulh(n >> pre, m) */
+	emit_a64_mov_i64(tmp, mag.m, ctx);
+	if (pre) {
+		emit(A64_LSR(1, tmp2, dst, pre), ctx);
+		emit(A64_UMULH(tmp, tmp2, tmp), ctx);
+	} else if (is_signed) {
+		emit(A64_SMULH(tmp, dst, tmp), ctx);
+	} else {
+		emit(A64_UMULH(tmp, dst, tmp), ctx);
+	}
+
+	if (is_signed) {
+		if (corr > 0)
+			emit(A64_ADD(1, tmp, tmp, dst), ctx);
+		else if (corr < 0)
+			emit(A64_SUB(1, tmp, tmp, dst), ctx);
+		if (s)
+			emit(A64_ASR(1, tmp, tmp, s), ctx);
+		/* q += q >>> 63 */
+		emit(A64_ADD_LSR(1, q, tmp, tmp, 63), ctx);
+	} else if (!mag.add) {
+		if (s)
+			emit(A64_LSR(1, q, tmp, s), ctx);
+		else if (q != tmp)
+			emit(A64_MOV(1, q, tmp), ctx);
+	} else {
+		/* q = (((n - t) >> 1) + t) >> (s - 1) */
+		emit(A64_SUB(1, tmp2, dst, tmp), ctx);
+		emit(A64_ADD_LSR(1, tmp, tmp, tmp2, 1), ctx);
+		if (s > 1)
+			emit(A64_LSR(1, q, tmp, s - 1), ctx);
+		else if (q != tmp)
+			emit(A64_MOV(1, q, tmp), ctx);
+	}
+
+	if (is_mod) {
+		/* dst = n - q * d */
+		emit_a64_mov_i(1, tmp2, imm, ctx);
+		emit(A64_MSUB(1, dst, dst, tmp, tmp2), ctx);
+	}
+	return true;
+}
+
 /* generated main prog prologue:
  *      bti c // if CONFIG_ARM64_BTI_KERNEL
  *      mov x9, lr
@@ -1930,6 +2065,8 @@ static int build_insn(const struct bpf_verifier_env *env, const struct bpf_insn
 		break;
 	case BPF_ALU | BPF_DIV | BPF_K:
 	case BPF_ALU64 | BPF_DIV | BPF_K:
+		if (is64 && emit_div_const(insn, ctx))
+			break;
 		emit_a64_mov_i(is64, tmp, imm, ctx);
 		if (!off)
 			emit(A64_UDIV(is64, dst, dst, tmp), ctx);
@@ -1938,6 +2075,8 @@ static int build_insn(const struct bpf_verifier_env *env, const struct bpf_insn
 		break;
 	case BPF_ALU | BPF_MOD | BPF_K:
 	case BPF_ALU64 | BPF_MOD | BPF_K:
+		if (is64 && emit_div_const(insn, ctx))
+			break;
 		emit_a64_mov_i(is64, tmp2, imm, ctx);
 		if (!off)
 			emit(A64_UDIV(is64, tmp, dst, tmp2), ctx);
-- 
2.43.0

