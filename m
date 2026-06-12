Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B2053043CE;
	Fri, 12 Jun 2026 01:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781226626; cv=none; b=lmx2m9YW5hKXFtvuHz+jJjIeSKnrzBghLGA4Hx++59THv8rIFcI5204RmQhy2CDNXUN8nNul+0csNRAdv4LkLQdxD4f/fIraXmdl8s8lwNRjsvqPKBn4L8ROyISkDELvExiqded/hrHnbJ9KWUYiONM6c5LuZMUtiIoogGucvn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781226626; c=relaxed/simple;
	bh=pNiKlJ6NbmzWPwwAd1NDkeKjChv85ysLybtmH1wQAEg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bfsFuhR90Dzx+Dq0FMKmee3IJL0LRnXnAiconYuhNvFolVdrpQJrHipbcFMJJO68oqKrv4U4SkLDO1ZXzoWC0VhICyTS1B/u9ZbMdgVnzdUja+MPoobUwHMoX9HlHBb6wri0+uC4NsnbiQvrbiQROphSkT17g41WBnXEFPg+Dgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8Cx4ep8XCtqUE0TAA--.51440S3;
	Fri, 12 Jun 2026 09:10:20 +0800 (CST)
Received: from linux.localdomain (unknown [113.200.148.30])
	by front1 (Coremail) with SMTP id qMiowJCx_8J5XCtqUG+jAA--.47689S2;
	Fri, 12 Jun 2026 09:10:18 +0800 (CST)
From: Tiezhu Yang <yangtiezhu@loongson.cn>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: Puranjay Mohan <puranjay@kernel.org>,
	loongarch@lists.linux.dev,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v3] bpf: Fix unaligned interpreter panic on JIT fallback path
Date: Fri, 12 Jun 2026 09:10:16 +0800
Message-ID: <20260612011016.25701-1-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJCx_8J5XCtqUG+jAA--.47689S2
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoWxury3uFWUGF1kWFyfZr4kZrc_yoWrXr43pF
	95Cw4akr4UXF4Ig3y7JwsFvw15Kw48uay5GayfKr1FkF4FqrnrW3WUKw1FgFsxGr4j9F1x
	Zr42vFy29a48JFXCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUkjb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVWUJVW8JwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I
	8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AK
	xVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2Ij64
	vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
	jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2I
	x0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK
	8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I
	0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07j1WlkUUUUU=

When an architecture implements bpf_jit_inlines_helper_call(), such
as LoongArch, ARM64, and RISC-V, the BPF verifier skips rewriting
the helper call offset (insn->imm) during the bpf_do_misc_fixups()
phase if the helper is expected to be inlined by the JIT compiler.
As a result, insn->imm remains as the raw helper enum ID.

However, if JIT is disabled at runtime (net.core.bpf_jit_enable=0)
or if the JIT compilation later dynamically fails (e.g., due to OOM
during bpf_jit_alloc_exec()), the core BPF subsystem falls back to
the BPF interpreter.

When the fallback interpreter executes (__bpf_call_base + insn->imm)
with the unpatched raw helper ID, it jumps into an unaligned invalid
address space, triggering a fatal instruction alignment fault (ADEF)
or illegal memory access kernel panic.

This issue impacts all architectures that support helper inlining.
Introduce a late fixup pass via bpf_fixup_fallback_inline_helpers()
in __bpf_prog_select_runtime() to fix it.

When JIT compilation fails or is disabled, the helper call offsets
originally skipped for inlining are rewritten to relative memory
offsets right before transferring control to the interpreter.

A bounds check on insn->imm against __BPF_FUNC_MAX_ID is added to
ensure already-patched address offsets of regular non-inlined helpers
are safely filtered out during traversal.

1. Test case (test_panic.c):

  #include <linux/bpf.h>
  #include <bpf/bpf_helpers.h>

  SEC("kprobe/sys_getpid")
  int test_panic(void *ctx)
  {
  	struct task_struct *task;

  	task = (struct task_struct *)bpf_get_current_task();
  	if (task)
  		bpf_printk("Task address: %p\n", task);

  	return 0;
  }

  char LICENSE[] SEC("license") = "GPL";

2. Reproduction steps:

  $ clang -target bpf -O2 -g -c test_panic.c -o test_panic.o
  $ sudo sysctl -w net.core.bpf_jit_enable=0
  $ sudo bpftool prog load test_panic.o /sys/fs/bpf/test_panic autoattach
  $ sudo cat /sys/kernel/debug/tracing/trace_pipe

3. Panic information on LoongArch:

  Kernel ade access[#1]:
  ...
      ra: 9000000000486e50 ___bpf_prog_run+0x1370/0x36b0
     ERA: 9000000000485383 __bpf_prog_ret0_warn+0x13/0x20
  ...
   ESTAT: 00080000 [ADEF] (IS= ECode=8 EsubCode=0)

Fixes: 2ddec2c80b44 ("riscv, bpf: inline bpf_get_smp_processor_id()")
Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
Acked-by: Leon Hwang <leon.hwang@linux.dev>
---
 kernel/bpf/core.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 649cce41e13f..14bb71853a15 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -2608,6 +2608,31 @@ static struct bpf_prog *bpf_prog_jit_compile(struct bpf_verifier_env *env, struc
 	return prog;
 }
 
+/* Fix up helper call offsets for inlined helpers on JIT fallback path. */
+static void bpf_fixup_fallback_inline_helpers(struct bpf_verifier_env *env, struct bpf_prog *fp)
+{
+	struct bpf_insn *insn = fp->insnsi;
+	const struct bpf_func_proto *fn;
+	int i;
+
+	if (!env || !env->ops->get_func_proto)
+		return;
+
+	for (i = 0; i < fp->len; i++, insn++) {
+		if (bpf_helper_call(insn)) {
+			/* Filter out already-patched address offsets. */
+			if (insn->imm >= __BPF_FUNC_MAX_ID)
+				continue;
+
+			if (bpf_jit_inlines_helper_call(insn->imm)) {
+				fn = env->ops->get_func_proto(insn->imm, env->prog);
+				if (fn && fn->func)
+					insn->imm = fn->func - __bpf_call_base;
+			}
+		}
+	}
+}
+
 struct bpf_prog *__bpf_prog_select_runtime(struct bpf_verifier_env *env, struct bpf_prog *fp,
 					   int *err)
 {
@@ -2643,6 +2668,9 @@ struct bpf_prog *__bpf_prog_select_runtime(struct bpf_verifier_env *env, struct
 			*err = -ENOTSUPP;
 			return fp;
 		}
+
+		if (!fp->jited)
+			bpf_fixup_fallback_inline_helpers(env, fp);
 	} else {
 		*err = bpf_prog_offload_compile(fp);
 		if (*err)
-- 
2.42.0

