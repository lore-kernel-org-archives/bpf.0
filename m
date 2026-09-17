Received: from zg8tmtyylji0my4xnjeumjiw.icoremail.net (zg8tmtyylji0my4xnjeumjiw.icoremail.net [162.243.161.220])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBA922BE7BE
	for <bpf@vger.kernel.org>; Thu, 17 Sep 2026 04:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.161.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789618674; cv=none; b=W3JQ6F/pcYqBNjVbeEva3qn6Exbq9aWULOU2bRGy5b461NObPEjpDC/9MJ+i8XfeNFv+5DnXRIZpQp7U8eYPHxi44E66YCjbcQ2RviNeu6pxepZgKJ0bvPink2lz9EWaUNJNjV+6lWczAFf2j89bzf29f9j1Q9hCj1a3m42RkCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789618674; c=relaxed/simple;
	bh=UtIiyhx7xTUtvqGHHN8hjXPr4otchmxj2RP0GW/mHpI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ms6LShNdd0hyfODsH8q6VFyUz1rEb24Vmxk5GcY+n3LJizbu/PIGQdsByjfqfFGLNGBLbCgod2CdUR8ElTLqiUaNna+4R6S4jEdQ5KqLgvswAw29Kv/cOiQfNeCb7LuTTgeK/3BpwbOySKl0BY96cDsGmdkpMM9bgs+YsZB+TVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=162.243.161.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from zju.edu.cn (unknown [10.162.163.215])
	by mtasvr (Coremail) with SMTP id _____wCXn3_XaatqnRMdAQ--.4127S3;
	Thu, 17 Sep 2026 12:17:27 +0800 (CST)
Received: from lutetium.tail477849.ts.net (unknown [10.162.163.215])
	by mail-app1 (Coremail) with SMTP id yy_KCgC3uaPXaatqJeuJBA--.2178S2;
	Thu, 17 Sep 2026 12:17:27 +0800 (CST)
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
Subject: [PATCH bpf-next 4/8] bpf, riscv: JIT UHMUL and SHMUL on RV64
Date: Thu, 17 Sep 2026 12:17:08 +0800
Message-ID: <20260917041712.1860722-5-tangyazhou@zju.edu.cn>
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
X-CM-TRANSID:yy_KCgC3uaPXaatqJeuJBA--.2178S2
X-CM-SenderInfo: qssvjiasrsq6lmxovvfxof0/1tbiAgERCmqq8RoVXQAEs-
X-CM-DELIVERINFO: =?B?LN9wrwXKKxbFmtjJiESix3B1w3vD7IpoGYuur0o+r46DyAi5OfOO+T4vrW4FyUBIyu
	9q9BMXZiQifGBAu8ehqrOKaOrkKdH7bq7gRxNBpyQy62yDDlSN24p++xaLpNrAU+XNr3lo
	OgZa6pbw/w+V2YWLMSrWMjgJuyqGNMP+ujHqfSGWxPpfHk6jcYgx8PzLxgcfeg==
X-Coremail-Antispam: 1Uk129KBj93XoWxXw1rCw1UCF1DCw1rJF48Xwc_yoW5Cry3pr
	Z0krn3urWvqF4fJFyDJF47Zw15GF1vgrW7Kry5Kay5KFsFqFZ7Ga1fKw17CF98XryrXa48
	JFWY9F93C3yvyrbCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUBjb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AK
	xVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI0UMc
	02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUAVWUtwAv7VC2z280aVAF
	wI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0Y48IcxkI7V
	AKI48G6xCjnVAKz4kxM4IIrI8v6xkF7I0E8cxan2IY04v7MxAIw28IcxkI7VAKI48JMxC2
	0s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI
	0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE
	14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1lIxAIcVCF04k26cxKx2
	IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_
	Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jjhFxUUUUU=

From: Yazhou Tang <tangyazhou518@outlook.com>

On RV64, the RISC-V M extension provides MULHU and MULH instructions that
return the high 64 bits of an unsigned or signed 64-bit multiplication,
respectively.

Add the missing MULH encoder and use MULHU and MULH to lower the UHMUL and
SHMUL BPF_MUL variants for both register and immediate sources. Keep the
existing low-half and ALU32 multiplication lowering unchanged.

Suggested-by: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Signed-off-by: Yazhou Tang <tangyazhou518@outlook.com>
Co-developed-by: Tianci Cao <ziye@zju.edu.cn>
Signed-off-by: Tianci Cao <ziye@zju.edu.cn>
Co-developed-by: Shenghao Yuan <shenghaoyuan0928@163.com>
Signed-off-by: Shenghao Yuan <shenghaoyuan0928@163.com>
---
 arch/riscv/net/bpf_jit.h        |  5 +++++
 arch/riscv/net/bpf_jit_comp64.c | 18 +++++++++++++++---
 2 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/arch/riscv/net/bpf_jit.h b/arch/riscv/net/bpf_jit.h
index 5c4f53060c91..21a190a6a6d9 100644
--- a/arch/riscv/net/bpf_jit.h
+++ b/arch/riscv/net/bpf_jit.h
@@ -436,6 +436,11 @@ static inline u32 rv_mul(u8 rd, u8 rs1, u8 rs2)
 	return rv_r_insn(1, rs2, rs1, 0, rd, 0x33);
 }
 
+static inline u32 rv_mulh(u8 rd, u8 rs1, u8 rs2)
+{
+	return rv_r_insn(1, rs2, rs1, 1, rd, 0x33);
+}
+
 static inline u32 rv_mulhu(u8 rd, u8 rs1, u8 rs2)
 {
 	return rv_r_insn(1, rs2, rs1, 3, rd, 0x33);
diff --git a/arch/riscv/net/bpf_jit_comp64.c b/arch/riscv/net/bpf_jit_comp64.c
index ed0a6f871dea..a773506a9209 100644
--- a/arch/riscv/net/bpf_jit_comp64.c
+++ b/arch/riscv/net/bpf_jit_comp64.c
@@ -197,6 +197,19 @@ static void emit_imm(u8 rd, s64 val, struct rv_jit_context *ctx)
 		emit_addi(rd, rd, lower, ctx);
 }
 
+static void emit_mul(u8 rd, u8 rs, bool is64, s16 off,
+		     struct rv_jit_context *ctx)
+{
+	if (!is64)
+		emit(rv_mulw(rd, rd, rs), ctx);
+	else if (off == BPF_MUL_VARIANT_UHMUL)
+		emit(rv_mulhu(rd, rd, rs), ctx);
+	else if (off == BPF_MUL_VARIANT_SHMUL)
+		emit(rv_mulh(rd, rd, rs), ctx);
+	else
+		emit(rv_mul(rd, rd, rs), ctx);
+}
+
 static void __build_epilogue(bool is_tail_call, struct rv_jit_context *ctx)
 {
 	int stack_adjust = ctx->stack_size, store_offset = stack_adjust - 8;
@@ -1498,7 +1511,7 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn, struct rv_jit_context *ctx,
 		break;
 	case BPF_ALU | BPF_MUL | BPF_X:
 	case BPF_ALU64 | BPF_MUL | BPF_X:
-		emit(is64 ? rv_mul(rd, rd, rs) : rv_mulw(rd, rd, rs), ctx);
+		emit_mul(rd, rs, is64, off, ctx);
 		if (!is64 && !aux->verifier_zext)
 			emit_zextw(rd, rd, ctx);
 		break;
@@ -1634,8 +1647,7 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn, struct rv_jit_context *ctx,
 	case BPF_ALU | BPF_MUL | BPF_K:
 	case BPF_ALU64 | BPF_MUL | BPF_K:
 		emit_imm(RV_REG_T1, imm, ctx);
-		emit(is64 ? rv_mul(rd, rd, RV_REG_T1) :
-		     rv_mulw(rd, rd, RV_REG_T1), ctx);
+		emit_mul(rd, RV_REG_T1, is64, off, ctx);
 		if (!is64 && !aux->verifier_zext)
 			emit_zextw(rd, rd, ctx);
 		break;
-- 
2.55.0

