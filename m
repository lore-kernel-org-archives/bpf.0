Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 535B223ED6A;
	Thu, 11 Jun 2026 01:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781142815; cv=none; b=d58oKniFtTjgHqT7g04KPiO9JAVEcJuVCLiTR8nNZiL/pfvG01jVdqydRE9l7YflTBliSiJz2hBq7/mu5CxyWRIIESh+4udakK2m4y3PQJ3UNEmo4jtrRqr3RW8e5tFGy4pjozASCYfr6zHGGdPjoQ5o4luj0sKwOnDPI8Et5rQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781142815; c=relaxed/simple;
	bh=6+UBWqoGkizmA+xUeHOC78owiTy6GcsSxdD/Vyv1M6k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qiR1yUDjlPfHj65yV3MmXBD+eiRisLIhbJfebO+uE4TDOJDYh1QjavcG3qqdqlAxId2CUPuLGIT8eJCYU3HbBmhCfLcaBXblhKeT9eF35EVSgH+n6GjcKJrfke2lLD9e2RTiQv+oJZfEMz7quwhR3WmjrjBbGNuFK/liu4r117o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8BxzsAbFSpqFecSAA--.26806S3;
	Thu, 11 Jun 2026 09:53:31 +0800 (CST)
Received: from linux.localdomain (unknown [113.200.148.30])
	by front1 (Coremail) with SMTP id qMiowJBx68EXFSpqrXaiAA--.43928S5;
	Thu, 11 Jun 2026 09:53:30 +0800 (CST)
From: Tiezhu Yang <yangtiezhu@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>,
	Hengqi Chen <hengqi.chen@gmail.com>
Cc: loongarch@lists.linux.dev,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/3] LoongArch: BPF: Inline bpf_get_smp_processor_id() helper
Date: Thu, 11 Jun 2026 09:53:27 +0800
Message-ID: <20260611015327.12108-4-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20260611015327.12108-1-yangtiezhu@loongson.cn>
References: <20260611015327.12108-1-yangtiezhu@loongson.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJBx68EXFSpqrXaiAA--.43928S5
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoW7CrykWw4UurW7JFW8ZF1xXrc_yoW5Jr1UpF
	s8CrsIkr4DWa4FqrWxGr4kZryYqws5Wry3GFyYgayak3Z7Xry5tr1fKw13tFn5Ar4093Wx
	Z390kwsYkF4UXagCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUk0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1a6r1DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I
	8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1q6rW5McIj6I8E87Iv67AK
	xVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2Ij64
	vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
	jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2I
	x0cI8IcVAFwI0_Gr0_Xr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK
	8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I
	0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUoxR6UUUUU

The pointer to thread_info is always available in the $tp register,
the call to bpf_get_smp_processor_id() can be inlined into a single
load instruction.

(1) Here is the sample test.c:

  #include <linux/bpf.h>
  #include <bpf/bpf_helpers.h>

  SEC("raw_tp/sys_enter")
  int test_cpuid(void *ctx)
  {
	  return bpf_get_smp_processor_id();
  }
  char _license[] SEC("license") = "GPL";

(2) Here are the test steps:

  sudo yum install libbpf-devel kernel-devel bpftool
  clang -target bpf -O2 -c test.c -o test.o
  sudo sysctl -w net.core.bpf_jit_enable=1
  sudo bpftool prog show name test_cpuid
  sudo rm -f /sys/fs/bpf/test_cpuid
  sudo bpftool prog load test.o /sys/fs/bpf/test_cpuid
  ID=$(sudo bpftool prog show pinned /sys/fs/bpf/test_cpuid | grep -oE '^[0-9]+')
  sudo bpftool prog dump jited id $ID

(3) Here are the test results:

Before: 6 instructions

  ...
  64:	lu12i.w	$t1, 1213
  68:	ori	$t1, $t1, 1680
  6c:	lu32i.d	$t1, 0
  70:	lu52i.d	$t1, $t1, -1792
  74:	jirl	$ra, $t1, 0
  78:	move	$a5, $a0
  ...

After: 1 instruction

  ...
  64:	ld.wu	$a5, $tp, 16
  ...

This is similar with commit 2ddec2c80b44 ("riscv, bpf: inline
bpf_get_smp_processor_id()").

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 arch/loongarch/net/bpf_jit.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bpf_jit.c
index cb379b236d7d..448162584c9a 100644
--- a/arch/loongarch/net/bpf_jit.c
+++ b/arch/loongarch/net/bpf_jit.c
@@ -5,6 +5,7 @@
  * Copyright (C) 2022 Loongson Technology Corporation Limited
  */
 #include <linux/memory.h>
+#include <asm/asm-offsets.h>
 #include "bpf_jit.h"
 
 #define LOONGARCH_MAX_REG_ARGS 8
@@ -1154,6 +1155,12 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx, bool ext
 			break;
 		}
 
+		/* Implement helper call to bpf_get_smp_processor_id() inline */
+		if (insn->src_reg == 0 && insn->imm == BPF_FUNC_get_smp_processor_id) {
+			emit_insn(ctx, ldwu, regmap[BPF_REG_0], LOONGARCH_GPR_TP, TI_CPU);
+			break;
+		}
+
 		ret = bpf_jit_get_func_addr(ctx->prog, insn, extra_pass,
 					    &func_addr, &func_addr_fixed);
 		if (ret < 0)
@@ -2384,6 +2391,7 @@ bool bpf_jit_inlines_helper_call(s32 imm)
 	switch (imm) {
 	case BPF_FUNC_get_current_task:
 	case BPF_FUNC_get_current_task_btf:
+	case BPF_FUNC_get_smp_processor_id:
 		return true;
 	default:
 		return false;
-- 
2.42.0

