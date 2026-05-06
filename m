Received: from zg8tmtyylji0my4xnjeumjiw.icoremail.net (zg8tmtyylji0my4xnjeumjiw.icoremail.net [162.243.161.220])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5835F2F3621
	for <bpf@vger.kernel.org>; Wed,  6 May 2026 09:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.161.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778060879; cv=none; b=hkUuCmbGZPbGUIfzDdbI/oqDe7XfBU3yW2BjyHhAVgGoxwzk2tvZiHhD3C+IDWhCh6y9RyR4PbNtFzxSqg/xKzg4ebKUa24jglJpsprLgIsTUaFEihi1vI6PDYa9Jr+OgRTOn+bR+nT65Q5Fz46fCTxkzazuN7vqueLR0ZwDJec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778060879; c=relaxed/simple;
	bh=+b3ctsztqnd9kzf4FI80YQMoEvvd6J0PEmDxQyHHvBo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hl9sBUHcDKXDHT3+CAphnftrfz1ydQa5x2yEiSmo0TYhmVuipFTCmDMhknGz4jFE9jwu3ujfaUMGuJM4k4lE+BkSNQyrXeChb3pz9sjVojui8gDt9DytDK221obADS0+j/xqyXS5t/LvcK1FYj81jc+ViZ6J12hMSgJEcXTDRLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=162.243.161.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from zju.edu.cn (unknown [10.162.163.215])
	by mtasvr (Coremail) with SMTP id _____wCXkEc5DvtpHuEWAQ--.1097S3;
	Wed, 06 May 2026 17:47:37 +0800 (CST)
Received: from lutetium.tail477849.ts.net (unknown [10.162.163.215])
	by mail-app1 (Coremail) with SMTP id yy_KCgCH1Z05DvtpomffAA--.1752S2;
	Wed, 06 May 2026 17:47:37 +0800 (CST)
From: Yazhou Tang <tangyazhou@zju.edu.cn>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	eddyz87@gmail.com,
	emil@etsalapatis.com,
	puranjay@kernel.org,
	xukuohai@huaweicloud.com,
	qmo@kernel.org
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
Subject: [PATCH bpf-next v10 2/3] bpf: Fix s16 truncation for large bpf-to-bpf call offsets
Date: Wed,  6 May 2026 17:47:13 +0800
Message-ID: <20260506094714.419842-3-tangyazhou@zju.edu.cn>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260506094714.419842-1-tangyazhou@zju.edu.cn>
References: <20260506094714.419842-1-tangyazhou@zju.edu.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:yy_KCgCH1Z05DvtpomffAA--.1752S2
X-CM-SenderInfo: qssvjiasrsq6lmxovvfxof0/1tbiBgcDCmn6SA9E3QABsE
X-CM-DELIVERINFO: =?B?9ycY2AXKKxbFmtjJiESix3B1w3vD7IpoGYuur0o+r46DyAi5OfOO+T4vrW4FyUBIyu
	9q9HZcWNexokz5CY3K6SJERHe2Jt7P6Zxvv0yPTMpZwMN4Xx9i7U2/oocL60y7RfNmbBes
	sialQz2N6JEDK/xuHKAZOxIaca3bM5b0LLYmELA/d9yI6VfUy2hmPFH4lWtTvw==
X-Coremail-Antispam: 1Uk129KBj93XoW3JrWxtw1DKF4rGFW5KFy7twc_yoW3Ar4xpF
	s5K34UCr4rXr4av3srJrs7Cw45Jrs5Z347Cas8G34F9r42qF93WF98KFsavFyfCryIkr12
	qFsF93sxCw17ArXCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUBjb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
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
	Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07je-eOUUUUU=

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

If the original imm exceeds the s16 range (i.e., a jump offset greater
than 32767 instructions), this downcast silently truncates the offset,
resulting in an incorrect call target.

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

To avoid requiring bpftool changes, keep the new imm/off encoding internal
and restore the legacy xlated dump layout in bpf_insn_prepare_dump().
For bpf-to-bpf call offsets that do not fit in s16, export off as 0 instead
of a truncated and misleading value.

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
 include/linux/bpf.h    |  6 ++++++
 include/linux/filter.h |  3 ---
 kernel/bpf/core.c      | 21 ++++++++++++++-------
 kernel/bpf/fixups.c    |  6 +++---
 kernel/bpf/syscall.c   | 26 ++++++++++++++++++++++++++
 5 files changed, 49 insertions(+), 13 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index eb6b816bc8b5..4e7f28538b17 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -2923,6 +2923,12 @@ int bpf_check(struct bpf_prog **fp, union bpf_attr *attr, bpfptr_t uattr, u32 ua
 
 #ifndef CONFIG_BPF_JIT_ALWAYS_ON
 int bpf_patch_call_args(struct bpf_insn *insn, u32 stack_depth);
+s32 bpf_call_args_imm(s16 idx);
+#else
+static inline s32 bpf_call_args_imm(s16 idx)
+{
+	return 0;
+}
 #endif
 
 struct btf *bpf_get_btf_vmlinux(void);
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
index fcc881909969..bd80f1768ef6 100644
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
@@ -2077,10 +2080,9 @@ static u64 ___bpf_prog_run(u64 *regs, const struct bpf_insn *insn)
 		CONT;
 
 	JMP_CALL_ARGS:
-		BPF_R0 = (__bpf_call_base_args + insn->imm)(BPF_R1, BPF_R2,
-							    BPF_R3, BPF_R4,
-							    BPF_R5,
-							    insn + insn->off + 1);
+		BPF_R0 = interpreters_args[insn->off](BPF_R1, BPF_R2, BPF_R3,
+						      BPF_R4, BPF_R5,
+						      insn + insn->imm + 1);
 		CONT;
 
 	JMP_TAIL_CALL: {
@@ -2400,12 +2402,17 @@ int bpf_patch_call_args(struct bpf_insn *insn, u32 stack_depth)
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
+
+s32 bpf_call_args_imm(s16 idx)
+{
+	if (WARN_ON_ONCE(idx < 0 || idx >= ARRAY_SIZE(interpreters_args)))
+		return 0;
+	return BPF_CALL_IMM(interpreters_args[idx]);
+}
 #endif
 #endif
 
diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
index df8f48091321..3692adf62558 100644
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
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 3b1f0ba02f61..f2e2aae5a1c1 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -4924,6 +4924,29 @@ static const struct bpf_map *bpf_map_from_imm(const struct bpf_prog *prog,
 	return map;
 }
 
+static void prepare_dump_pseudo_call(struct bpf_insn *insn)
+{
+	s32 call_off = insn->imm;
+
+	/*
+	 * BPF_CALL_ARGS only exists for interpreter fallback.
+	 * 1. For interpreter (BPF_CALL_ARGS): insn->off is the index of
+	 *    interpreters_args array, so here using bpf_call_args_imm()
+	 *    to get the real address offset.
+	 * 2. For JIT (BPF_CALL): insn->off is the subprog id.
+	 */
+	if (insn->code == (BPF_JMP | BPF_CALL_ARGS))
+		insn->imm = bpf_call_args_imm(insn->off);
+	else
+		insn->imm = insn->off;
+
+	/* Avoid dumping a truncated and misleading pc-relative offset. */
+	if (call_off > S16_MAX || call_off < S16_MIN)
+		insn->off = 0;
+	else
+		insn->off = call_off;
+}
+
 static struct bpf_insn *bpf_insn_prepare_dump(const struct bpf_prog *prog,
 					      const struct cred *f_cred)
 {
@@ -4949,6 +4972,9 @@ static struct bpf_insn *bpf_insn_prepare_dump(const struct bpf_prog *prog,
 		}
 		if (code == (BPF_JMP | BPF_CALL) ||
 		    code == (BPF_JMP | BPF_CALL_ARGS)) {
+			/* Restore the legacy xlated dump layout. */
+			if (insns[i].src_reg == BPF_PSEUDO_CALL)
+				prepare_dump_pseudo_call(&insns[i]);
 			if (code == (BPF_JMP | BPF_CALL_ARGS))
 				insns[i].code = BPF_JMP | BPF_CALL;
 			if (!bpf_dump_raw_ok(f_cred))
-- 
2.54.0

