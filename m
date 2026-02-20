Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7CE332E6BC
	for <bpf@vger.kernel.org>; Fri, 20 Feb 2026 06:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771569606; cv=none; b=B7l1uIdoiaGM3twF9Hcz7G0oX+j+AjiceV3YYCyOOuImA78/VG/0qZaq9bT7lg/UHZPfxWOMKCw7B6OolkklSqdfUeKjsqT4PnZD92/f9L+tRb/CawBjoYD3yoRNCm9RRZedc/Tr5LH6EdbmrMNPeixc8l6i7oKMoY7qLZsTIFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771569606; c=relaxed/simple;
	bh=BJ4VRbeZIHVa3l3+ssMBDLoQ7Uay+665cI+a4spZ/W4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hNcZlHpAJDOpLBsDtc69mbq3Y8cS3D7TRfCQGMz5vYHsAc9rF0R+r2RlPQJEuYUh05SB9IwKA+rbafxfEne9muZFlaQAcEtpGl52Mv0nVPmnDp8j4IaRBLupRemiqzd41K6GUsOFdRZeur4zCqIvIS8Rd/1FQQZeoUA1YinS7mE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=YOFvIhWm; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="YOFvIhWm"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61JMJYAH1261014;
	Fri, 20 Feb 2026 06:39:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=OKrXPlX9taqXY/rFx
	QaNgARTTA6rqe/8bDz7nOHWXBo=; b=YOFvIhWmfNtsxKPTzKKlyESZnh9mHiv97
	PmSXmx1b439iaQhxCqYZQNuWCTVE4nudidXQx+oV20GvbQmU1TY6eQUPcIkpY7XY
	enI/QP2SgHjBZXVygkiHu68hMV6+yeVpqgEs9ZPiIziLSUt723jApClKERf7g8BT
	lk5FcEfVPgCF98H2BnO2BbsdP6V0PhFI4xIkpPp+OlstvBPxFLnOAhUVQi4xDwQN
	FAPuTjhRj+6nvm+AkGIduVaA7eiI6VLAvjif1f/ZrZXu9egPWn60jFHrYvjE9Cuz
	J/dgDpPrFN7IKxe9edqCwDFJjB2SaPnU/etExIdhDTGGqVlO1C3dg==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4caj6s9r50-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 20 Feb 2026 06:39:50 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61K4I7IL015697;
	Fri, 20 Feb 2026 06:39:49 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ccb45fc03-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 20 Feb 2026 06:39:49 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 61K6djCk46268920
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 20 Feb 2026 06:39:45 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 50A5420043;
	Fri, 20 Feb 2026 06:39:45 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 19CC520040;
	Fri, 20 Feb 2026 06:39:43 +0000 (GMT)
Received: from li-bd3f974c-2712-11b2-a85c-df1cec4d728e.ibm.com.com (unknown [9.43.64.63])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 20 Feb 2026 06:39:42 +0000 (GMT)
From: Hari Bathini <hbathini@linux.ibm.com>
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Cc: bpf@vger.kernel.org, Madhavan Srinivasan <maddy@linux.ibm.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Saket Kumar Bhaskar <skb99@linux.ibm.com>,
        Abhishek Dubey <adubey@linux.ibm.com>,
        Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Subject: [PATCH v2 3/5] powerpc64/bpf: use consistent tailcall offset in trampoline
Date: Fri, 20 Feb 2026 12:09:31 +0530
Message-ID: <20260220063933.196141-4-hbathini@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260220063933.196141-1-hbathini@linux.ibm.com>
References: <20260220063933.196141-1-hbathini@linux.ibm.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=dvvWylg4 c=1 sm=1 tr=0 ts=699801b6 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=VnNF1IyMAAAA:8 a=mg7oJYEXke3Tg0AfzmQA:9
X-Proofpoint-GUID: OboERxKcP8v6U38EZpAqeo4WC4-Re9cl
X-Proofpoint-ORIG-GUID: OboERxKcP8v6U38EZpAqeo4WC4-Re9cl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIwMDA1MiBTYWx0ZWRfX/7iVWAIfLaUV
 CKXZmmkNBzs0ewVJCyHydeCZJ9e5KKMtyqMla0j+ecWz6yRu1auS+LnrfKETwGwmkdYA8yvcQ9R
 zHCjmd5/eLBFXZv1NklCF8kw1WqDtHfiHkwWfGY3P40Yi2y0SGG1UgDHzckArnL+ThmLyCBuloe
 Q4UcaUyE0ijczFQVBg0etsfJe3/FY5MlvJkoRuERHZ0IIavN/9Ee+ehrKIakwPvbmAYrEbok3AM
 q9WTASsg1s7ytrhHlBaz40eWPXJzLWTaCvmjQD7yLR15KogMsu1kKsI8V0WdoWjH4MCKDdc5Ym8
 gG6kpZNIfA7g5pt/3e/Glp631U29egKFC4OIfWfz3LbF1zAi3rGcAtL1VKs7OpCUn76B8WYs3FF
 nv5FrcIL0lGOy/mnbXzf8WZn+N5HifWrZ4nIDLIut0qFHgEo0WQ3vWQONhGfqVptfncduU0qOR7
 d2Yy9XzRsvFKHV4MbXg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-19_06,2026-02-20_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 impostorscore=0 adultscore=0
 priorityscore=1501 clxscore=1015 malwarescore=0 phishscore=0 suspectscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602200052

Ideally, the offset used to load the tail call info field and to find
the pass by reference address for tail call field should be the same.
But while setting up the tail call info in the trampoline, this was
not followed. This can be misleading and can lead to unpredictable
results if and when bpf_has_stack_frame() ends up returning true
for trampoline frame. Since commit 15513beeb673 ("powerpc64/bpf:
Moving tail_call_cnt to bottom of frame") and commit 2ed2d8f6fb38
("powerpc64/bpf: Support tailcalls with subprogs") ensured tail call
field is at the bottom of the stack frame for BPF programs as well as
BPF trampoline, avoid relying on bpf_jit_stack_tailcallinfo_offset()
and bpf_has_stack_frame() for trampoline frame and always calculate
tail call field offset with reference to older frame.

Fixes: 2ed2d8f6fb38 ("powerpc64/bpf: Support tailcalls with subprogs")
Signed-off-by: Hari Bathini <hbathini@linux.ibm.com>
---

Changes since v1:
* Fixed spelling error in changelog.
* Fixed a comment in bpf_trampoline_setup_tail_call_info().


 arch/powerpc/net/bpf_jit.h        |  5 -----
 arch/powerpc/net/bpf_jit_comp.c   | 12 +++++-------
 arch/powerpc/net/bpf_jit_comp64.c |  5 ++++-
 3 files changed, 9 insertions(+), 13 deletions(-)

diff --git a/arch/powerpc/net/bpf_jit.h b/arch/powerpc/net/bpf_jit.h
index 82bbf63f0e57..7354e1d72f79 100644
--- a/arch/powerpc/net/bpf_jit.h
+++ b/arch/powerpc/net/bpf_jit.h
@@ -81,9 +81,6 @@
 
 #ifdef CONFIG_PPC64
 
-/* for gpr non volatile registers BPG_REG_6 to 10 */
-#define BPF_PPC_STACK_SAVE	(6 * 8)
-
 /* If dummy pass (!image), account for maximum possible instructions */
 #define PPC_LI64(d, i)		do {					      \
 	if (!image)							      \
@@ -219,8 +216,6 @@ int bpf_jit_emit_exit_insn(u32 *image, struct codegen_context *ctx, int tmp_reg,
 int bpf_add_extable_entry(struct bpf_prog *fp, u32 *image, u32 *fimage, int pass,
 			  struct codegen_context *ctx, int insn_idx,
 			  int jmp_off, int dst_reg, u32 code);
-
-int bpf_jit_stack_tailcallinfo_offset(struct codegen_context *ctx);
 #endif
 
 #endif
diff --git a/arch/powerpc/net/bpf_jit_comp.c b/arch/powerpc/net/bpf_jit_comp.c
index fb6cc1f832a8..860b118391ed 100644
--- a/arch/powerpc/net/bpf_jit_comp.c
+++ b/arch/powerpc/net/bpf_jit_comp.c
@@ -642,15 +642,13 @@ static void bpf_trampoline_setup_tail_call_info(u32 *image, struct codegen_conte
 						int bpf_dummy_frame_size, int r4_off)
 {
 	if (IS_ENABLED(CONFIG_PPC64)) {
-		/* See Generated stack layout */
-		int tailcallinfo_offset = BPF_PPC_TAILCALL;
-
 		/*
 		 * func_frame_offset =                                   ...(1)
 		 *      bpf_dummy_frame_size + trampoline_frame_size
 		 */
 		EMIT(PPC_RAW_LD(_R4, _R1, func_frame_offset));
-		EMIT(PPC_RAW_LD(_R3, _R4, -tailcallinfo_offset));
+		/* Refer to trampoline's Generated stack layout */
+		EMIT(PPC_RAW_LD(_R3, _R4, -BPF_PPC_TAILCALL));
 
 		/*
 		 * Setting the tail_call_info in trampoline's frame
@@ -658,7 +656,7 @@ static void bpf_trampoline_setup_tail_call_info(u32 *image, struct codegen_conte
 		 */
 		EMIT(PPC_RAW_CMPLWI(_R3, MAX_TAIL_CALL_CNT));
 		PPC_BCC_CONST_SHORT(COND_GT, 8);
-		EMIT(PPC_RAW_ADDI(_R3, _R4, bpf_jit_stack_tailcallinfo_offset(ctx)));
+		EMIT(PPC_RAW_ADDI(_R3, _R4, -BPF_PPC_TAILCALL));
 		/*
 		 * From ...(1) above:
 		 * trampoline_frame_bottom =                            ...(2)
@@ -666,14 +664,14 @@ static void bpf_trampoline_setup_tail_call_info(u32 *image, struct codegen_conte
 		 *
 		 * Using ...(2) derived above:
 		 * trampoline_tail_call_info_offset =                  ...(3)
-		 *      trampoline_frame_bottom - tailcallinfo_offset
+		 *      trampoline_frame_bottom - BPF_PPC_TAILCALL
 		 *
 		 * From ...(3):
 		 * Use trampoline_tail_call_info_offset to write reference of main's
 		 * tail_call_info in trampoline frame.
 		 */
 		EMIT(PPC_RAW_STL(_R3, _R1, (func_frame_offset - bpf_dummy_frame_size)
-								- tailcallinfo_offset));
+								- BPF_PPC_TAILCALL));
 	} else {
 		/* See bpf_jit_stack_offsetof() and BPF_PPC_TC */
 		EMIT(PPC_RAW_LL(_R4, _R1, r4_off));
diff --git a/arch/powerpc/net/bpf_jit_comp64.c b/arch/powerpc/net/bpf_jit_comp64.c
index 44ce8a8783f9..5d4d2bb23cef 100644
--- a/arch/powerpc/net/bpf_jit_comp64.c
+++ b/arch/powerpc/net/bpf_jit_comp64.c
@@ -42,6 +42,9 @@
  * exception boundary.
  */
 
+/* BPF non-volatile registers save area size */
+#define BPF_PPC_STACK_SAVE	(6*8)
+
 /* for bpf JIT code internal usage */
 #define BPF_PPC_STACK_LOCALS	24
 /*
@@ -148,7 +151,7 @@ static int bpf_jit_stack_local(struct codegen_context *ctx)
 	}
 }
 
-int bpf_jit_stack_tailcallinfo_offset(struct codegen_context *ctx)
+static int bpf_jit_stack_tailcallinfo_offset(struct codegen_context *ctx)
 {
 	return bpf_jit_stack_local(ctx) + BPF_PPC_STACK_LOCALS + BPF_PPC_STACK_SAVE;
 }
-- 
2.53.0

