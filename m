Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=52.187.6.220
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792685715;
	b=5Z/TTVSazMKhnSc5o04jqJZPO1c6nKQMyR0hOhE2tUfSir48yUgGvRFTnvah7f0TbBNT
	 BV3IMRemugFqY03ntvSI+73J3PYQICg8y6DRQvmbx/kpLx6U+3vx14/8IQcj8vfUism6U
	 pmhYrIsral6y4V++DD8+j9l8s6yC9qnVEFD5k9rKOoHfo9+f7+nEUgMtR9uuRbZBmtQjD
	 lLa7t862YYFZR9Q+18YaR1PiLvSvJVsEReICLIirPpYd8Hm/yywdI2+uXlifXcnRe4DyQ
	 BIYQJrt9nhlYMDArQ96OdEGse2tPNW+TIoq0Q0VlHyZG9gjXh27jqSi6+52e9v3KpzQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792685715;
	h=DMARC-Filter:Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-CM-TRANSID:X-CM-SenderInfo:
	 X-CM-DELIVERINFO:X-Coremail-Antispam;
	bh=nE826xCLEJD5ZHftuJqSMdgXTfk7GjwT10iWohR6gIw=;
	b=t1O9z5xS4g7AL1GoXTT+84XFwYrHiX7hhqt1Kf0LUEZpdpb99PtTy7hnu94vViDl6bOI
	 7jjcikyH2AsQc23NAkQKhAaNtjZr/GzaHf89ljw1rWPd8Ilm9gRzhtxh4Mjbr5IX/hqfC
	 FGbElQbNGK5D3mi9YZZLlyZL8EYKgmSyvwfbOuXXSmue/CIZXy8qynfTclMQcp3i2FPUp
	 adxvteUKQv6B55EpNmKqWWDnlr+sGgIA+1rBr7wIva2VOKQ77yxKghyPX3U7b6iHAeVBK
	 wf4Hv0iqQfTIVONoz2HhMISNZ7kasrkigi2EJj0NbDxhBj5McNlGguBwsyQ06haK+CA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=zju.edu.cn;
	spf=pass smtp.mailfrom=zju.edu.cn;
	arc=none smtp.remote-ip=52.187.6.220
Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [52.187.6.220])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7070A606A320;
	Thu, 22 Oct 2026 16:15:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7070A606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from zju.edu.cn (unknown [10.192.73.73])
	by mtasvr (Coremail) with SMTP id _____wB3EzyANtpqUUi0AQ--.3945S3;
	Fri, 23 Oct 2026 00:14:56 +0800 (CST)
Received: from [127.0.0.1] (unknown [10.192.73.73])
	by mail-app2 (Coremail) with UTF8SMTPA id zC_KCgDHHXx8Ntpqp5N8AA--.36932S4;
	Fri, 23 Oct 2026 00:14:55 +0800 (CST)
From: Yazhou Tang <tangyazhou@zju.edu.cn>
Date: Fri, 23 Oct 2026 00:14:38 +0800
Subject: [PATCH bpf-next v3 2/7] bpf, x86: JIT UHMUL and SHMUL on x86-64
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261023-bpf-hmul-v3-2-b99e808cb28b@outlook.com>
References: <20261023-bpf-hmul-v3-0-b99e808cb28b@outlook.com>
In-Reply-To: <20261023-bpf-hmul-v3-0-b99e808cb28b@outlook.com>
To: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
 David Vernet <void@manifault.com>, bpf@ietf.org
Cc: John Fastabend <john.fastabend@gmail.com>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 Emil Tsalapatis <emil@etsalapatis.com>, 
 Ihor Solodrai <ihor.solodrai@linux.dev>, Quentin Monnet <qmo@kernel.org>, 
 Puranjay Mohan <puranjay@kernel.org>, Xu Kuohai <xukuohai@huaweicloud.com>, 
 =?utf-8?q?Bj=C3=B6rn_T=C3=B6pel?= <bjorn@kernel.org>, 
 Pu Lehui <pulehui@huawei.com>, Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Luke Nelson <luke.r.nels@gmail.com>, Xi Wang <xi.wang@gmail.com>, 
 Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, 
 Tianci Cao <ziye@zju.edu.cn>, Yazhou Tang <tangyazhou518@outlook.com>, 
 Shenghao Yuan <shenghaoyuan0928@163.com>, 
 Alexei Starovoitov <ast@kernel.org>
X-Mailer: b4 0.15.2
X-CM-TRANSID:zC_KCgDHHXx8Ntpqp5N8AA--.36932S4
X-CM-SenderInfo: qssvjiasrsq6lmxovvfxof0/1tbiBgoMCmrZFZ1O1wAAso
X-CM-DELIVERINFO: =?B?uZIQCgXKKxbFmtjJiESix3B1w3vD7IpoGYuur0o+r46DyAi5OfOO+T4vrW4FyUBIyu
	9q9HIk87VlnPlgT0flwOg+OZEYBBrlbBt14j71g2g+WT5ej/zpX86Yli1thGqDdrJ9lz2y
	+UYAa8tO1tZGO/9TSUZHlfcxsfLxYWtvTcNJVJbCX06BBENacVVgBpyvWt0s0A==
X-Coremail-Antispam: 1Uk129KBj93XoWxtr17Gr4UAw17Aw4rXFy8tFc_yoW7Cw1rpF
	4kWrn3CF4kZws7JrZrXa1xArnxJF4xWr18Ca47W3yxJ3WaqF1xWF4xKa4aq3s8CryFqa4f
	tr4qkr9xCa4kWFXCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUU9Kb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWUJVW8JwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I
	8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AK
	xVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7xvr2IYc2Ij64
	vIr40E4x8a64kEw24lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2Ij64vIr41l4I8I
	3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxV
	WUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAF
	wI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcI
	k0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j
	6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU2QJ5DUUUU

From: Tianci Cao <ziye@zju.edu.cn>

JIT the UHMUL and SHMUL instructions with the one-operand x86-64 mul and
imul instructions. These instructions multiply RAX by an explicit
source and return the full product in RDX:RAX, so the desired high half
is available in RDX.

Copy register or immediate sources into AUX_REG, load the destination
into RAX, and move RDX back to the BPF destination after multiplication.
Preserve RAX and RDX when they hold other live BPF registers, while
handling BPF_REG_0 and BPF_REG_3 destinations without restoring over the
result.

Leave the existing JIT handling of ordinary BPF_MUL unchanged.

Add bpf_insn_is_hmul() to identify the high-half multiplication variants.
Introduce bpf_jit_supports_hmul() with a weak default returning false,
and override it to return true for the x86-64 JIT. This allows the
verifier to check JIT support without adding rejection logic to every
unsupported backend.

Link: https://lore.kernel.org/bpf/CAADnVQ+2O2zgdy11+vxE6dOp+3Br4zZBysHF-Hne7cP+eeucnQ@mail.gmail.com/
Suggested-by: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Signed-off-by: Tianci Cao <ziye@zju.edu.cn>
Co-developed-by: Yazhou Tang <tangyazhou518@outlook.com>
Signed-off-by: Yazhou Tang <tangyazhou518@outlook.com>
Co-developed-by: Shenghao Yuan <shenghaoyuan0928@163.com>
Signed-off-by: Shenghao Yuan <shenghaoyuan0928@163.com>
---
 arch/x86/net/bpf_jit_comp.c | 53 +++++++++++++++++++++++++++++++++++++++++++++
 include/linux/filter.h      |  8 +++++++
 kernel/bpf/core.c           |  6 +++++
 3 files changed, 67 insertions(+)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 6a2fe3d0039d..2707e8fb9799 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -1378,6 +1378,38 @@ static int emit_kasan_check(struct bpf_verifier_env *env, u8 **pprog,
 	return 0;
 }
 
+/*
+ * The one-operand x86 mul/imul forms use RAX as the implicit first
+ * operand and store the 128-bit product in RDX:RAX.
+ * The JIT uses AUX_REG as the explicit second operand.
+ */
+static void emit_hmul_aux(u8 **pprog, u32 dst_reg, bool is_signed)
+{
+	u8 *prog = *pprog;
+	bool save_rax = dst_reg != BPF_REG_0;
+	bool save_rdx = dst_reg != BPF_REG_3;
+	u8 mul_modrm_base = is_signed ? 0xE8 : 0xE0; /* imul /5 or mul /4 */
+
+	if (save_rax)
+		EMIT1(0x50); /* push rax */
+	if (save_rdx)
+		EMIT1(0x52); /* push rdx */
+
+	if (save_rax)
+		emit_mov_reg(&prog, true, BPF_REG_0, dst_reg);
+	maybe_emit_1mod(&prog, AUX_REG, true);
+	EMIT2(0xF7, add_1reg(mul_modrm_base, AUX_REG));
+	if (save_rdx)
+		emit_mov_reg(&prog, true, dst_reg, BPF_REG_3);
+
+	if (save_rdx)
+		EMIT1(0x5A); /* pop rdx */
+	if (save_rax)
+		EMIT1(0x58); /* pop rax */
+
+	*pprog = prog;
+}
+
 /* LDX: dst_reg = *(u8*)(src_reg + off) */
 static void emit_ldx(u8 **pprog, u32 size, u32 dst_reg, u32 src_reg, int off)
 {
@@ -2916,6 +2948,14 @@ static int do_jit(struct bpf_verifier_env *env, struct bpf_prog *bpf_prog, int *
 
 		case BPF_ALU | BPF_MUL | BPF_K:
 		case BPF_ALU64 | BPF_MUL | BPF_K:
+			if (bpf_insn_is_hmul(insn)) {
+				/* imul/mul use AUX_REG as src. */
+				emit_mov_imm32(&prog, true, AUX_REG, imm32);
+				emit_hmul_aux(&prog, dst_reg,
+					      insn->off == BPF_SHMUL);
+				break;
+			}
+
 			/*
 			 * lea for 3, 5 and 9, which LLVM leaves as a
 			 * multiplication, but not for r13, which needs a
@@ -2951,6 +2991,14 @@ static int do_jit(struct bpf_verifier_env *env, struct bpf_prog *bpf_prog, int *
 
 		case BPF_ALU | BPF_MUL | BPF_X:
 		case BPF_ALU64 | BPF_MUL | BPF_X:
+			if (bpf_insn_is_hmul(insn)) {
+				/* imul/mul use AUX_REG as src. */
+				emit_mov_reg(&prog, true, AUX_REG, src_reg);
+				emit_hmul_aux(&prog, dst_reg,
+					      insn->off == BPF_SHMUL);
+				break;
+			}
+
 			maybe_emit_mod(&prog, src_reg, dst_reg,
 				       BPF_CLASS(insn->code) == BPF_ALU64);
 
@@ -5126,6 +5174,11 @@ bool bpf_jit_supports_unwind(void)
 	return true;
 }
 
+bool bpf_jit_supports_hmul(void)
+{
+	return true;
+}
+
 const struct bpf_jit_arg_abi *bpf_jit_arg_abi(void)
 {
 	return &x86_arg_abi;
diff --git a/include/linux/filter.h b/include/linux/filter.h
index e0ee8adf3949..2a2101fb0168 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -178,6 +178,13 @@ static inline u64 bpf_shmul64(s64 a, s64 b)
 	return hi;
 }
 
+static inline bool bpf_insn_is_hmul(const struct bpf_insn *insn)
+{
+	return BPF_CLASS(insn->code) == BPF_ALU64 &&
+	       BPF_OP(insn->code) == BPF_MUL &&
+	       (insn->off == BPF_UHMUL || insn->off == BPF_SHMUL);
+}
+
 /* Endianess conversion, cpu_to_{l,b}e(), {l,b}e_to_cpu() */
 
 #define BPF_ENDIAN(TYPE, DST, LEN)				\
@@ -1307,6 +1314,7 @@ bool bpf_jit_supports_kfunc_call(void);
 bool bpf_jit_supports_callx(void);
 bool bpf_jit_supports_kfunc_ret_reg_pair(void);
 bool bpf_jit_supports_unwind(void);
+bool bpf_jit_supports_hmul(void);
 bool bpf_jit_supports_stack_args(void);
 bool bpf_jit_supports_arena_args(void);
 bool bpf_jit_supports_far_kfunc_call(void);
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index f4f8cfa80033..8600c9384217 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -3444,6 +3444,12 @@ bool __weak bpf_jit_supports_unwind(void)
 	return false;
 }
 
+/* uhmul and shmul */
+bool __weak bpf_jit_supports_hmul(void)
+{
+	return false;
+}
+
 /*
  * How this arch places a by-value kfunc argument, or NULL for one that has
  * not opted in and so only takes an argument of a single eightbyte, which

-- 
2.56.0

