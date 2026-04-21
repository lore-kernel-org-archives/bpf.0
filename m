Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [52.229.168.213])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A2973D891E
	for <bpf@vger.kernel.org>; Tue, 21 Apr 2026 14:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.229.168.213
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776782764; cv=none; b=DwdoB0m+nz+YYj1uZtEkZOUBc2WYm0QpbLFQhAnLqiylool+jnx3s3rhkaeHMJy/nrSfYkqGBBt7uCVbbkk23hbss2FeyXLbo/Uw1jY9gp95WkrK5aTS1kqiz9XTs7hmbxaQjGCtX+lnKsSTMX3JoF1YmWIADr03eIPBAtA29Zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776782764; c=relaxed/simple;
	bh=RxCQ8tyHOuiCLRsLD1WAWudZUwpxR2fnobQYdgZNsX4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hrNvssrOgg/ULR6rgjqfd/iujom7ut43p5xceEQ9WvJUXTeqB7eqtH5DZ93cbqnqD3H6CdEfHAkriA/sDP8AW2hwy13duM/npLlYKK+rTAkTQY1ROAxS9KcbrgptFDiEFIQeQCCOlXb9wdmcPfmzXioKSsAIS1QjWPsp5BcpJa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=52.229.168.213
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from zju.edu.cn (unknown [10.162.235.246])
	by mtasvr (Coremail) with SMTP id _____wDn7z+EjedpN3+cAA--.1926S3;
	Tue, 21 Apr 2026 22:45:24 +0800 (CST)
Received: from wolframium.tail477849.ts.net (unknown [10.162.235.246])
	by mail-app3 (Coremail) with SMTP id zS_KCgB3YneEjedp7e2dAA--.11568S2;
	Tue, 21 Apr 2026 22:45:24 +0800 (CST)
From: Yazhou Tang <tangyazhou@zju.edu.cn>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	eddyz87@gmail.com,
	emil@etsalapatis.com,
	puranjay@kernel.org,
	xukuohai@huaweicloud.com
Cc: daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	tangyazhou518@outlook.com,
	shenghaoyuan0928@163.com,
	ziye@zju.edu.cn
Subject: [PATCH bpf-next v7 2/3] bpf: Fix s16 truncation for large bpf-to-bpf call offsets
Date: Tue, 21 Apr 2026 22:45:03 +0800
Message-ID: <20260421144504.823756-3-tangyazhou@zju.edu.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260421144504.823756-1-tangyazhou@zju.edu.cn>
References: <20260421144504.823756-1-tangyazhou@zju.edu.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zS_KCgB3YneEjedp7e2dAA--.11568S2
X-CM-SenderInfo: qssvjiasrsq6lmxovvfxof0/1tbiAgcICmnmgY0TDgADsa
X-CM-DELIVERINFO: =?B?gmlatgXKKxbFmtjJiESix3B1w3vD7IpoGYuur0o+r46DyAi5OfOO+T4vrW4FyUBIyu
	9q9N9K5WE5sTF3JnYhkXfPC+XHEFZkaJdyRKlYCH6d+YnnO7tQFcvhCwqQV4xZ7QMBH7Pn
	LplJXeUxFS0JoM8TTB86F55L2MKmKXHQQJY7i4wqcfMC7QH3nRw1GEy8H0gexA==
X-Coremail-Antispam: 1Uk129KBj93XoW3JrWxtw1DKF4rGFW5KFy7twc_yoWfJF45pF
	Z8KFy7Kr4kJr4Sy39rCr4UAw43Gr4kAa47Ca95J34Svr43tF9xWF18KF1SvFZ3Cr929w1Y
	yr4qva4xuw1DCrXCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUBjb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AK
	xVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI0UMc
	02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAF
	wI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0Y48IcxkI7V
	AKI48G6xCjnVAKz4kxM4IIrI8v6xkF7I0E8cxan2IY04v7MxAIw28IcxkI7VAKI48JMxC2
	0s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI
	0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE
	14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1lIxAIcVCF04k26cxKx2
	IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_
	Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jUKsbUUUUU=

From: Yazhou Tang <tangyazhou518@outlook.com>

Currently, the BPF instruction set allows bpf-to-bpf calls (or internal calls,
pseudo calls) to use a 32-bit imm field to represent the relative jump offset.

However, when JIT is disabled or falls back to the interpreter, the verifier
invokes bpf_patch_call_args() to rewrite the call instruction. In this
function, the 32-bit imm is downcast to s16 and stored in the off field.

    void bpf_patch_call_args(struct bpf_insn *insn, u32 stack_depth)
    {
        stack_depth = max_t(u32, stack_depth, 1);
        insn->off = (s16) insn->imm;
        insn->imm = interpreters_args[(round_up(stack_depth, 32) / 32) - 1] -
            __bpf_call_base_args;
        insn->code = BPF_JMP | BPF_CALL_ARGS;
    }

If the original imm exceeds the s16 range (i.e., jump offset > 32KB),
this downcast silently truncates the offset, resulting in an incorrect
call target.

Fix this by:
1. In bpf_patch_call_args(), keeping the imm field unchanged and using the off
   field to store the index of the interpreter function.
2. In ___bpf_prog_run() for the JMP_CALL_ARGS case, retrieving the interpreter
   function pointer from the interpreters_args array using the off field as
   the index, and passing the original imm to calculate the last argument of
   the interpreter function.

After these changes, the truncation issue is resolved, and __bpf_call_base_args
is also no longer needed and can be removed, which makes the code cleaner.

Performance: In ___bpf_prog_run() for the JMP_CALL_ARGS case, changing the
retrieval of the interpreter function pointer from pointer addition to direct
array indexing improves performance. The possible reason is that the latter
has better instruction-level parallelism. See the v5 discussion [1] for more
details.

[1] https://lore.kernel.org/bpf/f120c3c4-6999-414a-b514-518bb64b4758@zju.edu.cn/

The related dumper code is also updated to adapt to the verifier changes.
Specifically, the usages of insn->imm and insn->off are swapped:
1. When JIT is enabled, use insn->imm as the call offset, and insn->off
   as the subprog id.
2. When JIT is disabled, print insn->imm as the call offset.

Consequently, the workaround introduced in tools/testing/selftests/bpf/disasm_helpers.c
by commit 203e6aba7692 ("selftests/bpf: print correct offset for pseudo calls in disasm_insn()")
is no longer needed. Since the verifier now correctly exposes the offset
in the imm field, we can safely remove the custom print_call_cb() and
allow the selftests to rely on the native BPF disassembler.

Fixes: 1ea47e01ad6e ("bpf: add support for bpf_call to interpreter")
Fixes: 7105e828c087 ("bpf: allow for correlation of maps and helpers in dump")
Suggested-by: Xu Kuohai <xukuohai@huaweicloud.com>
Suggested-by: Puranjay Mohan <puranjay@kernel.org>
Co-developed-by: Tianci Cao <ziye@zju.edu.cn>
Signed-off-by: Tianci Cao <ziye@zju.edu.cn>
Co-developed-by: Shenghao Yuan <shenghaoyuan0928@163.com>
Signed-off-by: Shenghao Yuan <shenghaoyuan0928@163.com>
Signed-off-by: Yazhou Tang <tangyazhou518@outlook.com>
---
 include/linux/filter.h                       |  3 ---
 kernel/bpf/core.c                            | 11 ++++++-----
 kernel/bpf/fixups.c                          |  6 +++---
 tools/bpf/bpftool/xlated_dumper.c            | 10 +++++-----
 tools/testing/selftests/bpf/disasm_helpers.c | 18 ------------------
 5 files changed, 14 insertions(+), 34 deletions(-)

diff --git a/include/linux/filter.h b/include/linux/filter.h
index 1ec6d5ba64cc..88a241aac36a 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -1151,9 +1151,6 @@ bool sk_filter_charge(struct sock *sk, struct sk_filter *fp);
 void sk_filter_uncharge(struct sock *sk, struct sk_filter *fp);
 
 u64 __bpf_call_base(u64 r1, u64 r2, u64 r3, u64 r4, u64 r5);
-#define __bpf_call_base_args \
-	((u64 (*)(u64, u64, u64, u64, u64, const struct bpf_insn *)) \
-	 (void *)__bpf_call_base)
 
 struct bpf_prog *bpf_int_jit_compile(struct bpf_verifier_env *env, struct bpf_prog *prog);
 void bpf_jit_compile(struct bpf_prog *prog);
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 63044ebe5721..cdccb1b319a6 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -1771,6 +1771,9 @@ static u32 abs_s32(s32 x)
 	return x >= 0 ? (u32)x : -(u32)x;
 }
 
+static u64 (*interpreters_args[])(u64 r1, u64 r2, u64 r3, u64 r4, u64 r5,
+				  const struct bpf_insn *insn);
+
 /**
  *	___bpf_prog_run - run eBPF program on a given context
  *	@regs: is the array of MAX_BPF_EXT_REG eBPF pseudo-registers
@@ -2077,10 +2080,10 @@ static u64 ___bpf_prog_run(u64 *regs, const struct bpf_insn *insn)
 		CONT;
 
 	JMP_CALL_ARGS:
-		BPF_R0 = (__bpf_call_base_args + insn->imm)(BPF_R1, BPF_R2,
+		BPF_R0 = (interpreters_args[insn->off])(BPF_R1, BPF_R2,
 							    BPF_R3, BPF_R4,
 							    BPF_R5,
-							    insn + insn->off + 1);
+							    insn + insn->imm + 1);
 		CONT;
 
 	JMP_TAIL_CALL: {
@@ -2400,9 +2403,7 @@ int bpf_patch_call_args(struct bpf_insn *insn, u32 stack_depth)
 	/* Prevent out-of-bounds read to interpreters_args */
 	if (stack_depth > MAX_BPF_STACK)
 		return -EINVAL;
-	insn->off = (s16) insn->imm;
-	insn->imm = interpreters_args[(round_up(stack_depth, 32) / 32) - 1] -
-		__bpf_call_base_args;
+	insn->off = (round_up(stack_depth, 32) / 32) - 1;
 	insn->code = BPF_JMP | BPF_CALL_ARGS;
 	return 0;
 }
diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
index 300e4e251931..8947ef74f6a8 100644
--- a/kernel/bpf/fixups.c
+++ b/kernel/bpf/fixups.c
@@ -1250,9 +1250,9 @@ static int jit_subprogs(struct bpf_verifier_env *env)
 		}
 		if (!bpf_pseudo_call(insn))
 			continue;
-		insn->off = env->insn_aux_data[i].call_imm;
-		subprog = bpf_find_subprog(env, i + insn->off + 1);
-		insn->imm = subprog;
+		insn->imm = env->insn_aux_data[i].call_imm;
+		subprog = bpf_find_subprog(env, i + insn->imm + 1);
+		insn->off = subprog;
 	}
 
 	prog->jited = 1;
diff --git a/tools/bpf/bpftool/xlated_dumper.c b/tools/bpf/bpftool/xlated_dumper.c
index 5e7cb8b36fef..6ccda6787245 100644
--- a/tools/bpf/bpftool/xlated_dumper.c
+++ b/tools/bpf/bpftool/xlated_dumper.c
@@ -150,13 +150,13 @@ static const char *print_call_pcrel(struct dump_data *dd,
 	if (!dd->nr_jited_ksyms)
 		/* Do not show address for interpreted programs */
 		snprintf(dd->scratch_buff, sizeof(dd->scratch_buff),
-			"%+d", insn->off);
+			"%+d", insn->imm);
 	else if (sym)
 		snprintf(dd->scratch_buff, sizeof(dd->scratch_buff),
-			 "%+d#%s", insn->off, sym->name);
+			 "%+d#%s", insn->imm, sym->name);
 	else
 		snprintf(dd->scratch_buff, sizeof(dd->scratch_buff),
-			 "%+d#0x%lx", insn->off, address);
+			 "%+d#0x%lx", insn->imm, address);
 	return dd->scratch_buff;
 }
 
@@ -181,8 +181,8 @@ static const char *print_call(void *private_data,
 	struct kernel_sym *sym;
 
 	if (insn->src_reg == BPF_PSEUDO_CALL &&
-	    (__u32) insn->imm < dd->nr_jited_ksyms && dd->jited_ksyms)
-		address = dd->jited_ksyms[insn->imm];
+	    (__u32) insn->off < dd->nr_jited_ksyms && dd->jited_ksyms)
+		address = dd->jited_ksyms[insn->off];
 
 	sym = kernel_syms_search(dd, address);
 	if (insn->src_reg == BPF_PSEUDO_CALL)
diff --git a/tools/testing/selftests/bpf/disasm_helpers.c b/tools/testing/selftests/bpf/disasm_helpers.c
index f529f1c8c171..96b1f2ffe438 100644
--- a/tools/testing/selftests/bpf/disasm_helpers.c
+++ b/tools/testing/selftests/bpf/disasm_helpers.c
@@ -4,7 +4,6 @@
 #include "disasm.h"
 
 struct print_insn_context {
-	char scratch[16];
 	char *buf;
 	size_t sz;
 };
@@ -19,22 +18,6 @@ static void print_insn_cb(void *private_data, const char *fmt, ...)
 	va_end(args);
 }
 
-static const char *print_call_cb(void *private_data, const struct bpf_insn *insn)
-{
-	struct print_insn_context *ctx = private_data;
-
-	/* For pseudo calls verifier.c:jit_subprogs() hides original
-	 * imm to insn->off and changes insn->imm to be an index of
-	 * the subprog instead.
-	 */
-	if (insn->src_reg == BPF_PSEUDO_CALL) {
-		snprintf(ctx->scratch, sizeof(ctx->scratch), "%+d", insn->off);
-		return ctx->scratch;
-	}
-
-	return NULL;
-}
-
 struct bpf_insn *disasm_insn(struct bpf_insn *insn, char *buf, size_t buf_sz)
 {
 	struct print_insn_context ctx = {
@@ -43,7 +26,6 @@ struct bpf_insn *disasm_insn(struct bpf_insn *insn, char *buf, size_t buf_sz)
 	};
 	struct bpf_insn_cbs cbs = {
 		.cb_print	= print_insn_cb,
-		.cb_call	= print_call_cb,
 		.private_data	= &ctx,
 	};
 	char *tmp, *pfx_end, *sfx_start;
-- 
2.53.0

