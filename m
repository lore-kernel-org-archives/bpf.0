Received: from zg8tndyumtaxlji0oc4xnzya.icoremail.net (zg8tndyumtaxlji0oc4xnzya.icoremail.net [46.101.248.176])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 388683B0AF8
	for <bpf@vger.kernel.org>; Thu, 17 Sep 2026 04:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.101.248.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789618669; cv=none; b=WnXY2ONLh5lMWV3K2B7YvjGK7GqGlJjFJSMr5ZlXxUDoQgLsqwovnlblbcvMvjBdq5dGuSkq7mhyJ1mgdXT4i+VGusq7gPK/FlnQ5gcCuGqQy0nddGG3ddr/pTlyKTM7AXz0YYTXV0eWZ59TMaupGO3cqYwEH19hG61FT6+YUA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789618669; c=relaxed/simple;
	bh=VoE04cWt8+u+FvbiiqamuMLETvz4FLLguij9YUj4T8Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qfyFdEJoemaJmAeGpnQQs6vM1sS90XAIFMfknvQhiWiG9RoduG0MgdE6Q3r/+nQt68d4mGlxw3hqGmzhmThCmCWhWjWuMZIf9IjEe5zNLhNzUz7ahTcYa+4hv3nJJENB+trube794l/MddfLD+NfP9UyBwkakZ2M2be9tu08K3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=46.101.248.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from zju.edu.cn (unknown [10.162.163.215])
	by mtasvr (Coremail) with SMTP id _____wAHwz3WaatqmhMdAQ--.3856S3;
	Thu, 17 Sep 2026 12:17:26 +0800 (CST)
Received: from lutetium.tail477849.ts.net (unknown [10.162.163.215])
	by mail-app1 (Coremail) with SMTP id yy_KCgC3Bp_WaatqIOuJBA--.2568S2;
	Thu, 17 Sep 2026 12:17:26 +0800 (CST)
From: Yazhou Tang <tangyazhou@zju.edu.cn>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	eddyz87@gmail.com
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
	Alexei Starovoitov <alexei.starovoitov@gmail.com>
Subject: [PATCH bpf-next 3/8] bpf, arm64: JIT UHMUL and SHMUL
Date: Thu, 17 Sep 2026 12:17:07 +0800
Message-ID: <20260917041712.1860722-4-tangyazhou@zju.edu.cn>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260917041712.1860722-1-tangyazhou@zju.edu.cn>
References: <20260917041712.1860722-1-tangyazhou@zju.edu.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:yy_KCgC3Bp_WaatqIOuJBA--.2568S2
X-CM-SenderInfo: qssvjiasrsq6lmxovvfxof0/1tbiAgERCmqq8RoVXQADs4
X-CM-DELIVERINFO: =?B?ClERKAXKKxbFmtjJiESix3B1w3vD7IpoGYuur0o+r46DyAi5OfOO+T4vrW4FyUBIyu
	9q9BMXZiQifGBAu8ehqrOKaOoPPbv1Xv5L+CYGnZ3YJpc7WOpHKqF6HJ4hvYdwKTZtEqD9
	78dJjdEeYQxJUwdxJwBFlI16qdMcCU+huTjNT+W8icSgtJaCEZ9Tz8GlhmJJEw==
X-Coremail-Antispam: 1Uk129KBj93XoWxXr1fCFWxKr1xCr15tF48Zrc_yoW7Jw15pw
	n8urWSkrWkWF13GF97tFnrZr4Yka1Fgw4DK34Uu3yrKrs8Xa4UWFWSg3y2yFs8Gryjga9Y
	qFy29r1F9aykXwcCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUU9Eb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AK
	xVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI0UMc
	02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAF
	wI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0Y48IcxkI7V
	AKI48G6xCjnVAKz4kxM4IIrI8v6xkF7I0E8cxan2IY04v7MxAIw28IcxkI7VAKI48JMxC2
	0s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI
	0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE
	14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20x
	vaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8
	JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU81v35UUUUU==

From: Yazhou Tang <tangyazhou518@outlook.com>

arm64 provides UMULH and SMULH instructions that return the high 64 bits
of an unsigned or signed 64-bit multiplication, respectively.

Add encodings for these instructions and use them to lower the UHMUL and
SHMUL BPF_MUL variants for both register and immediate sources. Keep the
existing low-half and ALU32 multiplication lowering unchanged.

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
 arch/arm64/net/bpf_jit_comp.c | 15 +++++++++++++--
 4 files changed, 29 insertions(+), 2 deletions(-)

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
index 6c04fee46876..054c38775dd2 100644
--- a/arch/arm64/net/bpf_jit_comp.c
+++ b/arch/arm64/net/bpf_jit_comp.c
@@ -144,6 +144,17 @@ static inline void emit_a64_mov_i(const int is64, const int reg,
 	}
 }
 
+static inline void emit_a64_mul(const bool is64, const u8 dst, const u8 src,
+				const s16 off, struct jit_ctx *ctx)
+{
+	if (is64 && off == BPF_MUL_VARIANT_UHMUL)
+		emit(A64_UMULH(dst, dst, src), ctx);
+	else if (is64 && off == BPF_MUL_VARIANT_SHMUL)
+		emit(A64_SMULH(dst, dst, src), ctx);
+	else
+		emit(A64_MUL(is64, dst, dst, src), ctx);
+}
+
 static int i64_i16_blocks(const u64 val, bool inverse)
 {
 	return (((val >>  0) & 0xffff) != (inverse ? 0xffff : 0x0000)) +
@@ -1454,7 +1465,7 @@ static int build_insn(const struct bpf_verifier_env *env, const struct bpf_insn
 		break;
 	case BPF_ALU | BPF_MUL | BPF_X:
 	case BPF_ALU64 | BPF_MUL | BPF_X:
-		emit(A64_MUL(is64, dst, dst, src), ctx);
+		emit_a64_mul(is64, dst, src, off, ctx);
 		break;
 	case BPF_ALU | BPF_DIV | BPF_X:
 	case BPF_ALU64 | BPF_DIV | BPF_X:
@@ -1583,7 +1594,7 @@ static int build_insn(const struct bpf_verifier_env *env, const struct bpf_insn
 	case BPF_ALU | BPF_MUL | BPF_K:
 	case BPF_ALU64 | BPF_MUL | BPF_K:
 		emit_a64_mov_i(is64, tmp, imm, ctx);
-		emit(A64_MUL(is64, dst, dst, tmp), ctx);
+		emit_a64_mul(is64, dst, tmp, off, ctx);
 		break;
 	case BPF_ALU | BPF_DIV | BPF_K:
 	case BPF_ALU64 | BPF_DIV | BPF_K:
-- 
2.55.0

