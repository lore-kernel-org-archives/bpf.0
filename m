Received: from zg8tmja5ljk3lje4mi4ymjia.icoremail.net (zg8tmja5ljk3lje4mi4ymjia.icoremail.net [209.97.182.222])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34A7717BA2
	for <bpf@vger.kernel.org>; Mon, 16 Mar 2026 19:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.97.182.222
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773687793; cv=none; b=Uhj3fMvAQaNRhfNxRt+Ay+/sOzx/XYnOaKEz3CpDIUuq6TzoIdSqzvpwXg+qllzSLBIZNCUexJFpha2eV0myiCfsdlnRcmjuEeF7g18nWGeMafRx0ujVJSv2oG4G9aPn6IQeTiw1XoS8v7xoNnV0ttLaetNIusaoNXC/d3En70s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773687793; c=relaxed/simple;
	bh=8pl2m5FDjuNFdT4s3PuLSUfpRSJvtJgVl6p2+YNKFpw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mvsZS7dmsrZDrxi3ia0NZM5GEzXFVsXxaTufP4me/ygj3BhVKWnCbaA92CMt3PRHpke4fDilohsWKf/Inxlm3nPkfd/vS+fvLkGB2mvwG8scC/CqdFAAvgcc1eb6RSRb2Jmn/jZ/kHeTpSP4pFxql42NlpKlVPeZ3Bn3HMxMCjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=209.97.182.222
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from zju.edu.cn (unknown [10.162.192.132])
	by mtasvr (Coremail) with SMTP id _____wDHGDjMU7hpU9gfAA--.5240S3;
	Tue, 17 Mar 2026 03:02:36 +0800 (CST)
Received: from wolframium.tail477849.ts.net (unknown [10.162.192.132])
	by mail-app3 (Coremail) with SMTP id zS_KCgBXNWfMU7hpfPq4Bg--.11360S2;
	Tue, 17 Mar 2026 03:02:36 +0800 (CST)
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
	ziye@zju.edu.cn
Subject: [PATCH bpf 1/2] bpf: reject bpf-to-bpf call with large offset in interpreter
Date: Tue, 17 Mar 2026 03:02:19 +0800
Message-ID: <20260316190220.113417-2-tangyazhou@zju.edu.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260316190220.113417-1-tangyazhou@zju.edu.cn>
References: <20260316190220.113417-1-tangyazhou@zju.edu.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zS_KCgBXNWfMU7hpfPq4Bg--.11360S2
X-CM-SenderInfo: qssvjiasrsq6lmxovvfxof0/1tbiBhILCmm1ugoVzwADsg
X-CM-DELIVERINFO: =?B?8hQlsgXKKxbFmtjJiESix3B1w3vD7IpoGYuur0o+r46DyAi5OfOO+T4vrW4FyUBIyu
	9q9Ed38ain3iGL/cGOK3OqJ6biWplNSP28A51Ahop46MdRtpXyz36wQiNfBnFml4y5L0W+
	ruGwEgxexgm6iRYrrtc2xQ9OCKRZ5Q54tKV2TwRTj4OOXSR8EogD8O//E8a33Q==
X-Coremail-Antispam: 1Uk129KBj93XoWxur1xuw48KF1UJr1rWF4fXrc_yoW5Gr1rpr
	WkKa4IgFykJw4Ikw47Ar4xuF15GFs3J3y7GFWrC34fKws8GFy0yFy5KrW7Xa4fGrn3Cw4Y
	qrsF9a4Ikw4UGagCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUU9Eb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6r4j6r4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI0UMc
	02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAF
	wI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0Y48IcxkI7V
	AKI48G6xCjnVAKz4kxM4IIrI8v6xkF7I0E8cxan2IY04v7MxAIw28IcxkI7VAKI48JMxC2
	0s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI
	0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE
	14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20x
	vaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8
	JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU1yrW5UUUUU==

From: Yazhou Tang <tangyazhou518@outlook.com>

Currently, the BPF instruction set allows bpf-to-bpf call (or internal call,
pseudo call) to use a 32-bit `imm` field to represent the relative jump offset.

However, when JIT is disabled or falls back to interpreter, the verifier
invokes `bpf_patch_call_args()` to rewrite the call instruction. In this
function, the 32-bit `imm` is downcasted to s16 and stored in the `off` field.

```c
void bpf_patch_call_args(struct bpf_insn *insn, u32 stack_depth)
{
	stack_depth = max_t(u32, stack_depth, 1);
	insn->off = (s16) insn->imm;
	insn->imm = interpreters_args[(round_up(stack_depth, 32) / 32) - 1] -
		__bpf_call_base_args;
	insn->code = BPF_JMP | BPF_CALL_ARGS;
}
```

If the original `imm` exceeds the s16 range (i.e., jump offset > 32KB),
this downcast silently truncates the offset, resulting in an incorrect
call target.

Fix this by explicitly checking the offset boundary in `fixup_call_args()`.
If the offset is out of range, reject the program with -EINVAL and emit
a clear verifier log message.

Co-developed-by: Tianci Cao <ziye@zju.edu.cn>
Signed-off-by: Tianci Cao <ziye@zju.edu.cn>
Co-developed-by: Shenghao Yuan <shenghaoyuan0928@163.com>
Signed-off-by: Shenghao Yuan <shenghaoyuan0928@163.com>
Signed-off-by: Yazhou Tang <tangyazhou518@outlook.com>
---

We also evaluated a potentially more fundamental fix: patching the instruction
stream in `do_misc_fixups()` to mov the 32-bit `imm` into an auxiliary register
(`BPF_REG_AX`) prior to the call, and then utilizing `BPF_REG_AX` to resolve
the jump target in the interpreter.

To avoid degrading performance, this patching must be strictly confined to
cases where JIT is disabled. However, reliably determining the final JIT
execution status during the verification stage is not easy. Therefore, we
opted for the simplest and safest fix for now.

 kernel/bpf/verifier.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index df22bfc572e2..0ee8a3333193 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -23109,6 +23109,12 @@ static int fixup_call_args(struct bpf_verifier_env *env)
 
 		if (!bpf_pseudo_call(insn))
 			continue;
+
+		if (insn->imm < S16_MIN || insn->imm > S16_MAX) {
+			verbose(env, "bpf-to-bpf call offset out of range for interpreter\n");
+			return -EINVAL;
+		}
+
 		depth = get_callee_stack_depth(env, insn, i);
 		if (depth < 0)
 			return depth;
-- 
2.53.0

