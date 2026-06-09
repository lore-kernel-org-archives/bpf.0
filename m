Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D9BE271471
	for <bpf@vger.kernel.org>; Tue,  9 Jun 2026 04:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780978549; cv=none; b=A5z2bcQoCMyusSyMcsvesSwjdKXVpACQEK1iDAABeHIpoR5RbMMRoKBDihWDNV7rANT5sWP9EnL2P9EXLpMIg9gpa9N3P/JGBxlOf8Q/g28wvUm4uw1hr+QG3eJvmkdEi8kdlUFhQinyluOpDPo5YpL8tsIfjGbFW5xIdY22JkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780978549; c=relaxed/simple;
	bh=dx7gFPht/W9l9YvdNWrRjXh3WMPbekq1t0fZlRS7OsI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=reHbbPwaWijY8Mw6Y/J6YLchH5WbO96FVg26Nzy9czZCP3/bRGJhdPvVHJrDeWZ5dKos+yianMuZs0SqmcuEAINWoIshkwFqt8m6QiIA0yFvDsC4uqd36UxJCItrMFXpq36deowYWtSilNRIwtmfNlzjaaJAC0vILjRFIGWbAmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=wA1yVL3I; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="wA1yVL3I"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780978545;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E9K8DKQzuZY5lkKWGM48eNIzslFzSc/uOU/tK45gZds=;
	b=wA1yVL3IBn/vFFV+TZzzySp5wd839U2zorkWa78WxvpHMqQn3mPH4cArsvkkRP5y5mByoB
	zPB0ArtKJzrdERucUWstCPqEN791d5OMGUYLbrgQsnMMDEDYquQuKrbmO91y+5bfBFXIyx
	ERb9HTwSnoovnldwM0ZEP5n88lM0gyU=
From: George Guo <dongtai.guo@linux.dev>
To: Huacai Chen <chenhuacai@kernel.org>,
	Tiezhu Yang <yangtiezhu@loongson.cn>,
	Hengqi Chen <hengqi.chen@gmail.com>
Cc: WANG Xuerui <kernel@xen0n.name>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	loongarch@lists.linux.dev,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	George Guo <guodongtai@kylinos.cn>
Subject: [PATCH v1 2/2] LoongArch: BPF: Add timed may_goto support
Date: Tue,  9 Jun 2026 12:14:07 +0800
Message-Id: <20260609041407.122384-3-dongtai.guo@linux.dev>
In-Reply-To: <20260609041407.122384-1-dongtai.guo@linux.dev>
References: <20260609041407.122384-1-dongtai.guo@linux.dev>
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

arch_bpf_timed_may_goto() is called with a custom calling convention.
The verifier passes the stack offset of the count/timestamp pair in
BPF_REG_AX ($t0) and expects the updated count back in the same
register, so the stub adds the offset to BPF_REG_FP ($s4), calls
bpf_check_timed_may_goto(), and moves the result back into $t0 while
preserving the BPF caller-saved registers R0 - R5. The JIT call path is
updated to skip the usual 'BPF_REG_0 = C return value' move for this
helper since its result is delivered in BPF_REG_AX instead.

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
index 20d5bf792108..794c0c37fa9c 100644
--- a/arch/loongarch/net/bpf_jit.c
+++ b/arch/loongarch/net/bpf_jit.c
@@ -1185,7 +1185,13 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx, bool ext
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
@@ -2376,6 +2382,11 @@ bool bpf_jit_supports_percpu_insn(void)
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
index 000000000000..aa86250a9c65
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
+	st.d		ra, sp, 0
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
+	ld.d		ra, sp, 0
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

