Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2BB346C855
	for <bpf@vger.kernel.org>; Tue,  4 Aug 2026 15:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785858415; cv=none; b=CueICeUkNReaTVVAMCwemCxnllPRJzRF2FGaY0Ojy0jSpddgUiIp0YkMrtCSGsEotqzIOU3dYlBBLjQGR0gAOjVmIdZgBV9CK9sSL9b4MwNFRIxNtBPxWUh000Ue3EXdn/gh0EM/WBE2QE9+YtadH3zT9kVMPQ6HG++J/5WrXp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785858415; c=relaxed/simple;
	bh=UkvTxU0c2KcE5jFeR4XX4JR57uXmgvH73AtGAwrlKzk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ERBF6hodMFHhsQ+c5VR6EdWoN7PUraSOESsI1H2HEnMnF9e5ISA+r9tteRKpIK7omz6UuYGBRteRGcx3w3SK8z40WVsryvUDn6G5PzWL/dfBu8Hg7SsSkoJzSw+8+7n32xfdtbcdB4ltxuDfp7ikA1n8bAAUYpopWfrnNO9k/D0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=LNUCVGYZ; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="LNUCVGYZ"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1785858411;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oSVnprZ4KaeR41KPt5lEBSjzlm/HBklaQ8jOsYV0o8o=;
	b=LNUCVGYZQoKtwmckWUWCwzkQLC4YE4zGBIc+sDZXx9efG8Y+xVIKWJjX/dyltbrzSnGT96
	5og8lI3TFw6JTfzEjGuxfT+cObKohK0AuTu02VVcMRIp8DWNKVkYYkkra8fmMHY3V0B8ie
	RWZs5cV1shBDakXFQzWNqQArlOP5iZs=
From: George Guo <dongtai.guo@linux.dev>
To: chenhuacai@kernel.org,
	yangtiezhu@loongson.cn,
	hengqi.chen@gmail.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org
Cc: kernel@xen0n.name,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	memxor@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	guodongtai@kylinos.cn,
	bpf@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/2] LoongArch: BPF: Add timed may_goto support
Date: Tue,  4 Aug 2026 23:39:38 +0800
Message-ID: <20260804153938.16129-3-dongtai.guo@linux.dev>
In-Reply-To: <20260804153938.16129-1-dongtai.guo@linux.dev>
References: <20260804153938.16129-1-dongtai.guo@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: George Guo <guodongtai@kylinos.cn>

Implement arch_bpf_timed_may_goto() and advertise it through
bpf_jit_supports_timed_may_goto() so the verifier lowers may_goto into
the timed variant: instead of a fixed iteration counter, the loop is
bounded by a wall-clock timeout maintained in a per-loop stack slot.

arch_bpf_timed_may_goto() uses a custom calling convention: the verifier
passes the count/timestamp stack offset in BPF_REG_AX and expects the
updated count back in the same register. The JIT call path therefore skips
the usual 'BPF_REG_0 = C return value' move for this helper.

Signed-off-by: George Guo <guodongtai@kylinos.cn>
---
 arch/loongarch/net/Makefile             |  2 +-
 arch/loongarch/net/bpf_jit.c            | 13 ++++++-
 arch/loongarch/net/bpf_timed_may_goto.S | 47 +++++++++++++++++++++++++
 3 files changed, 60 insertions(+), 2 deletions(-)
 create mode 100644 arch/loongarch/net/bpf_timed_may_goto.S

diff --git a/arch/loongarch/net/Makefile b/arch/loongarch/net/Makefile
index 1ec12a0c324a..8d9ddb48f9ea 100644
--- a/arch/loongarch/net/Makefile
+++ b/arch/loongarch/net/Makefile
@@ -4,4 +4,4 @@
 #
 # Copyright (C) 2022 Loongson Technology Corporation Limited
 #
-obj-$(CONFIG_BPF_JIT) += bpf_jit.o
+obj-$(CONFIG_BPF_JIT) += bpf_jit.o bpf_timed_may_goto.o
diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bpf_jit.c
index b8dd956d46bd..004a139e0f49 100644
--- a/arch/loongarch/net/bpf_jit.c
+++ b/arch/loongarch/net/bpf_jit.c
@@ -1192,7 +1192,13 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx, bool ext
 		move_addr(ctx, t1, func_addr);
 		emit_insn(ctx, jirl, LOONGARCH_GPR_RA, t1, 0);
 
-		if (insn->src_reg != BPF_PSEUDO_CALL)
+		/*
+		 * Call to arch_bpf_timed_may_goto() uses a custom calling
+		 * convention with the argument and return value in BPF_REG_AX,
+		 * so skip moving the C return value into BPF_REG_0.
+		 */
+		if (insn->src_reg != BPF_PSEUDO_CALL &&
+		    func_addr != (u64)arch_bpf_timed_may_goto)
 			move_reg(ctx, regmap[BPF_REG_0], LOONGARCH_GPR_A0);
 
 		break;
@@ -2390,6 +2396,11 @@ bool bpf_jit_supports_percpu_insn(void)
 	return true;
 }
 
+bool bpf_jit_supports_timed_may_goto(void)
+{
+	return true;
+}
+
 /* Indicate the JIT backend supports mixing bpf2bpf and tailcalls. */
 bool bpf_jit_supports_subprog_tailcalls(void)
 {
diff --git a/arch/loongarch/net/bpf_timed_may_goto.S b/arch/loongarch/net/bpf_timed_may_goto.S
new file mode 100644
index 000000000000..8a4c15418998
--- /dev/null
+++ b/arch/loongarch/net/bpf_timed_may_goto.S
@@ -0,0 +1,47 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Author: George Guo <guodongtai@kylinos.cn>
+ * Copyright (C) 2026 KylinSoft Corporation.
+ */
+
+#include <asm/asmmacro.h>
+#include <asm/regdef.h>
+#include <linux/export.h>
+#include <linux/linkage.h>
+
+SYM_FUNC_START(arch_bpf_timed_may_goto)
+	addi.d		sp, sp, -64
+	st.d		ra, sp, 56
+
+	/* Save BPF registers R0 - R5 (a5, a0 - a4) */
+	st.d		a5, sp, 8
+	st.d		a0, sp, 16
+	st.d		a1, sp, 24
+	st.d		a2, sp, 32
+	st.d		a3, sp, 40
+	st.d		a4, sp, 48
+
+	/*
+	 * BPF_REG_AX (t0) holds the offset passed in by the verifier; add it
+	 * to BPF_REG_FP (s4) to get the pointer to the count and timestamp,
+	 * then pass it as the first argument in a0.
+	 *
+	 * The verifier emits a load using FP right before this call, so
+	 * BPF_REG_FP (s4) is always set up by the JIT in this case.
+	 */
+	add.d		a0, t0, s4
+	bl		bpf_check_timed_may_goto
+	/* BPF_REG_AX (t0) will be stored into count, so move the return value to it. */
+	move		t0, a0
+
+	ld.d		ra, sp, 56
+	ld.d		a5, sp, 8
+	ld.d		a0, sp, 16
+	ld.d		a1, sp, 24
+	ld.d		a2, sp, 32
+	ld.d		a3, sp, 40
+	ld.d		a4, sp, 48
+	addi.d		sp, sp, 64
+
+	jr		ra
+SYM_FUNC_END(arch_bpf_timed_may_goto)
-- 
2.53.0

