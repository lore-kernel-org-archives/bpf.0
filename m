Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C225395AE6;
	Thu, 21 May 2026 07:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779346902; cv=none; b=cGoo9TN4zh4FV+ooMTKZaD0UHmwEL10ETFwIjAUbxwVmf1nsRKp3rM1pU87SqYDXLW9V5lkDcvEynh4zWA3dDtXf6K2d5b4YWqhErku2az5TNUakQ5QSZvlZtL9eKZUqKs/D+mNR3ZLR5V4lw7qGHpz2cCvpwg72zXNGVaufVpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779346902; c=relaxed/simple;
	bh=PdbZ5ZHXuEILGZDBH/lspiS27yk0X5rxznk0JTFiOYo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L9JIEo4DFbgabqN2o9Z1tgvmQTaDd7r6aQ6+20szLTwtrLJJJc0mJH+dfQjsfnkl1oELy/xzex4vYlhLxdnPq9lozgLBKL90Uhn51CekI72OTvgt8I64NdV6xZmpjjkJhA5jJFlbXbHkSPu2ZaUF6yRFxgQWLwzqj41VAA54k1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8DxVejOrQ5qWOgLAA--.28859S3;
	Thu, 21 May 2026 15:01:34 +0800 (CST)
Received: from linux.localdomain (unknown [113.200.148.30])
	by front1 (Coremail) with SMTP id qMiowJDxaeDJrQ5qureKAA--.1831S5;
	Thu, 21 May 2026 15:01:33 +0800 (CST)
From: Tiezhu Yang <yangtiezhu@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>,
	Hengqi Chen <hengqi.chen@gmail.com>
Cc: loongarch@lists.linux.dev,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 3/3] LoongArch: BPF: Fix off-by-one error in tail call
Date: Thu, 21 May 2026 15:01:28 +0800
Message-ID: <20260521070128.28086-4-yangtiezhu@loongson.cn>
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
X-CM-TRANSID:qMiowJDxaeDJrQ5qureKAA--.1831S5
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoWxCF47WrW7XF43GFWkKFykJFc_yoW5GF1xpr
	WkZw4kCrWkX34ayFs7Can7XryYyFZ5Gry7GF1rArZ3Crn3Zry2ga4jk34SgF98KrsYyry8
	Xr1v934rZ3WkAabCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUkFb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27w
	Aqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jw0_WrylYx0Ex4A2jsIE
	14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCF04k20xvY0x
	0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E
	7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcV
	C0I7IYx2IY67AKxVW8JVW5JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF
	04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7
	CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07josjUUUUUU=

The current code updates the tail call counter (TCC) using a pre-increment
approach, it stores the incremented value back to memory before performing
any boundary or target validation checks.

This causes two major issues:
1. When a tail call fails because the target program is NULL, the TCC is
   incorrectly incremented and saved in memory anyway.
2. This dummy increment implicitly consumes one slot of the allowed tail
   call budget. As a result, the subsequent loop reaches the maximum limit
   prematurely, leading to a test failure where the actual loop count is
   32 instead of the expected 33.

Fix this by deferring the counter update. Change the branch condition to
BPF_JSGE (greater or equal) so that we check the boundary first. The TCC
is only incremented and stored back to memory after the boundary check
and the NULL-target check both pass.

Before:
  $ sudo ./test_progs -t tailcalls/tailcall_3
  ...
  test_tailcall_count:FAIL:tailcall count unexpected tailcall count: actual 32 != expected 33
  ...
  #465/3   tailcalls/tailcall_3:FAIL
  #465     tailcalls:FAIL

After:

  $ sudo ./test_progs -t tailcalls/tailcall_3
  #465/3   tailcalls/tailcall_3:OK
  #465     tailcalls:OK
  Summary: 1/1 PASSED, 0 SKIPPED, 0 FAILED

Fixes: c0fcc955ff82 ("LoongArch: BPF: Fix the tailcall hierarchy")
Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 arch/loongarch/net/bpf_jit.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bpf_jit.c
index a69ece7e62d5..811a6c193656 100644
--- a/arch/loongarch/net/bpf_jit.c
+++ b/arch/loongarch/net/bpf_jit.c
@@ -328,12 +328,12 @@ static int emit_bpf_tail_call(struct jit_ctx *ctx, int insn)
 	 */
 	emit_insn(ctx, ldd, REG_TCC, LOONGARCH_GPR_SP, tcc_ptr_off);
 	emit_insn(ctx, ldd, t3, REG_TCC, 0);
-	emit_insn(ctx, addid, t3, t3, 1);
-	emit_insn(ctx, std, t3, REG_TCC, 0);
 	emit_insn(ctx, addid, t2, LOONGARCH_GPR_ZERO, MAX_TAIL_CALL_CNT);
-	if (emit_tailcall_jmp(ctx, BPF_JSGT, t3, t2, jmp_offset) < 0)
+	if (emit_tailcall_jmp(ctx, BPF_JSGE, t3, t2, jmp_offset) < 0)
 		goto toofar;
 
+	emit_insn(ctx, addid, t3, t3, 1);
+
 	/*
 	 * prog = array->ptrs[index];
 	 * if (!prog)
@@ -346,6 +346,8 @@ static int emit_bpf_tail_call(struct jit_ctx *ctx, int insn)
 	if (emit_tailcall_jmp(ctx, BPF_JEQ, t2, LOONGARCH_GPR_ZERO, jmp_offset) < 0)
 		goto toofar;
 
+	emit_insn(ctx, std, t3, REG_TCC, 0);
+
 	/* goto *(prog->bpf_func + 4); */
 	off = offsetof(struct bpf_prog, bpf_func);
 	emit_insn(ctx, ldd, t3, t2, off);
-- 
2.42.0

