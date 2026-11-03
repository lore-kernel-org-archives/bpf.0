Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.133.104.62
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793708867;
	b=UH1WFnodvEOw2TvE4whCBCWR8hGiK2SfBCmFQjogN68t3bNkQjw8SGyHrXCPYW+Llf7f
	 oOCe6hXEuvI1xtpXy2lL1Ot3DNw0swM/3Nn7DUohtQpjOwVGO8VnSK2EnjsQlgj2V1S/J
	 vpouT8pq3ftqSLGwGjQeFbvZMmAEruyMGQlIhqRy6wrcs8zvPjdIyO7YO0biIveTDDDS3
	 8h5U8qJCP0Mc2YNRqgS8aelJ1QUwURga/S85HTfUL4Z4S3nCMU6BZScsN4qYy/1KDqX9c
	 Z+AhdX/QgbASfccMliam2vX2Bt3o2OZCMU3zLLYD9LKuwXFFfNWoasCBHWuAvcZyxwA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793708867;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Virus-Scanned;
	bh=4Cozozu9RCKzZ0Csn/8Ru73jWh7Kwt8zLMlWpokD1hM=;
	b=wCBtTCbC75dBBRbqACRICMBeHtAmpGaC6/wOVHAiQuML5DHairujpU8gJfcEreCf++7S
	 fbOIYIgxbKJ+PjUI0qV6cakY/1Wpb7P9oWwGgL43CPNxSP5QjWFgifoLpNr15owIWSBW5
	 oBK00G6P8CM8BE3i96DcAkX11JDcjF1g62GjxcXuMtYG4jftXd2gIYijMNRkbCmEEaHS1
	 FeySizvrY4fMmQ2UJZjojJRyN/iQP0rs3ozQXWyqWBz4dYrk3wF2lGkQ+/VE4YLfl2AGX
	 c9S5tYlCmrSW1rCs0VLdB6XxkgkfpEwp8hI97fDZm8DU90el4mUMvl2jJnMjw8lgO2g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=iogearbox.net;
	spf=pass smtp.mailfrom=iogearbox.net;
	dkim=pass header.d=iogearbox.net header.i=@iogearbox.net header.a=rsa-sha256 header.s=default2302 header.b=ddMvLgYk;
	arc=none smtp.remote-ip=213.133.104.62
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ECD6606D801
	for <bpf@vger.kernel.org>; Tue,  3 Nov 2026 12:27:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4ECD6606D801
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=iogearbox.net header.i=@iogearbox.net header.a=rsa-sha256 header.s=default2302 header.b=ddMvLgYk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=4Cozozu9RCKzZ0Csn/8Ru73jWh7Kwt8zLMlWpokD1hM=; b=ddMvLgYklQFV1rVUhMCx5jDQB1
	mXCUCnnbU0oL1Qm5+W4+7XgbslKDBijXMygVFiNlljBc6+oiCCp7zAVxTmcgNmmgJr1UrQtHvDx9i
	jzappWeGFi62snE3XqdyoqKoRKbVDJ5tWwu36v4zzygw9573MxJvbKdU/iHRSf6PxTTpebh59TBVV
	+sTV4MIH2s7X3kiehqVR26Txhfc93aFPc1RxbmHyWRMbh8NofQvbYkV9eO1+mDJv1Hqt2aHGNjZhE
	9bbomeBzPicp3E7C/SjZVQ4TBx1E0A1zgeu0ahtKXi7v1ObF8krjOKqcZwssIQZ2k37qYBoofOVQA
	6v9gz8/g==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1xODc2-000MQm-39;
	Tue, 03 Nov 2026 13:27:39 +0100
From: Daniel Borkmann <daniel@iogearbox.net>
To: ast@kernel.org
Cc: puranjay@kernel.org,
	memxor@gmail.com,
	xukuohai@huaweicloud.com,
	bpf@vger.kernel.org
Subject: [PATCH bpf-next v2 07/20] bpf: Move the division magic number selection out of the x86 JIT
Date: Tue,  3 Nov 2026 13:27:20 +0100
Message-ID: <20261103122733.1383002-8-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261103122733.1383002-1-daniel@iogearbox.net>
References: <20261103122733.1383002-1-daniel@iogearbox.net>
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
X-Virus-Scanned: Clear (ClamAV 1.4.6/28173/Tue Nov  3 07:27:52 2026)

bpf_magic_udiv() and bpf_magic_sdiv() compute the multiplier and shift
for the division by a constant, and emit_div_const() picks the divisors
they take, the correction of the signed quotient and the shift of the
dividend by the trailing zeros of an even divisor whose magic number
needs 65 bits otherwise, and guards the shift count. None of it is x86
specific, so move it to the core as bpf_magic_div(), which a JIT calls
once before emitting the instructions, for the other JITs to use without
a copy of their own. The magic numbers divide 64-bit values by a divisor
only known at run time, which a 32-bit kernel has no inline form for, so
they come under CONFIG_64BIT like the JITs which can use them. No
functional change.

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 arch/x86/net/bpf_jit_comp.c | 163 ++++--------------------------------
 include/linux/filter.h      |  12 +++
 kernel/bpf/core.c           | 147 ++++++++++++++++++++++++++++++++
 3 files changed, 175 insertions(+), 147 deletions(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 83b0cb1f911c..1f4d3bbfa90e 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -2028,109 +2028,12 @@ static void emit_shiftx(u8 **pprog, u32 dst_reg, u8 src_reg, bool is64, u8 op)
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
 /*
  * Divide dst_reg by the constant in insn->imm of a 64-bit division through
- * a multiplication with the magic number from bpf_magic_udiv() or
- * bpf_magic_sdiv(). The dividend goes through rax and the multiplier
- * through r11, the caller saves rax and rdx unless they are dst_reg, and
- * r10 is scratch. Returns false for the divisors left to div/idiv.
+ * a multiplication with the magic number from bpf_magic_div(). The dividend
+ * goes through rax and the multiplier through r11, the caller saves rax and
+ * rdx unless they are dst_reg, and r10 is scratch. Returns false for the
+ * divisors left to div/idiv.
  */
 static bool emit_div_const(u8 **pprog, const struct bpf_insn *insn, u32 dst_reg)
 {
@@ -2140,46 +2043,12 @@ static bool emit_div_const(u8 **pprog, const struct bpf_insn *insn, u32 dst_reg)
 	s32 imm32 = insn->imm;
 	struct bpf_div_magic mag;
 	u8 *prog = *pprog;
-	int corr = 0, pre = 0, s;
 
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
+	if (!bpf_magic_div(imm32, is_signed, &mag))
 		return false;
 
 	/* Keep the dividend when the multiplication clobbers it */
-	if ((is_mod || mag.add || corr) &&
+	if ((is_mod || mag.add || mag.corr) &&
 	    (dst_reg == BPF_REG_0 || dst_reg == BPF_REG_3)) {
 		emit_mov_reg(&prog, true, BPF_REG_AX, dst_reg);
 		n_reg = BPF_REG_AX;
@@ -2188,18 +2057,18 @@ static bool emit_div_const(u8 **pprog, const struct bpf_insn *insn, u32 dst_reg)
 	/* mov rax, dst_reg; shr rax, pre; mov r11, m; mul r11 or imul r11 */
 	if (dst_reg != BPF_REG_0)
 		emit_mov_reg(&prog, true, BPF_REG_0, dst_reg);
-	if (pre)
-		emit_shift_imm(&prog, BPF_RSH, BPF_REG_0, pre, true);
+	if (mag.pre)
+		emit_shift_imm(&prog, BPF_RSH, BPF_REG_0, mag.pre, true);
 	emit_mov_imm64(&prog, AUX_REG, mag.m >> 32, (u32)mag.m);
 	EMIT3(0x49, 0xF7, is_signed ? 0xEB : 0xE3);
 	if (is_signed) {
 		/* add rdx, n_reg or sub rdx, n_reg */
-		if (corr)
-			emit_alu_reg(&prog, corr > 0 ? BPF_ADD : BPF_SUB,
+		if (mag.corr)
+			emit_alu_reg(&prog, mag.corr > 0 ? BPF_ADD : BPF_SUB,
 				     BPF_REG_3, n_reg, true);
 		/* sar rdx, s */
-		if (s)
-			emit_shift_imm(&prog, BPF_ARSH, BPF_REG_3, s, true);
+		if (mag.s)
+			emit_shift_imm(&prog, BPF_ARSH, BPF_REG_3, mag.s, true);
 		/* mov rax, rdx; shr rax, 63; add rdx, rax */
 		emit_mov_reg(&prog, true, BPF_REG_0, BPF_REG_3);
 		emit_shift_imm(&prog, BPF_RSH, BPF_REG_0, 63, true);
@@ -2207,8 +2076,8 @@ static bool emit_div_const(u8 **pprog, const struct bpf_insn *insn, u32 dst_reg)
 		q_reg = BPF_REG_3;
 	} else if (!mag.add) {
 		/* shr rdx, s */
-		if (s)
-			emit_shift_imm(&prog, BPF_RSH, BPF_REG_3, s, true);
+		if (mag.s)
+			emit_shift_imm(&prog, BPF_RSH, BPF_REG_3, mag.s, true);
 		q_reg = BPF_REG_3;
 	} else {
 		/* mov rax, n_reg; sub rax, rdx; shr rax, 1 */
@@ -2217,8 +2086,8 @@ static bool emit_div_const(u8 **pprog, const struct bpf_insn *insn, u32 dst_reg)
 		emit_shift_imm(&prog, BPF_RSH, BPF_REG_0, 1, true);
 		/* add rax, rdx; shr rax, s - 1 */
 		emit_alu_reg(&prog, BPF_ADD, BPF_REG_0, BPF_REG_3, true);
-		if (s > 1)
-			emit_shift_imm(&prog, BPF_RSH, BPF_REG_0, s - 1, true);
+		if (mag.s > 1)
+			emit_shift_imm(&prog, BPF_RSH, BPF_REG_0, mag.s - 1, true);
 		q_reg = BPF_REG_0;
 	}
 
diff --git a/include/linux/filter.h b/include/linux/filter.h
index 8a8134752f30..bf0d04cca2ce 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -1500,6 +1500,18 @@ void bpf_jit_binary_pack_free(struct bpf_binary_header *ro_header,
 int bpf_jit_add_poke_descriptor(struct bpf_prog *prog,
 				struct bpf_jit_poke_descriptor *poke);
 
+#ifdef CONFIG_64BIT
+struct bpf_div_magic {
+	u64 m;		/* multiplier, sign extended for signed division */
+	int s;		/* shift of the high half of the product */
+	int pre;	/* shift of the dividend before the multiplication */
+	int corr;	/* dividend added (1) or subtracted (-1) to the product */
+	bool add;	/* multiplier has 65 bits, use the add sequence */
+};
+
+bool bpf_magic_div(s32 d, bool is_signed, struct bpf_div_magic *mag);
+#endif
+
 int bpf_jit_get_func_addr(const struct bpf_prog *prog,
 			  const struct bpf_insn *insn, bool extra_pass,
 			  u64 *func_addr, bool *func_addr_fixed);
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 0586ed020397..9fd13fcf7d84 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -1519,6 +1519,153 @@ void __weak bpf_jit_free(struct bpf_prog *fp)
 	bpf_prog_unlock_free(fp);
 }
 
+#ifdef CONFIG_64BIT
+/*
+ * Multiplier and shift for an unsigned division by the constant d, with
+ * 2 <= d < 2^64 and a dividend below 2^(64 - lz): n / d == (mulhu(n, m)
+ * >> s), or with the add sequence when m needs 65 bits, (((n - t) >> 1)
+ * + t) >> (s - 1) with t = mulhu(n, m). Hacker's Delight, 2nd ed., figure
+ * 10-2.
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
+ * Magic number for the 64-bit division or modulo by the constant d of a
+ * BPF_DIV or BPF_MOD with BPF_K, signed per is_signed, as the JITs emit it:
+ * the high half of the product of the dividend, shifted right by pre for an
+ * unsigned division, and the multiplier m, shifted right by s, the add
+ * sequence of bpf_magic_udiv() instead when add is set, and for a signed
+ * division with the dividend added for corr > 0 or subtracted for corr < 0
+ * before the arithmetic shift and the sign bit of the quotient added after
+ * it. The dividend of an even unsigned divisor is shifted by the trailing
+ * zeros first when the magic number needs 65 bits otherwise, the one of the
+ * odd part then fits without the add sequence. Returns false for the
+ * divisors left to the division instruction: 0 and +-1, the unsigned ones
+ * above 2^63, which a negative d stands for, and a shift the sequences do
+ * not take, which d >= 2 never gives.
+ */
+bool bpf_magic_div(s32 d, bool is_signed, struct bpf_div_magic *mag)
+{
+	mag->pre = 0;
+	mag->corr = 0;
+	if (is_signed) {
+		/* |d| >= 2, the verifier already rewrote d == -1 */
+		if (d >= -1 && d <= 1)
+			return false;
+		bpf_magic_sdiv(d, mag);
+		/* q += n for d > 0 and m < 0, q -= n for d < 0 and m > 0 */
+		if (d > 0 && (s64)mag->m < 0)
+			mag->corr = 1;
+		else if (d < 0 && (s64)mag->m > 0)
+			mag->corr = -1;
+	} else {
+		/* d >= 2, a negative d is a divisor above 2^63 */
+		if (d < 2)
+			return false;
+		bpf_magic_udiv(d, 0, mag);
+		/*
+		 * Shift the dividend by the trailing zeros of an even divisor
+		 * first, the magic number of the odd part then fits without
+		 * the add sequence.
+		 */
+		if (mag->add && !(d & 1)) {
+			mag->pre = __ffs(d) & 31;
+			bpf_magic_udiv(d >> mag->pre, mag->pre, mag);
+			if (mag->add)
+				return false;
+		}
+	}
+	/*
+	 * The shift is at most 63, or 64 with the add sequence which shifts
+	 * by s - 1 and needs s >= 1. Never hit for d >= 2, kept as a guard
+	 * against an unencodable count.
+	 */
+	return mag->s <= 64 - !mag->add && (!mag->add || mag->s);
+}
+#endif /* CONFIG_64BIT */
+
 int bpf_jit_get_func_addr(const struct bpf_prog *prog,
 			  const struct bpf_insn *insn, bool extra_pass,
 			  u64 *func_addr, bool *func_addr_fixed)
-- 
2.43.0

