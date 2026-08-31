Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 717D038DC66;
	Mon, 31 Aug 2026 02:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788143500; cv=none; b=J6AkTbcRibLFAp6OnyZ5vfAceed6Ydnz4xn+KIjJQVAzB065+qhngdJkgJo56WYTGM5bGSictz/cku6bVZY2XrDZ4a19JCx3bTqJwlTfM4V8y58XEbGldIoARRIdYrVvjqolKy2aFrGMxGxb+QV2dUikk4iPb0unV7atEX1qjRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788143500; c=relaxed/simple;
	bh=bjSZ1iWs4Dn/zALF7NO1b+tiRY0+8b5Uko7srttrhU8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=I20MzgLwGvIhUGJPJCxtCw3SyS5GP4q4Qvi4DrFWuSSpuwULenQ/5l99UKZi/cQEJVnFd/N1RCPGht1Pi0XdP1IV9qvrGx7U+gKYUF772JYzO+uBC4C2aexF5lVCjTk1haN9qmX0CALS2oHrzG24TumR6S+V4JZjHtjBZOG1IBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [123.138.236.242])
	by gateway (Coremail) with SMTP id _____8DxTNJx55RqSL4GAA--.18791S3;
	Mon, 31 Aug 2026 10:31:13 +0800 (CST)
Received: from linux.localdomain (unknown [123.138.236.242])
	by front1 (Coremail) with SMTP id qMiowJCxtMxr55Rqh_gXAA--.23244S2;
	Mon, 31 Aug 2026 10:31:08 +0800 (CST)
From: Tiezhu Yang <yangtiezhu@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Hengqi Chen <hengqi.chen@gmail.com>
Cc: loongarch@lists.linux.dev,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] LoongArch: BPF: Fix off-by-one error for insn_is_cast_user
Date: Mon, 31 Aug 2026 10:31:06 +0800
Message-ID: <20260831023106.3279-1-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJCxtMxr55Rqh_gXAA--.23244S2
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoW7KrWkuF1kWF1fJw43Ar15KFX_yoW8Aryfpr
	ZrAws8GFW8WrWru3WkJFWvvF1akFsxWr47GF42y3yFy3s0qr1FqFyfK390kFnYyw40vF1S
	qr9Ykw17Za4DZ3cCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUk0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	Gr1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI0UMc
	02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAF
	wI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxAIw28IcxkI7V
	AKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCj
	r7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6x
	IIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAI
	w20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x
	0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxU25EfUUUUU

In the LoongArch BPF JIT code, the branch offset represents the number
of instructions. An offset of 1 means the target of the "beq" is the
current PC plus 1 instruction (PC + 4 bytes). This matches the exact
same path as the sequential non-branch execution, the "or" instruction
is always executed for the cast_user JIT arm in build_insn().

If the pointer is not NULL, there is no side effect. But if the pointer
is NULL, it is incorrectly combined with the base address and turns into
a non-zero address, meaning a zero arena offset no longer casts to NULL.

Fix this by changing the branch offset from 1 to 2, which properly skips
the "or" instruction and jumps directly to the "move_reg" instruction if
the pointer is NULL, ensuring the destination register is safely cleared
to 0.

Fixes: 4fdb5dd8aeba ("LoongArch: BPF: Implement bpf_addr_space_cast instruction")
Cc: stable@vger.kernel.org
Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
v2: Update the commit message, no code changes.

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

