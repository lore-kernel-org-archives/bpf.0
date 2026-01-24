Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BB3C225A3D;
	Sat, 24 Jan 2026 07:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769241251; cv=none; b=L3t0Y389jU+dfCdxjxCMdHlidPUbQ+0GpL5a1+RRyK+N4Mzio+LeW+3G64OLCmyJm5iGMcrfmMSEIM4WBpTHGbEpWT87UtUa6EvYp3yd5ZhoZypF1VJVPTZhGKNv1NQV/9X+tYCbPwMX1wwTJy+qUv0TjFRD8PwqVdGgeES4kJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769241251; c=relaxed/simple;
	bh=TCTKfshPCV8SO4rny2nEmpkQ7KnE8QDxHggBE04FCkY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VWEy80Gz8rOqWfuGbY5Ps9X3s0RORc8SLTsFEeiml8hLoGa9U131bc/WJ675OXpm2X039QpIHaNSZVBZbmtxOxs0XtYrLmCXiTqdtm91BDaOzB9z0wHHmLZzMQU5NlF49Xr0pHpy1FuG/yBzx5dd5gcknJ6Ral7Lq+ILphdNKj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=FuZAuNKT; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="FuZAuNKT"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60O7jwrA001740;
	Sat, 24 Jan 2026 07:53:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=X9MwwHemcZiPszY3K
	p91dfFv3DKy9H/iTxZM5Y0gVkE=; b=FuZAuNKTsb9cJDD+teyQTTAq06yKLBFHc
	VCjkY9Pd3qIJJgkj99mE54nPmHjavQZCd7GF3iXGUrdTP28AuSJGfWg65znyD/DD
	G8klMFeZlc6nluKWrrM7C6SqcWxSsSlXkNeeKyJUSqkogRk06IJ9KI4icmfIbS1f
	vt3IauexTPAFlFaq0sX5GCxeyZaf5Yrj4GSJQQf1r2eLCwZhmiGY8e5CIidmHHFj
	FdcH4yJekB7BsKJONLw+a0SOIPRKaOWzFv6Ut7U8DphCihrsYo+l0FCg5uPL/kf3
	IXvJ92AQfCClEBOUHx5xFJMw0KY1ux/lEpb2hR6UrFYS5a3l1+xRQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bvnk6grmk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 24 Jan 2026 07:53:27 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 60O7rR9A014049;
	Sat, 24 Jan 2026 07:53:27 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bvnk6grmg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 24 Jan 2026 07:53:26 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60O6Seeq027298;
	Sat, 24 Jan 2026 07:53:25 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4brnrnmx74-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 24 Jan 2026 07:53:25 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 60O7rLFT17301860
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 24 Jan 2026 07:53:21 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 79DC020043;
	Sat, 24 Jan 2026 07:53:21 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 16DB320040;
	Sat, 24 Jan 2026 07:53:15 +0000 (GMT)
Received: from abhi.. (unknown [9.124.223.59])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sat, 24 Jan 2026 07:53:14 +0000 (GMT)
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
Subject: [PATCH v5 5/6] powerpc64/bpf: Support exceptions
Date: Sat, 24 Jan 2026 13:22:22 +0530
Message-ID: <20260124075223.6033-6-adubey@linux.ibm.com>
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
X-Proofpoint-GUID: wwG8h5J6O3egLS2U5yNf7qxG-JWX_uuo
X-Proofpoint-ORIG-GUID: ktkxY51okytgQPuHJcU8WUsOEYkCq1Xp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI0MDA2MCBTYWx0ZWRfX6iLnNr0OKdHW
 pxkNi08Y+VOfmcrxUbAe5BA+YcFbA3DIdApvLN7Ck4l3CGym2YMwu2wjdU23TUmNBQ5o8KVmJPd
 efNWq8dKndLHP0R9AAxpoC+gZBB1kjZveeGC7CqeQG8xCt7UDNk8qaoPbaLyaI33pSnZeAAekoT
 jj9RaMftvTBXXdDEEGyV8uNtetKkbqsehRq84rCC8D+x/E5xnZulrT5PeTgucPaI12u8EfB1twh
 9jgO+FXu0pwXSDJRWZBE+Z+iXCwv2SLB09uswO+NuJYU20u0Cr2qb+nLmL6zt4FFJg+3G/RO1it
 VGwwKLTaWmrEaq0ZxmmHT2qo81YYSX7ZN/w99uWjm5xzBbpnmnDZRrze6QPDjbxc2YdDXh5VsAK
 Wp70LG1vVPfqIdMQMo4dt7HJN9hqBNjC0Fwfaw/ffYbleqBqVT4rVyVgqcz+nDZtsbu2HLkDGGb
 C9YvJ1Zy4JWgtg/Gwyw==
X-Authority-Analysis: v=2.4 cv=AMiVTGgp c=1 sm=1 tr=0 ts=69747a77 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=DU0EyFXtAAAA:8 a=VnNF1IyMAAAA:8
 a=xcpHmmOOOUdXZ9sPVCMA:9 a=UCR5be5CC-YrbG9FbbB0:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-24_02,2026-01-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 phishscore=0 bulkscore=0 suspectscore=0
 adultscore=0 clxscore=1015 priorityscore=1501 lowpriorityscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2601150000
 definitions=main-2601240060

From: Abhishek Dubey <adubey@linux.ibm.com>

The modified prologue/epilogue generation code now
enables exception-callback to use the stack frame of
the program marked as exception boundary, where callee
saved registers are stored.

As per ppc64 ABIv2 documentation[1], r14-r31 are callee
saved registers. BPF programs on ppc64 already saves
r26-r31 registers. Saving the remaining set of callee
saved registers(r14-r25) is handled in the next patch.

[1] https://ftp.rtems.org/pub/rtems/people/sebh/ABI64BitOpenPOWERv1.1_16July2015_pub.pdf

Signed-off-by: Abhishek Dubey <adubey@linux.ibm.com>
---
 arch/powerpc/net/bpf_jit.h        |  2 ++
 arch/powerpc/net/bpf_jit_comp.c   |  7 ++++
 arch/powerpc/net/bpf_jit_comp64.c | 59 +++++++++++++++++++++----------
 3 files changed, 50 insertions(+), 18 deletions(-)

diff --git a/arch/powerpc/net/bpf_jit.h b/arch/powerpc/net/bpf_jit.h
index 56f56fdd4969..82bbf63f0e57 100644
--- a/arch/powerpc/net/bpf_jit.h
+++ b/arch/powerpc/net/bpf_jit.h
@@ -179,6 +179,8 @@ struct codegen_context {
 	u64 arena_vm_start;
 	u64 user_vm_start;
 	bool is_subprog;
+	bool exception_boundary;
+	bool exception_cb;
 };
 
 #define bpf_to_ppc(r)	(ctx->b2p[r])
diff --git a/arch/powerpc/net/bpf_jit_comp.c b/arch/powerpc/net/bpf_jit_comp.c
index f8769d785123..3a2e6fa3ac7c 100644
--- a/arch/powerpc/net/bpf_jit_comp.c
+++ b/arch/powerpc/net/bpf_jit_comp.c
@@ -207,6 +207,8 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *fp)
 	cgctx.arena_vm_start = bpf_arena_get_kern_vm_start(fp->aux->arena);
 	cgctx.user_vm_start = bpf_arena_get_user_vm_start(fp->aux->arena);
 	cgctx.is_subprog = bpf_is_subprog(fp);
+	cgctx.exception_boundary = fp->aux->exception_boundary;
+	cgctx.exception_cb = fp->aux->exception_cb;
 
 	/* Scouting faux-generate pass 0 */
 	if (bpf_jit_build_body(fp, NULL, NULL, &cgctx, addrs, 0, false)) {
@@ -436,6 +438,11 @@ void bpf_jit_free(struct bpf_prog *fp)
 	bpf_prog_unlock_free(fp);
 }
 
+bool bpf_jit_supports_exceptions(void)
+{
+	return IS_ENABLED(CONFIG_PPC64);
+}
+
 bool bpf_jit_supports_subprog_tailcalls(void)
 {
 	return IS_ENABLED(CONFIG_PPC64);
diff --git a/arch/powerpc/net/bpf_jit_comp64.c b/arch/powerpc/net/bpf_jit_comp64.c
index 1bba068f2c4c..db121b1404fe 100644
--- a/arch/powerpc/net/bpf_jit_comp64.c
+++ b/arch/powerpc/net/bpf_jit_comp64.c
@@ -89,7 +89,9 @@ static inline bool bpf_has_stack_frame(struct codegen_context *ctx)
 	 * - the bpf program uses its stack area
 	 * The latter condition is deduced from the usage of BPF_REG_FP
 	 */
-	return ctx->seen & SEEN_FUNC || bpf_is_seen_register(ctx, bpf_to_ppc(BPF_REG_FP));
+	return ctx->seen & SEEN_FUNC ||
+	       bpf_is_seen_register(ctx, bpf_to_ppc(BPF_REG_FP)) ||
+	       ctx->exception_cb;
 }
 
 /*
@@ -161,8 +163,13 @@ void bpf_jit_build_prologue(u32 *image, struct codegen_context *ctx)
 		EMIT(PPC_RAW_LI(bpf_to_ppc(TMP_REG_1), 0));
 		/* this goes in the redzone */
 		EMIT(PPC_RAW_STD(bpf_to_ppc(TMP_REG_1), _R1, -(BPF_PPC_TAILCALL)));
-	} else {
+	} else if (!ctx->exception_cb) {
 		/*
+		 * Tailcall jitting for non exception_cb progs only.
+		 * exception_cb won't require tail_call_info to be setup.
+		 *
+		 * tail_call_info interpretation logic:
+		 *
 		 * if tail_call_info < MAX_TAIL_CALL_CNT
 		 *      main prog calling first subprog -> copy reference
 		 * else
@@ -177,8 +184,12 @@ void bpf_jit_build_prologue(u32 *image, struct codegen_context *ctx)
 		EMIT(PPC_RAW_STD(bpf_to_ppc(TMP_REG_1), _R1, -(BPF_PPC_TAILCALL)));
 	}
 
-	if (bpf_has_stack_frame(ctx)) {
+	if (bpf_has_stack_frame(ctx) && !ctx->exception_cb) {
 		/*
+		 * exception_cb uses boundary frame after stack walk.
+		 * It can simply use redzone, this optimization reduces
+		 * stack walk loop by one level.
+		 *
 		 * We need a stack frame, but we don't necessarily need to
 		 * save/restore LR unless we call other functions
 		 */
@@ -190,23 +201,35 @@ void bpf_jit_build_prologue(u32 *image, struct codegen_context *ctx)
 		EMIT(PPC_RAW_STDU(_R1, _R1, -(BPF_PPC_STACKFRAME + ctx->stack_size)));
 	}
 
-	/*
-	 * Back up non-volatile regs -- BPF registers 6-10
-	 * If we haven't created our own stack frame, we save these
-	 * in the protected zone below the previous stack frame
-	 */
-	for (i = BPF_REG_6; i <= BPF_REG_10; i++)
-		if (bpf_is_seen_register(ctx, bpf_to_ppc(i)))
-			EMIT(PPC_RAW_STD(bpf_to_ppc(i), _R1, bpf_jit_stack_offsetof(ctx, bpf_to_ppc(i))));
+	if (!ctx->exception_cb) {
+		/*
+		 * Back up non-volatile regs -- BPF registers 6-10
+		 * If we haven't created our own stack frame, we save these
+		 * in the protected zone below the previous stack frame
+		 */
+		for (i = BPF_REG_6; i <= BPF_REG_10; i++)
+			if (ctx->exception_boundary || bpf_is_seen_register(ctx, bpf_to_ppc(i)))
+				EMIT(PPC_RAW_STD(bpf_to_ppc(i), _R1,
+					bpf_jit_stack_offsetof(ctx, bpf_to_ppc(i))));
 
-	if (ctx->arena_vm_start)
-		EMIT(PPC_RAW_STD(bpf_to_ppc(ARENA_VM_START), _R1,
+		if (ctx->exception_boundary || ctx->arena_vm_start)
+			EMIT(PPC_RAW_STD(bpf_to_ppc(ARENA_VM_START), _R1,
 				 bpf_jit_stack_offsetof(ctx, bpf_to_ppc(ARENA_VM_START))));
+	} else {
+		/*
+		 * Exception callback receives Frame Pointer of boundary
+		 * program(main prog) as third arg
+		 */
+		EMIT(PPC_RAW_MR(_R1, _R5));
+	}
 
-	/* Setup frame pointer to point to the bpf stack area */
+	/*
+	 * Exception_cb not restricted from using stack area or arena.
+	 * Setup frame pointer to point to the bpf stack area
+	 */
 	if (bpf_is_seen_register(ctx, bpf_to_ppc(BPF_REG_FP)))
 		EMIT(PPC_RAW_ADDI(bpf_to_ppc(BPF_REG_FP), _R1,
-				STACK_FRAME_MIN_SIZE + ctx->stack_size));
+			STACK_FRAME_MIN_SIZE + ctx->stack_size));
 
 	if (ctx->arena_vm_start)
 		PPC_LI64(bpf_to_ppc(ARENA_VM_START), ctx->arena_vm_start);
@@ -218,17 +241,17 @@ static void bpf_jit_emit_common_epilogue(u32 *image, struct codegen_context *ctx
 
 	/* Restore NVRs */
 	for (i = BPF_REG_6; i <= BPF_REG_10; i++)
-		if (bpf_is_seen_register(ctx, bpf_to_ppc(i)))
+		if (ctx->exception_cb || bpf_is_seen_register(ctx, bpf_to_ppc(i)))
 			EMIT(PPC_RAW_LD(bpf_to_ppc(i), _R1, bpf_jit_stack_offsetof(ctx, bpf_to_ppc(i))));
 
-	if (ctx->arena_vm_start)
+	if (ctx->exception_cb || ctx->arena_vm_start)
 		EMIT(PPC_RAW_LD(bpf_to_ppc(ARENA_VM_START), _R1,
 				bpf_jit_stack_offsetof(ctx, bpf_to_ppc(ARENA_VM_START))));
 
 	/* Tear down our stack frame */
 	if (bpf_has_stack_frame(ctx)) {
 		EMIT(PPC_RAW_ADDI(_R1, _R1, BPF_PPC_STACKFRAME + ctx->stack_size));
-		if (ctx->seen & SEEN_FUNC) {
+		if (ctx->seen & SEEN_FUNC || ctx->exception_cb) {
 			EMIT(PPC_RAW_LD(_R0, _R1, PPC_LR_STKOFF));
 			EMIT(PPC_RAW_MTLR(_R0));
 		}
-- 
2.48.1

