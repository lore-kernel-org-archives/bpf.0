Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DBFA191F94
	for <bpf@vger.kernel.org>; Fri, 20 Feb 2026 06:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771569041; cv=none; b=YWa12zjOenkRjxmy0pItLGsGgtMgLLKXlxRcsG9oROcMSg8gXVB9+pTpY0J+MHlhyQcyOXj4p298InyWtrIZYAcdw9CG3jEuH6FJpJsDxekWWvICJRTQpx1SJKwJVStzWpMuwgSES128dOrWL4sbcnOEPyOW1mHCQTzs+PMSVPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771569041; c=relaxed/simple;
	bh=aBC9AlIKnWVJPnGThIIy+rfwCEWwi78KJ4ypwPw9vy8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NRtJHtvwyLZTpsrOiImKdXGhc5uFBTXEUL+HUCq8MZLFLzKoGUJDiP21HKkjvyFg9nHz7rJTwA1dvxAWy7kN43vxkvBugpARH2BRS1fOctlF/Nzt+WNUjEiK6HwNmWRDWrMj7ytTIpM23BGhQohivOD2yLkDQUGOD3fKY3YqQoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=BMqYz7pb; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="BMqYz7pb"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61JJtOZg1260217;
	Fri, 20 Feb 2026 06:30:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=dPj9g+WDkor+tNG0OT1yTsgsegbdDqYlzy/A4pCWK
	lg=; b=BMqYz7pbxxuqSUmncwuaW108EjmGEMtu6WnXcdeSe6rx3CsZ7K9C+vH3i
	NKj7Uryy/xS7+ynaXgfftp/GqEMV1dhGKwgkmwihwJ3eTNTzE8YsTlmrFRTGVFec
	46BMi35drcj734G5o3wBI+OnqGMiJo27l3XcjGn1OCj7MM9kMMj+N2zS82xsIfWc
	c7SqUZK7juNB+jk4jmaYS04g3MnmeuzOyoEVeLfj/aXqtyqYlSf0G76VGP4gyrL/
	7VQImvQyKN47Nwj4CNM3ZQj4f5TPdO9uwpQbwzznGnEh32RLZXf5XeKWn2vOCNfy
	TG3mj8vBEejdmx8lkixi5RJzG3mXg==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4caj6s9q91-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 20 Feb 2026 06:30:07 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61K42NP6001395;
	Fri, 20 Feb 2026 06:30:07 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ccb2bqbn9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 20 Feb 2026 06:30:06 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 61K6U3FB28050086
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 20 Feb 2026 06:30:03 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1FA922004B;
	Fri, 20 Feb 2026 06:30:03 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1D93420040;
	Fri, 20 Feb 2026 06:30:01 +0000 (GMT)
Received: from li-bd3f974c-2712-11b2-a85c-df1cec4d728e.ibm.com.com (unknown [9.43.64.63])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 20 Feb 2026 06:30:00 +0000 (GMT)
From: Hari Bathini <hbathini@linux.ibm.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Saket Kumar Bhaskar <skb99@linux.ibm.com>,
        Abhishek Dubey <adubey@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH 1/2] bpf: do not increment tailcall count when prog is NULL
Date: Fri, 20 Feb 2026 11:59:58 +0530
Message-ID: <20260220062959.195101-1-hbathini@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=dvvWylg4 c=1 sm=1 tr=0 ts=6997ff6f cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=VnNF1IyMAAAA:8 a=88n30AINgtHh2v353bYA:9
X-Proofpoint-GUID: 15tlexwDVnI1YaKSu0DIEwrRL9crA7iG
X-Proofpoint-ORIG-GUID: 15tlexwDVnI1YaKSu0DIEwrRL9crA7iG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIwMDA1MiBTYWx0ZWRfX5qXKFoTVEs6o
 sbiTnLkQDLRHkEf+rKw6Fhb4MluPgoOCcKu5amAI8uZ+LLl44yQ7/29u7cbb6XTYJ5Aj/nqJd49
 6oAxOSa/JIrg2PEgCD6CYFm4kS4SMVK0Y3quGtVM7yLFEoo7gqa2QWR4a0t+3nB0RvybZocafiu
 LTFjn5ERhptJfH8v0EOEnA5Zs6ZVgmGbYGcLFTI2kDVjqXn3dHayXW3R4hUDw5w9hMnJCxAv2gW
 vbpIPAo8h0JQ3SpPB/9J4CK74UhCFtZ3AevpncEa446wXFFYmMXaelP1yA8fo414cx/rAnjdVXK
 yBkcCwb7Frhh23RyDcEarjhkGWB9PeCtT1c4D4ztnpddINSRMpmQ6Z3xQtWSIcmSrqQhzLUHOTR
 kgrQvn5OlGKIz0tBnuSfRwCcFXK8E7is74mJroIpYb35JkuV+nzVxM4xF02TZQOQzV95O1Svl5Q
 BTEGhbT6+L3G2ppN9IQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-19_06,2026-02-20_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 impostorscore=0 adultscore=0
 priorityscore=1501 clxscore=1015 malwarescore=0 phishscore=0 suspectscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602200052

Currently, tailcall count is incremented in the interpreter even when
tailcall fails due to non-existent prog. Fix this by holding off on
the tailcall count increment until after NULL check on the prog.

Fixes: 04fd61ab36ec ("bpf: allow bpf programs to tail-call other bpf programs")
Suggested-by: Ilya Leoshkevich <iii@linux.ibm.com>
Signed-off-by: Hari Bathini <hbathini@linux.ibm.com>
---
 kernel/bpf/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 1b9b18e5b03c..3f6b2263c8e0 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -2057,12 +2057,12 @@ static u64 ___bpf_prog_run(u64 *regs, const struct bpf_insn *insn)
 		if (unlikely(tail_call_cnt >= MAX_TAIL_CALL_CNT))
 			goto out;
 
-		tail_call_cnt++;
-
 		prog = READ_ONCE(array->ptrs[index]);
 		if (!prog)
 			goto out;
 
+		tail_call_cnt++;
+
 		/* ARG1 at this point is guaranteed to point to CTX from
 		 * the verifier side due to the fact that the tail call is
 		 * handled like a helper, that is, bpf_tail_call_proto,
-- 
2.53.0

