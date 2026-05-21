Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EB48385D7D;
	Thu, 21 May 2026 07:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779346900; cv=none; b=eCSQyoAKjlG95blr/UWE4XB/lZI/l4yVvTFTQ066foMSctOJK+cOJecvAGY4HPMiXYTQ3HXawTMA2Bm4wDdH3ojEQeBtivsm+M8BQCD9l/ODRW9NEHAXsk9tBL56N9tomJT7Olzc9YUtWTHIxzmgNPiMOPSouAaAvcv7mg8/FE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779346900; c=relaxed/simple;
	bh=JamPnZ4fTURhk5PIUUA/9HbA3LpAtyLYz5ibDAHlnks=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tGe37HtLkM2p431eJwmlB/SVJdUuu+ZFBXdICAEUH8fsunvxY7/VDDj1o3MBlzUvQkAJU8r+mBeS+LYKaaqkaOFSlgLlLG0NhCPlXMFA1t6glTrc3zCABCHVbXUtM8NWxvB9LPIVcxVN6knzs8hnUKDP5G7HD9T0Xvf6JsPNn70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8Dx8erNrQ5qTegLAA--.34714S3;
	Thu, 21 May 2026 15:01:33 +0800 (CST)
Received: from linux.localdomain (unknown [113.200.148.30])
	by front1 (Coremail) with SMTP id qMiowJDxaeDJrQ5qureKAA--.1831S3;
	Thu, 21 May 2026 15:01:32 +0800 (CST)
From: Tiezhu Yang <yangtiezhu@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>,
	Hengqi Chen <hengqi.chen@gmail.com>
Cc: loongarch@lists.linux.dev,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/3] LoongArch: BPF: Fix tail call prologue alignment
Date: Thu, 21 May 2026 15:01:26 +0800
Message-ID: <20260521070128.28086-2-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20260521070128.28086-1-yangtiezhu@loongson.cn>
References: <20260521070128.28086-1-yangtiezhu@loongson.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJDxaeDJrQ5qureKAA--.1831S3
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoW7uF1ruw1xAF48XF1UWr1xZwc_yoW8Cr4kpF
	Wxuws5GrWvgr1xCFn2y3y8Xr4ayFZ5GrW7Wr1UA3yYkwsxury0gF1fKFy3CF98Xr48Cr10
	qr1Fvw1UuF4kA3gCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUkYb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r126r13M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27w
	Aqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JF0_Jw1lYx0Ex4A2jsIE
	14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCF04k20xvY0x
	0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E
	7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcV
	C0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF
	04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7
	CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8SksDUUUUU==

Currently, the LoongArch BPF JIT assumes a fixed number of instructions to
skip when performing a tail call, but actually it does not account for the
difference between the main programs and the subprograms. The subprograms
do not initialize the Tail Call Count (TCC), leading to an incorrect jump
offset that skips functional instructions (like stack adjustment).

To fix this issue, add a NOP instruction in the subprogram prologue where
the TCC initialization would normally be. This ensures that both the main
programs and the subprograms have consistent prologue layouts, allowing
tail calls to always land on the correct instruction regardless of the
target program type.

Fixes: c0fcc955ff82 ("LoongArch: BPF: Fix the tailcall hierarchy")
Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 arch/loongarch/net/bpf_jit.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bpf_jit.c
index 24913dc7f4e8..aefe5fa1c584 100644
--- a/arch/loongarch/net/bpf_jit.c
+++ b/arch/loongarch/net/bpf_jit.c
@@ -149,12 +149,15 @@ static void build_prologue(struct jit_ctx *ctx)
 		emit_insn(ctx, nop);
 
 	/*
-	 * First instruction initializes the tail call count (TCC)
-	 * register to zero. On tail call we skip this instruction,
-	 * and the TCC is passed in REG_TCC from the caller.
+	 * Initialize or align the TCC register slot.
+	 * For main programs, TCC is zeroed. For subprograms, a nop is emitted
+	 * to keep the prologue size consistent, ensuring tail calls skip the
+	 * correct number of instructions.
 	 */
 	if (is_main_prog)
 		emit_insn(ctx, addid, REG_TCC, LOONGARCH_GPR_ZERO, 0);
+	else
+		emit_insn(ctx, nop);
 
 	emit_insn(ctx, addid, LOONGARCH_GPR_SP, LOONGARCH_GPR_SP, -stack_adjust);
 
-- 
2.42.0

