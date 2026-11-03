Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793728171;
	b=C5dHm9c77l2Gqqr3UK+fdlwsX1WL876GEWn0h+ZYicEHgE0v+KsgT8m8vZTk2pH7I0pd
	 u7jdIIzUeL8426F8vmQUycDD7VPWefOJJ9BZbyRqEfAgPX/6W402lh0UN8lm++mb+ycXX
	 iwtOxyW4I3ddk/C1Sb08XZGduqvLCADz4ODC3i6g76Qyg1F2RillXHS1P6WjXRpVOU5Hj
	 AQmK55h50tG+4xttN6AgtuAcrzwWeVJkzQplpCe9ERbiLm0xTzJAqBzy6QCWHwI3tUXsY
	 LlfVULmXkyGrVcMDmOmBWmpHUjjiELo8/IG+QejCEEMkxwWpAb6JQDwEwP67F0AH2yA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793728171;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:Content-Transfer-Encoding:MIME-Version;
	bh=Y3h7cSjqvOTXKd16F+0Lv4WNSd/cF1wXuHnkOCK5EGo=;
	b=V3QemjOJkPUwqLlyp8vPELcEJr8Mrsq6iSsDymXYBNP7Um+ZM4tNdfSQaeYdkeb182f7
	 TRGcKiP+QzlOrkzDMq9Nt12GtzYBRrfIPgpdiUaFOUgMzUR+KfkajSD42vgBkiIFIsoRw
	 gjh93yhQzJoPkmQDpJ67MPme/GNKi7jHvG7Fv2qdIF+JuR0z8fotzOa3M/jhHZ8e/9JNX
	 K+ZJBFpPCu8wJxKtH5dxPfMrZsceuGi0FnBo48xicYvpKcTviid7h/j/nXPB/mOKFziF6
	 o/IVRD6k7zB5XY2cTTR/VBJqO/bmvgC/ZQYlLX9So9qkRJeQowmX6eU8efwMeOFByeQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vSGYaP7R;
	arc=none smtp.remote-ip=209.85.216.47
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD6D6606A31B
	for <bpf@vger.kernel.org>; Tue,  3 Nov 2026 17:49:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DD6D6606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vSGYaP7R
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-3ad2b3b1c02so2459775a91.1
        for <bpf@vger.kernel.org>; Tue, 03 Nov 2026 09:49:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793728170; x=1794332970; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Y3h7cSjqvOTXKd16F+0Lv4WNSd/cF1wXuHnkOCK5EGo=;
        b=vSGYaP7R1nHzTGEZAZTY+Yw/fhrzFxbjqhmU29WI9lzgNpE+zQg7pnn77AyirCIVsT
         K24+RydZ2g0IRmegmgkyZzkAtwae2ZllViB06RIEW2DFYVO7lx30O2riH72Rzy+PxQHX
         V4iSPmwrEz1b1feLus+IUKwtFHYuARPR7r0swWDoOS5UP5mUBVfkTQKyzVBJ5ym74m8q
         PE++uhSHheDu96qEYMEtlbu62OWfAZ0kmkFNVO4fYYENipVCa3bwNmurNouD8yO81HDv
         gpU0r37IuNgI098AlIk9DN+qXgOgMkcYpVcDXfXZtlkTbVREEHayYDkq4BhTHSqe6uY2
         P1pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793728170; x=1794332970;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Y3h7cSjqvOTXKd16F+0Lv4WNSd/cF1wXuHnkOCK5EGo=;
        b=STsi7L8+Y4qy2J3qCDTgtsIe6W9wV/nT91SPTnihHwUO83EhNMKcUjKZTdmt0PZ6QG
         ve6qgTz8ji4ZSWeLUrIm7e801eA2+jiHgQadjbAdgZXLPgvattDDtzYhbS7HTf0z3ItC
         iE1yKxB4It5g9FQVY5OiN/e0cU3CeAJ1dcaCpnezraIv+WA13khhHy9Fxvgo9Ga12Izh
         7U8UcKTDM/IqKghUEJL/FBVpMbojnA2O3ejswnabWyaoxJVwUclCaoWWfs5X9bVPyiqt
         +2F35vRJqxt6h0LhabyNQoP8NEw4Ig8IVy7RCPtCgFO8NoycArcksAi/7y7Ru+fpiDtc
         i5Nw==
X-Forwarded-Encrypted: i=1; AKwUvBxoJkHDcYFvH88SKHpUpNkye4QIXYPoTNF/Y/ezfaNDuNdse/bvzZdwCz5ku3KuD3gqssM=@vger.kernel.org
X-Gm-Message-State: APuU4Z8sTNf25r8wkIee0vKE/jf0J0kz9frec32svzHqwnbrU80L0HH3
	IcWDm/a6b86/NwGMTWKC/8FwAX6u96PI9zPkj5u9oCkLMWczW4BvJL7+
X-Gm-Gg: AYBFou0WfIGKDDvzcWOF0mH+f9wHV7eJq3dDXOZgRmGtpLy/LhVbrP9rErhEIGfQlbv
	UuRPjU4tDmORmifJV70UY+vsnW6B6qO9w8aoaM1/V/Yw2l8EYtpBmfUq+kGknGxA9ArtfqtVhdi
	AtsXShrSQubNyc8EJuE74MNBLhK+PwlxPnNWf9gz6mjoIoVgvtZMpg/cjrAIWuQV3bEg3gC/ciI
	gesbLBLDiIDyG55q2d9ep8FpmDwNOfOGkte6khV+GMPD8Ahn2itaPXehL9Yx63Gimzgk+eLD0/U
	Hp5oVFroaidPYCuNpsPwjqc5hqjYGhA3q+WmavH1GQEb0Sdrv6RUaV1RNLGMw9WSvGw3MIX/qWW
	to2/9mWBqNm4MIPEBx22xJKbJ7mb9g7LhT/xk0QFoNsqbgl+TTqXQm3U2IdFLDUiZ0FlcKzMwtU
	2QtRVp34jQnLlGL6RW04xdP4y/rcgJa2ir4HOi9ySyB7OXtz7GFUl+OSj+0pnvr6qL7mfTr1A7m
	A+mOUqzYomi75Ue6dygoRUo++FaP8Tu/DBS+utM4RezwfuK3oyb3lQAfB2Gs4yVUzK++e7wGYSd
	D8m5YVvUp4Igoq4rydhvsubg+/aWL5QEXBPHoup+TJYa4mMRcMCp6q8teRTYWiVtjDp8YtMD2BJ
	KCrwEyzMBqMrDIz8JlnPQPiw9+yN+/d0VMw==
X-Received: by 2002:a17:90b:3b4f:b0:3a8:6a04:80ef with SMTP id 98e67ed59e1d1-3ae8957a24dmr11473000a91.6.1793728170119;
        Tue, 03 Nov 2026 09:49:30 -0800 (PST)
Received: from localhost ([153.61.198.255])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae87f5dcc3sm11961560a91.3.2026.11.03.09.49.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Nov 2026 09:49:29 -0800 (PST)
Content-Type: text/plain; charset=UTF-8
Date: Tue, 03 Nov 2026 17:49:29 +0000
Message-Id: <DMLRKH6WQQ92.34GQL15IOSCH5@gmail.com>
Cc: <puranjay@kernel.org>, <memxor@gmail.com>, <xukuohai@huaweicloud.com>,
 <bpf@vger.kernel.org>
Subject: Re: [PATCH bpf-next v2 15/20] bpf, arm64: Divide by constants via
 multiplication with a magic number
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Daniel Borkmann" <daniel@iogearbox.net>
In-Reply-To: <20261103122733.1383002-16-daniel@iogearbox.net>
References: <20261103122733.1383002-1-daniel@iogearbox.net> <20261103122733.1383002-16-daniel@iogearbox.net>
Content-Transfer-Encoding: 8bit
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Tue, Nov 03, 2026 at 04:27 AM Daniel Borkmann <daniel@iogearbox.net> wrote:
> LLVM strength-reduces 32-bit divisions by a constant into a 64-bit
> multiplication, but has no high-half multiply for the 64-bit ones, so
> these reach the JIT as BPF_DIV/BPF_MOD with BPF_K and were emitted as
> udiv or sdiv, which take 5 to 20 cycles on Neoverse N1 through V3 and
> block the one divider of the core until done, whereas umulh and smulh
> take 3 cycles and issue twice per cycle on N2 and later, 5 cycles on N1.
> Cilium divides by NSEC_PER_SEC this way in its monotonic clock helper,
> which conntrack, NAT and the load balancer run for every entry they
> stamp or check.

BPF has a high-half multiply since last week:
commit f09c72811afa ("bpf: Add UHMUL and SHMUL instructions")
The x86-64, arm64 and riscv64 JITs support it.

can the verifier do the whole thing now ?
bpf_do_misc_fixups() turns 'r1 /= 1000000000' into

  r1 >>= 9
  ax = 0x44b82fa09b5a53 ll
  r1 uh*= ax
  r1 >>= 11

arm64 emits 7 insns for it, the same as this patch.
x86 emits one mov more than today.
riscv64 gets it too, and every JIT that adds uhmul later.
The magic number is computed once, not in every pass of a JIT.
Then no need for patches 7 and 15, and emit_div_const() in x86 goes away.

AX is the only scratch register. The cost:

  insn                      arm64, compared to this patch
  ------------------------  -----------------------------
  udiv, mul and shift       same number of insns
  udiv, add sequence        1 more insn
  sdiv                      2 more insns
  umod, m fits in 64 bits   1 more insn
  umod, m needs 65 bits     keeps udiv
  smod                      keeps sdiv

x86 loses the last two rows as well.
The cover letter names the divisors 1000000000, 100 and 1000000.
All three are in the first row.

bpf_magic_udiv() and bpf_magic_sdiv() only move. div_by_const() is new.
The shifts for sdiv by a power of 2 are not in the diff.

Something like this (compile tested only):

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 83b0cb1..691174c 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -2028,218 +2028,6 @@ static void emit_shiftx(u8 **pprog, u32 dst_reg, u8 src_reg, bool is64, u8 op)
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
@@ -2827,11 +2615,6 @@ static int do_jit(struct bpf_verifier_env *env, struct bpf_prog *bpf_prog, int *
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
@@ -2878,7 +2661,7 @@ static int do_jit(struct bpf_verifier_env *env, struct bpf_prog *bpf_prog, int *
 				 dst_reg != BPF_REG_0)
 				/* mov dst_reg, rax */
 				emit_mov_reg(&prog, is64, dst_reg, BPF_REG_0);
-div_done:
+
 			if (dst_reg != BPF_REG_3)
 				EMIT1(0x5A); /* pop rdx */
 			if (dst_reg != BPF_REG_0)
diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
index ead7871..c26e5e1 100644
--- a/kernel/bpf/fixups.c
+++ b/kernel/bpf/fixups.c
@@ -1796,6 +1796,195 @@ static int may_goto_off(struct bpf_verifier_env *env, const struct bpf_insn *ins
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
+ * 64-bit 'dst /= imm' and 'dst %= imm' as uhmul or shmul by the magic number.
+ * AX is the only scratch register. A modulo has to keep the dividend, so smod
+ * and umod by a divisor that needs the shift of the dividend or the add
+ * sequence keep the division. Returns the number of insns, 0 for no change.
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
+		/* ax = shmul(dst, m) +- dst >> s; dst = ax + (ax >>> 63) */
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
@@ -1872,6 +2061,20 @@ int bpf_do_misc_fixups(struct bpf_verifier_env *env)
 			goto next_insn;
 		}

+		/* LLVM strength-reduces the 32-bit ones itself */
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

pw-bot: cr
