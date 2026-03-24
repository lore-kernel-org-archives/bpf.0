Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1E5F3D9043
	for <bpf@vger.kernel.org>; Tue, 24 Mar 2026 09:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774342876; cv=none; b=mtyJ/I2mAvK7qkuFMudnrYSXSTzDQAy3lE05j2bs4wd0H0YcApAPVMijY/Vfh2sJtZvsR7yHAiFgvxw0EF96VdFZoJDWH0H86/xO3otkw3r6DPzmmKApY68LdXgH1eLbIroohcKrgpmbJ5O2BU1SE3y7xuP/R5zY8ZLAi6dAtuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774342876; c=relaxed/simple;
	bh=aJcQLd0YA10w+zM0yAeipLN7pP4LXhFA5BKVjKuW+Lk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ukD0U8K6icCjzlntnDvCVCWZ4sHdr+WlzjQfgTnOluaAUYh/OsBXpS3uhrdZFq3B7DVlZHX7jXIXqXqhJ+ExjZLb3YMv07COf8/Xvhms+6BJE5CFM6dUCkGdqNptZEqHbYc9NQz0imlMzzsNinfrxG7se7gj+bKyWSCQqQujv0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8DxMMDZUsJplCAeAA--.27148S3;
	Tue, 24 Mar 2026 17:01:13 +0800 (CST)
Received: from linux.localdomain (unknown [113.200.148.30])
	by front1 (Coremail) with SMTP id qMiowJDxC8LTUsJpmxVcAA--.43301S5;
	Tue, 24 Mar 2026 17:01:12 +0800 (CST)
From: Tiezhu Yang <yangtiezhu@loongson.cn>
To: loongarch@lists.linux.dev,
	bpf@vger.kernel.org
Subject: [RFC PATCH 3/7] LoongArch: BPF: Rename emit_atomic() to emit_atomic_rmw()
Date: Tue, 24 Mar 2026 17:01:02 +0800
Message-ID: <20260324090106.13527-4-yangtiezhu@loongson.cn>
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
X-CM-TRANSID:qMiowJDxC8LTUsJpmxVcAA--.43301S5
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoW7Jw4DZryUtr17Xw4rXF1rKrX_yoW8JF1Dpr
	s5ZwsYkrWrXw1DWa4DJay7ur13KFsYy3yaqF4UZ3yfXanIgr1DWF1rK3WDGFy5A3y8Xr1f
	XrnYkryj93W8A3cCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUkFb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
	1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r126r1DMcIj6I8E87Iv
	67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2
	Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s02
	6x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1Y6r17MIIYrxkI7VAKI48JMIIF0x
	vE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE
	42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6x
	kF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07j83kZUUUUU=

All of the instructions in emit_atomic() are only read-modify-write
instructions, rename emit_atomic() to emit_atomic_rmw() to make it
clear because there will be a new function emit_atomic_ld_st() for
load-acquire or store-release instructions in the later patch.

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 arch/loongarch/net/bpf_jit.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bpf_jit.c
index 9cb796e16379..b734989b648b 100644
--- a/arch/loongarch/net/bpf_jit.c
+++ b/arch/loongarch/net/bpf_jit.c
@@ -344,7 +344,7 @@ static int emit_bpf_tail_call(struct jit_ctx *ctx, int insn)
 #undef jmp_offset
 }
 
-static void emit_atomic(const struct bpf_insn *insn, struct jit_ctx *ctx)
+static void emit_atomic_rmw(const struct bpf_insn *insn, struct jit_ctx *ctx)
 {
 	const u8 t1 = LOONGARCH_GPR_T1;
 	const u8 t2 = LOONGARCH_GPR_T2;
@@ -1256,7 +1256,7 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx, bool ext
 
 	case BPF_STX | BPF_ATOMIC | BPF_W:
 	case BPF_STX | BPF_ATOMIC | BPF_DW:
-		emit_atomic(insn, ctx);
+		emit_atomic_rmw(insn, ctx);
 		break;
 
 	/* Speculation barrier */
-- 
2.42.0

