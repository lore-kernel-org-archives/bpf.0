Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F32D382389;
	Tue,  7 Apr 2026 06:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775543004; cv=none; b=WRgHZRSfPB63MM563TiLJxvY0tZfTfDhL+5elkafH6z58zSZmE+gzYvS6zHia9P2WbF9VdQx6nrSjWRhDk2c2pQPT1XVvQ0sWOaBaWUEOeOcTIFpbsV70woKA1hdJWl+CqOSx9WjiaDplax2cd6EXIIfgN0TwMKV3JkeZX8naYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775543004; c=relaxed/simple;
	bh=XQ4Vez+4fynTr5VWS/XpBbVcpmlTMr1JImr1B/hJwLU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D7YA2zpbMLv5KDn5edVIrih9nWI0ZcgkkF+voLeRBXo8M4ZyvP7qvUKZ2Z6DJq1CaIpB3Mx1flYvwsdAGUnmrv4LhKxPezZJCUSsbdzb/XJjkMi13n2dc7HGlGpHGB+qAgAu87t0U3E2MHrgwHZr4roqhydk5jTi0BFTrFSytqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8DxssDTotRpuqUiAA--.37580S3;
	Tue, 07 Apr 2026 14:23:15 +0800 (CST)
Received: from linux.localdomain (unknown [113.200.148.30])
	by front1 (Coremail) with SMTP id qMiowJCx_8LLotRpYh5nAA--.54S4;
	Tue, 07 Apr 2026 14:23:14 +0800 (CST)
From: Tiezhu Yang <yangtiezhu@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>,
	Hengqi Chen <hengqi.chen@gmail.com>
Cc: loongarch@lists.linux.dev,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/5] LoongArch: BPF: Add the default case in emit_atomic() and rename it
Date: Tue,  7 Apr 2026 14:23:03 +0800
Message-ID: <20260407062306.8915-3-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20260407062306.8915-1-yangtiezhu@loongson.cn>
References: <20260407062306.8915-1-yangtiezhu@loongson.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJCx_8LLotRpYh5nAA--.54S4
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoW7tFWrWr17WF43Jr4UAr1fAFc_yoW8Cr1Dpr
	s8AwsYkrZ3XwnYga4DJa9ruw13KFs5tay3JF4UZ3yxXwsIqr1DWF1rt3WqqFy5A3y8Wr1f
	XrsYkFyUu3W8J3cCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUkFb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r126r13M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27w
	Aqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jw0_WrylYx0Ex4A2jsIE
	14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCF04k20xvY0x
	0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E
	7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcV
	C0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF
	04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7
	CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07j5l1kUUUUU=

Like the other archs such as x86 and riscv, add the default case
in emit_atomic() to print an error message for the invalid opcode
and return -EINVAL , then make its return type as int.

While at it, given that all of the instructions in emit_atomic()
are only read-modify-write instructions, rename emit_atomic() to
emit_atomic_rmw() to make it clear, because there will be a new
function emit_atomic_ld_st() for load-acquire and store-release
instructions in the later patch.

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 arch/loongarch/net/bpf_jit.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bpf_jit.c
index 9cb796e16379..fefda4050a20 100644
--- a/arch/loongarch/net/bpf_jit.c
+++ b/arch/loongarch/net/bpf_jit.c
@@ -344,7 +344,7 @@ static int emit_bpf_tail_call(struct jit_ctx *ctx, int insn)
 #undef jmp_offset
 }
 
-static void emit_atomic(const struct bpf_insn *insn, struct jit_ctx *ctx)
+static int emit_atomic_rmw(const struct bpf_insn *insn, struct jit_ctx *ctx)
 {
 	const u8 t1 = LOONGARCH_GPR_T1;
 	const u8 t2 = LOONGARCH_GPR_T2;
@@ -448,7 +448,12 @@ static void emit_atomic(const struct bpf_insn *insn, struct jit_ctx *ctx)
 			emit_zext_32(ctx, r0, true);
 		}
 		break;
+	default:
+		pr_err_once("bpf-jit: invalid atomic read-modify-write opcode %02x\n", imm);
+		return -EINVAL;
 	}
+
+	return 0;
 }
 
 static bool is_signed_bpf_cond(u8 cond)
@@ -1256,7 +1261,9 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx, bool ext
 
 	case BPF_STX | BPF_ATOMIC | BPF_W:
 	case BPF_STX | BPF_ATOMIC | BPF_DW:
-		emit_atomic(insn, ctx);
+		ret = emit_atomic_rmw(insn, ctx);
+		if (ret)
+			return ret;
 		break;
 
 	/* Speculation barrier */
-- 
2.42.0

