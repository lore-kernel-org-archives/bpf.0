Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25FBA27380A
	for <bpf@vger.kernel.org>; Tue, 14 Apr 2026 14:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776176990; cv=none; b=I+K1yFWAV557DHmKN1cRjwwqGR43RgMrYBApT/E1Iv4BOSl1t1tJMtTXPID6zizUDB/w4Q5x3Sfx1yzr8xMBlQbISmzs+5gjrevt/YpWhq4z6Zk5LWUg+oWrz/3vAdvZmPjR3W7wam7VQYIoCznPdjgE8X4OS2n5QArywYG6KyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776176990; c=relaxed/simple;
	bh=6z5ZXTYPoAXpbPM6XzJpPVsG2nyNI96mXM+LnGFnXZo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Ju3RKaGhLxPF2Uw/yihKLw2kEZrUNUApSHt0g3p+TVd9d5dEB3ftMr4c5GC8f3+WR/8HOWaoJeEGLuc6ZkiEMg6H/Y0+AM69B/T5AxLHHLLNCWTw2fU+kAv4zDd12qvwZcQspObUcuCKGM3tsOUQeJBj6haa8NV0SIyZFcR/FXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=SxtIUDNV; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="SxtIUDNV"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63EDdDLw1843301;
	Tue, 14 Apr 2026 14:29:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=YjAnSX5zyRx35H14kLZgKz9J3KMf
	UuvZPe4gzyVoh88=; b=SxtIUDNVYCdsePtpf4FbbQlG1JNkI1P1RLQlHerJ3E+M
	syxRsgXwi5nDjHtpNK7TvZfUpTMq6hT6hA3b1py6pnYxIVhIfb1q9oGeJFTn/Hjx
	7wa2ZiE/l3n+WMA9d+p29kbUyEaVKl3DR7p6YsjuGOZEcX8unyMsWfrDSlCL0l0M
	mqjpiKCt2rG0RubH0NAHnlj2ZnveNvEWcHBzk4igmbvx8RCjN6EYHSPRmr/jAK8C
	kHmjBYRKIzlr17lL2ehnFr+HjEKnfwIaMn838WVbz51nISFtonu/bXb9HA+upK6x
	8cw9AjZEcmsXGTHDe7ZI6ygAPkPWQt0/pKDEQiUqZg==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dh89mk5qx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 Apr 2026 14:29:35 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 63ED82v0031191;
	Tue, 14 Apr 2026 14:29:34 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dg10y9xqt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 Apr 2026 14:29:34 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63EETX1e30540388
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 14 Apr 2026 14:29:33 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9B3F958051;
	Tue, 14 Apr 2026 14:29:33 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id ABA345805C;
	Tue, 14 Apr 2026 14:29:31 +0000 (GMT)
Received: from thinkpad-p1.aag-de.ibm.com (unknown [9.52.219.66])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 14 Apr 2026 14:29:31 +0000 (GMT)
From: Maxim Khmelevskii <max@linux.ibm.com>
To: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc: bpf@vger.kernel.org, Ilya Leoshkevich <iii@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Subject: [PATCH bpf-next] s390/bpf: inline smp_processor_id and current_task
Date: Tue, 14 Apr 2026 16:29:26 +0200
Message-ID: <20260414142930.528751-1-max@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE0MDEzNCBTYWx0ZWRfX0IN6RLOTCZ8y
 2sBaWW50O+mbko41o95tba84mR1bcDQCHmGXm8M4tLNshiswRdKLw7s31lzQ5V5qjzrpkfOQWuR
 QhwZyJnAs2S5GpdyNec3LmXEJ/whWy8WYuYD/wyTfSrTmScqP9sCpUVXjZXNF6l1s4KC7pPabFA
 N9FDC5yZLyRy+l6+PPiLdj3rBPmSbcIZfTpkekPBUev49kF1FJStjMxBMb6RCSVHASs8Pyinyjz
 mQI6qa9/fu9FY/OnDt0SPun/VsJxhgcp4PZYxmlAL5JYBpNh/+opzWae4/IKZQnfD8oWdLHUM46
 NBCg0bc12FaOAlEqIq78WDjpKIgCZhwZ1zNnOwNzRPfRybid/ONL+lVfuV5O5OexKgmEk4MYOzX
 w08InAvhvKBRrMaS0JIcQRL39Nx2JOKd8wwT35qe4CDcL4QCWuNmgDxGkRj7m1dIMOMqE21nDdl
 WvRXqeUwh0dbh+8FOIQ==
X-Authority-Analysis: v=2.4 cv=eJ4jSnp1 c=1 sm=1 tr=0 ts=69de4f50 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=NEAV23lmAAAA:8
 a=VnNF1IyMAAAA:8 a=xk9cym82weemkfCegS0A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: Mnc2js8KdH3KEWTsikY5JMl_lK_7U-mV
X-Proofpoint-ORIG-GUID: Mnc2js8KdH3KEWTsikY5JMl_lK_7U-mV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-14_03,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 adultscore=0 priorityscore=1501
 clxscore=1011 bulkscore=0 suspectscore=0 spamscore=0 impostorscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604070000
 definitions=main-2604140134

Inline these calls in bpf jit:
 - bpf_get_smp_processor_id()
 - bpf_get_current_task()
 - bpf_get_current_task_btf()

s390 has a 8 KiB per-CPU prefix area in the CPU's
virtual address space, called the lowcore. It is a
struct that contains the cpu number and a pointer
to the current task. These are exactly the values
returned by the BPF helpers.

Emit a load from the lowcore instead of a helper
function call.

JIT output for `bpf_get_smp_processor_id`:

 Before:                       After:
---------------               ----------------
brasl   %r14,0x3ffe0385460    ly      %r14,928
lgr     %r14,%r2

JIT output for `bpf_get_current_task`:

 Before:                        After:
---------------                ----------------
brasl   %r14,0x3ffe0362a90     lg      %r14,832
lgr     %r14,%r2

Benchmark using [1] on KVM(virtme-ng).

./benchs/run_bench_trigger.sh glob-arr-inc arr-inc hash-inc

+---------------+--------------------+--------------------+--------------+
|     Name      |       Before       |       After        |   % change   |
|---------------+--------------------+--------------------+--------------|
| glob-arr-inc  | 244.954 ± 0.654M/s | 278.501 ± 0.834M/s |   + 13.70%   |
| arr-inc       | 311.597 ± 1.016M/s | 313.610 ± 0.331M/s |   + 0.65%    |
| hash-inc      | 47.421 ± 0.017M/s  | 47.600 ± 0.004M/s  |   + 0.38%    |
+---------------+--------------------+--------------------+--------------+

[1] https://github.com/anakryiko/linux/commit/8dec900975ef

Signed-off-by: Maxim Khmelevskii <max@linux.ibm.com>
Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 arch/s390/net/bpf_jit_comp.c | 37 ++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/arch/s390/net/bpf_jit_comp.c b/arch/s390/net/bpf_jit_comp.c
index d08d159b6319..93ab2fb16b99 100644
--- a/arch/s390/net/bpf_jit_comp.c
+++ b/arch/s390/net/bpf_jit_comp.c
@@ -27,6 +27,7 @@
 #include <asm/extable.h>
 #include <asm/dis.h>
 #include <asm/facility.h>
+#include <asm/lowcore.h>
 #include <asm/nospec-branch.h>
 #include <asm/set_memory.h>
 #include <asm/text-patching.h>
@@ -1777,6 +1778,30 @@ static noinline int bpf_jit_insn(struct bpf_jit *jit, struct bpf_prog *fp,
 		int j, ret;
 		u64 func;
 
+		/* Implement helper call to bpf_get_smp_processor_id() inline */
+		if (insn->src_reg == 0 &&
+		    insn->imm == BPF_FUNC_get_smp_processor_id) {
+			const u32 *cpu_nr = &get_lowcore()->cpu_nr;
+
+			/* ly %b0, cpu_nr */
+			EMIT6_DISP_LH(0xe3000000, 0x0058, BPF_REG_0, REG_0, REG_0,
+				      (unsigned long)cpu_nr);
+			break;
+		}
+
+		/* Implement helper call to bpf_get_current_task/_btf() inline */
+		if (insn->src_reg == 0 &&
+		    (insn->imm == BPF_FUNC_get_current_task ||
+		     insn->imm == BPF_FUNC_get_current_task_btf)) {
+			const u64 *current_task =
+				&get_lowcore()->current_task;
+
+			/* lg %b0, current_task */
+			EMIT6_DISP_LH(0xe3000000, 0x0004, BPF_REG_0, REG_0, REG_0,
+				      (unsigned long)current_task);
+			break;
+		}
+
 		ret = bpf_jit_get_func_addr(fp, insn, extra_pass,
 					    &func, &func_addr_fixed);
 		if (ret < 0)
@@ -3076,3 +3101,15 @@ bool bpf_jit_supports_timed_may_goto(void)
 {
 	return true;
 }
+
+bool bpf_jit_inlines_helper_call(s32 imm)
+{
+	switch (imm) {
+	case BPF_FUNC_get_smp_processor_id:
+	case BPF_FUNC_get_current_task:
+	case BPF_FUNC_get_current_task_btf:
+		return true;
+	default:
+		return false;
+	}
+}
-- 
2.53.0

