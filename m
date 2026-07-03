Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6D243D5C15
	for <bpf@vger.kernel.org>; Fri,  3 Jul 2026 12:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783083441; cv=none; b=FEuT6ybDEbReRFDDnAMlAffvbj4eansRjBy8LTx6jg5s8tyENnK0AB/YTnhDu/hiXJAX73dE9nsEuPOzKtBHilGkJHkg6szyAxP0zxlw+2ekWqbcaS/M5O+alTrOkYdZuA6pImWllr6NnsIS/HE4D7c728pG+kDLt7lz5Az9HJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783083441; c=relaxed/simple;
	bh=8UxlWSQK3fTYAT4Fz03Zn6tbSUJHT66QJcf5oQBeAoE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MeK91nMNH1atFdVzz2fBeUz6rVboDKOihEj0kLIc19Zhsje+UvY9G/LfssqdBdC/k43zNgPFEXqERzWjrbye/drJ7nCh/BjQ7Lo5+xFZPpZAWpNIAFzP7xnjKQcQ5f7AI++QWPFsas7molAKPMzx6XOMg2tckCw6jA1taMnMcBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=IdgVQTnx; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="IdgVQTnx"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6636IQCc1812994;
	Fri, 3 Jul 2026 12:57:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=a+UvNl9r22JcexuGd
	op6i8kw3V+4YeUIYDWXuG+0PTA=; b=IdgVQTnxhQA2UhemGO0NxzdpXUU4Xxaic
	pqDEt4RkWE5QRNmTuERAxx1c9zlfYc4Y6aqmaDBKUF2AlMt22LrczJq61uysFv9Z
	qvo5zPL54pTdkhLxiz3DK2VgLca/InnMbwpOH93WSOv4zvA3b2auqO0/gQOGdSgP
	pbZJmnJTALpF9g3X0le5oQWqjWFrXLnYBokFA+jBZJZQK34hTFA12WIMdPBybmrN
	GTXS9XdzvRfrYAWRqYYKOp2I9T3QwbzEpUlbDoavl10kSVtOk5g4G2jYVdOJHlQY
	G7mGDQRBfVfLQ4xprl02JcQgHA2tA2zCyNlyClGuaMRWpsnQx7NAg==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26qaewkf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 03 Jul 2026 12:57:06 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 663CncKm011900;
	Fri, 3 Jul 2026 12:57:05 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f2tbhru9f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 03 Jul 2026 12:57:05 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 663CuV8320382240
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 3 Jul 2026 12:56:31 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8FAE758043;
	Fri,  3 Jul 2026 12:57:04 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7508558059;
	Fri,  3 Jul 2026 12:57:02 +0000 (GMT)
Received: from thinkpad-p1.ibmuc.com (unknown [9.111.50.198])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  3 Jul 2026 12:57:02 +0000 (GMT)
From: Maxim Khmelevskii <max@linux.ibm.com>
To: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc: bpf@vger.kernel.org, Ilya Leoshkevich <iii@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Subject: [PATCH bpf-next 2/2] selftests/bpf: Add test for bpf_get_smp_processor_id
Date: Fri,  3 Jul 2026 14:51:36 +0200
Message-ID: <20260703125648.919196-6-max@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260703125648.919196-4-max@linux.ibm.com>
References: <20260703125648.919196-4-max@linux.ibm.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDEyNiBTYWx0ZWRfX8GnivEuOoj2j
 0cele7rRVtjd04kz6JDsFMdQWTwcaGQV+fVzSRO06jpwZGj2JaBO7g/GJDGWAV/BSi4mm/7JFpG
 IDa3s0mtgheOSj1aRPCFdIYI1WzJEuaanGHQS3bqgyl0ZeKAqztO/wNPkE0ydihOaa2TZEHW+3T
 X7dTmLLTjXT8HvcKg3mEYMiYMdxcOKk9aUT5n9vEitnG/56UsWnR3E6383im86W8dam1LPxQ4mo
 9CqbMlvOyE4ai/kd2+HvY7yvKfnR7uPqpCA4NpU3ShRXGDzIxuj+OXSmlheg1AgYTRQX7kBTGxQ
 tuhc3xo7bxadTkQy9y+Kv4xP4EA7APC0LAgjtHOH+XcI/ARxty22RW5LGFkGIcBNFo2M0JkHEjn
 upRdgxqmVoX0dbEAiuD0zsJQwshUW1L9N2Hk7U/W10RdKzIsvmLmNWtV1bHnxXn0MCCVQJ90DcU
 1B7CXsLVZEzpElqXN0A==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDEyNiBTYWx0ZWRfXxXN+wTXstuoX
 nLOKQFMXx/i5UqXhUQJYOlrcSm3s64HjkczbvsTnSCSrQS+5Iz44pkKLVctk5Dqn4leuvipN28N
 RC+8j8oW+gaqwi+81rX2yrVaBtPUn9k=
X-Proofpoint-GUID: 9GURUdbV511eEeGPn7V7kRnAc5eSj6eT
X-Proofpoint-ORIG-GUID: 9GURUdbV511eEeGPn7V7kRnAc5eSj6eT
X-Authority-Analysis: v=2.4 cv=WZ88rUhX c=1 sm=1 tr=0 ts=6a47b1a2 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=op7KPUZqbHCrF8WiKDoA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 phishscore=0 clxscore=1015 bulkscore=0
 impostorscore=0 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607030126

Add a test which checks on each CPU that the
bpf_get_smp_processor_id BPF helper is returning
the correct CPU number.

Signed-off-by: Maxim Khmelevskii <max@linux.ibm.com>
Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 .../bpf/prog_tests/get_smp_processor_id.c     | 45 +++++++++++++++++++
 .../bpf/progs/get_smp_processor_id.c          | 20 +++++++++
 2 files changed, 65 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/get_smp_processor_id.c
 create mode 100644 tools/testing/selftests/bpf/progs/get_smp_processor_id.c

diff --git a/tools/testing/selftests/bpf/prog_tests/get_smp_processor_id.c b/tools/testing/selftests/bpf/prog_tests/get_smp_processor_id.c
new file mode 100644
index 000000000000..1b5c738ab81f
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/get_smp_processor_id.c
@@ -0,0 +1,45 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <test_progs.h>
+#include "bpf/libbpf_internal.h"
+#include "get_smp_processor_id.skel.h"
+
+void test_get_smp_processor_id(void)
+{
+	LIBBPF_OPTS(bpf_test_run_opts, opts,
+		    .flags = BPF_F_TEST_RUN_ON_CPU,
+		    .cpu = 0,
+	);
+	struct get_smp_processor_id *skel;
+	int prog_fd, err, online_cpu_nr, i;
+	bool *online = NULL;
+
+	err = parse_cpu_mask_file("/sys/devices/system/cpu/online",
+				  &online, &online_cpu_nr);
+	if (!ASSERT_OK(err, "parse_cpu_mask_file"))
+		return;
+
+	skel = get_smp_processor_id__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "get_smp_processor_id__open_and_load"))
+		goto cleanup;
+
+	prog_fd = bpf_program__fd(skel->progs.call_bpf_get_smp_processor_id);
+
+	for (i = 0; i < online_cpu_nr; i++) {
+		if (!online[i])
+			continue;
+
+		opts.cpu = i;
+		skel->bss->cpu_nr_result = -1;
+
+		err = bpf_prog_test_run_opts(prog_fd, &opts);
+		if (!ASSERT_OK(err, "bpf_prog_test_run_opts"))
+			goto cleanup;
+
+		ASSERT_EQ(skel->bss->cpu_nr_result, opts.cpu, "cpu_nr_result");
+	}
+
+cleanup:
+	free(online);
+	get_smp_processor_id__destroy(skel);
+}
diff --git a/tools/testing/selftests/bpf/progs/get_smp_processor_id.c b/tools/testing/selftests/bpf/progs/get_smp_processor_id.c
new file mode 100644
index 000000000000..cf4791a5cf07
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/get_smp_processor_id.c
@@ -0,0 +1,20 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
+
+__u64 cpu_nr_result;
+
+SEC("raw_tp")
+void call_bpf_get_smp_processor_id(void)
+{
+	register __u64 r0 asm("r0") = -1;
+	asm volatile ("call %[bpf_get_smp_processor_id];"
+		      : "+r"(r0)
+		      : __imm(bpf_get_smp_processor_id)
+		      : "r1", "r2", "r3", "r4", "r5", "memory");
+	cpu_nr_result = r0;
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.54.0

