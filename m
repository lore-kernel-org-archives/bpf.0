Received: from zg8tmja5ljk3lje4mi4ymjia.icoremail.net (zg8tmja5ljk3lje4mi4ymjia.icoremail.net [209.97.182.222])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E8542DC334
	for <bpf@vger.kernel.org>; Wed,  6 May 2026 09:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.97.182.222
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778060878; cv=none; b=O5Yl2D0ANukZIO0ogaB5d9RyVzxRxIjwlROBf4K4sm5cz0ZwnBjRpZKWCd1AlD8iEGEYKsV2zZF7fAR0lw5RUvASKieXiWpTYVxlm6ELy3kDRwALU+reJGohKvEi869hhOu/zoyTgvgVYFY5E+WDBbMuTKl+ofUyWJNPOE2EYzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778060878; c=relaxed/simple;
	bh=6QWNiAloEKAm+fO38cYKr6+peVc8sZfOi1hYpNJ0WSI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UDoIQFdLa4SlPvKO2vaO1PbvBmYZEDZoB8sRHmCYTGgtQcpWiggpdn1q9ukhh4xad/LUw/E3yX0H8wtVtnklOssTnHiyQdBBYZ8l6Gb0Dsqa/rY1G4oabpTveqhtRf9TY6HUjbBbTMGK0ufS1N2pwaLpdUHFnVCChy/Kn+xndRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=209.97.182.222
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from zju.edu.cn (unknown [10.162.163.215])
	by mtasvr (Coremail) with SMTP id _____wBHEUU4DvtpFeEWAQ--.4219S3;
	Wed, 06 May 2026 17:47:36 +0800 (CST)
Received: from lutetium.tail477849.ts.net (unknown [10.162.163.215])
	by mail-app1 (Coremail) with SMTP id yy_KCgCX5p44Dvtpn2ffAA--.1513S2;
	Wed, 06 May 2026 17:47:36 +0800 (CST)
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
	ziye@zju.edu.cn,
	Xu Kuohai <xukuohai@huawei.com>
Subject: [PATCH bpf-next v10 1/3] bpf: Fix out-of-bounds read in bpf_patch_call_args()
Date: Wed,  6 May 2026 17:47:12 +0800
Message-ID: <20260506094714.419842-2-tangyazhou@zju.edu.cn>
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
X-CM-TRANSID:yy_KCgCX5p44Dvtpn2ffAA--.1513S2
X-CM-SenderInfo: qssvjiasrsq6lmxovvfxof0/1tbiBgcDCmn6SA9E3QAAsF
X-CM-DELIVERINFO: =?B?QJ1d2QXKKxbFmtjJiESix3B1w3vD7IpoGYuur0o+r46DyAi5OfOO+T4vrW4FyUBIyu
	9q9HZcWNexokz5CY3K6SJERHdN0Tmt4VNgZ8ieigwkRA00S6SxeRQYRar7gvJ+KkX+0mHe
	yDHn43qpG7y+46CP8EFj61G0KYw+QbEQtTEJbVImmRXNGBjYI1T5yEbe3OUvmQ==
X-Coremail-Antispam: 1Uk129KBj93XoWxXF4fur4rury8ZFW5Wr4rWFX_yoW5Cw4xpF
	1DJ3W2kFWrXw4Ik343GF47Zr15Jan5urW7KFWrJry0kr42qFs7Gwn0gFnrZFyfXrn2k3yx
	Jr1I93ySk3y8W3cCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
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

The interpreters_args array only accommodates stack depths up to
MAX_BPF_STACK (512 bytes). However, do_misc_fixups() may allow a larger
stack depth if JIT is requested.

If JIT compilation later fails and falls back to the interpreter, the
verifier invokes bpf_patch_call_args() with this oversized stack depth.
This causes a load-time out-of-bounds (OOB) read when calculating the
interpreter function pointer index.

Fix this by changing bpf_patch_call_args() to return an int and explicitly
rejecting the JIT fallback (returning -EINVAL) if the stack depth exceeds
MAX_BPF_STACK.

Fixes: 1ea47e01ad6e ("bpf: add support for bpf_call to interpreter")
Co-developed-by: Tianci Cao <ziye@zju.edu.cn>
Signed-off-by: Tianci Cao <ziye@zju.edu.cn>
Co-developed-by: Shenghao Yuan <shenghaoyuan0928@163.com>
Signed-off-by: Shenghao Yuan <shenghaoyuan0928@163.com>
Signed-off-by: Yazhou Tang <tangyazhou518@outlook.com>
Acked-by: Xu Kuohai <xukuohai@huawei.com>
---
 include/linux/bpf.h | 2 +-
 kernel/bpf/core.c   | 6 +++++-
 kernel/bpf/fixups.c | 7 ++++++-
 3 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 715b6df9c403..eb6b816bc8b5 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -2922,7 +2922,7 @@ int bpf_check_uarg_tail_zero(bpfptr_t uaddr, size_t expected_size,
 int bpf_check(struct bpf_prog **fp, union bpf_attr *attr, bpfptr_t uattr, u32 uattr_size);
 
 #ifndef CONFIG_BPF_JIT_ALWAYS_ON
-void bpf_patch_call_args(struct bpf_insn *insn, u32 stack_depth);
+int bpf_patch_call_args(struct bpf_insn *insn, u32 stack_depth);
 #endif
 
 struct btf *bpf_get_btf_vmlinux(void);
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index ae10b9ca018d..fcc881909969 100644
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
index fba9e8c00878..df8f48091321 100644
--- a/kernel/bpf/fixups.c
+++ b/kernel/bpf/fixups.c
@@ -1416,7 +1416,12 @@ int bpf_fixup_call_args(struct bpf_verifier_env *env)
 		depth = get_callee_stack_depth(env, insn, i);
 		if (depth < 0)
 			return depth;
-		bpf_patch_call_args(insn, depth);
+		err = bpf_patch_call_args(insn, depth);
+		if (err) {
+			verbose(env, "stack depth %d exceeds interpreter stack depth limit\n",
+				depth);
+			return err;
+		}
 	}
 	err = 0;
 #endif
-- 
2.54.0

