Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC9EC3D6CDA
	for <bpf@vger.kernel.org>; Tue, 21 Apr 2026 17:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776794118; cv=none; b=qv+kXOVQ5UPL6f0r3zO/vIvo/HmmsXeUtO5iPGI6jiULT66qWHzGgFADW2lQOF2zNvfaKoFMUoceeZV98ceIOlVHKJ0ImvOwYPrILEmOekaQFEcOf486WGitAwkwaA/isnNZ7x5EuFfimpSUuYEy2v4EYOSiGuWAfelvv1TsC2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776794118; c=relaxed/simple;
	bh=uPiFRQzZfVvzy7zWQCW3Lj5kFGPiQvn4HfvW3TBLDLo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ovprH9BAXGD6XfLDQKUD+PB+y1y5DXw5ytLnCixsOJ6jEr0MVKhouu6O3YjULgeOV4KDj8UVdLqDh96Dcp8i97otK0PUyGCqUiOTh/LNcxybgmqGtOySWZ/Ox9S7lBoIhWeVnioPIBvveh0MstnITuNOhXcJ/NzZK5j53DOrbXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=fb.com header.i=@fb.com header.b=veNgwGAc; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fb.com header.i=@fb.com header.b="veNgwGAc"
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
	by m0001303.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 63LGwGLr3387300
	for <bpf@vger.kernel.org>; Tue, 21 Apr 2026 10:55:15 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=s2048-2025-q2; bh=0IaRGKevGSbluAH5p0
	3+E69GVV+ISfPxqCNvPSEsLdU=; b=veNgwGAcMpKunMvv4kdinPuWQP1iuqTTsC
	QiVuNFjr/yQ3mLeS3CinWRYR2fjNCuzt2dzxDcmRNyVUKp6QrUCgyOcUjxl9K1Gv
	a6/pCRLF8wFe2bc6e/SFOAQf+pY4ubvdzzdFgmeN68XJ6DQf0HKP2dg2zpcNWate
	Le/51J1/lKR/AEq+tTnZXaDSmOmJdZxwZg0sZhzq/m0T4y/yzAiZ8lZvKdCPcXBs
	YqlAwnLkZBRvPYcno2ptoEbVETpgMcBlt4lhMq3c++RXrYusSKVUe9b9xrUoDpy0
	mpAca9C3eJSRd1VWeFClau6ghHO3kBw7z7K10dfCvEcjHGcjKkkg==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by m0001303.ppops.net (PPS) with ESMTPS id 4dm5m8j3tb-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Tue, 21 Apr 2026 10:55:15 -0700 (PDT)
Received: from twshared4770.04.frc1.facebook.com (2620:10d:c0a8:1c::1b) by
 mail.thefacebook.com (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.37; Tue, 21 Apr 2026 17:55:13 +0000
Received: by devvm14451.vll0.facebook.com (Postfix, from userid 187975)
	id 7BE7668155F77; Tue, 21 Apr 2026 10:55:07 -0700 (PDT)
From: Jie Meng <jmeng@fb.com>
To: <bpf@vger.kernel.org>
CC: <ast@kernel.org>, <andrii@kernel.org>, <daniel@iogearbox.net>,
        <jmeng@fb.com>
Subject: [PATCH v3 bpf-next] bpf, x86: Granlund-Montgomery optimization for 64-bit div/mod by immediate
Date: Tue, 21 Apr 2026 10:55:07 -0700
Message-ID: <20260421175507.2396332-1-jmeng@fb.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIxMDE3OCBTYWx0ZWRfXxqTrEg3GSpfs
 7iIkHjMv+AWsOpC7NgltJG9Fz4KNU+abjtwSrP+YCEsItvDqQ2Kur60gqQaz5Zx1brIX4HhLgMB
 M8ZuH/ekOA97WYItTeBPT4Ku0AlP+ivk0MzsnPgHAk44w97ZwYpsFWmbuylLC2kuGgh4AD9TH16
 52HN96mFx+2WkLvZONLYdmm2jzNkCaatgRaBCGLmNO4uBpBh13ZTW59RlbPqd7G8W0p3Pipdp+G
 Wwk/HePsCGXftIxKbMP4uNYkgMuN+k/gLx2FHe2Ruf0a9+D/qN8JF5Mnto71Nd3FnsF0ME6SOot
 kRIPPbxRkiN9BP2gWAvtgtGvXF5OPAnSvY65JSGma2oWdxcxKCzUQmWmlwxXdODFPS9FncV5DXv
 x5aA5vvOPDSCWTxE3iVk0z2rh9GkPO6IkAJKOYLo+LcJ8euCNn66WYZ5HOOB3qLLV9wMUh9QPhT
 jA1UJoOF24z+Zju5U3g==
X-Authority-Analysis: v=2.4 cv=bv58wkai c=1 sm=1 tr=0 ts=69e7ba03 cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=_78whYxrdx1mplLwxq1U:22 a=FOH2dFAWAAAA:8 a=FWv110D_93i-94zjWioA:9
X-Proofpoint-GUID: bszFRjgj7HOtpbGcWt31PZ6rHChE_qLU
X-Proofpoint-ORIG-GUID: bszFRjgj7HOtpbGcWt31PZ6rHChE_qLU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-21_03,2026-04-21_02,2025-10-01_01

Replace slow 64-bit div/idiv instructions (10-20 cycles on latest x86,
even slower with older models) with fast multiply-and-shift sequences
(~4-5 cycles) for BPF_K div/mod operations, using the
Granlund-Montgomery algorithm.

For each 64-bit BPF_ALU64_{DIV,MOD}_K instruction with a non-zero
immediate divisor, the JIT computes a magic multiplier and shift at
JIT compile time via choose_multiplier_64(), then emits:

  Unsigned: floor(n/d) =3D mulhi(n, m) >> s
  Signed:   trunc(n/d) =3D mulhi_signed(n, m) >> s + sign_correction

Both unsigned (mul + wide correction) and signed (imul + add-n
correction) variants are implemented. Remainder is computed as
r =3D n - q * d. The optimization targets 64-bit operations only, as
LLVM already optimizes 32-bit cases at the compiler level.

The change doesn't put much effort in optimizing cases expected to
be handled by LLVM, such as 32-bit division by an immediate, or
power-of-2 divisors, which produce correct but suboptimal code sequence
(still faster than div/idiv). BPF LLVM cannot apply the optimization for
64-bit division because it would need an instruction that can do 128-bit
by 64-bit division (like x86's DIV and IDIV)

- div128_u64(): inline asm helper for 128-bit division using two divq
  steps, avoiding libgcc dependency
- choose_multiplier_64(): compute magic multiplier m, shift s, and
  is_wide flag for a given divisor and precision
- emit_udivmod_const(): unsigned 64-bit div/mod code generation with
  mul/shr and optional wide correction ((n-t)/2+t) path
- emit_sdivmod_const(): signed 64-bit div/mod code generation with
  imul/sar, add-n correction for overflowing m, sign correction
  (add sign bit to round toward zero), and negation for negative
  divisors
- emit_divmod_const(): top-level dispatch; falls back to div/idiv for
  32-bit, divisor=3D0, or negative unsigned immediates

Test Plan:

 test_bpf: Summary: 1061 PASSED, 0 FAILED, [1049/1049 JIT'ed]
 test_bpf: test_tail_calls: Summary: 10 PASSED, 0 FAILED, [10/10 JIT'ed]
 test_bpf: test_skb_segment: Summary: 2 PASSED, 0 FAILED

Assisted-by: Claude:claude-opus-4-6
Signed-off-by: Jie Meng <jmeng@fb.com>
---
 arch/x86/net/bpf_jit_comp.c | 286 ++++++++++++++++++++++++++++++++++++
 1 file changed, 286 insertions(+)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index ea9e707e8abf..39182355d61d 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -1649,6 +1649,286 @@ static int emit_spectre_bhb_barrier(u8 **pprog, u=
8 *ip,
 	return 0;
 }
=20
+/*
+ * ---------- Division by compile-time constant optimization ----------
+ *
+ * For 64-bit BPF_K (immediate divisor) div/mod operations, replace slow
+ * div/idiv instructions (15+ cycles) with fast multiply+shift sequences
+ * (~4 cycles).
+ *
+ * LLVM already optimizes power-of-2 divisors and 32-bit operations at t=
he
+ * compiler level, so this JIT optimization only focuses on 64-bit divis=
ion by
+ * general constants, both signed and unsigned. For power-of-2 divisors,=
 the
+ * algorithm generates instructions yielding correct results, but isn't =
the
+ * most optimal for performance (still faster than div/idiv though).
+ */
+
+struct bpf_jit_div_const {
+	u64 m;        /* magic multiplier */
+	u8 shift;     /* post-shift amount */
+	bool is_wide; /* unsigned: m > 2^64, needs (n-t)/2+t correction
+		       * signed: m overflows, needs add-n correction
+		       */
+};
+
+/*
+ * Divide a 128-bit value (n_hi:n_lo) by a u64 divisor using x86-64 divq=
.
+ * Do not rely on libgcc for 128-bit division. Two divq steps give a ful=
l
+ * 128-bit quotient.
+ */
+static inline unsigned __int128 div128_u64(u64 n_hi, u64 n_lo, u64 d)
+{
+	u64 q_hi, q_lo, rem;
+
+	asm("divq %[d]" : "=3Da"(q_hi), "=3Dd"(rem)
+	    : "a"(n_hi), "d"(0ULL), [d] "rm"(d));
+	asm("divq %[d]" : "=3Da"(q_lo), "=3Dd"(rem)
+	    : "a"(n_lo), "d"(rem), [d] "rm"(d));
+
+	return ((unsigned __int128)q_hi << 64) | q_lo;
+}
+
+/*
+ * Granlund-Montgomery choose_multiplier for 64-bit division by constant=
.
+ * Computes magic multiplier m and shift s such that:
+ *   unsigned: floor(n/d) =3D mulhi(n, m) >> s  (with possible wide corr=
ection)
+ *   signed:   floor(n/d) =3D mulhi_signed(n, m) >> s + sign_correction
+ *
+ * prec =3D 64 for unsigned, 63 for signed (sign bit reduces usable rang=
e).
+ */
+static bool choose_multiplier_64(u32 d, u8 prec, struct bpf_jit_div_cons=
t *c)
+{
+	unsigned __int128 mlow, mhigh;
+	u32 l, post_shift;
+
+	if (d <=3D 1)
+		return false;
+
+	l =3D fls(d - 1);
+
+	mlow =3D div128_u64(1ULL << l, 0, d);
+	mhigh =3D div128_u64(1ULL << l, 1ULL << (l + 64 - prec), d);
+
+	post_shift =3D l;
+	while (post_shift > 0) {
+		unsigned __int128 lo =3D mlow >> 1, hi =3D mhigh >> 1;
+
+		if (lo >=3D hi)
+			break;
+		mlow =3D lo;
+		mhigh =3D hi;
+		post_shift--;
+	}
+
+	c->m =3D (u64)mhigh;
+	c->shift =3D post_shift;
+	c->is_wide =3D (mhigh >> 64) !=3D 0;
+	return true;
+}
+
+/* Unsigned 64-bit div/mod by constant via multiply+shift */
+static void emit_udivmod_const(u8 **pprog, u32 dst_reg, u32 d,
+			       const struct bpf_jit_div_const *c, bool is_mod)
+{
+	u8 *prog =3D *pprog;
+
+	/* For MOD, save original n for remainder =3D n - q * d */
+	if (is_mod) {
+		maybe_emit_1mod(&prog, dst_reg, false); /* push dst */
+		EMIT1(add_1reg(0x50, dst_reg));
+	}
+
+	if (dst_reg !=3D BPF_REG_0)
+		EMIT1(0x50); /* push rax */
+	if (dst_reg !=3D BPF_REG_3)
+		EMIT1(0x52); /* push rdx */
+	if (dst_reg !=3D BPF_REG_0)
+		emit_mov_reg(&prog, true, BPF_REG_0, dst_reg); /* mov rax, dst */
+	if (c->is_wide)
+		EMIT1(0x50); /* push rax (=3D n, for wide correction) */
+
+	/* movabs r11, m */
+	emit_mov_imm64(&prog, AUX_REG, (u32)(c->m >> 32), (u32)c->m);
+
+	/* mul r11 -> rdx:rax =3D rax * r11 (unsigned) */
+	EMIT1(add_1mod(0x48, AUX_REG));
+	EMIT2(0xF7, add_1reg(0xE0, AUX_REG));
+
+	if (c->is_wide) {
+		/*
+		 * Wide correction: quotient =3D ((n - t) >> 1 + t) >> (shift-1)
+		 * where t =3D mulhi(n, m) in rdx
+		 */
+		EMIT2(0x41, 0x5B); /* pop r11 (=3D n) */
+		/* sub r11, rdx */
+		EMIT1(add_2mod(0x48, AUX_REG, BPF_REG_3));
+		EMIT2(0x29, add_2reg(0xC0, AUX_REG, BPF_REG_3));
+		/* shr r11, 1 */
+		EMIT1(add_1mod(0x48, AUX_REG));
+		EMIT2(0xD1, add_1reg(0xE8, AUX_REG));
+		/* add r11, rdx */
+		EMIT1(add_2mod(0x48, AUX_REG, BPF_REG_3));
+		EMIT2(0x01, add_2reg(0xC0, AUX_REG, BPF_REG_3));
+		/* shr r11, shift-1 */
+		if (c->shift > 1) {
+			EMIT1(add_1mod(0x48, AUX_REG));
+			EMIT3(0xC1, add_1reg(0xE8, AUX_REG),
+			      c->shift - 1);
+		}
+		/* mov dst, r11 */
+		emit_mov_reg(&prog, true, dst_reg, AUX_REG);
+	} else {
+		/* shr rdx, shift */
+		if (c->shift) {
+			EMIT1(0x48);
+			EMIT3(0xC1, add_1reg(0xE8, BPF_REG_3), c->shift);
+		}
+		/* mov dst, rdx */
+		if (dst_reg !=3D BPF_REG_3)
+			emit_mov_reg(&prog, true, dst_reg, BPF_REG_3);
+	}
+
+	if (dst_reg !=3D BPF_REG_3)
+		EMIT1(0x5A); /* pop rdx */
+	if (dst_reg !=3D BPF_REG_0)
+		EMIT1(0x58); /* pop rax */
+
+	/* dst =3D quotient; compute remainder if needed */
+	if (is_mod) {
+		/* imul r11, dst, d -> r11 =3D quotient * d */
+		maybe_emit_mod(&prog, dst_reg, AUX_REG, true);
+		if (is_imm8(d))
+			EMIT3(0x6B, add_2reg(0xC0, dst_reg, AUX_REG), d);
+		else
+			EMIT2_off32(0x69,
+				    add_2reg(0xC0, dst_reg, AUX_REG), d);
+		/* pop dst (=3D original n) */
+		maybe_emit_1mod(&prog, dst_reg, false);
+		EMIT1(add_1reg(0x58, dst_reg));
+		/* sub dst, r11 -> remainder =3D n - q*d */
+		maybe_emit_mod(&prog, dst_reg, AUX_REG, true);
+		EMIT2(0x29, add_2reg(0xC0, dst_reg, AUX_REG));
+	}
+
+	*pprog =3D prog;
+}
+
+/* Signed 64-bit div/mod by constant via multiply+shift */
+static void emit_sdivmod_const(u8 **pprog, u32 dst_reg, s32 imm,
+			       const struct bpf_jit_div_const *c, bool is_mod)
+{
+	u8 *prog =3D *pprog;
+	bool neg_divisor =3D (imm < 0);
+
+	/* For MOD, save original n for remainder =3D n - q * d */
+	if (is_mod) {
+		maybe_emit_1mod(&prog, dst_reg, false); /* push dst */
+		EMIT1(add_1reg(0x50, dst_reg));
+	}
+
+	if (dst_reg !=3D BPF_REG_0)
+		EMIT1(0x50); /* push rax */
+	if (dst_reg !=3D BPF_REG_3)
+		EMIT1(0x52); /* push rdx */
+	if (dst_reg !=3D BPF_REG_0)
+		emit_mov_reg(&prog, true, BPF_REG_0, dst_reg); /* mov rax, dst */
+	if (c->is_wide)
+		EMIT1(0x50); /* push rax (=3D n, for wide correction) */
+
+	/* movabs r11, m */
+	emit_mov_imm64(&prog, AUX_REG, (u32)(c->m >> 32), (u32)c->m);
+
+	/* imul r11 -> rdx:rax =3D rax * r11 (signed) */
+	EMIT1(add_1mod(0x48, AUX_REG));
+	EMIT2(0xF7, add_1reg(0xE8, AUX_REG));
+
+	if (c->is_wide) {
+		/* Wide correction: rdx +=3D n (bit 63 set in m) */
+		EMIT2(0x41, 0x5B); /* pop r11 (=3D n) */
+		/* add rdx, r11 */
+		EMIT1(add_2mod(0x48, BPF_REG_3, AUX_REG));
+		EMIT2(0x01, add_2reg(0xC0, BPF_REG_3, AUX_REG));
+	}
+
+	/* sar rdx, shift */
+	if (c->shift) {
+		EMIT1(0x48);
+		EMIT3(0xC1, add_1reg(0xF8, BPF_REG_3), c->shift);
+	}
+
+	/* Sign correction: round toward zero by adding sign bit */
+	emit_mov_reg(&prog, true, AUX_REG, BPF_REG_3); /* mov r11, rdx */
+	EMIT1(add_1mod(0x48, AUX_REG));
+	EMIT3(0xC1, add_1reg(0xE8, AUX_REG), 63); /* shr r11, 63 */
+	EMIT1(add_2mod(0x48, BPF_REG_3, AUX_REG));
+	EMIT2(0x01, add_2reg(0xC0, BPF_REG_3, AUX_REG)); /* add rdx, r11 */
+
+	/* mov dst, rdx */
+	if (dst_reg !=3D BPF_REG_3)
+		emit_mov_reg(&prog, true, dst_reg, BPF_REG_3);
+	if (dst_reg !=3D BPF_REG_3)
+		EMIT1(0x5A); /* pop rdx */
+	if (dst_reg !=3D BPF_REG_0)
+		EMIT1(0x58); /* pop rax */
+
+	/* neg dst (if divisor was negative) */
+	if (neg_divisor) {
+		EMIT1(add_1mod(0x48, dst_reg));
+		EMIT2(0xF7, add_1reg(0xD8, dst_reg));
+	}
+
+	/* dst =3D quotient; compute remainder if needed */
+	if (is_mod) {
+		/* imul r11, dst, d -> r11 =3D quotient * d */
+		maybe_emit_mod(&prog, dst_reg, AUX_REG, true);
+		if (is_imm8(imm))
+			EMIT3(0x6B, add_2reg(0xC0, dst_reg, AUX_REG), imm);
+		else
+			EMIT2_off32(0x69,
+				    add_2reg(0xC0, dst_reg, AUX_REG), imm);
+		/* pop dst (=3D original n) */
+		maybe_emit_1mod(&prog, dst_reg, false);
+		EMIT1(add_1reg(0x58, dst_reg));
+		/* sub dst, r11 -> remainder =3D n - q*d */
+		maybe_emit_mod(&prog, dst_reg, AUX_REG, true);
+		EMIT2(0x29, add_2reg(0xC0, dst_reg, AUX_REG));
+	}
+
+	*pprog =3D prog;
+}
+
+static bool emit_divmod_const(u8 **pprog, u32 dst_reg, s32 imm, bool is6=
4,
+			      bool is_mod, bool is_signed)
+{
+	struct bpf_jit_div_const c;
+
+    /* Assuming that LLVM already optimizes 32-bit */
+	if (!is64 || imm =3D=3D 0)
+		return false;
+
+	if (!is_signed) {
+		if (imm < 0)
+			return false;
+		if (!choose_multiplier_64((u32)imm, 64, &c))
+			return false;
+		emit_udivmod_const(pprog, dst_reg, (u32)imm, &c, is_mod);
+	} else {
+		u32 ad =3D (imm > 0) ? (u32)imm : (u32)(-imm);
+
+		if (ad <=3D 1)
+			return false;
+		if (!choose_multiplier_64(ad, 63, &c))
+			return false;
+		/* For signed, is_wide means bit 63 is set (m appears
+		 * negative to imul), not that it exceeds 2^64.
+		 */
+		c.is_wide =3D (c.m >> 63) !=3D 0;
+		emit_sdivmod_const(pprog, dst_reg, imm, &c, is_mod);
+	}
+
+	return true;
+}
+
 static int do_jit(struct bpf_verifier_env *env, struct bpf_prog *bpf_pro=
g, int *addrs, u8 *image,
 		  u8 *rw_image, int oldproglen, struct jit_context *ctx, bool jmp_padd=
ing)
 {
@@ -1891,6 +2171,12 @@ static int do_jit(struct bpf_verifier_env *env, st=
ruct bpf_prog *bpf_prog, int *
 		case BPF_ALU64 | BPF_DIV | BPF_K: {
 			bool is64 =3D BPF_CLASS(insn->code) =3D=3D BPF_ALU64;
=20
+			if (BPF_SRC(insn->code) =3D=3D BPF_K &&
+			    emit_divmod_const(&prog, dst_reg, imm32, is64,
+					     BPF_OP(insn->code) =3D=3D BPF_MOD,
+					     insn->off !=3D 0))
+				break;
+
 			if (dst_reg !=3D BPF_REG_0)
 				EMIT1(0x50); /* push rax */
 			if (dst_reg !=3D BPF_REG_3)
--=20
2.52.0

