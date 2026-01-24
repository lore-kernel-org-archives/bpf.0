Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51A0A2848A0;
	Sat, 24 Jan 2026 07:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769241224; cv=none; b=GhsYjbndowRsjsntsh4h02c/nnlNG8q07ud0N7KxVZBN87zLEi3svrKefW+gmpuG4PhennFtri8I5IAFvguo1ipJj1EAdMvDHAhZ47Lpex3Lf9G1XqzW3Ygc2hpHR1j8+h4nEGaZ4xqrHaB9on7mASjjjSwa5IuIWuCpdU3x/m4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769241224; c=relaxed/simple;
	bh=oeJO3hczzmPQy7vube3UOCTKQb3K5zRr8MH4GQUFHxU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n0lfmXx9gJLwsFlKuvri9wtnUWMp1D7Nj+5JC+SCi2YRyYh8iarDS0ABzMUbW8kjAz8mfBtOrLPvRxJIAbFeB5IDvJmAJGAmPvH9NfhnR8214/EWMQASxnDhjtSRhdlI4VKj+kg+gRT2rTsfd2rK4w29lf0yULUsxGBOv4PmmUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=mm1vQQqA; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="mm1vQQqA"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60O5RSev024443;
	Sat, 24 Jan 2026 07:53:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=UXdPxN0yzQYC1zXtR
	qHrrTIjvlERtEZxVMk7HfF01xU=; b=mm1vQQqAipr4Psx80BtReaB7rzUE7oQO/
	VebSDCwbT/OVCBZ8YPUxNTeSLvVUHF/yv+bGzlizW6UC/VhnCGzHXWc+1Hxva9lP
	b7+AiKadjrQ51eWygQ1TtwQhDKuaPl8l0csisQlgRBmyHROIVubiajiZJUXHae+y
	zfQU/v+OrQNG8lA/6siEfb7RTrnXoWr8tfHXMrW3T1qr9YXgwcuxWZC3rZfTzj7D
	5MXBrNo/rWs6tebOc70GzkHpXnuOJNopaRMh5OI8fhHTu8CKVaxp56mld69cCTWw
	qgNoS9vFxlcz8DQy5ftlGYfKcWzbns0VxfDey/RjU8hv8ccbzZrfA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bvnr5rjb6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 24 Jan 2026 07:53:09 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 60O7r8R7010462;
	Sat, 24 Jan 2026 07:53:08 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bvnr5rjb4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 24 Jan 2026 07:53:08 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60O24kpu006424;
	Sat, 24 Jan 2026 07:53:07 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4brqf24n1q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 24 Jan 2026 07:53:07 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 60O7r4Vo47514030
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 24 Jan 2026 07:53:04 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E9BA620043;
	Sat, 24 Jan 2026 07:53:03 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9A36120040;
	Sat, 24 Jan 2026 07:52:57 +0000 (GMT)
Received: from abhi.. (unknown [9.124.223.59])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sat, 24 Jan 2026 07:52:57 +0000 (GMT)
From: adubey@linux.ibm.com
To: bpf@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: hbathini@linux.ibm.com, sachinpb@linux.ibm.com, venkat88@linux.ibm.com,
        andrii@kernel.org, eddyz87@gmail.com, mykolal@fb.com, ast@kernel.org,
        daniel@iogearbox.net, martin.lau@linux.dev, song@kernel.org,
        yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
        sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org,
        christophe.leroy@csgroup.eu, naveen@kernel.org, maddy@linux.ibm.com,
        mpe@ellerman.id.au, npiggin@gmail.com, memxor@gmail.com,
        iii@linux.ibm.com, shuah@kernel.org,
        Abhishek Dubey <adubey@linux.ibm.com>
Subject: [PATCH v5 3/6] powerpc64/bpf: Avoid tailcall restore from trampoline
Date: Sat, 24 Jan 2026 13:22:20 +0530
Message-ID: <20260124075223.6033-4-adubey@linux.ibm.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260124075223.6033-1-adubey@linux.ibm.com>
References: <20260124075223.6033-1-adubey@linux.ibm.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI0MDA2MCBTYWx0ZWRfXyKAdOv1HA5FA
 84DoEfCC1SloNkLxLa+syX9gZPZbEJSl5o8fxx3mKyikDijirNWaPPQ5TVfZpIBasV2o0eWT/EA
 shBgEZL5FSNF3ZkCCes2VZtpPHrp6xzoOi7mGGZcXm9Z+9I2Jy4fnOOFYN+tXZST8vnOO+4Z451
 KbWrWRJOaeNrh/kT9GQ0DU07hOfsQHkAbAmPoRZOe/R7R3kuT6M2OGpZ3S+L87RrEb9gRPV/dgI
 O1QmMVI3KD+Z327VPP/7UsoDHooIHw47dzhanrGTeHcqcdIpYpyK9K48xXR4Xmya82dez/o2319
 PtbOibXjCFZ9c6RHhM2ESjFuDCzckCXfDjGOSqWSMwrnQ/AS1YqCQVbm0P2oEE946Fx0shmeQRn
 FVOMc56dpQPyd78e2030QACHnBblQyHoq5hFQx8SZCd/ixVRyyJH0iZCmjX2RoLjQa52qApLVgW
 3FCFXlFuOW2a84+f5/A==
X-Proofpoint-GUID: zttSLy4Wpu_vInN_j3ZKCS3aXrDsCSxt
X-Proofpoint-ORIG-GUID: PCDTYKd1zuPlntCIjQHjWNKfHLnepz56
X-Authority-Analysis: v=2.4 cv=X+Vf6WTe c=1 sm=1 tr=0 ts=69747a65 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8
 a=yUNxoNuUyiXgUDPvJtcA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-24_02,2026-01-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 impostorscore=0 lowpriorityscore=0
 clxscore=1015 spamscore=0 adultscore=0 malwarescore=0 bulkscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2601150000
 definitions=main-2601240060

From: Abhishek Dubey <adubey@linux.ibm.com>

Back propagation of tailcall count is no longer needed for
powerpc64 due to use of reference, which updates the tailcall
count in the tail_call_info field in the frame of the main
program only.

Back propagation is still required for 32-bit powerpc.

Signed-off-by: Abhishek Dubey <adubey@linux.ibm.com>
---
 arch/powerpc/net/bpf_jit_comp.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/net/bpf_jit_comp.c b/arch/powerpc/net/bpf_jit_comp.c
index 4b18daed054a..f8769d785123 100644
--- a/arch/powerpc/net/bpf_jit_comp.c
+++ b/arch/powerpc/net/bpf_jit_comp.c
@@ -659,14 +659,11 @@ static void bpf_trampoline_setup_tail_call_info(u32 *image, struct codegen_conte
 static void bpf_trampoline_restore_tail_call_cnt(u32 *image, struct codegen_context *ctx,
 						 int func_frame_offset, int r4_off)
 {
-	if (IS_ENABLED(CONFIG_PPC64)) {
-		/* See bpf_jit_stack_tailcallcnt() */
-		int tailcallcnt_offset = BPF_PPC_TAILCALL;
-
-		EMIT(PPC_RAW_LL(_R3, _R1, -tailcallcnt_offset));
-		EMIT(PPC_RAW_STL(_R3, _R1, func_frame_offset - tailcallcnt_offset));
-	} else {
-		/* See bpf_jit_stack_offsetof() and BPF_PPC_TC */
+	if (IS_ENABLED(CONFIG_PPC32)) {
+		/*
+		 * Restore tailcall for 32-bit powerpc
+		 * See bpf_jit_stack_offsetof() and BPF_PPC_TC
+		 */
 		EMIT(PPC_RAW_STL(_R4, _R1, r4_off));
 	}
 }
-- 
2.48.1

