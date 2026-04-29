Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E351F40FDAD
	for <bpf@vger.kernel.org>; Wed, 29 Apr 2026 17:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.164.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777483206; cv=none; b=q0a0zMcT9aDa4NrllFIAtT042dMpH87loQnFuONPdbQpJSCffxPDTYB9VGlTSwWXJTnqZYW2Ndrv2i4QceFqUeFiVfeAffnifip8eB15m+ZEZivnbgpyxoPik32fbfVRZNJ674uLssIr/C6+kyEIVRDD0B4wa05mZxHIxrHxXIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777483206; c=relaxed/simple;
	bh=5U2cJ8PhHycN7BzXjb49W8z+yoH0m9G0YkPcyT75L78=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iUA1G7HaQJrQa20AOS5uu9EZVEjoBP0BpnhXngR2BaSuDQuF5jncGwNqi2Vdov3B/AqB15/FVjoPXVuRhVJ1SAXrMEPEhZVd6e+szQi88slF6sTIFiTLFa3vu2I45+iu65OVZ0eQOdfGIyD7KU0dnc8CcR5Neb92rW+kxm0BGk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=162.243.164.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from zju.edu.cn (unknown [112.10.248.232])
	by mtasvr (Coremail) with SMTP id _____wBHpjqvPfJpFe7iAA--.46S3;
	Thu, 30 Apr 2026 01:19:43 +0800 (CST)
Received: from wolframium.tail477849.ts.net (unknown [112.10.248.232])
	by mail-app2 (Coremail) with SMTP id zC_KCgAnmM2rPfJpI3fsAA--.28036S2;
	Thu, 30 Apr 2026 01:19:42 +0800 (CST)
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
Subject: [PATCH bpf-next v9 2/3] bpf: Fix s16 truncation for large bpf-to-bpf call offsets
Date: Thu, 30 Apr 2026 01:19:03 +0800
Message-ID: <20260429171904.107244-3-tangyazhou@zju.edu.cn>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260429171904.107244-1-tangyazhou@zju.edu.cn>
References: <20260429171904.107244-1-tangyazhou@zju.edu.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zC_KCgAnmM2rPfJpI3fsAA--.28036S2
X-CM-SenderInfo: qssvjiasrsq6lmxovvfxof0/1tbiAgMQCmnxDY5J4AABso
X-CM-DELIVERINFO: =?B?brZ+4gXKKxbFmtjJiESix3B1w3vD7IpoGYuur0o+r46DyAi5OfOO+T4vrW4FyUBIyu
	9q9JbrTQrMiN5RXULcsl7pn2ZpyEEY5kcaKMLg1gJMY68HN9f+0fW09c9rBZG3adAk/YnR
	FB6fs10b/PVh/m2u8ueUccXLBgWW0tgG3wFM54ao+NQtH1lPZwZNNe2mpkW6zg==
X-Coremail-Antispam: 1Uk129KBj93XoW3JrWxtw1DKF4rGFW5KFy7twc_yoWfZr45pa
	98KryxKr4DXr4Sy39rGr4UCw43Grs7Aa47Ca95J3ySvr43tFnxWF18KF1SvF9xGr929w1Y
	yrsFva4xuw1DCrXCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUB0b4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26r1j6r4UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8JVW8Jr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27w
	Aqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE
	14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjcxG0xvY0x
	0EwIxGrVCF72vEw4AK0wACI402YVCY1x02628vn2kIc2xKxwCF04k20xvY0x0EwIxGrwCF
	x2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14
	v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY
	67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI
	8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v2
	6r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU7wIDDUUUU

From: Yazhou Tang <tangyazhou518@outlook.com>

Currently, the BPF instruction set allows bpf-to-bpf calls (or internal
calls, pseudo calls) to use a 32-bit imm field to represent the relative
jump offset.

However, when JIT is disabled or falls back to the interpreter, the
verifier invokes bpf_patch_call_args() to rewrite the call instruction.
In this function, the 32-bit imm is downcast to s16 and stored in the off
field.

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
1. In bpf_patch_call_args(), keeping the imm field unchanged and using the
   off field to store the index of the interpreter function.
2. In ___bpf_prog_run() for the JMP_CALL_ARGS case, retrieving the
   interpreter function pointer from the interpreters_args array using the
   off field as the index, and passing the original imm to calculate the
   last argument of the interpreter function.

After these changes, the truncation issue is resolved, and __bpf_call_base_args
is also no longer needed and can be removed, which makes the code cleaner.

Performance: In ___bpf_prog_run() for the JMP_CALL_ARGS case, changing the
retrieval of the interpreter function pointer from pointer addition to
direct array indexing improves performance. The possible reason is that the
latter has better instruction-level parallelism. See the v5 discussion [1]
for more details.

[1] https://lore.kernel.org/bpf/f120c3c4-6999-414a-b514-518bb64b4758@zju.edu.cn/

The related dumper code is also updated to adapt to the verifier changes.
Specifically, the usages of insn->imm and insn->off are swapped:
1. When JIT is enabled, use insn->imm as the call offset, and insn->off
   as the subprog id.
2. When JIT is disabled, print insn->imm as the call offset.
3. The cfg_partition_funcs() function in bpftool is also updated to use
   insn->imm to calculate the call target, preventing error during
   "bpftool prog dump xlated visual".

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
 tools/bpf/bpftool/cfg.c                      |  2 +-
 tools/bpf/bpftool/xlated_dumper.c            | 10 +++++-----
 tools/testing/selftests/bpf/disasm_helpers.c | 18 ------------------
 6 files changed, 15 insertions(+), 35 deletions(-)

diff --git a/include/linux/filter.h b/include/linux/filter.h
index b77d0b06db6e..c4d25d78291b 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -1152,9 +1152,6 @@ bool sk_filter_charge(struct sock *sk, struct sk_filter *fp);
 void sk_filter_uncharge(struct sock *sk, struct sk_filter *fp);
 
 u64 __bpf_call_base(u64 r1, u64 r2, u64 r3, u64 r4, u64 r5);
-#define __bpf_call_base_args \
-	((u64 (*)(u64, u64, u64, u64, u64, const struct bpf_insn *)) \
-	 (void *)__bpf_call_base)
 
 struct bpf_prog *bpf_int_jit_compile(struct bpf_verifier_env *env, struct bpf_prog *prog);
 void bpf_jit_compile(struct bpf_prog *prog);
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index fcc881909969..8f7db5f0c7e5 100644
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
diff --git a/tools/bpf/bpftool/cfg.c b/tools/bpf/bpftool/cfg.c
index e3785f9a697d..df43a0e0023f 100644
--- a/tools/bpf/bpftool/cfg.c
+++ b/tools/bpf/bpftool/cfg.c
@@ -142,7 +142,7 @@ static bool cfg_partition_funcs(struct cfg *cfg, struct bpf_insn *cur,
 			continue;
 		if (cur->src_reg != BPF_PSEUDO_CALL)
 			continue;
-		func = cfg_append_func(cfg, cur + cur->off + 1);
+		func = cfg_append_func(cfg, cur + cur->imm + 1);
 		if (!func)
 			return true;
 	}
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
2.54.0

