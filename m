Received: from zg8tmja5ljk3lje4mi4ymjia.icoremail.net (zg8tmja5ljk3lje4mi4ymjia.icoremail.net [209.97.182.222])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA65C3D905F
	for <bpf@vger.kernel.org>; Tue, 21 Apr 2026 14:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.97.182.222
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776782760; cv=none; b=cSrQnab74TmpjArJN36aAPZ6aTMfP1D3IHGtanh01LWv2oi9Ek7g/fEisR9Dr9ZmmvkrKItRz6RN5+TRbWDMVXRHdBbBae1CKi2UdavXG8axUnDhHX/JEQzXUC82so5cZFJCdN94cHtLFdlIU1TmZ8p7H63ByFbjpd95/kG09w8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776782760; c=relaxed/simple;
	bh=WMvf9ItEouMO+yGMdGK3Z63JxRtY0pwCKfeUe9LA3fQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jQderLPg3EhJAYFdgo1kgn8KwJcXwybgGvW5Raz+6OwlW9Y3LKNV1+YRl+zt02Q6kiP27muD8MZ9b4HLY/0iWDJwoK8XcoEm2c+NJP5Z81zGtXhoLi35ANp3RP144sgoUdqvtiGnVQXo6K2nSHfjxI7ilAmr6i6NmMDa+EO/eKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=209.97.182.222
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from zju.edu.cn (unknown [10.162.235.246])
	by mtasvr (Coremail) with SMTP id _____wAn4jyDjedpGH+cAA--.6766S3;
	Tue, 21 Apr 2026 22:45:23 +0800 (CST)
Received: from wolframium.tail477849.ts.net (unknown [10.162.235.246])
	by mail-app3 (Coremail) with SMTP id zS_KCgC3zW+Cjedp4+2dAA--.52257S2;
	Tue, 21 Apr 2026 22:45:22 +0800 (CST)
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
Subject: [PATCH bpf-next v7 1/3] bpf: Fix out-of-bounds read in bpf_patch_call_args()
Date: Tue, 21 Apr 2026 22:45:02 +0800
Message-ID: <20260421144504.823756-2-tangyazhou@zju.edu.cn>
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
X-CM-TRANSID:zS_KCgC3zW+Cjedp4+2dAA--.52257S2
X-CM-SenderInfo: qssvjiasrsq6lmxovvfxof0/1tbiAgcICmnmgY0TDgACsb
X-CM-DELIVERINFO: =?B?3YP5VAXKKxbFmtjJiESix3B1w3vD7IpoGYuur0o+r46DyAi5OfOO+T4vrW4FyUBIyu
	9q9N9K5WE5sTF3JnYhkXfPC+X/RNfp+puaFMC8eAp95Y+jZX2f4m6G1LN7d6ndbKiHDxjr
	dCH6AkLQDhRlC6crhuJroJ0gg1J9nc0n+o9ldxksdlm0lZX4TahXWjPdZrNcuw==
X-Coremail-Antispam: 1Uk129KBj93XoWxXF4fur4rury8ZFW5Wr4rWFX_yoW5Aw1rpF
	1DJ3WIkFW8Jw4Ik347GF47Zr15JFs5ZFW7KayrJ340kr42qFs7Jrn0gFnFvFWfXrsak3yx
	Jr1I934Sk3yxW3cCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
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

The interpreters_args array only accommodates stack depths up to MAX_BPF_STACK
(512 bytes). However, do_misc_fixups() may allow a larger stack depth if JIT
is requested.

If JIT compilation later fails and falls back to the interpreter, the verifier
invokes bpf_patch_call_args() with this oversized stack depth. This causes a
load-time out-of-bounds (OOB) read when calculating the interpreter function
pointer index.

Fix this by changing bpf_patch_call_args() to return an int and explicitly
rejecting the JIT fallback (returning -EINVAL) if the stack depth exceeds
MAX_BPF_STACK.

Co-developed-by: Tianci Cao <ziye@zju.edu.cn>
Signed-off-by: Tianci Cao <ziye@zju.edu.cn>
Co-developed-by: Shenghao Yuan <shenghaoyuan0928@163.com>
Signed-off-by: Shenghao Yuan <shenghaoyuan0928@163.com>
Signed-off-by: Yazhou Tang <tangyazhou518@outlook.com>
---
 include/linux/bpf.h | 2 +-
 kernel/bpf/core.c   | 6 +++++-
 kernel/bpf/fixups.c | 6 +++++-
 3 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 3cb6b9e70080..9fb24a5f31ac 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -2917,7 +2917,7 @@ int bpf_check_uarg_tail_zero(bpfptr_t uaddr, size_t expected_size,
 int bpf_check(struct bpf_prog **fp, union bpf_attr *attr, bpfptr_t uattr, u32 uattr_size);
 
 #ifndef CONFIG_BPF_JIT_ALWAYS_ON
-void bpf_patch_call_args(struct bpf_insn *insn, u32 stack_depth);
+int bpf_patch_call_args(struct bpf_insn *insn, u32 stack_depth);
 #endif
 
 struct btf *bpf_get_btf_vmlinux(void);
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 8b018ff48875..63044ebe5721 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -2394,13 +2394,17 @@ EVAL4(PROG_NAME_LIST, 416, 448, 480, 512)
 #undef PROG_NAME_LIST
 
 #ifdef CONFIG_BPF_SYSCALL
-void bpf_patch_call_args(struct bpf_insn *insn, u32 stack_depth)
+int bpf_patch_call_args(struct bpf_insn *insn, u32 stack_depth)
 {
 	stack_depth = max_t(u32, stack_depth, 1);
+	/* Prevent out-of-bounds read to interpreters_args */
+	if (stack_depth > MAX_BPF_STACK)
+		return -EINVAL;
 	insn->off = (s16) insn->imm;
 	insn->imm = interpreters_args[(round_up(stack_depth, 32) / 32) - 1] -
 		__bpf_call_base_args;
 	insn->code = BPF_JMP | BPF_CALL_ARGS;
+	return 0;
 }
 #endif
 #endif
diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
index fba9e8c00878..300e4e251931 100644
--- a/kernel/bpf/fixups.c
+++ b/kernel/bpf/fixups.c
@@ -1416,7 +1416,11 @@ int bpf_fixup_call_args(struct bpf_verifier_env *env)
 		depth = get_callee_stack_depth(env, insn, i);
 		if (depth < 0)
 			return depth;
-		bpf_patch_call_args(insn, depth);
+		err = bpf_patch_call_args(insn, depth);
+		if (err) {
+			verbose(env, "interpreter stack depth %d is too large\n", depth);
+			return err;
+		}
 	}
 	err = 0;
 #endif
-- 
2.53.0

