Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 527A538888C
	for <bpf@vger.kernel.org>; Wed,  2 Sep 2026 07:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.164.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788332801; cv=none; b=Y3sSIZH6uwAduUyZYO+vk3GPfed1HFhwXvoHOOcYjy1vOKsfon9wYrFqW0NGujy147l73hrBUXlhRX/W1DpwW3CpaWgOT1+s4KV6Z8mVJ9Fr7bkUAtrZlATpdjoDqnkP5sTlcUfDiaJR587N5xao9Hwv1tQ7XCN17ZKS7HNVxw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788332801; c=relaxed/simple;
	bh=Fj4ab1ZbuBI+egQcZqkssPzRcV2zp9jxsRD+Oniv/sc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wf4ubqKiO6Y5Hjnxw5bRH8OXU7XftLpNIIX6D8pQHdI8fCZHgygdkEQMPLe7Hy7TC/DjurYM8p9Pv4DZ7x1QuQYtN+h2q3XhaL5ZM+jovgGw2KwlqGGHhR+rnDAz3HbByN5ZSbaSuclp+ayE9fMODQW5EQox7e/0H8ZaYtybhwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=162.243.164.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from zju.edu.cn (unknown [10.14.28.207])
	by mtasvr (Coremail) with SMTP id _____wDnkjzfypdqGxXjAA--.11283S3;
	Wed, 02 Sep 2026 15:06:07 +0800 (CST)
Received: from lutetium.tail477849.ts.net (unknown [10.14.28.207])
	by mail-app2 (Coremail) with SMTP id zC_KCgCnF83eypdqBR5IBA--.54450S2;
	Wed, 02 Sep 2026 15:06:06 +0800 (CST)
From: Yazhou Tang <tangyazhou@zju.edu.cn>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	eddyz87@gmail.com
Cc: daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	tangyazhou518@outlook.com,
	shenghaoyuan0928@163.com,
	ziye@zju.edu.cn
Subject: [RFC PATCH bpf-next 3/6] bpf: Reject UHMUL/SHMUL in unsupported JITs
Date: Wed,  2 Sep 2026 15:05:31 +0800
Message-ID: <20260902070534.2141812-4-tangyazhou@zju.edu.cn>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260902070534.2141812-1-tangyazhou@zju.edu.cn>
References: <20260902070534.2141812-1-tangyazhou@zju.edu.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zC_KCgCnF83eypdqBR5IBA--.54450S2
X-CM-SenderInfo: qssvjiasrsq6lmxovvfxof0/1tbiAhECCmqXKpkZ+wAAs3
X-CM-DELIVERINFO: =?B?nNUS1wXKKxbFmtjJiESix3B1w3vD7IpoGYuur0o+r46DyAi5OfOO+T4vrW4FyUBIyu
	9q9Kedt9TgU4vPvYZ+hKALaYeKGS1SY4FqKIIUO3CcMlqq+a6+EkLKhdawR/ZWU7CXSnEn
	A6DnKKIoHwp52yKM1GuSZ/Piop57DUhvU1FR+68CHIFdJkXjPQIhAJZKOW4u2g==
X-Coremail-Antispam: 1Uk129KBj93XoW3KFy8uF4kXFy5JFWrCF15GFX_yoWDCF4UpF
	4kArn3Cr4vgw48XFykJa97Zr1UtF40ga17CFyj9ayfAanFqr9xXF1fKw15ArZ8ArWUX3WF
	qFWY9r1qk34kXacCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUU9Eb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Cr1j6rxdM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I
	8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AK
	xVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7xvr2IYc2Ij64
	vIr40E4x8a64kEw24lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2Ij64vIr41l4I8I
	3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxV
	WUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAF
	wI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwCI42IY6xAIw20EY4v20x
	vaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8
	JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU1iZ23UUUUU==

From: Yazhou Tang <tangyazhou518@outlook.com>

CPU JIT backends currently lower BPF_MUL based on the opcode without
examining insn->off. Once the verifier accepts UHMUL and SHMUL, a backend
without explicit support would therefore lower either variant as the
existing low-half multiplication and silently produce the wrong result.

Reject UHMUL and SHMUL in each affected CPU JIT without native support,
using its existing unsupported-instruction path. This makes JIT compilation
fail cleanly instead of emitting an incorrect low-half multiply, and allows
the normal interpreter fallback when available.

The NFP hardware offload compiler has the same opcode-only dispatch:
BPF_ALU64 MUL instructions are routed to mul_reg64() or mul_imm64()
without considering insn->off. Reject UHMUL and SHMUL in the NFP offload
verifier as well, before they can reach the ordinary multiplication lowering.

Signed-off-by: Yazhou Tang <tangyazhou518@outlook.com>
Co-developed-by: Tianci Cao <ziye@zju.edu.cn>
Signed-off-by: Tianci Cao <ziye@zju.edu.cn>
Co-developed-by: Shenghao Yuan <shenghaoyuan0928@163.com>
Signed-off-by: Shenghao Yuan <shenghaoyuan0928@163.com>
---
 arch/arc/net/bpf_jit_core.c                       | 3 +++
 arch/arm/net/bpf_jit_32.c                         | 3 +++
 arch/arm64/net/bpf_jit_comp.c                     | 3 +++
 arch/loongarch/net/bpf_jit.c                      | 3 +++
 arch/mips/net/bpf_jit_comp32.c                    | 3 +++
 arch/mips/net/bpf_jit_comp64.c                    | 3 +++
 arch/parisc/net/bpf_jit_comp32.c                  | 3 +++
 arch/parisc/net/bpf_jit_comp64.c                  | 3 +++
 arch/powerpc/net/bpf_jit_comp32.c                 | 3 +++
 arch/powerpc/net/bpf_jit_comp64.c                 | 3 +++
 arch/riscv/net/bpf_jit_comp32.c                   | 3 +++
 arch/riscv/net/bpf_jit_comp64.c                   | 3 +++
 arch/s390/net/bpf_jit_comp.c                      | 3 +++
 arch/sparc/net/bpf_jit_comp_64.c                  | 3 +++
 arch/x86/net/bpf_jit_comp32.c                     | 3 +++
 drivers/net/ethernet/netronome/nfp/bpf/verifier.c | 6 ++++++
 16 files changed, 51 insertions(+)

diff --git a/arch/arc/net/bpf_jit_core.c b/arch/arc/net/bpf_jit_core.c
index 639a2736f029..78b1819cee5a 100644
--- a/arch/arc/net/bpf_jit_core.c
+++ b/arch/arc/net/bpf_jit_core.c
@@ -734,6 +734,9 @@ static int handle_insn(struct jit_context *ctx, u32 idx)
 	u8  len = 0;
 	int ret = 0;
 
+	if (bpf_insn_is_hmul(insn))
+		return -EOPNOTSUPP;
+
 	switch (code) {
 	/* dst += src (32-bit) */
 	case BPF_ALU | BPF_ADD | BPF_X:
diff --git a/arch/arm/net/bpf_jit_32.c b/arch/arm/net/bpf_jit_32.c
index 9ede81afbc50..aa466fc79d96 100644
--- a/arch/arm/net/bpf_jit_32.c
+++ b/arch/arm/net/bpf_jit_32.c
@@ -1611,6 +1611,9 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx)
 } while (0)
 #define check_imm24(imm) check_imm(24, imm)
 
+	if (bpf_insn_is_hmul(insn))
+		goto notyet;
+
 	switch (code) {
 	/* ALU operations */
 
diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
index 3aa3ea0bc30b..dc60a931c364 100644
--- a/arch/arm64/net/bpf_jit_comp.c
+++ b/arch/arm64/net/bpf_jit_comp.c
@@ -1325,6 +1325,9 @@ static int build_insn(const struct bpf_verifier_env *env, const struct bpf_insn
 	int ret;
 	bool sign_extend;
 
+	if (bpf_insn_is_hmul(insn))
+		return -EOPNOTSUPP;
+
 	if (bpf_insn_is_indirect_target(env, ctx->prog, i))
 		emit_bti(A64_BTI_J, ctx);
 
diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bpf_jit.c
index 29c281bef28e..f0a433dc0ccd 100644
--- a/arch/loongarch/net/bpf_jit.c
+++ b/arch/loongarch/net/bpf_jit.c
@@ -730,6 +730,9 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx, bool ext
 	const s32 imm = insn->imm;
 	const bool is32 = BPF_CLASS(insn->code) == BPF_ALU || BPF_CLASS(insn->code) == BPF_JMP32;
 
+	if (bpf_insn_is_hmul(insn))
+		return -EOPNOTSUPP;
+
 	switch (code) {
 	/* dst = src */
 	case BPF_ALU | BPF_MOV | BPF_X:
diff --git a/arch/mips/net/bpf_jit_comp32.c b/arch/mips/net/bpf_jit_comp32.c
index 40a878b672f5..1afe15162af2 100644
--- a/arch/mips/net/bpf_jit_comp32.c
+++ b/arch/mips/net/bpf_jit_comp32.c
@@ -1472,6 +1472,9 @@ int build_insn(const struct bpf_insn *insn, struct jit_context *ctx)
 	s32 val, rel;
 	u8 alu, jmp;
 
+	if (bpf_insn_is_hmul(insn))
+		goto notyet;
+
 	switch (code) {
 	/* ALU operations */
 	/* dst = imm */
diff --git a/arch/mips/net/bpf_jit_comp64.c b/arch/mips/net/bpf_jit_comp64.c
index fa7e9aa37f49..a9765ea25282 100644
--- a/arch/mips/net/bpf_jit_comp64.c
+++ b/arch/mips/net/bpf_jit_comp64.c
@@ -643,6 +643,9 @@ int build_insn(const struct bpf_insn *insn, struct jit_context *ctx)
 	s32 val, rel;
 	u8 alu, jmp;
 
+	if (bpf_insn_is_hmul(insn))
+		goto notyet;
+
 	switch (code) {
 	/* ALU operations */
 	/* dst = imm */
diff --git a/arch/parisc/net/bpf_jit_comp32.c b/arch/parisc/net/bpf_jit_comp32.c
index 5ff0cf925fe9..6bf72d04855b 100644
--- a/arch/parisc/net/bpf_jit_comp32.c
+++ b/arch/parisc/net/bpf_jit_comp32.c
@@ -1133,6 +1133,9 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn, struct hppa_jit_context *ctx,
 		BPF_CLASS(code), code, (code & BPF_ALU64) ? 1:0, BPF_SIZE(code),
 		BPF_OP(code), insn->src_reg, insn->dst_reg);
 
+	if (bpf_insn_is_hmul(insn))
+		return -EOPNOTSUPP;
+
 	switch (code) {
 	/* dst = src */
 	case BPF_ALU64 | BPF_MOV | BPF_X:
diff --git a/arch/parisc/net/bpf_jit_comp64.c b/arch/parisc/net/bpf_jit_comp64.c
index 54b0d5e25e02..36b6078a146f 100644
--- a/arch/parisc/net/bpf_jit_comp64.c
+++ b/arch/parisc/net/bpf_jit_comp64.c
@@ -603,6 +603,9 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn, struct hppa_jit_context *ctx,
 
 	init_regs(&rd, &rs, insn, ctx);
 
+	if (bpf_insn_is_hmul(insn))
+		return -EOPNOTSUPP;
+
 	switch (code) {
 	/* dst = src */
 	case BPF_ALU | BPF_MOV | BPF_X:
diff --git a/arch/powerpc/net/bpf_jit_comp32.c b/arch/powerpc/net/bpf_jit_comp32.c
index bfdc50740da8..b578b19017b2 100644
--- a/arch/powerpc/net/bpf_jit_comp32.c
+++ b/arch/powerpc/net/bpf_jit_comp32.c
@@ -349,6 +349,9 @@ int bpf_jit_build_body(struct bpf_prog *fp, u32 *image, u32 *fimage, struct code
 		u32 true_cond;
 		u32 tmp_idx;
 
+		if (bpf_insn_is_hmul(insn))
+			return -EOPNOTSUPP;
+
 		if (i && (BPF_CLASS(code) == BPF_ALU64 || BPF_CLASS(code) == BPF_ALU) &&
 		    (BPF_CLASS(prevcode) == BPF_ALU64 || BPF_CLASS(prevcode) == BPF_ALU) &&
 		    BPF_OP(prevcode) == BPF_MOV && BPF_SRC(prevcode) == BPF_X &&
diff --git a/arch/powerpc/net/bpf_jit_comp64.c b/arch/powerpc/net/bpf_jit_comp64.c
index fc9db691e820..4ef0f3cffe84 100644
--- a/arch/powerpc/net/bpf_jit_comp64.c
+++ b/arch/powerpc/net/bpf_jit_comp64.c
@@ -992,6 +992,9 @@ int bpf_jit_build_body(struct bpf_prog *fp, u32 *image, u32 *fimage, struct code
 		u32 tmp_idx;
 		u32 jmp_off;
 
+		if (bpf_insn_is_hmul(insn))
+			return -EOPNOTSUPP;
+
 		/*
 		 * addrs[] maps a BPF bytecode address into a real offset from
 		 * the start of the body code.
diff --git a/arch/riscv/net/bpf_jit_comp32.c b/arch/riscv/net/bpf_jit_comp32.c
index a9e0bd5cc81d..64bc6779d25c 100644
--- a/arch/riscv/net/bpf_jit_comp32.c
+++ b/arch/riscv/net/bpf_jit_comp32.c
@@ -1014,6 +1014,9 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn, struct rv_jit_context *ctx,
 	const s8 *tmp1 = bpf2rv32[TMP_REG_1];
 	const s8 *tmp2 = bpf2rv32[TMP_REG_2];
 
+	if (bpf_insn_is_hmul(insn))
+		goto notsupported;
+
 	switch (code) {
 	case BPF_ALU64 | BPF_MOV | BPF_X:
 		if (insn->off != 0) {
diff --git a/arch/riscv/net/bpf_jit_comp64.c b/arch/riscv/net/bpf_jit_comp64.c
index e7378be171a9..2fc263b4adfe 100644
--- a/arch/riscv/net/bpf_jit_comp64.c
+++ b/arch/riscv/net/bpf_jit_comp64.c
@@ -1373,6 +1373,9 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn, struct rv_jit_context *ctx,
 
 	init_regs(&rd, &rs, insn, ctx);
 
+	if (bpf_insn_is_hmul(insn))
+		return -EOPNOTSUPP;
+
 	switch (code) {
 	/* dst = src */
 	case BPF_ALU | BPF_MOV | BPF_X:
diff --git a/arch/s390/net/bpf_jit_comp.c b/arch/s390/net/bpf_jit_comp.c
index c46872b071ce..402af90c9281 100644
--- a/arch/s390/net/bpf_jit_comp.c
+++ b/arch/s390/net/bpf_jit_comp.c
@@ -969,6 +969,9 @@ static noinline int bpf_jit_insn(struct bpf_jit *jit, struct bpf_prog *fp,
 
 	bpf_jit_probe_init(&probe);
 
+	if (bpf_insn_is_hmul(insn))
+		return -EOPNOTSUPP;
+
 	switch (insn->code) {
 	/*
 	 * BPF_MOV
diff --git a/arch/sparc/net/bpf_jit_comp_64.c b/arch/sparc/net/bpf_jit_comp_64.c
index 2fa0e9375127..1154ddc515b0 100644
--- a/arch/sparc/net/bpf_jit_comp_64.c
+++ b/arch/sparc/net/bpf_jit_comp_64.c
@@ -901,6 +901,9 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx)
 	const s16 off = insn->off;
 	const s32 imm = insn->imm;
 
+	if (bpf_insn_is_hmul(insn))
+		return -EOPNOTSUPP;
+
 	if (insn->src_reg == BPF_REG_FP)
 		ctx->saw_frame_pointer = true;
 
diff --git a/arch/x86/net/bpf_jit_comp32.c b/arch/x86/net/bpf_jit_comp32.c
index 852baf2e4db4..11ed65130d1e 100644
--- a/arch/x86/net/bpf_jit_comp32.c
+++ b/arch/x86/net/bpf_jit_comp32.c
@@ -1683,6 +1683,9 @@ static int do_jit(struct bpf_prog *bpf_prog, int *addrs, u8 *image,
 		int ilen;
 		u8 *func;
 
+		if (bpf_insn_is_hmul(insn))
+			goto notyet;
+
 		switch (code) {
 		/* ALU operations */
 		/* dst = src */
diff --git a/drivers/net/ethernet/netronome/nfp/bpf/verifier.c b/drivers/net/ethernet/netronome/nfp/bpf/verifier.c
index 1caa87da72b5..effce27f3b88 100644
--- a/drivers/net/ethernet/netronome/nfp/bpf/verifier.c
+++ b/drivers/net/ethernet/netronome/nfp/bpf/verifier.c
@@ -3,6 +3,7 @@
 
 #include <linux/bpf.h>
 #include <linux/bpf_verifier.h>
+#include <linux/filter.h>
 #include <linux/kernel.h>
 #include <linux/netdevice.h>
 #include <linux/pkt_cls.h>
@@ -561,6 +562,11 @@ nfp_bpf_check_alu(struct nfp_prog *nfp_prog, struct nfp_insn_meta *meta,
 	const struct bpf_reg_state *dreg =
 		cur_regs(env) + meta->insn.dst_reg;
 
+	if (bpf_insn_is_hmul(&meta->insn)) {
+		pr_vlog(env, "UHMUL/SHMUL are not supported\n");
+		return -EOPNOTSUPP;
+	}
+
 	meta->umin_src = min(meta->umin_src, reg_umin(sreg));
 	meta->umax_src = max(meta->umax_src, reg_umax(sreg));
 	meta->umin_dst = min(meta->umin_dst, reg_umin(dreg));
-- 
2.43.0

