Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ED50223DEA;
	Sat, 17 Oct 2026 10:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792234296; cv=none; b=flTX3LmGYjP7P4W5B8P/RAPQBi7CIu76VAXJxZJR+vvEttSjZvz6jVjIfcQ1IaS4eGZX4t5jUKUpgiWo1OGaMMhcV+sQOgBloqb1bvDh6FYWiNCLGvdjSI0kwH9Q283wUMBaL3cLY9OPYmIMW1RQI6xpKtHzcoYXjsZ7j0TOwgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792234296; c=relaxed/simple;
	bh=GgaQFVqEjIrCUeHwcQ+Fc526g51/JusfikxoHon9ouI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mhDnt7mFwfzdOKoSIP13C2gdenJLbQxQJkM7Aix5B+ffbIwBFLGgAJrBT1zmJs69zcIjxmNe5RJz+2PzeNiStpHelSw++OmI15T/8y0V5LSqF3z6K/kuie1q/nCEsQvJQLWn2sgzSRfTxwhmD4mZxnY/GyeE5SJrV/RbyiRzhIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [123.138.236.242])
	by gateway (Coremail) with SMTP id _____8AxntIzU9NqLcgWAA--.705S3;
	Sat, 17 Oct 2026 18:51:31 +0800 (CST)
Received: from linux.localdomain (unknown [123.138.236.242])
	by front1 (Coremail) with SMTP id qMiowJAx1cwwU9Nq824tAA--.1559S2;
	Sat, 17 Oct 2026 18:51:29 +0800 (CST)
From: Tiezhu Yang <yangtiezhu@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>,
	Hengqi Chen <hengqi.chen@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: loongarch@lists.linux.dev,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] LoongArch: BPF: Fix stack arguments for indirect trampolines
Date: Sat, 17 Oct 2026 18:51:28 +0800
Message-ID: <20261017105128.18537-1-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJAx1cwwU9Nq824tAA--.1559S2
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoWxAF4kZF43tw4kXw17uFyxXrc_yoW5Cw4fpF
	n0kFsxGF48tr4Iq3Z7JayUZr1a9Fs3Z3y3Wr4DJay8ua15uryUXr1rK3ZI9F98Grn5A34F
	vrs0vw1YvFWDA3gCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUkjb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I
	8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AK
	xVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2Ij64
	vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
	jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2I
	x0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK
	8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I
	0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07j0FALUUUUU=

From: Kumar Kartikeya Dwivedi <memxor@gmail.com>

LoongArch passes arguments beyond a0-a7 at the caller stack pointer. The
trampoline store_args() helper always reads those arguments at FP + 16,
which is correct for an fentry trampoline: its prologue leaves FP 16 bytes
below the stack pointer at trampoline entry after accounting for the saved
parent and traced-function frames.

A struct_ops indirect trampoline is entered through a function pointer and
only saves its own RA and FP before setting FP to the entry stack pointer.
Its stack arguments therefore start at FP, not FP + 16. As a result, every
stack-passed struct_ops argument is currently read two slots late.

Select the source offset based on whether the trampoline is indirect. This
also prepares the stack-passed arena argument path to consume the actual
pointer slot.

With this patch, the BPF selftest "./test_progs -t struct_ops_multi_args"
passed on LoongArch.

Fixes: c9ebe2016de9 ("LoongArch: BPF: Support up to 12 function arguments for trampoline")
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
Here is the original link:
https://lore.kernel.org/bpf/20260821233516.3426127-8-memxor@gmail.com/

This version is based on the series:
https://lore.kernel.org/loongarch/20261016081006.26069-1-yangtiezhu@loongson.cn/

 arch/loongarch/net/bpf_jit.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bpf_jit.c
index 1a7c8effc37b..03c59956c0b7 100644
--- a/arch/loongarch/net/bpf_jit.c
+++ b/arch/loongarch/net/bpf_jit.c
@@ -1725,17 +1725,23 @@ int bpf_arch_text_invalidate(void *dst, size_t len)
 	return ret;
 }
 
-static void store_args(struct jit_ctx *ctx, int nr_arg_slots, int args_off)
+static void store_args(struct jit_ctx *ctx, int nr_arg_slots, int args_off, bool is_struct_ops)
 {
+
+	/*
+	 * Regular fentry trampolines need to skip the 16-byte saved T0 and FP
+	 * slots of the traced function. Indirect struct_ops trampolines place
+	 * incoming stack arguments directly at FP.
+	 */
+	int stack_args_off = is_struct_ops ? 0 : 16;
 	int i;
 
 	for (i = 0; i < nr_arg_slots; i++) {
 		if (i < LOONGARCH_MAX_REG_ARGS)
 			emit_insn(ctx, std, LOONGARCH_GPR_A0 + i, LOONGARCH_GPR_FP, -args_off);
 		else {
-			/* Skip slots for T0 and FP of traced function */
 			emit_insn(ctx, ldd, LOONGARCH_GPR_T1, LOONGARCH_GPR_FP,
-				  16 + (i - LOONGARCH_MAX_REG_ARGS) * 8);
+				  stack_args_off + (i - LOONGARCH_MAX_REG_ARGS) * 8);
 			emit_insn(ctx, std, LOONGARCH_GPR_T1, LOONGARCH_GPR_FP, -args_off);
 		}
 		args_off -= 8;
@@ -2068,7 +2074,7 @@ static int __arch_prepare_bpf_trampoline(struct jit_ctx *ctx, struct bpf_tramp_i
 	func_meta = nr_arg_slots;
 	emit_store_stack_imm64(ctx, LOONGARCH_GPR_T1, -func_meta_off, func_meta);
 
-	store_args(ctx, nr_arg_slots, args_off);
+	store_args(ctx, nr_arg_slots, args_off, is_struct_ops);
 
 	if (bpf_fsession_cnt(tnodes)) {
 		/* clear all session cookies' value */
-- 
2.42.0

