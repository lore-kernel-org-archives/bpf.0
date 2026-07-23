Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4E914746D4
	for <bpf@vger.kernel.org>; Thu, 23 Jul 2026 14:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784815651; cv=none; b=a8NlxOLRQb69Zfj7hkv5hAKJMY1Kc2fTBsmZgEmAk+YYbwNsWYA+Rlwky4yCl1R7iuW6mf2fyb5HKIPdSVhJ8Hwekz3FvUYvZ8glcZz4MHZhUK64cXNLd1suUKi58kpu8lXsqpCkN/ejt+k+OnfdovOoVWs6WbphfGjtNTa7n+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784815651; c=relaxed/simple;
	bh=sQiCF/bv5r8bm9OyGOm2NTYMVHexF4u6R5i27+GJOnA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dq+scvMoJKursvhXEabP++jBo89wLEGgql+zYdVy4wLBnX9bwJ54c4mtDNqMcA3qT8wE8NcOMa81TXjYNmiDZDmf/Kqqs868UgwKZwWO/7ZvimshFacO2nWrT6ovXIICHE70yHAFYa1FfhsZBmR8zzwwt9gmsPmDB5Jq3vnaiA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=JejNtqLZ; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="JejNtqLZ"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66NDC3C72987036;
	Thu, 23 Jul 2026 14:07:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=ULoFRS2IvNt03k00F
	Q6yoREvo+b7YLgDOISpnMy4iTE=; b=JejNtqLZ+ESo7IP1caFVgtSFBO+1Fa5fK
	WaTBkJavmQ4MHT/LGmk6S4FiyHLKhiBiQccvBguYDP/U1/zwyLf/vvz/oWPICrKx
	D735xIiGZiwmVG5FBVwj7RIL8cd8b+1ICG0doiV+k36+1exYY7m9tAtmtxjsU5rP
	cGcc01TWhciymW88KyKnVBYMDjluT/vWjfiEBbIKYcCaopjJL10IyYr6C7ZKU0o/
	Pl2DFPKKxqafrHE/dFsMp4IMdzx36OOzY5fCMKv1cEnc5VcjtsjYo/Ph+ym3Hmnl
	8e11wWYBb3JLh65WSA/El4z2uaOxoYL8GEatHdHqkuI4aeTGb5i8w==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg78gf9ga-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Jul 2026 14:07:09 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66NE4cwr029918;
	Thu, 23 Jul 2026 14:07:09 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fgmtk4gg3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Jul 2026 14:07:09 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66NE77IA14156534
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 Jul 2026 14:07:07 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C36965803F;
	Thu, 23 Jul 2026 14:07:07 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9F7715804E;
	Thu, 23 Jul 2026 14:07:05 +0000 (GMT)
Received: from thinkpad-p1.ehn-de.ibm.com (unknown [9.224.75.254])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 23 Jul 2026 14:07:05 +0000 (GMT)
From: Maxim Khmelevskii <max@linux.ibm.com>
To: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc: bpf@vger.kernel.org, Ilya Leoshkevich <iii@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Subject: [PATCH bpf-next 3/3] s390/bpf: Enable atomics tests for s390
Date: Thu, 23 Jul 2026 16:03:51 +0200
Message-ID: <20260723140648.583055-8-max@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260723140648.583055-5-max@linux.ibm.com>
References: <20260723140648.583055-5-max@linux.ibm.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIzMDEzNSBTYWx0ZWRfX23xn0B9S2Wzs
 lZeh35ixObfFlpjWhjupicsx1NOsEuZdDJHqPUeT/3CeFQe2wBYlHaF84HNPQxjPt8CuccOQfMV
 VtxAuWSwpuLaO3B4gBjZS/Qp94fKLULqd3lGMR2moBg3LgkNR7FAwu76wJYE5tC42YS82NuplHD
 s6zJXBYV/4SC4zHxoh6LFPzOS8FY+2nW9mUHYt9asUzoXkHXSC/kUuXu3xI9t0jgv/PHDqfIiqz
 /VX0/nia3M6UAe+EZUEgGr6S/Vco6VRJPDDeuxytA1fWG+cnNAdAjZKsJon7l6JLrLJA2DBkNGq
 S6l6fsAhf6euNzeZwSZQ8Zpo3FEwDiLhYkyrxsuBrEBLfByuUc5i/Ig7/Gn7+8BmSePAOeOJ5me
 /Ioi6T/mQqiKPdkcXwpRTbQreEeLkSKdnTJ4waAK/yJGv5xYDU74J/DAYJITGoUkWF9MjlH1oQH
 ej6h9SRf3D3VoETTf8A==
X-Proofpoint-GUID: pga3sMQ7acDb-kMo1sYkaXwPWfCcqOUj
X-Authority-Analysis: v=2.4 cv=MelcfZ/f c=1 sm=1 tr=0 ts=6a62200d cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=-kW5C2ItWs_aNgl303YA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIzMDEzNSBTYWx0ZWRfXzDFWnkCzE0An
 HV3LUj8BlQKfWzwvt3KdF+pJLRfbKe0CpkyDOwBAogRd7jQu3RhD3s7GwDI0A4gSKybcXtE4bHR
 meLUlMzmIZcGVT17OtcOS/G8QPkX1hI=
X-Proofpoint-ORIG-GUID: pga3sMQ7acDb-kMo1sYkaXwPWfCcqOUj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-23_04,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0 spamscore=0
 clxscore=1015 malwarescore=0 phishscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607230135

Add s390 to the if statement, that defines CAN_USE_LOAD_ACQ_STORE_REL.
Reuse CAN_USE_LOAD_ACQ_STORE_REL in arena_atomics selftest,
to remove code duplication.

Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>
Signed-off-by: Maxim Khmelevskii <max@linux.ibm.com>
---
 .../selftests/bpf/progs/arena_atomics.c        | 18 ++++++++++++------
 tools/testing/selftests/bpf/progs/bpf_misc.h   |  9 ++++++---
 2 files changed, 18 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/arena_atomics.c b/tools/testing/selftests/bpf/progs/arena_atomics.c
index 2e7751a85399..73bc2b835f3f 100644
--- a/tools/testing/selftests/bpf/progs/arena_atomics.c
+++ b/tools/testing/selftests/bpf/progs/arena_atomics.c
@@ -28,8 +28,10 @@ bool skip_all_tests = true;
 
 #if defined(ENABLE_ATOMICS_TESTS) &&		  \
 	defined(__BPF_FEATURE_ADDR_SPACE_CAST) && \
-	(defined(__TARGET_ARCH_arm64) || defined(__TARGET_ARCH_x86) || \
-	 (defined(__TARGET_ARCH_riscv) && __riscv_xlen == 64))
+	(defined(__TARGET_ARCH_arm64) || \
+	 defined(__TARGET_ARCH_x86) || \
+	 (defined(__TARGET_ARCH_riscv) && __riscv_xlen == 64) || \
+	 defined(__TARGET_ARCH_s390))
 bool skip_lacq_srel_tests __attribute((__section__(".data"))) = false;
 #else
 bool skip_lacq_srel_tests = true;
@@ -315,8 +317,10 @@ int load_acquire(const void *ctx)
 {
 #if defined(ENABLE_ATOMICS_TESTS) &&		  \
 	defined(__BPF_FEATURE_ADDR_SPACE_CAST) && \
-	(defined(__TARGET_ARCH_arm64) || defined(__TARGET_ARCH_x86) || \
-	 (defined(__TARGET_ARCH_riscv) && __riscv_xlen == 64))
+	(defined(__TARGET_ARCH_arm64) || \
+	 defined(__TARGET_ARCH_x86) || \
+	 (defined(__TARGET_ARCH_riscv) && __riscv_xlen == 64) || \
+	 defined(__TARGET_ARCH_s390))
 
 #define LOAD_ACQUIRE_ARENA(SIZEOP, SIZE, SRC, DST)	\
 	{ asm volatile (				\
@@ -367,8 +371,10 @@ int store_release(const void *ctx)
 {
 #if defined(ENABLE_ATOMICS_TESTS) &&		  \
 	defined(__BPF_FEATURE_ADDR_SPACE_CAST) && \
-	(defined(__TARGET_ARCH_arm64) || defined(__TARGET_ARCH_x86) || \
-	 (defined(__TARGET_ARCH_riscv) && __riscv_xlen == 64))
+	(defined(__TARGET_ARCH_arm64) || \
+	 defined(__TARGET_ARCH_x86) || \
+	 (defined(__TARGET_ARCH_riscv) && __riscv_xlen == 64) || \
+	 defined(__TARGET_ARCH_s390))
 
 #define STORE_RELEASE_ARENA(SIZEOP, DST, VAL)	\
 	{ asm volatile (			\
diff --git a/tools/testing/selftests/bpf/progs/bpf_misc.h b/tools/testing/selftests/bpf/progs/bpf_misc.h
index b0c441384f20..5eacf1b43252 100644
--- a/tools/testing/selftests/bpf/progs/bpf_misc.h
+++ b/tools/testing/selftests/bpf/progs/bpf_misc.h
@@ -264,9 +264,12 @@
 #endif
 
 #if __clang_major__ >= 18 && defined(ENABLE_ATOMICS_TESTS) &&		\
-	(defined(__TARGET_ARCH_arm64) || defined(__TARGET_ARCH_x86) ||	\
-	(defined(__TARGET_ARCH_riscv) && __riscv_xlen == 64) || \
-	defined(__TARGET_ARCH_powerpc) || defined(__TARGET_ARCH_loongarch))
+	(defined(__TARGET_ARCH_arm64) ||				\
+	 defined(__TARGET_ARCH_x86) ||					\
+	 (defined(__TARGET_ARCH_riscv) && __riscv_xlen == 64) ||	\
+	 defined(__TARGET_ARCH_s390) ||					\
+	 defined(__TARGET_ARCH_powerpc) ||				\
+	 defined(__TARGET_ARCH_loongarch))
 #define CAN_USE_LOAD_ACQ_STORE_REL
 #endif
 
-- 
2.55.0

