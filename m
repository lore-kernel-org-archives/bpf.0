Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45FAC37CD5F;
	Mon, 13 Apr 2026 04:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776053128; cv=none; b=dmiq22aHTQDjEVkBLfNWby8J2x6MgxKjvybXgmUZEAx7bh2Lp8uaSgz+WXu+HqZaERdrJYRa21KKo+OvMrajFmy/tNEhQb4wu+azw7Hbrd8C0NqZLm7JwdzowHqBrs0p0AMdGvfOjmuBa7jLxB5PQXVPDehpl+QJ/HyJ7idcpvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776053128; c=relaxed/simple;
	bh=ALq4qrTVJYdy6ttYjPprTcuUYC/8FBPDvmWLdU/58f0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TtgSlqo1iJfev5+LImQ2zxH+H6Zp+1gU+9qyv3zPXjkhVo3RCmBkcNhn10GF6SQQYXbgIuMZ6JNd+PyDSmob52dIGmHSJi9cURHvdieLyYneLEASftV1yXkYplmM6U2ftBmpM65dkGyQPcyAOKEczd4OSmzoR+O9FdXQZCRXO/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8Axwep+a9xptwIAAA--.70S3;
	Mon, 13 Apr 2026 12:05:18 +0800 (CST)
Received: from linux.localdomain (unknown [113.200.148.30])
	by front1 (Coremail) with SMTP id qMiowJDxaeBya9xpD91rAA--.9793S6;
	Mon, 13 Apr 2026 12:05:18 +0800 (CST)
From: Tiezhu Yang <yangtiezhu@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>,
	Hengqi Chen <hengqi.chen@gmail.com>
Cc: loongarch@lists.linux.dev,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 4/5] LoongArch: BPF: Support load-acquire and store-release instructions
Date: Mon, 13 Apr 2026 12:05:05 +0800
Message-ID: <20260413040506.26640-5-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20260413040506.26640-1-yangtiezhu@loongson.cn>
References: <20260413040506.26640-1-yangtiezhu@loongson.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJDxaeBya9xpD91rAA--.9793S6
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoWxGF47Ww4xuw45GrWkZw17twc_yoWrGr1rpr
	srCw4Fkw4DA34fWFn3JFW7WFyrKFs3Kr1DX3W7t3yfX3y3Xwn8WF95KF1avFy5G3ykXrn7
	WFWvvF9F9a4UCrXCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUk2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1a6r1DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
	1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1q6rW5McIj6I8E87Iv
	67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2
	Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s02
	6x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0x
	vE2Ix0cI8IcVAFwI0_Xr0_Ar1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE
	42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6x
	kF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUoxR6UUUUU

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
 arch/loongarch/net/bpf_jit.c | 98 +++++++++++++++++++++++++++++++++++-
 1 file changed, 97 insertions(+), 1 deletion(-)

diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bpf_jit.c
index c9a32f124f5e..805f95cbe798 100644
--- a/arch/loongarch/net/bpf_jit.c
+++ b/arch/loongarch/net/bpf_jit.c
@@ -344,6 +344,99 @@ static int emit_bpf_tail_call(struct jit_ctx *ctx, int insn)
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
+				emit_insn(ctx, ldbu, dst, src, off);
+			} else {
+				move_imm(ctx, t1, off, false);
+				emit_insn(ctx, ldxbu, dst, src, t1);
+			}
+			break;
+		case BPF_H:
+			if (is_signed_imm12(off)) {
+				emit_insn(ctx, ldhu, dst, src, off);
+			} else {
+				move_imm(ctx, t1, off, false);
+				emit_insn(ctx, ldxhu, dst, src, t1);
+			}
+			break;
+		case BPF_W:
+			if (is_signed_imm12(off)) {
+				emit_insn(ctx, ldwu, dst, src, off);
+			} else {
+				move_imm(ctx, t1, off, false);
+				emit_insn(ctx, ldxwu, dst, src, t1);
+			}
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
@@ -1326,7 +1419,10 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx, bool ext
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
-- 
2.42.0

