Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34CFA396B82;
	Fri, 10 Apr 2026 10:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775818473; cv=none; b=FFi+pMg6RAJNfXlRUHxTKsuLyBWlw68q+3UCISlvvahct5u/OQUr/oIKdwlJwCDZ8jubtF1UvYl0IHMa9z5ssPhXA3cpkFd+tpLT7ttMZxp55sBXAWo77B9QgYbnF7Kdt54Fv66Gc+LoF/1rExU6dWXX1WAj0dzatt+AppTroCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775818473; c=relaxed/simple;
	bh=2EdHCsAD4jtFpVhokSRSmDHiF05jvD3EmVglWBqRjQ4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=a4vf0cwrtsoGsiHa00QLFEOULX0RvqSjzYHMcGrayJNS6otHkXHgSOQKdOeBC87VfNUdUqb7O5scCgXaPUy6DcndRuzLYsKAbDOJKrhP6iOyQlao2ZYPDSxK3d99lq+M3yVaULw6CT/CKnW3zFvrL9OrNdZtBkhAXZbpG8eGuek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=jWz6cGAO; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="jWz6cGAO"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63A10AcX2592757;
	Fri, 10 Apr 2026 10:54:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=KFHFjsFq5MrU8B5Bmbcnu5De8RhaBKL5ohjIz4RcE
	FE=; b=jWz6cGAOeFdWnP0aoRYrrlCmUvA3eEoPuK4fkFH6TNNIpXui5xvJxlC3i
	gzXHtHwFDi03a4xpzfFUBBAIz0yYjmVnQir9bhaIiI6BoSgTa4YpHcfquKTkysHM
	h26oGmWnWBZXUjFS/367oebap/RuZxjc3jtCRIbXwTbKT501N5EPVF/9a3K4oUvp
	erpRUqzCMGGkBb7cwoODStC8+jlJKF4fQuPeeuhJZi0HQZKiryPu7HyYcAPM1HoL
	3B38ciuidc7X9ig6CmXzJnnPUXRTX2kbExE69HTJSZMCn6yHUtJhWn4VWpPcWxvp
	Uwy4bMR/9/KpXeHQKt2GsBmb27odA==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dcn2ehjg3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 Apr 2026 10:54:21 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 63A85k3U014361;
	Fri, 10 Apr 2026 10:54:20 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dcmg4yn2d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 Apr 2026 10:54:20 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63AAsG0Q43319710
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 10 Apr 2026 10:54:16 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7B20320043;
	Fri, 10 Apr 2026 10:54:16 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B2AEE20040;
	Fri, 10 Apr 2026 10:54:10 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.61.241.130])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 10 Apr 2026 10:54:10 +0000 (GMT)
From: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
To: bpf@vger.kernel.org
Cc: skb99@linux.ibm.com, hbathini@linux.ibm.com, adubey@linux.ibm.com,
        ast@kernel.org, alexei.starovoitov@gmail.com, peterz@infradead.org,
        andrii@kernel.org, maddy@linux.ibm.com, linux-kernel@vger.kernel.org,
        riteshh@linux.ibm.com, alan.maguire@oracle.com,
        Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Subject: [PATCH] bpf/selftests: remove test_access_variable_array
Date: Fri, 10 Apr 2026 16:24:04 +0530
Message-ID: <20260410105404.91126-1-venkat88@linux.ibm.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: T4oXYMgLFhRq7UyLFey0V-HlOymnvtms
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEwMDEwMCBTYWx0ZWRfX6NDdCvwL8kUH
 pE582vdeXo1fl2lVfvJPdUyOicettonyi6gyCd4DvBN3ZHiKc5cBv8c3kMZJoquvBucbIAocpWs
 B4jeGk+Sy0W89T04ZxqnFbzSxqS82k+t60jSdU0xPHz/E4d4GCQp3H+SFga4iZtG5ctZeZKr66H
 cxgjNo159SfotBm5jR50zIqcAXWho4LStunpweP4qzf41Q6xRLOoOqE2dCxZjfLz4eGIRIgi9vz
 E+zqKEaeib2zgBq/077GU2jj+++xBCDUECsaAKlovG7jA9RB2AcbMJ+n29MvbFA2XtJVe0KhVbv
 f8ac+5ATiDWOmVs8TcGps467/mEc4/+N7R6PqkaSlyN3pSsIQ/Ls7tY+MxvAFgVKKcrZsfnUzL7
 Px6HGyEx+YY5t085uJ8dykHpDdt+SVZVeuHyjobWKZcBeAjt1hYK6pZYQT6HQFy6srKRmu6pi5t
 8MSBXmyqZzW4aXqhipg==
X-Authority-Analysis: v=2.4 cv=Cfw4Irrl c=1 sm=1 tr=0 ts=69d8d6dd cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=fr7GdGX52fyC5VJlwL4A:9
X-Proofpoint-GUID: 3EcIb9v_m4-CPn4L3AZ0vLDlbgPgVFVc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-10_03,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 clxscore=1011 adultscore=0 suspectscore=0
 priorityscore=1501 impostorscore=0 bulkscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604100100

test_access_variable_array relied on accessing struct sched_domain::span
to validate variable-length array handling via BTF. Recent scheduler
refactoring removed or hid this field, causing the test
to fail to build.

Given that this test depends on internal scheduler structures that are
subject to refactoring, and equivalent variable-length array coverage
already exists via bpf_testmod-based tests, remove
test_access_variable_array entirely.

Link: https://lore.kernel.org/all/177434340048.1647592.8586759362906719839.tip-bot2@tip-bot2/

Signed-off-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
---
 .../bpf/prog_tests/access_variable_array.c    | 16 ----------------
 .../bpf/progs/test_access_variable_array.c    | 19 -------------------
 2 files changed, 35 deletions(-)
 delete mode 100644 tools/testing/selftests/bpf/prog_tests/access_variable_array.c
 delete mode 100644 tools/testing/selftests/bpf/progs/test_access_variable_array.c

diff --git a/tools/testing/selftests/bpf/prog_tests/access_variable_array.c b/tools/testing/selftests/bpf/prog_tests/access_variable_array.c
deleted file mode 100644
index 08131782437c..000000000000
--- a/tools/testing/selftests/bpf/prog_tests/access_variable_array.c
+++ /dev/null
@@ -1,16 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/* Copyright (c) 2022 Bytedance */
-
-#include <test_progs.h>
-#include "test_access_variable_array.skel.h"
-
-void test_access_variable_array(void)
-{
-	struct test_access_variable_array *skel;
-
-	skel = test_access_variable_array__open_and_load();
-	if (!ASSERT_OK_PTR(skel, "test_access_variable_array__open_and_load"))
-		return;
-
-	test_access_variable_array__destroy(skel);
-}
diff --git a/tools/testing/selftests/bpf/progs/test_access_variable_array.c b/tools/testing/selftests/bpf/progs/test_access_variable_array.c
deleted file mode 100644
index 326b7d1f496a..000000000000
--- a/tools/testing/selftests/bpf/progs/test_access_variable_array.c
+++ /dev/null
@@ -1,19 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/* Copyright (c) 2023 Bytedance */
-
-#include "vmlinux.h"
-#include <bpf/bpf_helpers.h>
-#include <bpf/bpf_tracing.h>
-
-unsigned long span = 0;
-
-SEC("fentry/sched_balance_rq")
-int BPF_PROG(fentry_fentry, int this_cpu, struct rq *this_rq,
-		struct sched_domain *sd)
-{
-	span = sd->span[0];
-
-	return 0;
-}
-
-char _license[] SEC("license") = "GPL";
-- 
2.45.2

