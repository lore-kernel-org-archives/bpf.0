Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6CE65012A5
	for <bpf@vger.kernel.org>; Tue, 13 Oct 2026 17:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791913241; cv=none; b=U2hfFLXzDKDeNOlmn4RWNqPhNwMT9drROe3MxOdhKymT1+3t0rJx91fSfuaXw1xuW8SPbJFUVMD9ljfgb6rY3TJwLwGnT4l+RPSDUBcLgZ44+FQkVp2hjyp7Q3Zt8DfbIU0KqrirXgikMY8YC+MwRlzZLu7lkPQGmb7OFZ4mRSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791913241; c=relaxed/simple;
	bh=4OgcjQ+WdHkFpXOMNqV4v7rvWDwG9ADfvLX4wykpDk0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DUKFrT81bk3ZrwFGsJGsng1NvbfeM89jZDKSJASmr2yE3iAkrlT2gi7ztHq3uuE8dfMdROFG2o6m7AmeNb//cgJbvxfDoQKkWdsFpyCC6+vihQI9YZnuD63+6e5V5gMvNJc0tH1JJzB7Y9o5g0RuZOWw/lkGS+NcaEbO4b9SZUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=nQnLKl+D; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="nQnLKl+D"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=Eeg1ZAllSpunZgXOac3YvgUPqKMySENgt2I2CbYjPR4=; b=nQnLKl+Ds9BgclElXRvcY4u5cM
	qpiy/XHaOjCgby5TCEi61+O2pWiWfQHw+EtC5OjC89chHlLruuCjQvQbhwYeHYyT1NLQmT1Q4RWie
	aEuhvrn+fEkddPLpYrjXOOwHk7ADdLZQIUwrsNPaPDpUh+spsXiYULWzTgmNmIV+y9CToomm7+VHl
	OlVcOJwPlH58oRD7stLPkr7mBRgCyozTxG+GnZ5Vwb0qxMUeKS851/1+nNVj3UYyC7yP8kCZNUFI1
	iSZpf1n57pFU0+ebVhIWwvQ3kn2UEIWbrwqTzdBzei4XY9jrjglhpwE6l7QtzAy/grbmuo2va8Wt9
	FT08aw6g==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1xGg3K-000PRk-1w;
	Tue, 13 Oct 2026 19:12:38 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: alexei.starovoitov@gmail.com
Cc: memxor@gmail.com,
	yonghong.song@linux.dev,
	puranjay@kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH bpf-next 13/18] bpf, x86: Divide by constants via multiplication with a magic number
Date: Tue, 13 Oct 2026 19:12:25 +0200
Message-ID: <20261013171230.523677-14-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261013171230.523677-1-daniel@iogearbox.net>
References: <20261013171230.523677-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/28152/Tue Oct 13 08:26:14 2026)

LLVM strength-reduces 32-bit divisions by a constant into a 64-bit
multiplication, but has no high-half multiply for the 64-bit ones, so
these reach the JIT as BPF_DIV/BPF_MOD with BPF_K and were emitted as
div or idiv, which take 20-100 cycles on Intel before Ice Lake, about
15 cycles on Ice Lake and later, and 9-19 cycles on AMD Zen 3-5,
whereas a mul is 3 to 4 cycles on all current cores.

Emit the multiplication with a magic number instead, with the constants
computed per Hacker's Delight, 2nd ed., figures 10-1 and 10-2, which is
also what compilers do for native code: an unsigned division becomes a
mul plus a shift, or plus a sub/shr/add/shr sequence when the magic
number needs 65 bits, which an even divisor avoids by shifting the
dividend by its trailing zeros first, a signed one an imul, an optional
add or sub of the dividend, a sar and the sign bit adjustment. A modulo
multiplies the quotient back and subtracts it from the dividend.
Divisors 0 and +-1 as well as unsigned divisors above 2^63 (negative
imm32) are left to div/idiv as before, and so are the 32-bit divisions.

The magic numbers were validated in user space against the bounds from
Hacker's Delight for every divisor an imm32 can hold, in both
signednesses, and the emitted sequences were executed with dividends
around every multiple boundary of the divisor, at the extremes and at
random.

Before, for r1 /= 1000:

  50                             pushq %rax
  52                             pushq %rdx
  49 c7 c3 e8 03 00 00           movq $0x3e8,%r11
  48 89 f8                       movq %rdi,%rax
  31 d2                          xorl %edx,%edx
  49 f7 f3                       divq %r11
  48 89 c7                       movq %rax,%rdi
  5a                             popq %rdx
  58                             popq %rax

After:

  50                             pushq %rax
  52                             pushq %rdx
  48 89 f8                       movq %rdi,%rax
  48 c1 e8 03                    shrq $0x3,%rax
  49 bb cf f7 53 e3 a5 9b c4 20  movabsq $0x20c49ba5e353f7cf,%r11
  49 f7 e3                       mulq %r11
  48 c1 ea 04                    shrq $0x4,%rdx
  48 89 d7                       movq %rdx,%rdi
  5a                             popq %rdx
  58                             popq %rax

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 arch/x86/net/bpf_jit_comp.c | 219 +++++++++++++++++++++++++++++++++++-
 1 file changed, 218 insertions(+), 1 deletion(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 564cead6eab7..4e9c6bbe93d0 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -1923,6 +1923,218 @@ static void emit_shiftx(u8 **pprog, u32 dst_reg, u8 src_reg, bool is64, u8 op)
 	*pprog = prog;
 }
 
+struct bpf_div_magic {
+	u64 m;		/* multiplier, sign extended for signed division */
+	int s;		/* shift of the high half of the product */
+	bool add;	/* multiplier has 65 bits, use the add sequence */
+};
+
+/*
+ * Multiplier and shift for an unsigned division by the constant d, with
+ * 2 <= d < 2^64 and a dividend below 2^(64 - lz): n / d == (mulhu(n, m)
+ * >> s), or with the add sequence when m needs 65 bits, (((n - t) >> 1)
+ * + t) >> (s - 1) with t = mulhu(n, m). Hacker's Delight, 2nd ed., figure
+ * 10-2.
+ */
+static void bpf_magic_udiv(u64 d, int lz, struct bpf_div_magic *mag)
+{
+	u64 mask = ~0ULL >> lz;
+	u64 nc, delta, q1, r1, q2, r2;
+	int p;
+
+	mag->add = false;
+	/* Largest value with nc mod d == d - 1 */
+	nc = mask - (mask % d + 1) % d;
+	p = 63;
+	q1 = (1ULL << 63) / nc;			/* 2^p / nc */
+	r1 = (1ULL << 63) - q1 * nc;		/* 2^p mod nc */
+	q2 = (~0ULL >> 1) / d;			/* (2^p - 1) / d */
+	r2 = (~0ULL >> 1) - q2 * d;		/* (2^p - 1) mod d */
+	do {
+		p++;
+		if (r1 >= nc - r1) {
+			q1 = 2 * q1 + 1;
+			r1 = 2 * r1 - nc;
+		} else {
+			q1 = 2 * q1;
+			r1 = 2 * r1;
+		}
+		if (r2 + 1 >= d - r2) {
+			if (q2 >= (~0ULL >> 1))
+				mag->add = true;
+			q2 = 2 * q2 + 1;
+			r2 = 2 * r2 + 1 - d;
+		} else {
+			if (q2 >= (1ULL << 63))
+				mag->add = true;
+			q2 = 2 * q2;
+			r2 = 2 * r2 + 1;
+		}
+		delta = d - 1 - r2;
+	} while (p < 128 && (q1 < delta || (q1 == delta && r1 == 0)));
+
+	mag->m = q2 + 1;
+	mag->s = p - 64;
+}
+
+/*
+ * Multiplier and shift for a signed division by the constant d, with
+ * 2 <= |d| < 2^63: q = mulhs(n, m), q += n if d > 0 and m < 0, q -= n
+ * if d < 0 and m > 0, q >>= s (arithmetic), n / d == q + (q >>> 63).
+ * Hacker's Delight, 2nd ed., figure 10-1.
+ */
+static void bpf_magic_sdiv(s64 d, struct bpf_div_magic *mag)
+{
+	u64 ad = d < 0 ? -(u64)d : (u64)d;
+	u64 t, anc, delta, q1, r1, q2, r2;
+	int p;
+
+	t = (1ULL << 63) + (d < 0);
+	anc = t - 1 - t % ad;			/* |nc| */
+	p = 63;
+	q1 = (1ULL << 63) / anc;		/* 2^p / |nc| */
+	r1 = (1ULL << 63) - q1 * anc;		/* 2^p mod |nc| */
+	q2 = (1ULL << 63) / ad;			/* 2^p / |d| */
+	r2 = (1ULL << 63) - q2 * ad;		/* 2^p mod |d| */
+	do {
+		p++;
+		q1 = 2 * q1;
+		r1 = 2 * r1;
+		if (r1 >= anc) {
+			q1++;
+			r1 -= anc;
+		}
+		q2 = 2 * q2;
+		r2 = 2 * r2;
+		if (r2 >= ad) {
+			q2++;
+			r2 -= ad;
+		}
+		delta = ad - r2;
+	} while (q1 < delta || (q1 == delta && r1 == 0));
+
+	mag->m = q2 + 1;
+	if (d < 0)
+		mag->m = -mag->m;
+	mag->s = p - 64;
+	mag->add = false;
+}
+
+/*
+ * Divide dst_reg by the constant in insn->imm of a 64-bit division through
+ * a multiplication with the magic number from bpf_magic_udiv() or
+ * bpf_magic_sdiv(). The dividend goes through rax and the multiplier
+ * through r11, the caller saves rax and rdx unless they are dst_reg, and
+ * r10 is scratch. Returns false for the divisors left to div/idiv.
+ */
+static bool emit_div_const(u8 **pprog, const struct bpf_insn *insn, u32 dst_reg)
+{
+	bool is_mod = BPF_OP(insn->code) == BPF_MOD;
+	bool is_signed = insn->off == 1;
+	u32 n_reg = dst_reg, q_reg;
+	s32 imm32 = insn->imm;
+	struct bpf_div_magic mag;
+	u8 *prog = *pprog;
+	int corr = 0, pre = 0, s;
+
+	if (is_signed) {
+		/* |d| >= 2, the verifier already rewrote d == -1 */
+		if (imm32 >= -1 && imm32 <= 1)
+			return false;
+		bpf_magic_sdiv(imm32, &mag);
+		/* q += n for d > 0 and m < 0, q -= n for d < 0 and m > 0 */
+		if (imm32 > 0 && (s64)mag.m < 0)
+			corr = 1;
+		else if (imm32 < 0 && (s64)mag.m > 0)
+			corr = -1;
+	} else {
+		/* d >= 2, a negative imm32 is a divisor above 2^63 */
+		if (imm32 < 2)
+			return false;
+		bpf_magic_udiv(imm32, 0, &mag);
+		/*
+		 * Shift the dividend by the trailing zeros of an even divisor
+		 * first, the magic number of the odd part then fits without
+		 * the add sequence.
+		 */
+		if (mag.add && !(imm32 & 1)) {
+			pre = __ffs(imm32);
+			bpf_magic_udiv(imm32 >> pre, pre, &mag);
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
+	/* Keep the dividend when the multiplication clobbers it */
+	if ((is_mod || mag.add || corr) &&
+	    (dst_reg == BPF_REG_0 || dst_reg == BPF_REG_3)) {
+		emit_mov_reg(&prog, true, BPF_REG_AX, dst_reg);
+		n_reg = BPF_REG_AX;
+	}
+
+	/* mov rax, dst_reg; shr rax, pre; mov r11, m; mul r11 or imul r11 */
+	if (dst_reg != BPF_REG_0)
+		emit_mov_reg(&prog, true, BPF_REG_0, dst_reg);
+	if (pre)
+		emit_shift_imm(&prog, BPF_RSH, BPF_REG_0, pre, true);
+	emit_mov_imm64(&prog, AUX_REG, mag.m >> 32, (u32)mag.m);
+	EMIT3(0x49, 0xF7, is_signed ? 0xEB : 0xE3);
+	if (is_signed) {
+		/* add rdx, n_reg or sub rdx, n_reg */
+		if (corr)
+			emit_alu_reg(&prog, corr > 0 ? BPF_ADD : BPF_SUB,
+				     BPF_REG_3, n_reg, true);
+		/* sar rdx, s */
+		if (s)
+			emit_shift_imm(&prog, BPF_ARSH, BPF_REG_3, s, true);
+		/* mov rax, rdx; shr rax, 63; add rdx, rax */
+		emit_mov_reg(&prog, true, BPF_REG_0, BPF_REG_3);
+		emit_shift_imm(&prog, BPF_RSH, BPF_REG_0, 63, true);
+		emit_alu_reg(&prog, BPF_ADD, BPF_REG_3, BPF_REG_0, true);
+		q_reg = BPF_REG_3;
+	} else if (!mag.add) {
+		/* shr rdx, s */
+		if (s)
+			emit_shift_imm(&prog, BPF_RSH, BPF_REG_3, s, true);
+		q_reg = BPF_REG_3;
+	} else {
+		/* mov rax, n_reg; sub rax, rdx; shr rax, 1 */
+		emit_mov_reg(&prog, true, BPF_REG_0, n_reg);
+		emit_alu_reg(&prog, BPF_SUB, BPF_REG_0, BPF_REG_3, true);
+		emit_shift_imm(&prog, BPF_RSH, BPF_REG_0, 1, true);
+		/* add rax, rdx; shr rax, s - 1 */
+		emit_alu_reg(&prog, BPF_ADD, BPF_REG_0, BPF_REG_3, true);
+		if (s > 1)
+			emit_shift_imm(&prog, BPF_RSH, BPF_REG_0, s - 1, true);
+		q_reg = BPF_REG_0;
+	}
+
+	if (is_mod) {
+		/* imul q_reg, q_reg, imm32 */
+		maybe_emit_mod(&prog, q_reg, q_reg, true);
+		if (is_imm8(imm32))
+			EMIT3(0x6B, add_2reg(0xC0, q_reg, q_reg), imm32);
+		else
+			EMIT2_off32(0x69, add_2reg(0xC0, q_reg, q_reg), imm32);
+		/* sub n_reg, q_reg */
+		emit_alu_reg(&prog, BPF_SUB, n_reg, q_reg, true);
+		q_reg = n_reg;
+	}
+	if (q_reg != dst_reg)
+		emit_mov_reg(&prog, true, dst_reg, q_reg);
+
+	*pprog = prog;
+	return true;
+}
+
 static void emit_priv_frame_ptr(u8 **pprog, void __percpu *priv_frame_ptr)
 {
 	u8 *prog = *pprog;
@@ -2443,6 +2655,11 @@ static int do_jit(struct bpf_verifier_env *env, struct bpf_prog *bpf_prog, int *
 			if (dst_reg != BPF_REG_3)
 				EMIT1(0x52); /* push rdx */
 
+			/* LLVM strength-reduces the 32-bit ones itself */
+			if (is64 && BPF_SRC(insn->code) == BPF_K &&
+			    emit_div_const(&prog, insn, dst_reg))
+				goto div_done;
+
 			if (BPF_SRC(insn->code) == BPF_X) {
 				if (src_reg == BPF_REG_0 ||
 				    src_reg == BPF_REG_3) {
@@ -2489,7 +2706,7 @@ static int do_jit(struct bpf_verifier_env *env, struct bpf_prog *bpf_prog, int *
 				 dst_reg != BPF_REG_0)
 				/* mov dst_reg, rax */
 				emit_mov_reg(&prog, is64, dst_reg, BPF_REG_0);
-
+div_done:
 			if (dst_reg != BPF_REG_3)
 				EMIT1(0x5A); /* pop rdx */
 			if (dst_reg != BPF_REG_0)
-- 
2.43.0

