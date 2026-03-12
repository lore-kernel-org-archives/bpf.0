Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 681B827470;
	Thu, 12 Mar 2026 08:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773302501; cv=none; b=RFyKtD75BPrBy7TCoaFdMAeN+bGPPf8lFN785PijLjvjxpb2InZYYTe6KFDPjnWjz+9uWhQspnKS9lAInByP+JZMecTRIhftH8GLaAf6JCBKLAGyGzijoSW9kj38j6AKYJTmi4BIAYlfq/vQFAvc6BybOBeHPeyJbAka7CnQKZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773302501; c=relaxed/simple;
	bh=D9e4uZc05nCroTsBT+LiGGlTaE4vR3PpTwKKvXrW/vg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MmLWHRmi8Vb8pitc0B7jUlKxBcF/oiZTjnwG1x0c8FsooqU/7RiXZ+iw4KVDzokBr7AdBYQ99Wq6HpFnEh0ciH+rsTamOjQmCp6mYMeLlj2f7yqc0daTqFxxie52Px+Dfd+bhHJe6mtlJpaI5pc4aMYT1rBgTC4nFLQ1757CDyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=QwyryCi2; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="QwyryCi2"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62BMVvC52580826;
	Thu, 12 Mar 2026 08:01:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=nIFw0gTDP0L25W2iw7lUukmzLy4KEAgrf/+pXe8d/
	sQ=; b=QwyryCi2qvdbYkVe6TdsXItITPyHBh/SnXETMe/TaaTg9elYvS92nR8MO
	43yOUI235sEQ/kfBVdcl9Jk+lmfLhnxC2SLsIqyQoN/ufA24xkZ9wT0ZzXGulbw3
	ghEcTMeMrFlUMSwOyuFil6Ib7Emw2kUz+qrBfgQ2nnfmpGn33D2OpZ8M9G3hK9Sr
	YTOpkaliXyYVC6JVexeVjhsRXexnBXqHVYNcRJbM24JqRgjMM0jlnX8ods341AYC
	DJlgFXcQzdk7G77oJGoN+9NmQfunNECdqO5R4gZWK8Qyoa6OdzbDGsc5nANjJkCS
	HIjKjgB4P5x3jH6QTEHY0KqOjjQFQ==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cuh94smeg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Mar 2026 08:01:18 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62C4HPV6006048;
	Thu, 12 Mar 2026 08:01:18 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cuha9hfve-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Mar 2026 08:01:18 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62C81Ga723724410
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 12 Mar 2026 08:01:16 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4B1722004E;
	Thu, 12 Mar 2026 08:01:16 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A5EA82004B;
	Thu, 12 Mar 2026 08:01:14 +0000 (GMT)
Received: from li-bd3f974c-2712-11b2-a85c-df1cec4d728e.in.ibm.com (unknown [9.78.106.17])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 12 Mar 2026 08:01:14 +0000 (GMT)
From: Hari Bathini <hbathini@linux.ibm.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, Shuah Khan <shuah@kernel.org>,
        linux-kselftest@vger.kernel.org
Subject: [PATCH bpf-next v2] selftests/bpf: improve test coverage for kfunc call
Date: Thu, 12 Mar 2026 13:31:13 +0530
Message-ID: <20260312080113.843408-1-hbathini@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=QKtlhwLL c=1 sm=1 tr=0 ts=69b272cf cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=expF912i6usqNW0XGO0A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEyMDA2MyBTYWx0ZWRfX30qW9Ob9sqdE
 9iujRIa5lo/pMUlGfBukZofonwXf6va6JbEZger2/VbHU9CYDe18Tx53Okq4RHCrsQUhKhKmL/l
 t2bvzL58f3bMQ58FAr5BiOc9NxoR0uB9K118ZTasgS3wslNNC/eu3VNpGpk1nkE+eiblNV9r0DR
 uj64HLuzWTkNBmguJbz+iLgOPhMz7NNj75tBu9zoQbVVYe6UqXpjOms360t2CJS5LPLaAZN+6Nn
 KRXJP/3/LunnxWuL3F7qwQUIItxumRyxQA72QQNnDeiPGPekdFE6PTZBppjliSWNRmq4P9A1hjK
 Y0NSKeyNzxRNY7jF+IdqshmUVWTuYtB9WsleX8dDrTkkX1go6qADs087y3m1P1woo0mF4L7a/Pl
 J6cRVgvnJBCWerAeNKy3Xa0tYJLMksv0ZSR1RXXRJqpfSRJz28vjdZsFPwQsqkdWcCKQGf6hLve
 yFF06vxotw5VYZiGKSg==
X-Proofpoint-ORIG-GUID: HKJI84ZfLTXo-wmnhycRuFMqCK3Iea2S
X-Proofpoint-GUID: HKJI84ZfLTXo-wmnhycRuFMqCK3Iea2S
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-11_02,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 impostorscore=0 clxscore=1015
 priorityscore=1501 bulkscore=0 adultscore=0 phishscore=0 spamscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603120063

On powerpc, immediate load instructions are sign extended. In case
of unsigned types, arguments should be explicitly zero-extended by
the caller. For kfunc call, this needs to be handled in the JIT code.
In bpf_kfunc_call_test4(), that tests for sign-extension of signed
argument types in kfunc calls, add some additional failure checks.
And add bpf_kfunc_call_test5() to test zero-extension of unsigned
argument types in kfunc calls.

Signed-off-by: Hari Bathini <hbathini@linux.ibm.com>
---

Changes in v2:
- Added asm version of the selftest for consistent testing across
  different BPF ISA versions.
- Added comments clearly stating the intent of the test cases.
- Updated sign-extension selftest to have additional failure checks.


 .../selftests/bpf/prog_tests/kfunc_call.c     |  2 +
 .../selftests/bpf/progs/kfunc_call_test.c     | 98 +++++++++++++++++++
 .../selftests/bpf/test_kmods/bpf_testmod.c    | 54 +++++++++-
 .../bpf/test_kmods/bpf_testmod_kfunc.h        |  1 +
 4 files changed, 154 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/kfunc_call.c b/tools/testing/selftests/bpf/prog_tests/kfunc_call.c
index f79c8e53cb3e..62f3fb79f5d1 100644
--- a/tools/testing/selftests/bpf/prog_tests/kfunc_call.c
+++ b/tools/testing/selftests/bpf/prog_tests/kfunc_call.c
@@ -74,6 +74,8 @@ static struct kfunc_test_params kfunc_tests[] = {
 	TC_TEST(kfunc_call_test1, 12),
 	TC_TEST(kfunc_call_test2, 3),
 	TC_TEST(kfunc_call_test4, -1234),
+	TC_TEST(kfunc_call_test5, 0),
+	TC_TEST(kfunc_call_test5_asm, 0),
 	TC_TEST(kfunc_call_test_ref_btf_id, 0),
 	TC_TEST(kfunc_call_test_get_mem, 42),
 	SYSCALL_TEST(kfunc_syscall_test, 0),
diff --git a/tools/testing/selftests/bpf/progs/kfunc_call_test.c b/tools/testing/selftests/bpf/progs/kfunc_call_test.c
index 8b86113a0126..5edc51564f71 100644
--- a/tools/testing/selftests/bpf/progs/kfunc_call_test.c
+++ b/tools/testing/selftests/bpf/progs/kfunc_call_test.c
@@ -2,8 +2,106 @@
 /* Copyright (c) 2021 Facebook */
 #include <vmlinux.h>
 #include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
 #include "../test_kmods/bpf_testmod_kfunc.h"
 
+SEC("tc")
+int kfunc_call_test5(struct __sk_buff *skb)
+{
+	struct bpf_sock *sk = skb->sk;
+	int ret;
+	u32 val32;
+	u16 val16;
+	u8 val8;
+
+	if (!sk)
+		return -1;
+
+	sk = bpf_sk_fullsock(sk);
+	if (!sk)
+		return -1;
+
+	/*
+	 * Test with constant values to verify zero-extension.
+	 * ISA-dependent BPF asm:
+	 *   With ALU32:    w1 = 0xFF; w2 = 0xFFFF; w3 = 0xFFFFffff
+	 *   Without ALU32: r1 = 0xFF; r2 = 0xFFFF; r3 = 0xFFFFffff
+	 * Both zero-extend to 64-bit before the kfunc call.
+	 */
+	ret = bpf_kfunc_call_test5(0xFF, 0xFFFF, 0xFFFFffffULL);
+	if (ret)
+		return ret;
+
+	val32 = bpf_get_prandom_u32();
+	val16 = val32 & 0xFFFF;
+	val8 = val32 & 0xFF;
+	ret = bpf_kfunc_call_test5(val8, val16, val32);
+	if (ret)
+		return ret;
+
+	/*
+	 * Test multiplication with different operand sizes:
+	 *
+	 * val8 * 0xFF:
+	 *   - Both operands promote to int (32-bit signed)
+	 *   - Result: 32-bit multiplication, truncated to u8, then zero-extended
+	 *
+	 * val16 * 0xFFFF:
+	 *   - Both operands promote to int (32-bit signed)
+	 *   - Result: 32-bit multiplication, truncated to u16, then zero-extended
+	 *
+	 * val32 * 0xFFFFffffULL:
+	 *   - val32 (u32) promotes to unsigned long long (due to ULL suffix)
+	 *   - Result: 64-bit unsigned multiplication, truncated to u32, then zero-extended
+	 */
+	ret = bpf_kfunc_call_test5(val8 * 0xFF, val16 * 0xFFFF, val32 * 0xFFFFffffULL);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+/*
+ * Assembly version testing the multiplication edge case explicitly.
+ * This ensures consistent testing across different ISA versions.
+ */
+SEC("tc")
+__naked int kfunc_call_test5_asm(void)
+{
+	asm volatile (
+		/* Get a random u32 value */
+		"call %[bpf_get_prandom_u32];"
+		"r6 = r0;"              /* Save val32 in r6 */
+
+		/* Prepare first argument: val8 * 0xFF */
+		"r1 = r6;"
+		"r1 &= 0xFF;"           /* val8 = val32 & 0xFF */
+		"r7 = 0xFF;"
+		"r1 *= r7;"             /* 64-bit mult: r1 = r1 * r7 */
+
+		/* Prepare second argument: val16 * 0xFFFF */
+		"r2 = r6;"
+		"r2 &= 0xFFFF;"         /* val16 = val32 & 0xFFFF */
+		"r7 = 0xFFFF;"
+		"r2 *= r7;"             /* 64-bit mult: r2 = r2 * r7 */
+
+		/* Prepare third argument: val32 * 0xFFFFffff */
+		"r3 = r6;"              /* val32 */
+		"r7 = 0xFFFFffff;"
+		"r3 *= r7;"             /* 64-bit mult: r3 = r3 * r7 */
+
+		/* Call kfunc with multiplication results */
+		"call bpf_kfunc_call_test5;"
+
+		/* Check return value */
+		"if r0 != 0 goto exit_%=;"
+		"r0 = 0;"
+		"exit_%=: exit;"
+		:
+		: __imm(bpf_get_prandom_u32)
+		: __clobber_all);
+}
+
 SEC("tc")
 int kfunc_call_test4(struct __sk_buff *skb)
 {
diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
index e62c6b78657f..94edbd2afa67 100644
--- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
+++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
@@ -760,12 +760,63 @@ __bpf_kfunc struct sock *bpf_kfunc_call_test3(struct sock *sk)
 
 __bpf_kfunc long noinline bpf_kfunc_call_test4(signed char a, short b, int c, long d)
 {
-	/* Provoke the compiler to assume that the caller has sign-extended a,
+	/*
+	 * Make val as volatile to avoid compiler optimizations.
+	 * Verify that negative signed values remain negative after
+	 * sign-extension (JIT must sign-extend, not zero-extend).
+	 */
+	volatile long val;
+
+	/* val will be positive, if JIT does zero-extension instead of sign-extension */
+	val = a;
+	if (val >= 0)
+		return 1;
+
+	val = b;
+	if (val >= 0)
+		return 2;
+
+	val = c;
+	if (val >= 0)
+		return 3;
+
+	/*
+	 * Provoke the compiler to assume that the caller has sign-extended a,
 	 * b and c on platforms where this is required (e.g. s390x).
 	 */
 	return (long)a + (long)b + (long)c + d;
 }
 
+__bpf_kfunc int bpf_kfunc_call_test5(u8 a, u16 b, u32 c)
+{
+	/*
+	 * Make val as volatile to avoid compiler optimizations on the below checks
+	 * In C, assigning u8/u16/u32 to long performs zero-extension.
+	 */
+	volatile long val = a;
+
+	/* Check zero-extension */
+	if (val != (unsigned long)a)
+		return 1;
+	/* Check no sign-extension */
+	if (val < 0)
+		return 2;
+
+	val = b;
+	if (val != (unsigned long)b)
+		return 3;
+	if (val < 0)
+		return 4;
+
+	val = c;
+	if (val != (unsigned long)c)
+		return 5;
+	if (val < 0)
+		return 6;
+
+	return 0;
+}
+
 static struct prog_test_ref_kfunc prog_test_struct = {
 	.a = 42,
 	.b = 108,
@@ -1228,6 +1279,7 @@ BTF_ID_FLAGS(func, bpf_kfunc_call_test1)
 BTF_ID_FLAGS(func, bpf_kfunc_call_test2)
 BTF_ID_FLAGS(func, bpf_kfunc_call_test3)
 BTF_ID_FLAGS(func, bpf_kfunc_call_test4)
+BTF_ID_FLAGS(func, bpf_kfunc_call_test5)
 BTF_ID_FLAGS(func, bpf_kfunc_call_test_mem_len_pass1)
 BTF_ID_FLAGS(func, bpf_kfunc_call_test_mem_len_fail1)
 BTF_ID_FLAGS(func, bpf_kfunc_call_test_mem_len_fail2)
diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h b/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h
index b393bf771131..aa0b8d41e71b 100644
--- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h
+++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h
@@ -110,6 +110,7 @@ __u64 bpf_kfunc_call_test1(struct sock *sk, __u32 a, __u64 b,
 int bpf_kfunc_call_test2(struct sock *sk, __u32 a, __u32 b) __ksym;
 struct sock *bpf_kfunc_call_test3(struct sock *sk) __ksym;
 long bpf_kfunc_call_test4(signed char a, short b, int c, long d) __ksym;
+int bpf_kfunc_call_test5(__u8 a, __u16 b, __u32 c) __ksym;
 
 void bpf_kfunc_call_test_pass_ctx(struct __sk_buff *skb) __ksym;
 void bpf_kfunc_call_test_pass1(struct prog_test_pass1 *p) __ksym;
-- 
2.53.0

