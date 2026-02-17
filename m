Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E32F280A29
	for <bpf@vger.kernel.org>; Tue, 17 Feb 2026 16:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771344526; cv=none; b=otOAu7drRQ/fRJQFzQFootoM28TWByAAOQ9Y4u4uRiOcMrrLJPZ0ejzynJlJ7x02tRbDnlBLqi0ZhiaGAqPgtKxGZ681WttaVTP5wAPEKrdt+0iz1l7MlCxJjzGDkhEsxOsmoYkNhK3QqPOOvw3FNBMC6Mrv+H2em/OjpGVqbgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771344526; c=relaxed/simple;
	bh=eIh+sYEseLFtSLE2ccp+WhkVu0HO8MQafZJOsX10l2U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TqTOQUoVhQyBo6UAtqAvazneqlRtkgpcZYjVnXZYzOl7gE6dzs8IYvxb/Ivzssf65zMfQxDsvVHnRsW4zXeWeVJc52lG5tszVnT40mrb5STv7/GRWeLFsO/AcgVYJHAH0Nr3qdw4Qb65HHzFPQSme8PQh+3q8DO4u1cKfdS2BCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=TIDfXCaY; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="TIDfXCaY"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61HB02ko3695618;
	Tue, 17 Feb 2026 16:08:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=injeCjqR9nrCaoJQg
	nUMeSomb6V8PsSfVdkyaPFY5CY=; b=TIDfXCaY9UC9nSeePTXdy9e/Yxl8MUpFt
	Cuj1+7ChN9678nE+s4RBb3FAq+7+yxPT5M0DLMwDilRvwrnWGN0Nyl7hl5I5Gx2Q
	kdk2xicr0NS9977llc4fb1pyLU5vNGPCN7AWjFW+H75zqPSdVmgb3pIfkk4Mqx+B
	6IfxX8ROCNFVHQQazHrN+InAwjcAzwwW6uk0RB7XR6ST17RsnhnzHLdbjxMRZYZN
	l4T/QPTRmsB0QGw1a7p+BUTO4P3k7v5hHyD6Lxv66GZamzFFz1q7FRi7hCatn63t
	URW2C7IHvivQGekNqfeJjFWXRA6qSN2lZ8IFT7NgpxV5tRgkGzz9w==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4caj6rw0wd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Feb 2026 16:08:24 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61HG26uH017777;
	Tue, 17 Feb 2026 16:08:23 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ccb28bka8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Feb 2026 16:08:23 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 61HG8JUZ46727646
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 17 Feb 2026 16:08:19 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D074A20040;
	Tue, 17 Feb 2026 16:08:19 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8609720043;
	Tue, 17 Feb 2026 16:08:19 +0000 (GMT)
Received: from heavy.ibm.com (unknown [9.87.136.123])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 17 Feb 2026 16:08:19 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH 1/2] s390: Introduce bpf_get_lowcore() kfunc
Date: Tue, 17 Feb 2026 17:05:08 +0100
Message-ID: <20260217160813.100855-2-iii@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260217160813.100855-1-iii@linux.ibm.com>
References: <20260217160813.100855-1-iii@linux.ibm.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=dvvWylg4 c=1 sm=1 tr=0 ts=69949278 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=VnNF1IyMAAAA:8 a=1QZ0JqaDopSXdCT8NOYA:9
X-Proofpoint-GUID: PmyK2dzAJ0JArXaFPVBXDn5C8eEiFMKR
X-Proofpoint-ORIG-GUID: PmyK2dzAJ0JArXaFPVBXDn5C8eEiFMKR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE3MDEyNyBTYWx0ZWRfX96LePpvx3pET
 1U8reS82SxhJDOSfx1tNfvx34iFoXdP+JBTwiz89p6dUHCokzDjLiLeCmxpqS83HIeuQwAj4Q6c
 f8aX/fyNNV3Vs7HrIY8LKd8Xm+g4Mje98AIBks3mdxFJFuDadzIuq8CMshDNXIseksrn3zFQYJj
 DA1dyFVOHCqCdVAyR2NyfopwJ2mKA0SSYdlVI9BqIYQqp81xl9zXW9NHD6iIJqAy2+2A/go0lzB
 NW8ixnk5S8FFbjzNGwX1qzXs5UmFXHzG8B12YATcYGcO/JlJNw54HkiTOW+korBoq93FQlDDSUW
 Slcyz/xoGDcYD85BPeKNMMK2oO7NS3d9Pa/5yeAtVlAItEwrZ/XXvWPDmawvY/PBnTZRDGMoIfj
 tBIALU7vSVQoFrs9X5rOI3BAIup+4ZjhHqhwXJNNQQ38SLRMlHCe9lKMBz0jkujhlYU22+9iT/j
 MnjWW+FpzFByiW+3BIQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-17_02,2026-02-16_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 impostorscore=0 adultscore=0
 priorityscore=1501 clxscore=1015 malwarescore=0 phishscore=0 suspectscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602170127

Implementing BPF version of preempt_count() requires accessing lowcore
from BPF. Since lowcore can be relocated, open-coding
(struct lowcore *)0 does not work, so add a kfunc.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 arch/s390/kernel/Makefile                      |  2 ++
 arch/s390/kernel/bpf.c                         | 12 ++++++++++++
 kernel/bpf/helpers.c                           |  3 +++
 tools/testing/selftests/bpf/bpf_experimental.h |  4 ++++
 4 files changed, 21 insertions(+)
 create mode 100644 arch/s390/kernel/bpf.c

diff --git a/arch/s390/kernel/Makefile b/arch/s390/kernel/Makefile
index 42c83d60d6fae..b522c6649fccb 100644
--- a/arch/s390/kernel/Makefile
+++ b/arch/s390/kernel/Makefile
@@ -80,5 +80,7 @@ obj-$(CONFIG_PERF_EVENTS)	+= perf_pai.o
 
 obj-$(CONFIG_TRACEPOINTS)	+= trace.o
 
+obj-$(CONFIG_BPF_SYSCALL)	+= bpf.o
+
 # vdso
 obj-y				+= vdso/
diff --git a/arch/s390/kernel/bpf.c b/arch/s390/kernel/bpf.c
new file mode 100644
index 0000000000000..713337fae6263
--- /dev/null
+++ b/arch/s390/kernel/bpf.c
@@ -0,0 +1,12 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <asm/lowcore.h>
+#include <linux/btf.h>
+
+__bpf_kfunc_start_defs();
+
+__bpf_kfunc struct lowcore *bpf_get_lowcore(void)
+{
+	return get_lowcore();
+}
+
+__bpf_kfunc_end_defs();
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 7ac32798eb041..8c1023da3855d 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -4578,6 +4578,9 @@ BTF_ID_FLAGS(func, bpf_key_put, KF_RELEASE)
 BTF_ID_FLAGS(func, bpf_verify_pkcs7_signature, KF_SLEEPABLE)
 #endif
 #endif
+#ifdef CONFIG_S390
+BTF_ID_FLAGS(func, bpf_get_lowcore)
+#endif
 BTF_KFUNCS_END(generic_btf_ids)
 
 static const struct btf_kfunc_id_set generic_kfunc_set = {
diff --git a/tools/testing/selftests/bpf/bpf_experimental.h b/tools/testing/selftests/bpf/bpf_experimental.h
index 9df77e59d4f5d..4453ad27b2ef7 100644
--- a/tools/testing/selftests/bpf/bpf_experimental.h
+++ b/tools/testing/selftests/bpf/bpf_experimental.h
@@ -627,6 +627,10 @@ struct task_struct___preempt_rt {
 	int softirq_disable_cnt;
 } __attribute__((preserve_access_index));
 
+#ifdef bpf_target_s390
+extern struct lowcore *bpf_get_lowcore(void) __weak __ksym;
+#endif
+
 static inline int get_preempt_count(void)
 {
 #if defined(bpf_target_x86)
-- 
2.53.0

