Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.243.161.220
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792571053;
	b=WQ7k9IN3qQpigC3za8C/3veecy75XDnX4sbk0sV2pX9MusU2pCaA1pprGMllN/1w9d5R
	 6Yh+o9FQBNKOjfZyboZCyGOfz8gC0iiYWOSeGwpJ5ZPubLcBMLuC0sI7uQlnhNbYdIYhP
	 ravS9a/c3gVrfOYdr0PfCaM82FAa6HUuA7Ze8GO9U1PHTdBMpDXly+Knv6IpZlNc/71F/
	 bblhOP/ajAHIs+WwF0T1vV9BE/HwFIBFdxuKTB572mH+2DvI5XKZQcaX9WZKGARZgxbeV
	 Sm2DOQiDz36+Qi0//h0pmL/28e+k442/BXDKgsjcPECDUu33RpauNEh20xANbQCgTUA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792571053;
	h=DMARC-Filter:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:X-Mailer:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-CM-SenderInfo:
	 X-CM-DELIVERINFO:X-Coremail-Antispam;
	bh=CbD0gxR0Wk8lCNNFQRlUKh0FxoEg/NBxggjXK7WDk24=;
	b=i1Je/Cc0GbCpITYsq6hzw9mllSIxBRzPerUbL97mLmWLsT50dahe4TD/Tb/F9fUwGF2D
	 41vIUyOG5FgC2+wLlUBDnBKu1+5vv2ychIpBi0fOdaRdVLS1ModZ2Khy0VxadC2W6iwtw
	 UrvIm93Q+8s3fBfBTfZp9Ioogi/509u6FUfilbQe8E3kpmBcBwqKnHdYfiAa/f8UF20hI
	 c5zz/Y6aBrCc7m8+bkmd/Eb9Qqh+IEgfTV4bTJwZkqdBpB2cS39wcsb+mPZfPRewH8DRc
	 bXzwDPcRKKhbBXqSGA0jU6v9fy5+vLg5sPpPDDrwkfjOGVMcfBFRCYTeIqc8jLjb+RA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=zju.edu.cn;
	spf=pass smtp.mailfrom=zju.edu.cn;
	arc=none smtp.remote-ip=162.243.161.220
Received: from zg8tmtyylji0my4xnjeumjiw.icoremail.net (zg8tmtyylji0my4xnjeumjiw.icoremail.net [162.243.161.220])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77ADE606A324;
	Wed, 21 Oct 2026 08:24:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 77ADE606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from zju.edu.cn (unknown [10.162.163.215])
	by mtasvr (Coremail) with SMTP id _____wDnoj2Ldthqx0+tAQ--.291S3;
	Wed, 21 Oct 2026 16:23:39 +0800 (CST)
Received: from lutetium.tail477849.ts.net (unknown [10.162.163.215])
	by mail-app3 (Coremail) with UTF8SMTPA id zS_KCgDHZ6KJdthqoVy1AA--.41174S2;
	Wed, 21 Oct 2026 16:23:38 +0800 (CST)
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
Subject: [PATCH bpf-next v2 4/8] bpf, riscv: JIT UHMUL and SHMUL on RV64
Date: Wed, 21 Oct 2026 16:23:34 +0800
Message-ID: <20261021-bpf-hmul-v2-4-88e260099f7d@outlook.com>
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
X-CM-TRANSID:zS_KCgDHZ6KJdthqoVy1AA--.41174S2
X-CM-SenderInfo: qssvjiasrsq6lmxovvfxof0/1tbiBhMLCmrXxB0gcQACsj
X-CM-DELIVERINFO: =?B?6hsdgwXKKxbFmtjJiESix3B1w3vD7IpoGYuur0o+r46DyAi5OfOO+T4vrW4FyUBIyu
	9q9C3p0bkPmn0Y7fsOHCqvQSlsVEzD+W3MyGWincVVrVSTU+ArkQH/OK/F0lezexfgEdHO
	SMezzgM0yONphbwL0sjex5asr3klFH/wch+QcGGSGhWFXUjsiodnGlnB8JMk6w==
X-Coremail-Antispam: 1Uk129KBj93XoWxXw1rCw1UCF1DCw1rJF48Xwc_yoW5Cr15pr
	Z0krna9rWvqF4fJFyDJF47Zw15JFn2gry7KF15Kay5GFsFqFZ7Ga1fKw17Ar98XFyrXa48
	JFWY9FnxCayvyrbCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUBEb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AK
	xVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI0UMc
	02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAF
	wI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0Y48IcxkI7V
	AKI48G6xCjnVAKz4kxM4IIrI8v6xkF7I0E8cxan2IY04v7M4kE6xkIj40Ew7xC0wCF04k2
	0xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI
	8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Wrv_Gr1UMIIYrxkI7VAKI48J
	MIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJw
	CI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2
	z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x07j8189UUUUU=

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
index 788fcc21fd5b..dfaf85926f20 100644
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

-- 
2.56.0

