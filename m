Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FF9E3B4404;
	Mon,  8 Jun 2026 10:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780914929; cv=none; b=gFbg/uPS0obc65cLOdZQBAeAiqxN8mShaLzNsD5iWN6vzUzVb0/tK23+SaDVG8kiSEekH5kRAeGpjIT1uoa/eOGSLihtVAo3n7tddq2UyyAhKA4RYu20wyDT/gxbZOnkwNSsV+UxCbEaa1L3VnWZfEX616JGMoUBcEgyGGkzt+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780914929; c=relaxed/simple;
	bh=Bo0BHYJ0tHSmpC59lQMtEt4KfHXhD8Eh07x0FPHBtV8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EoN6dyX15bks310EMHFL8/TqK3sFUm+fdBTUNndkhdO9PQ2WlJOQjPGliZmpwyPHiZ7V4dePO+hNYxyduf38p0VD3lCbGH0xAohwJfSnjtyZrlBH2/0fhGaaUW0ydYn5MYsp6Nyhv0DvtkEDJVurm/hzNYqPRGXvSu4ly1HVQS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8Bxt3jumiZq9ckRAA--.22850S3;
	Mon, 08 Jun 2026 18:35:26 +0800 (CST)
Received: from linux.localdomain (unknown [113.200.148.30])
	by front1 (Coremail) with SMTP id qMiowJBxSeDlmiZqLqafAA--.40549S4;
	Mon, 08 Jun 2026 18:35:25 +0800 (CST)
From: Tiezhu Yang <yangtiezhu@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>,
	Hengqi Chen <hengqi.chen@gmail.com>
Cc: loongarch@lists.linux.dev,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 2/3] LoongArch: BPF: Inline bpf_get_current_task{_btf}() helpers
Date: Mon,  8 Jun 2026 18:35:15 +0800
Message-ID: <20260608103516.20643-3-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20260608103516.20643-1-yangtiezhu@loongson.cn>
References: <20260608103516.20643-1-yangtiezhu@loongson.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJBxSeDlmiZqLqafAA--.40549S4
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoW7tr43KFy8tF4DXw4DXryDXFc_yoW8KFyDpF
	4UAr1Ykr4DX34ftrWxJw4DZr1ayaykGry7WFy5K3ySka1fXrnYqr1fK3W3JF95ArW8ZF1f
	Z39FyrsY9F1DAagCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUk2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r126r13M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
	1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1q6rW5McIj6I8E87Iv
	67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2
	Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s02
	6x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0x
	vE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE
	42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6x
	kF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUco7KUUUUU

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

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 arch/loongarch/net/bpf_jit.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bpf_jit.c
index 24913dc7f4e8..b93b67d22c26 100644
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
@@ -2367,3 +2374,14 @@ bool bpf_jit_supports_subprog_tailcalls(void)
 {
 	return true;
 }
+
+bool bpf_jit_inlines_helper_call(s32 imm)
+{
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

