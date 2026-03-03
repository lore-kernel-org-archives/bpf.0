Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED3A93321A2
	for <bpf@vger.kernel.org>; Tue,  3 Mar 2026 13:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772542960; cv=none; b=seyKS46VkIyV+7sIJgpvoqGhVDo1IHxlQSwzeGC60T9Ee++ldmUjrgyzrtGZ961wipWu0Py/RR63EJ/E11bb65erKeBrV5UzQbjJGLYwwJ1SXSalbxrl+YsrhRSLMDwBf70R1dqKRt6ujXPCq2bqNYnHoN6lmBPChfB6Cs/v3JM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772542960; c=relaxed/simple;
	bh=iX9cU5tNVDch+N6/I8HitVXxAG6A0epjJQ+pbZFQhk0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lHCrFg3qY3d+zTXn5NDyBqXbFQenaahEL1sHI5546xKkUFFWPm+pvMlc44PwVw7JLb1Mgq2ZNRHk9tepGMXNWxLwVP7439I952T1nA0lXnPv+2FTVuvxpDcu8pRtpaQEYg5W6149fFv9VluQ2Wv4oAfC8S6TgMUoLuG9+jEk61A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=FHeKXQNV; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="FHeKXQNV"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 623A25u82804450;
	Tue, 3 Mar 2026 13:02:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=yBrvbkoJLRs9uzgWS
	mJpgJmDaj4/bmRFClF6EwTRTCw=; b=FHeKXQNVrohLURwnjQ2Ilm/w8006irbsG
	lD5xS+7+DN22a39V8nfyWhM2Vw2J4A714RQ5h8z0hXIcsUsRWZViVslplAq3GXYx
	Tv5GYIMjjumiFfCOeajLnnAGvDRGGtpckhM86F5jJ5lWzRzU3VfgAFjKpYOL9K4h
	0S4yrBhrDLxykRs6JsevEh5ruiet57krwXZzgfINg+A5D/vDD8rVW0iPk2FaKJpN
	jag2SZAwbMWnwvv0ru5quCpejQuZQGHj+XdxhscaOXG7iQKQ8Tt1krTCDJC04pdV
	3OH8WUkPCj91OdQ5BzqApQW1hZd/xFkRcmOLw/Y6Ylawvta+QHMxw==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ckskctyrp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 03 Mar 2026 13:02:23 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 623AcSJh010309;
	Tue, 3 Mar 2026 13:02:22 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4cmc6k260b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 03 Mar 2026 13:02:22 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 623D2IYh49217844
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 3 Mar 2026 13:02:18 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2C7552004B;
	Tue,  3 Mar 2026 13:02:18 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3D0C82004D;
	Tue,  3 Mar 2026 13:02:16 +0000 (GMT)
Received: from li-bd3f974c-2712-11b2-a85c-df1cec4d728e.in.ibm.com (unknown [9.78.106.17])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  3 Mar 2026 13:02:16 +0000 (GMT)
From: Hari Bathini <hbathini@linux.ibm.com>
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Cc: bpf@vger.kernel.org, Madhavan Srinivasan <maddy@linux.ibm.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Saket Kumar Bhaskar <skb99@linux.ibm.com>,
        Abhishek Dubey <adubey@linux.ibm.com>,
        Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Subject: [PATCH v3 3/6] powerpc64/bpf: use consistent tailcall offset in trampoline
Date: Tue,  3 Mar 2026 18:32:05 +0530
Message-ID: <20260303130208.325249-4-hbathini@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260303130208.325249-1-hbathini@linux.ibm.com>
References: <20260303130208.325249-1-hbathini@linux.ibm.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: hWoZDMT3tU6VwcwxGFDmmPI4NqHJmJas
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAzMDA5OSBTYWx0ZWRfX+IRvPbzR607P
 tkAfhGf2dZeZ2hShqNi/p0MQw7jI5GwXV3QxrnZkbfJtlZ1Mfc+G6NlwQSOeY2/LR1O3lG4toCH
 MPB5RIRB7UMEuvld2/d50KFVE90WAxPCs5fRq80eb5uGwbwLLADTtSH7z+88d8xVIVNoDvB6Udb
 zB3SnQMwESxThfMOP7YcWFTwlIVG4QM4naP0e/hBX70xatvIICiBsxYTn0M3yHiW37qJ1HpNuUr
 dR9/6U2XnxqEXbnguto4k8o/AF7aUFJgAdNroJUcxd64XcOd3+7lXAvB1G3CcIr+CB5q39N5gRC
 7guVx310G26BB0usBJCSEjMPazWD9dWHgSrIHRA1hC8pIFJHB+cEjte9vtwVlIje1V7NHPW+fVz
 FLumI4hkstr/rzccBf2HEvHP9JFeTCHMK6XcaAAGikVAHgcWwMLSH4hA8lhFMkO/7Ao8QMg08KY
 ddh4BZTjSoi97Zyibkg==
X-Authority-Analysis: v=2.4 cv=H7DWAuYi c=1 sm=1 tr=0 ts=69a6dbdf cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=mg7oJYEXke3Tg0AfzmQA:9
X-Proofpoint-ORIG-GUID: hWoZDMT3tU6VwcwxGFDmmPI4NqHJmJas
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-02_05,2026-03-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 adultscore=0 bulkscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603030099

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

Changes in v3:
- BPF_PPC_STACK_SAVE macro definition adjusted as suggested by Abhishek.


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
index 95f208229b09..a4aa1e4c9f1c 100644
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
index 44ce8a8783f9..7655be76f537 100644
--- a/arch/powerpc/net/bpf_jit_comp64.c
+++ b/arch/powerpc/net/bpf_jit_comp64.c
@@ -42,6 +42,9 @@
  * exception boundary.
  */
 
+/* BPF non-volatile registers save area size */
+#define BPF_PPC_STACK_SAVE	(6 * 8)
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

