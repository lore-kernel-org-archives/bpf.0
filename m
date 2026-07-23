Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FE903A5445;
	Thu, 23 Jul 2026 05:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784785323; cv=none; b=pw06EVx+pyQnI2Lb3wRiIp3OAUo+BaiQ1kowmxzGE8YJGwZ9Z7X5RhcK/PhGNRHe6E5hNufIxhBav/+q9IyOcQ4krO10+x18pY0HY1RCxbn2Jg7OsrtQltNqEnciHRlvM1rBAHGqXOIlROi0cQYfEm2BrsnAfDfyEo1moVoRzr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784785323; c=relaxed/simple;
	bh=sNbBrbNgL1DCvUesbsN84M4eYHPRqBcR/E53/mGivWk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dT2QnILSck5dIQVcc40vOSscDCffRI45YKalsilWOB6Uf/RsU6NDXy/nZd7kaMjqd0+Em7cIYNwKNbaqUGSjZDyAnc4/ynMKu9OwKNM036PEwoQZV+K5ysdN1Aydh1CMf4u4o4cKf4MvSIRMDWN1mwfp+B3WhzI1nkiXvaZG76s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 2e012e52865911f1aa26b74ffac11d73-20260723
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:acf894eb-d1fa-4853-9153-903f1dea7d32,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:e7bac3a,CLOUDID:5a4cc073e97d43289fcbe7c6e710344a,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:81|82|102|136|850|865|898,TC:nil,Content
	:0|15|50,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
	,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 2e012e52865911f1aa26b74ffac11d73-20260723
X-User: jiangfeng@kylinos.cn
Received: from [127.0.0.1] [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <jiangfeng@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1905472986; Thu, 23 Jul 2026 13:41:40 +0800
From: Feng Jiang <jiangfeng@kylinos.cn>
Date: Thu, 23 Jul 2026 05:41:32 +0000
Subject: [PATCH bpf-next v5 1/3] bpf, riscv: add support for timed may_goto
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260723-riscv-bpf-timed-may-goto-v5-1-86acb54e5642@kylinos.cn>
References: <20260723-riscv-bpf-timed-may-goto-v5-0-86acb54e5642@kylinos.cn>
In-Reply-To: <20260723-riscv-bpf-timed-may-goto-v5-0-86acb54e5642@kylinos.cn>
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 Emil Tsalapatis <emil@etsalapatis.com>, Luke Nelson <luke.r.nels@gmail.com>, 
 Xi Wang <xi.wang@gmail.com>, 
 =?utf-8?q?Bj=C3=B6rn_T=C3=B6pel?= <bjorn@kernel.org>, 
 Pu Lehui <pulehui@huawei.com>, Puranjay Mohan <puranjay@kernel.org>, 
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
 Shuah Khan <shuah@kernel.org>, Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: bpf@vger.kernel.org, linux-riscv@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Feng Jiang <jiangfeng@kylinos.cn>
X-Mailer: b4 0.14.3

Implement arch_bpf_timed_may_goto() for the RV64 JIT. The argument and
return value are carried in BPF_REG_AX, and BPF R0-R5 are preserved
across the call to the generic bpf_check_timed_may_goto().

Enable bpf_jit_supports_timed_may_goto() so the verifier uses the timed
expansion path.

Signed-off-by: Feng Jiang <jiangfeng@kylinos.cn>
---
 arch/riscv/net/Makefile             |  2 +-
 arch/riscv/net/bpf_jit_comp64.c     | 12 +++++++++-
 arch/riscv/net/bpf_timed_may_goto.S | 47 +++++++++++++++++++++++++++++++++++++
 3 files changed, 59 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/net/Makefile b/arch/riscv/net/Makefile
index 9a1e5f0a94e5..6458d4d51990 100644
--- a/arch/riscv/net/Makefile
+++ b/arch/riscv/net/Makefile
@@ -3,7 +3,7 @@
 obj-$(CONFIG_BPF_JIT) += bpf_jit_core.o
 
 ifeq ($(CONFIG_ARCH_RV64I),y)
-	obj-$(CONFIG_BPF_JIT) += bpf_jit_comp64.o
+	obj-$(CONFIG_BPF_JIT) += bpf_jit_comp64.o bpf_timed_may_goto.o
 else
 	obj-$(CONFIG_BPF_JIT) += bpf_jit_comp32.o
 endif
diff --git a/arch/riscv/net/bpf_jit_comp64.c b/arch/riscv/net/bpf_jit_comp64.c
index ad089a9a4ea9..8fe8969fb8a0 100644
--- a/arch/riscv/net/bpf_jit_comp64.c
+++ b/arch/riscv/net/bpf_jit_comp64.c
@@ -1841,7 +1841,12 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn, struct rv_jit_context *ctx,
 		if (aux->tail_call_reachable && insn->src_reg == BPF_PSEUDO_CALL)
 			emit_sd(RV_REG_SP, ctx->tcc_offset, RV_REG_TCC, ctx);
 
-		if (insn->src_reg != BPF_PSEUDO_CALL)
+		/*
+		 * arch_bpf_timed_may_goto() is emitted by the verifier and
+		 * returns its result in BPF_REG_AX instead of BPF_REG_0, so
+		 * skip the normal "move return register into R0".
+		 */
+		if (insn->src_reg != BPF_PSEUDO_CALL && addr != (u64)arch_bpf_timed_may_goto)
 			emit_mv(bpf_to_rv_reg(BPF_REG_0, ctx), RV_REG_A0, ctx);
 		break;
 	}
@@ -2161,3 +2166,8 @@ bool bpf_jit_supports_subprog_tailcalls(void)
 {
 	return true;
 }
+
+bool bpf_jit_supports_timed_may_goto(void)
+{
+	return true;
+}
diff --git a/arch/riscv/net/bpf_timed_may_goto.S b/arch/riscv/net/bpf_timed_may_goto.S
new file mode 100644
index 000000000000..02c637d87420
--- /dev/null
+++ b/arch/riscv/net/bpf_timed_may_goto.S
@@ -0,0 +1,47 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (c) 2026 Feng Jiang <jiangfeng@kylinos.cn> */
+
+#include <linux/linkage.h>
+#include <asm/asm.h>
+
+/*
+ * Trampoline for the BPF timed may_goto loop bound. Custom calling convention:
+ *	- input:  stack offset in BPF_REG_AX (t0)
+ *	- output: updated count in BPF_REG_AX (t0)
+ *
+ * Calls bpf_check_timed_may_goto(ptr) with the standard RISC-V ABI, where
+ * ptr = BPF_REG_FP (s5) + BPF_REG_AX (t0). BPF R0-R5 (a5, a0-a4) are saved
+ * across the call; BPF_REG_FP (s5) is callee-saved and needs no saving.
+ */
+
+SYM_FUNC_START(arch_bpf_timed_may_goto)
+	addi	sp, sp, -(8*SZREG)
+	REG_S	ra, 7*SZREG(sp)
+	REG_S	s0, 6*SZREG(sp)
+	addi	s0, sp, 8*SZREG
+
+	/* Save BPF registers R0-R5 (a5, a0-a4) */
+	REG_S	a5, 5*SZREG(sp)
+	REG_S	a0, 4*SZREG(sp)
+	REG_S	a1, 3*SZREG(sp)
+	REG_S	a2, 2*SZREG(sp)
+	REG_S	a3, 1*SZREG(sp)
+	REG_S	a4, 0*SZREG(sp)
+
+	add	a0, t0, s5
+	call	bpf_check_timed_may_goto
+	mv	t0, a0
+
+	/* Restore BPF registers R0-R5 */
+	REG_L	a4, 0*SZREG(sp)
+	REG_L	a3, 1*SZREG(sp)
+	REG_L	a2, 2*SZREG(sp)
+	REG_L	a1, 3*SZREG(sp)
+	REG_L	a0, 4*SZREG(sp)
+	REG_L	a5, 5*SZREG(sp)
+
+	REG_L	s0, 6*SZREG(sp)
+	REG_L	ra, 7*SZREG(sp)
+	addi	sp, sp, 8*SZREG
+	ret
+SYM_FUNC_END(arch_bpf_timed_may_goto)

-- 
2.53.0

