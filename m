Received: from zg8tmtyylji0my4xnjeumjiw.icoremail.net (zg8tmtyylji0my4xnjeumjiw.icoremail.net [162.243.161.220])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39D802C027F
	for <bpf@vger.kernel.org>; Wed,  2 Sep 2026 07:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.161.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788332801; cv=none; b=Dk6pPdlgDVOa49XBGPEcwQRYBtXW1OpsPzbqNMqL82If8xRDaOrI9WToOlybTOln0e9A0hziMo940gC4EjkWW1IOqPnPOg051mX/ZBaR3rhYI8m5ZKxbSEfUGOUpIL5uPIiG3UIv3xs/a8Cwc1qV29z74XQVK6B4LrAl7bRp22Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788332801; c=relaxed/simple;
	bh=8ewlaT5eOdydcuaNtDcllOYby4eA3U27K4wPJtalqmk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bjGN3Z/HGl6QDipF5SWsCRe2Zm83GbW55sBvPonxFI3RHqK7DeykW5yAsO1DM6pdf/TDCbJwNpM3SyqRhh09EVEo0XGbmC6cv+ElujVjm1zpIU51hYcCxH+yaArZqrqiqjYFAbP3xNDsERWzUgCWh82Zc9SftA7Rh3YeCi9RsOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=162.243.161.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from zju.edu.cn (unknown [10.14.28.207])
	by mtasvr (Coremail) with SMTP id _____wBnQX7dypdqFRXjAA--.9584S3;
	Wed, 02 Sep 2026 15:06:05 +0800 (CST)
Received: from lutetium.tail477849.ts.net (unknown [10.14.28.207])
	by mail-app2 (Coremail) with SMTP id zC_KCgDHEMXcypdq+x1IBA--.64992S2;
	Wed, 02 Sep 2026 15:06:05 +0800 (CST)
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
Subject: [RFC PATCH bpf-next 2/6] bpf, x86: JIT UHMUL and SHMUL on x86-64
Date: Wed,  2 Sep 2026 15:05:30 +0800
Message-ID: <20260902070534.2141812-3-tangyazhou@zju.edu.cn>
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
X-CM-TRANSID:zC_KCgDHEMXcypdq+x1IBA--.64992S2
X-CM-SenderInfo: qssvjiasrsq6lmxovvfxof0/1tbiBgICCmqXKpkZxgAAsd
X-CM-DELIVERINFO: =?B?sBK/YwXKKxbFmtjJiESix3B1w3vD7IpoGYuur0o+r46DyAi5OfOO+T4vrW4FyUBIyu
	9q9PYsV5on1RElGPnYlsVFa2q1sn5An/8RDTO0AZ0bmJUyRsbwf2xqKzsI4PywII6HFv9X
	/Aval9UCskWhzFNywnC/Pp8gXplja5n4FyhJ/R/dcI52Bf8ebYG51r56/3NqsQ==
X-Coremail-Antispam: 1Uk129KBj93XoWxGFW3AFykAFWxKw1kZr45CFX_yoW5tw43pF
	s7Crn3CFWDZwsrtrZrXFWxZFnxWF4xWr1xAa47A3y7X3ZxXr1ruF4xK3W3t3s8CryFvw1f
	tr1j9347C3WkWFbCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUU9Kb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Cr1j6rxdM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I
	8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AK
	xVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7xvr2IYc2Ij64
	vIr40E4x8a64kEw24lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2Ij64vIr41l4I8I
	3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxV
	WUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAF
	wI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcI
	k0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j
	6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU2db1UUUUU

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
index 48429fae0641..233a05971cf4 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -1110,6 +1110,38 @@ static void maybe_emit_1mod(u8 **pprog, u32 reg, bool is64)
 	*pprog = prog;
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
@@ -2088,6 +2120,14 @@ static int do_jit(struct bpf_verifier_env *env, struct bpf_prog *bpf_prog, int *
 
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
 
@@ -2104,6 +2144,14 @@ static int do_jit(struct bpf_verifier_env *env, struct bpf_prog *bpf_prog, int *
 
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
2.43.0

