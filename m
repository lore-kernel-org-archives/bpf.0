Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F577378D7B;
	Sat, 11 Jul 2026 10:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783764609; cv=none; b=SBU1+r31XwtzTgaxVu7gLs9S+IQzawnNEkWTiQ2eJui//hQIb3At7KpzPJkplf/YTOjndp4NhUJQsm2fE4WkNbiSO8Dp3aItGpHnQ8QYQ9qGRpkxS5vp9GCBtp0KaoeD2m00ubf7UEynDmfRmVnFTXFRDGizxI/CTzAhUf1xaPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783764609; c=relaxed/simple;
	bh=yS+97/41Qd8llSY4zKvUH6KpwF+n52y5s3cK5KRUCmk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l9ARcLDNoUqPm96TD5hanlaB4sE8w+9LkAY9b+9H9flnelMXf+WI+Ib9xjS+ivV612ofOTiO2dnD21uiAregJ+Wb7ubuxi3/fX2viTVK7kpdnG3h5/2KYus1aWI+IpDH6dHwhyaZOh7vL0VIufB8+lSLRXtMks42CKB67nHfVvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8Cxaet3FlJqypgCAA--.10722S3;
	Sat, 11 Jul 2026 18:09:59 +0800 (CST)
Received: from linux.localdomain (unknown [113.200.148.30])
	by front1 (Coremail) with SMTP id qMiowJAxTOV1FlJqVnAJAA--.36096S3;
	Sat, 11 Jul 2026 18:09:59 +0800 (CST)
From: Tiezhu Yang <yangtiezhu@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>,
	Hengqi Chen <hengqi.chen@gmail.com>
Cc: loongarch@lists.linux.dev,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/3] LoongArch: BPF: Remove redundant zext jumping in move_imm()
Date: Sat, 11 Jul 2026 18:09:54 +0800
Message-ID: <20260711100956.4351-2-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20260711100956.4351-1-yangtiezhu@loongson.cn>
References: <20260711100956.4351-1-yangtiezhu@loongson.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJAxTOV1FlJqVnAJAA--.36096S3
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoWrZFy5ZrWfGryftw1DKFyDurX_yoW8JF17p3
	y0kws5t3yvgF1fJa4kJrWxWr1UArs3Wa13W3W2krWUGan8X347Xrn3K3y5XFZ5Gw4rGF1F
	qFZIyw1qvF1DCagCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUkjb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r126r13M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I
	8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r126r1DMcIj6I8E87Iv67AK
	xVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2Ij64
	vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
	jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2I
	x0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK
	8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I
	0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07jjpB-UUUUU=

In move_imm(), when an immediate hits the 12-bit unsigned range, an
`ori rd, $zero, imm` instruction is emitted.

According to the manual, the ori instruction inherently performs a
logical or with zero-extended immediate operands against $zero, so
the upper 32 bits of the destination register `rd` are already 0.

However, the existing JIT code unconditionally executes `goto zext;`
after ori, forcing it to fallthrough into `emit_zext_32()` to clear
the upper 32 bits for 32-bit ALU operations.

Fix this redundancy by directly returning from the function inside
the `is_unsigned_imm12` block.

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 arch/loongarch/net/bpf_jit.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/loongarch/net/bpf_jit.h b/arch/loongarch/net/bpf_jit.h
index a8e29be35fa8..bb58c42c2f2a 100644
--- a/arch/loongarch/net/bpf_jit.h
+++ b/arch/loongarch/net/bpf_jit.h
@@ -156,7 +156,7 @@ static inline void move_imm(struct jit_ctx *ctx, enum loongarch_gpr rd, long imm
 	/* ori rd, $zero, imm_11_0 */
 	if (is_unsigned_imm12(imm)) {
 		emit_insn(ctx, ori, rd, LOONGARCH_GPR_ZERO, imm);
-		goto zext;
+		return;
 	}
 
 	/* lu52id rd, $zero, imm_63_52 */
-- 
2.42.0

