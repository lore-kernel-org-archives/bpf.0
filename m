Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DCAC366DCF;
	Wed,  1 Apr 2026 07:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775027545; cv=none; b=ozpE+et/8x1MGQmDQp+dJIETBKsfr1zJ4pE+gCxEu+SGYfXp7Ih6u0NsgtsBGG6vkEnp7sVfZvsZH7hbJmeAD5ieZivBNkG1y8OZZtwAxQ2hf5t0CkoTnUygi51TIFHVGLEww5PIoXcUtMeveZLonfaecgrAI/E3pUfsD7TN9ZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775027545; c=relaxed/simple;
	bh=MnkpGkoDttMr6Jy9w/iGNeSHHSyYY/5k7m8ZY+YQ3LA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BfpyY55L9CIDD+b8ZDKnP1t3A5mLkTv4vRc9QFZARuLNLV7k3Jbw2jQ8GSqv3sYuR6J0egA+MlyGxahNUw86Y7LczN0ewWhfeNK+Vt9cjbvtZPnH+BDZx71cHaDhydCJQq4i/mUJ6LGK1KCMRnETSi32i/atc6/lKuNcprdW4CU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8DxAfFWxcxpKLYgAA--.27139S3;
	Wed, 01 Apr 2026 15:12:22 +0800 (CST)
Received: from linux.localdomain (unknown [113.200.148.30])
	by front1 (Coremail) with SMTP id qMiowJAxHMJHxcxppFpiAA--.55591S6;
	Wed, 01 Apr 2026 15:12:21 +0800 (CST)
From: Tiezhu Yang <yangtiezhu@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>,
	Hengqi Chen <hengqi.chen@gmail.com>
Cc: loongarch@lists.linux.dev,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 4/5] LoongArch: BPF: Support load-acquire and store-release instructions
Date: Wed,  1 Apr 2026 15:12:05 +0800
Message-ID: <20260401071206.5506-5-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20260401071206.5506-1-yangtiezhu@loongson.cn>
References: <20260401071206.5506-1-yangtiezhu@loongson.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJAxHMJHxcxppFpiAA--.55591S6
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoWxGF47Ww4xuw45GrWkZw17twc_yoWrtw4rpr
	nrCrsYkr48Aa4SgF97JFW7WFyrKFs3Kr1UX3W7t393X3y3X345WF1rKF1avFy5G3ykXrs3
	WFZYvFy29a4UGrXCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUkFb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27w
	Aqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jw0_WrylYx0Ex4A2jsIE
	14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCF04k20xvY0x
	0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E
	7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcV
	C0I7IYx2IY67AKxVW8JVW5JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF
	04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7
	CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07josjUUUUUU=

Use the LoongArch common memory access instructions with the barrier dbar
to support the BPF load-acquire and store-release instructions.

With this patch, the following testcases passed on LoongArch if the macro
CAN_USE_LOAD_ACQ_STORE_REL is usable in bpf selftests:

  sudo ./test_progs -t verifier_load_acquire
  sudo ./test_progs -t verifier_store_release
  sudo ./test_progs -t verifier_precision/bpf_load_acquire
  sudo ./test_progs -t verifier_precision/bpf_store_release
  sudo ./test_progs -t compute_live_registers/atomic_load_acq_store_rel

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 arch/loongarch/net/bpf_jit.c | 101 ++++++++++++++++++++++++++++++++++-
 arch/loongarch/net/bpf_jit.h |  12 +++++
 2 files changed, 112 insertions(+), 1 deletion(-)

diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bpf_jit.c
index c9a32f124f5e..f18a2858123f 100644
--- a/arch/loongarch/net/bpf_jit.c
+++ b/arch/loongarch/net/bpf_jit.c
@@ -344,6 +344,102 @@ static int emit_bpf_tail_call(struct jit_ctx *ctx, int insn)
 #undef jmp_offset
 }
 
+static int emit_atomic_ld_st(const struct bpf_insn *insn, struct jit_ctx *ctx)
+{
+	const u8 t1 = LOONGARCH_GPR_T1;
+	const u8 src = regmap[insn->src_reg];
+	const u8 dst = regmap[insn->dst_reg];
+	const s16 off = insn->off;
+	const s32 imm = insn->imm;
+
+	switch (imm) {
+	/* dst_reg = load_acquire(src_reg + off16) */
+	case BPF_LOAD_ACQ:
+		switch (BPF_SIZE(insn->code)) {
+		case BPF_B:
+			if (is_signed_imm12(off)) {
+				emit_insn(ctx, ldb, dst, src, off);
+			} else {
+				move_imm(ctx, t1, off, false);
+				emit_insn(ctx, ldxb, dst, src, t1);
+			}
+			emit_zext_8(ctx, dst);
+			break;
+		case BPF_H:
+			if (is_signed_imm12(off)) {
+				emit_insn(ctx, ldh, dst, src, off);
+			} else {
+				move_imm(ctx, t1, off, false);
+				emit_insn(ctx, ldxh, dst, src, t1);
+			}
+			emit_zext_16(ctx, dst);
+			break;
+		case BPF_W:
+			if (is_signed_imm12(off)) {
+				emit_insn(ctx, ldw, dst, src, off);
+			} else {
+				move_imm(ctx, t1, off, false);
+				emit_insn(ctx, ldxw, dst, src, t1);
+			}
+			emit_zext_32(ctx, dst, true);
+			break;
+		case BPF_DW:
+			if (is_signed_imm12(off)) {
+				emit_insn(ctx, ldd, dst, src, off);
+			} else {
+				move_imm(ctx, t1, off, false);
+				emit_insn(ctx, ldxd, dst, src, t1);
+			}
+			break;
+		}
+		emit_insn(ctx, dbar, 0b10100);
+		break;
+	/* store_release(dst_reg + off16, src_reg) */
+	case BPF_STORE_REL:
+		emit_insn(ctx, dbar, 0b10010);
+		switch (BPF_SIZE(insn->code)) {
+		case BPF_B:
+			if (is_signed_imm12(off)) {
+				emit_insn(ctx, stb, src, dst, off);
+			} else {
+				move_imm(ctx, t1, off, false);
+				emit_insn(ctx, stxb, src, dst, t1);
+			}
+			break;
+		case BPF_H:
+			if (is_signed_imm12(off)) {
+				emit_insn(ctx, sth, src, dst, off);
+			} else {
+				move_imm(ctx, t1, off, false);
+				emit_insn(ctx, stxh, src, dst, t1);
+			}
+			break;
+		case BPF_W:
+			if (is_signed_imm12(off)) {
+				emit_insn(ctx, stw, src, dst, off);
+			} else {
+				move_imm(ctx, t1, off, false);
+				emit_insn(ctx, stxw, src, dst, t1);
+			}
+			break;
+		case BPF_DW:
+			if (is_signed_imm12(off)) {
+				emit_insn(ctx, std, src, dst, off);
+			} else {
+				move_imm(ctx, t1, off, false);
+				emit_insn(ctx, stxd, src, dst, t1);
+			}
+			break;
+		}
+		break;
+	default:
+		pr_err_once("bpf-jit: invalid atomic load/store opcode %02x\n", imm);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 static int emit_atomic_rmw(const struct bpf_insn *insn, struct jit_ctx *ctx)
 {
 	const u8 t1 = LOONGARCH_GPR_T1;
@@ -1326,7 +1422,10 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx, bool ext
 	case BPF_STX | BPF_ATOMIC | BPF_H:
 	case BPF_STX | BPF_ATOMIC | BPF_W:
 	case BPF_STX | BPF_ATOMIC | BPF_DW:
-		ret = emit_atomic_rmw(insn, ctx);
+		if (bpf_atomic_is_load_store(insn))
+			ret = emit_atomic_ld_st(insn, ctx);
+		else
+			ret = emit_atomic_rmw(insn, ctx);
 		if (ret)
 			return ret;
 		break;
diff --git a/arch/loongarch/net/bpf_jit.h b/arch/loongarch/net/bpf_jit.h
index a8e29be35fa8..9150de94ac60 100644
--- a/arch/loongarch/net/bpf_jit.h
+++ b/arch/loongarch/net/bpf_jit.h
@@ -72,6 +72,18 @@ static inline int epilogue_offset(const struct jit_ctx *ctx)
 	return (to - from);
 }
 
+/* Zero-extend 8 bits into 64 bits */
+static inline void emit_zext_8(struct jit_ctx *ctx, enum loongarch_gpr reg)
+{
+	emit_insn(ctx, bstrinsd, reg, LOONGARCH_GPR_ZERO, 63, 8);
+}
+
+/* Zero-extend 16 bits into 64 bits */
+static inline void emit_zext_16(struct jit_ctx *ctx, enum loongarch_gpr reg)
+{
+	emit_insn(ctx, bstrinsd, reg, LOONGARCH_GPR_ZERO, 63, 16);
+}
+
 /* Zero-extend 32 bits into 64 bits */
 static inline void emit_zext_32(struct jit_ctx *ctx, enum loongarch_gpr reg, bool is32)
 {
-- 
2.42.0

