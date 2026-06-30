Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D381533F5AE;
	Tue, 30 Jun 2026 02:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782786440; cv=none; b=Vx8ITTwmfHuQCZShqDA5W79uEE1hMUBSHPPpg7ukrtCjsIyzX8klBByRcxPptsW56KdBW7ppLLUtWyiKdRIO3HOKTqLbDq2yavfPiqbp5/FEg9DmkuqxQjW1Rms9m/djrRQ7wssw4gFQ1Ceyejv/0yC2XiSQmSLrAR8BURVxZeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782786440; c=relaxed/simple;
	bh=wDfWyJSySFUPDT/NxSIVB2ine9Z5DIgAsWv7Vpn+7+o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bwiruQb0ZU4VioURYMypxNsRVZrNHfBnJerx+PjMX1briJsgvvZZJhgnnIvfHzDvjqUnOiwfjBj9oTM++RaZKaxueOh2VZK/1GfyaeoiE9GSnA91dpzl3v62lDml0QpQyZB9g4CAm0ez/YNw0rk4YK49DGydYrY+xbQoisFZYl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8CxX+p9KUNq1HcZAA--.64125S3;
	Tue, 30 Jun 2026 10:27:09 +0800 (CST)
Received: from linux.localdomain (unknown [113.200.148.30])
	by front1 (Coremail) with SMTP id qMiowJBxbcJ6KUNqIH24AA--.20759S3;
	Tue, 30 Jun 2026 10:27:07 +0800 (CST)
From: Tiezhu Yang <yangtiezhu@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>,
	Hengqi Chen <hengqi.chen@gmail.com>
Cc: loongarch@lists.linux.dev,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/4] LoongArch: BPF: Optimize redundant TCC loads in epilogue
Date: Tue, 30 Jun 2026 10:27:02 +0800
Message-ID: <20260630022705.11536-2-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20260630022705.11536-1-yangtiezhu@loongson.cn>
References: <20260630022705.11536-1-yangtiezhu@loongson.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJBxbcJ6KUNqIH24AA--.20759S3
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoW7trWDAF4fuF1UAr43WFy7CFX_yoW8CryxpF
	1qy3Z5CrWkXr18JFs2yFsFgr97Ga95WrW3WryUJrZ5Ar98ZFyfXFy8Kw1YkFWkX395Ar1S
	vrZ0yw1Y9F4DW3cCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
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
	x0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK
	8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I
	0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUcCD7UUUUU

The legacy epilogue implementation pops the tail call counter (TCC)
context via a redundant double-load pattern. It first decrements the
load_offset by 2 slots to fetch 'tcc_ptr', and then immediately bumps
it back up by 1 slot to load the original 'tcc' value into REG_TCC,
meaninglessly overwriting the register.

Optimize this sequence by adjusting the load_offset by only 1 slot.
This aligns the offset directly with the higher stack slot containing
the entry TCC counter (or caller state), allowing us to restore the
REG_TCC register safely with a single load.

This removes one redundant instruction from the epilogue hot path,
improves code readability, and ensures the correct TCC register
context is handed back cleanly upon normal return.

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 arch/loongarch/net/bpf_jit.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bpf_jit.c
index ad7e28375aa9..719dc4ab7a98 100644
--- a/arch/loongarch/net/bpf_jit.c
+++ b/arch/loongarch/net/bpf_jit.c
@@ -246,14 +246,8 @@ static void __build_epilogue(struct jit_ctx *ctx, bool is_tail_call)
 		emit_insn(ctx, ldd, REG_ARENA, LOONGARCH_GPR_SP, load_offset);
 	}
 
-	/*
-	 * When push into the stack, follow the order of tcc then tcc_ptr.
-	 * When pop from the stack, first pop tcc_ptr then followed by tcc.
-	 */
-	load_offset -= 2 * sizeof(long);
-	emit_insn(ctx, ldd, REG_TCC, LOONGARCH_GPR_SP, load_offset);
-
-	load_offset += sizeof(long);
+	/* Only restore the TCC state into REG_TCC from the higher slot */
+	load_offset -= sizeof(long);
 	emit_insn(ctx, ldd, REG_TCC, LOONGARCH_GPR_SP, load_offset);
 
 	emit_insn(ctx, addid, LOONGARCH_GPR_SP, LOONGARCH_GPR_SP, stack_adjust);
-- 
2.42.0

