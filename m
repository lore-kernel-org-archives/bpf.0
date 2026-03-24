Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9310D3DA5AF
	for <bpf@vger.kernel.org>; Tue, 24 Mar 2026 09:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774342881; cv=none; b=NVPkdLgbfZFQjU34I+c4yw/KlFuUVCAuDgbngLjyzNpAtPQJKvJ0qaWWkcwtOovlRuGgbBcqgbbjl+hlvpfv1Gg6n9Lflui/hcrNrEaWehSUbnQol90reJVBwxmd3jwWHy9Y1AMOqwyRGz8TuAcPj5PKlVO0erqEl2yhhZE2U4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774342881; c=relaxed/simple;
	bh=yh/EMrOR07+J74nyCPhnJUGsVFbzrA8Xwz44FcAJqBw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZPsXXGOF4iEZaiU67rm/ht3pb6FITHELnnRnkqxNg5vbojh/WzsZ8N1GdB1dBcmnFSaj6QNKzT4sowAJ+yW7i8mD220bFiAk5r888Rl/H37OSiC5OxwOZxTdxaIRuLEdcblsBKOR+ArVTJ2kINkMjeWa5ez4QkqEKgmS6QebRfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8BxHMPeUsJpnCAeAA--.20276S3;
	Tue, 24 Mar 2026 17:01:18 +0800 (CST)
Received: from linux.localdomain (unknown [113.200.148.30])
	by front1 (Coremail) with SMTP id qMiowJDxC8LTUsJpmxVcAA--.43301S8;
	Tue, 24 Mar 2026 17:01:17 +0800 (CST)
From: Tiezhu Yang <yangtiezhu@loongson.cn>
To: loongarch@lists.linux.dev,
	bpf@vger.kernel.org
Subject: [RFC PATCH 6/7] LoongArch: BPF: Add load-acquire and store-release instructions
Date: Tue, 24 Mar 2026 17:01:05 +0800
Message-ID: <20260324090106.13527-7-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20260324090106.13527-1-yangtiezhu@loongson.cn>
References: <20260324090106.13527-1-yangtiezhu@loongson.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJDxC8LTUsJpmxVcAA--.43301S8
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoWxGw47tr13Gr1DKr4fAr15ZFc_yoWrGFyfpa
	nrCws5GFZxX3s3WF93JFZ7W3W5KFs5tas8XF13J3yfG39xXFnxGF1kKF1SvFy5GryDCr1I
	qa1F9Fyj9ayxAFbCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUk2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
	1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1q6rW5McIj6I8E87Iv
	67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2
	Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s02
	6x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1Y6r17MIIYrxkI7VAKI48JMIIF0x
	vE2Ix0cI8IcVAFwI0_Gr0_Xr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE
	42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6x
	kF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUcCD7UUUUU

Use the native instructions LLACQ.{W/D} and SCREL.{W/D} to support the BPF
load-acquire (BPF_LOAD_ACQ) and store-release (BPF_STORE_REL) instructions
in the JIT compiler.

With this patch, the following testcases passed on LoongArch if the macro
CAN_USE_LOAD_ACQ_STORE_REL is defined in bpf selftests:

  sudo ./test_progs -t verifier_load_acquire
  sudo ./test_progs -t verifier_store_release
  sudo ./test_progs -t verifier_precision/bpf_load_acquire
  sudo ./test_progs -t verifier_precision/bpf_store_release
  sudo ./test_progs -t compute_live_registers/atomic_load_acq_store_rel

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 arch/loongarch/net/bpf_jit.c | 86 +++++++++++++++++++++++++++++++++++-
 1 file changed, 85 insertions(+), 1 deletion(-)

diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bpf_jit.c
index c9a32f124f5e..d1e9866911dd 100644
--- a/arch/loongarch/net/bpf_jit.c
+++ b/arch/loongarch/net/bpf_jit.c
@@ -344,6 +344,87 @@ static int emit_bpf_tail_call(struct jit_ctx *ctx, int insn)
 #undef jmp_offset
 }
 
+static int emit_atomic_ld_st(const struct bpf_insn *insn, struct jit_ctx *ctx)
+{
+	const u8 t1 = LOONGARCH_GPR_T1;
+	const u8 t2 = LOONGARCH_GPR_T2;
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
+			pr_err_once("bpf-jit: llacq.b instruction is not supported\n");
+			return -EINVAL;
+		case BPF_H:
+			pr_err_once("bpf-jit: llacq.h instruction is not supported\n");
+			return -EINVAL;
+		case BPF_W:
+			if (cpu_has_llacq_screl) {
+				move_imm(ctx, t1, off, false);
+				emit_insn(ctx, addd, t2, src, t1);
+				emit_insn(ctx, llacqw, dst, t2);
+				emit_zext_32(ctx, dst, true);
+			} else {
+				pr_err_once("bpf-jit: llacq.w instruction is not supported\n");
+				return -EINVAL;
+			}
+			break;
+		case BPF_DW:
+			if (cpu_has_llacq_screl) {
+				move_imm(ctx, t1, off, false);
+				emit_insn(ctx, addd, t2, src, t1);
+				emit_insn(ctx, llacqd, dst, t2);
+			} else {
+				pr_err_once("bpf-jit: llacq.d instruction is not supported\n");
+				return -EINVAL;
+			}
+			break;
+		}
+		break;
+	/* store_release(dst_reg + off16, src_reg) */
+	case BPF_STORE_REL:
+		switch (BPF_SIZE(insn->code)) {
+		case BPF_B:
+			pr_err_once("bpf-jit: screl.b instruction is not supported\n");
+			return -EINVAL;
+		case BPF_H:
+			pr_err_once("bpf-jit: screl.h instruction is not supported\n");
+			return -EINVAL;
+		case BPF_W:
+			if (cpu_has_llacq_screl) {
+				move_imm(ctx, t1, off, false);
+				emit_insn(ctx, addd, t2, dst, t1);
+				emit_insn(ctx, screlw, src, t2);
+			} else {
+				pr_err_once("bpf-jit: screl.w instruction is not supported\n");
+				return -EINVAL;
+			}
+			break;
+		case BPF_DW:
+			if (cpu_has_llacq_screl) {
+				move_imm(ctx, t1, off, false);
+				emit_insn(ctx, addd, t2, dst, t1);
+				emit_insn(ctx, screld, src, t2);
+			} else {
+				pr_err_once("bpf-jit: screl.d instruction is not supported\n");
+				return -EINVAL;
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
@@ -1326,7 +1407,10 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx, bool ext
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

