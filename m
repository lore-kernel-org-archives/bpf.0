Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48A1F2EDD6B
	for <bpf@vger.kernel.org>; Wed, 25 Feb 2026 22:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772057618; cv=none; b=Fks7dKfyVnHdY+D78WuZfyfK0U7ttjoNdTY88kD+TSXmL7zgSvytDYZ28Pdqc+sTJWeF0dZa8MnA7q67TMhdripWaHnpocZ9qUtvgxGaB1jtbxkixcqZFTfw5qwg4iJ8KyHsGdRuOB0qniwPmcRzKATs3n8MtxufSHQZSaYa1dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772057618; c=relaxed/simple;
	bh=uWy7JOeZmBN/++A9/JkYdMLdmz+u5iHdPCOz7rwh1x8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IBDOsLtKGxsIp3lQC2iuNIJaOw/PWYfYIbvaHBxBwJXZST6prRCWtH0WeBrmaz5EA9e5P0qrNQRerUVFss5/IhPDavZ0pR13ayKMu2bgqCqA0PQc9+z6m+420XN8IQc5CbItv2p+mXGbNkZhqcQG+zU38RHdRXAWbEYwS9zn30g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=VIP7Ejlo; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="VIP7Ejlo"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61PF9h772774175;
	Wed, 25 Feb 2026 22:13:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=CKksP/7kRZbD8X/Qs
	1392h9zaNldfBZ6sBaDcofTYeI=; b=VIP7EjloYofvWASNiwQICAuaJPtWM6dQS
	XzmTizVdadPdaxFAaa/Nsm38GFNNRNyKxSHbthAwPdgqf8LgkwHPsJG5zaS7s75m
	r/InEMCnI99CY5SZPiiry/4JdVp7VI8yPWHNzIgIvXE57poRxsVph/Yql3EDR6AQ
	tJdCHwm0vou2XTjfjpOOWiKuPo7jfej41gMUdVxTbylyaGH2kFsGoTyIVcIv8oic
	fyELdqQGt1A+uyv0Bb6pM0zu5fZOiOFZtq2d03HNVERVpSkif44/uGSzYt1vHVjA
	b0upgHjwuwbkUa5M9BL0cNEsTh3HoMrR9xYYqFUxLb69erXNKCyjg==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cf34ca39v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Feb 2026 22:13:12 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61PJWo9f013411;
	Wed, 25 Feb 2026 22:13:12 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4cfqdy7t6v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Feb 2026 22:13:12 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 61PMD75J48103774
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 25 Feb 2026 22:13:08 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D7E5B2004E;
	Wed, 25 Feb 2026 22:13:07 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4CD722004B;
	Wed, 25 Feb 2026 22:13:06 +0000 (GMT)
Received: from ltcrain4-lp15.ltc.tadn.ibm.com (unknown [9.5.7.39])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 25 Feb 2026 22:13:06 +0000 (GMT)
From: adubey@linux.ibm.com
To: linuxppc-dev@lists.ozlabs.org
Cc: bpf@vger.kernel.org, hbathini@linux.ibm.com, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, maddy@linux.ibm.com,
        Abhishek Dubey <adubey@linux.ibm.com>
Subject: [PATCH v4 2/2] selftests/bpf: Enable private stack tests for powerpc64
Date: Wed, 25 Feb 2026 22:13:24 -0500
Message-ID: <20260226031324.17352-2-adubey@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260226031324.17352-1-adubey@linux.ibm.com>
References: <20260226031324.17352-1-adubey@linux.ibm.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI1MDIxMiBTYWx0ZWRfX1ZZw63RUuebZ
 p2axfhHD6cYAGwdnEOJad33AopxKHzn0we+rw9iMvLSWrtEOMXie3jSQGUUCyxan5Dja1vfJaZH
 aoY/srR8LhGZQdYzHj8ILACODBaKVLN8mXGJhChAV8hlq+nRVbUoDFZfbkOmn50jz8cqNL7zMrR
 588sauooQs2VJJ9COWIrOpP6HtegTquMRbiajwbCQEymq/yeEvcloP2dc0kS7XH+IR81BdEhs2B
 dayWbUyApJaFbpyszuLg9U8ER+X88UIo5zkvijH6epFhhTNPI6CCJnurN0AcwppS358gttY46X/
 U+B489nzS6K23gfSfH5sLlnhdCI192NkG1KcObTkK/E4k+6VR/HgHqSxjss9A+qhHBm8XmkJS8n
 g4PseBhwlQWVToDaK1LDOprQ2kCVs3ZGrrfHs4ZsL6OJ8NMxidLYcbZjtH+3QuRcYtgFJLVPmn8
 VD0YTji5aQVtqJKNo0g==
X-Proofpoint-ORIG-GUID: GHF6h37bvVam8xQGisGvshypyii9lGEI
X-Authority-Analysis: v=2.4 cv=F9lat6hN c=1 sm=1 tr=0 ts=699f73f8 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=WRW5XrRV495NP23rXD4A:9
X-Proofpoint-GUID: GHF6h37bvVam8xQGisGvshypyii9lGEI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-25_03,2026-02-25_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 bulkscore=0 adultscore=0 spamscore=0
 clxscore=1015 suspectscore=0 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602250212

From: Abhishek Dubey <adubey@linux.ibm.com>

With support of private stack, relevant tests must pass
on powerpc64.

#./test_progs -t struct_ops_private_stack
#434/1   struct_ops_private_stack/private_stack:OK
#434/2   struct_ops_private_stack/private_stack_fail:OK
#434/3   struct_ops_private_stack/private_stack_recur:OK
#434     struct_ops_private_stack:OK
Summary: 1/3 PASSED, 0 SKIPPED, 0 FAILED

v2->v3:
  Enable testcase using __powerpc64__ instead of __TARGET_ARCH_powerpc,
  to prevent it getting invoked on powerpc32

[v2]: https://lore.kernel.org/bpf/20260225153950.15331-1-adubey@linux.ibm.com

Signed-off-by: Abhishek Dubey <adubey@linux.ibm.com>
---
 .../bpf/prog_tests/struct_ops_private_stack.c | 29 +++++++++----------
 .../bpf/progs/struct_ops_private_stack.c      |  6 ----
 .../bpf/progs/struct_ops_private_stack_fail.c |  6 ----
 .../progs/struct_ops_private_stack_recur.c    |  6 ----
 4 files changed, 13 insertions(+), 34 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/struct_ops_private_stack.c b/tools/testing/selftests/bpf/prog_tests/struct_ops_private_stack.c
index 4006879ca3fe..afad3522b772 100644
--- a/tools/testing/selftests/bpf/prog_tests/struct_ops_private_stack.c
+++ b/tools/testing/selftests/bpf/prog_tests/struct_ops_private_stack.c
@@ -5,6 +5,7 @@
 #include "struct_ops_private_stack_fail.skel.h"
 #include "struct_ops_private_stack_recur.skel.h"
 
+#if defined(__x86_64__) || defined(__aarch64__) || defined(__powerpc64__)
 static void test_private_stack(void)
 {
 	struct struct_ops_private_stack *skel;
@@ -15,11 +16,6 @@ static void test_private_stack(void)
 	if (!ASSERT_OK_PTR(skel, "struct_ops_private_stack__open"))
 		return;
 
-	if (skel->data->skip) {
-		test__skip();
-		goto cleanup;
-	}
-
 	err = struct_ops_private_stack__load(skel);
 	if (!ASSERT_OK(err, "struct_ops_private_stack__load"))
 		goto cleanup;
@@ -48,11 +44,6 @@ static void test_private_stack_fail(void)
 	if (!ASSERT_OK_PTR(skel, "struct_ops_private_stack_fail__open"))
 		return;
 
-	if (skel->data->skip) {
-		test__skip();
-		goto cleanup;
-	}
-
 	err = struct_ops_private_stack_fail__load(skel);
 	if (!ASSERT_ERR(err, "struct_ops_private_stack_fail__load"))
 		goto cleanup;
@@ -72,11 +63,6 @@ static void test_private_stack_recur(void)
 	if (!ASSERT_OK_PTR(skel, "struct_ops_private_stack_recur__open"))
 		return;
 
-	if (skel->data->skip) {
-		test__skip();
-		goto cleanup;
-	}
-
 	err = struct_ops_private_stack_recur__load(skel);
 	if (!ASSERT_OK(err, "struct_ops_private_stack_recur__load"))
 		goto cleanup;
@@ -95,7 +81,7 @@ static void test_private_stack_recur(void)
 	struct_ops_private_stack_recur__destroy(skel);
 }
 
-void test_struct_ops_private_stack(void)
+static void __test_struct_ops_private_stack(void)
 {
 	if (test__start_subtest("private_stack"))
 		test_private_stack();
@@ -104,3 +90,14 @@ void test_struct_ops_private_stack(void)
 	if (test__start_subtest("private_stack_recur"))
 		test_private_stack_recur();
 }
+#else
+static void __test_struct_ops_private_stack(void)
+{
+	test__skip();
+}
+#endif
+
+void test_struct_ops_private_stack(void)
+{
+	__test_struct_ops_private_stack();
+}
diff --git a/tools/testing/selftests/bpf/progs/struct_ops_private_stack.c b/tools/testing/selftests/bpf/progs/struct_ops_private_stack.c
index dbe646013811..3cd0c1a55cbd 100644
--- a/tools/testing/selftests/bpf/progs/struct_ops_private_stack.c
+++ b/tools/testing/selftests/bpf/progs/struct_ops_private_stack.c
@@ -7,12 +7,6 @@
 
 char _license[] SEC("license") = "GPL";
 
-#if defined(__TARGET_ARCH_x86) || defined(__TARGET_ARCH_arm64)
-bool skip __attribute((__section__(".data"))) = false;
-#else
-bool skip = true;
-#endif
-
 void bpf_testmod_ops3_call_test_2(void) __ksym;
 
 int val_i, val_j;
diff --git a/tools/testing/selftests/bpf/progs/struct_ops_private_stack_fail.c b/tools/testing/selftests/bpf/progs/struct_ops_private_stack_fail.c
index 3d89ad7cbe2a..1442728f5604 100644
--- a/tools/testing/selftests/bpf/progs/struct_ops_private_stack_fail.c
+++ b/tools/testing/selftests/bpf/progs/struct_ops_private_stack_fail.c
@@ -7,12 +7,6 @@
 
 char _license[] SEC("license") = "GPL";
 
-#if defined(__TARGET_ARCH_x86) || defined(__TARGET_ARCH_arm64)
-bool skip __attribute((__section__(".data"))) = false;
-#else
-bool skip = true;
-#endif
-
 void bpf_testmod_ops3_call_test_2(void) __ksym;
 
 int val_i, val_j;
diff --git a/tools/testing/selftests/bpf/progs/struct_ops_private_stack_recur.c b/tools/testing/selftests/bpf/progs/struct_ops_private_stack_recur.c
index b1f6d7e5a8e5..faaa0f8d65a4 100644
--- a/tools/testing/selftests/bpf/progs/struct_ops_private_stack_recur.c
+++ b/tools/testing/selftests/bpf/progs/struct_ops_private_stack_recur.c
@@ -7,12 +7,6 @@
 
 char _license[] SEC("license") = "GPL";
 
-#if defined(__TARGET_ARCH_x86) || defined(__TARGET_ARCH_arm64)
-bool skip __attribute((__section__(".data"))) = false;
-#else
-bool skip = true;
-#endif
-
 void bpf_testmod_ops3_call_test_1(void) __ksym;
 
 int val_i, val_j;
-- 
2.52.0

