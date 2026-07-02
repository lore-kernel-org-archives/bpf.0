Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F01F53019DC
	for <bpf@vger.kernel.org>; Thu,  2 Jul 2026 02:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782959080; cv=none; b=UIeTFtVouOo+pp7AlQcERU3SKT6sujjNM4T0912x44gpVt5rZ3t+1Q5Up20gdT2r+CUC4sHYqSbTe+hL5toxjO+aupVZYn6RU5S6Pae+bHbYq1ke0w6sgjTz/NFshdnGL1Z1LYICBxrUlq2z9lGvkhIKDy3mriWGXdQ1wqAcdDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782959080; c=relaxed/simple;
	bh=bTc+6+MU3AieKzk7mlwNK0uCeTNHZ3qAtx1qWHhjn7E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CPCLEiEpd8F/8/RIEav6eeYU1h2tI4rFEZZ4hUUj+cgaX75vUhPogXS0kP7OJP+lDqsv5mUlRsJVzy6WspQDQql/7xgll+PUEhvtD9LRBA/vxHlobWKfVOcPI+5AUa49sZwWnVpf0yfYZParKktfd4WOrRbsFDUOnEBzEvnhJ2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Wxt1il90; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Wxt1il90"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782959067;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZBqzt++b2Rtqd7Ud6I1gpN0Fo7cumb2X1wVjVk4svFU=;
	b=Wxt1il90E7IvBSyN4tqjVovsMLtNT7F3+nPCIGefmyICIqZAcvnMt9YV1GSjboBBQ5zz9Z
	K3mxxuFmt7dpaVGleZa43aW7AI6ajX74Ia/EUjVXZ7WxJX3ZeYkogbKltE4fLsBFxeepx3
	6KgZhkKWyq9/hS97JbAw4bDQnR+yecA=
From: George Guo <dongtai.guo@linux.dev>
To: Huacai Chen <chenhuacai@kernel.org>,
	Tiezhu Yang <yangtiezhu@loongson.cn>,
	Hengqi Chen <hengqi.chen@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: WANG Xuerui <kernel@xen0n.name>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	George Guo <guodongtai@kylinos.cn>,
	bpf@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v2 03/11] LoongArch: BPF: Add timed may_goto support
Date: Thu,  2 Jul 2026 10:23:14 +0800
Message-Id: <20260702022322.51033-4-dongtai.guo@linux.dev>
In-Reply-To: <20260702022322.51033-1-dongtai.guo@linux.dev>
References: <20260702022322.51033-1-dongtai.guo@linux.dev>
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
index b4208fa3a242..bb84b985cb45 100644
--- a/arch/loongarch/net/bpf_jit.c
+++ b/arch/loongarch/net/bpf_jit.c
@@ -1229,7 +1229,13 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx, bool ext
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
@@ -2420,6 +2426,11 @@ bool bpf_jit_supports_percpu_insn(void)
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
2.25.1

