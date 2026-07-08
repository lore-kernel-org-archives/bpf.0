Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 485BF39936D
	for <bpf@vger.kernel.org>; Wed,  8 Jul 2026 10:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783507714; cv=none; b=UuzCdZZEEBQjX0tLO7yRCL4G9H0/kIhHZ8LLs89Fp+QMVumRlS3Tk7LhfG+25jnf/igO2fySztJZPmT4b2kX9azLeEI3WiXuL4EBq8XjFocRSe0IPH4YTANE66/GBXAg/r/fwJWnn5jlWA0bW3T4ISnWnyO3gRzMEnzf44LyEhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783507714; c=relaxed/simple;
	bh=rw0/Y6ij4sjyskzmtiQPROM/LE/dAncSm8DhJ7C2vP4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=L0I2LJ2DgbJgpn0DmjsOgeRZH5Sasy6Zj1GZrAwu39+MR4CmmZUnwHh3TP+gvr7atWwCiHlPyNnknsgkO6y1ajJJA5v12S4SeOxBnOmKAmM6hP5lZgMuCWeYN2+y12Q9Hhu5kFG8MA9NrTCW73ad0It+C8xwam4tmeHKIK/k/ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=NP6+naLb; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="NP6+naLb"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6688IDqE2501470;
	Wed, 8 Jul 2026 10:48:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=Hz3xHW/t0zumNsKzYq3sSzmJAkawbtt2fcHGgooJn
	bA=; b=NP6+naLbRSJg1WB2mQSkkJIMJhOTiSY8DcGCIVk7PA4WRfHEMXJonUoxR
	VMy7pR/GiEhZDQf6pBrsNhxbT6qFUdXBZxuCF58LDY6/rJiFQkyuXf/WCk+1P7Tl
	q/cXsSnW99toQo5IcGd1x7oMNx+56Jqmex6f49Cdjl+FfpD42BLm6C6mBBON/2Ul
	jo1H3105hHxwSft5SvTmRDanAYcuXSmxHZyPeAM/SNl9sD8RRsh11a1tUTLFVDHp
	I7V2jfWB3IBIVi+S+3adYlBLBGnuDr83GwJ4+Y0G6e0oMfFVhyPNtspmveaT0yf0
	+Ij9AVbpvU+lOh/tPF0MwHuz+LwCg==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6sw4uyse-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Jul 2026 10:48:09 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 668AYff2028439;
	Wed, 8 Jul 2026 10:48:08 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f7cvw7sxu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Jul 2026 10:48:08 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 668Am7QF19661370
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 8 Jul 2026 10:48:07 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0D6635805C;
	Wed,  8 Jul 2026 10:48:07 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DC6BB5805A;
	Wed,  8 Jul 2026 10:48:04 +0000 (GMT)
Received: from thinkpad-p1.ibmuc.com (unknown [9.111.42.233])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  8 Jul 2026 10:48:04 +0000 (GMT)
From: Maxim Khmelevskii <max@linux.ibm.com>
To: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc: bpf@vger.kernel.org, Ilya Leoshkevich <iii@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Subject: [PATCH bpf-next] selftests/bpf: Skip res_spin_lock_stress if no perf support
Date: Wed,  8 Jul 2026 12:47:17 +0200
Message-ID: <20260708104729.1248234-2-max@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Kg50f6LhcUKWHmciq3YRYb2-bEZ5B0ZX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA4MDEwNSBTYWx0ZWRfX+bzUGS9kYzLY
 SnPdFmb0/Q2IYfwIJOOh974XKaa2/sB2D6uodRG0bqDePNkXQg3gUiRm2M/V9+0adZkmrqAi4Zy
 BTiGoH29E6E27yzKEsyLJHOajo8njD6fgtg2WALYLCnCom5jfzT33N3okTTn0YZ76r4aD99XjfE
 SQAtjlNEhcw2rqaFirDYFKvLZj1QVB8GpZzT9A35mMZS+n5jTHNdvJnNTlenb4xvfyKAjEwYLEA
 lCwDhPTEGSBkEmFyN2dtKSSL4TlXigHyeDZR6BG6FHFpMPXcwpdsAgXplOEDzHN94sKM7KHDOyc
 D6lTo9TZPBMhpCN04mvbVbaMyYC3jfl5JsVTpfqkcexzEXfc8ZZwdYwDXgBSlkeEtjRMKwW+Yw4
 Ps4MhjOS5oIkg3b8qBtOEz/A6eYgq89F7GStEtZJqX5E9X1dV4Y+t1xw2tKbg5nTzJXzJ0Aku0J
 bxb6TuiaFyzja28R/KQ==
X-Proofpoint-ORIG-GUID: Kg50f6LhcUKWHmciq3YRYb2-bEZ5B0ZX
X-Authority-Analysis: v=2.4 cv=FqQ1OWrq c=1 sm=1 tr=0 ts=6a4e2ae9 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=JGzehNbvbNBXqxIBsbgA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA4MDEwNSBTYWx0ZWRfX7sgTDWSO62F6
 WV+uYKFpHUrjEyhjy7xfdzRd3CppfME7VlbNn1yRRpFAePzIsN2ZgJTDvPxTVgNy+BPgnPqh7gu
 Zeq1x3Ea5pIANgOqhI4ZKNKfXTI+1KM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-08_01,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 clxscore=1015 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 suspectscore=0 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607080105

Probe PMU support before loading bpf_test_rqspinlock.ko,
otherwise the test fails with not obvious error without
proper perf event support:

    Failed to load bpf_test_rqspinlock.ko into the kernel: -2
    serial_test_res_spin_lock_stress:FAIL:load module AA
        unexpected error: -22 (errno 2)

Reported-by: Ilya Leoshkevich <iii@linux.ibm.com>
Signed-off-by: Maxim Khmelevskii <max@linux.ibm.com>
Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 .../selftests/bpf/prog_tests/res_spin_lock.c  | 20 +++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/res_spin_lock.c b/tools/testing/selftests/bpf/prog_tests/res_spin_lock.c
index f0a8c828f8f1..7541f4966abc 100644
--- a/tools/testing/selftests/bpf/prog_tests/res_spin_lock.c
+++ b/tools/testing/selftests/bpf/prog_tests/res_spin_lock.c
@@ -3,6 +3,8 @@
 #include <test_progs.h>
 #include <network_helpers.h>
 #include <sys/sysinfo.h>
+#include <sys/syscall.h>
+#include <linux/perf_event.h>
 
 #include "res_spin_lock.skel.h"
 #include "res_spin_lock_fail.skel.h"
@@ -102,11 +104,29 @@ void test_res_spin_lock_success(void)
 
 void serial_test_res_spin_lock_stress(void)
 {
+	struct perf_event_attr attr = {
+		.size = sizeof(attr),
+		.type = PERF_TYPE_HARDWARE,
+		.config = PERF_COUNT_HW_CPU_CYCLES,
+	};
+	int pmu_fd;
+
 	if (libbpf_num_possible_cpus() < 3) {
 		test__skip();
 		return;
 	}
 
+	pmu_fd = syscall(__NR_perf_event_open, &attr, 0, -1, -1, 0);
+	if (pmu_fd < 0) {
+		if (errno == ENOENT || errno == EOPNOTSUPP) {
+			test__skip();
+			return;
+		}
+		ASSERT_OK(-errno, "perf_event_open pmu probe");
+		return;
+	}
+	close(pmu_fd);
+
 	ASSERT_OK(load_module("bpf_test_rqspinlock.ko", false), "load module AA");
 	sleep(5);
 	unload_module("bpf_test_rqspinlock", false);
-- 
2.54.0

