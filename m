Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF140259CBD
	for <bpf@vger.kernel.org>; Mon, 16 Feb 2026 06:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771225029; cv=none; b=F5snJ+A1cNpUwRQdnhJG3Pr4ycaywOcN4sA69pEziX9zLWLOdBmhjOLliFz2CiaX9Me4BfhExIFm43JgAY1ygy7TE9DKwHm62/HJ9xHrq4OkO6kM49c7AKLnEkV2aObQCpCqC5Ss6f3ZDlZdmDr7r+vhiKQ3aYjpyPYUfTy3OOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771225029; c=relaxed/simple;
	bh=+jNc4ozOVGRPJFKcQZT9MihF+Z2RzAqYhz+uU0KEd7s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=flpDtvPHiYke5vkBFTPJPA+rayoVBRolOlhZHvv9zTR9Jcjc2smlM6ivAPJfu81cV0WHLZgJLzrtLtYLZ5yddToQ6QmjzpNimkPTGiQAcKlbhhiLTr8DL7T5oBnDDBJNhE7twi8gBgSBb9HTHpnQ7nyn5WEjzXCBCvQ/ZZZhdkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=e57yaJyB; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="e57yaJyB"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61FNjKbY3723169;
	Mon, 16 Feb 2026 06:56:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=zHk59IxzIIMXT7idl
	WS8zNdNKadoH3cZhPPcbxmTXJ8=; b=e57yaJyB3yhdpKH7h3FNi8KK11Y5ox0IA
	BXsbp7mV1uJXa/p95KdX2BosfsDOu01wks2Gg48Dpt8D29/Ke8ywr94N1dU1EY9W
	PRuA+juL+ojxzdUq04+FsQKX/oIJiCZgAZDAKaZDw3wR2VMy9a59FIG7CCdPIanF
	YsTy+TGdz0ugrN6ppYaIP4YOFcOQC5MnuewfGFUbsL1diKS5DCyBbTeUTNp1LlvT
	73NksMOqkd3MaA46omak4LgfNauxQyqL1V6FE2bTEY4m8iYKSFse4q2u7Wp1NvSM
	GdtVzCkZCfyO1jB7kT7ZpxjjPezco4C/35y326Mb+CO1lnZgRiHPA==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4caj6rpeqs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Feb 2026 06:56:52 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61G6IR3w012624;
	Mon, 16 Feb 2026 06:56:51 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cb3crvg45-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Feb 2026 06:56:51 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 61G6ul5L16384328
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Feb 2026 06:56:47 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B70882004D;
	Mon, 16 Feb 2026 06:56:47 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0EAD420040;
	Mon, 16 Feb 2026 06:56:46 +0000 (GMT)
Received: from li-bd3f974c-2712-11b2-a85c-df1cec4d728e.in.ibm.com (unknown [9.78.106.17])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 16 Feb 2026 06:56:45 +0000 (GMT)
From: Hari Bathini <hbathini@linux.ibm.com>
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Saket Kumar Bhaskar <skb99@linux.ibm.com>,
        Abhishek Dubey <adubey@linux.ibm.com>
Subject: [PATCH 3/5] powerpc64/bpf: use consistent tailcall offset in trampoline
Date: Mon, 16 Feb 2026 12:26:37 +0530
Message-ID: <20260216065639.1750181-4-hbathini@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260216065639.1750181-1-hbathini@linux.ibm.com>
References: <20260216065639.1750181-1-hbathini@linux.ibm.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=dvvWylg4 c=1 sm=1 tr=0 ts=6992bfb4 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=VnNF1IyMAAAA:8 a=mg7oJYEXke3Tg0AfzmQA:9
X-Proofpoint-GUID: 24Fh-U_mTGGgO2DDQET1tFJmMhepSwrD
X-Proofpoint-ORIG-GUID: 24Fh-U_mTGGgO2DDQET1tFJmMhepSwrD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE2MDA1NCBTYWx0ZWRfX93XPhoPbHTfP
 hMDgzf7IJlpRIhPJ9ZDaHrXmvl4GmujnUj5ixEbmJg1+hhRQJg+rejJ1nBuHNpCjF66paUOGOka
 QiYCeencFIL4Wwmlkh9EPUht2QuLe7epozezyrCDTEk1RMyTVFd+J8A0W4wID6Ll1vwkJlBdE6n
 cGcIGT/ZY5ZukVvInJlA1AcvmrbxAziMHVY4dlS96jrpJ5mnz/qDTkHr+jG1MOouLQ3CLgFW1nh
 5o8EczfMW2AeEvp6C9dHEfW7Ea2VgSB5S9++RuGeBARtfvwvfOd9GPh3cklEnO98VfoNYGfiCqq
 +twx+yeVroIgnAYJ9W62zZTsdT133cAbKGvwDUSf9J2Go/OCOlNx2Hxv5qUIpinmSpOQ3PDaVIs
 2FgW9URg/x0zNd//kYYpKVTwSRiTyes28wNvhjQE9v7NUEd8cMHSnKANVCCtYghPEsN1FWumBkT
 XLaL56fF0n4L4lga3Vg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-16_03,2026-02-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 impostorscore=0 adultscore=0
 priorityscore=1501 clxscore=1015 malwarescore=0 phishscore=0 suspectscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602160054

Ideally, the offset used to load the tail call info field and to find
the pass by reference address for tail call field should be the same.
But while setting up the tail call info in the trampoline, this was
not followed. This can be misleading and can lead to unpredicable
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
 arch/powerpc/net/bpf_jit.h        |  5 -----
 arch/powerpc/net/bpf_jit_comp.c   | 10 ++++------
 arch/powerpc/net/bpf_jit_comp64.c |  5 ++++-
 3 files changed, 8 insertions(+), 12 deletions(-)

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
index fb6cc1f832a8..1ff8030faf1f 100644
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
@@ -673,7 +671,7 @@ static void bpf_trampoline_setup_tail_call_info(u32 *image, struct codegen_conte
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

