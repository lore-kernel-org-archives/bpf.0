Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F3143431E6;
	Sat, 11 Jul 2026 10:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783764609; cv=none; b=Fi23LoYOfK6enW0ZMQfCRl9ANHf/rkrKQum61tHLtqKdlqiLhHNjopHiVShDlkmvQRlJO00E57XXWvT7Wml46JCnolQNJ6Gdy/Jf4qTiLnf7KyUdhjEQGHLAxRcBuofhQkyD1k/uL9wpt7vmNDMD3E8a5eOM/jyOlwbs0+F3fSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783764609; c=relaxed/simple;
	bh=w8zIGyzCl2Br4soKquLqAXcNYNTCI4ddHmmc29vYsnk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V06wrVsTaphUspigPHtDVF3jE4WYkLsJZzF4a5pLjkyFiuK7c2iIkETx6t8Hdy1shMflWng0CmcfbgtP/McTKXYzEzZGgEbwmTThdPdjuHWZ5SeeFAHaJENSd0nw0lRVn8+hJMq2mZF88XhtfCiinBENAaBqFhI6NpnlNfaSqXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8CxJOp4FlJq0pgCAA--.9393S3;
	Sat, 11 Jul 2026 18:10:00 +0800 (CST)
Received: from linux.localdomain (unknown [113.200.148.30])
	by front1 (Coremail) with SMTP id qMiowJAxTOV1FlJqVnAJAA--.36096S5;
	Sat, 11 Jul 2026 18:10:00 +0800 (CST)
From: Tiezhu Yang <yangtiezhu@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>,
	Hengqi Chen <hengqi.chen@gmail.com>
Cc: loongarch@lists.linux.dev,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 3/3] LoongArch: BPF: Split unconditional branch JA paths statically
Date: Sat, 11 Jul 2026 18:09:56 +0800
Message-ID: <20260711100956.4351-4-yangtiezhu@loongson.cn>
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
X-CM-TRANSID:qMiowJAxTOV1FlJqVnAJAA--.36096S5
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoW7WFyUXw17Xr4rZF48Kw18tFc_yoW8Gr13pr
	n8ur90yr4SgryrXFsrX39rWa45tws3Gry2qFWDKw48JrZIq3s8XF1rKw1agF98Gwn3Z3WI
	gF9Y9rnxu3WDAacCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUk0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I
	8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1q6rW5McIj6I8E87Iv67AK
	xVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2Ij64
	vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
	jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2I
	x0cI8IcVAFwI0_Gr0_Xr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK
	8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I
	0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUcCD7UUUUU

In build_insn(), both 32-bit and 64-bit unconditional branch JA paths
currently share a single case block. It relies on a runtime condition
check to multiplex between the 'off' and 'imm' fields.

Since the instruction classes are already resolved at compile-time via
distinct switch-case labels, this runtime check is redundant.

Split the two paths into individual case blocks to remove the redundant
runtime check.

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 arch/loongarch/net/bpf_jit.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bpf_jit.c
index 5f32b205a6ac..69bc30f88c44 100644
--- a/arch/loongarch/net/bpf_jit.c
+++ b/arch/loongarch/net/bpf_jit.c
@@ -1150,11 +1150,12 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx, bool ext
 
 	/* PC += off */
 	case BPF_JMP | BPF_JA:
+		jmp_offset = bpf2la_offset(i, off, ctx);
+		if (emit_uncond_jmp(ctx, jmp_offset) < 0)
+			goto toofar;
+		break;
 	case BPF_JMP32 | BPF_JA:
-		if (BPF_CLASS(code) == BPF_JMP)
-			jmp_offset = bpf2la_offset(i, off, ctx);
-		else
-			jmp_offset = bpf2la_offset(i, imm, ctx);
+		jmp_offset = bpf2la_offset(i, imm, ctx);
 		if (emit_uncond_jmp(ctx, jmp_offset) < 0)
 			goto toofar;
 		break;
-- 
2.42.0

