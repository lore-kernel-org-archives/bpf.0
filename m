Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.133.104.62
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794166073;
	b=jo+ilyW3KQ+4mXQp5U15J6JURwO4sr0nQ6zKyobasqzn6x2gwPzKnCO2yDQ2H9ZKryfd
	 Y9paNV6KF+o4Woo9h6uGBtq5yk75W87wvY7l/WgabcKSpylSCuLbklNwY6FuZyOEF3HF6
	 TNbUIu96MCrUNu4i4BGCXwXQlciJzRiKbcwFHb8o+MdYL1eM51lPGowMdBj0IEU4PCl21
	 OL5B/AusQYnt5O6KbW52C18Igni86pG4KUxnZQwcbFXvKANTv79N+GJcGmOX9uTwGGaeV
	 2TzR/GFlI1Fxuaw2Qmdk8WT3Wd56ATC6KK1xYuj6VW/qr6APkQiPWaMQrxnXImO+YmQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794166073;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Virus-Scanned;
	bh=Mln/qShQLNPruLJTLxfesUnC9Vn3DOTK+wANUXDNWSY=;
	b=JqsicpLk5Gja+f4ESeVXT5BnvlBi8h8OaKE6VgorsTPPcq68XV+D7jz1nMI67ScgYYic
	 mpKEtqu5263zStwi19s5++ElrXg0UQoQ+hh39NJ6bNeY2xE5TVaZ5yIjXQ3TGgINmXc7i
	 kDmfoFGfmWbXVk/gAbQzeEffX2uOszFwaoPmggN4YqTI0yZ+4ZVP5sY2Mkymt9ZzvTolq
	 8+5BhXF7am+NDP7kQ1PXyst7Vcm5n3E5NzWAx0qDC2Bfyswzp7MjaoCQ9MWWoegvfjvM1
	 /5ltoQ0WK6PbV9wxX2gJ+NYd7fSYbMnQi3zn3nwCpgZxsCmph+K+uVf8HzcKrLaqb/Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=iogearbox.net;
	spf=pass smtp.mailfrom=iogearbox.net;
	dkim=pass header.d=iogearbox.net header.i=@iogearbox.net header.a=rsa-sha256 header.s=default2302 header.b=dapBJ6rh;
	arc=none smtp.remote-ip=213.133.104.62
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E513D606A323
	for <bpf@vger.kernel.org>; Sun,  8 Nov 2026 19:27:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E513D606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.a=rsa-sha256 header.s=default2302 header.b=dapBJ6rh
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=Mln/qShQLNPruLJTLxfesUnC9Vn3DOTK+wANUXDNWSY=; b=dapBJ6rhMtOjtKo9XlKqkUP5+w
	BN+mBdq4HTb/pb00pVRJum2Hv6OAY4xrnAXoJ40MpvMtqnkvHqooDbVGByLOZjhIserC65CYM5C9Z
	2KNq6wbToREtqN/fijsAVt741iO+FR+SML+HWSAGYyfHl9PcVDGGboVkT/tjnPYk+6TtRDlVWsppD
	PMwjDJ7kDKwlua0ANtUyOMWM17cTGDyM4AbVenvNVJoR7zY8RsUXTa1BpJ24eXoZTQCYyZsP5IQGl
	mj5quBlHIxbqmw6wrRgjgnn2IeEIYotDN6dCYdIRJP5B7ZVblD9njbGKOfOFKYz/xru2uegZAAqow
	/nXUi6sQ==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1xQ8YP-000PnT-1V;
	Sun, 08 Nov 2026 20:27:50 +0100
From: Daniel Borkmann <daniel@iogearbox.net>
To: ast@kernel.org
Cc: puranjay@kernel.org,
	memxor@gmail.com,
	xukuohai@huaweicloud.com,
	bpf@vger.kernel.org,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>
Subject: [PATCH bpf-next v3 11/24] bpf: Divide by constants via uhmul and shmul in the verifier
Date: Sun,  8 Nov 2026 20:26:37 +0100
Message-ID: <b733e9e689b13a03b83577f9e40712ec10dc01bb.1794165614.git.daniel@iogearbox.net>
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

LLVM has no high-half multiply to strength-reduce 64-bit divisions by a
constant, so they reach the kernel as BPF_DIV and BPF_MOD with BPF_K.
On arm64, that is a udiv or sdiv of 5 to 20 cycles.

Rewrite them in bpf_do_misc_fixups() into a uhmul or shmul by the magic
number, for the JITs that support UHMUL and SHMUL. This replaces
emit_div_const() in the x86 JIT.

With AX as the only scratch register, smod keeps the division, and so
does umod when the divisor needs the add sequence or a dividend shift.
The division is also kept for a divisor of 1, an unsigned divisor above
2^63, and for blinded or offloaded programs.

Powers of two are not special-cased, as LLVM already emits shifts for
them. The sequences were checked in user space against C division
across the imm32 range.

Like other rewrites that grow a program, this one can leave a jump at
the edge of its range over such a division unpatchable. So jit_insns'
max_jmp now divides by -7, which stays a division.

Before/after on x86 for r1 /= 1000. r1 %= 1000 is back to a div, as
1000 needs the add sequence or a dividend shift:

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

  48 c1 ef 03                    shrq $0x3,%rdi
  49 ba cf f7 53 e3 a5 9b c4 20  movabsq $0x20c49ba5e353f7cf,%r10
  4d 89 d3                       movq %r10,%r11
  50                             pushq %rax
  52                             pushq %rdx
  48 89 f8                       movq %rdi,%rax
  49 f7 e3                       mulq %r11
  48 89 d7                       movq %rdx,%rdi
  5a                             popq %rdx
  58                             popq %rax
  48 c1 ef 04                    shrq $0x4,%rdi

Suggested-by: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 arch/x86/net/bpf_jit_comp.c                   | 219 +-----------------
 kernel/bpf/fixups.c                           | 199 ++++++++++++++++
 .../selftests/bpf/prog_tests/jit_insns.c      |  26 +--
 3 files changed, 208 insertions(+), 236 deletions(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 320cf9b526b3..5bc744c42f7f 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -2035,218 +2035,6 @@ static void emit_shiftx(u8 **pprog, u32 dst_reg, u8 src_reg, bool is64, u8 op)
 	*pprog = prog;
 }
 
-struct bpf_div_magic {
-	u64 m;		/* multiplier, sign extended for signed division */
-	int s;		/* shift of the high half of the product */
-	bool add;	/* multiplier has 65 bits, use the add sequence */
-};
-
-/*
- * Multiplier and shift for an unsigned division by the constant d, with
- * 2 <= d < 2^64 and a dividend below 2^(64 - lz): n / d == (mulhu(n, m)
- * >> s), or with the add sequence when m needs 65 bits, (((n - t) >> 1)
- * + t) >> (s - 1) with t = mulhu(n, m). Hacker's Delight, 2nd ed., figure
- * 10-2.
- */
-static void bpf_magic_udiv(u64 d, int lz, struct bpf_div_magic *mag)
-{
-	u64 mask = ~0ULL >> (lz & 63);
-	u64 nc, delta, q1, r1, q2, r2;
-	int p;
-
-	mag->add = false;
-	/* Largest value with nc mod d == d - 1 */
-	nc = mask - (mask % d + 1) % d;
-	p = 63;
-	q1 = (1ULL << 63) / nc;			/* 2^p / nc */
-	r1 = (1ULL << 63) - q1 * nc;		/* 2^p mod nc */
-	q2 = (~0ULL >> 1) / d;			/* (2^p - 1) / d */
-	r2 = (~0ULL >> 1) - q2 * d;		/* (2^p - 1) mod d */
-	do {
-		p++;
-		if (r1 >= nc - r1) {
-			q1 = 2 * q1 + 1;
-			r1 = 2 * r1 - nc;
-		} else {
-			q1 = 2 * q1;
-			r1 = 2 * r1;
-		}
-		if (r2 + 1 >= d - r2) {
-			if (q2 >= (~0ULL >> 1))
-				mag->add = true;
-			q2 = 2 * q2 + 1;
-			r2 = 2 * r2 + 1 - d;
-		} else {
-			if (q2 >= (1ULL << 63))
-				mag->add = true;
-			q2 = 2 * q2;
-			r2 = 2 * r2 + 1;
-		}
-		delta = d - 1 - r2;
-	} while (p < 128 && (q1 < delta || (q1 == delta && r1 == 0)));
-
-	mag->m = q2 + 1;
-	mag->s = p - 64;
-}
-
-/*
- * Multiplier and shift for a signed division by the constant d, with
- * 2 <= |d| < 2^63: q = mulhs(n, m), q += n if d > 0 and m < 0, q -= n
- * if d < 0 and m > 0, q >>= s (arithmetic), n / d == q + (q >>> 63).
- * Hacker's Delight, 2nd ed., figure 10-1.
- */
-static void bpf_magic_sdiv(s64 d, struct bpf_div_magic *mag)
-{
-	u64 ad = d < 0 ? -(u64)d : (u64)d;
-	u64 t, anc, delta, q1, r1, q2, r2;
-	int p;
-
-	t = (1ULL << 63) + (d < 0);
-	anc = t - 1 - t % ad;			/* |nc| */
-	p = 63;
-	q1 = (1ULL << 63) / anc;		/* 2^p / |nc| */
-	r1 = (1ULL << 63) - q1 * anc;		/* 2^p mod |nc| */
-	q2 = (1ULL << 63) / ad;			/* 2^p / |d| */
-	r2 = (1ULL << 63) - q2 * ad;		/* 2^p mod |d| */
-	do {
-		p++;
-		q1 = 2 * q1;
-		r1 = 2 * r1;
-		if (r1 >= anc) {
-			q1++;
-			r1 -= anc;
-		}
-		q2 = 2 * q2;
-		r2 = 2 * r2;
-		if (r2 >= ad) {
-			q2++;
-			r2 -= ad;
-		}
-		delta = ad - r2;
-	} while (q1 < delta || (q1 == delta && r1 == 0));
-
-	mag->m = q2 + 1;
-	if (d < 0)
-		mag->m = -mag->m;
-	mag->s = p - 64;
-	mag->add = false;
-}
-
-/*
- * Divide dst_reg by the constant in insn->imm of a 64-bit division through
- * a multiplication with the magic number from bpf_magic_udiv() or
- * bpf_magic_sdiv(). The dividend goes through rax and the multiplier
- * through r11, the caller saves rax and rdx unless they are dst_reg, and
- * r10 is scratch. Returns false for the divisors left to div/idiv.
- */
-static bool emit_div_const(u8 **pprog, const struct bpf_insn *insn, u32 dst_reg)
-{
-	bool is_mod = BPF_OP(insn->code) == BPF_MOD;
-	bool is_signed = insn->off == 1;
-	u32 n_reg = dst_reg, q_reg;
-	s32 imm32 = insn->imm;
-	struct bpf_div_magic mag;
-	u8 *prog = *pprog;
-	int corr = 0, pre = 0, s;
-
-	if (is_signed) {
-		/* |d| >= 2, the verifier already rewrote d == -1 */
-		if (imm32 >= -1 && imm32 <= 1)
-			return false;
-		bpf_magic_sdiv(imm32, &mag);
-		/* q += n for d > 0 and m < 0, q -= n for d < 0 and m > 0 */
-		if (imm32 > 0 && (s64)mag.m < 0)
-			corr = 1;
-		else if (imm32 < 0 && (s64)mag.m > 0)
-			corr = -1;
-	} else {
-		/* d >= 2, a negative imm32 is a divisor above 2^63 */
-		if (imm32 < 2)
-			return false;
-		bpf_magic_udiv(imm32, 0, &mag);
-		/*
-		 * Shift the dividend by the trailing zeros of an even divisor
-		 * first, the magic number of the odd part then fits without
-		 * the add sequence.
-		 */
-		if (mag.add && !(imm32 & 1)) {
-			pre = __ffs(imm32) & 31;
-			bpf_magic_udiv(imm32 >> pre, pre, &mag);
-			if (mag.add)
-				return false;
-		}
-	}
-	s = mag.s;
-	/*
-	 * The shift is at most 63, or 64 with the add sequence which shifts
-	 * by s - 1 and needs s >= 1. Never hit for d >= 2, kept as a guard
-	 * against an unencodable count.
-	 */
-	if (s > 64 - !mag.add || (mag.add && !s))
-		return false;
-
-	/* Keep the dividend when the multiplication clobbers it */
-	if ((is_mod || mag.add || corr) &&
-	    (dst_reg == BPF_REG_0 || dst_reg == BPF_REG_3)) {
-		emit_mov_reg(&prog, true, BPF_REG_AX, dst_reg);
-		n_reg = BPF_REG_AX;
-	}
-
-	/* mov rax, dst_reg; shr rax, pre; mov r11, m; mul r11 or imul r11 */
-	if (dst_reg != BPF_REG_0)
-		emit_mov_reg(&prog, true, BPF_REG_0, dst_reg);
-	if (pre)
-		emit_shift_imm(&prog, BPF_RSH, BPF_REG_0, pre, true);
-	emit_mov_imm64(&prog, AUX_REG, mag.m >> 32, (u32)mag.m);
-	EMIT3(0x49, 0xF7, is_signed ? 0xEB : 0xE3);
-	if (is_signed) {
-		/* add rdx, n_reg or sub rdx, n_reg */
-		if (corr)
-			emit_alu_reg(&prog, corr > 0 ? BPF_ADD : BPF_SUB,
-				     BPF_REG_3, n_reg, true);
-		/* sar rdx, s */
-		if (s)
-			emit_shift_imm(&prog, BPF_ARSH, BPF_REG_3, s, true);
-		/* mov rax, rdx; shr rax, 63; add rdx, rax */
-		emit_mov_reg(&prog, true, BPF_REG_0, BPF_REG_3);
-		emit_shift_imm(&prog, BPF_RSH, BPF_REG_0, 63, true);
-		emit_alu_reg(&prog, BPF_ADD, BPF_REG_3, BPF_REG_0, true);
-		q_reg = BPF_REG_3;
-	} else if (!mag.add) {
-		/* shr rdx, s */
-		if (s)
-			emit_shift_imm(&prog, BPF_RSH, BPF_REG_3, s, true);
-		q_reg = BPF_REG_3;
-	} else {
-		/* mov rax, n_reg; sub rax, rdx; shr rax, 1 */
-		emit_mov_reg(&prog, true, BPF_REG_0, n_reg);
-		emit_alu_reg(&prog, BPF_SUB, BPF_REG_0, BPF_REG_3, true);
-		emit_shift_imm(&prog, BPF_RSH, BPF_REG_0, 1, true);
-		/* add rax, rdx; shr rax, s - 1 */
-		emit_alu_reg(&prog, BPF_ADD, BPF_REG_0, BPF_REG_3, true);
-		if (s > 1)
-			emit_shift_imm(&prog, BPF_RSH, BPF_REG_0, s - 1, true);
-		q_reg = BPF_REG_0;
-	}
-
-	if (is_mod) {
-		/* imul q_reg, q_reg, imm32 */
-		maybe_emit_mod(&prog, q_reg, q_reg, true);
-		if (is_imm8(imm32))
-			EMIT3(0x6B, add_2reg(0xC0, q_reg, q_reg), imm32);
-		else
-			EMIT2_off32(0x69, add_2reg(0xC0, q_reg, q_reg), imm32);
-		/* sub n_reg, q_reg */
-		emit_alu_reg(&prog, BPF_SUB, n_reg, q_reg, true);
-		q_reg = n_reg;
-	}
-	if (q_reg != dst_reg)
-		emit_mov_reg(&prog, true, dst_reg, q_reg);
-
-	*pprog = prog;
-	return true;
-}
-
 static void emit_priv_frame_ptr(u8 **pprog, void __percpu *priv_frame_ptr)
 {
 	u8 *prog = *pprog;
@@ -2901,11 +2689,6 @@ static int do_jit(struct bpf_verifier_env *env, struct bpf_prog *bpf_prog, int *
 			if (dst_reg != BPF_REG_3)
 				EMIT1(0x52); /* push rdx */
 
-			/* LLVM strength-reduces the 32-bit ones itself */
-			if (is64 && BPF_SRC(insn->code) == BPF_K &&
-			    emit_div_const(&prog, insn, dst_reg))
-				goto div_done;
-
 			if (BPF_SRC(insn->code) == BPF_X) {
 				if (src_reg == BPF_REG_0 ||
 				    src_reg == BPF_REG_3) {
@@ -2952,7 +2735,7 @@ static int do_jit(struct bpf_verifier_env *env, struct bpf_prog *bpf_prog, int *
 				 dst_reg != BPF_REG_0)
 				/* mov dst_reg, rax */
 				emit_mov_reg(&prog, is64, dst_reg, BPF_REG_0);
-div_done:
+
 			if (dst_reg != BPF_REG_3)
 				EMIT1(0x5A); /* pop rdx */
 			if (dst_reg != BPF_REG_0)
diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
index 108b2aa924a9..1d33a78d9373 100644
--- a/kernel/bpf/fixups.c
+++ b/kernel/bpf/fixups.c
@@ -2402,6 +2402,191 @@ static int may_goto_off(struct bpf_verifier_env *env, const struct bpf_insn *ins
 	return off;
 }
 
+#ifdef CONFIG_64BIT
+struct bpf_div_magic {
+	u64 m;		/* multiplier, sign extended for signed division */
+	int s;		/* shift of the high half of the product */
+	bool add;	/* multiplier has 65 bits, use the add sequence */
+};
+
+/*
+ * m and s with n / d == mulhu(n, m) >> s for 2 <= d < 2^64 and n below
+ * 2^(64 - lz), or (((n - t) >> 1) + t) >> (s - 1) with t = mulhu(n, m) when m
+ * needs 65 bits. Hacker's Delight, 2nd ed., figure 10-2.
+ */
+static void bpf_magic_udiv(u64 d, int lz, struct bpf_div_magic *mag)
+{
+	u64 mask = ~0ULL >> (lz & 63);
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
+ * m and s with n / d == q + (q >> 63), q = (mulhs(n, m) +- n) s>> s, for
+ * 2 <= |d| < 2^63, adding n for d > 0 and m < 0, subtracting it for d < 0 and
+ * m > 0. Hacker's Delight, 2nd ed., figure 10-1.
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
+ * 64-bit dst /= imm and dst %= imm as a uhmul or shmul by the magic number
+ * with AX as scratch, into buf. Returns the count, or 0 to keep the division,
+ * as for smod and for umod by a divisor that needs the add sequence.
+ */
+static int div_by_const(const struct bpf_insn *insn, struct bpf_insn *buf)
+{
+	bool is_mod = BPF_OP(insn->code) == BPF_MOD;
+	bool is_signed = insn->off == 1;
+	u8 dst = insn->dst_reg, ax = BPF_REG_AX;
+	struct bpf_insn *p = buf;
+	struct bpf_div_magic mag;
+	s32 d = insn->imm;
+	int pre = 0;
+
+	if (is_signed) {
+		/* |d| >= 2, d == -1 is gone already */
+		if (is_mod || (d >= -1 && d <= 1))
+			return 0;
+		bpf_magic_sdiv(d, &mag);
+	} else {
+		/* d >= 2, a negative imm is a divisor above 2^63 */
+		if (d < 2)
+			return 0;
+		bpf_magic_udiv(d, 0, &mag);
+		if (mag.add && is_mod)
+			return 0;
+		/*
+		 * Shift the dividend by the trailing zeros of an even divisor
+		 * first, the magic number of the odd part then fits without
+		 * the add sequence.
+		 */
+		if (mag.add && !(d & 1)) {
+			pre = __ffs(d) & 31;
+			bpf_magic_udiv(d >> pre, pre, &mag);
+			if (mag.add)
+				return 0;
+		}
+	}
+	/* The add sequence shifts by s - 1. Never hit for d >= 2. */
+	if (mag.s > 64 - !mag.add || (mag.add && !mag.s))
+		return 0;
+
+	if (pre)
+		*p++ = BPF_ALU64_IMM(BPF_RSH, dst, pre);
+	/* ax = m ll */
+	*p++ = BPF_RAW_INSN(BPF_LD | BPF_DW | BPF_IMM, ax, 0, 0, (u32)mag.m);
+	*p++ = BPF_RAW_INSN(0, 0, 0, 0, mag.m >> 32);
+	if (is_signed) {
+		/* ax = (shmul(dst, m) +- dst) s>> s; dst = ax + (ax >> 63) */
+		*p++ = BPF_ALU64_REG_OFF(BPF_MUL, ax, dst, BPF_SHMUL);
+		if (d > 0 && (s64)mag.m < 0)
+			*p++ = BPF_ALU64_REG(BPF_ADD, ax, dst);
+		else if (d < 0 && (s64)mag.m > 0)
+			*p++ = BPF_ALU64_REG(BPF_SUB, ax, dst);
+		if (mag.s)
+			*p++ = BPF_ALU64_IMM(BPF_ARSH, ax, mag.s);
+		*p++ = BPF_MOV64_REG(dst, ax);
+		*p++ = BPF_ALU64_IMM(BPF_RSH, dst, 63);
+		*p++ = BPF_ALU64_REG(BPF_ADD, dst, ax);
+	} else if (is_mod) {
+		/* dst -= (uhmul(dst, m) >> s) * d */
+		*p++ = BPF_ALU64_REG_OFF(BPF_MUL, ax, dst, BPF_UHMUL);
+		if (mag.s)
+			*p++ = BPF_ALU64_IMM(BPF_RSH, ax, mag.s);
+		*p++ = BPF_ALU64_IMM(BPF_MUL, ax, d);
+		*p++ = BPF_ALU64_REG(BPF_SUB, dst, ax);
+	} else if (mag.add) {
+		/* ax = uhmul(dst, m); dst = (((dst - ax) >> 1) + ax) >> (s - 1) */
+		*p++ = BPF_ALU64_REG_OFF(BPF_MUL, ax, dst, BPF_UHMUL);
+		*p++ = BPF_ALU64_REG(BPF_SUB, dst, ax);
+		*p++ = BPF_ALU64_IMM(BPF_RSH, dst, 1);
+		*p++ = BPF_ALU64_REG(BPF_ADD, dst, ax);
+		if (mag.s > 1)
+			*p++ = BPF_ALU64_IMM(BPF_RSH, dst, mag.s - 1);
+	} else {
+		/* dst = uhmul(dst, m) >> s */
+		*p++ = BPF_ALU64_REG_OFF(BPF_MUL, dst, ax, BPF_UHMUL);
+		if (mag.s)
+			*p++ = BPF_ALU64_IMM(BPF_RSH, dst, mag.s);
+	}
+	return p - buf;
+}
+#else
+static int div_by_const(const struct bpf_insn *insn, struct bpf_insn *buf)
+{
+	return 0;
+}
+#endif
+
 /* Do various post-verification rewrites in a single program pass.
  * These rewrites simplify JIT and interpreter implementations.
  */
@@ -2481,6 +2666,20 @@ int bpf_do_misc_fixups(struct bpf_verifier_env *env)
 			goto next_insn;
 		}
 
+		/* Divide by a constant via uhmul or shmul, LLVM does the 32-bit ones */
+		if ((insn->code == (BPF_ALU64 | BPF_MOD | BPF_K) ||
+		     insn->code == (BPF_ALU64 | BPF_DIV | BPF_K)) &&
+		    prog->jit_requested && !prog->blinding_requested &&
+		    !bpf_prog_is_offloaded(prog->aux) && bpf_jit_supports_hmul()) {
+			cnt = div_by_const(insn, insn_buf);
+			if (cnt) {
+				insn = bpf_patch_list_add(env, i, insn_buf, cnt);
+				if (IS_ERR(insn))
+					return PTR_ERR(insn);
+				goto next_insn;
+			}
+		}
+
 		/* Make divide-by-zero and divide-by-minus-one exceptions impossible. */
 		if (insn->code == (BPF_ALU64 | BPF_MOD | BPF_X) ||
 		    insn->code == (BPF_ALU64 | BPF_DIV | BPF_X) ||
diff --git a/tools/testing/selftests/bpf/prog_tests/jit_insns.c b/tools/testing/selftests/bpf/prog_tests/jit_insns.c
index 52bffe27199b..5fd1c856ded7 100644
--- a/tools/testing/selftests/bpf/prog_tests/jit_insns.c
+++ b/tools/testing/selftests/bpf/prog_tests/jit_insns.c
@@ -582,14 +582,10 @@ static void test_alu_imm_regs(void)
 }
 
 /*
- * Division and modulo by constants for every width, signedness and
- * destination register with a set of divisors and dividends around the
- * multiple boundaries and the extremes of each range. This covers a JIT
- * replacing the division with a multiplication by a magic number in all
- * of its forms: magic numbers needing the extra add step, zero shifts,
- * both signed corrections, and the divisors like 1, -1 and the ones
- * above 2^63 that are still emitted as a real division. The dividends
- * of the 32-bit operations carry garbage in the upper 32 bits.
+ * Division and modulo by constants for every width, signedness and register,
+ * with dividends at the multiple boundaries and the extremes: every form of
+ * the verifier's multiplication by the magic number and the divisors it keeps.
+ * The dividends of the 32-bit operations carry garbage in the upper half.
  */
 static const __s32 unsigned_divisors[] = {
 	2, 3, 7, 10, 25, 641, 1000, 4096, 65536, 1000000007, 0x7fffffff,
@@ -2486,15 +2482,9 @@ static void test_acq_rel(void)
 }
 
 /*
- * A jump with the maximal offset over instructions which expand to several
- * native ones, so that the native offset outgrows the field of a short
- * branch and takes the JITs through their branch conversion. The region
- * must not grow in the verifier, or the jump could not reach over it any
- * more: the divisions are by constants, as a division by a register gets
- * a zero check in front, and the region sticks to one width, as a 32-bit
- * result read by a 64-bit instruction gets a zero extension on the JITs
- * which need one. The region is the not taken path and ends with a result
- * different from the taken one, so a jump landing inside it fails the run.
+ * A jump with the maximal offset over insns that expand natively, through the
+ * JITs' long branch forms. The region must not grow in the verifier: one width
+ * and divisions by constants it keeps. A jump landing inside it fails the run.
  */
 static void max_jmp(bool alu32, bool taken)
 {
@@ -2524,7 +2514,7 @@ static void max_jmp(bool alu32, bool taken)
 
 		if (op == BPF_DIV || op == BPF_MOD)
 			insns[i++] = alu32 ? BPF_ALU32_IMM(op, BPF_REG_3, 7) :
-					     BPF_ALU64_IMM(op, BPF_REG_3, 7);
+					     BPF_ALU64_IMM(op, BPF_REG_3, -7);
 		else
 			insns[i++] = alu32 ? BPF_ALU32_REG(op, BPF_REG_3, BPF_REG_2) :
 					     BPF_ALU64_REG(op, BPF_REG_3, BPF_REG_2);
-- 
2.43.0

