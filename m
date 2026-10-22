Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=210.32.2.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792686554;
	b=AvFgHLO0Nkuw1FK7XxGNSoKmpjURWGBvbXaVP1wcTIj9HYlxab7Iq0JOgZBLjWmh7H/c
	 O40DFgIWEhp9NQ5GzUyAcsPJM7Dqp/TexyFREKBseYhh8diI0P5IK4SfcP/ruvIRja5MH
	 6mkKLfhclN+ptGvcI9Zsz1YzGWFDhOe/XNGpbmlp1cFs0B9o/fdZ/hDPxmEdrPXuCgBQW
	 L6iYCiVjH2VscMWMEbyTseEV37KUrkPkZqVmpR+rB8iK+8j2uEW5UsoasKZzXVm8W5lRr
	 US5w3cpmuOvkPYUqDmyiXyY7ANdaACoWc8OTCYOdSCn/2nVUETvpaW97pZw01vBM4qw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792686554;
	h=DMARC-Filter:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:X-Mailer:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-CM-SenderInfo:
	 X-CM-DELIVERINFO:X-Coremail-Antispam;
	bh=4zpg+d2Y/YWU9dBCmWBPbPCICknsWcgc4NzLDHirAYE=;
	b=X5H8evfV5HHto4EabxHLBMY4B89+EctSIhTh8rYbXgMjzeftSuza8fkfr4yuXoXhCy1R
	 YEcDM9cnNXODBTsv00sc61AW/NT2KgipCmNAApuR/Dd4+DgRdHJ6i2twHxzLmPa1DHILL
	 xQpEUMwpiAhE3JVusF4Y0QBBCLFgehmiolNB+s2Bd29PcekEsOtAct35i2Fz/hDFaYvIf
	 8ObD4i2iC6vlwmgO0pQ8xx48bpC/D/ii9cLiZJaHDW8/w1WW3VqYuTdcRjy5lHs1NWw13
	 p9EkilAspo5O+J7uSt+QiK9Da//BoiaB7T5l1NoZw/K9fHUY6Dj57Ceup7HskmJmFPA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=zju.edu.cn;
	spf=pass smtp.mailfrom=zju.edu.cn;
	arc=none smtp.remote-ip=210.32.2.4
Received: from zju.edu.cn (gw.zju.edu.cn [210.32.2.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDEB1606A31B;
	Thu, 22 Oct 2026 16:29:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EDEB1606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from zju.edu.cn (unknown [10.192.73.73])
	by mtasvr (Coremail) with SMTP id _____wCHIzzEOdpqM1K0AQ--.3595S3;
	Fri, 23 Oct 2026 00:28:53 +0800 (CST)
Received: from wolframium.tail477849.ts.net (unknown [10.192.73.73])
	by mail-app1 (Coremail) with UTF8SMTPA id yy_KCgAnNYLEOdpqCKOJAA--.45403S2;
	Fri, 23 Oct 2026 00:28:52 +0800 (CST)
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
	Yazhou Tang <tangyazhou518@outlook.com>,
	Tianci Cao <ziye@zju.edu.cn>,
	Shenghao Yuan <shenghaoyuan0928@163.com>
Subject: [PATCH bpf-next v3 4/7] bpf, riscv: JIT UHMUL and SHMUL on RV64
Date: Fri, 23 Oct 2026 00:28:44 +0800
Message-ID: <20261023-bpf-hmul-v3-4-b99e808cb28b@outlook.com>
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
X-CM-TRANSID:yy_KCgAnNYLEOdpqCKOJAA--.45403S2
X-CM-SenderInfo: qssvjiasrsq6lmxovvfxof0/1tbiAgcMCmrZFZ1PbgAAsZ
X-CM-DELIVERINFO: =?B?LIvJiAXKKxbFmtjJiESix3B1w3vD7IpoGYuur0o+r46DyAi5OfOO+T4vrW4FyUBIyu
	9q9JvUPXy3lrK4tLMdKxxmGTMAANfNQqn9NorCujO+csyB/yxq06i2V+Rls4y2tTJjy1Ge
	lw9XxDD7uwItX54c+IVPjykV3RS2lZH13tYw/MjBr+dIyu7j4V2aU8N5SK5sqA==
X-Coremail-Antispam: 1Uk129KBj93XoWxXw1rCFWkJr15Zw1rAry8Xrc_yoW5urykpr
	Z0krn3urWvqF4fJFyDJF47Zw15GFn7Wry7KF1UKay5JF42qFZ7Ga1rKw12yr98XFyrWa48
	JFWY9F9xC3yvyrgCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUBYb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26r1j6r4UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8JVW8Jr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27w
	Aqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JF0_Jw1lYx0Ex4A2jsIE
	14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjcxG0xvY0x
	0EwIxGrVCF72vEw4AK0wACI402YVCY1x02628vn2kIc2xKxwCF04k20xvY0x0EwIxGrwCF
	x2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14
	v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY
	67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJwCI42IY6xAIw20EY4
	v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AK
	xVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8b_-PUUUUU==

From: Yazhou Tang <tangyazhou518@outlook.com>

On RV64, the RISC-V M extension provides MULHU and MULH instructions that
return the high 64 bits of an unsigned or signed 64-bit multiplication,
respectively.

Add the missing MULH encoder and use MULHU and MULH to lower the UHMUL and
SHMUL BPF_MUL variants for both register and immediate sources. Keep the
existing low-half and ALU32 multiplication lowering unchanged.

Opt the RV64 JIT into HMUL support by returning true from
bpf_jit_supports_hmul().

Suggested-by: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Signed-off-by: Yazhou Tang <tangyazhou518@outlook.com>
Co-developed-by: Tianci Cao <ziye@zju.edu.cn>
Signed-off-by: Tianci Cao <ziye@zju.edu.cn>
Co-developed-by: Shenghao Yuan <shenghaoyuan0928@163.com>
Signed-off-by: Shenghao Yuan <shenghaoyuan0928@163.com>
Acked-by: Björn Töpel <bjorn@kernel.org>
---
 arch/riscv/net/bpf_jit.h        |  5 +++++
 arch/riscv/net/bpf_jit_comp64.c | 23 ++++++++++++++++++++---
 2 files changed, 25 insertions(+), 3 deletions(-)

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
index 788fcc21fd5b..371405598faa 100644
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
+	else if (off == BPF_UHMUL)
+		emit(rv_mulhu(rd, rd, rs), ctx);
+	else if (off == BPF_SHMUL)
+		emit(rv_mulh(rd, rd, rs), ctx);
+	else
+		emit(rv_mul(rd, rd, rs), ctx);
+}
+
 static void __build_epilogue(bool is_tail_call, struct rv_jit_context *ctx)
 {
 	int stack_adjust = ctx->stack_size, store_offset = stack_adjust - 8;
@@ -1526,7 +1539,7 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn, struct rv_jit_context *ctx,
 		break;
 	case BPF_ALU | BPF_MUL | BPF_X:
 	case BPF_ALU64 | BPF_MUL | BPF_X:
-		emit(is64 ? rv_mul(rd, rd, rs) : rv_mulw(rd, rd, rs), ctx);
+		emit_mul(rd, rs, is64, off, ctx);
 		if (!is64 && !aux->verifier_zext)
 			emit_zextw(rd, rd, ctx);
 		break;
@@ -1662,8 +1675,7 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn, struct rv_jit_context *ctx,
 	case BPF_ALU | BPF_MUL | BPF_K:
 	case BPF_ALU64 | BPF_MUL | BPF_K:
 		emit_imm(RV_REG_T1, imm, ctx);
-		emit(is64 ? rv_mul(rd, rd, RV_REG_T1) :
-		     rv_mulw(rd, rd, RV_REG_T1), ctx);
+		emit_mul(rd, RV_REG_T1, is64, off, ctx);
 		if (!is64 && !aux->verifier_zext)
 			emit_zextw(rd, rd, ctx);
 		break;
@@ -2303,3 +2315,8 @@ bool bpf_jit_supports_callx(void)
 {
 	return true;
 }
+
+bool bpf_jit_supports_hmul(void)
+{
+	return true;
+}

-- 
2.56.0

