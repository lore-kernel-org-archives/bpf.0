Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE8ED191
	for <bpf@vger.kernel.org>; Mon, 23 Feb 2026 15:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771860921; cv=none; b=n83tNFzO6CJLN9XOilnp3xXMXBJrS8e6pAEXUMXQwqcit/cW2YiAAopYf3y0izuXJfLU5CwI2T6KwgIk+j5LLHzxHEErhWmMMMBcAhUP1Ioz51gfxqHMFJcr8KnI+MMzY907IAp0HEAP3xEMZXPhMLnjT9kLcnAWzseNtitYJDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771860921; c=relaxed/simple;
	bh=hkyDsXFmzzBihCCJDjzPZrwScmo//I5swDOyDnylp90=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PYR944ZRCmssJqIxQb3lUpB29Z0EGwBfXLFiSn22P52twPXPm3ZuZ9/9qj4MjOOqDVYdsPmKvk1mli7TmF+To+42YVrgoVYaDBob/BqqY+qiCvgd99iWvmHhxv4PQf52ToO9UXRGOugTmzYUoonqmN1nAzR6ZHlG1YbY5bpzvHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=QCBu7A1y; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="QCBu7A1y"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61N3V6Gv3294422;
	Mon, 23 Feb 2026 15:35:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=NhmzsnRNt6/PzuwBHqJYLSgu3RZvza2Xeke+GC67E
	8o=; b=QCBu7A1yLssREO8xwMw1XSmm7WXEP2YsUFs4pfBtYvqQ6iNEe+84UntOe
	hO/cg2Uq2tVzeZKnxQoXtLJcGHghsm4TEZrAi2JUrIkSd9musqew8ZtmTkawTO7I
	coQ528yPyQIbLEEHmPOCSiLhrUMKGkwapxZQ8IeLBQKYdN9LQbHmSMJp25YS9zG1
	xZxy1XrxDGZQ5Wc2AQQ+z0AbXHZAcE77L4yE7N5kRPGkkCnAPDJqdrevlC8i86wd
	Zx5jg0zH2qVx8eUzjF1sgcDgrFzgLtR49dMOwegySmLzzsmHQHIbZRgMa0eHsUM3
	M/0DRoMPISu9tFNmX2swtqFltY/rg==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cf4brq84p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Feb 2026 15:35:05 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61NErelf015959;
	Mon, 23 Feb 2026 15:35:04 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cfq1sdcsp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Feb 2026 15:35:04 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 61NFZ2Mb52232568
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 23 Feb 2026 15:35:02 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A59E920040;
	Mon, 23 Feb 2026 15:35:02 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BCB4E20049;
	Mon, 23 Feb 2026 15:35:00 +0000 (GMT)
Received: from ltcrain4-lp15.ltc.tadn.ibm.com (unknown [9.5.7.39])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 23 Feb 2026 15:35:00 +0000 (GMT)
From: adubey@linux.ibm.com
To: bpf@vger.kernel.org
Cc: puranjay@kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, martin.lau@kernel.org, eddyz87@gmail.com,
        memxor@gmail.com, mykyta.yatsenko5@gmail.com,
        Abhishek Dubey <adubey@linux.ibm.com>
Subject: [PATCH] selftest/bpf: enable test for instruction array on arm64
Date: Mon, 23 Feb 2026 15:35:11 -0500
Message-ID: <20260223203511.118475-1-adubey@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: u1b8bRWjkMzCnm0hE-pfxN5pMoJlIE59
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIzMDEzMCBTYWx0ZWRfXxyInQn7wBxmy
 GSryumN1Mm9Nf/aRRntCqmzF4L4Ts8RRhDQjEzUvAI3FhPKIrw4fEQ5n2PBKkGyH5+kziM7zHJh
 AhRirDpENOiHKGPRDKWsNEuIdJ+R2WgfMQFuC3G2W39r4RedGKNFyykigkdp3HCB800rc8z3JUS
 MXzH0h19t8L8M6wih018k3heI+BRbdT8sIiimCJlb0T/sK3BHo6OKBa2a/btqDhmV4StsmY4wwP
 9jFEimWdohFLdMiE41rsk4LGYgaqF0U4wBhTH6+A6JQKx4WF48Rpu1obn3WPQOzPzTZilWQpfRi
 WPKuAKMhgSu/VoMMz2ltencKTuztvmHLgB4KEAAccOSHmVuA994cuz+YrKW7BEJRDtLNLlYVFDt
 K9AHujuoz+38aW4uk4reFsOlEqkGVYjlHeipS64/xTNVW9FOWaPiA09+n0awwJsyPIl70MgcprP
 RnXVIS3yQLjvMQ/j5mQ==
X-Authority-Analysis: v=2.4 cv=eNceTXp1 c=1 sm=1 tr=0 ts=699c73a9 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=VnNF1IyMAAAA:8 a=NlIJwHu8qxd8-q_6SGIA:9
X-Proofpoint-GUID: o5jjGCebWeTqf68IFnZPC5tehMJ9uc64
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-23_03,2026-02-23_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 priorityscore=1501 phishscore=0 suspectscore=0 adultscore=0
 bulkscore=0 lowpriorityscore=0 malwarescore=0 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602230130

From: Abhishek Dubey <adubey@linux.ibm.com>

As arm64 JIT now supports instruction array, make sure
all relevant tests run on this architecture.

#21/1    bpf_insn_array/one2one:OK
#21/2    bpf_insn_array/simple:OK
#21/3    bpf_insn_array/deletions:OK
#21/4    bpf_insn_array/deletions-with-functions:OK
#21/5    bpf_insn_array/blindness:OK
#21/6    bpf_insn_array/incorrect-index:OK
#21/7    bpf_insn_array/load-unfrozen-map:OK
#21/8    bpf_insn_array/no-map-reuse:OK
#21/9    bpf_insn_array/bpf-side-ops:OK
#21      bpf_insn_array:OK
Summary: 1/9 PASSED, 0 SKIPPED, 0 FAILED

Signed-off-by: Abhishek Dubey <adubey@linux.ibm.com>
---
 tools/testing/selftests/bpf/prog_tests/bpf_insn_array.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_insn_array.c b/tools/testing/selftests/bpf/prog_tests/bpf_insn_array.c
index 269870bec941..93166c2da8e7 100644
--- a/tools/testing/selftests/bpf/prog_tests/bpf_insn_array.c
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_insn_array.c
@@ -3,7 +3,7 @@
 #include <bpf/bpf.h>
 #include <test_progs.h>
 
-#ifdef __x86_64__
+#if defined(__x86_64__) || defined(__aarch64__)
 static int map_create(__u32 map_type, __u32 max_entries)
 {
 	const char *map_name = "insn_array";
-- 
2.52.0

