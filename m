Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE3A134CFC7;
	Fri, 28 Aug 2026 07:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787903468; cv=none; b=M2/lEsu4bvKk7KshUYUl6BSkHxLN2EmOapPt5uB6wXgOR6YEH2r/2ECXX20UVdbdo3JfppwzSiI9dmmMv0p2bKtWUwVgYsoUzUoggtkOo2lyLQcTYVtO0xNTgX+K1TmrEPdyrO/LKmyJM5AReqtHjLiB0RYh/cugDWMEHuSTj68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787903468; c=relaxed/simple;
	bh=1OjkvvAZOnGlCuXH2KuSAvAMmthp6CXtjH/L+oEPLe4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qjFxVFgL/aQB0+UyoTQZ3DA4/O1eVpp67SqQ8+2M5P63xAv4neuv6uAZfmC1Z1LdQAEtK+gkr9ESFVCsS5klNRmDkHvAfs0mEdaELk9IZ4/WG1b25CBe6niN2hABBTN7j16Gac7Lnxr45ngmqHI7KV0TORa4GEBflF6fd7zzTEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [123.138.236.242])
	by gateway (Coremail) with SMTP id _____8BxLtPnPZFqlQcGAA--.16997S3;
	Fri, 28 Aug 2026 15:51:04 +0800 (CST)
Received: from linux.localdomain (unknown [123.138.236.242])
	by front1 (Coremail) with SMTP id qMiowJAxmM3lPZFq5D0VAA--.41531S2;
	Fri, 28 Aug 2026 15:51:02 +0800 (CST)
From: Tiezhu Yang <yangtiezhu@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: loongarch@lists.linux.dev,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1] LoongArch: BPF: Fix off-by-one error for insn_is_cast_user
Date: Fri, 28 Aug 2026 15:51:00 +0800
Message-ID: <20260828075100.24776-1-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJAxmM3lPZFq5D0VAA--.41531S2
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoW7Zr1kur4DtFyrJF1xtFyDCFX_yoW8WF1rpr
	ZxCws8KFWUWry3ua4DJayIvF1ftFs3Wr43WF12y3yFy3sIqryFqFyrK3sIkFnYkw48Zr1F
	qr9Ykw1Yva4DZacCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUU9Yb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6r4UJVWxJr1ln4kS14v26r1Y6r17M2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12
	xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y
	6r17McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64
	vIr41l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAFwI0_
	Jrv_JF1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1V
	AY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAI
	cVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42
	IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIev
	Ja73UjIFyTuYvjxU2L05UUUUU

Fix a severe off-by-one error in the branch offset calculation for the
user pointer cast helper insn_is_cast_user() inside build_insn().

In the current code, an offset of 1 causes the "beq" to target the next
"or" instruction, which means the "or" instruction is always executed,
even if the pointer is NULL. Thus, a native NULL pointer is incorrectly
combined with the arena base address and turns into a non-zero address,
breaking nullable safety guards and causing silent memory corruption.

Fix this by changing the branch offset from 1 to 2, which properly skips
the "or" instruction and jumps directly to the "move_reg" instruction if
the pointer is NULL, ensuring the destination register is safely cleared
to 0.

Fixes: 4fdb5dd8aeba ("LoongArch: BPF: Implement bpf_addr_space_cast instruction")
Cc: stable@vger.kernel.org
Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 arch/loongarch/net/bpf_jit.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bpf_jit.c
index 1eb588e443c9..4da278900938 100644
--- a/arch/loongarch/net/bpf_jit.c
+++ b/arch/loongarch/net/bpf_jit.c
@@ -717,7 +717,7 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx, bool ext
 			move_reg(ctx, t1, src);
 			emit_zext_32(ctx, t1, true);
 			move_imm(ctx, dst, (ctx->user_vm_start >> 32) << 32, false);
-			emit_insn(ctx, beq, t1, LOONGARCH_GPR_ZERO, 1);
+			emit_insn(ctx, beq, t1, LOONGARCH_GPR_ZERO, 2);
 			emit_insn(ctx, or, t1, dst, t1);
 			move_reg(ctx, dst, t1);
 			break;
-- 
2.42.0

