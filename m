Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [52.175.55.52])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC0A8336EE1
	for <bpf@vger.kernel.org>; Thu, 26 Mar 2026 06:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.175.55.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774506879; cv=none; b=hvUlM3U+NXjl+KKlnXzXKkGRPeJz/ADMdx1TMvNjngowjmQ0OcKt6bG5pimARIvH1vooxNw11E+P+Nr2a7nh1hj7K97gOLMccBy2BBYlAdIBgpbsUKjgB3lSJeQPqfRKjkOPs/38dsufbk5iHTPeMgnK7z/Eg9+fUNDEJ9W96H0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774506879; c=relaxed/simple;
	bh=pepLG/GCr7PAzau2NiylD1ymC7QMLXA6yFGApw+R53A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J5LDmjhbHV8Tcwvy0iZY8b0ER7df8BKfDUo0gG7eizv0qgy5CzETT26RUvnOZuUNh6E0eOUJdwhEry7Gu3Api5LVFlUhZEBfPkSllgWYb3EvhnA4PvB5pgpSpcYcYDSOeas9uNoo98VUNp68bmmJvgdAt88rcILI9ZwUaFeozjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=52.175.55.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from zju.edu.cn (unknown [115.236.2.94])
	by mtasvr (Coremail) with SMTP id _____wCHwAlX08Rp1OAEAA--.12313S3;
	Thu, 26 Mar 2026 14:33:59 +0800 (CST)
Received: from wolframium.tail477849.ts.net (unknown [115.236.2.94])
	by mail-app2 (Coremail) with SMTP id zC_KCgA3p8xP08RpWXkqAA--.13527S2;
	Thu, 26 Mar 2026 14:33:52 +0800 (CST)
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
Subject: [PATCH bpf v4 1/3] bpf: Reject bpf-to-bpf call with large offset in interpreter
Date: Thu, 26 Mar 2026 14:33:27 +0800
Message-ID: <20260326063329.10031-2-tangyazhou@zju.edu.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260326063329.10031-1-tangyazhou@zju.edu.cn>
References: <20260326063329.10031-1-tangyazhou@zju.edu.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zC_KCgA3p8xP08RpWXkqAA--.13527S2
X-CM-SenderInfo: qssvjiasrsq6lmxovvfxof0/1tbiBhIBCmnC6QtZNQACs4
X-CM-DELIVERINFO: =?B?Lro5xgXKKxbFmtjJiESix3B1w3vD7IpoGYuur0o+r46DyAi5OfOO+T4vrW4FyUBIyu
	9q9EgOJRkhWYhllRvpYFmgQv9K+L4xOUibAgVoSSQxE+WFuAf6rK8wtZ+4HFETJro1ROSD
	pdlptszDfcFEuVdrMi5dbca2UIfDQQRRGHMBMSfaZCKUz6T9Wo2HR2QbHyhYKQ==
X-Coremail-Antispam: 1Uk129KBj93XoWxur1xuw48KF1UJrWrZF47trc_yoW5tw13pF
	1kKa4xtF4ktw40k347Cr47Zr13JFs5Z347KFyrA34rKr4jqan3J3s8KFsrZFyfJrn3Cw4I
	qFsF9rWIy34UWagCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUU9Eb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
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
	JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU1Hq2tUUUUU==

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
index 39ddc7eb49b1..471ce73b760e 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -2396,13 +2396,16 @@ EVAL4(PROG_NAME_LIST, 416, 448, 480, 512)
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
index df22bfc572e2..702579f56f7d 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -23112,7 +23112,11 @@ static int fixup_call_args(struct bpf_verifier_env *env)
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

