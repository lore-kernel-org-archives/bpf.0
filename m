Received: from zg8tndyumtaxlji0oc4xnzya.icoremail.net (zg8tndyumtaxlji0oc4xnzya.icoremail.net [46.101.248.176])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78E8A3A9619
	for <bpf@vger.kernel.org>; Thu, 17 Sep 2026 04:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.101.248.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789618671; cv=none; b=RQt3wJ8AWL3u9ZY/Z+M1xnJ3dghGS9kaaaP+PvwzffYHbH8UMCDexW+paW+F8mx8ay00Q06eYp85sWi7OxjnlVy1u3jronPOrAX9er7xZlihKYdMhXjx0p9aYvMgF4cpsTDLwcddpTckcz2Z8Ait7JbzOQzUE3vSuP7DdgTGyTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789618671; c=relaxed/simple;
	bh=YjsCJQWb0UXGcPH56cQWLPMMUxVGzrAvBd2iAfXkmO4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=by7nTiT9Rzqhvtc+9UQ3VhH/M1fFD7M3XlTn5hLJE0vtGID+O1y6RWNtkcy/7jC7oLU0OdU7a5qa98S9r4uPPoFZE+uPooh9FGCotexZ9LMVPtKiASD2obSM6aPqGyCQx8Ag8JtOMY/TOJrwec/lKnKWAXUn05+EXDazGjyJDdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=46.101.248.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from zju.edu.cn (unknown [10.162.163.215])
	by mtasvr (Coremail) with SMTP id _____wCntizVaatqlBMdAQ--.3695S3;
	Thu, 17 Sep 2026 12:17:25 +0800 (CST)
Received: from lutetium.tail477849.ts.net (unknown [10.162.163.215])
	by mail-app1 (Coremail) with SMTP id yy_KCgBXWaPVaatqHOuJBA--.2395S2;
	Thu, 17 Sep 2026 12:17:25 +0800 (CST)
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
Subject: [PATCH bpf-next 2/8] bpf, x86: JIT UHMUL and SHMUL on x86-64
Date: Thu, 17 Sep 2026 12:17:06 +0800
Message-ID: <20260917041712.1860722-3-tangyazhou@zju.edu.cn>
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
X-CM-TRANSID:yy_KCgBXWaPVaatqHOuJBA--.2395S2
X-CM-SenderInfo: qssvjiasrsq6lmxovvfxof0/1tbiAgERCmqq8RoVXQACs5
X-CM-DELIVERINFO: =?B?chPqKgXKKxbFmtjJiESix3B1w3vD7IpoGYuur0o+r46DyAi5OfOO+T4vrW4FyUBIyu
	9q9BMXZiQifGBAu8ehqrOKaOoCu6oazgQNXDxSQVkINRMZAtiARYR0Wa6pbT9IGuRif/XK
	42VW6g/IBSQBLFLl+ca4xNZ9qydfBi1br2tQWqONowmc/WHsIU9MDdR3IaVvZA==
X-Coremail-Antispam: 1Uk129KBj93XoWxGFW3AFykAFWxtw15tw4rtFc_yoW5Kr1rpF
	s7Crn3CFWDZwsrtrZrXFWxZrnxXF4xWr4xAa42y3y7X3ZxXr1ruF4xKa43t34rCryF9w1f
	tr1Y93srC3WkuFbCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
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

Link: https://lore.kernel.org/bpf/CAADnVQ+2O2zgdy11+vxE6dOp+3Br4zZBysHF-Hne7cP+eeucnQ@mail.gmail.com/
Suggested-by: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Signed-off-by: Tianci Cao <ziye@zju.edu.cn>
Co-developed-by: Yazhou Tang <tangyazhou518@outlook.com>
Signed-off-by: Yazhou Tang <tangyazhou518@outlook.com>
Co-developed-by: Shenghao Yuan <shenghaoyuan0928@163.com>
Signed-off-by: Shenghao Yuan <shenghaoyuan0928@163.com>
---
 arch/x86/net/bpf_jit_comp.c | 48 +++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index d4a980140b48..645d0ac4db04 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -1225,6 +1225,38 @@ static int emit_kasan_check(struct bpf_verifier_env *env, u8 **pprog,
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
@@ -2332,6 +2364,14 @@ static int do_jit(struct bpf_verifier_env *env, struct bpf_prog *bpf_prog, int *
 
 		case BPF_ALU | BPF_MUL | BPF_K:
 		case BPF_ALU64 | BPF_MUL | BPF_K:
+			if (bpf_insn_is_hmul(insn)) {
+				/* imul/mul use AUX_REG as src. */
+				emit_mov_imm32(&prog, true, AUX_REG, imm32);
+				emit_hmul_aux(&prog, dst_reg,
+					      insn->off == BPF_MUL_VARIANT_SHMUL);
+				break;
+			}
+
 			maybe_emit_mod(&prog, dst_reg, dst_reg,
 				       BPF_CLASS(insn->code) == BPF_ALU64);
 
@@ -2348,6 +2388,14 @@ static int do_jit(struct bpf_verifier_env *env, struct bpf_prog *bpf_prog, int *
 
 		case BPF_ALU | BPF_MUL | BPF_X:
 		case BPF_ALU64 | BPF_MUL | BPF_X:
+			if (bpf_insn_is_hmul(insn)) {
+				/* imul/mul use AUX_REG as src. */
+				emit_mov_reg(&prog, true, AUX_REG, src_reg);
+				emit_hmul_aux(&prog, dst_reg,
+					      insn->off == BPF_MUL_VARIANT_SHMUL);
+				break;
+			}
+
 			maybe_emit_mod(&prog, src_reg, dst_reg,
 				       BPF_CLASS(insn->code) == BPF_ALU64);
 
-- 
2.55.0

