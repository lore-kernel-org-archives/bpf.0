Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37B8A37D13A;
	Tue, 26 May 2026 07:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779779010; cv=none; b=aInALG93mYw8G5Kdw0XTe6/4bdcQMprxcJzby+ITuaWR+FQX0RhzabYrw2WgjuO7Ip2ayaYkHaN4KzjA9syE0hLdaGJyOvTcnNGTgP+yiQbsR+gYDA36TJtbKH4VonGahp/ucwzYoW2EWE33QiageX5iFJ/C918Nilz4ZEi++rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779779010; c=relaxed/simple;
	bh=3/aMoYcSbz4SWqIv++wdbI56AwMz4acoXM0V+am/EKk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GynGBz81pqnREm89vC+g9udJVRglcZ9Qv5ftmmb2VT2Jvv7wBCvrc31VyI8dNHHkBy/nyXO5FOm5pd4eaxycrg+XEQ6Ah269TdTkgaphz2iA6Gqegub4hYMi3jzMDCXJSbVbuFxSzgKiPYwQog5u+lnZiefHohiOp94yhRMHU50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8BxzsC7RRVqeU0NAA--.14371S3;
	Tue, 26 May 2026 15:03:23 +0800 (CST)
Received: from linux.localdomain (unknown [113.200.148.30])
	by front1 (Coremail) with SMTP id qMiowJDxysG0RRVqq1+RAA--.11006S4;
	Tue, 26 May 2026 15:03:19 +0800 (CST)
From: Tiezhu Yang <yangtiezhu@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>,
	Hengqi Chen <hengqi.chen@gmail.com>
Cc: loongarch@lists.linux.dev,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] LoongArch: BPF: Fix off-by-one error in tail call
Date: Tue, 26 May 2026 15:03:16 +0800
Message-ID: <20260526070316.28228-3-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20260526070316.28228-1-yangtiezhu@loongson.cn>
References: <20260526070316.28228-1-yangtiezhu@loongson.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJDxysG0RRVqq1+RAA--.11006S4
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoWxCF47WrW7XF43GFWkKFykJFc_yoW5GF1xpr
	WkZr4kCrWkX34ayFs7Gan7Xr90yFZ5Gry7GF1FyrZ3Crn3Zry7Wa4jk34SgF98KrsYyry8
	Xr1v9w1rZ3WkAabCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUkFb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27w
	Aqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jw0_WrylYx0Ex4A2jsIE
	14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCF04k20xvY0x
	0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E
	7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcV
	C0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF
	04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7
	CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07j8CztUUUUU=

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
index 77261fc7867a..4c009a49d13f 100644
--- a/arch/loongarch/net/bpf_jit.c
+++ b/arch/loongarch/net/bpf_jit.c
@@ -325,12 +325,12 @@ static int emit_bpf_tail_call(struct jit_ctx *ctx, int insn)
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
@@ -343,6 +343,8 @@ static int emit_bpf_tail_call(struct jit_ctx *ctx, int insn)
 	if (emit_tailcall_jmp(ctx, BPF_JEQ, t2, LOONGARCH_GPR_ZERO, jmp_offset) < 0)
 		goto toofar;
 
+	emit_insn(ctx, std, t3, REG_TCC, 0);
+
 	/* goto *(prog->bpf_func + 4); */
 	off = offsetof(struct bpf_prog, bpf_func);
 	emit_insn(ctx, ldd, t3, t2, off);
-- 
2.42.0

