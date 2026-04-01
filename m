Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 120EB3DCDAD;
	Wed,  1 Apr 2026 11:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775042508; cv=none; b=tZZQIhbNs3eIYsHh02b4Fltgty+Ga3Wytt9uP9oUTpsIMoX674LFYBspL+uCbR24UjfCCRQZsWfKH9RtTrB7iopC3jn97tOpVKdg7ldLeFWRtOWvHW6iD6QGoplA8wsOxBHJa/tQrcI471MyhKba1UfFcAtifdCEpOlkZlnHao8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775042508; c=relaxed/simple;
	bh=OLCGiGaoee2/lY6eid7VgOZH4Z/Bdb45+9znUaQF/+g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rCTSFiqge8zzaRty2ttZmTxmPR08WSkuauuCkmQNzyVy9IHx2joQIq/Z0cgED4VuxYgdQ/CJ9y2vxsDS1UQkH0NPcvqUiaqRoXw58UV5IctB2rxMA0J8QZfed4eexaSlXGCQPTMtWdhF1jI0BAV2hcGNqJ0uRHHpgv2qyKIk4rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=s7RW4b1N; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="s7RW4b1N"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 631AC5Fd119453;
	Wed, 1 Apr 2026 11:21:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=B8sLrD5INAbLnxutZ
	cOEx6h9KhE/KtCmj7IYXlwDiZQ=; b=s7RW4b1Ney98AKb4GPDbitkbUCQL4SI1f
	QKCYrTqcQRyRI9G5uNSHPAu5R10vf/M9y8wMagUW5n5stCPs5fBrE0P9SqLofbR9
	rlFGLdPwWpEJsFjWqnNmCPnTIMc8JEVPiMspXrL06mQkIwAMM3fiOT3jBBFppsrh
	o2V8idC/j5+97rDukMG0OkkAKMQ/SIMiEHT2i06TjMIH/8GOQbI8flC/7g/GQymH
	MQ3r4/xv+Sbi5Vst8G7q35nw8cexz4qTA1jF9N42AeQe5zxD+At4sSC1aex0swKB
	bmnQ34gRfIfiKYbEO8FMZ0tYAcwRZeECwy1drbIQ4ROsiZqD1LHrw==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d66ms7213-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Apr 2026 11:21:29 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 631AVJYA021722;
	Wed, 1 Apr 2026 11:21:28 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4d6sasnf5f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Apr 2026 11:21:28 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 631BLPdC15204646
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 1 Apr 2026 11:21:25 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 060E720043;
	Wed,  1 Apr 2026 11:21:25 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 00E3120040;
	Wed,  1 Apr 2026 11:21:23 +0000 (GMT)
Received: from ltcrain4-lp15.ltc.tadn.ibm.com (unknown [9.5.7.39])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  1 Apr 2026 11:21:22 +0000 (GMT)
From: adubey@linux.ibm.com
To: linuxppc-dev@lists.ozlabs.org
Cc: hbathini@linux.ibm.com, bpf@vger.kernel.org, maddy@linux.ibm.com,
        ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
        shuah@kernel.org, linux-kselftest@vger.kernel.org,
        Abhishek Dubey <adubey@linux.ibm.com>,
        Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Subject: [PATCH v3 2/4] selftest/bpf: Enable instruction array test for powerpc
Date: Wed,  1 Apr 2026 11:21:31 -0400
Message-ID: <20260401152133.42544-3-adubey@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260401152133.42544-1-adubey@linux.ibm.com>
References: <20260401152133.42544-1-adubey@linux.ibm.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=J6enLQnS c=1 sm=1 tr=0 ts=69ccffb9 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=qzfPCzmIJ3PduWSRb40A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAxMDEwMyBTYWx0ZWRfXyPfEgqGD7SOi
 VfrU9UPtMXvWvKhJMbwSVfiZoR75x3q6zAul72c414GXPl5Brd6TrrnVu6ixEPFEEAC58ROb6JR
 JpVZARgY2C+usN5XzMCS6FDzHc7Ou82mve2a+2BGRLVgFvc7mFLsPtlhJEZXxT1uGJBhzOcGyr5
 mUrhnkEeu7jkFNwYmzpJcSkDqfoYHGYSrRvAjrwiKN1giok9AAyIm2LpL3sAqCZk7Uo+Q947DB0
 21XARdBFrjYJ+HfQsD6OhpNHwmKUpUN3RXv/XO29uatZ4iZm3Wv3i9bbNBh/X0Gq/U/8d4OpxbT
 RU16ixEldCEmrdoL7wRdGOr94xaIJTwohhNbI6i8PqI39h6IIo231WW4wtfycy+3Bm7L73dG/cj
 A7PuRm6ZneF2YI97vy/K3fz+2uMUJyNsGV1qrRcDndB6c2G/auJqOglS5S78u8bIHiIMZEpvOTF
 R95ydDedwSzsNI93jpg==
X-Proofpoint-GUID: b4MXLmGxMsq1C9CEfufWWM9xtnL8C542
X-Proofpoint-ORIG-GUID: b4MXLmGxMsq1C9CEfufWWM9xtnL8C542
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-01_03,2026-04-01_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 adultscore=0 priorityscore=1501 bulkscore=0
 phishscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604010103

From: Abhishek Dubey <adubey@linux.ibm.com>

With instruction array now supported, enable corresponding bpf
selftest for powerpc.

Signed-off-by: Abhishek Dubey <adubey@linux.ibm.com>
Acked-by: Hari Bathini <hbathini@linux.ibm.com>
Tested-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
---
 tools/testing/selftests/bpf/prog_tests/bpf_insn_array.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_insn_array.c b/tools/testing/selftests/bpf/prog_tests/bpf_insn_array.c
index 269870bec941..482d38b9c29e 100644
--- a/tools/testing/selftests/bpf/prog_tests/bpf_insn_array.c
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_insn_array.c
@@ -3,7 +3,7 @@
 #include <bpf/bpf.h>
 #include <test_progs.h>
 
-#ifdef __x86_64__
+#if defined(__x86_64__) || defined(__powerpc__)
 static int map_create(__u32 map_type, __u32 max_entries)
 {
 	const char *map_name = "insn_array";
-- 
2.52.0

