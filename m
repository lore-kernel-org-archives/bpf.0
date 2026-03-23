Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [52.229.168.213])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C15EC317148
	for <bpf@vger.kernel.org>; Mon, 23 Mar 2026 12:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.229.168.213
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774268619; cv=none; b=AU8Mxrqv/nsX7eCiAFY8/eUodpIeKg8zcLyMpyFRXhdMcZeTi6QL5CIkXNCK/LBwGGF2Pqz54DorE+GMumghHlqSW79FdGBoea+mH7qIG72ypTFCvwOt4vbb1eyc7768Rys7/yXpX1hbCJT3dfEdey078YlsTZxV05X7/6CzWA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774268619; c=relaxed/simple;
	bh=hlMBfzH1rlAmMpqPEEgvVWl5IVpXRRp/d2WkEDDOSJ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JpS3Li66Ajbw0vw5gGqDMxO7QRQe3z8h+eOxLKILj7BmykUVNqS/zAfFHx4FfAiX53u+r6xL9q/s5UbBYC0taZlKJP/+X7vw1GwuIH57rmWZXyCGKYvtoTROXg8ynjcqX8CoYM57/ghRPYJTxCsp9R2InC9THLcK/VqGn9EWAfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=52.229.168.213
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from zju.edu.cn (unknown [10.162.82.142])
	by mtasvr (Coremail) with SMTP id _____wCXFaSpMMFptyFIAA--.3913S3;
	Mon, 23 Mar 2026 20:23:05 +0800 (CST)
Received: from wolframium.tail477849.ts.net (unknown [10.162.82.142])
	by mail-app3 (Coremail) with SMTP id zS_KCgBXcHKpMMFpxCYOAA--.3266S2;
	Mon, 23 Mar 2026 20:23:05 +0800 (CST)
From: Yazhou Tang <tangyazhou@zju.edu.cn>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	tangyazhou518@outlook.com,
	shenghaoyuan0928@163.com,
	ziye@zju.edu.cn,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH bpf v3 1/3] bpf: Reject bpf-to-bpf call with large offset in interpreter
Date: Mon, 23 Mar 2026 20:22:52 +0800
Message-ID: <20260323122254.98540-2-tangyazhou@zju.edu.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323122254.98540-1-tangyazhou@zju.edu.cn>
References: <20260323122254.98540-1-tangyazhou@zju.edu.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zS_KCgBXcHKpMMFpxCYOAA--.3266S2
X-CM-SenderInfo: qssvjiasrsq6lmxovvfxof0/1tbiBgUTCmnARgsoRgAAsQ
X-CM-DELIVERINFO: =?B?NmyamwXKKxbFmtjJiESix3B1w3vD7IpoGYuur0o+r46DyAi5OfOO+T4vrW4FyUBIyu
	9q9FTBy7QYTsCPUa/Qus8L73AEAxz9t1pIbfYhpkqDX8lGwzIhrogwdm5Um0wQSj1NVBRZ
	QFVQRor4Z7cixmp6l/+gpyAf8u0IbW9ln938OBdLgnqU7Ug/GZaklAunEA3y6w==
X-Coremail-Antispam: 1Uk129KBj93XoWxur1xuw48KF1UJrWrZF47trc_yoW5KF13pF
	1kKa4xtF48tw40k343Cr47Zry3JFs5Z347KFyrA34Fkr4jqan7J3s8KFsrZFyfGrn3Cw4x
	tFsF9rWIy348WagCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUU9Eb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AK
	xVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI0UMc
	02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAF
	wI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0Y48IcxkI7V
	AKI48G6xCjnVAKz4kxM4IIrI8v6xkF7I0E8cxan2IY04v7MxAIw28IcxkI7VAKI48JMxC2
	0s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI
	0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE
	14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20x
	vaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8
	JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8FoGPUUUUU==

From: Yazhou Tang <tangyazhou518@outlook.com>

Currently, the BPF instruction set allows bpf-to-bpf call (or internal call,
pseudo call) to use a 32-bit imm field to represent the relative jump offset.

However, when JIT is disabled or falls back to interpreter, the verifier
invokes bpf_patch_call_args() to rewrite the call instruction. In this
function, the 32-bit imm is downcasted to s16 and stored in the `off` field.

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

Fix this by explicitly checking the offset boundary in bpf_patch_call_args().
If the offset is out of range, reject the program with -EINVAL and emit
a clear verifier log message.

Fixes: 1ea47e01ad6e ("bpf: add support for bpf_call to interpreter")
Co-developed-by: Tianci Cao <ziye@zju.edu.cn>
Signed-off-by: Tianci Cao <ziye@zju.edu.cn>
Co-developed-by: Shenghao Yuan <shenghaoyuan0928@163.com>
Signed-off-by: Shenghao Yuan <shenghaoyuan0928@163.com>
Signed-off-by: Yazhou Tang <tangyazhou518@outlook.com>
Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
---
 include/linux/bpf.h   | 2 +-
 kernel/bpf/core.c     | 7 +++++--
 kernel/bpf/verifier.c | 6 +++++-
 3 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 05b34a6355b0..5daea9f82b80 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -2916,7 +2916,7 @@ int bpf_check_uarg_tail_zero(bpfptr_t uaddr, size_t expected_size,
 int bpf_check(struct bpf_prog **fp, union bpf_attr *attr, bpfptr_t uattr, u32 uattr_size);
 
 #ifndef CONFIG_BPF_JIT_ALWAYS_ON
-void bpf_patch_call_args(struct bpf_insn *insn, u32 stack_depth);
+int bpf_patch_call_args(struct bpf_insn *insn, u32 stack_depth);
 #endif
 
 struct btf *bpf_get_btf_vmlinux(void);
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 9de5e69607c6..108c5d7b86f9 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -2402,13 +2402,16 @@ EVAL4(PROG_NAME_LIST, 416, 448, 480, 512)
 #undef PROG_NAME_LIST
 
 #ifdef CONFIG_BPF_SYSCALL
-void bpf_patch_call_args(struct bpf_insn *insn, u32 stack_depth)
+int bpf_patch_call_args(struct bpf_insn *insn, u32 stack_depth)
 {
-	stack_depth = max_t(u32, stack_depth, 1);
+	if (insn->imm < S16_MIN || insn->imm > S16_MAX)
+		return -EINVAL;
 	insn->off = (s16) insn->imm;
+	stack_depth = max_t(u32, stack_depth, 1);
 	insn->imm = interpreters_args[(round_up(stack_depth, 32) / 32) - 1] -
 		__bpf_call_base_args;
 	insn->code = BPF_JMP | BPF_CALL_ARGS;
+	return 0;
 }
 #endif
 #endif
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index f108c01ff6d0..809ac2325dcb 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -23122,7 +23122,11 @@ static int fixup_call_args(struct bpf_verifier_env *env)
 		depth = get_callee_stack_depth(env, insn, i);
 		if (depth < 0)
 			return depth;
-		bpf_patch_call_args(insn, depth);
+		err = bpf_patch_call_args(insn, depth);
+		if (err) {
+			verbose(env, "bpf-to-bpf call offset out of range for interpreter\n");
+			return err;
+		}
 	}
 	err = 0;
 #endif
-- 
2.53.0

