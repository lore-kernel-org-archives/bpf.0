Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 897EF30216D
	for <bpf@vger.kernel.org>; Mon,  6 Apr 2026 20:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775508024; cv=none; b=WpQ7BwpAapNROeZrLga34E+J+lSgJtdn+ePYFkQFR+2f0rD+274Tewx8IahIy0aIA/k1t0/H8qY3xdSbemTG8otSkU6imLle6nPxp9zRTQ2J4+Vt7Bf7ezsvmJgsEdthnicQ15kE7aqXfHDyma90eIm6w3lhl6bYd7UaJ0Ww958=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775508024; c=relaxed/simple;
	bh=CsvHdh+AfHq2/663zmM47yJ51xS8td8tmFOlPwWbc6Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qxz4IUMqe889FyHxfT10YBecjCs7Wf+kdemzgj3EB9COFfBGUsiHOFOI6TIB1OdGKVk+ZhNYsNh5RRqsRvjFJ9j3UKxfLsROc9unm6Ky4x/OkWvwWJr4vpgQX1Ujztk48y4fEEFFxr1fgpA3gihQBV4CGzwLtVrqlQc5TVzVfcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=fb.com header.i=@fb.com header.b=s4pb6Sma; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fb.com header.i=@fb.com header.b="s4pb6Sma"
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 636DwHAF465538
	for <bpf@vger.kernel.org>; Mon, 6 Apr 2026 13:40:20 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=BrxsbPvY18V6ORTTMD+51i/xpBTKxgnkNYlHy0SSl9k=; b=s4pb6SmavPrO
	ZnDho5ZYgMAaQObtubYkyTWHRWqE5tEfjq9qEeqjvTys1+PD+RzZkN3He7wkG2lK
	4o1YpCYhTNqWcd53cfBhwNd/xzolSuEfO1tFvZpEAWWV+s1ihYVr4MPc3tHOO0mI
	bFdDziA4Lhu1nSCfNzjaDGNUmIXCdznnD8Nyok9WAnagjHiMAZEgKOnoJ4llIASx
	hK1mkvNn54sVBRYzkftaotuiR3KE9QDlrPYUOF9N+JL57NRnx8WxqW4DECDYVJld
	P3mo/Xiln5kwoFMuKMlvfIivie1HULqbKwquhhZVWNc6oLeHAUaQtYPF/aeYS5eC
	AVT5OXSyXA==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4db0axtgym-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Mon, 06 Apr 2026 13:40:20 -0700 (PDT)
Received: from twshared62801.02.prn5.facebook.com (2620:10d:c0a8:1b::8e35) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.35; Mon, 6 Apr 2026 20:40:19 +0000
Received: by devvm14451.vll0.facebook.com (Postfix, from userid 187975)
	id 5468E584354B9; Mon,  6 Apr 2026 13:40:04 -0700 (PDT)
From: Jie Meng <jmeng@fb.com>
To: <alexei.starovoitov@gmail.com>
CC: <andrii@kernel.org>, <ast@kernel.org>, <bpf@vger.kernel.org>,
        <daniel@iogearbox.net>, Jie Meng <jmeng@fb.com>
Subject: [PATCH v2] bpf/tests: Exhaustive test coverage for signed division and modulo
Date: Mon, 6 Apr 2026 13:39:50 -0700
Message-ID: <20260406203950.2669356-1-jmeng@fb.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <CAADnVQKXio6nh+3OLkJb3C5FyGS404ZAQEPpwxVD6Bsr444ahQ@mail.gmail.com>
References: <CAADnVQKXio6nh+3OLkJb3C5FyGS404ZAQEPpwxVD6Bsr444ahQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA2MDIwMiBTYWx0ZWRfX7HPqU0MoLmlZ
 /7wMpv3PKmbVSZxepUV2SuaUgjF3RkpdJXWI22GBdLAf4ukdv50ThoMttqGFBO8ca8x6zQ7+OiQ
 MQc9YjORkOWCUTBWK7zrn18i2nPVz9Rl/8mPdShiF+iDEa0t1Q11EWd1b/KDdgveTNqgQCCeJJ2
 iMPVpS99ie6Qcx7ueErq4Jxtolv8Q0k7gMOYlP3E+aLR00fNAoSf7go313KQGAi06GU3TspwiSi
 Ng+yslp7+KDg7fthLhdeEK6wwT6vq8gCuYcZjbXb4QQsPjHf3rC96oy4mUU0mZg4BmRJkhCQeqG
 f5rpdMlUQJCn8L1Ie4OrsRAMYgRozyACHgwcJBg79N/SE5tYn3E+0o49vuYyh1YIoLCxD16ZfOD
 ctLGZzETfowc3MJ6pAACpZh3klvfDFIjyTmr7kXuYb4v9fpw9dgTWFeI6RlRx8keR0wFz2Y3Ao2
 ACt53w0fK08vRuXl71w==
X-Proofpoint-GUID: VFTuJPDMrhWuJ3dChqQd0pdR-zUq4EvO
X-Authority-Analysis: v=2.4 cv=F/Nat6hN c=1 sm=1 tr=0 ts=69d41a34 cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=PAz_-FQ8hEVmOPYdF0yf:22 a=FOH2dFAWAAAA:8 a=yWc4s_t62PmSMwoZswwA:9
X-Proofpoint-ORIG-GUID: VFTuJPDMrhWuJ3dChqQd0pdR-zUq4EvO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-06_04,2026-04-03_01,2025-10-01_01

Extend lib/test_bpf.c to provide comprehensive test coverage for BPF
signed division (SDIV) and signed modulo (SMOD) instructions, both
32-bit and 64-bit variants with immediate operands.

Introduce F_ALU32 and F_SIGNED flags to replace the less readable
bool alu32 and s16 off parameters throughout the test helpers. The
BPF instruction 'off' field is derived from flags only at the point
of instruction encoding.

Changes:
- Add enum { F_ALU32 =3D 1, F_SIGNED =3D 2 } for readable test flags.
- __bpf_alu_result(): add is_signed parameter to select signed vs
  unsigned div/mod semantics. When is_signed, uses div64_s64() / s64
  modulo with truncation toward zero, matching BPF signed division
  spec. Skips divisor =3D=3D -1 cases (handled by verifier).
- __bpf_emit_alu64_imm(), __bpf_emit_alu32_imm(): extract flags from
  arg array, derive is_signed and off for instruction encoding.
  For ALU32 signed, cast operands to s32 before computing reference
  results.
- __bpf_fill_alu_imm_regs(): take u32 flags instead of bool alu32
  and s16 off. Use F_ALU32/F_SIGNED for operand setup and result
  computation. Properly cast operands to (s32) for ALU32 signed
  cases to match 32-bit signed division semantics.
- __bpf_fill_alu_shift(), __bpf_fill_alu_shift_same_reg(): convert
  bool alu32 parameter to u32 flags for consistency.
- New test fill functions: bpf_fill_alu{32,64}_{sdiv,smod}_imm() and
  bpf_fill_alu{32,64}_{sdiv,smod}_imm_regs(), each testing all
  immediate value magnitudes and all register pair combinations.
- All existing unsigned tests updated to use flags (0 or F_ALU32),
  preserving backward compatibility.

8 new test cases added:
  ALU64_SDIV_K, ALU64_SMOD_K (immediate magnitudes + register combos)
  ALU32_SDIV_K, ALU32_SMOD_K (immediate magnitudes + register combos)

Test results:
  test_bpf: Summary: 1061 PASSED, 0 FAILED, [1049/1049 JIT'ed]
  test_bpf: test_tail_calls: Summary: 10 PASSED, 0 FAILED, [10/10 JIT'ed]
  test_bpf: test_skb_segment: Summary: 2 PASSED, 0 FAILED

Assisted-by: Claude:claude-opus-4-6
Signed-off-by: Jie Meng <jmeng@fb.com>
---
v1 -> v2: addressed Alexei's comments about readability

 lib/test_bpf.c | 366 +++++++++++++++++++++++++++++++++++--------------
 1 file changed, 266 insertions(+), 100 deletions(-)

diff --git a/lib/test_bpf.c b/lib/test_bpf.c
index 5892c0f17ddc..8f29bbbf810e 100644
--- a/lib/test_bpf.c
+++ b/lib/test_bpf.c
@@ -560,7 +560,9 @@ static int bpf_fill_max_jmp_never_taken(struct bpf_te=
st *self)
 }
=20
 /* ALU result computation used in tests */
-static bool __bpf_alu_result(u64 *res, u64 v1, u64 v2, u8 op)
+enum { F_ALU32 =3D 1, F_SIGNED =3D 2 };
+
+static bool __bpf_alu_result(u64 *res, u64 v1, u64 v2, u8 op, bool is_si=
gned)
 {
 	*res =3D 0;
 	switch (op) {
@@ -599,12 +601,28 @@ static bool __bpf_alu_result(u64 *res, u64 v1, u64 =
v2, u8 op)
 	case BPF_DIV:
 		if (v2 =3D=3D 0)
 			return false;
-		*res =3D div64_u64(v1, v2);
+		if (!is_signed) {
+			*res =3D div64_u64(v1, v2);
+		} else {
+			if ((s64)v2 =3D=3D -1) /* Handled by verifier */
+				return false;
+			*res =3D (u64)div64_s64(v1, v2);
+		}
 		break;
 	case BPF_MOD:
 		if (v2 =3D=3D 0)
 			return false;
-		div64_u64_rem(v1, v2, res);
+		if (!is_signed) {
+			div64_u64_rem(v1, v2, res);
+		} else {
+			if ((s64)v2 =3D=3D -1)
+				return false;
+			/*
+			 * Avoid s64 % s64 which generates __moddi3 on
+			 * 32-bit architectures. Use div64_s64 instead.
+			 */
+			*res =3D (u64)((s64)v1 - div64_s64(v1, v2) * (s64)v2);
+		}
 		break;
 	}
 	return true;
@@ -612,7 +630,7 @@ static bool __bpf_alu_result(u64 *res, u64 v1, u64 v2=
, u8 op)
=20
 /* Test an ALU shift operation for all valid shift values */
 static int __bpf_fill_alu_shift(struct bpf_test *self, u8 op,
-				u8 mode, bool alu32)
+				u8 mode, u32 flags)
 {
 	static const s64 regs[] =3D {
 		0x0123456789abcdefLL, /* dword > 0, word < 0 */
@@ -620,7 +638,7 @@ static int __bpf_fill_alu_shift(struct bpf_test *self=
, u8 op,
 		0xfedcba0198765432LL, /* dword < 0, word < 0 */
 		0x0123458967abcdefLL, /* dword > 0, word > 0 */
 	};
-	int bits =3D alu32 ? 32 : 64;
+	int bits =3D (flags & F_ALU32) ? 32 : 64;
 	int len =3D (2 + 7 * bits) * ARRAY_SIZE(regs) + 3;
 	struct bpf_insn *insn;
 	int imm, k;
@@ -643,7 +661,7 @@ static int __bpf_fill_alu_shift(struct bpf_test *self=
, u8 op,
 			/* Perform operation */
 			insn[i++] =3D BPF_ALU64_REG(BPF_MOV, R1, R3);
 			insn[i++] =3D BPF_ALU64_IMM(BPF_MOV, R2, imm);
-			if (alu32) {
+			if (flags & F_ALU32) {
 				if (mode =3D=3D BPF_K)
 					insn[i++] =3D BPF_ALU32_IMM(op, R1, imm);
 				else
@@ -653,14 +671,14 @@ static int __bpf_fill_alu_shift(struct bpf_test *se=
lf, u8 op,
 					reg =3D (s32)reg;
 				else
 					reg =3D (u32)reg;
-				__bpf_alu_result(&val, reg, imm, op);
+				__bpf_alu_result(&val, reg, imm, op, false);
 				val =3D (u32)val;
 			} else {
 				if (mode =3D=3D BPF_K)
 					insn[i++] =3D BPF_ALU64_IMM(op, R1, imm);
 				else
 					insn[i++] =3D BPF_ALU64_REG(op, R1, R2);
-				__bpf_alu_result(&val, reg, imm, op);
+				__bpf_alu_result(&val, reg, imm, op, false);
 			}
=20
 			/*
@@ -688,62 +706,62 @@ static int __bpf_fill_alu_shift(struct bpf_test *se=
lf, u8 op,
=20
 static int bpf_fill_alu64_lsh_imm(struct bpf_test *self)
 {
-	return __bpf_fill_alu_shift(self, BPF_LSH, BPF_K, false);
+	return __bpf_fill_alu_shift(self, BPF_LSH, BPF_K, 0);
 }
=20
 static int bpf_fill_alu64_rsh_imm(struct bpf_test *self)
 {
-	return __bpf_fill_alu_shift(self, BPF_RSH, BPF_K, false);
+	return __bpf_fill_alu_shift(self, BPF_RSH, BPF_K, 0);
 }
=20
 static int bpf_fill_alu64_arsh_imm(struct bpf_test *self)
 {
-	return __bpf_fill_alu_shift(self, BPF_ARSH, BPF_K, false);
+	return __bpf_fill_alu_shift(self, BPF_ARSH, BPF_K, 0);
 }
=20
 static int bpf_fill_alu64_lsh_reg(struct bpf_test *self)
 {
-	return __bpf_fill_alu_shift(self, BPF_LSH, BPF_X, false);
+	return __bpf_fill_alu_shift(self, BPF_LSH, BPF_X, 0);
 }
=20
 static int bpf_fill_alu64_rsh_reg(struct bpf_test *self)
 {
-	return __bpf_fill_alu_shift(self, BPF_RSH, BPF_X, false);
+	return __bpf_fill_alu_shift(self, BPF_RSH, BPF_X, 0);
 }
=20
 static int bpf_fill_alu64_arsh_reg(struct bpf_test *self)
 {
-	return __bpf_fill_alu_shift(self, BPF_ARSH, BPF_X, false);
+	return __bpf_fill_alu_shift(self, BPF_ARSH, BPF_X, 0);
 }
=20
 static int bpf_fill_alu32_lsh_imm(struct bpf_test *self)
 {
-	return __bpf_fill_alu_shift(self, BPF_LSH, BPF_K, true);
+	return __bpf_fill_alu_shift(self, BPF_LSH, BPF_K, F_ALU32);
 }
=20
 static int bpf_fill_alu32_rsh_imm(struct bpf_test *self)
 {
-	return __bpf_fill_alu_shift(self, BPF_RSH, BPF_K, true);
+	return __bpf_fill_alu_shift(self, BPF_RSH, BPF_K, F_ALU32);
 }
=20
 static int bpf_fill_alu32_arsh_imm(struct bpf_test *self)
 {
-	return __bpf_fill_alu_shift(self, BPF_ARSH, BPF_K, true);
+	return __bpf_fill_alu_shift(self, BPF_ARSH, BPF_K, F_ALU32);
 }
=20
 static int bpf_fill_alu32_lsh_reg(struct bpf_test *self)
 {
-	return __bpf_fill_alu_shift(self, BPF_LSH, BPF_X, true);
+	return __bpf_fill_alu_shift(self, BPF_LSH, BPF_X, F_ALU32);
 }
=20
 static int bpf_fill_alu32_rsh_reg(struct bpf_test *self)
 {
-	return __bpf_fill_alu_shift(self, BPF_RSH, BPF_X, true);
+	return __bpf_fill_alu_shift(self, BPF_RSH, BPF_X, F_ALU32);
 }
=20
 static int bpf_fill_alu32_arsh_reg(struct bpf_test *self)
 {
-	return __bpf_fill_alu_shift(self, BPF_ARSH, BPF_X, true);
+	return __bpf_fill_alu_shift(self, BPF_ARSH, BPF_X, F_ALU32);
 }
=20
 /*
@@ -751,9 +769,9 @@ static int bpf_fill_alu32_arsh_reg(struct bpf_test *s=
elf)
  * for the case when the source and destination are the same.
  */
 static int __bpf_fill_alu_shift_same_reg(struct bpf_test *self, u8 op,
-					 bool alu32)
+					 u32 flags)
 {
-	int bits =3D alu32 ? 32 : 64;
+	int bits =3D (flags & F_ALU32) ? 32 : 64;
 	int len =3D 3 + 6 * bits;
 	struct bpf_insn *insn;
 	int i =3D 0;
@@ -770,14 +788,14 @@ static int __bpf_fill_alu_shift_same_reg(struct bpf=
_test *self, u8 op,
=20
 		/* Perform operation */
 		insn[i++] =3D BPF_ALU64_IMM(BPF_MOV, R1, val);
-		if (alu32)
+		if (flags & F_ALU32)
 			insn[i++] =3D BPF_ALU32_REG(op, R1, R1);
 		else
 			insn[i++] =3D BPF_ALU64_REG(op, R1, R1);
=20
 		/* Compute the reference result */
-		__bpf_alu_result(&res, val, val, op);
-		if (alu32)
+		__bpf_alu_result(&res, val, val, op, false);
+		if (flags & F_ALU32)
 			res =3D (u32)res;
 		i +=3D __bpf_ld_imm64(&insn[i], R2, res);
=20
@@ -798,32 +816,32 @@ static int __bpf_fill_alu_shift_same_reg(struct bpf=
_test *self, u8 op,
=20
 static int bpf_fill_alu64_lsh_same_reg(struct bpf_test *self)
 {
-	return __bpf_fill_alu_shift_same_reg(self, BPF_LSH, false);
+	return __bpf_fill_alu_shift_same_reg(self, BPF_LSH, 0);
 }
=20
 static int bpf_fill_alu64_rsh_same_reg(struct bpf_test *self)
 {
-	return __bpf_fill_alu_shift_same_reg(self, BPF_RSH, false);
+	return __bpf_fill_alu_shift_same_reg(self, BPF_RSH, 0);
 }
=20
 static int bpf_fill_alu64_arsh_same_reg(struct bpf_test *self)
 {
-	return __bpf_fill_alu_shift_same_reg(self, BPF_ARSH, false);
+	return __bpf_fill_alu_shift_same_reg(self, BPF_ARSH, 0);
 }
=20
 static int bpf_fill_alu32_lsh_same_reg(struct bpf_test *self)
 {
-	return __bpf_fill_alu_shift_same_reg(self, BPF_LSH, true);
+	return __bpf_fill_alu_shift_same_reg(self, BPF_LSH, F_ALU32);
 }
=20
 static int bpf_fill_alu32_rsh_same_reg(struct bpf_test *self)
 {
-	return __bpf_fill_alu_shift_same_reg(self, BPF_RSH, true);
+	return __bpf_fill_alu_shift_same_reg(self, BPF_RSH, F_ALU32);
 }
=20
 static int bpf_fill_alu32_arsh_same_reg(struct bpf_test *self)
 {
-	return __bpf_fill_alu_shift_same_reg(self, BPF_ARSH, true);
+	return __bpf_fill_alu_shift_same_reg(self, BPF_ARSH, F_ALU32);
 }
=20
 /*
@@ -936,17 +954,21 @@ static int __bpf_fill_pattern(struct bpf_test *self=
, void *arg,
 static int __bpf_emit_alu64_imm(struct bpf_test *self, void *arg,
 				struct bpf_insn *insns, s64 dst, s64 imm)
 {
-	int op =3D *(int *)arg;
+	int *a =3D arg;
+	int op =3D a[0];
+	u32 flags =3D a[1];
+	bool is_signed =3D flags & F_SIGNED;
+	s16 off =3D is_signed ? 1 : 0;
 	int i =3D 0;
 	u64 res;
=20
 	if (!insns)
 		return 7;
=20
-	if (__bpf_alu_result(&res, dst, (s32)imm, op)) {
+	if (__bpf_alu_result(&res, dst, (s32)imm, op, is_signed)) {
 		i +=3D __bpf_ld_imm64(&insns[i], R1, dst);
 		i +=3D __bpf_ld_imm64(&insns[i], R3, res);
-		insns[i++] =3D BPF_ALU64_IMM(op, R1, imm);
+		insns[i++] =3D BPF_ALU64_IMM_OFF(op, R1, imm, off);
 		insns[i++] =3D BPF_JMP_REG(BPF_JEQ, R1, R3, 1);
 		insns[i++] =3D BPF_EXIT_INSN();
 	}
@@ -957,17 +979,30 @@ static int __bpf_emit_alu64_imm(struct bpf_test *se=
lf, void *arg,
 static int __bpf_emit_alu32_imm(struct bpf_test *self, void *arg,
 				struct bpf_insn *insns, s64 dst, s64 imm)
 {
-	int op =3D *(int *)arg;
+	int *a =3D arg;
+	int op =3D a[0];
+	u32 flags =3D a[1];
+	bool is_signed =3D flags & F_SIGNED;
+	s16 off =3D is_signed ? 1 : 0;
 	int i =3D 0;
 	u64 res;
+	u64 v1, v2;
=20
 	if (!insns)
 		return 7;
=20
-	if (__bpf_alu_result(&res, (u32)dst, (u32)imm, op)) {
+	if (is_signed) {
+		v1 =3D (s32)dst;
+		v2 =3D (s32)imm;
+	} else {
+		v1 =3D (u32)dst;
+		v2 =3D (u32)imm;
+	}
+
+	if (__bpf_alu_result(&res, v1, v2, op, is_signed)) {
 		i +=3D __bpf_ld_imm64(&insns[i], R1, dst);
 		i +=3D __bpf_ld_imm64(&insns[i], R3, (u32)res);
-		insns[i++] =3D BPF_ALU32_IMM(op, R1, imm);
+		insns[i++] =3D BPF_ALU32_IMM_OFF(op, R1, imm, off);
 		insns[i++] =3D BPF_JMP_REG(BPF_JEQ, R1, R3, 1);
 		insns[i++] =3D BPF_EXIT_INSN();
 	}
@@ -985,7 +1020,7 @@ static int __bpf_emit_alu64_reg(struct bpf_test *sel=
f, void *arg,
 	if (!insns)
 		return 9;
=20
-	if (__bpf_alu_result(&res, dst, src, op)) {
+	if (__bpf_alu_result(&res, dst, src, op, false)) {
 		i +=3D __bpf_ld_imm64(&insns[i], R1, dst);
 		i +=3D __bpf_ld_imm64(&insns[i], R2, src);
 		i +=3D __bpf_ld_imm64(&insns[i], R3, res);
@@ -1007,7 +1042,7 @@ static int __bpf_emit_alu32_reg(struct bpf_test *se=
lf, void *arg,
 	if (!insns)
 		return 9;
=20
-	if (__bpf_alu_result(&res, (u32)dst, (u32)src, op)) {
+	if (__bpf_alu_result(&res, (u32)dst, (u32)src, op, false)) {
 		i +=3D __bpf_ld_imm64(&insns[i], R1, dst);
 		i +=3D __bpf_ld_imm64(&insns[i], R2, src);
 		i +=3D __bpf_ld_imm64(&insns[i], R3, (u32)res);
@@ -1019,16 +1054,20 @@ static int __bpf_emit_alu32_reg(struct bpf_test *=
self, void *arg,
 	return i;
 }
=20
-static int __bpf_fill_alu64_imm(struct bpf_test *self, int op)
+static int __bpf_fill_alu64_imm(struct bpf_test *self, int op, u32 flags=
)
 {
-	return __bpf_fill_pattern(self, &op, 64, 32,
+	int arg[2] =3D {op, flags};
+
+	return __bpf_fill_pattern(self, &arg, 64, 32,
 				  PATTERN_BLOCK1, PATTERN_BLOCK2,
 				  &__bpf_emit_alu64_imm);
 }
=20
-static int __bpf_fill_alu32_imm(struct bpf_test *self, int op)
+static int __bpf_fill_alu32_imm(struct bpf_test *self, int op, u32 flags=
)
 {
-	return __bpf_fill_pattern(self, &op, 64, 32,
+	int arg[2] =3D {op, flags};
+
+	return __bpf_fill_pattern(self, &arg, 64, 32,
 				  PATTERN_BLOCK1, PATTERN_BLOCK2,
 				  &__bpf_emit_alu32_imm);
 }
@@ -1050,93 +1089,115 @@ static int __bpf_fill_alu32_reg(struct bpf_test =
*self, int op)
 /* ALU64 immediate operations */
 static int bpf_fill_alu64_mov_imm(struct bpf_test *self)
 {
-	return __bpf_fill_alu64_imm(self, BPF_MOV);
+	return __bpf_fill_alu64_imm(self, BPF_MOV, 0);
 }
=20
 static int bpf_fill_alu64_and_imm(struct bpf_test *self)
 {
-	return __bpf_fill_alu64_imm(self, BPF_AND);
+	return __bpf_fill_alu64_imm(self, BPF_AND, 0);
 }
=20
 static int bpf_fill_alu64_or_imm(struct bpf_test *self)
 {
-	return __bpf_fill_alu64_imm(self, BPF_OR);
+	return __bpf_fill_alu64_imm(self, BPF_OR, 0);
 }
=20
 static int bpf_fill_alu64_xor_imm(struct bpf_test *self)
 {
-	return __bpf_fill_alu64_imm(self, BPF_XOR);
+	return __bpf_fill_alu64_imm(self, BPF_XOR, 0);
 }
=20
 static int bpf_fill_alu64_add_imm(struct bpf_test *self)
 {
-	return __bpf_fill_alu64_imm(self, BPF_ADD);
+	return __bpf_fill_alu64_imm(self, BPF_ADD, 0);
 }
=20
 static int bpf_fill_alu64_sub_imm(struct bpf_test *self)
 {
-	return __bpf_fill_alu64_imm(self, BPF_SUB);
+	return __bpf_fill_alu64_imm(self, BPF_SUB, 0);
 }
=20
 static int bpf_fill_alu64_mul_imm(struct bpf_test *self)
 {
-	return __bpf_fill_alu64_imm(self, BPF_MUL);
+	return __bpf_fill_alu64_imm(self, BPF_MUL, 0);
 }
=20
 static int bpf_fill_alu64_div_imm(struct bpf_test *self)
 {
-	return __bpf_fill_alu64_imm(self, BPF_DIV);
+	return __bpf_fill_alu64_imm(self, BPF_DIV, 0);
 }
=20
 static int bpf_fill_alu64_mod_imm(struct bpf_test *self)
 {
-	return __bpf_fill_alu64_imm(self, BPF_MOD);
+	return __bpf_fill_alu64_imm(self, BPF_MOD, 0);
+}
+
+/* Signed ALU64 immediate operations */
+static int bpf_fill_alu64_sdiv_imm(struct bpf_test *self)
+{
+	return __bpf_fill_alu64_imm(self, BPF_DIV, F_SIGNED);
+}
+
+static int bpf_fill_alu64_smod_imm(struct bpf_test *self)
+{
+	return __bpf_fill_alu64_imm(self, BPF_MOD, F_SIGNED);
+}
+
+/* Signed ALU32 immediate operations */
+static int bpf_fill_alu32_sdiv_imm(struct bpf_test *self)
+{
+	return __bpf_fill_alu32_imm(self, BPF_DIV, F_SIGNED);
+}
+
+static int bpf_fill_alu32_smod_imm(struct bpf_test *self)
+{
+	return __bpf_fill_alu32_imm(self, BPF_MOD, F_SIGNED);
 }
=20
 /* ALU32 immediate operations */
 static int bpf_fill_alu32_mov_imm(struct bpf_test *self)
 {
-	return __bpf_fill_alu32_imm(self, BPF_MOV);
+	return __bpf_fill_alu32_imm(self, BPF_MOV, 0);
 }
=20
 static int bpf_fill_alu32_and_imm(struct bpf_test *self)
 {
-	return __bpf_fill_alu32_imm(self, BPF_AND);
+	return __bpf_fill_alu32_imm(self, BPF_AND, 0);
 }
=20
 static int bpf_fill_alu32_or_imm(struct bpf_test *self)
 {
-	return __bpf_fill_alu32_imm(self, BPF_OR);
+	return __bpf_fill_alu32_imm(self, BPF_OR, 0);
 }
=20
 static int bpf_fill_alu32_xor_imm(struct bpf_test *self)
 {
-	return __bpf_fill_alu32_imm(self, BPF_XOR);
+	return __bpf_fill_alu32_imm(self, BPF_XOR, 0);
 }
=20
 static int bpf_fill_alu32_add_imm(struct bpf_test *self)
 {
-	return __bpf_fill_alu32_imm(self, BPF_ADD);
+	return __bpf_fill_alu32_imm(self, BPF_ADD, 0);
 }
=20
 static int bpf_fill_alu32_sub_imm(struct bpf_test *self)
 {
-	return __bpf_fill_alu32_imm(self, BPF_SUB);
+	return __bpf_fill_alu32_imm(self, BPF_SUB, 0);
 }
=20
 static int bpf_fill_alu32_mul_imm(struct bpf_test *self)
 {
-	return __bpf_fill_alu32_imm(self, BPF_MUL);
+	return __bpf_fill_alu32_imm(self, BPF_MUL, 0);
 }
=20
 static int bpf_fill_alu32_div_imm(struct bpf_test *self)
 {
-	return __bpf_fill_alu32_imm(self, BPF_DIV);
+	return __bpf_fill_alu32_imm(self, BPF_DIV, 0);
 }
=20
 static int bpf_fill_alu32_mod_imm(struct bpf_test *self)
 {
-	return __bpf_fill_alu32_imm(self, BPF_MOD);
+	return __bpf_fill_alu32_imm(self, BPF_MOD, 0);
 }
=20
 /* ALU64 register operations */
@@ -1235,7 +1296,8 @@ static int bpf_fill_alu32_mod_reg(struct bpf_test *=
self)
  * Test JITs that implement complex ALU operations as function
  * calls, and must re-arrange operands for argument passing.
  */
-static int __bpf_fill_alu_imm_regs(struct bpf_test *self, u8 op, bool al=
u32)
+static int __bpf_fill_alu_imm_regs(struct bpf_test *self, u8 op,
+				    u32 flags)
 {
 	int len =3D 2 + 10 * 10;
 	struct bpf_insn *insns;
@@ -1249,28 +1311,42 @@ static int __bpf_fill_alu_imm_regs(struct bpf_tes=
t *self, u8 op, bool alu32)
 		return -ENOMEM;
=20
 	/* Operand and result values according to operation */
-	if (alu32)
-		dst =3D 0x76543210U;
-	else
-		dst =3D 0x7edcba9876543210ULL;
+	if (flags & F_SIGNED) {
+		if (flags & F_ALU32)
+			dst =3D -76543210;
+		else
+			dst =3D -7654321076543210LL;
+	} else {
+		if (flags & F_ALU32)
+			dst =3D 0x76543210U;
+		else
+			dst =3D 0x7edcba9876543210ULL;
+	}
 	imm =3D 0x01234567U;
=20
 	if (op =3D=3D BPF_LSH || op =3D=3D BPF_RSH || op =3D=3D BPF_ARSH)
 		imm &=3D 31;
=20
-	__bpf_alu_result(&res, dst, imm, op);
+	if ((flags & F_ALU32) && (flags & F_SIGNED))
+		__bpf_alu_result(&res, (u64)(s32)dst, (u64)(s32)imm, op, true);
+	else if (flags & F_ALU32)
+		__bpf_alu_result(&res, (u32)dst, (u32)imm, op, false);
+	else
+		__bpf_alu_result(&res, dst, imm, op, flags & F_SIGNED);
=20
-	if (alu32)
+	if (flags & F_ALU32)
 		res =3D (u32)res;
=20
 	/* Check all operand registers */
 	for (rd =3D R0; rd <=3D R9; rd++) {
 		i +=3D __bpf_ld_imm64(&insns[i], rd, dst);
=20
-		if (alu32)
-			insns[i++] =3D BPF_ALU32_IMM(op, rd, imm);
+		s16 off =3D (flags & F_SIGNED) ? 1 : 0;
+
+		if (flags & F_ALU32)
+			insns[i++] =3D BPF_ALU32_IMM_OFF(op, rd, imm, off);
 		else
-			insns[i++] =3D BPF_ALU64_IMM(op, rd, imm);
+			insns[i++] =3D BPF_ALU64_IMM_OFF(op, rd, imm, off);
=20
 		insns[i++] =3D BPF_JMP32_IMM(BPF_JEQ, rd, res, 2);
 		insns[i++] =3D BPF_MOV64_IMM(R0, __LINE__);
@@ -1295,123 +1371,145 @@ static int __bpf_fill_alu_imm_regs(struct bpf_t=
est *self, u8 op, bool alu32)
 /* ALU64 K registers */
 static int bpf_fill_alu64_mov_imm_regs(struct bpf_test *self)
 {
-	return __bpf_fill_alu_imm_regs(self, BPF_MOV, false);
+	return __bpf_fill_alu_imm_regs(self, BPF_MOV, 0);
 }
=20
 static int bpf_fill_alu64_and_imm_regs(struct bpf_test *self)
 {
-	return __bpf_fill_alu_imm_regs(self, BPF_AND, false);
+	return __bpf_fill_alu_imm_regs(self, BPF_AND, 0);
 }
=20
 static int bpf_fill_alu64_or_imm_regs(struct bpf_test *self)
 {
-	return __bpf_fill_alu_imm_regs(self, BPF_OR, false);
+	return __bpf_fill_alu_imm_regs(self, BPF_OR, 0);
 }
=20
 static int bpf_fill_alu64_xor_imm_regs(struct bpf_test *self)
 {
-	return __bpf_fill_alu_imm_regs(self, BPF_XOR, false);
+	return __bpf_fill_alu_imm_regs(self, BPF_XOR, 0);
 }
=20
 static int bpf_fill_alu64_lsh_imm_regs(struct bpf_test *self)
 {
-	return __bpf_fill_alu_imm_regs(self, BPF_LSH, false);
+	return __bpf_fill_alu_imm_regs(self, BPF_LSH, 0);
 }
=20
 static int bpf_fill_alu64_rsh_imm_regs(struct bpf_test *self)
 {
-	return __bpf_fill_alu_imm_regs(self, BPF_RSH, false);
+	return __bpf_fill_alu_imm_regs(self, BPF_RSH, 0);
 }
=20
 static int bpf_fill_alu64_arsh_imm_regs(struct bpf_test *self)
 {
-	return __bpf_fill_alu_imm_regs(self, BPF_ARSH, false);
+	return __bpf_fill_alu_imm_regs(self, BPF_ARSH, 0);
 }
=20
 static int bpf_fill_alu64_add_imm_regs(struct bpf_test *self)
 {
-	return __bpf_fill_alu_imm_regs(self, BPF_ADD, false);
+	return __bpf_fill_alu_imm_regs(self, BPF_ADD, 0);
 }
=20
 static int bpf_fill_alu64_sub_imm_regs(struct bpf_test *self)
 {
-	return __bpf_fill_alu_imm_regs(self, BPF_SUB, false);
+	return __bpf_fill_alu_imm_regs(self, BPF_SUB, 0);
 }
=20
 static int bpf_fill_alu64_mul_imm_regs(struct bpf_test *self)
 {
-	return __bpf_fill_alu_imm_regs(self, BPF_MUL, false);
+	return __bpf_fill_alu_imm_regs(self, BPF_MUL, 0);
 }
=20
 static int bpf_fill_alu64_div_imm_regs(struct bpf_test *self)
 {
-	return __bpf_fill_alu_imm_regs(self, BPF_DIV, false);
+	return __bpf_fill_alu_imm_regs(self, BPF_DIV, 0);
 }
=20
 static int bpf_fill_alu64_mod_imm_regs(struct bpf_test *self)
 {
-	return __bpf_fill_alu_imm_regs(self, BPF_MOD, false);
+	return __bpf_fill_alu_imm_regs(self, BPF_MOD, 0);
+}
+
+/* Signed ALU64 K registers */
+static int bpf_fill_alu64_sdiv_imm_regs(struct bpf_test *self)
+{
+	return __bpf_fill_alu_imm_regs(self, BPF_DIV, F_SIGNED);
+}
+
+static int bpf_fill_alu64_smod_imm_regs(struct bpf_test *self)
+{
+	return __bpf_fill_alu_imm_regs(self, BPF_MOD, F_SIGNED);
 }
=20
 /* ALU32 K registers */
 static int bpf_fill_alu32_mov_imm_regs(struct bpf_test *self)
 {
-	return __bpf_fill_alu_imm_regs(self, BPF_MOV, true);
+	return __bpf_fill_alu_imm_regs(self, BPF_MOV, F_ALU32);
 }
=20
 static int bpf_fill_alu32_and_imm_regs(struct bpf_test *self)
 {
-	return __bpf_fill_alu_imm_regs(self, BPF_AND, true);
+	return __bpf_fill_alu_imm_regs(self, BPF_AND, F_ALU32);
 }
=20
 static int bpf_fill_alu32_or_imm_regs(struct bpf_test *self)
 {
-	return __bpf_fill_alu_imm_regs(self, BPF_OR, true);
+	return __bpf_fill_alu_imm_regs(self, BPF_OR, F_ALU32);
 }
=20
 static int bpf_fill_alu32_xor_imm_regs(struct bpf_test *self)
 {
-	return __bpf_fill_alu_imm_regs(self, BPF_XOR, true);
+	return __bpf_fill_alu_imm_regs(self, BPF_XOR, F_ALU32);
 }
=20
 static int bpf_fill_alu32_lsh_imm_regs(struct bpf_test *self)
 {
-	return __bpf_fill_alu_imm_regs(self, BPF_LSH, true);
+	return __bpf_fill_alu_imm_regs(self, BPF_LSH, F_ALU32);
 }
=20
 static int bpf_fill_alu32_rsh_imm_regs(struct bpf_test *self)
 {
-	return __bpf_fill_alu_imm_regs(self, BPF_RSH, true);
+	return __bpf_fill_alu_imm_regs(self, BPF_RSH, F_ALU32);
 }
=20
 static int bpf_fill_alu32_arsh_imm_regs(struct bpf_test *self)
 {
-	return __bpf_fill_alu_imm_regs(self, BPF_ARSH, true);
+	return __bpf_fill_alu_imm_regs(self, BPF_ARSH, F_ALU32);
 }
=20
 static int bpf_fill_alu32_add_imm_regs(struct bpf_test *self)
 {
-	return __bpf_fill_alu_imm_regs(self, BPF_ADD, true);
+	return __bpf_fill_alu_imm_regs(self, BPF_ADD, F_ALU32);
 }
=20
 static int bpf_fill_alu32_sub_imm_regs(struct bpf_test *self)
 {
-	return __bpf_fill_alu_imm_regs(self, BPF_SUB, true);
+	return __bpf_fill_alu_imm_regs(self, BPF_SUB, F_ALU32);
 }
=20
 static int bpf_fill_alu32_mul_imm_regs(struct bpf_test *self)
 {
-	return __bpf_fill_alu_imm_regs(self, BPF_MUL, true);
+	return __bpf_fill_alu_imm_regs(self, BPF_MUL, F_ALU32);
 }
=20
 static int bpf_fill_alu32_div_imm_regs(struct bpf_test *self)
 {
-	return __bpf_fill_alu_imm_regs(self, BPF_DIV, true);
+	return __bpf_fill_alu_imm_regs(self, BPF_DIV, F_ALU32);
 }
=20
 static int bpf_fill_alu32_mod_imm_regs(struct bpf_test *self)
 {
-	return __bpf_fill_alu_imm_regs(self, BPF_MOD, true);
+	return __bpf_fill_alu_imm_regs(self, BPF_MOD, F_ALU32);
+}
+
+/* Signed ALU32 K registers */
+static int bpf_fill_alu32_sdiv_imm_regs(struct bpf_test *self)
+{
+	return __bpf_fill_alu_imm_regs(self, BPF_DIV, F_ALU32 | F_SIGNED);
+}
+
+static int bpf_fill_alu32_smod_imm_regs(struct bpf_test *self)
+{
+	return __bpf_fill_alu_imm_regs(self, BPF_MOD, F_ALU32 | F_SIGNED);
 }
=20
 /*
@@ -1442,8 +1540,8 @@ static int __bpf_fill_alu_reg_pairs(struct bpf_test=
 *self, u8 op, bool alu32)
 	if (op =3D=3D BPF_LSH || op =3D=3D BPF_RSH || op =3D=3D BPF_ARSH)
 		src &=3D 31;
=20
-	__bpf_alu_result(&res, dst, src, op);
-	__bpf_alu_result(&same, src, src, op);
+	__bpf_alu_result(&res, dst, src, op, false);
+	__bpf_alu_result(&same, src, src, op, false);
=20
 	if (alu32) {
 		res =3D (u32)res;
@@ -1626,7 +1724,7 @@ static int __bpf_emit_atomic64(struct bpf_test *sel=
f, void *arg,
 		res =3D src;
 		break;
 	default:
-		__bpf_alu_result(&res, dst, src, BPF_OP(op));
+		__bpf_alu_result(&res, dst, src, BPF_OP(op), false);
 	}
=20
 	keep =3D 0x0123456789abcdefULL;
@@ -1673,7 +1771,7 @@ static int __bpf_emit_atomic32(struct bpf_test *sel=
f, void *arg,
 		res =3D src;
 		break;
 	default:
-		__bpf_alu_result(&res, (u32)dst, (u32)src, BPF_OP(op));
+		__bpf_alu_result(&res, (u32)dst, (u32)src, BPF_OP(op), false);
 	}
=20
 	keep =3D 0x0123456789abcdefULL;
@@ -1939,7 +2037,7 @@ static int __bpf_fill_atomic_reg_pairs(struct bpf_t=
est *self, u8 width, u8 op)
 		res =3D mem;
 		break;
 	default:
-		__bpf_alu_result(&res, mem, upd, BPF_OP(op));
+		__bpf_alu_result(&res, mem, upd, BPF_OP(op), false);
 	}
=20
 	/* Test all operand registers */
@@ -12354,6 +12452,22 @@ static struct bpf_test tests[] =3D {
 		{ { 0, 1 } },
 		.fill_helper =3D bpf_fill_alu64_mod_imm_regs,
 	},
+	{
+		"ALU64_SDIV_K: registers",
+		{ },
+		INTERNAL,
+		{ },
+		{ { 0, 1 } },
+		.fill_helper =3D bpf_fill_alu64_sdiv_imm_regs,
+	},
+	{
+		"ALU64_SMOD_K: registers",
+		{ },
+		INTERNAL,
+		{ },
+		{ { 0, 1 } },
+		.fill_helper =3D bpf_fill_alu64_smod_imm_regs,
+	},
 	/* ALU32 K registers */
 	{
 		"ALU32_MOV_K: registers",
@@ -12451,6 +12565,22 @@ static struct bpf_test tests[] =3D {
 		{ { 0, 1 } },
 		.fill_helper =3D bpf_fill_alu32_mod_imm_regs,
 	},
+	{
+		"ALU32_SDIV_K: registers",
+		{ },
+		INTERNAL,
+		{ },
+		{ { 0, 1 } },
+		.fill_helper =3D bpf_fill_alu32_sdiv_imm_regs,
+	},
+	{
+		"ALU32_SMOD_K: registers",
+		{ },
+		INTERNAL,
+		{ },
+		{ { 0, 1 } },
+		.fill_helper =3D bpf_fill_alu32_smod_imm_regs,
+	},
 	/* ALU64 X register combinations */
 	{
 		"ALU64_MOV_X: register combinations",
@@ -12881,6 +13011,24 @@ static struct bpf_test tests[] =3D {
 		.fill_helper =3D bpf_fill_alu64_mod_imm,
 		.nr_testruns =3D NR_PATTERN_RUNS,
 	},
+	{
+		"ALU64_SDIV_K: all immediate value magnitudes",
+		{ },
+		INTERNAL | FLAG_NO_DATA,
+		{ },
+		{ { 0, 1 } },
+		.fill_helper =3D bpf_fill_alu64_sdiv_imm,
+		.nr_testruns =3D NR_PATTERN_RUNS,
+	},
+	{
+		"ALU64_SMOD_K: all immediate value magnitudes",
+		{ },
+		INTERNAL | FLAG_NO_DATA,
+		{ },
+		{ { 0, 1 } },
+		.fill_helper =3D bpf_fill_alu64_smod_imm,
+		.nr_testruns =3D NR_PATTERN_RUNS,
+	},
 	/* ALU32 immediate magnitudes */
 	{
 		"ALU32_MOV_K: all immediate value magnitudes",
@@ -12963,6 +13111,24 @@ static struct bpf_test tests[] =3D {
 		.fill_helper =3D bpf_fill_alu32_mod_imm,
 		.nr_testruns =3D NR_PATTERN_RUNS,
 	},
+	{
+		"ALU32_SDIV_K: all immediate value magnitudes",
+		{ },
+		INTERNAL | FLAG_NO_DATA,
+		{ },
+		{ { 0, 1 } },
+		.fill_helper =3D bpf_fill_alu32_sdiv_imm,
+		.nr_testruns =3D NR_PATTERN_RUNS,
+	},
+	{
+		"ALU32_SMOD_K: all immediate value magnitudes",
+		{ },
+		INTERNAL | FLAG_NO_DATA,
+		{ },
+		{ { 0, 1 } },
+		.fill_helper =3D bpf_fill_alu32_smod_imm,
+		.nr_testruns =3D NR_PATTERN_RUNS,
+	},
 	/* ALU64 register magnitudes */
 	{
 		"ALU64_MOV_X: all register value magnitudes",
--=20
2.52.0

