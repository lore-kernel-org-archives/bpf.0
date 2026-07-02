Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F3821FF7C7
	for <bpf@vger.kernel.org>; Thu,  2 Jul 2026 02:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782958878; cv=none; b=pfxDVAlKMJ74bShk7xae4+87EhZnUJeHGqpm3qPMmQGEnw9SNQTXfdEOmzaQvwzdGrCk/K04IjkFBZXDnm6HNND6U8xRavwafly/U7/NMJbxIaiWetBIubfqg55+MRyJi5k75ANVCPX6io+Ovr6Wh0V3Ehp2+kYnWD3hIQL2HcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782958878; c=relaxed/simple;
	bh=wY913XJBoNw3wtoxup1g0+gEBADQrvWUQ9ZrluiGm8M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pKg/z2u+1JuyirTseY2S3rZIN0DszBz1xCAtILpv1SsExcnHeTZNzVAxqmOpWiLijzEXN2cBDyeRP61If5/jeXLnT9SgGk10hawjLkefClIW3mAn8ZdX5daiKiYSNliwc/6lEjkqQMx9d462Tbl2UMc7/ybG+NHu1zLEc8V8tTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8Bxh_AZy0VqZ74AAA--.4324S3;
	Thu, 02 Jul 2026 10:21:13 +0800 (CST)
Received: from linux.localdomain (unknown [113.200.148.30])
	by front1 (Coremail) with SMTP id qMiowJBxbcIUy0VqqGy7AA--.26372S2;
	Thu, 02 Jul 2026 10:21:10 +0800 (CST)
From: Tiezhu Yang <yangtiezhu@loongson.cn>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	KaFai Wan <kafai.wan@linux.dev>
Cc: bpf@vger.kernel.org,
	loongarch@lists.linux.dev,
	Leon Hwang <leon.hwang@linux.dev>
Subject: [PATCH bpf-next v5] bpf: Reject programs with inlined helpers if JIT is unavailable
Date: Thu,  2 Jul 2026 10:21:08 +0800
Message-ID: <20260702022108.17693-1-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJBxbcIUy0VqqGy7AA--.26372S2
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoWxZr18Xr17XF13AF4fCw1UCFX_yoW5KryrpF
	n8C3y7Cr4IqF4I9asrJw4xuw1Yqa1rG3W7Ga18GrW0ya1aqFn2qanYgFyFvFWfCr4vkr1S
	vwnF9r10ka4UXFXCm3ZEXasCq-sJn29KB7ZKAUJUUUUx529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUBYb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	Gr0_Gr1UM2kKe7AKxVWUAVWUtwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYI
	kI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUAVWU
	twAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI4
	8JMxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j
	6r4UMxCIbckI1I0E14v26r126r1DMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwV
	AFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv2
	0xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4
	v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AK
	xVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8svtJUUUUU==

When an architecture implements bpf_jit_inlines_helper_call(), such as
LoongArch, ARM64, PowerPC, and RISC-V, the verifier skips rewriting the
helper call offset (insn->imm) during the bpf_do_misc_fixups() phase,
because the helper is expected to be inlined by the JIT compiler. As a
result, insn->imm remains as the raw helper enum ID.

However, if JIT is disabled at runtime (net.core.bpf_jit_enable=0) or
if the JIT compilation later dynamically fails (e.g., due to OOM), the
core BPF subsystem falls back to the BPF interpreter.

When the interpreter executes (__bpf_call_base + insn->imm) with the
unpatched raw helper ID, it jumps into an unaligned invalid address
space, triggering an instruction alignment fault or a memory access
panic.

To avoid modifying the BPF interpreter's complexity for JIT-specific
paths, just introduce a 'jit_required' flag in struct bpf_prog. When
a program contains helper calls that skip rewriting for JIT inlining,
set this flag to 1. During runtime selection, if JIT compilation is
not available, explicitly reject loading with -ENOTSUPP instead of
falling back to the interpreter, safely preventing the kernel panic.

Fixes: 2ddec2c80b44 ("riscv, bpf: inline bpf_get_smp_processor_id()")
Suggested-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
v5:
  - Drop the fallback interpreter fixups as per maintainer's feedback.
  - Introduce 'jit_required' member in struct bpf_prog to flag programs
    that strictly rely on JIT.
  - Reject loading with -ENOTSUPP in __bpf_prog_select_runtime() if JIT
    fails or is disabled for these programs.
  - Upgrade 'jited' bitfield group type from u16 to u32 in struct bpf_prog
    to prevent 17-bit overflow warning.

 include/linux/bpf.h | 3 ++-
 kernel/bpf/core.c   | 2 +-
 kernel/bpf/fixups.c | 4 +++-
 3 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index ba09795e0bfd..463fae6a5c33 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1865,8 +1865,9 @@ struct bpf_prog_aux {
 
 struct bpf_prog {
 	u16			pages;		/* Number of allocated pages */
-	u16			jited:1,	/* Is our filter JIT'ed? */
+	u32			jited:1,	/* Is our filter JIT'ed? */
 				jit_requested:1,/* archs need to JIT the prog */
+				jit_required:1, /* program strictly requires JIT compiler */
 				gpl_compatible:1, /* Is filter GPL compatible? */
 				cb_access:1,	/* Is control block accessed? */
 				dst_needed:1,	/* Do we need dst entry? */
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 649cce41e13f..a55754bcc593 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -2639,7 +2639,7 @@ struct bpf_prog *__bpf_prog_select_runtime(struct bpf_verifier_env *env, struct
 
 		fp = bpf_prog_jit_compile(env, fp);
 		bpf_prog_jit_attempt_done(fp);
-		if (!fp->jited && jit_needed) {
+		if (!fp->jited && (jit_needed || fp->jit_required)) {
 			*err = -ENOTSUPP;
 			return fp;
 		}
diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
index 12a8a4eb757f..94e0457a0aa3 100644
--- a/kernel/bpf/fixups.c
+++ b/kernel/bpf/fixups.c
@@ -1841,8 +1841,10 @@ int bpf_do_misc_fixups(struct bpf_verifier_env *env)
 		}
 
 		/* Skip inlining the helper call if the JIT does it. */
-		if (bpf_jit_inlines_helper_call(insn->imm))
+		if (bpf_jit_inlines_helper_call(insn->imm)) {
+			prog->jit_required = 1;
 			goto next_insn;
+		}
 
 		if (insn->imm == BPF_FUNC_get_route_realm)
 			prog->dst_needed = 1;
-- 
2.42.0

