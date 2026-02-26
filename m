Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A4B8377561
	for <bpf@vger.kernel.org>; Wed, 25 Feb 2026 23:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772061166; cv=none; b=iX2rIV0/b1LN/zkQLwTRwj8TG8ltX0Bfwv+GBYHk/TiNld7mouS/JITMIUw/N5LeFVKcuVevKCFsDiG9vZcLoh/MPh5Gc/T6N/bWZuP0NboJq4CnQRzXppWbkXFcj5jMWyh51oL/RybOlRYERK+CLaKrEQTyvxR+JsmrEBRVpv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772061166; c=relaxed/simple;
	bh=Kbwq5zrQGjkxUE667axG+mbs1PJ3JbROsozrpQRb/mQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=exdPuiWMTfLaNNW+yO0COWBmQsfkomGqoti8D0I4KPxtGm2AgYYh/TeLFaYBYK5M+o97nlByIO+ayESjfpxROpO/N7Q0Kci07t+EBdv7/iHL8SNF/dRC19l5WcQEDfSz5xuXDBs4OMooJ+1rPlRzs6/6rlBDhrz+04auH+TOIKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=GCmiVXF3; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="GCmiVXF3"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61PN3ZNH3100088;
	Wed, 25 Feb 2026 23:12:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=bJBI3RFG9a8FQwceD
	r4O9OG/l515U/udor1eVd7h3wQ=; b=GCmiVXF3FOI7exMbCxNxgqXAKTFdZ6tdY
	FqQ45Qt8YoOBqYq4IpTpuVduYSo2oTPQLu0UWfaJGp6KNvkaRArhXXUsOzimA9Po
	SE2cHESZnHtaXj7zpfZc7HYtmm9UT7N/YTxVFNR6/s8mJWv+YNKJXAd2fUZcOQmi
	Z0jxc+CyCz05H2hoccjf6BH9UJh9wGHIZZiTXYUQYHS2KJj/gt4ufDqPKIJCIfAW
	UYm0EnxHcIwiQXjQe1fk4yYt8f0AKJg4ZRVrIS6YQNZM9ZGbM2qL0x5ehDtgsj1Q
	v3aBxuNRh6b43hTwVtDy6eMzfvUw98A97Cle2/07kkhpPx8moHn0Q==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cf34caa73-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Feb 2026 23:12:27 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61PMlrT4015764;
	Wed, 25 Feb 2026 23:12:26 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cfq1sr36t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Feb 2026 23:12:26 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 61PNCNWG31850790
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 25 Feb 2026 23:12:23 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 03FF420049;
	Wed, 25 Feb 2026 23:12:23 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 717022004B;
	Wed, 25 Feb 2026 23:12:21 +0000 (GMT)
Received: from ltcrain4-lp15.ltc.tadn.ibm.com (unknown [9.5.7.39])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 25 Feb 2026 23:12:21 +0000 (GMT)
From: adubey@linux.ibm.com
To: linuxppc-dev@lists.ozlabs.org
Cc: bpf@vger.kernel.org, hbathini@linux.ibm.com, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, maddy@linux.ibm.com,
        Abhishek Dubey <adubey@linux.ibm.com>
Subject: [PATCH v2 2/3] selftest/bpf: Enable get_func_args and get_func_ip tests on powerpc64
Date: Wed, 25 Feb 2026 23:12:16 -0500
Message-ID: <20260226041217.18059-2-adubey@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260226041217.18059-1-adubey@linux.ibm.com>
References: <20260226041217.18059-1-adubey@linux.ibm.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI1MDIyMSBTYWx0ZWRfX8hs6iphqIk3S
 be/ly43XLDOl+OZ9qU+7XstVORV7WP7i7nAWJKWxF30D+IPvlJchRNh9A9Xr1GcM2uXB67lkSu6
 D8UeWKwpTTq5u+F8GIFA/ho2FCVEWNKmfYRgV2H+dpAUr1cBQvKeTuaUDOe6nzunMp7jmFGRo4Y
 KiqieI2WZhyV6Qwi5VqgBZXEAgfeH7KmK9q16JQDb8wpPjLcPtL6dkYuLlpBCcVuMYmDM7+1y4p
 Uxr1ILFq4dnDpYmEo8CMK7z5zXJ9n6+eo8+WVX6W9jNVIYt87vLffAVGftnE82JlENk21Kdt7Cm
 aMtmvW+yBHua9JmlvisrUbZDv0KMH0AESh0GaTU+zizKI7BZGvrYrJWDr2BAhOPOQGs1LUbKLm2
 jwqCsFJWXA6RZpnXsle3XnGxa6nJNBjSOQ8xL9e/zLnYTEgFPhd3Ybo23ek0/ey3ZimP4KDsQag
 mYZG6f88eZ5VNPpTUxA==
X-Proofpoint-ORIG-GUID: urcxs8dHxKb8U3Iq6BR2V5Y5SH-Ca_s4
X-Authority-Analysis: v=2.4 cv=F9lat6hN c=1 sm=1 tr=0 ts=699f81db cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=DaqX_wUs_lNjO4TYtv0A:9
X-Proofpoint-GUID: urcxs8dHxKb8U3Iq6BR2V5Y5SH-Ca_s4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-25_04,2026-02-25_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 bulkscore=0 adultscore=0 spamscore=0
 clxscore=1015 suspectscore=0 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602250221

From: Abhishek Dubey <adubey@linux.ibm.com>

Allow get_func_args, get_func_ip & fsession selftests to run on
powerpc64.

# ./test_progs -t fsession
#135/1   fsession_test/fsession_test:OK
#135/2   fsession_test/fsession_reattach:OK
#135/3   fsession_test/fsession_cookie:OK
#135     fsession_test:OK
Summary: 1/3 PASSED, 0 SKIPPED, 0 FAILED

# ./test_progs -t get_func
#138     get_func_args_test:OK
#139     get_func_ip_test:OK
Summary: 2/0 PASSED, 0 SKIPPED, 0 FAILED

v1->v2:
  Resolve merge conflict

[v1]: https://lore.kernel.org/bpf/20260216155310.38457-1-adubey@linux.ibm.com

Signed-off-by: Abhishek Dubey <adubey@linux.ibm.com>
---
 tools/testing/selftests/bpf/progs/get_func_args_test.c | 3 ++-
 tools/testing/selftests/bpf/progs/get_func_ip_test.c   | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/get_func_args_test.c b/tools/testing/selftests/bpf/progs/get_func_args_test.c
index 075a1180ec26..1fe1fb0548ea 100644
--- a/tools/testing/selftests/bpf/progs/get_func_args_test.c
+++ b/tools/testing/selftests/bpf/progs/get_func_args_test.c
@@ -167,7 +167,8 @@ int BPF_PROG(tp_test2)
 }
 
 __u64 test7_result = 0;
-#if defined(bpf_target_x86) || defined(bpf_target_arm64) || defined(bpf_target_riscv)
+#if defined(bpf_target_x86) || defined(bpf_target_arm64) ||	\
+	defined(bpf_target_riscv) || defined(bpf_target_powerpc64)
 SEC("fsession/bpf_fentry_test1")
 int BPF_PROG(test7)
 {
diff --git a/tools/testing/selftests/bpf/progs/get_func_ip_test.c b/tools/testing/selftests/bpf/progs/get_func_ip_test.c
index 45eaa54d1ac7..be6b1a073b11 100644
--- a/tools/testing/selftests/bpf/progs/get_func_ip_test.c
+++ b/tools/testing/selftests/bpf/progs/get_func_ip_test.c
@@ -106,7 +106,8 @@ int BPF_URETPROBE(test8, int ret)
 
 __u64 test9_entry_result = 0;
 __u64 test9_exit_result = 0;
-#if defined(bpf_target_x86) || defined(bpf_target_arm64) || defined(bpf_target_riscv)
+#if defined(bpf_target_x86) || defined(bpf_target_arm64) ||	\
+	defined(bpf_target_riscv) || defined(bpf_target_powerpc64)
 SEC("fsession/bpf_fentry_test1")
 int BPF_PROG(test9, int a)
 {
-- 
2.52.0

