Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F386515EA6
	for <bpf@vger.kernel.org>; Thu,  4 Apr 2024 21:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712267142; cv=none; b=pbNDoGDtcboNpfQQyXDVPTo18n42LDEEDZLvVaD88etR6OeURHKPP28GWj113iRNOP4oXPq0zuE22lJ7D5hu3eb7xMcB2EwPjVMMOLqDUest2i7JRU1IGNswtVjPNaTIZy3egVmiTUYYoo7ika7hewE7bKEbSKs4sV17vrh2ZXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712267142; c=relaxed/simple;
	bh=EwBBFFczqE2hNXmrpOsf2p7b/I+0r+2KT4NIrmjNPBA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sp+7YHW9LxJ8wE6wcOWq8eKOFIOEQeOB7Ng9olBwbUr2hc9w/WRLD+7uoJRFPTbppoOQ9tucDHfsFcZlA9zVVlGmygCqwIaPh56Fo9ar4aPsMRtadsGn4cHCPOQQuRSP1Xr6Yo3vzbqw/iSO2wShFxPU46sqLjsGXSUTqv1dc/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tTi3XzM5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tTi3XzM5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7764FC433C7;
	Thu,  4 Apr 2024 21:45:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712267141;
	bh=EwBBFFczqE2hNXmrpOsf2p7b/I+0r+2KT4NIrmjNPBA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tTi3XzM52iHFW78a1k+G/SOAWdQMEkiduxfgcEjf/tvU6pYiCgK94uLxzBBFu8bkl
	 moFMizOCD/kRCGoCJ11xrQQDEmL/NJ7QSIWBPROvmHH58UDJZvsdfUg/sZ5fw5M9Vw
	 H8U75q3nH6Hyj6dMoAhCsPZCQMkTfgvSwXIvBgr8lp5obydBOERtZNjnyyJxIwitsm
	 //sC3e78hTwMfvCOllNXwRoqECKQ6QDz6pxfVHov7HSFC6mXIFkslNcSK7GZ6hPUfo
	 sAX9pT1NnZ9ISUD8kw4KECf0CQFq7apa5WwxRhQioc3CLXy30jXc8C14U25iA8y20M
	 MaPoMXzyW0+wQ==
From: Andrii Nakryiko <andrii@kernel.org>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@kernel.org
Cc: andrii@kernel.org,
	kernel-team@meta.com,
	syzbot+148110ee7cf72f39f33e@syzkaller.appspotmail.com
Subject: [PATCH v2 bpf-next 2/2] selftests/bpf: add fp-leaking precise subprog result tests
Date: Thu,  4 Apr 2024 14:45:36 -0700
Message-ID: <20240404214536.3551295-2-andrii@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240404214536.3551295-1-andrii@kernel.org>
References: <20240404214536.3551295-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add selftests validating that BPF verifier handles precision marking
for SCALAR registers derived from r10 (fp) register correctly.

Given `r0 = (s8)r10;` syntax is not supported by older Clang compilers,
use the raw BPF instruction syntax to maximize compatibility.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/include/linux/filter.h                  | 18 ++++
 .../bpf/progs/verifier_subprog_precision.c    | 89 +++++++++++++++++++
 2 files changed, 107 insertions(+)

diff --git a/tools/include/linux/filter.h b/tools/include/linux/filter.h
index 736bdeccdfe4..65aa8ce142e5 100644
--- a/tools/include/linux/filter.h
+++ b/tools/include/linux/filter.h
@@ -111,6 +111,24 @@
 		.off   = 0,					\
 		.imm   = IMM })
 
+/* Short form of movsx, dst_reg = (s8,s16,s32)src_reg */
+
+#define BPF_MOVSX64_REG(DST, SRC, OFF)				\
+	((struct bpf_insn) {					\
+		.code  = BPF_ALU64 | BPF_MOV | BPF_X,		\
+		.dst_reg = DST,					\
+		.src_reg = SRC,					\
+		.off   = OFF,					\
+		.imm   = 0 })
+
+#define BPF_MOVSX32_REG(DST, SRC, OFF)				\
+	((struct bpf_insn) {					\
+		.code  = BPF_ALU | BPF_MOV | BPF_X,		\
+		.dst_reg = DST,					\
+		.src_reg = SRC,					\
+		.off   = OFF,					\
+		.imm   = 0 })
+
 /* Short form of mov based on type,  BPF_X: dst_reg = src_reg, BPF_K: dst_reg = imm32 */
 
 #define BPF_MOV64_RAW(TYPE, DST, SRC, IMM)			\
diff --git a/tools/testing/selftests/bpf/progs/verifier_subprog_precision.c b/tools/testing/selftests/bpf/progs/verifier_subprog_precision.c
index 6f5d19665cf6..4a58e0398e72 100644
--- a/tools/testing/selftests/bpf/progs/verifier_subprog_precision.c
+++ b/tools/testing/selftests/bpf/progs/verifier_subprog_precision.c
@@ -6,6 +6,7 @@
 #include <linux/bpf.h>
 #include <bpf/bpf_helpers.h>
 #include "bpf_misc.h"
+#include <../../../tools/include/linux/filter.h>
 
 #define ARRAY_SIZE(x) (sizeof(x) / sizeof(x[0]))
 
@@ -76,6 +77,94 @@ __naked int subprog_result_precise(void)
 	);
 }
 
+__naked __noinline __used
+static unsigned long fp_leaking_subprog()
+{
+	asm volatile (
+		".8byte %[r0_eq_r10_cast_s8];"
+		"exit;"
+		:: __imm_insn(r0_eq_r10_cast_s8, BPF_MOVSX64_REG(BPF_REG_0, BPF_REG_10, 8))
+	);
+}
+
+__naked __noinline __used
+static unsigned long sneaky_fp_leaking_subprog()
+{
+	asm volatile (
+		"r1 = r10;"
+		".8byte %[r0_eq_r1_cast_s8];"
+		"exit;"
+		:: __imm_insn(r0_eq_r1_cast_s8, BPF_MOVSX64_REG(BPF_REG_0, BPF_REG_1, 8))
+	);
+}
+
+SEC("?raw_tp")
+__success __log_level(2)
+__msg("6: (0f) r1 += r0")
+__msg("mark_precise: frame0: last_idx 6 first_idx 0 subseq_idx -1")
+__msg("mark_precise: frame0: regs=r0 stack= before 5: (bf) r1 = r6")
+__msg("mark_precise: frame0: regs=r0 stack= before 4: (27) r0 *= 4")
+__msg("mark_precise: frame0: regs=r0 stack= before 3: (57) r0 &= 3")
+__msg("mark_precise: frame0: regs=r0 stack= before 10: (95) exit")
+__msg("mark_precise: frame1: regs=r0 stack= before 9: (bf) r0 = (s8)r10")
+__msg("7: R0_w=scalar")
+__naked int fp_precise_subprog_result(void)
+{
+	asm volatile (
+		"call fp_leaking_subprog;"
+		/* use subprog's returned value (which is derived from r10=fp
+		 * register), as index into vals array, forcing all of that to
+		 * be known precisely
+		 */
+		"r0 &= 3;"
+		"r0 *= 4;"
+		"r1 = %[vals];"
+		/* force precision marking */
+		"r1 += r0;"
+		"r0 = *(u32 *)(r1 + 0);"
+		"exit;"
+		:
+		: __imm_ptr(vals)
+		: __clobber_common
+	);
+}
+
+SEC("?raw_tp")
+__success __log_level(2)
+__msg("6: (0f) r1 += r0")
+__msg("mark_precise: frame0: last_idx 6 first_idx 0 subseq_idx -1")
+__msg("mark_precise: frame0: regs=r0 stack= before 5: (bf) r1 = r6")
+__msg("mark_precise: frame0: regs=r0 stack= before 4: (27) r0 *= 4")
+__msg("mark_precise: frame0: regs=r0 stack= before 3: (57) r0 &= 3")
+__msg("mark_precise: frame0: regs=r0 stack= before 11: (95) exit")
+__msg("mark_precise: frame1: regs=r0 stack= before 10: (bf) r0 = (s8)r1")
+/* here r1 is marked precise, even though it's fp register, but that's fine
+ * because by the time we get out of subprogram it has to be derived from r10
+ * anyways, at which point we'll break precision chain
+ */
+__msg("mark_precise: frame1: regs=r1 stack= before 9: (bf) r1 = r10")
+__msg("7: R0_w=scalar")
+__naked int sneaky_fp_precise_subprog_result(void)
+{
+	asm volatile (
+		"call sneaky_fp_leaking_subprog;"
+		/* use subprog's returned value (which is derived from r10=fp
+		 * register), as index into vals array, forcing all of that to
+		 * be known precisely
+		 */
+		"r0 &= 3;"
+		"r0 *= 4;"
+		"r1 = %[vals];"
+		/* force precision marking */
+		"r1 += r0;"
+		"r0 = *(u32 *)(r1 + 0);"
+		"exit;"
+		:
+		: __imm_ptr(vals)
+		: __clobber_common
+	);
+}
+
 SEC("?raw_tp")
 __success __log_level(2)
 __msg("9: (0f) r1 += r0")
-- 
2.43.0

