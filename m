Received: from zju.edu.cn (gw.zju.edu.cn [210.32.2.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 875253BE638
	for <bpf@vger.kernel.org>; Thu, 17 Sep 2026 04:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.32.2.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789618781; cv=none; b=Puab88q9U4CdUMCnwssDmqQhNCWwt4OK0O7KoKLYhIBT8ylxGR9VDxj2g42H96vZVOo1mPxOp7NgSMK1yUENTtpIZP4/1xcPxnQzBNz9+IlegA5Mmjh9VQ/v5Vm4IrMyn43OxmuW/hyfO+bJMJXJ+TUrAh2ZjfJM/NrnVzDzUic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789618781; c=relaxed/simple;
	bh=NIyK4mLjUosxG4TwQDJY1eGmPYHabwv/g9eFyY40jB0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CE/rFUCD25M44odTOoOxXDisQ1Iky+YHHh+X615S0gTMO5bKheyacH4k6M+ghOEJFpe+YUzpBB+bKUFOM63JySpCJzUceJ7h9SNDJvK9bN1Rf8uDL3pjkH8aASb6U4jeK/NaMmHp6Y46UXsXmgAamrdD/5wctNsk4Wg1SNV1olM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=210.32.2.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from zju.edu.cn (unknown [10.162.163.215])
	by mtasvr (Coremail) with SMTP id _____wBXUH_aaatqpBMdAQ--.3643S3;
	Thu, 17 Sep 2026 12:17:30 +0800 (CST)
Received: from lutetium.tail477849.ts.net (unknown [10.162.163.215])
	by mail-app1 (Coremail) with SMTP id yy_KCgAHC6XZaatqLeuJBA--.2484S2;
	Thu, 17 Sep 2026 12:17:29 +0800 (CST)
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
Subject: [PATCH bpf-next 7/8] bpf: Add verifier support for UHMUL and SHMUL
Date: Thu, 17 Sep 2026 12:17:11 +0800
Message-ID: <20260917041712.1860722-8-tangyazhou@zju.edu.cn>
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
X-CM-TRANSID:yy_KCgAHC6XZaatqLeuJBA--.2484S2
X-CM-SenderInfo: qssvjiasrsq6lmxovvfxof0/1tbiBgMRCmqq8RoVWgACs4
X-CM-DELIVERINFO: =?B?7CUEXgXKKxbFmtjJiESix3B1w3vD7IpoGYuur0o+r46DyAi5OfOO+T4vrW4FyUBIyu
	9q9NuO7bmcOm6inyHA68dGwwSDjwOQj2pya3udbY5OQbVGtQTceyTRXOqRd+9npnNIMuzx
	tYW6ygMMAODLRUSlwhJpgK6yGINPMCS0UMu5Krzc7nMXHM/QSxr4ZaI2KSj+CQ==
X-Coremail-Antispam: 1Uk129KBj93XoWxWF1rZrykKF13ZFy3Gw1ktFc_yoWrAFy8pr
	4DXr95JrWkCay7ua9rZa97Ar90qF18Kw48ur9rA34xXFyUJF98tF42gFy7Z34ayrWvga4x
	tF4Yv34qga4UAFgCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUBYb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AK
	xVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI0UMc
	02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUAVWUtwAv7VC2z280aVAF
	wI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0Y48IcxkI7V
	AKI48G6xCjnVAKz4kxM4IIrI8v6xkF7I0E8cxan2IY04v7MxAIw28IcxkI7VAKI48JMxC2
	0s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI
	0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE
	14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UMIIF0xvE42xK8VAvwI
	8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v2
	6r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7IU80tC7UUUUU==

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
index ed8742bf504f..92603a6a030b 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -15238,6 +15238,24 @@ static void scalar_min_max_mul(struct bpf_reg_state *dst_reg,
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
@@ -15934,6 +15952,25 @@ static int adjust_scalar_min_max_vals(struct bpf_verifier_env *env,
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
@@ -16059,6 +16096,11 @@ static int adjust_reg_min_max_vals(struct bpf_verifier_env *env,
 	if (dst_reg->type == PTR_TO_ARENA || (src_reg && src_reg->type == PTR_TO_ARENA)) {
 		struct bpf_insn_aux_data *aux = cur_aux(env);
 
+		if (bpf_insn_is_hmul(insn)) {
+			verbose(env, "UHMUL/SHMUL with arena pointers are not supported\n");
+			return -EOPNOTSUPP;
+		}
+
 		if (dst_reg->type != PTR_TO_ARENA)
 			*dst_reg = *src_reg;
 
@@ -19341,6 +19383,9 @@ static int fd_array_get_map_idx(struct bpf_verifier_env *env, u32 idx)
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
2.55.0

