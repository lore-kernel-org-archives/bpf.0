Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 077DF322A00
	for <bpf@vger.kernel.org>; Thu, 26 Mar 2026 20:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774558281; cv=none; b=a4TRTCw0Ep9sigXSE1oolBKG6JdZvkZkeExu/uaI1C/+cInKm0eGcTMaSm+hoYeS2Q4a9BRXsy5TcJE44Y7zraUv1waTePvgn2KCpvtC+BgUBCGw6Pha7cNOxdmHOkLUGzGpW925E1UjqTkHBovO4E1qhOFyYfYTZpgo9FAeqvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774558281; c=relaxed/simple;
	bh=h/VIrK4OF7tVCpek10YVY1lae4Vk+1iLnlWATTheGMw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=oBrSPJ2kh1YCotE2xfhpPU0v+qMKua87o5Q3K1WgSx+VQx7QXcKGtzt7uK0FHZzIJWv1Qz33Z1Q9ky9pz6Vd/hy2AVRWk3t0LlSXyozTM45YlNYWRggwbcRmBQGquhan8RwuZMZpSLLWXxpIYGBFgYyrzWhQ48Fq6RzViTv+ca4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=fb.com header.i=@fb.com header.b=r1ctWX9C; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fb.com header.i=@fb.com header.b="r1ctWX9C"
Received: from pps.filterd (m0528005.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62QHIbO13002322
	for <bpf@vger.kernel.org>; Thu, 26 Mar 2026 13:51:18 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=s2048-2025-q2; bh=eFo2shl6n8Y5yS/fAx
	/u0CewT0DCzpO0QMYYlVVs5Io=; b=r1ctWX9CUHztLqlW864XBjtEpvr+uFwfIF
	FPmQrw5KY16V51CuQ/+Xd0NbdCHk2GAkaavVwO1zEky5M8oACGm7HhVRU/4znggd
	E99MU1ojKiIyNw1YTkEMLg54Y8s2kZO8mbH1CkwyyJ9rI7fZALV7yrE0FFcdzGpS
	j4yXVcLeUBJ28j222AxmkvNHbYAXmJEOJEq+gmWK4VCOTTyFYNVIeEBEr0aQqsgX
	XzCQgtiIqOHwfjvSUzqz6x2XvLyB1oJNGkQNsGq5D6LGm8LT+xZozuMU6PVwSS9t
	eya+hO6UbZs/lP1YEWhVn7yqc9SXBOZEjDNonStWLMTCJ+21uwmg==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4d4w3aa03v-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Thu, 26 Mar 2026 13:51:17 -0700 (PDT)
Received: from twshared107802.16.frc2.facebook.com (2620:10d:c0a8:1b::30) by
 mail.thefacebook.com (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.35; Thu, 26 Mar 2026 20:51:16 +0000
Received: by devvm14451.vll0.facebook.com (Postfix, from userid 187975)
	id 71C73551C66D6; Thu, 26 Mar 2026 13:51:03 -0700 (PDT)
From: Jie Meng <jmeng@fb.com>
To: <bpf@vger.kernel.org>, <ast@kernel.org>, <andrii@kernel.org>,
        <daniel@iogearbox.net>
CC: Jie Meng <jmeng@fb.com>
Subject: [PATCH bpf-next] bpf/tests: Exhaustive test coverage for signed division and modulo
Date: Thu, 26 Mar 2026 13:50:50 -0700
Message-ID: <20260326205050.2826760-1-jmeng@fb.com>
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
X-Authority-Analysis: v=2.4 cv=a449NESF c=1 sm=1 tr=0 ts=69c59c45 cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=jCddH8ec0KUNCymVuxII:22 a=FOH2dFAWAAAA:8 a=0iyn1J9l7PR8C6wG42QA:9
X-Proofpoint-ORIG-GUID: io-ayptheLlsOTvJg25YN_ql-JARip2q
X-Proofpoint-GUID: io-ayptheLlsOTvJg25YN_ql-JARip2q
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI2MDE1MCBTYWx0ZWRfXyGc8VyXnFNZO
 S26p1mzhT1l6QQ3hCgQrtFoA7J3KE+JQ8MEPKgwZQyMlOSf7JsZn1fH4F9vfp/hgqE9cnPrW4+H
 tXR7Xyrn7+inf2CKAEbLgnslLGmfPRzFQibdFCYHrEoArumXLYRkMfm2logkT4Dptnfwfx0EUL3
 DweaDSRqDF7y93cHTlDG3ZiVLc7DS8GkqSFd55HttGC12VnYLHcWDJb76cnh616XzOMaR/ivucW
 3NC2hMFfnrb6hn/Dw1DkKlAWnvcSFLg/EycNGfSrh44TKpc7wlp73S2NkTXzOF5PkFuTaQkho4t
 tKaeUio5dvo3NwbM6yFbnJrdBNwBi6TzwYmVgjC2dX/jACkllOAGk3h+3exFq4EbwaDDwCXp8lp
 p4s9WBdm6xe3INvDjKTyO7hHbfca2tRqcQIWUjMZjL2f6/K0A3zzC1i6WE+JPE/jbgB/B3xMRoL
 36qAg9QvTwLPUk+0r1Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-26_03,2026-03-26_01,2025-10-01_01

Extend lib/test_bpf.c to provide comprehensive test coverage for BPF
signed division (SDIV) and signed modulo (SMOD) instructions, both
32-bit and 64-bit variants with immediate operands.

Changes:
- __bpf_alu_result(): add off parameter to select signed vs unsigned
  div/mod semantics. When off !=3D 0, uses div64_s64() / s64 modulo with
  truncation toward zero, matching BPF signed division spec. Skips
  divisor =3D=3D -1 cases (handled by verifier).
- __bpf_emit_alu64_imm(), __bpf_emit_alu32_imm(): propagate off to
  use BPF_ALU{32,64}_IMM_OFF() instruction encoding and signed result
  computation. For ALU32 signed, cast operands to s32 before computing
  reference results.
- __bpf_fill_alu_imm_regs(): add off parameter, use negative test
  values for signed cases (-76543210 / -7654321076543210LL) to exercise
  sign-related edge cases.
- New test fill functions: bpf_fill_alu{32,64}_{sdiv,smod}_imm() and
  bpf_fill_alu{32,64}_{sdiv,smod}_imm_regs(), each testing all
  immediate value magnitudes and all register pair combinations.
- All existing unsigned tests updated to pass off=3D0, preserving
  backward compatibility.

8 new test cases added:
  ALU64_SDIV_K, ALU64_SMOD_K (immediate magnitudes + register combos)
  ALU32_SDIV_K, ALU32_SMOD_K (immediate magnitudes + register combos)

Assisted-by: Claude:claude-opus-4-6
Signed-off-by: Jie Meng <jmeng@fb.com>
---
 lib/test_bpf.c | 299 +++++++++++++++++++++++++++++++++++++------------
 1 file changed, 226 insertions(+), 73 deletions(-)

diff --git a/lib/test_bpf.c b/lib/test_bpf.c
index 5892c0f17ddc..2f1b252f2a50 100644
--- a/lib/test_bpf.c
+++ b/lib/test_bpf.c
@@ -560,7 +560,7 @@ static int bpf_fill_max_jmp_never_taken(struct bpf_te=
st *self)
 }
=20
 /* ALU result computation used in tests */
-static bool __bpf_alu_result(u64 *res, u64 v1, u64 v2, u8 op)
+static bool __bpf_alu_result(u64 *res, u64 v1, u64 v2, u8 op, s16 off)
 {
 	*res =3D 0;
 	switch (op) {
@@ -599,12 +599,28 @@ static bool __bpf_alu_result(u64 *res, u64 v1, u64 =
v2, u8 op)
 	case BPF_DIV:
 		if (v2 =3D=3D 0)
 			return false;
-		*res =3D div64_u64(v1, v2);
+		if (off =3D=3D 0) {
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
+		if (off =3D=3D 0) {
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
@@ -653,14 +669,14 @@ static int __bpf_fill_alu_shift(struct bpf_test *se=
lf, u8 op,
 					reg =3D (s32)reg;
 				else
 					reg =3D (u32)reg;
-				__bpf_alu_result(&val, reg, imm, op);
+				__bpf_alu_result(&val, reg, imm, op, 0);
 				val =3D (u32)val;
 			} else {
 				if (mode =3D=3D BPF_K)
 					insn[i++] =3D BPF_ALU64_IMM(op, R1, imm);
 				else
 					insn[i++] =3D BPF_ALU64_REG(op, R1, R2);
-				__bpf_alu_result(&val, reg, imm, op);
+				__bpf_alu_result(&val, reg, imm, op, 0);
 			}
=20
 			/*
@@ -776,7 +792,7 @@ static int __bpf_fill_alu_shift_same_reg(struct bpf_t=
est *self, u8 op,
 			insn[i++] =3D BPF_ALU64_REG(op, R1, R1);
=20
 		/* Compute the reference result */
-		__bpf_alu_result(&res, val, val, op);
+		__bpf_alu_result(&res, val, val, op, 0);
 		if (alu32)
 			res =3D (u32)res;
 		i +=3D __bpf_ld_imm64(&insn[i], R2, res);
@@ -936,17 +952,19 @@ static int __bpf_fill_pattern(struct bpf_test *self=
, void *arg,
 static int __bpf_emit_alu64_imm(struct bpf_test *self, void *arg,
 				struct bpf_insn *insns, s64 dst, s64 imm)
 {
-	int op =3D *(int *)arg;
+	int *a =3D arg;
+	int op =3D a[0];
+	s16 off =3D a[1];
 	int i =3D 0;
 	u64 res;
=20
 	if (!insns)
 		return 7;
=20
-	if (__bpf_alu_result(&res, dst, (s32)imm, op)) {
+	if (__bpf_alu_result(&res, dst, (s32)imm, op, off)) {
 		i +=3D __bpf_ld_imm64(&insns[i], R1, dst);
 		i +=3D __bpf_ld_imm64(&insns[i], R3, res);
-		insns[i++] =3D BPF_ALU64_IMM(op, R1, imm);
+		insns[i++] =3D BPF_ALU64_IMM_OFF(op, R1, imm, off);
 		insns[i++] =3D BPF_JMP_REG(BPF_JEQ, R1, R3, 1);
 		insns[i++] =3D BPF_EXIT_INSN();
 	}
@@ -957,17 +975,28 @@ static int __bpf_emit_alu64_imm(struct bpf_test *se=
lf, void *arg,
 static int __bpf_emit_alu32_imm(struct bpf_test *self, void *arg,
 				struct bpf_insn *insns, s64 dst, s64 imm)
 {
-	int op =3D *(int *)arg;
+	int *a =3D arg;
+	int op =3D a[0];
+	s16 off =3D a[1];
 	int i =3D 0;
 	u64 res;
+	u64 v1, v2;
=20
 	if (!insns)
 		return 7;
=20
-	if (__bpf_alu_result(&res, (u32)dst, (u32)imm, op)) {
+	if (off) {
+		v1 =3D (s32)dst;
+		v2 =3D (s32)imm;
+	} else {
+		v1 =3D (u32)dst;
+		v2 =3D (u32)imm;
+	}
+
+	if (__bpf_alu_result(&res, v1, v2, op, off)) {
 		i +=3D __bpf_ld_imm64(&insns[i], R1, dst);
 		i +=3D __bpf_ld_imm64(&insns[i], R3, (u32)res);
-		insns[i++] =3D BPF_ALU32_IMM(op, R1, imm);
+		insns[i++] =3D BPF_ALU32_IMM_OFF(op, R1, imm, off);
 		insns[i++] =3D BPF_JMP_REG(BPF_JEQ, R1, R3, 1);
 		insns[i++] =3D BPF_EXIT_INSN();
 	}
@@ -985,7 +1014,7 @@ static int __bpf_emit_alu64_reg(struct bpf_test *sel=
f, void *arg,
 	if (!insns)
 		return 9;
=20
-	if (__bpf_alu_result(&res, dst, src, op)) {
+	if (__bpf_alu_result(&res, dst, src, op, 0)) {
 		i +=3D __bpf_ld_imm64(&insns[i], R1, dst);
 		i +=3D __bpf_ld_imm64(&insns[i], R2, src);
 		i +=3D __bpf_ld_imm64(&insns[i], R3, res);
@@ -1007,7 +1036,7 @@ static int __bpf_emit_alu32_reg(struct bpf_test *se=
lf, void *arg,
 	if (!insns)
 		return 9;
=20
-	if (__bpf_alu_result(&res, (u32)dst, (u32)src, op)) {
+	if (__bpf_alu_result(&res, (u32)dst, (u32)src, op, 0)) {
 		i +=3D __bpf_ld_imm64(&insns[i], R1, dst);
 		i +=3D __bpf_ld_imm64(&insns[i], R2, src);
 		i +=3D __bpf_ld_imm64(&insns[i], R3, (u32)res);
@@ -1019,16 +1048,20 @@ static int __bpf_emit_alu32_reg(struct bpf_test *=
self, void *arg,
 	return i;
 }
=20
-static int __bpf_fill_alu64_imm(struct bpf_test *self, int op)
+static int __bpf_fill_alu64_imm(struct bpf_test *self, int op, s16 off)
 {
-	return __bpf_fill_pattern(self, &op, 64, 32,
+	int arg[2] =3D {op, off};
+
+	return __bpf_fill_pattern(self, &arg, 64, 32,
 				  PATTERN_BLOCK1, PATTERN_BLOCK2,
 				  &__bpf_emit_alu64_imm);
 }
=20
-static int __bpf_fill_alu32_imm(struct bpf_test *self, int op)
+static int __bpf_fill_alu32_imm(struct bpf_test *self, int op, s16 off)
 {
-	return __bpf_fill_pattern(self, &op, 64, 32,
+	int arg[2] =3D {op, off};
+
+	return __bpf_fill_pattern(self, &arg, 64, 32,
 				  PATTERN_BLOCK1, PATTERN_BLOCK2,
 				  &__bpf_emit_alu32_imm);
 }
@@ -1050,93 +1083,115 @@ static int __bpf_fill_alu32_reg(struct bpf_test =
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
+	return __bpf_fill_alu64_imm(self, BPF_DIV, 1);
+}
+
+static int bpf_fill_alu64_smod_imm(struct bpf_test *self)
+{
+	return __bpf_fill_alu64_imm(self, BPF_MOD, 1);
+}
+
+/* Signed ALU32 immediate operations */
+static int bpf_fill_alu32_sdiv_imm(struct bpf_test *self)
+{
+	return __bpf_fill_alu32_imm(self, BPF_DIV, 1);
+}
+
+static int bpf_fill_alu32_smod_imm(struct bpf_test *self)
+{
+	return __bpf_fill_alu32_imm(self, BPF_MOD, 1);
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
@@ -1235,7 +1290,8 @@ static int bpf_fill_alu32_mod_reg(struct bpf_test *=
self)
  * Test JITs that implement complex ALU operations as function
  * calls, and must re-arrange operands for argument passing.
  */
-static int __bpf_fill_alu_imm_regs(struct bpf_test *self, u8 op, bool al=
u32)
+static int __bpf_fill_alu_imm_regs(struct bpf_test *self, u8 op,
+				    bool alu32, s16 off)
 {
 	int len =3D 2 + 10 * 10;
 	struct bpf_insn *insns;
@@ -1249,16 +1305,23 @@ static int __bpf_fill_alu_imm_regs(struct bpf_tes=
t *self, u8 op, bool alu32)
 		return -ENOMEM;
=20
 	/* Operand and result values according to operation */
-	if (alu32)
-		dst =3D 0x76543210U;
-	else
-		dst =3D 0x7edcba9876543210ULL;
+	if (off) {
+		if (alu32)
+			dst =3D -76543210;
+		else
+			dst =3D -7654321076543210LL;
+	} else {
+		if (alu32)
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
+	__bpf_alu_result(&res, dst, imm, op, off);
=20
 	if (alu32)
 		res =3D (u32)res;
@@ -1268,9 +1331,9 @@ static int __bpf_fill_alu_imm_regs(struct bpf_test =
*self, u8 op, bool alu32)
 		i +=3D __bpf_ld_imm64(&insns[i], rd, dst);
=20
 		if (alu32)
-			insns[i++] =3D BPF_ALU32_IMM(op, rd, imm);
+			insns[i++] =3D BPF_ALU32_IMM_OFF(op, rd, imm, off);
 		else
-			insns[i++] =3D BPF_ALU64_IMM(op, rd, imm);
+			insns[i++] =3D BPF_ALU64_IMM_OFF(op, rd, imm, off);
=20
 		insns[i++] =3D BPF_JMP32_IMM(BPF_JEQ, rd, res, 2);
 		insns[i++] =3D BPF_MOV64_IMM(R0, __LINE__);
@@ -1295,123 +1358,145 @@ static int __bpf_fill_alu_imm_regs(struct bpf_t=
est *self, u8 op, bool alu32)
 /* ALU64 K registers */
 static int bpf_fill_alu64_mov_imm_regs(struct bpf_test *self)
 {
-	return __bpf_fill_alu_imm_regs(self, BPF_MOV, false);
+	return __bpf_fill_alu_imm_regs(self, BPF_MOV, false, 0);
 }
=20
 static int bpf_fill_alu64_and_imm_regs(struct bpf_test *self)
 {
-	return __bpf_fill_alu_imm_regs(self, BPF_AND, false);
+	return __bpf_fill_alu_imm_regs(self, BPF_AND, false, 0);
 }
=20
 static int bpf_fill_alu64_or_imm_regs(struct bpf_test *self)
 {
-	return __bpf_fill_alu_imm_regs(self, BPF_OR, false);
+	return __bpf_fill_alu_imm_regs(self, BPF_OR, false, 0);
 }
=20
 static int bpf_fill_alu64_xor_imm_regs(struct bpf_test *self)
 {
-	return __bpf_fill_alu_imm_regs(self, BPF_XOR, false);
+	return __bpf_fill_alu_imm_regs(self, BPF_XOR, false, 0);
 }
=20
 static int bpf_fill_alu64_lsh_imm_regs(struct bpf_test *self)
 {
-	return __bpf_fill_alu_imm_regs(self, BPF_LSH, false);
+	return __bpf_fill_alu_imm_regs(self, BPF_LSH, false, 0);
 }
=20
 static int bpf_fill_alu64_rsh_imm_regs(struct bpf_test *self)
 {
-	return __bpf_fill_alu_imm_regs(self, BPF_RSH, false);
+	return __bpf_fill_alu_imm_regs(self, BPF_RSH, false, 0);
 }
=20
 static int bpf_fill_alu64_arsh_imm_regs(struct bpf_test *self)
 {
-	return __bpf_fill_alu_imm_regs(self, BPF_ARSH, false);
+	return __bpf_fill_alu_imm_regs(self, BPF_ARSH, false, 0);
 }
=20
 static int bpf_fill_alu64_add_imm_regs(struct bpf_test *self)
 {
-	return __bpf_fill_alu_imm_regs(self, BPF_ADD, false);
+	return __bpf_fill_alu_imm_regs(self, BPF_ADD, false, 0);
 }
=20
 static int bpf_fill_alu64_sub_imm_regs(struct bpf_test *self)
 {
-	return __bpf_fill_alu_imm_regs(self, BPF_SUB, false);
+	return __bpf_fill_alu_imm_regs(self, BPF_SUB, false, 0);
 }
=20
 static int bpf_fill_alu64_mul_imm_regs(struct bpf_test *self)
 {
-	return __bpf_fill_alu_imm_regs(self, BPF_MUL, false);
+	return __bpf_fill_alu_imm_regs(self, BPF_MUL, false, 0);
 }
=20
 static int bpf_fill_alu64_div_imm_regs(struct bpf_test *self)
 {
-	return __bpf_fill_alu_imm_regs(self, BPF_DIV, false);
+	return __bpf_fill_alu_imm_regs(self, BPF_DIV, false, 0);
 }
=20
 static int bpf_fill_alu64_mod_imm_regs(struct bpf_test *self)
 {
-	return __bpf_fill_alu_imm_regs(self, BPF_MOD, false);
+	return __bpf_fill_alu_imm_regs(self, BPF_MOD, false, 0);
+}
+
+/* Signed ALU64 K registers */
+static int bpf_fill_alu64_sdiv_imm_regs(struct bpf_test *self)
+{
+	return __bpf_fill_alu_imm_regs(self, BPF_DIV, false, 1);
+}
+
+static int bpf_fill_alu64_smod_imm_regs(struct bpf_test *self)
+{
+	return __bpf_fill_alu_imm_regs(self, BPF_MOD, false, 1);
 }
=20
 /* ALU32 K registers */
 static int bpf_fill_alu32_mov_imm_regs(struct bpf_test *self)
 {
-	return __bpf_fill_alu_imm_regs(self, BPF_MOV, true);
+	return __bpf_fill_alu_imm_regs(self, BPF_MOV, true, 0);
 }
=20
 static int bpf_fill_alu32_and_imm_regs(struct bpf_test *self)
 {
-	return __bpf_fill_alu_imm_regs(self, BPF_AND, true);
+	return __bpf_fill_alu_imm_regs(self, BPF_AND, true, 0);
 }
=20
 static int bpf_fill_alu32_or_imm_regs(struct bpf_test *self)
 {
-	return __bpf_fill_alu_imm_regs(self, BPF_OR, true);
+	return __bpf_fill_alu_imm_regs(self, BPF_OR, true, 0);
 }
=20
 static int bpf_fill_alu32_xor_imm_regs(struct bpf_test *self)
 {
-	return __bpf_fill_alu_imm_regs(self, BPF_XOR, true);
+	return __bpf_fill_alu_imm_regs(self, BPF_XOR, true, 0);
 }
=20
 static int bpf_fill_alu32_lsh_imm_regs(struct bpf_test *self)
 {
-	return __bpf_fill_alu_imm_regs(self, BPF_LSH, true);
+	return __bpf_fill_alu_imm_regs(self, BPF_LSH, true, 0);
 }
=20
 static int bpf_fill_alu32_rsh_imm_regs(struct bpf_test *self)
 {
-	return __bpf_fill_alu_imm_regs(self, BPF_RSH, true);
+	return __bpf_fill_alu_imm_regs(self, BPF_RSH, true, 0);
 }
=20
 static int bpf_fill_alu32_arsh_imm_regs(struct bpf_test *self)
 {
-	return __bpf_fill_alu_imm_regs(self, BPF_ARSH, true);
+	return __bpf_fill_alu_imm_regs(self, BPF_ARSH, true, 0);
 }
=20
 static int bpf_fill_alu32_add_imm_regs(struct bpf_test *self)
 {
-	return __bpf_fill_alu_imm_regs(self, BPF_ADD, true);
+	return __bpf_fill_alu_imm_regs(self, BPF_ADD, true, 0);
 }
=20
 static int bpf_fill_alu32_sub_imm_regs(struct bpf_test *self)
 {
-	return __bpf_fill_alu_imm_regs(self, BPF_SUB, true);
+	return __bpf_fill_alu_imm_regs(self, BPF_SUB, true, 0);
 }
=20
 static int bpf_fill_alu32_mul_imm_regs(struct bpf_test *self)
 {
-	return __bpf_fill_alu_imm_regs(self, BPF_MUL, true);
+	return __bpf_fill_alu_imm_regs(self, BPF_MUL, true, 0);
 }
=20
 static int bpf_fill_alu32_div_imm_regs(struct bpf_test *self)
 {
-	return __bpf_fill_alu_imm_regs(self, BPF_DIV, true);
+	return __bpf_fill_alu_imm_regs(self, BPF_DIV, true, 0);
 }
=20
 static int bpf_fill_alu32_mod_imm_regs(struct bpf_test *self)
 {
-	return __bpf_fill_alu_imm_regs(self, BPF_MOD, true);
+	return __bpf_fill_alu_imm_regs(self, BPF_MOD, true, 0);
+}
+
+/* Signed ALU32 K registers */
+static int bpf_fill_alu32_sdiv_imm_regs(struct bpf_test *self)
+{
+	return __bpf_fill_alu_imm_regs(self, BPF_DIV, true, 1);
+}
+
+static int bpf_fill_alu32_smod_imm_regs(struct bpf_test *self)
+{
+	return __bpf_fill_alu_imm_regs(self, BPF_MOD, true, 1);
 }
=20
 /*
@@ -1442,8 +1527,8 @@ static int __bpf_fill_alu_reg_pairs(struct bpf_test=
 *self, u8 op, bool alu32)
 	if (op =3D=3D BPF_LSH || op =3D=3D BPF_RSH || op =3D=3D BPF_ARSH)
 		src &=3D 31;
=20
-	__bpf_alu_result(&res, dst, src, op);
-	__bpf_alu_result(&same, src, src, op);
+	__bpf_alu_result(&res, dst, src, op, 0);
+	__bpf_alu_result(&same, src, src, op, 0);
=20
 	if (alu32) {
 		res =3D (u32)res;
@@ -1626,7 +1711,7 @@ static int __bpf_emit_atomic64(struct bpf_test *sel=
f, void *arg,
 		res =3D src;
 		break;
 	default:
-		__bpf_alu_result(&res, dst, src, BPF_OP(op));
+		__bpf_alu_result(&res, dst, src, BPF_OP(op), 0);
 	}
=20
 	keep =3D 0x0123456789abcdefULL;
@@ -1673,7 +1758,7 @@ static int __bpf_emit_atomic32(struct bpf_test *sel=
f, void *arg,
 		res =3D src;
 		break;
 	default:
-		__bpf_alu_result(&res, (u32)dst, (u32)src, BPF_OP(op));
+		__bpf_alu_result(&res, (u32)dst, (u32)src, BPF_OP(op), 0);
 	}
=20
 	keep =3D 0x0123456789abcdefULL;
@@ -1939,7 +2024,7 @@ static int __bpf_fill_atomic_reg_pairs(struct bpf_t=
est *self, u8 width, u8 op)
 		res =3D mem;
 		break;
 	default:
-		__bpf_alu_result(&res, mem, upd, BPF_OP(op));
+		__bpf_alu_result(&res, mem, upd, BPF_OP(op), 0);
 	}
=20
 	/* Test all operand registers */
@@ -12354,6 +12439,22 @@ static struct bpf_test tests[] =3D {
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
@@ -12451,6 +12552,22 @@ static struct bpf_test tests[] =3D {
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
@@ -12881,6 +12998,24 @@ static struct bpf_test tests[] =3D {
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
@@ -12963,6 +13098,24 @@ static struct bpf_test tests[] =3D {
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

