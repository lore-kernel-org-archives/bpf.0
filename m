Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=210.32.2.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792571060;
	b=5FBoh8ZfTNNyxJthQU5pCIJdwoMfOTyLvUHLD/O6mAWEHV0H35jsDErDHsfwvgsJJD41
	 BXxQuCmhs6eUESmi6SQ3MrnZpxOMWKCbF/2nYvffCEprChs2aVoryARFJuWK9a+Bmlswn
	 Ll9NRG/Psfjk1iVJxHexmMK1H+a+RgrZPK/roualg/9LKK1s+NqErdUMwj66LWawSEe94
	 sdNv1Jm3YCxvqYlOXiVRbwT7ctlJHyeESprDVPjttG2YMh9qBBcsMWX62e2LFNEsNjM/P
	 +5CQrKTUBJ0xFIF1OSjfuGJgtSdP+9/CtMghPwLe0PJ8r0PupTNVxUfSl5RT4kxarwQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792571060;
	h=DMARC-Filter:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:X-Mailer:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-CM-SenderInfo:
	 X-CM-DELIVERINFO:X-Coremail-Antispam;
	bh=ZUYLUIYNIvT2fAMsQQMTBfsCLKRtYC4REL8TQLCRp4o=;
	b=NAoBwU8kQyDOnV4hGZ9JUjROdQOCT01qBcbjMKqQgzMEhz1CkFGa0GRPMSeKC4G3oGp2
	 xkx52vY/jrUMd+j55CEIaJgKKrrbLUvmev25mS6dkXSEQ8xykc8c/GLM1jwuXkNbVTcTs
	 C2dxOzO70eKOPsdtbTfs40ghFi8hQnqEHdPwa1qviaZOGHRkAKWG1E1tM5zQrynnP1TqQ
	 szyBJHxzyAlOg/PvfXqMyMqEi4sYdsyf7S6rUZI2yMdoESm8SU0r565W4NQmFk3d7EodT
	 ssjy7/CB8uvp9U0wueMTkMomZsZsxl88pdIqqfEqdfRk/p6JAVDBrav2k2rjm511HeA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=zju.edu.cn;
	spf=pass smtp.mailfrom=zju.edu.cn;
	arc=none smtp.remote-ip=210.32.2.4
Received: from zju.edu.cn (gw.zju.edu.cn [210.32.2.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DDD5606A319;
	Wed, 21 Oct 2026 08:24:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6DDD5606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from zju.edu.cn (unknown [10.162.163.215])
	by mtasvr (Coremail) with SMTP id _____wCHM32adthqGVCtAQ--.275S3;
	Wed, 21 Oct 2026 16:23:54 +0800 (CST)
Received: from lutetium.tail477849.ts.net (unknown [10.162.163.215])
	by mail-app3 (Coremail) with UTF8SMTPA id zS_KCgDHZ6KSdthqyVy1AA--.41177S2;
	Wed, 21 Oct 2026 16:23:47 +0800 (CST)
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
Subject: [PATCH bpf-next v2 5/8] bpf: Reject UHMUL/SHMUL in unsupported backends
Date: Wed, 21 Oct 2026 16:23:44 +0800
Message-ID: <20261021-bpf-hmul-v2-5-88e260099f7d@outlook.com>
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
X-CM-TRANSID:zS_KCgDHZ6KSdthqyVy1AA--.41177S2
X-CM-SenderInfo: qssvjiasrsq6lmxovvfxof0/1tbiBhMLCmrXxB0gcQADsi
X-CM-DELIVERINFO: =?B?nmTESQXKKxbFmtjJiESix3B1w3vD7IpoGYuur0o+r46DyAi5OfOO+T4vrW4FyUBIyu
	9q9C3p0bkPmn0Y7fsOHCqvQSm8JpIX9djNFo0AR66WN37T0QnU/6GqonERN5r60Pi/XNHO
	SMezzgM0yONphbwL0si5ykPrzaIesWwpX89CnKVSOQTjwu1kEhkebUWCxGZHDw==
X-Coremail-Antispam: 1Uk129KBj93XoW3Xw1xtF4rZw1fWFWDAw47Awc_yoWfur43pF
	4kArn3Cr4vgw48ZF1kJa97Zr15tF40ga17CFyj9ayxAanFq3sxXF4fKw15AFZ8ArWUX3WF
	qFWY9r1qk34kXacCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUBEb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Cr1j6rxdM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I
	8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AK
	xVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7xvr2IYc2Ij64
	vIr40E4x8a64kEw24lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lw4CEc2x0rVAKj4xxMxAIw28I
	cxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2
	IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWrXVW8Jr1lIxkGc2Ij64vIr41l
	IxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
	CI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2
	z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x07jeD73UUUUU=

From: Yazhou Tang <tangyazhou518@outlook.com>

CPU JIT backends without explicit UHMUL/SHMUL support currently lower
BPF_MUL based on the opcode without examining insn->off. Once the verifier
accepts UHMUL and SHMUL, a backend without explicit support would therefore
lower either variant as the existing low-half multiplication and silently
produce the wrong result.

Reject UHMUL and SHMUL in each affected CPU JIT without native support,
using its existing unsupported-instruction path. This makes JIT compilation
fail cleanly instead of emitting an incorrect low-half multiply, and allows
the normal interpreter fallback when available.

The NFP hardware offload compiler has the same opcode-only dispatch:
BPF_ALU64 MUL instructions are routed to mul_reg64() or mul_imm64()
without considering insn->off. Reject UHMUL and SHMUL in the NFP offload
verifier as well, before they can reach the ordinary multiplication lowering.

Signed-off-by: Yazhou Tang <tangyazhou518@outlook.com>
Co-developed-by: Tianci Cao <ziye@zju.edu.cn>
Signed-off-by: Tianci Cao <ziye@zju.edu.cn>
Co-developed-by: Shenghao Yuan <shenghaoyuan0928@163.com>
Signed-off-by: Shenghao Yuan <shenghaoyuan0928@163.com>
---
 arch/arc/net/bpf_jit_core.c                       | 3 +++
 arch/arm/net/bpf_jit_32.c                         | 3 +++
 arch/loongarch/net/bpf_jit.c                      | 3 +++
 arch/mips/net/bpf_jit_comp32.c                    | 3 +++
 arch/mips/net/bpf_jit_comp64.c                    | 3 +++
 arch/parisc/net/bpf_jit_comp32.c                  | 3 +++
 arch/parisc/net/bpf_jit_comp64.c                  | 3 +++
 arch/powerpc/net/bpf_jit_comp32.c                 | 3 +++
 arch/powerpc/net/bpf_jit_comp64.c                 | 3 +++
 arch/riscv/net/bpf_jit_comp32.c                   | 3 +++
 arch/s390/net/bpf_jit_comp.c                      | 3 +++
 arch/sparc/net/bpf_jit_comp_64.c                  | 3 +++
 arch/x86/net/bpf_jit_comp32.c                     | 3 +++
 drivers/net/ethernet/netronome/nfp/bpf/verifier.c | 6 ++++++
 14 files changed, 45 insertions(+)

diff --git a/arch/arc/net/bpf_jit_core.c b/arch/arc/net/bpf_jit_core.c
index 639a2736f029..78b1819cee5a 100644
--- a/arch/arc/net/bpf_jit_core.c
+++ b/arch/arc/net/bpf_jit_core.c
@@ -734,6 +734,9 @@ static int handle_insn(struct jit_context *ctx, u32 idx)
 	u8  len = 0;
 	int ret = 0;
 
+	if (bpf_insn_is_hmul(insn))
+		return -EOPNOTSUPP;
+
 	switch (code) {
 	/* dst += src (32-bit) */
 	case BPF_ALU | BPF_ADD | BPF_X:
diff --git a/arch/arm/net/bpf_jit_32.c b/arch/arm/net/bpf_jit_32.c
index 9ede81afbc50..aa466fc79d96 100644
--- a/arch/arm/net/bpf_jit_32.c
+++ b/arch/arm/net/bpf_jit_32.c
@@ -1611,6 +1611,9 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx)
 } while (0)
 #define check_imm24(imm) check_imm(24, imm)
 
+	if (bpf_insn_is_hmul(insn))
+		goto notyet;
+
 	switch (code) {
 	/* ALU operations */
 
diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bpf_jit.c
index 9393e4b0db8e..71bd518ceaf3 100644
--- a/arch/loongarch/net/bpf_jit.c
+++ b/arch/loongarch/net/bpf_jit.c
@@ -709,6 +709,9 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx, bool ext
 	const s32 imm = insn->imm;
 	const bool is32 = BPF_CLASS(insn->code) == BPF_ALU || BPF_CLASS(insn->code) == BPF_JMP32;
 
+	if (bpf_insn_is_hmul(insn))
+		return -EOPNOTSUPP;
+
 	switch (code) {
 	/* dst = src */
 	case BPF_ALU | BPF_MOV | BPF_X:
diff --git a/arch/mips/net/bpf_jit_comp32.c b/arch/mips/net/bpf_jit_comp32.c
index 84d9c7036e4f..4a8bedddf61b 100644
--- a/arch/mips/net/bpf_jit_comp32.c
+++ b/arch/mips/net/bpf_jit_comp32.c
@@ -1544,6 +1544,9 @@ int build_insn(const struct bpf_insn *insn, struct jit_context *ctx)
 	s32 val, rel;
 	u8 alu, jmp;
 
+	if (bpf_insn_is_hmul(insn))
+		goto notyet;
+
 	switch (code) {
 	/* ALU operations */
 	/* dst = imm */
diff --git a/arch/mips/net/bpf_jit_comp64.c b/arch/mips/net/bpf_jit_comp64.c
index 994589c3de46..75202cac31f4 100644
--- a/arch/mips/net/bpf_jit_comp64.c
+++ b/arch/mips/net/bpf_jit_comp64.c
@@ -719,6 +719,9 @@ int build_insn(const struct bpf_insn *insn, struct jit_context *ctx)
 	s32 val, rel;
 	u8 alu, jmp;
 
+	if (bpf_insn_is_hmul(insn))
+		goto notyet;
+
 	switch (code) {
 	/* ALU operations */
 	/* dst = imm */
diff --git a/arch/parisc/net/bpf_jit_comp32.c b/arch/parisc/net/bpf_jit_comp32.c
index eea0a34a3bfe..294eee24f2d9 100644
--- a/arch/parisc/net/bpf_jit_comp32.c
+++ b/arch/parisc/net/bpf_jit_comp32.c
@@ -1142,6 +1142,9 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn, struct hppa_jit_context *ctx,
 		BPF_CLASS(code), code, (code & BPF_ALU64) ? 1:0, BPF_SIZE(code),
 		BPF_OP(code), insn->src_reg, insn->dst_reg);
 
+	if (bpf_insn_is_hmul(insn))
+		return -EOPNOTSUPP;
+
 	switch (code) {
 	/* dst = src */
 	case BPF_ALU64 | BPF_MOV | BPF_X:
diff --git a/arch/parisc/net/bpf_jit_comp64.c b/arch/parisc/net/bpf_jit_comp64.c
index c326fa737ec8..319bd28f1e5b 100644
--- a/arch/parisc/net/bpf_jit_comp64.c
+++ b/arch/parisc/net/bpf_jit_comp64.c
@@ -610,6 +610,9 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn, struct hppa_jit_context *ctx,
 
 	init_regs(&rd, &rs, insn, ctx);
 
+	if (bpf_insn_is_hmul(insn))
+		return -EOPNOTSUPP;
+
 	switch (code) {
 	/* dst = src */
 	case BPF_ALU | BPF_MOV | BPF_X:
diff --git a/arch/powerpc/net/bpf_jit_comp32.c b/arch/powerpc/net/bpf_jit_comp32.c
index bfdc50740da8..6bfc97a029d7 100644
--- a/arch/powerpc/net/bpf_jit_comp32.c
+++ b/arch/powerpc/net/bpf_jit_comp32.c
@@ -349,6 +349,9 @@ int bpf_jit_build_body(struct bpf_prog *fp, u32 *image, u32 *fimage, struct code
 		u32 true_cond;
 		u32 tmp_idx;
 
+		if (bpf_insn_is_hmul(&insn[i]))
+			return -EOPNOTSUPP;
+
 		if (i && (BPF_CLASS(code) == BPF_ALU64 || BPF_CLASS(code) == BPF_ALU) &&
 		    (BPF_CLASS(prevcode) == BPF_ALU64 || BPF_CLASS(prevcode) == BPF_ALU) &&
 		    BPF_OP(prevcode) == BPF_MOV && BPF_SRC(prevcode) == BPF_X &&
diff --git a/arch/powerpc/net/bpf_jit_comp64.c b/arch/powerpc/net/bpf_jit_comp64.c
index fc9db691e820..192c96e0ed34 100644
--- a/arch/powerpc/net/bpf_jit_comp64.c
+++ b/arch/powerpc/net/bpf_jit_comp64.c
@@ -992,6 +992,9 @@ int bpf_jit_build_body(struct bpf_prog *fp, u32 *image, u32 *fimage, struct code
 		u32 tmp_idx;
 		u32 jmp_off;
 
+		if (bpf_insn_is_hmul(&insn[i]))
+			return -EOPNOTSUPP;
+
 		/*
 		 * addrs[] maps a BPF bytecode address into a real offset from
 		 * the start of the body code.
diff --git a/arch/riscv/net/bpf_jit_comp32.c b/arch/riscv/net/bpf_jit_comp32.c
index a9e0bd5cc81d..64bc6779d25c 100644
--- a/arch/riscv/net/bpf_jit_comp32.c
+++ b/arch/riscv/net/bpf_jit_comp32.c
@@ -1014,6 +1014,9 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn, struct rv_jit_context *ctx,
 	const s8 *tmp1 = bpf2rv32[TMP_REG_1];
 	const s8 *tmp2 = bpf2rv32[TMP_REG_2];
 
+	if (bpf_insn_is_hmul(insn))
+		goto notsupported;
+
 	switch (code) {
 	case BPF_ALU64 | BPF_MOV | BPF_X:
 		if (insn->off != 0) {
diff --git a/arch/s390/net/bpf_jit_comp.c b/arch/s390/net/bpf_jit_comp.c
index 8eaaac7028a1..35af9a32294a 100644
--- a/arch/s390/net/bpf_jit_comp.c
+++ b/arch/s390/net/bpf_jit_comp.c
@@ -993,6 +993,9 @@ static noinline int bpf_jit_insn(struct bpf_jit *jit, struct bpf_prog *fp,
 
 	bpf_jit_probe_init(&probe);
 
+	if (bpf_insn_is_hmul(insn))
+		return -EOPNOTSUPP;
+
 	switch (insn->code) {
 	/*
 	 * BPF_MOV
diff --git a/arch/sparc/net/bpf_jit_comp_64.c b/arch/sparc/net/bpf_jit_comp_64.c
index 2fa0e9375127..1154ddc515b0 100644
--- a/arch/sparc/net/bpf_jit_comp_64.c
+++ b/arch/sparc/net/bpf_jit_comp_64.c
@@ -901,6 +901,9 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx)
 	const s16 off = insn->off;
 	const s32 imm = insn->imm;
 
+	if (bpf_insn_is_hmul(insn))
+		return -EOPNOTSUPP;
+
 	if (insn->src_reg == BPF_REG_FP)
 		ctx->saw_frame_pointer = true;
 
diff --git a/arch/x86/net/bpf_jit_comp32.c b/arch/x86/net/bpf_jit_comp32.c
index 852baf2e4db4..11ed65130d1e 100644
--- a/arch/x86/net/bpf_jit_comp32.c
+++ b/arch/x86/net/bpf_jit_comp32.c
@@ -1683,6 +1683,9 @@ static int do_jit(struct bpf_prog *bpf_prog, int *addrs, u8 *image,
 		int ilen;
 		u8 *func;
 
+		if (bpf_insn_is_hmul(insn))
+			goto notyet;
+
 		switch (code) {
 		/* ALU operations */
 		/* dst = src */
diff --git a/drivers/net/ethernet/netronome/nfp/bpf/verifier.c b/drivers/net/ethernet/netronome/nfp/bpf/verifier.c
index 9ddbfe9d6019..4481c8d84d28 100644
--- a/drivers/net/ethernet/netronome/nfp/bpf/verifier.c
+++ b/drivers/net/ethernet/netronome/nfp/bpf/verifier.c
@@ -3,6 +3,7 @@
 
 #include <linux/bpf.h>
 #include <linux/bpf_verifier.h>
+#include <linux/filter.h>
 #include <linux/kernel.h>
 #include <linux/netdevice.h>
 #include <linux/pkt_cls.h>
@@ -561,6 +562,11 @@ nfp_bpf_check_alu(struct nfp_prog *nfp_prog, struct nfp_insn_meta *meta,
 	const struct bpf_reg_state *dreg =
 		cur_regs(env) + meta->insn.dst_reg;
 
+	if (bpf_insn_is_hmul(&meta->insn)) {
+		pr_vlog(env, "UHMUL/SHMUL are not supported\n");
+		return -EOPNOTSUPP;
+	}
+
 	meta->umin_src = min(meta->umin_src, reg_umin(sreg));
 	meta->umax_src = max(meta->umax_src, reg_umax(sreg));
 	meta->umin_dst = min(meta->umin_dst, reg_umin(dreg));

-- 
2.56.0

