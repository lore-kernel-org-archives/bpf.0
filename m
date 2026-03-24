Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF55C1DC985
	for <bpf@vger.kernel.org>; Tue, 24 Mar 2026 09:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774342880; cv=none; b=sQVhHQCtKMBT1YoNEEkjpKDzCIsc0O0avKoE64Ls2qnanlX3GO0D/tQxff+mbNRrXFkiWFzDt71seDx365e9rOrd9qUE8OSMGGG4SEVCuTvH6H7pz0qlAsHYvv24fhBIWpMrhZGFeHRbriR/RMVslK7nRNZDpbgYihezHen0TTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774342880; c=relaxed/simple;
	bh=3yzXMbOZPuFtgID0Ow9coTlkNZpL95FyQrR43DqC9W4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ql39k86AiLwv7v3cMp4y4Iimqrk0tmCd4801q/yBQJXRhh5YLLkI+ud8ifZW5hZefKO5g4xSxP+hy+xxv+WgVUrIxXibCZXdof06vq/QMCFRbnrdybby4nF2gag3o34bGJxqvH69AKhp6yg9OIKEB2iCNSjVL2IligoIvKbzSnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8BxFMHbUsJplyAeAA--.39373S3;
	Tue, 24 Mar 2026 17:01:15 +0800 (CST)
Received: from linux.localdomain (unknown [113.200.148.30])
	by front1 (Coremail) with SMTP id qMiowJDxC8LTUsJpmxVcAA--.43301S6;
	Tue, 24 Mar 2026 17:01:13 +0800 (CST)
From: Tiezhu Yang <yangtiezhu@loongson.cn>
To: loongarch@lists.linux.dev,
	bpf@vger.kernel.org
Subject: [RFC PATCH 4/7] LoongArch: BPF: Add the default case in emit_atomic_rmw()
Date: Tue, 24 Mar 2026 17:01:03 +0800
Message-ID: <20260324090106.13527-5-yangtiezhu@loongson.cn>
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
X-CM-TRANSID:qMiowJDxC8LTUsJpmxVcAA--.43301S6
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoW7WrWrGF4fZFW5ZFy8Ar1fuFX_yoW8XF47pr
	s8AwsYkrZ3Xr1FgFWDJa9rurn8Kr4ktFWagFy7Z3yxJrsIqryDWF1rK3ZrXry5A348Wr1f
	XrsYkr1a9a18J3cCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUkFb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
	1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1q6rW5McIj6I8E87Iv
	67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2
	Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s02
	6x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1Y6r17MIIYrxkI7VAKI48JMIIF0x
	vE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE
	42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6x
	kF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07j0byZUUUUU=

Like the other archs such as x86 and riscv, add the default case to print
an error message for the invalid opcode and return -EINVAL, then make its
return type as int.

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 arch/loongarch/net/bpf_jit.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bpf_jit.c
index b734989b648b..fefda4050a20 100644
--- a/arch/loongarch/net/bpf_jit.c
+++ b/arch/loongarch/net/bpf_jit.c
@@ -344,7 +344,7 @@ static int emit_bpf_tail_call(struct jit_ctx *ctx, int insn)
 #undef jmp_offset
 }
 
-static void emit_atomic_rmw(const struct bpf_insn *insn, struct jit_ctx *ctx)
+static int emit_atomic_rmw(const struct bpf_insn *insn, struct jit_ctx *ctx)
 {
 	const u8 t1 = LOONGARCH_GPR_T1;
 	const u8 t2 = LOONGARCH_GPR_T2;
@@ -448,7 +448,12 @@ static void emit_atomic_rmw(const struct bpf_insn *insn, struct jit_ctx *ctx)
 			emit_zext_32(ctx, r0, true);
 		}
 		break;
+	default:
+		pr_err_once("bpf-jit: invalid atomic read-modify-write opcode %02x\n", imm);
+		return -EINVAL;
 	}
+
+	return 0;
 }
 
 static bool is_signed_bpf_cond(u8 cond)
@@ -1256,7 +1261,9 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx, bool ext
 
 	case BPF_STX | BPF_ATOMIC | BPF_W:
 	case BPF_STX | BPF_ATOMIC | BPF_DW:
-		emit_atomic_rmw(insn, ctx);
+		ret = emit_atomic_rmw(insn, ctx);
+		if (ret)
+			return ret;
 		break;
 
 	/* Speculation barrier */
-- 
2.42.0

