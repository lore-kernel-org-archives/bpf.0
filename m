Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63B591DDC33;
	Mon,  6 Jul 2026 03:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783309157; cv=none; b=F4zxTJB29GPpTh8kJicbnNytkbBuLq8r9uAo6vYeuvNoTqF/muNJJjGlt5OMg2KhJSfom8wRIl44NeTTVcK5oy5qA7sAs7g1TAZ5Xo1XcbfxBLuba4kiAg20NNki7tn4aBlsKn0M8BmhiPtE+xlXWaai4e61WKYd6q1+4HtBsFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783309157; c=relaxed/simple;
	bh=wDfWyJSySFUPDT/NxSIVB2ine9Z5DIgAsWv7Vpn+7+o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sg8XlqlP/KyQlPvZHXCK2sY2Q1AiC7YORChWYrQ3u0UBCTAzn8/X7SVarVgekArTGTl3Wm7R83Z9PqEC6Oh8KNJeV9tAI4OeqqULr4Bfd70HUtISl7c7aKfiXM/m8ju4XCSADcmakrbXz4oM8s8Tw4oxMttjY4mZ17BDEFUUF8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8BxGOteI0tqVkQAAA--.1335S3;
	Mon, 06 Jul 2026 11:39:10 +0800 (CST)
Received: from linux.localdomain (unknown [113.200.148.30])
	by front1 (Coremail) with SMTP id qMiowJAx3cZbI0tq3LoBAA--.10774S3;
	Mon, 06 Jul 2026 11:39:10 +0800 (CST)
From: Tiezhu Yang <yangtiezhu@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>,
	Hengqi Chen <hengqi.chen@gmail.com>
Cc: loongarch@lists.linux.dev,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/4] LoongArch: BPF: Optimize redundant TCC loads in epilogue
Date: Mon,  6 Jul 2026 11:39:03 +0800
Message-ID: <20260706033906.1988-2-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20260706033906.1988-1-yangtiezhu@loongson.cn>
References: <20260706033906.1988-1-yangtiezhu@loongson.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJAx3cZbI0tq3LoBAA--.10774S3
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoW7trWDAF4fuF1UAr43WFy7CFX_yoW8CryxpF
	1qy3Z5CrWkXr18JFs2yFsFgr97Ga95WrW3WryUJrZ5Ar98ZFyfXFy8Kw1YkFWkX395Ar1S
	vrZ0yw1Y9F4DW3cCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUkFb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r126r13M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27w
	Aqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JF0_Jw1lYx0Ex4A2jsIE
	14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCF04k20xvY0x
	0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E
	7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcV
	C0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF
	04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7
	CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jea0PUUUUU=

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

