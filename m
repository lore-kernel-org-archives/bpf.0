Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=210.32.2.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792571081;
	b=4OQNADUbRMHTaLug5TXl2dG/2lJEcIYiM6aH9OQEsIofixaHlRy3nYdzv8tKKOQbtuD0
	 cU1b031Y+tsGRokwWelkhoQ/mVfER9LdAx5r2OvBM87MxVWdPEWBP1Hs940cCNfX7lAOl
	 Sfg2nCSPeNxZKyNmzjK9FVhW0LNtrzj0x/ZKFrGkJwTwpslnQGGAM5yX+5Ua0p7Of6CaJ
	 CLj5JNMZE1/MssUvzBLAw+3zBRYEANcKfDxqYhYyu5IEx8b1s1pqs7a2gelOAjsZA6Ar5
	 EsXA9mbWfmWhCnE+JVXvnHnRg09Ez6YlUgYhzbzk4eBDF1zf3NyXxeiUw0vU4RVjYZg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792571081;
	h=DMARC-Filter:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:X-Mailer:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-CM-SenderInfo:
	 X-CM-DELIVERINFO:X-Coremail-Antispam;
	bh=h8eddZT9hDTRgRSZp5lKDiD9JXGbTl/NCxh/RdFf6Mc=;
	b=WhKZoquPcDeegfQTzzH+YDX9V1OEHjNrQsGYvr0+uB4mWVaOuSWp7oj1UMKi7pC7iqux
	 CnmDqCgcEsAS//4RQl6b27ndc6DbceAZlja8DcIx4vqyUgVC8JNfYdDkduaHFXX+kS2KM
	 btcrp8aQ31LfT8j4GYnOJ4qUGYGTSI/wvgjEK4qTa4iyWSGT71tXid2naqmSarC3oSnUW
	 zc7xkSZkyi0R4g3Bfye9tp2FYFUZitxc5W6+cDEDcHTEEjPo/DiYf7IQbp1wHcG17Me+u
	 rcQuZTOzdYY7nNOyT7d1wQNk1FkyZ/ZUsA7eMRjLuhM5sWSRRns+rsTFxfHUiGewibA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=zju.edu.cn;
	spf=pass smtp.mailfrom=zju.edu.cn;
	arc=none smtp.remote-ip=210.32.2.4
Received: from zju.edu.cn (gw.zju.edu.cn [210.32.2.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 740A0606A31A;
	Wed, 21 Oct 2026 08:24:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 740A0606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from zju.edu.cn (unknown [10.162.163.215])
	by mtasvr (Coremail) with SMTP id _____wAXAX+1dthqkVCtAQ--.382S3;
	Wed, 21 Oct 2026 16:24:21 +0800 (CST)
Received: from lutetium.tail477849.ts.net (unknown [10.162.163.215])
	by mail-app3 (Coremail) with UTF8SMTPA id zS_KCgA32KKsdthqPl21AA--.47446S2;
	Wed, 21 Oct 2026 16:24:13 +0800 (CST)
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
	Tianci Cao <ziye@zju.edu.cn>,
	Yazhou Tang <tangyazhou518@outlook.com>,
	Shenghao Yuan <shenghaoyuan0928@163.com>
Subject: [PATCH bpf-next v2 7/8] bpf: Add verifier support for UHMUL and SHMUL
Date: Wed, 21 Oct 2026 16:24:10 +0800
Message-ID: <20261021-bpf-hmul-v2-7-88e260099f7d@outlook.com>
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
X-CM-TRANSID:zS_KCgA32KKsdthqPl21AA--.47446S2
X-CM-SenderInfo: qssvjiasrsq6lmxovvfxof0/1tbiAhILCmrXxB0pugABsn
X-CM-DELIVERINFO: =?B?N5tuEgXKKxbFmtjJiESix3B1w3vD7IpoGYuur0o+r46DyAi5OfOO+T4vrW4FyUBIyu
	9q9Ks5WUqw3Z4rlIZd02nqEte7vE5X8r7PoGTmM5ivi+t+g0KhJc0NasiSc+kD3IPo+Y6X
	N+4FoHWeuFvL2eN8QXUH8FDuENTTluHYrAqEalW4/31dW7yDvuavBQKfbVwx1A==
X-Coremail-Antispam: 1Uk129KBj93XoWxWF1rZrykKF13urW3Xr4DZFc_yoWrWw1Dpr
	4kXr98KrWkCa17ua9xZa97Ar90qF18tw48ur9rA34xXFyUJF98tF42gFy7Z34ayrWvgFyx
	tF4Yv3sFga4UCFgCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUBEb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Cr1j6rxdM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I
	8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r126r1DMcIj6I8E87Iv67AK
	xVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7xvr2IYc2Ij64
	vIr40E4x8a64kEw24lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lw4CEc2x0rVAKj4xxMxAIw28I
	cxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2
	IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWrXVW8Jr1lIxkGc2Ij64vIr41l
	IxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
	CI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2
	z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x07j50edUUUUU=

From: Tianci Cao <ziye@zju.edu.cn>

Extend ALU variant validation to accept off == 1 and off == 2 as UHMUL and
SHMUL, respectively, for BPF_ALU64 MUL instructions. Both offsets remain
reserved for BPF_ALU MUL, since the high-half variants are only defined
for 64-bit operations. All other MUL offsets remain invalid.

For scalar tracking, compute the exact high-half result when both operands
are constants. Mark the destination unknown when either operand is variable
until range analysis for these variants is added. Keep the existing scalar
analysis for ordinary low-half MUL unchanged.

Reject UHMUL and SHMUL when either operand is PTR_TO_ARENA. Arena
arithmetic can be rewritten from BPF_ALU64 to BPF_ALU to enforce its 32-bit
pointer representation, but such a rewrite cannot preserve the semantics of
variants that are only defined for BPF_ALU64.

Link: https://lore.kernel.org/bpf/CAADnVQ+2O2zgdy11+vxE6dOp+3Br4zZBysHF-Hne7cP+eeucnQ@mail.gmail.com/
Suggested-by: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Signed-off-by: Tianci Cao <ziye@zju.edu.cn>
Co-developed-by: Yazhou Tang <tangyazhou518@outlook.com>
Signed-off-by: Yazhou Tang <tangyazhou518@outlook.com>
Co-developed-by: Shenghao Yuan <shenghaoyuan0928@163.com>
Signed-off-by: Shenghao Yuan <shenghaoyuan0928@163.com>
---
 kernel/bpf/verifier.c | 44 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 4f9d7b3de442..fbb920239783 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -16664,6 +16664,24 @@ static void scalar_min_max_mul(struct bpf_reg_state *dst_reg,
 					cnum64_from_srange(smin, smax));
 }
 
+static void scalar_min_max_uhmul(struct bpf_reg_state *dst_reg,
+				 struct bpf_reg_state *src_reg)
+{
+	u64 dst = reg_const_value(dst_reg, false);
+	u64 src = reg_const_value(src_reg, false);
+
+	___mark_reg_known(dst_reg, bpf_uhmul64(dst, src));
+}
+
+static void scalar_min_max_shmul(struct bpf_reg_state *dst_reg,
+				 struct bpf_reg_state *src_reg)
+{
+	s64 dst = reg_const_value(dst_reg, false);
+	s64 src = reg_const_value(src_reg, false);
+
+	___mark_reg_known(dst_reg, bpf_shmul64(dst, src));
+}
+
 static void scalar32_min_max_udiv(struct bpf_reg_state *dst_reg,
 				  struct bpf_reg_state *src_reg)
 {
@@ -17364,6 +17382,25 @@ static int adjust_scalar_min_max_vals(struct bpf_verifier_env *env,
 		reg_step_reset(dst_reg);
 		break;
 	case BPF_MUL:
+		/*
+		 * Range analysis for UHMUL/SHMUL is not implemented yet.
+		 * Compute an exact result only when both operands are constants.
+		 * Ordinary low-half MUL continues to use the analysis below.
+		 */
+		if (bpf_insn_is_hmul(insn) &&
+		    (!is_reg_const(dst_reg, false) ||
+		     !is_reg_const(&src_reg, false))) {
+			__mark_reg_unknown(env, dst_reg);
+			break;
+		}
+		if (!alu32 && insn->off == BPF_UHMUL) {
+			scalar_min_max_uhmul(dst_reg, &src_reg);
+			break;
+		}
+		if (!alu32 && insn->off == BPF_SHMUL) {
+			scalar_min_max_shmul(dst_reg, &src_reg);
+			break;
+		}
 		scalar_step_mul(dst_reg, &src_reg);
 		dst_reg->var_off = tnum_mul(dst_reg->var_off, src_reg.var_off);
 		scalar32_min_max_mul(dst_reg, &src_reg);
@@ -17499,6 +17536,11 @@ static int adjust_reg_min_max_vals(struct bpf_verifier_env *env,
 	/* Case where at least one operand is an arena. */
 	if (dst_reg->type == PTR_TO_ARENA || (src_reg && src_reg->type == PTR_TO_ARENA)) {
 
+		if (bpf_insn_is_hmul(insn)) {
+			verbose(env, "UHMUL/SHMUL with arena pointers are not supported\n");
+			return -EOPNOTSUPP;
+		}
+
 		if (dst_reg->type != PTR_TO_ARENA)
 			*dst_reg = *src_reg;
 
@@ -21197,6 +21239,8 @@ static int fd_array_get_map_idx(struct bpf_verifier_env *env, u32 idx)
 static bool is_valid_alu_variant(const struct bpf_insn *insn)
 {
 	switch (BPF_OP(insn->code)) {
+	case BPF_MUL:
+		return insn->off == 0 || bpf_insn_is_hmul(insn);
 	case BPF_DIV:
 	case BPF_MOD:
 		/* off == 1 selects SDIV/SMOD. */

-- 
2.56.0

