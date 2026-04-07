Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C44D4359A75;
	Tue,  7 Apr 2026 16:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775578343; cv=none; b=P2ctk5e3zfHgMWsc6FfvV4UxCKSZkLGbuXsWhhWhpDfZSh3QPBW+YtSjMof4saE+JpuUrrtevIqppyTx2cuP6iwvZS4uHqPrx8Or0k5+tLSCUW5bRC8WI0IngxSJVZGnejmRjqQTIZAs//JtdTwHx2URGMCfBB/cfiFg+RdUngo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775578343; c=relaxed/simple;
	bh=9N9lZTgfkgxpqE82kLFAmmZSUfZOJL5vmp78/8PKvD4=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=XtCV8JICfQ6GnwKNJo1AYE/iiQvPiMbSZE/RQGXRytdbGImqot2Jbd7qmfO51umnRPZeEV2xy2gIYoUIAug8y4yeKH9jD/ODDSKeZUJ+Usj+znYjB0SRzuMhb+0y4N0Te9duYG046EulrPFpJj2AYMT5fhGSeap8yIyv41PywjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=hSYYR3MT; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="hSYYR3MT"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 637EA1ll2299517;
	Tue, 7 Apr 2026 16:12:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=28WxbXt8Utr4J1010EfRRuWCBT3L
	nCUGjH2pgT7t6Oc=; b=hSYYR3MTT1nF7r8AuIvA1PnPZCe2bZL6egKDxn87ixIo
	JSWK/2Pq9C5xZ++Y3zxTkChfYxJOwteQXnw8SguWWECMoBfLFj2UTvrIJv3ouztx
	4jsPEznfbbe/tTWi117L9lb4deUNH9Z/TT2tb0k8n8QrwUlgxM6Qy6RBPi+FNd1G
	pLULJ4cOOr3N/iXzBvOTShpU7bhdXYJnQkE/mgH4cEfbjUKjMW8uUfWawUPzZXSo
	elgTJWgGkvpnFnnlX8g1hcFi+PhJOiya15fuANgggvpwJ7BXa52H2bKVfl5egDp3
	2QVcT4OfKI6lpMvmW+KtuPVKgncSdGRQUhrEfhz6Cg==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dcn2fune9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Apr 2026 16:12:09 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 637Eelx5030068;
	Tue, 7 Apr 2026 16:12:09 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dcme7bwmn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Apr 2026 16:12:09 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 637GC74Y29426338
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 7 Apr 2026 16:12:07 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7DB3558059;
	Tue,  7 Apr 2026 16:12:07 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1FEF758043;
	Tue,  7 Apr 2026 16:12:04 +0000 (GMT)
Received: from [9.61.247.154] (unknown [9.61.247.154])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  7 Apr 2026 16:12:03 +0000 (GMT)
Message-ID: <3e129be5-d61e-4bc4-b691-8d69e2f58de6@linux.ibm.com>
Date: Tue, 7 Apr 2026 21:42:02 +0530
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-GB
To: bpf <bpf@vger.kernel.org>, Saket Kumar Bhaskar <skb99@linux.ibm.com>,
        Hari Bathini <hbathini@linux.ibm.com>,
        Abhishek Dubey
 <adubey@linux.ibm.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Ritesh Harjani <riteshh@linux.ibm.com>
From: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Subject: bpf/selftests: test_access_variable_array breaks due to
 sched_domain::span removal
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=KeridwYD c=1 sm=1 tr=0 ts=69d52cd9 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=fj4YXy0ajhRxkL7hFC8A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: h9FMt6i7L0mbiTIe5VxYFuW7Mu2y6sR9
X-Proofpoint-GUID: h9FMt6i7L0mbiTIe5VxYFuW7Mu2y6sR9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA3MDE0MyBTYWx0ZWRfX4SKYF7ESbziS
 SbZDAUQiS+imnhrxGMAjiFTw2SgtIBGhTVdMXomF0vxENIez97miI59TCBLh1fXiqJzXWz6luBf
 qVptN3pYPeRYxND5zRC6mojLqTRXlzlmXeiqbNQSV2CZAxxbA5FeTB4QugyaE5rmtV+8DawOa1p
 7iAWtnFKyGQFjybQRQ6vx+pEuctDoigJyYlLQx7NUfI/GSxwQj6fAU8wYhSoUPyC/8om8n92GXc
 dKC2JGWspmJ4abELSQfbc5Ewa0HIejnN+ZKkT44AJr3hI4S534+h/ZU8Z0iFbjaPZXQ4wFQJ+/J
 R+bYmP5In1Uft5rxHGxuTmzun3mDb945m+mQOP9EnyzmUTsg0AD/373PDtOu75YIkobAI9q2MP1
 mFqcyNGVVi4H8VOPYnI5rRtw+Jw6k/wddmW6rgJIx+F3tl7K3Evu9Xyx8xI9d2Zk/VHqzPfseFZ
 EfT2QcNZVwlLEDJlPRw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-07_03,2026-04-07_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0 impostorscore=0
 clxscore=1015 phishscore=0 priorityscore=1501 spamscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604070143

Hi,


While running BPF selftests on current linux-next, I noticed that
test_access_variable_array fails to build due to reliance on
struct sched_domain::span, which is no longer appers to be BTF-visible 
after recent
scheduler refactoring.

The Build error I am seeing is:

progs/test_access_variable_array.c:14:13: error: no member named 'span' 
in 'struct sched_domain'  CLNG-BPF [test_progs] test_check_mtu.bpf.o

    14 |         span = sd->span[0];
       |                ~~  ^

Below is a proposed update to the test that switches from
sched_domain::span to sched_group::cpumask. This preserves the original
intent of validating variable-length array access via BTF while avoiding
reliance on removed scheduler internals.


diff --git 
a/tools/testing/selftests/bpf/progs/test_access_variable_array.c 
b/tools/testing/selftests/bpf/progs/test_access_variable_array.c
index 326b7d1f496a..c9f345ccde3c 100644
--- a/tools/testing/selftests/bpf/progs/test_access_variable_array.c
+++ b/tools/testing/selftests/bpf/progs/test_access_variable_array.c
@@ -4,14 +4,18 @@
  #include "vmlinux.h"
  #include <bpf/bpf_helpers.h>
  #include <bpf/bpf_tracing.h>
+#include <bpf/bpf_core_read.h>

-unsigned long span = 0;
+unsigned long cpumask0 = 0;

-SEC("fentry/sched_balance_rq")
-int BPF_PROG(fentry_fentry, int this_cpu, struct rq *this_rq,
-               struct sched_domain *sd)
+SEC("fentry/sched_balance_find_dst_group_cpu")
+int BPF_PROG(fentry_fentry, struct sched_group *sg, struct task_struct *p,
+               int this_cpu)
  {
-       span = sd->span[0];
+       unsigned long *mask;
+       /* Read pointer to variable-length CPU mask */
+       mask = BPF_CORE_READ(sg, cpumask);
+       cpumask0 = mask[0];

         return 0;
  }


I have tested this change, and it seems to be working as expected.


# ./test_progs -t access_variable_array
#1       access_variable_array:OK
Summary: 1/0 PASSED, 0 SKIPPED, 0 FAILED


Please note that this comes from my early days of working on upstream
kernel contributions, and I am still learning the BPF and scheduler
internals. My understanding here may be incomplete, so I wanted to
share this primarily to report the breakage I am seeing and propose a
possible direction for fixing the test.

I would appreciate any feedback on whether this is the right approach,
or if there is a more appropriate structure or hook to use for
preserving the variable-length array coverage in this selftest.


Regards,

Venkat.



