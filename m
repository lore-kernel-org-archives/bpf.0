Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF67836D518
	for <bpf@vger.kernel.org>; Tue, 17 Feb 2026 16:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771344525; cv=none; b=fndYdQbpFQvxY0SW0ZUzuRahZ0ClAXA+zU/THWoQOgN716mMhmi20qzRYrJZFAYMIm+4Vg3cc2EPswPaPJIRPH9bFScH2Tm5BA/zyowmY+iqC3jchNee84pwAVC02Lg9lv22LHqnPCeATaBVMjEo8hBRdGA5KYubj/WCuadryvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771344525; c=relaxed/simple;
	bh=6tCZ2EPr4huBj01EOQM/F1PNm+lueXAH008ZePh98rk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R26vkRM0DBSO8nVFiZoe86m/NK/onYKlz239WuWkM44tN9uPEJPNF6VSAKf++Rc9Y5bxFjj09GCVGoPMMIG0BBSribx+SmJGsqGbZM5LNSoD3iZay0wX4vEY5cCpmaMGV2Y/PWn9InF0Bp0edfQNjg4oNbdIw8wdezpIS1xbWdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=rWV0f/If; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="rWV0f/If"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61HG5FuB2616022;
	Tue, 17 Feb 2026 16:08:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=YpMai+Ckl1HoKregs
	C4NVGE1SoHBdiq0YRJFx0janOA=; b=rWV0f/IfOvmDkFk868gj5A9AUbt/xh/SB
	BNYGmTNXucd5KlJpQ/2sF8RLJbMZE8dJwXH7yPKjZtw8uUMCUbSq/XwLhFNZm4z8
	9vVIk/dtjxxlognQyuVCcG/+Z+lQll9nAIgcgNrijJ/0f2XyaNrWSVlge3KdjnjR
	b/86gMFzSbfLllkVQawLXZ0UrL7X25xLqzsRzfpgi5yJWVK3E9mpyxelUbyBzfjC
	VL0FhmTrxYL9XKPwAUWxbue01wVDmkNCmU8AZQyOHCFF9R4SoNAVBUVXdkPGqsAG
	/NHMEdUhHwX3CfQ+fKb+4T3Uo5tZl5oY3Xyz7v270QwVRWSb0FkGQ==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4caj6un1v1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Feb 2026 16:08:24 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61HFn9eQ001381;
	Tue, 17 Feb 2026 16:08:23 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ccb2bbkeg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Feb 2026 16:08:23 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 61HG8K5V27787576
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 17 Feb 2026 16:08:20 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2495320040;
	Tue, 17 Feb 2026 16:08:20 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DB7AF2004B;
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
Subject: [PATCH 2/2] bpf/s390: Implement get_preempt_count()
Date: Tue, 17 Feb 2026 17:05:09 +0100
Message-ID: <20260217160813.100855-3-iii@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=E+/AZKdl c=1 sm=1 tr=0 ts=69949278 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=VnNF1IyMAAAA:8 a=1GQEZibl0TGm58y0pKgA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE3MDEyNyBTYWx0ZWRfX3gkZROgIdRD8
 UIORwYgPSX5JDY8JBbRVx3PR/3gl+/pfAo4xi4tP9MBkH9QXkKcHgjkuvhmys2uCyAejnpmrlIR
 Es9o8UoULohsTOecnOirm6KgaPAQyMGL8uaGOvj9qy+TL1G863q0vMr1ONS4/e5jcJutbD4Pb2K
 rw6lrAuGhhaH6Sblmmq0DHqbC0vNOKMIq7R3OevXSpVNG5rz+U/5PrYtQaTc9agVu4i8Nhm149b
 I/qRzgFRSuFSYTc4jU0HDvzo6yJxu/+XPb9kizfbZtRsdGx3+f7gzZ01s+dKcmdhLJ7koSEo4Fb
 EZdjX8DIgIu6N3A+h+knAREdz8eyVnayUa4aL8BInyr9yBcegDBrG/uZRPquZ3TiLMMJfb3SlLJ
 6XkIA1fRbGWQh03EehBby4s5fFJ3Sy8vbpkclO7NQVuXxut57jc3Ass5PlkLsWXmKh0KrjtfAZC
 mVysKnOsjOYjxUdt3jQ==
X-Proofpoint-ORIG-GUID: QDqsro4s5GoFNcXkM-yc7uFbJKgrqsLm
X-Proofpoint-GUID: QDqsro4s5GoFNcXkM-yc7uFbJKgrqsLm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-17_02,2026-02-16_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 malwarescore=0 phishscore=0 bulkscore=0
 suspectscore=0 spamscore=0 clxscore=1015 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602170127

exe_ctx test fails on s390, because get_preempt_count() is not
implemented and its fallback path always returns 0. Implement it
using the new bpf_get_lowcore() kfunc.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 tools/testing/selftests/bpf/bpf_experimental.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tools/testing/selftests/bpf/bpf_experimental.h b/tools/testing/selftests/bpf/bpf_experimental.h
index 4453ad27b2ef7..44466acf80838 100644
--- a/tools/testing/selftests/bpf/bpf_experimental.h
+++ b/tools/testing/selftests/bpf/bpf_experimental.h
@@ -651,6 +651,8 @@ static inline int get_preempt_count(void)
 	return bpf_get_current_task_btf()->thread_info.preempt.count;
 #elif defined(bpf_target_powerpc)
 	return bpf_get_current_task_btf()->thread_info.preempt_count;
+#elif defined(bpf_target_s390)
+	return bpf_get_lowcore()->preempt_count;
 #endif
 	return 0;
 }
@@ -660,6 +662,7 @@ static inline int get_preempt_count(void)
  *	* x86
  *	* arm64
  *	* powerpc64
+ *	* s390x
  */
 static inline int bpf_in_interrupt(void)
 {
@@ -680,6 +683,7 @@ static inline int bpf_in_interrupt(void)
  *	* x86
  *	* arm64
  *	* powerpc64
+ *	* s390x
  */
 static inline int bpf_in_nmi(void)
 {
@@ -691,6 +695,7 @@ static inline int bpf_in_nmi(void)
  *	* x86
  *	* arm64
  *	* powerpc64
+ *	* s390x
  */
 static inline int bpf_in_hardirq(void)
 {
@@ -702,6 +707,7 @@ static inline int bpf_in_hardirq(void)
  *	* x86
  *	* arm64
  *	* powerpc64
+ *	* s390x
  */
 static inline int bpf_in_serving_softirq(void)
 {
@@ -721,6 +727,7 @@ static inline int bpf_in_serving_softirq(void)
  *	* x86
  *	* arm64
  *	* powerpc64
+ *	* s390x
  */
 static inline int bpf_in_task(void)
 {
-- 
2.53.0

