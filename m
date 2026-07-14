Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C4843BF684;
	Tue, 14 Jul 2026 12:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784031403; cv=none; b=GIWWEA6FjgiVoTWxmCz95w0FYd/dO1zDCp+4tBSSUuss9fuzN3LE2nUcuZY6LqiQvog57U19jftdVY5xgPUd1DbOkDypHi/Q4vGmJGjafjBA0y6Y7O+96zqhtKPtx3FIP5k0s036iBqwSKddu+Y4MjPabL7ibFwDnJp71VXSTCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784031403; c=relaxed/simple;
	bh=Elt5MKAY55ZX4mcbRsImPgbrsAPseQfnz74J6UKmSks=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FeXtjGtMi7s/1AjHZ7r8mTSOSwUPiKyoSeturNhYg3apEtZk8z8MUXSwFJlnoL4CAxGLEk4Z2rcv/qqZJMNtfyh0HyQzJb7dhxmMO53G0eOMGBn7I5oVmk42fwj0sdD2hOhmSTCRVg+syla36q+DaCZ2VCi1QGykLzq9/LyJJHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: d38b56787f7d11f1aa26b74ffac11d73-20260714
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:298d5829-ba20-455e-a0e3-656ecc3f1cf2,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:e7bac3a,CLOUDID:622c0acc96050cf769b2fdd8b8619630,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:81|82|102|136|850|865|898,TC:nil,Content
	:0|15|50,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
	,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: d38b56787f7d11f1aa26b74ffac11d73-20260714
X-User: jiangfeng@kylinos.cn
Received: from [127.0.0.1] [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <jiangfeng@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 827933751; Tue, 14 Jul 2026 20:16:22 +0800
From: Feng Jiang <jiangfeng@kylinos.cn>
Date: Tue, 14 Jul 2026 20:16:15 +0800
Subject: [PATCH v2 1/2] bpf, riscv: add support for timed may_goto
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260714-riscv-bpf-timed-may-goto-v2-1-eeb6201aedcc@kylinos.cn>
References: <20260714-riscv-bpf-timed-may-goto-v2-0-eeb6201aedcc@kylinos.cn>
In-Reply-To: <20260714-riscv-bpf-timed-may-goto-v2-0-eeb6201aedcc@kylinos.cn>
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 Emil Tsalapatis <emil@etsalapatis.com>, 
 =?utf-8?q?Bj=C3=B6rn_T=C3=B6pel?= <bjorn@kernel.org>, 
 Pu Lehui <pulehui@huawei.com>, Puranjay Mohan <puranjay@kernel.org>, 
 Luke Nelson <luke.r.nels@gmail.com>, Xi Wang <xi.wang@gmail.com>, 
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
 Shuah Khan <shuah@kernel.org>
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
 arch/riscv/net/bpf_jit_comp64.c     | 13 ++++++++++-
 arch/riscv/net/bpf_timed_may_goto.S | 44 +++++++++++++++++++++++++++++++++++++
 3 files changed, 57 insertions(+), 2 deletions(-)

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
index c03c1de16b79..4f88a446278a 100644
--- a/arch/riscv/net/bpf_jit_comp64.c
+++ b/arch/riscv/net/bpf_jit_comp64.c
@@ -1841,7 +1841,13 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn, struct rv_jit_context *ctx,
 		if (ret)
 			return ret;
 
-		if (insn->src_reg != BPF_PSEUDO_CALL)
+		/*
+		 * arch_bpf_timed_may_goto() is emitted by the verifier and
+		 * returns its result in BPF_REG_AX instead of BPF_REG_0, so
+		 * skip the normal "move return register into R0".
+		 */
+		if (insn->src_reg != BPF_PSEUDO_CALL &&
+		    addr != (u64)arch_bpf_timed_may_goto)
 			emit_mv(bpf_to_rv_reg(BPF_REG_0, ctx), RV_REG_A0, ctx);
 		break;
 	}
@@ -2157,3 +2163,8 @@ bool bpf_jit_supports_fsession(void)
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
index 000000000000..f54f389d921e
--- /dev/null
+++ b/arch/riscv/net/bpf_timed_may_goto.S
@@ -0,0 +1,44 @@
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
+	addi	sp, sp, -64
+	sd	ra, 56(sp)
+
+	/* Save BPF registers R0-R5 (a5, a0-a4) */
+	sd	a5, 48(sp)
+	sd	a0, 40(sp)
+	sd	a1, 32(sp)
+	sd	a2, 24(sp)
+	sd	a3, 16(sp)
+	sd	a4, 8(sp)
+
+	add	a0, t0, s5
+	call	bpf_check_timed_may_goto
+	mv	t0, a0
+
+	/* Restore BPF registers R0-R5 */
+	ld	a4, 8(sp)
+	ld	a3, 16(sp)
+	ld	a2, 24(sp)
+	ld	a1, 32(sp)
+	ld	a0, 40(sp)
+	ld	a5, 48(sp)
+
+	ld	ra, 56(sp)
+	addi	sp, sp, 64
+	ret
+SYM_FUNC_END(arch_bpf_timed_may_goto)

-- 
2.25.1

