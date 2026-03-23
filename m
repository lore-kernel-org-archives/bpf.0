Received: from zg8tmtyylji0my4xnjeumjiw.icoremail.net (zg8tmtyylji0my4xnjeumjiw.icoremail.net [162.243.161.220])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A2C7370D45
	for <bpf@vger.kernel.org>; Mon, 23 Mar 2026 08:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.161.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774253915; cv=none; b=gwUtCcbODHjqQhbt6jHDIk8UqPEdqTQD8AEI/DmXawgCChU/epTtUrvfcfnKnai14gAJhKg288u0gd2C2eZcLeBWJ2gY+9c15Mdx3RcjA9BCrzybN4ftQFVE0YSlqUB3HoCld9KG6C7YJt/D4y7/IgtMjOSgWVxE8HDx0wrFi/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774253915; c=relaxed/simple;
	bh=pepLG/GCr7PAzau2NiylD1ymC7QMLXA6yFGApw+R53A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mJNN1hsbK5U53pPOsEopue5xHUB640XFi6YW961ivYOuJ64RaqS1E8daYYWhXwV2zebKQSK8do29kReGd0NowGkLFz1wbMuE/47m5m+s1gufnT52pM2qlVO6qHeucREwc/gTQLX6bryqh/gXU5agshEUFn3V0wFIGORSZetn5A0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=162.243.161.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from zju.edu.cn (unknown [10.162.82.142])
	by mtasvr (Coremail) with SMTP id _____wA3PYQ398BpoM1GAA--.918S3;
	Mon, 23 Mar 2026 16:17:59 +0800 (CST)
Received: from wolframium.tail477849.ts.net (unknown [10.162.82.142])
	by mail-app4 (Coremail) with SMTP id zi_KCgDHqzQ398BpLUUMAA--.46410S2;
	Mon, 23 Mar 2026 16:17:59 +0800 (CST)
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
Subject: [PATCH bpf v2 1/3] bpf: Reject bpf-to-bpf call with large offset in interpreter
Date: Mon, 23 Mar 2026 16:17:46 +0800
Message-ID: <20260323081748.106603-2-tangyazhou@zju.edu.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323081748.106603-1-tangyazhou@zju.edu.cn>
References: <20260323081748.106603-1-tangyazhou@zju.edu.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zi_KCgDHqzQ398BpLUUMAA--.46410S2
X-CM-SenderInfo: qssvjiasrsq6lmxovvfxof0/1tbiBgMQCmm8UYsYPgACs0
X-CM-DELIVERINFO: =?B?BO8N3QXKKxbFmtjJiESix3B1w3vD7IpoGYuur0o+r46DyAi5OfOO+T4vrW4FyUBIyu
	9q9BZfZ83D7fDWWCSgyGjOU48QgaVWaYqkMj5RQZ0C68s6smzb0MvgLFjfWRppB6YrvmxP
	k9YzzyR8i2ANFjS13jUg7Ik7NIXJxXxkfjzbnJtxv1lIg0ZKxTY6jXoHQwEDjQ==
X-Coremail-Antispam: 1Uk129KBj93XoWxur1xuw48KF1UJrWrZF47trc_yoW5tw13pF
	1kKa4xtF4ktw40k347Cr47Zr13JFs5Z347KFyrA34rKr4jqan3J3s8KFsrZFyfJrn3Cw4I
	qFsF9rWIy34UWagCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUU9Kb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Cr1j6rxdM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I
	8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AK
	xVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7xvr2IYc2Ij64
	vIr40E4x8a64kEw24lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2Ij64vIr41l4I8I
	3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxV
	WUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAF
	wI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcI
	k0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j
	6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUcbyCDUUUU

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

