Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=210.32.2.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792686568;
	b=OLSfDR+q4dlAXCFc3Pf4pZBsCSWl06G8V2NnMKl2NuCUcmva09+jaYmhUqe5QYbMmdHe
	 oyBACzMQux00FmQwIIcqWbxnY+Vh0Bey+i44sXu6gbA9RiVAy6wtz++qxxbDuIs29JK72
	 Q/+3HtrC/EjeSIBSEU0Y7zXHlHX5L0IgYiaQVbDeYBXtAg16RlotdIeV5kEBjO2PSA7ta
	 EjElNIn0d5/5iMa0mL6+q8NvoNwX1AsyRGruDYsm//2DS7gCaezjduq816DupzSNUBUM4
	 eNKr29pc298HrHwz9gUXYUbCIpu2Lxu/d1UPjiXwA3Q5jbJI1nf+CAropz1pzkwDBTg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792686568;
	h=DMARC-Filter:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:X-Mailer:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-CM-SenderInfo:
	 X-CM-DELIVERINFO:X-Coremail-Antispam;
	bh=bOwcLgxkpMpvqkM1mozJopLnsS1J/6i2UqCUh6lOHrs=;
	b=DaBFXcLBmn+DRr5wlod0UrR2d1Ar4V0uq+PQYC3D3JYc6Tx097jsBL8GENb7mW1w1HIr
	 wjhG9NDFQFeR+CKInyqy5a5EJJQWc7Sg9xraW1aCrq0WPx6w1//Ti9daINxy5SPBaMJLd
	 Qy2qvUeUxX6oOkyteb4Tv025+nXKxUbvKgw8ROrezey/LIr97CxkTLrGx8SJlxalJWGbX
	 9xnshO5vadUF7QiAD/y8GOWo1gmd2I2NgnO5TJ1UqAUcmLtEQ2lluN+d+7gygSJc27yJa
	 y1Kbpn3tYHpBa7dmEZDBohOwHqEb32WY6PFjPuaZJVtoJLf+UYig5lwJFHzYfJ8JLhQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=zju.edu.cn;
	spf=pass smtp.mailfrom=zju.edu.cn;
	arc=none smtp.remote-ip=210.32.2.4
Received: from zju.edu.cn (gw.zju.edu.cn [210.32.2.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CB5F606A334;
	Thu, 22 Oct 2026 16:29:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0CB5F606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from zju.edu.cn (unknown [10.192.73.73])
	by mtasvr (Coremail) with SMTP id _____wAn4nzcOdpqe1K0AQ--.1016S3;
	Fri, 23 Oct 2026 00:29:16 +0800 (CST)
Received: from wolframium.tail477849.ts.net (unknown [10.192.73.73])
	by mail-app1 (Coremail) with UTF8SMTPA id yy_KCgAnOIXbOdpqSKOJAA--.46247S2;
	Fri, 23 Oct 2026 00:29:15 +0800 (CST)
From: Yazhou Tang <tangyazhou@zju.edu.cn>
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
	Luke Nelson <luke.r.nels@gmail.com>,
	Xi Wang <xi.wang@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org,
	Tianci Cao <ziye@zju.edu.cn>,
	Yazhou Tang <tangyazhou518@outlook.com>,
	Shenghao Yuan <shenghaoyuan0928@163.com>
Subject: [PATCH bpf-next v3 6/7] bpf: Add verifier support for UHMUL and SHMUL
Date: Fri, 23 Oct 2026 00:28:46 +0800
Message-ID: <20261023-bpf-hmul-v3-6-b99e808cb28b@outlook.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261023-bpf-hmul-v3-0-b99e808cb28b@outlook.com>
References: <20261023-bpf-hmul-v3-0-b99e808cb28b@outlook.com>
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
X-CM-TRANSID:yy_KCgAnOIXbOdpqSKOJAA--.46247S2
X-CM-SenderInfo: qssvjiasrsq6lmxovvfxof0/1tbiBgQMCmrZFZ1POgABsL
X-CM-DELIVERINFO: =?B?q/xNBwXKKxbFmtjJiESix3B1w3vD7IpoGYuur0o+r46DyAi5OfOO+T4vrW4FyUBIyu
	9q9JatvK8BSGkLsRrdyfcL+iNUSMiHsF/F74WoM6SvQj32BL24wUHaJNE2x+v2N3Qx3FGe
	lw9XxDD7uwItX54c+IUF3pawoLy/9T/FD+PhlgUXVTrRUztHXQBJAWqh5F7vSA==
X-Coremail-Antispam: 1Uk129KBj93XoW3XFW7Gr4UZw1DAr1fKFy5ZFc_yoW7Wr4DpF
	4kXr95JrWkCw47uasrZan7Ar90qF1xJ3y8u347A34IqFW7JF98tF4IgFy2v34akayvga4x
	tF4jv3sF9a4UCFgCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUBYb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26r1j6r4UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8JVW8Jr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27w
	Aqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE
	14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjcxG0xvY0x
	0EwIxGrVCF72vEw4AK0wACI402YVCY1x02628vn2kIc2xKxwCF04k20xvY0x0EwIxGrwCF
	x2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14
	v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY
	67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJwCI42IY6xAIw20EY4
	v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AK
	xVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8UPEDUUUUU==

From: Tianci Cao <ziye@zju.edu.cn>

Extend ALU variant validation to accept off == 1 and off == 2 as UHMUL
and SHMUL, respectively, for BPF_ALU64 MUL instructions. Both offsets
remain reserved for BPF_ALU MUL. All other MUL offsets remain invalid.

Reject HMUL instructions when the program is offloaded to hardware or
when JIT compilation is requested but the JIT does not support HMUL.
Return -EOPNOTSUPP with a verifier log message in both cases. UHMUL
and SHMUL remain available through the interpreter when JIT compilation
is disabled.

For scalar tracking, compute the exact high-half result when both
operands are constants. Mark the destination unknown when either
operand is variable until range analysis for these variants is added.
Keep the existing scalar analysis for ordinary low-half MUL unchanged.

Reject UHMUL and SHMUL when either operand is PTR_TO_ARENA. Arena
arithmetic can be rewritten from BPF_ALU64 to BPF_ALU to enforce its
32-bit pointer representation, but such a rewrite cannot preserve the
semantics of variants that are only defined for BPF_ALU64.

Link: https://lore.kernel.org/bpf/CAADnVQ+2O2zgdy11+vxE6dOp+3Br4zZBysHF-Hne7cP+eeucnQ@mail.gmail.com/
Suggested-by: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Signed-off-by: Tianci Cao <ziye@zju.edu.cn>
Co-developed-by: Yazhou Tang <tangyazhou518@outlook.com>
Signed-off-by: Yazhou Tang <tangyazhou518@outlook.com>
Co-developed-by: Shenghao Yuan <shenghaoyuan0928@163.com>
Signed-off-by: Shenghao Yuan <shenghaoyuan0928@163.com>
---
 kernel/bpf/verifier.c | 57 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 4f9d7b3de442..ac7974038eaa 100644
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
@@ -21206,6 +21250,17 @@ static bool is_valid_alu_variant(const struct bpf_insn *insn)
 	}
 }
 
+/* The interpreter supports uhmul and shmul. JITs opt in. */
+static int check_hmul_jit(struct bpf_verifier_env *env)
+{
+	if (bpf_prog_is_offloaded(env->prog->aux) ||
+	    (env->prog->jit_requested && !bpf_jit_supports_hmul())) {
+		verbose(env, "JIT doesn't support uhmul and shmul\n");
+		return -EOPNOTSUPP;
+	}
+	return 0;
+}
+
 static int check_alu_fields(struct bpf_verifier_env *env, struct bpf_insn *insn)
 {
 	u8 class = BPF_CLASS(insn->code);
@@ -21267,6 +21322,8 @@ static int check_alu_fields(struct bpf_verifier_env *env, struct bpf_insn *insn)
 			verbose(env, "BPF_ALU uses reserved fields\n");
 			return -EINVAL;
 		}
+		if (bpf_insn_is_hmul(insn))
+			return check_hmul_jit(env);
 		return 0;
 	default:
 		verbose(env, "invalid BPF_ALU opcode %x\n", opcode);

-- 
2.56.0

