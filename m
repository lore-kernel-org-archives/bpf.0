Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48B9C23FC41;
	Thu, 11 Jun 2026 01:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781142815; cv=none; b=IkvA0AgrtRFe/iYW2RH4wn7nBn9mQT7U2S/XXHLEb5bqPuex2Aoa5oXWLqXzVAydVUscYzIvdXxrLp3+ZSuaE6HgWU3QMfEYmtdby3ptFl/dZMc2u3EEHRuyakN2PJ6OmVj8ZKY1xm4hxseiFJOtW1iFK8hfMRM4YKuCtPUTE8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781142815; c=relaxed/simple;
	bh=a+WWJK1OsRk2PQIR6ycFumNzrETgsSywDSl8cizvmAg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TUWn0heisyCH0R//+Gn1Q11VJiMXen1RXw+5NdeO9zE8yMKk31E6FxIgtmKPqVWYsjZaouReLM+J5IWHCkwXAa2bF/Z0o3P4tuULH/rqDvKQXWkedRuOnyCyENqeRmB0joYCFyOkjMQyuIibk/FjnGjuRbMA4cC8B8O8txcqVfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8AxI_AaFSpqEecSAA--.49997S3;
	Thu, 11 Jun 2026 09:53:30 +0800 (CST)
Received: from linux.localdomain (unknown [113.200.148.30])
	by front1 (Coremail) with SMTP id qMiowJBx68EXFSpqrXaiAA--.43928S4;
	Thu, 11 Jun 2026 09:53:29 +0800 (CST)
From: Tiezhu Yang <yangtiezhu@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>,
	Hengqi Chen <hengqi.chen@gmail.com>
Cc: loongarch@lists.linux.dev,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/3] LoongArch: BPF: Inline bpf_get_current_task{_btf}() helpers
Date: Thu, 11 Jun 2026 09:53:26 +0800
Message-ID: <20260611015327.12108-3-yangtiezhu@loongson.cn>
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
X-CM-TRANSID:qMiowJBx68EXFSpqrXaiAA--.43928S4
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoWxGFyrtF15Aw13uw45urWrXrc_yoWrWw43pF
	WUCr4Ykr4kX34fKrWxJw4DZr1Yyw4DZryUGFy7KF4Fka13Xr1Yqr1fK3W3tFZ5CrWkuF1x
	Z39rKF1q9F1UZagCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUk0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1a6r1DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I
	8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1q6rW5McIj6I8E87Iv67AK
	xVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2Ij64
	vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
	jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2I
	x0cI8IcVAFwI0_Gr0_Xr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK
	8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I
	0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUoxR6UUUUU

The pointer to task_struct is always available in the $tp register,
the calls to bpf_get_current_task() and bpf_get_current_task_btf()
can be inlined into a single move instruction.

(1) Here is the sample test.c:

  #include <linux/bpf.h>
  #include <bpf/bpf_helpers.h>

  SEC("raw_tp/sys_enter")
  long test_task(void *ctx)
  {
	  return (long)bpf_get_current_task();
  }
  char _license[] SEC("license") = "GPL";

(2) Here are the test steps:

  sudo yum install libbpf-devel kernel-devel bpftool
  clang -target bpf -O2 -c test.c -o test.o
  sudo sysctl -w net.core.bpf_jit_enable=1
  sudo bpftool prog show name test_task
  sudo rm -f /sys/fs/bpf/test_task
  sudo bpftool prog load test.o /sys/fs/bpf/test_task
  ID=$(sudo bpftool prog show pinned /sys/fs/bpf/test_task | grep -oE '^[0-9]+')
  sudo bpftool prog dump jited id $ID

(3) Here are the test results:

Before: 6 instructions

  ...
  64:	lu12i.w	$t1, 1093
  68:	ori	$t1, $t1, 3320
  6c:	lu32i.d	$t1, 0
  70:	lu52i.d	$t1, $t1, -1792
  74:	jirl	$ra, $t1, 0
  78:	move	$a5, $a0
  ...

After: 1 instruction

  ...
  64:	move	$a5, $tp
  ...

This is similar with commit 2bb138cb20a6 ("bpf, arm64: Inline
bpf_get_current_task/_btf() helpers").

Additionally, a safety check for bpf_jit_enable is introduced in
bpf_jit_inlines_helper_call(). If CONFIG_BPF_JIT_ALWAYS_ON is not
set and JIT is disabled at runtime, the function returns false to
safely accommodate the fallback path to the BPF interpreter.

Without this check, bpf_jit_inlines_helper_call() unconditionally
returns true. As a result, the verifier would skip fixing up the
call offset, leaving insn->imm as the raw helper ID rather than
the expected "insn->imm = fn->func - __bpf_call_base".

When the fallback interpreter executes (__bpf_call_base + insn->imm)
with this raw ID, it jumps into an unaligned invalid address space,
triggering a fatal instruction alignment fault (ADEF) kernel panic.

(1) Here is the sample test_panic.c:

  #include <linux/bpf.h>
  #include <bpf/bpf_helpers.h>

  SEC("kprobe/sys_getpid")
  int test_panic_vulner(void *ctx)
  {
  	struct task_struct *task;

  	task = (struct task_struct *)bpf_get_current_task();
  	if (task)
  		bpf_printk("Task address: %p\n", task);

  	return 0;
  }

  char LICENSE[] SEC("license") = "GPL";

(2) Kernel panic reproduction steps without the bpf_jit_enable check:

  clang -target bpf -O2 -g -c test_panic.c -o test_panic.o
  sudo sysctl -w net.core.bpf_jit_enable=0
  sudo bpftool prog load test_panic.o /sys/fs/bpf/test_panic autoattach

(3) Kernel panic information without the bpf_jit_enable check:
  Kernel ade access[#1]:
  ...
      ra: 9000000000486e50 ___bpf_prog_run+0x1370/0x36b0
     ERA: 9000000000485383 __bpf_prog_ret0_warn+0x13/0x20
  ...
   ESTAT: 00080000 [ADEF] (IS= ECode=8 EsubCode=0)

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 arch/loongarch/net/bpf_jit.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bpf_jit.c
index 24913dc7f4e8..cb379b236d7d 100644
--- a/arch/loongarch/net/bpf_jit.c
+++ b/arch/loongarch/net/bpf_jit.c
@@ -1147,6 +1147,13 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx, bool ext
 
 	/* function call */
 	case BPF_JMP | BPF_CALL:
+		/* Implement helper call to bpf_get_current_task/_btf() inline */
+		if (insn->src_reg == 0 && (insn->imm == BPF_FUNC_get_current_task ||
+					   insn->imm == BPF_FUNC_get_current_task_btf)) {
+			move_reg(ctx, regmap[BPF_REG_0], LOONGARCH_GPR_TP);
+			break;
+		}
+
 		ret = bpf_jit_get_func_addr(ctx->prog, insn, extra_pass,
 					    &func_addr, &func_addr_fixed);
 		if (ret < 0)
@@ -2367,3 +2374,18 @@ bool bpf_jit_supports_subprog_tailcalls(void)
 {
 	return true;
 }
+
+bool bpf_jit_inlines_helper_call(s32 imm)
+{
+	/* Prevent interpreter panic when JIT is disabled at runtime */
+	if (!bpf_jit_enable)
+		return false;
+
+	switch (imm) {
+	case BPF_FUNC_get_current_task:
+	case BPF_FUNC_get_current_task_btf:
+		return true;
+	default:
+		return false;
+	}
+}
-- 
2.42.0

