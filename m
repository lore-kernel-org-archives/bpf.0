Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3772C21E091;
	Mon, 15 Jun 2026 02:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781492005; cv=none; b=kPivfC479VlaBtjthNZwmwd1WzQ7IOmLQf0QDgeMzEWCvPnlBUAyNa5Rp6nmbObXCS45ONolppP736m+b64lwGsoh0GZYdSt7K8Ej3/jIG6ibSl9ndjELQrc0KkFOV+YJrPne8W13ds9zlupa7j6x3BtEoOffFO5ON/8CplwTBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781492005; c=relaxed/simple;
	bh=mB6/UeQsSSL1/92z+VyMCrGbG+FsKUV0A2C5TY8I9mQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TDxvKJJWgMt+nVp+kLmMyr0hVnUmAWZoC7QqRp+Mi/CseWJhc//tKDycgUckQT3b+ekP4HXqT+FgZpMWisgKg0dtrrzUikQsermuUgaSCIj0MHZR/1eS58iWXSb16wpyHHzAG2wVOaVhHqEKaOBazF4NzL1pfzwuYPAe8ekGfwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8CxRXgfaS9qVCwUAA--.28643S3;
	Mon, 15 Jun 2026 10:53:19 +0800 (CST)
Received: from linux.localdomain (unknown [113.200.148.30])
	by front1 (Coremail) with SMTP id qMiowJBxpsAdaS9qV6qmAA--.19986S2;
	Mon, 15 Jun 2026 10:53:18 +0800 (CST)
From: Tiezhu Yang <yangtiezhu@loongson.cn>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: Puranjay Mohan <puranjay@kernel.org>,
	loongarch@lists.linux.dev,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v4] bpf: Fix unaligned interpreter panic on JIT fallback path
Date: Mon, 15 Jun 2026 10:53:16 +0800
Message-ID: <20260615025316.24429-1-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJBxpsAdaS9qV6qmAA--.19986S2
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoWxury3uFWUGF1kAw4kWr48GrX_yoWrXF48pF
	4kCw1akr48Xa1I93y7Jw42yw15t3yrJay5Ga93Gr1FkF45XrnrWF4UKw1FqFsxJr4093Wf
	Zr42vFy29a48JagCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUkYb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6r4j6r4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI0UMc
	02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAF
	wI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxAIw28IcxkI7V
	AKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCj
	r7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6x
	IIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAI
	w20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x
	0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8vApUUUUUU==

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

This issue impacts all architectures that support helper inlining,
so introduce a late fixup pass via bpf_fixup_fallback_helpers() in
__bpf_prog_select_runtime() to fix this panic.

When JIT compilation fails or is disabled, the helper call offsets
originally skipped for inlining are rewritten to relative memory
offsets right before transferring control to the interpreter.

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
Tested-by: Xu Kuohai <xukuohai@huawei.com>
---
v4:
  - Rename the static function to bpf_fixup_fallback_helpers() to
    be more accurate and concise, following the file's naming style.
  - Remove redundant helper ID bounds check since invalid helper
    IDs are already filtered out in bpf_jit_inlines_helper_call().
  - Simplify code by merging nested if statements for helper checks.

 kernel/bpf/core.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 649cce41e13f..0db6e55bad52 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -2608,6 +2608,25 @@ static struct bpf_prog *bpf_prog_jit_compile(struct bpf_verifier_env *env, struc
 	return prog;
 }
 
+/* Fix up helper call offsets on JIT fallback path. */
+static void bpf_fixup_fallback_helpers(struct bpf_verifier_env *env, struct bpf_prog *fp)
+{
+	struct bpf_insn *insn = fp->insnsi;
+	const struct bpf_func_proto *fn;
+	int i;
+
+	if (!env || !env->ops->get_func_proto)
+		return;
+
+	for (i = 0; i < fp->len; i++, insn++) {
+		if (bpf_helper_call(insn) && bpf_jit_inlines_helper_call(insn->imm)) {
+			fn = env->ops->get_func_proto(insn->imm, env->prog);
+			if (fn && fn->func)
+				insn->imm = fn->func - __bpf_call_base;
+		}
+	}
+}
+
 struct bpf_prog *__bpf_prog_select_runtime(struct bpf_verifier_env *env, struct bpf_prog *fp,
 					   int *err)
 {
@@ -2643,6 +2662,9 @@ struct bpf_prog *__bpf_prog_select_runtime(struct bpf_verifier_env *env, struct
 			*err = -ENOTSUPP;
 			return fp;
 		}
+
+		if (!fp->jited)
+			bpf_fixup_fallback_helpers(env, fp);
 	} else {
 		*err = bpf_prog_offload_compile(fp);
 		if (*err)
-- 
2.42.0

