Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E92C426699;
	Tue,  3 Mar 2026 13:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772543714; cv=none; b=Ej3OKMwLsuDjFo6ziHS29ayLYuXc8FQCD2rax/S/U07pUscTvnpxG62ZNqlxoNoQlRqj2WGJd/2sSRx0i3WHJ3tRxI3hVLz9ZgDLca8JpF0yc7SUz6xD+Fj9e8jWGztL3C9whMMgQwS46A9v1z4fKjjtoAbYe43BIt7pnDEbXiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772543714; c=relaxed/simple;
	bh=/MyWbW03chpBJaPzR/BFPiU3CF6WAhtdLIPgT2cm51U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sWW+NikZ4VZvw46DzXn+fJCTfo/mt8Jkr1YbzN1T1Ter3J1RgzB5Gbkiq8MI95kZHp7tOZOyn/0A++IGp8L6VqHoUld/S0yLO74eL7r8tpjSGkrVfRXm/46Rng698YSDpzjt3FLr6na24xGhRpOxLNIgYz0FW4BPfRG3+hCNc3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=p9osVp3v; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="p9osVp3v"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6237I5Fc2246261;
	Tue, 3 Mar 2026 13:14:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=dnPUKhp1sBymgzQCRaFIsgoe2Dawzv5JW1P6j/OpY
	CY=; b=p9osVp3vdmoZK/EQWZemxOST/WC+Ix1eLV/2GxlrRm4CtYk3D0QjKF2/j
	MQKa55wdcKQvq6Aggla+zeSK1c7yR9MUUYXXngxg90fqQAAmxkDl4FT1BIFs9z2M
	xVxBDHM6CztkSuMvaV2pJRqS/GwmeguicTfuswR2OitqZAL6AwiAqzh/K7CRowHN
	ZmJLjKujx/ziWdDH10CClpk2vdUkgTOG4Ww6YXeVaxJxATj3t4LztGLWVAI6UZSj
	5dryug06E5eMWiBlrAQg1rCnwkCLxwLKv2r+QBMbcXlWLiDTvL8IGlHTp6dKdbYh
	U+XryzWHNl7JpmBNT5RHHK59ts97g==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cksk3truh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 03 Mar 2026 13:14:58 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 623BjWxn027662;
	Tue, 3 Mar 2026 13:14:57 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cmcwja1jp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 03 Mar 2026 13:14:57 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 623DEujj40436020
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 3 Mar 2026 13:14:56 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E777C2004B;
	Tue,  3 Mar 2026 13:14:55 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 97F0F20043;
	Tue,  3 Mar 2026 13:14:54 +0000 (GMT)
Received: from li-bd3f974c-2712-11b2-a85c-df1cec4d728e.in.ibm.com (unknown [9.78.106.17])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  3 Mar 2026 13:14:54 +0000 (GMT)
From: Hari Bathini <hbathini@linux.ibm.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, Shuah Khan <shuah@kernel.org>,
        linux-kselftest@vger.kernel.org
Subject: [PATCH] selftests/bpf: improve test coverage for kfunc call
Date: Tue,  3 Mar 2026 18:44:53 +0530
Message-ID: <20260303131453.328674-1-hbathini@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 8b54qjDb-R5ivBcUuCWV5kQCZ84D1uIU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAzMDEwMyBTYWx0ZWRfX7koSo+OIHtDl
 2IxAg4In0E6t0JkW+wXTtG7vp55D0bC6gPoE/c68QyAy2BVOXK/aVazTEbMaeMZ9X616sIhdRTG
 BFzAZhhcf4Ra0e5heiuVr9DsNEJspwwX8Y9WxCi5N0ZWsC9fDHPRpWWnX0j6pMEq7U3RxKczX41
 SpsmIBKO5MDZYKiKFb1ZZHtbdf/oevcuqHzI/3w4avYv6C++Nf5e/p9/9AdKqhkTIdwt3bG7/3Q
 voGsNGPAQbU4jcrnhfiHVW+8dCbyLn97IHmjk5rTamyOIRdONWdpXfXoucbz9h7+/xsh1U9k4wA
 4IXHkhBWsJ1aUPqvRylPo0K3NgPeo9MQqW303CH1AS1MlnzMWqpUmBuwao5HV3zilPDiA44Sfa7
 k66vby3ELhY3ufp2871023md5345hRQe5tm0lQ3yPGbQYmT7I2a9VPWPPc6XoeBlczccJBBXuBY
 vyVvG7ir9m9pE1xbZLw==
X-Authority-Analysis: v=2.4 cv=csCWUl4i c=1 sm=1 tr=0 ts=69a6ded2 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=AYg3Pj_DittMGbcp-hAA:9
X-Proofpoint-GUID: 8b54qjDb-R5ivBcUuCWV5kQCZ84D1uIU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-02_05,2026-03-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 suspectscore=0 malwarescore=0 adultscore=0
 clxscore=1015 bulkscore=0 phishscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603030103

On powerpc, immediate load instructions are sign extended. In case
of unsigned types, arguments should be explicitly zero-extended by
the caller. For kfunc call, this needs to be handled in the JIT code.
While kfunc_call_test4 test case already checks for sign-extension of
signed argument types in kfunc calls, zero-extension for unsigned
argument types is being checked with this test case.

Signed-off-by: Hari Bathini <hbathini@linux.ibm.com>
---

- powerpc BPF JIT was not handling ABI sign-extension & zero-extension
  appropriately for kfunc calls. Fixed with:

    https://lore.kernel.org/all/20260303130208.325249-7-hbathini@linux.ibm.com/


 .../selftests/bpf/prog_tests/kfunc_call.c     |  1 +
 .../selftests/bpf/progs/kfunc_call_test.c     | 34 +++++++++++++++++++
 .../selftests/bpf/test_kmods/bpf_testmod.c    | 28 +++++++++++++++
 .../bpf/test_kmods/bpf_testmod_kfunc.h        |  1 +
 4 files changed, 64 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/kfunc_call.c b/tools/testing/selftests/bpf/prog_tests/kfunc_call.c
index f79c8e53cb3e..fb06f2485197 100644
--- a/tools/testing/selftests/bpf/prog_tests/kfunc_call.c
+++ b/tools/testing/selftests/bpf/prog_tests/kfunc_call.c
@@ -74,6 +74,7 @@ static struct kfunc_test_params kfunc_tests[] = {
 	TC_TEST(kfunc_call_test1, 12),
 	TC_TEST(kfunc_call_test2, 3),
 	TC_TEST(kfunc_call_test4, -1234),
+	TC_TEST(kfunc_call_test5, 0),
 	TC_TEST(kfunc_call_test_ref_btf_id, 0),
 	TC_TEST(kfunc_call_test_get_mem, 42),
 	SYSCALL_TEST(kfunc_syscall_test, 0),
diff --git a/tools/testing/selftests/bpf/progs/kfunc_call_test.c b/tools/testing/selftests/bpf/progs/kfunc_call_test.c
index 8b86113a0126..a32c3a60fa4f 100644
--- a/tools/testing/selftests/bpf/progs/kfunc_call_test.c
+++ b/tools/testing/selftests/bpf/progs/kfunc_call_test.c
@@ -4,6 +4,40 @@
 #include <bpf/bpf_helpers.h>
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
+	ret = bpf_kfunc_call_test5(0xFF, 0xFFFF, 0xFFFFFFFF);
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
+	ret = bpf_kfunc_call_test5(val8 * 0xFF, val16 * 0xFFFF, val32 * 0xFFFFFFFF);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
 SEC("tc")
 int kfunc_call_test4(struct __sk_buff *skb)
 {
diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
index e62c6b78657f..de4897ddcff1 100644
--- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
+++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
@@ -766,6 +766,33 @@ __bpf_kfunc long noinline bpf_kfunc_call_test4(signed char a, short b, int c, lo
 	return (long)a + (long)b + (long)c + d;
 }
 
+__bpf_kfunc int bpf_kfunc_call_test5(u8 a, u16 b, u32 c)
+{
+	/* Make val as volatile to avoid compiler optimizations on the below checks */
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
@@ -1228,6 +1255,7 @@ BTF_ID_FLAGS(func, bpf_kfunc_call_test1)
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

