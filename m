Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.243.161.220
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792685713;
	b=Bwl2Nwx8B8jpYduvYCqjXNBHaN8pLo55+v0hMwNtJcNPnbxgUwtT1eNHHSPIed9KDTT6
	 P7qfVPuSs1Ux00RSJLJ7ngZ+Cg0ZjnZaEhygpY/T1WuQ0vCVcDvOEPEIYeYl/BsL60FNm
	 SPPrrof7JIcIkFRKIGZmH7wOZoystpFo4CR1wMKpe0vEGynt/g22SFRyxEGZJOfjAVXvq
	 hWEhXSwK/Pj3ZrNZZrbdzN/byyMZoTn5ilVyhgcmOkbTWR/7VXM9Ob8OmcNdGJqVtF7QK
	 TsQqMpqnBvfuQs9WZzvo+jpjM00oGBKyhPv507g5L0UOjnoo+1bnq8Pqo3OY5bTQOPQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792685713;
	h=DMARC-Filter:Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-CM-TRANSID:X-CM-SenderInfo:
	 X-CM-DELIVERINFO:X-Coremail-Antispam;
	bh=8tfp3QAPuDEdybi+FBKOLURn8tz+g3+bHd+95vIfOC0=;
	b=Z4ujMh8Z+vr09xFdW/YeTVVPEo88f+vDbsaYXaRIYqW1zpIGAtKsbmw+oCuE1vg4Me7O
	 QQAHPVH9RJVIqZ89oe6Js53djwRJ4DToLy+zt7pB5RU5zQzDbJT5O9Ep/OSXtwvfOuFVB
	 EPgB9GcMSl96tNkvrc+n+zeRewkR0PM31QI5lsrpv2gqA1WAeEf6N6EZTzCB571371ryZ
	 LM+6jyzJc5Y3JFHXNV4AjLsVoBipmZ4yiZeU2khsgJoYvrWp4CQEjQmFiBDkFYW0iBNfq
	 Cld2SH4FS5b/wckQgV0kSGEekZOFgUWcgKV9xuku76/IhaEduG1OWtCoRddM/ZB3P+g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=zju.edu.cn;
	spf=pass smtp.mailfrom=zju.edu.cn;
	arc=none smtp.remote-ip=162.243.161.220
Received: from zg8tmtyylji0my4xnjeumjiw.icoremail.net (zg8tmtyylji0my4xnjeumjiw.icoremail.net [162.243.161.220])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50168606A31B;
	Thu, 22 Oct 2026 16:15:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 50168606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from zju.edu.cn (unknown [10.192.73.73])
	by mtasvr (Coremail) with SMTP id _____wBnJGSBNtpqU0i0AQ--.983S3;
	Fri, 23 Oct 2026 00:14:57 +0800 (CST)
Received: from [127.0.0.1] (unknown [10.192.73.73])
	by mail-app2 (Coremail) with UTF8SMTPA id zC_KCgDHHXx8Ntpqp5N8AA--.36932S5;
	Fri, 23 Oct 2026 00:14:56 +0800 (CST)
From: Yazhou Tang <tangyazhou@zju.edu.cn>
Date: Fri, 23 Oct 2026 00:14:39 +0800
Subject: [PATCH bpf-next v3 3/7] bpf, arm64: JIT UHMUL and SHMUL
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
Message-Id: <20261023-bpf-hmul-v3-3-b99e808cb28b@outlook.com>
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
 Yazhou Tang <tangyazhou518@outlook.com>, Tianci Cao <ziye@zju.edu.cn>, 
 Shenghao Yuan <shenghaoyuan0928@163.com>, 
 Alexei Starovoitov <ast@kernel.org>
X-Mailer: b4 0.15.2
X-CM-TRANSID:zC_KCgDHHXx8Ntpqp5N8AA--.36932S5
X-CM-SenderInfo: qssvjiasrsq6lmxovvfxof0/1tbiBgoMCmrZFZ1O1wABsp
X-CM-DELIVERINFO: =?B?4q5n2AXKKxbFmtjJiESix3B1w3vD7IpoGYuur0o+r46DyAi5OfOO+T4vrW4FyUBIyu
	9q9HIk87VlnPlgT0flwOg+OZGV997bwYzJFqEUm6fkTD3ogLq+0FotimyGWsZSt1sQ4D2y
	+UYAa8tO1tZGO/9TSUZHlfcxsfLxYWtvTcNJVJbC+sM5DI0YfmFrvRF/czRiuA==
X-Coremail-Antispam: 1Uk129KBj93XoW3Xr13ZFyDtFWDZw1rCw1fZrc_yoW7Xw4fpw
	n8urWSkrWkWF1fGF97trnrZr4Yka1Fgr4DK34Uu3yrKan8Xa4UGF4Sg3y2vFs8Gryjga9Y
	qFyj9r1S9aykXabCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUU9Kb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
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
	6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU2D73DUUUU

From: Yazhou Tang <tangyazhou518@outlook.com>

arm64 provides UMULH and SMULH instructions that return the high 64 bits
of an unsigned or signed 64-bit multiplication, respectively.

Add encodings for these instructions and use them to lower the UHMUL and
SHMUL BPF_MUL variants for both register and immediate sources. Keep the
existing low-half and ALU32 multiplication lowering unchanged.

Opt the arm64 JIT into HMUL support by returning true from
bpf_jit_supports_hmul().

Suggested-by: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Signed-off-by: Yazhou Tang <tangyazhou518@outlook.com>
Co-developed-by: Tianci Cao <ziye@zju.edu.cn>
Signed-off-by: Tianci Cao <ziye@zju.edu.cn>
Co-developed-by: Shenghao Yuan <shenghaoyuan0928@163.com>
Signed-off-by: Shenghao Yuan <shenghaoyuan0928@163.com>
---
 arch/arm64/include/asm/insn.h |  4 ++++
 arch/arm64/lib/insn.c         |  6 ++++++
 arch/arm64/net/bpf_jit.h      |  6 ++++++
 arch/arm64/net/bpf_jit_comp.c | 20 ++++++++++++++++++--
 4 files changed, 34 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/insn.h b/arch/arm64/include/asm/insn.h
index 1ce75a442638..f38738fa54a2 100644
--- a/arch/arm64/include/asm/insn.h
+++ b/arch/arm64/include/asm/insn.h
@@ -247,6 +247,8 @@ enum aarch64_insn_data2_type {
 enum aarch64_insn_data3_type {
 	AARCH64_INSN_DATA3_MADD,
 	AARCH64_INSN_DATA3_MSUB,
+	AARCH64_INSN_DATA3_SMULH,
+	AARCH64_INSN_DATA3_UMULH,
 };
 
 enum aarch64_insn_logic_type {
@@ -396,6 +398,8 @@ __AARCH64_INSN_FUNCS(sub_ext,	0x7FE00000, 0x4B200000)
 __AARCH64_INSN_FUNCS(subs_ext,	0x7FE00000, 0x6B200000)
 __AARCH64_INSN_FUNCS(madd,	0x7FE08000, 0x1B000000)
 __AARCH64_INSN_FUNCS(msub,	0x7FE08000, 0x1B008000)
+__AARCH64_INSN_FUNCS(smulh,	0x7FE0FC00, 0x1B407C00)
+__AARCH64_INSN_FUNCS(umulh,	0x7FE0FC00, 0x1BC07C00)
 __AARCH64_INSN_FUNCS(udiv,	0x7FE0FC00, 0x1AC00800)
 __AARCH64_INSN_FUNCS(sdiv,	0x7FE0FC00, 0x1AC00C00)
 __AARCH64_INSN_FUNCS(lslv,	0x7FE0FC00, 0x1AC02000)
diff --git a/arch/arm64/lib/insn.c b/arch/arm64/lib/insn.c
index e70ac0238515..dc483d1b8bd5 100644
--- a/arch/arm64/lib/insn.c
+++ b/arch/arm64/lib/insn.c
@@ -1155,6 +1155,12 @@ u32 aarch64_insn_gen_data3(enum aarch64_insn_register dst,
 	case AARCH64_INSN_DATA3_MSUB:
 		insn = aarch64_insn_get_msub_value();
 		break;
+	case AARCH64_INSN_DATA3_SMULH:
+		insn = aarch64_insn_get_smulh_value();
+		break;
+	case AARCH64_INSN_DATA3_UMULH:
+		insn = aarch64_insn_get_umulh_value();
+		break;
 	default:
 		pr_err("%s: unknown data3 encoding %d\n", __func__, type);
 		return AARCH64_BREAK_FAULT;
diff --git a/arch/arm64/net/bpf_jit.h b/arch/arm64/net/bpf_jit.h
index b2fe6e6dcf44..70fc329c661d 100644
--- a/arch/arm64/net/bpf_jit.h
+++ b/arch/arm64/net/bpf_jit.h
@@ -281,6 +281,12 @@
 	A64_VARIANT(sf), AARCH64_INSN_DATA3_MSUB)
 /* Rd = Rn * Rm */
 #define A64_MUL(sf, Rd, Rn, Rm) A64_MADD(sf, Rd, A64_ZR, Rn, Rm)
+/* Rd = high 64 bits of signed Rn * Rm */
+#define A64_SMULH(Rd, Rn, Rm) aarch64_insn_gen_data3(Rd, A64_ZR, Rn, Rm, \
+	AARCH64_INSN_VARIANT_64BIT, AARCH64_INSN_DATA3_SMULH)
+/* Rd = high 64 bits of unsigned Rn * Rm */
+#define A64_UMULH(Rd, Rn, Rm) aarch64_insn_gen_data3(Rd, A64_ZR, Rn, Rm, \
+	AARCH64_INSN_VARIANT_64BIT, AARCH64_INSN_DATA3_UMULH)
 
 /* Logical (shifted register) */
 #define A64_LOGIC_SREG(sf, Rd, Rn, Rm, type) \
diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
index 326e9e1dea0a..3b4793092c1a 100644
--- a/arch/arm64/net/bpf_jit_comp.c
+++ b/arch/arm64/net/bpf_jit_comp.c
@@ -144,6 +144,17 @@ static inline void emit_a64_mov_i(const int is64, const int reg,
 	}
 }
 
+static inline void emit_a64_mul(const bool is64, const u8 dst, const u8 src,
+				const s16 off, struct jit_ctx *ctx)
+{
+	if (is64 && off == BPF_UHMUL)
+		emit(A64_UMULH(dst, dst, src), ctx);
+	else if (is64 && off == BPF_SHMUL)
+		emit(A64_SMULH(dst, dst, src), ctx);
+	else
+		emit(A64_MUL(is64, dst, dst, src), ctx);
+}
+
 static int i64_i16_blocks(const u64 val, bool inverse)
 {
 	return (((val >>  0) & 0xffff) != (inverse ? 0xffff : 0x0000)) +
@@ -1531,7 +1542,7 @@ static int build_insn(const struct bpf_verifier_env *env, const struct bpf_insn
 		break;
 	case BPF_ALU | BPF_MUL | BPF_X:
 	case BPF_ALU64 | BPF_MUL | BPF_X:
-		emit(A64_MUL(is64, dst, dst, src), ctx);
+		emit_a64_mul(is64, dst, src, off, ctx);
 		break;
 	case BPF_ALU | BPF_DIV | BPF_X:
 	case BPF_ALU64 | BPF_DIV | BPF_X:
@@ -1660,7 +1671,7 @@ static int build_insn(const struct bpf_verifier_env *env, const struct bpf_insn
 	case BPF_ALU | BPF_MUL | BPF_K:
 	case BPF_ALU64 | BPF_MUL | BPF_K:
 		emit_a64_mov_i(is64, tmp, imm, ctx);
-		emit(A64_MUL(is64, dst, dst, tmp), ctx);
+		emit_a64_mul(is64, dst, tmp, off, ctx);
 		break;
 	case BPF_ALU | BPF_DIV | BPF_K:
 	case BPF_ALU64 | BPF_DIV | BPF_K:
@@ -2595,6 +2606,11 @@ bool bpf_jit_supports_callx(void)
 	return true;
 }
 
+bool bpf_jit_supports_hmul(void)
+{
+	return true;
+}
+
 bool bpf_jit_supports_large_stack(void)
 {
 	return true;

-- 
2.56.0

