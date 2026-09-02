Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [13.75.44.102])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74E3A36B92D
	for <bpf@vger.kernel.org>; Wed,  2 Sep 2026 07:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.75.44.102
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788332807; cv=none; b=kUR2/EQGjjTuw/RvGIPCtPitG/4+5Xm7rWwuCWjvtXBjqBqDBMx80iYvGUTOS+iZUG3c/3HEG9Ey6KdpTLvYVQWqUKczUKA6y760MxAOlPOhIZaP7eEPJkniaMc67gk3D1CF8JZCaHL2KiZq6oKZQT9UIBTzLPVZfn4kvxkf+jQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788332807; c=relaxed/simple;
	bh=m9gqftxiEGjvCRaW9aBtbyvjFUk/e+xORNXzD8YsxAA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MbfpOIzg7yzRKkSVeASAKkGd9RHFcAjmZM6L5Z3yCNvBvWYibxIPROs8oWc1FXmqscLOIJF/H7cKQ4j4d78fHSy8VghoI6eKDMD9EaKBhg+EWp8ikb/IuGfpXSJPQl0iS7STzieI2UYTISLlrAwWsZgWx76mfCetMaOHbFQoyW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=13.75.44.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from zju.edu.cn (unknown [10.14.28.207])
	by mtasvr (Coremail) with SMTP id _____wAnPnzhypdqJxXjAA--.43488S3;
	Wed, 02 Sep 2026 15:06:09 +0800 (CST)
Received: from lutetium.tail477849.ts.net (unknown [10.14.28.207])
	by mail-app2 (Coremail) with SMTP id zC_KCgB36c7hypdqDx5IBA--.42767S2;
	Wed, 02 Sep 2026 15:06:09 +0800 (CST)
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
Subject: [RFC PATCH bpf-next 5/6] bpf: Add verifier support for UHMUL and SHMUL
Date: Wed,  2 Sep 2026 15:05:33 +0800
Message-ID: <20260902070534.2141812-6-tangyazhou@zju.edu.cn>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260902070534.2141812-1-tangyazhou@zju.edu.cn>
References: <20260902070534.2141812-1-tangyazhou@zju.edu.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zC_KCgB36c7hypdqDx5IBA--.42767S2
X-CM-SenderInfo: qssvjiasrsq6lmxovvfxof0/1tbiAhECCmqXKpkZ+wACs1
X-CM-DELIVERINFO: =?B?cNPVdAXKKxbFmtjJiESix3B1w3vD7IpoGYuur0o+r46DyAi5OfOO+T4vrW4FyUBIyu
	9q9Kedt9TgU4vPvYZ+hKALaYffjSaDI7rpEIXbPl9F2aZimKL6VcbFsy0GHhomWgo0DD0P
	G5ubdHMtPUps3EQwiTH8ALO0eO7323Ppp0p3dZx+HuLDa1i9iX3NXeh+YLktGw==
X-Coremail-Antispam: 1Uk129KBj93XoWxWF1rZrykKF13ZFy3Gw1ktFc_yoWrAFy8pr
	4kXr95trWkCay7u39rZa97Ar90qF1kKw48ur9rA34xXFyUJF98tF42gFy7A34YyrWvgFyx
	tF4Yv34qga4UAFgCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUU9Eb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Cr1j6rxdM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I
	8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r126r1DMcIj6I8E87Iv67AK
	xVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7xvr2IYc2Ij64
	vIr40E4x8a64kEw24lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2Ij64vIr41l4I8I
	3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxV
	WUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAF
	wI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwCI42IY6xAIw20EY4v20x
	vaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8
	JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU86MKtUUUUU==

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
 kernel/bpf/verifier.c | 45 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 92ab55ba349d..82a45550d2ee 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -15056,6 +15056,24 @@ static void scalar_min_max_mul(struct bpf_reg_state *dst_reg,
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
@@ -15752,6 +15770,25 @@ static int adjust_scalar_min_max_vals(struct bpf_verifier_env *env,
 		dst_reg->var_off = tnum_neg(env->fake_reg[0].var_off);
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
+		if (!alu32 && insn->off == BPF_MUL_VARIANT_UHMUL) {
+			scalar_min_max_uhmul(dst_reg, &src_reg);
+			break;
+		}
+		if (!alu32 && insn->off == BPF_MUL_VARIANT_SHMUL) {
+			scalar_min_max_shmul(dst_reg, &src_reg);
+			break;
+		}
 		dst_reg->var_off = tnum_mul(dst_reg->var_off, src_reg.var_off);
 		scalar32_min_max_mul(dst_reg, &src_reg);
 		scalar_min_max_mul(dst_reg, &src_reg);
@@ -15877,6 +15914,11 @@ static int adjust_reg_min_max_vals(struct bpf_verifier_env *env,
 	if (dst_reg->type == PTR_TO_ARENA || (src_reg && src_reg->type == PTR_TO_ARENA)) {
 		struct bpf_insn_aux_data *aux = cur_aux(env);
 
+		if (bpf_insn_is_hmul(insn)) {
+			verbose(env, "UHMUL/SHMUL with arena pointers are not supported\n");
+			return -EOPNOTSUPP;
+		}
+
 		if (dst_reg->type != PTR_TO_ARENA)
 			*dst_reg = *src_reg;
 
@@ -19111,6 +19153,9 @@ static int fd_array_get_map_idx(struct bpf_verifier_env *env, u32 idx)
 static bool is_valid_alu_variant(const struct bpf_insn *insn)
 {
 	switch (BPF_OP(insn->code)) {
+	case BPF_MUL:
+		return insn->off == BPF_MUL_VARIANT_LO ||
+		       bpf_insn_is_hmul(insn);
 	case BPF_DIV:
 	case BPF_MOD:
 		/* off == 1 selects SDIV/SMOD. */
-- 
2.43.0

