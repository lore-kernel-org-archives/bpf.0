Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C917535F16B
	for <bpf@vger.kernel.org>; Wed, 29 Apr 2026 17:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.164.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777483205; cv=none; b=VuqKio217Qqa3Wk3N+Um89vaunzyX13tkEBBsuZaN4kiYDjecg9DGee8zvBLMoosKu0K/RujhZfd8Cux9TWSLfWEgoOGBCynHNCdIEaKALOUb05rJp98u2iip9o/YZUbuMY38Njsiz/lpUFwQizgfh2+AvkSXDRSZS+3XSpoxGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777483205; c=relaxed/simple;
	bh=hKbybxsRTbKx9iT9R+I1oa5EIAFcoNwQG1qGp0/z4Lw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q0OZzpfnFzj8mkRrMNLhFvWp0H9RzKmNW8Easwe/7FmgTayjh5VXFwJcjwKi9Ce/vLsCSn6hc1e/Ke6jElmWuFNnMzl66wQSwJeE8QZKipUDyshv6e/XYax8XmcQn4BTZTOCroB6YshDykeRpBY2/6hLNFMqyWTOagFk865O6ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=162.243.164.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from zju.edu.cn (unknown [112.10.248.232])
	by mtasvr (Coremail) with SMTP id _____wDn7z+qPfJpzu3iAA--.5884S3;
	Thu, 30 Apr 2026 01:19:38 +0800 (CST)
Received: from wolframium.tail477849.ts.net (unknown [112.10.248.232])
	by mail-app2 (Coremail) with SMTP id zC_KCgAnmM2mPfJpFHfsAA--.28035S2;
	Thu, 30 Apr 2026 01:19:37 +0800 (CST)
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
Subject: [PATCH bpf-next v9 1/3] bpf: Fix out-of-bounds read in bpf_patch_call_args()
Date: Thu, 30 Apr 2026 01:19:02 +0800
Message-ID: <20260429171904.107244-2-tangyazhou@zju.edu.cn>
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
X-CM-TRANSID:zC_KCgAnmM2mPfJpFHfsAA--.28035S2
X-CM-SenderInfo: qssvjiasrsq6lmxovvfxof0/1tbiAgMQCmnxDY5J4AAAsp
X-CM-DELIVERINFO: =?B?GfwfegXKKxbFmtjJiESix3B1w3vD7IpoGYuur0o+r46DyAi5OfOO+T4vrW4FyUBIyu
	9q9JbrTQrMiN5RXULcsl7pn2aP6rKTp6s5rZCw1xZMO6SxiNIfQMh/VCwxdZGtMw2baInR
	FB6fs10b/PVh/m2u8ue4YAfjdlMM2Ipe4QR+kY3GyUn0cVa1tQaXI36YXbHBzw==
X-Coremail-Antispam: 1Uk129KBj93XoWxXF4fur4rury8ZFW5Wr4rWFX_yoW5CF1rpF
	1DJ3W2kF4rXw4Ik347GF47Zr15JFs5ZrW7KFWrJ340kr42qFs7Jrn0gFnrZFWfXrnak3yx
	Jr1I93ySk3y8W3cCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUBjb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26r1j6r4UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8JVW8Jr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27w
	Aqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE
	14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjcxG0xvY0x
	0EwIxGrVCF72vEw4AK0wACI402YVCY1x02628vn2kIc2xKxwCF04k20xvY0x0EwIxGrwCF
	x2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14
	v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY
	67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2
	IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_
	Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UNtxhUUUUU=

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
---
 include/linux/bpf.h | 2 +-
 kernel/bpf/core.c   | 6 +++++-
 kernel/bpf/fixups.c | 6 +++++-
 3 files changed, 11 insertions(+), 3 deletions(-)

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
2.54.0

