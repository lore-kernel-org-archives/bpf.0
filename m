Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.243.164.118
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792571049;
	b=lYNPGd6YtNJD0fEU6+mj1ib8fTjUMT9WxVoM6BQQxUVHETxseSVcyjw6f9SH3jyrI7h6
	 35VLR01zcnlJ/cLt/Ws4wSBv+2/qQs4gwKGf2L/Flls2dZNK7+0QTk0XFZlZGEiAn9TX7
	 ZVQclQ4f+DMH9Xx+ZTG5XZuRgtTmYs+j5tp1T1VzFyPRUwJeFlVCP2o3fRUqb9LOwbPqw
	 rNbjHA5zTdLt/oakIG9smpHO+gXEEF4TIfZgTPW6BKN/V0fJh/HxgoK4UcsM0X15yBt1Y
	 oTmMqhqZtrGX+XutA9x1HkUh2KFCMzWM4HTPY9Eeb55PXARQlPkkmt5B6/QatEPN18Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792571049;
	h=DMARC-Filter:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:X-Mailer:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-CM-SenderInfo:
	 X-CM-DELIVERINFO:X-Coremail-Antispam;
	bh=ZJZsGt1RoLGv6bmAnd/MQ4/K8kUfoZK+ne5ibrmUcEs=;
	b=Gkz2w1spzCmN5MgN4Caq5bgoUTLL33MS9gEBTokM1Q+i2z2zWdGz7DRmw0i9qAAS4pKP
	 Hr1A6EWKNdbmiWHTeHK6A3FGAMm9I9ajAOrg1wLWEBFfPJu8gnUpNzTlz4hKlO4ohTqaa
	 EIBBnwADEQHVHXUKR1k60/v0nkKALmK2qwKApSdAblZWWisIyreAXgJ9FISoOojp+/52g
	 KqDb8O4vuwkLU98ddqlQoktTIMy3cTGyUaBSvaFUqAYEneUIIcO1oisP6vPFFdwOXzgVG
	 bsn/ZXUD4QG1nFVc72A5jsEWe3CH8TlrS9YQ7j3x5l1v4zoi0uUaBG3xqGMCcr764FQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=zju.edu.cn;
	spf=pass smtp.mailfrom=zju.edu.cn;
	arc=none smtp.remote-ip=162.243.164.118
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F21AA606A319;
	Wed, 21 Oct 2026 08:24:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F21AA606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from zju.edu.cn (unknown [10.162.163.215])
	by mtasvr (Coremail) with SMTP id _____wDHIT2CdthqlU+tAQ--.827S3;
	Wed, 21 Oct 2026 16:23:31 +0800 (CST)
Received: from lutetium.tail477849.ts.net (unknown [10.162.163.215])
	by mail-app3 (Coremail) with UTF8SMTPA id zS_KCgCnR6KAdthqbly1AA--.47192S2;
	Wed, 21 Oct 2026 16:23:29 +0800 (CST)
From: tangyazhou@zju.edu.cn
To: bpf@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	David Vernet <void@manifault.com>,
	bpf@ietf.org
Cc: John Fastabend <john.fastabend@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Quentin Monnet <qmo@kernel.org>,
	Puranjay Mohan <puranjay@kernel.org>,
	Xu Kuohai <xukuohai@huaweicloud.com>,
	=?utf-8?q?Bj=C3=B6rn_T=C3=B6pel?= <bjorn@kernel.org>,
	Pu Lehui <pulehui@huawei.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	Shahab Vahedi <list+bpf@vahedi.org>,
	Russell King <linux@armlinux.org.uk>,
	Tiezhu Yang <yangtiezhu@loongson.cn>,
	Hengqi Chen <hengqi.chen@gmail.com>,
	Johan Almbladh <johan.almbladh@anyfinetworks.com>,
	Paul Burton <paulburton@kernel.org>,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	Helge Deller <deller@gmx.de>,
	Hari Bathini <hbathini@linux.ibm.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Naveen N Rao <naveen@kernel.org>,
	Luke Nelson <luke.r.nels@gmail.com>,
	Xi Wang <xi.wang@gmail.com>,
	Ilya Leoshkevich <iii@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	"David S. Miller" <davem@davemloft.net>,
	Wang YanQing <udknight@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org,
	Yazhou Tang <tangyazhou518@outlook.com>,
	Tianci Cao <ziye@zju.edu.cn>,
	Shenghao Yuan <shenghaoyuan0928@163.com>
Subject: [PATCH bpf-next v2 3/8] bpf, arm64: JIT UHMUL and SHMUL
Date: Wed, 21 Oct 2026 16:23:23 +0800
Message-ID: <20261021-bpf-hmul-v2-3-88e260099f7d@outlook.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261021-bpf-hmul-v2-0-88e260099f7d@outlook.com>
References: <20261021-bpf-hmul-v2-0-88e260099f7d@outlook.com>
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
X-Mailer: b4 0.15.2
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zS_KCgCnR6KAdthqbly1AA--.47192S2
X-CM-SenderInfo: qssvjiasrsq6lmxovvfxof0/1tbiBhMLCmrXxB0gcQABsg
X-CM-DELIVERINFO: =?B?Xo5KYQXKKxbFmtjJiESix3B1w3vD7IpoGYuur0o+r46DyAi5OfOO+T4vrW4FyUBIyu
	9q9C3p0bkPmn0Y7fsOHCqvQSnLiEKTnblmL+U+pBVp0RIpwbVyc97K1UufZTOlSmiCpW3i
	5mtPgHnUlpBEYv6mWIEaZaBLTnfE6zncm1Lm6vdzJ4dz/iU4djPgnHvF/UDoow==
X-Coremail-Antispam: 1Uk129KBj93XoWxXr1fCFWxKr1xCr15tF48Zrc_yoW7JF4Dpw
	n5urWSkrWkWF13GF97tFnrZw4Yka1Fgw4DK345u3yrKrs8Xa4UGFWSg3y2yFs8Gryjga9Y
	qFyj9r1F9aykXwcCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUBKb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AK
	xVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI0UMc
	02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAF
	wI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0Y48IcxkI7V
	AKI48G6xCjnVAKz4kxM4IIrI8v6xkF7I0E8cxan2IY04v7M4kE6xkIj40Ew7xC0wCF04k2
	0xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI
	8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Wrv_Gr1UMIIYrxkI7VAKI48J
	MIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMI
	IF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E
	87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7IU8ymh7UUUUU==

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
index 326e9e1dea0a..a9989cd5098c 100644
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

-- 
2.56.0

